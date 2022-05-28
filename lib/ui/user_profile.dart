import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/bloc/user_cubit.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/services/implementation/auth_service.dart';
import 'package:geeksday/ui/guategeeks/elements.dart';
import 'package:geeksday/ui/guategeeks/multiavatar.dart';
import 'package:deep_collection/deep_collection.dart';

class UserProfile extends StatelessWidget {
  final String? idUser;
  UserProfile({Key? key, this.idUser}) : super(key: key);

  bool editionEnabled = false;

  // get sliderValues => sliders.reduce((value, element) => '$value$element');

  @override
  Widget build(BuildContext context) {
    AuthUser userData = BlocProvider.of<AuthCubit>(context).getUser()!;
    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 700 ? 700 : width;

    return BlocProvider(
        create: (context) => UserCubit(userData, AuthService()),
        child: GuateGeeksScaffold(
          body: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
            if (state is UserCancelEditingState) {
              BlocProvider.of<UserCubit>(context).setUser(userData);
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).appBarTheme.backgroundColor,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black38,
                          spreadRadius: 0,
                          blurRadius: 1,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    height: 60,
                    child: navbar(context),
                  ),
                  UserProfileHeader(),
                  const SizedBox(
                    height: 50,
                  ),
                  state is UserEditingState
                      ? SizedBox(
                          width: maxWidth,
                          child: sliderWidgets(context),
                        )
                      : const UserDetails(),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            );
          }),
        ));
  }

  Widget sliderWidgets(context) {
    List<Widget> widgets = [];

    var partDescriptor =
        getPartDescriptor(BlocProvider.of<UserCubit>(context).getImage())
            .deepReverse();
    partDescriptor.forEach((index, element) {
      widgets.add(
        Column(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  const SizedBox(width: 20),
                  Text(MultiAvatarPart.values
                      .where((element) => element.name == index)
                      .first
                      .label),
                ],
              ),
            ),
            Slider(
              value: double.parse(element),
              min: 0,
              max: 47,
              label: element,
              divisions: 48,
              onChanged: (value) {
                partDescriptor[index] =
                    value.round().toString().padLeft(2, '0');

                BlocProvider.of<UserCubit>(context).updateImage(partDescriptor
                    .values
                    .reduce((value, element) => '$value$element'));
              },
            ),
          ],
        ),
      );
    });

    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 200,
        child: Column(
          children: widgets,
        ),
      ),
    );
  }

  Widget navbar(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocProvider.of<UserCubit>(context).isEditing
            ? GestureDetector(
                onTap: () {
                  BlocProvider.of<UserCubit>(context).cancelEditing();
                },
                child: Icon(
                  Icons.close,
                  size: 30,
                  color: Theme.of(context).appBarTheme.iconTheme!.color,
                ),
              )
            : Container(),
        Text(
          "Perfil",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        BlocProvider.of<UserCubit>(context).isEditing
            ? GestureDetector(
                onTap: () {
                  BlocProvider.of<UserCubit>(context).updateUser();
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
}

class UserDetails extends StatelessWidget {
  const UserDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
}

class UserProfileHeader extends StatelessWidget {
  UserProfileHeader({Key? key}) : super(key: key);
  var _usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      _usernameController = TextEditingController(text: state.user.name);
      _usernameController.addListener(() {
        BlocProvider.of<UserCubit>(context)
            .updateName(_usernameController.text);
      });
      String? usernameValidator(String? value) {
        return (value == null || value.isEmpty)
            ? 'This is a required field'
            : null;
      }

      return Container(
        margin: const EdgeInsets.only(top: 80),
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    SvgPicture.string(multiavatar("",
                        stringParts:
                            BlocProvider.of<UserCubit>(context).getImage())),
                  ],
                ),
                Positioned(
                  right: 5,
                  bottom: 10,
                  child: GestureDetector(
                    onTap: () {
                      state is UserEditingState
                          ? BlocProvider.of<UserCubit>(context).randomAvatar()
                          : BlocProvider.of<UserCubit>(context).userEditing();
                    },
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                        border: Border.all(color: const Color(0xFFD3D3D3)),
                      ),
                      child: state is UserEditingState
                          ? const Icon(Icons.shuffle,
                              size: 40, color: Color(0xFF9A9C9E))
                          : const Icon(
                              Icons.edit,
                              size: 40,
                              color: Color(0xFF9A9C9E),
                            ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: state is UserEditingState
                  ? SizedBox(
                      width: 200,
                      child: TextFormField(
                        controller: _usernameController,
                        validator: usernameValidator,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            fillColor: Theme.of(context)
                                .inputDecorationTheme
                                .fillColor,
                            contentPadding: EdgeInsets.zero),
                      ),
                    )
                  : Text(
                      BlocProvider.of<UserCubit>(context).getUserName(),
                      style: Theme.of(context).textTheme.headline3,
                    ),
            ),
          ],
        ),
      );
    });
  }
}
