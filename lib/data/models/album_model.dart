import 'package:equatable/equatable.dart';
import 'package:album/domain/entities/album.dart';

class AlbumModel extends Equatable {
  final int userId;
  final int id;
  final String title;

  AlbumModel({required this.userId, required this.id, required this.title});

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }

  Album toEntity() {
    return Album(userId: userId, id: id, title: title);
  }

  @override
  List<Object> get props => [userId, id, title];
}

class PhotoModel extends Equatable {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  PhotoModel({required this.albumId, required this.id, required this.title, required this.url, required this.thumbnailUrl});

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      albumId: json['albumId'],
      id: json['id'],
      title: json['title'],
      url: json['url'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }

  @override
  List<Object> get props => [albumId, id, title, url, thumbnailUrl];
}