import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        // backgroundColor: Color(0xff555555),
        actions: [
          IconButton(
            onPressed: () {},
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

  Widget avatarWidget() {
    String rawSvg = multiavatar(DateTime.now().toIso8601String());
    return SvgPicture.string(rawSvg);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 700 ? 700 : width;
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
                  child: avatarWidget(),
                ),
                SizedBox(height: 5.0),
                userData(),
                SizedBox(height: 30.0),
                userInformation(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget userData() {
    return Container(
      child: Column(
        children: [
          Text(
            "User name",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 22.0,
            ),
          ),
          Text(
            "emailaddress@gmail.com",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey,
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget userInformation() {
    return Container(
      width: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            Text(
              "60",
              style: styleText(22.0, FontWeight.bold, Colors.black),
            ),
            Text(
              "Post",
              style: styleText(17.0, FontWeight.w600, Colors.grey),
            )
          ]),
          Column(children: [
            Text(
              "60",
              style: styleText(22.0, FontWeight.bold, Colors.black),
            ),
            Text(
              "You Like",
              style: styleText(17.0, FontWeight.w600, Colors.grey),
            )
          ]),
          Column(children: [
            Text(
              "10",
              style: styleText(22.0, FontWeight.bold, Colors.black),
            ),
            Text(
              "Followers",
              style: styleText(17.0, FontWeight.w600, Colors.grey),
            )
          ]),
        ],
      ),
    );
  }

  TextStyle styleText(fontSize, FontWeight fontWeight, color) {
    return TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);
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
