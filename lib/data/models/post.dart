
// ignore_for_file: must_be_immutable
import 'package:equatable/equatable.dart';
import 'package:teste_ciss/data/models/user.dart';

class Post extends Equatable {
  Post({
    required this.id,
    required this.title,
    required this.body,
    required this.user,
  });

  int id = 0;
  String title = "";
  String body = "";
  User user = User(id: 0, name: "", username: "", email: "");
  
  Post.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    body = map['body'];
    user = User(id: map['userId'], name: "", username: "", email: "");
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['body'] = body;
    data['userId'] = user.id;
    return data;
  }

  @override
  String toString() {
    return "\n {\n id: $id, \n título: $title, \n corpo: $body \n}";
  }

  @override
  List<Object?> get props => [id, title, body, user];
}
