import 'package:flutter/material.dart';
import 'package:spotify/core/helper/helper.dart';

class ArtistList extends StatelessWidget {
  final List artists;

  const ArtistList({super.key, required this.artists});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: artists.length,
        itemBuilder: (context, index) {
          final artist = artists[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(artist["images"].isNotEmpty ? artist["images"][0]["url"] : ""),
            ),
            title: Text(artist["name"]),
          );
        },
      ),
    );
  }
}
