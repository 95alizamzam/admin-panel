import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/bloc.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/events.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/states.dart';
import 'package:marketing_admin_panel/models/offers_model.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/constants.dart';
import 'package:marketing_admin_panel/utils/enums.dart';
import 'package:marketing_admin_panel/utils/modal_sheets.dart';
import 'package:marketing_admin_panel/utils/navigator/named_routes.dart';
import 'package:marketing_admin_panel/utils/navigator/navigator_imp.dart';
import 'package:intl/intl.dart' show DateFormat;

class PostOffer extends StatefulWidget {
  final offerOwnerType;
  const PostOffer({Key? key, required this.offerOwnerType}) : super(key: key);

  @override
  State<PostOffer> createState() => _PostOfferState();
}

class _PostOfferState extends State<PostOffer> {
  ScrollController _scrollController = ScrollController();
  String _lastFetchedOfferId = '';

  @override
  void initState() {
    context.read<OfferBloc>().add(FetchAllOffers(OfferType.Post, widget.offerOwnerType));
    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
        context.read<OfferBloc>().add(FetchMoreOffers(OfferType.Post, widget.offerOwnerType, _lastFetchedOfferId));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
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
        else if (state is FetchMoreOfferFiledState)
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
        else {
          final postOffers = context.read<OfferBloc>().postOffers;
          if (postOffers.isEmpty)
            return Center(
              child: Text(
                'No offers yet',
                style: Constants.TEXT_STYLE4,
              ),
            );
          else{
            _lastFetchedOfferId = postOffers.last.id!;
            return Container(
              padding: const EdgeInsets.only(top: 12),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        ModalSheets().showOfferFilter(context, widget.offerOwnerType, OfferType.Post);
                      },
                      icon: SvgPicture.asset(
                        'assets/images/filter.svg',
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                        controller: _scrollController,
                        itemBuilder: (ctx, index) {
                          OnePostModel onePostModel = postOffers[index] as OnePostModel;

                          return InkWell(
                            onTap: () {
                              NavigatorImpl().push(NamedRoutes.POST_DETAILS_SCREEN, arguments: {
                                'post': postOffers[index],
                              });
                            },
                            child: Container(
                              height: screenHeight * 0.3,
                              color: MyColors.lightGrey.withOpacity(0.2),
                              child: Stack(
                                children: [
                                  Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        if (onePostModel.shortDesc != null && onePostModel.shortDesc!.isNotEmpty)
                                          Expanded(
                                            child: SingleChildScrollView(
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 12),
                                                child: Text(
                                                  onePostModel.shortDesc!,
                                                  softWrap: true,
                                                  textAlign: TextAlign.left,
                                                  overflow: TextOverflow.fade,
                                                  style: Constants.TEXT_STYLE4,
                                                ),
                                              ),
                                            ),
                                          ),
                                        if (onePostModel.shortDesc != null && onePostModel.shortDesc!.isNotEmpty) Spacer(),
                                        Container(
                                          width: screenWidth * 0.4,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: postOffers[index].offerMedia!.length,
                                            itemBuilder: (ctx, i) => Stack(
                                              children: [
                                                Container(
                                                  width: screenWidth * 0.4,
                                                  child: Image.network(
                                                    postOffers[index].offerMedia![i],
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 10,
                                                  right: 10,
                                                  child: Chip(
                                                    label: Text(
                                                      '${i + 1} / ${postOffers[index].offerMedia!.length}',
                                                      style: Constants.TEXT_STYLE6,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 12,
                                    right: 12,
                                    child: Text(
                                      DateFormat('dd MMM yyyy').format(
                                        postOffers[index].offerCreationDate!,
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
                                              postOffers[index].id!,
                                              postOffers[index].offerOwnerType!,
                                              postOffers[index].offerType!,
                                              postOffers[index].offerOwnerId!,
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
                          );
                        },
                        separatorBuilder: (ctx, index) => const SizedBox(
                          height: 8,
                        ),
                        itemCount: postOffers.length),
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
