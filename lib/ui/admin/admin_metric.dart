import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geeksday/bloc/admin_cubit.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/bloc/post_cubit.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/services/admin_service.dart';
import 'package:geeksday/services/implementation/admin_service.dart';
import 'package:geeksday/services/implementation/auth_service.dart';
import 'package:geeksday/services/implementation/post_service.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:provider/provider.dart';

class AdminMetric extends StatefulWidget {
  const AdminMetric({Key? key}) : super(key: key);

  @override
  State<AdminMetric> createState() => _AdminMetricState();
}

List<String> categories = [
  'Más publicaciones',
  'Más me gusta',
  'Más comentarios',
  'Mayor Puntuacion en los Quiz',
];
String categorieDefault = "Más publicaciones";

class _AdminMetricState extends State<AdminMetric> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AdminCubit(AdminService(), PostService(), AuthService()),
      child: Scaffold(
          appBar: AppBar(
            title: Text("Admin"),
          ),
          body: _body(context)),
    );
  }

  Widget _body(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 700 ? 700 : width;

    return BlocBuilder<AdminCubit, AdminState>(
      builder: (context, state) {
        return Center(
          child: Container(
            width: maxWidth,
            child: Card(  
              child: ListView(  
                children: [
                  _crearDropdown(context),
                  showUsers(context),
                ],
              ),
            ),
            // child: Column(
            //   children: [
            //     Container(
            //       width: maxWidth,
            //       child: Card(
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(5),
            //         ),
            //         child: Stack(
            //           children: [
            //             Padding(
            //               padding: EdgeInsets.symmetric(horizontal: 20),
            //               child: _crearDropdown(context),
            //             ),
            //             showUsers(context), 
            //           ],
            //         ),
            //       ),
            //     ),
               
            //   ],
            // ),
          ),
        );
      },
    );
  }

  Widget showUsers(BuildContext context){
    return BlocBuilder<AdminCubit, AdminState>(builder: (context, state){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: state.postList.entries.map((e) {
            AuthUser user = state.userList[e.key] as AuthUser;
            return users(user, e.value,);
          }).toList());
      },
    );
  }

  Widget users(AuthUser user, estate){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Row(
        children: [
          Container(
              width: 50,
              height: 50,
              child: SvgPicture.string(
                  multiavatar(user.image),
              ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: Theme.of(context).textTheme.headline1,
                ),
                Text(
                  "${estate}",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



  List<DropdownMenuItem<String>> getOpcionesDropdown() {
    List<DropdownMenuItem<String>> lista = [];
    categories.forEach((option) {
      lista.add(DropdownMenuItem(
        child: Text(option),
        value: option,
      ));
    });
    return lista;
  }

  Widget _crearDropdown(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Theme.of(context).selectedRowColor,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<PostFilterOptions>(
            isExpanded: true,
            value: PostFilterOptions.MOST_POST,
            items: PostFilterOptions.values.map((options) {
              return DropdownMenuItem<PostFilterOptions>(
                value: options,
                child: Text(options.toString()),
              );
            }).toList(),
            onChanged: (PostFilterOptions? option) {
              BlocProvider.of<AdminCubit>(context).sortPostList(option);
            },
          ),
        ),
      ),
    );
  }
}
