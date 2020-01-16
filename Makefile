#
# on CentOS 6.5 call with
#    scl enable devtoolset-7 -- make
#
NAME = myprogram

CFLAGS += -c -std=c++14 $(shell PKG_CONFIG_PATH=/usr/local/lib64/pkgconfig/ pkg-config --cflags libpistache)
LDFLAGS += $(shell PKG_CONFIG_PATH=/usr/local/lib64/pkgconfig/ pkg-config --libs libpistache)

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
