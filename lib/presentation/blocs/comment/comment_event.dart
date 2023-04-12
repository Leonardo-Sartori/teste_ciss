abstract class CommentEvent {}

class CommentInitialEvent extends CommentEvent {
  CommentInitialEvent();
}

class CommentLoadingEvent extends CommentEvent {
  final int postId;

  CommentLoadingEvent({required this.postId});
}

class CommentSuccessEvent extends CommentEvent {
  CommentSuccessEvent();
}

class CommentErrorEvent extends CommentEvent {
  final String error;
  
  CommentErrorEvent({required this.error});
}