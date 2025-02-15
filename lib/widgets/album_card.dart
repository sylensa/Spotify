import 'package:flutter/material.dart';
import 'package:spotify/core/helper/helper.dart';
import 'package:spotify/models/album_model.dart';

class AlbumCard extends StatelessWidget {
  final Album album;
  const AlbumCard({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      child: Column(
        children: [
          Expanded(child: displayImage(album.images?.firstOrNull, height: 100,radius: 0)),
          SizedBox(height: 10,),
          appText(album.name,),
          SizedBox(height: 5,),
          appText("${album.artists?.first.name}"),
          SizedBox(height: 5,),
          appText("${album.releaseDate?.split("-")[0]}"), // Year
        ],
      ),
    );
  }
}
