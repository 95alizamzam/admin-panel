import 'package:marketing_admin_panel/models/image_offer_model.dart';
import 'package:marketing_admin_panel/models/product_offer_model.dart';
import 'package:marketing_admin_panel/models/usersModel.dart';

abstract class OfferStates {}

class FetchOfferInitialState extends OfferStates {}

class FetchOfferLoadingState extends OfferStates {}

class FetchOfferImagesDoneState extends OfferStates {
  final ImagesOffer model;
  FetchOfferImagesDoneState(this.model);
}

class FetchOfferPostDoneState extends OfferStates {
  final ImagesOffer model;
  FetchOfferPostDoneState(this.model);
}

class FetchOfferProductDoneState extends OfferStates {
  final ProductsOffersModel model;
  FetchOfferProductDoneState(this.model);
}

class FetchOfferVideoDoneState extends OfferStates {
  final ImagesOffer model;
  FetchOfferVideoDoneState(this.model);
}

class FetchOfferFiledState extends OfferStates {}
