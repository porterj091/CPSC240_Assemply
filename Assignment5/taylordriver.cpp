//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
//Author information
//  Author name: Joseph Porter
//  Author email: porterj091@csu.fullerton.edu
//  Author CWID: 891686651
//  Author location: Fullerton, Calif.
//Course information
//  Course number: CPSC240
//  Assignment number: 5
//  Due date: 2015 - November 12th
//Project information
//  Project title: Powers of e 
//  Purpose: To calculate the Taylor series
//  Project files: taylordriver.cpp taylormain.asm
//Module information
//  File name: taylordriver.cpp
//  This module's call name: taylor.out  This module is invoked by the user.
//  Language: C++
//  Date last modified: 2015-November 11th
//  Purpose: This module is the top level driver: it will call taylor_start
//Translator information (Tested in Linux shell)
//  Gnu compiler: g++ -c -m64 -Wall -l taylordriver.lis -o taylordriver.o taylordriver.cpp
//  Gnu linker:   g++ -m64 -o taylor.out taylordriver.o taylormain.o
//  Execute:      ./taylor.out
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

extern "C" void taylor_start(double *, double *, double *, double *);  //The "C" is a directive to the C++ compiler to use standard "CCC" rules for parameter passing.

int main(){
  printf("%s\n","This is CPSC Assignment 5 programmed by Joseph Porter");
  printf("%s\n", "This software is running on a Cyberpower Fangbook Pro with processor Intel Core i7-4790 running at 2.4GHz.");
  double *a = new double;
  double *b = new double;
  double *c = new double;
  double *d = new double;
  taylor_start(a, b, c, d);
  printf("The driver received these numbers: %1.8lf, %1.8lf, %1.8lf, %1.8lf\n", *a, *b, *c, *d);
  printf("%s\n", "Have a nice X86 day.");

  return 0;                                                 //'0' is the traditional code for 'no errors'.

}//End of main
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**

