// ignore_for_file: non_constant_identifier_names

import 'package:FireChat/Services/Auth/authservices.dart';
import 'package:FireChat/config/Enum.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  final AuthServices authServices;
  late String verificationIds;
  // ignore: no_leading_underscores_for_local_identifiers
  PhoneAuthCubit(AuthServices _auth)
      : authServices = _auth,
        super(PhoneAuthInitial());

  Future<void> PhoneAuth({required String phoneNumber}) async {
    try {
      emit(PhoneAuthLoading());
      authServices.PhoneNumberAuth(
          phoneNumber: phoneNumber,
          verificationCompleted: (AuthCredential authCredential) {},
          verificationFailed: (FirebaseAuthException e) {
            if (e.code == 'invalid-phone-number') {
              emit(PhoneAuthEnum(Authstatus: SMSCodeStatus.NumberInvalid));
            }
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            verificationIds = verificationId;
            emit(PhoneAuthEnum(Authstatus: SMSCodeStatus.SMSSend));
          },
          codeSent: (String verificationId, int? resendToken) {
            verificationIds = verificationId;
            emit(PhoneAuthEnum(Authstatus: SMSCodeStatus.SMSSend));
          });
      // ignore: unused_catch_clause
    } on FirebaseAuthException catch (e) {
      emit(PhoneAuthEnum(Authstatus: SMSCodeStatus.InternetError));
    }
  }

  Future<void> CodeVerify({required String SMSCode}) async {
    String Data = await authServices.CodeVerify(
        verificationId: verificationIds, smsCode: SMSCode);
    if (Data.contains("HASUSER")) {
      emit(PhoneAuthEnum(Authstatus: SMSCodeStatus.VerifyComplate));
    } else if (Data.contains("INVALIDSMSCODE")) {
      emit(PhoneAuthEnum(Authstatus: SMSCodeStatus.SMSInvalid));
    } else if (Data.contains("SMSEXPIRED")) {
      emit(PhoneAuthEnum(Authstatus: SMSCodeStatus.SMSExpired));
    }
  }
}
