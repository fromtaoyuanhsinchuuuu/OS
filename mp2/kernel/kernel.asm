
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00009117          	auipc	sp,0x9
    80000004:	9e013103          	ld	sp,-1568(sp) # 800089e0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	77b050ef          	jal	ra,80005f90 <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    8000001c:	1101                	addi	sp,sp,-32
    8000001e:	ec06                	sd	ra,24(sp)
    80000020:	e822                	sd	s0,16(sp)
    80000022:	e426                	sd	s1,8(sp)
    80000024:	e04a                	sd	s2,0(sp)
    80000026:	1000                	addi	s0,sp,32
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    80000028:	03451793          	slli	a5,a0,0x34
    8000002c:	ebb9                	bnez	a5,80000082 <kfree+0x66>
    8000002e:	84aa                	mv	s1,a0
    80000030:	00026797          	auipc	a5,0x26
    80000034:	21078793          	addi	a5,a5,528 # 80026240 <end>
    80000038:	04f56563          	bltu	a0,a5,80000082 <kfree+0x66>
    8000003c:	47c5                	li	a5,17
    8000003e:	07ee                	slli	a5,a5,0x1b
    80000040:	04f57163          	bgeu	a0,a5,80000082 <kfree+0x66>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    80000044:	6605                	lui	a2,0x1
    80000046:	4585                	li	a1,1
    80000048:	00000097          	auipc	ra,0x0
    8000004c:	130080e7          	jalr	304(ra) # 80000178 <memset>

  r = (struct run*)pa;

  acquire(&kmem.lock);
    80000050:	00009917          	auipc	s2,0x9
    80000054:	fe090913          	addi	s2,s2,-32 # 80009030 <kmem>
    80000058:	854a                	mv	a0,s2
    8000005a:	00007097          	auipc	ra,0x7
    8000005e:	930080e7          	jalr	-1744(ra) # 8000698a <acquire>
  r->next = kmem.freelist;
    80000062:	01893783          	ld	a5,24(s2)
    80000066:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    80000068:	00993c23          	sd	s1,24(s2)
  release(&kmem.lock);
    8000006c:	854a                	mv	a0,s2
    8000006e:	00007097          	auipc	ra,0x7
    80000072:	9d0080e7          	jalr	-1584(ra) # 80006a3e <release>
}
    80000076:	60e2                	ld	ra,24(sp)
    80000078:	6442                	ld	s0,16(sp)
    8000007a:	64a2                	ld	s1,8(sp)
    8000007c:	6902                	ld	s2,0(sp)
    8000007e:	6105                	addi	sp,sp,32
    80000080:	8082                	ret
    panic("kfree");
    80000082:	00008517          	auipc	a0,0x8
    80000086:	f8e50513          	addi	a0,a0,-114 # 80008010 <etext+0x10>
    8000008a:	00006097          	auipc	ra,0x6
    8000008e:	3b6080e7          	jalr	950(ra) # 80006440 <panic>

0000000080000092 <freerange>:
{
    80000092:	7179                	addi	sp,sp,-48
    80000094:	f406                	sd	ra,40(sp)
    80000096:	f022                	sd	s0,32(sp)
    80000098:	ec26                	sd	s1,24(sp)
    8000009a:	e84a                	sd	s2,16(sp)
    8000009c:	e44e                	sd	s3,8(sp)
    8000009e:	e052                	sd	s4,0(sp)
    800000a0:	1800                	addi	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    800000a2:	6785                	lui	a5,0x1
    800000a4:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    800000a8:	94aa                	add	s1,s1,a0
    800000aa:	757d                	lui	a0,0xfffff
    800000ac:	8ce9                	and	s1,s1,a0
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000ae:	94be                	add	s1,s1,a5
    800000b0:	0095ee63          	bltu	a1,s1,800000cc <freerange+0x3a>
    800000b4:	892e                	mv	s2,a1
    kfree(p);
    800000b6:	7a7d                	lui	s4,0xfffff
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000b8:	6985                	lui	s3,0x1
    kfree(p);
    800000ba:	01448533          	add	a0,s1,s4
    800000be:	00000097          	auipc	ra,0x0
    800000c2:	f5e080e7          	jalr	-162(ra) # 8000001c <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000c6:	94ce                	add	s1,s1,s3
    800000c8:	fe9979e3          	bgeu	s2,s1,800000ba <freerange+0x28>
}
    800000cc:	70a2                	ld	ra,40(sp)
    800000ce:	7402                	ld	s0,32(sp)
    800000d0:	64e2                	ld	s1,24(sp)
    800000d2:	6942                	ld	s2,16(sp)
    800000d4:	69a2                	ld	s3,8(sp)
    800000d6:	6a02                	ld	s4,0(sp)
    800000d8:	6145                	addi	sp,sp,48
    800000da:	8082                	ret

00000000800000dc <kinit>:
{
    800000dc:	1141                	addi	sp,sp,-16
    800000de:	e406                	sd	ra,8(sp)
    800000e0:	e022                	sd	s0,0(sp)
    800000e2:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    800000e4:	00008597          	auipc	a1,0x8
    800000e8:	f3458593          	addi	a1,a1,-204 # 80008018 <etext+0x18>
    800000ec:	00009517          	auipc	a0,0x9
    800000f0:	f4450513          	addi	a0,a0,-188 # 80009030 <kmem>
    800000f4:	00007097          	auipc	ra,0x7
    800000f8:	806080e7          	jalr	-2042(ra) # 800068fa <initlock>
  freerange(end, (void*)PHYSTOP);
    800000fc:	45c5                	li	a1,17
    800000fe:	05ee                	slli	a1,a1,0x1b
    80000100:	00026517          	auipc	a0,0x26
    80000104:	14050513          	addi	a0,a0,320 # 80026240 <end>
    80000108:	00000097          	auipc	ra,0x0
    8000010c:	f8a080e7          	jalr	-118(ra) # 80000092 <freerange>
}
    80000110:	60a2                	ld	ra,8(sp)
    80000112:	6402                	ld	s0,0(sp)
    80000114:	0141                	addi	sp,sp,16
    80000116:	8082                	ret

0000000080000118 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    80000118:	1101                	addi	sp,sp,-32
    8000011a:	ec06                	sd	ra,24(sp)
    8000011c:	e822                	sd	s0,16(sp)
    8000011e:	e426                	sd	s1,8(sp)
    80000120:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    80000122:	00009497          	auipc	s1,0x9
    80000126:	f0e48493          	addi	s1,s1,-242 # 80009030 <kmem>
    8000012a:	8526                	mv	a0,s1
    8000012c:	00007097          	auipc	ra,0x7
    80000130:	85e080e7          	jalr	-1954(ra) # 8000698a <acquire>
  r = kmem.freelist;
    80000134:	6c84                	ld	s1,24(s1)
  if(r)
    80000136:	c885                	beqz	s1,80000166 <kalloc+0x4e>
    kmem.freelist = r->next;
    80000138:	609c                	ld	a5,0(s1)
    8000013a:	00009517          	auipc	a0,0x9
    8000013e:	ef650513          	addi	a0,a0,-266 # 80009030 <kmem>
    80000142:	ed1c                	sd	a5,24(a0)
  release(&kmem.lock);
    80000144:	00007097          	auipc	ra,0x7
    80000148:	8fa080e7          	jalr	-1798(ra) # 80006a3e <release>

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
    8000014c:	6605                	lui	a2,0x1
    8000014e:	4595                	li	a1,5
    80000150:	8526                	mv	a0,s1
    80000152:	00000097          	auipc	ra,0x0
    80000156:	026080e7          	jalr	38(ra) # 80000178 <memset>
  return (void*)r;
}
    8000015a:	8526                	mv	a0,s1
    8000015c:	60e2                	ld	ra,24(sp)
    8000015e:	6442                	ld	s0,16(sp)
    80000160:	64a2                	ld	s1,8(sp)
    80000162:	6105                	addi	sp,sp,32
    80000164:	8082                	ret
  release(&kmem.lock);
    80000166:	00009517          	auipc	a0,0x9
    8000016a:	eca50513          	addi	a0,a0,-310 # 80009030 <kmem>
    8000016e:	00007097          	auipc	ra,0x7
    80000172:	8d0080e7          	jalr	-1840(ra) # 80006a3e <release>
  if(r)
    80000176:	b7d5                	j	8000015a <kalloc+0x42>

0000000080000178 <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    80000178:	1141                	addi	sp,sp,-16
    8000017a:	e422                	sd	s0,8(sp)
    8000017c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    8000017e:	ce09                	beqz	a2,80000198 <memset+0x20>
    80000180:	87aa                	mv	a5,a0
    80000182:	fff6071b          	addiw	a4,a2,-1
    80000186:	1702                	slli	a4,a4,0x20
    80000188:	9301                	srli	a4,a4,0x20
    8000018a:	0705                	addi	a4,a4,1
    8000018c:	972a                	add	a4,a4,a0
    cdst[i] = c;
    8000018e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    80000192:	0785                	addi	a5,a5,1
    80000194:	fee79de3          	bne	a5,a4,8000018e <memset+0x16>
  }
  return dst;
}
    80000198:	6422                	ld	s0,8(sp)
    8000019a:	0141                	addi	sp,sp,16
    8000019c:	8082                	ret

000000008000019e <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    8000019e:	1141                	addi	sp,sp,-16
    800001a0:	e422                	sd	s0,8(sp)
    800001a2:	0800                	addi	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    800001a4:	ca05                	beqz	a2,800001d4 <memcmp+0x36>
    800001a6:	fff6069b          	addiw	a3,a2,-1
    800001aa:	1682                	slli	a3,a3,0x20
    800001ac:	9281                	srli	a3,a3,0x20
    800001ae:	0685                	addi	a3,a3,1
    800001b0:	96aa                	add	a3,a3,a0
    if(*s1 != *s2)
    800001b2:	00054783          	lbu	a5,0(a0)
    800001b6:	0005c703          	lbu	a4,0(a1)
    800001ba:	00e79863          	bne	a5,a4,800001ca <memcmp+0x2c>
      return *s1 - *s2;
    s1++, s2++;
    800001be:	0505                	addi	a0,a0,1
    800001c0:	0585                	addi	a1,a1,1
  while(n-- > 0){
    800001c2:	fed518e3          	bne	a0,a3,800001b2 <memcmp+0x14>
  }

  return 0;
    800001c6:	4501                	li	a0,0
    800001c8:	a019                	j	800001ce <memcmp+0x30>
      return *s1 - *s2;
    800001ca:	40e7853b          	subw	a0,a5,a4
}
    800001ce:	6422                	ld	s0,8(sp)
    800001d0:	0141                	addi	sp,sp,16
    800001d2:	8082                	ret
  return 0;
    800001d4:	4501                	li	a0,0
    800001d6:	bfe5                	j	800001ce <memcmp+0x30>

00000000800001d8 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    800001d8:	1141                	addi	sp,sp,-16
    800001da:	e422                	sd	s0,8(sp)
    800001dc:	0800                	addi	s0,sp,16
  const char *s;
  char *d;

  if(n == 0)
    800001de:	ca0d                	beqz	a2,80000210 <memmove+0x38>
    return dst;
  
  s = src;
  d = dst;
  if(s < d && s + n > d){
    800001e0:	00a5f963          	bgeu	a1,a0,800001f2 <memmove+0x1a>
    800001e4:	02061693          	slli	a3,a2,0x20
    800001e8:	9281                	srli	a3,a3,0x20
    800001ea:	00d58733          	add	a4,a1,a3
    800001ee:	02e56463          	bltu	a0,a4,80000216 <memmove+0x3e>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    800001f2:	fff6079b          	addiw	a5,a2,-1
    800001f6:	1782                	slli	a5,a5,0x20
    800001f8:	9381                	srli	a5,a5,0x20
    800001fa:	0785                	addi	a5,a5,1
    800001fc:	97ae                	add	a5,a5,a1
    800001fe:	872a                	mv	a4,a0
      *d++ = *s++;
    80000200:	0585                	addi	a1,a1,1
    80000202:	0705                	addi	a4,a4,1
    80000204:	fff5c683          	lbu	a3,-1(a1)
    80000208:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    8000020c:	fef59ae3          	bne	a1,a5,80000200 <memmove+0x28>

  return dst;
}
    80000210:	6422                	ld	s0,8(sp)
    80000212:	0141                	addi	sp,sp,16
    80000214:	8082                	ret
    d += n;
    80000216:	96aa                	add	a3,a3,a0
    while(n-- > 0)
    80000218:	fff6079b          	addiw	a5,a2,-1
    8000021c:	1782                	slli	a5,a5,0x20
    8000021e:	9381                	srli	a5,a5,0x20
    80000220:	fff7c793          	not	a5,a5
    80000224:	97ba                	add	a5,a5,a4
      *--d = *--s;
    80000226:	177d                	addi	a4,a4,-1
    80000228:	16fd                	addi	a3,a3,-1
    8000022a:	00074603          	lbu	a2,0(a4)
    8000022e:	00c68023          	sb	a2,0(a3)
    while(n-- > 0)
    80000232:	fef71ae3          	bne	a4,a5,80000226 <memmove+0x4e>
    80000236:	bfe9                	j	80000210 <memmove+0x38>

0000000080000238 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    80000238:	1141                	addi	sp,sp,-16
    8000023a:	e406                	sd	ra,8(sp)
    8000023c:	e022                	sd	s0,0(sp)
    8000023e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    80000240:	00000097          	auipc	ra,0x0
    80000244:	f98080e7          	jalr	-104(ra) # 800001d8 <memmove>
}
    80000248:	60a2                	ld	ra,8(sp)
    8000024a:	6402                	ld	s0,0(sp)
    8000024c:	0141                	addi	sp,sp,16
    8000024e:	8082                	ret

0000000080000250 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    80000250:	1141                	addi	sp,sp,-16
    80000252:	e422                	sd	s0,8(sp)
    80000254:	0800                	addi	s0,sp,16
  while(n > 0 && *p && *p == *q)
    80000256:	ce11                	beqz	a2,80000272 <strncmp+0x22>
    80000258:	00054783          	lbu	a5,0(a0)
    8000025c:	cf89                	beqz	a5,80000276 <strncmp+0x26>
    8000025e:	0005c703          	lbu	a4,0(a1)
    80000262:	00f71a63          	bne	a4,a5,80000276 <strncmp+0x26>
    n--, p++, q++;
    80000266:	367d                	addiw	a2,a2,-1
    80000268:	0505                	addi	a0,a0,1
    8000026a:	0585                	addi	a1,a1,1
  while(n > 0 && *p && *p == *q)
    8000026c:	f675                	bnez	a2,80000258 <strncmp+0x8>
  if(n == 0)
    return 0;
    8000026e:	4501                	li	a0,0
    80000270:	a809                	j	80000282 <strncmp+0x32>
    80000272:	4501                	li	a0,0
    80000274:	a039                	j	80000282 <strncmp+0x32>
  if(n == 0)
    80000276:	ca09                	beqz	a2,80000288 <strncmp+0x38>
  return (uchar)*p - (uchar)*q;
    80000278:	00054503          	lbu	a0,0(a0)
    8000027c:	0005c783          	lbu	a5,0(a1)
    80000280:	9d1d                	subw	a0,a0,a5
}
    80000282:	6422                	ld	s0,8(sp)
    80000284:	0141                	addi	sp,sp,16
    80000286:	8082                	ret
    return 0;
    80000288:	4501                	li	a0,0
    8000028a:	bfe5                	j	80000282 <strncmp+0x32>

000000008000028c <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    8000028c:	1141                	addi	sp,sp,-16
    8000028e:	e422                	sd	s0,8(sp)
    80000290:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    80000292:	872a                	mv	a4,a0
    80000294:	8832                	mv	a6,a2
    80000296:	367d                	addiw	a2,a2,-1
    80000298:	01005963          	blez	a6,800002aa <strncpy+0x1e>
    8000029c:	0705                	addi	a4,a4,1
    8000029e:	0005c783          	lbu	a5,0(a1)
    800002a2:	fef70fa3          	sb	a5,-1(a4)
    800002a6:	0585                	addi	a1,a1,1
    800002a8:	f7f5                	bnez	a5,80000294 <strncpy+0x8>
    ;
  while(n-- > 0)
    800002aa:	00c05d63          	blez	a2,800002c4 <strncpy+0x38>
    800002ae:	86ba                	mv	a3,a4
    *s++ = 0;
    800002b0:	0685                	addi	a3,a3,1
    800002b2:	fe068fa3          	sb	zero,-1(a3)
  while(n-- > 0)
    800002b6:	fff6c793          	not	a5,a3
    800002ba:	9fb9                	addw	a5,a5,a4
    800002bc:	010787bb          	addw	a5,a5,a6
    800002c0:	fef048e3          	bgtz	a5,800002b0 <strncpy+0x24>
  return os;
}
    800002c4:	6422                	ld	s0,8(sp)
    800002c6:	0141                	addi	sp,sp,16
    800002c8:	8082                	ret

00000000800002ca <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    800002ca:	1141                	addi	sp,sp,-16
    800002cc:	e422                	sd	s0,8(sp)
    800002ce:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    800002d0:	02c05363          	blez	a2,800002f6 <safestrcpy+0x2c>
    800002d4:	fff6069b          	addiw	a3,a2,-1
    800002d8:	1682                	slli	a3,a3,0x20
    800002da:	9281                	srli	a3,a3,0x20
    800002dc:	96ae                	add	a3,a3,a1
    800002de:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    800002e0:	00d58963          	beq	a1,a3,800002f2 <safestrcpy+0x28>
    800002e4:	0585                	addi	a1,a1,1
    800002e6:	0785                	addi	a5,a5,1
    800002e8:	fff5c703          	lbu	a4,-1(a1)
    800002ec:	fee78fa3          	sb	a4,-1(a5)
    800002f0:	fb65                	bnez	a4,800002e0 <safestrcpy+0x16>
    ;
  *s = 0;
    800002f2:	00078023          	sb	zero,0(a5)
  return os;
}
    800002f6:	6422                	ld	s0,8(sp)
    800002f8:	0141                	addi	sp,sp,16
    800002fa:	8082                	ret

00000000800002fc <strlen>:

int
strlen(const char *s)
{
    800002fc:	1141                	addi	sp,sp,-16
    800002fe:	e422                	sd	s0,8(sp)
    80000300:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    80000302:	00054783          	lbu	a5,0(a0)
    80000306:	cf91                	beqz	a5,80000322 <strlen+0x26>
    80000308:	0505                	addi	a0,a0,1
    8000030a:	87aa                	mv	a5,a0
    8000030c:	4685                	li	a3,1
    8000030e:	9e89                	subw	a3,a3,a0
    80000310:	00f6853b          	addw	a0,a3,a5
    80000314:	0785                	addi	a5,a5,1
    80000316:	fff7c703          	lbu	a4,-1(a5)
    8000031a:	fb7d                	bnez	a4,80000310 <strlen+0x14>
    ;
  return n;
}
    8000031c:	6422                	ld	s0,8(sp)
    8000031e:	0141                	addi	sp,sp,16
    80000320:	8082                	ret
  for(n = 0; s[n]; n++)
    80000322:	4501                	li	a0,0
    80000324:	bfe5                	j	8000031c <strlen+0x20>

0000000080000326 <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    80000326:	1141                	addi	sp,sp,-16
    80000328:	e406                	sd	ra,8(sp)
    8000032a:	e022                	sd	s0,0(sp)
    8000032c:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    8000032e:	00001097          	auipc	ra,0x1
    80000332:	fe4080e7          	jalr	-28(ra) # 80001312 <cpuid>
    virtio_disk_init(); // emulated hard disk
    userinit();      // first user process
    __sync_synchronize();
    started = 1;
  } else {
    while(started == 0)
    80000336:	00009717          	auipc	a4,0x9
    8000033a:	cca70713          	addi	a4,a4,-822 # 80009000 <started>
  if(cpuid() == 0){
    8000033e:	c139                	beqz	a0,80000384 <main+0x5e>
    while(started == 0)
    80000340:	431c                	lw	a5,0(a4)
    80000342:	2781                	sext.w	a5,a5
    80000344:	dff5                	beqz	a5,80000340 <main+0x1a>
      ;
    __sync_synchronize();
    80000346:	0ff0000f          	fence
    printf("hart %d starting\n", cpuid());
    8000034a:	00001097          	auipc	ra,0x1
    8000034e:	fc8080e7          	jalr	-56(ra) # 80001312 <cpuid>
    80000352:	85aa                	mv	a1,a0
    80000354:	00008517          	auipc	a0,0x8
    80000358:	ce450513          	addi	a0,a0,-796 # 80008038 <etext+0x38>
    8000035c:	00006097          	auipc	ra,0x6
    80000360:	12e080e7          	jalr	302(ra) # 8000648a <printf>
    kvminithart();    // turn on paging
    80000364:	00000097          	auipc	ra,0x0
    80000368:	0d8080e7          	jalr	216(ra) # 8000043c <kvminithart>
    trapinithart();   // install kernel trap vector
    8000036c:	00002097          	auipc	ra,0x2
    80000370:	c1e080e7          	jalr	-994(ra) # 80001f8a <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80000374:	00005097          	auipc	ra,0x5
    80000378:	3dc080e7          	jalr	988(ra) # 80005750 <plicinithart>
  }

  scheduler();
    8000037c:	00001097          	auipc	ra,0x1
    80000380:	4cc080e7          	jalr	1228(ra) # 80001848 <scheduler>
    consoleinit();
    80000384:	00006097          	auipc	ra,0x6
    80000388:	fce080e7          	jalr	-50(ra) # 80006352 <consoleinit>
    printfinit();
    8000038c:	00006097          	auipc	ra,0x6
    80000390:	2e4080e7          	jalr	740(ra) # 80006670 <printfinit>
    printf("\n");
    80000394:	00008517          	auipc	a0,0x8
    80000398:	cb450513          	addi	a0,a0,-844 # 80008048 <etext+0x48>
    8000039c:	00006097          	auipc	ra,0x6
    800003a0:	0ee080e7          	jalr	238(ra) # 8000648a <printf>
    printf("xv6 kernel is booting\n");
    800003a4:	00008517          	auipc	a0,0x8
    800003a8:	c7c50513          	addi	a0,a0,-900 # 80008020 <etext+0x20>
    800003ac:	00006097          	auipc	ra,0x6
    800003b0:	0de080e7          	jalr	222(ra) # 8000648a <printf>
    printf("\n");
    800003b4:	00008517          	auipc	a0,0x8
    800003b8:	c9450513          	addi	a0,a0,-876 # 80008048 <etext+0x48>
    800003bc:	00006097          	auipc	ra,0x6
    800003c0:	0ce080e7          	jalr	206(ra) # 8000648a <printf>
    kinit();         // physical page allocator
    800003c4:	00000097          	auipc	ra,0x0
    800003c8:	d18080e7          	jalr	-744(ra) # 800000dc <kinit>
    kvminit();       // create kernel page table
    800003cc:	00000097          	auipc	ra,0x0
    800003d0:	322080e7          	jalr	802(ra) # 800006ee <kvminit>
    kvminithart();   // turn on paging
    800003d4:	00000097          	auipc	ra,0x0
    800003d8:	068080e7          	jalr	104(ra) # 8000043c <kvminithart>
    procinit();      // process table
    800003dc:	00001097          	auipc	ra,0x1
    800003e0:	e88080e7          	jalr	-376(ra) # 80001264 <procinit>
    trapinit();      // trap vectors
    800003e4:	00002097          	auipc	ra,0x2
    800003e8:	b7e080e7          	jalr	-1154(ra) # 80001f62 <trapinit>
    trapinithart();  // install kernel trap vector
    800003ec:	00002097          	auipc	ra,0x2
    800003f0:	b9e080e7          	jalr	-1122(ra) # 80001f8a <trapinithart>
    plicinit();      // set up interrupt controller
    800003f4:	00005097          	auipc	ra,0x5
    800003f8:	346080e7          	jalr	838(ra) # 8000573a <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    800003fc:	00005097          	auipc	ra,0x5
    80000400:	354080e7          	jalr	852(ra) # 80005750 <plicinithart>
    binit();         // buffer cache
    80000404:	00002097          	auipc	ra,0x2
    80000408:	3d0080e7          	jalr	976(ra) # 800027d4 <binit>
    iinit();         // inode table
    8000040c:	00003097          	auipc	ra,0x3
    80000410:	a50080e7          	jalr	-1456(ra) # 80002e5c <iinit>
    fileinit();      // file table
    80000414:	00004097          	auipc	ra,0x4
    80000418:	b70080e7          	jalr	-1168(ra) # 80003f84 <fileinit>
    virtio_disk_init(); // emulated hard disk
    8000041c:	00005097          	auipc	ra,0x5
    80000420:	456080e7          	jalr	1110(ra) # 80005872 <virtio_disk_init>
    userinit();      // first user process
    80000424:	00001097          	auipc	ra,0x1
    80000428:	1f2080e7          	jalr	498(ra) # 80001616 <userinit>
    __sync_synchronize();
    8000042c:	0ff0000f          	fence
    started = 1;
    80000430:	4785                	li	a5,1
    80000432:	00009717          	auipc	a4,0x9
    80000436:	bcf72723          	sw	a5,-1074(a4) # 80009000 <started>
    8000043a:	b789                	j	8000037c <main+0x56>

000000008000043c <kvminithart>:
}

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void kvminithart()
{
    8000043c:	1141                	addi	sp,sp,-16
    8000043e:	e422                	sd	s0,8(sp)
    80000440:	0800                	addi	s0,sp,16
  w_satp(MAKE_SATP(kernel_pagetable));
    80000442:	00009797          	auipc	a5,0x9
    80000446:	bc67b783          	ld	a5,-1082(a5) # 80009008 <kernel_pagetable>
    8000044a:	83b1                	srli	a5,a5,0xc
    8000044c:	577d                	li	a4,-1
    8000044e:	177e                	slli	a4,a4,0x3f
    80000450:	8fd9                	or	a5,a5,a4
// supervisor address translation and protection;
// holds the address of the page table.
static inline void
w_satp(uint64 x)
{
  asm volatile("csrw satp, %0" : : "r" (x));
    80000452:	18079073          	csrw	satp,a5
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    80000456:	12000073          	sfence.vma
  sfence_vma();
}
    8000045a:	6422                	ld	s0,8(sp)
    8000045c:	0141                	addi	sp,sp,16
    8000045e:	8082                	ret

0000000080000460 <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    80000460:	7139                	addi	sp,sp,-64
    80000462:	fc06                	sd	ra,56(sp)
    80000464:	f822                	sd	s0,48(sp)
    80000466:	f426                	sd	s1,40(sp)
    80000468:	f04a                	sd	s2,32(sp)
    8000046a:	ec4e                	sd	s3,24(sp)
    8000046c:	e852                	sd	s4,16(sp)
    8000046e:	e456                	sd	s5,8(sp)
    80000470:	e05a                	sd	s6,0(sp)
    80000472:	0080                	addi	s0,sp,64
    80000474:	84aa                	mv	s1,a0
    80000476:	89ae                	mv	s3,a1
    80000478:	8ab2                	mv	s5,a2
  if (va >= MAXVA)
    8000047a:	57fd                	li	a5,-1
    8000047c:	83e9                	srli	a5,a5,0x1a
    8000047e:	4a79                	li	s4,30
    panic("walk");

  for (int level = 2; level > 0; level--)
    80000480:	4b31                	li	s6,12
  if (va >= MAXVA)
    80000482:	04b7f263          	bgeu	a5,a1,800004c6 <walk+0x66>
    panic("walk");
    80000486:	00008517          	auipc	a0,0x8
    8000048a:	bca50513          	addi	a0,a0,-1078 # 80008050 <etext+0x50>
    8000048e:	00006097          	auipc	ra,0x6
    80000492:	fb2080e7          	jalr	-78(ra) # 80006440 <panic>
    {
      pagetable = (pagetable_t)PTE2PA(*pte);
    }
    else
    {
      if (!alloc || (pagetable = (pde_t *)kalloc()) == 0)
    80000496:	060a8663          	beqz	s5,80000502 <walk+0xa2>
    8000049a:	00000097          	auipc	ra,0x0
    8000049e:	c7e080e7          	jalr	-898(ra) # 80000118 <kalloc>
    800004a2:	84aa                	mv	s1,a0
    800004a4:	c529                	beqz	a0,800004ee <walk+0x8e>
        return 0;
      memset(pagetable, 0, PGSIZE);
    800004a6:	6605                	lui	a2,0x1
    800004a8:	4581                	li	a1,0
    800004aa:	00000097          	auipc	ra,0x0
    800004ae:	cce080e7          	jalr	-818(ra) # 80000178 <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    800004b2:	00c4d793          	srli	a5,s1,0xc
    800004b6:	07aa                	slli	a5,a5,0xa
    800004b8:	0017e793          	ori	a5,a5,1
    800004bc:	00f93023          	sd	a5,0(s2)
  for (int level = 2; level > 0; level--)
    800004c0:	3a5d                	addiw	s4,s4,-9
    800004c2:	036a0063          	beq	s4,s6,800004e2 <walk+0x82>
    pte_t *pte = &pagetable[PX(level, va)];
    800004c6:	0149d933          	srl	s2,s3,s4
    800004ca:	1ff97913          	andi	s2,s2,511
    800004ce:	090e                	slli	s2,s2,0x3
    800004d0:	9926                	add	s2,s2,s1
    if (*pte & PTE_V)
    800004d2:	00093483          	ld	s1,0(s2)
    800004d6:	0014f793          	andi	a5,s1,1
    800004da:	dfd5                	beqz	a5,80000496 <walk+0x36>
      pagetable = (pagetable_t)PTE2PA(*pte);
    800004dc:	80a9                	srli	s1,s1,0xa
    800004de:	04b2                	slli	s1,s1,0xc
    800004e0:	b7c5                	j	800004c0 <walk+0x60>
    }
  }

  /* 此為access到的pte, 如果是lru，則把這個pte加進去 或是更改順序 */
  pte_t *pte = &pagetable[PX(0, va)]; 
    800004e2:	00c9d513          	srli	a0,s3,0xc
    800004e6:	1ff57513          	andi	a0,a0,511
    800004ea:	050e                	slli	a0,a0,0x3
    800004ec:	9526                	add	a0,a0,s1
    if (pte_idx == -1){ // not find
      q_push(&q, (uint64)pte);
    }
#endif
  return pte;
}
    800004ee:	70e2                	ld	ra,56(sp)
    800004f0:	7442                	ld	s0,48(sp)
    800004f2:	74a2                	ld	s1,40(sp)
    800004f4:	7902                	ld	s2,32(sp)
    800004f6:	69e2                	ld	s3,24(sp)
    800004f8:	6a42                	ld	s4,16(sp)
    800004fa:	6aa2                	ld	s5,8(sp)
    800004fc:	6b02                	ld	s6,0(sp)
    800004fe:	6121                	addi	sp,sp,64
    80000500:	8082                	ret
        return 0;
    80000502:	4501                	li	a0,0
    80000504:	b7ed                	j	800004ee <walk+0x8e>

0000000080000506 <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if (va >= MAXVA)
    80000506:	57fd                	li	a5,-1
    80000508:	83e9                	srli	a5,a5,0x1a
    8000050a:	00b7f463          	bgeu	a5,a1,80000512 <walkaddr+0xc>
    return 0;
    8000050e:	4501                	li	a0,0
    return 0;
  if ((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    80000510:	8082                	ret
{
    80000512:	1141                	addi	sp,sp,-16
    80000514:	e406                	sd	ra,8(sp)
    80000516:	e022                	sd	s0,0(sp)
    80000518:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    8000051a:	4601                	li	a2,0
    8000051c:	00000097          	auipc	ra,0x0
    80000520:	f44080e7          	jalr	-188(ra) # 80000460 <walk>
  if (pte == 0)
    80000524:	c105                	beqz	a0,80000544 <walkaddr+0x3e>
  if ((*pte & PTE_V) == 0)
    80000526:	611c                	ld	a5,0(a0)
  if ((*pte & PTE_U) == 0)
    80000528:	0117f693          	andi	a3,a5,17
    8000052c:	4745                	li	a4,17
    return 0;
    8000052e:	4501                	li	a0,0
  if ((*pte & PTE_U) == 0)
    80000530:	00e68663          	beq	a3,a4,8000053c <walkaddr+0x36>
}
    80000534:	60a2                	ld	ra,8(sp)
    80000536:	6402                	ld	s0,0(sp)
    80000538:	0141                	addi	sp,sp,16
    8000053a:	8082                	ret
  pa = PTE2PA(*pte);
    8000053c:	00a7d513          	srli	a0,a5,0xa
    80000540:	0532                	slli	a0,a0,0xc
  return pa;
    80000542:	bfcd                	j	80000534 <walkaddr+0x2e>
    return 0;
    80000544:	4501                	li	a0,0
    80000546:	b7fd                	j	80000534 <walkaddr+0x2e>

0000000080000548 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned. Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    80000548:	715d                	addi	sp,sp,-80
    8000054a:	e486                	sd	ra,72(sp)
    8000054c:	e0a2                	sd	s0,64(sp)
    8000054e:	fc26                	sd	s1,56(sp)
    80000550:	f84a                	sd	s2,48(sp)
    80000552:	f44e                	sd	s3,40(sp)
    80000554:	f052                	sd	s4,32(sp)
    80000556:	ec56                	sd	s5,24(sp)
    80000558:	e85a                	sd	s6,16(sp)
    8000055a:	e45e                	sd	s7,8(sp)
    8000055c:	0880                	addi	s0,sp,80
  uint64 a, last;
  pte_t *pte;

  if (size == 0)
    8000055e:	c205                	beqz	a2,8000057e <mappages+0x36>
    80000560:	8aaa                	mv	s5,a0
    80000562:	8b3a                	mv	s6,a4
    panic("mappages: size");
  a = PGROUNDDOWN(va);
    80000564:	77fd                	lui	a5,0xfffff
    80000566:	00f5fa33          	and	s4,a1,a5
  last = PGROUNDDOWN(va + size - 1);
    8000056a:	15fd                	addi	a1,a1,-1
    8000056c:	00c589b3          	add	s3,a1,a2
    80000570:	00f9f9b3          	and	s3,s3,a5
  a = PGROUNDDOWN(va);
    80000574:	8952                	mv	s2,s4
    80000576:	41468a33          	sub	s4,a3,s4
    if (*pte & PTE_V)
      panic("mappages: remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if (a == last)
      break;
    a += PGSIZE;
    8000057a:	6b85                	lui	s7,0x1
    8000057c:	a015                	j	800005a0 <mappages+0x58>
    panic("mappages: size");
    8000057e:	00008517          	auipc	a0,0x8
    80000582:	ada50513          	addi	a0,a0,-1318 # 80008058 <etext+0x58>
    80000586:	00006097          	auipc	ra,0x6
    8000058a:	eba080e7          	jalr	-326(ra) # 80006440 <panic>
      panic("mappages: remap");
    8000058e:	00008517          	auipc	a0,0x8
    80000592:	ada50513          	addi	a0,a0,-1318 # 80008068 <etext+0x68>
    80000596:	00006097          	auipc	ra,0x6
    8000059a:	eaa080e7          	jalr	-342(ra) # 80006440 <panic>
    a += PGSIZE;
    8000059e:	995e                	add	s2,s2,s7
  for (;;)
    800005a0:	012a04b3          	add	s1,s4,s2
    if ((pte = walk(pagetable, a, 1)) == 0)
    800005a4:	4605                	li	a2,1
    800005a6:	85ca                	mv	a1,s2
    800005a8:	8556                	mv	a0,s5
    800005aa:	00000097          	auipc	ra,0x0
    800005ae:	eb6080e7          	jalr	-330(ra) # 80000460 <walk>
    800005b2:	cd19                	beqz	a0,800005d0 <mappages+0x88>
    if (*pte & PTE_V)
    800005b4:	611c                	ld	a5,0(a0)
    800005b6:	8b85                	andi	a5,a5,1
    800005b8:	fbf9                	bnez	a5,8000058e <mappages+0x46>
    *pte = PA2PTE(pa) | perm | PTE_V;
    800005ba:	80b1                	srli	s1,s1,0xc
    800005bc:	04aa                	slli	s1,s1,0xa
    800005be:	0164e4b3          	or	s1,s1,s6
    800005c2:	0014e493          	ori	s1,s1,1
    800005c6:	e104                	sd	s1,0(a0)
    if (a == last)
    800005c8:	fd391be3          	bne	s2,s3,8000059e <mappages+0x56>
    pa += PGSIZE;
  }
  return 0;
    800005cc:	4501                	li	a0,0
    800005ce:	a011                	j	800005d2 <mappages+0x8a>
      return -1;
    800005d0:	557d                	li	a0,-1
}
    800005d2:	60a6                	ld	ra,72(sp)
    800005d4:	6406                	ld	s0,64(sp)
    800005d6:	74e2                	ld	s1,56(sp)
    800005d8:	7942                	ld	s2,48(sp)
    800005da:	79a2                	ld	s3,40(sp)
    800005dc:	7a02                	ld	s4,32(sp)
    800005de:	6ae2                	ld	s5,24(sp)
    800005e0:	6b42                	ld	s6,16(sp)
    800005e2:	6ba2                	ld	s7,8(sp)
    800005e4:	6161                	addi	sp,sp,80
    800005e6:	8082                	ret

00000000800005e8 <kvmmap>:
{
    800005e8:	1141                	addi	sp,sp,-16
    800005ea:	e406                	sd	ra,8(sp)
    800005ec:	e022                	sd	s0,0(sp)
    800005ee:	0800                	addi	s0,sp,16
    800005f0:	87b6                	mv	a5,a3
  if (mappages(kpgtbl, va, sz, pa, perm) != 0)
    800005f2:	86b2                	mv	a3,a2
    800005f4:	863e                	mv	a2,a5
    800005f6:	00000097          	auipc	ra,0x0
    800005fa:	f52080e7          	jalr	-174(ra) # 80000548 <mappages>
    800005fe:	e509                	bnez	a0,80000608 <kvmmap+0x20>
}
    80000600:	60a2                	ld	ra,8(sp)
    80000602:	6402                	ld	s0,0(sp)
    80000604:	0141                	addi	sp,sp,16
    80000606:	8082                	ret
    panic("kvmmap");
    80000608:	00008517          	auipc	a0,0x8
    8000060c:	a7050513          	addi	a0,a0,-1424 # 80008078 <etext+0x78>
    80000610:	00006097          	auipc	ra,0x6
    80000614:	e30080e7          	jalr	-464(ra) # 80006440 <panic>

0000000080000618 <kvmmake>:
{
    80000618:	1101                	addi	sp,sp,-32
    8000061a:	ec06                	sd	ra,24(sp)
    8000061c:	e822                	sd	s0,16(sp)
    8000061e:	e426                	sd	s1,8(sp)
    80000620:	e04a                	sd	s2,0(sp)
    80000622:	1000                	addi	s0,sp,32
  kpgtbl = (pagetable_t)kalloc();
    80000624:	00000097          	auipc	ra,0x0
    80000628:	af4080e7          	jalr	-1292(ra) # 80000118 <kalloc>
    8000062c:	84aa                	mv	s1,a0
  memset(kpgtbl, 0, PGSIZE);
    8000062e:	6605                	lui	a2,0x1
    80000630:	4581                	li	a1,0
    80000632:	00000097          	auipc	ra,0x0
    80000636:	b46080e7          	jalr	-1210(ra) # 80000178 <memset>
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    8000063a:	4719                	li	a4,6
    8000063c:	6685                	lui	a3,0x1
    8000063e:	10000637          	lui	a2,0x10000
    80000642:	100005b7          	lui	a1,0x10000
    80000646:	8526                	mv	a0,s1
    80000648:	00000097          	auipc	ra,0x0
    8000064c:	fa0080e7          	jalr	-96(ra) # 800005e8 <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    80000650:	4719                	li	a4,6
    80000652:	6685                	lui	a3,0x1
    80000654:	10001637          	lui	a2,0x10001
    80000658:	100015b7          	lui	a1,0x10001
    8000065c:	8526                	mv	a0,s1
    8000065e:	00000097          	auipc	ra,0x0
    80000662:	f8a080e7          	jalr	-118(ra) # 800005e8 <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    80000666:	4719                	li	a4,6
    80000668:	004006b7          	lui	a3,0x400
    8000066c:	0c000637          	lui	a2,0xc000
    80000670:	0c0005b7          	lui	a1,0xc000
    80000674:	8526                	mv	a0,s1
    80000676:	00000097          	auipc	ra,0x0
    8000067a:	f72080e7          	jalr	-142(ra) # 800005e8 <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext - KERNBASE, PTE_R | PTE_X);
    8000067e:	00008917          	auipc	s2,0x8
    80000682:	98290913          	addi	s2,s2,-1662 # 80008000 <etext>
    80000686:	4729                	li	a4,10
    80000688:	80008697          	auipc	a3,0x80008
    8000068c:	97868693          	addi	a3,a3,-1672 # 8000 <_entry-0x7fff8000>
    80000690:	4605                	li	a2,1
    80000692:	067e                	slli	a2,a2,0x1f
    80000694:	85b2                	mv	a1,a2
    80000696:	8526                	mv	a0,s1
    80000698:	00000097          	auipc	ra,0x0
    8000069c:	f50080e7          	jalr	-176(ra) # 800005e8 <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP - (uint64)etext, PTE_R | PTE_W);
    800006a0:	4719                	li	a4,6
    800006a2:	46c5                	li	a3,17
    800006a4:	06ee                	slli	a3,a3,0x1b
    800006a6:	412686b3          	sub	a3,a3,s2
    800006aa:	864a                	mv	a2,s2
    800006ac:	85ca                	mv	a1,s2
    800006ae:	8526                	mv	a0,s1
    800006b0:	00000097          	auipc	ra,0x0
    800006b4:	f38080e7          	jalr	-200(ra) # 800005e8 <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    800006b8:	4729                	li	a4,10
    800006ba:	6685                	lui	a3,0x1
    800006bc:	00007617          	auipc	a2,0x7
    800006c0:	94460613          	addi	a2,a2,-1724 # 80007000 <_trampoline>
    800006c4:	040005b7          	lui	a1,0x4000
    800006c8:	15fd                	addi	a1,a1,-1
    800006ca:	05b2                	slli	a1,a1,0xc
    800006cc:	8526                	mv	a0,s1
    800006ce:	00000097          	auipc	ra,0x0
    800006d2:	f1a080e7          	jalr	-230(ra) # 800005e8 <kvmmap>
  proc_mapstacks(kpgtbl);
    800006d6:	8526                	mv	a0,s1
    800006d8:	00001097          	auipc	ra,0x1
    800006dc:	af8080e7          	jalr	-1288(ra) # 800011d0 <proc_mapstacks>
}
    800006e0:	8526                	mv	a0,s1
    800006e2:	60e2                	ld	ra,24(sp)
    800006e4:	6442                	ld	s0,16(sp)
    800006e6:	64a2                	ld	s1,8(sp)
    800006e8:	6902                	ld	s2,0(sp)
    800006ea:	6105                	addi	sp,sp,32
    800006ec:	8082                	ret

00000000800006ee <kvminit>:
{
    800006ee:	1141                	addi	sp,sp,-16
    800006f0:	e406                	sd	ra,8(sp)
    800006f2:	e022                	sd	s0,0(sp)
    800006f4:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    800006f6:	00000097          	auipc	ra,0x0
    800006fa:	f22080e7          	jalr	-222(ra) # 80000618 <kvmmake>
    800006fe:	00009797          	auipc	a5,0x9
    80000702:	90a7b523          	sd	a0,-1782(a5) # 80009008 <kernel_pagetable>
}
    80000706:	60a2                	ld	ra,8(sp)
    80000708:	6402                	ld	s0,0(sp)
    8000070a:	0141                	addi	sp,sp,16
    8000070c:	8082                	ret

000000008000070e <uvmunmap>:

// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    8000070e:	715d                	addi	sp,sp,-80
    80000710:	e486                	sd	ra,72(sp)
    80000712:	e0a2                	sd	s0,64(sp)
    80000714:	fc26                	sd	s1,56(sp)
    80000716:	f84a                	sd	s2,48(sp)
    80000718:	f44e                	sd	s3,40(sp)
    8000071a:	f052                	sd	s4,32(sp)
    8000071c:	ec56                	sd	s5,24(sp)
    8000071e:	e85a                	sd	s6,16(sp)
    80000720:	e45e                	sd	s7,8(sp)
    80000722:	0880                	addi	s0,sp,80
  uint64 a;
  pte_t *pte;

  if ((va % PGSIZE) != 0)
    80000724:	03459793          	slli	a5,a1,0x34
    80000728:	e795                	bnez	a5,80000754 <uvmunmap+0x46>
    8000072a:	8a2a                	mv	s4,a0
    8000072c:	892e                	mv	s2,a1
    8000072e:	8b36                	mv	s6,a3
    panic("uvmunmap: not aligned");

  for (a = va; a < va + npages * PGSIZE; a += PGSIZE)
    80000730:	0632                	slli	a2,a2,0xc
    80000732:	00b609b3          	add	s3,a2,a1
    }

    if ((*pte & PTE_V) == 0)
      continue;

    if (PTE_FLAGS(*pte) == PTE_V)
    80000736:	4b85                	li	s7,1
  for (a = va; a < va + npages * PGSIZE; a += PGSIZE)
    80000738:	6a85                	lui	s5,0x1
    8000073a:	0735e163          	bltu	a1,s3,8000079c <uvmunmap+0x8e>
      uint64 pa = PTE2PA(*pte);
      kfree((void *)pa);
    }
    *pte = 0;
  }
}
    8000073e:	60a6                	ld	ra,72(sp)
    80000740:	6406                	ld	s0,64(sp)
    80000742:	74e2                	ld	s1,56(sp)
    80000744:	7942                	ld	s2,48(sp)
    80000746:	79a2                	ld	s3,40(sp)
    80000748:	7a02                	ld	s4,32(sp)
    8000074a:	6ae2                	ld	s5,24(sp)
    8000074c:	6b42                	ld	s6,16(sp)
    8000074e:	6ba2                	ld	s7,8(sp)
    80000750:	6161                	addi	sp,sp,80
    80000752:	8082                	ret
    panic("uvmunmap: not aligned");
    80000754:	00008517          	auipc	a0,0x8
    80000758:	92c50513          	addi	a0,a0,-1748 # 80008080 <etext+0x80>
    8000075c:	00006097          	auipc	ra,0x6
    80000760:	ce4080e7          	jalr	-796(ra) # 80006440 <panic>
      panic("uvmunmap: walk");
    80000764:	00008517          	auipc	a0,0x8
    80000768:	93450513          	addi	a0,a0,-1740 # 80008098 <etext+0x98>
    8000076c:	00006097          	auipc	ra,0x6
    80000770:	cd4080e7          	jalr	-812(ra) # 80006440 <panic>
      panic("uvmunmap: not a leaf");
    80000774:	00008517          	auipc	a0,0x8
    80000778:	93450513          	addi	a0,a0,-1740 # 800080a8 <etext+0xa8>
    8000077c:	00006097          	auipc	ra,0x6
    80000780:	cc4080e7          	jalr	-828(ra) # 80006440 <panic>
      uint64 pa = PTE2PA(*pte);
    80000784:	83a9                	srli	a5,a5,0xa
      kfree((void *)pa);
    80000786:	00c79513          	slli	a0,a5,0xc
    8000078a:	00000097          	auipc	ra,0x0
    8000078e:	892080e7          	jalr	-1902(ra) # 8000001c <kfree>
    *pte = 0;
    80000792:	0004b023          	sd	zero,0(s1)
  for (a = va; a < va + npages * PGSIZE; a += PGSIZE)
    80000796:	9956                	add	s2,s2,s5
    80000798:	fb3973e3          	bgeu	s2,s3,8000073e <uvmunmap+0x30>
    if ((pte = walk(pagetable, a, 0)) == 0)
    8000079c:	4601                	li	a2,0
    8000079e:	85ca                	mv	a1,s2
    800007a0:	8552                	mv	a0,s4
    800007a2:	00000097          	auipc	ra,0x0
    800007a6:	cbe080e7          	jalr	-834(ra) # 80000460 <walk>
    800007aa:	84aa                	mv	s1,a0
    800007ac:	dd45                	beqz	a0,80000764 <uvmunmap+0x56>
    if (*pte & PTE_S)
    800007ae:	611c                	ld	a5,0(a0)
    800007b0:	2007f713          	andi	a4,a5,512
    800007b4:	f36d                	bnez	a4,80000796 <uvmunmap+0x88>
    if ((*pte & PTE_V) == 0)
    800007b6:	0017f713          	andi	a4,a5,1
    800007ba:	df71                	beqz	a4,80000796 <uvmunmap+0x88>
    if (PTE_FLAGS(*pte) == PTE_V)
    800007bc:	3ff7f713          	andi	a4,a5,1023
    800007c0:	fb770ae3          	beq	a4,s7,80000774 <uvmunmap+0x66>
    if (do_free)
    800007c4:	fc0b07e3          	beqz	s6,80000792 <uvmunmap+0x84>
    800007c8:	bf75                	j	80000784 <uvmunmap+0x76>

00000000800007ca <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    800007ca:	1101                	addi	sp,sp,-32
    800007cc:	ec06                	sd	ra,24(sp)
    800007ce:	e822                	sd	s0,16(sp)
    800007d0:	e426                	sd	s1,8(sp)
    800007d2:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t)kalloc();
    800007d4:	00000097          	auipc	ra,0x0
    800007d8:	944080e7          	jalr	-1724(ra) # 80000118 <kalloc>
    800007dc:	84aa                	mv	s1,a0
  if (pagetable == 0)
    800007de:	c519                	beqz	a0,800007ec <uvmcreate+0x22>
    return 0;
  memset(pagetable, 0, PGSIZE);
    800007e0:	6605                	lui	a2,0x1
    800007e2:	4581                	li	a1,0
    800007e4:	00000097          	auipc	ra,0x0
    800007e8:	994080e7          	jalr	-1644(ra) # 80000178 <memset>
  return pagetable;
}
    800007ec:	8526                	mv	a0,s1
    800007ee:	60e2                	ld	ra,24(sp)
    800007f0:	6442                	ld	s0,16(sp)
    800007f2:	64a2                	ld	s1,8(sp)
    800007f4:	6105                	addi	sp,sp,32
    800007f6:	8082                	ret

00000000800007f8 <uvminit>:

// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void uvminit(pagetable_t pagetable, uchar *src, uint sz)
{
    800007f8:	7179                	addi	sp,sp,-48
    800007fa:	f406                	sd	ra,40(sp)
    800007fc:	f022                	sd	s0,32(sp)
    800007fe:	ec26                	sd	s1,24(sp)
    80000800:	e84a                	sd	s2,16(sp)
    80000802:	e44e                	sd	s3,8(sp)
    80000804:	e052                	sd	s4,0(sp)
    80000806:	1800                	addi	s0,sp,48
  char *mem;

  if (sz >= PGSIZE)
    80000808:	6785                	lui	a5,0x1
    8000080a:	04f67863          	bgeu	a2,a5,8000085a <uvminit+0x62>
    8000080e:	8a2a                	mv	s4,a0
    80000810:	89ae                	mv	s3,a1
    80000812:	84b2                	mv	s1,a2
    panic("inituvm: more than a page");
  mem = kalloc();
    80000814:	00000097          	auipc	ra,0x0
    80000818:	904080e7          	jalr	-1788(ra) # 80000118 <kalloc>
    8000081c:	892a                	mv	s2,a0
  memset(mem, 0, PGSIZE);
    8000081e:	6605                	lui	a2,0x1
    80000820:	4581                	li	a1,0
    80000822:	00000097          	auipc	ra,0x0
    80000826:	956080e7          	jalr	-1706(ra) # 80000178 <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W | PTE_R | PTE_X | PTE_U);
    8000082a:	4779                	li	a4,30
    8000082c:	86ca                	mv	a3,s2
    8000082e:	6605                	lui	a2,0x1
    80000830:	4581                	li	a1,0
    80000832:	8552                	mv	a0,s4
    80000834:	00000097          	auipc	ra,0x0
    80000838:	d14080e7          	jalr	-748(ra) # 80000548 <mappages>
  memmove(mem, src, sz);
    8000083c:	8626                	mv	a2,s1
    8000083e:	85ce                	mv	a1,s3
    80000840:	854a                	mv	a0,s2
    80000842:	00000097          	auipc	ra,0x0
    80000846:	996080e7          	jalr	-1642(ra) # 800001d8 <memmove>
}
    8000084a:	70a2                	ld	ra,40(sp)
    8000084c:	7402                	ld	s0,32(sp)
    8000084e:	64e2                	ld	s1,24(sp)
    80000850:	6942                	ld	s2,16(sp)
    80000852:	69a2                	ld	s3,8(sp)
    80000854:	6a02                	ld	s4,0(sp)
    80000856:	6145                	addi	sp,sp,48
    80000858:	8082                	ret
    panic("inituvm: more than a page");
    8000085a:	00008517          	auipc	a0,0x8
    8000085e:	86650513          	addi	a0,a0,-1946 # 800080c0 <etext+0xc0>
    80000862:	00006097          	auipc	ra,0x6
    80000866:	bde080e7          	jalr	-1058(ra) # 80006440 <panic>

000000008000086a <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    8000086a:	1101                	addi	sp,sp,-32
    8000086c:	ec06                	sd	ra,24(sp)
    8000086e:	e822                	sd	s0,16(sp)
    80000870:	e426                	sd	s1,8(sp)
    80000872:	1000                	addi	s0,sp,32
  if (newsz >= oldsz)
    return oldsz;
    80000874:	84ae                	mv	s1,a1
  if (newsz >= oldsz)
    80000876:	00b67d63          	bgeu	a2,a1,80000890 <uvmdealloc+0x26>
    8000087a:	84b2                	mv	s1,a2

  if (PGROUNDUP(newsz) < PGROUNDUP(oldsz))
    8000087c:	6785                	lui	a5,0x1
    8000087e:	17fd                	addi	a5,a5,-1
    80000880:	00f60733          	add	a4,a2,a5
    80000884:	767d                	lui	a2,0xfffff
    80000886:	8f71                	and	a4,a4,a2
    80000888:	97ae                	add	a5,a5,a1
    8000088a:	8ff1                	and	a5,a5,a2
    8000088c:	00f76863          	bltu	a4,a5,8000089c <uvmdealloc+0x32>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
}
    80000890:	8526                	mv	a0,s1
    80000892:	60e2                	ld	ra,24(sp)
    80000894:	6442                	ld	s0,16(sp)
    80000896:	64a2                	ld	s1,8(sp)
    80000898:	6105                	addi	sp,sp,32
    8000089a:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    8000089c:	8f99                	sub	a5,a5,a4
    8000089e:	83b1                	srli	a5,a5,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    800008a0:	4685                	li	a3,1
    800008a2:	0007861b          	sext.w	a2,a5
    800008a6:	85ba                	mv	a1,a4
    800008a8:	00000097          	auipc	ra,0x0
    800008ac:	e66080e7          	jalr	-410(ra) # 8000070e <uvmunmap>
    800008b0:	b7c5                	j	80000890 <uvmdealloc+0x26>

00000000800008b2 <uvmalloc>:
  if (newsz < oldsz)
    800008b2:	0ab66163          	bltu	a2,a1,80000954 <uvmalloc+0xa2>
{
    800008b6:	7139                	addi	sp,sp,-64
    800008b8:	fc06                	sd	ra,56(sp)
    800008ba:	f822                	sd	s0,48(sp)
    800008bc:	f426                	sd	s1,40(sp)
    800008be:	f04a                	sd	s2,32(sp)
    800008c0:	ec4e                	sd	s3,24(sp)
    800008c2:	e852                	sd	s4,16(sp)
    800008c4:	e456                	sd	s5,8(sp)
    800008c6:	0080                	addi	s0,sp,64
    800008c8:	8aaa                	mv	s5,a0
    800008ca:	8a32                	mv	s4,a2
  oldsz = PGROUNDUP(oldsz);
    800008cc:	6985                	lui	s3,0x1
    800008ce:	19fd                	addi	s3,s3,-1
    800008d0:	95ce                	add	a1,a1,s3
    800008d2:	79fd                	lui	s3,0xfffff
    800008d4:	0135f9b3          	and	s3,a1,s3
  for (a = oldsz; a < newsz; a += PGSIZE)
    800008d8:	08c9f063          	bgeu	s3,a2,80000958 <uvmalloc+0xa6>
    800008dc:	894e                	mv	s2,s3
    mem = kalloc();
    800008de:	00000097          	auipc	ra,0x0
    800008e2:	83a080e7          	jalr	-1990(ra) # 80000118 <kalloc>
    800008e6:	84aa                	mv	s1,a0
    if (mem == 0)
    800008e8:	c51d                	beqz	a0,80000916 <uvmalloc+0x64>
    memset(mem, 0, PGSIZE);
    800008ea:	6605                	lui	a2,0x1
    800008ec:	4581                	li	a1,0
    800008ee:	00000097          	auipc	ra,0x0
    800008f2:	88a080e7          	jalr	-1910(ra) # 80000178 <memset>
    if (mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_W | PTE_X | PTE_R | PTE_U) != 0)
    800008f6:	4779                	li	a4,30
    800008f8:	86a6                	mv	a3,s1
    800008fa:	6605                	lui	a2,0x1
    800008fc:	85ca                	mv	a1,s2
    800008fe:	8556                	mv	a0,s5
    80000900:	00000097          	auipc	ra,0x0
    80000904:	c48080e7          	jalr	-952(ra) # 80000548 <mappages>
    80000908:	e905                	bnez	a0,80000938 <uvmalloc+0x86>
  for (a = oldsz; a < newsz; a += PGSIZE)
    8000090a:	6785                	lui	a5,0x1
    8000090c:	993e                	add	s2,s2,a5
    8000090e:	fd4968e3          	bltu	s2,s4,800008de <uvmalloc+0x2c>
  return newsz;
    80000912:	8552                	mv	a0,s4
    80000914:	a809                	j	80000926 <uvmalloc+0x74>
      uvmdealloc(pagetable, a, oldsz);
    80000916:	864e                	mv	a2,s3
    80000918:	85ca                	mv	a1,s2
    8000091a:	8556                	mv	a0,s5
    8000091c:	00000097          	auipc	ra,0x0
    80000920:	f4e080e7          	jalr	-178(ra) # 8000086a <uvmdealloc>
      return 0;
    80000924:	4501                	li	a0,0
}
    80000926:	70e2                	ld	ra,56(sp)
    80000928:	7442                	ld	s0,48(sp)
    8000092a:	74a2                	ld	s1,40(sp)
    8000092c:	7902                	ld	s2,32(sp)
    8000092e:	69e2                	ld	s3,24(sp)
    80000930:	6a42                	ld	s4,16(sp)
    80000932:	6aa2                	ld	s5,8(sp)
    80000934:	6121                	addi	sp,sp,64
    80000936:	8082                	ret
      kfree(mem);
    80000938:	8526                	mv	a0,s1
    8000093a:	fffff097          	auipc	ra,0xfffff
    8000093e:	6e2080e7          	jalr	1762(ra) # 8000001c <kfree>
      uvmdealloc(pagetable, a, oldsz);
    80000942:	864e                	mv	a2,s3
    80000944:	85ca                	mv	a1,s2
    80000946:	8556                	mv	a0,s5
    80000948:	00000097          	auipc	ra,0x0
    8000094c:	f22080e7          	jalr	-222(ra) # 8000086a <uvmdealloc>
      return 0;
    80000950:	4501                	li	a0,0
    80000952:	bfd1                	j	80000926 <uvmalloc+0x74>
    return oldsz;
    80000954:	852e                	mv	a0,a1
}
    80000956:	8082                	ret
  return newsz;
    80000958:	8532                	mv	a0,a2
    8000095a:	b7f1                	j	80000926 <uvmalloc+0x74>

000000008000095c <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void freewalk(pagetable_t pagetable)
{
    8000095c:	7179                	addi	sp,sp,-48
    8000095e:	f406                	sd	ra,40(sp)
    80000960:	f022                	sd	s0,32(sp)
    80000962:	ec26                	sd	s1,24(sp)
    80000964:	e84a                	sd	s2,16(sp)
    80000966:	e44e                	sd	s3,8(sp)
    80000968:	e052                	sd	s4,0(sp)
    8000096a:	1800                	addi	s0,sp,48
    8000096c:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a page table.
  for (int i = 0; i < 512; i++)
    8000096e:	84aa                	mv	s1,a0
    80000970:	6905                	lui	s2,0x1
    80000972:	992a                	add	s2,s2,a0
  {
    pte_t pte = pagetable[i];
    if ((pte & PTE_V) && (pte & (PTE_R | PTE_W | PTE_X)) == 0)
    80000974:	4985                	li	s3,1
    80000976:	a821                	j	8000098e <freewalk+0x32>
    {
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    80000978:	8129                	srli	a0,a0,0xa
      freewalk((pagetable_t)child);
    8000097a:	0532                	slli	a0,a0,0xc
    8000097c:	00000097          	auipc	ra,0x0
    80000980:	fe0080e7          	jalr	-32(ra) # 8000095c <freewalk>
      pagetable[i] = 0;
    80000984:	0004b023          	sd	zero,0(s1)
  for (int i = 0; i < 512; i++)
    80000988:	04a1                	addi	s1,s1,8
    8000098a:	03248163          	beq	s1,s2,800009ac <freewalk+0x50>
    pte_t pte = pagetable[i];
    8000098e:	6088                	ld	a0,0(s1)
    if ((pte & PTE_V) && (pte & (PTE_R | PTE_W | PTE_X)) == 0)
    80000990:	00f57793          	andi	a5,a0,15
    80000994:	ff3782e3          	beq	a5,s3,80000978 <freewalk+0x1c>
    }
    else if (pte & PTE_V)
    80000998:	8905                	andi	a0,a0,1
    8000099a:	d57d                	beqz	a0,80000988 <freewalk+0x2c>
    {
      panic("freewalk: leaf");
    8000099c:	00007517          	auipc	a0,0x7
    800009a0:	74450513          	addi	a0,a0,1860 # 800080e0 <etext+0xe0>
    800009a4:	00006097          	auipc	ra,0x6
    800009a8:	a9c080e7          	jalr	-1380(ra) # 80006440 <panic>
    }
  }
  kfree((void *)pagetable);
    800009ac:	8552                	mv	a0,s4
    800009ae:	fffff097          	auipc	ra,0xfffff
    800009b2:	66e080e7          	jalr	1646(ra) # 8000001c <kfree>
}
    800009b6:	70a2                	ld	ra,40(sp)
    800009b8:	7402                	ld	s0,32(sp)
    800009ba:	64e2                	ld	s1,24(sp)
    800009bc:	6942                	ld	s2,16(sp)
    800009be:	69a2                	ld	s3,8(sp)
    800009c0:	6a02                	ld	s4,0(sp)
    800009c2:	6145                	addi	sp,sp,48
    800009c4:	8082                	ret

00000000800009c6 <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void uvmfree(pagetable_t pagetable, uint64 sz)
{
    800009c6:	1101                	addi	sp,sp,-32
    800009c8:	ec06                	sd	ra,24(sp)
    800009ca:	e822                	sd	s0,16(sp)
    800009cc:	e426                	sd	s1,8(sp)
    800009ce:	1000                	addi	s0,sp,32
    800009d0:	84aa                	mv	s1,a0
  if (sz > 0)
    800009d2:	e999                	bnez	a1,800009e8 <uvmfree+0x22>
    uvmunmap(pagetable, 0, PGROUNDUP(sz) / PGSIZE, 1);
  freewalk(pagetable);
    800009d4:	8526                	mv	a0,s1
    800009d6:	00000097          	auipc	ra,0x0
    800009da:	f86080e7          	jalr	-122(ra) # 8000095c <freewalk>
}
    800009de:	60e2                	ld	ra,24(sp)
    800009e0:	6442                	ld	s0,16(sp)
    800009e2:	64a2                	ld	s1,8(sp)
    800009e4:	6105                	addi	sp,sp,32
    800009e6:	8082                	ret
    uvmunmap(pagetable, 0, PGROUNDUP(sz) / PGSIZE, 1);
    800009e8:	6605                	lui	a2,0x1
    800009ea:	167d                	addi	a2,a2,-1
    800009ec:	962e                	add	a2,a2,a1
    800009ee:	4685                	li	a3,1
    800009f0:	8231                	srli	a2,a2,0xc
    800009f2:	4581                	li	a1,0
    800009f4:	00000097          	auipc	ra,0x0
    800009f8:	d1a080e7          	jalr	-742(ra) # 8000070e <uvmunmap>
    800009fc:	bfe1                	j	800009d4 <uvmfree+0xe>

00000000800009fe <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for (i = 0; i < sz; i += PGSIZE)
    800009fe:	c679                	beqz	a2,80000acc <uvmcopy+0xce>
{
    80000a00:	715d                	addi	sp,sp,-80
    80000a02:	e486                	sd	ra,72(sp)
    80000a04:	e0a2                	sd	s0,64(sp)
    80000a06:	fc26                	sd	s1,56(sp)
    80000a08:	f84a                	sd	s2,48(sp)
    80000a0a:	f44e                	sd	s3,40(sp)
    80000a0c:	f052                	sd	s4,32(sp)
    80000a0e:	ec56                	sd	s5,24(sp)
    80000a10:	e85a                	sd	s6,16(sp)
    80000a12:	e45e                	sd	s7,8(sp)
    80000a14:	0880                	addi	s0,sp,80
    80000a16:	8b2a                	mv	s6,a0
    80000a18:	8aae                	mv	s5,a1
    80000a1a:	8a32                	mv	s4,a2
  for (i = 0; i < sz; i += PGSIZE)
    80000a1c:	4981                	li	s3,0
  {
    if ((pte = walk(old, i, 0)) == 0)
    80000a1e:	4601                	li	a2,0
    80000a20:	85ce                	mv	a1,s3
    80000a22:	855a                	mv	a0,s6
    80000a24:	00000097          	auipc	ra,0x0
    80000a28:	a3c080e7          	jalr	-1476(ra) # 80000460 <walk>
    80000a2c:	c531                	beqz	a0,80000a78 <uvmcopy+0x7a>
      panic("uvmcopy: pte should exist");
    if ((*pte & PTE_V) == 0)
    80000a2e:	6118                	ld	a4,0(a0)
    80000a30:	00177793          	andi	a5,a4,1
    80000a34:	cbb1                	beqz	a5,80000a88 <uvmcopy+0x8a>
      panic("uvmcopy: page not present");
    pa = PTE2PA(*pte);
    80000a36:	00a75593          	srli	a1,a4,0xa
    80000a3a:	00c59b93          	slli	s7,a1,0xc
    flags = PTE_FLAGS(*pte);
    80000a3e:	3ff77493          	andi	s1,a4,1023
    if ((mem = kalloc()) == 0)
    80000a42:	fffff097          	auipc	ra,0xfffff
    80000a46:	6d6080e7          	jalr	1750(ra) # 80000118 <kalloc>
    80000a4a:	892a                	mv	s2,a0
    80000a4c:	c939                	beqz	a0,80000aa2 <uvmcopy+0xa4>
      goto err;
    memmove(mem, (char *)pa, PGSIZE);
    80000a4e:	6605                	lui	a2,0x1
    80000a50:	85de                	mv	a1,s7
    80000a52:	fffff097          	auipc	ra,0xfffff
    80000a56:	786080e7          	jalr	1926(ra) # 800001d8 <memmove>
    if (mappages(new, i, PGSIZE, (uint64)mem, flags) != 0)
    80000a5a:	8726                	mv	a4,s1
    80000a5c:	86ca                	mv	a3,s2
    80000a5e:	6605                	lui	a2,0x1
    80000a60:	85ce                	mv	a1,s3
    80000a62:	8556                	mv	a0,s5
    80000a64:	00000097          	auipc	ra,0x0
    80000a68:	ae4080e7          	jalr	-1308(ra) # 80000548 <mappages>
    80000a6c:	e515                	bnez	a0,80000a98 <uvmcopy+0x9a>
  for (i = 0; i < sz; i += PGSIZE)
    80000a6e:	6785                	lui	a5,0x1
    80000a70:	99be                	add	s3,s3,a5
    80000a72:	fb49e6e3          	bltu	s3,s4,80000a1e <uvmcopy+0x20>
    80000a76:	a081                	j	80000ab6 <uvmcopy+0xb8>
      panic("uvmcopy: pte should exist");
    80000a78:	00007517          	auipc	a0,0x7
    80000a7c:	67850513          	addi	a0,a0,1656 # 800080f0 <etext+0xf0>
    80000a80:	00006097          	auipc	ra,0x6
    80000a84:	9c0080e7          	jalr	-1600(ra) # 80006440 <panic>
      panic("uvmcopy: page not present");
    80000a88:	00007517          	auipc	a0,0x7
    80000a8c:	68850513          	addi	a0,a0,1672 # 80008110 <etext+0x110>
    80000a90:	00006097          	auipc	ra,0x6
    80000a94:	9b0080e7          	jalr	-1616(ra) # 80006440 <panic>
    {
      kfree(mem);
    80000a98:	854a                	mv	a0,s2
    80000a9a:	fffff097          	auipc	ra,0xfffff
    80000a9e:	582080e7          	jalr	1410(ra) # 8000001c <kfree>
    }
  }
  return 0;

err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    80000aa2:	4685                	li	a3,1
    80000aa4:	00c9d613          	srli	a2,s3,0xc
    80000aa8:	4581                	li	a1,0
    80000aaa:	8556                	mv	a0,s5
    80000aac:	00000097          	auipc	ra,0x0
    80000ab0:	c62080e7          	jalr	-926(ra) # 8000070e <uvmunmap>
  return -1;
    80000ab4:	557d                	li	a0,-1
}
    80000ab6:	60a6                	ld	ra,72(sp)
    80000ab8:	6406                	ld	s0,64(sp)
    80000aba:	74e2                	ld	s1,56(sp)
    80000abc:	7942                	ld	s2,48(sp)
    80000abe:	79a2                	ld	s3,40(sp)
    80000ac0:	7a02                	ld	s4,32(sp)
    80000ac2:	6ae2                	ld	s5,24(sp)
    80000ac4:	6b42                	ld	s6,16(sp)
    80000ac6:	6ba2                	ld	s7,8(sp)
    80000ac8:	6161                	addi	sp,sp,80
    80000aca:	8082                	ret
  return 0;
    80000acc:	4501                	li	a0,0
}
    80000ace:	8082                	ret

0000000080000ad0 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void uvmclear(pagetable_t pagetable, uint64 va)
{
    80000ad0:	1141                	addi	sp,sp,-16
    80000ad2:	e406                	sd	ra,8(sp)
    80000ad4:	e022                	sd	s0,0(sp)
    80000ad6:	0800                	addi	s0,sp,16
  pte_t *pte;
  pte = walk(pagetable, va, 0);
    80000ad8:	4601                	li	a2,0
    80000ada:	00000097          	auipc	ra,0x0
    80000ade:	986080e7          	jalr	-1658(ra) # 80000460 <walk>
  if (pte == 0)
    80000ae2:	c901                	beqz	a0,80000af2 <uvmclear+0x22>
    panic("uvmclear");
  *pte &= ~PTE_U;
    80000ae4:	611c                	ld	a5,0(a0)
    80000ae6:	9bbd                	andi	a5,a5,-17
    80000ae8:	e11c                	sd	a5,0(a0)
}
    80000aea:	60a2                	ld	ra,8(sp)
    80000aec:	6402                	ld	s0,0(sp)
    80000aee:	0141                	addi	sp,sp,16
    80000af0:	8082                	ret
    panic("uvmclear");
    80000af2:	00007517          	auipc	a0,0x7
    80000af6:	63e50513          	addi	a0,a0,1598 # 80008130 <etext+0x130>
    80000afa:	00006097          	auipc	ra,0x6
    80000afe:	946080e7          	jalr	-1722(ra) # 80006440 <panic>

0000000080000b02 <copyout>:
// Return 0 on success, -1 on error.
int copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;

  while (len > 0)
    80000b02:	c6bd                	beqz	a3,80000b70 <copyout+0x6e>
{
    80000b04:	715d                	addi	sp,sp,-80
    80000b06:	e486                	sd	ra,72(sp)
    80000b08:	e0a2                	sd	s0,64(sp)
    80000b0a:	fc26                	sd	s1,56(sp)
    80000b0c:	f84a                	sd	s2,48(sp)
    80000b0e:	f44e                	sd	s3,40(sp)
    80000b10:	f052                	sd	s4,32(sp)
    80000b12:	ec56                	sd	s5,24(sp)
    80000b14:	e85a                	sd	s6,16(sp)
    80000b16:	e45e                	sd	s7,8(sp)
    80000b18:	e062                	sd	s8,0(sp)
    80000b1a:	0880                	addi	s0,sp,80
    80000b1c:	8b2a                	mv	s6,a0
    80000b1e:	8c2e                	mv	s8,a1
    80000b20:	8a32                	mv	s4,a2
    80000b22:	89b6                	mv	s3,a3
  {
    va0 = PGROUNDDOWN(dstva);
    80000b24:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if (pa0 == 0)
      return -1;
    n = PGSIZE - (dstva - va0);
    80000b26:	6a85                	lui	s5,0x1
    80000b28:	a015                	j	80000b4c <copyout+0x4a>
    if (n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80000b2a:	9562                	add	a0,a0,s8
    80000b2c:	0004861b          	sext.w	a2,s1
    80000b30:	85d2                	mv	a1,s4
    80000b32:	41250533          	sub	a0,a0,s2
    80000b36:	fffff097          	auipc	ra,0xfffff
    80000b3a:	6a2080e7          	jalr	1698(ra) # 800001d8 <memmove>

    len -= n;
    80000b3e:	409989b3          	sub	s3,s3,s1
    src += n;
    80000b42:	9a26                	add	s4,s4,s1
    dstva = va0 + PGSIZE;
    80000b44:	01590c33          	add	s8,s2,s5
  while (len > 0)
    80000b48:	02098263          	beqz	s3,80000b6c <copyout+0x6a>
    va0 = PGROUNDDOWN(dstva);
    80000b4c:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80000b50:	85ca                	mv	a1,s2
    80000b52:	855a                	mv	a0,s6
    80000b54:	00000097          	auipc	ra,0x0
    80000b58:	9b2080e7          	jalr	-1614(ra) # 80000506 <walkaddr>
    if (pa0 == 0)
    80000b5c:	cd01                	beqz	a0,80000b74 <copyout+0x72>
    n = PGSIZE - (dstva - va0);
    80000b5e:	418904b3          	sub	s1,s2,s8
    80000b62:	94d6                	add	s1,s1,s5
    if (n > len)
    80000b64:	fc99f3e3          	bgeu	s3,s1,80000b2a <copyout+0x28>
    80000b68:	84ce                	mv	s1,s3
    80000b6a:	b7c1                	j	80000b2a <copyout+0x28>
  }
  return 0;
    80000b6c:	4501                	li	a0,0
    80000b6e:	a021                	j	80000b76 <copyout+0x74>
    80000b70:	4501                	li	a0,0
}
    80000b72:	8082                	ret
      return -1;
    80000b74:	557d                	li	a0,-1
}
    80000b76:	60a6                	ld	ra,72(sp)
    80000b78:	6406                	ld	s0,64(sp)
    80000b7a:	74e2                	ld	s1,56(sp)
    80000b7c:	7942                	ld	s2,48(sp)
    80000b7e:	79a2                	ld	s3,40(sp)
    80000b80:	7a02                	ld	s4,32(sp)
    80000b82:	6ae2                	ld	s5,24(sp)
    80000b84:	6b42                	ld	s6,16(sp)
    80000b86:	6ba2                	ld	s7,8(sp)
    80000b88:	6c02                	ld	s8,0(sp)
    80000b8a:	6161                	addi	sp,sp,80
    80000b8c:	8082                	ret

0000000080000b8e <copyin>:
// Return 0 on success, -1 on error.
int copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while (len > 0)
    80000b8e:	c6bd                	beqz	a3,80000bfc <copyin+0x6e>
{
    80000b90:	715d                	addi	sp,sp,-80
    80000b92:	e486                	sd	ra,72(sp)
    80000b94:	e0a2                	sd	s0,64(sp)
    80000b96:	fc26                	sd	s1,56(sp)
    80000b98:	f84a                	sd	s2,48(sp)
    80000b9a:	f44e                	sd	s3,40(sp)
    80000b9c:	f052                	sd	s4,32(sp)
    80000b9e:	ec56                	sd	s5,24(sp)
    80000ba0:	e85a                	sd	s6,16(sp)
    80000ba2:	e45e                	sd	s7,8(sp)
    80000ba4:	e062                	sd	s8,0(sp)
    80000ba6:	0880                	addi	s0,sp,80
    80000ba8:	8b2a                	mv	s6,a0
    80000baa:	8a2e                	mv	s4,a1
    80000bac:	8c32                	mv	s8,a2
    80000bae:	89b6                	mv	s3,a3
  {
    va0 = PGROUNDDOWN(srcva);
    80000bb0:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if (pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000bb2:	6a85                	lui	s5,0x1
    80000bb4:	a015                	j	80000bd8 <copyin+0x4a>
    if (n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80000bb6:	9562                	add	a0,a0,s8
    80000bb8:	0004861b          	sext.w	a2,s1
    80000bbc:	412505b3          	sub	a1,a0,s2
    80000bc0:	8552                	mv	a0,s4
    80000bc2:	fffff097          	auipc	ra,0xfffff
    80000bc6:	616080e7          	jalr	1558(ra) # 800001d8 <memmove>

    len -= n;
    80000bca:	409989b3          	sub	s3,s3,s1
    dst += n;
    80000bce:	9a26                	add	s4,s4,s1
    srcva = va0 + PGSIZE;
    80000bd0:	01590c33          	add	s8,s2,s5
  while (len > 0)
    80000bd4:	02098263          	beqz	s3,80000bf8 <copyin+0x6a>
    va0 = PGROUNDDOWN(srcva);
    80000bd8:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80000bdc:	85ca                	mv	a1,s2
    80000bde:	855a                	mv	a0,s6
    80000be0:	00000097          	auipc	ra,0x0
    80000be4:	926080e7          	jalr	-1754(ra) # 80000506 <walkaddr>
    if (pa0 == 0)
    80000be8:	cd01                	beqz	a0,80000c00 <copyin+0x72>
    n = PGSIZE - (srcva - va0);
    80000bea:	418904b3          	sub	s1,s2,s8
    80000bee:	94d6                	add	s1,s1,s5
    if (n > len)
    80000bf0:	fc99f3e3          	bgeu	s3,s1,80000bb6 <copyin+0x28>
    80000bf4:	84ce                	mv	s1,s3
    80000bf6:	b7c1                	j	80000bb6 <copyin+0x28>
  }
  return 0;
    80000bf8:	4501                	li	a0,0
    80000bfa:	a021                	j	80000c02 <copyin+0x74>
    80000bfc:	4501                	li	a0,0
}
    80000bfe:	8082                	ret
      return -1;
    80000c00:	557d                	li	a0,-1
}
    80000c02:	60a6                	ld	ra,72(sp)
    80000c04:	6406                	ld	s0,64(sp)
    80000c06:	74e2                	ld	s1,56(sp)
    80000c08:	7942                	ld	s2,48(sp)
    80000c0a:	79a2                	ld	s3,40(sp)
    80000c0c:	7a02                	ld	s4,32(sp)
    80000c0e:	6ae2                	ld	s5,24(sp)
    80000c10:	6b42                	ld	s6,16(sp)
    80000c12:	6ba2                	ld	s7,8(sp)
    80000c14:	6c02                	ld	s8,0(sp)
    80000c16:	6161                	addi	sp,sp,80
    80000c18:	8082                	ret

0000000080000c1a <copyinstr>:
int copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while (got_null == 0 && max > 0)
    80000c1a:	c6c5                	beqz	a3,80000cc2 <copyinstr+0xa8>
{
    80000c1c:	715d                	addi	sp,sp,-80
    80000c1e:	e486                	sd	ra,72(sp)
    80000c20:	e0a2                	sd	s0,64(sp)
    80000c22:	fc26                	sd	s1,56(sp)
    80000c24:	f84a                	sd	s2,48(sp)
    80000c26:	f44e                	sd	s3,40(sp)
    80000c28:	f052                	sd	s4,32(sp)
    80000c2a:	ec56                	sd	s5,24(sp)
    80000c2c:	e85a                	sd	s6,16(sp)
    80000c2e:	e45e                	sd	s7,8(sp)
    80000c30:	0880                	addi	s0,sp,80
    80000c32:	8a2a                	mv	s4,a0
    80000c34:	8b2e                	mv	s6,a1
    80000c36:	8bb2                	mv	s7,a2
    80000c38:	84b6                	mv	s1,a3
  {
    va0 = PGROUNDDOWN(srcva);
    80000c3a:	7afd                	lui	s5,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if (pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000c3c:	6985                	lui	s3,0x1
    80000c3e:	a035                	j	80000c6a <copyinstr+0x50>
    char *p = (char *)(pa0 + (srcva - va0));
    while (n > 0)
    {
      if (*p == '\0')
      {
        *dst = '\0';
    80000c40:	00078023          	sb	zero,0(a5) # 1000 <_entry-0x7ffff000>
    80000c44:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if (got_null)
    80000c46:	0017b793          	seqz	a5,a5
    80000c4a:	40f00533          	neg	a0,a5
  }
  else
  {
    return -1;
  }
}
    80000c4e:	60a6                	ld	ra,72(sp)
    80000c50:	6406                	ld	s0,64(sp)
    80000c52:	74e2                	ld	s1,56(sp)
    80000c54:	7942                	ld	s2,48(sp)
    80000c56:	79a2                	ld	s3,40(sp)
    80000c58:	7a02                	ld	s4,32(sp)
    80000c5a:	6ae2                	ld	s5,24(sp)
    80000c5c:	6b42                	ld	s6,16(sp)
    80000c5e:	6ba2                	ld	s7,8(sp)
    80000c60:	6161                	addi	sp,sp,80
    80000c62:	8082                	ret
    srcva = va0 + PGSIZE;
    80000c64:	01390bb3          	add	s7,s2,s3
  while (got_null == 0 && max > 0)
    80000c68:	c8a9                	beqz	s1,80000cba <copyinstr+0xa0>
    va0 = PGROUNDDOWN(srcva);
    80000c6a:	015bf933          	and	s2,s7,s5
    pa0 = walkaddr(pagetable, va0);
    80000c6e:	85ca                	mv	a1,s2
    80000c70:	8552                	mv	a0,s4
    80000c72:	00000097          	auipc	ra,0x0
    80000c76:	894080e7          	jalr	-1900(ra) # 80000506 <walkaddr>
    if (pa0 == 0)
    80000c7a:	c131                	beqz	a0,80000cbe <copyinstr+0xa4>
    n = PGSIZE - (srcva - va0);
    80000c7c:	41790833          	sub	a6,s2,s7
    80000c80:	984e                	add	a6,a6,s3
    if (n > max)
    80000c82:	0104f363          	bgeu	s1,a6,80000c88 <copyinstr+0x6e>
    80000c86:	8826                	mv	a6,s1
    char *p = (char *)(pa0 + (srcva - va0));
    80000c88:	955e                	add	a0,a0,s7
    80000c8a:	41250533          	sub	a0,a0,s2
    while (n > 0)
    80000c8e:	fc080be3          	beqz	a6,80000c64 <copyinstr+0x4a>
    80000c92:	985a                	add	a6,a6,s6
    80000c94:	87da                	mv	a5,s6
      if (*p == '\0')
    80000c96:	41650633          	sub	a2,a0,s6
    80000c9a:	14fd                	addi	s1,s1,-1
    80000c9c:	9b26                	add	s6,s6,s1
    80000c9e:	00f60733          	add	a4,a2,a5
    80000ca2:	00074703          	lbu	a4,0(a4)
    80000ca6:	df49                	beqz	a4,80000c40 <copyinstr+0x26>
        *dst = *p;
    80000ca8:	00e78023          	sb	a4,0(a5)
      --max;
    80000cac:	40fb04b3          	sub	s1,s6,a5
      dst++;
    80000cb0:	0785                	addi	a5,a5,1
    while (n > 0)
    80000cb2:	ff0796e3          	bne	a5,a6,80000c9e <copyinstr+0x84>
      dst++;
    80000cb6:	8b42                	mv	s6,a6
    80000cb8:	b775                	j	80000c64 <copyinstr+0x4a>
    80000cba:	4781                	li	a5,0
    80000cbc:	b769                	j	80000c46 <copyinstr+0x2c>
      return -1;
    80000cbe:	557d                	li	a0,-1
    80000cc0:	b779                	j	80000c4e <copyinstr+0x34>
  int got_null = 0;
    80000cc2:	4781                	li	a5,0
  if (got_null)
    80000cc4:	0017b793          	seqz	a5,a5
    80000cc8:	40f00533          	neg	a0,a5
}
    80000ccc:	8082                	ret

0000000080000cce <print_Symbol>:

void print_Symbol(pte_t ini_pte)
{
    80000cce:	1101                	addi	sp,sp,-32
    80000cd0:	ec06                	sd	ra,24(sp)
    80000cd2:	e822                	sd	s0,16(sp)
    80000cd4:	e426                	sd	s1,8(sp)
    80000cd6:	1000                	addi	s0,sp,32
    80000cd8:	84aa                	mv	s1,a0
  if (ini_pte & PTE_V)
    80000cda:	00157793          	andi	a5,a0,1
    80000cde:	e3b9                	bnez	a5,80000d24 <print_Symbol+0x56>
    printf(" V");
  if (ini_pte & PTE_R)
    80000ce0:	0024f793          	andi	a5,s1,2
    80000ce4:	eba9                	bnez	a5,80000d36 <print_Symbol+0x68>
    printf(" R");
  if (ini_pte & PTE_W)
    80000ce6:	0044f793          	andi	a5,s1,4
    80000cea:	efb9                	bnez	a5,80000d48 <print_Symbol+0x7a>
    printf(" W");
  if (ini_pte & PTE_X)
    80000cec:	0084f793          	andi	a5,s1,8
    80000cf0:	e7ad                	bnez	a5,80000d5a <print_Symbol+0x8c>
    printf(" X");
  if (ini_pte & PTE_U)
    80000cf2:	0104f793          	andi	a5,s1,16
    80000cf6:	ebbd                	bnez	a5,80000d6c <print_Symbol+0x9e>
    printf(" U");
  if (ini_pte & PTE_S)
    80000cf8:	2004f793          	andi	a5,s1,512
    80000cfc:	e3c9                	bnez	a5,80000d7e <print_Symbol+0xb0>
  {
    printf(" S");
  }
  else
  {
    if (ini_pte & PTE_D)
    80000cfe:	0804f793          	andi	a5,s1,128
    80000d02:	e7d9                	bnez	a5,80000d90 <print_Symbol+0xc2>
      printf(" D");
    if (ini_pte & PTE_P)
    80000d04:	1004f493          	andi	s1,s1,256
    80000d08:	ecc9                	bnez	s1,80000da2 <print_Symbol+0xd4>
      printf(" P");
  }
  printf("\n");
    80000d0a:	00007517          	auipc	a0,0x7
    80000d0e:	33e50513          	addi	a0,a0,830 # 80008048 <etext+0x48>
    80000d12:	00005097          	auipc	ra,0x5
    80000d16:	778080e7          	jalr	1912(ra) # 8000648a <printf>
}
    80000d1a:	60e2                	ld	ra,24(sp)
    80000d1c:	6442                	ld	s0,16(sp)
    80000d1e:	64a2                	ld	s1,8(sp)
    80000d20:	6105                	addi	sp,sp,32
    80000d22:	8082                	ret
    printf(" V");
    80000d24:	00007517          	auipc	a0,0x7
    80000d28:	41c50513          	addi	a0,a0,1052 # 80008140 <etext+0x140>
    80000d2c:	00005097          	auipc	ra,0x5
    80000d30:	75e080e7          	jalr	1886(ra) # 8000648a <printf>
    80000d34:	b775                	j	80000ce0 <print_Symbol+0x12>
    printf(" R");
    80000d36:	00007517          	auipc	a0,0x7
    80000d3a:	41250513          	addi	a0,a0,1042 # 80008148 <etext+0x148>
    80000d3e:	00005097          	auipc	ra,0x5
    80000d42:	74c080e7          	jalr	1868(ra) # 8000648a <printf>
    80000d46:	b745                	j	80000ce6 <print_Symbol+0x18>
    printf(" W");
    80000d48:	00007517          	auipc	a0,0x7
    80000d4c:	40850513          	addi	a0,a0,1032 # 80008150 <etext+0x150>
    80000d50:	00005097          	auipc	ra,0x5
    80000d54:	73a080e7          	jalr	1850(ra) # 8000648a <printf>
    80000d58:	bf51                	j	80000cec <print_Symbol+0x1e>
    printf(" X");
    80000d5a:	00007517          	auipc	a0,0x7
    80000d5e:	3fe50513          	addi	a0,a0,1022 # 80008158 <etext+0x158>
    80000d62:	00005097          	auipc	ra,0x5
    80000d66:	728080e7          	jalr	1832(ra) # 8000648a <printf>
    80000d6a:	b761                	j	80000cf2 <print_Symbol+0x24>
    printf(" U");
    80000d6c:	00007517          	auipc	a0,0x7
    80000d70:	3f450513          	addi	a0,a0,1012 # 80008160 <etext+0x160>
    80000d74:	00005097          	auipc	ra,0x5
    80000d78:	716080e7          	jalr	1814(ra) # 8000648a <printf>
    80000d7c:	bfb5                	j	80000cf8 <print_Symbol+0x2a>
    printf(" S");
    80000d7e:	00007517          	auipc	a0,0x7
    80000d82:	3ea50513          	addi	a0,a0,1002 # 80008168 <etext+0x168>
    80000d86:	00005097          	auipc	ra,0x5
    80000d8a:	704080e7          	jalr	1796(ra) # 8000648a <printf>
    80000d8e:	bfb5                	j	80000d0a <print_Symbol+0x3c>
      printf(" D");
    80000d90:	00007517          	auipc	a0,0x7
    80000d94:	3e050513          	addi	a0,a0,992 # 80008170 <etext+0x170>
    80000d98:	00005097          	auipc	ra,0x5
    80000d9c:	6f2080e7          	jalr	1778(ra) # 8000648a <printf>
    80000da0:	b795                	j	80000d04 <print_Symbol+0x36>
      printf(" P");
    80000da2:	00007517          	auipc	a0,0x7
    80000da6:	3d650513          	addi	a0,a0,982 # 80008178 <etext+0x178>
    80000daa:	00005097          	auipc	ra,0x5
    80000dae:	6e0080e7          	jalr	1760(ra) # 8000648a <printf>
    80000db2:	bfa1                	j	80000d0a <print_Symbol+0x3c>

0000000080000db4 <madvise>:

/* NTU OS 2024 */
/* Map pages to physical memory or swap space. */
int madvise(uint64 base, uint64 len, int advice)
{
    80000db4:	715d                	addi	sp,sp,-80
    80000db6:	e486                	sd	ra,72(sp)
    80000db8:	e0a2                	sd	s0,64(sp)
    80000dba:	fc26                	sd	s1,56(sp)
    80000dbc:	f84a                	sd	s2,48(sp)
    80000dbe:	f44e                	sd	s3,40(sp)
    80000dc0:	f052                	sd	s4,32(sp)
    80000dc2:	ec56                	sd	s5,24(sp)
    80000dc4:	e85a                	sd	s6,16(sp)
    80000dc6:	e45e                	sd	s7,8(sp)
    80000dc8:	0880                	addi	s0,sp,80
    80000dca:	84aa                	mv	s1,a0
    80000dcc:	8a2e                	mv	s4,a1
    80000dce:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    80000dd0:	00000097          	auipc	ra,0x0
    80000dd4:	56e080e7          	jalr	1390(ra) # 8000133e <myproc>
  pagetable_t pgtbl = p->pagetable;

  if (base > p->sz || (base + len) > p->sz)
    80000dd8:	6538                	ld	a4,72(a0)
    80000dda:	1a976763          	bltu	a4,s1,80000f88 <madvise+0x1d4>
    80000dde:	87aa                	mv	a5,a0
    80000de0:	01448933          	add	s2,s1,s4
    80000de4:	1b276463          	bltu	a4,s2,80000f8c <madvise+0x1d8>
    return -1;
  }

  if (len == 0)
  {
    return 0;
    80000de8:	4501                	li	a0,0
  if (len == 0)
    80000dea:	020a0963          	beqz	s4,80000e1c <madvise+0x68>

  uint64 begin = PGROUNDDOWN(base);
  uint64 last = PGROUNDDOWN(base + len - 1);

  if (advice == MADV_NORMAL){
    return 0;
    80000dee:	854e                	mv	a0,s3
  if (advice == MADV_NORMAL){
    80000df0:	02098663          	beqz	s3,80000e1c <madvise+0x68>
  pagetable_t pgtbl = p->pagetable;
    80000df4:	0507ba03          	ld	s4,80(a5)
  uint64 begin = PGROUNDDOWN(base);
    80000df8:	77fd                	lui	a5,0xfffff
    80000dfa:	8cfd                	and	s1,s1,a5
  uint64 last = PGROUNDDOWN(base + len - 1);
    80000dfc:	197d                	addi	s2,s2,-1
    80000dfe:	00f97933          	and	s2,s2,a5
  }
  else if (advice == MADV_WILLNEED){ // disk -> physical memory
    80000e02:	4785                	li	a5,1
    80000e04:	02f98763          	beq	s3,a5,80000e32 <madvise+0x7e>

    end_op();
    return 0;
    // TODO
  }
  else if (advice == MADV_DONTNEED){ // physical memory -> disk
    80000e08:	4789                	li	a5,2
    80000e0a:	0af98e63          	beq	s3,a5,80000ec6 <madvise+0x112>
    }

    end_op();
    return 0;
  }
  else if (advice == MADV_PIN){
    80000e0e:	478d                	li	a5,3
    80000e10:	10f98663          	beq	s3,a5,80000f1c <madvise+0x168>
      pte = walk(pgtbl, va, 0);
      *pte |= PTE_P;
    }
    end_op();
  }
  else if (advice == MADV_UNPIN){
    80000e14:	4791                	li	a5,4
      *pte &= ~PTE_P;
    }
    end_op();
  }
  else{
    return -1;
    80000e16:	557d                	li	a0,-1
  else if (advice == MADV_UNPIN){
    80000e18:	12f98d63          	beq	s3,a5,80000f52 <madvise+0x19e>
  }
  return -1;
}
    80000e1c:	60a6                	ld	ra,72(sp)
    80000e1e:	6406                	ld	s0,64(sp)
    80000e20:	74e2                	ld	s1,56(sp)
    80000e22:	7942                	ld	s2,48(sp)
    80000e24:	79a2                	ld	s3,40(sp)
    80000e26:	7a02                	ld	s4,32(sp)
    80000e28:	6ae2                	ld	s5,24(sp)
    80000e2a:	6b42                	ld	s6,16(sp)
    80000e2c:	6ba2                	ld	s7,8(sp)
    80000e2e:	6161                	addi	sp,sp,80
    80000e30:	8082                	ret
    begin_op();
    80000e32:	00003097          	auipc	ra,0x3
    80000e36:	d6a080e7          	jalr	-662(ra) # 80003b9c <begin_op>
    for (uint64 va = begin; va <= last; va += PGSIZE)
    80000e3a:	08996063          	bltu	s2,s1,80000eba <madvise+0x106>
    80000e3e:	6b05                	lui	s6,0x1
    80000e40:	a811                	j	80000e54 <madvise+0xa0>
          end_op();
    80000e42:	00003097          	auipc	ra,0x3
    80000e46:	dda080e7          	jalr	-550(ra) # 80003c1c <end_op>
          return -1;
    80000e4a:	557d                	li	a0,-1
    80000e4c:	bfc1                	j	80000e1c <madvise+0x68>
    for (uint64 va = begin; va <= last; va += PGSIZE)
    80000e4e:	94da                	add	s1,s1,s6
    80000e50:	06996563          	bltu	s2,s1,80000eba <madvise+0x106>
      pte = walk(pgtbl, va, 0);
    80000e54:	4601                	li	a2,0
    80000e56:	85a6                	mv	a1,s1
    80000e58:	8552                	mv	a0,s4
    80000e5a:	fffff097          	auipc	ra,0xfffff
    80000e5e:	606080e7          	jalr	1542(ra) # 80000460 <walk>
    80000e62:	89aa                	mv	s3,a0
      if (pte != 0 && (*pte & PTE_S)) // 確保資料在disk裡
    80000e64:	d56d                	beqz	a0,80000e4e <madvise+0x9a>
    80000e66:	611c                	ld	a5,0(a0)
    80000e68:	2007f793          	andi	a5,a5,512
    80000e6c:	d3ed                	beqz	a5,80000e4e <madvise+0x9a>
        char *pa = (char *)kalloc(); // 位在physical memory的free page
    80000e6e:	fffff097          	auipc	ra,0xfffff
    80000e72:	2aa080e7          	jalr	682(ra) # 80000118 <kalloc>
    80000e76:	8aaa                	mv	s5,a0
        if (pa == 0)
    80000e78:	d569                	beqz	a0,80000e42 <madvise+0x8e>
        uint dp = PTE2BLOCKNO(*pte);
    80000e7a:	0009bb83          	ld	s7,0(s3) # 1000 <_entry-0x7ffff000>
    80000e7e:	00abdb93          	srli	s7,s7,0xa
    80000e82:	2b81                	sext.w	s7,s7
        read_page_from_disk(ROOTDEV, pa, dp);                   // 從disk搬回來
    80000e84:	865e                	mv	a2,s7
    80000e86:	85aa                	mv	a1,a0
    80000e88:	4505                	li	a0,1
    80000e8a:	00002097          	auipc	ra,0x2
    80000e8e:	bc6080e7          	jalr	-1082(ra) # 80002a50 <read_page_from_disk>
        *pte = (PA2PTE(pa) | PTE_FLAGS(*pte) | PTE_V) & ~PTE_S; // 將pte的pointer指到physical memory
    80000e92:	00cada93          	srli	s5,s5,0xc
    80000e96:	0aaa                	slli	s5,s5,0xa
    80000e98:	0009b783          	ld	a5,0(s3)
    80000e9c:	1fe7f793          	andi	a5,a5,510
    80000ea0:	0157eab3          	or	s5,a5,s5
    80000ea4:	001aea93          	ori	s5,s5,1
    80000ea8:	0159b023          	sd	s5,0(s3)
        bfree_page(ROOTDEV, dp);
    80000eac:	85de                	mv	a1,s7
    80000eae:	4505                	li	a0,1
    80000eb0:	00003097          	auipc	ra,0x3
    80000eb4:	a68080e7          	jalr	-1432(ra) # 80003918 <bfree_page>
    80000eb8:	bf59                	j	80000e4e <madvise+0x9a>
    end_op();
    80000eba:	00003097          	auipc	ra,0x3
    80000ebe:	d62080e7          	jalr	-670(ra) # 80003c1c <end_op>
    return 0;
    80000ec2:	4501                	li	a0,0
    80000ec4:	bfa1                	j	80000e1c <madvise+0x68>
    begin_op();
    80000ec6:	00003097          	auipc	ra,0x3
    80000eca:	cd6080e7          	jalr	-810(ra) # 80003b9c <begin_op>
    for (uint64 va = begin; va <= last; va += PGSIZE) {
    80000ece:	04996163          	bltu	s2,s1,80000f10 <madvise+0x15c>
    80000ed2:	6985                	lui	s3,0x1
    80000ed4:	a801                	j	80000ee4 <madvise+0x130>
        kfree(pa);
    80000ed6:	fffff097          	auipc	ra,0xfffff
    80000eda:	146080e7          	jalr	326(ra) # 8000001c <kfree>
    for (uint64 va = begin; va <= last; va += PGSIZE) {
    80000ede:	94ce                	add	s1,s1,s3
    80000ee0:	02996863          	bltu	s2,s1,80000f10 <madvise+0x15c>
      pte = walk(pgtbl, va, 0);
    80000ee4:	4601                	li	a2,0
    80000ee6:	85a6                	mv	a1,s1
    80000ee8:	8552                	mv	a0,s4
    80000eea:	fffff097          	auipc	ra,0xfffff
    80000eee:	576080e7          	jalr	1398(ra) # 80000460 <walk>
      if (pte != 0 && (*pte & PTE_V)) {
    80000ef2:	d575                	beqz	a0,80000ede <madvise+0x12a>
    80000ef4:	611c                	ld	a5,0(a0)
    80000ef6:	8b85                	andi	a5,a5,1
    80000ef8:	d3fd                	beqz	a5,80000ede <madvise+0x12a>
        char *pa = (char*) swap_page_from_pte(pte);
    80000efa:	00005097          	auipc	ra,0x5
    80000efe:	e5c080e7          	jalr	-420(ra) # 80005d56 <swap_page_from_pte>
        if (pa == 0) {
    80000f02:	f971                	bnez	a0,80000ed6 <madvise+0x122>
          end_op();
    80000f04:	00003097          	auipc	ra,0x3
    80000f08:	d18080e7          	jalr	-744(ra) # 80003c1c <end_op>
          return -1;
    80000f0c:	557d                	li	a0,-1
    80000f0e:	b739                	j	80000e1c <madvise+0x68>
    end_op();
    80000f10:	00003097          	auipc	ra,0x3
    80000f14:	d0c080e7          	jalr	-756(ra) # 80003c1c <end_op>
    return 0;
    80000f18:	4501                	li	a0,0
    80000f1a:	b709                	j	80000e1c <madvise+0x68>
    begin_op();
    80000f1c:	00003097          	auipc	ra,0x3
    80000f20:	c80080e7          	jalr	-896(ra) # 80003b9c <begin_op>
    for (uint64 va = begin; va <= last; va += PGSIZE){
    80000f24:	02996163          	bltu	s2,s1,80000f46 <madvise+0x192>
    80000f28:	6985                	lui	s3,0x1
      pte = walk(pgtbl, va, 0);
    80000f2a:	4601                	li	a2,0
    80000f2c:	85a6                	mv	a1,s1
    80000f2e:	8552                	mv	a0,s4
    80000f30:	fffff097          	auipc	ra,0xfffff
    80000f34:	530080e7          	jalr	1328(ra) # 80000460 <walk>
      *pte |= PTE_P;
    80000f38:	611c                	ld	a5,0(a0)
    80000f3a:	1007e793          	ori	a5,a5,256
    80000f3e:	e11c                	sd	a5,0(a0)
    for (uint64 va = begin; va <= last; va += PGSIZE){
    80000f40:	94ce                	add	s1,s1,s3
    80000f42:	fe9974e3          	bgeu	s2,s1,80000f2a <madvise+0x176>
    end_op();
    80000f46:	00003097          	auipc	ra,0x3
    80000f4a:	cd6080e7          	jalr	-810(ra) # 80003c1c <end_op>
  return -1;
    80000f4e:	557d                	li	a0,-1
    80000f50:	b5f1                	j	80000e1c <madvise+0x68>
    begin_op();
    80000f52:	00003097          	auipc	ra,0x3
    80000f56:	c4a080e7          	jalr	-950(ra) # 80003b9c <begin_op>
    for (uint64 va = begin; va <= last; va += PGSIZE){
    80000f5a:	02996163          	bltu	s2,s1,80000f7c <madvise+0x1c8>
    80000f5e:	6985                	lui	s3,0x1
      pte = walk(pgtbl, va, 0);
    80000f60:	4601                	li	a2,0
    80000f62:	85a6                	mv	a1,s1
    80000f64:	8552                	mv	a0,s4
    80000f66:	fffff097          	auipc	ra,0xfffff
    80000f6a:	4fa080e7          	jalr	1274(ra) # 80000460 <walk>
      *pte &= ~PTE_P;
    80000f6e:	611c                	ld	a5,0(a0)
    80000f70:	eff7f793          	andi	a5,a5,-257
    80000f74:	e11c                	sd	a5,0(a0)
    for (uint64 va = begin; va <= last; va += PGSIZE){
    80000f76:	94ce                	add	s1,s1,s3
    80000f78:	fe9974e3          	bgeu	s2,s1,80000f60 <madvise+0x1ac>
    end_op();
    80000f7c:	00003097          	auipc	ra,0x3
    80000f80:	ca0080e7          	jalr	-864(ra) # 80003c1c <end_op>
  return -1;
    80000f84:	557d                	li	a0,-1
    80000f86:	bd59                	j	80000e1c <madvise+0x68>
    return -1;
    80000f88:	557d                	li	a0,-1
    80000f8a:	bd49                	j	80000e1c <madvise+0x68>
    80000f8c:	557d                	li	a0,-1
    80000f8e:	b579                	j	80000e1c <madvise+0x68>

0000000080000f90 <cal_dva>:
  printf("------End--------------\n");
}
#endif

uint64 cal_dva(int layer)
{
    80000f90:	1141                	addi	sp,sp,-16
    80000f92:	e422                	sd	s0,8(sp)
    80000f94:	0800                	addi	s0,sp,16
  uint64 rt_val = 0x1000;
  for (int i = 0; i < layer - 1; i++)
    80000f96:	4785                	li	a5,1
    80000f98:	00a7dd63          	bge	a5,a0,80000fb2 <cal_dva+0x22>
    80000f9c:	fff5071b          	addiw	a4,a0,-1
    80000fa0:	4781                	li	a5,0
  uint64 rt_val = 0x1000;
    80000fa2:	6505                	lui	a0,0x1
  {
    rt_val *= 512;
    80000fa4:	0526                	slli	a0,a0,0x9
  for (int i = 0; i < layer - 1; i++)
    80000fa6:	2785                	addiw	a5,a5,1
    80000fa8:	fee79ee3          	bne	a5,a4,80000fa4 <cal_dva+0x14>
  }
  return rt_val;
}
    80000fac:	6422                	ld	s0,8(sp)
    80000fae:	0141                	addi	sp,sp,16
    80000fb0:	8082                	ret
  uint64 rt_val = 0x1000;
    80000fb2:	6505                	lui	a0,0x1
  return rt_val;
    80000fb4:	bfe5                	j	80000fac <cal_dva+0x1c>

0000000080000fb6 <find_last_entry>:

int find_last_entry(pagetable_t now_pagetable)
{
    80000fb6:	1141                	addi	sp,sp,-16
    80000fb8:	e422                	sd	s0,8(sp)
    80000fba:	0800                	addi	s0,sp,16
  for (int i = MAX_Entry - 1; i >= 0; i--)
    80000fbc:	6705                	lui	a4,0x1
    80000fbe:	1761                	addi	a4,a4,-8
    80000fc0:	972a                	add	a4,a4,a0
    80000fc2:	1ff00513          	li	a0,511
    80000fc6:	56fd                	li	a3,-1
  {
    if (now_pagetable[i] & PTE_V)
    80000fc8:	631c                	ld	a5,0(a4)
    80000fca:	8b85                	andi	a5,a5,1
    80000fcc:	e789                	bnez	a5,80000fd6 <find_last_entry+0x20>
  for (int i = MAX_Entry - 1; i >= 0; i--)
    80000fce:	357d                	addiw	a0,a0,-1
    80000fd0:	1761                	addi	a4,a4,-8
    80000fd2:	fed51be3          	bne	a0,a3,80000fc8 <find_last_entry+0x12>
    {
      return i;
    }
  }
  return -1;
}
    80000fd6:	6422                	ld	s0,8(sp)
    80000fd8:	0141                	addi	sp,sp,16
    80000fda:	8082                	ret

0000000080000fdc <print_bone>:

void print_bone(int layer, int last_layer_last, int last_last_layer_last)
{
  if (layer == 3)
    80000fdc:	478d                	li	a5,3
    80000fde:	08f50a63          	beq	a0,a5,80001072 <print_bone+0x96>
{
    80000fe2:	1101                	addi	sp,sp,-32
    80000fe4:	ec06                	sd	ra,24(sp)
    80000fe6:	e822                	sd	s0,16(sp)
    80000fe8:	e426                	sd	s1,8(sp)
    80000fea:	1000                	addi	s0,sp,32
    80000fec:	84ae                	mv	s1,a1
    return;
  if (layer == 2)
    80000fee:	4789                	li	a5,2
    80000ff0:	02f50863          	beq	a0,a5,80001020 <print_bone+0x44>
    else
    {
      printf("|   ");
    }
  }
  if (layer == 1)
    80000ff4:	4785                	li	a5,1
    80000ff6:	02f51e63          	bne	a0,a5,80001032 <print_bone+0x56>
  {
    if (last_last_layer_last)
    80000ffa:	ca31                	beqz	a2,8000104e <print_bone+0x72>
    {
      printf("    ");
    80000ffc:	00007517          	auipc	a0,0x7
    80001000:	18450513          	addi	a0,a0,388 # 80008180 <etext+0x180>
    80001004:	00005097          	auipc	ra,0x5
    80001008:	486080e7          	jalr	1158(ra) # 8000648a <printf>
    }
    else
    {
      printf("|   ");
    }
    if (last_layer_last)
    8000100c:	c8b1                	beqz	s1,80001060 <print_bone+0x84>
    {
      printf("    ");
    8000100e:	00007517          	auipc	a0,0x7
    80001012:	17250513          	addi	a0,a0,370 # 80008180 <etext+0x180>
    80001016:	00005097          	auipc	ra,0x5
    8000101a:	474080e7          	jalr	1140(ra) # 8000648a <printf>
    8000101e:	a811                	j	80001032 <print_bone+0x56>
    if (last_layer_last)
    80001020:	cd91                	beqz	a1,8000103c <print_bone+0x60>
      printf("    ");
    80001022:	00007517          	auipc	a0,0x7
    80001026:	15e50513          	addi	a0,a0,350 # 80008180 <etext+0x180>
    8000102a:	00005097          	auipc	ra,0x5
    8000102e:	460080e7          	jalr	1120(ra) # 8000648a <printf>
    {
      printf("|   ");
    }
  }
  return;
}
    80001032:	60e2                	ld	ra,24(sp)
    80001034:	6442                	ld	s0,16(sp)
    80001036:	64a2                	ld	s1,8(sp)
    80001038:	6105                	addi	sp,sp,32
    8000103a:	8082                	ret
      printf("|   ");
    8000103c:	00007517          	auipc	a0,0x7
    80001040:	14c50513          	addi	a0,a0,332 # 80008188 <etext+0x188>
    80001044:	00005097          	auipc	ra,0x5
    80001048:	446080e7          	jalr	1094(ra) # 8000648a <printf>
    8000104c:	b7dd                	j	80001032 <print_bone+0x56>
      printf("|   ");
    8000104e:	00007517          	auipc	a0,0x7
    80001052:	13a50513          	addi	a0,a0,314 # 80008188 <etext+0x188>
    80001056:	00005097          	auipc	ra,0x5
    8000105a:	434080e7          	jalr	1076(ra) # 8000648a <printf>
    8000105e:	b77d                	j	8000100c <print_bone+0x30>
      printf("|   ");
    80001060:	00007517          	auipc	a0,0x7
    80001064:	12850513          	addi	a0,a0,296 # 80008188 <etext+0x188>
    80001068:	00005097          	auipc	ra,0x5
    8000106c:	422080e7          	jalr	1058(ra) # 8000648a <printf>
    80001070:	b7c9                	j	80001032 <print_bone+0x56>
    80001072:	8082                	ret

0000000080001074 <help_print>:



void help_print(pagetable_t now_pagetable, uint64 va, int layer, int last_layer_last, int last_last_layer_last) // 這層pte裡的pa就是下層的pte
{
    80001074:	7175                	addi	sp,sp,-144
    80001076:	e506                	sd	ra,136(sp)
    80001078:	e122                	sd	s0,128(sp)
    8000107a:	fca6                	sd	s1,120(sp)
    8000107c:	f8ca                	sd	s2,112(sp)
    8000107e:	f4ce                	sd	s3,104(sp)
    80001080:	f0d2                	sd	s4,96(sp)
    80001082:	ecd6                	sd	s5,88(sp)
    80001084:	e8da                	sd	s6,80(sp)
    80001086:	e4de                	sd	s7,72(sp)
    80001088:	e0e2                	sd	s8,64(sp)
    8000108a:	fc66                	sd	s9,56(sp)
    8000108c:	f86a                	sd	s10,48(sp)
    8000108e:	f46e                	sd	s11,40(sp)
    80001090:	0900                	addi	s0,sp,144
    80001092:	89aa                	mv	s3,a0
    80001094:	8dae                	mv	s11,a1
    80001096:	8cb2                	mv	s9,a2
    80001098:	f8d43423          	sd	a3,-120(s0)
    8000109c:	f8e43023          	sd	a4,-128(s0)

  int last_entry = find_last_entry(now_pagetable);
    800010a0:	00000097          	auipc	ra,0x0
    800010a4:	f16080e7          	jalr	-234(ra) # 80000fb6 <find_last_entry>
    800010a8:	f6a43c23          	sd	a0,-136(s0)
    800010ac:	4481                	li	s1,0
      else if (now_entry & PTE_S)
        printf("+-- %d: pte=%p va=%p blockno=%p", i, now_pagetable + i, va + d_va * i, PTE2BLOCKNO(now_entry));
      print_Symbol(now_entry);
      int term = PTE_R | PTE_W | PTE_X;
      if ((now_entry & term) == 0) // not yet reach end
        help_print(pa, va + d_va * i, layer - 1, i == last_entry, last_layer_last);
    800010ae:	fffc879b          	addiw	a5,s9,-1
    800010b2:	f6f43823          	sd	a5,-144(s0)
  for (int i = 0; i < MAX_Entry; i++){
    800010b6:	20000b93          	li	s7,512
    800010ba:	a825                	j	800010f2 <help_print+0x7e>
        printf("+-- %d: pte=%p va=%p pa=%p", i, now_pagetable + i, va + d_va * i, PTE2PA(now_entry));
    800010bc:	034486b3          	mul	a3,s1,s4
    800010c0:	876a                	mv	a4,s10
    800010c2:	96ee                	add	a3,a3,s11
    800010c4:	864e                	mv	a2,s3
    800010c6:	85d6                	mv	a1,s5
    800010c8:	00007517          	auipc	a0,0x7
    800010cc:	0c850513          	addi	a0,a0,200 # 80008190 <etext+0x190>
    800010d0:	00005097          	auipc	ra,0x5
    800010d4:	3ba080e7          	jalr	954(ra) # 8000648a <printf>
      print_Symbol(now_entry);
    800010d8:	854a                	mv	a0,s2
    800010da:	00000097          	auipc	ra,0x0
    800010de:	bf4080e7          	jalr	-1036(ra) # 80000cce <print_Symbol>
      if ((now_entry & term) == 0) // not yet reach end
    800010e2:	00e97913          	andi	s2,s2,14
    800010e6:	06090563          	beqz	s2,80001150 <help_print+0xdc>
  for (int i = 0; i < MAX_Entry; i++){
    800010ea:	0485                	addi	s1,s1,1
    800010ec:	09a1                	addi	s3,s3,8
    800010ee:	09748563          	beq	s1,s7,80001178 <help_print+0x104>
    800010f2:	00048a9b          	sext.w	s5,s1
    uint64 now_entry = now_pagetable[i];
    800010f6:	0009b903          	ld	s2,0(s3) # 1000 <_entry-0x7ffff000>
    if (now_entry & PTE_V || now_entry & PTE_S){
    800010fa:	20197793          	andi	a5,s2,513
    800010fe:	d7f5                	beqz	a5,800010ea <help_print+0x76>
      pagetable_t pa = (pagetable_t)PTE2PA(now_entry); // next pagetable
    80001100:	00a95c13          	srli	s8,s2,0xa
    80001104:	00cc1d13          	slli	s10,s8,0xc
      uint64 d_va = cal_dva(layer);
    80001108:	8566                	mv	a0,s9
    8000110a:	00000097          	auipc	ra,0x0
    8000110e:	e86080e7          	jalr	-378(ra) # 80000f90 <cal_dva>
    80001112:	8a2a                	mv	s4,a0
      print_bone(layer, last_layer_last, last_last_layer_last);
    80001114:	f8043603          	ld	a2,-128(s0)
    80001118:	f8843583          	ld	a1,-120(s0)
    8000111c:	8566                	mv	a0,s9
    8000111e:	00000097          	auipc	ra,0x0
    80001122:	ebe080e7          	jalr	-322(ra) # 80000fdc <print_bone>
      if (now_entry & PTE_V)
    80001126:	00197793          	andi	a5,s2,1
    8000112a:	fbc9                	bnez	a5,800010bc <help_print+0x48>
      else if (now_entry & PTE_S)
    8000112c:	20097793          	andi	a5,s2,512
    80001130:	d7c5                	beqz	a5,800010d8 <help_print+0x64>
        printf("+-- %d: pte=%p va=%p blockno=%p", i, now_pagetable + i, va + d_va * i, PTE2BLOCKNO(now_entry));
    80001132:	034486b3          	mul	a3,s1,s4
    80001136:	8762                	mv	a4,s8
    80001138:	96ee                	add	a3,a3,s11
    8000113a:	864e                	mv	a2,s3
    8000113c:	85d6                	mv	a1,s5
    8000113e:	00007517          	auipc	a0,0x7
    80001142:	07250513          	addi	a0,a0,114 # 800081b0 <etext+0x1b0>
    80001146:	00005097          	auipc	ra,0x5
    8000114a:	344080e7          	jalr	836(ra) # 8000648a <printf>
    8000114e:	b769                	j	800010d8 <help_print+0x64>
        help_print(pa, va + d_va * i, layer - 1, i == last_entry, last_layer_last);
    80001150:	0004869b          	sext.w	a3,s1
    80001154:	f7843783          	ld	a5,-136(s0)
    80001158:	8e9d                	sub	a3,a3,a5
    8000115a:	034485b3          	mul	a1,s1,s4
    8000115e:	f8843703          	ld	a4,-120(s0)
    80001162:	0016b693          	seqz	a3,a3
    80001166:	f7043603          	ld	a2,-144(s0)
    8000116a:	95ee                	add	a1,a1,s11
    8000116c:	856a                	mv	a0,s10
    8000116e:	00000097          	auipc	ra,0x0
    80001172:	f06080e7          	jalr	-250(ra) # 80001074 <help_print>
    80001176:	bf95                	j	800010ea <help_print+0x76>
    }
  }
}
    80001178:	60aa                	ld	ra,136(sp)
    8000117a:	640a                	ld	s0,128(sp)
    8000117c:	74e6                	ld	s1,120(sp)
    8000117e:	7946                	ld	s2,112(sp)
    80001180:	79a6                	ld	s3,104(sp)
    80001182:	7a06                	ld	s4,96(sp)
    80001184:	6ae6                	ld	s5,88(sp)
    80001186:	6b46                	ld	s6,80(sp)
    80001188:	6ba6                	ld	s7,72(sp)
    8000118a:	6c06                	ld	s8,64(sp)
    8000118c:	7ce2                	ld	s9,56(sp)
    8000118e:	7d42                	ld	s10,48(sp)
    80001190:	7da2                	ld	s11,40(sp)
    80001192:	6149                	addi	sp,sp,144
    80001194:	8082                	ret

0000000080001196 <vmprint>:

/* NTU OS 2024 */
/* Print multi layer page table. */
void vmprint(pagetable_t pagetable)
{
    80001196:	1101                	addi	sp,sp,-32
    80001198:	ec06                	sd	ra,24(sp)
    8000119a:	e822                	sd	s0,16(sp)
    8000119c:	e426                	sd	s1,8(sp)
    8000119e:	1000                	addi	s0,sp,32
    800011a0:	84aa                	mv	s1,a0
  /* TODO */
  printf("page table %p\n", pagetable);
    800011a2:	85aa                	mv	a1,a0
    800011a4:	00007517          	auipc	a0,0x7
    800011a8:	02c50513          	addi	a0,a0,44 # 800081d0 <etext+0x1d0>
    800011ac:	00005097          	auipc	ra,0x5
    800011b0:	2de080e7          	jalr	734(ra) # 8000648a <printf>
  help_print(pagetable, 0, 3, 0, 0);
    800011b4:	4701                	li	a4,0
    800011b6:	4681                	li	a3,0
    800011b8:	460d                	li	a2,3
    800011ba:	4581                	li	a1,0
    800011bc:	8526                	mv	a0,s1
    800011be:	00000097          	auipc	ra,0x0
    800011c2:	eb6080e7          	jalr	-330(ra) # 80001074 <help_print>
  // panic("not implemented yet\n");
}
    800011c6:	60e2                	ld	ra,24(sp)
    800011c8:	6442                	ld	s0,16(sp)
    800011ca:	64a2                	ld	s1,8(sp)
    800011cc:	6105                	addi	sp,sp,32
    800011ce:	8082                	ret

00000000800011d0 <proc_mapstacks>:

// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl) {
    800011d0:	7139                	addi	sp,sp,-64
    800011d2:	fc06                	sd	ra,56(sp)
    800011d4:	f822                	sd	s0,48(sp)
    800011d6:	f426                	sd	s1,40(sp)
    800011d8:	f04a                	sd	s2,32(sp)
    800011da:	ec4e                	sd	s3,24(sp)
    800011dc:	e852                	sd	s4,16(sp)
    800011de:	e456                	sd	s5,8(sp)
    800011e0:	e05a                	sd	s6,0(sp)
    800011e2:	0080                	addi	s0,sp,64
    800011e4:	89aa                	mv	s3,a0
  struct proc *p;
  for(p = proc; p < &proc[NPROC]; p++) {
    800011e6:	00008497          	auipc	s1,0x8
    800011ea:	29a48493          	addi	s1,s1,666 # 80009480 <proc>
    char *pa = kalloc();
    if(pa == 0)
      panic("kalloc");
    uint64 va = KSTACK((int) (p - proc));
    800011ee:	8b26                	mv	s6,s1
    800011f0:	00007a97          	auipc	s5,0x7
    800011f4:	e10a8a93          	addi	s5,s5,-496 # 80008000 <etext>
    800011f8:	01000937          	lui	s2,0x1000
    800011fc:	197d                	addi	s2,s2,-1
    800011fe:	093a                	slli	s2,s2,0xe
  for(p = proc; p < &proc[NPROC]; p++) {
    80001200:	0000ea17          	auipc	s4,0xe
    80001204:	c80a0a13          	addi	s4,s4,-896 # 8000ee80 <tickslock>
    char *pa = kalloc();
    80001208:	fffff097          	auipc	ra,0xfffff
    8000120c:	f10080e7          	jalr	-240(ra) # 80000118 <kalloc>
    80001210:	862a                	mv	a2,a0
    if(pa == 0)
    80001212:	c129                	beqz	a0,80001254 <proc_mapstacks+0x84>
    uint64 va = KSTACK((int) (p - proc));
    80001214:	416485b3          	sub	a1,s1,s6
    80001218:	858d                	srai	a1,a1,0x3
    8000121a:	000ab783          	ld	a5,0(s5)
    8000121e:	02f585b3          	mul	a1,a1,a5
    80001222:	00d5959b          	slliw	a1,a1,0xd
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80001226:	4719                	li	a4,6
    80001228:	6685                	lui	a3,0x1
    8000122a:	40b905b3          	sub	a1,s2,a1
    8000122e:	854e                	mv	a0,s3
    80001230:	fffff097          	auipc	ra,0xfffff
    80001234:	3b8080e7          	jalr	952(ra) # 800005e8 <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001238:	16848493          	addi	s1,s1,360
    8000123c:	fd4496e3          	bne	s1,s4,80001208 <proc_mapstacks+0x38>
  }
}
    80001240:	70e2                	ld	ra,56(sp)
    80001242:	7442                	ld	s0,48(sp)
    80001244:	74a2                	ld	s1,40(sp)
    80001246:	7902                	ld	s2,32(sp)
    80001248:	69e2                	ld	s3,24(sp)
    8000124a:	6a42                	ld	s4,16(sp)
    8000124c:	6aa2                	ld	s5,8(sp)
    8000124e:	6b02                	ld	s6,0(sp)
    80001250:	6121                	addi	sp,sp,64
    80001252:	8082                	ret
      panic("kalloc");
    80001254:	00007517          	auipc	a0,0x7
    80001258:	f8c50513          	addi	a0,a0,-116 # 800081e0 <etext+0x1e0>
    8000125c:	00005097          	auipc	ra,0x5
    80001260:	1e4080e7          	jalr	484(ra) # 80006440 <panic>

0000000080001264 <procinit>:

// initialize the proc table at boot time.
void
procinit(void)
{
    80001264:	7139                	addi	sp,sp,-64
    80001266:	fc06                	sd	ra,56(sp)
    80001268:	f822                	sd	s0,48(sp)
    8000126a:	f426                	sd	s1,40(sp)
    8000126c:	f04a                	sd	s2,32(sp)
    8000126e:	ec4e                	sd	s3,24(sp)
    80001270:	e852                	sd	s4,16(sp)
    80001272:	e456                	sd	s5,8(sp)
    80001274:	e05a                	sd	s6,0(sp)
    80001276:	0080                	addi	s0,sp,64
  struct proc *p;
  initlock(&pid_lock, "nextpid");
    80001278:	00007597          	auipc	a1,0x7
    8000127c:	f7058593          	addi	a1,a1,-144 # 800081e8 <etext+0x1e8>
    80001280:	00008517          	auipc	a0,0x8
    80001284:	dd050513          	addi	a0,a0,-560 # 80009050 <pid_lock>
    80001288:	00005097          	auipc	ra,0x5
    8000128c:	672080e7          	jalr	1650(ra) # 800068fa <initlock>
  initlock(&wait_lock, "wait_lock");
    80001290:	00007597          	auipc	a1,0x7
    80001294:	f6058593          	addi	a1,a1,-160 # 800081f0 <etext+0x1f0>
    80001298:	00008517          	auipc	a0,0x8
    8000129c:	dd050513          	addi	a0,a0,-560 # 80009068 <wait_lock>
    800012a0:	00005097          	auipc	ra,0x5
    800012a4:	65a080e7          	jalr	1626(ra) # 800068fa <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    800012a8:	00008497          	auipc	s1,0x8
    800012ac:	1d848493          	addi	s1,s1,472 # 80009480 <proc>
      initlock(&p->lock, "proc");
    800012b0:	00007b17          	auipc	s6,0x7
    800012b4:	f50b0b13          	addi	s6,s6,-176 # 80008200 <etext+0x200>
      p->kstack = KSTACK((int) (p - proc));
    800012b8:	8aa6                	mv	s5,s1
    800012ba:	00007a17          	auipc	s4,0x7
    800012be:	d46a0a13          	addi	s4,s4,-698 # 80008000 <etext>
    800012c2:	01000937          	lui	s2,0x1000
    800012c6:	197d                	addi	s2,s2,-1
    800012c8:	093a                	slli	s2,s2,0xe
  for(p = proc; p < &proc[NPROC]; p++) {
    800012ca:	0000e997          	auipc	s3,0xe
    800012ce:	bb698993          	addi	s3,s3,-1098 # 8000ee80 <tickslock>
      initlock(&p->lock, "proc");
    800012d2:	85da                	mv	a1,s6
    800012d4:	8526                	mv	a0,s1
    800012d6:	00005097          	auipc	ra,0x5
    800012da:	624080e7          	jalr	1572(ra) # 800068fa <initlock>
      p->kstack = KSTACK((int) (p - proc));
    800012de:	415487b3          	sub	a5,s1,s5
    800012e2:	878d                	srai	a5,a5,0x3
    800012e4:	000a3703          	ld	a4,0(s4)
    800012e8:	02e787b3          	mul	a5,a5,a4
    800012ec:	00d7979b          	slliw	a5,a5,0xd
    800012f0:	40f907b3          	sub	a5,s2,a5
    800012f4:	e0bc                	sd	a5,64(s1)
  for(p = proc; p < &proc[NPROC]; p++) {
    800012f6:	16848493          	addi	s1,s1,360
    800012fa:	fd349ce3          	bne	s1,s3,800012d2 <procinit+0x6e>
  }
}
    800012fe:	70e2                	ld	ra,56(sp)
    80001300:	7442                	ld	s0,48(sp)
    80001302:	74a2                	ld	s1,40(sp)
    80001304:	7902                	ld	s2,32(sp)
    80001306:	69e2                	ld	s3,24(sp)
    80001308:	6a42                	ld	s4,16(sp)
    8000130a:	6aa2                	ld	s5,8(sp)
    8000130c:	6b02                	ld	s6,0(sp)
    8000130e:	6121                	addi	sp,sp,64
    80001310:	8082                	ret

0000000080001312 <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    80001312:	1141                	addi	sp,sp,-16
    80001314:	e422                	sd	s0,8(sp)
    80001316:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    80001318:	8512                	mv	a0,tp
  int id = r_tp();
  return id;
}
    8000131a:	2501                	sext.w	a0,a0
    8000131c:	6422                	ld	s0,8(sp)
    8000131e:	0141                	addi	sp,sp,16
    80001320:	8082                	ret

0000000080001322 <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void) {
    80001322:	1141                	addi	sp,sp,-16
    80001324:	e422                	sd	s0,8(sp)
    80001326:	0800                	addi	s0,sp,16
    80001328:	8792                	mv	a5,tp
  int id = cpuid();
  struct cpu *c = &cpus[id];
    8000132a:	2781                	sext.w	a5,a5
    8000132c:	079e                	slli	a5,a5,0x7
  return c;
}
    8000132e:	00008517          	auipc	a0,0x8
    80001332:	d5250513          	addi	a0,a0,-686 # 80009080 <cpus>
    80001336:	953e                	add	a0,a0,a5
    80001338:	6422                	ld	s0,8(sp)
    8000133a:	0141                	addi	sp,sp,16
    8000133c:	8082                	ret

000000008000133e <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void) {
    8000133e:	1101                	addi	sp,sp,-32
    80001340:	ec06                	sd	ra,24(sp)
    80001342:	e822                	sd	s0,16(sp)
    80001344:	e426                	sd	s1,8(sp)
    80001346:	1000                	addi	s0,sp,32
  push_off();
    80001348:	00005097          	auipc	ra,0x5
    8000134c:	5f6080e7          	jalr	1526(ra) # 8000693e <push_off>
    80001350:	8792                	mv	a5,tp
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
    80001352:	2781                	sext.w	a5,a5
    80001354:	079e                	slli	a5,a5,0x7
    80001356:	00008717          	auipc	a4,0x8
    8000135a:	cfa70713          	addi	a4,a4,-774 # 80009050 <pid_lock>
    8000135e:	97ba                	add	a5,a5,a4
    80001360:	7b84                	ld	s1,48(a5)
  pop_off();
    80001362:	00005097          	auipc	ra,0x5
    80001366:	67c080e7          	jalr	1660(ra) # 800069de <pop_off>
  return p;
}
    8000136a:	8526                	mv	a0,s1
    8000136c:	60e2                	ld	ra,24(sp)
    8000136e:	6442                	ld	s0,16(sp)
    80001370:	64a2                	ld	s1,8(sp)
    80001372:	6105                	addi	sp,sp,32
    80001374:	8082                	ret

0000000080001376 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    80001376:	1141                	addi	sp,sp,-16
    80001378:	e406                	sd	ra,8(sp)
    8000137a:	e022                	sd	s0,0(sp)
    8000137c:	0800                	addi	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    8000137e:	00000097          	auipc	ra,0x0
    80001382:	fc0080e7          	jalr	-64(ra) # 8000133e <myproc>
    80001386:	00005097          	auipc	ra,0x5
    8000138a:	6b8080e7          	jalr	1720(ra) # 80006a3e <release>

  if (first) {
    8000138e:	00007797          	auipc	a5,0x7
    80001392:	6027a783          	lw	a5,1538(a5) # 80008990 <first.1776>
    80001396:	eb89                	bnez	a5,800013a8 <forkret+0x32>
    // be run from main().
    first = 0;
    fsinit(ROOTDEV);
  }

  usertrapret();
    80001398:	00001097          	auipc	ra,0x1
    8000139c:	c0a080e7          	jalr	-1014(ra) # 80001fa2 <usertrapret>
}
    800013a0:	60a2                	ld	ra,8(sp)
    800013a2:	6402                	ld	s0,0(sp)
    800013a4:	0141                	addi	sp,sp,16
    800013a6:	8082                	ret
    first = 0;
    800013a8:	00007797          	auipc	a5,0x7
    800013ac:	5e07a423          	sw	zero,1512(a5) # 80008990 <first.1776>
    fsinit(ROOTDEV);
    800013b0:	4505                	li	a0,1
    800013b2:	00002097          	auipc	ra,0x2
    800013b6:	a2a080e7          	jalr	-1494(ra) # 80002ddc <fsinit>
    800013ba:	bff9                	j	80001398 <forkret+0x22>

00000000800013bc <allocpid>:
allocpid() {
    800013bc:	1101                	addi	sp,sp,-32
    800013be:	ec06                	sd	ra,24(sp)
    800013c0:	e822                	sd	s0,16(sp)
    800013c2:	e426                	sd	s1,8(sp)
    800013c4:	e04a                	sd	s2,0(sp)
    800013c6:	1000                	addi	s0,sp,32
  acquire(&pid_lock);
    800013c8:	00008917          	auipc	s2,0x8
    800013cc:	c8890913          	addi	s2,s2,-888 # 80009050 <pid_lock>
    800013d0:	854a                	mv	a0,s2
    800013d2:	00005097          	auipc	ra,0x5
    800013d6:	5b8080e7          	jalr	1464(ra) # 8000698a <acquire>
  pid = nextpid;
    800013da:	00007797          	auipc	a5,0x7
    800013de:	5ba78793          	addi	a5,a5,1466 # 80008994 <nextpid>
    800013e2:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    800013e4:	0014871b          	addiw	a4,s1,1
    800013e8:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    800013ea:	854a                	mv	a0,s2
    800013ec:	00005097          	auipc	ra,0x5
    800013f0:	652080e7          	jalr	1618(ra) # 80006a3e <release>
}
    800013f4:	8526                	mv	a0,s1
    800013f6:	60e2                	ld	ra,24(sp)
    800013f8:	6442                	ld	s0,16(sp)
    800013fa:	64a2                	ld	s1,8(sp)
    800013fc:	6902                	ld	s2,0(sp)
    800013fe:	6105                	addi	sp,sp,32
    80001400:	8082                	ret

0000000080001402 <proc_pagetable>:
{
    80001402:	1101                	addi	sp,sp,-32
    80001404:	ec06                	sd	ra,24(sp)
    80001406:	e822                	sd	s0,16(sp)
    80001408:	e426                	sd	s1,8(sp)
    8000140a:	e04a                	sd	s2,0(sp)
    8000140c:	1000                	addi	s0,sp,32
    8000140e:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    80001410:	fffff097          	auipc	ra,0xfffff
    80001414:	3ba080e7          	jalr	954(ra) # 800007ca <uvmcreate>
    80001418:	84aa                	mv	s1,a0
  if(pagetable == 0)
    8000141a:	c121                	beqz	a0,8000145a <proc_pagetable+0x58>
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    8000141c:	4729                	li	a4,10
    8000141e:	00006697          	auipc	a3,0x6
    80001422:	be268693          	addi	a3,a3,-1054 # 80007000 <_trampoline>
    80001426:	6605                	lui	a2,0x1
    80001428:	040005b7          	lui	a1,0x4000
    8000142c:	15fd                	addi	a1,a1,-1
    8000142e:	05b2                	slli	a1,a1,0xc
    80001430:	fffff097          	auipc	ra,0xfffff
    80001434:	118080e7          	jalr	280(ra) # 80000548 <mappages>
    80001438:	02054863          	bltz	a0,80001468 <proc_pagetable+0x66>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    8000143c:	4719                	li	a4,6
    8000143e:	05893683          	ld	a3,88(s2)
    80001442:	6605                	lui	a2,0x1
    80001444:	020005b7          	lui	a1,0x2000
    80001448:	15fd                	addi	a1,a1,-1
    8000144a:	05b6                	slli	a1,a1,0xd
    8000144c:	8526                	mv	a0,s1
    8000144e:	fffff097          	auipc	ra,0xfffff
    80001452:	0fa080e7          	jalr	250(ra) # 80000548 <mappages>
    80001456:	02054163          	bltz	a0,80001478 <proc_pagetable+0x76>
}
    8000145a:	8526                	mv	a0,s1
    8000145c:	60e2                	ld	ra,24(sp)
    8000145e:	6442                	ld	s0,16(sp)
    80001460:	64a2                	ld	s1,8(sp)
    80001462:	6902                	ld	s2,0(sp)
    80001464:	6105                	addi	sp,sp,32
    80001466:	8082                	ret
    uvmfree(pagetable, 0);
    80001468:	4581                	li	a1,0
    8000146a:	8526                	mv	a0,s1
    8000146c:	fffff097          	auipc	ra,0xfffff
    80001470:	55a080e7          	jalr	1370(ra) # 800009c6 <uvmfree>
    return 0;
    80001474:	4481                	li	s1,0
    80001476:	b7d5                	j	8000145a <proc_pagetable+0x58>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001478:	4681                	li	a3,0
    8000147a:	4605                	li	a2,1
    8000147c:	040005b7          	lui	a1,0x4000
    80001480:	15fd                	addi	a1,a1,-1
    80001482:	05b2                	slli	a1,a1,0xc
    80001484:	8526                	mv	a0,s1
    80001486:	fffff097          	auipc	ra,0xfffff
    8000148a:	288080e7          	jalr	648(ra) # 8000070e <uvmunmap>
    uvmfree(pagetable, 0);
    8000148e:	4581                	li	a1,0
    80001490:	8526                	mv	a0,s1
    80001492:	fffff097          	auipc	ra,0xfffff
    80001496:	534080e7          	jalr	1332(ra) # 800009c6 <uvmfree>
    return 0;
    8000149a:	4481                	li	s1,0
    8000149c:	bf7d                	j	8000145a <proc_pagetable+0x58>

000000008000149e <proc_freepagetable>:
{
    8000149e:	1101                	addi	sp,sp,-32
    800014a0:	ec06                	sd	ra,24(sp)
    800014a2:	e822                	sd	s0,16(sp)
    800014a4:	e426                	sd	s1,8(sp)
    800014a6:	e04a                	sd	s2,0(sp)
    800014a8:	1000                	addi	s0,sp,32
    800014aa:	84aa                	mv	s1,a0
    800014ac:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    800014ae:	4681                	li	a3,0
    800014b0:	4605                	li	a2,1
    800014b2:	040005b7          	lui	a1,0x4000
    800014b6:	15fd                	addi	a1,a1,-1
    800014b8:	05b2                	slli	a1,a1,0xc
    800014ba:	fffff097          	auipc	ra,0xfffff
    800014be:	254080e7          	jalr	596(ra) # 8000070e <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    800014c2:	4681                	li	a3,0
    800014c4:	4605                	li	a2,1
    800014c6:	020005b7          	lui	a1,0x2000
    800014ca:	15fd                	addi	a1,a1,-1
    800014cc:	05b6                	slli	a1,a1,0xd
    800014ce:	8526                	mv	a0,s1
    800014d0:	fffff097          	auipc	ra,0xfffff
    800014d4:	23e080e7          	jalr	574(ra) # 8000070e <uvmunmap>
  uvmfree(pagetable, sz);
    800014d8:	85ca                	mv	a1,s2
    800014da:	8526                	mv	a0,s1
    800014dc:	fffff097          	auipc	ra,0xfffff
    800014e0:	4ea080e7          	jalr	1258(ra) # 800009c6 <uvmfree>
}
    800014e4:	60e2                	ld	ra,24(sp)
    800014e6:	6442                	ld	s0,16(sp)
    800014e8:	64a2                	ld	s1,8(sp)
    800014ea:	6902                	ld	s2,0(sp)
    800014ec:	6105                	addi	sp,sp,32
    800014ee:	8082                	ret

00000000800014f0 <freeproc>:
{
    800014f0:	1101                	addi	sp,sp,-32
    800014f2:	ec06                	sd	ra,24(sp)
    800014f4:	e822                	sd	s0,16(sp)
    800014f6:	e426                	sd	s1,8(sp)
    800014f8:	1000                	addi	s0,sp,32
    800014fa:	84aa                	mv	s1,a0
  if(p->trapframe)
    800014fc:	6d28                	ld	a0,88(a0)
    800014fe:	c509                	beqz	a0,80001508 <freeproc+0x18>
    kfree((void*)p->trapframe);
    80001500:	fffff097          	auipc	ra,0xfffff
    80001504:	b1c080e7          	jalr	-1252(ra) # 8000001c <kfree>
  p->trapframe = 0;
    80001508:	0404bc23          	sd	zero,88(s1)
  if(p->pagetable)
    8000150c:	68a8                	ld	a0,80(s1)
    8000150e:	c511                	beqz	a0,8000151a <freeproc+0x2a>
    proc_freepagetable(p->pagetable, p->sz);
    80001510:	64ac                	ld	a1,72(s1)
    80001512:	00000097          	auipc	ra,0x0
    80001516:	f8c080e7          	jalr	-116(ra) # 8000149e <proc_freepagetable>
  p->pagetable = 0;
    8000151a:	0404b823          	sd	zero,80(s1)
  p->sz = 0;
    8000151e:	0404b423          	sd	zero,72(s1)
  p->pid = 0;
    80001522:	0204a823          	sw	zero,48(s1)
  p->parent = 0;
    80001526:	0204bc23          	sd	zero,56(s1)
  p->name[0] = 0;
    8000152a:	14048c23          	sb	zero,344(s1)
  p->chan = 0;
    8000152e:	0204b023          	sd	zero,32(s1)
  p->killed = 0;
    80001532:	0204a423          	sw	zero,40(s1)
  p->xstate = 0;
    80001536:	0204a623          	sw	zero,44(s1)
  p->state = UNUSED;
    8000153a:	0004ac23          	sw	zero,24(s1)
}
    8000153e:	60e2                	ld	ra,24(sp)
    80001540:	6442                	ld	s0,16(sp)
    80001542:	64a2                	ld	s1,8(sp)
    80001544:	6105                	addi	sp,sp,32
    80001546:	8082                	ret

0000000080001548 <allocproc>:
{
    80001548:	1101                	addi	sp,sp,-32
    8000154a:	ec06                	sd	ra,24(sp)
    8000154c:	e822                	sd	s0,16(sp)
    8000154e:	e426                	sd	s1,8(sp)
    80001550:	e04a                	sd	s2,0(sp)
    80001552:	1000                	addi	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    80001554:	00008497          	auipc	s1,0x8
    80001558:	f2c48493          	addi	s1,s1,-212 # 80009480 <proc>
    8000155c:	0000e917          	auipc	s2,0xe
    80001560:	92490913          	addi	s2,s2,-1756 # 8000ee80 <tickslock>
    acquire(&p->lock);
    80001564:	8526                	mv	a0,s1
    80001566:	00005097          	auipc	ra,0x5
    8000156a:	424080e7          	jalr	1060(ra) # 8000698a <acquire>
    if(p->state == UNUSED) {
    8000156e:	4c9c                	lw	a5,24(s1)
    80001570:	cf81                	beqz	a5,80001588 <allocproc+0x40>
      release(&p->lock);
    80001572:	8526                	mv	a0,s1
    80001574:	00005097          	auipc	ra,0x5
    80001578:	4ca080e7          	jalr	1226(ra) # 80006a3e <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    8000157c:	16848493          	addi	s1,s1,360
    80001580:	ff2492e3          	bne	s1,s2,80001564 <allocproc+0x1c>
  return 0;
    80001584:	4481                	li	s1,0
    80001586:	a889                	j	800015d8 <allocproc+0x90>
  p->pid = allocpid();
    80001588:	00000097          	auipc	ra,0x0
    8000158c:	e34080e7          	jalr	-460(ra) # 800013bc <allocpid>
    80001590:	d888                	sw	a0,48(s1)
  p->state = USED;
    80001592:	4785                	li	a5,1
    80001594:	cc9c                	sw	a5,24(s1)
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    80001596:	fffff097          	auipc	ra,0xfffff
    8000159a:	b82080e7          	jalr	-1150(ra) # 80000118 <kalloc>
    8000159e:	892a                	mv	s2,a0
    800015a0:	eca8                	sd	a0,88(s1)
    800015a2:	c131                	beqz	a0,800015e6 <allocproc+0x9e>
  p->pagetable = proc_pagetable(p);
    800015a4:	8526                	mv	a0,s1
    800015a6:	00000097          	auipc	ra,0x0
    800015aa:	e5c080e7          	jalr	-420(ra) # 80001402 <proc_pagetable>
    800015ae:	892a                	mv	s2,a0
    800015b0:	e8a8                	sd	a0,80(s1)
  if(p->pagetable == 0){
    800015b2:	c531                	beqz	a0,800015fe <allocproc+0xb6>
  memset(&p->context, 0, sizeof(p->context));
    800015b4:	07000613          	li	a2,112
    800015b8:	4581                	li	a1,0
    800015ba:	06048513          	addi	a0,s1,96
    800015be:	fffff097          	auipc	ra,0xfffff
    800015c2:	bba080e7          	jalr	-1094(ra) # 80000178 <memset>
  p->context.ra = (uint64)forkret;
    800015c6:	00000797          	auipc	a5,0x0
    800015ca:	db078793          	addi	a5,a5,-592 # 80001376 <forkret>
    800015ce:	f0bc                	sd	a5,96(s1)
  p->context.sp = p->kstack + PGSIZE;
    800015d0:	60bc                	ld	a5,64(s1)
    800015d2:	6705                	lui	a4,0x1
    800015d4:	97ba                	add	a5,a5,a4
    800015d6:	f4bc                	sd	a5,104(s1)
}
    800015d8:	8526                	mv	a0,s1
    800015da:	60e2                	ld	ra,24(sp)
    800015dc:	6442                	ld	s0,16(sp)
    800015de:	64a2                	ld	s1,8(sp)
    800015e0:	6902                	ld	s2,0(sp)
    800015e2:	6105                	addi	sp,sp,32
    800015e4:	8082                	ret
    freeproc(p);
    800015e6:	8526                	mv	a0,s1
    800015e8:	00000097          	auipc	ra,0x0
    800015ec:	f08080e7          	jalr	-248(ra) # 800014f0 <freeproc>
    release(&p->lock);
    800015f0:	8526                	mv	a0,s1
    800015f2:	00005097          	auipc	ra,0x5
    800015f6:	44c080e7          	jalr	1100(ra) # 80006a3e <release>
    return 0;
    800015fa:	84ca                	mv	s1,s2
    800015fc:	bff1                	j	800015d8 <allocproc+0x90>
    freeproc(p);
    800015fe:	8526                	mv	a0,s1
    80001600:	00000097          	auipc	ra,0x0
    80001604:	ef0080e7          	jalr	-272(ra) # 800014f0 <freeproc>
    release(&p->lock);
    80001608:	8526                	mv	a0,s1
    8000160a:	00005097          	auipc	ra,0x5
    8000160e:	434080e7          	jalr	1076(ra) # 80006a3e <release>
    return 0;
    80001612:	84ca                	mv	s1,s2
    80001614:	b7d1                	j	800015d8 <allocproc+0x90>

0000000080001616 <userinit>:
{
    80001616:	1101                	addi	sp,sp,-32
    80001618:	ec06                	sd	ra,24(sp)
    8000161a:	e822                	sd	s0,16(sp)
    8000161c:	e426                	sd	s1,8(sp)
    8000161e:	1000                	addi	s0,sp,32
  p = allocproc();
    80001620:	00000097          	auipc	ra,0x0
    80001624:	f28080e7          	jalr	-216(ra) # 80001548 <allocproc>
    80001628:	84aa                	mv	s1,a0
  initproc = p;
    8000162a:	00008797          	auipc	a5,0x8
    8000162e:	9ea7b323          	sd	a0,-1562(a5) # 80009010 <initproc>
  uvminit(p->pagetable, initcode, sizeof(initcode));
    80001632:	03400613          	li	a2,52
    80001636:	00007597          	auipc	a1,0x7
    8000163a:	36a58593          	addi	a1,a1,874 # 800089a0 <initcode>
    8000163e:	6928                	ld	a0,80(a0)
    80001640:	fffff097          	auipc	ra,0xfffff
    80001644:	1b8080e7          	jalr	440(ra) # 800007f8 <uvminit>
  p->sz = PGSIZE;
    80001648:	6785                	lui	a5,0x1
    8000164a:	e4bc                	sd	a5,72(s1)
  p->trapframe->epc = 0;      // user program counter
    8000164c:	6cb8                	ld	a4,88(s1)
    8000164e:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
  p->trapframe->sp = PGSIZE;  // user stack pointer
    80001652:	6cb8                	ld	a4,88(s1)
    80001654:	fb1c                	sd	a5,48(a4)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    80001656:	4641                	li	a2,16
    80001658:	00007597          	auipc	a1,0x7
    8000165c:	bb058593          	addi	a1,a1,-1104 # 80008208 <etext+0x208>
    80001660:	15848513          	addi	a0,s1,344
    80001664:	fffff097          	auipc	ra,0xfffff
    80001668:	c66080e7          	jalr	-922(ra) # 800002ca <safestrcpy>
  p->cwd = namei("/");
    8000166c:	00007517          	auipc	a0,0x7
    80001670:	bac50513          	addi	a0,a0,-1108 # 80008218 <etext+0x218>
    80001674:	00002097          	auipc	ra,0x2
    80001678:	17a080e7          	jalr	378(ra) # 800037ee <namei>
    8000167c:	14a4b823          	sd	a0,336(s1)
  p->state = RUNNABLE;
    80001680:	478d                	li	a5,3
    80001682:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    80001684:	8526                	mv	a0,s1
    80001686:	00005097          	auipc	ra,0x5
    8000168a:	3b8080e7          	jalr	952(ra) # 80006a3e <release>
}
    8000168e:	60e2                	ld	ra,24(sp)
    80001690:	6442                	ld	s0,16(sp)
    80001692:	64a2                	ld	s1,8(sp)
    80001694:	6105                	addi	sp,sp,32
    80001696:	8082                	ret

0000000080001698 <growproc>:
{
    80001698:	1101                	addi	sp,sp,-32
    8000169a:	ec06                	sd	ra,24(sp)
    8000169c:	e822                	sd	s0,16(sp)
    8000169e:	e426                	sd	s1,8(sp)
    800016a0:	e04a                	sd	s2,0(sp)
    800016a2:	1000                	addi	s0,sp,32
    800016a4:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    800016a6:	00000097          	auipc	ra,0x0
    800016aa:	c98080e7          	jalr	-872(ra) # 8000133e <myproc>
    800016ae:	892a                	mv	s2,a0
  sz = p->sz;
    800016b0:	652c                	ld	a1,72(a0)
    800016b2:	0005861b          	sext.w	a2,a1
  if(n > 0){
    800016b6:	00904f63          	bgtz	s1,800016d4 <growproc+0x3c>
  } else if(n < 0){
    800016ba:	0204cc63          	bltz	s1,800016f2 <growproc+0x5a>
  p->sz = sz;
    800016be:	1602                	slli	a2,a2,0x20
    800016c0:	9201                	srli	a2,a2,0x20
    800016c2:	04c93423          	sd	a2,72(s2)
  return 0;
    800016c6:	4501                	li	a0,0
}
    800016c8:	60e2                	ld	ra,24(sp)
    800016ca:	6442                	ld	s0,16(sp)
    800016cc:	64a2                	ld	s1,8(sp)
    800016ce:	6902                	ld	s2,0(sp)
    800016d0:	6105                	addi	sp,sp,32
    800016d2:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n)) == 0) {
    800016d4:	9e25                	addw	a2,a2,s1
    800016d6:	1602                	slli	a2,a2,0x20
    800016d8:	9201                	srli	a2,a2,0x20
    800016da:	1582                	slli	a1,a1,0x20
    800016dc:	9181                	srli	a1,a1,0x20
    800016de:	6928                	ld	a0,80(a0)
    800016e0:	fffff097          	auipc	ra,0xfffff
    800016e4:	1d2080e7          	jalr	466(ra) # 800008b2 <uvmalloc>
    800016e8:	0005061b          	sext.w	a2,a0
    800016ec:	fa69                	bnez	a2,800016be <growproc+0x26>
      return -1;
    800016ee:	557d                	li	a0,-1
    800016f0:	bfe1                	j	800016c8 <growproc+0x30>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    800016f2:	9e25                	addw	a2,a2,s1
    800016f4:	1602                	slli	a2,a2,0x20
    800016f6:	9201                	srli	a2,a2,0x20
    800016f8:	1582                	slli	a1,a1,0x20
    800016fa:	9181                	srli	a1,a1,0x20
    800016fc:	6928                	ld	a0,80(a0)
    800016fe:	fffff097          	auipc	ra,0xfffff
    80001702:	16c080e7          	jalr	364(ra) # 8000086a <uvmdealloc>
    80001706:	0005061b          	sext.w	a2,a0
    8000170a:	bf55                	j	800016be <growproc+0x26>

000000008000170c <fork>:
{
    8000170c:	7179                	addi	sp,sp,-48
    8000170e:	f406                	sd	ra,40(sp)
    80001710:	f022                	sd	s0,32(sp)
    80001712:	ec26                	sd	s1,24(sp)
    80001714:	e84a                	sd	s2,16(sp)
    80001716:	e44e                	sd	s3,8(sp)
    80001718:	e052                	sd	s4,0(sp)
    8000171a:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    8000171c:	00000097          	auipc	ra,0x0
    80001720:	c22080e7          	jalr	-990(ra) # 8000133e <myproc>
    80001724:	892a                	mv	s2,a0
  if((np = allocproc()) == 0){
    80001726:	00000097          	auipc	ra,0x0
    8000172a:	e22080e7          	jalr	-478(ra) # 80001548 <allocproc>
    8000172e:	10050b63          	beqz	a0,80001844 <fork+0x138>
    80001732:	89aa                	mv	s3,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    80001734:	04893603          	ld	a2,72(s2)
    80001738:	692c                	ld	a1,80(a0)
    8000173a:	05093503          	ld	a0,80(s2)
    8000173e:	fffff097          	auipc	ra,0xfffff
    80001742:	2c0080e7          	jalr	704(ra) # 800009fe <uvmcopy>
    80001746:	04054663          	bltz	a0,80001792 <fork+0x86>
  np->sz = p->sz;
    8000174a:	04893783          	ld	a5,72(s2)
    8000174e:	04f9b423          	sd	a5,72(s3)
  *(np->trapframe) = *(p->trapframe);
    80001752:	05893683          	ld	a3,88(s2)
    80001756:	87b6                	mv	a5,a3
    80001758:	0589b703          	ld	a4,88(s3)
    8000175c:	12068693          	addi	a3,a3,288
    80001760:	0007b803          	ld	a6,0(a5) # 1000 <_entry-0x7ffff000>
    80001764:	6788                	ld	a0,8(a5)
    80001766:	6b8c                	ld	a1,16(a5)
    80001768:	6f90                	ld	a2,24(a5)
    8000176a:	01073023          	sd	a6,0(a4)
    8000176e:	e708                	sd	a0,8(a4)
    80001770:	eb0c                	sd	a1,16(a4)
    80001772:	ef10                	sd	a2,24(a4)
    80001774:	02078793          	addi	a5,a5,32
    80001778:	02070713          	addi	a4,a4,32
    8000177c:	fed792e3          	bne	a5,a3,80001760 <fork+0x54>
  np->trapframe->a0 = 0;
    80001780:	0589b783          	ld	a5,88(s3)
    80001784:	0607b823          	sd	zero,112(a5)
    80001788:	0d000493          	li	s1,208
  for(i = 0; i < NOFILE; i++)
    8000178c:	15000a13          	li	s4,336
    80001790:	a03d                	j	800017be <fork+0xb2>
    freeproc(np);
    80001792:	854e                	mv	a0,s3
    80001794:	00000097          	auipc	ra,0x0
    80001798:	d5c080e7          	jalr	-676(ra) # 800014f0 <freeproc>
    release(&np->lock);
    8000179c:	854e                	mv	a0,s3
    8000179e:	00005097          	auipc	ra,0x5
    800017a2:	2a0080e7          	jalr	672(ra) # 80006a3e <release>
    return -1;
    800017a6:	5a7d                	li	s4,-1
    800017a8:	a069                	j	80001832 <fork+0x126>
      np->ofile[i] = filedup(p->ofile[i]);
    800017aa:	00003097          	auipc	ra,0x3
    800017ae:	86c080e7          	jalr	-1940(ra) # 80004016 <filedup>
    800017b2:	009987b3          	add	a5,s3,s1
    800017b6:	e388                	sd	a0,0(a5)
  for(i = 0; i < NOFILE; i++)
    800017b8:	04a1                	addi	s1,s1,8
    800017ba:	01448763          	beq	s1,s4,800017c8 <fork+0xbc>
    if(p->ofile[i])
    800017be:	009907b3          	add	a5,s2,s1
    800017c2:	6388                	ld	a0,0(a5)
    800017c4:	f17d                	bnez	a0,800017aa <fork+0x9e>
    800017c6:	bfcd                	j	800017b8 <fork+0xac>
  np->cwd = idup(p->cwd);
    800017c8:	15093503          	ld	a0,336(s2)
    800017cc:	00002097          	auipc	ra,0x2
    800017d0:	838080e7          	jalr	-1992(ra) # 80003004 <idup>
    800017d4:	14a9b823          	sd	a0,336(s3)
  safestrcpy(np->name, p->name, sizeof(p->name));
    800017d8:	4641                	li	a2,16
    800017da:	15890593          	addi	a1,s2,344
    800017de:	15898513          	addi	a0,s3,344
    800017e2:	fffff097          	auipc	ra,0xfffff
    800017e6:	ae8080e7          	jalr	-1304(ra) # 800002ca <safestrcpy>
  pid = np->pid;
    800017ea:	0309aa03          	lw	s4,48(s3)
  release(&np->lock);
    800017ee:	854e                	mv	a0,s3
    800017f0:	00005097          	auipc	ra,0x5
    800017f4:	24e080e7          	jalr	590(ra) # 80006a3e <release>
  acquire(&wait_lock);
    800017f8:	00008497          	auipc	s1,0x8
    800017fc:	87048493          	addi	s1,s1,-1936 # 80009068 <wait_lock>
    80001800:	8526                	mv	a0,s1
    80001802:	00005097          	auipc	ra,0x5
    80001806:	188080e7          	jalr	392(ra) # 8000698a <acquire>
  np->parent = p;
    8000180a:	0329bc23          	sd	s2,56(s3)
  release(&wait_lock);
    8000180e:	8526                	mv	a0,s1
    80001810:	00005097          	auipc	ra,0x5
    80001814:	22e080e7          	jalr	558(ra) # 80006a3e <release>
  acquire(&np->lock);
    80001818:	854e                	mv	a0,s3
    8000181a:	00005097          	auipc	ra,0x5
    8000181e:	170080e7          	jalr	368(ra) # 8000698a <acquire>
  np->state = RUNNABLE;
    80001822:	478d                	li	a5,3
    80001824:	00f9ac23          	sw	a5,24(s3)
  release(&np->lock);
    80001828:	854e                	mv	a0,s3
    8000182a:	00005097          	auipc	ra,0x5
    8000182e:	214080e7          	jalr	532(ra) # 80006a3e <release>
}
    80001832:	8552                	mv	a0,s4
    80001834:	70a2                	ld	ra,40(sp)
    80001836:	7402                	ld	s0,32(sp)
    80001838:	64e2                	ld	s1,24(sp)
    8000183a:	6942                	ld	s2,16(sp)
    8000183c:	69a2                	ld	s3,8(sp)
    8000183e:	6a02                	ld	s4,0(sp)
    80001840:	6145                	addi	sp,sp,48
    80001842:	8082                	ret
    return -1;
    80001844:	5a7d                	li	s4,-1
    80001846:	b7f5                	j	80001832 <fork+0x126>

0000000080001848 <scheduler>:
{
    80001848:	7139                	addi	sp,sp,-64
    8000184a:	fc06                	sd	ra,56(sp)
    8000184c:	f822                	sd	s0,48(sp)
    8000184e:	f426                	sd	s1,40(sp)
    80001850:	f04a                	sd	s2,32(sp)
    80001852:	ec4e                	sd	s3,24(sp)
    80001854:	e852                	sd	s4,16(sp)
    80001856:	e456                	sd	s5,8(sp)
    80001858:	e05a                	sd	s6,0(sp)
    8000185a:	0080                	addi	s0,sp,64
    8000185c:	8792                	mv	a5,tp
  int id = r_tp();
    8000185e:	2781                	sext.w	a5,a5
  c->proc = 0;
    80001860:	00779a93          	slli	s5,a5,0x7
    80001864:	00007717          	auipc	a4,0x7
    80001868:	7ec70713          	addi	a4,a4,2028 # 80009050 <pid_lock>
    8000186c:	9756                	add	a4,a4,s5
    8000186e:	02073823          	sd	zero,48(a4)
        swtch(&c->context, &p->context);
    80001872:	00008717          	auipc	a4,0x8
    80001876:	81670713          	addi	a4,a4,-2026 # 80009088 <cpus+0x8>
    8000187a:	9aba                	add	s5,s5,a4
      if(p->state == RUNNABLE) {
    8000187c:	498d                	li	s3,3
        p->state = RUNNING;
    8000187e:	4b11                	li	s6,4
        c->proc = p;
    80001880:	079e                	slli	a5,a5,0x7
    80001882:	00007a17          	auipc	s4,0x7
    80001886:	7cea0a13          	addi	s4,s4,1998 # 80009050 <pid_lock>
    8000188a:	9a3e                	add	s4,s4,a5
    for(p = proc; p < &proc[NPROC]; p++) {
    8000188c:	0000d917          	auipc	s2,0xd
    80001890:	5f490913          	addi	s2,s2,1524 # 8000ee80 <tickslock>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001894:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001898:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000189c:	10079073          	csrw	sstatus,a5
    800018a0:	00008497          	auipc	s1,0x8
    800018a4:	be048493          	addi	s1,s1,-1056 # 80009480 <proc>
    800018a8:	a03d                	j	800018d6 <scheduler+0x8e>
        p->state = RUNNING;
    800018aa:	0164ac23          	sw	s6,24(s1)
        c->proc = p;
    800018ae:	029a3823          	sd	s1,48(s4)
        swtch(&c->context, &p->context);
    800018b2:	06048593          	addi	a1,s1,96
    800018b6:	8556                	mv	a0,s5
    800018b8:	00000097          	auipc	ra,0x0
    800018bc:	640080e7          	jalr	1600(ra) # 80001ef8 <swtch>
        c->proc = 0;
    800018c0:	020a3823          	sd	zero,48(s4)
      release(&p->lock);
    800018c4:	8526                	mv	a0,s1
    800018c6:	00005097          	auipc	ra,0x5
    800018ca:	178080e7          	jalr	376(ra) # 80006a3e <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    800018ce:	16848493          	addi	s1,s1,360
    800018d2:	fd2481e3          	beq	s1,s2,80001894 <scheduler+0x4c>
      acquire(&p->lock);
    800018d6:	8526                	mv	a0,s1
    800018d8:	00005097          	auipc	ra,0x5
    800018dc:	0b2080e7          	jalr	178(ra) # 8000698a <acquire>
      if(p->state == RUNNABLE) {
    800018e0:	4c9c                	lw	a5,24(s1)
    800018e2:	ff3791e3          	bne	a5,s3,800018c4 <scheduler+0x7c>
    800018e6:	b7d1                	j	800018aa <scheduler+0x62>

00000000800018e8 <sched>:
{
    800018e8:	7179                	addi	sp,sp,-48
    800018ea:	f406                	sd	ra,40(sp)
    800018ec:	f022                	sd	s0,32(sp)
    800018ee:	ec26                	sd	s1,24(sp)
    800018f0:	e84a                	sd	s2,16(sp)
    800018f2:	e44e                	sd	s3,8(sp)
    800018f4:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    800018f6:	00000097          	auipc	ra,0x0
    800018fa:	a48080e7          	jalr	-1464(ra) # 8000133e <myproc>
    800018fe:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    80001900:	00005097          	auipc	ra,0x5
    80001904:	010080e7          	jalr	16(ra) # 80006910 <holding>
    80001908:	c93d                	beqz	a0,8000197e <sched+0x96>
  asm volatile("mv %0, tp" : "=r" (x) );
    8000190a:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    8000190c:	2781                	sext.w	a5,a5
    8000190e:	079e                	slli	a5,a5,0x7
    80001910:	00007717          	auipc	a4,0x7
    80001914:	74070713          	addi	a4,a4,1856 # 80009050 <pid_lock>
    80001918:	97ba                	add	a5,a5,a4
    8000191a:	0a87a703          	lw	a4,168(a5)
    8000191e:	4785                	li	a5,1
    80001920:	06f71763          	bne	a4,a5,8000198e <sched+0xa6>
  if(p->state == RUNNING)
    80001924:	4c98                	lw	a4,24(s1)
    80001926:	4791                	li	a5,4
    80001928:	06f70b63          	beq	a4,a5,8000199e <sched+0xb6>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000192c:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001930:	8b89                	andi	a5,a5,2
  if(intr_get())
    80001932:	efb5                	bnez	a5,800019ae <sched+0xc6>
  asm volatile("mv %0, tp" : "=r" (x) );
    80001934:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    80001936:	00007917          	auipc	s2,0x7
    8000193a:	71a90913          	addi	s2,s2,1818 # 80009050 <pid_lock>
    8000193e:	2781                	sext.w	a5,a5
    80001940:	079e                	slli	a5,a5,0x7
    80001942:	97ca                	add	a5,a5,s2
    80001944:	0ac7a983          	lw	s3,172(a5)
    80001948:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    8000194a:	2781                	sext.w	a5,a5
    8000194c:	079e                	slli	a5,a5,0x7
    8000194e:	00007597          	auipc	a1,0x7
    80001952:	73a58593          	addi	a1,a1,1850 # 80009088 <cpus+0x8>
    80001956:	95be                	add	a1,a1,a5
    80001958:	06048513          	addi	a0,s1,96
    8000195c:	00000097          	auipc	ra,0x0
    80001960:	59c080e7          	jalr	1436(ra) # 80001ef8 <swtch>
    80001964:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    80001966:	2781                	sext.w	a5,a5
    80001968:	079e                	slli	a5,a5,0x7
    8000196a:	97ca                	add	a5,a5,s2
    8000196c:	0b37a623          	sw	s3,172(a5)
}
    80001970:	70a2                	ld	ra,40(sp)
    80001972:	7402                	ld	s0,32(sp)
    80001974:	64e2                	ld	s1,24(sp)
    80001976:	6942                	ld	s2,16(sp)
    80001978:	69a2                	ld	s3,8(sp)
    8000197a:	6145                	addi	sp,sp,48
    8000197c:	8082                	ret
    panic("sched p->lock");
    8000197e:	00007517          	auipc	a0,0x7
    80001982:	8a250513          	addi	a0,a0,-1886 # 80008220 <etext+0x220>
    80001986:	00005097          	auipc	ra,0x5
    8000198a:	aba080e7          	jalr	-1350(ra) # 80006440 <panic>
    panic("sched locks");
    8000198e:	00007517          	auipc	a0,0x7
    80001992:	8a250513          	addi	a0,a0,-1886 # 80008230 <etext+0x230>
    80001996:	00005097          	auipc	ra,0x5
    8000199a:	aaa080e7          	jalr	-1366(ra) # 80006440 <panic>
    panic("sched running");
    8000199e:	00007517          	auipc	a0,0x7
    800019a2:	8a250513          	addi	a0,a0,-1886 # 80008240 <etext+0x240>
    800019a6:	00005097          	auipc	ra,0x5
    800019aa:	a9a080e7          	jalr	-1382(ra) # 80006440 <panic>
    panic("sched interruptible");
    800019ae:	00007517          	auipc	a0,0x7
    800019b2:	8a250513          	addi	a0,a0,-1886 # 80008250 <etext+0x250>
    800019b6:	00005097          	auipc	ra,0x5
    800019ba:	a8a080e7          	jalr	-1398(ra) # 80006440 <panic>

00000000800019be <yield>:
{
    800019be:	1101                	addi	sp,sp,-32
    800019c0:	ec06                	sd	ra,24(sp)
    800019c2:	e822                	sd	s0,16(sp)
    800019c4:	e426                	sd	s1,8(sp)
    800019c6:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    800019c8:	00000097          	auipc	ra,0x0
    800019cc:	976080e7          	jalr	-1674(ra) # 8000133e <myproc>
    800019d0:	84aa                	mv	s1,a0
  acquire(&p->lock);
    800019d2:	00005097          	auipc	ra,0x5
    800019d6:	fb8080e7          	jalr	-72(ra) # 8000698a <acquire>
  p->state = RUNNABLE;
    800019da:	478d                	li	a5,3
    800019dc:	cc9c                	sw	a5,24(s1)
  sched();
    800019de:	00000097          	auipc	ra,0x0
    800019e2:	f0a080e7          	jalr	-246(ra) # 800018e8 <sched>
  release(&p->lock);
    800019e6:	8526                	mv	a0,s1
    800019e8:	00005097          	auipc	ra,0x5
    800019ec:	056080e7          	jalr	86(ra) # 80006a3e <release>
}
    800019f0:	60e2                	ld	ra,24(sp)
    800019f2:	6442                	ld	s0,16(sp)
    800019f4:	64a2                	ld	s1,8(sp)
    800019f6:	6105                	addi	sp,sp,32
    800019f8:	8082                	ret

00000000800019fa <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    800019fa:	7179                	addi	sp,sp,-48
    800019fc:	f406                	sd	ra,40(sp)
    800019fe:	f022                	sd	s0,32(sp)
    80001a00:	ec26                	sd	s1,24(sp)
    80001a02:	e84a                	sd	s2,16(sp)
    80001a04:	e44e                	sd	s3,8(sp)
    80001a06:	1800                	addi	s0,sp,48
    80001a08:	89aa                	mv	s3,a0
    80001a0a:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80001a0c:	00000097          	auipc	ra,0x0
    80001a10:	932080e7          	jalr	-1742(ra) # 8000133e <myproc>
    80001a14:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    80001a16:	00005097          	auipc	ra,0x5
    80001a1a:	f74080e7          	jalr	-140(ra) # 8000698a <acquire>
  release(lk);
    80001a1e:	854a                	mv	a0,s2
    80001a20:	00005097          	auipc	ra,0x5
    80001a24:	01e080e7          	jalr	30(ra) # 80006a3e <release>

  // Go to sleep.
  p->chan = chan;
    80001a28:	0334b023          	sd	s3,32(s1)
  p->state = SLEEPING;
    80001a2c:	4789                	li	a5,2
    80001a2e:	cc9c                	sw	a5,24(s1)

  sched();
    80001a30:	00000097          	auipc	ra,0x0
    80001a34:	eb8080e7          	jalr	-328(ra) # 800018e8 <sched>

  // Tidy up.
  p->chan = 0;
    80001a38:	0204b023          	sd	zero,32(s1)

  // Reacquire original lock.
  release(&p->lock);
    80001a3c:	8526                	mv	a0,s1
    80001a3e:	00005097          	auipc	ra,0x5
    80001a42:	000080e7          	jalr	ra # 80006a3e <release>
  acquire(lk);
    80001a46:	854a                	mv	a0,s2
    80001a48:	00005097          	auipc	ra,0x5
    80001a4c:	f42080e7          	jalr	-190(ra) # 8000698a <acquire>
}
    80001a50:	70a2                	ld	ra,40(sp)
    80001a52:	7402                	ld	s0,32(sp)
    80001a54:	64e2                	ld	s1,24(sp)
    80001a56:	6942                	ld	s2,16(sp)
    80001a58:	69a2                	ld	s3,8(sp)
    80001a5a:	6145                	addi	sp,sp,48
    80001a5c:	8082                	ret

0000000080001a5e <wait>:
{
    80001a5e:	715d                	addi	sp,sp,-80
    80001a60:	e486                	sd	ra,72(sp)
    80001a62:	e0a2                	sd	s0,64(sp)
    80001a64:	fc26                	sd	s1,56(sp)
    80001a66:	f84a                	sd	s2,48(sp)
    80001a68:	f44e                	sd	s3,40(sp)
    80001a6a:	f052                	sd	s4,32(sp)
    80001a6c:	ec56                	sd	s5,24(sp)
    80001a6e:	e85a                	sd	s6,16(sp)
    80001a70:	e45e                	sd	s7,8(sp)
    80001a72:	e062                	sd	s8,0(sp)
    80001a74:	0880                	addi	s0,sp,80
    80001a76:	8b2a                	mv	s6,a0
  struct proc *p = myproc();
    80001a78:	00000097          	auipc	ra,0x0
    80001a7c:	8c6080e7          	jalr	-1850(ra) # 8000133e <myproc>
    80001a80:	892a                	mv	s2,a0
  acquire(&wait_lock);
    80001a82:	00007517          	auipc	a0,0x7
    80001a86:	5e650513          	addi	a0,a0,1510 # 80009068 <wait_lock>
    80001a8a:	00005097          	auipc	ra,0x5
    80001a8e:	f00080e7          	jalr	-256(ra) # 8000698a <acquire>
    havekids = 0;
    80001a92:	4b81                	li	s7,0
        if(np->state == ZOMBIE){
    80001a94:	4a15                	li	s4,5
    for(np = proc; np < &proc[NPROC]; np++){
    80001a96:	0000d997          	auipc	s3,0xd
    80001a9a:	3ea98993          	addi	s3,s3,1002 # 8000ee80 <tickslock>
        havekids = 1;
    80001a9e:	4a85                	li	s5,1
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80001aa0:	00007c17          	auipc	s8,0x7
    80001aa4:	5c8c0c13          	addi	s8,s8,1480 # 80009068 <wait_lock>
    havekids = 0;
    80001aa8:	875e                	mv	a4,s7
    for(np = proc; np < &proc[NPROC]; np++){
    80001aaa:	00008497          	auipc	s1,0x8
    80001aae:	9d648493          	addi	s1,s1,-1578 # 80009480 <proc>
    80001ab2:	a0bd                	j	80001b20 <wait+0xc2>
          pid = np->pid;
    80001ab4:	0304a983          	lw	s3,48(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&np->xstate,
    80001ab8:	000b0e63          	beqz	s6,80001ad4 <wait+0x76>
    80001abc:	4691                	li	a3,4
    80001abe:	02c48613          	addi	a2,s1,44
    80001ac2:	85da                	mv	a1,s6
    80001ac4:	05093503          	ld	a0,80(s2)
    80001ac8:	fffff097          	auipc	ra,0xfffff
    80001acc:	03a080e7          	jalr	58(ra) # 80000b02 <copyout>
    80001ad0:	02054563          	bltz	a0,80001afa <wait+0x9c>
          freeproc(np);
    80001ad4:	8526                	mv	a0,s1
    80001ad6:	00000097          	auipc	ra,0x0
    80001ada:	a1a080e7          	jalr	-1510(ra) # 800014f0 <freeproc>
          release(&np->lock);
    80001ade:	8526                	mv	a0,s1
    80001ae0:	00005097          	auipc	ra,0x5
    80001ae4:	f5e080e7          	jalr	-162(ra) # 80006a3e <release>
          release(&wait_lock);
    80001ae8:	00007517          	auipc	a0,0x7
    80001aec:	58050513          	addi	a0,a0,1408 # 80009068 <wait_lock>
    80001af0:	00005097          	auipc	ra,0x5
    80001af4:	f4e080e7          	jalr	-178(ra) # 80006a3e <release>
          return pid;
    80001af8:	a09d                	j	80001b5e <wait+0x100>
            release(&np->lock);
    80001afa:	8526                	mv	a0,s1
    80001afc:	00005097          	auipc	ra,0x5
    80001b00:	f42080e7          	jalr	-190(ra) # 80006a3e <release>
            release(&wait_lock);
    80001b04:	00007517          	auipc	a0,0x7
    80001b08:	56450513          	addi	a0,a0,1380 # 80009068 <wait_lock>
    80001b0c:	00005097          	auipc	ra,0x5
    80001b10:	f32080e7          	jalr	-206(ra) # 80006a3e <release>
            return -1;
    80001b14:	59fd                	li	s3,-1
    80001b16:	a0a1                	j	80001b5e <wait+0x100>
    for(np = proc; np < &proc[NPROC]; np++){
    80001b18:	16848493          	addi	s1,s1,360
    80001b1c:	03348463          	beq	s1,s3,80001b44 <wait+0xe6>
      if(np->parent == p){
    80001b20:	7c9c                	ld	a5,56(s1)
    80001b22:	ff279be3          	bne	a5,s2,80001b18 <wait+0xba>
        acquire(&np->lock);
    80001b26:	8526                	mv	a0,s1
    80001b28:	00005097          	auipc	ra,0x5
    80001b2c:	e62080e7          	jalr	-414(ra) # 8000698a <acquire>
        if(np->state == ZOMBIE){
    80001b30:	4c9c                	lw	a5,24(s1)
    80001b32:	f94781e3          	beq	a5,s4,80001ab4 <wait+0x56>
        release(&np->lock);
    80001b36:	8526                	mv	a0,s1
    80001b38:	00005097          	auipc	ra,0x5
    80001b3c:	f06080e7          	jalr	-250(ra) # 80006a3e <release>
        havekids = 1;
    80001b40:	8756                	mv	a4,s5
    80001b42:	bfd9                	j	80001b18 <wait+0xba>
    if(!havekids || p->killed){
    80001b44:	c701                	beqz	a4,80001b4c <wait+0xee>
    80001b46:	02892783          	lw	a5,40(s2)
    80001b4a:	c79d                	beqz	a5,80001b78 <wait+0x11a>
      release(&wait_lock);
    80001b4c:	00007517          	auipc	a0,0x7
    80001b50:	51c50513          	addi	a0,a0,1308 # 80009068 <wait_lock>
    80001b54:	00005097          	auipc	ra,0x5
    80001b58:	eea080e7          	jalr	-278(ra) # 80006a3e <release>
      return -1;
    80001b5c:	59fd                	li	s3,-1
}
    80001b5e:	854e                	mv	a0,s3
    80001b60:	60a6                	ld	ra,72(sp)
    80001b62:	6406                	ld	s0,64(sp)
    80001b64:	74e2                	ld	s1,56(sp)
    80001b66:	7942                	ld	s2,48(sp)
    80001b68:	79a2                	ld	s3,40(sp)
    80001b6a:	7a02                	ld	s4,32(sp)
    80001b6c:	6ae2                	ld	s5,24(sp)
    80001b6e:	6b42                	ld	s6,16(sp)
    80001b70:	6ba2                	ld	s7,8(sp)
    80001b72:	6c02                	ld	s8,0(sp)
    80001b74:	6161                	addi	sp,sp,80
    80001b76:	8082                	ret
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80001b78:	85e2                	mv	a1,s8
    80001b7a:	854a                	mv	a0,s2
    80001b7c:	00000097          	auipc	ra,0x0
    80001b80:	e7e080e7          	jalr	-386(ra) # 800019fa <sleep>
    havekids = 0;
    80001b84:	b715                	j	80001aa8 <wait+0x4a>

0000000080001b86 <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    80001b86:	7139                	addi	sp,sp,-64
    80001b88:	fc06                	sd	ra,56(sp)
    80001b8a:	f822                	sd	s0,48(sp)
    80001b8c:	f426                	sd	s1,40(sp)
    80001b8e:	f04a                	sd	s2,32(sp)
    80001b90:	ec4e                	sd	s3,24(sp)
    80001b92:	e852                	sd	s4,16(sp)
    80001b94:	e456                	sd	s5,8(sp)
    80001b96:	0080                	addi	s0,sp,64
    80001b98:	8a2a                	mv	s4,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    80001b9a:	00008497          	auipc	s1,0x8
    80001b9e:	8e648493          	addi	s1,s1,-1818 # 80009480 <proc>
    if(p != myproc()){
      acquire(&p->lock);
      if(p->state == SLEEPING && p->chan == chan) {
    80001ba2:	4989                	li	s3,2
        p->state = RUNNABLE;
    80001ba4:	4a8d                	li	s5,3
  for(p = proc; p < &proc[NPROC]; p++) {
    80001ba6:	0000d917          	auipc	s2,0xd
    80001baa:	2da90913          	addi	s2,s2,730 # 8000ee80 <tickslock>
    80001bae:	a821                	j	80001bc6 <wakeup+0x40>
        p->state = RUNNABLE;
    80001bb0:	0154ac23          	sw	s5,24(s1)
      }
      release(&p->lock);
    80001bb4:	8526                	mv	a0,s1
    80001bb6:	00005097          	auipc	ra,0x5
    80001bba:	e88080e7          	jalr	-376(ra) # 80006a3e <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001bbe:	16848493          	addi	s1,s1,360
    80001bc2:	03248463          	beq	s1,s2,80001bea <wakeup+0x64>
    if(p != myproc()){
    80001bc6:	fffff097          	auipc	ra,0xfffff
    80001bca:	778080e7          	jalr	1912(ra) # 8000133e <myproc>
    80001bce:	fea488e3          	beq	s1,a0,80001bbe <wakeup+0x38>
      acquire(&p->lock);
    80001bd2:	8526                	mv	a0,s1
    80001bd4:	00005097          	auipc	ra,0x5
    80001bd8:	db6080e7          	jalr	-586(ra) # 8000698a <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    80001bdc:	4c9c                	lw	a5,24(s1)
    80001bde:	fd379be3          	bne	a5,s3,80001bb4 <wakeup+0x2e>
    80001be2:	709c                	ld	a5,32(s1)
    80001be4:	fd4798e3          	bne	a5,s4,80001bb4 <wakeup+0x2e>
    80001be8:	b7e1                	j	80001bb0 <wakeup+0x2a>
    }
  }
}
    80001bea:	70e2                	ld	ra,56(sp)
    80001bec:	7442                	ld	s0,48(sp)
    80001bee:	74a2                	ld	s1,40(sp)
    80001bf0:	7902                	ld	s2,32(sp)
    80001bf2:	69e2                	ld	s3,24(sp)
    80001bf4:	6a42                	ld	s4,16(sp)
    80001bf6:	6aa2                	ld	s5,8(sp)
    80001bf8:	6121                	addi	sp,sp,64
    80001bfa:	8082                	ret

0000000080001bfc <reparent>:
{
    80001bfc:	7179                	addi	sp,sp,-48
    80001bfe:	f406                	sd	ra,40(sp)
    80001c00:	f022                	sd	s0,32(sp)
    80001c02:	ec26                	sd	s1,24(sp)
    80001c04:	e84a                	sd	s2,16(sp)
    80001c06:	e44e                	sd	s3,8(sp)
    80001c08:	e052                	sd	s4,0(sp)
    80001c0a:	1800                	addi	s0,sp,48
    80001c0c:	892a                	mv	s2,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80001c0e:	00008497          	auipc	s1,0x8
    80001c12:	87248493          	addi	s1,s1,-1934 # 80009480 <proc>
      pp->parent = initproc;
    80001c16:	00007a17          	auipc	s4,0x7
    80001c1a:	3faa0a13          	addi	s4,s4,1018 # 80009010 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80001c1e:	0000d997          	auipc	s3,0xd
    80001c22:	26298993          	addi	s3,s3,610 # 8000ee80 <tickslock>
    80001c26:	a029                	j	80001c30 <reparent+0x34>
    80001c28:	16848493          	addi	s1,s1,360
    80001c2c:	01348d63          	beq	s1,s3,80001c46 <reparent+0x4a>
    if(pp->parent == p){
    80001c30:	7c9c                	ld	a5,56(s1)
    80001c32:	ff279be3          	bne	a5,s2,80001c28 <reparent+0x2c>
      pp->parent = initproc;
    80001c36:	000a3503          	ld	a0,0(s4)
    80001c3a:	fc88                	sd	a0,56(s1)
      wakeup(initproc);
    80001c3c:	00000097          	auipc	ra,0x0
    80001c40:	f4a080e7          	jalr	-182(ra) # 80001b86 <wakeup>
    80001c44:	b7d5                	j	80001c28 <reparent+0x2c>
}
    80001c46:	70a2                	ld	ra,40(sp)
    80001c48:	7402                	ld	s0,32(sp)
    80001c4a:	64e2                	ld	s1,24(sp)
    80001c4c:	6942                	ld	s2,16(sp)
    80001c4e:	69a2                	ld	s3,8(sp)
    80001c50:	6a02                	ld	s4,0(sp)
    80001c52:	6145                	addi	sp,sp,48
    80001c54:	8082                	ret

0000000080001c56 <exit>:
{
    80001c56:	7179                	addi	sp,sp,-48
    80001c58:	f406                	sd	ra,40(sp)
    80001c5a:	f022                	sd	s0,32(sp)
    80001c5c:	ec26                	sd	s1,24(sp)
    80001c5e:	e84a                	sd	s2,16(sp)
    80001c60:	e44e                	sd	s3,8(sp)
    80001c62:	e052                	sd	s4,0(sp)
    80001c64:	1800                	addi	s0,sp,48
    80001c66:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    80001c68:	fffff097          	auipc	ra,0xfffff
    80001c6c:	6d6080e7          	jalr	1750(ra) # 8000133e <myproc>
    80001c70:	89aa                	mv	s3,a0
  if(p == initproc)
    80001c72:	00007797          	auipc	a5,0x7
    80001c76:	39e7b783          	ld	a5,926(a5) # 80009010 <initproc>
    80001c7a:	0d050493          	addi	s1,a0,208
    80001c7e:	15050913          	addi	s2,a0,336
    80001c82:	02a79363          	bne	a5,a0,80001ca8 <exit+0x52>
    panic("init exiting");
    80001c86:	00006517          	auipc	a0,0x6
    80001c8a:	5e250513          	addi	a0,a0,1506 # 80008268 <etext+0x268>
    80001c8e:	00004097          	auipc	ra,0x4
    80001c92:	7b2080e7          	jalr	1970(ra) # 80006440 <panic>
      fileclose(f);
    80001c96:	00002097          	auipc	ra,0x2
    80001c9a:	3d2080e7          	jalr	978(ra) # 80004068 <fileclose>
      p->ofile[fd] = 0;
    80001c9e:	0004b023          	sd	zero,0(s1)
  for(int fd = 0; fd < NOFILE; fd++){
    80001ca2:	04a1                	addi	s1,s1,8
    80001ca4:	01248563          	beq	s1,s2,80001cae <exit+0x58>
    if(p->ofile[fd]){
    80001ca8:	6088                	ld	a0,0(s1)
    80001caa:	f575                	bnez	a0,80001c96 <exit+0x40>
    80001cac:	bfdd                	j	80001ca2 <exit+0x4c>
  begin_op();
    80001cae:	00002097          	auipc	ra,0x2
    80001cb2:	eee080e7          	jalr	-274(ra) # 80003b9c <begin_op>
  iput(p->cwd);
    80001cb6:	1509b503          	ld	a0,336(s3)
    80001cba:	00001097          	auipc	ra,0x1
    80001cbe:	542080e7          	jalr	1346(ra) # 800031fc <iput>
  end_op();
    80001cc2:	00002097          	auipc	ra,0x2
    80001cc6:	f5a080e7          	jalr	-166(ra) # 80003c1c <end_op>
  p->cwd = 0;
    80001cca:	1409b823          	sd	zero,336(s3)
  acquire(&wait_lock);
    80001cce:	00007497          	auipc	s1,0x7
    80001cd2:	39a48493          	addi	s1,s1,922 # 80009068 <wait_lock>
    80001cd6:	8526                	mv	a0,s1
    80001cd8:	00005097          	auipc	ra,0x5
    80001cdc:	cb2080e7          	jalr	-846(ra) # 8000698a <acquire>
  reparent(p);
    80001ce0:	854e                	mv	a0,s3
    80001ce2:	00000097          	auipc	ra,0x0
    80001ce6:	f1a080e7          	jalr	-230(ra) # 80001bfc <reparent>
  wakeup(p->parent);
    80001cea:	0389b503          	ld	a0,56(s3)
    80001cee:	00000097          	auipc	ra,0x0
    80001cf2:	e98080e7          	jalr	-360(ra) # 80001b86 <wakeup>
  acquire(&p->lock);
    80001cf6:	854e                	mv	a0,s3
    80001cf8:	00005097          	auipc	ra,0x5
    80001cfc:	c92080e7          	jalr	-878(ra) # 8000698a <acquire>
  p->xstate = status;
    80001d00:	0349a623          	sw	s4,44(s3)
  p->state = ZOMBIE;
    80001d04:	4795                	li	a5,5
    80001d06:	00f9ac23          	sw	a5,24(s3)
  release(&wait_lock);
    80001d0a:	8526                	mv	a0,s1
    80001d0c:	00005097          	auipc	ra,0x5
    80001d10:	d32080e7          	jalr	-718(ra) # 80006a3e <release>
  sched();
    80001d14:	00000097          	auipc	ra,0x0
    80001d18:	bd4080e7          	jalr	-1068(ra) # 800018e8 <sched>
  panic("zombie exit");
    80001d1c:	00006517          	auipc	a0,0x6
    80001d20:	55c50513          	addi	a0,a0,1372 # 80008278 <etext+0x278>
    80001d24:	00004097          	auipc	ra,0x4
    80001d28:	71c080e7          	jalr	1820(ra) # 80006440 <panic>

0000000080001d2c <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    80001d2c:	7179                	addi	sp,sp,-48
    80001d2e:	f406                	sd	ra,40(sp)
    80001d30:	f022                	sd	s0,32(sp)
    80001d32:	ec26                	sd	s1,24(sp)
    80001d34:	e84a                	sd	s2,16(sp)
    80001d36:	e44e                	sd	s3,8(sp)
    80001d38:	1800                	addi	s0,sp,48
    80001d3a:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    80001d3c:	00007497          	auipc	s1,0x7
    80001d40:	74448493          	addi	s1,s1,1860 # 80009480 <proc>
    80001d44:	0000d997          	auipc	s3,0xd
    80001d48:	13c98993          	addi	s3,s3,316 # 8000ee80 <tickslock>
    acquire(&p->lock);
    80001d4c:	8526                	mv	a0,s1
    80001d4e:	00005097          	auipc	ra,0x5
    80001d52:	c3c080e7          	jalr	-964(ra) # 8000698a <acquire>
    if(p->pid == pid){
    80001d56:	589c                	lw	a5,48(s1)
    80001d58:	01278d63          	beq	a5,s2,80001d72 <kill+0x46>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    80001d5c:	8526                	mv	a0,s1
    80001d5e:	00005097          	auipc	ra,0x5
    80001d62:	ce0080e7          	jalr	-800(ra) # 80006a3e <release>
  for(p = proc; p < &proc[NPROC]; p++){
    80001d66:	16848493          	addi	s1,s1,360
    80001d6a:	ff3491e3          	bne	s1,s3,80001d4c <kill+0x20>
  }
  return -1;
    80001d6e:	557d                	li	a0,-1
    80001d70:	a829                	j	80001d8a <kill+0x5e>
      p->killed = 1;
    80001d72:	4785                	li	a5,1
    80001d74:	d49c                	sw	a5,40(s1)
      if(p->state == SLEEPING){
    80001d76:	4c98                	lw	a4,24(s1)
    80001d78:	4789                	li	a5,2
    80001d7a:	00f70f63          	beq	a4,a5,80001d98 <kill+0x6c>
      release(&p->lock);
    80001d7e:	8526                	mv	a0,s1
    80001d80:	00005097          	auipc	ra,0x5
    80001d84:	cbe080e7          	jalr	-834(ra) # 80006a3e <release>
      return 0;
    80001d88:	4501                	li	a0,0
}
    80001d8a:	70a2                	ld	ra,40(sp)
    80001d8c:	7402                	ld	s0,32(sp)
    80001d8e:	64e2                	ld	s1,24(sp)
    80001d90:	6942                	ld	s2,16(sp)
    80001d92:	69a2                	ld	s3,8(sp)
    80001d94:	6145                	addi	sp,sp,48
    80001d96:	8082                	ret
        p->state = RUNNABLE;
    80001d98:	478d                	li	a5,3
    80001d9a:	cc9c                	sw	a5,24(s1)
    80001d9c:	b7cd                	j	80001d7e <kill+0x52>

0000000080001d9e <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    80001d9e:	7179                	addi	sp,sp,-48
    80001da0:	f406                	sd	ra,40(sp)
    80001da2:	f022                	sd	s0,32(sp)
    80001da4:	ec26                	sd	s1,24(sp)
    80001da6:	e84a                	sd	s2,16(sp)
    80001da8:	e44e                	sd	s3,8(sp)
    80001daa:	e052                	sd	s4,0(sp)
    80001dac:	1800                	addi	s0,sp,48
    80001dae:	84aa                	mv	s1,a0
    80001db0:	892e                	mv	s2,a1
    80001db2:	89b2                	mv	s3,a2
    80001db4:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80001db6:	fffff097          	auipc	ra,0xfffff
    80001dba:	588080e7          	jalr	1416(ra) # 8000133e <myproc>
  if(user_dst){
    80001dbe:	c08d                	beqz	s1,80001de0 <either_copyout+0x42>
    return copyout(p->pagetable, dst, src, len);
    80001dc0:	86d2                	mv	a3,s4
    80001dc2:	864e                	mv	a2,s3
    80001dc4:	85ca                	mv	a1,s2
    80001dc6:	6928                	ld	a0,80(a0)
    80001dc8:	fffff097          	auipc	ra,0xfffff
    80001dcc:	d3a080e7          	jalr	-710(ra) # 80000b02 <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    80001dd0:	70a2                	ld	ra,40(sp)
    80001dd2:	7402                	ld	s0,32(sp)
    80001dd4:	64e2                	ld	s1,24(sp)
    80001dd6:	6942                	ld	s2,16(sp)
    80001dd8:	69a2                	ld	s3,8(sp)
    80001dda:	6a02                	ld	s4,0(sp)
    80001ddc:	6145                	addi	sp,sp,48
    80001dde:	8082                	ret
    memmove((char *)dst, src, len);
    80001de0:	000a061b          	sext.w	a2,s4
    80001de4:	85ce                	mv	a1,s3
    80001de6:	854a                	mv	a0,s2
    80001de8:	ffffe097          	auipc	ra,0xffffe
    80001dec:	3f0080e7          	jalr	1008(ra) # 800001d8 <memmove>
    return 0;
    80001df0:	8526                	mv	a0,s1
    80001df2:	bff9                	j	80001dd0 <either_copyout+0x32>

0000000080001df4 <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    80001df4:	7179                	addi	sp,sp,-48
    80001df6:	f406                	sd	ra,40(sp)
    80001df8:	f022                	sd	s0,32(sp)
    80001dfa:	ec26                	sd	s1,24(sp)
    80001dfc:	e84a                	sd	s2,16(sp)
    80001dfe:	e44e                	sd	s3,8(sp)
    80001e00:	e052                	sd	s4,0(sp)
    80001e02:	1800                	addi	s0,sp,48
    80001e04:	892a                	mv	s2,a0
    80001e06:	84ae                	mv	s1,a1
    80001e08:	89b2                	mv	s3,a2
    80001e0a:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80001e0c:	fffff097          	auipc	ra,0xfffff
    80001e10:	532080e7          	jalr	1330(ra) # 8000133e <myproc>
  if(user_src){
    80001e14:	c08d                	beqz	s1,80001e36 <either_copyin+0x42>
    return copyin(p->pagetable, dst, src, len);
    80001e16:	86d2                	mv	a3,s4
    80001e18:	864e                	mv	a2,s3
    80001e1a:	85ca                	mv	a1,s2
    80001e1c:	6928                	ld	a0,80(a0)
    80001e1e:	fffff097          	auipc	ra,0xfffff
    80001e22:	d70080e7          	jalr	-656(ra) # 80000b8e <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    80001e26:	70a2                	ld	ra,40(sp)
    80001e28:	7402                	ld	s0,32(sp)
    80001e2a:	64e2                	ld	s1,24(sp)
    80001e2c:	6942                	ld	s2,16(sp)
    80001e2e:	69a2                	ld	s3,8(sp)
    80001e30:	6a02                	ld	s4,0(sp)
    80001e32:	6145                	addi	sp,sp,48
    80001e34:	8082                	ret
    memmove(dst, (char*)src, len);
    80001e36:	000a061b          	sext.w	a2,s4
    80001e3a:	85ce                	mv	a1,s3
    80001e3c:	854a                	mv	a0,s2
    80001e3e:	ffffe097          	auipc	ra,0xffffe
    80001e42:	39a080e7          	jalr	922(ra) # 800001d8 <memmove>
    return 0;
    80001e46:	8526                	mv	a0,s1
    80001e48:	bff9                	j	80001e26 <either_copyin+0x32>

0000000080001e4a <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    80001e4a:	715d                	addi	sp,sp,-80
    80001e4c:	e486                	sd	ra,72(sp)
    80001e4e:	e0a2                	sd	s0,64(sp)
    80001e50:	fc26                	sd	s1,56(sp)
    80001e52:	f84a                	sd	s2,48(sp)
    80001e54:	f44e                	sd	s3,40(sp)
    80001e56:	f052                	sd	s4,32(sp)
    80001e58:	ec56                	sd	s5,24(sp)
    80001e5a:	e85a                	sd	s6,16(sp)
    80001e5c:	e45e                	sd	s7,8(sp)
    80001e5e:	0880                	addi	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    80001e60:	00006517          	auipc	a0,0x6
    80001e64:	1e850513          	addi	a0,a0,488 # 80008048 <etext+0x48>
    80001e68:	00004097          	auipc	ra,0x4
    80001e6c:	622080e7          	jalr	1570(ra) # 8000648a <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001e70:	00007497          	auipc	s1,0x7
    80001e74:	76848493          	addi	s1,s1,1896 # 800095d8 <proc+0x158>
    80001e78:	0000d917          	auipc	s2,0xd
    80001e7c:	16090913          	addi	s2,s2,352 # 8000efd8 <bcache+0x140>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001e80:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    80001e82:	00006997          	auipc	s3,0x6
    80001e86:	40698993          	addi	s3,s3,1030 # 80008288 <etext+0x288>
    printf("%d %s %s", p->pid, state, p->name);
    80001e8a:	00006a97          	auipc	s5,0x6
    80001e8e:	406a8a93          	addi	s5,s5,1030 # 80008290 <etext+0x290>
    printf("\n");
    80001e92:	00006a17          	auipc	s4,0x6
    80001e96:	1b6a0a13          	addi	s4,s4,438 # 80008048 <etext+0x48>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001e9a:	00006b97          	auipc	s7,0x6
    80001e9e:	42eb8b93          	addi	s7,s7,1070 # 800082c8 <states.1813>
    80001ea2:	a00d                	j	80001ec4 <procdump+0x7a>
    printf("%d %s %s", p->pid, state, p->name);
    80001ea4:	ed86a583          	lw	a1,-296(a3)
    80001ea8:	8556                	mv	a0,s5
    80001eaa:	00004097          	auipc	ra,0x4
    80001eae:	5e0080e7          	jalr	1504(ra) # 8000648a <printf>
    printf("\n");
    80001eb2:	8552                	mv	a0,s4
    80001eb4:	00004097          	auipc	ra,0x4
    80001eb8:	5d6080e7          	jalr	1494(ra) # 8000648a <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001ebc:	16848493          	addi	s1,s1,360
    80001ec0:	03248163          	beq	s1,s2,80001ee2 <procdump+0x98>
    if(p->state == UNUSED)
    80001ec4:	86a6                	mv	a3,s1
    80001ec6:	ec04a783          	lw	a5,-320(s1)
    80001eca:	dbed                	beqz	a5,80001ebc <procdump+0x72>
      state = "???";
    80001ecc:	864e                	mv	a2,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001ece:	fcfb6be3          	bltu	s6,a5,80001ea4 <procdump+0x5a>
    80001ed2:	1782                	slli	a5,a5,0x20
    80001ed4:	9381                	srli	a5,a5,0x20
    80001ed6:	078e                	slli	a5,a5,0x3
    80001ed8:	97de                	add	a5,a5,s7
    80001eda:	6390                	ld	a2,0(a5)
    80001edc:	f661                	bnez	a2,80001ea4 <procdump+0x5a>
      state = "???";
    80001ede:	864e                	mv	a2,s3
    80001ee0:	b7d1                	j	80001ea4 <procdump+0x5a>
  }
}
    80001ee2:	60a6                	ld	ra,72(sp)
    80001ee4:	6406                	ld	s0,64(sp)
    80001ee6:	74e2                	ld	s1,56(sp)
    80001ee8:	7942                	ld	s2,48(sp)
    80001eea:	79a2                	ld	s3,40(sp)
    80001eec:	7a02                	ld	s4,32(sp)
    80001eee:	6ae2                	ld	s5,24(sp)
    80001ef0:	6b42                	ld	s6,16(sp)
    80001ef2:	6ba2                	ld	s7,8(sp)
    80001ef4:	6161                	addi	sp,sp,80
    80001ef6:	8082                	ret

0000000080001ef8 <swtch>:
    80001ef8:	00153023          	sd	ra,0(a0)
    80001efc:	00253423          	sd	sp,8(a0)
    80001f00:	e900                	sd	s0,16(a0)
    80001f02:	ed04                	sd	s1,24(a0)
    80001f04:	03253023          	sd	s2,32(a0)
    80001f08:	03353423          	sd	s3,40(a0)
    80001f0c:	03453823          	sd	s4,48(a0)
    80001f10:	03553c23          	sd	s5,56(a0)
    80001f14:	05653023          	sd	s6,64(a0)
    80001f18:	05753423          	sd	s7,72(a0)
    80001f1c:	05853823          	sd	s8,80(a0)
    80001f20:	05953c23          	sd	s9,88(a0)
    80001f24:	07a53023          	sd	s10,96(a0)
    80001f28:	07b53423          	sd	s11,104(a0)
    80001f2c:	0005b083          	ld	ra,0(a1)
    80001f30:	0085b103          	ld	sp,8(a1)
    80001f34:	6980                	ld	s0,16(a1)
    80001f36:	6d84                	ld	s1,24(a1)
    80001f38:	0205b903          	ld	s2,32(a1)
    80001f3c:	0285b983          	ld	s3,40(a1)
    80001f40:	0305ba03          	ld	s4,48(a1)
    80001f44:	0385ba83          	ld	s5,56(a1)
    80001f48:	0405bb03          	ld	s6,64(a1)
    80001f4c:	0485bb83          	ld	s7,72(a1)
    80001f50:	0505bc03          	ld	s8,80(a1)
    80001f54:	0585bc83          	ld	s9,88(a1)
    80001f58:	0605bd03          	ld	s10,96(a1)
    80001f5c:	0685bd83          	ld	s11,104(a1)
    80001f60:	8082                	ret

0000000080001f62 <trapinit>:

extern int devintr();

void
trapinit(void)
{
    80001f62:	1141                	addi	sp,sp,-16
    80001f64:	e406                	sd	ra,8(sp)
    80001f66:	e022                	sd	s0,0(sp)
    80001f68:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80001f6a:	00006597          	auipc	a1,0x6
    80001f6e:	38e58593          	addi	a1,a1,910 # 800082f8 <states.1813+0x30>
    80001f72:	0000d517          	auipc	a0,0xd
    80001f76:	f0e50513          	addi	a0,a0,-242 # 8000ee80 <tickslock>
    80001f7a:	00005097          	auipc	ra,0x5
    80001f7e:	980080e7          	jalr	-1664(ra) # 800068fa <initlock>
}
    80001f82:	60a2                	ld	ra,8(sp)
    80001f84:	6402                	ld	s0,0(sp)
    80001f86:	0141                	addi	sp,sp,16
    80001f88:	8082                	ret

0000000080001f8a <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80001f8a:	1141                	addi	sp,sp,-16
    80001f8c:	e422                	sd	s0,8(sp)
    80001f8e:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001f90:	00003797          	auipc	a5,0x3
    80001f94:	6f078793          	addi	a5,a5,1776 # 80005680 <kernelvec>
    80001f98:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    80001f9c:	6422                	ld	s0,8(sp)
    80001f9e:	0141                	addi	sp,sp,16
    80001fa0:	8082                	ret

0000000080001fa2 <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80001fa2:	1141                	addi	sp,sp,-16
    80001fa4:	e406                	sd	ra,8(sp)
    80001fa6:	e022                	sd	s0,0(sp)
    80001fa8:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    80001faa:	fffff097          	auipc	ra,0xfffff
    80001fae:	394080e7          	jalr	916(ra) # 8000133e <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001fb2:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80001fb6:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001fb8:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to trampoline.S
  w_stvec(TRAMPOLINE + (uservec - trampoline));
    80001fbc:	00005617          	auipc	a2,0x5
    80001fc0:	04460613          	addi	a2,a2,68 # 80007000 <_trampoline>
    80001fc4:	00005697          	auipc	a3,0x5
    80001fc8:	03c68693          	addi	a3,a3,60 # 80007000 <_trampoline>
    80001fcc:	8e91                	sub	a3,a3,a2
    80001fce:	040007b7          	lui	a5,0x4000
    80001fd2:	17fd                	addi	a5,a5,-1
    80001fd4:	07b2                	slli	a5,a5,0xc
    80001fd6:	96be                	add	a3,a3,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001fd8:	10569073          	csrw	stvec,a3

  // set up trapframe values that uservec will need when
  // the process next re-enters the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    80001fdc:	6d38                	ld	a4,88(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    80001fde:	180026f3          	csrr	a3,satp
    80001fe2:	e314                	sd	a3,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80001fe4:	6d38                	ld	a4,88(a0)
    80001fe6:	6134                	ld	a3,64(a0)
    80001fe8:	6585                	lui	a1,0x1
    80001fea:	96ae                	add	a3,a3,a1
    80001fec:	e714                	sd	a3,8(a4)
  p->trapframe->kernel_trap = (uint64)usertrap;
    80001fee:	6d38                	ld	a4,88(a0)
    80001ff0:	00000697          	auipc	a3,0x0
    80001ff4:	13868693          	addi	a3,a3,312 # 80002128 <usertrap>
    80001ff8:	eb14                	sd	a3,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    80001ffa:	6d38                	ld	a4,88(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    80001ffc:	8692                	mv	a3,tp
    80001ffe:	f314                	sd	a3,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002000:	100026f3          	csrr	a3,sstatus

  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80002004:	eff6f693          	andi	a3,a3,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80002008:	0206e693          	ori	a3,a3,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000200c:	10069073          	csrw	sstatus,a3
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80002010:	6d38                	ld	a4,88(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80002012:	6f18                	ld	a4,24(a4)
    80002014:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    80002018:	692c                	ld	a1,80(a0)
    8000201a:	81b1                	srli	a1,a1,0xc

  // jump to trampoline.S at the top of memory, which
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 fn = TRAMPOLINE + (userret - trampoline);
    8000201c:	00005717          	auipc	a4,0x5
    80002020:	07470713          	addi	a4,a4,116 # 80007090 <userret>
    80002024:	8f11                	sub	a4,a4,a2
    80002026:	97ba                	add	a5,a5,a4
  ((void (*)(uint64,uint64))fn)(TRAPFRAME, satp);
    80002028:	577d                	li	a4,-1
    8000202a:	177e                	slli	a4,a4,0x3f
    8000202c:	8dd9                	or	a1,a1,a4
    8000202e:	02000537          	lui	a0,0x2000
    80002032:	157d                	addi	a0,a0,-1
    80002034:	0536                	slli	a0,a0,0xd
    80002036:	9782                	jalr	a5
}
    80002038:	60a2                	ld	ra,8(sp)
    8000203a:	6402                	ld	s0,0(sp)
    8000203c:	0141                	addi	sp,sp,16
    8000203e:	8082                	ret

0000000080002040 <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    80002040:	1101                	addi	sp,sp,-32
    80002042:	ec06                	sd	ra,24(sp)
    80002044:	e822                	sd	s0,16(sp)
    80002046:	e426                	sd	s1,8(sp)
    80002048:	1000                	addi	s0,sp,32
  acquire(&tickslock);
    8000204a:	0000d497          	auipc	s1,0xd
    8000204e:	e3648493          	addi	s1,s1,-458 # 8000ee80 <tickslock>
    80002052:	8526                	mv	a0,s1
    80002054:	00005097          	auipc	ra,0x5
    80002058:	936080e7          	jalr	-1738(ra) # 8000698a <acquire>
  ticks++;
    8000205c:	00007517          	auipc	a0,0x7
    80002060:	fbc50513          	addi	a0,a0,-68 # 80009018 <ticks>
    80002064:	411c                	lw	a5,0(a0)
    80002066:	2785                	addiw	a5,a5,1
    80002068:	c11c                	sw	a5,0(a0)
  wakeup(&ticks);
    8000206a:	00000097          	auipc	ra,0x0
    8000206e:	b1c080e7          	jalr	-1252(ra) # 80001b86 <wakeup>
  release(&tickslock);
    80002072:	8526                	mv	a0,s1
    80002074:	00005097          	auipc	ra,0x5
    80002078:	9ca080e7          	jalr	-1590(ra) # 80006a3e <release>
}
    8000207c:	60e2                	ld	ra,24(sp)
    8000207e:	6442                	ld	s0,16(sp)
    80002080:	64a2                	ld	s1,8(sp)
    80002082:	6105                	addi	sp,sp,32
    80002084:	8082                	ret

0000000080002086 <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    80002086:	1101                	addi	sp,sp,-32
    80002088:	ec06                	sd	ra,24(sp)
    8000208a:	e822                	sd	s0,16(sp)
    8000208c:	e426                	sd	s1,8(sp)
    8000208e:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002090:	14202773          	csrr	a4,scause
  uint64 scause = r_scause();

  if((scause & 0x8000000000000000L) &&
    80002094:	00074d63          	bltz	a4,800020ae <devintr+0x28>
    // now allowed to interrupt again.
    if(irq)
      plic_complete(irq);

    return 1;
  } else if(scause == 0x8000000000000001L){
    80002098:	57fd                	li	a5,-1
    8000209a:	17fe                	slli	a5,a5,0x3f
    8000209c:	0785                	addi	a5,a5,1
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);

    return 2;
  } else {
    return 0;
    8000209e:	4501                	li	a0,0
  } else if(scause == 0x8000000000000001L){
    800020a0:	06f70363          	beq	a4,a5,80002106 <devintr+0x80>
  }
}
    800020a4:	60e2                	ld	ra,24(sp)
    800020a6:	6442                	ld	s0,16(sp)
    800020a8:	64a2                	ld	s1,8(sp)
    800020aa:	6105                	addi	sp,sp,32
    800020ac:	8082                	ret
     (scause & 0xff) == 9){
    800020ae:	0ff77793          	andi	a5,a4,255
  if((scause & 0x8000000000000000L) &&
    800020b2:	46a5                	li	a3,9
    800020b4:	fed792e3          	bne	a5,a3,80002098 <devintr+0x12>
    int irq = plic_claim();
    800020b8:	00003097          	auipc	ra,0x3
    800020bc:	6d0080e7          	jalr	1744(ra) # 80005788 <plic_claim>
    800020c0:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    800020c2:	47a9                	li	a5,10
    800020c4:	02f50763          	beq	a0,a5,800020f2 <devintr+0x6c>
    } else if(irq == VIRTIO0_IRQ){
    800020c8:	4785                	li	a5,1
    800020ca:	02f50963          	beq	a0,a5,800020fc <devintr+0x76>
    return 1;
    800020ce:	4505                	li	a0,1
    } else if(irq){
    800020d0:	d8f1                	beqz	s1,800020a4 <devintr+0x1e>
      printf("unexpected interrupt irq=%d\n", irq);
    800020d2:	85a6                	mv	a1,s1
    800020d4:	00006517          	auipc	a0,0x6
    800020d8:	22c50513          	addi	a0,a0,556 # 80008300 <states.1813+0x38>
    800020dc:	00004097          	auipc	ra,0x4
    800020e0:	3ae080e7          	jalr	942(ra) # 8000648a <printf>
      plic_complete(irq);
    800020e4:	8526                	mv	a0,s1
    800020e6:	00003097          	auipc	ra,0x3
    800020ea:	6c6080e7          	jalr	1734(ra) # 800057ac <plic_complete>
    return 1;
    800020ee:	4505                	li	a0,1
    800020f0:	bf55                	j	800020a4 <devintr+0x1e>
      uartintr();
    800020f2:	00004097          	auipc	ra,0x4
    800020f6:	7b8080e7          	jalr	1976(ra) # 800068aa <uartintr>
    800020fa:	b7ed                	j	800020e4 <devintr+0x5e>
      virtio_disk_intr();
    800020fc:	00004097          	auipc	ra,0x4
    80002100:	b90080e7          	jalr	-1136(ra) # 80005c8c <virtio_disk_intr>
    80002104:	b7c5                	j	800020e4 <devintr+0x5e>
    if(cpuid() == 0){
    80002106:	fffff097          	auipc	ra,0xfffff
    8000210a:	20c080e7          	jalr	524(ra) # 80001312 <cpuid>
    8000210e:	c901                	beqz	a0,8000211e <devintr+0x98>
  asm volatile("csrr %0, sip" : "=r" (x) );
    80002110:	144027f3          	csrr	a5,sip
    w_sip(r_sip() & ~2);
    80002114:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    80002116:	14479073          	csrw	sip,a5
    return 2;
    8000211a:	4509                	li	a0,2
    8000211c:	b761                	j	800020a4 <devintr+0x1e>
      clockintr();
    8000211e:	00000097          	auipc	ra,0x0
    80002122:	f22080e7          	jalr	-222(ra) # 80002040 <clockintr>
    80002126:	b7ed                	j	80002110 <devintr+0x8a>

0000000080002128 <usertrap>:
{
    80002128:	1101                	addi	sp,sp,-32
    8000212a:	ec06                	sd	ra,24(sp)
    8000212c:	e822                	sd	s0,16(sp)
    8000212e:	e426                	sd	s1,8(sp)
    80002130:	e04a                	sd	s2,0(sp)
    80002132:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002134:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    80002138:	1007f793          	andi	a5,a5,256
    8000213c:	e3ad                	bnez	a5,8000219e <usertrap+0x76>
  asm volatile("csrw stvec, %0" : : "r" (x));
    8000213e:	00003797          	auipc	a5,0x3
    80002142:	54278793          	addi	a5,a5,1346 # 80005680 <kernelvec>
    80002146:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    8000214a:	fffff097          	auipc	ra,0xfffff
    8000214e:	1f4080e7          	jalr	500(ra) # 8000133e <myproc>
    80002152:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    80002154:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002156:	14102773          	csrr	a4,sepc
    8000215a:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    8000215c:	14202773          	csrr	a4,scause
  if(scause == 8) {
    80002160:	47a1                	li	a5,8
    80002162:	04f71c63          	bne	a4,a5,800021ba <usertrap+0x92>
    if(p->killed)
    80002166:	551c                	lw	a5,40(a0)
    80002168:	e3b9                	bnez	a5,800021ae <usertrap+0x86>
    p->trapframe->epc += 4;
    8000216a:	6cb8                	ld	a4,88(s1)
    8000216c:	6f1c                	ld	a5,24(a4)
    8000216e:	0791                	addi	a5,a5,4
    80002170:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002172:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80002176:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000217a:	10079073          	csrw	sstatus,a5
    syscall();
    8000217e:	00000097          	auipc	ra,0x0
    80002182:	2fe080e7          	jalr	766(ra) # 8000247c <syscall>
  if(p->killed)
    80002186:	549c                	lw	a5,40(s1)
    80002188:	ebd9                	bnez	a5,8000221e <usertrap+0xf6>
  usertrapret();
    8000218a:	00000097          	auipc	ra,0x0
    8000218e:	e18080e7          	jalr	-488(ra) # 80001fa2 <usertrapret>
}
    80002192:	60e2                	ld	ra,24(sp)
    80002194:	6442                	ld	s0,16(sp)
    80002196:	64a2                	ld	s1,8(sp)
    80002198:	6902                	ld	s2,0(sp)
    8000219a:	6105                	addi	sp,sp,32
    8000219c:	8082                	ret
    panic("usertrap: not from user mode");
    8000219e:	00006517          	auipc	a0,0x6
    800021a2:	18250513          	addi	a0,a0,386 # 80008320 <states.1813+0x58>
    800021a6:	00004097          	auipc	ra,0x4
    800021aa:	29a080e7          	jalr	666(ra) # 80006440 <panic>
      exit(-1);
    800021ae:	557d                	li	a0,-1
    800021b0:	00000097          	auipc	ra,0x0
    800021b4:	aa6080e7          	jalr	-1370(ra) # 80001c56 <exit>
    800021b8:	bf4d                	j	8000216a <usertrap+0x42>
  } else if ((which_dev = devintr()) != 0) {
    800021ba:	00000097          	auipc	ra,0x0
    800021be:	ecc080e7          	jalr	-308(ra) # 80002086 <devintr>
    800021c2:	892a                	mv	s2,a0
    800021c4:	e931                	bnez	a0,80002218 <usertrap+0xf0>
  asm volatile("csrr %0, scause" : "=r" (x) );
    800021c6:	14202773          	csrr	a4,scause
  else if (r_scause() == 13 || r_scause() == 15){
    800021ca:	47b5                	li	a5,13
    800021cc:	00f70763          	beq	a4,a5,800021da <usertrap+0xb2>
    800021d0:	14202773          	csrr	a4,scause
    800021d4:	47bd                	li	a5,15
    800021d6:	00f71763          	bne	a4,a5,800021e4 <usertrap+0xbc>
    handle_pgfault();
    800021da:	00004097          	auipc	ra,0x4
    800021de:	bdc080e7          	jalr	-1060(ra) # 80005db6 <handle_pgfault>
    800021e2:	b755                	j	80002186 <usertrap+0x5e>
    800021e4:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    800021e8:	5890                	lw	a2,48(s1)
    800021ea:	00006517          	auipc	a0,0x6
    800021ee:	15650513          	addi	a0,a0,342 # 80008340 <states.1813+0x78>
    800021f2:	00004097          	auipc	ra,0x4
    800021f6:	298080e7          	jalr	664(ra) # 8000648a <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    800021fa:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    800021fe:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80002202:	00006517          	auipc	a0,0x6
    80002206:	16e50513          	addi	a0,a0,366 # 80008370 <states.1813+0xa8>
    8000220a:	00004097          	auipc	ra,0x4
    8000220e:	280080e7          	jalr	640(ra) # 8000648a <printf>
    p->killed = 1;
    80002212:	4785                	li	a5,1
    80002214:	d49c                	sw	a5,40(s1)
  if(p->killed)
    80002216:	a029                	j	80002220 <usertrap+0xf8>
    80002218:	549c                	lw	a5,40(s1)
    8000221a:	cb81                	beqz	a5,8000222a <usertrap+0x102>
    8000221c:	a011                	j	80002220 <usertrap+0xf8>
    8000221e:	4901                	li	s2,0
    exit(-1);
    80002220:	557d                	li	a0,-1
    80002222:	00000097          	auipc	ra,0x0
    80002226:	a34080e7          	jalr	-1484(ra) # 80001c56 <exit>
  if(which_dev == 2)
    8000222a:	4789                	li	a5,2
    8000222c:	f4f91fe3          	bne	s2,a5,8000218a <usertrap+0x62>
    yield();
    80002230:	fffff097          	auipc	ra,0xfffff
    80002234:	78e080e7          	jalr	1934(ra) # 800019be <yield>
    80002238:	bf89                	j	8000218a <usertrap+0x62>

000000008000223a <kerneltrap>:
{
    8000223a:	7179                	addi	sp,sp,-48
    8000223c:	f406                	sd	ra,40(sp)
    8000223e:	f022                	sd	s0,32(sp)
    80002240:	ec26                	sd	s1,24(sp)
    80002242:	e84a                	sd	s2,16(sp)
    80002244:	e44e                	sd	s3,8(sp)
    80002246:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002248:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000224c:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002250:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    80002254:	1004f793          	andi	a5,s1,256
    80002258:	cb85                	beqz	a5,80002288 <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000225a:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    8000225e:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    80002260:	ef85                	bnez	a5,80002298 <kerneltrap+0x5e>
  if((which_dev = devintr()) == 0){
    80002262:	00000097          	auipc	ra,0x0
    80002266:	e24080e7          	jalr	-476(ra) # 80002086 <devintr>
    8000226a:	cd1d                	beqz	a0,800022a8 <kerneltrap+0x6e>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    8000226c:	4789                	li	a5,2
    8000226e:	06f50a63          	beq	a0,a5,800022e2 <kerneltrap+0xa8>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80002272:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002276:	10049073          	csrw	sstatus,s1
}
    8000227a:	70a2                	ld	ra,40(sp)
    8000227c:	7402                	ld	s0,32(sp)
    8000227e:	64e2                	ld	s1,24(sp)
    80002280:	6942                	ld	s2,16(sp)
    80002282:	69a2                	ld	s3,8(sp)
    80002284:	6145                	addi	sp,sp,48
    80002286:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    80002288:	00006517          	auipc	a0,0x6
    8000228c:	10850513          	addi	a0,a0,264 # 80008390 <states.1813+0xc8>
    80002290:	00004097          	auipc	ra,0x4
    80002294:	1b0080e7          	jalr	432(ra) # 80006440 <panic>
    panic("kerneltrap: interrupts enabled");
    80002298:	00006517          	auipc	a0,0x6
    8000229c:	12050513          	addi	a0,a0,288 # 800083b8 <states.1813+0xf0>
    800022a0:	00004097          	auipc	ra,0x4
    800022a4:	1a0080e7          	jalr	416(ra) # 80006440 <panic>
    printf("scause %p\n", scause);
    800022a8:	85ce                	mv	a1,s3
    800022aa:	00006517          	auipc	a0,0x6
    800022ae:	12e50513          	addi	a0,a0,302 # 800083d8 <states.1813+0x110>
    800022b2:	00004097          	auipc	ra,0x4
    800022b6:	1d8080e7          	jalr	472(ra) # 8000648a <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    800022ba:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    800022be:	14302673          	csrr	a2,stval
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    800022c2:	00006517          	auipc	a0,0x6
    800022c6:	12650513          	addi	a0,a0,294 # 800083e8 <states.1813+0x120>
    800022ca:	00004097          	auipc	ra,0x4
    800022ce:	1c0080e7          	jalr	448(ra) # 8000648a <printf>
    panic("kerneltrap");
    800022d2:	00006517          	auipc	a0,0x6
    800022d6:	12e50513          	addi	a0,a0,302 # 80008400 <states.1813+0x138>
    800022da:	00004097          	auipc	ra,0x4
    800022de:	166080e7          	jalr	358(ra) # 80006440 <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    800022e2:	fffff097          	auipc	ra,0xfffff
    800022e6:	05c080e7          	jalr	92(ra) # 8000133e <myproc>
    800022ea:	d541                	beqz	a0,80002272 <kerneltrap+0x38>
    800022ec:	fffff097          	auipc	ra,0xfffff
    800022f0:	052080e7          	jalr	82(ra) # 8000133e <myproc>
    800022f4:	4d18                	lw	a4,24(a0)
    800022f6:	4791                	li	a5,4
    800022f8:	f6f71de3          	bne	a4,a5,80002272 <kerneltrap+0x38>
    yield();
    800022fc:	fffff097          	auipc	ra,0xfffff
    80002300:	6c2080e7          	jalr	1730(ra) # 800019be <yield>
    80002304:	b7bd                	j	80002272 <kerneltrap+0x38>

0000000080002306 <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80002306:	1101                	addi	sp,sp,-32
    80002308:	ec06                	sd	ra,24(sp)
    8000230a:	e822                	sd	s0,16(sp)
    8000230c:	e426                	sd	s1,8(sp)
    8000230e:	1000                	addi	s0,sp,32
    80002310:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80002312:	fffff097          	auipc	ra,0xfffff
    80002316:	02c080e7          	jalr	44(ra) # 8000133e <myproc>
  switch (n) {
    8000231a:	4795                	li	a5,5
    8000231c:	0497e163          	bltu	a5,s1,8000235e <argraw+0x58>
    80002320:	048a                	slli	s1,s1,0x2
    80002322:	00006717          	auipc	a4,0x6
    80002326:	11670713          	addi	a4,a4,278 # 80008438 <states.1813+0x170>
    8000232a:	94ba                	add	s1,s1,a4
    8000232c:	409c                	lw	a5,0(s1)
    8000232e:	97ba                	add	a5,a5,a4
    80002330:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80002332:	6d3c                	ld	a5,88(a0)
    80002334:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80002336:	60e2                	ld	ra,24(sp)
    80002338:	6442                	ld	s0,16(sp)
    8000233a:	64a2                	ld	s1,8(sp)
    8000233c:	6105                	addi	sp,sp,32
    8000233e:	8082                	ret
    return p->trapframe->a1;
    80002340:	6d3c                	ld	a5,88(a0)
    80002342:	7fa8                	ld	a0,120(a5)
    80002344:	bfcd                	j	80002336 <argraw+0x30>
    return p->trapframe->a2;
    80002346:	6d3c                	ld	a5,88(a0)
    80002348:	63c8                	ld	a0,128(a5)
    8000234a:	b7f5                	j	80002336 <argraw+0x30>
    return p->trapframe->a3;
    8000234c:	6d3c                	ld	a5,88(a0)
    8000234e:	67c8                	ld	a0,136(a5)
    80002350:	b7dd                	j	80002336 <argraw+0x30>
    return p->trapframe->a4;
    80002352:	6d3c                	ld	a5,88(a0)
    80002354:	6bc8                	ld	a0,144(a5)
    80002356:	b7c5                	j	80002336 <argraw+0x30>
    return p->trapframe->a5;
    80002358:	6d3c                	ld	a5,88(a0)
    8000235a:	6fc8                	ld	a0,152(a5)
    8000235c:	bfe9                	j	80002336 <argraw+0x30>
  panic("argraw");
    8000235e:	00006517          	auipc	a0,0x6
    80002362:	0b250513          	addi	a0,a0,178 # 80008410 <states.1813+0x148>
    80002366:	00004097          	auipc	ra,0x4
    8000236a:	0da080e7          	jalr	218(ra) # 80006440 <panic>

000000008000236e <fetchaddr>:
{
    8000236e:	1101                	addi	sp,sp,-32
    80002370:	ec06                	sd	ra,24(sp)
    80002372:	e822                	sd	s0,16(sp)
    80002374:	e426                	sd	s1,8(sp)
    80002376:	e04a                	sd	s2,0(sp)
    80002378:	1000                	addi	s0,sp,32
    8000237a:	84aa                	mv	s1,a0
    8000237c:	892e                	mv	s2,a1
  struct proc *p = myproc();
    8000237e:	fffff097          	auipc	ra,0xfffff
    80002382:	fc0080e7          	jalr	-64(ra) # 8000133e <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz)
    80002386:	653c                	ld	a5,72(a0)
    80002388:	02f4f863          	bgeu	s1,a5,800023b8 <fetchaddr+0x4a>
    8000238c:	00848713          	addi	a4,s1,8
    80002390:	02e7e663          	bltu	a5,a4,800023bc <fetchaddr+0x4e>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80002394:	46a1                	li	a3,8
    80002396:	8626                	mv	a2,s1
    80002398:	85ca                	mv	a1,s2
    8000239a:	6928                	ld	a0,80(a0)
    8000239c:	ffffe097          	auipc	ra,0xffffe
    800023a0:	7f2080e7          	jalr	2034(ra) # 80000b8e <copyin>
    800023a4:	00a03533          	snez	a0,a0
    800023a8:	40a00533          	neg	a0,a0
}
    800023ac:	60e2                	ld	ra,24(sp)
    800023ae:	6442                	ld	s0,16(sp)
    800023b0:	64a2                	ld	s1,8(sp)
    800023b2:	6902                	ld	s2,0(sp)
    800023b4:	6105                	addi	sp,sp,32
    800023b6:	8082                	ret
    return -1;
    800023b8:	557d                	li	a0,-1
    800023ba:	bfcd                	j	800023ac <fetchaddr+0x3e>
    800023bc:	557d                	li	a0,-1
    800023be:	b7fd                	j	800023ac <fetchaddr+0x3e>

00000000800023c0 <fetchstr>:
{
    800023c0:	7179                	addi	sp,sp,-48
    800023c2:	f406                	sd	ra,40(sp)
    800023c4:	f022                	sd	s0,32(sp)
    800023c6:	ec26                	sd	s1,24(sp)
    800023c8:	e84a                	sd	s2,16(sp)
    800023ca:	e44e                	sd	s3,8(sp)
    800023cc:	1800                	addi	s0,sp,48
    800023ce:	892a                	mv	s2,a0
    800023d0:	84ae                	mv	s1,a1
    800023d2:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    800023d4:	fffff097          	auipc	ra,0xfffff
    800023d8:	f6a080e7          	jalr	-150(ra) # 8000133e <myproc>
  int err = copyinstr(p->pagetable, buf, addr, max);
    800023dc:	86ce                	mv	a3,s3
    800023de:	864a                	mv	a2,s2
    800023e0:	85a6                	mv	a1,s1
    800023e2:	6928                	ld	a0,80(a0)
    800023e4:	fffff097          	auipc	ra,0xfffff
    800023e8:	836080e7          	jalr	-1994(ra) # 80000c1a <copyinstr>
  if(err < 0)
    800023ec:	00054763          	bltz	a0,800023fa <fetchstr+0x3a>
  return strlen(buf);
    800023f0:	8526                	mv	a0,s1
    800023f2:	ffffe097          	auipc	ra,0xffffe
    800023f6:	f0a080e7          	jalr	-246(ra) # 800002fc <strlen>
}
    800023fa:	70a2                	ld	ra,40(sp)
    800023fc:	7402                	ld	s0,32(sp)
    800023fe:	64e2                	ld	s1,24(sp)
    80002400:	6942                	ld	s2,16(sp)
    80002402:	69a2                	ld	s3,8(sp)
    80002404:	6145                	addi	sp,sp,48
    80002406:	8082                	ret

0000000080002408 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
    80002408:	1101                	addi	sp,sp,-32
    8000240a:	ec06                	sd	ra,24(sp)
    8000240c:	e822                	sd	s0,16(sp)
    8000240e:	e426                	sd	s1,8(sp)
    80002410:	1000                	addi	s0,sp,32
    80002412:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002414:	00000097          	auipc	ra,0x0
    80002418:	ef2080e7          	jalr	-270(ra) # 80002306 <argraw>
    8000241c:	c088                	sw	a0,0(s1)
  return 0;
}
    8000241e:	4501                	li	a0,0
    80002420:	60e2                	ld	ra,24(sp)
    80002422:	6442                	ld	s0,16(sp)
    80002424:	64a2                	ld	s1,8(sp)
    80002426:	6105                	addi	sp,sp,32
    80002428:	8082                	ret

000000008000242a <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
int
argaddr(int n, uint64 *ip)
{
    8000242a:	1101                	addi	sp,sp,-32
    8000242c:	ec06                	sd	ra,24(sp)
    8000242e:	e822                	sd	s0,16(sp)
    80002430:	e426                	sd	s1,8(sp)
    80002432:	1000                	addi	s0,sp,32
    80002434:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002436:	00000097          	auipc	ra,0x0
    8000243a:	ed0080e7          	jalr	-304(ra) # 80002306 <argraw>
    8000243e:	e088                	sd	a0,0(s1)
  return 0;
}
    80002440:	4501                	li	a0,0
    80002442:	60e2                	ld	ra,24(sp)
    80002444:	6442                	ld	s0,16(sp)
    80002446:	64a2                	ld	s1,8(sp)
    80002448:	6105                	addi	sp,sp,32
    8000244a:	8082                	ret

000000008000244c <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    8000244c:	1101                	addi	sp,sp,-32
    8000244e:	ec06                	sd	ra,24(sp)
    80002450:	e822                	sd	s0,16(sp)
    80002452:	e426                	sd	s1,8(sp)
    80002454:	e04a                	sd	s2,0(sp)
    80002456:	1000                	addi	s0,sp,32
    80002458:	84ae                	mv	s1,a1
    8000245a:	8932                	mv	s2,a2
  *ip = argraw(n);
    8000245c:	00000097          	auipc	ra,0x0
    80002460:	eaa080e7          	jalr	-342(ra) # 80002306 <argraw>
  uint64 addr;
  if(argaddr(n, &addr) < 0)
    return -1;
  return fetchstr(addr, buf, max);
    80002464:	864a                	mv	a2,s2
    80002466:	85a6                	mv	a1,s1
    80002468:	00000097          	auipc	ra,0x0
    8000246c:	f58080e7          	jalr	-168(ra) # 800023c0 <fetchstr>
}
    80002470:	60e2                	ld	ra,24(sp)
    80002472:	6442                	ld	s0,16(sp)
    80002474:	64a2                	ld	s1,8(sp)
    80002476:	6902                	ld	s2,0(sp)
    80002478:	6105                	addi	sp,sp,32
    8000247a:	8082                	ret

000000008000247c <syscall>:



void
syscall(void)
{
    8000247c:	1101                	addi	sp,sp,-32
    8000247e:	ec06                	sd	ra,24(sp)
    80002480:	e822                	sd	s0,16(sp)
    80002482:	e426                	sd	s1,8(sp)
    80002484:	e04a                	sd	s2,0(sp)
    80002486:	1000                	addi	s0,sp,32
  int num;
  struct proc *p = myproc();
    80002488:	fffff097          	auipc	ra,0xfffff
    8000248c:	eb6080e7          	jalr	-330(ra) # 8000133e <myproc>
    80002490:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    80002492:	05853903          	ld	s2,88(a0)
    80002496:	0a893783          	ld	a5,168(s2)
    8000249a:	0007869b          	sext.w	a3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    8000249e:	37fd                	addiw	a5,a5,-1
    800024a0:	477d                	li	a4,31
    800024a2:	00f76f63          	bltu	a4,a5,800024c0 <syscall+0x44>
    800024a6:	00369713          	slli	a4,a3,0x3
    800024aa:	00006797          	auipc	a5,0x6
    800024ae:	fa678793          	addi	a5,a5,-90 # 80008450 <syscalls>
    800024b2:	97ba                	add	a5,a5,a4
    800024b4:	639c                	ld	a5,0(a5)
    800024b6:	c789                	beqz	a5,800024c0 <syscall+0x44>
    p->trapframe->a0 = syscalls[num]();
    800024b8:	9782                	jalr	a5
    800024ba:	06a93823          	sd	a0,112(s2)
    800024be:	a839                	j	800024dc <syscall+0x60>
  } else {
    printf("%d %s: unknown sys call %d\n",
    800024c0:	15848613          	addi	a2,s1,344
    800024c4:	588c                	lw	a1,48(s1)
    800024c6:	00006517          	auipc	a0,0x6
    800024ca:	f5250513          	addi	a0,a0,-174 # 80008418 <states.1813+0x150>
    800024ce:	00004097          	auipc	ra,0x4
    800024d2:	fbc080e7          	jalr	-68(ra) # 8000648a <printf>
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
    800024d6:	6cbc                	ld	a5,88(s1)
    800024d8:	577d                	li	a4,-1
    800024da:	fbb8                	sd	a4,112(a5)
  }
}
    800024dc:	60e2                	ld	ra,24(sp)
    800024de:	6442                	ld	s0,16(sp)
    800024e0:	64a2                	ld	s1,8(sp)
    800024e2:	6902                	ld	s2,0(sp)
    800024e4:	6105                	addi	sp,sp,32
    800024e6:	8082                	ret

00000000800024e8 <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    800024e8:	1101                	addi	sp,sp,-32
    800024ea:	ec06                	sd	ra,24(sp)
    800024ec:	e822                	sd	s0,16(sp)
    800024ee:	1000                	addi	s0,sp,32
  int n;
  if(argint(0, &n) < 0)
    800024f0:	fec40593          	addi	a1,s0,-20
    800024f4:	4501                	li	a0,0
    800024f6:	00000097          	auipc	ra,0x0
    800024fa:	f12080e7          	jalr	-238(ra) # 80002408 <argint>
    return -1;
    800024fe:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    80002500:	00054963          	bltz	a0,80002512 <sys_exit+0x2a>
  exit(n);
    80002504:	fec42503          	lw	a0,-20(s0)
    80002508:	fffff097          	auipc	ra,0xfffff
    8000250c:	74e080e7          	jalr	1870(ra) # 80001c56 <exit>
  return 0;  // not reached
    80002510:	4781                	li	a5,0
}
    80002512:	853e                	mv	a0,a5
    80002514:	60e2                	ld	ra,24(sp)
    80002516:	6442                	ld	s0,16(sp)
    80002518:	6105                	addi	sp,sp,32
    8000251a:	8082                	ret

000000008000251c <sys_getpid>:

uint64
sys_getpid(void)
{
    8000251c:	1141                	addi	sp,sp,-16
    8000251e:	e406                	sd	ra,8(sp)
    80002520:	e022                	sd	s0,0(sp)
    80002522:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80002524:	fffff097          	auipc	ra,0xfffff
    80002528:	e1a080e7          	jalr	-486(ra) # 8000133e <myproc>
}
    8000252c:	5908                	lw	a0,48(a0)
    8000252e:	60a2                	ld	ra,8(sp)
    80002530:	6402                	ld	s0,0(sp)
    80002532:	0141                	addi	sp,sp,16
    80002534:	8082                	ret

0000000080002536 <sys_fork>:

uint64
sys_fork(void)
{
    80002536:	1141                	addi	sp,sp,-16
    80002538:	e406                	sd	ra,8(sp)
    8000253a:	e022                	sd	s0,0(sp)
    8000253c:	0800                	addi	s0,sp,16
  return fork();
    8000253e:	fffff097          	auipc	ra,0xfffff
    80002542:	1ce080e7          	jalr	462(ra) # 8000170c <fork>
}
    80002546:	60a2                	ld	ra,8(sp)
    80002548:	6402                	ld	s0,0(sp)
    8000254a:	0141                	addi	sp,sp,16
    8000254c:	8082                	ret

000000008000254e <sys_wait>:

uint64
sys_wait(void)
{
    8000254e:	1101                	addi	sp,sp,-32
    80002550:	ec06                	sd	ra,24(sp)
    80002552:	e822                	sd	s0,16(sp)
    80002554:	1000                	addi	s0,sp,32
  uint64 p;
  if(argaddr(0, &p) < 0)
    80002556:	fe840593          	addi	a1,s0,-24
    8000255a:	4501                	li	a0,0
    8000255c:	00000097          	auipc	ra,0x0
    80002560:	ece080e7          	jalr	-306(ra) # 8000242a <argaddr>
    80002564:	87aa                	mv	a5,a0
    return -1;
    80002566:	557d                	li	a0,-1
  if(argaddr(0, &p) < 0)
    80002568:	0007c863          	bltz	a5,80002578 <sys_wait+0x2a>
  return wait(p);
    8000256c:	fe843503          	ld	a0,-24(s0)
    80002570:	fffff097          	auipc	ra,0xfffff
    80002574:	4ee080e7          	jalr	1262(ra) # 80001a5e <wait>
}
    80002578:	60e2                	ld	ra,24(sp)
    8000257a:	6442                	ld	s0,16(sp)
    8000257c:	6105                	addi	sp,sp,32
    8000257e:	8082                	ret

0000000080002580 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80002580:	7179                	addi	sp,sp,-48
    80002582:	f406                	sd	ra,40(sp)
    80002584:	f022                	sd	s0,32(sp)
    80002586:	ec26                	sd	s1,24(sp)
    80002588:	1800                	addi	s0,sp,48
  int addr;
  int n;

  if(argint(0, &n) < 0)
    8000258a:	fdc40593          	addi	a1,s0,-36
    8000258e:	4501                	li	a0,0
    80002590:	00000097          	auipc	ra,0x0
    80002594:	e78080e7          	jalr	-392(ra) # 80002408 <argint>
    80002598:	87aa                	mv	a5,a0
    return -1;
    8000259a:	557d                	li	a0,-1
  if(argint(0, &n) < 0)
    8000259c:	0207c063          	bltz	a5,800025bc <sys_sbrk+0x3c>
  
  addr = myproc()->sz;
    800025a0:	fffff097          	auipc	ra,0xfffff
    800025a4:	d9e080e7          	jalr	-610(ra) # 8000133e <myproc>
    800025a8:	4524                	lw	s1,72(a0)
  if(growproc(n) < 0)
    800025aa:	fdc42503          	lw	a0,-36(s0)
    800025ae:	fffff097          	auipc	ra,0xfffff
    800025b2:	0ea080e7          	jalr	234(ra) # 80001698 <growproc>
    800025b6:	00054863          	bltz	a0,800025c6 <sys_sbrk+0x46>
    return -1;
  return addr;
    800025ba:	8526                	mv	a0,s1
}
    800025bc:	70a2                	ld	ra,40(sp)
    800025be:	7402                	ld	s0,32(sp)
    800025c0:	64e2                	ld	s1,24(sp)
    800025c2:	6145                	addi	sp,sp,48
    800025c4:	8082                	ret
    return -1;
    800025c6:	557d                	li	a0,-1
    800025c8:	bfd5                	j	800025bc <sys_sbrk+0x3c>

00000000800025ca <sys_sleep>:

uint64
sys_sleep(void)
{
    800025ca:	7139                	addi	sp,sp,-64
    800025cc:	fc06                	sd	ra,56(sp)
    800025ce:	f822                	sd	s0,48(sp)
    800025d0:	f426                	sd	s1,40(sp)
    800025d2:	f04a                	sd	s2,32(sp)
    800025d4:	ec4e                	sd	s3,24(sp)
    800025d6:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;


  if(argint(0, &n) < 0)
    800025d8:	fcc40593          	addi	a1,s0,-52
    800025dc:	4501                	li	a0,0
    800025de:	00000097          	auipc	ra,0x0
    800025e2:	e2a080e7          	jalr	-470(ra) # 80002408 <argint>
    return -1;
    800025e6:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    800025e8:	06054563          	bltz	a0,80002652 <sys_sleep+0x88>
  acquire(&tickslock);
    800025ec:	0000d517          	auipc	a0,0xd
    800025f0:	89450513          	addi	a0,a0,-1900 # 8000ee80 <tickslock>
    800025f4:	00004097          	auipc	ra,0x4
    800025f8:	396080e7          	jalr	918(ra) # 8000698a <acquire>
  ticks0 = ticks;
    800025fc:	00007917          	auipc	s2,0x7
    80002600:	a1c92903          	lw	s2,-1508(s2) # 80009018 <ticks>
  while(ticks - ticks0 < n){
    80002604:	fcc42783          	lw	a5,-52(s0)
    80002608:	cf85                	beqz	a5,80002640 <sys_sleep+0x76>
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    8000260a:	0000d997          	auipc	s3,0xd
    8000260e:	87698993          	addi	s3,s3,-1930 # 8000ee80 <tickslock>
    80002612:	00007497          	auipc	s1,0x7
    80002616:	a0648493          	addi	s1,s1,-1530 # 80009018 <ticks>
    if(myproc()->killed){
    8000261a:	fffff097          	auipc	ra,0xfffff
    8000261e:	d24080e7          	jalr	-732(ra) # 8000133e <myproc>
    80002622:	551c                	lw	a5,40(a0)
    80002624:	ef9d                	bnez	a5,80002662 <sys_sleep+0x98>
    sleep(&ticks, &tickslock);
    80002626:	85ce                	mv	a1,s3
    80002628:	8526                	mv	a0,s1
    8000262a:	fffff097          	auipc	ra,0xfffff
    8000262e:	3d0080e7          	jalr	976(ra) # 800019fa <sleep>
  while(ticks - ticks0 < n){
    80002632:	409c                	lw	a5,0(s1)
    80002634:	412787bb          	subw	a5,a5,s2
    80002638:	fcc42703          	lw	a4,-52(s0)
    8000263c:	fce7efe3          	bltu	a5,a4,8000261a <sys_sleep+0x50>
  }
  release(&tickslock);
    80002640:	0000d517          	auipc	a0,0xd
    80002644:	84050513          	addi	a0,a0,-1984 # 8000ee80 <tickslock>
    80002648:	00004097          	auipc	ra,0x4
    8000264c:	3f6080e7          	jalr	1014(ra) # 80006a3e <release>
  return 0;
    80002650:	4781                	li	a5,0
}
    80002652:	853e                	mv	a0,a5
    80002654:	70e2                	ld	ra,56(sp)
    80002656:	7442                	ld	s0,48(sp)
    80002658:	74a2                	ld	s1,40(sp)
    8000265a:	7902                	ld	s2,32(sp)
    8000265c:	69e2                	ld	s3,24(sp)
    8000265e:	6121                	addi	sp,sp,64
    80002660:	8082                	ret
      release(&tickslock);
    80002662:	0000d517          	auipc	a0,0xd
    80002666:	81e50513          	addi	a0,a0,-2018 # 8000ee80 <tickslock>
    8000266a:	00004097          	auipc	ra,0x4
    8000266e:	3d4080e7          	jalr	980(ra) # 80006a3e <release>
      return -1;
    80002672:	57fd                	li	a5,-1
    80002674:	bff9                	j	80002652 <sys_sleep+0x88>

0000000080002676 <sys_pgaccess>:


#ifdef LAB_PGTBL
int
sys_pgaccess(void)
{
    80002676:	1141                	addi	sp,sp,-16
    80002678:	e422                	sd	s0,8(sp)
    8000267a:	0800                	addi	s0,sp,16
  // lab pgtbl: your code here.
  return 0;
}
    8000267c:	4501                	li	a0,0
    8000267e:	6422                	ld	s0,8(sp)
    80002680:	0141                	addi	sp,sp,16
    80002682:	8082                	ret

0000000080002684 <sys_kill>:
#endif

uint64
sys_kill(void)
{
    80002684:	1101                	addi	sp,sp,-32
    80002686:	ec06                	sd	ra,24(sp)
    80002688:	e822                	sd	s0,16(sp)
    8000268a:	1000                	addi	s0,sp,32
  int pid;

  if(argint(0, &pid) < 0)
    8000268c:	fec40593          	addi	a1,s0,-20
    80002690:	4501                	li	a0,0
    80002692:	00000097          	auipc	ra,0x0
    80002696:	d76080e7          	jalr	-650(ra) # 80002408 <argint>
    8000269a:	87aa                	mv	a5,a0
    return -1;
    8000269c:	557d                	li	a0,-1
  if(argint(0, &pid) < 0)
    8000269e:	0007c863          	bltz	a5,800026ae <sys_kill+0x2a>
  return kill(pid);
    800026a2:	fec42503          	lw	a0,-20(s0)
    800026a6:	fffff097          	auipc	ra,0xfffff
    800026aa:	686080e7          	jalr	1670(ra) # 80001d2c <kill>
}
    800026ae:	60e2                	ld	ra,24(sp)
    800026b0:	6442                	ld	s0,16(sp)
    800026b2:	6105                	addi	sp,sp,32
    800026b4:	8082                	ret

00000000800026b6 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    800026b6:	1101                	addi	sp,sp,-32
    800026b8:	ec06                	sd	ra,24(sp)
    800026ba:	e822                	sd	s0,16(sp)
    800026bc:	e426                	sd	s1,8(sp)
    800026be:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    800026c0:	0000c517          	auipc	a0,0xc
    800026c4:	7c050513          	addi	a0,a0,1984 # 8000ee80 <tickslock>
    800026c8:	00004097          	auipc	ra,0x4
    800026cc:	2c2080e7          	jalr	706(ra) # 8000698a <acquire>
  xticks = ticks;
    800026d0:	00007497          	auipc	s1,0x7
    800026d4:	9484a483          	lw	s1,-1720(s1) # 80009018 <ticks>
  release(&tickslock);
    800026d8:	0000c517          	auipc	a0,0xc
    800026dc:	7a850513          	addi	a0,a0,1960 # 8000ee80 <tickslock>
    800026e0:	00004097          	auipc	ra,0x4
    800026e4:	35e080e7          	jalr	862(ra) # 80006a3e <release>
  return xticks;
}
    800026e8:	02049513          	slli	a0,s1,0x20
    800026ec:	9101                	srli	a0,a0,0x20
    800026ee:	60e2                	ld	ra,24(sp)
    800026f0:	6442                	ld	s0,16(sp)
    800026f2:	64a2                	ld	s1,8(sp)
    800026f4:	6105                	addi	sp,sp,32
    800026f6:	8082                	ret

00000000800026f8 <bget>:
// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return locked buffer.
static struct buf*
bget(uint dev, uint blockno)
{
    800026f8:	7179                	addi	sp,sp,-48
    800026fa:	f406                	sd	ra,40(sp)
    800026fc:	f022                	sd	s0,32(sp)
    800026fe:	ec26                	sd	s1,24(sp)
    80002700:	e84a                	sd	s2,16(sp)
    80002702:	e44e                	sd	s3,8(sp)
    80002704:	1800                	addi	s0,sp,48
    80002706:	892a                	mv	s2,a0
    80002708:	89ae                	mv	s3,a1
  struct buf *b;

  acquire(&bcache.lock);
    8000270a:	0000c517          	auipc	a0,0xc
    8000270e:	78e50513          	addi	a0,a0,1934 # 8000ee98 <bcache>
    80002712:	00004097          	auipc	ra,0x4
    80002716:	278080e7          	jalr	632(ra) # 8000698a <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    8000271a:	00015497          	auipc	s1,0x15
    8000271e:	a364b483          	ld	s1,-1482(s1) # 80017150 <bcache+0x82b8>
    80002722:	00015797          	auipc	a5,0x15
    80002726:	9de78793          	addi	a5,a5,-1570 # 80017100 <bcache+0x8268>
    8000272a:	02f48f63          	beq	s1,a5,80002768 <bget+0x70>
    8000272e:	873e                	mv	a4,a5
    80002730:	a021                	j	80002738 <bget+0x40>
    80002732:	68a4                	ld	s1,80(s1)
    80002734:	02e48a63          	beq	s1,a4,80002768 <bget+0x70>
    if(b->dev == dev && b->blockno == blockno){
    80002738:	449c                	lw	a5,8(s1)
    8000273a:	ff279ce3          	bne	a5,s2,80002732 <bget+0x3a>
    8000273e:	44dc                	lw	a5,12(s1)
    80002740:	ff3799e3          	bne	a5,s3,80002732 <bget+0x3a>
      b->refcnt++;
    80002744:	40bc                	lw	a5,64(s1)
    80002746:	2785                	addiw	a5,a5,1
    80002748:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    8000274a:	0000c517          	auipc	a0,0xc
    8000274e:	74e50513          	addi	a0,a0,1870 # 8000ee98 <bcache>
    80002752:	00004097          	auipc	ra,0x4
    80002756:	2ec080e7          	jalr	748(ra) # 80006a3e <release>
      acquiresleep(&b->lock);
    8000275a:	01048513          	addi	a0,s1,16
    8000275e:	00001097          	auipc	ra,0x1
    80002762:	736080e7          	jalr	1846(ra) # 80003e94 <acquiresleep>
      return b;
    80002766:	a8b9                	j	800027c4 <bget+0xcc>
    }
  }

  // Not cached.
  // Recycle the least recently used (LRU) unused buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80002768:	00015497          	auipc	s1,0x15
    8000276c:	9e04b483          	ld	s1,-1568(s1) # 80017148 <bcache+0x82b0>
    80002770:	00015797          	auipc	a5,0x15
    80002774:	99078793          	addi	a5,a5,-1648 # 80017100 <bcache+0x8268>
    80002778:	00f48863          	beq	s1,a5,80002788 <bget+0x90>
    8000277c:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    8000277e:	40bc                	lw	a5,64(s1)
    80002780:	cf81                	beqz	a5,80002798 <bget+0xa0>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80002782:	64a4                	ld	s1,72(s1)
    80002784:	fee49de3          	bne	s1,a4,8000277e <bget+0x86>
      release(&bcache.lock);
      acquiresleep(&b->lock);
      return b;
    }
  }
  panic("bget: no buffers");
    80002788:	00006517          	auipc	a0,0x6
    8000278c:	dd050513          	addi	a0,a0,-560 # 80008558 <syscalls+0x108>
    80002790:	00004097          	auipc	ra,0x4
    80002794:	cb0080e7          	jalr	-848(ra) # 80006440 <panic>
      b->dev = dev;
    80002798:	0124a423          	sw	s2,8(s1)
      b->blockno = blockno;
    8000279c:	0134a623          	sw	s3,12(s1)
      b->valid = 0;
    800027a0:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    800027a4:	4785                	li	a5,1
    800027a6:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    800027a8:	0000c517          	auipc	a0,0xc
    800027ac:	6f050513          	addi	a0,a0,1776 # 8000ee98 <bcache>
    800027b0:	00004097          	auipc	ra,0x4
    800027b4:	28e080e7          	jalr	654(ra) # 80006a3e <release>
      acquiresleep(&b->lock);
    800027b8:	01048513          	addi	a0,s1,16
    800027bc:	00001097          	auipc	ra,0x1
    800027c0:	6d8080e7          	jalr	1752(ra) # 80003e94 <acquiresleep>
}
    800027c4:	8526                	mv	a0,s1
    800027c6:	70a2                	ld	ra,40(sp)
    800027c8:	7402                	ld	s0,32(sp)
    800027ca:	64e2                	ld	s1,24(sp)
    800027cc:	6942                	ld	s2,16(sp)
    800027ce:	69a2                	ld	s3,8(sp)
    800027d0:	6145                	addi	sp,sp,48
    800027d2:	8082                	ret

00000000800027d4 <binit>:
{
    800027d4:	7179                	addi	sp,sp,-48
    800027d6:	f406                	sd	ra,40(sp)
    800027d8:	f022                	sd	s0,32(sp)
    800027da:	ec26                	sd	s1,24(sp)
    800027dc:	e84a                	sd	s2,16(sp)
    800027de:	e44e                	sd	s3,8(sp)
    800027e0:	e052                	sd	s4,0(sp)
    800027e2:	1800                	addi	s0,sp,48
  initlock(&bcache.lock, "bcache");
    800027e4:	00006597          	auipc	a1,0x6
    800027e8:	d8c58593          	addi	a1,a1,-628 # 80008570 <syscalls+0x120>
    800027ec:	0000c517          	auipc	a0,0xc
    800027f0:	6ac50513          	addi	a0,a0,1708 # 8000ee98 <bcache>
    800027f4:	00004097          	auipc	ra,0x4
    800027f8:	106080e7          	jalr	262(ra) # 800068fa <initlock>
  bcache.head.prev = &bcache.head;
    800027fc:	00014797          	auipc	a5,0x14
    80002800:	69c78793          	addi	a5,a5,1692 # 80016e98 <bcache+0x8000>
    80002804:	00015717          	auipc	a4,0x15
    80002808:	8fc70713          	addi	a4,a4,-1796 # 80017100 <bcache+0x8268>
    8000280c:	2ae7b823          	sd	a4,688(a5)
  bcache.head.next = &bcache.head;
    80002810:	2ae7bc23          	sd	a4,696(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80002814:	0000c497          	auipc	s1,0xc
    80002818:	69c48493          	addi	s1,s1,1692 # 8000eeb0 <bcache+0x18>
    b->next = bcache.head.next;
    8000281c:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    8000281e:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    80002820:	00006a17          	auipc	s4,0x6
    80002824:	d58a0a13          	addi	s4,s4,-680 # 80008578 <syscalls+0x128>
    b->next = bcache.head.next;
    80002828:	2b893783          	ld	a5,696(s2)
    8000282c:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    8000282e:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    80002832:	85d2                	mv	a1,s4
    80002834:	01048513          	addi	a0,s1,16
    80002838:	00001097          	auipc	ra,0x1
    8000283c:	622080e7          	jalr	1570(ra) # 80003e5a <initsleeplock>
    bcache.head.next->prev = b;
    80002840:	2b893783          	ld	a5,696(s2)
    80002844:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    80002846:	2a993c23          	sd	s1,696(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    8000284a:	45848493          	addi	s1,s1,1112
    8000284e:	fd349de3          	bne	s1,s3,80002828 <binit+0x54>
}
    80002852:	70a2                	ld	ra,40(sp)
    80002854:	7402                	ld	s0,32(sp)
    80002856:	64e2                	ld	s1,24(sp)
    80002858:	6942                	ld	s2,16(sp)
    8000285a:	69a2                	ld	s3,8(sp)
    8000285c:	6a02                	ld	s4,0(sp)
    8000285e:	6145                	addi	sp,sp,48
    80002860:	8082                	ret

0000000080002862 <bread>:

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    80002862:	1101                	addi	sp,sp,-32
    80002864:	ec06                	sd	ra,24(sp)
    80002866:	e822                	sd	s0,16(sp)
    80002868:	e426                	sd	s1,8(sp)
    8000286a:	1000                	addi	s0,sp,32
  struct buf *b;

  b = bget(dev, blockno);
    8000286c:	00000097          	auipc	ra,0x0
    80002870:	e8c080e7          	jalr	-372(ra) # 800026f8 <bget>
    80002874:	84aa                	mv	s1,a0
  if(!b->valid) {
    80002876:	411c                	lw	a5,0(a0)
    80002878:	c799                	beqz	a5,80002886 <bread+0x24>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    8000287a:	8526                	mv	a0,s1
    8000287c:	60e2                	ld	ra,24(sp)
    8000287e:	6442                	ld	s0,16(sp)
    80002880:	64a2                	ld	s1,8(sp)
    80002882:	6105                	addi	sp,sp,32
    80002884:	8082                	ret
    virtio_disk_rw(b, 0);
    80002886:	4581                	li	a1,0
    80002888:	00003097          	auipc	ra,0x3
    8000288c:	12e080e7          	jalr	302(ra) # 800059b6 <virtio_disk_rw>
    b->valid = 1;
    80002890:	4785                	li	a5,1
    80002892:	c09c                	sw	a5,0(s1)
  return b;
    80002894:	b7dd                	j	8000287a <bread+0x18>

0000000080002896 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    80002896:	1101                	addi	sp,sp,-32
    80002898:	ec06                	sd	ra,24(sp)
    8000289a:	e822                	sd	s0,16(sp)
    8000289c:	e426                	sd	s1,8(sp)
    8000289e:	1000                	addi	s0,sp,32
    800028a0:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    800028a2:	0541                	addi	a0,a0,16
    800028a4:	00001097          	auipc	ra,0x1
    800028a8:	68a080e7          	jalr	1674(ra) # 80003f2e <holdingsleep>
    800028ac:	cd01                	beqz	a0,800028c4 <bwrite+0x2e>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    800028ae:	4585                	li	a1,1
    800028b0:	8526                	mv	a0,s1
    800028b2:	00003097          	auipc	ra,0x3
    800028b6:	104080e7          	jalr	260(ra) # 800059b6 <virtio_disk_rw>
}
    800028ba:	60e2                	ld	ra,24(sp)
    800028bc:	6442                	ld	s0,16(sp)
    800028be:	64a2                	ld	s1,8(sp)
    800028c0:	6105                	addi	sp,sp,32
    800028c2:	8082                	ret
    panic("bwrite");
    800028c4:	00006517          	auipc	a0,0x6
    800028c8:	cbc50513          	addi	a0,a0,-836 # 80008580 <syscalls+0x130>
    800028cc:	00004097          	auipc	ra,0x4
    800028d0:	b74080e7          	jalr	-1164(ra) # 80006440 <panic>

00000000800028d4 <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    800028d4:	1101                	addi	sp,sp,-32
    800028d6:	ec06                	sd	ra,24(sp)
    800028d8:	e822                	sd	s0,16(sp)
    800028da:	e426                	sd	s1,8(sp)
    800028dc:	e04a                	sd	s2,0(sp)
    800028de:	1000                	addi	s0,sp,32
    800028e0:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    800028e2:	01050913          	addi	s2,a0,16
    800028e6:	854a                	mv	a0,s2
    800028e8:	00001097          	auipc	ra,0x1
    800028ec:	646080e7          	jalr	1606(ra) # 80003f2e <holdingsleep>
    800028f0:	c92d                	beqz	a0,80002962 <brelse+0x8e>
    panic("brelse");

  releasesleep(&b->lock);
    800028f2:	854a                	mv	a0,s2
    800028f4:	00001097          	auipc	ra,0x1
    800028f8:	5f6080e7          	jalr	1526(ra) # 80003eea <releasesleep>

  acquire(&bcache.lock);
    800028fc:	0000c517          	auipc	a0,0xc
    80002900:	59c50513          	addi	a0,a0,1436 # 8000ee98 <bcache>
    80002904:	00004097          	auipc	ra,0x4
    80002908:	086080e7          	jalr	134(ra) # 8000698a <acquire>
  b->refcnt--;
    8000290c:	40bc                	lw	a5,64(s1)
    8000290e:	37fd                	addiw	a5,a5,-1
    80002910:	0007871b          	sext.w	a4,a5
    80002914:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    80002916:	eb05                	bnez	a4,80002946 <brelse+0x72>
    // no one is waiting for it.
    b->next->prev = b->prev;
    80002918:	68bc                	ld	a5,80(s1)
    8000291a:	64b8                	ld	a4,72(s1)
    8000291c:	e7b8                	sd	a4,72(a5)
    b->prev->next = b->next;
    8000291e:	64bc                	ld	a5,72(s1)
    80002920:	68b8                	ld	a4,80(s1)
    80002922:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    80002924:	00014797          	auipc	a5,0x14
    80002928:	57478793          	addi	a5,a5,1396 # 80016e98 <bcache+0x8000>
    8000292c:	2b87b703          	ld	a4,696(a5)
    80002930:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    80002932:	00014717          	auipc	a4,0x14
    80002936:	7ce70713          	addi	a4,a4,1998 # 80017100 <bcache+0x8268>
    8000293a:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    8000293c:	2b87b703          	ld	a4,696(a5)
    80002940:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    80002942:	2a97bc23          	sd	s1,696(a5)
  }

  release(&bcache.lock);
    80002946:	0000c517          	auipc	a0,0xc
    8000294a:	55250513          	addi	a0,a0,1362 # 8000ee98 <bcache>
    8000294e:	00004097          	auipc	ra,0x4
    80002952:	0f0080e7          	jalr	240(ra) # 80006a3e <release>
}
    80002956:	60e2                	ld	ra,24(sp)
    80002958:	6442                	ld	s0,16(sp)
    8000295a:	64a2                	ld	s1,8(sp)
    8000295c:	6902                	ld	s2,0(sp)
    8000295e:	6105                	addi	sp,sp,32
    80002960:	8082                	ret
    panic("brelse");
    80002962:	00006517          	auipc	a0,0x6
    80002966:	c2650513          	addi	a0,a0,-986 # 80008588 <syscalls+0x138>
    8000296a:	00004097          	auipc	ra,0x4
    8000296e:	ad6080e7          	jalr	-1322(ra) # 80006440 <panic>

0000000080002972 <bpin>:

void
bpin(struct buf *b) {
    80002972:	1101                	addi	sp,sp,-32
    80002974:	ec06                	sd	ra,24(sp)
    80002976:	e822                	sd	s0,16(sp)
    80002978:	e426                	sd	s1,8(sp)
    8000297a:	1000                	addi	s0,sp,32
    8000297c:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    8000297e:	0000c517          	auipc	a0,0xc
    80002982:	51a50513          	addi	a0,a0,1306 # 8000ee98 <bcache>
    80002986:	00004097          	auipc	ra,0x4
    8000298a:	004080e7          	jalr	4(ra) # 8000698a <acquire>
  b->refcnt++;
    8000298e:	40bc                	lw	a5,64(s1)
    80002990:	2785                	addiw	a5,a5,1
    80002992:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    80002994:	0000c517          	auipc	a0,0xc
    80002998:	50450513          	addi	a0,a0,1284 # 8000ee98 <bcache>
    8000299c:	00004097          	auipc	ra,0x4
    800029a0:	0a2080e7          	jalr	162(ra) # 80006a3e <release>
}
    800029a4:	60e2                	ld	ra,24(sp)
    800029a6:	6442                	ld	s0,16(sp)
    800029a8:	64a2                	ld	s1,8(sp)
    800029aa:	6105                	addi	sp,sp,32
    800029ac:	8082                	ret

00000000800029ae <bunpin>:

void
bunpin(struct buf *b) {
    800029ae:	1101                	addi	sp,sp,-32
    800029b0:	ec06                	sd	ra,24(sp)
    800029b2:	e822                	sd	s0,16(sp)
    800029b4:	e426                	sd	s1,8(sp)
    800029b6:	1000                	addi	s0,sp,32
    800029b8:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    800029ba:	0000c517          	auipc	a0,0xc
    800029be:	4de50513          	addi	a0,a0,1246 # 8000ee98 <bcache>
    800029c2:	00004097          	auipc	ra,0x4
    800029c6:	fc8080e7          	jalr	-56(ra) # 8000698a <acquire>
  b->refcnt--;
    800029ca:	40bc                	lw	a5,64(s1)
    800029cc:	37fd                	addiw	a5,a5,-1
    800029ce:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    800029d0:	0000c517          	auipc	a0,0xc
    800029d4:	4c850513          	addi	a0,a0,1224 # 8000ee98 <bcache>
    800029d8:	00004097          	auipc	ra,0x4
    800029dc:	066080e7          	jalr	102(ra) # 80006a3e <release>
}
    800029e0:	60e2                	ld	ra,24(sp)
    800029e2:	6442                	ld	s0,16(sp)
    800029e4:	64a2                	ld	s1,8(sp)
    800029e6:	6105                	addi	sp,sp,32
    800029e8:	8082                	ret

00000000800029ea <write_page_to_disk>:

/* NTU OS 2024 */
/* Write 4096 bytes page to the eight consecutive 512-byte blocks starting at blk. */
void write_page_to_disk(uint dev, char *page, uint blk) {
    800029ea:	7179                	addi	sp,sp,-48
    800029ec:	f406                	sd	ra,40(sp)
    800029ee:	f022                	sd	s0,32(sp)
    800029f0:	ec26                	sd	s1,24(sp)
    800029f2:	e84a                	sd	s2,16(sp)
    800029f4:	e44e                	sd	s3,8(sp)
    800029f6:	e052                	sd	s4,0(sp)
    800029f8:	1800                	addi	s0,sp,48
    800029fa:	89b2                	mv	s3,a2
  for (int i = 0; i < 8; i++) {
    800029fc:	892e                	mv	s2,a1
    800029fe:	6a05                	lui	s4,0x1
    80002a00:	9a2e                	add	s4,s4,a1
    // disk
    int offset = i * 512;
    int blk_idx = blk + i;
    struct buf *buffer = bget(ROOTDEV, blk_idx);
    80002a02:	85ce                	mv	a1,s3
    80002a04:	4505                	li	a0,1
    80002a06:	00000097          	auipc	ra,0x0
    80002a0a:	cf2080e7          	jalr	-782(ra) # 800026f8 <bget>
    80002a0e:	84aa                	mv	s1,a0
    memmove(buffer->data, page + offset, 512);
    80002a10:	20000613          	li	a2,512
    80002a14:	85ca                	mv	a1,s2
    80002a16:	05850513          	addi	a0,a0,88
    80002a1a:	ffffd097          	auipc	ra,0xffffd
    80002a1e:	7be080e7          	jalr	1982(ra) # 800001d8 <memmove>
    bwrite(buffer);
    80002a22:	8526                	mv	a0,s1
    80002a24:	00000097          	auipc	ra,0x0
    80002a28:	e72080e7          	jalr	-398(ra) # 80002896 <bwrite>
    brelse(buffer);
    80002a2c:	8526                	mv	a0,s1
    80002a2e:	00000097          	auipc	ra,0x0
    80002a32:	ea6080e7          	jalr	-346(ra) # 800028d4 <brelse>
  for (int i = 0; i < 8; i++) {
    80002a36:	2985                	addiw	s3,s3,1
    80002a38:	20090913          	addi	s2,s2,512
    80002a3c:	fd4913e3          	bne	s2,s4,80002a02 <write_page_to_disk+0x18>
  }
}
    80002a40:	70a2                	ld	ra,40(sp)
    80002a42:	7402                	ld	s0,32(sp)
    80002a44:	64e2                	ld	s1,24(sp)
    80002a46:	6942                	ld	s2,16(sp)
    80002a48:	69a2                	ld	s3,8(sp)
    80002a4a:	6a02                	ld	s4,0(sp)
    80002a4c:	6145                	addi	sp,sp,48
    80002a4e:	8082                	ret

0000000080002a50 <read_page_from_disk>:

/* NTU OS 2024 */
/* Read 4096 bytes from the eight consecutive 512-byte blocks starting at blk into page. */
void read_page_from_disk(uint dev, char *page, uint blk) {
    80002a50:	7179                	addi	sp,sp,-48
    80002a52:	f406                	sd	ra,40(sp)
    80002a54:	f022                	sd	s0,32(sp)
    80002a56:	ec26                	sd	s1,24(sp)
    80002a58:	e84a                	sd	s2,16(sp)
    80002a5a:	e44e                	sd	s3,8(sp)
    80002a5c:	e052                	sd	s4,0(sp)
    80002a5e:	1800                	addi	s0,sp,48
    80002a60:	89b2                	mv	s3,a2
  for (int i = 0; i < 8; i++) {
    80002a62:	892e                	mv	s2,a1
    80002a64:	6a05                	lui	s4,0x1
    80002a66:	9a2e                	add	s4,s4,a1
    int offset = i * 512;
    int blk_idx = blk + i;
    struct buf *buffer = bread(ROOTDEV, blk_idx);
    80002a68:	85ce                	mv	a1,s3
    80002a6a:	4505                	li	a0,1
    80002a6c:	00000097          	auipc	ra,0x0
    80002a70:	df6080e7          	jalr	-522(ra) # 80002862 <bread>
    80002a74:	84aa                	mv	s1,a0
    memmove(page + offset, buffer->data, 512);
    80002a76:	20000613          	li	a2,512
    80002a7a:	05850593          	addi	a1,a0,88
    80002a7e:	854a                	mv	a0,s2
    80002a80:	ffffd097          	auipc	ra,0xffffd
    80002a84:	758080e7          	jalr	1880(ra) # 800001d8 <memmove>
    brelse(buffer);
    80002a88:	8526                	mv	a0,s1
    80002a8a:	00000097          	auipc	ra,0x0
    80002a8e:	e4a080e7          	jalr	-438(ra) # 800028d4 <brelse>
  for (int i = 0; i < 8; i++) {
    80002a92:	2985                	addiw	s3,s3,1
    80002a94:	20090913          	addi	s2,s2,512
    80002a98:	fd4918e3          	bne	s2,s4,80002a68 <read_page_from_disk+0x18>
  }
}
    80002a9c:	70a2                	ld	ra,40(sp)
    80002a9e:	7402                	ld	s0,32(sp)
    80002aa0:	64e2                	ld	s1,24(sp)
    80002aa2:	6942                	ld	s2,16(sp)
    80002aa4:	69a2                	ld	s3,8(sp)
    80002aa6:	6a02                	ld	s4,0(sp)
    80002aa8:	6145                	addi	sp,sp,48
    80002aaa:	8082                	ret

0000000080002aac <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    80002aac:	1101                	addi	sp,sp,-32
    80002aae:	ec06                	sd	ra,24(sp)
    80002ab0:	e822                	sd	s0,16(sp)
    80002ab2:	e426                	sd	s1,8(sp)
    80002ab4:	1000                	addi	s0,sp,32
    80002ab6:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    80002ab8:	00d5d59b          	srliw	a1,a1,0xd
    80002abc:	00015797          	auipc	a5,0x15
    80002ac0:	ab87a783          	lw	a5,-1352(a5) # 80017574 <sb+0x1c>
    80002ac4:	9dbd                	addw	a1,a1,a5
    80002ac6:	00000097          	auipc	ra,0x0
    80002aca:	d9c080e7          	jalr	-612(ra) # 80002862 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    80002ace:	0074f713          	andi	a4,s1,7
    80002ad2:	4785                	li	a5,1
    80002ad4:	00e797bb          	sllw	a5,a5,a4
  if((bp->data[bi/8] & m) == 0)
    80002ad8:	14ce                	slli	s1,s1,0x33
    80002ada:	90d9                	srli	s1,s1,0x36
    80002adc:	00950733          	add	a4,a0,s1
    80002ae0:	05874703          	lbu	a4,88(a4)
    80002ae4:	00e7f6b3          	and	a3,a5,a4
    80002ae8:	c285                	beqz	a3,80002b08 <bfree+0x5c>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    80002aea:	94aa                	add	s1,s1,a0
    80002aec:	fff7c793          	not	a5,a5
    80002af0:	8ff9                	and	a5,a5,a4
    80002af2:	04f48c23          	sb	a5,88(s1)
  //log_write(bp);
  brelse(bp);
    80002af6:	00000097          	auipc	ra,0x0
    80002afa:	dde080e7          	jalr	-546(ra) # 800028d4 <brelse>
}
    80002afe:	60e2                	ld	ra,24(sp)
    80002b00:	6442                	ld	s0,16(sp)
    80002b02:	64a2                	ld	s1,8(sp)
    80002b04:	6105                	addi	sp,sp,32
    80002b06:	8082                	ret
    panic("freeing free block");
    80002b08:	00006517          	auipc	a0,0x6
    80002b0c:	a8850513          	addi	a0,a0,-1400 # 80008590 <syscalls+0x140>
    80002b10:	00004097          	auipc	ra,0x4
    80002b14:	930080e7          	jalr	-1744(ra) # 80006440 <panic>

0000000080002b18 <bzero>:
{
    80002b18:	1101                	addi	sp,sp,-32
    80002b1a:	ec06                	sd	ra,24(sp)
    80002b1c:	e822                	sd	s0,16(sp)
    80002b1e:	e426                	sd	s1,8(sp)
    80002b20:	1000                	addi	s0,sp,32
  bp = bread(dev, bno);
    80002b22:	00000097          	auipc	ra,0x0
    80002b26:	d40080e7          	jalr	-704(ra) # 80002862 <bread>
    80002b2a:	84aa                	mv	s1,a0
  memset(bp->data, 0, BSIZE);
    80002b2c:	40000613          	li	a2,1024
    80002b30:	4581                	li	a1,0
    80002b32:	05850513          	addi	a0,a0,88
    80002b36:	ffffd097          	auipc	ra,0xffffd
    80002b3a:	642080e7          	jalr	1602(ra) # 80000178 <memset>
  brelse(bp);
    80002b3e:	8526                	mv	a0,s1
    80002b40:	00000097          	auipc	ra,0x0
    80002b44:	d94080e7          	jalr	-620(ra) # 800028d4 <brelse>
}
    80002b48:	60e2                	ld	ra,24(sp)
    80002b4a:	6442                	ld	s0,16(sp)
    80002b4c:	64a2                	ld	s1,8(sp)
    80002b4e:	6105                	addi	sp,sp,32
    80002b50:	8082                	ret

0000000080002b52 <balloc>:
{
    80002b52:	711d                	addi	sp,sp,-96
    80002b54:	ec86                	sd	ra,88(sp)
    80002b56:	e8a2                	sd	s0,80(sp)
    80002b58:	e4a6                	sd	s1,72(sp)
    80002b5a:	e0ca                	sd	s2,64(sp)
    80002b5c:	fc4e                	sd	s3,56(sp)
    80002b5e:	f852                	sd	s4,48(sp)
    80002b60:	f456                	sd	s5,40(sp)
    80002b62:	f05a                	sd	s6,32(sp)
    80002b64:	ec5e                	sd	s7,24(sp)
    80002b66:	e862                	sd	s8,16(sp)
    80002b68:	e466                	sd	s9,8(sp)
    80002b6a:	1080                	addi	s0,sp,96
  for(b = 0; b < sb.size; b += BPB){
    80002b6c:	00015797          	auipc	a5,0x15
    80002b70:	9f07a783          	lw	a5,-1552(a5) # 8001755c <sb+0x4>
    80002b74:	cbd1                	beqz	a5,80002c08 <balloc+0xb6>
    80002b76:	8baa                	mv	s7,a0
    80002b78:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    80002b7a:	00015b17          	auipc	s6,0x15
    80002b7e:	9deb0b13          	addi	s6,s6,-1570 # 80017558 <sb>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002b82:	4c01                	li	s8,0
      m = 1 << (bi % 8);
    80002b84:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002b86:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    80002b88:	6c89                	lui	s9,0x2
    80002b8a:	a829                	j	80002ba4 <balloc+0x52>
    brelse(bp);
    80002b8c:	00000097          	auipc	ra,0x0
    80002b90:	d48080e7          	jalr	-696(ra) # 800028d4 <brelse>
  for(b = 0; b < sb.size; b += BPB){
    80002b94:	015c87bb          	addw	a5,s9,s5
    80002b98:	00078a9b          	sext.w	s5,a5
    80002b9c:	004b2703          	lw	a4,4(s6)
    80002ba0:	06eaf463          	bgeu	s5,a4,80002c08 <balloc+0xb6>
    bp = bread(dev, BBLOCK(b, sb));
    80002ba4:	41fad79b          	sraiw	a5,s5,0x1f
    80002ba8:	0137d79b          	srliw	a5,a5,0x13
    80002bac:	015787bb          	addw	a5,a5,s5
    80002bb0:	40d7d79b          	sraiw	a5,a5,0xd
    80002bb4:	01cb2583          	lw	a1,28(s6)
    80002bb8:	9dbd                	addw	a1,a1,a5
    80002bba:	855e                	mv	a0,s7
    80002bbc:	00000097          	auipc	ra,0x0
    80002bc0:	ca6080e7          	jalr	-858(ra) # 80002862 <bread>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002bc4:	004b2803          	lw	a6,4(s6)
    80002bc8:	000a849b          	sext.w	s1,s5
    80002bcc:	8662                	mv	a2,s8
    80002bce:	0004891b          	sext.w	s2,s1
    80002bd2:	fb04fde3          	bgeu	s1,a6,80002b8c <balloc+0x3a>
      m = 1 << (bi % 8);
    80002bd6:	41f6579b          	sraiw	a5,a2,0x1f
    80002bda:	01d7d69b          	srliw	a3,a5,0x1d
    80002bde:	00c6873b          	addw	a4,a3,a2
    80002be2:	00777793          	andi	a5,a4,7
    80002be6:	9f95                	subw	a5,a5,a3
    80002be8:	00f997bb          	sllw	a5,s3,a5
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    80002bec:	4037571b          	sraiw	a4,a4,0x3
    80002bf0:	00e506b3          	add	a3,a0,a4
    80002bf4:	0586c683          	lbu	a3,88(a3)
    80002bf8:	00d7f5b3          	and	a1,a5,a3
    80002bfc:	cd91                	beqz	a1,80002c18 <balloc+0xc6>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002bfe:	2605                	addiw	a2,a2,1
    80002c00:	2485                	addiw	s1,s1,1
    80002c02:	fd4616e3          	bne	a2,s4,80002bce <balloc+0x7c>
    80002c06:	b759                	j	80002b8c <balloc+0x3a>
  panic("balloc: out of blocks");
    80002c08:	00006517          	auipc	a0,0x6
    80002c0c:	9a050513          	addi	a0,a0,-1632 # 800085a8 <syscalls+0x158>
    80002c10:	00004097          	auipc	ra,0x4
    80002c14:	830080e7          	jalr	-2000(ra) # 80006440 <panic>
        bp->data[bi/8] |= m;  // Mark block in use.
    80002c18:	972a                	add	a4,a4,a0
    80002c1a:	8fd5                	or	a5,a5,a3
    80002c1c:	04f70c23          	sb	a5,88(a4)
        brelse(bp);
    80002c20:	00000097          	auipc	ra,0x0
    80002c24:	cb4080e7          	jalr	-844(ra) # 800028d4 <brelse>
        bzero(dev, b + bi);
    80002c28:	85ca                	mv	a1,s2
    80002c2a:	855e                	mv	a0,s7
    80002c2c:	00000097          	auipc	ra,0x0
    80002c30:	eec080e7          	jalr	-276(ra) # 80002b18 <bzero>
}
    80002c34:	8526                	mv	a0,s1
    80002c36:	60e6                	ld	ra,88(sp)
    80002c38:	6446                	ld	s0,80(sp)
    80002c3a:	64a6                	ld	s1,72(sp)
    80002c3c:	6906                	ld	s2,64(sp)
    80002c3e:	79e2                	ld	s3,56(sp)
    80002c40:	7a42                	ld	s4,48(sp)
    80002c42:	7aa2                	ld	s5,40(sp)
    80002c44:	7b02                	ld	s6,32(sp)
    80002c46:	6be2                	ld	s7,24(sp)
    80002c48:	6c42                	ld	s8,16(sp)
    80002c4a:	6ca2                	ld	s9,8(sp)
    80002c4c:	6125                	addi	sp,sp,96
    80002c4e:	8082                	ret

0000000080002c50 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
    80002c50:	7179                	addi	sp,sp,-48
    80002c52:	f406                	sd	ra,40(sp)
    80002c54:	f022                	sd	s0,32(sp)
    80002c56:	ec26                	sd	s1,24(sp)
    80002c58:	e84a                	sd	s2,16(sp)
    80002c5a:	e44e                	sd	s3,8(sp)
    80002c5c:	e052                	sd	s4,0(sp)
    80002c5e:	1800                	addi	s0,sp,48
    80002c60:	892a                	mv	s2,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    80002c62:	47ad                	li	a5,11
    80002c64:	04b7fe63          	bgeu	a5,a1,80002cc0 <bmap+0x70>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
    80002c68:	ff45849b          	addiw	s1,a1,-12
    80002c6c:	0004871b          	sext.w	a4,s1

  if(bn < NINDIRECT){
    80002c70:	0ff00793          	li	a5,255
    80002c74:	08e7ee63          	bltu	a5,a4,80002d10 <bmap+0xc0>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
    80002c78:	08052583          	lw	a1,128(a0)
    80002c7c:	c5ad                	beqz	a1,80002ce6 <bmap+0x96>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    80002c7e:	00092503          	lw	a0,0(s2)
    80002c82:	00000097          	auipc	ra,0x0
    80002c86:	be0080e7          	jalr	-1056(ra) # 80002862 <bread>
    80002c8a:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    80002c8c:	05850793          	addi	a5,a0,88
    if((addr = a[bn]) == 0){
    80002c90:	02049593          	slli	a1,s1,0x20
    80002c94:	9181                	srli	a1,a1,0x20
    80002c96:	058a                	slli	a1,a1,0x2
    80002c98:	00b784b3          	add	s1,a5,a1
    80002c9c:	0004a983          	lw	s3,0(s1)
    80002ca0:	04098d63          	beqz	s3,80002cfa <bmap+0xaa>
      a[bn] = addr = balloc(ip->dev);
      //log_write(bp);
    }
    brelse(bp);
    80002ca4:	8552                	mv	a0,s4
    80002ca6:	00000097          	auipc	ra,0x0
    80002caa:	c2e080e7          	jalr	-978(ra) # 800028d4 <brelse>
    return addr;
  }

  panic("bmap: out of range");
}
    80002cae:	854e                	mv	a0,s3
    80002cb0:	70a2                	ld	ra,40(sp)
    80002cb2:	7402                	ld	s0,32(sp)
    80002cb4:	64e2                	ld	s1,24(sp)
    80002cb6:	6942                	ld	s2,16(sp)
    80002cb8:	69a2                	ld	s3,8(sp)
    80002cba:	6a02                	ld	s4,0(sp)
    80002cbc:	6145                	addi	sp,sp,48
    80002cbe:	8082                	ret
    if((addr = ip->addrs[bn]) == 0)
    80002cc0:	02059493          	slli	s1,a1,0x20
    80002cc4:	9081                	srli	s1,s1,0x20
    80002cc6:	048a                	slli	s1,s1,0x2
    80002cc8:	94aa                	add	s1,s1,a0
    80002cca:	0504a983          	lw	s3,80(s1)
    80002cce:	fe0990e3          	bnez	s3,80002cae <bmap+0x5e>
      ip->addrs[bn] = addr = balloc(ip->dev);
    80002cd2:	4108                	lw	a0,0(a0)
    80002cd4:	00000097          	auipc	ra,0x0
    80002cd8:	e7e080e7          	jalr	-386(ra) # 80002b52 <balloc>
    80002cdc:	0005099b          	sext.w	s3,a0
    80002ce0:	0534a823          	sw	s3,80(s1)
    80002ce4:	b7e9                	j	80002cae <bmap+0x5e>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    80002ce6:	4108                	lw	a0,0(a0)
    80002ce8:	00000097          	auipc	ra,0x0
    80002cec:	e6a080e7          	jalr	-406(ra) # 80002b52 <balloc>
    80002cf0:	0005059b          	sext.w	a1,a0
    80002cf4:	08b92023          	sw	a1,128(s2)
    80002cf8:	b759                	j	80002c7e <bmap+0x2e>
      a[bn] = addr = balloc(ip->dev);
    80002cfa:	00092503          	lw	a0,0(s2)
    80002cfe:	00000097          	auipc	ra,0x0
    80002d02:	e54080e7          	jalr	-428(ra) # 80002b52 <balloc>
    80002d06:	0005099b          	sext.w	s3,a0
    80002d0a:	0134a023          	sw	s3,0(s1)
    80002d0e:	bf59                	j	80002ca4 <bmap+0x54>
  panic("bmap: out of range");
    80002d10:	00006517          	auipc	a0,0x6
    80002d14:	8b050513          	addi	a0,a0,-1872 # 800085c0 <syscalls+0x170>
    80002d18:	00003097          	auipc	ra,0x3
    80002d1c:	728080e7          	jalr	1832(ra) # 80006440 <panic>

0000000080002d20 <iget>:
{
    80002d20:	7179                	addi	sp,sp,-48
    80002d22:	f406                	sd	ra,40(sp)
    80002d24:	f022                	sd	s0,32(sp)
    80002d26:	ec26                	sd	s1,24(sp)
    80002d28:	e84a                	sd	s2,16(sp)
    80002d2a:	e44e                	sd	s3,8(sp)
    80002d2c:	e052                	sd	s4,0(sp)
    80002d2e:	1800                	addi	s0,sp,48
    80002d30:	89aa                	mv	s3,a0
    80002d32:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    80002d34:	00015517          	auipc	a0,0x15
    80002d38:	84450513          	addi	a0,a0,-1980 # 80017578 <itable>
    80002d3c:	00004097          	auipc	ra,0x4
    80002d40:	c4e080e7          	jalr	-946(ra) # 8000698a <acquire>
  empty = 0;
    80002d44:	4901                	li	s2,0
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80002d46:	00015497          	auipc	s1,0x15
    80002d4a:	84a48493          	addi	s1,s1,-1974 # 80017590 <itable+0x18>
    80002d4e:	00016697          	auipc	a3,0x16
    80002d52:	2d268693          	addi	a3,a3,722 # 80019020 <log>
    80002d56:	a039                	j	80002d64 <iget+0x44>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80002d58:	02090b63          	beqz	s2,80002d8e <iget+0x6e>
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80002d5c:	08848493          	addi	s1,s1,136
    80002d60:	02d48a63          	beq	s1,a3,80002d94 <iget+0x74>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    80002d64:	449c                	lw	a5,8(s1)
    80002d66:	fef059e3          	blez	a5,80002d58 <iget+0x38>
    80002d6a:	4098                	lw	a4,0(s1)
    80002d6c:	ff3716e3          	bne	a4,s3,80002d58 <iget+0x38>
    80002d70:	40d8                	lw	a4,4(s1)
    80002d72:	ff4713e3          	bne	a4,s4,80002d58 <iget+0x38>
      ip->ref++;
    80002d76:	2785                	addiw	a5,a5,1
    80002d78:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    80002d7a:	00014517          	auipc	a0,0x14
    80002d7e:	7fe50513          	addi	a0,a0,2046 # 80017578 <itable>
    80002d82:	00004097          	auipc	ra,0x4
    80002d86:	cbc080e7          	jalr	-836(ra) # 80006a3e <release>
      return ip;
    80002d8a:	8926                	mv	s2,s1
    80002d8c:	a03d                	j	80002dba <iget+0x9a>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80002d8e:	f7f9                	bnez	a5,80002d5c <iget+0x3c>
    80002d90:	8926                	mv	s2,s1
    80002d92:	b7e9                	j	80002d5c <iget+0x3c>
  if(empty == 0)
    80002d94:	02090c63          	beqz	s2,80002dcc <iget+0xac>
  ip->dev = dev;
    80002d98:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    80002d9c:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    80002da0:	4785                	li	a5,1
    80002da2:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    80002da6:	04092023          	sw	zero,64(s2)
  release(&itable.lock);
    80002daa:	00014517          	auipc	a0,0x14
    80002dae:	7ce50513          	addi	a0,a0,1998 # 80017578 <itable>
    80002db2:	00004097          	auipc	ra,0x4
    80002db6:	c8c080e7          	jalr	-884(ra) # 80006a3e <release>
}
    80002dba:	854a                	mv	a0,s2
    80002dbc:	70a2                	ld	ra,40(sp)
    80002dbe:	7402                	ld	s0,32(sp)
    80002dc0:	64e2                	ld	s1,24(sp)
    80002dc2:	6942                	ld	s2,16(sp)
    80002dc4:	69a2                	ld	s3,8(sp)
    80002dc6:	6a02                	ld	s4,0(sp)
    80002dc8:	6145                	addi	sp,sp,48
    80002dca:	8082                	ret
    panic("iget: no inodes");
    80002dcc:	00006517          	auipc	a0,0x6
    80002dd0:	80c50513          	addi	a0,a0,-2036 # 800085d8 <syscalls+0x188>
    80002dd4:	00003097          	auipc	ra,0x3
    80002dd8:	66c080e7          	jalr	1644(ra) # 80006440 <panic>

0000000080002ddc <fsinit>:
fsinit(int dev) {
    80002ddc:	7179                	addi	sp,sp,-48
    80002dde:	f406                	sd	ra,40(sp)
    80002de0:	f022                	sd	s0,32(sp)
    80002de2:	ec26                	sd	s1,24(sp)
    80002de4:	e84a                	sd	s2,16(sp)
    80002de6:	e44e                	sd	s3,8(sp)
    80002de8:	1800                	addi	s0,sp,48
    80002dea:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    80002dec:	4585                	li	a1,1
    80002dee:	00000097          	auipc	ra,0x0
    80002df2:	a74080e7          	jalr	-1420(ra) # 80002862 <bread>
    80002df6:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    80002df8:	00014997          	auipc	s3,0x14
    80002dfc:	76098993          	addi	s3,s3,1888 # 80017558 <sb>
    80002e00:	02000613          	li	a2,32
    80002e04:	05850593          	addi	a1,a0,88
    80002e08:	854e                	mv	a0,s3
    80002e0a:	ffffd097          	auipc	ra,0xffffd
    80002e0e:	3ce080e7          	jalr	974(ra) # 800001d8 <memmove>
  brelse(bp);
    80002e12:	8526                	mv	a0,s1
    80002e14:	00000097          	auipc	ra,0x0
    80002e18:	ac0080e7          	jalr	-1344(ra) # 800028d4 <brelse>
  if(sb.magic != FSMAGIC)
    80002e1c:	0009a703          	lw	a4,0(s3)
    80002e20:	102037b7          	lui	a5,0x10203
    80002e24:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80002e28:	02f71263          	bne	a4,a5,80002e4c <fsinit+0x70>
  initlog(dev, &sb);
    80002e2c:	00014597          	auipc	a1,0x14
    80002e30:	72c58593          	addi	a1,a1,1836 # 80017558 <sb>
    80002e34:	854a                	mv	a0,s2
    80002e36:	00001097          	auipc	ra,0x1
    80002e3a:	cc2080e7          	jalr	-830(ra) # 80003af8 <initlog>
}
    80002e3e:	70a2                	ld	ra,40(sp)
    80002e40:	7402                	ld	s0,32(sp)
    80002e42:	64e2                	ld	s1,24(sp)
    80002e44:	6942                	ld	s2,16(sp)
    80002e46:	69a2                	ld	s3,8(sp)
    80002e48:	6145                	addi	sp,sp,48
    80002e4a:	8082                	ret
    panic("invalid file system");
    80002e4c:	00005517          	auipc	a0,0x5
    80002e50:	79c50513          	addi	a0,a0,1948 # 800085e8 <syscalls+0x198>
    80002e54:	00003097          	auipc	ra,0x3
    80002e58:	5ec080e7          	jalr	1516(ra) # 80006440 <panic>

0000000080002e5c <iinit>:
{
    80002e5c:	7179                	addi	sp,sp,-48
    80002e5e:	f406                	sd	ra,40(sp)
    80002e60:	f022                	sd	s0,32(sp)
    80002e62:	ec26                	sd	s1,24(sp)
    80002e64:	e84a                	sd	s2,16(sp)
    80002e66:	e44e                	sd	s3,8(sp)
    80002e68:	1800                	addi	s0,sp,48
  initlock(&itable.lock, "itable");
    80002e6a:	00005597          	auipc	a1,0x5
    80002e6e:	79658593          	addi	a1,a1,1942 # 80008600 <syscalls+0x1b0>
    80002e72:	00014517          	auipc	a0,0x14
    80002e76:	70650513          	addi	a0,a0,1798 # 80017578 <itable>
    80002e7a:	00004097          	auipc	ra,0x4
    80002e7e:	a80080e7          	jalr	-1408(ra) # 800068fa <initlock>
  for(i = 0; i < NINODE; i++) {
    80002e82:	00014497          	auipc	s1,0x14
    80002e86:	71e48493          	addi	s1,s1,1822 # 800175a0 <itable+0x28>
    80002e8a:	00016997          	auipc	s3,0x16
    80002e8e:	1a698993          	addi	s3,s3,422 # 80019030 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    80002e92:	00005917          	auipc	s2,0x5
    80002e96:	77690913          	addi	s2,s2,1910 # 80008608 <syscalls+0x1b8>
    80002e9a:	85ca                	mv	a1,s2
    80002e9c:	8526                	mv	a0,s1
    80002e9e:	00001097          	auipc	ra,0x1
    80002ea2:	fbc080e7          	jalr	-68(ra) # 80003e5a <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    80002ea6:	08848493          	addi	s1,s1,136
    80002eaa:	ff3498e3          	bne	s1,s3,80002e9a <iinit+0x3e>
}
    80002eae:	70a2                	ld	ra,40(sp)
    80002eb0:	7402                	ld	s0,32(sp)
    80002eb2:	64e2                	ld	s1,24(sp)
    80002eb4:	6942                	ld	s2,16(sp)
    80002eb6:	69a2                	ld	s3,8(sp)
    80002eb8:	6145                	addi	sp,sp,48
    80002eba:	8082                	ret

0000000080002ebc <ialloc>:
{
    80002ebc:	715d                	addi	sp,sp,-80
    80002ebe:	e486                	sd	ra,72(sp)
    80002ec0:	e0a2                	sd	s0,64(sp)
    80002ec2:	fc26                	sd	s1,56(sp)
    80002ec4:	f84a                	sd	s2,48(sp)
    80002ec6:	f44e                	sd	s3,40(sp)
    80002ec8:	f052                	sd	s4,32(sp)
    80002eca:	ec56                	sd	s5,24(sp)
    80002ecc:	e85a                	sd	s6,16(sp)
    80002ece:	e45e                	sd	s7,8(sp)
    80002ed0:	0880                	addi	s0,sp,80
  for(inum = 1; inum < sb.ninodes; inum++){
    80002ed2:	00014717          	auipc	a4,0x14
    80002ed6:	69272703          	lw	a4,1682(a4) # 80017564 <sb+0xc>
    80002eda:	4785                	li	a5,1
    80002edc:	04e7fa63          	bgeu	a5,a4,80002f30 <ialloc+0x74>
    80002ee0:	8aaa                	mv	s5,a0
    80002ee2:	8bae                	mv	s7,a1
    80002ee4:	4485                	li	s1,1
    bp = bread(dev, IBLOCK(inum, sb));
    80002ee6:	00014a17          	auipc	s4,0x14
    80002eea:	672a0a13          	addi	s4,s4,1650 # 80017558 <sb>
    80002eee:	00048b1b          	sext.w	s6,s1
    80002ef2:	0044d593          	srli	a1,s1,0x4
    80002ef6:	018a2783          	lw	a5,24(s4)
    80002efa:	9dbd                	addw	a1,a1,a5
    80002efc:	8556                	mv	a0,s5
    80002efe:	00000097          	auipc	ra,0x0
    80002f02:	964080e7          	jalr	-1692(ra) # 80002862 <bread>
    80002f06:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    80002f08:	05850993          	addi	s3,a0,88
    80002f0c:	00f4f793          	andi	a5,s1,15
    80002f10:	079a                	slli	a5,a5,0x6
    80002f12:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    80002f14:	00099783          	lh	a5,0(s3)
    80002f18:	c785                	beqz	a5,80002f40 <ialloc+0x84>
    brelse(bp);
    80002f1a:	00000097          	auipc	ra,0x0
    80002f1e:	9ba080e7          	jalr	-1606(ra) # 800028d4 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    80002f22:	0485                	addi	s1,s1,1
    80002f24:	00ca2703          	lw	a4,12(s4)
    80002f28:	0004879b          	sext.w	a5,s1
    80002f2c:	fce7e1e3          	bltu	a5,a4,80002eee <ialloc+0x32>
  panic("ialloc: no inodes");
    80002f30:	00005517          	auipc	a0,0x5
    80002f34:	6e050513          	addi	a0,a0,1760 # 80008610 <syscalls+0x1c0>
    80002f38:	00003097          	auipc	ra,0x3
    80002f3c:	508080e7          	jalr	1288(ra) # 80006440 <panic>
      memset(dip, 0, sizeof(*dip));
    80002f40:	04000613          	li	a2,64
    80002f44:	4581                	li	a1,0
    80002f46:	854e                	mv	a0,s3
    80002f48:	ffffd097          	auipc	ra,0xffffd
    80002f4c:	230080e7          	jalr	560(ra) # 80000178 <memset>
      dip->type = type;
    80002f50:	01799023          	sh	s7,0(s3)
      brelse(bp);
    80002f54:	854a                	mv	a0,s2
    80002f56:	00000097          	auipc	ra,0x0
    80002f5a:	97e080e7          	jalr	-1666(ra) # 800028d4 <brelse>
      return iget(dev, inum);
    80002f5e:	85da                	mv	a1,s6
    80002f60:	8556                	mv	a0,s5
    80002f62:	00000097          	auipc	ra,0x0
    80002f66:	dbe080e7          	jalr	-578(ra) # 80002d20 <iget>
}
    80002f6a:	60a6                	ld	ra,72(sp)
    80002f6c:	6406                	ld	s0,64(sp)
    80002f6e:	74e2                	ld	s1,56(sp)
    80002f70:	7942                	ld	s2,48(sp)
    80002f72:	79a2                	ld	s3,40(sp)
    80002f74:	7a02                	ld	s4,32(sp)
    80002f76:	6ae2                	ld	s5,24(sp)
    80002f78:	6b42                	ld	s6,16(sp)
    80002f7a:	6ba2                	ld	s7,8(sp)
    80002f7c:	6161                	addi	sp,sp,80
    80002f7e:	8082                	ret

0000000080002f80 <iupdate>:
{
    80002f80:	1101                	addi	sp,sp,-32
    80002f82:	ec06                	sd	ra,24(sp)
    80002f84:	e822                	sd	s0,16(sp)
    80002f86:	e426                	sd	s1,8(sp)
    80002f88:	e04a                	sd	s2,0(sp)
    80002f8a:	1000                	addi	s0,sp,32
    80002f8c:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002f8e:	415c                	lw	a5,4(a0)
    80002f90:	0047d79b          	srliw	a5,a5,0x4
    80002f94:	00014597          	auipc	a1,0x14
    80002f98:	5dc5a583          	lw	a1,1500(a1) # 80017570 <sb+0x18>
    80002f9c:	9dbd                	addw	a1,a1,a5
    80002f9e:	4108                	lw	a0,0(a0)
    80002fa0:	00000097          	auipc	ra,0x0
    80002fa4:	8c2080e7          	jalr	-1854(ra) # 80002862 <bread>
    80002fa8:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002faa:	05850793          	addi	a5,a0,88
    80002fae:	40d8                	lw	a4,4(s1)
    80002fb0:	8b3d                	andi	a4,a4,15
    80002fb2:	071a                	slli	a4,a4,0x6
    80002fb4:	97ba                	add	a5,a5,a4
  dip->type = ip->type;
    80002fb6:	04449703          	lh	a4,68(s1)
    80002fba:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    80002fbe:	04649703          	lh	a4,70(s1)
    80002fc2:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    80002fc6:	04849703          	lh	a4,72(s1)
    80002fca:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    80002fce:	04a49703          	lh	a4,74(s1)
    80002fd2:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    80002fd6:	44f8                	lw	a4,76(s1)
    80002fd8:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80002fda:	03400613          	li	a2,52
    80002fde:	05048593          	addi	a1,s1,80
    80002fe2:	00c78513          	addi	a0,a5,12
    80002fe6:	ffffd097          	auipc	ra,0xffffd
    80002fea:	1f2080e7          	jalr	498(ra) # 800001d8 <memmove>
  brelse(bp);
    80002fee:	854a                	mv	a0,s2
    80002ff0:	00000097          	auipc	ra,0x0
    80002ff4:	8e4080e7          	jalr	-1820(ra) # 800028d4 <brelse>
}
    80002ff8:	60e2                	ld	ra,24(sp)
    80002ffa:	6442                	ld	s0,16(sp)
    80002ffc:	64a2                	ld	s1,8(sp)
    80002ffe:	6902                	ld	s2,0(sp)
    80003000:	6105                	addi	sp,sp,32
    80003002:	8082                	ret

0000000080003004 <idup>:
{
    80003004:	1101                	addi	sp,sp,-32
    80003006:	ec06                	sd	ra,24(sp)
    80003008:	e822                	sd	s0,16(sp)
    8000300a:	e426                	sd	s1,8(sp)
    8000300c:	1000                	addi	s0,sp,32
    8000300e:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80003010:	00014517          	auipc	a0,0x14
    80003014:	56850513          	addi	a0,a0,1384 # 80017578 <itable>
    80003018:	00004097          	auipc	ra,0x4
    8000301c:	972080e7          	jalr	-1678(ra) # 8000698a <acquire>
  ip->ref++;
    80003020:	449c                	lw	a5,8(s1)
    80003022:	2785                	addiw	a5,a5,1
    80003024:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80003026:	00014517          	auipc	a0,0x14
    8000302a:	55250513          	addi	a0,a0,1362 # 80017578 <itable>
    8000302e:	00004097          	auipc	ra,0x4
    80003032:	a10080e7          	jalr	-1520(ra) # 80006a3e <release>
}
    80003036:	8526                	mv	a0,s1
    80003038:	60e2                	ld	ra,24(sp)
    8000303a:	6442                	ld	s0,16(sp)
    8000303c:	64a2                	ld	s1,8(sp)
    8000303e:	6105                	addi	sp,sp,32
    80003040:	8082                	ret

0000000080003042 <ilock>:
{
    80003042:	1101                	addi	sp,sp,-32
    80003044:	ec06                	sd	ra,24(sp)
    80003046:	e822                	sd	s0,16(sp)
    80003048:	e426                	sd	s1,8(sp)
    8000304a:	e04a                	sd	s2,0(sp)
    8000304c:	1000                	addi	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    8000304e:	c115                	beqz	a0,80003072 <ilock+0x30>
    80003050:	84aa                	mv	s1,a0
    80003052:	451c                	lw	a5,8(a0)
    80003054:	00f05f63          	blez	a5,80003072 <ilock+0x30>
  acquiresleep(&ip->lock);
    80003058:	0541                	addi	a0,a0,16
    8000305a:	00001097          	auipc	ra,0x1
    8000305e:	e3a080e7          	jalr	-454(ra) # 80003e94 <acquiresleep>
  if(ip->valid == 0){
    80003062:	40bc                	lw	a5,64(s1)
    80003064:	cf99                	beqz	a5,80003082 <ilock+0x40>
}
    80003066:	60e2                	ld	ra,24(sp)
    80003068:	6442                	ld	s0,16(sp)
    8000306a:	64a2                	ld	s1,8(sp)
    8000306c:	6902                	ld	s2,0(sp)
    8000306e:	6105                	addi	sp,sp,32
    80003070:	8082                	ret
    panic("ilock");
    80003072:	00005517          	auipc	a0,0x5
    80003076:	5b650513          	addi	a0,a0,1462 # 80008628 <syscalls+0x1d8>
    8000307a:	00003097          	auipc	ra,0x3
    8000307e:	3c6080e7          	jalr	966(ra) # 80006440 <panic>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80003082:	40dc                	lw	a5,4(s1)
    80003084:	0047d79b          	srliw	a5,a5,0x4
    80003088:	00014597          	auipc	a1,0x14
    8000308c:	4e85a583          	lw	a1,1256(a1) # 80017570 <sb+0x18>
    80003090:	9dbd                	addw	a1,a1,a5
    80003092:	4088                	lw	a0,0(s1)
    80003094:	fffff097          	auipc	ra,0xfffff
    80003098:	7ce080e7          	jalr	1998(ra) # 80002862 <bread>
    8000309c:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    8000309e:	05850593          	addi	a1,a0,88
    800030a2:	40dc                	lw	a5,4(s1)
    800030a4:	8bbd                	andi	a5,a5,15
    800030a6:	079a                	slli	a5,a5,0x6
    800030a8:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    800030aa:	00059783          	lh	a5,0(a1)
    800030ae:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    800030b2:	00259783          	lh	a5,2(a1)
    800030b6:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    800030ba:	00459783          	lh	a5,4(a1)
    800030be:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    800030c2:	00659783          	lh	a5,6(a1)
    800030c6:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    800030ca:	459c                	lw	a5,8(a1)
    800030cc:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    800030ce:	03400613          	li	a2,52
    800030d2:	05b1                	addi	a1,a1,12
    800030d4:	05048513          	addi	a0,s1,80
    800030d8:	ffffd097          	auipc	ra,0xffffd
    800030dc:	100080e7          	jalr	256(ra) # 800001d8 <memmove>
    brelse(bp);
    800030e0:	854a                	mv	a0,s2
    800030e2:	fffff097          	auipc	ra,0xfffff
    800030e6:	7f2080e7          	jalr	2034(ra) # 800028d4 <brelse>
    ip->valid = 1;
    800030ea:	4785                	li	a5,1
    800030ec:	c0bc                	sw	a5,64(s1)
    if(ip->type == 0)
    800030ee:	04449783          	lh	a5,68(s1)
    800030f2:	fbb5                	bnez	a5,80003066 <ilock+0x24>
      panic("ilock: no type");
    800030f4:	00005517          	auipc	a0,0x5
    800030f8:	53c50513          	addi	a0,a0,1340 # 80008630 <syscalls+0x1e0>
    800030fc:	00003097          	auipc	ra,0x3
    80003100:	344080e7          	jalr	836(ra) # 80006440 <panic>

0000000080003104 <iunlock>:
{
    80003104:	1101                	addi	sp,sp,-32
    80003106:	ec06                	sd	ra,24(sp)
    80003108:	e822                	sd	s0,16(sp)
    8000310a:	e426                	sd	s1,8(sp)
    8000310c:	e04a                	sd	s2,0(sp)
    8000310e:	1000                	addi	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80003110:	c905                	beqz	a0,80003140 <iunlock+0x3c>
    80003112:	84aa                	mv	s1,a0
    80003114:	01050913          	addi	s2,a0,16
    80003118:	854a                	mv	a0,s2
    8000311a:	00001097          	auipc	ra,0x1
    8000311e:	e14080e7          	jalr	-492(ra) # 80003f2e <holdingsleep>
    80003122:	cd19                	beqz	a0,80003140 <iunlock+0x3c>
    80003124:	449c                	lw	a5,8(s1)
    80003126:	00f05d63          	blez	a5,80003140 <iunlock+0x3c>
  releasesleep(&ip->lock);
    8000312a:	854a                	mv	a0,s2
    8000312c:	00001097          	auipc	ra,0x1
    80003130:	dbe080e7          	jalr	-578(ra) # 80003eea <releasesleep>
}
    80003134:	60e2                	ld	ra,24(sp)
    80003136:	6442                	ld	s0,16(sp)
    80003138:	64a2                	ld	s1,8(sp)
    8000313a:	6902                	ld	s2,0(sp)
    8000313c:	6105                	addi	sp,sp,32
    8000313e:	8082                	ret
    panic("iunlock");
    80003140:	00005517          	auipc	a0,0x5
    80003144:	50050513          	addi	a0,a0,1280 # 80008640 <syscalls+0x1f0>
    80003148:	00003097          	auipc	ra,0x3
    8000314c:	2f8080e7          	jalr	760(ra) # 80006440 <panic>

0000000080003150 <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    80003150:	7179                	addi	sp,sp,-48
    80003152:	f406                	sd	ra,40(sp)
    80003154:	f022                	sd	s0,32(sp)
    80003156:	ec26                	sd	s1,24(sp)
    80003158:	e84a                	sd	s2,16(sp)
    8000315a:	e44e                	sd	s3,8(sp)
    8000315c:	e052                	sd	s4,0(sp)
    8000315e:	1800                	addi	s0,sp,48
    80003160:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80003162:	05050493          	addi	s1,a0,80
    80003166:	08050913          	addi	s2,a0,128
    8000316a:	a021                	j	80003172 <itrunc+0x22>
    8000316c:	0491                	addi	s1,s1,4
    8000316e:	01248d63          	beq	s1,s2,80003188 <itrunc+0x38>
    if(ip->addrs[i]){
    80003172:	408c                	lw	a1,0(s1)
    80003174:	dde5                	beqz	a1,8000316c <itrunc+0x1c>
      bfree(ip->dev, ip->addrs[i]);
    80003176:	0009a503          	lw	a0,0(s3)
    8000317a:	00000097          	auipc	ra,0x0
    8000317e:	932080e7          	jalr	-1742(ra) # 80002aac <bfree>
      ip->addrs[i] = 0;
    80003182:	0004a023          	sw	zero,0(s1)
    80003186:	b7dd                	j	8000316c <itrunc+0x1c>
    }
  }

  if(ip->addrs[NDIRECT]){
    80003188:	0809a583          	lw	a1,128(s3)
    8000318c:	e185                	bnez	a1,800031ac <itrunc+0x5c>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    8000318e:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    80003192:	854e                	mv	a0,s3
    80003194:	00000097          	auipc	ra,0x0
    80003198:	dec080e7          	jalr	-532(ra) # 80002f80 <iupdate>
}
    8000319c:	70a2                	ld	ra,40(sp)
    8000319e:	7402                	ld	s0,32(sp)
    800031a0:	64e2                	ld	s1,24(sp)
    800031a2:	6942                	ld	s2,16(sp)
    800031a4:	69a2                	ld	s3,8(sp)
    800031a6:	6a02                	ld	s4,0(sp)
    800031a8:	6145                	addi	sp,sp,48
    800031aa:	8082                	ret
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    800031ac:	0009a503          	lw	a0,0(s3)
    800031b0:	fffff097          	auipc	ra,0xfffff
    800031b4:	6b2080e7          	jalr	1714(ra) # 80002862 <bread>
    800031b8:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    800031ba:	05850493          	addi	s1,a0,88
    800031be:	45850913          	addi	s2,a0,1112
    800031c2:	a811                	j	800031d6 <itrunc+0x86>
        bfree(ip->dev, a[j]);
    800031c4:	0009a503          	lw	a0,0(s3)
    800031c8:	00000097          	auipc	ra,0x0
    800031cc:	8e4080e7          	jalr	-1820(ra) # 80002aac <bfree>
    for(j = 0; j < NINDIRECT; j++){
    800031d0:	0491                	addi	s1,s1,4
    800031d2:	01248563          	beq	s1,s2,800031dc <itrunc+0x8c>
      if(a[j])
    800031d6:	408c                	lw	a1,0(s1)
    800031d8:	dde5                	beqz	a1,800031d0 <itrunc+0x80>
    800031da:	b7ed                	j	800031c4 <itrunc+0x74>
    brelse(bp);
    800031dc:	8552                	mv	a0,s4
    800031de:	fffff097          	auipc	ra,0xfffff
    800031e2:	6f6080e7          	jalr	1782(ra) # 800028d4 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    800031e6:	0809a583          	lw	a1,128(s3)
    800031ea:	0009a503          	lw	a0,0(s3)
    800031ee:	00000097          	auipc	ra,0x0
    800031f2:	8be080e7          	jalr	-1858(ra) # 80002aac <bfree>
    ip->addrs[NDIRECT] = 0;
    800031f6:	0809a023          	sw	zero,128(s3)
    800031fa:	bf51                	j	8000318e <itrunc+0x3e>

00000000800031fc <iput>:
{
    800031fc:	1101                	addi	sp,sp,-32
    800031fe:	ec06                	sd	ra,24(sp)
    80003200:	e822                	sd	s0,16(sp)
    80003202:	e426                	sd	s1,8(sp)
    80003204:	e04a                	sd	s2,0(sp)
    80003206:	1000                	addi	s0,sp,32
    80003208:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    8000320a:	00014517          	auipc	a0,0x14
    8000320e:	36e50513          	addi	a0,a0,878 # 80017578 <itable>
    80003212:	00003097          	auipc	ra,0x3
    80003216:	778080e7          	jalr	1912(ra) # 8000698a <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    8000321a:	4498                	lw	a4,8(s1)
    8000321c:	4785                	li	a5,1
    8000321e:	02f70363          	beq	a4,a5,80003244 <iput+0x48>
  ip->ref--;
    80003222:	449c                	lw	a5,8(s1)
    80003224:	37fd                	addiw	a5,a5,-1
    80003226:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80003228:	00014517          	auipc	a0,0x14
    8000322c:	35050513          	addi	a0,a0,848 # 80017578 <itable>
    80003230:	00004097          	auipc	ra,0x4
    80003234:	80e080e7          	jalr	-2034(ra) # 80006a3e <release>
}
    80003238:	60e2                	ld	ra,24(sp)
    8000323a:	6442                	ld	s0,16(sp)
    8000323c:	64a2                	ld	s1,8(sp)
    8000323e:	6902                	ld	s2,0(sp)
    80003240:	6105                	addi	sp,sp,32
    80003242:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80003244:	40bc                	lw	a5,64(s1)
    80003246:	dff1                	beqz	a5,80003222 <iput+0x26>
    80003248:	04a49783          	lh	a5,74(s1)
    8000324c:	fbf9                	bnez	a5,80003222 <iput+0x26>
    acquiresleep(&ip->lock);
    8000324e:	01048913          	addi	s2,s1,16
    80003252:	854a                	mv	a0,s2
    80003254:	00001097          	auipc	ra,0x1
    80003258:	c40080e7          	jalr	-960(ra) # 80003e94 <acquiresleep>
    release(&itable.lock);
    8000325c:	00014517          	auipc	a0,0x14
    80003260:	31c50513          	addi	a0,a0,796 # 80017578 <itable>
    80003264:	00003097          	auipc	ra,0x3
    80003268:	7da080e7          	jalr	2010(ra) # 80006a3e <release>
    itrunc(ip);
    8000326c:	8526                	mv	a0,s1
    8000326e:	00000097          	auipc	ra,0x0
    80003272:	ee2080e7          	jalr	-286(ra) # 80003150 <itrunc>
    ip->type = 0;
    80003276:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    8000327a:	8526                	mv	a0,s1
    8000327c:	00000097          	auipc	ra,0x0
    80003280:	d04080e7          	jalr	-764(ra) # 80002f80 <iupdate>
    ip->valid = 0;
    80003284:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    80003288:	854a                	mv	a0,s2
    8000328a:	00001097          	auipc	ra,0x1
    8000328e:	c60080e7          	jalr	-928(ra) # 80003eea <releasesleep>
    acquire(&itable.lock);
    80003292:	00014517          	auipc	a0,0x14
    80003296:	2e650513          	addi	a0,a0,742 # 80017578 <itable>
    8000329a:	00003097          	auipc	ra,0x3
    8000329e:	6f0080e7          	jalr	1776(ra) # 8000698a <acquire>
    800032a2:	b741                	j	80003222 <iput+0x26>

00000000800032a4 <iunlockput>:
{
    800032a4:	1101                	addi	sp,sp,-32
    800032a6:	ec06                	sd	ra,24(sp)
    800032a8:	e822                	sd	s0,16(sp)
    800032aa:	e426                	sd	s1,8(sp)
    800032ac:	1000                	addi	s0,sp,32
    800032ae:	84aa                	mv	s1,a0
  iunlock(ip);
    800032b0:	00000097          	auipc	ra,0x0
    800032b4:	e54080e7          	jalr	-428(ra) # 80003104 <iunlock>
  iput(ip);
    800032b8:	8526                	mv	a0,s1
    800032ba:	00000097          	auipc	ra,0x0
    800032be:	f42080e7          	jalr	-190(ra) # 800031fc <iput>
}
    800032c2:	60e2                	ld	ra,24(sp)
    800032c4:	6442                	ld	s0,16(sp)
    800032c6:	64a2                	ld	s1,8(sp)
    800032c8:	6105                	addi	sp,sp,32
    800032ca:	8082                	ret

00000000800032cc <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    800032cc:	1141                	addi	sp,sp,-16
    800032ce:	e422                	sd	s0,8(sp)
    800032d0:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    800032d2:	411c                	lw	a5,0(a0)
    800032d4:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    800032d6:	415c                	lw	a5,4(a0)
    800032d8:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    800032da:	04451783          	lh	a5,68(a0)
    800032de:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    800032e2:	04a51783          	lh	a5,74(a0)
    800032e6:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    800032ea:	04c56783          	lwu	a5,76(a0)
    800032ee:	e99c                	sd	a5,16(a1)
}
    800032f0:	6422                	ld	s0,8(sp)
    800032f2:	0141                	addi	sp,sp,16
    800032f4:	8082                	ret

00000000800032f6 <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    800032f6:	457c                	lw	a5,76(a0)
    800032f8:	0ed7e963          	bltu	a5,a3,800033ea <readi+0xf4>
{
    800032fc:	7159                	addi	sp,sp,-112
    800032fe:	f486                	sd	ra,104(sp)
    80003300:	f0a2                	sd	s0,96(sp)
    80003302:	eca6                	sd	s1,88(sp)
    80003304:	e8ca                	sd	s2,80(sp)
    80003306:	e4ce                	sd	s3,72(sp)
    80003308:	e0d2                	sd	s4,64(sp)
    8000330a:	fc56                	sd	s5,56(sp)
    8000330c:	f85a                	sd	s6,48(sp)
    8000330e:	f45e                	sd	s7,40(sp)
    80003310:	f062                	sd	s8,32(sp)
    80003312:	ec66                	sd	s9,24(sp)
    80003314:	e86a                	sd	s10,16(sp)
    80003316:	e46e                	sd	s11,8(sp)
    80003318:	1880                	addi	s0,sp,112
    8000331a:	8baa                	mv	s7,a0
    8000331c:	8c2e                	mv	s8,a1
    8000331e:	8ab2                	mv	s5,a2
    80003320:	84b6                	mv	s1,a3
    80003322:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    80003324:	9f35                	addw	a4,a4,a3
    return 0;
    80003326:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    80003328:	0ad76063          	bltu	a4,a3,800033c8 <readi+0xd2>
  if(off + n > ip->size)
    8000332c:	00e7f463          	bgeu	a5,a4,80003334 <readi+0x3e>
    n = ip->size - off;
    80003330:	40d78b3b          	subw	s6,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003334:	0a0b0963          	beqz	s6,800033e6 <readi+0xf0>
    80003338:	4981                	li	s3,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    8000333a:	40000d13          	li	s10,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    8000333e:	5cfd                	li	s9,-1
    80003340:	a82d                	j	8000337a <readi+0x84>
    80003342:	020a1d93          	slli	s11,s4,0x20
    80003346:	020ddd93          	srli	s11,s11,0x20
    8000334a:	05890613          	addi	a2,s2,88
    8000334e:	86ee                	mv	a3,s11
    80003350:	963a                	add	a2,a2,a4
    80003352:	85d6                	mv	a1,s5
    80003354:	8562                	mv	a0,s8
    80003356:	fffff097          	auipc	ra,0xfffff
    8000335a:	a48080e7          	jalr	-1464(ra) # 80001d9e <either_copyout>
    8000335e:	05950d63          	beq	a0,s9,800033b8 <readi+0xc2>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    80003362:	854a                	mv	a0,s2
    80003364:	fffff097          	auipc	ra,0xfffff
    80003368:	570080e7          	jalr	1392(ra) # 800028d4 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    8000336c:	013a09bb          	addw	s3,s4,s3
    80003370:	009a04bb          	addw	s1,s4,s1
    80003374:	9aee                	add	s5,s5,s11
    80003376:	0569f763          	bgeu	s3,s6,800033c4 <readi+0xce>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    8000337a:	000ba903          	lw	s2,0(s7)
    8000337e:	00a4d59b          	srliw	a1,s1,0xa
    80003382:	855e                	mv	a0,s7
    80003384:	00000097          	auipc	ra,0x0
    80003388:	8cc080e7          	jalr	-1844(ra) # 80002c50 <bmap>
    8000338c:	0005059b          	sext.w	a1,a0
    80003390:	854a                	mv	a0,s2
    80003392:	fffff097          	auipc	ra,0xfffff
    80003396:	4d0080e7          	jalr	1232(ra) # 80002862 <bread>
    8000339a:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    8000339c:	3ff4f713          	andi	a4,s1,1023
    800033a0:	40ed07bb          	subw	a5,s10,a4
    800033a4:	413b06bb          	subw	a3,s6,s3
    800033a8:	8a3e                	mv	s4,a5
    800033aa:	2781                	sext.w	a5,a5
    800033ac:	0006861b          	sext.w	a2,a3
    800033b0:	f8f679e3          	bgeu	a2,a5,80003342 <readi+0x4c>
    800033b4:	8a36                	mv	s4,a3
    800033b6:	b771                	j	80003342 <readi+0x4c>
      brelse(bp);
    800033b8:	854a                	mv	a0,s2
    800033ba:	fffff097          	auipc	ra,0xfffff
    800033be:	51a080e7          	jalr	1306(ra) # 800028d4 <brelse>
      tot = -1;
    800033c2:	59fd                	li	s3,-1
  }
  return tot;
    800033c4:	0009851b          	sext.w	a0,s3
}
    800033c8:	70a6                	ld	ra,104(sp)
    800033ca:	7406                	ld	s0,96(sp)
    800033cc:	64e6                	ld	s1,88(sp)
    800033ce:	6946                	ld	s2,80(sp)
    800033d0:	69a6                	ld	s3,72(sp)
    800033d2:	6a06                	ld	s4,64(sp)
    800033d4:	7ae2                	ld	s5,56(sp)
    800033d6:	7b42                	ld	s6,48(sp)
    800033d8:	7ba2                	ld	s7,40(sp)
    800033da:	7c02                	ld	s8,32(sp)
    800033dc:	6ce2                	ld	s9,24(sp)
    800033de:	6d42                	ld	s10,16(sp)
    800033e0:	6da2                	ld	s11,8(sp)
    800033e2:	6165                	addi	sp,sp,112
    800033e4:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    800033e6:	89da                	mv	s3,s6
    800033e8:	bff1                	j	800033c4 <readi+0xce>
    return 0;
    800033ea:	4501                	li	a0,0
}
    800033ec:	8082                	ret

00000000800033ee <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    800033ee:	457c                	lw	a5,76(a0)
    800033f0:	10d7e363          	bltu	a5,a3,800034f6 <writei+0x108>
{
    800033f4:	7159                	addi	sp,sp,-112
    800033f6:	f486                	sd	ra,104(sp)
    800033f8:	f0a2                	sd	s0,96(sp)
    800033fa:	eca6                	sd	s1,88(sp)
    800033fc:	e8ca                	sd	s2,80(sp)
    800033fe:	e4ce                	sd	s3,72(sp)
    80003400:	e0d2                	sd	s4,64(sp)
    80003402:	fc56                	sd	s5,56(sp)
    80003404:	f85a                	sd	s6,48(sp)
    80003406:	f45e                	sd	s7,40(sp)
    80003408:	f062                	sd	s8,32(sp)
    8000340a:	ec66                	sd	s9,24(sp)
    8000340c:	e86a                	sd	s10,16(sp)
    8000340e:	e46e                	sd	s11,8(sp)
    80003410:	1880                	addi	s0,sp,112
    80003412:	8b2a                	mv	s6,a0
    80003414:	8c2e                	mv	s8,a1
    80003416:	8ab2                	mv	s5,a2
    80003418:	8936                	mv	s2,a3
    8000341a:	8bba                	mv	s7,a4
  if(off > ip->size || off + n < off)
    8000341c:	00e687bb          	addw	a5,a3,a4
    80003420:	0cd7ed63          	bltu	a5,a3,800034fa <writei+0x10c>
    return -1;
  if(off + n > MAXFILE*BSIZE)
    80003424:	00043737          	lui	a4,0x43
    80003428:	0cf76b63          	bltu	a4,a5,800034fe <writei+0x110>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    8000342c:	0c0b8363          	beqz	s7,800034f2 <writei+0x104>
    80003430:	4a01                	li	s4,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    80003432:	40000d13          	li	s10,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80003436:	5cfd                	li	s9,-1
    80003438:	a82d                	j	80003472 <writei+0x84>
    8000343a:	02099d93          	slli	s11,s3,0x20
    8000343e:	020ddd93          	srli	s11,s11,0x20
    80003442:	05848513          	addi	a0,s1,88
    80003446:	86ee                	mv	a3,s11
    80003448:	8656                	mv	a2,s5
    8000344a:	85e2                	mv	a1,s8
    8000344c:	953a                	add	a0,a0,a4
    8000344e:	fffff097          	auipc	ra,0xfffff
    80003452:	9a6080e7          	jalr	-1626(ra) # 80001df4 <either_copyin>
    80003456:	05950d63          	beq	a0,s9,800034b0 <writei+0xc2>
      brelse(bp);
      break;
    }
    //log_write(bp);
    brelse(bp);
    8000345a:	8526                	mv	a0,s1
    8000345c:	fffff097          	auipc	ra,0xfffff
    80003460:	478080e7          	jalr	1144(ra) # 800028d4 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003464:	01498a3b          	addw	s4,s3,s4
    80003468:	0129893b          	addw	s2,s3,s2
    8000346c:	9aee                	add	s5,s5,s11
    8000346e:	057a7663          	bgeu	s4,s7,800034ba <writei+0xcc>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    80003472:	000b2483          	lw	s1,0(s6)
    80003476:	00a9559b          	srliw	a1,s2,0xa
    8000347a:	855a                	mv	a0,s6
    8000347c:	fffff097          	auipc	ra,0xfffff
    80003480:	7d4080e7          	jalr	2004(ra) # 80002c50 <bmap>
    80003484:	0005059b          	sext.w	a1,a0
    80003488:	8526                	mv	a0,s1
    8000348a:	fffff097          	auipc	ra,0xfffff
    8000348e:	3d8080e7          	jalr	984(ra) # 80002862 <bread>
    80003492:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80003494:	3ff97713          	andi	a4,s2,1023
    80003498:	40ed07bb          	subw	a5,s10,a4
    8000349c:	414b86bb          	subw	a3,s7,s4
    800034a0:	89be                	mv	s3,a5
    800034a2:	2781                	sext.w	a5,a5
    800034a4:	0006861b          	sext.w	a2,a3
    800034a8:	f8f679e3          	bgeu	a2,a5,8000343a <writei+0x4c>
    800034ac:	89b6                	mv	s3,a3
    800034ae:	b771                	j	8000343a <writei+0x4c>
      brelse(bp);
    800034b0:	8526                	mv	a0,s1
    800034b2:	fffff097          	auipc	ra,0xfffff
    800034b6:	422080e7          	jalr	1058(ra) # 800028d4 <brelse>
  }

  if(off > ip->size)
    800034ba:	04cb2783          	lw	a5,76(s6)
    800034be:	0127f463          	bgeu	a5,s2,800034c6 <writei+0xd8>
    ip->size = off;
    800034c2:	052b2623          	sw	s2,76(s6)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    800034c6:	855a                	mv	a0,s6
    800034c8:	00000097          	auipc	ra,0x0
    800034cc:	ab8080e7          	jalr	-1352(ra) # 80002f80 <iupdate>

  return tot;
    800034d0:	000a051b          	sext.w	a0,s4
}
    800034d4:	70a6                	ld	ra,104(sp)
    800034d6:	7406                	ld	s0,96(sp)
    800034d8:	64e6                	ld	s1,88(sp)
    800034da:	6946                	ld	s2,80(sp)
    800034dc:	69a6                	ld	s3,72(sp)
    800034de:	6a06                	ld	s4,64(sp)
    800034e0:	7ae2                	ld	s5,56(sp)
    800034e2:	7b42                	ld	s6,48(sp)
    800034e4:	7ba2                	ld	s7,40(sp)
    800034e6:	7c02                	ld	s8,32(sp)
    800034e8:	6ce2                	ld	s9,24(sp)
    800034ea:	6d42                	ld	s10,16(sp)
    800034ec:	6da2                	ld	s11,8(sp)
    800034ee:	6165                	addi	sp,sp,112
    800034f0:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    800034f2:	8a5e                	mv	s4,s7
    800034f4:	bfc9                	j	800034c6 <writei+0xd8>
    return -1;
    800034f6:	557d                	li	a0,-1
}
    800034f8:	8082                	ret
    return -1;
    800034fa:	557d                	li	a0,-1
    800034fc:	bfe1                	j	800034d4 <writei+0xe6>
    return -1;
    800034fe:	557d                	li	a0,-1
    80003500:	bfd1                	j	800034d4 <writei+0xe6>

0000000080003502 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80003502:	1141                	addi	sp,sp,-16
    80003504:	e406                	sd	ra,8(sp)
    80003506:	e022                	sd	s0,0(sp)
    80003508:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    8000350a:	4639                	li	a2,14
    8000350c:	ffffd097          	auipc	ra,0xffffd
    80003510:	d44080e7          	jalr	-700(ra) # 80000250 <strncmp>
}
    80003514:	60a2                	ld	ra,8(sp)
    80003516:	6402                	ld	s0,0(sp)
    80003518:	0141                	addi	sp,sp,16
    8000351a:	8082                	ret

000000008000351c <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    8000351c:	7139                	addi	sp,sp,-64
    8000351e:	fc06                	sd	ra,56(sp)
    80003520:	f822                	sd	s0,48(sp)
    80003522:	f426                	sd	s1,40(sp)
    80003524:	f04a                	sd	s2,32(sp)
    80003526:	ec4e                	sd	s3,24(sp)
    80003528:	e852                	sd	s4,16(sp)
    8000352a:	0080                	addi	s0,sp,64
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    8000352c:	04451703          	lh	a4,68(a0)
    80003530:	4785                	li	a5,1
    80003532:	00f71a63          	bne	a4,a5,80003546 <dirlookup+0x2a>
    80003536:	892a                	mv	s2,a0
    80003538:	89ae                	mv	s3,a1
    8000353a:	8a32                	mv	s4,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    8000353c:	457c                	lw	a5,76(a0)
    8000353e:	4481                	li	s1,0
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    80003540:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003542:	e79d                	bnez	a5,80003570 <dirlookup+0x54>
    80003544:	a8a5                	j	800035bc <dirlookup+0xa0>
    panic("dirlookup not DIR");
    80003546:	00005517          	auipc	a0,0x5
    8000354a:	10250513          	addi	a0,a0,258 # 80008648 <syscalls+0x1f8>
    8000354e:	00003097          	auipc	ra,0x3
    80003552:	ef2080e7          	jalr	-270(ra) # 80006440 <panic>
      panic("dirlookup read");
    80003556:	00005517          	auipc	a0,0x5
    8000355a:	10a50513          	addi	a0,a0,266 # 80008660 <syscalls+0x210>
    8000355e:	00003097          	auipc	ra,0x3
    80003562:	ee2080e7          	jalr	-286(ra) # 80006440 <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003566:	24c1                	addiw	s1,s1,16
    80003568:	04c92783          	lw	a5,76(s2)
    8000356c:	04f4f763          	bgeu	s1,a5,800035ba <dirlookup+0x9e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003570:	4741                	li	a4,16
    80003572:	86a6                	mv	a3,s1
    80003574:	fc040613          	addi	a2,s0,-64
    80003578:	4581                	li	a1,0
    8000357a:	854a                	mv	a0,s2
    8000357c:	00000097          	auipc	ra,0x0
    80003580:	d7a080e7          	jalr	-646(ra) # 800032f6 <readi>
    80003584:	47c1                	li	a5,16
    80003586:	fcf518e3          	bne	a0,a5,80003556 <dirlookup+0x3a>
    if(de.inum == 0)
    8000358a:	fc045783          	lhu	a5,-64(s0)
    8000358e:	dfe1                	beqz	a5,80003566 <dirlookup+0x4a>
    if(namecmp(name, de.name) == 0){
    80003590:	fc240593          	addi	a1,s0,-62
    80003594:	854e                	mv	a0,s3
    80003596:	00000097          	auipc	ra,0x0
    8000359a:	f6c080e7          	jalr	-148(ra) # 80003502 <namecmp>
    8000359e:	f561                	bnez	a0,80003566 <dirlookup+0x4a>
      if(poff)
    800035a0:	000a0463          	beqz	s4,800035a8 <dirlookup+0x8c>
        *poff = off;
    800035a4:	009a2023          	sw	s1,0(s4)
      return iget(dp->dev, inum);
    800035a8:	fc045583          	lhu	a1,-64(s0)
    800035ac:	00092503          	lw	a0,0(s2)
    800035b0:	fffff097          	auipc	ra,0xfffff
    800035b4:	770080e7          	jalr	1904(ra) # 80002d20 <iget>
    800035b8:	a011                	j	800035bc <dirlookup+0xa0>
  return 0;
    800035ba:	4501                	li	a0,0
}
    800035bc:	70e2                	ld	ra,56(sp)
    800035be:	7442                	ld	s0,48(sp)
    800035c0:	74a2                	ld	s1,40(sp)
    800035c2:	7902                	ld	s2,32(sp)
    800035c4:	69e2                	ld	s3,24(sp)
    800035c6:	6a42                	ld	s4,16(sp)
    800035c8:	6121                	addi	sp,sp,64
    800035ca:	8082                	ret

00000000800035cc <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    800035cc:	711d                	addi	sp,sp,-96
    800035ce:	ec86                	sd	ra,88(sp)
    800035d0:	e8a2                	sd	s0,80(sp)
    800035d2:	e4a6                	sd	s1,72(sp)
    800035d4:	e0ca                	sd	s2,64(sp)
    800035d6:	fc4e                	sd	s3,56(sp)
    800035d8:	f852                	sd	s4,48(sp)
    800035da:	f456                	sd	s5,40(sp)
    800035dc:	f05a                	sd	s6,32(sp)
    800035de:	ec5e                	sd	s7,24(sp)
    800035e0:	e862                	sd	s8,16(sp)
    800035e2:	e466                	sd	s9,8(sp)
    800035e4:	1080                	addi	s0,sp,96
    800035e6:	84aa                	mv	s1,a0
    800035e8:	8b2e                	mv	s6,a1
    800035ea:	8ab2                	mv	s5,a2
  struct inode *ip, *next;

  if(*path == '/')
    800035ec:	00054703          	lbu	a4,0(a0)
    800035f0:	02f00793          	li	a5,47
    800035f4:	02f70363          	beq	a4,a5,8000361a <namex+0x4e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    800035f8:	ffffe097          	auipc	ra,0xffffe
    800035fc:	d46080e7          	jalr	-698(ra) # 8000133e <myproc>
    80003600:	15053503          	ld	a0,336(a0)
    80003604:	00000097          	auipc	ra,0x0
    80003608:	a00080e7          	jalr	-1536(ra) # 80003004 <idup>
    8000360c:	89aa                	mv	s3,a0
  while(*path == '/')
    8000360e:	02f00913          	li	s2,47
  len = path - s;
    80003612:	4b81                	li	s7,0
  if(len >= DIRSIZ)
    80003614:	4cb5                	li	s9,13

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    80003616:	4c05                	li	s8,1
    80003618:	a865                	j	800036d0 <namex+0x104>
    ip = iget(ROOTDEV, ROOTINO);
    8000361a:	4585                	li	a1,1
    8000361c:	4505                	li	a0,1
    8000361e:	fffff097          	auipc	ra,0xfffff
    80003622:	702080e7          	jalr	1794(ra) # 80002d20 <iget>
    80003626:	89aa                	mv	s3,a0
    80003628:	b7dd                	j	8000360e <namex+0x42>
      iunlockput(ip);
    8000362a:	854e                	mv	a0,s3
    8000362c:	00000097          	auipc	ra,0x0
    80003630:	c78080e7          	jalr	-904(ra) # 800032a4 <iunlockput>
      return 0;
    80003634:	4981                	li	s3,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    80003636:	854e                	mv	a0,s3
    80003638:	60e6                	ld	ra,88(sp)
    8000363a:	6446                	ld	s0,80(sp)
    8000363c:	64a6                	ld	s1,72(sp)
    8000363e:	6906                	ld	s2,64(sp)
    80003640:	79e2                	ld	s3,56(sp)
    80003642:	7a42                	ld	s4,48(sp)
    80003644:	7aa2                	ld	s5,40(sp)
    80003646:	7b02                	ld	s6,32(sp)
    80003648:	6be2                	ld	s7,24(sp)
    8000364a:	6c42                	ld	s8,16(sp)
    8000364c:	6ca2                	ld	s9,8(sp)
    8000364e:	6125                	addi	sp,sp,96
    80003650:	8082                	ret
      iunlock(ip);
    80003652:	854e                	mv	a0,s3
    80003654:	00000097          	auipc	ra,0x0
    80003658:	ab0080e7          	jalr	-1360(ra) # 80003104 <iunlock>
      return ip;
    8000365c:	bfe9                	j	80003636 <namex+0x6a>
      iunlockput(ip);
    8000365e:	854e                	mv	a0,s3
    80003660:	00000097          	auipc	ra,0x0
    80003664:	c44080e7          	jalr	-956(ra) # 800032a4 <iunlockput>
      return 0;
    80003668:	89d2                	mv	s3,s4
    8000366a:	b7f1                	j	80003636 <namex+0x6a>
  len = path - s;
    8000366c:	40b48633          	sub	a2,s1,a1
    80003670:	00060a1b          	sext.w	s4,a2
  if(len >= DIRSIZ)
    80003674:	094cd463          	bge	s9,s4,800036fc <namex+0x130>
    memmove(name, s, DIRSIZ);
    80003678:	4639                	li	a2,14
    8000367a:	8556                	mv	a0,s5
    8000367c:	ffffd097          	auipc	ra,0xffffd
    80003680:	b5c080e7          	jalr	-1188(ra) # 800001d8 <memmove>
  while(*path == '/')
    80003684:	0004c783          	lbu	a5,0(s1)
    80003688:	01279763          	bne	a5,s2,80003696 <namex+0xca>
    path++;
    8000368c:	0485                	addi	s1,s1,1
  while(*path == '/')
    8000368e:	0004c783          	lbu	a5,0(s1)
    80003692:	ff278de3          	beq	a5,s2,8000368c <namex+0xc0>
    ilock(ip);
    80003696:	854e                	mv	a0,s3
    80003698:	00000097          	auipc	ra,0x0
    8000369c:	9aa080e7          	jalr	-1622(ra) # 80003042 <ilock>
    if(ip->type != T_DIR){
    800036a0:	04499783          	lh	a5,68(s3)
    800036a4:	f98793e3          	bne	a5,s8,8000362a <namex+0x5e>
    if(nameiparent && *path == '\0'){
    800036a8:	000b0563          	beqz	s6,800036b2 <namex+0xe6>
    800036ac:	0004c783          	lbu	a5,0(s1)
    800036b0:	d3cd                	beqz	a5,80003652 <namex+0x86>
    if((next = dirlookup(ip, name, 0)) == 0){
    800036b2:	865e                	mv	a2,s7
    800036b4:	85d6                	mv	a1,s5
    800036b6:	854e                	mv	a0,s3
    800036b8:	00000097          	auipc	ra,0x0
    800036bc:	e64080e7          	jalr	-412(ra) # 8000351c <dirlookup>
    800036c0:	8a2a                	mv	s4,a0
    800036c2:	dd51                	beqz	a0,8000365e <namex+0x92>
    iunlockput(ip);
    800036c4:	854e                	mv	a0,s3
    800036c6:	00000097          	auipc	ra,0x0
    800036ca:	bde080e7          	jalr	-1058(ra) # 800032a4 <iunlockput>
    ip = next;
    800036ce:	89d2                	mv	s3,s4
  while(*path == '/')
    800036d0:	0004c783          	lbu	a5,0(s1)
    800036d4:	05279763          	bne	a5,s2,80003722 <namex+0x156>
    path++;
    800036d8:	0485                	addi	s1,s1,1
  while(*path == '/')
    800036da:	0004c783          	lbu	a5,0(s1)
    800036de:	ff278de3          	beq	a5,s2,800036d8 <namex+0x10c>
  if(*path == 0)
    800036e2:	c79d                	beqz	a5,80003710 <namex+0x144>
    path++;
    800036e4:	85a6                	mv	a1,s1
  len = path - s;
    800036e6:	8a5e                	mv	s4,s7
    800036e8:	865e                	mv	a2,s7
  while(*path != '/' && *path != 0)
    800036ea:	01278963          	beq	a5,s2,800036fc <namex+0x130>
    800036ee:	dfbd                	beqz	a5,8000366c <namex+0xa0>
    path++;
    800036f0:	0485                	addi	s1,s1,1
  while(*path != '/' && *path != 0)
    800036f2:	0004c783          	lbu	a5,0(s1)
    800036f6:	ff279ce3          	bne	a5,s2,800036ee <namex+0x122>
    800036fa:	bf8d                	j	8000366c <namex+0xa0>
    memmove(name, s, len);
    800036fc:	2601                	sext.w	a2,a2
    800036fe:	8556                	mv	a0,s5
    80003700:	ffffd097          	auipc	ra,0xffffd
    80003704:	ad8080e7          	jalr	-1320(ra) # 800001d8 <memmove>
    name[len] = 0;
    80003708:	9a56                	add	s4,s4,s5
    8000370a:	000a0023          	sb	zero,0(s4)
    8000370e:	bf9d                	j	80003684 <namex+0xb8>
  if(nameiparent){
    80003710:	f20b03e3          	beqz	s6,80003636 <namex+0x6a>
    iput(ip);
    80003714:	854e                	mv	a0,s3
    80003716:	00000097          	auipc	ra,0x0
    8000371a:	ae6080e7          	jalr	-1306(ra) # 800031fc <iput>
    return 0;
    8000371e:	4981                	li	s3,0
    80003720:	bf19                	j	80003636 <namex+0x6a>
  if(*path == 0)
    80003722:	d7fd                	beqz	a5,80003710 <namex+0x144>
  while(*path != '/' && *path != 0)
    80003724:	0004c783          	lbu	a5,0(s1)
    80003728:	85a6                	mv	a1,s1
    8000372a:	b7d1                	j	800036ee <namex+0x122>

000000008000372c <dirlink>:
{
    8000372c:	7139                	addi	sp,sp,-64
    8000372e:	fc06                	sd	ra,56(sp)
    80003730:	f822                	sd	s0,48(sp)
    80003732:	f426                	sd	s1,40(sp)
    80003734:	f04a                	sd	s2,32(sp)
    80003736:	ec4e                	sd	s3,24(sp)
    80003738:	e852                	sd	s4,16(sp)
    8000373a:	0080                	addi	s0,sp,64
    8000373c:	892a                	mv	s2,a0
    8000373e:	8a2e                	mv	s4,a1
    80003740:	89b2                	mv	s3,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    80003742:	4601                	li	a2,0
    80003744:	00000097          	auipc	ra,0x0
    80003748:	dd8080e7          	jalr	-552(ra) # 8000351c <dirlookup>
    8000374c:	e93d                	bnez	a0,800037c2 <dirlink+0x96>
  for(off = 0; off < dp->size; off += sizeof(de)){
    8000374e:	04c92483          	lw	s1,76(s2)
    80003752:	c49d                	beqz	s1,80003780 <dirlink+0x54>
    80003754:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003756:	4741                	li	a4,16
    80003758:	86a6                	mv	a3,s1
    8000375a:	fc040613          	addi	a2,s0,-64
    8000375e:	4581                	li	a1,0
    80003760:	854a                	mv	a0,s2
    80003762:	00000097          	auipc	ra,0x0
    80003766:	b94080e7          	jalr	-1132(ra) # 800032f6 <readi>
    8000376a:	47c1                	li	a5,16
    8000376c:	06f51163          	bne	a0,a5,800037ce <dirlink+0xa2>
    if(de.inum == 0)
    80003770:	fc045783          	lhu	a5,-64(s0)
    80003774:	c791                	beqz	a5,80003780 <dirlink+0x54>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003776:	24c1                	addiw	s1,s1,16
    80003778:	04c92783          	lw	a5,76(s2)
    8000377c:	fcf4ede3          	bltu	s1,a5,80003756 <dirlink+0x2a>
  strncpy(de.name, name, DIRSIZ);
    80003780:	4639                	li	a2,14
    80003782:	85d2                	mv	a1,s4
    80003784:	fc240513          	addi	a0,s0,-62
    80003788:	ffffd097          	auipc	ra,0xffffd
    8000378c:	b04080e7          	jalr	-1276(ra) # 8000028c <strncpy>
  de.inum = inum;
    80003790:	fd341023          	sh	s3,-64(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003794:	4741                	li	a4,16
    80003796:	86a6                	mv	a3,s1
    80003798:	fc040613          	addi	a2,s0,-64
    8000379c:	4581                	li	a1,0
    8000379e:	854a                	mv	a0,s2
    800037a0:	00000097          	auipc	ra,0x0
    800037a4:	c4e080e7          	jalr	-946(ra) # 800033ee <writei>
    800037a8:	872a                	mv	a4,a0
    800037aa:	47c1                	li	a5,16
  return 0;
    800037ac:	4501                	li	a0,0
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800037ae:	02f71863          	bne	a4,a5,800037de <dirlink+0xb2>
}
    800037b2:	70e2                	ld	ra,56(sp)
    800037b4:	7442                	ld	s0,48(sp)
    800037b6:	74a2                	ld	s1,40(sp)
    800037b8:	7902                	ld	s2,32(sp)
    800037ba:	69e2                	ld	s3,24(sp)
    800037bc:	6a42                	ld	s4,16(sp)
    800037be:	6121                	addi	sp,sp,64
    800037c0:	8082                	ret
    iput(ip);
    800037c2:	00000097          	auipc	ra,0x0
    800037c6:	a3a080e7          	jalr	-1478(ra) # 800031fc <iput>
    return -1;
    800037ca:	557d                	li	a0,-1
    800037cc:	b7dd                	j	800037b2 <dirlink+0x86>
      panic("dirlink read");
    800037ce:	00005517          	auipc	a0,0x5
    800037d2:	ea250513          	addi	a0,a0,-350 # 80008670 <syscalls+0x220>
    800037d6:	00003097          	auipc	ra,0x3
    800037da:	c6a080e7          	jalr	-918(ra) # 80006440 <panic>
    panic("dirlink");
    800037de:	00005517          	auipc	a0,0x5
    800037e2:	03a50513          	addi	a0,a0,58 # 80008818 <syscalls+0x3c8>
    800037e6:	00003097          	auipc	ra,0x3
    800037ea:	c5a080e7          	jalr	-934(ra) # 80006440 <panic>

00000000800037ee <namei>:

struct inode*
namei(char *path)
{
    800037ee:	1101                	addi	sp,sp,-32
    800037f0:	ec06                	sd	ra,24(sp)
    800037f2:	e822                	sd	s0,16(sp)
    800037f4:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    800037f6:	fe040613          	addi	a2,s0,-32
    800037fa:	4581                	li	a1,0
    800037fc:	00000097          	auipc	ra,0x0
    80003800:	dd0080e7          	jalr	-560(ra) # 800035cc <namex>
}
    80003804:	60e2                	ld	ra,24(sp)
    80003806:	6442                	ld	s0,16(sp)
    80003808:	6105                	addi	sp,sp,32
    8000380a:	8082                	ret

000000008000380c <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    8000380c:	1141                	addi	sp,sp,-16
    8000380e:	e406                	sd	ra,8(sp)
    80003810:	e022                	sd	s0,0(sp)
    80003812:	0800                	addi	s0,sp,16
    80003814:	862e                	mv	a2,a1
  return namex(path, 1, name);
    80003816:	4585                	li	a1,1
    80003818:	00000097          	auipc	ra,0x0
    8000381c:	db4080e7          	jalr	-588(ra) # 800035cc <namex>
}
    80003820:	60a2                	ld	ra,8(sp)
    80003822:	6402                	ld	s0,0(sp)
    80003824:	0141                	addi	sp,sp,16
    80003826:	8082                	ret

0000000080003828 <balloc_page>:

/* NTU OS 2024 */
/* Similar to balloc, except allocates eight consecutive free blocks. */
uint balloc_page(uint dev) {
    80003828:	715d                	addi	sp,sp,-80
    8000382a:	e486                	sd	ra,72(sp)
    8000382c:	e0a2                	sd	s0,64(sp)
    8000382e:	fc26                	sd	s1,56(sp)
    80003830:	f84a                	sd	s2,48(sp)
    80003832:	f44e                	sd	s3,40(sp)
    80003834:	f052                	sd	s4,32(sp)
    80003836:	ec56                	sd	s5,24(sp)
    80003838:	e85a                	sd	s6,16(sp)
    8000383a:	e45e                	sd	s7,8(sp)
    8000383c:	0880                	addi	s0,sp,80
  for (int b = 0; b < sb.size; b += BPB) {
    8000383e:	00014797          	auipc	a5,0x14
    80003842:	d1e7a783          	lw	a5,-738(a5) # 8001755c <sb+0x4>
    80003846:	c3e9                	beqz	a5,80003908 <balloc_page+0xe0>
    80003848:	89aa                	mv	s3,a0
    8000384a:	4a01                	li	s4,0
    struct buf *bp = bread(dev, BBLOCK(b, sb));
    8000384c:	00014a97          	auipc	s5,0x14
    80003850:	d0ca8a93          	addi	s5,s5,-756 # 80017558 <sb>

    for (int bi = 0; bi < BPB && b + bi < sb.size; bi += 8) {
    80003854:	4b01                	li	s6,0
    80003856:	6909                	lui	s2,0x2
  for (int b = 0; b < sb.size; b += BPB) {
    80003858:	6b89                	lui	s7,0x2
    8000385a:	a8b9                	j	800038b8 <balloc_page+0x90>
      uchar *bits = &bp->data[bi / 8];
      if (*bits == 0) {
        *bits |= 0xff; // Mark 8 consecutive blocks in use.
    8000385c:	97aa                	add	a5,a5,a0
    8000385e:	577d                	li	a4,-1
    80003860:	04e78c23          	sb	a4,88(a5)
        //log_write(bp);
        brelse(bp);
    80003864:	fffff097          	auipc	ra,0xfffff
    80003868:	070080e7          	jalr	112(ra) # 800028d4 <brelse>

        for (int i = 0; i < 8; i += 1) {
    8000386c:	00848a1b          	addiw	s4,s1,8
        brelse(bp);
    80003870:	8926                	mv	s2,s1
          bzero(dev, b + bi + i);
    80003872:	2981                	sext.w	s3,s3
    80003874:	0009059b          	sext.w	a1,s2
    80003878:	854e                	mv	a0,s3
    8000387a:	fffff097          	auipc	ra,0xfffff
    8000387e:	29e080e7          	jalr	670(ra) # 80002b18 <bzero>
        for (int i = 0; i < 8; i += 1) {
    80003882:	2905                	addiw	s2,s2,1
    80003884:	ff4918e3          	bne	s2,s4,80003874 <balloc_page+0x4c>
    }

    brelse(bp);
  }
  panic("balloc_page: out of blocks");
}
    80003888:	8526                	mv	a0,s1
    8000388a:	60a6                	ld	ra,72(sp)
    8000388c:	6406                	ld	s0,64(sp)
    8000388e:	74e2                	ld	s1,56(sp)
    80003890:	7942                	ld	s2,48(sp)
    80003892:	79a2                	ld	s3,40(sp)
    80003894:	7a02                	ld	s4,32(sp)
    80003896:	6ae2                	ld	s5,24(sp)
    80003898:	6b42                	ld	s6,16(sp)
    8000389a:	6ba2                	ld	s7,8(sp)
    8000389c:	6161                	addi	sp,sp,80
    8000389e:	8082                	ret
    brelse(bp);
    800038a0:	fffff097          	auipc	ra,0xfffff
    800038a4:	034080e7          	jalr	52(ra) # 800028d4 <brelse>
  for (int b = 0; b < sb.size; b += BPB) {
    800038a8:	014b87bb          	addw	a5,s7,s4
    800038ac:	00078a1b          	sext.w	s4,a5
    800038b0:	004aa703          	lw	a4,4(s5)
    800038b4:	04ea7a63          	bgeu	s4,a4,80003908 <balloc_page+0xe0>
    struct buf *bp = bread(dev, BBLOCK(b, sb));
    800038b8:	41fa579b          	sraiw	a5,s4,0x1f
    800038bc:	0137d79b          	srliw	a5,a5,0x13
    800038c0:	014787bb          	addw	a5,a5,s4
    800038c4:	40d7d79b          	sraiw	a5,a5,0xd
    800038c8:	01caa583          	lw	a1,28(s5)
    800038cc:	9dbd                	addw	a1,a1,a5
    800038ce:	854e                	mv	a0,s3
    800038d0:	fffff097          	auipc	ra,0xfffff
    800038d4:	f92080e7          	jalr	-110(ra) # 80002862 <bread>
    for (int bi = 0; bi < BPB && b + bi < sb.size; bi += 8) {
    800038d8:	004aa603          	lw	a2,4(s5)
    800038dc:	000a049b          	sext.w	s1,s4
    800038e0:	875a                	mv	a4,s6
    800038e2:	fac4ffe3          	bgeu	s1,a2,800038a0 <balloc_page+0x78>
      uchar *bits = &bp->data[bi / 8];
    800038e6:	41f7579b          	sraiw	a5,a4,0x1f
    800038ea:	01d7d79b          	srliw	a5,a5,0x1d
    800038ee:	9fb9                	addw	a5,a5,a4
    800038f0:	4037d79b          	sraiw	a5,a5,0x3
      if (*bits == 0) {
    800038f4:	00f506b3          	add	a3,a0,a5
    800038f8:	0586c683          	lbu	a3,88(a3)
    800038fc:	d2a5                	beqz	a3,8000385c <balloc_page+0x34>
    for (int bi = 0; bi < BPB && b + bi < sb.size; bi += 8) {
    800038fe:	2721                	addiw	a4,a4,8
    80003900:	24a1                	addiw	s1,s1,8
    80003902:	ff2710e3          	bne	a4,s2,800038e2 <balloc_page+0xba>
    80003906:	bf69                	j	800038a0 <balloc_page+0x78>
  panic("balloc_page: out of blocks");
    80003908:	00005517          	auipc	a0,0x5
    8000390c:	d7850513          	addi	a0,a0,-648 # 80008680 <syscalls+0x230>
    80003910:	00003097          	auipc	ra,0x3
    80003914:	b30080e7          	jalr	-1232(ra) # 80006440 <panic>

0000000080003918 <bfree_page>:

/* NTU OS 2024 */
/* Free 8 disk blocks allocated from balloc_page(). */
void bfree_page(int dev, uint blockno) {
    80003918:	1101                	addi	sp,sp,-32
    8000391a:	ec06                	sd	ra,24(sp)
    8000391c:	e822                	sd	s0,16(sp)
    8000391e:	e426                	sd	s1,8(sp)
    80003920:	1000                	addi	s0,sp,32
  if (blockno + 8 > sb.size) {
    80003922:	0085871b          	addiw	a4,a1,8
    80003926:	00014797          	auipc	a5,0x14
    8000392a:	c367a783          	lw	a5,-970(a5) # 8001755c <sb+0x4>
    8000392e:	04e7ee63          	bltu	a5,a4,8000398a <bfree_page+0x72>
    panic("bfree_page: blockno out of bound");
  }

  if ((blockno % 8) != 0) {
    80003932:	0075f793          	andi	a5,a1,7
    80003936:	e3b5                	bnez	a5,8000399a <bfree_page+0x82>
    panic("bfree_page: blockno is not aligned");
  }

  int bi = blockno % BPB;
    80003938:	03359493          	slli	s1,a1,0x33
    8000393c:	90cd                	srli	s1,s1,0x33
  int b = blockno - bi;
    8000393e:	9d85                	subw	a1,a1,s1
  struct buf *bp = bread(dev, BBLOCK(b, sb));
    80003940:	41f5d79b          	sraiw	a5,a1,0x1f
    80003944:	0137d79b          	srliw	a5,a5,0x13
    80003948:	9dbd                	addw	a1,a1,a5
    8000394a:	40d5d59b          	sraiw	a1,a1,0xd
    8000394e:	00014797          	auipc	a5,0x14
    80003952:	c267a783          	lw	a5,-986(a5) # 80017574 <sb+0x1c>
    80003956:	9dbd                	addw	a1,a1,a5
    80003958:	fffff097          	auipc	ra,0xfffff
    8000395c:	f0a080e7          	jalr	-246(ra) # 80002862 <bread>
  uchar *bits = &bp->data[bi / 8];
    80003960:	808d                	srli	s1,s1,0x3

  if (*bits != 0xff) {
    80003962:	009507b3          	add	a5,a0,s1
    80003966:	0587c703          	lbu	a4,88(a5)
    8000396a:	0ff00793          	li	a5,255
    8000396e:	02f71e63          	bne	a4,a5,800039aa <bfree_page+0x92>
    panic("bfree_page: data bits are invalid");
  }

  *bits = 0;
    80003972:	94aa                	add	s1,s1,a0
    80003974:	04048c23          	sb	zero,88(s1)
  //log_write(bp);
  brelse(bp);
    80003978:	fffff097          	auipc	ra,0xfffff
    8000397c:	f5c080e7          	jalr	-164(ra) # 800028d4 <brelse>
}
    80003980:	60e2                	ld	ra,24(sp)
    80003982:	6442                	ld	s0,16(sp)
    80003984:	64a2                	ld	s1,8(sp)
    80003986:	6105                	addi	sp,sp,32
    80003988:	8082                	ret
    panic("bfree_page: blockno out of bound");
    8000398a:	00005517          	auipc	a0,0x5
    8000398e:	d1650513          	addi	a0,a0,-746 # 800086a0 <syscalls+0x250>
    80003992:	00003097          	auipc	ra,0x3
    80003996:	aae080e7          	jalr	-1362(ra) # 80006440 <panic>
    panic("bfree_page: blockno is not aligned");
    8000399a:	00005517          	auipc	a0,0x5
    8000399e:	d2e50513          	addi	a0,a0,-722 # 800086c8 <syscalls+0x278>
    800039a2:	00003097          	auipc	ra,0x3
    800039a6:	a9e080e7          	jalr	-1378(ra) # 80006440 <panic>
    panic("bfree_page: data bits are invalid");
    800039aa:	00005517          	auipc	a0,0x5
    800039ae:	d4650513          	addi	a0,a0,-698 # 800086f0 <syscalls+0x2a0>
    800039b2:	00003097          	auipc	ra,0x3
    800039b6:	a8e080e7          	jalr	-1394(ra) # 80006440 <panic>

00000000800039ba <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    800039ba:	1101                	addi	sp,sp,-32
    800039bc:	ec06                	sd	ra,24(sp)
    800039be:	e822                	sd	s0,16(sp)
    800039c0:	e426                	sd	s1,8(sp)
    800039c2:	e04a                	sd	s2,0(sp)
    800039c4:	1000                	addi	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    800039c6:	00015917          	auipc	s2,0x15
    800039ca:	65a90913          	addi	s2,s2,1626 # 80019020 <log>
    800039ce:	01892583          	lw	a1,24(s2)
    800039d2:	02892503          	lw	a0,40(s2)
    800039d6:	fffff097          	auipc	ra,0xfffff
    800039da:	e8c080e7          	jalr	-372(ra) # 80002862 <bread>
    800039de:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    800039e0:	02c92683          	lw	a3,44(s2)
    800039e4:	cd34                	sw	a3,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    800039e6:	02d05763          	blez	a3,80003a14 <write_head+0x5a>
    800039ea:	00015797          	auipc	a5,0x15
    800039ee:	66678793          	addi	a5,a5,1638 # 80019050 <log+0x30>
    800039f2:	05c50713          	addi	a4,a0,92
    800039f6:	36fd                	addiw	a3,a3,-1
    800039f8:	1682                	slli	a3,a3,0x20
    800039fa:	9281                	srli	a3,a3,0x20
    800039fc:	068a                	slli	a3,a3,0x2
    800039fe:	00015617          	auipc	a2,0x15
    80003a02:	65660613          	addi	a2,a2,1622 # 80019054 <log+0x34>
    80003a06:	96b2                	add	a3,a3,a2
    hb->block[i] = log.lh.block[i];
    80003a08:	4390                	lw	a2,0(a5)
    80003a0a:	c310                	sw	a2,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    80003a0c:	0791                	addi	a5,a5,4
    80003a0e:	0711                	addi	a4,a4,4
    80003a10:	fed79ce3          	bne	a5,a3,80003a08 <write_head+0x4e>
  }
  bwrite(buf);
    80003a14:	8526                	mv	a0,s1
    80003a16:	fffff097          	auipc	ra,0xfffff
    80003a1a:	e80080e7          	jalr	-384(ra) # 80002896 <bwrite>
  brelse(buf);
    80003a1e:	8526                	mv	a0,s1
    80003a20:	fffff097          	auipc	ra,0xfffff
    80003a24:	eb4080e7          	jalr	-332(ra) # 800028d4 <brelse>
}
    80003a28:	60e2                	ld	ra,24(sp)
    80003a2a:	6442                	ld	s0,16(sp)
    80003a2c:	64a2                	ld	s1,8(sp)
    80003a2e:	6902                	ld	s2,0(sp)
    80003a30:	6105                	addi	sp,sp,32
    80003a32:	8082                	ret

0000000080003a34 <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    80003a34:	00015797          	auipc	a5,0x15
    80003a38:	6187a783          	lw	a5,1560(a5) # 8001904c <log+0x2c>
    80003a3c:	0af05d63          	blez	a5,80003af6 <install_trans+0xc2>
{
    80003a40:	7139                	addi	sp,sp,-64
    80003a42:	fc06                	sd	ra,56(sp)
    80003a44:	f822                	sd	s0,48(sp)
    80003a46:	f426                	sd	s1,40(sp)
    80003a48:	f04a                	sd	s2,32(sp)
    80003a4a:	ec4e                	sd	s3,24(sp)
    80003a4c:	e852                	sd	s4,16(sp)
    80003a4e:	e456                	sd	s5,8(sp)
    80003a50:	e05a                	sd	s6,0(sp)
    80003a52:	0080                	addi	s0,sp,64
    80003a54:	8b2a                	mv	s6,a0
    80003a56:	00015a97          	auipc	s5,0x15
    80003a5a:	5faa8a93          	addi	s5,s5,1530 # 80019050 <log+0x30>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003a5e:	4a01                	li	s4,0
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80003a60:	00015997          	auipc	s3,0x15
    80003a64:	5c098993          	addi	s3,s3,1472 # 80019020 <log>
    80003a68:	a035                	j	80003a94 <install_trans+0x60>
      bunpin(dbuf);
    80003a6a:	8526                	mv	a0,s1
    80003a6c:	fffff097          	auipc	ra,0xfffff
    80003a70:	f42080e7          	jalr	-190(ra) # 800029ae <bunpin>
    brelse(lbuf);
    80003a74:	854a                	mv	a0,s2
    80003a76:	fffff097          	auipc	ra,0xfffff
    80003a7a:	e5e080e7          	jalr	-418(ra) # 800028d4 <brelse>
    brelse(dbuf);
    80003a7e:	8526                	mv	a0,s1
    80003a80:	fffff097          	auipc	ra,0xfffff
    80003a84:	e54080e7          	jalr	-428(ra) # 800028d4 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003a88:	2a05                	addiw	s4,s4,1
    80003a8a:	0a91                	addi	s5,s5,4
    80003a8c:	02c9a783          	lw	a5,44(s3)
    80003a90:	04fa5963          	bge	s4,a5,80003ae2 <install_trans+0xae>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80003a94:	0189a583          	lw	a1,24(s3)
    80003a98:	014585bb          	addw	a1,a1,s4
    80003a9c:	2585                	addiw	a1,a1,1
    80003a9e:	0289a503          	lw	a0,40(s3)
    80003aa2:	fffff097          	auipc	ra,0xfffff
    80003aa6:	dc0080e7          	jalr	-576(ra) # 80002862 <bread>
    80003aaa:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    80003aac:	000aa583          	lw	a1,0(s5)
    80003ab0:	0289a503          	lw	a0,40(s3)
    80003ab4:	fffff097          	auipc	ra,0xfffff
    80003ab8:	dae080e7          	jalr	-594(ra) # 80002862 <bread>
    80003abc:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80003abe:	40000613          	li	a2,1024
    80003ac2:	05890593          	addi	a1,s2,88
    80003ac6:	05850513          	addi	a0,a0,88
    80003aca:	ffffc097          	auipc	ra,0xffffc
    80003ace:	70e080e7          	jalr	1806(ra) # 800001d8 <memmove>
    bwrite(dbuf);  // write dst to disk
    80003ad2:	8526                	mv	a0,s1
    80003ad4:	fffff097          	auipc	ra,0xfffff
    80003ad8:	dc2080e7          	jalr	-574(ra) # 80002896 <bwrite>
    if(recovering == 0)
    80003adc:	f80b1ce3          	bnez	s6,80003a74 <install_trans+0x40>
    80003ae0:	b769                	j	80003a6a <install_trans+0x36>
}
    80003ae2:	70e2                	ld	ra,56(sp)
    80003ae4:	7442                	ld	s0,48(sp)
    80003ae6:	74a2                	ld	s1,40(sp)
    80003ae8:	7902                	ld	s2,32(sp)
    80003aea:	69e2                	ld	s3,24(sp)
    80003aec:	6a42                	ld	s4,16(sp)
    80003aee:	6aa2                	ld	s5,8(sp)
    80003af0:	6b02                	ld	s6,0(sp)
    80003af2:	6121                	addi	sp,sp,64
    80003af4:	8082                	ret
    80003af6:	8082                	ret

0000000080003af8 <initlog>:
{
    80003af8:	7179                	addi	sp,sp,-48
    80003afa:	f406                	sd	ra,40(sp)
    80003afc:	f022                	sd	s0,32(sp)
    80003afe:	ec26                	sd	s1,24(sp)
    80003b00:	e84a                	sd	s2,16(sp)
    80003b02:	e44e                	sd	s3,8(sp)
    80003b04:	1800                	addi	s0,sp,48
    80003b06:	892a                	mv	s2,a0
    80003b08:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    80003b0a:	00015497          	auipc	s1,0x15
    80003b0e:	51648493          	addi	s1,s1,1302 # 80019020 <log>
    80003b12:	00005597          	auipc	a1,0x5
    80003b16:	c0658593          	addi	a1,a1,-1018 # 80008718 <syscalls+0x2c8>
    80003b1a:	8526                	mv	a0,s1
    80003b1c:	00003097          	auipc	ra,0x3
    80003b20:	dde080e7          	jalr	-546(ra) # 800068fa <initlock>
  log.start = sb->logstart;
    80003b24:	0149a583          	lw	a1,20(s3)
    80003b28:	cc8c                	sw	a1,24(s1)
  log.size = sb->nlog;
    80003b2a:	0109a783          	lw	a5,16(s3)
    80003b2e:	ccdc                	sw	a5,28(s1)
  log.dev = dev;
    80003b30:	0324a423          	sw	s2,40(s1)
  struct buf *buf = bread(log.dev, log.start);
    80003b34:	854a                	mv	a0,s2
    80003b36:	fffff097          	auipc	ra,0xfffff
    80003b3a:	d2c080e7          	jalr	-724(ra) # 80002862 <bread>
  log.lh.n = lh->n;
    80003b3e:	4d3c                	lw	a5,88(a0)
    80003b40:	d4dc                	sw	a5,44(s1)
  for (i = 0; i < log.lh.n; i++) {
    80003b42:	02f05563          	blez	a5,80003b6c <initlog+0x74>
    80003b46:	05c50713          	addi	a4,a0,92
    80003b4a:	00015697          	auipc	a3,0x15
    80003b4e:	50668693          	addi	a3,a3,1286 # 80019050 <log+0x30>
    80003b52:	37fd                	addiw	a5,a5,-1
    80003b54:	1782                	slli	a5,a5,0x20
    80003b56:	9381                	srli	a5,a5,0x20
    80003b58:	078a                	slli	a5,a5,0x2
    80003b5a:	06050613          	addi	a2,a0,96
    80003b5e:	97b2                	add	a5,a5,a2
    log.lh.block[i] = lh->block[i];
    80003b60:	4310                	lw	a2,0(a4)
    80003b62:	c290                	sw	a2,0(a3)
  for (i = 0; i < log.lh.n; i++) {
    80003b64:	0711                	addi	a4,a4,4
    80003b66:	0691                	addi	a3,a3,4
    80003b68:	fef71ce3          	bne	a4,a5,80003b60 <initlog+0x68>
  brelse(buf);
    80003b6c:	fffff097          	auipc	ra,0xfffff
    80003b70:	d68080e7          	jalr	-664(ra) # 800028d4 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    80003b74:	4505                	li	a0,1
    80003b76:	00000097          	auipc	ra,0x0
    80003b7a:	ebe080e7          	jalr	-322(ra) # 80003a34 <install_trans>
  log.lh.n = 0;
    80003b7e:	00015797          	auipc	a5,0x15
    80003b82:	4c07a723          	sw	zero,1230(a5) # 8001904c <log+0x2c>
  write_head(); // clear the log
    80003b86:	00000097          	auipc	ra,0x0
    80003b8a:	e34080e7          	jalr	-460(ra) # 800039ba <write_head>
}
    80003b8e:	70a2                	ld	ra,40(sp)
    80003b90:	7402                	ld	s0,32(sp)
    80003b92:	64e2                	ld	s1,24(sp)
    80003b94:	6942                	ld	s2,16(sp)
    80003b96:	69a2                	ld	s3,8(sp)
    80003b98:	6145                	addi	sp,sp,48
    80003b9a:	8082                	ret

0000000080003b9c <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    80003b9c:	1101                	addi	sp,sp,-32
    80003b9e:	ec06                	sd	ra,24(sp)
    80003ba0:	e822                	sd	s0,16(sp)
    80003ba2:	e426                	sd	s1,8(sp)
    80003ba4:	e04a                	sd	s2,0(sp)
    80003ba6:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    80003ba8:	00015517          	auipc	a0,0x15
    80003bac:	47850513          	addi	a0,a0,1144 # 80019020 <log>
    80003bb0:	00003097          	auipc	ra,0x3
    80003bb4:	dda080e7          	jalr	-550(ra) # 8000698a <acquire>
  while(1){
    if(log.committing){
    80003bb8:	00015497          	auipc	s1,0x15
    80003bbc:	46848493          	addi	s1,s1,1128 # 80019020 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80003bc0:	4979                	li	s2,30
    80003bc2:	a039                	j	80003bd0 <begin_op+0x34>
      sleep(&log, &log.lock);
    80003bc4:	85a6                	mv	a1,s1
    80003bc6:	8526                	mv	a0,s1
    80003bc8:	ffffe097          	auipc	ra,0xffffe
    80003bcc:	e32080e7          	jalr	-462(ra) # 800019fa <sleep>
    if(log.committing){
    80003bd0:	50dc                	lw	a5,36(s1)
    80003bd2:	fbed                	bnez	a5,80003bc4 <begin_op+0x28>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80003bd4:	509c                	lw	a5,32(s1)
    80003bd6:	0017871b          	addiw	a4,a5,1
    80003bda:	0007069b          	sext.w	a3,a4
    80003bde:	0027179b          	slliw	a5,a4,0x2
    80003be2:	9fb9                	addw	a5,a5,a4
    80003be4:	0017979b          	slliw	a5,a5,0x1
    80003be8:	54d8                	lw	a4,44(s1)
    80003bea:	9fb9                	addw	a5,a5,a4
    80003bec:	00f95963          	bge	s2,a5,80003bfe <begin_op+0x62>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    80003bf0:	85a6                	mv	a1,s1
    80003bf2:	8526                	mv	a0,s1
    80003bf4:	ffffe097          	auipc	ra,0xffffe
    80003bf8:	e06080e7          	jalr	-506(ra) # 800019fa <sleep>
    80003bfc:	bfd1                	j	80003bd0 <begin_op+0x34>
    } else {
      log.outstanding += 1;
    80003bfe:	00015517          	auipc	a0,0x15
    80003c02:	42250513          	addi	a0,a0,1058 # 80019020 <log>
    80003c06:	d114                	sw	a3,32(a0)
      release(&log.lock);
    80003c08:	00003097          	auipc	ra,0x3
    80003c0c:	e36080e7          	jalr	-458(ra) # 80006a3e <release>
      break;
    }
  }
}
    80003c10:	60e2                	ld	ra,24(sp)
    80003c12:	6442                	ld	s0,16(sp)
    80003c14:	64a2                	ld	s1,8(sp)
    80003c16:	6902                	ld	s2,0(sp)
    80003c18:	6105                	addi	sp,sp,32
    80003c1a:	8082                	ret

0000000080003c1c <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    80003c1c:	7139                	addi	sp,sp,-64
    80003c1e:	fc06                	sd	ra,56(sp)
    80003c20:	f822                	sd	s0,48(sp)
    80003c22:	f426                	sd	s1,40(sp)
    80003c24:	f04a                	sd	s2,32(sp)
    80003c26:	ec4e                	sd	s3,24(sp)
    80003c28:	e852                	sd	s4,16(sp)
    80003c2a:	e456                	sd	s5,8(sp)
    80003c2c:	0080                	addi	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    80003c2e:	00015497          	auipc	s1,0x15
    80003c32:	3f248493          	addi	s1,s1,1010 # 80019020 <log>
    80003c36:	8526                	mv	a0,s1
    80003c38:	00003097          	auipc	ra,0x3
    80003c3c:	d52080e7          	jalr	-686(ra) # 8000698a <acquire>
  log.outstanding -= 1;
    80003c40:	509c                	lw	a5,32(s1)
    80003c42:	37fd                	addiw	a5,a5,-1
    80003c44:	0007891b          	sext.w	s2,a5
    80003c48:	d09c                	sw	a5,32(s1)
  if(log.committing)
    80003c4a:	50dc                	lw	a5,36(s1)
    80003c4c:	efb9                	bnez	a5,80003caa <end_op+0x8e>
    panic("log.committing");
  if(log.outstanding == 0){
    80003c4e:	06091663          	bnez	s2,80003cba <end_op+0x9e>
    do_commit = 1;
    log.committing = 1;
    80003c52:	00015497          	auipc	s1,0x15
    80003c56:	3ce48493          	addi	s1,s1,974 # 80019020 <log>
    80003c5a:	4785                	li	a5,1
    80003c5c:	d0dc                	sw	a5,36(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    80003c5e:	8526                	mv	a0,s1
    80003c60:	00003097          	auipc	ra,0x3
    80003c64:	dde080e7          	jalr	-546(ra) # 80006a3e <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    80003c68:	54dc                	lw	a5,44(s1)
    80003c6a:	06f04763          	bgtz	a5,80003cd8 <end_op+0xbc>
    acquire(&log.lock);
    80003c6e:	00015497          	auipc	s1,0x15
    80003c72:	3b248493          	addi	s1,s1,946 # 80019020 <log>
    80003c76:	8526                	mv	a0,s1
    80003c78:	00003097          	auipc	ra,0x3
    80003c7c:	d12080e7          	jalr	-750(ra) # 8000698a <acquire>
    log.committing = 0;
    80003c80:	0204a223          	sw	zero,36(s1)
    wakeup(&log);
    80003c84:	8526                	mv	a0,s1
    80003c86:	ffffe097          	auipc	ra,0xffffe
    80003c8a:	f00080e7          	jalr	-256(ra) # 80001b86 <wakeup>
    release(&log.lock);
    80003c8e:	8526                	mv	a0,s1
    80003c90:	00003097          	auipc	ra,0x3
    80003c94:	dae080e7          	jalr	-594(ra) # 80006a3e <release>
}
    80003c98:	70e2                	ld	ra,56(sp)
    80003c9a:	7442                	ld	s0,48(sp)
    80003c9c:	74a2                	ld	s1,40(sp)
    80003c9e:	7902                	ld	s2,32(sp)
    80003ca0:	69e2                	ld	s3,24(sp)
    80003ca2:	6a42                	ld	s4,16(sp)
    80003ca4:	6aa2                	ld	s5,8(sp)
    80003ca6:	6121                	addi	sp,sp,64
    80003ca8:	8082                	ret
    panic("log.committing");
    80003caa:	00005517          	auipc	a0,0x5
    80003cae:	a7650513          	addi	a0,a0,-1418 # 80008720 <syscalls+0x2d0>
    80003cb2:	00002097          	auipc	ra,0x2
    80003cb6:	78e080e7          	jalr	1934(ra) # 80006440 <panic>
    wakeup(&log);
    80003cba:	00015497          	auipc	s1,0x15
    80003cbe:	36648493          	addi	s1,s1,870 # 80019020 <log>
    80003cc2:	8526                	mv	a0,s1
    80003cc4:	ffffe097          	auipc	ra,0xffffe
    80003cc8:	ec2080e7          	jalr	-318(ra) # 80001b86 <wakeup>
  release(&log.lock);
    80003ccc:	8526                	mv	a0,s1
    80003cce:	00003097          	auipc	ra,0x3
    80003cd2:	d70080e7          	jalr	-656(ra) # 80006a3e <release>
  if(do_commit){
    80003cd6:	b7c9                	j	80003c98 <end_op+0x7c>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003cd8:	00015a97          	auipc	s5,0x15
    80003cdc:	378a8a93          	addi	s5,s5,888 # 80019050 <log+0x30>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    80003ce0:	00015a17          	auipc	s4,0x15
    80003ce4:	340a0a13          	addi	s4,s4,832 # 80019020 <log>
    80003ce8:	018a2583          	lw	a1,24(s4)
    80003cec:	012585bb          	addw	a1,a1,s2
    80003cf0:	2585                	addiw	a1,a1,1
    80003cf2:	028a2503          	lw	a0,40(s4)
    80003cf6:	fffff097          	auipc	ra,0xfffff
    80003cfa:	b6c080e7          	jalr	-1172(ra) # 80002862 <bread>
    80003cfe:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    80003d00:	000aa583          	lw	a1,0(s5)
    80003d04:	028a2503          	lw	a0,40(s4)
    80003d08:	fffff097          	auipc	ra,0xfffff
    80003d0c:	b5a080e7          	jalr	-1190(ra) # 80002862 <bread>
    80003d10:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    80003d12:	40000613          	li	a2,1024
    80003d16:	05850593          	addi	a1,a0,88
    80003d1a:	05848513          	addi	a0,s1,88
    80003d1e:	ffffc097          	auipc	ra,0xffffc
    80003d22:	4ba080e7          	jalr	1210(ra) # 800001d8 <memmove>
    bwrite(to);  // write the log
    80003d26:	8526                	mv	a0,s1
    80003d28:	fffff097          	auipc	ra,0xfffff
    80003d2c:	b6e080e7          	jalr	-1170(ra) # 80002896 <bwrite>
    brelse(from);
    80003d30:	854e                	mv	a0,s3
    80003d32:	fffff097          	auipc	ra,0xfffff
    80003d36:	ba2080e7          	jalr	-1118(ra) # 800028d4 <brelse>
    brelse(to);
    80003d3a:	8526                	mv	a0,s1
    80003d3c:	fffff097          	auipc	ra,0xfffff
    80003d40:	b98080e7          	jalr	-1128(ra) # 800028d4 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003d44:	2905                	addiw	s2,s2,1
    80003d46:	0a91                	addi	s5,s5,4
    80003d48:	02ca2783          	lw	a5,44(s4)
    80003d4c:	f8f94ee3          	blt	s2,a5,80003ce8 <end_op+0xcc>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    80003d50:	00000097          	auipc	ra,0x0
    80003d54:	c6a080e7          	jalr	-918(ra) # 800039ba <write_head>
    install_trans(0); // Now install writes to home locations
    80003d58:	4501                	li	a0,0
    80003d5a:	00000097          	auipc	ra,0x0
    80003d5e:	cda080e7          	jalr	-806(ra) # 80003a34 <install_trans>
    log.lh.n = 0;
    80003d62:	00015797          	auipc	a5,0x15
    80003d66:	2e07a523          	sw	zero,746(a5) # 8001904c <log+0x2c>
    write_head();    // Erase the transaction from the log
    80003d6a:	00000097          	auipc	ra,0x0
    80003d6e:	c50080e7          	jalr	-944(ra) # 800039ba <write_head>
    80003d72:	bdf5                	j	80003c6e <end_op+0x52>

0000000080003d74 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    80003d74:	1101                	addi	sp,sp,-32
    80003d76:	ec06                	sd	ra,24(sp)
    80003d78:	e822                	sd	s0,16(sp)
    80003d7a:	e426                	sd	s1,8(sp)
    80003d7c:	e04a                	sd	s2,0(sp)
    80003d7e:	1000                	addi	s0,sp,32
    80003d80:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    80003d82:	00015917          	auipc	s2,0x15
    80003d86:	29e90913          	addi	s2,s2,670 # 80019020 <log>
    80003d8a:	854a                	mv	a0,s2
    80003d8c:	00003097          	auipc	ra,0x3
    80003d90:	bfe080e7          	jalr	-1026(ra) # 8000698a <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    80003d94:	02c92603          	lw	a2,44(s2)
    80003d98:	47f5                	li	a5,29
    80003d9a:	06c7c563          	blt	a5,a2,80003e04 <log_write+0x90>
    80003d9e:	00015797          	auipc	a5,0x15
    80003da2:	29e7a783          	lw	a5,670(a5) # 8001903c <log+0x1c>
    80003da6:	37fd                	addiw	a5,a5,-1
    80003da8:	04f65e63          	bge	a2,a5,80003e04 <log_write+0x90>
    panic("too big a transaction");
  if (log.outstanding < 1)
    80003dac:	00015797          	auipc	a5,0x15
    80003db0:	2947a783          	lw	a5,660(a5) # 80019040 <log+0x20>
    80003db4:	06f05063          	blez	a5,80003e14 <log_write+0xa0>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    80003db8:	4781                	li	a5,0
    80003dba:	06c05563          	blez	a2,80003e24 <log_write+0xb0>
    if (log.lh.block[i] == b->blockno)   // log absorption
    80003dbe:	44cc                	lw	a1,12(s1)
    80003dc0:	00015717          	auipc	a4,0x15
    80003dc4:	29070713          	addi	a4,a4,656 # 80019050 <log+0x30>
  for (i = 0; i < log.lh.n; i++) {
    80003dc8:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorption
    80003dca:	4314                	lw	a3,0(a4)
    80003dcc:	04b68c63          	beq	a3,a1,80003e24 <log_write+0xb0>
  for (i = 0; i < log.lh.n; i++) {
    80003dd0:	2785                	addiw	a5,a5,1
    80003dd2:	0711                	addi	a4,a4,4
    80003dd4:	fef61be3          	bne	a2,a5,80003dca <log_write+0x56>
      break;
  }
  log.lh.block[i] = b->blockno;
    80003dd8:	0621                	addi	a2,a2,8
    80003dda:	060a                	slli	a2,a2,0x2
    80003ddc:	00015797          	auipc	a5,0x15
    80003de0:	24478793          	addi	a5,a5,580 # 80019020 <log>
    80003de4:	963e                	add	a2,a2,a5
    80003de6:	44dc                	lw	a5,12(s1)
    80003de8:	ca1c                	sw	a5,16(a2)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    80003dea:	8526                	mv	a0,s1
    80003dec:	fffff097          	auipc	ra,0xfffff
    80003df0:	b86080e7          	jalr	-1146(ra) # 80002972 <bpin>
    log.lh.n++;
    80003df4:	00015717          	auipc	a4,0x15
    80003df8:	22c70713          	addi	a4,a4,556 # 80019020 <log>
    80003dfc:	575c                	lw	a5,44(a4)
    80003dfe:	2785                	addiw	a5,a5,1
    80003e00:	d75c                	sw	a5,44(a4)
    80003e02:	a835                	j	80003e3e <log_write+0xca>
    panic("too big a transaction");
    80003e04:	00005517          	auipc	a0,0x5
    80003e08:	92c50513          	addi	a0,a0,-1748 # 80008730 <syscalls+0x2e0>
    80003e0c:	00002097          	auipc	ra,0x2
    80003e10:	634080e7          	jalr	1588(ra) # 80006440 <panic>
    panic("log_write outside of trans");
    80003e14:	00005517          	auipc	a0,0x5
    80003e18:	93450513          	addi	a0,a0,-1740 # 80008748 <syscalls+0x2f8>
    80003e1c:	00002097          	auipc	ra,0x2
    80003e20:	624080e7          	jalr	1572(ra) # 80006440 <panic>
  log.lh.block[i] = b->blockno;
    80003e24:	00878713          	addi	a4,a5,8
    80003e28:	00271693          	slli	a3,a4,0x2
    80003e2c:	00015717          	auipc	a4,0x15
    80003e30:	1f470713          	addi	a4,a4,500 # 80019020 <log>
    80003e34:	9736                	add	a4,a4,a3
    80003e36:	44d4                	lw	a3,12(s1)
    80003e38:	cb14                	sw	a3,16(a4)
  if (i == log.lh.n) {  // Add new block to log?
    80003e3a:	faf608e3          	beq	a2,a5,80003dea <log_write+0x76>
  }
  release(&log.lock);
    80003e3e:	00015517          	auipc	a0,0x15
    80003e42:	1e250513          	addi	a0,a0,482 # 80019020 <log>
    80003e46:	00003097          	auipc	ra,0x3
    80003e4a:	bf8080e7          	jalr	-1032(ra) # 80006a3e <release>
}
    80003e4e:	60e2                	ld	ra,24(sp)
    80003e50:	6442                	ld	s0,16(sp)
    80003e52:	64a2                	ld	s1,8(sp)
    80003e54:	6902                	ld	s2,0(sp)
    80003e56:	6105                	addi	sp,sp,32
    80003e58:	8082                	ret

0000000080003e5a <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    80003e5a:	1101                	addi	sp,sp,-32
    80003e5c:	ec06                	sd	ra,24(sp)
    80003e5e:	e822                	sd	s0,16(sp)
    80003e60:	e426                	sd	s1,8(sp)
    80003e62:	e04a                	sd	s2,0(sp)
    80003e64:	1000                	addi	s0,sp,32
    80003e66:	84aa                	mv	s1,a0
    80003e68:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    80003e6a:	00005597          	auipc	a1,0x5
    80003e6e:	8fe58593          	addi	a1,a1,-1794 # 80008768 <syscalls+0x318>
    80003e72:	0521                	addi	a0,a0,8
    80003e74:	00003097          	auipc	ra,0x3
    80003e78:	a86080e7          	jalr	-1402(ra) # 800068fa <initlock>
  lk->name = name;
    80003e7c:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    80003e80:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003e84:	0204a423          	sw	zero,40(s1)
}
    80003e88:	60e2                	ld	ra,24(sp)
    80003e8a:	6442                	ld	s0,16(sp)
    80003e8c:	64a2                	ld	s1,8(sp)
    80003e8e:	6902                	ld	s2,0(sp)
    80003e90:	6105                	addi	sp,sp,32
    80003e92:	8082                	ret

0000000080003e94 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    80003e94:	1101                	addi	sp,sp,-32
    80003e96:	ec06                	sd	ra,24(sp)
    80003e98:	e822                	sd	s0,16(sp)
    80003e9a:	e426                	sd	s1,8(sp)
    80003e9c:	e04a                	sd	s2,0(sp)
    80003e9e:	1000                	addi	s0,sp,32
    80003ea0:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003ea2:	00850913          	addi	s2,a0,8
    80003ea6:	854a                	mv	a0,s2
    80003ea8:	00003097          	auipc	ra,0x3
    80003eac:	ae2080e7          	jalr	-1310(ra) # 8000698a <acquire>
  while (lk->locked) {
    80003eb0:	409c                	lw	a5,0(s1)
    80003eb2:	cb89                	beqz	a5,80003ec4 <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    80003eb4:	85ca                	mv	a1,s2
    80003eb6:	8526                	mv	a0,s1
    80003eb8:	ffffe097          	auipc	ra,0xffffe
    80003ebc:	b42080e7          	jalr	-1214(ra) # 800019fa <sleep>
  while (lk->locked) {
    80003ec0:	409c                	lw	a5,0(s1)
    80003ec2:	fbed                	bnez	a5,80003eb4 <acquiresleep+0x20>
  }
  lk->locked = 1;
    80003ec4:	4785                	li	a5,1
    80003ec6:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    80003ec8:	ffffd097          	auipc	ra,0xffffd
    80003ecc:	476080e7          	jalr	1142(ra) # 8000133e <myproc>
    80003ed0:	591c                	lw	a5,48(a0)
    80003ed2:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    80003ed4:	854a                	mv	a0,s2
    80003ed6:	00003097          	auipc	ra,0x3
    80003eda:	b68080e7          	jalr	-1176(ra) # 80006a3e <release>
}
    80003ede:	60e2                	ld	ra,24(sp)
    80003ee0:	6442                	ld	s0,16(sp)
    80003ee2:	64a2                	ld	s1,8(sp)
    80003ee4:	6902                	ld	s2,0(sp)
    80003ee6:	6105                	addi	sp,sp,32
    80003ee8:	8082                	ret

0000000080003eea <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    80003eea:	1101                	addi	sp,sp,-32
    80003eec:	ec06                	sd	ra,24(sp)
    80003eee:	e822                	sd	s0,16(sp)
    80003ef0:	e426                	sd	s1,8(sp)
    80003ef2:	e04a                	sd	s2,0(sp)
    80003ef4:	1000                	addi	s0,sp,32
    80003ef6:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003ef8:	00850913          	addi	s2,a0,8
    80003efc:	854a                	mv	a0,s2
    80003efe:	00003097          	auipc	ra,0x3
    80003f02:	a8c080e7          	jalr	-1396(ra) # 8000698a <acquire>
  lk->locked = 0;
    80003f06:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003f0a:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    80003f0e:	8526                	mv	a0,s1
    80003f10:	ffffe097          	auipc	ra,0xffffe
    80003f14:	c76080e7          	jalr	-906(ra) # 80001b86 <wakeup>
  release(&lk->lk);
    80003f18:	854a                	mv	a0,s2
    80003f1a:	00003097          	auipc	ra,0x3
    80003f1e:	b24080e7          	jalr	-1244(ra) # 80006a3e <release>
}
    80003f22:	60e2                	ld	ra,24(sp)
    80003f24:	6442                	ld	s0,16(sp)
    80003f26:	64a2                	ld	s1,8(sp)
    80003f28:	6902                	ld	s2,0(sp)
    80003f2a:	6105                	addi	sp,sp,32
    80003f2c:	8082                	ret

0000000080003f2e <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80003f2e:	7179                	addi	sp,sp,-48
    80003f30:	f406                	sd	ra,40(sp)
    80003f32:	f022                	sd	s0,32(sp)
    80003f34:	ec26                	sd	s1,24(sp)
    80003f36:	e84a                	sd	s2,16(sp)
    80003f38:	e44e                	sd	s3,8(sp)
    80003f3a:	1800                	addi	s0,sp,48
    80003f3c:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    80003f3e:	00850913          	addi	s2,a0,8
    80003f42:	854a                	mv	a0,s2
    80003f44:	00003097          	auipc	ra,0x3
    80003f48:	a46080e7          	jalr	-1466(ra) # 8000698a <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    80003f4c:	409c                	lw	a5,0(s1)
    80003f4e:	ef99                	bnez	a5,80003f6c <holdingsleep+0x3e>
    80003f50:	4481                	li	s1,0
  release(&lk->lk);
    80003f52:	854a                	mv	a0,s2
    80003f54:	00003097          	auipc	ra,0x3
    80003f58:	aea080e7          	jalr	-1302(ra) # 80006a3e <release>
  return r;
}
    80003f5c:	8526                	mv	a0,s1
    80003f5e:	70a2                	ld	ra,40(sp)
    80003f60:	7402                	ld	s0,32(sp)
    80003f62:	64e2                	ld	s1,24(sp)
    80003f64:	6942                	ld	s2,16(sp)
    80003f66:	69a2                	ld	s3,8(sp)
    80003f68:	6145                	addi	sp,sp,48
    80003f6a:	8082                	ret
  r = lk->locked && (lk->pid == myproc()->pid);
    80003f6c:	0284a983          	lw	s3,40(s1)
    80003f70:	ffffd097          	auipc	ra,0xffffd
    80003f74:	3ce080e7          	jalr	974(ra) # 8000133e <myproc>
    80003f78:	5904                	lw	s1,48(a0)
    80003f7a:	413484b3          	sub	s1,s1,s3
    80003f7e:	0014b493          	seqz	s1,s1
    80003f82:	bfc1                	j	80003f52 <holdingsleep+0x24>

0000000080003f84 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    80003f84:	1141                	addi	sp,sp,-16
    80003f86:	e406                	sd	ra,8(sp)
    80003f88:	e022                	sd	s0,0(sp)
    80003f8a:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80003f8c:	00004597          	auipc	a1,0x4
    80003f90:	7ec58593          	addi	a1,a1,2028 # 80008778 <syscalls+0x328>
    80003f94:	00015517          	auipc	a0,0x15
    80003f98:	1d450513          	addi	a0,a0,468 # 80019168 <ftable>
    80003f9c:	00003097          	auipc	ra,0x3
    80003fa0:	95e080e7          	jalr	-1698(ra) # 800068fa <initlock>
}
    80003fa4:	60a2                	ld	ra,8(sp)
    80003fa6:	6402                	ld	s0,0(sp)
    80003fa8:	0141                	addi	sp,sp,16
    80003faa:	8082                	ret

0000000080003fac <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80003fac:	1101                	addi	sp,sp,-32
    80003fae:	ec06                	sd	ra,24(sp)
    80003fb0:	e822                	sd	s0,16(sp)
    80003fb2:	e426                	sd	s1,8(sp)
    80003fb4:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    80003fb6:	00015517          	auipc	a0,0x15
    80003fba:	1b250513          	addi	a0,a0,434 # 80019168 <ftable>
    80003fbe:	00003097          	auipc	ra,0x3
    80003fc2:	9cc080e7          	jalr	-1588(ra) # 8000698a <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003fc6:	00015497          	auipc	s1,0x15
    80003fca:	1ba48493          	addi	s1,s1,442 # 80019180 <ftable+0x18>
    80003fce:	00016717          	auipc	a4,0x16
    80003fd2:	15270713          	addi	a4,a4,338 # 8001a120 <ftable+0xfb8>
    if(f->ref == 0){
    80003fd6:	40dc                	lw	a5,4(s1)
    80003fd8:	cf99                	beqz	a5,80003ff6 <filealloc+0x4a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003fda:	02848493          	addi	s1,s1,40
    80003fde:	fee49ce3          	bne	s1,a4,80003fd6 <filealloc+0x2a>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    80003fe2:	00015517          	auipc	a0,0x15
    80003fe6:	18650513          	addi	a0,a0,390 # 80019168 <ftable>
    80003fea:	00003097          	auipc	ra,0x3
    80003fee:	a54080e7          	jalr	-1452(ra) # 80006a3e <release>
  return 0;
    80003ff2:	4481                	li	s1,0
    80003ff4:	a819                	j	8000400a <filealloc+0x5e>
      f->ref = 1;
    80003ff6:	4785                	li	a5,1
    80003ff8:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    80003ffa:	00015517          	auipc	a0,0x15
    80003ffe:	16e50513          	addi	a0,a0,366 # 80019168 <ftable>
    80004002:	00003097          	auipc	ra,0x3
    80004006:	a3c080e7          	jalr	-1476(ra) # 80006a3e <release>
}
    8000400a:	8526                	mv	a0,s1
    8000400c:	60e2                	ld	ra,24(sp)
    8000400e:	6442                	ld	s0,16(sp)
    80004010:	64a2                	ld	s1,8(sp)
    80004012:	6105                	addi	sp,sp,32
    80004014:	8082                	ret

0000000080004016 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    80004016:	1101                	addi	sp,sp,-32
    80004018:	ec06                	sd	ra,24(sp)
    8000401a:	e822                	sd	s0,16(sp)
    8000401c:	e426                	sd	s1,8(sp)
    8000401e:	1000                	addi	s0,sp,32
    80004020:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    80004022:	00015517          	auipc	a0,0x15
    80004026:	14650513          	addi	a0,a0,326 # 80019168 <ftable>
    8000402a:	00003097          	auipc	ra,0x3
    8000402e:	960080e7          	jalr	-1696(ra) # 8000698a <acquire>
  if(f->ref < 1)
    80004032:	40dc                	lw	a5,4(s1)
    80004034:	02f05263          	blez	a5,80004058 <filedup+0x42>
    panic("filedup");
  f->ref++;
    80004038:	2785                	addiw	a5,a5,1
    8000403a:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    8000403c:	00015517          	auipc	a0,0x15
    80004040:	12c50513          	addi	a0,a0,300 # 80019168 <ftable>
    80004044:	00003097          	auipc	ra,0x3
    80004048:	9fa080e7          	jalr	-1542(ra) # 80006a3e <release>
  return f;
}
    8000404c:	8526                	mv	a0,s1
    8000404e:	60e2                	ld	ra,24(sp)
    80004050:	6442                	ld	s0,16(sp)
    80004052:	64a2                	ld	s1,8(sp)
    80004054:	6105                	addi	sp,sp,32
    80004056:	8082                	ret
    panic("filedup");
    80004058:	00004517          	auipc	a0,0x4
    8000405c:	72850513          	addi	a0,a0,1832 # 80008780 <syscalls+0x330>
    80004060:	00002097          	auipc	ra,0x2
    80004064:	3e0080e7          	jalr	992(ra) # 80006440 <panic>

0000000080004068 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80004068:	7139                	addi	sp,sp,-64
    8000406a:	fc06                	sd	ra,56(sp)
    8000406c:	f822                	sd	s0,48(sp)
    8000406e:	f426                	sd	s1,40(sp)
    80004070:	f04a                	sd	s2,32(sp)
    80004072:	ec4e                	sd	s3,24(sp)
    80004074:	e852                	sd	s4,16(sp)
    80004076:	e456                	sd	s5,8(sp)
    80004078:	0080                	addi	s0,sp,64
    8000407a:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    8000407c:	00015517          	auipc	a0,0x15
    80004080:	0ec50513          	addi	a0,a0,236 # 80019168 <ftable>
    80004084:	00003097          	auipc	ra,0x3
    80004088:	906080e7          	jalr	-1786(ra) # 8000698a <acquire>
  if(f->ref < 1)
    8000408c:	40dc                	lw	a5,4(s1)
    8000408e:	06f05163          	blez	a5,800040f0 <fileclose+0x88>
    panic("fileclose");
  if(--f->ref > 0){
    80004092:	37fd                	addiw	a5,a5,-1
    80004094:	0007871b          	sext.w	a4,a5
    80004098:	c0dc                	sw	a5,4(s1)
    8000409a:	06e04363          	bgtz	a4,80004100 <fileclose+0x98>
    release(&ftable.lock);
    return;
  }
  ff = *f;
    8000409e:	0004a903          	lw	s2,0(s1)
    800040a2:	0094ca83          	lbu	s5,9(s1)
    800040a6:	0104ba03          	ld	s4,16(s1)
    800040aa:	0184b983          	ld	s3,24(s1)
  f->ref = 0;
    800040ae:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    800040b2:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    800040b6:	00015517          	auipc	a0,0x15
    800040ba:	0b250513          	addi	a0,a0,178 # 80019168 <ftable>
    800040be:	00003097          	auipc	ra,0x3
    800040c2:	980080e7          	jalr	-1664(ra) # 80006a3e <release>

  if(ff.type == FD_PIPE){
    800040c6:	4785                	li	a5,1
    800040c8:	04f90d63          	beq	s2,a5,80004122 <fileclose+0xba>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    800040cc:	3979                	addiw	s2,s2,-2
    800040ce:	4785                	li	a5,1
    800040d0:	0527e063          	bltu	a5,s2,80004110 <fileclose+0xa8>
    begin_op();
    800040d4:	00000097          	auipc	ra,0x0
    800040d8:	ac8080e7          	jalr	-1336(ra) # 80003b9c <begin_op>
    iput(ff.ip);
    800040dc:	854e                	mv	a0,s3
    800040de:	fffff097          	auipc	ra,0xfffff
    800040e2:	11e080e7          	jalr	286(ra) # 800031fc <iput>
    end_op();
    800040e6:	00000097          	auipc	ra,0x0
    800040ea:	b36080e7          	jalr	-1226(ra) # 80003c1c <end_op>
    800040ee:	a00d                	j	80004110 <fileclose+0xa8>
    panic("fileclose");
    800040f0:	00004517          	auipc	a0,0x4
    800040f4:	69850513          	addi	a0,a0,1688 # 80008788 <syscalls+0x338>
    800040f8:	00002097          	auipc	ra,0x2
    800040fc:	348080e7          	jalr	840(ra) # 80006440 <panic>
    release(&ftable.lock);
    80004100:	00015517          	auipc	a0,0x15
    80004104:	06850513          	addi	a0,a0,104 # 80019168 <ftable>
    80004108:	00003097          	auipc	ra,0x3
    8000410c:	936080e7          	jalr	-1738(ra) # 80006a3e <release>
  }
}
    80004110:	70e2                	ld	ra,56(sp)
    80004112:	7442                	ld	s0,48(sp)
    80004114:	74a2                	ld	s1,40(sp)
    80004116:	7902                	ld	s2,32(sp)
    80004118:	69e2                	ld	s3,24(sp)
    8000411a:	6a42                	ld	s4,16(sp)
    8000411c:	6aa2                	ld	s5,8(sp)
    8000411e:	6121                	addi	sp,sp,64
    80004120:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    80004122:	85d6                	mv	a1,s5
    80004124:	8552                	mv	a0,s4
    80004126:	00000097          	auipc	ra,0x0
    8000412a:	34c080e7          	jalr	844(ra) # 80004472 <pipeclose>
    8000412e:	b7cd                	j	80004110 <fileclose+0xa8>

0000000080004130 <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80004130:	715d                	addi	sp,sp,-80
    80004132:	e486                	sd	ra,72(sp)
    80004134:	e0a2                	sd	s0,64(sp)
    80004136:	fc26                	sd	s1,56(sp)
    80004138:	f84a                	sd	s2,48(sp)
    8000413a:	f44e                	sd	s3,40(sp)
    8000413c:	0880                	addi	s0,sp,80
    8000413e:	84aa                	mv	s1,a0
    80004140:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    80004142:	ffffd097          	auipc	ra,0xffffd
    80004146:	1fc080e7          	jalr	508(ra) # 8000133e <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    8000414a:	409c                	lw	a5,0(s1)
    8000414c:	37f9                	addiw	a5,a5,-2
    8000414e:	4705                	li	a4,1
    80004150:	04f76763          	bltu	a4,a5,8000419e <filestat+0x6e>
    80004154:	892a                	mv	s2,a0
    ilock(f->ip);
    80004156:	6c88                	ld	a0,24(s1)
    80004158:	fffff097          	auipc	ra,0xfffff
    8000415c:	eea080e7          	jalr	-278(ra) # 80003042 <ilock>
    stati(f->ip, &st);
    80004160:	fb840593          	addi	a1,s0,-72
    80004164:	6c88                	ld	a0,24(s1)
    80004166:	fffff097          	auipc	ra,0xfffff
    8000416a:	166080e7          	jalr	358(ra) # 800032cc <stati>
    iunlock(f->ip);
    8000416e:	6c88                	ld	a0,24(s1)
    80004170:	fffff097          	auipc	ra,0xfffff
    80004174:	f94080e7          	jalr	-108(ra) # 80003104 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80004178:	46e1                	li	a3,24
    8000417a:	fb840613          	addi	a2,s0,-72
    8000417e:	85ce                	mv	a1,s3
    80004180:	05093503          	ld	a0,80(s2)
    80004184:	ffffd097          	auipc	ra,0xffffd
    80004188:	97e080e7          	jalr	-1666(ra) # 80000b02 <copyout>
    8000418c:	41f5551b          	sraiw	a0,a0,0x1f
      return -1;
    return 0;
  }
  return -1;
}
    80004190:	60a6                	ld	ra,72(sp)
    80004192:	6406                	ld	s0,64(sp)
    80004194:	74e2                	ld	s1,56(sp)
    80004196:	7942                	ld	s2,48(sp)
    80004198:	79a2                	ld	s3,40(sp)
    8000419a:	6161                	addi	sp,sp,80
    8000419c:	8082                	ret
  return -1;
    8000419e:	557d                	li	a0,-1
    800041a0:	bfc5                	j	80004190 <filestat+0x60>

00000000800041a2 <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    800041a2:	7179                	addi	sp,sp,-48
    800041a4:	f406                	sd	ra,40(sp)
    800041a6:	f022                	sd	s0,32(sp)
    800041a8:	ec26                	sd	s1,24(sp)
    800041aa:	e84a                	sd	s2,16(sp)
    800041ac:	e44e                	sd	s3,8(sp)
    800041ae:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    800041b0:	00854783          	lbu	a5,8(a0)
    800041b4:	c3d5                	beqz	a5,80004258 <fileread+0xb6>
    800041b6:	84aa                	mv	s1,a0
    800041b8:	89ae                	mv	s3,a1
    800041ba:	8932                	mv	s2,a2
    return -1;

  if(f->type == FD_PIPE){
    800041bc:	411c                	lw	a5,0(a0)
    800041be:	4705                	li	a4,1
    800041c0:	04e78963          	beq	a5,a4,80004212 <fileread+0x70>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    800041c4:	470d                	li	a4,3
    800041c6:	04e78d63          	beq	a5,a4,80004220 <fileread+0x7e>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    800041ca:	4709                	li	a4,2
    800041cc:	06e79e63          	bne	a5,a4,80004248 <fileread+0xa6>
    ilock(f->ip);
    800041d0:	6d08                	ld	a0,24(a0)
    800041d2:	fffff097          	auipc	ra,0xfffff
    800041d6:	e70080e7          	jalr	-400(ra) # 80003042 <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    800041da:	874a                	mv	a4,s2
    800041dc:	5094                	lw	a3,32(s1)
    800041de:	864e                	mv	a2,s3
    800041e0:	4585                	li	a1,1
    800041e2:	6c88                	ld	a0,24(s1)
    800041e4:	fffff097          	auipc	ra,0xfffff
    800041e8:	112080e7          	jalr	274(ra) # 800032f6 <readi>
    800041ec:	892a                	mv	s2,a0
    800041ee:	00a05563          	blez	a0,800041f8 <fileread+0x56>
      f->off += r;
    800041f2:	509c                	lw	a5,32(s1)
    800041f4:	9fa9                	addw	a5,a5,a0
    800041f6:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    800041f8:	6c88                	ld	a0,24(s1)
    800041fa:	fffff097          	auipc	ra,0xfffff
    800041fe:	f0a080e7          	jalr	-246(ra) # 80003104 <iunlock>
  } else {
    panic("fileread");
  }

  return r;
}
    80004202:	854a                	mv	a0,s2
    80004204:	70a2                	ld	ra,40(sp)
    80004206:	7402                	ld	s0,32(sp)
    80004208:	64e2                	ld	s1,24(sp)
    8000420a:	6942                	ld	s2,16(sp)
    8000420c:	69a2                	ld	s3,8(sp)
    8000420e:	6145                	addi	sp,sp,48
    80004210:	8082                	ret
    r = piperead(f->pipe, addr, n);
    80004212:	6908                	ld	a0,16(a0)
    80004214:	00000097          	auipc	ra,0x0
    80004218:	3c8080e7          	jalr	968(ra) # 800045dc <piperead>
    8000421c:	892a                	mv	s2,a0
    8000421e:	b7d5                	j	80004202 <fileread+0x60>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80004220:	02451783          	lh	a5,36(a0)
    80004224:	03079693          	slli	a3,a5,0x30
    80004228:	92c1                	srli	a3,a3,0x30
    8000422a:	4725                	li	a4,9
    8000422c:	02d76863          	bltu	a4,a3,8000425c <fileread+0xba>
    80004230:	0792                	slli	a5,a5,0x4
    80004232:	00015717          	auipc	a4,0x15
    80004236:	e9670713          	addi	a4,a4,-362 # 800190c8 <devsw>
    8000423a:	97ba                	add	a5,a5,a4
    8000423c:	639c                	ld	a5,0(a5)
    8000423e:	c38d                	beqz	a5,80004260 <fileread+0xbe>
    r = devsw[f->major].read(1, addr, n);
    80004240:	4505                	li	a0,1
    80004242:	9782                	jalr	a5
    80004244:	892a                	mv	s2,a0
    80004246:	bf75                	j	80004202 <fileread+0x60>
    panic("fileread");
    80004248:	00004517          	auipc	a0,0x4
    8000424c:	55050513          	addi	a0,a0,1360 # 80008798 <syscalls+0x348>
    80004250:	00002097          	auipc	ra,0x2
    80004254:	1f0080e7          	jalr	496(ra) # 80006440 <panic>
    return -1;
    80004258:	597d                	li	s2,-1
    8000425a:	b765                	j	80004202 <fileread+0x60>
      return -1;
    8000425c:	597d                	li	s2,-1
    8000425e:	b755                	j	80004202 <fileread+0x60>
    80004260:	597d                	li	s2,-1
    80004262:	b745                	j	80004202 <fileread+0x60>

0000000080004264 <filewrite>:

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
    80004264:	715d                	addi	sp,sp,-80
    80004266:	e486                	sd	ra,72(sp)
    80004268:	e0a2                	sd	s0,64(sp)
    8000426a:	fc26                	sd	s1,56(sp)
    8000426c:	f84a                	sd	s2,48(sp)
    8000426e:	f44e                	sd	s3,40(sp)
    80004270:	f052                	sd	s4,32(sp)
    80004272:	ec56                	sd	s5,24(sp)
    80004274:	e85a                	sd	s6,16(sp)
    80004276:	e45e                	sd	s7,8(sp)
    80004278:	e062                	sd	s8,0(sp)
    8000427a:	0880                	addi	s0,sp,80
  int r, ret = 0;

  if(f->writable == 0)
    8000427c:	00954783          	lbu	a5,9(a0)
    80004280:	10078663          	beqz	a5,8000438c <filewrite+0x128>
    80004284:	892a                	mv	s2,a0
    80004286:	8aae                	mv	s5,a1
    80004288:	8a32                	mv	s4,a2
    return -1;

  if(f->type == FD_PIPE){
    8000428a:	411c                	lw	a5,0(a0)
    8000428c:	4705                	li	a4,1
    8000428e:	02e78263          	beq	a5,a4,800042b2 <filewrite+0x4e>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80004292:	470d                	li	a4,3
    80004294:	02e78663          	beq	a5,a4,800042c0 <filewrite+0x5c>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    80004298:	4709                	li	a4,2
    8000429a:	0ee79163          	bne	a5,a4,8000437c <filewrite+0x118>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    8000429e:	0ac05d63          	blez	a2,80004358 <filewrite+0xf4>
    int i = 0;
    800042a2:	4981                	li	s3,0
    800042a4:	6b05                	lui	s6,0x1
    800042a6:	c00b0b13          	addi	s6,s6,-1024 # c00 <_entry-0x7ffff400>
    800042aa:	6b85                	lui	s7,0x1
    800042ac:	c00b8b9b          	addiw	s7,s7,-1024
    800042b0:	a861                	j	80004348 <filewrite+0xe4>
    ret = pipewrite(f->pipe, addr, n);
    800042b2:	6908                	ld	a0,16(a0)
    800042b4:	00000097          	auipc	ra,0x0
    800042b8:	22e080e7          	jalr	558(ra) # 800044e2 <pipewrite>
    800042bc:	8a2a                	mv	s4,a0
    800042be:	a045                	j	8000435e <filewrite+0xfa>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    800042c0:	02451783          	lh	a5,36(a0)
    800042c4:	03079693          	slli	a3,a5,0x30
    800042c8:	92c1                	srli	a3,a3,0x30
    800042ca:	4725                	li	a4,9
    800042cc:	0cd76263          	bltu	a4,a3,80004390 <filewrite+0x12c>
    800042d0:	0792                	slli	a5,a5,0x4
    800042d2:	00015717          	auipc	a4,0x15
    800042d6:	df670713          	addi	a4,a4,-522 # 800190c8 <devsw>
    800042da:	97ba                	add	a5,a5,a4
    800042dc:	679c                	ld	a5,8(a5)
    800042de:	cbdd                	beqz	a5,80004394 <filewrite+0x130>
    ret = devsw[f->major].write(1, addr, n);
    800042e0:	4505                	li	a0,1
    800042e2:	9782                	jalr	a5
    800042e4:	8a2a                	mv	s4,a0
    800042e6:	a8a5                	j	8000435e <filewrite+0xfa>
    800042e8:	00048c1b          	sext.w	s8,s1
      int n1 = n - i;
      if(n1 > max)
        n1 = max;

      begin_op();
    800042ec:	00000097          	auipc	ra,0x0
    800042f0:	8b0080e7          	jalr	-1872(ra) # 80003b9c <begin_op>
      ilock(f->ip);
    800042f4:	01893503          	ld	a0,24(s2)
    800042f8:	fffff097          	auipc	ra,0xfffff
    800042fc:	d4a080e7          	jalr	-694(ra) # 80003042 <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80004300:	8762                	mv	a4,s8
    80004302:	02092683          	lw	a3,32(s2)
    80004306:	01598633          	add	a2,s3,s5
    8000430a:	4585                	li	a1,1
    8000430c:	01893503          	ld	a0,24(s2)
    80004310:	fffff097          	auipc	ra,0xfffff
    80004314:	0de080e7          	jalr	222(ra) # 800033ee <writei>
    80004318:	84aa                	mv	s1,a0
    8000431a:	00a05763          	blez	a0,80004328 <filewrite+0xc4>
        f->off += r;
    8000431e:	02092783          	lw	a5,32(s2)
    80004322:	9fa9                	addw	a5,a5,a0
    80004324:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    80004328:	01893503          	ld	a0,24(s2)
    8000432c:	fffff097          	auipc	ra,0xfffff
    80004330:	dd8080e7          	jalr	-552(ra) # 80003104 <iunlock>
      end_op();
    80004334:	00000097          	auipc	ra,0x0
    80004338:	8e8080e7          	jalr	-1816(ra) # 80003c1c <end_op>

      if(r != n1){
    8000433c:	009c1f63          	bne	s8,s1,8000435a <filewrite+0xf6>
        // error from writei
        break;
      }
      i += r;
    80004340:	013489bb          	addw	s3,s1,s3
    while(i < n){
    80004344:	0149db63          	bge	s3,s4,8000435a <filewrite+0xf6>
      int n1 = n - i;
    80004348:	413a07bb          	subw	a5,s4,s3
      if(n1 > max)
    8000434c:	84be                	mv	s1,a5
    8000434e:	2781                	sext.w	a5,a5
    80004350:	f8fb5ce3          	bge	s6,a5,800042e8 <filewrite+0x84>
    80004354:	84de                	mv	s1,s7
    80004356:	bf49                	j	800042e8 <filewrite+0x84>
    int i = 0;
    80004358:	4981                	li	s3,0
    }
    ret = (i == n ? n : -1);
    8000435a:	013a1f63          	bne	s4,s3,80004378 <filewrite+0x114>
  } else {
    panic("filewrite");
  }

  return ret;
}
    8000435e:	8552                	mv	a0,s4
    80004360:	60a6                	ld	ra,72(sp)
    80004362:	6406                	ld	s0,64(sp)
    80004364:	74e2                	ld	s1,56(sp)
    80004366:	7942                	ld	s2,48(sp)
    80004368:	79a2                	ld	s3,40(sp)
    8000436a:	7a02                	ld	s4,32(sp)
    8000436c:	6ae2                	ld	s5,24(sp)
    8000436e:	6b42                	ld	s6,16(sp)
    80004370:	6ba2                	ld	s7,8(sp)
    80004372:	6c02                	ld	s8,0(sp)
    80004374:	6161                	addi	sp,sp,80
    80004376:	8082                	ret
    ret = (i == n ? n : -1);
    80004378:	5a7d                	li	s4,-1
    8000437a:	b7d5                	j	8000435e <filewrite+0xfa>
    panic("filewrite");
    8000437c:	00004517          	auipc	a0,0x4
    80004380:	42c50513          	addi	a0,a0,1068 # 800087a8 <syscalls+0x358>
    80004384:	00002097          	auipc	ra,0x2
    80004388:	0bc080e7          	jalr	188(ra) # 80006440 <panic>
    return -1;
    8000438c:	5a7d                	li	s4,-1
    8000438e:	bfc1                	j	8000435e <filewrite+0xfa>
      return -1;
    80004390:	5a7d                	li	s4,-1
    80004392:	b7f1                	j	8000435e <filewrite+0xfa>
    80004394:	5a7d                	li	s4,-1
    80004396:	b7e1                	j	8000435e <filewrite+0xfa>

0000000080004398 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    80004398:	7179                	addi	sp,sp,-48
    8000439a:	f406                	sd	ra,40(sp)
    8000439c:	f022                	sd	s0,32(sp)
    8000439e:	ec26                	sd	s1,24(sp)
    800043a0:	e84a                	sd	s2,16(sp)
    800043a2:	e44e                	sd	s3,8(sp)
    800043a4:	e052                	sd	s4,0(sp)
    800043a6:	1800                	addi	s0,sp,48
    800043a8:	84aa                	mv	s1,a0
    800043aa:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    800043ac:	0005b023          	sd	zero,0(a1)
    800043b0:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    800043b4:	00000097          	auipc	ra,0x0
    800043b8:	bf8080e7          	jalr	-1032(ra) # 80003fac <filealloc>
    800043bc:	e088                	sd	a0,0(s1)
    800043be:	c551                	beqz	a0,8000444a <pipealloc+0xb2>
    800043c0:	00000097          	auipc	ra,0x0
    800043c4:	bec080e7          	jalr	-1044(ra) # 80003fac <filealloc>
    800043c8:	00aa3023          	sd	a0,0(s4)
    800043cc:	c92d                	beqz	a0,8000443e <pipealloc+0xa6>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    800043ce:	ffffc097          	auipc	ra,0xffffc
    800043d2:	d4a080e7          	jalr	-694(ra) # 80000118 <kalloc>
    800043d6:	892a                	mv	s2,a0
    800043d8:	c125                	beqz	a0,80004438 <pipealloc+0xa0>
    goto bad;
  pi->readopen = 1;
    800043da:	4985                	li	s3,1
    800043dc:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    800043e0:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    800043e4:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    800043e8:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    800043ec:	00004597          	auipc	a1,0x4
    800043f0:	3cc58593          	addi	a1,a1,972 # 800087b8 <syscalls+0x368>
    800043f4:	00002097          	auipc	ra,0x2
    800043f8:	506080e7          	jalr	1286(ra) # 800068fa <initlock>
  (*f0)->type = FD_PIPE;
    800043fc:	609c                	ld	a5,0(s1)
    800043fe:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    80004402:	609c                	ld	a5,0(s1)
    80004404:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    80004408:	609c                	ld	a5,0(s1)
    8000440a:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    8000440e:	609c                	ld	a5,0(s1)
    80004410:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    80004414:	000a3783          	ld	a5,0(s4)
    80004418:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    8000441c:	000a3783          	ld	a5,0(s4)
    80004420:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80004424:	000a3783          	ld	a5,0(s4)
    80004428:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    8000442c:	000a3783          	ld	a5,0(s4)
    80004430:	0127b823          	sd	s2,16(a5)
  return 0;
    80004434:	4501                	li	a0,0
    80004436:	a025                	j	8000445e <pipealloc+0xc6>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80004438:	6088                	ld	a0,0(s1)
    8000443a:	e501                	bnez	a0,80004442 <pipealloc+0xaa>
    8000443c:	a039                	j	8000444a <pipealloc+0xb2>
    8000443e:	6088                	ld	a0,0(s1)
    80004440:	c51d                	beqz	a0,8000446e <pipealloc+0xd6>
    fileclose(*f0);
    80004442:	00000097          	auipc	ra,0x0
    80004446:	c26080e7          	jalr	-986(ra) # 80004068 <fileclose>
  if(*f1)
    8000444a:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    8000444e:	557d                	li	a0,-1
  if(*f1)
    80004450:	c799                	beqz	a5,8000445e <pipealloc+0xc6>
    fileclose(*f1);
    80004452:	853e                	mv	a0,a5
    80004454:	00000097          	auipc	ra,0x0
    80004458:	c14080e7          	jalr	-1004(ra) # 80004068 <fileclose>
  return -1;
    8000445c:	557d                	li	a0,-1
}
    8000445e:	70a2                	ld	ra,40(sp)
    80004460:	7402                	ld	s0,32(sp)
    80004462:	64e2                	ld	s1,24(sp)
    80004464:	6942                	ld	s2,16(sp)
    80004466:	69a2                	ld	s3,8(sp)
    80004468:	6a02                	ld	s4,0(sp)
    8000446a:	6145                	addi	sp,sp,48
    8000446c:	8082                	ret
  return -1;
    8000446e:	557d                	li	a0,-1
    80004470:	b7fd                	j	8000445e <pipealloc+0xc6>

0000000080004472 <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80004472:	1101                	addi	sp,sp,-32
    80004474:	ec06                	sd	ra,24(sp)
    80004476:	e822                	sd	s0,16(sp)
    80004478:	e426                	sd	s1,8(sp)
    8000447a:	e04a                	sd	s2,0(sp)
    8000447c:	1000                	addi	s0,sp,32
    8000447e:	84aa                	mv	s1,a0
    80004480:	892e                	mv	s2,a1
  acquire(&pi->lock);
    80004482:	00002097          	auipc	ra,0x2
    80004486:	508080e7          	jalr	1288(ra) # 8000698a <acquire>
  if(writable){
    8000448a:	02090d63          	beqz	s2,800044c4 <pipeclose+0x52>
    pi->writeopen = 0;
    8000448e:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    80004492:	21848513          	addi	a0,s1,536
    80004496:	ffffd097          	auipc	ra,0xffffd
    8000449a:	6f0080e7          	jalr	1776(ra) # 80001b86 <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    8000449e:	2204b783          	ld	a5,544(s1)
    800044a2:	eb95                	bnez	a5,800044d6 <pipeclose+0x64>
    release(&pi->lock);
    800044a4:	8526                	mv	a0,s1
    800044a6:	00002097          	auipc	ra,0x2
    800044aa:	598080e7          	jalr	1432(ra) # 80006a3e <release>
    kfree((char*)pi);
    800044ae:	8526                	mv	a0,s1
    800044b0:	ffffc097          	auipc	ra,0xffffc
    800044b4:	b6c080e7          	jalr	-1172(ra) # 8000001c <kfree>
  } else
    release(&pi->lock);
}
    800044b8:	60e2                	ld	ra,24(sp)
    800044ba:	6442                	ld	s0,16(sp)
    800044bc:	64a2                	ld	s1,8(sp)
    800044be:	6902                	ld	s2,0(sp)
    800044c0:	6105                	addi	sp,sp,32
    800044c2:	8082                	ret
    pi->readopen = 0;
    800044c4:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    800044c8:	21c48513          	addi	a0,s1,540
    800044cc:	ffffd097          	auipc	ra,0xffffd
    800044d0:	6ba080e7          	jalr	1722(ra) # 80001b86 <wakeup>
    800044d4:	b7e9                	j	8000449e <pipeclose+0x2c>
    release(&pi->lock);
    800044d6:	8526                	mv	a0,s1
    800044d8:	00002097          	auipc	ra,0x2
    800044dc:	566080e7          	jalr	1382(ra) # 80006a3e <release>
}
    800044e0:	bfe1                	j	800044b8 <pipeclose+0x46>

00000000800044e2 <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    800044e2:	7159                	addi	sp,sp,-112
    800044e4:	f486                	sd	ra,104(sp)
    800044e6:	f0a2                	sd	s0,96(sp)
    800044e8:	eca6                	sd	s1,88(sp)
    800044ea:	e8ca                	sd	s2,80(sp)
    800044ec:	e4ce                	sd	s3,72(sp)
    800044ee:	e0d2                	sd	s4,64(sp)
    800044f0:	fc56                	sd	s5,56(sp)
    800044f2:	f85a                	sd	s6,48(sp)
    800044f4:	f45e                	sd	s7,40(sp)
    800044f6:	f062                	sd	s8,32(sp)
    800044f8:	ec66                	sd	s9,24(sp)
    800044fa:	1880                	addi	s0,sp,112
    800044fc:	84aa                	mv	s1,a0
    800044fe:	8aae                	mv	s5,a1
    80004500:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    80004502:	ffffd097          	auipc	ra,0xffffd
    80004506:	e3c080e7          	jalr	-452(ra) # 8000133e <myproc>
    8000450a:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    8000450c:	8526                	mv	a0,s1
    8000450e:	00002097          	auipc	ra,0x2
    80004512:	47c080e7          	jalr	1148(ra) # 8000698a <acquire>
  while(i < n){
    80004516:	0d405163          	blez	s4,800045d8 <pipewrite+0xf6>
    8000451a:	8ba6                	mv	s7,s1
  int i = 0;
    8000451c:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    8000451e:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    80004520:	21848c93          	addi	s9,s1,536
      sleep(&pi->nwrite, &pi->lock);
    80004524:	21c48c13          	addi	s8,s1,540
    80004528:	a08d                	j	8000458a <pipewrite+0xa8>
      release(&pi->lock);
    8000452a:	8526                	mv	a0,s1
    8000452c:	00002097          	auipc	ra,0x2
    80004530:	512080e7          	jalr	1298(ra) # 80006a3e <release>
      return -1;
    80004534:	597d                	li	s2,-1
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    80004536:	854a                	mv	a0,s2
    80004538:	70a6                	ld	ra,104(sp)
    8000453a:	7406                	ld	s0,96(sp)
    8000453c:	64e6                	ld	s1,88(sp)
    8000453e:	6946                	ld	s2,80(sp)
    80004540:	69a6                	ld	s3,72(sp)
    80004542:	6a06                	ld	s4,64(sp)
    80004544:	7ae2                	ld	s5,56(sp)
    80004546:	7b42                	ld	s6,48(sp)
    80004548:	7ba2                	ld	s7,40(sp)
    8000454a:	7c02                	ld	s8,32(sp)
    8000454c:	6ce2                	ld	s9,24(sp)
    8000454e:	6165                	addi	sp,sp,112
    80004550:	8082                	ret
      wakeup(&pi->nread);
    80004552:	8566                	mv	a0,s9
    80004554:	ffffd097          	auipc	ra,0xffffd
    80004558:	632080e7          	jalr	1586(ra) # 80001b86 <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    8000455c:	85de                	mv	a1,s7
    8000455e:	8562                	mv	a0,s8
    80004560:	ffffd097          	auipc	ra,0xffffd
    80004564:	49a080e7          	jalr	1178(ra) # 800019fa <sleep>
    80004568:	a839                	j	80004586 <pipewrite+0xa4>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    8000456a:	21c4a783          	lw	a5,540(s1)
    8000456e:	0017871b          	addiw	a4,a5,1
    80004572:	20e4ae23          	sw	a4,540(s1)
    80004576:	1ff7f793          	andi	a5,a5,511
    8000457a:	97a6                	add	a5,a5,s1
    8000457c:	f9f44703          	lbu	a4,-97(s0)
    80004580:	00e78c23          	sb	a4,24(a5)
      i++;
    80004584:	2905                	addiw	s2,s2,1
  while(i < n){
    80004586:	03495d63          	bge	s2,s4,800045c0 <pipewrite+0xde>
    if(pi->readopen == 0 || pr->killed){
    8000458a:	2204a783          	lw	a5,544(s1)
    8000458e:	dfd1                	beqz	a5,8000452a <pipewrite+0x48>
    80004590:	0289a783          	lw	a5,40(s3)
    80004594:	fbd9                	bnez	a5,8000452a <pipewrite+0x48>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    80004596:	2184a783          	lw	a5,536(s1)
    8000459a:	21c4a703          	lw	a4,540(s1)
    8000459e:	2007879b          	addiw	a5,a5,512
    800045a2:	faf708e3          	beq	a4,a5,80004552 <pipewrite+0x70>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    800045a6:	4685                	li	a3,1
    800045a8:	01590633          	add	a2,s2,s5
    800045ac:	f9f40593          	addi	a1,s0,-97
    800045b0:	0509b503          	ld	a0,80(s3)
    800045b4:	ffffc097          	auipc	ra,0xffffc
    800045b8:	5da080e7          	jalr	1498(ra) # 80000b8e <copyin>
    800045bc:	fb6517e3          	bne	a0,s6,8000456a <pipewrite+0x88>
  wakeup(&pi->nread);
    800045c0:	21848513          	addi	a0,s1,536
    800045c4:	ffffd097          	auipc	ra,0xffffd
    800045c8:	5c2080e7          	jalr	1474(ra) # 80001b86 <wakeup>
  release(&pi->lock);
    800045cc:	8526                	mv	a0,s1
    800045ce:	00002097          	auipc	ra,0x2
    800045d2:	470080e7          	jalr	1136(ra) # 80006a3e <release>
  return i;
    800045d6:	b785                	j	80004536 <pipewrite+0x54>
  int i = 0;
    800045d8:	4901                	li	s2,0
    800045da:	b7dd                	j	800045c0 <pipewrite+0xde>

00000000800045dc <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    800045dc:	715d                	addi	sp,sp,-80
    800045de:	e486                	sd	ra,72(sp)
    800045e0:	e0a2                	sd	s0,64(sp)
    800045e2:	fc26                	sd	s1,56(sp)
    800045e4:	f84a                	sd	s2,48(sp)
    800045e6:	f44e                	sd	s3,40(sp)
    800045e8:	f052                	sd	s4,32(sp)
    800045ea:	ec56                	sd	s5,24(sp)
    800045ec:	e85a                	sd	s6,16(sp)
    800045ee:	0880                	addi	s0,sp,80
    800045f0:	84aa                	mv	s1,a0
    800045f2:	892e                	mv	s2,a1
    800045f4:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    800045f6:	ffffd097          	auipc	ra,0xffffd
    800045fa:	d48080e7          	jalr	-696(ra) # 8000133e <myproc>
    800045fe:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    80004600:	8b26                	mv	s6,s1
    80004602:	8526                	mv	a0,s1
    80004604:	00002097          	auipc	ra,0x2
    80004608:	386080e7          	jalr	902(ra) # 8000698a <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    8000460c:	2184a703          	lw	a4,536(s1)
    80004610:	21c4a783          	lw	a5,540(s1)
    if(pr->killed){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80004614:	21848993          	addi	s3,s1,536
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004618:	02f71463          	bne	a4,a5,80004640 <piperead+0x64>
    8000461c:	2244a783          	lw	a5,548(s1)
    80004620:	c385                	beqz	a5,80004640 <piperead+0x64>
    if(pr->killed){
    80004622:	028a2783          	lw	a5,40(s4)
    80004626:	ebc1                	bnez	a5,800046b6 <piperead+0xda>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80004628:	85da                	mv	a1,s6
    8000462a:	854e                	mv	a0,s3
    8000462c:	ffffd097          	auipc	ra,0xffffd
    80004630:	3ce080e7          	jalr	974(ra) # 800019fa <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004634:	2184a703          	lw	a4,536(s1)
    80004638:	21c4a783          	lw	a5,540(s1)
    8000463c:	fef700e3          	beq	a4,a5,8000461c <piperead+0x40>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004640:	09505263          	blez	s5,800046c4 <piperead+0xe8>
    80004644:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80004646:	5b7d                	li	s6,-1
    if(pi->nread == pi->nwrite)
    80004648:	2184a783          	lw	a5,536(s1)
    8000464c:	21c4a703          	lw	a4,540(s1)
    80004650:	02f70d63          	beq	a4,a5,8000468a <piperead+0xae>
    ch = pi->data[pi->nread++ % PIPESIZE];
    80004654:	0017871b          	addiw	a4,a5,1
    80004658:	20e4ac23          	sw	a4,536(s1)
    8000465c:	1ff7f793          	andi	a5,a5,511
    80004660:	97a6                	add	a5,a5,s1
    80004662:	0187c783          	lbu	a5,24(a5)
    80004666:	faf40fa3          	sb	a5,-65(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    8000466a:	4685                	li	a3,1
    8000466c:	fbf40613          	addi	a2,s0,-65
    80004670:	85ca                	mv	a1,s2
    80004672:	050a3503          	ld	a0,80(s4)
    80004676:	ffffc097          	auipc	ra,0xffffc
    8000467a:	48c080e7          	jalr	1164(ra) # 80000b02 <copyout>
    8000467e:	01650663          	beq	a0,s6,8000468a <piperead+0xae>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004682:	2985                	addiw	s3,s3,1
    80004684:	0905                	addi	s2,s2,1
    80004686:	fd3a91e3          	bne	s5,s3,80004648 <piperead+0x6c>
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    8000468a:	21c48513          	addi	a0,s1,540
    8000468e:	ffffd097          	auipc	ra,0xffffd
    80004692:	4f8080e7          	jalr	1272(ra) # 80001b86 <wakeup>
  release(&pi->lock);
    80004696:	8526                	mv	a0,s1
    80004698:	00002097          	auipc	ra,0x2
    8000469c:	3a6080e7          	jalr	934(ra) # 80006a3e <release>
  return i;
}
    800046a0:	854e                	mv	a0,s3
    800046a2:	60a6                	ld	ra,72(sp)
    800046a4:	6406                	ld	s0,64(sp)
    800046a6:	74e2                	ld	s1,56(sp)
    800046a8:	7942                	ld	s2,48(sp)
    800046aa:	79a2                	ld	s3,40(sp)
    800046ac:	7a02                	ld	s4,32(sp)
    800046ae:	6ae2                	ld	s5,24(sp)
    800046b0:	6b42                	ld	s6,16(sp)
    800046b2:	6161                	addi	sp,sp,80
    800046b4:	8082                	ret
      release(&pi->lock);
    800046b6:	8526                	mv	a0,s1
    800046b8:	00002097          	auipc	ra,0x2
    800046bc:	386080e7          	jalr	902(ra) # 80006a3e <release>
      return -1;
    800046c0:	59fd                	li	s3,-1
    800046c2:	bff9                	j	800046a0 <piperead+0xc4>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    800046c4:	4981                	li	s3,0
    800046c6:	b7d1                	j	8000468a <piperead+0xae>

00000000800046c8 <exec>:

static int loadseg(pde_t *pgdir, uint64 addr, struct inode *ip, uint offset, uint sz);

int
exec(char *path, char **argv)
{
    800046c8:	df010113          	addi	sp,sp,-528
    800046cc:	20113423          	sd	ra,520(sp)
    800046d0:	20813023          	sd	s0,512(sp)
    800046d4:	ffa6                	sd	s1,504(sp)
    800046d6:	fbca                	sd	s2,496(sp)
    800046d8:	f7ce                	sd	s3,488(sp)
    800046da:	f3d2                	sd	s4,480(sp)
    800046dc:	efd6                	sd	s5,472(sp)
    800046de:	ebda                	sd	s6,464(sp)
    800046e0:	e7de                	sd	s7,456(sp)
    800046e2:	e3e2                	sd	s8,448(sp)
    800046e4:	ff66                	sd	s9,440(sp)
    800046e6:	fb6a                	sd	s10,432(sp)
    800046e8:	f76e                	sd	s11,424(sp)
    800046ea:	0c00                	addi	s0,sp,528
    800046ec:	84aa                	mv	s1,a0
    800046ee:	dea43c23          	sd	a0,-520(s0)
    800046f2:	e0b43023          	sd	a1,-512(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    800046f6:	ffffd097          	auipc	ra,0xffffd
    800046fa:	c48080e7          	jalr	-952(ra) # 8000133e <myproc>
    800046fe:	892a                	mv	s2,a0

  begin_op();
    80004700:	fffff097          	auipc	ra,0xfffff
    80004704:	49c080e7          	jalr	1180(ra) # 80003b9c <begin_op>

  if((ip = namei(path)) == 0){
    80004708:	8526                	mv	a0,s1
    8000470a:	fffff097          	auipc	ra,0xfffff
    8000470e:	0e4080e7          	jalr	228(ra) # 800037ee <namei>
    80004712:	c92d                	beqz	a0,80004784 <exec+0xbc>
    80004714:	84aa                	mv	s1,a0
    end_op();
    return -1;
  }
  ilock(ip);
    80004716:	fffff097          	auipc	ra,0xfffff
    8000471a:	92c080e7          	jalr	-1748(ra) # 80003042 <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    8000471e:	04000713          	li	a4,64
    80004722:	4681                	li	a3,0
    80004724:	e5040613          	addi	a2,s0,-432
    80004728:	4581                	li	a1,0
    8000472a:	8526                	mv	a0,s1
    8000472c:	fffff097          	auipc	ra,0xfffff
    80004730:	bca080e7          	jalr	-1078(ra) # 800032f6 <readi>
    80004734:	04000793          	li	a5,64
    80004738:	00f51a63          	bne	a0,a5,8000474c <exec+0x84>
    goto bad;
  if(elf.magic != ELF_MAGIC)
    8000473c:	e5042703          	lw	a4,-432(s0)
    80004740:	464c47b7          	lui	a5,0x464c4
    80004744:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80004748:	04f70463          	beq	a4,a5,80004790 <exec+0xc8>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    8000474c:	8526                	mv	a0,s1
    8000474e:	fffff097          	auipc	ra,0xfffff
    80004752:	b56080e7          	jalr	-1194(ra) # 800032a4 <iunlockput>
    end_op();
    80004756:	fffff097          	auipc	ra,0xfffff
    8000475a:	4c6080e7          	jalr	1222(ra) # 80003c1c <end_op>
  }
  return -1;
    8000475e:	557d                	li	a0,-1
}
    80004760:	20813083          	ld	ra,520(sp)
    80004764:	20013403          	ld	s0,512(sp)
    80004768:	74fe                	ld	s1,504(sp)
    8000476a:	795e                	ld	s2,496(sp)
    8000476c:	79be                	ld	s3,488(sp)
    8000476e:	7a1e                	ld	s4,480(sp)
    80004770:	6afe                	ld	s5,472(sp)
    80004772:	6b5e                	ld	s6,464(sp)
    80004774:	6bbe                	ld	s7,456(sp)
    80004776:	6c1e                	ld	s8,448(sp)
    80004778:	7cfa                	ld	s9,440(sp)
    8000477a:	7d5a                	ld	s10,432(sp)
    8000477c:	7dba                	ld	s11,424(sp)
    8000477e:	21010113          	addi	sp,sp,528
    80004782:	8082                	ret
    end_op();
    80004784:	fffff097          	auipc	ra,0xfffff
    80004788:	498080e7          	jalr	1176(ra) # 80003c1c <end_op>
    return -1;
    8000478c:	557d                	li	a0,-1
    8000478e:	bfc9                	j	80004760 <exec+0x98>
  if((pagetable = proc_pagetable(p)) == 0)
    80004790:	854a                	mv	a0,s2
    80004792:	ffffd097          	auipc	ra,0xffffd
    80004796:	c70080e7          	jalr	-912(ra) # 80001402 <proc_pagetable>
    8000479a:	8baa                	mv	s7,a0
    8000479c:	d945                	beqz	a0,8000474c <exec+0x84>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    8000479e:	e7042983          	lw	s3,-400(s0)
    800047a2:	e8845783          	lhu	a5,-376(s0)
    800047a6:	c7ad                	beqz	a5,80004810 <exec+0x148>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    800047a8:	4901                	li	s2,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    800047aa:	4b01                	li	s6,0
    if((ph.vaddr % PGSIZE) != 0)
    800047ac:	6c85                	lui	s9,0x1
    800047ae:	fffc8793          	addi	a5,s9,-1 # fff <_entry-0x7ffff001>
    800047b2:	def43823          	sd	a5,-528(s0)
    800047b6:	a42d                	j	800049e0 <exec+0x318>
  uint64 pa;

  for(i = 0; i < sz; i += PGSIZE){
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    800047b8:	00004517          	auipc	a0,0x4
    800047bc:	00850513          	addi	a0,a0,8 # 800087c0 <syscalls+0x370>
    800047c0:	00002097          	auipc	ra,0x2
    800047c4:	c80080e7          	jalr	-896(ra) # 80006440 <panic>
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    800047c8:	8756                	mv	a4,s5
    800047ca:	012d86bb          	addw	a3,s11,s2
    800047ce:	4581                	li	a1,0
    800047d0:	8526                	mv	a0,s1
    800047d2:	fffff097          	auipc	ra,0xfffff
    800047d6:	b24080e7          	jalr	-1244(ra) # 800032f6 <readi>
    800047da:	2501                	sext.w	a0,a0
    800047dc:	1aaa9963          	bne	s5,a0,8000498e <exec+0x2c6>
  for(i = 0; i < sz; i += PGSIZE){
    800047e0:	6785                	lui	a5,0x1
    800047e2:	0127893b          	addw	s2,a5,s2
    800047e6:	77fd                	lui	a5,0xfffff
    800047e8:	01478a3b          	addw	s4,a5,s4
    800047ec:	1f897163          	bgeu	s2,s8,800049ce <exec+0x306>
    pa = walkaddr(pagetable, va + i);
    800047f0:	02091593          	slli	a1,s2,0x20
    800047f4:	9181                	srli	a1,a1,0x20
    800047f6:	95ea                	add	a1,a1,s10
    800047f8:	855e                	mv	a0,s7
    800047fa:	ffffc097          	auipc	ra,0xffffc
    800047fe:	d0c080e7          	jalr	-756(ra) # 80000506 <walkaddr>
    80004802:	862a                	mv	a2,a0
    if(pa == 0)
    80004804:	d955                	beqz	a0,800047b8 <exec+0xf0>
      n = PGSIZE;
    80004806:	8ae6                	mv	s5,s9
    if(sz - i < PGSIZE)
    80004808:	fd9a70e3          	bgeu	s4,s9,800047c8 <exec+0x100>
      n = sz - i;
    8000480c:	8ad2                	mv	s5,s4
    8000480e:	bf6d                	j	800047c8 <exec+0x100>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80004810:	4901                	li	s2,0
  iunlockput(ip);
    80004812:	8526                	mv	a0,s1
    80004814:	fffff097          	auipc	ra,0xfffff
    80004818:	a90080e7          	jalr	-1392(ra) # 800032a4 <iunlockput>
  end_op();
    8000481c:	fffff097          	auipc	ra,0xfffff
    80004820:	400080e7          	jalr	1024(ra) # 80003c1c <end_op>
  p = myproc();
    80004824:	ffffd097          	auipc	ra,0xffffd
    80004828:	b1a080e7          	jalr	-1254(ra) # 8000133e <myproc>
    8000482c:	8aaa                	mv	s5,a0
  uint64 oldsz = p->sz;
    8000482e:	04853d03          	ld	s10,72(a0)
  sz = PGROUNDUP(sz);
    80004832:	6785                	lui	a5,0x1
    80004834:	17fd                	addi	a5,a5,-1
    80004836:	993e                	add	s2,s2,a5
    80004838:	757d                	lui	a0,0xfffff
    8000483a:	00a977b3          	and	a5,s2,a0
    8000483e:	e0f43423          	sd	a5,-504(s0)
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    80004842:	6609                	lui	a2,0x2
    80004844:	963e                	add	a2,a2,a5
    80004846:	85be                	mv	a1,a5
    80004848:	855e                	mv	a0,s7
    8000484a:	ffffc097          	auipc	ra,0xffffc
    8000484e:	068080e7          	jalr	104(ra) # 800008b2 <uvmalloc>
    80004852:	8b2a                	mv	s6,a0
  ip = 0;
    80004854:	4481                	li	s1,0
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    80004856:	12050c63          	beqz	a0,8000498e <exec+0x2c6>
  uvmclear(pagetable, sz-2*PGSIZE);
    8000485a:	75f9                	lui	a1,0xffffe
    8000485c:	95aa                	add	a1,a1,a0
    8000485e:	855e                	mv	a0,s7
    80004860:	ffffc097          	auipc	ra,0xffffc
    80004864:	270080e7          	jalr	624(ra) # 80000ad0 <uvmclear>
  stackbase = sp - PGSIZE;
    80004868:	7c7d                	lui	s8,0xfffff
    8000486a:	9c5a                	add	s8,s8,s6
  for(argc = 0; argv[argc]; argc++) {
    8000486c:	e0043783          	ld	a5,-512(s0)
    80004870:	6388                	ld	a0,0(a5)
    80004872:	c535                	beqz	a0,800048de <exec+0x216>
    80004874:	e9040993          	addi	s3,s0,-368
    80004878:	f9040c93          	addi	s9,s0,-112
  sp = sz;
    8000487c:	895a                	mv	s2,s6
    sp -= strlen(argv[argc]) + 1;
    8000487e:	ffffc097          	auipc	ra,0xffffc
    80004882:	a7e080e7          	jalr	-1410(ra) # 800002fc <strlen>
    80004886:	2505                	addiw	a0,a0,1
    80004888:	40a90933          	sub	s2,s2,a0
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    8000488c:	ff097913          	andi	s2,s2,-16
    if(sp < stackbase)
    80004890:	13896363          	bltu	s2,s8,800049b6 <exec+0x2ee>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80004894:	e0043d83          	ld	s11,-512(s0)
    80004898:	000dba03          	ld	s4,0(s11)
    8000489c:	8552                	mv	a0,s4
    8000489e:	ffffc097          	auipc	ra,0xffffc
    800048a2:	a5e080e7          	jalr	-1442(ra) # 800002fc <strlen>
    800048a6:	0015069b          	addiw	a3,a0,1
    800048aa:	8652                	mv	a2,s4
    800048ac:	85ca                	mv	a1,s2
    800048ae:	855e                	mv	a0,s7
    800048b0:	ffffc097          	auipc	ra,0xffffc
    800048b4:	252080e7          	jalr	594(ra) # 80000b02 <copyout>
    800048b8:	10054363          	bltz	a0,800049be <exec+0x2f6>
    ustack[argc] = sp;
    800048bc:	0129b023          	sd	s2,0(s3)
  for(argc = 0; argv[argc]; argc++) {
    800048c0:	0485                	addi	s1,s1,1
    800048c2:	008d8793          	addi	a5,s11,8
    800048c6:	e0f43023          	sd	a5,-512(s0)
    800048ca:	008db503          	ld	a0,8(s11)
    800048ce:	c911                	beqz	a0,800048e2 <exec+0x21a>
    if(argc >= MAXARG)
    800048d0:	09a1                	addi	s3,s3,8
    800048d2:	fb3c96e3          	bne	s9,s3,8000487e <exec+0x1b6>
  sz = sz1;
    800048d6:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    800048da:	4481                	li	s1,0
    800048dc:	a84d                	j	8000498e <exec+0x2c6>
  sp = sz;
    800048de:	895a                	mv	s2,s6
  for(argc = 0; argv[argc]; argc++) {
    800048e0:	4481                	li	s1,0
  ustack[argc] = 0;
    800048e2:	00349793          	slli	a5,s1,0x3
    800048e6:	f9040713          	addi	a4,s0,-112
    800048ea:	97ba                	add	a5,a5,a4
    800048ec:	f007b023          	sd	zero,-256(a5) # f00 <_entry-0x7ffff100>
  sp -= (argc+1) * sizeof(uint64);
    800048f0:	00148693          	addi	a3,s1,1
    800048f4:	068e                	slli	a3,a3,0x3
    800048f6:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    800048fa:	ff097913          	andi	s2,s2,-16
  if(sp < stackbase)
    800048fe:	01897663          	bgeu	s2,s8,8000490a <exec+0x242>
  sz = sz1;
    80004902:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    80004906:	4481                	li	s1,0
    80004908:	a059                	j	8000498e <exec+0x2c6>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    8000490a:	e9040613          	addi	a2,s0,-368
    8000490e:	85ca                	mv	a1,s2
    80004910:	855e                	mv	a0,s7
    80004912:	ffffc097          	auipc	ra,0xffffc
    80004916:	1f0080e7          	jalr	496(ra) # 80000b02 <copyout>
    8000491a:	0a054663          	bltz	a0,800049c6 <exec+0x2fe>
  p->trapframe->a1 = sp;
    8000491e:	058ab783          	ld	a5,88(s5)
    80004922:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    80004926:	df843783          	ld	a5,-520(s0)
    8000492a:	0007c703          	lbu	a4,0(a5)
    8000492e:	cf11                	beqz	a4,8000494a <exec+0x282>
    80004930:	0785                	addi	a5,a5,1
    if(*s == '/')
    80004932:	02f00693          	li	a3,47
    80004936:	a039                	j	80004944 <exec+0x27c>
      last = s+1;
    80004938:	def43c23          	sd	a5,-520(s0)
  for(last=s=path; *s; s++)
    8000493c:	0785                	addi	a5,a5,1
    8000493e:	fff7c703          	lbu	a4,-1(a5)
    80004942:	c701                	beqz	a4,8000494a <exec+0x282>
    if(*s == '/')
    80004944:	fed71ce3          	bne	a4,a3,8000493c <exec+0x274>
    80004948:	bfc5                	j	80004938 <exec+0x270>
  safestrcpy(p->name, last, sizeof(p->name));
    8000494a:	4641                	li	a2,16
    8000494c:	df843583          	ld	a1,-520(s0)
    80004950:	158a8513          	addi	a0,s5,344
    80004954:	ffffc097          	auipc	ra,0xffffc
    80004958:	976080e7          	jalr	-1674(ra) # 800002ca <safestrcpy>
  oldpagetable = p->pagetable;
    8000495c:	050ab503          	ld	a0,80(s5)
  p->pagetable = pagetable;
    80004960:	057ab823          	sd	s7,80(s5)
  p->sz = sz;
    80004964:	056ab423          	sd	s6,72(s5)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    80004968:	058ab783          	ld	a5,88(s5)
    8000496c:	e6843703          	ld	a4,-408(s0)
    80004970:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    80004972:	058ab783          	ld	a5,88(s5)
    80004976:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    8000497a:	85ea                	mv	a1,s10
    8000497c:	ffffd097          	auipc	ra,0xffffd
    80004980:	b22080e7          	jalr	-1246(ra) # 8000149e <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    80004984:	0004851b          	sext.w	a0,s1
    80004988:	bbe1                	j	80004760 <exec+0x98>
    8000498a:	e1243423          	sd	s2,-504(s0)
    proc_freepagetable(pagetable, sz);
    8000498e:	e0843583          	ld	a1,-504(s0)
    80004992:	855e                	mv	a0,s7
    80004994:	ffffd097          	auipc	ra,0xffffd
    80004998:	b0a080e7          	jalr	-1270(ra) # 8000149e <proc_freepagetable>
  if(ip){
    8000499c:	da0498e3          	bnez	s1,8000474c <exec+0x84>
  return -1;
    800049a0:	557d                	li	a0,-1
    800049a2:	bb7d                	j	80004760 <exec+0x98>
    800049a4:	e1243423          	sd	s2,-504(s0)
    800049a8:	b7dd                	j	8000498e <exec+0x2c6>
    800049aa:	e1243423          	sd	s2,-504(s0)
    800049ae:	b7c5                	j	8000498e <exec+0x2c6>
    800049b0:	e1243423          	sd	s2,-504(s0)
    800049b4:	bfe9                	j	8000498e <exec+0x2c6>
  sz = sz1;
    800049b6:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    800049ba:	4481                	li	s1,0
    800049bc:	bfc9                	j	8000498e <exec+0x2c6>
  sz = sz1;
    800049be:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    800049c2:	4481                	li	s1,0
    800049c4:	b7e9                	j	8000498e <exec+0x2c6>
  sz = sz1;
    800049c6:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    800049ca:	4481                	li	s1,0
    800049cc:	b7c9                	j	8000498e <exec+0x2c6>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    800049ce:	e0843903          	ld	s2,-504(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    800049d2:	2b05                	addiw	s6,s6,1
    800049d4:	0389899b          	addiw	s3,s3,56
    800049d8:	e8845783          	lhu	a5,-376(s0)
    800049dc:	e2fb5be3          	bge	s6,a5,80004812 <exec+0x14a>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    800049e0:	2981                	sext.w	s3,s3
    800049e2:	03800713          	li	a4,56
    800049e6:	86ce                	mv	a3,s3
    800049e8:	e1840613          	addi	a2,s0,-488
    800049ec:	4581                	li	a1,0
    800049ee:	8526                	mv	a0,s1
    800049f0:	fffff097          	auipc	ra,0xfffff
    800049f4:	906080e7          	jalr	-1786(ra) # 800032f6 <readi>
    800049f8:	03800793          	li	a5,56
    800049fc:	f8f517e3          	bne	a0,a5,8000498a <exec+0x2c2>
    if(ph.type != ELF_PROG_LOAD)
    80004a00:	e1842783          	lw	a5,-488(s0)
    80004a04:	4705                	li	a4,1
    80004a06:	fce796e3          	bne	a5,a4,800049d2 <exec+0x30a>
    if(ph.memsz < ph.filesz)
    80004a0a:	e4043603          	ld	a2,-448(s0)
    80004a0e:	e3843783          	ld	a5,-456(s0)
    80004a12:	f8f669e3          	bltu	a2,a5,800049a4 <exec+0x2dc>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80004a16:	e2843783          	ld	a5,-472(s0)
    80004a1a:	963e                	add	a2,a2,a5
    80004a1c:	f8f667e3          	bltu	a2,a5,800049aa <exec+0x2e2>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    80004a20:	85ca                	mv	a1,s2
    80004a22:	855e                	mv	a0,s7
    80004a24:	ffffc097          	auipc	ra,0xffffc
    80004a28:	e8e080e7          	jalr	-370(ra) # 800008b2 <uvmalloc>
    80004a2c:	e0a43423          	sd	a0,-504(s0)
    80004a30:	d141                	beqz	a0,800049b0 <exec+0x2e8>
    if((ph.vaddr % PGSIZE) != 0)
    80004a32:	e2843d03          	ld	s10,-472(s0)
    80004a36:	df043783          	ld	a5,-528(s0)
    80004a3a:	00fd77b3          	and	a5,s10,a5
    80004a3e:	fba1                	bnez	a5,8000498e <exec+0x2c6>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80004a40:	e2042d83          	lw	s11,-480(s0)
    80004a44:	e3842c03          	lw	s8,-456(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80004a48:	f80c03e3          	beqz	s8,800049ce <exec+0x306>
    80004a4c:	8a62                	mv	s4,s8
    80004a4e:	4901                	li	s2,0
    80004a50:	b345                	j	800047f0 <exec+0x128>

0000000080004a52 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    80004a52:	7179                	addi	sp,sp,-48
    80004a54:	f406                	sd	ra,40(sp)
    80004a56:	f022                	sd	s0,32(sp)
    80004a58:	ec26                	sd	s1,24(sp)
    80004a5a:	e84a                	sd	s2,16(sp)
    80004a5c:	1800                	addi	s0,sp,48
    80004a5e:	892e                	mv	s2,a1
    80004a60:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    80004a62:	fdc40593          	addi	a1,s0,-36
    80004a66:	ffffe097          	auipc	ra,0xffffe
    80004a6a:	9a2080e7          	jalr	-1630(ra) # 80002408 <argint>
    80004a6e:	04054063          	bltz	a0,80004aae <argfd+0x5c>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    80004a72:	fdc42703          	lw	a4,-36(s0)
    80004a76:	47bd                	li	a5,15
    80004a78:	02e7ed63          	bltu	a5,a4,80004ab2 <argfd+0x60>
    80004a7c:	ffffd097          	auipc	ra,0xffffd
    80004a80:	8c2080e7          	jalr	-1854(ra) # 8000133e <myproc>
    80004a84:	fdc42703          	lw	a4,-36(s0)
    80004a88:	01a70793          	addi	a5,a4,26
    80004a8c:	078e                	slli	a5,a5,0x3
    80004a8e:	953e                	add	a0,a0,a5
    80004a90:	611c                	ld	a5,0(a0)
    80004a92:	c395                	beqz	a5,80004ab6 <argfd+0x64>
    return -1;
  if(pfd)
    80004a94:	00090463          	beqz	s2,80004a9c <argfd+0x4a>
    *pfd = fd;
    80004a98:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    80004a9c:	4501                	li	a0,0
  if(pf)
    80004a9e:	c091                	beqz	s1,80004aa2 <argfd+0x50>
    *pf = f;
    80004aa0:	e09c                	sd	a5,0(s1)
}
    80004aa2:	70a2                	ld	ra,40(sp)
    80004aa4:	7402                	ld	s0,32(sp)
    80004aa6:	64e2                	ld	s1,24(sp)
    80004aa8:	6942                	ld	s2,16(sp)
    80004aaa:	6145                	addi	sp,sp,48
    80004aac:	8082                	ret
    return -1;
    80004aae:	557d                	li	a0,-1
    80004ab0:	bfcd                	j	80004aa2 <argfd+0x50>
    return -1;
    80004ab2:	557d                	li	a0,-1
    80004ab4:	b7fd                	j	80004aa2 <argfd+0x50>
    80004ab6:	557d                	li	a0,-1
    80004ab8:	b7ed                	j	80004aa2 <argfd+0x50>

0000000080004aba <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    80004aba:	1101                	addi	sp,sp,-32
    80004abc:	ec06                	sd	ra,24(sp)
    80004abe:	e822                	sd	s0,16(sp)
    80004ac0:	e426                	sd	s1,8(sp)
    80004ac2:	1000                	addi	s0,sp,32
    80004ac4:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    80004ac6:	ffffd097          	auipc	ra,0xffffd
    80004aca:	878080e7          	jalr	-1928(ra) # 8000133e <myproc>
    80004ace:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    80004ad0:	0d050793          	addi	a5,a0,208 # fffffffffffff0d0 <end+0xffffffff7ffd8e90>
    80004ad4:	4501                	li	a0,0
    80004ad6:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    80004ad8:	6398                	ld	a4,0(a5)
    80004ada:	cb19                	beqz	a4,80004af0 <fdalloc+0x36>
  for(fd = 0; fd < NOFILE; fd++){
    80004adc:	2505                	addiw	a0,a0,1
    80004ade:	07a1                	addi	a5,a5,8
    80004ae0:	fed51ce3          	bne	a0,a3,80004ad8 <fdalloc+0x1e>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    80004ae4:	557d                	li	a0,-1
}
    80004ae6:	60e2                	ld	ra,24(sp)
    80004ae8:	6442                	ld	s0,16(sp)
    80004aea:	64a2                	ld	s1,8(sp)
    80004aec:	6105                	addi	sp,sp,32
    80004aee:	8082                	ret
      p->ofile[fd] = f;
    80004af0:	01a50793          	addi	a5,a0,26
    80004af4:	078e                	slli	a5,a5,0x3
    80004af6:	963e                	add	a2,a2,a5
    80004af8:	e204                	sd	s1,0(a2)
      return fd;
    80004afa:	b7f5                	j	80004ae6 <fdalloc+0x2c>

0000000080004afc <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    80004afc:	715d                	addi	sp,sp,-80
    80004afe:	e486                	sd	ra,72(sp)
    80004b00:	e0a2                	sd	s0,64(sp)
    80004b02:	fc26                	sd	s1,56(sp)
    80004b04:	f84a                	sd	s2,48(sp)
    80004b06:	f44e                	sd	s3,40(sp)
    80004b08:	f052                	sd	s4,32(sp)
    80004b0a:	ec56                	sd	s5,24(sp)
    80004b0c:	0880                	addi	s0,sp,80
    80004b0e:	89ae                	mv	s3,a1
    80004b10:	8ab2                	mv	s5,a2
    80004b12:	8a36                	mv	s4,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    80004b14:	fb040593          	addi	a1,s0,-80
    80004b18:	fffff097          	auipc	ra,0xfffff
    80004b1c:	cf4080e7          	jalr	-780(ra) # 8000380c <nameiparent>
    80004b20:	892a                	mv	s2,a0
    80004b22:	12050f63          	beqz	a0,80004c60 <create+0x164>
    return 0;

  ilock(dp);
    80004b26:	ffffe097          	auipc	ra,0xffffe
    80004b2a:	51c080e7          	jalr	1308(ra) # 80003042 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    80004b2e:	4601                	li	a2,0
    80004b30:	fb040593          	addi	a1,s0,-80
    80004b34:	854a                	mv	a0,s2
    80004b36:	fffff097          	auipc	ra,0xfffff
    80004b3a:	9e6080e7          	jalr	-1562(ra) # 8000351c <dirlookup>
    80004b3e:	84aa                	mv	s1,a0
    80004b40:	c921                	beqz	a0,80004b90 <create+0x94>
    iunlockput(dp);
    80004b42:	854a                	mv	a0,s2
    80004b44:	ffffe097          	auipc	ra,0xffffe
    80004b48:	760080e7          	jalr	1888(ra) # 800032a4 <iunlockput>
    ilock(ip);
    80004b4c:	8526                	mv	a0,s1
    80004b4e:	ffffe097          	auipc	ra,0xffffe
    80004b52:	4f4080e7          	jalr	1268(ra) # 80003042 <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    80004b56:	2981                	sext.w	s3,s3
    80004b58:	4789                	li	a5,2
    80004b5a:	02f99463          	bne	s3,a5,80004b82 <create+0x86>
    80004b5e:	0444d783          	lhu	a5,68(s1)
    80004b62:	37f9                	addiw	a5,a5,-2
    80004b64:	17c2                	slli	a5,a5,0x30
    80004b66:	93c1                	srli	a5,a5,0x30
    80004b68:	4705                	li	a4,1
    80004b6a:	00f76c63          	bltu	a4,a5,80004b82 <create+0x86>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
    80004b6e:	8526                	mv	a0,s1
    80004b70:	60a6                	ld	ra,72(sp)
    80004b72:	6406                	ld	s0,64(sp)
    80004b74:	74e2                	ld	s1,56(sp)
    80004b76:	7942                	ld	s2,48(sp)
    80004b78:	79a2                	ld	s3,40(sp)
    80004b7a:	7a02                	ld	s4,32(sp)
    80004b7c:	6ae2                	ld	s5,24(sp)
    80004b7e:	6161                	addi	sp,sp,80
    80004b80:	8082                	ret
    iunlockput(ip);
    80004b82:	8526                	mv	a0,s1
    80004b84:	ffffe097          	auipc	ra,0xffffe
    80004b88:	720080e7          	jalr	1824(ra) # 800032a4 <iunlockput>
    return 0;
    80004b8c:	4481                	li	s1,0
    80004b8e:	b7c5                	j	80004b6e <create+0x72>
  if((ip = ialloc(dp->dev, type)) == 0)
    80004b90:	85ce                	mv	a1,s3
    80004b92:	00092503          	lw	a0,0(s2)
    80004b96:	ffffe097          	auipc	ra,0xffffe
    80004b9a:	326080e7          	jalr	806(ra) # 80002ebc <ialloc>
    80004b9e:	84aa                	mv	s1,a0
    80004ba0:	c529                	beqz	a0,80004bea <create+0xee>
  ilock(ip);
    80004ba2:	ffffe097          	auipc	ra,0xffffe
    80004ba6:	4a0080e7          	jalr	1184(ra) # 80003042 <ilock>
  ip->major = major;
    80004baa:	05549323          	sh	s5,70(s1)
  ip->minor = minor;
    80004bae:	05449423          	sh	s4,72(s1)
  ip->nlink = 1;
    80004bb2:	4785                	li	a5,1
    80004bb4:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004bb8:	8526                	mv	a0,s1
    80004bba:	ffffe097          	auipc	ra,0xffffe
    80004bbe:	3c6080e7          	jalr	966(ra) # 80002f80 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    80004bc2:	2981                	sext.w	s3,s3
    80004bc4:	4785                	li	a5,1
    80004bc6:	02f98a63          	beq	s3,a5,80004bfa <create+0xfe>
  if(dirlink(dp, name, ip->inum) < 0)
    80004bca:	40d0                	lw	a2,4(s1)
    80004bcc:	fb040593          	addi	a1,s0,-80
    80004bd0:	854a                	mv	a0,s2
    80004bd2:	fffff097          	auipc	ra,0xfffff
    80004bd6:	b5a080e7          	jalr	-1190(ra) # 8000372c <dirlink>
    80004bda:	06054b63          	bltz	a0,80004c50 <create+0x154>
  iunlockput(dp);
    80004bde:	854a                	mv	a0,s2
    80004be0:	ffffe097          	auipc	ra,0xffffe
    80004be4:	6c4080e7          	jalr	1732(ra) # 800032a4 <iunlockput>
  return ip;
    80004be8:	b759                	j	80004b6e <create+0x72>
    panic("create: ialloc");
    80004bea:	00004517          	auipc	a0,0x4
    80004bee:	bf650513          	addi	a0,a0,-1034 # 800087e0 <syscalls+0x390>
    80004bf2:	00002097          	auipc	ra,0x2
    80004bf6:	84e080e7          	jalr	-1970(ra) # 80006440 <panic>
    dp->nlink++;  // for ".."
    80004bfa:	04a95783          	lhu	a5,74(s2)
    80004bfe:	2785                	addiw	a5,a5,1
    80004c00:	04f91523          	sh	a5,74(s2)
    iupdate(dp);
    80004c04:	854a                	mv	a0,s2
    80004c06:	ffffe097          	auipc	ra,0xffffe
    80004c0a:	37a080e7          	jalr	890(ra) # 80002f80 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    80004c0e:	40d0                	lw	a2,4(s1)
    80004c10:	00004597          	auipc	a1,0x4
    80004c14:	be058593          	addi	a1,a1,-1056 # 800087f0 <syscalls+0x3a0>
    80004c18:	8526                	mv	a0,s1
    80004c1a:	fffff097          	auipc	ra,0xfffff
    80004c1e:	b12080e7          	jalr	-1262(ra) # 8000372c <dirlink>
    80004c22:	00054f63          	bltz	a0,80004c40 <create+0x144>
    80004c26:	00492603          	lw	a2,4(s2)
    80004c2a:	00004597          	auipc	a1,0x4
    80004c2e:	bce58593          	addi	a1,a1,-1074 # 800087f8 <syscalls+0x3a8>
    80004c32:	8526                	mv	a0,s1
    80004c34:	fffff097          	auipc	ra,0xfffff
    80004c38:	af8080e7          	jalr	-1288(ra) # 8000372c <dirlink>
    80004c3c:	f80557e3          	bgez	a0,80004bca <create+0xce>
      panic("create dots");
    80004c40:	00004517          	auipc	a0,0x4
    80004c44:	bc050513          	addi	a0,a0,-1088 # 80008800 <syscalls+0x3b0>
    80004c48:	00001097          	auipc	ra,0x1
    80004c4c:	7f8080e7          	jalr	2040(ra) # 80006440 <panic>
    panic("create: dirlink");
    80004c50:	00004517          	auipc	a0,0x4
    80004c54:	bc050513          	addi	a0,a0,-1088 # 80008810 <syscalls+0x3c0>
    80004c58:	00001097          	auipc	ra,0x1
    80004c5c:	7e8080e7          	jalr	2024(ra) # 80006440 <panic>
    return 0;
    80004c60:	84aa                	mv	s1,a0
    80004c62:	b731                	j	80004b6e <create+0x72>

0000000080004c64 <sys_dup>:
{
    80004c64:	7179                	addi	sp,sp,-48
    80004c66:	f406                	sd	ra,40(sp)
    80004c68:	f022                	sd	s0,32(sp)
    80004c6a:	ec26                	sd	s1,24(sp)
    80004c6c:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    80004c6e:	fd840613          	addi	a2,s0,-40
    80004c72:	4581                	li	a1,0
    80004c74:	4501                	li	a0,0
    80004c76:	00000097          	auipc	ra,0x0
    80004c7a:	ddc080e7          	jalr	-548(ra) # 80004a52 <argfd>
    return -1;
    80004c7e:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    80004c80:	02054363          	bltz	a0,80004ca6 <sys_dup+0x42>
  if((fd=fdalloc(f)) < 0)
    80004c84:	fd843503          	ld	a0,-40(s0)
    80004c88:	00000097          	auipc	ra,0x0
    80004c8c:	e32080e7          	jalr	-462(ra) # 80004aba <fdalloc>
    80004c90:	84aa                	mv	s1,a0
    return -1;
    80004c92:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    80004c94:	00054963          	bltz	a0,80004ca6 <sys_dup+0x42>
  filedup(f);
    80004c98:	fd843503          	ld	a0,-40(s0)
    80004c9c:	fffff097          	auipc	ra,0xfffff
    80004ca0:	37a080e7          	jalr	890(ra) # 80004016 <filedup>
  return fd;
    80004ca4:	87a6                	mv	a5,s1
}
    80004ca6:	853e                	mv	a0,a5
    80004ca8:	70a2                	ld	ra,40(sp)
    80004caa:	7402                	ld	s0,32(sp)
    80004cac:	64e2                	ld	s1,24(sp)
    80004cae:	6145                	addi	sp,sp,48
    80004cb0:	8082                	ret

0000000080004cb2 <sys_read>:
{
    80004cb2:	7179                	addi	sp,sp,-48
    80004cb4:	f406                	sd	ra,40(sp)
    80004cb6:	f022                	sd	s0,32(sp)
    80004cb8:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004cba:	fe840613          	addi	a2,s0,-24
    80004cbe:	4581                	li	a1,0
    80004cc0:	4501                	li	a0,0
    80004cc2:	00000097          	auipc	ra,0x0
    80004cc6:	d90080e7          	jalr	-624(ra) # 80004a52 <argfd>
    return -1;
    80004cca:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004ccc:	04054163          	bltz	a0,80004d0e <sys_read+0x5c>
    80004cd0:	fe440593          	addi	a1,s0,-28
    80004cd4:	4509                	li	a0,2
    80004cd6:	ffffd097          	auipc	ra,0xffffd
    80004cda:	732080e7          	jalr	1842(ra) # 80002408 <argint>
    return -1;
    80004cde:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004ce0:	02054763          	bltz	a0,80004d0e <sys_read+0x5c>
    80004ce4:	fd840593          	addi	a1,s0,-40
    80004ce8:	4505                	li	a0,1
    80004cea:	ffffd097          	auipc	ra,0xffffd
    80004cee:	740080e7          	jalr	1856(ra) # 8000242a <argaddr>
    return -1;
    80004cf2:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004cf4:	00054d63          	bltz	a0,80004d0e <sys_read+0x5c>
  return fileread(f, p, n);
    80004cf8:	fe442603          	lw	a2,-28(s0)
    80004cfc:	fd843583          	ld	a1,-40(s0)
    80004d00:	fe843503          	ld	a0,-24(s0)
    80004d04:	fffff097          	auipc	ra,0xfffff
    80004d08:	49e080e7          	jalr	1182(ra) # 800041a2 <fileread>
    80004d0c:	87aa                	mv	a5,a0
}
    80004d0e:	853e                	mv	a0,a5
    80004d10:	70a2                	ld	ra,40(sp)
    80004d12:	7402                	ld	s0,32(sp)
    80004d14:	6145                	addi	sp,sp,48
    80004d16:	8082                	ret

0000000080004d18 <sys_write>:
{
    80004d18:	7179                	addi	sp,sp,-48
    80004d1a:	f406                	sd	ra,40(sp)
    80004d1c:	f022                	sd	s0,32(sp)
    80004d1e:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004d20:	fe840613          	addi	a2,s0,-24
    80004d24:	4581                	li	a1,0
    80004d26:	4501                	li	a0,0
    80004d28:	00000097          	auipc	ra,0x0
    80004d2c:	d2a080e7          	jalr	-726(ra) # 80004a52 <argfd>
    return -1;
    80004d30:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004d32:	04054163          	bltz	a0,80004d74 <sys_write+0x5c>
    80004d36:	fe440593          	addi	a1,s0,-28
    80004d3a:	4509                	li	a0,2
    80004d3c:	ffffd097          	auipc	ra,0xffffd
    80004d40:	6cc080e7          	jalr	1740(ra) # 80002408 <argint>
    return -1;
    80004d44:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004d46:	02054763          	bltz	a0,80004d74 <sys_write+0x5c>
    80004d4a:	fd840593          	addi	a1,s0,-40
    80004d4e:	4505                	li	a0,1
    80004d50:	ffffd097          	auipc	ra,0xffffd
    80004d54:	6da080e7          	jalr	1754(ra) # 8000242a <argaddr>
    return -1;
    80004d58:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004d5a:	00054d63          	bltz	a0,80004d74 <sys_write+0x5c>
  return filewrite(f, p, n);
    80004d5e:	fe442603          	lw	a2,-28(s0)
    80004d62:	fd843583          	ld	a1,-40(s0)
    80004d66:	fe843503          	ld	a0,-24(s0)
    80004d6a:	fffff097          	auipc	ra,0xfffff
    80004d6e:	4fa080e7          	jalr	1274(ra) # 80004264 <filewrite>
    80004d72:	87aa                	mv	a5,a0
}
    80004d74:	853e                	mv	a0,a5
    80004d76:	70a2                	ld	ra,40(sp)
    80004d78:	7402                	ld	s0,32(sp)
    80004d7a:	6145                	addi	sp,sp,48
    80004d7c:	8082                	ret

0000000080004d7e <sys_close>:
{
    80004d7e:	1101                	addi	sp,sp,-32
    80004d80:	ec06                	sd	ra,24(sp)
    80004d82:	e822                	sd	s0,16(sp)
    80004d84:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    80004d86:	fe040613          	addi	a2,s0,-32
    80004d8a:	fec40593          	addi	a1,s0,-20
    80004d8e:	4501                	li	a0,0
    80004d90:	00000097          	auipc	ra,0x0
    80004d94:	cc2080e7          	jalr	-830(ra) # 80004a52 <argfd>
    return -1;
    80004d98:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    80004d9a:	02054463          	bltz	a0,80004dc2 <sys_close+0x44>
  myproc()->ofile[fd] = 0;
    80004d9e:	ffffc097          	auipc	ra,0xffffc
    80004da2:	5a0080e7          	jalr	1440(ra) # 8000133e <myproc>
    80004da6:	fec42783          	lw	a5,-20(s0)
    80004daa:	07e9                	addi	a5,a5,26
    80004dac:	078e                	slli	a5,a5,0x3
    80004dae:	97aa                	add	a5,a5,a0
    80004db0:	0007b023          	sd	zero,0(a5)
  fileclose(f);
    80004db4:	fe043503          	ld	a0,-32(s0)
    80004db8:	fffff097          	auipc	ra,0xfffff
    80004dbc:	2b0080e7          	jalr	688(ra) # 80004068 <fileclose>
  return 0;
    80004dc0:	4781                	li	a5,0
}
    80004dc2:	853e                	mv	a0,a5
    80004dc4:	60e2                	ld	ra,24(sp)
    80004dc6:	6442                	ld	s0,16(sp)
    80004dc8:	6105                	addi	sp,sp,32
    80004dca:	8082                	ret

0000000080004dcc <sys_fstat>:
{
    80004dcc:	1101                	addi	sp,sp,-32
    80004dce:	ec06                	sd	ra,24(sp)
    80004dd0:	e822                	sd	s0,16(sp)
    80004dd2:	1000                	addi	s0,sp,32
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80004dd4:	fe840613          	addi	a2,s0,-24
    80004dd8:	4581                	li	a1,0
    80004dda:	4501                	li	a0,0
    80004ddc:	00000097          	auipc	ra,0x0
    80004de0:	c76080e7          	jalr	-906(ra) # 80004a52 <argfd>
    return -1;
    80004de4:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80004de6:	02054563          	bltz	a0,80004e10 <sys_fstat+0x44>
    80004dea:	fe040593          	addi	a1,s0,-32
    80004dee:	4505                	li	a0,1
    80004df0:	ffffd097          	auipc	ra,0xffffd
    80004df4:	63a080e7          	jalr	1594(ra) # 8000242a <argaddr>
    return -1;
    80004df8:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80004dfa:	00054b63          	bltz	a0,80004e10 <sys_fstat+0x44>
  return filestat(f, st);
    80004dfe:	fe043583          	ld	a1,-32(s0)
    80004e02:	fe843503          	ld	a0,-24(s0)
    80004e06:	fffff097          	auipc	ra,0xfffff
    80004e0a:	32a080e7          	jalr	810(ra) # 80004130 <filestat>
    80004e0e:	87aa                	mv	a5,a0
}
    80004e10:	853e                	mv	a0,a5
    80004e12:	60e2                	ld	ra,24(sp)
    80004e14:	6442                	ld	s0,16(sp)
    80004e16:	6105                	addi	sp,sp,32
    80004e18:	8082                	ret

0000000080004e1a <sys_link>:
{
    80004e1a:	7169                	addi	sp,sp,-304
    80004e1c:	f606                	sd	ra,296(sp)
    80004e1e:	f222                	sd	s0,288(sp)
    80004e20:	ee26                	sd	s1,280(sp)
    80004e22:	ea4a                	sd	s2,272(sp)
    80004e24:	1a00                	addi	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004e26:	08000613          	li	a2,128
    80004e2a:	ed040593          	addi	a1,s0,-304
    80004e2e:	4501                	li	a0,0
    80004e30:	ffffd097          	auipc	ra,0xffffd
    80004e34:	61c080e7          	jalr	1564(ra) # 8000244c <argstr>
    return -1;
    80004e38:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004e3a:	10054e63          	bltz	a0,80004f56 <sys_link+0x13c>
    80004e3e:	08000613          	li	a2,128
    80004e42:	f5040593          	addi	a1,s0,-176
    80004e46:	4505                	li	a0,1
    80004e48:	ffffd097          	auipc	ra,0xffffd
    80004e4c:	604080e7          	jalr	1540(ra) # 8000244c <argstr>
    return -1;
    80004e50:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004e52:	10054263          	bltz	a0,80004f56 <sys_link+0x13c>
  begin_op();
    80004e56:	fffff097          	auipc	ra,0xfffff
    80004e5a:	d46080e7          	jalr	-698(ra) # 80003b9c <begin_op>
  if((ip = namei(old)) == 0){
    80004e5e:	ed040513          	addi	a0,s0,-304
    80004e62:	fffff097          	auipc	ra,0xfffff
    80004e66:	98c080e7          	jalr	-1652(ra) # 800037ee <namei>
    80004e6a:	84aa                	mv	s1,a0
    80004e6c:	c551                	beqz	a0,80004ef8 <sys_link+0xde>
  ilock(ip);
    80004e6e:	ffffe097          	auipc	ra,0xffffe
    80004e72:	1d4080e7          	jalr	468(ra) # 80003042 <ilock>
  if(ip->type == T_DIR){
    80004e76:	04449703          	lh	a4,68(s1)
    80004e7a:	4785                	li	a5,1
    80004e7c:	08f70463          	beq	a4,a5,80004f04 <sys_link+0xea>
  ip->nlink++;
    80004e80:	04a4d783          	lhu	a5,74(s1)
    80004e84:	2785                	addiw	a5,a5,1
    80004e86:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004e8a:	8526                	mv	a0,s1
    80004e8c:	ffffe097          	auipc	ra,0xffffe
    80004e90:	0f4080e7          	jalr	244(ra) # 80002f80 <iupdate>
  iunlock(ip);
    80004e94:	8526                	mv	a0,s1
    80004e96:	ffffe097          	auipc	ra,0xffffe
    80004e9a:	26e080e7          	jalr	622(ra) # 80003104 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    80004e9e:	fd040593          	addi	a1,s0,-48
    80004ea2:	f5040513          	addi	a0,s0,-176
    80004ea6:	fffff097          	auipc	ra,0xfffff
    80004eaa:	966080e7          	jalr	-1690(ra) # 8000380c <nameiparent>
    80004eae:	892a                	mv	s2,a0
    80004eb0:	c935                	beqz	a0,80004f24 <sys_link+0x10a>
  ilock(dp);
    80004eb2:	ffffe097          	auipc	ra,0xffffe
    80004eb6:	190080e7          	jalr	400(ra) # 80003042 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    80004eba:	00092703          	lw	a4,0(s2)
    80004ebe:	409c                	lw	a5,0(s1)
    80004ec0:	04f71d63          	bne	a4,a5,80004f1a <sys_link+0x100>
    80004ec4:	40d0                	lw	a2,4(s1)
    80004ec6:	fd040593          	addi	a1,s0,-48
    80004eca:	854a                	mv	a0,s2
    80004ecc:	fffff097          	auipc	ra,0xfffff
    80004ed0:	860080e7          	jalr	-1952(ra) # 8000372c <dirlink>
    80004ed4:	04054363          	bltz	a0,80004f1a <sys_link+0x100>
  iunlockput(dp);
    80004ed8:	854a                	mv	a0,s2
    80004eda:	ffffe097          	auipc	ra,0xffffe
    80004ede:	3ca080e7          	jalr	970(ra) # 800032a4 <iunlockput>
  iput(ip);
    80004ee2:	8526                	mv	a0,s1
    80004ee4:	ffffe097          	auipc	ra,0xffffe
    80004ee8:	318080e7          	jalr	792(ra) # 800031fc <iput>
  end_op();
    80004eec:	fffff097          	auipc	ra,0xfffff
    80004ef0:	d30080e7          	jalr	-720(ra) # 80003c1c <end_op>
  return 0;
    80004ef4:	4781                	li	a5,0
    80004ef6:	a085                	j	80004f56 <sys_link+0x13c>
    end_op();
    80004ef8:	fffff097          	auipc	ra,0xfffff
    80004efc:	d24080e7          	jalr	-732(ra) # 80003c1c <end_op>
    return -1;
    80004f00:	57fd                	li	a5,-1
    80004f02:	a891                	j	80004f56 <sys_link+0x13c>
    iunlockput(ip);
    80004f04:	8526                	mv	a0,s1
    80004f06:	ffffe097          	auipc	ra,0xffffe
    80004f0a:	39e080e7          	jalr	926(ra) # 800032a4 <iunlockput>
    end_op();
    80004f0e:	fffff097          	auipc	ra,0xfffff
    80004f12:	d0e080e7          	jalr	-754(ra) # 80003c1c <end_op>
    return -1;
    80004f16:	57fd                	li	a5,-1
    80004f18:	a83d                	j	80004f56 <sys_link+0x13c>
    iunlockput(dp);
    80004f1a:	854a                	mv	a0,s2
    80004f1c:	ffffe097          	auipc	ra,0xffffe
    80004f20:	388080e7          	jalr	904(ra) # 800032a4 <iunlockput>
  ilock(ip);
    80004f24:	8526                	mv	a0,s1
    80004f26:	ffffe097          	auipc	ra,0xffffe
    80004f2a:	11c080e7          	jalr	284(ra) # 80003042 <ilock>
  ip->nlink--;
    80004f2e:	04a4d783          	lhu	a5,74(s1)
    80004f32:	37fd                	addiw	a5,a5,-1
    80004f34:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004f38:	8526                	mv	a0,s1
    80004f3a:	ffffe097          	auipc	ra,0xffffe
    80004f3e:	046080e7          	jalr	70(ra) # 80002f80 <iupdate>
  iunlockput(ip);
    80004f42:	8526                	mv	a0,s1
    80004f44:	ffffe097          	auipc	ra,0xffffe
    80004f48:	360080e7          	jalr	864(ra) # 800032a4 <iunlockput>
  end_op();
    80004f4c:	fffff097          	auipc	ra,0xfffff
    80004f50:	cd0080e7          	jalr	-816(ra) # 80003c1c <end_op>
  return -1;
    80004f54:	57fd                	li	a5,-1
}
    80004f56:	853e                	mv	a0,a5
    80004f58:	70b2                	ld	ra,296(sp)
    80004f5a:	7412                	ld	s0,288(sp)
    80004f5c:	64f2                	ld	s1,280(sp)
    80004f5e:	6952                	ld	s2,272(sp)
    80004f60:	6155                	addi	sp,sp,304
    80004f62:	8082                	ret

0000000080004f64 <sys_unlink>:
{
    80004f64:	7151                	addi	sp,sp,-240
    80004f66:	f586                	sd	ra,232(sp)
    80004f68:	f1a2                	sd	s0,224(sp)
    80004f6a:	eda6                	sd	s1,216(sp)
    80004f6c:	e9ca                	sd	s2,208(sp)
    80004f6e:	e5ce                	sd	s3,200(sp)
    80004f70:	1980                	addi	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    80004f72:	08000613          	li	a2,128
    80004f76:	f3040593          	addi	a1,s0,-208
    80004f7a:	4501                	li	a0,0
    80004f7c:	ffffd097          	auipc	ra,0xffffd
    80004f80:	4d0080e7          	jalr	1232(ra) # 8000244c <argstr>
    80004f84:	18054163          	bltz	a0,80005106 <sys_unlink+0x1a2>
  begin_op();
    80004f88:	fffff097          	auipc	ra,0xfffff
    80004f8c:	c14080e7          	jalr	-1004(ra) # 80003b9c <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    80004f90:	fb040593          	addi	a1,s0,-80
    80004f94:	f3040513          	addi	a0,s0,-208
    80004f98:	fffff097          	auipc	ra,0xfffff
    80004f9c:	874080e7          	jalr	-1932(ra) # 8000380c <nameiparent>
    80004fa0:	84aa                	mv	s1,a0
    80004fa2:	c979                	beqz	a0,80005078 <sys_unlink+0x114>
  ilock(dp);
    80004fa4:	ffffe097          	auipc	ra,0xffffe
    80004fa8:	09e080e7          	jalr	158(ra) # 80003042 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    80004fac:	00004597          	auipc	a1,0x4
    80004fb0:	84458593          	addi	a1,a1,-1980 # 800087f0 <syscalls+0x3a0>
    80004fb4:	fb040513          	addi	a0,s0,-80
    80004fb8:	ffffe097          	auipc	ra,0xffffe
    80004fbc:	54a080e7          	jalr	1354(ra) # 80003502 <namecmp>
    80004fc0:	14050a63          	beqz	a0,80005114 <sys_unlink+0x1b0>
    80004fc4:	00004597          	auipc	a1,0x4
    80004fc8:	83458593          	addi	a1,a1,-1996 # 800087f8 <syscalls+0x3a8>
    80004fcc:	fb040513          	addi	a0,s0,-80
    80004fd0:	ffffe097          	auipc	ra,0xffffe
    80004fd4:	532080e7          	jalr	1330(ra) # 80003502 <namecmp>
    80004fd8:	12050e63          	beqz	a0,80005114 <sys_unlink+0x1b0>
  if((ip = dirlookup(dp, name, &off)) == 0)
    80004fdc:	f2c40613          	addi	a2,s0,-212
    80004fe0:	fb040593          	addi	a1,s0,-80
    80004fe4:	8526                	mv	a0,s1
    80004fe6:	ffffe097          	auipc	ra,0xffffe
    80004fea:	536080e7          	jalr	1334(ra) # 8000351c <dirlookup>
    80004fee:	892a                	mv	s2,a0
    80004ff0:	12050263          	beqz	a0,80005114 <sys_unlink+0x1b0>
  ilock(ip);
    80004ff4:	ffffe097          	auipc	ra,0xffffe
    80004ff8:	04e080e7          	jalr	78(ra) # 80003042 <ilock>
  if(ip->nlink < 1)
    80004ffc:	04a91783          	lh	a5,74(s2)
    80005000:	08f05263          	blez	a5,80005084 <sys_unlink+0x120>
  if(ip->type == T_DIR && !isdirempty(ip)){
    80005004:	04491703          	lh	a4,68(s2)
    80005008:	4785                	li	a5,1
    8000500a:	08f70563          	beq	a4,a5,80005094 <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
    8000500e:	4641                	li	a2,16
    80005010:	4581                	li	a1,0
    80005012:	fc040513          	addi	a0,s0,-64
    80005016:	ffffb097          	auipc	ra,0xffffb
    8000501a:	162080e7          	jalr	354(ra) # 80000178 <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000501e:	4741                	li	a4,16
    80005020:	f2c42683          	lw	a3,-212(s0)
    80005024:	fc040613          	addi	a2,s0,-64
    80005028:	4581                	li	a1,0
    8000502a:	8526                	mv	a0,s1
    8000502c:	ffffe097          	auipc	ra,0xffffe
    80005030:	3c2080e7          	jalr	962(ra) # 800033ee <writei>
    80005034:	47c1                	li	a5,16
    80005036:	0af51563          	bne	a0,a5,800050e0 <sys_unlink+0x17c>
  if(ip->type == T_DIR){
    8000503a:	04491703          	lh	a4,68(s2)
    8000503e:	4785                	li	a5,1
    80005040:	0af70863          	beq	a4,a5,800050f0 <sys_unlink+0x18c>
  iunlockput(dp);
    80005044:	8526                	mv	a0,s1
    80005046:	ffffe097          	auipc	ra,0xffffe
    8000504a:	25e080e7          	jalr	606(ra) # 800032a4 <iunlockput>
  ip->nlink--;
    8000504e:	04a95783          	lhu	a5,74(s2)
    80005052:	37fd                	addiw	a5,a5,-1
    80005054:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    80005058:	854a                	mv	a0,s2
    8000505a:	ffffe097          	auipc	ra,0xffffe
    8000505e:	f26080e7          	jalr	-218(ra) # 80002f80 <iupdate>
  iunlockput(ip);
    80005062:	854a                	mv	a0,s2
    80005064:	ffffe097          	auipc	ra,0xffffe
    80005068:	240080e7          	jalr	576(ra) # 800032a4 <iunlockput>
  end_op();
    8000506c:	fffff097          	auipc	ra,0xfffff
    80005070:	bb0080e7          	jalr	-1104(ra) # 80003c1c <end_op>
  return 0;
    80005074:	4501                	li	a0,0
    80005076:	a84d                	j	80005128 <sys_unlink+0x1c4>
    end_op();
    80005078:	fffff097          	auipc	ra,0xfffff
    8000507c:	ba4080e7          	jalr	-1116(ra) # 80003c1c <end_op>
    return -1;
    80005080:	557d                	li	a0,-1
    80005082:	a05d                	j	80005128 <sys_unlink+0x1c4>
    panic("unlink: nlink < 1");
    80005084:	00003517          	auipc	a0,0x3
    80005088:	79c50513          	addi	a0,a0,1948 # 80008820 <syscalls+0x3d0>
    8000508c:	00001097          	auipc	ra,0x1
    80005090:	3b4080e7          	jalr	948(ra) # 80006440 <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80005094:	04c92703          	lw	a4,76(s2)
    80005098:	02000793          	li	a5,32
    8000509c:	f6e7f9e3          	bgeu	a5,a4,8000500e <sys_unlink+0xaa>
    800050a0:	02000993          	li	s3,32
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800050a4:	4741                	li	a4,16
    800050a6:	86ce                	mv	a3,s3
    800050a8:	f1840613          	addi	a2,s0,-232
    800050ac:	4581                	li	a1,0
    800050ae:	854a                	mv	a0,s2
    800050b0:	ffffe097          	auipc	ra,0xffffe
    800050b4:	246080e7          	jalr	582(ra) # 800032f6 <readi>
    800050b8:	47c1                	li	a5,16
    800050ba:	00f51b63          	bne	a0,a5,800050d0 <sys_unlink+0x16c>
    if(de.inum != 0)
    800050be:	f1845783          	lhu	a5,-232(s0)
    800050c2:	e7a1                	bnez	a5,8000510a <sys_unlink+0x1a6>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    800050c4:	29c1                	addiw	s3,s3,16
    800050c6:	04c92783          	lw	a5,76(s2)
    800050ca:	fcf9ede3          	bltu	s3,a5,800050a4 <sys_unlink+0x140>
    800050ce:	b781                	j	8000500e <sys_unlink+0xaa>
      panic("isdirempty: readi");
    800050d0:	00003517          	auipc	a0,0x3
    800050d4:	76850513          	addi	a0,a0,1896 # 80008838 <syscalls+0x3e8>
    800050d8:	00001097          	auipc	ra,0x1
    800050dc:	368080e7          	jalr	872(ra) # 80006440 <panic>
    panic("unlink: writei");
    800050e0:	00003517          	auipc	a0,0x3
    800050e4:	77050513          	addi	a0,a0,1904 # 80008850 <syscalls+0x400>
    800050e8:	00001097          	auipc	ra,0x1
    800050ec:	358080e7          	jalr	856(ra) # 80006440 <panic>
    dp->nlink--;
    800050f0:	04a4d783          	lhu	a5,74(s1)
    800050f4:	37fd                	addiw	a5,a5,-1
    800050f6:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    800050fa:	8526                	mv	a0,s1
    800050fc:	ffffe097          	auipc	ra,0xffffe
    80005100:	e84080e7          	jalr	-380(ra) # 80002f80 <iupdate>
    80005104:	b781                	j	80005044 <sys_unlink+0xe0>
    return -1;
    80005106:	557d                	li	a0,-1
    80005108:	a005                	j	80005128 <sys_unlink+0x1c4>
    iunlockput(ip);
    8000510a:	854a                	mv	a0,s2
    8000510c:	ffffe097          	auipc	ra,0xffffe
    80005110:	198080e7          	jalr	408(ra) # 800032a4 <iunlockput>
  iunlockput(dp);
    80005114:	8526                	mv	a0,s1
    80005116:	ffffe097          	auipc	ra,0xffffe
    8000511a:	18e080e7          	jalr	398(ra) # 800032a4 <iunlockput>
  end_op();
    8000511e:	fffff097          	auipc	ra,0xfffff
    80005122:	afe080e7          	jalr	-1282(ra) # 80003c1c <end_op>
  return -1;
    80005126:	557d                	li	a0,-1
}
    80005128:	70ae                	ld	ra,232(sp)
    8000512a:	740e                	ld	s0,224(sp)
    8000512c:	64ee                	ld	s1,216(sp)
    8000512e:	694e                	ld	s2,208(sp)
    80005130:	69ae                	ld	s3,200(sp)
    80005132:	616d                	addi	sp,sp,240
    80005134:	8082                	ret

0000000080005136 <sys_open>:

uint64
sys_open(void)
{
    80005136:	7131                	addi	sp,sp,-192
    80005138:	fd06                	sd	ra,184(sp)
    8000513a:	f922                	sd	s0,176(sp)
    8000513c:	f526                	sd	s1,168(sp)
    8000513e:	f14a                	sd	s2,160(sp)
    80005140:	ed4e                	sd	s3,152(sp)
    80005142:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    80005144:	08000613          	li	a2,128
    80005148:	f5040593          	addi	a1,s0,-176
    8000514c:	4501                	li	a0,0
    8000514e:	ffffd097          	auipc	ra,0xffffd
    80005152:	2fe080e7          	jalr	766(ra) # 8000244c <argstr>
    return -1;
    80005156:	54fd                	li	s1,-1
  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    80005158:	0c054163          	bltz	a0,8000521a <sys_open+0xe4>
    8000515c:	f4c40593          	addi	a1,s0,-180
    80005160:	4505                	li	a0,1
    80005162:	ffffd097          	auipc	ra,0xffffd
    80005166:	2a6080e7          	jalr	678(ra) # 80002408 <argint>
    8000516a:	0a054863          	bltz	a0,8000521a <sys_open+0xe4>

  begin_op();
    8000516e:	fffff097          	auipc	ra,0xfffff
    80005172:	a2e080e7          	jalr	-1490(ra) # 80003b9c <begin_op>

  if(omode & O_CREATE){
    80005176:	f4c42783          	lw	a5,-180(s0)
    8000517a:	2007f793          	andi	a5,a5,512
    8000517e:	cbdd                	beqz	a5,80005234 <sys_open+0xfe>
    ip = create(path, T_FILE, 0, 0);
    80005180:	4681                	li	a3,0
    80005182:	4601                	li	a2,0
    80005184:	4589                	li	a1,2
    80005186:	f5040513          	addi	a0,s0,-176
    8000518a:	00000097          	auipc	ra,0x0
    8000518e:	972080e7          	jalr	-1678(ra) # 80004afc <create>
    80005192:	892a                	mv	s2,a0
    if(ip == 0){
    80005194:	c959                	beqz	a0,8000522a <sys_open+0xf4>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80005196:	04491703          	lh	a4,68(s2)
    8000519a:	478d                	li	a5,3
    8000519c:	00f71763          	bne	a4,a5,800051aa <sys_open+0x74>
    800051a0:	04695703          	lhu	a4,70(s2)
    800051a4:	47a5                	li	a5,9
    800051a6:	0ce7ec63          	bltu	a5,a4,8000527e <sys_open+0x148>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    800051aa:	fffff097          	auipc	ra,0xfffff
    800051ae:	e02080e7          	jalr	-510(ra) # 80003fac <filealloc>
    800051b2:	89aa                	mv	s3,a0
    800051b4:	10050263          	beqz	a0,800052b8 <sys_open+0x182>
    800051b8:	00000097          	auipc	ra,0x0
    800051bc:	902080e7          	jalr	-1790(ra) # 80004aba <fdalloc>
    800051c0:	84aa                	mv	s1,a0
    800051c2:	0e054663          	bltz	a0,800052ae <sys_open+0x178>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    800051c6:	04491703          	lh	a4,68(s2)
    800051ca:	478d                	li	a5,3
    800051cc:	0cf70463          	beq	a4,a5,80005294 <sys_open+0x15e>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    800051d0:	4789                	li	a5,2
    800051d2:	00f9a023          	sw	a5,0(s3)
    f->off = 0;
    800051d6:	0209a023          	sw	zero,32(s3)
  }
  f->ip = ip;
    800051da:	0129bc23          	sd	s2,24(s3)
  f->readable = !(omode & O_WRONLY);
    800051de:	f4c42783          	lw	a5,-180(s0)
    800051e2:	0017c713          	xori	a4,a5,1
    800051e6:	8b05                	andi	a4,a4,1
    800051e8:	00e98423          	sb	a4,8(s3)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    800051ec:	0037f713          	andi	a4,a5,3
    800051f0:	00e03733          	snez	a4,a4
    800051f4:	00e984a3          	sb	a4,9(s3)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    800051f8:	4007f793          	andi	a5,a5,1024
    800051fc:	c791                	beqz	a5,80005208 <sys_open+0xd2>
    800051fe:	04491703          	lh	a4,68(s2)
    80005202:	4789                	li	a5,2
    80005204:	08f70f63          	beq	a4,a5,800052a2 <sys_open+0x16c>
    itrunc(ip);
  }

  iunlock(ip);
    80005208:	854a                	mv	a0,s2
    8000520a:	ffffe097          	auipc	ra,0xffffe
    8000520e:	efa080e7          	jalr	-262(ra) # 80003104 <iunlock>
  end_op();
    80005212:	fffff097          	auipc	ra,0xfffff
    80005216:	a0a080e7          	jalr	-1526(ra) # 80003c1c <end_op>

  return fd;
}
    8000521a:	8526                	mv	a0,s1
    8000521c:	70ea                	ld	ra,184(sp)
    8000521e:	744a                	ld	s0,176(sp)
    80005220:	74aa                	ld	s1,168(sp)
    80005222:	790a                	ld	s2,160(sp)
    80005224:	69ea                	ld	s3,152(sp)
    80005226:	6129                	addi	sp,sp,192
    80005228:	8082                	ret
      end_op();
    8000522a:	fffff097          	auipc	ra,0xfffff
    8000522e:	9f2080e7          	jalr	-1550(ra) # 80003c1c <end_op>
      return -1;
    80005232:	b7e5                	j	8000521a <sys_open+0xe4>
    if((ip = namei(path)) == 0){
    80005234:	f5040513          	addi	a0,s0,-176
    80005238:	ffffe097          	auipc	ra,0xffffe
    8000523c:	5b6080e7          	jalr	1462(ra) # 800037ee <namei>
    80005240:	892a                	mv	s2,a0
    80005242:	c905                	beqz	a0,80005272 <sys_open+0x13c>
    ilock(ip);
    80005244:	ffffe097          	auipc	ra,0xffffe
    80005248:	dfe080e7          	jalr	-514(ra) # 80003042 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    8000524c:	04491703          	lh	a4,68(s2)
    80005250:	4785                	li	a5,1
    80005252:	f4f712e3          	bne	a4,a5,80005196 <sys_open+0x60>
    80005256:	f4c42783          	lw	a5,-180(s0)
    8000525a:	dba1                	beqz	a5,800051aa <sys_open+0x74>
      iunlockput(ip);
    8000525c:	854a                	mv	a0,s2
    8000525e:	ffffe097          	auipc	ra,0xffffe
    80005262:	046080e7          	jalr	70(ra) # 800032a4 <iunlockput>
      end_op();
    80005266:	fffff097          	auipc	ra,0xfffff
    8000526a:	9b6080e7          	jalr	-1610(ra) # 80003c1c <end_op>
      return -1;
    8000526e:	54fd                	li	s1,-1
    80005270:	b76d                	j	8000521a <sys_open+0xe4>
      end_op();
    80005272:	fffff097          	auipc	ra,0xfffff
    80005276:	9aa080e7          	jalr	-1622(ra) # 80003c1c <end_op>
      return -1;
    8000527a:	54fd                	li	s1,-1
    8000527c:	bf79                	j	8000521a <sys_open+0xe4>
    iunlockput(ip);
    8000527e:	854a                	mv	a0,s2
    80005280:	ffffe097          	auipc	ra,0xffffe
    80005284:	024080e7          	jalr	36(ra) # 800032a4 <iunlockput>
    end_op();
    80005288:	fffff097          	auipc	ra,0xfffff
    8000528c:	994080e7          	jalr	-1644(ra) # 80003c1c <end_op>
    return -1;
    80005290:	54fd                	li	s1,-1
    80005292:	b761                	j	8000521a <sys_open+0xe4>
    f->type = FD_DEVICE;
    80005294:	00f9a023          	sw	a5,0(s3)
    f->major = ip->major;
    80005298:	04691783          	lh	a5,70(s2)
    8000529c:	02f99223          	sh	a5,36(s3)
    800052a0:	bf2d                	j	800051da <sys_open+0xa4>
    itrunc(ip);
    800052a2:	854a                	mv	a0,s2
    800052a4:	ffffe097          	auipc	ra,0xffffe
    800052a8:	eac080e7          	jalr	-340(ra) # 80003150 <itrunc>
    800052ac:	bfb1                	j	80005208 <sys_open+0xd2>
      fileclose(f);
    800052ae:	854e                	mv	a0,s3
    800052b0:	fffff097          	auipc	ra,0xfffff
    800052b4:	db8080e7          	jalr	-584(ra) # 80004068 <fileclose>
    iunlockput(ip);
    800052b8:	854a                	mv	a0,s2
    800052ba:	ffffe097          	auipc	ra,0xffffe
    800052be:	fea080e7          	jalr	-22(ra) # 800032a4 <iunlockput>
    end_op();
    800052c2:	fffff097          	auipc	ra,0xfffff
    800052c6:	95a080e7          	jalr	-1702(ra) # 80003c1c <end_op>
    return -1;
    800052ca:	54fd                	li	s1,-1
    800052cc:	b7b9                	j	8000521a <sys_open+0xe4>

00000000800052ce <sys_mkdir>:

uint64
sys_mkdir(void)
{
    800052ce:	7175                	addi	sp,sp,-144
    800052d0:	e506                	sd	ra,136(sp)
    800052d2:	e122                	sd	s0,128(sp)
    800052d4:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    800052d6:	fffff097          	auipc	ra,0xfffff
    800052da:	8c6080e7          	jalr	-1850(ra) # 80003b9c <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    800052de:	08000613          	li	a2,128
    800052e2:	f7040593          	addi	a1,s0,-144
    800052e6:	4501                	li	a0,0
    800052e8:	ffffd097          	auipc	ra,0xffffd
    800052ec:	164080e7          	jalr	356(ra) # 8000244c <argstr>
    800052f0:	02054963          	bltz	a0,80005322 <sys_mkdir+0x54>
    800052f4:	4681                	li	a3,0
    800052f6:	4601                	li	a2,0
    800052f8:	4585                	li	a1,1
    800052fa:	f7040513          	addi	a0,s0,-144
    800052fe:	fffff097          	auipc	ra,0xfffff
    80005302:	7fe080e7          	jalr	2046(ra) # 80004afc <create>
    80005306:	cd11                	beqz	a0,80005322 <sys_mkdir+0x54>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80005308:	ffffe097          	auipc	ra,0xffffe
    8000530c:	f9c080e7          	jalr	-100(ra) # 800032a4 <iunlockput>
  end_op();
    80005310:	fffff097          	auipc	ra,0xfffff
    80005314:	90c080e7          	jalr	-1780(ra) # 80003c1c <end_op>
  return 0;
    80005318:	4501                	li	a0,0
}
    8000531a:	60aa                	ld	ra,136(sp)
    8000531c:	640a                	ld	s0,128(sp)
    8000531e:	6149                	addi	sp,sp,144
    80005320:	8082                	ret
    end_op();
    80005322:	fffff097          	auipc	ra,0xfffff
    80005326:	8fa080e7          	jalr	-1798(ra) # 80003c1c <end_op>
    return -1;
    8000532a:	557d                	li	a0,-1
    8000532c:	b7fd                	j	8000531a <sys_mkdir+0x4c>

000000008000532e <sys_mknod>:

uint64
sys_mknod(void)
{
    8000532e:	7135                	addi	sp,sp,-160
    80005330:	ed06                	sd	ra,152(sp)
    80005332:	e922                	sd	s0,144(sp)
    80005334:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80005336:	fffff097          	auipc	ra,0xfffff
    8000533a:	866080e7          	jalr	-1946(ra) # 80003b9c <begin_op>
  if((argstr(0, path, MAXPATH)) < 0 ||
    8000533e:	08000613          	li	a2,128
    80005342:	f7040593          	addi	a1,s0,-144
    80005346:	4501                	li	a0,0
    80005348:	ffffd097          	auipc	ra,0xffffd
    8000534c:	104080e7          	jalr	260(ra) # 8000244c <argstr>
    80005350:	04054a63          	bltz	a0,800053a4 <sys_mknod+0x76>
     argint(1, &major) < 0 ||
    80005354:	f6c40593          	addi	a1,s0,-148
    80005358:	4505                	li	a0,1
    8000535a:	ffffd097          	auipc	ra,0xffffd
    8000535e:	0ae080e7          	jalr	174(ra) # 80002408 <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80005362:	04054163          	bltz	a0,800053a4 <sys_mknod+0x76>
     argint(2, &minor) < 0 ||
    80005366:	f6840593          	addi	a1,s0,-152
    8000536a:	4509                	li	a0,2
    8000536c:	ffffd097          	auipc	ra,0xffffd
    80005370:	09c080e7          	jalr	156(ra) # 80002408 <argint>
     argint(1, &major) < 0 ||
    80005374:	02054863          	bltz	a0,800053a4 <sys_mknod+0x76>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80005378:	f6841683          	lh	a3,-152(s0)
    8000537c:	f6c41603          	lh	a2,-148(s0)
    80005380:	458d                	li	a1,3
    80005382:	f7040513          	addi	a0,s0,-144
    80005386:	fffff097          	auipc	ra,0xfffff
    8000538a:	776080e7          	jalr	1910(ra) # 80004afc <create>
     argint(2, &minor) < 0 ||
    8000538e:	c919                	beqz	a0,800053a4 <sys_mknod+0x76>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80005390:	ffffe097          	auipc	ra,0xffffe
    80005394:	f14080e7          	jalr	-236(ra) # 800032a4 <iunlockput>
  end_op();
    80005398:	fffff097          	auipc	ra,0xfffff
    8000539c:	884080e7          	jalr	-1916(ra) # 80003c1c <end_op>
  return 0;
    800053a0:	4501                	li	a0,0
    800053a2:	a031                	j	800053ae <sys_mknod+0x80>
    end_op();
    800053a4:	fffff097          	auipc	ra,0xfffff
    800053a8:	878080e7          	jalr	-1928(ra) # 80003c1c <end_op>
    return -1;
    800053ac:	557d                	li	a0,-1
}
    800053ae:	60ea                	ld	ra,152(sp)
    800053b0:	644a                	ld	s0,144(sp)
    800053b2:	610d                	addi	sp,sp,160
    800053b4:	8082                	ret

00000000800053b6 <sys_chdir>:

uint64
sys_chdir(void)
{
    800053b6:	7135                	addi	sp,sp,-160
    800053b8:	ed06                	sd	ra,152(sp)
    800053ba:	e922                	sd	s0,144(sp)
    800053bc:	e526                	sd	s1,136(sp)
    800053be:	e14a                	sd	s2,128(sp)
    800053c0:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    800053c2:	ffffc097          	auipc	ra,0xffffc
    800053c6:	f7c080e7          	jalr	-132(ra) # 8000133e <myproc>
    800053ca:	892a                	mv	s2,a0
  
  begin_op();
    800053cc:	ffffe097          	auipc	ra,0xffffe
    800053d0:	7d0080e7          	jalr	2000(ra) # 80003b9c <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    800053d4:	08000613          	li	a2,128
    800053d8:	f6040593          	addi	a1,s0,-160
    800053dc:	4501                	li	a0,0
    800053de:	ffffd097          	auipc	ra,0xffffd
    800053e2:	06e080e7          	jalr	110(ra) # 8000244c <argstr>
    800053e6:	04054b63          	bltz	a0,8000543c <sys_chdir+0x86>
    800053ea:	f6040513          	addi	a0,s0,-160
    800053ee:	ffffe097          	auipc	ra,0xffffe
    800053f2:	400080e7          	jalr	1024(ra) # 800037ee <namei>
    800053f6:	84aa                	mv	s1,a0
    800053f8:	c131                	beqz	a0,8000543c <sys_chdir+0x86>
    end_op();
    return -1;
  }
  ilock(ip);
    800053fa:	ffffe097          	auipc	ra,0xffffe
    800053fe:	c48080e7          	jalr	-952(ra) # 80003042 <ilock>
  if(ip->type != T_DIR){
    80005402:	04449703          	lh	a4,68(s1)
    80005406:	4785                	li	a5,1
    80005408:	04f71063          	bne	a4,a5,80005448 <sys_chdir+0x92>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    8000540c:	8526                	mv	a0,s1
    8000540e:	ffffe097          	auipc	ra,0xffffe
    80005412:	cf6080e7          	jalr	-778(ra) # 80003104 <iunlock>
  iput(p->cwd);
    80005416:	15093503          	ld	a0,336(s2)
    8000541a:	ffffe097          	auipc	ra,0xffffe
    8000541e:	de2080e7          	jalr	-542(ra) # 800031fc <iput>
  end_op();
    80005422:	ffffe097          	auipc	ra,0xffffe
    80005426:	7fa080e7          	jalr	2042(ra) # 80003c1c <end_op>
  p->cwd = ip;
    8000542a:	14993823          	sd	s1,336(s2)
  return 0;
    8000542e:	4501                	li	a0,0
}
    80005430:	60ea                	ld	ra,152(sp)
    80005432:	644a                	ld	s0,144(sp)
    80005434:	64aa                	ld	s1,136(sp)
    80005436:	690a                	ld	s2,128(sp)
    80005438:	610d                	addi	sp,sp,160
    8000543a:	8082                	ret
    end_op();
    8000543c:	ffffe097          	auipc	ra,0xffffe
    80005440:	7e0080e7          	jalr	2016(ra) # 80003c1c <end_op>
    return -1;
    80005444:	557d                	li	a0,-1
    80005446:	b7ed                	j	80005430 <sys_chdir+0x7a>
    iunlockput(ip);
    80005448:	8526                	mv	a0,s1
    8000544a:	ffffe097          	auipc	ra,0xffffe
    8000544e:	e5a080e7          	jalr	-422(ra) # 800032a4 <iunlockput>
    end_op();
    80005452:	ffffe097          	auipc	ra,0xffffe
    80005456:	7ca080e7          	jalr	1994(ra) # 80003c1c <end_op>
    return -1;
    8000545a:	557d                	li	a0,-1
    8000545c:	bfd1                	j	80005430 <sys_chdir+0x7a>

000000008000545e <sys_exec>:

uint64
sys_exec(void)
{
    8000545e:	7145                	addi	sp,sp,-464
    80005460:	e786                	sd	ra,456(sp)
    80005462:	e3a2                	sd	s0,448(sp)
    80005464:	ff26                	sd	s1,440(sp)
    80005466:	fb4a                	sd	s2,432(sp)
    80005468:	f74e                	sd	s3,424(sp)
    8000546a:	f352                	sd	s4,416(sp)
    8000546c:	ef56                	sd	s5,408(sp)
    8000546e:	0b80                	addi	s0,sp,464
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    80005470:	08000613          	li	a2,128
    80005474:	f4040593          	addi	a1,s0,-192
    80005478:	4501                	li	a0,0
    8000547a:	ffffd097          	auipc	ra,0xffffd
    8000547e:	fd2080e7          	jalr	-46(ra) # 8000244c <argstr>
    return -1;
    80005482:	597d                	li	s2,-1
  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    80005484:	0c054a63          	bltz	a0,80005558 <sys_exec+0xfa>
    80005488:	e3840593          	addi	a1,s0,-456
    8000548c:	4505                	li	a0,1
    8000548e:	ffffd097          	auipc	ra,0xffffd
    80005492:	f9c080e7          	jalr	-100(ra) # 8000242a <argaddr>
    80005496:	0c054163          	bltz	a0,80005558 <sys_exec+0xfa>
  }
  memset(argv, 0, sizeof(argv));
    8000549a:	10000613          	li	a2,256
    8000549e:	4581                	li	a1,0
    800054a0:	e4040513          	addi	a0,s0,-448
    800054a4:	ffffb097          	auipc	ra,0xffffb
    800054a8:	cd4080e7          	jalr	-812(ra) # 80000178 <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    800054ac:	e4040493          	addi	s1,s0,-448
  memset(argv, 0, sizeof(argv));
    800054b0:	89a6                	mv	s3,s1
    800054b2:	4901                	li	s2,0
    if(i >= NELEM(argv)){
    800054b4:	02000a13          	li	s4,32
    800054b8:	00090a9b          	sext.w	s5,s2
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    800054bc:	00391513          	slli	a0,s2,0x3
    800054c0:	e3040593          	addi	a1,s0,-464
    800054c4:	e3843783          	ld	a5,-456(s0)
    800054c8:	953e                	add	a0,a0,a5
    800054ca:	ffffd097          	auipc	ra,0xffffd
    800054ce:	ea4080e7          	jalr	-348(ra) # 8000236e <fetchaddr>
    800054d2:	02054a63          	bltz	a0,80005506 <sys_exec+0xa8>
      goto bad;
    }
    if(uarg == 0){
    800054d6:	e3043783          	ld	a5,-464(s0)
    800054da:	c3b9                	beqz	a5,80005520 <sys_exec+0xc2>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    800054dc:	ffffb097          	auipc	ra,0xffffb
    800054e0:	c3c080e7          	jalr	-964(ra) # 80000118 <kalloc>
    800054e4:	85aa                	mv	a1,a0
    800054e6:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    800054ea:	cd11                	beqz	a0,80005506 <sys_exec+0xa8>
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    800054ec:	6605                	lui	a2,0x1
    800054ee:	e3043503          	ld	a0,-464(s0)
    800054f2:	ffffd097          	auipc	ra,0xffffd
    800054f6:	ece080e7          	jalr	-306(ra) # 800023c0 <fetchstr>
    800054fa:	00054663          	bltz	a0,80005506 <sys_exec+0xa8>
    if(i >= NELEM(argv)){
    800054fe:	0905                	addi	s2,s2,1
    80005500:	09a1                	addi	s3,s3,8
    80005502:	fb491be3          	bne	s2,s4,800054b8 <sys_exec+0x5a>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005506:	10048913          	addi	s2,s1,256
    8000550a:	6088                	ld	a0,0(s1)
    8000550c:	c529                	beqz	a0,80005556 <sys_exec+0xf8>
    kfree(argv[i]);
    8000550e:	ffffb097          	auipc	ra,0xffffb
    80005512:	b0e080e7          	jalr	-1266(ra) # 8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005516:	04a1                	addi	s1,s1,8
    80005518:	ff2499e3          	bne	s1,s2,8000550a <sys_exec+0xac>
  return -1;
    8000551c:	597d                	li	s2,-1
    8000551e:	a82d                	j	80005558 <sys_exec+0xfa>
      argv[i] = 0;
    80005520:	0a8e                	slli	s5,s5,0x3
    80005522:	fc040793          	addi	a5,s0,-64
    80005526:	9abe                	add	s5,s5,a5
    80005528:	e80ab023          	sd	zero,-384(s5)
  int ret = exec(path, argv);
    8000552c:	e4040593          	addi	a1,s0,-448
    80005530:	f4040513          	addi	a0,s0,-192
    80005534:	fffff097          	auipc	ra,0xfffff
    80005538:	194080e7          	jalr	404(ra) # 800046c8 <exec>
    8000553c:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8000553e:	10048993          	addi	s3,s1,256
    80005542:	6088                	ld	a0,0(s1)
    80005544:	c911                	beqz	a0,80005558 <sys_exec+0xfa>
    kfree(argv[i]);
    80005546:	ffffb097          	auipc	ra,0xffffb
    8000554a:	ad6080e7          	jalr	-1322(ra) # 8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8000554e:	04a1                	addi	s1,s1,8
    80005550:	ff3499e3          	bne	s1,s3,80005542 <sys_exec+0xe4>
    80005554:	a011                	j	80005558 <sys_exec+0xfa>
  return -1;
    80005556:	597d                	li	s2,-1
}
    80005558:	854a                	mv	a0,s2
    8000555a:	60be                	ld	ra,456(sp)
    8000555c:	641e                	ld	s0,448(sp)
    8000555e:	74fa                	ld	s1,440(sp)
    80005560:	795a                	ld	s2,432(sp)
    80005562:	79ba                	ld	s3,424(sp)
    80005564:	7a1a                	ld	s4,416(sp)
    80005566:	6afa                	ld	s5,408(sp)
    80005568:	6179                	addi	sp,sp,464
    8000556a:	8082                	ret

000000008000556c <sys_pipe>:

uint64
sys_pipe(void)
{
    8000556c:	7139                	addi	sp,sp,-64
    8000556e:	fc06                	sd	ra,56(sp)
    80005570:	f822                	sd	s0,48(sp)
    80005572:	f426                	sd	s1,40(sp)
    80005574:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    80005576:	ffffc097          	auipc	ra,0xffffc
    8000557a:	dc8080e7          	jalr	-568(ra) # 8000133e <myproc>
    8000557e:	84aa                	mv	s1,a0

  if(argaddr(0, &fdarray) < 0)
    80005580:	fd840593          	addi	a1,s0,-40
    80005584:	4501                	li	a0,0
    80005586:	ffffd097          	auipc	ra,0xffffd
    8000558a:	ea4080e7          	jalr	-348(ra) # 8000242a <argaddr>
    return -1;
    8000558e:	57fd                	li	a5,-1
  if(argaddr(0, &fdarray) < 0)
    80005590:	0e054063          	bltz	a0,80005670 <sys_pipe+0x104>
  if(pipealloc(&rf, &wf) < 0)
    80005594:	fc840593          	addi	a1,s0,-56
    80005598:	fd040513          	addi	a0,s0,-48
    8000559c:	fffff097          	auipc	ra,0xfffff
    800055a0:	dfc080e7          	jalr	-516(ra) # 80004398 <pipealloc>
    return -1;
    800055a4:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    800055a6:	0c054563          	bltz	a0,80005670 <sys_pipe+0x104>
  fd0 = -1;
    800055aa:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    800055ae:	fd043503          	ld	a0,-48(s0)
    800055b2:	fffff097          	auipc	ra,0xfffff
    800055b6:	508080e7          	jalr	1288(ra) # 80004aba <fdalloc>
    800055ba:	fca42223          	sw	a0,-60(s0)
    800055be:	08054c63          	bltz	a0,80005656 <sys_pipe+0xea>
    800055c2:	fc843503          	ld	a0,-56(s0)
    800055c6:	fffff097          	auipc	ra,0xfffff
    800055ca:	4f4080e7          	jalr	1268(ra) # 80004aba <fdalloc>
    800055ce:	fca42023          	sw	a0,-64(s0)
    800055d2:	06054863          	bltz	a0,80005642 <sys_pipe+0xd6>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    800055d6:	4691                	li	a3,4
    800055d8:	fc440613          	addi	a2,s0,-60
    800055dc:	fd843583          	ld	a1,-40(s0)
    800055e0:	68a8                	ld	a0,80(s1)
    800055e2:	ffffb097          	auipc	ra,0xffffb
    800055e6:	520080e7          	jalr	1312(ra) # 80000b02 <copyout>
    800055ea:	02054063          	bltz	a0,8000560a <sys_pipe+0x9e>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    800055ee:	4691                	li	a3,4
    800055f0:	fc040613          	addi	a2,s0,-64
    800055f4:	fd843583          	ld	a1,-40(s0)
    800055f8:	0591                	addi	a1,a1,4
    800055fa:	68a8                	ld	a0,80(s1)
    800055fc:	ffffb097          	auipc	ra,0xffffb
    80005600:	506080e7          	jalr	1286(ra) # 80000b02 <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    80005604:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80005606:	06055563          	bgez	a0,80005670 <sys_pipe+0x104>
    p->ofile[fd0] = 0;
    8000560a:	fc442783          	lw	a5,-60(s0)
    8000560e:	07e9                	addi	a5,a5,26
    80005610:	078e                	slli	a5,a5,0x3
    80005612:	97a6                	add	a5,a5,s1
    80005614:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    80005618:	fc042503          	lw	a0,-64(s0)
    8000561c:	0569                	addi	a0,a0,26
    8000561e:	050e                	slli	a0,a0,0x3
    80005620:	9526                	add	a0,a0,s1
    80005622:	00053023          	sd	zero,0(a0)
    fileclose(rf);
    80005626:	fd043503          	ld	a0,-48(s0)
    8000562a:	fffff097          	auipc	ra,0xfffff
    8000562e:	a3e080e7          	jalr	-1474(ra) # 80004068 <fileclose>
    fileclose(wf);
    80005632:	fc843503          	ld	a0,-56(s0)
    80005636:	fffff097          	auipc	ra,0xfffff
    8000563a:	a32080e7          	jalr	-1486(ra) # 80004068 <fileclose>
    return -1;
    8000563e:	57fd                	li	a5,-1
    80005640:	a805                	j	80005670 <sys_pipe+0x104>
    if(fd0 >= 0)
    80005642:	fc442783          	lw	a5,-60(s0)
    80005646:	0007c863          	bltz	a5,80005656 <sys_pipe+0xea>
      p->ofile[fd0] = 0;
    8000564a:	01a78513          	addi	a0,a5,26
    8000564e:	050e                	slli	a0,a0,0x3
    80005650:	9526                	add	a0,a0,s1
    80005652:	00053023          	sd	zero,0(a0)
    fileclose(rf);
    80005656:	fd043503          	ld	a0,-48(s0)
    8000565a:	fffff097          	auipc	ra,0xfffff
    8000565e:	a0e080e7          	jalr	-1522(ra) # 80004068 <fileclose>
    fileclose(wf);
    80005662:	fc843503          	ld	a0,-56(s0)
    80005666:	fffff097          	auipc	ra,0xfffff
    8000566a:	a02080e7          	jalr	-1534(ra) # 80004068 <fileclose>
    return -1;
    8000566e:	57fd                	li	a5,-1
}
    80005670:	853e                	mv	a0,a5
    80005672:	70e2                	ld	ra,56(sp)
    80005674:	7442                	ld	s0,48(sp)
    80005676:	74a2                	ld	s1,40(sp)
    80005678:	6121                	addi	sp,sp,64
    8000567a:	8082                	ret
    8000567c:	0000                	unimp
	...

0000000080005680 <kernelvec>:
    80005680:	7111                	addi	sp,sp,-256
    80005682:	e006                	sd	ra,0(sp)
    80005684:	e40a                	sd	sp,8(sp)
    80005686:	e80e                	sd	gp,16(sp)
    80005688:	ec12                	sd	tp,24(sp)
    8000568a:	f016                	sd	t0,32(sp)
    8000568c:	f41a                	sd	t1,40(sp)
    8000568e:	f81e                	sd	t2,48(sp)
    80005690:	fc22                	sd	s0,56(sp)
    80005692:	e0a6                	sd	s1,64(sp)
    80005694:	e4aa                	sd	a0,72(sp)
    80005696:	e8ae                	sd	a1,80(sp)
    80005698:	ecb2                	sd	a2,88(sp)
    8000569a:	f0b6                	sd	a3,96(sp)
    8000569c:	f4ba                	sd	a4,104(sp)
    8000569e:	f8be                	sd	a5,112(sp)
    800056a0:	fcc2                	sd	a6,120(sp)
    800056a2:	e146                	sd	a7,128(sp)
    800056a4:	e54a                	sd	s2,136(sp)
    800056a6:	e94e                	sd	s3,144(sp)
    800056a8:	ed52                	sd	s4,152(sp)
    800056aa:	f156                	sd	s5,160(sp)
    800056ac:	f55a                	sd	s6,168(sp)
    800056ae:	f95e                	sd	s7,176(sp)
    800056b0:	fd62                	sd	s8,184(sp)
    800056b2:	e1e6                	sd	s9,192(sp)
    800056b4:	e5ea                	sd	s10,200(sp)
    800056b6:	e9ee                	sd	s11,208(sp)
    800056b8:	edf2                	sd	t3,216(sp)
    800056ba:	f1f6                	sd	t4,224(sp)
    800056bc:	f5fa                	sd	t5,232(sp)
    800056be:	f9fe                	sd	t6,240(sp)
    800056c0:	b7bfc0ef          	jal	ra,8000223a <kerneltrap>
    800056c4:	6082                	ld	ra,0(sp)
    800056c6:	6122                	ld	sp,8(sp)
    800056c8:	61c2                	ld	gp,16(sp)
    800056ca:	7282                	ld	t0,32(sp)
    800056cc:	7322                	ld	t1,40(sp)
    800056ce:	73c2                	ld	t2,48(sp)
    800056d0:	7462                	ld	s0,56(sp)
    800056d2:	6486                	ld	s1,64(sp)
    800056d4:	6526                	ld	a0,72(sp)
    800056d6:	65c6                	ld	a1,80(sp)
    800056d8:	6666                	ld	a2,88(sp)
    800056da:	7686                	ld	a3,96(sp)
    800056dc:	7726                	ld	a4,104(sp)
    800056de:	77c6                	ld	a5,112(sp)
    800056e0:	7866                	ld	a6,120(sp)
    800056e2:	688a                	ld	a7,128(sp)
    800056e4:	692a                	ld	s2,136(sp)
    800056e6:	69ca                	ld	s3,144(sp)
    800056e8:	6a6a                	ld	s4,152(sp)
    800056ea:	7a8a                	ld	s5,160(sp)
    800056ec:	7b2a                	ld	s6,168(sp)
    800056ee:	7bca                	ld	s7,176(sp)
    800056f0:	7c6a                	ld	s8,184(sp)
    800056f2:	6c8e                	ld	s9,192(sp)
    800056f4:	6d2e                	ld	s10,200(sp)
    800056f6:	6dce                	ld	s11,208(sp)
    800056f8:	6e6e                	ld	t3,216(sp)
    800056fa:	7e8e                	ld	t4,224(sp)
    800056fc:	7f2e                	ld	t5,232(sp)
    800056fe:	7fce                	ld	t6,240(sp)
    80005700:	6111                	addi	sp,sp,256
    80005702:	10200073          	sret
    80005706:	00000013          	nop
    8000570a:	00000013          	nop
    8000570e:	0001                	nop

0000000080005710 <timervec>:
    80005710:	34051573          	csrrw	a0,mscratch,a0
    80005714:	e10c                	sd	a1,0(a0)
    80005716:	e510                	sd	a2,8(a0)
    80005718:	e914                	sd	a3,16(a0)
    8000571a:	6d0c                	ld	a1,24(a0)
    8000571c:	7110                	ld	a2,32(a0)
    8000571e:	6194                	ld	a3,0(a1)
    80005720:	96b2                	add	a3,a3,a2
    80005722:	e194                	sd	a3,0(a1)
    80005724:	4589                	li	a1,2
    80005726:	14459073          	csrw	sip,a1
    8000572a:	6914                	ld	a3,16(a0)
    8000572c:	6510                	ld	a2,8(a0)
    8000572e:	610c                	ld	a1,0(a0)
    80005730:	34051573          	csrrw	a0,mscratch,a0
    80005734:	30200073          	mret
	...

000000008000573a <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    8000573a:	1141                	addi	sp,sp,-16
    8000573c:	e422                	sd	s0,8(sp)
    8000573e:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80005740:	0c0007b7          	lui	a5,0xc000
    80005744:	4705                	li	a4,1
    80005746:	d798                	sw	a4,40(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    80005748:	c3d8                	sw	a4,4(a5)
}
    8000574a:	6422                	ld	s0,8(sp)
    8000574c:	0141                	addi	sp,sp,16
    8000574e:	8082                	ret

0000000080005750 <plicinithart>:

void
plicinithart(void)
{
    80005750:	1141                	addi	sp,sp,-16
    80005752:	e406                	sd	ra,8(sp)
    80005754:	e022                	sd	s0,0(sp)
    80005756:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005758:	ffffc097          	auipc	ra,0xffffc
    8000575c:	bba080e7          	jalr	-1094(ra) # 80001312 <cpuid>
  
  // set uart's enable bit for this hart's S-mode. 
  *(uint32*)PLIC_SENABLE(hart)= (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80005760:	0085171b          	slliw	a4,a0,0x8
    80005764:	0c0027b7          	lui	a5,0xc002
    80005768:	97ba                	add	a5,a5,a4
    8000576a:	40200713          	li	a4,1026
    8000576e:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80005772:	00d5151b          	slliw	a0,a0,0xd
    80005776:	0c2017b7          	lui	a5,0xc201
    8000577a:	953e                	add	a0,a0,a5
    8000577c:	00052023          	sw	zero,0(a0)
}
    80005780:	60a2                	ld	ra,8(sp)
    80005782:	6402                	ld	s0,0(sp)
    80005784:	0141                	addi	sp,sp,16
    80005786:	8082                	ret

0000000080005788 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    80005788:	1141                	addi	sp,sp,-16
    8000578a:	e406                	sd	ra,8(sp)
    8000578c:	e022                	sd	s0,0(sp)
    8000578e:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005790:	ffffc097          	auipc	ra,0xffffc
    80005794:	b82080e7          	jalr	-1150(ra) # 80001312 <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    80005798:	00d5179b          	slliw	a5,a0,0xd
    8000579c:	0c201537          	lui	a0,0xc201
    800057a0:	953e                	add	a0,a0,a5
  return irq;
}
    800057a2:	4148                	lw	a0,4(a0)
    800057a4:	60a2                	ld	ra,8(sp)
    800057a6:	6402                	ld	s0,0(sp)
    800057a8:	0141                	addi	sp,sp,16
    800057aa:	8082                	ret

00000000800057ac <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    800057ac:	1101                	addi	sp,sp,-32
    800057ae:	ec06                	sd	ra,24(sp)
    800057b0:	e822                	sd	s0,16(sp)
    800057b2:	e426                	sd	s1,8(sp)
    800057b4:	1000                	addi	s0,sp,32
    800057b6:	84aa                	mv	s1,a0
  int hart = cpuid();
    800057b8:	ffffc097          	auipc	ra,0xffffc
    800057bc:	b5a080e7          	jalr	-1190(ra) # 80001312 <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    800057c0:	00d5151b          	slliw	a0,a0,0xd
    800057c4:	0c2017b7          	lui	a5,0xc201
    800057c8:	97aa                	add	a5,a5,a0
    800057ca:	c3c4                	sw	s1,4(a5)
}
    800057cc:	60e2                	ld	ra,24(sp)
    800057ce:	6442                	ld	s0,16(sp)
    800057d0:	64a2                	ld	s1,8(sp)
    800057d2:	6105                	addi	sp,sp,32
    800057d4:	8082                	ret

00000000800057d6 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    800057d6:	1141                	addi	sp,sp,-16
    800057d8:	e406                	sd	ra,8(sp)
    800057da:	e022                	sd	s0,0(sp)
    800057dc:	0800                	addi	s0,sp,16
  if(i >= NUM)
    800057de:	479d                	li	a5,7
    800057e0:	06a7c963          	blt	a5,a0,80005852 <free_desc+0x7c>
    panic("free_desc 1");
  if(disk.free[i])
    800057e4:	00016797          	auipc	a5,0x16
    800057e8:	81c78793          	addi	a5,a5,-2020 # 8001b000 <disk>
    800057ec:	00a78733          	add	a4,a5,a0
    800057f0:	6789                	lui	a5,0x2
    800057f2:	97ba                	add	a5,a5,a4
    800057f4:	0187c783          	lbu	a5,24(a5) # 2018 <_entry-0x7fffdfe8>
    800057f8:	e7ad                	bnez	a5,80005862 <free_desc+0x8c>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    800057fa:	00451793          	slli	a5,a0,0x4
    800057fe:	00018717          	auipc	a4,0x18
    80005802:	80270713          	addi	a4,a4,-2046 # 8001d000 <disk+0x2000>
    80005806:	6314                	ld	a3,0(a4)
    80005808:	96be                	add	a3,a3,a5
    8000580a:	0006b023          	sd	zero,0(a3)
  disk.desc[i].len = 0;
    8000580e:	6314                	ld	a3,0(a4)
    80005810:	96be                	add	a3,a3,a5
    80005812:	0006a423          	sw	zero,8(a3)
  disk.desc[i].flags = 0;
    80005816:	6314                	ld	a3,0(a4)
    80005818:	96be                	add	a3,a3,a5
    8000581a:	00069623          	sh	zero,12(a3)
  disk.desc[i].next = 0;
    8000581e:	6318                	ld	a4,0(a4)
    80005820:	97ba                	add	a5,a5,a4
    80005822:	00079723          	sh	zero,14(a5)
  disk.free[i] = 1;
    80005826:	00015797          	auipc	a5,0x15
    8000582a:	7da78793          	addi	a5,a5,2010 # 8001b000 <disk>
    8000582e:	97aa                	add	a5,a5,a0
    80005830:	6509                	lui	a0,0x2
    80005832:	953e                	add	a0,a0,a5
    80005834:	4785                	li	a5,1
    80005836:	00f50c23          	sb	a5,24(a0) # 2018 <_entry-0x7fffdfe8>
  wakeup(&disk.free[0]);
    8000583a:	00017517          	auipc	a0,0x17
    8000583e:	7de50513          	addi	a0,a0,2014 # 8001d018 <disk+0x2018>
    80005842:	ffffc097          	auipc	ra,0xffffc
    80005846:	344080e7          	jalr	836(ra) # 80001b86 <wakeup>
}
    8000584a:	60a2                	ld	ra,8(sp)
    8000584c:	6402                	ld	s0,0(sp)
    8000584e:	0141                	addi	sp,sp,16
    80005850:	8082                	ret
    panic("free_desc 1");
    80005852:	00003517          	auipc	a0,0x3
    80005856:	00e50513          	addi	a0,a0,14 # 80008860 <syscalls+0x410>
    8000585a:	00001097          	auipc	ra,0x1
    8000585e:	be6080e7          	jalr	-1050(ra) # 80006440 <panic>
    panic("free_desc 2");
    80005862:	00003517          	auipc	a0,0x3
    80005866:	00e50513          	addi	a0,a0,14 # 80008870 <syscalls+0x420>
    8000586a:	00001097          	auipc	ra,0x1
    8000586e:	bd6080e7          	jalr	-1066(ra) # 80006440 <panic>

0000000080005872 <virtio_disk_init>:
{
    80005872:	1101                	addi	sp,sp,-32
    80005874:	ec06                	sd	ra,24(sp)
    80005876:	e822                	sd	s0,16(sp)
    80005878:	e426                	sd	s1,8(sp)
    8000587a:	1000                	addi	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    8000587c:	00003597          	auipc	a1,0x3
    80005880:	00458593          	addi	a1,a1,4 # 80008880 <syscalls+0x430>
    80005884:	00018517          	auipc	a0,0x18
    80005888:	8a450513          	addi	a0,a0,-1884 # 8001d128 <disk+0x2128>
    8000588c:	00001097          	auipc	ra,0x1
    80005890:	06e080e7          	jalr	110(ra) # 800068fa <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80005894:	100017b7          	lui	a5,0x10001
    80005898:	4398                	lw	a4,0(a5)
    8000589a:	2701                	sext.w	a4,a4
    8000589c:	747277b7          	lui	a5,0x74727
    800058a0:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    800058a4:	0ef71163          	bne	a4,a5,80005986 <virtio_disk_init+0x114>
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    800058a8:	100017b7          	lui	a5,0x10001
    800058ac:	43dc                	lw	a5,4(a5)
    800058ae:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    800058b0:	4705                	li	a4,1
    800058b2:	0ce79a63          	bne	a5,a4,80005986 <virtio_disk_init+0x114>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    800058b6:	100017b7          	lui	a5,0x10001
    800058ba:	479c                	lw	a5,8(a5)
    800058bc:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    800058be:	4709                	li	a4,2
    800058c0:	0ce79363          	bne	a5,a4,80005986 <virtio_disk_init+0x114>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    800058c4:	100017b7          	lui	a5,0x10001
    800058c8:	47d8                	lw	a4,12(a5)
    800058ca:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    800058cc:	554d47b7          	lui	a5,0x554d4
    800058d0:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    800058d4:	0af71963          	bne	a4,a5,80005986 <virtio_disk_init+0x114>
  *R(VIRTIO_MMIO_STATUS) = status;
    800058d8:	100017b7          	lui	a5,0x10001
    800058dc:	4705                	li	a4,1
    800058de:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    800058e0:	470d                	li	a4,3
    800058e2:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    800058e4:	4b94                	lw	a3,16(a5)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    800058e6:	c7ffe737          	lui	a4,0xc7ffe
    800058ea:	75f70713          	addi	a4,a4,1887 # ffffffffc7ffe75f <end+0xffffffff47fd851f>
    800058ee:	8f75                	and	a4,a4,a3
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    800058f0:	2701                	sext.w	a4,a4
    800058f2:	d398                	sw	a4,32(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    800058f4:	472d                	li	a4,11
    800058f6:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    800058f8:	473d                	li	a4,15
    800058fa:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_GUEST_PAGE_SIZE) = PGSIZE;
    800058fc:	6705                	lui	a4,0x1
    800058fe:	d798                	sw	a4,40(a5)
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    80005900:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    80005904:	5bdc                	lw	a5,52(a5)
    80005906:	2781                	sext.w	a5,a5
  if(max == 0)
    80005908:	c7d9                	beqz	a5,80005996 <virtio_disk_init+0x124>
  if(max < NUM)
    8000590a:	471d                	li	a4,7
    8000590c:	08f77d63          	bgeu	a4,a5,800059a6 <virtio_disk_init+0x134>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    80005910:	100014b7          	lui	s1,0x10001
    80005914:	47a1                	li	a5,8
    80005916:	dc9c                	sw	a5,56(s1)
  memset(disk.pages, 0, sizeof(disk.pages));
    80005918:	6609                	lui	a2,0x2
    8000591a:	4581                	li	a1,0
    8000591c:	00015517          	auipc	a0,0x15
    80005920:	6e450513          	addi	a0,a0,1764 # 8001b000 <disk>
    80005924:	ffffb097          	auipc	ra,0xffffb
    80005928:	854080e7          	jalr	-1964(ra) # 80000178 <memset>
  *R(VIRTIO_MMIO_QUEUE_PFN) = ((uint64)disk.pages) >> PGSHIFT;
    8000592c:	00015717          	auipc	a4,0x15
    80005930:	6d470713          	addi	a4,a4,1748 # 8001b000 <disk>
    80005934:	00c75793          	srli	a5,a4,0xc
    80005938:	2781                	sext.w	a5,a5
    8000593a:	c0bc                	sw	a5,64(s1)
  disk.desc = (struct virtq_desc *) disk.pages;
    8000593c:	00017797          	auipc	a5,0x17
    80005940:	6c478793          	addi	a5,a5,1732 # 8001d000 <disk+0x2000>
    80005944:	e398                	sd	a4,0(a5)
  disk.avail = (struct virtq_avail *)(disk.pages + NUM*sizeof(struct virtq_desc));
    80005946:	00015717          	auipc	a4,0x15
    8000594a:	73a70713          	addi	a4,a4,1850 # 8001b080 <disk+0x80>
    8000594e:	e798                	sd	a4,8(a5)
  disk.used = (struct virtq_used *) (disk.pages + PGSIZE);
    80005950:	00016717          	auipc	a4,0x16
    80005954:	6b070713          	addi	a4,a4,1712 # 8001c000 <disk+0x1000>
    80005958:	eb98                	sd	a4,16(a5)
    disk.free[i] = 1;
    8000595a:	4705                	li	a4,1
    8000595c:	00e78c23          	sb	a4,24(a5)
    80005960:	00e78ca3          	sb	a4,25(a5)
    80005964:	00e78d23          	sb	a4,26(a5)
    80005968:	00e78da3          	sb	a4,27(a5)
    8000596c:	00e78e23          	sb	a4,28(a5)
    80005970:	00e78ea3          	sb	a4,29(a5)
    80005974:	00e78f23          	sb	a4,30(a5)
    80005978:	00e78fa3          	sb	a4,31(a5)
}
    8000597c:	60e2                	ld	ra,24(sp)
    8000597e:	6442                	ld	s0,16(sp)
    80005980:	64a2                	ld	s1,8(sp)
    80005982:	6105                	addi	sp,sp,32
    80005984:	8082                	ret
    panic("could not find virtio disk");
    80005986:	00003517          	auipc	a0,0x3
    8000598a:	f0a50513          	addi	a0,a0,-246 # 80008890 <syscalls+0x440>
    8000598e:	00001097          	auipc	ra,0x1
    80005992:	ab2080e7          	jalr	-1358(ra) # 80006440 <panic>
    panic("virtio disk has no queue 0");
    80005996:	00003517          	auipc	a0,0x3
    8000599a:	f1a50513          	addi	a0,a0,-230 # 800088b0 <syscalls+0x460>
    8000599e:	00001097          	auipc	ra,0x1
    800059a2:	aa2080e7          	jalr	-1374(ra) # 80006440 <panic>
    panic("virtio disk max queue too short");
    800059a6:	00003517          	auipc	a0,0x3
    800059aa:	f2a50513          	addi	a0,a0,-214 # 800088d0 <syscalls+0x480>
    800059ae:	00001097          	auipc	ra,0x1
    800059b2:	a92080e7          	jalr	-1390(ra) # 80006440 <panic>

00000000800059b6 <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    800059b6:	7159                	addi	sp,sp,-112
    800059b8:	f486                	sd	ra,104(sp)
    800059ba:	f0a2                	sd	s0,96(sp)
    800059bc:	eca6                	sd	s1,88(sp)
    800059be:	e8ca                	sd	s2,80(sp)
    800059c0:	e4ce                	sd	s3,72(sp)
    800059c2:	e0d2                	sd	s4,64(sp)
    800059c4:	fc56                	sd	s5,56(sp)
    800059c6:	f85a                	sd	s6,48(sp)
    800059c8:	f45e                	sd	s7,40(sp)
    800059ca:	f062                	sd	s8,32(sp)
    800059cc:	ec66                	sd	s9,24(sp)
    800059ce:	e86a                	sd	s10,16(sp)
    800059d0:	1880                	addi	s0,sp,112
    800059d2:	892a                	mv	s2,a0
    800059d4:	8d2e                	mv	s10,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    800059d6:	00c52c83          	lw	s9,12(a0)
    800059da:	001c9c9b          	slliw	s9,s9,0x1
    800059de:	1c82                	slli	s9,s9,0x20
    800059e0:	020cdc93          	srli	s9,s9,0x20

  acquire(&disk.vdisk_lock);
    800059e4:	00017517          	auipc	a0,0x17
    800059e8:	74450513          	addi	a0,a0,1860 # 8001d128 <disk+0x2128>
    800059ec:	00001097          	auipc	ra,0x1
    800059f0:	f9e080e7          	jalr	-98(ra) # 8000698a <acquire>
  for(int i = 0; i < 3; i++){
    800059f4:	4981                	li	s3,0
  for(int i = 0; i < NUM; i++){
    800059f6:	4c21                	li	s8,8
      disk.free[i] = 0;
    800059f8:	00015b97          	auipc	s7,0x15
    800059fc:	608b8b93          	addi	s7,s7,1544 # 8001b000 <disk>
    80005a00:	6b09                	lui	s6,0x2
  for(int i = 0; i < 3; i++){
    80005a02:	4a8d                	li	s5,3
  for(int i = 0; i < NUM; i++){
    80005a04:	8a4e                	mv	s4,s3
    80005a06:	a051                	j	80005a8a <virtio_disk_rw+0xd4>
      disk.free[i] = 0;
    80005a08:	00fb86b3          	add	a3,s7,a5
    80005a0c:	96da                	add	a3,a3,s6
    80005a0e:	00068c23          	sb	zero,24(a3)
    idx[i] = alloc_desc();
    80005a12:	c21c                	sw	a5,0(a2)
    if(idx[i] < 0){
    80005a14:	0207c563          	bltz	a5,80005a3e <virtio_disk_rw+0x88>
  for(int i = 0; i < 3; i++){
    80005a18:	2485                	addiw	s1,s1,1
    80005a1a:	0711                	addi	a4,a4,4
    80005a1c:	25548063          	beq	s1,s5,80005c5c <virtio_disk_rw+0x2a6>
    idx[i] = alloc_desc();
    80005a20:	863a                	mv	a2,a4
  for(int i = 0; i < NUM; i++){
    80005a22:	00017697          	auipc	a3,0x17
    80005a26:	5f668693          	addi	a3,a3,1526 # 8001d018 <disk+0x2018>
    80005a2a:	87d2                	mv	a5,s4
    if(disk.free[i]){
    80005a2c:	0006c583          	lbu	a1,0(a3)
    80005a30:	fde1                	bnez	a1,80005a08 <virtio_disk_rw+0x52>
  for(int i = 0; i < NUM; i++){
    80005a32:	2785                	addiw	a5,a5,1
    80005a34:	0685                	addi	a3,a3,1
    80005a36:	ff879be3          	bne	a5,s8,80005a2c <virtio_disk_rw+0x76>
    idx[i] = alloc_desc();
    80005a3a:	57fd                	li	a5,-1
    80005a3c:	c21c                	sw	a5,0(a2)
      for(int j = 0; j < i; j++)
    80005a3e:	02905a63          	blez	s1,80005a72 <virtio_disk_rw+0xbc>
        free_desc(idx[j]);
    80005a42:	f9042503          	lw	a0,-112(s0)
    80005a46:	00000097          	auipc	ra,0x0
    80005a4a:	d90080e7          	jalr	-624(ra) # 800057d6 <free_desc>
      for(int j = 0; j < i; j++)
    80005a4e:	4785                	li	a5,1
    80005a50:	0297d163          	bge	a5,s1,80005a72 <virtio_disk_rw+0xbc>
        free_desc(idx[j]);
    80005a54:	f9442503          	lw	a0,-108(s0)
    80005a58:	00000097          	auipc	ra,0x0
    80005a5c:	d7e080e7          	jalr	-642(ra) # 800057d6 <free_desc>
      for(int j = 0; j < i; j++)
    80005a60:	4789                	li	a5,2
    80005a62:	0097d863          	bge	a5,s1,80005a72 <virtio_disk_rw+0xbc>
        free_desc(idx[j]);
    80005a66:	f9842503          	lw	a0,-104(s0)
    80005a6a:	00000097          	auipc	ra,0x0
    80005a6e:	d6c080e7          	jalr	-660(ra) # 800057d6 <free_desc>
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    80005a72:	00017597          	auipc	a1,0x17
    80005a76:	6b658593          	addi	a1,a1,1718 # 8001d128 <disk+0x2128>
    80005a7a:	00017517          	auipc	a0,0x17
    80005a7e:	59e50513          	addi	a0,a0,1438 # 8001d018 <disk+0x2018>
    80005a82:	ffffc097          	auipc	ra,0xffffc
    80005a86:	f78080e7          	jalr	-136(ra) # 800019fa <sleep>
  for(int i = 0; i < 3; i++){
    80005a8a:	f9040713          	addi	a4,s0,-112
    80005a8e:	84ce                	mv	s1,s3
    80005a90:	bf41                	j	80005a20 <virtio_disk_rw+0x6a>
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];

  if(write)
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
    80005a92:	20058713          	addi	a4,a1,512
    80005a96:	00471693          	slli	a3,a4,0x4
    80005a9a:	00015717          	auipc	a4,0x15
    80005a9e:	56670713          	addi	a4,a4,1382 # 8001b000 <disk>
    80005aa2:	9736                	add	a4,a4,a3
    80005aa4:	4685                	li	a3,1
    80005aa6:	0ad72423          	sw	a3,168(a4)
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
  buf0->reserved = 0;
    80005aaa:	20058713          	addi	a4,a1,512
    80005aae:	00471693          	slli	a3,a4,0x4
    80005ab2:	00015717          	auipc	a4,0x15
    80005ab6:	54e70713          	addi	a4,a4,1358 # 8001b000 <disk>
    80005aba:	9736                	add	a4,a4,a3
    80005abc:	0a072623          	sw	zero,172(a4)
  buf0->sector = sector;
    80005ac0:	0b973823          	sd	s9,176(a4)

  disk.desc[idx[0]].addr = (uint64) buf0;
    80005ac4:	7679                	lui	a2,0xffffe
    80005ac6:	963e                	add	a2,a2,a5
    80005ac8:	00017697          	auipc	a3,0x17
    80005acc:	53868693          	addi	a3,a3,1336 # 8001d000 <disk+0x2000>
    80005ad0:	6298                	ld	a4,0(a3)
    80005ad2:	9732                	add	a4,a4,a2
    80005ad4:	e308                	sd	a0,0(a4)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    80005ad6:	6298                	ld	a4,0(a3)
    80005ad8:	9732                	add	a4,a4,a2
    80005ada:	4541                	li	a0,16
    80005adc:	c708                	sw	a0,8(a4)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    80005ade:	6298                	ld	a4,0(a3)
    80005ae0:	9732                	add	a4,a4,a2
    80005ae2:	4505                	li	a0,1
    80005ae4:	00a71623          	sh	a0,12(a4)
  disk.desc[idx[0]].next = idx[1];
    80005ae8:	f9442703          	lw	a4,-108(s0)
    80005aec:	6288                	ld	a0,0(a3)
    80005aee:	962a                	add	a2,a2,a0
    80005af0:	00e61723          	sh	a4,14(a2) # ffffffffffffe00e <end+0xffffffff7ffd7dce>

  disk.desc[idx[1]].addr = (uint64) b->data;
    80005af4:	0712                	slli	a4,a4,0x4
    80005af6:	6290                	ld	a2,0(a3)
    80005af8:	963a                	add	a2,a2,a4
    80005afa:	05890513          	addi	a0,s2,88
    80005afe:	e208                	sd	a0,0(a2)
  disk.desc[idx[1]].len = BSIZE;
    80005b00:	6294                	ld	a3,0(a3)
    80005b02:	96ba                	add	a3,a3,a4
    80005b04:	40000613          	li	a2,1024
    80005b08:	c690                	sw	a2,8(a3)
  if(write)
    80005b0a:	140d0063          	beqz	s10,80005c4a <virtio_disk_rw+0x294>
    disk.desc[idx[1]].flags = 0; // device reads b->data
    80005b0e:	00017697          	auipc	a3,0x17
    80005b12:	4f26b683          	ld	a3,1266(a3) # 8001d000 <disk+0x2000>
    80005b16:	96ba                	add	a3,a3,a4
    80005b18:	00069623          	sh	zero,12(a3)
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    80005b1c:	00015817          	auipc	a6,0x15
    80005b20:	4e480813          	addi	a6,a6,1252 # 8001b000 <disk>
    80005b24:	00017517          	auipc	a0,0x17
    80005b28:	4dc50513          	addi	a0,a0,1244 # 8001d000 <disk+0x2000>
    80005b2c:	6114                	ld	a3,0(a0)
    80005b2e:	96ba                	add	a3,a3,a4
    80005b30:	00c6d603          	lhu	a2,12(a3)
    80005b34:	00166613          	ori	a2,a2,1
    80005b38:	00c69623          	sh	a2,12(a3)
  disk.desc[idx[1]].next = idx[2];
    80005b3c:	f9842683          	lw	a3,-104(s0)
    80005b40:	6110                	ld	a2,0(a0)
    80005b42:	9732                	add	a4,a4,a2
    80005b44:	00d71723          	sh	a3,14(a4)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    80005b48:	20058613          	addi	a2,a1,512
    80005b4c:	0612                	slli	a2,a2,0x4
    80005b4e:	9642                	add	a2,a2,a6
    80005b50:	577d                	li	a4,-1
    80005b52:	02e60823          	sb	a4,48(a2)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    80005b56:	00469713          	slli	a4,a3,0x4
    80005b5a:	6114                	ld	a3,0(a0)
    80005b5c:	96ba                	add	a3,a3,a4
    80005b5e:	03078793          	addi	a5,a5,48
    80005b62:	97c2                	add	a5,a5,a6
    80005b64:	e29c                	sd	a5,0(a3)
  disk.desc[idx[2]].len = 1;
    80005b66:	611c                	ld	a5,0(a0)
    80005b68:	97ba                	add	a5,a5,a4
    80005b6a:	4685                	li	a3,1
    80005b6c:	c794                	sw	a3,8(a5)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    80005b6e:	611c                	ld	a5,0(a0)
    80005b70:	97ba                	add	a5,a5,a4
    80005b72:	4809                	li	a6,2
    80005b74:	01079623          	sh	a6,12(a5)
  disk.desc[idx[2]].next = 0;
    80005b78:	611c                	ld	a5,0(a0)
    80005b7a:	973e                	add	a4,a4,a5
    80005b7c:	00071723          	sh	zero,14(a4)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    80005b80:	00d92223          	sw	a3,4(s2)
  disk.info[idx[0]].b = b;
    80005b84:	03263423          	sd	s2,40(a2)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    80005b88:	6518                	ld	a4,8(a0)
    80005b8a:	00275783          	lhu	a5,2(a4)
    80005b8e:	8b9d                	andi	a5,a5,7
    80005b90:	0786                	slli	a5,a5,0x1
    80005b92:	97ba                	add	a5,a5,a4
    80005b94:	00b79223          	sh	a1,4(a5)

  __sync_synchronize();
    80005b98:	0ff0000f          	fence

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    80005b9c:	6518                	ld	a4,8(a0)
    80005b9e:	00275783          	lhu	a5,2(a4)
    80005ba2:	2785                	addiw	a5,a5,1
    80005ba4:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    80005ba8:	0ff0000f          	fence

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    80005bac:	100017b7          	lui	a5,0x10001
    80005bb0:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    80005bb4:	00492703          	lw	a4,4(s2)
    80005bb8:	4785                	li	a5,1
    80005bba:	02f71163          	bne	a4,a5,80005bdc <virtio_disk_rw+0x226>
    sleep(b, &disk.vdisk_lock);
    80005bbe:	00017997          	auipc	s3,0x17
    80005bc2:	56a98993          	addi	s3,s3,1386 # 8001d128 <disk+0x2128>
  while(b->disk == 1) {
    80005bc6:	4485                	li	s1,1
    sleep(b, &disk.vdisk_lock);
    80005bc8:	85ce                	mv	a1,s3
    80005bca:	854a                	mv	a0,s2
    80005bcc:	ffffc097          	auipc	ra,0xffffc
    80005bd0:	e2e080e7          	jalr	-466(ra) # 800019fa <sleep>
  while(b->disk == 1) {
    80005bd4:	00492783          	lw	a5,4(s2)
    80005bd8:	fe9788e3          	beq	a5,s1,80005bc8 <virtio_disk_rw+0x212>
  }

  disk.info[idx[0]].b = 0;
    80005bdc:	f9042903          	lw	s2,-112(s0)
    80005be0:	20090793          	addi	a5,s2,512
    80005be4:	00479713          	slli	a4,a5,0x4
    80005be8:	00015797          	auipc	a5,0x15
    80005bec:	41878793          	addi	a5,a5,1048 # 8001b000 <disk>
    80005bf0:	97ba                	add	a5,a5,a4
    80005bf2:	0207b423          	sd	zero,40(a5)
    int flag = disk.desc[i].flags;
    80005bf6:	00017997          	auipc	s3,0x17
    80005bfa:	40a98993          	addi	s3,s3,1034 # 8001d000 <disk+0x2000>
    80005bfe:	00491713          	slli	a4,s2,0x4
    80005c02:	0009b783          	ld	a5,0(s3)
    80005c06:	97ba                	add	a5,a5,a4
    80005c08:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    80005c0c:	854a                	mv	a0,s2
    80005c0e:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    80005c12:	00000097          	auipc	ra,0x0
    80005c16:	bc4080e7          	jalr	-1084(ra) # 800057d6 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    80005c1a:	8885                	andi	s1,s1,1
    80005c1c:	f0ed                	bnez	s1,80005bfe <virtio_disk_rw+0x248>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    80005c1e:	00017517          	auipc	a0,0x17
    80005c22:	50a50513          	addi	a0,a0,1290 # 8001d128 <disk+0x2128>
    80005c26:	00001097          	auipc	ra,0x1
    80005c2a:	e18080e7          	jalr	-488(ra) # 80006a3e <release>
}
    80005c2e:	70a6                	ld	ra,104(sp)
    80005c30:	7406                	ld	s0,96(sp)
    80005c32:	64e6                	ld	s1,88(sp)
    80005c34:	6946                	ld	s2,80(sp)
    80005c36:	69a6                	ld	s3,72(sp)
    80005c38:	6a06                	ld	s4,64(sp)
    80005c3a:	7ae2                	ld	s5,56(sp)
    80005c3c:	7b42                	ld	s6,48(sp)
    80005c3e:	7ba2                	ld	s7,40(sp)
    80005c40:	7c02                	ld	s8,32(sp)
    80005c42:	6ce2                	ld	s9,24(sp)
    80005c44:	6d42                	ld	s10,16(sp)
    80005c46:	6165                	addi	sp,sp,112
    80005c48:	8082                	ret
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    80005c4a:	00017697          	auipc	a3,0x17
    80005c4e:	3b66b683          	ld	a3,950(a3) # 8001d000 <disk+0x2000>
    80005c52:	96ba                	add	a3,a3,a4
    80005c54:	4609                	li	a2,2
    80005c56:	00c69623          	sh	a2,12(a3)
    80005c5a:	b5c9                	j	80005b1c <virtio_disk_rw+0x166>
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80005c5c:	f9042583          	lw	a1,-112(s0)
    80005c60:	20058793          	addi	a5,a1,512
    80005c64:	0792                	slli	a5,a5,0x4
    80005c66:	00015517          	auipc	a0,0x15
    80005c6a:	44250513          	addi	a0,a0,1090 # 8001b0a8 <disk+0xa8>
    80005c6e:	953e                	add	a0,a0,a5
  if(write)
    80005c70:	e20d11e3          	bnez	s10,80005a92 <virtio_disk_rw+0xdc>
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
    80005c74:	20058713          	addi	a4,a1,512
    80005c78:	00471693          	slli	a3,a4,0x4
    80005c7c:	00015717          	auipc	a4,0x15
    80005c80:	38470713          	addi	a4,a4,900 # 8001b000 <disk>
    80005c84:	9736                	add	a4,a4,a3
    80005c86:	0a072423          	sw	zero,168(a4)
    80005c8a:	b505                	j	80005aaa <virtio_disk_rw+0xf4>

0000000080005c8c <virtio_disk_intr>:

void
virtio_disk_intr()
{
    80005c8c:	1101                	addi	sp,sp,-32
    80005c8e:	ec06                	sd	ra,24(sp)
    80005c90:	e822                	sd	s0,16(sp)
    80005c92:	e426                	sd	s1,8(sp)
    80005c94:	e04a                	sd	s2,0(sp)
    80005c96:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    80005c98:	00017517          	auipc	a0,0x17
    80005c9c:	49050513          	addi	a0,a0,1168 # 8001d128 <disk+0x2128>
    80005ca0:	00001097          	auipc	ra,0x1
    80005ca4:	cea080e7          	jalr	-790(ra) # 8000698a <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    80005ca8:	10001737          	lui	a4,0x10001
    80005cac:	533c                	lw	a5,96(a4)
    80005cae:	8b8d                	andi	a5,a5,3
    80005cb0:	d37c                	sw	a5,100(a4)

  __sync_synchronize();
    80005cb2:	0ff0000f          	fence

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    80005cb6:	00017797          	auipc	a5,0x17
    80005cba:	34a78793          	addi	a5,a5,842 # 8001d000 <disk+0x2000>
    80005cbe:	6b94                	ld	a3,16(a5)
    80005cc0:	0207d703          	lhu	a4,32(a5)
    80005cc4:	0026d783          	lhu	a5,2(a3)
    80005cc8:	06f70163          	beq	a4,a5,80005d2a <virtio_disk_intr+0x9e>
    __sync_synchronize();
    int id = disk.used->ring[disk.used_idx % NUM].id;
    80005ccc:	00015917          	auipc	s2,0x15
    80005cd0:	33490913          	addi	s2,s2,820 # 8001b000 <disk>
    80005cd4:	00017497          	auipc	s1,0x17
    80005cd8:	32c48493          	addi	s1,s1,812 # 8001d000 <disk+0x2000>
    __sync_synchronize();
    80005cdc:	0ff0000f          	fence
    int id = disk.used->ring[disk.used_idx % NUM].id;
    80005ce0:	6898                	ld	a4,16(s1)
    80005ce2:	0204d783          	lhu	a5,32(s1)
    80005ce6:	8b9d                	andi	a5,a5,7
    80005ce8:	078e                	slli	a5,a5,0x3
    80005cea:	97ba                	add	a5,a5,a4
    80005cec:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    80005cee:	20078713          	addi	a4,a5,512
    80005cf2:	0712                	slli	a4,a4,0x4
    80005cf4:	974a                	add	a4,a4,s2
    80005cf6:	03074703          	lbu	a4,48(a4) # 10001030 <_entry-0x6fffefd0>
    80005cfa:	e731                	bnez	a4,80005d46 <virtio_disk_intr+0xba>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    80005cfc:	20078793          	addi	a5,a5,512
    80005d00:	0792                	slli	a5,a5,0x4
    80005d02:	97ca                	add	a5,a5,s2
    80005d04:	7788                	ld	a0,40(a5)
    b->disk = 0;   // disk is done with buf
    80005d06:	00052223          	sw	zero,4(a0)
    wakeup(b);
    80005d0a:	ffffc097          	auipc	ra,0xffffc
    80005d0e:	e7c080e7          	jalr	-388(ra) # 80001b86 <wakeup>

    disk.used_idx += 1;
    80005d12:	0204d783          	lhu	a5,32(s1)
    80005d16:	2785                	addiw	a5,a5,1
    80005d18:	17c2                	slli	a5,a5,0x30
    80005d1a:	93c1                	srli	a5,a5,0x30
    80005d1c:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    80005d20:	6898                	ld	a4,16(s1)
    80005d22:	00275703          	lhu	a4,2(a4)
    80005d26:	faf71be3          	bne	a4,a5,80005cdc <virtio_disk_intr+0x50>
  }

  release(&disk.vdisk_lock);
    80005d2a:	00017517          	auipc	a0,0x17
    80005d2e:	3fe50513          	addi	a0,a0,1022 # 8001d128 <disk+0x2128>
    80005d32:	00001097          	auipc	ra,0x1
    80005d36:	d0c080e7          	jalr	-756(ra) # 80006a3e <release>
}
    80005d3a:	60e2                	ld	ra,24(sp)
    80005d3c:	6442                	ld	s0,16(sp)
    80005d3e:	64a2                	ld	s1,8(sp)
    80005d40:	6902                	ld	s2,0(sp)
    80005d42:	6105                	addi	sp,sp,32
    80005d44:	8082                	ret
      panic("virtio_disk_intr status");
    80005d46:	00003517          	auipc	a0,0x3
    80005d4a:	baa50513          	addi	a0,a0,-1110 # 800088f0 <syscalls+0x4a0>
    80005d4e:	00000097          	auipc	ra,0x0
    80005d52:	6f2080e7          	jalr	1778(ra) # 80006440 <panic>

0000000080005d56 <swap_page_from_pte>:
/* NTU OS 2024 */
/* Allocate eight consecutive disk blocks. */
/* Save the content of the physical page in the pte */
/* to the disk blocks and save the block-id into the */
/* pte. */
char *swap_page_from_pte(pte_t *pte) {
    80005d56:	7179                	addi	sp,sp,-48
    80005d58:	f406                	sd	ra,40(sp)
    80005d5a:	f022                	sd	s0,32(sp)
    80005d5c:	ec26                	sd	s1,24(sp)
    80005d5e:	e84a                	sd	s2,16(sp)
    80005d60:	e44e                	sd	s3,8(sp)
    80005d62:	1800                	addi	s0,sp,48
    80005d64:	89aa                	mv	s3,a0
  char *pa = (char*) PTE2PA(*pte);
    80005d66:	00053903          	ld	s2,0(a0)
    80005d6a:	00a95913          	srli	s2,s2,0xa
    80005d6e:	0932                	slli	s2,s2,0xc
  uint dp = balloc_page(ROOTDEV); // 叫disk allocate一個空間給我
    80005d70:	4505                	li	a0,1
    80005d72:	ffffe097          	auipc	ra,0xffffe
    80005d76:	ab6080e7          	jalr	-1354(ra) # 80003828 <balloc_page>
    80005d7a:	0005049b          	sext.w	s1,a0
  write_page_to_disk(ROOTDEV, pa, dp); // write this page to disk
    80005d7e:	8626                	mv	a2,s1
    80005d80:	85ca                	mv	a1,s2
    80005d82:	4505                	li	a0,1
    80005d84:	ffffd097          	auipc	ra,0xffffd
    80005d88:	c66080e7          	jalr	-922(ra) # 800029ea <write_page_to_disk>
  *pte = (BLOCKNO2PTE(dp) | PTE_FLAGS(*pte) | PTE_S) & ~PTE_V; // 將pte的pointer指到disk
    80005d8c:	0009b783          	ld	a5,0(s3)
    80005d90:	00a4949b          	slliw	s1,s1,0xa
    80005d94:	1482                	slli	s1,s1,0x20
    80005d96:	9081                	srli	s1,s1,0x20
    80005d98:	1fe7f793          	andi	a5,a5,510
    80005d9c:	8cdd                	or	s1,s1,a5
    80005d9e:	2004e493          	ori	s1,s1,512
    80005da2:	0099b023          	sd	s1,0(s3)
  return pa;
}
    80005da6:	854a                	mv	a0,s2
    80005da8:	70a2                	ld	ra,40(sp)
    80005daa:	7402                	ld	s0,32(sp)
    80005dac:	64e2                	ld	s1,24(sp)
    80005dae:	6942                	ld	s2,16(sp)
    80005db0:	69a2                	ld	s3,8(sp)
    80005db2:	6145                	addi	sp,sp,48
    80005db4:	8082                	ret

0000000080005db6 <handle_pgfault>:

/* NTU OS 2024 */
/* Page fault handler */
int handle_pgfault() { // 僅有一個va需要處理
    80005db6:	7179                	addi	sp,sp,-48
    80005db8:	f406                	sd	ra,40(sp)
    80005dba:	f022                	sd	s0,32(sp)
    80005dbc:	ec26                	sd	s1,24(sp)
    80005dbe:	e84a                	sd	s2,16(sp)
    80005dc0:	e44e                	sd	s3,8(sp)
    80005dc2:	1800                	addi	s0,sp,48
  /* Find the address that caused the fault */
  printf("27\n");
    80005dc4:	00003517          	auipc	a0,0x3
    80005dc8:	b4450513          	addi	a0,a0,-1212 # 80008908 <syscalls+0x4b8>
    80005dcc:	00000097          	auipc	ra,0x0
    80005dd0:	6be080e7          	jalr	1726(ra) # 8000648a <printf>
    80005dd4:	143024f3          	csrr	s1,stval
  uint64 va = r_stval();
  va = PGROUNDDOWN(va);
    80005dd8:	77fd                	lui	a5,0xfffff
    80005dda:	8cfd                	and	s1,s1,a5
  // madvise(PGROUNDDOWN(va), PGSIZE, MADV_WILLNEED);
  struct proc *p = myproc();
    80005ddc:	ffffb097          	auipc	ra,0xffffb
    80005de0:	562080e7          	jalr	1378(ra) # 8000133e <myproc>
  pagetable_t pgtbl = p->pagetable;
    80005de4:	05053903          	ld	s2,80(a0)
  if (va > p->sz || (va + PGSIZE) > p->sz) return -1;
    80005de8:	6538                	ld	a4,72(a0)
    80005dea:	0a976263          	bltu	a4,s1,80005e8e <handle_pgfault+0xd8>
    80005dee:	6785                	lui	a5,0x1
    80005df0:	97a6                	add	a5,a5,s1
    80005df2:	0af76063          	bltu	a4,a5,80005e92 <handle_pgfault+0xdc>
  
  begin_op();
    80005df6:	ffffe097          	auipc	ra,0xffffe
    80005dfa:	da6080e7          	jalr	-602(ra) # 80003b9c <begin_op>
  pte_t *pte = walk(pgtbl, va, 0);
    80005dfe:	4601                	li	a2,0
    80005e00:	85a6                	mv	a1,s1
    80005e02:	854a                	mv	a0,s2
    80005e04:	ffffa097          	auipc	ra,0xffffa
    80005e08:	65c080e7          	jalr	1628(ra) # 80000460 <walk>
    80005e0c:	892a                	mv	s2,a0
  if (pte == 0 || (*pte & PTE_S) == 0) {
    80005e0e:	c525                	beqz	a0,80005e76 <handle_pgfault+0xc0>
    80005e10:	611c                	ld	a5,0(a0)
    80005e12:	2007f793          	andi	a5,a5,512
    80005e16:	c3a5                	beqz	a5,80005e76 <handle_pgfault+0xc0>
    end_op();
    return -1;
  }
  
  char *pa = (char *)kalloc(); // 位在physical memory的free page
    80005e18:	ffffa097          	auipc	ra,0xffffa
    80005e1c:	300080e7          	jalr	768(ra) # 80000118 <kalloc>
    80005e20:	84aa                	mv	s1,a0
  if (pa == 0) {
    80005e22:	c125                	beqz	a0,80005e82 <handle_pgfault+0xcc>
    end_op();
    return -1;
  }
  uint dp = PTE2BLOCKNO(*pte);
    80005e24:	00093983          	ld	s3,0(s2)
    80005e28:	00a9d993          	srli	s3,s3,0xa
    80005e2c:	2981                	sext.w	s3,s3
  read_page_from_disk(ROOTDEV, pa, dp); // 從disk搬回來
    80005e2e:	864e                	mv	a2,s3
    80005e30:	85aa                	mv	a1,a0
    80005e32:	4505                	li	a0,1
    80005e34:	ffffd097          	auipc	ra,0xffffd
    80005e38:	c1c080e7          	jalr	-996(ra) # 80002a50 <read_page_from_disk>
  *pte = (PA2PTE(pa) | PTE_FLAGS(*pte) | PTE_V) & ~PTE_S; // 將pte的pointer指到physical memory
    80005e3c:	80b1                	srli	s1,s1,0xc
    80005e3e:	04aa                	slli	s1,s1,0xa
    80005e40:	00093783          	ld	a5,0(s2)
    80005e44:	1fe7f793          	andi	a5,a5,510
    80005e48:	8cdd                	or	s1,s1,a5
    80005e4a:	0014e493          	ori	s1,s1,1
    80005e4e:	00993023          	sd	s1,0(s2)
  bfree_page(ROOTDEV, dp);
    80005e52:	85ce                	mv	a1,s3
    80005e54:	4505                	li	a0,1
    80005e56:	ffffe097          	auipc	ra,0xffffe
    80005e5a:	ac2080e7          	jalr	-1342(ra) # 80003918 <bfree_page>
  end_op();
    80005e5e:	ffffe097          	auipc	ra,0xffffe
    80005e62:	dbe080e7          	jalr	-578(ra) # 80003c1c <end_op>
  return 0;
    80005e66:	4501                	li	a0,0
}
    80005e68:	70a2                	ld	ra,40(sp)
    80005e6a:	7402                	ld	s0,32(sp)
    80005e6c:	64e2                	ld	s1,24(sp)
    80005e6e:	6942                	ld	s2,16(sp)
    80005e70:	69a2                	ld	s3,8(sp)
    80005e72:	6145                	addi	sp,sp,48
    80005e74:	8082                	ret
    end_op();
    80005e76:	ffffe097          	auipc	ra,0xffffe
    80005e7a:	da6080e7          	jalr	-602(ra) # 80003c1c <end_op>
    return -1;
    80005e7e:	557d                	li	a0,-1
    80005e80:	b7e5                	j	80005e68 <handle_pgfault+0xb2>
    end_op();
    80005e82:	ffffe097          	auipc	ra,0xffffe
    80005e86:	d9a080e7          	jalr	-614(ra) # 80003c1c <end_op>
    return -1;
    80005e8a:	557d                	li	a0,-1
    80005e8c:	bff1                	j	80005e68 <handle_pgfault+0xb2>
  if (va > p->sz || (va + PGSIZE) > p->sz) return -1;
    80005e8e:	557d                	li	a0,-1
    80005e90:	bfe1                	j	80005e68 <handle_pgfault+0xb2>
    80005e92:	557d                	li	a0,-1
    80005e94:	bfd1                	j	80005e68 <handle_pgfault+0xb2>

0000000080005e96 <sys_vmprint>:

/* NTU OS 2024 */
/* Entry of vmprint() syscall. */
uint64
sys_vmprint(void)
{
    80005e96:	1141                	addi	sp,sp,-16
    80005e98:	e406                	sd	ra,8(sp)
    80005e9a:	e022                	sd	s0,0(sp)
    80005e9c:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    80005e9e:	ffffb097          	auipc	ra,0xffffb
    80005ea2:	4a0080e7          	jalr	1184(ra) # 8000133e <myproc>
  vmprint(p->pagetable);
    80005ea6:	6928                	ld	a0,80(a0)
    80005ea8:	ffffb097          	auipc	ra,0xffffb
    80005eac:	2ee080e7          	jalr	750(ra) # 80001196 <vmprint>
  return 0;
}
    80005eb0:	4501                	li	a0,0
    80005eb2:	60a2                	ld	ra,8(sp)
    80005eb4:	6402                	ld	s0,0(sp)
    80005eb6:	0141                	addi	sp,sp,16
    80005eb8:	8082                	ret

0000000080005eba <sys_madvise>:

/* NTU OS 2024 */
/* Entry of madvise() syscall. */
uint64
sys_madvise(void)
{
    80005eba:	1101                	addi	sp,sp,-32
    80005ebc:	ec06                	sd	ra,24(sp)
    80005ebe:	e822                	sd	s0,16(sp)
    80005ec0:	1000                	addi	s0,sp,32

  uint64 addr;
  int length;
  int advise;

  if (argaddr(0, &addr) < 0) return -1;
    80005ec2:	fe840593          	addi	a1,s0,-24
    80005ec6:	4501                	li	a0,0
    80005ec8:	ffffc097          	auipc	ra,0xffffc
    80005ecc:	562080e7          	jalr	1378(ra) # 8000242a <argaddr>
    80005ed0:	57fd                	li	a5,-1
    80005ed2:	04054163          	bltz	a0,80005f14 <sys_madvise+0x5a>
  if (argint(1, &length) < 0) return -1;
    80005ed6:	fe440593          	addi	a1,s0,-28
    80005eda:	4505                	li	a0,1
    80005edc:	ffffc097          	auipc	ra,0xffffc
    80005ee0:	52c080e7          	jalr	1324(ra) # 80002408 <argint>
    80005ee4:	57fd                	li	a5,-1
    80005ee6:	02054763          	bltz	a0,80005f14 <sys_madvise+0x5a>
  if (argint(2, &advise) < 0) return -1;
    80005eea:	fe040593          	addi	a1,s0,-32
    80005eee:	4509                	li	a0,2
    80005ef0:	ffffc097          	auipc	ra,0xffffc
    80005ef4:	518080e7          	jalr	1304(ra) # 80002408 <argint>
    80005ef8:	57fd                	li	a5,-1
    80005efa:	00054d63          	bltz	a0,80005f14 <sys_madvise+0x5a>

  int ret = madvise(addr, length, advise);
    80005efe:	fe042603          	lw	a2,-32(s0)
    80005f02:	fe442583          	lw	a1,-28(s0)
    80005f06:	fe843503          	ld	a0,-24(s0)
    80005f0a:	ffffb097          	auipc	ra,0xffffb
    80005f0e:	eaa080e7          	jalr	-342(ra) # 80000db4 <madvise>
  return ret;
    80005f12:	87aa                	mv	a5,a0
}
    80005f14:	853e                	mv	a0,a5
    80005f16:	60e2                	ld	ra,24(sp)
    80005f18:	6442                	ld	s0,16(sp)
    80005f1a:	6105                	addi	sp,sp,32
    80005f1c:	8082                	ret

0000000080005f1e <timerinit>:
// which arrive at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    80005f1e:	1141                	addi	sp,sp,-16
    80005f20:	e422                	sd	s0,8(sp)
    80005f22:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80005f24:	f14027f3          	csrr	a5,mhartid
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    80005f28:	0007869b          	sext.w	a3,a5

  // ask the CLINT for a timer interrupt.
  int interval = 1000000; // cycles; about 1/10th second in qemu.
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    80005f2c:	0037979b          	slliw	a5,a5,0x3
    80005f30:	02004737          	lui	a4,0x2004
    80005f34:	97ba                	add	a5,a5,a4
    80005f36:	0200c737          	lui	a4,0x200c
    80005f3a:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80005f3e:	000f4637          	lui	a2,0xf4
    80005f42:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80005f46:	95b2                	add	a1,a1,a2
    80005f48:	e38c                	sd	a1,0(a5)

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
    80005f4a:	00269713          	slli	a4,a3,0x2
    80005f4e:	9736                	add	a4,a4,a3
    80005f50:	00371693          	slli	a3,a4,0x3
    80005f54:	00018717          	auipc	a4,0x18
    80005f58:	0ac70713          	addi	a4,a4,172 # 8001e000 <timer_scratch>
    80005f5c:	9736                	add	a4,a4,a3
  scratch[3] = CLINT_MTIMECMP(id);
    80005f5e:	ef1c                	sd	a5,24(a4)
  scratch[4] = interval;
    80005f60:	f310                	sd	a2,32(a4)
  asm volatile("csrw mscratch, %0" : : "r" (x));
    80005f62:	34071073          	csrw	mscratch,a4
  asm volatile("csrw mtvec, %0" : : "r" (x));
    80005f66:	fffff797          	auipc	a5,0xfffff
    80005f6a:	7aa78793          	addi	a5,a5,1962 # 80005710 <timervec>
    80005f6e:	30579073          	csrw	mtvec,a5
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80005f72:	300027f3          	csrr	a5,mstatus

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    80005f76:	0087e793          	ori	a5,a5,8
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80005f7a:	30079073          	csrw	mstatus,a5
  asm volatile("csrr %0, mie" : "=r" (x) );
    80005f7e:	304027f3          	csrr	a5,mie

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    80005f82:	0807e793          	ori	a5,a5,128
  asm volatile("csrw mie, %0" : : "r" (x));
    80005f86:	30479073          	csrw	mie,a5
}
    80005f8a:	6422                	ld	s0,8(sp)
    80005f8c:	0141                	addi	sp,sp,16
    80005f8e:	8082                	ret

0000000080005f90 <start>:
{
    80005f90:	1141                	addi	sp,sp,-16
    80005f92:	e406                	sd	ra,8(sp)
    80005f94:	e022                	sd	s0,0(sp)
    80005f96:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80005f98:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    80005f9c:	7779                	lui	a4,0xffffe
    80005f9e:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffd85bf>
    80005fa2:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    80005fa4:	6705                	lui	a4,0x1
    80005fa6:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80005faa:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80005fac:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    80005fb0:	ffffa797          	auipc	a5,0xffffa
    80005fb4:	37678793          	addi	a5,a5,886 # 80000326 <main>
    80005fb8:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    80005fbc:	4781                	li	a5,0
    80005fbe:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    80005fc2:	67c1                	lui	a5,0x10
    80005fc4:	17fd                	addi	a5,a5,-1
    80005fc6:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    80005fca:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    80005fce:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    80005fd2:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    80005fd6:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    80005fda:	57fd                	li	a5,-1
    80005fdc:	83a9                	srli	a5,a5,0xa
    80005fde:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    80005fe2:	47bd                	li	a5,15
    80005fe4:	3a079073          	csrw	pmpcfg0,a5
  timerinit();
    80005fe8:	00000097          	auipc	ra,0x0
    80005fec:	f36080e7          	jalr	-202(ra) # 80005f1e <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80005ff0:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    80005ff4:	2781                	sext.w	a5,a5
  asm volatile("mv tp, %0" : : "r" (x));
    80005ff6:	823e                	mv	tp,a5
  asm volatile("mret");
    80005ff8:	30200073          	mret
}
    80005ffc:	60a2                	ld	ra,8(sp)
    80005ffe:	6402                	ld	s0,0(sp)
    80006000:	0141                	addi	sp,sp,16
    80006002:	8082                	ret

0000000080006004 <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    80006004:	715d                	addi	sp,sp,-80
    80006006:	e486                	sd	ra,72(sp)
    80006008:	e0a2                	sd	s0,64(sp)
    8000600a:	fc26                	sd	s1,56(sp)
    8000600c:	f84a                	sd	s2,48(sp)
    8000600e:	f44e                	sd	s3,40(sp)
    80006010:	f052                	sd	s4,32(sp)
    80006012:	ec56                	sd	s5,24(sp)
    80006014:	0880                	addi	s0,sp,80
  int i;

  for(i = 0; i < n; i++){
    80006016:	04c05663          	blez	a2,80006062 <consolewrite+0x5e>
    8000601a:	8a2a                	mv	s4,a0
    8000601c:	84ae                	mv	s1,a1
    8000601e:	89b2                	mv	s3,a2
    80006020:	4901                	li	s2,0
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    80006022:	5afd                	li	s5,-1
    80006024:	4685                	li	a3,1
    80006026:	8626                	mv	a2,s1
    80006028:	85d2                	mv	a1,s4
    8000602a:	fbf40513          	addi	a0,s0,-65
    8000602e:	ffffc097          	auipc	ra,0xffffc
    80006032:	dc6080e7          	jalr	-570(ra) # 80001df4 <either_copyin>
    80006036:	01550c63          	beq	a0,s5,8000604e <consolewrite+0x4a>
      break;
    uartputc(c);
    8000603a:	fbf44503          	lbu	a0,-65(s0)
    8000603e:	00000097          	auipc	ra,0x0
    80006042:	78e080e7          	jalr	1934(ra) # 800067cc <uartputc>
  for(i = 0; i < n; i++){
    80006046:	2905                	addiw	s2,s2,1
    80006048:	0485                	addi	s1,s1,1
    8000604a:	fd299de3          	bne	s3,s2,80006024 <consolewrite+0x20>
  }

  return i;
}
    8000604e:	854a                	mv	a0,s2
    80006050:	60a6                	ld	ra,72(sp)
    80006052:	6406                	ld	s0,64(sp)
    80006054:	74e2                	ld	s1,56(sp)
    80006056:	7942                	ld	s2,48(sp)
    80006058:	79a2                	ld	s3,40(sp)
    8000605a:	7a02                	ld	s4,32(sp)
    8000605c:	6ae2                	ld	s5,24(sp)
    8000605e:	6161                	addi	sp,sp,80
    80006060:	8082                	ret
  for(i = 0; i < n; i++){
    80006062:	4901                	li	s2,0
    80006064:	b7ed                	j	8000604e <consolewrite+0x4a>

0000000080006066 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80006066:	7119                	addi	sp,sp,-128
    80006068:	fc86                	sd	ra,120(sp)
    8000606a:	f8a2                	sd	s0,112(sp)
    8000606c:	f4a6                	sd	s1,104(sp)
    8000606e:	f0ca                	sd	s2,96(sp)
    80006070:	ecce                	sd	s3,88(sp)
    80006072:	e8d2                	sd	s4,80(sp)
    80006074:	e4d6                	sd	s5,72(sp)
    80006076:	e0da                	sd	s6,64(sp)
    80006078:	fc5e                	sd	s7,56(sp)
    8000607a:	f862                	sd	s8,48(sp)
    8000607c:	f466                	sd	s9,40(sp)
    8000607e:	f06a                	sd	s10,32(sp)
    80006080:	ec6e                	sd	s11,24(sp)
    80006082:	0100                	addi	s0,sp,128
    80006084:	8b2a                	mv	s6,a0
    80006086:	8aae                	mv	s5,a1
    80006088:	8a32                	mv	s4,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    8000608a:	00060b9b          	sext.w	s7,a2
  acquire(&cons.lock);
    8000608e:	00020517          	auipc	a0,0x20
    80006092:	0b250513          	addi	a0,a0,178 # 80026140 <cons>
    80006096:	00001097          	auipc	ra,0x1
    8000609a:	8f4080e7          	jalr	-1804(ra) # 8000698a <acquire>
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    8000609e:	00020497          	auipc	s1,0x20
    800060a2:	0a248493          	addi	s1,s1,162 # 80026140 <cons>
      if(myproc()->killed){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    800060a6:	89a6                	mv	s3,s1
    800060a8:	00020917          	auipc	s2,0x20
    800060ac:	13090913          	addi	s2,s2,304 # 800261d8 <cons+0x98>
    }

    c = cons.buf[cons.r++ % INPUT_BUF];

    if(c == C('D')){  // end-of-file
    800060b0:	4c91                	li	s9,4
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    800060b2:	5d7d                	li	s10,-1
      break;

    dst++;
    --n;

    if(c == '\n'){
    800060b4:	4da9                	li	s11,10
  while(n > 0){
    800060b6:	07405863          	blez	s4,80006126 <consoleread+0xc0>
    while(cons.r == cons.w){
    800060ba:	0984a783          	lw	a5,152(s1)
    800060be:	09c4a703          	lw	a4,156(s1)
    800060c2:	02f71463          	bne	a4,a5,800060ea <consoleread+0x84>
      if(myproc()->killed){
    800060c6:	ffffb097          	auipc	ra,0xffffb
    800060ca:	278080e7          	jalr	632(ra) # 8000133e <myproc>
    800060ce:	551c                	lw	a5,40(a0)
    800060d0:	e7b5                	bnez	a5,8000613c <consoleread+0xd6>
      sleep(&cons.r, &cons.lock);
    800060d2:	85ce                	mv	a1,s3
    800060d4:	854a                	mv	a0,s2
    800060d6:	ffffc097          	auipc	ra,0xffffc
    800060da:	924080e7          	jalr	-1756(ra) # 800019fa <sleep>
    while(cons.r == cons.w){
    800060de:	0984a783          	lw	a5,152(s1)
    800060e2:	09c4a703          	lw	a4,156(s1)
    800060e6:	fef700e3          	beq	a4,a5,800060c6 <consoleread+0x60>
    c = cons.buf[cons.r++ % INPUT_BUF];
    800060ea:	0017871b          	addiw	a4,a5,1
    800060ee:	08e4ac23          	sw	a4,152(s1)
    800060f2:	07f7f713          	andi	a4,a5,127
    800060f6:	9726                	add	a4,a4,s1
    800060f8:	01874703          	lbu	a4,24(a4)
    800060fc:	00070c1b          	sext.w	s8,a4
    if(c == C('D')){  // end-of-file
    80006100:	079c0663          	beq	s8,s9,8000616c <consoleread+0x106>
    cbuf = c;
    80006104:	f8e407a3          	sb	a4,-113(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80006108:	4685                	li	a3,1
    8000610a:	f8f40613          	addi	a2,s0,-113
    8000610e:	85d6                	mv	a1,s5
    80006110:	855a                	mv	a0,s6
    80006112:	ffffc097          	auipc	ra,0xffffc
    80006116:	c8c080e7          	jalr	-884(ra) # 80001d9e <either_copyout>
    8000611a:	01a50663          	beq	a0,s10,80006126 <consoleread+0xc0>
    dst++;
    8000611e:	0a85                	addi	s5,s5,1
    --n;
    80006120:	3a7d                	addiw	s4,s4,-1
    if(c == '\n'){
    80006122:	f9bc1ae3          	bne	s8,s11,800060b6 <consoleread+0x50>
      // a whole line has arrived, return to
      // the user-level read().
      break;
    }
  }
  release(&cons.lock);
    80006126:	00020517          	auipc	a0,0x20
    8000612a:	01a50513          	addi	a0,a0,26 # 80026140 <cons>
    8000612e:	00001097          	auipc	ra,0x1
    80006132:	910080e7          	jalr	-1776(ra) # 80006a3e <release>

  return target - n;
    80006136:	414b853b          	subw	a0,s7,s4
    8000613a:	a811                	j	8000614e <consoleread+0xe8>
        release(&cons.lock);
    8000613c:	00020517          	auipc	a0,0x20
    80006140:	00450513          	addi	a0,a0,4 # 80026140 <cons>
    80006144:	00001097          	auipc	ra,0x1
    80006148:	8fa080e7          	jalr	-1798(ra) # 80006a3e <release>
        return -1;
    8000614c:	557d                	li	a0,-1
}
    8000614e:	70e6                	ld	ra,120(sp)
    80006150:	7446                	ld	s0,112(sp)
    80006152:	74a6                	ld	s1,104(sp)
    80006154:	7906                	ld	s2,96(sp)
    80006156:	69e6                	ld	s3,88(sp)
    80006158:	6a46                	ld	s4,80(sp)
    8000615a:	6aa6                	ld	s5,72(sp)
    8000615c:	6b06                	ld	s6,64(sp)
    8000615e:	7be2                	ld	s7,56(sp)
    80006160:	7c42                	ld	s8,48(sp)
    80006162:	7ca2                	ld	s9,40(sp)
    80006164:	7d02                	ld	s10,32(sp)
    80006166:	6de2                	ld	s11,24(sp)
    80006168:	6109                	addi	sp,sp,128
    8000616a:	8082                	ret
      if(n < target){
    8000616c:	000a071b          	sext.w	a4,s4
    80006170:	fb777be3          	bgeu	a4,s7,80006126 <consoleread+0xc0>
        cons.r--;
    80006174:	00020717          	auipc	a4,0x20
    80006178:	06f72223          	sw	a5,100(a4) # 800261d8 <cons+0x98>
    8000617c:	b76d                	j	80006126 <consoleread+0xc0>

000000008000617e <consputc>:
{
    8000617e:	1141                	addi	sp,sp,-16
    80006180:	e406                	sd	ra,8(sp)
    80006182:	e022                	sd	s0,0(sp)
    80006184:	0800                	addi	s0,sp,16
  if(c == BACKSPACE){
    80006186:	10000793          	li	a5,256
    8000618a:	00f50a63          	beq	a0,a5,8000619e <consputc+0x20>
    uartputc_sync(c);
    8000618e:	00000097          	auipc	ra,0x0
    80006192:	564080e7          	jalr	1380(ra) # 800066f2 <uartputc_sync>
}
    80006196:	60a2                	ld	ra,8(sp)
    80006198:	6402                	ld	s0,0(sp)
    8000619a:	0141                	addi	sp,sp,16
    8000619c:	8082                	ret
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    8000619e:	4521                	li	a0,8
    800061a0:	00000097          	auipc	ra,0x0
    800061a4:	552080e7          	jalr	1362(ra) # 800066f2 <uartputc_sync>
    800061a8:	02000513          	li	a0,32
    800061ac:	00000097          	auipc	ra,0x0
    800061b0:	546080e7          	jalr	1350(ra) # 800066f2 <uartputc_sync>
    800061b4:	4521                	li	a0,8
    800061b6:	00000097          	auipc	ra,0x0
    800061ba:	53c080e7          	jalr	1340(ra) # 800066f2 <uartputc_sync>
    800061be:	bfe1                	j	80006196 <consputc+0x18>

00000000800061c0 <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    800061c0:	1101                	addi	sp,sp,-32
    800061c2:	ec06                	sd	ra,24(sp)
    800061c4:	e822                	sd	s0,16(sp)
    800061c6:	e426                	sd	s1,8(sp)
    800061c8:	e04a                	sd	s2,0(sp)
    800061ca:	1000                	addi	s0,sp,32
    800061cc:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    800061ce:	00020517          	auipc	a0,0x20
    800061d2:	f7250513          	addi	a0,a0,-142 # 80026140 <cons>
    800061d6:	00000097          	auipc	ra,0x0
    800061da:	7b4080e7          	jalr	1972(ra) # 8000698a <acquire>

  switch(c){
    800061de:	47d5                	li	a5,21
    800061e0:	0af48663          	beq	s1,a5,8000628c <consoleintr+0xcc>
    800061e4:	0297ca63          	blt	a5,s1,80006218 <consoleintr+0x58>
    800061e8:	47a1                	li	a5,8
    800061ea:	0ef48763          	beq	s1,a5,800062d8 <consoleintr+0x118>
    800061ee:	47c1                	li	a5,16
    800061f0:	10f49a63          	bne	s1,a5,80006304 <consoleintr+0x144>
  case C('P'):  // Print process list.
    procdump();
    800061f4:	ffffc097          	auipc	ra,0xffffc
    800061f8:	c56080e7          	jalr	-938(ra) # 80001e4a <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    800061fc:	00020517          	auipc	a0,0x20
    80006200:	f4450513          	addi	a0,a0,-188 # 80026140 <cons>
    80006204:	00001097          	auipc	ra,0x1
    80006208:	83a080e7          	jalr	-1990(ra) # 80006a3e <release>
}
    8000620c:	60e2                	ld	ra,24(sp)
    8000620e:	6442                	ld	s0,16(sp)
    80006210:	64a2                	ld	s1,8(sp)
    80006212:	6902                	ld	s2,0(sp)
    80006214:	6105                	addi	sp,sp,32
    80006216:	8082                	ret
  switch(c){
    80006218:	07f00793          	li	a5,127
    8000621c:	0af48e63          	beq	s1,a5,800062d8 <consoleintr+0x118>
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    80006220:	00020717          	auipc	a4,0x20
    80006224:	f2070713          	addi	a4,a4,-224 # 80026140 <cons>
    80006228:	0a072783          	lw	a5,160(a4)
    8000622c:	09872703          	lw	a4,152(a4)
    80006230:	9f99                	subw	a5,a5,a4
    80006232:	07f00713          	li	a4,127
    80006236:	fcf763e3          	bltu	a4,a5,800061fc <consoleintr+0x3c>
      c = (c == '\r') ? '\n' : c;
    8000623a:	47b5                	li	a5,13
    8000623c:	0cf48763          	beq	s1,a5,8000630a <consoleintr+0x14a>
      consputc(c);
    80006240:	8526                	mv	a0,s1
    80006242:	00000097          	auipc	ra,0x0
    80006246:	f3c080e7          	jalr	-196(ra) # 8000617e <consputc>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    8000624a:	00020797          	auipc	a5,0x20
    8000624e:	ef678793          	addi	a5,a5,-266 # 80026140 <cons>
    80006252:	0a07a703          	lw	a4,160(a5)
    80006256:	0017069b          	addiw	a3,a4,1
    8000625a:	0006861b          	sext.w	a2,a3
    8000625e:	0ad7a023          	sw	a3,160(a5)
    80006262:	07f77713          	andi	a4,a4,127
    80006266:	97ba                	add	a5,a5,a4
    80006268:	00978c23          	sb	s1,24(a5)
      if(c == '\n' || c == C('D') || cons.e == cons.r+INPUT_BUF){
    8000626c:	47a9                	li	a5,10
    8000626e:	0cf48563          	beq	s1,a5,80006338 <consoleintr+0x178>
    80006272:	4791                	li	a5,4
    80006274:	0cf48263          	beq	s1,a5,80006338 <consoleintr+0x178>
    80006278:	00020797          	auipc	a5,0x20
    8000627c:	f607a783          	lw	a5,-160(a5) # 800261d8 <cons+0x98>
    80006280:	0807879b          	addiw	a5,a5,128
    80006284:	f6f61ce3          	bne	a2,a5,800061fc <consoleintr+0x3c>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80006288:	863e                	mv	a2,a5
    8000628a:	a07d                	j	80006338 <consoleintr+0x178>
    while(cons.e != cons.w &&
    8000628c:	00020717          	auipc	a4,0x20
    80006290:	eb470713          	addi	a4,a4,-332 # 80026140 <cons>
    80006294:	0a072783          	lw	a5,160(a4)
    80006298:	09c72703          	lw	a4,156(a4)
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    8000629c:	00020497          	auipc	s1,0x20
    800062a0:	ea448493          	addi	s1,s1,-348 # 80026140 <cons>
    while(cons.e != cons.w &&
    800062a4:	4929                	li	s2,10
    800062a6:	f4f70be3          	beq	a4,a5,800061fc <consoleintr+0x3c>
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    800062aa:	37fd                	addiw	a5,a5,-1
    800062ac:	07f7f713          	andi	a4,a5,127
    800062b0:	9726                	add	a4,a4,s1
    while(cons.e != cons.w &&
    800062b2:	01874703          	lbu	a4,24(a4)
    800062b6:	f52703e3          	beq	a4,s2,800061fc <consoleintr+0x3c>
      cons.e--;
    800062ba:	0af4a023          	sw	a5,160(s1)
      consputc(BACKSPACE);
    800062be:	10000513          	li	a0,256
    800062c2:	00000097          	auipc	ra,0x0
    800062c6:	ebc080e7          	jalr	-324(ra) # 8000617e <consputc>
    while(cons.e != cons.w &&
    800062ca:	0a04a783          	lw	a5,160(s1)
    800062ce:	09c4a703          	lw	a4,156(s1)
    800062d2:	fcf71ce3          	bne	a4,a5,800062aa <consoleintr+0xea>
    800062d6:	b71d                	j	800061fc <consoleintr+0x3c>
    if(cons.e != cons.w){
    800062d8:	00020717          	auipc	a4,0x20
    800062dc:	e6870713          	addi	a4,a4,-408 # 80026140 <cons>
    800062e0:	0a072783          	lw	a5,160(a4)
    800062e4:	09c72703          	lw	a4,156(a4)
    800062e8:	f0f70ae3          	beq	a4,a5,800061fc <consoleintr+0x3c>
      cons.e--;
    800062ec:	37fd                	addiw	a5,a5,-1
    800062ee:	00020717          	auipc	a4,0x20
    800062f2:	eef72923          	sw	a5,-270(a4) # 800261e0 <cons+0xa0>
      consputc(BACKSPACE);
    800062f6:	10000513          	li	a0,256
    800062fa:	00000097          	auipc	ra,0x0
    800062fe:	e84080e7          	jalr	-380(ra) # 8000617e <consputc>
    80006302:	bded                	j	800061fc <consoleintr+0x3c>
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    80006304:	ee048ce3          	beqz	s1,800061fc <consoleintr+0x3c>
    80006308:	bf21                	j	80006220 <consoleintr+0x60>
      consputc(c);
    8000630a:	4529                	li	a0,10
    8000630c:	00000097          	auipc	ra,0x0
    80006310:	e72080e7          	jalr	-398(ra) # 8000617e <consputc>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80006314:	00020797          	auipc	a5,0x20
    80006318:	e2c78793          	addi	a5,a5,-468 # 80026140 <cons>
    8000631c:	0a07a703          	lw	a4,160(a5)
    80006320:	0017069b          	addiw	a3,a4,1
    80006324:	0006861b          	sext.w	a2,a3
    80006328:	0ad7a023          	sw	a3,160(a5)
    8000632c:	07f77713          	andi	a4,a4,127
    80006330:	97ba                	add	a5,a5,a4
    80006332:	4729                	li	a4,10
    80006334:	00e78c23          	sb	a4,24(a5)
        cons.w = cons.e;
    80006338:	00020797          	auipc	a5,0x20
    8000633c:	eac7a223          	sw	a2,-348(a5) # 800261dc <cons+0x9c>
        wakeup(&cons.r);
    80006340:	00020517          	auipc	a0,0x20
    80006344:	e9850513          	addi	a0,a0,-360 # 800261d8 <cons+0x98>
    80006348:	ffffc097          	auipc	ra,0xffffc
    8000634c:	83e080e7          	jalr	-1986(ra) # 80001b86 <wakeup>
    80006350:	b575                	j	800061fc <consoleintr+0x3c>

0000000080006352 <consoleinit>:

void
consoleinit(void)
{
    80006352:	1141                	addi	sp,sp,-16
    80006354:	e406                	sd	ra,8(sp)
    80006356:	e022                	sd	s0,0(sp)
    80006358:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    8000635a:	00002597          	auipc	a1,0x2
    8000635e:	5b658593          	addi	a1,a1,1462 # 80008910 <syscalls+0x4c0>
    80006362:	00020517          	auipc	a0,0x20
    80006366:	dde50513          	addi	a0,a0,-546 # 80026140 <cons>
    8000636a:	00000097          	auipc	ra,0x0
    8000636e:	590080e7          	jalr	1424(ra) # 800068fa <initlock>

  uartinit();
    80006372:	00000097          	auipc	ra,0x0
    80006376:	330080e7          	jalr	816(ra) # 800066a2 <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    8000637a:	00013797          	auipc	a5,0x13
    8000637e:	d4e78793          	addi	a5,a5,-690 # 800190c8 <devsw>
    80006382:	00000717          	auipc	a4,0x0
    80006386:	ce470713          	addi	a4,a4,-796 # 80006066 <consoleread>
    8000638a:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    8000638c:	00000717          	auipc	a4,0x0
    80006390:	c7870713          	addi	a4,a4,-904 # 80006004 <consolewrite>
    80006394:	ef98                	sd	a4,24(a5)
}
    80006396:	60a2                	ld	ra,8(sp)
    80006398:	6402                	ld	s0,0(sp)
    8000639a:	0141                	addi	sp,sp,16
    8000639c:	8082                	ret

000000008000639e <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    8000639e:	7179                	addi	sp,sp,-48
    800063a0:	f406                	sd	ra,40(sp)
    800063a2:	f022                	sd	s0,32(sp)
    800063a4:	ec26                	sd	s1,24(sp)
    800063a6:	e84a                	sd	s2,16(sp)
    800063a8:	1800                	addi	s0,sp,48
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    800063aa:	c219                	beqz	a2,800063b0 <printint+0x12>
    800063ac:	08054663          	bltz	a0,80006438 <printint+0x9a>
    x = -xx;
  else
    x = xx;
    800063b0:	2501                	sext.w	a0,a0
    800063b2:	4881                	li	a7,0
    800063b4:	fd040693          	addi	a3,s0,-48

  i = 0;
    800063b8:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    800063ba:	2581                	sext.w	a1,a1
    800063bc:	00002617          	auipc	a2,0x2
    800063c0:	58460613          	addi	a2,a2,1412 # 80008940 <digits>
    800063c4:	883a                	mv	a6,a4
    800063c6:	2705                	addiw	a4,a4,1
    800063c8:	02b577bb          	remuw	a5,a0,a1
    800063cc:	1782                	slli	a5,a5,0x20
    800063ce:	9381                	srli	a5,a5,0x20
    800063d0:	97b2                	add	a5,a5,a2
    800063d2:	0007c783          	lbu	a5,0(a5)
    800063d6:	00f68023          	sb	a5,0(a3)
  } while((x /= base) != 0);
    800063da:	0005079b          	sext.w	a5,a0
    800063de:	02b5553b          	divuw	a0,a0,a1
    800063e2:	0685                	addi	a3,a3,1
    800063e4:	feb7f0e3          	bgeu	a5,a1,800063c4 <printint+0x26>

  if(sign)
    800063e8:	00088b63          	beqz	a7,800063fe <printint+0x60>
    buf[i++] = '-';
    800063ec:	fe040793          	addi	a5,s0,-32
    800063f0:	973e                	add	a4,a4,a5
    800063f2:	02d00793          	li	a5,45
    800063f6:	fef70823          	sb	a5,-16(a4)
    800063fa:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    800063fe:	02e05763          	blez	a4,8000642c <printint+0x8e>
    80006402:	fd040793          	addi	a5,s0,-48
    80006406:	00e784b3          	add	s1,a5,a4
    8000640a:	fff78913          	addi	s2,a5,-1
    8000640e:	993a                	add	s2,s2,a4
    80006410:	377d                	addiw	a4,a4,-1
    80006412:	1702                	slli	a4,a4,0x20
    80006414:	9301                	srli	a4,a4,0x20
    80006416:	40e90933          	sub	s2,s2,a4
    consputc(buf[i]);
    8000641a:	fff4c503          	lbu	a0,-1(s1)
    8000641e:	00000097          	auipc	ra,0x0
    80006422:	d60080e7          	jalr	-672(ra) # 8000617e <consputc>
  while(--i >= 0)
    80006426:	14fd                	addi	s1,s1,-1
    80006428:	ff2499e3          	bne	s1,s2,8000641a <printint+0x7c>
}
    8000642c:	70a2                	ld	ra,40(sp)
    8000642e:	7402                	ld	s0,32(sp)
    80006430:	64e2                	ld	s1,24(sp)
    80006432:	6942                	ld	s2,16(sp)
    80006434:	6145                	addi	sp,sp,48
    80006436:	8082                	ret
    x = -xx;
    80006438:	40a0053b          	negw	a0,a0
  if(sign && (sign = xx < 0))
    8000643c:	4885                	li	a7,1
    x = -xx;
    8000643e:	bf9d                	j	800063b4 <printint+0x16>

0000000080006440 <panic>:
    release(&pr.lock);
}

void
panic(char *s)
{
    80006440:	1101                	addi	sp,sp,-32
    80006442:	ec06                	sd	ra,24(sp)
    80006444:	e822                	sd	s0,16(sp)
    80006446:	e426                	sd	s1,8(sp)
    80006448:	1000                	addi	s0,sp,32
    8000644a:	84aa                	mv	s1,a0
  pr.locking = 0;
    8000644c:	00020797          	auipc	a5,0x20
    80006450:	da07aa23          	sw	zero,-588(a5) # 80026200 <pr+0x18>
  printf("panic: ");
    80006454:	00002517          	auipc	a0,0x2
    80006458:	4c450513          	addi	a0,a0,1220 # 80008918 <syscalls+0x4c8>
    8000645c:	00000097          	auipc	ra,0x0
    80006460:	02e080e7          	jalr	46(ra) # 8000648a <printf>
  printf(s);
    80006464:	8526                	mv	a0,s1
    80006466:	00000097          	auipc	ra,0x0
    8000646a:	024080e7          	jalr	36(ra) # 8000648a <printf>
  printf("\n");
    8000646e:	00002517          	auipc	a0,0x2
    80006472:	bda50513          	addi	a0,a0,-1062 # 80008048 <etext+0x48>
    80006476:	00000097          	auipc	ra,0x0
    8000647a:	014080e7          	jalr	20(ra) # 8000648a <printf>
  panicked = 1; // freeze uart output from other CPUs
    8000647e:	4785                	li	a5,1
    80006480:	00003717          	auipc	a4,0x3
    80006484:	b8f72e23          	sw	a5,-1124(a4) # 8000901c <panicked>
  for(;;)
    80006488:	a001                	j	80006488 <panic+0x48>

000000008000648a <printf>:
{
    8000648a:	7131                	addi	sp,sp,-192
    8000648c:	fc86                	sd	ra,120(sp)
    8000648e:	f8a2                	sd	s0,112(sp)
    80006490:	f4a6                	sd	s1,104(sp)
    80006492:	f0ca                	sd	s2,96(sp)
    80006494:	ecce                	sd	s3,88(sp)
    80006496:	e8d2                	sd	s4,80(sp)
    80006498:	e4d6                	sd	s5,72(sp)
    8000649a:	e0da                	sd	s6,64(sp)
    8000649c:	fc5e                	sd	s7,56(sp)
    8000649e:	f862                	sd	s8,48(sp)
    800064a0:	f466                	sd	s9,40(sp)
    800064a2:	f06a                	sd	s10,32(sp)
    800064a4:	ec6e                	sd	s11,24(sp)
    800064a6:	0100                	addi	s0,sp,128
    800064a8:	8a2a                	mv	s4,a0
    800064aa:	e40c                	sd	a1,8(s0)
    800064ac:	e810                	sd	a2,16(s0)
    800064ae:	ec14                	sd	a3,24(s0)
    800064b0:	f018                	sd	a4,32(s0)
    800064b2:	f41c                	sd	a5,40(s0)
    800064b4:	03043823          	sd	a6,48(s0)
    800064b8:	03143c23          	sd	a7,56(s0)
  locking = pr.locking;
    800064bc:	00020d97          	auipc	s11,0x20
    800064c0:	d44dad83          	lw	s11,-700(s11) # 80026200 <pr+0x18>
  if(locking)
    800064c4:	020d9b63          	bnez	s11,800064fa <printf+0x70>
  if (fmt == 0)
    800064c8:	040a0263          	beqz	s4,8000650c <printf+0x82>
  va_start(ap, fmt);
    800064cc:	00840793          	addi	a5,s0,8
    800064d0:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    800064d4:	000a4503          	lbu	a0,0(s4)
    800064d8:	16050263          	beqz	a0,8000663c <printf+0x1b2>
    800064dc:	4481                	li	s1,0
    if(c != '%'){
    800064de:	02500a93          	li	s5,37
    switch(c){
    800064e2:	07000b13          	li	s6,112
  consputc('x');
    800064e6:	4d41                	li	s10,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800064e8:	00002b97          	auipc	s7,0x2
    800064ec:	458b8b93          	addi	s7,s7,1112 # 80008940 <digits>
    switch(c){
    800064f0:	07300c93          	li	s9,115
    800064f4:	06400c13          	li	s8,100
    800064f8:	a82d                	j	80006532 <printf+0xa8>
    acquire(&pr.lock);
    800064fa:	00020517          	auipc	a0,0x20
    800064fe:	cee50513          	addi	a0,a0,-786 # 800261e8 <pr>
    80006502:	00000097          	auipc	ra,0x0
    80006506:	488080e7          	jalr	1160(ra) # 8000698a <acquire>
    8000650a:	bf7d                	j	800064c8 <printf+0x3e>
    panic("null fmt");
    8000650c:	00002517          	auipc	a0,0x2
    80006510:	41c50513          	addi	a0,a0,1052 # 80008928 <syscalls+0x4d8>
    80006514:	00000097          	auipc	ra,0x0
    80006518:	f2c080e7          	jalr	-212(ra) # 80006440 <panic>
      consputc(c);
    8000651c:	00000097          	auipc	ra,0x0
    80006520:	c62080e7          	jalr	-926(ra) # 8000617e <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80006524:	2485                	addiw	s1,s1,1
    80006526:	009a07b3          	add	a5,s4,s1
    8000652a:	0007c503          	lbu	a0,0(a5)
    8000652e:	10050763          	beqz	a0,8000663c <printf+0x1b2>
    if(c != '%'){
    80006532:	ff5515e3          	bne	a0,s5,8000651c <printf+0x92>
    c = fmt[++i] & 0xff;
    80006536:	2485                	addiw	s1,s1,1
    80006538:	009a07b3          	add	a5,s4,s1
    8000653c:	0007c783          	lbu	a5,0(a5)
    80006540:	0007891b          	sext.w	s2,a5
    if(c == 0)
    80006544:	cfe5                	beqz	a5,8000663c <printf+0x1b2>
    switch(c){
    80006546:	05678a63          	beq	a5,s6,8000659a <printf+0x110>
    8000654a:	02fb7663          	bgeu	s6,a5,80006576 <printf+0xec>
    8000654e:	09978963          	beq	a5,s9,800065e0 <printf+0x156>
    80006552:	07800713          	li	a4,120
    80006556:	0ce79863          	bne	a5,a4,80006626 <printf+0x19c>
      printint(va_arg(ap, int), 16, 1);
    8000655a:	f8843783          	ld	a5,-120(s0)
    8000655e:	00878713          	addi	a4,a5,8
    80006562:	f8e43423          	sd	a4,-120(s0)
    80006566:	4605                	li	a2,1
    80006568:	85ea                	mv	a1,s10
    8000656a:	4388                	lw	a0,0(a5)
    8000656c:	00000097          	auipc	ra,0x0
    80006570:	e32080e7          	jalr	-462(ra) # 8000639e <printint>
      break;
    80006574:	bf45                	j	80006524 <printf+0x9a>
    switch(c){
    80006576:	0b578263          	beq	a5,s5,8000661a <printf+0x190>
    8000657a:	0b879663          	bne	a5,s8,80006626 <printf+0x19c>
      printint(va_arg(ap, int), 10, 1);
    8000657e:	f8843783          	ld	a5,-120(s0)
    80006582:	00878713          	addi	a4,a5,8
    80006586:	f8e43423          	sd	a4,-120(s0)
    8000658a:	4605                	li	a2,1
    8000658c:	45a9                	li	a1,10
    8000658e:	4388                	lw	a0,0(a5)
    80006590:	00000097          	auipc	ra,0x0
    80006594:	e0e080e7          	jalr	-498(ra) # 8000639e <printint>
      break;
    80006598:	b771                	j	80006524 <printf+0x9a>
      printptr(va_arg(ap, uint64));
    8000659a:	f8843783          	ld	a5,-120(s0)
    8000659e:	00878713          	addi	a4,a5,8
    800065a2:	f8e43423          	sd	a4,-120(s0)
    800065a6:	0007b983          	ld	s3,0(a5)
  consputc('0');
    800065aa:	03000513          	li	a0,48
    800065ae:	00000097          	auipc	ra,0x0
    800065b2:	bd0080e7          	jalr	-1072(ra) # 8000617e <consputc>
  consputc('x');
    800065b6:	07800513          	li	a0,120
    800065ba:	00000097          	auipc	ra,0x0
    800065be:	bc4080e7          	jalr	-1084(ra) # 8000617e <consputc>
    800065c2:	896a                	mv	s2,s10
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800065c4:	03c9d793          	srli	a5,s3,0x3c
    800065c8:	97de                	add	a5,a5,s7
    800065ca:	0007c503          	lbu	a0,0(a5)
    800065ce:	00000097          	auipc	ra,0x0
    800065d2:	bb0080e7          	jalr	-1104(ra) # 8000617e <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    800065d6:	0992                	slli	s3,s3,0x4
    800065d8:	397d                	addiw	s2,s2,-1
    800065da:	fe0915e3          	bnez	s2,800065c4 <printf+0x13a>
    800065de:	b799                	j	80006524 <printf+0x9a>
      if((s = va_arg(ap, char*)) == 0)
    800065e0:	f8843783          	ld	a5,-120(s0)
    800065e4:	00878713          	addi	a4,a5,8
    800065e8:	f8e43423          	sd	a4,-120(s0)
    800065ec:	0007b903          	ld	s2,0(a5)
    800065f0:	00090e63          	beqz	s2,8000660c <printf+0x182>
      for(; *s; s++)
    800065f4:	00094503          	lbu	a0,0(s2)
    800065f8:	d515                	beqz	a0,80006524 <printf+0x9a>
        consputc(*s);
    800065fa:	00000097          	auipc	ra,0x0
    800065fe:	b84080e7          	jalr	-1148(ra) # 8000617e <consputc>
      for(; *s; s++)
    80006602:	0905                	addi	s2,s2,1
    80006604:	00094503          	lbu	a0,0(s2)
    80006608:	f96d                	bnez	a0,800065fa <printf+0x170>
    8000660a:	bf29                	j	80006524 <printf+0x9a>
        s = "(null)";
    8000660c:	00002917          	auipc	s2,0x2
    80006610:	31490913          	addi	s2,s2,788 # 80008920 <syscalls+0x4d0>
      for(; *s; s++)
    80006614:	02800513          	li	a0,40
    80006618:	b7cd                	j	800065fa <printf+0x170>
      consputc('%');
    8000661a:	8556                	mv	a0,s5
    8000661c:	00000097          	auipc	ra,0x0
    80006620:	b62080e7          	jalr	-1182(ra) # 8000617e <consputc>
      break;
    80006624:	b701                	j	80006524 <printf+0x9a>
      consputc('%');
    80006626:	8556                	mv	a0,s5
    80006628:	00000097          	auipc	ra,0x0
    8000662c:	b56080e7          	jalr	-1194(ra) # 8000617e <consputc>
      consputc(c);
    80006630:	854a                	mv	a0,s2
    80006632:	00000097          	auipc	ra,0x0
    80006636:	b4c080e7          	jalr	-1204(ra) # 8000617e <consputc>
      break;
    8000663a:	b5ed                	j	80006524 <printf+0x9a>
  if(locking)
    8000663c:	020d9163          	bnez	s11,8000665e <printf+0x1d4>
}
    80006640:	70e6                	ld	ra,120(sp)
    80006642:	7446                	ld	s0,112(sp)
    80006644:	74a6                	ld	s1,104(sp)
    80006646:	7906                	ld	s2,96(sp)
    80006648:	69e6                	ld	s3,88(sp)
    8000664a:	6a46                	ld	s4,80(sp)
    8000664c:	6aa6                	ld	s5,72(sp)
    8000664e:	6b06                	ld	s6,64(sp)
    80006650:	7be2                	ld	s7,56(sp)
    80006652:	7c42                	ld	s8,48(sp)
    80006654:	7ca2                	ld	s9,40(sp)
    80006656:	7d02                	ld	s10,32(sp)
    80006658:	6de2                	ld	s11,24(sp)
    8000665a:	6129                	addi	sp,sp,192
    8000665c:	8082                	ret
    release(&pr.lock);
    8000665e:	00020517          	auipc	a0,0x20
    80006662:	b8a50513          	addi	a0,a0,-1142 # 800261e8 <pr>
    80006666:	00000097          	auipc	ra,0x0
    8000666a:	3d8080e7          	jalr	984(ra) # 80006a3e <release>
}
    8000666e:	bfc9                	j	80006640 <printf+0x1b6>

0000000080006670 <printfinit>:
    ;
}

void
printfinit(void)
{
    80006670:	1101                	addi	sp,sp,-32
    80006672:	ec06                	sd	ra,24(sp)
    80006674:	e822                	sd	s0,16(sp)
    80006676:	e426                	sd	s1,8(sp)
    80006678:	1000                	addi	s0,sp,32
  initlock(&pr.lock, "pr");
    8000667a:	00020497          	auipc	s1,0x20
    8000667e:	b6e48493          	addi	s1,s1,-1170 # 800261e8 <pr>
    80006682:	00002597          	auipc	a1,0x2
    80006686:	2b658593          	addi	a1,a1,694 # 80008938 <syscalls+0x4e8>
    8000668a:	8526                	mv	a0,s1
    8000668c:	00000097          	auipc	ra,0x0
    80006690:	26e080e7          	jalr	622(ra) # 800068fa <initlock>
  pr.locking = 1;
    80006694:	4785                	li	a5,1
    80006696:	cc9c                	sw	a5,24(s1)
}
    80006698:	60e2                	ld	ra,24(sp)
    8000669a:	6442                	ld	s0,16(sp)
    8000669c:	64a2                	ld	s1,8(sp)
    8000669e:	6105                	addi	sp,sp,32
    800066a0:	8082                	ret

00000000800066a2 <uartinit>:

void uartstart();

void
uartinit(void)
{
    800066a2:	1141                	addi	sp,sp,-16
    800066a4:	e406                	sd	ra,8(sp)
    800066a6:	e022                	sd	s0,0(sp)
    800066a8:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    800066aa:	100007b7          	lui	a5,0x10000
    800066ae:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    800066b2:	f8000713          	li	a4,-128
    800066b6:	00e781a3          	sb	a4,3(a5)

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    800066ba:	470d                	li	a4,3
    800066bc:	00e78023          	sb	a4,0(a5)

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    800066c0:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    800066c4:	00e781a3          	sb	a4,3(a5)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    800066c8:	469d                	li	a3,7
    800066ca:	00d78123          	sb	a3,2(a5)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    800066ce:	00e780a3          	sb	a4,1(a5)

  initlock(&uart_tx_lock, "uart");
    800066d2:	00002597          	auipc	a1,0x2
    800066d6:	28658593          	addi	a1,a1,646 # 80008958 <digits+0x18>
    800066da:	00020517          	auipc	a0,0x20
    800066de:	b2e50513          	addi	a0,a0,-1234 # 80026208 <uart_tx_lock>
    800066e2:	00000097          	auipc	ra,0x0
    800066e6:	218080e7          	jalr	536(ra) # 800068fa <initlock>
}
    800066ea:	60a2                	ld	ra,8(sp)
    800066ec:	6402                	ld	s0,0(sp)
    800066ee:	0141                	addi	sp,sp,16
    800066f0:	8082                	ret

00000000800066f2 <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    800066f2:	1101                	addi	sp,sp,-32
    800066f4:	ec06                	sd	ra,24(sp)
    800066f6:	e822                	sd	s0,16(sp)
    800066f8:	e426                	sd	s1,8(sp)
    800066fa:	1000                	addi	s0,sp,32
    800066fc:	84aa                	mv	s1,a0
  push_off();
    800066fe:	00000097          	auipc	ra,0x0
    80006702:	240080e7          	jalr	576(ra) # 8000693e <push_off>

  if(panicked){
    80006706:	00003797          	auipc	a5,0x3
    8000670a:	9167a783          	lw	a5,-1770(a5) # 8000901c <panicked>
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    8000670e:	10000737          	lui	a4,0x10000
  if(panicked){
    80006712:	c391                	beqz	a5,80006716 <uartputc_sync+0x24>
    for(;;)
    80006714:	a001                	j	80006714 <uartputc_sync+0x22>
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80006716:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000671a:	0ff7f793          	andi	a5,a5,255
    8000671e:	0207f793          	andi	a5,a5,32
    80006722:	dbf5                	beqz	a5,80006716 <uartputc_sync+0x24>
    ;
  WriteReg(THR, c);
    80006724:	0ff4f793          	andi	a5,s1,255
    80006728:	10000737          	lui	a4,0x10000
    8000672c:	00f70023          	sb	a5,0(a4) # 10000000 <_entry-0x70000000>

  pop_off();
    80006730:	00000097          	auipc	ra,0x0
    80006734:	2ae080e7          	jalr	686(ra) # 800069de <pop_off>
}
    80006738:	60e2                	ld	ra,24(sp)
    8000673a:	6442                	ld	s0,16(sp)
    8000673c:	64a2                	ld	s1,8(sp)
    8000673e:	6105                	addi	sp,sp,32
    80006740:	8082                	ret

0000000080006742 <uartstart>:
// called from both the top- and bottom-half.
void
uartstart()
{
  while(1){
    if(uart_tx_w == uart_tx_r){
    80006742:	00003717          	auipc	a4,0x3
    80006746:	8de73703          	ld	a4,-1826(a4) # 80009020 <uart_tx_r>
    8000674a:	00003797          	auipc	a5,0x3
    8000674e:	8de7b783          	ld	a5,-1826(a5) # 80009028 <uart_tx_w>
    80006752:	06e78c63          	beq	a5,a4,800067ca <uartstart+0x88>
{
    80006756:	7139                	addi	sp,sp,-64
    80006758:	fc06                	sd	ra,56(sp)
    8000675a:	f822                	sd	s0,48(sp)
    8000675c:	f426                	sd	s1,40(sp)
    8000675e:	f04a                	sd	s2,32(sp)
    80006760:	ec4e                	sd	s3,24(sp)
    80006762:	e852                	sd	s4,16(sp)
    80006764:	e456                	sd	s5,8(sp)
    80006766:	0080                	addi	s0,sp,64
      // transmit buffer is empty.
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80006768:	10000937          	lui	s2,0x10000
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    8000676c:	00020a17          	auipc	s4,0x20
    80006770:	a9ca0a13          	addi	s4,s4,-1380 # 80026208 <uart_tx_lock>
    uart_tx_r += 1;
    80006774:	00003497          	auipc	s1,0x3
    80006778:	8ac48493          	addi	s1,s1,-1876 # 80009020 <uart_tx_r>
    if(uart_tx_w == uart_tx_r){
    8000677c:	00003997          	auipc	s3,0x3
    80006780:	8ac98993          	addi	s3,s3,-1876 # 80009028 <uart_tx_w>
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80006784:	00594783          	lbu	a5,5(s2) # 10000005 <_entry-0x6ffffffb>
    80006788:	0ff7f793          	andi	a5,a5,255
    8000678c:	0207f793          	andi	a5,a5,32
    80006790:	c785                	beqz	a5,800067b8 <uartstart+0x76>
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80006792:	01f77793          	andi	a5,a4,31
    80006796:	97d2                	add	a5,a5,s4
    80006798:	0187ca83          	lbu	s5,24(a5)
    uart_tx_r += 1;
    8000679c:	0705                	addi	a4,a4,1
    8000679e:	e098                	sd	a4,0(s1)
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    800067a0:	8526                	mv	a0,s1
    800067a2:	ffffb097          	auipc	ra,0xffffb
    800067a6:	3e4080e7          	jalr	996(ra) # 80001b86 <wakeup>
    
    WriteReg(THR, c);
    800067aa:	01590023          	sb	s5,0(s2)
    if(uart_tx_w == uart_tx_r){
    800067ae:	6098                	ld	a4,0(s1)
    800067b0:	0009b783          	ld	a5,0(s3)
    800067b4:	fce798e3          	bne	a5,a4,80006784 <uartstart+0x42>
  }
}
    800067b8:	70e2                	ld	ra,56(sp)
    800067ba:	7442                	ld	s0,48(sp)
    800067bc:	74a2                	ld	s1,40(sp)
    800067be:	7902                	ld	s2,32(sp)
    800067c0:	69e2                	ld	s3,24(sp)
    800067c2:	6a42                	ld	s4,16(sp)
    800067c4:	6aa2                	ld	s5,8(sp)
    800067c6:	6121                	addi	sp,sp,64
    800067c8:	8082                	ret
    800067ca:	8082                	ret

00000000800067cc <uartputc>:
{
    800067cc:	7179                	addi	sp,sp,-48
    800067ce:	f406                	sd	ra,40(sp)
    800067d0:	f022                	sd	s0,32(sp)
    800067d2:	ec26                	sd	s1,24(sp)
    800067d4:	e84a                	sd	s2,16(sp)
    800067d6:	e44e                	sd	s3,8(sp)
    800067d8:	e052                	sd	s4,0(sp)
    800067da:	1800                	addi	s0,sp,48
    800067dc:	89aa                	mv	s3,a0
  acquire(&uart_tx_lock);
    800067de:	00020517          	auipc	a0,0x20
    800067e2:	a2a50513          	addi	a0,a0,-1494 # 80026208 <uart_tx_lock>
    800067e6:	00000097          	auipc	ra,0x0
    800067ea:	1a4080e7          	jalr	420(ra) # 8000698a <acquire>
  if(panicked){
    800067ee:	00003797          	auipc	a5,0x3
    800067f2:	82e7a783          	lw	a5,-2002(a5) # 8000901c <panicked>
    800067f6:	c391                	beqz	a5,800067fa <uartputc+0x2e>
    for(;;)
    800067f8:	a001                	j	800067f8 <uartputc+0x2c>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    800067fa:	00003797          	auipc	a5,0x3
    800067fe:	82e7b783          	ld	a5,-2002(a5) # 80009028 <uart_tx_w>
    80006802:	00003717          	auipc	a4,0x3
    80006806:	81e73703          	ld	a4,-2018(a4) # 80009020 <uart_tx_r>
    8000680a:	02070713          	addi	a4,a4,32
    8000680e:	02f71b63          	bne	a4,a5,80006844 <uartputc+0x78>
      sleep(&uart_tx_r, &uart_tx_lock);
    80006812:	00020a17          	auipc	s4,0x20
    80006816:	9f6a0a13          	addi	s4,s4,-1546 # 80026208 <uart_tx_lock>
    8000681a:	00003497          	auipc	s1,0x3
    8000681e:	80648493          	addi	s1,s1,-2042 # 80009020 <uart_tx_r>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80006822:	00003917          	auipc	s2,0x3
    80006826:	80690913          	addi	s2,s2,-2042 # 80009028 <uart_tx_w>
      sleep(&uart_tx_r, &uart_tx_lock);
    8000682a:	85d2                	mv	a1,s4
    8000682c:	8526                	mv	a0,s1
    8000682e:	ffffb097          	auipc	ra,0xffffb
    80006832:	1cc080e7          	jalr	460(ra) # 800019fa <sleep>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80006836:	00093783          	ld	a5,0(s2)
    8000683a:	6098                	ld	a4,0(s1)
    8000683c:	02070713          	addi	a4,a4,32
    80006840:	fef705e3          	beq	a4,a5,8000682a <uartputc+0x5e>
      uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    80006844:	00020497          	auipc	s1,0x20
    80006848:	9c448493          	addi	s1,s1,-1596 # 80026208 <uart_tx_lock>
    8000684c:	01f7f713          	andi	a4,a5,31
    80006850:	9726                	add	a4,a4,s1
    80006852:	01370c23          	sb	s3,24(a4)
      uart_tx_w += 1;
    80006856:	0785                	addi	a5,a5,1
    80006858:	00002717          	auipc	a4,0x2
    8000685c:	7cf73823          	sd	a5,2000(a4) # 80009028 <uart_tx_w>
      uartstart();
    80006860:	00000097          	auipc	ra,0x0
    80006864:	ee2080e7          	jalr	-286(ra) # 80006742 <uartstart>
      release(&uart_tx_lock);
    80006868:	8526                	mv	a0,s1
    8000686a:	00000097          	auipc	ra,0x0
    8000686e:	1d4080e7          	jalr	468(ra) # 80006a3e <release>
}
    80006872:	70a2                	ld	ra,40(sp)
    80006874:	7402                	ld	s0,32(sp)
    80006876:	64e2                	ld	s1,24(sp)
    80006878:	6942                	ld	s2,16(sp)
    8000687a:	69a2                	ld	s3,8(sp)
    8000687c:	6a02                	ld	s4,0(sp)
    8000687e:	6145                	addi	sp,sp,48
    80006880:	8082                	ret

0000000080006882 <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    80006882:	1141                	addi	sp,sp,-16
    80006884:	e422                	sd	s0,8(sp)
    80006886:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    80006888:	100007b7          	lui	a5,0x10000
    8000688c:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80006890:	8b85                	andi	a5,a5,1
    80006892:	cb91                	beqz	a5,800068a6 <uartgetc+0x24>
    // input data is ready.
    return ReadReg(RHR);
    80006894:	100007b7          	lui	a5,0x10000
    80006898:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
    8000689c:	0ff57513          	andi	a0,a0,255
  } else {
    return -1;
  }
}
    800068a0:	6422                	ld	s0,8(sp)
    800068a2:	0141                	addi	sp,sp,16
    800068a4:	8082                	ret
    return -1;
    800068a6:	557d                	li	a0,-1
    800068a8:	bfe5                	j	800068a0 <uartgetc+0x1e>

00000000800068aa <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from trap.c.
void
uartintr(void)
{
    800068aa:	1101                	addi	sp,sp,-32
    800068ac:	ec06                	sd	ra,24(sp)
    800068ae:	e822                	sd	s0,16(sp)
    800068b0:	e426                	sd	s1,8(sp)
    800068b2:	1000                	addi	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    800068b4:	54fd                	li	s1,-1
    int c = uartgetc();
    800068b6:	00000097          	auipc	ra,0x0
    800068ba:	fcc080e7          	jalr	-52(ra) # 80006882 <uartgetc>
    if(c == -1)
    800068be:	00950763          	beq	a0,s1,800068cc <uartintr+0x22>
      break;
    consoleintr(c);
    800068c2:	00000097          	auipc	ra,0x0
    800068c6:	8fe080e7          	jalr	-1794(ra) # 800061c0 <consoleintr>
  while(1){
    800068ca:	b7f5                	j	800068b6 <uartintr+0xc>
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    800068cc:	00020497          	auipc	s1,0x20
    800068d0:	93c48493          	addi	s1,s1,-1732 # 80026208 <uart_tx_lock>
    800068d4:	8526                	mv	a0,s1
    800068d6:	00000097          	auipc	ra,0x0
    800068da:	0b4080e7          	jalr	180(ra) # 8000698a <acquire>
  uartstart();
    800068de:	00000097          	auipc	ra,0x0
    800068e2:	e64080e7          	jalr	-412(ra) # 80006742 <uartstart>
  release(&uart_tx_lock);
    800068e6:	8526                	mv	a0,s1
    800068e8:	00000097          	auipc	ra,0x0
    800068ec:	156080e7          	jalr	342(ra) # 80006a3e <release>
}
    800068f0:	60e2                	ld	ra,24(sp)
    800068f2:	6442                	ld	s0,16(sp)
    800068f4:	64a2                	ld	s1,8(sp)
    800068f6:	6105                	addi	sp,sp,32
    800068f8:	8082                	ret

00000000800068fa <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    800068fa:	1141                	addi	sp,sp,-16
    800068fc:	e422                	sd	s0,8(sp)
    800068fe:	0800                	addi	s0,sp,16
  lk->name = name;
    80006900:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    80006902:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    80006906:	00053823          	sd	zero,16(a0)
}
    8000690a:	6422                	ld	s0,8(sp)
    8000690c:	0141                	addi	sp,sp,16
    8000690e:	8082                	ret

0000000080006910 <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    80006910:	411c                	lw	a5,0(a0)
    80006912:	e399                	bnez	a5,80006918 <holding+0x8>
    80006914:	4501                	li	a0,0
  return r;
}
    80006916:	8082                	ret
{
    80006918:	1101                	addi	sp,sp,-32
    8000691a:	ec06                	sd	ra,24(sp)
    8000691c:	e822                	sd	s0,16(sp)
    8000691e:	e426                	sd	s1,8(sp)
    80006920:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    80006922:	6904                	ld	s1,16(a0)
    80006924:	ffffb097          	auipc	ra,0xffffb
    80006928:	9fe080e7          	jalr	-1538(ra) # 80001322 <mycpu>
    8000692c:	40a48533          	sub	a0,s1,a0
    80006930:	00153513          	seqz	a0,a0
}
    80006934:	60e2                	ld	ra,24(sp)
    80006936:	6442                	ld	s0,16(sp)
    80006938:	64a2                	ld	s1,8(sp)
    8000693a:	6105                	addi	sp,sp,32
    8000693c:	8082                	ret

000000008000693e <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    8000693e:	1101                	addi	sp,sp,-32
    80006940:	ec06                	sd	ra,24(sp)
    80006942:	e822                	sd	s0,16(sp)
    80006944:	e426                	sd	s1,8(sp)
    80006946:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80006948:	100024f3          	csrr	s1,sstatus
    8000694c:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80006950:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80006952:	10079073          	csrw	sstatus,a5
  int old = intr_get();

  intr_off();
  if(mycpu()->noff == 0)
    80006956:	ffffb097          	auipc	ra,0xffffb
    8000695a:	9cc080e7          	jalr	-1588(ra) # 80001322 <mycpu>
    8000695e:	5d3c                	lw	a5,120(a0)
    80006960:	cf89                	beqz	a5,8000697a <push_off+0x3c>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    80006962:	ffffb097          	auipc	ra,0xffffb
    80006966:	9c0080e7          	jalr	-1600(ra) # 80001322 <mycpu>
    8000696a:	5d3c                	lw	a5,120(a0)
    8000696c:	2785                	addiw	a5,a5,1
    8000696e:	dd3c                	sw	a5,120(a0)
}
    80006970:	60e2                	ld	ra,24(sp)
    80006972:	6442                	ld	s0,16(sp)
    80006974:	64a2                	ld	s1,8(sp)
    80006976:	6105                	addi	sp,sp,32
    80006978:	8082                	ret
    mycpu()->intena = old;
    8000697a:	ffffb097          	auipc	ra,0xffffb
    8000697e:	9a8080e7          	jalr	-1624(ra) # 80001322 <mycpu>
  return (x & SSTATUS_SIE) != 0;
    80006982:	8085                	srli	s1,s1,0x1
    80006984:	8885                	andi	s1,s1,1
    80006986:	dd64                	sw	s1,124(a0)
    80006988:	bfe9                	j	80006962 <push_off+0x24>

000000008000698a <acquire>:
{
    8000698a:	1101                	addi	sp,sp,-32
    8000698c:	ec06                	sd	ra,24(sp)
    8000698e:	e822                	sd	s0,16(sp)
    80006990:	e426                	sd	s1,8(sp)
    80006992:	1000                	addi	s0,sp,32
    80006994:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    80006996:	00000097          	auipc	ra,0x0
    8000699a:	fa8080e7          	jalr	-88(ra) # 8000693e <push_off>
  if(holding(lk))
    8000699e:	8526                	mv	a0,s1
    800069a0:	00000097          	auipc	ra,0x0
    800069a4:	f70080e7          	jalr	-144(ra) # 80006910 <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    800069a8:	4705                	li	a4,1
  if(holding(lk))
    800069aa:	e115                	bnez	a0,800069ce <acquire+0x44>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    800069ac:	87ba                	mv	a5,a4
    800069ae:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    800069b2:	2781                	sext.w	a5,a5
    800069b4:	ffe5                	bnez	a5,800069ac <acquire+0x22>
  __sync_synchronize();
    800069b6:	0ff0000f          	fence
  lk->cpu = mycpu();
    800069ba:	ffffb097          	auipc	ra,0xffffb
    800069be:	968080e7          	jalr	-1688(ra) # 80001322 <mycpu>
    800069c2:	e888                	sd	a0,16(s1)
}
    800069c4:	60e2                	ld	ra,24(sp)
    800069c6:	6442                	ld	s0,16(sp)
    800069c8:	64a2                	ld	s1,8(sp)
    800069ca:	6105                	addi	sp,sp,32
    800069cc:	8082                	ret
    panic("acquire");
    800069ce:	00002517          	auipc	a0,0x2
    800069d2:	f9250513          	addi	a0,a0,-110 # 80008960 <digits+0x20>
    800069d6:	00000097          	auipc	ra,0x0
    800069da:	a6a080e7          	jalr	-1430(ra) # 80006440 <panic>

00000000800069de <pop_off>:

void
pop_off(void)
{
    800069de:	1141                	addi	sp,sp,-16
    800069e0:	e406                	sd	ra,8(sp)
    800069e2:	e022                	sd	s0,0(sp)
    800069e4:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    800069e6:	ffffb097          	auipc	ra,0xffffb
    800069ea:	93c080e7          	jalr	-1732(ra) # 80001322 <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800069ee:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    800069f2:	8b89                	andi	a5,a5,2
  if(intr_get())
    800069f4:	e78d                	bnez	a5,80006a1e <pop_off+0x40>
    panic("pop_off - interruptible");
  if(c->noff < 1)
    800069f6:	5d3c                	lw	a5,120(a0)
    800069f8:	02f05b63          	blez	a5,80006a2e <pop_off+0x50>
    panic("pop_off");
  c->noff -= 1;
    800069fc:	37fd                	addiw	a5,a5,-1
    800069fe:	0007871b          	sext.w	a4,a5
    80006a02:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    80006a04:	eb09                	bnez	a4,80006a16 <pop_off+0x38>
    80006a06:	5d7c                	lw	a5,124(a0)
    80006a08:	c799                	beqz	a5,80006a16 <pop_off+0x38>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80006a0a:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80006a0e:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80006a12:	10079073          	csrw	sstatus,a5
    intr_on();
}
    80006a16:	60a2                	ld	ra,8(sp)
    80006a18:	6402                	ld	s0,0(sp)
    80006a1a:	0141                	addi	sp,sp,16
    80006a1c:	8082                	ret
    panic("pop_off - interruptible");
    80006a1e:	00002517          	auipc	a0,0x2
    80006a22:	f4a50513          	addi	a0,a0,-182 # 80008968 <digits+0x28>
    80006a26:	00000097          	auipc	ra,0x0
    80006a2a:	a1a080e7          	jalr	-1510(ra) # 80006440 <panic>
    panic("pop_off");
    80006a2e:	00002517          	auipc	a0,0x2
    80006a32:	f5250513          	addi	a0,a0,-174 # 80008980 <digits+0x40>
    80006a36:	00000097          	auipc	ra,0x0
    80006a3a:	a0a080e7          	jalr	-1526(ra) # 80006440 <panic>

0000000080006a3e <release>:
{
    80006a3e:	1101                	addi	sp,sp,-32
    80006a40:	ec06                	sd	ra,24(sp)
    80006a42:	e822                	sd	s0,16(sp)
    80006a44:	e426                	sd	s1,8(sp)
    80006a46:	1000                	addi	s0,sp,32
    80006a48:	84aa                	mv	s1,a0
  if(!holding(lk))
    80006a4a:	00000097          	auipc	ra,0x0
    80006a4e:	ec6080e7          	jalr	-314(ra) # 80006910 <holding>
    80006a52:	c115                	beqz	a0,80006a76 <release+0x38>
  lk->cpu = 0;
    80006a54:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    80006a58:	0ff0000f          	fence
  __sync_lock_release(&lk->locked);
    80006a5c:	0f50000f          	fence	iorw,ow
    80006a60:	0804a02f          	amoswap.w	zero,zero,(s1)
  pop_off();
    80006a64:	00000097          	auipc	ra,0x0
    80006a68:	f7a080e7          	jalr	-134(ra) # 800069de <pop_off>
}
    80006a6c:	60e2                	ld	ra,24(sp)
    80006a6e:	6442                	ld	s0,16(sp)
    80006a70:	64a2                	ld	s1,8(sp)
    80006a72:	6105                	addi	sp,sp,32
    80006a74:	8082                	ret
    panic("release");
    80006a76:	00002517          	auipc	a0,0x2
    80006a7a:	f1250513          	addi	a0,a0,-238 # 80008988 <digits+0x48>
    80006a7e:	00000097          	auipc	ra,0x0
    80006a82:	9c2080e7          	jalr	-1598(ra) # 80006440 <panic>
	...

0000000080007000 <_trampoline>:
    80007000:	14051573          	csrrw	a0,sscratch,a0
    80007004:	02153423          	sd	ra,40(a0)
    80007008:	02253823          	sd	sp,48(a0)
    8000700c:	02353c23          	sd	gp,56(a0)
    80007010:	04453023          	sd	tp,64(a0)
    80007014:	04553423          	sd	t0,72(a0)
    80007018:	04653823          	sd	t1,80(a0)
    8000701c:	04753c23          	sd	t2,88(a0)
    80007020:	f120                	sd	s0,96(a0)
    80007022:	f524                	sd	s1,104(a0)
    80007024:	fd2c                	sd	a1,120(a0)
    80007026:	e150                	sd	a2,128(a0)
    80007028:	e554                	sd	a3,136(a0)
    8000702a:	e958                	sd	a4,144(a0)
    8000702c:	ed5c                	sd	a5,152(a0)
    8000702e:	0b053023          	sd	a6,160(a0)
    80007032:	0b153423          	sd	a7,168(a0)
    80007036:	0b253823          	sd	s2,176(a0)
    8000703a:	0b353c23          	sd	s3,184(a0)
    8000703e:	0d453023          	sd	s4,192(a0)
    80007042:	0d553423          	sd	s5,200(a0)
    80007046:	0d653823          	sd	s6,208(a0)
    8000704a:	0d753c23          	sd	s7,216(a0)
    8000704e:	0f853023          	sd	s8,224(a0)
    80007052:	0f953423          	sd	s9,232(a0)
    80007056:	0fa53823          	sd	s10,240(a0)
    8000705a:	0fb53c23          	sd	s11,248(a0)
    8000705e:	11c53023          	sd	t3,256(a0)
    80007062:	11d53423          	sd	t4,264(a0)
    80007066:	11e53823          	sd	t5,272(a0)
    8000706a:	11f53c23          	sd	t6,280(a0)
    8000706e:	140022f3          	csrr	t0,sscratch
    80007072:	06553823          	sd	t0,112(a0)
    80007076:	00853103          	ld	sp,8(a0)
    8000707a:	02053203          	ld	tp,32(a0)
    8000707e:	01053283          	ld	t0,16(a0)
    80007082:	00053303          	ld	t1,0(a0)
    80007086:	18031073          	csrw	satp,t1
    8000708a:	12000073          	sfence.vma
    8000708e:	8282                	jr	t0

0000000080007090 <userret>:
    80007090:	18059073          	csrw	satp,a1
    80007094:	12000073          	sfence.vma
    80007098:	07053283          	ld	t0,112(a0)
    8000709c:	14029073          	csrw	sscratch,t0
    800070a0:	02853083          	ld	ra,40(a0)
    800070a4:	03053103          	ld	sp,48(a0)
    800070a8:	03853183          	ld	gp,56(a0)
    800070ac:	04053203          	ld	tp,64(a0)
    800070b0:	04853283          	ld	t0,72(a0)
    800070b4:	05053303          	ld	t1,80(a0)
    800070b8:	05853383          	ld	t2,88(a0)
    800070bc:	7120                	ld	s0,96(a0)
    800070be:	7524                	ld	s1,104(a0)
    800070c0:	7d2c                	ld	a1,120(a0)
    800070c2:	6150                	ld	a2,128(a0)
    800070c4:	6554                	ld	a3,136(a0)
    800070c6:	6958                	ld	a4,144(a0)
    800070c8:	6d5c                	ld	a5,152(a0)
    800070ca:	0a053803          	ld	a6,160(a0)
    800070ce:	0a853883          	ld	a7,168(a0)
    800070d2:	0b053903          	ld	s2,176(a0)
    800070d6:	0b853983          	ld	s3,184(a0)
    800070da:	0c053a03          	ld	s4,192(a0)
    800070de:	0c853a83          	ld	s5,200(a0)
    800070e2:	0d053b03          	ld	s6,208(a0)
    800070e6:	0d853b83          	ld	s7,216(a0)
    800070ea:	0e053c03          	ld	s8,224(a0)
    800070ee:	0e853c83          	ld	s9,232(a0)
    800070f2:	0f053d03          	ld	s10,240(a0)
    800070f6:	0f853d83          	ld	s11,248(a0)
    800070fa:	10053e03          	ld	t3,256(a0)
    800070fe:	10853e83          	ld	t4,264(a0)
    80007102:	11053f03          	ld	t5,272(a0)
    80007106:	11853f83          	ld	t6,280(a0)
    8000710a:	14051573          	csrrw	a0,sscratch,a0
    8000710e:	10200073          	sret
	...
