//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
//Author information
//  Author name: Joseph Porter
//  Author email: porterj091@csu.fullerton.edu
//  Author CWID: 891686651
//  Author location: Fullerton, Calif.
//Course information
//  Course number: CPSC240
//  Assignment number: 7
//  Due date: 2015 - December 15th
//Project information
//  Project title: Stack Frames
//  Purpose: Experience the internal mechanisms of function calls
//  Project files: stackdriver.c stack2.c stack3.c stack4.c stackmain.asm
//Module information
//  File name: stackdriver.c
//  This module's call name: stack.out  This module is invoked by the user.
//  Language: C
//  Date last modified: 2015-December 1st
//  Purpose: This module is the top level driver: it will call stack2
//Translator information (Tested in Linux shell)
//  Gnu compiler: gcc -c -m64 -Wall -l stackdriver.lis -o stackdriver.o stackdriver.c
//  Gnu linker:   gcc -m64 -o stack.out stackdriver.o stack2.o stack3.o stack4.o stackmain.o debug.o
//  Execute:      ./stack.out
//References and credits
//  References: Professor Holliday for style and programming help
//Format information
//  Page width: 172 columns
//  Begin comments: 61
//  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
//Permission information
//	No restrictions
//===== Begin code area ===================================================================================================================================================

#include <stdio.h>
#include <stdint.h>                                         //To students: the second, third, and fourth header files are probably not needed.

extern void C2(double);   	            				//The "C" is a directive to the C++ compiler to use standard "CCC" rules for parameter passing.

int main()
{
  printf("%s\n%s\n","This is CSPC 240 Assignment 7 by Joseph Porter", "The main function has begun");
  double a = 5.2;
  double b = -1.6;
  printf("The variables are: a = %1.1lf, b = %1.1lf\n", a, b);
  printf("%s\n", "Function C2 will be called next");
  C2(a);
  printf("The variables are after calling C2: a = %1.1lf, b = %1.1lf\n", a, b);
  printf("%s\n", "The driver will now return a 0 to the operating system. Bye.");

  return 0;                                                 //'0' is the traditional code for 'no errors'.

}//End of main
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**

