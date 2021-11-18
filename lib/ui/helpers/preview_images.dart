
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
      return Container(
        child: Image.network(blobImage.url, width: 50, height: 250),
      );
    }
    return Container();
  }
}