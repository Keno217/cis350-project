const express = require("express");
const cors = require("cors");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

const app = express();
const UsersModel = require("./models/Users");
const RecordsModel = require("./models/Records");

app.use(express.json());
app.use(cors());

module.exports = app;

// routes
app.post("/loginUser", async (req, res) => {
  const { user, pass } = req.body;
  const client = await UsersModel.findOne({ username: user });

  if (!client) {
    return res.status(404).json({ message: "User not found" });
  }

  const isPasswordValid = await bcrypt.compare(pass, client.password); // compare hashed passwords

  if (!isPasswordValid) {
    return res.status(401).json({ message: "Invalid credentials." });
  }

  return res.status(200).json({ message: "Login successful." });
});

app.post("/createUser", async (req, res) => {
  const { user, pass } = req.body;

  const existingUser = await UsersModel.findOne({ username: user });

  if (existingUser) {
    return res.status(409).json({ error: "User already exists." });
  }

  const salt = await bcrypt.genSalt(15); // hash rng key
  const hashedPassword = await bcrypt.hash(pass, salt); // hash password again once received over the net

  const newUser = new UsersModel({ username: user, password: hashedPassword });
  await newUser.save();

  return res.status(201).json({ message: "User created successfully." });
});

app.get("/getRecords", (req, res) => {
  const user = req.body;
  RecordsModel.find({ user: user.user }).then((data) => {
    res.json(data);
  });
});

app.post("/createRecord", async (req, res) => {
  var record = req.body;
  var today = new Date();
  record.day = today.getDate();
  record.month = today.getMonth() + 1; // Date uses 0-indexed months so we add 1
  record.year = today.getFullYear();

  // delete record(s) for the same day
  await RecordsModel.deleteMany({
    user: record.user,
    day: record.day,
    month: record.month,
    year: record.year,
  });

  const newRecord = new RecordsModel(record);
  await newRecord.save();
  res.json(record);
});

app.post("/getBarGraph", (req, res) => {
  const user = req.body;

  const weekAgo = new Date();
  weekAgo.setDate(weekAgo.getDate() - 7);

  const startOfWeek = new Date(weekAgo);
  startOfWeek.setDate(startOfWeek.getDate() - startOfWeek.getDay()); // get start of week (sunday is start of week for our app)

  const endOfWeek = new Date(weekAgo);
  endOfWeek.setDate(endOfWeek.getDate() + (6 - endOfWeek.getDay())); // get end of week (saturday) for our app

  RecordsModel.find({
    user: user.user,
    day: { $gte: startOfWeek.getDate(), $lte: endOfWeek.getDate() }, // look for record models starting from start of week to end of week
  })
    .sort({ year: -1, month: -1, day: -1 })
    .then((data) => {
      let weeklyDuration = new Array(7).fill(0.0); // array mimics the week index 0 - 6 (sunday - saturday)

      data.forEach((record) => {
        const date = new Date(record.year, record.month - 1, record.day);
        const dayIndex = date.getDay(); // sunday (0) - saturday (6)
        const duration = Math.abs(record.end_time - record.start_time) / 60; // the amount of time of slept for that sleep record
        weeklyDuration[dayIndex] = duration;
      });

      res.status(200).json({ success: true, durations: weeklyDuration });
    })
    .catch((err) => {
      console.error("Error:", err);
      res
        .status(500)
        .json({ success: false, error: "Failed to fetch weekly data" });
    });
});

app.post("/getAverages", (req, res) => {
  user = req.body;

  RecordsModel.find({ user: user.user })
    .then((data) => {
      let averageDuration = 0;
      let totalDuration = 0;
      let qtyRestNeeded = 0; // quantity of rest needed. Each day you should sleep 8 hours. If you have three records this value should be 24.
      let recordCount = data.length;

      data.forEach((record) => {
        const duration = Math.abs(record.end_time - record.start_time);
        totalDuration += duration;
      });

      if (recordCount > 0) {
        averageDuration = totalDuration / recordCount;
        qtyRestNeeded = 8 * 60 * recordCount;
      }

      // convert into HH:MM format
      const averageDurationHHMM = convert(Math.round(averageDuration)); 
      const qtyRestNeededHHMM = convert(Math.round(qtyRestNeeded));
      const totalDurationHHMM = convert(Math.round(totalDuration));

      res.status(200).json({
        averageDuration: averageDurationHHMM,
        totalRest: totalDurationHHMM,
        qtyRestNeeded: qtyRestNeededHHMM,
      });
    })
    .catch((err) => {
      console.error("Error fetching records:", err);
      res.status(500).json({ error: "Error fetching records" });
    });
});

app.post("/getSleepStats", (req, res) => {
  user = req.body;
  RecordsModel.find({ user: user.user })
    .sort({ year: -1, month: -1, day: -1 })
    .then((data) => {
      let formattedData = data.map((record) => {
        // calculate duration and format date
        duration = Math.abs(record.end_time - record.start_time);
        const date = `${record.year}-${record.month}-${record.day}`;

        // convert into HH:MM format
        startTime = convert(record.start_time);
        endTime = convert(record.end_time);
        duration = convert(duration);

        return {
          id: record.id,
          user: record.user,
          startTime: startTime,
          endTime: endTime,
          date: date,
          duration: duration,
        };
      });

      res.status(200).json({
        success: true,
        records: formattedData,
      });
    })
    .catch((err) => {
      console.error("Error:", err);
      res
        .status(500)
        .json({ success: false, error: "Failed to fetch sleep records" });
    });
});





// function(s)
function convert(minutes) { // convert minutes into HH:MM format
  if (typeof minutes !== "number" || isNaN(minutes)) {
    return "00:00"; // Default value if minutes is not a valid number
  }

  const hours = Math.floor(minutes / 60);
  const mins = minutes % 60;

  const hoursStr = hours < 10 ? "0" + hours : hours.toString();
  const minsStr = mins < 10 ? "0" + mins : mins.toString();

  return hoursStr + ":" + minsStr;
}
