import 'package:flutter/material.dart';
import 'package:marketing_admin_panel/UI/offers_tab/widgets/likes_and_comments.dart';
import 'package:marketing_admin_panel/models/offers_model.dart';
import 'package:marketing_admin_panel/utils/constants.dart';
import 'package:marketing_admin_panel/utils/navigator/named_routes.dart';
import 'package:marketing_admin_panel/utils/navigator/navigator_imp.dart';

import 'owner_row.dart';

class PostDetailsScreen extends StatelessWidget {
  const PostDetailsScreen({Key? key, required this.navigator, required this.post}) : super(key: key);

  final navigator;
  final OnePostModel post;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          OwnerRow(id: post.offerOwnerId),
          Container(
            height: screenHeight * 0.4,
            child: Center(
              child: Container(
                width: screenWidth * 0.5,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: post.offerMedia!.length,
                  itemBuilder: (ctx, i) => Stack(
                    children: [
                      Container(
                        width: screenWidth * 0.5,
                        child: GestureDetector(
                          onTap: () {
                            NavigatorImpl().push(NamedRoutes.IMAGE_SCREEN, arguments: {'imageUrl': post.offerMedia![i], 'heroTag': 'image$i'});
                          },
                          child: Hero(
                            tag: 'image$i',
                            child: Image.network(
                              post.offerMedia![i],
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
                            '${i + 1} / ${post.offerMedia!.length}',
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: Text(
              post.shortDesc!,
              style: Constants.TEXT_STYLE4,
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          LikesAndComments(
            likes: post.likes,
            comments: post.comments ?? [],
            offerOwnerType: post.offerOwnerType!,
            offerId: post.id!,
            offerType: post.offerType!,
          ),
        ],
      ),
    );
  }
}
