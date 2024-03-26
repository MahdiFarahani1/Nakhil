import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nakhil/Core/const/const_color.dart';
import 'package:nakhil/Core/extensions/layout_ex.dart';
import 'package:nakhil/Core/gen/assets.gen.dart';
import 'package:nakhil/Core/utils/esay_size.dart';
import 'package:nakhil/Core/utils/loading.dart';

class NewsItem extends StatelessWidget {
  final String path;
  final String title;
  final String time;
  const NewsItem(
      {super.key, required this.path, required this.title, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
          Align(
            alignment: Alignment.bottomLeft,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.only(left: 8, bottom: 8),
                width: 27,
                height: 27,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    image: DecorationImage(
                        image: AssetImage(Assets.images.save.path))),
              ),
            ),
          )
        ],
      ),
    );
  }
}
