import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesis/cubit/exercise_cubit.dart';

class ExerciseCheckButton extends StatelessWidget {
  const ExerciseCheckButton({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    final ExerciseCubit exerciseCubit = context.read<ExerciseCubit>();
    return TextButton(
          child: Text(exerciseCubit.buttonLabel),
          onPressed: () {
            exerciseCubit.checkButtonPressed();
          },
        );
  }
}
