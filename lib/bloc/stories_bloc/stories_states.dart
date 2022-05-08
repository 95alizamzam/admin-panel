
class StoriesState {}

class StoriesInitialState extends StoriesState {}

class GetStoriesLoading extends StoriesState {}

class GetStoriesDone extends StoriesState {}

class GetStoriesFailed extends StoriesState {
  String message;

  GetStoriesFailed(this.message);
}

class GetMoreStoriesLoading extends StoriesState {}

class GetMoreStoriesDone extends StoriesState {}

class GetMoreStoriesFailed extends StoriesState {
  String message;

  GetMoreStoriesFailed(this.message);
}

class DeleteStoryLoading extends StoriesState {}

class DeleteStoryDone extends StoriesState {}

class DeleteStoryFailed extends StoriesState {
  String message;

  DeleteStoryFailed(this.message);
}

class FilterStoriesLoading extends StoriesState {}

class FilterStoriesDone extends StoriesState {}

class FilterStoriesFailed extends StoriesState {
  String message;

  FilterStoriesFailed(this.message);
}

