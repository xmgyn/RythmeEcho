#include <gtk/gtk.h>
#include <mongoc/mongoc.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>

// Implement CLI 
// Memory Not Efficient
// Widget Call In Single Iteration
// Improve Element Positions

mongoc_client_t *client;
gchar *url = NULL, *title = NULL, *id = NULL, *artist = NULL, *thumbnail = NULL, *video_ext = NULL, *video_codec = NULL, *audio_codec = NULL, *video_format = NULL, *duration = NULL;

void on_ok_button_clicked(GtkWidget *widget, gpointer data);
void on_parse_button_clicked(GtkWidget *widget, gpointer data);
GString* run_command(const char *command, GtkWidget *widget);
int database_handle(gchar* database_name, gchar* collection_name, bson_t *doc);
void update_log_text(GtkWidget *text_view, const gchar *new_log);
GtkWidget* create_log_dialog(GtkWidget *parent);
bool check_if_document_exists(const char *database_name, const char *collection_name, const char *id_str);
void show_message_box(GtkWidget *parent, const gchar *command);
GtkWidget* fetch_grid_elements(GtkWidget *widget, gpointer data);
static void activate(GtkApplication *app, gpointer user_data);

int main(int argc, char **argv) {
    if (argc > 1 && strcmp(argv[1], "command_line") == 0) {
        printf("CLI Not Implemented Yet");
        // Implement CLI : --history returns last 4, --upload youtube_link, --media UID
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

// Correct
void on_ok_button_clicked(GtkWidget *widget, gpointer data) {
    if (url == NULL && title == NULL && id == NULL && artist == NULL && thumbnail == NULL && duration == NULL) {
        show_message_box(gtk_widget_get_toplevel(widget), "Check The Values");
        exit(EXIT_FAILURE);
    }

    if(check_if_document_exists("media_server", "media_info", id)) {
        show_message_box(gtk_widget_get_toplevel(widget), "Entry Exists");
        exit(EXIT_FAILURE);
    }

    GtkWidget *window = (GtkWidget *)data;
    GtkWidget* song_entry = fetch_grid_elements(window, "song_entry");
    GtkWidget* artist_entry = fetch_grid_elements(window,  "artist_entry");
    // Fetch All Widgets At Once

    title = gtk_entry_get_text(GTK_ENTRY(song_entry));
    artist = gtk_entry_get_text(GTK_ENTRY(artist_entry));

    GtkWidget *text_view = create_log_dialog(window);

    update_log_text(text_view, "Operations Started...\n");

    const char *video_path = g_strdup_printf("./video/%s.mp4",id); 
    const char *audio_path = g_strdup_printf("./audio/%s.m4a",id);

    gchar command[512];
    snprintf(command, sizeof(command), "./yt-dlp -f 'bestvideo[ext=mp4]' -o '%s' --no-progress %s", video_path, url);
    GString *result = run_command(command, widget);
    if (result == NULL) {
        show_message_box(gtk_widget_get_toplevel(widget), "Video Download Failed");
        exit(EXIT_FAILURE);
    } else {
        update_log_text(text_view, "Video Download Complete\n");
    }

    gchar command1[512];
    snprintf(command1, sizeof(command1), "./yt-dlp -f 'bestaudio[ext=m4a]' -o '%s' --no-progress %s", audio_path, url);
    GString *result1 = run_command(command1, widget);
    if (result1 == NULL) {
        show_message_box(gtk_widget_get_toplevel(widget), "Audio Download Failed");
        exit(EXIT_FAILURE);
    } else {
        update_log_text(text_view, "Audio Download Complete\n");
    }

    bson_t *doc;

    struct stat st; 
    stat(video_path, &st);
    int video_size = st.st_size; 
    memset(&st, 0, sizeof(st));
    stat(audio_path, &st);
    int audio_size = st.st_size; 
    
    
    doc = bson_new();
    BSON_APPEND_UTF8(doc, "_id", id);
    BSON_APPEND_UTF8(doc, "song_title", title);
    BSON_APPEND_INT32(doc, "plays", 0);
    BSON_APPEND_INT32(doc, "video_size", video_size);
    BSON_APPEND_INT32(doc, "audio_size", audio_size);
    BSON_APPEND_UTF8(doc, "video_codec", video_codec);
    BSON_APPEND_UTF8(doc, "audio_codec", audio_codec);
    BSON_APPEND_UTF8(doc, "Format", video_format);

    if (!database_handle("media_server", "media_info", doc)) {
        update_log_text(text_view, "Media Info Updated\n");
    } else {
        show_message_box(gtk_widget_get_toplevel(widget), "media_info Upload Failed");
        exit(EXIT_FAILURE);
    }

    doc = bson_new();
    BSON_APPEND_UTF8(doc, "_id", id);
    BSON_APPEND_UTF8(doc, "song_title", title);
    BSON_APPEND_UTF8(doc, "artist", artist);
    BSON_APPEND_UTF8(doc, "youtube_link", url);
    BSON_APPEND_UTF8(doc, "duration", duration); 

    if (!database_handle("media_server", "media_metadata", doc)) {
        update_log_text(text_view, "Media Metadata Updated\n");
    } else {
        show_message_box(gtk_widget_get_toplevel(widget), "media_metadata Upload Failed");
        exit(EXIT_FAILURE);
    }

    update_log_text(text_view, "Press OK To Continue\n");
    gtk_dialog_run(GTK_DIALOG(gtk_widget_get_toplevel(text_view)));
    gtk_widget_destroy(gtk_widget_get_toplevel(text_view));
    show_message_box(gtk_widget_get_toplevel(widget), "Successful");
}

// Correct
void on_parse_button_clicked(GtkWidget *widget, gpointer data) {
    GtkWidget *window = (GtkWidget *)data;

    // ./yt-dlp --print "title: %(title)s\nid: %(id)s\nartist: %(uploader)s\nthumbnail: %(thumbnail)s" https://www.youtube.com/watch?v=bB3-CUMERIU

    // curl -o ./.thumbnails/hello.jpg https://cdn3.pixelcut.app/7/20/uncrop_hero_bdf08a8ca6.jpg 

    GtkWidget* youtube_link = fetch_grid_elements(window, "youtube_link_entry");
    GtkWidget* song_entry = fetch_grid_elements(window, "song_entry");
    GtkWidget* artist_entry = fetch_grid_elements(window,  "artist_entry");
    GtkWidget* uid_entry = fetch_grid_elements(window, "uid_entry");
    GtkWidget* image_box = fetch_grid_elements(window, "image_box");
    // Fetch All Widgets At Once

    url = gtk_entry_get_text(GTK_ENTRY(youtube_link));

    gchar command[512];
    snprintf(command, sizeof(command), "./yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]' --print 'Title: %(title)s\nID: %(id)s\nArtist: %(uploader)s\nThumbnail: %(thumbnail)s\nVideo Extension: %(ext)s\nVideo Codec: %(vcodec)s\nAudio Codec: %(acodec)s\nFormat: %(format)s\nDuration: %(duration_string)s' %s", url);


    GString *result = run_command(command, widget);
    if (result == NULL) {
        show_message_box(gtk_widget_get_toplevel(widget), "Print Didn't Worked");
        exit(EXIT_FAILURE);
    }

    show_message_box(gtk_widget_get_toplevel(widget), result->str);

    GRegex *regex;
    GMatchInfo *match_info;

    const gchar *pattern = "Title: ([^\n]+)\nID: ([^\n]+)\nArtist: ([^\n]+)\nThumbnail: ([^\n]+)\nVideo Extension: ([^\n]+)\nVideo Codec: ([^\n]+)\nAudio Codec: ([^\n]+)\nFormat: ([^\n]+)\nDuration: ([^\n]+)";

    regex = g_regex_new(pattern, 0, 0, NULL);
    g_regex_match(regex, result->str, 0, &match_info);

    //g_free(command);
    //g_string_free(result, TRUE);    

    if (g_match_info_matches(match_info)) {
        title = g_match_info_fetch(match_info, 1);
        id = g_match_info_fetch(match_info, 2);
        artist = g_match_info_fetch(match_info, 3);
        thumbnail = g_match_info_fetch(match_info, 4);
        video_ext = g_match_info_fetch(match_info, 5);
        video_codec = g_match_info_fetch(match_info, 6);
        audio_codec = g_match_info_fetch(match_info, 7);
        video_format = g_match_info_fetch(match_info, 8);
        duration = g_match_info_fetch(match_info, 9);
    }   

    g_match_info_free(match_info);
    g_regex_unref(regex);

    const char* dot = strrchr(thumbnail, '.');

    gchar commandC[512];
    snprintf(commandC, sizeof(commandC), "curl -s -o ./.thumbnails/%s%s %s", id, dot, thumbnail);

    GString *result1 = run_command(commandC, widget);
    if (result1 == NULL) {
        show_message_box(gtk_widget_get_toplevel(widget), "Thumbnail Download Unsucessful");
        exit(EXIT_FAILURE);
    }

    
    if(strcmp(dot,".jpg")!= 0) {
        gchar commandV[512];
        snprintf(commandV, sizeof(commandV), "convert ./.thumbnails/%s%s ./.thumbnails/%s.jpg", id, dot, id);
        GString *result2 = run_command(commandV, widget);
        if (result2 == NULL) {
            show_message_box(gtk_widget_get_toplevel(widget), "Thumbnail Did Not Convert");
            exit(EXIT_FAILURE);
        } else {
            if (remove(g_strdup_printf("./.thumbnails/%s%s", id, dot)) != 0) {
                show_message_box(gtk_widget_get_toplevel(widget), "Thumbnail Delete Failed, Do It Manually");
            }
        }
    }

    GdkPixbuf *pixbuf = gdk_pixbuf_new_from_file(g_strdup_printf("./.thumbnails/%s.jpg", id), NULL);
    GdkPixbuf *scaled_pixbuf = gdk_pixbuf_scale_simple(pixbuf, 400, 250, GDK_INTERP_BILINEAR);
    gtk_image_set_from_pixbuf(GTK_IMAGE(image_box), scaled_pixbuf);

    gtk_entry_set_text(GTK_ENTRY(song_entry), title);
    gtk_entry_set_text(GTK_ENTRY(artist_entry), artist);
    gtk_entry_set_text(GTK_ENTRY(uid_entry), id);    
}

// Correct
GString* run_command(const char *command, GtkWidget *widget) {
    FILE *fp = popen(command, "r");
    if (fp == NULL) {
        show_message_box(gtk_widget_get_toplevel(widget), "Failed to run command\n");
        return NULL;
    }

    GString *output = g_string_new(NULL);
    char buffer[128];
    while (fgets(buffer, sizeof(buffer) - 1, fp) != NULL) {
        g_string_append(output, buffer);
    }
    pclose(fp);

    return output;
}

// Correct
int database_handle(gchar* database_name, gchar* collection_name, bson_t *doc) {
    mongoc_collection_t *collection;
    bson_error_t error;

    collection = mongoc_client_get_collection(client, database_name, collection_name);

    if (!mongoc_collection_insert_one(collection, doc, NULL, NULL, &error)) {
        show_message_box(NULL, "Mongo Insertion Failed");
        bson_destroy(doc);
        mongoc_collection_destroy(collection);
        mongoc_client_destroy(client);
        mongoc_cleanup();
        exit(EXIT_FAILURE);
    }

    bson_destroy(doc);
    mongoc_collection_destroy(collection);

    return 0;
}

// Correct
bool check_if_document_exists(const char *database_name, const char *collection_name, const char *id_str) { 
    mongoc_collection_t *collection = mongoc_client_get_collection(client, database_name, collection_name); 
    bson_t *query = BCON_NEW("_id", BCON_UTF8(id_str)); 
    mongoc_cursor_t *cursor = mongoc_collection_find_with_opts(collection, query, NULL, NULL); 
    const bson_t *doc; 
    bool exists = mongoc_cursor_next(cursor, &doc); 
    bson_error_t error; 
    if (mongoc_cursor_error(cursor, &error)) { 
        fprintf(stderr, "Cursor Error: %s\n", error.message); 
    } 
    mongoc_cursor_destroy(cursor); 
    bson_destroy(query); 
    mongoc_collection_destroy(collection); 
    return exists;
} 

// Correct
void show_message_box(GtkWidget *parent, const gchar *command) {
    GtkWidget *dialog = gtk_message_dialog_new(GTK_WINDOW(parent),
                                               GTK_DIALOG_DESTROY_WITH_PARENT,
                                               GTK_MESSAGE_INFO,
                                               GTK_BUTTONS_OK,
                                               "%s", command);

    gtk_dialog_run(GTK_DIALOG(dialog));
    gtk_widget_destroy(dialog);
}

// Correct
GtkWidget* create_log_dialog(GtkWidget *parent) {
    GtkWidget *dialog = gtk_dialog_new_with_buttons("Logs",
                                                    GTK_WINDOW(parent),
                                                    GTK_DIALOG_DESTROY_WITH_PARENT,
                                                    "_OK",
                                                    GTK_RESPONSE_OK,
                                                    NULL);
    
    GtkWidget *content_area = gtk_dialog_get_content_area(GTK_DIALOG(dialog));
    GtkWidget *scrolled_window = gtk_scrolled_window_new(NULL, NULL);
    GtkWidget *text_view = gtk_text_view_new();

    gtk_container_add(GTK_CONTAINER(scrolled_window), text_view);
    gtk_container_add(GTK_CONTAINER(content_area), scrolled_window);

    gtk_text_view_set_editable(GTK_TEXT_VIEW(text_view), FALSE);
    gtk_widget_set_size_request(scrolled_window, 400, 300);
    gtk_widget_show_all(dialog);

    return text_view;  // Return the text view for updating logs
}

// Correct
void update_log_text(GtkWidget *text_view, const gchar *new_log) {
    GtkTextBuffer *buffer = gtk_text_view_get_buffer(GTK_TEXT_VIEW(text_view));
    GtkTextIter end;
    gtk_text_buffer_get_end_iter(buffer, &end);
    gtk_text_buffer_insert(buffer, &end, new_log, -1);
    while (gtk_events_pending()) gtk_main_iteration();
}

// Correct
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
    

    GdkPixbuf *pixbuf = gdk_pixbuf_new_from_file("./.thumbnails/sample.jpg", NULL);
    GdkPixbuf *scaled_pixbuf = gdk_pixbuf_scale_simple(pixbuf, 400, 250, GDK_INTERP_BILINEAR);
    image_box = gtk_image_new_from_pixbuf(scaled_pixbuf);
    gtk_widget_set_name(image_box, "image_box"); 


    song_label = gtk_label_new("Song");
    song_entry = gtk_entry_new();
    gtk_widget_set_name(song_entry, "song_entry"); 

    artist_label = gtk_label_new("Artist");
    artist_entry = gtk_entry_new();
    gtk_widget_set_name(artist_entry, "artist_entry"); 

    uid_label = gtk_label_new("UID");
    uid_entry = gtk_entry_new();
    gtk_widget_set_name(uid_entry, "uid_entry"); 
    gtk_editable_set_editable(GTK_EDITABLE(uid_entry), FALSE); 
    gtk_widget_set_sensitive(uid_entry, FALSE);

    ok_button = gtk_button_new_with_label("OK");
    cancel_button = gtk_button_new_with_label("Cancel");

    gtk_grid_set_row_spacing(GTK_GRID(grid), 10);   
    gtk_grid_set_column_spacing(GTK_GRID(grid), 10); 

    GtkWidget *widgets[] = {youtube_link_label, song_label, artist_label, uid_label, ok_button, cancel_button};

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

gtk_grid_attach(GTK_GRID(grid), uid_label, 0, 5, 1, 1);
gtk_grid_attach(GTK_GRID(grid), uid_entry, 1, 5, 4, 1);

gtk_grid_attach(GTK_GRID(grid), ok_button, 3, 6, 1, 1);
gtk_grid_attach(GTK_GRID(grid), cancel_button, 4, 6, 1, 1);


    gtk_widget_show_all(window);

    g_signal_connect(parse_button, "clicked", G_CALLBACK(on_parse_button_clicked), window); 
    
    g_signal_connect(ok_button, "clicked", G_CALLBACK(on_ok_button_clicked), window);
    g_signal_connect(cancel_button, "clicked", G_CALLBACK(gtk_window_close), window);
}