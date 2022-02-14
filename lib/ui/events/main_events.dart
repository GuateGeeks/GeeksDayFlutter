import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/bloc/events/show_events_cubit.dart';
import 'package:geeksday/models/events.dart';
import 'package:geeksday/services/implementation/events_service.dart';
import 'package:geeksday/services/navigationService.dart';
import 'package:geeksday/ui/events/form_create_event.dart';
import 'package:geeksday/ui/locator.dart';

class MainEvents extends StatelessWidget {
  static Widget create(BuildContext context) {
    return MainEvents();
  }

  const MainEvents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 700 ? 700 : width;
    ShowEventsCubit showEvents = ShowEventsCubit(EventsService());
    return BlocProvider.value(
      value: showEvents,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Eventos"),
        ),
        floatingActionButton: floatingButton(context, showEvents),
        body: Builder(builder: (context) {
          BlocProvider.of<ShowEventsCubit>(context).getEventsList();
          return Center(
            child: Container(
              width: maxWidth,
              child: mainEventsBody(context),
            ),
          );
        }),
      ),
    );
  }

  Widget floatingButton(BuildContext context, ShowEventsCubit showEvents){
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (_) => FormCreateEvent(showEvents: showEvents),
        );
      },
      tooltip: "Agregar Nuevo Evento",
      child: Icon(Icons.add),
    );
  }

  Widget mainEventsBody(context) {
    return BlocBuilder<ShowEventsCubit, ShowEventsState>(
      builder: (context, state) {
        if (!(state is EventsLoaded)) {
          return Center(child: CircularProgressIndicator());
        }
        final events = state.event;

        return RefreshIndicator(
          onRefresh: (){
            return   BlocProvider.of<ShowEventsCubit>(context).getEventsList();
          },
          child: (events.isEmpty) ? listEventsEmpty(context) : gridViewImage(events, context),
        );
      },
    );
  }

  Widget listEventsEmpty(BuildContext context) {
    return Center(
      child: Text("Aún no hay eventos",
          style: Theme.of(context).textTheme.headline4),
    );
  }

  Widget gridViewImage(List<Events> events, BuildContext context) {
    return GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 0.9,
        children: events.map((event) {
          var getImage =
              BlocProvider.of<ShowEventsCubit>(context).getImageURL(event.id);
          return StreamBuilder(
            stream: getImage.asStream(),
            builder: (context, snapshot) {
              //if the image is loading we show a circularProgressIndicator
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return GestureDetector(
                onTap: () {
                  locator<NavigationService>().navigateTo('/evento/'+'${event.id}');
                },
                child: Card(child: backgroundImage(snapshot, event)),
              );
            },
          );
        }).toList());
  }

  //widget to display the event image
  Widget backgroundImage(snapshot, event) {
    return Stack(
      children: [
        Image(
          height: double.infinity,
          image: NetworkImage(snapshot.data.toString()),
          fit: BoxFit.cover,
        ),
        nameEvent(event)
      ],
    );
  }

  //widget to show the name of the event, and put a transparent color to the image, so that it does not hide the name of the event
  Widget nameEvent(event) {
    return Container(
      padding: EdgeInsets.only(bottom: 10, left: 5.0, right: 5.0),
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.bottomCenter,
      color: Colors.black45,
      child: Text(
        event.name,
        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
