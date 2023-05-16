import 'dart:async';
import 'package:hr_app/data/model/body/MenuModelRequest.dart';
import 'package:hr_app/data/model/body/store_model_request.dart';
import 'package:hr_app/helper/user_login_info.dart';
import 'package:hr_app/provider/product_provider.dart';
import 'package:hr_app/provider/report_parse_provider.dart';
import 'package:hr_app/utill/color_resources.dart';
import 'package:hr_app/view/screen/auth/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../helper/network_info.dart';
import '../../helper/security_helper.dart';
import '../../provider/auth_provider.dart';
import '../../provider/parse_provider.dart';
import '../../provider/splash_provider.dart';
import '../../utill/app_constants.dart';
import '../../utill/images.dart';
import 'landing_page/landing_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {

    super.initState();
    NetworkInfo.checkConnectivity(context);

    // Timer(Duration(seconds: 5), (){
    //   Navigator.of(context).pushReplacement(MaterialPageRoute(
    //       builder: (BuildContext context) => AuthScreen()));
    // });

    Provider.of<SplashProvider>(context, listen: false).initConfig(context).then((bool isSuccess) {
      if(isSuccess) {
        Timer(Duration(seconds: 1), () {
          if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
            Provider.of<AuthProvider>(context, listen: false).updateToken(context);
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => LandingScreen()));
          } else {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => AuthScreen()));
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.MAIN_COLOR,
        body: Stack(
      clipBehavior: Clip.none,
      children: [
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Hero(
                  tag: 'logo',
                  child: Image.asset(Images.white_logo, fit: BoxFit.cover)),
            ],
          ),
        ),
      ],
    ));
  }
}
