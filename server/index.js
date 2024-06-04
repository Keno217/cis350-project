const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

const app = express();
const UsersModel = require('./models/Users');
const RecordsModel = require('./models/Records');

app.use(express.json());
app.use(cors());


if (!process.env.DATABASE_URL) {
    throw new Error('DATABASE_URL must be set');
}

mongoose.connect(process.env.DATABASE_URL)

app.listen(3001, () => {
    console.log('Server is running...');
});

app.get('/getUser', (req, res) => {
    const user = req.body;
    UsersModel.find({name: user.name}).then ( data => {
        res.json(data);
    });
});

app.post('/createUser', async (req, res) => {
    const user = req.body;
    const newUser = new UsersModel(user);
    await newUser.save();
    res.json(user);
});

app.get('/getRecords', (req, res) => {
    const user = req.body;
    RecordsModel.find({user: user.user}).then ( data => {
        res.json(data);
    });
});

app.post('/createRecord', async (req, res) => {
    const record = req.body;
    const newRecord = new RecordsModel(record);
    await newRecord.save();
    res.json(record);
});