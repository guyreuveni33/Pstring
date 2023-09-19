// Guy reuveni 206398596
.section .rodata
format_string: .string " %s"
format_char: .string " %d"
format_option: .string " %d"

.section .text
.globl run_main
.type run_main,@function
run_main:
    pushq   %rbp                    # Save the old frame pointer on the stack
    movq    %rsp, %rbp              # Save the old frame pointer for debugging purposes
    subq    $528, %rsp              # Allocate space on the stack for local variables
    movq    $format_char, %rdi      # Load the format string into %rdi
    leaq    (%rsp), %rsi            # moving the stack pointer to rsi
    xorq    %rax, %rax              # reset %rax
    call    scanf                   # Call scanf to read in the string length value

    leaq    1(%rsp), %rsi           # moving the stack pointer to rsi
    movq    $format_string, %rdi    # Load the format string into %rdi
    movq    $0, %rax                # reset %rax
    call    scanf                   # Call scanf to read in the string value

    movq    $format_char, %rdi      # Load the format string into %rdi
    leaq    257(%rsp), %rsi         # moving the stack pointer to rsi
    xorq    %rax, %rax              # reset %rax
    call    scanf                   # Call scanf to read in the string length value

    movq    $format_string, %rdi    # Load the format string into %rdi
    leaq    258(%rsp), %rsi         # moving the stack pointer to rsi
    xorq    %rax, %rax              # reset %rax
    call    scanf                   # Call scanf to read in the string value

    movq    $format_option, %rdi    # Load format string into %rdi
    leaq    514(%rsp), %rsi         # moving the stack pointer to rsi
    xorq    %rax, %rax              # reset %rax
    call    scanf                   # Call scanf to read in the option

    movzbq  514(%rsp),%rdi          # option to rdi
    leaq    (%rsp),%rsi             # pString1 to rsi
    leaq    257(%rsp),%rdx          # pString2 to rdx
    call    func_select             # call the func select function

    addq    $528, %rsp              # Deallocate space on the stack for local variables
    movq    %rbp, %rsp              # Restore the old stack pointer
    popq    %rbp                    # Restore the old frame pointer
    xorq    %rax, %rax              # reset %rax
    ret                             # Return from the function
