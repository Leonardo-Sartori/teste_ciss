import 'package:teste_ciss/data/models/user.dart';

abstract class UserState {
  List<User> userList = <User>[];

  UserState({
    required this.userList,
  });
}

class UserInitialState extends UserState {
  UserInitialState() : super(userList: []);
}

class UserLoadingState extends UserState {
  UserLoadingState({required List<User> userList}) : super(userList: userList);
}
class UserSuccessState extends UserState {
  UserSuccessState({required List<User> userList}) : super(userList: userList);
}

class UserErrorState extends UserState {
  UserErrorState({required String error}) : super(userList: []);
}
