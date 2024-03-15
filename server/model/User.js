const { ValidatorsImpl } = require("express-validator/src/chain");
const mongoose = require("mongoose");

const quizProgressSchema = new mongoose.Schema({
  quizId: { type: mongoose.Schema.Types.ObjectId, ref: "Quiz", required: true },
  progress: Number,
  marks: Number,
});

const userSchema = new mongoose.Schema({
  studentId: { type: String, required: true },
  email: {
    type: String,
    unique: true,
    required: true,
  },
  password: { type: String, required: true },
  quizProgress: [quizProgressSchema],
});

// Method to update quiz progress and marks
userSchema.methods.updateQuizProgress = async function (
  quizId,
  progress,
  marks
) {
  const existingProgress = this.quizProgress.find(
    (entry) => entry.quizId.toString() === quizId.toString()
  );

  if (existingProgress) {
    existingProgress.progress = progress;
    existingProgress.marks = marks;
  } else {
    this.quizProgress.push({ quizId, progress, marks });
  }

  return this.save();
};

const User = mongoose.model("User", userSchema);

module.exports = User;
