import 'package:flutter/material.dart';
import 'package:teste_ciss/data/models/user.dart';

class UserListItem extends StatelessWidget {
  final User user;
  final Function getPosts;
  final Function getAlbums;

  const UserListItem({
    Key? key,
    required this.user,
    required this.getPosts,
    required this.getAlbums,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          ListTile(
            title: Text(user.name, style: textStyle()),
            subtitle: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Flexible(child: Text(user.username, style: textStyle())),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Flexible(child: Text(user.email, style: textStyle())),
                  ],
                ),
              ],
            ),
            dense: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                  child: const Text('ÁLBUNS'),
                  onPressed: () {
                    getAlbums();
                  }),
              const SizedBox(width: 8),
              TextButton(
                  child: const Text('POSTS'),
                  onPressed: () {
                    getPosts();
                  }),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }

  TextStyle textStyle() {
    return const TextStyle(fontSize: 15, overflow: TextOverflow.ellipsis);
  }
}
