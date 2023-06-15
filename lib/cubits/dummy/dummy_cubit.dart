import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:wo/core/entities/exercise.dart';
import 'package:wo/core/entities/workout.dart';
import 'dummy_state.dart';

class DummyScreenCubit extends Cubit<DummyScreenState> {
  late Box workoutBox;
  late Box exerciseBox;

  DummyScreenCubit()
      : super(DummyScreenState(
            stage: DummyScreenStage.loading, workoutList: [])) {
    load();
  }

  load() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(WorkoutAdapter());
    }
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ExerciseAdapter());
    }
    // Hive.deleteBoxFromDisk("Workout");
    // Hive.deleteBoxFromDisk("Exercise");
    workoutBox = await Hive.openBox<Workout>("Workout");
    exerciseBox = await Hive.openBox<Exercise>("Exercise");

    List<Workout> workoutList = [];
    for (int i = 0; i < workoutBox.values.length; i++) {
      workoutList.add(Workout(
          name: (workoutBox.values.elementAt(i) as Workout).name,
          id: i,
          exercise: (workoutBox.values.elementAt(i) as Workout).exercise));
    }

    emit(state.copyWith(
        stage: DummyScreenStage.display, workoutList: workoutList));
  }

  addWorkout(String name) async {
    if (name == '') {
      return;
    }
    final Workout workout = Workout(name: name);
    final int id = await workoutBox.add(workout);
    emit(state.copyWith(workoutList: [...state.workoutList, workout..id = id]));
  }

  removeWorkout(int id) async {
    await workoutBox.deleteAt(id);

    await state.workoutList.removeAt(id);
    emit(state.copyWith(workoutList: [...state.workoutList]));
  }

  f() async {
    var exercise =
        Exercise(name: "name", weight: "weight", reps: "reps", sets: "sets");
    await exerciseBox.add(exercise);
    workoutBox.put(
        "Workout1",
        Workout(
            name: "workoutnaem",
            exercise: HiveList(exerciseBox, objects: [exercise])));

    Workout o = await workoutBox.get("Workout1");

    exerciseBox.clear();
    workoutBox.clear();
  }
}
