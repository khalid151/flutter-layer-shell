import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_layer_shell/flutter_layer_shell.dart';
import 'package:flutter_layer_shell/flutter_layer_shell_platform_interface.dart';
import 'package:flutter_layer_shell/flutter_layer_shell_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterLayerShellPlatform
    with MockPlatformInterfaceMixin
    implements FlutterLayerShellPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterLayerShellPlatform initialPlatform =
      FlutterLayerShellPlatform.instance;

  test('$MethodChannelFlutterLayerShell is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterLayerShell>());
  });

  test('getPlatformVersion', () async {
    FlutterLayerShell flutterLayerShellPlugin = FlutterLayerShell();
    MockFlutterLayerShellPlatform fakePlatform =
        MockFlutterLayerShellPlatform();
    FlutterLayerShellPlatform.instance = fakePlatform;

    expect(await flutterLayerShellPlugin.getPlatformVersion(), '42');
  });
}
