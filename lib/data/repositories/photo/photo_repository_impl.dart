import 'package:injectable/injectable.dart';
import 'package:teste_ciss/data/datasources/photo_datasource.dart';
import 'package:teste_ciss/data/models/photo.dart';
import 'package:teste_ciss/data/repositories/photo/photo_repository.dart';

@Injectable(as: PhotoRepository)
class PhotoRepositoryImpl implements PhotoRepository{

  final PhotoDatasource photoDatasource;

  PhotoRepositoryImpl({required this.photoDatasource});
  
  @override
  Future<List<Photo>> getPhotosByAlbum({required int albumId}) async {
    return photoDatasource.getPhotosByAlbum(albumId: albumId);
  }

}