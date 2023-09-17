const UserModel = require('../models/user_model');
const bcrypt = require('bcrypt');

const UserController = {
    createAccount: async function (req, res) {
        try {
            const UserData = req.body;
            const newUser = new UserModel(UserData);
            await newUser.save();

            return res.json({
                success: true, data: newUser, message: 'User Created!'
            });

        } catch (error) {
            return res.json({
                success: false,
                message: error
            });
        }
    },

    signIn: async function (req, res) {
        try {
            const { email, password } = req.body;
            const foundUser = await UserModel.findOne({ email: email });

            if (!foundUser) {
                return res.json({
                    success: false,
                    message: 'User not found!'
                });
            }

            const passwordMatch = bcrypt.compareSync(password, foundUser.password);

            if (!passwordMatch) {
                return res.json({
                    success: false,
                    message: 'Incorrect Password'
                });
            }

            return res.json({
                success: true,
                data: foundUser,
                message: 'User found!'
            });

        } catch (error) {
            return res.json({
                success: false,
                message: error
            });
        }
    },


    updateUser: async function (req, res) {
        try {
            const userId = req.params.id;
            const updateData = req.body;

            const updatedUser = await UserModel.findOneAndUpdate({
                _id: userId
            },
                {
                    updateData
                }, { new: true })

            if (!updatedUser) {
                throw "User not found!";
            }

            return res.json({ success: true, data: updatedData, message: "User Updated!" });
        } catch (error) {
            return res.json({
                success: false,
                message: error
            });
        }
    }
}

module.exports = UserController;