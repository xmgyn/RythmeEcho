#include <gtk/gtk.h>
#include <stdio.h>
#include <string.h>

static void activate(GtkApplication *app, gpointer user_data) {
    GtkWidget *window;
    GtkWidget *label;

    window = gtk_application_window_new(app);
    gtk_window_set_title(GTK_WINDOW(window), "Hello World");
    gtk_window_set_default_size(GTK_WINDOW(window), 200, 200);

    label = gtk_label_new("Hello, World!");
    gtk_container_add(GTK_CONTAINER(window), label);

    gtk_widget_show_all(window);
}

int main(int argc, char **argv) {
    if (argc > 1 && strcmp(argv[1], "command_line") == 0) {
        printf("hello\n");
        return 0;
    }

    GtkApplication *app;
    int status;

    app = gtk_application_new("com.example.HelloWorld", G_APPLICATION_FLAGS_NONE);
    g_signal_connect(app, "activate", G_CALLBACK(activate), NULL);

    status = g_application_run(G_APPLICATION(app), argc, argv);
    g_object_unref(app);

    return status;
}
