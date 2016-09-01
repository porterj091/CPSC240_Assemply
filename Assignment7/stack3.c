//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
/*
  Author: Joseph Porter
  Email:  porterj091@csu.fullerton.edu
  Course: CPSC 240
  Assignment: 7
  Due date: December 15th, 2015

  Name of this file: stack3.c

  GNU Compiler: gcc -c -m64 -Wall -l stack3.lis -o stack3.o stack3.c

  Purpose: This is subprogram number 2 out of 5 designed for the purpose of investigating the role of the system stack in the process of calling subprograms.
*/
//===== Begin code area ===================================================================================================================================================

#include <stdio.h>
#include <stdint.h>                                         //To students: the second, third, and fourth header files are probably not needed.

extern void C4(double);

void C3(double a)
{
  double b, c, d, z; 
  b = -2.3;
  c = 7.9;
  z = 2.2;
  d = a;
  printf("%s\n", "Function C3 has begun");
  printf("The variables are: b = %1.1lf, c = %1.1lf, z = %1.1lf d = %1.1lf\n", b, c, z, d);
  printf("%s\n", "Function C4 will be called next");
  C4(b);
  printf("The variables are after calling C4: b = %1.1lf, c = %1.1lf, z = %1.1lf d = %1.1lf\n", b, c, z, d);
  printf("%s\n", "C3 is now finished");

}//End of stack2
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**

