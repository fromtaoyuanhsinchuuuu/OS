
user/_custom_1:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#define PG_SIZE 4096
#define NR_PG 4096

/*large number of pages allocated*/

int main(int argc, char *argv[]) {
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
  	vmprint();
   8:	00000097          	auipc	ra,0x0
   c:	376080e7          	jalr	886(ra) # 37e <vmprint>
	for (int i = 0;i < 2;i++) {
  		char *ptr = malloc(NR_PG * PG_SIZE);
  10:	01000537          	lui	a0,0x1000
  14:	00000097          	auipc	ra,0x0
  18:	71c080e7          	jalr	1820(ra) # 730 <malloc>
  		vmprint();
  1c:	00000097          	auipc	ra,0x0
  20:	362080e7          	jalr	866(ra) # 37e <vmprint>
  		char *ptr = malloc(NR_PG * PG_SIZE);
  24:	01000537          	lui	a0,0x1000
  28:	00000097          	auipc	ra,0x0
  2c:	708080e7          	jalr	1800(ra) # 730 <malloc>
  		vmprint();
  30:	00000097          	auipc	ra,0x0
  34:	34e080e7          	jalr	846(ra) # 37e <vmprint>
	}
  	exit(0);
  38:	4501                	li	a0,0
  3a:	00000097          	auipc	ra,0x0
  3e:	294080e7          	jalr	660(ra) # 2ce <exit>

0000000000000042 <strcpy>:



char*
strcpy(char *s, const char *t)
{
  42:	1141                	addi	sp,sp,-16
  44:	e422                	sd	s0,8(sp)
  46:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  48:	87aa                	mv	a5,a0
  4a:	0585                	addi	a1,a1,1
  4c:	0785                	addi	a5,a5,1
  4e:	fff5c703          	lbu	a4,-1(a1)
  52:	fee78fa3          	sb	a4,-1(a5)
  56:	fb75                	bnez	a4,4a <strcpy+0x8>
    ;
  return os;
}
  58:	6422                	ld	s0,8(sp)
  5a:	0141                	addi	sp,sp,16
  5c:	8082                	ret

000000000000005e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  5e:	1141                	addi	sp,sp,-16
  60:	e422                	sd	s0,8(sp)
  62:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  64:	00054783          	lbu	a5,0(a0) # 1000000 <__global_pointer$+0xffefcf>
  68:	cb91                	beqz	a5,7c <strcmp+0x1e>
  6a:	0005c703          	lbu	a4,0(a1)
  6e:	00f71763          	bne	a4,a5,7c <strcmp+0x1e>
    p++, q++;
  72:	0505                	addi	a0,a0,1
  74:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  76:	00054783          	lbu	a5,0(a0)
  7a:	fbe5                	bnez	a5,6a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  7c:	0005c503          	lbu	a0,0(a1)
}
  80:	40a7853b          	subw	a0,a5,a0
  84:	6422                	ld	s0,8(sp)
  86:	0141                	addi	sp,sp,16
  88:	8082                	ret

000000000000008a <strlen>:

uint
strlen(const char *s)
{
  8a:	1141                	addi	sp,sp,-16
  8c:	e422                	sd	s0,8(sp)
  8e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  90:	00054783          	lbu	a5,0(a0)
  94:	cf91                	beqz	a5,b0 <strlen+0x26>
  96:	0505                	addi	a0,a0,1
  98:	87aa                	mv	a5,a0
  9a:	4685                	li	a3,1
  9c:	9e89                	subw	a3,a3,a0
  9e:	00f6853b          	addw	a0,a3,a5
  a2:	0785                	addi	a5,a5,1
  a4:	fff7c703          	lbu	a4,-1(a5)
  a8:	fb7d                	bnez	a4,9e <strlen+0x14>
    ;
  return n;
}
  aa:	6422                	ld	s0,8(sp)
  ac:	0141                	addi	sp,sp,16
  ae:	8082                	ret
  for(n = 0; s[n]; n++)
  b0:	4501                	li	a0,0
  b2:	bfe5                	j	aa <strlen+0x20>

00000000000000b4 <memset>:

void*
memset(void *dst, int c, uint n)
{
  b4:	1141                	addi	sp,sp,-16
  b6:	e422                	sd	s0,8(sp)
  b8:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  ba:	ce09                	beqz	a2,d4 <memset+0x20>
  bc:	87aa                	mv	a5,a0
  be:	fff6071b          	addiw	a4,a2,-1
  c2:	1702                	slli	a4,a4,0x20
  c4:	9301                	srli	a4,a4,0x20
  c6:	0705                	addi	a4,a4,1
  c8:	972a                	add	a4,a4,a0
    cdst[i] = c;
  ca:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  ce:	0785                	addi	a5,a5,1
  d0:	fee79de3          	bne	a5,a4,ca <memset+0x16>
  }
  return dst;
}
  d4:	6422                	ld	s0,8(sp)
  d6:	0141                	addi	sp,sp,16
  d8:	8082                	ret

00000000000000da <strchr>:

char*
strchr(const char *s, char c)
{
  da:	1141                	addi	sp,sp,-16
  dc:	e422                	sd	s0,8(sp)
  de:	0800                	addi	s0,sp,16
  for(; *s; s++)
  e0:	00054783          	lbu	a5,0(a0)
  e4:	cb99                	beqz	a5,fa <strchr+0x20>
    if(*s == c)
  e6:	00f58763          	beq	a1,a5,f4 <strchr+0x1a>
  for(; *s; s++)
  ea:	0505                	addi	a0,a0,1
  ec:	00054783          	lbu	a5,0(a0)
  f0:	fbfd                	bnez	a5,e6 <strchr+0xc>
      return (char*)s;
  return 0;
  f2:	4501                	li	a0,0
}
  f4:	6422                	ld	s0,8(sp)
  f6:	0141                	addi	sp,sp,16
  f8:	8082                	ret
  return 0;
  fa:	4501                	li	a0,0
  fc:	bfe5                	j	f4 <strchr+0x1a>

00000000000000fe <gets>:

char*
gets(char *buf, int max)
{
  fe:	711d                	addi	sp,sp,-96
 100:	ec86                	sd	ra,88(sp)
 102:	e8a2                	sd	s0,80(sp)
 104:	e4a6                	sd	s1,72(sp)
 106:	e0ca                	sd	s2,64(sp)
 108:	fc4e                	sd	s3,56(sp)
 10a:	f852                	sd	s4,48(sp)
 10c:	f456                	sd	s5,40(sp)
 10e:	f05a                	sd	s6,32(sp)
 110:	ec5e                	sd	s7,24(sp)
 112:	1080                	addi	s0,sp,96
 114:	8baa                	mv	s7,a0
 116:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 118:	892a                	mv	s2,a0
 11a:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 11c:	4aa9                	li	s5,10
 11e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 120:	89a6                	mv	s3,s1
 122:	2485                	addiw	s1,s1,1
 124:	0344d863          	bge	s1,s4,154 <gets+0x56>
    cc = read(0, &c, 1);
 128:	4605                	li	a2,1
 12a:	faf40593          	addi	a1,s0,-81
 12e:	4501                	li	a0,0
 130:	00000097          	auipc	ra,0x0
 134:	1b6080e7          	jalr	438(ra) # 2e6 <read>
    if(cc < 1)
 138:	00a05e63          	blez	a0,154 <gets+0x56>
    buf[i++] = c;
 13c:	faf44783          	lbu	a5,-81(s0)
 140:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 144:	01578763          	beq	a5,s5,152 <gets+0x54>
 148:	0905                	addi	s2,s2,1
 14a:	fd679be3          	bne	a5,s6,120 <gets+0x22>
  for(i=0; i+1 < max; ){
 14e:	89a6                	mv	s3,s1
 150:	a011                	j	154 <gets+0x56>
 152:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 154:	99de                	add	s3,s3,s7
 156:	00098023          	sb	zero,0(s3)
  return buf;
}
 15a:	855e                	mv	a0,s7
 15c:	60e6                	ld	ra,88(sp)
 15e:	6446                	ld	s0,80(sp)
 160:	64a6                	ld	s1,72(sp)
 162:	6906                	ld	s2,64(sp)
 164:	79e2                	ld	s3,56(sp)
 166:	7a42                	ld	s4,48(sp)
 168:	7aa2                	ld	s5,40(sp)
 16a:	7b02                	ld	s6,32(sp)
 16c:	6be2                	ld	s7,24(sp)
 16e:	6125                	addi	sp,sp,96
 170:	8082                	ret

0000000000000172 <stat>:

int
stat(const char *n, struct stat *st)
{
 172:	1101                	addi	sp,sp,-32
 174:	ec06                	sd	ra,24(sp)
 176:	e822                	sd	s0,16(sp)
 178:	e426                	sd	s1,8(sp)
 17a:	e04a                	sd	s2,0(sp)
 17c:	1000                	addi	s0,sp,32
 17e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 180:	4581                	li	a1,0
 182:	00000097          	auipc	ra,0x0
 186:	18c080e7          	jalr	396(ra) # 30e <open>
  if(fd < 0)
 18a:	02054563          	bltz	a0,1b4 <stat+0x42>
 18e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 190:	85ca                	mv	a1,s2
 192:	00000097          	auipc	ra,0x0
 196:	194080e7          	jalr	404(ra) # 326 <fstat>
 19a:	892a                	mv	s2,a0
  close(fd);
 19c:	8526                	mv	a0,s1
 19e:	00000097          	auipc	ra,0x0
 1a2:	158080e7          	jalr	344(ra) # 2f6 <close>
  return r;
}
 1a6:	854a                	mv	a0,s2
 1a8:	60e2                	ld	ra,24(sp)
 1aa:	6442                	ld	s0,16(sp)
 1ac:	64a2                	ld	s1,8(sp)
 1ae:	6902                	ld	s2,0(sp)
 1b0:	6105                	addi	sp,sp,32
 1b2:	8082                	ret
    return -1;
 1b4:	597d                	li	s2,-1
 1b6:	bfc5                	j	1a6 <stat+0x34>

00000000000001b8 <atoi>:

int
atoi(const char *s)
{
 1b8:	1141                	addi	sp,sp,-16
 1ba:	e422                	sd	s0,8(sp)
 1bc:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1be:	00054603          	lbu	a2,0(a0)
 1c2:	fd06079b          	addiw	a5,a2,-48
 1c6:	0ff7f793          	andi	a5,a5,255
 1ca:	4725                	li	a4,9
 1cc:	02f76963          	bltu	a4,a5,1fe <atoi+0x46>
 1d0:	86aa                	mv	a3,a0
  n = 0;
 1d2:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 1d4:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 1d6:	0685                	addi	a3,a3,1
 1d8:	0025179b          	slliw	a5,a0,0x2
 1dc:	9fa9                	addw	a5,a5,a0
 1de:	0017979b          	slliw	a5,a5,0x1
 1e2:	9fb1                	addw	a5,a5,a2
 1e4:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1e8:	0006c603          	lbu	a2,0(a3)
 1ec:	fd06071b          	addiw	a4,a2,-48
 1f0:	0ff77713          	andi	a4,a4,255
 1f4:	fee5f1e3          	bgeu	a1,a4,1d6 <atoi+0x1e>
  return n;
}
 1f8:	6422                	ld	s0,8(sp)
 1fa:	0141                	addi	sp,sp,16
 1fc:	8082                	ret
  n = 0;
 1fe:	4501                	li	a0,0
 200:	bfe5                	j	1f8 <atoi+0x40>

0000000000000202 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 202:	1141                	addi	sp,sp,-16
 204:	e422                	sd	s0,8(sp)
 206:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 208:	02b57663          	bgeu	a0,a1,234 <memmove+0x32>
    while(n-- > 0)
 20c:	02c05163          	blez	a2,22e <memmove+0x2c>
 210:	fff6079b          	addiw	a5,a2,-1
 214:	1782                	slli	a5,a5,0x20
 216:	9381                	srli	a5,a5,0x20
 218:	0785                	addi	a5,a5,1
 21a:	97aa                	add	a5,a5,a0
  dst = vdst;
 21c:	872a                	mv	a4,a0
      *dst++ = *src++;
 21e:	0585                	addi	a1,a1,1
 220:	0705                	addi	a4,a4,1
 222:	fff5c683          	lbu	a3,-1(a1)
 226:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 22a:	fee79ae3          	bne	a5,a4,21e <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 22e:	6422                	ld	s0,8(sp)
 230:	0141                	addi	sp,sp,16
 232:	8082                	ret
    dst += n;
 234:	00c50733          	add	a4,a0,a2
    src += n;
 238:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 23a:	fec05ae3          	blez	a2,22e <memmove+0x2c>
 23e:	fff6079b          	addiw	a5,a2,-1
 242:	1782                	slli	a5,a5,0x20
 244:	9381                	srli	a5,a5,0x20
 246:	fff7c793          	not	a5,a5
 24a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 24c:	15fd                	addi	a1,a1,-1
 24e:	177d                	addi	a4,a4,-1
 250:	0005c683          	lbu	a3,0(a1)
 254:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 258:	fee79ae3          	bne	a5,a4,24c <memmove+0x4a>
 25c:	bfc9                	j	22e <memmove+0x2c>

000000000000025e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 25e:	1141                	addi	sp,sp,-16
 260:	e422                	sd	s0,8(sp)
 262:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 264:	ca05                	beqz	a2,294 <memcmp+0x36>
 266:	fff6069b          	addiw	a3,a2,-1
 26a:	1682                	slli	a3,a3,0x20
 26c:	9281                	srli	a3,a3,0x20
 26e:	0685                	addi	a3,a3,1
 270:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 272:	00054783          	lbu	a5,0(a0)
 276:	0005c703          	lbu	a4,0(a1)
 27a:	00e79863          	bne	a5,a4,28a <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 27e:	0505                	addi	a0,a0,1
    p2++;
 280:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 282:	fed518e3          	bne	a0,a3,272 <memcmp+0x14>
  }
  return 0;
 286:	4501                	li	a0,0
 288:	a019                	j	28e <memcmp+0x30>
      return *p1 - *p2;
 28a:	40e7853b          	subw	a0,a5,a4
}
 28e:	6422                	ld	s0,8(sp)
 290:	0141                	addi	sp,sp,16
 292:	8082                	ret
  return 0;
 294:	4501                	li	a0,0
 296:	bfe5                	j	28e <memcmp+0x30>

0000000000000298 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 298:	1141                	addi	sp,sp,-16
 29a:	e406                	sd	ra,8(sp)
 29c:	e022                	sd	s0,0(sp)
 29e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2a0:	00000097          	auipc	ra,0x0
 2a4:	f62080e7          	jalr	-158(ra) # 202 <memmove>
}
 2a8:	60a2                	ld	ra,8(sp)
 2aa:	6402                	ld	s0,0(sp)
 2ac:	0141                	addi	sp,sp,16
 2ae:	8082                	ret

00000000000002b0 <ugetpid>:

#ifdef LAB_PGTBL
int
ugetpid(void)
{
 2b0:	1141                	addi	sp,sp,-16
 2b2:	e422                	sd	s0,8(sp)
 2b4:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 2b6:	040007b7          	lui	a5,0x4000
}
 2ba:	17f5                	addi	a5,a5,-3
 2bc:	07b2                	slli	a5,a5,0xc
 2be:	4388                	lw	a0,0(a5)
 2c0:	6422                	ld	s0,8(sp)
 2c2:	0141                	addi	sp,sp,16
 2c4:	8082                	ret

00000000000002c6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2c6:	4885                	li	a7,1
 ecall
 2c8:	00000073          	ecall
 ret
 2cc:	8082                	ret

00000000000002ce <exit>:
.global exit
exit:
 li a7, SYS_exit
 2ce:	4889                	li	a7,2
 ecall
 2d0:	00000073          	ecall
 ret
 2d4:	8082                	ret

00000000000002d6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 2d6:	488d                	li	a7,3
 ecall
 2d8:	00000073          	ecall
 ret
 2dc:	8082                	ret

00000000000002de <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 2de:	4891                	li	a7,4
 ecall
 2e0:	00000073          	ecall
 ret
 2e4:	8082                	ret

00000000000002e6 <read>:
.global read
read:
 li a7, SYS_read
 2e6:	4895                	li	a7,5
 ecall
 2e8:	00000073          	ecall
 ret
 2ec:	8082                	ret

00000000000002ee <write>:
.global write
write:
 li a7, SYS_write
 2ee:	48c1                	li	a7,16
 ecall
 2f0:	00000073          	ecall
 ret
 2f4:	8082                	ret

00000000000002f6 <close>:
.global close
close:
 li a7, SYS_close
 2f6:	48d5                	li	a7,21
 ecall
 2f8:	00000073          	ecall
 ret
 2fc:	8082                	ret

00000000000002fe <kill>:
.global kill
kill:
 li a7, SYS_kill
 2fe:	4899                	li	a7,6
 ecall
 300:	00000073          	ecall
 ret
 304:	8082                	ret

0000000000000306 <exec>:
.global exec
exec:
 li a7, SYS_exec
 306:	489d                	li	a7,7
 ecall
 308:	00000073          	ecall
 ret
 30c:	8082                	ret

000000000000030e <open>:
.global open
open:
 li a7, SYS_open
 30e:	48bd                	li	a7,15
 ecall
 310:	00000073          	ecall
 ret
 314:	8082                	ret

0000000000000316 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 316:	48c5                	li	a7,17
 ecall
 318:	00000073          	ecall
 ret
 31c:	8082                	ret

000000000000031e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 31e:	48c9                	li	a7,18
 ecall
 320:	00000073          	ecall
 ret
 324:	8082                	ret

0000000000000326 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 326:	48a1                	li	a7,8
 ecall
 328:	00000073          	ecall
 ret
 32c:	8082                	ret

000000000000032e <link>:
.global link
link:
 li a7, SYS_link
 32e:	48cd                	li	a7,19
 ecall
 330:	00000073          	ecall
 ret
 334:	8082                	ret

0000000000000336 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 336:	48d1                	li	a7,20
 ecall
 338:	00000073          	ecall
 ret
 33c:	8082                	ret

000000000000033e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 33e:	48a5                	li	a7,9
 ecall
 340:	00000073          	ecall
 ret
 344:	8082                	ret

0000000000000346 <dup>:
.global dup
dup:
 li a7, SYS_dup
 346:	48a9                	li	a7,10
 ecall
 348:	00000073          	ecall
 ret
 34c:	8082                	ret

000000000000034e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 34e:	48ad                	li	a7,11
 ecall
 350:	00000073          	ecall
 ret
 354:	8082                	ret

0000000000000356 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 356:	48b1                	li	a7,12
 ecall
 358:	00000073          	ecall
 ret
 35c:	8082                	ret

000000000000035e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 35e:	48b5                	li	a7,13
 ecall
 360:	00000073          	ecall
 ret
 364:	8082                	ret

0000000000000366 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 366:	48b9                	li	a7,14
 ecall
 368:	00000073          	ecall
 ret
 36c:	8082                	ret

000000000000036e <connect>:
.global connect
connect:
 li a7, SYS_connect
 36e:	48f5                	li	a7,29
 ecall
 370:	00000073          	ecall
 ret
 374:	8082                	ret

0000000000000376 <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 376:	48f9                	li	a7,30
 ecall
 378:	00000073          	ecall
 ret
 37c:	8082                	ret

000000000000037e <vmprint>:
.global vmprint
vmprint:
 li a7, SYS_vmprint
 37e:	48fd                	li	a7,31
 ecall
 380:	00000073          	ecall
 ret
 384:	8082                	ret

0000000000000386 <madvise>:
.global madvise
madvise:
 li a7, SYS_madvise
 386:	02000893          	li	a7,32
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <pgprint>:
.global pgprint
pgprint:
 li a7, SYS_pgprint
 390:	02100893          	li	a7,33
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 39a:	1101                	addi	sp,sp,-32
 39c:	ec06                	sd	ra,24(sp)
 39e:	e822                	sd	s0,16(sp)
 3a0:	1000                	addi	s0,sp,32
 3a2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3a6:	4605                	li	a2,1
 3a8:	fef40593          	addi	a1,s0,-17
 3ac:	00000097          	auipc	ra,0x0
 3b0:	f42080e7          	jalr	-190(ra) # 2ee <write>
}
 3b4:	60e2                	ld	ra,24(sp)
 3b6:	6442                	ld	s0,16(sp)
 3b8:	6105                	addi	sp,sp,32
 3ba:	8082                	ret

00000000000003bc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3bc:	7139                	addi	sp,sp,-64
 3be:	fc06                	sd	ra,56(sp)
 3c0:	f822                	sd	s0,48(sp)
 3c2:	f426                	sd	s1,40(sp)
 3c4:	f04a                	sd	s2,32(sp)
 3c6:	ec4e                	sd	s3,24(sp)
 3c8:	0080                	addi	s0,sp,64
 3ca:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3cc:	c299                	beqz	a3,3d2 <printint+0x16>
 3ce:	0805c863          	bltz	a1,45e <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3d2:	2581                	sext.w	a1,a1
  neg = 0;
 3d4:	4881                	li	a7,0
 3d6:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 3da:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 3dc:	2601                	sext.w	a2,a2
 3de:	00000517          	auipc	a0,0x0
 3e2:	44250513          	addi	a0,a0,1090 # 820 <digits>
 3e6:	883a                	mv	a6,a4
 3e8:	2705                	addiw	a4,a4,1
 3ea:	02c5f7bb          	remuw	a5,a1,a2
 3ee:	1782                	slli	a5,a5,0x20
 3f0:	9381                	srli	a5,a5,0x20
 3f2:	97aa                	add	a5,a5,a0
 3f4:	0007c783          	lbu	a5,0(a5) # 4000000 <__global_pointer$+0x3ffefcf>
 3f8:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 3fc:	0005879b          	sext.w	a5,a1
 400:	02c5d5bb          	divuw	a1,a1,a2
 404:	0685                	addi	a3,a3,1
 406:	fec7f0e3          	bgeu	a5,a2,3e6 <printint+0x2a>
  if(neg)
 40a:	00088b63          	beqz	a7,420 <printint+0x64>
    buf[i++] = '-';
 40e:	fd040793          	addi	a5,s0,-48
 412:	973e                	add	a4,a4,a5
 414:	02d00793          	li	a5,45
 418:	fef70823          	sb	a5,-16(a4)
 41c:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 420:	02e05863          	blez	a4,450 <printint+0x94>
 424:	fc040793          	addi	a5,s0,-64
 428:	00e78933          	add	s2,a5,a4
 42c:	fff78993          	addi	s3,a5,-1
 430:	99ba                	add	s3,s3,a4
 432:	377d                	addiw	a4,a4,-1
 434:	1702                	slli	a4,a4,0x20
 436:	9301                	srli	a4,a4,0x20
 438:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 43c:	fff94583          	lbu	a1,-1(s2)
 440:	8526                	mv	a0,s1
 442:	00000097          	auipc	ra,0x0
 446:	f58080e7          	jalr	-168(ra) # 39a <putc>
  while(--i >= 0)
 44a:	197d                	addi	s2,s2,-1
 44c:	ff3918e3          	bne	s2,s3,43c <printint+0x80>
}
 450:	70e2                	ld	ra,56(sp)
 452:	7442                	ld	s0,48(sp)
 454:	74a2                	ld	s1,40(sp)
 456:	7902                	ld	s2,32(sp)
 458:	69e2                	ld	s3,24(sp)
 45a:	6121                	addi	sp,sp,64
 45c:	8082                	ret
    x = -xx;
 45e:	40b005bb          	negw	a1,a1
    neg = 1;
 462:	4885                	li	a7,1
    x = -xx;
 464:	bf8d                	j	3d6 <printint+0x1a>

0000000000000466 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 466:	7119                	addi	sp,sp,-128
 468:	fc86                	sd	ra,120(sp)
 46a:	f8a2                	sd	s0,112(sp)
 46c:	f4a6                	sd	s1,104(sp)
 46e:	f0ca                	sd	s2,96(sp)
 470:	ecce                	sd	s3,88(sp)
 472:	e8d2                	sd	s4,80(sp)
 474:	e4d6                	sd	s5,72(sp)
 476:	e0da                	sd	s6,64(sp)
 478:	fc5e                	sd	s7,56(sp)
 47a:	f862                	sd	s8,48(sp)
 47c:	f466                	sd	s9,40(sp)
 47e:	f06a                	sd	s10,32(sp)
 480:	ec6e                	sd	s11,24(sp)
 482:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 484:	0005c903          	lbu	s2,0(a1)
 488:	18090f63          	beqz	s2,626 <vprintf+0x1c0>
 48c:	8aaa                	mv	s5,a0
 48e:	8b32                	mv	s6,a2
 490:	00158493          	addi	s1,a1,1
  state = 0;
 494:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 496:	02500a13          	li	s4,37
      if(c == 'd'){
 49a:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 49e:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 4a2:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 4a6:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 4aa:	00000b97          	auipc	s7,0x0
 4ae:	376b8b93          	addi	s7,s7,886 # 820 <digits>
 4b2:	a839                	j	4d0 <vprintf+0x6a>
        putc(fd, c);
 4b4:	85ca                	mv	a1,s2
 4b6:	8556                	mv	a0,s5
 4b8:	00000097          	auipc	ra,0x0
 4bc:	ee2080e7          	jalr	-286(ra) # 39a <putc>
 4c0:	a019                	j	4c6 <vprintf+0x60>
    } else if(state == '%'){
 4c2:	01498f63          	beq	s3,s4,4e0 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 4c6:	0485                	addi	s1,s1,1
 4c8:	fff4c903          	lbu	s2,-1(s1)
 4cc:	14090d63          	beqz	s2,626 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 4d0:	0009079b          	sext.w	a5,s2
    if(state == 0){
 4d4:	fe0997e3          	bnez	s3,4c2 <vprintf+0x5c>
      if(c == '%'){
 4d8:	fd479ee3          	bne	a5,s4,4b4 <vprintf+0x4e>
        state = '%';
 4dc:	89be                	mv	s3,a5
 4de:	b7e5                	j	4c6 <vprintf+0x60>
      if(c == 'd'){
 4e0:	05878063          	beq	a5,s8,520 <vprintf+0xba>
      } else if(c == 'l') {
 4e4:	05978c63          	beq	a5,s9,53c <vprintf+0xd6>
      } else if(c == 'x') {
 4e8:	07a78863          	beq	a5,s10,558 <vprintf+0xf2>
      } else if(c == 'p') {
 4ec:	09b78463          	beq	a5,s11,574 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 4f0:	07300713          	li	a4,115
 4f4:	0ce78663          	beq	a5,a4,5c0 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4f8:	06300713          	li	a4,99
 4fc:	0ee78e63          	beq	a5,a4,5f8 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 500:	11478863          	beq	a5,s4,610 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 504:	85d2                	mv	a1,s4
 506:	8556                	mv	a0,s5
 508:	00000097          	auipc	ra,0x0
 50c:	e92080e7          	jalr	-366(ra) # 39a <putc>
        putc(fd, c);
 510:	85ca                	mv	a1,s2
 512:	8556                	mv	a0,s5
 514:	00000097          	auipc	ra,0x0
 518:	e86080e7          	jalr	-378(ra) # 39a <putc>
      }
      state = 0;
 51c:	4981                	li	s3,0
 51e:	b765                	j	4c6 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 520:	008b0913          	addi	s2,s6,8
 524:	4685                	li	a3,1
 526:	4629                	li	a2,10
 528:	000b2583          	lw	a1,0(s6)
 52c:	8556                	mv	a0,s5
 52e:	00000097          	auipc	ra,0x0
 532:	e8e080e7          	jalr	-370(ra) # 3bc <printint>
 536:	8b4a                	mv	s6,s2
      state = 0;
 538:	4981                	li	s3,0
 53a:	b771                	j	4c6 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 53c:	008b0913          	addi	s2,s6,8
 540:	4681                	li	a3,0
 542:	4629                	li	a2,10
 544:	000b2583          	lw	a1,0(s6)
 548:	8556                	mv	a0,s5
 54a:	00000097          	auipc	ra,0x0
 54e:	e72080e7          	jalr	-398(ra) # 3bc <printint>
 552:	8b4a                	mv	s6,s2
      state = 0;
 554:	4981                	li	s3,0
 556:	bf85                	j	4c6 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 558:	008b0913          	addi	s2,s6,8
 55c:	4681                	li	a3,0
 55e:	4641                	li	a2,16
 560:	000b2583          	lw	a1,0(s6)
 564:	8556                	mv	a0,s5
 566:	00000097          	auipc	ra,0x0
 56a:	e56080e7          	jalr	-426(ra) # 3bc <printint>
 56e:	8b4a                	mv	s6,s2
      state = 0;
 570:	4981                	li	s3,0
 572:	bf91                	j	4c6 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 574:	008b0793          	addi	a5,s6,8
 578:	f8f43423          	sd	a5,-120(s0)
 57c:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 580:	03000593          	li	a1,48
 584:	8556                	mv	a0,s5
 586:	00000097          	auipc	ra,0x0
 58a:	e14080e7          	jalr	-492(ra) # 39a <putc>
  putc(fd, 'x');
 58e:	85ea                	mv	a1,s10
 590:	8556                	mv	a0,s5
 592:	00000097          	auipc	ra,0x0
 596:	e08080e7          	jalr	-504(ra) # 39a <putc>
 59a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 59c:	03c9d793          	srli	a5,s3,0x3c
 5a0:	97de                	add	a5,a5,s7
 5a2:	0007c583          	lbu	a1,0(a5)
 5a6:	8556                	mv	a0,s5
 5a8:	00000097          	auipc	ra,0x0
 5ac:	df2080e7          	jalr	-526(ra) # 39a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 5b0:	0992                	slli	s3,s3,0x4
 5b2:	397d                	addiw	s2,s2,-1
 5b4:	fe0914e3          	bnez	s2,59c <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 5b8:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 5bc:	4981                	li	s3,0
 5be:	b721                	j	4c6 <vprintf+0x60>
        s = va_arg(ap, char*);
 5c0:	008b0993          	addi	s3,s6,8
 5c4:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 5c8:	02090163          	beqz	s2,5ea <vprintf+0x184>
        while(*s != 0){
 5cc:	00094583          	lbu	a1,0(s2)
 5d0:	c9a1                	beqz	a1,620 <vprintf+0x1ba>
          putc(fd, *s);
 5d2:	8556                	mv	a0,s5
 5d4:	00000097          	auipc	ra,0x0
 5d8:	dc6080e7          	jalr	-570(ra) # 39a <putc>
          s++;
 5dc:	0905                	addi	s2,s2,1
        while(*s != 0){
 5de:	00094583          	lbu	a1,0(s2)
 5e2:	f9e5                	bnez	a1,5d2 <vprintf+0x16c>
        s = va_arg(ap, char*);
 5e4:	8b4e                	mv	s6,s3
      state = 0;
 5e6:	4981                	li	s3,0
 5e8:	bdf9                	j	4c6 <vprintf+0x60>
          s = "(null)";
 5ea:	00000917          	auipc	s2,0x0
 5ee:	22e90913          	addi	s2,s2,558 # 818 <malloc+0xe8>
        while(*s != 0){
 5f2:	02800593          	li	a1,40
 5f6:	bff1                	j	5d2 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 5f8:	008b0913          	addi	s2,s6,8
 5fc:	000b4583          	lbu	a1,0(s6)
 600:	8556                	mv	a0,s5
 602:	00000097          	auipc	ra,0x0
 606:	d98080e7          	jalr	-616(ra) # 39a <putc>
 60a:	8b4a                	mv	s6,s2
      state = 0;
 60c:	4981                	li	s3,0
 60e:	bd65                	j	4c6 <vprintf+0x60>
        putc(fd, c);
 610:	85d2                	mv	a1,s4
 612:	8556                	mv	a0,s5
 614:	00000097          	auipc	ra,0x0
 618:	d86080e7          	jalr	-634(ra) # 39a <putc>
      state = 0;
 61c:	4981                	li	s3,0
 61e:	b565                	j	4c6 <vprintf+0x60>
        s = va_arg(ap, char*);
 620:	8b4e                	mv	s6,s3
      state = 0;
 622:	4981                	li	s3,0
 624:	b54d                	j	4c6 <vprintf+0x60>
    }
  }
}
 626:	70e6                	ld	ra,120(sp)
 628:	7446                	ld	s0,112(sp)
 62a:	74a6                	ld	s1,104(sp)
 62c:	7906                	ld	s2,96(sp)
 62e:	69e6                	ld	s3,88(sp)
 630:	6a46                	ld	s4,80(sp)
 632:	6aa6                	ld	s5,72(sp)
 634:	6b06                	ld	s6,64(sp)
 636:	7be2                	ld	s7,56(sp)
 638:	7c42                	ld	s8,48(sp)
 63a:	7ca2                	ld	s9,40(sp)
 63c:	7d02                	ld	s10,32(sp)
 63e:	6de2                	ld	s11,24(sp)
 640:	6109                	addi	sp,sp,128
 642:	8082                	ret

0000000000000644 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 644:	715d                	addi	sp,sp,-80
 646:	ec06                	sd	ra,24(sp)
 648:	e822                	sd	s0,16(sp)
 64a:	1000                	addi	s0,sp,32
 64c:	e010                	sd	a2,0(s0)
 64e:	e414                	sd	a3,8(s0)
 650:	e818                	sd	a4,16(s0)
 652:	ec1c                	sd	a5,24(s0)
 654:	03043023          	sd	a6,32(s0)
 658:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 65c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 660:	8622                	mv	a2,s0
 662:	00000097          	auipc	ra,0x0
 666:	e04080e7          	jalr	-508(ra) # 466 <vprintf>
}
 66a:	60e2                	ld	ra,24(sp)
 66c:	6442                	ld	s0,16(sp)
 66e:	6161                	addi	sp,sp,80
 670:	8082                	ret

0000000000000672 <printf>:

void
printf(const char *fmt, ...)
{
 672:	711d                	addi	sp,sp,-96
 674:	ec06                	sd	ra,24(sp)
 676:	e822                	sd	s0,16(sp)
 678:	1000                	addi	s0,sp,32
 67a:	e40c                	sd	a1,8(s0)
 67c:	e810                	sd	a2,16(s0)
 67e:	ec14                	sd	a3,24(s0)
 680:	f018                	sd	a4,32(s0)
 682:	f41c                	sd	a5,40(s0)
 684:	03043823          	sd	a6,48(s0)
 688:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 68c:	00840613          	addi	a2,s0,8
 690:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 694:	85aa                	mv	a1,a0
 696:	4505                	li	a0,1
 698:	00000097          	auipc	ra,0x0
 69c:	dce080e7          	jalr	-562(ra) # 466 <vprintf>
}
 6a0:	60e2                	ld	ra,24(sp)
 6a2:	6442                	ld	s0,16(sp)
 6a4:	6125                	addi	sp,sp,96
 6a6:	8082                	ret

00000000000006a8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6a8:	1141                	addi	sp,sp,-16
 6aa:	e422                	sd	s0,8(sp)
 6ac:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6ae:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6b2:	00000797          	auipc	a5,0x0
 6b6:	1867b783          	ld	a5,390(a5) # 838 <freep>
 6ba:	a805                	j	6ea <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6bc:	4618                	lw	a4,8(a2)
 6be:	9db9                	addw	a1,a1,a4
 6c0:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 6c4:	6398                	ld	a4,0(a5)
 6c6:	6318                	ld	a4,0(a4)
 6c8:	fee53823          	sd	a4,-16(a0)
 6cc:	a091                	j	710 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 6ce:	ff852703          	lw	a4,-8(a0)
 6d2:	9e39                	addw	a2,a2,a4
 6d4:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 6d6:	ff053703          	ld	a4,-16(a0)
 6da:	e398                	sd	a4,0(a5)
 6dc:	a099                	j	722 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6de:	6398                	ld	a4,0(a5)
 6e0:	00e7e463          	bltu	a5,a4,6e8 <free+0x40>
 6e4:	00e6ea63          	bltu	a3,a4,6f8 <free+0x50>
{
 6e8:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6ea:	fed7fae3          	bgeu	a5,a3,6de <free+0x36>
 6ee:	6398                	ld	a4,0(a5)
 6f0:	00e6e463          	bltu	a3,a4,6f8 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6f4:	fee7eae3          	bltu	a5,a4,6e8 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 6f8:	ff852583          	lw	a1,-8(a0)
 6fc:	6390                	ld	a2,0(a5)
 6fe:	02059713          	slli	a4,a1,0x20
 702:	9301                	srli	a4,a4,0x20
 704:	0712                	slli	a4,a4,0x4
 706:	9736                	add	a4,a4,a3
 708:	fae60ae3          	beq	a2,a4,6bc <free+0x14>
    bp->s.ptr = p->s.ptr;
 70c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 710:	4790                	lw	a2,8(a5)
 712:	02061713          	slli	a4,a2,0x20
 716:	9301                	srli	a4,a4,0x20
 718:	0712                	slli	a4,a4,0x4
 71a:	973e                	add	a4,a4,a5
 71c:	fae689e3          	beq	a3,a4,6ce <free+0x26>
  } else
    p->s.ptr = bp;
 720:	e394                	sd	a3,0(a5)
  freep = p;
 722:	00000717          	auipc	a4,0x0
 726:	10f73b23          	sd	a5,278(a4) # 838 <freep>
}
 72a:	6422                	ld	s0,8(sp)
 72c:	0141                	addi	sp,sp,16
 72e:	8082                	ret

0000000000000730 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 730:	7139                	addi	sp,sp,-64
 732:	fc06                	sd	ra,56(sp)
 734:	f822                	sd	s0,48(sp)
 736:	f426                	sd	s1,40(sp)
 738:	f04a                	sd	s2,32(sp)
 73a:	ec4e                	sd	s3,24(sp)
 73c:	e852                	sd	s4,16(sp)
 73e:	e456                	sd	s5,8(sp)
 740:	e05a                	sd	s6,0(sp)
 742:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 744:	02051493          	slli	s1,a0,0x20
 748:	9081                	srli	s1,s1,0x20
 74a:	04bd                	addi	s1,s1,15
 74c:	8091                	srli	s1,s1,0x4
 74e:	0014899b          	addiw	s3,s1,1
 752:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 754:	00000797          	auipc	a5,0x0
 758:	0e47b783          	ld	a5,228(a5) # 838 <freep>
 75c:	c795                	beqz	a5,788 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 75e:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
 760:	4518                	lw	a4,8(a0)
 762:	02977f63          	bgeu	a4,s1,7a0 <malloc+0x70>
 766:	8a4e                	mv	s4,s3
 768:	0009879b          	sext.w	a5,s3
 76c:	6705                	lui	a4,0x1
 76e:	00e7f363          	bgeu	a5,a4,774 <malloc+0x44>
 772:	6a05                	lui	s4,0x1
 774:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 778:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p);
    }
    if(p == freep)
 77c:	00000917          	auipc	s2,0x0
 780:	0bc90913          	addi	s2,s2,188 # 838 <freep>
  if(p == (char*)-1)
 784:	5afd                	li	s5,-1
 786:	a0bd                	j	7f4 <malloc+0xc4>
    base.s.ptr = freep = prevp = &base;
 788:	00000517          	auipc	a0,0x0
 78c:	0b850513          	addi	a0,a0,184 # 840 <base>
 790:	00000797          	auipc	a5,0x0
 794:	0aa7b423          	sd	a0,168(a5) # 838 <freep>
 798:	e108                	sd	a0,0(a0)
    base.s.size = 0;
 79a:	00052423          	sw	zero,8(a0)
    if(p->s.size >= nunits){
 79e:	b7e1                	j	766 <malloc+0x36>
      if(p->s.size == nunits)
 7a0:	02e48963          	beq	s1,a4,7d2 <malloc+0xa2>
        p->s.size -= nunits;
 7a4:	4137073b          	subw	a4,a4,s3
 7a8:	c518                	sw	a4,8(a0)
        p += p->s.size;
 7aa:	1702                	slli	a4,a4,0x20
 7ac:	9301                	srli	a4,a4,0x20
 7ae:	0712                	slli	a4,a4,0x4
 7b0:	953a                	add	a0,a0,a4
        p->s.size = nunits;
 7b2:	01352423          	sw	s3,8(a0)
      freep = prevp;
 7b6:	00000717          	auipc	a4,0x0
 7ba:	08f73123          	sd	a5,130(a4) # 838 <freep>
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 7be:	70e2                	ld	ra,56(sp)
 7c0:	7442                	ld	s0,48(sp)
 7c2:	74a2                	ld	s1,40(sp)
 7c4:	7902                	ld	s2,32(sp)
 7c6:	69e2                	ld	s3,24(sp)
 7c8:	6a42                	ld	s4,16(sp)
 7ca:	6aa2                	ld	s5,8(sp)
 7cc:	6b02                	ld	s6,0(sp)
 7ce:	6121                	addi	sp,sp,64
 7d0:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 7d2:	6118                	ld	a4,0(a0)
 7d4:	e398                	sd	a4,0(a5)
 7d6:	b7c5                	j	7b6 <malloc+0x86>
  hp->s.size = nu;
 7d8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 7dc:	0541                	addi	a0,a0,16
 7de:	00000097          	auipc	ra,0x0
 7e2:	eca080e7          	jalr	-310(ra) # 6a8 <free>
  return freep;
 7e6:	00093783          	ld	a5,0(s2)
      if((p = morecore(nunits)) == 0)
 7ea:	c39d                	beqz	a5,810 <malloc+0xe0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7ec:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
 7ee:	4518                	lw	a4,8(a0)
 7f0:	fa9778e3          	bgeu	a4,s1,7a0 <malloc+0x70>
    if(p == freep)
 7f4:	00093703          	ld	a4,0(s2)
 7f8:	87aa                	mv	a5,a0
 7fa:	fea719e3          	bne	a4,a0,7ec <malloc+0xbc>
  p = sbrk(nu * sizeof(Header));
 7fe:	8552                	mv	a0,s4
 800:	00000097          	auipc	ra,0x0
 804:	b56080e7          	jalr	-1194(ra) # 356 <sbrk>
  if(p == (char*)-1)
 808:	fd5518e3          	bne	a0,s5,7d8 <malloc+0xa8>
        return 0;
 80c:	4501                	li	a0,0
 80e:	bf45                	j	7be <malloc+0x8e>
 810:	853e                	mv	a0,a5
 812:	b775                	j	7be <malloc+0x8e>
