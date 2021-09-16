SRC_DIR := ${shell pwd}/src
WRK_DIR := ${shell pwd}/build
PROJECT_NAME := helloworld
MAIN_PRJ := helloworld.prg
MAIN_ASM := ${PROJECT_NAME}.asm
C64_COMPILER := /usr/bin/acme
C64_EMULATOR := /usr/bin/x64

ifndef VERSION
	VERSION = 0.0.0
endif

default: build

clean:
	@echo "Cleaning..."
	@rm -rf ${WRK_DIR}/*

build: clean
	@echo "Building..."
	@if [ ! -e ${WRK_DIR} ]; then mkdir ${WRK_DIR}; fi
	@if [ ! -e ${WRK_DIR}/bin/ ]; then mkdir ${WRK_DIR}/bin; fi
	@if [ ! -e ${WRK_DIR}/report/ ]; then mkdir ${WRK_DIR}/report; fi
	@cd ${SRC_DIR};${C64_COMPILER} --msvc --color --format cbm --report ${WRK_DIR}/report/${PROJECT_NAME}.rpt --outfile ${WRK_DIR}/bin/${MAIN_PRJ} Main.asm

run:
	@echo "Running..."
	@${C64_EMULATOR} +warp -refresh 1 -speed 110 ${WRK_DIR}/bin/${MAIN_PRJ}
