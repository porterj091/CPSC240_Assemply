;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7*
;Author information
;  Author name: Joseph Porter
;  Author email: porterj091@csu.fullerton.edu
;  Author location: Lake Forest, Calif.
;Course information
;  Course number: CPSC240
;  Assignment number: 6
;  Due date: 2015-Dec-1
;Project information
;  Project title: Harmonic Series
;  Purpose: Work with arrays to sort and display
;  Status:
;  Project files: harmonicdriver.cpp harmonicmain.asm 
;Module information
;  File name: arraymain.asm
;  This module's call name: taylor_start
;  Language: X86-64
;  Syntax: Intel
;  Date last modified: 2015-September 24th
;  Purpose: This module will calculate the total interest payment and display the amount paid each month
;  Linux: nasm -f elf64 -l harmonicmain.lis -o harmonicmain.o harmonicmain.asm
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

long_format db "%ld", 0										;Float format for a single float number

stringformat db "%s", 0					    				;General string format

welcome db "This program will compute a partial sum of the harmonic series.", 10, 10
		db "These results were obtained on a Cyberpower Fangbook Pro with a Intel Core i7-4790 processor at 2.4GHz.", 10, 10, 0

enter_data db "Please enter a positive integer for the number of terms to include in the harmoic sum: ", 0

computed db "The harmoic sum H(%ld) is being computed.", 10
		 db "Please be patient . . . .", 10, 0

done db "The sum is now computed.", 10, 0

clock_after db "The clock time after computing the harmonic sum was %10ld.", 10, 0

clock_before db "The clock time before computing the sum was	    %10ld.", 10, 0

total_time db "The harmonic computation required %ld clock cycles (tics) which  is %1.0lf nanoseconds on this machine.", 10, 0

output db "The harmonic sum of %ld terms is %1.18lf, which is 0x%1.16lX.", 10, 0

end_message db "This assembly program will now return the harmonic sum and the last term to the caller.", 10, 0


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

;=========== Welcome Message ==============================================================================================================================================
mov qword	rax, 0											;No data from SSE will be printed
mov			rdi, stringformat								;"%s"
mov			rsi, welcome									;"This program will compute a partial sum of the harmonic series." ...
call		printf											;Call an external function to handle ouput

;=========== Enter Data message ===========================================================================================================================================
mov qword	rax, 0											;No data from SSE will be printed
mov			rdi, stringformat								;"%s"
mov			rsi, enter_data									;"Please enter a positive integer for the number of terms to include in the harmoic sum: "
call		printf											;Call an external function to handle output

;========== Get the Data from user ========================================================================================================================================
push qword	0												;Reserve 8 bytes of storage for the incoming input
mov qword	rax, 0											;SSE is not used in scanf operation
mov			rdi, long_format								;"%ld"
mov			rsi, rsp										;Point to a place where scanf can store the answer
call		scanf											;Call an external function to handle input

;========== Computed message ==============================================================================================================================================
mov qword	rax, 0											;No data from SSE will be printed
mov			rdi, computed									;"The harmoic sum H(%ld) is being computed.","Please be patient . . . ."
mov			rsi, [rsp]										;Copy the number of terms from the stack into rsi
call		printf											;Call an external function to handle output

;======== Place correct values in registers ===============================================================================================================================
mov			rcx, 0x3FF0000000000000							;Place 1.0 into the rcx register
push		rcx												;Push the 1.0 onto the stack to use in harmonic sum
mov			rcx, 0x4000000000000000							;Place 2.0 into the rcx register
push		rcx												;Push the 2.0 onto the stack to use in harmonic sum
mov			rcx, 0x4008000000000000							;Place 3.0 into the rcx register
push		rcx												;Push the 3.0 onto the stack to use in harmonic sum
mov			rcx, 0x4010000000000000							;Place 4.0 into the rcx register
push		rcx												;Push the 4.0 onto the stack to use in harmonic sum
vmovupd		ymm14, [rsp]									;Place the values into ymm11 -> | 1.0 | 2.0 | 3.0 | 4.0 |
vbroadcastsd ymm12, [rsp]									;Place 4.0 into ymm12 -> | 4.0 | 4.0 | 4.0 | 4.0 |
pop			rcx												;Pop the push of 4.0
pop			rcx												;Pop the push of 3.0
pop			rcx												;Pop the push of 2.0
vbroadcastsd ymm9, [rsp]									;Place 1.0 into ymm9 -> | 1.0 | 1.0 | 1.0 | 1.0 |
vbroadcastsd ymm13, [rsp]									;Place 1.0 into ymm12 -> | 1.0 | 1.0 | 1.0 | 1.0 |
pop			rcx												;Pop the push of 1.0
push qword	0												;Push 1.0 onto the stack
vbroadcastsd ymm15, [rsp]									;Place 0.0 into ymm10 -> | 0.0 | 0.0 | 0.0 | 0.0 |
pop			rax												;Reverse the push of 0

;========= Get start clock time ===========================================================================================================================================
cpuid														;Stop the cores for executing program
rdtsc														;Get the clock time in tics will place in lower half of rdx and rax
shl			rdx, 32											;Shift 32 bits left in rdx register
or			rdx, rax										;Smash rdx into rax getting the total time in tics stored in rdx
mov			r14, rdx										;Copy the answer from rdx into r14

;======== Begin the algoritum =============================================================================================================================================
mov			r13, [rsp]										;Copy the iterations from the stack into r13
mov			rax, r13										;Copy the iterations into rax
cqo															;
mov			r15, 4											;Move the divisor into r13
idiv		r15												;Divide iterations by 4
mov			rcx, 0											;The counter of iterations
beginloop:													;Marker to the start of the loop
cmp			rcx, rax										;Compare the counter with the number of terms
jge			loopfinish										;Jump to the end of the loop when counter > number of terms
vdivpd		ymm11, ymm13, ymm14								;Divide 1.0 by ymm14 -> | 1.0 | 2.0 | 3.0 | 4.0 |
vaddpd		ymm15, ymm11									;Add that term into the accumulator
vaddpd		ymm14, ymm12									;Add four to the divisor ymm14
inc			rcx												;Add four to the iterator
jmp  		beginloop										;Jump to the beginning of the loop
loopfinish:													;Marker to signify the end of the loop

;========= Get end clock time ============================================================================================================================================
cpuid														;Stop the cores for executing program
rdtsc														;Get the clock time in tics will place in lower half of rdx and rax
shl			rdx, 32											;Shift 32 bits left in rdx register
or			rdx, rax										;Smash rdx into rax getting the total time in tics stored in rdx
mov			r15, rdx										;Copy the answer from rdx into r15

;======= Save the last term calculated ====================================================================================================================================
movsd		xmm0, xmm11										;Copy the last term calculated into xmm0 to be saved on heap after algorithum
mov			rdx, [rsp+1*8]									;Get the 2nd argument from the stack into rdx
movsd		[rdx], xmm0										;Copy the last term calculated into the heap space

;=========== Finished the algoritum =======================================================================================================================================
mov qword	rax, 0											;No data from SSE will be printed
mov			rdi, stringformat								;"%s"
mov			rsi, done										;"The sum is now computed."
call		printf											;Call an external function to handle output



;====== Clock before ======================================================================================================================================================
mov qword 	rax, 0											;No data from SSE will be used
mov			rdi, clock_before								;"The clock time before computing the sum was	    %10ld."
mov			rsi, r14										;Copy the clock start time into rsi for printing
call 		printf											;Call an external function to handle the output

;====== Clock After =======================================================================================================================================================
mov qword 	rax, 0											;No data from SSE will be used
mov			rdi, clock_after								;"The clock time after computing the harmonic sum was %10ld."
mov			rsi, r15										;Copy the clock end time into rsi for printing
call 		printf											;Call an external function to handle the output

;======== Calculate the Total time taken ==================================================================================================================================
sub			r15, r14										;Subtract the before time from the after time
cvtsi2sd	xmm0, r15										;Convert the integer time into a float time for outputting
mov qword	rax, 1											;One number from SSE will be printed
mov			rdi, total_time									;"The harmonic computation required %ld clock cycles (tics) which  is %1.0lf nanoseconds on this machine."
mov			rsi, r15										;Copy the total time in tics to rsi for printing
mov			rcx, 0x4003333333333333							;Move 2.4 into rcx to divide later
push		rcx												;Push the 2.4 onto the stack
movsd		xmm1, [rsp]										;Copy the 2.4 from the stack into xmm1
divsd		xmm0, xmm1										;Divide the total tics by the clock speed
call		printf											;Call an external function to handle the output
pop			rax												;Pop the push of 2.4 earlier

;======= Get the total of the harmonic series =============================================================================================================================
vextractf128 xmm5, ymm15, 0									;Copy the lower parts of ymm15 and place into xmm0
movhlps		xmm1, xmm5										;Move the higher part of xmm0 into xmm1
vextractf128 xmm2, ymm15, 1									;Copy the higher parts of ymm15 and place into xmm2
movhlps		xmm3, xmm2										;Move the higher part of xmm2 into xmm3
addsd		xmm5, xmm1										;Add one part to xmm0
addsd		xmm5, xmm2										;Add second part to xmm0
addsd		xmm5, xmm3										;Add third part to xmm0

;======== Save the total harmonic series to the heap ======================================================================================================================
pop			rax												;Pop the iterations from the stack
pop			rsi												;Pop the 2nd argument from the stack
pop			rdx												;Pop the 1st argument from the stack
movsd		[rdx], xmm5										;Save the total harmonic series to the heap space
movsd		xmm0, xmm5										;Copy the sum to xmm0 for outputting

;======= Harmonic Sum Total Message =======================================================================================================================================
push qword  0												;Realign the boundry
push qword	0												;Push a number to be used to save the total harmonic series
movsd		[rsp], xmm5										;Copy the total harmonic series to the stack
mov qword	rax, 1											;One number from SSE will be printed
mov			rdi, output										;"The harmonic sum of %ld terms is %1.18lf, which is 0x%1.16lX."
mov			rsi, r13										;Copy the number of terms going to be printed
mov			rdx, [rsp]										;Get the total harmoinc series to be used for hex representation
call		printf											;Call an external function to handle the output
pop			rax												;Pop the push to save the total harmonic series
pop			rax												;Pop the push to align the boundry


;========= Print the end message ==========================================================================================================================================
mov qword	rax, 0											;No data from SSE will be printed
mov			rdi, stringformat								;"%s"
mov			rsi, end_message								;"This assembly program will now return the harmonic sum and the last term to the caller."
call		printf											;Call an external function to handle the output


;============ Reset the pointer to the start of the stack =================================================================================================================
mov 		rsp, rbp										;Reset rsp to the original pointer
pop rbp														;Restore the original value to rbp

ret															;Pop an 8-byte integer from the stack into register rip, then resume execution at the address rip
;========== End of program harmonicmain.asm ===============================================================================================================================
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7*

