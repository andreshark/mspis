import 'package:mspis/features/data/local_data_repository_impl.dart';
import 'package:mspis/features/domain/entities/question.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';

class LoadTestUseCase implements UseCase<DataState<List<QuestionEntity>>, int> {
  final LocalDataRepositoryImpl _dataRepositoryImpl;

  LoadTestUseCase(this._dataRepositoryImpl);

  @override
  Future<DataState<List<QuestionEntity>>> call({int? params}) async {
    return await _dataRepositoryImpl.loadTest(params!);
  }
}
