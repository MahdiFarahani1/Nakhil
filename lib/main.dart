import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nakhil/Config/gen/assets.gen.dart';
import 'package:nakhil/Config/gen/fonts.gen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "سلام خوبی من تستم",
          style:
              TextStyle(fontSize: 16, color: Colors.amber, fontFamily: "iran"),
        ),
      ),
      body: Column(
        children: [
          const Center(
            child: Text(
              "سلام دوست عزیز گل",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.amber,
                  fontFamily: FontFamily.iran),
            ),
          ),
          Assets.images.header.image(),
        ],
      ),
    );
  }
}
