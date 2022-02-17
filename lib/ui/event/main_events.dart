import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/bloc/event/event_cubit.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/models/event.dart';
import 'package:geeksday/services/implementation/event_service.dart';
import 'package:geeksday/ui/event/form_create_event.dart';
import 'package:geeksday/ui/home.dart';
import 'package:geeksday/ui/setting.dart';

class MainEvent extends StatelessWidget {
  static Widget create(BuildContext context) {
    return MainEvent();
  }

  const MainEvent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 700 ? 700 : width;
    AuthUser user = BlocProvider.of<AuthCubit>(context).getUser();
    return BlocProvider(
      create: (_) => EventCubit(EventService(), user),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Image.asset(
            'assets/guateGeeksLogo.png',
            width: 150,
            fit: BoxFit.cover,
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return Settings();
                    },
                  ),
                );
              },
              icon: Icon(
                Icons.menu,
                color: Color(0xFF0E89AF),
                size: 30,
              ),
            ),
          ],
        ),
        floatingActionButton: floatingButton(context),
        body: Builder(  
          builder: (context){
            BlocProvider.of<EventCubit>(context).getEventList();
            return Center(
              child: Container(
                 margin: EdgeInsets.only(top: 5),
                 width: maxWidth,
                 child: eventListBody(context),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget floatingButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (_) {return FormCreateEvent();},
        );
      },
      tooltip: "Agregar Nuevo Evento",
      child: Icon(Icons.add),
    );
  }

  Widget eventListBody(BuildContext context){
    return BlocBuilder<EventCubit, EventState>(builder: (context, state){
      if(!(state is EventLoaded)){
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      final events = state.events;
      return RefreshIndicator(
        onRefresh: () => BlocProvider.of<EventCubit>(context).getEventList(),
        child: events.isEmpty
              ? listEventEmpty(context)
              : listEvent(events, context),
      );



    });
  }
    Widget listEventEmpty(BuildContext context) {
    return Center(
      child: Text("Aún no hay eventos",
          style: Theme.of(context).textTheme.headline4),
    );
  }

    Widget listEvent(List<Event> event, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView(
          children: event.map((event) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return Home(event: event);
                    },
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Image.network(
                  event.image,
                  width: double.infinity,
                  height: 350,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}




