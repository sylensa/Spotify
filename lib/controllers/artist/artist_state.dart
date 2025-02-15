


import 'package:spotify/models/artist_model.dart';

abstract class ArtistState {}

class ArtistInitial extends ArtistState {}

class ArtistLoading extends ArtistState {}
class ArtistEmpty extends ArtistState {}

class ArtistLoaded extends ArtistState {
  final List<Artist> artists;
  ArtistLoaded({this.artists = const[]});
}




