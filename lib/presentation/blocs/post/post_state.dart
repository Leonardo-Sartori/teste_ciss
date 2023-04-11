import 'package:teste_ciss/data/models/post.dart';

abstract class PostState {
  List<Post> postList = <Post>[];

  PostState({
    required this.postList,
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
