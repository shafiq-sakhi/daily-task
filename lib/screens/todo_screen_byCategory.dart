import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/models/todo_service.dart';

class TodoScreenByCategory extends StatefulWidget {
  final String category;
  TodoScreenByCategory(this.category);

  @override
  _TodoScreenByCategoryState createState() => _TodoScreenByCategoryState();
}

class _TodoScreenByCategoryState extends State<TodoScreenByCategory> {
  List<Todo> todoList=[];
  TodoServices todoServices=TodoServices();

  @override
  void initState(){
    super.initState();
    getTodo();
  }

  getTodo()async{
    var result=await todoServices.readTodoByColumn(this.widget.category);
    result.forEach((todo){
      setState(() {
        var model=Todo();
        model.title=todo['title'];
        model.description=todo['description'];
        model.todoDate=todo['todoDate'];

        todoList.add(model);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.category),
      ),
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context,index){
            return Padding(
              padding:  EdgeInsets.fromLTRB(8.0,8.0,8.0,0.0),
              child: Card(
                elevation: 8,
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(todoList[index].title ?? 'No Title')
                    ],
                  ),
                  subtitle: Text(todoList[index].description ?? 'No Description'),
                  trailing: Text(todoList[index].todoDate ?? 'No Date'),
                ),
              ),
            );
          }
      ),
    );
  }
}
