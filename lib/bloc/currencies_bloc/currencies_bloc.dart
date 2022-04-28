import 'package:bloc/bloc.dart';
import 'package:marketing_admin_panel/bloc/currencies_bloc/currencies_events.dart';
import 'package:marketing_admin_panel/bloc/currencies_bloc/currencies_states.dart';
import 'package:marketing_admin_panel/repositories/currencies/currencies_repo.dart';

import '../../locator.dart';

class CurrenciesBloc extends Bloc<CurrenciesEvent, CurrenciesState> {
  late Map<String, double> currencies;
  CurrenciesBloc() : super(CurrenciesInitialState()) {
    on<CurrenciesEvent>((event, emit) async {
      if(event is GetCurrencies){
        emit(GetCurrenciesLoading());
        try{
          currencies = await locator.get<CurrenciesRepo>().getCurrencies();


          emit(GetCurrenciesSuccess());
        } catch (e){
          emit(GetCurrenciesFailed('Error, please try again'));
        }
      }else if(event is ChangeCurrencyValue){
        emit(ChangeCurrencyLoading());
        try{
          await locator.get<CurrenciesRepo>().changeCurrencyValue(event.currencyName, event.currencyNewValue);
          currencies[event.currencyName] = event.currencyNewValue;
          emit(ChangeCurrencySuccess());
        }catch (e){
          emit(ChangeCurrencyFailed('Error, please try again'));
        }
      }else if(event is DeleteCurrencyValue){
        emit(DeleteCurrencyLoading());
        try{
          await locator.get<CurrenciesRepo>().DeleteCurrency(event.currencyName);
          currencies.removeWhere((key, value) => key == event.currencyName);
          emit(DeleteCurrencySuccess());
        }catch (e){
          emit(DeleteCurrencyFailed('Error, please try again'));
        }
      }else if(event is AddCurrency){
        emit(AddCurrencyLoading());
        try{
          await locator.get<CurrenciesRepo>().AddCurrency(event.currencyName, event.currencyValue);
          currencies.putIfAbsent(event.currencyName, () => event.currencyValue);
          emit(AddCurrencySuccess());
        }catch (e){
          emit(AddCurrencyFailed('Error, please try again'));
        }
      }
    });
  }
}
