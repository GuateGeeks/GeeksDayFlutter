import 'package:geeksday/bloc/post_cubit.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/services/implementation/post_service.dart';
import 'package:geeksday/ui/post/post_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostList extends StatelessWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostCubit(PostService()),
      child: builder(context),
    );
  }

  Widget builder(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 700 ? 700 : width;
    return BlocBuilder<PostCubit, PostState>(builder: (_, state) {
      return Center(
        child: Container(
          width: maxWidth,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('posts').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return ListView(
                children: snapshot.data!.docs.map((post) {
                  return PostCard(
                      post: Post.fromMap(
                          post.data() as Map<String, dynamic>, post.id));
                }).toList(),
              );
            },
          ),
        ),
      );

      // return Center(
      //   child: StreamBuilder<QuerySnapshot>(
      //     stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      //     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //       return ListView(
      //         children: snapshot.data!.docs.map((post) {
      //           return PostCard(
      //               post: Post.fromMap(
      //                   post.data() as Map<String, dynamic>, post.id));
      //         }).toList(),
      //       );
      //     },
      //   ),
      // );
    });
  }
}

/*
children: snapshot.data!.docs.map((post) {
                return PostCard(
                  body: post['body'],
                  imageRef: post['imageRef'],
                );
              }).toList(),
*/
