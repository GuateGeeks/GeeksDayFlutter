import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/bloc/posts/feed_cubit.dart';
import 'package:geeksday/bloc/posts/post_cubit.dart';
import 'package:geeksday/bloc/posts/quiz_cubit.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/services/implementation/post_service.dart';
import 'package:geeksday/services/navigationService.dart';
import 'package:geeksday/ui/helpers/preview_images.dart';
import 'package:geeksday/ui/locator.dart';

import 'quiz/quiz_form.dart';

class PostCreate extends StatefulWidget {
  final String idEvent;

  PostCreate({Key? key, required this.idEvent}) : super(key: key);

  @override
  _PostCreateState createState() => _PostCreateState();
}

class _PostCreateState extends State<PostCreate> {
  final commentController = TextEditingController();
  File? uploadedImage;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 700 ? 700 : width;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Image.asset(
          "assets/guateGeeksLogo.png",
          width: 150,
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<PostCubit>(create: (_) {
            String userId = BlocProvider.of<AuthCubit>(context).getUserId();
            return PostCubit(
              PostService(),
              Post.newPost("", userId, widget.idEvent),
            );
          }),
          BlocProvider<QuizCubit>(
            create: (context) => QuizCubit(),
          ),
        ],
        child: Builder(
          builder: (context) {
            return Center(
              child: Container(
                width: maxWidth,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.fromLTRB(45, 25, 45, 5),
                alignment: Alignment.topCenter,
                child: Stack(children: [
                  createPostBody(context, uploadedImage),
                  Positioned(
                      bottom: 50,
                      width: maxWidth - 90,
                      child: Center(child: savePost())),
                ]),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget createPostBody(context, uploadedImage) {
    return BlocListener<PostCubit, PostState>(
      listener: (context, state) {
        if (state is PostCreated) {
          locator<NavigationService>().navigateTo('/evento/' + widget.idEvent);
          return;
        } else if (state is PostNotCreated) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        }
      },
      child: Column(
        children: [
          descriptionAndImage(context, uploadedImage),
          const SizedBox(
            height: 40,
          ),
          const Divider(
            thickness: 1,
            height: 1.5,
            color: Color(0xFFE5E5E5),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.5),
            child: ListView(
              children: [
                QuizForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget descriptionAndImage(context, uploadedImage) {
    return Row(
      children: [
        Expanded(
          flex: 7,
          child: description(),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          flex: 3,
          child: image(context, uploadedImage),
        )
      ],
    );
  }

  Widget description() {
    return TextFormField(
      maxLines: 4,
      controller: commentController,
      decoration: const InputDecoration(
          hintText: "Descripcion", border: InputBorder.none),
    );
  }

  Widget image(context, uploadedImage) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: GestureDetector(
        onTap: () => uploadImage(context),
        child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(
                color: const Color(0xFFD3D3D3),
              ),
            ),
            child: uploadedImage == null
                ? const Icon(
                    Icons.add_photo_alternate,
                    size: 40,
                    color: Color(0xFFD3D3D3),
                  )
                : PreviewImage(uploadedImage: uploadedImage)),
      ),
    );
  }

  Widget savePost() {
    String userId = BlocProvider.of<AuthCubit>(context).getUserId();
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        return Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 50),
              primary: Color(0xFF0E89AF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              BlocProvider.of<PostCubit>(context).createPost(
                commentController.text,
                BlocProvider.of<QuizCubit>(context).answers,
              );
            },
            child: state is PostLoading
                ? const CircularProgressIndicator()
                : const Text(
                    "Compartir",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
          ),
        );
      },
    );
  }

  uploadImage(context) async {
    var uploadInput = FileUploadInputElement()..accept = 'image/*';
    uploadInput.click();
    uploadInput.onChange.listen(
      (event) {
        final File file = uploadInput.files!.first;
        final reader = FileReader();
        reader.readAsDataUrl(file);
        reader.onLoadEnd.listen(
          (event) {
            setState(() {
              uploadedImage = file;
            });
            BlocProvider.of<PostCubit>(context).setImage(file);
          },
        );
      },
    );
  }
}
