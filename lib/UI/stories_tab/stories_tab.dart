import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketing_admin_panel/UI/stories_tab/widgets/story.dart';
import 'package:marketing_admin_panel/bloc/stories_bloc/stories_bloc.dart';
import 'package:marketing_admin_panel/bloc/stories_bloc/stories_events.dart';
import 'package:marketing_admin_panel/bloc/stories_bloc/stories_states.dart';
import 'package:marketing_admin_panel/models/story_model.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/constants.dart';
import 'package:marketing_admin_panel/utils/modal_sheets.dart';
import 'package:marketing_admin_panel/utils/navigator/named_routes.dart';
import 'package:marketing_admin_panel/utils/navigator/navigator_imp.dart';
import 'package:provider/src/provider.dart';

class StoriesTab extends StatefulWidget {
  @override
  State<StoriesTab> createState() => _StoriesTabState();
}

class _StoriesTabState extends State<StoriesTab> {
  ScrollController _scrollController = ScrollController();
  //for pagination
  String _lastFetchedStoryId = '';

  @override
  void initState() {
    context.read<StoriesBloc>().add(GetStories());
    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
        context.read<StoriesBloc>().add(GetMoreStories(_lastFetchedStoryId));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoriesBloc, StoriesState>(
      listener: (ctx, state) {
        if(state is DeleteStoryLoading)
          EasyLoading.show(status: 'Please wait');
        else if(state is DeleteStoryFailed){
          EasyLoading.dismiss();
          EasyLoading.showSuccess(state.message);
        }
        else if(state is DeleteStoryDone){
          EasyLoading.dismiss();
          EasyLoading.showSuccess('Done');
        }
      },
      builder: (ctx, state) {
        if (state is GetStoriesLoading || state is GetMoreStoriesLoading || state is StoriesInitialState || state is FilterStoriesLoading)
          return Center(
            child: CircularProgressIndicator(
              color: MyColors.secondaryColor,
            ),
          );
        else if (state is GetStoriesFailed)
          return Center(
            child: Text(
              state.message,
              style: Constants.TEXT_STYLE4,
              textAlign: TextAlign.center,
            ),
          );
        else if (state is FilterStoriesFailed)
          return Center(
            child: Text(
              state.message,
              style: Constants.TEXT_STYLE4,
              textAlign: TextAlign.center,
            ),
          );
        else if (state is GetMoreStoriesFailed)
          return Center(
            child: Text(
              state.message,
              style: Constants.TEXT_STYLE4,
              textAlign: TextAlign.center,
            ),
          );
        else {
          List<StoryModel> stories = context.read<StoriesBloc>().stories;
          if (stories.isEmpty)
            return Center(
              child: Text(
                'No stories yet',
                style: Constants.TEXT_STYLE4,
              ),
            );
          else {
            _lastFetchedStoryId = stories.last.storyId!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Stories',
                        style: Constants.TEXT_STYLE2.copyWith(fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      IconButton(onPressed: (){ModalSheets().showUsersFilter(context, 'stories',);}, icon: SvgPicture.asset('assets/images/filter.svg'),),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        childAspectRatio: 3 / 4,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        maxCrossAxisExtent: 150,
                        mainAxisExtent: 170,
                      ),
                      itemBuilder: (ctx, index) => GestureDetector(
                        onTap: (){
                          NavigatorImpl().push(
                              NamedRoutes.STORY_DETAILS_SCREEN,
                              arguments: {"story": stories[index]});
                        },
                        child: Story(
                          model: stories[index],
                        ),
                      ),
                      itemCount: stories.length,
                    ),
                  ),
                ],
              ),
            );
          }
        }
      },
    );
  }
}
