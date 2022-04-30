import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marketing_admin_panel/UI/shared_widgets/custom_button.dart';
import 'package:marketing_admin_panel/utils/constants.dart';
import 'package:marketing_admin_panel/utils/navigator/navigator_imp.dart';
import '../tabs/post_offers.dart';
import '../tabs/product_offer.dart';
import '../tabs/video_offers.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/enums.dart';

import '../tabs/image_offers.dart';

class OffersBar extends StatefulWidget {
  final UserType offerOwnerType;

  OffersBar({required this.offerOwnerType});

  @override
  _OffersBarState createState() => _OffersBarState();
}

class _OffersBarState extends State<OffersBar> {
  late List<Widget> content;
  PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    content = [
      ProductOffer(
        offerOwnerType: widget.offerOwnerType,
      ),
      ImageOffer(
        offerOwnerType: widget.offerOwnerType,
      ),
      PostOffer(
        offerOwnerType: widget.offerOwnerType,
      ),
      VideoOffer(
        offerOwnerType: widget.offerOwnerType,
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 10,
          bottom: TabBar(
            onTap: (index) {
              _pageController.jumpToPage(index);
            },
            automaticIndicatorColorAdjustment: true,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: MyColors.secondaryColor,
            labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            tabs: [
              Tab(
                text: 'Products',
                icon: SvgPicture.asset(
                  'assets/images/product.svg',
                  fit: BoxFit.scaleDown,
                  color: MyColors.secondaryColor,
                ),
              ),
              Tab(
                icon: SvgPicture.asset(
                  'assets/images/image.svg',
                  fit: BoxFit.scaleDown,
                  color: MyColors.secondaryColor,
                ),
                text: 'Images',
              ),
              Tab(
                icon: SvgPicture.asset(
                  'assets/images/post.svg',
                  fit: BoxFit.scaleDown,
                  color: MyColors.secondaryColor,
                ),
                text: 'Posts',
              ),
              Tab(
                icon: SvgPicture.asset(
                  'assets/images/video.svg',
                  fit: BoxFit.scaleDown,
                  color: MyColors.secondaryColor,
                ),
                text: 'Videos',
              ),
            ],
            indicator: const BoxDecoration(
              color: MyColors.lightGrey,
            ),
          ),
        ),
        // body: content[currentIndex],
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: content,
        ),
      ),
    );
  }
}
