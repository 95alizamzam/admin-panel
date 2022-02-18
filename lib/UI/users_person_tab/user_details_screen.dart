import 'package:flutter/material.dart';
import 'package:marketing_admin_panel/UI/shared_widgets/default_image.dart';
import 'package:marketing_admin_panel/models/usersModel.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/navigator/navigator_imp.dart';
import 'package:marketing_admin_panel/utils/shared_widgets.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({Key? key, required this.model, required this.navigator})
      : super(key: key);

  final OneUserModel model;
  final navigator;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              navigatorImp().pop();
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: MyColors.primaryColor,
            ),
          ),
        ),
        body: Container(
            width: double.maxFinite,
            height: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: 75,
                  child: model.profileImage == '' ? DefaultImage() : Image.network(model.profileImage.toString(),),
                  ),
                const SizedBox(height: 10),
                Text(
                  model.userName!,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  model.nickName!,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  model.phoneNumber!,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  width: double.maxFinite,
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'offersAdded',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            model.offersAdded == null
                                ? "0"
                                : model.offersAdded!.length.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      )),
                      Container(
                        width: 2,
                        color: Colors.black45,
                        height: double.maxFinite,
                      ),
                      Expanded(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'comments',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            model.comments == null
                                ? "0"
                                : model.comments!.length.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      )),
                      Container(
                        width: 2,
                        color: Colors.black45,
                        height: double.maxFinite,
                      ),
                      Expanded(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'offersLiked',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            model.offersLiked == null
                                ? "0"
                                : model.offersLiked!.length.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      )),
                      Container(
                        width: 2,
                        color: Colors.black45,
                        height: double.maxFinite,
                      ),
                      Expanded(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Points',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            model.points == null
                                ? "0"
                                : model.points.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
