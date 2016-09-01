;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7*
;Author information
;  Author name: Joseph Porter
;  Author email: porterj091@csu.fullerton.edu
;  Author location: Lake Forest, Calif.
;Course information
;  Course number: CPSC240
;  Assignment number: 5
;  Due date: 2015-Nov-12
;Project information
;  Project title: Powers of e
;  Purpose: Calculate the taylor series
;  Status:
;  Project files: taylordriver.cpp taylormain.asm
;Module information
;  File name: arraymain.asm
;  This module's call name: array_start
;  Language: X86-64
;  Syntax: Intel
;  Date last modified: 2015-November 11th
;  Purpose: This module is to calculate the taylor series
;  Linux: nasm -f elf64 -l taylormain.lis -o taylormain.o taylormain.asm
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

;%include "debug.inc"                                       ;Not used in this program.  "debug.inc" is typically used during the development phase of programming.

;===== Begin area for source code =========================================================================================================================================

extern printf                                               ;This exernal subprogram will be linked later

extern scanf												;An external subprogram that will be linked later

global taylor_start	                                        ;Make this program callable by other programs.

segment .data                                               ;Initialized data are placed in this segment



;==== Declare messages ====================================================================================================================================================

float_format db "%lf", 0									;Float format for a single float number

stringformat db "%s", 0					    				;General string format

welcome db 10, "This program will compute e^x for four values of x", 10, "Vector processing will be used to compute all four numbers concurrently", 10, 10, 0

enter_mes db "Please enter 4 exponents and 1 integer represent the number of terms in the Taylor series: ", 0

enter_data db "%lf %lf %lf %lf %ld", 0

begun db "The Taylor series algorithum has begun. Please be patient.", 10, 10, 0

complete db "The algorithm has completed successfully. The computed values are these.", 10, 0

output db "exp(%1.9lf) = %1.18lf", 10, "exp(%1.9lf) = %1.18lf", 10, "exp(%1.9lf) = %1.18lf", 10, "exp(%1.9lf) = %1.18lf", 10, 0

clock_before db "The clock before the algorithm began was %lu", 10, 0

clock_after db "The clock when the algorithm ended was 	 %lu", 10, 10, 0

run db "The run tim eof the algorithm alone was %lu tics = %1.0lf ns.", 10, 10, 0

return_mes db "This program will now return the computed powers of e to the caller. Enjoy your exponents.", 10, 0


segment .bss						    					;Uninitialized data is placed here

align 64


;==== Begin area for Instructions
;==========================================================================================================================================================================

segment .text						    					;Place executable instructions in this segment.

taylor_start:						    					;Entry point. Execution begins here.

push		rbp						    					;This marks the start of a new stack frame belonging to this execution of this function.
mov			rbp, rsp					    				;rbp holds the address of the start of this new stack frame.  When this function returns to its caller rbp must
							    							;hold the same value it holds now.

push		rdi												;Push the first argument
push		rsi												;Push the second argument
push		rdx												;Push the third argument
push		rcx												;Push the fourth argument

;======= Welcome Message ==================================================================================================================================================
mov qword 	rax, 0											;No data from SSE will be used
mov			rdi, stringformat								;"%s"
mov			rsi, welcome									;"This program will compute e^x for four values of x", "Vector processing will be used to compute all four..."
call		printf											;Call an external function to handle output

;======== Enter Message ===================================================================================================================================================
mov	qword	rax, 0											;No data from SSE will be used
mov			rdi, stringformat								;"%s"
mov			rsi, enter_mes									;"Please enter 4 exponents and 1 integer represent the number of terms in the Taylor series: "
call		printf											;Call an external function to handle output

;======= Get Numbers ======================================================================================================================================================
mov			rdi, enter_data									;"%lf %lf %lf %lf %ld"
push qword	0												;Push 8 bytes to store the 1th number
mov			rsi, rsp										;Point to stack for 1st number
push qword	0												;Push 8 bytes to store the 2th number
mov			rdx, rsp										;Point to stack for 2nd number
push qword	0												;Push 8 bytes to store the 3th number
mov			rcx, rsp										;Point to stack for 3rd number
push qword	0												;Push 8 bytes to store the 4th number
mov			r8, rsp											;Point to stack for 4th number
push qword	0												;Push 8 bytes to store the number of iterations
mov			r9, rsp											;Point to stack for 5th number
mov			rax, 0											;SSE is not used in scanf operations
call		scanf											;Call an external function to handle input

;========== Begun message =================================================================================================================================================
mov qword	rax, 0											;No data from SSE will be used
mov			rdi, stringformat								;"%s"
mov			rsi, begun										;"The Taylor series algorithum has begun. Please be patient."
call		printf											;Call an external function to handle output

;========= Place data in registers ========================================================================================================================================
pop			r13												;Pop the iterating number into r13 from stack
vmovupd		ymm12, [rsp]									;Copy the four inputted numbers from stack into ymm13
pop			rax												;Pop the push for 1st number
pop			rax												;Pop the push for 2nd number
pop			rax												;Pop the push for 3rd number
pop			rax												;Pop the push for 4th number

mov			rcx, 0x3FF0000000000000							;Move 1.0 into rcx to use in next operation
push 		rcx												;Push 1.0 to the stack to use in next operation
vbroadcastsd ymm8, [rsp]									;Copy 1.0 into the entire ymm8 register
vbroadcastsd ymm13, [rsp]									;Copy 1.0 into the entire ymm13 register for first run of algorithm
vbroadcastsd ymm10, [rsp]									;Copy n into the entire ymm10 register to use in algorithm
vbroadcastsd ymm9, [rsp]									;Copy 1.0 into ymm9 for accumulater
pop			rax												;Pop the push of 1.0 2 steps ahead

;========= Registures look like this ======================================================================================================================================
;All of them are 1.0 for the first iteration since it will always be 1.0
; Constant -> 		ymm8 	| 1.0 | 1.0 | 1.0 | 1.0 |	
; Previous term -> 	ymm13 	| 1.0 | 1.0 | 1.0 | 1.0 |	
; Acumulator -> 	ymm9 	| 1.0 | 1.0 | 1.0 | 1.0 |	
; Nth number -> 	ymm10 	| 1.0 | 1.0 | 1.0 | 1.0 |	
; Exponent -> 		ymm12 	| 1.0 | 2.0 | -1.0 | 0.5 |	

;========= Get start clock time ===========================================================================================================================================
cpuid														;Stop the cores for executing program
rdtsc														;Get the clock time in tics will place in lower half of rdx and rax
shl			rdx, 32											;Shift 32 bits left in rdx register
or			rdx, rax										;Smash rdx into rax getting the total time in tics stored in rdx
mov			r12, rdx										;Copy the answer from rdx into r12

;========= After the one iteration of the loop registers will look like this ==============================================================================================
; Constant -> 		ymm8 	| 1.0 | 1.0 | 1.0 | 1.0 |	
; Previous term -> 	ymm13 	| 1.0 | 2.0 | -1.0 | 0.5 |	
; Acumulator -> 	ymm9 	| 2.0 | 3.0 | 0.0 | 1.5 |	
; Nth number -> 	ymm10 	| 2.0 | 2.0 | 2.0 | 2.0 |	
; Exponent -> 		ymm12 	| 1.0 | 2.0 | -1.0 | 0.5 |	

;========= Start the algorithm ============================================================================================================================================

mov			rcx, 1											;Move 0 to rcx to be used as a counter
beginloop:													;Non executing marker
cmp			rcx, r13										;Compare rcx with the total number of iterations
jge			loopfinish										;Jump to end of loop if counter is greater than or equal to iterations
vmulpd		ymm13, ymm12									;Multiply the previous term by x
vdivpd		ymm13, ymm10									;Divide the previous term by n + 1
vaddpd		ymm10, ymm8										;Add 1.0 to n to use in next iteration
vaddpd 		ymm9, ymm13										;Add the term to the accumulator
inc			rcx												;Increment the counter by 1
jmp			beginloop										;Jump to the beginning of the loop
loopfinish:													;Marker for the end of the loop

;========= Get end clock time =============================================================================================================================================
cpuid														;Stop the cores for executing program
rdtsc														;Get the clock time in tics will place in lower half of rdx and rax
shl			rdx, 32											;Shift 32 bits left in rdx register
or			rdx, rax										;Smash rdx into rax getting the total time in tics stored in rdx
mov			r13, rdx										;Copy the answer from rdx into r11

;======== Move Data into right registers ==================================================================================================================================
vextractf128 xmm0, ymm12, 0									;Move the lower half of exponents into xmm0
movhlps		xmm2, xmm0										;Move upper half of xmm0 into xmm2 for exponents
vextractf128 xmm4, ymm12, 1									;Move the upper half of exponents into xmm4
movhlps		xmm6, xmm4										;Move upper half of xmm4 into xmm6 for exponents
vextractf128 xmm1, ymm9, 0									;Move the lower half of answers into xmm1
movhlps		xmm3, xmm1										;Move upper half of xmm1 into xmm3 for answers
vextractf128 xmm5, ymm9, 1									;Move the upper half of answers into xmm5
movhlps		xmm7, xmm5										;Move upper half of xmm5 into xmm7 for answers

;========== Save the Exponents into heap ==================================================================================================================================
pop			rcx												;Retrieve the fourth argument from stack
pop			rdx												;Retrieve the third argument from stack
pop			rsi												;Retrieve the second argument from stack
pop			rdi												;Retrieve the first argument from stack
push qword 	0												;Make 8 bytes of storage for the exponent
movsd		[rsp], xmm1										;Copy the first answer onto the stack
mov			rax, [rsp]										;Copy the answer from the stack into rax
mov			[rdi], rax										;Copy first answer into the heap
movsd		[rsp], xmm3										;Copy the second answer onto the stack
mov			rax, [rsp]										;Copy the answer from the stack into rax
mov			[rsi], rax										;Copy second answer into the heap
movsd		[rsp], xmm5										;Copy the third answer onto the stack
mov			rax, [rsp]										;Copy the answer from the stack into rax
mov			[rdx], rax										;Copy third answer into the heap
movsd		[rsp], xmm7										;Copy the fourth answer onto the stack
mov			rax, [rsp]										;Copy the answer from the stack into rax
mov			[rcx], rax										;Copy fourth answer into the heap
pop			rax												;Reverse the push of answer holder

mov qword	rax, 8											;8 numbers from SSE will be used
mov			rdi, output										;"exp(%1.8lf) = %1.18lf" ...
call		printf											;Call an external function to handle the output

;====== Clock before ======================================================================================================================================================
mov qword 	rax, 0											;No data from SSE will be used
mov			rdi, clock_before								;"The clock before the algorithm began was %lu"
mov			rsi, r12										;Copy the clock start time into rsi for printing
call 		printf											;Call an external function to handle the output

;====== Clock After =======================================================================================================================================================
mov qword 	rax, 0											;No data from SSE will be used
mov			rdi, clock_after								;"The clock when the algorithm ended was %lu"
mov			rsi, r13										;Copy the clock end time into rsi for printing
call 		printf											;Call an external function to handle the output

;======= Find the total time ==============================================================================================================================================
sub			r13, r12										;Subtract the starttime from the endtime
mov			rdi, run										;The run tim eof the algorithm alone was %lu tics = %1.0lf ns.
mov			rsi, r13										;Move the total time in tics into rsi for printf
mov			rcx, 0x4003333333333333							;Move the GHz into rcx, which is 2.4
push		rcx												;Push the 2.4 to the stack
movsd		xmm1, [rsp]										;Copy the divisor into xmm1 from the stack
pop			rax												;Reverse the push 2 steps ahead
cvtsi2sd	xmm0, r13										;Convert the integer time into a double time
divsd		xmm0, xmm1										;Divide the total time in tics by the Ghz
mov qword	rax, 1											;One number from SSE will be printed
call		printf											;Call an external function to handle the output

;============ Reset the pointer to the start of the stack =================================================================================================================
mov 		rsp, rbp										;Reset rsp to the original pointer
pop rbp														;Restore the original value to rbp

ret															;Pop an 8-byte integer from the stack into register rip, then resume execution at the address rip
;========== End of program interestmain.asm ===============================================================================================================================
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7*

