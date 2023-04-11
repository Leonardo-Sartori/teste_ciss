
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

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id == 0 ? null : id;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    return data;
  }

  @override
  String toString() {
    return name;
  }

  @override
  List<Object?> get props => [id, name, username, email];
}
