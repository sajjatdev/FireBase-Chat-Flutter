import 'package:FireChat/Landing.dart';
import 'package:FireChat/UI/Auth/Authview.dart';
import 'package:FireChat/UI/Auth/otp.dart';
import 'package:FireChat/UI/intor/intor.dart';
import 'package:FireChat/UI/profile/profile_setup.dart';
import 'package:flutter/material.dart';

class Routers {
  static Route onGenerateRoute(RouteSettings settings) {
    print('this is Route:- ${settings.name}');

    switch (settings.name) {
      case Loading.routeName:
        return Loading.route();
      case Intro.routeName:
        return Intro.route();
      case AuthView.routeName:
        return AuthView.route();
      case OTP.routeName:
        return OTP.route(phone_number: settings.arguments as String);
      case Profile_Setup.routeName:
        return Profile_Setup.route();
      default:
        return errorRoute();
    }
  }

  static Route errorRoute() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: '/error'),
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text("Error"),
              ),
            ));
  }
}
