import 'package:flutter/material.dart';
import 'package:news_repository/news_repository.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'custom_image_network.dart';

class CardNewSwiper extends StatelessWidget {
  const CardNewSwiper({required this.newModel, super.key});

  final NewModel newModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final uri = Uri.parse(newModel.url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      },
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CustomImageNetwork(
                  urlImage: newModel.urlToImage,
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(.75),
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _source(context: context),
                    const SizedBox(height: 8),
                    _titleNew(),
                    const SizedBox(height: 8),
                    _date(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _titleNew() {
    return Text(
      newModel.title,
      maxLines: 1,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _date() {
    var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    return Text(
      outputFormat.format(newModel.publishedAt),
      style: const TextStyle(color: Colors.white),
    );
  }

  Widget _source({required BuildContext context}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        newModel.source.name,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white,
        ),
      ),
    );
  }
}
