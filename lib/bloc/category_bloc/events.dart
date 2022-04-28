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
  final String catTitle;
  final String subCatName;

  RemoveParticularCategoryEvent(this.catTitle, this.subCatName);
}

class AddCategoryEvent extends CategoryEvents {
  final String title;
  final List<String> data;

  AddCategoryEvent(this.data, this.title);
}
