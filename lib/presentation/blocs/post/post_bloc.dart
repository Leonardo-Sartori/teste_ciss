import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:teste_ciss/data/models/post.dart';
import 'package:teste_ciss/data/repositories/post/post_repository_impl.dart';
import 'package:teste_ciss/presentation/blocs/post/post_event.dart';
import 'package:teste_ciss/presentation/blocs/post/post_state.dart';

@injectable
class PostBloc extends Bloc<PostEvent, PostState> {
  late PostRepositoryImpl postRepositoryImpl;

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

    on<PostSavingEvent>((ev, emit) async {
      final Post post;

      emit(PostLoadingState(postList: []));

      try {
        if (ev.post.id != 0) {
          post = await postRepositoryImpl.update(post: ev.post);
        } else {
          post = await postRepositoryImpl.save(post: ev.post);
        }

        emit(PostSavingSuccessState(postList: [], post: post));
      } catch (error) {
        emit(PostErrorState(error: error.toString()));
      }
    });

    on<PostDeletingEvent>((ev, emit) async {
      final int responseCode;

      emit(PostLoadingState(postList: []));

      try {
        responseCode = await postRepositoryImpl.delete(postId: ev.post.id);

        emit(PostDeletingSuccessState(postList: [], responseCode: responseCode, post: ev.post));
      } catch (error) {
        emit(PostErrorState(error: error.toString()));
      }
    });

    on<PostSearchEvent>((ev, emit) async {
      try {
        if (ev.searchText.isNotEmpty) {
          List<Post> tempList = <Post>[];

          for (var v in ev.posts) {
            if (v.title.toLowerCase().contains(ev.searchText.toLowerCase()) || v.body.toLowerCase().contains(ev.searchText.toLowerCase())) {
              tempList.add(v);
            }
          }

          ev.resultSearch = tempList;
        } else {
          ev.resultSearch = ev.posts;
        }

        emit(PostSearchState(postList: ev.posts, searchResult: ev.resultSearch));
      } catch (error) {
        emit(PostErrorState(error: error.toString()));
      }
    });
  }

  Future<List<Post>> _fetchPostList({required int userId}) async {
    List<Post> posts = <Post>[];

    try {
      posts = await postRepositoryImpl.getPostsByUser(userId: userId);
      return posts;
    } catch (e) {
      throw Exception('Ocorreu um erro ao buscar os posts do usuário!');
    }
  }
}
