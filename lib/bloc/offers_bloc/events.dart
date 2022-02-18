abstract class OfferEvents {}

class FetchAllOffers extends OfferEvents {
  final String type;
  FetchAllOffers(this.type);
}
