import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geeksday/bloc/admin_cubit.dart';
import 'package:geeksday/bloc/post_cubit.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/services/implementation/admin_service.dart';
import 'package:geeksday/services/implementation/auth_service.dart';
import 'package:geeksday/services/implementation/post_service.dart';
import 'package:geeksday/services/implementation/quiz_records_service.dart';
import 'package:multiavatar/multiavatar.dart';

class AdminMetric extends StatefulWidget {
  String idEvent;
  AdminMetric({Key? key, required this.idEvent}) : super(key: key);

  @override
  State<AdminMetric> createState() => _AdminMetricState();
}

class _AdminMetricState extends State<AdminMetric> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AdminCubit(AdminService(), PostService(), AuthService(), QuizRecordsService()),
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
            return users(context, user, e.value,);
          }).toList());
      },
    );
  }

  Widget users(BuildContext context, AuthUser user, estate){
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
                  estate.toString(),
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }





  Widget _crearDropdown(BuildContext context) {
    var optionsList = BlocProvider.of<AdminCubit>(context).optionsList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Theme.of(context).selectedRowColor,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            hint: Text("Seleccionar opcion"),
            isExpanded: true,
          
            items: optionsList.entries.map((option) {
              return DropdownMenuItem(
                value: option.key,
                child: Text(option.value.toString()),
              );
            }).toList(),

            onChanged: (optionKey){
              setState(() {                
                BlocProvider.of<AdminCubit>(context).sortPostList(optionKey, widget.idEvent);
              });
            },

          ),
        ),
      ),
    );
  }
}
