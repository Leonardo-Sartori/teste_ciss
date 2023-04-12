import 'package:teste_ciss/data/models/post.dart';

abstract class PostState {
  List<Post> postList = <Post>[];
  Post? post;
  int? responseCode;
  String? textSearch;
  List<Post>? searchResult;

  PostState({
    required this.postList,
    this.post,
    this.responseCode,
    this.textSearch,
    this.searchResult,
  });
}

class PostInitialState extends PostState {
  PostInitialState() : super(postList: []);
}

class PostLoadingState extends PostState {
  PostLoadingState({required List<Post> postList}) : super(postList: postList);
}
class PostSuccessState extends PostState {
  PostSuccessState({required List<Post> postList}) : super(postList: postList);
}

class PostErrorState extends PostState {
  PostErrorState({required String error}) : super(postList: []);
}

class PostSavingState extends PostState {
  PostSavingState({required Post post}) : super(postList: [], post: post);
}

class PostSavingSuccessState extends PostState {
  PostSavingSuccessState({required List<Post> postList, required Post post}) : super(postList: [], post: post);
}

class PostDeletingSuccessState extends PostState {
  PostDeletingSuccessState({required List<Post> postList, required Post post, required int responseCode}) : super(postList: [], responseCode: responseCode, post: post);
}

class PostSearchState extends PostState {
  PostSearchState({required List<Post> postList, required List<Post> searchResult}) : super(postList: postList, searchResult: searchResult);
}
