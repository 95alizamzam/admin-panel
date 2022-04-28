
class CurrenciesEvent {}

class GetCurrencies extends CurrenciesEvent {}

class ChangeCurrencyValue extends CurrenciesEvent {
  String currencyName;
  double currencyNewValue;

  ChangeCurrencyValue(this.currencyName, this.currencyNewValue);
}

class DeleteCurrencyValue extends CurrenciesEvent {
  String currencyName;

  DeleteCurrencyValue(this.currencyName);
}

class AddCurrency extends CurrenciesEvent {
  String currencyName;
  double currencyValue;

  AddCurrency(this.currencyName, this.currencyValue);
}