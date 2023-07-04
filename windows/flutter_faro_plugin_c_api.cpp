#include "include/flutter_faro/flutter_faro_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "flutter_faro_plugin.h"

void FlutterFaroPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flutter_faro::FlutterFaroPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
