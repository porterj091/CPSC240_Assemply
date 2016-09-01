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
;  Project title: Amortization Schedule
;  Purpose: Work with arrays to sort and display
;  Status:
;  Project files: arraydriver.cpp arraymain.asm sortfunction.cpp inputarray.asm outputarray.asm sortarray.asm
;Module information
;  File name: outputarray.asm
;  This module's call name: outputarray
;  Language: X86-64
;  Syntax: Intel
;  Date last modified: 2015-September 24th
;  Purpose: This will print a array with a given size
;  Linux: nasm -f elf64 -l outputarray.lis -o outputarray.o outputarray.asm
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

extern printf                                               ;This exernal subprogram will be linked later

extern scanf												;An external subprogram that will be linked later

global outputarray	                                        ;Make this program callable by other programs.

segment .data                                               ;Initialized data are placed in this segment

;==== Declare messages ====================================================================================================================================================

stringformat db "%s", 0					    				;General string format

menubar db "Index		Physical address	Hex value		Decimal value", 10, 0

output db "%d 		%016lX 	0x%016lX 	%1.11lf", 10, 0

segment .bss						    					;Uninitialized data is placed here

align 64

;==== Begin area for Instructions
;==========================================================================================================================================================================

segment .text						    					;Place executable instructions in this segment.

outputarray:						    					;Entry point. Execution begins here.

push		rbp						    					;This marks the start of a new stack frame belonging to this execution of this function.
mov			rbp, rsp					    				;rbp holds the address of the start of this new stack frame.  When this function returns to its caller rbp must
							    							;hold the same value it holds now.

;============= Place the address and size on the stack ===================
push 		rdi												;Is holding the start address of the array
push		rsi												;Is holding the size of the array

;============ Display the menubar message =======================
mov	qword	rax, 0											;SSE not used in printf operations
mov			rdi, stringformat								;"%s"
mov			rsi, menubar									;"Index		Physical address		Hex value		Decimal value"
call		printf											;Call an external function to handle the output

;============ Set up for the for loop ================
push qword	0												;Store zero on the stack to be used as the counter will be incremented
mov			r13, [rsp+2*8]									;Copy the start address for the array into r13
beginloop:													;Non executing marker used to start the loop
mov			r14, [rsp+1*8]									;Copy the size from the stack into r14
mov			r12, [rsp]										;Copy the counter from the stack into r12
cmp			r12, r14										;< or = or > result is stored in rflags
jge			loopfinish										;If the counter is greater than or equal to the size jump to the end of loop

;=========== Print the Array contents none Pointer =================

mov			rsi, r12										;Copy the counter into rsi to use in printf index value
mov			rdx, r13										;Copy the element into rdx to use in printf address value
mov			rcx, [r13]										;Copy the element into rdx to use in printf hex value
movsd		xmm0, [r13]										;Copy the element into xmm0 to use in printf decimal value

add			r13, 8											;Add 8 bytes to go to next element in the array
push		r13												;Push the element on the stack before printf changes it

push qword	0												;Realign the boundry
mov qword	rax, 1											;SSE will need to print one float number
mov			rdi, output										;"%d%25p%25x%1.11lf"
call		printf											;Call an external function to handle the output
pop			rax												;Reverse the push from earlier
pop			r13												;Pop the stack to return the element to r13


inc			r12												;Increment the counter to use in next iteration
mov			[rsp], r12										;Copy the counter to the stack to use in nect iteration

jmp			beginloop										;Return to the start of the for loop
loopfinish: 												;Marker for when exit condition is met

;============ Reset the pointer to the start of the stack =================================================================================================================
mov 		rsp, rbp										;Reset rsp to the original pointer
pop rbp														;Restore the original value to rbp

ret															;Pop an 8-byte integer from the stack into register rip, then resume execution at the address rip
;========== End of program interestmain.asm ===============================================================================================================================
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7*

