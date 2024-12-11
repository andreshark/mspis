import 'package:mspis/features/data/local_data_repository_impl.dart';
import 'package:mspis/features/domain/entities/user.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';

class GetStudentstUseCase
    implements UseCase<DataState<List<UserEntity>>, void> {
  final LocalDataRepositoryImpl _dataRepositoryImpl;

  GetStudentstUseCase(this._dataRepositoryImpl);

  @override
  Future<DataState<List<UserEntity>>> call({params}) async {
    return await _dataRepositoryImpl.getStudents();
  }
}
