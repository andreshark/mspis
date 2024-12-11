import 'dart:async';
import 'package:mspis/features/domain/usecases/Load_test.dart';
import 'package:mspis/features/domain/usecases/add_test_result.dart';
import '../../../domain/entities/question.dart';
import 'test_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/resources/data_state.dart';
import 'test_event.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  final LoadTestUseCase _loadTestUseCase;
  final AddTestResultUseCase _addTestResultUseCase;
  final _testId;

  TestBloc(this._loadTestUseCase, this._addTestResultUseCase, this._testId)
      : super(const TestLoading()) {
    on<LoadTest>(loadTest);
    on<ChooseAnswer>(chooseAnswer);
    on<ChooseQuestion>(chooseQuestion);
    on<TimerTick>(timerTick);
    on<EndTest>(endTest);
  }

  void endTest(EndTest event, Emitter<TestState> emit) {
    int totalScore = 0;
    double pol = 0;
    double chl = 0;
    double u = 0;
    int maxPol = state.questions!
        .where((question) => question.type == 2)
        .map((question) => question.difficult)
        .reduce((value, element) => value + element);
    int maxChl = state.questions!
        .where((question) => question.type == 1)
        .map((question) => question.difficult)
        .reduce((value, element) => value + element);
    int maxU = state.questions!
        .where((question) => question.type == 3)
        .map((question) => question.difficult)
        .reduce((value, element) => value + element);
    int maxScore = state.questions!
        .map((question) => question.difficult)
        .reduce((value, element) => value + element);

    for (QuestionEntity question in state.questions!) {
      if (question.curAnswer?.id == question.rightAnswerId) {
        totalScore += question.difficult;
        question.type == 1
            ? chl += question.difficult / maxChl
            : question.type == 2
                ? pol += question.difficult / maxPol
                : u += question.difficult / maxU;
      }
    }

    _addTestResultUseCase(
        params: ResultParams(
            testId: _testId, userId: event.userId, pol: pol, chl: chl, u: u));

    state.timer!.cancel();
    emit(TestResults(
        totalScore: totalScore, chl: chl, pol: pol, u: u, maxScore: maxScore));
  }

  void timerTick(TimerTick event, Emitter<TestState> emit) {
    emit((state as LocalDataDone).copyWith(
        remaining: Duration(seconds: state.remaining!.inSeconds - 1)));
  }

  void chooseAnswer(ChooseAnswer event, Emitter<TestState> emit) {
    List<QuestionEntity> questions = List.from(state.questions!);
    questions[state.questionNum!] =
        questions[state.questionNum!].changeAnswer(event.answer);
    emit((state as LocalDataDone).copyWith(questions: questions));
  }

  void chooseQuestion(ChooseQuestion event, Emitter<TestState> emit) {
    emit((state as LocalDataDone).copyWith(questionNum: event.questionNum));
  }

  void loadTest(LoadTest event, Emitter<TestState> emit) async {
    final DataState<List<QuestionEntity>> dataState =
        await _loadTestUseCase(params: event.id);
    if (dataState is DataSuccess) {
      Duration duration = Duration(
          minutes: dataState.data!
              .map((question) => question.difficult)
              .reduce((value, element) => value + element));

      emit(LocalDataDone(
          remaining: duration,
          questions: dataState.data!,
          timer: Timer.periodic(const Duration(seconds: 1),
              (Timer timer) => add(const TimerTick()))));
    }
  }
}
