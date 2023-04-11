import 'package:injectable/injectable.dart';
import 'package:teste_ciss/data/datasources/user_datasource.dart';
import 'package:teste_ciss/data/models/user.dart';
import 'package:teste_ciss/data/repositories/user/user_repository.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl implements UserRepository{

  final UserDatasource userDatasource;

  UserRepositoryImpl({required this.userDatasource});
  
  @override
  Future<List<User>> getAllUsers() async {
    return userDatasource.getAllUsers();
  }

}