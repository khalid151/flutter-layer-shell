#include "include/flutter_layer_shell/flutter_layer_shell_plugin.h"

#include <flutter_linux/flutter_linux.h>
#include <gtk-layer-shell.h>
#include <gtk/gtk.h>
#include <sys/utsname.h>

#include <cstring>

#include "flutter_layer_shell_plugin_private.h"

#define FLUTTER_LAYER_SHELL_PLUGIN(obj)                                        \
  (G_TYPE_CHECK_INSTANCE_CAST((obj), flutter_layer_shell_plugin_get_type(),    \
                              FlutterLayerShellPlugin))

void setup_layer_shell(GtkWindow *window) {
  gtk_layer_init_for_window(window);
  gtk_layer_set_layer(window, GTK_LAYER_SHELL_LAYER_BOTTOM);
  gtk_layer_auto_exclusive_zone_enable(window);
  for (int i = 0; i < GTK_LAYER_SHELL_EDGE_ENTRY_NUMBER; i++) {
    gtk_layer_set_anchor(window, (GtkLayerShellEdge)i, TRUE);
  }
}

struct _FlutterLayerShellPlugin {
  GObject parent_instance;
};

G_DEFINE_TYPE(FlutterLayerShellPlugin, flutter_layer_shell_plugin,
              g_object_get_type())

// Called when a method call is received from Flutter.
static void
flutter_layer_shell_plugin_handle_method_call(FlMethodCall *method_call,
                                              GtkWindow *window) {
  g_autoptr(FlMethodResponse) response = nullptr;

  const gchar *method = fl_method_call_get_name(method_call);

  if (strcmp(method, "configure_layer_shell") == 0) {
    auto args = fl_method_call_get_args(method_call);
    int size = fl_value_get_int(fl_value_lookup_string(args, "size"));
    int edge = fl_value_get_int(fl_value_lookup_string(args, "edge"));
    update_layer_position(window, edge);
    update_layer_size(window, size);
    response = FL_METHOD_RESPONSE(fl_method_success_response_new(nullptr));
  } else if (strcmp(method, "update_layer_position") == 0) {
    auto args = fl_method_call_get_args(method_call);
    int edge = fl_value_get_int(fl_value_lookup_string(args, "edge"));
    update_layer_position(window, edge);
    response = FL_METHOD_RESPONSE(fl_method_success_response_new(nullptr));
  } else if (strcmp(method, "update_layer_size") == 0) {
    auto args = fl_method_call_get_args(method_call);
    int size = fl_value_get_int(fl_value_lookup_string(args, "size"));
    update_layer_size(window, size);
    response = FL_METHOD_RESPONSE(fl_method_success_response_new(nullptr));
  } else {
    response = FL_METHOD_RESPONSE(fl_method_not_implemented_response_new());
  }

  fl_method_call_respond(method_call, response, nullptr);
}

void update_layer_size(GtkWindow *window, int size) {
  gtk_window_set_default_size(window, size, size);
  gtk_widget_set_size_request(GTK_WIDGET(window), size, size);
  gtk_window_set_resizable(GTK_WINDOW(window), FALSE);
}

void update_layer_position(GtkWindow *window, int edge) {
  for (int i = 0; i < GTK_LAYER_SHELL_EDGE_ENTRY_NUMBER; i++) {
    gtk_layer_set_anchor(window, (GtkLayerShellEdge)i, TRUE);
  }
  gtk_layer_set_anchor(window, (GtkLayerShellEdge)edge, FALSE);
}

static void flutter_layer_shell_plugin_dispose(GObject *object) {
  G_OBJECT_CLASS(flutter_layer_shell_plugin_parent_class)->dispose(object);
}

static void
flutter_layer_shell_plugin_class_init(FlutterLayerShellPluginClass *klass) {
  G_OBJECT_CLASS(klass)->dispose = flutter_layer_shell_plugin_dispose;
}

static void flutter_layer_shell_plugin_init(FlutterLayerShellPlugin *self) {}

static void method_call_cb(FlMethodChannel *channel, FlMethodCall *method_call,
                           gpointer user_data) {
  GtkWindow *window = GTK_WINDOW(user_data);
  flutter_layer_shell_plugin_handle_method_call(method_call, window);
}

void flutter_layer_shell_plugin_register_with_registrar(
    FlPluginRegistrar *registrar) {
  FlutterLayerShellPlugin *plugin = FLUTTER_LAYER_SHELL_PLUGIN(
      g_object_new(flutter_layer_shell_plugin_get_type(), nullptr));

  FlView *view = fl_plugin_registrar_get_view(registrar);
  GtkWindow *window = GTK_WINDOW(gtk_widget_get_toplevel(GTK_WIDGET(view)));
  // Prepare window to enable transparency
  gtk_widget_set_app_paintable(GTK_WIDGET(window), TRUE);

  g_autoptr(FlStandardMethodCodec) codec = fl_standard_method_codec_new();
  g_autoptr(FlMethodChannel) channel =
      fl_method_channel_new(fl_plugin_registrar_get_messenger(registrar),
                            "flutter_layer_shell", FL_METHOD_CODEC(codec));
  fl_method_channel_set_method_call_handler(channel, method_call_cb, window,
                                            nullptr);

  g_object_unref(plugin);
}
