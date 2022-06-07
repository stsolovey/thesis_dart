import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesis/cubit/course_state.dart';
import 'package:thesis/models/course_model.dart';
import 'package:thesis/pages_with_cubit/categories_page_with_cubit.dart';
import 'package:thesis/services/auth_service.dart';
import 'package:thesis/services/data_repository.dart';
import 'package:get/get.dart';

class CourseCubit extends Cubit<CourseState>{
  final DataRepository dataRepository;
  final AuthService _authService = AuthService();

  CourseCubit(this.dataRepository) : super(CourseEmptyState());

  Future<void> fetchCourse() async {

    try {
      emit(CourseLoadingState());
      final List<Course> _loadedCoursesList = await dataRepository.getCourses();

      emit(CourseLoadedState(loadedCoursesList: _loadedCoursesList));

    } catch (_) {
      emit(CourseErrorState());
      print(_);
    }
  }

  Future<void> clearCourse() async {
    emit(CourseEmptyState());
  }

  Future<void> toCategories(course) async {
    await dataRepository.setCurrentCourse(course.course_id, _authService.getCurrentUserUid);
    Get.to(CategoriesPageWithCubit(course: course));
  }
}

