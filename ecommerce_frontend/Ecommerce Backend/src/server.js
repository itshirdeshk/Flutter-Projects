const express = require('express');
const bodyParser = require('body-parser');
const morgan = require('morgan');
const helmet = require('helmet');
const cors = require('cors');
const mongoose = require('mongoose');


const app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended : false}));
app.use(helmet());
app.use(morgan('dev'));
app.use(cors());

mongoose.connect('mongodb+srv://itshirdeshk:jiophone@ecommerce-cluster.6ynw9hm.mongodb.net/ecommerce?retryWrites=true&w=majority');

app.get('/', (req, res) => {
    res.json({'success' : true, 'message' : 'Hey there'});
});

const UserRoutes = require('./routes/user_routes');
const CategoryRoute = require('./routes/category_routes');
const ProductRoutes = require('./routes/product_routes');
const CartRoutes = require('./routes/cart_routes');
const OrderRoutes = require('./routes/order_routes');

app.use('/api/user', UserRoutes);
app.use('/api/category', CategoryRoute);
app.use('/api/product', ProductRoutes);
app.use('/api/cart', CartRoutes);
app.use('/api/order', OrderRoutes);

const PORT = 5000;
app.listen(PORT, () => console.log(`Server started at PORT : ${PORT}`));