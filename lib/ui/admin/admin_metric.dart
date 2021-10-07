import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geeksday/bloc/admin_cubit.dart';
import 'package:geeksday/bloc/post_cubit.dart';
import 'package:geeksday/services/admin_service.dart';
import 'package:geeksday/services/implementation/admin_service.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:provider/provider.dart';

class AdminMetric extends StatefulWidget {
  const AdminMetric({Key? key}) : super(key: key);

  @override
  State<AdminMetric> createState() => _AdminMetricState();
}
List<String> categories = ['Más publicaciones', 'Más me gusta', 'Más comentarios', 'Mayor Puntuacion en los Quiz',];
String categorieDefault = "Más publicaciones";
var option = 0;
class _AdminMetricState extends State<AdminMetric> {
  @override
  Widget build(BuildContext context) {
      return BlocProvider(
        create: (_) => AdminCubit(AdminService()),
        child: Scaffold(
        appBar: AppBar(
          title: Text("Admin"),
        ),
        body: _body(context)
      ),
    );
  }

  Widget _body(BuildContext context){
    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 700 ? 700 : width;
    return BlocBuilder<AdminCubit, AdminState>(
      builder: (context, state){
        return Center(
        child: Container(
          width: maxWidth,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: ListView(
              children: [
                _crearDropdown(context),
                getUsers(),
              ],
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
          child: DropdownButton(
              isExpanded: true,
              value: categorieDefault,
              items: getOpcionesDropdown(),
              onChanged: (String? value) {
                setState(() {
                  categorieDefault = value!;
                  option = categories.indexOf(categorieDefault);
                  
                  BlocProvider.of<AdminCubit>(context).userList().then((value) => print(value));

                });
              },
              
          ),
        ),
      ),
    );
  }

  Widget getUsers(){
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: Column(
        children: [
          user(),
          user(),
          user(),
          user(),
          user(),
          user(),
          user(),
          user(),
          user(),
        ],
      ),
    );
  }

  Widget user(){
    return Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                            width: 50,
                            height: 50,
                            child: SvgPicture.string(
                                multiavatar("0000000000"),
                            ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "User name",
                                style: Theme.of(context).textTheme.headline1,
                              ),
                              Text(
                                "33",
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  
                ],
              ),
              const Divider(
                height: 25,
                thickness: 1,
              ),
           
          ],
        ),
      );
  }

}