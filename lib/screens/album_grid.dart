import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:spotify/controllers/album/album_controller.dart';
import 'package:spotify/controllers/album/album_state.dart';
import 'package:spotify/core/helper/helper.dart';
import 'package:spotify/widgets/album_card.dart';
import 'package:spotify/widgets/album_shimmering.dart';
import 'package:spotify/widgets/smart_refresh.dart';

class AlbumGrid extends StatefulWidget {
  const AlbumGrid({super.key});

  @override
  State<AlbumGrid> createState() => _AlbumGridState();
}

class _AlbumGridState extends State<AlbumGrid> {
  final RefreshController _refreshController =  RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumController,AlbumState>(builder: (context,state){
      if(state is AlbumLoaded){
        return SmartRefresh(
          onRefresh: BlocProvider.of<AlbumController>(context, listen: false).onRefresh ,
          onLoading:  BlocProvider.of<AlbumController>(context, listen: false).onLoading,
          refreshController: _refreshController,
          child: GridView.builder(
            itemCount: state.albums.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 albums per row
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final album = state.albums[index];
              return AlbumCard(album: album,);
            },
          ),
        );
      }
      else if(state is AlbumInitial){
        return  Expanded(
          child: GridView.builder(
            itemCount:10,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 albums per row
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              return  AlbumShimmering();
            },
          ),
        );

      }
      else if(state is AlbumEmpty){
        return Expanded(child: Center(child: appText("No data",color: Colors.white,size: 16,weight: FontWeight.w600),));
      }
      else{
        return SizedBox.shrink();
      }
    });
  }
}
