NAME = transform
CFLAGS = -O0 -g
DOMEPATH ?= '/home/trevor/git/dome'

.PHONY: all

all: ${NAME}.so #${NAME}.dll ${NAME}.dylib

transform.c.inc: transform.wren
	${DOMEPATH}/dome embed transform.wren TRANS_WREN_source transform.c.inc

#${NAME}.dylib: ${NAME}.c transform.c.inc
#	gcc -dynamiclib -o transform.dylib -I../../include transform.c -undefined dynamic_lookup

${NAME}.so: ${NAME}.c transform.c.inc
	gcc ${CFLAGS} -shared -std=c11 -o ${NAME}.so -fPIC -I${DOMEPATH}/include ${NAME}.c

#${NAME}.dll: ${NAME}.c transform.c.inc
#	x86_64-w64-mingw32-gcc-win32 ${CFLAGS} -shared -D _WIN32 -std=gnu11 -fPIC  -I../../include ${NAME}.c -Wl,--unresolved-symbols=ignore-in-object-files -o ${NAME}.dll -LC:/mingw/lib -lcomdlg32 -lole32

.PHONY: clean

clean:
	rm -f transform.so
	rm -f transform.dll
	rm -f transform.c.inc