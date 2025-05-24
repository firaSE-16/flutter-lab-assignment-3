import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:album/core/utils/extensions.dart';
import 'package:album/presentation/bloc/album_bloc.dart';
import 'package:album/presentation/bloc/album_event.dart';
import 'package:album/presentation/bloc/album_state.dart';
import 'package:album/presentation/widgets/album_card.dart';
import 'package:album/presentation/widgets/error_widget.dart';
import 'package:album/presentation/widgets/loading_widget.dart';
import 'dart:developer' as developer;

class AlbumsPage extends StatefulWidget {
  const AlbumsPage({Key? key}) : super(key: key);

  @override
  _AlbumsPageState createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<AlbumsPage> {
  @override
  void initState() {
    super.initState();
    // Trigger FetchAlbums when the page is loaded or navigated back to
    developer.log('AlbumsPage initialized, triggering FetchAlbums', name: 'AlbumsPage');
    context.read<AlbumBloc>().add(FetchAlbums());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Photo Albums',
          style: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
      ),
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          developer.log('Current state: ${state.runtimeType}', name: 'AlbumsPage');
          if (state is AlbumInitial) {
            // Ensure albums are fetched after a slight delay to allow state processing
            WidgetsBinding.instance.addPostFrameCallback((_) {
              developer.log('Triggering FetchAlbums from AlbumInitial state', name: 'AlbumsPage');
              context.read<AlbumBloc>().add(FetchAlbums());
            });
            return const LoadingWidget();
          } else if (state is AlbumLoading) {
            return const LoadingWidget();
          } else if (state is AlbumLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.albums.length,
              itemBuilder: (context, index) {
                final album = state.albums[index];
                return AlbumCard(
                  album: album,
                  onTap: () {
                    developer.log('Navigating to album: ${album.id}', name: 'AlbumsPage');
                    context.go('/album/${album.id}', extra: album.title);
                  },
                );
              },
            );
          } else if (state is AlbumError) {
            return CustomErrorWidget(
              message: state.message,
              onRetry: () {
                developer.log('Retry triggered', name: 'AlbumsPage');
                context.read<AlbumBloc>().add(FetchAlbums());
              },
            );
          } else {
            // Handle unexpected states (e.g., PhotosLoaded when on AlbumsPage)
            developer.log('Unexpected state: ${state.runtimeType}, triggering FetchAlbums', name: 'AlbumsPage');
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<AlbumBloc>().add(FetchAlbums());
            });
            return const LoadingWidget();
          }
        },
      ),
    );
  }
}