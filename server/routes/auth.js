const express = require("express");
const bcrypt = require("bcrypt");
const User = require("../model/User"); // Adjust the path accordingly

const router = express.Router();

router.post("api/register", async (req, res) => {
  // try {
  //   const { studentId, email, password } = req.body;
  //   const hashedPassword = await bcrypt.hash(password, 8);
  //   const user = new User({ email, password: hashedPassword, studentId });
  //   await user.save();
  //   res.status(201).send("User registered successfully");
  // } catch (error) {
  //   console.error(error);
  //   res.status(500).send("Internal Server Error");
  // }

  try {
    const { studentId, email, password } = req.body;
    const hashedPassword = await bcrypt.hash(password, 8);
    const user = new User({ email, password: hashedPassword, studentId });

    // Save the user and handle any validation errors
    await user
      .save()
      .then(() => res.status(201).send("User registered successfully"))
      .catch((validationError) => {
        if (validationError.name === "ValidationError") {
          console.error(validationError.errors);
          res.status(400).json({ error: validationError.message });
        } else {
          console.error(validationError);
          res.status(500).send("Internal Server Error");
        }
      });
  } catch (error) {
    console.error(error);
    res.status(500).send("Internal Server Error");
  }
});

router.post("api/login", async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await User.findOne({ email });

    if (user && (await bcrypt.compare(password, user.password))) {
      req.session.userId = user.studentId;
      res.status(200).send("Login successful");
    } else {
      res.status(401).send("Invalid email or password");
    }

    const token = jwt.sign({ id: user._id }, "passwordKey");
    res.json({ token, ...user._doc });
  } catch (error) {
    console.error(error);
    res.status(500).send("Internal Server Error");
  }
});

module.exports = router;
