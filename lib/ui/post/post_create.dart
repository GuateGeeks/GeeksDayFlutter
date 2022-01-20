import 'dart:html';

import 'package:flutter/material.dart';

class PostCreate extends StatelessWidget {
  static Widget create(BuildContext context) => PostCreate();

  const PostCreate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    File? uploadedImage;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Image.asset(
          'assets/guategeeks-logo-clear.png',
          width: 150,
          fit: BoxFit.cover,
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(15, 25, 15, 5),
        alignment: Alignment.topCenter,
        child: createPostBody(uploadedImage),
      ),
    );
  }

  Widget createPostBody(uploadedImage) {
    return SingleChildScrollView(
      child: Column(
        children: [
          image(uploadedImage),
          SizedBox(
            height: 40,
          ),
          description(),
        ],
      ),
    );
  }

  Widget image(uploadedImage) {
    return Container(
      height: 280,
      width: 260,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: uploadedImage == null
                ? Container(
                    width: 250,
                    height: 250,
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
                : Container(),
          ),
          Container(
            child: Positioned(
                right: 5,
                bottom: 20,
              child: GestureDetector(
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      border: Border.all(
                        color: Color(0xFFD3D3D3),
                      ),
                    ),
                  child: Icon(
                    Icons.camera_alt,
                    size: 30,
                    color: Color(0xFF0E89AF),
                   ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget description(){
    return TextField(
      decoration: InputDecoration(  
        hintText: "Descripcion",
        hintMaxLines: 6,
        
      ),
    );
  }

}




// import 'dart:html';
// import 'package:geeksday/bloc/auth_cubit.dart';
// import 'package:geeksday/bloc/posts/post_cubit.dart';
// import 'package:geeksday/models/auth_user.dart';
// import 'package:geeksday/models/post.dart';
// import 'package:geeksday/models/quiz.dart';
// import 'package:geeksday/services/implementation/post_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_whisperer/image_whisperer.dart';
// import 'package:flutter/foundation.dart';

// class PostCreate extends StatefulWidget {
//   final String idEvent;
//   PostCreate({Key? key, required this.idEvent}) : super(key: key);

//   @override
//   _PostCreateState createState() => _PostCreateState();
// }

// class _PostCreateState extends State<PostCreate> {
//   final commentController = TextEditingController();
//   File? uploadedImage;

//   Map<int, String> answersMap = {};

//   Widget _content(BuildContext context){
//     //responsive modal
//     double width = MediaQuery.of(context).size.width;
//     double maxWidth = width > 700 ? 700 : width;
//     return Center(
//       child: Container(  
//         width: maxWidth,
//         height: 900,
//         padding: EdgeInsets.fromLTRB(35, 20, 35, 5),
//         decoration: BoxDecoration(
//           color: Theme.of(context).primaryColor,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20.0),
//             topRight: Radius.circular(20.0),
//           ),
//         ),
//         child: Column(  
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(20),
//               child: Container(
//                 alignment: Alignment.topCenter,
//                 width: 50,
//                 height: 5,
//                 color: Colors.white,
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Text("Crear", 
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 26
//               ),
//             ),
//             SizedBox(
//               height: 45,
//             ),
//             createPost(),
//             Container(
//               margin: EdgeInsets.symmetric(vertical: 20),
//               child: Divider(
//                 height: 2,
//                 color: Colors.white,      
//               ),
//             ),
//             createQuiz(),
//           ],
//         )
//       ),
//     );
//   }

//   Widget createPost(){
//     return GestureDetector(
//       onTap: (){},
//       child: Row(  
//         children: [
//           Icon(
//             Icons.post_add_outlined,
//             color: Colors.white,
//           ),
//           SizedBox(width: 5),
//           Text(  
//             'Post',
//             style: Theme.of(context).textTheme.headline2
//           ),
//         ],
//       ),
//     );
//   }

//   Widget createQuiz(){
//     return GestureDetector(
//       onTap: (){},
//       child: Row(  
//         children: [
//           Icon(
//             Icons.post_add_outlined,
//             color: Colors.white,
//           ),
//           Text(  
//             'Quiz',
//             style: Theme.of(context).textTheme.headline2
//           ),
//         ],
//       ),
//     );
//   }

//   uploadImage(BuildContext context) async {
//     var uploadInput = FileUploadInputElement()..accept = 'image/*';
//     uploadInput.click();
//     uploadInput.onChange.listen(
//       (event) {
//         final File file = uploadInput.files!.first;
//         final reader = FileReader();
//         reader.readAsDataUrl(file);
//         reader.onLoadEnd.listen(
//           (event) {
//             setState(() {
//               uploadedImage = file;
//             });
//             BlocProvider.of<PostCubit>(context).setImage(file);
//           },
//         );
//       },
//     );
//   }

//   Widget previewImages(context) {
//     if (uploadedImage != null) {
//       BlobImage blobImage =
//           new BlobImage(uploadedImage, name: uploadedImage!.name);
//       return Container(
//         child: Image.network(blobImage.url, width: 50, height: 250),
//       );
//     }
//     return Container();
//   }

//   List<Widget> inputAnswers(BuildContext context) {
    
//     var postCubit = BlocProvider.of<PostCubit>(context);
//     bool isQuiz = postCubit.isQuiz();
//     var post = postCubit.state.post;
//     if (isQuiz) {
//       return post.quiz!.questions[0].answers
//           .map(
//             (answer) => Padding(
//               padding: const EdgeInsets.only(top: 10.0),
//               child: TextFormField(
//                 onChanged: (value) {
//                   int index = postCubit.indexOfAnswer(answer);
//                   saveAnswers(context, index, value);
//                 },
//                 keyboardType: TextInputType.text,
//                 decoration: InputDecoration(
//                   suffixIcon: InkWell(
//                     onTap: () {
//                       postCubit.toggleAnswerIsCorrect(answer);
//                     },
//                     child: Tooltip(
//                       message: "Respuesta Correcta",
//                       child: answer.isCorrect
//                           ? Icon(
//                               Icons.check_circle_rounded,
//                               color: Colors.green,
//                             )
//                           : Icon(Icons.check_circle_rounded),
//                     ),
//                   ),
//                   hintText: answer.text,
//                   border: InputBorder.none,
//                   filled: true,
//                   fillColor: Theme.of(context).inputDecorationTheme.fillColor,
//                   contentPadding:
//                       const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
//                   focusedBorder:
//                       Theme.of(context).inputDecorationTheme.focusedBorder,
//                   enabledBorder:
//                       Theme.of(context).inputDecorationTheme.enabledBorder,
//                 ),
//               ),
//             ),
//           )
//           .toList();
//     }
//     return [];
//   }

//   void saveAnswers(BuildContext context, int index, String value){
//     var postCubit = BlocProvider.of<PostCubit>(context);
//     answersMap[index] = value;
//     answersMap.forEach((key, value) { 
//       setState(() {
//         postCubit.updateQuizAnswer(key, value);
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     String idUser = BlocProvider.of<AuthCubit>(context).getUserId();
//     return BlocProvider(
//       create: (_) => PostCubit(PostService(), Post.newPost("", idUser, widget.idEvent)),
//       child: _content(context),
//     );
//   }

//   Widget title(BuildContext context) {
//     AuthUser userData = BlocProvider.of<AuthCubit>(context).getUser();
//     bool isQuiz = BlocProvider.of<PostCubit>(context).isQuiz();
//     var boldStyle = Theme.of(context).textTheme.headline2;
//     var grayStyle = Theme.of(context).textTheme.headline5;

//       return Padding(
//         padding: EdgeInsets.fromLTRB(0, 15, 15, 15),
//         child: Row(
//           children: [
//             TextButton(
//               onPressed: () => BlocProvider.of<PostCubit>(context).unsetQuiz(),
//               child: Text("Post", style: isQuiz ? grayStyle : boldStyle,),
//             ),

//             userData.isadmin == true ?
//             Row(
//               children: [
//                 Text("/", style: TextStyle(fontSize: 25, color: Colors.grey)),
//                 TextButton(
//                   onPressed: () {
           
//                     Question question = Question(
//                       "Pregunta", [
//                         Answer("Respuesta", false, 0),
//                         Answer("Respuesta", false, 0),
//                       ],
//                     );
//                     BlocProvider.of<PostCubit>(context).setQuiz(Quiz([question], []));
//                   },
//                   child: Text("Quiz", style: isQuiz ? boldStyle : grayStyle),
//                 ),
//               ],
//             )
//             : Container(),
//           ],
//         ),
//       );
//   }

//   //Add TextFromField dynamically
//   Widget addAnswer(BuildContext context) {
//     bool isQuiz = BlocProvider.of<PostCubit>(context).isQuiz();
//     if (isQuiz) {
//       return TextButton(
//         onPressed: () => {BlocProvider.of<PostCubit>(context).addAnswer()},
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Icon(Icons.add),
//             Text("Agregar Respuesta"),
//           ],
//         ),
//       );
//     }
//     return Container();
//   }

//   Widget description(BuildContext context) {
//     return TextFormField(
//       minLines: 1,
//       maxLines: 4,
//       controller: commentController,
//       keyboardType: TextInputType.text,
//       decoration: InputDecoration(
//         suffixIcon: InkWell(
//           onTap: () {
//             uploadImage(context);
//           },
//           child: Icon(Icons.image_search),
//         ),
//         hintText: "Descripcion",
//       ),
//     );
//   }

//    Widget buttonSave(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
//       child: ValueListenableBuilder<TextEditingValue>(
//         valueListenable: commentController,
//         builder: (context, value, child){
//           return ElevatedButton(
//             onPressed: value.text.isNotEmpty ? () {
//               BlocProvider.of<PostCubit>(context).createPost(commentController.text);
//               Navigator.pop(context);
//             } : null,
//             style: ButtonStyle(
//               padding:
//                   MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 20)),
//             ),
//             child: Text("Guardar"),
//           );
//         },
//       ),
//     );
//   }
// }
