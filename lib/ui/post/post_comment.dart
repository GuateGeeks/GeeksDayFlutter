import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/bloc/post_cubit.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/services/implementation/post_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multiavatar/multiavatar.dart';

class PostComment extends StatelessWidget {
  //get the data from the posts
  Post post;
  PostComment(this.post, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostCubit(PostService(), this.post),
      child: builder(context),
    );
  }

  @override
  Widget builder(BuildContext context) {
    //define screen width
    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 700 ? 700 : width;

    return BlocBuilder<PostCubit, PostState>(builder: (context, state) {
      //get user id
      String user = BlocProvider.of<AuthCubit>(context).getUser().uid;
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          //Main Container
          child: Container(
            width: maxWidth,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: ListView(
                      children: [
                        //function to show the image, the date and the description of the post
                        postDescription(context),
                        const Divider(
                          height: 25,
                          thickness: 1,
                        ),
                        //function to display the image, name, date and comment
                        ...comments(context, user),
                        SizedBox(
                          height: 70,
                        )
                      ],
                    ),
                  ),
                  //Function to create a new comment
                  textFormFielComment(context)
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
  //post description
  Widget postDescription(context) {
    PostCubit state = BlocProvider.of<PostCubit>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                //verify that the user has an avatar as a profile picture and display it
                child: post.userimage == null
                    ? Container()
                    : SvgPicture.string(multiavatar(post.userimage)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      post.username,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Text(
                      //get the date the post was made
                      state.getDatePost(post.createdAt),
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 7.0,
          ),
          Text(
            post.text,
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }
  //Comments
  List<Widget> comments(context, userId) {
    PostCubit state = BlocProvider.of<PostCubit>(context);
    return post.commentList
      .map((comment) => Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                            width: 50,
                            height: 50,
                            child: SvgPicture.string(
                                multiavatar(comment.user.image),
                            ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                comment.user.name,
                                style: Theme.of(context).textTheme.headline1,
                              ),
                              Text(
                                //function to show the date the comment was made
                                state.getDatePost(comment.createdAt),
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  //button to delete comment
                  deleteCommentButton(
                    comment.id, 
                    comment.user.uid, 
                    context,
                  ),
                ],
              ),
            SizedBox(
              height: 7.0,
            ),
            Text(
              comment.text,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    ).toList();
  }

  //function to delete comment
  Widget deleteCommentButton(commentId, commentUserId, context){
    //validate if the user is an administrator or the user has made a comment to show the delete comment button
    var user = BlocProvider.of<AuthCubit>(context).getUser();
    if(user.uid == commentUserId || user.isadmin == true){
      return PopupMenuButton(
        itemBuilder: (context) => [
          PopupMenuItem(
            value: "Eliminar",
            child: Text("Eliminar"),
          ),
        ],
        onSelected: (_){
          BlocProvider.of<PostCubit>(context).commentDeletion(post, commentId);
        },
      );
    }
    return Container();
  }

  //make a comment
  Widget textFormFielComment(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    return Positioned(
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: Container(
        //color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  minLines: 1,
                  maxLines: 2,
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Agregar un comentario",
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(8),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderRadius: new BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                //get the information of who is making the comment
                AuthUser user = BlocProvider.of<AuthCubit>(context).getUser();
                String userImage =
                    BlocProvider.of<AuthCubit>(context).getUserImage();
                BlocProvider.of<PostCubit>(context)
                    .makeComment(user, _controller.text, userImage);
              },
              icon: Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }
}
