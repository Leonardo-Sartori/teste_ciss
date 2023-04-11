import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:teste_ciss/core/injection/injection.dart';
import 'package:teste_ciss/data/models/album.dart';
import 'package:teste_ciss/data/repositories/album/album_repository.dart';
import 'package:teste_ciss/presentation/blocs/album/album_event.dart';
import 'package:teste_ciss/presentation/blocs/album/album_state.dart';

@injectable
class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumRepository _albumRepository = getIt.get<AlbumRepository>();

  AlbumBloc() : super(AlbumInitialState()) {    
    on<AlbumLoadingEvent>((ev, emit) async {
      emit(AlbumLoadingState(albumList: []));

      try {
        final albumList = await _fetchAlbumList(userId: ev.userId);
        emit(AlbumSuccessState(albumList: albumList));
      } catch (error) {
        emit(AlbumErrorState(error: error.toString()));
      }
    });
  }

  Future<List<Album>> _fetchAlbumList({required int userId}) async {
    List<Album> albums = <Album>[];

    try {
      albums = await _albumRepository.getAlbumsByUser(userId: userId);
      return albums;
    } catch (e) {
      throw Exception('Ocorreu um erro ao buscar os álbuns do usuário!');
    }
  }
}
