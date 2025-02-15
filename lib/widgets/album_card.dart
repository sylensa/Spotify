import 'package:flutter/material.dart';
import 'package:spotify/core/helper/helper.dart';
import 'package:spotify/models/album_model.dart';

class AlbumCard extends StatelessWidget {
  final Album album;
  const AlbumCard({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: displayImage(album.images?.firstOrNull, height: 100,radius: 0),
          ),
          appText(album.name,),
          appText("${album.artists?.first.name}"),
          appText("${album.releaseDate?.split("-")[0]}"), // Year
        ],
      ),
    );
  }
}
