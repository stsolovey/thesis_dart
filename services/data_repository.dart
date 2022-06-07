import 'package:thesis/models/category_model.dart';
import 'package:thesis/models/course_model.dart';
import 'package:thesis/models/exercise_model.dart';
import 'package:thesis/services/data_provider.dart';

class DataRepository {
  final DataProvider _dataProvider = DataProvider();


  Future<List<Course>> getCourses() {
    return _dataProvider.getCourse();
  }

  Future<List<Category>> getCategories(courseId) {
    return _dataProvider.getCategory(courseId);
  }

  Future<void> setCurrentCourse(courseId, userId) async {
    //return
      _dataProvider.setCurrentCourse(courseId, userId);
  }


  Future<Exercise> getExercise(courseId, exerciseId) async{
    return _dataProvider.getExercise(courseId, exerciseId);
  }

  Future<void> addStats(statistic) async {
    return _dataProvider.addStats(statistic);
  }

}


