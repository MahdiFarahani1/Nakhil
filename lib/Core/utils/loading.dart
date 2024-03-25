import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CostumLoading {
  static Widget loadCircle(BuildContext context) {
    return SpinKitRipple(
      itemBuilder: (context, index) {
        return const DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blueAccent,
          ),
        );
      },
    );
  }

  static Widget loadLine(BuildContext context) {
    return SpinKitThreeInOut(
      size: 35,
      itemBuilder: (context, index) {
        return const DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.blueAccent,
          ),
        );
      },
    );
  }

  static Widget fadingCircle(BuildContext context) {
    return SpinKitFadingCircle(
      size: 35,
      itemBuilder: (context, index) {
        return const DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.blueAccent,
          ),
        );
      },
    );
  }
}
