#!/bin/bash
set -x

make clean
make

echo ""
echo "=== Test 1: Simple 2-input AND ==="
./verilog_qm -v "module and2(input a, b, output y); assign y = a & b; endmodule"

echo ""
echo "=== Test 2: 2-input OR ==="
./verilog_qm -v "module or2(input a, b, output y); assign y = a | b; endmodule"

echo ""
echo "=== Test 3: 3-input function F = Σm(0,1,2,3) ==="
./verilog_qm -v "module foo(input a, b, c, output y); assign y = ~a & ~b | ~a & ~c | ~b & ~c | ~a & ~b & ~c; endmodule"

echo ""
echo "=== Test 4: XOR function ==="
./verilog_qm -v "module xor2(input a, b, output y); assign y = a ^ b; endmodule"

echo ""
echo "=== Test 5: 4-variable example from docs ==="
./verilog_qm -v "module example(input a, b, c, d, output y); assign y = a & ~b | a & c | ~b & ~c; endmodule" --minterms

echo ""
echo "=== Test 6: Half adder sum ==="
./verilog_qm -v "module ha_sum(input a, b, output sum); assign sum = a ^ b; endmodule"

echo ""
echo "=== Test 7: Majority function (3-input) ==="
./verilog_qm -v "module maj3(input a, b, c, output y); assign y = a & b | a & c | b & c; endmodule" --minterms

echo ""
echo "=== All tests completed ==="