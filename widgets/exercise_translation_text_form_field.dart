import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesis/cubit/exercise_cubit.dart';
import 'package:thesis/cubit/exercise_state.dart';

class ExerciseTranslationTextFormField extends StatelessWidget {
  ExerciseTranslationTextFormField({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    EdgeInsets padding = EdgeInsets.symmetric(
        vertical: 0.0,
        horizontal: 50.0);
    TextEditingController controller = TextEditingController();
    controller.addListener(() {
      final String text = controller.text.replaceAll('\n', '');
      controller.value = controller.value.copyWith(
        text: text,
        selection:
        TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
    return BlocBuilder<ExerciseCubit, ExerciseState>(builder: (context, state) {
      if (state is ExerciseLoadedState) {
        return Padding(padding: padding,
            child: TextFormField(
            controller: controller,
            decoration: new InputDecoration(
              hintText: "Type in Russian: ${state.course.language_from}",
            ),
            keyboardType: TextInputType.multiline,
            maxLines: null,
            onChanged: (value) {
              context.read<ExerciseCubit>().passValueFromTextEdit(value);
            }));
      }
      if (state is ExerciseCheckedRightState ||
          state is ExerciseCheckedWrongState) {
        return Padding(padding: padding,
            child: TextFormField(
          enabled: false,
          initialValue: context.read<ExerciseCubit>().text,
          keyboardType: TextInputType.multiline,
          maxLines: null,
        ));
      }
      return const SizedBox.shrink();
    });
  }
}
