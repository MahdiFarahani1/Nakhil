import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nakhil/Core/const/const_color.dart';
import 'package:nakhil/Core/dataBase/model.dart';
import 'package:nakhil/Core/gen/fonts.gen.dart';
import 'package:nakhil/Core/services/fetchContentApi/cubit/content_cubit.dart';
import 'package:nakhil/Core/services/fetchSearch/cubit/search_cubit.dart';
import 'package:nakhil/Core/services/news_cubit/cubit/news_cubit.dart';
import 'package:nakhil/Core/services/news_cubit/slider-bloc/slider_p_cubit.dart';
import 'package:nakhil/Features/Splash/view/splashMain.dart';
import 'package:nakhil/Features/home/cubit/nav_cubit.dart';
import 'package:nakhil/Features/home/widgets/cubit/select_category_cubit.dart';
import 'package:nakhil/Features/save/cubit/save_news_cubit.dart';
import 'package:nakhil/Features/settings/cubit/settings_cubit.dart';

late Box box;
late Box iconSave;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ItemDatabaseAdapter());

  box = await Hive.openBox<ItemDatabase>("saveitem");
  iconSave = await Hive.openBox("saveicon");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: ConstColor.baseColor,
        systemNavigationBarColor: ConstColor.baseColor));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit(),
        ),
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
        BlocProvider(
          create: (context) => SelectCategoryCubit(),
        ),
        BlocProvider(
          create: (context) => ContentCubit(),
        ),
        BlocProvider(
          create: (context) => NavCubit(),
        ),
        BlocProvider(
          create: (context) => SliderPCubit(),
        ),
        BlocProvider(
          create: (context) => SaveNewsCubit(),
        ),
        BlocProvider(
          create: (context) => SettingsCubit(),
        ),
        //     BlocProvider(
        //   create: (context) => SettingsCubit(),
        // ),
      ],
      child: GetMaterialApp(
        initialRoute: "/",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: FontFamily.bloom,
          primaryColor: ConstColor.baseColor,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
          useMaterial3: true,
        ),
        home: const SplashMain(),
      ),
    );
  }
}
