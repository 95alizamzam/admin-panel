import 'package:flutter/material.dart';
import 'package:marketing_admin_panel/UI/offers_tab/widgets/likes_and_comments.dart';
import 'package:marketing_admin_panel/UI/offers_tab/widgets/video_offers.dart';
import 'package:marketing_admin_panel/models/offers_model.dart';

import 'owner_row.dart';

class VideoDetailsScreen extends StatelessWidget {
  const VideoDetailsScreen(
      {Key? key, required this.navigator, required this.video})
      : super(key: key);

  final navigator;
  final OneVideoModel video;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          OwnerRow(id: video.offerOwnerId),
          Container(
            height: screenHeight * 0.4,
            child: Center(
              child: Container(
                //width: screenWidth * 0.5,
                child: OfferVideoItem(offer: video,),
              ),
            ),
          ),
          const SizedBox(height: 18,),
          LikesAndComments(likes: video.likes, comments: video.comments),
        ],
      ),
    );
  }
}
