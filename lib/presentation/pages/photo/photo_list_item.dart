import 'package:flutter/material.dart';
import 'package:teste_ciss/data/models/photo.dart';


class PhotoListItem extends StatelessWidget {
  final Photo photo;

  const PhotoListItem({
    Key? key,
    required this.photo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          ListTile(
            title: Text(photo.title, style: textStyle()),
            subtitle: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Flexible(child: Text(photo.title, style: textStyle())),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Flexible(child: Text(photo.title, style: textStyle())),
                  ],
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
