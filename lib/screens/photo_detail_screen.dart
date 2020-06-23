import 'package:flutter/material.dart';

import 'package:photo_view/photo_view_gallery.dart' as pv;

class PhotoDetailScreen extends StatelessWidget {
  
  final List<String> assetPath;

  const PhotoDetailScreen(this.assetPath);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
         child: pv.PhotoViewGallery(),
      ),
    );
  }
}
