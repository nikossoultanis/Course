#include <stdio.h>
#include <time.h>
#define N 100000

	void nothing ()
	{
		int x=0;
		int y=1;
		x=x+1;
		y=y+x;
		return;
	}

int main(int argc, char const *argv[])
{
system("clear");
	
	clock_t start, end;
	double cpu_time_used;

	pid_t pid[N];
	int counter;
	int counter2;

usleep(150000);
printf("Preparing \n");
usleep(150000);
printf("Preparing. \n");
usleep(150000);
printf("Preparing.. \n");
usleep(150000);
printf("Preparing... \n");
usleep(150000);
printf("Ready \n");
start=clock();
	printf("Starting at: %.6f \n", start );


for (counter = 0; counter < N; counter++)
	{
		pid[counter]=fork();
		if(pid[counter] == 0)
		{
			nothing();
			return;
		}
	}
for(counter2 = 0; counter2 < N; counter2++)
		wait(pid[counter2]);

end = clock();
cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;

printf("Total Time Elapsed: %.6f seconds \n", cpu_time_used);
printf("Average Time Elapsed: %.6f seconds \n", cpu_time_used/N);
return 0;
}
