const TodoModel = require('../model/todo.model');

class ToDoServices {
    static async createTodo(userId, title, desc) {
        const createTodo = new TodoModel({ userId, title, desc });
        return createTodo.save();
    }

    static async getUserToDoData(userId) {
        const todoData = await TodoModel.find({ userId });
        return todoData;
    }

    static async deleteToDo(userId) {
        const deleted = await TodoModel.findByIdAndDelete({ _id: id });
        return deleted;
    }
}

module.exports = ToDoServices;