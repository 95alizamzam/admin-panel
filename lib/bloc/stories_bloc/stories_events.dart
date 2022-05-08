
class StoriesEvent {}

class GetStories extends StoriesEvent {}

class GetMoreStories extends StoriesEvent {
  String lastFetchedStoryId;

  GetMoreStories(this.lastFetchedStoryId);
}

class DeleteStory extends StoriesEvent {
  String storyId;

  DeleteStory(this.storyId);
}

class FilterStories extends StoriesEvent {
  double minAge;
  double maxAge;
  List<String> countries;
  String gender;

  FilterStories(this.minAge, this.maxAge, this.gender, this.countries);
}