import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/controllers/album/album_controller.dart';
import 'package:spotify/controllers/artist/artist_controller.dart';
import 'package:spotify/controllers/authentication/authentication_controller.dart';
import 'package:spotify/core/helper/helper.dart';
import 'package:spotify/core/tab_bar_controller.dart';
import 'package:spotify/screens/album_grid.dart';
import 'package:spotify/screens/artist_list.dart';
import 'package:spotify/screens/connectivity_screen.dart';
import 'package:spotify/widgets/search_bar.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isSearchingAlbums = true; // Toggle between albums & artists
  bool albumTapped = false;
  bool artistTaped = false;
 final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityScreen(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: false,
            backgroundColor: Colors.black,
            title: appText("Search",weight: FontWeight.w700,color: Colors.white,size: 30)
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Column(
            children: [
              // Search Bar
              SearchBarWidget(
                searchController: searchController,
                onChanged: (searchString){
                 setState(() {
                   if(searchString.isNotEmpty){
                     artistTaped = false;
                     albumTapped = false;
                     if(isSearchingAlbums){
                       albumTapped = true;
                       BlocProvider.of<AlbumController>(context, listen: false).onSearchChanged(searchString);
                     }else{
                       artistTaped = true;
                       BlocProvider.of<ArtistController>(context, listen: false).onSearchChanged(searchString);
                     }
                   }

                 });

                },
              ),

              SizedBox(height: 20,),

              // Results Display (Albums or Artists)
              if(searchController.text.isNotEmpty)
              Expanded(
                child: SellItOptionsLab(
                  index: isSearchingAlbums ? 0 : 1,
                 options: ["Albums","Artist"],
                  onChange: (index){
                    setState(() {
                      isSearchingAlbums = index == 0;
                      if(isSearchingAlbums && !albumTapped){
                        albumTapped = true;
                        BlocProvider.of<AlbumController>(context, listen: false).onSearchChanged(searchController.text);
                      }
                      else if(!artistTaped){
                        artistTaped = true;
                        BlocProvider.of<ArtistController>(context, listen: false).onSearchChanged(searchController.text);
                      }
                    });
                  },
                  children: [
                     AlbumGrid(query: searchController.text,),
                     ArtistList(query: searchController.text,)
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
