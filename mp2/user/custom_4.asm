
user/_custom_4:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#define PG_SIZE 4096
#define NR_PG 16

/* fifo, pin, unpin, swap*/

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
  18:	53c080e7          	jalr	1340(ra) # 550 <vmprint>
	char *ptr = malloc(NR_PG * PG_SIZE);
  1c:	6541                	lui	a0,0x10
  1e:	00001097          	auipc	ra,0x1
  22:	8e4080e7          	jalr	-1820(ra) # 902 <malloc>
  26:	8b2a                	mv	s6,a0
	printf("After malloc\n");
  28:	00001517          	auipc	a0,0x1
  2c:	9c050513          	addi	a0,a0,-1600 # 9e8 <malloc+0xe6>
  30:	00001097          	auipc	ra,0x1
  34:	814080e7          	jalr	-2028(ra) # 844 <printf>
	vmprint();
  38:	00000097          	auipc	ra,0x0
  3c:	518080e7          	jalr	1304(ra) # 550 <vmprint>
	madvise((uint64) ptr + 3*PG_SIZE, PG_SIZE,  MADV_PIN); //pin 6
  40:	690d                	lui	s2,0x3
  42:	995a                	add	s2,s2,s6
  44:	460d                	li	a2,3
  46:	6585                	lui	a1,0x1
  48:	854a                	mv	a0,s2
  4a:	00000097          	auipc	ra,0x0
  4e:	50e080e7          	jalr	1294(ra) # 558 <madvise>
	printf("After madvise(MADV_PIN 6)\n");
  52:	00001517          	auipc	a0,0x1
  56:	9a650513          	addi	a0,a0,-1626 # 9f8 <malloc+0xf6>
  5a:	00000097          	auipc	ra,0x0
  5e:	7ea080e7          	jalr	2026(ra) # 844 <printf>
	pgprint();
  62:	00000097          	auipc	ra,0x0
  66:	500080e7          	jalr	1280(ra) # 562 <pgprint>

	madvise((uint64) ptr + 12*PG_SIZE, PG_SIZE,  MADV_PIN); //pin 15
  6a:	460d                	li	a2,3
  6c:	6585                	lui	a1,0x1
  6e:	6531                	lui	a0,0xc
  70:	955a                	add	a0,a0,s6
  72:	00000097          	auipc	ra,0x0
  76:	4e6080e7          	jalr	1254(ra) # 558 <madvise>
	printf("After madvise(MADV_PIN 15)\n");
  7a:	00001517          	auipc	a0,0x1
  7e:	99e50513          	addi	a0,a0,-1634 # a18 <malloc+0x116>
  82:	00000097          	auipc	ra,0x0
  86:	7c2080e7          	jalr	1986(ra) # 844 <printf>
	pgprint();
  8a:	00000097          	auipc	ra,0x0
  8e:	4d8080e7          	jalr	1240(ra) # 562 <pgprint>

	madvise((uint64) ptr + 10*PG_SIZE, PG_SIZE,  MADV_PIN); //pin 13
  92:	64a9                	lui	s1,0xa
  94:	94da                	add	s1,s1,s6
  96:	460d                	li	a2,3
  98:	6585                	lui	a1,0x1
  9a:	8526                	mv	a0,s1
  9c:	00000097          	auipc	ra,0x0
  a0:	4bc080e7          	jalr	1212(ra) # 558 <madvise>
	printf("After madvise(MADV_PIN 13)\n");
  a4:	00001517          	auipc	a0,0x1
  a8:	99450513          	addi	a0,a0,-1644 # a38 <malloc+0x136>
  ac:	00000097          	auipc	ra,0x0
  b0:	798080e7          	jalr	1944(ra) # 844 <printf>
	pgprint();
  b4:	00000097          	auipc	ra,0x0
  b8:	4ae080e7          	jalr	1198(ra) # 562 <pgprint>

	char *qtr = malloc(2*PG_SIZE);
  bc:	6509                	lui	a0,0x2
  be:	00001097          	auipc	ra,0x1
  c2:	844080e7          	jalr	-1980(ra) # 902 <malloc>
	printf("After malloc\n");
  c6:	00001517          	auipc	a0,0x1
  ca:	92250513          	addi	a0,a0,-1758 # 9e8 <malloc+0xe6>
  ce:	00000097          	auipc	ra,0x0
  d2:	776080e7          	jalr	1910(ra) # 844 <printf>
	vmprint();
  d6:	00000097          	auipc	ra,0x0
  da:	47a080e7          	jalr	1146(ra) # 550 <vmprint>
	pgprint();
  de:	00000097          	auipc	ra,0x0
  e2:	484080e7          	jalr	1156(ra) # 562 <pgprint>

	madvise((uint64) ptr + 10*PG_SIZE, PG_SIZE,  MADV_UNPIN); //unpin 13
  e6:	4611                	li	a2,4
  e8:	6585                	lui	a1,0x1
  ea:	8526                	mv	a0,s1
  ec:	00000097          	auipc	ra,0x0
  f0:	46c080e7          	jalr	1132(ra) # 558 <madvise>
	printf("After madvise(MADV_UNPIN 12)\n");
  f4:	00001517          	auipc	a0,0x1
  f8:	96450513          	addi	a0,a0,-1692 # a58 <malloc+0x156>
  fc:	00000097          	auipc	ra,0x0
 100:	748080e7          	jalr	1864(ra) # 844 <printf>
	pgprint();
 104:	00000097          	auipc	ra,0x0
 108:	45e080e7          	jalr	1118(ra) # 562 <pgprint>

	madvise((uint64) ptr + 10*PG_SIZE, PG_SIZE,  MADV_DONTNEED); //dontneed 13
 10c:	4609                	li	a2,2
 10e:	6585                	lui	a1,0x1
 110:	8526                	mv	a0,s1
 112:	00000097          	auipc	ra,0x0
 116:	446080e7          	jalr	1094(ra) # 558 <madvise>
	printf("After madvise(MADV_DONTNEED 13)\n");
 11a:	00001517          	auipc	a0,0x1
 11e:	95e50513          	addi	a0,a0,-1698 # a78 <malloc+0x176>
 122:	00000097          	auipc	ra,0x0
 126:	722080e7          	jalr	1826(ra) # 844 <printf>
	vmprint();
 12a:	00000097          	auipc	ra,0x0
 12e:	426080e7          	jalr	1062(ra) # 550 <vmprint>
	pgprint();
 132:	00000097          	auipc	ra,0x0
 136:	430080e7          	jalr	1072(ra) # 562 <pgprint>

	qtr = ptr + 10*PG_SIZE;
	*qtr = 'a'; //swap in 13
 13a:	06100793          	li	a5,97
 13e:	00f48023          	sb	a5,0(s1) # a000 <__global_pointer$+0x8ce7>
	printf("Page fault and swap in\n");
 142:	00001517          	auipc	a0,0x1
 146:	95e50513          	addi	a0,a0,-1698 # aa0 <malloc+0x19e>
 14a:	00000097          	auipc	ra,0x0
 14e:	6fa080e7          	jalr	1786(ra) # 844 <printf>
	vmprint();
 152:	00000097          	auipc	ra,0x0
 156:	3fe080e7          	jalr	1022(ra) # 550 <vmprint>
	pgprint();
 15a:	00000097          	auipc	ra,0x0
 15e:	408080e7          	jalr	1032(ra) # 562 <pgprint>

	madvise((uint64) ptr + 3*PG_SIZE, PG_SIZE,  MADV_UNPIN); //unpin 6
 162:	4611                	li	a2,4
 164:	6585                	lui	a1,0x1
 166:	854a                	mv	a0,s2
 168:	00000097          	auipc	ra,0x0
 16c:	3f0080e7          	jalr	1008(ra) # 558 <madvise>
	vmprint();
 170:	00000097          	auipc	ra,0x0
 174:	3e0080e7          	jalr	992(ra) # 550 <vmprint>
	madvise((uint64) ptr + 3*PG_SIZE, PG_SIZE,  MADV_DONTNEED); //dontneed 6
 178:	4609                	li	a2,2
 17a:	6585                	lui	a1,0x1
 17c:	854a                	mv	a0,s2
 17e:	00000097          	auipc	ra,0x0
 182:	3da080e7          	jalr	986(ra) # 558 <madvise>
	vmprint();
 186:	00000097          	auipc	ra,0x0
 18a:	3ca080e7          	jalr	970(ra) # 550 <vmprint>
	pgprint();
 18e:	00000097          	auipc	ra,0x0
 192:	3d4080e7          	jalr	980(ra) # 562 <pgprint>

	for (int i = 16;i >= 9;i--) {
 196:	6935                	lui	s2,0xd
 198:	995a                	add	s2,s2,s6
 19a:	44c1                	li	s1,16
		madvise((uint64) ptr + (i-3)*PG_SIZE, PG_SIZE,  MADV_PIN);
		printf("After madvise(MADV_PIN) %d\n", i);
 19c:	00001a97          	auipc	s5,0x1
 1a0:	91ca8a93          	addi	s5,s5,-1764 # ab8 <malloc+0x1b6>
 1a4:	7a7d                	lui	s4,0xfffff
	for (int i = 16;i >= 9;i--) {
 1a6:	49a1                	li	s3,8
		madvise((uint64) ptr + (i-3)*PG_SIZE, PG_SIZE,  MADV_PIN);
 1a8:	460d                	li	a2,3
 1aa:	6585                	lui	a1,0x1
 1ac:	854a                	mv	a0,s2
 1ae:	00000097          	auipc	ra,0x0
 1b2:	3aa080e7          	jalr	938(ra) # 558 <madvise>
		printf("After madvise(MADV_PIN) %d\n", i);
 1b6:	85a6                	mv	a1,s1
 1b8:	8556                	mv	a0,s5
 1ba:	00000097          	auipc	ra,0x0
 1be:	68a080e7          	jalr	1674(ra) # 844 <printf>
		vmprint();
 1c2:	00000097          	auipc	ra,0x0
 1c6:	38e080e7          	jalr	910(ra) # 550 <vmprint>
		pgprint();
 1ca:	00000097          	auipc	ra,0x0
 1ce:	398080e7          	jalr	920(ra) # 562 <pgprint>
	for (int i = 16;i >= 9;i--) {
 1d2:	34fd                	addiw	s1,s1,-1
 1d4:	9952                	add	s2,s2,s4
 1d6:	fd3499e3          	bne	s1,s3,1a8 <main+0x1a8>
	}

	madvise((uint64) ptr + 14*PG_SIZE, PG_SIZE,  MADV_WILLNEED); //willneed 17
 1da:	4605                	li	a2,1
 1dc:	6585                	lui	a1,0x1
 1de:	6539                	lui	a0,0xe
 1e0:	955a                	add	a0,a0,s6
 1e2:	00000097          	auipc	ra,0x0
 1e6:	376080e7          	jalr	886(ra) # 558 <madvise>
	printf("After madvise(MADV_WILLNEED) 17\n");
 1ea:	00001517          	auipc	a0,0x1
 1ee:	8ee50513          	addi	a0,a0,-1810 # ad8 <malloc+0x1d6>
 1f2:	00000097          	auipc	ra,0x0
 1f6:	652080e7          	jalr	1618(ra) # 844 <printf>
	vmprint();
 1fa:	00000097          	auipc	ra,0x0
 1fe:	356080e7          	jalr	854(ra) # 550 <vmprint>
	pgprint();
 202:	00000097          	auipc	ra,0x0
 206:	360080e7          	jalr	864(ra) # 562 <pgprint>

	exit(0);
 20a:	4501                	li	a0,0
 20c:	00000097          	auipc	ra,0x0
 210:	294080e7          	jalr	660(ra) # 4a0 <exit>

0000000000000214 <strcpy>:



char*
strcpy(char *s, const char *t)
{
 214:	1141                	addi	sp,sp,-16
 216:	e422                	sd	s0,8(sp)
 218:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 21a:	87aa                	mv	a5,a0
 21c:	0585                	addi	a1,a1,1
 21e:	0785                	addi	a5,a5,1
 220:	fff5c703          	lbu	a4,-1(a1) # fff <__BSS_END__+0x4c7>
 224:	fee78fa3          	sb	a4,-1(a5)
 228:	fb75                	bnez	a4,21c <strcpy+0x8>
    ;
  return os;
}
 22a:	6422                	ld	s0,8(sp)
 22c:	0141                	addi	sp,sp,16
 22e:	8082                	ret

0000000000000230 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 230:	1141                	addi	sp,sp,-16
 232:	e422                	sd	s0,8(sp)
 234:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 236:	00054783          	lbu	a5,0(a0)
 23a:	cb91                	beqz	a5,24e <strcmp+0x1e>
 23c:	0005c703          	lbu	a4,0(a1)
 240:	00f71763          	bne	a4,a5,24e <strcmp+0x1e>
    p++, q++;
 244:	0505                	addi	a0,a0,1
 246:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 248:	00054783          	lbu	a5,0(a0)
 24c:	fbe5                	bnez	a5,23c <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 24e:	0005c503          	lbu	a0,0(a1)
}
 252:	40a7853b          	subw	a0,a5,a0
 256:	6422                	ld	s0,8(sp)
 258:	0141                	addi	sp,sp,16
 25a:	8082                	ret

000000000000025c <strlen>:

uint
strlen(const char *s)
{
 25c:	1141                	addi	sp,sp,-16
 25e:	e422                	sd	s0,8(sp)
 260:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 262:	00054783          	lbu	a5,0(a0)
 266:	cf91                	beqz	a5,282 <strlen+0x26>
 268:	0505                	addi	a0,a0,1
 26a:	87aa                	mv	a5,a0
 26c:	4685                	li	a3,1
 26e:	9e89                	subw	a3,a3,a0
 270:	00f6853b          	addw	a0,a3,a5
 274:	0785                	addi	a5,a5,1
 276:	fff7c703          	lbu	a4,-1(a5)
 27a:	fb7d                	bnez	a4,270 <strlen+0x14>
    ;
  return n;
}
 27c:	6422                	ld	s0,8(sp)
 27e:	0141                	addi	sp,sp,16
 280:	8082                	ret
  for(n = 0; s[n]; n++)
 282:	4501                	li	a0,0
 284:	bfe5                	j	27c <strlen+0x20>

0000000000000286 <memset>:

void*
memset(void *dst, int c, uint n)
{
 286:	1141                	addi	sp,sp,-16
 288:	e422                	sd	s0,8(sp)
 28a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 28c:	ce09                	beqz	a2,2a6 <memset+0x20>
 28e:	87aa                	mv	a5,a0
 290:	fff6071b          	addiw	a4,a2,-1
 294:	1702                	slli	a4,a4,0x20
 296:	9301                	srli	a4,a4,0x20
 298:	0705                	addi	a4,a4,1
 29a:	972a                	add	a4,a4,a0
    cdst[i] = c;
 29c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2a0:	0785                	addi	a5,a5,1
 2a2:	fee79de3          	bne	a5,a4,29c <memset+0x16>
  }
  return dst;
}
 2a6:	6422                	ld	s0,8(sp)
 2a8:	0141                	addi	sp,sp,16
 2aa:	8082                	ret

00000000000002ac <strchr>:

char*
strchr(const char *s, char c)
{
 2ac:	1141                	addi	sp,sp,-16
 2ae:	e422                	sd	s0,8(sp)
 2b0:	0800                	addi	s0,sp,16
  for(; *s; s++)
 2b2:	00054783          	lbu	a5,0(a0)
 2b6:	cb99                	beqz	a5,2cc <strchr+0x20>
    if(*s == c)
 2b8:	00f58763          	beq	a1,a5,2c6 <strchr+0x1a>
  for(; *s; s++)
 2bc:	0505                	addi	a0,a0,1
 2be:	00054783          	lbu	a5,0(a0)
 2c2:	fbfd                	bnez	a5,2b8 <strchr+0xc>
      return (char*)s;
  return 0;
 2c4:	4501                	li	a0,0
}
 2c6:	6422                	ld	s0,8(sp)
 2c8:	0141                	addi	sp,sp,16
 2ca:	8082                	ret
  return 0;
 2cc:	4501                	li	a0,0
 2ce:	bfe5                	j	2c6 <strchr+0x1a>

00000000000002d0 <gets>:

char*
gets(char *buf, int max)
{
 2d0:	711d                	addi	sp,sp,-96
 2d2:	ec86                	sd	ra,88(sp)
 2d4:	e8a2                	sd	s0,80(sp)
 2d6:	e4a6                	sd	s1,72(sp)
 2d8:	e0ca                	sd	s2,64(sp)
 2da:	fc4e                	sd	s3,56(sp)
 2dc:	f852                	sd	s4,48(sp)
 2de:	f456                	sd	s5,40(sp)
 2e0:	f05a                	sd	s6,32(sp)
 2e2:	ec5e                	sd	s7,24(sp)
 2e4:	1080                	addi	s0,sp,96
 2e6:	8baa                	mv	s7,a0
 2e8:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2ea:	892a                	mv	s2,a0
 2ec:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2ee:	4aa9                	li	s5,10
 2f0:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 2f2:	89a6                	mv	s3,s1
 2f4:	2485                	addiw	s1,s1,1
 2f6:	0344d863          	bge	s1,s4,326 <gets+0x56>
    cc = read(0, &c, 1);
 2fa:	4605                	li	a2,1
 2fc:	faf40593          	addi	a1,s0,-81
 300:	4501                	li	a0,0
 302:	00000097          	auipc	ra,0x0
 306:	1b6080e7          	jalr	438(ra) # 4b8 <read>
    if(cc < 1)
 30a:	00a05e63          	blez	a0,326 <gets+0x56>
    buf[i++] = c;
 30e:	faf44783          	lbu	a5,-81(s0)
 312:	00f90023          	sb	a5,0(s2) # d000 <__global_pointer$+0xbce7>
    if(c == '\n' || c == '\r')
 316:	01578763          	beq	a5,s5,324 <gets+0x54>
 31a:	0905                	addi	s2,s2,1
 31c:	fd679be3          	bne	a5,s6,2f2 <gets+0x22>
  for(i=0; i+1 < max; ){
 320:	89a6                	mv	s3,s1
 322:	a011                	j	326 <gets+0x56>
 324:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 326:	99de                	add	s3,s3,s7
 328:	00098023          	sb	zero,0(s3)
  return buf;
}
 32c:	855e                	mv	a0,s7
 32e:	60e6                	ld	ra,88(sp)
 330:	6446                	ld	s0,80(sp)
 332:	64a6                	ld	s1,72(sp)
 334:	6906                	ld	s2,64(sp)
 336:	79e2                	ld	s3,56(sp)
 338:	7a42                	ld	s4,48(sp)
 33a:	7aa2                	ld	s5,40(sp)
 33c:	7b02                	ld	s6,32(sp)
 33e:	6be2                	ld	s7,24(sp)
 340:	6125                	addi	sp,sp,96
 342:	8082                	ret

0000000000000344 <stat>:

int
stat(const char *n, struct stat *st)
{
 344:	1101                	addi	sp,sp,-32
 346:	ec06                	sd	ra,24(sp)
 348:	e822                	sd	s0,16(sp)
 34a:	e426                	sd	s1,8(sp)
 34c:	e04a                	sd	s2,0(sp)
 34e:	1000                	addi	s0,sp,32
 350:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 352:	4581                	li	a1,0
 354:	00000097          	auipc	ra,0x0
 358:	18c080e7          	jalr	396(ra) # 4e0 <open>
  if(fd < 0)
 35c:	02054563          	bltz	a0,386 <stat+0x42>
 360:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 362:	85ca                	mv	a1,s2
 364:	00000097          	auipc	ra,0x0
 368:	194080e7          	jalr	404(ra) # 4f8 <fstat>
 36c:	892a                	mv	s2,a0
  close(fd);
 36e:	8526                	mv	a0,s1
 370:	00000097          	auipc	ra,0x0
 374:	158080e7          	jalr	344(ra) # 4c8 <close>
  return r;
}
 378:	854a                	mv	a0,s2
 37a:	60e2                	ld	ra,24(sp)
 37c:	6442                	ld	s0,16(sp)
 37e:	64a2                	ld	s1,8(sp)
 380:	6902                	ld	s2,0(sp)
 382:	6105                	addi	sp,sp,32
 384:	8082                	ret
    return -1;
 386:	597d                	li	s2,-1
 388:	bfc5                	j	378 <stat+0x34>

000000000000038a <atoi>:

int
atoi(const char *s)
{
 38a:	1141                	addi	sp,sp,-16
 38c:	e422                	sd	s0,8(sp)
 38e:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 390:	00054603          	lbu	a2,0(a0)
 394:	fd06079b          	addiw	a5,a2,-48
 398:	0ff7f793          	andi	a5,a5,255
 39c:	4725                	li	a4,9
 39e:	02f76963          	bltu	a4,a5,3d0 <atoi+0x46>
 3a2:	86aa                	mv	a3,a0
  n = 0;
 3a4:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 3a6:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 3a8:	0685                	addi	a3,a3,1
 3aa:	0025179b          	slliw	a5,a0,0x2
 3ae:	9fa9                	addw	a5,a5,a0
 3b0:	0017979b          	slliw	a5,a5,0x1
 3b4:	9fb1                	addw	a5,a5,a2
 3b6:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 3ba:	0006c603          	lbu	a2,0(a3)
 3be:	fd06071b          	addiw	a4,a2,-48
 3c2:	0ff77713          	andi	a4,a4,255
 3c6:	fee5f1e3          	bgeu	a1,a4,3a8 <atoi+0x1e>
  return n;
}
 3ca:	6422                	ld	s0,8(sp)
 3cc:	0141                	addi	sp,sp,16
 3ce:	8082                	ret
  n = 0;
 3d0:	4501                	li	a0,0
 3d2:	bfe5                	j	3ca <atoi+0x40>

00000000000003d4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3d4:	1141                	addi	sp,sp,-16
 3d6:	e422                	sd	s0,8(sp)
 3d8:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 3da:	02b57663          	bgeu	a0,a1,406 <memmove+0x32>
    while(n-- > 0)
 3de:	02c05163          	blez	a2,400 <memmove+0x2c>
 3e2:	fff6079b          	addiw	a5,a2,-1
 3e6:	1782                	slli	a5,a5,0x20
 3e8:	9381                	srli	a5,a5,0x20
 3ea:	0785                	addi	a5,a5,1
 3ec:	97aa                	add	a5,a5,a0
  dst = vdst;
 3ee:	872a                	mv	a4,a0
      *dst++ = *src++;
 3f0:	0585                	addi	a1,a1,1
 3f2:	0705                	addi	a4,a4,1
 3f4:	fff5c683          	lbu	a3,-1(a1)
 3f8:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 3fc:	fee79ae3          	bne	a5,a4,3f0 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 400:	6422                	ld	s0,8(sp)
 402:	0141                	addi	sp,sp,16
 404:	8082                	ret
    dst += n;
 406:	00c50733          	add	a4,a0,a2
    src += n;
 40a:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 40c:	fec05ae3          	blez	a2,400 <memmove+0x2c>
 410:	fff6079b          	addiw	a5,a2,-1
 414:	1782                	slli	a5,a5,0x20
 416:	9381                	srli	a5,a5,0x20
 418:	fff7c793          	not	a5,a5
 41c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 41e:	15fd                	addi	a1,a1,-1
 420:	177d                	addi	a4,a4,-1
 422:	0005c683          	lbu	a3,0(a1)
 426:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 42a:	fee79ae3          	bne	a5,a4,41e <memmove+0x4a>
 42e:	bfc9                	j	400 <memmove+0x2c>

0000000000000430 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 430:	1141                	addi	sp,sp,-16
 432:	e422                	sd	s0,8(sp)
 434:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 436:	ca05                	beqz	a2,466 <memcmp+0x36>
 438:	fff6069b          	addiw	a3,a2,-1
 43c:	1682                	slli	a3,a3,0x20
 43e:	9281                	srli	a3,a3,0x20
 440:	0685                	addi	a3,a3,1
 442:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 444:	00054783          	lbu	a5,0(a0)
 448:	0005c703          	lbu	a4,0(a1)
 44c:	00e79863          	bne	a5,a4,45c <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 450:	0505                	addi	a0,a0,1
    p2++;
 452:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 454:	fed518e3          	bne	a0,a3,444 <memcmp+0x14>
  }
  return 0;
 458:	4501                	li	a0,0
 45a:	a019                	j	460 <memcmp+0x30>
      return *p1 - *p2;
 45c:	40e7853b          	subw	a0,a5,a4
}
 460:	6422                	ld	s0,8(sp)
 462:	0141                	addi	sp,sp,16
 464:	8082                	ret
  return 0;
 466:	4501                	li	a0,0
 468:	bfe5                	j	460 <memcmp+0x30>

000000000000046a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 46a:	1141                	addi	sp,sp,-16
 46c:	e406                	sd	ra,8(sp)
 46e:	e022                	sd	s0,0(sp)
 470:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 472:	00000097          	auipc	ra,0x0
 476:	f62080e7          	jalr	-158(ra) # 3d4 <memmove>
}
 47a:	60a2                	ld	ra,8(sp)
 47c:	6402                	ld	s0,0(sp)
 47e:	0141                	addi	sp,sp,16
 480:	8082                	ret

0000000000000482 <ugetpid>:

#ifdef LAB_PGTBL
int
ugetpid(void)
{
 482:	1141                	addi	sp,sp,-16
 484:	e422                	sd	s0,8(sp)
 486:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 488:	040007b7          	lui	a5,0x4000
}
 48c:	17f5                	addi	a5,a5,-3
 48e:	07b2                	slli	a5,a5,0xc
 490:	4388                	lw	a0,0(a5)
 492:	6422                	ld	s0,8(sp)
 494:	0141                	addi	sp,sp,16
 496:	8082                	ret

0000000000000498 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 498:	4885                	li	a7,1
 ecall
 49a:	00000073          	ecall
 ret
 49e:	8082                	ret

00000000000004a0 <exit>:
.global exit
exit:
 li a7, SYS_exit
 4a0:	4889                	li	a7,2
 ecall
 4a2:	00000073          	ecall
 ret
 4a6:	8082                	ret

00000000000004a8 <wait>:
.global wait
wait:
 li a7, SYS_wait
 4a8:	488d                	li	a7,3
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4b0:	4891                	li	a7,4
 ecall
 4b2:	00000073          	ecall
 ret
 4b6:	8082                	ret

00000000000004b8 <read>:
.global read
read:
 li a7, SYS_read
 4b8:	4895                	li	a7,5
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <write>:
.global write
write:
 li a7, SYS_write
 4c0:	48c1                	li	a7,16
 ecall
 4c2:	00000073          	ecall
 ret
 4c6:	8082                	ret

00000000000004c8 <close>:
.global close
close:
 li a7, SYS_close
 4c8:	48d5                	li	a7,21
 ecall
 4ca:	00000073          	ecall
 ret
 4ce:	8082                	ret

00000000000004d0 <kill>:
.global kill
kill:
 li a7, SYS_kill
 4d0:	4899                	li	a7,6
 ecall
 4d2:	00000073          	ecall
 ret
 4d6:	8082                	ret

00000000000004d8 <exec>:
.global exec
exec:
 li a7, SYS_exec
 4d8:	489d                	li	a7,7
 ecall
 4da:	00000073          	ecall
 ret
 4de:	8082                	ret

00000000000004e0 <open>:
.global open
open:
 li a7, SYS_open
 4e0:	48bd                	li	a7,15
 ecall
 4e2:	00000073          	ecall
 ret
 4e6:	8082                	ret

00000000000004e8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 4e8:	48c5                	li	a7,17
 ecall
 4ea:	00000073          	ecall
 ret
 4ee:	8082                	ret

00000000000004f0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4f0:	48c9                	li	a7,18
 ecall
 4f2:	00000073          	ecall
 ret
 4f6:	8082                	ret

00000000000004f8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4f8:	48a1                	li	a7,8
 ecall
 4fa:	00000073          	ecall
 ret
 4fe:	8082                	ret

0000000000000500 <link>:
.global link
link:
 li a7, SYS_link
 500:	48cd                	li	a7,19
 ecall
 502:	00000073          	ecall
 ret
 506:	8082                	ret

0000000000000508 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 508:	48d1                	li	a7,20
 ecall
 50a:	00000073          	ecall
 ret
 50e:	8082                	ret

0000000000000510 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 510:	48a5                	li	a7,9
 ecall
 512:	00000073          	ecall
 ret
 516:	8082                	ret

0000000000000518 <dup>:
.global dup
dup:
 li a7, SYS_dup
 518:	48a9                	li	a7,10
 ecall
 51a:	00000073          	ecall
 ret
 51e:	8082                	ret

0000000000000520 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 520:	48ad                	li	a7,11
 ecall
 522:	00000073          	ecall
 ret
 526:	8082                	ret

0000000000000528 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 528:	48b1                	li	a7,12
 ecall
 52a:	00000073          	ecall
 ret
 52e:	8082                	ret

0000000000000530 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 530:	48b5                	li	a7,13
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 538:	48b9                	li	a7,14
 ecall
 53a:	00000073          	ecall
 ret
 53e:	8082                	ret

0000000000000540 <connect>:
.global connect
connect:
 li a7, SYS_connect
 540:	48f5                	li	a7,29
 ecall
 542:	00000073          	ecall
 ret
 546:	8082                	ret

0000000000000548 <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 548:	48f9                	li	a7,30
 ecall
 54a:	00000073          	ecall
 ret
 54e:	8082                	ret

0000000000000550 <vmprint>:
.global vmprint
vmprint:
 li a7, SYS_vmprint
 550:	48fd                	li	a7,31
 ecall
 552:	00000073          	ecall
 ret
 556:	8082                	ret

0000000000000558 <madvise>:
.global madvise
madvise:
 li a7, SYS_madvise
 558:	02000893          	li	a7,32
 ecall
 55c:	00000073          	ecall
 ret
 560:	8082                	ret

0000000000000562 <pgprint>:
.global pgprint
pgprint:
 li a7, SYS_pgprint
 562:	02100893          	li	a7,33
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 56c:	1101                	addi	sp,sp,-32
 56e:	ec06                	sd	ra,24(sp)
 570:	e822                	sd	s0,16(sp)
 572:	1000                	addi	s0,sp,32
 574:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 578:	4605                	li	a2,1
 57a:	fef40593          	addi	a1,s0,-17
 57e:	00000097          	auipc	ra,0x0
 582:	f42080e7          	jalr	-190(ra) # 4c0 <write>
}
 586:	60e2                	ld	ra,24(sp)
 588:	6442                	ld	s0,16(sp)
 58a:	6105                	addi	sp,sp,32
 58c:	8082                	ret

000000000000058e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 58e:	7139                	addi	sp,sp,-64
 590:	fc06                	sd	ra,56(sp)
 592:	f822                	sd	s0,48(sp)
 594:	f426                	sd	s1,40(sp)
 596:	f04a                	sd	s2,32(sp)
 598:	ec4e                	sd	s3,24(sp)
 59a:	0080                	addi	s0,sp,64
 59c:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 59e:	c299                	beqz	a3,5a4 <printint+0x16>
 5a0:	0805c863          	bltz	a1,630 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5a4:	2581                	sext.w	a1,a1
  neg = 0;
 5a6:	4881                	li	a7,0
 5a8:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 5ac:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 5ae:	2601                	sext.w	a2,a2
 5b0:	00000517          	auipc	a0,0x0
 5b4:	55850513          	addi	a0,a0,1368 # b08 <digits>
 5b8:	883a                	mv	a6,a4
 5ba:	2705                	addiw	a4,a4,1
 5bc:	02c5f7bb          	remuw	a5,a1,a2
 5c0:	1782                	slli	a5,a5,0x20
 5c2:	9381                	srli	a5,a5,0x20
 5c4:	97aa                	add	a5,a5,a0
 5c6:	0007c783          	lbu	a5,0(a5) # 4000000 <__global_pointer$+0x3ffece7>
 5ca:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 5ce:	0005879b          	sext.w	a5,a1
 5d2:	02c5d5bb          	divuw	a1,a1,a2
 5d6:	0685                	addi	a3,a3,1
 5d8:	fec7f0e3          	bgeu	a5,a2,5b8 <printint+0x2a>
  if(neg)
 5dc:	00088b63          	beqz	a7,5f2 <printint+0x64>
    buf[i++] = '-';
 5e0:	fd040793          	addi	a5,s0,-48
 5e4:	973e                	add	a4,a4,a5
 5e6:	02d00793          	li	a5,45
 5ea:	fef70823          	sb	a5,-16(a4)
 5ee:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 5f2:	02e05863          	blez	a4,622 <printint+0x94>
 5f6:	fc040793          	addi	a5,s0,-64
 5fa:	00e78933          	add	s2,a5,a4
 5fe:	fff78993          	addi	s3,a5,-1
 602:	99ba                	add	s3,s3,a4
 604:	377d                	addiw	a4,a4,-1
 606:	1702                	slli	a4,a4,0x20
 608:	9301                	srli	a4,a4,0x20
 60a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 60e:	fff94583          	lbu	a1,-1(s2)
 612:	8526                	mv	a0,s1
 614:	00000097          	auipc	ra,0x0
 618:	f58080e7          	jalr	-168(ra) # 56c <putc>
  while(--i >= 0)
 61c:	197d                	addi	s2,s2,-1
 61e:	ff3918e3          	bne	s2,s3,60e <printint+0x80>
}
 622:	70e2                	ld	ra,56(sp)
 624:	7442                	ld	s0,48(sp)
 626:	74a2                	ld	s1,40(sp)
 628:	7902                	ld	s2,32(sp)
 62a:	69e2                	ld	s3,24(sp)
 62c:	6121                	addi	sp,sp,64
 62e:	8082                	ret
    x = -xx;
 630:	40b005bb          	negw	a1,a1
    neg = 1;
 634:	4885                	li	a7,1
    x = -xx;
 636:	bf8d                	j	5a8 <printint+0x1a>

0000000000000638 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 638:	7119                	addi	sp,sp,-128
 63a:	fc86                	sd	ra,120(sp)
 63c:	f8a2                	sd	s0,112(sp)
 63e:	f4a6                	sd	s1,104(sp)
 640:	f0ca                	sd	s2,96(sp)
 642:	ecce                	sd	s3,88(sp)
 644:	e8d2                	sd	s4,80(sp)
 646:	e4d6                	sd	s5,72(sp)
 648:	e0da                	sd	s6,64(sp)
 64a:	fc5e                	sd	s7,56(sp)
 64c:	f862                	sd	s8,48(sp)
 64e:	f466                	sd	s9,40(sp)
 650:	f06a                	sd	s10,32(sp)
 652:	ec6e                	sd	s11,24(sp)
 654:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 656:	0005c903          	lbu	s2,0(a1)
 65a:	18090f63          	beqz	s2,7f8 <vprintf+0x1c0>
 65e:	8aaa                	mv	s5,a0
 660:	8b32                	mv	s6,a2
 662:	00158493          	addi	s1,a1,1
  state = 0;
 666:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 668:	02500a13          	li	s4,37
      if(c == 'd'){
 66c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 670:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 674:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 678:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 67c:	00000b97          	auipc	s7,0x0
 680:	48cb8b93          	addi	s7,s7,1164 # b08 <digits>
 684:	a839                	j	6a2 <vprintf+0x6a>
        putc(fd, c);
 686:	85ca                	mv	a1,s2
 688:	8556                	mv	a0,s5
 68a:	00000097          	auipc	ra,0x0
 68e:	ee2080e7          	jalr	-286(ra) # 56c <putc>
 692:	a019                	j	698 <vprintf+0x60>
    } else if(state == '%'){
 694:	01498f63          	beq	s3,s4,6b2 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 698:	0485                	addi	s1,s1,1
 69a:	fff4c903          	lbu	s2,-1(s1)
 69e:	14090d63          	beqz	s2,7f8 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 6a2:	0009079b          	sext.w	a5,s2
    if(state == 0){
 6a6:	fe0997e3          	bnez	s3,694 <vprintf+0x5c>
      if(c == '%'){
 6aa:	fd479ee3          	bne	a5,s4,686 <vprintf+0x4e>
        state = '%';
 6ae:	89be                	mv	s3,a5
 6b0:	b7e5                	j	698 <vprintf+0x60>
      if(c == 'd'){
 6b2:	05878063          	beq	a5,s8,6f2 <vprintf+0xba>
      } else if(c == 'l') {
 6b6:	05978c63          	beq	a5,s9,70e <vprintf+0xd6>
      } else if(c == 'x') {
 6ba:	07a78863          	beq	a5,s10,72a <vprintf+0xf2>
      } else if(c == 'p') {
 6be:	09b78463          	beq	a5,s11,746 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 6c2:	07300713          	li	a4,115
 6c6:	0ce78663          	beq	a5,a4,792 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6ca:	06300713          	li	a4,99
 6ce:	0ee78e63          	beq	a5,a4,7ca <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 6d2:	11478863          	beq	a5,s4,7e2 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6d6:	85d2                	mv	a1,s4
 6d8:	8556                	mv	a0,s5
 6da:	00000097          	auipc	ra,0x0
 6de:	e92080e7          	jalr	-366(ra) # 56c <putc>
        putc(fd, c);
 6e2:	85ca                	mv	a1,s2
 6e4:	8556                	mv	a0,s5
 6e6:	00000097          	auipc	ra,0x0
 6ea:	e86080e7          	jalr	-378(ra) # 56c <putc>
      }
      state = 0;
 6ee:	4981                	li	s3,0
 6f0:	b765                	j	698 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 6f2:	008b0913          	addi	s2,s6,8
 6f6:	4685                	li	a3,1
 6f8:	4629                	li	a2,10
 6fa:	000b2583          	lw	a1,0(s6)
 6fe:	8556                	mv	a0,s5
 700:	00000097          	auipc	ra,0x0
 704:	e8e080e7          	jalr	-370(ra) # 58e <printint>
 708:	8b4a                	mv	s6,s2
      state = 0;
 70a:	4981                	li	s3,0
 70c:	b771                	j	698 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 70e:	008b0913          	addi	s2,s6,8
 712:	4681                	li	a3,0
 714:	4629                	li	a2,10
 716:	000b2583          	lw	a1,0(s6)
 71a:	8556                	mv	a0,s5
 71c:	00000097          	auipc	ra,0x0
 720:	e72080e7          	jalr	-398(ra) # 58e <printint>
 724:	8b4a                	mv	s6,s2
      state = 0;
 726:	4981                	li	s3,0
 728:	bf85                	j	698 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 72a:	008b0913          	addi	s2,s6,8
 72e:	4681                	li	a3,0
 730:	4641                	li	a2,16
 732:	000b2583          	lw	a1,0(s6)
 736:	8556                	mv	a0,s5
 738:	00000097          	auipc	ra,0x0
 73c:	e56080e7          	jalr	-426(ra) # 58e <printint>
 740:	8b4a                	mv	s6,s2
      state = 0;
 742:	4981                	li	s3,0
 744:	bf91                	j	698 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 746:	008b0793          	addi	a5,s6,8
 74a:	f8f43423          	sd	a5,-120(s0)
 74e:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 752:	03000593          	li	a1,48
 756:	8556                	mv	a0,s5
 758:	00000097          	auipc	ra,0x0
 75c:	e14080e7          	jalr	-492(ra) # 56c <putc>
  putc(fd, 'x');
 760:	85ea                	mv	a1,s10
 762:	8556                	mv	a0,s5
 764:	00000097          	auipc	ra,0x0
 768:	e08080e7          	jalr	-504(ra) # 56c <putc>
 76c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 76e:	03c9d793          	srli	a5,s3,0x3c
 772:	97de                	add	a5,a5,s7
 774:	0007c583          	lbu	a1,0(a5)
 778:	8556                	mv	a0,s5
 77a:	00000097          	auipc	ra,0x0
 77e:	df2080e7          	jalr	-526(ra) # 56c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 782:	0992                	slli	s3,s3,0x4
 784:	397d                	addiw	s2,s2,-1
 786:	fe0914e3          	bnez	s2,76e <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 78a:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 78e:	4981                	li	s3,0
 790:	b721                	j	698 <vprintf+0x60>
        s = va_arg(ap, char*);
 792:	008b0993          	addi	s3,s6,8
 796:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 79a:	02090163          	beqz	s2,7bc <vprintf+0x184>
        while(*s != 0){
 79e:	00094583          	lbu	a1,0(s2)
 7a2:	c9a1                	beqz	a1,7f2 <vprintf+0x1ba>
          putc(fd, *s);
 7a4:	8556                	mv	a0,s5
 7a6:	00000097          	auipc	ra,0x0
 7aa:	dc6080e7          	jalr	-570(ra) # 56c <putc>
          s++;
 7ae:	0905                	addi	s2,s2,1
        while(*s != 0){
 7b0:	00094583          	lbu	a1,0(s2)
 7b4:	f9e5                	bnez	a1,7a4 <vprintf+0x16c>
        s = va_arg(ap, char*);
 7b6:	8b4e                	mv	s6,s3
      state = 0;
 7b8:	4981                	li	s3,0
 7ba:	bdf9                	j	698 <vprintf+0x60>
          s = "(null)";
 7bc:	00000917          	auipc	s2,0x0
 7c0:	34490913          	addi	s2,s2,836 # b00 <malloc+0x1fe>
        while(*s != 0){
 7c4:	02800593          	li	a1,40
 7c8:	bff1                	j	7a4 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 7ca:	008b0913          	addi	s2,s6,8
 7ce:	000b4583          	lbu	a1,0(s6)
 7d2:	8556                	mv	a0,s5
 7d4:	00000097          	auipc	ra,0x0
 7d8:	d98080e7          	jalr	-616(ra) # 56c <putc>
 7dc:	8b4a                	mv	s6,s2
      state = 0;
 7de:	4981                	li	s3,0
 7e0:	bd65                	j	698 <vprintf+0x60>
        putc(fd, c);
 7e2:	85d2                	mv	a1,s4
 7e4:	8556                	mv	a0,s5
 7e6:	00000097          	auipc	ra,0x0
 7ea:	d86080e7          	jalr	-634(ra) # 56c <putc>
      state = 0;
 7ee:	4981                	li	s3,0
 7f0:	b565                	j	698 <vprintf+0x60>
        s = va_arg(ap, char*);
 7f2:	8b4e                	mv	s6,s3
      state = 0;
 7f4:	4981                	li	s3,0
 7f6:	b54d                	j	698 <vprintf+0x60>
    }
  }
}
 7f8:	70e6                	ld	ra,120(sp)
 7fa:	7446                	ld	s0,112(sp)
 7fc:	74a6                	ld	s1,104(sp)
 7fe:	7906                	ld	s2,96(sp)
 800:	69e6                	ld	s3,88(sp)
 802:	6a46                	ld	s4,80(sp)
 804:	6aa6                	ld	s5,72(sp)
 806:	6b06                	ld	s6,64(sp)
 808:	7be2                	ld	s7,56(sp)
 80a:	7c42                	ld	s8,48(sp)
 80c:	7ca2                	ld	s9,40(sp)
 80e:	7d02                	ld	s10,32(sp)
 810:	6de2                	ld	s11,24(sp)
 812:	6109                	addi	sp,sp,128
 814:	8082                	ret

0000000000000816 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 816:	715d                	addi	sp,sp,-80
 818:	ec06                	sd	ra,24(sp)
 81a:	e822                	sd	s0,16(sp)
 81c:	1000                	addi	s0,sp,32
 81e:	e010                	sd	a2,0(s0)
 820:	e414                	sd	a3,8(s0)
 822:	e818                	sd	a4,16(s0)
 824:	ec1c                	sd	a5,24(s0)
 826:	03043023          	sd	a6,32(s0)
 82a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 82e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 832:	8622                	mv	a2,s0
 834:	00000097          	auipc	ra,0x0
 838:	e04080e7          	jalr	-508(ra) # 638 <vprintf>
}
 83c:	60e2                	ld	ra,24(sp)
 83e:	6442                	ld	s0,16(sp)
 840:	6161                	addi	sp,sp,80
 842:	8082                	ret

0000000000000844 <printf>:

void
printf(const char *fmt, ...)
{
 844:	711d                	addi	sp,sp,-96
 846:	ec06                	sd	ra,24(sp)
 848:	e822                	sd	s0,16(sp)
 84a:	1000                	addi	s0,sp,32
 84c:	e40c                	sd	a1,8(s0)
 84e:	e810                	sd	a2,16(s0)
 850:	ec14                	sd	a3,24(s0)
 852:	f018                	sd	a4,32(s0)
 854:	f41c                	sd	a5,40(s0)
 856:	03043823          	sd	a6,48(s0)
 85a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 85e:	00840613          	addi	a2,s0,8
 862:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 866:	85aa                	mv	a1,a0
 868:	4505                	li	a0,1
 86a:	00000097          	auipc	ra,0x0
 86e:	dce080e7          	jalr	-562(ra) # 638 <vprintf>
}
 872:	60e2                	ld	ra,24(sp)
 874:	6442                	ld	s0,16(sp)
 876:	6125                	addi	sp,sp,96
 878:	8082                	ret

000000000000087a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 87a:	1141                	addi	sp,sp,-16
 87c:	e422                	sd	s0,8(sp)
 87e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 880:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 884:	00000797          	auipc	a5,0x0
 888:	29c7b783          	ld	a5,668(a5) # b20 <freep>
 88c:	a805                	j	8bc <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 88e:	4618                	lw	a4,8(a2)
 890:	9db9                	addw	a1,a1,a4
 892:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 896:	6398                	ld	a4,0(a5)
 898:	6318                	ld	a4,0(a4)
 89a:	fee53823          	sd	a4,-16(a0)
 89e:	a091                	j	8e2 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8a0:	ff852703          	lw	a4,-8(a0)
 8a4:	9e39                	addw	a2,a2,a4
 8a6:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 8a8:	ff053703          	ld	a4,-16(a0)
 8ac:	e398                	sd	a4,0(a5)
 8ae:	a099                	j	8f4 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8b0:	6398                	ld	a4,0(a5)
 8b2:	00e7e463          	bltu	a5,a4,8ba <free+0x40>
 8b6:	00e6ea63          	bltu	a3,a4,8ca <free+0x50>
{
 8ba:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8bc:	fed7fae3          	bgeu	a5,a3,8b0 <free+0x36>
 8c0:	6398                	ld	a4,0(a5)
 8c2:	00e6e463          	bltu	a3,a4,8ca <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8c6:	fee7eae3          	bltu	a5,a4,8ba <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 8ca:	ff852583          	lw	a1,-8(a0)
 8ce:	6390                	ld	a2,0(a5)
 8d0:	02059713          	slli	a4,a1,0x20
 8d4:	9301                	srli	a4,a4,0x20
 8d6:	0712                	slli	a4,a4,0x4
 8d8:	9736                	add	a4,a4,a3
 8da:	fae60ae3          	beq	a2,a4,88e <free+0x14>
    bp->s.ptr = p->s.ptr;
 8de:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8e2:	4790                	lw	a2,8(a5)
 8e4:	02061713          	slli	a4,a2,0x20
 8e8:	9301                	srli	a4,a4,0x20
 8ea:	0712                	slli	a4,a4,0x4
 8ec:	973e                	add	a4,a4,a5
 8ee:	fae689e3          	beq	a3,a4,8a0 <free+0x26>
  } else
    p->s.ptr = bp;
 8f2:	e394                	sd	a3,0(a5)
  freep = p;
 8f4:	00000717          	auipc	a4,0x0
 8f8:	22f73623          	sd	a5,556(a4) # b20 <freep>
}
 8fc:	6422                	ld	s0,8(sp)
 8fe:	0141                	addi	sp,sp,16
 900:	8082                	ret

0000000000000902 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 902:	7139                	addi	sp,sp,-64
 904:	fc06                	sd	ra,56(sp)
 906:	f822                	sd	s0,48(sp)
 908:	f426                	sd	s1,40(sp)
 90a:	f04a                	sd	s2,32(sp)
 90c:	ec4e                	sd	s3,24(sp)
 90e:	e852                	sd	s4,16(sp)
 910:	e456                	sd	s5,8(sp)
 912:	e05a                	sd	s6,0(sp)
 914:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 916:	02051493          	slli	s1,a0,0x20
 91a:	9081                	srli	s1,s1,0x20
 91c:	04bd                	addi	s1,s1,15
 91e:	8091                	srli	s1,s1,0x4
 920:	0014899b          	addiw	s3,s1,1
 924:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 926:	00000797          	auipc	a5,0x0
 92a:	1fa7b783          	ld	a5,506(a5) # b20 <freep>
 92e:	c795                	beqz	a5,95a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 930:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
 932:	4518                	lw	a4,8(a0)
 934:	02977f63          	bgeu	a4,s1,972 <malloc+0x70>
 938:	8a4e                	mv	s4,s3
 93a:	0009879b          	sext.w	a5,s3
 93e:	6705                	lui	a4,0x1
 940:	00e7f363          	bgeu	a5,a4,946 <malloc+0x44>
 944:	6a05                	lui	s4,0x1
 946:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 94a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p);
    }
    if(p == freep)
 94e:	00000917          	auipc	s2,0x0
 952:	1d290913          	addi	s2,s2,466 # b20 <freep>
  if(p == (char*)-1)
 956:	5afd                	li	s5,-1
 958:	a0bd                	j	9c6 <malloc+0xc4>
    base.s.ptr = freep = prevp = &base;
 95a:	00000517          	auipc	a0,0x0
 95e:	1ce50513          	addi	a0,a0,462 # b28 <base>
 962:	00000797          	auipc	a5,0x0
 966:	1aa7bf23          	sd	a0,446(a5) # b20 <freep>
 96a:	e108                	sd	a0,0(a0)
    base.s.size = 0;
 96c:	00052423          	sw	zero,8(a0)
    if(p->s.size >= nunits){
 970:	b7e1                	j	938 <malloc+0x36>
      if(p->s.size == nunits)
 972:	02e48963          	beq	s1,a4,9a4 <malloc+0xa2>
        p->s.size -= nunits;
 976:	4137073b          	subw	a4,a4,s3
 97a:	c518                	sw	a4,8(a0)
        p += p->s.size;
 97c:	1702                	slli	a4,a4,0x20
 97e:	9301                	srli	a4,a4,0x20
 980:	0712                	slli	a4,a4,0x4
 982:	953a                	add	a0,a0,a4
        p->s.size = nunits;
 984:	01352423          	sw	s3,8(a0)
      freep = prevp;
 988:	00000717          	auipc	a4,0x0
 98c:	18f73c23          	sd	a5,408(a4) # b20 <freep>
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 990:	70e2                	ld	ra,56(sp)
 992:	7442                	ld	s0,48(sp)
 994:	74a2                	ld	s1,40(sp)
 996:	7902                	ld	s2,32(sp)
 998:	69e2                	ld	s3,24(sp)
 99a:	6a42                	ld	s4,16(sp)
 99c:	6aa2                	ld	s5,8(sp)
 99e:	6b02                	ld	s6,0(sp)
 9a0:	6121                	addi	sp,sp,64
 9a2:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 9a4:	6118                	ld	a4,0(a0)
 9a6:	e398                	sd	a4,0(a5)
 9a8:	b7c5                	j	988 <malloc+0x86>
  hp->s.size = nu;
 9aa:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9ae:	0541                	addi	a0,a0,16
 9b0:	00000097          	auipc	ra,0x0
 9b4:	eca080e7          	jalr	-310(ra) # 87a <free>
  return freep;
 9b8:	00093783          	ld	a5,0(s2)
      if((p = morecore(nunits)) == 0)
 9bc:	c39d                	beqz	a5,9e2 <malloc+0xe0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9be:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
 9c0:	4518                	lw	a4,8(a0)
 9c2:	fa9778e3          	bgeu	a4,s1,972 <malloc+0x70>
    if(p == freep)
 9c6:	00093703          	ld	a4,0(s2)
 9ca:	87aa                	mv	a5,a0
 9cc:	fea719e3          	bne	a4,a0,9be <malloc+0xbc>
  p = sbrk(nu * sizeof(Header));
 9d0:	8552                	mv	a0,s4
 9d2:	00000097          	auipc	ra,0x0
 9d6:	b56080e7          	jalr	-1194(ra) # 528 <sbrk>
  if(p == (char*)-1)
 9da:	fd5518e3          	bne	a0,s5,9aa <malloc+0xa8>
        return 0;
 9de:	4501                	li	a0,0
 9e0:	bf45                	j	990 <malloc+0x8e>
 9e2:	853e                	mv	a0,a5
 9e4:	b775                	j	990 <malloc+0x8e>
