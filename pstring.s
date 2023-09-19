// Guy reuveni 206398596
.data
.section .rodata
format_Invalid_Input: .string "invalid input!\n" # this will be the message in case of invalid input from the user

.section .text
.globl pstrlen
.type pstrlen,@function
pstrlen:                                # this will return this length of a string
    pushq   %rbp                        # push the rpb register to the stack
    movq    %rsp,%rbp                   # push the rsp to the rbp place
    movzbq  (%rdi),%rax                 # moving the first byte of rdi that contain the string length to rax register
    jmp     .Exit                       # jump to the exit label


.section .text
.globl replaceChar
.type replaceChar,@function
replaceChar:                            # this will replace chars in the string according to the user input
    pushq   %rbp                        # push the rpb register to the stack
    movq    %rsp,%rbp                   # push the rpb register to the stack
    movq    %rdi,%rax                   # saving pointer to the pstring
    movzbq  (%rdi),%r10                 # saving the string length
    incq    %rdi                        #increament the register of rdi by one
    xorq    %r8,%r8                     # reset r8
    leaq    (%rdi),%r8                  # in order to move forward the string and not the length of the char
    xorq    %r9,%r9                     # reset r9
    movzbq  (%rsi),%r9                  # moving the old char of the user we would like to check if appear on the string
.ReplacementLoop:
    cmpb    %r9b,(%r8)                  # this will compare one char each time of the string with the char the user inserted
    jne     .Continue                   # if the chars are'nt equals, jump to continue label
    movzbq  (%rdx),%r11                 # moving the new char of the user we would like to swap for
    movb    %r11b,(%r8)                 # replacing the old char in the new char
    incq    %r8                         # move the for the next char on the string
    subq    $1,%r10                     # reduce one of the string length (our counter)
    cmpq    $0,%r10                     # check if we need to loop again
    jne     .ReplacementLoop            # if r10 isn't equal to zero jump to ReplacementLoop
    jmp     .Exit                       # if we end looping, jump to the exit label
.Continue:                              # in case there is no need to replace the chars
    incq    %r8                         # move the for the next char on the string
    subq    $1,%r10                     # reduce one of the string length (our counter)
    cmpq    $0,%r10                     # check if the counter(%r10) equal zero
    jne     .ReplacementLoop            # if the counter(%r10) is not zero jmp back to Loop1
    jmp     .Exit                       # jump to the exit label

.section .text
.globl pstrijcpy
.type pstrijcpy,@function
pstrijcpy:                              # this get two strings, and copy substring of the second string to the first according to the user input
    pushq   %rbp                        # push the rpb register to the stack
    movq    %rsp, %rbp                  # push the rpb register to the stack
    pushq   %r14                        # push the r14 register to the stack
    pushq   %r15                        # push the r15 register to the stack
    xorq    %r14,%r14                   # reset r14
    xorq    %r15,%r15                   # reset r15
    leaq    1(%rdi), %r8                # this will move the string only to r8 register
    leaq    (%rdi), %r14                # moving the first string to r14
    leaq    (%rsi), %r9                 # moving the second string to r9
    movq    %rdx, %r10                  # moving i value to r10
    movq    %rcx, %r11                  # moving j value to r11
    cmpb    $0,%r10b                    # check if the i value is invalid
    jl      .Error_Cpy                  # jump to the error label
    cmpb    $0,%r11b                    # check if the j value is invalid
    jl      .Error_Cpy                  # jump to the error label
    cmpb    (%r14),%r11b                # check if the j value is invalid
    jns     .Error_Cpy                  # jump to the error label
    cmpb    (%r9),%r11b                 # check if the j value is invalid
    jns     .Error_Cpy                  # jump to the error label
    cmpb    (%r14),%r10b                # check if the i value is invalid
    jns     .Error_Cpy                  # jump to the error label
    cmpb    (%r9),%r10b                 # check if the i value is invalid
    jns     .Error_Cpy                  # jump to the error label
    addq    %rdx,%r14                   # moving to the i char in the first string
    addq    %rdx,%r9                    # moving to the i char in the second string
.Iterate:                               # this will iterate the string
    cmpq    %rdx, %rcx                  # compare j-i
    js      .Done                       # if the are equal jump to done label
    subq    $1, %rcx                    # reducing the j by one
    incq    %r14                        # moving for the next char in the string
    incq    %r9                         # moving for the next char in the string
    movq    (%r9), %r15                 # moving the second string
    movb    %r15b, (%r14)               # copy char from the second string to the first string
    jmp     .Iterate                    # jump to the iterate label
.Done:
    movq    %r8, %rax                   # moving the string to rax
    popq   %r15                         # pop the r15 register out of the stack
    popq   %r14                         # pop the r14 register out of the stack
    jmp     .Exit                       # jump to exit label
.Error_Cpy:                             # in case the i or the j are'nt valid value
    movq    $format_Invalid_Input,%rdi  # Load the format string into %rdi
    xorq    %rax, %rax                  # reset %rax
    call    printf                      # Call printf function
    xorq    %rax, %rax                  # reset %rax
    popq   %r15                         # pop the r15 register out of the stack
    popq   %r14                         # pop the r14 register out of the stack
    jmp     .Exit

.section .text
.globl swapCase
.type swapCase,@function
swapCase:                               # this will swap chars in the string,Uppercase to Lowercase and vise versa
    pushq   %rbp                        # push the rpb register to the stack
    movq    %rsp,%rbp                   # push the rpb register to the stack
    movzbq  (%rdi),%r10                 # moving the length of the string to the r10 regsiter
    incq    %rdi                        # moving the first input of the user to the string address
    movq    %rdi,%r8                    # moving the string the r8 register
    movq    %rdi,%rax                   # move rdi to rax in order to return it in the end of the function
    leaq    (%rdi),%r9                  # move  the string to r9 register
    jmp     .LoopUpperCase              # jump to LoopUpperCase label
.ForwardingNotLetter:                   # in case there is no need to swap the letter, like @
    leaq    1(%r9),%r9                  # forwarding to the next char in the string
    subq    $1,%r10                     # reducing the counter of the loop
    cmpq    $0,%r10                     # check if we still need to loop
    jne     .LoopUpperCase              # jump to LoopUpperCase label
    movq    %r8,%rax                    # moving the string to the rax register
    jmp     .Exit                       # jump to Exit label
.Forwarding:
    incq     %r9                        # forwarding to the next char in the string
.LoopUpperCase:                         # loop for uppercase
    cmpb    $65,(%r9)                   # check if this is upper or lower case
    js      .ForwardingNotLetter        # jump to ForwardingNotLetter label
    cmpb    $90,(%r9)                   # check if this is upper or lower case
    jns     .LoopLowerCase              # jump to LoopLowerCase label
    addq    $32,(%r9)                   # converting to lower case
    subq    $1,%r10                     # reducing the counter of the loop
    cmpq    $0,%r10                     # check if we still need to loop
    jne     .Forwarding                 # jump to Forwarding label
    movq    %r8,%rax                    # moving the string to the rax register
    jmp     .Exit                       # jump to Exit label
.LoopLowerCase:                         # loop for lowercase
    cmpb    $97,(%r9)                   # check if this is upper or lower case
    js      .ForwardingNotLetter        # in case there is no need to change the letter
    cmpb    $123,(%r9)                  # check if this is upper or lower case
    jns     .ForwardingNotLetter        # in case there is no need to change the letter
    subq    $32,(%r9)                   # converting to upper case
    subq    $1,%r10                     # reducing the counter of the loop
    cmpq    $0,%r10                     # check if we still need to loop
    jne     .Forwarding                 # jump to Forwarding label
    movq    %r8,%rax                    # moving the string to the rax register
    jmp     .Exit                       # jump to Exit label
.Error:
    movq    $format_Invalid_Input, %rdi # Load the format string into %rdi
    xorq    %rax,%rax                   # reset %rax
    call    printf                      # Call printf function
    jmp     .Exit                       # jump to Exit label

.section .text
.globl pstrijcmp
.type pstrijcmp,@function
pstrijcmp:
    pushq   %rbp                        # push the rpb register to the stack
    movq    %rsp,%rbp                   # push the rpb register to the stack
    pushq   %r14                        # push the r14 register to the stack
    pushq   %r15                        # push the r15 register to the stack
    xorq    %r14,%r14                   # reset r14
    xorq    %r15,%r15                   # reset r15
    leaq    1(%rdi), %r8                # move the string to r8
    leaq    (%rdi), %r14                # move the first string to r14
    leaq    (%rsi), %r9                 # move the second string to r9
    xorq    %r10,%r10                   # reset r10
    movq    %rdx, %r10                  # moving i to r10
    xorq    %r11,%r11                   # reset r11
    movq    %rcx, %r11                  # moving j to r11
    cmpb    $0,%r10b                    # check if the i value is invalid
    jl      .Error_Cmp                  # jump to Error_Cmp label
    cmpb    $0,%r11b                    # check if the j value is invalid
    jl      .Error_Cmp                  # jump to Error_Cmp label
    cmpb    (%r14),%r11b                # check if the j value is invalid
    jg     .Error_Cmp                   # jump to Error_Cmp label
    cmpb    (%r9),%r11b                 # check if the j value is invalid
    jg     .Error_Cmp                   # jump to Error_Cmp label
    cmpb    (%r14),%r10b                # check if the i value is invalid
    jg     .Error_Cmp                   # jump to Error_Cmp label
    cmpb    (%r9),%r10b                 # check if the i value is invalid
    jg     .Error_Cmp                   # jump to Error_Cmp label
    addq    %rdx,%r14                   # moving to the i char in the first string
    addq    %rdx,%r9                    # moving to the i char in the second string
    addq    $1,%rcx                     # add one to the j
    jmp     .Equal                      # jump to Equal label
.Subtract:
    subq    $1, %rcx                    #reduce one from j value
.Equal:
    cmpq    %rdx, %rcx                  #j-i
    je      .Neutral                    # jump to Neutral labe
    incq    %r14                        # forwarding the first string to the next char
    incq    %r9                         # forwarding the second string to the next char
    movzbq  (%r14),%r15                 # moving one char to another register for the compare in the next line
    cmpb    %r15b,(%r9)                 # checking whice char is greater
    je      .Subtract                   # jump to Decrement label
    cmpb    %r15b,(%r9)                 # checking whice char is greater
    js      .Positive                   # jump to Positive label
    cmpb    %r15b,(%r9)                 # checking whice char is greater
    ja      .Negative                   # jump to Negative label
.Negative:                              # if the first string is lower by lexicographic order, according the range the user set
    movq    $-1,%rax                    # move -1 to the rax, in order to return it
    popq   %r15                         # pop the r15 register out of the stack
    popq   %r14                         # pop the r14 register out of the stack
    jmp     .Exit                       # jump to Exit label
.Positive:                              # if the first string is greater by lexicographic order,according the range the user set
    movq    $1,%rax                     # move 1 to the rax, in order to return it
    popq   %r15                         # pop the r15 register out of the stack
    popq   %r14                         # pop the r14 register out of the stack
    jmp     .Exit                       # jump to Exit label
.Neutral:                               # if the two strings are equals, according the range the user set
    movq    $0,%rax                     # move 0 to the rax, in order to return it
    popq   %r15                         # pop the r15 register out of the stack
    popq   %r14                         # pop the r14 register out of the stack
    jmp     .Exit                       # jump to Exit label
.Error_Cmp:                             # in case the user set worng range
    movq    $format_Invalid_Input, %rdi # Load the format string into %rdi
    xorq    %rax,%rax                   # reset %rax
    call    printf                      # Call printf function
    movq    $-2,%rax                    # move 2 to the rax, in order to return it
    popq   %r15                         # pop the r15 register out of the stack
    popq   %r14                         # pop the r14 register out of the stack
.Exit:
    movq    %rbp,%rsp                   # move the rbp to rsp
    popq    %rbp                        # pop rbp
    ret                                 #return
