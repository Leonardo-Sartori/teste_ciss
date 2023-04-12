import 'package:teste_ciss/data/models/comment.dart';

abstract class CommentRepository {
  Future<List<Comment>> getCommentsByPost({required int postId});
}