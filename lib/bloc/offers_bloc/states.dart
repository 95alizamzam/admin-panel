
abstract class OfferStates {}

class FetchOfferInitialState extends OfferStates {}

class FetchOfferLoadingState extends OfferStates {}

class FetchOfferDoneState extends OfferStates {}

class FetchOfferFiledState extends OfferStates {
  String message;

  FetchOfferFiledState(this.message);
}

class FetchMoreOfferLoadingState extends OfferStates {}

class FetchMoreOfferDoneState extends OfferStates {}

class FetchMoreOfferFiledState extends OfferStates {
  String message;

  FetchMoreOfferFiledState(this.message);
}

class DeleteOfferLoading extends OfferStates {}

class DeleteOfferSucceed extends OfferStates {}

class DeleteOfferFailed extends OfferStates {
  String message;

  DeleteOfferFailed(this.message);
}

class DeleteCommentLoading extends OfferStates {}

class DeleteCommentSucceed extends OfferStates {}

class DeleteCommentFailed extends OfferStates {
  String message;

  DeleteCommentFailed(this.message);
}

class FilterOffersLoading extends OfferStates {}

class FilterOffersDone extends OfferStates {}

class FilterOffersFailed extends OfferStates {
  String message;

  FilterOffersFailed(this.message);
}