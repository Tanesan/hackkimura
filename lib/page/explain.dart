import 'package:flutter/material.dart';
import 'package:hackkimura/model/BarometerArgs.dart';
import 'package:hackkimura/model/UserData.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Explain extends StatefulWidget {
  const Explain({Key? key}) : super(key: key);

  @override
  _ExplainState createState() => _ExplainState();
}

class _ExplainState extends State<Explain> {
  final introKey = GlobalKey<IntroductionScreenState>();

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    var userData = ModalRoute.of(context)?.settings.arguments as UserData;
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      // pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return Scaffold(
        body: IntroductionScreen(
      key: introKey,
      // globalBackgroundColor: Colors.white,
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {Navigator.of(context).pushNamed("/grade", arguments: userData);},
              child: Text('トップに戻る', style: Theme.of(context).textTheme.subtitle1),
            ),
          ),
        ),
      ),
      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          child: const Text(
            'さっそく遊ぶ！',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          onPressed: () => Navigator.of(context).pushNamed('/training',
              arguments: userData),
        ),
      ),
      pages: [
        PageViewModel(
          title: "ペットボトルだけ?",
          body:
          "そう。必要なものはペットボトルだけ。暇な時、トレーニングしたい時にさくっとプレイ",
          image: _buildImage('petbottle.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "ペットボトルの上にスマホ",
          body:
          "ペットボトルの上にスマホを乗せてください。乗せる位置はどこでもどうぞ",
          image: _buildImage('img2.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "上から押そう",
          body:
          "リズムに乗って上から押すだけ",
          image: _buildImage('img3.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "準備はいい？",
          bodyWidget:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
              Center(child: Text("さあ始めよう",
                  style: Theme.of(context).textTheme.headline3))
          ]),
          image: _buildImage('start.png'),
        ),
      ],
      onDone: () => Navigator.of(context).pushNamed('/training',
          arguments: userData), // You can override onSkip callback
      nextFlex: 1,
      //rtl: true, // Display as right-to-left
      next: const Icon(Icons.arrow_forward),
      done: const Text('Play', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(10.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Color(0x000006),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    ));
  }
}
