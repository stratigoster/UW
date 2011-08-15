CXX = u++
CXXFLAGS = -g -Wall -Wno-unused-label
EXEC = webBrowser
OBJS = keyboard.o \
	   browser.o \
	   courier.o \
	   topicNameServer.o \
	   assassin.o \
	   server.o \
	   worker.o \
	   readersWriter.o \
	   cache.o

all: $(EXEC)

$(EXEC): $(OBJS) driver.cc
	$(CXX) $(CXXFLAGS) driver.cc $(OBJS) -o $@

clean:
	rm -f $(OBJS) $(EXEC)
