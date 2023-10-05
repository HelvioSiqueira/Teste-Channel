//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <teste_plugin/teste_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) teste_plugin_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "TestePlugin");
  teste_plugin_register_with_registrar(teste_plugin_registrar);
}
