import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:geeksday/bloc/posts/feed_cubit.dart';
import 'package:geeksday/bloc/posts/post_cubit.dart';
import 'package:geeksday/models/events.dart';
import 'package:geeksday/services/implementation/post_service.dart';
import 'package:geeksday/ui/helpers/preview_images.dart';

class QuizCreate extends StatefulWidget {
  Events event;

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
        child: Container(
          padding: EdgeInsets.fromLTRB(45, 25, 45, 5),
          alignment: Alignment.topCenter,
          child: createQuizBody(uploadedImage),
        ),
      ),
    );
  }

  Widget createQuizBody(uploadedImage) {
    return SingleChildScrollView(
      child: Column(
        children: [
          image(uploadedImage),
          description(),
          SizedBox(
            height: 30,
          ),
          inputAnswers(context)
          // savePost(),
        ],
      ),
    );
  }

  Widget image(uploadedImage) {
   return Container(
      height: 260,
      width: 240,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: uploadedImage == null
                ? Container(
                    width: 230,
                    height: 230,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                        color: Color(0xFFD3D3D3),
                      ),
                    ),
                    child: Icon(
                      Icons.image,
                      size: 80,
                      color: Color(0xFFD3D3D3),
                    ),
                  )
                : Container(
                    width: 230,
                    height: 230,
                    child: PreviewImage(uploadedImage: uploadedImage),
                  ),
          ),
          Positioned(
            right: 5,
            bottom: 10,
            child: GestureDetector(
              onTap: () => uploadImage(context),
              child: Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  border: Border.all(
                    color: Color(0xFFD3D3D3)
                  ),
                ),
                child: Icon(
                  Icons.camera_alt,
                  size: 40,
                  color: Color(0xFF0E89AF),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget description() {
     return PhysicalModel(
      borderRadius: BorderRadius.circular(15),
      color: Colors.white,
      elevation: 5.0,
      shadowColor: Colors.black,
      child: TextFormField(
        
        maxLines: 6,
        minLines: 6,
        decoration: InputDecoration(
          hintText: "Descripcion",
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
          filled: true,
        ),
      ),
    );
  }


  Widget inputAnswers(BuildContext context) {
    return Container(
      child: Column(  
        children: [
          TextFormField(
            decoration: InputDecoration(  
              filled: false,
              
              prefixIcon: FlutterSwitch(
                      width: 50.0,
                      height: 20.0,
                      toggleSize: 25.0,
                      value: status,
                      borderRadius: 70.0,
                      padding: 2.0,
                      toggleColor: Color.fromRGBO(2, 107, 206, 1),
                      switchBorder: status ? Border.all(
                        color: Color.fromRGBO(2, 107, 206, 1),
                        width: 1.0,
                      ) : Border.all(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        width: 1.0,
                      ),
                      toggleBorder: Border.all(
                        color: Color.fromRGBO(2, 107, 206, 1),
                        width: 3.0,
                      ),
                      activeColor: Colors.black38,
                      inactiveColor: Colors.black38,
                      onToggle: (val) {
                        setState(() {
                          status = val;
                        });
                      },
                    ),
            ),
          ),
        ],
      ),
    );
    return Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: TextFormField(
                onChanged: (value) {
                  },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: () {
                     
                    },
                    child: Tooltip(
                      message: "Respuesta Correcta",
                      
                    ),
                  ),
                  hintText: "Agregar Respuesta",
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  focusedBorder:
                      Theme.of(context).inputDecorationTheme.focusedBorder,
                  enabledBorder:
                      Theme.of(context).inputDecorationTheme.enabledBorder,
                ),
              ),
            );
        
    
  }

    void saveAnswers(BuildContext context, int index, String value){
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
