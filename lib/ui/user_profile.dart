import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/ui/guategeeks/elements.dart';
import 'package:multiavatar/multiavatar.dart';

class UserProfile extends StatefulWidget {
  final String idUser;

  const UserProfile({Key? key, required this.idUser}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool isEdited = false;
  final _formKey = GlobalKey<FormState>();
  var _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthUser userData = BlocProvider.of<AuthCubit>(context).getUser()!;
    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 400 ? 400 : width;

    String randomAvatar =
        BlocProvider.of<AuthCubit>(context).getAvatar(userData.image);

    return GuateGeeksScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.backgroundColor,
                boxShadow: [
                  const BoxShadow(
                    color: Colors.black38,
                    spreadRadius: 0,
                    blurRadius: 1,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              height: 60,
              child: navbar(randomAvatar),
            ),
            bodyUserProfile(userData, randomAvatar),
            const SizedBox(
              height: 50,
            ),
            userDataProfile(context, userData, maxWidth),
            const SizedBox(
              height: 50,
            ),
            userInformation(context),
          ],
        ),
      ),
    );
  }

  Widget navbar(randomAvatar) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        isEdited
            ? Icon(
                Icons.close,
                size: 30,
                color: Theme.of(context).appBarTheme.iconTheme!.color,
              )
            : Container(),
        Text(
          "Perfil",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        isEdited
            ? GestureDetector(
                onTap: () {
                  saveUser(_usernameController.text, randomAvatar);
                },
                child: Icon(
                  Icons.check,
                  size: 30,
                  color: Theme.of(context).appBarTheme.iconTheme!.color,
                ),
              )
            : Container()
      ],
    );
  }

  Widget bodyUserProfile(AuthUser userData, randomAvatar) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is UpdateUser) {
          print("Perfil editado");
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top: 80),
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: SizedBox(
                    width: 228,
                    height: 228,
                    child: SvgPicture.string(multiavatar(randomAvatar)))),
            Positioned(
              right: 5,
              bottom: 10,
              child: GestureDetector(
                onTap: () {
                  BlocProvider.of<AuthCubit>(context).generateAvatar();
                  setState(() {
                    isEdited = true;
                    avatarWidget(randomAvatar);
                  });
                },
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    border: Border.all(color: const Color(0xFFD3D3D3)),
                  ),
                  child: const Icon(
                    Icons.edit,
                    size: 40,
                    color: Color(0xFF9A9C9E),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //function to display the user's name in an input, so that the user can edit their name
  Widget userDataProfile(context, AuthUser userData, maxWidth) {
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
              onTap: () {
                setState(() {
                  isEdited = true;
                });
              },
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

  Widget avatarWidget(randomAvatar) {
    String rawSvg = multiavatar(randomAvatar);
    return SvgPicture.string(rawSvg);
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
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              "Post",
              style: Theme.of(context).textTheme.caption,
            )
          ]),
          Column(children: [
            Text(
              "60",
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              "Me Gusta",
              style: Theme.of(context).textTheme.caption,
            )
          ]),
          Column(children: [
            Text(
              "10",
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              "Seguidores",
              style: Theme.of(context).textTheme.caption,
            )
          ]),
        ],
      ),
    );
  }

  void saveUser(String userName, String userAvatar) {
    BlocProvider.of<AuthCubit>(context).updateUser(userName, userAvatar);
  }
}
