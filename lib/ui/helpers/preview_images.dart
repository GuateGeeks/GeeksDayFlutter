//file to show a preview of the images before uploading them to the database
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:image_whisperer/image_whisperer.dart';

class PreviewImage extends StatelessWidget {
  final File? uploadedImage;
  const PreviewImage({Key? key, this.uploadedImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (uploadedImage != null) {
      BlobImage blobImage =
          new BlobImage(uploadedImage, name: uploadedImage!.name);
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          blobImage.url,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    }
    return Container();
  }
}
