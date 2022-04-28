import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:marketing_admin_panel/UI/shared_widgets/custom_button.dart';
import 'package:marketing_admin_panel/bloc/category_bloc/change_bloc.dart';
import 'package:marketing_admin_panel/bloc/category_bloc/events.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/constants.dart';
import 'package:marketing_admin_panel/utils/navigator/navigator_imp.dart';

class ModalContent extends StatefulWidget {
	const ModalContent({Key? key}) : super(key: key);

	@override
	State<ModalContent> createState() => _ModalContentState();
}

class _ModalContentState extends State<ModalContent> {
	List<String> newCats = [];

	TextEditingController con = TextEditingController();
	TextEditingController subCon = TextEditingController();

	@override
  void dispose() {
    con.dispose();
    subCon.dispose();
    super.dispose();
  }
	@override
	Widget build(BuildContext context) {
		return Container(
			padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
			child: SingleChildScrollView(
				child: Column(
					children: [
						Row(
						  children: [
						    Expanded(
						      child: TextField(
						      	keyboardType: TextInputType.text,
						      	obscureText: false,
						      	controller: con,
						      	decoration: InputDecoration(
						      		enabledBorder: Constants.outlineBorder,
						      		disabledBorder: Constants.outlineBorder,
						      		focusedBorder: Constants.outlineBorder,
						      		errorBorder: Constants.outlineBorder,
						      		focusedErrorBorder: Constants.outlineBorder,
						      		hintText: 'Category Title',
						      		hintStyle: Constants.TEXT_STYLE4,
						      	),
						      ),
						    ),
								const SizedBox(
									width: 10,
								),
								Expanded(
								  child: TextField(
								  	keyboardType: TextInputType.text,
								  	obscureText: false,
								  	controller: subCon,
								  	decoration: InputDecoration(
								  		enabledBorder: Constants.outlineBorder,
								  		disabledBorder: Constants.outlineBorder,
								  		focusedBorder: Constants.outlineBorder,
								  		errorBorder: Constants.outlineBorder,
								  		focusedErrorBorder: Constants.outlineBorder,
								  		hintText: 'subCategory Title',
								  		hintStyle: Constants.TEXT_STYLE4,
								  	),
								  ),
								),
								const SizedBox(
									width: 10,
								),
								GestureDetector(
									onTap: () {
										if (subCon.text.isNotEmpty) {
											setState(() {
												newCats.add(subCon.text.trim());
												subCon.clear();
											});
										}
									},
									child: Container(
											padding: const EdgeInsets.all(10),
											decoration: BoxDecoration(
												borderRadius: BorderRadius.circular(10),
												color: MyColors.secondaryColor,
											),
											child: const Icon(
												Icons.add,
												color: MyColors.primaryColor,
											)),
								),
						  ],
						),
						const SizedBox(height: 10),
						if(newCats.isNotEmpty)
							Container(
								decoration: BoxDecoration(
									borderRadius: BorderRadius.circular(15),
									color: Colors.grey.shade200,
								),
								margin: const EdgeInsets.symmetric(horizontal: 30),
								height: 80,
								child: ListView.separated(
									scrollDirection: Axis.horizontal,
									itemBuilder: (context, index) => Container(
										padding: const EdgeInsets.symmetric(horizontal: 12),
										child: Row(
											children: [
												Text(
													newCats[index],
													style: Constants.TEXT_STYLE4,
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
														padding: const EdgeInsets.all(6),
														decoration: BoxDecoration(
															borderRadius: BorderRadius.circular(8),
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
						const SizedBox(height: 10),
						CustomButton(
							ontap: () {
								if (newCats.isEmpty || con.text.isEmpty) {
									EasyLoading.showToast('Fill all fields',);
								} else {
									BlocProvider.of<CategoryBloc>(context).add(AddCategoryEvent(newCats, con.text));

									NavigatorImpl().pop();

									BlocProvider.of<CategoryBloc>(context).add(FetchAllCategoriesEvent());
								}
							},
							color: MyColors.secondaryColor,
							buttonLabel: 'Add',
							padding: 12,
							radius: 15,
							labelColor: Colors.white,
							labelSize: 20,
							width: MediaQuery.of(context).size.width / 3,
						),
						const SizedBox(height: 20),
						Padding(
								padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)),
					],
				),
			),
		);
	}
}
