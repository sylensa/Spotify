

import 'package:spotify/models/album_model.dart';

abstract class AlbumState {}

class AlbumInitial extends AlbumState {}

class AlbumLoading extends AlbumState {}
class AlbumEmpty extends AlbumState {}

class AlbumLoaded extends AlbumState {
  List<Album> albums;
  AlbumLoaded({this.albums = const []});
}




