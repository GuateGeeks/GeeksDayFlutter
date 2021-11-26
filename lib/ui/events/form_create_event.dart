import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/bloc/events_cubit.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/services/implementation/events_service.dart';
import 'package:geeksday/ui/helpers/preview_images.dart';
import 'package:provider/provider.dart';

class FormCreateEvent extends StatefulWidget {
  FormCreateEvent({Key? key}) : super(key: key);

  @override
  _FormCreateEventState createState() => _FormCreateEventState();
  
}

class _FormCreateEventState extends State<FormCreateEvent> {
  File? uploadedImage;
  TextEditingController nameEvent = TextEditingController();
  TextEditingController codigoEvent = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AuthUser user = BlocProvider.of<AuthCubit>(context).getUser();
    return BlocProvider(
      create: (_) => EventsCubit(EventsService(), user),
      child: modalForm(),
    );
  }

  //Function that shows the modal when clicking on the floatingActionButton
  Widget modalForm(){
    bool isAdmin = Provider.of<AuthCubit>(context).getUser().isadmin;
    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 700 ? 700 : width;
    return BlocBuilder<EventsCubit, EventsState>(builder: (context, state){
      return Container(
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
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              "Agregar Evento",
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(
              height: 20.0,
            ),
            //image preview
            PreviewImage(uploadedImage: uploadedImage),
            isAdmin 
            //form to create a new event
              ? formCreateEvent(context)
            //form to register for an event
              : formRegistrationEvent(),
            //button to save in new event
            buttonSave(context),
          ],
        ),
      ); 
    });
  }
  //form to create a new event
  Widget formCreateEvent(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: nameEvent,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              suffixIcon: InkWell(
                onTap: () {
                  uploadImage(context);
                },
                child: Icon(Icons.image_search),
              ),
              hintText: "Nombre del Evento",
            ),
          ),
          TextFormField(
            controller: codigoEvent,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                child: Icon(Icons.replay_circle_filled_outlined),
                onTap: (){
                  //the ramdon code of is generating from the cubit
                  codigoEvent.text = BlocProvider.of<EventsCubit>(context).codigoRandom(); 
                },
              ),
              hintText: "Generar Código",
            ),
          ),
        ],
      ),
    );
  }

  Widget formRegistrationEvent(){
    return Form( 
      child: TextFormField(
        controller: codigoEvent,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: "Ingresar Código del Evento",
        ),
      ),
    );
  }

  //function that is responsible for sending the selected image to the cubit, and then that image is displayed in the modal by fetching it from the PreviewImage file
  uploadImage(BuildContext context){
    var uploadInput = FileUploadInputElement()..accept = 'image/*';
    uploadInput.click();
    uploadInput.onChange.listen(
      (event){
        final File file = uploadInput.files!.first;
        final reader = FileReader();
        reader.readAsDataUrl(file);
        reader.onLoadEnd.listen((event) {
          setState(() {
            uploadedImage = file;
          });
           BlocProvider.of<EventsCubit>(context).setImage(file);
        });
      }
    );
  }

  //button to save in new event
  Widget buttonSave(BuildContext context) {
    String userId = BlocProvider.of<AuthCubit>(context).getUserId();
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: codigoEvent,
        builder: (context, value, child){
          return ElevatedButton(
            onPressed: (value.text.isNotEmpty)
            //We check if the entry of the name of the event is empty, we register the user to an event, otherwise a new event is created
              ? (){
                if(nameEvent.text.isNotEmpty){
                  BlocProvider.of<EventsCubit>(context).createEvent(nameEvent.text, codigoEvent.text);
                }else{
                   BlocProvider.of<EventsCubit>(context).addUserToEvent(codigoEvent.text, userId);
                }
              }
              : null,
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 20)),
            ),
            child: Text("Guardar"),
          );
        },
      ),
    );
  }
}
