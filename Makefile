# vhdl files
FILES = src/*
VHDLEX = .vhd

# testbench
TESTBENCHFILE = tb/${TESTBENCH}$(VHDLEX)
TESTBENCH = adder_tb

#GHDL CONFIG
GHDL_CMD = ghdl

SIM_DIR = simulation/$(TESTBENCH)
STOP_TIME = 2000ns

# Simulation break condition
GHDL_SIM_OPT = --stop-time=$(STOP_TIME)
GHDL_FLAGS  = --ieee=synopsys --std=08 --warn-no-vital-generic

WAVEFORM_VIEWER = gtkwave
WAVEFILE = $(SIM_DIR)/$(TESTBENCH).ghw
SAVEFILE = simulation/$(TESTBENCH).gtkw

.PHONY: clean all view

all:  $(WAVEFILE)

view : $(WAVEFILE)
	$(WAVEFORM_VIEWER) $^ $(SAVEFILE)


# Compilation of the TestBench
$(SIM_DIR)/$(TESTBENCH).bin: $(FILES) $(TESTBENCHFILE) $(TOOLSFILE)
	
	#Set the working directory
	mkdir -p $(SIM_DIR)/
	
	#Importing the sources
	@echo "Importing ..."
	$(GHDL_CMD) -i $(GHDL_FLAGS)  --workdir=$(SIM_DIR)/ --work=lib_VHDL $^
	#Compiling the sources
	@echo "Starting make .."
	@$(GHDL_CMD) -m  $(GHDL_FLAGS)  --workdir=$(SIM_DIR)/ --work=lib_VHDL $(TESTBENCH)
	
	#Cleaning of the directory
	mv e~$(TESTBENCH).o $(SIM_DIR)/
	mv $(TESTBENCH) $(SIM_DIR)/$(TESTBENCH).bin

# Running and generation of the wavefile
$(WAVEFILE): $(SIM_DIR)/$(TESTBENCH).bin
	@echo "Run .."
	@./$(SIM_DIR)/$(TESTBENCH).bin $(GHDL_SIM_OPT) --wave=$@

#Cleaning the working directory and the binary files
clean:
	@rm -rf $(SIM_DIR)
	@rm -rf simulation/$(TESTBENCH).*
