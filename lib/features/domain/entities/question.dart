import 'package:equatable/equatable.dart';
import 'package:mspis/features/domain/entities/answer.dart';

class QuestionEntity extends Equatable {
  const QuestionEntity({
    required this.description,
    required this.difficult,
    required this.type,
    required this.rightAnswerId,
    required this.answers,
    this.curAnswer,
  });
  final String description;
  final int difficult;
  final int type;
  final int rightAnswerId;
  final AnswerEntity? curAnswer;
  final List<AnswerEntity> answers;

  @override
  List<Object?> get props {
    return [
      description,
      difficult,
      type,
      rightAnswerId,
      curAnswer,
      rightAnswerId,
      answers
    ];
  }

  QuestionEntity changeAnswer(AnswerEntity answer) {
    return QuestionEntity(
        description: description,
        difficult: difficult,
        type: type,
        curAnswer: answer,
        rightAnswerId: rightAnswerId,
        answers: answers);
  }
}
