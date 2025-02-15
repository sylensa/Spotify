import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:spotify/controllers/artist/artist_controller.dart';
import 'package:spotify/core/helper/helper.dart';
import 'package:spotify/widgets/smart_refresh.dart';

class ArtistList extends StatefulWidget {
  final List artists;

  const ArtistList({super.key, required this.artists});

  @override
  State<ArtistList> createState() => _ArtistListState();
}

class _ArtistListState extends State<ArtistList> {
  final RefreshController _refreshController =  RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return SmartRefresh(
      onRefresh: BlocProvider.of<ArtistController>(context, listen: false).onRefresh ,
      onLoading:  BlocProvider.of<ArtistController>(context, listen: false).onLoading,
      refreshController: _refreshController,
      child: ListView.builder(
        itemCount: widget.artists.length,
        itemBuilder: (context, index) {
          final artist = widget.artists[index];
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
