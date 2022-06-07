import 'package:thesis/models/course_model.dart';

abstract class CategoryState{
}

class CategoryEmptyState extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryLoadedState extends CategoryState {
  List<dynamic> loadedCategory;
  Course course;
  CategoryLoadedState({required this.loadedCategory, required this.course}) : assert(loadedCategory != null, course != null);
}

class CategoryErrorState extends CategoryState {}


