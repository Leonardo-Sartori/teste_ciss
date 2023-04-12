import 'package:teste_ciss/data/models/post.dart';

abstract class PostRepository {
  Future<List<Post>> getPostsByUser({required int userId});
  Future<Post> save({required Post post});
  Future<Post> update({required Post post});
  Future<int> delete({required int postId});
}