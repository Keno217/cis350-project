const mongoose = require("mongoose");

const app = require("./app");

//load .env file
require("dotenv").config();

if (!process.env.DATABASE_URL) {
  throw new Error("DATABASE_URL must be set");
}

mongoose
  .connect(process.env.DATABASE_URL)
  .then(() => {
    console.log("Connected to MongoDB");
  })
  .catch((err) => {
    console.error("Failed to connect to MongoDB:", err);
  });

const PORT = process.env.PORT || 3001;
app.listen(PORT, () => {
  console.log("Server is running...\nport: " + PORT);
});
