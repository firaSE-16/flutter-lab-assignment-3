import 'package:album/data/models/album_model.dart';
import 'package:album/domain/entities/album.dart';
import 'package:album/domain/repositories/album_repository.dart';

class GetAlbums {
  final AlbumRepository repository;

  GetAlbums(this.repository);

  Future<List<Album>> call() async {
    return await repository.getAlbums();
  }

  Future<List<PhotoModel>> getPhotos(int albumId) async {
    return await repository.getPhotos(albumId);
  }
}