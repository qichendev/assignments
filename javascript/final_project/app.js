const express = require("express");
const path = require("path");

const connectToDatabase = require("./config/db");
const userRoutes = require("./routes/userRoutes");

const app = express();
const clientBuildPath = path.join(__dirname, "client", "dist");

connectToDatabase().catch((error) => {
  console.error("Initial database connection error:", error.message);
});

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use("/api/users", userRoutes);
app.use(express.static(clientBuildPath));

app.get("/", (req, res) => {
  res.sendFile(path.join(clientBuildPath, "index.html"));
});

app.get(/^\/(?!api).*/, (req, res) => {
  res.sendFile(path.join(clientBuildPath, "index.html"));
});

app.use((req, res) => {
  res.status(404).json({
    message: "API route not found."
  });
});

app.use((err, req, res, next) => {
  console.error(err);

  res.status(err.status || 500).json({
    message: err.message || "An unexpected error occurred."
  });
});

module.exports = app;
