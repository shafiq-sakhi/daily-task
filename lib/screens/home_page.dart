import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/models/todo_service.dart';
import 'package:todo_list/screens/drawer_navigation.dart';
import 'todo_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TodoServices? todoServices;

  List<Todo> todoList=[];

  @override
  void initState() {
    getAllTodo();
    super.initState();
  }

  getAllTodo() async{
    todoServices=TodoServices();
    todoList=<Todo>[];

    var allTodo=await todoServices!.readTodo();

    allTodo.forEach((todo){
      setState(() {
        var model=Todo();
        model.id=todo['id'];
        model.title=todo['title'];
        model.description=todo['description'];
        model.category=todo['category'];
        model.todoDate=todo['todoDate'];
        model.isFinished=todo['isFinished'];

        todoList.add(model);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      drawer: DrawerNavigation(),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> TodoScreen())),
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context,index){
            return Padding(
              padding: EdgeInsets.fromLTRB(8.0,8.0,8.0,0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)
                ),
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(todoList[index].title ?? 'No Title')
                    ],
                  ),
                  subtitle: Text(todoList[index].category ?? 'No Category'),
                  trailing: Text(todoList[index].todoDate ?? 'No Date'),
                ),
              ),
            );
          }
          )
    );
  }

}
