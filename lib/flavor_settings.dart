
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify/core/shared_preference.dart';
import 'package:spotify/core/utils/app_url.dart';

enum FlavorType { PROD, DEV }
FlavorType flavorEnv = FlavorType.DEV;

class FlavorSettings {
  FlavorSettings() {}
  static Future<void> init(FlavorType flavor) async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    UserPreferences.prefs = await SharedPreferences.getInstance();

    switch (flavor) {
      case FlavorType.PROD:
        flavor = FlavorType.PROD;
        FlavorConfig(variables: {"baseUrl": AppUrl.liveBaseURL});
        break;
      default:
        flavor = FlavorType.DEV;
        FlavorConfig(
            name: "TEST",
            color: Colors.red,
            location: BannerLocation.topStart,
            variables: {"baseUrl": AppUrl.qaBaseURL});
    }
  }

  static String get apiBaseUrl {
    return FlavorConfig.instance.variables['baseUrl'];
  }

}
