import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:wo/core/utils/app_consts.dart';

import '../../../core/entities/exercise.dart';
import '../../../core/entities/workout.dart';
import 'exercise_state.dart';

class ExerciseCubit extends Cubit<ExerciseState> {

  final Workout workout;
  late Box workoutBox;
  late Box exerciseBox;

  ExerciseCubit({required this.workout})
      : super(ExerciseState(
            stage: ExerciseStateStage.display,
            exercise: [],)){
    load();
  }

  load()async {
    workoutBox =  await Hive.openBox<Workout>(workoutBoxName);
    exerciseBox = await  Hive.openBox<Exercise>(exerciseBoxName);


    emit(state.copyWith(excecise: workout.exercise));


  }


  addExercise(Exercise exercise)async{

      final id = await exerciseBox.add(exercise);
      exercise.id = id;
      workout.exercise = HiveList(exerciseBox,objects: [...?workout.exercise, exercise]);

      await workoutBox.putAt(workout.id, workout);

      emit(state.copyWith(excecise: [...state.exercise, exercise]));


  }
}
