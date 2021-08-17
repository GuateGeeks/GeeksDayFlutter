import 'dart:html';

import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/bloc/post_cubit.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/services/implementation/post_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCreate extends StatefulWidget {
  static Widget create(BuildContext context) {
    AuthUser user = context.read<AuthCubit>().getUser();
    return BlocProvider(
      create: (_) => PostCubit(PostService(), Post.newPost("", user)),
      child: PostCreate(),
    );
  }

  PostCreate({Key? key}) : super(key: key);

  @override
  _PostCreateState createState() => _PostCreateState();
}

class _PostCreateState extends State<PostCreate> {
  @override
  Widget build(BuildContext context) {
    final commentController = TextEditingController();
    //Responsive modal Nuevo post
    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 700 ? 700 : width;

    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        return Center(
          child: Container(
            width: maxWidth,
            color: Color(0xff757575),
            child: Container(
              width: maxWidth,
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              //header modal Nuevo Post
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  //Header Nuevo Post
                  title(),
                  SizedBox(
                    height: 15.0,
                  ),
                  //Input description Nuevo Post
                  description(commentController),
                  //Button save Nuevo Post
                  buttonSave(commentController)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  //Header Nuevo Post
  Widget title() {
    return Text(
      "New Post",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20.0,
        color: Colors.blue,
      ),
    );
  }

  //Input description
  Widget description(commentController) {
    return TextFormField(
      minLines: 1,
      maxLines: 4,
      controller: commentController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        suffixIcon: InkWell(
          onTap: () {
            uploadImage(context);
          },
          child: Icon(Icons.image_search),
        ),
        hintText: "Description",
        border: InputBorder.none,
        filled: true,
        fillColor: Color.fromRGBO(240, 240, 240, 1),
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
        focusedBorder: OutlineInputBorder(
          borderRadius: new BorderRadius.circular(8),
          borderSide: new BorderSide(
            color: Color.fromRGBO(240, 240, 240, 1),
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderRadius: new BorderRadius.circular(8),
          borderSide: new BorderSide(
            color: Color.fromRGBO(240, 240, 240, 1),
          ),
        ),
      ),
    );
  }

  //Button Guardar
  Widget buttonSave(commentController) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: ElevatedButton(
        onPressed: () {
          BlocProvider.of<PostCubit>(context)
              .createPost(commentController.text);
          Navigator.pop(context);
        },
        style: ButtonStyle(
          padding:
              MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 20)),
        ),
        child: const Text("Guardar"),
      ),
    );
  }

  //upload images from gallery
  uploadImage(BuildContext context) async {
    var uploadInput = FileUploadInputElement()..accept = 'image/*';
    uploadInput.click();
    uploadInput.onChange.listen(
      (event) {
        final File file = uploadInput.files!.first;
        final reader = FileReader();
        reader.readAsDataUrl(file);
        reader.onLoadEnd.listen(
          (event) {
            BlocProvider.of<PostCubit>(context).setImage(file);
          },
        );
      },
    );
  }

  final TextEditingController maxWidthController = TextEditingController();

  final TextEditingController maxHeightController = TextEditingController();

  final TextEditingController qualityController = TextEditingController();

  Future<void> _displayPickImageDialog(
      BuildContext context, OnPickImageCallback onPick) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add optional parameters'),
          content: Column(
            children: <Widget>[
              TextField(
                controller: maxWidthController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration:
                    InputDecoration(hintText: "Enter maxWidth if desired"),
              ),
              TextField(
                controller: maxHeightController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration:
                    InputDecoration(hintText: "Enter maxHeight if desired"),
              ),
              TextField(
                controller: qualityController,
                keyboardType: TextInputType.number,
                decoration:
                    InputDecoration(hintText: "Enter quality if desired"),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('PICK'),
              onPressed: () {
                double? width = maxWidthController.text.isNotEmpty
                    ? double.parse(maxWidthController.text)
                    : null;
                double? height = maxHeightController.text.isNotEmpty
                    ? double.parse(maxHeightController.text)
                    : null;
                int? quality = qualityController.text.isNotEmpty
                    ? int.parse(qualityController.text)
                    : null;
                onPick(width, height, quality);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

typedef void OnPickImageCallback(
    double? maxWidth, double? maxHeight, int? quality);
