const router = require('express').Router();
const ToDoController = require('../controller/todo.controller');

router.post('/createToDo', ToDoController.createTodo);

router.get('/getUserToDoList', ToDoController.getUserToDoList);

router.get('/deleteToDo', ToDoController.deleteToDo);

module.exports = router;