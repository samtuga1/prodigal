import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prodigal/app.dart';
import 'package:prodigal/utils/initializer.dart';
import 'dart:ui';

final providerContainer = ProviderContainer();

Future<void> bootstrap(String envConfig) async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  final shockwaveShader = await FragmentProgram.fromAsset('lib/shaders/shockwave.frag');
  final perlinShader = await FragmentProgram.fromAsset('lib/shaders/perlin.frag');

  Initializer.init(envConfig, () {
    runApp(
      ProviderScope(
        child: ShaderProvider(
          shader: ShaderCollection(
            shockwaveShader: shockwaveShader,
            perlinShader: perlinShader,
          ),
          child: const App(),
        ),
      ),
    );
  });
}

// Provides the shader collection via inherited widget
class ShaderProvider extends InheritedWidget {
  const ShaderProvider({
    super.key,
    required this.shader,
    required super.child,
  });

  final ShaderCollection shader;

  static ShaderCollection of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<ShaderProvider>();
    return provider!.shader;
  }

  @override
  bool updateShouldNotify(covariant ShaderProvider oldWidget) {
    return oldWidget.shader != shader;
  }
}

class ShaderCollection {
  final FragmentProgram perlinShader;
  final FragmentProgram shockwaveShader;

  ShaderCollection({
    required this.shockwaveShader,
    required this.perlinShader,
  });
}
