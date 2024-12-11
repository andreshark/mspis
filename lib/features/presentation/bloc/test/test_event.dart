import 'package:mspis/features/domain/entities/answer.dart';

abstract class TestEvent {
  const TestEvent();
}

class LoadTest extends TestEvent {
  final int id;
  const LoadTest({
    required this.id,
  });
}

class ChooseAnswer extends TestEvent {
  final AnswerEntity answer;
  const ChooseAnswer({required this.answer});
}

class ChooseQuestion extends TestEvent {
  final int questionNum;
  const ChooseQuestion({required this.questionNum});
}

class EndTest extends TestEvent {
  final int userId;
  const EndTest({required this.userId});
}

class TimerTick extends TestEvent {
  const TimerTick();
}
