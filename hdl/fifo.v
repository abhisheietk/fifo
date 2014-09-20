module dpram (
    clK, 
    fifo_IN,
    fifo_WR,
    fifo_RD,
    fifo_OUT
    );

    parameter DATA = 16;
    parameter ADDR = 5;