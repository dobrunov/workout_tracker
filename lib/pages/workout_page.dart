import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_tracker/constants/decoration_constants.dart';
import 'package:workout_tracker/data/workout_data.dart';

import '../components/dialog_field_widget.dart';
import '../components/exercise_tile.dart';
import '../constants/color_constants.dart';
import '../constants/text_styles.dart';

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
          mainAxisSize: MainAxisSize.min,
          children: [
            // exercise name
            DialogFieldWidget(
              controller: exerciseNameController,
              hintText: 'exercise name',
            ),
            // weight
            DialogFieldWidget(
              controller: weightNameController,
              hintText: 'weight',
            ),
            // reps
            DialogFieldWidget(
              controller: repsNameController,
              hintText: 'reps',
            ),
            // sets
            DialogFieldWidget(
              controller: setsNameController,
              hintText: 'sets',
            ),
          ],
        ),
        actions: [
          Padding(
            padding: paddingLeftRight15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // cancel button
                MaterialButton(
                  color: red500,
                  onPressed: cancelExercise,
                  child: const Text(
                    'cancel',
                    style: buttonTextStyle,
                  ),
                ),

                // save button
                MaterialButton(
                  color: green500,
                  onPressed: saveExercise,
                  child: const Text(
                    'save',
                    style: buttonTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // save exercise
  void saveExercise() {
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
  void cancelExercise() {
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
          backgroundColor: green500,
          title: Text(widget.workoutName),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.builder(
                itemCount: value.numberOfExercisesInWorkout(widget.workoutName),
                itemBuilder: (context, index) => Padding(
                  padding: tilePadding,
                  child: ExerciseTile(
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
            ),
            // add button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: green500,
                fixedSize: Size(
                  MediaQuery.of(context).size.width * 0.95,
                  50.0,
                ),
              ),
              onPressed: createNewExercise,
              child: const Text(
                'ADD EXERCISE',
                style: buttonTextStyle,
              ),
            ),
            const SizedBox(
              height: 1,
            ),
          ],
        ),
      ),
    );
  }
}
