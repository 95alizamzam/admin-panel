import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/bloc.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/events.dart';

class OffersTab extends StatefulWidget {
  const OffersTab({Key? key}) : super(key: key);

  @override
  State<OffersTab> createState() => _OffersTabState();
}

class _OffersTabState extends State<OffersTab> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<OfferBloc>(context).add(FetchAllOffers());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('offers'),
    );
  }
}
