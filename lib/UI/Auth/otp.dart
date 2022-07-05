import 'dart:async';
import 'dart:io';

import 'package:FireChat/Logic/Phone_Auth/phone_auth_cubit.dart';
import 'package:FireChat/Widget/Qcolors.dart';
import 'package:FireChat/config/Enum.dart';
import 'package:FireChat/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class OTP extends StatefulWidget {
  const OTP({Key? key, required this.phone_number}) : super(key: key);
  static const String routeName = '/OTP';

  static Route route({required String phone_number}) {
    if (Platform.isIOS) {
      return CupertinoPageRoute(
          settings: const RouteSettings(name: routeName),
          builder: (_) => OTP(
                phone_number: phone_number,
              ));
    } else {
      return MaterialPageRoute(
          settings: const RouteSettings(name: routeName),
          builder: (_) => OTP(
                phone_number: phone_number,
              ));
    }
  }

  final String phone_number;

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  TextEditingController textEditingController = TextEditingController();
  bool PageLoading = false;
  bool btnenable = false;
  String androidOTP = '';
  //timer Start

  Timer? _timer;
  int _start = 60;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animationController.addListener(() {
      setState(() {});
    });

    animationController.forward();
    setState(() {
      startTimer();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    textEditingController.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      progressIndicator: PlatformCircularProgressIndicator(
        material: (_, __) =>
            MaterialProgressIndicatorData(color: QTextColor(context)),
        cupertino: (_, __) =>
            CupertinoProgressIndicatorData(color: QTextColor(context)),
      ),
      color: Qcolors(context),
      isLoading: PageLoading,
      child: PlatformScaffold(
        appBar: PlatformAppBar(
          trailingActions: [
            if (_start == 0) ...[
              GestureDetector(
                onTap: () {
                  setState(() {
                    PageLoading = true;
                  });
                  Fluttertoast.showToast(
                      msg: "ReSend SMS Code",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Qcolors(context),
                      textColor: QTextColor(context),
                      fontSize: 16.0);
                  context
                      .read<PhoneAuthCubit>()
                      .PhoneAuth(phoneNumber: widget.phone_number);

                  Future.delayed(const Duration(seconds: 5), () {
                    setState(() {
                      PageLoading = false;
                    });
                  });
                },
                child: Platform.isAndroid
                    ? Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(right: 5.w),
                          child: const Text(
                            "Resend",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ))
                    : const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Resend",
                          style: TextStyle(color: Colors.blue),
                        )),
              )
            ] else ...[
              Platform.isAndroid
                  ? Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(right: 5.w),
                        child: Text(
                          _start.toString() + "S",
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ))
                  : Align(
                      alignment: Alignment.center,
                      child: Text(
                        _start.toString() + "S",
                        style: const TextStyle(color: Colors.blue),
                      ))
            ],
          ],
          material: (_, __) => MaterialAppBarData(
              iconTheme: IconThemeData(color: QTextColor(context)),
              centerTitle: true,
              title: Text(
                "OTP",
                style: TextStyle(color: QTextColor(context)),
              ),
              backgroundColor: Qcolors(context),
              elevation: 1,
              shadowColor: Qcolors(context)),
          cupertino: (_, __) => CupertinoNavigationBarData(
            title: Text(
              "OTP",
              style: TextStyle(color: QTextColor(context)),
            ),
            backgroundColor: Qcolors(context),
          ),
        ),
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
                    duration: const Duration(seconds: 1),
                    opacity: 1 *
                        animationController
                            .drive(CurveTween(curve: Curves.easeInOut))
                            .value,
                    child: child),
              );
            },
            child: Transform.translate(
              offset: const Offset(0, -50),
              child: Column(
                children: [
                  Expanded(
                    child: LottieBuilder.asset(
                      'assets/animation/otp.json',
                      width: 50.w,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'We Sent OTP code ',
                        style: TextStyle(
                          color: QTextColor(context),
                          fontSize: 12.sp,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: widget.phone_number,
                            style: TextStyle(
                                color: QTextColor(context),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                              text: ' to Verify your Number',
                              style: TextStyle(
                                color: QTextColor(context),
                                fontSize: 12.sp,
                              )),
                        ],
                      ),
                    ),
                  ),
                  PlatformWidget(
                    cupertino: (_, __) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: PlatformTextField(
                            controller: textEditingController,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                setState(() {
                                  btnenable = true;
                                });
                              } else {
                                setState(() {
                                  btnenable = false;
                                });
                              }
                            },
                            cupertino: (_, __) => CupertinoTextFieldData(
                                cursorColor: QTextColor(context),
                                decoration: BoxDecoration(
                                    color: Qcolors(context),
                                    borderRadius: BorderRadius.circular(10)),
                                placeholder: "Enter your OTP Code",
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.sp, vertical: 12.sp))),
                      );
                    },
                    material: (_, __) {
                      return OtpTextField(
                        numberOfFields: 6,
                        cursorColor: QTextColor(context),
                        focusedBorderColor: QTextColor(context),

                        borderColor: QTextColor(context),
                        //set to true to show as box or false to show as dash
                        showFieldAsBox: false,

                        onSubmit: (code) {
                          setState(() {
                            PageLoading = true;
                          });
                          context
                              .read<PhoneAuthCubit>()
                              .CodeVerify(SMSCode: code);
                        },
                        onCodeChanged: (String code) {
                          setState(() {
                            androidOTP = code;
                          });

                          print(androidOTP);

                          if (androidOTP.length == 6) {
                            setState(() {
                              btnenable = true;
                            });
                          } else {
                            setState(() {
                              btnenable = false;
                            });
                          }
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 60.w,
                  ),
                  PlatformWidget(
                    material: (_, __) {
                      return BlocListener<PhoneAuthCubit, PhoneAuthState>(
                        listener: (context, state) {
                          if (state is PhoneAuthEnum) {
                            if (state.Authstatus ==
                                SMSCodeStatus.VerifyComplate) {
                              Navigator.of(context).pushNamed(
                                "/profile_setup",
                              );
                              shareP.setString("MyUID", widget.phone_number);
                              setState(() {
                                PageLoading = false;
                              });
                            }
                            if (state.Authstatus == SMSCodeStatus.SMSInvalid) {
                              Fluttertoast.showToast(
                                  msg: "SMS Invalid",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Qcolors(context),
                                  textColor: QTextColor(context),
                                  fontSize: 16.0);
                              setState(() {
                                PageLoading = false;
                              });
                            }

                            if (state.Authstatus == SMSCodeStatus.SMSExpired) {
                              print("Please SMS sent again");
                              Fluttertoast.showToast(
                                  msg: "Please SMS sent again",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Qcolors(context),
                                  textColor: QTextColor(context),
                                  fontSize: 16.0);
                              setState(() {
                                PageLoading = false;
                              });
                            }
                          }
                        },
                        child: GestureDetector(
                          onTap: btnenable
                              ? () {
                                  setState(() {
                                    PageLoading = true;
                                  });
                                  context
                                      .read<PhoneAuthCubit>()
                                      .CodeVerify(SMSCode: androidOTP);
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
                              "VERIFY",
                              style: TextStyle(
                                  color: QTextColor(context), fontSize: 15.sp),
                            ),
                          ),
                        ),
                      );
                    },
                    cupertino: (_, __) {
                      return BlocListener<PhoneAuthCubit, PhoneAuthState>(
                        listener: (context, state) {
                          if (state is PhoneAuthEnum) {
                            if (state.Authstatus ==
                                SMSCodeStatus.VerifyComplate) {
                              Navigator.of(context).pushNamed(
                                "/profile_setup",
                              );
                              shareP.setString("MyUID", widget.phone_number);
                              setState(() {
                                PageLoading = false;
                              });
                            }
                            if (state.Authstatus == SMSCodeStatus.SMSInvalid) {
                              Fluttertoast.showToast(
                                  msg: "SMS Invalid",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Qcolors(context),
                                  textColor: QTextColor(context),
                                  fontSize: 16.0);
                              setState(() {
                                PageLoading = false;
                              });
                            }

                            if (state.Authstatus == SMSCodeStatus.SMSExpired) {
                              print("Please SMS sent again");
                              Fluttertoast.showToast(
                                  msg: "Please SMS sent again",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Qcolors(context),
                                  textColor: QTextColor(context),
                                  fontSize: 16.0);
                              setState(() {
                                PageLoading = false;
                              });
                            }
                          }
                        },
                        child: CupertinoButton(
                            color: Qcolors(context),
                            onPressed: btnenable
                                ? () {
                                    setState(() {
                                      PageLoading = true;
                                    });
                                    context.read<PhoneAuthCubit>().CodeVerify(
                                        SMSCode: textEditingController.text);
                                  }
                                : null,
                            child: Text(
                              "VERIFY",
                              style: TextStyle(color: QTextColor(context)),
                            )),
                      );
                    },
                  ),
                  SizedBox(
                    height: 3.w,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
