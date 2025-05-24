import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:album/presentation/pages/album_detail_page.dart';
import 'package:album/presentation/pages/albums_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AlbumsPage(),
    ),
    GoRoute(
      path: '/album/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        final title = state.extra as String? ?? 'Album';
        return AlbumDetailPage(albumId: id, albumTitle: title);
      },
    ),
  ],
);