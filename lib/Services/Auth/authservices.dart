import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthServices {
  final FirebaseAuth firebase;

  AuthServices(FirebaseAuth _fireAuth) : firebase = _fireAuth;

  Future<void> PhoneNumberAuth(
      {phoneNumber,
      verificationCompleted,
      verificationFailed,
      codeSent,
      codeAutoRetrievalTimeout}) async {
    await firebase.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  Future<String> CodeVerify(
      {required String verificationId, required String smsCode}) async {
    final users;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      users = await firebase.signInWithCredential(credential);
      return users.user!.uid != null ? "HASUSER" : "NOUSER";
    } on FirebaseAuthException catch (e) {
      if (e.message!.contains(
          "e.message.contains('The sms verification code used to create the phone auth credential is invalid')")) {
        return "INVALIDSMSCODE";
      } else if (e.message!.contains('The sms code has expired')) {
        return "SMSEXPIRED";
      } else {
        return "INTERNETERROR";
      }
    }
  }

  Stream<User?> auth_status() {
    return firebase.authStateChanges();
  }
}
