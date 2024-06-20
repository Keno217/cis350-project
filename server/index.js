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
    await RecordsModel.deleteMany({ user: record.user, day: record.day, month: record.month, year: record.year });

    const newRecord = new RecordsModel(record);
    await newRecord.save();
    res.json(record);
});

app.post('/getSleepStats', (req, res) => {
    const user = req.body;

    RecordsModel.find({ user: user.user })
        .sort({ date: -1 })
        .limit(7)
        .then(data => {
            let weeklyDuration = data.map(record => {
                const duration = Math.abs(record.end_time - record.start_time);
                duration = duration / 60;
                return duration;
            });

            RecordsModel.find({ user: user.user }).then(data => {
                let formattedData = data.map(record => {
                    // calculate duration and format date
                    const duration = Math.abs(record.end_time - record.start_time)
                    const date = `${record.year}-${record.month}-${record.day}`;

                    return {
                        id: record.id,
                        user: record.user,
                        startTime: record.start_time,
                        endTime: record.end_time,
                        date: date,
                        duration: duration
                    };
                });

                res.status(200).json({
                    success: true,
                    records: formattedData,
                    duration: weeklyDuration
                });
            })
                .catch(err => {
                    console.error('Error:', err);
                    res.status(500).json({ success: false, error: 'Failed to fetch sleep records' });
                })
        });
})