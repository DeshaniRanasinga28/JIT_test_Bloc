import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jit_transfer_app/ui/splash/splash_screen_wrapper.dart';

import '../../const/string_const.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1000), () {
      if (mounted) {
        navigateToHome(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const PopScope(
      canPop: true,
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Text(StringConst.gitTransferLabel,
            style: TextStyle(
              fontFamily: "FiraSans",
              fontSize: 32.0,
              fontWeight: FontWeight.w800
            ),),
          )
        ),
      ),
    );
  }

  void navigateToHome(BuildContext context) async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => const SplashScreenWrapper()),
          (r) => false,
    );
  }
}
