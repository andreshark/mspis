import 'package:mspis/features/data/local_data_repository_impl.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';

class ShowTestsUseCase implements UseCase<DataState, int> {
  final LocalDataRepositoryImpl _dataRepositoryImpl;

  ShowTestsUseCase(this._dataRepositoryImpl);

  @override
  Future<DataState<List<Map<String, dynamic>>>> call({int? params}) async {
    return await _dataRepositoryImpl.readTable('tests', 'id', params!);
  }
}
