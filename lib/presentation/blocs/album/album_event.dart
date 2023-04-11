abstract class AlbumEvent {}

class AlbumInitialEvent extends AlbumEvent {
  AlbumInitialEvent();
}

class AlbumLoadingEvent extends AlbumEvent {
  final int userId;

  AlbumLoadingEvent({required this.userId});
}

class AlbumSuccessEvent extends AlbumEvent {
  AlbumSuccessEvent();
}

class AlbumErrorEvent extends AlbumEvent {
  final String error;
  
  AlbumErrorEvent({required this.error});
}