import 'package:teste_ciss/data/models/photo.dart';

abstract class PhotoState {
  List<Photo> photoList = <Photo>[];

  PhotoState({
    required this.photoList,
  });
}

class PhotoInitialState extends PhotoState {
  PhotoInitialState() : super(photoList: []);
}

class PhotoLoadingState extends PhotoState {
  PhotoLoadingState({required List<Photo> photoList}) : super(photoList: photoList);
}
class PhotoSuccessState extends PhotoState {
  PhotoSuccessState({required List<Photo> photoList}) : super(photoList: photoList);
}

class PhotoErrorState extends PhotoState {
  PhotoErrorState({required String error}) : super(photoList: []);
}
