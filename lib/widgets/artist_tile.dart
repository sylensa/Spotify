import 'package:flutter/material.dart';
import 'package:spotify/core/helper/helper.dart';
import 'package:spotify/models/artist_model.dart';

class ArtistTile extends StatelessWidget {
  final Artist artist;
  const ArtistTile({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: displayImage(artist.images?.firstOrNull,radius: 30),
      title: appText("${artist.name}",color: Colors.white,size: 166,weight: FontWeight.w600),
    );
  }
}
