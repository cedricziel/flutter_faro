#ifndef FLUTTER_PLUGIN_FLUTTER_FARO_PLUGIN_H_
#define FLUTTER_PLUGIN_FLUTTER_FARO_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace flutter_faro {

class FlutterFaroPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FlutterFaroPlugin();

  virtual ~FlutterFaroPlugin();

  // Disallow copy and assign.
  FlutterFaroPlugin(const FlutterFaroPlugin&) = delete;
  FlutterFaroPlugin& operator=(const FlutterFaroPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace flutter_faro

#endif  // FLUTTER_PLUGIN_FLUTTER_FARO_PLUGIN_H_
