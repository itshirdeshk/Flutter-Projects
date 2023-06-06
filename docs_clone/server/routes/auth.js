const express = require('express');
const jwt = require('jsonwebtoken');
const User = require('../models/user');
const auth = require('../middlewares/auth');

const authRouter = express.Router();

authRouter.post('/api/signup', async (req, res) => {
    try {
        const { name, email, profilePic } = req.body;

        // First check email is already exists or not?
        // Because we have to minimize calls to the database

        // Now how to check if email already exists?
        let user = await User.findOne({ email });

        if (!user) {
            user = new User({
                // name: name,
                // email: email,
                // profilePic: profilePic,
                name,
                email,
                profilePic,
            });

            user = await user.save();
        }

        const token = jwt.sign({id: user._id}, "passwordKey");

        res.json({ user, token });
    } catch (e) {
        res.status(500).json({error: e.message});
    }
});

authRouter.get("/", auth, async (req, res) => {
    const user = await User.findById(req.user);
    res.json({user, token: req.token});
});

module.exports = authRouter;