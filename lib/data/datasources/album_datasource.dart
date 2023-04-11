import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:teste_ciss/data/models/album.dart';
import 'package:teste_ciss/data/models/user.dart';
import 'package:teste_ciss/data/services/json_placeholder_api/json_placeholder_api.dart';
import 'package:teste_ciss/shared/constants/api.dart';

@injectable
class AlbumDatasource {
  late final JsonPlaceholderApi jsonPlaceholderApi;

  AlbumDatasource({required this.jsonPlaceholderApi});

  Future<List<Album>> getAlbumsByUser({required int userId}) async {
    final response = await jsonPlaceholderApi.client.get(Uri.parse('${ConstantsApi.baseUrl}/users/$userId/albums'));
    final responseData = json.decode(response.body);
    late List<Album> albums = [];

    for (dynamic album in responseData) {
        albums.add(
          Album(
            id: album["id"],
            title: album["title"],
            user: User(id: album["userId"], name: "", username: "", email: "")
          ),
        );
      }
    return albums;
  }
}