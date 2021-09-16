import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geeksday/provider/theme_provider.dart';
import 'package:geeksday/routes.dart';
import 'package:geeksday/ui/user_profile.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget avatarWidget() {
    String rawSvg = multiavatar(DateTime.now().toIso8601String());
    return SvgPicture.string(rawSvg);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Column(
      children: [
        SizedBox(height: 100.0),
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
                  style: Theme.of(context).textTheme.headline3,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20.0),
        ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return UserProfile();
                },
              ),
            );
          },
          leading: Icon(Icons.person, color: Theme.of(context).iconTheme.color),
          title: Text(
            "Profile",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, Routes.settings);
          },
          leading:
              Icon(Icons.settings, color: Theme.of(context).iconTheme.color),
          title: Text(
            "Settings",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        ListTile(
          onTap: () {},
          leading: Icon(Icons.logout, color: Theme.of(context).iconTheme.color),
          title: Text(
            "Logout",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Switch(
          value: themeProvider.isDarkMode,
          onChanged: (value) {
            final provider = Provider.of<ThemeProvider>(context, listen: false);
            provider.toggleTheme(value);
          },
        ),
      ],
    );
  }
}
