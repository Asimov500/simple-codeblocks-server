#
# on CentOS 6.5 call with
#    scl enable devtoolset-7 -- make
#
NAME = myprogram

# all possible lib search paths.
LD_SEARCH=-Wl,-rpath,./ -Wl,-rpath,/usr/lib64 -Wl,-rpath,/usr/local/lib64/

# try pkg-config in default and local-install paths
MY_CFLAGS=$(shell pkg-config --cflags libpistache)
MY_LDFLAGS=$(shell pkg-config --libs libpistache)
ifeq ($(MY_CFLAGS),)
    MY_CFLAGS=$(shell PKG_CONFIG_PATH=/usr/local/lib64/pkgconfig/ pkg-config --cflags libpistache)
    MY_LDFLAGS=$(shell PKG_CONFIG_PATH=/usr/local/lib64/pkgconfig/ pkg-config --libs libpistache)
endif
CFLAGS += -c -std=c++14 $(MY_CFLAGS)
LDFLAGS += $(MY_LDFLAGS) $(LD_SEARCH)

.PHONY: pistache

# required to add c++ ABI libs at link time
LD=g++

output: main.o
	$(LD) main.o $(LDFLAGS) -o $(NAME)

main.o: main.cpp
	$(CXX) $(CFLAGS) main.cpp

clean:
	rm -f *.o myprogram

pistache:
	mkdir -p pistache/build
	cd pistache/build; cmake3 ../
	cd pistache/build; make all install
