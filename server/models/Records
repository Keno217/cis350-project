const mongoose = require("mongoose")
const RecordsSchema = new mongoose.Schema({
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