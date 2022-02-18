import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/events.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/states.dart';

import 'package:marketing_admin_panel/locator.dart';
import 'package:marketing_admin_panel/repositories/offers/offers_repo.dart';

class OfferBloc extends Bloc<OfferEvents, OfferStates> {
  OfferBloc() : super(OfferInitialState()) {
    on<OfferEvents>((event, emit) async {
      if (event is FetchAllOffers) {
        emit(OfferLoadingState());
        try {
          final data = await locator.get<OffersRepo>().getAllOffers(event.type);

          if (event.type.trim() == 'OfferType.Image') {
            print(data.docs[0].data());
          }
          if (event.type.trim() == 'OfferType.Product') {
            print(data.docs[0].data());
          }
          if (event.type.trim() == 'OfferType.Image') {
            print(data.docs[0].data());
          }
          if (event.type.trim() == 'OfferType.Image') {
            print(data.docs[0].data());
          }
        } catch (e) {
          print(e.toString());
          emit(OfferFiledState());
        }
      }
    });
  }
}
