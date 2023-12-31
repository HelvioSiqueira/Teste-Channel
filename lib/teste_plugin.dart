import 'package:teste_plugin/location_platform_interface.dart';

import 'teste_plugin_platform_interface.dart';

class TestePlugin {
  Future<String?> getPlatformVersion() {
    return TestePluginPlatform.instance.getPlatformVersion();
  }

  Future<Map<Object?, Object?>?> getLocationUpdates() {
    return LocationPluginPlatform.instance.getLocation();
  }
}
