import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriesModel {
  List<CategoryModel> cats = [];
  CategoriesModel.fromJson(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data) {
    for (var element in data) {
      cats.add(CategoryModel.fromJson(element));
    }
  }
}

class CategoryModel {
  String? title;
  List<dynamic> subCategories = [];

  CategoryModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    title = json.id;
    subCategories = json.data()['subCategories'];
  }
}
