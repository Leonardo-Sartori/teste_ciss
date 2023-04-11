
// ignore_for_file: must_be_immutable
import 'package:equatable/equatable.dart';
import 'package:teste_ciss/data/models/album.dart';
import 'package:teste_ciss/data/models/user.dart';

class Photo extends Equatable {
  Photo({
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
    required this.album,
  });

  int id = 0;
  String title = "";
  String url = "";
  String thumbnailUrl = "";
  Album album = Album(id: 0, title: "", user: User(id: 0, name: "", username: "", email: ""));
  
  Photo.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    url = map['url'];
    thumbnailUrl = map['thumbnailUrl'];
    album = Album(id: map['albumId'], title: "", user: User(id: 0, name: "", username: "", email: ""));
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id == 0 ? null : id;
    data['title'] = title;
    data['url'] = url;
    data['thumbnailUrl'] = thumbnailUrl;
    data['albumId'] = album.id;
    return data;
  }

  @override
  String toString() {
    return title;
  }

  @override
  List<Object?> get props => [id, title, url, thumbnailUrl, album];
}
