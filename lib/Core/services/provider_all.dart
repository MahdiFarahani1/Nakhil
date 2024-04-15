import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakhil/Core/widgets/cubit/na_vcon_cubit.dart';

class ProviderAll {
  Future<Response<dynamic>> fetchAllData(
      {required int start,
      required int categoryid,
      required BuildContext context}) async {
    var res = await Dio().get(BlocProvider.of<ControllerApp>(context)
            .state
            .status is Nnews
        ? "https://palms-news.com/api/news?start=$start&limit=20&gid=$categoryid"
        : "https://www.iraqpalm.com/api/news?start=$start&limit=20&gid=$categoryid");
    return res;
  }

  Future<Response<dynamic>> fetchClickData(
      {required int id, required BuildContext context}) async {
    var res = await Dio().post(
        BlocProvider.of<ControllerApp>(context).state.status is Nnews
            ? "https://palms-news.com/api/news/content?&id=$id"
            : "https://www.iraqpalm.com/api/news/content?&id=$id");
    return res;
  }

  Future<Response<dynamic>> fetchArtClickData({
    required BuildContext context,
    required int id,
  }) async {
    var res = await Dio().get(
        BlocProvider.of<ControllerApp>(context).state.status is Nnews
            ? "https://palms-news.com/api/article/content/$id"
            : "https://www.iraqpalm.com/api/article/content/$id");
    return res;
  }

  Future<Response<dynamic>> fetchArtData(
      {required BuildContext context}) async {
    var res = await Dio().post(
        BlocProvider.of<ControllerApp>(context).state.status is Nnews
            ? "https://palms-news.com/api/article"
            : "https://www.iraqpalm.com/api/article");
    return res;
  }
}
