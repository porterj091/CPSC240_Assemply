//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
//Author information
//  Author name: Joseph Porter
//  Author email: porterj091@csu.fullerton.edu
//  Author CWID: 891686651
//  Author location: Fullerton, Calif.
//Course information
//  Course number: CPSC240
//  Assignment number: 1
//  Due date: 2015 - August 25th
//Project information
//  Project title: Spheres Program
//  Purpose: To compute the surface area and volume of a sphere given its radius.
//  Project files: Spheredriver.c spheremain.asm
//Module information
//  File name: Spheredriver.c
//  This module's call name: sphere.out  This module is invoked by the user.
//  Language: C
//  Date last modified: 2015-August 18th
//  Purpose: This module is the top level driver: it will call spheredemo
//Translator information (Tested in Linux shell)
//  Gnu compiler: gcc -c -m64 -Wall -std=c99 -l avxdriver.lis -o avxdriver.o avxdriver.c
//  Gnu linker:   gcc -m64 -o avx.out avxdriver.o avxmain.o
//  Execute:      ./avx.out
//References and credits
//  No references: Professor Holliday for style and programming help
//Format information
//  Page width: 172 columns
//  Begin comments: 61
//  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
//===== Begin code area ===================================================================================================================================================
//
#include <stdio.h>
#include <stdint.h>

extern double spheredemo();

int main()
{double return_code = -99.9;
 printf("%s","This is CPSC 240 Assigment 1 programmed by Joseph Porter.\nThis software is running on a CyberpowerPC Fangbook with processor Intel Core i7- i7-4700MQ  runnning at 2.4GHz.\n");
 return_code = spheredemo();
 printf("%s %1.12lf\n","The driver recieved this number: ", return_code);
 printf("%s","The driver will now return 0 to the operating system. Have a nice x86 day.\n");
 return 0;
}//End of main


//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
