//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
//Author information
//  Author name: Joseph Porter
//  Author email: porterj091@csu.fullerton.edu
//  Author CWID: 891686651
//  Author location: Fullerton, Calif.
//Course information
//  Course number: CPSC240
//  Assignment number: 4
//  Due date: 2015 - October 20th
//Project information
//  Project title: Array Processing
//  Purpose: Work with arrays to sort and display
//  Project files: arraydriver.cpp arraymain.asm sortfunction.cpp inputarray.asm outputarray.asm sortarray.asm
//Module information
//  File name: arraydriver.cpp
//  This module's call name: array.out  This module is invoked by the user.
//  Language: C++
//  Date last modified: 2015-October 12th
//  Purpose: This module is the top level driver: it will call array_start
//Translator information (Tested in Linux shell)
//  Gnu compiler: g++ -c -m64 -Wall -l arraydriver.lis -o arraydriver.o arraydriver.cpp
//  Gnu linker:   g++ -m64 -o array.out arraydriver.o arraymain.o sortfunction.o inputarray.o outputarray.o swaparray.o
//  Execute:      ./array.out
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

extern "C" double *array_start();   	                  	    //The "C" is a directive to the C++ compiler to use standard "CCC" rules for parameter passing.

int main(){

  printf("%s","This driver program will start the main assembly program of Assignment 4.");
  double *return_code = array_start();
  printf("%s\n", "Without knowing the purpose the driver recieved this array:");
  for (int i = 0; i < 5; i++)
  {
		printf("%1.10lf\n", return_code[i]);
  }
  printf("%s\n", "Have a nice day. This driver will return 0 to the operating system. Bye.");

  return 0;                                                 //'0' is the traditional code for 'no errors'.

}//End of main
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**

