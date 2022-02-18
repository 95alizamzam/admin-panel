import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/bloc.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/events.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/states.dart';
import 'package:marketing_admin_panel/models/image_offer_model.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:video_player/video_player.dart';

class VideoOffer extends StatefulWidget {
  const VideoOffer({Key? key}) : super(key: key);

  @override
  State<VideoOffer> createState() => _VideoOfferState();
}

class _VideoOfferState extends State<VideoOffer> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<OfferBloc>(context).add(FetchAllOffers('OfferType.Video'));
  }

  List<OneImageOffer> data = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfferBloc, OfferStates>(
      builder: (context, state) {
        if (state is FetchOfferVideoDoneState) {
          data = state.model.allImageOffers;
        }
        return Container(
          width: double.maxFinite,
          height: double.maxFinite,
          child: ListView.separated(
            itemBuilder: (context, index) => OfferVideoItem(
              offer: data[index],
            ),
            separatorBuilder: (context, index) => SizedBox(height: 10),
            itemCount: data.length,
          ),
        );
      },
    );
  }
}

class OfferVideoItem extends StatefulWidget {
  const OfferVideoItem({Key? key, required this.offer}) : super(key: key);

  final OneImageOffer offer;

  @override
  State<OfferVideoItem> createState() => _OfferVideoItemState();
}

class _OfferVideoItemState extends State<OfferVideoItem> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  void checkVideo() {
    // Implement your calls inside these conditions' bodies :
    if (_controller.value.position ==
        Duration(seconds: 0, minutes: 0, hours: 0)) {
      print('video Started');
    }

    if (_controller.value.position == _controller.value.duration) {
      print('video Ended');
      setState(() {});
    }
  }

  void playVideo() {
    _controller = VideoPlayerController.network(widget.offer.offerMedia.first);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.addListener(checkVideo);
  }

  @override
  void initState() {
    super.initState();
    playVideo();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      alignment: Alignment.center,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: MyColors.grey.withOpacity(0.1),
      ),
      child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 100,
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause_circle_outline
                          : Icons.play_circle_outline,
                      size: 35,
                      color: MyColors.primaryColor,
                    ),
                    onPressed: () {
                      setState(() {
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        } else {
                          _controller.play();
                        }
                      });
                    },
                  ),
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
