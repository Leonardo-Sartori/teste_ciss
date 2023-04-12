import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:teste_ciss/data/models/user.dart';
import 'package:teste_ciss/data/services/json_placeholder_api/json_placeholder_api.dart';
import 'package:teste_ciss/shared/constants/api.dart';

@injectable
class UserDatasource {
  late final JsonPlaceholderApi jsonPlaceholderApi;

  UserDatasource({required this.jsonPlaceholderApi});

  Future<List<User>> getAllUsers() async {
    final response = await jsonPlaceholderApi.client.get(Uri.parse('${ConstantsApi.baseUrl}/users/'));
    final responseData = json.decode(response.body);
    late List<User> users = [];

    for (dynamic user in responseData) {
        users.add(
          User.fromMap(user),
        );
      }
    return users;
  }
}