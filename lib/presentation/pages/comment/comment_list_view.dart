import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_ciss/core/injection/injection.dart';
import 'package:teste_ciss/data/models/comment.dart';
import 'package:teste_ciss/data/models/post.dart';
import 'package:teste_ciss/data/models/user.dart';
import 'package:teste_ciss/presentation/blocs/comment/comment_bloc.dart';
import 'package:teste_ciss/presentation/blocs/comment/comment_event.dart';
import 'package:teste_ciss/presentation/blocs/comment/comment_state.dart';
import 'package:teste_ciss/presentation/pages/comment/comment_list_item.dart';
import 'package:teste_ciss/shared/components/app_nodata.dart';
import 'package:teste_ciss/shared/components/custom_bottom_navigator_bar.dart';

class CommentListView extends StatefulWidget {
  final Post post;
  final User user;

  const CommentListView({Key? key, required this.post, required this.user}) : super(key: key);

  @override
  State<CommentListView> createState() => _CommentListViewState();
}

class _CommentListViewState extends State<CommentListView> {
  final _commentBloc = getIt.get<CommentBloc>();
  List<Comment> filteredComments = <Comment>[];
  List<Comment> comments = <Comment>[];
  int listLenght = 0;

  @override
  void initState() {
    _getComments();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getComments() {
    _commentBloc.add(CommentLoadingEvent(postId: widget.post.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comentários"),
      ),
      body: BlocProvider(
        create: (context) => _commentBloc,
        child: _body(),
      ),
      bottomNavigationBar: BlocConsumer<CommentBloc, CommentState>(
        bloc: _commentBloc,
        listener: (context, state) {
          if (state is CommentLoadingState || state is CommentErrorState) {
            listLenght = 0;
          }

          if (state is CommentSuccessState) {
            listLenght = state.commentList.length;
          }
        },
        builder: (context, state) {
          if (state is CommentSuccessState) {
            return CustomBottomNavigationBar(
              count: listLenght,
              text: 'Comentários',
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _body() {
    return BlocBuilder<CommentBloc, CommentState>(
      bloc: _commentBloc,
      builder: (context, state) {
        if (state is CommentSuccessState) {
          comments = state.commentList;
          filteredComments = comments;
          listLenght = state.commentList.length;
        }

        if (state is CommentSuccessState) {
          return filteredComments.isNotEmpty
              ? ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return index >= filteredComments.length
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                CommentListItem(
                                  comment: filteredComments[index],
                                  post: widget.post,
                                  user: widget.user,
                                ),
                                const SizedBox(height: 20,),
                              ],
                            ),
                          );
                  },
                  itemCount: filteredComments.length,
                )
              : const AppNoData();
        } else {
          return Container();
        }
      },
    );
  }

}
