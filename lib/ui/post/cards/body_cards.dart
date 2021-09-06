import 'package:flutter/material.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/bloc/post_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';

class BodyCard extends StatelessWidget {
  const BodyCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PostCubit state = BlocProvider.of<PostCubit>(context);
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: StreamBuilder<String>(
              stream: state.getImageURL(state.getPost()!.id).asStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return ImagePage(snapshot.data.toString());
                          },
                        ),
                      );
                    },
                    child: Image.network(
                      snapshot.data.toString(),
                      width: 400.0,
                      height: 400.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Text(
              state.getPost()!.text,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          // In this way you can add list members as part of other list
          // https://www.woolha.com/tutorials/dart-using-triple-dot-spread-operator-examples

          ProgressBar(),
          // ...AnswersList(state),
        ],
      ),
    );
  }
}

class ImagePage extends StatelessWidget {
  late String image;
  ImagePage(this.image);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(
          image,
        ),
      ),
    );
  }
}

class ProgressBar extends StatefulWidget {
  ProgressBar({Key? key}) : super(key: key);

  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  bool isPressed = false;
  //color of the quizz answers
  Color btnColor = Color(0xffE4E4E4);
  //temporary correct answer
  String correctAnswer = "rp1";

  @override
  Widget build(BuildContext context) {
    PostCubit state = BlocProvider.of<PostCubit>(context);
    return Column(
      children: [
        ...AnswersList(state),
      ],
    );
  }

  List<Widget> AnswersList(PostCubit state) {
    double width = MediaQuery.of(context).size.width;
    if (state.isQuiz()) {
      return state
          .getAnswers()
          .map(
            (answer) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 20.0),
                child: isPressed
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          new LinearPercentIndicator(
                            width: width < 650
                                ? MediaQuery.of(context).size.width - 100
                                : 450,
                            animation: true,
                            lineHeight: 40.0,
                            animationDuration: 2500,
                            percent: 0.8,
                            center: Text(
                              "80.0% Porcentaje respuestas",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: correctAnswer == answer.text
                                ? Colors.green
                                : Colors.red,
                          ),
                        ],
                      )
                    : Padding(
                        padding: width < 650
                            ? (width < 500
                                ? EdgeInsets.symmetric(horizontal: 0)
                                : EdgeInsets.symmetric(horizontal: 10))
                            : EdgeInsets.symmetric(horizontal: 60),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            //change color to the answers, if the answer is correct it is marked in green, otherwise it is marked in red
                            backgroundColor: btnColor,
                            padding: EdgeInsets.symmetric(vertical: 20.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: () {
                            setState(() {
                              //get the click a button of the answers
                              isPressed = true;
                            });
                          },
                          child: Text(
                            answer.text,
                            style: TextStyle(
                              color: isPressed ? Colors.white : Colors.grey,
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          )
          .toList();
    } else {
      return [];
    }
  }
}
