import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_repository/news_repository.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:test_bambu/src/pages/home/cubit/home_cubit.dart';
import 'package:test_bambu/src/pages/home/cubit/home_state.dart';
import 'package:test_bambu/src/pages/home/view/widgets/category_list.dart';
import 'package:test_bambu/src/pages/search/view/custom_search_delegate.dart';
import 'package:test_bambu/src/utils/fonts_styles.dart';
import 'package:test_bambu/src/widgets/card_new.dart';
import 'package:test_bambu/src/widgets/swiper_news.dart';

import '../../login/cubit/auth_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey[900],
        child: const MenuDrawer(),
      ),
      body: const BodyHomeView(),
    );
  }
}

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 128.0,
              height: 128.0,
              margin: const EdgeInsets.only(
                top: 24.0,
                bottom: 16,
              ),
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                color: Colors.black26,
                shape: BoxShape.circle,
              ),
              child: Image.network(
                state.user.photo ??
                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                fit: BoxFit.cover,
              ),
            ),
            Text(
              state.user.name ?? '',
              style: headingStyleBold.copyWith(color: Colors.white),
            ),
            Text(
              state.user.uid,
              style: captionStyle.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              state.user.email ?? '',
              style: bodyStyle.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              'Usuario desde:',
              style: bodyStyle.copyWith(color: Colors.white),
            ),
            Text(
              state.user.date.toString(),
              style: const TextStyle(color: Colors.white),
            ),
            const Spacer(),
            ListTile(
              onTap: () {
                context.read<AuthCubit>().logout();
              },
              leading: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title: const Text(
                'Cerrar sesion',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}

class BodyHomeView extends StatelessWidget {
  const BodyHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(
        newsRepository: context.read<NewsRepository>(),
      )..getNews(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          switch (state.status) {
            case HomeStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case HomeStatus.success:
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  MultiSliver(
                    children: [
                      SwiperNews(news: state.newsHeader.reversed.toList()),
                    ],
                  ),
                  SliverPinnedHeader(
                    child: Column(
                      children: const [
                        SizedBox(height: 8),
                        CategoryList(),
                        SizedBox(height: 8),
                        Text(
                          'Mas noticias',
                          style: headingStyleBold,
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                  SliverClip(
                    child: MultiSliver(
                      children: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return CardNew(
                                newModel: state.news[index],
                              );
                            },
                            childCount: state.news.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            //
            case HomeStatus.error:
              return const Center(
                child: Text('Ha ocurrido un error'),
              );
            case HomeStatus.loadingCategory:
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  MultiSliver(
                    children: [
                      SwiperNews(news: state.newsHeader.reversed.toList()),
                    ],
                  ),
                  SliverPinnedHeader(
                    child: Column(
                      children: const [
                        SizedBox(height: 8),
                        CategoryList(),
                        SizedBox(height: 8),
                        Text(
                          'Mas noticias',
                          style: headingStyleBold,
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                  SliverClip(
                    child: MultiSliver(
                      children: const [
                        SizedBox(
                          height: 200,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}
