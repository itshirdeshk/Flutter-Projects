const CategoryRoute = require('express').Router();
const CategoryController = require('../controllers/category_controller');

CategoryRoute.get('/', CategoryController.fetchAllCategory);
CategoryRoute.get('/:id', CategoryController.fetchCategoryById);
CategoryRoute.post('/', CategoryController.createCategory);

module.exports = CategoryRoute