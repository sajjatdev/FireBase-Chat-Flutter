import 'dart:io';

import 'package:FireChat/Widget/QText.dart';
import 'package:FireChat/Widget/Qcolors.dart';
import 'package:FireChat/config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);
  static const String routeName = '/Intro';

  static Route route() {
    if (Platform.isIOS) {
      return CupertinoPageRoute(
          settings: const RouteSettings(name: routeName),
          builder: (_) => Intro());
    } else {
      return MaterialPageRoute(
          settings: const RouteSettings(name: routeName),
          builder: (_) => Intro());
    }
  }

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    animationController.addListener(() {
      setState(() {});
    });
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return PlatformScaffold(
        body: SafeArea(
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(
                0,
                50 *
                    animationController
                        .drive(CurveTween(curve: Curves.easeInOut))
                        .value),
            child: AnimatedOpacity(
                duration: Duration(seconds: 1),
                opacity: 1 *
                    animationController
                        .drive(CurveTween(curve: Curves.easeInOut))
                        .value,
                child: child),
          );
        },
        child: Transform.translate(
          offset: Offset(0, -50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: LottieBuilder.asset(
                  'assets/animation/intro.json',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5.w),
                child: Text(
                  "FireChat",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30.sp,
                      color: QTextColor(context),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: PlatformWidget(material: (_, __) {
                  return Text(
                    Intro_title,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 15.sp, color: QTextColor(context)),
                  );
                }, cupertino: (_, __) {
                  return const QText(
                    text: Intro_title,
                  );
                }),
              ),
              SizedBox(
                height: 20.w,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: PlatformWidget(material: (context, platform) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed("/AuthView");
                    },
                    child: Container(
                      height: 12.w,
                      width: 50.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Qcolors(context),
                          borderRadius: BorderRadius.circular(10.sp)),
                      child: Text(
                        ButtonText,
                        style: TextStyle(
                            color: QTextColor(context), fontSize: 15.sp),
                      ),
                    ),
                  );
                }, cupertino: (_, __) {
                  return PlatformElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/AuthView");
                    },
                    color: isDarkMode
                        ? HexColor(darkBGColor)
                        : HexColor(lightBGcolors),
                    child: PlatformText(ButtonText,
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                color:
                                    isDarkMode ? Colors.white : Colors.black))),
                  );
                }),
              ),
              SizedBox(
                height: 2.w,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
