import 'package:flutter/material.dart';
import 'package:thesis/cubit/category_cubit.dart';
import 'package:thesis/models/course_model.dart';
import 'package:thesis/services/data_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesis/widgets/category_appbar.dart';
import 'package:thesis/widgets/category_list.dart';

class CategoriesPageWithCubit extends StatelessWidget {
  final dataRepository = DataRepository();
  final Course course;

  CategoriesPageWithCubit({
    Key? key,
    required this.course,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryCubit>(
        create: (context) => CategoryCubit(
            dataRepository: dataRepository,
            course: course
        ),
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: CategoryAppBar(),//AppBar(title: Text(course.course_name)),
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: CategoryList()),
                ]
            )
        )
    );
  }
}
