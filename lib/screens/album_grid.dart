import 'package:flutter/material.dart';
import 'package:spotify/core/helper/helper.dart';

class AlbumGrid extends StatelessWidget {
  final List albums;

  AlbumGrid({required this.albums});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        itemCount: albums.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 albums per row
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          final album = albums[index];
          return Card(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: displayImage(album["images"][0]["url"], height: 100,radius: 0),
                ),
                appText(album["name"],),
                appText(album["artists"][0]["name"]),
                appText(album["release_date"].split("-")[0]), // Year
              ],
            ),
          );
        },
      ),
    );
  }
}
