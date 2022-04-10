module Half_Adder (
    input wire a,
    input wire b,
    output wire sum,
    output wire carry
);
    assign sum = a^b;
    assign carry = a&b;
endmodule