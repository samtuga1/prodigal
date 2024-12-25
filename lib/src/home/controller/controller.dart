import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prodigal/src/home/state.dart';
import 'package:prodigal/src/modules/screens/index.dart';
import 'package:prodigal/src/speech/screens/index.dart';
import 'package:prodigal/src/voice_chat/screens/voice_chat_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'controller.g.dart';

@Riverpod(keepAlive: true)
class HomeController extends _$HomeController {
  @override
  HomeState build() {
    [Permission.microphone].request();
    return HomeState();
  }

  final pages = [
    (page: const VoiceChatScreen(), title: 'Voice Chat', icon: const Icon(Icons.ring_volume_rounded)),
    (page: const SpeechScreen(), title: 'Speech', icon: const Icon(Icons.mic)),
    (page: const ModulesScreen(), title: 'Modules & Cakes', icon: const Icon(Icons.menu_book_rounded)),
  ];

  void switchPage(int index) => state = state.copyWith(selected: index);
}
