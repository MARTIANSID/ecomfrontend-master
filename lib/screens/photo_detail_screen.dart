import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:photo_view/photo_view.dart';

import 'package:photo_view/photo_view_gallery.dart' as pv;
import 'package:photo_view/photo_view_gallery.dart';

class PhotoDetailScreen extends StatelessWidget {
  final colorKey;
  final product;
  const PhotoDetailScreen(this.colorKey, this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
        child: pv.PhotoViewGallery(
          pageOptions: <PhotoViewGalleryPageOptions>[
            PhotoViewGalleryPageOptions(
              imageProvider: product.imageUrl.containsKey(colorKey)
                  ? AdvancedNetworkImage(
                      product.imageUrl[colorKey],
                      useDiskCache: true,
                      cacheRule: CacheRule(maxAge: const Duration(days: 3)),
                    )
                  : AdvancedNetworkImage(
                      product.imageUrl['yellow'],
                      useDiskCache: true,
                      cacheRule: CacheRule(maxAge: const Duration(days: 3)),
                    ),
              heroAttributes: PhotoViewHeroAttributes(tag: "tag1"),      
            ),
          ],
        ),
      ),
    );
  }
}
