import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prodigal/gen/assets.gen.dart';
import 'package:prodigal/src/speech/screens/speech2text_screen.dart';
import 'package:prodigal/src/speech/screens/text2speech_screen.dart';
import 'package:prodigal/src/speech/widgets/speech_item.dart';
import 'package:prodigal/utils/extensions.dart';

class SpeechScreen extends StatelessWidget {
  const SpeechScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLightMode = context.theme.brightness == Brightness.light;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 30),
      child: Row(
        children: [
          Flexible(
            child: SpeechContainer(
              label: 'Speech2Text',
              onTap: () => Navigator.of(context).pushNamed(Speech2TextScreen.route),
              icon: const Icon(
                Icons.mic,
              ),
              assetPath: isLightMode ? Assets.images.speechContainer1.path : Assets.images.speechContainerDark1.path,
            ),
          ),
          16.horizontalSpace,
          Flexible(
            child: SpeechContainer(
              label: 'Text2Speech',
              onTap: () => Navigator.of(context).pushNamed(Text2speechScreen.route),
              icon: const Icon(Icons.text_fields_outlined),
              assetPath: isLightMode ? Assets.images.speechContainer2.path : Assets.images.speechContainerDark2.path,
            ),
          ),
        ],
      ),
    );
  }
}
