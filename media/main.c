#include <gtk/gtk.h>
#include <mongoc/mongoc.h>
#include <stdio.h>
#include <string.h>

mongoc_client_t *client;

void on_ok_button_clicked(GtkWidget *widget, gpointer data);
gchar* show_message_box(GtkWidget *parent, const gchar *command);
int database_handle(gchar* database_name, gchar* collection_name, bson_t *doc);
void create_dynamic_short_video(const char *input_file, int num_segments, int segment_duration, int total_duration);
void on_parse_button_clicked(GtkWidget *widget, gpointer data);
static void activate(GtkApplication *app, gpointer user_data);

int main(int argc, char **argv) {
    if (argc > 1 && strcmp(argv[1], "command_line") == 0) {
        printf("hello\n");
        return 0;
    }

    GtkApplication *app;
    int status;

    mongoc_init();

    client = mongoc_client_new("mongodb://localhost:27017/");
    if (!client) {
        fprintf(stderr, "Failed to parse URI.\n");
        return EXIT_FAILURE;
    }

    app = gtk_application_new("com.example.Media_handler", G_APPLICATION_FLAGS_NONE);
    g_signal_connect(app, "activate", G_CALLBACK(activate), NULL);

    status = g_application_run(G_APPLICATION(app), 0, NULL);
    g_object_unref(app);

    mongoc_client_destroy(client);
    mongoc_cleanup();

    return status;
}


void on_ok_button_clicked(GtkWidget *widget, gpointer data) {
    g_print("OK Clicked");
    
    // Download Audio And Video
    // Download Thumbnail And Rename With UID

    bson_t *doc;

    // media_info:
    //  UID : { song_title, plays, download_date }

    // media_metadata:
    //  UID : { song_title, artist, youtube_link, duration }
    
    doc = bson_new();
BSON_APPEND_UTF8(doc, "_id", "song12345");
BSON_APPEND_UTF8(doc, "song_title", "Best Song Ever");
BSON_APPEND_INT32(doc, "plays", 150);
//BSON_APPEND_DATE_TIME(doc, "download_date", bson_get_now());
BSON_APPEND_UTF8(doc, "video_ext", ".mp4"); 
BSON_APPEND_UTF8(doc, "audio_ext", ".webm");
BSON_APPEND_UTF8(doc, "video_size", "");
BSON_APPEND_UTF8(doc, "audio_size", "");
BSON_APPEND_UTF8(doc, "video_codec", "");
BSON_APPEND_UTF8(doc, "audio_codec", "");
BSON_APPEND_UTF8(doc, "video_format", "");
BSON_APPEND_UTF8(doc, "audio_format", "");

if (!database_handle("media_server", "media_info", doc)) {
        g_print("Upload Successful");
    } else g_error("An error occurred: %s", "Description of the error");

doc = bson_new();
BSON_APPEND_UTF8(doc, "_id", "song12345");
BSON_APPEND_UTF8(doc, "song_title", "Best Song Ever");
BSON_APPEND_UTF8(doc, "artist", "Great Artist");
BSON_APPEND_UTF8(doc, "youtube_link", "https://www.youtube.com/watch?v=example");
BSON_APPEND_INT32(doc, "duration", 240); 

    if (!database_handle("media_server", "media_metadata", doc)) {
        g_print("Upload Successful");
    } else g_error("An error occurred: %s", "Description of the error");
    
    const char *input_file = "input.mp4";
    int num_segments = 3;
    int segment_duration = 5;  // in seconds
    int total_duration = 180;  // in seconds, assuming the input video is 3 minutes long

    create_dynamic_short_video(input_file, num_segments, segment_duration, total_duration);
}

// Correct
gchar* show_message_box(GtkWidget *parent, const gchar *command) {
    FILE *fp = popen(command, "r");
    if (fp == NULL) {
        g_print("Failed to run command\n");
        return "Failed to run command\n";
    }
    GString *output = g_string_new(NULL);
    char buffer[128];
    while (fgets(buffer, sizeof(buffer) - 1, fp) != NULL) {
        g_string_append(output, buffer);
    }
    pclose(fp);
    GtkWidget *dialog = gtk_message_dialog_new(GTK_WINDOW(parent),
                                               GTK_DIALOG_DESTROY_WITH_PARENT,
                                               GTK_MESSAGE_INFO,
                                               GTK_BUTTONS_OK,
                                               "%s", output->str);

    gtk_dialog_run(GTK_DIALOG(dialog));
    gtk_widget_destroy(dialog);

    return output->str;
}

// Correct
int database_handle(gchar* database_name, gchar* collection_name, bson_t *doc) {
    mongoc_collection_t *collection;
    bson_error_t error;

    collection = mongoc_client_get_collection(client, database_name, collection_name);

    // Insert the document into the collection
    if (!mongoc_collection_insert_one(collection, doc, NULL, NULL, &error)) {
        fprintf(stderr, "Insert failed: %s\n", error.message);
        bson_destroy(doc);
        mongoc_collection_destroy(collection);
        mongoc_client_destroy(client);
        mongoc_cleanup();
        return EXIT_FAILURE;
    }

    bson_destroy(doc);
    mongoc_collection_destroy(collection);

    return 0;
}

void create_dynamic_short_video(const char *input_file, int num_segments, int segment_duration, int total_duration) {
    // Initialize random seed
    srand(time(NULL));

    // Calculate the maximum start time for each segment
    int max_start_time = total_duration - (num_segments * segment_duration);

    // Generate random start times for each segment
    int *start_times = (int *)malloc(num_segments * sizeof(int));
    for (int i = 0; i < num_segments; ++i) {
        start_times[i] = rand() % max_start_time;
    }

    // Create FFmpeg commands to extract segments
    char command[1024];
    for (int i = 0; i < num_segments; ++i) {
        snprintf(command, sizeof(command), "ffmpeg -i %s -ss %02d:%02d:%02d -t %02d:%02d:%02d -c copy segment%d.mp4",
                 input_file, start_times[i] / 3600, (start_times[i] % 3600) / 60, start_times[i] % 60,
                 segment_duration / 3600, (segment_duration % 3600) / 60, segment_duration % 60, i + 1);
        system(command);
    }

    // Create a text file listing the segments
    const char *filename = ".segments.txt";
    FILE *segments_file = fopen(filename, "w");
    if (!segments_file) {
        perror("Failed to open segments.txt");
        free(start_times);
        return;
    }
    for (int i = 0; i < num_segments; ++i) {
        fprintf(segments_file, "file 'segment%d.mp4'\n", i + 1);
    }
    fclose(segments_file);

    // Concatenate the segments
    snprintf(command, sizeof(command), "ffmpeg -f concat -safe 0 -i %s -c copy %s", filename, strcat(input_file, "/.loop/"));
    system(command);

    if (remove(filename) == 0) { printf("File deleted successfully.\n"); } else { perror("Error deleting file"); } 

    // Clean up
    free(start_times);
}

GtkWidget* fetch_grid_elements(GtkWidget *widget, gpointer data) {
    if (GTK_IS_CONTAINER(widget)) {
        GList *children = gtk_container_get_children(GTK_CONTAINER(widget));
        for (GList *iter = children; iter != NULL; iter = g_list_next(iter)) {
            GtkWidget *result = fetch_grid_elements(GTK_WIDGET(iter->data), data);
            if (result != NULL) {
                g_list_free(children);
                return result;
            }
        }
        g_list_free(children);
    }

    const gchar *name = (const gchar *)data;

    if (g_strcmp0(gtk_widget_get_name(widget), name) == 0) {
        return widget;
    }

    return NULL;
}


void on_parse_button_clicked(GtkWidget *widget, gpointer data) {
    GtkWidget *window = (GtkWidget *)data;

// ./yt-dlp --print "title: %(title)s\nid: %(id)s\nartist: %(uploader)s\nthumbnail: %(thumbnail)s" https://www.youtube.com/watch?v=bB3-CUMERIU

    GtkWidget* youtube_link = fetch_grid_elements(window, "youtube_link_entry");
    gchar command[256];
    snprintf(command, sizeof(command), "./yt-dlp --print \"title: %(title)s\nid: %(id)s\nartist: %(uploader)s\nthumbnail: %(thumbnail)s\" %s", gtk_entry_get_text(GTK_ENTRY(youtube_link)));

    gchar* command1 = show_message_box(gtk_widget_get_toplevel(widget), command);

    GtkWidget* song_entry = fetch_grid_elements(window, "song_entry");
    GtkWidget* artist_entry = fetch_grid_elements(window,  "artist_entry");
    GtkWidget* uid_entry = fetch_grid_elements(window, "uid_entry");

    GRegex *regex;
GMatchInfo *match_info;
gchar *title = NULL, *id = NULL, *artist = NULL;

regex = g_regex_new("title: ([^\n]+)\nid: ([^\n]+)\nartist: ([^\n]+)", 0, 0, NULL);
g_regex_match(regex, command1, 0, &match_info);

if (g_match_info_matches(match_info)) {
    title = g_match_info_fetch(match_info, 1);
    id = g_match_info_fetch(match_info, 2);
    artist = g_match_info_fetch(match_info, 3);
}

g_match_info_free(match_info);
g_regex_unref(regex);


    gtk_entry_set_text(GTK_ENTRY(song_entry), title);
    gtk_entry_set_text(GTK_ENTRY(artist_entry), artist);
    gtk_entry_set_text(GTK_ENTRY(uid_entry), id);
}

// Correct
static void activate(GtkApplication *app, gpointer user_data) {
    GtkWidget *window;
    GtkWidget *grid;

    GtkWidget *youtube_link_label;
    GtkWidget *youtube_link_entry;
    GtkWidget *parse_button;

    GtkWidget *image_box;

    GtkWidget *song_label;
    GtkWidget *song_entry;

    GtkWidget *artist_label;
    GtkWidget *artist_entry;

    GtkWidget *id16_label;
    GtkWidget *id16_entry;

    GtkWidget *uid_label;
    GtkWidget *uid_entry;

    GtkWidget *ok_button;
    GtkWidget *cancel_button;

    window = gtk_application_window_new(app);
    gtk_window_set_title(GTK_WINDOW(window), "Media Handler");
    gtk_window_set_default_size(GTK_WINDOW(window), 400, 300);
    gtk_window_set_resizable(GTK_WINDOW(window),FALSE);

    grid = gtk_grid_new();
    gtk_container_add(GTK_CONTAINER(window), grid);

    youtube_link_label = gtk_label_new("YouTube");
    youtube_link_entry = gtk_entry_new();
    gtk_widget_set_name(youtube_link_entry, "youtube_link_entry"); 
    parse_button = gtk_button_new_with_label("Parse");
    

    GdkPixbuf *pixbuf = gdk_pixbuf_new_from_file("sample.jpg", NULL);
    GdkPixbuf *scaled_pixbuf = gdk_pixbuf_scale_simple(pixbuf, 300, 200, GDK_INTERP_BILINEAR);
    image_box = gtk_image_new_from_pixbuf(scaled_pixbuf);



    song_label = gtk_label_new("Song");
    song_entry = gtk_entry_new();
    gtk_widget_set_name(song_entry, "song_entry"); 

    artist_label = gtk_label_new("Artist");
    artist_entry = gtk_entry_new();
    gtk_widget_set_name(artist_entry, "artist_entry"); 

    id16_label = gtk_label_new("ID16");
    id16_entry = gtk_entry_new();

    uid_label = gtk_label_new("UID");
    uid_entry = gtk_entry_new();
    gtk_widget_set_name(uid_entry, "uid_entry"); 

    ok_button = gtk_button_new_with_label("OK");
    cancel_button = gtk_button_new_with_label("Cancel");

gtk_grid_set_row_spacing(GTK_GRID(grid), 10);   
gtk_grid_set_column_spacing(GTK_GRID(grid), 10); 

GtkWidget *widgets[] = {youtube_link_label, song_label, artist_label, id16_label, uid_label, ok_button, cancel_button};

for (int i = 0; i < sizeof(widgets)/sizeof(widgets[0]); ++i) {
    gtk_widget_set_margin_top(widgets[i], 5);
    gtk_widget_set_margin_bottom(widgets[i], 5);
}

gtk_grid_attach(GTK_GRID(grid), youtube_link_label, 0, 0, 1, 1);
gtk_grid_attach(GTK_GRID(grid), youtube_link_entry, 1, 0, 3, 1);
gtk_grid_attach(GTK_GRID(grid), parse_button, 4, 0, 1, 1);

gtk_grid_attach(GTK_GRID(grid), image_box, 0, 1, 5, 1);
gtk_widget_set_halign(image_box, GTK_ALIGN_CENTER);

gtk_grid_attach(GTK_GRID(grid), song_label, 0, 2, 1, 1);
gtk_grid_attach(GTK_GRID(grid), song_entry, 1, 2, 4, 1);

gtk_grid_attach(GTK_GRID(grid), artist_label, 0, 3, 1, 1);
gtk_grid_attach(GTK_GRID(grid), artist_entry, 1, 3, 4, 1);

gtk_grid_attach(GTK_GRID(grid), id16_label, 0, 4, 1, 1);
gtk_grid_attach(GTK_GRID(grid), id16_entry, 1, 4, 4, 1);

gtk_grid_attach(GTK_GRID(grid), uid_label, 0, 5, 1, 1);
gtk_grid_attach(GTK_GRID(grid), uid_entry, 1, 5, 4, 1);

gtk_grid_attach(GTK_GRID(grid), ok_button, 3, 6, 1, 1);
gtk_grid_attach(GTK_GRID(grid), cancel_button, 4, 6, 1, 1);


    gtk_widget_show_all(window);

    g_signal_connect(parse_button, "clicked", G_CALLBACK(on_parse_button_clicked), window); 
    
    g_signal_connect(ok_button, "clicked", G_CALLBACK(on_ok_button_clicked), window);
    g_signal_connect(cancel_button, "clicked", G_CALLBACK(gtk_window_close), window);
}