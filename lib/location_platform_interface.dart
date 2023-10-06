import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:teste_plugin/location_method_channel.dart';

import 'teste_plugin_method_channel.dart';

abstract class LocationPluginPlatform extends PlatformInterface {
  /// Constructs a TestePluginPlatform.
  LocationPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static LocationPluginPlatform _instance = LocationMethodChannel();

  /// The default instance of [LocationPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelTestePlugin].
  static LocationPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [LocationPluginPlatform] when
  /// they register themselves.
  static set instance(LocationPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<Map<Object?, Object?>?> getLocation() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
