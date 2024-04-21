import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/widgets/cubit/na_vcon_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class COnstMethod {
  String baseImageUrlLow({required BuildContext context}) {
    return BlocProvider.of<ControllerApp>(context).state.status is Nnews
        ? "https://palms-news.com/upload_list/thumbs/"
        : "https://iraqpalm.com/upload_list/thumbs/";
  }

  String baseImageUrlHight({required BuildContext context}) {
    return BlocProvider.of<ControllerApp>(context).state.status is Nnews
        ? "https://palms-news.com/upload_list/source/"
        : "https://iraqpalm.com/upload_list/source/";
  }
}
