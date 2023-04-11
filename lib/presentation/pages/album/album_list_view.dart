import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_ciss/core/injection/injection.dart';
import 'package:teste_ciss/data/models/album.dart';
import 'package:teste_ciss/data/models/user.dart';
import 'package:teste_ciss/presentation/blocs/album/album_bloc.dart';
import 'package:teste_ciss/presentation/blocs/album/album_event.dart';
import 'package:teste_ciss/presentation/blocs/album/album_state.dart';
import 'package:teste_ciss/presentation/pages/album/album_list_item.dart';
import 'package:teste_ciss/presentation/pages/user/user_form_page.dart';
import 'package:teste_ciss/shared/components/app_no_data.dart';
import 'package:teste_ciss/shared/components/custom_bottom_navigator_bar.dart';
import 'package:teste_ciss/shared/utils/navigator/nav.dart';

class AlbumListView extends StatefulWidget {
  final User user;

  const AlbumListView({Key? key, required this.user}) : super(key: key);

  @override
  State<AlbumListView> createState() => _AlbumListViewState();
}

class _AlbumListViewState extends State<AlbumListView> {
  final _albumBloc = getIt.get<AlbumBloc>();
  List<Album> filteredAlbums = <Album>[];
  List<Album> albums = <Album>[];
  int listLenght = 0;

  final streamIconSearchField = StreamController<String>.broadcast();
  final streamContentAppBar = StreamController<Widget>.broadcast();
  final TextEditingController _filter = TextEditingController();
  Widget? _appBarTitle;

  @override
  void initState() {
    streamIconSearchField.sink.add("search");
    _getAlbums();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getAlbums() {
    _albumBloc.add(AlbumLoadingEvent(userId: widget.user.id));
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
                  : const Text("Álbuns");
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
                        _appBarTitle = const Text('Álbuns');
                        filteredAlbums = albums;
                        _filter.clear();
                        _getAlbums();
                      }

                      streamContentAppBar.sink.add(_appBarTitle!);
                    });
              })
        ],
      ),
      body: BlocProvider(
        create: (context) => _albumBloc,
        child: _body(),
      ),
      bottomNavigationBar: BlocConsumer<AlbumBloc, AlbumState>(
        bloc: _albumBloc,
        listener: (context, state) {
          if (state is AlbumLoadingState || state is AlbumErrorState) {
            listLenght = 0;
          }

          if (state is AlbumSuccessState) {
            listLenght = state.albumList.length;
          }
        },
        builder: (context, state) {
          if (state is AlbumSuccessState) {
            return CustomBottomNavigationBar(
              count: listLenght,
              text: 'Álbuns',
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
    return BlocBuilder<AlbumBloc, AlbumState>(
      bloc: _albumBloc,
      builder: (context, state) {
        if (state is AlbumSuccessState) {
          albums = state.albumList;
          filteredAlbums = albums;
          listLenght = state.albumList.length;
        }

        if (state is AlbumSuccessState) {
          return filteredAlbums.isNotEmpty
              ? ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return index >= filteredAlbums.length
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                AlbumListItem(
                                  user: widget.user,
                                  album: filteredAlbums[index],
                                  getImages: (){},
                                ),
                                const SizedBox(height: 20,),
                              ],
                            ),
                          );
                  },
                  itemCount: filteredAlbums.length,
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
