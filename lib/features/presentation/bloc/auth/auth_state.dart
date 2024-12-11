import 'package:equatable/equatable.dart';
import '../../../domain/entities/user.dart';

abstract class AuthState extends Equatable {
  final String? errorMessage;
  final UserEntity? userEntity;

  const AuthState({this.errorMessage, this.userEntity});

  @override
  List<Object> get props => [];
}

class LoginFailed extends AuthState {
  const LoginFailed(String errorMessage) : super(errorMessage: errorMessage);

  @override
  List<Object> get props => [errorMessage!];
}

class LoginSuccess extends AuthState {
  const LoginSuccess({super.userEntity});

  @override
  List<Object> get props => [userEntity!];
}

class StartLoginState extends AuthState {
  const StartLoginState();
}

class LoginChecking extends AuthState {
  const LoginChecking();
}
