import 'package:flutter/material.dart';
// import 'package:flutter_advanced_networkimage/provider.dart';
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
              maxScale: PhotoViewComputedScale.contained * 5.0,
              minScale: PhotoViewComputedScale.contained * 0.5,
              imageProvider: product.imageUrl.containsKey(colorKey)
                  ? NetworkImage(
                      product.imageUrl[colorKey],
                    )
                  : NetworkImage(
                      product.imageUrl['yellow'],
                    ),
              //     product.imageUrl[colorKey],
              //     useDiskCache: true,
              //     cacheRule: CacheRule(maxAge: const Duration(days: 3)),
              //   )
              // : AdvancedNetworkImage(
              //     product.imageUrl['yellow'],
              //     useDiskCache: true,
              //     cacheRule: CacheRule(maxAge: const Duration(days: 3)),
              //   ),
              heroAttributes: PhotoViewHeroAttributes(tag: "tag1"),
            ),
          ],
        ),
      ),
    );
  }
}

// 9791055441
// vanitha r statistics
