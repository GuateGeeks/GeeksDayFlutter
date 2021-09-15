import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  static Widget create(BuildContext context) {
    return Settings();
  }

  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GeeksDay'),
        actions: [],
      ),
    );
  }
}
