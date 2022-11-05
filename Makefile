.PHONY: build run clean

build: src/main.c
	gcc -o app src/main.c

clean:
	rm -f app
