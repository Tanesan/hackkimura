import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';

void requestCertificate(BuildContext context) async {
  bool _isOnlyWebLogin = false;
  final Set<String> _selectedScopes = Set.from(['profile']);

  try {
    /// requestCode is for Android platform only, use another unique value in your application.
    final loginOption =
    LoginOption(_isOnlyWebLogin, 'normal', requestCode: 8192);
    final result = await LineSDK.instance
        .login(scopes: _selectedScopes.toList(), option: loginOption);
    /*
    final accessToken = await LineSDK.instance.currentAccessToken;
    final idToken = result.accessToken.idToken;
    final userEmail = (idToken != null) ? idToken['email'] : null;
     */
    UserProfile userProfile = result.userProfile!;
    _showDialog(context, "LINE Blockchainで認定証を作成しました。¥nLINEをご確認ください。");
  } on PlatformException catch (e) {
    _showDialog(context, e.toString());
  }
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