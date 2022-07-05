part of 'auth_status_cubit.dart';

abstract class AuthStatusState extends Equatable {
  const AuthStatusState();

  @override
  List<Object> get props => [];
}

class AuthStatusInitial extends AuthStatusState {}

class AuthStatusEnum extends AuthStatusState {
  final AuthStatus authStatus;

  AuthStatusEnum({required this.authStatus});

  @override
  // TODO: implement props
  List<Object> get props => [this.authStatus];
}
