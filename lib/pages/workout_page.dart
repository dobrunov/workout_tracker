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

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text(widget.workoutName),
        ),
        body: ListView.builder(
          itemCount: value.numberOfExercisesInWorkout(widget.workoutName),
          itemBuilder: (context, index) => ExerciseTile(
            exerciseName: value.getRelevantWorkout(widget.workoutName).exercises[index].name,
            weight: value.getRelevantWorkout(widget.workoutName).exercises[index].weight,
            reps: value.getRelevantWorkout(widget.workoutName).exercises[index].reps,
            sets: value.getRelevantWorkout(widget.workoutName).exercises[index].sets,
            isCompleted: value.getRelevantWorkout(widget.workoutName).exercises[index].isCompleted,
            onCheckBoxChanged: (value) => onCheckBoxChanged(
              widget.workoutName,
              (value?.getRelevantWorkout(widget.workoutName).exercises[index].name),
            ),
          ),
        ),
      ),
    );
  }
}
