import 'package:teste_ciss/data/models/comment.dart';

abstract class CommentState {
  List<Comment> commentList = <Comment>[];

  CommentState({
    required this.commentList,
  });
}

class CommentInitialState extends CommentState {
  CommentInitialState() : super(commentList: []);
}

class CommentLoadingState extends CommentState {
  CommentLoadingState({required List<Comment> commentList}) : super(commentList: commentList);
}
class CommentSuccessState extends CommentState {
  CommentSuccessState({required List<Comment> commentList}) : super(commentList: commentList);
}

class CommentErrorState extends CommentState {
  CommentErrorState({required String error}) : super(commentList: []);
}
