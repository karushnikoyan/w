import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wo/core/entities/workout.dart';
import 'package:wo/view/dummy/workout/exercises_screen.dart';

import '../../core/utils/snackBar.dart';
import '../../core/utils/style.dart';
import '../../cubits/dummy/dummy_cubit.dart';
import '../../cubits/dummy/dummy_state.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DummyScreenCubit>(
        create: (_) => DummyScreenCubit(),
        child: BlocBuilder<DummyScreenCubit, DummyScreenState>(
          builder: (context, state) {
            switch (state.stage) {
              case DummyScreenStage.display:
                return DisplayWorkoutScreen();
              case DummyScreenStage.loading:
                return Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        ));
  }
}

class DisplayWorkoutScreen extends StatelessWidget {
  const DisplayWorkoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DummyScreenCubit>();
    final size = MediaQuery.of(context).size;

    return WillPopScope(
        child: SafeArea(
          bottom: false,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                "Workout",
              ),
              centerTitle: true,
              backgroundColor: AppColors.primary,
            ),
            backgroundColor: AppColors.greenBackGround,
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/9aa-1.png",
                    ),
                    fit: BoxFit.cover),
              ),
              child: Padding(
                //54.0
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width / 7.4),
                child: ListView.builder(
                  itemCount: cubit.state.workoutList.length,
                  itemBuilder: (context, index) {
                    Workout item = cubit.state.workoutList[index];
                    return Dismissible(
                      key: UniqueKey(),
                      confirmDismiss: (DismissDirection direction) async {
                        return await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor:
                                  AppColors.cOcean.withOpacity(0.7),
                              title: const Text("Confirm"),
                              content: const Text(
                                  "Are you sure you wish to delete this item?"),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: const Text("CANCEL"),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.redAccent),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    await cubit.removeWorkout(index);
                                    Navigator.of(context).pop(true);
                                  },
                                  child: const Text("DELETE"),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.greenAccent),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      onDismissed: (direction) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${item.name} is deleted'),
                          ),
                        );
                      },
                      background: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Expanded(
                          child: Container(
                            // width:  40,
                            // size.height * 0.20,
                            color: AppColors.cRed,
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      child: Center(
                          child: Column(
                        children: [
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  return ExerciseScreen(
                                      workout: cubit.state.workoutList[index],
                                      exercise: cubit
                                              .state.workoutList[index].exercise
                                              ?.toList() ??
                                          []);
                                }),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.cOcean,
                                elevation: 0,
                                foregroundColor: Colors.white60,
                                shadowColor: Colors.transparent),
                            child: Container(
                              width: size.width * 0.6,
                              height: size.height * 0.06,
                              child: Center(
                                child: Text(
                                  cubit.state.workoutList[index].name,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          )
                        ],
                      )),
                    );
                  },
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.cOcean,
              onPressed: () async {
                final result = await showModal(context);
                if (result == null) {
                  return;
                }
                try {
                  cubit.addWorkout(result as String);
                } catch (e) {
                  showSnackBar(context, Colors.green, "Something went wrong");
                }
              },
              child: Icon(
                Icons.add,
                color: Colors.white60,
              ),
            ),
          ),
        ),
        onWillPop: () async {
          return false;
        },
    );
  }

  showModal(BuildContext context) async {
    final result = await showModalBottomSheet(
        context: context,
        builder: (context) {
          TextEditingController controller = TextEditingController();
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: AppColors.primary,
              centerTitle: true,
              title: Text("Create new workout"),
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
                    Navigator.of(context).pop(controller.text);
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
              child: Container(
                height: 430,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/women.png",
                      ),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: controller,
                        onSubmitted: (_) {
                          Navigator.of(context).pop(controller.text);
                        },
                        decoration: InputDecoration(
                          hintText: "Type...",
                          filled: true,
                          fillColor: AppColors.cOcean,
                          border: OutlineInputBorder(
                            // borderSide: BorderSide(width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
    return result;
  }
}
