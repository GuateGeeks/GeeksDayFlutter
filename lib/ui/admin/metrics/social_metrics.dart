import 'package:flutter/material.dart';
import 'package:geeksday/ui/guategeeks/elements.dart';

class SocialMetrics extends StatelessWidget {
  const SocialMetrics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 700 ? 700 : width;
    return GuateGeeksScaffold(
        body: Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topCenter,
          radius: 0.9,
          colors: [
            Color(0xFF0E89AF),
            Color(0xFF4B3BAB),
          ],
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("Con mas likes"),
              Icon(Icons.arrow_drop_down_rounded)
            ]),
          ),
          Container(
            child: Row(children: [
              Expanded(
                child: Container(
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 5),
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(990),
                            ),
                            child: Icon(Icons.person, size: 90)),
                        SizedBox(
                          height: 10,
                        ),
                        Text("2"),
                        Text("Pedro Gomez"),
                        Text("9999"),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 5),
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(990),
                            ),
                            child: Icon(Icons.person, size: 120)),
                        SizedBox(
                          height: 10,
                        ),
                        Text("1"),
                        Text("Luis Gomez"),
                        Text("99999"),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 5),
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(990),
                            ),
                            child: Icon(Icons.person, size: 90)),
                        SizedBox(
                          height: 10,
                        ),
                        Text("3"),
                        Text("Pedro Gomez"),
                        Text("999"),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              width: maxWidth,
              padding: const EdgeInsets.fromLTRB(35, 20, 35, 5),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: Container(child: Text("4")),
                    title: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.red),
                          child: Icon(
                            Icons.person,
                            size: 50,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            height: 50,
                            child: Center(
                              child: Text(
                                "Alvin Estrada",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    trailing: Container(child: Text("4999")),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: Container(child: Text("4")),
                    title: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.red),
                          child: Icon(
                            Icons.person,
                            size: 50,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            height: 50,
                            child: Center(
                              child: Text(
                                "Alvin Estrada",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    trailing: Container(child: Text("4999")),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: Container(child: Text("4")),
                    title: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.red),
                          child: Icon(
                            Icons.person,
                            size: 50,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            height: 50,
                            child: Center(
                              child: Text(
                                "Alvin Estrada",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    trailing: Container(child: Text("4999")),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    ));
  }
}
