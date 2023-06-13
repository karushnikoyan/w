import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                "Football Facts",
              ),
              centerTitle: true,
              backgroundColor: AppColors.primary,
            ),
            backgroundColor: AppColors.greenBackGround,
            body: ListView.builder(
              itemCount: cubit.state.workoutList.length,
              itemBuilder: (context, index) {
                return Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 10,),
                      ElevatedButton(
                        onPressed: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context){
                              return ExerciseScreen(
                                  workout: cubit.state.workoutList[index],
                                  exercise: cubit.state.workoutList[index].exercise?.toList() ?? []);
                            })
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.workoutButton,
                          elevation: 0,
                          foregroundColor: Colors.white,
                          shadowColor: Colors.transparent
                        ),
                        child: Container(
                          width: size.width * 0.7,
                          height: size.height * 0.08,

                          child: Center(
                            child: Text(cubit.state.workoutList[index].name,overflow: TextOverflow.ellipsis,),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0,)
                    ],
                  )
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
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
              child: Icon(Icons.add),
            ),
          ),
        ),
        onWillPop: () async {
          return false;
        });
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
                    ),)
              ],
            ),
            backgroundColor: AppColors.modalBackground,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 30.0,
                  ),
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(
                        hintText: "Type...",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 2.0),
                            borderRadius: BorderRadius.circular(10.0))),
                  )
                ],
              ),
            ),
          );
        });
    return result;
  }
}
