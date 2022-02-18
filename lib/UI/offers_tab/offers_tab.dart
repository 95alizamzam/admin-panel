import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing_admin_panel/UI/offers_tab/widgets/image_offers.dart';
import 'package:marketing_admin_panel/UI/offers_tab/widgets/product_offer.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/bloc.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/events.dart';
import 'package:marketing_admin_panel/utils/colors.dart';

class OffersTab extends StatefulWidget {
  const OffersTab({Key? key}) : super(key: key);

  @override
  State<OffersTab> createState() => _OffersTabState();
}

class _OffersTabState extends State<OffersTab> {
  int currentIndex = 0;

  List<Widget> content = [
    const ProductOffer(),
    const ImageOffer(),
  ];

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
            tabs: const [
              Tab(
                text: 'Products',
                icon: Icon(Icons.apps_rounded),
              ),
              Tab(
                icon: Icon(Icons.image),
                text: 'images offer',
              ),
              Tab(
                icon: Icon(Icons.video_collection_outlined),
                text: 'videos offer',
              ),
              Tab(
                icon: Icon(Icons.post_add_outlined),
                text: 'posts offer',
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
