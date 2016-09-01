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
;  File name: inputarray.asm
;  This module's call name: inputarray
;  Language: X86-64
;  Syntax: Intel
;  Date last modified: 2015-September 24th
;  Purpose: This module will get the array and return its size
;  Linux: nasm -f elf64 -l inputarray.lis -o inputarray.o inputarray.asm
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

global inputarray	                                        ;Make this program callable by other programs.

segment .data                                               ;Initialized data are placed in this segment


;==== Declare messages ====================================================================================================================================================

float_format db "%lf", 0									;Float format for a single float number

stringformat db "%s", 0					    				;General string format

characterformat db " %c"									;Character format for a single char 

doyou_message db "Do you have data to enter into the array (Y or N)? ", 0

enter_float db "Enter the next float number: ", 0


segment .bss						    					;Uninitialized data is placed here

align 64

;==== Begin area for Instructions
;==========================================================================================================================================================================

segment .text						    					;Place executable instructions in this segment.

inputarray:						    						;Entry point. Execution begins here.

push		rbp						    					;This marks the start of a new stack frame belonging to this execution of this function.
mov			rbp, rsp					    				;rbp holds the address of the start of this new stack frame.  When this function returns to its caller rbp must
							    							;hold the same value it holds now.

;=============== Setup for For loop ================
push		rdi												;This will push the address of the array onto stack
push qword  0												;This will be used as a counter of the array
beginloop:													;non-executing marker

;================ DoYou Message ====================
mov qword 	rax, 0											;No data from SSE will be printed
mov 		rdi, stringformat								;"%s"
mov			rsi, doyou_message								;"Do you have data to enter into the array (Y or N)? "
call 		printf											;Call an external function to handle output

;================ Get the answer ==================
push qword	0												;Reserve 8 bytes to store answer 
mov qword	rax, 0											;SSE not used in scanf operation
mov			rdi, characterformat							;"%c"
mov			rsi, rsp										;Point to a place where scanf can store its value
call		scanf											;Call an external function to handle input
mov			r13, [rsp]										;Pop the anwser into rdi to see if user inputted 'Y'
pop			rax												;Pop the stack to remove the answer
mov			r12, 'Y'										;If user enters 'Y' then proceed with the loop

;============== Check if user wants to enter number ======================
cmp			r13, r12										;< or = or > result is stored in rflags
jne	 		loopfinish										;jne jump to end of loop if user didn't input 'Y'

;============== Enter the float number for the array =====================
mov qword	rax, 0											;No data from SSE will be printed
mov 		rdi, stringformat								;"%s"
mov			rsi, enter_float								;"Enter the next float number: "
call 		printf											;Call and external function to handle output

;============== Get the number from the user ===============================
push qword	0												;Reserve 8 bytes to store scanf input
mov qword 	rax, 0											;SSE not used in scanf operation
mov			rdi, float_format								;"%lf"
mov			rsi, rsp										;Point to stack where scanf can store its value
call		scanf											;Call an external function to handle input

;=============== Place input into array ====================================
movsd 		xmm5, [rsp]										;Copy the answer from the stack into xmm5
pop			rax												;Pop the answer stored on the stack
mov			rcx, [rsp]										;Get the current counter from stack and store it in rcx
mov			rdi, [rsp+1*8]									;Copy the address of the start of the array
movsd		[rdi+rcx*8], xmm5								;Copy the answer into the array's element
inc			rcx												;Increment the counter to access next element in array
mov			[rsp], rcx										;Copy the counter to the stack for use in next iteration

;============== Finsih the loop ==============================================
jmp beginloop												;Jump to the start of the loop for next iteration
loopfinish:													;Marker for when the user inputs something other than 'Y'



;============ Reset the pointer to the start of the stack =================================================================================================================
mov			rax, [rsp]										;Return the total number of elements in the array will return in rax
mov 		rsp, rbp										;Reset rsp to the original pointer
pop rbp														;Restore the original value to rbp

ret															;Pop an 8-byte integer from the stack into register rip, then resume execution at the address rip
;========== End of program interestmain.asm ===============================================================================================================================
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7*

