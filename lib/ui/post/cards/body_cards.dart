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
    return Column(
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
                child: Image.network(
                  snapshot.data.toString(),
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20.0),
          child: Text(state.getPost()!.text,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              )),
        ),
      ],
    );
  }
}
