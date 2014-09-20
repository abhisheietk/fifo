TOPLEVEL = fifo

PWD=$(shell pwd)
COCOTB=~/2014_devel/EDA/cocotb

VERILOG_SOURCES = $(PWD)/../../hdl/fifo.v $(PWD)/../../hdl/dpram.v
MODULE=test_fifo #cocotb,test_discovery,test_external,test_regression

SIM_ARGS=-lxt2

include $(COCOTB)/makefiles/Makefile.inc
include $(COCOTB)/makefiles/Makefile.sim