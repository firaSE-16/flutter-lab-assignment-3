import 'package:equatable/equatable.dart';

class Album extends Equatable {
  final int userId;
  final int id;
  final String title;

  Album({required this.userId, required this.id, required this.title});

  @override
  List<Object> get props => [userId, id, title];
}