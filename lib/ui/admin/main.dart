import 'package:flutter/material.dart';
import 'package:geeksday/ui/guategeeks/elements.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 700 ? 700 : width;
    return GuateGeeksScaffold(body: const Center(child: Text("admin page")));
  }
}
