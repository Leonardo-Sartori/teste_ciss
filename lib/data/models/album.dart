
// ignore_for_file: must_be_immutable
import 'package:equatable/equatable.dart';
import 'package:teste_ciss/data/models/user.dart';

class Album extends Equatable {
  Album({
    required this.id,
    required this.title,
    required this.user,
  });

  int id = 0;
  String title = "";
  User user = User(id: 0, name: "", username: "", email: "");
  
  Album.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    user = User(id: map['userId'], name: "", username: "", email: "");
  }

  @override
  String toString() {
    return title;
  }

  @override
  List<Object?> get props => [id, title, user];
}
