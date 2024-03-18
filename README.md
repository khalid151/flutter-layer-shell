# flutter_layer_shell

A bare-bones plugin to help creating wayland bars. All it does is provide a function to configure the position and size of the bar.

## Getting Started
To get started, edit `linux/my_application.cc` and add the following header
```c
#include <flutter_layer_shell/flutter_layer_shell_plugin.h>
```
And call this function `setup_layer_shell(window)` right after creating the GTK window:
```c
// Implements GApplication::activate.
static void my_application_activate(GApplication* application) {
  MyApplication* self = MY_APPLICATION(application);
  GtkWindow* window =
      GTK_WINDOW(gtk_application_window_new(GTK_APPLICATION(application)));

  // Must run before creating the view
  setup_layer_shell(window);
```

Once done, bar can be set like this:
```dart
import 'package:flutter_layer_shell/flutter_layer_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterLayerShell.configure(edge: LayerShellEdge.TOP, size: 65);
  runApp(const MyApp());
}
```

There are other to functions to update the size and position dynamically.
```
FlutterLayerShell.changeSize(size);
FlutterLayerShell.changePosition(layerShellEdge);
```
