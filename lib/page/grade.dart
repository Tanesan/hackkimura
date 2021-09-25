import 'package:flutter/material.dart';

class Grade extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.only(top: size.height * 0.08, right: size.width * 0.08,left:size.width * 0.08),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Text("ようこそ",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white60)),
              ),
              Container(
                width: double.infinity,
                child: Text("鈴木さん",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.08),
                child: Card(
                  child: Column(
                      children: [
                          Container(
                            // backgroundColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("1st", style: TextStyle(fontSize: 32, color: Colors.white)),
                            ),
                          )
                  ]
                ),
              ))
            ],
          ),
        ));
  }
}
