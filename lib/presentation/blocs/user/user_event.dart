
abstract class UserEvent {}

class UserInitialEvent extends UserEvent {
  UserInitialEvent();
}

class UserLoadingEvent extends UserEvent {
  UserLoadingEvent();
}

class UserSuccessEvent extends UserEvent {
  UserSuccessEvent();
}

class UserErrorEvent extends UserEvent {
  final String error;
  
  UserErrorEvent({required this.error});
}