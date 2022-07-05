// ignore: file_names
import 'dart:io';

import 'package:FireChat/Logic/Phone_Auth/phone_auth_cubit.dart';
import 'package:FireChat/Widget/QText.dart';
import 'package:FireChat/Widget/Qcolors.dart';
import 'package:FireChat/config/Enum.dart';
import 'package:FireChat/config/config.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';

import 'package:sizer/sizer.dart';

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);
  static const String routeName = '/AuthView';

  static Route route() {
    if (Platform.isIOS) {
      return CupertinoPageRoute(
          settings: const RouteSettings(name: routeName),
          builder: (_) => AuthView());
    } else {
      return MaterialPageRoute(
          settings: const RouteSettings(name: routeName),
          builder: (_) => AuthView());
    }
  }

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> with TickerProviderStateMixin {
  TextEditingController number = TextEditingController();
  late AnimationController animationControllers;
  bool clear = false;
  // ignore: non_constant_identifier_names
  bool PageLoading = false;

  @override
  void initState() {
    animationControllers =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animationControllers.addListener(() {
      setState(() {});
    });

    animationControllers.forward();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    number.clear();
    animationControllers.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return LoadingOverlay(
      progressIndicator: PlatformCircularProgressIndicator(
        material: (_, __) =>
            MaterialProgressIndicatorData(color: QTextColor(context)),
        cupertino: (_, __) =>
            CupertinoProgressIndicatorData(color: QTextColor(context)),
      ),
      isLoading: PageLoading,
      color: Qcolors(context),
      child: PlatformScaffold(
        body: SafeArea(
          child: AnimatedBuilder(
            animation: animationControllers,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                    0,
                    50 *
                        animationControllers
                            .drive(CurveTween(curve: Curves.easeInOut))
                            .value),
                child: AnimatedOpacity(
                    duration: const Duration(seconds: 1),
                    opacity: 1 *
                        animationControllers
                            .drive(CurveTween(curve: Curves.easeInOut))
                            .value,
                    child: child),
              );
            },
            child: Transform.translate(
              offset: const Offset(0, -50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10.w,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: QText(
                      text: "LOGIN WITH MOBILE NUMBER",
                      size: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: LottieBuilder.asset(
                      'assets/animation/phone.json',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: PlatformWidget(material: (_, __) {
                      return TextField(
                        cursorColor: QTextColor(context),
                        keyboardType: TextInputType.phone,
                        controller: number,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              clear = true;
                            });
                          } else {
                            setState(() {
                              clear = false;
                            });
                          }
                        },
                        style: TextStyle(
                            fontSize: 15.sp, color: QTextColor(context)),
                        decoration: InputDecoration(
                            filled: true,
                            suffixIcon: clear
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        number.clear();
                                        clear = false;
                                      });
                                    },
                                    color: QTextColor(context),
                                    icon: const Icon(
                                      Icons.close,
                                    ))
                                : null,
                            fillColor: Qcolors(context),
                            hintText: "Enter your Phone number",
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10.sp))),
                      );
                    }, cupertino: (_, __) {
                      return PlatformTextField(
                          controller: number,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              setState(() {
                                clear = true;
                              });
                            } else {
                              setState(() {
                                clear = false;
                              });
                            }
                          },
                          cupertino: (_, __) => CupertinoTextFieldData(
                              suffix: clear
                                  ? PlatformIconButton(
                                      onPressed: () {
                                        setState(() {
                                          number.clear();
                                          clear = false;
                                        });
                                      },
                                      icon: Icon(
                                        CupertinoIcons.clear,
                                        size: 15.sp,
                                        color: QTextColor(context),
                                      ))
                                  : null,
                              cursorColor: QTextColor(context),
                              decoration: BoxDecoration(
                                  color: Qcolors(context),
                                  borderRadius: BorderRadius.circular(10)),
                              placeholder: "Enter your Phone number",
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.sp, vertical: 12.sp)));
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: PlatformWidget(material: (_, __) {
                      return Text(
                        AuthScreenSubText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12.sp, color: QTextColor(context)),
                      );
                    }, cupertino: (_, __) {
                      return const QText(
                        text: AuthScreenSubText,
                        size: 12,
                      );
                    }),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: PlatformWidget(
                      material: (_, __) {
                        return BlocListener<PhoneAuthCubit, PhoneAuthState>(
                          listener: (context, state) {
                            if (state is PhoneAuthEnum) {
                              if (state.Authstatus == SMSCodeStatus.SMSSend) {
                                Navigator.of(context)
                                    .pushNamed("/OTP", arguments: number.text);
                                setState(() {
                                  PageLoading = false;
                                });
                              }
                              if (state.Authstatus ==
                                  SMSCodeStatus.NumberInvalid) {
                                print("Phone Number Invalid");
                                setState(() {
                                  PageLoading = false;
                                });

                                Fluttertoast.showToast(
                                    msg: "Your Phone Number Invalid",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Qcolors(context),
                                    textColor: QTextColor(context),
                                    fontSize: 16.0);
                              }
                              if (state.Authstatus ==
                                  SMSCodeStatus.InternetError) {
                                print("Try again");
                                setState(() {
                                  PageLoading = false;
                                });
                                Fluttertoast.showToast(
                                    msg: "Please Try again",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Qcolors(context),
                                    textColor: QTextColor(context),
                                    fontSize: 16.0);
                              }
                            }
                          },
                          child: GestureDetector(
                            onTap: clear
                                ? () {
                                    setState(() {
                                      PageLoading = true;
                                    });
                                    context
                                        .read<PhoneAuthCubit>()
                                        .PhoneAuth(phoneNumber: number.text);
                                  }
                                : null,
                            child: Container(
                              height: 12.w,
                              width: 50.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Qcolors(context),
                                  borderRadius: BorderRadius.circular(10.sp)),
                              child: Text(
                                "SEND CODE",
                                style: TextStyle(
                                    color: QTextColor(context),
                                    fontSize: 15.sp),
                              ),
                            ),
                          ),
                        );
                      },
                      cupertino: (_, __) {
                        return BlocListener<PhoneAuthCubit, PhoneAuthState>(
                          listener: (context, state) {
                            if (state is PhoneAuthEnum) {
                              if (state.Authstatus == SMSCodeStatus.SMSSend) {
                                Navigator.of(context)
                                    .pushNamed("/OTP", arguments: number.text);
                                setState(() {
                                  PageLoading = false;
                                });
                              }
                              if (state.Authstatus ==
                                  SMSCodeStatus.NumberInvalid) {
                                print("Phone Number Invalid");
                                setState(() {
                                  PageLoading = false;
                                });

                                Fluttertoast.showToast(
                                    msg: "Your Phone Number Invalid",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Qcolors(context),
                                    textColor: QTextColor(context),
                                    fontSize: 16.0);
                              }
                              if (state.Authstatus ==
                                  SMSCodeStatus.InternetError) {
                                print("Try again");
                                setState(() {
                                  PageLoading = false;
                                });
                                Fluttertoast.showToast(
                                    msg: "Please Try again",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Qcolors(context),
                                    textColor: QTextColor(context),
                                    fontSize: 16.0);
                              }
                            }
                          },
                          child: PlatformElevatedButton(
                            onPressed: clear
                                ? () {
                                    setState(() {
                                      PageLoading = true;
                                    });
                                    context
                                        .read<PhoneAuthCubit>()
                                        .PhoneAuth(phoneNumber: number.text);
                                  }
                                : null,
                            color: Qcolors(context),
                            child: PlatformText("SEND CODE",
                                style: GoogleFonts.lato(
                                    textStyle:
                                        TextStyle(color: QTextColor(context)))),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
