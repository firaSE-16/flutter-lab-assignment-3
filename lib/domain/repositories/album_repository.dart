import 'package:album/data/models/album_model.dart';
import 'package:album/domain/entities/album.dart';

abstract class AlbumRepository {
  Future<List<Album>> getAlbums();
  Future<List<PhotoModel>> getPhotos(int albumId);
}