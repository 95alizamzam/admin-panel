import 'package:flutter/material.dart';
import 'package:marketing_admin_panel/UI/offers_tab/owner_row.dart';
import 'package:marketing_admin_panel/UI/offers_tab/widgets/likes_and_comments.dart';
import 'package:marketing_admin_panel/models/offers_model.dart';
import 'package:marketing_admin_panel/utils/constants.dart';
import 'package:marketing_admin_panel/utils/navigator/named_routes.dart';
import 'package:marketing_admin_panel/utils/navigator/navigator_imp.dart';

class ImageDetailsScreen extends StatelessWidget {
  const ImageDetailsScreen({Key? key, required this.navigator, required this.offer}) : super(key: key);

  final navigator;
  final OneImageModel offer;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          OwnerRow(id: offer.offerOwnerId),
          Container(
            height: screenHeight * 0.4,
            child: Center(
              child: Container(
                width: screenWidth * 0.5,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: offer.offerMedia!.length,
                  itemBuilder: (ctx, i) => Stack(
                    children: [
                      Container(
                        width: screenWidth * 0.5,
                        child: GestureDetector(
                          onTap: () {
                            NavigatorImpl().push(NamedRoutes.IMAGE_SCREEN, arguments: {'imageUrl': offer.offerMedia![i], 'heroTag': 'image$i'});
                          },
                          child: Hero(
                            tag: 'image$i',
                            child: Image.network(
                              offer.offerMedia![i],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Chip(
                          label: Text(
                            '${i + 1} / ${offer.offerMedia!.length}',
                            style: Constants.TEXT_STYLE6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          LikesAndComments(
            likes: offer.likes,
            comments: offer.comments ?? [],
            offerId: offer.id!,
            offerOwnerType: offer.offerOwnerType!,
            offerType: offer.offerType!,
          ),
        ],
      ),
    );
  }
}
