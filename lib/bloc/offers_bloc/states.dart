import 'package:marketing_admin_panel/models/usersModel.dart';

abstract class OfferStates {}

class OfferInitialState extends OfferStates {}

class OfferLoadingState extends OfferStates {}

class OfferDoneState extends OfferStates {}

class OfferFiledState extends OfferStates {}
