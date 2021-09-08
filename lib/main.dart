import 'dart:math';

import 'package:flutter/material.dart';
import 'package:what_type_is_your_shark/funFacts.dart';

import 'MyInformation.dart';
import 'SecondPage.dart';

void main() {
  runApp(MaterialApp(home: homePage()));
}

class homePage extends StatelessWidget {
  final rng = new Random();
  final facts = funFacts();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          color: Color(0xff37dbff),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(0.075 * height),
                child: Image(
                  image: AssetImage("assets/shark.png"),
                  height: 0.4 * height,
                  width: 0.4 * height,
                ),
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => classifyPage()));
                },
                label: Text(
                  "What Type is My Shark",
                  style: TextStyle(fontSize: 15, fontFamily: "FredokaOne"),
                ),
                icon: Icon(
                  Icons.waves,
                  color: Color(0xff000070),
                ),
              ),
              SizedBox(
                height: 0.05 * height,
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  showDialog<String>(
                    barrierColor: Color(0xff37dbff),
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      backgroundColor: Colors.white,
                      title: Center(
                          child: Text(
                        'Did you know?',
                        style:
                            TextStyle(fontSize: 25, fontFamily: "FredokaOne"),
                      )),
                      content: Text(
                        '${facts.listofFacts[rng.nextInt(facts.listofFacts.length)]}',
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            return Navigator.pop(context, 'OK');
                          },
                          child: Center(child: Text('OK')),
                        ),
                      ],
                    ),
                  );
                },
                label: Text(
                  "Random Fun Fact About Sharks",
                  style: TextStyle(fontSize: 15, fontFamily: "FredokaOne"),
                ),
                icon: Icon(
                  Icons.info_outline,
                  color: Color(0xff000070),
                ),
              ),
              SizedBox(
                height: 0.05 * height,
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  showDialog<String>(
                    barrierColor: Color(0xff37dbff),
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Center(
                        child: Text(
                          "ME",
                          style:
                              TextStyle(fontSize: 25, fontFamily: "FredokaOne"),
                        ),
                      ),
                      content: MyIndormation(),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            return Navigator.pop(context, 'Return');
                          },
                          child: Center(child: Text('Return')),
                        ),
                      ],
                    ),
                  );
                },
                label: Text(
                  "Information about Creator",
                  style: TextStyle(fontSize: 15, fontFamily: "FredokaOne"),
                ),
                icon: Icon(
                  Icons.quick_contacts_mail_outlined,
                  color: Color(0xff000070),
                ),
              ),
              SizedBox(
                height: 0.1 * height,
              ),
              Text("V1.1.0"),
            ],
          ),
        ),
      ),
    );
  }
}
