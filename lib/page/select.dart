import 'package:flutter/material.dart';
import 'package:hackkimura/model/UserData.dart';

class Select extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var userData = ModalRoute.of(context)?.settings.arguments as UserData;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(onPressed: () {Navigator.of(context).pop();}, icon: Icon(Icons.arrow_back)),
        title: Text('胸骨圧迫トレーニング'),
        // 右側のアイコン一覧
        /*
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
         */
      ),
      body:   Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 250),
              child: Center(
                child: Container(
                  width: 300.0,
                  height: 50.0,
                  child: OutlinedButton(
                    child: const Text('トレーニングモード', style: TextStyle(fontWeight: FontWeight.bold)),
                    style: OutlinedButton.styleFrom(
                      primary: Colors.white,
                      shape: const StadiumBorder(),
                      side: const BorderSide(color: Colors.green),
                    ),
                    onPressed: () {Navigator.of(context).pushNamed('/training', arguments: userData);},
                  ),

                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: Center(
                child: Container(
                  width: 300.0,
                  height: 50.0,
                  child: OutlinedButton(
                    child: const Text('採点モード', style: TextStyle(fontWeight: FontWeight.bold)),
                    style: OutlinedButton.styleFrom(
                      primary: Colors.white,
                      shape: const StadiumBorder(),
                      side: const BorderSide(color: Colors.green),
                    ),
                    onPressed: () {Navigator.of(context).pushNamed('/battle', arguments: userData);},
                  ),

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}