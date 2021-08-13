import 'package:flutter/material.dart';

class EmailForm extends StatefulWidget {
  String? Function(String? value) emailAndUsernameValidator;
  TextEditingController emailController;

  EmailForm(this.emailAndUsernameValidator, this.emailController, {Key? key})
      : super(key: key);

  @override
  _EmailFormState createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Text(
            "Email",
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Colors.white, fontSize: 18),
          ),
        ),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          validator: widget.emailAndUsernameValidator,
          controller: widget.emailController,
          decoration: InputDecoration(
            hintText: "Enter your email",
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
        ),
      ],
    );
  }
}
