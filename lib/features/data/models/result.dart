import 'package:mspis/features/domain/entities/results.dart';

class ResultModel extends ResultEntity {
  const ResultModel(
      {required pol,
      required chl,
      required u,
      required testId,
      required userId})
      : super(pol: pol, chl: chl, u: u, testId: testId, userId: userId);

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
        pol: json['pol'].toDouble(),
        chl: json['chl'].toDouble(),
        u: json['u'].toDouble(),
        userId: json['user_id'] as int,
        testId: json['test_id'] as int);
  }
}
