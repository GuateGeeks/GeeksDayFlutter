import 'dart:html';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/bloc/post_cubit.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/models/quiz.dart';
import 'package:geeksday/services/implementation/post_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_whisperer/image_whisperer.dart';
import 'package:flutter/foundation.dart';

class PostCreate extends StatefulWidget {
  PostCreate({Key? key}) : super(key: key);

  @override
  _PostCreateState createState() => _PostCreateState();
}

class _PostCreateState extends State<PostCreate> {
  final commentController = TextEditingController();
  File? uploadedImage;

  Map<int, String> answersMap = {};


  Widget _content(BuildContext context) {
    //responsive modal
    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 700 ? 700 : width;
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        //main container
        return Center(
          child: Container(
            width: maxWidth,
            height: 900,
            constraints: BoxConstraints(
              maxHeight: double.infinity,
            ),
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            //ocultar la barra de scroll
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: ListView(
                shrinkWrap: true,
                children: [
                  //Header Nuevo Post
                  title(context),
                  SizedBox(
                    height: 10.0,
                  ),
                  //feature to preview images before posting
                  previewImages(context),
                  SizedBox(
                    height: 10.0,
                  ),
                  //Input description Nuevo Post
                  description(context),
                  //show answers
                  ...inputAnswers(context),
                  //function to add more answers
                  addAnswer(context),
                  //function to make the publication
                  buttonSave(context),
                ],
              ),
            ),
          ),
        );
      },
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
            setState(() {
              uploadedImage = file;
            });
            BlocProvider.of<PostCubit>(context).setImage(file);
          },
        );
      },
    );
  }

  Widget previewImages(context) {
    if (uploadedImage != null) {
      BlobImage blobImage =
          new BlobImage(uploadedImage, name: uploadedImage!.name);
      return Container(
        child: Image.network(blobImage.url, width: 50, height: 250),
      );
    }
    return Container();
  }

  List<Widget> inputAnswers(BuildContext context) {
    
    var postCubit = BlocProvider.of<PostCubit>(context);
    bool isQuiz = postCubit.isQuiz();
    var post = postCubit.state.post;
    if (isQuiz) {
      return post.quiz!.questions[0].answers
          .map(
            (answer) => Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: TextFormField(
                onChanged: (value) {
                  int index = postCubit.indexOfAnswer(answer);
                  saveAnswers(context, index, value);
                },
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
                  fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  focusedBorder:
                      Theme.of(context).inputDecorationTheme.focusedBorder,
                  enabledBorder:
                      Theme.of(context).inputDecorationTheme.enabledBorder,
                ),
              ),
            ),
          )
          .toList();
    }
    return [];
  }

  void saveAnswers(BuildContext context, int index, String value){
    var postCubit = BlocProvider.of<PostCubit>(context);
    answersMap[index] = value;
    answersMap.forEach((key, value) { 
      setState(() {
        postCubit.updateQuizAnswer(key, value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthUser user = BlocProvider.of<AuthCubit>(context).getUser();
    return BlocProvider(
      create: (_) => PostCubit(PostService(), Post.newPost("", user)),
      child: _content(context),
    );
  }

  Widget title(BuildContext context) {
    AuthUser userData = BlocProvider.of<AuthCubit>(context).getUser();
    bool isQuiz = BlocProvider.of<PostCubit>(context).isQuiz();
    var boldStyle = Theme.of(context).textTheme.headline2;
    var grayStyle = Theme.of(context).textTheme.headline5;

      return Padding(
        padding: EdgeInsets.fromLTRB(0, 15, 15, 15),
        child: Row(
          children: [
            TextButton(
              onPressed: () => BlocProvider.of<PostCubit>(context).unsetQuiz(),
              child: Text("Post", style: isQuiz ? grayStyle : boldStyle,),
            ),

            userData.isadmin == true ?
            Row(
              children: [
                Text("/", style: TextStyle(fontSize: 25, color: Colors.grey)),
                TextButton(
                  onPressed: () {
                    Question question = Question(
                      "Pregunta", [
                        Answer("Respuesta", false, 0),
                        Answer("Respuesta", false, 0),
                      ],
                    );
                    BlocProvider.of<PostCubit>(context).setQuiz(Quiz([question]));
                  },
                  child: Text("Quizz", style: isQuiz ? boldStyle : grayStyle),
                ),
              ],
            )
            : Container(),
          ],
        ),
      );
  }

  //Add TextFromField dynamically
  Widget addAnswer(BuildContext context) {
    bool isQuiz = BlocProvider.of<PostCubit>(context).isQuiz();
    if (isQuiz) {
      return TextButton(
        onPressed: () => {BlocProvider.of<PostCubit>(context).addAnswer()},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.add),
            Text("Agregar Respuesta"),
          ],
        ),
      );
    }
    return Container();
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
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: commentController,
        builder: (context, value, child){
          return ElevatedButton(
            onPressed: value.text.isNotEmpty ? () {
              
            //   BlocProvider.of<PostCubit>(context)
            // .createPost(commentController.text);
            // Navigator.pop(context);

            } : null,
            style: ButtonStyle(
              padding:
                  MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 20)),
            ),
            child: Text("Guardar"),
          );
        },
      ),
    );
  }
}
