import 'package:injectable/injectable.dart';
import 'package:teste_ciss/data/datasources/album_datasource.dart';
import 'package:teste_ciss/data/models/album.dart';
import 'package:teste_ciss/data/repositories/album/album_repository.dart';

@Injectable(as: AlbumRepository)
class AlbumRepositoryImpl implements AlbumRepository{

  final AlbumDatasource albumDatasource;

  AlbumRepositoryImpl({required this.albumDatasource});
  
  @override
  Future<List<Album>> getAlbumsByUser({required int userId}) async {
    return albumDatasource.getAlbumsByUser(userId: userId);
  }

}