import 'package:flutter/material.dart';

class ShowDialog{

  showFormDialog({required BuildContext context,required String buttonText,required String titleText,
    required Function onPressedButton,required TextEditingController nameController,
    required TextEditingController descriptionController}){

    return showDialog(context: context,barrierDismissible: false, builder: (param){
      return AlertDialog(
        actions: [
          FlatButton(
              color: Colors.red,
              onPressed: ()=> Navigator.pop(context),
              child: Text('Cancel')
          ),
          FlatButton(
              color: Colors.blue,
              onPressed:()=> onPressedButton()!,
              child: Text(buttonText)
          )
        ],
        title: Text(titleText),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                    hintText: 'Write a category',
                    labelText: 'Category'
                ),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                    hintText: 'Write a description',
                    labelText: 'Description'
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  showDeleteFormDialog({required BuildContext context, required Function onPressedButton}) {
    return showDialog(
        context: context, barrierDismissible: false, builder: (param) {
      return AlertDialog(
        actions: [
          FlatButton(
              color: Colors.red,
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel')
          ),
          FlatButton(
              color: Colors.blue,
              onPressed: () => onPressedButton()!,
              child: Text('Delete')
          )
        ],
        title: Text('Are you sure you want to delete this?'),
      );
    });
  }

}