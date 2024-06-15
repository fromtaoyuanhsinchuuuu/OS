#include "param.h"
#include "types.h"
#include "memlayout.h"
#include "riscv.h"
#include "spinlock.h"
#include "defs.h"
#include "proc.h"
#include "vm.h"

/* NTU OS 2024 */
/* Allocate eight consecutive disk blocks. */
/* Save the content of the physical page in the pte */
/* to the disk blocks and save the block-id into the */
/* pte. */
char *swap_page_from_pte(pte_t *pte) {
  char *pa = (char*) PTE2PA(*pte);
  uint dp = balloc_page(ROOTDEV); // 叫disk allocate一個空間給我
  write_page_to_disk(ROOTDEV, pa, dp); // write this page to disk
  *pte = (BLOCKNO2PTE(dp) | PTE_FLAGS(*pte) | PTE_S) & ~PTE_V; // 將pte的pointer指到disk
  return pa;
}

/* NTU OS 2024 */
/* Page fault handler */
int handle_pgfault() { // 僅有一個va需要處理
  /* Find the address that caused the fault */
  printf("27\n");
  uint64 va = r_stval();
  va = PGROUNDDOWN(va);
  // madvise(PGROUNDDOWN(va), PGSIZE, MADV_WILLNEED);
  struct proc *p = myproc();
  pagetable_t pgtbl = p->pagetable;
  if (va > p->sz || (va + PGSIZE) > p->sz) return -1;
  
  begin_op();
  pte_t *pte = walk(pgtbl, va, 0);
  if (pte == 0 || (*pte & PTE_S) == 0) {
    end_op();
    return -1;
  }
  
  char *pa = (char *)kalloc(); // 位在physical memory的free page
  if (pa == 0) {
    end_op();
    return -1;
  }
  uint dp = PTE2BLOCKNO(*pte);
  read_page_from_disk(ROOTDEV, pa, dp); // 從disk搬回來
  *pte = (PA2PTE(pa) | PTE_FLAGS(*pte) | PTE_V) & ~PTE_S; // 將pte的pointer指到physical memory
  bfree_page(ROOTDEV, dp);
  end_op();
  return 0;
}
