const ProductController = require('../controllers/product_controller');

const ProductRoutes = require('express').Router();

ProductRoutes.get('/', ProductController.fetchAllProduct);
ProductRoutes.get('/category/:id', ProductController.fetchProductByCategory);
ProductRoutes.post('/', ProductController.createProduct);

module.exports = ProductRoutes;