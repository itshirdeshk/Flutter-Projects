const CategoryModel = require('../models/category_model');

const CategoryController = {

    createCategory: async function(req, res){
        try {
            const CategoryData = req.body;
            const newCategory = new CategoryModel(CategoryData);
            await newCategory.save();

            return res.json({
                success : true,
                data: newCategory,
                message : 'Category Created!'
            });            
        } catch (error) {
            return res.json({
                success : false,
                message : error
            });
        }
    },

    fetchAllCategory: async function(req, res){
        try {
            
            const categories = await CategoryModel.find();

            return res.json({
                success : true,
                data: categories,
                
            });    


        } catch (error) {
            return res.json({
                success : false,
                message : error
            });
        }
    },

    fetchCategoryById: async function(req, res){
        try {
            const id = req.params.id;
            const category = await CategoryModel.findById(id);

            if(!category) {
                return res.json({
                    success : false,
                    message : 'Category not found!',
                    
                });    
            }

            return res.json({
                success : true,
                data: category,
                
            });    


        } catch (error) {
            return res.json({
                success : false,
                message : error
            });
        }
    }

     


}

module.exports = CategoryController;