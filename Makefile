BIN = ministat 
SRCS= ministat.c
OBJS= ministat.o

PKGS = 

CFLAGS  += -g -Wall -Werror
CPPFLAGS+= -D_GNU_SOURCE
LDFLAGS += -lm

PREFIX ?= /usr

# No user serviceable parts below this line.
#PPFLAGS+= $(shell pkg-config --silence-errors --cflags $(PKGS))
#LDFLAGS += $(shell pkg-config --silence-errors --libs $(PKGS))

all: $(BIN)

$(BIN): $(OBJS)
	$(CC) $(OBJS) ${LDFLAGS} -o ${BIN}

$(OBJS): %.o: %.c
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $<

install:
	install -d $(PREFIX)/bin
	install -m 0755 $(BIN) $(PREFIX)/bin/$(BIN)

clean:
	-rm -rf $(BIN) *.o *.core

.PHONY: install clean

-include $(DEPS)
