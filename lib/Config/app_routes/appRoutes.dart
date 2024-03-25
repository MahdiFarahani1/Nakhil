import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:nakhil/Features/home/view/nakhil_home.dart';

class AppRoutes {
  static List<GetPage<dynamic>> pages = [
    GetPage(
      name: NakhilHome.rn,
      page: () => const NakhilHome(),
    )
  ];
}
