CC = gcc
CFLAGS = `pkg-config --cflags gtk+-3.0` -I/usr/local/include/libmongoc-1.0 -I/usr/local/include/libbson-1.0
LDFLAGS = `pkg-config --libs gtk+-3.0` -L/usr/local/lib -lmongoc-1.0 -lbson-1.0

TARGET = main

all: $(TARGET)

$(TARGET): main.o
	$(CC) -o $(TARGET) main.o $(LDFLAGS)

main.o: main.c
	$(CC) -c main.c $(CFLAGS)

clean:
	rm -f main.o $(TARGET)

.PHONY: all clean
