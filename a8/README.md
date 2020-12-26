# Assignment 8

Synthesis

## Goals

- Run post-synthesis simulation of your design

## Given

This builds on top of assignment 6, and the test case is also the same.  The `run` script firsts tests for behavioural simulation, then synthesizes, and finally runs a post-synthesis simulation.  Synthesis is done using the [`yosys`](http://www.clifford.at/yosys/) open source synthesis tool.  It is quite possible that this tool has somewhat different behaviour in terms of synthesis than Xilinx Vivado.  For this assignment, we are going with Yosys since it is much faster and less resource intensive, and easier to install and run.

**NOTE**: In case you have got your code synthesized with Vivado but it does not pass the scripts here, they will still be considered valid submissions, but you will need to give a complete demonstration of how it synthesizes under Vivado and why it fails under Yosys.

## Details on the assignment

Most of the work is already done: you have presumably already passed assignment 6 by now.  However, there is a good chance that there are problems with the code that result in synthesis errors, or possible synthesis/simulation mismatches.  You need to correct these.

A few notes:

- `yosys` generates a lot of information very fast.  You may want to redirect this to a file (use something like `yosys synth.ys > out.log`) and go through it in case you find errors.
- Some common sources of problems:
    - Latches instead of flip-flops
    - Multi-driver nets: you *initialize* inside one `always` block and do the evaluation in another block.  
- Look for *WARNING*s in the output of yosys: in most cases it will proceed to synthesize even when there are warnings, but the output will likely not match what you expect.

### Synthesis script

`synth.ys` is a script used by `yosys` - it uses some simple defaults to target the Xilinx 7-series FPGAs.

For reference, a `synth.tcl` script is also provided, which you should be able to use with Vivado.  However, due to computational load issues, this is not going to be evaluated.

### Grading

You could possibly just submit the exact same code that you did for assignment 6.  However, if there are issues with synthesis, then correct them and submit for this assignment.  You will NOT be penalized for assignment 6 if the synthesis fails, but for this assignment you must pass the post-synthesis simulation.

## HowTo

Fork this repostiry (`EE2003/a8`) into your namespace so that you can edit and push changes.

The `run.sh` script performs all the steps required to compile and test your code.  The `iverilog` compiler is used for running the verilog simulations.  `yosys` is required for the synthesis steps.  Under Ubuntu (at least 18.04+) you can just run `sudo apt install yosys` and it should work.

**NOTE**: This assignment does NOT have a drone file for automatic testing, but you are required to tag and push as usual.  The appropriate tag from your repository will be used for evaluation.

Once you have confirmed that your code passes all the tests, commit all the changes, tag it for submission, and push to your repository.

## Date

Due Midnight, (Will be upated), 2020
