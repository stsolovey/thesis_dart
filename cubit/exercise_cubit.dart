import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesis/cubit/exercise_state.dart';
import 'package:thesis/models/category_model.dart';
import 'package:thesis/models/course_model.dart';
import 'package:thesis/models/exercise_model.dart';
import 'package:thesis/models/statistic_model.dart';
import 'package:thesis/services/auth_service.dart';
import 'package:thesis/services/data_repository.dart';
import 'package:thesis/services/exercise_generator.dart';

class ExerciseCubit extends Cubit<ExerciseState> {
  final DataRepository dataRepository;
  final ExerciseGenerator exerciseGenerator;
  final AuthService _authService = AuthService();

  final Course course;
  final Category category;

  String text = "";
  String buttonLabel = 'Check';
  late String exerciseId;
  late Exercise _loadedExercise;

  ExerciseCubit({
    required this.exerciseGenerator,
    required this.dataRepository,
    required this.course,
    required this.category,
  }) : super(ExerciseEmptyState());

  Future<void> fetchExercise() async {
    try {
      emit(ExerciseLoadingState());
      exerciseId = await exerciseGenerator.generateExercise(
          course.course_id, category.category_id);
      _loadedExercise =
          await dataRepository.getExercise(course.course_id, exerciseId);
      emit(
          ExerciseLoadedState(loadedExercise: _loadedExercise, course: course));
    } catch (e) {
      emit(ExerciseErrorState());
    }
  }

  void passValueFromTextEdit(String value) {
    text = value;
  }

  void checkButtonPressed() {
    if (text != "") checkInProcess();
  }

  bool checkAnswer() {
    return _loadedExercise.translation == text;
  }

  void checkInProcess() {
    try {
      emit(ExerciseCheckingState());
      bool rightAnswer = checkAnswer();
      buttonLabel = 'Next';
      addStats(rightAnswer);
      if (rightAnswer) {
        emit(ExerciseCheckedRightState(
            loadedExercise: _loadedExercise, course: course));
      } else {
        emit(ExerciseCheckedWrongState(
            loadedExercise: _loadedExercise, course: course));
      }
    } catch (e) {
      emit(ExerciseErrorState());
    }
  }

  void addStats(answerFlag) {
    String userId = _authService.getCurrentUserUid;
    StatisticModel statistic = StatisticModel(
        userId:userId,
        courseId:course.course_id,
        categoryId:category.category_id,
        exerciseId:_loadedExercise.exercise_id,
        answerFlag:answerFlag
    );
    dataRepository.addStats(statistic);
  }
}
