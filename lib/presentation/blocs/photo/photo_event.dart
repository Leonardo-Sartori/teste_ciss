abstract class PhotoEvent {}

class PhotoInitialEvent extends PhotoEvent {
  PhotoInitialEvent();
}

class PhotoLoadingEvent extends PhotoEvent {
  final int albumId;

  PhotoLoadingEvent({required this.albumId});
}

class PhotoSuccessEvent extends PhotoEvent {
  PhotoSuccessEvent();
}

class PhotoErrorEvent extends PhotoEvent {
  final String error;
  
  PhotoErrorEvent({required this.error});
}