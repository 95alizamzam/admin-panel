import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marketing_admin_panel/UI/currencies/widgets/add_currency_sheet.dart';
import 'package:marketing_admin_panel/UI/currencies/widgets/currency_item.dart';
import 'package:marketing_admin_panel/UI/shared_widgets/custom_text_form_field.dart';
import 'package:marketing_admin_panel/bloc/currencies_bloc/currencies_bloc.dart';
import 'package:marketing_admin_panel/bloc/currencies_bloc/currencies_events.dart';
import 'package:marketing_admin_panel/bloc/currencies_bloc/currencies_states.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/constants.dart';
import 'package:marketing_admin_panel/utils/modal_sheets.dart';

class CurrenciesTab extends StatefulWidget {
  @override
  State<CurrenciesTab> createState() => _CurrenciesTabState();
}

class _CurrenciesTabState extends State<CurrenciesTab> {
  @override
  void initState() {
    BlocProvider.of<CurrenciesBloc>(context).add(GetCurrencies());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrenciesBloc, CurrenciesState>(
        builder: (context, state) {
      if (state is GetCurrenciesFailed)
        return Center(
          child: Text(state.message),
        );
      else if (state is GetCurrenciesLoading || state is CurrenciesInitialState)
        return Center(
          child: CircularProgressIndicator(
            color: MyColors.secondaryColor,
          ),
        );
      else {
        Map<String, double> currencies =
            context.read<CurrenciesBloc>().currencies;
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Available Currencies',
                    style: Constants.TEXT_STYLE2
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => ModalSheets().showAddCurrencySheet(context),
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: MyColors.secondaryColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 24,
                          ),
                          Text(
                            'Add New Currency',
                            style: Constants.TEXT_STYLE4
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                '1 American USD equals:',
                style: Constants.TEXT_STYLE4
                    .copyWith(color: MyColors.secondaryColor),
              ),
              const SizedBox(
                height: 12,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 300),
                  child: ListView.separated(
                    itemCount: currencies.length,
                    separatorBuilder: (ctx, index) => const SizedBox(
                      height: 8,
                    ),
                    itemBuilder: (ctx, index) => CurrencyItem(
                      currencyTitle: currencies.keys.toList()[index],
                      currencyValue: currencies.values.toList()[index],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
  }
}
