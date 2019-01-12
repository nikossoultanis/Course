#include <stdio.h>          /* printf()                 */
#include <stdlib.h>         /* exit(), malloc(), free() */
#include <sys/types.h>      /* key_t, sem_t, pid_t      */
#include <sys/shm.h>        /* shmat(), IPC_RMID        */
#include <errno.h>          /* errno, ECHILD            */
#include <semaphore.h>      /* sem_open(), sem_destroy(), sem_wait().. */
#include <fcntl.h>          /* O_CREAT, O_EXEC          */
#include <unistd.h>
#include <linux/futex.h>
#include <errno.h>

sem_t *synch1;
sem_t *synch2;

int main(int argc, char const *argv[])
{

    synch1 = sem_open("sem1", O_CREAT | O_EXCL, 0644, 0); //initiallizing the semaphore synch1.
    synch2 = sem_open("sem2", O_CREAT | O_EXCL, 0644, 0); //initiallizing the semaphore synch2.

    int pid1,pid2,pid3,pid4,pid5;  //storing the pids of the new processes.

    	pid1=fork();	//creating the first 2 processes (parent and child).

	if(pid1==0){	//using the pid1==0 for the child process
		printf("I am process 1:\n");
		sem_post(synch1);	
		
		}
		else{	//else we create again 2 processes and take the child with if(pid2==0)
		pid2=fork();
				if(pid2==0){
			printf("I am process 2:\n");	
			sem_post(synch1);
			}else {
				pid3=fork();
				if(pid3==0){
				sem_wait(synch1);
				sem_wait(synch1);
				printf("I am process 3:\n");
				sem_post(synch2);		
				}
			
			else{	
				pid4=fork();
					if(pid4==0){
			 		printf("I am process 4:\n");
			 		sem_post(synch2);
			 	}
					
					else {
							pid5=fork();
							if(pid5==0)
								{
								sem_wait(synch2);
								sem_wait(synch2);
								printf("I am process 5:\n");
							}
					}
				}
			}
		}



	sem_unlink("sem1");	//unlinking and then closing the semaphore synch1 (sem1).
	sem_close(synch1);

	sem_unlink("sem2");	//same as before.
	sem_close(synch2);


		return 0;
}
