import 'package:teste_ciss/data/models/post.dart';

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

class PostSavingEvent extends PostEvent {
  final Post post;

  PostSavingEvent({required this.post});
}

class PostDeletingEvent extends PostEvent {
  final Post post;

  PostDeletingEvent({required this.post});
}

class PostSearchEvent extends PostEvent {
  List<Post> posts = [];
  List<Post> resultSearch = [];
  String searchText = "";

  PostSearchEvent({required this.posts, required this.resultSearch, required this.searchText});
}