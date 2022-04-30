import 'package:marketing_admin_panel/models/comment_model.dart';
import 'package:marketing_admin_panel/utils/enums.dart';

abstract class OfferEvents {}

class FetchAllOffers extends OfferEvents {
  OfferType offerType;
  UserType ownerType;

  FetchAllOffers(this.offerType, this.ownerType,);
}

class FetchMoreOffers extends OfferEvents {
  OfferType offerType;
  UserType ownerType;
  String lastFetchedOffersId;

  FetchMoreOffers(this.offerType, this.ownerType, this.lastFetchedOffersId);
}

class DeleteOffer extends OfferEvents {
  String offerId;
  String offerOwnerType;
  String offerType;
  String uId;

  DeleteOffer(this.offerId, this.offerOwnerType, this.offerType, this.uId);
}

class DeleteComment extends OfferEvents {
  String offerId;
  String offerOwnerType;
  CommentModel comment;
  String offerType;

  DeleteComment(this.offerOwnerType, this.offerId, this.comment, this.offerType);
}

class FilterOffers extends OfferEvents {
  double minPrice;
  double maxPrice;
  String status;
  List<String> categories;
  List<String> countries;
  OfferType offerType;
  UserType userType;

  FilterOffers(this.minPrice, this.maxPrice, this.status, this.categories, this.countries, this.offerType, this.userType);
}