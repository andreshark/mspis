import 'package:mspis/features/data/local_data_repository_impl.dart';
import 'package:mspis/features/domain/entities/user.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';

class LoginUseCase implements UseCase<DataState<UserEntity>, LoginParams> {
  final LocalDataRepositoryImpl _localDataRepositoryImpl;

  LoginUseCase(this._localDataRepositoryImpl);

  @override
  Future<DataState<UserEntity>> call({LoginParams? params}) async {
    return await _localDataRepositoryImpl.auth(params!.email, params.password);
  }
}

class LoginParams {
  const LoginParams({required this.email, required this.password});

  final String email;
  final String password;
}
