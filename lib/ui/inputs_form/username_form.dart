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
            "Username",
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Colors.white, fontSize: 18),
          ),
        ),
        TextFormField(
          keyboardType: TextInputType.name,
          controller: widget.usernameController,
          validator: widget.emailAndUsernameValidator,
          cursorColor: Color.fromRGBO(170, 170, 170, 1),
          decoration: InputDecoration(
            hintText: "Enter your username",
            border: InputBorder.none,
            filled: true,
            fillColor: Color.fromRGBO(240, 240, 240, 1),
            contentPadding:
                const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
            focusedBorder: OutlineInputBorder(
              borderRadius: new BorderRadius.circular(8),
              borderSide: new BorderSide(
                color: Color.fromRGBO(240, 240, 240, 1),
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderRadius: new BorderRadius.circular(8),
              borderSide: new BorderSide(
                color: Color.fromRGBO(240, 240, 240, 1),
              ),
            ),
          ),
          // validator: emailValidator,
        ),
      ],
    );
  }
}
