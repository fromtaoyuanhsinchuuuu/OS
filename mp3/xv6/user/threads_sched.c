#include "kernel/types.h"
#include "user/user.h"
#include "user/list.h"
#include "user/threads.h"
#include "user/threads_sched.h"

#define NULL 0

/* default scheduling algorithm */
struct threads_sched_result schedule_default(struct threads_sched_args args)
{
    struct thread *thread_with_smallest_id = NULL;
    struct thread *th = NULL;
    list_for_each_entry(th, args.run_queue, thread_list) { // 像for迴圈
        if (thread_with_smallest_id == NULL || th->ID < thread_with_smallest_id->ID)
            thread_with_smallest_id = th;
    }

    struct threads_sched_result r;
    if (thread_with_smallest_id != NULL) {
        r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
        r.allocated_time = thread_with_smallest_id->remaining_time;
    } else {
        r.scheduled_thread_list_member = args.run_queue;
        r.allocated_time = 1;
    }

    return r;
}

void handle_run_queue_empty(struct threads_sched_result *r, struct threads_sched_args args) // 在release_queue找第一個entry
{
    struct release_queue_entry *rqe = NULL;
    r->allocated_time = __INT_MAX__;
    list_for_each_entry(rqe, args.release_queue, thread_list) { // 取release time最小那個
        if (r->allocated_time == __INT_MAX__ || r->allocated_time + args.current_time > rqe->release_time){
            r->allocated_time = rqe->release_time - args.current_time;
        }
    }
    r->scheduled_thread_list_member = args.run_queue;
    return;
}



/* MP3 Part 1 - Non-Real-Time Scheduling */
/* Weighted-Round-Robin Scheduling */
struct threads_sched_result schedule_wrr(struct threads_sched_args args)
{
    struct thread *thread_wrr = NULL;
    struct thread *th = NULL;
    list_for_each_entry(th, args.run_queue, thread_list) { // 取第一個
        thread_wrr = th;
        break;
    }

    struct threads_sched_result r;
    if (thread_wrr != NULL) {
        r.scheduled_thread_list_member = &thread_wrr->thread_list;
        r.allocated_time = (thread_wrr->remaining_time <= thread_wrr->weight * args.time_quantum)? thread_wrr->remaining_time:  thread_wrr->weight * args.time_quantum;
    }
    else{
        handle_run_queue_empty(&r, args);
    }
    return r;
    // TODO: implement the weighted round-robin scheduling algorithm

}

/* Shortest-Job-First Scheduling */
struct threads_sched_result schedule_sjf(struct threads_sched_args args)
{
    struct thread *thread_with_min_remain = NULL;
    struct thread *th = NULL;
    list_for_each_entry(th, args.run_queue, thread_list) { // 像for迴圈
        if (thread_with_min_remain == NULL || th->remaining_time < thread_with_min_remain->remaining_time || (th->remaining_time == thread_with_min_remain->remaining_time && th->ID < thread_with_min_remain->ID)){
            thread_with_min_remain = th;
        }
    }
    struct threads_sched_result r;
    // TODO: implement the shortest-job-first scheduling algorithm

    if (thread_with_min_remain != NULL) {
        r.scheduled_thread_list_member = &thread_with_min_remain->thread_list;
        /* since algo is preemptive, it may not complete its job */
        struct release_queue_entry *rqe = NULL;
        r.allocated_time = thread_with_min_remain->remaining_time;
        list_for_each_entry(rqe, args.release_queue, thread_list) { // release_queue那個thread進來後看有沒有可能比原來的還要小
            if (thread_with_min_remain->remaining_time - (rqe->release_time - args.current_time) > rqe->thrd->processing_time){
                r.allocated_time = (rqe->release_time - args.current_time < r.allocated_time)? rqe->release_time - args.current_time: r.allocated_time;
            }
            else if (thread_with_min_remain->remaining_time - (rqe->release_time - args.current_time) == rqe->thrd->processing_time && rqe->thrd->ID < thread_with_min_remain->ID){
                r.allocated_time = (rqe->release_time - args.current_time < r.allocated_time)? rqe->release_time - args.current_time: r.allocated_time;
            }
        }
    }
    else{
        handle_run_queue_empty(&r, args);
    }

    return r;
}

/* MP3 Part 2 - Real-Time Scheduling*/
/* Least-Slack-Time Scheduling */
struct threads_sched_result schedule_lst(struct threads_sched_args args)
{
    struct thread *thread_with_min_slack_time = NULL;
    struct thread *th = NULL;
    list_for_each_entry(th, args.run_queue, thread_list) { // 先照演算法選取
        int tmp_slack_time = th->current_deadline - args.current_time - th->remaining_time;
        if (thread_with_min_slack_time == NULL){
            thread_with_min_slack_time = th;
        }
        else{
            int now_slack_time = thread_with_min_slack_time->current_deadline - args.current_time - thread_with_min_slack_time->remaining_time;
            if (tmp_slack_time < now_slack_time || (tmp_slack_time == now_slack_time && th->ID <= thread_with_min_slack_time->ID)) thread_with_min_slack_time = th;
        }
    }

    int find_miss_dead_line = 0;
    list_for_each_entry(th, args.run_queue, thread_list) { // 再選如果有已經miss deadline的
        if (args.current_time >= th->current_deadline){ // th miss deadline
            if (args.current_time < thread_with_min_slack_time->current_deadline || (args.current_time > thread_with_min_slack_time->current_deadline && th->ID < thread_with_min_slack_time->ID)){
                find_miss_dead_line = 1;
                thread_with_min_slack_time = th;
            }
        }
    }


    struct threads_sched_result r;
    if (find_miss_dead_line == 1){
        r.scheduled_thread_list_member = &thread_with_min_slack_time->thread_list;
        r.allocated_time = 0;
        return r;
    }

    if (thread_with_min_slack_time != NULL) {
        r.scheduled_thread_list_member = &thread_with_min_slack_time->thread_list;
        /* since algo is preemptive, it may not complete its job */
        struct release_queue_entry *rqe = NULL;
        r.allocated_time = thread_with_min_slack_time->remaining_time;
        int now_slack_time = thread_with_min_slack_time->current_deadline - args.current_time - thread_with_min_slack_time->remaining_time;
        list_for_each_entry(rqe, args.release_queue, thread_list) { // 計算relesae queue的slack time會不會比上面抓到的還要小
            int tmp_slack_time = rqe->thrd->period - rqe->thrd->processing_time;
            if (tmp_slack_time < now_slack_time || (tmp_slack_time == now_slack_time && rqe->thrd->ID < thread_with_min_slack_time->ID)){
                r.allocated_time = (rqe->release_time - args.current_time < r.allocated_time)? rqe->release_time - args.current_time: r.allocated_time;
            }
        }
        now_slack_time = thread_with_min_slack_time->current_deadline - args.current_time - thread_with_min_slack_time->remaining_time;
        if (now_slack_time < 0){ // 將來會不會miss deadline
            r.allocated_time = thread_with_min_slack_time->current_deadline - args.current_time;
        }
    }
    else{
        handle_run_queue_empty(&r, args);
    }
    return r;
}

/* Deadline-Monotonic Scheduling */
struct threads_sched_result schedule_dm(struct threads_sched_args args)
{
    struct thread *thread_with_min_period = NULL;
    struct thread *th = NULL;
    list_for_each_entry(th, args.run_queue, thread_list) { // 像for迴圈
        if (thread_with_min_period == NULL || th->period < thread_with_min_period->period || (th->period == thread_with_min_period->period && th->ID < thread_with_min_period->ID)){
            thread_with_min_period = th;
        }
    }

    int find_miss_dead_line = 0;
    list_for_each_entry(th, args.run_queue, thread_list) { // 再選如果有已經miss deadline的
        if (args.current_time >= th->current_deadline){ // th miss deadline
            if (args.current_time < thread_with_min_period->current_deadline || (args.current_time > thread_with_min_period->current_deadline && th->ID <= thread_with_min_period->ID)){
                find_miss_dead_line = 1;
                thread_with_min_period = th;
            }
        }
    }

    struct threads_sched_result r;
    if (find_miss_dead_line == 1){
        r.scheduled_thread_list_member = &thread_with_min_period->thread_list;
        r.allocated_time = 0;
        return r;
    }

    if (thread_with_min_period != NULL) {
        r.scheduled_thread_list_member = &thread_with_min_period->thread_list;
        /* since algo is preemptive, it may not complete its job */
        struct release_queue_entry *rqe = NULL;
        r.allocated_time = thread_with_min_period->remaining_time;
        list_for_each_entry(rqe, args.release_queue, thread_list) { // 計算relesae queue的slack time會不會比上面抓到的還要小
            if (rqe->thrd->period < thread_with_min_period->period || (rqe->thrd->period == thread_with_min_period->period && rqe->thrd->ID < thread_with_min_period->ID)){
                r.allocated_time = (rqe->release_time - args.current_time < r.allocated_time)? rqe->release_time - args.current_time: r.allocated_time;
            }
        }
        if (args.current_time + r.allocated_time > thread_with_min_period->current_deadline){ // 將來會miss deadline
            r.allocated_time = thread_with_min_period->current_deadline - args.current_time;
        }
    }
    else{
        handle_run_queue_empty(&r, args);
    }
    return r;
}
