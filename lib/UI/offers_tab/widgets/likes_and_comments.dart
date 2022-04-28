import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marketing_admin_panel/UI/shared_widgets/default_image.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/constants.dart';

class LikesAndComments extends StatelessWidget {
  final likes;
  final comments;

  LikesAndComments({required this.likes, required this.comments});
  @override
  Widget build(BuildContext context) {
    print('likes is $likes');
    print('comments is $comments');
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/like.svg',
                    fit: BoxFit.scaleDown,
                    color: MyColors.secondaryColor,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    '${likes.length ?? 0}',
                    style: Constants.TEXT_STYLE4,
                  ),
                ],
              ),
              const SizedBox(
                width: 16,
              ),
              Row(
                children: [
                  Icon(
                    CupertinoIcons.square_favorites_fill,
                    color: MyColors.secondaryColor,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    '${comments.length ?? 0}',
                    style: Constants.TEXT_STYLE4,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        if (comments != null && comments.isNotEmpty)
          Text(
            'Comments',
            style: Constants.TEXT_STYLE9,
          ),
        if (comments != null && comments.isNotEmpty)
          Column(
            children: (comments as List<dynamic>)
                .map(
                  (comment) => ListTile(
                    leading: comment['userImage'] == ''
                        ? DefaultImage(size: 50.0)
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              comment['userImage'],
                              fit: BoxFit.cover,
                              width: 50,
                              height: 50,
                            ),
                          ),
                    title: Text(
                      comment['userName'],
                      style: Constants.TEXT_STYLE4,
                    ),
                    subtitle: Text(
                      comment['content'],
                      style: Constants.TEXT_STYLE4,
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: GestureDetector(
                        onTap: (){

                        },
                        child: SvgPicture.asset(
                          'assets/images/trash.svg',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}
