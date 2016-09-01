;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7*
;Author information
;  Author name: Joseph Porter
;  Author email: porterj091@csu.fullerton.edu
;  Author location: Lake Forest, Calif.
;Course information
;  Course number: CPSC240
;  Assignment number: 3
;  Due date: 2015-Oct-20
;Project information
;  Project title: Array Processing
;  Purpose: Work with arrays to sort and display
;  Status:
;  Project files: arraydriver.cpp arraymain.asm sortfunction.cpp inputarray.asm outputarray.asm sortarray.asm
;Module information
;  File name: arraymain.asm
;  This module's call name: swap
;  Language: X86-64
;  Syntax: Intel
;  Date last modified: 2015-September 24th
;  Purpose: This module will swap the two values passed to it
;  Linux: nasm -f elf64 -l swaparray.lis -o swaparray.o swaparray.asm
;References and credits
;  Profressor Holliday for the sample programs and style information
;Format information
;  Page width: 172 columns
;  Begin comments: 61
;  Optimal print specification: Landscape, 7 points, monospace, 8Â½x11 paper
;
;===== Begin area for include files =======================================================================================================================================

;%include "savedata.inc"                                    ;Not used in this program.  In most programs backing up registers is an important operation, but not here.

;%include "debug.inc"                                       ;Not used in this program.  "debug.inc" is typically used during the development phase of programming.

;===== Begin area for source code =========================================================================================================================================

global swap     	                                        ;Make this program callable by other programs.

segment .data                                               ;Initialized data are placed in this segment

segment .bss						    					;Uninitialized data is placed here

align 64

;==== Begin area for Instructions
;==========================================================================================================================================================================

segment .text						    					;Place executable instructions in this segment.

swap:       						    					;Entry point. Execution begins here.

push		rbp						    					;This marks the start of a new stack frame belonging to this execution of this function.
mov			rbp, rsp					    				;rbp holds the address of the start of this new stack frame.  When this function returns to its caller rbp must
							    							;hold the same value it holds now.

;=========== Swap the two values =====================
mov         r14, [rdi]                                      ;Copy the number stored in the first address to r14
mov         r15, [rsi]                                      ;Copy the number stored in the second address to r15
mov         [rdi], r15                                      ;Copy the second number to first address
mov         [rsi], r14                                      ;Copy the first number to second address

;============ Reset the pointer to the start of the stack =================================================================================================================

mov 		rsp, rbp										;Reset rsp to the original pointer
pop rbp														;Restore the original value to rbp

ret															;Pop an 8-byte integer from the stack into register rip, then resume execution at the address rip
;========== End of program interestmain.asm ===============================================================================================================================
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7*

