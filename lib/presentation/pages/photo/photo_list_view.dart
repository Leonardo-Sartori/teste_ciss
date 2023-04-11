import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_ciss/core/injection/injection.dart';
import 'package:teste_ciss/data/models/album.dart';
import 'package:teste_ciss/data/models/photo.dart';
import 'package:teste_ciss/presentation/blocs/album/album_state.dart';
import 'package:teste_ciss/presentation/blocs/photo/photo_bloc.dart';
import 'package:teste_ciss/presentation/blocs/photo/photo_event.dart';
import 'package:teste_ciss/presentation/blocs/photo/photo_state.dart';
import 'package:teste_ciss/presentation/pages/photo/photo_list_item.dart';
import 'package:teste_ciss/presentation/pages/user/user_form_page.dart';
import 'package:teste_ciss/shared/components/app_no_data.dart';
import 'package:teste_ciss/shared/components/custom_bottom_navigator_bar.dart';
import 'package:teste_ciss/shared/utils/navigator/nav.dart';

class PhotoListView extends StatefulWidget {
  final Album album;

  const PhotoListView({Key? key, required this.album}) : super(key: key);

  @override
  State<PhotoListView> createState() => _PhotoListViewState();
}

class _PhotoListViewState extends State<PhotoListView> {
  final _photoBloc = getIt.get<PhotoBloc>();
  List<Photo> filteredPhotos = <Photo>[];
  List<Photo> photos = <Photo>[];
  int listLenght = 0;

  final streamIconSearchField = StreamController<String>.broadcast();
  final streamContentAppBar = StreamController<Widget>.broadcast();
  final TextEditingController _filter = TextEditingController();
  Widget? _appBarTitle;

  @override
  void initState() {
    streamIconSearchField.sink.add("search");
    _getPhotos();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getPhotos() {
    _photoBloc.add(PhotoLoadingEvent(albumId: widget.album.id));
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
                  : const Text("Fotos");
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
                        _appBarTitle = const Text('Fotos');
                        filteredPhotos = photos;
                        _filter.clear();
                        _getPhotos();
                      }

                      streamContentAppBar.sink.add(_appBarTitle!);
                    });
              })
        ],
      ),
      body: BlocProvider(
        create: (context) => _photoBloc,
        child: _body(),
      ),
      bottomNavigationBar: BlocConsumer<PhotoBloc, PhotoState>(
        bloc: _photoBloc,
        listener: (context, state) {
          if (state is PhotoLoadingState || state is PhotoErrorState) {
            listLenght = 0;
          }

          if (state is PhotoSuccessState) {
            listLenght = state.photoList.length;
          }
        },
        builder: (context, state) {
          if (state is PhotoSuccessState) {
            return CustomBottomNavigationBar(
              count: listLenght,
              text: 'Fotos',
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
    return BlocBuilder<PhotoBloc, PhotoState>(
      bloc: _photoBloc,
      builder: (context, state) {
        if (state is AlbumSuccessState) {
          photos = state.photoList;
          filteredPhotos = photos;
          listLenght = state.photoList.length;
        }

        if (state is AlbumSuccessState) {
          return filteredPhotos.isNotEmpty
              ? ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return index >= filteredPhotos.length
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                PhotoListItem(
                                  photo: filteredPhotos[index],
                                ),
                                const SizedBox(height: 20,),
                              ],
                            ),
                          );
                  },
                  itemCount: filteredPhotos.length,
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
