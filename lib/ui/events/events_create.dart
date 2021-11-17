
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/bloc/events_cubit.dart';
import 'package:geeksday/services/implementation/events_service.dart';
import 'package:geeksday/ui/events/user_events.dart';
import 'package:provider/provider.dart';

import 'admin_events.dart';
import 'form_create_event.dart';

class EventsCreate extends StatelessWidget {
  static Widget create(BuildContext context) {
    return EventsCreate();
  }
  const EventsCreate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Eventos"),
      ),
      body: BlocProvider(
        create: (_) => EventsCubit(EventsService()),
        child: bodyEventsCreate(context),
      ),
      floatingActionButton: floatingActionButton(context),
    );
  }
  
  Widget bodyEventsCreate(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 500 ? 500 : width;
    return BlocBuilder<EventsCubit, EventsState>(builder: (context, state){
      var isAdmin = Provider.of<AuthCubit>(context).getUser().isadmin;
        return Center(
          child: Container(  
            width: maxWidth,
            child: isAdmin 
              ? AdminEvents(events: state)
              : userEvents()   
       ),
     ); 
    });
  }
  
  Widget floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        //Show modal new post
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) => Container(
            width: 800,
            child: FormCreateEvent(),
          ),
        );
      },
      tooltip: "Agregar Evento",
    );
  }
}