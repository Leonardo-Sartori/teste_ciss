import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_ciss/core/injection/injection.dart';
import 'package:teste_ciss/data/models/post.dart';
import 'package:teste_ciss/data/models/user.dart';
import 'package:teste_ciss/presentation/blocs/post/post_bloc.dart';
import 'package:teste_ciss/presentation/blocs/post/post_event.dart';
import 'package:teste_ciss/presentation/blocs/post/post_state.dart';
import 'package:teste_ciss/presentation/pages/post/post_list_item.dart';
import 'package:teste_ciss/presentation/pages/user/user_form_page.dart';
import 'package:teste_ciss/shared/components/app_no_data.dart';
import 'package:teste_ciss/shared/components/custom_bottom_navigator_bar.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<Widget>(
            stream: streamContentAppBar.stream,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? snapshot.data!
                  : const Text("Posts");
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
                        // _searchIcon = const Icon(Icons.close);
                        streamIconSearchField.sink.add("clear");
                        _appBarTitle = TextField(
                          // style: const TextStyle(),
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
                            // hintStyle: TextStyle(),
                          ),
                          onChanged: (value) {
                            // _userBloc.add(ProspectSearchEvent(
                            //     prospects: partners,
                            //     resultSearch: [],
                            //     searchText: value));
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
        },
        builder: (context, state) {
          if (state is PostSuccessState) {
            return CustomBottomNavigationBar(
              count: listLenght,
              text: 'Posts',
            );
          } else {
            return Container();
          }
        },
      ),
      // floatingActionButton: CustomFloatingActionButton(
      //   goTo: () => _goToForm(),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
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

        if (state is PostSuccessState) {
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
                                  getComments: (){},
                                ),
                                const SizedBox(height: 20,),
                              ],
                            ),
                          );
                  },
                  itemCount: filteredPosts.length,
                )
              : AppNoData(text: "Nada Encontrado !");
        } else {
          return Container();
        }
      },
    );
  }

  void _goToForm(){
    push(context, UserFormPage());
  }

}
