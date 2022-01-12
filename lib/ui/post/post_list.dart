import 'package:geeksday/bloc/posts/feed_cubit.dart';
import 'package:geeksday/bloc/posts/post_test_cubit.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/services/implementation/post_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/ui/post/post_card.dart';
import 'package:geeksday/ui/post/post_create.dart';

class PostList extends StatefulWidget {
  String idEvent;
  PostList({Key? key, required this.idEvent}) : super(key: key);

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostTestCubit(PostService(), null),
      child: Builder(builder: (context) {
        BlocProvider.of<PostTestCubit>(context).getPost();
        return postListBody(context);
      }),
    );
  }

    Widget postListBody(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double maxWidth = width > 700 ? 700 : width;
    double modalHeight = width > 500 ? height / 2 : height / 1.3;

    return BlocBuilder<PostTestCubit, PostTestState>(builder: (context, state) {
      if(state is PostLoaded1){
        return showPostList(maxWidth, state.postList, modalHeight, context);
      } 

      return Center(child: CircularProgressIndicator());
     
    });
  }

  Widget mostrar(List<Post> postlist, modalHeight){
    return Column(
      children: [
        Column(
          children: postlist.map((e) {
            return Text(e.text);
          }).toList(),
        ),
        floatingActionButtons(modalHeight, context, widget.idEvent)
      ],
    );
  }

  Widget showPostList(double maxWidth, List<Post> posts, double modalHeight, context) {
    return Stack(
      children: [
        postsCards(maxWidth, posts),
        floatingActionButtons(modalHeight, context, widget.idEvent),
      ],
    );
  }

    Widget floatingActionButtons(double modalHeight, context, idEvent) {
    return Positioned(
      right: 10,
      bottom: 15,
      child: Column(
        children: [
          SizedBox(height: 8.0),
          createPostButton(modalHeight, context, idEvent),
        ],
      ),
    );
  }

    Widget createPostButton(modalHeight, context, idEvent) {
    return FloatingActionButton(
      onPressed: () {
        //Show modal new post
        showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) => Container(
            height: modalHeight,
            width: 800,
            child: PostCreate(idEvent: idEvent),
          ),
        );
      },
      tooltip: 'Crear Nuevo Post',
      child: const Icon(Icons.add),
    );
  }

    Widget postsCards(double maxWidth, List<Post> posts) {
      ScrollController scrollController = ScrollController();
    return Center(
      child: Container(
        width: maxWidth,
        child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: RefreshIndicator(
              onRefresh: () =>
                  BlocProvider.of<FeedCubit>(context).getPostList(),
              child: ListView(
                controller: scrollController,
                children: posts.map((post) {
                  return PostCard(post: post);
                }).toList(),
              ),
            )),
      ),
    );
  }
}


// class PostList extends StatefulWidget {
//   final String idEvent;
//   const PostList({Key? key, required this.idEvent}) : super(key: key);

//   @override
//   _PostListState createState() => _PostListState();
// }

// class _PostListState extends State<PostList> {
//   ScrollController scrollController = ScrollController();
//   bool showBackToTopButton = false;

//   @override
//   void initState() {
//     super.initState();
//     scrollController
//       ..addListener(() {
//         setState(() {
//           if (scrollController.offset >= 400) {
//             showBackToTopButton = true;
//           } else {
//             showBackToTopButton = false;
//           }
//         });
//       });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => FeedCubit(PostService(), widget.idEvent),
//       child: Builder(builder: (context) {
//         BlocProvider.of<FeedCubit>(context).getPostList();
//         return postListBody(context);
//       }),
//     );
//   }

//   Widget postListBody(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     double maxWidth = width > 700 ? 700 : width;
//     double modalHeight = width > 500 ? height / 2 : height / 1.3;

//     return BlocBuilder<FeedCubit, FeedState>(builder: (context, state) {
//       if (!(state is PostLoaded)) {
//         return Center(child: CircularProgressIndicator());
//       }

//       final posts = state.post;

//       return (posts.isEmpty)
//           ? postListEmpty(modalHeight)
//           : showPostList(maxWidth, posts, modalHeight);
//     });
//   }

//   Widget showPostList(double maxWidth, List<Post> posts, double modalHeight) {
//     return Stack(
//       children: [
//         postsCards(maxWidth, posts),
//         floatingActionButtons(modalHeight),
//       ],
//     );
//   }

//   Widget postsCards(double maxWidth, List<Post> posts) {
//     return Center(
//       child: Container(
//         width: maxWidth,
//         child: ScrollConfiguration(
//             behavior:
//                 ScrollConfiguration.of(context).copyWith(scrollbars: false),
//             child: RefreshIndicator(
//               onRefresh: () =>
//                   BlocProvider.of<FeedCubit>(context).getPostList(),
//               child: ListView(
//                 controller: scrollController,
//                 children: posts.map((post) {
//                   return PostCard(post: post);
//                 }).toList(),
//               ),
//             )),
//       ),
//     );
//   }

//   Widget postListEmpty(modalHeight) {
//        return Stack(
//       children: [
//         Center(
//           child: Text("Aún no hay posts para este evento"),
//         ),
//         floatingActionButtons(modalHeight),
//       ],
//     );
//   }

//   Widget floatingActionButtons(double modalHeight) {
//     return Positioned(
//       right: 10,
//       bottom: 15,
//       child: Column(
//         children: [
//           showBackToTopButton ? backToTopButton() : Container(),
//           SizedBox(height: 8.0),
//           createPostButton(modalHeight),
//         ],
//       ),
//     );
//   }

//   Widget backToTopButton() {
//     return GestureDetector(
//       onTap: () {
//         scrollController.animateTo(0,
//             duration: Duration(milliseconds: 500), curve: Curves.linear);
//       },
//       child: Container(
//         height: 45,
//         width: 45,
//         decoration: BoxDecoration(
//           color: Colors.grey[200],
//           borderRadius: BorderRadius.all(Radius.circular(25)),
//           boxShadow: [
//             BoxShadow(
//                 offset: Offset(0, 4.0),
//                 blurRadius: 0.50,
//                 color: Colors.black.withOpacity(.2),
//                 spreadRadius: 0.10)
//           ],
//         ),
//         child: Icon(
//           Icons.arrow_upward_sharp,
//           color: Colors.blueGrey,
//         ),
//       ),
//     );
//   }

//   Widget createPostButton(modalHeight) {
//     return FloatingActionButton(
//       onPressed: () {
//         //Show modal new post
//         showModalBottomSheet(
//           isScrollControlled: true,
//           backgroundColor: Colors.transparent,
//           context: context,
//           builder: (context) => Container(
//             height: modalHeight,
//             width: 800,
//             child: PostCreate(idEvent: widget.idEvent),
//           ),
//         );
//       },
//       tooltip: 'Crear Nuevo Post',
//       child: const Icon(Icons.add),
//     );
//   }
// }
