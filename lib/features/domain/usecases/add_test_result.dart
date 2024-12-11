import 'package:mspis/features/data/local_data_repository_impl.dart';
import '../../../../core/usecase/usecase.dart';

class AddTestResultUseCase implements UseCase<void, ResultParams> {
  final LocalDataRepositoryImpl _localDataRepositoryImpl;

  AddTestResultUseCase(this._localDataRepositoryImpl);

  @override
  Future<void> call({ResultParams? params}) async {
    _localDataRepositoryImpl.addTestResult(params!);
  }
}

class ResultParams {
  const ResultParams(
      {required this.testId,
      required this.userId,
      required this.pol,
      required this.chl,
      required this.u});

  final int testId;
  final int userId;
  final double pol;
  final double chl;
  final double u;
}
