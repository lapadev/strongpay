import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strongpay/data/sharedpreference_helper.dart';
import 'package:strongpay/ui/index/index.dart';
import 'package:strongpay/ui/login/login.dart';
import 'package:strongpay/ui/pin/pin.dart';
import 'package:strongpay/utils/sp_constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _shouldFadeOut = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: AnimatedOpacity(
            opacity: _shouldFadeOut ? 1.0 : 0.0,
            duration: Duration(milliseconds: 1000),
            child: Container(
              width: 150.0,
              height: 150.0,
              child: Image.asset('images/logo_strongpay_yellow.png'),
            ),
          ),
        ));
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);

    super.initState();

    /// ToDo: Remove it
    SharedPreferenceHelper.initDebugValues();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _shouldFadeOut = true;
      });

      _initSplashScreen();
    });
  }

  Future<void> _initSplashScreen() async {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    bool isUserLogged = await _checkIfUserIsLogged();

    await Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
//          builder: (_) => isUserLogged ? PinPage() : LoginPage()
              builder: (_) => IndexPage()));
    });
  }

  Future<bool> _checkIfUserIsLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userEmail = prefs.getString(SPConstants.USER_EMAIL_KEY);
    return (userEmail != null && userEmail.isNotEmpty);
  }
}
