import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal1_app/dataBase/data_base.dart';
import 'package:meal1_app/models/category.dart';
import 'package:flutter/material.dart';
import '../../dummy_data.dart';
import '../../file_operations.dart';
part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  late List<Category> categories=[];
  late List<Category> categoriesTemp=[];

  late String pathImages;
  CategoryCubit() : super(CategoryInitial()) {
    if(categories.isEmpty) {
      fillCategoryList();
    }
  }

Future<void> fillCategoryList()async{
    List<Category> temp = await DatabaseHelper.instance.getCategoriesList();
    categories=DummyData().getDummyCategories()+temp;
    categoriesTemp=DummyData().getDummyCategories()+temp;
    emit(CategoryInitial());
}
  static CategoryCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }


  Future<void> addCategoryToDatabase(String categoryName,String categoryImagePath) async {
    DatabaseHelper.instance.insertCategory(Category(id: '',title: categoryName, image: await getImagePathFile(categoryName, categoryImagePath)));
    categories=categoriesTemp+(await DatabaseHelper.instance.getCategoriesList());
    emit(CategoryLoaded());
  }
}
