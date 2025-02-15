import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:spotify/controllers/album/album_controller.dart';
import 'package:spotify/core/helper/helper.dart';
import 'package:spotify/widgets/smart_refresh.dart';

class AlbumGrid extends StatefulWidget {
  final List albums;

  AlbumGrid({required this.albums});

  @override
  State<AlbumGrid> createState() => _AlbumGridState();
}

class _AlbumGridState extends State<AlbumGrid> {
  final RefreshController _refreshController =  RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return SmartRefresh(
      onRefresh: BlocProvider.of<AlbumController>(context, listen: false).onRefresh ,
      onLoading:  BlocProvider.of<AlbumController>(context, listen: false).onLoading,
      refreshController: _refreshController,
      child: GridView.builder(
        itemCount: widget.albums.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 albums per row
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          final album = widget.albums[index];
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
