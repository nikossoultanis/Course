#include <stdio.h>
#include <unistd.h>

int main(int argc, char const *argv[])
{	
	int pid1;
	int pid2;
	int pid3;
	int pid4;

	pid1=fork();

	if(pid1==0){
		printf("I am the first child with parent: %d \n", getppid());
		sleep(0.1);	
	}else{
		sleep(0.2);
		pid2=fork();
		if(pid2==0)
			printf("I am the second child with parent: %d \n",getppid());
	
		else{	
			sleep(0.3);
			pid3=fork();
				if(pid3==0)
				 printf("I am the third child with parent: %d \n", getppid());
			
			else{	
				sleep(0.5);
				pid4=fork();
					if(pid4==0)
			 		printf("I am the fourth child with parent: %d \n",getppid());
				}
			}
		}
	return 0;
}