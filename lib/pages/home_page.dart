import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_tracker/constants/decoration_constants.dart';
import 'package:workout_tracker/pages/workout_page.dart';

import '../components/dialog_field_widget.dart';
import '../components/heat_map.dart';
import '../constants/color_constants.dart';
import '../constants/text_styles.dart';
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
        content: DialogFieldWidget(
          controller: newWorkoutNameController,
          hintText: 'workout name',
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
                  onPressed: cancelWorkout,
                  child: const Text(
                    'cancel',
                    style: buttonTextStyle,
                  ),
                ),

                // save button
                MaterialButton(
                  color: green500,
                  onPressed: saveWorkout,
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
  void saveWorkout() {
    // get workout name from text controller
    String newWorkoutName = newWorkoutNameController.text;
    // add workout to workout data list
    Provider.of<WorkoutData>(context, listen: false).addWorkout(newWorkoutName);
    // pop dialog box
    Navigator.pop(context);
    clear();
  }

  // cancel workout
  void cancelWorkout() {
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
        backgroundColor: grey100,
        appBar: AppBar(
          backgroundColor: green500,
          title: const Text('Workout tracker'),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView(
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
                      padding: tilePadding,
                      child: Container(
                        color: green100,
                        child: ListTile(
                          title: Text(value.getWorkoutList()[index].name, style: tileHeaderTextStyle),
                          trailing: IconButton(
                            icon: const Icon(Icons.arrow_forward),
                            onPressed: () => goToWorkoutPage(value.getWorkoutList()[index].name),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
              onPressed: createNewWorkout,
              child: const Text(
                'ADD WORKOUT',
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
