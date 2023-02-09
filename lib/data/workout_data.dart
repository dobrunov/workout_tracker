import 'package:workout_tracker/models/exercise.dart';
import 'package:workout_tracker/models/workout.dart';

class WorkoutData {
  /*
  WORKOUT DATA STRUCTURE
   - this overall list contains te different workouts
   - each workout has a name, and list of exercises
  */

  List<Workout> workoutList = [
    // default workout
    Workout(
      name: "Upper Body",
      exercises: [
        Exercise(
          name: "Bicep Curls",
          weight: "10",
          reps: "10",
          sets: "3",
        ),
      ],
    ),
  ];

  // get the list of workouts

  // add a workout

  // add an exercise to a workout

  // check off exercise

  // get length of a given workout
}
