import 'package:mspis/features/domain/entities/user.dart';

class UserModel extends UserEntity {
  const UserModel(
      {required name,
      required id,
      required role,
      required login,
      required password})
      : super(name: name, id: id, login: login, role: role, password: password);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] as String,
      id: json['id'] as int,
      role: json['role'] as int,
      login: json['login'] as String,
      password: json['password'] as String,
    );
  }
}
