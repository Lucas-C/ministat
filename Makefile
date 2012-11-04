CC ?= clang 
INSTALLPATH ?= /usr/bin

CFLAGS += -Wall -Werror
LDFLAGS += -lm

BIN = ministat 
SRC = $(BIN).c

# No user serviceable parts below this line.
OBJS = $(addprefix $(OBJ), $(SRC:.c=.o))
DEPS = $(addsuffix .depend, $(OBJS))
OBJ  = obj

all: obj $(OBJ)/$(BIN)

obj:
	-mkdir obj

$(OBJ)$/(BIN): $(OBJS)
	$(CC) -o $@ $^ ${LDFLAGS}


$(OBJ)/%.o: %.c
	@echo "Generating $@.depend"
	@$(CC) $(CFLAGS) -MM $< | \
	sed 's,$*\.o[ :]*,$@ $@.depend : ,g' >> $@.depend
	$(CC) $(CFLAGS) -o $@ -c $<

depend:
	@echo "Dependencies are automatically generated."

install:
	install -m 0755 $(OBJ)/$(BIN) $(INSTALLPATH)

clean:
	-rm -rf $(BIN) obj *.core

.PHONY: all depend install clean

-include $(DEPS)
