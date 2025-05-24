import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:album/data/datasources/album_remote_data_source.dart';
import 'package:album/data/repositories/album_repository_impl.dart';
import 'package:album/domain/usercases/get_albums.dart';
import 'package:album/presentation/bloc/album_bloc.dart';
import 'package:album/presentation/router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final client = http.Client();
    final remoteDataSource = AlbumRemoteDataSourceImpl(client);
    final repository = AlbumRepositoryImpl(remoteDataSource);
    final getAlbums = GetAlbums(repository);

    return BlocProvider(
      create: (context) => AlbumBloc(getAlbums),
      child: MaterialApp.router(
        title: 'Photo Album App',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          scaffoldBackgroundColor: Colors.grey.shade100,
          useMaterial3: true,
        ),
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}