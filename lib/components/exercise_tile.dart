import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../constants/decoration_constants.dart';
import '../constants/text_styles.dart';

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
      color: green100,
      child: Padding(
        padding: tilePadding,
        child: ListTile(
          title: Text(exerciseName, style: tileHeaderTextStyle),
          subtitle: Row(
            children: [
              // weight
              Chip(
                label: Text("$weight kg", style: chipsTextStyle),
                backgroundColor: green200,
              ),
              gapWith5,
              // reps
              Chip(
                label: Text("$reps reps", style: chipsTextStyle),
                backgroundColor: green200,
              ),
              gapWith5,
              // sets
              Chip(
                label: Text("$sets sets", style: chipsTextStyle),
                backgroundColor: green200,
              ),
            ],
          ),
          trailing: Checkbox(
            activeColor: green500,
            value: isCompleted,
            onChanged: (value) => onCheckBoxChanged!(value),
          ),
        ),
      ),
    );
  }
}
