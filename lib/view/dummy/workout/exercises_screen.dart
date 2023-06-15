import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:wo/core/entities/workout.dart';
import 'package:wo/core/utils/app_consts.dart';
import 'package:wo/core/utils/snackBar.dart';
import 'package:wo/cubits/dummy/dummy_cubit.dart';
import 'package:wo/cubits/dummy/exercise/exercise_cubit.dart';
import 'package:wo/cubits/dummy/exercise/exercise_state.dart';
import 'package:wo/view/dummy/workout/widgets/capsul_widget.dart';

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
        create: (_) => ExerciseCubit(workout: workout),
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

class ExerciseDisplayScreen extends StatefulWidget {
  const ExerciseDisplayScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseDisplayScreen> createState() => _ExerciseDisplayScreenState();
}

class _ExerciseDisplayScreenState extends State<ExerciseDisplayScreen> {
  bool checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = context.watch<ExerciseCubit>();
    cubit.load();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            cubit.workout.name,
            style: AppTextStyle.titleSmallWhite,
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppColors.primary,
        ),
        backgroundColor: AppColors.greenBackGround,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/gantel.png",
                ),
                fit: BoxFit.cover),
          ),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowIndicator();
              return false;
            },
            child: ListView.builder(

                itemCount: cubit.state.exercise.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width / 30),
                    child: Dismissible(
                      key: UniqueKey(),
                      confirmDismiss: (DismissDirection direction) async {
                        return await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Confirm"),
                              content: const Text(
                                  "Are you sure you wish to delete this item?"),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: const Text("CANCEL"),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.cancel),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    await cubit.removeExercise(index);
                                    Navigator.of(context).pop(true);
                                  },
                                  child: const Text("DELETE"),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.apply),
                                ),
                              ],
                            );
                          },
                        );
                      },

                      direction: DismissDirection.endToStart,

                      background: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: size.width * 0.80,
                                height: size.height / 6
                                ,
                                decoration: BoxDecoration(
                                    color: AppColors.cOrange,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20.0)
                                  ),


                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Padding(
                                        padding: const EdgeInsets.all(00.0),
                                        child: Wrap(
                                          // crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                           Padding(
                                             padding: const EdgeInsets.all(4.0),
                                             child: Container(
                                                 decoration : BoxDecoration(
                                               color : Colors.white30 ,
                                               borderRadius: BorderRadius.all(
                                                   Radius.circular(30.0)
                                               ),
                                             ),child: Padding(
                                               padding: const EdgeInsets.only(left: 10,right: 10,top: 4,bottom: 4),
                                               child: Text(cubit.state.exercise[index].name,style: TextStyle(fontSize: 22 ,color: Colors.white60),),
                                             )),
                                           ),



                                            Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Container( decoration : BoxDecoration(
                                                color : Colors.white30 ,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30.0)
                                                ),
                                              ),child: Padding(
                                                padding: const EdgeInsets.only(left: 10,right: 10,top: 4,bottom: 4),
                                                child: Text(cubit.state.exercise[index].weight,style: TextStyle(fontSize: 22 ,color: Colors.white60),),
                                              )),
                                            ),


                                            Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Container( decoration : BoxDecoration(
                                                color : Colors.white30 ,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30.0)
                                                ),
                                              ),child: Padding(
                                                padding: const EdgeInsets.only(left: 10,right: 10,top: 4,bottom: 4),
                                                child: Text(cubit.state.exercise[index].reps,style: TextStyle(fontSize: 22 ,color: Colors.white60),),
                                              )),
                                            ),



                                            Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Container( decoration : BoxDecoration(
                                                color : Colors.white30 ,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30.0)
                                                ),
                                              ),child: Padding(
                                                padding: const EdgeInsets.only(left: 10,right: 10,top: 4,bottom: 4),
                                                child: Text(cubit.state.exercise[index].sets,style: TextStyle(fontSize: 22 ,color: Colors.white60),),
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Checkbox(
                                        activeColor: AppColors.cGray,
                                          value: cubit.state.exercise[index].isCompleted,
                                          onChanged: (toggle) {
                                            cubit.toggle(
                                                Exercise(
                                                  name: cubit.state.exercise[index].name,
                                                  weight: cubit.state.exercise[index].weight,
                                                  reps: cubit.state.exercise[index].reps,
                                                  sets: cubit.state.exercise[index].sets,
                                                  id: cubit.state.exercise[index].id,
                                                  isCompleted: toggle!,
                                                ),
                                                index);
                                          }),
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                          // Checkbox(
                          //     value: cubit.state.exercise[index].isCompleted,
                          //     onChanged: (toggle) {
                          //       cubit.toggle(
                          //           Exercise(
                          //             name: cubit.state.exercise[index].name,
                          //             weight: cubit.state.exercise[index].weight,
                          //             reps: cubit.state.exercise[index].reps,
                          //             sets: cubit.state.exercise[index].sets,
                          //             id: cubit.state.exercise[index].id,
                          //             isCompleted: toggle!,
                          //           ),
                          //           index);
                          //     }),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.cOrange,
          onPressed: () async {
            final result = await showModal(context);
            if (result == null) {
              return;
            }

            cubit.addExercise(result);
          },
          child: Icon(
            Icons.add_circle_outlined,
            color: Colors.white60,
          ),
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
                    if (nameController.text == '') {
                      showSnackBar(context, Colors.red, "Enter title");
                      return;
                    }
                    double? wg = double.tryParse(weightController.text);
                    int? rps = int.tryParse(repsController.text);
                    int? sts = int.tryParse(setsController.text);
                    if (wg == null && (weightController.text != "")) {
                      showSnackBar(context, Colors.red,"Not valid weight value");
                      return;
                    }
                    if (rps == null && (repsController.text != "")) {
                      showSnackBar(context, Colors.red,"Not valid reps value");
                      return;
                    }
                    if (sts == null && (setsController.text != "")) {
                      showSnackBar(context, Colors.red,"Not valid sets value");
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

            body: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/boy_drink.png",),
                    fit: BoxFit.cover),

                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30.0,
                      ),
                      TextField(
                        controller: nameController,
                            style: TextStyle(color: Colors.white60),
                        decoration: InputDecoration(
                            fillColor: AppColors.cOrange,filled:true,
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
                        style: TextStyle(color: Colors.white60),

                        decoration: InputDecoration(
                            fillColor: AppColors.cOrange,filled:true,
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
                        style: TextStyle(color: Colors.white60),

                        decoration: InputDecoration(
                            fillColor: AppColors.cOrange,filled:true,
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
                        style: TextStyle(color: Colors.white60),

                      decoration: InputDecoration(
                          fillColor: AppColors.cOrange,filled:true,
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
