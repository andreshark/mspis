import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:mspis/features/domain/entities/question.dart';

abstract class TestState extends Equatable {
  final List<QuestionEntity>? questions;
  final Timer? timer;
  final int? questionNum;
  final Duration? remaining;
  final int? totalScore;
  final double? chl;
  final double? pol;
  final double? u;
  final int? maxScore;

  const TestState(
      {this.questions,
      this.timer,
      this.questionNum,
      this.remaining,
      this.chl,
      this.pol,
      this.u,
      this.totalScore,
      this.maxScore});
}

class TestLoading extends TestState {
  const TestLoading();

  @override
  List<Object> get props => [];
}

class TestResults extends TestState {
  const TestResults(
      {required super.totalScore,
      required super.chl,
      required super.pol,
      required super.u,
      required super.maxScore});

  @override
  List<Object> get props => [chl!, pol!, u!, totalScore!, maxScore!];
}

class LocalDataDone extends TestState {
  const LocalDataDone(
      {required List<QuestionEntity> questions,
      required Timer timer,
      required Duration remaining,
      int questionNum = 0})
      : super(
            questions: questions,
            timer: timer,
            questionNum: questionNum,
            remaining: remaining);

  @override
  List<Object> get props => [questions!, timer!, questionNum!, remaining!];

  LocalDataDone copyWith(
      {List<QuestionEntity>? questions,
      Timer? timer,
      int? questionNum,
      Duration? remaining}) {
    return LocalDataDone(
        questions: questions ?? this.questions!,
        timer: timer ?? this.timer!,
        remaining: remaining ?? this.remaining!,
        questionNum: questionNum ?? this.questionNum!);
  }
}
