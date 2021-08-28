import 'package:flutter/material.dart';

class AddAnswers extends StatefulWidget {
  var answerList = <TextEditingController>[];
  var textFormField = <TextFormField>[];
  AddAnswers({Key? key}) : super(key: key);

  @override
  _AddAnswersState createState() => _AddAnswersState();
}

class _AddAnswersState extends State<AddAnswers> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.textFormField.length,
            itemBuilder: (BuildContext context, int index) {
              return widget.textFormField[index];
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              onPressed: () =>
                  setState(() => widget.textFormField.add(createTextField())),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.add),
                  Text("Agregar Respuesta"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  createTextField() {
    var nameController = TextEditingController();
    widget.answerList.add(nameController);
    return TextFormField(
      onSaved: (value) {},
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        suffixIcon: InkWell(
          onTap: () {
            // isCorrect = !isCorrect;
            // setState(() {});
          },
          child: Tooltip(
              message: "Respuesta Correcta",
              child: Icon(Icons.check_circle_rounded)
              // child: isCorrect
              //     ? Icon(
              //         Icons.check_circle_rounded,
              //         color: Colors.green,
              //       )
              //     : Icon(Icons.check_circle_rounded),
              ),
        ),
        hintText: "Respuesta",
        border: InputBorder.none,
        filled: true,
        fillColor: Color.fromRGBO(240, 240, 240, 1),
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
        focusedBorder: OutlineInputBorder(
          borderRadius: new BorderRadius.circular(8),
          borderSide: new BorderSide(
            color: Color.fromRGBO(240, 240, 240, 1),
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderRadius: new BorderRadius.circular(8),
          borderSide: new BorderSide(
            color: Color.fromRGBO(240, 240, 240, 1),
          ),
        ),
      ),
    );
  }
}
