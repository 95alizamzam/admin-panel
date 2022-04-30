import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marketing_admin_panel/UI/shared_widgets/default_image.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/bloc.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/events.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/states.dart';
import 'package:marketing_admin_panel/models/comment_model.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/constants.dart';
import 'package:provider/src/provider.dart';

class LikesAndComments extends StatelessWidget {
  final likes;
  final List<CommentModel> comments;
  final String offerId;
  final String offerOwnerType;
  final String offerType;

  LikesAndComments({required this.likes, required this.comments, required this.offerOwnerType, required this.offerId, required this.offerType});

  @override
  Widget build(BuildContext context) {
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
                    '${comments.length}',
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
        if (comments.isNotEmpty)
          Text(
            'Comments',
            style: Constants.TEXT_STYLE9,
          ),
        if (comments.isNotEmpty)
          Column(
            children: comments
                .map(
                  (comment) => ListTile(
                    leading: comment.userImage == ''
                        ? DefaultImage(size: 50.0)
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              comment.userImage!,
                              fit: BoxFit.cover,
                              width: 50,
                              height: 50,
                            ),
                          ),
                    title: Text(
                      comment.userName!,
                      style: Constants.TEXT_STYLE4,
                    ),
                    subtitle: Text(
                      comment.content ?? '',
                      style: Constants.TEXT_STYLE4,
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: BlocConsumer<OfferBloc, OfferStates>(
                        listener: (ctx, state) {
                          if (state is DeleteCommentFailed) EasyLoading.showToast(state.message);
                        },
                        builder: (ctx, state) {
                          if (state is DeleteCommentLoading)
                            return Container();
                          else
                            return GestureDetector(
                              onTap: () {
                                context.read<OfferBloc>().add(DeleteComment(offerOwnerType, offerId, comment, offerType));
                              },
                              child: SvgPicture.asset(
                                'assets/images/trash.svg',
                                fit: BoxFit.scaleDown,
                              ),
                            );
                        },
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
