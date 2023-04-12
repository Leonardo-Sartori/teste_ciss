import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:teste_ciss/data/models/comment.dart';
import 'package:teste_ciss/data/services/json_placeholder_api/json_placeholder_api.dart';
import 'package:teste_ciss/shared/constants/api.dart';

@injectable
class CommentDatasource {
  late final JsonPlaceholderApi jsonPlaceholderApi;

  CommentDatasource({required this.jsonPlaceholderApi});

  Future<List<Comment>> getCommentsByPost({required int postId}) async {
    final response = await jsonPlaceholderApi.client.get(Uri.parse('${ConstantsApi.baseUrl}/comments?postId=$postId'));
    final responseData = json.decode(response.body);
    late List<Comment> comments = [];

    for (dynamic comment in responseData) {
        comments.add(
          Comment.fromMap(comment),
        );
      }
    return comments;
  }
}