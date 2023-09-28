import 'package:todo_list/repositories/repository.dart';
import 'category.dart';

class CategoryServices{
   Repository? _repository;

  CategoryServices(){
    _repository=Repository();
  }

   services(Category category)async{
    return await _repository!.insertData('categories', category.categoryMapping());
  }

  readCategories()async{
    return _repository!.readData('categories');
  }

  readCategoriesById(categoryId)async{
    return _repository!.readDataById('categories', categoryId);
  }

  updateCategory(Category category)async{
    return _repository!.updateData('categories', category.categoryMapping());
  }

  deleteCategory(categoryId)async{
    return _repository!.deleteData('categories', categoryId);
  }

}