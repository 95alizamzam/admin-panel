import 'package:flutter/material.dart';
import 'package:marketing_admin_panel/UI/home_screen/widgets/Tabs/user_tab/most_row_elements.dart';
import 'package:marketing_admin_panel/UI/home_screen/widgets/Tabs/user_tab/users_list.dart';
import 'package:marketing_admin_panel/utils/colors.dart';

class UsersTab extends StatelessWidget {
  UsersTab({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      padding: const EdgeInsets.only(right: 10, top: 20, bottom: 20),
      color: MyColors.primaryColor,
      child: Column(
        children: [
          SizedBox(
            child: Form(
              key: formKey,
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Empty Field';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                    color: MyColors.lightBlue,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: MyColors.secondaryColor,
                    ),
                  ),
                  hintText: 'Enter User Name Or Email',
                  filled: true,
                  fillColor: MyColors.primaryColor,
                  hintStyle: const TextStyle(
                    color: MyColors.lightBlue,
                  ),
                ),
                onFieldSubmitted: (String? value) {
                  if (!formKey.currentState!.validate()) {
                    return;
                  } else {
                    formKey.currentState!.save();
                    // do the search process
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              width: double.maxFinite,
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: const [
                        RowElement(
                          label: 'The most Buy',
                          userImage:
                              'https://th.bing.com/th/id/R.3282eea20bca492fee1217a9e67bdcb9?rik=nEoqljJB8%2fSl%2fw&pid=ImgRaw&r=0',
                          userName: 'Ali Zamzam',
                        ),
                        SizedBox(width: 20),
                        RowElement(
                          label: 'The most Buy',
                          userImage:
                              'https://th.bing.com/th/id/R.3282eea20bca492fee1217a9e67bdcb9?rik=nEoqljJB8%2fSl%2fw&pid=ImgRaw&r=0',
                          userName: 'Ali Zamzam',
                        ),
                      ],
                    ),
                  ),
                  const UsersList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
