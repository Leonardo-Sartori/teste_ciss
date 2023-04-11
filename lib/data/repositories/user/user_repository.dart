import 'package:teste_ciss/data/models/user.dart';

abstract class UserRepository {
  Future<List<User>> getAllUsers();
}