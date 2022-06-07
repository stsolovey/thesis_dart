import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesis/cubit/exercise_cubit.dart';
import 'package:thesis/cubit/exercise_state.dart';
import 'package:thesis/widgets/exercise_translation_check_button.dart';
import 'package:thesis/widgets/exercise_translation_overview.dart';
import 'package:thesis/widgets/exercise_translation_task.dart';
import 'package:thesis/widgets/exercise_translation_text_form_field.dart';
import 'package:thesis/widgets/exercise_translation_title.dart';

class ExerciseTranslation extends StatelessWidget {
  const ExerciseTranslation({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return BlocBuilder<ExerciseCubit, ExerciseState>(builder: (context, state) {
      if (state is ExerciseEmptyState) {
        context.read<ExerciseCubit>().fetchExercise();
        return Center(child: CircularProgressIndicator());
      } else if (state is ExerciseLoadingState) {
        return Center(child: CircularProgressIndicator());
      } else if (state is ExerciseCheckingState) {
        return Center(child: CircularProgressIndicator());
      } else if (state is ExerciseLoadedState ||
          state is ExerciseCheckedRightState ||
          state is ExerciseCheckedWrongState) {
        return RawKeyboardListener(
            autofocus: true,
            focusNode: FocusNode(),
            onKey: (event) {
              if (event is RawKeyDownEvent) {
                if (event.isKeyPressed(LogicalKeyboardKey.enter) ||
                    event.isKeyPressed(LogicalKeyboardKey.numpadEnter)) {
                  context.read<ExerciseCubit>().checkButtonPressed();
                }
              }
            },
            child: Scaffold(
                body: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                  ExerciseTranslationTitle(),
                  ExerciseTranslationTask(),
                  ExerciseTranslationTextFormField(),
                  ExerciseTranslationOverview(),
                  ExerciseCheckButton(),
                ])));
      }

      return const SizedBox.shrink();
    });
  }
}
