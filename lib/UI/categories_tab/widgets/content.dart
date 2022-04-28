import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marketing_admin_panel/bloc/category_bloc/change_bloc.dart';
import 'package:marketing_admin_panel/bloc/category_bloc/events.dart';
import 'package:marketing_admin_panel/bloc/category_bloc/states.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/constants.dart';

class Content extends StatefulWidget {
  const Content({
    Key? key,
    required this.selectedCategory,
    required this.subCat,
  }) : super(key: key);

  final String selectedCategory;
  final List<dynamic> subCat;

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  void delete(subCat) {
    widget.subCat.removeWhere((element) => element == subCat);
    if(widget.subCat.length == 0)
      BlocProvider.of<CategoryBloc>(context).add(RemoveCategoryEvent(widget.selectedCategory));
    else
      BlocProvider.of<CategoryBloc>(context).add(
        RemoveParticularCategoryEvent(
          widget.selectedCategory,
          subCat,
        ),
      );

    BlocProvider.of<CategoryBloc>(context).add(FetchAllCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryStates>(
      builder: (context, state) {
        if (state is FetchAllCategoriesLoadingStates) {
          return const Center(
            child: CircularProgressIndicator(
              color: MyColors.primaryColor,
            ),
          );
        } else {
          return widget.selectedCategory.isEmpty && widget.subCat.isEmpty
              ? const Center(
                  child: Text(
                  'Welcome, please click on Category',
                  style: Constants.TEXT_STYLE9,
                ))
              : Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ListView(
                    children: widget.subCat.map((subCat) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 6,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: MyColors.lightBlue,
                                ),
                                child: Text(
                                  subCat,
                                  textAlign: TextAlign.center,
                                  style: Constants.TEXT_STYLE4
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                delete(subCat);
                              },
                              child: SvgPicture.asset(
                                'assets/images/trash.svg',
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                );
        }
      },
    );
  }
}

/*child: ListView(
                  children: widget.subCat.map((subCat) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 6,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey.shade400,
                              ),
                              child: Text(
                                subCat,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: MyColors.primaryColor,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          PopupMenuButton<String>(
                            color: Colors.white,
                            enabled: true,
                            iconSize: 20,
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: EdgeInsets.zero,
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem<String>(
                                  value: subCat,
                                  enabled: true,
                                  textStyle: const TextStyle(
                                    color: Colors.red,
                                  ),
                                  child: const Text('Delete'),
                                  onTap: () => delete(subCat),
                                ),
                              ];
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),*/
