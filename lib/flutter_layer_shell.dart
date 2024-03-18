import 'flutter_layer_shell_platform_interface.dart';

enum LayerShellEdge {
  RIGHT,
  LEFT,
  BOTTOM,
  TOP,
}

class FlutterLayerShell {
  static void configure({required LayerShellEdge edge, int size = 30}) {
    FlutterLayerShellPlatform.instance.configure(edge.index, size);
  }

  static void changeSize(int size) {
    FlutterLayerShellPlatform.instance.changeSize(size);
  }

  static void changePosition(LayerShellEdge edge) {
    FlutterLayerShellPlatform.instance.changePosition(edge.index);
  }
}
