import 'package:flutter/material.dart';

class Grade extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.only(top: size.height * 0.08 , right: size.width * 0.08,left:size.width * 0.08),
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
                padding: EdgeInsets.only(top: size.height * 0.04),
                child: Row(
                  children: [
                    Card(
                        color: Colors.lightBlueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                            children: [
                                Container(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(size.height * 0.03),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 40,
                                              child: Row(
                                                children: [
                                                  Text("1", style: TextStyle(fontSize: 40,fontWeight: FontWeight.w600, color: Colors.white)),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 4.0, top: 13.0),
                                                    child: Text("位", style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal, color: Colors.white)),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Text("in class", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.white60)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                        ]
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: size.width * 0.05),
                        child: Card(
                          color: Colors.grey[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                              children: [
                                Container(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(size.height * 0.03),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 87,
                                              child: Row(
                                                children: [
                                                  Text("136", style: TextStyle(fontSize: 40,fontWeight: FontWeight.w600, color: Colors.white)),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 4.0, top: 13.0),
                                                    child: Text("p", style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal, color: Colors.white)),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Text("best score", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.white60)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ]
                          ),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.width * 0.9),
                child: Center(
                  child: Container(
                    width: 200.0,
                    height: 50.0,
                    child: OutlinedButton(
                      child: const Text('スタート', style: TextStyle(fontWeight: FontWeight.bold)),
                      style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                        shape: const StadiumBorder(),
                        side: const BorderSide(color: Colors.green),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed('/select');
                      },
                    ),
                  ),
                ),
              ),],
          ),
        ));
  }
}
