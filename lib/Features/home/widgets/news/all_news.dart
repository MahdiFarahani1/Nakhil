import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:nakhil/Core/const/const_method.dart';
import 'package:nakhil/Core/services/fetchAll/fetch_all_api.dart';
import 'package:nakhil/Core/services/fetchAll/model/title_news_model.dart';
import 'package:nakhil/Core/utils/esay_size.dart';
import 'package:nakhil/Core/utils/format_date.dart';
import 'package:nakhil/Core/utils/loading.dart';
import 'package:nakhil/Features/home/widgets/news/news-item.dart';

class AllNews {
  static Widget news(BuildContext context) {
    return GetBuilder<ServiceController>(
      init: ServiceController(),
      builder: (controller) {
        if (controller.status is Loading) {
          return Expanded(
              child: SizedBox(
                  width: EsaySize.width(context),
                  child: CostumLoading.fadingCircle(context)));
        }
        if (controller.status is Complete) {
          var data = controller.data as TitleNewsModel;

          return Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return NewsItem(
                  id: data.posts![index].id!,
                  time: FormatData.result(data.posts![index].dateTime!),
                  title: data.posts![index].title!,
                  path:
                      "${COnstMethod.baseImageUrlLow}${data.posts![index].img!}",
                );
              },
              itemCount: 20,
            ),
          );
        }
        if (controller.status is Error) {
          return const Center(child: Text("Error"));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
