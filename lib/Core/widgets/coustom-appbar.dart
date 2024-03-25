import 'package:flutter/material.dart';
import 'package:nakhil/Core/const/const_color.dart';
import 'package:nakhil/Core/gen/assets.gen.dart';

class CommonAppbar {
  static AppBar appBar() {
    return AppBar(
      backgroundColor: ConstColor.baseColor,
      centerTitle: true,
      title: Assets.images.logoTx2.image(),
      leading: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.all(8),
        decoration: decor(),
        child: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: Assets.images.menu.image(),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
      ),
      actions: [
        Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.all(8),
          decoration: decor(),
          child: IconButton(
            icon: Assets.images.search.image(),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  static BoxDecoration decor() {
    return BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(10));
  }
}
