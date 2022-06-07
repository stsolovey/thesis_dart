import 'package:thesis/models/course_model.dart';
import 'package:thesis/models/exercise_model.dart';

abstract class ExerciseState{}

class ExerciseEmptyState extends ExerciseState{}
class ExerciseLoadingState extends ExerciseState{}
class ExerciseLoadedState extends ExerciseState{
  final Exercise loadedExercise;
  final Course course;
  ExerciseLoadedState({required this.loadedExercise, required this.course});
}
class ExerciseCheckingState extends ExerciseState{}

class ExerciseCheckedRightState extends ExerciseState{
  final Exercise loadedExercise;
  final Course course;
  ExerciseCheckedRightState({required this.loadedExercise, required this.course});
}

class ExerciseCheckedWrongState extends ExerciseState{
  final Exercise loadedExercise;
  final Course course;
  ExerciseCheckedWrongState({required this.loadedExercise, required this.course});
}

class ExerciseErrorState extends ExerciseState{}