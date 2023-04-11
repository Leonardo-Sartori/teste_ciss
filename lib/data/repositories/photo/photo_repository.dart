import 'package:teste_ciss/data/models/photo.dart';

abstract class PhotoRepository {
  Future<List<Photo>> getPhotosByAlbum({required int albumId});
}