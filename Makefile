NAME = myprogram
CFLAGS = -std=c++14 $(pkg-config --cflags --libs libpistache)
output: main.o
	g++ main.o -o $(NAME)

main.o: main.cpp
	g++ $(CFLAGS) main.cpp

clean:
	rm *.o myprogram


