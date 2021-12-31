import 'package:flutter/material.dart';

class UsernameForm extends StatefulWidget {
  String? Function(String? value) emailAndUsernameValidator;
  TextEditingController usernameController;
  UsernameForm(this.emailAndUsernameValidator, this.usernameController,
      {Key? key})
      : super(key: key);

  @override
  _UsernameFormState createState() => _UsernameFormState();
}

class _UsernameFormState extends State<UsernameForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Text(
            "Nombre de Usuario",
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        TextFormField(
          keyboardType: TextInputType.name,
          controller: widget.usernameController,
          validator: widget.emailAndUsernameValidator,
          cursorColor: Color.fromRGBO(170, 170, 170, 1),
          
          decoration: InputDecoration(
            hintText: "Ingresa tu nombre de usuario",
            border: InputBorder.none,
            filled: true,
            fillColor: Theme.of(context).inputDecorationTheme.fillColor,
            contentPadding:
                const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
            focusedBorder: OutlineInputBorder(
              borderRadius: new BorderRadius.circular(8),
              borderSide: new BorderSide(
                color: Colors.transparent,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderRadius: new BorderRadius.circular(8),
              borderSide: new BorderSide(
                color: Colors.transparent,
              ),
            ),
          ),
          // validator: emailValidator,
        ),
      ],
    );
  }
}
