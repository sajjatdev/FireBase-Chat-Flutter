part of 'phone_auth_cubit.dart';

abstract class PhoneAuthState extends Equatable {
  const PhoneAuthState();

  @override
  List<Object> get props => [];
}

class PhoneAuthInitial extends PhoneAuthState {}

class PhoneAuthLoading extends PhoneAuthState {
  final bool isloading;

  PhoneAuthLoading({this.isloading = false});

  @override
  // TODO: implement props
  List<Object> get props => [isloading];
}

class PhoneAuthEnum extends PhoneAuthState {
  final SMSCodeStatus Authstatus;

  PhoneAuthEnum({required this.Authstatus});

  @override
  // TODO: implement props
  List<Object> get props => [Authstatus];
}


