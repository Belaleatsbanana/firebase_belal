import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_belal/cubit/category_cubit.dart';
import 'package:firebase_belal/cubit/category_state.dart';

class CategoryScreen extends StatelessWidget {
  final String categoryName;
  const CategoryScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      CategoryCubit(categoryName)..getCoursesByCategoryName(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          title: Text(
            categoryName,
          ),
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        body: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CategoryError) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is CategoryLoaded) {
              return Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    if (context.read<CategoryCubit>().courses.isEmpty)
                      const Center(
                        child: Text('No Data'),
                      )
                    else
                      Expanded(
                        child: ListView.builder(
                          itemCount:
                          context.read<CategoryCubit>().courses.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                context
                                    .read<CategoryCubit>()
                                    .courses[index]
                                    .name,
                              ),
                              subtitle: Text(
                                context
                                    .read<CategoryCubit>()
                                    .courses[index]
                                    .description,
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
