//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <flutter_audio_capture/flutter_audio_capture_plugin.h>
#include <record_linux/record_linux_plugin.h>
#include <smart_auth/smart_auth_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) flutter_audio_capture_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "FlutterAudioCapturePlugin");
  flutter_audio_capture_plugin_register_with_registrar(flutter_audio_capture_registrar);
  g_autoptr(FlPluginRegistrar) record_linux_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "RecordLinuxPlugin");
  record_linux_plugin_register_with_registrar(record_linux_registrar);
  g_autoptr(FlPluginRegistrar) smart_auth_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "SmartAuthPlugin");
  smart_auth_plugin_register_with_registrar(smart_auth_registrar);
}
