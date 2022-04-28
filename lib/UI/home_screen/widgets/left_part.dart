import 'package:flutter/material.dart';

class LeftPart extends StatefulWidget {
  const LeftPart({Key? key}) : super(key: key);

  @override
  State<LeftPart> createState() => _LeftPartState();
}

class _LeftPartState extends State<LeftPart> {
  static const Map<String, String> drawerItems = {
    'Users': 'person',
    'اCompanies': 'person',
    'Categories': 'category',
    'Offers': 'offers',
  };

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(),
      // child: Container(
      //   height: double.maxFinite,
      //   padding: const EdgeInsets.all(14),
      //   color: MyColors.primaryColor,
      //   child: SingleChildScrollView(
      //     child: Column(
      //       children: List.generate(drawerItems.length, (index) {
      //         // drawer header
      //         if (index == 0) {
      //           return Container(
      //             alignment: Alignment.center,
      //             width: double.maxFinite,
      //             height: 150,
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 const Text(
      //                   'Admin Panel',
      //                   style: Constants.TEXT_STYLE2,
      //                 ),
      //                 Divider(
      //                   color: Colors.grey.shade400,
      //                   endIndent: 10,
      //                   indent: 10,
      //                 ),
      //               ],
      //             ),
      //           );
      //         }
      //
      //         return GestureDetector(
      //           onTap: () {
      //             setState(() => currentIndex = index);
      //             BlocProvider.of<PanelBloc>(context)
      //                 .add(ChangeIndexEvents(index - 1));
      //           },
      //           child: Container(
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(15),
      //               color: currentIndex == index
      //                   ? MyColors.lightBlue
      //                   : MyColors.grey,
      //             ),
      //             padding: const EdgeInsets.symmetric(vertical: 12),
      //             margin: const EdgeInsets.only(bottom: 20),
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               children: [
      //                 const SizedBox(width: 20),
      //                 Icon(
      //                   drawerItems[index]['icon'],
      //                   size: 20,
      //                   color: MyColors.primaryColor,
      //                 ),
      //                 const SizedBox(width: 10),
      //                 Text(
      //                   drawerItems[index]['title'],
      //                   style: const TextStyle(
      //                     color: MyColors.primaryColor,
      //                     fontSize: 18,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         );
      //       }).toList(),
      //     ),
      //   ),
      // ),
    );
  }
}
