import 'package:flutter/material.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/bloc/quiz_records_cubit.dart';
import 'package:geeksday/bloc/post_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/models/quiz.dart';
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
          Container(
            child: StreamBuilder<String>(
              stream: state.getImageURL(state.getPost()!.id).asStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return snapshot.data.toString() != "null" 
                ? Container(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: ClipRRect(  
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
                  ),
                )
                : Container();
              },
            ),
          ),
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
  bool correctAnswer = true;
  Color a = Colors.white12;
  String selected = '';
  bool isAnswered = false;

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
    int answerNumber = 1;
    String userId = BlocProvider.of<AuthCubit>(context).getUserId();
    print(selected);
    if (state.isQuiz()) {
      return state
          .getAnswers()
          .map(
            (answer) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 35.0),
              child: GestureDetector(
                onTap: (){

                  setState(() {
                    // var quizRecords = BlocProvider.of<QuizRecordsCubit>(context);
                    // quizRecords.answeredQuiz(answer.text, answer.isCorrect, state.idPost(), userId);
                    // state.updateIsAnswered();
                   a = changeColorAnswer(answer, answer.text);
                    isAnswered = true;
                  selected = answer.text;
                  });
                  
                },
                child: Container(
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(  
                    border: Border.all(
                      
                      color: isAnswered ?
                                selected == answer.text && answer.isCorrect ? Colors.green :
                                selected == answer.text && answer.isCorrect == false ? Colors.red :
                                Colors.white12
                              : Colors.white12
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(

                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(  
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${answerNumber++}. ${answer.text}"
                        ),
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(  
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.white12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ),
          )
          .toList();
    } else {
      return [];
    }
  }

  Color changeColorAnswer(Answer answer, texto){
    
    if(isAnswered){
      if(selected == texto && answer.isCorrect){
        return Colors.green;
      }
    }

    return Colors.white12;
 
  }
}
