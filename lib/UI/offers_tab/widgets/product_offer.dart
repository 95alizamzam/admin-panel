import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/bloc.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/events.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
