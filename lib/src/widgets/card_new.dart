import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:news_repository/news_repository.dart';
import 'package:test_bambu/src/widgets/custom_image_network.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class CardNew extends StatelessWidget {
  const CardNew({required this.newModel, super.key});

  final NewModel newModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CustomImageNetwork(
                  urlImage: newModel.urlToImage,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * .25,
                ),
                _source(context: context),
              ],
            ),
            const SizedBox(height: 8),
            ExpandablePanel(
              header: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _titleNew(),
                  const SizedBox(height: 8),
                  _date(),
                  const SizedBox(height: 8),
                ],
              ),
              collapsed: Text(
                newModel.description ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              expanded: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(newModel.description ?? ''),
                    ElevatedButton(
                      onPressed: () async {
                        final uri = Uri.parse(newModel.url);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri);
                        }
                      },
                      child: const Text('NOTA COMPLETA'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _titleNew() {
    return Text(
      newModel.title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _date() {
    var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    return Text(outputFormat.format(newModel.publishedAt));
  }

  Widget _source({required BuildContext context}) {
    return Positioned(
      bottom: 8,
      left: 8,
      child: Container(
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
      ),
    );
  }
}
