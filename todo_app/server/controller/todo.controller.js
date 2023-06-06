const ToDoServices = require('../services/todo.services');

exports.createTodo = async (req, res, next) => {
    try {
        const { userId, title, desc } = req.body;

        let todo = await ToDoServices.createTodo(userId, title, desc);

        res.json({ status: true, success: todo });
    } catch (error) {
        throw error;
    }
}

exports.getUserToDoList = async (req, res, next) => {
    try {
        const { userId } = req.body;

        let todoData = await ToDoServices.getUserToDoData(userId);

        res.json({ status: true, success: todoData });
    } catch (error) {
        throw error;
    }
}

exports.deleteToDo = async (req, res, next) => {
    try {
        const { id } = req.body;

        let deleted = await ToDoServices.deleteToDo(id);

        res.json({ status: true, success: deleted });
    } catch (error) {
        throw error;
    }
}