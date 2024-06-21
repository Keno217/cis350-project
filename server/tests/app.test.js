const mongoose = require("mongoose");
const request = require("supertest");

const app = require("../app");

require("dotenv").config();

beforeEach(async () => {
  await mongoose.connect(process.env.DATABASE_URL);
});

afterEach(async () => {
  await mongoose.connection.close();
});

describe("POST /loginUser", () => {
  it("should login as user", async () => {
    const response = await request(app).post("/loginUser").send({
      user: "server test",
      pass: "server test",
    });

    expect(response.statusCode).toBe(200);
  });
});

describe("POST /loginUser with invalid credentials", () => {
  it("should fail to login", async () => {
    const response = await request(app).post("/loginUser").send({
      user: "server test",
      pass: "something else",
    });

    expect(response.statusCode).toBe(401);
  });
});

describe("POST /createUser with an existing user", () => {
  it("should fail to create a new user", async () => {
    const response = await request(app).post("/createUser").send({
      user: "server test",
      pass: "server test",
    });

    expect(response.statusCode).toBe(409);
  });
});

describe("GET /getRecords", () => {
  it("should return the records for a user", async () => {
    const response = await request(app).get("/getRecords").send({
      user: "server test",
    });

    expect(response.statusCode).toBe(200);
  });
});

describe("POST /createRecord", () => {
  it("should create a record for the current day", async () => {
    const response = await request(app).post("/createRecord").send({
      user: "server test",
      start_time: "0",
      end_time: "300",
    });

    expect(response.statusCode).toBe(200);
  });
});

describe("POST /getBarGraph", () => {
  it("should get the bar graph for the past week", async () => {
    const response = await request(app).post("/getBarGraph").send({
      user: "server test",
    });

    expect(response.statusCode).toBe(200);
  });
});

describe("POST /getAverages", () => {
  it("should get average sleep duration for the user", async () => {
    const response = await request(app).post("/getAverages").send({
      user: "server test",
    });

    expect(response.statusCode).toBe(200);
  });
});

describe("POST /getSleepStats", () => {
  it("should get the user's sleep stats", async () => {
    const response = await request(app).post("/getSleepStats").send({
      user: "server test",
    });

    expect(response.statusCode).toBe(200);
  });
});