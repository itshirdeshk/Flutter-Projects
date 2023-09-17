const OrderModel = require('../models/order_model');
const CartModel = require('../models/cart_model');
const razorpay = require('../services/razorpay');

const OrderController = {
    createOrder: async function (req, res) {
        try {
            const { user, items, status, totalAmount } = req.body;

            // Create order in razorpay
            const razorpayOrder = await razorpay.orders.create({
                amount: totalAmount * 100,
                currency: 'INR', 
            });

            const newOrder = new OrderModel({
                user: user,
                items: items,
                status: status,
                totalAmount: totalAmount,
                razorpayOrderId: razorpayOrder.id,
            });

            await newOrder.save();

            // Update the cart
            await CartModel.findOneAndUpdate(
                { user: user._id },
                {
                    items: []
                }
            )

            return res.json({
                success: true, data: newOrder, message: 'Order Placed!'
            });
        } catch (error) {
            return res.json({
                success: false,
                message: error
            });
        }
    },

    fetchOrdersForUser: async function (req, res) {
        try {
            const userId = req.params.userId;
            const foundOrder = await OrderModel.find({ "user.id": userId }).sort({ createdOn: -1 });

            return res.json({
                success: true, data: foundOrder, message: 'Order found!'
            });
        } catch (error) {
            return res.json({
                success: false,
                message: error
            });
        } 
    },

    updateOrderStatus: async function (req, res) {
        try {
            const { orderId, status, razorpayPaymentId, razorpaySignature  } = req.body;

            const updatedOrder = await OrderModel.findOneAndUpdate({
                _id: orderId
            },
                {
                    status: status,
                    razorpayPaymentId: razorpayPaymentId,
                    razorpaySignature: razorpaySignature,
                }, {
                new: true
            });

            return res.json({
                success: true, data: updatedOrder, message: 'Status Updated'
            });
        } catch (error) {
            return res.json({
                success: false,
                message: error
            });
        }
    }
}

module.exports = OrderController;