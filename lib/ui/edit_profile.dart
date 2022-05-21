import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/services/navigationService.dart';
import 'package:geeksday/ui/guategeeks/elements.dart';
import 'package:geeksday/ui/locator.dart';
import 'package:multiavatar/multiavatar.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GuateGeeksScaffold(
      body: const BodyEditUserProfile(),
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

  @override
  Widget build(BuildContext context) {
    var userData = BlocProvider.of<AuthCubit>(context).getUser()!;

    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 400 ? 400 : width;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is UpdateUser) {
          locator<NavigationService>().navigateTo('/perfil');
        }
      },
      child: ListView(
        shrinkWrap: true,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              CustomPaint(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                ),
                painter: HeaderCurvedContainer(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 120.0),
                  CircleAvatar(
                    radius: 60.0,
                    child: randomAvatar == ""
                        ? avatarWidget(userData.image)
                        : avatarWidget(randomAvatar),
                  ),
                  const SizedBox(height: 10.0),
                  randomButton(context),
                  userDataProfile(context, userData, maxWidth),
                  const SizedBox(height: 15.0),
                  buttonSave(userData, maxWidth),
                ],
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        color: Theme.of(context).selectedRowColor,
        child: IconButton(
          tooltip: "Crear Avatar",
          onPressed: () {
            var random = List.generate(12, (_) => Random().nextInt(100));
            randomAvatar = random.join();
            setState(() {
              avatarWidget(randomAvatar);
            });
          },
          icon: const Icon(Icons.refresh, size: 25.0, color: Colors.white),
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
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      width: maxWidth,
      child: ElevatedButton(
        onPressed: () {
          BlocProvider.of<AuthCubit>(context)
              .updateUser(_usernameController.text, randomAvatar);
        },
        child: const Text("Guardar"),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 20)),
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
