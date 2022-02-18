abstract class CategoryEvents {}

class FetchAllCategoriesEvent extends CategoryEvents {
  FetchAllCategoriesEvent();
}

class ChangeCategoryEvent extends CategoryEvents {
  final int index;
  ChangeCategoryEvent(this.index);
}

class RemoveCategoryEvent extends CategoryEvents {
  final String id;
  RemoveCategoryEvent(this.id);
}

class RemoveParticularCategoryEvent extends CategoryEvents {
  final String cattitle;
  final String subCatName;

  RemoveParticularCategoryEvent(this.cattitle, this.subCatName);
}

class AddCategoryEvent extends CategoryEvents {
  final String title;
  final List<String> data;

  AddCategoryEvent(this.data, this.title);
}
