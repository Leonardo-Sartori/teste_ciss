
// ignore_for_file: must_be_immutable
import 'package:equatable/equatable.dart';

class User extends Equatable {
  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
  });

  int id = 0;
  String name = "";
  String username = "";
  String email = "";
  
  User.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    username = map['username'];
    email = map['email'];
  }

  @override
  String toString() {
    return name;
  }

  @override
  List<Object?> get props => [id, name, username, email];
}
