import 'exercise.dart';
import 'package:hive/hive.dart';

part 'workout.g.dart';


@HiveType(typeId: 1)
class Workout {

  @HiveField(0)
  int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  HiveList<Exercise>? exercise;

  Workout({
    required this.name,
    this.id = 0,
    this.exercise});
}
