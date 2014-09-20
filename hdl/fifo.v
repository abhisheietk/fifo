module fifo (
    clK, 
    fifo_WR,
    fifo_IN,
    fifo_RD,
    fifo_OUT,
    rsT,
    statuS
    );

    parameter DATA = 16;
    parameter ADDR = 5;
    
    input clK;
    
    // in fifo
    input  wire              fifo_WR;
    input  wire [DATA-1:0]   fifo_IN;
    
    // out fifo
    input  wire              fifo_RD;
    output wire [DATA-1:0]   fifo_OUT;
    input  wire              rsT;
    output wire [1:0]        statuS;
    reg         [ADDR-1:0]   Address_In;
    reg         [ADDR-1:0]   Address_Out;
    reg         [ADDR-1:0]   Diff;
 
    dpram Fifomem (
        .clK(clK), 

        .a_port_WR(fifo_WR),
        .a_port_ADDR(Address_In),
        .a_port_data_IN(fifo_IN),
        .a_port_data_OUT(),

        .b_port_WR(1'b0),
        .b_port_ADDR(Address_Out),
        .b_port_data_IN(),
        .b_port_data_OUT(fifo_OUT)
        );
    defparam Fifomem.DATA = DATA;
    defparam Fifomem.ADDR = ADDR;

    assign statuS = Diff;


    initial begin
        $dumpfile("dump.lxt");
        $dumpvars();
    end
    
    initial begin
        Address_Out <= 0;
        Address_In  <= 0;
        Diff        <= 0;
    end
        
    always @(posedge clK) begin
        if (rsT) begin
            Address_Out <= 0;
            Address_In  <= 0;
            Diff        <= 0;
        end

        if (fifo_WR & fifo_RD) begin            
            Address_In <= Address_In + 1;
            Address_Out <= Address_Out + 1;
        end
        else if (fifo_WR) begin
            Address_In <= Address_In + 1;
            Diff       <= Diff + 1;
        end        
        else if (fifo_RD) begin
            Address_Out <= Address_Out + 1;
            Diff        <= Diff - 1;
        end   
    end

endmodule