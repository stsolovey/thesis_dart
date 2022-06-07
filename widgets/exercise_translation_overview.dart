import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesis/cubit/exercise_cubit.dart';
import 'package:thesis/cubit/exercise_state.dart';

class ExerciseTranslationOverview extends StatelessWidget {
  const ExerciseTranslationOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExerciseCubit, ExerciseState>(builder: (context, state) {
      if (state is ExerciseCheckedRightState) {
        return Column(children: [
          Text('Right answer'),
        ]);
      } else if (state is ExerciseCheckedWrongState) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Text('Your answer:  ${context.read<ExerciseCubit>().text}'),
          Text('Right answer: ${state.loadedExercise.translation}'),
        ]);
      }
      return const SizedBox.shrink();
    });
  }
}

/*Align(
              alignment: Alignment.topLeft,
              child:),*/
