;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
;Author information
;  Author name: Joseph Porter
;  Author email: porterj091@csu.fullerton.edu
;  Author location: Lake Forest, Calif.
;Course information
;  Course number: CPSC240
;  Assignment number: 1
;  Due date: 2015-Aug-25
;Project information
;  Project title: Test Presence of AVX
;  Purpose: This program will use some instructions that apply only to the AVX component.  If these instructions are successful then there is strong reason to believe
;           that the current platform has the AVX component.  There are other compact techniques to test for the presence of the AVX component, but this program also
;           includes sample instructions accessing AVX data.
;  Status:
;  Project files: Spheredriver.c spheremain.asm
;Module information
;  File name: spheremain.asm
;  This module's call name: spheredemo
;  Language: X86-64
;  Syntax: Intel
;  Date last modified: 2015-August 18th
;  Purpose: This module will perform the calculations to find the area an volume from the test data.
;Translator information
;  Linux: nasm -f elf64 -l spheremain.lis -o spheremain.o spheremain.asm
;References and credits
;  Profressor Holliday for the sample programs and style information
;Format information
;  Page width: 172 columns
;  Begin comments: 61
;  Optimal print specification: Landscape, 7 points, monospace, 8Â½x11 paper
;
;===== Begin area for include files =======================================================================================================================================

;%include "savedata.inc"                                     ;Not used in this program.  In most programs backing up registers is an important operation, but not here.


%include "debug.inc"                                        ;Not used in this program.  "debug.inc" is typically used during the development phase of programming.

;===== Begin area for source code =========================================================================================================================================

extern printf                                               ;This subprogram will be linked later

extern scanf

global spheredemo                                           ;Make this program callable by other programs.

segment .data                                               ;Initialized data are placed in this segment

align 16                                                    ;Start new data on a 16-byte boundary

;===== Declare some messages ==============================================================================================================================================

welcome db "Welcome to the spheres program.  This program will compute the surface area and volume of a sphere.", 10, 0

enterinfo db "Please enter the radius of the sphere: ", 0

farewell db "I hope you enjoyed using my program as much as I enjoyed making it.  Bye.", 10, 0

;===== Declare formats for output =========================================================================================================================================

spheredemo.stringformat db "%s", 0

spheredemo.outputmessage db "The sphere with radius %1.18lf has area %1.18lf and volume &1.18f.", 10, 0

eight_byte_format db "%lf", 0

segment .bss
align 64
mainstoragearea resb 952

;==========================================================================================================================================================================
;===== Begin the application here: ==================================================================
;==========================================================================================================================================================================

segment .text                                               ;Instructions are placed in this segment

spheredemo:                                                    ;Execution of this program will begin here.

align 16                                                    ;Start the next instruction on a 16-byte boundary.  Typically this is not necessary.

;The next two instructions must be performed at the start of every assembly program.
push       rbp                                              ;This marks the start of a new stack frame belonging to this execution of this function.
mov        rbp, rsp                                         ;rbp holds the address of the start of this new stack frame.  When this function returns to its caller rbp must
                                                            ;hold the same value it holds now.

;===== Output the welcome message =========================================================================================================================================
;At this point there are no data in any register of value to this program.  Therefore, printf will be called without backing up any data.

mov qword rdi, .stringformat                                ;"%s"
mov qword rsi, welcome                                      ;
mov qword rax, 0                                            ;
call      printf                                            ;An external function handles output.

;===== Output Enter information for the user ==============================================================================================================================
mov qword rdi, .stringformat                                ;"%s"
mov qword rsi, enterinfo                                    ;
mov qword rax, 0                                            ;Zero in rax indicates printf receives no data from vector registers
call      printf                                            ;An external function handles output.

;========= Have the user enter the information ====================================
push	qword 0						    ;Reserve 8 bytes of storage
mov	qword rax, 0
mov	rdi, eight_byte_format
mov	rsi, rsp
call	scanf
movsd	xmm0, [rsp]
pop	rax

;showfpuregisters 133

;=============== Perform arithmitic operations on the inputted number to find area ==================
mov	rax, xmm0
mov	rbx, xmm0
mul	rbx
mov 	rax, 1
call	printf

;=========== reset the pointer to start of the stack =========================
pop rbp
ret


;===== End of program spheredemo ==============================================================================================================================================
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**


