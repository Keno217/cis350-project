const mongoose = require("mongoose")
const { v4: uuidv4 } = require("uuid")

const RecordsSchema = new mongoose.Schema({
    id: {
        type: String,
        unique: true,
        default: uuidv4, // generate a new UUID as default value
    },
    user: {
        type: String,
        required: true,
    },
    start_time: {
        type: String,
        required: true,
    },
    end_time: {
        type: String,
        required: true,
    },
});

const RecordsModel = mongoose.model("records", RecordsSchema);
module.exports = RecordsModel;