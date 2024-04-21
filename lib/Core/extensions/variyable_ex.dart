import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/utils/category.dart';
import 'package:flutter_application_1/Core/widgets/cubit/na_vcon_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension IntEx on int {
  String categoryCheker(BuildContext context) {
    String result =
        (BlocProvider.of<ControllerApp>(context).state.status is Nnews
                ? categoryIdNews[this]
                : categoryIdAraghi[this]) ??
            "الاخبار";
    return result;
  }
}
