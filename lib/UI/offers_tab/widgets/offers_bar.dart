import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marketing_admin_panel/UI/offers_tab/widgets/post_offers.dart';
import 'package:marketing_admin_panel/UI/offers_tab/widgets/product_offer.dart';
import 'package:marketing_admin_panel/UI/offers_tab/widgets/video_offers.dart';
import 'package:marketing_admin_panel/utils/colors.dart';

import 'image_offers.dart';

class OffersBar extends StatefulWidget {
  final String offerOwnerType;

  OffersBar({required this.offerOwnerType});

  @override
  _OffersBarState createState() => _OffersBarState();
}

class _OffersBarState extends State<OffersBar> {
  int currentIndex = 0;

  late List<Widget> content;

  @override
  void initState() {
    content = [
      ProductOffer(offerOwnerType: widget.offerOwnerType,),
      ImageOffer(offerOwnerType: widget.offerOwnerType,),
      PostOffer(offerOwnerType: widget.offerOwnerType,),
      VideoOffer(offerOwnerType: widget.offerOwnerType,),
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
              setState(() => currentIndex = index);
            },
            automaticIndicatorColorAdjustment: true,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: MyColors.primaryColor,
            unselectedLabelColor: MyColors.secondaryColor,
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
                  color: currentIndex == 0 ? Colors.white : MyColors.secondaryColor,
                ),
              ),
              Tab(
                icon: SvgPicture.asset(
                  'assets/images/image.svg',
                  fit: BoxFit.scaleDown,
                  color: currentIndex == 1 ? Colors.white : MyColors.secondaryColor,
                ),
                text: 'Images',
              ),
              Tab(
                icon: SvgPicture.asset('assets/images/post.svg',
                  fit: BoxFit.scaleDown,
                  color: currentIndex == 2 ? Colors.white : MyColors.secondaryColor,
                ),
                text: 'Posts',
              ),
              Tab(
                icon: SvgPicture.asset(
                  'assets/images/video.svg',
                  fit: BoxFit.scaleDown,
                  color: currentIndex == 3 ? Colors.white : MyColors.secondaryColor,
                ),
                text: 'Videos',
              ),
            ],
            indicator: const BoxDecoration(
              color: MyColors.secondaryColor,
            ),
          ),
        ),
        body: content[currentIndex],
      ),
    );
  }
}
