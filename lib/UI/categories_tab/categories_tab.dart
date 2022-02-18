import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    currentIndex = 0;

    subcategories = [];
    data1 = [];

    selectedCategory = '';
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<CategoryBloc>(context).add(FetchAllCategoriesEvent());
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
      },
      builder: (context, state) {
        if (state is ChangeSelectedCategoryLoadingStates) {
          return const Center(
            child: CircularProgressIndicator(
              color: MyColors.primaryColor,
            ),
          );
        } else {
          return Container(
            color: MyColors.primaryColor,
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Column(
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
            ),
          );
        }
      },
    );
  }
}
