import 'package:flutter_svg/svg.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/bloc/posts/post_cubit.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/services/implementation/post_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/ui/helpers/return_button.dart';
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

    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        //get user id
        String user = BlocProvider.of<AuthCubit>(context).getUser().uid;
        return Scaffold(
          appBar: AppBar(
            elevation: 0.5,
            title: Text(
              'Comentarios',
              style: Theme.of(context).appBarTheme.toolbarTextStyle,
            ),
            leading: ReturnButton(),
          ),
          body: Center(
            //Main Container
            child: Container(
              width: maxWidth,
              child: Stack(
                children: [
                  ListView(
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

                  //Function to create a new comment
                  textFormFielComment(context)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  //post description
  Widget postDescription(context) {
    PostCubit state = BlocProvider.of<PostCubit>(context);
    String userId = state.getPost()!.idUser;
    bool isLiked = state.likedByMe(userId);
    AuthUser userData =
        BlocProvider.of<AuthCubit>(context).getUserByPost(userId);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 46,
                  height: 46,
                  child: SvgPicture.string(multiavatar(userData.image)),
                ),
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //we show the user's name
                      Text(
                        userData.name,
                        style: Theme.of(context).textTheme.headline1,
                        textAlign: TextAlign.right,
                      ),
                      Text(
                        state.getDatePost(post.createdAt),
                        style: Theme.of(context).textTheme.headline2,
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Container(
          margin: EdgeInsets.only(right: 5),
          child: GestureDetector(
              onTap: () {
                likePost(context);
                isLiked = !isLiked;
              },
              child: isLiked
                  ? SvgPicture.asset('assets/icons/is_liked.svg')
                  : SvgPicture.asset('assets/icons/like.svg')),
        ),
      ),
    );
  }

  //Comments
  List<Widget> comments(context, userId) {
    PostCubit state = BlocProvider.of<PostCubit>(context);
    return post.commentList.map((comment) {
      AuthUser userData =
          BlocProvider.of<AuthCubit>(context).getUserByPost(comment.idUser);
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        child: SvgPicture.string(multiavatar(userData.image)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //we show the user's name
                            Text(
                              userData.name,
                              style: Theme.of(context).textTheme.headline1,
                              textAlign: TextAlign.right,
                            ),
                            Text(
                              state.getDatePost(post.createdAt),
                              style: Theme.of(context).textTheme.headline2,
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: deleteCommentButton(
                comment.id,
                comment.idUser,
                context,
              ),
            ),
            SizedBox(
              height: 6.0,
            ),
            Container(
              margin: EdgeInsets.only(left: 58),
              child: Text(
                comment.text,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  //function to delete comment
  Widget deleteCommentButton(commentId, commentUserId, context) {
    //validate if the user is an administrator or the user has made a comment to show the delete comment button
    var user = BlocProvider.of<AuthCubit>(context).getUser();
    if (user.uid == commentUserId || user.isadmin == true) {
      return Theme(
        data: Theme.of(context).copyWith(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        child: PopupMenuButton(
          icon: Icon(
            Icons.more_vert_rounded,
            color: Color(0xFF0E89AF),
            size: 30,
          ),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: "Eliminar",
              child: Text("Eliminar"),
            ),
          ],
          onSelected: (_) {
            BlocProvider.of<PostCubit>(context).commentDeletion(commentId);
          },
        ),
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
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  style: TextStyle(
                    fontSize: 13,
                  ),
                  textInputAction: TextInputAction.send,
                  minLines: 1,
                  maxLines: 2,
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Agregar un comentario",
                    hintStyle: TextStyle(
                      fontSize: 13,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    filled: true,
                    fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                  ),
                ),
              ),
            ),
            Theme(
              data: Theme.of(context).copyWith(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
              ),
              child: IconButton(
                onPressed: () {
                  //get the information of who is making the comment
                  String idUser =
                      BlocProvider.of<AuthCubit>(context).getUserId();
                  BlocProvider.of<PostCubit>(context)
                      .makeComment(idUser, _controller.text);
                },
                icon: Icon(
                  Icons.send,
                  color: Color(0xFF0E89AF),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //function to know which user has liked the post
  void likePost(BuildContext context) {
    String userId = post.idUser;
    BlocProvider.of<PostCubit>(context).toggleLikeToPost(userId);
  }
}
