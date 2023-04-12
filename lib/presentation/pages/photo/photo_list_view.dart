import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_ciss/core/injection/injection.dart';
import 'package:teste_ciss/data/models/album.dart';
import 'package:teste_ciss/data/models/photo.dart';
import 'package:teste_ciss/data/models/user.dart';
import 'package:teste_ciss/presentation/blocs/photo/photo_bloc.dart';
import 'package:teste_ciss/presentation/blocs/photo/photo_event.dart';
import 'package:teste_ciss/presentation/blocs/photo/photo_state.dart';
import 'package:teste_ciss/presentation/pages/photo/photo_list_item.dart';
import 'package:teste_ciss/shared/components/app_no_data.dart';
import 'package:teste_ciss/shared/components/custom_bottom_navigator_bar.dart';

class PhotoListView extends StatefulWidget {
  final Album album;
  final User user;

  const PhotoListView({Key? key, required this.album, required this.user}) : super(key: key);

  @override
  State<PhotoListView> createState() => _PhotoListViewState();
}

class _PhotoListViewState extends State<PhotoListView> {
  final _photoBloc = getIt.get<PhotoBloc>();
  List<Photo> filteredPhotos = <Photo>[];
  List<Photo> photos = <Photo>[];
  int listLenght = 0;

  @override
  void initState() {
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
        title: const Text("Fotos"),
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
    );
  }

  Widget _body() {
    return BlocBuilder<PhotoBloc, PhotoState>(
      bloc: _photoBloc,
      builder: (context, state) {
        if (state is PhotoSuccessState) {
          photos = state.photoList;
          filteredPhotos = photos;
          listLenght = state.photoList.length;
        }

        if (state is PhotoSuccessState) {
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
                                  user: widget.user,
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

}
