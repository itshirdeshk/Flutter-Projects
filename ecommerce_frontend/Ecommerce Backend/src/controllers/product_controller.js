const ProductModel = require('../models/product_model');

const ProductController = {

    createProduct: async function(req, res){
        try {
            const ProductData = req.body;
            const newProduct = new ProductModel(ProductData);
            await newProduct.save();

            return res.json({
                success : true,
                data: newProduct,
                message : 'Product Created!'
            });            
        } catch (error) {
            return res.json({
                success : false,
                message : error
            });
        }
    },

    fetchAllProduct: async function(req, res){
        try {
            
            const products = await ProductModel.find();

            return res.json({
                success : true,
                data: products,
                
            });    


        } catch (error) {
            return res.json({
                success : false,
                message : error
            });
        }
    },

    // fetchCategoryById: async function(req, res){
    //     try {
    //         const id = req.params.id;
    //         const category = await ProductModel.findById(id);

    //         if(!category) {
    //             return res.json({
    //                 success : false,
    //                 message : 'Produc not found!',
                    
    //             });    
    //         }

    //         return res.json({
    //             success : true,
    //             data: category,
                
    //         });    


    //     } catch (error) {
    //         return res.json({
    //             success : false,
    //             message : error
    //         });
    //     }
    // }

    fetchProductByCategory : async function(req, res){
        try {
            const categoryId = req.params.id;
            const products = await ProductModel.find({category : categoryId});

            return res.json({
                success : true,
                data: products,
                
            });    


        } catch (error) {
            return res.json({
                success : false,
                message : error
            });
        }
    }


}

module.exports = ProductController;