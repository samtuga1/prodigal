// import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:prodigal/config/global_configuration.dart';
import 'package:prodigal/injection/injection.dart';

class Initializer {
  static void init(String envConfig, VoidCallback runApp) async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await initializeDependencies(envConfig);
    runApp();
  }

  static Future<void> initializeDependencies(envConfig) async {
    await GlobalConfiguration.instance.loadFromAsset(envConfig);
    await configureDependencies();
  }
}
