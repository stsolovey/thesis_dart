

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesis/cubit/category_cubit.dart';
import 'package:thesis/cubit/category_state.dart';

class CategoryAppBar extends StatelessWidget with PreferredSizeWidget {
  const CategoryAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
      if (state is CategoryEmptyState){
        return AppBar(title: Text("Empty"));
      }
      else if (state is CategoryLoadingState){
        return AppBar(title: Text("Empty"));
      }else if (state is CategoryLoadedState){
        return AppBar(title: Text(state.course.course_name));
      }
      return const SizedBox.shrink();
    });
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
