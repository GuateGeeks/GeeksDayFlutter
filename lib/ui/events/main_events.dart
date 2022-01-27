import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/bloc/events/show_events_cubit.dart';
import 'package:geeksday/models/events.dart';
import 'package:geeksday/services/implementation/events_service.dart';
import 'package:geeksday/ui/events/form_create_event.dart';
import 'package:geeksday/ui/home.dart';
import 'package:geeksday/ui/setting.dart';

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
            icon: Icon(Icons.menu),
          ),
        ],
        ),
        floatingActionButton: floatingButton(context, showEvents),
        body: Builder(builder: (context) {
          BlocProvider.of<ShowEventsCubit>(context).getEventsList();
          return Center(
            child: Container(
              margin: EdgeInsets.only(top: 5),
              width: maxWidth,
              child: mainEventsBody(context),
            ),
          );
        }),
      ),
    );
  }

  Widget floatingButton(BuildContext context, ShowEventsCubit showEvents) {
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
          onRefresh: () {
            return BlocProvider.of<ShowEventsCubit>(context).getEventsList();
          },
          child: (events.isEmpty)
              ? listEventsEmpty(context)
              : listEvents(events, context),
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

  Widget listEvents(List<Events> events, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView(
          children: events.map((event) {
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
