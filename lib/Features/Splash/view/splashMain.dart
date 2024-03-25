import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:nakhil/Core/extensions/widget_ex.dart';
import 'package:nakhil/Features/Splash/controller/videoplayer_controller.dart';
import 'package:video_player/video_player.dart';

class SplashMain extends StatelessWidget {
  const SplashMain({super.key});

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
                : "error".readyText();
          },
        ),
      ),
    );
  }
}
