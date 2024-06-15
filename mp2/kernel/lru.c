#include "lru.h"

#include "param.h"
#include "types.h"
#include "memlayout.h"
#include "riscv.h"
#include "spinlock.h"
#include "defs.h"
#include "proc.h"

int pin_num(lru_t *q)
{
	int Pin_num = 0;
	for (int i = 0; i < q->size; i++){
		pte_t *pte = (pte_t *) q->bucket[i];
		Pin_num += (*pte & PTE_P);
	}
	return Pin_num;
}

void lru_init(lru_t *lru){
	return;
	// panic("not implemented yet\n");
}

int lru_push(lru_t *q, uint64 e){
	// printf("lru buffer num:%d\n", q->size);
	if (lru_full(q)){
		if (pin_num(q) == PG_BUF_SIZE){ // full pin num
			return -1;
		}
		else{
			pte_t *tmp_pte;
			for (int i = 0; i < q->size; i++){
				tmp_pte = (pte_t *)q->bucket[i];
				if (*tmp_pte & PTE_P){ // this pte is pinned
					continue;
				}
				else{
					lru_pop(q, i);
					q->bucket[q->size++] = e;
					if (q->size != PG_BUF_SIZE){
						panic("43 lru !\n");
					}
					return 1;
				}
			}
		}
	}
	else{
		q->bucket[q->size++] = e;
		return 1;
	}
	return -1;
}

uint64 lru_pop(lru_t *q, int idx){
	uint64 rt_pte = q->bucket[idx];
	for (int j = idx; j < q->size - 1; j++){
		q->bucket[j] = q->bucket[j + 1];
	}
	q->size--;
	return rt_pte;
	panic("not implemented yet\n");
}

int lru_empty(lru_t *q){
	return (q->size == 0);
	panic("not implemented yet\n");
}

int lru_full(lru_t *q){
	if (q->size == PG_BUF_SIZE) return 1;
	else return 0;
	panic("not implemented yet\n");
}

int lru_clear(lru_t *q){
	for (int i = 0; i < PG_BUF_SIZE; i++){
		q->bucket[i] = 0;
	}
	panic("not implemented yet\n");
}

int lru_find(lru_t *q, uint64 e){ // return index
	for (int i = 0; i < q->size; i++){
		if (q->bucket[i] == e) return i;
	}
	return -1;
	panic("not implemented yet\n");
}

void lru_access(lru_t *q, int idx, uint64 e){
	// printf("access! 94 change position!\n");
	// lru_print_buffer(q);
	// printf("idx:%d\n", idx);
	for (int i = idx; i < q->size; i++){
		q->bucket[i] = q->bucket[i + 1];
	}
	q->bucket[q->size - 1] = e;
	// lru_print_buffer(q);

	return;
}

void lru_print_buffer(lru_t *q)
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

