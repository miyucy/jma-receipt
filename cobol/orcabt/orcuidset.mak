OUT_NAME=liborcuidset
OUT_PATH1=./
IN_PROG1=orcuidset
INC_PATH1=/usr/include/

all:: $(OUT_NAME)

$(OUT_NAME): $(IN_PROG1).o 
	gcc -fPIC -c $(IN_PROG1).c -I$(INC_PATH1)
	gcc -shared -Wl,-soname,$(OUT_PATH1)$(OUT_NAME).so -o $(OUT_PATH1)$(OUT_NAME).so $(IN_PROG1).o $(OPTLIBS)
