//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
//Author information
//  Author name: Joseph Porter
//  Author email: porterj091@csu.fullerton.edu
//  Author CWID: 891686651
//  Author location: Fullerton, Calif.
//Course information
//  Course number: CPSC240
//  Assignment number: 2
//  Due date: 2015 - August 25th
//Project information
//  Project title: Electric Circuit Processing
//  Purpose: To compute the surface area and volume of a sphere given its radius.
//  Project files: Spheredriver.c spheremain.asm
//Module information
//  File name: Spheredriver.c
//  This module's call name: sphere.out  This module is invoked by the user.
//  Language: C++
//  Date last modified: 2015-August 18th
//  Purpose: This module is the top level driver: it will call circuit_power
//Translator information (Tested in Linux shell)
//  Gnu compiler: g++ -c -m64 -Wall -l circuitdriver.lis -o circuitdriver.o circuitdriver.cpp
//  Gnu linker:   g++ -m64 -o circuit.out circuitdriver.o circuitmain.o 
//  Execute:      ./circuit.out
//References and credits
//  References: Professor Holliday for style and programming help
//Format information
//  Page width: 172 columns
//  Begin comments: 61
//  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
//===== Begin code area ===================================================================================================================================================
//
#include <stdio.h>
#include <stdint.h>                                         //To students: the second, third, and fourth header files are probably not needed.
#include <ctime>
#include <cstring>

extern "C" double circuit_power();                      //The "C" is a directive to the C++ compiler to use standard "CCC" rules for parameter passing.

int main(){

  double return_code = -99.99;                              //-99.99 is an arbitrary number; that initial value could have been anything.

  printf("%s","Welcome to Electric Circuit Processing by Joseph Porter. \n");
  return_code = circuit_power();
  printf("%s%1.18lf%s\n%s\n","The driver received this number: ",return_code, ".", "The driver will now return 0 to the operating system.  Have a nice day.");

  return 0;                                                 //'0' is the traditional code for 'no errors'.

}//End of main
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**

