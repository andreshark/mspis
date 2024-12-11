import 'package:mspis/features/domain/entities/user.dart';
import 'package:mspis/features/domain/usecases/get_result.dart';
import 'package:mspis/features/domain/usecases/show_tests.dart';
import 'package:mspis/features/domain/usecases/show_themes.dart';
import '../../../domain/usecases/get_students.dart';
import '../../../domain/usecases/init_table.dart';
import 'local_data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/resources/data_state.dart';
import 'local_data_event.dart';

class LocalDataBloc extends Bloc<LocalDataEvent, LocalDataState> {
  final ShowTestsUseCase _loadTestUseCase;
  final InitTableUseCase _initTableUseCase;
  final ShowThemesUseCase _showThemesUseCase;
  final GetResultUseCase _getResultUseCase;
  final GetStudentstUseCase _getStudentstUseCase;

  LocalDataBloc(
      this._loadTestUseCase,
      this._initTableUseCase,
      this._showThemesUseCase,
      this._getResultUseCase,
      this._getStudentstUseCase)
      : super(const LocalDataLoading()) {
    on<ReadTables>(readTables);
    on<InitTable>(initTable);
    on<ChooseTheme>(chooseTheme);
    on<BackToThemes>(backToThemes);
  }

  void chooseTheme(ChooseTheme event, Emitter<LocalDataState> emit) async {
    final dataState = await _loadTestUseCase(params: event.themeId);
    if (dataState is DataSuccess) {
      emit(LocalDataDone(
          tests: dataState.data,
          inTests: true,
          themeId: event.themeId,
          themes: state.themes,
          allTests: state.allTests,
          results: state.results,
          users: state.users));
    }
  }

  void backToThemes(BackToThemes event, Emitter<LocalDataState> emit) async {
    emit(LocalDataDone(
        themes: state.themes,
        inTests: false,
        allTests: state.allTests,
        users: state.users,
        results: state.results));
  }

  Future<void> readTables(
      ReadTables event, Emitter<LocalDataState> emit) async {
    final dataState = await _showThemesUseCase();
    final dataState1 = await _loadTestUseCase(params: 0);
    late final datastate2;
    List<UserEntity> students = [];
    if (event.user.role == 2) {
      datastate2 = await _getResultUseCase();
      students = (await _getStudentstUseCase()).data!;
    } else {
      datastate2 = await _getResultUseCase(params: event.user.id);
    }

    if (dataState is DataSuccess) {
      emit(LocalDataDone(
          themes: dataState.data!,
          allTests: dataState1.data,
          results: datastate2.data,
          users: students));
    }
  }

  Future<void> initTable(InitTable event, Emitter<LocalDataState> emit) async {
    final dataState =
        await _initTableUseCase(params: (event.bdName, event.user, event.pass));
    if (dataState is DataSuccess) {
      emit(LocalDataLoading());
    }
  }
}
