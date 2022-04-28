import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:marketing_admin_panel/UI/shared_widgets/custom_button.dart';
import 'package:marketing_admin_panel/UI/shared_widgets/custom_text_form_field.dart';
import 'package:marketing_admin_panel/bloc/currencies_bloc/currencies_bloc.dart';
import 'package:marketing_admin_panel/bloc/currencies_bloc/currencies_events.dart';
import 'package:marketing_admin_panel/utils/colors.dart';

class AddCurrencySheet extends StatefulWidget {
  @override
  State<AddCurrencySheet> createState() => _AddCurrencySheetState();
}

class _AddCurrencySheetState extends State<AddCurrencySheet> {
  TextEditingController currencyName = TextEditingController();
  TextEditingController currencyValue = TextEditingController();

  @override
  void dispose() {
    currencyName.dispose();
    currencyValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          children: [
            CustomTextFormField(
              controller: currencyName,
              hint: 'Currency Name',
              width: 200.0,
              validateInput: (p) {},
              saveInput: (p) {},
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              controller: currencyValue,
              hint: 'Currency Value',
              width: 200.0,
              validateInput: (p) {},
              saveInput: (p) {},
            ),
            const SizedBox(
              height: 16,
            ),
            CustomButton(
              ontap: () {
                if(currencyName.text.isNotEmpty && currencyValue.text.isNotEmpty){
                  try {
                    double value = double.parse(currencyValue.text);
                    BlocProvider.of<CurrenciesBloc>(context).add(AddCurrency(currencyName.text.toUpperCase(), value));
                  }catch (e) {
                    EasyLoading.showToast('Please enter a valid value');
                  }
                }else
                  EasyLoading.showToast('Please fill all fields');
              },
              buttonLabel: 'Add',
              padding: 8,
              radius: 15,
              color: MyColors.secondaryColor,
              labelColor: Colors.white,
              labelSize: 16,
              width: 200,
            ),
          ],
        ),
      ),
    );
  }
}
