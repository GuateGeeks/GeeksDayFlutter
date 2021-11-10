import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/bloc/events_cubit.dart';
import 'package:geeksday/provider/theme_provider.dart';
import 'package:geeksday/ui/home.dart';
import 'package:provider/provider.dart';



class EventRegistration extends StatefulWidget {
  static Widget create(BuildContext context) {
    return EventRegistration();
  }
  EventRegistration({Key? key}) : super(key: key);

  @override
  _EventRegistrationState createState() => _EventRegistrationState();
}

class _EventRegistrationState extends State<EventRegistration> {
  @override
  void initState() {
    super.initState();
    cards.add(createCard());
  }
  List cards = [];  
  @override
  Widget build(BuildContext context) {
    
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          home: Scaffold(
            appBar: new AppBar(
              title: new Text("Eventos"),
            ),
            body: bodyEvents(context),
            floatingActionButton: floatinBottom(),
          ),
          
        );
    
  }

  Widget floatinBottom(){
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        //Show modal new post
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) => Container(
            width: 800,
            child: registerEvent(),
          ),
        );
      },
      tooltip: "Agregar Evento",
    );
  }

    Widget bodyEvents (context){
    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 500 ? 500 : width;
    return Center(
      child: Container(
        width: maxWidth,
        child: new GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 0.6,
          scrollDirection: Axis.vertical,
          children: cards.map((value) {
            return createCard();
          }).toList()
        ),
        ),
    );
  }

  
  Widget createCard(){
    final rnd = new Random();

    final r = rnd.nextInt(255);
    final g = rnd.nextInt(255);
    final b = rnd.nextInt(255);
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
      child: GestureDetector(
        onTap: (){
          Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return Home();
                },
              ),
            );
        },
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.home,
                  color: Colors.white,
                  size: 60.0,
                ),
                SizedBox(height: 50,),
                Center(
                  child: Text("Nombre del Evento",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            color: Color.fromRGBO(r, g, b, .8),
          ),
        ),
      ),
    );
  }

  Widget registerEvent(){
    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 500 ? 500 : width;
    return Center(
      child: Container(
        width: maxWidth,
        height: 900,
        constraints: BoxConstraints(
          maxHeight: double.infinity,
        ),
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: ListView(
                shrinkWrap: true,
                children: [
                  //Header Nuevo Post
                  Text("Agregar Evento",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //Input description Nuevo Post
                  codigo(context),
                  buttonSave(context),
                ],
              ),
            ),
      ),
    );
  }
  
  Widget codigo(BuildContext context) {
    return TextFormField(
      minLines: 1,
      maxLines: 4,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: "Description",
      ),
    );
  }

  Widget buttonSave(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
      child:  ElevatedButton(
        onPressed: () {
          var a  = BlocProvider.of<EventsCubit>(context);
          print(a);
          // setState(() => cards.add(createCard()));
        },
        style: ButtonStyle(
          padding:
              MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 20)),
        ),
        child: Text("Guardar"),
      ),
    );
  }
}