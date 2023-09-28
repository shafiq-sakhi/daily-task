import 'package:todo_list/models/todo.dart';
import 'package:todo_list/repositories/repository.dart';

class TodoServices{
  Repository? _repository;

  TodoServices(){
    _repository=Repository();
  }

  saveTodo(Todo todo)async{
    return await _repository!.insertData('todo', todo.todoMapping());
  }

  readTodo()async{
    return await _repository!.readData('todo');
  }
  
  readTodoByColumn(category)async{
    return await _repository!.readDataByColumn('todo', 'category', category);
  }

}