const express = require("express");
const path = require("path");

const connectToDatabase = require("./config/db");
const userRoutes = require("./routes/userRoutes");

const app = express();

connectToDatabase().catch((error) => {
  console.error("Initial database connection error:", error.message);
});

app.set("view engine", "pug");
app.set("views", path.join(__dirname, "views"));

app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, "public")));

app.use((req, res, next) => {
  res.locals.currentPath = req.path;
  next();
});

app.get("/", (req, res) => {
  res.redirect("/users");
});

app.use("/", userRoutes);

app.use((req, res) => {
  res.status(404).render("users/not-found", {
    title: "Page Not Found"
  });
});

app.use((err, req, res, next) => {
  console.error(err);

  res.status(err.status || 500).render("users/error", {
    title: "Application Error",
    errorMessage: err.message || "An unexpected error occurred."
  });
});

module.exports = app;
