import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:url_launcher/url_launcher.dart';

class Emergency extends StatefulWidget {
  const Emergency({Key? key}) : super(key: key);

  @override
  _EmergencyState createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {
  int _index = 0;
  AudioCache player = AudioCache();
  void _music(index) {
    if (index == 0){
      player.play('sound/around_check.mp3');
    }else if (index == 1){
      player.play('sound/effect_check.mp3');
    }else if (index == 2){
      player.play('sound/big_voice_help.mp3');
    }else if (index == 3){
      player.play('sound/AED.mp3');
    }else if (index == 4){
      player.play('sound/breath.mp3');
    }else if (index == 5){
      player.play('sound/kyokotuappaku.mp3');
    }
  }
  void _call119() async =>
      await canLaunch('tel:09071071210') ? await launch('tel:09071071210') : throw 'Could not launch';

  @override
  void initState() {
    super.initState();
    player.play('sound/around_check.mp3');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('緊急事態'),
        ),
        body: SingleChildScrollView(
        child: Column(
          children: [
        InkWell(
        child: Text("このページの情報のソースはこちらです。", style: Theme.of(context).textTheme.subtitle1),
          onTap: () async {
            if (await canLaunch("https://www.med.or.jp/99/cpr.html")) {
              await launch("https://www.med.or.jp/99/cpr.html");
            }
          },
        ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Stepper(
                  physics: ClampingScrollPhysics(),
                currentStep: _index,
                onStepCancel: () {
                  if (_index > 0) {
                    setState(() {
                      _index -= 1;
                      _music(_index);
                      // print(_index);
                    });
                  }
                },
                onStepContinue: () {
                  if (_index >= 0 && _index <= 4) {
                    setState(() {
                      _index += 1;
                      _music(_index);
                      // print(_index);
                    });
                  }
                },
                onStepTapped: (int index) {
                  setState(() {
                    _index = index;
                  });
                },
                controlsBuilder: (BuildContext context,
                    {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
                  return Container(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _index != 0 ? (Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: ElevatedButton(
                            onPressed: onStepCancel,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0, right: 8.0, bottom: 8.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4, right: 4),
                                    child: Icon(Icons.undo),
                                  ),
                                  Text('戻る', style: TextStyle(fontSize: 24)),
                                ],
                              ),
                            ),
                          ),
                        )):(Text("")),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: ElevatedButton(
                            onPressed: onStepContinue,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0, right: 8.0, bottom: 8.0),
                              child: Row(
                                children: [
                                  Text('進む', style: TextStyle(fontSize: 24)),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4, right: 4),
                                    child: Icon(Icons.redo),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                steps: <Step>[
                  Step(
                    title: _index == 0 ? Text('周囲の安全の確認',
                        style: TextStyle(color: Colors.blue, fontSize: 36)) : Text('周囲の安全の確認'),
                    isActive: _index >= 0,
                    content: Container(
                        alignment: Alignment.centerLeft,
                        child: Text('車道の上であれば少し道脇に運んでください。', style: TextStyle(fontSize: 24))),
                  ),
                  Step(
                    title: _index == 1 ? Text('傷病者の反応、意識を確認',
                        style: TextStyle(color: Colors.blue, fontSize: 36)) : Text('傷病者の反応'),
                    content: SingleChildScrollView(
                      child:Text('傷病者に近づき、反応（意識）を確認してください。コロナ禍においては、感染症対策のため、傷病者の顔と救助者の顔があまり近づきすぎないようにしてください。', style: TextStyle(fontSize: 24))),
                    isActive: _index >= 1,
                  ),
                  Step(
                    title:  _index == 2 ? Text('大声で叫び応援を求む',
                       style: TextStyle(color: Colors.blue, fontSize: 36)) : Text('大声で叫び応援を求む'),
                    content: SingleChildScrollView(
                      child:Text('傷病者に反応がなければ、大声で叫び応援を呼んでください。', style: TextStyle(fontSize: 24))),
                    isActive: _index >= 2,
                  ),
                  Step(
                    title: _index == 3 ? Text('119番通報およびAEDを用意', style: TextStyle(color: Colors.blue, fontSize: 36)) : Text('119番通報およびAEDを用意'),
                    content: Container(child:SingleChildScrollView(
                        child:
                        Column(
                      children: [
                        Text('大声で応援を呼んでも誰も来ない場合は、自分で119番通報をします。AEDがあることが分かっている場合には、AEDを取りに行きます。119番に通報すると、通信指令員が電話を通じて、バイスタンダーが行うべきことを指導してくれます。', style: TextStyle(fontSize: 24)),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: ElevatedButton(
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                            onPressed: _call119,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0, right: 8.0, bottom: 8.0),
                              child: Row(
                                children: [
                                  Center(child: Text('119番通報をする', style: TextStyle(fontSize: 24))),
                                ],
                              ),
                            ),
                          ),
                        ),],
                    ))),
                    isActive: _index >= 3,
                  ), Step(
                    title: _index == 4 ? Text('患者の呼吸を確認', style: TextStyle(color: Colors.blue, fontSize: 36)) : Text('患者の呼吸を確認'),
                    content: SingleChildScrollView(
                      child:Text('胸と腹部の動きを見て、息があるか確認。10秒以内で確認してください。呼吸がないか、普段どおりではない場合（死戦期呼吸：しゃくりあげるように途切れ途切れの呼吸）は、心停止と判断してください。また、「普段どおりの呼吸」かどうか分からない場合も、胸骨圧迫を開始してください。', style: TextStyle(fontSize: 24))),
                    isActive: _index >= 4,
                  ),
                  Step(
                    title: _index == 5 ? Text('胸骨圧迫', style: TextStyle(color: Colors.blue, fontSize: 36)) : Text('胸骨圧迫'),
                    content: SingleChildScrollView(
                        child:Text('呼吸がない、異常な呼吸（しゃくりあげるような不規則な呼吸）がある場合は直ちに行ってください。胸の真ん中付近で心臓マッサージを行ってください。コロナ禍においては、感染症対策のため、胸骨圧迫を開始する前に、ハンカチやタオルなどがあれば傷病者の鼻と口にそれをかぶせるようにしてください（マスクや衣服などで代用しても構いません）。', style: TextStyle(fontSize: 24))),
                    isActive: _index >= 5,
                  )
                ],
            ),
              )),
          ],
        )));
  }}

