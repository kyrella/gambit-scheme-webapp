GSC = /usr/bin/gsc
GSC_FLAGS = -:search=./lib -warnings -target js
GSC_LIB_PATH = /usr/lib/gambit-c
OUT_DIR = js/gen

src = src/app.scm
lib = lib/ffi.sld lib/sxml.sld lib/srfi/1/1.sld

app_target = ${OUT_DIR}/app.js
lib_targets = ${lib:%.sld=${OUT_DIR}/%.js}

.PHONY: all clean

all: ${app_target}

${OUT_DIR}/lib/%.js: lib/%.sld
	@mkdir -p $(dir $@)
	${GSC} ${GSC_FLAGS} -c -o $@ $<

${OUT_DIR}/lib/srfi/1/1.js: ${GSC_LIB_PATH}/srfi/1/1.sld
	@mkdir -p $(dir $@)
	${GSC} ${GSC_FLAGS} -c -o $@ $<

${app_target}: ${src} ${lib_targets}
	echo ${lib_targets}
	${GSC} ${GSC_FLAGS} -o $@ -exe -nopreload ${lib_targets} $<

clean:
	rm -rf ${app_target} ${lib_targets}
