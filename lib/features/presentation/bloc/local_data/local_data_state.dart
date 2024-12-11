import 'package:equatable/equatable.dart';
import 'package:mspis/features/domain/entities/results.dart';
import 'package:mspis/features/domain/entities/user.dart';

abstract class LocalDataState extends Equatable {
  final List<Map<String, dynamic>>? themes;
  final List<Map<String, dynamic>>? tests;
  final List<Map<String, dynamic>>? allTests;
  final List<ResultEntity>? results;
  final List<UserEntity>? users;
  final bool? inTests;
  final int? themeId;

  const LocalDataState(
      {this.themes,
      this.inTests,
      this.themeId,
      this.tests,
      this.allTests,
      this.users,
      this.results});
}

class LocalDataLoading extends LocalDataState {
  const LocalDataLoading();

  @override
  List<Object> get props => [];
}

class LocalDataWainting extends LocalDataState {
  const LocalDataWainting();

  @override
  List<Object> get props => [];
}

class LocalDataDone extends LocalDataState {
  const LocalDataDone(
      {super.themes,
      super.themeId,
      super.inTests = false,
      super.tests,
      super.allTests,
      super.results,
      super.users});

  @override
  List<Object> get props => [themes!, inTests!, results!];
}
