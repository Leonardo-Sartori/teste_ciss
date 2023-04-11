import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:teste_ciss/data/models/post.dart';
import 'package:teste_ciss/data/models/user.dart';
import 'package:teste_ciss/data/services/json_placeholder_api/json_placeholder_api.dart';
import 'package:teste_ciss/shared/constants/api.dart';

@injectable
class PostDatasource {
  late final JsonPlaceholderApi jsonPlaceholderApi;

  PostDatasource({required this.jsonPlaceholderApi});

  Future<List<Post>> getPostsByUser({required userId}) async {
    final response = await jsonPlaceholderApi.client.get(Uri.parse('${ConstantsApi.baseUrl}/users/$userId/posts'));
    final responseData = json.decode(response.body);
    late List<Post> posts = [];

    for (dynamic post in responseData) {
        posts.add(
          Post(
            id: post["id"],
            title: post["title"],
            body: post["body"],
            user: User(id: post["userId"], name: "", username: "", email: "")
          ),
        );
      }
    return posts;
  }
}