import 'package:flutter/material.dart';
import 'package:todo_list/models/category.dart';
import 'package:todo_list/models/category_services.dart';
import 'package:todo_list/screens/todo_screen_byCategory.dart';
import 'home_page.dart';
import 'categories_screen.dart';

class DrawerNavigation extends StatefulWidget {
  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  List<Widget> _category=[];

  @override
  void initState() {
    getAllCategory();
    super.initState();
  }

  var categoryService=CategoryServices();

  getAllCategory()async{
    var result=await categoryService.readCategories();

    result.forEach((category){
      setState(() {
        _category.add(InkWell(
          onTap: ()=> Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=> TodoScreenByCategory(category['name']))
          ),
          child: ListTile(
            title: Text(category['name']),
          ),
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('images/profile.JPG')
                ),
                accountName: Text('Shafiq Sakhi'),
                accountEmail: Text('shafiqsakhi0@gmail.com')
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('home'),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> HomePage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text('Categories'),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CategoriesScreen()));
              },
            ),
            Divider(),
            Column(
              children: _category,
            )
          ],
        ),
      ),
    );
  }
}

