;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7*
;Author information
;  Author name: Joseph Porter
;  Author email: porterj091@csu.fullerton.edu
;  Author location: Lake Forest, Calif.
;Course information
;  Course number: CPSC240
;  Assignment number: 2
;  Due date: 2015-Sep-10
;Project information
;  Project title: Electric Circuits in Parallel
;  Purpose: This program will analyze direct current circuits configured in parallel
;  Status:
;  Project files: Spheredriver.c spheremain.asm
;Module information
;  File name: circuit_power.asm
;  This module's call name: circuit_power
;  Language: X86-64
;  Syntax: Intel
;  Date last modified: 2015-August 25th
;  Purpose: This module will perform the calculations to find the current that passes between the 4 circuits
;  Linux: nasm -f elf64 -l circuit.lis -o circuitmain.o circuit_power.asm
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

global circuit_power                                        ;Make this program callable by other programs.

segment .data                                               ;Initialized data are placed in this segment

;==== Declare messages ====================================================================================================================================================

fourfloats db "%lf%lf%lf%lf",0				    			;Will allow four float numbers to be inputted

float_format db "%lf", 0									;Float format for a single float number

welcome db 10, "This program will help analyze direct current circuits configured in parallel", 10, 0

voltenter db "Please enter the voltage of the entire circuit in volts: ", 0

circuitenter db "Enter the power of 4 devices (watts) separated by space and press enter: ", 0

thankyoumessage db 10, "Thank you. The computations have completed with the following results.", 10,10, 0

voltoutput db "Circuit total voltage: %1.18lf V", 10, 0	    ;Output the total voltage in floating point format with units in Volts

devicemessage db "Device number:		1			2			3			4", 10, 0

poweroutput db "Power (watts):  %1.18lf  %1.18lf  %1.18lf  %1.18lf", 10, 0

currentoutput db "Current (amps): %1.18lf  %1.18lf  %1.18lf  %1.18lf", 10,10, 0 

totalcurrent db "Total current in the circuit is %1.18lf amps.", 10, 0

totalpower db "Total power in the circuit is %1.18lf watts.", 10, 0

goodbye db "The analyzer program will now return the total power to the driver.", 10,10, 0

stringformat db "%s", 0					    				;General string format



segment .bss						    					;Uninitialized data is placed here

align 64

;==== Begin area for Instructions
;==========================================================================================================================================================================

segment .text						    					;Place executable instructions in this segment.

circuit_power:						    					;Entry point. Execution begins here.

push		rbp						    					;This marks the start of a new stack frame belonging to this execution of this function.
mov			rbp, rsp					    				;rbp holds the address of the start of this new stack frame.  When this function returns to its caller rbp must
							    							;hold the same value it holds now.
;=============== Show the initial message =================================================================================================================================
mov qword	rax, 0											;No data from the SSE will be printed
mov			rdi, stringformat								;"%s"
mov 		rsi, welcome									;"This program will help analyze direct current circuits configured in parallel" 
call 		printf											;Call a library function to make the output

;================ Prompt for the floating voltage number ==================================================================================================================
mov qword	rax, 0											;No data from the SSE will be printed
mov			rdi, stringformat								;"%s"
mov 		rsi, voltenter									;"Please enter the voltage of the entire circuit in volts: " 
call 		printf											;Call a library function to make the output

;================ Obtain the float number (total Voltage) from user and store in ymm9 =====================================================================================

push qword	0												;Reserve 8 bytes of storage for the incoming float number
mov qword	rax, 0											;SSE is not used in scanf operation
mov			rdi, float_format								;"%lf"
mov 		rsi, rsp										;Point to a place where scanf can reserve the number
call 		scanf											;Call a library function to do the input work

;================== Prompt the 4 devices to be inputted ===================================================================================================================
mov qword	rax,0											;No data from the SSE will be printed
mov 		rdi, stringformat								;"%s"
mov 		rsi, circuitenter								;"Enter the power of 4 devices (watts) separated by space and press enter: "
call 		printf											;Call a library function to do the input

;================ Obtain the 4 circuit power comsumptions in Watts ========================================================================================================

mov 		rdi, fourfloats									;"%lf%lf%lf%lf"
push qword  0												;Reserve 8 bytes of storage for the incoming float number
mov 		rsi, rsp										;Copy first inputted number from stack to rsi registure
push qword	0												;Reserve 8 bytes of storage for the incoming float number
mov 		rdx, rsp										;Copy second inputted number from stack to rdx registure
push qword	0												;Reserve 8 bytes of storage for the incoming float number
mov 		rcx, rsp										;Copy third inputted number from stack to rcx registure
push qword	0												;Reserve 8 bytes of storage for the incoming float number
mov 		r8, rsp											;Copy fourth inputted number from stack to r8 registure
mov 		rax, 0											;SSE is not used in scanf operation
call 		scanf 											;Call a library function to do the input work

;==================== Show thankyou message ===============================================================================================================================
mov qword	rax,0											;NO data from the SSE will be printed
mov 		rdi, stringformat								;"%s"
mov 		rsi, thankyoumessage							;"Thank you. The computations have completed with the following results."
call 		printf											;Call a library function to do the printing

;==================== Total Voltage message ===============================================================================================================================
push qword	0 												;Advance to a 16-byte boundary
movsd 		xmm0, [rsp+5*8]									;Copy the fifth number on the stack which is the total voltage into xmm0
mov 		rax, 1											;Tells printf one number is being printed
mov 		rdi, voltoutput 								;"Circuit total voltage: %1.18lf V"
call 		printf											;Call a library function to do the printing
pop 		rax												;Reverse the push

;==================== Device number message ===============================================================================================================================
mov qword	rax, 0 											;No data from the SSE will be printed
mov 		rdi, stringformat								;"%s"
mov			rsi, devicemessage								;"Device number:	1	2	3	4"
call 		printf 											;Call a library function to do the printing

;==================== Show the power in each device =======================================================================================================================
push qword  0 												;Advance to a 16-byte boundary
movsd 		xmm0, [rsp+4*8]									;Copy first inputted number from stack into xmm0
movsd 		xmm1, [rsp+3*8]									;Copy second inputted number from stack into xmm1
movsd 		xmm2, [rsp+2*8]									;Copy third inputted number from stack into xmm2
movsd 		xmm3, [rsp+1*8] 								;Copy fourth inputted number from stack into xmm3
mov qword 	rax, 4 											;Tell printf four numbers are being outputted
mov 		rdi, poweroutput 								;"Power (watts):  %1.18lf  %1.18lf  %1.18lf  %1.18lf"
call 		printf 											;Call a library function to print
pop 		rax												;Reverse the push 7 steps ahead

;========= Divide the power by the total voltage ==========================================================================================================================
movsd 		xmm4, [rsp+4*8] 								;Copy the divisor(Total Voltage) from stack to xmm4
movsd 		xmm0, [rsp+3*8] 								;Copy the first input number from stack into xmm0
movsd 		xmm1, [rsp+2*8]									;Copy the second input number from stack into xmm1
movsd 		xmm2, [rsp+1*8] 								;Copy the third input number from stack into xmm2
movsd 		xmm3, [rsp+0*8] 								;Copy the fourth input number from stack into xmm3
divsd 		xmm0, xmm4										;Divide xmm0 by the divisor(total voltage)
divsd 		xmm1, xmm4										;Divide xmm1 by the divisor(total voltage)
divsd		xmm2, xmm4										;Divide xmm2 by the divisor(total voltage)
divsd 		xmm3, xmm4										;Divide xmm3 by the divisor(total voltage)

;========== Add all currents together to xmm6 =============================================================================================================================
push qword	0												;Push 0 to stack for xmm6
movsd		xmm6, [rsp]										;Zero out xmm6 to add inputs
addsd		xmm6, xmm0										;Add xmm0 to xmm6
addsd		xmm6, xmm1										;Add xmm1 to xmm6
addsd 		xmm6, xmm2										;Add xmm2 to xmm6
addsd 		xmm6, xmm3										;Add xmm3 to xmm6
movsd		[rsp], xmm6										;Place total sum(total amps) onto stack

;============ Show the current in each device =============================================================================================================================
mov qword	rax, 4 											;Tell printf four numbers are being outputted
mov 		rdi, currentoutput 								;"Current (amps):  %1.18lf  %1.18lf  %1.18lf  %1.18lf"
call 		printf 											;Call a library function to do the print

;=========== Show total current in each device ============================================================================================================================
movsd 		xmm0, [rsp+0*8]									;Copy the sum of amps from stack to xmm0
mov qword	rax, 1											;Tell printf how many number to print
mov 		rdi, totalcurrent								;"Total current in the circuit is %1.18lf amps."
call 		printf											;Call a library function to do the print
pop			rax												;Reverse the push

;============== Sum the total power from all 4 devices ====================================================================================================================
movsd 		xmm1, [rsp+3*8]									;Copy the first inputted number from stack into xmm1
movsd		xmm2, [rsp+2*8]									;Copy the first inputted number from stack into xmm2
movsd		xmm3, [rsp+1*8]									;Copy the third inputted number from stack into xmm3
movsd		xmm4, [rsp+0*8]									;Copy the fourth inputted number from stack into xmm4

push qword	0												;Push 0 to stack for xmm0
movsd		xmm0, [rsp]										;Zero out xmm0 to add inputs
addsd		xmm0, xmm1										;Add xmm1 to xmm0
addsd		xmm0, xmm2										;Add xmm2 to xmm0
addsd		xmm0, xmm3										;Add xmm3 to xmm0
addsd		xmm0, xmm4										;Add xmm4 to xmm0
movsd		[rsp], xmm0										;Copy the sum to the stack

;=============== Show the total power from all 4 devices ==================================================================================================================
mov qword	rax, 1											;Tells printf one number will be outputted
mov			rdi, totalpower									;"Total power in the circuit is %1.18lf watts."
call		printf											;Call a library function to do the print

;============ Conclusion message ==========================================================================================================================================
mov qword	rax, 0											;No data from the SSE will be printed
mov 		rdi, stringformat								;"%s"
mov 		rsi, goodbye									;"The analyzer program will now return the total power to the driver."
call 		printf											;Call a library function to do the hard work

; =========== Reset the pointer to the start of the stack =================================================================================================================
movsd 		xmm0, [rsp]										;Copy the sum(total Power)from the stack into xmm0
mov 		rsp, rbp										;Reset rsp to the original pointer
pop rbp														;Restore the original value to rbp

ret															;Pop an 8-byte integer from the stack into register rip, then resume execution at the address rip
;========== End of program circuit_power.asm ==============================================================================================================================
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7*

