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
          exercise: [],
        )) {
    load();
  }

  List<Exercise> getList() {
    List<Exercise> exerciseList = [];
    if (workout.exercise != null && workout.exercise!.length > 0) {
      for (int i = 0; i < workout.exercise!.length; i++) {
        exerciseList.add(
          Exercise(
            name: (workout.exercise?.elementAt(i) as Exercise).name,
            weight: (workout.exercise?.elementAt(i) as Exercise).weight,
            reps: (workout.exercise?.elementAt(i) as Exercise).reps,
            sets: (workout.exercise?.elementAt(i) as Exercise).sets,
            id: i,
            isCompleted:
                (workout.exercise?.elementAt(i) as Exercise).isCompleted,
          ),
        );
      }
    }
    return exerciseList;
  }

  load() async {
    workoutBox = await Hive.openBox<Workout>(workoutBoxName);
    exerciseBox = await Hive.openBox<Exercise>(exerciseBoxName);

    emit(state.copyWith(excecise: workout.exercise));
  }

  addExercise(Exercise exercise) async {
    final id = await exerciseBox.add(exercise);
    exercise.id = id;
    workout.exercise =
        HiveList(exerciseBox, objects: [...?workout.exercise, exercise]);

    await workoutBox.putAt(workout.id, workout);

    emit(state.copyWith(excecise: [...state.exercise, exercise]));
  }

  removeExercise(int index) async {
    // await exerciseBox.deleteAt(index);
    await workout.exercise?.deleteFromHive(index);
    List<Exercise> exerciseList = [];
    if (workout.exercise!.length > 0) {
      for (int i = 0; i < workout.exercise!.length; i++) {
        exerciseList.add(
          Exercise(
            name: (workout.exercise?.elementAt(i) as Exercise).name,
            weight: (workout.exercise?.elementAt(i) as Exercise).weight,
            reps: (workout.exercise?.elementAt(i) as Exercise).reps,
            sets: (workout.exercise?.elementAt(i) as Exercise).sets,
            id: (workout.exercise?.elementAt(i) as Exercise).id,
            isCompleted:
                (workout.exercise?.elementAt(i) as Exercise).isCompleted,
            // (workout.exercise?.elementAt(i) as Exercise).isCompleted,
          ),
        );
      }
    } else {
      exerciseList = [];
    }

    print(state.exercise.length);
    emit(state.copyWith(excecise: exerciseList));
  }

  toggle(Exercise exercise, int index) async {
    await exerciseBox.putAt(index, exercise);
    workout.exercise?[index].isCompleted = exercise.isCompleted;
    workout.exercise?[index].save();
    print('${state.exercise[index].isCompleted}');
    List<Exercise> exerciseList = [];
    if (workout.exercise!.length > 0) {
      for (int i = 0; i < workout.exercise!.length; i++) {
        exerciseList.add(
          Exercise(
            name: (workout.exercise?.elementAt(i) as Exercise).name,
            weight: (workout.exercise?.elementAt(i) as Exercise).weight,
            reps: (workout.exercise?.elementAt(i) as Exercise).reps,
            sets: (workout.exercise?.elementAt(i) as Exercise).sets,
            id: (workout.exercise?.elementAt(i) as Exercise).id,
            isCompleted:
                (workout.exercise?.elementAt(i) as Exercise).isCompleted,
            // (workout.exercise?.elementAt(i) as Exercise).isCompleted,
          ),
        );
      }
    } else {
      exerciseList = [];
    }
    emit(state.copyWith(excecise: exerciseList));
    // await exerciseBox.putAt(index, exercise);
    // print(
    //     '${exerciseBox.getAt(index).name} ${exerciseBox.getAt(index).isCompleted} ${exerciseBox.getAt(index).id}');
    // getList();
    // await state.copyWith(excecise: getList().toList());
    //
    // emit(state.copyWith(excecise: getList().toList()));
  }
}

// await exerciseBox.deleteAt(id);
// List<Exercise> exerciseList = [];
// for (int i = 0; i < exerciseBox.values.length; i++) {
// exerciseList.add(
// Exercise(
// name: (exerciseBox.values.elementAt(i) as Exercise).name,
// weight: (exerciseBox.values.elementAt(i) as Exercise).weight,
// reps: (exerciseBox.values.elementAt(i) as Exercise).reps,
// sets: (exerciseBox.values.elementAt(i) as Exercise).sets,
// id: i,
// isCompleted:
// (exerciseBox.values.elementAt(i) as Exercise).isCompleted,
// ),
// );
// }
// await state.exercise.removeAt(id);
// emit(state.copyWith(excecise: exerciseList));
