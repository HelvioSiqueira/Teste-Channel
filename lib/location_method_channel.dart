import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'location_platform_interface.dart';
import 'teste_plugin_platform_interface.dart';

/// An implementation of [TestePluginPlatform] that uses method channels.
class LocationMethodChannel extends LocationPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('getLocationToHealth');

  @override
  Future<Map<Object?, Object?>?> getLocation() async {

    final version = await methodChannel.invokeMethod<Map<Object?, Object?>?>('getLocation');
    return version;
  }
}
