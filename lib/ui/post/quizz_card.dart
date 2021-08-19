import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geeksday/ui/post/cards/button_widget.dart';
import 'package:geeksday/ui/post/cards/header_card.dart';
import 'package:like_button/like_button.dart';

class QuizzCard extends StatefulWidget {
  QuizzCard({Key? key}) : super(key: key);

  @override
  _QuizzCardState createState() => _QuizzCardState();
}

class _QuizzCardState extends State<QuizzCard> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              header(),
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYWqVZPSOVfhq9QFwz-yKFkj9eu89xK0UGMQ&usqp=CAU',
                  width: 400.0,
                  height: 400.0,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ),
              Answers(),
              Answers(),
              Answers(),
              Answers(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 13.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    likeButton(width),
                    SizedBox(
                      width: 20.0,
                    ),
                    commentButton(width)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget header() {
  return Container(
    padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
    child: Row(
      children: <Widget>[
        Container(
          width: 50,
          height: 50,
          padding: EdgeInsets.all(10),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
            image: DecorationImage(
              image: NetworkImage(
                  "https://yt3.ggpht.com/a/AATXAJyPMywRmD62sfK-1CXjwF0YkvrvnmaaHzs4uw=s900-c-k-c0xffffffff-no-rj-mo"),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Column(
            children: <Widget>[
              Text(
                "Prueba 1",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Text(
                "2 days ago",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

//function like button
Widget likeButton(width) {
  return ElevatedButton(
    onPressed: () {},
    style: ButtonStyle(
      padding: (width > 620)
          // If the screen size is greater than 620
          ? MaterialStateProperty.all(
              EdgeInsets.symmetric(horizontal: 100, vertical: 15))
          //If the screen size es greater than 450
          : (width > 450
              ? MaterialStateProperty.all(
                  EdgeInsets.symmetric(horizontal: 60, vertical: 15))
              //If the screen size is less than 450
              : MaterialStateProperty.all(
                  EdgeInsets.symmetric(horizontal: 28, vertical: 15),
                )),
      backgroundColor:
          MaterialStateProperty.all<Color>(Color.fromRGBO(235, 235, 235, .6)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
      ),
    ),
    //likeButton library implementation
    child: LikeButton(
      likeBuilder: (bool isLike) {
        return Icon(
          Icons.favorite,
          color: isLike ? Color.fromRGBO(229, 21, 21, 1) : Colors.grey,
        );
      },

      // isLiked: BlocProvider.of<PostCubit>(context).likedByMe(userId),
      // likeCount: BlocProvider.of<PostCubit>(context).getLikesCount(),
      countBuilder: (count, isLiked, text) {
        Widget result;
        if (count == 0) {
          result = Text(
            "LIKE",
            style: TextStyle(
                color: isLiked ? Color.fromRGBO(229, 21, 21, 1) : Colors.grey,
                fontWeight: FontWeight.bold),
          );
        } else
          result = Text("LIKE",
              style: TextStyle(
                  color: isLiked ? Color.fromRGBO(229, 21, 21, 1) : Colors.grey,
                  fontWeight: FontWeight.bold));
        return result;
      },
    ),
  );
}

//Comment Button
Widget commentButton(width) {
  return ElevatedButton.icon(
    onPressed: () {
      // Navigator.pushNamed(context, Routes.postComment);
    },
    style: ButtonStyle(
      padding: (width > 620)
          // If the screen size is greater than 620
          ? MaterialStateProperty.all(
              EdgeInsets.symmetric(horizontal: 95, vertical: 18))
          // If the screen size is greater than 620
          : (width > 450
              ? MaterialStateProperty.all(
                  EdgeInsets.symmetric(horizontal: 48, vertical: 18))
              // If the screen size is less than 620
              : MaterialStateProperty.all(
                  EdgeInsets.symmetric(horizontal: 19, vertical: 18),
                )),
      backgroundColor:
          MaterialStateProperty.all<Color>(Color.fromRGBO(235, 235, 235, .6)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
      ),
    ),
    icon: Icon(Icons.chat_bubble, color: Colors.grey),
    label: Text(
      "COMMENT",
      style: TextStyle(color: Colors.grey),
    ),
  );
}

class Answers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
              "1. Si",
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
    );
  }
}
