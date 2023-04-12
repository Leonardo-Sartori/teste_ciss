import 'package:flutter/material.dart';
import 'package:teste_ciss/data/models/photo.dart';
import 'package:teste_ciss/data/models/user.dart';

class PhotoListItem extends StatelessWidget {
  final Photo photo;
  final User user;

  const PhotoListItem({
    Key? key,
    required this.photo,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(photo.thumbnailUrl),
            ),
            title: Text(user.name, style: textStyle()),
            subtitle: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Flexible(child: Text(user.email, style: textStyle())),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(photo.url),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            dense: true,
          ),
        ],
      ),
    );
  }

  TextStyle textStyle() {
    return const TextStyle(fontSize: 15, overflow: TextOverflow.ellipsis);
  }
}
