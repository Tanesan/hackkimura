import 'package:flutter/material.dart';
import 'package:hackkimura/model/BarometerArgs.dart';
import 'package:hackkimura/model/UserData.dart';

class Training extends StatefulWidget {
  const Training({Key? key}) : super(key: key);

  @override
  _TrainingState createState() => _TrainingState();
}

class _TrainingState extends State<Training> {
  double _currentSliderValue = 60;
  bool _active = true;
  void _changeSwitch(bool e) => setState(() => _active = e);

  @override
  Widget build(BuildContext context) {
    // print(ModalRoute.of(context)?.settings.arguments);
    final Size size = MediaQuery.of(context).size;
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
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  Text("2Lペットボトルの上にスマホを固定し，測定開始ボタンを押してください。",
                  style: Theme.of(context).textTheme.headline5),
                  userData.chooseMode == "training" ? Padding(
                    padding: EdgeInsets.only(right: 200, top: 20),
                    child: Text("トレーニング時間",
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.subtitle1),
                  ) : Container(),
                  userData.chooseMode == "training" ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(_currentSliderValue.round().toString(),
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.headline4),
                          Text("秒",
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.subtitle1)
                        ],
                      ),
                      Container(
                        width: size.width * 0.59,
                        child: Slider(
                          value: _currentSliderValue,
                          min: 0,
                          max: 1000,
                          divisions: 1000,
                          label: _currentSliderValue.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              _currentSliderValue = value;
                            });
                          },
                        ),
                      )
                    ],
                  ) : Container(),
                  userData.chooseMode == "training" ? Padding(
                    padding: EdgeInsets.only(right: 220, top: 16),
                    child: Text("メトロノーム",
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.subtitle1),
                  ) : Container(),
                  userData.chooseMode == "training" ? Padding(
                    padding: EdgeInsets.only(top: 8.0, left: 8.0),
                    child: Row(
                      children: [
                        Text(_active ? "ON " : "OFF",
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.headline4),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Switch(
                            value: _active,
                            activeColor: Colors.green,
                            onChanged: _changeSwitch,
                          ),
                        ),
                      ],
                    ),
                  ) : Container(),

                  Center(
                    child: Padding(
                      padding:  userData.chooseMode == "training" ? EdgeInsets.only(top: 50) : EdgeInsets.only(top: 180),
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
                                    time: _currentSliderValue,
                                    metro: _active,
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
