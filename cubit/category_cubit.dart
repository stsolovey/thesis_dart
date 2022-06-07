import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:thesis/cubit/category_state.dart';
import 'package:thesis/models/category_model.dart';
import 'package:thesis/models/course_model.dart';
import 'package:thesis/pages_with_cubit/exercise_page_with_cubit.dart';
import 'package:thesis/services/data_repository.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final DataRepository dataRepository;
  final Course course;

  CategoryCubit({
    required this.course,
    required this.dataRepository,
  }) : super(CategoryEmptyState());

  Future<void> fetchCategory() async {
    try {
      emit(CategoryLoadingState());
      final List<Category> _loadedCategoriesList =
          await dataRepository.getCategories(course.course_id);

      emit(CategoryLoadedState(
          loadedCategory: _loadedCategoriesList, course: course)
      );
    } catch (_) {
      emit(CategoryErrorState());
      print(_);
    }
  }

  Future<void> clearCategory() async {
    emit(CategoryEmptyState());
  }

  Future<void> toExercise(category) async {
    Get.to(ExercisePageWithCubit(course: course, category: category));
  }
}
