import 'dart:async';
import 'package:flutter/material.dart';
import 'package:teste_ciss/data/models/album.dart';
import 'package:teste_ciss/data/models/user.dart';

class AlbumListItem extends StatelessWidget {
  final User user;
  final Album album;
  final Function getImages;

  const AlbumListItem({
    Key? key,
    required this.user,
    required this.album,
    required this.getImages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          ListTile(
            title: Text(album.title, style: textStyle()),
            dense: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                  child: const Text('IMAGENS'),
                  onPressed: () {
                    getImages();
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
