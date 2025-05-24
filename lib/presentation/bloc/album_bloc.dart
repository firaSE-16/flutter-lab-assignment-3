import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:album/data/models/album_model.dart';
import 'package:album/domain/entities/album.dart';
import 'package:album/domain/usercases/get_albums.dart';
import 'package:album/presentation/bloc/album_event.dart';
import 'package:album/presentation/bloc/album_state.dart';
import 'dart:developer' as developer;

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final GetAlbums getAlbums;

  AlbumBloc(this.getAlbums) : super(AlbumInitial()) {
    on<FetchAlbums>(_onFetchAlbums);
    on<FetchPhotos>(_onFetchPhotos);
  }

  Future<void> _onFetchAlbums(FetchAlbums event, Emitter<AlbumState> emit) async {
    emit(AlbumLoading());
    try {
      developer.log('Fetching albums...', name: 'AlbumBloc');
      final albums = await getAlbums();
      developer.log('Albums fetched successfully: ${albums.length} albums', name: 'AlbumBloc');
      emit(AlbumLoaded(albums));
    } catch (e) {
      developer.log('Error fetching albums: $e', name: 'AlbumBloc');
      emit(AlbumError('Failed to load albums: ${e.toString()}'));
    }
  }

  Future<void> _onFetchPhotos(FetchPhotos event, Emitter<AlbumState> emit) async {
    emit(AlbumLoading());
    try {
      developer.log('Fetching photos for albumId: ${event.albumId}', name: 'AlbumBloc');
      final photos = await getAlbums.getPhotos(event.albumId);
      developer.log('Photos fetched successfully: ${photos.length} photos', name: 'AlbumBloc');
      emit(PhotosLoaded(photos));
    } catch (e) {
      developer.log('Error fetching photos: $e', name: 'AlbumBloc');
      emit(AlbumError('Failed to load photos: ${e.toString()}'));
    }
  }
}