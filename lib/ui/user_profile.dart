import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/ui/edit_profile.dart';
import 'package:multiavatar/multiavatar.dart';

class UserProfile extends StatelessWidget {
  static Widget create(BuildContext context) {
    return const UserProfile();
  }

  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("You Profile"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return EditProfile();
                  },
                ),
              );
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: BodyUserProfile(),
    );
  }
}

class BodyUserProfile extends StatelessWidget {
  const BodyUserProfile({Key? key}) : super(key: key);

  Widget avatarWidget(randomAvatar) {
    String rawSvg = multiavatar(randomAvatar);
    return SvgPicture.string(rawSvg);
  }

  @override
  Widget build(BuildContext context) {
    var userData = BlocProvider.of<AuthCubit>(context).getUser();
    String randomAvatar = userData.image;

    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 450,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: []),
              )
            ],
          ),
          CustomPaint(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            painter: HeaderCurvedContainer(),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 120.0,
                ),
                CircleAvatar(
                  radius: 60.0,
                  child: avatarWidget(randomAvatar),
                ),
                SizedBox(height: 5.0),
                userDataProfile(context, userData),
                SizedBox(height: 30.0),
                userInformation(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget userDataProfile(context, userData) {
    return Container(
      child: Column(
        children: [
          Text(
            userData.name,
            style: Theme.of(context).textTheme.headline3,
          ),
          Text(
            userData.email,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }

  Widget userInformation(context) {
    return Container(
      width: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            Text(
              "60",
              style: Theme.of(context).textTheme.headline2,
            ),
            Text(
              "Post",
              style: Theme.of(context).textTheme.caption,
            )
          ]),
          Column(children: [
            Text(
              "60",
              style: Theme.of(context).textTheme.headline2,
            ),
            Text(
              "You Like",
              style: Theme.of(context).textTheme.caption,
            )
          ]),
          Column(children: [
            Text(
              "10",
              style: Theme.of(context).textTheme.headline2,
            ),
            Text(
              "Followers",
              style: Theme.of(context).textTheme.caption,
            )
          ]),
        ],
      ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.blue;
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
