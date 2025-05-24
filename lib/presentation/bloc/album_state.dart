import 'package:equatable/equatable.dart';
import 'package:album/data/models/album_model.dart';
import 'package:album/domain/entities/album.dart';

abstract class AlbumState extends Equatable {
  @override
  List<Object> get props => [];
}

class AlbumInitial extends AlbumState {}

class AlbumLoading extends AlbumState {}

class AlbumLoaded extends AlbumState {
  final List<Album> albums;

  AlbumLoaded(this.albums);

  @override
  List<Object> get props => [albums];
}

class PhotosLoaded extends AlbumState {
  final List<PhotoModel> photos;

  PhotosLoaded(this.photos);

  @override
  List<Object> get props => [photos];
}

class AlbumError extends AlbumState {
  final String message;

  AlbumError(this.message);

  @override
  List<Object> get props => [message];
}