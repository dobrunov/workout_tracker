import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_tracker/models/workout.dart';
import 'package:workout_tracker/pages/workout_page.dart';

import '../components/heat_map.dart';
import '../data/workout_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Provider.of<WorkoutData>(context, listen: false).initializeWorkoutList();
  }

  // text controller
  final newWorkoutNameController = TextEditingController();

  // create a new workout
  void createNewWorkout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Create new workout"),
        content: TextField(
          controller: newWorkoutNameController,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // cancel button
                MaterialButton(
                  color: Colors.red[500],
                  onPressed: cancel,
                  child: const Text('cancel'),
                ),

                // save button
                MaterialButton(
                  color: Colors.green[500],
                  onPressed: save,
                  child: const Text('save'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // go to workout page
  void goToWorkoutPage(String workoutName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkoutPage(
          workoutName: workoutName,
        ),
      ),
    );
  }

  // save workout
  void save() {
    // get workout name from text controller
    String newWorkoutName = newWorkoutNameController.text;
    // add workout to workout data list
    Provider.of<WorkoutData>(context, listen: false).addWorkout(newWorkoutName);

    // pop dialog box
    Navigator.pop(context);
    clear();
  }

  // cancel workout
  void cancel() {
    // pop dialog box
    Navigator.pop(context);
    clear();
  }

  // clear controllers
  void clear() {
    newWorkoutNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            backgroundColor: Colors.green[500],
            title: const Text('Workout tracker'),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.green[500],
            onPressed: createNewWorkout,
            child: const Icon(Icons.add),
          ),
          body: ListView(
            children: [
              // HEAT MAP
              MyHeatMap(
                datasets: value.heatMapDataSet,
                startDateYYYYMMDD: value.getStartDate(),
              ),

              // Workout list
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.getWorkoutList().length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.green[100],
                    child: ListTile(
                      title: Text(value.getWorkoutList()[index].name),
                      trailing: IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: () => goToWorkoutPage(value.getWorkoutList()[index].name),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
