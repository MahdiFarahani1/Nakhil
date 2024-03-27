import 'package:flutter/material.dart';
import 'package:nakhil/Core/utils/esay_size.dart';
import 'package:nakhil/Features/home/widgets/category/category-item.dart';

class Cat {
  static SizedBox category(BuildContext context) {
    return SizedBox(
      width: EsaySize.width(context),
      height: 40,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return const CatItem();
        },
        itemCount: 8,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
