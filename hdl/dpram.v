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
    output reg  [DATA-1:0]   a_port_data_OUT;
    
    // port B
    input  wire              b_port_WR;
    input  wire [ADDR-1:0]   b_port_ADDR;
    input  wire [DATA-1:0]   b_port_data_IN;
    output reg  [DATA-1:0]   b_port_data_OUT;
    
    initial begin
        $dumpfile("dump.lxt");
        $dumpvars();
    end
    
    // Memory as multi-dimensional array
    reg [DATA-1:0] Memory [0:2**ADDR-1];
    
    // Write data to Memory
    always @(posedge clK) begin
        if (a_port_WR) begin
            Memory[a_port_ADDR] <= a_port_data_IN;
        end
    end
    always @(posedge clK) begin
        if (b_port_WR) begin
            Memory[b_port_ADDR] <= b_port_data_IN;
        end
    end
    
    // Read data from memory
    always @(posedge clK) begin
        a_port_data_OUT <= Memory[a_port_ADDR];
        b_port_data_OUT <= Memory[b_port_ADDR];
    end

endmodule
    initial begin
        $dumpfile("dump.lxt");
        $dumpvars();
    end
    
    // Memory as multi-dimensional array
    reg [DATA-1:0] Memory [0:2**ADDR-1];
    
    // Write data to Memory
    always @(posedge clK) begin
        if (a_port_WR) begin
            Memory[a_port_ADDR] <= a_port_data_IN;
        end
    end
    always @(posedge clK) begin
        if (b_port_WR) begin
            Memory[b_port_ADDR] <= b_port_data_IN;
        end
    end
    
    // Read data from memory
    always @(posedge clK) begin
        a_port_data_OUT <= Memory[a_port_ADDR];
        b_port_data_OUT <= Memory[b_port_ADDR];
    end

endmodule