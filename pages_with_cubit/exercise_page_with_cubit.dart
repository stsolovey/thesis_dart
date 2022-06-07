import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesis/cubit/exercise_cubit.dart';
import 'package:thesis/models/category_model.dart';
import 'package:thesis/models/course_model.dart';
import 'package:thesis/services/data_repository.dart';
import 'package:thesis/services/exercise_generator.dart';
import 'package:thesis/widgets/exercise_translation.dart';

class ExercisePageWithCubit extends StatelessWidget {
  final dataRepository = DataRepository();
  final exerciseGenerator = ExerciseGenerator();
  final Course course;
  final Category category;

  //final Exercise exercise;

  ExercisePageWithCubit({
    Key? key,
    required this.course,
    required this.category,
    //required this.exercise,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExerciseCubit>(
        create: (context) => ExerciseCubit(
              dataRepository: dataRepository,
              exerciseGenerator: exerciseGenerator,
              course: course,
              category: category,
            ),

        child: ExerciseTranslation(),
        //Column(
        //    crossAxisAlignment: CrossAxisAlignment.center,
        //    children: <Widget>[
        //      ExerciseTranslation(),
        //    ])
            );
    return Container();
  }
}
