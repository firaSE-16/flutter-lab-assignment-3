import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:album/core/utils/extensions.dart';
import 'package:album/domain/entities/album.dart';

class AlbumCard extends StatelessWidget {
  final Album album;
  final VoidCallback onTap;

  const AlbumCard({Key? key, required this.album, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.teal.shade100,
          child: const Icon(Icons.photo_album, color: Colors.teal),
        ),
        title: Text(
          album.title.capitalize(),
          style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }
}