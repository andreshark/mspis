import 'package:get_it/get_it.dart';
import 'package:mspis/features/domain/usecases/Load_test.dart';
import 'package:mspis/features/domain/usecases/add_test_result.dart';
import 'package:mspis/features/domain/usecases/get_result.dart';
import 'package:mspis/features/domain/usecases/get_students.dart';
import 'package:mspis/features/domain/usecases/login.dart';
import 'package:mspis/features/domain/usecases/show_themes.dart';
import 'package:mspis/features/presentation/bloc/auth/auth_bloc.dart';
import 'features/data/app_data_service.dart';
import 'features/data/local_data_repository_impl.dart';
import 'features/domain/usecases/show_tests.dart';
import 'features/domain/usecases/init_table.dart';
import 'features/presentation/bloc/local_data/local_data_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //services
  sl.registerLazySingleton<AppDataService>(() => AppDataService());

  //repositories
  sl.registerLazySingleton<LocalDataRepositoryImpl>(
      () => LocalDataRepositoryImpl(sl()));

  //usecases
  sl.registerLazySingleton<ShowTestsUseCase>(() => ShowTestsUseCase(sl()));
  sl.registerLazySingleton<InitTableUseCase>(() => InitTableUseCase(sl()));
  sl.registerLazySingleton<LoadTestUseCase>(() => LoadTestUseCase(sl()));
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));
  sl.registerLazySingleton<ShowThemesUseCase>(() => ShowThemesUseCase(sl()));
  sl.registerLazySingleton<GetResultUseCase>(() => GetResultUseCase(sl()));
  sl.registerLazySingleton<GetStudentstUseCase>(
      () => GetStudentstUseCase(sl()));
  sl.registerLazySingleton<AddTestResultUseCase>(
      () => AddTestResultUseCase(sl()));

  //blocs
  sl.registerLazySingleton<LocalDataBloc>(
      () => LocalDataBloc(sl(), sl(), sl(), sl(), sl()));
  sl.registerLazySingleton<AuthBloc>(() => AuthBloc(sl(), sl()));
}
