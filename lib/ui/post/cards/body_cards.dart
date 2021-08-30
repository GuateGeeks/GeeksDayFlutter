import 'package:flutter/material.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/bloc/post_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BodyCard extends StatelessWidget {
  const BodyCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PostCubit state = BlocProvider.of<PostCubit>(context);
    return Container(
      padding: EdgeInsets.only(bottom: 20),
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
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
          ...AnswersList(state),
        ],
      ),
    );
  }

  List<Widget> AnswersList(PostCubit state) {
    if (state.isQuiz()) {
      return state
          .getAnswers()
          .map((answer) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Container(
                  margin: EdgeInsets.only(top: 10.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        answer.text,
                        style: TextStyle(color: Colors.grey, fontSize: 17),
                      ),
                      Container(
                        height: 26,
                        width: 26,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ))
          .toList();
    } else {
      return [];
    }
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
