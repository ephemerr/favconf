#!/usr/bin/colormake

######################################### Additional variables

GLFW_FLAGS := -L/usr/local/lib -lglfw3 -lrt -lXrandr -lXi -lXxf86vm -lXcursor -lGL #-lm -lXrender -lXfixes -lXext -lX11 -lpthread -lxcb -lXau -lXdmcp

######################################### Local defines

include makefile.def

######################################### Main variables

CC		= gcc
PDIR 	= /home/azzel/projects

CFLAGS 	+= -Wall -Wextra 
LDFLAGS += 

SRC 	+= src cfg
INCLUDE += $(SRC)

LIBDIRS += /usr/local/lib
LIBS 	+= rt m

SOURCES += $(wildcard $(addsuffix /*.c, $(SRC)))
OBJECTS += $(SOURCES:.c=.o)


######################################### Test variables

DIR_TEST := test 
INCLUDE_TEST := $(INCLUDE) $(DIR_TEST) $(PDIR)/cpputest/include/

LIBS_TEST += $(LIBS) CppUTest 
LIBDIRS_TEST += $(LIBDIRS) $(PDIR)/cpputest/lib

SOURCES_TEST := $(wildcard $(addsuffix /*.cpp, $(DIR_TEST)))
OBJECTS_TEST := $(SOURCES_TEST:.cpp=.opp) $(OBJECTS)

EXEC_TEST := utest


######################################### Targets

# Linkage
$(EXECUTABLE) : $(OBJECTS) main.o
	$(CC) -o $@ $(OBJECTS) main.o  $(LDFLAGS) $(addprefix -l, $(LIBS)) $(addprefix -I, $(INCLUDE)) $(addprefix -L, $(LIBDIRS)) 

# Create target & unit test
all: $(EXECUTABLE) $(EXEC_TEST)
	make lib	

# Create library
lib : $(OBJECTS) 
	ar -r lib$(EXECUTABLE).a $(OBJECTS) 

# Compilation
%.o : %.c 
	$(CC) -o $@ -c $< $(CFLAGS) $(addprefix -I, $(INCLUDE))

# Unit tests linkage
$(EXEC_TEST) : $(OBJECTS_TEST) test/main.o 
	$(CC) -o $(EXEC_TEST) $(OBJECTS_TEST) test/main.o $(LDFLAGS) $(addprefix -l, $(LIBS_TEST)) $(addprefix -I, $(INCLUDE_TEST)) $(addprefix -L, $(LIBDIRS_TEST)) 

# Unit test compilation
%.opp : %.cpp
	$(CC) -o $@ -c $< $(CFLAGS) $(addprefix -I, $(INCLUDE_TEST))
	
clean :
	rm -rf $(EXEC_TEST) $(EXECUTABLE) $(OBJECTS) main.o $(OBJECTS_TEST) test/main.o  *.a

new:
	ctags -R $(INCLUDE) $(INCLUDE_TEST)
	make clean
	make all
	./utest
