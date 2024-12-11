import 'package:mspis/features/data/models/user.dart';
import 'package:mspis/features/domain/entities/question.dart';
import 'package:mspis/features/domain/entities/results.dart';
import 'package:mspis/features/domain/entities/user.dart';

import '../../../../core/resources/data_state.dart';
import 'usecases/add_test_result.dart';

abstract class LocalDataRepository {
  Future<DataState<List<QuestionEntity>>> loadTest(int id);

  Future<DataState<List<Map<String, dynamic>>>> readTable(
      String tableName, String columnId, int? themeId);

  Future<DataState> initTable(String bd, String user, String pass);

  Future<DataState<UserModel>> auth(String email, String password);

  Future<DataState> addTestResult(ResultParams params);

  Future<DataState<List<ResultEntity>>> getResults(int? userId);

  Future<DataState<List<UserEntity>>> getStudents();
}
