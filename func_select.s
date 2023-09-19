// Guy reuveni 206398596
.section .rodata
format_Invalid_Option: .string "invalid option!\n"
format_char: .string " %c"
format_digit: .string " %d"

format_pstrlen1: .string "first pstring length: %d, "
format_pstrlen2: .string "second pstring length: %d\n"
format_replace_char:.string "old char: %c, new char: %c, first string: %s, second string: %s\n"
format_pstrijcpy:.string "length: %d, string: %s\n"
format_swap: .string "length: %d, string: %s\n"
format_cmp:.string "compare result: %d\n"
.align 8
.L10:
.quad .L1
.quad .L2
.quad .L3
.quad .L4
.quad .L5
.quad .L6
.quad .L7

.section .text
.global func_select
.type func_select,@function
func_select:
    pushq   %rbp                        # push rbp to the stack
    movq    %rsp, %rbp                  # for correct debugging
    pushq   %r12                        # push r12 to the stack
    pushq   %r13                        # push hr13 to the stack
    movq    %rsi,%r12                   # ptr1
    movq    %rdx,%r13                   # ptr2
    subq    $31,%rdi                    # reduce 31 from the option the user inserted
    cmpq    $0,%rdi                     # check if the option value the user inserted is invalid
    jl      .L8                         # if the value of the option is invalid jump to L8 label
    cmpq    $7,%rdi                     # check if the option value the user inserted is invalid
    jae     .L8                         # if the value of the option is invalid jump to L8 label
    jmp *    .L10(,%rdi,8)              # jump to the right line according the user input
.L1:
    movq    %r12,%rdi                   # ptr1
    call    pstrlen                     # call pstrlen function
    movq    $format_pstrlen1, %rdi      # Load the format_pstrlen1 into %rdi
    movq    %rax,%rsi                   # moving the return of the function to rsi
    xorq    %rax, %rax                  # reset %rax
    call    printf                      # Call printf function
    movq    %r13,%rdi                   # ptr2
    call    pstrlen                     # call pstrlen function
    movq    %rax,%rsi                   # moving the return of the function to rsi
    movq    $format_pstrlen2, %rdi      # Load the format_pstrlen2 into %rdi
    xorq    %rax, %rax                  # reset %rax
    call    printf                      # Call printf function
    jmp     .L9
.L2:
    subq    $16,%rsp                    # move rsp register 16 bytes in the stack
    movq    $format_char, %rdi          # Load the format_char into %rdi
    leaq    (%rsp), %rsi                # moving the stack pointer to rsi
    xorq    %rax, %rax                  # reset %rax
    call    scanf                       # Call scanf to read in the input value

    movq    $format_char, %rdi          # Load the format_char into %rdi
    leaq    8(%rsp), %rsi               # moving the stack pointer to rsi
    xorq    %rax, %rax                  # reset %rax
    call    scanf                       # Call scanf to read in the input value

    leaq    (%rsp),%rsi                 # old char for the first call of replacechar
    leaq    8(%rsp),%rdx                # new char for the first call of replacechar
    movq    %r12,%rdi                   # moving the string to rdi
    call    replaceChar                 # call the replacechar function
    movq    %rax,%r12                   # move the string after the replaceChar function
    leaq    (%rsp),%rsi                 # old char for the first call of replacechar
    leaq    8(%rsp),%rdx                # new char for the first call of replacechar
    movq    %r13,%rdi                   # moving the string to rdi
    call    replaceChar                 # call the replacechar function
    movq    %rax,%r13                   # move the string after the replaceChar function
    movq    (%rsp),%rsi                 # moving old char to printf
    movq    8(%rsp),%rdx                # moving new char to printf
    incq    %r12                        # forward for the first string value
    movq    %r12,%rcx                   # moving first string to the printf
    incq    %r13                        # forward for the second string value
    movq    %r13,%r8                    # moving first string to the printf
    movq    $format_replace_char, %rdi  # Load the address of the format_replace_char string into %rdi
    xorq    %rax, %rax                  # reset %rax
    call    printf                      # Call printf function
    jmp     .L9                         # jump to label 9
.L3:
    jmp     .L2                         # jump to L2 label
.L4:
    jmp     .L8                         # jump to L8 label
.L5:
    subq     $16,%rsp                   # moving rsp 16 bytes lower on the stack
    movq    $format_digit, %rdi         # Load the address of the format string into %rdi
    leaq    (%rsp), %rsi                # moving the stack pointer to rsi
    xorq    %rax, %rax                  # reset %rax
    call    scanf                       # Call scanf to read in the input value
    movq    $format_digit, %rdi         # Load the address of the format_digit into %rdi
    leaq    8(%rsp), %rsi               # moving the stack pointer to rsi
    xorq    %rax, %rax                  # reset %rax
    call    scanf                       # Call scanf to read in the input value
    movzbq  (%rsp),%rdx                 # old char for the first call of replacechar
    movzbq  8(%rsp),%rcx                # new char for the first call of replacechar
    movq    %r12,%rdi                   # move  the first string to rdi
    movq    %r13,%rsi                   # move the second string to rsi
    call    pstrijcpy                   # call the pstrijcpy function
    cmpq    $0,%rax                     # check if the value return from pstrijcpy is 0
    je      .L15
    movq    $format_pstrijcpy, %rdi     # Load the format string into %rdi
    movzbq  (%r12), %rsi                # moving the length value to rsi in order to print
    movq    %rax,%rdx                   # moving the string value to rsi in order to print
    xorq    %rax, %rax                  # reset %rax
    call    printf                      # Call printf function
    movq    $format_pstrijcpy, %rdi     # Load the format string into %rdi
    movzbq  (%r13), %rsi                # moving the length value to rsi in order to print
    incq    %r13                        # forwarding for the string value
    movq    %r13,%rdx                   # moving the string value to rsi in order to print
    xorq    %rax, %rax                  # reset %rax
    call    printf                      # Call printf function
    jmp     .L9                         # jump to label 9
.L15:
    movq    $format_pstrijcpy, %rdi     # Load the format string into %rdi
    movzbq  (%r12), %rsi                # moving the length value to rsi in order to print
    incq    %r12                        # forwarding for the string value
    movq    %r12,%rdx                   # moving the string value to rsi in order to print
    xorq    %rax, %rax                  # reset %rax
    call    printf                      # Call printf function

    movq    $format_pstrijcpy, %rdi     # Load the format string into %rdi
    movzbq  (%r13), %rsi                # moving the length value to rsi in order to print
    incq    %r13                        # forwarding for the string value
    movq    %r13,%rdx                   # moving the string value to rsi in order to print
    xorq    %rax, %rax                  # reset %rax
    call    printf                      # Call printf function
    jmp     .L9                         # jump to label 9
.L6:
    movq    %r12,%rdi                   # moving the first string to rdi
    call    swapCase                    # call the swapCase function
    movq    $format_swap, %rdi          # Load the format_swap into %rdi
    movzbq  (%r12), %rsi                # moving the length of the string to rsi
    movq    %rax,%rdx                   # moving the return string of the function to rdx
    xorq    %rax, %rax                  # reset %rax
    call    printf                      # Call printf function
    movq    %r13,%rdi                   # moving the second string to rdi
    call    swapCase                    # call the swapCase function
    movq    $format_swap, %rdi          # Load the format string into %rdi
    movzbq  (%r13), %rsi                # moving the length of the string to rsi
    movq    %rax,%rdx                   # moving the return string of the function to rdx
    xorq    %rax, %rax                  # reset %rax
    call    printf                      # Call printf function
    jmp     .L9                         # jump to label 9

.L7:
    subq    $16,%rsp                    # moving rsp 16 bytes lower on the stack
    movq    $format_digit, %rdi         # Load the format string into %rdi
    leaq    (%rsp), %rsi                # moving the stack pointer to rsi
    xorq    %rax, %rax                  # reset %rax
    call    scanf                       # Call scanf to read in the input value

    movq    $format_digit, %rdi         # Load the format_digit into %rdi
    leaq    8(%rsp), %rsi               # moving the stack pointer to rsi
    xorq    %rax, %rax                  # reset %rax
    call    scanf                       # Call scanf to read in the input value

    movzbq  (%rsp),%rdx                 # old char for the first call of replacechar
    movzbq  8(%rsp),%rcx                # new char for the first call of replacechar
    movq    %r12,%rdi                   # move the first string to rdi
    movq    %r13,%rsi                   # move the second string to rdi
    call    pstrijcmp                   # call the pstrijcmp function

    movq    %rax,%rsi                   # move the return value of pstrijcmp to rsi
    movq    $format_cmp, %rdi           # Load the format string into %rdi
    xorq    %rax, %rax                  # reset %rax
    call    printf                      # Call printf function
    jmp     .L9                         # jump to label 9
.L8:
    movq    $format_Invalid_Option,%rdi # Load the format_Invalid_Option into %rdi
    xorq    %rax, %rax                  # reset %rax
    call    printf                      # Call printf function
.L9:
    popq    %r13                        # pop r13 register from the stack
    popq    %r12                        # pop r13 register from the stack
    movq    %rbp,%rsp                   # move the rbg register to rsp
    popq    %rbp                        # pop rbp register from the stack
    ret                                 # return
