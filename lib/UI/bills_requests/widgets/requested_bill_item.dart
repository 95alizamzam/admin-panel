import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:marketing_admin_panel/UI/shared_widgets/custom_button.dart';
import 'package:marketing_admin_panel/bloc/bills_bloc/bills_bloc.dart';
import 'package:marketing_admin_panel/bloc/bills_bloc/events.dart';
import 'package:marketing_admin_panel/models/bill_model.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/constants.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:marketing_admin_panel/utils/navigator/navigator_imp.dart';
import 'package:provider/src/provider.dart';
import '../../../helper.dart';

class RequestedBillItem extends StatefulWidget {
  final OneBillModel bill;

  RequestedBillItem({required this.bill});
  @override
  _RequestedBillItemState createState() => _RequestedBillItemState();
}

class _RequestedBillItemState extends State<RequestedBillItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: MyColors.lightGrey.withOpacity(0.3),
      ),
      child: ExpansionTile(
        title: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '#ID ',
                    style: Constants.TEXT_STYLE1.copyWith(color: MyColors.secondaryColor),
                  ),
                  Text(
                    widget.bill.id!,
                    style: Constants.TEXT_STYLE1,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Text(
                    'Customer share ',
                    style: Constants.TEXT_STYLE1.copyWith(color: MyColors.secondaryColor),
                  ),
                  Text(
                    '${Helper().roundPrice(widget.bill.amount!)}',
                    style: Constants.TEXT_STYLE1,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  DateFormat('dd MMM yyyy').format(widget.bill.date!),
                  style: Constants.TEXT_STYLE1,
                ),
              ),
            ),
            if (widget.bill.isDelivered!)
              Text(
                'Delivered',
                style: Constants.TEXT_STYLE4.copyWith(color: MyColors.red),
              ),
          ],
        ),
        iconColor: MyColors.secondaryColor,
        collapsedIconColor: MyColors.grey,
        childrenPadding: const EdgeInsets.all(8),
        children: [
          Align(alignment: Alignment.centerLeft, child: Text('Customer Info', style: Constants.TEXT_STYLE4.copyWith(fontWeight: FontWeight.w500),),),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      'Customer name ',
                      style: Constants.TEXT_STYLE1.copyWith(color: MyColors.secondaryColor),
                    ),
                    Text(
                      '${widget.bill.userName!}',
                      style: Constants.TEXT_STYLE1,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      'Customer number ',
                      style: Constants.TEXT_STYLE1.copyWith(color: MyColors.secondaryColor),
                    ),
                    Text(
                      '${widget.bill.userPhoneNumber}',
                      style: Constants.TEXT_STYLE1,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Text(
                      'Customer email ',
                      style: Constants.TEXT_STYLE1.copyWith(color: MyColors.secondaryColor),
                    ),
                    Expanded(
                      child: Text(
                        '${widget.bill.userEmail!}',
                        style: Constants.TEXT_STYLE1,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Text(
                      'Country ',
                      style: Constants.TEXT_STYLE1.copyWith(color: MyColors.secondaryColor),
                    ),
                    Text(
                      '${widget.bill.userCountry}',
                      style: Constants.TEXT_STYLE1,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Text(
                      'City ',
                      style: Constants.TEXT_STYLE1.copyWith(color: MyColors.secondaryColor),
                    ),
                    Text(
                      '${widget.bill.userCity}',
                      style: Constants.TEXT_STYLE1,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          if (widget.bill.userLatitude != 0 && widget.bill.userLongitude != 0)
            AddressListTile(longitude: widget.bill.userLongitude, latitude: widget.bill.userLatitude, text: 'Customer address'),
          const SizedBox(
            height: 12,
          ),
          Align(alignment: Alignment.centerLeft, child: Text('Product Info', style: Constants.TEXT_STYLE4.copyWith(fontWeight: FontWeight.w500),),),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      'Vat ',
                      style: Constants.TEXT_STYLE1.copyWith(color: MyColors.secondaryColor),
                    ),
                    Text(
                      '${widget.bill.vat!}',
                      style: Constants.TEXT_STYLE1,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      'Shipping Cost ',
                      style: Constants.TEXT_STYLE1.copyWith(color: MyColors.secondaryColor),
                    ),
                    Text(
                      '${widget.bill.shippingCost}',
                      style: Constants.TEXT_STYLE1,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      'Ship to ',
                      style: Constants.TEXT_STYLE1.copyWith(color: MyColors.secondaryColor),
                    ),
                    Text(
                      '${widget.bill.shipTo}',
                      style: Constants.TEXT_STYLE1,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Text(
                      'Product name ',
                      style: Constants.TEXT_STYLE1.copyWith(color: MyColors.secondaryColor),
                    ),
                    Expanded(
                      child: Text(
                        '${widget.bill.productName!}',
                        style: Constants.TEXT_STYLE1,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Text(
                      'Price ',
                      style: Constants.TEXT_STYLE1.copyWith(color: MyColors.secondaryColor),
                    ),
                    Text(
                      '${Helper().roundPrice(widget.bill.productPrice)}',
                      style: Constants.TEXT_STYLE1,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Text(
                      'Color ',
                      style: Constants.TEXT_STYLE1.copyWith(color: MyColors.secondaryColor),
                    ),
                    CircleAvatar(
                      backgroundColor: widget.bill.productColor,
                      radius: 10,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Text(
                      'Size ',
                      style: Constants.TEXT_STYLE1.copyWith(color: MyColors.secondaryColor),
                    ),
                    Text(
                      '${widget.bill.productSize}',
                      style: Constants.TEXT_STYLE1,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Align(alignment: Alignment.centerLeft, child: Text('Buyer Info', style: Constants.TEXT_STYLE4.copyWith(fontWeight: FontWeight.w500),),),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      'Buyer name ',
                      style: Constants.TEXT_STYLE1.copyWith(color: MyColors.secondaryColor),
                    ),
                    Text(
                      '${widget.bill.buyerName!}',
                      style: Constants.TEXT_STYLE1,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      'Buyer number ',
                      style: Constants.TEXT_STYLE1.copyWith(color: MyColors.secondaryColor),
                    ),
                    Text(
                      '${widget.bill.buyerPhoneNumber}',
                      style: Constants.TEXT_STYLE1,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Text(
                      'Buyer email ',
                      style: Constants.TEXT_STYLE1.copyWith(color: MyColors.secondaryColor),
                    ),
                    Expanded(
                      child: Text(
                        '${widget.bill.buyerEmail!}',
                        style: Constants.TEXT_STYLE1,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Text(
                      'Country ',
                      style: Constants.TEXT_STYLE1.copyWith(color: MyColors.secondaryColor),
                    ),
                    Text(
                      '${widget.bill.buyerCountry}',
                      style: Constants.TEXT_STYLE1,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Text(
                      'City ',
                      style: Constants.TEXT_STYLE1.copyWith(color: MyColors.secondaryColor),
                    ),
                    Text(
                      '${widget.bill.buyerCity}',
                      style: Constants.TEXT_STYLE1,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          if (widget.bill.buyerLatitude != 0 && widget.bill.buyerLongitude != 0)
            AddressListTile(longitude: widget.bill.buyerLongitude, latitude: widget.bill.buyerLatitude, text: 'Buyer address',),

          //action
          if (!widget.bill.isDelivered!)
            Align(
              alignment: Alignment.bottomRight,
              child: CustomButton(
                radius: 8,
                color: MyColors.secondaryColor,
                width: 100,
                buttonLabel: 'Done',
                labelColor: Colors.white,
                labelSize: 16,
                padding: 8,
                ontap: () async {
                  bool b = await showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text(
                        'Are you sure?',
                        style: Constants.TEXT_STYLE8,
                      ),
                      content: Text(
                        'By pressing this button you agree that this bill is delivered.',
                        style: Constants.TEXT_STYLE4.copyWith(color: Colors.red),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            NavigatorImpl().pop(result: true);
                          },
                          child: Text(
                            'Yes',
                            style: TextStyle(color: MyColors.secondaryColor),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            NavigatorImpl().pop(result: false);
                          },
                          child: Text(
                            'No',
                            style: TextStyle(color: MyColors.secondaryColor),
                          ),
                        ),
                      ],
                    ),
                  );

                  if (b) {
                    print(b);
                    context.read<BillsBloc>().add(MarkBillAsDelivered(widget.bill.id!));
                  }
                },
              ),
            )
          else
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: SvgPicture.asset('assets/images/trash.svg'),
                onPressed: () async {
                  bool b = await showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text(
                        'Are you sure?',
                        style: Constants.TEXT_STYLE8,
                      ),
                      content: Text(
                        'This bill will be deleted.',
                        style: Constants.TEXT_STYLE4.copyWith(color: Colors.red),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            NavigatorImpl().pop(result: true);
                          },
                          child: Text(
                            'Yes',
                            style: TextStyle(color: MyColors.secondaryColor),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            NavigatorImpl().pop(result: false);
                          },
                          child: Text(
                            'No',
                            style: TextStyle(color: MyColors.secondaryColor),
                          ),
                        ),
                      ],
                    ),
                  );

                  if (b) {
                    print(b);
                    context.read<BillsBloc>().add(DeleteBillRequest(widget.bill.id!));
                  }
                },
              ),
            ),
        ],
      ),
    );
  }
}

class AddressListTile extends StatefulWidget {
  final latitude, longitude;
  final String text;

  AddressListTile({required this.longitude, required this.latitude, required this.text});

  @override
  _AddressListTileState createState() => _AddressListTileState();
}

class _AddressListTileState extends State<AddressListTile> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Helper().getUserAddress(widget.latitude, widget.longitude),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return LinearProgressIndicator();
        else if (snapshot.hasData) {
          Placemark address = snapshot.data as Placemark;
          return ListTile(
            title: Text(
              widget.text,
              style: Constants.TEXT_STYLE1.copyWith(color: MyColors.secondaryColor),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Country: ${address.country}',
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
                Text(
                  'Area: ${address.administrativeArea}',
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
                Text(
                  'SubArea: ${address.subAdministrativeArea}',
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
                Text(
                  'Locality: ${address.locality}',
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
                Text(
                  'Street: ${address.street}',
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
                Text(
                  'Postal Code: ${address.postalCode}',
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
              ],
            ),
          );
        } else
          return Text('');
      },
    );
  }
}
