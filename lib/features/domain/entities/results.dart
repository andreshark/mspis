import 'package:equatable/equatable.dart';

class ResultEntity extends Equatable {
  const ResultEntity(
      {required this.chl,
      required this.pol,
      required this.u,
      required this.testId,
      required this.userId});
  final double chl;
  final double pol;
  final double u;
  final int testId;
  final int userId;

  @override
  List<Object?> get props {
    return [chl, pol, u, testId, userId];
  }
}
