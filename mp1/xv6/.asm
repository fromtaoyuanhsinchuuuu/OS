
user/_custom-10:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fib>:
#define NULL 0

static struct thread *t;
static int cnt = 0;

void fib(void *arg) {
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
    cnt++;
   e:	00001797          	auipc	a5,0x1
  12:	d6a78793          	addi	a5,a5,-662 # d78 <cnt>
  16:	4390                	lw	a2,0(a5)
  18:	2605                	addiw	a2,a2,1
  1a:	c390                	sw	a2,0(a5)
    int k2 = (unsigned long)arg;
    int l = k2 / 1000;
  1c:	3e800493          	li	s1,1000
  20:	0295493b          	divw	s2,a0,s1
    int k = k2 % 1000;
  24:	029564bb          	remw	s1,a0,s1
    printf("fib %d %d %d\n", l, cnt, k);
  28:	0004869b          	sext.w	a3,s1
  2c:	2601                	sext.w	a2,a2
  2e:	0009059b          	sext.w	a1,s2
  32:	00001517          	auipc	a0,0x1
  36:	cf650513          	addi	a0,a0,-778 # d28 <thread_assign_task+0x78>
  3a:	00000097          	auipc	ra,0x0
  3e:	6d2080e7          	jalr	1746(ra) # 70c <printf>
    if(k % 2 == 0) return;
  42:	0014f793          	andi	a5,s1,1
  46:	c7b5                	beqz	a5,b2 <fib+0xb2>
  48:	0004871b          	sext.w	a4,s1

    if (k == 0 || k == 1) {
  4c:	4785                	li	a5,1
  4e:	04e7fe63          	bgeu	a5,a4,aa <fib+0xaa>
        thread_exit();
    } else {
        register void *k1 = (void *)(unsigned long)(k - 1 + 1000 * l);
  52:	3e800613          	li	a2,1000
  56:	0326063b          	mulw	a2,a2,s2
  5a:	fff4899b          	addiw	s3,s1,-1
  5e:	00c989bb          	addw	s3,s3,a2
        register void *k2 = (void *)(unsigned long)(k - 2 + 1000 * l);
  62:	34f9                	addiw	s1,s1,-2
        thread_assign_task(t, fib, k2);
  64:	00001917          	auipc	s2,0x1
  68:	d1c90913          	addi	s2,s2,-740 # d80 <t>
  6c:	9e25                	addw	a2,a2,s1
  6e:	00000597          	auipc	a1,0x0
  72:	f9258593          	addi	a1,a1,-110 # 0 <fib>
  76:	00093503          	ld	a0,0(s2)
  7a:	00001097          	auipc	ra,0x1
  7e:	c36080e7          	jalr	-970(ra) # cb0 <thread_assign_task>
        thread_assign_task(t, fib, k1);
  82:	864e                	mv	a2,s3
  84:	00000597          	auipc	a1,0x0
  88:	f7c58593          	addi	a1,a1,-132 # 0 <fib>
  8c:	00093503          	ld	a0,0(s2)
  90:	00001097          	auipc	ra,0x1
  94:	c20080e7          	jalr	-992(ra) # cb0 <thread_assign_task>
        if((unsigned long)k1 == 726) thread_yield();
  98:	2d600793          	li	a5,726
  9c:	00f99b63          	bne	s3,a5,b2 <fib+0xb2>
  a0:	00001097          	auipc	ra,0x1
  a4:	b5a080e7          	jalr	-1190(ra) # bfa <thread_yield>
  a8:	a029                	j	b2 <fib+0xb2>
        thread_exit();
  aa:	00001097          	auipc	ra,0x1
  ae:	93a080e7          	jalr	-1734(ra) # 9e4 <thread_exit>
        else return;
    }
}
  b2:	70a2                	ld	ra,40(sp)
  b4:	7402                	ld	s0,32(sp)
  b6:	64e2                	ld	s1,24(sp)
  b8:	6942                	ld	s2,16(sp)
  ba:	69a2                	ld	s3,8(sp)
  bc:	6145                	addi	sp,sp,48
  be:	8082                	ret

00000000000000c0 <main>:

int main(int argc, char **argv) {
  c0:	1141                	addi	sp,sp,-16
  c2:	e406                	sd	ra,8(sp)
  c4:	e022                	sd	s0,0(sp)
  c6:	0800                	addi	s0,sp,16
    printf("custom-10\n");
  c8:	00001517          	auipc	a0,0x1
  cc:	c7050513          	addi	a0,a0,-912 # d38 <thread_assign_task+0x88>
  d0:	00000097          	auipc	ra,0x0
  d4:	63c080e7          	jalr	1596(ra) # 70c <printf>
    for (int i = 0; i < 1; i++) {
        t = thread_create(fib, (void *)(unsigned long)(727 + 1000 * i));
  d8:	2d700593          	li	a1,727
  dc:	00000517          	auipc	a0,0x0
  e0:	f2450513          	addi	a0,a0,-220 # 0 <fib>
  e4:	00001097          	auipc	ra,0x1
  e8:	840080e7          	jalr	-1984(ra) # 924 <thread_create>
  ec:	00001797          	auipc	a5,0x1
  f0:	c8a7ba23          	sd	a0,-876(a5) # d80 <t>
        thread_add_runqueue(t);
  f4:	00001097          	auipc	ra,0x1
  f8:	8a0080e7          	jalr	-1888(ra) # 994 <thread_add_runqueue>
        thread_start_threading();
  fc:	00001097          	auipc	ra,0x1
 100:	b80080e7          	jalr	-1152(ra) # c7c <thread_start_threading>
    }
    printf("\nexited\n");
 104:	00001517          	auipc	a0,0x1
 108:	c4450513          	addi	a0,a0,-956 # d48 <thread_assign_task+0x98>
 10c:	00000097          	auipc	ra,0x0
 110:	600080e7          	jalr	1536(ra) # 70c <printf>
    exit(0);
 114:	4501                	li	a0,0
 116:	00000097          	auipc	ra,0x0
 11a:	27e080e7          	jalr	638(ra) # 394 <exit>

000000000000011e <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 11e:	1141                	addi	sp,sp,-16
 120:	e422                	sd	s0,8(sp)
 122:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 124:	87aa                	mv	a5,a0
 126:	0585                	addi	a1,a1,1
 128:	0785                	addi	a5,a5,1
 12a:	fff5c703          	lbu	a4,-1(a1)
 12e:	fee78fa3          	sb	a4,-1(a5)
 132:	fb75                	bnez	a4,126 <strcpy+0x8>
    ;
  return os;
}
 134:	6422                	ld	s0,8(sp)
 136:	0141                	addi	sp,sp,16
 138:	8082                	ret

000000000000013a <strcmp>:

int
strcmp(const char *p, const char *q)
{
 13a:	1141                	addi	sp,sp,-16
 13c:	e422                	sd	s0,8(sp)
 13e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 140:	00054783          	lbu	a5,0(a0)
 144:	cb91                	beqz	a5,158 <strcmp+0x1e>
 146:	0005c703          	lbu	a4,0(a1)
 14a:	00f71763          	bne	a4,a5,158 <strcmp+0x1e>
    p++, q++;
 14e:	0505                	addi	a0,a0,1
 150:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 152:	00054783          	lbu	a5,0(a0)
 156:	fbe5                	bnez	a5,146 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 158:	0005c503          	lbu	a0,0(a1)
}
 15c:	40a7853b          	subw	a0,a5,a0
 160:	6422                	ld	s0,8(sp)
 162:	0141                	addi	sp,sp,16
 164:	8082                	ret

0000000000000166 <strlen>:

uint
strlen(const char *s)
{
 166:	1141                	addi	sp,sp,-16
 168:	e422                	sd	s0,8(sp)
 16a:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 16c:	00054783          	lbu	a5,0(a0)
 170:	cf91                	beqz	a5,18c <strlen+0x26>
 172:	0505                	addi	a0,a0,1
 174:	87aa                	mv	a5,a0
 176:	4685                	li	a3,1
 178:	9e89                	subw	a3,a3,a0
 17a:	00f6853b          	addw	a0,a3,a5
 17e:	0785                	addi	a5,a5,1
 180:	fff7c703          	lbu	a4,-1(a5)
 184:	fb7d                	bnez	a4,17a <strlen+0x14>
    ;
  return n;
}
 186:	6422                	ld	s0,8(sp)
 188:	0141                	addi	sp,sp,16
 18a:	8082                	ret
  for(n = 0; s[n]; n++)
 18c:	4501                	li	a0,0
 18e:	bfe5                	j	186 <strlen+0x20>

0000000000000190 <memset>:

void*
memset(void *dst, int c, uint n)
{
 190:	1141                	addi	sp,sp,-16
 192:	e422                	sd	s0,8(sp)
 194:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 196:	ce09                	beqz	a2,1b0 <memset+0x20>
 198:	87aa                	mv	a5,a0
 19a:	fff6071b          	addiw	a4,a2,-1
 19e:	1702                	slli	a4,a4,0x20
 1a0:	9301                	srli	a4,a4,0x20
 1a2:	0705                	addi	a4,a4,1
 1a4:	972a                	add	a4,a4,a0
    cdst[i] = c;
 1a6:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1aa:	0785                	addi	a5,a5,1
 1ac:	fee79de3          	bne	a5,a4,1a6 <memset+0x16>
  }
  return dst;
}
 1b0:	6422                	ld	s0,8(sp)
 1b2:	0141                	addi	sp,sp,16
 1b4:	8082                	ret

00000000000001b6 <strchr>:

char*
strchr(const char *s, char c)
{
 1b6:	1141                	addi	sp,sp,-16
 1b8:	e422                	sd	s0,8(sp)
 1ba:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1bc:	00054783          	lbu	a5,0(a0)
 1c0:	cb99                	beqz	a5,1d6 <strchr+0x20>
    if(*s == c)
 1c2:	00f58763          	beq	a1,a5,1d0 <strchr+0x1a>
  for(; *s; s++)
 1c6:	0505                	addi	a0,a0,1
 1c8:	00054783          	lbu	a5,0(a0)
 1cc:	fbfd                	bnez	a5,1c2 <strchr+0xc>
      return (char*)s;
  return 0;
 1ce:	4501                	li	a0,0
}
 1d0:	6422                	ld	s0,8(sp)
 1d2:	0141                	addi	sp,sp,16
 1d4:	8082                	ret
  return 0;
 1d6:	4501                	li	a0,0
 1d8:	bfe5                	j	1d0 <strchr+0x1a>

00000000000001da <gets>:

char*
gets(char *buf, int max)
{
 1da:	711d                	addi	sp,sp,-96
 1dc:	ec86                	sd	ra,88(sp)
 1de:	e8a2                	sd	s0,80(sp)
 1e0:	e4a6                	sd	s1,72(sp)
 1e2:	e0ca                	sd	s2,64(sp)
 1e4:	fc4e                	sd	s3,56(sp)
 1e6:	f852                	sd	s4,48(sp)
 1e8:	f456                	sd	s5,40(sp)
 1ea:	f05a                	sd	s6,32(sp)
 1ec:	ec5e                	sd	s7,24(sp)
 1ee:	1080                	addi	s0,sp,96
 1f0:	8baa                	mv	s7,a0
 1f2:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1f4:	892a                	mv	s2,a0
 1f6:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1f8:	4aa9                	li	s5,10
 1fa:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1fc:	89a6                	mv	s3,s1
 1fe:	2485                	addiw	s1,s1,1
 200:	0344d863          	bge	s1,s4,230 <gets+0x56>
    cc = read(0, &c, 1);
 204:	4605                	li	a2,1
 206:	faf40593          	addi	a1,s0,-81
 20a:	4501                	li	a0,0
 20c:	00000097          	auipc	ra,0x0
 210:	1a0080e7          	jalr	416(ra) # 3ac <read>
    if(cc < 1)
 214:	00a05e63          	blez	a0,230 <gets+0x56>
    buf[i++] = c;
 218:	faf44783          	lbu	a5,-81(s0)
 21c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 220:	01578763          	beq	a5,s5,22e <gets+0x54>
 224:	0905                	addi	s2,s2,1
 226:	fd679be3          	bne	a5,s6,1fc <gets+0x22>
  for(i=0; i+1 < max; ){
 22a:	89a6                	mv	s3,s1
 22c:	a011                	j	230 <gets+0x56>
 22e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 230:	99de                	add	s3,s3,s7
 232:	00098023          	sb	zero,0(s3)
  return buf;
}
 236:	855e                	mv	a0,s7
 238:	60e6                	ld	ra,88(sp)
 23a:	6446                	ld	s0,80(sp)
 23c:	64a6                	ld	s1,72(sp)
 23e:	6906                	ld	s2,64(sp)
 240:	79e2                	ld	s3,56(sp)
 242:	7a42                	ld	s4,48(sp)
 244:	7aa2                	ld	s5,40(sp)
 246:	7b02                	ld	s6,32(sp)
 248:	6be2                	ld	s7,24(sp)
 24a:	6125                	addi	sp,sp,96
 24c:	8082                	ret

000000000000024e <stat>:

int
stat(const char *n, struct stat *st)
{
 24e:	1101                	addi	sp,sp,-32
 250:	ec06                	sd	ra,24(sp)
 252:	e822                	sd	s0,16(sp)
 254:	e426                	sd	s1,8(sp)
 256:	e04a                	sd	s2,0(sp)
 258:	1000                	addi	s0,sp,32
 25a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 25c:	4581                	li	a1,0
 25e:	00000097          	auipc	ra,0x0
 262:	176080e7          	jalr	374(ra) # 3d4 <open>
  if(fd < 0)
 266:	02054563          	bltz	a0,290 <stat+0x42>
 26a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 26c:	85ca                	mv	a1,s2
 26e:	00000097          	auipc	ra,0x0
 272:	17e080e7          	jalr	382(ra) # 3ec <fstat>
 276:	892a                	mv	s2,a0
  close(fd);
 278:	8526                	mv	a0,s1
 27a:	00000097          	auipc	ra,0x0
 27e:	142080e7          	jalr	322(ra) # 3bc <close>
  return r;
}
 282:	854a                	mv	a0,s2
 284:	60e2                	ld	ra,24(sp)
 286:	6442                	ld	s0,16(sp)
 288:	64a2                	ld	s1,8(sp)
 28a:	6902                	ld	s2,0(sp)
 28c:	6105                	addi	sp,sp,32
 28e:	8082                	ret
    return -1;
 290:	597d                	li	s2,-1
 292:	bfc5                	j	282 <stat+0x34>

0000000000000294 <atoi>:

int
atoi(const char *s)
{
 294:	1141                	addi	sp,sp,-16
 296:	e422                	sd	s0,8(sp)
 298:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 29a:	00054603          	lbu	a2,0(a0)
 29e:	fd06079b          	addiw	a5,a2,-48
 2a2:	0ff7f793          	andi	a5,a5,255
 2a6:	4725                	li	a4,9
 2a8:	02f76963          	bltu	a4,a5,2da <atoi+0x46>
 2ac:	86aa                	mv	a3,a0
  n = 0;
 2ae:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 2b0:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 2b2:	0685                	addi	a3,a3,1
 2b4:	0025179b          	slliw	a5,a0,0x2
 2b8:	9fa9                	addw	a5,a5,a0
 2ba:	0017979b          	slliw	a5,a5,0x1
 2be:	9fb1                	addw	a5,a5,a2
 2c0:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2c4:	0006c603          	lbu	a2,0(a3)
 2c8:	fd06071b          	addiw	a4,a2,-48
 2cc:	0ff77713          	andi	a4,a4,255
 2d0:	fee5f1e3          	bgeu	a1,a4,2b2 <atoi+0x1e>
  return n;
}
 2d4:	6422                	ld	s0,8(sp)
 2d6:	0141                	addi	sp,sp,16
 2d8:	8082                	ret
  n = 0;
 2da:	4501                	li	a0,0
 2dc:	bfe5                	j	2d4 <atoi+0x40>

00000000000002de <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2de:	1141                	addi	sp,sp,-16
 2e0:	e422                	sd	s0,8(sp)
 2e2:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2e4:	02b57663          	bgeu	a0,a1,310 <memmove+0x32>
    while(n-- > 0)
 2e8:	02c05163          	blez	a2,30a <memmove+0x2c>
 2ec:	fff6079b          	addiw	a5,a2,-1
 2f0:	1782                	slli	a5,a5,0x20
 2f2:	9381                	srli	a5,a5,0x20
 2f4:	0785                	addi	a5,a5,1
 2f6:	97aa                	add	a5,a5,a0
  dst = vdst;
 2f8:	872a                	mv	a4,a0
      *dst++ = *src++;
 2fa:	0585                	addi	a1,a1,1
 2fc:	0705                	addi	a4,a4,1
 2fe:	fff5c683          	lbu	a3,-1(a1)
 302:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 306:	fee79ae3          	bne	a5,a4,2fa <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 30a:	6422                	ld	s0,8(sp)
 30c:	0141                	addi	sp,sp,16
 30e:	8082                	ret
    dst += n;
 310:	00c50733          	add	a4,a0,a2
    src += n;
 314:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 316:	fec05ae3          	blez	a2,30a <memmove+0x2c>
 31a:	fff6079b          	addiw	a5,a2,-1
 31e:	1782                	slli	a5,a5,0x20
 320:	9381                	srli	a5,a5,0x20
 322:	fff7c793          	not	a5,a5
 326:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 328:	15fd                	addi	a1,a1,-1
 32a:	177d                	addi	a4,a4,-1
 32c:	0005c683          	lbu	a3,0(a1)
 330:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 334:	fee79ae3          	bne	a5,a4,328 <memmove+0x4a>
 338:	bfc9                	j	30a <memmove+0x2c>

000000000000033a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 33a:	1141                	addi	sp,sp,-16
 33c:	e422                	sd	s0,8(sp)
 33e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 340:	ca05                	beqz	a2,370 <memcmp+0x36>
 342:	fff6069b          	addiw	a3,a2,-1
 346:	1682                	slli	a3,a3,0x20
 348:	9281                	srli	a3,a3,0x20
 34a:	0685                	addi	a3,a3,1
 34c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 34e:	00054783          	lbu	a5,0(a0)
 352:	0005c703          	lbu	a4,0(a1)
 356:	00e79863          	bne	a5,a4,366 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 35a:	0505                	addi	a0,a0,1
    p2++;
 35c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 35e:	fed518e3          	bne	a0,a3,34e <memcmp+0x14>
  }
  return 0;
 362:	4501                	li	a0,0
 364:	a019                	j	36a <memcmp+0x30>
      return *p1 - *p2;
 366:	40e7853b          	subw	a0,a5,a4
}
 36a:	6422                	ld	s0,8(sp)
 36c:	0141                	addi	sp,sp,16
 36e:	8082                	ret
  return 0;
 370:	4501                	li	a0,0
 372:	bfe5                	j	36a <memcmp+0x30>

0000000000000374 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 374:	1141                	addi	sp,sp,-16
 376:	e406                	sd	ra,8(sp)
 378:	e022                	sd	s0,0(sp)
 37a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 37c:	00000097          	auipc	ra,0x0
 380:	f62080e7          	jalr	-158(ra) # 2de <memmove>
}
 384:	60a2                	ld	ra,8(sp)
 386:	6402                	ld	s0,0(sp)
 388:	0141                	addi	sp,sp,16
 38a:	8082                	ret

000000000000038c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 38c:	4885                	li	a7,1
 ecall
 38e:	00000073          	ecall
 ret
 392:	8082                	ret

0000000000000394 <exit>:
.global exit
exit:
 li a7, SYS_exit
 394:	4889                	li	a7,2
 ecall
 396:	00000073          	ecall
 ret
 39a:	8082                	ret

000000000000039c <wait>:
.global wait
wait:
 li a7, SYS_wait
 39c:	488d                	li	a7,3
 ecall
 39e:	00000073          	ecall
 ret
 3a2:	8082                	ret

00000000000003a4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3a4:	4891                	li	a7,4
 ecall
 3a6:	00000073          	ecall
 ret
 3aa:	8082                	ret

00000000000003ac <read>:
.global read
read:
 li a7, SYS_read
 3ac:	4895                	li	a7,5
 ecall
 3ae:	00000073          	ecall
 ret
 3b2:	8082                	ret

00000000000003b4 <write>:
.global write
write:
 li a7, SYS_write
 3b4:	48c1                	li	a7,16
 ecall
 3b6:	00000073          	ecall
 ret
 3ba:	8082                	ret

00000000000003bc <close>:
.global close
close:
 li a7, SYS_close
 3bc:	48d5                	li	a7,21
 ecall
 3be:	00000073          	ecall
 ret
 3c2:	8082                	ret

00000000000003c4 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3c4:	4899                	li	a7,6
 ecall
 3c6:	00000073          	ecall
 ret
 3ca:	8082                	ret

00000000000003cc <exec>:
.global exec
exec:
 li a7, SYS_exec
 3cc:	489d                	li	a7,7
 ecall
 3ce:	00000073          	ecall
 ret
 3d2:	8082                	ret

00000000000003d4 <open>:
.global open
open:
 li a7, SYS_open
 3d4:	48bd                	li	a7,15
 ecall
 3d6:	00000073          	ecall
 ret
 3da:	8082                	ret

00000000000003dc <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3dc:	48c5                	li	a7,17
 ecall
 3de:	00000073          	ecall
 ret
 3e2:	8082                	ret

00000000000003e4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3e4:	48c9                	li	a7,18
 ecall
 3e6:	00000073          	ecall
 ret
 3ea:	8082                	ret

00000000000003ec <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3ec:	48a1                	li	a7,8
 ecall
 3ee:	00000073          	ecall
 ret
 3f2:	8082                	ret

00000000000003f4 <link>:
.global link
link:
 li a7, SYS_link
 3f4:	48cd                	li	a7,19
 ecall
 3f6:	00000073          	ecall
 ret
 3fa:	8082                	ret

00000000000003fc <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3fc:	48d1                	li	a7,20
 ecall
 3fe:	00000073          	ecall
 ret
 402:	8082                	ret

0000000000000404 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 404:	48a5                	li	a7,9
 ecall
 406:	00000073          	ecall
 ret
 40a:	8082                	ret

000000000000040c <dup>:
.global dup
dup:
 li a7, SYS_dup
 40c:	48a9                	li	a7,10
 ecall
 40e:	00000073          	ecall
 ret
 412:	8082                	ret

0000000000000414 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 414:	48ad                	li	a7,11
 ecall
 416:	00000073          	ecall
 ret
 41a:	8082                	ret

000000000000041c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 41c:	48b1                	li	a7,12
 ecall
 41e:	00000073          	ecall
 ret
 422:	8082                	ret

0000000000000424 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 424:	48b5                	li	a7,13
 ecall
 426:	00000073          	ecall
 ret
 42a:	8082                	ret

000000000000042c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 42c:	48b9                	li	a7,14
 ecall
 42e:	00000073          	ecall
 ret
 432:	8082                	ret

0000000000000434 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 434:	1101                	addi	sp,sp,-32
 436:	ec06                	sd	ra,24(sp)
 438:	e822                	sd	s0,16(sp)
 43a:	1000                	addi	s0,sp,32
 43c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 440:	4605                	li	a2,1
 442:	fef40593          	addi	a1,s0,-17
 446:	00000097          	auipc	ra,0x0
 44a:	f6e080e7          	jalr	-146(ra) # 3b4 <write>
}
 44e:	60e2                	ld	ra,24(sp)
 450:	6442                	ld	s0,16(sp)
 452:	6105                	addi	sp,sp,32
 454:	8082                	ret

0000000000000456 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 456:	7139                	addi	sp,sp,-64
 458:	fc06                	sd	ra,56(sp)
 45a:	f822                	sd	s0,48(sp)
 45c:	f426                	sd	s1,40(sp)
 45e:	f04a                	sd	s2,32(sp)
 460:	ec4e                	sd	s3,24(sp)
 462:	0080                	addi	s0,sp,64
 464:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 466:	c299                	beqz	a3,46c <printint+0x16>
 468:	0805c863          	bltz	a1,4f8 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 46c:	2581                	sext.w	a1,a1
  neg = 0;
 46e:	4881                	li	a7,0
 470:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 474:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 476:	2601                	sext.w	a2,a2
 478:	00001517          	auipc	a0,0x1
 47c:	8e850513          	addi	a0,a0,-1816 # d60 <digits>
 480:	883a                	mv	a6,a4
 482:	2705                	addiw	a4,a4,1
 484:	02c5f7bb          	remuw	a5,a1,a2
 488:	1782                	slli	a5,a5,0x20
 48a:	9381                	srli	a5,a5,0x20
 48c:	97aa                	add	a5,a5,a0
 48e:	0007c783          	lbu	a5,0(a5)
 492:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 496:	0005879b          	sext.w	a5,a1
 49a:	02c5d5bb          	divuw	a1,a1,a2
 49e:	0685                	addi	a3,a3,1
 4a0:	fec7f0e3          	bgeu	a5,a2,480 <printint+0x2a>
  if(neg)
 4a4:	00088b63          	beqz	a7,4ba <printint+0x64>
    buf[i++] = '-';
 4a8:	fd040793          	addi	a5,s0,-48
 4ac:	973e                	add	a4,a4,a5
 4ae:	02d00793          	li	a5,45
 4b2:	fef70823          	sb	a5,-16(a4)
 4b6:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 4ba:	02e05863          	blez	a4,4ea <printint+0x94>
 4be:	fc040793          	addi	a5,s0,-64
 4c2:	00e78933          	add	s2,a5,a4
 4c6:	fff78993          	addi	s3,a5,-1
 4ca:	99ba                	add	s3,s3,a4
 4cc:	377d                	addiw	a4,a4,-1
 4ce:	1702                	slli	a4,a4,0x20
 4d0:	9301                	srli	a4,a4,0x20
 4d2:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 4d6:	fff94583          	lbu	a1,-1(s2)
 4da:	8526                	mv	a0,s1
 4dc:	00000097          	auipc	ra,0x0
 4e0:	f58080e7          	jalr	-168(ra) # 434 <putc>
  while(--i >= 0)
 4e4:	197d                	addi	s2,s2,-1
 4e6:	ff3918e3          	bne	s2,s3,4d6 <printint+0x80>
}
 4ea:	70e2                	ld	ra,56(sp)
 4ec:	7442                	ld	s0,48(sp)
 4ee:	74a2                	ld	s1,40(sp)
 4f0:	7902                	ld	s2,32(sp)
 4f2:	69e2                	ld	s3,24(sp)
 4f4:	6121                	addi	sp,sp,64
 4f6:	8082                	ret
    x = -xx;
 4f8:	40b005bb          	negw	a1,a1
    neg = 1;
 4fc:	4885                	li	a7,1
    x = -xx;
 4fe:	bf8d                	j	470 <printint+0x1a>

0000000000000500 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 500:	7119                	addi	sp,sp,-128
 502:	fc86                	sd	ra,120(sp)
 504:	f8a2                	sd	s0,112(sp)
 506:	f4a6                	sd	s1,104(sp)
 508:	f0ca                	sd	s2,96(sp)
 50a:	ecce                	sd	s3,88(sp)
 50c:	e8d2                	sd	s4,80(sp)
 50e:	e4d6                	sd	s5,72(sp)
 510:	e0da                	sd	s6,64(sp)
 512:	fc5e                	sd	s7,56(sp)
 514:	f862                	sd	s8,48(sp)
 516:	f466                	sd	s9,40(sp)
 518:	f06a                	sd	s10,32(sp)
 51a:	ec6e                	sd	s11,24(sp)
 51c:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 51e:	0005c903          	lbu	s2,0(a1)
 522:	18090f63          	beqz	s2,6c0 <vprintf+0x1c0>
 526:	8aaa                	mv	s5,a0
 528:	8b32                	mv	s6,a2
 52a:	00158493          	addi	s1,a1,1
  state = 0;
 52e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 530:	02500a13          	li	s4,37
      if(c == 'd'){
 534:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 538:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 53c:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 540:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 544:	00001b97          	auipc	s7,0x1
 548:	81cb8b93          	addi	s7,s7,-2020 # d60 <digits>
 54c:	a839                	j	56a <vprintf+0x6a>
        putc(fd, c);
 54e:	85ca                	mv	a1,s2
 550:	8556                	mv	a0,s5
 552:	00000097          	auipc	ra,0x0
 556:	ee2080e7          	jalr	-286(ra) # 434 <putc>
 55a:	a019                	j	560 <vprintf+0x60>
    } else if(state == '%'){
 55c:	01498f63          	beq	s3,s4,57a <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 560:	0485                	addi	s1,s1,1
 562:	fff4c903          	lbu	s2,-1(s1)
 566:	14090d63          	beqz	s2,6c0 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 56a:	0009079b          	sext.w	a5,s2
    if(state == 0){
 56e:	fe0997e3          	bnez	s3,55c <vprintf+0x5c>
      if(c == '%'){
 572:	fd479ee3          	bne	a5,s4,54e <vprintf+0x4e>
        state = '%';
 576:	89be                	mv	s3,a5
 578:	b7e5                	j	560 <vprintf+0x60>
      if(c == 'd'){
 57a:	05878063          	beq	a5,s8,5ba <vprintf+0xba>
      } else if(c == 'l') {
 57e:	05978c63          	beq	a5,s9,5d6 <vprintf+0xd6>
      } else if(c == 'x') {
 582:	07a78863          	beq	a5,s10,5f2 <vprintf+0xf2>
      } else if(c == 'p') {
 586:	09b78463          	beq	a5,s11,60e <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 58a:	07300713          	li	a4,115
 58e:	0ce78663          	beq	a5,a4,65a <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 592:	06300713          	li	a4,99
 596:	0ee78e63          	beq	a5,a4,692 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 59a:	11478863          	beq	a5,s4,6aa <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 59e:	85d2                	mv	a1,s4
 5a0:	8556                	mv	a0,s5
 5a2:	00000097          	auipc	ra,0x0
 5a6:	e92080e7          	jalr	-366(ra) # 434 <putc>
        putc(fd, c);
 5aa:	85ca                	mv	a1,s2
 5ac:	8556                	mv	a0,s5
 5ae:	00000097          	auipc	ra,0x0
 5b2:	e86080e7          	jalr	-378(ra) # 434 <putc>
      }
      state = 0;
 5b6:	4981                	li	s3,0
 5b8:	b765                	j	560 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 5ba:	008b0913          	addi	s2,s6,8
 5be:	4685                	li	a3,1
 5c0:	4629                	li	a2,10
 5c2:	000b2583          	lw	a1,0(s6)
 5c6:	8556                	mv	a0,s5
 5c8:	00000097          	auipc	ra,0x0
 5cc:	e8e080e7          	jalr	-370(ra) # 456 <printint>
 5d0:	8b4a                	mv	s6,s2
      state = 0;
 5d2:	4981                	li	s3,0
 5d4:	b771                	j	560 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5d6:	008b0913          	addi	s2,s6,8
 5da:	4681                	li	a3,0
 5dc:	4629                	li	a2,10
 5de:	000b2583          	lw	a1,0(s6)
 5e2:	8556                	mv	a0,s5
 5e4:	00000097          	auipc	ra,0x0
 5e8:	e72080e7          	jalr	-398(ra) # 456 <printint>
 5ec:	8b4a                	mv	s6,s2
      state = 0;
 5ee:	4981                	li	s3,0
 5f0:	bf85                	j	560 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 5f2:	008b0913          	addi	s2,s6,8
 5f6:	4681                	li	a3,0
 5f8:	4641                	li	a2,16
 5fa:	000b2583          	lw	a1,0(s6)
 5fe:	8556                	mv	a0,s5
 600:	00000097          	auipc	ra,0x0
 604:	e56080e7          	jalr	-426(ra) # 456 <printint>
 608:	8b4a                	mv	s6,s2
      state = 0;
 60a:	4981                	li	s3,0
 60c:	bf91                	j	560 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 60e:	008b0793          	addi	a5,s6,8
 612:	f8f43423          	sd	a5,-120(s0)
 616:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 61a:	03000593          	li	a1,48
 61e:	8556                	mv	a0,s5
 620:	00000097          	auipc	ra,0x0
 624:	e14080e7          	jalr	-492(ra) # 434 <putc>
  putc(fd, 'x');
 628:	85ea                	mv	a1,s10
 62a:	8556                	mv	a0,s5
 62c:	00000097          	auipc	ra,0x0
 630:	e08080e7          	jalr	-504(ra) # 434 <putc>
 634:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 636:	03c9d793          	srli	a5,s3,0x3c
 63a:	97de                	add	a5,a5,s7
 63c:	0007c583          	lbu	a1,0(a5)
 640:	8556                	mv	a0,s5
 642:	00000097          	auipc	ra,0x0
 646:	df2080e7          	jalr	-526(ra) # 434 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 64a:	0992                	slli	s3,s3,0x4
 64c:	397d                	addiw	s2,s2,-1
 64e:	fe0914e3          	bnez	s2,636 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 652:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 656:	4981                	li	s3,0
 658:	b721                	j	560 <vprintf+0x60>
        s = va_arg(ap, char*);
 65a:	008b0993          	addi	s3,s6,8
 65e:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 662:	02090163          	beqz	s2,684 <vprintf+0x184>
        while(*s != 0){
 666:	00094583          	lbu	a1,0(s2)
 66a:	c9a1                	beqz	a1,6ba <vprintf+0x1ba>
          putc(fd, *s);
 66c:	8556                	mv	a0,s5
 66e:	00000097          	auipc	ra,0x0
 672:	dc6080e7          	jalr	-570(ra) # 434 <putc>
          s++;
 676:	0905                	addi	s2,s2,1
        while(*s != 0){
 678:	00094583          	lbu	a1,0(s2)
 67c:	f9e5                	bnez	a1,66c <vprintf+0x16c>
        s = va_arg(ap, char*);
 67e:	8b4e                	mv	s6,s3
      state = 0;
 680:	4981                	li	s3,0
 682:	bdf9                	j	560 <vprintf+0x60>
          s = "(null)";
 684:	00000917          	auipc	s2,0x0
 688:	6d490913          	addi	s2,s2,1748 # d58 <thread_assign_task+0xa8>
        while(*s != 0){
 68c:	02800593          	li	a1,40
 690:	bff1                	j	66c <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 692:	008b0913          	addi	s2,s6,8
 696:	000b4583          	lbu	a1,0(s6)
 69a:	8556                	mv	a0,s5
 69c:	00000097          	auipc	ra,0x0
 6a0:	d98080e7          	jalr	-616(ra) # 434 <putc>
 6a4:	8b4a                	mv	s6,s2
      state = 0;
 6a6:	4981                	li	s3,0
 6a8:	bd65                	j	560 <vprintf+0x60>
        putc(fd, c);
 6aa:	85d2                	mv	a1,s4
 6ac:	8556                	mv	a0,s5
 6ae:	00000097          	auipc	ra,0x0
 6b2:	d86080e7          	jalr	-634(ra) # 434 <putc>
      state = 0;
 6b6:	4981                	li	s3,0
 6b8:	b565                	j	560 <vprintf+0x60>
        s = va_arg(ap, char*);
 6ba:	8b4e                	mv	s6,s3
      state = 0;
 6bc:	4981                	li	s3,0
 6be:	b54d                	j	560 <vprintf+0x60>
    }
  }
}
 6c0:	70e6                	ld	ra,120(sp)
 6c2:	7446                	ld	s0,112(sp)
 6c4:	74a6                	ld	s1,104(sp)
 6c6:	7906                	ld	s2,96(sp)
 6c8:	69e6                	ld	s3,88(sp)
 6ca:	6a46                	ld	s4,80(sp)
 6cc:	6aa6                	ld	s5,72(sp)
 6ce:	6b06                	ld	s6,64(sp)
 6d0:	7be2                	ld	s7,56(sp)
 6d2:	7c42                	ld	s8,48(sp)
 6d4:	7ca2                	ld	s9,40(sp)
 6d6:	7d02                	ld	s10,32(sp)
 6d8:	6de2                	ld	s11,24(sp)
 6da:	6109                	addi	sp,sp,128
 6dc:	8082                	ret

00000000000006de <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6de:	715d                	addi	sp,sp,-80
 6e0:	ec06                	sd	ra,24(sp)
 6e2:	e822                	sd	s0,16(sp)
 6e4:	1000                	addi	s0,sp,32
 6e6:	e010                	sd	a2,0(s0)
 6e8:	e414                	sd	a3,8(s0)
 6ea:	e818                	sd	a4,16(s0)
 6ec:	ec1c                	sd	a5,24(s0)
 6ee:	03043023          	sd	a6,32(s0)
 6f2:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6f6:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6fa:	8622                	mv	a2,s0
 6fc:	00000097          	auipc	ra,0x0
 700:	e04080e7          	jalr	-508(ra) # 500 <vprintf>
}
 704:	60e2                	ld	ra,24(sp)
 706:	6442                	ld	s0,16(sp)
 708:	6161                	addi	sp,sp,80
 70a:	8082                	ret

000000000000070c <printf>:

void
printf(const char *fmt, ...)
{
 70c:	711d                	addi	sp,sp,-96
 70e:	ec06                	sd	ra,24(sp)
 710:	e822                	sd	s0,16(sp)
 712:	1000                	addi	s0,sp,32
 714:	e40c                	sd	a1,8(s0)
 716:	e810                	sd	a2,16(s0)
 718:	ec14                	sd	a3,24(s0)
 71a:	f018                	sd	a4,32(s0)
 71c:	f41c                	sd	a5,40(s0)
 71e:	03043823          	sd	a6,48(s0)
 722:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 726:	00840613          	addi	a2,s0,8
 72a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 72e:	85aa                	mv	a1,a0
 730:	4505                	li	a0,1
 732:	00000097          	auipc	ra,0x0
 736:	dce080e7          	jalr	-562(ra) # 500 <vprintf>
}
 73a:	60e2                	ld	ra,24(sp)
 73c:	6442                	ld	s0,16(sp)
 73e:	6125                	addi	sp,sp,96
 740:	8082                	ret

0000000000000742 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 742:	1141                	addi	sp,sp,-16
 744:	e422                	sd	s0,8(sp)
 746:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 748:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 74c:	00000797          	auipc	a5,0x0
 750:	63c7b783          	ld	a5,1596(a5) # d88 <freep>
 754:	a805                	j	784 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 756:	4618                	lw	a4,8(a2)
 758:	9db9                	addw	a1,a1,a4
 75a:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 75e:	6398                	ld	a4,0(a5)
 760:	6318                	ld	a4,0(a4)
 762:	fee53823          	sd	a4,-16(a0)
 766:	a091                	j	7aa <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 768:	ff852703          	lw	a4,-8(a0)
 76c:	9e39                	addw	a2,a2,a4
 76e:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 770:	ff053703          	ld	a4,-16(a0)
 774:	e398                	sd	a4,0(a5)
 776:	a099                	j	7bc <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 778:	6398                	ld	a4,0(a5)
 77a:	00e7e463          	bltu	a5,a4,782 <free+0x40>
 77e:	00e6ea63          	bltu	a3,a4,792 <free+0x50>
{
 782:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 784:	fed7fae3          	bgeu	a5,a3,778 <free+0x36>
 788:	6398                	ld	a4,0(a5)
 78a:	00e6e463          	bltu	a3,a4,792 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 78e:	fee7eae3          	bltu	a5,a4,782 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 792:	ff852583          	lw	a1,-8(a0)
 796:	6390                	ld	a2,0(a5)
 798:	02059713          	slli	a4,a1,0x20
 79c:	9301                	srli	a4,a4,0x20
 79e:	0712                	slli	a4,a4,0x4
 7a0:	9736                	add	a4,a4,a3
 7a2:	fae60ae3          	beq	a2,a4,756 <free+0x14>
    bp->s.ptr = p->s.ptr;
 7a6:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7aa:	4790                	lw	a2,8(a5)
 7ac:	02061713          	slli	a4,a2,0x20
 7b0:	9301                	srli	a4,a4,0x20
 7b2:	0712                	slli	a4,a4,0x4
 7b4:	973e                	add	a4,a4,a5
 7b6:	fae689e3          	beq	a3,a4,768 <free+0x26>
  } else
    p->s.ptr = bp;
 7ba:	e394                	sd	a3,0(a5)
  freep = p;
 7bc:	00000717          	auipc	a4,0x0
 7c0:	5cf73623          	sd	a5,1484(a4) # d88 <freep>
}
 7c4:	6422                	ld	s0,8(sp)
 7c6:	0141                	addi	sp,sp,16
 7c8:	8082                	ret

00000000000007ca <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7ca:	7139                	addi	sp,sp,-64
 7cc:	fc06                	sd	ra,56(sp)
 7ce:	f822                	sd	s0,48(sp)
 7d0:	f426                	sd	s1,40(sp)
 7d2:	f04a                	sd	s2,32(sp)
 7d4:	ec4e                	sd	s3,24(sp)
 7d6:	e852                	sd	s4,16(sp)
 7d8:	e456                	sd	s5,8(sp)
 7da:	e05a                	sd	s6,0(sp)
 7dc:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7de:	02051493          	slli	s1,a0,0x20
 7e2:	9081                	srli	s1,s1,0x20
 7e4:	04bd                	addi	s1,s1,15
 7e6:	8091                	srli	s1,s1,0x4
 7e8:	0014899b          	addiw	s3,s1,1
 7ec:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 7ee:	00000517          	auipc	a0,0x0
 7f2:	59a53503          	ld	a0,1434(a0) # d88 <freep>
 7f6:	c515                	beqz	a0,822 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7f8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7fa:	4798                	lw	a4,8(a5)
 7fc:	02977f63          	bgeu	a4,s1,83a <malloc+0x70>
 800:	8a4e                	mv	s4,s3
 802:	0009871b          	sext.w	a4,s3
 806:	6685                	lui	a3,0x1
 808:	00d77363          	bgeu	a4,a3,80e <malloc+0x44>
 80c:	6a05                	lui	s4,0x1
 80e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 812:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 816:	00000917          	auipc	s2,0x0
 81a:	57290913          	addi	s2,s2,1394 # d88 <freep>
  if(p == (char*)-1)
 81e:	5afd                	li	s5,-1
 820:	a88d                	j	892 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 822:	00000797          	auipc	a5,0x0
 826:	57678793          	addi	a5,a5,1398 # d98 <base>
 82a:	00000717          	auipc	a4,0x0
 82e:	54f73f23          	sd	a5,1374(a4) # d88 <freep>
 832:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 834:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 838:	b7e1                	j	800 <malloc+0x36>
      if(p->s.size == nunits)
 83a:	02e48b63          	beq	s1,a4,870 <malloc+0xa6>
        p->s.size -= nunits;
 83e:	4137073b          	subw	a4,a4,s3
 842:	c798                	sw	a4,8(a5)
        p += p->s.size;
 844:	1702                	slli	a4,a4,0x20
 846:	9301                	srli	a4,a4,0x20
 848:	0712                	slli	a4,a4,0x4
 84a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 84c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 850:	00000717          	auipc	a4,0x0
 854:	52a73c23          	sd	a0,1336(a4) # d88 <freep>
      return (void*)(p + 1);
 858:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 85c:	70e2                	ld	ra,56(sp)
 85e:	7442                	ld	s0,48(sp)
 860:	74a2                	ld	s1,40(sp)
 862:	7902                	ld	s2,32(sp)
 864:	69e2                	ld	s3,24(sp)
 866:	6a42                	ld	s4,16(sp)
 868:	6aa2                	ld	s5,8(sp)
 86a:	6b02                	ld	s6,0(sp)
 86c:	6121                	addi	sp,sp,64
 86e:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 870:	6398                	ld	a4,0(a5)
 872:	e118                	sd	a4,0(a0)
 874:	bff1                	j	850 <malloc+0x86>
  hp->s.size = nu;
 876:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 87a:	0541                	addi	a0,a0,16
 87c:	00000097          	auipc	ra,0x0
 880:	ec6080e7          	jalr	-314(ra) # 742 <free>
  return freep;
 884:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 888:	d971                	beqz	a0,85c <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 88a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 88c:	4798                	lw	a4,8(a5)
 88e:	fa9776e3          	bgeu	a4,s1,83a <malloc+0x70>
    if(p == freep)
 892:	00093703          	ld	a4,0(s2)
 896:	853e                	mv	a0,a5
 898:	fef719e3          	bne	a4,a5,88a <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 89c:	8552                	mv	a0,s4
 89e:	00000097          	auipc	ra,0x0
 8a2:	b7e080e7          	jalr	-1154(ra) # 41c <sbrk>
  if(p == (char*)-1)
 8a6:	fd5518e3          	bne	a0,s5,876 <malloc+0xac>
        return 0;
 8aa:	4501                	li	a0,0
 8ac:	bf45                	j	85c <malloc+0x92>

00000000000008ae <setjmp>:
 8ae:	e100                	sd	s0,0(a0)
 8b0:	e504                	sd	s1,8(a0)
 8b2:	01253823          	sd	s2,16(a0)
 8b6:	01353c23          	sd	s3,24(a0)
 8ba:	03453023          	sd	s4,32(a0)
 8be:	03553423          	sd	s5,40(a0)
 8c2:	03653823          	sd	s6,48(a0)
 8c6:	03753c23          	sd	s7,56(a0)
 8ca:	05853023          	sd	s8,64(a0)
 8ce:	05953423          	sd	s9,72(a0)
 8d2:	05a53823          	sd	s10,80(a0)
 8d6:	05b53c23          	sd	s11,88(a0)
 8da:	06153023          	sd	ra,96(a0)
 8de:	06253423          	sd	sp,104(a0)
 8e2:	4501                	li	a0,0
 8e4:	8082                	ret

00000000000008e6 <longjmp>:
 8e6:	6100                	ld	s0,0(a0)
 8e8:	6504                	ld	s1,8(a0)
 8ea:	01053903          	ld	s2,16(a0)
 8ee:	01853983          	ld	s3,24(a0)
 8f2:	02053a03          	ld	s4,32(a0)
 8f6:	02853a83          	ld	s5,40(a0)
 8fa:	03053b03          	ld	s6,48(a0)
 8fe:	03853b83          	ld	s7,56(a0)
 902:	04053c03          	ld	s8,64(a0)
 906:	04853c83          	ld	s9,72(a0)
 90a:	05053d03          	ld	s10,80(a0)
 90e:	05853d83          	ld	s11,88(a0)
 912:	06053083          	ld	ra,96(a0)
 916:	06853103          	ld	sp,104(a0)
 91a:	c199                	beqz	a1,920 <longjmp_1>
 91c:	852e                	mv	a0,a1
 91e:	8082                	ret

0000000000000920 <longjmp_1>:
 920:	4505                	li	a0,1
 922:	8082                	ret

0000000000000924 <thread_create>:
static struct thread* current_thread = NULL;
static int id = 1;
static jmp_buf env_st;
// static jmp_buf env_tmp;

struct thread *thread_create(void (*f)(void *), void *arg){ // init thread
 924:	7179                	addi	sp,sp,-48
 926:	f406                	sd	ra,40(sp)
 928:	f022                	sd	s0,32(sp)
 92a:	ec26                	sd	s1,24(sp)
 92c:	e84a                	sd	s2,16(sp)
 92e:	e44e                	sd	s3,8(sp)
 930:	1800                	addi	s0,sp,48
 932:	89aa                	mv	s3,a0
 934:	892e                	mv	s2,a1
    // printf("I am creting!!\n"); 
    struct thread *t = (struct thread *) malloc(sizeof(struct thread));
 936:	0c000513          	li	a0,192
 93a:	00000097          	auipc	ra,0x0
 93e:	e90080e7          	jalr	-368(ra) # 7ca <malloc>
 942:	84aa                	mv	s1,a0
    unsigned long new_stack;
    unsigned long new_stack_p;
    new_stack = (unsigned long) malloc(sizeof(unsigned long)*0x100);
 944:	6505                	lui	a0,0x1
 946:	80050513          	addi	a0,a0,-2048 # 800 <malloc+0x36>
 94a:	00000097          	auipc	ra,0x0
 94e:	e80080e7          	jalr	-384(ra) # 7ca <malloc>
    new_stack_p = new_stack +0x100*8-0x2*8;
    t->fp = f;
 952:	0134b023          	sd	s3,0(s1)
    t->arg = arg;
 956:	0124b423          	sd	s2,8(s1)
    t->ID  = id;
 95a:	00000717          	auipc	a4,0x0
 95e:	41a70713          	addi	a4,a4,1050 # d74 <id>
 962:	431c                	lw	a5,0(a4)
 964:	08f4ac23          	sw	a5,152(s1)
    t->buf_set = 0;
 968:	0804aa23          	sw	zero,148(s1)
    t->stack = (void*) new_stack;
 96c:	e888                	sd	a0,16(s1)
    new_stack_p = new_stack +0x100*8-0x2*8;
 96e:	7f050513          	addi	a0,a0,2032
    t->stack_p = (void*) new_stack_p;
 972:	ec88                	sd	a0,24(s1)
    t->in_task = 0;
 974:	0804a823          	sw	zero,144(s1)
    t->head_task = NULL;
 978:	0a04b023          	sd	zero,160(s1)
    t->task_num = 0;
 97c:	0804ae23          	sw	zero,156(s1)
    id++;
 980:	2785                	addiw	a5,a5,1
 982:	c31c                	sw	a5,0(a4)
    return t;
}
 984:	8526                	mv	a0,s1
 986:	70a2                	ld	ra,40(sp)
 988:	7402                	ld	s0,32(sp)
 98a:	64e2                	ld	s1,24(sp)
 98c:	6942                	ld	s2,16(sp)
 98e:	69a2                	ld	s3,8(sp)
 990:	6145                	addi	sp,sp,48
 992:	8082                	ret

0000000000000994 <thread_add_runqueue>:
void thread_add_runqueue(struct thread *t){
 994:	1141                	addi	sp,sp,-16
 996:	e422                	sd	s0,8(sp)
 998:	0800                	addi	s0,sp,16
    // Check if the runqueue is empty
    if (current_thread == NULL) {
 99a:	00000797          	auipc	a5,0x0
 99e:	3f67b783          	ld	a5,1014(a5) # d90 <current_thread>
 9a2:	cb89                	beqz	a5,9b4 <thread_add_runqueue+0x20>
        current_thread = t;
        t->next = t;  // Point to itself, making it circular
        t->previous = t;
    } else {
        // Insert the new thread at the end of the runqueue
        t->next = current_thread;
 9a4:	fd5c                	sd	a5,184(a0)
        t->previous = current_thread->previous;
 9a6:	7bd8                	ld	a4,176(a5)
 9a8:	f958                	sd	a4,176(a0)
        current_thread->previous->next = t;
 9aa:	ff48                	sd	a0,184(a4)
        current_thread->previous = t;
 9ac:	fbc8                	sd	a0,176(a5)
    }
    return;
}
 9ae:	6422                	ld	s0,8(sp)
 9b0:	0141                	addi	sp,sp,16
 9b2:	8082                	ret
        current_thread = t;
 9b4:	00000797          	auipc	a5,0x0
 9b8:	3ca7be23          	sd	a0,988(a5) # d90 <current_thread>
        t->next = t;  // Point to itself, making it circular
 9bc:	fd48                	sd	a0,184(a0)
        t->previous = t;
 9be:	f948                	sd	a0,176(a0)
 9c0:	b7fd                	j	9ae <thread_add_runqueue+0x1a>

00000000000009c2 <schedule>:
        current_thread->in_task = 0;
        longjmp(current_thread->env, 1);
    }
}

void schedule(void) { // for threads
 9c2:	1141                	addi	sp,sp,-16
 9c4:	e422                	sd	s0,8(sp)
 9c6:	0800                	addi	s0,sp,16
    if (current_thread != NULL && current_thread->next != NULL) {
 9c8:	00000797          	auipc	a5,0x0
 9cc:	3c87b783          	ld	a5,968(a5) # d90 <current_thread>
 9d0:	c799                	beqz	a5,9de <schedule+0x1c>
 9d2:	7fdc                	ld	a5,184(a5)
 9d4:	c789                	beqz	a5,9de <schedule+0x1c>
        current_thread = current_thread->next;
 9d6:	00000717          	auipc	a4,0x0
 9da:	3af73d23          	sd	a5,954(a4) # d90 <current_thread>
    }
}
 9de:	6422                	ld	s0,8(sp)
 9e0:	0141                	addi	sp,sp,16
 9e2:	8082                	ret

00000000000009e4 <thread_exit>:

void thread_exit(void) {
 9e4:	7179                	addi	sp,sp,-48
 9e6:	f406                	sd	ra,40(sp)
 9e8:	f022                	sd	s0,32(sp)
 9ea:	ec26                	sd	s1,24(sp)
 9ec:	e84a                	sd	s2,16(sp)
 9ee:	e44e                	sd	s3,8(sp)
 9f0:	1800                	addi	s0,sp,48
    /* free tasks */
    task *tmp = current_thread->head_task;
 9f2:	00000797          	auipc	a5,0x0
 9f6:	39e7b783          	ld	a5,926(a5) # d90 <current_thread>
 9fa:	73c4                	ld	s1,160(a5)
    task *tmp_next;
    while (tmp != NULL){
 9fc:	c895                	beqz	s1,a30 <thread_exit+0x4c>
        tmp_next = tmp->next;
        free(tmp->stack);
        free(tmp);
        current_thread->task_num--;
 9fe:	00000997          	auipc	s3,0x0
 a02:	39298993          	addi	s3,s3,914 # d90 <current_thread>
        tmp_next = tmp->next;
 a06:	8926                	mv	s2,s1
 a08:	7084                	ld	s1,32(s1)
        free(tmp->stack);
 a0a:	01093503          	ld	a0,16(s2)
 a0e:	00000097          	auipc	ra,0x0
 a12:	d34080e7          	jalr	-716(ra) # 742 <free>
        free(tmp);
 a16:	854a                	mv	a0,s2
 a18:	00000097          	auipc	ra,0x0
 a1c:	d2a080e7          	jalr	-726(ra) # 742 <free>
        current_thread->task_num--;
 a20:	0009b703          	ld	a4,0(s3)
 a24:	09c72783          	lw	a5,156(a4)
 a28:	37fd                	addiw	a5,a5,-1
 a2a:	08f72e23          	sw	a5,156(a4)
    while (tmp != NULL){
 a2e:	fce1                	bnez	s1,a06 <thread_exit+0x22>
        tmp = tmp_next;
    }
    // Check if after scheduling, we are back to the same thread, which means it's the last one
    if (current_thread->next == current_thread){ // only one thread left
 a30:	00000797          	auipc	a5,0x0
 a34:	3607b783          	ld	a5,864(a5) # d90 <current_thread>
 a38:	7fd8                	ld	a4,184(a5)
 a3a:	04e78363          	beq	a5,a4,a80 <thread_exit+0x9c>
        free(current_thread);
        current_thread = NULL;
        longjmp(env_st, 1);
    }
    else{
        current_thread->previous->next = current_thread->next;
 a3e:	7bd4                	ld	a3,176(a5)
 a40:	fed8                	sd	a4,184(a3)
        current_thread->next->previous = current_thread->previous;
 a42:	7bd4                	ld	a3,176(a5)
 a44:	fb54                	sd	a3,176(a4)
        thread *tmp = current_thread->next;
 a46:	0b87b903          	ld	s2,184(a5)
        free(current_thread->stack);
 a4a:	6b88                	ld	a0,16(a5)
 a4c:	00000097          	auipc	ra,0x0
 a50:	cf6080e7          	jalr	-778(ra) # 742 <free>
        free(current_thread);
 a54:	00000497          	auipc	s1,0x0
 a58:	33c48493          	addi	s1,s1,828 # d90 <current_thread>
 a5c:	6088                	ld	a0,0(s1)
 a5e:	00000097          	auipc	ra,0x0
 a62:	ce4080e7          	jalr	-796(ra) # 742 <free>
        current_thread = tmp;
 a66:	0124b023          	sd	s2,0(s1)
        dispatch();
 a6a:	00000097          	auipc	ra,0x0
 a6e:	04a080e7          	jalr	74(ra) # ab4 <dispatch>
    }
}
 a72:	70a2                	ld	ra,40(sp)
 a74:	7402                	ld	s0,32(sp)
 a76:	64e2                	ld	s1,24(sp)
 a78:	6942                	ld	s2,16(sp)
 a7a:	69a2                	ld	s3,8(sp)
 a7c:	6145                	addi	sp,sp,48
 a7e:	8082                	ret
        free(current_thread->stack);
 a80:	6b88                	ld	a0,16(a5)
 a82:	00000097          	auipc	ra,0x0
 a86:	cc0080e7          	jalr	-832(ra) # 742 <free>
        free(current_thread);
 a8a:	00000497          	auipc	s1,0x0
 a8e:	30648493          	addi	s1,s1,774 # d90 <current_thread>
 a92:	6088                	ld	a0,0(s1)
 a94:	00000097          	auipc	ra,0x0
 a98:	cae080e7          	jalr	-850(ra) # 742 <free>
        current_thread = NULL;
 a9c:	0004b023          	sd	zero,0(s1)
        longjmp(env_st, 1);
 aa0:	4585                	li	a1,1
 aa2:	00000517          	auipc	a0,0x0
 aa6:	30650513          	addi	a0,a0,774 # da8 <env_st>
 aaa:	00000097          	auipc	ra,0x0
 aae:	e3c080e7          	jalr	-452(ra) # 8e6 <longjmp>
 ab2:	b7c1                	j	a72 <thread_exit+0x8e>

0000000000000ab4 <dispatch>:
void dispatch(void) {
 ab4:	1101                	addi	sp,sp,-32
 ab6:	ec06                	sd	ra,24(sp)
 ab8:	e822                	sd	s0,16(sp)
 aba:	e426                	sd	s1,8(sp)
 abc:	1000                	addi	s0,sp,32
    while (current_thread->task_num > 0) {
 abe:	00000797          	auipc	a5,0x0
 ac2:	2d278793          	addi	a5,a5,722 # d90 <current_thread>
 ac6:	639c                	ld	a5,0(a5)
 ac8:	09c7a703          	lw	a4,156(a5)
 acc:	0ce05363          	blez	a4,b92 <dispatch+0xde>
        if (current_thread->head_task->buf_set == 0){
 ad0:	73c8                	ld	a0,160(a5)
 ad2:	0a052703          	lw	a4,160(a0)
 ad6:	e355                	bnez	a4,b7a <dispatch+0xc6>
            if (setjmp(current_thread->head_task->env) == 0) { // init sp
 ad8:	03050513          	addi	a0,a0,48
 adc:	00000097          	auipc	ra,0x0
 ae0:	dd2080e7          	jalr	-558(ra) # 8ae <setjmp>
 ae4:	c135                	beqz	a0,b48 <dispatch+0x94>
                current_thread->in_task = 1;
 ae6:	00000497          	auipc	s1,0x0
 aea:	2aa48493          	addi	s1,s1,682 # d90 <current_thread>
 aee:	6098                	ld	a4,0(s1)
 af0:	4785                	li	a5,1
 af2:	08f72823          	sw	a5,144(a4)
                current_thread->now_task = current_thread->head_task;
 af6:	735c                	ld	a5,160(a4)
 af8:	f75c                	sd	a5,168(a4)
                current_thread->now_task->function(current_thread->now_task->arg);
 afa:	6398                	ld	a4,0(a5)
 afc:	6788                	ld	a0,8(a5)
 afe:	9702                	jalr	a4
                if (current_thread->now_task->next != NULL){
 b00:	609c                	ld	a5,0(s1)
 b02:	77d4                	ld	a3,168(a5)
 b04:	7298                	ld	a4,32(a3)
 b06:	c319                	beqz	a4,b0c <dispatch+0x58>
                    current_thread->now_task->next->prev = current_thread->now_task->prev;
 b08:	7694                	ld	a3,40(a3)
 b0a:	f714                	sd	a3,40(a4)
                if (current_thread->now_task->prev != NULL){
 b0c:	77d4                	ld	a3,168(a5)
 b0e:	7698                	ld	a4,40(a3)
 b10:	c32d                	beqz	a4,b72 <dispatch+0xbe>
                    current_thread->now_task->prev->next = current_thread->now_task->next;
 b12:	7294                	ld	a3,32(a3)
 b14:	f314                	sd	a3,32(a4)
                current_thread->task_num--;
 b16:	09c7a703          	lw	a4,156(a5)
 b1a:	377d                	addiw	a4,a4,-1
 b1c:	08e7ae23          	sw	a4,156(a5)
                free(current_thread->now_task->stack);
 b20:	77dc                	ld	a5,168(a5)
 b22:	6b88                	ld	a0,16(a5)
 b24:	00000097          	auipc	ra,0x0
 b28:	c1e080e7          	jalr	-994(ra) # 742 <free>
                free(current_thread->now_task);
 b2c:	00000497          	auipc	s1,0x0
 b30:	26448493          	addi	s1,s1,612 # d90 <current_thread>
 b34:	609c                	ld	a5,0(s1)
 b36:	77c8                	ld	a0,168(a5)
 b38:	00000097          	auipc	ra,0x0
 b3c:	c0a080e7          	jalr	-1014(ra) # 742 <free>
                current_thread->now_task = NULL;
 b40:	609c                	ld	a5,0(s1)
 b42:	0a07b423          	sd	zero,168(a5)
 b46:	bfa5                	j	abe <dispatch+0xa>
                current_thread->head_task->buf_set = 1;
 b48:	00000797          	auipc	a5,0x0
 b4c:	24878793          	addi	a5,a5,584 # d90 <current_thread>
 b50:	639c                	ld	a5,0(a5)
 b52:	73d8                	ld	a4,160(a5)
 b54:	4685                	li	a3,1
 b56:	0ad72023          	sw	a3,160(a4)
                current_thread->head_task->env->sp = (unsigned long)(current_thread->head_task->stack_p);
 b5a:	73d8                	ld	a4,160(a5)
 b5c:	6f14                	ld	a3,24(a4)
 b5e:	ef54                	sd	a3,152(a4)
                longjmp(current_thread->head_task->env, 1);
 b60:	73c8                	ld	a0,160(a5)
 b62:	4585                	li	a1,1
 b64:	03050513          	addi	a0,a0,48
 b68:	00000097          	auipc	ra,0x0
 b6c:	d7e080e7          	jalr	-642(ra) # 8e6 <longjmp>
 b70:	b7b9                	j	abe <dispatch+0xa>
                    current_thread->head_task = current_thread->head_task->next;
 b72:	73d8                	ld	a4,160(a5)
 b74:	7318                	ld	a4,32(a4)
 b76:	f3d8                	sd	a4,160(a5)
 b78:	bf79                	j	b16 <dispatch+0x62>
            current_thread->in_task = 1;
 b7a:	4705                	li	a4,1
 b7c:	08e7a823          	sw	a4,144(a5)
            current_thread->now_task = current_thread->head_task;
 b80:	f7c8                	sd	a0,168(a5)
            longjmp(current_thread->now_task->env, 1);
 b82:	4585                	li	a1,1
 b84:	03050513          	addi	a0,a0,48
 b88:	00000097          	auipc	ra,0x0
 b8c:	d5e080e7          	jalr	-674(ra) # 8e6 <longjmp>
 b90:	b73d                	j	abe <dispatch+0xa>
    if (current_thread->buf_set == 0) {
 b92:	0947a703          	lw	a4,148(a5)
 b96:	eb21                	bnez	a4,be6 <dispatch+0x132>
        if (setjmp(current_thread->env) == 0) {
 b98:	02078513          	addi	a0,a5,32
 b9c:	00000097          	auipc	ra,0x0
 ba0:	d12080e7          	jalr	-750(ra) # 8ae <setjmp>
 ba4:	c11d                	beqz	a0,bca <dispatch+0x116>
            current_thread->in_task = 0;
 ba6:	00000797          	auipc	a5,0x0
 baa:	1ea7b783          	ld	a5,490(a5) # d90 <current_thread>
 bae:	0807a823          	sw	zero,144(a5)
            current_thread->fp(current_thread->arg);
 bb2:	6398                	ld	a4,0(a5)
 bb4:	6788                	ld	a0,8(a5)
 bb6:	9702                	jalr	a4
            thread_exit();
 bb8:	00000097          	auipc	ra,0x0
 bbc:	e2c080e7          	jalr	-468(ra) # 9e4 <thread_exit>
}
 bc0:	60e2                	ld	ra,24(sp)
 bc2:	6442                	ld	s0,16(sp)
 bc4:	64a2                	ld	s1,8(sp)
 bc6:	6105                	addi	sp,sp,32
 bc8:	8082                	ret
            current_thread->env->sp = (unsigned long)(current_thread->stack_p);
 bca:	00000517          	auipc	a0,0x0
 bce:	1c653503          	ld	a0,454(a0) # d90 <current_thread>
 bd2:	6d1c                	ld	a5,24(a0)
 bd4:	e55c                	sd	a5,136(a0)
            longjmp(current_thread->env, 1); // Jump to the new context
 bd6:	4585                	li	a1,1
 bd8:	02050513          	addi	a0,a0,32
 bdc:	00000097          	auipc	ra,0x0
 be0:	d0a080e7          	jalr	-758(ra) # 8e6 <longjmp>
 be4:	bff1                	j	bc0 <dispatch+0x10c>
        current_thread->in_task = 0;
 be6:	0807a823          	sw	zero,144(a5)
        longjmp(current_thread->env, 1);
 bea:	4585                	li	a1,1
 bec:	02078513          	addi	a0,a5,32
 bf0:	00000097          	auipc	ra,0x0
 bf4:	cf6080e7          	jalr	-778(ra) # 8e6 <longjmp>
}
 bf8:	b7e1                	j	bc0 <dispatch+0x10c>

0000000000000bfa <thread_yield>:
void thread_yield(void){
 bfa:	1141                	addi	sp,sp,-16
 bfc:	e406                	sd	ra,8(sp)
 bfe:	e022                	sd	s0,0(sp)
 c00:	0800                	addi	s0,sp,16
    if (current_thread->in_task == 1){ // thread is doing tasks
 c02:	00000517          	auipc	a0,0x0
 c06:	18e53503          	ld	a0,398(a0) # d90 <current_thread>
 c0a:	09052703          	lw	a4,144(a0)
 c0e:	4785                	li	a5,1
 c10:	00f70d63          	beq	a4,a5,c2a <thread_yield+0x30>
        if (setjmp(current_thread->env) == 0) {
 c14:	02050513          	addi	a0,a0,32
 c18:	00000097          	auipc	ra,0x0
 c1c:	c96080e7          	jalr	-874(ra) # 8ae <setjmp>
 c20:	cd15                	beqz	a0,c5c <thread_yield+0x62>
}
 c22:	60a2                	ld	ra,8(sp)
 c24:	6402                	ld	s0,0(sp)
 c26:	0141                	addi	sp,sp,16
 c28:	8082                	ret
        if (setjmp(current_thread->now_task->env) == 0){
 c2a:	7548                	ld	a0,168(a0)
 c2c:	03050513          	addi	a0,a0,48
 c30:	00000097          	auipc	ra,0x0
 c34:	c7e080e7          	jalr	-898(ra) # 8ae <setjmp>
 c38:	f56d                	bnez	a0,c22 <thread_yield+0x28>
            current_thread->now_task->buf_set = 1;
 c3a:	00000797          	auipc	a5,0x0
 c3e:	1567b783          	ld	a5,342(a5) # d90 <current_thread>
 c42:	77dc                	ld	a5,168(a5)
 c44:	4705                	li	a4,1
 c46:	0ae7a023          	sw	a4,160(a5)
            schedule();
 c4a:	00000097          	auipc	ra,0x0
 c4e:	d78080e7          	jalr	-648(ra) # 9c2 <schedule>
            dispatch();
 c52:	00000097          	auipc	ra,0x0
 c56:	e62080e7          	jalr	-414(ra) # ab4 <dispatch>
 c5a:	b7e1                	j	c22 <thread_yield+0x28>
            current_thread->buf_set = 1;  // Mark that the env has been set for this thread
 c5c:	00000797          	auipc	a5,0x0
 c60:	1347b783          	ld	a5,308(a5) # d90 <current_thread>
 c64:	4705                	li	a4,1
 c66:	08e7aa23          	sw	a4,148(a5)
            schedule();  // Move to the next thread in the runqueue
 c6a:	00000097          	auipc	ra,0x0
 c6e:	d58080e7          	jalr	-680(ra) # 9c2 <schedule>
            dispatch();  // Switch to the next thread
 c72:	00000097          	auipc	ra,0x0
 c76:	e42080e7          	jalr	-446(ra) # ab4 <dispatch>
}
 c7a:	b765                	j	c22 <thread_yield+0x28>

0000000000000c7c <thread_start_threading>:

void thread_start_threading(void) {
 c7c:	1141                	addi	sp,sp,-16
 c7e:	e406                	sd	ra,8(sp)
 c80:	e022                	sd	s0,0(sp)
 c82:	0800                	addi	s0,sp,16
    // Ensure there is at least one thread in the runqueue
    if (setjmp(env_st) == 0){
 c84:	00000517          	auipc	a0,0x0
 c88:	12450513          	addi	a0,a0,292 # da8 <env_st>
 c8c:	00000097          	auipc	ra,0x0
 c90:	c22080e7          	jalr	-990(ra) # 8ae <setjmp>
 c94:	c909                	beqz	a0,ca6 <thread_start_threading+0x2a>
        dispatch();
    }
    else{ // all threads had exited, return to main 
        current_thread = NULL;
 c96:	00000797          	auipc	a5,0x0
 c9a:	0e07bd23          	sd	zero,250(a5) # d90 <current_thread>
        return;
    }
}
 c9e:	60a2                	ld	ra,8(sp)
 ca0:	6402                	ld	s0,0(sp)
 ca2:	0141                	addi	sp,sp,16
 ca4:	8082                	ret
        dispatch();
 ca6:	00000097          	auipc	ra,0x0
 caa:	e0e080e7          	jalr	-498(ra) # ab4 <dispatch>
 cae:	bfc5                	j	c9e <thread_start_threading+0x22>

0000000000000cb0 <thread_assign_task>:

// part 2
void thread_assign_task(struct thread *t, void (*f)(void *), void *arg) {
 cb0:	7179                	addi	sp,sp,-48
 cb2:	f406                	sd	ra,40(sp)
 cb4:	f022                	sd	s0,32(sp)
 cb6:	ec26                	sd	s1,24(sp)
 cb8:	e84a                	sd	s2,16(sp)
 cba:	e44e                	sd	s3,8(sp)
 cbc:	e052                	sd	s4,0(sp)
 cbe:	1800                	addi	s0,sp,48
 cc0:	892a                	mv	s2,a0
 cc2:	8a2e                	mv	s4,a1
 cc4:	89b2                	mv	s3,a2
    struct task *new_task = malloc(sizeof(struct task));
 cc6:	0a800513          	li	a0,168
 cca:	00000097          	auipc	ra,0x0
 cce:	b00080e7          	jalr	-1280(ra) # 7ca <malloc>
 cd2:	84aa                	mv	s1,a0
    new_task->function = f;
 cd4:	01453023          	sd	s4,0(a0)
    new_task->arg = arg;
 cd8:	01353423          	sd	s3,8(a0)
    new_task->buf_set = 0;
 cdc:	0a052023          	sw	zero,160(a0)

    // Allocate stack for the task and set stack pointer
    unsigned long task_stack = (unsigned long) malloc(sizeof(unsigned long) * 0x100);
 ce0:	6505                	lui	a0,0x1
 ce2:	80050513          	addi	a0,a0,-2048 # 800 <malloc+0x36>
 ce6:	00000097          	auipc	ra,0x0
 cea:	ae4080e7          	jalr	-1308(ra) # 7ca <malloc>
    new_task->stack = (void *)task_stack;
 cee:	e888                	sd	a0,16(s1)
    new_task->stack_p = (void *)(task_stack + 0x100 * 8 - 0x2 * 8);
 cf0:	7f050513          	addi	a0,a0,2032
 cf4:	ec88                	sd	a0,24(s1)

    // Insert the new task at the head of the list
    new_task->next = t->head_task;
 cf6:	0a093783          	ld	a5,160(s2)
 cfa:	f09c                	sd	a5,32(s1)
    new_task->prev = NULL; // As it's the new head, prev is NULL
 cfc:	0204b423          	sd	zero,40(s1)

    // If there's already a task, set its prev to the new task
    if (t->head_task != NULL) {
 d00:	0a093783          	ld	a5,160(s2)
 d04:	c391                	beqz	a5,d08 <thread_assign_task+0x58>
        t->head_task->prev = new_task;
 d06:	f784                	sd	s1,40(a5)
    }

    // Update the thread's current task pointer
    t->head_task = new_task;
 d08:	0a993023          	sd	s1,160(s2)
    t->task_num++;
 d0c:	09c92783          	lw	a5,156(s2)
 d10:	2785                	addiw	a5,a5,1
 d12:	08f92e23          	sw	a5,156(s2)
    return;
 d16:	70a2                	ld	ra,40(sp)
 d18:	7402                	ld	s0,32(sp)
 d1a:	64e2                	ld	s1,24(sp)
 d1c:	6942                	ld	s2,16(sp)
 d1e:	69a2                	ld	s3,8(sp)
 d20:	6a02                	ld	s4,0(sp)
 d22:	6145                	addi	sp,sp,48
 d24:	8082                	ret
