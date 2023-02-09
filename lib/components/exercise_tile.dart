import 'package:flutter/material.dart';

class ExerciseTile extends StatelessWidget {
  final String exerciseName;
  final String weight;
  final String reps;
  final String sets;
  final bool isCompleted;
  void Function(bool?)? onCheckBoxChanged;

  ExerciseTile({
    Key? key,
    required this.exerciseName,
    required this.weight,
    required this.reps,
    required this.sets,
    required this.isCompleted,
    required this.onCheckBoxChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: ListTile(
        title: Text(exerciseName),
        // title: Text(value.getRelevantWorkout(widget.workoutName).exercises[index].name),
        subtitle: Row(
          children: [
            // weight
            Chip(
              label: Text("$weight kg"),
              // label: Text("${value.getRelevantWorkout(widget.workoutName).exercises[index].weight} kg"),
            ),
            // reps
            Chip(
              // label: Text("${value.getRelevantWorkout(widget.workoutName).exercises[index].reps} reps"),
              label: Text("$reps reps"),
            ),
            // sets
            Chip(
              label: Text("$sets sets"),
              // label: Text("${value.getRelevantWorkout(widget.workoutName).exercises[index].sets} sets"),
            ),
          ],
        ),
        trailing: Checkbox(
          value: isCompleted,
          onChanged: (value) => onCheckBoxCanged!(value),
        ),
      ),
    );
  }
}
