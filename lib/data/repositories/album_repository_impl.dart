import 'package:album/core/errors/exceptions.dart';
import 'package:album/data/datasources/album_remote_data_source.dart';
import 'package:album/data/models/album_model.dart';
import 'package:album/domain/entities/album.dart';
import 'package:album/domain/repositories/album_repository.dart';

class AlbumRepositoryImpl implements AlbumRepository {
  final AlbumRemoteDataSource remoteDataSource;

  AlbumRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Album>> getAlbums() async {
    try {
      final albumModels = await remoteDataSource.getAlbums();
      return albumModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<PhotoModel>> getPhotos(int albumId) async {
    try {
      return await remoteDataSource.getPhotos(albumId);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}