#include <stdio.h>
#include <time.h>

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
	clock_t start, end;
	double cpu_time_used;

	pid_t pid;
	int counter;
	int counter2;

   	start=clock();
	printf("Starting at: %.6f \n", start );

for (counter = 0; counter < 1000000; counter++)
	{
		pid=fork();
		if(pid == 0)
		{
			nothing();
			return;
		}
	}
for(counter2 = 0; counter2 < 1000000; counter2++)
		wait(NULL);

end = clock();
cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;

printf("Total Time Elapsed: %.6f \n", cpu_time_used);
return 0;
}