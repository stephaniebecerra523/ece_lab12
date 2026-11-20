
module binary(
    input w,
    input clk,
    input reset,
    output z,
    output [2:0] state
);

    wire [2:0] State;
    wire [2:0] Next;

    wire a, b, c;

    assign a = State[2];
    assign b = State[1];
    assign c = State[0];

    dff zero(
        .Default(1'b0),
        .D(Next[0]),
        .clk(clk),
        .reset(reset),
        .Q(State[0])
    );

    dff one(
        .Default(1'b0),
        .D(Next[1]),
        .clk(clk),
        .reset(reset),
        .Q(State[1])
    );

    dff two(
        .Default(1'b0),
        .D(Next[2]),
        .clk(clk),
        .reset(reset),
        .Q(State[2])
    );

    assign Next[0] =
        (b & c & ~w) |
        (w & ~a & ~b) |
        (w & ~a & ~c) |
        (~b & ~c & ~w);

    assign Next[1] =
        (b & ~c) |
        (~b & c) |
        (w & ~a & ~b);

    assign Next[2] =
        (a & w) |
        (b & c & w);

    assign z =
        (~a & b & ~c) |
        (a & ~b & ~c);

    assign state = State;

endmodule
