import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'teste_plugin_method_channel.dart';

abstract class TestePluginPlatform extends PlatformInterface {
  /// Constructs a TestePluginPlatform.
  TestePluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static TestePluginPlatform _instance = MethodChannelTestePlugin();

  /// The default instance of [TestePluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelTestePlugin].
  static TestePluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TestePluginPlatform] when
  /// they register themselves.
  static set instance(TestePluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
