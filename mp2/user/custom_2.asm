
user/_custom_2:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <rng>:

#define PG_SIZE 4096
#define NR_PG 16

/* madvise: lots of WILLNEED, DONTNEED, and page fault*/
uint rng() {
   0:	1141                	addi	sp,sp,-16
   2:	e422                	sd	s0,8(sp)
   4:	0800                	addi	s0,sp,16
	static uint x = 41;
	return (x = x*0xdefaced + 17);
   6:	00001717          	auipc	a4,0x1
   a:	96e70713          	addi	a4,a4,-1682 # 974 <x.1103>
   e:	4308                	lw	a0,0(a4)
  10:	0defb7b7          	lui	a5,0xdefb
  14:	ced7879b          	addiw	a5,a5,-787
  18:	02f5053b          	mulw	a0,a0,a5
  1c:	2545                	addiw	a0,a0,17
  1e:	c308                	sw	a0,0(a4)
}
  20:	2501                	sext.w	a0,a0
  22:	6422                	ld	s0,8(sp)
  24:	0141                	addi	sp,sp,16
  26:	8082                	ret

0000000000000028 <main>:

int main(int argc, char *argv[]) {
  28:	7159                	addi	sp,sp,-112
  2a:	f486                	sd	ra,104(sp)
  2c:	f0a2                	sd	s0,96(sp)
  2e:	eca6                	sd	s1,88(sp)
  30:	e8ca                	sd	s2,80(sp)
  32:	e4ce                	sd	s3,72(sp)
  34:	e0d2                	sd	s4,64(sp)
  36:	fc56                	sd	s5,56(sp)
  38:	f85a                	sd	s6,48(sp)
  3a:	f45e                	sd	s7,40(sp)
  3c:	f062                	sd	s8,32(sp)
  3e:	ec66                	sd	s9,24(sp)
  40:	e86a                	sd	s10,16(sp)
  42:	e46e                	sd	s11,8(sp)
  44:	1880                	addi	s0,sp,112
	vmprint();
  46:	00000097          	auipc	ra,0x0
  4a:	448080e7          	jalr	1096(ra) # 48e <vmprint>
	char *ptr = malloc(NR_PG * PG_SIZE);
  4e:	6541                	lui	a0,0x10
  50:	00000097          	auipc	ra,0x0
  54:	7f0080e7          	jalr	2032(ra) # 840 <malloc>
  58:	8aaa                	mv	s5,a0
  5a:	0ff00993          	li	s3,255
	for (int i = 0;i < 255;i++) {
		int lef = rng()%15, rig = rng()%15;
  5e:	4a3d                	li	s4,15
		if (lef > rig) {
			int tmp = lef;
			lef = rig;
			rig = tmp;
		}
		int btype = rng()%3;
  60:	4b0d                	li	s6,3
		if (btype == 0) {
			printf("DONTNEED %d %d\n", lef+3, rig+3);
			madvise((uint64) ptr + lef*PG_SIZE, (rig-lef+1)*PG_SIZE, MADV_DONTNEED);
		} else if (btype == 1) {
  62:	4b85                	li	s7,1
			printf("WILLNEED %d %d\n", lef+3, rig+3);
			madvise((uint64) ptr + lef*PG_SIZE, (rig-lef+1)*PG_SIZE, MADV_WILLNEED);
		}  else {
			int idx = rng()%15;
			char *qtr = ptr+idx*PG_SIZE+idx;
			printf("ACCESS %d\n", idx+3);
  64:	00001c97          	auipc	s9,0x1
  68:	8e4c8c93          	addi	s9,s9,-1820 # 948 <malloc+0x108>
			*qtr = 'a';
  6c:	06100c13          	li	s8,97
			printf("WILLNEED %d %d\n", lef+3, rig+3);
  70:	00001d97          	auipc	s11,0x1
  74:	8c8d8d93          	addi	s11,s11,-1848 # 938 <malloc+0xf8>
			printf("DONTNEED %d %d\n", lef+3, rig+3);
  78:	00001d17          	auipc	s10,0x1
  7c:	8b0d0d13          	addi	s10,s10,-1872 # 928 <malloc+0xe8>
  80:	a09d                	j	e6 <main+0xbe>
  82:	00348613          	addi	a2,s1,3
  86:	00390593          	addi	a1,s2,3
  8a:	856a                	mv	a0,s10
  8c:	00000097          	auipc	ra,0x0
  90:	6f6080e7          	jalr	1782(ra) # 782 <printf>
			madvise((uint64) ptr + lef*PG_SIZE, (rig-lef+1)*PG_SIZE, MADV_DONTNEED);
  94:	412485bb          	subw	a1,s1,s2
  98:	2585                	addiw	a1,a1,1
  9a:	00c91513          	slli	a0,s2,0xc
  9e:	4609                	li	a2,2
  a0:	00c5959b          	slliw	a1,a1,0xc
  a4:	9556                	add	a0,a0,s5
  a6:	00000097          	auipc	ra,0x0
  aa:	3f0080e7          	jalr	1008(ra) # 496 <madvise>
  ae:	a02d                	j	d8 <main+0xb0>
			int idx = rng()%15;
  b0:	00000097          	auipc	ra,0x0
  b4:	f50080e7          	jalr	-176(ra) # 0 <rng>
  b8:	034575bb          	remuw	a1,a0,s4
  bc:	0005879b          	sext.w	a5,a1
			char *qtr = ptr+idx*PG_SIZE+idx;
  c0:	00c5949b          	slliw	s1,a1,0xc
  c4:	94be                	add	s1,s1,a5
  c6:	94d6                	add	s1,s1,s5
			printf("ACCESS %d\n", idx+3);
  c8:	258d                	addiw	a1,a1,3
  ca:	8566                	mv	a0,s9
  cc:	00000097          	auipc	ra,0x0
  d0:	6b6080e7          	jalr	1718(ra) # 782 <printf>
			*qtr = 'a';
  d4:	01848023          	sb	s8,0(s1)
		}
		vmprint();
  d8:	00000097          	auipc	ra,0x0
  dc:	3b6080e7          	jalr	950(ra) # 48e <vmprint>
	for (int i = 0;i < 255;i++) {
  e0:	39fd                	addiw	s3,s3,-1
  e2:	06098363          	beqz	s3,148 <main+0x120>
		int lef = rng()%15, rig = rng()%15;
  e6:	00000097          	auipc	ra,0x0
  ea:	f1a080e7          	jalr	-230(ra) # 0 <rng>
  ee:	0345793b          	remuw	s2,a0,s4
  f2:	00000097          	auipc	ra,0x0
  f6:	f0e080e7          	jalr	-242(ra) # 0 <rng>
  fa:	034574bb          	remuw	s1,a0,s4
		if (lef > rig) {
  fe:	0124d563          	bge	s1,s2,108 <main+0xe0>
 102:	87ca                	mv	a5,s2
			lef = rig;
 104:	8926                	mv	s2,s1
			rig = tmp;
 106:	84be                	mv	s1,a5
		int btype = rng()%3;
 108:	00000097          	auipc	ra,0x0
 10c:	ef8080e7          	jalr	-264(ra) # 0 <rng>
 110:	0365753b          	remuw	a0,a0,s6
		if (btype == 0) {
 114:	d53d                	beqz	a0,82 <main+0x5a>
		} else if (btype == 1) {
 116:	f9751de3          	bne	a0,s7,b0 <main+0x88>
			printf("WILLNEED %d %d\n", lef+3, rig+3);
 11a:	00348613          	addi	a2,s1,3
 11e:	00390593          	addi	a1,s2,3
 122:	856e                	mv	a0,s11
 124:	00000097          	auipc	ra,0x0
 128:	65e080e7          	jalr	1630(ra) # 782 <printf>
			madvise((uint64) ptr + lef*PG_SIZE, (rig-lef+1)*PG_SIZE, MADV_WILLNEED);
 12c:	412485bb          	subw	a1,s1,s2
 130:	2585                	addiw	a1,a1,1
 132:	00c91513          	slli	a0,s2,0xc
 136:	865e                	mv	a2,s7
 138:	00c5959b          	slliw	a1,a1,0xc
 13c:	9556                	add	a0,a0,s5
 13e:	00000097          	auipc	ra,0x0
 142:	358080e7          	jalr	856(ra) # 496 <madvise>
 146:	bf49                	j	d8 <main+0xb0>
	}
	exit(0);
 148:	4501                	li	a0,0
 14a:	00000097          	auipc	ra,0x0
 14e:	294080e7          	jalr	660(ra) # 3de <exit>

0000000000000152 <strcpy>:



char*
strcpy(char *s, const char *t)
{
 152:	1141                	addi	sp,sp,-16
 154:	e422                	sd	s0,8(sp)
 156:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 158:	87aa                	mv	a5,a0
 15a:	0585                	addi	a1,a1,1
 15c:	0785                	addi	a5,a5,1
 15e:	fff5c703          	lbu	a4,-1(a1)
 162:	fee78fa3          	sb	a4,-1(a5) # defafff <__global_pointer$+0xdef9e8e>
 166:	fb75                	bnez	a4,15a <strcpy+0x8>
    ;
  return os;
}
 168:	6422                	ld	s0,8(sp)
 16a:	0141                	addi	sp,sp,16
 16c:	8082                	ret

000000000000016e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 16e:	1141                	addi	sp,sp,-16
 170:	e422                	sd	s0,8(sp)
 172:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 174:	00054783          	lbu	a5,0(a0) # 10000 <__global_pointer$+0xee8f>
 178:	cb91                	beqz	a5,18c <strcmp+0x1e>
 17a:	0005c703          	lbu	a4,0(a1)
 17e:	00f71763          	bne	a4,a5,18c <strcmp+0x1e>
    p++, q++;
 182:	0505                	addi	a0,a0,1
 184:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 186:	00054783          	lbu	a5,0(a0)
 18a:	fbe5                	bnez	a5,17a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 18c:	0005c503          	lbu	a0,0(a1)
}
 190:	40a7853b          	subw	a0,a5,a0
 194:	6422                	ld	s0,8(sp)
 196:	0141                	addi	sp,sp,16
 198:	8082                	ret

000000000000019a <strlen>:

uint
strlen(const char *s)
{
 19a:	1141                	addi	sp,sp,-16
 19c:	e422                	sd	s0,8(sp)
 19e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1a0:	00054783          	lbu	a5,0(a0)
 1a4:	cf91                	beqz	a5,1c0 <strlen+0x26>
 1a6:	0505                	addi	a0,a0,1
 1a8:	87aa                	mv	a5,a0
 1aa:	4685                	li	a3,1
 1ac:	9e89                	subw	a3,a3,a0
 1ae:	00f6853b          	addw	a0,a3,a5
 1b2:	0785                	addi	a5,a5,1
 1b4:	fff7c703          	lbu	a4,-1(a5)
 1b8:	fb7d                	bnez	a4,1ae <strlen+0x14>
    ;
  return n;
}
 1ba:	6422                	ld	s0,8(sp)
 1bc:	0141                	addi	sp,sp,16
 1be:	8082                	ret
  for(n = 0; s[n]; n++)
 1c0:	4501                	li	a0,0
 1c2:	bfe5                	j	1ba <strlen+0x20>

00000000000001c4 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1c4:	1141                	addi	sp,sp,-16
 1c6:	e422                	sd	s0,8(sp)
 1c8:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1ca:	ce09                	beqz	a2,1e4 <memset+0x20>
 1cc:	87aa                	mv	a5,a0
 1ce:	fff6071b          	addiw	a4,a2,-1
 1d2:	1702                	slli	a4,a4,0x20
 1d4:	9301                	srli	a4,a4,0x20
 1d6:	0705                	addi	a4,a4,1
 1d8:	972a                	add	a4,a4,a0
    cdst[i] = c;
 1da:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1de:	0785                	addi	a5,a5,1
 1e0:	fee79de3          	bne	a5,a4,1da <memset+0x16>
  }
  return dst;
}
 1e4:	6422                	ld	s0,8(sp)
 1e6:	0141                	addi	sp,sp,16
 1e8:	8082                	ret

00000000000001ea <strchr>:

char*
strchr(const char *s, char c)
{
 1ea:	1141                	addi	sp,sp,-16
 1ec:	e422                	sd	s0,8(sp)
 1ee:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1f0:	00054783          	lbu	a5,0(a0)
 1f4:	cb99                	beqz	a5,20a <strchr+0x20>
    if(*s == c)
 1f6:	00f58763          	beq	a1,a5,204 <strchr+0x1a>
  for(; *s; s++)
 1fa:	0505                	addi	a0,a0,1
 1fc:	00054783          	lbu	a5,0(a0)
 200:	fbfd                	bnez	a5,1f6 <strchr+0xc>
      return (char*)s;
  return 0;
 202:	4501                	li	a0,0
}
 204:	6422                	ld	s0,8(sp)
 206:	0141                	addi	sp,sp,16
 208:	8082                	ret
  return 0;
 20a:	4501                	li	a0,0
 20c:	bfe5                	j	204 <strchr+0x1a>

000000000000020e <gets>:

char*
gets(char *buf, int max)
{
 20e:	711d                	addi	sp,sp,-96
 210:	ec86                	sd	ra,88(sp)
 212:	e8a2                	sd	s0,80(sp)
 214:	e4a6                	sd	s1,72(sp)
 216:	e0ca                	sd	s2,64(sp)
 218:	fc4e                	sd	s3,56(sp)
 21a:	f852                	sd	s4,48(sp)
 21c:	f456                	sd	s5,40(sp)
 21e:	f05a                	sd	s6,32(sp)
 220:	ec5e                	sd	s7,24(sp)
 222:	1080                	addi	s0,sp,96
 224:	8baa                	mv	s7,a0
 226:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 228:	892a                	mv	s2,a0
 22a:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 22c:	4aa9                	li	s5,10
 22e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 230:	89a6                	mv	s3,s1
 232:	2485                	addiw	s1,s1,1
 234:	0344d863          	bge	s1,s4,264 <gets+0x56>
    cc = read(0, &c, 1);
 238:	4605                	li	a2,1
 23a:	faf40593          	addi	a1,s0,-81
 23e:	4501                	li	a0,0
 240:	00000097          	auipc	ra,0x0
 244:	1b6080e7          	jalr	438(ra) # 3f6 <read>
    if(cc < 1)
 248:	00a05e63          	blez	a0,264 <gets+0x56>
    buf[i++] = c;
 24c:	faf44783          	lbu	a5,-81(s0)
 250:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 254:	01578763          	beq	a5,s5,262 <gets+0x54>
 258:	0905                	addi	s2,s2,1
 25a:	fd679be3          	bne	a5,s6,230 <gets+0x22>
  for(i=0; i+1 < max; ){
 25e:	89a6                	mv	s3,s1
 260:	a011                	j	264 <gets+0x56>
 262:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 264:	99de                	add	s3,s3,s7
 266:	00098023          	sb	zero,0(s3)
  return buf;
}
 26a:	855e                	mv	a0,s7
 26c:	60e6                	ld	ra,88(sp)
 26e:	6446                	ld	s0,80(sp)
 270:	64a6                	ld	s1,72(sp)
 272:	6906                	ld	s2,64(sp)
 274:	79e2                	ld	s3,56(sp)
 276:	7a42                	ld	s4,48(sp)
 278:	7aa2                	ld	s5,40(sp)
 27a:	7b02                	ld	s6,32(sp)
 27c:	6be2                	ld	s7,24(sp)
 27e:	6125                	addi	sp,sp,96
 280:	8082                	ret

0000000000000282 <stat>:

int
stat(const char *n, struct stat *st)
{
 282:	1101                	addi	sp,sp,-32
 284:	ec06                	sd	ra,24(sp)
 286:	e822                	sd	s0,16(sp)
 288:	e426                	sd	s1,8(sp)
 28a:	e04a                	sd	s2,0(sp)
 28c:	1000                	addi	s0,sp,32
 28e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 290:	4581                	li	a1,0
 292:	00000097          	auipc	ra,0x0
 296:	18c080e7          	jalr	396(ra) # 41e <open>
  if(fd < 0)
 29a:	02054563          	bltz	a0,2c4 <stat+0x42>
 29e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2a0:	85ca                	mv	a1,s2
 2a2:	00000097          	auipc	ra,0x0
 2a6:	194080e7          	jalr	404(ra) # 436 <fstat>
 2aa:	892a                	mv	s2,a0
  close(fd);
 2ac:	8526                	mv	a0,s1
 2ae:	00000097          	auipc	ra,0x0
 2b2:	158080e7          	jalr	344(ra) # 406 <close>
  return r;
}
 2b6:	854a                	mv	a0,s2
 2b8:	60e2                	ld	ra,24(sp)
 2ba:	6442                	ld	s0,16(sp)
 2bc:	64a2                	ld	s1,8(sp)
 2be:	6902                	ld	s2,0(sp)
 2c0:	6105                	addi	sp,sp,32
 2c2:	8082                	ret
    return -1;
 2c4:	597d                	li	s2,-1
 2c6:	bfc5                	j	2b6 <stat+0x34>

00000000000002c8 <atoi>:

int
atoi(const char *s)
{
 2c8:	1141                	addi	sp,sp,-16
 2ca:	e422                	sd	s0,8(sp)
 2cc:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2ce:	00054603          	lbu	a2,0(a0)
 2d2:	fd06079b          	addiw	a5,a2,-48
 2d6:	0ff7f793          	andi	a5,a5,255
 2da:	4725                	li	a4,9
 2dc:	02f76963          	bltu	a4,a5,30e <atoi+0x46>
 2e0:	86aa                	mv	a3,a0
  n = 0;
 2e2:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 2e4:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 2e6:	0685                	addi	a3,a3,1
 2e8:	0025179b          	slliw	a5,a0,0x2
 2ec:	9fa9                	addw	a5,a5,a0
 2ee:	0017979b          	slliw	a5,a5,0x1
 2f2:	9fb1                	addw	a5,a5,a2
 2f4:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2f8:	0006c603          	lbu	a2,0(a3)
 2fc:	fd06071b          	addiw	a4,a2,-48
 300:	0ff77713          	andi	a4,a4,255
 304:	fee5f1e3          	bgeu	a1,a4,2e6 <atoi+0x1e>
  return n;
}
 308:	6422                	ld	s0,8(sp)
 30a:	0141                	addi	sp,sp,16
 30c:	8082                	ret
  n = 0;
 30e:	4501                	li	a0,0
 310:	bfe5                	j	308 <atoi+0x40>

0000000000000312 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 312:	1141                	addi	sp,sp,-16
 314:	e422                	sd	s0,8(sp)
 316:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 318:	02b57663          	bgeu	a0,a1,344 <memmove+0x32>
    while(n-- > 0)
 31c:	02c05163          	blez	a2,33e <memmove+0x2c>
 320:	fff6079b          	addiw	a5,a2,-1
 324:	1782                	slli	a5,a5,0x20
 326:	9381                	srli	a5,a5,0x20
 328:	0785                	addi	a5,a5,1
 32a:	97aa                	add	a5,a5,a0
  dst = vdst;
 32c:	872a                	mv	a4,a0
      *dst++ = *src++;
 32e:	0585                	addi	a1,a1,1
 330:	0705                	addi	a4,a4,1
 332:	fff5c683          	lbu	a3,-1(a1)
 336:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 33a:	fee79ae3          	bne	a5,a4,32e <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 33e:	6422                	ld	s0,8(sp)
 340:	0141                	addi	sp,sp,16
 342:	8082                	ret
    dst += n;
 344:	00c50733          	add	a4,a0,a2
    src += n;
 348:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 34a:	fec05ae3          	blez	a2,33e <memmove+0x2c>
 34e:	fff6079b          	addiw	a5,a2,-1
 352:	1782                	slli	a5,a5,0x20
 354:	9381                	srli	a5,a5,0x20
 356:	fff7c793          	not	a5,a5
 35a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 35c:	15fd                	addi	a1,a1,-1
 35e:	177d                	addi	a4,a4,-1
 360:	0005c683          	lbu	a3,0(a1)
 364:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 368:	fee79ae3          	bne	a5,a4,35c <memmove+0x4a>
 36c:	bfc9                	j	33e <memmove+0x2c>

000000000000036e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 36e:	1141                	addi	sp,sp,-16
 370:	e422                	sd	s0,8(sp)
 372:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 374:	ca05                	beqz	a2,3a4 <memcmp+0x36>
 376:	fff6069b          	addiw	a3,a2,-1
 37a:	1682                	slli	a3,a3,0x20
 37c:	9281                	srli	a3,a3,0x20
 37e:	0685                	addi	a3,a3,1
 380:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 382:	00054783          	lbu	a5,0(a0)
 386:	0005c703          	lbu	a4,0(a1)
 38a:	00e79863          	bne	a5,a4,39a <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 38e:	0505                	addi	a0,a0,1
    p2++;
 390:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 392:	fed518e3          	bne	a0,a3,382 <memcmp+0x14>
  }
  return 0;
 396:	4501                	li	a0,0
 398:	a019                	j	39e <memcmp+0x30>
      return *p1 - *p2;
 39a:	40e7853b          	subw	a0,a5,a4
}
 39e:	6422                	ld	s0,8(sp)
 3a0:	0141                	addi	sp,sp,16
 3a2:	8082                	ret
  return 0;
 3a4:	4501                	li	a0,0
 3a6:	bfe5                	j	39e <memcmp+0x30>

00000000000003a8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3a8:	1141                	addi	sp,sp,-16
 3aa:	e406                	sd	ra,8(sp)
 3ac:	e022                	sd	s0,0(sp)
 3ae:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3b0:	00000097          	auipc	ra,0x0
 3b4:	f62080e7          	jalr	-158(ra) # 312 <memmove>
}
 3b8:	60a2                	ld	ra,8(sp)
 3ba:	6402                	ld	s0,0(sp)
 3bc:	0141                	addi	sp,sp,16
 3be:	8082                	ret

00000000000003c0 <ugetpid>:

#ifdef LAB_PGTBL
int
ugetpid(void)
{
 3c0:	1141                	addi	sp,sp,-16
 3c2:	e422                	sd	s0,8(sp)
 3c4:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 3c6:	040007b7          	lui	a5,0x4000
}
 3ca:	17f5                	addi	a5,a5,-3
 3cc:	07b2                	slli	a5,a5,0xc
 3ce:	4388                	lw	a0,0(a5)
 3d0:	6422                	ld	s0,8(sp)
 3d2:	0141                	addi	sp,sp,16
 3d4:	8082                	ret

00000000000003d6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3d6:	4885                	li	a7,1
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <exit>:
.global exit
exit:
 li a7, SYS_exit
 3de:	4889                	li	a7,2
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3e6:	488d                	li	a7,3
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3ee:	4891                	li	a7,4
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <read>:
.global read
read:
 li a7, SYS_read
 3f6:	4895                	li	a7,5
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <write>:
.global write
write:
 li a7, SYS_write
 3fe:	48c1                	li	a7,16
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <close>:
.global close
close:
 li a7, SYS_close
 406:	48d5                	li	a7,21
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <kill>:
.global kill
kill:
 li a7, SYS_kill
 40e:	4899                	li	a7,6
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <exec>:
.global exec
exec:
 li a7, SYS_exec
 416:	489d                	li	a7,7
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <open>:
.global open
open:
 li a7, SYS_open
 41e:	48bd                	li	a7,15
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 426:	48c5                	li	a7,17
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 42e:	48c9                	li	a7,18
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 436:	48a1                	li	a7,8
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <link>:
.global link
link:
 li a7, SYS_link
 43e:	48cd                	li	a7,19
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 446:	48d1                	li	a7,20
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 44e:	48a5                	li	a7,9
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <dup>:
.global dup
dup:
 li a7, SYS_dup
 456:	48a9                	li	a7,10
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 45e:	48ad                	li	a7,11
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 466:	48b1                	li	a7,12
 ecall
 468:	00000073          	ecall
 ret
 46c:	8082                	ret

000000000000046e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 46e:	48b5                	li	a7,13
 ecall
 470:	00000073          	ecall
 ret
 474:	8082                	ret

0000000000000476 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 476:	48b9                	li	a7,14
 ecall
 478:	00000073          	ecall
 ret
 47c:	8082                	ret

000000000000047e <connect>:
.global connect
connect:
 li a7, SYS_connect
 47e:	48f5                	li	a7,29
 ecall
 480:	00000073          	ecall
 ret
 484:	8082                	ret

0000000000000486 <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 486:	48f9                	li	a7,30
 ecall
 488:	00000073          	ecall
 ret
 48c:	8082                	ret

000000000000048e <vmprint>:
.global vmprint
vmprint:
 li a7, SYS_vmprint
 48e:	48fd                	li	a7,31
 ecall
 490:	00000073          	ecall
 ret
 494:	8082                	ret

0000000000000496 <madvise>:
.global madvise
madvise:
 li a7, SYS_madvise
 496:	02000893          	li	a7,32
 ecall
 49a:	00000073          	ecall
 ret
 49e:	8082                	ret

00000000000004a0 <pgprint>:
.global pgprint
pgprint:
 li a7, SYS_pgprint
 4a0:	02100893          	li	a7,33
 ecall
 4a4:	00000073          	ecall
 ret
 4a8:	8082                	ret

00000000000004aa <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4aa:	1101                	addi	sp,sp,-32
 4ac:	ec06                	sd	ra,24(sp)
 4ae:	e822                	sd	s0,16(sp)
 4b0:	1000                	addi	s0,sp,32
 4b2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4b6:	4605                	li	a2,1
 4b8:	fef40593          	addi	a1,s0,-17
 4bc:	00000097          	auipc	ra,0x0
 4c0:	f42080e7          	jalr	-190(ra) # 3fe <write>
}
 4c4:	60e2                	ld	ra,24(sp)
 4c6:	6442                	ld	s0,16(sp)
 4c8:	6105                	addi	sp,sp,32
 4ca:	8082                	ret

00000000000004cc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4cc:	7139                	addi	sp,sp,-64
 4ce:	fc06                	sd	ra,56(sp)
 4d0:	f822                	sd	s0,48(sp)
 4d2:	f426                	sd	s1,40(sp)
 4d4:	f04a                	sd	s2,32(sp)
 4d6:	ec4e                	sd	s3,24(sp)
 4d8:	0080                	addi	s0,sp,64
 4da:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4dc:	c299                	beqz	a3,4e2 <printint+0x16>
 4de:	0805c863          	bltz	a1,56e <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4e2:	2581                	sext.w	a1,a1
  neg = 0;
 4e4:	4881                	li	a7,0
 4e6:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 4ea:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 4ec:	2601                	sext.w	a2,a2
 4ee:	00000517          	auipc	a0,0x0
 4f2:	47250513          	addi	a0,a0,1138 # 960 <digits>
 4f6:	883a                	mv	a6,a4
 4f8:	2705                	addiw	a4,a4,1
 4fa:	02c5f7bb          	remuw	a5,a1,a2
 4fe:	1782                	slli	a5,a5,0x20
 500:	9381                	srli	a5,a5,0x20
 502:	97aa                	add	a5,a5,a0
 504:	0007c783          	lbu	a5,0(a5) # 4000000 <__global_pointer$+0x3ffee8f>
 508:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 50c:	0005879b          	sext.w	a5,a1
 510:	02c5d5bb          	divuw	a1,a1,a2
 514:	0685                	addi	a3,a3,1
 516:	fec7f0e3          	bgeu	a5,a2,4f6 <printint+0x2a>
  if(neg)
 51a:	00088b63          	beqz	a7,530 <printint+0x64>
    buf[i++] = '-';
 51e:	fd040793          	addi	a5,s0,-48
 522:	973e                	add	a4,a4,a5
 524:	02d00793          	li	a5,45
 528:	fef70823          	sb	a5,-16(a4)
 52c:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 530:	02e05863          	blez	a4,560 <printint+0x94>
 534:	fc040793          	addi	a5,s0,-64
 538:	00e78933          	add	s2,a5,a4
 53c:	fff78993          	addi	s3,a5,-1
 540:	99ba                	add	s3,s3,a4
 542:	377d                	addiw	a4,a4,-1
 544:	1702                	slli	a4,a4,0x20
 546:	9301                	srli	a4,a4,0x20
 548:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 54c:	fff94583          	lbu	a1,-1(s2)
 550:	8526                	mv	a0,s1
 552:	00000097          	auipc	ra,0x0
 556:	f58080e7          	jalr	-168(ra) # 4aa <putc>
  while(--i >= 0)
 55a:	197d                	addi	s2,s2,-1
 55c:	ff3918e3          	bne	s2,s3,54c <printint+0x80>
}
 560:	70e2                	ld	ra,56(sp)
 562:	7442                	ld	s0,48(sp)
 564:	74a2                	ld	s1,40(sp)
 566:	7902                	ld	s2,32(sp)
 568:	69e2                	ld	s3,24(sp)
 56a:	6121                	addi	sp,sp,64
 56c:	8082                	ret
    x = -xx;
 56e:	40b005bb          	negw	a1,a1
    neg = 1;
 572:	4885                	li	a7,1
    x = -xx;
 574:	bf8d                	j	4e6 <printint+0x1a>

0000000000000576 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 576:	7119                	addi	sp,sp,-128
 578:	fc86                	sd	ra,120(sp)
 57a:	f8a2                	sd	s0,112(sp)
 57c:	f4a6                	sd	s1,104(sp)
 57e:	f0ca                	sd	s2,96(sp)
 580:	ecce                	sd	s3,88(sp)
 582:	e8d2                	sd	s4,80(sp)
 584:	e4d6                	sd	s5,72(sp)
 586:	e0da                	sd	s6,64(sp)
 588:	fc5e                	sd	s7,56(sp)
 58a:	f862                	sd	s8,48(sp)
 58c:	f466                	sd	s9,40(sp)
 58e:	f06a                	sd	s10,32(sp)
 590:	ec6e                	sd	s11,24(sp)
 592:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 594:	0005c903          	lbu	s2,0(a1)
 598:	18090f63          	beqz	s2,736 <vprintf+0x1c0>
 59c:	8aaa                	mv	s5,a0
 59e:	8b32                	mv	s6,a2
 5a0:	00158493          	addi	s1,a1,1
  state = 0;
 5a4:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5a6:	02500a13          	li	s4,37
      if(c == 'd'){
 5aa:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 5ae:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 5b2:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 5b6:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5ba:	00000b97          	auipc	s7,0x0
 5be:	3a6b8b93          	addi	s7,s7,934 # 960 <digits>
 5c2:	a839                	j	5e0 <vprintf+0x6a>
        putc(fd, c);
 5c4:	85ca                	mv	a1,s2
 5c6:	8556                	mv	a0,s5
 5c8:	00000097          	auipc	ra,0x0
 5cc:	ee2080e7          	jalr	-286(ra) # 4aa <putc>
 5d0:	a019                	j	5d6 <vprintf+0x60>
    } else if(state == '%'){
 5d2:	01498f63          	beq	s3,s4,5f0 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 5d6:	0485                	addi	s1,s1,1
 5d8:	fff4c903          	lbu	s2,-1(s1)
 5dc:	14090d63          	beqz	s2,736 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 5e0:	0009079b          	sext.w	a5,s2
    if(state == 0){
 5e4:	fe0997e3          	bnez	s3,5d2 <vprintf+0x5c>
      if(c == '%'){
 5e8:	fd479ee3          	bne	a5,s4,5c4 <vprintf+0x4e>
        state = '%';
 5ec:	89be                	mv	s3,a5
 5ee:	b7e5                	j	5d6 <vprintf+0x60>
      if(c == 'd'){
 5f0:	05878063          	beq	a5,s8,630 <vprintf+0xba>
      } else if(c == 'l') {
 5f4:	05978c63          	beq	a5,s9,64c <vprintf+0xd6>
      } else if(c == 'x') {
 5f8:	07a78863          	beq	a5,s10,668 <vprintf+0xf2>
      } else if(c == 'p') {
 5fc:	09b78463          	beq	a5,s11,684 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 600:	07300713          	li	a4,115
 604:	0ce78663          	beq	a5,a4,6d0 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 608:	06300713          	li	a4,99
 60c:	0ee78e63          	beq	a5,a4,708 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 610:	11478863          	beq	a5,s4,720 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 614:	85d2                	mv	a1,s4
 616:	8556                	mv	a0,s5
 618:	00000097          	auipc	ra,0x0
 61c:	e92080e7          	jalr	-366(ra) # 4aa <putc>
        putc(fd, c);
 620:	85ca                	mv	a1,s2
 622:	8556                	mv	a0,s5
 624:	00000097          	auipc	ra,0x0
 628:	e86080e7          	jalr	-378(ra) # 4aa <putc>
      }
      state = 0;
 62c:	4981                	li	s3,0
 62e:	b765                	j	5d6 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 630:	008b0913          	addi	s2,s6,8
 634:	4685                	li	a3,1
 636:	4629                	li	a2,10
 638:	000b2583          	lw	a1,0(s6)
 63c:	8556                	mv	a0,s5
 63e:	00000097          	auipc	ra,0x0
 642:	e8e080e7          	jalr	-370(ra) # 4cc <printint>
 646:	8b4a                	mv	s6,s2
      state = 0;
 648:	4981                	li	s3,0
 64a:	b771                	j	5d6 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 64c:	008b0913          	addi	s2,s6,8
 650:	4681                	li	a3,0
 652:	4629                	li	a2,10
 654:	000b2583          	lw	a1,0(s6)
 658:	8556                	mv	a0,s5
 65a:	00000097          	auipc	ra,0x0
 65e:	e72080e7          	jalr	-398(ra) # 4cc <printint>
 662:	8b4a                	mv	s6,s2
      state = 0;
 664:	4981                	li	s3,0
 666:	bf85                	j	5d6 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 668:	008b0913          	addi	s2,s6,8
 66c:	4681                	li	a3,0
 66e:	4641                	li	a2,16
 670:	000b2583          	lw	a1,0(s6)
 674:	8556                	mv	a0,s5
 676:	00000097          	auipc	ra,0x0
 67a:	e56080e7          	jalr	-426(ra) # 4cc <printint>
 67e:	8b4a                	mv	s6,s2
      state = 0;
 680:	4981                	li	s3,0
 682:	bf91                	j	5d6 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 684:	008b0793          	addi	a5,s6,8
 688:	f8f43423          	sd	a5,-120(s0)
 68c:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 690:	03000593          	li	a1,48
 694:	8556                	mv	a0,s5
 696:	00000097          	auipc	ra,0x0
 69a:	e14080e7          	jalr	-492(ra) # 4aa <putc>
  putc(fd, 'x');
 69e:	85ea                	mv	a1,s10
 6a0:	8556                	mv	a0,s5
 6a2:	00000097          	auipc	ra,0x0
 6a6:	e08080e7          	jalr	-504(ra) # 4aa <putc>
 6aa:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6ac:	03c9d793          	srli	a5,s3,0x3c
 6b0:	97de                	add	a5,a5,s7
 6b2:	0007c583          	lbu	a1,0(a5)
 6b6:	8556                	mv	a0,s5
 6b8:	00000097          	auipc	ra,0x0
 6bc:	df2080e7          	jalr	-526(ra) # 4aa <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6c0:	0992                	slli	s3,s3,0x4
 6c2:	397d                	addiw	s2,s2,-1
 6c4:	fe0914e3          	bnez	s2,6ac <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 6c8:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 6cc:	4981                	li	s3,0
 6ce:	b721                	j	5d6 <vprintf+0x60>
        s = va_arg(ap, char*);
 6d0:	008b0993          	addi	s3,s6,8
 6d4:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 6d8:	02090163          	beqz	s2,6fa <vprintf+0x184>
        while(*s != 0){
 6dc:	00094583          	lbu	a1,0(s2)
 6e0:	c9a1                	beqz	a1,730 <vprintf+0x1ba>
          putc(fd, *s);
 6e2:	8556                	mv	a0,s5
 6e4:	00000097          	auipc	ra,0x0
 6e8:	dc6080e7          	jalr	-570(ra) # 4aa <putc>
          s++;
 6ec:	0905                	addi	s2,s2,1
        while(*s != 0){
 6ee:	00094583          	lbu	a1,0(s2)
 6f2:	f9e5                	bnez	a1,6e2 <vprintf+0x16c>
        s = va_arg(ap, char*);
 6f4:	8b4e                	mv	s6,s3
      state = 0;
 6f6:	4981                	li	s3,0
 6f8:	bdf9                	j	5d6 <vprintf+0x60>
          s = "(null)";
 6fa:	00000917          	auipc	s2,0x0
 6fe:	25e90913          	addi	s2,s2,606 # 958 <malloc+0x118>
        while(*s != 0){
 702:	02800593          	li	a1,40
 706:	bff1                	j	6e2 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 708:	008b0913          	addi	s2,s6,8
 70c:	000b4583          	lbu	a1,0(s6)
 710:	8556                	mv	a0,s5
 712:	00000097          	auipc	ra,0x0
 716:	d98080e7          	jalr	-616(ra) # 4aa <putc>
 71a:	8b4a                	mv	s6,s2
      state = 0;
 71c:	4981                	li	s3,0
 71e:	bd65                	j	5d6 <vprintf+0x60>
        putc(fd, c);
 720:	85d2                	mv	a1,s4
 722:	8556                	mv	a0,s5
 724:	00000097          	auipc	ra,0x0
 728:	d86080e7          	jalr	-634(ra) # 4aa <putc>
      state = 0;
 72c:	4981                	li	s3,0
 72e:	b565                	j	5d6 <vprintf+0x60>
        s = va_arg(ap, char*);
 730:	8b4e                	mv	s6,s3
      state = 0;
 732:	4981                	li	s3,0
 734:	b54d                	j	5d6 <vprintf+0x60>
    }
  }
}
 736:	70e6                	ld	ra,120(sp)
 738:	7446                	ld	s0,112(sp)
 73a:	74a6                	ld	s1,104(sp)
 73c:	7906                	ld	s2,96(sp)
 73e:	69e6                	ld	s3,88(sp)
 740:	6a46                	ld	s4,80(sp)
 742:	6aa6                	ld	s5,72(sp)
 744:	6b06                	ld	s6,64(sp)
 746:	7be2                	ld	s7,56(sp)
 748:	7c42                	ld	s8,48(sp)
 74a:	7ca2                	ld	s9,40(sp)
 74c:	7d02                	ld	s10,32(sp)
 74e:	6de2                	ld	s11,24(sp)
 750:	6109                	addi	sp,sp,128
 752:	8082                	ret

0000000000000754 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 754:	715d                	addi	sp,sp,-80
 756:	ec06                	sd	ra,24(sp)
 758:	e822                	sd	s0,16(sp)
 75a:	1000                	addi	s0,sp,32
 75c:	e010                	sd	a2,0(s0)
 75e:	e414                	sd	a3,8(s0)
 760:	e818                	sd	a4,16(s0)
 762:	ec1c                	sd	a5,24(s0)
 764:	03043023          	sd	a6,32(s0)
 768:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 76c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 770:	8622                	mv	a2,s0
 772:	00000097          	auipc	ra,0x0
 776:	e04080e7          	jalr	-508(ra) # 576 <vprintf>
}
 77a:	60e2                	ld	ra,24(sp)
 77c:	6442                	ld	s0,16(sp)
 77e:	6161                	addi	sp,sp,80
 780:	8082                	ret

0000000000000782 <printf>:

void
printf(const char *fmt, ...)
{
 782:	711d                	addi	sp,sp,-96
 784:	ec06                	sd	ra,24(sp)
 786:	e822                	sd	s0,16(sp)
 788:	1000                	addi	s0,sp,32
 78a:	e40c                	sd	a1,8(s0)
 78c:	e810                	sd	a2,16(s0)
 78e:	ec14                	sd	a3,24(s0)
 790:	f018                	sd	a4,32(s0)
 792:	f41c                	sd	a5,40(s0)
 794:	03043823          	sd	a6,48(s0)
 798:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 79c:	00840613          	addi	a2,s0,8
 7a0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7a4:	85aa                	mv	a1,a0
 7a6:	4505                	li	a0,1
 7a8:	00000097          	auipc	ra,0x0
 7ac:	dce080e7          	jalr	-562(ra) # 576 <vprintf>
}
 7b0:	60e2                	ld	ra,24(sp)
 7b2:	6442                	ld	s0,16(sp)
 7b4:	6125                	addi	sp,sp,96
 7b6:	8082                	ret

00000000000007b8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7b8:	1141                	addi	sp,sp,-16
 7ba:	e422                	sd	s0,8(sp)
 7bc:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7be:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7c2:	00000797          	auipc	a5,0x0
 7c6:	1b67b783          	ld	a5,438(a5) # 978 <freep>
 7ca:	a805                	j	7fa <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7cc:	4618                	lw	a4,8(a2)
 7ce:	9db9                	addw	a1,a1,a4
 7d0:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7d4:	6398                	ld	a4,0(a5)
 7d6:	6318                	ld	a4,0(a4)
 7d8:	fee53823          	sd	a4,-16(a0)
 7dc:	a091                	j	820 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7de:	ff852703          	lw	a4,-8(a0)
 7e2:	9e39                	addw	a2,a2,a4
 7e4:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 7e6:	ff053703          	ld	a4,-16(a0)
 7ea:	e398                	sd	a4,0(a5)
 7ec:	a099                	j	832 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ee:	6398                	ld	a4,0(a5)
 7f0:	00e7e463          	bltu	a5,a4,7f8 <free+0x40>
 7f4:	00e6ea63          	bltu	a3,a4,808 <free+0x50>
{
 7f8:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7fa:	fed7fae3          	bgeu	a5,a3,7ee <free+0x36>
 7fe:	6398                	ld	a4,0(a5)
 800:	00e6e463          	bltu	a3,a4,808 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 804:	fee7eae3          	bltu	a5,a4,7f8 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 808:	ff852583          	lw	a1,-8(a0)
 80c:	6390                	ld	a2,0(a5)
 80e:	02059713          	slli	a4,a1,0x20
 812:	9301                	srli	a4,a4,0x20
 814:	0712                	slli	a4,a4,0x4
 816:	9736                	add	a4,a4,a3
 818:	fae60ae3          	beq	a2,a4,7cc <free+0x14>
    bp->s.ptr = p->s.ptr;
 81c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 820:	4790                	lw	a2,8(a5)
 822:	02061713          	slli	a4,a2,0x20
 826:	9301                	srli	a4,a4,0x20
 828:	0712                	slli	a4,a4,0x4
 82a:	973e                	add	a4,a4,a5
 82c:	fae689e3          	beq	a3,a4,7de <free+0x26>
  } else
    p->s.ptr = bp;
 830:	e394                	sd	a3,0(a5)
  freep = p;
 832:	00000717          	auipc	a4,0x0
 836:	14f73323          	sd	a5,326(a4) # 978 <freep>
}
 83a:	6422                	ld	s0,8(sp)
 83c:	0141                	addi	sp,sp,16
 83e:	8082                	ret

0000000000000840 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 840:	7139                	addi	sp,sp,-64
 842:	fc06                	sd	ra,56(sp)
 844:	f822                	sd	s0,48(sp)
 846:	f426                	sd	s1,40(sp)
 848:	f04a                	sd	s2,32(sp)
 84a:	ec4e                	sd	s3,24(sp)
 84c:	e852                	sd	s4,16(sp)
 84e:	e456                	sd	s5,8(sp)
 850:	e05a                	sd	s6,0(sp)
 852:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 854:	02051493          	slli	s1,a0,0x20
 858:	9081                	srli	s1,s1,0x20
 85a:	04bd                	addi	s1,s1,15
 85c:	8091                	srli	s1,s1,0x4
 85e:	0014899b          	addiw	s3,s1,1
 862:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 864:	00000797          	auipc	a5,0x0
 868:	1147b783          	ld	a5,276(a5) # 978 <freep>
 86c:	c795                	beqz	a5,898 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 86e:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
 870:	4518                	lw	a4,8(a0)
 872:	02977f63          	bgeu	a4,s1,8b0 <malloc+0x70>
 876:	8a4e                	mv	s4,s3
 878:	0009879b          	sext.w	a5,s3
 87c:	6705                	lui	a4,0x1
 87e:	00e7f363          	bgeu	a5,a4,884 <malloc+0x44>
 882:	6a05                	lui	s4,0x1
 884:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 888:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p);
    }
    if(p == freep)
 88c:	00000917          	auipc	s2,0x0
 890:	0ec90913          	addi	s2,s2,236 # 978 <freep>
  if(p == (char*)-1)
 894:	5afd                	li	s5,-1
 896:	a0bd                	j	904 <malloc+0xc4>
    base.s.ptr = freep = prevp = &base;
 898:	00000517          	auipc	a0,0x0
 89c:	0e850513          	addi	a0,a0,232 # 980 <base>
 8a0:	00000797          	auipc	a5,0x0
 8a4:	0ca7bc23          	sd	a0,216(a5) # 978 <freep>
 8a8:	e108                	sd	a0,0(a0)
    base.s.size = 0;
 8aa:	00052423          	sw	zero,8(a0)
    if(p->s.size >= nunits){
 8ae:	b7e1                	j	876 <malloc+0x36>
      if(p->s.size == nunits)
 8b0:	02e48963          	beq	s1,a4,8e2 <malloc+0xa2>
        p->s.size -= nunits;
 8b4:	4137073b          	subw	a4,a4,s3
 8b8:	c518                	sw	a4,8(a0)
        p += p->s.size;
 8ba:	1702                	slli	a4,a4,0x20
 8bc:	9301                	srli	a4,a4,0x20
 8be:	0712                	slli	a4,a4,0x4
 8c0:	953a                	add	a0,a0,a4
        p->s.size = nunits;
 8c2:	01352423          	sw	s3,8(a0)
      freep = prevp;
 8c6:	00000717          	auipc	a4,0x0
 8ca:	0af73923          	sd	a5,178(a4) # 978 <freep>
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8ce:	70e2                	ld	ra,56(sp)
 8d0:	7442                	ld	s0,48(sp)
 8d2:	74a2                	ld	s1,40(sp)
 8d4:	7902                	ld	s2,32(sp)
 8d6:	69e2                	ld	s3,24(sp)
 8d8:	6a42                	ld	s4,16(sp)
 8da:	6aa2                	ld	s5,8(sp)
 8dc:	6b02                	ld	s6,0(sp)
 8de:	6121                	addi	sp,sp,64
 8e0:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 8e2:	6118                	ld	a4,0(a0)
 8e4:	e398                	sd	a4,0(a5)
 8e6:	b7c5                	j	8c6 <malloc+0x86>
  hp->s.size = nu;
 8e8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8ec:	0541                	addi	a0,a0,16
 8ee:	00000097          	auipc	ra,0x0
 8f2:	eca080e7          	jalr	-310(ra) # 7b8 <free>
  return freep;
 8f6:	00093783          	ld	a5,0(s2)
      if((p = morecore(nunits)) == 0)
 8fa:	c39d                	beqz	a5,920 <malloc+0xe0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8fc:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
 8fe:	4518                	lw	a4,8(a0)
 900:	fa9778e3          	bgeu	a4,s1,8b0 <malloc+0x70>
    if(p == freep)
 904:	00093703          	ld	a4,0(s2)
 908:	87aa                	mv	a5,a0
 90a:	fea719e3          	bne	a4,a0,8fc <malloc+0xbc>
  p = sbrk(nu * sizeof(Header));
 90e:	8552                	mv	a0,s4
 910:	00000097          	auipc	ra,0x0
 914:	b56080e7          	jalr	-1194(ra) # 466 <sbrk>
  if(p == (char*)-1)
 918:	fd5518e3          	bne	a0,s5,8e8 <malloc+0xa8>
        return 0;
 91c:	4501                	li	a0,0
 91e:	bf45                	j	8ce <malloc+0x8e>
 920:	853e                	mv	a0,a5
 922:	b775                	j	8ce <malloc+0x8e>
