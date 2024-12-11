import 'package:mspis/features/data/app_data_service.dart';
import 'package:mspis/features/domain/entities/answer.dart';
import 'package:mspis/features/domain/entities/question.dart';
import 'package:mspis/features/domain/entities/results.dart';
import 'package:mspis/features/domain/entities/user.dart';
import 'package:mspis/features/domain/usecases/add_test_result.dart';
import 'package:postgres/postgres.dart';
import '../../core/resources/data_state.dart';
import '../domain/local_data_repository.dart';
import 'models/user.dart';

class LocalDataRepositoryImpl extends LocalDataRepository {
  LocalDataRepositoryImpl(this.appDataService);
  final AppDataService appDataService;

  @override
  auth(String email, String password) async {
    DataState<UserModel> dataState =
        await appDataService.getUser('users', email, password);
    return dataState;
  }

  @override
  readTable(String tableName, String columnId, int? themeId) async {
    DataState<List<Map<String, dynamic>>> response = await appDataService
        .readTable(tableName: tableName, columnId: columnId, themeId: themeId);
    if (response is DataSuccess) {
      return DataSuccess(response.data!);
    }
    return DataFailedMessage('');
  }

  @override
  loadTest(int id) async {
    DataState<List<Map<String, dynamic>>> response =
        await appDataService.readTable(tableName: 'questions', columnId: 'id');
    DataState<List<Map<String, dynamic>>> response1 =
        await appDataService.readTable(tableName: 'answers', columnId: 'id');
    if (response is DataSuccess) {
      List<Map<String, dynamic>> rows = response.data!;
      List<Map<String, dynamic>> rows1 = response1.data!;
      List<QuestionEntity> questions = rows
          .where((element) => element['test_id'] == id)
          .map((element) => QuestionEntity(
              description: element['description'],
              difficult: element['difficult'],
              type: element['knowledge_type'],
              rightAnswerId: element['right_answer_id'],
              answers: rows1
                  .where((element1) => element1['question_id'] == element['id'])
                  .map((element1) => AnswerEntity(
                      id: element1['id'], description: element1['description']))
                  .toList()))
          .toList();
      return DataSuccess(questions);
    }
    return DataFailedMessage('');
  }

  @override
  Future<DataState> addTestResult(ResultParams params) {
    return appDataService.addTestResult(params);
  }

  @override
  Future<DataState> initTable(String bd, String user, String pass) {
    return appDataService.init();
  }

  @override
  Future<DataState<List<ResultEntity>>> getResults(int? userId) {
    return appDataService.getResults(userId);
  }

  @override
  Future<DataState<List<UserEntity>>> getStudents() {
    return appDataService.getStudents();
  }
}
