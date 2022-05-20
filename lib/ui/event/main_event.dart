import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/bloc/event/event_cubit.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/models/event.dart';
import 'package:geeksday/services/implementation/event_service.dart';
import 'package:geeksday/services/navigationService.dart';
import 'package:geeksday/ui/event/event_options.dart';
import 'package:geeksday/ui/event/form_create_event.dart';
import 'package:geeksday/ui/guategeeks/elements.dart';
import 'package:geeksday/ui/locator.dart';

class MainEvent extends StatelessWidget {
  const MainEvent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 700 ? 700 : width;
    AuthUser user = BlocProvider.of<AuthCubit>(context).getUser()!;
    return BlocProvider(
      create: (_) => EventCubit(EventService(), user),
      child: GuateGeeksScaffold(
        floatingActionButton: floatingButton(context),
        body: Builder(
          builder: (context) {
            BlocProvider.of<EventCubit>(context).getEventList();
            return Center(
              child: Container(
                margin: const EdgeInsets.only(top: 6),
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
      backgroundColor: Color(0xFF0E89AF),
      onPressed: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (_) {
            return FormCreateEvent();
          },
        );
      },
      tooltip: "Agregar Nuevo Evento",
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  Widget eventListBody(BuildContext context) {
    return BlocBuilder<EventCubit, EventState>(builder: (context, state) {
      if (!(state is EventLoaded)) {
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
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView(
          children: event.map((event) {
            return Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  margin:
                      EdgeInsets.only(top: 10, bottom: 37, left: 13, right: 13),
                  child: GestureDetector(
                    onTap: () {
                      locator<NavigationService>()
                          .navigateTo('/evento/' + event.id);
                    },
                    child: AspectRatio(
                      aspectRatio: 3 / 2,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              spreadRadius: 0,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 7), // changes position of shadow
                            ),
                          ],
                        ),
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            child: Image.network(
                              event.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                textImage(context, event),
                BlocProvider.of<AuthCubit>(context).getUser()!.isadmin
                    ? Positioned(
                        top: 20,
                        right: 20,
                        child: EventOptions(eventId: event.id))
                    : Container()
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget textImage(BuildContext context, event) {
    return GestureDetector(
      onTap: () {
        locator<NavigationService>().navigateTo('/evento/' + event.id);
      },
      child: Container(
        color: Color.fromRGBO(255, 255, 255, 0.5),
        height: 43,
        width: 133,
        child: Center(
          child: Text(
            'Click Aquí',
            style: TextStyle(
                color: Color(0xFF4A4A4A),
                fontSize: 18,
                fontWeight: FontWeight.w400,
                fontFamily: 'Biryani'),
          ),
        ),
      ),
    );
  }
}
