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
;  File name: arraymain.asm
;  This module's call name: array_start
;  Language: X86-64
;  Syntax: Intel
;  Date last modified: 2015-September 24th
;  Purpose: This module will calculate the total interest payment and display the amount paid each month
;  Linux: nasm -f elf64 -l arraymain.lis -o arraymain.o arraymain.asm
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

extern sort													;An external c++ function that will be linked later

extern inputarray											;An external asm function that will be linked later

extern outputarray											;An external asm function that will be linked later

global array_start	                                        ;Make this program callable by other programs.

segment .data                                               ;Initialized data are placed in this segment



;==== Declare messages ====================================================================================================================================================

float_format db "%lf", 0									;Float format for a single float number

stringformat db "%s", 0					    				;General string format

welcome db 10, "Welcome to Array Processing programmed by Joseph Porter.", 10, 10, "Please enter quadword floats for storage in an array: ",10, 0

thankyou db "Thank you. This is the array: ", 10, 0

sortPoint db "Next the array will be sorted by pointers.", 10, 10, "The array after sorting by pointers is: ",10, 0

arrayPresent db "The array without sorting by pointers is still present: ", 10, 0



segment .bss						    					;Uninitialized data is placed here

align 64

data resq 50

pointers resq 50

;==== Begin area for Instructions
;==========================================================================================================================================================================

segment .text						    					;Place executable instructions in this segment.

array_start:						    					;Entry point. Execution begins here.

push		rbp						    					;This marks the start of a new stack frame belonging to this execution of this function.
mov			rbp, rsp					    				;rbp holds the address of the start of this new stack frame.  When this function returns to its caller rbp must
							    							;hold the same value it holds now.

;============= Welcome Message ==========================================
mov	qword	rax, 0											;No data from SSE will be printed
mov 		rdi, stringformat								;"%s"
mov			rsi, welcome									;"Welcome to Array Processing programmed by Joseph Porter.", "Please enter quadword floats for storage in an 
															;array: "
call		printf											;Call an external function to handle output

;============= Call inputarray ==========================================
; | rdi --> Address of Array
; | rax --> The number of elements in array

mov			rdi, data										;Copy the start address of the data array into rdi
call		inputarray										;Call and external asm function to handle input of array
push		rax												;Push the size of the array onto the stack

;============== Create the pointer array from the inputted data ======================
;mov			[pointers], data								;Copy the start address of data and place it into pointers
mov			r14, 0											;This will be the counter for the for loop
mov			r13, data										;Place the start of the array in r13
beginloop:													;None executing marker to start of loop
mov			rcx, [rsp]										;Move the size of the array into rcx to use in for loop
cmp			r14, rcx										;< or = or > result is stored in rflags
jg			loopfinish										;Jump to end of loop if r14 is greater than the size of array
movsd		xmm5, [r13]
movsd		[pointers+r14*8], xmm5							;Copy the address of the data element into the pointers array
inc			r14												;Add one to the counter of the array
add			r13, 8											;Add 8bytes to jump to next element in the array
jmp			beginloop										;Jump to the start of the loop for next iteration
loopfinish:													;jg jump to this spot if the counter is more than of equal to the size of the array

;============= Sort the pointers Array ========================
; | Place registers like this
; | rdi --> Start address of the array
; | rsi --> Total size of the array

mov			rdi, pointers
mov			rsi, [rsp]
call		sort

;============ Thank You Message ========================
mov qword	rax, 0											;No data from SSE will be printed
mov			rdi, stringformat								;"%s"
mov			rsi, thankyou									;"Thank you. This is the array: "
call 		printf											;Call and external function to handle output

;=========== Output the Array ==========================
; | Place registers like this
; |	rdi --> Start address of array
; | rsi --> Total size of the array
mov			rdi, data
mov			rsi, [rsp]
call		outputarray

;=========== Sort Points Message =======================
mov qword	rax, 0											;No data from SSE will be printed
mov 		rdi, stringformat								;"%s"
mov			rsi, sortPoint									;"Next the array will be sorted by pointers.", "The array after sorting by pointers is: "
call		printf											;Call and external function to handle output

;=========== Output the Array ==========================
; | Place registers like this
; |	rdi --> Start address of array
; | rsi --> Total size of the array
mov			rdi, pointers
mov			rsi, [rsp]
call		outputarray

;=========== Array Present Message =======================
mov qword 	rax, 0											;No data from SSE will be printed
mov	 		rdi, stringformat								;"%s"
mov			rsi, arrayPresent								;"The array without sorting by pointers is still present: "
call    	printf											;Call and external function to handle output

;=========== Output the Array =====================
; | Place registers like this
; |	rdi --> Start address of array
; | rsi --> Total size of the array
mov			rdi, data
mov			rsi, [rsp]
call		outputarray

;============ Reset the pointer to the start of the stack =================================================================================================================
mov 		rax, data										;Copy the sum(total interest)from the stack into xmm0
mov 		rsp, rbp										;Reset rsp to the original pointer
pop rbp														;Restore the original value to rbp

ret															;Pop an 8-byte integer from the stack into register rip, then resume execution at the address rip
;========== End of program interestmain.asm ===============================================================================================================================
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7*

