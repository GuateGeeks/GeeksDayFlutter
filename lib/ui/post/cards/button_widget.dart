import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:geeksday/routes.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLiked = false;
    return Column(
      children: <Widget>[
        Text(
          "Se el primer en darle me gusta",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(235, 235, 235, .6),
                      padding: EdgeInsets.symmetric(
                          horizontal: 35.0, vertical: 15.0)),
                  icon: LikeButton(
                    isLiked: isLiked,
                    onTap: (isLiked) async {
                      return !isLiked;
                    },
                  ),
                  label: Text("LIKE", style: TextStyle(color: Colors.grey))),
              ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.postComment);
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(235, 235, 235, .6),
                      padding: EdgeInsets.symmetric(
                          horizontal: 35.0, vertical: 15.0)),
                  icon: Icon(Icons.chat_bubble, color: Colors.grey),
                  label: Text("COMMENT", style: TextStyle(color: Colors.grey)))
            ],
          ),
        )
      ],
    );
  }
}
