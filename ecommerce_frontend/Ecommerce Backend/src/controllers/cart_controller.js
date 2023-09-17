const CartModel = require('../models/cart_model');

const CartController = {
    getCartForUser: async function (req, res) {
        try {
            const user = req.params.user;
            const foundCart = await CartModel.findOne({ user: user }).populate("items.product");

            if (!foundCart) {
                return res.json({
                    success: true,
                    data: []
                });
            }

            return res.json({
                success: true,
                data: foundCart.items
            });
        } catch (error) {
            return res.json({
                success: false,
                message: error
            });
        }
    },

    addToCart: async function (req, res) {
        try {
            const { product, user, quantity } = req.body;
            const foundCart = await CartModel.findOne({ user: user });

            if (!foundCart) {
                const newCart = new CartModel({ user: user });
                newCart.items.push({
                    product: product, quantity: quantity
                });

                await newCart.save();

                return res.json({
                    success: true,
                    data: newCart,
                    message: 'Product added to Cart!'
                });
            }

            // Deleting the item if it is already exists
            await CartModel.findOneAndUpdate({
                user: user, "items.product": product
            },
                {
                    $pull: { items: { product: product } }
                }, { new: true });

            // if cart already exists
            const updatedCart = await CartModel.findOneAndUpdate({
                user: user
            },
                {
                    $push: {
                        items: {
                            product: product, quantity: quantity
                        }
                    }
                },
                {
                    new: true
                }
            ).populate( "items.product");

            return res.json({
                success: true,
                data: updatedCart.items,
                message: 'Product added to Cart!'
            });
        } catch (error) {
            return res.json({
                success: false,
                message: error
            });
        }
    },

    removeFromCart: async function (req, res) {
        try {
            const { user, product } = req.body;
            const updatedCart = await CartModel.findOneAndUpdate({
                user: user
            },
                {
                    $pull: {
                        items: {
                            product: product
                        }
                    }
                },
                {
                    new: true
                }
            ).populate( "items.product");

            return res.json({
                success: true,
                data: updatedCart.items,
                message: 'Product removed from Cart!'
            });

        } catch (error) {
            return res.json({
                success: false,
                message: error
            });
        }
    },
}

module.exports = CartController;