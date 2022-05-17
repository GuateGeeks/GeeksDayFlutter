import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/bloc/event/event_cubit.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/services/implementation/event_service.dart';
import 'package:geeksday/ui/helpers/preview_images.dart';
import 'package:provider/provider.dart';

class FormCreateEvent extends StatefulWidget {
  FormCreateEvent({Key? key}) : super(key: key);

  @override
  State<FormCreateEvent> createState() => _FormCreateEventState();
}

class _FormCreateEventState extends State<FormCreateEvent> {
  TextEditingController nameEvent = TextEditingController();
  TextEditingController codigoEvent = TextEditingController();
  File? uploadedImage;
  @override
  Widget build(BuildContext context) {
    AuthUser user = BlocProvider.of<AuthCubit>(context).getUser()!;
    return BlocProvider(
      create: (_) => EventCubit(EventService(), user),
      child: bodyFormCreateEvent(),
    );
  }

  Widget bodyFormCreateEvent() {
    return BlocListener<EventCubit, EventState>(
      listener: (context, state) {
        if (state is EventAdded) {
          Navigator.pop(context);
          return;
        }
      },
      child: modalForm(),
    );
  }

  //Function that shows the modal when clicking on the floatingActionButton
  Widget modalForm() {
    bool isAdmin = Provider.of<AuthCubit>(context).getUser()!.isadmin;
    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 700 ? 700 : width;
    return BlocBuilder<EventCubit, EventState>(builder: (context, state) {
      return Center(
        child: Container(
          width: maxWidth,
          height: 500,
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
                  ? formCreateEvent(context, maxWidth)
                  //form to register for an event
                  : formRegistrationEvent(),
              //button to save in new event
              buttonSave(context, state),
            ],
          ),
        ),
      );
    });
  }

  //form to create a new event
  Widget formCreateEvent(BuildContext context, maxWidth) {
    return Container(
      width: maxWidth,
      child: Form(
        child: Column(
          children: [
            TextFormField(
              autofocus: true,
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
                  onTap: () {
                    //the ramdon code of is generating from the cubit
                    codigoEvent.text =
                        BlocProvider.of<EventCubit>(context).codigoRandom();
                  },
                ),
                hintText: "Generar Código",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget formRegistrationEvent() {
    return Form(
      child: TextFormField(
        autofocus: true,
        controller: codigoEvent,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: "Ingresar Código del Evento",
        ),
      ),
    );
  }

  //button to save in new event
  Widget buttonSave(BuildContext context, EventState state) {
    AuthUser user = BlocProvider.of<AuthCubit>(context).getUser()!;
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: codigoEvent,
        builder: (context, value, child) {
          return ElevatedButton(
            //We validate that the event has an image, otherwise the save button is not enabled
            onPressed: user.isadmin && uploadedImage == null
                ? null
                : () {
                    saveEvent(context, value, user.uid);
                  },
            style: ButtonStyle(
              padding:
                  MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 20)),
            ),
            child: (state is AddingEvent)
                ? CircularProgressIndicator(color: Colors.white)
                : Text("Guardar"),
          );
        },
      ),
    );
  }

  //Function to save an event
  void saveEvent(BuildContext context, TextEditingValue value, String userId) {
    //If the event name is empty, we validate that the user joins an event. If the event name  is not empty, we create an event
    if (value.text.isNotEmpty) {
      if (nameEvent.text.isNotEmpty) {
        BlocProvider.of<EventCubit>(context)
            .createEvent(nameEvent.text, codigoEvent.text);
      } else {
        BlocProvider.of<EventCubit>(context).registerInEvent(codigoEvent.text);
      }
    }
  }

  //function that is responsible for sending the selected image to the cubit, and then that image is displayed in the modal by fetching it from the PreviewImage file
  uploadImage(BuildContext context) {
    var uploadInput = FileUploadInputElement()..accept = 'image/*';
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      final File file = uploadInput.files!.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) {
        setState(() {
          uploadedImage = file;
        });
        BlocProvider.of<EventCubit>(context).setImage(file);
      });
    });
  }
}
