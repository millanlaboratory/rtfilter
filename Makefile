CC=gcc
LD=gcc
LDFLAGS=-lm -lrt $(PFLAGS)
CFLAGS=-march=native -msse2 -mfpmath=sse -O3 -I. -W -Wall -g3 $(PFLAGS)

all: test_timing test_filter
	

test_filter: filter-sse.o test_filter.o common-filters.o
	$(LD) -o $@ $^ $(LDFLAGS)

test_timing: filter-sse.o test_timing.o common-filters.o
	$(LD) -o $@ $^ $(LDFLAGS)

clean:
	$(RM) *.o *.s *.i
	$(RM) test_timing test_filter
