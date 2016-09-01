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
//  Project title: Amortization Schedule
//  Purpose: To compute the surface area and volume of a sphere given its radius.
//  Project files: interestdriver.cpp interestmain.asm interestfunction.cpp
//Module information
//  File name: interestfunction.cpp
//  This module's call name: interest.out  This module is invoked by the user.
//  Language: C++
//  Date last modified: 2015-September 10th
//  Purpose: This module is the top level driver: it will call interest_calc
//Translator information (Tested in Linux shell)
//  Gnu compiler: g++ -c -m64 -Wall -l interestdriver.lis -o interestdriver.o interestdriver.cpp
//  Gnu linker:   g++ -m64 -o interest.out interestdriver.o interestmain.o 
//  Execute:      ./interest.out
//References and credits
//  References: Professor Holliday for style and programming help
//Format information
//  Page width: 172 columns
//  Begin comments: 61
//  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
//===== Begin code area ===================================================================================================================================================


#include <stdio.h>
#include <stdint.h>
#include <cmath>

double monthly_payment(double, double, long);


double monthly_payment(double principal, double rate, long months)
{
double return_value, rate_i_value;
rate = rate / 12.0;
rate_i_value = pow((1 + rate), months);
return_value = principal * ((rate * rate_i_value) / rate_i_value - 1);
return return_value;
}
