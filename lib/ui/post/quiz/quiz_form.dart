import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/bloc/posts/post_cubit.dart';
import 'package:geeksday/bloc/posts/quiz_cubit.dart';
import 'package:geeksday/models/quiz.dart';

class QuizForm extends StatelessWidget {
  const QuizForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _quizForm(context);
  }

  Widget _quizForm(BuildContext context) {
    return BlocBuilder<QuizCubit, QuizState>(builder: (context, state) {
      QuizCubit cubit = BlocProvider.of<QuizCubit>(context);
      List<QuizInput> _questions = [];
      for (Answer answer in cubit.answers) {
        _questions.add(QuizInput(answer: answer));
      }
      return Column(
        children: [
          SwitchListTile(
              value: cubit.isQuizEnabled(),
              title: Text("Habilitar Quiz"),
              onChanged: (value) {
                cubit.setQuizEnable(value);
                if (value) {
                  BlocProvider.of<PostCubit>(context).setupQuiz();
                } else {
                  BlocProvider.of<PostCubit>(context).unsetQuiz();
                }
              }),
          Column(
            children: _questions,
          ),
          AbsorbPointer(
            absorbing: !cubit.isQuizEnabled(),
            child: Opacity(
              opacity: cubit.isQuizEnabled() ? 1 : 0.2,
              child: ListTile(
                title: Text("Agregar opcion"),
                trailing: Icon(Icons.add),
                onTap: () {
                  cubit.addItem();
                },
              ),
            ),
          )
        ],
      );
    });
  }
}

class QuizInput extends StatefulWidget {
  final Answer answer;
  const QuizInput({Key? key, required this.answer}) : super(key: key);

  @override
  State<QuizInput> createState() => _QuizInputState();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return answer.toString();
  }
}

class _QuizInputState extends State<QuizInput> {
  bool _isCorrect = false;
  String text = "";
  @override
  Widget build(BuildContext context) {
    QuizCubit cubit = BlocProvider.of<QuizCubit>(context);
    text = widget.answer.text;
    return BlocBuilder<QuizCubit, QuizState>(
        builder: (context, state) => AbsorbPointer(
              absorbing: !cubit.isQuizEnabled(),
              child: Opacity(
                opacity: cubit.isQuizEnabled() ? 1 : 0.2,
                child: Dismissible(
                  key: Key(UniqueKey().toString()),
                  onDismissed: (direction) {
                    cubit.removeItem(widget.answer);
                  },
                  child: SwitchListTile(
                      value: widget.answer.isCorrect,
                      title: TextFormField(
                        onChanged: (value) =>
                            {widget.answer.text = text = value},
                        controller: TextEditingController(text: text),
                        decoration: const InputDecoration(
                            hintText: "Respuesta", border: InputBorder.none),
                      ),
                      onChanged: (value) {
                        setState(() {
                          widget.answer.isCorrect = value;
                        });
                      }),
                ),
              ),
            ),
        buildWhen: (previousStage, state) {
          return state is QuizEnabled;
        });
  }
}
