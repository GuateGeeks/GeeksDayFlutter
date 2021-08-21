import 'dart:html';

import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/bloc/post_cubit.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/services/implementation/post_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizzCreate extends StatefulWidget {
  static Widget create(BuildContext context) {
    AuthUser user = context.read<AuthCubit>().getUser();
    return BlocProvider(
      create: (_) => PostCubit(PostService(), Post.newPost("", user)),
      child: QuizzCreate(),
    );
  }

  final onButtonPressed;
  QuizzCreate({Key? key, this.onButtonPressed}) : super(key: key);

  @override
  _QuizzCreateState createState() => _QuizzCreateState();
}

class _QuizzCreateState extends State<QuizzCreate> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 700 ? 700 : width;
    return Center(
      child: Container(
        width: maxWidth,
        child: Container(
          width: maxWidth,
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: ListView(
            children: [
              Column(
                children: [
                  //Title Quizz
                  title(),
                  //Show preview Image
                  previewImage(),
                  SizedBox(
                    height: 15,
                  ),
                  //Description Quizz
                  description(),
                  SizedBox(
                    height: 15,
                  ),
                  //Anwers Quizz
                  inputAnswers('Respuesta 1'),
                  SizedBox(height: 10),
                  inputAnswers('Respuesta 2'),
                  SizedBox(height: 10),
                  inputAnswers('Respuesta 3'),
                  SizedBox(height: 10),
                  inputAnswers('Respuesta 4'),
                  SizedBox(height: 10),
                  //TODO: Connect button functionality
                  buttonSave(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

//Header Nuevo Post
  Widget title() {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: [
            TextButton(
              onPressed: widget.onButtonPressed,
              child: Text(
                "Post",
                style: TextStyle(color: Colors.grey, fontSize: 16.0),
              ),
            ),
            Text("/", style: TextStyle(fontSize: 25, color: Colors.grey)),
            TextButton(
              onPressed: () {},
              child: Text(
                "Quizz",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //preview Image
  Widget previewImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Image.network(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYWqVZPSOVfhq9QFwz-yKFkj9eu89xK0UGMQ&usqp=CAU',
        height: 250,
        width: 250,
        fit: BoxFit.cover,
      ),
    );
  }

  //Description Quizz
  Widget description() {
    return TextField(
      minLines: 1,
      maxLines: 4,
      decoration: InputDecoration(
        hintText: "Descripcion Quizz",
        suffixIcon: InkWell(
          onTap: () {},
          child: Icon(Icons.image_search),
        ),
      ),
    );
  }

  //input Answer
  Widget inputAnswers(answer) {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        suffixIcon: InkWell(
          onTap: () {},
          child: Icon(
            Icons.check_circle_rounded,
            color: Colors.grey,
          ),
        ),
        hintText: answer,
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
    );
  }

  //Button Guardar
  Widget buttonSave() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(horizontal: 50, vertical: 20)),
        ),
        child: const Text("Guardar Quizz"),
      ),
    );
  }
}
