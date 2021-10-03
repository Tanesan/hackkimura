import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:url_launcher/url_launcher.dart';

class Sos extends StatelessWidget {
  const Sos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text('緊急事態'),
        ),
        body: SingleChildScrollView(
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
                      // Navigator.of(context).pushNamed('/emergency');
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
              child: Text("-BPM110~120の曲-",
                  style: Theme.of(context).textTheme.headline5),
            ),
            Card(
                // color: Colors.grey[900],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: new InkWell(
                    onTap: () {
                      // Navigator.of(context).pushNamed('/emergency');
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(size.height * 0.05),
                          child: Container(
                            width: double.infinity,
                            child: Text("風たちの声　Radwimpsとか？マリーゴールドとか",
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
                      Navigator.of(context).pushNamed('/aed');
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
        )));
  }
}
