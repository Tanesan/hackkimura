import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart' hide PlayerState;
import 'package:hackkimura/function/audio.dart';
import 'package:flutter_playout/player_state.dart';



class Sos extends StatefulWidget {
  @override
  _SosState createState() => _SosState();
}

class _SosState extends State<Sos> {
  AudioCache player = AudioCache();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text('緊急事態'),
        ),
        body: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
                child: Column(
              children: [
                Card(
                    // color: Colors.grey[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: new InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('/emergency');
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(size.height * 0.05),
                              child: Container(
                                width: double.infinity,
                                child: Text("救急蘇生法の流れを確認",
                                    style: Theme.of(context).textTheme.headline5),
                              ),
                            ),
                          ],
                        ))),
                Padding(
                  padding: EdgeInsets.only(top: 24, bottom: 8),
                  child: Text("-音声-", style: Theme.of(context).textTheme.headline5),
                ),
                Card(
                    // color: Colors.grey[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: new InkWell(
                        onTap: () {
                          player.play('sound/sos.mp3');
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(size.height * 0.05),
                              child: Container(
                                width: double.infinity,
                                child: Text("傷病者がいます。119番とAEDお願いします。",
                                    style: Theme.of(context).textTheme.headline5),
                              ),
                            ),
                          ],
                        ))),
                Padding(
                  padding: EdgeInsets.only(top: 24, bottom: 8),
                  child:
                      Text("近くのAED", style: Theme.of(context).textTheme.headline5),
                ),
                Card(
                  // color: Colors.grey[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: new InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('/aed')
                          // showDialog<String>(
                          //   context: context,
                          //   builder: (BuildContext context) => AlertDialog(
                          //     // title: const Text('AlertDialog Title'),
                          //     content: const Text('このアプリでは現在地周辺のAEDの場所の取得を可能にするために、現在地のデータが収集されます。アプリを閉じているときや、使用していないときにも収集されます'),
                          //     actions: <Widget>[
                          //       TextButton(
                          //         onPressed: () => Navigator.of(context).pushNamed('/aed'),
                          //         child: const Text('了解'),
                          //       ),
                          //     ],
                          //   ),
                          // );
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(size.height * 0.05),
                              child: Container(
                                width: double.infinity,
                                child: Text("近くのAEDを探す",
                                    style: Theme.of(context).textTheme.headline5),
                              ),
                            ),
                          ],
                        ))),
                ],
            ),
            )),
            AudioPlayout(
              desiredState: PlayerState.PLAYING,
            )],
        )
    );
  }
}
