import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/constants.dart';

class SideMenu extends StatefulWidget {
  final PageController pageController;

  SideMenu({
    required this.pageController,
  });

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  static const Map<String, String> drawerItems = {
    'Users': 'person',
    'Companies': 'person',
    'Categories': 'category',
    'Offers': 'offers',
    'C.Offers': 'offers',
    'Currencies': 'offers',
    'Bills Requests': 'bill',
  };
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.secondaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'OVX Style',
          style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: MyColors.secondaryColor,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20),
        child: ListView.separated(
          itemCount: drawerItems.length,
          separatorBuilder: (context, index) => const SizedBox(
            height: 4,
          ),
          itemBuilder: (context, index) => Row(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 100),
                color: Colors.white,
                height: selectedIndex == index ? 55 : 0,
                width: 3,
              ),
              Expanded(
                child: Container(
                  color: selectedIndex == index ? MyColors.tabColor : MyColors.secondaryColor,
                  child: ListTile(
                    title: Text(
                      drawerItems.keys.toList()[index],
                      style: Constants.TEXT_STYLE4.copyWith(color: Colors.white,),
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: SvgPicture.asset('assets/images/${drawerItems.values.toList()[index]}.svg', color: Colors.white, fit: BoxFit.scaleDown,),
                    ),
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                        widget.pageController.animateToPage(selectedIndex, duration: Duration(milliseconds: 500), curve: Curves.linear);
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
