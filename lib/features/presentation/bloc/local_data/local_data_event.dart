import 'package:mspis/features/domain/entities/user.dart';

abstract class LocalDataEvent {
  const LocalDataEvent();
}

class ReadTables extends LocalDataEvent {
  final UserEntity user;
  const ReadTables({required this.user});
}

class ChooseTheme extends LocalDataEvent {
  final int themeId;
  const ChooseTheme({required this.themeId});
}

class BackToThemes extends LocalDataEvent {
  const BackToThemes();
}

class InitTable extends LocalDataEvent {
  final String user;
  final String pass;
  final String bdName;
  const InitTable({
    required this.user,
    required this.pass,
    required this.bdName,
  });
}
