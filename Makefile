EMACS_ROOT ?= emacs
JANET_ROOT ?= janet

CC      = gcc
LD      = gcc
CFLAGS = -ggdb3 -Wall

all: janet-core.so

janet-core.so: janet-core.o libjanet.a
	$(LD) -shared -L$(JANET_ROOT)/build -o $@ $< -l:libjanet.a

janet-core.o: janet-core.c
	$(CC) $(CFLAGS) -I$(JANET_ROOT)/src/include -I$(JANET_ROOT)/src/conf -fPIC -c -o $@ $<

# https://stackoverflow.com/a/37825586
libjanet.a:
	$(MAKE) -C janet

clean:
	rm -f janet-core.so janet-core.o
	cd janet && make clean

