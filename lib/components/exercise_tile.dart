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
      color: Colors.green[100],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(exerciseName),
          // title: Text(value.getRelevantWorkout(widget.workoutName).exercises[index].name),
          subtitle: Row(
            children: [
              // weight
              Chip(
                label: Text("$weight kg"),
                backgroundColor: Colors.green[200],
                // label: Text("${value.getRelevantWorkout(widget.workoutName).exercises[index].weight} kg"),
              ),
              // reps
              Chip(
                // label: Text("${value.getRelevantWorkout(widget.workoutName).exercises[index].reps} reps"),
                label: Text("$reps reps"),
                backgroundColor: Colors.green[200],
              ),
              // sets
              Chip(
                label: Text("$sets sets"),
                backgroundColor: Colors.green[200],
                // label: Text("${value.getRelevantWorkout(widget.workoutName).exercises[index].sets} sets"),
              ),
            ],
          ),
          trailing: Checkbox(
            activeColor: Colors.green[500],
            value: isCompleted,
            onChanged: (value) => onCheckBoxChanged!(value),
          ),
        ),
      ),
    );
  }
}
