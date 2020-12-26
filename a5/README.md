# Assignment 5

Implement Load/Store instructions

## Goals

- Implement all the instructions in the RISC-V RV32I ISA that correspond to Load/Store (memory) operations.

## Given

- Test bench with test cases having Load/Store along with ALU operations
    - Test bench will feed one input instruction per clock cycle
    - All registers are assumed initialized to 0 - this should be done in your code
- IMEM and DMEM are given as modules in the test bench.  You should not change them, but have to follow the read/write timing patterns from them.
- `cpu_tb.v` is the top test bench - the interface for your CPU code must match this.

## Details on the assignment

You need to implement code for the `cpu` module, that will read in the instructions and execute them.  For assignment 5 (Load/Store) you can assume that the program counter (PC) always increments by 4 on each clock cycle.  For the assignment involving branching, this cannot be assumed and you will have to implement the proper changes in PC.

### Test cases

Test cases are given under the `test/` folder, with appropriate imem and dmem files.  Each imem file contains a set of instructions at the end that will dump all the register values into the first several locations in dmem.  The test bench will then read out these values from dmem and compare with expected results.

The file `dump.s` in the top folder also shows an example of assembly code that you can write to create your own test cases.  You can compile and disassemble as follows to generate the instruction codes.  Note that function calls need to be handled with care: the addresses for functions are not resolved till the Link step completes, so disassembled code will not look or work as expected.

```bash
$ riscv32-unknown-elf-gcc -c dump.s
$ riscv32-unknown-elf-objdump -d -Mnumeric,no-aliases dump.o
```

### Grading

Assignment 5 (Load/Store) and 6 (Branch) use the same test bench, and only differ in the test cases.  Therefore if you submit the same code for both that is perfectly fine.  However, if you have trouble implementing branching, you are advised to ensure that the Load/Store is correctly implemented so you get full credit for A5.

## HowTo

Fork this repostiry (`EE2003/a5`) into your namespace so that you can edit and push changes.

The `run.sh` script performs all the steps required to compile and test your code.  The `iverilog` compiler is used for running the verilog simulations.

**IMPORTANT**: do not rename files or create new files - otherwise the auto-grader will not recognize it.  Even if you change the `.drone.yml` file, the system will repeat the tests with different configuration files, and your changes will most likely not be recognized then.

Once you have confirmed that your code passes all the tests, commit all the changes, tag it for submission, and push to your repository.

## Date

Due Midnight, Oct 8, 2020
