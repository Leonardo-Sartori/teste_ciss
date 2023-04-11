import 'package:teste_ciss/data/models/album.dart';

abstract class AlbumRepository {
  Future<List<Album>> getAlbumsByUser({required int userId});
}