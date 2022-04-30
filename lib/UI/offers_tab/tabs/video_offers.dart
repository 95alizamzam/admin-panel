import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/bloc.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/events.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/states.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/constants.dart';
import 'package:marketing_admin_panel/utils/enums.dart';
import 'package:marketing_admin_panel/utils/modal_sheets.dart';
import 'package:marketing_admin_panel/utils/navigator/named_routes.dart';
import 'package:marketing_admin_panel/utils/navigator/navigator_imp.dart';
import 'package:video_player/video_player.dart';
import 'package:intl/intl.dart' show DateFormat;

class VideoOffer extends StatefulWidget {
  final offerOwnerType;
  const VideoOffer({Key? key, required this.offerOwnerType}) : super(key: key);

  @override
  State<VideoOffer> createState() => _VideoOfferState();
}

class _VideoOfferState extends State<VideoOffer> {
  ScrollController _scrollController = ScrollController();
  String _lastFetchedOfferId = '';

  @override
  void initState() {
    context.read<OfferBloc>().add(FetchAllOffers(OfferType.Video, widget.offerOwnerType));
    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
        context.read<OfferBloc>().add(FetchMoreOffers(OfferType.Video, widget.offerOwnerType, _lastFetchedOfferId));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<OfferBloc, OfferStates>(
      listener: (ctx, state) {
        if (state is DeleteOfferLoading)
          EasyLoading.show(status: 'Please wait');
        else if (state is DeleteOfferFailed)
          EasyLoading.showError(state.message);
        else if (state is DeleteOfferSucceed) EasyLoading.showSuccess('Offer Deleted');
      },
      builder: (ctx, state) {
        if (state is FetchOfferLoadingState || state is FetchOfferInitialState || state is FetchMoreOfferLoadingState || state is FilterOffersLoading)
          return Center(
            child: CircularProgressIndicator(
              color: MyColors.secondaryColor,
            ),
          );
        else if (state is FetchOfferFiledState)
          return Center(
            child: Text(
              state.message,
              style: Constants.TEXT_STYLE9,
            ),
          );
        else if (state is FilterOffersFailed)
          return Center(
            child: Text(
              state.message,
              style: Constants.TEXT_STYLE9,
            ),
          );
        else if (state is FetchMoreOfferFiledState)
          return Center(
            child: Text(
              state.message,
              style: Constants.TEXT_STYLE9,
            ),
          );
        else {
          final videoOffers = context.read<OfferBloc>().videoOffers;
          if (videoOffers.isEmpty)
            return Center(
              child: Text(
                'No offers yet',
                style: Constants.TEXT_STYLE4,
              ),
            );
          else {
            _lastFetchedOfferId = videoOffers.last.id!;
            return Container(
              padding: const EdgeInsets.only(top: 12),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        ModalSheets().showOfferFilter(context, widget.offerOwnerType, OfferType.Video);
                      },
                      icon: SvgPicture.asset(
                        'assets/images/filter.svg',
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      controller: _scrollController,
                        itemBuilder: (ctx, index) => InkWell(
                              onTap: () {
                                NavigatorImpl().push(NamedRoutes.VIDEO_DETAILS_SCREEN, arguments: {
                                  'video': videoOffers[index],
                                });
                              },
                              child: Container(
                                height: screenHeight * 0.3,
                                color: MyColors.lightGrey.withOpacity(0.2),
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Container(
                                        //width: screenWidth * 0.4,
                                        child: OfferVideoItem(
                                          offer: videoOffers[index],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 12,
                                      right: 12,
                                      child: Text(
                                        DateFormat('dd MMM yyyy').format(
                                          videoOffers[index].offerCreationDate!,
                                        ),
                                        style: Constants.TEXT_STYLE6,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 12,
                                      right: 12,
                                      child: GestureDetector(
                                        onTap: () async {
                                          bool b = await showDialog(
                                            context: context,
                                            builder: (ctx) => AlertDialog(
                                              title: Text(
                                                'Are you sure?',
                                                style: Constants.TEXT_STYLE8,
                                              ),
                                              content: Text(
                                                'Offer and its data will be deleted',
                                                style: Constants.TEXT_STYLE4.copyWith(color: Colors.red),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    NavigatorImpl().pop(result: true);
                                                  },
                                                  child: Text(
                                                    'Yes',
                                                    style: TextStyle(color: MyColors.secondaryColor),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    NavigatorImpl().pop(result: false);
                                                  },
                                                  child: Text(
                                                    'No',
                                                    style: TextStyle(color: MyColors.secondaryColor),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );

                                          if (b)
                                            BlocProvider.of<OfferBloc>(context).add(
                                              DeleteOffer(
                                                videoOffers[index].id!,
                                                videoOffers[index].offerOwnerType!,
                                                videoOffers[index].offerType!,
                                                videoOffers[index].offerOwnerId!,
                                              ),
                                            );
                                        },
                                        child: SvgPicture.asset(
                                          'assets/images/trash.svg',
                                          fit: BoxFit.scaleDown,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        separatorBuilder: (ctx, index) => const SizedBox(
                              height: 8,
                            ),
                        itemCount: videoOffers.length),
                  ),
                  state is FetchMoreOfferLoadingState
                      ? RefreshProgressIndicator(
                          color: MyColors.secondaryColor,
                        )
                      : state is FetchMoreOfferFiledState
                          ? Center(
                              child: Text(
                                state.message,
                                style: Constants.TEXT_STYLE6,
                              ),
                            )
                          : Container(),
                ],
              ),
            );
          }
        }
      },
    );
  }
}

class OfferVideoItem extends StatefulWidget {
  const OfferVideoItem({Key? key, required this.offer}) : super(key: key);

  final offer;

  @override
  State<OfferVideoItem> createState() => _OfferVideoItemState();
}

class _OfferVideoItemState extends State<OfferVideoItem> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  void checkVideo() {
    // Implement your calls inside these conditions' bodies :
    if (_controller.value.position == Duration(seconds: 0, minutes: 0, hours: 0)) {
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      // margin: EdgeInsets.all(20),
      // alignment: Alignment.center,
      // padding: EdgeInsets.all(20),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(15),
      //   color: MyColors.grey.withOpacity(0.1),
      // ),
      child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: screenHeight * 0.3,
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _controller.value.isPlaying ? Icons.pause_circle_outline : Icons.play_circle_outline,
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
              return Center(
                  child: CircularProgressIndicator(
                color: MyColors.secondaryColor,
              ));
            }
          }),
    );
  }
}
