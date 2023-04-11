import 'package:teste_ciss/data/models/album.dart';

abstract class AlbumState {
  List<Album> albumList = <Album>[];

  AlbumState({
    required this.albumList,
  });
}

class AlbumInitialState extends AlbumState {
  AlbumInitialState() : super(albumList: []);
}

class AlbumLoadingState extends AlbumState {
  AlbumLoadingState({required List<Album> albumList}) : super(albumList: albumList);
}
class AlbumSuccessState extends AlbumState {
  AlbumSuccessState({required List<Album> albumList}) : super(albumList: albumList);
}

class AlbumErrorState extends AlbumState {
  AlbumErrorState({required String error}) : super(albumList: []);
}
