import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/models/category.dart';
import 'package:todo_list/models/category_services.dart';
import 'package:todo_list/screens/home_page.dart';
import 'package:todo_list/showDialog_components.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

    @override
  void initState() {
    super.initState();
    getCategories();
  }

    var  categoryNameController=TextEditingController();
    var  categoryDescriptionController=TextEditingController();

    var  editCategoryNameController=TextEditingController();
    var  editCategoryDescriptionController=TextEditingController();

    var  category=Category();
    var  categoryServices=CategoryServices();

    List<Category> categoriesList= <Category>[];

    final GlobalKey<ScaffoldState> globalKey=GlobalKey<ScaffoldState>();

    getCategories() async{
      categoriesList=<Category>[];
      var categories=await categoryServices.readCategories();
      categories.forEach((category){
        setState(() {
          var categoryModel=Category();
          categoryModel.id=category['id'];
          categoryModel.name=category['name'];
          categoryModel.description=category['description'];
          categoriesList.add(categoryModel);
        });
      });
    }

    _editCategory(BuildContext context,categoryId)async {
      var editCategory = await categoryServices.readCategoriesById(categoryId);
      setState(() {
        editCategoryNameController.text = editCategory[0]['name'] ?? 'No name';
        editCategoryDescriptionController.text =
            editCategory[0]['description'] ?? 'No Description';
      });
      ShowDialog().showFormDialog(
          context: context,
          buttonText: 'Update',
          titleText: 'Edit Categories Form',
          onPressedButton: ()async{
            category.id=editCategory[0]['id'];
            category.name=editCategoryNameController.text;
            category.description=editCategoryDescriptionController.text;
            var result=await categoryServices.updateCategory(category);
            getCategories();
            Navigator.pop(context);
            _showSnackBar(Text('updated'));
          },
          nameController: editCategoryNameController,
          descriptionController: editCategoryDescriptionController
      );
    }

    _showSnackBar(message){
      var snackBar=SnackBar(content: message);
      globalKey.currentState!.showSnackBar(snackBar);
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=>
          ShowDialog().showFormDialog(
            context: context,
            buttonText: 'Save',
            titleText: 'Categories Form',
            onPressedButton: ()async{
              category.name=categoryNameController.text;
              category.description=categoryDescriptionController.text;
              var result=await categoryServices.services(category);
              getCategories();
              Navigator.pop(context);
              _showSnackBar(Text('added'));
            },
            nameController: categoryNameController,
            descriptionController: categoryDescriptionController
          ),
      ),
      appBar: AppBar(
        title: Text('Categories'),
        leading: RaisedButton(
          color: Colors.blue,
          elevation: 0.0,
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));
          },
        ),
      ),
      body: ListView.builder(
          itemCount: categoriesList.length,
          itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.only(top: 8.0,left: 16.0,right: 16.0),
                child: Card(
                  elevation: 8.0,
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(categoriesList[index].name),
                        IconButton(
                            onPressed: ()=>
                              ShowDialog().showDeleteFormDialog(
                                  context: context,
                                  onPressedButton: ()async{
                                    var result=await categoryServices.deleteCategory(categoriesList[index].id);
                                    getCategories();
                                    Navigator.pop(context);
                                    _showSnackBar(Text('deleted'));
                                  }
                              ),
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            )
                        )
                      ],
                    ),
                    leading: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: (){
                        _editCategory(context, categoriesList[index].id);
                      },
                    ),
                    subtitle: Text(categoriesList[index].description),
                  ),
                ),
              );
          }
      ),
    );
  }
}

