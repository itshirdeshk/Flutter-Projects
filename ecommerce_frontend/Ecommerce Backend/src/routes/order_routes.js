const OrderController = require('../controllers/order_controller');

const OrderRoutes = require('express').Router();

OrderRoutes.get('/:userId', OrderController.fetchOrdersForUser);
OrderRoutes.post('/', OrderController.createOrder);
OrderRoutes.put('/updateStatus', OrderController.updateOrderStatus);

module.exports = OrderRoutes;