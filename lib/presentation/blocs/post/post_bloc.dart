import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:teste_ciss/core/injection/injection.dart';
import 'package:teste_ciss/data/models/post.dart';
import 'package:teste_ciss/data/repositories/post/post_repository.dart';
import 'package:teste_ciss/presentation/blocs/post/post_event.dart';
import 'package:teste_ciss/presentation/blocs/post/post_state.dart';

@injectable
class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _postRepository = getIt.get<PostRepository>();

  PostBloc() : super(PostInitialState()) {    
    on<PostLoadingEvent>((ev, emit) async {
      emit(PostLoadingState(postList: []));

      try {
        final postList = await _fetchPostList(userId: ev.userId);
        emit(PostSuccessState(postList: postList));
      } catch (error) {
        emit(PostErrorState(error: error.toString()));
      }
    });
  }

  Future<List<Post>> _fetchPostList({required int userId}) async {
    List<Post> posts = <Post>[];

    try {
      posts = await _postRepository.getPostsByUser(userId: userId);
      return posts;
    } catch (e) {
      throw Exception('Ocorreu um erro ao buscar os posts do usuário!');
    }
  }
}
