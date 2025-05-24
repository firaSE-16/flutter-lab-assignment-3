import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:album/core/utils/extensions.dart';
import 'package:album/presentation/bloc/album_bloc.dart';
import 'package:album/presentation/bloc/album_event.dart';
import 'package:album/presentation/bloc/album_state.dart';
import 'package:album/presentation/widgets/error_widget.dart';
import 'package:album/presentation/widgets/loading_widget.dart';
import 'package:album/presentation/widgets/photo_grid_item.dart';

class AlbumDetailPage extends StatelessWidget {
  final int albumId;
  final String albumTitle;

  const AlbumDetailPage({Key? key, required this.albumId, required this.albumTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          albumTitle.capitalize(),
          style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          if (state is AlbumInitial || state is AlbumLoaded) {
            context.read<AlbumBloc>().add(FetchPhotos(albumId));
            return const LoadingWidget();
          } else if (state is AlbumLoading) {
            return const LoadingWidget();
          } else if (state is PhotosLoaded) {
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              itemCount: state.photos.length,
              itemBuilder: (context, index) {
                final photo = state.photos[index];
                return PhotoGridItem(
                  photoTitle: photo.title,
                  photoUrl: photo.thumbnailUrl,
                );
              },
            );
          } else if (state is AlbumError) {
            return CustomErrorWidget(
              message: state.message,
              onRetry: () => context.read<AlbumBloc>().add(FetchPhotos(albumId)),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}