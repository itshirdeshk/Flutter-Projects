const express = require('express');
const bodyParser = require('body-parser');
const userRouter = require('./router/user.router');
const TodoRouter = require('./router/todo.router');

const app = express();

app.use(bodyParser.json());


app.use('/', userRouter);
app.use('/', TodoRouter);

module.exports = app;