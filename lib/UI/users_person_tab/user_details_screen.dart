import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketing_admin_panel/UI/shared_widgets/default_image.dart';
import 'package:marketing_admin_panel/UI/users_person_tab/widgets/package_chip.dart';
import 'package:marketing_admin_panel/utils/enums.dart';
import '../shared_widgets/images_list_view.dart';
import 'widgets/user_info_row.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/constants.dart';

import 'widgets/address_row.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({Key? key, required this.user, required this.navigator}) : super(key: key);

  final user;
  final navigator;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.userName}'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            color: MyColors.lightGrey.withOpacity(0.2),
            child: Row(
              children: [
                user.profileImage == ''
                    ? DefaultImage(
                        size: 100.0,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          user.profileImage.toString(),
                          fit: BoxFit.cover,
                          height: 100,
                          width: 100,
                        ),
                      ),
                const SizedBox(
                  width: 25,
                ),
                Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.userName + ' ' + '(${user.userType.toString().substring(9)})',
                      style: Constants.TEXT_STYLE2,
                    ),
                    Row(
                      children: [
                        Text(
                          user.userCode,
                          style: Constants.TEXT_STYLE8,
                        ),
                        IconButton(
                          onPressed: () async {
                            await Clipboard.setData(ClipboardData(text: user.userCode));
                            EasyLoading.showToast('User code is copied to clipboard');
                          },
                          icon: Icon(
                            Icons.copy_outlined,
                            color: MyColors.black,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  width: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/offers.svg',
                          fit: BoxFit.scaleDown,
                          color: MyColors.secondaryColor,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          '${user.offersAdded == null ? 0 : user.offersAdded.length}',
                          style: Constants.TEXT_STYLE4,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/like.svg',
                          fit: BoxFit.scaleDown,
                          color: MyColors.secondaryColor,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          '${user.offersLiked == null ? 0 : user.offersLiked.length}',
                          style: Constants.TEXT_STYLE4,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.square_favorites_fill,
                          color: MyColors.secondaryColor,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          '${user.comments == null ? 0 : user.offersLiked.length}',
                          style: Constants.TEXT_STYLE4,
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                PackageChip(userId: user.id),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: ListView(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Chip(
                      label: Text('${user.points ?? 0} Points'),
                      labelStyle: Constants.TEXT_STYLE4,
                      backgroundColor: Colors.amberAccent,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          UserInfoRow(
                            data: user.email,
                            title: 'Email',
                            icon: SvgPicture.asset(
                              'assets/images/email.svg',
                              fit: BoxFit.scaleDown,
                              color: MyColors.secondaryColor,
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          UserInfoRow(
                            data: user.country ?? 'Not Provided',
                            title: 'Country',
                            icon: Icon(
                              Icons.location_city,
                              color: MyColors.secondaryColor,
                            ),
                          ),
                          if (user.userType == 'Person')
                            const SizedBox(
                              height: 14,
                            ),
                          if (user.userType == 'Person')
                            UserInfoRow(
                              data: user.gender ?? 'Not Provided',
                              title: 'Gender',
                              icon: SvgPicture.asset(
                                'assets/images/person.svg',
                                color: MyColors.secondaryColor,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          UserInfoRow(
                            data: user.phoneNumber,
                            title: 'Phone Number',
                            icon: SvgPicture.asset(
                              'assets/images/phone.svg',
                              fit: BoxFit.scaleDown,
                              color: MyColors.secondaryColor,
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          UserInfoRow(
                            data: user.city ?? 'Not Provided',
                            title: 'City',
                            icon: Icon(
                              Icons.location_city,
                              color: MyColors.secondaryColor,
                            ),
                          ),
                          if (user.userType == 'Person')
                            const SizedBox(
                              height: 14,
                            ),
                          if (user.userType == 'Person')
                            UserInfoRow(
                              data: user.dateBirth ?? 'Not Provided',
                              title: 'Date Birth',
                              icon: SvgPicture.asset(
                                'assets/images/date.svg',
                                color: MyColors.secondaryColor,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  AddressInfoRow(
                    latitude: user.latitude ?? 0.0,
                    longitude: user.longitude ?? 0.0,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  UserInfoRow(
                    data: user.shortDesc ?? 'Not Provided',
                    title: 'Short Description',
                    flexible: true,
                    icon: Icon(
                      Icons.description,
                      color: MyColors.secondaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  if (user.userType == UserType.Company.toString())
                    UserInfoRow(
                      data: user.regNumber,
                      title: 'Registration Number',
                      icon: Icon(
                        Icons.app_registration,
                        color: MyColors.secondaryColor,
                      ),
                    ),
                  if (user.userType == UserType.Company.toString())
                    SizedBox(
                      height: 12,
                    ),
                  if (user.userType == UserType.Company.toString())
                    Text(
                      'Registration Images',
                      style: Constants.TEXT_STYLE9,
                    ),
                  if (user.userType == UserType.Company.toString())
                    SizedBox(
                      height: 12,
                    ),
                  if (user.userType == UserType.Company.toString())
                    ImagesListView(
                      images: user.regImages ?? [],
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
