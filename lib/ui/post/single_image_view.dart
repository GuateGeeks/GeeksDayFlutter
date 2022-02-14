import 'package:flutter/material.dart';
import 'package:geeksday/ui/helpers/return_button.dart';

class SingleImageView extends StatelessWidget {
  String image;
  SingleImageView({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: ReturnButton(), 
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(image)
      ),
    );
  }
}