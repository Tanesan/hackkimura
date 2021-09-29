import 'package:flutter/material.dart';
import 'package:hackkimura/model/BarometerArgs.dart';
import 'package:hackkimura/model/UserData.dart';
import 'package:audioplayers/audioplayers.dart';

class Emergency extends StatefulWidget {
  const Emergency({Key? key}) : super(key: key);

  @override
  _EmergencyState createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {
  @override
  int _index = 0;
  final player = AudioCache();
  void _music(index) {
    if (index == 0){
      player.play('sound/周囲の安全.mp3');
    }else if (index == 1){
      player.play('sound/傷病者.mp3');
    }else if (index == 2){
      player.play('sound/大声で叫び応援.mp3');
    }else if (index == 3){
      player.play('sound/AED.mp3');
    }else if (index == 4){
      // player.play('sound/AED.mp3');
    }else if (index == 5){
      // player.play('sound/AED.mp3');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('緊急事態'),
        ),
        body: Stepper(
          currentStep: _index,
          onStepCancel: () {
            if (_index > 0) {
              setState(() {
                _index -= 1;
                _music(_index);
              });
            }
          },
          onStepContinue: () {
            if (_index >= 0 && _index <= 4) {
              setState(() {
                _index += 1;
                _music(_index);
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
                  ElevatedButton(
                    onPressed: onStepCancel,
                    child: const Text('戻る'),
                  ),
                  ElevatedButton(
                    onPressed: onStepContinue,
                    child: const Text('次へ'),
                  ),
                ],
              ),
            );
          },
          steps: <Step>[
            Step(
              title: const Text('周囲の安全の確認',
                  style: TextStyle(color: Colors.black, fontSize: 36)),
              content: Container(
                  alignment: Alignment.centerLeft,
                  child: const Text('車道の上であれば少し道脇に運んでください。')),
            ),
            const Step(
              title: Text('傷病者の反応、意識を確認'),
              content: Text('傷病者に近づき、反応（意識）を確認してください。コロナ禍においては、感染症対策のため、傷病者の顔と救助者の顔があまり近づきすぎないようにしてください。'),
            ),
            const Step(
              title: Text('大声で叫び応援を求む'),
              content: Text('傷病者に反応がなければ、大声で叫び応援を呼んでください。'),
            ),
            const Step(
              title: Text('119番通報およびAEDを用意'),
              content: Text('大声で応援を呼んでも誰も来ない場合は、自分で119番通報をします。AEDがあることが分かっている場合には、AEDを取りに行きます。119番に通報すると、通信指令員が電話を通じて、バイスタンダーが行うべきことを指導してくれます。'),
            ),
            const Step(
              title: Text('患者の呼吸を確認'),
              content: Text('胸と腹部の動きを見て、息があるか確認。10秒以内で確認してください。呼吸がないか、普段どおりではない場合（死戦期呼吸：しゃくりあげるように途切れ途切れの呼吸）は、心停止と判断してください。また、「普段どおりの呼吸」かどうか分からない場合も、胸骨圧迫を開始してください。'),
            ),
            const Step(
              title: Text('胸骨圧迫'),
              content: Text('呼吸がない、異常な呼吸（しゃくりあげるような不規則な呼吸）がある場合は直ちに行ってください。胸の真ん中付近で心臓マッサージを行ってください。コロナ禍においては、感染症対策のため、胸骨圧迫を開始する前に、ハンカチやタオルなどがあれば傷病者の鼻と口にそれをかぶせるようにしてください（マスクや衣服などで代用しても構いません）。'),
            )
          ],
        ));
  }}

