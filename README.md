# Pstring

Pstring is a library of assembly functions that allow working with Pstrings in a way similar to the `string.h` library in the C language.

## Introduction

A Pstring is defined as a struct, which will be stored in memory as follows:

typedef struct {
  char size;
  char string[255];
} Pstring;

## Assignment Summary

This project was developed as part of the Computer Architecture course. It involved implementing various operations on Pstrings (Pascal-style strings) using assembly language. Here's an overview of the tasks completed for this assignment:

### Task 1: Calculate Pstring Length
- When provided with the number 31, the program calculates and prints the lengths of two Pstrings using the `pstrlen` function.

### Task 2: Replace Characters
- When provided with the numbers 32 or 33, the program prompts the user to input two characters, `oldChar` and `newChar`. It then uses the `replaceChar` function to replace occurrences of `oldChar` with `newChar` in both Pstrings and prints the results.

### Task 3: Copy Pstring Substring
- When provided with the number 35, the program prompts the user to input two integer values, representing the start and end indices of a substring. It uses the `pstrijcpy` function to copy the substring from one Pstring to another and prints the modified Pstring.

### Task 4: Swap Case
- When provided with the number 36, the program uses the `swapCase` function to swap the case of English letters in both Pstrings (e.g., 'A' becomes 'a' and vice versa) and prints the results.

### Task 5: Compare Pstrings
- When provided with the number 37, the program prompts the user to input two integer values, representing the start and end indices of substrings within both Pstrings. It uses the `pstrijcmp` function to compare the substrings and prints the comparison result.

These tasks required implementing and utilizing various Pstring operations in assembly language, demonstrating proficiency in low-level programming and string manipulation.

## Getting Started

To use this library, follow these steps:

1. Clone this repository:
   git clone https://github.com/guyreuveni33/Pstring

2.Compile using the makefile.
   make

3.Run the program on Linux:
   ./a.out

## Runnign Example
<img src="https://i.postimg.cc/y8HW8wZ2/1.png" alt="image" height="800" width="400">

<img src="https://i.postimg.cc/L826pjdp/2.png" alt="image" height="600" width="200">
