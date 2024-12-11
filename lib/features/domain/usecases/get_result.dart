import 'package:mspis/features/data/local_data_repository_impl.dart';
import 'package:mspis/features/domain/entities/results.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';

class GetResultUseCase implements UseCase<DataState<List<ResultEntity>>, int> {
  final LocalDataRepositoryImpl _dataRepositoryImpl;

  GetResultUseCase(this._dataRepositoryImpl);

  @override
  Future<DataState<List<ResultEntity>>> call({int? params}) async {
    return await _dataRepositoryImpl.getResults(params);
  }
}
