import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesis/cubit/exercise_cubit.dart';
import 'package:thesis/cubit/exercise_state.dart';

class ExerciseTranslationTask extends StatelessWidget {
  const ExerciseTranslationTask({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //TextStyle style = TextStyle(fontSize: 16);
    return BlocBuilder<ExerciseCubit, ExerciseState>(builder: (context, state) {
      if (state is ExerciseLoadedState ) {
        return Text(state.loadedExercise.sentence, );
      } else if (state is ExerciseCheckedRightState){
        return Text(state.loadedExercise.sentence, );
      } else if (state is ExerciseCheckedWrongState){
        return Text(state.loadedExercise.sentence, );
      }
      return const SizedBox.shrink();
    });
  }
}
