import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:teste_ciss/core/injection/injection.dart';
import 'package:teste_ciss/data/models/comment.dart';
import 'package:teste_ciss/data/repositories/comment/comment_repository.dart';
import 'package:teste_ciss/presentation/blocs/comment/comment_event.dart';
import 'package:teste_ciss/presentation/blocs/comment/comment_state.dart';

@injectable
class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepository _commentRepository = getIt.get<CommentRepository>();

  CommentBloc() : super(CommentInitialState()) {    
    on<CommentLoadingEvent>((ev, emit) async {
      emit(CommentLoadingState(commentList: []));

      try {
        final commentList = await _fetchCommentList(postId: ev.postId);
        emit(CommentSuccessState(commentList: commentList));
      } catch (error) {
        emit(CommentErrorState(error: error.toString()));
      }
    });
  }

  Future<List<Comment>> _fetchCommentList({required int postId}) async {
    List<Comment> comments = <Comment>[];

    try {
      comments = await _commentRepository.getCommentsByPost(postId: postId);
      return comments;
    } catch (e) {
      throw Exception('Ocorreu um erro ao buscar as comentários do post!');
    }
  }
}
