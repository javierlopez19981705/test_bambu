import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_repository/news_repository.dart';
import 'package:test_bambu/src/pages/search/cubit/search_cubit.dart';
import 'package:test_bambu/src/pages/search/view/widgets/list_search.dart';

class SearchView extends StatelessWidget {
  const SearchView({required this.query, super.key});

  final String query;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SearchCubit(repository: context.read<NewsRepository>())
            ..initSearch(query: query),
      child: _view(context: context),
    );
  }

  Widget _view({required BuildContext context}) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        switch (state.status) {
          case SearchStatus.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case SearchStatus.success:
            return ListSearch(news: state.news);

          case SearchStatus.error:
            return const Center(
              child: Text('Ha ocurrido un error'),
            );
          case SearchStatus.loadingMore:
            return ListSearch(
              news: state.news,
              loadingMore: true,
            );
        }
      },
    );
  }
}
