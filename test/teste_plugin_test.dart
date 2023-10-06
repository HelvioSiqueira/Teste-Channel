import 'package:flutter_test/flutter_test.dart';
import 'package:teste_plugin/teste_plugin.dart';
import 'package:teste_plugin/teste_plugin_platform_interface.dart';
import 'package:teste_plugin/teste_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTestePluginPlatform
    with MockPlatformInterfaceMixin
    implements TestePluginPlatform {

  @override
  Future<String?> getLocation() => Future.value('42');
}

void main() {
  final TestePluginPlatform initialPlatform = TestePluginPlatform.instance;

  test('$MethodChannelTestePlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTestePlugin>());
  });

  test('getPlatformVersion', () async {
    TestePlugin testePlugin = TestePlugin();
    MockTestePluginPlatform fakePlatform = MockTestePluginPlatform();
    TestePluginPlatform.instance = fakePlatform;

    expect(await testePlugin.getPlatformVersion(), '42');
  });
}
