import 'package:flutter/material.dart';

class SingleImageView extends StatelessWidget {
  String image;
  SingleImageView({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: BackButton(),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(image)
      ),
    );
  }
}