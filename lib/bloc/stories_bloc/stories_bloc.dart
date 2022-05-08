import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing_admin_panel/bloc/stories_bloc/stories_events.dart';
import 'package:marketing_admin_panel/bloc/stories_bloc/stories_states.dart';
import 'package:marketing_admin_panel/models/story_model.dart';
import 'package:marketing_admin_panel/repositories/stories/stories_repository.dart';
import 'package:marketing_admin_panel/locator.dart';

class StoriesBloc extends Bloc<StoriesEvent, StoriesState> {
  List<StoryModel> stories = [];

  //in case many requests sent at same time
  bool alreadyFetchingMoreStories = false;

  StoriesBloc() : super(StoriesInitialState()) {
    on<StoriesEvent>((event, emit) async {
      if(event is GetStories){
        emit(GetStoriesLoading());
        try{
          stories = await locator.get<StoriesRepository>().getStories();
          emit(GetStoriesDone());
        }catch (e){
          emit(GetStoriesFailed('Error, try again'));
        }
      }

      else if (event is GetMoreStories && !alreadyFetchingMoreStories) {
        alreadyFetchingMoreStories = true;
        emit(GetMoreStoriesLoading());
        try {
          final moreStories = await locator.get<StoriesRepository>().getStories(lastFetchedStoryId: event.lastFetchedStoryId);
          stories.addAll(moreStories);
          alreadyFetchingMoreStories = false;
          emit(GetMoreStoriesDone());
        } catch (e) {
          alreadyFetchingMoreStories = false;
          emit(GetMoreStoriesFailed('Error, please try again'));
        }
      }

      else if(event is DeleteStory){
        emit(DeleteStoryLoading());
        try{
          await locator.get<StoriesRepository>().deleteStory(event.storyId);
          stories.removeWhere((story) => story.storyId == event.storyId);
          emit(DeleteStoryDone());
        }catch (e){
          emit(DeleteStoryFailed('Error, try again'));
        }
      }

      else if(event is FilterStories){
        emit(FilterStoriesLoading());
        try{
          stories = await locator.get<StoriesRepository>().getFilteredStories(event.minAge, event.maxAge, event.gender, event.countries);
          emit(FilterStoriesDone());
        }catch (e){
          emit(FilterStoriesFailed('Error, try again'));
        }
      }
    });
  }
}
