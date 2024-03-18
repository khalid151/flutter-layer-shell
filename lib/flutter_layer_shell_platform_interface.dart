import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_layer_shell_method_channel.dart';

abstract class FlutterLayerShellPlatform extends PlatformInterface {
  /// Constructs a FlutterLayerShellPlatform.
  FlutterLayerShellPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterLayerShellPlatform _instance = MethodChannelFlutterLayerShell();

  /// The default instance of [FlutterLayerShellPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterLayerShell].
  static FlutterLayerShellPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterLayerShellPlatform] when
  /// they register themselves.
  static set instance(FlutterLayerShellPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  void configure(int edge, int size) {
    throw UnimplementedError('configure() has not been implemented.');
  }

  void changeSize(int size) {
    throw UnimplementedError('changeSize() has not been implemented.');
  }

  void changePosition(int edge) {
    throw UnimplementedError('changePosition() has not been implemented.');
  }
}
