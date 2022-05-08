import 'package:flutter/cupertino.dart';
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
  static Map<String, Widget> drawerItems = {
    'Users': SvgPicture.asset('assets/images/person.svg', color: Colors.white, fit: BoxFit.scaleDown,),
    'Companies':  SvgPicture.asset('assets/images/person.svg', color: Colors.white, fit: BoxFit.scaleDown,),
    'Categories':  SvgPicture.asset('assets/images/category.svg', color: Colors.white, fit: BoxFit.scaleDown,),
    'Offers':  SvgPicture.asset('assets/images/offers.svg', color: Colors.white, fit: BoxFit.scaleDown,),
    'C.Offers':  SvgPicture.asset('assets/images/offers.svg', color: Colors.white, fit: BoxFit.scaleDown,),
    'Currencies': Icon(CupertinoIcons.money_dollar_circle, color: Colors.white,),
    'Bills Requests': Icon(Icons.description, color: Colors.white,),
    'Packages': SvgPicture.asset('assets/images/offers.svg', color: Colors.white, fit: BoxFit.scaleDown,),
    'Stories': SvgPicture.asset('assets/images/story.svg', color: Colors.white, fit: BoxFit.scaleDown,),
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
                      child: drawerItems.values.toList()[index],
                    ),
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                        widget.pageController.jumpToPage(selectedIndex);
                        //widget.pageController.animateToPage(selectedIndex, duration: Duration(milliseconds: 500), curve: Curves.linear);
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
