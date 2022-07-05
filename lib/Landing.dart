import 'dart:io';

import 'package:FireChat/UI/Error/errorpage.dart';
import 'package:FireChat/UI/intor/intor.dart';
import 'package:FireChat/UI/profile/profile_setup.dart';
import 'package:FireChat/config/Enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Logic/AuthStatus/auth_status_cubit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);
  static const String routeName = '/';

  static Route route() {
    if (Platform.isIOS) {
      return CupertinoPageRoute(
          settings: const RouteSettings(name: routeName),
          builder: (_) => Loading());
    } else {
      return MaterialPageRoute(
          settings: const RouteSettings(name: routeName),
          builder: (_) => Loading());
    }
  }

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    // TODO: implement initState

    // current State Check Bloc Call
    context.read<AuthStatusCubit>().GetUserStatus();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthStatusCubit, AuthStatusState>(
      builder: (context, state) {
        if (state is AuthStatusEnum) {
          if (state.authStatus == AuthStatus.Has_User) {
            return const Profile_Setup();
          } else if (state.authStatus == AuthStatus.Error) {
            return const ErrorPage();
          } else {
            return const Intro();
          }
        } else {
          return const ErrorPage();
        }
      },
    );
  }
}
