import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geeksday/routes.dart';
import 'package:multiavatar/multiavatar.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget avatarWidget() {
    String rawSvg = multiavatar(DateTime.now().toIso8601String());
    return SvgPicture.string(rawSvg);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Padding(
            padding: EdgeInsets.only(top: 40.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50.0,
                  child: avatarWidget(),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "User name",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20.0),
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, Routes.userProfile);
          },
          leading: Icon(Icons.person, color: Colors.black),
          title: Text("Profile"),
        ),
        ListTile(
          onTap: () {},
          leading: Icon(Icons.settings, color: Colors.black),
          title: Text("Settings"),
        ),
        ListTile(
          onTap: () {},
          leading: Icon(Icons.logout, color: Colors.black),
          title: Text("Logout"),
        ),
      ],
    );
  }
}
