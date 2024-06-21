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
