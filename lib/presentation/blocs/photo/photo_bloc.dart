import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:teste_ciss/data/models/photo.dart';
import 'package:teste_ciss/data/repositories/photo/photo_repository_impl.dart';
import 'package:teste_ciss/presentation/blocs/photo/photo_event.dart';
import 'package:teste_ciss/presentation/blocs/photo/photo_state.dart';

@injectable
class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  late final PhotoRepositoryImpl _photoRepositoryImpl;

  PhotoBloc() : super(PhotoInitialState()) {    
    on<PhotoLoadingEvent>((ev, emit) async {
      emit(PhotoLoadingState(photoList: []));

      try {
        final photoList = await _fetchPhotoList(albumId: ev.albumId);
        emit(PhotoSuccessState(photoList: photoList));
      } catch (error) {
        emit(PhotoErrorState(error: error.toString()));
      }
    });
  }

  Future<List<Photo>> _fetchPhotoList({required int albumId}) async {
    List<Photo> photos = <Photo>[];

    try {
      photos = await _photoRepositoryImpl.getPhotosByAlbum(albumId: albumId);
      return photos;
    } catch (e) {
      throw Exception('Ocorreu um erro ao buscar as imagens do álbum!');
    }
  }
}
