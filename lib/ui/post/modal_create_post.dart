import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geeksday/models/event.dart';
import 'package:geeksday/ui/post/post_create.dart';
import 'package:geeksday/ui/post/quiz_create.dart';

class ModalCreatePost extends StatelessWidget {
  Event event;
  ModalCreatePost({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //responsive modal
    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 700 ? 700 : width;
    return Center(
      child: Container(
          width: maxWidth,
          height: 400,
          padding: EdgeInsets.fromLTRB(35, 20, 35, 5),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  alignment: Alignment.topCenter,
                  width: 50,
                  height: 5,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Crear",
                style: TextStyle(color: Colors.white, fontSize: 26),
              ),
              SizedBox(
                height: 30,
              ),
              createPost(context),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Divider(
                  height: 2,
                  color: Colors.white,
                ),
              ),
              createQuiz(context),
            ],
          )),
    );
  }

  Widget createPost(context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return PostCreate(event: event);
            },
          ),
        );
      },
      child: Row(
        children: [
          SvgPicture.asset('assets/icons/post.svg'),
          SizedBox(width: 15),
          Text('Post', style: Theme.of(context).textTheme.headline2),
        ],
      ),
    );
  }

  Widget createQuiz(context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return QuizCreate(event: event);
            },
          ),
        );
      },
      child: Row(
        children: [
          SvgPicture.asset('assets/icons/post.svg'),
          SizedBox(width: 15),
          Text('Quiz', style: Theme.of(context).textTheme.headline2),
        ],
      ),
    );
  }
}
