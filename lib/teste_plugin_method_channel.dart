import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'teste_plugin_platform_interface.dart';

/// An implementation of [TestePluginPlatform] that uses method channels.
class MethodChannelTestePlugin extends TestePluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('teste_plugin');

  @override
  Future<String?> getPlatformVersion() async {

    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
