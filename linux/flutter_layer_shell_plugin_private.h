#include <flutter_linux/flutter_linux.h>

#include "include/flutter_layer_shell/flutter_layer_shell_plugin.h"

// This file exposes some plugin internals for unit testing. See
// https://github.com/flutter/flutter/issues/88724 for current limitations
// in the unit-testable API.

void update_layer_size(GtkWindow *window, int size);
void update_layer_position(GtkWindow *window, int edge);
