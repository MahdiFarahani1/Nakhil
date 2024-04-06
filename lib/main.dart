import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nakhil/Core/const/const_color.dart';
import 'package:nakhil/Core/services/fetchSearch/cubit/search_cubit.dart';
import 'package:nakhil/Core/services/news_cubit/cubit/news_cubit.dart';
import 'package:nakhil/Features/Splash/view/splashMain.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        ), // BlocProvider(
        //   create: (context) => SearchCubit(),
        // ),
      ],
      child: GetMaterialApp(
        initialRoute: "/",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
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
