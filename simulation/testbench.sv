module tb_smart_parking;

reg clk;
reg reset;
reg vehicle_entry;
reg vehicle_exit;

wire [3:0] occupied_count;
wire [3:0] slots_available;
wire parking_full;
wire parking_almost_full;
wire entry_allowed;
wire exit_allowed;

smart_parking_controller dut (
    .clk(clk),
    .reset(reset),
    .vehicle_entry(vehicle_entry),
    .vehicle_exit(vehicle_exit),
    .occupied_count(occupied_count),
    .slots_available(slots_available),
    .parking_full(parking_full),
    .parking_almost_full(parking_almost_full),
    .entry_allowed(entry_allowed),
    .exit_allowed(exit_allowed)
);

always #5 clk = ~clk;

initial begin

    $dumpfile("dump.vcd");
    $dumpvars(0, tb_smart_parking);

    clk = 0;
    reset = 1;
    vehicle_entry = 0;
    vehicle_exit = 0;

    // Reset
    #20;
    reset = 0;

    // Fill parking: 0 -> 8
    repeat (8) begin
        @(negedge clk);
        vehicle_entry = 1;

        @(negedge clk);
        vehicle_entry = 0;
    end

    // Try entry when full
    @(negedge clk);
    vehicle_entry = 1;

    @(negedge clk);
    vehicle_entry = 0;

    // Empty parking: 8 -> 0
    repeat (8) begin
        @(negedge clk);
        vehicle_exit = 1;

        @(negedge clk);
        vehicle_exit = 0;
    end

    // Try exit when empty
    @(negedge clk);
    vehicle_exit = 1;

    @(negedge clk);
    vehicle_exit = 0;

    #30;

    $finish;

end

endmodule
