import 'package:flutter/material.dart';
import 'package:marketing_admin_panel/UI/offers_tab/widgets/likes_and_comments.dart';
import 'package:marketing_admin_panel/UI/offers_tab/widgets/product_info.dart';
import 'package:marketing_admin_panel/UI/shared_widgets/default_image.dart';
import 'package:marketing_admin_panel/models/offers_model.dart';
import 'package:marketing_admin_panel/models/usersModel.dart';
import 'package:marketing_admin_panel/repositories/users/user_repo.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/constants.dart';
import 'package:marketing_admin_panel/utils/navigator/named_routes.dart';
import 'package:marketing_admin_panel/utils/navigator/navigator_imp.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen(
      {Key? key, required this.navigator, required this.product})
      : super(key: key);

  final navigator;
  final OneProductModel product;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('${product.offerName}'),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              decoration: BoxDecoration(
                color: MyColors.secondaryColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                product.status == 'OfferStatus.New' ? "New" : "Used",
                style: TextStyle(color: MyColors.primaryColor),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          FutureBuilder(
            future: UserRepo().getUserById(product.offerOwnerId!),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return LinearProgressIndicator(
                  color: MyColors.secondaryColor,
                );
              else if (snapshot.hasError)
                return Text('Error, please refresh page');
              else {
                final user = snapshot.data as OneUserModel;
                print(user.profileImage);
                return InkWell(
                  onTap: () {
                    NavigatorImpl().push(NamedRoutes.UserDetails, arguments: {
                      'user': user,
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        user.profileImage == null || user.profileImage == ''
                            ? DefaultImage(size: 50.0)
                            : ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            user.profileImage!,
                            fit: BoxFit.cover,
                            width: 50.0,
                            height: 50.0,
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Text(
                          user.userName!,
                          style: Constants.TEXT_STYLE4,
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
          Container(
            height: screenHeight * 0.4,
            child: Center(
              child: Container(
                width: screenWidth * 0.5,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: product.offerMedia!.length,
                  separatorBuilder: (ctx, index) => const SizedBox(
                    width: 10,
                  ),
                  itemBuilder: (ctx, index) => GestureDetector(
                    onTap: () {
                      NavigatorImpl()
                          .push(NamedRoutes.IMAGE_SCREEN, arguments: {
                        'imageUrl': product.offerMedia![index],
                        'heroTag': 'image$index',
                      });
                    },
                    child: Hero(
                      tag: 'image$index',
                      child: Container(
                        width: screenWidth * 0.5,
                        child: Image.network(
                          product.offerMedia![index],
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          ProductInfo(
            product: product,
          ),
          const SizedBox(
            height: 8,
          ),
          LikesAndComments(
            comments: product.comments ?? [],
            likes: product.likes,
            offerId: product.id!,
            offerOwnerType: product.offerOwnerType!,
            offerType: product.offerType!,
          ),
        ],
      ),
    );
  }
}
