;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7*
;Author information
;  Author name: Joseph Porter
;  Author email: porterj091@csu.fullerton.edu
;  Author location: Lake Forest, Calif.
;Course information
;  Course number: CPSC240
;  Assignment number: 3
;  Due date: 2015-Sep-29
;Project information
;  Project title: Bank Interest
;  Purpose: This program will analyze direct current circuits configured in parallel
;  Status:
;  Project files: interestdriver.cpp interestmain.asm interestfunction.cpp
;Module information
;  File name: interestmain.asm
;  This module's call name: interest_calc
;  Language: X86-64
;  Syntax: Intel
;  Date last modified: 2015-September 8th
;  Purpose: This module will perform the calculations to find the current that passes between the 4 circuits
;  Linux: nasm -f elf64 -l interestmain.lis -o interestmain.o interestmain.asm
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

extern monthly_payment										;An external c function that will be linked later

global interest_calc                                        ;Make this program callable by other programs.

segment .data                                               ;Initialized data are placed in this segment

;==== Declare messages ====================================================================================================================================================

float_format db "%lf", 0									;Float format for a single float number

long_format db "%d", 0										;Long format for a single long number

welcome db 10, "Welcome to the Bank of Rich Man", 10, "Joseph Porter", 10, 10, 0

enter_rate db "Please enter the current prime interest rate as a float number: ", 0

enter_loan db "Enter the amounts of the loan: ", 0

enter_months db "Enter the time of the loan as a whole number of months: ", 0

schedule_message db "The repayment schedule for this loan is:", 10, 10, 0

first_line db "Month	Monthly		Paid on 	Paid on 	Principal", 10, 0

second_line db "Number 		Payment 	Interest 	Principal 	at end of month", 10, 0

conclusion db "Thank you for your inquiry at our bank.", 10, 0

return_message db "This program will now return the total interest paid to the driver.", 10, 0

stringformat db "%s", 0					    				;General string format



segment .bss						    					;Uninitialized data is placed here

align 64

;==== Begin area for Instructions
;==========================================================================================================================================================================

segment .text						    					;Place executable instructions in this segment.

interest_calc:						    					;Entry point. Execution begins here.

push		rbp						    					;This marks the start of a new stack frame belonging to this execution of this function.
mov			rbp, rsp					    				;rbp holds the address of the start of this new stack frame.  When this function returns to its caller rbp must
							    							;hold the same value it holds now.
;=============== Show the initial message =================================================================================================================================
mov qword	rax, 0											;No data from the SSE will be printed
mov			rdi, stringformat								;"%s"
mov 		rsi, welcome									;"This program will help analyze direct current circuits configured in parallel" 
call 		printf											;Call a library function to make the output

;================ Prompt for the floating interest rate ===================================================================================================================
mov qword	rax, 0											;No data from the SSE will be printed
mov			rdi, stringformat								;"%s"
mov 		rsi, enter_rate									;"Please enter the current prime interest rate as a float number: "
call 		printf											;Call a library function to make the output

;========= Set up to enter the float interest rate =============================
push qword	0												;Reserve 8bytes for the input from scanf
mov qword	rax, 0											;SSE is not used in scanf operations
mov			rdi, float_format								;"%lf"
mov 		rsi, rsp										;Point to a place where scanf can reserve the number
call 		scanf											;Call a library function to handle input

;======= Promt for the total loan ======================
mov qword	rax, 0											;No data from the SSE will be printed
mov 		rdi, stringformat								;"%s"
mov 		rsi, enter_loan									;"Enter the amounts of the loan: "
call 		printf											;Call a library function to make the output

;====== Set up to enter the loan amount ==============================
push qword	0												;Reserve 8 bytes for scanf operation
mov qword	rax, 0											;SSE is not used in scanf operations
mov 		rdi, float_format								;"%lf"
mov 		rsi, rsp										;Point to a place where scanf can reserve the number
call 		scanf											;Call a library function to handle input

;======= Prompt to enter total time in months ===================
mov qword	rax, 0											;No data from SSE will be printed
mov 		rdi, stringformat								;"%s"
mov 		rsi, enter_months								;"Enter the time of the loan as a whole number of months: "
call 		printf											;Call a library function to make the output

;======= Set up to enter the time in months =================
push qword	0;												;Reserve 8 bytes for scanf operation
mov qword	rax, 0											;SSE is not used in scanf operations
mov 		rdi, long_format								;"%d"
mov 		rsi, rsp										;Point to a place where scanf can reserve the number
call 		scanf											;Call a library function to handle the input

;======== Display repayment schedule message ================
mov qword	rax, 0											;No data from the SSE will be printed
mov 		rdi, stringformat								;"%s"
mov 		rsi, schedule_message							;"The repayment schedule for this loan is:"
call 		printf											;Call a library function to make the output

;======== Find out the amount for the monthly payments ================
movsd 		xmm0, [rsp+(2*8)]
movsd		xmm1, [rsp+(1*8)]
mov 		r10, [rsp]
call		monthly_payment


;======== Set up the for loop ===================
;mov 		rcx, 0											;Initialize loop counter to 0
;mov 		r12, [rsp]										;Place the total months on r12 for total iteration time
;beginloop:													;non-executing marker
;cmp			rcx, r12										;< or = or > result is stored in rflags
;jge 		loopfinish										;jge checks inside of rflags to see what was stored there by cmp

;do body of the loop

;inc 		rcx
;jmp 		beginloop
;loopfinished:												;A marker to stop the for loop

;========= Display the conclusion message ====================
mov qword 	rax, 0											;No data from the SSE will be printed
mov 		rdi, stringformat								;"%s"
mov 		rsi, conclusion									;"Thank you for your inquiry at our bank."
call 		printf											;Call a library function to make the output

; =========== Reset the pointer to the start of the stack =================================================================================================================
movsd 		xmm0, [rsp]										;Copy the sum(total Power)from the stack into xmm0
mov 		rsp, rbp										;Reset rsp to the original pointer
pop rbp														;Restore the original value to rbp

ret															;Pop an 8-byte integer from the stack into register rip, then resume execution at the address rip
;========== End of program circuit_power.asm ==============================================================================================================================
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7*

