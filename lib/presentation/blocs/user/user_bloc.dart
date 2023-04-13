import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:teste_ciss/data/models/user.dart';
import 'package:teste_ciss/data/repositories/user/user_repository_impl.dart';
import 'package:teste_ciss/presentation/blocs/user/user_event.dart';
import 'package:teste_ciss/presentation/blocs/user/user_state.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  late final UserRepositoryImpl _userRepositoryImpl;

  UserBloc() : super(UserInitialState()) {    
    on<UserLoadingEvent>((ev, emit) async {
      emit(UserLoadingState(userList: []));

      try {
        final userList = await _fetchUserList();
        emit(UserSuccessState(userList: userList));
      } catch (error) {
        emit(UserErrorState(error: error.toString()));
      }
    });
  }

  Future<List<User>> _fetchUserList() async {
    List<User> users = <User>[];

    try {
      users = await _userRepositoryImpl.getAllUsers();
      return users;
    } catch (e) {
      throw Exception('Ocorreu um erro ao buscar usuários!');
    }
  }
}
