import 'package:flutter/material.dart';
import 'package:thesis/cubit/course_cubit.dart';
import 'package:thesis/services/data_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesis/widgets/course_list.dart';

class ClassCoursePageWithCubit extends StatelessWidget {
  final dataRepository = DataRepository();

  ClassCoursePageWithCubit({Key? key}) : super(key: key);
  @override

  Widget build(BuildContext context) {
    return BlocProvider<CourseCubit>(
      create: (context) => CourseCubit(dataRepository),
      child: Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(title: const Text("Courses")),
        body: Column(crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(child: CourseList())
        ])
      )
    );

    Container();
  }
}

