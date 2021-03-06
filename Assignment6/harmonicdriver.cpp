//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
//Author information
//  Author name: Joseph Porter
//  Author email: porterj091@csu.fullerton.edu
//  Author CWID: 891686651
//  Author location: Fullerton, Calif.
//Course information
//  Course number: CPSC240
//  Assignment number: 6
//  Due date: 2015 - December 1st
//Project information
//  Project title: Harmonic Series
//  Purpose: Work with arrays to sort and display
//  Project files: harmonicdriver.cpp harmonicmain.asm 
//Module information
//  File name: arraydriver.cpp
//  This module's call name: harmonic.out  This module is invoked by the user.
//  Language: C++
//  Date last modified: 2015-October 12th
//  Purpose: This module is the top level driver: it will call array_start
//Translator information (Tested in Linux shell)
//  Gnu compiler: g++ -c -m64 -Wall -l harmonicdriver.lis -o harmonicdriver.o harmonicdriver.cpp
//  Gnu linker:   g++ -m64 -o harmonic.out harmonicdriver.o harmonicmain.o
//  Execute:      ./harmonic.out
//References and credits
//  References: Professor Holliday for style and programming help
//Format information
//  Page width: 172 columns
//  Begin comments: 61
//  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
//Permission information
//	No restrictions
//===== Begin code area ===================================================================================================================================================
//
#include <stdio.h>
#include <stdint.h>                                         //To students: the second, third, and fourth header files are probably not needed.
#include <ctime>
#include <cstring>

extern "C" void taylor_start(double *, double *);   	            //The "C" is a directive to the C++ compiler to use standard "CCC" rules for parameter passing.

int main(){
  printf("%s\n","Welcome to the harmonic series by Joseph Porter");
  double *a = new double;
  double *b = new double;
  taylor_start(a, b);
  printf("The driver received these two numbers: %1.22lf, %1.22lf\n", *a, *b);
  printf("%s\n", "The driver will now return a 0 to the operating system. Bye.");

  return 0;                                                 //'0' is the traditional code for 'no errors'.

}//End of main
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**

