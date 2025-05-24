import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PhotoGridItem extends StatelessWidget {
  final String photoTitle;
  final String photoUrl;

  const PhotoGridItem({Key? key, required this.photoTitle, required this.photoUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: const Icon(Icons.image, size: 80, color: Colors.teal),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              photoTitle,
              style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}