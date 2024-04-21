import 'package:flutter_application_1/Core/gen/assets.gen.dart';
import 'package:flutter_application_1/Features/home/view/nakhil_home.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VController extends GetxController {
  late VideoPlayerController _videoController;
  VideoPlayerController get video => _videoController;

  @override
  void onInit() {
    super.onInit();
    _videoController = VideoPlayerController.asset(Assets.videos.splash);
    _videoController.initialize().then((value) {
      _videoController.play();
      update();
    });
    _videoController.addListener(() {
      if (_videoController.value.position == _videoController.value.duration) {
        Get.offAll(const NakhilHome());
      }
    });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }
}
