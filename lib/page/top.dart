import 'package:flutter/material.dart';
import 'package:hackkimura/model/UserData.dart';
import 'package:flutter/services.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';

class Top extends StatefulWidget {
  @override
  _TopState createState() => _TopState();
}

class _TopState extends State<Top> with SingleTickerProviderStateMixin {
  UserData userData = UserData();
  final ScrollController controller = ScrollController();

  UserProfile? _userProfile;
  bool _isOnlyWebLogin = false;

  final Set<String> _selectedScopes = Set.from(['profile']);

  void _signIn() async {
    try {
      /// requestCode is for Android platform only, use another unique value in your application.
      final loginOption =
          LoginOption(_isOnlyWebLogin, 'normal', requestCode: 8192);
      final result = await LineSDK.instance
          .login(scopes: _selectedScopes.toList(), option: loginOption);
      final accessToken = await LineSDK.instance.currentAccessToken;

      final idToken = result.accessToken.idToken;
//      final userEmail = (idToken != null) ? idToken['email'] : null;

      _userProfile = result.userProfile;
      userData.name = _userProfile!.displayName;
      userData.id = _userProfile!.userId;
      print(userData.id);
//      userData.mail = userEmail;
//      userData.accessToken = accessToken;
      Navigator.of(context).pushNamed('/grade', arguments: userData);
    } on PlatformException catch (e) {
      _showDialog(context, e.toString());
    }
  }

  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 180).animate(animationController);
    animation.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    if (animationController != null) {
      animationController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
              children: [
                InkWell(
                    onTap: () {
                      if (animation.value == 0) {
                        animationController.forward(from: 0.0);
                      }else{
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
                          padding:
                              EdgeInsets.only(top: size.height * 0.4 - 72),
                          child: Center(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: size.width * 0.05),
                                      child: Text('胸骨圧迫',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 48,
                                              color: Colors.white)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: size.width * 0.01),
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
                        child: Column(
                        children:[
                            /*
                            Padding(
                              padding: EdgeInsets.only(
                                  top: size.width * 0.01,
                                  right: size.width * 0.1,
                                  left: size.width * 0.1),
                              child: Center(
                                child: FocusScope(
                                  child: Focus(
                                    onFocusChange: (focus) =>
                                        controller.animateTo(
                                      size.height * 0.3,
                                      curve: Curves.easeOut,
                                      duration:
                                          const Duration(milliseconds: 300),
                                    ),
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
                                              TextStyle(color: Colors.white),
                                          enabledBorder: OutlineInputBorder(
                                            // width: 0.0 produces a thin "hairline" border
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            borderSide: const BorderSide(
                                                color: Colors.green,
                                                width: 1.0),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            borderSide: BorderSide(
                                              color: Colors.green,
                                            ),
                                          ),
                                          labelText: 'ユーザー名',
                                        ),
                                        onChanged: (text) {
                                          userData.name = text;
                                        }),
                                  ),
                                ),
                              ),
                            ),
                               */
                            Padding(
                                padding: EdgeInsets.only(
                                    top: size.width * 0.01,
                                    right: size.width * 0.1,
                                    left: size.width * 0.1),
                                child: FocusScope(
                                    child: Focus(
                                        onFocusChange: (focus) =>
                                            controller.animateTo(
                                              size.height * 0.3,
                                              curve: Curves.easeOut,
                                              duration: const Duration(
                                                  milliseconds: 300),
                                            ),
                                        child: Center(
                                          child: TextField(
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(
                                                        r'^[0-9a-zA-Z@_.-]+$')),
                                              ],
                                              maxLength: 20,
                                              maxLines: 1,
                                              obscureText: false,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                              decoration: InputDecoration(
                                                labelStyle: TextStyle(
                                                    color: Colors.white),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  // width: 0.0 produces a thin "hairline" border
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  borderSide: const BorderSide(
                                                      color: Colors.green,
                                                      width: 1.0),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  borderSide: BorderSide(
                                                    color: Colors.green,
                                                  ),
                                                ),
                                                labelText: 'クラスID',
                                              ),
                                              onChanged: (text) {
                                                userData.classCode = text;
                                              }),
                                        )))),
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
                                      primary: Colors.white,
                                      shape: const StadiumBorder(),
                                      side:
                                          const BorderSide(color: Colors.green),
                                    ),
                                    onPressed: _signIn),
                              )),
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: Container(
                                  width: 200.0,
                                  height: 50.0,
                                  child: TextButton(
                                      child: const Text('ログインしないで続ける',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      style: TextButton.styleFrom(
                                        primary: Colors.white,
                                      ),
                                      onPressed: () {
                                        userData.name = "Guest";
                                        Navigator.of(context).pushNamed(
                                            "/grade",
                                            arguments: userData);
                                      })),
                            ),
                          ]))
                        : null),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed('/emergency');
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
                                  padding:
                                      EdgeInsets.only(left: size.width * 0.1),
                                  child: Row(
                                    children: [
                                      Text('緊急事態',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize:
                                                  48 - animation.value * 0.1,
                                              fontWeight: FontWeight.bold,
                                              color: animation.value == 0
                                                  ? Colors.red
                                                  : Colors.white)),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: size.width * 0.01),
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

  void _showDialog(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(text),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
//                style: TextButton.styleFrom(primary: accentColor),
            )
          ],
        );
      },
    );
  }
}
