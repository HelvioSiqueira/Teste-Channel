
import 'teste_plugin_platform_interface.dart';

class TestePlugin {
  Future<String?> getPlatformVersion() {
    return TestePluginPlatform.instance.getPlatformVersion();
  }
}
