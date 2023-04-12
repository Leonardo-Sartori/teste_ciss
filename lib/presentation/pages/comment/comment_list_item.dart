import 'package:flutter/material.dart';
import 'package:teste_ciss/data/models/comment.dart';
import 'package:teste_ciss/data/models/post.dart';
import 'package:teste_ciss/data/models/user.dart';

class CommentListItem extends StatelessWidget {
  final User user;
  final Post post;
  final Comment comment;

  const CommentListItem({
    Key? key,
    required this.user,
    required this.post,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(comment.email, style: fontWeightBold()),
              ],
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(comment.body, style: textStyle()),
            )
          ],
        ),
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
