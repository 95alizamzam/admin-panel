import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:marketing_admin_panel/bloc/offers_bloc/bloc.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/events.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/states.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/constants.dart';
import 'package:marketing_admin_panel/utils/navigator/named_routes.dart';
import 'package:marketing_admin_panel/utils/navigator/navigator_imp.dart';

class ProductOffer extends StatefulWidget {
  final offerOwnerType;
  const ProductOffer({Key? key, required this.offerOwnerType}) : super(key: key);

  @override
  State<ProductOffer> createState() => _ProductOfferState();
}

class _ProductOfferState extends State<ProductOffer> {
  @override
  void initState() {
    BlocProvider.of<OfferBloc>(context)
        .add(FetchAllOffers('OfferType.Product', widget.offerOwnerType));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OfferBloc, OfferStates>(
      listener: (ctx, state) {
        if (state is DeleteOfferLoading)
          EasyLoading.show(status: 'Please wait');
        else if (state is DeleteOfferFailed)
          EasyLoading.showError(state.message);
        else if (state is DeleteOfferSucceed)
          EasyLoading.showSuccess('Offer Deleted');
      },
      builder: (ctx, state) {
        if (state is FetchOfferLoadingState || state is FetchOfferInitialState)
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
        else {
          final productOffers = context.read<OfferBloc>().offers.productOffers;
          return Container(
            padding: const EdgeInsets.only(left: 18, right: 18, top: 12),
            child: ListView.separated(
                itemBuilder: (ctx, index) => InkWell(
                      onTap: () {
                        NavigatorImpl().push(NamedRoutes.PRODUCT_DETAILS_SCREEN,
                            arguments: {
                              'product': productOffers[index],
                            });
                      },
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              productOffers[index].offerMedia.first,
                              height: 70,
                              width: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                productOffers[index].offerName,
                                style: Constants.TEXT_STYLE4,
                              ),
                              subtitle: Text(
                                DateFormat('dd MMM yyyy').format(
                                    productOffers[index].offerCreationDate!),
                              ),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
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
                                    style: Constants.TEXT_STYLE4
                                        .copyWith(color: Colors.red),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        NavigatorImpl().pop(result: true);
                                      },
                                      child: Text(
                                        'Yes',
                                        style: TextStyle(
                                            color: MyColors.secondaryColor),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        NavigatorImpl().pop(result: false);
                                      },
                                      child: Text(
                                        'No',
                                        style: TextStyle(
                                            color: MyColors.secondaryColor),
                                      ),
                                    ),
                                  ],
                                ),
                              );

                              if (b)
                                BlocProvider.of<OfferBloc>(context).add(
                                  DeleteOffer(
                                    productOffers[index].id!,
                                    productOffers[index].offerOwnerType,
                                    productOffers[index].offerType,
                                    productOffers[index].offerOwnerId,
                                  ),
                                );
                            },
                            child: SvgPicture.asset(
                              'assets/images/trash.svg',
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ],
                      ),
                    ),
                separatorBuilder: (ctx, index) => const SizedBox(
                      height: 8,
                    ),
                itemCount: productOffers.length),
          );
        }
      },
    );
  }
}
