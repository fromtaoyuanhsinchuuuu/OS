
user/_custom_5:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#define PG_SIZE 4096
#define NR_PG 16

/* lru, pin, unpin, swap*/

int main(int argc, char *argv[]) {
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	f04a                	sd	s2,32(sp)
   a:	ec4e                	sd	s3,24(sp)
   c:	e852                	sd	s4,16(sp)
   e:	e456                	sd	s5,8(sp)
  10:	e05a                	sd	s6,0(sp)
  12:	0080                	addi	s0,sp,64
  vmprint();
  14:	00000097          	auipc	ra,0x0
  18:	4ee080e7          	jalr	1262(ra) # 502 <vmprint>
  char *ptr = malloc(NR_PG * PG_SIZE);
  1c:	6541                	lui	a0,0x10
  1e:	00001097          	auipc	ra,0x1
  22:	896080e7          	jalr	-1898(ra) # 8b4 <malloc>
  26:	8b2a                	mv	s6,a0
  printf("After malloc\n");
  28:	00001517          	auipc	a0,0x1
  2c:	97050513          	addi	a0,a0,-1680 # 998 <malloc+0xe4>
  30:	00000097          	auipc	ra,0x0
  34:	7c6080e7          	jalr	1990(ra) # 7f6 <printf>
  vmprint();
  38:	00000097          	auipc	ra,0x0
  3c:	4ca080e7          	jalr	1226(ra) # 502 <vmprint>
  madvise((uint64) ptr + 3*PG_SIZE, PG_SIZE,  MADV_PIN); //pin 6
  40:	648d                	lui	s1,0x3
  42:	94da                	add	s1,s1,s6
  44:	460d                	li	a2,3
  46:	6585                	lui	a1,0x1
  48:	8526                	mv	a0,s1
  4a:	00000097          	auipc	ra,0x0
  4e:	4c0080e7          	jalr	1216(ra) # 50a <madvise>
  printf("After madvise(MADV_PIN)\n");
  52:	00001517          	auipc	a0,0x1
  56:	95650513          	addi	a0,a0,-1706 # 9a8 <malloc+0xf4>
  5a:	00000097          	auipc	ra,0x0
  5e:	79c080e7          	jalr	1948(ra) # 7f6 <printf>
  pgprint();
  62:	00000097          	auipc	ra,0x0
  66:	4b2080e7          	jalr	1202(ra) # 514 <pgprint>

  madvise((uint64) ptr + 4*PG_SIZE, 3*PG_SIZE,  MADV_DONTNEED); //dontneed 7 8 9
  6a:	4609                	li	a2,2
  6c:	658d                	lui	a1,0x3
  6e:	6511                	lui	a0,0x4
  70:	955a                	add	a0,a0,s6
  72:	00000097          	auipc	ra,0x0
  76:	498080e7          	jalr	1176(ra) # 50a <madvise>
  printf("After madvise(MADV_DONTNEED)\n");
  7a:	00001517          	auipc	a0,0x1
  7e:	94e50513          	addi	a0,a0,-1714 # 9c8 <malloc+0x114>
  82:	00000097          	auipc	ra,0x0
  86:	774080e7          	jalr	1908(ra) # 7f6 <printf>
  vmprint();
  8a:	00000097          	auipc	ra,0x0
  8e:	478080e7          	jalr	1144(ra) # 502 <vmprint>
  pgprint();
  92:	00000097          	auipc	ra,0x0
  96:	482080e7          	jalr	1154(ra) # 514 <pgprint>

  char *qtr;
  qtr = ptr + 5*PG_SIZE;
  *qtr = 'a'; //swap in 8
  9a:	6795                	lui	a5,0x5
  9c:	97da                	add	a5,a5,s6
  9e:	06100713          	li	a4,97
  a2:	00e78023          	sb	a4,0(a5) # 5000 <__global_pointer$+0x3d4f>
  printf("Page fault and swap in\n");
  a6:	00001517          	auipc	a0,0x1
  aa:	94250513          	addi	a0,a0,-1726 # 9e8 <malloc+0x134>
  ae:	00000097          	auipc	ra,0x0
  b2:	748080e7          	jalr	1864(ra) # 7f6 <printf>
  vmprint();
  b6:	00000097          	auipc	ra,0x0
  ba:	44c080e7          	jalr	1100(ra) # 502 <vmprint>
  pgprint();
  be:	00000097          	auipc	ra,0x0
  c2:	456080e7          	jalr	1110(ra) # 514 <pgprint>

  madvise((uint64) ptr + 3*PG_SIZE, PG_SIZE,  MADV_UNPIN); //unpin 6
  c6:	4611                	li	a2,4
  c8:	6585                	lui	a1,0x1
  ca:	8526                	mv	a0,s1
  cc:	00000097          	auipc	ra,0x0
  d0:	43e080e7          	jalr	1086(ra) # 50a <madvise>
  printf("After unpin 6\n");
  d4:	00001517          	auipc	a0,0x1
  d8:	92c50513          	addi	a0,a0,-1748 # a00 <malloc+0x14c>
  dc:	00000097          	auipc	ra,0x0
  e0:	71a080e7          	jalr	1818(ra) # 7f6 <printf>
  vmprint();
  e4:	00000097          	auipc	ra,0x0
  e8:	41e080e7          	jalr	1054(ra) # 502 <vmprint>
  madvise((uint64) ptr + 3*PG_SIZE, PG_SIZE,  MADV_DONTNEED); //dontneed 6
  ec:	4609                	li	a2,2
  ee:	6585                	lui	a1,0x1
  f0:	8526                	mv	a0,s1
  f2:	00000097          	auipc	ra,0x0
  f6:	418080e7          	jalr	1048(ra) # 50a <madvise>
  printf("After dontneed 6\n");
  fa:	00001517          	auipc	a0,0x1
  fe:	91650513          	addi	a0,a0,-1770 # a10 <malloc+0x15c>
 102:	00000097          	auipc	ra,0x0
 106:	6f4080e7          	jalr	1780(ra) # 7f6 <printf>
  vmprint();
 10a:	00000097          	auipc	ra,0x0
 10e:	3f8080e7          	jalr	1016(ra) # 502 <vmprint>
  pgprint();
 112:	00000097          	auipc	ra,0x0
 116:	402080e7          	jalr	1026(ra) # 514 <pgprint>

  madvise((uint64) ptr + 3*PG_SIZE, 4*PG_SIZE,  MADV_WILLNEED); //willneed 6 7 8 9
 11a:	4605                	li	a2,1
 11c:	6591                	lui	a1,0x4
 11e:	8526                	mv	a0,s1
 120:	00000097          	auipc	ra,0x0
 124:	3ea080e7          	jalr	1002(ra) # 50a <madvise>
  printf("After madvise(MADV_WILLNEED) 6 7 8 9\n");
 128:	00001517          	auipc	a0,0x1
 12c:	90050513          	addi	a0,a0,-1792 # a28 <malloc+0x174>
 130:	00000097          	auipc	ra,0x0
 134:	6c6080e7          	jalr	1734(ra) # 7f6 <printf>
  vmprint();
 138:	00000097          	auipc	ra,0x0
 13c:	3ca080e7          	jalr	970(ra) # 502 <vmprint>
  pgprint();
 140:	00000097          	auipc	ra,0x0
 144:	3d4080e7          	jalr	980(ra) # 514 <pgprint>

  //pin everything
  for (int i = 16;i >= 9;i--) {
 148:	6935                	lui	s2,0xd
 14a:	995a                	add	s2,s2,s6
 14c:	44c1                	li	s1,16
	madvise((uint64) ptr + (i-3)*PG_SIZE, PG_SIZE,  MADV_PIN);
	printf("After madvise(MADV_PIN) %d\n", i);
 14e:	00001a97          	auipc	s5,0x1
 152:	902a8a93          	addi	s5,s5,-1790 # a50 <malloc+0x19c>
 156:	7a7d                	lui	s4,0xfffff
  for (int i = 16;i >= 9;i--) {
 158:	49a1                	li	s3,8
	madvise((uint64) ptr + (i-3)*PG_SIZE, PG_SIZE,  MADV_PIN);
 15a:	460d                	li	a2,3
 15c:	6585                	lui	a1,0x1
 15e:	854a                	mv	a0,s2
 160:	00000097          	auipc	ra,0x0
 164:	3aa080e7          	jalr	938(ra) # 50a <madvise>
	printf("After madvise(MADV_PIN) %d\n", i);
 168:	85a6                	mv	a1,s1
 16a:	8556                	mv	a0,s5
 16c:	00000097          	auipc	ra,0x0
 170:	68a080e7          	jalr	1674(ra) # 7f6 <printf>
	vmprint();
 174:	00000097          	auipc	ra,0x0
 178:	38e080e7          	jalr	910(ra) # 502 <vmprint>
	pgprint();
 17c:	00000097          	auipc	ra,0x0
 180:	398080e7          	jalr	920(ra) # 514 <pgprint>
  for (int i = 16;i >= 9;i--) {
 184:	34fd                	addiw	s1,s1,-1
 186:	9952                	add	s2,s2,s4
 188:	fd3499e3          	bne	s1,s3,15a <main+0x15a>
  }

  madvise((uint64) ptr + 14*PG_SIZE, PG_SIZE,  MADV_WILLNEED); //willneed 17
 18c:	4605                	li	a2,1
 18e:	6585                	lui	a1,0x1
 190:	6539                	lui	a0,0xe
 192:	955a                	add	a0,a0,s6
 194:	00000097          	auipc	ra,0x0
 198:	376080e7          	jalr	886(ra) # 50a <madvise>
  printf("After madvise(MADV_WILLNEED) 17\n");
 19c:	00001517          	auipc	a0,0x1
 1a0:	8d450513          	addi	a0,a0,-1836 # a70 <malloc+0x1bc>
 1a4:	00000097          	auipc	ra,0x0
 1a8:	652080e7          	jalr	1618(ra) # 7f6 <printf>
  vmprint();
 1ac:	00000097          	auipc	ra,0x0
 1b0:	356080e7          	jalr	854(ra) # 502 <vmprint>
  pgprint();
 1b4:	00000097          	auipc	ra,0x0
 1b8:	360080e7          	jalr	864(ra) # 514 <pgprint>
  exit(0);
 1bc:	4501                	li	a0,0
 1be:	00000097          	auipc	ra,0x0
 1c2:	294080e7          	jalr	660(ra) # 452 <exit>

00000000000001c6 <strcpy>:



char*
strcpy(char *s, const char *t)
{
 1c6:	1141                	addi	sp,sp,-16
 1c8:	e422                	sd	s0,8(sp)
 1ca:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1cc:	87aa                	mv	a5,a0
 1ce:	0585                	addi	a1,a1,1
 1d0:	0785                	addi	a5,a5,1
 1d2:	fff5c703          	lbu	a4,-1(a1) # fff <__BSS_END__+0x52f>
 1d6:	fee78fa3          	sb	a4,-1(a5)
 1da:	fb75                	bnez	a4,1ce <strcpy+0x8>
    ;
  return os;
}
 1dc:	6422                	ld	s0,8(sp)
 1de:	0141                	addi	sp,sp,16
 1e0:	8082                	ret

00000000000001e2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1e2:	1141                	addi	sp,sp,-16
 1e4:	e422                	sd	s0,8(sp)
 1e6:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1e8:	00054783          	lbu	a5,0(a0)
 1ec:	cb91                	beqz	a5,200 <strcmp+0x1e>
 1ee:	0005c703          	lbu	a4,0(a1)
 1f2:	00f71763          	bne	a4,a5,200 <strcmp+0x1e>
    p++, q++;
 1f6:	0505                	addi	a0,a0,1
 1f8:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1fa:	00054783          	lbu	a5,0(a0)
 1fe:	fbe5                	bnez	a5,1ee <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 200:	0005c503          	lbu	a0,0(a1)
}
 204:	40a7853b          	subw	a0,a5,a0
 208:	6422                	ld	s0,8(sp)
 20a:	0141                	addi	sp,sp,16
 20c:	8082                	ret

000000000000020e <strlen>:

uint
strlen(const char *s)
{
 20e:	1141                	addi	sp,sp,-16
 210:	e422                	sd	s0,8(sp)
 212:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 214:	00054783          	lbu	a5,0(a0)
 218:	cf91                	beqz	a5,234 <strlen+0x26>
 21a:	0505                	addi	a0,a0,1
 21c:	87aa                	mv	a5,a0
 21e:	4685                	li	a3,1
 220:	9e89                	subw	a3,a3,a0
 222:	00f6853b          	addw	a0,a3,a5
 226:	0785                	addi	a5,a5,1
 228:	fff7c703          	lbu	a4,-1(a5)
 22c:	fb7d                	bnez	a4,222 <strlen+0x14>
    ;
  return n;
}
 22e:	6422                	ld	s0,8(sp)
 230:	0141                	addi	sp,sp,16
 232:	8082                	ret
  for(n = 0; s[n]; n++)
 234:	4501                	li	a0,0
 236:	bfe5                	j	22e <strlen+0x20>

0000000000000238 <memset>:

void*
memset(void *dst, int c, uint n)
{
 238:	1141                	addi	sp,sp,-16
 23a:	e422                	sd	s0,8(sp)
 23c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 23e:	ce09                	beqz	a2,258 <memset+0x20>
 240:	87aa                	mv	a5,a0
 242:	fff6071b          	addiw	a4,a2,-1
 246:	1702                	slli	a4,a4,0x20
 248:	9301                	srli	a4,a4,0x20
 24a:	0705                	addi	a4,a4,1
 24c:	972a                	add	a4,a4,a0
    cdst[i] = c;
 24e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 252:	0785                	addi	a5,a5,1
 254:	fee79de3          	bne	a5,a4,24e <memset+0x16>
  }
  return dst;
}
 258:	6422                	ld	s0,8(sp)
 25a:	0141                	addi	sp,sp,16
 25c:	8082                	ret

000000000000025e <strchr>:

char*
strchr(const char *s, char c)
{
 25e:	1141                	addi	sp,sp,-16
 260:	e422                	sd	s0,8(sp)
 262:	0800                	addi	s0,sp,16
  for(; *s; s++)
 264:	00054783          	lbu	a5,0(a0)
 268:	cb99                	beqz	a5,27e <strchr+0x20>
    if(*s == c)
 26a:	00f58763          	beq	a1,a5,278 <strchr+0x1a>
  for(; *s; s++)
 26e:	0505                	addi	a0,a0,1
 270:	00054783          	lbu	a5,0(a0)
 274:	fbfd                	bnez	a5,26a <strchr+0xc>
      return (char*)s;
  return 0;
 276:	4501                	li	a0,0
}
 278:	6422                	ld	s0,8(sp)
 27a:	0141                	addi	sp,sp,16
 27c:	8082                	ret
  return 0;
 27e:	4501                	li	a0,0
 280:	bfe5                	j	278 <strchr+0x1a>

0000000000000282 <gets>:

char*
gets(char *buf, int max)
{
 282:	711d                	addi	sp,sp,-96
 284:	ec86                	sd	ra,88(sp)
 286:	e8a2                	sd	s0,80(sp)
 288:	e4a6                	sd	s1,72(sp)
 28a:	e0ca                	sd	s2,64(sp)
 28c:	fc4e                	sd	s3,56(sp)
 28e:	f852                	sd	s4,48(sp)
 290:	f456                	sd	s5,40(sp)
 292:	f05a                	sd	s6,32(sp)
 294:	ec5e                	sd	s7,24(sp)
 296:	1080                	addi	s0,sp,96
 298:	8baa                	mv	s7,a0
 29a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 29c:	892a                	mv	s2,a0
 29e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2a0:	4aa9                	li	s5,10
 2a2:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 2a4:	89a6                	mv	s3,s1
 2a6:	2485                	addiw	s1,s1,1
 2a8:	0344d863          	bge	s1,s4,2d8 <gets+0x56>
    cc = read(0, &c, 1);
 2ac:	4605                	li	a2,1
 2ae:	faf40593          	addi	a1,s0,-81
 2b2:	4501                	li	a0,0
 2b4:	00000097          	auipc	ra,0x0
 2b8:	1b6080e7          	jalr	438(ra) # 46a <read>
    if(cc < 1)
 2bc:	00a05e63          	blez	a0,2d8 <gets+0x56>
    buf[i++] = c;
 2c0:	faf44783          	lbu	a5,-81(s0)
 2c4:	00f90023          	sb	a5,0(s2) # d000 <__global_pointer$+0xbd4f>
    if(c == '\n' || c == '\r')
 2c8:	01578763          	beq	a5,s5,2d6 <gets+0x54>
 2cc:	0905                	addi	s2,s2,1
 2ce:	fd679be3          	bne	a5,s6,2a4 <gets+0x22>
  for(i=0; i+1 < max; ){
 2d2:	89a6                	mv	s3,s1
 2d4:	a011                	j	2d8 <gets+0x56>
 2d6:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2d8:	99de                	add	s3,s3,s7
 2da:	00098023          	sb	zero,0(s3)
  return buf;
}
 2de:	855e                	mv	a0,s7
 2e0:	60e6                	ld	ra,88(sp)
 2e2:	6446                	ld	s0,80(sp)
 2e4:	64a6                	ld	s1,72(sp)
 2e6:	6906                	ld	s2,64(sp)
 2e8:	79e2                	ld	s3,56(sp)
 2ea:	7a42                	ld	s4,48(sp)
 2ec:	7aa2                	ld	s5,40(sp)
 2ee:	7b02                	ld	s6,32(sp)
 2f0:	6be2                	ld	s7,24(sp)
 2f2:	6125                	addi	sp,sp,96
 2f4:	8082                	ret

00000000000002f6 <stat>:

int
stat(const char *n, struct stat *st)
{
 2f6:	1101                	addi	sp,sp,-32
 2f8:	ec06                	sd	ra,24(sp)
 2fa:	e822                	sd	s0,16(sp)
 2fc:	e426                	sd	s1,8(sp)
 2fe:	e04a                	sd	s2,0(sp)
 300:	1000                	addi	s0,sp,32
 302:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 304:	4581                	li	a1,0
 306:	00000097          	auipc	ra,0x0
 30a:	18c080e7          	jalr	396(ra) # 492 <open>
  if(fd < 0)
 30e:	02054563          	bltz	a0,338 <stat+0x42>
 312:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 314:	85ca                	mv	a1,s2
 316:	00000097          	auipc	ra,0x0
 31a:	194080e7          	jalr	404(ra) # 4aa <fstat>
 31e:	892a                	mv	s2,a0
  close(fd);
 320:	8526                	mv	a0,s1
 322:	00000097          	auipc	ra,0x0
 326:	158080e7          	jalr	344(ra) # 47a <close>
  return r;
}
 32a:	854a                	mv	a0,s2
 32c:	60e2                	ld	ra,24(sp)
 32e:	6442                	ld	s0,16(sp)
 330:	64a2                	ld	s1,8(sp)
 332:	6902                	ld	s2,0(sp)
 334:	6105                	addi	sp,sp,32
 336:	8082                	ret
    return -1;
 338:	597d                	li	s2,-1
 33a:	bfc5                	j	32a <stat+0x34>

000000000000033c <atoi>:

int
atoi(const char *s)
{
 33c:	1141                	addi	sp,sp,-16
 33e:	e422                	sd	s0,8(sp)
 340:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 342:	00054603          	lbu	a2,0(a0)
 346:	fd06079b          	addiw	a5,a2,-48
 34a:	0ff7f793          	andi	a5,a5,255
 34e:	4725                	li	a4,9
 350:	02f76963          	bltu	a4,a5,382 <atoi+0x46>
 354:	86aa                	mv	a3,a0
  n = 0;
 356:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 358:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 35a:	0685                	addi	a3,a3,1
 35c:	0025179b          	slliw	a5,a0,0x2
 360:	9fa9                	addw	a5,a5,a0
 362:	0017979b          	slliw	a5,a5,0x1
 366:	9fb1                	addw	a5,a5,a2
 368:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 36c:	0006c603          	lbu	a2,0(a3)
 370:	fd06071b          	addiw	a4,a2,-48
 374:	0ff77713          	andi	a4,a4,255
 378:	fee5f1e3          	bgeu	a1,a4,35a <atoi+0x1e>
  return n;
}
 37c:	6422                	ld	s0,8(sp)
 37e:	0141                	addi	sp,sp,16
 380:	8082                	ret
  n = 0;
 382:	4501                	li	a0,0
 384:	bfe5                	j	37c <atoi+0x40>

0000000000000386 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 386:	1141                	addi	sp,sp,-16
 388:	e422                	sd	s0,8(sp)
 38a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 38c:	02b57663          	bgeu	a0,a1,3b8 <memmove+0x32>
    while(n-- > 0)
 390:	02c05163          	blez	a2,3b2 <memmove+0x2c>
 394:	fff6079b          	addiw	a5,a2,-1
 398:	1782                	slli	a5,a5,0x20
 39a:	9381                	srli	a5,a5,0x20
 39c:	0785                	addi	a5,a5,1
 39e:	97aa                	add	a5,a5,a0
  dst = vdst;
 3a0:	872a                	mv	a4,a0
      *dst++ = *src++;
 3a2:	0585                	addi	a1,a1,1
 3a4:	0705                	addi	a4,a4,1
 3a6:	fff5c683          	lbu	a3,-1(a1)
 3aa:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 3ae:	fee79ae3          	bne	a5,a4,3a2 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3b2:	6422                	ld	s0,8(sp)
 3b4:	0141                	addi	sp,sp,16
 3b6:	8082                	ret
    dst += n;
 3b8:	00c50733          	add	a4,a0,a2
    src += n;
 3bc:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3be:	fec05ae3          	blez	a2,3b2 <memmove+0x2c>
 3c2:	fff6079b          	addiw	a5,a2,-1
 3c6:	1782                	slli	a5,a5,0x20
 3c8:	9381                	srli	a5,a5,0x20
 3ca:	fff7c793          	not	a5,a5
 3ce:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3d0:	15fd                	addi	a1,a1,-1
 3d2:	177d                	addi	a4,a4,-1
 3d4:	0005c683          	lbu	a3,0(a1)
 3d8:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3dc:	fee79ae3          	bne	a5,a4,3d0 <memmove+0x4a>
 3e0:	bfc9                	j	3b2 <memmove+0x2c>

00000000000003e2 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3e2:	1141                	addi	sp,sp,-16
 3e4:	e422                	sd	s0,8(sp)
 3e6:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3e8:	ca05                	beqz	a2,418 <memcmp+0x36>
 3ea:	fff6069b          	addiw	a3,a2,-1
 3ee:	1682                	slli	a3,a3,0x20
 3f0:	9281                	srli	a3,a3,0x20
 3f2:	0685                	addi	a3,a3,1
 3f4:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3f6:	00054783          	lbu	a5,0(a0)
 3fa:	0005c703          	lbu	a4,0(a1)
 3fe:	00e79863          	bne	a5,a4,40e <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 402:	0505                	addi	a0,a0,1
    p2++;
 404:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 406:	fed518e3          	bne	a0,a3,3f6 <memcmp+0x14>
  }
  return 0;
 40a:	4501                	li	a0,0
 40c:	a019                	j	412 <memcmp+0x30>
      return *p1 - *p2;
 40e:	40e7853b          	subw	a0,a5,a4
}
 412:	6422                	ld	s0,8(sp)
 414:	0141                	addi	sp,sp,16
 416:	8082                	ret
  return 0;
 418:	4501                	li	a0,0
 41a:	bfe5                	j	412 <memcmp+0x30>

000000000000041c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 41c:	1141                	addi	sp,sp,-16
 41e:	e406                	sd	ra,8(sp)
 420:	e022                	sd	s0,0(sp)
 422:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 424:	00000097          	auipc	ra,0x0
 428:	f62080e7          	jalr	-158(ra) # 386 <memmove>
}
 42c:	60a2                	ld	ra,8(sp)
 42e:	6402                	ld	s0,0(sp)
 430:	0141                	addi	sp,sp,16
 432:	8082                	ret

0000000000000434 <ugetpid>:

#ifdef LAB_PGTBL
int
ugetpid(void)
{
 434:	1141                	addi	sp,sp,-16
 436:	e422                	sd	s0,8(sp)
 438:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 43a:	040007b7          	lui	a5,0x4000
}
 43e:	17f5                	addi	a5,a5,-3
 440:	07b2                	slli	a5,a5,0xc
 442:	4388                	lw	a0,0(a5)
 444:	6422                	ld	s0,8(sp)
 446:	0141                	addi	sp,sp,16
 448:	8082                	ret

000000000000044a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 44a:	4885                	li	a7,1
 ecall
 44c:	00000073          	ecall
 ret
 450:	8082                	ret

0000000000000452 <exit>:
.global exit
exit:
 li a7, SYS_exit
 452:	4889                	li	a7,2
 ecall
 454:	00000073          	ecall
 ret
 458:	8082                	ret

000000000000045a <wait>:
.global wait
wait:
 li a7, SYS_wait
 45a:	488d                	li	a7,3
 ecall
 45c:	00000073          	ecall
 ret
 460:	8082                	ret

0000000000000462 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 462:	4891                	li	a7,4
 ecall
 464:	00000073          	ecall
 ret
 468:	8082                	ret

000000000000046a <read>:
.global read
read:
 li a7, SYS_read
 46a:	4895                	li	a7,5
 ecall
 46c:	00000073          	ecall
 ret
 470:	8082                	ret

0000000000000472 <write>:
.global write
write:
 li a7, SYS_write
 472:	48c1                	li	a7,16
 ecall
 474:	00000073          	ecall
 ret
 478:	8082                	ret

000000000000047a <close>:
.global close
close:
 li a7, SYS_close
 47a:	48d5                	li	a7,21
 ecall
 47c:	00000073          	ecall
 ret
 480:	8082                	ret

0000000000000482 <kill>:
.global kill
kill:
 li a7, SYS_kill
 482:	4899                	li	a7,6
 ecall
 484:	00000073          	ecall
 ret
 488:	8082                	ret

000000000000048a <exec>:
.global exec
exec:
 li a7, SYS_exec
 48a:	489d                	li	a7,7
 ecall
 48c:	00000073          	ecall
 ret
 490:	8082                	ret

0000000000000492 <open>:
.global open
open:
 li a7, SYS_open
 492:	48bd                	li	a7,15
 ecall
 494:	00000073          	ecall
 ret
 498:	8082                	ret

000000000000049a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 49a:	48c5                	li	a7,17
 ecall
 49c:	00000073          	ecall
 ret
 4a0:	8082                	ret

00000000000004a2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4a2:	48c9                	li	a7,18
 ecall
 4a4:	00000073          	ecall
 ret
 4a8:	8082                	ret

00000000000004aa <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4aa:	48a1                	li	a7,8
 ecall
 4ac:	00000073          	ecall
 ret
 4b0:	8082                	ret

00000000000004b2 <link>:
.global link
link:
 li a7, SYS_link
 4b2:	48cd                	li	a7,19
 ecall
 4b4:	00000073          	ecall
 ret
 4b8:	8082                	ret

00000000000004ba <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4ba:	48d1                	li	a7,20
 ecall
 4bc:	00000073          	ecall
 ret
 4c0:	8082                	ret

00000000000004c2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4c2:	48a5                	li	a7,9
 ecall
 4c4:	00000073          	ecall
 ret
 4c8:	8082                	ret

00000000000004ca <dup>:
.global dup
dup:
 li a7, SYS_dup
 4ca:	48a9                	li	a7,10
 ecall
 4cc:	00000073          	ecall
 ret
 4d0:	8082                	ret

00000000000004d2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4d2:	48ad                	li	a7,11
 ecall
 4d4:	00000073          	ecall
 ret
 4d8:	8082                	ret

00000000000004da <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4da:	48b1                	li	a7,12
 ecall
 4dc:	00000073          	ecall
 ret
 4e0:	8082                	ret

00000000000004e2 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4e2:	48b5                	li	a7,13
 ecall
 4e4:	00000073          	ecall
 ret
 4e8:	8082                	ret

00000000000004ea <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4ea:	48b9                	li	a7,14
 ecall
 4ec:	00000073          	ecall
 ret
 4f0:	8082                	ret

00000000000004f2 <connect>:
.global connect
connect:
 li a7, SYS_connect
 4f2:	48f5                	li	a7,29
 ecall
 4f4:	00000073          	ecall
 ret
 4f8:	8082                	ret

00000000000004fa <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 4fa:	48f9                	li	a7,30
 ecall
 4fc:	00000073          	ecall
 ret
 500:	8082                	ret

0000000000000502 <vmprint>:
.global vmprint
vmprint:
 li a7, SYS_vmprint
 502:	48fd                	li	a7,31
 ecall
 504:	00000073          	ecall
 ret
 508:	8082                	ret

000000000000050a <madvise>:
.global madvise
madvise:
 li a7, SYS_madvise
 50a:	02000893          	li	a7,32
 ecall
 50e:	00000073          	ecall
 ret
 512:	8082                	ret

0000000000000514 <pgprint>:
.global pgprint
pgprint:
 li a7, SYS_pgprint
 514:	02100893          	li	a7,33
 ecall
 518:	00000073          	ecall
 ret
 51c:	8082                	ret

000000000000051e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 51e:	1101                	addi	sp,sp,-32
 520:	ec06                	sd	ra,24(sp)
 522:	e822                	sd	s0,16(sp)
 524:	1000                	addi	s0,sp,32
 526:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 52a:	4605                	li	a2,1
 52c:	fef40593          	addi	a1,s0,-17
 530:	00000097          	auipc	ra,0x0
 534:	f42080e7          	jalr	-190(ra) # 472 <write>
}
 538:	60e2                	ld	ra,24(sp)
 53a:	6442                	ld	s0,16(sp)
 53c:	6105                	addi	sp,sp,32
 53e:	8082                	ret

0000000000000540 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 540:	7139                	addi	sp,sp,-64
 542:	fc06                	sd	ra,56(sp)
 544:	f822                	sd	s0,48(sp)
 546:	f426                	sd	s1,40(sp)
 548:	f04a                	sd	s2,32(sp)
 54a:	ec4e                	sd	s3,24(sp)
 54c:	0080                	addi	s0,sp,64
 54e:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 550:	c299                	beqz	a3,556 <printint+0x16>
 552:	0805c863          	bltz	a1,5e2 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 556:	2581                	sext.w	a1,a1
  neg = 0;
 558:	4881                	li	a7,0
 55a:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 55e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 560:	2601                	sext.w	a2,a2
 562:	00000517          	auipc	a0,0x0
 566:	53e50513          	addi	a0,a0,1342 # aa0 <digits>
 56a:	883a                	mv	a6,a4
 56c:	2705                	addiw	a4,a4,1
 56e:	02c5f7bb          	remuw	a5,a1,a2
 572:	1782                	slli	a5,a5,0x20
 574:	9381                	srli	a5,a5,0x20
 576:	97aa                	add	a5,a5,a0
 578:	0007c783          	lbu	a5,0(a5) # 4000000 <__global_pointer$+0x3ffed4f>
 57c:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 580:	0005879b          	sext.w	a5,a1
 584:	02c5d5bb          	divuw	a1,a1,a2
 588:	0685                	addi	a3,a3,1
 58a:	fec7f0e3          	bgeu	a5,a2,56a <printint+0x2a>
  if(neg)
 58e:	00088b63          	beqz	a7,5a4 <printint+0x64>
    buf[i++] = '-';
 592:	fd040793          	addi	a5,s0,-48
 596:	973e                	add	a4,a4,a5
 598:	02d00793          	li	a5,45
 59c:	fef70823          	sb	a5,-16(a4)
 5a0:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 5a4:	02e05863          	blez	a4,5d4 <printint+0x94>
 5a8:	fc040793          	addi	a5,s0,-64
 5ac:	00e78933          	add	s2,a5,a4
 5b0:	fff78993          	addi	s3,a5,-1
 5b4:	99ba                	add	s3,s3,a4
 5b6:	377d                	addiw	a4,a4,-1
 5b8:	1702                	slli	a4,a4,0x20
 5ba:	9301                	srli	a4,a4,0x20
 5bc:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 5c0:	fff94583          	lbu	a1,-1(s2)
 5c4:	8526                	mv	a0,s1
 5c6:	00000097          	auipc	ra,0x0
 5ca:	f58080e7          	jalr	-168(ra) # 51e <putc>
  while(--i >= 0)
 5ce:	197d                	addi	s2,s2,-1
 5d0:	ff3918e3          	bne	s2,s3,5c0 <printint+0x80>
}
 5d4:	70e2                	ld	ra,56(sp)
 5d6:	7442                	ld	s0,48(sp)
 5d8:	74a2                	ld	s1,40(sp)
 5da:	7902                	ld	s2,32(sp)
 5dc:	69e2                	ld	s3,24(sp)
 5de:	6121                	addi	sp,sp,64
 5e0:	8082                	ret
    x = -xx;
 5e2:	40b005bb          	negw	a1,a1
    neg = 1;
 5e6:	4885                	li	a7,1
    x = -xx;
 5e8:	bf8d                	j	55a <printint+0x1a>

00000000000005ea <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5ea:	7119                	addi	sp,sp,-128
 5ec:	fc86                	sd	ra,120(sp)
 5ee:	f8a2                	sd	s0,112(sp)
 5f0:	f4a6                	sd	s1,104(sp)
 5f2:	f0ca                	sd	s2,96(sp)
 5f4:	ecce                	sd	s3,88(sp)
 5f6:	e8d2                	sd	s4,80(sp)
 5f8:	e4d6                	sd	s5,72(sp)
 5fa:	e0da                	sd	s6,64(sp)
 5fc:	fc5e                	sd	s7,56(sp)
 5fe:	f862                	sd	s8,48(sp)
 600:	f466                	sd	s9,40(sp)
 602:	f06a                	sd	s10,32(sp)
 604:	ec6e                	sd	s11,24(sp)
 606:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 608:	0005c903          	lbu	s2,0(a1)
 60c:	18090f63          	beqz	s2,7aa <vprintf+0x1c0>
 610:	8aaa                	mv	s5,a0
 612:	8b32                	mv	s6,a2
 614:	00158493          	addi	s1,a1,1
  state = 0;
 618:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 61a:	02500a13          	li	s4,37
      if(c == 'd'){
 61e:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 622:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 626:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 62a:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 62e:	00000b97          	auipc	s7,0x0
 632:	472b8b93          	addi	s7,s7,1138 # aa0 <digits>
 636:	a839                	j	654 <vprintf+0x6a>
        putc(fd, c);
 638:	85ca                	mv	a1,s2
 63a:	8556                	mv	a0,s5
 63c:	00000097          	auipc	ra,0x0
 640:	ee2080e7          	jalr	-286(ra) # 51e <putc>
 644:	a019                	j	64a <vprintf+0x60>
    } else if(state == '%'){
 646:	01498f63          	beq	s3,s4,664 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 64a:	0485                	addi	s1,s1,1
 64c:	fff4c903          	lbu	s2,-1(s1) # 2fff <__global_pointer$+0x1d4e>
 650:	14090d63          	beqz	s2,7aa <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 654:	0009079b          	sext.w	a5,s2
    if(state == 0){
 658:	fe0997e3          	bnez	s3,646 <vprintf+0x5c>
      if(c == '%'){
 65c:	fd479ee3          	bne	a5,s4,638 <vprintf+0x4e>
        state = '%';
 660:	89be                	mv	s3,a5
 662:	b7e5                	j	64a <vprintf+0x60>
      if(c == 'd'){
 664:	05878063          	beq	a5,s8,6a4 <vprintf+0xba>
      } else if(c == 'l') {
 668:	05978c63          	beq	a5,s9,6c0 <vprintf+0xd6>
      } else if(c == 'x') {
 66c:	07a78863          	beq	a5,s10,6dc <vprintf+0xf2>
      } else if(c == 'p') {
 670:	09b78463          	beq	a5,s11,6f8 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 674:	07300713          	li	a4,115
 678:	0ce78663          	beq	a5,a4,744 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 67c:	06300713          	li	a4,99
 680:	0ee78e63          	beq	a5,a4,77c <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 684:	11478863          	beq	a5,s4,794 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 688:	85d2                	mv	a1,s4
 68a:	8556                	mv	a0,s5
 68c:	00000097          	auipc	ra,0x0
 690:	e92080e7          	jalr	-366(ra) # 51e <putc>
        putc(fd, c);
 694:	85ca                	mv	a1,s2
 696:	8556                	mv	a0,s5
 698:	00000097          	auipc	ra,0x0
 69c:	e86080e7          	jalr	-378(ra) # 51e <putc>
      }
      state = 0;
 6a0:	4981                	li	s3,0
 6a2:	b765                	j	64a <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 6a4:	008b0913          	addi	s2,s6,8
 6a8:	4685                	li	a3,1
 6aa:	4629                	li	a2,10
 6ac:	000b2583          	lw	a1,0(s6)
 6b0:	8556                	mv	a0,s5
 6b2:	00000097          	auipc	ra,0x0
 6b6:	e8e080e7          	jalr	-370(ra) # 540 <printint>
 6ba:	8b4a                	mv	s6,s2
      state = 0;
 6bc:	4981                	li	s3,0
 6be:	b771                	j	64a <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6c0:	008b0913          	addi	s2,s6,8
 6c4:	4681                	li	a3,0
 6c6:	4629                	li	a2,10
 6c8:	000b2583          	lw	a1,0(s6)
 6cc:	8556                	mv	a0,s5
 6ce:	00000097          	auipc	ra,0x0
 6d2:	e72080e7          	jalr	-398(ra) # 540 <printint>
 6d6:	8b4a                	mv	s6,s2
      state = 0;
 6d8:	4981                	li	s3,0
 6da:	bf85                	j	64a <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 6dc:	008b0913          	addi	s2,s6,8
 6e0:	4681                	li	a3,0
 6e2:	4641                	li	a2,16
 6e4:	000b2583          	lw	a1,0(s6)
 6e8:	8556                	mv	a0,s5
 6ea:	00000097          	auipc	ra,0x0
 6ee:	e56080e7          	jalr	-426(ra) # 540 <printint>
 6f2:	8b4a                	mv	s6,s2
      state = 0;
 6f4:	4981                	li	s3,0
 6f6:	bf91                	j	64a <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 6f8:	008b0793          	addi	a5,s6,8
 6fc:	f8f43423          	sd	a5,-120(s0)
 700:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 704:	03000593          	li	a1,48
 708:	8556                	mv	a0,s5
 70a:	00000097          	auipc	ra,0x0
 70e:	e14080e7          	jalr	-492(ra) # 51e <putc>
  putc(fd, 'x');
 712:	85ea                	mv	a1,s10
 714:	8556                	mv	a0,s5
 716:	00000097          	auipc	ra,0x0
 71a:	e08080e7          	jalr	-504(ra) # 51e <putc>
 71e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 720:	03c9d793          	srli	a5,s3,0x3c
 724:	97de                	add	a5,a5,s7
 726:	0007c583          	lbu	a1,0(a5)
 72a:	8556                	mv	a0,s5
 72c:	00000097          	auipc	ra,0x0
 730:	df2080e7          	jalr	-526(ra) # 51e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 734:	0992                	slli	s3,s3,0x4
 736:	397d                	addiw	s2,s2,-1
 738:	fe0914e3          	bnez	s2,720 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 73c:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 740:	4981                	li	s3,0
 742:	b721                	j	64a <vprintf+0x60>
        s = va_arg(ap, char*);
 744:	008b0993          	addi	s3,s6,8
 748:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 74c:	02090163          	beqz	s2,76e <vprintf+0x184>
        while(*s != 0){
 750:	00094583          	lbu	a1,0(s2)
 754:	c9a1                	beqz	a1,7a4 <vprintf+0x1ba>
          putc(fd, *s);
 756:	8556                	mv	a0,s5
 758:	00000097          	auipc	ra,0x0
 75c:	dc6080e7          	jalr	-570(ra) # 51e <putc>
          s++;
 760:	0905                	addi	s2,s2,1
        while(*s != 0){
 762:	00094583          	lbu	a1,0(s2)
 766:	f9e5                	bnez	a1,756 <vprintf+0x16c>
        s = va_arg(ap, char*);
 768:	8b4e                	mv	s6,s3
      state = 0;
 76a:	4981                	li	s3,0
 76c:	bdf9                	j	64a <vprintf+0x60>
          s = "(null)";
 76e:	00000917          	auipc	s2,0x0
 772:	32a90913          	addi	s2,s2,810 # a98 <malloc+0x1e4>
        while(*s != 0){
 776:	02800593          	li	a1,40
 77a:	bff1                	j	756 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 77c:	008b0913          	addi	s2,s6,8
 780:	000b4583          	lbu	a1,0(s6)
 784:	8556                	mv	a0,s5
 786:	00000097          	auipc	ra,0x0
 78a:	d98080e7          	jalr	-616(ra) # 51e <putc>
 78e:	8b4a                	mv	s6,s2
      state = 0;
 790:	4981                	li	s3,0
 792:	bd65                	j	64a <vprintf+0x60>
        putc(fd, c);
 794:	85d2                	mv	a1,s4
 796:	8556                	mv	a0,s5
 798:	00000097          	auipc	ra,0x0
 79c:	d86080e7          	jalr	-634(ra) # 51e <putc>
      state = 0;
 7a0:	4981                	li	s3,0
 7a2:	b565                	j	64a <vprintf+0x60>
        s = va_arg(ap, char*);
 7a4:	8b4e                	mv	s6,s3
      state = 0;
 7a6:	4981                	li	s3,0
 7a8:	b54d                	j	64a <vprintf+0x60>
    }
  }
}
 7aa:	70e6                	ld	ra,120(sp)
 7ac:	7446                	ld	s0,112(sp)
 7ae:	74a6                	ld	s1,104(sp)
 7b0:	7906                	ld	s2,96(sp)
 7b2:	69e6                	ld	s3,88(sp)
 7b4:	6a46                	ld	s4,80(sp)
 7b6:	6aa6                	ld	s5,72(sp)
 7b8:	6b06                	ld	s6,64(sp)
 7ba:	7be2                	ld	s7,56(sp)
 7bc:	7c42                	ld	s8,48(sp)
 7be:	7ca2                	ld	s9,40(sp)
 7c0:	7d02                	ld	s10,32(sp)
 7c2:	6de2                	ld	s11,24(sp)
 7c4:	6109                	addi	sp,sp,128
 7c6:	8082                	ret

00000000000007c8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7c8:	715d                	addi	sp,sp,-80
 7ca:	ec06                	sd	ra,24(sp)
 7cc:	e822                	sd	s0,16(sp)
 7ce:	1000                	addi	s0,sp,32
 7d0:	e010                	sd	a2,0(s0)
 7d2:	e414                	sd	a3,8(s0)
 7d4:	e818                	sd	a4,16(s0)
 7d6:	ec1c                	sd	a5,24(s0)
 7d8:	03043023          	sd	a6,32(s0)
 7dc:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7e0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7e4:	8622                	mv	a2,s0
 7e6:	00000097          	auipc	ra,0x0
 7ea:	e04080e7          	jalr	-508(ra) # 5ea <vprintf>
}
 7ee:	60e2                	ld	ra,24(sp)
 7f0:	6442                	ld	s0,16(sp)
 7f2:	6161                	addi	sp,sp,80
 7f4:	8082                	ret

00000000000007f6 <printf>:

void
printf(const char *fmt, ...)
{
 7f6:	711d                	addi	sp,sp,-96
 7f8:	ec06                	sd	ra,24(sp)
 7fa:	e822                	sd	s0,16(sp)
 7fc:	1000                	addi	s0,sp,32
 7fe:	e40c                	sd	a1,8(s0)
 800:	e810                	sd	a2,16(s0)
 802:	ec14                	sd	a3,24(s0)
 804:	f018                	sd	a4,32(s0)
 806:	f41c                	sd	a5,40(s0)
 808:	03043823          	sd	a6,48(s0)
 80c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 810:	00840613          	addi	a2,s0,8
 814:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 818:	85aa                	mv	a1,a0
 81a:	4505                	li	a0,1
 81c:	00000097          	auipc	ra,0x0
 820:	dce080e7          	jalr	-562(ra) # 5ea <vprintf>
}
 824:	60e2                	ld	ra,24(sp)
 826:	6442                	ld	s0,16(sp)
 828:	6125                	addi	sp,sp,96
 82a:	8082                	ret

000000000000082c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 82c:	1141                	addi	sp,sp,-16
 82e:	e422                	sd	s0,8(sp)
 830:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 832:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 836:	00000797          	auipc	a5,0x0
 83a:	2827b783          	ld	a5,642(a5) # ab8 <freep>
 83e:	a805                	j	86e <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 840:	4618                	lw	a4,8(a2)
 842:	9db9                	addw	a1,a1,a4
 844:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 848:	6398                	ld	a4,0(a5)
 84a:	6318                	ld	a4,0(a4)
 84c:	fee53823          	sd	a4,-16(a0)
 850:	a091                	j	894 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 852:	ff852703          	lw	a4,-8(a0)
 856:	9e39                	addw	a2,a2,a4
 858:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 85a:	ff053703          	ld	a4,-16(a0)
 85e:	e398                	sd	a4,0(a5)
 860:	a099                	j	8a6 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 862:	6398                	ld	a4,0(a5)
 864:	00e7e463          	bltu	a5,a4,86c <free+0x40>
 868:	00e6ea63          	bltu	a3,a4,87c <free+0x50>
{
 86c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 86e:	fed7fae3          	bgeu	a5,a3,862 <free+0x36>
 872:	6398                	ld	a4,0(a5)
 874:	00e6e463          	bltu	a3,a4,87c <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 878:	fee7eae3          	bltu	a5,a4,86c <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 87c:	ff852583          	lw	a1,-8(a0)
 880:	6390                	ld	a2,0(a5)
 882:	02059713          	slli	a4,a1,0x20
 886:	9301                	srli	a4,a4,0x20
 888:	0712                	slli	a4,a4,0x4
 88a:	9736                	add	a4,a4,a3
 88c:	fae60ae3          	beq	a2,a4,840 <free+0x14>
    bp->s.ptr = p->s.ptr;
 890:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 894:	4790                	lw	a2,8(a5)
 896:	02061713          	slli	a4,a2,0x20
 89a:	9301                	srli	a4,a4,0x20
 89c:	0712                	slli	a4,a4,0x4
 89e:	973e                	add	a4,a4,a5
 8a0:	fae689e3          	beq	a3,a4,852 <free+0x26>
  } else
    p->s.ptr = bp;
 8a4:	e394                	sd	a3,0(a5)
  freep = p;
 8a6:	00000717          	auipc	a4,0x0
 8aa:	20f73923          	sd	a5,530(a4) # ab8 <freep>
}
 8ae:	6422                	ld	s0,8(sp)
 8b0:	0141                	addi	sp,sp,16
 8b2:	8082                	ret

00000000000008b4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8b4:	7139                	addi	sp,sp,-64
 8b6:	fc06                	sd	ra,56(sp)
 8b8:	f822                	sd	s0,48(sp)
 8ba:	f426                	sd	s1,40(sp)
 8bc:	f04a                	sd	s2,32(sp)
 8be:	ec4e                	sd	s3,24(sp)
 8c0:	e852                	sd	s4,16(sp)
 8c2:	e456                	sd	s5,8(sp)
 8c4:	e05a                	sd	s6,0(sp)
 8c6:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8c8:	02051493          	slli	s1,a0,0x20
 8cc:	9081                	srli	s1,s1,0x20
 8ce:	04bd                	addi	s1,s1,15
 8d0:	8091                	srli	s1,s1,0x4
 8d2:	0014899b          	addiw	s3,s1,1
 8d6:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 8d8:	00000797          	auipc	a5,0x0
 8dc:	1e07b783          	ld	a5,480(a5) # ab8 <freep>
 8e0:	c795                	beqz	a5,90c <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8e2:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
 8e4:	4518                	lw	a4,8(a0)
 8e6:	02977f63          	bgeu	a4,s1,924 <malloc+0x70>
 8ea:	8a4e                	mv	s4,s3
 8ec:	0009879b          	sext.w	a5,s3
 8f0:	6705                	lui	a4,0x1
 8f2:	00e7f363          	bgeu	a5,a4,8f8 <malloc+0x44>
 8f6:	6a05                	lui	s4,0x1
 8f8:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8fc:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p);
    }
    if(p == freep)
 900:	00000917          	auipc	s2,0x0
 904:	1b890913          	addi	s2,s2,440 # ab8 <freep>
  if(p == (char*)-1)
 908:	5afd                	li	s5,-1
 90a:	a0bd                	j	978 <malloc+0xc4>
    base.s.ptr = freep = prevp = &base;
 90c:	00000517          	auipc	a0,0x0
 910:	1b450513          	addi	a0,a0,436 # ac0 <base>
 914:	00000797          	auipc	a5,0x0
 918:	1aa7b223          	sd	a0,420(a5) # ab8 <freep>
 91c:	e108                	sd	a0,0(a0)
    base.s.size = 0;
 91e:	00052423          	sw	zero,8(a0)
    if(p->s.size >= nunits){
 922:	b7e1                	j	8ea <malloc+0x36>
      if(p->s.size == nunits)
 924:	02e48963          	beq	s1,a4,956 <malloc+0xa2>
        p->s.size -= nunits;
 928:	4137073b          	subw	a4,a4,s3
 92c:	c518                	sw	a4,8(a0)
        p += p->s.size;
 92e:	1702                	slli	a4,a4,0x20
 930:	9301                	srli	a4,a4,0x20
 932:	0712                	slli	a4,a4,0x4
 934:	953a                	add	a0,a0,a4
        p->s.size = nunits;
 936:	01352423          	sw	s3,8(a0)
      freep = prevp;
 93a:	00000717          	auipc	a4,0x0
 93e:	16f73f23          	sd	a5,382(a4) # ab8 <freep>
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 942:	70e2                	ld	ra,56(sp)
 944:	7442                	ld	s0,48(sp)
 946:	74a2                	ld	s1,40(sp)
 948:	7902                	ld	s2,32(sp)
 94a:	69e2                	ld	s3,24(sp)
 94c:	6a42                	ld	s4,16(sp)
 94e:	6aa2                	ld	s5,8(sp)
 950:	6b02                	ld	s6,0(sp)
 952:	6121                	addi	sp,sp,64
 954:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 956:	6118                	ld	a4,0(a0)
 958:	e398                	sd	a4,0(a5)
 95a:	b7c5                	j	93a <malloc+0x86>
  hp->s.size = nu;
 95c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 960:	0541                	addi	a0,a0,16
 962:	00000097          	auipc	ra,0x0
 966:	eca080e7          	jalr	-310(ra) # 82c <free>
  return freep;
 96a:	00093783          	ld	a5,0(s2)
      if((p = morecore(nunits)) == 0)
 96e:	c39d                	beqz	a5,994 <malloc+0xe0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 970:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
 972:	4518                	lw	a4,8(a0)
 974:	fa9778e3          	bgeu	a4,s1,924 <malloc+0x70>
    if(p == freep)
 978:	00093703          	ld	a4,0(s2)
 97c:	87aa                	mv	a5,a0
 97e:	fea719e3          	bne	a4,a0,970 <malloc+0xbc>
  p = sbrk(nu * sizeof(Header));
 982:	8552                	mv	a0,s4
 984:	00000097          	auipc	ra,0x0
 988:	b56080e7          	jalr	-1194(ra) # 4da <sbrk>
  if(p == (char*)-1)
 98c:	fd5518e3          	bne	a0,s5,95c <malloc+0xa8>
        return 0;
 990:	4501                	li	a0,0
 992:	bf45                	j	942 <malloc+0x8e>
 994:	853e                	mv	a0,a5
 996:	b775                	j	942 <malloc+0x8e>
