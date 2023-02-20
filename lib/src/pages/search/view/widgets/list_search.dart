import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_repository/news_repository.dart';
import 'package:test_bambu/src/pages/search/cubit/search_cubit.dart';

import '../../../../widgets/card_new.dart';

class ListSearch extends StatelessWidget {
  ListSearch({
    super.key,
    required this.news,
    this.loadingMore = false,
  });

  final List<NewModel> news;
  final bool loadingMore;
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final size = (MediaQuery.of(context).size.height);

    controller.addListener(() {
      if (controller.offset > (controller.position.maxScrollExtent - size)) {
        context.read<SearchCubit>().loadMoreNews();
      }
    });

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      controller: controller,
      itemBuilder: (context, index) {
        if (loadingMore) {
          if (index == news.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return CardNew(
              newModel: news[index],
            );
          }
        } else {
          return CardNew(
            newModel: news[index],
          );
        }
      },
      itemCount: loadingMore ? (news.length + 1) : news.length,
    );
  }
}
