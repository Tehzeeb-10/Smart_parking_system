module smart_parking_controller #(
    parameter CAPACITY = 8
)(
    input wire clk,
    input wire reset,
    input wire vehicle_entry,
    input wire vehicle_exit,

    output reg [3:0] occupied_count,
    output wire [3:0] slots_available,
    output wire parking_full,
    output wire parking_almost_full,
    output wire entry_allowed,
    output wire exit_allowed
);

always @(posedge clk or posedge reset) begin

    if (reset) begin
        occupied_count <= 4'd0;
    end

    else if (vehicle_entry && !vehicle_exit) begin
        if (occupied_count < 4'd8)
            occupied_count <= occupied_count + 4'd1;
    end

    else if (vehicle_exit && !vehicle_entry) begin
        if (occupied_count > 4'd0)
            occupied_count <= occupied_count - 4'd1;
    end

end

assign slots_available = 4'd8 - occupied_count;
assign parking_full = (occupied_count == 4'd8);
assign parking_almost_full = (occupied_count == 4'd7);
assign entry_allowed = (occupied_count < 4'd8);
assign exit_allowed = (occupied_count > 4'd0);

endmodule
