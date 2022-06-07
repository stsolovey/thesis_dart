abstract class CourseState{}

class CourseEmptyState extends CourseState {}

class CourseLoadingState extends CourseState {}

class CourseLoadedState extends CourseState {
  List<dynamic> loadedCoursesList;
  CourseLoadedState({required this.loadedCoursesList}) : assert(loadedCoursesList != null);
}

class CourseErrorState extends CourseState {}