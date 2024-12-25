import 'package:flutter/material.dart';
import 'package:prodigal/src/home/home_screen.dart';
import 'package:prodigal/src/landing/landing_screen.dart';
import 'package:prodigal/src/modules/screens/cakes_screen.dart';
import 'package:prodigal/src/speech/screens/speech2text_screen.dart';
import 'package:prodigal/src/speech/screens/text2speech_screen.dart';
import 'package:prodigal/src/voice_chat/screens/voice_chat_detail.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) => switch (settings.name) {
        '/' => route(const LandingScreen()),
        HomeScreen.route => route(const HomeScreen()),
        VoiceChatDetailScreen.route => route(const VoiceChatDetailScreen()),
        Speech2TextScreen.route => route(const Speech2TextScreen()),
        Text2speechScreen.route => route(const Text2speechScreen()),
        CakesScreen.route => route(const CakesScreen(), settings: settings),
        _ => route(Container()),
      };

  static Route route(Widget routeWidget, {RouteSettings? settings, bool slideUp = false, bool fade = false}) {
    if (slideUp) {
      return PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (context, animation, secondary) {
          return SlideTransition(
            position: CurvedAnimation(parent: animation, curve: Curves.easeInOut).drive(
              Tween(
                begin: const Offset(0, 1),
                end: const Offset(0, 0),
              ),
            ),
            child: routeWidget,
          );
        },
      );
    }

    if (fade) {
      return PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (context, animation, secondary) {
          return FadeTransition(
            opacity: animation,
            child: routeWidget,
          );
        },
      );
    }

    return MaterialPageRoute(settings: settings, builder: (context) => routeWidget);
  }
}
