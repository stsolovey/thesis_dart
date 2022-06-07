import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesis/cubit/course_cubit.dart';

class ActionButtons extends StatelessWidget {
  //const ActionButtons({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    final CourseCubit courseCubit = context.read<CourseCubit>();
    return Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
      ElevatedButton(
          child: Text('Load'),
          onPressed: () {
            courseCubit.fetchCourse();
          },
          style: ElevatedButton.styleFrom(primary: Colors.deepPurpleAccent)),
      SizedBox(width: 8.0),
      ElevatedButton(
          child: Text('Clear'),
          onPressed: () {
            courseCubit.clearCourse();
          },
          style: ElevatedButton.styleFrom(primary: Colors.red)),
    ]);
  }
}
