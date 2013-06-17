CFLAGS = -g
# uncomment to change optimization level
# CFLAGS += -O2

TARGET_DAEMON=fmberryd
OBJS = fmberryd.o ns741.o i2c.o
LIBS = -lbcm2835 -lpthread -lconfuse

all: fmberryd

fmberryd: $(OBJS)
	$(CC) $(CFLAGS) -o $(TARGET_DAEMON) $(OBJS) $(LIBS)

clean:
	$(RM) -f *.o $(TARGET_DAEMON)

%.o: %.c Makefile
	$(CC) -c $(CFLAGS) $< -o $@
	
install:
	install -m 644 fmberry.conf /etc/fmberry.conf
	install fmberryd /usr/local/bin
	install ctlfmberry /usr/local/bin
	install fmberry /etc/init.d

uninstall:
	$(RM) /usr/local/bin/fmberryd
	$(RM) /usr/local/bin/ctlfmberry
	$(RM) /etc/init.d/fmberry
