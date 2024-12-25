import 'dart:convert';
import 'package:flutter/services.dart';

class GlobalConfiguration {
  static GlobalConfiguration? _instance;

  static GlobalConfiguration instance = _instance ??= GlobalConfiguration();

  late Map<String, dynamic> appConfig = {};

  Future<GlobalConfiguration> loadFromAsset(String envConfig) async {
    //load json configuration from asset
    String content = await rootBundle.loadString('assets/cfg/$envConfig.json');
    Map<String, dynamic> configMap = jsonDecode(content);
    appConfig.addAll(configMap);

    print(appConfig);

    return this;
  }
}
