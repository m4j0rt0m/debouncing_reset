TOP_MODULE = debouncing_reset
SIM_MODULE = debouncing_reset_tb

SRC        = $(wildcard $(shell find ./src/* -name "*.v"))
HEADERS    = $(wildcard $(shell find ./src/* -name "*.h"))

SIM_SRC    = $(wildcard $(shell find ./test_bench/* -name "*.v"))

SIM        = iverilog
SIM_FLAGS  = -o build/$(TOP_MODULE).tb -s $(SIM_MODULE) $(SRC)
RUN        = vvp
RUN_FLAGS  = -v

all: lint-only sim wave

sim: $(SIM_SRC) $(SRC)
	mkdir -p build
	$(SIM) $(SIM_SRC) $(SIM_FLAGS)	
	$(RUN) $(RUN_FLAGS) ./build/$(TOP_MODULE).tb
	mv $(TOP_MODULE).vcd ./build/

wave: $(SIM_SRC) $(SRC)
	gtkwave ./build/$(TOP_MODULE).vcd &

lint-only:
	verilator --lint-only $(SRC) -I./src

clean:
	rm -r ./build/*

.PHONY: all lint-only sim wave clean
