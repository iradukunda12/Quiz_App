const express = require("express");
const { body, validationResult } = require("express-validator");
const Quiz = require("../model/quiz");
const User = require("../model/User");

const router = express.Router();

// Validation middleware for submitting quiz answers
const validateSubmitAnswers = [
  body("answers")
    .isArray()
    .withMessage("Answers must be an array")
    .custom((answers) => {
      const quizQuestionsLength = Quiz.questions ? Quiz.questions.length : 0;

      if (!Array.isArray(answers) || answers.length !== quizQuestionsLength) {
        throw new Error(
          `Answers must be an array with ${quizQuestionsLength} elements`
        );
      }

      return true;
    }),
];

// Validation middleware for creating or updating a quiz
const validateQuiz = [
  body("title").notEmpty().withMessage("Title cannot be empty"),
  body("questions").isArray().withMessage("Questions must be an array"),
  body("questions.*.question")
    .notEmpty()
    .withMessage("Question cannot be empty"),
  body("questions.*.options").isArray().withMessage("Options must be an array"),
  body("questions.*.correctOption")
    .isInt({ min: 0 })
    .withMessage("Correct option must be a valid index"),
];

// Error handling middleware
const handleValidationErrors = (req, res, next) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  next();
};

// Create a quiz
router.post(
  "/quizzes",
  validateQuiz,
  handleValidationErrors,
  async (req, res) => {
    try {
      const quiz = new Quiz(req.body);
      await quiz.save();
      console.log("Quiz saved successfully:", quiz);
      res.status(201).json(quiz);
    } catch (error) {
      console.error(error);
      res.status(500).json({ error: "Internal Server Error" });
    }
  }
);

// Get all quizzes
router.get("/quizzes", async (req, res) => {
  try {
    const quizzes = await Quiz.find();
    res.json(quizzes);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

// Update a quiz
router.put(
  "/quizzes/:id",
  validateQuiz,
  handleValidationErrors,
  async (req, res) => {
    try {
      const quiz = await Quiz.findByIdAndUpdate(req.params.id, req.body, {
        new: true,
        runValidators: true,
      });

      if (!quiz) {
        return res.status(404).json({ error: "Quiz not found" });
      }

      res.json(quiz);
    } catch (error) {
      console.error(error);
      res.status(500).json({ error: "Internal Server Error" });
    }
  }
);

// Delete a quiz
router.delete("/quizzes/:id", async (req, res) => {
  try {
    const quiz = await Quiz.findByIdAndDelete(req.params.id);

    if (!quiz) {
      return res.status(404).json({ error: "Quiz not found" });
    }

    res.json({ message: "Quiz deleted successfully" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

// Submit Answers (Implicit Start)
router.post(
  "/quizzes/:quizId/submit",
  validateSubmitAnswers,
  handleValidationErrors,
  async (req, res) => {
    try {
      const { quizId } = req.params;
      const { answers } = req.body;
      const userId = req.user.id; // Assuming you have middleware to extract user from token

      // Check if the quiz session is already started for the user
      const user = await User.findById(userId);

      if (
        !user.quizProgress.some((progress) => progress.quizId.equals(quizId))
      ) {
        // If the quiz session is not started, mark it as started
        user.quizProgress.push({ quizId, progress: 0 });
        await user.save();
      }

      // Process and save the user's answers
      const quiz = await Quiz.findById(quizId);

      if (!quiz) {
        return res.status(404).json({ error: "Quiz not found" });
      }

      const userAnswers = answers.map((answer, index) => ({
        question: quiz.questions[index].question,
        selectedOption: answer,
        correctOption: quiz.questions[index].correctOption,
      }));

      // Check if user selected more than one answer for any question
      if (userAnswers.some((ans) => Array.isArray(ans.selectedOption))) {
        return res
          .status(400)
          .json({ error: "Please choose only one answer per question." });
      }

      // Calculate marks (customize based on your criteria)
      const marks = calculateMarks(quiz, userAnswers);

      // Update user's quiz progress
      const quizProgress = user.quizProgress.find((progress) =>
        progress.quizId.equals(quizId)
      );
      quizProgress.progress = marks; // Assuming marks as progress for simplicity
      await user.save();

      // Respond with confirmation
      res.json({
        message: "Quiz session started or answers submitted successfully.",
        marks,
      });
    } catch (error) {
      console.error(error);
      res.status(500).json({ error: "Internal Server Error" });
    }
  }
);

// Update quiz progress and marks for a user
router.post("/users/:userId/quiz-progress", async (req, res) => {
  try {
    const userId = req.params.userId;
    const { quizId, progress, marks } = req.body;

    const user = await User.findById(userId);

    if (!user) {
      return res.status(404).json({ error: "User not found" });
    }

    // Assuming you have a method to update quiz progress and marks in your User model
    await user.updateQuizProgress(quizId, progress, marks);

    res.json({ message: "Quiz progress and marks updated successfully" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

// ... other code ...

// Function to calculate marks (customize based on your criteria)
function calculateMarks(quiz, userAnswers) {
  let correctAnswers = 0;

  userAnswers.forEach((answer, index) => {
    if (answer.selectedOption === quiz.questions[index].correctOption) {
      correctAnswers++;
    }
  });

  // Customize the calculation based on your criteria
  const totalQuestions = quiz.questions.length;
  const marks = (correctAnswers / totalQuestions) * 100;

  return marks;
}

module.exports = router;
