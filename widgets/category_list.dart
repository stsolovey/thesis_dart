import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thesis/cubit/category_cubit.dart';
import 'package:thesis/cubit/category_state.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CategoryCubit categoryCubit = context.read<CategoryCubit>();
    return BlocBuilder<CategoryCubit, CategoryState>(builder: (context, state) {
      if (state is CategoryEmptyState) {
        context.read<CategoryCubit>().fetchCategory();
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state is CategoryLoadingState) {
        return const Center(child: CircularProgressIndicator());
      }

      if (state is CategoryLoadedState) {
        return ListView.builder(
          itemCount: state.loadedCategory.length,
          itemBuilder: (context, index) => Card(
            child: ListTile(
              // leading: Text("${state.loadedCategory[index].weight.toString()}."),
              enabled: state.loadedCategory[index].weight <= 2 ? true : false,
              title: Row(children: [
                Expanded(
                  child: Text(
                      '${state.loadedCategory[index].weight.toString()}. ${state.loadedCategory[index].category_name}'),
                ),
              ]),
              onTap: (){
                categoryCubit.toExercise(state.loadedCategory[index]);
              }
            ),
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }
}
