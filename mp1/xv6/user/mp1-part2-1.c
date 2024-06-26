#include "kernel/types.h"
#include "user/user.h"
#include "user/threads.h"

#define NULL 0
int cnt = 0;

void task3(void *arg){
    printf("task 3: %d\n", cnt++);
    thread_yield();
    // printf("should return!!\n", cnt);
}

void f3(void *arg)
{
    int i = 10000;
    while (1) {
        printf("thread 3: %d\n", i++);
        if(i == 10005) {
            thread_exit();
        }
        thread_yield();
    }
}

void f2(void *arg)
{
    int i = 0;
    while(1) {
        printf("thread 2: %d\n",i++);
        if (i == 5) {
            thread_exit();
        }
        thread_yield();
    }
}

void f1(void *arg)
{
    int i = 100;
    struct thread *t2 = thread_create(f2, NULL);
    thread_add_runqueue(t2);
    struct thread *t3 = thread_create(f3, NULL);
    thread_add_runqueue(t3);
    
    
    while(1) {
        printf("thread 1: %d\n", i++);
        thread_assign_task(t3, task3, NULL);
        if (i == 110) {
            thread_exit();
        }
        thread_yield();
    }
}

int main(int argc, char **argv)
{
    printf("mp1-part2-1\n");
    struct thread *t1 = thread_create(f1, NULL);
    thread_add_runqueue(t1);
    thread_start_threading();
    printf("\nexited\n");
    exit(0);
}
