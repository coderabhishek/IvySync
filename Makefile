# We don't need kludgy automatizations here,
# let's use a simple Makefile.
# Just tweak the values below to fix your paths
#
# $Id: Makefile 60 2004-11-12 15:40:18Z jaromil $


CC = gcc
CPP = g++
LINKER = ld

# debugging flags:
CPPFLAGS = -I. -Ixmlrpc++ -Wall -ggdb -pg `pkg-config --cflags gtk+-2.0`

# optimized flags:
#CPPFLAGS = -I. -Ixmlrpc++ -Wall -O2 -fomit-frame-pointer -ffast-math -march=pentium3 \
           `pkg-config --cflags gtk+-2.0`

LIBS = xmlrpc++/libxmlrpc++.a -lpthread -lssl `pkg-config --libs gtk+-2.0`

OBJ = decoder.o thread.o utils.o cmdline.o gui.o xmlrpc.o

all: xmlrpc ivysync

xmlrpc: 
	cd xmlrpc++ && $(MAKE)

ivysync: $(OBJ)
	$(CPP) $(CPPFLAGS) -o ivysync $(OBJ) $(LIBS)


#make clean
clean:
	rm -rf *.o *~ ivysync 

install: ivysync
	install ivysync /usr/local/bin

# generic make rules
#%: %.c
#	$(CC) $(CFLAGS) -o $@ $< $(LIBS)
#%.o: %.c
#	$(CC) $(CFLAGS) -c -o $@ $<


