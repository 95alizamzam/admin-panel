import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/bloc.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/events.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/states.dart';
import 'package:marketing_admin_panel/models/product_offer_model.dart';
import 'package:marketing_admin_panel/utils/colors.dart';

class ProductOffer extends StatefulWidget {
  const ProductOffer({Key? key}) : super(key: key);

  @override
  State<ProductOffer> createState() => _ProductOfferState();
}

class _ProductOfferState extends State<ProductOffer> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<OfferBloc>(context)
        .add(FetchAllOffers('OfferType.Product'));
  }

  List<OneProductOfferModel> data = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfferBloc, OfferStates>(
      builder: (context, state) {
        print(state.toString());
        if (state is FetchOfferProductDoneState) {
          data = state.model.allProductsOffers;
          return Container(
            width: double.maxFinite,
            height: double.maxFinite,
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: MyColors.grey.withOpacity(0.1),
            ),
            child: ListView.separated(
              itemBuilder: (context, index) => OneProductOfferItem(
                model: data[index],
              ),
              separatorBuilder: (context, index) => SizedBox(height: 20),
              itemCount: data.length,
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        ;
      },
    );
  }
}

class OneProductOfferItem extends StatelessWidget {
  const OneProductOfferItem({Key? key, required this.model}) : super(key: key);

  final OneProductOfferModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Image(
            image: NetworkImage(model.offerMedia.first),
            width: 50,
            height: 50,
            fit: BoxFit.contain,
          ),
          Text(model.offerName),
          Text(model.discount.toString()),
        ],
      ),
    );
  }
}
