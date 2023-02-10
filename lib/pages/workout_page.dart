import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_tracker/data/workout_data.dart';

import '../components/exercise_tile.dart';

class WorkoutPage extends StatefulWidget {
  final String workoutName;

  const WorkoutPage({Key? key, required this.workoutName}) : super(key: key);

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  // checkbox was tapped
  void onCheckBoxChanged(String workoutName, String exerciseName) {
    Provider.of<WorkoutData>(context, listen: false).checkOffExercise(workoutName, exerciseName);
  }

// text controllers
  final exerciseNameController = TextEditingController();
  final weightNameController = TextEditingController();
  final repsNameController = TextEditingController();
  final setsNameController = TextEditingController();

// create new exercise
  void createNewExercise() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add a new exercise'),
        content: Column(
          children: [
            // exercise name
            TextField(
              controller: exerciseNameController,
            ),
            // weight
            TextField(
              controller: weightNameController,
            ),
            // reps
            TextField(
              controller: repsNameController,
            ),
            // sets
            TextField(
              controller: setsNameController,
            ),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: save,
            child: Text('save'),
          ),
          MaterialButton(
            onPressed: cancel,
            child: Text('cancel'),
          ),
        ],
      ),
    );
  }

  // save exercise
  void save() {
    // get exercise name from text controller
    String newExerciseName = exerciseNameController.text;
    String weight = weightNameController.text;
    String reps = repsNameController.text;
    String sets = setsNameController.text;

    // add exercise to workout data list
    Provider.of<WorkoutData>(context, listen: false).addExercise(
      widget.workoutName,
      newExerciseName,
      weight,
      reps,
      sets,
    );

    // pop dialog box
    Navigator.pop(context);
    clear();
  }

  // cancel exercise
  void cancel() {
    // pop dialog box
    Navigator.pop(context);
    clear();
  }

  // clear controllers
  void clear() {
    exerciseNameController.clear();
    weightNameController.clear();
    repsNameController.clear();
    setsNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text(widget.workoutName),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewExercise,
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: value.numberOfExercisesInWorkout(widget.workoutName),
          itemBuilder: (context, index) => ExerciseTile(
            exerciseName: value.getRelevantWorkout(widget.workoutName).exercises[index].name,
            weight: value.getRelevantWorkout(widget.workoutName).exercises[index].weight,
            reps: value.getRelevantWorkout(widget.workoutName).exercises[index].reps,
            sets: value.getRelevantWorkout(widget.workoutName).exercises[index].sets,
            isCompleted: value.getRelevantWorkout(widget.workoutName).exercises[index].isCompleted,
            onCheckBoxChanged: (val) => onCheckBoxChanged(
              widget.workoutName,
              value.getRelevantWorkout(widget.workoutName).exercises[index].name,
            ),
          ),
        ),
      ),
    );
  }
}
