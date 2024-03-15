const express = require("express");
const bodyParser = require("body-parser");
const session = require("express-session");
const authRoutes = require("./routes/auth");
const mongoose = require("mongoose");
const Quiz = require("./model/quiz");
const quizRoutes = require("./routes/quizRoutes");
const errorHandler = require("./middlewares/errorHandler");

mongoose.connect(
  "mongodb+srv://iradukundakvn8:Iradukunda123@cluster0.mz7qmcm.mongodb.net/Quiz_App",
  {
    // useNewUrlParser: true,
    // useUnifiedTopology: true,
    serverSelectionTimeoutMS: 5000, // Set the server selection timeout
  }
);

const db = mongoose.connection;

db.on("error", (err) => {
  console.error("MongoDB connection error:", err);
});

db.once("open", () => {
  console.log("Connected to MongoDB");
});

const app = express();

app.use(bodyParser.json());
app.use(express.json());
app.use(
  session({
    secret: "your-secret-key",
    resave: false,
    saveUninitialized: true,
  })
);

app.use("/auth", authRoutes);

// Use Quiz routes
app.use("/questions", quizRoutes);

// Use error handler middleware
app.use(errorHandler);

// Expose an endpoint to get the port
app.get("/getPort", (req, res) => {
  const PORT = process.env.PORT || 4000;
  res.json({ port: PORT });
});
// Other middleware and routes can be added here

const PORT = process.env.PORT || 4000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
