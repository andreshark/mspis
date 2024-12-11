import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.name,
    required this.login,
    required this.password,
    required this.role,
  });
  final String name;
  final int id;
  final int role;
  final String login;
  final String password;

  @override
  List<Object?> get props {
    return [id, name, role, login, password];
  }
}
