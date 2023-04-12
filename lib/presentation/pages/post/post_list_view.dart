import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_ciss/core/injection/injection.dart';
import 'package:teste_ciss/data/models/post.dart';
import 'package:teste_ciss/data/models/user.dart';
import 'package:teste_ciss/presentation/blocs/post/post_bloc.dart';
import 'package:teste_ciss/presentation/blocs/post/post_event.dart';
import 'package:teste_ciss/presentation/blocs/post/post_state.dart';
import 'package:teste_ciss/presentation/pages/comment/comment_list_view.dart';
import 'package:teste_ciss/presentation/pages/post/post_list_item.dart';
import 'package:teste_ciss/presentation/pages/post/post_form_page.dart';
import 'package:teste_ciss/shared/components/alerts.dart';
import 'package:teste_ciss/shared/components/custom_bottom_navigator_bar.dart';
import 'package:teste_ciss/shared/components/custom_floating_action_button.dart';
import 'package:teste_ciss/shared/components/easy_loading.dart';
import 'package:teste_ciss/shared/utils/navigator/nav.dart';

class PostListView extends StatefulWidget {
  final User user;

  const PostListView({Key? key, required this.user}) : super(key: key);

  @override
  State<PostListView> createState() => _PostListViewState();
}

class _PostListViewState extends State<PostListView> {
  final _postBloc = getIt.get<PostBloc>();
  List<Post> filteredPosts = <Post>[];
  List<Post> posts = <Post>[];
  int listLenght = 0;

  final streamIconSearchField = StreamController<String>.broadcast();
  final streamContentAppBar = StreamController<Widget>.broadcast();
  final TextEditingController _filter = TextEditingController();
  Widget? _appBarTitle;

  @override
  void initState() {
    streamIconSearchField.sink.add("search");
    _getPosts();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getPosts() {
    _postBloc.add(PostLoadingEvent(userId: widget.user.id));
  }

  void _goToForm({Post? post}) {
    push(
        context,
        PostFormPage(
          user: widget.user,
          post: post,
        ),
        replace: true);
  }

  void deleteComment({required Post post}) {
    confirmAlert("Deseja realmente excluir o comentário  ?", context, () {
      dismiss(context);
      _postBloc.add(PostDeletingEvent(post: post));
    }, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<Widget>(
            stream: streamContentAppBar.stream,
            builder: (context, snapshot) {
              return snapshot.hasData ? snapshot.data! : const Text("Posts");
            }),
        actions: [
          StreamBuilder<String>(
              stream: streamIconSearchField.stream,
              builder: (context, snapshot) {
                return IconButton(
                    icon: !snapshot.hasData || snapshot.data == "search"
                        ? const Icon(Icons.search)
                        : const Icon(Icons.clear),
                    onPressed: () {
                      if (!snapshot.hasData || snapshot.data == "search") {
                        streamIconSearchField.sink.add("clear");
                        _appBarTitle = TextField(
                          controller: _filter,
                          autofocus: true,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.transparent, width: 1.0),
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                            ),
                            hintText: 'Buscar...',
                            hintStyle: TextStyle(color: Colors.white)
                          ),
                          onChanged: (value) {
                            _postBloc.add(PostSearchEvent(
                                posts: posts,
                                resultSearch: [],
                                searchText: value));
                          },
                        );
                      } else {
                        // _searchIcon = const Icon(Icons.search);
                        streamIconSearchField.sink.add("search");
                        _appBarTitle = const Text('Posts');
                        filteredPosts = posts;
                        _filter.clear();
                        _getPosts();
                      }

                      streamContentAppBar.sink.add(_appBarTitle!);
                    });
              })
        ],
      ),
      body: BlocProvider(
        create: (context) => _postBloc,
        child: _body(),
      ),
      bottomNavigationBar: BlocConsumer<PostBloc, PostState>(
        bloc: _postBloc,
        listener: (context, state) {
          if (state is PostLoadingState || state is PostErrorState) {
            listLenght = 0;
          }

          if (state is PostSuccessState) {
            listLenght = state.postList.length;
          }

          if (state is PostSearchState) {
            listLenght = state.searchResult!.length;
          }
        },
        builder: (context, state) {
          if (state is PostSuccessState || state is PostSearchState) {
            return CustomBottomNavigationBar(
              count: listLenght,
              text: 'Posts',
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: CustomFloatingActionButton(
        goTo: () => _goToForm(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  Widget _body() {
    return BlocBuilder<PostBloc, PostState>(
      bloc: _postBloc,
      builder: (context, state) {
        if (state is PostSuccessState) {
          posts = state.postList;
          filteredPosts = posts;
          listLenght = state.postList.length;
        }

        if (state is PostSearchState) {
          posts = state.postList;
          filteredPosts = state.searchResult!;
          listLenght = state.searchResult!.length;
        }

        if (state is PostDeletingSuccessState) {
          if (state.responseCode == 200) {
            showSuccess(text: "Elemento excluído com sucesso: ${state.post}");
          } else {
            showError();
            _getPosts();
          }
        }

        if (state is PostSuccessState || state is PostSearchState) {
          return filteredPosts.isNotEmpty
              ? ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return index >= filteredPosts.length
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                PostListItem(
                                  user: widget.user,
                                  post: filteredPosts[index],
                                  getComments: () => push(
                                      context,
                                      CommentListView(
                                          post: filteredPosts[index],
                                          user: widget.user)),
                                  onDelete: () =>
                                      deleteComment(post: filteredPosts[index]),
                                  onEdit: () =>
                                      _goToForm(post: filteredPosts[index]),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          );
                  },
                  itemCount: filteredPosts.length,
                )
              : const Center(child: Text("Nenhum registro atende a pesquisa !"));
        } else {
          return Container();
        }
      },
    );
  }
}
