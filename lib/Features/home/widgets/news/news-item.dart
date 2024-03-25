import 'package:flutter/material.dart';
import 'package:nakhil/Core/const/const_color.dart';
import 'package:nakhil/Core/extensions/layout_ex.dart';
import 'package:nakhil/Core/utils/esay_size.dart';

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
      child: Row(
        children: [
          Container(
            width: EsaySize.width(context) / 3.2,
            height: EsaySize.height(context) / 7.6,
            decoration: 10.0.decor(ConstColor.baseColor),
          ),
          EsaySize.gap(14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const Text(
                "",
              ),
              Text(
                time,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          const Spacer(),
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
                      image: NetworkImage(
                    path,
                  )),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
