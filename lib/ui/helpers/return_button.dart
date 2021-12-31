import 'package:flutter/material.dart';

class ReturnButton extends StatelessWidget {
  const ReturnButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(  
      builder: (context){
        return IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
          tooltip: 'Regresar',
        );
      }
    );
  }
}
