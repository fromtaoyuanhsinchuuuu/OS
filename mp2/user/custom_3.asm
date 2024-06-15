
user/_custom_3:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#define PG_SIZE 4096
#define NR_PG 16

/* madvise: rules about pin and unpin*/

int main(int argc, char *argv[]) {
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
	vmprint();
   e:	00000097          	auipc	ra,0x0
  12:	51e080e7          	jalr	1310(ra) # 52c <vmprint>
	char *ptr = malloc(NR_PG * PG_SIZE);
  16:	6541                	lui	a0,0x10
  18:	00001097          	auipc	ra,0x1
  1c:	8c6080e7          	jalr	-1850(ra) # 8de <malloc>
  20:	892a                	mv	s2,a0
	printf("After malloc\n");
  22:	00001517          	auipc	a0,0x1
  26:	9a650513          	addi	a0,a0,-1626 # 9c8 <malloc+0xea>
  2a:	00000097          	auipc	ra,0x0
  2e:	7f6080e7          	jalr	2038(ra) # 820 <printf>
	vmprint();
  32:	00000097          	auipc	ra,0x0
  36:	4fa080e7          	jalr	1274(ra) # 52c <vmprint>

	madvise((uint64) ptr + 7*PG_SIZE, PG_SIZE,  MADV_PIN); //pin 10
  3a:	649d                	lui	s1,0x7
  3c:	94ca                	add	s1,s1,s2
  3e:	460d                	li	a2,3
  40:	6585                	lui	a1,0x1
  42:	8526                	mv	a0,s1
  44:	00000097          	auipc	ra,0x0
  48:	4f0080e7          	jalr	1264(ra) # 534 <madvise>
	printf("After madvise(MADV_PIN 10)\n");
  4c:	00001517          	auipc	a0,0x1
  50:	98c50513          	addi	a0,a0,-1652 # 9d8 <malloc+0xfa>
  54:	00000097          	auipc	ra,0x0
  58:	7cc080e7          	jalr	1996(ra) # 820 <printf>
	vmprint();
  5c:	00000097          	auipc	ra,0x0
  60:	4d0080e7          	jalr	1232(ra) # 52c <vmprint>

	madvise((uint64) ptr + 4*PG_SIZE, 3*PG_SIZE,  MADV_DONTNEED); //dontneed 7 8 9
  64:	4609                	li	a2,2
  66:	658d                	lui	a1,0x3
  68:	6511                	lui	a0,0x4
  6a:	954a                	add	a0,a0,s2
  6c:	00000097          	auipc	ra,0x0
  70:	4c8080e7          	jalr	1224(ra) # 534 <madvise>
	printf("After madvise(MADV_DONTNEED 7 8 9)\n");
  74:	00001517          	auipc	a0,0x1
  78:	98450513          	addi	a0,a0,-1660 # 9f8 <malloc+0x11a>
  7c:	00000097          	auipc	ra,0x0
  80:	7a4080e7          	jalr	1956(ra) # 820 <printf>
	vmprint();
  84:	00000097          	auipc	ra,0x0
  88:	4a8080e7          	jalr	1192(ra) # 52c <vmprint>

	madvise((uint64) ptr + 7*PG_SIZE, PG_SIZE,  MADV_UNPIN); //unpin 10
  8c:	4611                	li	a2,4
  8e:	6585                	lui	a1,0x1
  90:	8526                	mv	a0,s1
  92:	00000097          	auipc	ra,0x0
  96:	4a2080e7          	jalr	1186(ra) # 534 <madvise>
	printf("After madvise(MADV_UNPIN 10)\n");
  9a:	00001517          	auipc	a0,0x1
  9e:	98650513          	addi	a0,a0,-1658 # a20 <malloc+0x142>
  a2:	00000097          	auipc	ra,0x0
  a6:	77e080e7          	jalr	1918(ra) # 820 <printf>
	vmprint();
  aa:	00000097          	auipc	ra,0x0
  ae:	482080e7          	jalr	1154(ra) # 52c <vmprint>

	char *qtr = ptr + 5*PG_SIZE;
	*qtr = 'a'; //swap in 8
  b2:	6515                	lui	a0,0x5
  b4:	992a                	add	s2,s2,a0
  b6:	06100993          	li	s3,97
  ba:	01390023          	sb	s3,0(s2)
	printf("Page fault and swap in\n");
  be:	00001517          	auipc	a0,0x1
  c2:	98250513          	addi	a0,a0,-1662 # a40 <malloc+0x162>
  c6:	00000097          	auipc	ra,0x0
  ca:	75a080e7          	jalr	1882(ra) # 820 <printf>
	vmprint();
  ce:	00000097          	auipc	ra,0x0
  d2:	45e080e7          	jalr	1118(ra) # 52c <vmprint>

	madvise((uint64) ptr + 7*PG_SIZE, PG_SIZE,  MADV_DONTNEED); //dontneed 10
  d6:	4609                	li	a2,2
  d8:	6585                	lui	a1,0x1
  da:	8526                	mv	a0,s1
  dc:	00000097          	auipc	ra,0x0
  e0:	458080e7          	jalr	1112(ra) # 534 <madvise>
	printf("After madvise(MADV_DONTNEED 10)\n");
  e4:	00001517          	auipc	a0,0x1
  e8:	97450513          	addi	a0,a0,-1676 # a58 <malloc+0x17a>
  ec:	00000097          	auipc	ra,0x0
  f0:	734080e7          	jalr	1844(ra) # 820 <printf>
	vmprint();
  f4:	00000097          	auipc	ra,0x0
  f8:	438080e7          	jalr	1080(ra) # 52c <vmprint>

	qtr = ptr + 7*PG_SIZE;
	*qtr = 'a'; //swap in 10
  fc:	01348023          	sb	s3,0(s1) # 7000 <__global_pointer$+0x5d27>
	*(qtr+1) = 'b'; 
 100:	06200793          	li	a5,98
 104:	00f480a3          	sb	a5,1(s1)
	printf("Page fault and swap in\n");
 108:	00001517          	auipc	a0,0x1
 10c:	93850513          	addi	a0,a0,-1736 # a40 <malloc+0x162>
 110:	00000097          	auipc	ra,0x0
 114:	710080e7          	jalr	1808(ra) # 820 <printf>
	vmprint();
 118:	00000097          	auipc	ra,0x0
 11c:	414080e7          	jalr	1044(ra) # 52c <vmprint>
	
	//memory persistence
	madvise((uint64) ptr + 7*PG_SIZE, PG_SIZE,  MADV_DONTNEED); //dontneed 10
 120:	4609                	li	a2,2
 122:	6585                	lui	a1,0x1
 124:	8526                	mv	a0,s1
 126:	00000097          	auipc	ra,0x0
 12a:	40e080e7          	jalr	1038(ra) # 534 <madvise>
	printf("After madvise(MADV_DONTNEED 10)\n");
 12e:	00001517          	auipc	a0,0x1
 132:	92a50513          	addi	a0,a0,-1750 # a58 <malloc+0x17a>
 136:	00000097          	auipc	ra,0x0
 13a:	6ea080e7          	jalr	1770(ra) # 820 <printf>
	vmprint();
 13e:	00000097          	auipc	ra,0x0
 142:	3ee080e7          	jalr	1006(ra) # 52c <vmprint>
	*(qtr+2) = 'c';
 146:	06300793          	li	a5,99
 14a:	00f48123          	sb	a5,2(s1)
	*(qtr+3) = 0;
 14e:	000481a3          	sb	zero,3(s1)
	printf("Page fault and swap in\n");
 152:	00001517          	auipc	a0,0x1
 156:	8ee50513          	addi	a0,a0,-1810 # a40 <malloc+0x162>
 15a:	00000097          	auipc	ra,0x0
 15e:	6c6080e7          	jalr	1734(ra) # 820 <printf>
	vmprint();
 162:	00000097          	auipc	ra,0x0
 166:	3ca080e7          	jalr	970(ra) # 52c <vmprint>
	printf("Saved string: %s\n", qtr);
 16a:	85a6                	mv	a1,s1
 16c:	00001517          	auipc	a0,0x1
 170:	91450513          	addi	a0,a0,-1772 # a80 <malloc+0x1a2>
 174:	00000097          	auipc	ra,0x0
 178:	6ac080e7          	jalr	1708(ra) # 820 <printf>

	madvise((uint64) ptr + 7*PG_SIZE, PG_SIZE,  MADV_DONTNEED); //dontneed 10
 17c:	4609                	li	a2,2
 17e:	6585                	lui	a1,0x1
 180:	8526                	mv	a0,s1
 182:	00000097          	auipc	ra,0x0
 186:	3b2080e7          	jalr	946(ra) # 534 <madvise>
	printf("After madvise(MADV_DONTNEED 10)\n");
 18a:	00001517          	auipc	a0,0x1
 18e:	8ce50513          	addi	a0,a0,-1842 # a58 <malloc+0x17a>
 192:	00000097          	auipc	ra,0x0
 196:	68e080e7          	jalr	1678(ra) # 820 <printf>
	vmprint();
 19a:	00000097          	auipc	ra,0x0
 19e:	392080e7          	jalr	914(ra) # 52c <vmprint>
	madvise((uint64) ptr + 7*PG_SIZE, PG_SIZE,  MADV_WILLNEED); //dontneed 10
 1a2:	4605                	li	a2,1
 1a4:	6585                	lui	a1,0x1
 1a6:	8526                	mv	a0,s1
 1a8:	00000097          	auipc	ra,0x0
 1ac:	38c080e7          	jalr	908(ra) # 534 <madvise>
	printf("After madvise(MADV_WILLNEED 10)\n");
 1b0:	00001517          	auipc	a0,0x1
 1b4:	8e850513          	addi	a0,a0,-1816 # a98 <malloc+0x1ba>
 1b8:	00000097          	auipc	ra,0x0
 1bc:	668080e7          	jalr	1640(ra) # 820 <printf>
	vmprint();
 1c0:	00000097          	auipc	ra,0x0
 1c4:	36c080e7          	jalr	876(ra) # 52c <vmprint>

	*(qtr+3) = 'd';
 1c8:	06400793          	li	a5,100
 1cc:	00f481a3          	sb	a5,3(s1)
	*(qtr+4) = 0;
 1d0:	00048223          	sb	zero,4(s1)
	printf("Saved string: %s\n", qtr);
 1d4:	85a6                	mv	a1,s1
 1d6:	00001517          	auipc	a0,0x1
 1da:	8aa50513          	addi	a0,a0,-1878 # a80 <malloc+0x1a2>
 1de:	00000097          	auipc	ra,0x0
 1e2:	642080e7          	jalr	1602(ra) # 820 <printf>

	exit(0);
 1e6:	4501                	li	a0,0
 1e8:	00000097          	auipc	ra,0x0
 1ec:	294080e7          	jalr	660(ra) # 47c <exit>

00000000000001f0 <strcpy>:



char*
strcpy(char *s, const char *t)
{
 1f0:	1141                	addi	sp,sp,-16
 1f2:	e422                	sd	s0,8(sp)
 1f4:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1f6:	87aa                	mv	a5,a0
 1f8:	0585                	addi	a1,a1,1
 1fa:	0785                	addi	a5,a5,1
 1fc:	fff5c703          	lbu	a4,-1(a1) # fff <__BSS_END__+0x507>
 200:	fee78fa3          	sb	a4,-1(a5)
 204:	fb75                	bnez	a4,1f8 <strcpy+0x8>
    ;
  return os;
}
 206:	6422                	ld	s0,8(sp)
 208:	0141                	addi	sp,sp,16
 20a:	8082                	ret

000000000000020c <strcmp>:

int
strcmp(const char *p, const char *q)
{
 20c:	1141                	addi	sp,sp,-16
 20e:	e422                	sd	s0,8(sp)
 210:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 212:	00054783          	lbu	a5,0(a0)
 216:	cb91                	beqz	a5,22a <strcmp+0x1e>
 218:	0005c703          	lbu	a4,0(a1)
 21c:	00f71763          	bne	a4,a5,22a <strcmp+0x1e>
    p++, q++;
 220:	0505                	addi	a0,a0,1
 222:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 224:	00054783          	lbu	a5,0(a0)
 228:	fbe5                	bnez	a5,218 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 22a:	0005c503          	lbu	a0,0(a1)
}
 22e:	40a7853b          	subw	a0,a5,a0
 232:	6422                	ld	s0,8(sp)
 234:	0141                	addi	sp,sp,16
 236:	8082                	ret

0000000000000238 <strlen>:

uint
strlen(const char *s)
{
 238:	1141                	addi	sp,sp,-16
 23a:	e422                	sd	s0,8(sp)
 23c:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 23e:	00054783          	lbu	a5,0(a0)
 242:	cf91                	beqz	a5,25e <strlen+0x26>
 244:	0505                	addi	a0,a0,1
 246:	87aa                	mv	a5,a0
 248:	4685                	li	a3,1
 24a:	9e89                	subw	a3,a3,a0
 24c:	00f6853b          	addw	a0,a3,a5
 250:	0785                	addi	a5,a5,1
 252:	fff7c703          	lbu	a4,-1(a5)
 256:	fb7d                	bnez	a4,24c <strlen+0x14>
    ;
  return n;
}
 258:	6422                	ld	s0,8(sp)
 25a:	0141                	addi	sp,sp,16
 25c:	8082                	ret
  for(n = 0; s[n]; n++)
 25e:	4501                	li	a0,0
 260:	bfe5                	j	258 <strlen+0x20>

0000000000000262 <memset>:

void*
memset(void *dst, int c, uint n)
{
 262:	1141                	addi	sp,sp,-16
 264:	e422                	sd	s0,8(sp)
 266:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 268:	ce09                	beqz	a2,282 <memset+0x20>
 26a:	87aa                	mv	a5,a0
 26c:	fff6071b          	addiw	a4,a2,-1
 270:	1702                	slli	a4,a4,0x20
 272:	9301                	srli	a4,a4,0x20
 274:	0705                	addi	a4,a4,1
 276:	972a                	add	a4,a4,a0
    cdst[i] = c;
 278:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 27c:	0785                	addi	a5,a5,1
 27e:	fee79de3          	bne	a5,a4,278 <memset+0x16>
  }
  return dst;
}
 282:	6422                	ld	s0,8(sp)
 284:	0141                	addi	sp,sp,16
 286:	8082                	ret

0000000000000288 <strchr>:

char*
strchr(const char *s, char c)
{
 288:	1141                	addi	sp,sp,-16
 28a:	e422                	sd	s0,8(sp)
 28c:	0800                	addi	s0,sp,16
  for(; *s; s++)
 28e:	00054783          	lbu	a5,0(a0)
 292:	cb99                	beqz	a5,2a8 <strchr+0x20>
    if(*s == c)
 294:	00f58763          	beq	a1,a5,2a2 <strchr+0x1a>
  for(; *s; s++)
 298:	0505                	addi	a0,a0,1
 29a:	00054783          	lbu	a5,0(a0)
 29e:	fbfd                	bnez	a5,294 <strchr+0xc>
      return (char*)s;
  return 0;
 2a0:	4501                	li	a0,0
}
 2a2:	6422                	ld	s0,8(sp)
 2a4:	0141                	addi	sp,sp,16
 2a6:	8082                	ret
  return 0;
 2a8:	4501                	li	a0,0
 2aa:	bfe5                	j	2a2 <strchr+0x1a>

00000000000002ac <gets>:

char*
gets(char *buf, int max)
{
 2ac:	711d                	addi	sp,sp,-96
 2ae:	ec86                	sd	ra,88(sp)
 2b0:	e8a2                	sd	s0,80(sp)
 2b2:	e4a6                	sd	s1,72(sp)
 2b4:	e0ca                	sd	s2,64(sp)
 2b6:	fc4e                	sd	s3,56(sp)
 2b8:	f852                	sd	s4,48(sp)
 2ba:	f456                	sd	s5,40(sp)
 2bc:	f05a                	sd	s6,32(sp)
 2be:	ec5e                	sd	s7,24(sp)
 2c0:	1080                	addi	s0,sp,96
 2c2:	8baa                	mv	s7,a0
 2c4:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2c6:	892a                	mv	s2,a0
 2c8:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2ca:	4aa9                	li	s5,10
 2cc:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 2ce:	89a6                	mv	s3,s1
 2d0:	2485                	addiw	s1,s1,1
 2d2:	0344d863          	bge	s1,s4,302 <gets+0x56>
    cc = read(0, &c, 1);
 2d6:	4605                	li	a2,1
 2d8:	faf40593          	addi	a1,s0,-81
 2dc:	4501                	li	a0,0
 2de:	00000097          	auipc	ra,0x0
 2e2:	1b6080e7          	jalr	438(ra) # 494 <read>
    if(cc < 1)
 2e6:	00a05e63          	blez	a0,302 <gets+0x56>
    buf[i++] = c;
 2ea:	faf44783          	lbu	a5,-81(s0)
 2ee:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2f2:	01578763          	beq	a5,s5,300 <gets+0x54>
 2f6:	0905                	addi	s2,s2,1
 2f8:	fd679be3          	bne	a5,s6,2ce <gets+0x22>
  for(i=0; i+1 < max; ){
 2fc:	89a6                	mv	s3,s1
 2fe:	a011                	j	302 <gets+0x56>
 300:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 302:	99de                	add	s3,s3,s7
 304:	00098023          	sb	zero,0(s3)
  return buf;
}
 308:	855e                	mv	a0,s7
 30a:	60e6                	ld	ra,88(sp)
 30c:	6446                	ld	s0,80(sp)
 30e:	64a6                	ld	s1,72(sp)
 310:	6906                	ld	s2,64(sp)
 312:	79e2                	ld	s3,56(sp)
 314:	7a42                	ld	s4,48(sp)
 316:	7aa2                	ld	s5,40(sp)
 318:	7b02                	ld	s6,32(sp)
 31a:	6be2                	ld	s7,24(sp)
 31c:	6125                	addi	sp,sp,96
 31e:	8082                	ret

0000000000000320 <stat>:

int
stat(const char *n, struct stat *st)
{
 320:	1101                	addi	sp,sp,-32
 322:	ec06                	sd	ra,24(sp)
 324:	e822                	sd	s0,16(sp)
 326:	e426                	sd	s1,8(sp)
 328:	e04a                	sd	s2,0(sp)
 32a:	1000                	addi	s0,sp,32
 32c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 32e:	4581                	li	a1,0
 330:	00000097          	auipc	ra,0x0
 334:	18c080e7          	jalr	396(ra) # 4bc <open>
  if(fd < 0)
 338:	02054563          	bltz	a0,362 <stat+0x42>
 33c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 33e:	85ca                	mv	a1,s2
 340:	00000097          	auipc	ra,0x0
 344:	194080e7          	jalr	404(ra) # 4d4 <fstat>
 348:	892a                	mv	s2,a0
  close(fd);
 34a:	8526                	mv	a0,s1
 34c:	00000097          	auipc	ra,0x0
 350:	158080e7          	jalr	344(ra) # 4a4 <close>
  return r;
}
 354:	854a                	mv	a0,s2
 356:	60e2                	ld	ra,24(sp)
 358:	6442                	ld	s0,16(sp)
 35a:	64a2                	ld	s1,8(sp)
 35c:	6902                	ld	s2,0(sp)
 35e:	6105                	addi	sp,sp,32
 360:	8082                	ret
    return -1;
 362:	597d                	li	s2,-1
 364:	bfc5                	j	354 <stat+0x34>

0000000000000366 <atoi>:

int
atoi(const char *s)
{
 366:	1141                	addi	sp,sp,-16
 368:	e422                	sd	s0,8(sp)
 36a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 36c:	00054603          	lbu	a2,0(a0)
 370:	fd06079b          	addiw	a5,a2,-48
 374:	0ff7f793          	andi	a5,a5,255
 378:	4725                	li	a4,9
 37a:	02f76963          	bltu	a4,a5,3ac <atoi+0x46>
 37e:	86aa                	mv	a3,a0
  n = 0;
 380:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 382:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 384:	0685                	addi	a3,a3,1
 386:	0025179b          	slliw	a5,a0,0x2
 38a:	9fa9                	addw	a5,a5,a0
 38c:	0017979b          	slliw	a5,a5,0x1
 390:	9fb1                	addw	a5,a5,a2
 392:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 396:	0006c603          	lbu	a2,0(a3)
 39a:	fd06071b          	addiw	a4,a2,-48
 39e:	0ff77713          	andi	a4,a4,255
 3a2:	fee5f1e3          	bgeu	a1,a4,384 <atoi+0x1e>
  return n;
}
 3a6:	6422                	ld	s0,8(sp)
 3a8:	0141                	addi	sp,sp,16
 3aa:	8082                	ret
  n = 0;
 3ac:	4501                	li	a0,0
 3ae:	bfe5                	j	3a6 <atoi+0x40>

00000000000003b0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3b0:	1141                	addi	sp,sp,-16
 3b2:	e422                	sd	s0,8(sp)
 3b4:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 3b6:	02b57663          	bgeu	a0,a1,3e2 <memmove+0x32>
    while(n-- > 0)
 3ba:	02c05163          	blez	a2,3dc <memmove+0x2c>
 3be:	fff6079b          	addiw	a5,a2,-1
 3c2:	1782                	slli	a5,a5,0x20
 3c4:	9381                	srli	a5,a5,0x20
 3c6:	0785                	addi	a5,a5,1
 3c8:	97aa                	add	a5,a5,a0
  dst = vdst;
 3ca:	872a                	mv	a4,a0
      *dst++ = *src++;
 3cc:	0585                	addi	a1,a1,1
 3ce:	0705                	addi	a4,a4,1
 3d0:	fff5c683          	lbu	a3,-1(a1)
 3d4:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 3d8:	fee79ae3          	bne	a5,a4,3cc <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3dc:	6422                	ld	s0,8(sp)
 3de:	0141                	addi	sp,sp,16
 3e0:	8082                	ret
    dst += n;
 3e2:	00c50733          	add	a4,a0,a2
    src += n;
 3e6:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3e8:	fec05ae3          	blez	a2,3dc <memmove+0x2c>
 3ec:	fff6079b          	addiw	a5,a2,-1
 3f0:	1782                	slli	a5,a5,0x20
 3f2:	9381                	srli	a5,a5,0x20
 3f4:	fff7c793          	not	a5,a5
 3f8:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3fa:	15fd                	addi	a1,a1,-1
 3fc:	177d                	addi	a4,a4,-1
 3fe:	0005c683          	lbu	a3,0(a1)
 402:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 406:	fee79ae3          	bne	a5,a4,3fa <memmove+0x4a>
 40a:	bfc9                	j	3dc <memmove+0x2c>

000000000000040c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 40c:	1141                	addi	sp,sp,-16
 40e:	e422                	sd	s0,8(sp)
 410:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 412:	ca05                	beqz	a2,442 <memcmp+0x36>
 414:	fff6069b          	addiw	a3,a2,-1
 418:	1682                	slli	a3,a3,0x20
 41a:	9281                	srli	a3,a3,0x20
 41c:	0685                	addi	a3,a3,1
 41e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 420:	00054783          	lbu	a5,0(a0)
 424:	0005c703          	lbu	a4,0(a1)
 428:	00e79863          	bne	a5,a4,438 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 42c:	0505                	addi	a0,a0,1
    p2++;
 42e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 430:	fed518e3          	bne	a0,a3,420 <memcmp+0x14>
  }
  return 0;
 434:	4501                	li	a0,0
 436:	a019                	j	43c <memcmp+0x30>
      return *p1 - *p2;
 438:	40e7853b          	subw	a0,a5,a4
}
 43c:	6422                	ld	s0,8(sp)
 43e:	0141                	addi	sp,sp,16
 440:	8082                	ret
  return 0;
 442:	4501                	li	a0,0
 444:	bfe5                	j	43c <memcmp+0x30>

0000000000000446 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 446:	1141                	addi	sp,sp,-16
 448:	e406                	sd	ra,8(sp)
 44a:	e022                	sd	s0,0(sp)
 44c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 44e:	00000097          	auipc	ra,0x0
 452:	f62080e7          	jalr	-158(ra) # 3b0 <memmove>
}
 456:	60a2                	ld	ra,8(sp)
 458:	6402                	ld	s0,0(sp)
 45a:	0141                	addi	sp,sp,16
 45c:	8082                	ret

000000000000045e <ugetpid>:

#ifdef LAB_PGTBL
int
ugetpid(void)
{
 45e:	1141                	addi	sp,sp,-16
 460:	e422                	sd	s0,8(sp)
 462:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 464:	040007b7          	lui	a5,0x4000
}
 468:	17f5                	addi	a5,a5,-3
 46a:	07b2                	slli	a5,a5,0xc
 46c:	4388                	lw	a0,0(a5)
 46e:	6422                	ld	s0,8(sp)
 470:	0141                	addi	sp,sp,16
 472:	8082                	ret

0000000000000474 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 474:	4885                	li	a7,1
 ecall
 476:	00000073          	ecall
 ret
 47a:	8082                	ret

000000000000047c <exit>:
.global exit
exit:
 li a7, SYS_exit
 47c:	4889                	li	a7,2
 ecall
 47e:	00000073          	ecall
 ret
 482:	8082                	ret

0000000000000484 <wait>:
.global wait
wait:
 li a7, SYS_wait
 484:	488d                	li	a7,3
 ecall
 486:	00000073          	ecall
 ret
 48a:	8082                	ret

000000000000048c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 48c:	4891                	li	a7,4
 ecall
 48e:	00000073          	ecall
 ret
 492:	8082                	ret

0000000000000494 <read>:
.global read
read:
 li a7, SYS_read
 494:	4895                	li	a7,5
 ecall
 496:	00000073          	ecall
 ret
 49a:	8082                	ret

000000000000049c <write>:
.global write
write:
 li a7, SYS_write
 49c:	48c1                	li	a7,16
 ecall
 49e:	00000073          	ecall
 ret
 4a2:	8082                	ret

00000000000004a4 <close>:
.global close
close:
 li a7, SYS_close
 4a4:	48d5                	li	a7,21
 ecall
 4a6:	00000073          	ecall
 ret
 4aa:	8082                	ret

00000000000004ac <kill>:
.global kill
kill:
 li a7, SYS_kill
 4ac:	4899                	li	a7,6
 ecall
 4ae:	00000073          	ecall
 ret
 4b2:	8082                	ret

00000000000004b4 <exec>:
.global exec
exec:
 li a7, SYS_exec
 4b4:	489d                	li	a7,7
 ecall
 4b6:	00000073          	ecall
 ret
 4ba:	8082                	ret

00000000000004bc <open>:
.global open
open:
 li a7, SYS_open
 4bc:	48bd                	li	a7,15
 ecall
 4be:	00000073          	ecall
 ret
 4c2:	8082                	ret

00000000000004c4 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 4c4:	48c5                	li	a7,17
 ecall
 4c6:	00000073          	ecall
 ret
 4ca:	8082                	ret

00000000000004cc <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4cc:	48c9                	li	a7,18
 ecall
 4ce:	00000073          	ecall
 ret
 4d2:	8082                	ret

00000000000004d4 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4d4:	48a1                	li	a7,8
 ecall
 4d6:	00000073          	ecall
 ret
 4da:	8082                	ret

00000000000004dc <link>:
.global link
link:
 li a7, SYS_link
 4dc:	48cd                	li	a7,19
 ecall
 4de:	00000073          	ecall
 ret
 4e2:	8082                	ret

00000000000004e4 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4e4:	48d1                	li	a7,20
 ecall
 4e6:	00000073          	ecall
 ret
 4ea:	8082                	ret

00000000000004ec <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4ec:	48a5                	li	a7,9
 ecall
 4ee:	00000073          	ecall
 ret
 4f2:	8082                	ret

00000000000004f4 <dup>:
.global dup
dup:
 li a7, SYS_dup
 4f4:	48a9                	li	a7,10
 ecall
 4f6:	00000073          	ecall
 ret
 4fa:	8082                	ret

00000000000004fc <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4fc:	48ad                	li	a7,11
 ecall
 4fe:	00000073          	ecall
 ret
 502:	8082                	ret

0000000000000504 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 504:	48b1                	li	a7,12
 ecall
 506:	00000073          	ecall
 ret
 50a:	8082                	ret

000000000000050c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 50c:	48b5                	li	a7,13
 ecall
 50e:	00000073          	ecall
 ret
 512:	8082                	ret

0000000000000514 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 514:	48b9                	li	a7,14
 ecall
 516:	00000073          	ecall
 ret
 51a:	8082                	ret

000000000000051c <connect>:
.global connect
connect:
 li a7, SYS_connect
 51c:	48f5                	li	a7,29
 ecall
 51e:	00000073          	ecall
 ret
 522:	8082                	ret

0000000000000524 <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 524:	48f9                	li	a7,30
 ecall
 526:	00000073          	ecall
 ret
 52a:	8082                	ret

000000000000052c <vmprint>:
.global vmprint
vmprint:
 li a7, SYS_vmprint
 52c:	48fd                	li	a7,31
 ecall
 52e:	00000073          	ecall
 ret
 532:	8082                	ret

0000000000000534 <madvise>:
.global madvise
madvise:
 li a7, SYS_madvise
 534:	02000893          	li	a7,32
 ecall
 538:	00000073          	ecall
 ret
 53c:	8082                	ret

000000000000053e <pgprint>:
.global pgprint
pgprint:
 li a7, SYS_pgprint
 53e:	02100893          	li	a7,33
 ecall
 542:	00000073          	ecall
 ret
 546:	8082                	ret

0000000000000548 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 548:	1101                	addi	sp,sp,-32
 54a:	ec06                	sd	ra,24(sp)
 54c:	e822                	sd	s0,16(sp)
 54e:	1000                	addi	s0,sp,32
 550:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 554:	4605                	li	a2,1
 556:	fef40593          	addi	a1,s0,-17
 55a:	00000097          	auipc	ra,0x0
 55e:	f42080e7          	jalr	-190(ra) # 49c <write>
}
 562:	60e2                	ld	ra,24(sp)
 564:	6442                	ld	s0,16(sp)
 566:	6105                	addi	sp,sp,32
 568:	8082                	ret

000000000000056a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 56a:	7139                	addi	sp,sp,-64
 56c:	fc06                	sd	ra,56(sp)
 56e:	f822                	sd	s0,48(sp)
 570:	f426                	sd	s1,40(sp)
 572:	f04a                	sd	s2,32(sp)
 574:	ec4e                	sd	s3,24(sp)
 576:	0080                	addi	s0,sp,64
 578:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 57a:	c299                	beqz	a3,580 <printint+0x16>
 57c:	0805c863          	bltz	a1,60c <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 580:	2581                	sext.w	a1,a1
  neg = 0;
 582:	4881                	li	a7,0
 584:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 588:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 58a:	2601                	sext.w	a2,a2
 58c:	00000517          	auipc	a0,0x0
 590:	53c50513          	addi	a0,a0,1340 # ac8 <digits>
 594:	883a                	mv	a6,a4
 596:	2705                	addiw	a4,a4,1
 598:	02c5f7bb          	remuw	a5,a1,a2
 59c:	1782                	slli	a5,a5,0x20
 59e:	9381                	srli	a5,a5,0x20
 5a0:	97aa                	add	a5,a5,a0
 5a2:	0007c783          	lbu	a5,0(a5) # 4000000 <__global_pointer$+0x3ffed27>
 5a6:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 5aa:	0005879b          	sext.w	a5,a1
 5ae:	02c5d5bb          	divuw	a1,a1,a2
 5b2:	0685                	addi	a3,a3,1
 5b4:	fec7f0e3          	bgeu	a5,a2,594 <printint+0x2a>
  if(neg)
 5b8:	00088b63          	beqz	a7,5ce <printint+0x64>
    buf[i++] = '-';
 5bc:	fd040793          	addi	a5,s0,-48
 5c0:	973e                	add	a4,a4,a5
 5c2:	02d00793          	li	a5,45
 5c6:	fef70823          	sb	a5,-16(a4)
 5ca:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 5ce:	02e05863          	blez	a4,5fe <printint+0x94>
 5d2:	fc040793          	addi	a5,s0,-64
 5d6:	00e78933          	add	s2,a5,a4
 5da:	fff78993          	addi	s3,a5,-1
 5de:	99ba                	add	s3,s3,a4
 5e0:	377d                	addiw	a4,a4,-1
 5e2:	1702                	slli	a4,a4,0x20
 5e4:	9301                	srli	a4,a4,0x20
 5e6:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 5ea:	fff94583          	lbu	a1,-1(s2)
 5ee:	8526                	mv	a0,s1
 5f0:	00000097          	auipc	ra,0x0
 5f4:	f58080e7          	jalr	-168(ra) # 548 <putc>
  while(--i >= 0)
 5f8:	197d                	addi	s2,s2,-1
 5fa:	ff3918e3          	bne	s2,s3,5ea <printint+0x80>
}
 5fe:	70e2                	ld	ra,56(sp)
 600:	7442                	ld	s0,48(sp)
 602:	74a2                	ld	s1,40(sp)
 604:	7902                	ld	s2,32(sp)
 606:	69e2                	ld	s3,24(sp)
 608:	6121                	addi	sp,sp,64
 60a:	8082                	ret
    x = -xx;
 60c:	40b005bb          	negw	a1,a1
    neg = 1;
 610:	4885                	li	a7,1
    x = -xx;
 612:	bf8d                	j	584 <printint+0x1a>

0000000000000614 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 614:	7119                	addi	sp,sp,-128
 616:	fc86                	sd	ra,120(sp)
 618:	f8a2                	sd	s0,112(sp)
 61a:	f4a6                	sd	s1,104(sp)
 61c:	f0ca                	sd	s2,96(sp)
 61e:	ecce                	sd	s3,88(sp)
 620:	e8d2                	sd	s4,80(sp)
 622:	e4d6                	sd	s5,72(sp)
 624:	e0da                	sd	s6,64(sp)
 626:	fc5e                	sd	s7,56(sp)
 628:	f862                	sd	s8,48(sp)
 62a:	f466                	sd	s9,40(sp)
 62c:	f06a                	sd	s10,32(sp)
 62e:	ec6e                	sd	s11,24(sp)
 630:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 632:	0005c903          	lbu	s2,0(a1)
 636:	18090f63          	beqz	s2,7d4 <vprintf+0x1c0>
 63a:	8aaa                	mv	s5,a0
 63c:	8b32                	mv	s6,a2
 63e:	00158493          	addi	s1,a1,1
  state = 0;
 642:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 644:	02500a13          	li	s4,37
      if(c == 'd'){
 648:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 64c:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 650:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 654:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 658:	00000b97          	auipc	s7,0x0
 65c:	470b8b93          	addi	s7,s7,1136 # ac8 <digits>
 660:	a839                	j	67e <vprintf+0x6a>
        putc(fd, c);
 662:	85ca                	mv	a1,s2
 664:	8556                	mv	a0,s5
 666:	00000097          	auipc	ra,0x0
 66a:	ee2080e7          	jalr	-286(ra) # 548 <putc>
 66e:	a019                	j	674 <vprintf+0x60>
    } else if(state == '%'){
 670:	01498f63          	beq	s3,s4,68e <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 674:	0485                	addi	s1,s1,1
 676:	fff4c903          	lbu	s2,-1(s1)
 67a:	14090d63          	beqz	s2,7d4 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 67e:	0009079b          	sext.w	a5,s2
    if(state == 0){
 682:	fe0997e3          	bnez	s3,670 <vprintf+0x5c>
      if(c == '%'){
 686:	fd479ee3          	bne	a5,s4,662 <vprintf+0x4e>
        state = '%';
 68a:	89be                	mv	s3,a5
 68c:	b7e5                	j	674 <vprintf+0x60>
      if(c == 'd'){
 68e:	05878063          	beq	a5,s8,6ce <vprintf+0xba>
      } else if(c == 'l') {
 692:	05978c63          	beq	a5,s9,6ea <vprintf+0xd6>
      } else if(c == 'x') {
 696:	07a78863          	beq	a5,s10,706 <vprintf+0xf2>
      } else if(c == 'p') {
 69a:	09b78463          	beq	a5,s11,722 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 69e:	07300713          	li	a4,115
 6a2:	0ce78663          	beq	a5,a4,76e <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6a6:	06300713          	li	a4,99
 6aa:	0ee78e63          	beq	a5,a4,7a6 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 6ae:	11478863          	beq	a5,s4,7be <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6b2:	85d2                	mv	a1,s4
 6b4:	8556                	mv	a0,s5
 6b6:	00000097          	auipc	ra,0x0
 6ba:	e92080e7          	jalr	-366(ra) # 548 <putc>
        putc(fd, c);
 6be:	85ca                	mv	a1,s2
 6c0:	8556                	mv	a0,s5
 6c2:	00000097          	auipc	ra,0x0
 6c6:	e86080e7          	jalr	-378(ra) # 548 <putc>
      }
      state = 0;
 6ca:	4981                	li	s3,0
 6cc:	b765                	j	674 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 6ce:	008b0913          	addi	s2,s6,8
 6d2:	4685                	li	a3,1
 6d4:	4629                	li	a2,10
 6d6:	000b2583          	lw	a1,0(s6)
 6da:	8556                	mv	a0,s5
 6dc:	00000097          	auipc	ra,0x0
 6e0:	e8e080e7          	jalr	-370(ra) # 56a <printint>
 6e4:	8b4a                	mv	s6,s2
      state = 0;
 6e6:	4981                	li	s3,0
 6e8:	b771                	j	674 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6ea:	008b0913          	addi	s2,s6,8
 6ee:	4681                	li	a3,0
 6f0:	4629                	li	a2,10
 6f2:	000b2583          	lw	a1,0(s6)
 6f6:	8556                	mv	a0,s5
 6f8:	00000097          	auipc	ra,0x0
 6fc:	e72080e7          	jalr	-398(ra) # 56a <printint>
 700:	8b4a                	mv	s6,s2
      state = 0;
 702:	4981                	li	s3,0
 704:	bf85                	j	674 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 706:	008b0913          	addi	s2,s6,8
 70a:	4681                	li	a3,0
 70c:	4641                	li	a2,16
 70e:	000b2583          	lw	a1,0(s6)
 712:	8556                	mv	a0,s5
 714:	00000097          	auipc	ra,0x0
 718:	e56080e7          	jalr	-426(ra) # 56a <printint>
 71c:	8b4a                	mv	s6,s2
      state = 0;
 71e:	4981                	li	s3,0
 720:	bf91                	j	674 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 722:	008b0793          	addi	a5,s6,8
 726:	f8f43423          	sd	a5,-120(s0)
 72a:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 72e:	03000593          	li	a1,48
 732:	8556                	mv	a0,s5
 734:	00000097          	auipc	ra,0x0
 738:	e14080e7          	jalr	-492(ra) # 548 <putc>
  putc(fd, 'x');
 73c:	85ea                	mv	a1,s10
 73e:	8556                	mv	a0,s5
 740:	00000097          	auipc	ra,0x0
 744:	e08080e7          	jalr	-504(ra) # 548 <putc>
 748:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 74a:	03c9d793          	srli	a5,s3,0x3c
 74e:	97de                	add	a5,a5,s7
 750:	0007c583          	lbu	a1,0(a5)
 754:	8556                	mv	a0,s5
 756:	00000097          	auipc	ra,0x0
 75a:	df2080e7          	jalr	-526(ra) # 548 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 75e:	0992                	slli	s3,s3,0x4
 760:	397d                	addiw	s2,s2,-1
 762:	fe0914e3          	bnez	s2,74a <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 766:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 76a:	4981                	li	s3,0
 76c:	b721                	j	674 <vprintf+0x60>
        s = va_arg(ap, char*);
 76e:	008b0993          	addi	s3,s6,8
 772:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 776:	02090163          	beqz	s2,798 <vprintf+0x184>
        while(*s != 0){
 77a:	00094583          	lbu	a1,0(s2)
 77e:	c9a1                	beqz	a1,7ce <vprintf+0x1ba>
          putc(fd, *s);
 780:	8556                	mv	a0,s5
 782:	00000097          	auipc	ra,0x0
 786:	dc6080e7          	jalr	-570(ra) # 548 <putc>
          s++;
 78a:	0905                	addi	s2,s2,1
        while(*s != 0){
 78c:	00094583          	lbu	a1,0(s2)
 790:	f9e5                	bnez	a1,780 <vprintf+0x16c>
        s = va_arg(ap, char*);
 792:	8b4e                	mv	s6,s3
      state = 0;
 794:	4981                	li	s3,0
 796:	bdf9                	j	674 <vprintf+0x60>
          s = "(null)";
 798:	00000917          	auipc	s2,0x0
 79c:	32890913          	addi	s2,s2,808 # ac0 <malloc+0x1e2>
        while(*s != 0){
 7a0:	02800593          	li	a1,40
 7a4:	bff1                	j	780 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 7a6:	008b0913          	addi	s2,s6,8
 7aa:	000b4583          	lbu	a1,0(s6)
 7ae:	8556                	mv	a0,s5
 7b0:	00000097          	auipc	ra,0x0
 7b4:	d98080e7          	jalr	-616(ra) # 548 <putc>
 7b8:	8b4a                	mv	s6,s2
      state = 0;
 7ba:	4981                	li	s3,0
 7bc:	bd65                	j	674 <vprintf+0x60>
        putc(fd, c);
 7be:	85d2                	mv	a1,s4
 7c0:	8556                	mv	a0,s5
 7c2:	00000097          	auipc	ra,0x0
 7c6:	d86080e7          	jalr	-634(ra) # 548 <putc>
      state = 0;
 7ca:	4981                	li	s3,0
 7cc:	b565                	j	674 <vprintf+0x60>
        s = va_arg(ap, char*);
 7ce:	8b4e                	mv	s6,s3
      state = 0;
 7d0:	4981                	li	s3,0
 7d2:	b54d                	j	674 <vprintf+0x60>
    }
  }
}
 7d4:	70e6                	ld	ra,120(sp)
 7d6:	7446                	ld	s0,112(sp)
 7d8:	74a6                	ld	s1,104(sp)
 7da:	7906                	ld	s2,96(sp)
 7dc:	69e6                	ld	s3,88(sp)
 7de:	6a46                	ld	s4,80(sp)
 7e0:	6aa6                	ld	s5,72(sp)
 7e2:	6b06                	ld	s6,64(sp)
 7e4:	7be2                	ld	s7,56(sp)
 7e6:	7c42                	ld	s8,48(sp)
 7e8:	7ca2                	ld	s9,40(sp)
 7ea:	7d02                	ld	s10,32(sp)
 7ec:	6de2                	ld	s11,24(sp)
 7ee:	6109                	addi	sp,sp,128
 7f0:	8082                	ret

00000000000007f2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7f2:	715d                	addi	sp,sp,-80
 7f4:	ec06                	sd	ra,24(sp)
 7f6:	e822                	sd	s0,16(sp)
 7f8:	1000                	addi	s0,sp,32
 7fa:	e010                	sd	a2,0(s0)
 7fc:	e414                	sd	a3,8(s0)
 7fe:	e818                	sd	a4,16(s0)
 800:	ec1c                	sd	a5,24(s0)
 802:	03043023          	sd	a6,32(s0)
 806:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 80a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 80e:	8622                	mv	a2,s0
 810:	00000097          	auipc	ra,0x0
 814:	e04080e7          	jalr	-508(ra) # 614 <vprintf>
}
 818:	60e2                	ld	ra,24(sp)
 81a:	6442                	ld	s0,16(sp)
 81c:	6161                	addi	sp,sp,80
 81e:	8082                	ret

0000000000000820 <printf>:

void
printf(const char *fmt, ...)
{
 820:	711d                	addi	sp,sp,-96
 822:	ec06                	sd	ra,24(sp)
 824:	e822                	sd	s0,16(sp)
 826:	1000                	addi	s0,sp,32
 828:	e40c                	sd	a1,8(s0)
 82a:	e810                	sd	a2,16(s0)
 82c:	ec14                	sd	a3,24(s0)
 82e:	f018                	sd	a4,32(s0)
 830:	f41c                	sd	a5,40(s0)
 832:	03043823          	sd	a6,48(s0)
 836:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 83a:	00840613          	addi	a2,s0,8
 83e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 842:	85aa                	mv	a1,a0
 844:	4505                	li	a0,1
 846:	00000097          	auipc	ra,0x0
 84a:	dce080e7          	jalr	-562(ra) # 614 <vprintf>
}
 84e:	60e2                	ld	ra,24(sp)
 850:	6442                	ld	s0,16(sp)
 852:	6125                	addi	sp,sp,96
 854:	8082                	ret

0000000000000856 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 856:	1141                	addi	sp,sp,-16
 858:	e422                	sd	s0,8(sp)
 85a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 85c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 860:	00000797          	auipc	a5,0x0
 864:	2807b783          	ld	a5,640(a5) # ae0 <freep>
 868:	a805                	j	898 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 86a:	4618                	lw	a4,8(a2)
 86c:	9db9                	addw	a1,a1,a4
 86e:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 872:	6398                	ld	a4,0(a5)
 874:	6318                	ld	a4,0(a4)
 876:	fee53823          	sd	a4,-16(a0)
 87a:	a091                	j	8be <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 87c:	ff852703          	lw	a4,-8(a0)
 880:	9e39                	addw	a2,a2,a4
 882:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 884:	ff053703          	ld	a4,-16(a0)
 888:	e398                	sd	a4,0(a5)
 88a:	a099                	j	8d0 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 88c:	6398                	ld	a4,0(a5)
 88e:	00e7e463          	bltu	a5,a4,896 <free+0x40>
 892:	00e6ea63          	bltu	a3,a4,8a6 <free+0x50>
{
 896:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 898:	fed7fae3          	bgeu	a5,a3,88c <free+0x36>
 89c:	6398                	ld	a4,0(a5)
 89e:	00e6e463          	bltu	a3,a4,8a6 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8a2:	fee7eae3          	bltu	a5,a4,896 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 8a6:	ff852583          	lw	a1,-8(a0)
 8aa:	6390                	ld	a2,0(a5)
 8ac:	02059713          	slli	a4,a1,0x20
 8b0:	9301                	srli	a4,a4,0x20
 8b2:	0712                	slli	a4,a4,0x4
 8b4:	9736                	add	a4,a4,a3
 8b6:	fae60ae3          	beq	a2,a4,86a <free+0x14>
    bp->s.ptr = p->s.ptr;
 8ba:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8be:	4790                	lw	a2,8(a5)
 8c0:	02061713          	slli	a4,a2,0x20
 8c4:	9301                	srli	a4,a4,0x20
 8c6:	0712                	slli	a4,a4,0x4
 8c8:	973e                	add	a4,a4,a5
 8ca:	fae689e3          	beq	a3,a4,87c <free+0x26>
  } else
    p->s.ptr = bp;
 8ce:	e394                	sd	a3,0(a5)
  freep = p;
 8d0:	00000717          	auipc	a4,0x0
 8d4:	20f73823          	sd	a5,528(a4) # ae0 <freep>
}
 8d8:	6422                	ld	s0,8(sp)
 8da:	0141                	addi	sp,sp,16
 8dc:	8082                	ret

00000000000008de <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8de:	7139                	addi	sp,sp,-64
 8e0:	fc06                	sd	ra,56(sp)
 8e2:	f822                	sd	s0,48(sp)
 8e4:	f426                	sd	s1,40(sp)
 8e6:	f04a                	sd	s2,32(sp)
 8e8:	ec4e                	sd	s3,24(sp)
 8ea:	e852                	sd	s4,16(sp)
 8ec:	e456                	sd	s5,8(sp)
 8ee:	e05a                	sd	s6,0(sp)
 8f0:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8f2:	02051493          	slli	s1,a0,0x20
 8f6:	9081                	srli	s1,s1,0x20
 8f8:	04bd                	addi	s1,s1,15
 8fa:	8091                	srli	s1,s1,0x4
 8fc:	0014899b          	addiw	s3,s1,1
 900:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 902:	00000797          	auipc	a5,0x0
 906:	1de7b783          	ld	a5,478(a5) # ae0 <freep>
 90a:	c795                	beqz	a5,936 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 90c:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
 90e:	4518                	lw	a4,8(a0)
 910:	02977f63          	bgeu	a4,s1,94e <malloc+0x70>
 914:	8a4e                	mv	s4,s3
 916:	0009879b          	sext.w	a5,s3
 91a:	6705                	lui	a4,0x1
 91c:	00e7f363          	bgeu	a5,a4,922 <malloc+0x44>
 920:	6a05                	lui	s4,0x1
 922:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 926:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p);
    }
    if(p == freep)
 92a:	00000917          	auipc	s2,0x0
 92e:	1b690913          	addi	s2,s2,438 # ae0 <freep>
  if(p == (char*)-1)
 932:	5afd                	li	s5,-1
 934:	a0bd                	j	9a2 <malloc+0xc4>
    base.s.ptr = freep = prevp = &base;
 936:	00000517          	auipc	a0,0x0
 93a:	1b250513          	addi	a0,a0,434 # ae8 <base>
 93e:	00000797          	auipc	a5,0x0
 942:	1aa7b123          	sd	a0,418(a5) # ae0 <freep>
 946:	e108                	sd	a0,0(a0)
    base.s.size = 0;
 948:	00052423          	sw	zero,8(a0)
    if(p->s.size >= nunits){
 94c:	b7e1                	j	914 <malloc+0x36>
      if(p->s.size == nunits)
 94e:	02e48963          	beq	s1,a4,980 <malloc+0xa2>
        p->s.size -= nunits;
 952:	4137073b          	subw	a4,a4,s3
 956:	c518                	sw	a4,8(a0)
        p += p->s.size;
 958:	1702                	slli	a4,a4,0x20
 95a:	9301                	srli	a4,a4,0x20
 95c:	0712                	slli	a4,a4,0x4
 95e:	953a                	add	a0,a0,a4
        p->s.size = nunits;
 960:	01352423          	sw	s3,8(a0)
      freep = prevp;
 964:	00000717          	auipc	a4,0x0
 968:	16f73e23          	sd	a5,380(a4) # ae0 <freep>
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 96c:	70e2                	ld	ra,56(sp)
 96e:	7442                	ld	s0,48(sp)
 970:	74a2                	ld	s1,40(sp)
 972:	7902                	ld	s2,32(sp)
 974:	69e2                	ld	s3,24(sp)
 976:	6a42                	ld	s4,16(sp)
 978:	6aa2                	ld	s5,8(sp)
 97a:	6b02                	ld	s6,0(sp)
 97c:	6121                	addi	sp,sp,64
 97e:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 980:	6118                	ld	a4,0(a0)
 982:	e398                	sd	a4,0(a5)
 984:	b7c5                	j	964 <malloc+0x86>
  hp->s.size = nu;
 986:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 98a:	0541                	addi	a0,a0,16
 98c:	00000097          	auipc	ra,0x0
 990:	eca080e7          	jalr	-310(ra) # 856 <free>
  return freep;
 994:	00093783          	ld	a5,0(s2)
      if((p = morecore(nunits)) == 0)
 998:	c39d                	beqz	a5,9be <malloc+0xe0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 99a:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
 99c:	4518                	lw	a4,8(a0)
 99e:	fa9778e3          	bgeu	a4,s1,94e <malloc+0x70>
    if(p == freep)
 9a2:	00093703          	ld	a4,0(s2)
 9a6:	87aa                	mv	a5,a0
 9a8:	fea719e3          	bne	a4,a0,99a <malloc+0xbc>
  p = sbrk(nu * sizeof(Header));
 9ac:	8552                	mv	a0,s4
 9ae:	00000097          	auipc	ra,0x0
 9b2:	b56080e7          	jalr	-1194(ra) # 504 <sbrk>
  if(p == (char*)-1)
 9b6:	fd5518e3          	bne	a0,s5,986 <malloc+0xa8>
        return 0;
 9ba:	4501                	li	a0,0
 9bc:	bf45                	j	96c <malloc+0x8e>
 9be:	853e                	mv	a0,a5
 9c0:	b775                	j	96c <malloc+0x8e>
