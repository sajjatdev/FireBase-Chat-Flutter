// ignore_for_file: unnecessary_null_comparison

import 'dart:async';

import 'package:FireChat/Services/Auth/authservices.dart';
import 'package:FireChat/config/Enum.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_status_state.dart';

class AuthStatusCubit extends Cubit<AuthStatusState> {
  final AuthServices authServices;
  StreamSubscription? userStatus;
  AuthStatusCubit(this.authServices) : super(AuthStatusInitial());

  // ignore: non_constant_identifier_names
  Future<void> GetUserStatus() async {
    try {
      userStatus = authServices.auth_status().listen((event) {
        if (event!.uid != null) {
          emit(AuthStatusEnum(authStatus: AuthStatus.Has_User));
        } else {
          userStatus!.cancel();
          emit(AuthStatusEnum(authStatus: AuthStatus.Logout));
        }
      });
    } on FirebaseAuthException catch (e) {
      userStatus!.cancel();
      emit(AuthStatusEnum(authStatus: AuthStatus.Error));
    }
  }
}
