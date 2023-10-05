#ifndef FLUTTER_PLUGIN_TESTE_PLUGIN_H_
#define FLUTTER_PLUGIN_TESTE_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace teste_plugin {

class TestePlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  TestePlugin();

  virtual ~TestePlugin();

  // Disallow copy and assign.
  TestePlugin(const TestePlugin&) = delete;
  TestePlugin& operator=(const TestePlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace teste_plugin

#endif  // FLUTTER_PLUGIN_TESTE_PLUGIN_H_
