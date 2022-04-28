import 'package:flutter/material.dart';
import 'package:marketing_admin_panel/utils/navigator/named_routes.dart';
import 'package:marketing_admin_panel/utils/navigator/navigator_imp.dart';

class ImagesListView extends StatelessWidget {
  final List<String> images;

  ImagesListView({required this.images});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.3,
      width: double.infinity,
      //color: MyColors.secondaryColor,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        separatorBuilder: (ctx, index) => const SizedBox(
          width: 10,
        ),
        itemBuilder: (ctx, index) => GestureDetector(
          onTap: (){
            NavigatorImpl().push(NamedRoutes.IMAGE_SCREEN, arguments: {
              'heroTag': 'images$index',
              'imageUrl': images[index],
            });
          },
          child: Hero(
            tag: 'images$index',
            child: Image.network(
              images[index],
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
    // if(regImages.isEmpty)
    //   return Container();
    // else
    //   return Container(
    //     height: screenHeight * 0.3,
    //     child: ListView.separated(
    //       scrollDirection: Axis.horizontal,
    //       itemCount: regImages.length,
    //       separatorBuilder: (ctx, index) => const SizedBox(width: 6,),
    //       itemBuilder: (ctx, index) => Image.network(regImages[index]),
    //     ),
    //   );
  }
}
