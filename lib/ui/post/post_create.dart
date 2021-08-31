import 'dart:html';

import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/bloc/post_cubit.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/models/quiz.dart';
import 'package:geeksday/services/implementation/post_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/routes.dart';

class PostCreate extends StatefulWidget {
  PostCreate({Key? key}) : super(key: key);

  @override
  _PostCreateState createState() => _PostCreateState();
}

class _PostCreateState extends State<PostCreate> {
  final commentController = TextEditingController();
  bool isCorrect = false;
  Widget _content(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 700 ? 700 : width;
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        return Center(
          child: Container(
            width: maxWidth,
            constraints: BoxConstraints(
              maxHeight: double.infinity,
            ),
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
                //Header Nuevo Post
                title(context),
                SizedBox(
                  height: 15.0,
                ),
                //Input description Nuevo Post
                description(context),
                ...inputAnswers(context),
                addAnswer(context),
                buttonSave(context)
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> inputAnswers(BuildContext context) {
    var postCubit = BlocProvider.of<PostCubit>(context);
    bool isQuiz = postCubit.isQuiz();
    var post = postCubit.state.post;
    if (isQuiz) {
      return post.quiz!.questions[0].answers
          .map(
            (answer) => TextFormField(
              onSaved: (value) {
                var index = postCubit.indexOfAnswer(answer);
                postCubit.updateQuizAnswer(index, value!);
              },
              onChanged: (value) {},
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                suffixIcon: InkWell(
                  onTap: () {
                    postCubit.toggleAnswerIsCorrect(answer);
                  },
                  child: Tooltip(
                    message: "Respuesta Correcta",
                    child: answer.isCorrect
                        ? Icon(
                            Icons.check_circle_rounded,
                            color: Colors.green,
                          )
                        : Icon(Icons.check_circle_rounded),
                  ),
                ),
                hintText: answer.text,
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
          )
          .toList();
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    //Responsive modal Nuevo post

    AuthUser user = BlocProvider.of<AuthCubit>(context).getUser();
    return BlocProvider(
      create: (_) => PostCubit(PostService(), Post.newPost("", user)),
      child: _content(context),
    );
  }

  Widget title(BuildContext context) {
    bool isQuiz = BlocProvider.of<PostCubit>(context).isQuiz();
    TextStyle boldStyle = TextStyle(
        color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold);
    TextStyle grayStyle = TextStyle(color: Colors.grey, fontSize: 16.0);

    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: [
          TextButton(
            onPressed: () {
              BlocProvider.of<PostCubit>(context).unsetQuiz();
            },
            child: Text(
              "Post",
              style: isQuiz ? grayStyle : boldStyle,
            ),
          ),
          Text("/", style: TextStyle(fontSize: 25, color: Colors.grey)),
          TextButton(
            onPressed: () {
              Question question = Question("Pregunta", [
                Answer("Respuesta", false, 0),
                Answer("Respuesta", false, 0),
              ]);
              BlocProvider.of<PostCubit>(context).setQuiz(Quiz([question]));
            },
            child: Text(
              "Quizz",
              style: isQuiz ? boldStyle : grayStyle,
            ),
          ),
        ],
      ),
    );
  }

  //Add TextFromField dynamically
  Widget addAnswer(BuildContext context) {
    bool isQuiz = BlocProvider.of<PostCubit>(context).isQuiz();
    if (isQuiz) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextButton(
          onPressed: () => {BlocProvider.of<PostCubit>(context).addAnswer()},
          //     setState(() => textFormField.add(createTextField())),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.add),
              Text("Agregar Respuesta"),
            ],
          ),
        ),
      );
    }
    return Text("");
  }

  Widget description(BuildContext context) {
    return TextFormField(
      minLines: 1,
      maxLines: 4,
      controller: commentController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        suffixIcon: InkWell(
          onTap: () {
            uploadImage(context);
          },
          child: Icon(Icons.image_search),
        ),
        hintText: "Description",
      ),
    );
  }

  Widget buttonSave(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: ElevatedButton(
        onPressed: () {
          BlocProvider.of<PostCubit>(context)
              .createPost(commentController.text);
          Navigator.pop(context);
        },
        style: ButtonStyle(
          padding:
              MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 20)),
        ),
        child: const Text("Guardar"),
      ),
    );
  }

  uploadImage(BuildContext context) async {
    var uploadInput = FileUploadInputElement()..accept = 'image/*';
    uploadInput.click();
    uploadInput.onChange.listen(
      (event) {
        final File file = uploadInput.files!.first;
        final reader = FileReader();
        reader.readAsDataUrl(file);
        reader.onLoadEnd.listen(
          (event) {
            BlocProvider.of<PostCubit>(context).setImage(file);
          },
        );
      },
    );
  }

  final TextEditingController maxWidthController = TextEditingController();

  final TextEditingController maxHeightController = TextEditingController();

  final TextEditingController qualityController = TextEditingController();

  Future<void> _displayPickImageDialog(
      BuildContext context, OnPickImageCallback onPick) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add optional parameters'),
          content: Column(
            children: <Widget>[
              TextField(
                controller: maxWidthController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration:
                    InputDecoration(hintText: "Enter maxWidth if desired"),
              ),
              TextField(
                controller: maxHeightController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration:
                    InputDecoration(hintText: "Enter maxHeight if desired"),
              ),
              TextField(
                controller: qualityController,
                keyboardType: TextInputType.number,
                decoration:
                    InputDecoration(hintText: "Enter quality if desired"),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('PICK'),
              onPressed: () {
                double? width = maxWidthController.text.isNotEmpty
                    ? double.parse(maxWidthController.text)
                    : null;
                double? height = maxHeightController.text.isNotEmpty
                    ? double.parse(maxHeightController.text)
                    : null;
                int? quality = qualityController.text.isNotEmpty
                    ? int.parse(qualityController.text)
                    : null;
                onPick(width, height, quality);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

typedef void OnPickImageCallback(
    double? maxWidth, double? maxHeight, int? quality);
