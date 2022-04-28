import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:marketing_admin_panel/UI/categories_tab/widgets/content.dart';
import 'package:marketing_admin_panel/UI/categories_tab/widgets/categories_show.dart';
import 'package:marketing_admin_panel/UI/categories_tab/widgets/top_row.dart';
import 'package:marketing_admin_panel/bloc/category_bloc/change_bloc.dart';
import 'package:marketing_admin_panel/bloc/category_bloc/events.dart';
import 'package:marketing_admin_panel/bloc/category_bloc/states.dart';
import 'package:marketing_admin_panel/models/categories_model.dart';
import 'package:marketing_admin_panel/utils/colors.dart';

class CategoriesTab extends StatefulWidget {
  const CategoriesTab({Key? key}) : super(key: key);
  @override
  State<CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {
  late List<CategoryModel> data1;

  late List<dynamic> subcategories;
  late String selectedCategory;
  late int currentIndex;

  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context).add(FetchAllCategoriesEvent());
    currentIndex = 0;
    subcategories = [];
    data1 = [];

    selectedCategory = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryBloc, CategoryStates>(
      listener: (context, state) {
        if (state is FetchAllCategoriesDoneStates) {
          data1 = state.model.cats;
        }

        if (state is ChangeSelectedCategoryDoneStates) {
          currentIndex = state.index;
          selectedCategory = data1[currentIndex].title!;
          subcategories = data1[currentIndex].subCategories;
        }

        if(state is Loading)
          EasyLoading.show(status: 'Please wait..');

        if(state is Done)
          EasyLoading.dismiss();

        if(state is Failed){
          EasyLoading.dismiss();
          EasyLoading.showError(state.message);
        }
      },
      builder: (context, state) {
        if (state is ChangeSelectedCategoryLoadingStates || state is FetchAllCategoriesLoadingStates) {
          return const Center(
            child: CircularProgressIndicator(
              color: MyColors.secondaryColor,
            ),
          );
        } else {
          return Container(
            color: MyColors.primaryColor,
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 1,
                  child: TopRow(),
                ),
                Expanded(
                  flex: 2,
                  child: CategoriesShow(items: data1),
                ),
                Divider(
                  color: Colors.grey.shade700,
                  thickness: 2,
                  endIndent: 20,
                  indent: 20,
                ),
                Expanded(
                  flex: 7,
                  child:  Content(
                    selectedCategory: selectedCategory,
                    subCat: data1.isEmpty ? [] : subcategories,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

/*Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const TopRow(),
                CategoriesShow(items: data1),
                Divider(
                  color: Colors.grey.shade700,
                  thickness: 2,
                  endIndent: 20,
                  indent: 20,
                ),
                Content(
                  selectedCategory: selectedCategory,
                  subCat: data1.isEmpty ? [] : subcategories,
                ),
              ],
            )*/
