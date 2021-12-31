import 'package:flutter/material.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/bloc/quiz_records_cubit.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/bloc/posts/post_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/models/quiz_records.dart';
import 'package:geeksday/services/implementation/quiz_records_service.dart';
import 'package:percent_indicator/percent_indicator.dart';

class BodyCard extends StatelessWidget {
  const BodyCard( {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PostCubit state = BlocProvider.of<PostCubit>(context);
    return BlocProvider(  
      create: (_) => QuizRecordsCubit(QuizRecordsService()),
      child: Container(
      child: Column(
        children: [
          // Container(
          //   child: StreamBuilder<String>(
          //     stream: state.getImageURL(state.getPost()!.id).asStream(),
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return Center(child: CircularProgressIndicator());
          //       }
          //       return snapshot.data.toString() != "null" 
          //       ? Container(
          //         padding: EdgeInsets.symmetric(vertical: 15.0),
          //         child: ClipRRect(  
          //           child: GestureDetector(
          //             onTap: () {
          //               Navigator.of(context).push(
          //                 MaterialPageRoute(
          //                   builder: (context) {
          //                     return ImagePage(snapshot.data.toString());
          //                   },
          //                 ),
          //               );
          //             },
          //             child:  Image.network(
          //               snapshot.data.toString(),
          //               width: MediaQuery.of(context).size.width,
          //               height: 400.0,
          //               fit: BoxFit.cover,
          //             ),
          //           ),
          //         ),
          //       )
          //       : Container();
          //     },
          //   ),
          // ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 15, 5),
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
        leading: BackButton(),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(image)
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
  //temporary correct answer
  bool correctAnswer = true;

  @override
  Widget build(BuildContext context) {
    PostCubit state = BlocProvider.of<PostCubit>(context);
     return Column(
       children: [
         ...AnswersList(state)
       ],
     );
  }

 

  List<Widget> AnswersList(PostCubit state) {
    String userId = BlocProvider.of<AuthCubit>(context).getUserId();
    double width = MediaQuery.of(context).size.width;

    if (state.isQuiz()) {
      bool isPressed = state.isAnswered(userId);
      int total = BlocProvider.of<PostCubit>(context).totalresponses(state);
      return state
          .getAnswers()
          .map(
            (answer) {
              int porcentage = state.porcentage(total, answer.selectedCounter);
              return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 20.0),
                child: GestureDetector(
                  onTap: isPressed ? null : () {
                    setState(() {
                      var quizRecords = BlocProvider.of<QuizRecordsCubit>(context);
                      quizRecords.answeredQuiz(answer.text, answer.isCorrect, state.idPost(), userId, state.idEvent());
                      //get the click a button of the answers
                      state.usersResponded(userId);
                      state.selectCounter(answer);
                      
                      
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new LinearPercentIndicator(
                        
                        backgroundColor: Colors.black12,
                        width: width < 650
                            ? MediaQuery.of(context).size.width - 100
                            : 450,
                        animation: true,
                        lineHeight: 40.0,
                        
                        animationDuration: 1000,
                        percent: isPressed ? answer.selectedCounter.toDouble() / total : 0,
                        center: Text(
                          isPressed ? "$porcentage%" : answer.text,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: isPressed
                            ? correctAnswer == answer.isCorrect
                                ? Colors.green
                                : Colors.red
                            : Colors.transparent,
                      ),
                    ],
                  ),
                ),
              ),
            );
            },
          )
          .toList();
    } else {
      return [];
    }
  }
}