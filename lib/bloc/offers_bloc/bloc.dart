import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/events.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/states.dart';
import 'package:marketing_admin_panel/locator.dart';
import 'package:marketing_admin_panel/models/offers_model.dart';
import 'package:marketing_admin_panel/repositories/offers/offers_repo.dart';
import 'package:marketing_admin_panel/utils/enums.dart';

class OfferBloc extends Bloc<OfferEvents, OfferStates> {
  List<OneOfferModel> productOffers = [];
  List<OneOfferModel> imageOffers = [];
  List<OneOfferModel> videoOffers = [];
  List<OneOfferModel> postOffers = [];

  //in case many requests sent at same time
  bool alreadyFetchingMoreOffers = false;

  OfferBloc() : super(FetchOfferInitialState()) {
    on<OfferEvents>((event, emit) async {
      if (event is FetchAllOffers) {
        emit(FetchOfferLoadingState());
        try {
          switch (event.offerType) {
            case OfferType.Product:
              productOffers = await locator.get<OffersRepo>().getAllOffers(event.offerType, event.ownerType);
              break;
            case OfferType.Video:
              videoOffers = await locator.get<OffersRepo>().getAllOffers(event.offerType, event.ownerType);
              break;
            case OfferType.Image:
              imageOffers = await locator.get<OffersRepo>().getAllOffers(event.offerType, event.ownerType);
              break;
            case OfferType.Post:
              postOffers = await locator.get<OffersRepo>().getAllOffers(event.offerType, event.ownerType);
              break;
          }
          emit(FetchOfferDoneState());
        } catch (e) {
          emit(FetchOfferFiledState('Error, please try again'));
        }
      }
      else if (event is FetchMoreOffers && !alreadyFetchingMoreOffers) {
        alreadyFetchingMoreOffers = true;
        emit(FetchMoreOfferLoadingState());
        try {
          switch (event.offerType) {
            case OfferType.Product:
              final moreProductOffers =
                  await locator.get<OffersRepo>().getAllOffers(event.offerType, event.ownerType, lastFetchedOfferId: event.lastFetchedOffersId);
              productOffers.addAll(moreProductOffers);
              break;
            case OfferType.Video:
              final moreVideoOffers =
                  await locator.get<OffersRepo>().getAllOffers(event.offerType, event.ownerType, lastFetchedOfferId: event.lastFetchedOffersId);
              videoOffers.addAll(moreVideoOffers);
              break;
            case OfferType.Image:
              final moreImageOffers =
                  await locator.get<OffersRepo>().getAllOffers(event.offerType, event.ownerType, lastFetchedOfferId: event.lastFetchedOffersId);
              imageOffers.addAll(moreImageOffers);
              break;
            case OfferType.Post:
              final morePostOffers =
                  await locator.get<OffersRepo>().getAllOffers(event.offerType, event.ownerType, lastFetchedOfferId: event.lastFetchedOffersId);
              postOffers.addAll(morePostOffers);
              break;
          }
          alreadyFetchingMoreOffers = false;
          emit(FetchMoreOfferDoneState());
        } catch (e) {
          alreadyFetchingMoreOffers = false;
          emit(FetchMoreOfferFiledState('Error, please try again'));
        }
      } else if (event is DeleteOffer) {
        emit(DeleteOfferLoading());
        try {
          await locator.get<OffersRepo>().deleteOffer(event.offerId, event.offerOwnerType, event.uId);
          if (event.offerType == OfferType.Product.toString())
            productOffers.removeWhere((offer) => offer.id == event.offerId);
          else if (event.offerType == OfferType.Post.toString())
            postOffers.removeWhere((offer) => offer.id == event.offerId);
          else if (event.offerType == OfferType.Image.toString())
            imageOffers.removeWhere((offer) => offer.id == event.offerId);
          else if (event.offerType == OfferType.Video.toString()) videoOffers.removeWhere((offer) => offer.id == event.offerId);

          emit(DeleteOfferSucceed());
        } catch (e) {
          print(e);
          emit(DeleteOfferFailed('Error, please try again later'));
        }
      } else if (event is DeleteComment) {
        emit(DeleteCommentLoading());
        try {
          await locator.get<OffersRepo>().deleteComment(event.offerId, event.offerOwnerType, event.comment);

          //to update ui
          if (event.offerType == OfferType.Product.toString())
            productOffers.firstWhere((offer) => offer.id == event.offerId).comments!.removeWhere((comment) => comment.id == event.comment.id);
          else if (event.offerType == OfferType.Post.toString())
            postOffers.firstWhere((offer) => offer.id == event.offerId).comments!.removeWhere((comment) => comment.id == event.comment.id);
          else if (event.offerType == OfferType.Image.toString())
            imageOffers.firstWhere((offer) => offer.id == event.offerId).comments!.removeWhere((comment) => comment.id == event.comment.id);
          else if (event.offerType == OfferType.Video.toString())
            videoOffers.firstWhere((offer) => offer.id == event.offerId).comments!.removeWhere((comment) => comment.id == event.comment.id);

          emit(DeleteCommentSucceed());
        } catch (e) {
          print(e);
          emit(DeleteCommentFailed('Error, please try again later'));
        }
      } else if (event is FilterOffers) {
        emit(FilterOffersLoading());
        try {
          final offers = await locator.get<OffersRepo>().filterOffers(
                event.minPrice,
                event.maxPrice,
                event.categories,
                event.countries,
                event.status,
                event.userType,
                event.offerType,
              );

          //to update ui
          if (event.offerType == OfferType.Product)
            productOffers = offers;
          else if (event.offerType == OfferType.Post)
            postOffers = offers;
          else if (event.offerType == OfferType.Image)
            imageOffers = offers;
          else if (event.offerType == OfferType.Video)
            videoOffers = offers;

          emit(FilterOffersDone());
        } catch (e) {
          print(e);
          emit(FilterOffersFailed('Error, please try again later'));
        }
      }
    });
  }
}
