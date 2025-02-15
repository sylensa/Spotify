import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:spotify/controllers/artist/artist_state.dart';
import 'package:spotify/models/artist_model.dart';
import 'package:spotify/repository/artist_repo.dart';



class ArtistController extends Cubit<ArtistState>{
  ArtistController() : super(ArtistEmpty());
  List<Artist> artists = [];
  int page = 1;
  final artistRepo = ArtistRepo();
  Timer? _debounce;

  searchArtists(bool initial,String query )async{
    if(initial){
      artists.clear();
      page = 1;
      emit(ArtistInitial());
    }
    List<Artist> listArtists  = await artistRepo.searchArtist(query: query);
    artists.addAll(listArtists);
    if(artists.isNotEmpty){
      emit(ArtistLoaded(artists: artists));
    }else{
      emit(ArtistEmpty());
    }

  }


  onSearchChanged(String value) async{
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(seconds: 1), () async{
      page = 1;
      await searchArtists(true,value);
    });
  }

  void onRefresh(RefreshController refreshController,String query) async{
    page = 1;
    await searchArtists(true,query);
    refreshController.refreshCompleted();
  }
  void onLoading(RefreshController refreshController,String query) async{
    page++;
    await searchArtists(false,query);
    refreshController.loadComplete();
  }

}