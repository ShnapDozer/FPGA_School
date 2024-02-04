`include "config.svh"

`define LAB1

module top
# (
    parameter clk_mhz = 50,
              w_key   = 4,
              w_sw    = 8,
              w_led   = 8,
              w_digit = 8,
              w_gpio  = 20
)
(
    input                        clk,
    input                        rst,

    // Keys, switches, LEDs

    input        [w_key   - 1:0] key,
    input        [w_sw    - 1:0] sw,
    output logic [w_led   - 1:0] led,

    // A dynamic seven-segment display

    output logic [          7:0] abcdefgh,
    output logic [w_digit - 1:0] digit,

    // VGA

    output logic                 vsync,
    output logic                 hsync,
    output logic [          3:0] red,
    output logic [          3:0] green,
    output logic [          3:0] blue,

    input        [         23:0] mic,

    // General-purpose Input/Output

    inout        [w_gpio  - 1:0] gpio

);

// lab1
//------------------------------------------------------------------------

`ifdef LAB1

       assign abcdefgh = '0;
       assign digit    = '0;
       assign vsync    = '0;
       assign hsync    = '0;
       assign red      = '0;
       assign green    = '0;
       assign blue     = '0;

    // Exercise 1: Free running counter.
    // How do you change the speed of LED blinking?
    // Try different bit slices to display.

    // localparam w_cnt = $clog2(clk_mhz * 1000000 * 1000);
    // logic [w_cnt - 1:0] cnt;

    // always_ff @ (posedge clk or posedge rst)
    //     if (rst)
    //         cnt <= '0;
    //     else
    //         cnt <= cnt + 1'd1;

    // assign led = cnt[$left(cnt) -: w_led];

    // Exercise 2: Key-controlled counter.
    // Comment out the code above.
    // Uncomment and synthesize the code below.
    // Press the key to see the counter incrementing.

    // 1. One key is used to increment, another to decrement.

    // logic increment_key_r;
    // logic decrement_key_r;

    // wire increment_key = key[0];
    // wire decrement_key =  key[1]; 

    // always_ff @ (posedge clk or posedge rst) begin
    //     if (rst) begin
    //         increment_key_r <= '0;
    //         decrement_key_r <= '0;
    //     end else begin
    //         increment_key_r <= increment_key;
    //         decrement_key_r <= decrement_key;
    //     end
    //  end

    // wire increment_key_pressed = ~increment_key & increment_key_r;
    // wire decrement_key_pressed = ~decrement_key & decrement_key_r;
    
    // logic [w_led - 1:0] cnt;
    // always_ff @ (posedge clk or posedge rst)
    //     if (rst)
    //         cnt <= '0;
    //     else if (increment_key_pressed)
    //         cnt <= cnt + 1'd1;
    //     else if (decrement_key_pressed)
    //         cnt <= cnt - 1'd1;

    // assign led = w_led' (cnt);

    // 2. Two counters controlled by different keys displayed in different groups of LEDs.

    localparam counterSize = w_led/2;

    logic first_key_r;
    logic second_key_r;

    wire first_key = key[0];
    wire second_key =  key[1]; 

    always_ff @ (posedge clk or posedge rst) begin
        if (rst) begin
            first_key_r <= '0;
            second_key_r <= '0;
        end else begin
            first_key_r <= first_key;
            second_key_r <= second_key;
        end
     end

    wire first_key_pressed = ~first_key & first_key_r;
    wire second_key_pressed = ~second_key & second_key_r;
    
    logic [counterSize - 1:0] firstCounter;
    logic [counterSize - 1:0] secondCounter;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            firstCounter <= '0;
            secondCounter <= '0;
        end else begin 
            if (first_key_pressed)
                firstCounter <= firstCounter + 1'd1;
        
            if (second_key_pressed)
                secondCounter <= secondCounter + 1'd1;
        end
    end

    assign led = { counterSize'(firstCounter), counterSize'(secondCounter) };

`endif
    


endmodule
