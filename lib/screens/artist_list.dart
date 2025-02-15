import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:spotify/controllers/artist/artist_controller.dart';
import 'package:spotify/controllers/artist/artist_state.dart';
import 'package:spotify/core/helper/helper.dart';
import 'package:spotify/widgets/artist_shimmering.dart';
import 'package:spotify/widgets/artist_tile.dart';
import 'package:spotify/widgets/smart_refresh.dart';

class ArtistList extends StatefulWidget {
  final String query;
  const ArtistList({super.key, required this.query});


  @override
  State<ArtistList> createState() => _ArtistListState();
}

class _ArtistListState extends State<ArtistList> {
  final RefreshController _refreshController =  RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArtistController,ArtistState>(builder: (context,state){
      if(state is ArtistLoaded){
        return SmartRefresh(
          onRefresh: (){
            BlocProvider.of<ArtistController>(context, listen: false).onRefresh(_refreshController,widget.query);
          } ,
          onLoading: (){
            BlocProvider.of<ArtistController>(context, listen: false).onLoading(_refreshController,widget.query);
          },
          refreshController: _refreshController,
          child: ListView.builder(
            itemCount: state.artists.length,
            itemBuilder: (context, index) {
              final artist = state.artists[index];
              return ArtistTile(artist: artist,);
            },
          ),
        );
      }
      else if(state is ArtistInitial){
        return Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return ArtistShimmering();
            },
          ),
        );

      }
      else if(state is ArtistEmpty){
        return Expanded(child: Center(child: appText("No data",color: Colors.white,size: 16,weight: FontWeight.w600),));
      }
      else{
       return SizedBox.shrink();
      }

    });
  }
}
