import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/widgets/cubit/na_vcon_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProviderSearch {
  Future<dynamic> fetchData(
      {required String sw,
      required int sctitle,
      required int sctxt,
      required int categoryID,
      required int start,
      required BuildContext context}) async {
    try {
      var res = await Dio().get(BlocProvider.of<ControllerApp>(context)
              .state
              .status is Nnews
          ? "https://palms-news.com/api/news?start=$start&sw=$sw&sctitle=$sctitle&sctxt=$sctxt&limit=20"
          : "https://iraqpalm.com/api/news?start=$start&sw=$sw&sctitle=$sctitle&sctxt=$sctxt&limit=20");

      if (res.statusCode == 200) {
        return res;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
