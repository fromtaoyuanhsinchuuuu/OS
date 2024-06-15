#ifndef THREADS_H_
#define THREADS_H_
#define NULL_FUNC ((void (*)(int))-1)
// TODO: necessary includes, if any
#include "user/setjmp.h"
// TODO: necessary defines, if any

typedef struct task {
    void (*function)(void *);
    void *arg;
    void *stack;
    void *stack_p;
    struct task *next;
    struct task *prev;
    jmp_buf env;
    int buf_set;
} task;

typedef struct thread {
    void (*fp)(void *arg);
    void *arg;
    void *stack;
    void *stack_p;
    jmp_buf env; // for thread function
    int in_task;
    int buf_set; // 1: indicate jmp_buf (env) has been set, 0: indicate jmp_buf (env) not set
    int ID;
    int task_num;
    task *head_task;
    task *now_task;
    struct thread *previous;
    struct thread *next;

} thread;

thread *thread_create(void (*f)(void *), void *arg);
void thread_add_runqueue(struct thread *t);
void thread_yield(void);
void dispatch(void);
void schedule(void);
void thread_exit(void);
void thread_start_threading(void);

// part 2
void thread_assign_task(struct thread *t, void (*f)(void *), void *arg);
#endif // THREADS_H_
