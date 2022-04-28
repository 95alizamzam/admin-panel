
abstract class OfferStates {}

class FetchOfferInitialState extends OfferStates {}

class FetchOfferLoadingState extends OfferStates {}

class FetchOfferDoneState extends OfferStates {}

class FetchOfferFiledState extends OfferStates {
  String message;

  FetchOfferFiledState(this.message);
}

class DeleteOfferLoading extends OfferStates {}

class DeleteOfferSucceed extends OfferStates {}

class DeleteOfferFailed extends OfferStates {
  String message;

  DeleteOfferFailed(this.message);
}

