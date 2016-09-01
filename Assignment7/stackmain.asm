;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7*
;Author information
;  Author name: Joseph Porter
;  Author email: porterj091@csu.fullerton.edu
;  Author location: Lake Forest, Calif.
;Course information
;  Course number: CPSC240
;  Assignment number: 7
;  Due date: 2015-Dec-15
;Project information
;  Project title: Stack Frames
;  Purpose: Experience the internal mechanisms of function calls
;  Status:
;  Project files: stackdriver.c stack2.c stack3.c stack4.c stackmain.asm
;Module information
;  File name: stackmain.asm
;  This module's call name: C5
;  Language: X86-64
;  Syntax: Intel
;  Date last modified: 2015-September 24th
;  Purpose: This module will calculate the total interest payment and display the amount paid each month
;  Linux: nasm -f elf64 -l stackmain.lis -o stackmain.o stackmain.asm
;References and credits
;  Profressor Holliday for the sample programs and style information
;Format information
;  Page width: 172 columns
;  Begin comments: 61
;  Optimal print specification: Landscape, 7 points, monospace, 8Â½x11 paper
;Permission information
;	No restrictions
;
;===== Begin area for include files =======================================================================================================================================

;%include "savedata.inc"                                    ;Not used in this program.  In most programs backing up registers is an important operation, but not here.

%include "debug.inc"                                       ;Not used in this program.  "debug.inc" is typically used during the development phase of programming.

;===== Begin area for source code =========================================================================================================================================

extern printf                                               ;This exernal subprogram will be linked later

extern scanf												;An external subprogram that will be linked later

global C5   		                                        ;Make this program callable by other programs.

segment .data                                               ;Initialized data are placed in this segment



;==== Declare messages ====================================================================================================================================================

long_format db "%ld", 0										;Float format for a single float number

stringformat db "%s", 0					    				;General string format

welcome db "Function C5 has begun", 10, "One imcoming value was received: %1.1lf", 10, "Here is the dumpstack you need.", 10, 0

changes db "Changes have been make to the stack, here is the stack for verification.", 10, 0

finished db "This assembly module is now finished and will return control to the caller.", 10, 0

segment .bss						    					;Uninitialized data is placed here

align 64


;==== Begin area for Instructions
;==========================================================================================================================================================================

segment .text						    					;Place executable instructions in this segment.

C5:									    					;Entry point. Execution begins here.

push		rbp						    					;This marks the start of a new stack frame belonging to this execution of this function.
mov			rbp, rsp					    				;rbp holds the address of the start of this new stack frame.  When this function returns to its caller rbp must
							    							;hold the same value it holds now.

push qword	0												;Push to allow the number coming in to be saved to the stack
movsd		[rsp], xmm0										;Save the number from caller to the stack

;================ Welcome Message =========================================================================================================================================
mov qword	rax, 1											;One SSE number will be outputted
mov			rdi, welcome									;"Function C5 has begun", 10, "One imcoming value was received: %1.1lf", 10, "Here is the dumpstack you need."
push qword	0												;Realign the boundry
call		printf											;Call an external function to handle the output
pop			rax												;Fix the push 2 steps ahead

dumpstack 50, 5, 33											;Dump the stack with 5 qwords below and 33 above

;================ Make changes to C4 ======================================================================================================================================
mov			rdx, -40										;Move -40 into rdx
cvtsi2sd	xmm0, rdx										;Convert the -40 into -40.0 to save in stack
movsd		[rsp + 48], xmm0								;Move the -40.0 into new position
mov			rdx, -41										;Move -41 into rdx
cvtsi2sd	xmm0, rdx										;Convert the -41 into -41.0 to save in stack
movsd		[rsp + 56], xmm0								;Move the -41.0 into new position
mov			rdx, -42										;Move -42 into rdx
cvtsi2sd	xmm0, rdx										;Convert the -32 into -42.0 to save in stack
movsd		[rsp + 64], xmm0								;Move the -42.0 into new position
mov			rdx, -43										;Move -43 into rdx
cvtsi2sd	xmm0, rdx										;Convert the -43 into -43.0 to save in stack
movsd		[rsp + 72], xmm0								;Move the -43.0 into new position

;============== Make changes to C3 ========================================================================================================================================
mov			rdx, -30										;Move -30 into rdx
cvtsi2sd	xmm0, rdx										;Convert the -30 into -30.0 to save in stack
movsd		[rsp + 120], xmm0								;Move the -30.0 into new position
mov			rdx, -31										;Move -31 into rdx
cvtsi2sd	xmm0, rdx										;Convert the -31 into -31.0 to save in stack
movsd		[rsp + 128], xmm0								;Move the -31.0 into new position
mov			rdx, -32										;Move -32 into rdx
cvtsi2sd	xmm0, rdx										;Convert the -32 into -32.0 to save in stack
movsd		[rsp + 136], xmm0								;Move the -32.0 into new position
mov			rdx, -33										;Move -33 into rdx
cvtsi2sd	xmm0, rdx										;Convert the -33 into -33.0 to save in stack
movsd		[rsp + 144], xmm0								;Move the -33.0 into new position

;=============== Make changes to C2 =======================================================================================================================================
mov			rdx, -20										;Move -20 into rdx
cvtsi2sd	xmm0, rdx										;Convert the -20 into -20.0 to save in stack
movsd		[rsp + 192], xmm0								;Move the -20.0 into new position
mov			rdx, -21										;Move -21 into rdx
cvtsi2sd	xmm0, rdx										;Convert the -21 into -21.0 to save in stack
movsd		[rsp + 200], xmm0								;Move the -21.0 into new position
mov			rdx, -22										;Move -22 into rdx
cvtsi2sd	xmm0, rdx										;Convert the -22 into -22.0 to save in stack
movsd		[rsp + 208], xmm0								;Move the -22.0 into new position

;=============== Make changes to C1 =======================================================================================================================================
mov			rdx, -10										;Move -10 into rdx
cvtsi2sd	xmm0, rdx										;Convert the -10 into -10.0 to save in stack
movsd		[rsp + 248], xmm0								;Move the -10.0 into new position
mov			rdx, -11										;Move -11 into rdx
cvtsi2sd	xmm0, rdx										;Convert the -11 into -11.0 to save in stack
movsd		[rsp + 256], xmm0								;Move the -11.0 into new position

;================ Make changes to return address of C4 ====================================================================================================================
; Can't seem to find the return address of C4 so I can't change it the place where it should show up is not there
; Really confused and could not figure it out.  Online it says that sometimes the complier holds the return address in a 
; register, and not on the stack, not sure if this is true.

;============= Changes message ============================================================================================================================================
mov qword 	rax, 0											;No data from SSE will be printed
mov			rdi, stringformat								;"%s"
mov			rsi, changes									;"Changes have been make to the stack, here is the stack for verification."
call		printf											;Call an external function to handle the output

dumpstack 51, 5, 33											;Dump the stack with 5 qwords below and 33 above

;============= Finished ===================================================================================================================================================
mov qword	rax, 0											;No data from SSE will be printed
mov 		rdi, stringformat								;"%s"
mov			rsi, finished									;"This assembly module is now finished and will return control to the caller."
call		printf											;Call an external function to handle the output

;============ Reset the pointer to the start of the stack =================================================================================================================
mov 		rsp, rbp										;Reset rsp to the original pointer
pop rbp														;Restore the original value to rbp

ret															;Pop an 8-byte integer from the stack into register rip, then resume execution at the address rip
;========== End of program interestmain.asm ===============================================================================================================================
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7*

