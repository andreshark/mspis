import 'package:mspis/features/data/local_data_repository_impl.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';

class ShowThemesUseCase implements UseCase<DataState, void> {
  final LocalDataRepositoryImpl _dataRepositoryImpl;

  ShowThemesUseCase(this._dataRepositoryImpl);

  @override
  Future<DataState<List<Map<String, dynamic>>>> call({params}) async {
    return await _dataRepositoryImpl.readTable('theme', 'id', null);
  }
}
