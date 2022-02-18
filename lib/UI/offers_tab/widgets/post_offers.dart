import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/bloc.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/events.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/states.dart';
import 'package:marketing_admin_panel/models/image_offer_model.dart';
import 'package:marketing_admin_panel/utils/colors.dart';

class PostOffer extends StatefulWidget {
  const PostOffer({Key? key}) : super(key: key);

  @override
  State<PostOffer> createState() => _PostOfferState();
}

class _PostOfferState extends State<PostOffer> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<OfferBloc>(context).add(FetchAllOffers('OfferType.Post'));
  }

  List<OneImageOffer> data = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfferBloc, OfferStates>(
      builder: (context, state) {
        if (state is FetchOfferPostDoneState) {
          data = state.model.allImageOffers;
        }
        return Container(
          width: double.maxFinite,
          height: double.maxFinite,
          child: ListView.separated(
            itemBuilder: (context, index) => OfferPostItem(
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

class OfferPostItem extends StatelessWidget {
  const OfferPostItem({Key? key, required this.offer}) : super(key: key);

  final OneImageOffer offer;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: MyColors.grey.withOpacity(0.2),
      ),
      child: Row(
        children: [
          Text(offer.shortDesc!),
          Image(
            image: NetworkImage(offer.offerMedia[0]),
          )
        ],
      ),
    );
  }
}
