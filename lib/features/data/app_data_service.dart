import 'package:mspis/features/data/models/result.dart';
import 'package:mspis/features/data/models/user.dart';
import 'package:mspis/features/domain/usecases/add_test_result.dart';
import 'package:postgres/postgres.dart';
import '../../../../../core/resources/data_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppDataService {
  Future<DataState> init() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseKey,
    );
    supabase = Supabase.instance.client;
    return DataSuccess(true);
  }

  late final SupabaseClient supabase;
  final supabaseUrl = 'https://bbghjrjtfcvonavewyyg.supabase.co';
  final supabaseKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJiZ2hqcmp0ZmN2b25hdmV3eXlnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM5MzQxOTEsImV4cCI6MjA0OTUxMDE5MX0.nUzKjYWyQUJErrYASYkEsRSzt9QdINb12Vly-eLOLdg';

  Future<DataState<List<Map<String, dynamic>>>> readTable(
      {required String tableName,
      required String columnId,
      int? themeId}) async {
    try {
      late final result1;
      if (themeId == null) {
        result1 = await supabase.from(tableName).select('*').order(columnId);
      } else if (themeId == 0) {
        result1 = await supabase.from(tableName).select('*').order(columnId);
      } else {
        result1 = await supabase
            .from(tableName)
            .select('*')
            .eq('theme_id', themeId)
            .order(columnId);
      }

      return DataSuccess(result1);
    } on ServerException catch (e) {
      return DataFailedMessage(e.message.toString());
    }
  }

  Future<DataState<UserModel>> getUser(
      String tableName, String login, String password) async {
    try {
      final result =
          await supabase.from('users').select('*').eq('login', login);
      if (result.isEmpty) {
        return DataFailedMessage("Пользователь с таким логином не найден");
      }

      UserModel user = UserModel.fromJson(result.first);

      if (user.password == password) {
        return DataSuccess(user);
      } else {
        return DataFailedMessage("Неправильный пароль");
      }
    } on ServerException catch (e) {
      return DataFailedMessage(e.message.toString());
    }
  }

  Future<DataState<List<UserModel>>> getStudents() async {
    try {
      final result = await supabase.from('users').select('*');

      return DataSuccess(
          result.map((element) => UserModel.fromJson(element)).toList());
    } on ServerException catch (e) {
      return DataFailedMessage(e.message.toString());
    }
  }

  Future<DataState<List<ResultModel>>> getResults(int? userId) async {
    try {
      if (userId == null) {
        final result = await supabase.from('results').select('*');

        return DataSuccess(
            result.map((element) => ResultModel.fromJson(element)).toList());
      } else {
        final result =
            await supabase.from('results').select('*').eq('user_id', userId);
        return DataSuccess(
            result.map((element) => ResultModel.fromJson(element)).toList());
      }
    } on ServerException catch (e) {
      return DataFailedMessage(e.message.toString());
    }
  }

  Future<DataState> addTestResult(ResultParams params) async {
    try {
      final result = await supabase
          .from('results')
          .select('*')
          .eq('test_id', params.testId);
      if (result.isEmpty) {
        await supabase.from('results').insert({
          'user_id': params.userId,
          'chl': params.chl,
          'pol': params.pol,
          'u': params.u,
          'test_id': params.testId,
        });
      } else {
        await supabase.from('results').update({
          'user_id': params.userId,
          'chl': params.chl,
          'pol': params.pol,
          'u': params.u,
          'test_id': params.testId,
        }).eq('test_id', params.testId);
      }

      return const DataSuccess('');
    } on ServerException catch (e) {
      return DataFailedMessage(e.message.toString());
    }
  }
}
