/*
  Full Stack JavaScript - Final MERN Assignment
  Student Name: Qi Chen
  CNumber: c0944666
*/

require("dotenv").config();

const app = require("./app");

const port = Number(process.env.PORT) || 3000;
const host = process.env.HOST || "127.0.0.1";

app.listen(port, host, () => {
  console.log(`Server listening on http://${host}:${port}`);
});
