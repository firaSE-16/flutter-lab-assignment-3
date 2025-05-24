import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:album/core/constants/app_constants.dart';
import 'package:album/core/errors/exceptions.dart';
import 'package:album/data/models/album_model.dart';

abstract class AlbumRemoteDataSource {
  Future<List<AlbumModel>> getAlbums();
  Future<List<PhotoModel>> getPhotos(int albumId);
}

class AlbumRemoteDataSourceImpl implements AlbumRemoteDataSource {
  final http.Client client;

  AlbumRemoteDataSourceImpl(this.client);

  @override
  Future<List<AlbumModel>> getAlbums() async {
    try {
      final response = await client
          .get(Uri.parse(AppConstants.baseUrl + AppConstants.albumsEndpoint))
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final jsonList = json.decode(response.body) as List;
        return jsonList.map((json) => AlbumModel.fromJson(json)).toList();
      } else {
        throw ServerException('Failed to load albums: ${response.statusCode}');
      }
    } catch (e) {
      throw NetworkException('Network error: $e');
    }
  }

  @override
  Future<List<PhotoModel>> getPhotos(int albumId) async {
    try {
      final response = await client
          .get(Uri.parse('${AppConstants.baseUrl}${AppConstants.photosEndpoint}?albumId=$albumId'))
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final jsonList = json.decode(response.body) as List;
        return jsonList.map((json) => PhotoModel.fromJson(json)).toList();
      } else {
        throw ServerException('Failed to load photos: ${response.statusCode}');
      }
    } catch (e) {
      throw NetworkException('Network error: $e');
    }
  }
}