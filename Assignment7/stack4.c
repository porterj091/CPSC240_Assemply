//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
/*
  Author: Joseph Porter
  Email:  porterj091@csu.fullerton.edu
  Course: CPSC 240
  Assignment: 7
  Due date: December 15th, 2015

  Name of this file: stack4.c

  GNU Compiler: gcc -c -m64 -Wall -l stack4.lis -o stack4.o stack4.c

  Purpose: This is subprogram number 2 out of 5 designed for the purpose of investigating the role of the system stack in the process of calling subprograms.
*/
//===== Begin code area ===================================================================================================================================================

#include <stdio.h>
#include <stdint.h>                                         //To students: the second, third, and fourth header files are probably not needed.

extern void C5(double);

void C4(double a)
{
  double b, c, d, z, f; 
  b = -1.5;
  c = 0.6;
  z = 2.1;
  f = 4.3;
  d = a;
  printf("%s\n", "Function C4 has begun");
  printf("The variables are: b = %1.1lf, c = %1.1lf, z = %1.1lf, f = %1.1lf, d = %1.1lf\n", b, c, z, f, d);
  printf("%s\n", "Function C5 will be called next");
  C5(c);
  printf("The variables are after calling C5: b = %1.1lf, c = %1.1lf, z = %1.1lf, f = %1.1lf, d = %1.1lf\n", b, c, z, f, d);
  printf("%s\n", "C4 is now finished");

}//End of stack2
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**

