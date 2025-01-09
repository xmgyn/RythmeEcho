CC = gcc
CFLAGS = `pkg-config --cflags gtk+-3.0`
LDFLAGS = `pkg-config --libs gtk+-3.0`
TARGET = main

all: $(TARGET)

$(TARGET): main.o
	$(CC) -o $(TARGET) main.o $(LDFLAGS)

main.o: main.c
	$(CC) -c main.c $(CFLAGS)

clean:
	rm -f main.o $(TARGET)

.PHONY: all clean
