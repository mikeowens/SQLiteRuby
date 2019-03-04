CC=gcc
CFLAGS=-I. -I/usr/include/ruby-2.3.0 -I/usr/include/x86_64-linux-gnu/ruby-2.3.0

DEPS = sqlite3.h

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

ext: sqlite3.o ruby_sqlite3.o ruby_sqlite3_stmt.o 
	$(CC) -o ext.o sqlite3.o ruby_sqlite3.o ruby_sqlite3_stmt.o 
