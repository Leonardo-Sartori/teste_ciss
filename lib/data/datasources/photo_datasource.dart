import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:teste_ciss/data/models/album.dart';
import 'package:teste_ciss/data/models/photo.dart';
import 'package:teste_ciss/data/models/user.dart';
import 'package:teste_ciss/data/services/json_placeholder_api/json_placeholder_api.dart';
import 'package:teste_ciss/shared/constants/api.dart';

@injectable
class PhotoDatasource {
  late final JsonPlaceholderApi jsonPlaceholderApi;

  PhotoDatasource({required this.jsonPlaceholderApi});

  Future<List<Photo>> getPhotosByAlbum({required int albumId}) async {
    final response = await jsonPlaceholderApi.client.get(Uri.parse('${ConstantsApi.baseUrl}/albums/$albumId/photos'));
    final responseData = json.decode(response.body);
    late List<Photo> photos = [];

    for (dynamic photo in responseData) {
        photos.add(
          Photo(id: photo["id"], 
          title: photo["title"], 
          url: photo["url"], 
          thumbnailUrl: photo["thumbnailUrl"],
          album: Album(id: photo["albumId"], title: "", user: User(id: 0, name: "", username: "", email: "")),
        )
        );
      }
    return photos;
  }
}