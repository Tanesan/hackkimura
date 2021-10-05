import 'package:flutter/material.dart';
import 'package:hackkimura/model/BarometerArgs.dart';
import 'package:hackkimura/model/UserData.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class Howtoplay extends StatefulWidget {
  const Howtoplay({Key? key}) : super(key: key);

  @override
  _HowtoplayState createState() => _HowtoplayState();
}

class _HowtoplayState extends State<Howtoplay> {
  final introKey = GlobalKey<IntroductionScreenState>();

  // Widget _buildFullscrenImage() {
  //   return Image.asset(
  //     'assets/fullscreen.jpg',
  //     fit: BoxFit.cover,
  //     height: double.infinity,
  //     width: double.infinity,
  //     alignment: Alignment.center,
  //   );
  // }

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
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return Scaffold(
        body: IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
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
          title: "寄り添おう",
          body:
          "仰向けに寝かせた傷病者の胸の横にひざまずく。",
          image: _buildImage('petbottle.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "傷病者の胸の真ん中とあなたは90°",
          body:
          "胸骨の下半分（胸の真ん中が目安）に片方の手のひら基部（手首に近い部分）をあて、もう片方の手を重ねて組む。垂直に体重が加わるように腕を真っすぐ伸ばし、組んだ手の真上に肩がくるような姿勢に。",
          image: _buildImage('img2.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "上から押そう",
          bodyWidget:Column(
            children: [
              Text("手のひら基部だけに力を加え、傷病者の胸が約５cm沈み込むように圧迫する。小児は胸の厚さの約１／３沈み込むくらいを目安に。体が小さく、両手で強すぎる場合は片手で行う。"),
            ],
          ),
          image: _buildImage('img3.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "疲れたら代わろう",
          bodyWidget:Column(
            children: [
              Text("助者が疲労して、圧迫の深さ、テンポ、解除（胸の戻り）が不十分になるのを防ぐため、周りに協力してくれる人がいたら、１～２分ごとを目安に胸骨圧迫の役割を交代しよう。"),
            ],
          ),
          image: _buildImage('img3.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "わかった？",
          bodyWidget:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
              Center(
                child: InkWell(
                    child: Text("この情報は「社団法人　北海道医師会」応急手当WEBをもとに作成しました。出典元サイトはこちらをクリックしてください。", style: Theme.of(context).textTheme.subtitle1),
                    onTap: () async {
                      if (await canLaunch("http://www.hokkaido.med.or.jp/firstaid/")) {
                        await launch("http://www.hokkaido.med.or.jp/firstaid/");
                      }
                    },
                  ),
              ),
          ]),
          image: _buildImage('start.png'),
        ),
      ],
      onDone: () => Navigator.of(context).pushNamed('/training',
          arguments: userData), // You can override onSkip callback
      nextFlex: 0,
      //rtl: true, // Display as right-to-left
      next: const Icon(Icons.arrow_forward),
      done: const Text('遊ぶ', style: TextStyle(fontWeight: FontWeight.w600)),
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
