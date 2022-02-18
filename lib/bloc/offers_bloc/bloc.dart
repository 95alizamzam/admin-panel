import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/events.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/states.dart';

import 'package:marketing_admin_panel/locator.dart';
import 'package:marketing_admin_panel/models/image_offer_model.dart';
import 'package:marketing_admin_panel/models/product_offer_model.dart';
import 'package:marketing_admin_panel/repositories/offers/offers_repo.dart';

class OfferBloc extends Bloc<OfferEvents, OfferStates> {
  OfferBloc() : super(FetchOfferInitialState()) {
    on<OfferEvents>((event, emit) async {
      if (event is FetchAllOffers) {
        emit(FetchOfferLoadingState());
        try {
          final data = await locator.get<OffersRepo>().getAllOffers(event.type);

          if (event.type.trim() == 'OfferType.Image') {
            ImagesOffer model = ImagesOffer.fromJson(data.docs);
            emit(FetchOfferImagesDoneState(model));
          }
          if (event.type.trim() == 'OfferType.Post') {
            ImagesOffer model = ImagesOffer.fromJson(data.docs);
            emit(FetchOfferPostDoneState(model));
          }
          if (event.type.trim() == 'OfferType.Video') {
            ImagesOffer model = ImagesOffer.fromJson(data.docs);
            emit(FetchOfferVideoDoneState(model));
          }
          if (event.type.trim() == 'OfferType.Product') {
            ProductsOffersModel model = ProductsOffersModel.fromJson(data.docs);
            emit(FetchOfferProductDoneState(model));
          }
        } catch (e) {
          print(e.toString());
          emit(FetchOfferFiledState());
        }
      }
    });
  }
}
