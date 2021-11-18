import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/bloc/events_cubit.dart';
import 'package:geeksday/bloc/feed_events_cubit.dart';
import 'package:geeksday/services/implementation/events_service.dart';
import 'package:geeksday/ui/home.dart';
import 'package:provider/provider.dart';

class AdminEvents extends StatelessWidget {
  final FeedEventsState events;
  const AdminEvents({Key? key, required this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Gridview is used to be able to show 3 events per row
    return BlocProvider(
      create: (_) => EventsCubit(EventsService()),
      child: provider(context),
    );
  }

  Widget provider(BuildContext context){
    return BlocBuilder<EventsCubit, EventsState>(builder: (context, state){ 
      var eventsCubit = Provider.of<EventsCubit>(context);
      return GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 0.9,
        //we go through the events and show them (the information comes from the events_create file)we go through the events and show them (the information comes from the events_create file)
        children: events.listEvents.map((event) {
          return StreamBuilder(
            stream: eventsCubit.getImageURL(event.id).asStream(),
            builder: (context, snapshot){
              //if the image is loading we show a circularProgressIndicator
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }
              return GestureDetector(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return Home();
                      },
                    ),
                  );
                },
                child: Card(
                  child: backgroundImage(snapshot, event)
                ),
              );
            },
          );
        }).toList(),
      );
    });
  }





  //widget to display the event image
  Widget backgroundImage(snapshot, event){
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
  Widget nameEvent(event){
    return Container(
      padding: EdgeInsets.only(bottom: 10, left: 5.0, right: 5.0),
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.bottomCenter,
      color: Colors.black45,
      child: Text(
        event.name, 
        style: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w400
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}