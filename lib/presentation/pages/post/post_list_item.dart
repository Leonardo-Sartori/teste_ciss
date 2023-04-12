import 'package:flutter/material.dart';
import 'package:teste_ciss/data/models/post.dart';
import 'package:teste_ciss/data/models/user.dart';

class PostListItem extends StatelessWidget {
  final Post post;
  final User user;
  final Function getComments;

  const PostListItem({
    Key? key,
    required this.post,
    required this.user,
    required this.getComments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          ListTile(
            title: Text(post.title, style: fontWeightBold()),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(post.body, style: textStyle(),),
            ),
            dense: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                  child: const Text('COMENTÁRIOS'),
                  onPressed: () {
                    getComments();
                  }),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }

  TextStyle textStyle() {
    return const TextStyle(fontSize: 15);
  }

  TextStyle fontWeightBold() {
    return const TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
  }
}
