import 'package:equatable/equatable.dart';
import 'package:wo/core/entities/workout.dart';

import '../../core/entities/exercise.dart';

enum DummyScreenStage {
  display,
  loading,
  // error,
}

class DummyScreenState extends Equatable {
  final List<Workout> workoutList;
  final DummyScreenStage stage;


  const DummyScreenState(
      {
        required this.stage,
        required this.workoutList,

      });

  DummyScreenState copyWith(
      {
        DummyScreenStage? stage,
        List<Workout>? workoutList,

     }) {
    return DummyScreenState(
        stage: stage ?? this.stage,
        workoutList: workoutList ?? this.workoutList,
        );
  }

  @override
  List<Object?> get props => [stage,workoutList];
}
