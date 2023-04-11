import 'package:teste_ciss/data/models/post.dart';

abstract class PostRepository {
  Future<List<Post>> getPostsByUser({required int userId});
}