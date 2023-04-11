abstract class PostEvent {}

class PostInitialEvent extends PostEvent {
  PostInitialEvent();
}

class PostLoadingEvent extends PostEvent {
  final int userId;

  PostLoadingEvent({required this.userId});
}

class PostSuccessEvent extends PostEvent {
  PostSuccessEvent();
}

class PostErrorEvent extends PostEvent {
  final String error;
  
  PostErrorEvent({required this.error});
}