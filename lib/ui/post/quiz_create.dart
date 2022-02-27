import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/bloc/posts/feed_cubit.dart';
import 'package:geeksday/bloc/posts/post_cubit.dart';
import 'package:geeksday/models/event.dart';
import 'package:geeksday/services/implementation/post_service.dart';
import 'package:geeksday/ui/helpers/preview_images.dart';

class QuizCreate extends StatefulWidget {
  Event event;

  QuizCreate({Key? key, required this.event}) : super(key: key);

  @override
  State<QuizCreate> createState() => _QuizCreateState();
}

class _QuizCreateState extends State<QuizCreate> {
  File? uploadedImage;
  Map<int, String> answersMap = {};
  bool status = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 800 ? 800 : width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Image.asset(
          'assets/guateGeeksLogo.png',
          width: 150,
          fit: BoxFit.cover,
        ),
      ),
      body: BlocProvider(
        create: (_) => FeedCubit(PostService(), widget.event.id),
        child: Center(
          child: Container(
            width: maxWidth,
            padding: EdgeInsets.fromLTRB(20, 25, 20, 5),
            child: createQuizBody(uploadedImage),
          ),
        ),
      ),
    );
  }

  Widget createQuizBody(uploadedImage) {
    return Column(
      children: [
        descriptionAndImage(uploadedImage),
        SizedBox(
          height: 40,
        ),
        Divider(
          thickness: 1,
          height: 1.5,
          color: Color(0xFFE5E5E5),
        ),
        SizedBox(
          height: 80,
        ),
        inputAnswers(context),
        inputAnswers(context),
        inputAnswers(context),
      ],
    );
  }

  Widget descriptionAndImage(uploadedImage) {
    return Row(
      children: [
        Expanded(
          flex: 7,
          child: description(),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          flex: 3,
          child: image(uploadedImage),
        )
      ],
    );
  }

  Widget description() {
    return TextFormField(
      maxLines: 4,
      decoration:
          InputDecoration(hintText: "Descripcion", border: InputBorder.none),
    );
  }

  Widget image(uploadedImage) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: uploadedImage == null
              ? Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(
                      color: Color(0xFFD3D3D3),
                    ),
                  ),
                  child: Icon(
                    Icons.image,
                    size: 40,
                    color: Color(0xFFD3D3D3),
                  ),
                )
              : Container(
                  width: 130,
                  height: 130,
                  child: PreviewImage(uploadedImage: uploadedImage),
                ),
        ),
        Positioned(
          right: 5,
          bottom: -10,
          child: GestureDetector(
            onTap: () => uploadImage(context),
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(50)),
                border: Border.all(color: Color(0xFFD3D3D3)),
              ),
              child: Icon(
                Icons.camera_alt,
                size: 25,
                color: Color(0xFF0E89AF),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget inputAnswers(BuildContext context) {
    bool isSwitchOn = true;

    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          suffixIcon: Switch(
            value: isSwitchOn,
            onChanged: (value) {
              setState(() {
                isSwitchOn = !isSwitchOn;
              });
            },
          ),
          hintText: "Respuesta",
          border: InputBorder.none,
          filled: false,
        ),
      ),
    );
  }

  void saveAnswers(BuildContext context, int index, String value) {
    var postCubit = BlocProvider.of<PostCubit>(context);
    answersMap[index] = value;
    answersMap.forEach((key, value) {
      setState(() {
        postCubit.updateQuizAnswer(key, value);
      });
    });
  }

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
            setState(() {
              uploadedImage = file;
            });
            BlocProvider.of<FeedCubit>(context).setImage(file);
          },
        );
      },
    );
  }
}
