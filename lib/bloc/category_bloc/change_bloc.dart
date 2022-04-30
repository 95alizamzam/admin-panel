import 'package:bloc/bloc.dart';
import 'package:marketing_admin_panel/bloc/category_bloc/events.dart';

import 'package:marketing_admin_panel/locator.dart';
import 'package:marketing_admin_panel/models/categories_model.dart';
import 'package:marketing_admin_panel/repositories/categories/category_repository.dart';

import 'states.dart';

class CategoryBloc extends Bloc<CategoryEvents, CategoryStates> {
	CategoryBloc() : super(ChangeSelectedCategoryInitialStates()) {
		on<CategoryEvents>((event, emit) async {
			if (event is FetchAllCategoriesEvent) {
				emit(FetchAllCategoriesLoadingStates());

				try {
					final data = await locator.get<CategoriesRepo>().getCategories();
					CategoriesModel model = CategoriesModel.fromJson(data.docs);

					emit(FetchAllCategoriesDoneStates(model));
				} catch (e) {
					print('in FetchAllCategoriesEvent');
					print(e.toString());
					emit(FetchAllCategoriesFailedStates('Error, try again'));
				}
			}

			if (event is ChangeCategoryEvent) {
				emit(ChangeSelectedCategoryLoadingStates());
				emit(ChangeSelectedCategoryDoneStates(event.index));
			}

			if (event is RemoveCategoryEvent) {
				emit(Loading());
				try {
					await locator.get<CategoriesRepo>().remove(event.id);
					emit(Done());
				} catch (e) {
					print('in RemoveCategoryEvent');
					print(e.toString());
					emit(Failed('Error, try again'));
				}
			}

			if (event is AddCategoryEvent) {
				emit(Loading());
				try {
					await locator.get<CategoriesRepo>().add(event.title, event.data);
					emit(Done());
				} catch (e) {
					print(' in AddCategoryEvent');
					print(e.toString());
					emit(Failed('Error, try again'));
				}
			}

			if (event is RemoveParticularCategoryEvent) {
				emit(Loading());
				try {
					await locator
							.get<CategoriesRepo>()
							.removeCat(event.catTitle, event.subCatName);
					emit(Done());
				} catch (e) {
					print('in RemoveParticularCategoryEvent');
					print(e.toString());
					emit(Failed('Error, try again'));
				}
			}
		});
	}
}
