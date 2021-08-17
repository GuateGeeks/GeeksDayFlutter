import 'dart:html';

import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/bloc/post_cubit.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/services/implementation/post_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

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
  //Variables para mostrar preview de la imagen
  // List<XFile>? _imagenFile;

  // set _imageFile(XFile? value) {
  //   _imagenFile = value == null ? null : [value];
  // }

  // final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final commentController = TextEditingController();
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "New Post",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  /*************container mostrar preview imagen***************/

                  //     Container(
                  //       child: ListView.builder(
                  //   key: UniqueKey(),
                  //   itemBuilder: (context, index) {

                  //     return Semantics(
                  //       label: 'image_picker_example_picked_image',
                  //       child: Image.file(File(_imagenFileList![index].path)),
                  //     );
                  //   },

                  // ),
                  //     ),

                  Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(230, 230, 230, 1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Description',
                              contentPadding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                            ),
                            controller: commentController,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            uploadImage(context);
                          },
                          // onPressed: () async {
                          //   final XFile? image = await _picker.pickImage(
                          //     source: ImageSource.gallery,
                          //     maxWidth: 100,
                          //     maxHeight: 120,
                          //     imageQuality: 100,
                          //   );
                          //   setState(() {
                          //     _imageFile = image;
                          //   });
                          // },
                          icon: const Icon(Icons.image_search),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<PostCubit>(context)
                            .createPost(commentController.text);
                        Navigator.pop(context);
                      },
                      child: const Text("aaa"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
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
            BlocProvider.of<PostCubit>(context).setImage(file);
          },
        );
      },
    );
  }
}

  // final TextEditingController maxWidthController = TextEditingController();

  // final TextEditingController maxHeightController = TextEditingController();

  // final TextEditingController qualityController = TextEditingController();

// class PostCreate extends StatelessWidget {
//   static Widget create(BuildContext context) {
//     AuthUser user = context.read<AuthCubit>().getUser();
//     return BlocProvider(
//       create: (_) => PostCubit(PostService(), Post.newPost("", user)),
//       child: PostCreate(),
//     );
//   }

//   PostCreate({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return builder(context);
//   }

//   Widget builder(BuildContext context) {
//     final commentController = TextEditingController();
//     var state = context.read<PostCubit>();
//     return Material(
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: TextField(
//                   controller: commentController,
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {
//                   uploadImage(context);
//                 },
//                 icon: const Icon(Icons.image_search),
//               )
//             ],
//           ),
//           Padding(
//             padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
//             child: ElevatedButton(
//               onPressed: () {
//                 state.createPost(commentController.text);
//                 Navigator.pop(context);
//               },
//               child: const Text("aaa"),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _displayPickImageDialog(
//       BuildContext context, OnPickImageCallback onPick) async {
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text('Add optional parameters'),
//             content: Column(
//               children: <Widget>[
//                 TextField(
//                   controller: maxWidthController,
//                   keyboardType: TextInputType.numberWithOptions(decimal: true),
//                   decoration:
//                       InputDecoration(hintText: "Enter maxWidth if desired"),
//                 ),
//                 TextField(
//                   controller: maxHeightController,
//                   keyboardType: TextInputType.numberWithOptions(decimal: true),
//                   decoration:
//                       InputDecoration(hintText: "Enter maxHeight if desired"),
//                 ),
//                 TextField(
//                   controller: qualityController,
//                   keyboardType: TextInputType.number,
//                   decoration:
//                       InputDecoration(hintText: "Enter quality if desired"),
//                 ),
//               ],
//             ),
//             actions: <Widget>[
//               TextButton(
//                 child: const Text('CANCEL'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//               TextButton(
//                   child: const Text('PICK'),
//                   onPressed: () {
//                     double? width = maxWidthController.text.isNotEmpty
//                         ? double.parse(maxWidthController.text)
//                         : null;
//                     double? height = maxHeightController.text.isNotEmpty
//                         ? double.parse(maxHeightController.text)
//                         : null;
//                     int? quality = qualityController.text.isNotEmpty
//                         ? int.parse(qualityController.text)
//                         : null;
//                     onPick(width, height, quality);
//                     Navigator.of(context).pop();
//                   }),
//             ],
//           );
//         });
//   }
// }

// typedef void OnPickImageCallback(
//     double? maxWidth, double? maxHeight, int? quality);
