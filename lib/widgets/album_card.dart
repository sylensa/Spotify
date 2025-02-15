import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:spotify/core/helper/helper.dart';
import 'package:spotify/models/album_model.dart';

class AlbumCard extends StatelessWidget {
  final Album album;
  const AlbumCard({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: displayImage(album.images?.firstOrNull?.url, height: 200,radius: 0)),
       Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           SizedBox(height: 10,),
           appText(album.name,color: Colors.white,weight: FontWeight.bold),
           SizedBox(height: 5,),
           appText("${album.artists?.first.name}",color: Colors.grey),
           SizedBox(height: 5,),
           appText("${album.releaseDate?.split("-")[0]}",color: Colors.grey),
         ],
       ) // Year
      ],
    );
  }
}
