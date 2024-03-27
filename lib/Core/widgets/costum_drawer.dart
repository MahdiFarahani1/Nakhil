import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nakhil/Core/const/const_color.dart';
import 'package:nakhil/Core/extensions/layout_ex.dart';
import 'package:nakhil/Core/gen/assets.gen.dart';
import 'package:nakhil/Core/utils/esay_size.dart';
import 'package:nakhil/Features/home/view/articles.dart';

class CostumDrawer {
  static Widget customDrawer(BuildContext context) {
    ButtonStyle styleBtn() {
      return ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          fixedSize: const Size(130, 30),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))));
    }

    TextStyle stlebtnText() {
      return const TextStyle(color: Colors.black);
    }

    return Align(
      alignment: Alignment.bottomRight,
      child: Builder(builder: (context) {
        return Container(
          width: EsaySize.width(context) / 1.8,
          height: EsaySize.height(context) -
              (Scaffold.of(context).appBarMaxHeight!),
          decoration: 10.0.decor(ConstColor.itemBackground),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.only(topLeft: Radius.circular(10)),
                    color: ConstColor.baseColor,
                  ),
                  width: EsaySize.width(context) / 1.8,
                  height: 220,
                  child: Assets.images.mainLogo.image(),
                ),
              ),
              EsaySize.gap(25),
              ElevatedButton(
                onPressed: () {},
                style: styleBtn(),
                child: Text(
                  "الرئيسية",
                  style: stlebtnText(),
                ),
              ),
              EsaySize.gap(8),
              ElevatedButton(
                onPressed: () {},
                style: styleBtn(),
                child: Text(
                  "الاخبار",
                  style: stlebtnText(),
                ),
              ),
              EsaySize.gap(8),
              ElevatedButton(
                onPressed: () {
                  Get.to(const Articles(), transition: Transition.leftToRight);
                },
                style: styleBtn(),
                child: Text(
                  "المقالات",
                  style: stlebtnText(),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
