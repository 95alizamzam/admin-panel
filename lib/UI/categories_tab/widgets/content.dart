import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing_admin_panel/bloc/category_bloc/change_bloc.dart';
import 'package:marketing_admin_panel/bloc/category_bloc/events.dart';
import 'package:marketing_admin_panel/bloc/category_bloc/states.dart';
import 'package:marketing_admin_panel/utils/colors.dart';

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
  void delete(subcat) {
    widget.subCat.removeWhere((element) => element == subcat);
    BlocProvider.of<CategoryBloc>(context).add(
      RemoveParticularCategoryEvent(
        widget.selectedCategory,
        subcat,
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
                  'Welocme, Please click on Category',
                  style: TextStyle(
                    fontSize: 30,
                    color: MyColors.primaryColor,
                  ),
                ))
              : SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          widget.selectedCategory,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.all(20),
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    color: Colors.white,
                                    child: Text(
                                      widget.selectedCategory,
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 200,
                                    color: Colors.white,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: widget.subCat.map((subcat) {
                                          return Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 6),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 20,
                                                    ),
                                                    width: double.maxFinite,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      color:
                                                          Colors.grey.shade300,
                                                    ),
                                                    child: Text(
                                                      subcat,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                        color: Colors.black,
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  padding: EdgeInsets.zero,
                                                  itemBuilder: (context) {
                                                    return [
                                                      PopupMenuItem<String>(
                                                        value: subcat,
                                                        enabled: true,
                                                        textStyle:
                                                            const TextStyle(
                                                          color: Colors.red,
                                                        ),
                                                        child: const Text(
                                                            'Delete'),
                                                        onTap: () =>
                                                            delete(subcat),
                                                      ),
                                                    ];
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                );
        }
      },
    );
  }
}
