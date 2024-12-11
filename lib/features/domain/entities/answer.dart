import 'package:equatable/equatable.dart';

class AnswerEntity extends Equatable {
  const AnswerEntity({required this.id, required this.description});
  final String description;
  final int id;

  @override
  List<Object?> get props {
    return [id, description];
  }
}
