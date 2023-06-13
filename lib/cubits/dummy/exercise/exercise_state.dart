import 'package:equatable/equatable.dart';

import '../../../core/entities/exercise.dart';

enum ExerciseStateStage {
  display,
  loading,
}

class ExerciseState extends Equatable {
  final List<Exercise> exercise;
  final ExerciseStateStage stage;

  ExerciseState({
    required this.exercise,
    required this.stage,

  });

  ExerciseState copyWith({
    ExerciseStateStage? stage,
    List<Exercise>? excecise,

  }) {
    return ExerciseState(
      stage: stage ?? this.stage,
      exercise: excecise ?? this.exercise,

    );
  }

  @override
  List<Object?> get props => [stage,exercise];
}
