import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_ciss/core/injection/injection.dart';
import 'package:teste_ciss/data/models/user.dart';
import 'package:teste_ciss/presentation/blocs/user/user_bloc.dart';
import 'package:teste_ciss/presentation/blocs/user/user_event.dart';
import 'package:teste_ciss/presentation/blocs/user/user_state.dart';
import 'package:teste_ciss/presentation/pages/album/album_list_view.dart';
import 'package:teste_ciss/presentation/pages/post/post_list_view.dart';
import 'package:teste_ciss/presentation/pages/user/user_list_item.dart';
import 'package:teste_ciss/shared/components/app_nodata.dart';
import 'package:teste_ciss/shared/components/custom_bottom_navigator_bar.dart';
import 'package:teste_ciss/shared/utils/navigator/nav.dart';

class UserListView extends StatefulWidget {
  const UserListView({Key? key}) : super(key: key);

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  final _userBloc = getIt.get<UserBloc>();
  List<User> filteredUsers = <User>[];
  List<User> users = <User>[];
  int listLenght = 0;

  @override
  void initState() {
    _getUsers();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getUsers() {
    _userBloc.add(UserLoadingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Usuários"),
      ),
      body: BlocProvider(
        create: (context) => _userBloc,
        child: _body(),
      ),
      bottomNavigationBar: BlocConsumer<UserBloc, UserState>(
        bloc: _userBloc,
        listener: (context, state) {
          if (state is UserLoadingState || state is UserErrorState) {
            listLenght = 0;
          }

          if (state is UserSuccessState) {
            listLenght = state.userList.length;
          }
        },
        builder: (context, state) {
          if (state is UserSuccessState) {
            return CustomBottomNavigationBar(
              count: listLenght,
              text: 'Usuários',
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _body() {
    return BlocBuilder<UserBloc, UserState>(
      bloc: _userBloc,
      builder: (context, state) {
        if (state is UserSuccessState) {
          users = state.userList;
          filteredUsers = users;
          listLenght = state.userList.length;
        }

        if (state is UserSuccessState) {
          return filteredUsers.isNotEmpty
              ? ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return index >= filteredUsers.length
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                UserListItem(
                                  user: filteredUsers[index],
                                  getAlbums: () => push(context, AlbumListView(user: filteredUsers[index])),
                                  getPosts: () => push(context, PostListView(user: filteredUsers[index])),
                                ),
                                const SizedBox(height: 20,),
                              ],
                            ),
                          );
                  },
                  itemCount: filteredUsers.length,
                )
              : const AppNoData();
        } else {
          return Container();
        }
      },
    );
  }
}
