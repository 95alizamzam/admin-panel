import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marketing_admin_panel/bloc/stories_bloc/stories_bloc.dart';
import 'package:marketing_admin_panel/bloc/stories_bloc/stories_events.dart';
import 'package:marketing_admin_panel/models/story_model.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/constants.dart';

class Story extends StatelessWidget {
  Story({Key? key, required this.model}) : super(key: key);

  final StoryModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: MyColors.secondaryColor,),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            FadeInImage(
              imageErrorBuilder: (_, g, d) {
                return Image(
                  image: AssetImage('assets/images/no_internet.png'),
                );
              },
              placeholder: Image(
                image: AssetImage('assets/images/loader-animation.gif'),
              ).image,
              image: Image(
                image: NetworkImage(model.storyUrls!.first),
              ).image,
              fit: BoxFit.cover,
              height: double.infinity,
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: SvgPicture.asset('assets/images/trash.svg'),
                onPressed: (){
                  context.read<StoriesBloc>().add(DeleteStory(model.storyId!));
                },
              ),
            ),
            Positioned(
              bottom: 6,
              left: 6,
              child: Row(
                children: [
                  if (model.ownerImage != '')
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(model.ownerImage!),
                    )
                  else
                    CircleAvatar(
                      radius: 20,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          'assets/images/default_profile.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  const SizedBox(width: 10),
                  Text(
                    model.ownerName!,
                    style: Constants.TEXT_STYLE6.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
