#include "fifo.h"
#include "param.h"
#include "types.h"
#include "memlayout.h"
#include "riscv.h"
#include "spinlock.h"
#include "defs.h"
#include "proc.h"

int pin_num(queue_t *q)
{
	int Pin_num = 0;
	for (int i = 0; i < q->size; i++){
		pte_t *pte = (pte_t *) q->bucket[i];
		Pin_num += (*pte & PTE_P);
	}
	return Pin_num;
}

void q_init(queue_t *q){
	// panic("Not implemented yet\n");
	return;
}

int q_push(queue_t *q, uint64 e){
	// printf("q_num:%d\n", q->size);
	// int q_full_result = -1;
	if (q_full(q)){
		if (pin_num(q) == PG_BUF_SIZE){ // full pin num
			// printf("full pin num!\n");
			return -1;
		}
		else{
			pte_t *tmp_pte;
			for (int i = 0; i < q->size; i++){
				tmp_pte = (pte_t *)q->bucket[i];
				if (*tmp_pte & PTE_P){ // this pte is pinned
					// printf("pte %d is pinned\n", i);
					continue;
				}
				else{
					// printf("pop index:%d\n", i);
					q_pop_idx(q, i);

					q->bucket[q->size++] = e;
					if (q->size != PG_BUF_SIZE){
						printf("asdkjasd\n");
						panic("40 error!\n");
					}
					return 1;
				}
			}
		}
	}
	else{
		// printf("q size:%d\n", q->size);
		// printf("q_full_result:%d\n", q_full_result);
		q->bucket[q->size++] = e;
		// if (q->size > PG_BUF_SIZE){
		// 	panic("nonsense 56!\n");
		// }
		return 1;
	}
	return -1;
	// panic("Not implemented yet\n");
}

uint64 q_pop_idx(queue_t *q, int idx){
	uint64 rt_pte = q->bucket[idx];
	for (int j = idx; j < q->size - 1; j++){
		q->bucket[j] = q->bucket[j + 1];
	}
	q->size--;
	return rt_pte;
	// q->bucket[q->size - 1] = e;
	// panic("Not implemented yet\n");
}

int q_empty(queue_t *q){
	return (q->size == 0);
	// panic("Not implemented yet\n");
}

int q_full(queue_t *q){
	// printf("into q_full q num:%d\n", q->size);
	if (q->size == PG_BUF_SIZE){
		// printf("82 !!\n");
		return 1;
	}
	else {
		return 0;
	}
	// panic("Not implemented yet\n");
}

int q_clear(queue_t *q){
	for (int i = 0; i < PG_BUF_SIZE; i++){
		q->bucket[i] = 0;
	}
	return 0;
	// panic("Not implemented yet\n");
}

int q_find(queue_t *q, uint64 e){ // return index
	for (int i = 0; i < q->size; i++){
		if (q->bucket[i] == e) {
			return i;
		}
	}
	return -1;
	// panic("Not implemented yet\n");
}

void q_print_buffer(queue_t *q)
{
	pte_t *tmp_pte;
	for (int i = 0; i < q->size; i++){
		tmp_pte = (pte_t *)q->bucket[i];
		// if (!(*tmp_pte & PTE_P)){
    		printf("pte: %p\n", tmp_pte);
		// }
	}
	// for (int i = 0; i < q->size; i++){
	// 	tmp_pte = (pte_t *)q->bucket[i];
	// 	if ((*tmp_pte & PTE_P)){
	// 		printf("pinned page!");
    // 		printf("pte: %p\n", tmp_pte);
	// 	}
	// }
	return;
	
}
