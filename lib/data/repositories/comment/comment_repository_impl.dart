import 'package:injectable/injectable.dart';
import 'package:teste_ciss/data/datasources/comment_datasource.dart';
import 'package:teste_ciss/data/models/comment.dart';
import 'package:teste_ciss/data/repositories/comment/comment_repository.dart';

@Injectable(as: CommentRepository)
class CommentRepositoryImpl implements CommentRepository{

  final CommentDatasource commentDatasource;

  CommentRepositoryImpl({required this.commentDatasource});
  
  @override
  Future<List<Comment>> getCommentsByPost({required int postId}) async {
    return commentDatasource.getCommentsByPost(postId: postId);
  }

}