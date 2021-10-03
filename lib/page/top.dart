import 'package:flutter/material.dart';
import 'package:hackkimura/model/UserData.dart';
import 'package:flutter/services.dart';
import 'package:games_services/games_services.dart';

class Top extends StatefulWidget {
  @override
  _TopState createState() => _TopState();
}

class _TopState extends State<Top> with SingleTickerProviderStateMixin {
  UserData userData = UserData();
  final ScrollController controller = ScrollController();

  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 180).animate(animationController);
    animation.addListener(() {
      setState(() {});
    });
    final result = GamesServices.signIn();
    print(result);
    super.initState();
  }

  @override
  void dispose() {
    // if (animationController != null) {
    animationController.dispose();
    // }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        // backgroundColor: Colors.black,
        body: Column(
      children: [
        InkWell(
            onTap: () {
              if (animation.value == 0) {
                animationController.forward(from: 0.0);
              } else {
                animationController.reverse();
              }
            },
            child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('images/AED.jpg'),
                  fit: BoxFit.cover,
                )),
                child: Padding(
                  padding: EdgeInsets.only(top: size.height * 0.4 - 72),
                  child: Center(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: size.width * 0.05),
                              child: Text('胸骨圧迫',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 48,
                                      color: Colors.white)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: size.width * 0.01),
                              child: Icon(Icons.play_circle_fill,
                                  color: Colors.white, size: 36.0),
                            ),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: size.width * 0.05,
                                bottom: size.height * 0.05),
                            child: Text('トレーニングモード',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ))),
        Container(
            width: double.infinity,
            height: animation.value * 1.3,
            child: animation.value > 40
                ? SingleChildScrollView(
                    child: Column(children: [
                    Padding(
                        padding: EdgeInsets.only(
                            top: size.width * 0.01,
                            right: size.width * 0.1,
                            left: size.width * 0.1),
                        child: FocusScope(
                            child: Focus(
                                onFocusChange: (focus) => controller.animateTo(
                                      size.height * 0.3,
                                      curve: Curves.easeOut,
                                      duration:
                                          const Duration(milliseconds: 300),
                                    ),
                                child: Center(
                                  child: TextField(
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'^[0-9a-zA-Z@_.-]+$')),
                                      ],
                                      maxLength: 20,
                                      maxLines: 1,
                                      obscureText: false,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      decoration: InputDecoration(
                                        labelStyle:
                                            TextStyle(color: Colors.green),
                                        enabledBorder: OutlineInputBorder(
                                          // width: 0.0 produces a thin "hairline" border
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          borderSide: const BorderSide(
                                              color: Colors.green, width: 1.0),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          borderSide: BorderSide(
                                            color: Colors.green,
                                          ),
                                        ),
                                        labelText: 'ユーザー名'
                                      ),
                                      onChanged: (text) {
                                        userData.classCode = text;
                                      }),
                                )))),
                    Padding(
                        padding: EdgeInsets.only(
                            top: size.width * 0.01,
                            right: size.width * 0.1,
                            left: size.width * 0.1),
                        child: FocusScope(
                            child: Focus(
                                onFocusChange: (focus) => controller.animateTo(
                                      size.height * 0.3,
                                      curve: Curves.easeOut,
                                      duration:
                                          const Duration(milliseconds: 300),
                                    ),
                                child: Center(
                                  child: TextField(
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'^[0-9a-zA-Z@_.-]+$')),
                                      ],
                                      maxLength: 20,
                                      maxLines: 1,
                                      obscureText: false,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      decoration: InputDecoration(
                                        labelStyle:
                                            TextStyle(color: Colors.green),
                                        enabledBorder: OutlineInputBorder(
                                          // width: 0.0 produces a thin "hairline" border
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          borderSide: const BorderSide(
                                              color: Colors.green, width: 1.0),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          borderSide: BorderSide(
                                            color: Colors.green,
                                          ),
                                        ),
                                        labelText: 'クラスID(指定がない場合は新規作成)',
                                      ),
                                      onChanged: (text) {
                                        userData.classCode = text;
                                      }),
                                )))),
                    Center(
                        child: Container(
                            width: 200.0,
                            height: 50.0,
                            child: OutlinedButton(
                              child: const Text('スタート',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              style: OutlinedButton.styleFrom(
                                primary: Colors.green,
                                shape: const StadiumBorder(),
                                side: const BorderSide(color: Colors.green),
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed('/mypage', arguments: userData);
                              },
                            ))),
                    /*
                            Padding(
                              padding: EdgeInsets.only(
                                  top: size.width * 0.01,
                                  bottom: size.height * 0.01),
                              child: Center(
                                  child: Container(
                                width: 200.0,
                                height: 50.0,
                                child: OutlinedButton(
                                    child: const Text('LINEでログイン',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    style: OutlinedButton.styleFrom(
                                      shape: const StadiumBorder(),
                                      side:
                                          const BorderSide(color: Colors.green),
                                    ),
                                    onPressed: _signIn),
                              )),
                            ),
                          SizedBox(height: 5),
                            Center(
                              child: Container(
                                  width: 200.0,
                                  height: 50.0,
                                  child: TextButton(
                                      child: const Text('ログインしないで続ける',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      style: TextButton.styleFrom(
                                        // primary: Colors.white,
                                      ),
                                      onPressed: () {
                                        userData.name = "Guest";
                                        Navigator.of(context).pushNamed(
                                            "/grade",
                                            arguments: userData);
                                      })),
                            ),

                             */
                  ]))
                : null),
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed('/sos');
          },
          child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('images/emergency.jpg'),
                fit: BoxFit.cover,
              )),
              child: Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.4 - 72 - animation.value * 1),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.only(left: size.width * 0.1),
                          child: Row(
                            children: [
                              Text('緊急事態',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 48 - animation.value * 0.1,
                                      fontWeight: FontWeight.bold,
                                      color: animation.value == 0
                                          ? Colors.red
                                          : Colors.white)),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: size.width * 0.01),
                                child: Icon(Icons.play_circle_fill,
                                    color: animation.value == 0
                                        ? Colors.red
                                        : Colors.white,
                                    size: 36.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: size.width * 0.1,
                              bottom: size.width * 0.05),
                          child: Text('Emergency',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 36 - animation.value * 0.1,
                                  fontWeight: FontWeight.bold,
                                  color: animation.value == 0
                                      ? Colors.red
                                      : Colors.white)),
                        ),
                      )
                    ],
                  ),
                ),
              )),
        )
      ],
    ));
  }
}
