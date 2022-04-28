import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketing_admin_panel/models/offers_model.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/constants.dart';
import 'package:intl/intl.dart' show DateFormat;

class ProductInfo extends StatelessWidget {
  final OneProductModel product;

  ProductInfo({required this.product});
  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Wrap(
              //spacing: 4,
              alignment: WrapAlignment.start,
              direction: Axis.horizontal,
              children: product.categories.map((item) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item,
                      style: Constants.TEXT_STYLE8
                          .copyWith(color: MyColors.secondaryColor),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: MyColors.black,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              product.offerName,
              style: Constants.TEXT_STYLE9,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              product.shortDesc,
              style: Constants.TEXT_STYLE4,
            ),
          ),
          if (product.discount != null && product.discount != 0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Chip(
                    label: Text('Discount ${product.discount} %'),
                    labelStyle: Constants.TEXT_STYLE4,
                    backgroundColor: Colors.amberAccent,
                  ),
                  if (product.discountExpireDate != '' && product.discountExpireDate != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                       'expires at ${product.discountExpireDate}',
                        style: Constants.TEXT_STYLE1,
                      ),
                    ),
                  if (product.vat != null && product.vat != 0)
                    Chip(
                      label: Text('V.A.T ${product.vat} %'),
                      labelStyle: Constants.TEXT_STYLE4,
                      backgroundColor: Colors.amberAccent,
                    ),
                ],
              ),
            ),
          Container(
            color: MyColors.lightGrey.withOpacity(0.3),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: product.properties
                  .map(
                    (property) => Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: Color(property['color']),
                        ),
                        Wrap(
                          children: (property['sizes'] as List<dynamic>)
                              .map((size) => Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Chip(
                                      label: Text(
                                        size['size'] +
                                            ' ' +
                                            size['price'].toString() +
                                            '\$',
                                        style: Constants.TEXT_STYLE4,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          if (product.isShippingFree!)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                leading: SvgPicture.asset(
                  'assets/images/free.svg',
                  fit: BoxFit.scaleDown,
                ),
                title: Text(
                  'Shipping free',
                  style: Constants.TEXT_STYLE4,
                ),
              ),
            ),
          if (product.isShippingFree!)
            const SizedBox(
              height: 10,
            ),
          if (product.isReturnAvailable!)
            ListTile(
              leading: SvgPicture.asset(
                'assets/images/return.svg',
                fit: BoxFit.scaleDown,
              ),
              title: Text(
                'Return product available',
                style: Constants.TEXT_STYLE4,
              ),
            ),
          if (product.shippingCosts != null && product.shippingCosts!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    'Shipping Countries:',
                    style: Constants.TEXT_STYLE9,
                  ),
                  Wrap(
                    children: product.shippingCosts!.keys
                        .map(
                          (key) => Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Chip(
                              label: Text(
                                key +
                                    ' ' +
                                    product.shippingCosts![key].toString() +
                                    '\$',
                                style: Constants.TEXT_STYLE4,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
