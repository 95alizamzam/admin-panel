abstract class OfferEvents {}

class FetchAllOffers extends OfferEvents {
  final String offerType;
  final String ownerType;
  FetchAllOffers(this.offerType, this.ownerType,);
}

class DeleteOffer extends OfferEvents {
  String offerId;
  String offerOwnerType;
  String offerType;
  String uId;

  DeleteOffer(this.offerId, this.offerOwnerType, this.offerType, this.uId);
}