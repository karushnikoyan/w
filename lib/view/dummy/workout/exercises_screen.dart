import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wo/core/entities/workout.dart';
import 'package:wo/core/utils/snackBar.dart';
import 'package:wo/cubits/dummy/dummy_cubit.dart';
import 'package:wo/cubits/dummy/exercise/exercise_cubit.dart';
import 'package:wo/cubits/dummy/exercise/exercise_state.dart';

import '../../../core/entities/exercise.dart';
import '../../../core/utils/style.dart';

class ExerciseScreen extends StatelessWidget {
  final List<Exercise> exercise;
  final Workout workout;

  const ExerciseScreen(
      {Key? key, required this.exercise, required this.workout})
      : super(key: key);










  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExerciseCubit>(
        create: (_) =>
            ExerciseCubit(workout: workout),
        child: BlocBuilder<ExerciseCubit, ExerciseState>(
          builder: (context, state) {
            switch (state.stage) {
              case ExerciseStateStage.display:
                return ExerciseDisplayScreen();
              case ExerciseStateStage.loading:
                return Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        ));
  }
}

class ExerciseDisplayScreen extends StatelessWidget {
  const ExerciseDisplayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = context.read<ExerciseCubit>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            cubit.workout.name,
            style: AppTextStyle.titleSmall,
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppColors.content,
        ),
        backgroundColor: AppColors.greenBackGround,
        body: ListView.builder(
            itemCount: cubit.state.exercise.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: size.width,
                    height: size.height * 0.2,
                    decoration:
                        BoxDecoration(color: AppColors.exerciseBackground),
                    child: Column(
                      children: [
                        Text(cubit.state.exercise[index].name),
                        Text(cubit.state.exercise[index].weight),
                        Text(cubit.state.exercise[index].reps),
                        Text(cubit.state.exercise[index].sets),


                      ],
                    ),

                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await showModal(context);
            if (result == null){
              return;
            }


            cubit.addExercise(result);
          },
          child: Icon(Icons.add_circle_outlined),
        ),
      ),
    );
  }

  showModal(BuildContext context) async {
    return await showModalBottomSheet(
        context: context,
        builder: (context) {
          TextEditingController nameController = TextEditingController();
          TextEditingController weightController = TextEditingController();
          TextEditingController repsController = TextEditingController();
          TextEditingController setsController = TextEditingController();
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: AppColors.primary,
              centerTitle: true,
              title: Text("Create new exercise"),
              leading: IconButton(
                icon: Icon(
                  Icons.dangerous,
                  color: Colors.red,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    if(nameController.text == ''){
                      showSnackBar(context, Colors.red, "Enter title");
                      return;
                    }

                      var exercise = Exercise(
                          name: nameController.text,
                          weight: weightController.text,
                          reps: repsController.text,
                          sets: setsController.text);


                    Navigator.of(context).pop(exercise);
                  },
                  icon: Icon(
                    Icons.done_outline,
                    color: Colors.green,
                  ),
                )
              ],
            ),
            backgroundColor: AppColors.modalBackground,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30.0,
                  ),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                        hintText: "Title",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 2.0),
                            borderRadius: BorderRadius.circular(10.0))),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: weightController,
                    decoration: InputDecoration(
                        hintText: "Weight",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 2.0),
                            borderRadius: BorderRadius.circular(10.0))),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: repsController,
                    decoration: InputDecoration(
                        hintText: "Reps",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 2.0),
                            borderRadius: BorderRadius.circular(10.0))),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: setsController,
                    decoration: InputDecoration(
                        hintText: "Sets",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 2.0),
                            borderRadius: BorderRadius.circular(10.0))),
                  ),
                ],
              ),
            ),
          );
        });


  }
}
