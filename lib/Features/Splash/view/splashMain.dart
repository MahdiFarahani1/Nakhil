import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:nakhil/Core/const/const_color.dart';
import 'package:nakhil/Core/utils/esay_size.dart';
import 'package:nakhil/Features/Splash/controller/videoplayer_controller.dart';
import 'package:nakhil/Features/settings/cubit/settings_cubit.dart';
import 'package:video_player/video_player.dart';

class SplashMain extends StatefulWidget {
  const SplashMain({super.key});

  @override
  State<SplashMain> createState() => _SplashMainState();
}

class _SplashMainState extends State<SplashMain> {
  @override
  void initState() {
    BlocProvider.of<SettingsCubit>(context).initSetting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GetBuilder<VController>(
          init: VController(),
          initState: (_) {},
          builder: (controller) {
            return controller.video.value.isInitialized
                ? VideoPlayer(controller.video)
                : Container(
                    width: EsaySize.width(context),
                    height: EsaySize.height(context),
                    color: ConstColor.baseColor,
                  );
          },
        ),
      ),
    );
  }
}
