
class CurrenciesState {}

class CurrenciesInitialState extends CurrenciesState {}

class GetCurrenciesLoading extends CurrenciesState {}

class GetCurrenciesSuccess extends CurrenciesState {}

class GetCurrenciesFailed extends CurrenciesState {
  String message;

  GetCurrenciesFailed(this.message);
}

class ChangeCurrencyLoading extends CurrenciesState {}

class ChangeCurrencySuccess extends CurrenciesState {}

class ChangeCurrencyFailed extends CurrenciesState {
  String message;

  ChangeCurrencyFailed(this.message);
}

class DeleteCurrencyLoading extends CurrenciesState {}

class DeleteCurrencySuccess extends CurrenciesState {}

class DeleteCurrencyFailed extends CurrenciesState {
  String message;

  DeleteCurrencyFailed(this.message);
}

class AddCurrencyLoading extends CurrenciesState {}

class AddCurrencySuccess extends CurrenciesState {}

class AddCurrencyFailed extends CurrenciesState {
  String message;

  AddCurrencyFailed(this.message);
}