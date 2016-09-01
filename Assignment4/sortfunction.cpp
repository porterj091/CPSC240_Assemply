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
//  File name: sortfunction.cpp
//  This module's call name: array.out  This module is invoked by the user.
//  Language: C++
//  Date last modified: 2015-October 12th
//  Purpose: This module is the top level driver: it will call interest_calc
//Translator information (Tested in Linux shell)
//  Gnu compiler: g++ -c -m64 -Wall -l sortfunction.lis -o sortfunction.o sortfunction.cpp
//References and credits
//  References: Professor Holliday for style and programming help
//Format information
//  Page width: 172 columns
//  Begin comments: 61
//  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
//===== Begin code area ===================================================================================================================================================


#include <stdio.h>
#include <stdint.h>

extern "C" void sort(double *, long);

extern "C" void swap(double *, double *);


void sort(double * points, long size)
{
	int smallest;
	
	for (int i = 0; i < size - 1; i++)
	{
		smallest = i;
		
		for (int index = i + 1; index < size; index++)
		{
			if (points[index] < points[smallest])
				smallest = index;
		}

		swap(&points[i], &points[smallest]);
	}
}
