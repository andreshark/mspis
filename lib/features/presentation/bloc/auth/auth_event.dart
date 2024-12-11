import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  final String? email;
  final String? password;

  const AuthEvent({this.email,this.password});

  @override
  List<Object> get props => [email!, password!];
}

class Login extends AuthEvent {
  const Login({ super.email,  super.password});
}
