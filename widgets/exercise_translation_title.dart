import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesis/cubit/exercise_cubit.dart';

class ExerciseTranslationTitle extends StatelessWidget {
  const ExerciseTranslationTitle({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    TextStyle style = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
    final ExerciseCubit exerciseCubit = context.read<ExerciseCubit>();
    return Text('Write in Russian: ${exerciseCubit.course.language_from}',
        style: style);
  }
}
