import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thesis/cubit/course_cubit.dart';
import 'package:thesis/cubit/course_state.dart';
import 'package:thesis/pages_with_cubit/categories_page_with_cubit.dart';

class CourseList extends StatelessWidget {


  //const UserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CourseCubit courseCubit = context.read<CourseCubit>();
    return BlocBuilder<CourseCubit, CourseState>(
      builder: (context, state) {
        if (state is CourseEmptyState){
          context.read<CourseCubit>().fetchCourse();
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is CourseLoadingState){
          return Center(child: CircularProgressIndicator());
        }

        if (state is CourseLoadedState){
          return ListView.builder(
            itemCount: state.loadedCoursesList.length,
            itemBuilder: (context, index) => Container(
              child: Card(
                //key: Key(state.loadedCourse[index].id),
                child: ListTile(
                  leading: Icon(
                      state.loadedCoursesList[index].type == 'lingvo' ?
                      FontAwesomeIcons.comments : FontAwesomeIcons.squareRootVariable
                  ),
                  title: Row(children: [
                    Expanded(
                      child: Text(state.loadedCoursesList[index].course_name),
                    ),
                    Text(state.loadedCoursesList[index].language_from),
                    const Text('-'),
                    Text(state.loadedCoursesList[index].language_to),
                  ]),
                  onTap: (){
                    courseCubit.toCategories(
                        state.loadedCoursesList[index]
                    );
                  },
                ),
              )
            ),
          );
        }
        return SizedBox.shrink();
      }
    );
  }
}
