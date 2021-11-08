import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/bloc/events_cubit.dart';
import 'package:geeksday/services/implementation/events_service.dart';
import 'package:geeksday/ui/home.dart';
import 'package:random_password_generator/random_password_generator.dart';

class EventsCreate extends StatefulWidget {
  static Widget create(BuildContext context) {
    return EventsCreate();
  }
  const EventsCreate({Key? key}) : super(key: key);

  @override
  _EventsCreateState createState() => _EventsCreateState();
}

class _EventsCreateState extends State<EventsCreate> {
  TextEditingController nameEvent = TextEditingController();
  TextEditingController codigoEvent = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EventsCubit(EventsService()),
      child: Scaffold(
        appBar: AppBar(  
          title: Text("Eventos"),
        ),
        body: bodyEventsCreate(),
        floatingActionButton: floatingActionButton(context),
      ),
    );
  }

  

  Widget bodyEventsCreate(){
    return Container();
  }

  Widget floatingActionButton(BuildContext context){
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        //Show modal new post
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) => Container(
            width: 800,
            child: createEvent(context),
          ),
        );
      },
      tooltip: "Agregar Evento",
    );
  }

  Widget createEvent(BuildContext context){
    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 700 ? 700 : width;
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
              eventsCreateForm(),
              buttonSave(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget eventsCreateForm(){
    return Form(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: "Nombre del Evento",
            ),
          ),
          TextFormField(
            controller: codigoEvent,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: codigoRandom,
                child: Icon(Icons.replay_circle_filled_outlined),
              ),
              hintText: "Generar Código",
            ),
          ),
        ],
      ),
    );
  }

  Widget buttonSave(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
      child:  ElevatedButton(
        onPressed: () {
         
        },
        style: ButtonStyle(
          padding:
              MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 20)),
        ),
        child: Text("Guardar"),
      ),
    );
  }

  void codigoRandom(){
    final codigo = RandomPasswordGenerator();
    String generateCodigo = codigo.randomPassword(
      letters: true,
      numbers: true,
      passwordLength: 16,
      uppercase: true,
      specialChar: false,
    );
    setState(() {
      codigoEvent.text = generateCodigo;
    });
  }
}