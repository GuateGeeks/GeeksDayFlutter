import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/ui/edit_profile.dart';
import 'package:multiavatar/multiavatar.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("You Profile"),
        centerTitle: true,
      ),
      body: BodyEditUserProfile(),
    );
  }
}

class BodyEditUserProfile extends StatefulWidget {
  const BodyEditUserProfile({Key? key}) : super(key: key);

  @override
  _BodyEditUserProfileState createState() => _BodyEditUserProfileState();
}

class _BodyEditUserProfileState extends State<BodyEditUserProfile> {
  final _formKey = GlobalKey<FormState>();
  var _usernameController = TextEditingController();
  String randomAvatar = "";

  Widget avatarWidget(String randomAvatar) {
    String rawSvg = multiavatar(randomAvatar);

    return SvgPicture.string(rawSvg);
  }

  @override
  Widget build(BuildContext context) {
    var userData = BlocProvider.of<AuthCubit>(context).getUser();

    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 400 ? 400 : width;
    return Center(
      child: Container(
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
              width: maxWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 120.0,
                  ),
                  CircleAvatar(
                    radius: 60.0,
                    child: randomAvatar == ""
                        ? avatarWidget(userData.image)
                        : avatarWidget(randomAvatar),
                  ),
                  SizedBox(height: 20.0),
                  randomButton(context),
                  SizedBox(height: 10.0),
                  userDataProfile(
                    context,
                    userData,
                  ),
                  SizedBox(height: 20.0),
                  buttonSave(userData),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget randomButton(context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: EdgeInsets.all(10.0),
        color: Colors.white10,
        child: IconButton(
          onPressed: () {
            var random = List.generate(12, (_) => Random().nextInt(100));
            randomAvatar = random.join();
            setState(() {
              avatarWidget(randomAvatar);
            });
          },
          icon: Icon(
            Icons.refresh,
            size: 25.0,
            color: Colors.white60,
          ),
        ),
      ),
    );
  }

  Widget userDataProfile(context, userData) {
    _usernameController = TextEditingController(text: userData.name);

    String? usernameValidator(String? value) {
      return (value == null || value.isEmpty)
          ? 'This is a required field'
          : null;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _usernameController,
              validator: usernameValidator,
              decoration: InputDecoration(
                fillColor: Theme.of(context).inputDecorationTheme.fillColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buttonSave(userData) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          BlocProvider.of<AuthCubit>(context)
              .updateUser(userData.uid, _usernameController.text, randomAvatar);
        },
        child: Text("Guardar"),
        style: ButtonStyle(
          padding:
              MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 20)),
        ),
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
