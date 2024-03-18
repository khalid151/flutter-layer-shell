#ifndef FLUTTER_PLUGIN_FLUTTER_LAYER_SHELL_PLUGIN_H_
#define FLUTTER_PLUGIN_FLUTTER_LAYER_SHELL_PLUGIN_H_

#include <flutter_linux/flutter_linux.h>

G_BEGIN_DECLS

#ifdef FLUTTER_PLUGIN_IMPL
#define FLUTTER_PLUGIN_EXPORT __attribute__((visibility("default")))
#else
#define FLUTTER_PLUGIN_EXPORT
#endif

typedef struct _FlutterLayerShellPlugin FlutterLayerShellPlugin;
typedef struct {
  GObjectClass parent_class;
} FlutterLayerShellPluginClass;

FLUTTER_PLUGIN_EXPORT GType flutter_layer_shell_plugin_get_type();

FLUTTER_PLUGIN_EXPORT void flutter_layer_shell_plugin_register_with_registrar(
    FlPluginRegistrar *registrar);

FLUTTER_PLUGIN_EXPORT void setup_layer_shell(GtkWindow *window);

G_END_DECLS

#endif // FLUTTER_PLUGIN_FLUTTER_LAYER_SHELL_PLUGIN_H_
