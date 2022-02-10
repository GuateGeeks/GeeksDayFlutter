import 'package:flutter/material.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/bloc/quiz_records_cubit.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/bloc/posts/post_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/services/implementation/quiz_records_service.dart';
import 'package:geeksday/ui/post/single_image_view.dart';
import 'package:percent_indicator/percent_indicator.dart';

class BodyCard extends StatelessWidget {
  final Post post;
  const BodyCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuizRecordsCubit(QuizRecordsService()),
      child: bodyBodyCard(context),
    );
  }

  Widget bodyBodyCard(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          post.imageRoute == "" ? Container() : showImage(context),
          postDescription(context),
          ProgressBar(post: post),
        ],
      ),
    );
  }

  Widget showImage(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return SingleImageView(image: post.imageRoute!);
              },
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                spreadRadius: 0,
                blurRadius: 7,
                offset: Offset(0, 7), // changes position of shadow
              ),
            ],
          ),
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22.0),
            child: Container(
              child: Image.network(
                post.imageRoute!,
                height: 400,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget postDescription(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 15),
      child: Text(
        post.text,
        style: Theme.of(context).textTheme.bodyText1,
        textAlign: TextAlign.left,
      ),
    );
  }
}

class ProgressBar extends StatefulWidget {
  final Post post;
  ProgressBar({Key? key, required this.post}) : super(key: key);

  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  //temporary correct answer
  bool correctAnswer = true;

  @override
  Widget build(BuildContext context) {
    PostCubit state = BlocProvider.of<PostCubit>(context);
    return answersList(state);
  }

  Widget answersList(PostCubit state) {
    String userId = BlocProvider.of<AuthCubit>(context).getUserId();
    if (state.isQuiz()) {
      bool isAnswered = state.isAnswered(userId);
      int total = BlocProvider.of<PostCubit>(context).totalresponses(state);
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: double.infinity,
        child: Column(
          children: state.getAnswers().map((answer) {
            int porcentage = state.porcentage(total, answer.selectedCounter);
            return Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: GestureDetector(
                onTap: isAnswered
                    ? null
                    : () {
                        setState(() {
                          var quizRecords =
                              BlocProvider.of<QuizRecordsCubit>(context);
                          quizRecords.answeredQuiz(
                              answer.text,
                              answer.isCorrect,
                              state.idPost(),
                              userId,
                              state.idEvent());
                          //get the click a button of the answers
                          state.usersResponded(userId);
                          state.selectCounter(answer);
                        });
                      },
                child: LinearPercentIndicator(
                  backgroundColor: Colors.black12,
                  // width: 600,
                  animation: true,
                  lineHeight: 40.0,
                  animationDuration: 1000,
                  percent: isAnswered
                      ? answer.selectedCounter.toDouble() / total
                      : 0,
                      center: Text(
                        isAnswered ? "$porcentage%" : answer.text,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      progressColor: isAnswered
                          ? correctAnswer == answer.isCorrect
                              ? Color(0xFF0E89AF)
                              : Color(0xFF4B3BAB)
                          : Colors.transparent,
                    ),
                ),
              
            );
          }).toList(),
        ),
      );
    }
    return Container();
  }
}
