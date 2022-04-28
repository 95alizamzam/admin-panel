import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/events.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/states.dart';
import 'package:marketing_admin_panel/locator.dart';
import 'package:marketing_admin_panel/models/offers_model.dart';
import 'package:marketing_admin_panel/repositories/offers/offers_repo.dart';

class OfferBloc extends Bloc<OfferEvents, OfferStates> {
  late OffersModel offers;
  OfferBloc() : super(FetchOfferInitialState()) {
    on<OfferEvents>((event, emit) async {
      if (event is FetchAllOffers) {
        emit(FetchOfferLoadingState());
        try {
          final data = await locator.get<OffersRepo>().getAllOffers(event.offerType, event.ownerType);
          offers = OffersModel.fromJson(data.docs);
          emit(FetchOfferDoneState());
        } catch (e) {
          print(e.toString() + 'pppppppp');
          emit(FetchOfferFiledState('Error, please try again'));
        }
      } else if(event is DeleteOffer){
        emit(DeleteOfferLoading());
        try{
          await locator.get<OffersRepo>().deleteOffer(event.offerId, event.offerOwnerType, event.uId);
          if(event.offerType == 'OfferType.Product')
            offers.productOffers.removeWhere((offer) => offer.id == event.offerId);
          else if(event.offerType == 'OfferType.Post')
            offers.postOffers.removeWhere((offer) => offer.id == event.offerId);
          else if(event.offerType == 'OfferType.Image')
            offers.imageOffers.removeWhere((offer) => offer.id == event.offerId);
          else if(event.offerType == 'OfferType.Video')
            offers.videoOffers.removeWhere((offer) => offer.id == event.offerId);

          emit(DeleteOfferSucceed());
        } catch (e){
          print(e);
          emit(DeleteOfferFailed('Error, please try again later'));
        }
      }
    });
  }
}
