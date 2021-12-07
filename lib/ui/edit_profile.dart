import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:multiavatar/multiavatar.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Edit your profile"),
        centerTitle: true,
      ),
      body: BodyEditUserProfile(),
    );
  }
}

class BodyEditUserProfile extends StatefulWidget {
  BodyEditUserProfile({Key? key}) : super(key: key);

  @override
  _BodyEditUserProfileState createState() => _BodyEditUserProfileState();
}

class _BodyEditUserProfileState extends State<BodyEditUserProfile> {
  final _formKey = GlobalKey<FormState>();
  var _usernameController = TextEditingController();
  String randomAvatar = "";

  @override
  Widget build(BuildContext context) {
    var userData = BlocProvider.of<AuthCubit>(context).getUser();

    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 400 ? 400 : width;

    return Container(
      child: ListView(
        shrinkWrap: true,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              CustomPaint(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                ),
                painter: HeaderCurvedContainer(),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 120.0),
                    CircleAvatar(
                      radius: 60.0,
                      child: randomAvatar == ""
                          ? avatarWidget(userData.image)
                          : avatarWidget(randomAvatar),
                    ),
                    SizedBox(height: 10.0),
                    randomButton(context),
                    userDataProfile(context, userData, maxWidth),
                    SizedBox(height: 15.0),
                    buttonSave(userData, maxWidth),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  //Widget to display the user's avatar
  Widget avatarWidget(String randomAvatar) {
    String rawSvg = multiavatar(randomAvatar);
    return SvgPicture.string(rawSvg);
  }

  //function to generate an avatar randomly and display the generated avatar on the screen
  Widget randomButton(context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          padding: EdgeInsets.all(10.0),
          color: Theme.of(context).selectedRowColor,
          child: IconButton(
            onPressed: () {
              var random = List.generate(12, (_) => Random().nextInt(100));
              randomAvatar = random.join();
              setState(() {
                avatarWidget(randomAvatar);
              });
            },
            icon: Icon(Icons.refresh, size: 25.0, color: Colors.white),
          ),
        ),
      ),
    );
  }

  //function to display the user's name in an input, so that the user can edit their name
  Widget userDataProfile(context, userData, maxWidth) {
    _usernameController = TextEditingController(text: userData.name);

    String? usernameValidator(String? value) {
      return (value == null || value.isEmpty)
          ? 'This is a required field'
          : null;
    }

    return Container(
      width: maxWidth,
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

  //Widget to show the button to save user data updates
  Widget buttonSave(userData, maxWidth) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      width: maxWidth,
      child: ElevatedButton(
        onPressed: () {
          BlocProvider.of<AuthCubit>(context)
              .updateUser(_usernameController.text, randomAvatar);
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

//This class is responsible for creating the blue background that is shown behind the user's avatar
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
