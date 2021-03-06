CFLAGS += $(DEFINES) -v -w 
OBJS = main.o table.o driver.o s16debug.o \
mattach.o mconnect.o mread.o mwrite.o mdetach.o \
mioctl.o mshutdown.o mgetsockopt.o msetsockopt.o \
mgetsockname.o mgetpeername.o mselect.o maccept.o \
mbind.o mlisten.o

TARGET = marignotti

$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) $(OBJS) $(LDLIBS) -o $@



s16debug.o: s16debug.c s16debug.h

main.o: main.c marignotti.h
table.o: table.c marignotti.h
driver.o: driver.c marignotti.h net.h
mread.o: mread.c marignotti.h
mwrite.o: mwrite.c marignotti.h
mattach.o: mattach.c marignotti.h
mconnect.o: mconnect.c marignotti.h
mdetach.o: mdetach.c marignotti.h
msetsockopt.o: msetsockopt.c marignotti.h
mgetsockopt.o: mgetsockopt.c marignotti.h
mshutdown.o: mshutdown.c marignotti.h
mioctl.o: mioctl.c marignotti.h
mgetsockname.o: mgetsockname.c marignotti.h
mselect.o: mselect.c marignotti.h
mgetpeername.o: mgetpeername.c marignotti.h
mbind.o: mbind.c marignotti.h
mlisten.o: mlisten.c marignotti.h
maccept.o: maccept.c marignotti.h

clean:
	$(RM) *.o *.root

clobber: clean
	$(RM) $(TARGET) 

