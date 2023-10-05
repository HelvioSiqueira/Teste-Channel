#include "include/teste_plugin/teste_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "teste_plugin.h"

void TestePluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  teste_plugin::TestePlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
