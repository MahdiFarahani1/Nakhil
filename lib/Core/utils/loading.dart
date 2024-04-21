import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/const/const_color.dart';
import 'package:flutter_application_1/Core/widgets/cubit/na_vcon_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CostumLoading {
  static Widget loadCircle(BuildContext context) {
    return BlocBuilder<ControllerApp, NaVconState>(
      builder: (context, state) {
        return SpinKitRipple(
          itemBuilder: (context, index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: state.status is Araghi
                    ? ConstColor.baseColor
                    : ColorNakhil.item,
              ),
            );
          },
        );
      },
    );
  }

  static Widget loadLine(BuildContext context) {
    return BlocBuilder<ControllerApp, NaVconState>(
      builder: (context, state) {
        return SpinKitThreeInOut(
          size: 35,
          itemBuilder: (context, index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: state.status is Araghi
                    ? ConstColor.baseColor
                    : ColorNakhil.item,
              ),
            );
          },
        );
      },
    );
  }

  static Widget fadingCircle(BuildContext context) {
    return BlocBuilder<ControllerApp, NaVconState>(
      builder: (context, state) {
        return SpinKitFadingCircle(
          size: 35,
          itemBuilder: (context, index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: state.status is Araghi
                    ? ConstColor.baseColor
                    : ColorNakhil.item,
              ),
            );
          },
        );
      },
    );
  }
}
