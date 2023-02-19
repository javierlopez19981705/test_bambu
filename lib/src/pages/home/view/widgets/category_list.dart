import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_repository/news_repository.dart';
import 'package:test_bambu/src/pages/home/cubit/home_cubit.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int indexSelected = 0;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return SizedBox(
      height: 30.0,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                indexSelected = index;
              });
              context.read<HomeCubit>().getNewsCategory(
                    category: CategoryNew.values[index],
                  );
            },
            child: Container(
              decoration: BoxDecoration(
                color: indexSelected == index ? primaryColor : Colors.white,
                border: Border.all(
                  color: indexSelected == index ? Colors.white : primaryColor,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              alignment: Alignment.center,
              child: Text(
                CategoryNew.values[index].name,
                style: TextStyle(
                  color: indexSelected == index ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        },
        itemCount: CategoryNew.values.length,
      ),
    );
  }
}
