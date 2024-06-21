const mongoose = require("mongoose");
const { v4: uuidv4 } = require("uuid");

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
    type: Number,
    required: true,
  },
  end_time: {
    type: Number,
    required: true,
  },
  day: {
    // day of the month 1-31
    type: Number,
    required: true,
  },
  month: {
    // month 1-12
    type: Number,
    required: true,
  },
  year: {
    type: Number,
    required: true,
  },
});

const RecordsModel = mongoose.model("records", RecordsSchema);
module.exports = RecordsModel;
