import 'package:flutter/material.dart';
import 'package:hackkimura/model/BarometerArgs.dart';
import 'package:hackkimura/model/UserData.dart';

class Training extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(ModalRoute.of(context)?.settings.arguments);
    var userData = ModalRoute.of(context)?.settings.arguments as UserData;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back)),
          title:
              Text(userData.chooseMode == "training" ? 'トレーニングモード' : '採点モード'),
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
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  Text("2Lペットボトルの上にスマホを固定し，測定開始ボタンを押してください。",
                  style: Theme.of(context).textTheme.headline5),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 180),
                      child: Container(
                        width: 300.0,
                        height: 300.0,
                        child: OutlinedButton(
                          child: Text('測定開始',
                              style: Theme.of(context).textTheme.headline2),
                          style: OutlinedButton.styleFrom(
                            primary: Colors.black,
                            shape: const StadiumBorder(),
                            side: const BorderSide(
                                color: Colors.green, width: 10.0),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/barometer',
                                arguments: BarometerArgs(
                                    userData: userData,
                                    mode: userData.chooseMode));
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
