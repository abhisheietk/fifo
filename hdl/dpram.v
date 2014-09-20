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
);    input clK;
    
    // port A
    input              a_port_WR;
    input  [ADDR-1:0]   a_port_ADDR;
    input  [DATA-1:0]   a_port_data_IN;
    output [DATA-1:0]   a_port_data_OUT;
    
    // port B
    input              a_port_WR;
    input  [ADDR-1:0]   a_port_ADDR;
    input  [DATA-1:0]   a_port_data_IN;
    output [DATA-1:0]   a_port_data_OUT;