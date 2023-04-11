import 'package:injectable/injectable.dart';
import 'package:teste_ciss/data/datasources/post_datasource.dart';
import 'package:teste_ciss/data/models/post.dart';
import 'package:teste_ciss/data/repositories/post/post_repository.dart';

@Injectable(as: PostRepository)
class PostRepositoryImpl implements PostRepository{

  final PostDatasource postDatasource;

  PostRepositoryImpl({required this.postDatasource});
  
  @override
  Future<List<Post>> getPostsByUser({required int userId}) async {
    return postDatasource.getPostsByUser(userId: userId);
  }

}