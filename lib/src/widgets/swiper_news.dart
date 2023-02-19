import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:news_repository/news_repository.dart';
import 'package:test_bambu/src/widgets/card_new_swiper.dart';

class SwiperNews extends StatelessWidget {
  const SwiperNews({required this.news, super.key});

  final List<NewModel> news;

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return CardNewSwiper(newModel: news[index]);
      },
      itemCount: news.length,
      itemWidth: MediaQuery.of(context).size.width,
      itemHeight: MediaQuery.of(context).size.height * .35,
      layout: SwiperLayout.TINDER,
    );
  }
}
