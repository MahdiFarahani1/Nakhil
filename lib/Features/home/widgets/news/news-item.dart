import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nakhil/Core/const/const_color.dart';
import 'package:nakhil/Core/extensions/layout_ex.dart';
import 'package:nakhil/Core/gen/fonts.gen.dart';
import 'package:nakhil/Core/utils/esay_size.dart';
import 'package:nakhil/Core/utils/loading.dart';
import 'package:nakhil/Features/click_news/view/Main_news_page.dart';

class NewsItem extends StatelessWidget {
  final String path;
  final String title;
  final String time;
  final int id;
  const NewsItem(
      {super.key,
      required this.path,
      required this.title,
      required this.time,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
            MainPage(
              isArtMode: false,
              id: id,
            ),
            arguments: false,
            transition: Transition.leftToRight);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: 10.0.decor(ConstColor.itemBackground),
        width: EsaySize.width(context),
        height: EsaySize.height(context) / 7.2,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 4),
              child: SizedBox(
                width: EsaySize.width(context) / 3.2,
                height: EsaySize.height(context) / 7.6,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: path,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) {
                      return const Center(
                        child: Icon(Icons.error),
                      );
                    },
                    placeholder: (context, url) {
                      return Center(
                        child: CostumLoading.loadCircle(context),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              child: Padding(
                padding: EdgeInsets.only(
                    right: EsaySize.width(context) / 3, left: 8, top: 8),
                child: Text(
                  title,
                  maxLines: 3,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 16.5,
                    fontFamily: FontFamily.neue,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 4, left: 50),
                child: Text(
                  time,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
