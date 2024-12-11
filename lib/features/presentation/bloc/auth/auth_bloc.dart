import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/resources/data_state.dart';
import '../../../domain/usecases/init_table.dart';
import '../../../domain/usecases/login.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final InitTableUseCase _initTableUseCase;

  AuthBloc(this._loginUseCase, this._initTableUseCase)
      : super(const StartLoginState()) {
    on<Login>(login);
  }

  void login(Login event, Emitter<AuthState> emit) async {
    emit(const LoginChecking());
    //имитицаия работы пока нету сервера
    //await Future.delayed(const Duration(seconds: 2), () {});
    // _syncDataObjectUseCase();
    // emit(const LoginSuccess(
    //     userEntity: UserEntity(accessListModels: [], role: '1', accessToken: '234234')));

    // проверка авторизации
    DataState dataState =
        await _initTableUseCase(params: ('mispis', 'postgres', '123'));
    if (dataState is DataSuccess) {
      final dataState = await _loginUseCase(
          params: LoginParams(email: event.email!, password: event.password!));
      if (dataState is DataSuccess) {
        emit(LoginSuccess(userEntity: dataState.data));
      }

      if (dataState is DataFailedMessage) {
        emit(LoginFailed(dataState.errorMessage!));
      }
    }
  }
}
