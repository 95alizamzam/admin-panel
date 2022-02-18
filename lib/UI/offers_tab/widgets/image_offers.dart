import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/bloc.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/events.dart';

class ImageOffer extends StatefulWidget {
  const ImageOffer({Key? key}) : super(key: key);

  @override
  State<ImageOffer> createState() => _ImageOfferState();
}

class _ImageOfferState extends State<ImageOffer> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<OfferBloc>(context).add(FetchAllOffers('OfferType.Image'));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
