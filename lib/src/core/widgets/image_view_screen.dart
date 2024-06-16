import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_boilerplate/src/core/app_theme/app_colors.dart';
import 'package:flutter_boilerplate/src/core/app_utils/app_utils.dart';

class ImageViewScreen extends StatelessWidget {
  final String imageUrls;
  final String activityName;

  const ImageViewScreen({super.key, required this.imageUrls, required this.activityName});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: false,
        titleSpacing: 0.0,
        backgroundColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(
          color: Colors.white, // <= You can change your color here.
        ),
        title: Text(activityName,style: const TextStyle(color: Colors.white,fontSize: 16),),
      ),
      body: PhotoView(
        imageProvider: NetworkImage(imageUrls),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 2,
        loadingBuilder: (context, event) {
          if (event == null) {
            return AppUtils.showSpinner(color: Colors.white);
          } else {
            return Center(
              child: CircularProgressIndicator(
                value: event.cumulativeBytesLoaded / event.expectedTotalBytes!,
              ),
            );
          }
        },
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Icon(Icons.error),
          );
        },
        backgroundDecoration: const BoxDecoration(
          color: Colors.black,
        ),
      ),
    );
  }
}
