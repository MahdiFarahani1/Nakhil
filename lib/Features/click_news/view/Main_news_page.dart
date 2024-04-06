import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nakhil/Core/const/const_color.dart';
import 'package:nakhil/Core/const/const_method.dart';
import 'package:nakhil/Core/extensions/variyable_ex.dart';
import 'package:nakhil/Core/gen/assets.gen.dart';
import 'package:nakhil/Core/services/fetchContentApi/fetchClickApi.dart';
import 'package:nakhil/Core/services/fetchContentApi/model/content_model.dart';
import 'package:nakhil/Core/utils/esay_size.dart';
import 'package:nakhil/Core/utils/format_date.dart';
import 'package:nakhil/Core/utils/loading.dart';
import 'package:nakhil/Core/widgets/costum_drawer.dart';
import 'package:nakhil/Core/widgets/coustom-appbar.dart';
import 'package:nakhil/Core/widgets/navbar.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class MainPage extends StatefulWidget {
  final int id;
  const MainPage({super.key, required this.id});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  void fetchData() async {
    var controll = Get.put(ServiceClickController());
    await controll.fetchData(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CommonAppbar.appBar(context,
            isCickMode: true, textEditingController: textEditingController),
        drawer: CostumDrawer.customDrawer(context),
        bottomNavigationBar: NavBarCommon.navigation(),
        body: GetBuilder<ServiceClickController>(
          builder: (controller) {
            if (controller.status is ClickLoading) {
              return Center(
                child: CostumLoading.fadingCircle(context),
              );
            }
            if (controller.status is ClickError) {
              return const Text("error");
            }
            if (controller.status is ClickComplete) {
              var data = controller.data as ContentModel;
              String content = data.post![0].content!;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(60)),
                      child: CachedNetworkImage(
                        imageUrl:
                            "${COnstMethod.baseImageUrlHight}${data.post![0].img}",
                        fit: BoxFit.cover,
                        width: EsaySize.width(context),
                        height: EsaySize.height(context) / 3.5,
                        placeholder: (context, url) {
                          return Center(
                            child: CostumLoading.fadingCircle(context),
                          );
                        },
                      ),
                    ),
                    titleUi(
                        title: data.post![0].title!,
                        time: data.post![0].dateTime!,
                        category: data.post![0].categoryId!.categoryCheker()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: HtmlWidget('''
  <div style="text-align: justify;">
    $content
  </div>
  '''),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget titleUi(
      {required int time, required String title, required String category}) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  maxLines: 3,
                  title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                EsaySize.gap(8),
                Container(
                  width: 140,
                  height: 1,
                  color: const Color.fromRGBO(142, 201, 51, 1),
                ),
                EsaySize.gap(8),
                Row(
                  children: [
                    Text(
                      category,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    EsaySize.gap(6),
                    const Text(
                      "__",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    EsaySize.gap(6),
                    Text(
                      FormatData.result(time),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    )
                  ],
                )
              ],
            ),
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                      color: ConstColor.baseColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Assets.images.share.image(),
                ),
              ),
              EsaySize.gap(12),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                      color: ConstColor.baseColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Assets.images.save1.image(),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
