import 'dart:async';
import 'package:flutter/material.dart';
import 'package:teste_ciss/data/models/post.dart';
import 'package:teste_ciss/data/models/user.dart';

class PostListItem extends StatelessWidget {
  final Post post;
  final User user;
  final Function getComments;

  final loadingErrorImage = StreamController<String>.broadcast();

  PostListItem({
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
          StreamBuilder<String>(
              stream: loadingErrorImage.stream,
              builder: (context, snapshot) {
                return ListTile(
                  title: Text(post.title, style: textStyle()),
                  subtitle: Text(post.body),
                  dense: true,
                );
              }),
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
    return const TextStyle(fontSize: 15, overflow: TextOverflow.ellipsis);
  }
}
