import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:teste_ciss/data/models/post.dart';
import 'package:teste_ciss/data/services/json_placeholder_api/json_placeholder_api.dart';
import 'package:teste_ciss/shared/constants/api.dart';

@injectable
class PostDatasource {
  late final JsonPlaceholderApi jsonPlaceholderApi;

  PostDatasource({required this.jsonPlaceholderApi});

  Future<List<Post>> getPostsByUser({required int userId}) async {
    final response = await jsonPlaceholderApi.client.get(Uri.parse('${ConstantsApi.baseUrl}/users/$userId/posts'));
    final responseData = json.decode(response.body);
    late List<Post> posts = [];

    for (dynamic post in responseData) {
        posts.add(
          Post.fromMap(post),
        );
      }
    return posts;
  }

  Future<Post> save({required Post post}) async {
    final response = await jsonPlaceholderApi.client.post(
      Uri.parse('${ConstantsApi.baseUrl}/posts'),
      headers: jsonPlaceholderApi.headers,
      body: jsonEncode(post.toMap())
    );

    Post postBody;
    postBody = Post.fromMap(jsonDecode(response.body));

    return postBody;
  }

  Future<Post> update({required Post post}) async {
    final response = await jsonPlaceholderApi.client.put(
      Uri.parse('${ConstantsApi.baseUrl}/posts/${post.id}'),
      headers: jsonPlaceholderApi.headers,
      body: jsonEncode(post.toMap())
    );

    Post postBody;
    postBody = Post.fromMap(jsonDecode(response.body));

    return postBody;
  }

  Future<int> delete({required int postId}) async {
    final response = await jsonPlaceholderApi.client.delete(Uri.parse('${ConstantsApi.baseUrl}/posts/$postId'));
    return response.statusCode;
  }
}