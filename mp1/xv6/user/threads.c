#include "kernel/types.h"
#include "user/setjmp.h"
#include "user/threads.h"
#include "user/user.h"
#define NULL 0

static struct thread* current_thread = NULL;
static int id = 1;
static jmp_buf env_st;
// static jmp_buf env_tmp;

struct thread *thread_create(void (*f)(void *), void *arg){ // init thread
    // printf("I am creting!!\n"); 
    struct thread *t = (struct thread *) malloc(sizeof(struct thread));
    unsigned long new_stack;
    unsigned long new_stack_p;
    new_stack = (unsigned long) malloc(sizeof(unsigned long)*0x100);
    new_stack_p = new_stack +0x100*8-0x2*8;
    t->fp = f;
    t->arg = arg;
    t->ID  = id;
    t->buf_set = 0;
    t->stack = (void*) new_stack;
    t->stack_p = (void*) new_stack_p;
    t->in_task = 0;
    t->head_task = NULL;
    t->task_num = 0;
    id++;
    return t;
}
void thread_add_runqueue(struct thread *t){
    // Check if the runqueue is empty
    if (current_thread == NULL) {
        // Initialize the runqueue with the new thread
        current_thread = t;
        t->next = t;  // Point to itself, making it circular
        t->previous = t;
    } else {
        // Insert the new thread at the end of the runqueue
        t->next = current_thread;
        t->previous = current_thread->previous;
        current_thread->previous->next = t;
        current_thread->previous = t;
    }
    return;
}

void thread_yield(void){
    // TODO

    if (current_thread->in_task == 1){ // thread is doing tasks
        if (setjmp(current_thread->now_task->env) == 0){
            current_thread->now_task->buf_set = 1;
            schedule();
            dispatch();
        }
        // dispatch() will long jmp to here
    }
    else{ // thread is doing thread's function
        if (setjmp(current_thread->env) == 0) {
            current_thread->buf_set = 1;  // Mark that the env has been set for this thread
            schedule();  // Move to the next thread in the runqueue
            dispatch();  // Switch to the next thread
        }
        // dispatch() will long jmp to here
    }
}

void dispatch(void) {

    // check whether current_thread has task
    while (current_thread->task_num > 0) {
        if (current_thread->head_task->buf_set == 0){
            if (setjmp(current_thread->head_task->env) == 0) { // init sp
                // Set the task's stack pointer
                current_thread->head_task->buf_set = 1;
                current_thread->head_task->env->sp = (unsigned long)(current_thread->head_task->stack_p);
                longjmp(current_thread->head_task->env, 1);
            }
            else{
                current_thread->in_task = 1;
                current_thread->now_task = current_thread->head_task;
                current_thread->now_task->function(current_thread->now_task->arg);

                /* handle current_thread->now_task return */
                if (current_thread->now_task->next != NULL){
                    current_thread->now_task->next->prev = current_thread->now_task->prev;
                }

                if (current_thread->now_task->prev != NULL){
                    current_thread->now_task->prev->next = current_thread->now_task->next;
                }
                else{
                    current_thread->head_task = current_thread->head_task->next;
                }
            
                current_thread->task_num--;
                free(current_thread->now_task->stack);
                free(current_thread->now_task);
                current_thread->now_task = NULL;
            }
        }
        else {
            current_thread->in_task = 1;
            current_thread->now_task = current_thread->head_task;
            longjmp(current_thread->now_task->env, 1);
        }
    }

    // Check if the thread has never been run before
    if (current_thread->buf_set == 0) {
        if (setjmp(current_thread->env) == 0) {
            current_thread->env->sp = (unsigned long)(current_thread->stack_p);
            longjmp(current_thread->env, 1); // Jump to the new context
        }
        else{
            current_thread->in_task = 0;
            current_thread->fp(current_thread->arg);
            thread_exit();

        }
    } else {
        // Restore the previously saved context
        current_thread->in_task = 0;
        longjmp(current_thread->env, 1);
    }
}

void schedule(void) { // for threads
    if (current_thread != NULL && current_thread->next != NULL) {
        current_thread = current_thread->next;
    }
}

void thread_exit(void) {
    /* free tasks */
    task *tmp = current_thread->head_task;
    task *tmp_next;
    while (tmp != NULL){
        tmp_next = tmp->next;
        free(tmp->stack);
        free(tmp);
        current_thread->task_num--;
        tmp = tmp_next;
    }
    // Check if after scheduling, we are back to the same thread, which means it's the last one
    if (current_thread->next == current_thread){ // only one thread left
        free(current_thread->stack);
        free(current_thread);
        current_thread = NULL;
        longjmp(env_st, 1);
    }
    else{
        current_thread->previous->next = current_thread->next;
        current_thread->next->previous = current_thread->previous;
        thread *tmp = current_thread->next;
        free(current_thread->stack);
        free(current_thread);
        current_thread = tmp;
        dispatch();
    }
}

void thread_start_threading(void) {
    // Ensure there is at least one thread in the runqueue
    if (setjmp(env_st) == 0){
        dispatch();
    }
    else{ // all threads had exited, return to main 
        current_thread = NULL;
        return;
    }
}

// part 2
void thread_assign_task(struct thread *t, void (*f)(void *), void *arg) {
    struct task *new_task = malloc(sizeof(struct task));
    new_task->function = f;
    new_task->arg = arg;
    new_task->buf_set = 0;

    // Allocate stack for the task and set stack pointer
    unsigned long task_stack = (unsigned long) malloc(sizeof(unsigned long) * 0x100);
    new_task->stack = (void *)task_stack;
    new_task->stack_p = (void *)(task_stack + 0x100 * 8 - 0x2 * 8);

    // Insert the new task at the head of the list
    new_task->next = t->head_task;
    new_task->prev = NULL; // As it's the new head, prev is NULL

    // If there's already a task, set its prev to the new task
    if (t->head_task != NULL) {
        t->head_task->prev = new_task;
    }

    // Update the thread's current task pointer
    t->head_task = new_task;
    t->task_num++;
    return;
}