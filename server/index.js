const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

//load .env file
require('dotenv').config();

const app = express();
const UsersModel = require('./models/Users');
const RecordsModel = require('./models/Records');

app.use(express.json());
app.use(cors());


if (!process.env.DATABASE_URL) {
    throw new Error('DATABASE_URL must be set');
}

mongoose.connect(process.env.DATABASE_URL)
    .then(() => {
        console.log('Connected to MongoDB');
    })
    .catch(err => {
        console.error('Failed to connect to MongoDB:', err);
    });

const PORT = process.env.PORT || 3001;
app.listen(PORT, () => {
    console.log('Server is running...\nport: ' + PORT);
});

app.get('/getUser', (req, res) => {
    const user = req.body;
    UsersModel.find({ name: user.name }).then(data => {
        res.json(data);
    });
});


app.post('/loginUser', async (req, res) => {
    const { user, pass } = req.body;
    const client = await UsersModel.findOne({ username: user });

    if (!client) {
        return res.status(404).json({ message: 'User not found' });
    }

    const isPasswordValid = await bcrypt.compare(pass, client.password);

    if (!isPasswordValid) {
        return res.status(401).json({ message: 'Invalid credentials.' });
    }

    return res.status(200).json({ message: 'Login successful.' });
});

app.post('/createUser', async (req, res) => {
    const { user, pass } = req.body;

    const existingUser = await UsersModel.findOne({ username: user });

    if (existingUser) {
        return res.status(409).json({ error: 'User already exists.' });
    }

    const salt = await bcrypt.genSalt(15);
    const hashedPassword = await bcrypt.hash(pass, salt);

    const newUser = new UsersModel({ username: user, password: hashedPassword });
    await newUser.save();

    return res.status(201).json({ message: 'User created successfully.' });
});


app.get('/getRecords', (req, res) => {
    const user = req.body;
    RecordsModel.find({ user: user.user }).then(data => {
        res.json(data);
    });
});

app.post('/createRecord', async (req, res) => {
    var record = req.body;
    var today = new Date();
    record.day = today.getDate();
    record.month = today.getMonth() + 1; // Date uses 0-indexed months so we add 1
    record.year = today.getFullYear();

    // delete record(s) for the same day
    await RecordsModel.deleteMany({user: record.user, day: record.day, month: record.month, year: record.year});

    const newRecord = new RecordsModel(record);
    await newRecord.save();
    res.json(record);
});

app.post('/getSleepStats', (req, res) => {
    const user = req.body;

    RecordsModel.find({ user: user.user }).then(data => {
        var dateMap = {};
        var totalSleepDuration = 0;
        data.forEach(record => {
            var start = new Date(record.start_time);
            var end = new Date(record.end_time);
            var date = start.toLocaleDateString();
            var duration = end - start; 

            dateMap[date] = (dateMap[date] || 0) + (end - start);
            totalSleepDuration += duration;
        });

        var numDays = Object.keys(dateMap).length;
        var averageSleepDuration = totalSleepDuration / numDays;

        res.json({
            dates: dateMap,
            average: averageSleepDuration,
        });
    });
})