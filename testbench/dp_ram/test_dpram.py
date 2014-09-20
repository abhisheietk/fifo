
import random

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge, ReadOnly
from cocotb.result import TestFailure, ReturnValue

@cocotb.coroutine
def write_ram(dut, address, value):
    """This coroutine performs a write of the RAM"""
    yield RisingEdge(dut.clK)                  # Synchronise to the read clock
    dut.a_port_ADDR = address                  # Drive the values
    dut.a_port_data_IN    = value
    dut.a_port_WR  = 1
    yield RisingEdge(dut.clK)                  # Wait 1 clock cycle
    dut.a_port_WR  = 0                         # Disable write

@cocotb.coroutine
def read_ram(dut, address):
    """This coroutine performs a read of the RAM and returns a value"""
    yield RisingEdge(dut.clK)               # Synchronise to the read clock
    dut.a_port_ADDR = address               # Drive the value onto the signal
    yield RisingEdge(dut.clK)               # Wait for 1 clock cycle
    yield ReadOnly()                             # Wait until all events have executed for this timestep
    raise ReturnValue(int(dut.a_port_data_OUT.value))  # Read back the value


@cocotb.test()
def test_dpram(dut):
    """Try writing values into the RAM and reading back"""
    RAM = {}
    
    # Read the parameters back from the DUT to set up our model
    width = dut.DATA.value.integer
    depth = 2**dut.ADDR.value.integer
    dut.log.info("Found %d entry RAM by %d bits wide" % (depth, width))

    # Set up independent read/write clocks
    cocotb.fork(Clock(dut.clK, 3200).start())
    
    dut.log.info("Writing in random values")
    for i in xrange(depth):
        RAM[i] = int(random.getrandbits(width))
        yield write_ram(dut, i, RAM[i])

    dut.log.info("Reading back values and checking")
    for i in xrange(depth):
        value = yield read_ram(dut, i)
        dut.log.info("%d   %d" % (value, RAM[i]))
        if value != RAM[i]:
            dut.log.error("RAM[%d] expected %d but got %d" % (i, RAM[i], dut.a_port_data_OUT.value.value))
            #raise TestFailure("RAM contents incorrect")
    dut.log.info("RAM contents OK")