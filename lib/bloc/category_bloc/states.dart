import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marketing_admin_panel/models/categories_model.dart';

abstract class CategoryStates {}

class ChangeSelectedCategoryInitialStates extends CategoryStates {}

// fetch add categories

class FetchAllCategoriesLoadingStates extends CategoryStates {}

class FetchAllCategoriesDoneStates extends CategoryStates {
  final CategoriesModel model;
  FetchAllCategoriesDoneStates(this.model);
}

class FetchAllCategoriesFailedStates extends CategoryStates {}

// when user click on category
class ChangeSelectedCategoryLoadingStates extends CategoryStates {}

class ChangeSelectedCategoryDoneStates extends CategoryStates {
  final int index;
  ChangeSelectedCategoryDoneStates(this.index);
}

class ChangeSelectedCategoryFailedStates extends CategoryStates {}
