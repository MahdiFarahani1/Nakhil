import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/const/const_color.dart';
import 'package:flutter_application_1/Core/const/const_method.dart';
import 'package:flutter_application_1/Core/dataBase/model.dart';
import 'package:flutter_application_1/Core/extensions/variyable_ex.dart';
import 'package:flutter_application_1/Core/gen/assets.gen.dart';
import 'package:flutter_application_1/Core/services/fetchContentApi/cubit/content_cubit.dart';
import 'package:flutter_application_1/Core/services/fetchContentApi/model/content_model.dart';
import 'package:flutter_application_1/Core/utils/esay_size.dart';
import 'package:flutter_application_1/Core/utils/format_date.dart';
import 'package:flutter_application_1/Core/utils/loading.dart';
import 'package:flutter_application_1/Core/widgets/costum_drawer.dart';
import 'package:flutter_application_1/Core/widgets/coustom-appbar.dart';
import 'package:flutter_application_1/Core/widgets/cubit/na_vcon_cubit.dart';
import 'package:flutter_application_1/Core/widgets/navbar.dart';
import 'package:flutter_application_1/Features/save/cubit/save_news_cubit.dart';
import 'package:flutter_application_1/Features/settings/cubit/settings_cubit.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:share/share.dart';

// ignore: must_be_immutable
class MainPage extends StatefulWidget {
  final int id;
  bool isArtMode;
  MainPage({super.key, required this.id, this.isArtMode = false});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool iconSelect = false;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    iconSelect = iconSave.get("iconSelect${widget.id}") ?? false;
    BlocProvider.of<ContentCubit>(context).fetchData(
      context: context,
      id: widget.id,
    );
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CommonAppbar.appBar(context,
            isCickMode: true, textEditingController: textEditingController),
        drawer: CostumDrawer.customDrawer(context),
        bottomNavigationBar: NavBarCommon.navigation(context),
        body: BlocBuilder<ContentCubit, ContentState>(
          builder: (context, state) {
            if (state.status is ClickLoading) {
              return Center(
                child: CostumLoading.fadingCircle(context),
              );
            }
            if (state.status is ClickError) {
              return const Text("error");
            }
            if (state.status is ClickComplete) {
              var data = state.data as ContentModel;
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
                            "${COnstMethod().baseImageUrlHight(context: context)}${data.post![0].img}",
                        fit: BoxFit.cover,
                        width: EsaySize.width(context),
                        height: EsaySize.height(context) / 3.5,
                        errorWidget: (context, url, error) {
                          return const Center(
                            child: Icon(Icons.error),
                          );
                        },
                        placeholder: (context, url) {
                          return Center(
                            child: CostumLoading.fadingCircle(context),
                          );
                        },
                      ),
                    ),
                    titleUi(
                        id: data.post![0].id!,
                        title: data.post![0].title!,
                        time: data.post![0].dateTime!,
                        category:
                            data.post![0].categoryId!.categoryCheker(context),
                        img:
                            "${COnstMethod().baseImageUrlHight(context: context)}${data.post![0].img}",
                        isArtMode: Art.isAretMode),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: BlocBuilder<SettingsCubit, SettingsState>(
                        builder: (context, state) {
                          return HtmlWidget(
                            '''
                        <div style="text-align: justify;">
                          $content
                        </div>
                        ''',
                            textStyle: TextStyle(
                                fontSize: state.fontsizeContent.toDouble()),
                          );
                        },
                      ),
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
      {required int time,
      required String title,
      required String category,
      required String img,
      required int id,
      required bool isArtMode}) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<SettingsCubit, SettingsState>(
                  builder: (context, state) {
                    return Text(
                      maxLines: 3,
                      title,
                      style: TextStyle(
                          fontSize: state.fontsizeTitle.toDouble(),
                          fontWeight: FontWeight.w600,
                          color: Color(state.titleColor)),
                    );
                  },
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
                onTap: () {
                  isArtMode
                      ? Share.share(BlocProvider.of<ControllerApp>(context)
                              .state
                              .status is Nnews
                          ? "https://palms-news.com/a$id"
                          : "https://www.iraqpalm.com/ar/a$id")
                      : Share.share(BlocProvider.of<ControllerApp>(context)
                              .state
                              .status is Nnews
                          ? "https://palms-news.com/n$id"
                          : "https://www.iraqpalm.com/ar/n$id");
                },
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
              StatefulBuilder(
                builder: (context, setState) {
                  return GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          // if (isFavorite) {
                          //   OperatorDatabase.addDatabase(
                          //       context:
                          //           context,
                          //       view:
                          //           view);
                          // } else {
                          //   OperatorDatabase.deleteDatabsae(
                          //       id: view[
                          //               0]
                          //           .id!,
                          //       context:
                          //           context);
                          // }
                          if (!iconSelect) {
                            iconSave.put("iconSelect${widget.id}", true);
                          } else {
                            iconSave.delete("iconSelect${widget.id}");
                          }
                          iconSelect = !iconSelect;
                        },
                      );

                      var model = ItemDatabase(
                          img: img,
                          time: time,
                          title: title,
                          id: id,
                          tag: BlocProvider.of<ControllerApp>(context)
                                  .state
                                  .status is Araghi
                              ? "a"
                              : "n");

                      bool exists =
                          box.values.any((element) => element.id == model.id);

                      if (!exists) {
                        box.add(model);
                      } else {
                        for (var value in box.values) {
                          if (value.id == model.id) {
                            var keyToRemove = box.keys.firstWhere(
                                (key) => box.get(key) == value,
                                orElse: () => null);
                            if (keyToRemove != null) {
                              box.delete(keyToRemove);
                            }
                          }
                        }
                      }
                      BlocProvider.of<SaveNewsCubit>(context).loadSave(context);
                    },
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                          color: ConstColor.baseColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Icon(
                        !iconSelect
                            ? Icons.bookmark_add_outlined
                            : Icons.bookmark,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
