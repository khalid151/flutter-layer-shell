import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_layer_shell_platform_interface.dart';

/// An implementation of [FlutterLayerShellPlatform] that uses method channels.
class MethodChannelFlutterLayerShell extends FlutterLayerShellPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_layer_shell');

  @override
  void configure(int edge, int size) {
    methodChannel
        .invokeMethod('configure_layer_shell', {'edge': edge, 'size': size});
  }

  @override
  void changeSize(int size) {
    methodChannel.invokeMethod('update_layer_size', {'size': size});
  }

  @override
  void changePosition(int edge) {
    methodChannel.invokeMethod('update_layer_position', {'edge': edge});
  }
}
