#include <stdio.h>
#include <stdlib.h>

int main()
{	
	int counter;
	int pids;

	printf("5 children chain will be created: \n \n");

	for(counter=0;counter<5;counter++){
	pids=fork();

	if(pids>0)
	{		
			printf("My PID: %d My Parent's PID: %d \n", getpid(),	getppid());
			wait(NULL); //wait for any child to terminate.
			break;
	}
	
}	
return 0;
}
	

