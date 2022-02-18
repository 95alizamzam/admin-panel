import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing_admin_panel/UI/shared_widgets/custom_button.dart';
import 'package:marketing_admin_panel/bloc/category_bloc/change_bloc.dart';
import 'package:marketing_admin_panel/bloc/category_bloc/events.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/shared_widgets.dart';

class ModalContent extends StatefulWidget {
  const ModalContent({Key? key}) : super(key: key);

  @override
  State<ModalContent> createState() => _ModalContentState();
}

class _ModalContentState extends State<ModalContent> {
  List<String> newCats = [];

  TextEditingController con = TextEditingController();
  TextEditingController subcon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.text,
              obscureText: false,
              controller: con,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: MyColors.primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: MyColors.black),
                ),
                hintText: 'Category Title',
                hintStyle: const TextStyle(color: MyColors.black),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              color: Colors.grey.shade50,
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      controller: subcon,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              const BorderSide(color: MyColors.primaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: MyColors.black),
                        ),
                        hintText: 'subCategory Title',
                        hintStyle: const TextStyle(color: MyColors.black),
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                  GestureDetector(
                    onTap: () {
                      if (subcon.text.isNotEmpty) {
                        setState(() {
                          newCats.add(subcon.text.trim());
                          subcon.clear();
                        });
                      }
                    },
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: MyColors.secondaryColor,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: MyColors.primaryColor,
                        )),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.shade200,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 30),
              height: 100,
              padding: const EdgeInsets.all(10),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    children: [
                      Text(
                        newCats[index],
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            newCats.removeWhere(
                              (element) => element == newCats[index],
                            );
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: MyColors.red,
                          ),
                          child: const Icon(
                            Icons.remove,
                            color: MyColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                separatorBuilder: (context, index) => const Divider(
                  color: MyColors.black,
                  thickness: 1,
                ),
                itemCount: newCats.length,
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              ontap: () {
                if (newCats.isEmpty || con.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: const Text(
                      'Empty Fields',
                      style: TextStyle(color: Colors.white),
                    ),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height - 100,
                      right: 20,
                      left: 20,
                    ),
                  ));
                } else {
                  BlocProvider.of<CategoryBloc>(context)
                      .add(AddCategoryEvent(newCats, con.text));

                  Navigator.of(context).pop();

                  BlocProvider.of<CategoryBloc>(context)
                      .add(FetchAllCategoriesEvent());
                }
              },
              buttonLabel: 'Add',
              padding: 20,
              radius: 15,
              labelColor: Colors.white,
              labelSize: 20,
              width: MediaQuery.of(context).size.width / 2,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
