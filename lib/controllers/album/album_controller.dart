import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:spotify/controllers/album/album_state.dart';
import 'package:spotify/models/album_model.dart';
import 'package:spotify/repository/album_repo.dart';

class AlbumController extends Cubit<AlbumState>{
  AlbumController() : super(AlbumInitial());
 List<Album> albums = [];
  int page = 1;
  final albumRepo = AlbumRepo();
  Timer? _debounce;
  searchAlbums(bool initial,String query )async{
    if(initial){
      albums.clear();
      page = 1;
      emit(AlbumInitial());
    }
    List<Album> listAlbums  = await albumRepo.searchAlbum(query: query);
    albums.addAll(listAlbums);
    if(albums.isNotEmpty){
      emit(AlbumLoaded(albums: albums));
    }else{
      emit(AlbumEmpty());
    }
  }
  onSearchChanged(String value) async{
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(seconds: 1), () async{
      page = 1;
      await searchAlbums(true,value);
    });
  }
  void onRefresh(RefreshController refreshController,String query) async{
    page = 1;
    await searchAlbums(true,query);
    refreshController.refreshCompleted();
  }
  void onLoading(RefreshController refreshController,String query) async{
    page++;
    await searchAlbums(false,query);
    refreshController.loadComplete();
  }

}