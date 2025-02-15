

abstract class AlbumState {}

class AlbumInitial extends AlbumState {}

class AlbumLoading extends AlbumState {}
class AlbumEmpty extends AlbumState {}

class AlbumLoaded extends AlbumState {
  AlbumLoaded();
}




