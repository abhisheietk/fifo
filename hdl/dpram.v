module dpram (
    clK, 

    a_port_WR,
    a_port_ADDR,
    a_port_data_IN,
    a_port_data_OUT,

    b_port_WR,
    b_port_ADDR,
    b_port_data_IN,
    b_port_data_OUT
    );

    parameter DATA = 16;
    parameter ADDR = 5;    input clK;
    
    // port A
    input  wire              a_port_WR;
    input  wire [ADDR-1:0]   a_port_ADDR;
    input  wire [DATA-1:0]   a_port_data_IN;
    output wire [DATA-1:0]   a_port_data_OUT;
    
    // port B
    input  wire              b_port_WR;
    input  wire [ADDR-1:0]   b_port_ADDR;
    input  wire [DATA-1:0]   b_port_data_IN;
    output wire [DATA-1:0]   b_port_data_OUT;
    