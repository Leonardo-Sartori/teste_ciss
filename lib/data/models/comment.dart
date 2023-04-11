
// ignore_for_file: must_be_immutable
import 'package:equatable/equatable.dart';
import 'package:teste_ciss/data/models/post.dart';
import 'package:teste_ciss/data/models/user.dart';

class Comment extends Equatable {
  Comment({
    required this.id,
    required this.name,
    required this.email,
    required this.body,
    required this.post,
  });

  int id = 0;
  String name = "";
  String email = "";
  String body = "";
  Post post = Post(id: 0, title: "", body: '', user: User(id: 0, name: "", username: "", email: ""));
  
  Comment.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    email = map['email'];
    body = map['body'];
    post = Post(id: map["postId"], title: "", body: '', user: User(id: 0, name: "", username: "", email: ""));
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id == 0 ? null : id;
    data['name'] = name;
    data['email'] = email;
    data['body'] = body;
    data['postId'] = post.id;
    return data;
  }

  @override
  String toString() {
    return name;
  }

  @override
  List<Object?> get props => [id, name, email, body, post];
}
