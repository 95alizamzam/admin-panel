import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/events.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/states.dart';
import 'package:marketing_admin_panel/bloc/userbloc/events.dart';
import 'package:marketing_admin_panel/bloc/userbloc/states.dart';
import 'package:marketing_admin_panel/locator.dart';
import 'package:marketing_admin_panel/models/usersModel.dart';
import 'package:marketing_admin_panel/repositories/offers/offers_repo.dart';
import 'package:marketing_admin_panel/repositories/users/user_repo.dart';
import 'dart:convert';

class OfferBloc extends Bloc<OfferEvents, OfferStates> {
  OfferBloc() : super(OfferInitialState()) {
    on<OfferEvents>((event, emit) async {
      if (event is FetchAllOffers) {
        emit(OfferLoadingState());

        try {
          final data = await locator.get<OffersRepo>().getAllOffers();

          //UsersModel model = UsersModel.fromJson(data.docs);
          print(data.docs[0].data());
          //emit(OfferDoneState(model));
        } catch (e) {
          print(e.toString());
          emit(OfferFiledState());
        }
      }
    });
  }
}
