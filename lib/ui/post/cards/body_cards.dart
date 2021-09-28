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
            child: StreamBuilder<String>(
              stream: state.getImageURL(state.getPost()!.id).asStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return ClipRRect(
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
                      width: MediaQuery.of(context).size.width,
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
              style: Theme.of(context).textTheme.headline4,
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
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      //get the click a button of the answers
                      isPressed = true;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new LinearPercentIndicator(
                        width: width < 650
                            ? MediaQuery.of(context).size.width - 100
                            : 450,
                        animation: true,
                        lineHeight: 40.0,
                        animationDuration: 2500,
                        percent: isPressed ? 0.8 : 0,
                        center: Text(
                          isPressed
                              ? "80.0% Porcentaje respuestas"
                              : answer.text,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: isPressed
                            ? correctAnswer == answer.text
                                ? Colors.green
                                : Colors.red
                            : Colors.transparent,
                      ),
                    ],
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
