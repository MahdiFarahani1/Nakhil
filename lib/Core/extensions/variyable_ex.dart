import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakhil/Core/utils/category.dart';
import 'package:nakhil/Core/widgets/cubit/na_vcon_cubit.dart';

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
