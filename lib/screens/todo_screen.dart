import 'package:flutter/material.dart';
import 'package:todo_list/models/category_services.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/models/todo_service.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {

  var todoTitleController=TextEditingController();
  var todoDescriptionController=TextEditingController();
  var todoDateController=TextEditingController();

  var categories=<DropdownMenuItem<String>>[];
  var selectedValue;

  GlobalKey<ScaffoldState> globalKey=GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _getCategories();
    super.initState();
  }

  _getCategories()async{
    var allCategories=await CategoryServices().readCategories();
    allCategories.forEach((category){
      setState(() {
        categories.add(DropdownMenuItem(
            value: category['name'],
            child: Text(category['name']),
        ));
      });
    });
  }

  void _onChanged(value){
    setState(() {
      selectedValue=value;
    });
  }

  _showSnackBar(message){
    var snackBar=SnackBar(content: message);
    globalKey.currentState!.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text('Create todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: todoTitleController,
              decoration: InputDecoration(
                labelText: 'Title',
                hintText: 'Write todo title',
              ),
            ),
            TextField(
              controller: todoDescriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Write todo description',
              ),
            ),
            TextField(
              controller: todoDateController,
              decoration: InputDecoration(
                labelText: 'Date',
                hintText: 'Pick a date',
                prefixIcon: InkWell(
                  onTap: null,
                  child: Icon(Icons.calendar_today),
                )
              ),
            ),
            DropdownButtonFormField<String>(
                onChanged:(value){
                  setState(() {
                    selectedValue=value!;
                  });
                },
                items: categories,
                value: selectedValue,
                hint: Text('Category'),
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
                child: Text(
                    'Save',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: ()async{
                  var todoObject=Todo();

                  todoObject.title= todoTitleController.text;
                  todoObject.description= todoDescriptionController.text;
                  todoObject.category= selectedValue;
                  todoObject.todoDate= todoDateController.text;
                  todoObject.isFinished=0;

                  var todoService=TodoServices();
                  var result=await todoService.saveTodo(todoObject);

                  if(result>0){
                    _showSnackBar(Text('added'));
                  }
                }
            )
          ],
        ),
      ),
    );
  }
}
