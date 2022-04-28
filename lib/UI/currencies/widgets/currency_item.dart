import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marketing_admin_panel/bloc/currencies_bloc/currencies_bloc.dart';
import 'package:marketing_admin_panel/bloc/currencies_bloc/currencies_events.dart';
import 'package:marketing_admin_panel/bloc/currencies_bloc/currencies_states.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/constants.dart';

class CurrencyItem extends StatefulWidget {
  final String currencyTitle;
  final double currencyValue;

  CurrencyItem({required this.currencyTitle, required this.currencyValue});

  @override
  State<CurrencyItem> createState() => _CurrencyItemState();
}

class _CurrencyItemState extends State<CurrencyItem> {
  bool editable = false;
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CurrenciesBloc, CurrenciesState>(
      listener: (context, state) {
        if (state is ChangeCurrencyLoading || state is DeleteCurrencyLoading || state is AddCurrencyLoading)
          EasyLoading.show(status: 'Please wait');
        else if (state is ChangeCurrencyFailed)
          EasyLoading.showError(state.message);
        else if (state is DeleteCurrencyFailed)
          EasyLoading.showError(state.message);
        else if (state is AddCurrencyFailed)
          EasyLoading.showError(state.message);
        else if (state is ChangeCurrencySuccess || state is DeleteCurrencySuccess || state is AddCurrencySuccess)
          EasyLoading.dismiss();
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: MyColors.lightGrey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Text(
              widget.currencyTitle,
              style:
                  Constants.TEXT_STYLE4.copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              '${widget.currencyValue}',
              style: Constants.TEXT_STYLE9,
            ),
            Spacer(),
            if (editable)
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration.collapsed(
                          fillColor: MyColors.lightBlue,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2),
                            borderSide: BorderSide(
                              color: MyColors.lightBlue,
                            ),
                          ),
                          filled: true,
                          hintText: 'New Value',
                          hintStyle: Constants.TEXT_STYLE1,
                        ),
                      ),
                    ),
                    IconButton(
                      color: MyColors.secondaryColor,
                      onPressed: () {
                        try {
                          double newValue = double.parse(controller.text);
                          setState(() {
                            editable = !editable;
                          });
                          BlocProvider.of<CurrenciesBloc>(context).add(
                              ChangeCurrencyValue(
                                  widget.currencyTitle, newValue));
                        } catch (e) {
                          EasyLoading.showToast('Please enter a valid value');
                        }
                      },
                      icon: Icon(
                        Icons.done,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(
              width: 8,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  editable = !editable;
                });
              },
              child: SvgPicture.asset('assets/images/edit_profile.svg',
                  fit: BoxFit.scaleDown),
            ),
            const SizedBox(
              width: 8,
            ),
            GestureDetector(
              onTap: (){
                BlocProvider.of<CurrenciesBloc>(context).add(DeleteCurrencyValue(widget.currencyTitle));
              },
              child: SvgPicture.asset('assets/images/trash.svg',
                  fit: BoxFit.scaleDown),
            ),
          ],
        ),
      ),
    );
  }
}
