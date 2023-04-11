import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:teste_ciss/core/injection/injection.dart';
import 'package:teste_ciss/data/models/photo.dart';
import 'package:teste_ciss/data/repositories/photo/photo_repository.dart';
import 'package:teste_ciss/presentation/blocs/photo/photo_event.dart';
import 'package:teste_ciss/presentation/blocs/photo/photo_state.dart';

@injectable
class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final PhotoRepository _photoRepository = getIt.get<PhotoRepository>();

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
      photos = await _photoRepository.getPhotosByAlbum(albumId: albumId);
      return photos;
    } catch (e) {
      throw Exception('Ocorreu um erro ao buscar as imagens do álbum!');
    }
  }
}
