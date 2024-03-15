const mongoose = require("mongoose");

const quizSchema = new mongoose.Schema({
  _id: {
    type: Number,
    required: true,
    // Ensure uniqueness
  },

  title: {
    type: String,
    required: true,
  },
  questions: [
    {
      question: {
        type: String,
        required: true,
      },
      options: [
        {
          type: String,
          required: true,
        },
      ],
      correctOption: {
        type: Number,
        required: true,
      },
    },
  ],
});

const Quiz = mongoose.model("Quiz", quizSchema);

module.exports = Quiz;
