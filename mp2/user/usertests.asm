
user/_usertests:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <copyinstr1>:
}

// what if you pass ridiculous string pointers to system calls?
void
copyinstr1(char *s)
{
       0:	1141                	addi	sp,sp,-16
       2:	e406                	sd	ra,8(sp)
       4:	e022                	sd	s0,0(sp)
       6:	0800                	addi	s0,sp,16
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };

  for(int ai = 0; ai < 2; ai++){
    uint64 addr = addrs[ai];

    int fd = open((char *)addr, O_CREATE|O_WRONLY);
       8:	20100593          	li	a1,513
       c:	4505                	li	a0,1
       e:	057e                	slli	a0,a0,0x1f
      10:	00006097          	auipc	ra,0x6
      14:	898080e7          	jalr	-1896(ra) # 58a8 <open>
    if(fd >= 0){
      18:	02055063          	bgez	a0,38 <copyinstr1+0x38>
    int fd = open((char *)addr, O_CREATE|O_WRONLY);
      1c:	20100593          	li	a1,513
      20:	557d                	li	a0,-1
      22:	00006097          	auipc	ra,0x6
      26:	886080e7          	jalr	-1914(ra) # 58a8 <open>
    uint64 addr = addrs[ai];
      2a:	55fd                	li	a1,-1
    if(fd >= 0){
      2c:	00055863          	bgez	a0,3c <copyinstr1+0x3c>
      printf("open(%p) returned %d, not -1\n", addr, fd);
      exit(1);
    }
  }
}
      30:	60a2                	ld	ra,8(sp)
      32:	6402                	ld	s0,0(sp)
      34:	0141                	addi	sp,sp,16
      36:	8082                	ret
    uint64 addr = addrs[ai];
      38:	4585                	li	a1,1
      3a:	05fe                	slli	a1,a1,0x1f
      printf("open(%p) returned %d, not -1\n", addr, fd);
      3c:	862a                	mv	a2,a0
      3e:	00006517          	auipc	a0,0x6
      42:	0d250513          	addi	a0,a0,210 # 6110 <malloc+0x446>
      46:	00006097          	auipc	ra,0x6
      4a:	bc6080e7          	jalr	-1082(ra) # 5c0c <printf>
      exit(1);
      4e:	4505                	li	a0,1
      50:	00006097          	auipc	ra,0x6
      54:	818080e7          	jalr	-2024(ra) # 5868 <exit>

0000000000000058 <bsstest>:
void
bsstest(char *s)
{
  int i;

  for(i = 0; i < sizeof(uninit); i++){
      58:	00009797          	auipc	a5,0x9
      5c:	66878793          	addi	a5,a5,1640 # 96c0 <uninit>
      60:	0000c697          	auipc	a3,0xc
      64:	d7068693          	addi	a3,a3,-656 # bdd0 <buf>
    if(uninit[i] != '\0'){
      68:	0007c703          	lbu	a4,0(a5)
      6c:	e709                	bnez	a4,76 <bsstest+0x1e>
  for(i = 0; i < sizeof(uninit); i++){
      6e:	0785                	addi	a5,a5,1
      70:	fed79ce3          	bne	a5,a3,68 <bsstest+0x10>
      74:	8082                	ret
{
      76:	1141                	addi	sp,sp,-16
      78:	e406                	sd	ra,8(sp)
      7a:	e022                	sd	s0,0(sp)
      7c:	0800                	addi	s0,sp,16
      printf("%s: bss test failed\n", s);
      7e:	85aa                	mv	a1,a0
      80:	00006517          	auipc	a0,0x6
      84:	0b050513          	addi	a0,a0,176 # 6130 <malloc+0x466>
      88:	00006097          	auipc	ra,0x6
      8c:	b84080e7          	jalr	-1148(ra) # 5c0c <printf>
      exit(1);
      90:	4505                	li	a0,1
      92:	00005097          	auipc	ra,0x5
      96:	7d6080e7          	jalr	2006(ra) # 5868 <exit>

000000000000009a <opentest>:
{
      9a:	1101                	addi	sp,sp,-32
      9c:	ec06                	sd	ra,24(sp)
      9e:	e822                	sd	s0,16(sp)
      a0:	e426                	sd	s1,8(sp)
      a2:	1000                	addi	s0,sp,32
      a4:	84aa                	mv	s1,a0
  fd = open("echo", 0);
      a6:	4581                	li	a1,0
      a8:	00006517          	auipc	a0,0x6
      ac:	0a050513          	addi	a0,a0,160 # 6148 <malloc+0x47e>
      b0:	00005097          	auipc	ra,0x5
      b4:	7f8080e7          	jalr	2040(ra) # 58a8 <open>
  if(fd < 0){
      b8:	02054663          	bltz	a0,e4 <opentest+0x4a>
  close(fd);
      bc:	00005097          	auipc	ra,0x5
      c0:	7d4080e7          	jalr	2004(ra) # 5890 <close>
  fd = open("doesnotexist", 0);
      c4:	4581                	li	a1,0
      c6:	00006517          	auipc	a0,0x6
      ca:	0a250513          	addi	a0,a0,162 # 6168 <malloc+0x49e>
      ce:	00005097          	auipc	ra,0x5
      d2:	7da080e7          	jalr	2010(ra) # 58a8 <open>
  if(fd >= 0){
      d6:	02055563          	bgez	a0,100 <opentest+0x66>
}
      da:	60e2                	ld	ra,24(sp)
      dc:	6442                	ld	s0,16(sp)
      de:	64a2                	ld	s1,8(sp)
      e0:	6105                	addi	sp,sp,32
      e2:	8082                	ret
    printf("%s: open echo failed!\n", s);
      e4:	85a6                	mv	a1,s1
      e6:	00006517          	auipc	a0,0x6
      ea:	06a50513          	addi	a0,a0,106 # 6150 <malloc+0x486>
      ee:	00006097          	auipc	ra,0x6
      f2:	b1e080e7          	jalr	-1250(ra) # 5c0c <printf>
    exit(1);
      f6:	4505                	li	a0,1
      f8:	00005097          	auipc	ra,0x5
      fc:	770080e7          	jalr	1904(ra) # 5868 <exit>
    printf("%s: open doesnotexist succeeded!\n", s);
     100:	85a6                	mv	a1,s1
     102:	00006517          	auipc	a0,0x6
     106:	07650513          	addi	a0,a0,118 # 6178 <malloc+0x4ae>
     10a:	00006097          	auipc	ra,0x6
     10e:	b02080e7          	jalr	-1278(ra) # 5c0c <printf>
    exit(1);
     112:	4505                	li	a0,1
     114:	00005097          	auipc	ra,0x5
     118:	754080e7          	jalr	1876(ra) # 5868 <exit>

000000000000011c <truncate2>:
{
     11c:	7179                	addi	sp,sp,-48
     11e:	f406                	sd	ra,40(sp)
     120:	f022                	sd	s0,32(sp)
     122:	ec26                	sd	s1,24(sp)
     124:	e84a                	sd	s2,16(sp)
     126:	e44e                	sd	s3,8(sp)
     128:	1800                	addi	s0,sp,48
     12a:	89aa                	mv	s3,a0
  unlink("truncfile");
     12c:	00006517          	auipc	a0,0x6
     130:	07450513          	addi	a0,a0,116 # 61a0 <malloc+0x4d6>
     134:	00005097          	auipc	ra,0x5
     138:	784080e7          	jalr	1924(ra) # 58b8 <unlink>
  int fd1 = open("truncfile", O_CREATE|O_TRUNC|O_WRONLY);
     13c:	60100593          	li	a1,1537
     140:	00006517          	auipc	a0,0x6
     144:	06050513          	addi	a0,a0,96 # 61a0 <malloc+0x4d6>
     148:	00005097          	auipc	ra,0x5
     14c:	760080e7          	jalr	1888(ra) # 58a8 <open>
     150:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     152:	4611                	li	a2,4
     154:	00006597          	auipc	a1,0x6
     158:	05c58593          	addi	a1,a1,92 # 61b0 <malloc+0x4e6>
     15c:	00005097          	auipc	ra,0x5
     160:	72c080e7          	jalr	1836(ra) # 5888 <write>
  int fd2 = open("truncfile", O_TRUNC|O_WRONLY);
     164:	40100593          	li	a1,1025
     168:	00006517          	auipc	a0,0x6
     16c:	03850513          	addi	a0,a0,56 # 61a0 <malloc+0x4d6>
     170:	00005097          	auipc	ra,0x5
     174:	738080e7          	jalr	1848(ra) # 58a8 <open>
     178:	892a                	mv	s2,a0
  int n = write(fd1, "x", 1);
     17a:	4605                	li	a2,1
     17c:	00006597          	auipc	a1,0x6
     180:	03c58593          	addi	a1,a1,60 # 61b8 <malloc+0x4ee>
     184:	8526                	mv	a0,s1
     186:	00005097          	auipc	ra,0x5
     18a:	702080e7          	jalr	1794(ra) # 5888 <write>
  if(n != -1){
     18e:	57fd                	li	a5,-1
     190:	02f51b63          	bne	a0,a5,1c6 <truncate2+0xaa>
  unlink("truncfile");
     194:	00006517          	auipc	a0,0x6
     198:	00c50513          	addi	a0,a0,12 # 61a0 <malloc+0x4d6>
     19c:	00005097          	auipc	ra,0x5
     1a0:	71c080e7          	jalr	1820(ra) # 58b8 <unlink>
  close(fd1);
     1a4:	8526                	mv	a0,s1
     1a6:	00005097          	auipc	ra,0x5
     1aa:	6ea080e7          	jalr	1770(ra) # 5890 <close>
  close(fd2);
     1ae:	854a                	mv	a0,s2
     1b0:	00005097          	auipc	ra,0x5
     1b4:	6e0080e7          	jalr	1760(ra) # 5890 <close>
}
     1b8:	70a2                	ld	ra,40(sp)
     1ba:	7402                	ld	s0,32(sp)
     1bc:	64e2                	ld	s1,24(sp)
     1be:	6942                	ld	s2,16(sp)
     1c0:	69a2                	ld	s3,8(sp)
     1c2:	6145                	addi	sp,sp,48
     1c4:	8082                	ret
    printf("%s: write returned %d, expected -1\n", s, n);
     1c6:	862a                	mv	a2,a0
     1c8:	85ce                	mv	a1,s3
     1ca:	00006517          	auipc	a0,0x6
     1ce:	ff650513          	addi	a0,a0,-10 # 61c0 <malloc+0x4f6>
     1d2:	00006097          	auipc	ra,0x6
     1d6:	a3a080e7          	jalr	-1478(ra) # 5c0c <printf>
    exit(1);
     1da:	4505                	li	a0,1
     1dc:	00005097          	auipc	ra,0x5
     1e0:	68c080e7          	jalr	1676(ra) # 5868 <exit>

00000000000001e4 <createtest>:
{
     1e4:	7179                	addi	sp,sp,-48
     1e6:	f406                	sd	ra,40(sp)
     1e8:	f022                	sd	s0,32(sp)
     1ea:	ec26                	sd	s1,24(sp)
     1ec:	e84a                	sd	s2,16(sp)
     1ee:	1800                	addi	s0,sp,48
  name[0] = 'a';
     1f0:	06100793          	li	a5,97
     1f4:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     1f8:	fc040d23          	sb	zero,-38(s0)
     1fc:	03000493          	li	s1,48
  for(i = 0; i < N; i++){
     200:	06400913          	li	s2,100
    name[1] = '0' + i;
     204:	fc940ca3          	sb	s1,-39(s0)
    fd = open(name, O_CREATE|O_RDWR);
     208:	20200593          	li	a1,514
     20c:	fd840513          	addi	a0,s0,-40
     210:	00005097          	auipc	ra,0x5
     214:	698080e7          	jalr	1688(ra) # 58a8 <open>
    close(fd);
     218:	00005097          	auipc	ra,0x5
     21c:	678080e7          	jalr	1656(ra) # 5890 <close>
  for(i = 0; i < N; i++){
     220:	2485                	addiw	s1,s1,1
     222:	0ff4f493          	andi	s1,s1,255
     226:	fd249fe3          	bne	s1,s2,204 <createtest+0x20>
  name[0] = 'a';
     22a:	06100793          	li	a5,97
     22e:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     232:	fc040d23          	sb	zero,-38(s0)
     236:	03000493          	li	s1,48
  for(i = 0; i < N; i++){
     23a:	06400913          	li	s2,100
    name[1] = '0' + i;
     23e:	fc940ca3          	sb	s1,-39(s0)
    unlink(name);
     242:	fd840513          	addi	a0,s0,-40
     246:	00005097          	auipc	ra,0x5
     24a:	672080e7          	jalr	1650(ra) # 58b8 <unlink>
  for(i = 0; i < N; i++){
     24e:	2485                	addiw	s1,s1,1
     250:	0ff4f493          	andi	s1,s1,255
     254:	ff2495e3          	bne	s1,s2,23e <createtest+0x5a>
}
     258:	70a2                	ld	ra,40(sp)
     25a:	7402                	ld	s0,32(sp)
     25c:	64e2                	ld	s1,24(sp)
     25e:	6942                	ld	s2,16(sp)
     260:	6145                	addi	sp,sp,48
     262:	8082                	ret

0000000000000264 <bigwrite>:
{
     264:	715d                	addi	sp,sp,-80
     266:	e486                	sd	ra,72(sp)
     268:	e0a2                	sd	s0,64(sp)
     26a:	fc26                	sd	s1,56(sp)
     26c:	f84a                	sd	s2,48(sp)
     26e:	f44e                	sd	s3,40(sp)
     270:	f052                	sd	s4,32(sp)
     272:	ec56                	sd	s5,24(sp)
     274:	e85a                	sd	s6,16(sp)
     276:	e45e                	sd	s7,8(sp)
     278:	0880                	addi	s0,sp,80
     27a:	8baa                	mv	s7,a0
  unlink("bigwrite");
     27c:	00006517          	auipc	a0,0x6
     280:	d1450513          	addi	a0,a0,-748 # 5f90 <malloc+0x2c6>
     284:	00005097          	auipc	ra,0x5
     288:	634080e7          	jalr	1588(ra) # 58b8 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     28c:	1f300493          	li	s1,499
    fd = open("bigwrite", O_CREATE | O_RDWR);
     290:	00006a97          	auipc	s5,0x6
     294:	d00a8a93          	addi	s5,s5,-768 # 5f90 <malloc+0x2c6>
      int cc = write(fd, buf, sz);
     298:	0000ca17          	auipc	s4,0xc
     29c:	b38a0a13          	addi	s4,s4,-1224 # bdd0 <buf>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     2a0:	6b0d                	lui	s6,0x3
     2a2:	1c9b0b13          	addi	s6,s6,457 # 31c9 <dirtest+0x8f>
    fd = open("bigwrite", O_CREATE | O_RDWR);
     2a6:	20200593          	li	a1,514
     2aa:	8556                	mv	a0,s5
     2ac:	00005097          	auipc	ra,0x5
     2b0:	5fc080e7          	jalr	1532(ra) # 58a8 <open>
     2b4:	892a                	mv	s2,a0
    if(fd < 0){
     2b6:	04054d63          	bltz	a0,310 <bigwrite+0xac>
      int cc = write(fd, buf, sz);
     2ba:	8626                	mv	a2,s1
     2bc:	85d2                	mv	a1,s4
     2be:	00005097          	auipc	ra,0x5
     2c2:	5ca080e7          	jalr	1482(ra) # 5888 <write>
     2c6:	89aa                	mv	s3,a0
      if(cc != sz){
     2c8:	06a49463          	bne	s1,a0,330 <bigwrite+0xcc>
      int cc = write(fd, buf, sz);
     2cc:	8626                	mv	a2,s1
     2ce:	85d2                	mv	a1,s4
     2d0:	854a                	mv	a0,s2
     2d2:	00005097          	auipc	ra,0x5
     2d6:	5b6080e7          	jalr	1462(ra) # 5888 <write>
      if(cc != sz){
     2da:	04951963          	bne	a0,s1,32c <bigwrite+0xc8>
    close(fd);
     2de:	854a                	mv	a0,s2
     2e0:	00005097          	auipc	ra,0x5
     2e4:	5b0080e7          	jalr	1456(ra) # 5890 <close>
    unlink("bigwrite");
     2e8:	8556                	mv	a0,s5
     2ea:	00005097          	auipc	ra,0x5
     2ee:	5ce080e7          	jalr	1486(ra) # 58b8 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     2f2:	1d74849b          	addiw	s1,s1,471
     2f6:	fb6498e3          	bne	s1,s6,2a6 <bigwrite+0x42>
}
     2fa:	60a6                	ld	ra,72(sp)
     2fc:	6406                	ld	s0,64(sp)
     2fe:	74e2                	ld	s1,56(sp)
     300:	7942                	ld	s2,48(sp)
     302:	79a2                	ld	s3,40(sp)
     304:	7a02                	ld	s4,32(sp)
     306:	6ae2                	ld	s5,24(sp)
     308:	6b42                	ld	s6,16(sp)
     30a:	6ba2                	ld	s7,8(sp)
     30c:	6161                	addi	sp,sp,80
     30e:	8082                	ret
      printf("%s: cannot create bigwrite\n", s);
     310:	85de                	mv	a1,s7
     312:	00006517          	auipc	a0,0x6
     316:	ed650513          	addi	a0,a0,-298 # 61e8 <malloc+0x51e>
     31a:	00006097          	auipc	ra,0x6
     31e:	8f2080e7          	jalr	-1806(ra) # 5c0c <printf>
      exit(1);
     322:	4505                	li	a0,1
     324:	00005097          	auipc	ra,0x5
     328:	544080e7          	jalr	1348(ra) # 5868 <exit>
     32c:	84ce                	mv	s1,s3
      int cc = write(fd, buf, sz);
     32e:	89aa                	mv	s3,a0
        printf("%s: write(%d) ret %d\n", s, sz, cc);
     330:	86ce                	mv	a3,s3
     332:	8626                	mv	a2,s1
     334:	85de                	mv	a1,s7
     336:	00006517          	auipc	a0,0x6
     33a:	ed250513          	addi	a0,a0,-302 # 6208 <malloc+0x53e>
     33e:	00006097          	auipc	ra,0x6
     342:	8ce080e7          	jalr	-1842(ra) # 5c0c <printf>
        exit(1);
     346:	4505                	li	a0,1
     348:	00005097          	auipc	ra,0x5
     34c:	520080e7          	jalr	1312(ra) # 5868 <exit>

0000000000000350 <copyin>:
{
     350:	715d                	addi	sp,sp,-80
     352:	e486                	sd	ra,72(sp)
     354:	e0a2                	sd	s0,64(sp)
     356:	fc26                	sd	s1,56(sp)
     358:	f84a                	sd	s2,48(sp)
     35a:	f44e                	sd	s3,40(sp)
     35c:	f052                	sd	s4,32(sp)
     35e:	0880                	addi	s0,sp,80
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     360:	4785                	li	a5,1
     362:	07fe                	slli	a5,a5,0x1f
     364:	fcf43023          	sd	a5,-64(s0)
     368:	57fd                	li	a5,-1
     36a:	fcf43423          	sd	a5,-56(s0)
  for(int ai = 0; ai < 2; ai++){
     36e:	fc040913          	addi	s2,s0,-64
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     372:	00006a17          	auipc	s4,0x6
     376:	eaea0a13          	addi	s4,s4,-338 # 6220 <malloc+0x556>
    uint64 addr = addrs[ai];
     37a:	00093983          	ld	s3,0(s2)
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     37e:	20100593          	li	a1,513
     382:	8552                	mv	a0,s4
     384:	00005097          	auipc	ra,0x5
     388:	524080e7          	jalr	1316(ra) # 58a8 <open>
     38c:	84aa                	mv	s1,a0
    if(fd < 0){
     38e:	08054863          	bltz	a0,41e <copyin+0xce>
    int n = write(fd, (void*)addr, 8192);
     392:	6609                	lui	a2,0x2
     394:	85ce                	mv	a1,s3
     396:	00005097          	auipc	ra,0x5
     39a:	4f2080e7          	jalr	1266(ra) # 5888 <write>
    if(n >= 0){
     39e:	08055d63          	bgez	a0,438 <copyin+0xe8>
    close(fd);
     3a2:	8526                	mv	a0,s1
     3a4:	00005097          	auipc	ra,0x5
     3a8:	4ec080e7          	jalr	1260(ra) # 5890 <close>
    unlink("copyin1");
     3ac:	8552                	mv	a0,s4
     3ae:	00005097          	auipc	ra,0x5
     3b2:	50a080e7          	jalr	1290(ra) # 58b8 <unlink>
    n = write(1, (char*)addr, 8192);
     3b6:	6609                	lui	a2,0x2
     3b8:	85ce                	mv	a1,s3
     3ba:	4505                	li	a0,1
     3bc:	00005097          	auipc	ra,0x5
     3c0:	4cc080e7          	jalr	1228(ra) # 5888 <write>
    if(n > 0){
     3c4:	08a04963          	bgtz	a0,456 <copyin+0x106>
    if(pipe(fds) < 0){
     3c8:	fb840513          	addi	a0,s0,-72
     3cc:	00005097          	auipc	ra,0x5
     3d0:	4ac080e7          	jalr	1196(ra) # 5878 <pipe>
     3d4:	0a054063          	bltz	a0,474 <copyin+0x124>
    n = write(fds[1], (char*)addr, 8192);
     3d8:	6609                	lui	a2,0x2
     3da:	85ce                	mv	a1,s3
     3dc:	fbc42503          	lw	a0,-68(s0)
     3e0:	00005097          	auipc	ra,0x5
     3e4:	4a8080e7          	jalr	1192(ra) # 5888 <write>
    if(n > 0){
     3e8:	0aa04363          	bgtz	a0,48e <copyin+0x13e>
    close(fds[0]);
     3ec:	fb842503          	lw	a0,-72(s0)
     3f0:	00005097          	auipc	ra,0x5
     3f4:	4a0080e7          	jalr	1184(ra) # 5890 <close>
    close(fds[1]);
     3f8:	fbc42503          	lw	a0,-68(s0)
     3fc:	00005097          	auipc	ra,0x5
     400:	494080e7          	jalr	1172(ra) # 5890 <close>
  for(int ai = 0; ai < 2; ai++){
     404:	0921                	addi	s2,s2,8
     406:	fd040793          	addi	a5,s0,-48
     40a:	f6f918e3          	bne	s2,a5,37a <copyin+0x2a>
}
     40e:	60a6                	ld	ra,72(sp)
     410:	6406                	ld	s0,64(sp)
     412:	74e2                	ld	s1,56(sp)
     414:	7942                	ld	s2,48(sp)
     416:	79a2                	ld	s3,40(sp)
     418:	7a02                	ld	s4,32(sp)
     41a:	6161                	addi	sp,sp,80
     41c:	8082                	ret
      printf("open(copyin1) failed\n");
     41e:	00006517          	auipc	a0,0x6
     422:	e0a50513          	addi	a0,a0,-502 # 6228 <malloc+0x55e>
     426:	00005097          	auipc	ra,0x5
     42a:	7e6080e7          	jalr	2022(ra) # 5c0c <printf>
      exit(1);
     42e:	4505                	li	a0,1
     430:	00005097          	auipc	ra,0x5
     434:	438080e7          	jalr	1080(ra) # 5868 <exit>
      printf("write(fd, %p, 8192) returned %d, not -1\n", addr, n);
     438:	862a                	mv	a2,a0
     43a:	85ce                	mv	a1,s3
     43c:	00006517          	auipc	a0,0x6
     440:	e0450513          	addi	a0,a0,-508 # 6240 <malloc+0x576>
     444:	00005097          	auipc	ra,0x5
     448:	7c8080e7          	jalr	1992(ra) # 5c0c <printf>
      exit(1);
     44c:	4505                	li	a0,1
     44e:	00005097          	auipc	ra,0x5
     452:	41a080e7          	jalr	1050(ra) # 5868 <exit>
      printf("write(1, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     456:	862a                	mv	a2,a0
     458:	85ce                	mv	a1,s3
     45a:	00006517          	auipc	a0,0x6
     45e:	e1650513          	addi	a0,a0,-490 # 6270 <malloc+0x5a6>
     462:	00005097          	auipc	ra,0x5
     466:	7aa080e7          	jalr	1962(ra) # 5c0c <printf>
      exit(1);
     46a:	4505                	li	a0,1
     46c:	00005097          	auipc	ra,0x5
     470:	3fc080e7          	jalr	1020(ra) # 5868 <exit>
      printf("pipe() failed\n");
     474:	00006517          	auipc	a0,0x6
     478:	e2c50513          	addi	a0,a0,-468 # 62a0 <malloc+0x5d6>
     47c:	00005097          	auipc	ra,0x5
     480:	790080e7          	jalr	1936(ra) # 5c0c <printf>
      exit(1);
     484:	4505                	li	a0,1
     486:	00005097          	auipc	ra,0x5
     48a:	3e2080e7          	jalr	994(ra) # 5868 <exit>
      printf("write(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     48e:	862a                	mv	a2,a0
     490:	85ce                	mv	a1,s3
     492:	00006517          	auipc	a0,0x6
     496:	e1e50513          	addi	a0,a0,-482 # 62b0 <malloc+0x5e6>
     49a:	00005097          	auipc	ra,0x5
     49e:	772080e7          	jalr	1906(ra) # 5c0c <printf>
      exit(1);
     4a2:	4505                	li	a0,1
     4a4:	00005097          	auipc	ra,0x5
     4a8:	3c4080e7          	jalr	964(ra) # 5868 <exit>

00000000000004ac <copyout>:
{
     4ac:	711d                	addi	sp,sp,-96
     4ae:	ec86                	sd	ra,88(sp)
     4b0:	e8a2                	sd	s0,80(sp)
     4b2:	e4a6                	sd	s1,72(sp)
     4b4:	e0ca                	sd	s2,64(sp)
     4b6:	fc4e                	sd	s3,56(sp)
     4b8:	f852                	sd	s4,48(sp)
     4ba:	f456                	sd	s5,40(sp)
     4bc:	1080                	addi	s0,sp,96
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     4be:	4785                	li	a5,1
     4c0:	07fe                	slli	a5,a5,0x1f
     4c2:	faf43823          	sd	a5,-80(s0)
     4c6:	57fd                	li	a5,-1
     4c8:	faf43c23          	sd	a5,-72(s0)
  for(int ai = 0; ai < 2; ai++){
     4cc:	fb040913          	addi	s2,s0,-80
    int fd = open("README", 0);
     4d0:	00006a17          	auipc	s4,0x6
     4d4:	e10a0a13          	addi	s4,s4,-496 # 62e0 <malloc+0x616>
    n = write(fds[1], "x", 1);
     4d8:	00006a97          	auipc	s5,0x6
     4dc:	ce0a8a93          	addi	s5,s5,-800 # 61b8 <malloc+0x4ee>
    uint64 addr = addrs[ai];
     4e0:	00093983          	ld	s3,0(s2)
    int fd = open("README", 0);
     4e4:	4581                	li	a1,0
     4e6:	8552                	mv	a0,s4
     4e8:	00005097          	auipc	ra,0x5
     4ec:	3c0080e7          	jalr	960(ra) # 58a8 <open>
     4f0:	84aa                	mv	s1,a0
    if(fd < 0){
     4f2:	08054663          	bltz	a0,57e <copyout+0xd2>
    int n = read(fd, (void*)addr, 8192);
     4f6:	6609                	lui	a2,0x2
     4f8:	85ce                	mv	a1,s3
     4fa:	00005097          	auipc	ra,0x5
     4fe:	386080e7          	jalr	902(ra) # 5880 <read>
    if(n > 0){
     502:	08a04b63          	bgtz	a0,598 <copyout+0xec>
    close(fd);
     506:	8526                	mv	a0,s1
     508:	00005097          	auipc	ra,0x5
     50c:	388080e7          	jalr	904(ra) # 5890 <close>
    if(pipe(fds) < 0){
     510:	fa840513          	addi	a0,s0,-88
     514:	00005097          	auipc	ra,0x5
     518:	364080e7          	jalr	868(ra) # 5878 <pipe>
     51c:	08054d63          	bltz	a0,5b6 <copyout+0x10a>
    n = write(fds[1], "x", 1);
     520:	4605                	li	a2,1
     522:	85d6                	mv	a1,s5
     524:	fac42503          	lw	a0,-84(s0)
     528:	00005097          	auipc	ra,0x5
     52c:	360080e7          	jalr	864(ra) # 5888 <write>
    if(n != 1){
     530:	4785                	li	a5,1
     532:	08f51f63          	bne	a0,a5,5d0 <copyout+0x124>
    n = read(fds[0], (void*)addr, 8192);
     536:	6609                	lui	a2,0x2
     538:	85ce                	mv	a1,s3
     53a:	fa842503          	lw	a0,-88(s0)
     53e:	00005097          	auipc	ra,0x5
     542:	342080e7          	jalr	834(ra) # 5880 <read>
    if(n > 0){
     546:	0aa04263          	bgtz	a0,5ea <copyout+0x13e>
    close(fds[0]);
     54a:	fa842503          	lw	a0,-88(s0)
     54e:	00005097          	auipc	ra,0x5
     552:	342080e7          	jalr	834(ra) # 5890 <close>
    close(fds[1]);
     556:	fac42503          	lw	a0,-84(s0)
     55a:	00005097          	auipc	ra,0x5
     55e:	336080e7          	jalr	822(ra) # 5890 <close>
  for(int ai = 0; ai < 2; ai++){
     562:	0921                	addi	s2,s2,8
     564:	fc040793          	addi	a5,s0,-64
     568:	f6f91ce3          	bne	s2,a5,4e0 <copyout+0x34>
}
     56c:	60e6                	ld	ra,88(sp)
     56e:	6446                	ld	s0,80(sp)
     570:	64a6                	ld	s1,72(sp)
     572:	6906                	ld	s2,64(sp)
     574:	79e2                	ld	s3,56(sp)
     576:	7a42                	ld	s4,48(sp)
     578:	7aa2                	ld	s5,40(sp)
     57a:	6125                	addi	sp,sp,96
     57c:	8082                	ret
      printf("open(README) failed\n");
     57e:	00006517          	auipc	a0,0x6
     582:	d6a50513          	addi	a0,a0,-662 # 62e8 <malloc+0x61e>
     586:	00005097          	auipc	ra,0x5
     58a:	686080e7          	jalr	1670(ra) # 5c0c <printf>
      exit(1);
     58e:	4505                	li	a0,1
     590:	00005097          	auipc	ra,0x5
     594:	2d8080e7          	jalr	728(ra) # 5868 <exit>
      printf("read(fd, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     598:	862a                	mv	a2,a0
     59a:	85ce                	mv	a1,s3
     59c:	00006517          	auipc	a0,0x6
     5a0:	d6450513          	addi	a0,a0,-668 # 6300 <malloc+0x636>
     5a4:	00005097          	auipc	ra,0x5
     5a8:	668080e7          	jalr	1640(ra) # 5c0c <printf>
      exit(1);
     5ac:	4505                	li	a0,1
     5ae:	00005097          	auipc	ra,0x5
     5b2:	2ba080e7          	jalr	698(ra) # 5868 <exit>
      printf("pipe() failed\n");
     5b6:	00006517          	auipc	a0,0x6
     5ba:	cea50513          	addi	a0,a0,-790 # 62a0 <malloc+0x5d6>
     5be:	00005097          	auipc	ra,0x5
     5c2:	64e080e7          	jalr	1614(ra) # 5c0c <printf>
      exit(1);
     5c6:	4505                	li	a0,1
     5c8:	00005097          	auipc	ra,0x5
     5cc:	2a0080e7          	jalr	672(ra) # 5868 <exit>
      printf("pipe write failed\n");
     5d0:	00006517          	auipc	a0,0x6
     5d4:	d6050513          	addi	a0,a0,-672 # 6330 <malloc+0x666>
     5d8:	00005097          	auipc	ra,0x5
     5dc:	634080e7          	jalr	1588(ra) # 5c0c <printf>
      exit(1);
     5e0:	4505                	li	a0,1
     5e2:	00005097          	auipc	ra,0x5
     5e6:	286080e7          	jalr	646(ra) # 5868 <exit>
      printf("read(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     5ea:	862a                	mv	a2,a0
     5ec:	85ce                	mv	a1,s3
     5ee:	00006517          	auipc	a0,0x6
     5f2:	d5a50513          	addi	a0,a0,-678 # 6348 <malloc+0x67e>
     5f6:	00005097          	auipc	ra,0x5
     5fa:	616080e7          	jalr	1558(ra) # 5c0c <printf>
      exit(1);
     5fe:	4505                	li	a0,1
     600:	00005097          	auipc	ra,0x5
     604:	268080e7          	jalr	616(ra) # 5868 <exit>

0000000000000608 <truncate1>:
{
     608:	711d                	addi	sp,sp,-96
     60a:	ec86                	sd	ra,88(sp)
     60c:	e8a2                	sd	s0,80(sp)
     60e:	e4a6                	sd	s1,72(sp)
     610:	e0ca                	sd	s2,64(sp)
     612:	fc4e                	sd	s3,56(sp)
     614:	f852                	sd	s4,48(sp)
     616:	f456                	sd	s5,40(sp)
     618:	1080                	addi	s0,sp,96
     61a:	8aaa                	mv	s5,a0
  unlink("truncfile");
     61c:	00006517          	auipc	a0,0x6
     620:	b8450513          	addi	a0,a0,-1148 # 61a0 <malloc+0x4d6>
     624:	00005097          	auipc	ra,0x5
     628:	294080e7          	jalr	660(ra) # 58b8 <unlink>
  int fd1 = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
     62c:	60100593          	li	a1,1537
     630:	00006517          	auipc	a0,0x6
     634:	b7050513          	addi	a0,a0,-1168 # 61a0 <malloc+0x4d6>
     638:	00005097          	auipc	ra,0x5
     63c:	270080e7          	jalr	624(ra) # 58a8 <open>
     640:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     642:	4611                	li	a2,4
     644:	00006597          	auipc	a1,0x6
     648:	b6c58593          	addi	a1,a1,-1172 # 61b0 <malloc+0x4e6>
     64c:	00005097          	auipc	ra,0x5
     650:	23c080e7          	jalr	572(ra) # 5888 <write>
  close(fd1);
     654:	8526                	mv	a0,s1
     656:	00005097          	auipc	ra,0x5
     65a:	23a080e7          	jalr	570(ra) # 5890 <close>
  int fd2 = open("truncfile", O_RDONLY);
     65e:	4581                	li	a1,0
     660:	00006517          	auipc	a0,0x6
     664:	b4050513          	addi	a0,a0,-1216 # 61a0 <malloc+0x4d6>
     668:	00005097          	auipc	ra,0x5
     66c:	240080e7          	jalr	576(ra) # 58a8 <open>
     670:	84aa                	mv	s1,a0
  int n = read(fd2, buf, sizeof(buf));
     672:	02000613          	li	a2,32
     676:	fa040593          	addi	a1,s0,-96
     67a:	00005097          	auipc	ra,0x5
     67e:	206080e7          	jalr	518(ra) # 5880 <read>
  if(n != 4){
     682:	4791                	li	a5,4
     684:	0cf51e63          	bne	a0,a5,760 <truncate1+0x158>
  fd1 = open("truncfile", O_WRONLY|O_TRUNC);
     688:	40100593          	li	a1,1025
     68c:	00006517          	auipc	a0,0x6
     690:	b1450513          	addi	a0,a0,-1260 # 61a0 <malloc+0x4d6>
     694:	00005097          	auipc	ra,0x5
     698:	214080e7          	jalr	532(ra) # 58a8 <open>
     69c:	89aa                	mv	s3,a0
  int fd3 = open("truncfile", O_RDONLY);
     69e:	4581                	li	a1,0
     6a0:	00006517          	auipc	a0,0x6
     6a4:	b0050513          	addi	a0,a0,-1280 # 61a0 <malloc+0x4d6>
     6a8:	00005097          	auipc	ra,0x5
     6ac:	200080e7          	jalr	512(ra) # 58a8 <open>
     6b0:	892a                	mv	s2,a0
  n = read(fd3, buf, sizeof(buf));
     6b2:	02000613          	li	a2,32
     6b6:	fa040593          	addi	a1,s0,-96
     6ba:	00005097          	auipc	ra,0x5
     6be:	1c6080e7          	jalr	454(ra) # 5880 <read>
     6c2:	8a2a                	mv	s4,a0
  if(n != 0){
     6c4:	ed4d                	bnez	a0,77e <truncate1+0x176>
  n = read(fd2, buf, sizeof(buf));
     6c6:	02000613          	li	a2,32
     6ca:	fa040593          	addi	a1,s0,-96
     6ce:	8526                	mv	a0,s1
     6d0:	00005097          	auipc	ra,0x5
     6d4:	1b0080e7          	jalr	432(ra) # 5880 <read>
     6d8:	8a2a                	mv	s4,a0
  if(n != 0){
     6da:	e971                	bnez	a0,7ae <truncate1+0x1a6>
  write(fd1, "abcdef", 6);
     6dc:	4619                	li	a2,6
     6de:	00006597          	auipc	a1,0x6
     6e2:	cfa58593          	addi	a1,a1,-774 # 63d8 <malloc+0x70e>
     6e6:	854e                	mv	a0,s3
     6e8:	00005097          	auipc	ra,0x5
     6ec:	1a0080e7          	jalr	416(ra) # 5888 <write>
  n = read(fd3, buf, sizeof(buf));
     6f0:	02000613          	li	a2,32
     6f4:	fa040593          	addi	a1,s0,-96
     6f8:	854a                	mv	a0,s2
     6fa:	00005097          	auipc	ra,0x5
     6fe:	186080e7          	jalr	390(ra) # 5880 <read>
  if(n != 6){
     702:	4799                	li	a5,6
     704:	0cf51d63          	bne	a0,a5,7de <truncate1+0x1d6>
  n = read(fd2, buf, sizeof(buf));
     708:	02000613          	li	a2,32
     70c:	fa040593          	addi	a1,s0,-96
     710:	8526                	mv	a0,s1
     712:	00005097          	auipc	ra,0x5
     716:	16e080e7          	jalr	366(ra) # 5880 <read>
  if(n != 2){
     71a:	4789                	li	a5,2
     71c:	0ef51063          	bne	a0,a5,7fc <truncate1+0x1f4>
  unlink("truncfile");
     720:	00006517          	auipc	a0,0x6
     724:	a8050513          	addi	a0,a0,-1408 # 61a0 <malloc+0x4d6>
     728:	00005097          	auipc	ra,0x5
     72c:	190080e7          	jalr	400(ra) # 58b8 <unlink>
  close(fd1);
     730:	854e                	mv	a0,s3
     732:	00005097          	auipc	ra,0x5
     736:	15e080e7          	jalr	350(ra) # 5890 <close>
  close(fd2);
     73a:	8526                	mv	a0,s1
     73c:	00005097          	auipc	ra,0x5
     740:	154080e7          	jalr	340(ra) # 5890 <close>
  close(fd3);
     744:	854a                	mv	a0,s2
     746:	00005097          	auipc	ra,0x5
     74a:	14a080e7          	jalr	330(ra) # 5890 <close>
}
     74e:	60e6                	ld	ra,88(sp)
     750:	6446                	ld	s0,80(sp)
     752:	64a6                	ld	s1,72(sp)
     754:	6906                	ld	s2,64(sp)
     756:	79e2                	ld	s3,56(sp)
     758:	7a42                	ld	s4,48(sp)
     75a:	7aa2                	ld	s5,40(sp)
     75c:	6125                	addi	sp,sp,96
     75e:	8082                	ret
    printf("%s: read %d bytes, wanted 4\n", s, n);
     760:	862a                	mv	a2,a0
     762:	85d6                	mv	a1,s5
     764:	00006517          	auipc	a0,0x6
     768:	c1450513          	addi	a0,a0,-1004 # 6378 <malloc+0x6ae>
     76c:	00005097          	auipc	ra,0x5
     770:	4a0080e7          	jalr	1184(ra) # 5c0c <printf>
    exit(1);
     774:	4505                	li	a0,1
     776:	00005097          	auipc	ra,0x5
     77a:	0f2080e7          	jalr	242(ra) # 5868 <exit>
    printf("aaa fd3=%d\n", fd3);
     77e:	85ca                	mv	a1,s2
     780:	00006517          	auipc	a0,0x6
     784:	c1850513          	addi	a0,a0,-1000 # 6398 <malloc+0x6ce>
     788:	00005097          	auipc	ra,0x5
     78c:	484080e7          	jalr	1156(ra) # 5c0c <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     790:	8652                	mv	a2,s4
     792:	85d6                	mv	a1,s5
     794:	00006517          	auipc	a0,0x6
     798:	c1450513          	addi	a0,a0,-1004 # 63a8 <malloc+0x6de>
     79c:	00005097          	auipc	ra,0x5
     7a0:	470080e7          	jalr	1136(ra) # 5c0c <printf>
    exit(1);
     7a4:	4505                	li	a0,1
     7a6:	00005097          	auipc	ra,0x5
     7aa:	0c2080e7          	jalr	194(ra) # 5868 <exit>
    printf("bbb fd2=%d\n", fd2);
     7ae:	85a6                	mv	a1,s1
     7b0:	00006517          	auipc	a0,0x6
     7b4:	c1850513          	addi	a0,a0,-1000 # 63c8 <malloc+0x6fe>
     7b8:	00005097          	auipc	ra,0x5
     7bc:	454080e7          	jalr	1108(ra) # 5c0c <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     7c0:	8652                	mv	a2,s4
     7c2:	85d6                	mv	a1,s5
     7c4:	00006517          	auipc	a0,0x6
     7c8:	be450513          	addi	a0,a0,-1052 # 63a8 <malloc+0x6de>
     7cc:	00005097          	auipc	ra,0x5
     7d0:	440080e7          	jalr	1088(ra) # 5c0c <printf>
    exit(1);
     7d4:	4505                	li	a0,1
     7d6:	00005097          	auipc	ra,0x5
     7da:	092080e7          	jalr	146(ra) # 5868 <exit>
    printf("%s: read %d bytes, wanted 6\n", s, n);
     7de:	862a                	mv	a2,a0
     7e0:	85d6                	mv	a1,s5
     7e2:	00006517          	auipc	a0,0x6
     7e6:	bfe50513          	addi	a0,a0,-1026 # 63e0 <malloc+0x716>
     7ea:	00005097          	auipc	ra,0x5
     7ee:	422080e7          	jalr	1058(ra) # 5c0c <printf>
    exit(1);
     7f2:	4505                	li	a0,1
     7f4:	00005097          	auipc	ra,0x5
     7f8:	074080e7          	jalr	116(ra) # 5868 <exit>
    printf("%s: read %d bytes, wanted 2\n", s, n);
     7fc:	862a                	mv	a2,a0
     7fe:	85d6                	mv	a1,s5
     800:	00006517          	auipc	a0,0x6
     804:	c0050513          	addi	a0,a0,-1024 # 6400 <malloc+0x736>
     808:	00005097          	auipc	ra,0x5
     80c:	404080e7          	jalr	1028(ra) # 5c0c <printf>
    exit(1);
     810:	4505                	li	a0,1
     812:	00005097          	auipc	ra,0x5
     816:	056080e7          	jalr	86(ra) # 5868 <exit>

000000000000081a <writetest>:
{
     81a:	7139                	addi	sp,sp,-64
     81c:	fc06                	sd	ra,56(sp)
     81e:	f822                	sd	s0,48(sp)
     820:	f426                	sd	s1,40(sp)
     822:	f04a                	sd	s2,32(sp)
     824:	ec4e                	sd	s3,24(sp)
     826:	e852                	sd	s4,16(sp)
     828:	e456                	sd	s5,8(sp)
     82a:	e05a                	sd	s6,0(sp)
     82c:	0080                	addi	s0,sp,64
     82e:	8b2a                	mv	s6,a0
  fd = open("small", O_CREATE|O_RDWR);
     830:	20200593          	li	a1,514
     834:	00006517          	auipc	a0,0x6
     838:	bec50513          	addi	a0,a0,-1044 # 6420 <malloc+0x756>
     83c:	00005097          	auipc	ra,0x5
     840:	06c080e7          	jalr	108(ra) # 58a8 <open>
  if(fd < 0){
     844:	0a054d63          	bltz	a0,8fe <writetest+0xe4>
     848:	892a                	mv	s2,a0
     84a:	4481                	li	s1,0
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     84c:	00006997          	auipc	s3,0x6
     850:	bfc98993          	addi	s3,s3,-1028 # 6448 <malloc+0x77e>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     854:	00006a97          	auipc	s5,0x6
     858:	c2ca8a93          	addi	s5,s5,-980 # 6480 <malloc+0x7b6>
  for(i = 0; i < N; i++){
     85c:	06400a13          	li	s4,100
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     860:	4629                	li	a2,10
     862:	85ce                	mv	a1,s3
     864:	854a                	mv	a0,s2
     866:	00005097          	auipc	ra,0x5
     86a:	022080e7          	jalr	34(ra) # 5888 <write>
     86e:	47a9                	li	a5,10
     870:	0af51563          	bne	a0,a5,91a <writetest+0x100>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     874:	4629                	li	a2,10
     876:	85d6                	mv	a1,s5
     878:	854a                	mv	a0,s2
     87a:	00005097          	auipc	ra,0x5
     87e:	00e080e7          	jalr	14(ra) # 5888 <write>
     882:	47a9                	li	a5,10
     884:	0af51a63          	bne	a0,a5,938 <writetest+0x11e>
  for(i = 0; i < N; i++){
     888:	2485                	addiw	s1,s1,1
     88a:	fd449be3          	bne	s1,s4,860 <writetest+0x46>
  close(fd);
     88e:	854a                	mv	a0,s2
     890:	00005097          	auipc	ra,0x5
     894:	000080e7          	jalr	ra # 5890 <close>
  fd = open("small", O_RDONLY);
     898:	4581                	li	a1,0
     89a:	00006517          	auipc	a0,0x6
     89e:	b8650513          	addi	a0,a0,-1146 # 6420 <malloc+0x756>
     8a2:	00005097          	auipc	ra,0x5
     8a6:	006080e7          	jalr	6(ra) # 58a8 <open>
     8aa:	84aa                	mv	s1,a0
  if(fd < 0){
     8ac:	0a054563          	bltz	a0,956 <writetest+0x13c>
  i = read(fd, buf, N*SZ*2);
     8b0:	7d000613          	li	a2,2000
     8b4:	0000b597          	auipc	a1,0xb
     8b8:	51c58593          	addi	a1,a1,1308 # bdd0 <buf>
     8bc:	00005097          	auipc	ra,0x5
     8c0:	fc4080e7          	jalr	-60(ra) # 5880 <read>
  if(i != N*SZ*2){
     8c4:	7d000793          	li	a5,2000
     8c8:	0af51563          	bne	a0,a5,972 <writetest+0x158>
  close(fd);
     8cc:	8526                	mv	a0,s1
     8ce:	00005097          	auipc	ra,0x5
     8d2:	fc2080e7          	jalr	-62(ra) # 5890 <close>
  if(unlink("small") < 0){
     8d6:	00006517          	auipc	a0,0x6
     8da:	b4a50513          	addi	a0,a0,-1206 # 6420 <malloc+0x756>
     8de:	00005097          	auipc	ra,0x5
     8e2:	fda080e7          	jalr	-38(ra) # 58b8 <unlink>
     8e6:	0a054463          	bltz	a0,98e <writetest+0x174>
}
     8ea:	70e2                	ld	ra,56(sp)
     8ec:	7442                	ld	s0,48(sp)
     8ee:	74a2                	ld	s1,40(sp)
     8f0:	7902                	ld	s2,32(sp)
     8f2:	69e2                	ld	s3,24(sp)
     8f4:	6a42                	ld	s4,16(sp)
     8f6:	6aa2                	ld	s5,8(sp)
     8f8:	6b02                	ld	s6,0(sp)
     8fa:	6121                	addi	sp,sp,64
     8fc:	8082                	ret
    printf("%s: error: creat small failed!\n", s);
     8fe:	85da                	mv	a1,s6
     900:	00006517          	auipc	a0,0x6
     904:	b2850513          	addi	a0,a0,-1240 # 6428 <malloc+0x75e>
     908:	00005097          	auipc	ra,0x5
     90c:	304080e7          	jalr	772(ra) # 5c0c <printf>
    exit(1);
     910:	4505                	li	a0,1
     912:	00005097          	auipc	ra,0x5
     916:	f56080e7          	jalr	-170(ra) # 5868 <exit>
      printf("%s: error: write aa %d new file failed\n", s, i);
     91a:	8626                	mv	a2,s1
     91c:	85da                	mv	a1,s6
     91e:	00006517          	auipc	a0,0x6
     922:	b3a50513          	addi	a0,a0,-1222 # 6458 <malloc+0x78e>
     926:	00005097          	auipc	ra,0x5
     92a:	2e6080e7          	jalr	742(ra) # 5c0c <printf>
      exit(1);
     92e:	4505                	li	a0,1
     930:	00005097          	auipc	ra,0x5
     934:	f38080e7          	jalr	-200(ra) # 5868 <exit>
      printf("%s: error: write bb %d new file failed\n", s, i);
     938:	8626                	mv	a2,s1
     93a:	85da                	mv	a1,s6
     93c:	00006517          	auipc	a0,0x6
     940:	b5450513          	addi	a0,a0,-1196 # 6490 <malloc+0x7c6>
     944:	00005097          	auipc	ra,0x5
     948:	2c8080e7          	jalr	712(ra) # 5c0c <printf>
      exit(1);
     94c:	4505                	li	a0,1
     94e:	00005097          	auipc	ra,0x5
     952:	f1a080e7          	jalr	-230(ra) # 5868 <exit>
    printf("%s: error: open small failed!\n", s);
     956:	85da                	mv	a1,s6
     958:	00006517          	auipc	a0,0x6
     95c:	b6050513          	addi	a0,a0,-1184 # 64b8 <malloc+0x7ee>
     960:	00005097          	auipc	ra,0x5
     964:	2ac080e7          	jalr	684(ra) # 5c0c <printf>
    exit(1);
     968:	4505                	li	a0,1
     96a:	00005097          	auipc	ra,0x5
     96e:	efe080e7          	jalr	-258(ra) # 5868 <exit>
    printf("%s: read failed\n", s);
     972:	85da                	mv	a1,s6
     974:	00006517          	auipc	a0,0x6
     978:	b6450513          	addi	a0,a0,-1180 # 64d8 <malloc+0x80e>
     97c:	00005097          	auipc	ra,0x5
     980:	290080e7          	jalr	656(ra) # 5c0c <printf>
    exit(1);
     984:	4505                	li	a0,1
     986:	00005097          	auipc	ra,0x5
     98a:	ee2080e7          	jalr	-286(ra) # 5868 <exit>
    printf("%s: unlink small failed\n", s);
     98e:	85da                	mv	a1,s6
     990:	00006517          	auipc	a0,0x6
     994:	b6050513          	addi	a0,a0,-1184 # 64f0 <malloc+0x826>
     998:	00005097          	auipc	ra,0x5
     99c:	274080e7          	jalr	628(ra) # 5c0c <printf>
    exit(1);
     9a0:	4505                	li	a0,1
     9a2:	00005097          	auipc	ra,0x5
     9a6:	ec6080e7          	jalr	-314(ra) # 5868 <exit>

00000000000009aa <writebig>:
{
     9aa:	7139                	addi	sp,sp,-64
     9ac:	fc06                	sd	ra,56(sp)
     9ae:	f822                	sd	s0,48(sp)
     9b0:	f426                	sd	s1,40(sp)
     9b2:	f04a                	sd	s2,32(sp)
     9b4:	ec4e                	sd	s3,24(sp)
     9b6:	e852                	sd	s4,16(sp)
     9b8:	e456                	sd	s5,8(sp)
     9ba:	0080                	addi	s0,sp,64
     9bc:	8aaa                	mv	s5,a0
  fd = open("big", O_CREATE|O_RDWR);
     9be:	20200593          	li	a1,514
     9c2:	00006517          	auipc	a0,0x6
     9c6:	b4e50513          	addi	a0,a0,-1202 # 6510 <malloc+0x846>
     9ca:	00005097          	auipc	ra,0x5
     9ce:	ede080e7          	jalr	-290(ra) # 58a8 <open>
     9d2:	89aa                	mv	s3,a0
  for(i = 0; i < MAXFILE; i++){
     9d4:	4481                	li	s1,0
    ((int*)buf)[0] = i;
     9d6:	0000b917          	auipc	s2,0xb
     9da:	3fa90913          	addi	s2,s2,1018 # bdd0 <buf>
  for(i = 0; i < MAXFILE; i++){
     9de:	10c00a13          	li	s4,268
  if(fd < 0){
     9e2:	06054c63          	bltz	a0,a5a <writebig+0xb0>
    ((int*)buf)[0] = i;
     9e6:	00992023          	sw	s1,0(s2)
    if(write(fd, buf, BSIZE) != BSIZE){
     9ea:	40000613          	li	a2,1024
     9ee:	85ca                	mv	a1,s2
     9f0:	854e                	mv	a0,s3
     9f2:	00005097          	auipc	ra,0x5
     9f6:	e96080e7          	jalr	-362(ra) # 5888 <write>
     9fa:	40000793          	li	a5,1024
     9fe:	06f51c63          	bne	a0,a5,a76 <writebig+0xcc>
  for(i = 0; i < MAXFILE; i++){
     a02:	2485                	addiw	s1,s1,1
     a04:	ff4491e3          	bne	s1,s4,9e6 <writebig+0x3c>
  close(fd);
     a08:	854e                	mv	a0,s3
     a0a:	00005097          	auipc	ra,0x5
     a0e:	e86080e7          	jalr	-378(ra) # 5890 <close>
  fd = open("big", O_RDONLY);
     a12:	4581                	li	a1,0
     a14:	00006517          	auipc	a0,0x6
     a18:	afc50513          	addi	a0,a0,-1284 # 6510 <malloc+0x846>
     a1c:	00005097          	auipc	ra,0x5
     a20:	e8c080e7          	jalr	-372(ra) # 58a8 <open>
     a24:	89aa                	mv	s3,a0
  n = 0;
     a26:	4481                	li	s1,0
    i = read(fd, buf, BSIZE);
     a28:	0000b917          	auipc	s2,0xb
     a2c:	3a890913          	addi	s2,s2,936 # bdd0 <buf>
  if(fd < 0){
     a30:	06054263          	bltz	a0,a94 <writebig+0xea>
    i = read(fd, buf, BSIZE);
     a34:	40000613          	li	a2,1024
     a38:	85ca                	mv	a1,s2
     a3a:	854e                	mv	a0,s3
     a3c:	00005097          	auipc	ra,0x5
     a40:	e44080e7          	jalr	-444(ra) # 5880 <read>
    if(i == 0){
     a44:	c535                	beqz	a0,ab0 <writebig+0x106>
    } else if(i != BSIZE){
     a46:	40000793          	li	a5,1024
     a4a:	0af51f63          	bne	a0,a5,b08 <writebig+0x15e>
    if(((int*)buf)[0] != n){
     a4e:	00092683          	lw	a3,0(s2)
     a52:	0c969a63          	bne	a3,s1,b26 <writebig+0x17c>
    n++;
     a56:	2485                	addiw	s1,s1,1
    i = read(fd, buf, BSIZE);
     a58:	bff1                	j	a34 <writebig+0x8a>
    printf("%s: error: creat big failed!\n", s);
     a5a:	85d6                	mv	a1,s5
     a5c:	00006517          	auipc	a0,0x6
     a60:	abc50513          	addi	a0,a0,-1348 # 6518 <malloc+0x84e>
     a64:	00005097          	auipc	ra,0x5
     a68:	1a8080e7          	jalr	424(ra) # 5c0c <printf>
    exit(1);
     a6c:	4505                	li	a0,1
     a6e:	00005097          	auipc	ra,0x5
     a72:	dfa080e7          	jalr	-518(ra) # 5868 <exit>
      printf("%s: error: write big file failed\n", s, i);
     a76:	8626                	mv	a2,s1
     a78:	85d6                	mv	a1,s5
     a7a:	00006517          	auipc	a0,0x6
     a7e:	abe50513          	addi	a0,a0,-1346 # 6538 <malloc+0x86e>
     a82:	00005097          	auipc	ra,0x5
     a86:	18a080e7          	jalr	394(ra) # 5c0c <printf>
      exit(1);
     a8a:	4505                	li	a0,1
     a8c:	00005097          	auipc	ra,0x5
     a90:	ddc080e7          	jalr	-548(ra) # 5868 <exit>
    printf("%s: error: open big failed!\n", s);
     a94:	85d6                	mv	a1,s5
     a96:	00006517          	auipc	a0,0x6
     a9a:	aca50513          	addi	a0,a0,-1334 # 6560 <malloc+0x896>
     a9e:	00005097          	auipc	ra,0x5
     aa2:	16e080e7          	jalr	366(ra) # 5c0c <printf>
    exit(1);
     aa6:	4505                	li	a0,1
     aa8:	00005097          	auipc	ra,0x5
     aac:	dc0080e7          	jalr	-576(ra) # 5868 <exit>
      if(n == MAXFILE - 1){
     ab0:	10b00793          	li	a5,267
     ab4:	02f48a63          	beq	s1,a5,ae8 <writebig+0x13e>
  close(fd);
     ab8:	854e                	mv	a0,s3
     aba:	00005097          	auipc	ra,0x5
     abe:	dd6080e7          	jalr	-554(ra) # 5890 <close>
  if(unlink("big") < 0){
     ac2:	00006517          	auipc	a0,0x6
     ac6:	a4e50513          	addi	a0,a0,-1458 # 6510 <malloc+0x846>
     aca:	00005097          	auipc	ra,0x5
     ace:	dee080e7          	jalr	-530(ra) # 58b8 <unlink>
     ad2:	06054963          	bltz	a0,b44 <writebig+0x19a>
}
     ad6:	70e2                	ld	ra,56(sp)
     ad8:	7442                	ld	s0,48(sp)
     ada:	74a2                	ld	s1,40(sp)
     adc:	7902                	ld	s2,32(sp)
     ade:	69e2                	ld	s3,24(sp)
     ae0:	6a42                	ld	s4,16(sp)
     ae2:	6aa2                	ld	s5,8(sp)
     ae4:	6121                	addi	sp,sp,64
     ae6:	8082                	ret
        printf("%s: read only %d blocks from big", s, n);
     ae8:	10b00613          	li	a2,267
     aec:	85d6                	mv	a1,s5
     aee:	00006517          	auipc	a0,0x6
     af2:	a9250513          	addi	a0,a0,-1390 # 6580 <malloc+0x8b6>
     af6:	00005097          	auipc	ra,0x5
     afa:	116080e7          	jalr	278(ra) # 5c0c <printf>
        exit(1);
     afe:	4505                	li	a0,1
     b00:	00005097          	auipc	ra,0x5
     b04:	d68080e7          	jalr	-664(ra) # 5868 <exit>
      printf("%s: read failed %d\n", s, i);
     b08:	862a                	mv	a2,a0
     b0a:	85d6                	mv	a1,s5
     b0c:	00006517          	auipc	a0,0x6
     b10:	a9c50513          	addi	a0,a0,-1380 # 65a8 <malloc+0x8de>
     b14:	00005097          	auipc	ra,0x5
     b18:	0f8080e7          	jalr	248(ra) # 5c0c <printf>
      exit(1);
     b1c:	4505                	li	a0,1
     b1e:	00005097          	auipc	ra,0x5
     b22:	d4a080e7          	jalr	-694(ra) # 5868 <exit>
      printf("%s: read content of block %d is %d\n", s,
     b26:	8626                	mv	a2,s1
     b28:	85d6                	mv	a1,s5
     b2a:	00006517          	auipc	a0,0x6
     b2e:	a9650513          	addi	a0,a0,-1386 # 65c0 <malloc+0x8f6>
     b32:	00005097          	auipc	ra,0x5
     b36:	0da080e7          	jalr	218(ra) # 5c0c <printf>
      exit(1);
     b3a:	4505                	li	a0,1
     b3c:	00005097          	auipc	ra,0x5
     b40:	d2c080e7          	jalr	-724(ra) # 5868 <exit>
    printf("%s: unlink big failed\n", s);
     b44:	85d6                	mv	a1,s5
     b46:	00006517          	auipc	a0,0x6
     b4a:	aa250513          	addi	a0,a0,-1374 # 65e8 <malloc+0x91e>
     b4e:	00005097          	auipc	ra,0x5
     b52:	0be080e7          	jalr	190(ra) # 5c0c <printf>
    exit(1);
     b56:	4505                	li	a0,1
     b58:	00005097          	auipc	ra,0x5
     b5c:	d10080e7          	jalr	-752(ra) # 5868 <exit>

0000000000000b60 <unlinkread>:
{
     b60:	7179                	addi	sp,sp,-48
     b62:	f406                	sd	ra,40(sp)
     b64:	f022                	sd	s0,32(sp)
     b66:	ec26                	sd	s1,24(sp)
     b68:	e84a                	sd	s2,16(sp)
     b6a:	e44e                	sd	s3,8(sp)
     b6c:	1800                	addi	s0,sp,48
     b6e:	89aa                	mv	s3,a0
  fd = open("unlinkread", O_CREATE | O_RDWR);
     b70:	20200593          	li	a1,514
     b74:	00005517          	auipc	a0,0x5
     b78:	3ac50513          	addi	a0,a0,940 # 5f20 <malloc+0x256>
     b7c:	00005097          	auipc	ra,0x5
     b80:	d2c080e7          	jalr	-724(ra) # 58a8 <open>
  if(fd < 0){
     b84:	0e054563          	bltz	a0,c6e <unlinkread+0x10e>
     b88:	84aa                	mv	s1,a0
  write(fd, "hello", SZ);
     b8a:	4615                	li	a2,5
     b8c:	00006597          	auipc	a1,0x6
     b90:	a9458593          	addi	a1,a1,-1388 # 6620 <malloc+0x956>
     b94:	00005097          	auipc	ra,0x5
     b98:	cf4080e7          	jalr	-780(ra) # 5888 <write>
  close(fd);
     b9c:	8526                	mv	a0,s1
     b9e:	00005097          	auipc	ra,0x5
     ba2:	cf2080e7          	jalr	-782(ra) # 5890 <close>
  fd = open("unlinkread", O_RDWR);
     ba6:	4589                	li	a1,2
     ba8:	00005517          	auipc	a0,0x5
     bac:	37850513          	addi	a0,a0,888 # 5f20 <malloc+0x256>
     bb0:	00005097          	auipc	ra,0x5
     bb4:	cf8080e7          	jalr	-776(ra) # 58a8 <open>
     bb8:	84aa                	mv	s1,a0
  if(fd < 0){
     bba:	0c054863          	bltz	a0,c8a <unlinkread+0x12a>
  if(unlink("unlinkread") != 0){
     bbe:	00005517          	auipc	a0,0x5
     bc2:	36250513          	addi	a0,a0,866 # 5f20 <malloc+0x256>
     bc6:	00005097          	auipc	ra,0x5
     bca:	cf2080e7          	jalr	-782(ra) # 58b8 <unlink>
     bce:	ed61                	bnez	a0,ca6 <unlinkread+0x146>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
     bd0:	20200593          	li	a1,514
     bd4:	00005517          	auipc	a0,0x5
     bd8:	34c50513          	addi	a0,a0,844 # 5f20 <malloc+0x256>
     bdc:	00005097          	auipc	ra,0x5
     be0:	ccc080e7          	jalr	-820(ra) # 58a8 <open>
     be4:	892a                	mv	s2,a0
  write(fd1, "yyy", 3);
     be6:	460d                	li	a2,3
     be8:	00006597          	auipc	a1,0x6
     bec:	a8058593          	addi	a1,a1,-1408 # 6668 <malloc+0x99e>
     bf0:	00005097          	auipc	ra,0x5
     bf4:	c98080e7          	jalr	-872(ra) # 5888 <write>
  close(fd1);
     bf8:	854a                	mv	a0,s2
     bfa:	00005097          	auipc	ra,0x5
     bfe:	c96080e7          	jalr	-874(ra) # 5890 <close>
  if(read(fd, buf, sizeof(buf)) != SZ){
     c02:	660d                	lui	a2,0x3
     c04:	0000b597          	auipc	a1,0xb
     c08:	1cc58593          	addi	a1,a1,460 # bdd0 <buf>
     c0c:	8526                	mv	a0,s1
     c0e:	00005097          	auipc	ra,0x5
     c12:	c72080e7          	jalr	-910(ra) # 5880 <read>
     c16:	4795                	li	a5,5
     c18:	0af51563          	bne	a0,a5,cc2 <unlinkread+0x162>
  if(buf[0] != 'h'){
     c1c:	0000b717          	auipc	a4,0xb
     c20:	1b474703          	lbu	a4,436(a4) # bdd0 <buf>
     c24:	06800793          	li	a5,104
     c28:	0af71b63          	bne	a4,a5,cde <unlinkread+0x17e>
  if(write(fd, buf, 10) != 10){
     c2c:	4629                	li	a2,10
     c2e:	0000b597          	auipc	a1,0xb
     c32:	1a258593          	addi	a1,a1,418 # bdd0 <buf>
     c36:	8526                	mv	a0,s1
     c38:	00005097          	auipc	ra,0x5
     c3c:	c50080e7          	jalr	-944(ra) # 5888 <write>
     c40:	47a9                	li	a5,10
     c42:	0af51c63          	bne	a0,a5,cfa <unlinkread+0x19a>
  close(fd);
     c46:	8526                	mv	a0,s1
     c48:	00005097          	auipc	ra,0x5
     c4c:	c48080e7          	jalr	-952(ra) # 5890 <close>
  unlink("unlinkread");
     c50:	00005517          	auipc	a0,0x5
     c54:	2d050513          	addi	a0,a0,720 # 5f20 <malloc+0x256>
     c58:	00005097          	auipc	ra,0x5
     c5c:	c60080e7          	jalr	-928(ra) # 58b8 <unlink>
}
     c60:	70a2                	ld	ra,40(sp)
     c62:	7402                	ld	s0,32(sp)
     c64:	64e2                	ld	s1,24(sp)
     c66:	6942                	ld	s2,16(sp)
     c68:	69a2                	ld	s3,8(sp)
     c6a:	6145                	addi	sp,sp,48
     c6c:	8082                	ret
    printf("%s: create unlinkread failed\n", s);
     c6e:	85ce                	mv	a1,s3
     c70:	00006517          	auipc	a0,0x6
     c74:	99050513          	addi	a0,a0,-1648 # 6600 <malloc+0x936>
     c78:	00005097          	auipc	ra,0x5
     c7c:	f94080e7          	jalr	-108(ra) # 5c0c <printf>
    exit(1);
     c80:	4505                	li	a0,1
     c82:	00005097          	auipc	ra,0x5
     c86:	be6080e7          	jalr	-1050(ra) # 5868 <exit>
    printf("%s: open unlinkread failed\n", s);
     c8a:	85ce                	mv	a1,s3
     c8c:	00006517          	auipc	a0,0x6
     c90:	99c50513          	addi	a0,a0,-1636 # 6628 <malloc+0x95e>
     c94:	00005097          	auipc	ra,0x5
     c98:	f78080e7          	jalr	-136(ra) # 5c0c <printf>
    exit(1);
     c9c:	4505                	li	a0,1
     c9e:	00005097          	auipc	ra,0x5
     ca2:	bca080e7          	jalr	-1078(ra) # 5868 <exit>
    printf("%s: unlink unlinkread failed\n", s);
     ca6:	85ce                	mv	a1,s3
     ca8:	00006517          	auipc	a0,0x6
     cac:	9a050513          	addi	a0,a0,-1632 # 6648 <malloc+0x97e>
     cb0:	00005097          	auipc	ra,0x5
     cb4:	f5c080e7          	jalr	-164(ra) # 5c0c <printf>
    exit(1);
     cb8:	4505                	li	a0,1
     cba:	00005097          	auipc	ra,0x5
     cbe:	bae080e7          	jalr	-1106(ra) # 5868 <exit>
    printf("%s: unlinkread read failed", s);
     cc2:	85ce                	mv	a1,s3
     cc4:	00006517          	auipc	a0,0x6
     cc8:	9ac50513          	addi	a0,a0,-1620 # 6670 <malloc+0x9a6>
     ccc:	00005097          	auipc	ra,0x5
     cd0:	f40080e7          	jalr	-192(ra) # 5c0c <printf>
    exit(1);
     cd4:	4505                	li	a0,1
     cd6:	00005097          	auipc	ra,0x5
     cda:	b92080e7          	jalr	-1134(ra) # 5868 <exit>
    printf("%s: unlinkread wrong data\n", s);
     cde:	85ce                	mv	a1,s3
     ce0:	00006517          	auipc	a0,0x6
     ce4:	9b050513          	addi	a0,a0,-1616 # 6690 <malloc+0x9c6>
     ce8:	00005097          	auipc	ra,0x5
     cec:	f24080e7          	jalr	-220(ra) # 5c0c <printf>
    exit(1);
     cf0:	4505                	li	a0,1
     cf2:	00005097          	auipc	ra,0x5
     cf6:	b76080e7          	jalr	-1162(ra) # 5868 <exit>
    printf("%s: unlinkread write failed\n", s);
     cfa:	85ce                	mv	a1,s3
     cfc:	00006517          	auipc	a0,0x6
     d00:	9b450513          	addi	a0,a0,-1612 # 66b0 <malloc+0x9e6>
     d04:	00005097          	auipc	ra,0x5
     d08:	f08080e7          	jalr	-248(ra) # 5c0c <printf>
    exit(1);
     d0c:	4505                	li	a0,1
     d0e:	00005097          	auipc	ra,0x5
     d12:	b5a080e7          	jalr	-1190(ra) # 5868 <exit>

0000000000000d16 <linktest>:
{
     d16:	1101                	addi	sp,sp,-32
     d18:	ec06                	sd	ra,24(sp)
     d1a:	e822                	sd	s0,16(sp)
     d1c:	e426                	sd	s1,8(sp)
     d1e:	e04a                	sd	s2,0(sp)
     d20:	1000                	addi	s0,sp,32
     d22:	892a                	mv	s2,a0
  unlink("lf1");
     d24:	00006517          	auipc	a0,0x6
     d28:	9ac50513          	addi	a0,a0,-1620 # 66d0 <malloc+0xa06>
     d2c:	00005097          	auipc	ra,0x5
     d30:	b8c080e7          	jalr	-1140(ra) # 58b8 <unlink>
  unlink("lf2");
     d34:	00006517          	auipc	a0,0x6
     d38:	9a450513          	addi	a0,a0,-1628 # 66d8 <malloc+0xa0e>
     d3c:	00005097          	auipc	ra,0x5
     d40:	b7c080e7          	jalr	-1156(ra) # 58b8 <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
     d44:	20200593          	li	a1,514
     d48:	00006517          	auipc	a0,0x6
     d4c:	98850513          	addi	a0,a0,-1656 # 66d0 <malloc+0xa06>
     d50:	00005097          	auipc	ra,0x5
     d54:	b58080e7          	jalr	-1192(ra) # 58a8 <open>
  if(fd < 0){
     d58:	10054763          	bltz	a0,e66 <linktest+0x150>
     d5c:	84aa                	mv	s1,a0
  if(write(fd, "hello", SZ) != SZ){
     d5e:	4615                	li	a2,5
     d60:	00006597          	auipc	a1,0x6
     d64:	8c058593          	addi	a1,a1,-1856 # 6620 <malloc+0x956>
     d68:	00005097          	auipc	ra,0x5
     d6c:	b20080e7          	jalr	-1248(ra) # 5888 <write>
     d70:	4795                	li	a5,5
     d72:	10f51863          	bne	a0,a5,e82 <linktest+0x16c>
  close(fd);
     d76:	8526                	mv	a0,s1
     d78:	00005097          	auipc	ra,0x5
     d7c:	b18080e7          	jalr	-1256(ra) # 5890 <close>
  if(link("lf1", "lf2") < 0){
     d80:	00006597          	auipc	a1,0x6
     d84:	95858593          	addi	a1,a1,-1704 # 66d8 <malloc+0xa0e>
     d88:	00006517          	auipc	a0,0x6
     d8c:	94850513          	addi	a0,a0,-1720 # 66d0 <malloc+0xa06>
     d90:	00005097          	auipc	ra,0x5
     d94:	b38080e7          	jalr	-1224(ra) # 58c8 <link>
     d98:	10054363          	bltz	a0,e9e <linktest+0x188>
  unlink("lf1");
     d9c:	00006517          	auipc	a0,0x6
     da0:	93450513          	addi	a0,a0,-1740 # 66d0 <malloc+0xa06>
     da4:	00005097          	auipc	ra,0x5
     da8:	b14080e7          	jalr	-1260(ra) # 58b8 <unlink>
  if(open("lf1", 0) >= 0){
     dac:	4581                	li	a1,0
     dae:	00006517          	auipc	a0,0x6
     db2:	92250513          	addi	a0,a0,-1758 # 66d0 <malloc+0xa06>
     db6:	00005097          	auipc	ra,0x5
     dba:	af2080e7          	jalr	-1294(ra) # 58a8 <open>
     dbe:	0e055e63          	bgez	a0,eba <linktest+0x1a4>
  fd = open("lf2", 0);
     dc2:	4581                	li	a1,0
     dc4:	00006517          	auipc	a0,0x6
     dc8:	91450513          	addi	a0,a0,-1772 # 66d8 <malloc+0xa0e>
     dcc:	00005097          	auipc	ra,0x5
     dd0:	adc080e7          	jalr	-1316(ra) # 58a8 <open>
     dd4:	84aa                	mv	s1,a0
  if(fd < 0){
     dd6:	10054063          	bltz	a0,ed6 <linktest+0x1c0>
  if(read(fd, buf, sizeof(buf)) != SZ){
     dda:	660d                	lui	a2,0x3
     ddc:	0000b597          	auipc	a1,0xb
     de0:	ff458593          	addi	a1,a1,-12 # bdd0 <buf>
     de4:	00005097          	auipc	ra,0x5
     de8:	a9c080e7          	jalr	-1380(ra) # 5880 <read>
     dec:	4795                	li	a5,5
     dee:	10f51263          	bne	a0,a5,ef2 <linktest+0x1dc>
  close(fd);
     df2:	8526                	mv	a0,s1
     df4:	00005097          	auipc	ra,0x5
     df8:	a9c080e7          	jalr	-1380(ra) # 5890 <close>
  if(link("lf2", "lf2") >= 0){
     dfc:	00006597          	auipc	a1,0x6
     e00:	8dc58593          	addi	a1,a1,-1828 # 66d8 <malloc+0xa0e>
     e04:	852e                	mv	a0,a1
     e06:	00005097          	auipc	ra,0x5
     e0a:	ac2080e7          	jalr	-1342(ra) # 58c8 <link>
     e0e:	10055063          	bgez	a0,f0e <linktest+0x1f8>
  unlink("lf2");
     e12:	00006517          	auipc	a0,0x6
     e16:	8c650513          	addi	a0,a0,-1850 # 66d8 <malloc+0xa0e>
     e1a:	00005097          	auipc	ra,0x5
     e1e:	a9e080e7          	jalr	-1378(ra) # 58b8 <unlink>
  if(link("lf2", "lf1") >= 0){
     e22:	00006597          	auipc	a1,0x6
     e26:	8ae58593          	addi	a1,a1,-1874 # 66d0 <malloc+0xa06>
     e2a:	00006517          	auipc	a0,0x6
     e2e:	8ae50513          	addi	a0,a0,-1874 # 66d8 <malloc+0xa0e>
     e32:	00005097          	auipc	ra,0x5
     e36:	a96080e7          	jalr	-1386(ra) # 58c8 <link>
     e3a:	0e055863          	bgez	a0,f2a <linktest+0x214>
  if(link(".", "lf1") >= 0){
     e3e:	00006597          	auipc	a1,0x6
     e42:	89258593          	addi	a1,a1,-1902 # 66d0 <malloc+0xa06>
     e46:	00006517          	auipc	a0,0x6
     e4a:	99a50513          	addi	a0,a0,-1638 # 67e0 <malloc+0xb16>
     e4e:	00005097          	auipc	ra,0x5
     e52:	a7a080e7          	jalr	-1414(ra) # 58c8 <link>
     e56:	0e055863          	bgez	a0,f46 <linktest+0x230>
}
     e5a:	60e2                	ld	ra,24(sp)
     e5c:	6442                	ld	s0,16(sp)
     e5e:	64a2                	ld	s1,8(sp)
     e60:	6902                	ld	s2,0(sp)
     e62:	6105                	addi	sp,sp,32
     e64:	8082                	ret
    printf("%s: create lf1 failed\n", s);
     e66:	85ca                	mv	a1,s2
     e68:	00006517          	auipc	a0,0x6
     e6c:	87850513          	addi	a0,a0,-1928 # 66e0 <malloc+0xa16>
     e70:	00005097          	auipc	ra,0x5
     e74:	d9c080e7          	jalr	-612(ra) # 5c0c <printf>
    exit(1);
     e78:	4505                	li	a0,1
     e7a:	00005097          	auipc	ra,0x5
     e7e:	9ee080e7          	jalr	-1554(ra) # 5868 <exit>
    printf("%s: write lf1 failed\n", s);
     e82:	85ca                	mv	a1,s2
     e84:	00006517          	auipc	a0,0x6
     e88:	87450513          	addi	a0,a0,-1932 # 66f8 <malloc+0xa2e>
     e8c:	00005097          	auipc	ra,0x5
     e90:	d80080e7          	jalr	-640(ra) # 5c0c <printf>
    exit(1);
     e94:	4505                	li	a0,1
     e96:	00005097          	auipc	ra,0x5
     e9a:	9d2080e7          	jalr	-1582(ra) # 5868 <exit>
    printf("%s: link lf1 lf2 failed\n", s);
     e9e:	85ca                	mv	a1,s2
     ea0:	00006517          	auipc	a0,0x6
     ea4:	87050513          	addi	a0,a0,-1936 # 6710 <malloc+0xa46>
     ea8:	00005097          	auipc	ra,0x5
     eac:	d64080e7          	jalr	-668(ra) # 5c0c <printf>
    exit(1);
     eb0:	4505                	li	a0,1
     eb2:	00005097          	auipc	ra,0x5
     eb6:	9b6080e7          	jalr	-1610(ra) # 5868 <exit>
    printf("%s: unlinked lf1 but it is still there!\n", s);
     eba:	85ca                	mv	a1,s2
     ebc:	00006517          	auipc	a0,0x6
     ec0:	87450513          	addi	a0,a0,-1932 # 6730 <malloc+0xa66>
     ec4:	00005097          	auipc	ra,0x5
     ec8:	d48080e7          	jalr	-696(ra) # 5c0c <printf>
    exit(1);
     ecc:	4505                	li	a0,1
     ece:	00005097          	auipc	ra,0x5
     ed2:	99a080e7          	jalr	-1638(ra) # 5868 <exit>
    printf("%s: open lf2 failed\n", s);
     ed6:	85ca                	mv	a1,s2
     ed8:	00006517          	auipc	a0,0x6
     edc:	88850513          	addi	a0,a0,-1912 # 6760 <malloc+0xa96>
     ee0:	00005097          	auipc	ra,0x5
     ee4:	d2c080e7          	jalr	-724(ra) # 5c0c <printf>
    exit(1);
     ee8:	4505                	li	a0,1
     eea:	00005097          	auipc	ra,0x5
     eee:	97e080e7          	jalr	-1666(ra) # 5868 <exit>
    printf("%s: read lf2 failed\n", s);
     ef2:	85ca                	mv	a1,s2
     ef4:	00006517          	auipc	a0,0x6
     ef8:	88450513          	addi	a0,a0,-1916 # 6778 <malloc+0xaae>
     efc:	00005097          	auipc	ra,0x5
     f00:	d10080e7          	jalr	-752(ra) # 5c0c <printf>
    exit(1);
     f04:	4505                	li	a0,1
     f06:	00005097          	auipc	ra,0x5
     f0a:	962080e7          	jalr	-1694(ra) # 5868 <exit>
    printf("%s: link lf2 lf2 succeeded! oops\n", s);
     f0e:	85ca                	mv	a1,s2
     f10:	00006517          	auipc	a0,0x6
     f14:	88050513          	addi	a0,a0,-1920 # 6790 <malloc+0xac6>
     f18:	00005097          	auipc	ra,0x5
     f1c:	cf4080e7          	jalr	-780(ra) # 5c0c <printf>
    exit(1);
     f20:	4505                	li	a0,1
     f22:	00005097          	auipc	ra,0x5
     f26:	946080e7          	jalr	-1722(ra) # 5868 <exit>
    printf("%s: link non-existent succeeded! oops\n", s);
     f2a:	85ca                	mv	a1,s2
     f2c:	00006517          	auipc	a0,0x6
     f30:	88c50513          	addi	a0,a0,-1908 # 67b8 <malloc+0xaee>
     f34:	00005097          	auipc	ra,0x5
     f38:	cd8080e7          	jalr	-808(ra) # 5c0c <printf>
    exit(1);
     f3c:	4505                	li	a0,1
     f3e:	00005097          	auipc	ra,0x5
     f42:	92a080e7          	jalr	-1750(ra) # 5868 <exit>
    printf("%s: link . lf1 succeeded! oops\n", s);
     f46:	85ca                	mv	a1,s2
     f48:	00006517          	auipc	a0,0x6
     f4c:	8a050513          	addi	a0,a0,-1888 # 67e8 <malloc+0xb1e>
     f50:	00005097          	auipc	ra,0x5
     f54:	cbc080e7          	jalr	-836(ra) # 5c0c <printf>
    exit(1);
     f58:	4505                	li	a0,1
     f5a:	00005097          	auipc	ra,0x5
     f5e:	90e080e7          	jalr	-1778(ra) # 5868 <exit>

0000000000000f62 <bigdir>:
{
     f62:	715d                	addi	sp,sp,-80
     f64:	e486                	sd	ra,72(sp)
     f66:	e0a2                	sd	s0,64(sp)
     f68:	fc26                	sd	s1,56(sp)
     f6a:	f84a                	sd	s2,48(sp)
     f6c:	f44e                	sd	s3,40(sp)
     f6e:	f052                	sd	s4,32(sp)
     f70:	ec56                	sd	s5,24(sp)
     f72:	e85a                	sd	s6,16(sp)
     f74:	0880                	addi	s0,sp,80
     f76:	89aa                	mv	s3,a0
  unlink("bd");
     f78:	00006517          	auipc	a0,0x6
     f7c:	89050513          	addi	a0,a0,-1904 # 6808 <malloc+0xb3e>
     f80:	00005097          	auipc	ra,0x5
     f84:	938080e7          	jalr	-1736(ra) # 58b8 <unlink>
  fd = open("bd", O_CREATE);
     f88:	20000593          	li	a1,512
     f8c:	00006517          	auipc	a0,0x6
     f90:	87c50513          	addi	a0,a0,-1924 # 6808 <malloc+0xb3e>
     f94:	00005097          	auipc	ra,0x5
     f98:	914080e7          	jalr	-1772(ra) # 58a8 <open>
  if(fd < 0){
     f9c:	0c054963          	bltz	a0,106e <bigdir+0x10c>
  close(fd);
     fa0:	00005097          	auipc	ra,0x5
     fa4:	8f0080e7          	jalr	-1808(ra) # 5890 <close>
  for(i = 0; i < N; i++){
     fa8:	4901                	li	s2,0
    name[0] = 'x';
     faa:	07800a93          	li	s5,120
    if(link("bd", name) != 0){
     fae:	00006a17          	auipc	s4,0x6
     fb2:	85aa0a13          	addi	s4,s4,-1958 # 6808 <malloc+0xb3e>
  for(i = 0; i < N; i++){
     fb6:	1f400b13          	li	s6,500
    name[0] = 'x';
     fba:	fb540823          	sb	s5,-80(s0)
    name[1] = '0' + (i / 64);
     fbe:	41f9579b          	sraiw	a5,s2,0x1f
     fc2:	01a7d71b          	srliw	a4,a5,0x1a
     fc6:	012707bb          	addw	a5,a4,s2
     fca:	4067d69b          	sraiw	a3,a5,0x6
     fce:	0306869b          	addiw	a3,a3,48
     fd2:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
     fd6:	03f7f793          	andi	a5,a5,63
     fda:	9f99                	subw	a5,a5,a4
     fdc:	0307879b          	addiw	a5,a5,48
     fe0:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
     fe4:	fa0409a3          	sb	zero,-77(s0)
    if(link("bd", name) != 0){
     fe8:	fb040593          	addi	a1,s0,-80
     fec:	8552                	mv	a0,s4
     fee:	00005097          	auipc	ra,0x5
     ff2:	8da080e7          	jalr	-1830(ra) # 58c8 <link>
     ff6:	84aa                	mv	s1,a0
     ff8:	e949                	bnez	a0,108a <bigdir+0x128>
  for(i = 0; i < N; i++){
     ffa:	2905                	addiw	s2,s2,1
     ffc:	fb691fe3          	bne	s2,s6,fba <bigdir+0x58>
  unlink("bd");
    1000:	00006517          	auipc	a0,0x6
    1004:	80850513          	addi	a0,a0,-2040 # 6808 <malloc+0xb3e>
    1008:	00005097          	auipc	ra,0x5
    100c:	8b0080e7          	jalr	-1872(ra) # 58b8 <unlink>
    name[0] = 'x';
    1010:	07800913          	li	s2,120
  for(i = 0; i < N; i++){
    1014:	1f400a13          	li	s4,500
    name[0] = 'x';
    1018:	fb240823          	sb	s2,-80(s0)
    name[1] = '0' + (i / 64);
    101c:	41f4d79b          	sraiw	a5,s1,0x1f
    1020:	01a7d71b          	srliw	a4,a5,0x1a
    1024:	009707bb          	addw	a5,a4,s1
    1028:	4067d69b          	sraiw	a3,a5,0x6
    102c:	0306869b          	addiw	a3,a3,48
    1030:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
    1034:	03f7f793          	andi	a5,a5,63
    1038:	9f99                	subw	a5,a5,a4
    103a:	0307879b          	addiw	a5,a5,48
    103e:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
    1042:	fa0409a3          	sb	zero,-77(s0)
    if(unlink(name) != 0){
    1046:	fb040513          	addi	a0,s0,-80
    104a:	00005097          	auipc	ra,0x5
    104e:	86e080e7          	jalr	-1938(ra) # 58b8 <unlink>
    1052:	ed21                	bnez	a0,10aa <bigdir+0x148>
  for(i = 0; i < N; i++){
    1054:	2485                	addiw	s1,s1,1
    1056:	fd4491e3          	bne	s1,s4,1018 <bigdir+0xb6>
}
    105a:	60a6                	ld	ra,72(sp)
    105c:	6406                	ld	s0,64(sp)
    105e:	74e2                	ld	s1,56(sp)
    1060:	7942                	ld	s2,48(sp)
    1062:	79a2                	ld	s3,40(sp)
    1064:	7a02                	ld	s4,32(sp)
    1066:	6ae2                	ld	s5,24(sp)
    1068:	6b42                	ld	s6,16(sp)
    106a:	6161                	addi	sp,sp,80
    106c:	8082                	ret
    printf("%s: bigdir create failed\n", s);
    106e:	85ce                	mv	a1,s3
    1070:	00005517          	auipc	a0,0x5
    1074:	7a050513          	addi	a0,a0,1952 # 6810 <malloc+0xb46>
    1078:	00005097          	auipc	ra,0x5
    107c:	b94080e7          	jalr	-1132(ra) # 5c0c <printf>
    exit(1);
    1080:	4505                	li	a0,1
    1082:	00004097          	auipc	ra,0x4
    1086:	7e6080e7          	jalr	2022(ra) # 5868 <exit>
      printf("%s: bigdir link(bd, %s) failed\n", s, name);
    108a:	fb040613          	addi	a2,s0,-80
    108e:	85ce                	mv	a1,s3
    1090:	00005517          	auipc	a0,0x5
    1094:	7a050513          	addi	a0,a0,1952 # 6830 <malloc+0xb66>
    1098:	00005097          	auipc	ra,0x5
    109c:	b74080e7          	jalr	-1164(ra) # 5c0c <printf>
      exit(1);
    10a0:	4505                	li	a0,1
    10a2:	00004097          	auipc	ra,0x4
    10a6:	7c6080e7          	jalr	1990(ra) # 5868 <exit>
      printf("%s: bigdir unlink failed", s);
    10aa:	85ce                	mv	a1,s3
    10ac:	00005517          	auipc	a0,0x5
    10b0:	7a450513          	addi	a0,a0,1956 # 6850 <malloc+0xb86>
    10b4:	00005097          	auipc	ra,0x5
    10b8:	b58080e7          	jalr	-1192(ra) # 5c0c <printf>
      exit(1);
    10bc:	4505                	li	a0,1
    10be:	00004097          	auipc	ra,0x4
    10c2:	7aa080e7          	jalr	1962(ra) # 5868 <exit>

00000000000010c6 <validatetest>:
{
    10c6:	7139                	addi	sp,sp,-64
    10c8:	fc06                	sd	ra,56(sp)
    10ca:	f822                	sd	s0,48(sp)
    10cc:	f426                	sd	s1,40(sp)
    10ce:	f04a                	sd	s2,32(sp)
    10d0:	ec4e                	sd	s3,24(sp)
    10d2:	e852                	sd	s4,16(sp)
    10d4:	e456                	sd	s5,8(sp)
    10d6:	e05a                	sd	s6,0(sp)
    10d8:	0080                	addi	s0,sp,64
    10da:	8b2a                	mv	s6,a0
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    10dc:	4481                	li	s1,0
    if(link("nosuchfile", (char*)p) != -1){
    10de:	00005997          	auipc	s3,0x5
    10e2:	79298993          	addi	s3,s3,1938 # 6870 <malloc+0xba6>
    10e6:	597d                	li	s2,-1
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    10e8:	6a85                	lui	s5,0x1
    10ea:	00114a37          	lui	s4,0x114
    if(link("nosuchfile", (char*)p) != -1){
    10ee:	85a6                	mv	a1,s1
    10f0:	854e                	mv	a0,s3
    10f2:	00004097          	auipc	ra,0x4
    10f6:	7d6080e7          	jalr	2006(ra) # 58c8 <link>
    10fa:	01251f63          	bne	a0,s2,1118 <validatetest+0x52>
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    10fe:	94d6                	add	s1,s1,s5
    1100:	ff4497e3          	bne	s1,s4,10ee <validatetest+0x28>
}
    1104:	70e2                	ld	ra,56(sp)
    1106:	7442                	ld	s0,48(sp)
    1108:	74a2                	ld	s1,40(sp)
    110a:	7902                	ld	s2,32(sp)
    110c:	69e2                	ld	s3,24(sp)
    110e:	6a42                	ld	s4,16(sp)
    1110:	6aa2                	ld	s5,8(sp)
    1112:	6b02                	ld	s6,0(sp)
    1114:	6121                	addi	sp,sp,64
    1116:	8082                	ret
      printf("%s: link should not succeed\n", s);
    1118:	85da                	mv	a1,s6
    111a:	00005517          	auipc	a0,0x5
    111e:	76650513          	addi	a0,a0,1894 # 6880 <malloc+0xbb6>
    1122:	00005097          	auipc	ra,0x5
    1126:	aea080e7          	jalr	-1302(ra) # 5c0c <printf>
      exit(1);
    112a:	4505                	li	a0,1
    112c:	00004097          	auipc	ra,0x4
    1130:	73c080e7          	jalr	1852(ra) # 5868 <exit>

0000000000001134 <pgbug>:
// regression test. copyin(), copyout(), and copyinstr() used to cast
// the virtual page address to uint, which (with certain wild system
// call arguments) resulted in a kernel page faults.
void
pgbug(char *s)
{
    1134:	7179                	addi	sp,sp,-48
    1136:	f406                	sd	ra,40(sp)
    1138:	f022                	sd	s0,32(sp)
    113a:	ec26                	sd	s1,24(sp)
    113c:	1800                	addi	s0,sp,48
  char *argv[1];
  argv[0] = 0;
    113e:	fc043c23          	sd	zero,-40(s0)
  exec((char*)0xeaeb0b5b00002f5e, argv);
    1142:	00007497          	auipc	s1,0x7
    1146:	4664b483          	ld	s1,1126(s1) # 85a8 <__SDATA_BEGIN__>
    114a:	fd840593          	addi	a1,s0,-40
    114e:	8526                	mv	a0,s1
    1150:	00004097          	auipc	ra,0x4
    1154:	750080e7          	jalr	1872(ra) # 58a0 <exec>

  pipe((int*)0xeaeb0b5b00002f5e);
    1158:	8526                	mv	a0,s1
    115a:	00004097          	auipc	ra,0x4
    115e:	71e080e7          	jalr	1822(ra) # 5878 <pipe>

  exit(0);
    1162:	4501                	li	a0,0
    1164:	00004097          	auipc	ra,0x4
    1168:	704080e7          	jalr	1796(ra) # 5868 <exit>

000000000000116c <badarg>:

// regression test. test whether exec() leaks memory if one of the
// arguments is invalid. the test passes if the kernel doesn't panic.
void
badarg(char *s)
{
    116c:	7139                	addi	sp,sp,-64
    116e:	fc06                	sd	ra,56(sp)
    1170:	f822                	sd	s0,48(sp)
    1172:	f426                	sd	s1,40(sp)
    1174:	f04a                	sd	s2,32(sp)
    1176:	ec4e                	sd	s3,24(sp)
    1178:	0080                	addi	s0,sp,64
    117a:	64b1                	lui	s1,0xc
    117c:	35048493          	addi	s1,s1,848 # c350 <buf+0x580>
  for(int i = 0; i < 50000; i++){
    char *argv[2];
    argv[0] = (char*)0xffffffff;
    1180:	597d                	li	s2,-1
    1182:	02095913          	srli	s2,s2,0x20
    argv[1] = 0;
    exec("echo", argv);
    1186:	00005997          	auipc	s3,0x5
    118a:	fc298993          	addi	s3,s3,-62 # 6148 <malloc+0x47e>
    argv[0] = (char*)0xffffffff;
    118e:	fd243023          	sd	s2,-64(s0)
    argv[1] = 0;
    1192:	fc043423          	sd	zero,-56(s0)
    exec("echo", argv);
    1196:	fc040593          	addi	a1,s0,-64
    119a:	854e                	mv	a0,s3
    119c:	00004097          	auipc	ra,0x4
    11a0:	704080e7          	jalr	1796(ra) # 58a0 <exec>
  for(int i = 0; i < 50000; i++){
    11a4:	34fd                	addiw	s1,s1,-1
    11a6:	f4e5                	bnez	s1,118e <badarg+0x22>
  }
  
  exit(0);
    11a8:	4501                	li	a0,0
    11aa:	00004097          	auipc	ra,0x4
    11ae:	6be080e7          	jalr	1726(ra) # 5868 <exit>

00000000000011b2 <copyinstr2>:
{
    11b2:	7155                	addi	sp,sp,-208
    11b4:	e586                	sd	ra,200(sp)
    11b6:	e1a2                	sd	s0,192(sp)
    11b8:	0980                	addi	s0,sp,208
  for(int i = 0; i < MAXPATH; i++)
    11ba:	f6840793          	addi	a5,s0,-152
    11be:	fe840693          	addi	a3,s0,-24
    b[i] = 'x';
    11c2:	07800713          	li	a4,120
    11c6:	00e78023          	sb	a4,0(a5)
  for(int i = 0; i < MAXPATH; i++)
    11ca:	0785                	addi	a5,a5,1
    11cc:	fed79de3          	bne	a5,a3,11c6 <copyinstr2+0x14>
  b[MAXPATH] = '\0';
    11d0:	fe040423          	sb	zero,-24(s0)
  int ret = unlink(b);
    11d4:	f6840513          	addi	a0,s0,-152
    11d8:	00004097          	auipc	ra,0x4
    11dc:	6e0080e7          	jalr	1760(ra) # 58b8 <unlink>
  if(ret != -1){
    11e0:	57fd                	li	a5,-1
    11e2:	0ef51063          	bne	a0,a5,12c2 <copyinstr2+0x110>
  int fd = open(b, O_CREATE | O_WRONLY);
    11e6:	20100593          	li	a1,513
    11ea:	f6840513          	addi	a0,s0,-152
    11ee:	00004097          	auipc	ra,0x4
    11f2:	6ba080e7          	jalr	1722(ra) # 58a8 <open>
  if(fd != -1){
    11f6:	57fd                	li	a5,-1
    11f8:	0ef51563          	bne	a0,a5,12e2 <copyinstr2+0x130>
  ret = link(b, b);
    11fc:	f6840593          	addi	a1,s0,-152
    1200:	852e                	mv	a0,a1
    1202:	00004097          	auipc	ra,0x4
    1206:	6c6080e7          	jalr	1734(ra) # 58c8 <link>
  if(ret != -1){
    120a:	57fd                	li	a5,-1
    120c:	0ef51b63          	bne	a0,a5,1302 <copyinstr2+0x150>
  char *args[] = { "xx", 0 };
    1210:	00007797          	auipc	a5,0x7
    1214:	85878793          	addi	a5,a5,-1960 # 7a68 <malloc+0x1d9e>
    1218:	f4f43c23          	sd	a5,-168(s0)
    121c:	f6043023          	sd	zero,-160(s0)
  ret = exec(b, args);
    1220:	f5840593          	addi	a1,s0,-168
    1224:	f6840513          	addi	a0,s0,-152
    1228:	00004097          	auipc	ra,0x4
    122c:	678080e7          	jalr	1656(ra) # 58a0 <exec>
  if(ret != -1){
    1230:	57fd                	li	a5,-1
    1232:	0ef51963          	bne	a0,a5,1324 <copyinstr2+0x172>
  int pid = fork();
    1236:	00004097          	auipc	ra,0x4
    123a:	62a080e7          	jalr	1578(ra) # 5860 <fork>
  if(pid < 0){
    123e:	10054363          	bltz	a0,1344 <copyinstr2+0x192>
  if(pid == 0){
    1242:	12051463          	bnez	a0,136a <copyinstr2+0x1b8>
    1246:	00007797          	auipc	a5,0x7
    124a:	47278793          	addi	a5,a5,1138 # 86b8 <big.1288>
    124e:	00008697          	auipc	a3,0x8
    1252:	46a68693          	addi	a3,a3,1130 # 96b8 <__global_pointer$+0x910>
      big[i] = 'x';
    1256:	07800713          	li	a4,120
    125a:	00e78023          	sb	a4,0(a5)
    for(int i = 0; i < PGSIZE; i++)
    125e:	0785                	addi	a5,a5,1
    1260:	fed79de3          	bne	a5,a3,125a <copyinstr2+0xa8>
    big[PGSIZE] = '\0';
    1264:	00008797          	auipc	a5,0x8
    1268:	44078a23          	sb	zero,1108(a5) # 96b8 <__global_pointer$+0x910>
    char *args2[] = { big, big, big, 0 };
    126c:	00007797          	auipc	a5,0x7
    1270:	f0c78793          	addi	a5,a5,-244 # 8178 <malloc+0x24ae>
    1274:	6390                	ld	a2,0(a5)
    1276:	6794                	ld	a3,8(a5)
    1278:	6b98                	ld	a4,16(a5)
    127a:	6f9c                	ld	a5,24(a5)
    127c:	f2c43823          	sd	a2,-208(s0)
    1280:	f2d43c23          	sd	a3,-200(s0)
    1284:	f4e43023          	sd	a4,-192(s0)
    1288:	f4f43423          	sd	a5,-184(s0)
    ret = exec("echo", args2);
    128c:	f3040593          	addi	a1,s0,-208
    1290:	00005517          	auipc	a0,0x5
    1294:	eb850513          	addi	a0,a0,-328 # 6148 <malloc+0x47e>
    1298:	00004097          	auipc	ra,0x4
    129c:	608080e7          	jalr	1544(ra) # 58a0 <exec>
    if(ret != -1){
    12a0:	57fd                	li	a5,-1
    12a2:	0af50e63          	beq	a0,a5,135e <copyinstr2+0x1ac>
      printf("exec(echo, BIG) returned %d, not -1\n", fd);
    12a6:	55fd                	li	a1,-1
    12a8:	00005517          	auipc	a0,0x5
    12ac:	68050513          	addi	a0,a0,1664 # 6928 <malloc+0xc5e>
    12b0:	00005097          	auipc	ra,0x5
    12b4:	95c080e7          	jalr	-1700(ra) # 5c0c <printf>
      exit(1);
    12b8:	4505                	li	a0,1
    12ba:	00004097          	auipc	ra,0x4
    12be:	5ae080e7          	jalr	1454(ra) # 5868 <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    12c2:	862a                	mv	a2,a0
    12c4:	f6840593          	addi	a1,s0,-152
    12c8:	00005517          	auipc	a0,0x5
    12cc:	5d850513          	addi	a0,a0,1496 # 68a0 <malloc+0xbd6>
    12d0:	00005097          	auipc	ra,0x5
    12d4:	93c080e7          	jalr	-1732(ra) # 5c0c <printf>
    exit(1);
    12d8:	4505                	li	a0,1
    12da:	00004097          	auipc	ra,0x4
    12de:	58e080e7          	jalr	1422(ra) # 5868 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    12e2:	862a                	mv	a2,a0
    12e4:	f6840593          	addi	a1,s0,-152
    12e8:	00005517          	auipc	a0,0x5
    12ec:	5d850513          	addi	a0,a0,1496 # 68c0 <malloc+0xbf6>
    12f0:	00005097          	auipc	ra,0x5
    12f4:	91c080e7          	jalr	-1764(ra) # 5c0c <printf>
    exit(1);
    12f8:	4505                	li	a0,1
    12fa:	00004097          	auipc	ra,0x4
    12fe:	56e080e7          	jalr	1390(ra) # 5868 <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    1302:	86aa                	mv	a3,a0
    1304:	f6840613          	addi	a2,s0,-152
    1308:	85b2                	mv	a1,a2
    130a:	00005517          	auipc	a0,0x5
    130e:	5d650513          	addi	a0,a0,1494 # 68e0 <malloc+0xc16>
    1312:	00005097          	auipc	ra,0x5
    1316:	8fa080e7          	jalr	-1798(ra) # 5c0c <printf>
    exit(1);
    131a:	4505                	li	a0,1
    131c:	00004097          	auipc	ra,0x4
    1320:	54c080e7          	jalr	1356(ra) # 5868 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    1324:	567d                	li	a2,-1
    1326:	f6840593          	addi	a1,s0,-152
    132a:	00005517          	auipc	a0,0x5
    132e:	5de50513          	addi	a0,a0,1502 # 6908 <malloc+0xc3e>
    1332:	00005097          	auipc	ra,0x5
    1336:	8da080e7          	jalr	-1830(ra) # 5c0c <printf>
    exit(1);
    133a:	4505                	li	a0,1
    133c:	00004097          	auipc	ra,0x4
    1340:	52c080e7          	jalr	1324(ra) # 5868 <exit>
    printf("fork failed\n");
    1344:	00006517          	auipc	a0,0x6
    1348:	a5c50513          	addi	a0,a0,-1444 # 6da0 <malloc+0x10d6>
    134c:	00005097          	auipc	ra,0x5
    1350:	8c0080e7          	jalr	-1856(ra) # 5c0c <printf>
    exit(1);
    1354:	4505                	li	a0,1
    1356:	00004097          	auipc	ra,0x4
    135a:	512080e7          	jalr	1298(ra) # 5868 <exit>
    exit(747); // OK
    135e:	2eb00513          	li	a0,747
    1362:	00004097          	auipc	ra,0x4
    1366:	506080e7          	jalr	1286(ra) # 5868 <exit>
  int st = 0;
    136a:	f4042a23          	sw	zero,-172(s0)
  wait(&st);
    136e:	f5440513          	addi	a0,s0,-172
    1372:	00004097          	auipc	ra,0x4
    1376:	4fe080e7          	jalr	1278(ra) # 5870 <wait>
  if(st != 747){
    137a:	f5442703          	lw	a4,-172(s0)
    137e:	2eb00793          	li	a5,747
    1382:	00f71663          	bne	a4,a5,138e <copyinstr2+0x1dc>
}
    1386:	60ae                	ld	ra,200(sp)
    1388:	640e                	ld	s0,192(sp)
    138a:	6169                	addi	sp,sp,208
    138c:	8082                	ret
    printf("exec(echo, BIG) succeeded, should have failed\n");
    138e:	00005517          	auipc	a0,0x5
    1392:	5c250513          	addi	a0,a0,1474 # 6950 <malloc+0xc86>
    1396:	00005097          	auipc	ra,0x5
    139a:	876080e7          	jalr	-1930(ra) # 5c0c <printf>
    exit(1);
    139e:	4505                	li	a0,1
    13a0:	00004097          	auipc	ra,0x4
    13a4:	4c8080e7          	jalr	1224(ra) # 5868 <exit>

00000000000013a8 <truncate3>:
{
    13a8:	7159                	addi	sp,sp,-112
    13aa:	f486                	sd	ra,104(sp)
    13ac:	f0a2                	sd	s0,96(sp)
    13ae:	eca6                	sd	s1,88(sp)
    13b0:	e8ca                	sd	s2,80(sp)
    13b2:	e4ce                	sd	s3,72(sp)
    13b4:	e0d2                	sd	s4,64(sp)
    13b6:	fc56                	sd	s5,56(sp)
    13b8:	1880                	addi	s0,sp,112
    13ba:	892a                	mv	s2,a0
  close(open("truncfile", O_CREATE|O_TRUNC|O_WRONLY));
    13bc:	60100593          	li	a1,1537
    13c0:	00005517          	auipc	a0,0x5
    13c4:	de050513          	addi	a0,a0,-544 # 61a0 <malloc+0x4d6>
    13c8:	00004097          	auipc	ra,0x4
    13cc:	4e0080e7          	jalr	1248(ra) # 58a8 <open>
    13d0:	00004097          	auipc	ra,0x4
    13d4:	4c0080e7          	jalr	1216(ra) # 5890 <close>
  pid = fork();
    13d8:	00004097          	auipc	ra,0x4
    13dc:	488080e7          	jalr	1160(ra) # 5860 <fork>
  if(pid < 0){
    13e0:	08054063          	bltz	a0,1460 <truncate3+0xb8>
  if(pid == 0){
    13e4:	e969                	bnez	a0,14b6 <truncate3+0x10e>
    13e6:	06400993          	li	s3,100
      int fd = open("truncfile", O_WRONLY);
    13ea:	00005a17          	auipc	s4,0x5
    13ee:	db6a0a13          	addi	s4,s4,-586 # 61a0 <malloc+0x4d6>
      int n = write(fd, "1234567890", 10);
    13f2:	00005a97          	auipc	s5,0x5
    13f6:	5bea8a93          	addi	s5,s5,1470 # 69b0 <malloc+0xce6>
      int fd = open("truncfile", O_WRONLY);
    13fa:	4585                	li	a1,1
    13fc:	8552                	mv	a0,s4
    13fe:	00004097          	auipc	ra,0x4
    1402:	4aa080e7          	jalr	1194(ra) # 58a8 <open>
    1406:	84aa                	mv	s1,a0
      if(fd < 0){
    1408:	06054a63          	bltz	a0,147c <truncate3+0xd4>
      int n = write(fd, "1234567890", 10);
    140c:	4629                	li	a2,10
    140e:	85d6                	mv	a1,s5
    1410:	00004097          	auipc	ra,0x4
    1414:	478080e7          	jalr	1144(ra) # 5888 <write>
      if(n != 10){
    1418:	47a9                	li	a5,10
    141a:	06f51f63          	bne	a0,a5,1498 <truncate3+0xf0>
      close(fd);
    141e:	8526                	mv	a0,s1
    1420:	00004097          	auipc	ra,0x4
    1424:	470080e7          	jalr	1136(ra) # 5890 <close>
      fd = open("truncfile", O_RDONLY);
    1428:	4581                	li	a1,0
    142a:	8552                	mv	a0,s4
    142c:	00004097          	auipc	ra,0x4
    1430:	47c080e7          	jalr	1148(ra) # 58a8 <open>
    1434:	84aa                	mv	s1,a0
      read(fd, buf, sizeof(buf));
    1436:	02000613          	li	a2,32
    143a:	f9840593          	addi	a1,s0,-104
    143e:	00004097          	auipc	ra,0x4
    1442:	442080e7          	jalr	1090(ra) # 5880 <read>
      close(fd);
    1446:	8526                	mv	a0,s1
    1448:	00004097          	auipc	ra,0x4
    144c:	448080e7          	jalr	1096(ra) # 5890 <close>
    for(int i = 0; i < 100; i++){
    1450:	39fd                	addiw	s3,s3,-1
    1452:	fa0994e3          	bnez	s3,13fa <truncate3+0x52>
    exit(0);
    1456:	4501                	li	a0,0
    1458:	00004097          	auipc	ra,0x4
    145c:	410080e7          	jalr	1040(ra) # 5868 <exit>
    printf("%s: fork failed\n", s);
    1460:	85ca                	mv	a1,s2
    1462:	00005517          	auipc	a0,0x5
    1466:	51e50513          	addi	a0,a0,1310 # 6980 <malloc+0xcb6>
    146a:	00004097          	auipc	ra,0x4
    146e:	7a2080e7          	jalr	1954(ra) # 5c0c <printf>
    exit(1);
    1472:	4505                	li	a0,1
    1474:	00004097          	auipc	ra,0x4
    1478:	3f4080e7          	jalr	1012(ra) # 5868 <exit>
        printf("%s: open failed\n", s);
    147c:	85ca                	mv	a1,s2
    147e:	00005517          	auipc	a0,0x5
    1482:	51a50513          	addi	a0,a0,1306 # 6998 <malloc+0xcce>
    1486:	00004097          	auipc	ra,0x4
    148a:	786080e7          	jalr	1926(ra) # 5c0c <printf>
        exit(1);
    148e:	4505                	li	a0,1
    1490:	00004097          	auipc	ra,0x4
    1494:	3d8080e7          	jalr	984(ra) # 5868 <exit>
        printf("%s: write got %d, expected 10\n", s, n);
    1498:	862a                	mv	a2,a0
    149a:	85ca                	mv	a1,s2
    149c:	00005517          	auipc	a0,0x5
    14a0:	52450513          	addi	a0,a0,1316 # 69c0 <malloc+0xcf6>
    14a4:	00004097          	auipc	ra,0x4
    14a8:	768080e7          	jalr	1896(ra) # 5c0c <printf>
        exit(1);
    14ac:	4505                	li	a0,1
    14ae:	00004097          	auipc	ra,0x4
    14b2:	3ba080e7          	jalr	954(ra) # 5868 <exit>
    14b6:	09600993          	li	s3,150
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    14ba:	00005a17          	auipc	s4,0x5
    14be:	ce6a0a13          	addi	s4,s4,-794 # 61a0 <malloc+0x4d6>
    int n = write(fd, "xxx", 3);
    14c2:	00005a97          	auipc	s5,0x5
    14c6:	51ea8a93          	addi	s5,s5,1310 # 69e0 <malloc+0xd16>
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    14ca:	60100593          	li	a1,1537
    14ce:	8552                	mv	a0,s4
    14d0:	00004097          	auipc	ra,0x4
    14d4:	3d8080e7          	jalr	984(ra) # 58a8 <open>
    14d8:	84aa                	mv	s1,a0
    if(fd < 0){
    14da:	04054763          	bltz	a0,1528 <truncate3+0x180>
    int n = write(fd, "xxx", 3);
    14de:	460d                	li	a2,3
    14e0:	85d6                	mv	a1,s5
    14e2:	00004097          	auipc	ra,0x4
    14e6:	3a6080e7          	jalr	934(ra) # 5888 <write>
    if(n != 3){
    14ea:	478d                	li	a5,3
    14ec:	04f51c63          	bne	a0,a5,1544 <truncate3+0x19c>
    close(fd);
    14f0:	8526                	mv	a0,s1
    14f2:	00004097          	auipc	ra,0x4
    14f6:	39e080e7          	jalr	926(ra) # 5890 <close>
  for(int i = 0; i < 150; i++){
    14fa:	39fd                	addiw	s3,s3,-1
    14fc:	fc0997e3          	bnez	s3,14ca <truncate3+0x122>
  wait(&xstatus);
    1500:	fbc40513          	addi	a0,s0,-68
    1504:	00004097          	auipc	ra,0x4
    1508:	36c080e7          	jalr	876(ra) # 5870 <wait>
  unlink("truncfile");
    150c:	00005517          	auipc	a0,0x5
    1510:	c9450513          	addi	a0,a0,-876 # 61a0 <malloc+0x4d6>
    1514:	00004097          	auipc	ra,0x4
    1518:	3a4080e7          	jalr	932(ra) # 58b8 <unlink>
  exit(xstatus);
    151c:	fbc42503          	lw	a0,-68(s0)
    1520:	00004097          	auipc	ra,0x4
    1524:	348080e7          	jalr	840(ra) # 5868 <exit>
      printf("%s: open failed\n", s);
    1528:	85ca                	mv	a1,s2
    152a:	00005517          	auipc	a0,0x5
    152e:	46e50513          	addi	a0,a0,1134 # 6998 <malloc+0xcce>
    1532:	00004097          	auipc	ra,0x4
    1536:	6da080e7          	jalr	1754(ra) # 5c0c <printf>
      exit(1);
    153a:	4505                	li	a0,1
    153c:	00004097          	auipc	ra,0x4
    1540:	32c080e7          	jalr	812(ra) # 5868 <exit>
      printf("%s: write got %d, expected 3\n", s, n);
    1544:	862a                	mv	a2,a0
    1546:	85ca                	mv	a1,s2
    1548:	00005517          	auipc	a0,0x5
    154c:	4a050513          	addi	a0,a0,1184 # 69e8 <malloc+0xd1e>
    1550:	00004097          	auipc	ra,0x4
    1554:	6bc080e7          	jalr	1724(ra) # 5c0c <printf>
      exit(1);
    1558:	4505                	li	a0,1
    155a:	00004097          	auipc	ra,0x4
    155e:	30e080e7          	jalr	782(ra) # 5868 <exit>

0000000000001562 <exectest>:
{
    1562:	715d                	addi	sp,sp,-80
    1564:	e486                	sd	ra,72(sp)
    1566:	e0a2                	sd	s0,64(sp)
    1568:	fc26                	sd	s1,56(sp)
    156a:	f84a                	sd	s2,48(sp)
    156c:	0880                	addi	s0,sp,80
    156e:	892a                	mv	s2,a0
  char *echoargv[] = { "echo", "OK", 0 };
    1570:	00005797          	auipc	a5,0x5
    1574:	bd878793          	addi	a5,a5,-1064 # 6148 <malloc+0x47e>
    1578:	fcf43023          	sd	a5,-64(s0)
    157c:	00005797          	auipc	a5,0x5
    1580:	48c78793          	addi	a5,a5,1164 # 6a08 <malloc+0xd3e>
    1584:	fcf43423          	sd	a5,-56(s0)
    1588:	fc043823          	sd	zero,-48(s0)
  unlink("echo-ok");
    158c:	00005517          	auipc	a0,0x5
    1590:	48450513          	addi	a0,a0,1156 # 6a10 <malloc+0xd46>
    1594:	00004097          	auipc	ra,0x4
    1598:	324080e7          	jalr	804(ra) # 58b8 <unlink>
  pid = fork();
    159c:	00004097          	auipc	ra,0x4
    15a0:	2c4080e7          	jalr	708(ra) # 5860 <fork>
  if(pid < 0) {
    15a4:	04054663          	bltz	a0,15f0 <exectest+0x8e>
    15a8:	84aa                	mv	s1,a0
  if(pid == 0) {
    15aa:	e959                	bnez	a0,1640 <exectest+0xde>
    close(1);
    15ac:	4505                	li	a0,1
    15ae:	00004097          	auipc	ra,0x4
    15b2:	2e2080e7          	jalr	738(ra) # 5890 <close>
    fd = open("echo-ok", O_CREATE|O_WRONLY);
    15b6:	20100593          	li	a1,513
    15ba:	00005517          	auipc	a0,0x5
    15be:	45650513          	addi	a0,a0,1110 # 6a10 <malloc+0xd46>
    15c2:	00004097          	auipc	ra,0x4
    15c6:	2e6080e7          	jalr	742(ra) # 58a8 <open>
    if(fd < 0) {
    15ca:	04054163          	bltz	a0,160c <exectest+0xaa>
    if(fd != 1) {
    15ce:	4785                	li	a5,1
    15d0:	04f50c63          	beq	a0,a5,1628 <exectest+0xc6>
      printf("%s: wrong fd\n", s);
    15d4:	85ca                	mv	a1,s2
    15d6:	00005517          	auipc	a0,0x5
    15da:	45a50513          	addi	a0,a0,1114 # 6a30 <malloc+0xd66>
    15de:	00004097          	auipc	ra,0x4
    15e2:	62e080e7          	jalr	1582(ra) # 5c0c <printf>
      exit(1);
    15e6:	4505                	li	a0,1
    15e8:	00004097          	auipc	ra,0x4
    15ec:	280080e7          	jalr	640(ra) # 5868 <exit>
     printf("%s: fork failed\n", s);
    15f0:	85ca                	mv	a1,s2
    15f2:	00005517          	auipc	a0,0x5
    15f6:	38e50513          	addi	a0,a0,910 # 6980 <malloc+0xcb6>
    15fa:	00004097          	auipc	ra,0x4
    15fe:	612080e7          	jalr	1554(ra) # 5c0c <printf>
     exit(1);
    1602:	4505                	li	a0,1
    1604:	00004097          	auipc	ra,0x4
    1608:	264080e7          	jalr	612(ra) # 5868 <exit>
      printf("%s: create failed\n", s);
    160c:	85ca                	mv	a1,s2
    160e:	00005517          	auipc	a0,0x5
    1612:	40a50513          	addi	a0,a0,1034 # 6a18 <malloc+0xd4e>
    1616:	00004097          	auipc	ra,0x4
    161a:	5f6080e7          	jalr	1526(ra) # 5c0c <printf>
      exit(1);
    161e:	4505                	li	a0,1
    1620:	00004097          	auipc	ra,0x4
    1624:	248080e7          	jalr	584(ra) # 5868 <exit>
    if(exec("echo", echoargv) < 0){
    1628:	fc040593          	addi	a1,s0,-64
    162c:	00005517          	auipc	a0,0x5
    1630:	b1c50513          	addi	a0,a0,-1252 # 6148 <malloc+0x47e>
    1634:	00004097          	auipc	ra,0x4
    1638:	26c080e7          	jalr	620(ra) # 58a0 <exec>
    163c:	02054163          	bltz	a0,165e <exectest+0xfc>
  if (wait(&xstatus) != pid) {
    1640:	fdc40513          	addi	a0,s0,-36
    1644:	00004097          	auipc	ra,0x4
    1648:	22c080e7          	jalr	556(ra) # 5870 <wait>
    164c:	02951763          	bne	a0,s1,167a <exectest+0x118>
  if(xstatus != 0)
    1650:	fdc42503          	lw	a0,-36(s0)
    1654:	cd0d                	beqz	a0,168e <exectest+0x12c>
    exit(xstatus);
    1656:	00004097          	auipc	ra,0x4
    165a:	212080e7          	jalr	530(ra) # 5868 <exit>
      printf("%s: exec echo failed\n", s);
    165e:	85ca                	mv	a1,s2
    1660:	00005517          	auipc	a0,0x5
    1664:	3e050513          	addi	a0,a0,992 # 6a40 <malloc+0xd76>
    1668:	00004097          	auipc	ra,0x4
    166c:	5a4080e7          	jalr	1444(ra) # 5c0c <printf>
      exit(1);
    1670:	4505                	li	a0,1
    1672:	00004097          	auipc	ra,0x4
    1676:	1f6080e7          	jalr	502(ra) # 5868 <exit>
    printf("%s: wait failed!\n", s);
    167a:	85ca                	mv	a1,s2
    167c:	00005517          	auipc	a0,0x5
    1680:	3dc50513          	addi	a0,a0,988 # 6a58 <malloc+0xd8e>
    1684:	00004097          	auipc	ra,0x4
    1688:	588080e7          	jalr	1416(ra) # 5c0c <printf>
    168c:	b7d1                	j	1650 <exectest+0xee>
  fd = open("echo-ok", O_RDONLY);
    168e:	4581                	li	a1,0
    1690:	00005517          	auipc	a0,0x5
    1694:	38050513          	addi	a0,a0,896 # 6a10 <malloc+0xd46>
    1698:	00004097          	auipc	ra,0x4
    169c:	210080e7          	jalr	528(ra) # 58a8 <open>
  if(fd < 0) {
    16a0:	02054a63          	bltz	a0,16d4 <exectest+0x172>
  if (read(fd, buf, 2) != 2) {
    16a4:	4609                	li	a2,2
    16a6:	fb840593          	addi	a1,s0,-72
    16aa:	00004097          	auipc	ra,0x4
    16ae:	1d6080e7          	jalr	470(ra) # 5880 <read>
    16b2:	4789                	li	a5,2
    16b4:	02f50e63          	beq	a0,a5,16f0 <exectest+0x18e>
    printf("%s: read failed\n", s);
    16b8:	85ca                	mv	a1,s2
    16ba:	00005517          	auipc	a0,0x5
    16be:	e1e50513          	addi	a0,a0,-482 # 64d8 <malloc+0x80e>
    16c2:	00004097          	auipc	ra,0x4
    16c6:	54a080e7          	jalr	1354(ra) # 5c0c <printf>
    exit(1);
    16ca:	4505                	li	a0,1
    16cc:	00004097          	auipc	ra,0x4
    16d0:	19c080e7          	jalr	412(ra) # 5868 <exit>
    printf("%s: open failed\n", s);
    16d4:	85ca                	mv	a1,s2
    16d6:	00005517          	auipc	a0,0x5
    16da:	2c250513          	addi	a0,a0,706 # 6998 <malloc+0xcce>
    16de:	00004097          	auipc	ra,0x4
    16e2:	52e080e7          	jalr	1326(ra) # 5c0c <printf>
    exit(1);
    16e6:	4505                	li	a0,1
    16e8:	00004097          	auipc	ra,0x4
    16ec:	180080e7          	jalr	384(ra) # 5868 <exit>
  unlink("echo-ok");
    16f0:	00005517          	auipc	a0,0x5
    16f4:	32050513          	addi	a0,a0,800 # 6a10 <malloc+0xd46>
    16f8:	00004097          	auipc	ra,0x4
    16fc:	1c0080e7          	jalr	448(ra) # 58b8 <unlink>
  if(buf[0] == 'O' && buf[1] == 'K')
    1700:	fb844703          	lbu	a4,-72(s0)
    1704:	04f00793          	li	a5,79
    1708:	00f71863          	bne	a4,a5,1718 <exectest+0x1b6>
    170c:	fb944703          	lbu	a4,-71(s0)
    1710:	04b00793          	li	a5,75
    1714:	02f70063          	beq	a4,a5,1734 <exectest+0x1d2>
    printf("%s: wrong output\n", s);
    1718:	85ca                	mv	a1,s2
    171a:	00005517          	auipc	a0,0x5
    171e:	35650513          	addi	a0,a0,854 # 6a70 <malloc+0xda6>
    1722:	00004097          	auipc	ra,0x4
    1726:	4ea080e7          	jalr	1258(ra) # 5c0c <printf>
    exit(1);
    172a:	4505                	li	a0,1
    172c:	00004097          	auipc	ra,0x4
    1730:	13c080e7          	jalr	316(ra) # 5868 <exit>
    exit(0);
    1734:	4501                	li	a0,0
    1736:	00004097          	auipc	ra,0x4
    173a:	132080e7          	jalr	306(ra) # 5868 <exit>

000000000000173e <pipe1>:
{
    173e:	711d                	addi	sp,sp,-96
    1740:	ec86                	sd	ra,88(sp)
    1742:	e8a2                	sd	s0,80(sp)
    1744:	e4a6                	sd	s1,72(sp)
    1746:	e0ca                	sd	s2,64(sp)
    1748:	fc4e                	sd	s3,56(sp)
    174a:	f852                	sd	s4,48(sp)
    174c:	f456                	sd	s5,40(sp)
    174e:	f05a                	sd	s6,32(sp)
    1750:	ec5e                	sd	s7,24(sp)
    1752:	1080                	addi	s0,sp,96
    1754:	892a                	mv	s2,a0
  if(pipe(fds) != 0){
    1756:	fa840513          	addi	a0,s0,-88
    175a:	00004097          	auipc	ra,0x4
    175e:	11e080e7          	jalr	286(ra) # 5878 <pipe>
    1762:	ed25                	bnez	a0,17da <pipe1+0x9c>
    1764:	84aa                	mv	s1,a0
  pid = fork();
    1766:	00004097          	auipc	ra,0x4
    176a:	0fa080e7          	jalr	250(ra) # 5860 <fork>
    176e:	8a2a                	mv	s4,a0
  if(pid == 0){
    1770:	c159                	beqz	a0,17f6 <pipe1+0xb8>
  } else if(pid > 0){
    1772:	16a05e63          	blez	a0,18ee <pipe1+0x1b0>
    close(fds[1]);
    1776:	fac42503          	lw	a0,-84(s0)
    177a:	00004097          	auipc	ra,0x4
    177e:	116080e7          	jalr	278(ra) # 5890 <close>
    total = 0;
    1782:	8a26                	mv	s4,s1
    cc = 1;
    1784:	4985                	li	s3,1
    while((n = read(fds[0], buf, cc)) > 0){
    1786:	0000aa97          	auipc	s5,0xa
    178a:	64aa8a93          	addi	s5,s5,1610 # bdd0 <buf>
      if(cc > sizeof(buf))
    178e:	6b0d                	lui	s6,0x3
    while((n = read(fds[0], buf, cc)) > 0){
    1790:	864e                	mv	a2,s3
    1792:	85d6                	mv	a1,s5
    1794:	fa842503          	lw	a0,-88(s0)
    1798:	00004097          	auipc	ra,0x4
    179c:	0e8080e7          	jalr	232(ra) # 5880 <read>
    17a0:	10a05263          	blez	a0,18a4 <pipe1+0x166>
      for(i = 0; i < n; i++){
    17a4:	0000a717          	auipc	a4,0xa
    17a8:	62c70713          	addi	a4,a4,1580 # bdd0 <buf>
    17ac:	00a4863b          	addw	a2,s1,a0
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    17b0:	00074683          	lbu	a3,0(a4)
    17b4:	0ff4f793          	andi	a5,s1,255
    17b8:	2485                	addiw	s1,s1,1
    17ba:	0cf69163          	bne	a3,a5,187c <pipe1+0x13e>
      for(i = 0; i < n; i++){
    17be:	0705                	addi	a4,a4,1
    17c0:	fec498e3          	bne	s1,a2,17b0 <pipe1+0x72>
      total += n;
    17c4:	00aa0a3b          	addw	s4,s4,a0
      cc = cc * 2;
    17c8:	0019979b          	slliw	a5,s3,0x1
    17cc:	0007899b          	sext.w	s3,a5
      if(cc > sizeof(buf))
    17d0:	013b7363          	bgeu	s6,s3,17d6 <pipe1+0x98>
        cc = sizeof(buf);
    17d4:	89da                	mv	s3,s6
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    17d6:	84b2                	mv	s1,a2
    17d8:	bf65                	j	1790 <pipe1+0x52>
    printf("%s: pipe() failed\n", s);
    17da:	85ca                	mv	a1,s2
    17dc:	00005517          	auipc	a0,0x5
    17e0:	2ac50513          	addi	a0,a0,684 # 6a88 <malloc+0xdbe>
    17e4:	00004097          	auipc	ra,0x4
    17e8:	428080e7          	jalr	1064(ra) # 5c0c <printf>
    exit(1);
    17ec:	4505                	li	a0,1
    17ee:	00004097          	auipc	ra,0x4
    17f2:	07a080e7          	jalr	122(ra) # 5868 <exit>
    close(fds[0]);
    17f6:	fa842503          	lw	a0,-88(s0)
    17fa:	00004097          	auipc	ra,0x4
    17fe:	096080e7          	jalr	150(ra) # 5890 <close>
    for(n = 0; n < N; n++){
    1802:	0000ab17          	auipc	s6,0xa
    1806:	5ceb0b13          	addi	s6,s6,1486 # bdd0 <buf>
    180a:	416004bb          	negw	s1,s6
    180e:	0ff4f493          	andi	s1,s1,255
    1812:	409b0993          	addi	s3,s6,1033
      if(write(fds[1], buf, SZ) != SZ){
    1816:	8bda                	mv	s7,s6
    for(n = 0; n < N; n++){
    1818:	6a85                	lui	s5,0x1
    181a:	42da8a93          	addi	s5,s5,1069 # 142d <truncate3+0x85>
{
    181e:	87da                	mv	a5,s6
        buf[i] = seq++;
    1820:	0097873b          	addw	a4,a5,s1
    1824:	00e78023          	sb	a4,0(a5)
      for(i = 0; i < SZ; i++)
    1828:	0785                	addi	a5,a5,1
    182a:	fef99be3          	bne	s3,a5,1820 <pipe1+0xe2>
    182e:	409a0a1b          	addiw	s4,s4,1033
      if(write(fds[1], buf, SZ) != SZ){
    1832:	40900613          	li	a2,1033
    1836:	85de                	mv	a1,s7
    1838:	fac42503          	lw	a0,-84(s0)
    183c:	00004097          	auipc	ra,0x4
    1840:	04c080e7          	jalr	76(ra) # 5888 <write>
    1844:	40900793          	li	a5,1033
    1848:	00f51c63          	bne	a0,a5,1860 <pipe1+0x122>
    for(n = 0; n < N; n++){
    184c:	24a5                	addiw	s1,s1,9
    184e:	0ff4f493          	andi	s1,s1,255
    1852:	fd5a16e3          	bne	s4,s5,181e <pipe1+0xe0>
    exit(0);
    1856:	4501                	li	a0,0
    1858:	00004097          	auipc	ra,0x4
    185c:	010080e7          	jalr	16(ra) # 5868 <exit>
        printf("%s: pipe1 oops 1\n", s);
    1860:	85ca                	mv	a1,s2
    1862:	00005517          	auipc	a0,0x5
    1866:	23e50513          	addi	a0,a0,574 # 6aa0 <malloc+0xdd6>
    186a:	00004097          	auipc	ra,0x4
    186e:	3a2080e7          	jalr	930(ra) # 5c0c <printf>
        exit(1);
    1872:	4505                	li	a0,1
    1874:	00004097          	auipc	ra,0x4
    1878:	ff4080e7          	jalr	-12(ra) # 5868 <exit>
          printf("%s: pipe1 oops 2\n", s);
    187c:	85ca                	mv	a1,s2
    187e:	00005517          	auipc	a0,0x5
    1882:	23a50513          	addi	a0,a0,570 # 6ab8 <malloc+0xdee>
    1886:	00004097          	auipc	ra,0x4
    188a:	386080e7          	jalr	902(ra) # 5c0c <printf>
}
    188e:	60e6                	ld	ra,88(sp)
    1890:	6446                	ld	s0,80(sp)
    1892:	64a6                	ld	s1,72(sp)
    1894:	6906                	ld	s2,64(sp)
    1896:	79e2                	ld	s3,56(sp)
    1898:	7a42                	ld	s4,48(sp)
    189a:	7aa2                	ld	s5,40(sp)
    189c:	7b02                	ld	s6,32(sp)
    189e:	6be2                	ld	s7,24(sp)
    18a0:	6125                	addi	sp,sp,96
    18a2:	8082                	ret
    if(total != N * SZ){
    18a4:	6785                	lui	a5,0x1
    18a6:	42d78793          	addi	a5,a5,1069 # 142d <truncate3+0x85>
    18aa:	02fa0063          	beq	s4,a5,18ca <pipe1+0x18c>
      printf("%s: pipe1 oops 3 total %d\n", total);
    18ae:	85d2                	mv	a1,s4
    18b0:	00005517          	auipc	a0,0x5
    18b4:	22050513          	addi	a0,a0,544 # 6ad0 <malloc+0xe06>
    18b8:	00004097          	auipc	ra,0x4
    18bc:	354080e7          	jalr	852(ra) # 5c0c <printf>
      exit(1);
    18c0:	4505                	li	a0,1
    18c2:	00004097          	auipc	ra,0x4
    18c6:	fa6080e7          	jalr	-90(ra) # 5868 <exit>
    close(fds[0]);
    18ca:	fa842503          	lw	a0,-88(s0)
    18ce:	00004097          	auipc	ra,0x4
    18d2:	fc2080e7          	jalr	-62(ra) # 5890 <close>
    wait(&xstatus);
    18d6:	fa440513          	addi	a0,s0,-92
    18da:	00004097          	auipc	ra,0x4
    18de:	f96080e7          	jalr	-106(ra) # 5870 <wait>
    exit(xstatus);
    18e2:	fa442503          	lw	a0,-92(s0)
    18e6:	00004097          	auipc	ra,0x4
    18ea:	f82080e7          	jalr	-126(ra) # 5868 <exit>
    printf("%s: fork() failed\n", s);
    18ee:	85ca                	mv	a1,s2
    18f0:	00005517          	auipc	a0,0x5
    18f4:	20050513          	addi	a0,a0,512 # 6af0 <malloc+0xe26>
    18f8:	00004097          	auipc	ra,0x4
    18fc:	314080e7          	jalr	788(ra) # 5c0c <printf>
    exit(1);
    1900:	4505                	li	a0,1
    1902:	00004097          	auipc	ra,0x4
    1906:	f66080e7          	jalr	-154(ra) # 5868 <exit>

000000000000190a <exitwait>:
{
    190a:	7139                	addi	sp,sp,-64
    190c:	fc06                	sd	ra,56(sp)
    190e:	f822                	sd	s0,48(sp)
    1910:	f426                	sd	s1,40(sp)
    1912:	f04a                	sd	s2,32(sp)
    1914:	ec4e                	sd	s3,24(sp)
    1916:	e852                	sd	s4,16(sp)
    1918:	0080                	addi	s0,sp,64
    191a:	8a2a                	mv	s4,a0
  for(i = 0; i < 100; i++){
    191c:	4901                	li	s2,0
    191e:	06400993          	li	s3,100
    pid = fork();
    1922:	00004097          	auipc	ra,0x4
    1926:	f3e080e7          	jalr	-194(ra) # 5860 <fork>
    192a:	84aa                	mv	s1,a0
    if(pid < 0){
    192c:	02054a63          	bltz	a0,1960 <exitwait+0x56>
    if(pid){
    1930:	c151                	beqz	a0,19b4 <exitwait+0xaa>
      if(wait(&xstate) != pid){
    1932:	fcc40513          	addi	a0,s0,-52
    1936:	00004097          	auipc	ra,0x4
    193a:	f3a080e7          	jalr	-198(ra) # 5870 <wait>
    193e:	02951f63          	bne	a0,s1,197c <exitwait+0x72>
      if(i != xstate) {
    1942:	fcc42783          	lw	a5,-52(s0)
    1946:	05279963          	bne	a5,s2,1998 <exitwait+0x8e>
  for(i = 0; i < 100; i++){
    194a:	2905                	addiw	s2,s2,1
    194c:	fd391be3          	bne	s2,s3,1922 <exitwait+0x18>
}
    1950:	70e2                	ld	ra,56(sp)
    1952:	7442                	ld	s0,48(sp)
    1954:	74a2                	ld	s1,40(sp)
    1956:	7902                	ld	s2,32(sp)
    1958:	69e2                	ld	s3,24(sp)
    195a:	6a42                	ld	s4,16(sp)
    195c:	6121                	addi	sp,sp,64
    195e:	8082                	ret
      printf("%s: fork failed\n", s);
    1960:	85d2                	mv	a1,s4
    1962:	00005517          	auipc	a0,0x5
    1966:	01e50513          	addi	a0,a0,30 # 6980 <malloc+0xcb6>
    196a:	00004097          	auipc	ra,0x4
    196e:	2a2080e7          	jalr	674(ra) # 5c0c <printf>
      exit(1);
    1972:	4505                	li	a0,1
    1974:	00004097          	auipc	ra,0x4
    1978:	ef4080e7          	jalr	-268(ra) # 5868 <exit>
        printf("%s: wait wrong pid\n", s);
    197c:	85d2                	mv	a1,s4
    197e:	00005517          	auipc	a0,0x5
    1982:	18a50513          	addi	a0,a0,394 # 6b08 <malloc+0xe3e>
    1986:	00004097          	auipc	ra,0x4
    198a:	286080e7          	jalr	646(ra) # 5c0c <printf>
        exit(1);
    198e:	4505                	li	a0,1
    1990:	00004097          	auipc	ra,0x4
    1994:	ed8080e7          	jalr	-296(ra) # 5868 <exit>
        printf("%s: wait wrong exit status\n", s);
    1998:	85d2                	mv	a1,s4
    199a:	00005517          	auipc	a0,0x5
    199e:	18650513          	addi	a0,a0,390 # 6b20 <malloc+0xe56>
    19a2:	00004097          	auipc	ra,0x4
    19a6:	26a080e7          	jalr	618(ra) # 5c0c <printf>
        exit(1);
    19aa:	4505                	li	a0,1
    19ac:	00004097          	auipc	ra,0x4
    19b0:	ebc080e7          	jalr	-324(ra) # 5868 <exit>
      exit(i);
    19b4:	854a                	mv	a0,s2
    19b6:	00004097          	auipc	ra,0x4
    19ba:	eb2080e7          	jalr	-334(ra) # 5868 <exit>

00000000000019be <twochildren>:
{
    19be:	1101                	addi	sp,sp,-32
    19c0:	ec06                	sd	ra,24(sp)
    19c2:	e822                	sd	s0,16(sp)
    19c4:	e426                	sd	s1,8(sp)
    19c6:	e04a                	sd	s2,0(sp)
    19c8:	1000                	addi	s0,sp,32
    19ca:	892a                	mv	s2,a0
    19cc:	3e800493          	li	s1,1000
    int pid1 = fork();
    19d0:	00004097          	auipc	ra,0x4
    19d4:	e90080e7          	jalr	-368(ra) # 5860 <fork>
    if(pid1 < 0){
    19d8:	02054c63          	bltz	a0,1a10 <twochildren+0x52>
    if(pid1 == 0){
    19dc:	c921                	beqz	a0,1a2c <twochildren+0x6e>
      int pid2 = fork();
    19de:	00004097          	auipc	ra,0x4
    19e2:	e82080e7          	jalr	-382(ra) # 5860 <fork>
      if(pid2 < 0){
    19e6:	04054763          	bltz	a0,1a34 <twochildren+0x76>
      if(pid2 == 0){
    19ea:	c13d                	beqz	a0,1a50 <twochildren+0x92>
        wait(0);
    19ec:	4501                	li	a0,0
    19ee:	00004097          	auipc	ra,0x4
    19f2:	e82080e7          	jalr	-382(ra) # 5870 <wait>
        wait(0);
    19f6:	4501                	li	a0,0
    19f8:	00004097          	auipc	ra,0x4
    19fc:	e78080e7          	jalr	-392(ra) # 5870 <wait>
  for(int i = 0; i < 1000; i++){
    1a00:	34fd                	addiw	s1,s1,-1
    1a02:	f4f9                	bnez	s1,19d0 <twochildren+0x12>
}
    1a04:	60e2                	ld	ra,24(sp)
    1a06:	6442                	ld	s0,16(sp)
    1a08:	64a2                	ld	s1,8(sp)
    1a0a:	6902                	ld	s2,0(sp)
    1a0c:	6105                	addi	sp,sp,32
    1a0e:	8082                	ret
      printf("%s: fork failed\n", s);
    1a10:	85ca                	mv	a1,s2
    1a12:	00005517          	auipc	a0,0x5
    1a16:	f6e50513          	addi	a0,a0,-146 # 6980 <malloc+0xcb6>
    1a1a:	00004097          	auipc	ra,0x4
    1a1e:	1f2080e7          	jalr	498(ra) # 5c0c <printf>
      exit(1);
    1a22:	4505                	li	a0,1
    1a24:	00004097          	auipc	ra,0x4
    1a28:	e44080e7          	jalr	-444(ra) # 5868 <exit>
      exit(0);
    1a2c:	00004097          	auipc	ra,0x4
    1a30:	e3c080e7          	jalr	-452(ra) # 5868 <exit>
        printf("%s: fork failed\n", s);
    1a34:	85ca                	mv	a1,s2
    1a36:	00005517          	auipc	a0,0x5
    1a3a:	f4a50513          	addi	a0,a0,-182 # 6980 <malloc+0xcb6>
    1a3e:	00004097          	auipc	ra,0x4
    1a42:	1ce080e7          	jalr	462(ra) # 5c0c <printf>
        exit(1);
    1a46:	4505                	li	a0,1
    1a48:	00004097          	auipc	ra,0x4
    1a4c:	e20080e7          	jalr	-480(ra) # 5868 <exit>
        exit(0);
    1a50:	00004097          	auipc	ra,0x4
    1a54:	e18080e7          	jalr	-488(ra) # 5868 <exit>

0000000000001a58 <forkfork>:
{
    1a58:	7179                	addi	sp,sp,-48
    1a5a:	f406                	sd	ra,40(sp)
    1a5c:	f022                	sd	s0,32(sp)
    1a5e:	ec26                	sd	s1,24(sp)
    1a60:	1800                	addi	s0,sp,48
    1a62:	84aa                	mv	s1,a0
    int pid = fork();
    1a64:	00004097          	auipc	ra,0x4
    1a68:	dfc080e7          	jalr	-516(ra) # 5860 <fork>
    if(pid < 0){
    1a6c:	04054163          	bltz	a0,1aae <forkfork+0x56>
    if(pid == 0){
    1a70:	cd29                	beqz	a0,1aca <forkfork+0x72>
    int pid = fork();
    1a72:	00004097          	auipc	ra,0x4
    1a76:	dee080e7          	jalr	-530(ra) # 5860 <fork>
    if(pid < 0){
    1a7a:	02054a63          	bltz	a0,1aae <forkfork+0x56>
    if(pid == 0){
    1a7e:	c531                	beqz	a0,1aca <forkfork+0x72>
    wait(&xstatus);
    1a80:	fdc40513          	addi	a0,s0,-36
    1a84:	00004097          	auipc	ra,0x4
    1a88:	dec080e7          	jalr	-532(ra) # 5870 <wait>
    if(xstatus != 0) {
    1a8c:	fdc42783          	lw	a5,-36(s0)
    1a90:	ebbd                	bnez	a5,1b06 <forkfork+0xae>
    wait(&xstatus);
    1a92:	fdc40513          	addi	a0,s0,-36
    1a96:	00004097          	auipc	ra,0x4
    1a9a:	dda080e7          	jalr	-550(ra) # 5870 <wait>
    if(xstatus != 0) {
    1a9e:	fdc42783          	lw	a5,-36(s0)
    1aa2:	e3b5                	bnez	a5,1b06 <forkfork+0xae>
}
    1aa4:	70a2                	ld	ra,40(sp)
    1aa6:	7402                	ld	s0,32(sp)
    1aa8:	64e2                	ld	s1,24(sp)
    1aaa:	6145                	addi	sp,sp,48
    1aac:	8082                	ret
      printf("%s: fork failed", s);
    1aae:	85a6                	mv	a1,s1
    1ab0:	00005517          	auipc	a0,0x5
    1ab4:	09050513          	addi	a0,a0,144 # 6b40 <malloc+0xe76>
    1ab8:	00004097          	auipc	ra,0x4
    1abc:	154080e7          	jalr	340(ra) # 5c0c <printf>
      exit(1);
    1ac0:	4505                	li	a0,1
    1ac2:	00004097          	auipc	ra,0x4
    1ac6:	da6080e7          	jalr	-602(ra) # 5868 <exit>
{
    1aca:	0c800493          	li	s1,200
        int pid1 = fork();
    1ace:	00004097          	auipc	ra,0x4
    1ad2:	d92080e7          	jalr	-622(ra) # 5860 <fork>
        if(pid1 < 0){
    1ad6:	00054f63          	bltz	a0,1af4 <forkfork+0x9c>
        if(pid1 == 0){
    1ada:	c115                	beqz	a0,1afe <forkfork+0xa6>
        wait(0);
    1adc:	4501                	li	a0,0
    1ade:	00004097          	auipc	ra,0x4
    1ae2:	d92080e7          	jalr	-622(ra) # 5870 <wait>
      for(int j = 0; j < 200; j++){
    1ae6:	34fd                	addiw	s1,s1,-1
    1ae8:	f0fd                	bnez	s1,1ace <forkfork+0x76>
      exit(0);
    1aea:	4501                	li	a0,0
    1aec:	00004097          	auipc	ra,0x4
    1af0:	d7c080e7          	jalr	-644(ra) # 5868 <exit>
          exit(1);
    1af4:	4505                	li	a0,1
    1af6:	00004097          	auipc	ra,0x4
    1afa:	d72080e7          	jalr	-654(ra) # 5868 <exit>
          exit(0);
    1afe:	00004097          	auipc	ra,0x4
    1b02:	d6a080e7          	jalr	-662(ra) # 5868 <exit>
      printf("%s: fork in child failed", s);
    1b06:	85a6                	mv	a1,s1
    1b08:	00005517          	auipc	a0,0x5
    1b0c:	04850513          	addi	a0,a0,72 # 6b50 <malloc+0xe86>
    1b10:	00004097          	auipc	ra,0x4
    1b14:	0fc080e7          	jalr	252(ra) # 5c0c <printf>
      exit(1);
    1b18:	4505                	li	a0,1
    1b1a:	00004097          	auipc	ra,0x4
    1b1e:	d4e080e7          	jalr	-690(ra) # 5868 <exit>

0000000000001b22 <reparent2>:
{
    1b22:	1101                	addi	sp,sp,-32
    1b24:	ec06                	sd	ra,24(sp)
    1b26:	e822                	sd	s0,16(sp)
    1b28:	e426                	sd	s1,8(sp)
    1b2a:	1000                	addi	s0,sp,32
    1b2c:	32000493          	li	s1,800
    int pid1 = fork();
    1b30:	00004097          	auipc	ra,0x4
    1b34:	d30080e7          	jalr	-720(ra) # 5860 <fork>
    if(pid1 < 0){
    1b38:	00054f63          	bltz	a0,1b56 <reparent2+0x34>
    if(pid1 == 0){
    1b3c:	c915                	beqz	a0,1b70 <reparent2+0x4e>
    wait(0);
    1b3e:	4501                	li	a0,0
    1b40:	00004097          	auipc	ra,0x4
    1b44:	d30080e7          	jalr	-720(ra) # 5870 <wait>
  for(int i = 0; i < 800; i++){
    1b48:	34fd                	addiw	s1,s1,-1
    1b4a:	f0fd                	bnez	s1,1b30 <reparent2+0xe>
  exit(0);
    1b4c:	4501                	li	a0,0
    1b4e:	00004097          	auipc	ra,0x4
    1b52:	d1a080e7          	jalr	-742(ra) # 5868 <exit>
      printf("fork failed\n");
    1b56:	00005517          	auipc	a0,0x5
    1b5a:	24a50513          	addi	a0,a0,586 # 6da0 <malloc+0x10d6>
    1b5e:	00004097          	auipc	ra,0x4
    1b62:	0ae080e7          	jalr	174(ra) # 5c0c <printf>
      exit(1);
    1b66:	4505                	li	a0,1
    1b68:	00004097          	auipc	ra,0x4
    1b6c:	d00080e7          	jalr	-768(ra) # 5868 <exit>
      fork();
    1b70:	00004097          	auipc	ra,0x4
    1b74:	cf0080e7          	jalr	-784(ra) # 5860 <fork>
      fork();
    1b78:	00004097          	auipc	ra,0x4
    1b7c:	ce8080e7          	jalr	-792(ra) # 5860 <fork>
      exit(0);
    1b80:	4501                	li	a0,0
    1b82:	00004097          	auipc	ra,0x4
    1b86:	ce6080e7          	jalr	-794(ra) # 5868 <exit>

0000000000001b8a <createdelete>:
{
    1b8a:	7175                	addi	sp,sp,-144
    1b8c:	e506                	sd	ra,136(sp)
    1b8e:	e122                	sd	s0,128(sp)
    1b90:	fca6                	sd	s1,120(sp)
    1b92:	f8ca                	sd	s2,112(sp)
    1b94:	f4ce                	sd	s3,104(sp)
    1b96:	f0d2                	sd	s4,96(sp)
    1b98:	ecd6                	sd	s5,88(sp)
    1b9a:	e8da                	sd	s6,80(sp)
    1b9c:	e4de                	sd	s7,72(sp)
    1b9e:	e0e2                	sd	s8,64(sp)
    1ba0:	fc66                	sd	s9,56(sp)
    1ba2:	0900                	addi	s0,sp,144
    1ba4:	8caa                	mv	s9,a0
  for(pi = 0; pi < NCHILD; pi++){
    1ba6:	4901                	li	s2,0
    1ba8:	4991                	li	s3,4
    pid = fork();
    1baa:	00004097          	auipc	ra,0x4
    1bae:	cb6080e7          	jalr	-842(ra) # 5860 <fork>
    1bb2:	84aa                	mv	s1,a0
    if(pid < 0){
    1bb4:	02054f63          	bltz	a0,1bf2 <createdelete+0x68>
    if(pid == 0){
    1bb8:	c939                	beqz	a0,1c0e <createdelete+0x84>
  for(pi = 0; pi < NCHILD; pi++){
    1bba:	2905                	addiw	s2,s2,1
    1bbc:	ff3917e3          	bne	s2,s3,1baa <createdelete+0x20>
    1bc0:	4491                	li	s1,4
    wait(&xstatus);
    1bc2:	f7c40513          	addi	a0,s0,-132
    1bc6:	00004097          	auipc	ra,0x4
    1bca:	caa080e7          	jalr	-854(ra) # 5870 <wait>
    if(xstatus != 0)
    1bce:	f7c42903          	lw	s2,-132(s0)
    1bd2:	0e091263          	bnez	s2,1cb6 <createdelete+0x12c>
  for(pi = 0; pi < NCHILD; pi++){
    1bd6:	34fd                	addiw	s1,s1,-1
    1bd8:	f4ed                	bnez	s1,1bc2 <createdelete+0x38>
  name[0] = name[1] = name[2] = 0;
    1bda:	f8040123          	sb	zero,-126(s0)
    1bde:	03000993          	li	s3,48
    1be2:	5a7d                	li	s4,-1
    1be4:	07000c13          	li	s8,112
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1be8:	4b21                	li	s6,8
      if((i == 0 || i >= N/2) && fd < 0){
    1bea:	4ba5                	li	s7,9
    for(pi = 0; pi < NCHILD; pi++){
    1bec:	07400a93          	li	s5,116
    1bf0:	a29d                	j	1d56 <createdelete+0x1cc>
      printf("fork failed\n", s);
    1bf2:	85e6                	mv	a1,s9
    1bf4:	00005517          	auipc	a0,0x5
    1bf8:	1ac50513          	addi	a0,a0,428 # 6da0 <malloc+0x10d6>
    1bfc:	00004097          	auipc	ra,0x4
    1c00:	010080e7          	jalr	16(ra) # 5c0c <printf>
      exit(1);
    1c04:	4505                	li	a0,1
    1c06:	00004097          	auipc	ra,0x4
    1c0a:	c62080e7          	jalr	-926(ra) # 5868 <exit>
      name[0] = 'p' + pi;
    1c0e:	0709091b          	addiw	s2,s2,112
    1c12:	f9240023          	sb	s2,-128(s0)
      name[2] = '\0';
    1c16:	f8040123          	sb	zero,-126(s0)
      for(i = 0; i < N; i++){
    1c1a:	4951                	li	s2,20
    1c1c:	a015                	j	1c40 <createdelete+0xb6>
          printf("%s: create failed\n", s);
    1c1e:	85e6                	mv	a1,s9
    1c20:	00005517          	auipc	a0,0x5
    1c24:	df850513          	addi	a0,a0,-520 # 6a18 <malloc+0xd4e>
    1c28:	00004097          	auipc	ra,0x4
    1c2c:	fe4080e7          	jalr	-28(ra) # 5c0c <printf>
          exit(1);
    1c30:	4505                	li	a0,1
    1c32:	00004097          	auipc	ra,0x4
    1c36:	c36080e7          	jalr	-970(ra) # 5868 <exit>
      for(i = 0; i < N; i++){
    1c3a:	2485                	addiw	s1,s1,1
    1c3c:	07248863          	beq	s1,s2,1cac <createdelete+0x122>
        name[1] = '0' + i;
    1c40:	0304879b          	addiw	a5,s1,48
    1c44:	f8f400a3          	sb	a5,-127(s0)
        fd = open(name, O_CREATE | O_RDWR);
    1c48:	20200593          	li	a1,514
    1c4c:	f8040513          	addi	a0,s0,-128
    1c50:	00004097          	auipc	ra,0x4
    1c54:	c58080e7          	jalr	-936(ra) # 58a8 <open>
        if(fd < 0){
    1c58:	fc0543e3          	bltz	a0,1c1e <createdelete+0x94>
        close(fd);
    1c5c:	00004097          	auipc	ra,0x4
    1c60:	c34080e7          	jalr	-972(ra) # 5890 <close>
        if(i > 0 && (i % 2 ) == 0){
    1c64:	fc905be3          	blez	s1,1c3a <createdelete+0xb0>
    1c68:	0014f793          	andi	a5,s1,1
    1c6c:	f7f9                	bnez	a5,1c3a <createdelete+0xb0>
          name[1] = '0' + (i / 2);
    1c6e:	01f4d79b          	srliw	a5,s1,0x1f
    1c72:	9fa5                	addw	a5,a5,s1
    1c74:	4017d79b          	sraiw	a5,a5,0x1
    1c78:	0307879b          	addiw	a5,a5,48
    1c7c:	f8f400a3          	sb	a5,-127(s0)
          if(unlink(name) < 0){
    1c80:	f8040513          	addi	a0,s0,-128
    1c84:	00004097          	auipc	ra,0x4
    1c88:	c34080e7          	jalr	-972(ra) # 58b8 <unlink>
    1c8c:	fa0557e3          	bgez	a0,1c3a <createdelete+0xb0>
            printf("%s: unlink failed\n", s);
    1c90:	85e6                	mv	a1,s9
    1c92:	00005517          	auipc	a0,0x5
    1c96:	ede50513          	addi	a0,a0,-290 # 6b70 <malloc+0xea6>
    1c9a:	00004097          	auipc	ra,0x4
    1c9e:	f72080e7          	jalr	-142(ra) # 5c0c <printf>
            exit(1);
    1ca2:	4505                	li	a0,1
    1ca4:	00004097          	auipc	ra,0x4
    1ca8:	bc4080e7          	jalr	-1084(ra) # 5868 <exit>
      exit(0);
    1cac:	4501                	li	a0,0
    1cae:	00004097          	auipc	ra,0x4
    1cb2:	bba080e7          	jalr	-1094(ra) # 5868 <exit>
      exit(1);
    1cb6:	4505                	li	a0,1
    1cb8:	00004097          	auipc	ra,0x4
    1cbc:	bb0080e7          	jalr	-1104(ra) # 5868 <exit>
        printf("%s: oops createdelete %s didn't exist\n", s, name);
    1cc0:	f8040613          	addi	a2,s0,-128
    1cc4:	85e6                	mv	a1,s9
    1cc6:	00005517          	auipc	a0,0x5
    1cca:	ec250513          	addi	a0,a0,-318 # 6b88 <malloc+0xebe>
    1cce:	00004097          	auipc	ra,0x4
    1cd2:	f3e080e7          	jalr	-194(ra) # 5c0c <printf>
        exit(1);
    1cd6:	4505                	li	a0,1
    1cd8:	00004097          	auipc	ra,0x4
    1cdc:	b90080e7          	jalr	-1136(ra) # 5868 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1ce0:	054b7163          	bgeu	s6,s4,1d22 <createdelete+0x198>
      if(fd >= 0)
    1ce4:	02055a63          	bgez	a0,1d18 <createdelete+0x18e>
    for(pi = 0; pi < NCHILD; pi++){
    1ce8:	2485                	addiw	s1,s1,1
    1cea:	0ff4f493          	andi	s1,s1,255
    1cee:	05548c63          	beq	s1,s5,1d46 <createdelete+0x1bc>
      name[0] = 'p' + pi;
    1cf2:	f8940023          	sb	s1,-128(s0)
      name[1] = '0' + i;
    1cf6:	f93400a3          	sb	s3,-127(s0)
      fd = open(name, 0);
    1cfa:	4581                	li	a1,0
    1cfc:	f8040513          	addi	a0,s0,-128
    1d00:	00004097          	auipc	ra,0x4
    1d04:	ba8080e7          	jalr	-1112(ra) # 58a8 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    1d08:	00090463          	beqz	s2,1d10 <createdelete+0x186>
    1d0c:	fd2bdae3          	bge	s7,s2,1ce0 <createdelete+0x156>
    1d10:	fa0548e3          	bltz	a0,1cc0 <createdelete+0x136>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1d14:	014b7963          	bgeu	s6,s4,1d26 <createdelete+0x19c>
        close(fd);
    1d18:	00004097          	auipc	ra,0x4
    1d1c:	b78080e7          	jalr	-1160(ra) # 5890 <close>
    1d20:	b7e1                	j	1ce8 <createdelete+0x15e>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1d22:	fc0543e3          	bltz	a0,1ce8 <createdelete+0x15e>
        printf("%s: oops createdelete %s did exist\n", s, name);
    1d26:	f8040613          	addi	a2,s0,-128
    1d2a:	85e6                	mv	a1,s9
    1d2c:	00005517          	auipc	a0,0x5
    1d30:	e8450513          	addi	a0,a0,-380 # 6bb0 <malloc+0xee6>
    1d34:	00004097          	auipc	ra,0x4
    1d38:	ed8080e7          	jalr	-296(ra) # 5c0c <printf>
        exit(1);
    1d3c:	4505                	li	a0,1
    1d3e:	00004097          	auipc	ra,0x4
    1d42:	b2a080e7          	jalr	-1238(ra) # 5868 <exit>
  for(i = 0; i < N; i++){
    1d46:	2905                	addiw	s2,s2,1
    1d48:	2a05                	addiw	s4,s4,1
    1d4a:	2985                	addiw	s3,s3,1
    1d4c:	0ff9f993          	andi	s3,s3,255
    1d50:	47d1                	li	a5,20
    1d52:	02f90a63          	beq	s2,a5,1d86 <createdelete+0x1fc>
    for(pi = 0; pi < NCHILD; pi++){
    1d56:	84e2                	mv	s1,s8
    1d58:	bf69                	j	1cf2 <createdelete+0x168>
  for(i = 0; i < N; i++){
    1d5a:	2905                	addiw	s2,s2,1
    1d5c:	0ff97913          	andi	s2,s2,255
    1d60:	2985                	addiw	s3,s3,1
    1d62:	0ff9f993          	andi	s3,s3,255
    1d66:	03490863          	beq	s2,s4,1d96 <createdelete+0x20c>
  name[0] = name[1] = name[2] = 0;
    1d6a:	84d6                	mv	s1,s5
      name[0] = 'p' + i;
    1d6c:	f9240023          	sb	s2,-128(s0)
      name[1] = '0' + i;
    1d70:	f93400a3          	sb	s3,-127(s0)
      unlink(name);
    1d74:	f8040513          	addi	a0,s0,-128
    1d78:	00004097          	auipc	ra,0x4
    1d7c:	b40080e7          	jalr	-1216(ra) # 58b8 <unlink>
    for(pi = 0; pi < NCHILD; pi++){
    1d80:	34fd                	addiw	s1,s1,-1
    1d82:	f4ed                	bnez	s1,1d6c <createdelete+0x1e2>
    1d84:	bfd9                	j	1d5a <createdelete+0x1d0>
    1d86:	03000993          	li	s3,48
    1d8a:	07000913          	li	s2,112
  name[0] = name[1] = name[2] = 0;
    1d8e:	4a91                	li	s5,4
  for(i = 0; i < N; i++){
    1d90:	08400a13          	li	s4,132
    1d94:	bfd9                	j	1d6a <createdelete+0x1e0>
}
    1d96:	60aa                	ld	ra,136(sp)
    1d98:	640a                	ld	s0,128(sp)
    1d9a:	74e6                	ld	s1,120(sp)
    1d9c:	7946                	ld	s2,112(sp)
    1d9e:	79a6                	ld	s3,104(sp)
    1da0:	7a06                	ld	s4,96(sp)
    1da2:	6ae6                	ld	s5,88(sp)
    1da4:	6b46                	ld	s6,80(sp)
    1da6:	6ba6                	ld	s7,72(sp)
    1da8:	6c06                	ld	s8,64(sp)
    1daa:	7ce2                	ld	s9,56(sp)
    1dac:	6149                	addi	sp,sp,144
    1dae:	8082                	ret

0000000000001db0 <linkunlink>:
{
    1db0:	711d                	addi	sp,sp,-96
    1db2:	ec86                	sd	ra,88(sp)
    1db4:	e8a2                	sd	s0,80(sp)
    1db6:	e4a6                	sd	s1,72(sp)
    1db8:	e0ca                	sd	s2,64(sp)
    1dba:	fc4e                	sd	s3,56(sp)
    1dbc:	f852                	sd	s4,48(sp)
    1dbe:	f456                	sd	s5,40(sp)
    1dc0:	f05a                	sd	s6,32(sp)
    1dc2:	ec5e                	sd	s7,24(sp)
    1dc4:	e862                	sd	s8,16(sp)
    1dc6:	e466                	sd	s9,8(sp)
    1dc8:	1080                	addi	s0,sp,96
    1dca:	84aa                	mv	s1,a0
  unlink("x");
    1dcc:	00004517          	auipc	a0,0x4
    1dd0:	3ec50513          	addi	a0,a0,1004 # 61b8 <malloc+0x4ee>
    1dd4:	00004097          	auipc	ra,0x4
    1dd8:	ae4080e7          	jalr	-1308(ra) # 58b8 <unlink>
  pid = fork();
    1ddc:	00004097          	auipc	ra,0x4
    1de0:	a84080e7          	jalr	-1404(ra) # 5860 <fork>
  if(pid < 0){
    1de4:	02054b63          	bltz	a0,1e1a <linkunlink+0x6a>
    1de8:	8c2a                	mv	s8,a0
  unsigned int x = (pid ? 1 : 97);
    1dea:	4c85                	li	s9,1
    1dec:	e119                	bnez	a0,1df2 <linkunlink+0x42>
    1dee:	06100c93          	li	s9,97
    1df2:	06400493          	li	s1,100
    x = x * 1103515245 + 12345;
    1df6:	41c659b7          	lui	s3,0x41c65
    1dfa:	e6d9899b          	addiw	s3,s3,-403
    1dfe:	690d                	lui	s2,0x3
    1e00:	0399091b          	addiw	s2,s2,57
    if((x % 3) == 0){
    1e04:	4a0d                	li	s4,3
    } else if((x % 3) == 1){
    1e06:	4b05                	li	s6,1
      unlink("x");
    1e08:	00004a97          	auipc	s5,0x4
    1e0c:	3b0a8a93          	addi	s5,s5,944 # 61b8 <malloc+0x4ee>
      link("cat", "x");
    1e10:	00005b97          	auipc	s7,0x5
    1e14:	dc8b8b93          	addi	s7,s7,-568 # 6bd8 <malloc+0xf0e>
    1e18:	a091                	j	1e5c <linkunlink+0xac>
    printf("%s: fork failed\n", s);
    1e1a:	85a6                	mv	a1,s1
    1e1c:	00005517          	auipc	a0,0x5
    1e20:	b6450513          	addi	a0,a0,-1180 # 6980 <malloc+0xcb6>
    1e24:	00004097          	auipc	ra,0x4
    1e28:	de8080e7          	jalr	-536(ra) # 5c0c <printf>
    exit(1);
    1e2c:	4505                	li	a0,1
    1e2e:	00004097          	auipc	ra,0x4
    1e32:	a3a080e7          	jalr	-1478(ra) # 5868 <exit>
      close(open("x", O_RDWR | O_CREATE));
    1e36:	20200593          	li	a1,514
    1e3a:	8556                	mv	a0,s5
    1e3c:	00004097          	auipc	ra,0x4
    1e40:	a6c080e7          	jalr	-1428(ra) # 58a8 <open>
    1e44:	00004097          	auipc	ra,0x4
    1e48:	a4c080e7          	jalr	-1460(ra) # 5890 <close>
    1e4c:	a031                	j	1e58 <linkunlink+0xa8>
      unlink("x");
    1e4e:	8556                	mv	a0,s5
    1e50:	00004097          	auipc	ra,0x4
    1e54:	a68080e7          	jalr	-1432(ra) # 58b8 <unlink>
  for(i = 0; i < 100; i++){
    1e58:	34fd                	addiw	s1,s1,-1
    1e5a:	c09d                	beqz	s1,1e80 <linkunlink+0xd0>
    x = x * 1103515245 + 12345;
    1e5c:	033c87bb          	mulw	a5,s9,s3
    1e60:	012787bb          	addw	a5,a5,s2
    1e64:	00078c9b          	sext.w	s9,a5
    if((x % 3) == 0){
    1e68:	0347f7bb          	remuw	a5,a5,s4
    1e6c:	d7e9                	beqz	a5,1e36 <linkunlink+0x86>
    } else if((x % 3) == 1){
    1e6e:	ff6790e3          	bne	a5,s6,1e4e <linkunlink+0x9e>
      link("cat", "x");
    1e72:	85d6                	mv	a1,s5
    1e74:	855e                	mv	a0,s7
    1e76:	00004097          	auipc	ra,0x4
    1e7a:	a52080e7          	jalr	-1454(ra) # 58c8 <link>
    1e7e:	bfe9                	j	1e58 <linkunlink+0xa8>
  if(pid)
    1e80:	020c0463          	beqz	s8,1ea8 <linkunlink+0xf8>
    wait(0);
    1e84:	4501                	li	a0,0
    1e86:	00004097          	auipc	ra,0x4
    1e8a:	9ea080e7          	jalr	-1558(ra) # 5870 <wait>
}
    1e8e:	60e6                	ld	ra,88(sp)
    1e90:	6446                	ld	s0,80(sp)
    1e92:	64a6                	ld	s1,72(sp)
    1e94:	6906                	ld	s2,64(sp)
    1e96:	79e2                	ld	s3,56(sp)
    1e98:	7a42                	ld	s4,48(sp)
    1e9a:	7aa2                	ld	s5,40(sp)
    1e9c:	7b02                	ld	s6,32(sp)
    1e9e:	6be2                	ld	s7,24(sp)
    1ea0:	6c42                	ld	s8,16(sp)
    1ea2:	6ca2                	ld	s9,8(sp)
    1ea4:	6125                	addi	sp,sp,96
    1ea6:	8082                	ret
    exit(0);
    1ea8:	4501                	li	a0,0
    1eaa:	00004097          	auipc	ra,0x4
    1eae:	9be080e7          	jalr	-1602(ra) # 5868 <exit>

0000000000001eb2 <manywrites>:
{
    1eb2:	711d                	addi	sp,sp,-96
    1eb4:	ec86                	sd	ra,88(sp)
    1eb6:	e8a2                	sd	s0,80(sp)
    1eb8:	e4a6                	sd	s1,72(sp)
    1eba:	e0ca                	sd	s2,64(sp)
    1ebc:	fc4e                	sd	s3,56(sp)
    1ebe:	f852                	sd	s4,48(sp)
    1ec0:	f456                	sd	s5,40(sp)
    1ec2:	f05a                	sd	s6,32(sp)
    1ec4:	ec5e                	sd	s7,24(sp)
    1ec6:	1080                	addi	s0,sp,96
    1ec8:	8aaa                	mv	s5,a0
  for(int ci = 0; ci < nchildren; ci++){
    1eca:	4901                	li	s2,0
    1ecc:	4991                	li	s3,4
    int pid = fork();
    1ece:	00004097          	auipc	ra,0x4
    1ed2:	992080e7          	jalr	-1646(ra) # 5860 <fork>
    1ed6:	84aa                	mv	s1,a0
    if(pid < 0){
    1ed8:	02054963          	bltz	a0,1f0a <manywrites+0x58>
    if(pid == 0){
    1edc:	c521                	beqz	a0,1f24 <manywrites+0x72>
  for(int ci = 0; ci < nchildren; ci++){
    1ede:	2905                	addiw	s2,s2,1
    1ee0:	ff3917e3          	bne	s2,s3,1ece <manywrites+0x1c>
    1ee4:	4491                	li	s1,4
    int st = 0;
    1ee6:	fa042423          	sw	zero,-88(s0)
    wait(&st);
    1eea:	fa840513          	addi	a0,s0,-88
    1eee:	00004097          	auipc	ra,0x4
    1ef2:	982080e7          	jalr	-1662(ra) # 5870 <wait>
    if(st != 0)
    1ef6:	fa842503          	lw	a0,-88(s0)
    1efa:	ed6d                	bnez	a0,1ff4 <manywrites+0x142>
  for(int ci = 0; ci < nchildren; ci++){
    1efc:	34fd                	addiw	s1,s1,-1
    1efe:	f4e5                	bnez	s1,1ee6 <manywrites+0x34>
  exit(0);
    1f00:	4501                	li	a0,0
    1f02:	00004097          	auipc	ra,0x4
    1f06:	966080e7          	jalr	-1690(ra) # 5868 <exit>
      printf("fork failed\n");
    1f0a:	00005517          	auipc	a0,0x5
    1f0e:	e9650513          	addi	a0,a0,-362 # 6da0 <malloc+0x10d6>
    1f12:	00004097          	auipc	ra,0x4
    1f16:	cfa080e7          	jalr	-774(ra) # 5c0c <printf>
      exit(1);
    1f1a:	4505                	li	a0,1
    1f1c:	00004097          	auipc	ra,0x4
    1f20:	94c080e7          	jalr	-1716(ra) # 5868 <exit>
      name[0] = 'b';
    1f24:	06200793          	li	a5,98
    1f28:	faf40423          	sb	a5,-88(s0)
      name[1] = 'a' + ci;
    1f2c:	0619079b          	addiw	a5,s2,97
    1f30:	faf404a3          	sb	a5,-87(s0)
      name[2] = '\0';
    1f34:	fa040523          	sb	zero,-86(s0)
      unlink(name);
    1f38:	fa840513          	addi	a0,s0,-88
    1f3c:	00004097          	auipc	ra,0x4
    1f40:	97c080e7          	jalr	-1668(ra) # 58b8 <unlink>
    1f44:	4b79                	li	s6,30
          int cc = write(fd, buf, sz);
    1f46:	0000ab97          	auipc	s7,0xa
    1f4a:	e8ab8b93          	addi	s7,s7,-374 # bdd0 <buf>
        for(int i = 0; i < ci+1; i++){
    1f4e:	8a26                	mv	s4,s1
    1f50:	02094e63          	bltz	s2,1f8c <manywrites+0xda>
          int fd = open(name, O_CREATE | O_RDWR);
    1f54:	20200593          	li	a1,514
    1f58:	fa840513          	addi	a0,s0,-88
    1f5c:	00004097          	auipc	ra,0x4
    1f60:	94c080e7          	jalr	-1716(ra) # 58a8 <open>
    1f64:	89aa                	mv	s3,a0
          if(fd < 0){
    1f66:	04054763          	bltz	a0,1fb4 <manywrites+0x102>
          int cc = write(fd, buf, sz);
    1f6a:	660d                	lui	a2,0x3
    1f6c:	85de                	mv	a1,s7
    1f6e:	00004097          	auipc	ra,0x4
    1f72:	91a080e7          	jalr	-1766(ra) # 5888 <write>
          if(cc != sz){
    1f76:	678d                	lui	a5,0x3
    1f78:	04f51e63          	bne	a0,a5,1fd4 <manywrites+0x122>
          close(fd);
    1f7c:	854e                	mv	a0,s3
    1f7e:	00004097          	auipc	ra,0x4
    1f82:	912080e7          	jalr	-1774(ra) # 5890 <close>
        for(int i = 0; i < ci+1; i++){
    1f86:	2a05                	addiw	s4,s4,1
    1f88:	fd4956e3          	bge	s2,s4,1f54 <manywrites+0xa2>
        unlink(name);
    1f8c:	fa840513          	addi	a0,s0,-88
    1f90:	00004097          	auipc	ra,0x4
    1f94:	928080e7          	jalr	-1752(ra) # 58b8 <unlink>
      for(int iters = 0; iters < howmany; iters++){
    1f98:	3b7d                	addiw	s6,s6,-1
    1f9a:	fa0b1ae3          	bnez	s6,1f4e <manywrites+0x9c>
      unlink(name);
    1f9e:	fa840513          	addi	a0,s0,-88
    1fa2:	00004097          	auipc	ra,0x4
    1fa6:	916080e7          	jalr	-1770(ra) # 58b8 <unlink>
      exit(0);
    1faa:	4501                	li	a0,0
    1fac:	00004097          	auipc	ra,0x4
    1fb0:	8bc080e7          	jalr	-1860(ra) # 5868 <exit>
            printf("%s: cannot create %s\n", s, name);
    1fb4:	fa840613          	addi	a2,s0,-88
    1fb8:	85d6                	mv	a1,s5
    1fba:	00005517          	auipc	a0,0x5
    1fbe:	c2650513          	addi	a0,a0,-986 # 6be0 <malloc+0xf16>
    1fc2:	00004097          	auipc	ra,0x4
    1fc6:	c4a080e7          	jalr	-950(ra) # 5c0c <printf>
            exit(1);
    1fca:	4505                	li	a0,1
    1fcc:	00004097          	auipc	ra,0x4
    1fd0:	89c080e7          	jalr	-1892(ra) # 5868 <exit>
            printf("%s: write(%d) ret %d\n", s, sz, cc);
    1fd4:	86aa                	mv	a3,a0
    1fd6:	660d                	lui	a2,0x3
    1fd8:	85d6                	mv	a1,s5
    1fda:	00004517          	auipc	a0,0x4
    1fde:	22e50513          	addi	a0,a0,558 # 6208 <malloc+0x53e>
    1fe2:	00004097          	auipc	ra,0x4
    1fe6:	c2a080e7          	jalr	-982(ra) # 5c0c <printf>
            exit(1);
    1fea:	4505                	li	a0,1
    1fec:	00004097          	auipc	ra,0x4
    1ff0:	87c080e7          	jalr	-1924(ra) # 5868 <exit>
      exit(st);
    1ff4:	00004097          	auipc	ra,0x4
    1ff8:	874080e7          	jalr	-1932(ra) # 5868 <exit>

0000000000001ffc <forktest>:
{
    1ffc:	7179                	addi	sp,sp,-48
    1ffe:	f406                	sd	ra,40(sp)
    2000:	f022                	sd	s0,32(sp)
    2002:	ec26                	sd	s1,24(sp)
    2004:	e84a                	sd	s2,16(sp)
    2006:	e44e                	sd	s3,8(sp)
    2008:	1800                	addi	s0,sp,48
    200a:	89aa                	mv	s3,a0
  for(n=0; n<N; n++){
    200c:	4481                	li	s1,0
    200e:	3e800913          	li	s2,1000
    pid = fork();
    2012:	00004097          	auipc	ra,0x4
    2016:	84e080e7          	jalr	-1970(ra) # 5860 <fork>
    if(pid < 0)
    201a:	02054863          	bltz	a0,204a <forktest+0x4e>
    if(pid == 0)
    201e:	c115                	beqz	a0,2042 <forktest+0x46>
  for(n=0; n<N; n++){
    2020:	2485                	addiw	s1,s1,1
    2022:	ff2498e3          	bne	s1,s2,2012 <forktest+0x16>
    printf("%s: fork claimed to work 1000 times!\n", s);
    2026:	85ce                	mv	a1,s3
    2028:	00005517          	auipc	a0,0x5
    202c:	be850513          	addi	a0,a0,-1048 # 6c10 <malloc+0xf46>
    2030:	00004097          	auipc	ra,0x4
    2034:	bdc080e7          	jalr	-1060(ra) # 5c0c <printf>
    exit(1);
    2038:	4505                	li	a0,1
    203a:	00004097          	auipc	ra,0x4
    203e:	82e080e7          	jalr	-2002(ra) # 5868 <exit>
      exit(0);
    2042:	00004097          	auipc	ra,0x4
    2046:	826080e7          	jalr	-2010(ra) # 5868 <exit>
  if (n == 0) {
    204a:	cc9d                	beqz	s1,2088 <forktest+0x8c>
  if(n == N){
    204c:	3e800793          	li	a5,1000
    2050:	fcf48be3          	beq	s1,a5,2026 <forktest+0x2a>
  for(; n > 0; n--){
    2054:	00905b63          	blez	s1,206a <forktest+0x6e>
    if(wait(0) < 0){
    2058:	4501                	li	a0,0
    205a:	00004097          	auipc	ra,0x4
    205e:	816080e7          	jalr	-2026(ra) # 5870 <wait>
    2062:	04054163          	bltz	a0,20a4 <forktest+0xa8>
  for(; n > 0; n--){
    2066:	34fd                	addiw	s1,s1,-1
    2068:	f8e5                	bnez	s1,2058 <forktest+0x5c>
  if(wait(0) != -1){
    206a:	4501                	li	a0,0
    206c:	00004097          	auipc	ra,0x4
    2070:	804080e7          	jalr	-2044(ra) # 5870 <wait>
    2074:	57fd                	li	a5,-1
    2076:	04f51563          	bne	a0,a5,20c0 <forktest+0xc4>
}
    207a:	70a2                	ld	ra,40(sp)
    207c:	7402                	ld	s0,32(sp)
    207e:	64e2                	ld	s1,24(sp)
    2080:	6942                	ld	s2,16(sp)
    2082:	69a2                	ld	s3,8(sp)
    2084:	6145                	addi	sp,sp,48
    2086:	8082                	ret
    printf("%s: no fork at all!\n", s);
    2088:	85ce                	mv	a1,s3
    208a:	00005517          	auipc	a0,0x5
    208e:	b6e50513          	addi	a0,a0,-1170 # 6bf8 <malloc+0xf2e>
    2092:	00004097          	auipc	ra,0x4
    2096:	b7a080e7          	jalr	-1158(ra) # 5c0c <printf>
    exit(1);
    209a:	4505                	li	a0,1
    209c:	00003097          	auipc	ra,0x3
    20a0:	7cc080e7          	jalr	1996(ra) # 5868 <exit>
      printf("%s: wait stopped early\n", s);
    20a4:	85ce                	mv	a1,s3
    20a6:	00005517          	auipc	a0,0x5
    20aa:	b9250513          	addi	a0,a0,-1134 # 6c38 <malloc+0xf6e>
    20ae:	00004097          	auipc	ra,0x4
    20b2:	b5e080e7          	jalr	-1186(ra) # 5c0c <printf>
      exit(1);
    20b6:	4505                	li	a0,1
    20b8:	00003097          	auipc	ra,0x3
    20bc:	7b0080e7          	jalr	1968(ra) # 5868 <exit>
    printf("%s: wait got too many\n", s);
    20c0:	85ce                	mv	a1,s3
    20c2:	00005517          	auipc	a0,0x5
    20c6:	b8e50513          	addi	a0,a0,-1138 # 6c50 <malloc+0xf86>
    20ca:	00004097          	auipc	ra,0x4
    20ce:	b42080e7          	jalr	-1214(ra) # 5c0c <printf>
    exit(1);
    20d2:	4505                	li	a0,1
    20d4:	00003097          	auipc	ra,0x3
    20d8:	794080e7          	jalr	1940(ra) # 5868 <exit>

00000000000020dc <kernmem>:
{
    20dc:	715d                	addi	sp,sp,-80
    20de:	e486                	sd	ra,72(sp)
    20e0:	e0a2                	sd	s0,64(sp)
    20e2:	fc26                	sd	s1,56(sp)
    20e4:	f84a                	sd	s2,48(sp)
    20e6:	f44e                	sd	s3,40(sp)
    20e8:	f052                	sd	s4,32(sp)
    20ea:	ec56                	sd	s5,24(sp)
    20ec:	0880                	addi	s0,sp,80
    20ee:	8a2a                	mv	s4,a0
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    20f0:	4485                	li	s1,1
    20f2:	04fe                	slli	s1,s1,0x1f
    if(xstatus != -1)  // did kernel kill child?
    20f4:	5afd                	li	s5,-1
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    20f6:	69b1                	lui	s3,0xc
    20f8:	35098993          	addi	s3,s3,848 # c350 <buf+0x580>
    20fc:	1003d937          	lui	s2,0x1003d
    2100:	090e                	slli	s2,s2,0x3
    2102:	48090913          	addi	s2,s2,1152 # 1003d480 <__BSS_END__+0x1002e6a0>
    pid = fork();
    2106:	00003097          	auipc	ra,0x3
    210a:	75a080e7          	jalr	1882(ra) # 5860 <fork>
    if(pid < 0){
    210e:	02054963          	bltz	a0,2140 <kernmem+0x64>
    if(pid == 0){
    2112:	c529                	beqz	a0,215c <kernmem+0x80>
    wait(&xstatus);
    2114:	fbc40513          	addi	a0,s0,-68
    2118:	00003097          	auipc	ra,0x3
    211c:	758080e7          	jalr	1880(ra) # 5870 <wait>
    if(xstatus != -1)  // did kernel kill child?
    2120:	fbc42783          	lw	a5,-68(s0)
    2124:	05579d63          	bne	a5,s5,217e <kernmem+0xa2>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2128:	94ce                	add	s1,s1,s3
    212a:	fd249ee3          	bne	s1,s2,2106 <kernmem+0x2a>
}
    212e:	60a6                	ld	ra,72(sp)
    2130:	6406                	ld	s0,64(sp)
    2132:	74e2                	ld	s1,56(sp)
    2134:	7942                	ld	s2,48(sp)
    2136:	79a2                	ld	s3,40(sp)
    2138:	7a02                	ld	s4,32(sp)
    213a:	6ae2                	ld	s5,24(sp)
    213c:	6161                	addi	sp,sp,80
    213e:	8082                	ret
      printf("%s: fork failed\n", s);
    2140:	85d2                	mv	a1,s4
    2142:	00005517          	auipc	a0,0x5
    2146:	83e50513          	addi	a0,a0,-1986 # 6980 <malloc+0xcb6>
    214a:	00004097          	auipc	ra,0x4
    214e:	ac2080e7          	jalr	-1342(ra) # 5c0c <printf>
      exit(1);
    2152:	4505                	li	a0,1
    2154:	00003097          	auipc	ra,0x3
    2158:	714080e7          	jalr	1812(ra) # 5868 <exit>
      printf("%s: oops could read %x = %x\n", s, a, *a);
    215c:	0004c683          	lbu	a3,0(s1)
    2160:	8626                	mv	a2,s1
    2162:	85d2                	mv	a1,s4
    2164:	00005517          	auipc	a0,0x5
    2168:	b0450513          	addi	a0,a0,-1276 # 6c68 <malloc+0xf9e>
    216c:	00004097          	auipc	ra,0x4
    2170:	aa0080e7          	jalr	-1376(ra) # 5c0c <printf>
      exit(1);
    2174:	4505                	li	a0,1
    2176:	00003097          	auipc	ra,0x3
    217a:	6f2080e7          	jalr	1778(ra) # 5868 <exit>
      exit(1);
    217e:	4505                	li	a0,1
    2180:	00003097          	auipc	ra,0x3
    2184:	6e8080e7          	jalr	1768(ra) # 5868 <exit>

0000000000002188 <MAXVAplus>:
{
    2188:	7179                	addi	sp,sp,-48
    218a:	f406                	sd	ra,40(sp)
    218c:	f022                	sd	s0,32(sp)
    218e:	ec26                	sd	s1,24(sp)
    2190:	e84a                	sd	s2,16(sp)
    2192:	1800                	addi	s0,sp,48
  volatile uint64 a = MAXVA;
    2194:	4785                	li	a5,1
    2196:	179a                	slli	a5,a5,0x26
    2198:	fcf43c23          	sd	a5,-40(s0)
  for( ; a != 0; a <<= 1){
    219c:	fd843783          	ld	a5,-40(s0)
    21a0:	cf85                	beqz	a5,21d8 <MAXVAplus+0x50>
    21a2:	892a                	mv	s2,a0
    if(xstatus != -1)  // did kernel kill child?
    21a4:	54fd                	li	s1,-1
    pid = fork();
    21a6:	00003097          	auipc	ra,0x3
    21aa:	6ba080e7          	jalr	1722(ra) # 5860 <fork>
    if(pid < 0){
    21ae:	02054b63          	bltz	a0,21e4 <MAXVAplus+0x5c>
    if(pid == 0){
    21b2:	c539                	beqz	a0,2200 <MAXVAplus+0x78>
    wait(&xstatus);
    21b4:	fd440513          	addi	a0,s0,-44
    21b8:	00003097          	auipc	ra,0x3
    21bc:	6b8080e7          	jalr	1720(ra) # 5870 <wait>
    if(xstatus != -1)  // did kernel kill child?
    21c0:	fd442783          	lw	a5,-44(s0)
    21c4:	06979463          	bne	a5,s1,222c <MAXVAplus+0xa4>
  for( ; a != 0; a <<= 1){
    21c8:	fd843783          	ld	a5,-40(s0)
    21cc:	0786                	slli	a5,a5,0x1
    21ce:	fcf43c23          	sd	a5,-40(s0)
    21d2:	fd843783          	ld	a5,-40(s0)
    21d6:	fbe1                	bnez	a5,21a6 <MAXVAplus+0x1e>
}
    21d8:	70a2                	ld	ra,40(sp)
    21da:	7402                	ld	s0,32(sp)
    21dc:	64e2                	ld	s1,24(sp)
    21de:	6942                	ld	s2,16(sp)
    21e0:	6145                	addi	sp,sp,48
    21e2:	8082                	ret
      printf("%s: fork failed\n", s);
    21e4:	85ca                	mv	a1,s2
    21e6:	00004517          	auipc	a0,0x4
    21ea:	79a50513          	addi	a0,a0,1946 # 6980 <malloc+0xcb6>
    21ee:	00004097          	auipc	ra,0x4
    21f2:	a1e080e7          	jalr	-1506(ra) # 5c0c <printf>
      exit(1);
    21f6:	4505                	li	a0,1
    21f8:	00003097          	auipc	ra,0x3
    21fc:	670080e7          	jalr	1648(ra) # 5868 <exit>
      *(char*)a = 99;
    2200:	fd843783          	ld	a5,-40(s0)
    2204:	06300713          	li	a4,99
    2208:	00e78023          	sb	a4,0(a5) # 3000 <iputtest+0x84>
      printf("%s: oops wrote %x\n", s, a);
    220c:	fd843603          	ld	a2,-40(s0)
    2210:	85ca                	mv	a1,s2
    2212:	00005517          	auipc	a0,0x5
    2216:	a7650513          	addi	a0,a0,-1418 # 6c88 <malloc+0xfbe>
    221a:	00004097          	auipc	ra,0x4
    221e:	9f2080e7          	jalr	-1550(ra) # 5c0c <printf>
      exit(1);
    2222:	4505                	li	a0,1
    2224:	00003097          	auipc	ra,0x3
    2228:	644080e7          	jalr	1604(ra) # 5868 <exit>
      exit(1);
    222c:	4505                	li	a0,1
    222e:	00003097          	auipc	ra,0x3
    2232:	63a080e7          	jalr	1594(ra) # 5868 <exit>

0000000000002236 <bigargtest>:
{
    2236:	7179                	addi	sp,sp,-48
    2238:	f406                	sd	ra,40(sp)
    223a:	f022                	sd	s0,32(sp)
    223c:	ec26                	sd	s1,24(sp)
    223e:	1800                	addi	s0,sp,48
    2240:	84aa                	mv	s1,a0
  unlink("bigarg-ok");
    2242:	00005517          	auipc	a0,0x5
    2246:	a5e50513          	addi	a0,a0,-1442 # 6ca0 <malloc+0xfd6>
    224a:	00003097          	auipc	ra,0x3
    224e:	66e080e7          	jalr	1646(ra) # 58b8 <unlink>
  pid = fork();
    2252:	00003097          	auipc	ra,0x3
    2256:	60e080e7          	jalr	1550(ra) # 5860 <fork>
  if(pid == 0){
    225a:	c121                	beqz	a0,229a <bigargtest+0x64>
  } else if(pid < 0){
    225c:	0a054063          	bltz	a0,22fc <bigargtest+0xc6>
  wait(&xstatus);
    2260:	fdc40513          	addi	a0,s0,-36
    2264:	00003097          	auipc	ra,0x3
    2268:	60c080e7          	jalr	1548(ra) # 5870 <wait>
  if(xstatus != 0)
    226c:	fdc42503          	lw	a0,-36(s0)
    2270:	e545                	bnez	a0,2318 <bigargtest+0xe2>
  fd = open("bigarg-ok", 0);
    2272:	4581                	li	a1,0
    2274:	00005517          	auipc	a0,0x5
    2278:	a2c50513          	addi	a0,a0,-1492 # 6ca0 <malloc+0xfd6>
    227c:	00003097          	auipc	ra,0x3
    2280:	62c080e7          	jalr	1580(ra) # 58a8 <open>
  if(fd < 0){
    2284:	08054e63          	bltz	a0,2320 <bigargtest+0xea>
  close(fd);
    2288:	00003097          	auipc	ra,0x3
    228c:	608080e7          	jalr	1544(ra) # 5890 <close>
}
    2290:	70a2                	ld	ra,40(sp)
    2292:	7402                	ld	s0,32(sp)
    2294:	64e2                	ld	s1,24(sp)
    2296:	6145                	addi	sp,sp,48
    2298:	8082                	ret
    229a:	00006797          	auipc	a5,0x6
    229e:	31e78793          	addi	a5,a5,798 # 85b8 <args.1877>
    22a2:	00006697          	auipc	a3,0x6
    22a6:	40e68693          	addi	a3,a3,1038 # 86b0 <args.1877+0xf8>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    22aa:	00005717          	auipc	a4,0x5
    22ae:	a0670713          	addi	a4,a4,-1530 # 6cb0 <malloc+0xfe6>
    22b2:	e398                	sd	a4,0(a5)
    for(i = 0; i < MAXARG-1; i++)
    22b4:	07a1                	addi	a5,a5,8
    22b6:	fed79ee3          	bne	a5,a3,22b2 <bigargtest+0x7c>
    args[MAXARG-1] = 0;
    22ba:	00006597          	auipc	a1,0x6
    22be:	2fe58593          	addi	a1,a1,766 # 85b8 <args.1877>
    22c2:	0e05bc23          	sd	zero,248(a1)
    exec("echo", args);
    22c6:	00004517          	auipc	a0,0x4
    22ca:	e8250513          	addi	a0,a0,-382 # 6148 <malloc+0x47e>
    22ce:	00003097          	auipc	ra,0x3
    22d2:	5d2080e7          	jalr	1490(ra) # 58a0 <exec>
    fd = open("bigarg-ok", O_CREATE);
    22d6:	20000593          	li	a1,512
    22da:	00005517          	auipc	a0,0x5
    22de:	9c650513          	addi	a0,a0,-1594 # 6ca0 <malloc+0xfd6>
    22e2:	00003097          	auipc	ra,0x3
    22e6:	5c6080e7          	jalr	1478(ra) # 58a8 <open>
    close(fd);
    22ea:	00003097          	auipc	ra,0x3
    22ee:	5a6080e7          	jalr	1446(ra) # 5890 <close>
    exit(0);
    22f2:	4501                	li	a0,0
    22f4:	00003097          	auipc	ra,0x3
    22f8:	574080e7          	jalr	1396(ra) # 5868 <exit>
    printf("%s: bigargtest: fork failed\n", s);
    22fc:	85a6                	mv	a1,s1
    22fe:	00005517          	auipc	a0,0x5
    2302:	a9250513          	addi	a0,a0,-1390 # 6d90 <malloc+0x10c6>
    2306:	00004097          	auipc	ra,0x4
    230a:	906080e7          	jalr	-1786(ra) # 5c0c <printf>
    exit(1);
    230e:	4505                	li	a0,1
    2310:	00003097          	auipc	ra,0x3
    2314:	558080e7          	jalr	1368(ra) # 5868 <exit>
    exit(xstatus);
    2318:	00003097          	auipc	ra,0x3
    231c:	550080e7          	jalr	1360(ra) # 5868 <exit>
    printf("%s: bigarg test failed!\n", s);
    2320:	85a6                	mv	a1,s1
    2322:	00005517          	auipc	a0,0x5
    2326:	a8e50513          	addi	a0,a0,-1394 # 6db0 <malloc+0x10e6>
    232a:	00004097          	auipc	ra,0x4
    232e:	8e2080e7          	jalr	-1822(ra) # 5c0c <printf>
    exit(1);
    2332:	4505                	li	a0,1
    2334:	00003097          	auipc	ra,0x3
    2338:	534080e7          	jalr	1332(ra) # 5868 <exit>

000000000000233c <stacktest>:
{
    233c:	7179                	addi	sp,sp,-48
    233e:	f406                	sd	ra,40(sp)
    2340:	f022                	sd	s0,32(sp)
    2342:	ec26                	sd	s1,24(sp)
    2344:	1800                	addi	s0,sp,48
    2346:	84aa                	mv	s1,a0
  pid = fork();
    2348:	00003097          	auipc	ra,0x3
    234c:	518080e7          	jalr	1304(ra) # 5860 <fork>
  if(pid == 0) {
    2350:	c115                	beqz	a0,2374 <stacktest+0x38>
  } else if(pid < 0){
    2352:	04054463          	bltz	a0,239a <stacktest+0x5e>
  wait(&xstatus);
    2356:	fdc40513          	addi	a0,s0,-36
    235a:	00003097          	auipc	ra,0x3
    235e:	516080e7          	jalr	1302(ra) # 5870 <wait>
  if(xstatus == -1)  // kernel killed child?
    2362:	fdc42503          	lw	a0,-36(s0)
    2366:	57fd                	li	a5,-1
    2368:	04f50763          	beq	a0,a5,23b6 <stacktest+0x7a>
    exit(xstatus);
    236c:	00003097          	auipc	ra,0x3
    2370:	4fc080e7          	jalr	1276(ra) # 5868 <exit>

static inline uint64
r_sp()
{
  uint64 x;
  asm volatile("mv %0, sp" : "=r" (x) );
    2374:	870a                	mv	a4,sp
    printf("%s: stacktest: read below stack %p\n", s, *sp);
    2376:	77fd                	lui	a5,0xfffff
    2378:	97ba                	add	a5,a5,a4
    237a:	0007c603          	lbu	a2,0(a5) # fffffffffffff000 <__BSS_END__+0xffffffffffff0220>
    237e:	85a6                	mv	a1,s1
    2380:	00005517          	auipc	a0,0x5
    2384:	a5050513          	addi	a0,a0,-1456 # 6dd0 <malloc+0x1106>
    2388:	00004097          	auipc	ra,0x4
    238c:	884080e7          	jalr	-1916(ra) # 5c0c <printf>
    exit(1);
    2390:	4505                	li	a0,1
    2392:	00003097          	auipc	ra,0x3
    2396:	4d6080e7          	jalr	1238(ra) # 5868 <exit>
    printf("%s: fork failed\n", s);
    239a:	85a6                	mv	a1,s1
    239c:	00004517          	auipc	a0,0x4
    23a0:	5e450513          	addi	a0,a0,1508 # 6980 <malloc+0xcb6>
    23a4:	00004097          	auipc	ra,0x4
    23a8:	868080e7          	jalr	-1944(ra) # 5c0c <printf>
    exit(1);
    23ac:	4505                	li	a0,1
    23ae:	00003097          	auipc	ra,0x3
    23b2:	4ba080e7          	jalr	1210(ra) # 5868 <exit>
    exit(0);
    23b6:	4501                	li	a0,0
    23b8:	00003097          	auipc	ra,0x3
    23bc:	4b0080e7          	jalr	1200(ra) # 5868 <exit>

00000000000023c0 <copyinstr3>:
{
    23c0:	7179                	addi	sp,sp,-48
    23c2:	f406                	sd	ra,40(sp)
    23c4:	f022                	sd	s0,32(sp)
    23c6:	ec26                	sd	s1,24(sp)
    23c8:	1800                	addi	s0,sp,48
  sbrk(8192);
    23ca:	6509                	lui	a0,0x2
    23cc:	00003097          	auipc	ra,0x3
    23d0:	524080e7          	jalr	1316(ra) # 58f0 <sbrk>
  uint64 top = (uint64) sbrk(0);
    23d4:	4501                	li	a0,0
    23d6:	00003097          	auipc	ra,0x3
    23da:	51a080e7          	jalr	1306(ra) # 58f0 <sbrk>
  if((top % PGSIZE) != 0){
    23de:	03451793          	slli	a5,a0,0x34
    23e2:	e3c9                	bnez	a5,2464 <copyinstr3+0xa4>
  top = (uint64) sbrk(0);
    23e4:	4501                	li	a0,0
    23e6:	00003097          	auipc	ra,0x3
    23ea:	50a080e7          	jalr	1290(ra) # 58f0 <sbrk>
  if(top % PGSIZE){
    23ee:	03451793          	slli	a5,a0,0x34
    23f2:	e3d9                	bnez	a5,2478 <copyinstr3+0xb8>
  char *b = (char *) (top - 1);
    23f4:	fff50493          	addi	s1,a0,-1 # 1fff <forktest+0x3>
  *b = 'x';
    23f8:	07800793          	li	a5,120
    23fc:	fef50fa3          	sb	a5,-1(a0)
  int ret = unlink(b);
    2400:	8526                	mv	a0,s1
    2402:	00003097          	auipc	ra,0x3
    2406:	4b6080e7          	jalr	1206(ra) # 58b8 <unlink>
  if(ret != -1){
    240a:	57fd                	li	a5,-1
    240c:	08f51363          	bne	a0,a5,2492 <copyinstr3+0xd2>
  int fd = open(b, O_CREATE | O_WRONLY);
    2410:	20100593          	li	a1,513
    2414:	8526                	mv	a0,s1
    2416:	00003097          	auipc	ra,0x3
    241a:	492080e7          	jalr	1170(ra) # 58a8 <open>
  if(fd != -1){
    241e:	57fd                	li	a5,-1
    2420:	08f51863          	bne	a0,a5,24b0 <copyinstr3+0xf0>
  ret = link(b, b);
    2424:	85a6                	mv	a1,s1
    2426:	8526                	mv	a0,s1
    2428:	00003097          	auipc	ra,0x3
    242c:	4a0080e7          	jalr	1184(ra) # 58c8 <link>
  if(ret != -1){
    2430:	57fd                	li	a5,-1
    2432:	08f51e63          	bne	a0,a5,24ce <copyinstr3+0x10e>
  char *args[] = { "xx", 0 };
    2436:	00005797          	auipc	a5,0x5
    243a:	63278793          	addi	a5,a5,1586 # 7a68 <malloc+0x1d9e>
    243e:	fcf43823          	sd	a5,-48(s0)
    2442:	fc043c23          	sd	zero,-40(s0)
  ret = exec(b, args);
    2446:	fd040593          	addi	a1,s0,-48
    244a:	8526                	mv	a0,s1
    244c:	00003097          	auipc	ra,0x3
    2450:	454080e7          	jalr	1108(ra) # 58a0 <exec>
  if(ret != -1){
    2454:	57fd                	li	a5,-1
    2456:	08f51c63          	bne	a0,a5,24ee <copyinstr3+0x12e>
}
    245a:	70a2                	ld	ra,40(sp)
    245c:	7402                	ld	s0,32(sp)
    245e:	64e2                	ld	s1,24(sp)
    2460:	6145                	addi	sp,sp,48
    2462:	8082                	ret
    sbrk(PGSIZE - (top % PGSIZE));
    2464:	0347d513          	srli	a0,a5,0x34
    2468:	6785                	lui	a5,0x1
    246a:	40a7853b          	subw	a0,a5,a0
    246e:	00003097          	auipc	ra,0x3
    2472:	482080e7          	jalr	1154(ra) # 58f0 <sbrk>
    2476:	b7bd                	j	23e4 <copyinstr3+0x24>
    printf("oops\n");
    2478:	00005517          	auipc	a0,0x5
    247c:	98050513          	addi	a0,a0,-1664 # 6df8 <malloc+0x112e>
    2480:	00003097          	auipc	ra,0x3
    2484:	78c080e7          	jalr	1932(ra) # 5c0c <printf>
    exit(1);
    2488:	4505                	li	a0,1
    248a:	00003097          	auipc	ra,0x3
    248e:	3de080e7          	jalr	990(ra) # 5868 <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    2492:	862a                	mv	a2,a0
    2494:	85a6                	mv	a1,s1
    2496:	00004517          	auipc	a0,0x4
    249a:	40a50513          	addi	a0,a0,1034 # 68a0 <malloc+0xbd6>
    249e:	00003097          	auipc	ra,0x3
    24a2:	76e080e7          	jalr	1902(ra) # 5c0c <printf>
    exit(1);
    24a6:	4505                	li	a0,1
    24a8:	00003097          	auipc	ra,0x3
    24ac:	3c0080e7          	jalr	960(ra) # 5868 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    24b0:	862a                	mv	a2,a0
    24b2:	85a6                	mv	a1,s1
    24b4:	00004517          	auipc	a0,0x4
    24b8:	40c50513          	addi	a0,a0,1036 # 68c0 <malloc+0xbf6>
    24bc:	00003097          	auipc	ra,0x3
    24c0:	750080e7          	jalr	1872(ra) # 5c0c <printf>
    exit(1);
    24c4:	4505                	li	a0,1
    24c6:	00003097          	auipc	ra,0x3
    24ca:	3a2080e7          	jalr	930(ra) # 5868 <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    24ce:	86aa                	mv	a3,a0
    24d0:	8626                	mv	a2,s1
    24d2:	85a6                	mv	a1,s1
    24d4:	00004517          	auipc	a0,0x4
    24d8:	40c50513          	addi	a0,a0,1036 # 68e0 <malloc+0xc16>
    24dc:	00003097          	auipc	ra,0x3
    24e0:	730080e7          	jalr	1840(ra) # 5c0c <printf>
    exit(1);
    24e4:	4505                	li	a0,1
    24e6:	00003097          	auipc	ra,0x3
    24ea:	382080e7          	jalr	898(ra) # 5868 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    24ee:	567d                	li	a2,-1
    24f0:	85a6                	mv	a1,s1
    24f2:	00004517          	auipc	a0,0x4
    24f6:	41650513          	addi	a0,a0,1046 # 6908 <malloc+0xc3e>
    24fa:	00003097          	auipc	ra,0x3
    24fe:	712080e7          	jalr	1810(ra) # 5c0c <printf>
    exit(1);
    2502:	4505                	li	a0,1
    2504:	00003097          	auipc	ra,0x3
    2508:	364080e7          	jalr	868(ra) # 5868 <exit>

000000000000250c <rwsbrk>:
{
    250c:	1101                	addi	sp,sp,-32
    250e:	ec06                	sd	ra,24(sp)
    2510:	e822                	sd	s0,16(sp)
    2512:	e426                	sd	s1,8(sp)
    2514:	e04a                	sd	s2,0(sp)
    2516:	1000                	addi	s0,sp,32
  uint64 a = (uint64) sbrk(8192);
    2518:	6509                	lui	a0,0x2
    251a:	00003097          	auipc	ra,0x3
    251e:	3d6080e7          	jalr	982(ra) # 58f0 <sbrk>
  if(a == 0xffffffffffffffffLL) {
    2522:	57fd                	li	a5,-1
    2524:	06f50363          	beq	a0,a5,258a <rwsbrk+0x7e>
    2528:	84aa                	mv	s1,a0
  if ((uint64) sbrk(-8192) ==  0xffffffffffffffffLL) {
    252a:	7579                	lui	a0,0xffffe
    252c:	00003097          	auipc	ra,0x3
    2530:	3c4080e7          	jalr	964(ra) # 58f0 <sbrk>
    2534:	57fd                	li	a5,-1
    2536:	06f50763          	beq	a0,a5,25a4 <rwsbrk+0x98>
  fd = open("rwsbrk", O_CREATE|O_WRONLY);
    253a:	20100593          	li	a1,513
    253e:	00004517          	auipc	a0,0x4
    2542:	8fa50513          	addi	a0,a0,-1798 # 5e38 <malloc+0x16e>
    2546:	00003097          	auipc	ra,0x3
    254a:	362080e7          	jalr	866(ra) # 58a8 <open>
    254e:	892a                	mv	s2,a0
  if(fd < 0){
    2550:	06054763          	bltz	a0,25be <rwsbrk+0xb2>
  n = write(fd, (void*)(a+4096), 1024);
    2554:	6505                	lui	a0,0x1
    2556:	94aa                	add	s1,s1,a0
    2558:	40000613          	li	a2,1024
    255c:	85a6                	mv	a1,s1
    255e:	854a                	mv	a0,s2
    2560:	00003097          	auipc	ra,0x3
    2564:	328080e7          	jalr	808(ra) # 5888 <write>
    2568:	862a                	mv	a2,a0
  if(n >= 0){
    256a:	06054763          	bltz	a0,25d8 <rwsbrk+0xcc>
    printf("write(fd, %p, 1024) returned %d, not -1\n", a+4096, n);
    256e:	85a6                	mv	a1,s1
    2570:	00005517          	auipc	a0,0x5
    2574:	8e050513          	addi	a0,a0,-1824 # 6e50 <malloc+0x1186>
    2578:	00003097          	auipc	ra,0x3
    257c:	694080e7          	jalr	1684(ra) # 5c0c <printf>
    exit(1);
    2580:	4505                	li	a0,1
    2582:	00003097          	auipc	ra,0x3
    2586:	2e6080e7          	jalr	742(ra) # 5868 <exit>
    printf("sbrk(rwsbrk) failed\n");
    258a:	00005517          	auipc	a0,0x5
    258e:	87650513          	addi	a0,a0,-1930 # 6e00 <malloc+0x1136>
    2592:	00003097          	auipc	ra,0x3
    2596:	67a080e7          	jalr	1658(ra) # 5c0c <printf>
    exit(1);
    259a:	4505                	li	a0,1
    259c:	00003097          	auipc	ra,0x3
    25a0:	2cc080e7          	jalr	716(ra) # 5868 <exit>
    printf("sbrk(rwsbrk) shrink failed\n");
    25a4:	00005517          	auipc	a0,0x5
    25a8:	87450513          	addi	a0,a0,-1932 # 6e18 <malloc+0x114e>
    25ac:	00003097          	auipc	ra,0x3
    25b0:	660080e7          	jalr	1632(ra) # 5c0c <printf>
    exit(1);
    25b4:	4505                	li	a0,1
    25b6:	00003097          	auipc	ra,0x3
    25ba:	2b2080e7          	jalr	690(ra) # 5868 <exit>
    printf("open(rwsbrk) failed\n");
    25be:	00005517          	auipc	a0,0x5
    25c2:	87a50513          	addi	a0,a0,-1926 # 6e38 <malloc+0x116e>
    25c6:	00003097          	auipc	ra,0x3
    25ca:	646080e7          	jalr	1606(ra) # 5c0c <printf>
    exit(1);
    25ce:	4505                	li	a0,1
    25d0:	00003097          	auipc	ra,0x3
    25d4:	298080e7          	jalr	664(ra) # 5868 <exit>
  close(fd);
    25d8:	854a                	mv	a0,s2
    25da:	00003097          	auipc	ra,0x3
    25de:	2b6080e7          	jalr	694(ra) # 5890 <close>
  unlink("rwsbrk");
    25e2:	00004517          	auipc	a0,0x4
    25e6:	85650513          	addi	a0,a0,-1962 # 5e38 <malloc+0x16e>
    25ea:	00003097          	auipc	ra,0x3
    25ee:	2ce080e7          	jalr	718(ra) # 58b8 <unlink>
  fd = open("README", O_RDONLY);
    25f2:	4581                	li	a1,0
    25f4:	00004517          	auipc	a0,0x4
    25f8:	cec50513          	addi	a0,a0,-788 # 62e0 <malloc+0x616>
    25fc:	00003097          	auipc	ra,0x3
    2600:	2ac080e7          	jalr	684(ra) # 58a8 <open>
    2604:	892a                	mv	s2,a0
  if(fd < 0){
    2606:	02054963          	bltz	a0,2638 <rwsbrk+0x12c>
  n = read(fd, (void*)(a+4096), 10);
    260a:	4629                	li	a2,10
    260c:	85a6                	mv	a1,s1
    260e:	00003097          	auipc	ra,0x3
    2612:	272080e7          	jalr	626(ra) # 5880 <read>
    2616:	862a                	mv	a2,a0
  if(n >= 0){
    2618:	02054d63          	bltz	a0,2652 <rwsbrk+0x146>
    printf("read(fd, %p, 10) returned %d, not -1\n", a+4096, n);
    261c:	85a6                	mv	a1,s1
    261e:	00005517          	auipc	a0,0x5
    2622:	86250513          	addi	a0,a0,-1950 # 6e80 <malloc+0x11b6>
    2626:	00003097          	auipc	ra,0x3
    262a:	5e6080e7          	jalr	1510(ra) # 5c0c <printf>
    exit(1);
    262e:	4505                	li	a0,1
    2630:	00003097          	auipc	ra,0x3
    2634:	238080e7          	jalr	568(ra) # 5868 <exit>
    printf("open(rwsbrk) failed\n");
    2638:	00005517          	auipc	a0,0x5
    263c:	80050513          	addi	a0,a0,-2048 # 6e38 <malloc+0x116e>
    2640:	00003097          	auipc	ra,0x3
    2644:	5cc080e7          	jalr	1484(ra) # 5c0c <printf>
    exit(1);
    2648:	4505                	li	a0,1
    264a:	00003097          	auipc	ra,0x3
    264e:	21e080e7          	jalr	542(ra) # 5868 <exit>
  close(fd);
    2652:	854a                	mv	a0,s2
    2654:	00003097          	auipc	ra,0x3
    2658:	23c080e7          	jalr	572(ra) # 5890 <close>
  exit(0);
    265c:	4501                	li	a0,0
    265e:	00003097          	auipc	ra,0x3
    2662:	20a080e7          	jalr	522(ra) # 5868 <exit>

0000000000002666 <sbrkbasic>:
{
    2666:	715d                	addi	sp,sp,-80
    2668:	e486                	sd	ra,72(sp)
    266a:	e0a2                	sd	s0,64(sp)
    266c:	fc26                	sd	s1,56(sp)
    266e:	f84a                	sd	s2,48(sp)
    2670:	f44e                	sd	s3,40(sp)
    2672:	f052                	sd	s4,32(sp)
    2674:	ec56                	sd	s5,24(sp)
    2676:	0880                	addi	s0,sp,80
    2678:	8a2a                	mv	s4,a0
  pid = fork();
    267a:	00003097          	auipc	ra,0x3
    267e:	1e6080e7          	jalr	486(ra) # 5860 <fork>
  if(pid < 0){
    2682:	02054c63          	bltz	a0,26ba <sbrkbasic+0x54>
  if(pid == 0){
    2686:	ed21                	bnez	a0,26de <sbrkbasic+0x78>
    a = sbrk(TOOMUCH);
    2688:	40000537          	lui	a0,0x40000
    268c:	00003097          	auipc	ra,0x3
    2690:	264080e7          	jalr	612(ra) # 58f0 <sbrk>
    if(a == (char*)0xffffffffffffffffL){
    2694:	57fd                	li	a5,-1
    2696:	02f50f63          	beq	a0,a5,26d4 <sbrkbasic+0x6e>
    for(b = a; b < a+TOOMUCH; b += 4096){
    269a:	400007b7          	lui	a5,0x40000
    269e:	97aa                	add	a5,a5,a0
      *b = 99;
    26a0:	06300693          	li	a3,99
    for(b = a; b < a+TOOMUCH; b += 4096){
    26a4:	6705                	lui	a4,0x1
      *b = 99;
    26a6:	00d50023          	sb	a3,0(a0) # 40000000 <__BSS_END__+0x3fff1220>
    for(b = a; b < a+TOOMUCH; b += 4096){
    26aa:	953a                	add	a0,a0,a4
    26ac:	fef51de3          	bne	a0,a5,26a6 <sbrkbasic+0x40>
    exit(1);
    26b0:	4505                	li	a0,1
    26b2:	00003097          	auipc	ra,0x3
    26b6:	1b6080e7          	jalr	438(ra) # 5868 <exit>
    printf("fork failed in sbrkbasic\n");
    26ba:	00004517          	auipc	a0,0x4
    26be:	7ee50513          	addi	a0,a0,2030 # 6ea8 <malloc+0x11de>
    26c2:	00003097          	auipc	ra,0x3
    26c6:	54a080e7          	jalr	1354(ra) # 5c0c <printf>
    exit(1);
    26ca:	4505                	li	a0,1
    26cc:	00003097          	auipc	ra,0x3
    26d0:	19c080e7          	jalr	412(ra) # 5868 <exit>
      exit(0);
    26d4:	4501                	li	a0,0
    26d6:	00003097          	auipc	ra,0x3
    26da:	192080e7          	jalr	402(ra) # 5868 <exit>
  wait(&xstatus);
    26de:	fbc40513          	addi	a0,s0,-68
    26e2:	00003097          	auipc	ra,0x3
    26e6:	18e080e7          	jalr	398(ra) # 5870 <wait>
  if(xstatus == 1){
    26ea:	fbc42703          	lw	a4,-68(s0)
    26ee:	4785                	li	a5,1
    26f0:	00f70e63          	beq	a4,a5,270c <sbrkbasic+0xa6>
  a = sbrk(0);
    26f4:	4501                	li	a0,0
    26f6:	00003097          	auipc	ra,0x3
    26fa:	1fa080e7          	jalr	506(ra) # 58f0 <sbrk>
    26fe:	84aa                	mv	s1,a0
  for(i = 0; i < 5000; i++){
    2700:	4901                	li	s2,0
    *b = 1;
    2702:	4a85                	li	s5,1
  for(i = 0; i < 5000; i++){
    2704:	6985                	lui	s3,0x1
    2706:	38898993          	addi	s3,s3,904 # 1388 <copyinstr2+0x1d6>
    270a:	a005                	j	272a <sbrkbasic+0xc4>
    printf("%s: too much memory allocated!\n", s);
    270c:	85d2                	mv	a1,s4
    270e:	00004517          	auipc	a0,0x4
    2712:	7ba50513          	addi	a0,a0,1978 # 6ec8 <malloc+0x11fe>
    2716:	00003097          	auipc	ra,0x3
    271a:	4f6080e7          	jalr	1270(ra) # 5c0c <printf>
    exit(1);
    271e:	4505                	li	a0,1
    2720:	00003097          	auipc	ra,0x3
    2724:	148080e7          	jalr	328(ra) # 5868 <exit>
    a = b + 1;
    2728:	84be                	mv	s1,a5
    b = sbrk(1);
    272a:	4505                	li	a0,1
    272c:	00003097          	auipc	ra,0x3
    2730:	1c4080e7          	jalr	452(ra) # 58f0 <sbrk>
    if(b != a){
    2734:	04951b63          	bne	a0,s1,278a <sbrkbasic+0x124>
    *b = 1;
    2738:	01548023          	sb	s5,0(s1)
    a = b + 1;
    273c:	00148793          	addi	a5,s1,1
  for(i = 0; i < 5000; i++){
    2740:	2905                	addiw	s2,s2,1
    2742:	ff3913e3          	bne	s2,s3,2728 <sbrkbasic+0xc2>
  pid = fork();
    2746:	00003097          	auipc	ra,0x3
    274a:	11a080e7          	jalr	282(ra) # 5860 <fork>
    274e:	892a                	mv	s2,a0
  if(pid < 0){
    2750:	04054e63          	bltz	a0,27ac <sbrkbasic+0x146>
  c = sbrk(1);
    2754:	4505                	li	a0,1
    2756:	00003097          	auipc	ra,0x3
    275a:	19a080e7          	jalr	410(ra) # 58f0 <sbrk>
  c = sbrk(1);
    275e:	4505                	li	a0,1
    2760:	00003097          	auipc	ra,0x3
    2764:	190080e7          	jalr	400(ra) # 58f0 <sbrk>
  if(c != a + 1){
    2768:	0489                	addi	s1,s1,2
    276a:	04a48f63          	beq	s1,a0,27c8 <sbrkbasic+0x162>
    printf("%s: sbrk test failed post-fork\n", s);
    276e:	85d2                	mv	a1,s4
    2770:	00004517          	auipc	a0,0x4
    2774:	7b850513          	addi	a0,a0,1976 # 6f28 <malloc+0x125e>
    2778:	00003097          	auipc	ra,0x3
    277c:	494080e7          	jalr	1172(ra) # 5c0c <printf>
    exit(1);
    2780:	4505                	li	a0,1
    2782:	00003097          	auipc	ra,0x3
    2786:	0e6080e7          	jalr	230(ra) # 5868 <exit>
      printf("%s: sbrk test failed %d %x %x\n", s, i, a, b);
    278a:	872a                	mv	a4,a0
    278c:	86a6                	mv	a3,s1
    278e:	864a                	mv	a2,s2
    2790:	85d2                	mv	a1,s4
    2792:	00004517          	auipc	a0,0x4
    2796:	75650513          	addi	a0,a0,1878 # 6ee8 <malloc+0x121e>
    279a:	00003097          	auipc	ra,0x3
    279e:	472080e7          	jalr	1138(ra) # 5c0c <printf>
      exit(1);
    27a2:	4505                	li	a0,1
    27a4:	00003097          	auipc	ra,0x3
    27a8:	0c4080e7          	jalr	196(ra) # 5868 <exit>
    printf("%s: sbrk test fork failed\n", s);
    27ac:	85d2                	mv	a1,s4
    27ae:	00004517          	auipc	a0,0x4
    27b2:	75a50513          	addi	a0,a0,1882 # 6f08 <malloc+0x123e>
    27b6:	00003097          	auipc	ra,0x3
    27ba:	456080e7          	jalr	1110(ra) # 5c0c <printf>
    exit(1);
    27be:	4505                	li	a0,1
    27c0:	00003097          	auipc	ra,0x3
    27c4:	0a8080e7          	jalr	168(ra) # 5868 <exit>
  if(pid == 0)
    27c8:	00091763          	bnez	s2,27d6 <sbrkbasic+0x170>
    exit(0);
    27cc:	4501                	li	a0,0
    27ce:	00003097          	auipc	ra,0x3
    27d2:	09a080e7          	jalr	154(ra) # 5868 <exit>
  wait(&xstatus);
    27d6:	fbc40513          	addi	a0,s0,-68
    27da:	00003097          	auipc	ra,0x3
    27de:	096080e7          	jalr	150(ra) # 5870 <wait>
  exit(xstatus);
    27e2:	fbc42503          	lw	a0,-68(s0)
    27e6:	00003097          	auipc	ra,0x3
    27ea:	082080e7          	jalr	130(ra) # 5868 <exit>

00000000000027ee <sbrkmuch>:
{
    27ee:	7179                	addi	sp,sp,-48
    27f0:	f406                	sd	ra,40(sp)
    27f2:	f022                	sd	s0,32(sp)
    27f4:	ec26                	sd	s1,24(sp)
    27f6:	e84a                	sd	s2,16(sp)
    27f8:	e44e                	sd	s3,8(sp)
    27fa:	e052                	sd	s4,0(sp)
    27fc:	1800                	addi	s0,sp,48
    27fe:	89aa                	mv	s3,a0
  oldbrk = sbrk(0);
    2800:	4501                	li	a0,0
    2802:	00003097          	auipc	ra,0x3
    2806:	0ee080e7          	jalr	238(ra) # 58f0 <sbrk>
    280a:	892a                	mv	s2,a0
  a = sbrk(0);
    280c:	4501                	li	a0,0
    280e:	00003097          	auipc	ra,0x3
    2812:	0e2080e7          	jalr	226(ra) # 58f0 <sbrk>
    2816:	84aa                	mv	s1,a0
  p = sbrk(amt);
    2818:	06400537          	lui	a0,0x6400
    281c:	9d05                	subw	a0,a0,s1
    281e:	00003097          	auipc	ra,0x3
    2822:	0d2080e7          	jalr	210(ra) # 58f0 <sbrk>
  if (p != a) {
    2826:	0ca49863          	bne	s1,a0,28f6 <sbrkmuch+0x108>
  char *eee = sbrk(0);
    282a:	4501                	li	a0,0
    282c:	00003097          	auipc	ra,0x3
    2830:	0c4080e7          	jalr	196(ra) # 58f0 <sbrk>
    2834:	87aa                	mv	a5,a0
  for(char *pp = a; pp < eee; pp += 4096)
    2836:	00a4f963          	bgeu	s1,a0,2848 <sbrkmuch+0x5a>
    *pp = 1;
    283a:	4685                	li	a3,1
  for(char *pp = a; pp < eee; pp += 4096)
    283c:	6705                	lui	a4,0x1
    *pp = 1;
    283e:	00d48023          	sb	a3,0(s1)
  for(char *pp = a; pp < eee; pp += 4096)
    2842:	94ba                	add	s1,s1,a4
    2844:	fef4ede3          	bltu	s1,a5,283e <sbrkmuch+0x50>
  *lastaddr = 99;
    2848:	064007b7          	lui	a5,0x6400
    284c:	06300713          	li	a4,99
    2850:	fee78fa3          	sb	a4,-1(a5) # 63fffff <__BSS_END__+0x63f121f>
  a = sbrk(0);
    2854:	4501                	li	a0,0
    2856:	00003097          	auipc	ra,0x3
    285a:	09a080e7          	jalr	154(ra) # 58f0 <sbrk>
    285e:	84aa                	mv	s1,a0
  c = sbrk(-PGSIZE);
    2860:	757d                	lui	a0,0xfffff
    2862:	00003097          	auipc	ra,0x3
    2866:	08e080e7          	jalr	142(ra) # 58f0 <sbrk>
  if(c == (char*)0xffffffffffffffffL){
    286a:	57fd                	li	a5,-1
    286c:	0af50363          	beq	a0,a5,2912 <sbrkmuch+0x124>
  c = sbrk(0);
    2870:	4501                	li	a0,0
    2872:	00003097          	auipc	ra,0x3
    2876:	07e080e7          	jalr	126(ra) # 58f0 <sbrk>
  if(c != a - PGSIZE){
    287a:	77fd                	lui	a5,0xfffff
    287c:	97a6                	add	a5,a5,s1
    287e:	0af51863          	bne	a0,a5,292e <sbrkmuch+0x140>
  a = sbrk(0);
    2882:	4501                	li	a0,0
    2884:	00003097          	auipc	ra,0x3
    2888:	06c080e7          	jalr	108(ra) # 58f0 <sbrk>
    288c:	84aa                	mv	s1,a0
  c = sbrk(PGSIZE);
    288e:	6505                	lui	a0,0x1
    2890:	00003097          	auipc	ra,0x3
    2894:	060080e7          	jalr	96(ra) # 58f0 <sbrk>
    2898:	8a2a                	mv	s4,a0
  if(c != a || sbrk(0) != a + PGSIZE){
    289a:	0aa49a63          	bne	s1,a0,294e <sbrkmuch+0x160>
    289e:	4501                	li	a0,0
    28a0:	00003097          	auipc	ra,0x3
    28a4:	050080e7          	jalr	80(ra) # 58f0 <sbrk>
    28a8:	6785                	lui	a5,0x1
    28aa:	97a6                	add	a5,a5,s1
    28ac:	0af51163          	bne	a0,a5,294e <sbrkmuch+0x160>
  if(*lastaddr == 99){
    28b0:	064007b7          	lui	a5,0x6400
    28b4:	fff7c703          	lbu	a4,-1(a5) # 63fffff <__BSS_END__+0x63f121f>
    28b8:	06300793          	li	a5,99
    28bc:	0af70963          	beq	a4,a5,296e <sbrkmuch+0x180>
  a = sbrk(0);
    28c0:	4501                	li	a0,0
    28c2:	00003097          	auipc	ra,0x3
    28c6:	02e080e7          	jalr	46(ra) # 58f0 <sbrk>
    28ca:	84aa                	mv	s1,a0
  c = sbrk(-(sbrk(0) - oldbrk));
    28cc:	4501                	li	a0,0
    28ce:	00003097          	auipc	ra,0x3
    28d2:	022080e7          	jalr	34(ra) # 58f0 <sbrk>
    28d6:	40a9053b          	subw	a0,s2,a0
    28da:	00003097          	auipc	ra,0x3
    28de:	016080e7          	jalr	22(ra) # 58f0 <sbrk>
  if(c != a){
    28e2:	0aa49463          	bne	s1,a0,298a <sbrkmuch+0x19c>
}
    28e6:	70a2                	ld	ra,40(sp)
    28e8:	7402                	ld	s0,32(sp)
    28ea:	64e2                	ld	s1,24(sp)
    28ec:	6942                	ld	s2,16(sp)
    28ee:	69a2                	ld	s3,8(sp)
    28f0:	6a02                	ld	s4,0(sp)
    28f2:	6145                	addi	sp,sp,48
    28f4:	8082                	ret
    printf("%s: sbrk test failed to grow big address space; enough phys mem?\n", s);
    28f6:	85ce                	mv	a1,s3
    28f8:	00004517          	auipc	a0,0x4
    28fc:	65050513          	addi	a0,a0,1616 # 6f48 <malloc+0x127e>
    2900:	00003097          	auipc	ra,0x3
    2904:	30c080e7          	jalr	780(ra) # 5c0c <printf>
    exit(1);
    2908:	4505                	li	a0,1
    290a:	00003097          	auipc	ra,0x3
    290e:	f5e080e7          	jalr	-162(ra) # 5868 <exit>
    printf("%s: sbrk could not deallocate\n", s);
    2912:	85ce                	mv	a1,s3
    2914:	00004517          	auipc	a0,0x4
    2918:	67c50513          	addi	a0,a0,1660 # 6f90 <malloc+0x12c6>
    291c:	00003097          	auipc	ra,0x3
    2920:	2f0080e7          	jalr	752(ra) # 5c0c <printf>
    exit(1);
    2924:	4505                	li	a0,1
    2926:	00003097          	auipc	ra,0x3
    292a:	f42080e7          	jalr	-190(ra) # 5868 <exit>
    printf("%s: sbrk deallocation produced wrong address, a %x c %x\n", s, a, c);
    292e:	86aa                	mv	a3,a0
    2930:	8626                	mv	a2,s1
    2932:	85ce                	mv	a1,s3
    2934:	00004517          	auipc	a0,0x4
    2938:	67c50513          	addi	a0,a0,1660 # 6fb0 <malloc+0x12e6>
    293c:	00003097          	auipc	ra,0x3
    2940:	2d0080e7          	jalr	720(ra) # 5c0c <printf>
    exit(1);
    2944:	4505                	li	a0,1
    2946:	00003097          	auipc	ra,0x3
    294a:	f22080e7          	jalr	-222(ra) # 5868 <exit>
    printf("%s: sbrk re-allocation failed, a %x c %x\n", s, a, c);
    294e:	86d2                	mv	a3,s4
    2950:	8626                	mv	a2,s1
    2952:	85ce                	mv	a1,s3
    2954:	00004517          	auipc	a0,0x4
    2958:	69c50513          	addi	a0,a0,1692 # 6ff0 <malloc+0x1326>
    295c:	00003097          	auipc	ra,0x3
    2960:	2b0080e7          	jalr	688(ra) # 5c0c <printf>
    exit(1);
    2964:	4505                	li	a0,1
    2966:	00003097          	auipc	ra,0x3
    296a:	f02080e7          	jalr	-254(ra) # 5868 <exit>
    printf("%s: sbrk de-allocation didn't really deallocate\n", s);
    296e:	85ce                	mv	a1,s3
    2970:	00004517          	auipc	a0,0x4
    2974:	6b050513          	addi	a0,a0,1712 # 7020 <malloc+0x1356>
    2978:	00003097          	auipc	ra,0x3
    297c:	294080e7          	jalr	660(ra) # 5c0c <printf>
    exit(1);
    2980:	4505                	li	a0,1
    2982:	00003097          	auipc	ra,0x3
    2986:	ee6080e7          	jalr	-282(ra) # 5868 <exit>
    printf("%s: sbrk downsize failed, a %x c %x\n", s, a, c);
    298a:	86aa                	mv	a3,a0
    298c:	8626                	mv	a2,s1
    298e:	85ce                	mv	a1,s3
    2990:	00004517          	auipc	a0,0x4
    2994:	6c850513          	addi	a0,a0,1736 # 7058 <malloc+0x138e>
    2998:	00003097          	auipc	ra,0x3
    299c:	274080e7          	jalr	628(ra) # 5c0c <printf>
    exit(1);
    29a0:	4505                	li	a0,1
    29a2:	00003097          	auipc	ra,0x3
    29a6:	ec6080e7          	jalr	-314(ra) # 5868 <exit>

00000000000029aa <sbrkarg>:
{
    29aa:	7179                	addi	sp,sp,-48
    29ac:	f406                	sd	ra,40(sp)
    29ae:	f022                	sd	s0,32(sp)
    29b0:	ec26                	sd	s1,24(sp)
    29b2:	e84a                	sd	s2,16(sp)
    29b4:	e44e                	sd	s3,8(sp)
    29b6:	1800                	addi	s0,sp,48
    29b8:	89aa                	mv	s3,a0
  a = sbrk(PGSIZE);
    29ba:	6505                	lui	a0,0x1
    29bc:	00003097          	auipc	ra,0x3
    29c0:	f34080e7          	jalr	-204(ra) # 58f0 <sbrk>
    29c4:	892a                	mv	s2,a0
  fd = open("sbrk", O_CREATE|O_WRONLY);
    29c6:	20100593          	li	a1,513
    29ca:	00004517          	auipc	a0,0x4
    29ce:	6b650513          	addi	a0,a0,1718 # 7080 <malloc+0x13b6>
    29d2:	00003097          	auipc	ra,0x3
    29d6:	ed6080e7          	jalr	-298(ra) # 58a8 <open>
    29da:	84aa                	mv	s1,a0
  unlink("sbrk");
    29dc:	00004517          	auipc	a0,0x4
    29e0:	6a450513          	addi	a0,a0,1700 # 7080 <malloc+0x13b6>
    29e4:	00003097          	auipc	ra,0x3
    29e8:	ed4080e7          	jalr	-300(ra) # 58b8 <unlink>
  if(fd < 0)  {
    29ec:	0404c163          	bltz	s1,2a2e <sbrkarg+0x84>
  if ((n = write(fd, a, PGSIZE)) < 0) {
    29f0:	6605                	lui	a2,0x1
    29f2:	85ca                	mv	a1,s2
    29f4:	8526                	mv	a0,s1
    29f6:	00003097          	auipc	ra,0x3
    29fa:	e92080e7          	jalr	-366(ra) # 5888 <write>
    29fe:	04054663          	bltz	a0,2a4a <sbrkarg+0xa0>
  close(fd);
    2a02:	8526                	mv	a0,s1
    2a04:	00003097          	auipc	ra,0x3
    2a08:	e8c080e7          	jalr	-372(ra) # 5890 <close>
  a = sbrk(PGSIZE);
    2a0c:	6505                	lui	a0,0x1
    2a0e:	00003097          	auipc	ra,0x3
    2a12:	ee2080e7          	jalr	-286(ra) # 58f0 <sbrk>
  if(pipe((int *) a) != 0){
    2a16:	00003097          	auipc	ra,0x3
    2a1a:	e62080e7          	jalr	-414(ra) # 5878 <pipe>
    2a1e:	e521                	bnez	a0,2a66 <sbrkarg+0xbc>
}
    2a20:	70a2                	ld	ra,40(sp)
    2a22:	7402                	ld	s0,32(sp)
    2a24:	64e2                	ld	s1,24(sp)
    2a26:	6942                	ld	s2,16(sp)
    2a28:	69a2                	ld	s3,8(sp)
    2a2a:	6145                	addi	sp,sp,48
    2a2c:	8082                	ret
    printf("%s: open sbrk failed\n", s);
    2a2e:	85ce                	mv	a1,s3
    2a30:	00004517          	auipc	a0,0x4
    2a34:	65850513          	addi	a0,a0,1624 # 7088 <malloc+0x13be>
    2a38:	00003097          	auipc	ra,0x3
    2a3c:	1d4080e7          	jalr	468(ra) # 5c0c <printf>
    exit(1);
    2a40:	4505                	li	a0,1
    2a42:	00003097          	auipc	ra,0x3
    2a46:	e26080e7          	jalr	-474(ra) # 5868 <exit>
    printf("%s: write sbrk failed\n", s);
    2a4a:	85ce                	mv	a1,s3
    2a4c:	00004517          	auipc	a0,0x4
    2a50:	65450513          	addi	a0,a0,1620 # 70a0 <malloc+0x13d6>
    2a54:	00003097          	auipc	ra,0x3
    2a58:	1b8080e7          	jalr	440(ra) # 5c0c <printf>
    exit(1);
    2a5c:	4505                	li	a0,1
    2a5e:	00003097          	auipc	ra,0x3
    2a62:	e0a080e7          	jalr	-502(ra) # 5868 <exit>
    printf("%s: pipe() failed\n", s);
    2a66:	85ce                	mv	a1,s3
    2a68:	00004517          	auipc	a0,0x4
    2a6c:	02050513          	addi	a0,a0,32 # 6a88 <malloc+0xdbe>
    2a70:	00003097          	auipc	ra,0x3
    2a74:	19c080e7          	jalr	412(ra) # 5c0c <printf>
    exit(1);
    2a78:	4505                	li	a0,1
    2a7a:	00003097          	auipc	ra,0x3
    2a7e:	dee080e7          	jalr	-530(ra) # 5868 <exit>

0000000000002a82 <argptest>:
{
    2a82:	1101                	addi	sp,sp,-32
    2a84:	ec06                	sd	ra,24(sp)
    2a86:	e822                	sd	s0,16(sp)
    2a88:	e426                	sd	s1,8(sp)
    2a8a:	e04a                	sd	s2,0(sp)
    2a8c:	1000                	addi	s0,sp,32
    2a8e:	892a                	mv	s2,a0
  fd = open("init", O_RDONLY);
    2a90:	4581                	li	a1,0
    2a92:	00004517          	auipc	a0,0x4
    2a96:	62650513          	addi	a0,a0,1574 # 70b8 <malloc+0x13ee>
    2a9a:	00003097          	auipc	ra,0x3
    2a9e:	e0e080e7          	jalr	-498(ra) # 58a8 <open>
  if (fd < 0) {
    2aa2:	02054b63          	bltz	a0,2ad8 <argptest+0x56>
    2aa6:	84aa                	mv	s1,a0
  read(fd, sbrk(0) - 1, -1);
    2aa8:	4501                	li	a0,0
    2aaa:	00003097          	auipc	ra,0x3
    2aae:	e46080e7          	jalr	-442(ra) # 58f0 <sbrk>
    2ab2:	567d                	li	a2,-1
    2ab4:	fff50593          	addi	a1,a0,-1
    2ab8:	8526                	mv	a0,s1
    2aba:	00003097          	auipc	ra,0x3
    2abe:	dc6080e7          	jalr	-570(ra) # 5880 <read>
  close(fd);
    2ac2:	8526                	mv	a0,s1
    2ac4:	00003097          	auipc	ra,0x3
    2ac8:	dcc080e7          	jalr	-564(ra) # 5890 <close>
}
    2acc:	60e2                	ld	ra,24(sp)
    2ace:	6442                	ld	s0,16(sp)
    2ad0:	64a2                	ld	s1,8(sp)
    2ad2:	6902                	ld	s2,0(sp)
    2ad4:	6105                	addi	sp,sp,32
    2ad6:	8082                	ret
    printf("%s: open failed\n", s);
    2ad8:	85ca                	mv	a1,s2
    2ada:	00004517          	auipc	a0,0x4
    2ade:	ebe50513          	addi	a0,a0,-322 # 6998 <malloc+0xcce>
    2ae2:	00003097          	auipc	ra,0x3
    2ae6:	12a080e7          	jalr	298(ra) # 5c0c <printf>
    exit(1);
    2aea:	4505                	li	a0,1
    2aec:	00003097          	auipc	ra,0x3
    2af0:	d7c080e7          	jalr	-644(ra) # 5868 <exit>

0000000000002af4 <sbrkbugs>:
{
    2af4:	1141                	addi	sp,sp,-16
    2af6:	e406                	sd	ra,8(sp)
    2af8:	e022                	sd	s0,0(sp)
    2afa:	0800                	addi	s0,sp,16
  int pid = fork();
    2afc:	00003097          	auipc	ra,0x3
    2b00:	d64080e7          	jalr	-668(ra) # 5860 <fork>
  if(pid < 0){
    2b04:	02054263          	bltz	a0,2b28 <sbrkbugs+0x34>
  if(pid == 0){
    2b08:	ed0d                	bnez	a0,2b42 <sbrkbugs+0x4e>
    int sz = (uint64) sbrk(0);
    2b0a:	00003097          	auipc	ra,0x3
    2b0e:	de6080e7          	jalr	-538(ra) # 58f0 <sbrk>
    sbrk(-sz);
    2b12:	40a0053b          	negw	a0,a0
    2b16:	00003097          	auipc	ra,0x3
    2b1a:	dda080e7          	jalr	-550(ra) # 58f0 <sbrk>
    exit(0);
    2b1e:	4501                	li	a0,0
    2b20:	00003097          	auipc	ra,0x3
    2b24:	d48080e7          	jalr	-696(ra) # 5868 <exit>
    printf("fork failed\n");
    2b28:	00004517          	auipc	a0,0x4
    2b2c:	27850513          	addi	a0,a0,632 # 6da0 <malloc+0x10d6>
    2b30:	00003097          	auipc	ra,0x3
    2b34:	0dc080e7          	jalr	220(ra) # 5c0c <printf>
    exit(1);
    2b38:	4505                	li	a0,1
    2b3a:	00003097          	auipc	ra,0x3
    2b3e:	d2e080e7          	jalr	-722(ra) # 5868 <exit>
  wait(0);
    2b42:	4501                	li	a0,0
    2b44:	00003097          	auipc	ra,0x3
    2b48:	d2c080e7          	jalr	-724(ra) # 5870 <wait>
  pid = fork();
    2b4c:	00003097          	auipc	ra,0x3
    2b50:	d14080e7          	jalr	-748(ra) # 5860 <fork>
  if(pid < 0){
    2b54:	02054563          	bltz	a0,2b7e <sbrkbugs+0x8a>
  if(pid == 0){
    2b58:	e121                	bnez	a0,2b98 <sbrkbugs+0xa4>
    int sz = (uint64) sbrk(0);
    2b5a:	00003097          	auipc	ra,0x3
    2b5e:	d96080e7          	jalr	-618(ra) # 58f0 <sbrk>
    sbrk(-(sz - 3500));
    2b62:	6785                	lui	a5,0x1
    2b64:	dac7879b          	addiw	a5,a5,-596
    2b68:	40a7853b          	subw	a0,a5,a0
    2b6c:	00003097          	auipc	ra,0x3
    2b70:	d84080e7          	jalr	-636(ra) # 58f0 <sbrk>
    exit(0);
    2b74:	4501                	li	a0,0
    2b76:	00003097          	auipc	ra,0x3
    2b7a:	cf2080e7          	jalr	-782(ra) # 5868 <exit>
    printf("fork failed\n");
    2b7e:	00004517          	auipc	a0,0x4
    2b82:	22250513          	addi	a0,a0,546 # 6da0 <malloc+0x10d6>
    2b86:	00003097          	auipc	ra,0x3
    2b8a:	086080e7          	jalr	134(ra) # 5c0c <printf>
    exit(1);
    2b8e:	4505                	li	a0,1
    2b90:	00003097          	auipc	ra,0x3
    2b94:	cd8080e7          	jalr	-808(ra) # 5868 <exit>
  wait(0);
    2b98:	4501                	li	a0,0
    2b9a:	00003097          	auipc	ra,0x3
    2b9e:	cd6080e7          	jalr	-810(ra) # 5870 <wait>
  pid = fork();
    2ba2:	00003097          	auipc	ra,0x3
    2ba6:	cbe080e7          	jalr	-834(ra) # 5860 <fork>
  if(pid < 0){
    2baa:	02054a63          	bltz	a0,2bde <sbrkbugs+0xea>
  if(pid == 0){
    2bae:	e529                	bnez	a0,2bf8 <sbrkbugs+0x104>
    sbrk((10*4096 + 2048) - (uint64)sbrk(0));
    2bb0:	00003097          	auipc	ra,0x3
    2bb4:	d40080e7          	jalr	-704(ra) # 58f0 <sbrk>
    2bb8:	67ad                	lui	a5,0xb
    2bba:	8007879b          	addiw	a5,a5,-2048
    2bbe:	40a7853b          	subw	a0,a5,a0
    2bc2:	00003097          	auipc	ra,0x3
    2bc6:	d2e080e7          	jalr	-722(ra) # 58f0 <sbrk>
    sbrk(-10);
    2bca:	5559                	li	a0,-10
    2bcc:	00003097          	auipc	ra,0x3
    2bd0:	d24080e7          	jalr	-732(ra) # 58f0 <sbrk>
    exit(0);
    2bd4:	4501                	li	a0,0
    2bd6:	00003097          	auipc	ra,0x3
    2bda:	c92080e7          	jalr	-878(ra) # 5868 <exit>
    printf("fork failed\n");
    2bde:	00004517          	auipc	a0,0x4
    2be2:	1c250513          	addi	a0,a0,450 # 6da0 <malloc+0x10d6>
    2be6:	00003097          	auipc	ra,0x3
    2bea:	026080e7          	jalr	38(ra) # 5c0c <printf>
    exit(1);
    2bee:	4505                	li	a0,1
    2bf0:	00003097          	auipc	ra,0x3
    2bf4:	c78080e7          	jalr	-904(ra) # 5868 <exit>
  wait(0);
    2bf8:	4501                	li	a0,0
    2bfa:	00003097          	auipc	ra,0x3
    2bfe:	c76080e7          	jalr	-906(ra) # 5870 <wait>
  exit(0);
    2c02:	4501                	li	a0,0
    2c04:	00003097          	auipc	ra,0x3
    2c08:	c64080e7          	jalr	-924(ra) # 5868 <exit>

0000000000002c0c <sbrklast>:
{
    2c0c:	7179                	addi	sp,sp,-48
    2c0e:	f406                	sd	ra,40(sp)
    2c10:	f022                	sd	s0,32(sp)
    2c12:	ec26                	sd	s1,24(sp)
    2c14:	e84a                	sd	s2,16(sp)
    2c16:	e44e                	sd	s3,8(sp)
    2c18:	1800                	addi	s0,sp,48
  uint64 top = (uint64) sbrk(0);
    2c1a:	4501                	li	a0,0
    2c1c:	00003097          	auipc	ra,0x3
    2c20:	cd4080e7          	jalr	-812(ra) # 58f0 <sbrk>
  if((top % 4096) != 0)
    2c24:	03451793          	slli	a5,a0,0x34
    2c28:	efc1                	bnez	a5,2cc0 <sbrklast+0xb4>
  sbrk(4096);
    2c2a:	6505                	lui	a0,0x1
    2c2c:	00003097          	auipc	ra,0x3
    2c30:	cc4080e7          	jalr	-828(ra) # 58f0 <sbrk>
  sbrk(10);
    2c34:	4529                	li	a0,10
    2c36:	00003097          	auipc	ra,0x3
    2c3a:	cba080e7          	jalr	-838(ra) # 58f0 <sbrk>
  sbrk(-20);
    2c3e:	5531                	li	a0,-20
    2c40:	00003097          	auipc	ra,0x3
    2c44:	cb0080e7          	jalr	-848(ra) # 58f0 <sbrk>
  top = (uint64) sbrk(0);
    2c48:	4501                	li	a0,0
    2c4a:	00003097          	auipc	ra,0x3
    2c4e:	ca6080e7          	jalr	-858(ra) # 58f0 <sbrk>
    2c52:	84aa                	mv	s1,a0
  char *p = (char *) (top - 64);
    2c54:	fc050913          	addi	s2,a0,-64 # fc0 <bigdir+0x5e>
  p[0] = 'x';
    2c58:	07800793          	li	a5,120
    2c5c:	fcf50023          	sb	a5,-64(a0)
  p[1] = '\0';
    2c60:	fc0500a3          	sb	zero,-63(a0)
  int fd = open(p, O_RDWR|O_CREATE);
    2c64:	20200593          	li	a1,514
    2c68:	854a                	mv	a0,s2
    2c6a:	00003097          	auipc	ra,0x3
    2c6e:	c3e080e7          	jalr	-962(ra) # 58a8 <open>
    2c72:	89aa                	mv	s3,a0
  write(fd, p, 1);
    2c74:	4605                	li	a2,1
    2c76:	85ca                	mv	a1,s2
    2c78:	00003097          	auipc	ra,0x3
    2c7c:	c10080e7          	jalr	-1008(ra) # 5888 <write>
  close(fd);
    2c80:	854e                	mv	a0,s3
    2c82:	00003097          	auipc	ra,0x3
    2c86:	c0e080e7          	jalr	-1010(ra) # 5890 <close>
  fd = open(p, O_RDWR);
    2c8a:	4589                	li	a1,2
    2c8c:	854a                	mv	a0,s2
    2c8e:	00003097          	auipc	ra,0x3
    2c92:	c1a080e7          	jalr	-998(ra) # 58a8 <open>
  p[0] = '\0';
    2c96:	fc048023          	sb	zero,-64(s1)
  read(fd, p, 1);
    2c9a:	4605                	li	a2,1
    2c9c:	85ca                	mv	a1,s2
    2c9e:	00003097          	auipc	ra,0x3
    2ca2:	be2080e7          	jalr	-1054(ra) # 5880 <read>
  if(p[0] != 'x')
    2ca6:	fc04c703          	lbu	a4,-64(s1)
    2caa:	07800793          	li	a5,120
    2cae:	02f71363          	bne	a4,a5,2cd4 <sbrklast+0xc8>
}
    2cb2:	70a2                	ld	ra,40(sp)
    2cb4:	7402                	ld	s0,32(sp)
    2cb6:	64e2                	ld	s1,24(sp)
    2cb8:	6942                	ld	s2,16(sp)
    2cba:	69a2                	ld	s3,8(sp)
    2cbc:	6145                	addi	sp,sp,48
    2cbe:	8082                	ret
    sbrk(4096 - (top % 4096));
    2cc0:	0347d513          	srli	a0,a5,0x34
    2cc4:	6785                	lui	a5,0x1
    2cc6:	40a7853b          	subw	a0,a5,a0
    2cca:	00003097          	auipc	ra,0x3
    2cce:	c26080e7          	jalr	-986(ra) # 58f0 <sbrk>
    2cd2:	bfa1                	j	2c2a <sbrklast+0x1e>
    exit(1);
    2cd4:	4505                	li	a0,1
    2cd6:	00003097          	auipc	ra,0x3
    2cda:	b92080e7          	jalr	-1134(ra) # 5868 <exit>

0000000000002cde <sbrk8000>:
{
    2cde:	1141                	addi	sp,sp,-16
    2ce0:	e406                	sd	ra,8(sp)
    2ce2:	e022                	sd	s0,0(sp)
    2ce4:	0800                	addi	s0,sp,16
  sbrk(0x80000004);
    2ce6:	80000537          	lui	a0,0x80000
    2cea:	0511                	addi	a0,a0,4
    2cec:	00003097          	auipc	ra,0x3
    2cf0:	c04080e7          	jalr	-1020(ra) # 58f0 <sbrk>
  volatile char *top = sbrk(0);
    2cf4:	4501                	li	a0,0
    2cf6:	00003097          	auipc	ra,0x3
    2cfa:	bfa080e7          	jalr	-1030(ra) # 58f0 <sbrk>
  *(top-1) = *(top-1) + 1;
    2cfe:	fff54783          	lbu	a5,-1(a0) # ffffffff7fffffff <__BSS_END__+0xffffffff7fff121f>
    2d02:	0785                	addi	a5,a5,1
    2d04:	0ff7f793          	andi	a5,a5,255
    2d08:	fef50fa3          	sb	a5,-1(a0)
}
    2d0c:	60a2                	ld	ra,8(sp)
    2d0e:	6402                	ld	s0,0(sp)
    2d10:	0141                	addi	sp,sp,16
    2d12:	8082                	ret

0000000000002d14 <execout>:
// test the exec() code that cleans up if it runs out
// of memory. it's really a test that such a condition
// doesn't cause a panic.
void
execout(char *s)
{
    2d14:	715d                	addi	sp,sp,-80
    2d16:	e486                	sd	ra,72(sp)
    2d18:	e0a2                	sd	s0,64(sp)
    2d1a:	fc26                	sd	s1,56(sp)
    2d1c:	f84a                	sd	s2,48(sp)
    2d1e:	f44e                	sd	s3,40(sp)
    2d20:	f052                	sd	s4,32(sp)
    2d22:	0880                	addi	s0,sp,80
  for(int avail = 0; avail < 15; avail++){
    2d24:	4901                	li	s2,0
    2d26:	49bd                	li	s3,15
    int pid = fork();
    2d28:	00003097          	auipc	ra,0x3
    2d2c:	b38080e7          	jalr	-1224(ra) # 5860 <fork>
    2d30:	84aa                	mv	s1,a0
    if(pid < 0){
    2d32:	02054063          	bltz	a0,2d52 <execout+0x3e>
      printf("fork failed\n");
      exit(1);
    } else if(pid == 0){
    2d36:	c91d                	beqz	a0,2d6c <execout+0x58>
      close(1);
      char *args[] = { "echo", "x", 0 };
      exec("echo", args);
      exit(0);
    } else {
      wait((int*)0);
    2d38:	4501                	li	a0,0
    2d3a:	00003097          	auipc	ra,0x3
    2d3e:	b36080e7          	jalr	-1226(ra) # 5870 <wait>
  for(int avail = 0; avail < 15; avail++){
    2d42:	2905                	addiw	s2,s2,1
    2d44:	ff3912e3          	bne	s2,s3,2d28 <execout+0x14>
    }
  }

  exit(0);
    2d48:	4501                	li	a0,0
    2d4a:	00003097          	auipc	ra,0x3
    2d4e:	b1e080e7          	jalr	-1250(ra) # 5868 <exit>
      printf("fork failed\n");
    2d52:	00004517          	auipc	a0,0x4
    2d56:	04e50513          	addi	a0,a0,78 # 6da0 <malloc+0x10d6>
    2d5a:	00003097          	auipc	ra,0x3
    2d5e:	eb2080e7          	jalr	-334(ra) # 5c0c <printf>
      exit(1);
    2d62:	4505                	li	a0,1
    2d64:	00003097          	auipc	ra,0x3
    2d68:	b04080e7          	jalr	-1276(ra) # 5868 <exit>
        if(a == 0xffffffffffffffffLL)
    2d6c:	59fd                	li	s3,-1
        *(char*)(a + 4096 - 1) = 1;
    2d6e:	4a05                	li	s4,1
        uint64 a = (uint64) sbrk(4096);
    2d70:	6505                	lui	a0,0x1
    2d72:	00003097          	auipc	ra,0x3
    2d76:	b7e080e7          	jalr	-1154(ra) # 58f0 <sbrk>
        if(a == 0xffffffffffffffffLL)
    2d7a:	01350763          	beq	a0,s3,2d88 <execout+0x74>
        *(char*)(a + 4096 - 1) = 1;
    2d7e:	6785                	lui	a5,0x1
    2d80:	953e                	add	a0,a0,a5
    2d82:	ff450fa3          	sb	s4,-1(a0) # fff <bigdir+0x9d>
      while(1){
    2d86:	b7ed                	j	2d70 <execout+0x5c>
      for(int i = 0; i < avail; i++)
    2d88:	01205a63          	blez	s2,2d9c <execout+0x88>
        sbrk(-4096);
    2d8c:	757d                	lui	a0,0xfffff
    2d8e:	00003097          	auipc	ra,0x3
    2d92:	b62080e7          	jalr	-1182(ra) # 58f0 <sbrk>
      for(int i = 0; i < avail; i++)
    2d96:	2485                	addiw	s1,s1,1
    2d98:	ff249ae3          	bne	s1,s2,2d8c <execout+0x78>
      close(1);
    2d9c:	4505                	li	a0,1
    2d9e:	00003097          	auipc	ra,0x3
    2da2:	af2080e7          	jalr	-1294(ra) # 5890 <close>
      char *args[] = { "echo", "x", 0 };
    2da6:	00003517          	auipc	a0,0x3
    2daa:	3a250513          	addi	a0,a0,930 # 6148 <malloc+0x47e>
    2dae:	faa43c23          	sd	a0,-72(s0)
    2db2:	00003797          	auipc	a5,0x3
    2db6:	40678793          	addi	a5,a5,1030 # 61b8 <malloc+0x4ee>
    2dba:	fcf43023          	sd	a5,-64(s0)
    2dbe:	fc043423          	sd	zero,-56(s0)
      exec("echo", args);
    2dc2:	fb840593          	addi	a1,s0,-72
    2dc6:	00003097          	auipc	ra,0x3
    2dca:	ada080e7          	jalr	-1318(ra) # 58a0 <exec>
      exit(0);
    2dce:	4501                	li	a0,0
    2dd0:	00003097          	auipc	ra,0x3
    2dd4:	a98080e7          	jalr	-1384(ra) # 5868 <exit>

0000000000002dd8 <fourteen>:
{
    2dd8:	1101                	addi	sp,sp,-32
    2dda:	ec06                	sd	ra,24(sp)
    2ddc:	e822                	sd	s0,16(sp)
    2dde:	e426                	sd	s1,8(sp)
    2de0:	1000                	addi	s0,sp,32
    2de2:	84aa                	mv	s1,a0
  if(mkdir("12345678901234") != 0){
    2de4:	00004517          	auipc	a0,0x4
    2de8:	4ac50513          	addi	a0,a0,1196 # 7290 <malloc+0x15c6>
    2dec:	00003097          	auipc	ra,0x3
    2df0:	ae4080e7          	jalr	-1308(ra) # 58d0 <mkdir>
    2df4:	e165                	bnez	a0,2ed4 <fourteen+0xfc>
  if(mkdir("12345678901234/123456789012345") != 0){
    2df6:	00004517          	auipc	a0,0x4
    2dfa:	2f250513          	addi	a0,a0,754 # 70e8 <malloc+0x141e>
    2dfe:	00003097          	auipc	ra,0x3
    2e02:	ad2080e7          	jalr	-1326(ra) # 58d0 <mkdir>
    2e06:	e56d                	bnez	a0,2ef0 <fourteen+0x118>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    2e08:	20000593          	li	a1,512
    2e0c:	00004517          	auipc	a0,0x4
    2e10:	33450513          	addi	a0,a0,820 # 7140 <malloc+0x1476>
    2e14:	00003097          	auipc	ra,0x3
    2e18:	a94080e7          	jalr	-1388(ra) # 58a8 <open>
  if(fd < 0){
    2e1c:	0e054863          	bltz	a0,2f0c <fourteen+0x134>
  close(fd);
    2e20:	00003097          	auipc	ra,0x3
    2e24:	a70080e7          	jalr	-1424(ra) # 5890 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    2e28:	4581                	li	a1,0
    2e2a:	00004517          	auipc	a0,0x4
    2e2e:	38e50513          	addi	a0,a0,910 # 71b8 <malloc+0x14ee>
    2e32:	00003097          	auipc	ra,0x3
    2e36:	a76080e7          	jalr	-1418(ra) # 58a8 <open>
  if(fd < 0){
    2e3a:	0e054763          	bltz	a0,2f28 <fourteen+0x150>
  close(fd);
    2e3e:	00003097          	auipc	ra,0x3
    2e42:	a52080e7          	jalr	-1454(ra) # 5890 <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    2e46:	00004517          	auipc	a0,0x4
    2e4a:	3e250513          	addi	a0,a0,994 # 7228 <malloc+0x155e>
    2e4e:	00003097          	auipc	ra,0x3
    2e52:	a82080e7          	jalr	-1406(ra) # 58d0 <mkdir>
    2e56:	c57d                	beqz	a0,2f44 <fourteen+0x16c>
  if(mkdir("123456789012345/12345678901234") == 0){
    2e58:	00004517          	auipc	a0,0x4
    2e5c:	42850513          	addi	a0,a0,1064 # 7280 <malloc+0x15b6>
    2e60:	00003097          	auipc	ra,0x3
    2e64:	a70080e7          	jalr	-1424(ra) # 58d0 <mkdir>
    2e68:	cd65                	beqz	a0,2f60 <fourteen+0x188>
  unlink("123456789012345/12345678901234");
    2e6a:	00004517          	auipc	a0,0x4
    2e6e:	41650513          	addi	a0,a0,1046 # 7280 <malloc+0x15b6>
    2e72:	00003097          	auipc	ra,0x3
    2e76:	a46080e7          	jalr	-1466(ra) # 58b8 <unlink>
  unlink("12345678901234/12345678901234");
    2e7a:	00004517          	auipc	a0,0x4
    2e7e:	3ae50513          	addi	a0,a0,942 # 7228 <malloc+0x155e>
    2e82:	00003097          	auipc	ra,0x3
    2e86:	a36080e7          	jalr	-1482(ra) # 58b8 <unlink>
  unlink("12345678901234/12345678901234/12345678901234");
    2e8a:	00004517          	auipc	a0,0x4
    2e8e:	32e50513          	addi	a0,a0,814 # 71b8 <malloc+0x14ee>
    2e92:	00003097          	auipc	ra,0x3
    2e96:	a26080e7          	jalr	-1498(ra) # 58b8 <unlink>
  unlink("123456789012345/123456789012345/123456789012345");
    2e9a:	00004517          	auipc	a0,0x4
    2e9e:	2a650513          	addi	a0,a0,678 # 7140 <malloc+0x1476>
    2ea2:	00003097          	auipc	ra,0x3
    2ea6:	a16080e7          	jalr	-1514(ra) # 58b8 <unlink>
  unlink("12345678901234/123456789012345");
    2eaa:	00004517          	auipc	a0,0x4
    2eae:	23e50513          	addi	a0,a0,574 # 70e8 <malloc+0x141e>
    2eb2:	00003097          	auipc	ra,0x3
    2eb6:	a06080e7          	jalr	-1530(ra) # 58b8 <unlink>
  unlink("12345678901234");
    2eba:	00004517          	auipc	a0,0x4
    2ebe:	3d650513          	addi	a0,a0,982 # 7290 <malloc+0x15c6>
    2ec2:	00003097          	auipc	ra,0x3
    2ec6:	9f6080e7          	jalr	-1546(ra) # 58b8 <unlink>
}
    2eca:	60e2                	ld	ra,24(sp)
    2ecc:	6442                	ld	s0,16(sp)
    2ece:	64a2                	ld	s1,8(sp)
    2ed0:	6105                	addi	sp,sp,32
    2ed2:	8082                	ret
    printf("%s: mkdir 12345678901234 failed\n", s);
    2ed4:	85a6                	mv	a1,s1
    2ed6:	00004517          	auipc	a0,0x4
    2eda:	1ea50513          	addi	a0,a0,490 # 70c0 <malloc+0x13f6>
    2ede:	00003097          	auipc	ra,0x3
    2ee2:	d2e080e7          	jalr	-722(ra) # 5c0c <printf>
    exit(1);
    2ee6:	4505                	li	a0,1
    2ee8:	00003097          	auipc	ra,0x3
    2eec:	980080e7          	jalr	-1664(ra) # 5868 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
    2ef0:	85a6                	mv	a1,s1
    2ef2:	00004517          	auipc	a0,0x4
    2ef6:	21650513          	addi	a0,a0,534 # 7108 <malloc+0x143e>
    2efa:	00003097          	auipc	ra,0x3
    2efe:	d12080e7          	jalr	-750(ra) # 5c0c <printf>
    exit(1);
    2f02:	4505                	li	a0,1
    2f04:	00003097          	auipc	ra,0x3
    2f08:	964080e7          	jalr	-1692(ra) # 5868 <exit>
    printf("%s: create 123456789012345/123456789012345/123456789012345 failed\n", s);
    2f0c:	85a6                	mv	a1,s1
    2f0e:	00004517          	auipc	a0,0x4
    2f12:	26250513          	addi	a0,a0,610 # 7170 <malloc+0x14a6>
    2f16:	00003097          	auipc	ra,0x3
    2f1a:	cf6080e7          	jalr	-778(ra) # 5c0c <printf>
    exit(1);
    2f1e:	4505                	li	a0,1
    2f20:	00003097          	auipc	ra,0x3
    2f24:	948080e7          	jalr	-1720(ra) # 5868 <exit>
    printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n", s);
    2f28:	85a6                	mv	a1,s1
    2f2a:	00004517          	auipc	a0,0x4
    2f2e:	2be50513          	addi	a0,a0,702 # 71e8 <malloc+0x151e>
    2f32:	00003097          	auipc	ra,0x3
    2f36:	cda080e7          	jalr	-806(ra) # 5c0c <printf>
    exit(1);
    2f3a:	4505                	li	a0,1
    2f3c:	00003097          	auipc	ra,0x3
    2f40:	92c080e7          	jalr	-1748(ra) # 5868 <exit>
    printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
    2f44:	85a6                	mv	a1,s1
    2f46:	00004517          	auipc	a0,0x4
    2f4a:	30250513          	addi	a0,a0,770 # 7248 <malloc+0x157e>
    2f4e:	00003097          	auipc	ra,0x3
    2f52:	cbe080e7          	jalr	-834(ra) # 5c0c <printf>
    exit(1);
    2f56:	4505                	li	a0,1
    2f58:	00003097          	auipc	ra,0x3
    2f5c:	910080e7          	jalr	-1776(ra) # 5868 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
    2f60:	85a6                	mv	a1,s1
    2f62:	00004517          	auipc	a0,0x4
    2f66:	33e50513          	addi	a0,a0,830 # 72a0 <malloc+0x15d6>
    2f6a:	00003097          	auipc	ra,0x3
    2f6e:	ca2080e7          	jalr	-862(ra) # 5c0c <printf>
    exit(1);
    2f72:	4505                	li	a0,1
    2f74:	00003097          	auipc	ra,0x3
    2f78:	8f4080e7          	jalr	-1804(ra) # 5868 <exit>

0000000000002f7c <iputtest>:
{
    2f7c:	1101                	addi	sp,sp,-32
    2f7e:	ec06                	sd	ra,24(sp)
    2f80:	e822                	sd	s0,16(sp)
    2f82:	e426                	sd	s1,8(sp)
    2f84:	1000                	addi	s0,sp,32
    2f86:	84aa                	mv	s1,a0
  if(mkdir("iputdir") < 0){
    2f88:	00004517          	auipc	a0,0x4
    2f8c:	35050513          	addi	a0,a0,848 # 72d8 <malloc+0x160e>
    2f90:	00003097          	auipc	ra,0x3
    2f94:	940080e7          	jalr	-1728(ra) # 58d0 <mkdir>
    2f98:	04054563          	bltz	a0,2fe2 <iputtest+0x66>
  if(chdir("iputdir") < 0){
    2f9c:	00004517          	auipc	a0,0x4
    2fa0:	33c50513          	addi	a0,a0,828 # 72d8 <malloc+0x160e>
    2fa4:	00003097          	auipc	ra,0x3
    2fa8:	934080e7          	jalr	-1740(ra) # 58d8 <chdir>
    2fac:	04054963          	bltz	a0,2ffe <iputtest+0x82>
  if(unlink("../iputdir") < 0){
    2fb0:	00004517          	auipc	a0,0x4
    2fb4:	36850513          	addi	a0,a0,872 # 7318 <malloc+0x164e>
    2fb8:	00003097          	auipc	ra,0x3
    2fbc:	900080e7          	jalr	-1792(ra) # 58b8 <unlink>
    2fc0:	04054d63          	bltz	a0,301a <iputtest+0x9e>
  if(chdir("/") < 0){
    2fc4:	00004517          	auipc	a0,0x4
    2fc8:	38450513          	addi	a0,a0,900 # 7348 <malloc+0x167e>
    2fcc:	00003097          	auipc	ra,0x3
    2fd0:	90c080e7          	jalr	-1780(ra) # 58d8 <chdir>
    2fd4:	06054163          	bltz	a0,3036 <iputtest+0xba>
}
    2fd8:	60e2                	ld	ra,24(sp)
    2fda:	6442                	ld	s0,16(sp)
    2fdc:	64a2                	ld	s1,8(sp)
    2fde:	6105                	addi	sp,sp,32
    2fe0:	8082                	ret
    printf("%s: mkdir failed\n", s);
    2fe2:	85a6                	mv	a1,s1
    2fe4:	00004517          	auipc	a0,0x4
    2fe8:	2fc50513          	addi	a0,a0,764 # 72e0 <malloc+0x1616>
    2fec:	00003097          	auipc	ra,0x3
    2ff0:	c20080e7          	jalr	-992(ra) # 5c0c <printf>
    exit(1);
    2ff4:	4505                	li	a0,1
    2ff6:	00003097          	auipc	ra,0x3
    2ffa:	872080e7          	jalr	-1934(ra) # 5868 <exit>
    printf("%s: chdir iputdir failed\n", s);
    2ffe:	85a6                	mv	a1,s1
    3000:	00004517          	auipc	a0,0x4
    3004:	2f850513          	addi	a0,a0,760 # 72f8 <malloc+0x162e>
    3008:	00003097          	auipc	ra,0x3
    300c:	c04080e7          	jalr	-1020(ra) # 5c0c <printf>
    exit(1);
    3010:	4505                	li	a0,1
    3012:	00003097          	auipc	ra,0x3
    3016:	856080e7          	jalr	-1962(ra) # 5868 <exit>
    printf("%s: unlink ../iputdir failed\n", s);
    301a:	85a6                	mv	a1,s1
    301c:	00004517          	auipc	a0,0x4
    3020:	30c50513          	addi	a0,a0,780 # 7328 <malloc+0x165e>
    3024:	00003097          	auipc	ra,0x3
    3028:	be8080e7          	jalr	-1048(ra) # 5c0c <printf>
    exit(1);
    302c:	4505                	li	a0,1
    302e:	00003097          	auipc	ra,0x3
    3032:	83a080e7          	jalr	-1990(ra) # 5868 <exit>
    printf("%s: chdir / failed\n", s);
    3036:	85a6                	mv	a1,s1
    3038:	00004517          	auipc	a0,0x4
    303c:	31850513          	addi	a0,a0,792 # 7350 <malloc+0x1686>
    3040:	00003097          	auipc	ra,0x3
    3044:	bcc080e7          	jalr	-1076(ra) # 5c0c <printf>
    exit(1);
    3048:	4505                	li	a0,1
    304a:	00003097          	auipc	ra,0x3
    304e:	81e080e7          	jalr	-2018(ra) # 5868 <exit>

0000000000003052 <exitiputtest>:
{
    3052:	7179                	addi	sp,sp,-48
    3054:	f406                	sd	ra,40(sp)
    3056:	f022                	sd	s0,32(sp)
    3058:	ec26                	sd	s1,24(sp)
    305a:	1800                	addi	s0,sp,48
    305c:	84aa                	mv	s1,a0
  pid = fork();
    305e:	00003097          	auipc	ra,0x3
    3062:	802080e7          	jalr	-2046(ra) # 5860 <fork>
  if(pid < 0){
    3066:	04054663          	bltz	a0,30b2 <exitiputtest+0x60>
  if(pid == 0){
    306a:	ed45                	bnez	a0,3122 <exitiputtest+0xd0>
    if(mkdir("iputdir") < 0){
    306c:	00004517          	auipc	a0,0x4
    3070:	26c50513          	addi	a0,a0,620 # 72d8 <malloc+0x160e>
    3074:	00003097          	auipc	ra,0x3
    3078:	85c080e7          	jalr	-1956(ra) # 58d0 <mkdir>
    307c:	04054963          	bltz	a0,30ce <exitiputtest+0x7c>
    if(chdir("iputdir") < 0){
    3080:	00004517          	auipc	a0,0x4
    3084:	25850513          	addi	a0,a0,600 # 72d8 <malloc+0x160e>
    3088:	00003097          	auipc	ra,0x3
    308c:	850080e7          	jalr	-1968(ra) # 58d8 <chdir>
    3090:	04054d63          	bltz	a0,30ea <exitiputtest+0x98>
    if(unlink("../iputdir") < 0){
    3094:	00004517          	auipc	a0,0x4
    3098:	28450513          	addi	a0,a0,644 # 7318 <malloc+0x164e>
    309c:	00003097          	auipc	ra,0x3
    30a0:	81c080e7          	jalr	-2020(ra) # 58b8 <unlink>
    30a4:	06054163          	bltz	a0,3106 <exitiputtest+0xb4>
    exit(0);
    30a8:	4501                	li	a0,0
    30aa:	00002097          	auipc	ra,0x2
    30ae:	7be080e7          	jalr	1982(ra) # 5868 <exit>
    printf("%s: fork failed\n", s);
    30b2:	85a6                	mv	a1,s1
    30b4:	00004517          	auipc	a0,0x4
    30b8:	8cc50513          	addi	a0,a0,-1844 # 6980 <malloc+0xcb6>
    30bc:	00003097          	auipc	ra,0x3
    30c0:	b50080e7          	jalr	-1200(ra) # 5c0c <printf>
    exit(1);
    30c4:	4505                	li	a0,1
    30c6:	00002097          	auipc	ra,0x2
    30ca:	7a2080e7          	jalr	1954(ra) # 5868 <exit>
      printf("%s: mkdir failed\n", s);
    30ce:	85a6                	mv	a1,s1
    30d0:	00004517          	auipc	a0,0x4
    30d4:	21050513          	addi	a0,a0,528 # 72e0 <malloc+0x1616>
    30d8:	00003097          	auipc	ra,0x3
    30dc:	b34080e7          	jalr	-1228(ra) # 5c0c <printf>
      exit(1);
    30e0:	4505                	li	a0,1
    30e2:	00002097          	auipc	ra,0x2
    30e6:	786080e7          	jalr	1926(ra) # 5868 <exit>
      printf("%s: child chdir failed\n", s);
    30ea:	85a6                	mv	a1,s1
    30ec:	00004517          	auipc	a0,0x4
    30f0:	27c50513          	addi	a0,a0,636 # 7368 <malloc+0x169e>
    30f4:	00003097          	auipc	ra,0x3
    30f8:	b18080e7          	jalr	-1256(ra) # 5c0c <printf>
      exit(1);
    30fc:	4505                	li	a0,1
    30fe:	00002097          	auipc	ra,0x2
    3102:	76a080e7          	jalr	1898(ra) # 5868 <exit>
      printf("%s: unlink ../iputdir failed\n", s);
    3106:	85a6                	mv	a1,s1
    3108:	00004517          	auipc	a0,0x4
    310c:	22050513          	addi	a0,a0,544 # 7328 <malloc+0x165e>
    3110:	00003097          	auipc	ra,0x3
    3114:	afc080e7          	jalr	-1284(ra) # 5c0c <printf>
      exit(1);
    3118:	4505                	li	a0,1
    311a:	00002097          	auipc	ra,0x2
    311e:	74e080e7          	jalr	1870(ra) # 5868 <exit>
  wait(&xstatus);
    3122:	fdc40513          	addi	a0,s0,-36
    3126:	00002097          	auipc	ra,0x2
    312a:	74a080e7          	jalr	1866(ra) # 5870 <wait>
  exit(xstatus);
    312e:	fdc42503          	lw	a0,-36(s0)
    3132:	00002097          	auipc	ra,0x2
    3136:	736080e7          	jalr	1846(ra) # 5868 <exit>

000000000000313a <dirtest>:
{
    313a:	1101                	addi	sp,sp,-32
    313c:	ec06                	sd	ra,24(sp)
    313e:	e822                	sd	s0,16(sp)
    3140:	e426                	sd	s1,8(sp)
    3142:	1000                	addi	s0,sp,32
    3144:	84aa                	mv	s1,a0
  if(mkdir("dir0") < 0){
    3146:	00004517          	auipc	a0,0x4
    314a:	23a50513          	addi	a0,a0,570 # 7380 <malloc+0x16b6>
    314e:	00002097          	auipc	ra,0x2
    3152:	782080e7          	jalr	1922(ra) # 58d0 <mkdir>
    3156:	04054563          	bltz	a0,31a0 <dirtest+0x66>
  if(chdir("dir0") < 0){
    315a:	00004517          	auipc	a0,0x4
    315e:	22650513          	addi	a0,a0,550 # 7380 <malloc+0x16b6>
    3162:	00002097          	auipc	ra,0x2
    3166:	776080e7          	jalr	1910(ra) # 58d8 <chdir>
    316a:	04054963          	bltz	a0,31bc <dirtest+0x82>
  if(chdir("..") < 0){
    316e:	00004517          	auipc	a0,0x4
    3172:	23250513          	addi	a0,a0,562 # 73a0 <malloc+0x16d6>
    3176:	00002097          	auipc	ra,0x2
    317a:	762080e7          	jalr	1890(ra) # 58d8 <chdir>
    317e:	04054d63          	bltz	a0,31d8 <dirtest+0x9e>
  if(unlink("dir0") < 0){
    3182:	00004517          	auipc	a0,0x4
    3186:	1fe50513          	addi	a0,a0,510 # 7380 <malloc+0x16b6>
    318a:	00002097          	auipc	ra,0x2
    318e:	72e080e7          	jalr	1838(ra) # 58b8 <unlink>
    3192:	06054163          	bltz	a0,31f4 <dirtest+0xba>
}
    3196:	60e2                	ld	ra,24(sp)
    3198:	6442                	ld	s0,16(sp)
    319a:	64a2                	ld	s1,8(sp)
    319c:	6105                	addi	sp,sp,32
    319e:	8082                	ret
    printf("%s: mkdir failed\n", s);
    31a0:	85a6                	mv	a1,s1
    31a2:	00004517          	auipc	a0,0x4
    31a6:	13e50513          	addi	a0,a0,318 # 72e0 <malloc+0x1616>
    31aa:	00003097          	auipc	ra,0x3
    31ae:	a62080e7          	jalr	-1438(ra) # 5c0c <printf>
    exit(1);
    31b2:	4505                	li	a0,1
    31b4:	00002097          	auipc	ra,0x2
    31b8:	6b4080e7          	jalr	1716(ra) # 5868 <exit>
    printf("%s: chdir dir0 failed\n", s);
    31bc:	85a6                	mv	a1,s1
    31be:	00004517          	auipc	a0,0x4
    31c2:	1ca50513          	addi	a0,a0,458 # 7388 <malloc+0x16be>
    31c6:	00003097          	auipc	ra,0x3
    31ca:	a46080e7          	jalr	-1466(ra) # 5c0c <printf>
    exit(1);
    31ce:	4505                	li	a0,1
    31d0:	00002097          	auipc	ra,0x2
    31d4:	698080e7          	jalr	1688(ra) # 5868 <exit>
    printf("%s: chdir .. failed\n", s);
    31d8:	85a6                	mv	a1,s1
    31da:	00004517          	auipc	a0,0x4
    31de:	1ce50513          	addi	a0,a0,462 # 73a8 <malloc+0x16de>
    31e2:	00003097          	auipc	ra,0x3
    31e6:	a2a080e7          	jalr	-1494(ra) # 5c0c <printf>
    exit(1);
    31ea:	4505                	li	a0,1
    31ec:	00002097          	auipc	ra,0x2
    31f0:	67c080e7          	jalr	1660(ra) # 5868 <exit>
    printf("%s: unlink dir0 failed\n", s);
    31f4:	85a6                	mv	a1,s1
    31f6:	00004517          	auipc	a0,0x4
    31fa:	1ca50513          	addi	a0,a0,458 # 73c0 <malloc+0x16f6>
    31fe:	00003097          	auipc	ra,0x3
    3202:	a0e080e7          	jalr	-1522(ra) # 5c0c <printf>
    exit(1);
    3206:	4505                	li	a0,1
    3208:	00002097          	auipc	ra,0x2
    320c:	660080e7          	jalr	1632(ra) # 5868 <exit>

0000000000003210 <subdir>:
{
    3210:	1101                	addi	sp,sp,-32
    3212:	ec06                	sd	ra,24(sp)
    3214:	e822                	sd	s0,16(sp)
    3216:	e426                	sd	s1,8(sp)
    3218:	e04a                	sd	s2,0(sp)
    321a:	1000                	addi	s0,sp,32
    321c:	892a                	mv	s2,a0
  unlink("ff");
    321e:	00004517          	auipc	a0,0x4
    3222:	2ea50513          	addi	a0,a0,746 # 7508 <malloc+0x183e>
    3226:	00002097          	auipc	ra,0x2
    322a:	692080e7          	jalr	1682(ra) # 58b8 <unlink>
  if(mkdir("dd") != 0){
    322e:	00004517          	auipc	a0,0x4
    3232:	1aa50513          	addi	a0,a0,426 # 73d8 <malloc+0x170e>
    3236:	00002097          	auipc	ra,0x2
    323a:	69a080e7          	jalr	1690(ra) # 58d0 <mkdir>
    323e:	38051663          	bnez	a0,35ca <subdir+0x3ba>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    3242:	20200593          	li	a1,514
    3246:	00004517          	auipc	a0,0x4
    324a:	1b250513          	addi	a0,a0,434 # 73f8 <malloc+0x172e>
    324e:	00002097          	auipc	ra,0x2
    3252:	65a080e7          	jalr	1626(ra) # 58a8 <open>
    3256:	84aa                	mv	s1,a0
  if(fd < 0){
    3258:	38054763          	bltz	a0,35e6 <subdir+0x3d6>
  write(fd, "ff", 2);
    325c:	4609                	li	a2,2
    325e:	00004597          	auipc	a1,0x4
    3262:	2aa58593          	addi	a1,a1,682 # 7508 <malloc+0x183e>
    3266:	00002097          	auipc	ra,0x2
    326a:	622080e7          	jalr	1570(ra) # 5888 <write>
  close(fd);
    326e:	8526                	mv	a0,s1
    3270:	00002097          	auipc	ra,0x2
    3274:	620080e7          	jalr	1568(ra) # 5890 <close>
  if(unlink("dd") >= 0){
    3278:	00004517          	auipc	a0,0x4
    327c:	16050513          	addi	a0,a0,352 # 73d8 <malloc+0x170e>
    3280:	00002097          	auipc	ra,0x2
    3284:	638080e7          	jalr	1592(ra) # 58b8 <unlink>
    3288:	36055d63          	bgez	a0,3602 <subdir+0x3f2>
  if(mkdir("/dd/dd") != 0){
    328c:	00004517          	auipc	a0,0x4
    3290:	1c450513          	addi	a0,a0,452 # 7450 <malloc+0x1786>
    3294:	00002097          	auipc	ra,0x2
    3298:	63c080e7          	jalr	1596(ra) # 58d0 <mkdir>
    329c:	38051163          	bnez	a0,361e <subdir+0x40e>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    32a0:	20200593          	li	a1,514
    32a4:	00004517          	auipc	a0,0x4
    32a8:	1d450513          	addi	a0,a0,468 # 7478 <malloc+0x17ae>
    32ac:	00002097          	auipc	ra,0x2
    32b0:	5fc080e7          	jalr	1532(ra) # 58a8 <open>
    32b4:	84aa                	mv	s1,a0
  if(fd < 0){
    32b6:	38054263          	bltz	a0,363a <subdir+0x42a>
  write(fd, "FF", 2);
    32ba:	4609                	li	a2,2
    32bc:	00004597          	auipc	a1,0x4
    32c0:	1ec58593          	addi	a1,a1,492 # 74a8 <malloc+0x17de>
    32c4:	00002097          	auipc	ra,0x2
    32c8:	5c4080e7          	jalr	1476(ra) # 5888 <write>
  close(fd);
    32cc:	8526                	mv	a0,s1
    32ce:	00002097          	auipc	ra,0x2
    32d2:	5c2080e7          	jalr	1474(ra) # 5890 <close>
  fd = open("dd/dd/../ff", 0);
    32d6:	4581                	li	a1,0
    32d8:	00004517          	auipc	a0,0x4
    32dc:	1d850513          	addi	a0,a0,472 # 74b0 <malloc+0x17e6>
    32e0:	00002097          	auipc	ra,0x2
    32e4:	5c8080e7          	jalr	1480(ra) # 58a8 <open>
    32e8:	84aa                	mv	s1,a0
  if(fd < 0){
    32ea:	36054663          	bltz	a0,3656 <subdir+0x446>
  cc = read(fd, buf, sizeof(buf));
    32ee:	660d                	lui	a2,0x3
    32f0:	00009597          	auipc	a1,0x9
    32f4:	ae058593          	addi	a1,a1,-1312 # bdd0 <buf>
    32f8:	00002097          	auipc	ra,0x2
    32fc:	588080e7          	jalr	1416(ra) # 5880 <read>
  if(cc != 2 || buf[0] != 'f'){
    3300:	4789                	li	a5,2
    3302:	36f51863          	bne	a0,a5,3672 <subdir+0x462>
    3306:	00009717          	auipc	a4,0x9
    330a:	aca74703          	lbu	a4,-1334(a4) # bdd0 <buf>
    330e:	06600793          	li	a5,102
    3312:	36f71063          	bne	a4,a5,3672 <subdir+0x462>
  close(fd);
    3316:	8526                	mv	a0,s1
    3318:	00002097          	auipc	ra,0x2
    331c:	578080e7          	jalr	1400(ra) # 5890 <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    3320:	00004597          	auipc	a1,0x4
    3324:	1e058593          	addi	a1,a1,480 # 7500 <malloc+0x1836>
    3328:	00004517          	auipc	a0,0x4
    332c:	15050513          	addi	a0,a0,336 # 7478 <malloc+0x17ae>
    3330:	00002097          	auipc	ra,0x2
    3334:	598080e7          	jalr	1432(ra) # 58c8 <link>
    3338:	34051b63          	bnez	a0,368e <subdir+0x47e>
  if(unlink("dd/dd/ff") != 0){
    333c:	00004517          	auipc	a0,0x4
    3340:	13c50513          	addi	a0,a0,316 # 7478 <malloc+0x17ae>
    3344:	00002097          	auipc	ra,0x2
    3348:	574080e7          	jalr	1396(ra) # 58b8 <unlink>
    334c:	34051f63          	bnez	a0,36aa <subdir+0x49a>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    3350:	4581                	li	a1,0
    3352:	00004517          	auipc	a0,0x4
    3356:	12650513          	addi	a0,a0,294 # 7478 <malloc+0x17ae>
    335a:	00002097          	auipc	ra,0x2
    335e:	54e080e7          	jalr	1358(ra) # 58a8 <open>
    3362:	36055263          	bgez	a0,36c6 <subdir+0x4b6>
  if(chdir("dd") != 0){
    3366:	00004517          	auipc	a0,0x4
    336a:	07250513          	addi	a0,a0,114 # 73d8 <malloc+0x170e>
    336e:	00002097          	auipc	ra,0x2
    3372:	56a080e7          	jalr	1386(ra) # 58d8 <chdir>
    3376:	36051663          	bnez	a0,36e2 <subdir+0x4d2>
  if(chdir("dd/../../dd") != 0){
    337a:	00004517          	auipc	a0,0x4
    337e:	21e50513          	addi	a0,a0,542 # 7598 <malloc+0x18ce>
    3382:	00002097          	auipc	ra,0x2
    3386:	556080e7          	jalr	1366(ra) # 58d8 <chdir>
    338a:	36051a63          	bnez	a0,36fe <subdir+0x4ee>
  if(chdir("dd/../../../dd") != 0){
    338e:	00004517          	auipc	a0,0x4
    3392:	23a50513          	addi	a0,a0,570 # 75c8 <malloc+0x18fe>
    3396:	00002097          	auipc	ra,0x2
    339a:	542080e7          	jalr	1346(ra) # 58d8 <chdir>
    339e:	36051e63          	bnez	a0,371a <subdir+0x50a>
  if(chdir("./..") != 0){
    33a2:	00004517          	auipc	a0,0x4
    33a6:	25650513          	addi	a0,a0,598 # 75f8 <malloc+0x192e>
    33aa:	00002097          	auipc	ra,0x2
    33ae:	52e080e7          	jalr	1326(ra) # 58d8 <chdir>
    33b2:	38051263          	bnez	a0,3736 <subdir+0x526>
  fd = open("dd/dd/ffff", 0);
    33b6:	4581                	li	a1,0
    33b8:	00004517          	auipc	a0,0x4
    33bc:	14850513          	addi	a0,a0,328 # 7500 <malloc+0x1836>
    33c0:	00002097          	auipc	ra,0x2
    33c4:	4e8080e7          	jalr	1256(ra) # 58a8 <open>
    33c8:	84aa                	mv	s1,a0
  if(fd < 0){
    33ca:	38054463          	bltz	a0,3752 <subdir+0x542>
  if(read(fd, buf, sizeof(buf)) != 2){
    33ce:	660d                	lui	a2,0x3
    33d0:	00009597          	auipc	a1,0x9
    33d4:	a0058593          	addi	a1,a1,-1536 # bdd0 <buf>
    33d8:	00002097          	auipc	ra,0x2
    33dc:	4a8080e7          	jalr	1192(ra) # 5880 <read>
    33e0:	4789                	li	a5,2
    33e2:	38f51663          	bne	a0,a5,376e <subdir+0x55e>
  close(fd);
    33e6:	8526                	mv	a0,s1
    33e8:	00002097          	auipc	ra,0x2
    33ec:	4a8080e7          	jalr	1192(ra) # 5890 <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    33f0:	4581                	li	a1,0
    33f2:	00004517          	auipc	a0,0x4
    33f6:	08650513          	addi	a0,a0,134 # 7478 <malloc+0x17ae>
    33fa:	00002097          	auipc	ra,0x2
    33fe:	4ae080e7          	jalr	1198(ra) # 58a8 <open>
    3402:	38055463          	bgez	a0,378a <subdir+0x57a>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    3406:	20200593          	li	a1,514
    340a:	00004517          	auipc	a0,0x4
    340e:	27e50513          	addi	a0,a0,638 # 7688 <malloc+0x19be>
    3412:	00002097          	auipc	ra,0x2
    3416:	496080e7          	jalr	1174(ra) # 58a8 <open>
    341a:	38055663          	bgez	a0,37a6 <subdir+0x596>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    341e:	20200593          	li	a1,514
    3422:	00004517          	auipc	a0,0x4
    3426:	29650513          	addi	a0,a0,662 # 76b8 <malloc+0x19ee>
    342a:	00002097          	auipc	ra,0x2
    342e:	47e080e7          	jalr	1150(ra) # 58a8 <open>
    3432:	38055863          	bgez	a0,37c2 <subdir+0x5b2>
  if(open("dd", O_CREATE) >= 0){
    3436:	20000593          	li	a1,512
    343a:	00004517          	auipc	a0,0x4
    343e:	f9e50513          	addi	a0,a0,-98 # 73d8 <malloc+0x170e>
    3442:	00002097          	auipc	ra,0x2
    3446:	466080e7          	jalr	1126(ra) # 58a8 <open>
    344a:	38055a63          	bgez	a0,37de <subdir+0x5ce>
  if(open("dd", O_RDWR) >= 0){
    344e:	4589                	li	a1,2
    3450:	00004517          	auipc	a0,0x4
    3454:	f8850513          	addi	a0,a0,-120 # 73d8 <malloc+0x170e>
    3458:	00002097          	auipc	ra,0x2
    345c:	450080e7          	jalr	1104(ra) # 58a8 <open>
    3460:	38055d63          	bgez	a0,37fa <subdir+0x5ea>
  if(open("dd", O_WRONLY) >= 0){
    3464:	4585                	li	a1,1
    3466:	00004517          	auipc	a0,0x4
    346a:	f7250513          	addi	a0,a0,-142 # 73d8 <malloc+0x170e>
    346e:	00002097          	auipc	ra,0x2
    3472:	43a080e7          	jalr	1082(ra) # 58a8 <open>
    3476:	3a055063          	bgez	a0,3816 <subdir+0x606>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    347a:	00004597          	auipc	a1,0x4
    347e:	2ce58593          	addi	a1,a1,718 # 7748 <malloc+0x1a7e>
    3482:	00004517          	auipc	a0,0x4
    3486:	20650513          	addi	a0,a0,518 # 7688 <malloc+0x19be>
    348a:	00002097          	auipc	ra,0x2
    348e:	43e080e7          	jalr	1086(ra) # 58c8 <link>
    3492:	3a050063          	beqz	a0,3832 <subdir+0x622>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    3496:	00004597          	auipc	a1,0x4
    349a:	2b258593          	addi	a1,a1,690 # 7748 <malloc+0x1a7e>
    349e:	00004517          	auipc	a0,0x4
    34a2:	21a50513          	addi	a0,a0,538 # 76b8 <malloc+0x19ee>
    34a6:	00002097          	auipc	ra,0x2
    34aa:	422080e7          	jalr	1058(ra) # 58c8 <link>
    34ae:	3a050063          	beqz	a0,384e <subdir+0x63e>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    34b2:	00004597          	auipc	a1,0x4
    34b6:	04e58593          	addi	a1,a1,78 # 7500 <malloc+0x1836>
    34ba:	00004517          	auipc	a0,0x4
    34be:	f3e50513          	addi	a0,a0,-194 # 73f8 <malloc+0x172e>
    34c2:	00002097          	auipc	ra,0x2
    34c6:	406080e7          	jalr	1030(ra) # 58c8 <link>
    34ca:	3a050063          	beqz	a0,386a <subdir+0x65a>
  if(mkdir("dd/ff/ff") == 0){
    34ce:	00004517          	auipc	a0,0x4
    34d2:	1ba50513          	addi	a0,a0,442 # 7688 <malloc+0x19be>
    34d6:	00002097          	auipc	ra,0x2
    34da:	3fa080e7          	jalr	1018(ra) # 58d0 <mkdir>
    34de:	3a050463          	beqz	a0,3886 <subdir+0x676>
  if(mkdir("dd/xx/ff") == 0){
    34e2:	00004517          	auipc	a0,0x4
    34e6:	1d650513          	addi	a0,a0,470 # 76b8 <malloc+0x19ee>
    34ea:	00002097          	auipc	ra,0x2
    34ee:	3e6080e7          	jalr	998(ra) # 58d0 <mkdir>
    34f2:	3a050863          	beqz	a0,38a2 <subdir+0x692>
  if(mkdir("dd/dd/ffff") == 0){
    34f6:	00004517          	auipc	a0,0x4
    34fa:	00a50513          	addi	a0,a0,10 # 7500 <malloc+0x1836>
    34fe:	00002097          	auipc	ra,0x2
    3502:	3d2080e7          	jalr	978(ra) # 58d0 <mkdir>
    3506:	3a050c63          	beqz	a0,38be <subdir+0x6ae>
  if(unlink("dd/xx/ff") == 0){
    350a:	00004517          	auipc	a0,0x4
    350e:	1ae50513          	addi	a0,a0,430 # 76b8 <malloc+0x19ee>
    3512:	00002097          	auipc	ra,0x2
    3516:	3a6080e7          	jalr	934(ra) # 58b8 <unlink>
    351a:	3c050063          	beqz	a0,38da <subdir+0x6ca>
  if(unlink("dd/ff/ff") == 0){
    351e:	00004517          	auipc	a0,0x4
    3522:	16a50513          	addi	a0,a0,362 # 7688 <malloc+0x19be>
    3526:	00002097          	auipc	ra,0x2
    352a:	392080e7          	jalr	914(ra) # 58b8 <unlink>
    352e:	3c050463          	beqz	a0,38f6 <subdir+0x6e6>
  if(chdir("dd/ff") == 0){
    3532:	00004517          	auipc	a0,0x4
    3536:	ec650513          	addi	a0,a0,-314 # 73f8 <malloc+0x172e>
    353a:	00002097          	auipc	ra,0x2
    353e:	39e080e7          	jalr	926(ra) # 58d8 <chdir>
    3542:	3c050863          	beqz	a0,3912 <subdir+0x702>
  if(chdir("dd/xx") == 0){
    3546:	00004517          	auipc	a0,0x4
    354a:	35250513          	addi	a0,a0,850 # 7898 <malloc+0x1bce>
    354e:	00002097          	auipc	ra,0x2
    3552:	38a080e7          	jalr	906(ra) # 58d8 <chdir>
    3556:	3c050c63          	beqz	a0,392e <subdir+0x71e>
  if(unlink("dd/dd/ffff") != 0){
    355a:	00004517          	auipc	a0,0x4
    355e:	fa650513          	addi	a0,a0,-90 # 7500 <malloc+0x1836>
    3562:	00002097          	auipc	ra,0x2
    3566:	356080e7          	jalr	854(ra) # 58b8 <unlink>
    356a:	3e051063          	bnez	a0,394a <subdir+0x73a>
  if(unlink("dd/ff") != 0){
    356e:	00004517          	auipc	a0,0x4
    3572:	e8a50513          	addi	a0,a0,-374 # 73f8 <malloc+0x172e>
    3576:	00002097          	auipc	ra,0x2
    357a:	342080e7          	jalr	834(ra) # 58b8 <unlink>
    357e:	3e051463          	bnez	a0,3966 <subdir+0x756>
  if(unlink("dd") == 0){
    3582:	00004517          	auipc	a0,0x4
    3586:	e5650513          	addi	a0,a0,-426 # 73d8 <malloc+0x170e>
    358a:	00002097          	auipc	ra,0x2
    358e:	32e080e7          	jalr	814(ra) # 58b8 <unlink>
    3592:	3e050863          	beqz	a0,3982 <subdir+0x772>
  if(unlink("dd/dd") < 0){
    3596:	00004517          	auipc	a0,0x4
    359a:	37250513          	addi	a0,a0,882 # 7908 <malloc+0x1c3e>
    359e:	00002097          	auipc	ra,0x2
    35a2:	31a080e7          	jalr	794(ra) # 58b8 <unlink>
    35a6:	3e054c63          	bltz	a0,399e <subdir+0x78e>
  if(unlink("dd") < 0){
    35aa:	00004517          	auipc	a0,0x4
    35ae:	e2e50513          	addi	a0,a0,-466 # 73d8 <malloc+0x170e>
    35b2:	00002097          	auipc	ra,0x2
    35b6:	306080e7          	jalr	774(ra) # 58b8 <unlink>
    35ba:	40054063          	bltz	a0,39ba <subdir+0x7aa>
}
    35be:	60e2                	ld	ra,24(sp)
    35c0:	6442                	ld	s0,16(sp)
    35c2:	64a2                	ld	s1,8(sp)
    35c4:	6902                	ld	s2,0(sp)
    35c6:	6105                	addi	sp,sp,32
    35c8:	8082                	ret
    printf("%s: mkdir dd failed\n", s);
    35ca:	85ca                	mv	a1,s2
    35cc:	00004517          	auipc	a0,0x4
    35d0:	e1450513          	addi	a0,a0,-492 # 73e0 <malloc+0x1716>
    35d4:	00002097          	auipc	ra,0x2
    35d8:	638080e7          	jalr	1592(ra) # 5c0c <printf>
    exit(1);
    35dc:	4505                	li	a0,1
    35de:	00002097          	auipc	ra,0x2
    35e2:	28a080e7          	jalr	650(ra) # 5868 <exit>
    printf("%s: create dd/ff failed\n", s);
    35e6:	85ca                	mv	a1,s2
    35e8:	00004517          	auipc	a0,0x4
    35ec:	e1850513          	addi	a0,a0,-488 # 7400 <malloc+0x1736>
    35f0:	00002097          	auipc	ra,0x2
    35f4:	61c080e7          	jalr	1564(ra) # 5c0c <printf>
    exit(1);
    35f8:	4505                	li	a0,1
    35fa:	00002097          	auipc	ra,0x2
    35fe:	26e080e7          	jalr	622(ra) # 5868 <exit>
    printf("%s: unlink dd (non-empty dir) succeeded!\n", s);
    3602:	85ca                	mv	a1,s2
    3604:	00004517          	auipc	a0,0x4
    3608:	e1c50513          	addi	a0,a0,-484 # 7420 <malloc+0x1756>
    360c:	00002097          	auipc	ra,0x2
    3610:	600080e7          	jalr	1536(ra) # 5c0c <printf>
    exit(1);
    3614:	4505                	li	a0,1
    3616:	00002097          	auipc	ra,0x2
    361a:	252080e7          	jalr	594(ra) # 5868 <exit>
    printf("subdir mkdir dd/dd failed\n", s);
    361e:	85ca                	mv	a1,s2
    3620:	00004517          	auipc	a0,0x4
    3624:	e3850513          	addi	a0,a0,-456 # 7458 <malloc+0x178e>
    3628:	00002097          	auipc	ra,0x2
    362c:	5e4080e7          	jalr	1508(ra) # 5c0c <printf>
    exit(1);
    3630:	4505                	li	a0,1
    3632:	00002097          	auipc	ra,0x2
    3636:	236080e7          	jalr	566(ra) # 5868 <exit>
    printf("%s: create dd/dd/ff failed\n", s);
    363a:	85ca                	mv	a1,s2
    363c:	00004517          	auipc	a0,0x4
    3640:	e4c50513          	addi	a0,a0,-436 # 7488 <malloc+0x17be>
    3644:	00002097          	auipc	ra,0x2
    3648:	5c8080e7          	jalr	1480(ra) # 5c0c <printf>
    exit(1);
    364c:	4505                	li	a0,1
    364e:	00002097          	auipc	ra,0x2
    3652:	21a080e7          	jalr	538(ra) # 5868 <exit>
    printf("%s: open dd/dd/../ff failed\n", s);
    3656:	85ca                	mv	a1,s2
    3658:	00004517          	auipc	a0,0x4
    365c:	e6850513          	addi	a0,a0,-408 # 74c0 <malloc+0x17f6>
    3660:	00002097          	auipc	ra,0x2
    3664:	5ac080e7          	jalr	1452(ra) # 5c0c <printf>
    exit(1);
    3668:	4505                	li	a0,1
    366a:	00002097          	auipc	ra,0x2
    366e:	1fe080e7          	jalr	510(ra) # 5868 <exit>
    printf("%s: dd/dd/../ff wrong content\n", s);
    3672:	85ca                	mv	a1,s2
    3674:	00004517          	auipc	a0,0x4
    3678:	e6c50513          	addi	a0,a0,-404 # 74e0 <malloc+0x1816>
    367c:	00002097          	auipc	ra,0x2
    3680:	590080e7          	jalr	1424(ra) # 5c0c <printf>
    exit(1);
    3684:	4505                	li	a0,1
    3686:	00002097          	auipc	ra,0x2
    368a:	1e2080e7          	jalr	482(ra) # 5868 <exit>
    printf("link dd/dd/ff dd/dd/ffff failed\n", s);
    368e:	85ca                	mv	a1,s2
    3690:	00004517          	auipc	a0,0x4
    3694:	e8050513          	addi	a0,a0,-384 # 7510 <malloc+0x1846>
    3698:	00002097          	auipc	ra,0x2
    369c:	574080e7          	jalr	1396(ra) # 5c0c <printf>
    exit(1);
    36a0:	4505                	li	a0,1
    36a2:	00002097          	auipc	ra,0x2
    36a6:	1c6080e7          	jalr	454(ra) # 5868 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    36aa:	85ca                	mv	a1,s2
    36ac:	00004517          	auipc	a0,0x4
    36b0:	e8c50513          	addi	a0,a0,-372 # 7538 <malloc+0x186e>
    36b4:	00002097          	auipc	ra,0x2
    36b8:	558080e7          	jalr	1368(ra) # 5c0c <printf>
    exit(1);
    36bc:	4505                	li	a0,1
    36be:	00002097          	auipc	ra,0x2
    36c2:	1aa080e7          	jalr	426(ra) # 5868 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded\n", s);
    36c6:	85ca                	mv	a1,s2
    36c8:	00004517          	auipc	a0,0x4
    36cc:	e9050513          	addi	a0,a0,-368 # 7558 <malloc+0x188e>
    36d0:	00002097          	auipc	ra,0x2
    36d4:	53c080e7          	jalr	1340(ra) # 5c0c <printf>
    exit(1);
    36d8:	4505                	li	a0,1
    36da:	00002097          	auipc	ra,0x2
    36de:	18e080e7          	jalr	398(ra) # 5868 <exit>
    printf("%s: chdir dd failed\n", s);
    36e2:	85ca                	mv	a1,s2
    36e4:	00004517          	auipc	a0,0x4
    36e8:	e9c50513          	addi	a0,a0,-356 # 7580 <malloc+0x18b6>
    36ec:	00002097          	auipc	ra,0x2
    36f0:	520080e7          	jalr	1312(ra) # 5c0c <printf>
    exit(1);
    36f4:	4505                	li	a0,1
    36f6:	00002097          	auipc	ra,0x2
    36fa:	172080e7          	jalr	370(ra) # 5868 <exit>
    printf("%s: chdir dd/../../dd failed\n", s);
    36fe:	85ca                	mv	a1,s2
    3700:	00004517          	auipc	a0,0x4
    3704:	ea850513          	addi	a0,a0,-344 # 75a8 <malloc+0x18de>
    3708:	00002097          	auipc	ra,0x2
    370c:	504080e7          	jalr	1284(ra) # 5c0c <printf>
    exit(1);
    3710:	4505                	li	a0,1
    3712:	00002097          	auipc	ra,0x2
    3716:	156080e7          	jalr	342(ra) # 5868 <exit>
    printf("chdir dd/../../dd failed\n", s);
    371a:	85ca                	mv	a1,s2
    371c:	00004517          	auipc	a0,0x4
    3720:	ebc50513          	addi	a0,a0,-324 # 75d8 <malloc+0x190e>
    3724:	00002097          	auipc	ra,0x2
    3728:	4e8080e7          	jalr	1256(ra) # 5c0c <printf>
    exit(1);
    372c:	4505                	li	a0,1
    372e:	00002097          	auipc	ra,0x2
    3732:	13a080e7          	jalr	314(ra) # 5868 <exit>
    printf("%s: chdir ./.. failed\n", s);
    3736:	85ca                	mv	a1,s2
    3738:	00004517          	auipc	a0,0x4
    373c:	ec850513          	addi	a0,a0,-312 # 7600 <malloc+0x1936>
    3740:	00002097          	auipc	ra,0x2
    3744:	4cc080e7          	jalr	1228(ra) # 5c0c <printf>
    exit(1);
    3748:	4505                	li	a0,1
    374a:	00002097          	auipc	ra,0x2
    374e:	11e080e7          	jalr	286(ra) # 5868 <exit>
    printf("%s: open dd/dd/ffff failed\n", s);
    3752:	85ca                	mv	a1,s2
    3754:	00004517          	auipc	a0,0x4
    3758:	ec450513          	addi	a0,a0,-316 # 7618 <malloc+0x194e>
    375c:	00002097          	auipc	ra,0x2
    3760:	4b0080e7          	jalr	1200(ra) # 5c0c <printf>
    exit(1);
    3764:	4505                	li	a0,1
    3766:	00002097          	auipc	ra,0x2
    376a:	102080e7          	jalr	258(ra) # 5868 <exit>
    printf("%s: read dd/dd/ffff wrong len\n", s);
    376e:	85ca                	mv	a1,s2
    3770:	00004517          	auipc	a0,0x4
    3774:	ec850513          	addi	a0,a0,-312 # 7638 <malloc+0x196e>
    3778:	00002097          	auipc	ra,0x2
    377c:	494080e7          	jalr	1172(ra) # 5c0c <printf>
    exit(1);
    3780:	4505                	li	a0,1
    3782:	00002097          	auipc	ra,0x2
    3786:	0e6080e7          	jalr	230(ra) # 5868 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded!\n", s);
    378a:	85ca                	mv	a1,s2
    378c:	00004517          	auipc	a0,0x4
    3790:	ecc50513          	addi	a0,a0,-308 # 7658 <malloc+0x198e>
    3794:	00002097          	auipc	ra,0x2
    3798:	478080e7          	jalr	1144(ra) # 5c0c <printf>
    exit(1);
    379c:	4505                	li	a0,1
    379e:	00002097          	auipc	ra,0x2
    37a2:	0ca080e7          	jalr	202(ra) # 5868 <exit>
    printf("%s: create dd/ff/ff succeeded!\n", s);
    37a6:	85ca                	mv	a1,s2
    37a8:	00004517          	auipc	a0,0x4
    37ac:	ef050513          	addi	a0,a0,-272 # 7698 <malloc+0x19ce>
    37b0:	00002097          	auipc	ra,0x2
    37b4:	45c080e7          	jalr	1116(ra) # 5c0c <printf>
    exit(1);
    37b8:	4505                	li	a0,1
    37ba:	00002097          	auipc	ra,0x2
    37be:	0ae080e7          	jalr	174(ra) # 5868 <exit>
    printf("%s: create dd/xx/ff succeeded!\n", s);
    37c2:	85ca                	mv	a1,s2
    37c4:	00004517          	auipc	a0,0x4
    37c8:	f0450513          	addi	a0,a0,-252 # 76c8 <malloc+0x19fe>
    37cc:	00002097          	auipc	ra,0x2
    37d0:	440080e7          	jalr	1088(ra) # 5c0c <printf>
    exit(1);
    37d4:	4505                	li	a0,1
    37d6:	00002097          	auipc	ra,0x2
    37da:	092080e7          	jalr	146(ra) # 5868 <exit>
    printf("%s: create dd succeeded!\n", s);
    37de:	85ca                	mv	a1,s2
    37e0:	00004517          	auipc	a0,0x4
    37e4:	f0850513          	addi	a0,a0,-248 # 76e8 <malloc+0x1a1e>
    37e8:	00002097          	auipc	ra,0x2
    37ec:	424080e7          	jalr	1060(ra) # 5c0c <printf>
    exit(1);
    37f0:	4505                	li	a0,1
    37f2:	00002097          	auipc	ra,0x2
    37f6:	076080e7          	jalr	118(ra) # 5868 <exit>
    printf("%s: open dd rdwr succeeded!\n", s);
    37fa:	85ca                	mv	a1,s2
    37fc:	00004517          	auipc	a0,0x4
    3800:	f0c50513          	addi	a0,a0,-244 # 7708 <malloc+0x1a3e>
    3804:	00002097          	auipc	ra,0x2
    3808:	408080e7          	jalr	1032(ra) # 5c0c <printf>
    exit(1);
    380c:	4505                	li	a0,1
    380e:	00002097          	auipc	ra,0x2
    3812:	05a080e7          	jalr	90(ra) # 5868 <exit>
    printf("%s: open dd wronly succeeded!\n", s);
    3816:	85ca                	mv	a1,s2
    3818:	00004517          	auipc	a0,0x4
    381c:	f1050513          	addi	a0,a0,-240 # 7728 <malloc+0x1a5e>
    3820:	00002097          	auipc	ra,0x2
    3824:	3ec080e7          	jalr	1004(ra) # 5c0c <printf>
    exit(1);
    3828:	4505                	li	a0,1
    382a:	00002097          	auipc	ra,0x2
    382e:	03e080e7          	jalr	62(ra) # 5868 <exit>
    printf("%s: link dd/ff/ff dd/dd/xx succeeded!\n", s);
    3832:	85ca                	mv	a1,s2
    3834:	00004517          	auipc	a0,0x4
    3838:	f2450513          	addi	a0,a0,-220 # 7758 <malloc+0x1a8e>
    383c:	00002097          	auipc	ra,0x2
    3840:	3d0080e7          	jalr	976(ra) # 5c0c <printf>
    exit(1);
    3844:	4505                	li	a0,1
    3846:	00002097          	auipc	ra,0x2
    384a:	022080e7          	jalr	34(ra) # 5868 <exit>
    printf("%s: link dd/xx/ff dd/dd/xx succeeded!\n", s);
    384e:	85ca                	mv	a1,s2
    3850:	00004517          	auipc	a0,0x4
    3854:	f3050513          	addi	a0,a0,-208 # 7780 <malloc+0x1ab6>
    3858:	00002097          	auipc	ra,0x2
    385c:	3b4080e7          	jalr	948(ra) # 5c0c <printf>
    exit(1);
    3860:	4505                	li	a0,1
    3862:	00002097          	auipc	ra,0x2
    3866:	006080e7          	jalr	6(ra) # 5868 <exit>
    printf("%s: link dd/ff dd/dd/ffff succeeded!\n", s);
    386a:	85ca                	mv	a1,s2
    386c:	00004517          	auipc	a0,0x4
    3870:	f3c50513          	addi	a0,a0,-196 # 77a8 <malloc+0x1ade>
    3874:	00002097          	auipc	ra,0x2
    3878:	398080e7          	jalr	920(ra) # 5c0c <printf>
    exit(1);
    387c:	4505                	li	a0,1
    387e:	00002097          	auipc	ra,0x2
    3882:	fea080e7          	jalr	-22(ra) # 5868 <exit>
    printf("%s: mkdir dd/ff/ff succeeded!\n", s);
    3886:	85ca                	mv	a1,s2
    3888:	00004517          	auipc	a0,0x4
    388c:	f4850513          	addi	a0,a0,-184 # 77d0 <malloc+0x1b06>
    3890:	00002097          	auipc	ra,0x2
    3894:	37c080e7          	jalr	892(ra) # 5c0c <printf>
    exit(1);
    3898:	4505                	li	a0,1
    389a:	00002097          	auipc	ra,0x2
    389e:	fce080e7          	jalr	-50(ra) # 5868 <exit>
    printf("%s: mkdir dd/xx/ff succeeded!\n", s);
    38a2:	85ca                	mv	a1,s2
    38a4:	00004517          	auipc	a0,0x4
    38a8:	f4c50513          	addi	a0,a0,-180 # 77f0 <malloc+0x1b26>
    38ac:	00002097          	auipc	ra,0x2
    38b0:	360080e7          	jalr	864(ra) # 5c0c <printf>
    exit(1);
    38b4:	4505                	li	a0,1
    38b6:	00002097          	auipc	ra,0x2
    38ba:	fb2080e7          	jalr	-78(ra) # 5868 <exit>
    printf("%s: mkdir dd/dd/ffff succeeded!\n", s);
    38be:	85ca                	mv	a1,s2
    38c0:	00004517          	auipc	a0,0x4
    38c4:	f5050513          	addi	a0,a0,-176 # 7810 <malloc+0x1b46>
    38c8:	00002097          	auipc	ra,0x2
    38cc:	344080e7          	jalr	836(ra) # 5c0c <printf>
    exit(1);
    38d0:	4505                	li	a0,1
    38d2:	00002097          	auipc	ra,0x2
    38d6:	f96080e7          	jalr	-106(ra) # 5868 <exit>
    printf("%s: unlink dd/xx/ff succeeded!\n", s);
    38da:	85ca                	mv	a1,s2
    38dc:	00004517          	auipc	a0,0x4
    38e0:	f5c50513          	addi	a0,a0,-164 # 7838 <malloc+0x1b6e>
    38e4:	00002097          	auipc	ra,0x2
    38e8:	328080e7          	jalr	808(ra) # 5c0c <printf>
    exit(1);
    38ec:	4505                	li	a0,1
    38ee:	00002097          	auipc	ra,0x2
    38f2:	f7a080e7          	jalr	-134(ra) # 5868 <exit>
    printf("%s: unlink dd/ff/ff succeeded!\n", s);
    38f6:	85ca                	mv	a1,s2
    38f8:	00004517          	auipc	a0,0x4
    38fc:	f6050513          	addi	a0,a0,-160 # 7858 <malloc+0x1b8e>
    3900:	00002097          	auipc	ra,0x2
    3904:	30c080e7          	jalr	780(ra) # 5c0c <printf>
    exit(1);
    3908:	4505                	li	a0,1
    390a:	00002097          	auipc	ra,0x2
    390e:	f5e080e7          	jalr	-162(ra) # 5868 <exit>
    printf("%s: chdir dd/ff succeeded!\n", s);
    3912:	85ca                	mv	a1,s2
    3914:	00004517          	auipc	a0,0x4
    3918:	f6450513          	addi	a0,a0,-156 # 7878 <malloc+0x1bae>
    391c:	00002097          	auipc	ra,0x2
    3920:	2f0080e7          	jalr	752(ra) # 5c0c <printf>
    exit(1);
    3924:	4505                	li	a0,1
    3926:	00002097          	auipc	ra,0x2
    392a:	f42080e7          	jalr	-190(ra) # 5868 <exit>
    printf("%s: chdir dd/xx succeeded!\n", s);
    392e:	85ca                	mv	a1,s2
    3930:	00004517          	auipc	a0,0x4
    3934:	f7050513          	addi	a0,a0,-144 # 78a0 <malloc+0x1bd6>
    3938:	00002097          	auipc	ra,0x2
    393c:	2d4080e7          	jalr	724(ra) # 5c0c <printf>
    exit(1);
    3940:	4505                	li	a0,1
    3942:	00002097          	auipc	ra,0x2
    3946:	f26080e7          	jalr	-218(ra) # 5868 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    394a:	85ca                	mv	a1,s2
    394c:	00004517          	auipc	a0,0x4
    3950:	bec50513          	addi	a0,a0,-1044 # 7538 <malloc+0x186e>
    3954:	00002097          	auipc	ra,0x2
    3958:	2b8080e7          	jalr	696(ra) # 5c0c <printf>
    exit(1);
    395c:	4505                	li	a0,1
    395e:	00002097          	auipc	ra,0x2
    3962:	f0a080e7          	jalr	-246(ra) # 5868 <exit>
    printf("%s: unlink dd/ff failed\n", s);
    3966:	85ca                	mv	a1,s2
    3968:	00004517          	auipc	a0,0x4
    396c:	f5850513          	addi	a0,a0,-168 # 78c0 <malloc+0x1bf6>
    3970:	00002097          	auipc	ra,0x2
    3974:	29c080e7          	jalr	668(ra) # 5c0c <printf>
    exit(1);
    3978:	4505                	li	a0,1
    397a:	00002097          	auipc	ra,0x2
    397e:	eee080e7          	jalr	-274(ra) # 5868 <exit>
    printf("%s: unlink non-empty dd succeeded!\n", s);
    3982:	85ca                	mv	a1,s2
    3984:	00004517          	auipc	a0,0x4
    3988:	f5c50513          	addi	a0,a0,-164 # 78e0 <malloc+0x1c16>
    398c:	00002097          	auipc	ra,0x2
    3990:	280080e7          	jalr	640(ra) # 5c0c <printf>
    exit(1);
    3994:	4505                	li	a0,1
    3996:	00002097          	auipc	ra,0x2
    399a:	ed2080e7          	jalr	-302(ra) # 5868 <exit>
    printf("%s: unlink dd/dd failed\n", s);
    399e:	85ca                	mv	a1,s2
    39a0:	00004517          	auipc	a0,0x4
    39a4:	f7050513          	addi	a0,a0,-144 # 7910 <malloc+0x1c46>
    39a8:	00002097          	auipc	ra,0x2
    39ac:	264080e7          	jalr	612(ra) # 5c0c <printf>
    exit(1);
    39b0:	4505                	li	a0,1
    39b2:	00002097          	auipc	ra,0x2
    39b6:	eb6080e7          	jalr	-330(ra) # 5868 <exit>
    printf("%s: unlink dd failed\n", s);
    39ba:	85ca                	mv	a1,s2
    39bc:	00004517          	auipc	a0,0x4
    39c0:	f7450513          	addi	a0,a0,-140 # 7930 <malloc+0x1c66>
    39c4:	00002097          	auipc	ra,0x2
    39c8:	248080e7          	jalr	584(ra) # 5c0c <printf>
    exit(1);
    39cc:	4505                	li	a0,1
    39ce:	00002097          	auipc	ra,0x2
    39d2:	e9a080e7          	jalr	-358(ra) # 5868 <exit>

00000000000039d6 <rmdot>:
{
    39d6:	1101                	addi	sp,sp,-32
    39d8:	ec06                	sd	ra,24(sp)
    39da:	e822                	sd	s0,16(sp)
    39dc:	e426                	sd	s1,8(sp)
    39de:	1000                	addi	s0,sp,32
    39e0:	84aa                	mv	s1,a0
  if(mkdir("dots") != 0){
    39e2:	00004517          	auipc	a0,0x4
    39e6:	f6650513          	addi	a0,a0,-154 # 7948 <malloc+0x1c7e>
    39ea:	00002097          	auipc	ra,0x2
    39ee:	ee6080e7          	jalr	-282(ra) # 58d0 <mkdir>
    39f2:	e549                	bnez	a0,3a7c <rmdot+0xa6>
  if(chdir("dots") != 0){
    39f4:	00004517          	auipc	a0,0x4
    39f8:	f5450513          	addi	a0,a0,-172 # 7948 <malloc+0x1c7e>
    39fc:	00002097          	auipc	ra,0x2
    3a00:	edc080e7          	jalr	-292(ra) # 58d8 <chdir>
    3a04:	e951                	bnez	a0,3a98 <rmdot+0xc2>
  if(unlink(".") == 0){
    3a06:	00003517          	auipc	a0,0x3
    3a0a:	dda50513          	addi	a0,a0,-550 # 67e0 <malloc+0xb16>
    3a0e:	00002097          	auipc	ra,0x2
    3a12:	eaa080e7          	jalr	-342(ra) # 58b8 <unlink>
    3a16:	cd59                	beqz	a0,3ab4 <rmdot+0xde>
  if(unlink("..") == 0){
    3a18:	00004517          	auipc	a0,0x4
    3a1c:	98850513          	addi	a0,a0,-1656 # 73a0 <malloc+0x16d6>
    3a20:	00002097          	auipc	ra,0x2
    3a24:	e98080e7          	jalr	-360(ra) # 58b8 <unlink>
    3a28:	c545                	beqz	a0,3ad0 <rmdot+0xfa>
  if(chdir("/") != 0){
    3a2a:	00004517          	auipc	a0,0x4
    3a2e:	91e50513          	addi	a0,a0,-1762 # 7348 <malloc+0x167e>
    3a32:	00002097          	auipc	ra,0x2
    3a36:	ea6080e7          	jalr	-346(ra) # 58d8 <chdir>
    3a3a:	e94d                	bnez	a0,3aec <rmdot+0x116>
  if(unlink("dots/.") == 0){
    3a3c:	00004517          	auipc	a0,0x4
    3a40:	f7450513          	addi	a0,a0,-140 # 79b0 <malloc+0x1ce6>
    3a44:	00002097          	auipc	ra,0x2
    3a48:	e74080e7          	jalr	-396(ra) # 58b8 <unlink>
    3a4c:	cd55                	beqz	a0,3b08 <rmdot+0x132>
  if(unlink("dots/..") == 0){
    3a4e:	00004517          	auipc	a0,0x4
    3a52:	f8a50513          	addi	a0,a0,-118 # 79d8 <malloc+0x1d0e>
    3a56:	00002097          	auipc	ra,0x2
    3a5a:	e62080e7          	jalr	-414(ra) # 58b8 <unlink>
    3a5e:	c179                	beqz	a0,3b24 <rmdot+0x14e>
  if(unlink("dots") != 0){
    3a60:	00004517          	auipc	a0,0x4
    3a64:	ee850513          	addi	a0,a0,-280 # 7948 <malloc+0x1c7e>
    3a68:	00002097          	auipc	ra,0x2
    3a6c:	e50080e7          	jalr	-432(ra) # 58b8 <unlink>
    3a70:	e961                	bnez	a0,3b40 <rmdot+0x16a>
}
    3a72:	60e2                	ld	ra,24(sp)
    3a74:	6442                	ld	s0,16(sp)
    3a76:	64a2                	ld	s1,8(sp)
    3a78:	6105                	addi	sp,sp,32
    3a7a:	8082                	ret
    printf("%s: mkdir dots failed\n", s);
    3a7c:	85a6                	mv	a1,s1
    3a7e:	00004517          	auipc	a0,0x4
    3a82:	ed250513          	addi	a0,a0,-302 # 7950 <malloc+0x1c86>
    3a86:	00002097          	auipc	ra,0x2
    3a8a:	186080e7          	jalr	390(ra) # 5c0c <printf>
    exit(1);
    3a8e:	4505                	li	a0,1
    3a90:	00002097          	auipc	ra,0x2
    3a94:	dd8080e7          	jalr	-552(ra) # 5868 <exit>
    printf("%s: chdir dots failed\n", s);
    3a98:	85a6                	mv	a1,s1
    3a9a:	00004517          	auipc	a0,0x4
    3a9e:	ece50513          	addi	a0,a0,-306 # 7968 <malloc+0x1c9e>
    3aa2:	00002097          	auipc	ra,0x2
    3aa6:	16a080e7          	jalr	362(ra) # 5c0c <printf>
    exit(1);
    3aaa:	4505                	li	a0,1
    3aac:	00002097          	auipc	ra,0x2
    3ab0:	dbc080e7          	jalr	-580(ra) # 5868 <exit>
    printf("%s: rm . worked!\n", s);
    3ab4:	85a6                	mv	a1,s1
    3ab6:	00004517          	auipc	a0,0x4
    3aba:	eca50513          	addi	a0,a0,-310 # 7980 <malloc+0x1cb6>
    3abe:	00002097          	auipc	ra,0x2
    3ac2:	14e080e7          	jalr	334(ra) # 5c0c <printf>
    exit(1);
    3ac6:	4505                	li	a0,1
    3ac8:	00002097          	auipc	ra,0x2
    3acc:	da0080e7          	jalr	-608(ra) # 5868 <exit>
    printf("%s: rm .. worked!\n", s);
    3ad0:	85a6                	mv	a1,s1
    3ad2:	00004517          	auipc	a0,0x4
    3ad6:	ec650513          	addi	a0,a0,-314 # 7998 <malloc+0x1cce>
    3ada:	00002097          	auipc	ra,0x2
    3ade:	132080e7          	jalr	306(ra) # 5c0c <printf>
    exit(1);
    3ae2:	4505                	li	a0,1
    3ae4:	00002097          	auipc	ra,0x2
    3ae8:	d84080e7          	jalr	-636(ra) # 5868 <exit>
    printf("%s: chdir / failed\n", s);
    3aec:	85a6                	mv	a1,s1
    3aee:	00004517          	auipc	a0,0x4
    3af2:	86250513          	addi	a0,a0,-1950 # 7350 <malloc+0x1686>
    3af6:	00002097          	auipc	ra,0x2
    3afa:	116080e7          	jalr	278(ra) # 5c0c <printf>
    exit(1);
    3afe:	4505                	li	a0,1
    3b00:	00002097          	auipc	ra,0x2
    3b04:	d68080e7          	jalr	-664(ra) # 5868 <exit>
    printf("%s: unlink dots/. worked!\n", s);
    3b08:	85a6                	mv	a1,s1
    3b0a:	00004517          	auipc	a0,0x4
    3b0e:	eae50513          	addi	a0,a0,-338 # 79b8 <malloc+0x1cee>
    3b12:	00002097          	auipc	ra,0x2
    3b16:	0fa080e7          	jalr	250(ra) # 5c0c <printf>
    exit(1);
    3b1a:	4505                	li	a0,1
    3b1c:	00002097          	auipc	ra,0x2
    3b20:	d4c080e7          	jalr	-692(ra) # 5868 <exit>
    printf("%s: unlink dots/.. worked!\n", s);
    3b24:	85a6                	mv	a1,s1
    3b26:	00004517          	auipc	a0,0x4
    3b2a:	eba50513          	addi	a0,a0,-326 # 79e0 <malloc+0x1d16>
    3b2e:	00002097          	auipc	ra,0x2
    3b32:	0de080e7          	jalr	222(ra) # 5c0c <printf>
    exit(1);
    3b36:	4505                	li	a0,1
    3b38:	00002097          	auipc	ra,0x2
    3b3c:	d30080e7          	jalr	-720(ra) # 5868 <exit>
    printf("%s: unlink dots failed!\n", s);
    3b40:	85a6                	mv	a1,s1
    3b42:	00004517          	auipc	a0,0x4
    3b46:	ebe50513          	addi	a0,a0,-322 # 7a00 <malloc+0x1d36>
    3b4a:	00002097          	auipc	ra,0x2
    3b4e:	0c2080e7          	jalr	194(ra) # 5c0c <printf>
    exit(1);
    3b52:	4505                	li	a0,1
    3b54:	00002097          	auipc	ra,0x2
    3b58:	d14080e7          	jalr	-748(ra) # 5868 <exit>

0000000000003b5c <dirfile>:
{
    3b5c:	1101                	addi	sp,sp,-32
    3b5e:	ec06                	sd	ra,24(sp)
    3b60:	e822                	sd	s0,16(sp)
    3b62:	e426                	sd	s1,8(sp)
    3b64:	e04a                	sd	s2,0(sp)
    3b66:	1000                	addi	s0,sp,32
    3b68:	892a                	mv	s2,a0
  fd = open("dirfile", O_CREATE);
    3b6a:	20000593          	li	a1,512
    3b6e:	00002517          	auipc	a0,0x2
    3b72:	57a50513          	addi	a0,a0,1402 # 60e8 <malloc+0x41e>
    3b76:	00002097          	auipc	ra,0x2
    3b7a:	d32080e7          	jalr	-718(ra) # 58a8 <open>
  if(fd < 0){
    3b7e:	0e054d63          	bltz	a0,3c78 <dirfile+0x11c>
  close(fd);
    3b82:	00002097          	auipc	ra,0x2
    3b86:	d0e080e7          	jalr	-754(ra) # 5890 <close>
  if(chdir("dirfile") == 0){
    3b8a:	00002517          	auipc	a0,0x2
    3b8e:	55e50513          	addi	a0,a0,1374 # 60e8 <malloc+0x41e>
    3b92:	00002097          	auipc	ra,0x2
    3b96:	d46080e7          	jalr	-698(ra) # 58d8 <chdir>
    3b9a:	cd6d                	beqz	a0,3c94 <dirfile+0x138>
  fd = open("dirfile/xx", 0);
    3b9c:	4581                	li	a1,0
    3b9e:	00004517          	auipc	a0,0x4
    3ba2:	ec250513          	addi	a0,a0,-318 # 7a60 <malloc+0x1d96>
    3ba6:	00002097          	auipc	ra,0x2
    3baa:	d02080e7          	jalr	-766(ra) # 58a8 <open>
  if(fd >= 0){
    3bae:	10055163          	bgez	a0,3cb0 <dirfile+0x154>
  fd = open("dirfile/xx", O_CREATE);
    3bb2:	20000593          	li	a1,512
    3bb6:	00004517          	auipc	a0,0x4
    3bba:	eaa50513          	addi	a0,a0,-342 # 7a60 <malloc+0x1d96>
    3bbe:	00002097          	auipc	ra,0x2
    3bc2:	cea080e7          	jalr	-790(ra) # 58a8 <open>
  if(fd >= 0){
    3bc6:	10055363          	bgez	a0,3ccc <dirfile+0x170>
  if(mkdir("dirfile/xx") == 0){
    3bca:	00004517          	auipc	a0,0x4
    3bce:	e9650513          	addi	a0,a0,-362 # 7a60 <malloc+0x1d96>
    3bd2:	00002097          	auipc	ra,0x2
    3bd6:	cfe080e7          	jalr	-770(ra) # 58d0 <mkdir>
    3bda:	10050763          	beqz	a0,3ce8 <dirfile+0x18c>
  if(unlink("dirfile/xx") == 0){
    3bde:	00004517          	auipc	a0,0x4
    3be2:	e8250513          	addi	a0,a0,-382 # 7a60 <malloc+0x1d96>
    3be6:	00002097          	auipc	ra,0x2
    3bea:	cd2080e7          	jalr	-814(ra) # 58b8 <unlink>
    3bee:	10050b63          	beqz	a0,3d04 <dirfile+0x1a8>
  if(link("README", "dirfile/xx") == 0){
    3bf2:	00004597          	auipc	a1,0x4
    3bf6:	e6e58593          	addi	a1,a1,-402 # 7a60 <malloc+0x1d96>
    3bfa:	00002517          	auipc	a0,0x2
    3bfe:	6e650513          	addi	a0,a0,1766 # 62e0 <malloc+0x616>
    3c02:	00002097          	auipc	ra,0x2
    3c06:	cc6080e7          	jalr	-826(ra) # 58c8 <link>
    3c0a:	10050b63          	beqz	a0,3d20 <dirfile+0x1c4>
  if(unlink("dirfile") != 0){
    3c0e:	00002517          	auipc	a0,0x2
    3c12:	4da50513          	addi	a0,a0,1242 # 60e8 <malloc+0x41e>
    3c16:	00002097          	auipc	ra,0x2
    3c1a:	ca2080e7          	jalr	-862(ra) # 58b8 <unlink>
    3c1e:	10051f63          	bnez	a0,3d3c <dirfile+0x1e0>
  fd = open(".", O_RDWR);
    3c22:	4589                	li	a1,2
    3c24:	00003517          	auipc	a0,0x3
    3c28:	bbc50513          	addi	a0,a0,-1092 # 67e0 <malloc+0xb16>
    3c2c:	00002097          	auipc	ra,0x2
    3c30:	c7c080e7          	jalr	-900(ra) # 58a8 <open>
  if(fd >= 0){
    3c34:	12055263          	bgez	a0,3d58 <dirfile+0x1fc>
  fd = open(".", 0);
    3c38:	4581                	li	a1,0
    3c3a:	00003517          	auipc	a0,0x3
    3c3e:	ba650513          	addi	a0,a0,-1114 # 67e0 <malloc+0xb16>
    3c42:	00002097          	auipc	ra,0x2
    3c46:	c66080e7          	jalr	-922(ra) # 58a8 <open>
    3c4a:	84aa                	mv	s1,a0
  if(write(fd, "x", 1) > 0){
    3c4c:	4605                	li	a2,1
    3c4e:	00002597          	auipc	a1,0x2
    3c52:	56a58593          	addi	a1,a1,1386 # 61b8 <malloc+0x4ee>
    3c56:	00002097          	auipc	ra,0x2
    3c5a:	c32080e7          	jalr	-974(ra) # 5888 <write>
    3c5e:	10a04b63          	bgtz	a0,3d74 <dirfile+0x218>
  close(fd);
    3c62:	8526                	mv	a0,s1
    3c64:	00002097          	auipc	ra,0x2
    3c68:	c2c080e7          	jalr	-980(ra) # 5890 <close>
}
    3c6c:	60e2                	ld	ra,24(sp)
    3c6e:	6442                	ld	s0,16(sp)
    3c70:	64a2                	ld	s1,8(sp)
    3c72:	6902                	ld	s2,0(sp)
    3c74:	6105                	addi	sp,sp,32
    3c76:	8082                	ret
    printf("%s: create dirfile failed\n", s);
    3c78:	85ca                	mv	a1,s2
    3c7a:	00004517          	auipc	a0,0x4
    3c7e:	da650513          	addi	a0,a0,-602 # 7a20 <malloc+0x1d56>
    3c82:	00002097          	auipc	ra,0x2
    3c86:	f8a080e7          	jalr	-118(ra) # 5c0c <printf>
    exit(1);
    3c8a:	4505                	li	a0,1
    3c8c:	00002097          	auipc	ra,0x2
    3c90:	bdc080e7          	jalr	-1060(ra) # 5868 <exit>
    printf("%s: chdir dirfile succeeded!\n", s);
    3c94:	85ca                	mv	a1,s2
    3c96:	00004517          	auipc	a0,0x4
    3c9a:	daa50513          	addi	a0,a0,-598 # 7a40 <malloc+0x1d76>
    3c9e:	00002097          	auipc	ra,0x2
    3ca2:	f6e080e7          	jalr	-146(ra) # 5c0c <printf>
    exit(1);
    3ca6:	4505                	li	a0,1
    3ca8:	00002097          	auipc	ra,0x2
    3cac:	bc0080e7          	jalr	-1088(ra) # 5868 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    3cb0:	85ca                	mv	a1,s2
    3cb2:	00004517          	auipc	a0,0x4
    3cb6:	dbe50513          	addi	a0,a0,-578 # 7a70 <malloc+0x1da6>
    3cba:	00002097          	auipc	ra,0x2
    3cbe:	f52080e7          	jalr	-174(ra) # 5c0c <printf>
    exit(1);
    3cc2:	4505                	li	a0,1
    3cc4:	00002097          	auipc	ra,0x2
    3cc8:	ba4080e7          	jalr	-1116(ra) # 5868 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    3ccc:	85ca                	mv	a1,s2
    3cce:	00004517          	auipc	a0,0x4
    3cd2:	da250513          	addi	a0,a0,-606 # 7a70 <malloc+0x1da6>
    3cd6:	00002097          	auipc	ra,0x2
    3cda:	f36080e7          	jalr	-202(ra) # 5c0c <printf>
    exit(1);
    3cde:	4505                	li	a0,1
    3ce0:	00002097          	auipc	ra,0x2
    3ce4:	b88080e7          	jalr	-1144(ra) # 5868 <exit>
    printf("%s: mkdir dirfile/xx succeeded!\n", s);
    3ce8:	85ca                	mv	a1,s2
    3cea:	00004517          	auipc	a0,0x4
    3cee:	dae50513          	addi	a0,a0,-594 # 7a98 <malloc+0x1dce>
    3cf2:	00002097          	auipc	ra,0x2
    3cf6:	f1a080e7          	jalr	-230(ra) # 5c0c <printf>
    exit(1);
    3cfa:	4505                	li	a0,1
    3cfc:	00002097          	auipc	ra,0x2
    3d00:	b6c080e7          	jalr	-1172(ra) # 5868 <exit>
    printf("%s: unlink dirfile/xx succeeded!\n", s);
    3d04:	85ca                	mv	a1,s2
    3d06:	00004517          	auipc	a0,0x4
    3d0a:	dba50513          	addi	a0,a0,-582 # 7ac0 <malloc+0x1df6>
    3d0e:	00002097          	auipc	ra,0x2
    3d12:	efe080e7          	jalr	-258(ra) # 5c0c <printf>
    exit(1);
    3d16:	4505                	li	a0,1
    3d18:	00002097          	auipc	ra,0x2
    3d1c:	b50080e7          	jalr	-1200(ra) # 5868 <exit>
    printf("%s: link to dirfile/xx succeeded!\n", s);
    3d20:	85ca                	mv	a1,s2
    3d22:	00004517          	auipc	a0,0x4
    3d26:	dc650513          	addi	a0,a0,-570 # 7ae8 <malloc+0x1e1e>
    3d2a:	00002097          	auipc	ra,0x2
    3d2e:	ee2080e7          	jalr	-286(ra) # 5c0c <printf>
    exit(1);
    3d32:	4505                	li	a0,1
    3d34:	00002097          	auipc	ra,0x2
    3d38:	b34080e7          	jalr	-1228(ra) # 5868 <exit>
    printf("%s: unlink dirfile failed!\n", s);
    3d3c:	85ca                	mv	a1,s2
    3d3e:	00004517          	auipc	a0,0x4
    3d42:	dd250513          	addi	a0,a0,-558 # 7b10 <malloc+0x1e46>
    3d46:	00002097          	auipc	ra,0x2
    3d4a:	ec6080e7          	jalr	-314(ra) # 5c0c <printf>
    exit(1);
    3d4e:	4505                	li	a0,1
    3d50:	00002097          	auipc	ra,0x2
    3d54:	b18080e7          	jalr	-1256(ra) # 5868 <exit>
    printf("%s: open . for writing succeeded!\n", s);
    3d58:	85ca                	mv	a1,s2
    3d5a:	00004517          	auipc	a0,0x4
    3d5e:	dd650513          	addi	a0,a0,-554 # 7b30 <malloc+0x1e66>
    3d62:	00002097          	auipc	ra,0x2
    3d66:	eaa080e7          	jalr	-342(ra) # 5c0c <printf>
    exit(1);
    3d6a:	4505                	li	a0,1
    3d6c:	00002097          	auipc	ra,0x2
    3d70:	afc080e7          	jalr	-1284(ra) # 5868 <exit>
    printf("%s: write . succeeded!\n", s);
    3d74:	85ca                	mv	a1,s2
    3d76:	00004517          	auipc	a0,0x4
    3d7a:	de250513          	addi	a0,a0,-542 # 7b58 <malloc+0x1e8e>
    3d7e:	00002097          	auipc	ra,0x2
    3d82:	e8e080e7          	jalr	-370(ra) # 5c0c <printf>
    exit(1);
    3d86:	4505                	li	a0,1
    3d88:	00002097          	auipc	ra,0x2
    3d8c:	ae0080e7          	jalr	-1312(ra) # 5868 <exit>

0000000000003d90 <iref>:
{
    3d90:	7139                	addi	sp,sp,-64
    3d92:	fc06                	sd	ra,56(sp)
    3d94:	f822                	sd	s0,48(sp)
    3d96:	f426                	sd	s1,40(sp)
    3d98:	f04a                	sd	s2,32(sp)
    3d9a:	ec4e                	sd	s3,24(sp)
    3d9c:	e852                	sd	s4,16(sp)
    3d9e:	e456                	sd	s5,8(sp)
    3da0:	e05a                	sd	s6,0(sp)
    3da2:	0080                	addi	s0,sp,64
    3da4:	8b2a                	mv	s6,a0
    3da6:	03300913          	li	s2,51
    if(mkdir("irefd") != 0){
    3daa:	00004a17          	auipc	s4,0x4
    3dae:	dc6a0a13          	addi	s4,s4,-570 # 7b70 <malloc+0x1ea6>
    mkdir("");
    3db2:	00004497          	auipc	s1,0x4
    3db6:	8ce48493          	addi	s1,s1,-1842 # 7680 <malloc+0x19b6>
    link("README", "");
    3dba:	00002a97          	auipc	s5,0x2
    3dbe:	526a8a93          	addi	s5,s5,1318 # 62e0 <malloc+0x616>
    fd = open("xx", O_CREATE);
    3dc2:	00004997          	auipc	s3,0x4
    3dc6:	ca698993          	addi	s3,s3,-858 # 7a68 <malloc+0x1d9e>
    3dca:	a891                	j	3e1e <iref+0x8e>
      printf("%s: mkdir irefd failed\n", s);
    3dcc:	85da                	mv	a1,s6
    3dce:	00004517          	auipc	a0,0x4
    3dd2:	daa50513          	addi	a0,a0,-598 # 7b78 <malloc+0x1eae>
    3dd6:	00002097          	auipc	ra,0x2
    3dda:	e36080e7          	jalr	-458(ra) # 5c0c <printf>
      exit(1);
    3dde:	4505                	li	a0,1
    3de0:	00002097          	auipc	ra,0x2
    3de4:	a88080e7          	jalr	-1400(ra) # 5868 <exit>
      printf("%s: chdir irefd failed\n", s);
    3de8:	85da                	mv	a1,s6
    3dea:	00004517          	auipc	a0,0x4
    3dee:	da650513          	addi	a0,a0,-602 # 7b90 <malloc+0x1ec6>
    3df2:	00002097          	auipc	ra,0x2
    3df6:	e1a080e7          	jalr	-486(ra) # 5c0c <printf>
      exit(1);
    3dfa:	4505                	li	a0,1
    3dfc:	00002097          	auipc	ra,0x2
    3e00:	a6c080e7          	jalr	-1428(ra) # 5868 <exit>
      close(fd);
    3e04:	00002097          	auipc	ra,0x2
    3e08:	a8c080e7          	jalr	-1396(ra) # 5890 <close>
    3e0c:	a889                	j	3e5e <iref+0xce>
    unlink("xx");
    3e0e:	854e                	mv	a0,s3
    3e10:	00002097          	auipc	ra,0x2
    3e14:	aa8080e7          	jalr	-1368(ra) # 58b8 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    3e18:	397d                	addiw	s2,s2,-1
    3e1a:	06090063          	beqz	s2,3e7a <iref+0xea>
    if(mkdir("irefd") != 0){
    3e1e:	8552                	mv	a0,s4
    3e20:	00002097          	auipc	ra,0x2
    3e24:	ab0080e7          	jalr	-1360(ra) # 58d0 <mkdir>
    3e28:	f155                	bnez	a0,3dcc <iref+0x3c>
    if(chdir("irefd") != 0){
    3e2a:	8552                	mv	a0,s4
    3e2c:	00002097          	auipc	ra,0x2
    3e30:	aac080e7          	jalr	-1364(ra) # 58d8 <chdir>
    3e34:	f955                	bnez	a0,3de8 <iref+0x58>
    mkdir("");
    3e36:	8526                	mv	a0,s1
    3e38:	00002097          	auipc	ra,0x2
    3e3c:	a98080e7          	jalr	-1384(ra) # 58d0 <mkdir>
    link("README", "");
    3e40:	85a6                	mv	a1,s1
    3e42:	8556                	mv	a0,s5
    3e44:	00002097          	auipc	ra,0x2
    3e48:	a84080e7          	jalr	-1404(ra) # 58c8 <link>
    fd = open("", O_CREATE);
    3e4c:	20000593          	li	a1,512
    3e50:	8526                	mv	a0,s1
    3e52:	00002097          	auipc	ra,0x2
    3e56:	a56080e7          	jalr	-1450(ra) # 58a8 <open>
    if(fd >= 0)
    3e5a:	fa0555e3          	bgez	a0,3e04 <iref+0x74>
    fd = open("xx", O_CREATE);
    3e5e:	20000593          	li	a1,512
    3e62:	854e                	mv	a0,s3
    3e64:	00002097          	auipc	ra,0x2
    3e68:	a44080e7          	jalr	-1468(ra) # 58a8 <open>
    if(fd >= 0)
    3e6c:	fa0541e3          	bltz	a0,3e0e <iref+0x7e>
      close(fd);
    3e70:	00002097          	auipc	ra,0x2
    3e74:	a20080e7          	jalr	-1504(ra) # 5890 <close>
    3e78:	bf59                	j	3e0e <iref+0x7e>
    3e7a:	03300493          	li	s1,51
    chdir("..");
    3e7e:	00003997          	auipc	s3,0x3
    3e82:	52298993          	addi	s3,s3,1314 # 73a0 <malloc+0x16d6>
    unlink("irefd");
    3e86:	00004917          	auipc	s2,0x4
    3e8a:	cea90913          	addi	s2,s2,-790 # 7b70 <malloc+0x1ea6>
    chdir("..");
    3e8e:	854e                	mv	a0,s3
    3e90:	00002097          	auipc	ra,0x2
    3e94:	a48080e7          	jalr	-1464(ra) # 58d8 <chdir>
    unlink("irefd");
    3e98:	854a                	mv	a0,s2
    3e9a:	00002097          	auipc	ra,0x2
    3e9e:	a1e080e7          	jalr	-1506(ra) # 58b8 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    3ea2:	34fd                	addiw	s1,s1,-1
    3ea4:	f4ed                	bnez	s1,3e8e <iref+0xfe>
  chdir("/");
    3ea6:	00003517          	auipc	a0,0x3
    3eaa:	4a250513          	addi	a0,a0,1186 # 7348 <malloc+0x167e>
    3eae:	00002097          	auipc	ra,0x2
    3eb2:	a2a080e7          	jalr	-1494(ra) # 58d8 <chdir>
}
    3eb6:	70e2                	ld	ra,56(sp)
    3eb8:	7442                	ld	s0,48(sp)
    3eba:	74a2                	ld	s1,40(sp)
    3ebc:	7902                	ld	s2,32(sp)
    3ebe:	69e2                	ld	s3,24(sp)
    3ec0:	6a42                	ld	s4,16(sp)
    3ec2:	6aa2                	ld	s5,8(sp)
    3ec4:	6b02                	ld	s6,0(sp)
    3ec6:	6121                	addi	sp,sp,64
    3ec8:	8082                	ret

0000000000003eca <openiputtest>:
{
    3eca:	7179                	addi	sp,sp,-48
    3ecc:	f406                	sd	ra,40(sp)
    3ece:	f022                	sd	s0,32(sp)
    3ed0:	ec26                	sd	s1,24(sp)
    3ed2:	1800                	addi	s0,sp,48
    3ed4:	84aa                	mv	s1,a0
  if(mkdir("oidir") < 0){
    3ed6:	00004517          	auipc	a0,0x4
    3eda:	cd250513          	addi	a0,a0,-814 # 7ba8 <malloc+0x1ede>
    3ede:	00002097          	auipc	ra,0x2
    3ee2:	9f2080e7          	jalr	-1550(ra) # 58d0 <mkdir>
    3ee6:	04054263          	bltz	a0,3f2a <openiputtest+0x60>
  pid = fork();
    3eea:	00002097          	auipc	ra,0x2
    3eee:	976080e7          	jalr	-1674(ra) # 5860 <fork>
  if(pid < 0){
    3ef2:	04054a63          	bltz	a0,3f46 <openiputtest+0x7c>
  if(pid == 0){
    3ef6:	e93d                	bnez	a0,3f6c <openiputtest+0xa2>
    int fd = open("oidir", O_RDWR);
    3ef8:	4589                	li	a1,2
    3efa:	00004517          	auipc	a0,0x4
    3efe:	cae50513          	addi	a0,a0,-850 # 7ba8 <malloc+0x1ede>
    3f02:	00002097          	auipc	ra,0x2
    3f06:	9a6080e7          	jalr	-1626(ra) # 58a8 <open>
    if(fd >= 0){
    3f0a:	04054c63          	bltz	a0,3f62 <openiputtest+0x98>
      printf("%s: open directory for write succeeded\n", s);
    3f0e:	85a6                	mv	a1,s1
    3f10:	00004517          	auipc	a0,0x4
    3f14:	cb850513          	addi	a0,a0,-840 # 7bc8 <malloc+0x1efe>
    3f18:	00002097          	auipc	ra,0x2
    3f1c:	cf4080e7          	jalr	-780(ra) # 5c0c <printf>
      exit(1);
    3f20:	4505                	li	a0,1
    3f22:	00002097          	auipc	ra,0x2
    3f26:	946080e7          	jalr	-1722(ra) # 5868 <exit>
    printf("%s: mkdir oidir failed\n", s);
    3f2a:	85a6                	mv	a1,s1
    3f2c:	00004517          	auipc	a0,0x4
    3f30:	c8450513          	addi	a0,a0,-892 # 7bb0 <malloc+0x1ee6>
    3f34:	00002097          	auipc	ra,0x2
    3f38:	cd8080e7          	jalr	-808(ra) # 5c0c <printf>
    exit(1);
    3f3c:	4505                	li	a0,1
    3f3e:	00002097          	auipc	ra,0x2
    3f42:	92a080e7          	jalr	-1750(ra) # 5868 <exit>
    printf("%s: fork failed\n", s);
    3f46:	85a6                	mv	a1,s1
    3f48:	00003517          	auipc	a0,0x3
    3f4c:	a3850513          	addi	a0,a0,-1480 # 6980 <malloc+0xcb6>
    3f50:	00002097          	auipc	ra,0x2
    3f54:	cbc080e7          	jalr	-836(ra) # 5c0c <printf>
    exit(1);
    3f58:	4505                	li	a0,1
    3f5a:	00002097          	auipc	ra,0x2
    3f5e:	90e080e7          	jalr	-1778(ra) # 5868 <exit>
    exit(0);
    3f62:	4501                	li	a0,0
    3f64:	00002097          	auipc	ra,0x2
    3f68:	904080e7          	jalr	-1788(ra) # 5868 <exit>
  sleep(1);
    3f6c:	4505                	li	a0,1
    3f6e:	00002097          	auipc	ra,0x2
    3f72:	98a080e7          	jalr	-1654(ra) # 58f8 <sleep>
  if(unlink("oidir") != 0){
    3f76:	00004517          	auipc	a0,0x4
    3f7a:	c3250513          	addi	a0,a0,-974 # 7ba8 <malloc+0x1ede>
    3f7e:	00002097          	auipc	ra,0x2
    3f82:	93a080e7          	jalr	-1734(ra) # 58b8 <unlink>
    3f86:	cd19                	beqz	a0,3fa4 <openiputtest+0xda>
    printf("%s: unlink failed\n", s);
    3f88:	85a6                	mv	a1,s1
    3f8a:	00003517          	auipc	a0,0x3
    3f8e:	be650513          	addi	a0,a0,-1050 # 6b70 <malloc+0xea6>
    3f92:	00002097          	auipc	ra,0x2
    3f96:	c7a080e7          	jalr	-902(ra) # 5c0c <printf>
    exit(1);
    3f9a:	4505                	li	a0,1
    3f9c:	00002097          	auipc	ra,0x2
    3fa0:	8cc080e7          	jalr	-1844(ra) # 5868 <exit>
  wait(&xstatus);
    3fa4:	fdc40513          	addi	a0,s0,-36
    3fa8:	00002097          	auipc	ra,0x2
    3fac:	8c8080e7          	jalr	-1848(ra) # 5870 <wait>
  exit(xstatus);
    3fb0:	fdc42503          	lw	a0,-36(s0)
    3fb4:	00002097          	auipc	ra,0x2
    3fb8:	8b4080e7          	jalr	-1868(ra) # 5868 <exit>

0000000000003fbc <forkforkfork>:
{
    3fbc:	1101                	addi	sp,sp,-32
    3fbe:	ec06                	sd	ra,24(sp)
    3fc0:	e822                	sd	s0,16(sp)
    3fc2:	e426                	sd	s1,8(sp)
    3fc4:	1000                	addi	s0,sp,32
    3fc6:	84aa                	mv	s1,a0
  unlink("stopforking");
    3fc8:	00004517          	auipc	a0,0x4
    3fcc:	c2850513          	addi	a0,a0,-984 # 7bf0 <malloc+0x1f26>
    3fd0:	00002097          	auipc	ra,0x2
    3fd4:	8e8080e7          	jalr	-1816(ra) # 58b8 <unlink>
  int pid = fork();
    3fd8:	00002097          	auipc	ra,0x2
    3fdc:	888080e7          	jalr	-1912(ra) # 5860 <fork>
  if(pid < 0){
    3fe0:	04054563          	bltz	a0,402a <forkforkfork+0x6e>
  if(pid == 0){
    3fe4:	c12d                	beqz	a0,4046 <forkforkfork+0x8a>
  sleep(20); // two seconds
    3fe6:	4551                	li	a0,20
    3fe8:	00002097          	auipc	ra,0x2
    3fec:	910080e7          	jalr	-1776(ra) # 58f8 <sleep>
  close(open("stopforking", O_CREATE|O_RDWR));
    3ff0:	20200593          	li	a1,514
    3ff4:	00004517          	auipc	a0,0x4
    3ff8:	bfc50513          	addi	a0,a0,-1028 # 7bf0 <malloc+0x1f26>
    3ffc:	00002097          	auipc	ra,0x2
    4000:	8ac080e7          	jalr	-1876(ra) # 58a8 <open>
    4004:	00002097          	auipc	ra,0x2
    4008:	88c080e7          	jalr	-1908(ra) # 5890 <close>
  wait(0);
    400c:	4501                	li	a0,0
    400e:	00002097          	auipc	ra,0x2
    4012:	862080e7          	jalr	-1950(ra) # 5870 <wait>
  sleep(10); // one second
    4016:	4529                	li	a0,10
    4018:	00002097          	auipc	ra,0x2
    401c:	8e0080e7          	jalr	-1824(ra) # 58f8 <sleep>
}
    4020:	60e2                	ld	ra,24(sp)
    4022:	6442                	ld	s0,16(sp)
    4024:	64a2                	ld	s1,8(sp)
    4026:	6105                	addi	sp,sp,32
    4028:	8082                	ret
    printf("%s: fork failed", s);
    402a:	85a6                	mv	a1,s1
    402c:	00003517          	auipc	a0,0x3
    4030:	b1450513          	addi	a0,a0,-1260 # 6b40 <malloc+0xe76>
    4034:	00002097          	auipc	ra,0x2
    4038:	bd8080e7          	jalr	-1064(ra) # 5c0c <printf>
    exit(1);
    403c:	4505                	li	a0,1
    403e:	00002097          	auipc	ra,0x2
    4042:	82a080e7          	jalr	-2006(ra) # 5868 <exit>
      int fd = open("stopforking", 0);
    4046:	00004497          	auipc	s1,0x4
    404a:	baa48493          	addi	s1,s1,-1110 # 7bf0 <malloc+0x1f26>
    404e:	4581                	li	a1,0
    4050:	8526                	mv	a0,s1
    4052:	00002097          	auipc	ra,0x2
    4056:	856080e7          	jalr	-1962(ra) # 58a8 <open>
      if(fd >= 0){
    405a:	02055463          	bgez	a0,4082 <forkforkfork+0xc6>
      if(fork() < 0){
    405e:	00002097          	auipc	ra,0x2
    4062:	802080e7          	jalr	-2046(ra) # 5860 <fork>
    4066:	fe0554e3          	bgez	a0,404e <forkforkfork+0x92>
        close(open("stopforking", O_CREATE|O_RDWR));
    406a:	20200593          	li	a1,514
    406e:	8526                	mv	a0,s1
    4070:	00002097          	auipc	ra,0x2
    4074:	838080e7          	jalr	-1992(ra) # 58a8 <open>
    4078:	00002097          	auipc	ra,0x2
    407c:	818080e7          	jalr	-2024(ra) # 5890 <close>
    4080:	b7f9                	j	404e <forkforkfork+0x92>
        exit(0);
    4082:	4501                	li	a0,0
    4084:	00001097          	auipc	ra,0x1
    4088:	7e4080e7          	jalr	2020(ra) # 5868 <exit>

000000000000408c <killstatus>:
{
    408c:	7139                	addi	sp,sp,-64
    408e:	fc06                	sd	ra,56(sp)
    4090:	f822                	sd	s0,48(sp)
    4092:	f426                	sd	s1,40(sp)
    4094:	f04a                	sd	s2,32(sp)
    4096:	ec4e                	sd	s3,24(sp)
    4098:	e852                	sd	s4,16(sp)
    409a:	0080                	addi	s0,sp,64
    409c:	8a2a                	mv	s4,a0
    409e:	06400913          	li	s2,100
    if(xst != -1) {
    40a2:	59fd                	li	s3,-1
    int pid1 = fork();
    40a4:	00001097          	auipc	ra,0x1
    40a8:	7bc080e7          	jalr	1980(ra) # 5860 <fork>
    40ac:	84aa                	mv	s1,a0
    if(pid1 < 0){
    40ae:	02054f63          	bltz	a0,40ec <killstatus+0x60>
    if(pid1 == 0){
    40b2:	c939                	beqz	a0,4108 <killstatus+0x7c>
    sleep(1);
    40b4:	4505                	li	a0,1
    40b6:	00002097          	auipc	ra,0x2
    40ba:	842080e7          	jalr	-1982(ra) # 58f8 <sleep>
    kill(pid1);
    40be:	8526                	mv	a0,s1
    40c0:	00001097          	auipc	ra,0x1
    40c4:	7d8080e7          	jalr	2008(ra) # 5898 <kill>
    wait(&xst);
    40c8:	fcc40513          	addi	a0,s0,-52
    40cc:	00001097          	auipc	ra,0x1
    40d0:	7a4080e7          	jalr	1956(ra) # 5870 <wait>
    if(xst != -1) {
    40d4:	fcc42783          	lw	a5,-52(s0)
    40d8:	03379d63          	bne	a5,s3,4112 <killstatus+0x86>
  for(int i = 0; i < 100; i++){
    40dc:	397d                	addiw	s2,s2,-1
    40de:	fc0913e3          	bnez	s2,40a4 <killstatus+0x18>
  exit(0);
    40e2:	4501                	li	a0,0
    40e4:	00001097          	auipc	ra,0x1
    40e8:	784080e7          	jalr	1924(ra) # 5868 <exit>
      printf("%s: fork failed\n", s);
    40ec:	85d2                	mv	a1,s4
    40ee:	00003517          	auipc	a0,0x3
    40f2:	89250513          	addi	a0,a0,-1902 # 6980 <malloc+0xcb6>
    40f6:	00002097          	auipc	ra,0x2
    40fa:	b16080e7          	jalr	-1258(ra) # 5c0c <printf>
      exit(1);
    40fe:	4505                	li	a0,1
    4100:	00001097          	auipc	ra,0x1
    4104:	768080e7          	jalr	1896(ra) # 5868 <exit>
        getpid();
    4108:	00001097          	auipc	ra,0x1
    410c:	7e0080e7          	jalr	2016(ra) # 58e8 <getpid>
      while(1) {
    4110:	bfe5                	j	4108 <killstatus+0x7c>
       printf("%s: status should be -1\n", s);
    4112:	85d2                	mv	a1,s4
    4114:	00004517          	auipc	a0,0x4
    4118:	aec50513          	addi	a0,a0,-1300 # 7c00 <malloc+0x1f36>
    411c:	00002097          	auipc	ra,0x2
    4120:	af0080e7          	jalr	-1296(ra) # 5c0c <printf>
       exit(1);
    4124:	4505                	li	a0,1
    4126:	00001097          	auipc	ra,0x1
    412a:	742080e7          	jalr	1858(ra) # 5868 <exit>

000000000000412e <preempt>:
{
    412e:	7139                	addi	sp,sp,-64
    4130:	fc06                	sd	ra,56(sp)
    4132:	f822                	sd	s0,48(sp)
    4134:	f426                	sd	s1,40(sp)
    4136:	f04a                	sd	s2,32(sp)
    4138:	ec4e                	sd	s3,24(sp)
    413a:	e852                	sd	s4,16(sp)
    413c:	0080                	addi	s0,sp,64
    413e:	84aa                	mv	s1,a0
  pid1 = fork();
    4140:	00001097          	auipc	ra,0x1
    4144:	720080e7          	jalr	1824(ra) # 5860 <fork>
  if(pid1 < 0) {
    4148:	00054563          	bltz	a0,4152 <preempt+0x24>
    414c:	8a2a                	mv	s4,a0
  if(pid1 == 0)
    414e:	e105                	bnez	a0,416e <preempt+0x40>
    for(;;)
    4150:	a001                	j	4150 <preempt+0x22>
    printf("%s: fork failed", s);
    4152:	85a6                	mv	a1,s1
    4154:	00003517          	auipc	a0,0x3
    4158:	9ec50513          	addi	a0,a0,-1556 # 6b40 <malloc+0xe76>
    415c:	00002097          	auipc	ra,0x2
    4160:	ab0080e7          	jalr	-1360(ra) # 5c0c <printf>
    exit(1);
    4164:	4505                	li	a0,1
    4166:	00001097          	auipc	ra,0x1
    416a:	702080e7          	jalr	1794(ra) # 5868 <exit>
  pid2 = fork();
    416e:	00001097          	auipc	ra,0x1
    4172:	6f2080e7          	jalr	1778(ra) # 5860 <fork>
    4176:	89aa                	mv	s3,a0
  if(pid2 < 0) {
    4178:	00054463          	bltz	a0,4180 <preempt+0x52>
  if(pid2 == 0)
    417c:	e105                	bnez	a0,419c <preempt+0x6e>
    for(;;)
    417e:	a001                	j	417e <preempt+0x50>
    printf("%s: fork failed\n", s);
    4180:	85a6                	mv	a1,s1
    4182:	00002517          	auipc	a0,0x2
    4186:	7fe50513          	addi	a0,a0,2046 # 6980 <malloc+0xcb6>
    418a:	00002097          	auipc	ra,0x2
    418e:	a82080e7          	jalr	-1406(ra) # 5c0c <printf>
    exit(1);
    4192:	4505                	li	a0,1
    4194:	00001097          	auipc	ra,0x1
    4198:	6d4080e7          	jalr	1748(ra) # 5868 <exit>
  pipe(pfds);
    419c:	fc840513          	addi	a0,s0,-56
    41a0:	00001097          	auipc	ra,0x1
    41a4:	6d8080e7          	jalr	1752(ra) # 5878 <pipe>
  pid3 = fork();
    41a8:	00001097          	auipc	ra,0x1
    41ac:	6b8080e7          	jalr	1720(ra) # 5860 <fork>
    41b0:	892a                	mv	s2,a0
  if(pid3 < 0) {
    41b2:	02054e63          	bltz	a0,41ee <preempt+0xc0>
  if(pid3 == 0){
    41b6:	e525                	bnez	a0,421e <preempt+0xf0>
    close(pfds[0]);
    41b8:	fc842503          	lw	a0,-56(s0)
    41bc:	00001097          	auipc	ra,0x1
    41c0:	6d4080e7          	jalr	1748(ra) # 5890 <close>
    if(write(pfds[1], "x", 1) != 1)
    41c4:	4605                	li	a2,1
    41c6:	00002597          	auipc	a1,0x2
    41ca:	ff258593          	addi	a1,a1,-14 # 61b8 <malloc+0x4ee>
    41ce:	fcc42503          	lw	a0,-52(s0)
    41d2:	00001097          	auipc	ra,0x1
    41d6:	6b6080e7          	jalr	1718(ra) # 5888 <write>
    41da:	4785                	li	a5,1
    41dc:	02f51763          	bne	a0,a5,420a <preempt+0xdc>
    close(pfds[1]);
    41e0:	fcc42503          	lw	a0,-52(s0)
    41e4:	00001097          	auipc	ra,0x1
    41e8:	6ac080e7          	jalr	1708(ra) # 5890 <close>
    for(;;)
    41ec:	a001                	j	41ec <preempt+0xbe>
     printf("%s: fork failed\n", s);
    41ee:	85a6                	mv	a1,s1
    41f0:	00002517          	auipc	a0,0x2
    41f4:	79050513          	addi	a0,a0,1936 # 6980 <malloc+0xcb6>
    41f8:	00002097          	auipc	ra,0x2
    41fc:	a14080e7          	jalr	-1516(ra) # 5c0c <printf>
     exit(1);
    4200:	4505                	li	a0,1
    4202:	00001097          	auipc	ra,0x1
    4206:	666080e7          	jalr	1638(ra) # 5868 <exit>
      printf("%s: preempt write error", s);
    420a:	85a6                	mv	a1,s1
    420c:	00004517          	auipc	a0,0x4
    4210:	a1450513          	addi	a0,a0,-1516 # 7c20 <malloc+0x1f56>
    4214:	00002097          	auipc	ra,0x2
    4218:	9f8080e7          	jalr	-1544(ra) # 5c0c <printf>
    421c:	b7d1                	j	41e0 <preempt+0xb2>
  close(pfds[1]);
    421e:	fcc42503          	lw	a0,-52(s0)
    4222:	00001097          	auipc	ra,0x1
    4226:	66e080e7          	jalr	1646(ra) # 5890 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    422a:	660d                	lui	a2,0x3
    422c:	00008597          	auipc	a1,0x8
    4230:	ba458593          	addi	a1,a1,-1116 # bdd0 <buf>
    4234:	fc842503          	lw	a0,-56(s0)
    4238:	00001097          	auipc	ra,0x1
    423c:	648080e7          	jalr	1608(ra) # 5880 <read>
    4240:	4785                	li	a5,1
    4242:	02f50363          	beq	a0,a5,4268 <preempt+0x13a>
    printf("%s: preempt read error", s);
    4246:	85a6                	mv	a1,s1
    4248:	00004517          	auipc	a0,0x4
    424c:	9f050513          	addi	a0,a0,-1552 # 7c38 <malloc+0x1f6e>
    4250:	00002097          	auipc	ra,0x2
    4254:	9bc080e7          	jalr	-1604(ra) # 5c0c <printf>
}
    4258:	70e2                	ld	ra,56(sp)
    425a:	7442                	ld	s0,48(sp)
    425c:	74a2                	ld	s1,40(sp)
    425e:	7902                	ld	s2,32(sp)
    4260:	69e2                	ld	s3,24(sp)
    4262:	6a42                	ld	s4,16(sp)
    4264:	6121                	addi	sp,sp,64
    4266:	8082                	ret
  close(pfds[0]);
    4268:	fc842503          	lw	a0,-56(s0)
    426c:	00001097          	auipc	ra,0x1
    4270:	624080e7          	jalr	1572(ra) # 5890 <close>
  printf("kill... ");
    4274:	00004517          	auipc	a0,0x4
    4278:	9dc50513          	addi	a0,a0,-1572 # 7c50 <malloc+0x1f86>
    427c:	00002097          	auipc	ra,0x2
    4280:	990080e7          	jalr	-1648(ra) # 5c0c <printf>
  kill(pid1);
    4284:	8552                	mv	a0,s4
    4286:	00001097          	auipc	ra,0x1
    428a:	612080e7          	jalr	1554(ra) # 5898 <kill>
  kill(pid2);
    428e:	854e                	mv	a0,s3
    4290:	00001097          	auipc	ra,0x1
    4294:	608080e7          	jalr	1544(ra) # 5898 <kill>
  kill(pid3);
    4298:	854a                	mv	a0,s2
    429a:	00001097          	auipc	ra,0x1
    429e:	5fe080e7          	jalr	1534(ra) # 5898 <kill>
  printf("wait... ");
    42a2:	00004517          	auipc	a0,0x4
    42a6:	9be50513          	addi	a0,a0,-1602 # 7c60 <malloc+0x1f96>
    42aa:	00002097          	auipc	ra,0x2
    42ae:	962080e7          	jalr	-1694(ra) # 5c0c <printf>
  wait(0);
    42b2:	4501                	li	a0,0
    42b4:	00001097          	auipc	ra,0x1
    42b8:	5bc080e7          	jalr	1468(ra) # 5870 <wait>
  wait(0);
    42bc:	4501                	li	a0,0
    42be:	00001097          	auipc	ra,0x1
    42c2:	5b2080e7          	jalr	1458(ra) # 5870 <wait>
  wait(0);
    42c6:	4501                	li	a0,0
    42c8:	00001097          	auipc	ra,0x1
    42cc:	5a8080e7          	jalr	1448(ra) # 5870 <wait>
    42d0:	b761                	j	4258 <preempt+0x12a>

00000000000042d2 <reparent>:
{
    42d2:	7179                	addi	sp,sp,-48
    42d4:	f406                	sd	ra,40(sp)
    42d6:	f022                	sd	s0,32(sp)
    42d8:	ec26                	sd	s1,24(sp)
    42da:	e84a                	sd	s2,16(sp)
    42dc:	e44e                	sd	s3,8(sp)
    42de:	e052                	sd	s4,0(sp)
    42e0:	1800                	addi	s0,sp,48
    42e2:	89aa                	mv	s3,a0
  int master_pid = getpid();
    42e4:	00001097          	auipc	ra,0x1
    42e8:	604080e7          	jalr	1540(ra) # 58e8 <getpid>
    42ec:	8a2a                	mv	s4,a0
    42ee:	0c800913          	li	s2,200
    int pid = fork();
    42f2:	00001097          	auipc	ra,0x1
    42f6:	56e080e7          	jalr	1390(ra) # 5860 <fork>
    42fa:	84aa                	mv	s1,a0
    if(pid < 0){
    42fc:	02054263          	bltz	a0,4320 <reparent+0x4e>
    if(pid){
    4300:	cd21                	beqz	a0,4358 <reparent+0x86>
      if(wait(0) != pid){
    4302:	4501                	li	a0,0
    4304:	00001097          	auipc	ra,0x1
    4308:	56c080e7          	jalr	1388(ra) # 5870 <wait>
    430c:	02951863          	bne	a0,s1,433c <reparent+0x6a>
  for(int i = 0; i < 200; i++){
    4310:	397d                	addiw	s2,s2,-1
    4312:	fe0910e3          	bnez	s2,42f2 <reparent+0x20>
  exit(0);
    4316:	4501                	li	a0,0
    4318:	00001097          	auipc	ra,0x1
    431c:	550080e7          	jalr	1360(ra) # 5868 <exit>
      printf("%s: fork failed\n", s);
    4320:	85ce                	mv	a1,s3
    4322:	00002517          	auipc	a0,0x2
    4326:	65e50513          	addi	a0,a0,1630 # 6980 <malloc+0xcb6>
    432a:	00002097          	auipc	ra,0x2
    432e:	8e2080e7          	jalr	-1822(ra) # 5c0c <printf>
      exit(1);
    4332:	4505                	li	a0,1
    4334:	00001097          	auipc	ra,0x1
    4338:	534080e7          	jalr	1332(ra) # 5868 <exit>
        printf("%s: wait wrong pid\n", s);
    433c:	85ce                	mv	a1,s3
    433e:	00002517          	auipc	a0,0x2
    4342:	7ca50513          	addi	a0,a0,1994 # 6b08 <malloc+0xe3e>
    4346:	00002097          	auipc	ra,0x2
    434a:	8c6080e7          	jalr	-1850(ra) # 5c0c <printf>
        exit(1);
    434e:	4505                	li	a0,1
    4350:	00001097          	auipc	ra,0x1
    4354:	518080e7          	jalr	1304(ra) # 5868 <exit>
      int pid2 = fork();
    4358:	00001097          	auipc	ra,0x1
    435c:	508080e7          	jalr	1288(ra) # 5860 <fork>
      if(pid2 < 0){
    4360:	00054763          	bltz	a0,436e <reparent+0x9c>
      exit(0);
    4364:	4501                	li	a0,0
    4366:	00001097          	auipc	ra,0x1
    436a:	502080e7          	jalr	1282(ra) # 5868 <exit>
        kill(master_pid);
    436e:	8552                	mv	a0,s4
    4370:	00001097          	auipc	ra,0x1
    4374:	528080e7          	jalr	1320(ra) # 5898 <kill>
        exit(1);
    4378:	4505                	li	a0,1
    437a:	00001097          	auipc	ra,0x1
    437e:	4ee080e7          	jalr	1262(ra) # 5868 <exit>

0000000000004382 <sbrkfail>:
{
    4382:	7119                	addi	sp,sp,-128
    4384:	fc86                	sd	ra,120(sp)
    4386:	f8a2                	sd	s0,112(sp)
    4388:	f4a6                	sd	s1,104(sp)
    438a:	f0ca                	sd	s2,96(sp)
    438c:	ecce                	sd	s3,88(sp)
    438e:	e8d2                	sd	s4,80(sp)
    4390:	e4d6                	sd	s5,72(sp)
    4392:	0100                	addi	s0,sp,128
    4394:	892a                	mv	s2,a0
  if(pipe(fds) != 0){
    4396:	fb040513          	addi	a0,s0,-80
    439a:	00001097          	auipc	ra,0x1
    439e:	4de080e7          	jalr	1246(ra) # 5878 <pipe>
    43a2:	e901                	bnez	a0,43b2 <sbrkfail+0x30>
    43a4:	f8040493          	addi	s1,s0,-128
    43a8:	fa840a13          	addi	s4,s0,-88
    43ac:	89a6                	mv	s3,s1
    if(pids[i] != -1)
    43ae:	5afd                	li	s5,-1
    43b0:	a08d                	j	4412 <sbrkfail+0x90>
    printf("%s: pipe() failed\n", s);
    43b2:	85ca                	mv	a1,s2
    43b4:	00002517          	auipc	a0,0x2
    43b8:	6d450513          	addi	a0,a0,1748 # 6a88 <malloc+0xdbe>
    43bc:	00002097          	auipc	ra,0x2
    43c0:	850080e7          	jalr	-1968(ra) # 5c0c <printf>
    exit(1);
    43c4:	4505                	li	a0,1
    43c6:	00001097          	auipc	ra,0x1
    43ca:	4a2080e7          	jalr	1186(ra) # 5868 <exit>
      sbrk(BIG - (uint64)sbrk(0));
    43ce:	4501                	li	a0,0
    43d0:	00001097          	auipc	ra,0x1
    43d4:	520080e7          	jalr	1312(ra) # 58f0 <sbrk>
    43d8:	064007b7          	lui	a5,0x6400
    43dc:	40a7853b          	subw	a0,a5,a0
    43e0:	00001097          	auipc	ra,0x1
    43e4:	510080e7          	jalr	1296(ra) # 58f0 <sbrk>
      write(fds[1], "x", 1);
    43e8:	4605                	li	a2,1
    43ea:	00002597          	auipc	a1,0x2
    43ee:	dce58593          	addi	a1,a1,-562 # 61b8 <malloc+0x4ee>
    43f2:	fb442503          	lw	a0,-76(s0)
    43f6:	00001097          	auipc	ra,0x1
    43fa:	492080e7          	jalr	1170(ra) # 5888 <write>
      for(;;) sleep(1000);
    43fe:	3e800513          	li	a0,1000
    4402:	00001097          	auipc	ra,0x1
    4406:	4f6080e7          	jalr	1270(ra) # 58f8 <sleep>
    440a:	bfd5                	j	43fe <sbrkfail+0x7c>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    440c:	0991                	addi	s3,s3,4
    440e:	03498563          	beq	s3,s4,4438 <sbrkfail+0xb6>
    if((pids[i] = fork()) == 0){
    4412:	00001097          	auipc	ra,0x1
    4416:	44e080e7          	jalr	1102(ra) # 5860 <fork>
    441a:	00a9a023          	sw	a0,0(s3)
    441e:	d945                	beqz	a0,43ce <sbrkfail+0x4c>
    if(pids[i] != -1)
    4420:	ff5506e3          	beq	a0,s5,440c <sbrkfail+0x8a>
      read(fds[0], &scratch, 1);
    4424:	4605                	li	a2,1
    4426:	faf40593          	addi	a1,s0,-81
    442a:	fb042503          	lw	a0,-80(s0)
    442e:	00001097          	auipc	ra,0x1
    4432:	452080e7          	jalr	1106(ra) # 5880 <read>
    4436:	bfd9                	j	440c <sbrkfail+0x8a>
  c = sbrk(PGSIZE);
    4438:	6505                	lui	a0,0x1
    443a:	00001097          	auipc	ra,0x1
    443e:	4b6080e7          	jalr	1206(ra) # 58f0 <sbrk>
    4442:	89aa                	mv	s3,a0
    if(pids[i] == -1)
    4444:	5afd                	li	s5,-1
    4446:	a021                	j	444e <sbrkfail+0xcc>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    4448:	0491                	addi	s1,s1,4
    444a:	01448f63          	beq	s1,s4,4468 <sbrkfail+0xe6>
    if(pids[i] == -1)
    444e:	4088                	lw	a0,0(s1)
    4450:	ff550ce3          	beq	a0,s5,4448 <sbrkfail+0xc6>
    kill(pids[i]);
    4454:	00001097          	auipc	ra,0x1
    4458:	444080e7          	jalr	1092(ra) # 5898 <kill>
    wait(0);
    445c:	4501                	li	a0,0
    445e:	00001097          	auipc	ra,0x1
    4462:	412080e7          	jalr	1042(ra) # 5870 <wait>
    4466:	b7cd                	j	4448 <sbrkfail+0xc6>
  if(c == (char*)0xffffffffffffffffL){
    4468:	57fd                	li	a5,-1
    446a:	04f98163          	beq	s3,a5,44ac <sbrkfail+0x12a>
  pid = fork();
    446e:	00001097          	auipc	ra,0x1
    4472:	3f2080e7          	jalr	1010(ra) # 5860 <fork>
    4476:	84aa                	mv	s1,a0
  if(pid < 0){
    4478:	04054863          	bltz	a0,44c8 <sbrkfail+0x146>
  if(pid == 0){
    447c:	c525                	beqz	a0,44e4 <sbrkfail+0x162>
  wait(&xstatus);
    447e:	fbc40513          	addi	a0,s0,-68
    4482:	00001097          	auipc	ra,0x1
    4486:	3ee080e7          	jalr	1006(ra) # 5870 <wait>
  if(xstatus != -1 && xstatus != 2)
    448a:	fbc42783          	lw	a5,-68(s0)
    448e:	577d                	li	a4,-1
    4490:	00e78563          	beq	a5,a4,449a <sbrkfail+0x118>
    4494:	4709                	li	a4,2
    4496:	08e79d63          	bne	a5,a4,4530 <sbrkfail+0x1ae>
}
    449a:	70e6                	ld	ra,120(sp)
    449c:	7446                	ld	s0,112(sp)
    449e:	74a6                	ld	s1,104(sp)
    44a0:	7906                	ld	s2,96(sp)
    44a2:	69e6                	ld	s3,88(sp)
    44a4:	6a46                	ld	s4,80(sp)
    44a6:	6aa6                	ld	s5,72(sp)
    44a8:	6109                	addi	sp,sp,128
    44aa:	8082                	ret
    printf("%s: failed sbrk leaked memory\n", s);
    44ac:	85ca                	mv	a1,s2
    44ae:	00003517          	auipc	a0,0x3
    44b2:	7c250513          	addi	a0,a0,1986 # 7c70 <malloc+0x1fa6>
    44b6:	00001097          	auipc	ra,0x1
    44ba:	756080e7          	jalr	1878(ra) # 5c0c <printf>
    exit(1);
    44be:	4505                	li	a0,1
    44c0:	00001097          	auipc	ra,0x1
    44c4:	3a8080e7          	jalr	936(ra) # 5868 <exit>
    printf("%s: fork failed\n", s);
    44c8:	85ca                	mv	a1,s2
    44ca:	00002517          	auipc	a0,0x2
    44ce:	4b650513          	addi	a0,a0,1206 # 6980 <malloc+0xcb6>
    44d2:	00001097          	auipc	ra,0x1
    44d6:	73a080e7          	jalr	1850(ra) # 5c0c <printf>
    exit(1);
    44da:	4505                	li	a0,1
    44dc:	00001097          	auipc	ra,0x1
    44e0:	38c080e7          	jalr	908(ra) # 5868 <exit>
    a = sbrk(0);
    44e4:	4501                	li	a0,0
    44e6:	00001097          	auipc	ra,0x1
    44ea:	40a080e7          	jalr	1034(ra) # 58f0 <sbrk>
    44ee:	89aa                	mv	s3,a0
    sbrk(10*BIG);
    44f0:	3e800537          	lui	a0,0x3e800
    44f4:	00001097          	auipc	ra,0x1
    44f8:	3fc080e7          	jalr	1020(ra) # 58f0 <sbrk>
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    44fc:	874e                	mv	a4,s3
    44fe:	3e8007b7          	lui	a5,0x3e800
    4502:	97ce                	add	a5,a5,s3
    4504:	6685                	lui	a3,0x1
      n += *(a+i);
    4506:	00074603          	lbu	a2,0(a4)
    450a:	9cb1                	addw	s1,s1,a2
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    450c:	9736                	add	a4,a4,a3
    450e:	fef71ce3          	bne	a4,a5,4506 <sbrkfail+0x184>
    printf("%s: allocate a lot of memory succeeded %d\n", s, n);
    4512:	8626                	mv	a2,s1
    4514:	85ca                	mv	a1,s2
    4516:	00003517          	auipc	a0,0x3
    451a:	77a50513          	addi	a0,a0,1914 # 7c90 <malloc+0x1fc6>
    451e:	00001097          	auipc	ra,0x1
    4522:	6ee080e7          	jalr	1774(ra) # 5c0c <printf>
    exit(1);
    4526:	4505                	li	a0,1
    4528:	00001097          	auipc	ra,0x1
    452c:	340080e7          	jalr	832(ra) # 5868 <exit>
    exit(1);
    4530:	4505                	li	a0,1
    4532:	00001097          	auipc	ra,0x1
    4536:	336080e7          	jalr	822(ra) # 5868 <exit>

000000000000453a <mem>:
{
    453a:	7139                	addi	sp,sp,-64
    453c:	fc06                	sd	ra,56(sp)
    453e:	f822                	sd	s0,48(sp)
    4540:	f426                	sd	s1,40(sp)
    4542:	f04a                	sd	s2,32(sp)
    4544:	ec4e                	sd	s3,24(sp)
    4546:	0080                	addi	s0,sp,64
    4548:	89aa                	mv	s3,a0
  if((pid = fork()) == 0){
    454a:	00001097          	auipc	ra,0x1
    454e:	316080e7          	jalr	790(ra) # 5860 <fork>
    m1 = 0;
    4552:	4481                	li	s1,0
    while((m2 = malloc(10001)) != 0){
    4554:	6909                	lui	s2,0x2
    4556:	71190913          	addi	s2,s2,1809 # 2711 <sbrkbasic+0xab>
  if((pid = fork()) == 0){
    455a:	ed39                	bnez	a0,45b8 <mem+0x7e>
    while((m2 = malloc(10001)) != 0){
    455c:	854a                	mv	a0,s2
    455e:	00001097          	auipc	ra,0x1
    4562:	76c080e7          	jalr	1900(ra) # 5cca <malloc>
    4566:	c501                	beqz	a0,456e <mem+0x34>
      *(char**)m2 = m1;
    4568:	e104                	sd	s1,0(a0)
      m1 = m2;
    456a:	84aa                	mv	s1,a0
    456c:	bfc5                	j	455c <mem+0x22>
    while(m1){
    456e:	c881                	beqz	s1,457e <mem+0x44>
      m2 = *(char**)m1;
    4570:	8526                	mv	a0,s1
    4572:	6084                	ld	s1,0(s1)
      free(m1);
    4574:	00001097          	auipc	ra,0x1
    4578:	6ce080e7          	jalr	1742(ra) # 5c42 <free>
    while(m1){
    457c:	f8f5                	bnez	s1,4570 <mem+0x36>
    m1 = malloc(1024*20);
    457e:	6515                	lui	a0,0x5
    4580:	00001097          	auipc	ra,0x1
    4584:	74a080e7          	jalr	1866(ra) # 5cca <malloc>
    if(m1 == 0){
    4588:	c911                	beqz	a0,459c <mem+0x62>
    free(m1);
    458a:	00001097          	auipc	ra,0x1
    458e:	6b8080e7          	jalr	1720(ra) # 5c42 <free>
    exit(0);
    4592:	4501                	li	a0,0
    4594:	00001097          	auipc	ra,0x1
    4598:	2d4080e7          	jalr	724(ra) # 5868 <exit>
      printf("couldn't allocate mem?!!\n", s);
    459c:	85ce                	mv	a1,s3
    459e:	00003517          	auipc	a0,0x3
    45a2:	72250513          	addi	a0,a0,1826 # 7cc0 <malloc+0x1ff6>
    45a6:	00001097          	auipc	ra,0x1
    45aa:	666080e7          	jalr	1638(ra) # 5c0c <printf>
      exit(1);
    45ae:	4505                	li	a0,1
    45b0:	00001097          	auipc	ra,0x1
    45b4:	2b8080e7          	jalr	696(ra) # 5868 <exit>
    wait(&xstatus);
    45b8:	fcc40513          	addi	a0,s0,-52
    45bc:	00001097          	auipc	ra,0x1
    45c0:	2b4080e7          	jalr	692(ra) # 5870 <wait>
    if(xstatus == -1){
    45c4:	fcc42503          	lw	a0,-52(s0)
    45c8:	57fd                	li	a5,-1
    45ca:	00f50663          	beq	a0,a5,45d6 <mem+0x9c>
    exit(xstatus);
    45ce:	00001097          	auipc	ra,0x1
    45d2:	29a080e7          	jalr	666(ra) # 5868 <exit>
      exit(0);
    45d6:	4501                	li	a0,0
    45d8:	00001097          	auipc	ra,0x1
    45dc:	290080e7          	jalr	656(ra) # 5868 <exit>

00000000000045e0 <sharedfd>:
{
    45e0:	7159                	addi	sp,sp,-112
    45e2:	f486                	sd	ra,104(sp)
    45e4:	f0a2                	sd	s0,96(sp)
    45e6:	eca6                	sd	s1,88(sp)
    45e8:	e8ca                	sd	s2,80(sp)
    45ea:	e4ce                	sd	s3,72(sp)
    45ec:	e0d2                	sd	s4,64(sp)
    45ee:	fc56                	sd	s5,56(sp)
    45f0:	f85a                	sd	s6,48(sp)
    45f2:	f45e                	sd	s7,40(sp)
    45f4:	1880                	addi	s0,sp,112
    45f6:	8a2a                	mv	s4,a0
  unlink("sharedfd");
    45f8:	00002517          	auipc	a0,0x2
    45fc:	96050513          	addi	a0,a0,-1696 # 5f58 <malloc+0x28e>
    4600:	00001097          	auipc	ra,0x1
    4604:	2b8080e7          	jalr	696(ra) # 58b8 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    4608:	20200593          	li	a1,514
    460c:	00002517          	auipc	a0,0x2
    4610:	94c50513          	addi	a0,a0,-1716 # 5f58 <malloc+0x28e>
    4614:	00001097          	auipc	ra,0x1
    4618:	294080e7          	jalr	660(ra) # 58a8 <open>
  if(fd < 0){
    461c:	04054a63          	bltz	a0,4670 <sharedfd+0x90>
    4620:	892a                	mv	s2,a0
  pid = fork();
    4622:	00001097          	auipc	ra,0x1
    4626:	23e080e7          	jalr	574(ra) # 5860 <fork>
    462a:	89aa                	mv	s3,a0
  memset(buf, pid==0?'c':'p', sizeof(buf));
    462c:	06300593          	li	a1,99
    4630:	c119                	beqz	a0,4636 <sharedfd+0x56>
    4632:	07000593          	li	a1,112
    4636:	4629                	li	a2,10
    4638:	fa040513          	addi	a0,s0,-96
    463c:	00001097          	auipc	ra,0x1
    4640:	012080e7          	jalr	18(ra) # 564e <memset>
    4644:	3e800493          	li	s1,1000
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    4648:	4629                	li	a2,10
    464a:	fa040593          	addi	a1,s0,-96
    464e:	854a                	mv	a0,s2
    4650:	00001097          	auipc	ra,0x1
    4654:	238080e7          	jalr	568(ra) # 5888 <write>
    4658:	47a9                	li	a5,10
    465a:	02f51963          	bne	a0,a5,468c <sharedfd+0xac>
  for(i = 0; i < N; i++){
    465e:	34fd                	addiw	s1,s1,-1
    4660:	f4e5                	bnez	s1,4648 <sharedfd+0x68>
  if(pid == 0) {
    4662:	04099363          	bnez	s3,46a8 <sharedfd+0xc8>
    exit(0);
    4666:	4501                	li	a0,0
    4668:	00001097          	auipc	ra,0x1
    466c:	200080e7          	jalr	512(ra) # 5868 <exit>
    printf("%s: cannot open sharedfd for writing", s);
    4670:	85d2                	mv	a1,s4
    4672:	00003517          	auipc	a0,0x3
    4676:	66e50513          	addi	a0,a0,1646 # 7ce0 <malloc+0x2016>
    467a:	00001097          	auipc	ra,0x1
    467e:	592080e7          	jalr	1426(ra) # 5c0c <printf>
    exit(1);
    4682:	4505                	li	a0,1
    4684:	00001097          	auipc	ra,0x1
    4688:	1e4080e7          	jalr	484(ra) # 5868 <exit>
      printf("%s: write sharedfd failed\n", s);
    468c:	85d2                	mv	a1,s4
    468e:	00003517          	auipc	a0,0x3
    4692:	67a50513          	addi	a0,a0,1658 # 7d08 <malloc+0x203e>
    4696:	00001097          	auipc	ra,0x1
    469a:	576080e7          	jalr	1398(ra) # 5c0c <printf>
      exit(1);
    469e:	4505                	li	a0,1
    46a0:	00001097          	auipc	ra,0x1
    46a4:	1c8080e7          	jalr	456(ra) # 5868 <exit>
    wait(&xstatus);
    46a8:	f9c40513          	addi	a0,s0,-100
    46ac:	00001097          	auipc	ra,0x1
    46b0:	1c4080e7          	jalr	452(ra) # 5870 <wait>
    if(xstatus != 0)
    46b4:	f9c42983          	lw	s3,-100(s0)
    46b8:	00098763          	beqz	s3,46c6 <sharedfd+0xe6>
      exit(xstatus);
    46bc:	854e                	mv	a0,s3
    46be:	00001097          	auipc	ra,0x1
    46c2:	1aa080e7          	jalr	426(ra) # 5868 <exit>
  close(fd);
    46c6:	854a                	mv	a0,s2
    46c8:	00001097          	auipc	ra,0x1
    46cc:	1c8080e7          	jalr	456(ra) # 5890 <close>
  fd = open("sharedfd", 0);
    46d0:	4581                	li	a1,0
    46d2:	00002517          	auipc	a0,0x2
    46d6:	88650513          	addi	a0,a0,-1914 # 5f58 <malloc+0x28e>
    46da:	00001097          	auipc	ra,0x1
    46de:	1ce080e7          	jalr	462(ra) # 58a8 <open>
    46e2:	8baa                	mv	s7,a0
  nc = np = 0;
    46e4:	8ace                	mv	s5,s3
  if(fd < 0){
    46e6:	02054563          	bltz	a0,4710 <sharedfd+0x130>
    46ea:	faa40913          	addi	s2,s0,-86
      if(buf[i] == 'c')
    46ee:	06300493          	li	s1,99
      if(buf[i] == 'p')
    46f2:	07000b13          	li	s6,112
  while((n = read(fd, buf, sizeof(buf))) > 0){
    46f6:	4629                	li	a2,10
    46f8:	fa040593          	addi	a1,s0,-96
    46fc:	855e                	mv	a0,s7
    46fe:	00001097          	auipc	ra,0x1
    4702:	182080e7          	jalr	386(ra) # 5880 <read>
    4706:	02a05f63          	blez	a0,4744 <sharedfd+0x164>
    470a:	fa040793          	addi	a5,s0,-96
    470e:	a01d                	j	4734 <sharedfd+0x154>
    printf("%s: cannot open sharedfd for reading\n", s);
    4710:	85d2                	mv	a1,s4
    4712:	00003517          	auipc	a0,0x3
    4716:	61650513          	addi	a0,a0,1558 # 7d28 <malloc+0x205e>
    471a:	00001097          	auipc	ra,0x1
    471e:	4f2080e7          	jalr	1266(ra) # 5c0c <printf>
    exit(1);
    4722:	4505                	li	a0,1
    4724:	00001097          	auipc	ra,0x1
    4728:	144080e7          	jalr	324(ra) # 5868 <exit>
        nc++;
    472c:	2985                	addiw	s3,s3,1
    for(i = 0; i < sizeof(buf); i++){
    472e:	0785                	addi	a5,a5,1
    4730:	fd2783e3          	beq	a5,s2,46f6 <sharedfd+0x116>
      if(buf[i] == 'c')
    4734:	0007c703          	lbu	a4,0(a5) # 3e800000 <__BSS_END__+0x3e7f1220>
    4738:	fe970ae3          	beq	a4,s1,472c <sharedfd+0x14c>
      if(buf[i] == 'p')
    473c:	ff6719e3          	bne	a4,s6,472e <sharedfd+0x14e>
        np++;
    4740:	2a85                	addiw	s5,s5,1
    4742:	b7f5                	j	472e <sharedfd+0x14e>
  close(fd);
    4744:	855e                	mv	a0,s7
    4746:	00001097          	auipc	ra,0x1
    474a:	14a080e7          	jalr	330(ra) # 5890 <close>
  unlink("sharedfd");
    474e:	00002517          	auipc	a0,0x2
    4752:	80a50513          	addi	a0,a0,-2038 # 5f58 <malloc+0x28e>
    4756:	00001097          	auipc	ra,0x1
    475a:	162080e7          	jalr	354(ra) # 58b8 <unlink>
  if(nc == N*SZ && np == N*SZ){
    475e:	6789                	lui	a5,0x2
    4760:	71078793          	addi	a5,a5,1808 # 2710 <sbrkbasic+0xaa>
    4764:	00f99763          	bne	s3,a5,4772 <sharedfd+0x192>
    4768:	6789                	lui	a5,0x2
    476a:	71078793          	addi	a5,a5,1808 # 2710 <sbrkbasic+0xaa>
    476e:	02fa8063          	beq	s5,a5,478e <sharedfd+0x1ae>
    printf("%s: nc/np test fails\n", s);
    4772:	85d2                	mv	a1,s4
    4774:	00003517          	auipc	a0,0x3
    4778:	5dc50513          	addi	a0,a0,1500 # 7d50 <malloc+0x2086>
    477c:	00001097          	auipc	ra,0x1
    4780:	490080e7          	jalr	1168(ra) # 5c0c <printf>
    exit(1);
    4784:	4505                	li	a0,1
    4786:	00001097          	auipc	ra,0x1
    478a:	0e2080e7          	jalr	226(ra) # 5868 <exit>
    exit(0);
    478e:	4501                	li	a0,0
    4790:	00001097          	auipc	ra,0x1
    4794:	0d8080e7          	jalr	216(ra) # 5868 <exit>

0000000000004798 <fourfiles>:
{
    4798:	7171                	addi	sp,sp,-176
    479a:	f506                	sd	ra,168(sp)
    479c:	f122                	sd	s0,160(sp)
    479e:	ed26                	sd	s1,152(sp)
    47a0:	e94a                	sd	s2,144(sp)
    47a2:	e54e                	sd	s3,136(sp)
    47a4:	e152                	sd	s4,128(sp)
    47a6:	fcd6                	sd	s5,120(sp)
    47a8:	f8da                	sd	s6,112(sp)
    47aa:	f4de                	sd	s7,104(sp)
    47ac:	f0e2                	sd	s8,96(sp)
    47ae:	ece6                	sd	s9,88(sp)
    47b0:	e8ea                	sd	s10,80(sp)
    47b2:	e4ee                	sd	s11,72(sp)
    47b4:	1900                	addi	s0,sp,176
    47b6:	8caa                	mv	s9,a0
  char *names[] = { "f0", "f1", "f2", "f3" };
    47b8:	00001797          	auipc	a5,0x1
    47bc:	5f878793          	addi	a5,a5,1528 # 5db0 <malloc+0xe6>
    47c0:	f6f43823          	sd	a5,-144(s0)
    47c4:	00001797          	auipc	a5,0x1
    47c8:	5f478793          	addi	a5,a5,1524 # 5db8 <malloc+0xee>
    47cc:	f6f43c23          	sd	a5,-136(s0)
    47d0:	00001797          	auipc	a5,0x1
    47d4:	5f078793          	addi	a5,a5,1520 # 5dc0 <malloc+0xf6>
    47d8:	f8f43023          	sd	a5,-128(s0)
    47dc:	00001797          	auipc	a5,0x1
    47e0:	5ec78793          	addi	a5,a5,1516 # 5dc8 <malloc+0xfe>
    47e4:	f8f43423          	sd	a5,-120(s0)
  for(pi = 0; pi < NCHILD; pi++){
    47e8:	f7040b93          	addi	s7,s0,-144
  char *names[] = { "f0", "f1", "f2", "f3" };
    47ec:	895e                	mv	s2,s7
  for(pi = 0; pi < NCHILD; pi++){
    47ee:	4481                	li	s1,0
    47f0:	4a11                	li	s4,4
    fname = names[pi];
    47f2:	00093983          	ld	s3,0(s2)
    unlink(fname);
    47f6:	854e                	mv	a0,s3
    47f8:	00001097          	auipc	ra,0x1
    47fc:	0c0080e7          	jalr	192(ra) # 58b8 <unlink>
    pid = fork();
    4800:	00001097          	auipc	ra,0x1
    4804:	060080e7          	jalr	96(ra) # 5860 <fork>
    if(pid < 0){
    4808:	04054563          	bltz	a0,4852 <fourfiles+0xba>
    if(pid == 0){
    480c:	c12d                	beqz	a0,486e <fourfiles+0xd6>
  for(pi = 0; pi < NCHILD; pi++){
    480e:	2485                	addiw	s1,s1,1
    4810:	0921                	addi	s2,s2,8
    4812:	ff4490e3          	bne	s1,s4,47f2 <fourfiles+0x5a>
    4816:	4491                	li	s1,4
    wait(&xstatus);
    4818:	f6c40513          	addi	a0,s0,-148
    481c:	00001097          	auipc	ra,0x1
    4820:	054080e7          	jalr	84(ra) # 5870 <wait>
    if(xstatus != 0)
    4824:	f6c42503          	lw	a0,-148(s0)
    4828:	ed69                	bnez	a0,4902 <fourfiles+0x16a>
  for(pi = 0; pi < NCHILD; pi++){
    482a:	34fd                	addiw	s1,s1,-1
    482c:	f4f5                	bnez	s1,4818 <fourfiles+0x80>
    482e:	03000b13          	li	s6,48
    total = 0;
    4832:	f4a43c23          	sd	a0,-168(s0)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    4836:	00007a17          	auipc	s4,0x7
    483a:	59aa0a13          	addi	s4,s4,1434 # bdd0 <buf>
    483e:	00007a97          	auipc	s5,0x7
    4842:	593a8a93          	addi	s5,s5,1427 # bdd1 <buf+0x1>
    if(total != N*SZ){
    4846:	6d05                	lui	s10,0x1
    4848:	770d0d13          	addi	s10,s10,1904 # 1770 <pipe1+0x32>
  for(i = 0; i < NCHILD; i++){
    484c:	03400d93          	li	s11,52
    4850:	a23d                	j	497e <fourfiles+0x1e6>
      printf("fork failed\n", s);
    4852:	85e6                	mv	a1,s9
    4854:	00002517          	auipc	a0,0x2
    4858:	54c50513          	addi	a0,a0,1356 # 6da0 <malloc+0x10d6>
    485c:	00001097          	auipc	ra,0x1
    4860:	3b0080e7          	jalr	944(ra) # 5c0c <printf>
      exit(1);
    4864:	4505                	li	a0,1
    4866:	00001097          	auipc	ra,0x1
    486a:	002080e7          	jalr	2(ra) # 5868 <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    486e:	20200593          	li	a1,514
    4872:	854e                	mv	a0,s3
    4874:	00001097          	auipc	ra,0x1
    4878:	034080e7          	jalr	52(ra) # 58a8 <open>
    487c:	892a                	mv	s2,a0
      if(fd < 0){
    487e:	04054763          	bltz	a0,48cc <fourfiles+0x134>
      memset(buf, '0'+pi, SZ);
    4882:	1f400613          	li	a2,500
    4886:	0304859b          	addiw	a1,s1,48
    488a:	00007517          	auipc	a0,0x7
    488e:	54650513          	addi	a0,a0,1350 # bdd0 <buf>
    4892:	00001097          	auipc	ra,0x1
    4896:	dbc080e7          	jalr	-580(ra) # 564e <memset>
    489a:	44b1                	li	s1,12
        if((n = write(fd, buf, SZ)) != SZ){
    489c:	00007997          	auipc	s3,0x7
    48a0:	53498993          	addi	s3,s3,1332 # bdd0 <buf>
    48a4:	1f400613          	li	a2,500
    48a8:	85ce                	mv	a1,s3
    48aa:	854a                	mv	a0,s2
    48ac:	00001097          	auipc	ra,0x1
    48b0:	fdc080e7          	jalr	-36(ra) # 5888 <write>
    48b4:	85aa                	mv	a1,a0
    48b6:	1f400793          	li	a5,500
    48ba:	02f51763          	bne	a0,a5,48e8 <fourfiles+0x150>
      for(i = 0; i < N; i++){
    48be:	34fd                	addiw	s1,s1,-1
    48c0:	f0f5                	bnez	s1,48a4 <fourfiles+0x10c>
      exit(0);
    48c2:	4501                	li	a0,0
    48c4:	00001097          	auipc	ra,0x1
    48c8:	fa4080e7          	jalr	-92(ra) # 5868 <exit>
        printf("create failed\n", s);
    48cc:	85e6                	mv	a1,s9
    48ce:	00003517          	auipc	a0,0x3
    48d2:	49a50513          	addi	a0,a0,1178 # 7d68 <malloc+0x209e>
    48d6:	00001097          	auipc	ra,0x1
    48da:	336080e7          	jalr	822(ra) # 5c0c <printf>
        exit(1);
    48de:	4505                	li	a0,1
    48e0:	00001097          	auipc	ra,0x1
    48e4:	f88080e7          	jalr	-120(ra) # 5868 <exit>
          printf("write failed %d\n", n);
    48e8:	00003517          	auipc	a0,0x3
    48ec:	49050513          	addi	a0,a0,1168 # 7d78 <malloc+0x20ae>
    48f0:	00001097          	auipc	ra,0x1
    48f4:	31c080e7          	jalr	796(ra) # 5c0c <printf>
          exit(1);
    48f8:	4505                	li	a0,1
    48fa:	00001097          	auipc	ra,0x1
    48fe:	f6e080e7          	jalr	-146(ra) # 5868 <exit>
      exit(xstatus);
    4902:	00001097          	auipc	ra,0x1
    4906:	f66080e7          	jalr	-154(ra) # 5868 <exit>
          printf("wrong char\n", s);
    490a:	85e6                	mv	a1,s9
    490c:	00003517          	auipc	a0,0x3
    4910:	48450513          	addi	a0,a0,1156 # 7d90 <malloc+0x20c6>
    4914:	00001097          	auipc	ra,0x1
    4918:	2f8080e7          	jalr	760(ra) # 5c0c <printf>
          exit(1);
    491c:	4505                	li	a0,1
    491e:	00001097          	auipc	ra,0x1
    4922:	f4a080e7          	jalr	-182(ra) # 5868 <exit>
      total += n;
    4926:	00a9093b          	addw	s2,s2,a0
    while((n = read(fd, buf, sizeof(buf))) > 0){
    492a:	660d                	lui	a2,0x3
    492c:	85d2                	mv	a1,s4
    492e:	854e                	mv	a0,s3
    4930:	00001097          	auipc	ra,0x1
    4934:	f50080e7          	jalr	-176(ra) # 5880 <read>
    4938:	02a05363          	blez	a0,495e <fourfiles+0x1c6>
    493c:	00007797          	auipc	a5,0x7
    4940:	49478793          	addi	a5,a5,1172 # bdd0 <buf>
    4944:	fff5069b          	addiw	a3,a0,-1
    4948:	1682                	slli	a3,a3,0x20
    494a:	9281                	srli	a3,a3,0x20
    494c:	96d6                	add	a3,a3,s5
        if(buf[j] != '0'+i){
    494e:	0007c703          	lbu	a4,0(a5)
    4952:	fa971ce3          	bne	a4,s1,490a <fourfiles+0x172>
      for(j = 0; j < n; j++){
    4956:	0785                	addi	a5,a5,1
    4958:	fed79be3          	bne	a5,a3,494e <fourfiles+0x1b6>
    495c:	b7e9                	j	4926 <fourfiles+0x18e>
    close(fd);
    495e:	854e                	mv	a0,s3
    4960:	00001097          	auipc	ra,0x1
    4964:	f30080e7          	jalr	-208(ra) # 5890 <close>
    if(total != N*SZ){
    4968:	03a91963          	bne	s2,s10,499a <fourfiles+0x202>
    unlink(fname);
    496c:	8562                	mv	a0,s8
    496e:	00001097          	auipc	ra,0x1
    4972:	f4a080e7          	jalr	-182(ra) # 58b8 <unlink>
  for(i = 0; i < NCHILD; i++){
    4976:	0ba1                	addi	s7,s7,8
    4978:	2b05                	addiw	s6,s6,1
    497a:	03bb0e63          	beq	s6,s11,49b6 <fourfiles+0x21e>
    fname = names[i];
    497e:	000bbc03          	ld	s8,0(s7)
    fd = open(fname, 0);
    4982:	4581                	li	a1,0
    4984:	8562                	mv	a0,s8
    4986:	00001097          	auipc	ra,0x1
    498a:	f22080e7          	jalr	-222(ra) # 58a8 <open>
    498e:	89aa                	mv	s3,a0
    total = 0;
    4990:	f5843903          	ld	s2,-168(s0)
        if(buf[j] != '0'+i){
    4994:	000b049b          	sext.w	s1,s6
    while((n = read(fd, buf, sizeof(buf))) > 0){
    4998:	bf49                	j	492a <fourfiles+0x192>
      printf("wrong length %d\n", total);
    499a:	85ca                	mv	a1,s2
    499c:	00003517          	auipc	a0,0x3
    49a0:	40450513          	addi	a0,a0,1028 # 7da0 <malloc+0x20d6>
    49a4:	00001097          	auipc	ra,0x1
    49a8:	268080e7          	jalr	616(ra) # 5c0c <printf>
      exit(1);
    49ac:	4505                	li	a0,1
    49ae:	00001097          	auipc	ra,0x1
    49b2:	eba080e7          	jalr	-326(ra) # 5868 <exit>
}
    49b6:	70aa                	ld	ra,168(sp)
    49b8:	740a                	ld	s0,160(sp)
    49ba:	64ea                	ld	s1,152(sp)
    49bc:	694a                	ld	s2,144(sp)
    49be:	69aa                	ld	s3,136(sp)
    49c0:	6a0a                	ld	s4,128(sp)
    49c2:	7ae6                	ld	s5,120(sp)
    49c4:	7b46                	ld	s6,112(sp)
    49c6:	7ba6                	ld	s7,104(sp)
    49c8:	7c06                	ld	s8,96(sp)
    49ca:	6ce6                	ld	s9,88(sp)
    49cc:	6d46                	ld	s10,80(sp)
    49ce:	6da6                	ld	s11,72(sp)
    49d0:	614d                	addi	sp,sp,176
    49d2:	8082                	ret

00000000000049d4 <concreate>:
{
    49d4:	7135                	addi	sp,sp,-160
    49d6:	ed06                	sd	ra,152(sp)
    49d8:	e922                	sd	s0,144(sp)
    49da:	e526                	sd	s1,136(sp)
    49dc:	e14a                	sd	s2,128(sp)
    49de:	fcce                	sd	s3,120(sp)
    49e0:	f8d2                	sd	s4,112(sp)
    49e2:	f4d6                	sd	s5,104(sp)
    49e4:	f0da                	sd	s6,96(sp)
    49e6:	ecde                	sd	s7,88(sp)
    49e8:	1100                	addi	s0,sp,160
    49ea:	89aa                	mv	s3,a0
  file[0] = 'C';
    49ec:	04300793          	li	a5,67
    49f0:	faf40423          	sb	a5,-88(s0)
  file[2] = '\0';
    49f4:	fa040523          	sb	zero,-86(s0)
  for(i = 0; i < N; i++){
    49f8:	4901                	li	s2,0
    if(pid && (i % 3) == 1){
    49fa:	4b0d                	li	s6,3
    49fc:	4a85                	li	s5,1
      link("C0", file);
    49fe:	00003b97          	auipc	s7,0x3
    4a02:	3bab8b93          	addi	s7,s7,954 # 7db8 <malloc+0x20ee>
  for(i = 0; i < N; i++){
    4a06:	02800a13          	li	s4,40
    4a0a:	acc1                	j	4cda <concreate+0x306>
      link("C0", file);
    4a0c:	fa840593          	addi	a1,s0,-88
    4a10:	855e                	mv	a0,s7
    4a12:	00001097          	auipc	ra,0x1
    4a16:	eb6080e7          	jalr	-330(ra) # 58c8 <link>
    if(pid == 0) {
    4a1a:	a45d                	j	4cc0 <concreate+0x2ec>
    } else if(pid == 0 && (i % 5) == 1){
    4a1c:	4795                	li	a5,5
    4a1e:	02f9693b          	remw	s2,s2,a5
    4a22:	4785                	li	a5,1
    4a24:	02f90b63          	beq	s2,a5,4a5a <concreate+0x86>
      fd = open(file, O_CREATE | O_RDWR);
    4a28:	20200593          	li	a1,514
    4a2c:	fa840513          	addi	a0,s0,-88
    4a30:	00001097          	auipc	ra,0x1
    4a34:	e78080e7          	jalr	-392(ra) # 58a8 <open>
      if(fd < 0){
    4a38:	26055b63          	bgez	a0,4cae <concreate+0x2da>
        printf("concreate create %s failed\n", file);
    4a3c:	fa840593          	addi	a1,s0,-88
    4a40:	00003517          	auipc	a0,0x3
    4a44:	38050513          	addi	a0,a0,896 # 7dc0 <malloc+0x20f6>
    4a48:	00001097          	auipc	ra,0x1
    4a4c:	1c4080e7          	jalr	452(ra) # 5c0c <printf>
        exit(1);
    4a50:	4505                	li	a0,1
    4a52:	00001097          	auipc	ra,0x1
    4a56:	e16080e7          	jalr	-490(ra) # 5868 <exit>
      link("C0", file);
    4a5a:	fa840593          	addi	a1,s0,-88
    4a5e:	00003517          	auipc	a0,0x3
    4a62:	35a50513          	addi	a0,a0,858 # 7db8 <malloc+0x20ee>
    4a66:	00001097          	auipc	ra,0x1
    4a6a:	e62080e7          	jalr	-414(ra) # 58c8 <link>
      exit(0);
    4a6e:	4501                	li	a0,0
    4a70:	00001097          	auipc	ra,0x1
    4a74:	df8080e7          	jalr	-520(ra) # 5868 <exit>
        exit(1);
    4a78:	4505                	li	a0,1
    4a7a:	00001097          	auipc	ra,0x1
    4a7e:	dee080e7          	jalr	-530(ra) # 5868 <exit>
  memset(fa, 0, sizeof(fa));
    4a82:	02800613          	li	a2,40
    4a86:	4581                	li	a1,0
    4a88:	f8040513          	addi	a0,s0,-128
    4a8c:	00001097          	auipc	ra,0x1
    4a90:	bc2080e7          	jalr	-1086(ra) # 564e <memset>
  fd = open(".", 0);
    4a94:	4581                	li	a1,0
    4a96:	00002517          	auipc	a0,0x2
    4a9a:	d4a50513          	addi	a0,a0,-694 # 67e0 <malloc+0xb16>
    4a9e:	00001097          	auipc	ra,0x1
    4aa2:	e0a080e7          	jalr	-502(ra) # 58a8 <open>
    4aa6:	892a                	mv	s2,a0
  n = 0;
    4aa8:	8aa6                	mv	s5,s1
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    4aaa:	04300a13          	li	s4,67
      if(i < 0 || i >= sizeof(fa)){
    4aae:	02700b13          	li	s6,39
      fa[i] = 1;
    4ab2:	4b85                	li	s7,1
  while(read(fd, &de, sizeof(de)) > 0){
    4ab4:	a03d                	j	4ae2 <concreate+0x10e>
        printf("%s: concreate weird file %s\n", s, de.name);
    4ab6:	f7240613          	addi	a2,s0,-142
    4aba:	85ce                	mv	a1,s3
    4abc:	00003517          	auipc	a0,0x3
    4ac0:	32450513          	addi	a0,a0,804 # 7de0 <malloc+0x2116>
    4ac4:	00001097          	auipc	ra,0x1
    4ac8:	148080e7          	jalr	328(ra) # 5c0c <printf>
        exit(1);
    4acc:	4505                	li	a0,1
    4ace:	00001097          	auipc	ra,0x1
    4ad2:	d9a080e7          	jalr	-614(ra) # 5868 <exit>
      fa[i] = 1;
    4ad6:	fb040793          	addi	a5,s0,-80
    4ada:	973e                	add	a4,a4,a5
    4adc:	fd770823          	sb	s7,-48(a4)
      n++;
    4ae0:	2a85                	addiw	s5,s5,1
  while(read(fd, &de, sizeof(de)) > 0){
    4ae2:	4641                	li	a2,16
    4ae4:	f7040593          	addi	a1,s0,-144
    4ae8:	854a                	mv	a0,s2
    4aea:	00001097          	auipc	ra,0x1
    4aee:	d96080e7          	jalr	-618(ra) # 5880 <read>
    4af2:	04a05a63          	blez	a0,4b46 <concreate+0x172>
    if(de.inum == 0)
    4af6:	f7045783          	lhu	a5,-144(s0)
    4afa:	d7e5                	beqz	a5,4ae2 <concreate+0x10e>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    4afc:	f7244783          	lbu	a5,-142(s0)
    4b00:	ff4791e3          	bne	a5,s4,4ae2 <concreate+0x10e>
    4b04:	f7444783          	lbu	a5,-140(s0)
    4b08:	ffe9                	bnez	a5,4ae2 <concreate+0x10e>
      i = de.name[1] - '0';
    4b0a:	f7344783          	lbu	a5,-141(s0)
    4b0e:	fd07879b          	addiw	a5,a5,-48
    4b12:	0007871b          	sext.w	a4,a5
      if(i < 0 || i >= sizeof(fa)){
    4b16:	faeb60e3          	bltu	s6,a4,4ab6 <concreate+0xe2>
      if(fa[i]){
    4b1a:	fb040793          	addi	a5,s0,-80
    4b1e:	97ba                	add	a5,a5,a4
    4b20:	fd07c783          	lbu	a5,-48(a5)
    4b24:	dbcd                	beqz	a5,4ad6 <concreate+0x102>
        printf("%s: concreate duplicate file %s\n", s, de.name);
    4b26:	f7240613          	addi	a2,s0,-142
    4b2a:	85ce                	mv	a1,s3
    4b2c:	00003517          	auipc	a0,0x3
    4b30:	2d450513          	addi	a0,a0,724 # 7e00 <malloc+0x2136>
    4b34:	00001097          	auipc	ra,0x1
    4b38:	0d8080e7          	jalr	216(ra) # 5c0c <printf>
        exit(1);
    4b3c:	4505                	li	a0,1
    4b3e:	00001097          	auipc	ra,0x1
    4b42:	d2a080e7          	jalr	-726(ra) # 5868 <exit>
  close(fd);
    4b46:	854a                	mv	a0,s2
    4b48:	00001097          	auipc	ra,0x1
    4b4c:	d48080e7          	jalr	-696(ra) # 5890 <close>
  if(n != N){
    4b50:	02800793          	li	a5,40
    4b54:	00fa9763          	bne	s5,a5,4b62 <concreate+0x18e>
    if(((i % 3) == 0 && pid == 0) ||
    4b58:	4a8d                	li	s5,3
    4b5a:	4b05                	li	s6,1
  for(i = 0; i < N; i++){
    4b5c:	02800a13          	li	s4,40
    4b60:	a8c9                	j	4c32 <concreate+0x25e>
    printf("%s: concreate not enough files in directory listing\n", s);
    4b62:	85ce                	mv	a1,s3
    4b64:	00003517          	auipc	a0,0x3
    4b68:	2c450513          	addi	a0,a0,708 # 7e28 <malloc+0x215e>
    4b6c:	00001097          	auipc	ra,0x1
    4b70:	0a0080e7          	jalr	160(ra) # 5c0c <printf>
    exit(1);
    4b74:	4505                	li	a0,1
    4b76:	00001097          	auipc	ra,0x1
    4b7a:	cf2080e7          	jalr	-782(ra) # 5868 <exit>
      printf("%s: fork failed\n", s);
    4b7e:	85ce                	mv	a1,s3
    4b80:	00002517          	auipc	a0,0x2
    4b84:	e0050513          	addi	a0,a0,-512 # 6980 <malloc+0xcb6>
    4b88:	00001097          	auipc	ra,0x1
    4b8c:	084080e7          	jalr	132(ra) # 5c0c <printf>
      exit(1);
    4b90:	4505                	li	a0,1
    4b92:	00001097          	auipc	ra,0x1
    4b96:	cd6080e7          	jalr	-810(ra) # 5868 <exit>
      close(open(file, 0));
    4b9a:	4581                	li	a1,0
    4b9c:	fa840513          	addi	a0,s0,-88
    4ba0:	00001097          	auipc	ra,0x1
    4ba4:	d08080e7          	jalr	-760(ra) # 58a8 <open>
    4ba8:	00001097          	auipc	ra,0x1
    4bac:	ce8080e7          	jalr	-792(ra) # 5890 <close>
      close(open(file, 0));
    4bb0:	4581                	li	a1,0
    4bb2:	fa840513          	addi	a0,s0,-88
    4bb6:	00001097          	auipc	ra,0x1
    4bba:	cf2080e7          	jalr	-782(ra) # 58a8 <open>
    4bbe:	00001097          	auipc	ra,0x1
    4bc2:	cd2080e7          	jalr	-814(ra) # 5890 <close>
      close(open(file, 0));
    4bc6:	4581                	li	a1,0
    4bc8:	fa840513          	addi	a0,s0,-88
    4bcc:	00001097          	auipc	ra,0x1
    4bd0:	cdc080e7          	jalr	-804(ra) # 58a8 <open>
    4bd4:	00001097          	auipc	ra,0x1
    4bd8:	cbc080e7          	jalr	-836(ra) # 5890 <close>
      close(open(file, 0));
    4bdc:	4581                	li	a1,0
    4bde:	fa840513          	addi	a0,s0,-88
    4be2:	00001097          	auipc	ra,0x1
    4be6:	cc6080e7          	jalr	-826(ra) # 58a8 <open>
    4bea:	00001097          	auipc	ra,0x1
    4bee:	ca6080e7          	jalr	-858(ra) # 5890 <close>
      close(open(file, 0));
    4bf2:	4581                	li	a1,0
    4bf4:	fa840513          	addi	a0,s0,-88
    4bf8:	00001097          	auipc	ra,0x1
    4bfc:	cb0080e7          	jalr	-848(ra) # 58a8 <open>
    4c00:	00001097          	auipc	ra,0x1
    4c04:	c90080e7          	jalr	-880(ra) # 5890 <close>
      close(open(file, 0));
    4c08:	4581                	li	a1,0
    4c0a:	fa840513          	addi	a0,s0,-88
    4c0e:	00001097          	auipc	ra,0x1
    4c12:	c9a080e7          	jalr	-870(ra) # 58a8 <open>
    4c16:	00001097          	auipc	ra,0x1
    4c1a:	c7a080e7          	jalr	-902(ra) # 5890 <close>
    if(pid == 0)
    4c1e:	08090363          	beqz	s2,4ca4 <concreate+0x2d0>
      wait(0);
    4c22:	4501                	li	a0,0
    4c24:	00001097          	auipc	ra,0x1
    4c28:	c4c080e7          	jalr	-948(ra) # 5870 <wait>
  for(i = 0; i < N; i++){
    4c2c:	2485                	addiw	s1,s1,1
    4c2e:	0f448563          	beq	s1,s4,4d18 <concreate+0x344>
    file[1] = '0' + i;
    4c32:	0304879b          	addiw	a5,s1,48
    4c36:	faf404a3          	sb	a5,-87(s0)
    pid = fork();
    4c3a:	00001097          	auipc	ra,0x1
    4c3e:	c26080e7          	jalr	-986(ra) # 5860 <fork>
    4c42:	892a                	mv	s2,a0
    if(pid < 0){
    4c44:	f2054de3          	bltz	a0,4b7e <concreate+0x1aa>
    if(((i % 3) == 0 && pid == 0) ||
    4c48:	0354e73b          	remw	a4,s1,s5
    4c4c:	00a767b3          	or	a5,a4,a0
    4c50:	2781                	sext.w	a5,a5
    4c52:	d7a1                	beqz	a5,4b9a <concreate+0x1c6>
    4c54:	01671363          	bne	a4,s6,4c5a <concreate+0x286>
       ((i % 3) == 1 && pid != 0)){
    4c58:	f129                	bnez	a0,4b9a <concreate+0x1c6>
      unlink(file);
    4c5a:	fa840513          	addi	a0,s0,-88
    4c5e:	00001097          	auipc	ra,0x1
    4c62:	c5a080e7          	jalr	-934(ra) # 58b8 <unlink>
      unlink(file);
    4c66:	fa840513          	addi	a0,s0,-88
    4c6a:	00001097          	auipc	ra,0x1
    4c6e:	c4e080e7          	jalr	-946(ra) # 58b8 <unlink>
      unlink(file);
    4c72:	fa840513          	addi	a0,s0,-88
    4c76:	00001097          	auipc	ra,0x1
    4c7a:	c42080e7          	jalr	-958(ra) # 58b8 <unlink>
      unlink(file);
    4c7e:	fa840513          	addi	a0,s0,-88
    4c82:	00001097          	auipc	ra,0x1
    4c86:	c36080e7          	jalr	-970(ra) # 58b8 <unlink>
      unlink(file);
    4c8a:	fa840513          	addi	a0,s0,-88
    4c8e:	00001097          	auipc	ra,0x1
    4c92:	c2a080e7          	jalr	-982(ra) # 58b8 <unlink>
      unlink(file);
    4c96:	fa840513          	addi	a0,s0,-88
    4c9a:	00001097          	auipc	ra,0x1
    4c9e:	c1e080e7          	jalr	-994(ra) # 58b8 <unlink>
    4ca2:	bfb5                	j	4c1e <concreate+0x24a>
      exit(0);
    4ca4:	4501                	li	a0,0
    4ca6:	00001097          	auipc	ra,0x1
    4caa:	bc2080e7          	jalr	-1086(ra) # 5868 <exit>
      close(fd);
    4cae:	00001097          	auipc	ra,0x1
    4cb2:	be2080e7          	jalr	-1054(ra) # 5890 <close>
    if(pid == 0) {
    4cb6:	bb65                	j	4a6e <concreate+0x9a>
      close(fd);
    4cb8:	00001097          	auipc	ra,0x1
    4cbc:	bd8080e7          	jalr	-1064(ra) # 5890 <close>
      wait(&xstatus);
    4cc0:	f6c40513          	addi	a0,s0,-148
    4cc4:	00001097          	auipc	ra,0x1
    4cc8:	bac080e7          	jalr	-1108(ra) # 5870 <wait>
      if(xstatus != 0)
    4ccc:	f6c42483          	lw	s1,-148(s0)
    4cd0:	da0494e3          	bnez	s1,4a78 <concreate+0xa4>
  for(i = 0; i < N; i++){
    4cd4:	2905                	addiw	s2,s2,1
    4cd6:	db4906e3          	beq	s2,s4,4a82 <concreate+0xae>
    file[1] = '0' + i;
    4cda:	0309079b          	addiw	a5,s2,48
    4cde:	faf404a3          	sb	a5,-87(s0)
    unlink(file);
    4ce2:	fa840513          	addi	a0,s0,-88
    4ce6:	00001097          	auipc	ra,0x1
    4cea:	bd2080e7          	jalr	-1070(ra) # 58b8 <unlink>
    pid = fork();
    4cee:	00001097          	auipc	ra,0x1
    4cf2:	b72080e7          	jalr	-1166(ra) # 5860 <fork>
    if(pid && (i % 3) == 1){
    4cf6:	d20503e3          	beqz	a0,4a1c <concreate+0x48>
    4cfa:	036967bb          	remw	a5,s2,s6
    4cfe:	d15787e3          	beq	a5,s5,4a0c <concreate+0x38>
      fd = open(file, O_CREATE | O_RDWR);
    4d02:	20200593          	li	a1,514
    4d06:	fa840513          	addi	a0,s0,-88
    4d0a:	00001097          	auipc	ra,0x1
    4d0e:	b9e080e7          	jalr	-1122(ra) # 58a8 <open>
      if(fd < 0){
    4d12:	fa0553e3          	bgez	a0,4cb8 <concreate+0x2e4>
    4d16:	b31d                	j	4a3c <concreate+0x68>
}
    4d18:	60ea                	ld	ra,152(sp)
    4d1a:	644a                	ld	s0,144(sp)
    4d1c:	64aa                	ld	s1,136(sp)
    4d1e:	690a                	ld	s2,128(sp)
    4d20:	79e6                	ld	s3,120(sp)
    4d22:	7a46                	ld	s4,112(sp)
    4d24:	7aa6                	ld	s5,104(sp)
    4d26:	7b06                	ld	s6,96(sp)
    4d28:	6be6                	ld	s7,88(sp)
    4d2a:	610d                	addi	sp,sp,160
    4d2c:	8082                	ret

0000000000004d2e <bigfile>:
{
    4d2e:	7139                	addi	sp,sp,-64
    4d30:	fc06                	sd	ra,56(sp)
    4d32:	f822                	sd	s0,48(sp)
    4d34:	f426                	sd	s1,40(sp)
    4d36:	f04a                	sd	s2,32(sp)
    4d38:	ec4e                	sd	s3,24(sp)
    4d3a:	e852                	sd	s4,16(sp)
    4d3c:	e456                	sd	s5,8(sp)
    4d3e:	0080                	addi	s0,sp,64
    4d40:	8aaa                	mv	s5,a0
  unlink("bigfile.dat");
    4d42:	00003517          	auipc	a0,0x3
    4d46:	11e50513          	addi	a0,a0,286 # 7e60 <malloc+0x2196>
    4d4a:	00001097          	auipc	ra,0x1
    4d4e:	b6e080e7          	jalr	-1170(ra) # 58b8 <unlink>
  fd = open("bigfile.dat", O_CREATE | O_RDWR);
    4d52:	20200593          	li	a1,514
    4d56:	00003517          	auipc	a0,0x3
    4d5a:	10a50513          	addi	a0,a0,266 # 7e60 <malloc+0x2196>
    4d5e:	00001097          	auipc	ra,0x1
    4d62:	b4a080e7          	jalr	-1206(ra) # 58a8 <open>
    4d66:	89aa                	mv	s3,a0
  for(i = 0; i < N; i++){
    4d68:	4481                	li	s1,0
    memset(buf, i, SZ);
    4d6a:	00007917          	auipc	s2,0x7
    4d6e:	06690913          	addi	s2,s2,102 # bdd0 <buf>
  for(i = 0; i < N; i++){
    4d72:	4a51                	li	s4,20
  if(fd < 0){
    4d74:	0a054063          	bltz	a0,4e14 <bigfile+0xe6>
    memset(buf, i, SZ);
    4d78:	25800613          	li	a2,600
    4d7c:	85a6                	mv	a1,s1
    4d7e:	854a                	mv	a0,s2
    4d80:	00001097          	auipc	ra,0x1
    4d84:	8ce080e7          	jalr	-1842(ra) # 564e <memset>
    if(write(fd, buf, SZ) != SZ){
    4d88:	25800613          	li	a2,600
    4d8c:	85ca                	mv	a1,s2
    4d8e:	854e                	mv	a0,s3
    4d90:	00001097          	auipc	ra,0x1
    4d94:	af8080e7          	jalr	-1288(ra) # 5888 <write>
    4d98:	25800793          	li	a5,600
    4d9c:	08f51a63          	bne	a0,a5,4e30 <bigfile+0x102>
  for(i = 0; i < N; i++){
    4da0:	2485                	addiw	s1,s1,1
    4da2:	fd449be3          	bne	s1,s4,4d78 <bigfile+0x4a>
  close(fd);
    4da6:	854e                	mv	a0,s3
    4da8:	00001097          	auipc	ra,0x1
    4dac:	ae8080e7          	jalr	-1304(ra) # 5890 <close>
  fd = open("bigfile.dat", 0);
    4db0:	4581                	li	a1,0
    4db2:	00003517          	auipc	a0,0x3
    4db6:	0ae50513          	addi	a0,a0,174 # 7e60 <malloc+0x2196>
    4dba:	00001097          	auipc	ra,0x1
    4dbe:	aee080e7          	jalr	-1298(ra) # 58a8 <open>
    4dc2:	8a2a                	mv	s4,a0
  total = 0;
    4dc4:	4981                	li	s3,0
  for(i = 0; ; i++){
    4dc6:	4481                	li	s1,0
    cc = read(fd, buf, SZ/2);
    4dc8:	00007917          	auipc	s2,0x7
    4dcc:	00890913          	addi	s2,s2,8 # bdd0 <buf>
  if(fd < 0){
    4dd0:	06054e63          	bltz	a0,4e4c <bigfile+0x11e>
    cc = read(fd, buf, SZ/2);
    4dd4:	12c00613          	li	a2,300
    4dd8:	85ca                	mv	a1,s2
    4dda:	8552                	mv	a0,s4
    4ddc:	00001097          	auipc	ra,0x1
    4de0:	aa4080e7          	jalr	-1372(ra) # 5880 <read>
    if(cc < 0){
    4de4:	08054263          	bltz	a0,4e68 <bigfile+0x13a>
    if(cc == 0)
    4de8:	c971                	beqz	a0,4ebc <bigfile+0x18e>
    if(cc != SZ/2){
    4dea:	12c00793          	li	a5,300
    4dee:	08f51b63          	bne	a0,a5,4e84 <bigfile+0x156>
    if(buf[0] != i/2 || buf[SZ/2-1] != i/2){
    4df2:	01f4d79b          	srliw	a5,s1,0x1f
    4df6:	9fa5                	addw	a5,a5,s1
    4df8:	4017d79b          	sraiw	a5,a5,0x1
    4dfc:	00094703          	lbu	a4,0(s2)
    4e00:	0af71063          	bne	a4,a5,4ea0 <bigfile+0x172>
    4e04:	12b94703          	lbu	a4,299(s2)
    4e08:	08f71c63          	bne	a4,a5,4ea0 <bigfile+0x172>
    total += cc;
    4e0c:	12c9899b          	addiw	s3,s3,300
  for(i = 0; ; i++){
    4e10:	2485                	addiw	s1,s1,1
    cc = read(fd, buf, SZ/2);
    4e12:	b7c9                	j	4dd4 <bigfile+0xa6>
    printf("%s: cannot create bigfile", s);
    4e14:	85d6                	mv	a1,s5
    4e16:	00003517          	auipc	a0,0x3
    4e1a:	05a50513          	addi	a0,a0,90 # 7e70 <malloc+0x21a6>
    4e1e:	00001097          	auipc	ra,0x1
    4e22:	dee080e7          	jalr	-530(ra) # 5c0c <printf>
    exit(1);
    4e26:	4505                	li	a0,1
    4e28:	00001097          	auipc	ra,0x1
    4e2c:	a40080e7          	jalr	-1472(ra) # 5868 <exit>
      printf("%s: write bigfile failed\n", s);
    4e30:	85d6                	mv	a1,s5
    4e32:	00003517          	auipc	a0,0x3
    4e36:	05e50513          	addi	a0,a0,94 # 7e90 <malloc+0x21c6>
    4e3a:	00001097          	auipc	ra,0x1
    4e3e:	dd2080e7          	jalr	-558(ra) # 5c0c <printf>
      exit(1);
    4e42:	4505                	li	a0,1
    4e44:	00001097          	auipc	ra,0x1
    4e48:	a24080e7          	jalr	-1500(ra) # 5868 <exit>
    printf("%s: cannot open bigfile\n", s);
    4e4c:	85d6                	mv	a1,s5
    4e4e:	00003517          	auipc	a0,0x3
    4e52:	06250513          	addi	a0,a0,98 # 7eb0 <malloc+0x21e6>
    4e56:	00001097          	auipc	ra,0x1
    4e5a:	db6080e7          	jalr	-586(ra) # 5c0c <printf>
    exit(1);
    4e5e:	4505                	li	a0,1
    4e60:	00001097          	auipc	ra,0x1
    4e64:	a08080e7          	jalr	-1528(ra) # 5868 <exit>
      printf("%s: read bigfile failed\n", s);
    4e68:	85d6                	mv	a1,s5
    4e6a:	00003517          	auipc	a0,0x3
    4e6e:	06650513          	addi	a0,a0,102 # 7ed0 <malloc+0x2206>
    4e72:	00001097          	auipc	ra,0x1
    4e76:	d9a080e7          	jalr	-614(ra) # 5c0c <printf>
      exit(1);
    4e7a:	4505                	li	a0,1
    4e7c:	00001097          	auipc	ra,0x1
    4e80:	9ec080e7          	jalr	-1556(ra) # 5868 <exit>
      printf("%s: short read bigfile\n", s);
    4e84:	85d6                	mv	a1,s5
    4e86:	00003517          	auipc	a0,0x3
    4e8a:	06a50513          	addi	a0,a0,106 # 7ef0 <malloc+0x2226>
    4e8e:	00001097          	auipc	ra,0x1
    4e92:	d7e080e7          	jalr	-642(ra) # 5c0c <printf>
      exit(1);
    4e96:	4505                	li	a0,1
    4e98:	00001097          	auipc	ra,0x1
    4e9c:	9d0080e7          	jalr	-1584(ra) # 5868 <exit>
      printf("%s: read bigfile wrong data\n", s);
    4ea0:	85d6                	mv	a1,s5
    4ea2:	00003517          	auipc	a0,0x3
    4ea6:	06650513          	addi	a0,a0,102 # 7f08 <malloc+0x223e>
    4eaa:	00001097          	auipc	ra,0x1
    4eae:	d62080e7          	jalr	-670(ra) # 5c0c <printf>
      exit(1);
    4eb2:	4505                	li	a0,1
    4eb4:	00001097          	auipc	ra,0x1
    4eb8:	9b4080e7          	jalr	-1612(ra) # 5868 <exit>
  close(fd);
    4ebc:	8552                	mv	a0,s4
    4ebe:	00001097          	auipc	ra,0x1
    4ec2:	9d2080e7          	jalr	-1582(ra) # 5890 <close>
  if(total != N*SZ){
    4ec6:	678d                	lui	a5,0x3
    4ec8:	ee078793          	addi	a5,a5,-288 # 2ee0 <fourteen+0x108>
    4ecc:	02f99363          	bne	s3,a5,4ef2 <bigfile+0x1c4>
  unlink("bigfile.dat");
    4ed0:	00003517          	auipc	a0,0x3
    4ed4:	f9050513          	addi	a0,a0,-112 # 7e60 <malloc+0x2196>
    4ed8:	00001097          	auipc	ra,0x1
    4edc:	9e0080e7          	jalr	-1568(ra) # 58b8 <unlink>
}
    4ee0:	70e2                	ld	ra,56(sp)
    4ee2:	7442                	ld	s0,48(sp)
    4ee4:	74a2                	ld	s1,40(sp)
    4ee6:	7902                	ld	s2,32(sp)
    4ee8:	69e2                	ld	s3,24(sp)
    4eea:	6a42                	ld	s4,16(sp)
    4eec:	6aa2                	ld	s5,8(sp)
    4eee:	6121                	addi	sp,sp,64
    4ef0:	8082                	ret
    printf("%s: read bigfile wrong total\n", s);
    4ef2:	85d6                	mv	a1,s5
    4ef4:	00003517          	auipc	a0,0x3
    4ef8:	03450513          	addi	a0,a0,52 # 7f28 <malloc+0x225e>
    4efc:	00001097          	auipc	ra,0x1
    4f00:	d10080e7          	jalr	-752(ra) # 5c0c <printf>
    exit(1);
    4f04:	4505                	li	a0,1
    4f06:	00001097          	auipc	ra,0x1
    4f0a:	962080e7          	jalr	-1694(ra) # 5868 <exit>

0000000000004f0e <fsfull>:
{
    4f0e:	7171                	addi	sp,sp,-176
    4f10:	f506                	sd	ra,168(sp)
    4f12:	f122                	sd	s0,160(sp)
    4f14:	ed26                	sd	s1,152(sp)
    4f16:	e94a                	sd	s2,144(sp)
    4f18:	e54e                	sd	s3,136(sp)
    4f1a:	e152                	sd	s4,128(sp)
    4f1c:	fcd6                	sd	s5,120(sp)
    4f1e:	f8da                	sd	s6,112(sp)
    4f20:	f4de                	sd	s7,104(sp)
    4f22:	f0e2                	sd	s8,96(sp)
    4f24:	ece6                	sd	s9,88(sp)
    4f26:	e8ea                	sd	s10,80(sp)
    4f28:	e4ee                	sd	s11,72(sp)
    4f2a:	1900                	addi	s0,sp,176
  printf("fsfull test\n");
    4f2c:	00003517          	auipc	a0,0x3
    4f30:	01c50513          	addi	a0,a0,28 # 7f48 <malloc+0x227e>
    4f34:	00001097          	auipc	ra,0x1
    4f38:	cd8080e7          	jalr	-808(ra) # 5c0c <printf>
  for(nfiles = 0; ; nfiles++){
    4f3c:	4481                	li	s1,0
    name[0] = 'f';
    4f3e:	06600d13          	li	s10,102
    name[1] = '0' + nfiles / 1000;
    4f42:	3e800c13          	li	s8,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    4f46:	06400b93          	li	s7,100
    name[3] = '0' + (nfiles % 100) / 10;
    4f4a:	4b29                	li	s6,10
    printf("writing %s\n", name);
    4f4c:	00003c97          	auipc	s9,0x3
    4f50:	00cc8c93          	addi	s9,s9,12 # 7f58 <malloc+0x228e>
    int total = 0;
    4f54:	4d81                	li	s11,0
      int cc = write(fd, buf, BSIZE);
    4f56:	00007a17          	auipc	s4,0x7
    4f5a:	e7aa0a13          	addi	s4,s4,-390 # bdd0 <buf>
    name[0] = 'f';
    4f5e:	f5a40823          	sb	s10,-176(s0)
    name[1] = '0' + nfiles / 1000;
    4f62:	0384c7bb          	divw	a5,s1,s8
    4f66:	0307879b          	addiw	a5,a5,48
    4f6a:	f4f408a3          	sb	a5,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    4f6e:	0384e7bb          	remw	a5,s1,s8
    4f72:	0377c7bb          	divw	a5,a5,s7
    4f76:	0307879b          	addiw	a5,a5,48
    4f7a:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    4f7e:	0374e7bb          	remw	a5,s1,s7
    4f82:	0367c7bb          	divw	a5,a5,s6
    4f86:	0307879b          	addiw	a5,a5,48
    4f8a:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    4f8e:	0364e7bb          	remw	a5,s1,s6
    4f92:	0307879b          	addiw	a5,a5,48
    4f96:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    4f9a:	f4040aa3          	sb	zero,-171(s0)
    printf("writing %s\n", name);
    4f9e:	f5040593          	addi	a1,s0,-176
    4fa2:	8566                	mv	a0,s9
    4fa4:	00001097          	auipc	ra,0x1
    4fa8:	c68080e7          	jalr	-920(ra) # 5c0c <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    4fac:	20200593          	li	a1,514
    4fb0:	f5040513          	addi	a0,s0,-176
    4fb4:	00001097          	auipc	ra,0x1
    4fb8:	8f4080e7          	jalr	-1804(ra) # 58a8 <open>
    4fbc:	892a                	mv	s2,a0
    if(fd < 0){
    4fbe:	0a055663          	bgez	a0,506a <fsfull+0x15c>
      printf("open %s failed\n", name);
    4fc2:	f5040593          	addi	a1,s0,-176
    4fc6:	00003517          	auipc	a0,0x3
    4fca:	fa250513          	addi	a0,a0,-94 # 7f68 <malloc+0x229e>
    4fce:	00001097          	auipc	ra,0x1
    4fd2:	c3e080e7          	jalr	-962(ra) # 5c0c <printf>
  while(nfiles >= 0){
    4fd6:	0604c363          	bltz	s1,503c <fsfull+0x12e>
    name[0] = 'f';
    4fda:	06600b13          	li	s6,102
    name[1] = '0' + nfiles / 1000;
    4fde:	3e800a13          	li	s4,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    4fe2:	06400993          	li	s3,100
    name[3] = '0' + (nfiles % 100) / 10;
    4fe6:	4929                	li	s2,10
  while(nfiles >= 0){
    4fe8:	5afd                	li	s5,-1
    name[0] = 'f';
    4fea:	f5640823          	sb	s6,-176(s0)
    name[1] = '0' + nfiles / 1000;
    4fee:	0344c7bb          	divw	a5,s1,s4
    4ff2:	0307879b          	addiw	a5,a5,48
    4ff6:	f4f408a3          	sb	a5,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    4ffa:	0344e7bb          	remw	a5,s1,s4
    4ffe:	0337c7bb          	divw	a5,a5,s3
    5002:	0307879b          	addiw	a5,a5,48
    5006:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    500a:	0334e7bb          	remw	a5,s1,s3
    500e:	0327c7bb          	divw	a5,a5,s2
    5012:	0307879b          	addiw	a5,a5,48
    5016:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    501a:	0324e7bb          	remw	a5,s1,s2
    501e:	0307879b          	addiw	a5,a5,48
    5022:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    5026:	f4040aa3          	sb	zero,-171(s0)
    unlink(name);
    502a:	f5040513          	addi	a0,s0,-176
    502e:	00001097          	auipc	ra,0x1
    5032:	88a080e7          	jalr	-1910(ra) # 58b8 <unlink>
    nfiles--;
    5036:	34fd                	addiw	s1,s1,-1
  while(nfiles >= 0){
    5038:	fb5499e3          	bne	s1,s5,4fea <fsfull+0xdc>
  printf("fsfull test finished\n");
    503c:	00003517          	auipc	a0,0x3
    5040:	f4c50513          	addi	a0,a0,-180 # 7f88 <malloc+0x22be>
    5044:	00001097          	auipc	ra,0x1
    5048:	bc8080e7          	jalr	-1080(ra) # 5c0c <printf>
}
    504c:	70aa                	ld	ra,168(sp)
    504e:	740a                	ld	s0,160(sp)
    5050:	64ea                	ld	s1,152(sp)
    5052:	694a                	ld	s2,144(sp)
    5054:	69aa                	ld	s3,136(sp)
    5056:	6a0a                	ld	s4,128(sp)
    5058:	7ae6                	ld	s5,120(sp)
    505a:	7b46                	ld	s6,112(sp)
    505c:	7ba6                	ld	s7,104(sp)
    505e:	7c06                	ld	s8,96(sp)
    5060:	6ce6                	ld	s9,88(sp)
    5062:	6d46                	ld	s10,80(sp)
    5064:	6da6                	ld	s11,72(sp)
    5066:	614d                	addi	sp,sp,176
    5068:	8082                	ret
    int total = 0;
    506a:	89ee                	mv	s3,s11
      if(cc < BSIZE)
    506c:	3ff00a93          	li	s5,1023
      int cc = write(fd, buf, BSIZE);
    5070:	40000613          	li	a2,1024
    5074:	85d2                	mv	a1,s4
    5076:	854a                	mv	a0,s2
    5078:	00001097          	auipc	ra,0x1
    507c:	810080e7          	jalr	-2032(ra) # 5888 <write>
      if(cc < BSIZE)
    5080:	00aad563          	bge	s5,a0,508a <fsfull+0x17c>
      total += cc;
    5084:	00a989bb          	addw	s3,s3,a0
    while(1){
    5088:	b7e5                	j	5070 <fsfull+0x162>
    printf("wrote %d bytes\n", total);
    508a:	85ce                	mv	a1,s3
    508c:	00003517          	auipc	a0,0x3
    5090:	eec50513          	addi	a0,a0,-276 # 7f78 <malloc+0x22ae>
    5094:	00001097          	auipc	ra,0x1
    5098:	b78080e7          	jalr	-1160(ra) # 5c0c <printf>
    close(fd);
    509c:	854a                	mv	a0,s2
    509e:	00000097          	auipc	ra,0x0
    50a2:	7f2080e7          	jalr	2034(ra) # 5890 <close>
    if(total == 0)
    50a6:	f20988e3          	beqz	s3,4fd6 <fsfull+0xc8>
  for(nfiles = 0; ; nfiles++){
    50aa:	2485                	addiw	s1,s1,1
    50ac:	bd4d                	j	4f5e <fsfull+0x50>

00000000000050ae <badwrite>:
{
    50ae:	7179                	addi	sp,sp,-48
    50b0:	f406                	sd	ra,40(sp)
    50b2:	f022                	sd	s0,32(sp)
    50b4:	ec26                	sd	s1,24(sp)
    50b6:	e84a                	sd	s2,16(sp)
    50b8:	e44e                	sd	s3,8(sp)
    50ba:	e052                	sd	s4,0(sp)
    50bc:	1800                	addi	s0,sp,48
  unlink("junk");
    50be:	00003517          	auipc	a0,0x3
    50c2:	ee250513          	addi	a0,a0,-286 # 7fa0 <malloc+0x22d6>
    50c6:	00000097          	auipc	ra,0x0
    50ca:	7f2080e7          	jalr	2034(ra) # 58b8 <unlink>
    50ce:	25800913          	li	s2,600
    int fd = open("junk", O_CREATE|O_WRONLY);
    50d2:	00003997          	auipc	s3,0x3
    50d6:	ece98993          	addi	s3,s3,-306 # 7fa0 <malloc+0x22d6>
    write(fd, (char*)0xffffffffffL, 1);
    50da:	5a7d                	li	s4,-1
    50dc:	018a5a13          	srli	s4,s4,0x18
    int fd = open("junk", O_CREATE|O_WRONLY);
    50e0:	20100593          	li	a1,513
    50e4:	854e                	mv	a0,s3
    50e6:	00000097          	auipc	ra,0x0
    50ea:	7c2080e7          	jalr	1986(ra) # 58a8 <open>
    50ee:	84aa                	mv	s1,a0
    if(fd < 0){
    50f0:	06054b63          	bltz	a0,5166 <badwrite+0xb8>
    write(fd, (char*)0xffffffffffL, 1);
    50f4:	4605                	li	a2,1
    50f6:	85d2                	mv	a1,s4
    50f8:	00000097          	auipc	ra,0x0
    50fc:	790080e7          	jalr	1936(ra) # 5888 <write>
    close(fd);
    5100:	8526                	mv	a0,s1
    5102:	00000097          	auipc	ra,0x0
    5106:	78e080e7          	jalr	1934(ra) # 5890 <close>
    unlink("junk");
    510a:	854e                	mv	a0,s3
    510c:	00000097          	auipc	ra,0x0
    5110:	7ac080e7          	jalr	1964(ra) # 58b8 <unlink>
  for(int i = 0; i < assumed_free; i++){
    5114:	397d                	addiw	s2,s2,-1
    5116:	fc0915e3          	bnez	s2,50e0 <badwrite+0x32>
  int fd = open("junk", O_CREATE|O_WRONLY);
    511a:	20100593          	li	a1,513
    511e:	00003517          	auipc	a0,0x3
    5122:	e8250513          	addi	a0,a0,-382 # 7fa0 <malloc+0x22d6>
    5126:	00000097          	auipc	ra,0x0
    512a:	782080e7          	jalr	1922(ra) # 58a8 <open>
    512e:	84aa                	mv	s1,a0
  if(fd < 0){
    5130:	04054863          	bltz	a0,5180 <badwrite+0xd2>
  if(write(fd, "x", 1) != 1){
    5134:	4605                	li	a2,1
    5136:	00001597          	auipc	a1,0x1
    513a:	08258593          	addi	a1,a1,130 # 61b8 <malloc+0x4ee>
    513e:	00000097          	auipc	ra,0x0
    5142:	74a080e7          	jalr	1866(ra) # 5888 <write>
    5146:	4785                	li	a5,1
    5148:	04f50963          	beq	a0,a5,519a <badwrite+0xec>
    printf("write failed\n");
    514c:	00003517          	auipc	a0,0x3
    5150:	e7450513          	addi	a0,a0,-396 # 7fc0 <malloc+0x22f6>
    5154:	00001097          	auipc	ra,0x1
    5158:	ab8080e7          	jalr	-1352(ra) # 5c0c <printf>
    exit(1);
    515c:	4505                	li	a0,1
    515e:	00000097          	auipc	ra,0x0
    5162:	70a080e7          	jalr	1802(ra) # 5868 <exit>
      printf("open junk failed\n");
    5166:	00003517          	auipc	a0,0x3
    516a:	e4250513          	addi	a0,a0,-446 # 7fa8 <malloc+0x22de>
    516e:	00001097          	auipc	ra,0x1
    5172:	a9e080e7          	jalr	-1378(ra) # 5c0c <printf>
      exit(1);
    5176:	4505                	li	a0,1
    5178:	00000097          	auipc	ra,0x0
    517c:	6f0080e7          	jalr	1776(ra) # 5868 <exit>
    printf("open junk failed\n");
    5180:	00003517          	auipc	a0,0x3
    5184:	e2850513          	addi	a0,a0,-472 # 7fa8 <malloc+0x22de>
    5188:	00001097          	auipc	ra,0x1
    518c:	a84080e7          	jalr	-1404(ra) # 5c0c <printf>
    exit(1);
    5190:	4505                	li	a0,1
    5192:	00000097          	auipc	ra,0x0
    5196:	6d6080e7          	jalr	1750(ra) # 5868 <exit>
  close(fd);
    519a:	8526                	mv	a0,s1
    519c:	00000097          	auipc	ra,0x0
    51a0:	6f4080e7          	jalr	1780(ra) # 5890 <close>
  unlink("junk");
    51a4:	00003517          	auipc	a0,0x3
    51a8:	dfc50513          	addi	a0,a0,-516 # 7fa0 <malloc+0x22d6>
    51ac:	00000097          	auipc	ra,0x0
    51b0:	70c080e7          	jalr	1804(ra) # 58b8 <unlink>
  exit(0);
    51b4:	4501                	li	a0,0
    51b6:	00000097          	auipc	ra,0x0
    51ba:	6b2080e7          	jalr	1714(ra) # 5868 <exit>

00000000000051be <countfree>:
// because out of memory with lazy allocation results in the process
// taking a fault and being killed, fork and report back.
//
int
countfree()
{
    51be:	7139                	addi	sp,sp,-64
    51c0:	fc06                	sd	ra,56(sp)
    51c2:	f822                	sd	s0,48(sp)
    51c4:	f426                	sd	s1,40(sp)
    51c6:	f04a                	sd	s2,32(sp)
    51c8:	ec4e                	sd	s3,24(sp)
    51ca:	0080                	addi	s0,sp,64
  int fds[2];

  if(pipe(fds) < 0){
    51cc:	fc840513          	addi	a0,s0,-56
    51d0:	00000097          	auipc	ra,0x0
    51d4:	6a8080e7          	jalr	1704(ra) # 5878 <pipe>
    51d8:	06054863          	bltz	a0,5248 <countfree+0x8a>
    printf("pipe() failed in countfree()\n");
    exit(1);
  }
  
  int pid = fork();
    51dc:	00000097          	auipc	ra,0x0
    51e0:	684080e7          	jalr	1668(ra) # 5860 <fork>

  if(pid < 0){
    51e4:	06054f63          	bltz	a0,5262 <countfree+0xa4>
    printf("fork failed in countfree()\n");
    exit(1);
  }

  if(pid == 0){
    51e8:	ed59                	bnez	a0,5286 <countfree+0xc8>
    close(fds[0]);
    51ea:	fc842503          	lw	a0,-56(s0)
    51ee:	00000097          	auipc	ra,0x0
    51f2:	6a2080e7          	jalr	1698(ra) # 5890 <close>
    
    while(1){
      uint64 a = (uint64) sbrk(4096);
      if(a == 0xffffffffffffffff){
    51f6:	54fd                	li	s1,-1
        break;
      }

      // modify the memory to make sure it's really allocated.
      *(char *)(a + 4096 - 1) = 1;
    51f8:	4985                	li	s3,1

      // report back one more page.
      if(write(fds[1], "x", 1) != 1){
    51fa:	00001917          	auipc	s2,0x1
    51fe:	fbe90913          	addi	s2,s2,-66 # 61b8 <malloc+0x4ee>
      uint64 a = (uint64) sbrk(4096);
    5202:	6505                	lui	a0,0x1
    5204:	00000097          	auipc	ra,0x0
    5208:	6ec080e7          	jalr	1772(ra) # 58f0 <sbrk>
      if(a == 0xffffffffffffffff){
    520c:	06950863          	beq	a0,s1,527c <countfree+0xbe>
      *(char *)(a + 4096 - 1) = 1;
    5210:	6785                	lui	a5,0x1
    5212:	953e                	add	a0,a0,a5
    5214:	ff350fa3          	sb	s3,-1(a0) # fff <bigdir+0x9d>
      if(write(fds[1], "x", 1) != 1){
    5218:	4605                	li	a2,1
    521a:	85ca                	mv	a1,s2
    521c:	fcc42503          	lw	a0,-52(s0)
    5220:	00000097          	auipc	ra,0x0
    5224:	668080e7          	jalr	1640(ra) # 5888 <write>
    5228:	4785                	li	a5,1
    522a:	fcf50ce3          	beq	a0,a5,5202 <countfree+0x44>
        printf("write() failed in countfree()\n");
    522e:	00003517          	auipc	a0,0x3
    5232:	de250513          	addi	a0,a0,-542 # 8010 <malloc+0x2346>
    5236:	00001097          	auipc	ra,0x1
    523a:	9d6080e7          	jalr	-1578(ra) # 5c0c <printf>
        exit(1);
    523e:	4505                	li	a0,1
    5240:	00000097          	auipc	ra,0x0
    5244:	628080e7          	jalr	1576(ra) # 5868 <exit>
    printf("pipe() failed in countfree()\n");
    5248:	00003517          	auipc	a0,0x3
    524c:	d8850513          	addi	a0,a0,-632 # 7fd0 <malloc+0x2306>
    5250:	00001097          	auipc	ra,0x1
    5254:	9bc080e7          	jalr	-1604(ra) # 5c0c <printf>
    exit(1);
    5258:	4505                	li	a0,1
    525a:	00000097          	auipc	ra,0x0
    525e:	60e080e7          	jalr	1550(ra) # 5868 <exit>
    printf("fork failed in countfree()\n");
    5262:	00003517          	auipc	a0,0x3
    5266:	d8e50513          	addi	a0,a0,-626 # 7ff0 <malloc+0x2326>
    526a:	00001097          	auipc	ra,0x1
    526e:	9a2080e7          	jalr	-1630(ra) # 5c0c <printf>
    exit(1);
    5272:	4505                	li	a0,1
    5274:	00000097          	auipc	ra,0x0
    5278:	5f4080e7          	jalr	1524(ra) # 5868 <exit>
      }
    }

    exit(0);
    527c:	4501                	li	a0,0
    527e:	00000097          	auipc	ra,0x0
    5282:	5ea080e7          	jalr	1514(ra) # 5868 <exit>
  }

  close(fds[1]);
    5286:	fcc42503          	lw	a0,-52(s0)
    528a:	00000097          	auipc	ra,0x0
    528e:	606080e7          	jalr	1542(ra) # 5890 <close>

  int n = 0;
    5292:	4481                	li	s1,0
  while(1){
    char c;
    int cc = read(fds[0], &c, 1);
    5294:	4605                	li	a2,1
    5296:	fc740593          	addi	a1,s0,-57
    529a:	fc842503          	lw	a0,-56(s0)
    529e:	00000097          	auipc	ra,0x0
    52a2:	5e2080e7          	jalr	1506(ra) # 5880 <read>
    if(cc < 0){
    52a6:	00054563          	bltz	a0,52b0 <countfree+0xf2>
      printf("read() failed in countfree()\n");
      exit(1);
    }
    if(cc == 0)
    52aa:	c105                	beqz	a0,52ca <countfree+0x10c>
      break;
    n += 1;
    52ac:	2485                	addiw	s1,s1,1
  while(1){
    52ae:	b7dd                	j	5294 <countfree+0xd6>
      printf("read() failed in countfree()\n");
    52b0:	00003517          	auipc	a0,0x3
    52b4:	d8050513          	addi	a0,a0,-640 # 8030 <malloc+0x2366>
    52b8:	00001097          	auipc	ra,0x1
    52bc:	954080e7          	jalr	-1708(ra) # 5c0c <printf>
      exit(1);
    52c0:	4505                	li	a0,1
    52c2:	00000097          	auipc	ra,0x0
    52c6:	5a6080e7          	jalr	1446(ra) # 5868 <exit>
  }

  close(fds[0]);
    52ca:	fc842503          	lw	a0,-56(s0)
    52ce:	00000097          	auipc	ra,0x0
    52d2:	5c2080e7          	jalr	1474(ra) # 5890 <close>
  wait((int*)0);
    52d6:	4501                	li	a0,0
    52d8:	00000097          	auipc	ra,0x0
    52dc:	598080e7          	jalr	1432(ra) # 5870 <wait>
  
  return n;
}
    52e0:	8526                	mv	a0,s1
    52e2:	70e2                	ld	ra,56(sp)
    52e4:	7442                	ld	s0,48(sp)
    52e6:	74a2                	ld	s1,40(sp)
    52e8:	7902                	ld	s2,32(sp)
    52ea:	69e2                	ld	s3,24(sp)
    52ec:	6121                	addi	sp,sp,64
    52ee:	8082                	ret

00000000000052f0 <run>:

// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int
run(void f(char *), char *s) {
    52f0:	7179                	addi	sp,sp,-48
    52f2:	f406                	sd	ra,40(sp)
    52f4:	f022                	sd	s0,32(sp)
    52f6:	ec26                	sd	s1,24(sp)
    52f8:	e84a                	sd	s2,16(sp)
    52fa:	1800                	addi	s0,sp,48
    52fc:	84aa                	mv	s1,a0
    52fe:	892e                	mv	s2,a1
  int pid;
  int xstatus;

  printf("test %s: ", s);
    5300:	00003517          	auipc	a0,0x3
    5304:	d5050513          	addi	a0,a0,-688 # 8050 <malloc+0x2386>
    5308:	00001097          	auipc	ra,0x1
    530c:	904080e7          	jalr	-1788(ra) # 5c0c <printf>
  if((pid = fork()) < 0) {
    5310:	00000097          	auipc	ra,0x0
    5314:	550080e7          	jalr	1360(ra) # 5860 <fork>
    5318:	02054e63          	bltz	a0,5354 <run+0x64>
    printf("runtest: fork error\n");
    exit(1);
  }
  if(pid == 0) {
    531c:	c929                	beqz	a0,536e <run+0x7e>
    f(s);
    exit(0);
  } else {
    wait(&xstatus);
    531e:	fdc40513          	addi	a0,s0,-36
    5322:	00000097          	auipc	ra,0x0
    5326:	54e080e7          	jalr	1358(ra) # 5870 <wait>
    if(xstatus != 0) 
    532a:	fdc42783          	lw	a5,-36(s0)
    532e:	c7b9                	beqz	a5,537c <run+0x8c>
      printf("FAILED\n");
    5330:	00003517          	auipc	a0,0x3
    5334:	d4850513          	addi	a0,a0,-696 # 8078 <malloc+0x23ae>
    5338:	00001097          	auipc	ra,0x1
    533c:	8d4080e7          	jalr	-1836(ra) # 5c0c <printf>
    else
      printf("OK\n");
    return xstatus == 0;
    5340:	fdc42503          	lw	a0,-36(s0)
  }
}
    5344:	00153513          	seqz	a0,a0
    5348:	70a2                	ld	ra,40(sp)
    534a:	7402                	ld	s0,32(sp)
    534c:	64e2                	ld	s1,24(sp)
    534e:	6942                	ld	s2,16(sp)
    5350:	6145                	addi	sp,sp,48
    5352:	8082                	ret
    printf("runtest: fork error\n");
    5354:	00003517          	auipc	a0,0x3
    5358:	d0c50513          	addi	a0,a0,-756 # 8060 <malloc+0x2396>
    535c:	00001097          	auipc	ra,0x1
    5360:	8b0080e7          	jalr	-1872(ra) # 5c0c <printf>
    exit(1);
    5364:	4505                	li	a0,1
    5366:	00000097          	auipc	ra,0x0
    536a:	502080e7          	jalr	1282(ra) # 5868 <exit>
    f(s);
    536e:	854a                	mv	a0,s2
    5370:	9482                	jalr	s1
    exit(0);
    5372:	4501                	li	a0,0
    5374:	00000097          	auipc	ra,0x0
    5378:	4f4080e7          	jalr	1268(ra) # 5868 <exit>
      printf("OK\n");
    537c:	00003517          	auipc	a0,0x3
    5380:	d0450513          	addi	a0,a0,-764 # 8080 <malloc+0x23b6>
    5384:	00001097          	auipc	ra,0x1
    5388:	888080e7          	jalr	-1912(ra) # 5c0c <printf>
    538c:	bf55                	j	5340 <run+0x50>

000000000000538e <main>:

int
main(int argc, char *argv[])
{
    538e:	bd010113          	addi	sp,sp,-1072
    5392:	42113423          	sd	ra,1064(sp)
    5396:	42813023          	sd	s0,1056(sp)
    539a:	40913c23          	sd	s1,1048(sp)
    539e:	41213823          	sd	s2,1040(sp)
    53a2:	41313423          	sd	s3,1032(sp)
    53a6:	41413023          	sd	s4,1024(sp)
    53aa:	3f513c23          	sd	s5,1016(sp)
    53ae:	3f613823          	sd	s6,1008(sp)
    53b2:	43010413          	addi	s0,sp,1072
    53b6:	89aa                	mv	s3,a0
  int continuous = 0;
  char *justone = 0;

  if(argc == 2 && strcmp(argv[1], "-c") == 0){
    53b8:	4789                	li	a5,2
    53ba:	08f50f63          	beq	a0,a5,5458 <main+0xca>
    continuous = 1;
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    continuous = 2;
  } else if(argc == 2 && argv[1][0] != '-'){
    justone = argv[1];
  } else if(argc > 1){
    53be:	4785                	li	a5,1
  char *justone = 0;
    53c0:	4901                	li	s2,0
  } else if(argc > 1){
    53c2:	0ca7c963          	blt	a5,a0,5494 <main+0x106>
  }
  
  struct test {
    void (*f)(char *);
    char *s;
  } tests[] = {
    53c6:	00003797          	auipc	a5,0x3
    53ca:	dd278793          	addi	a5,a5,-558 # 8198 <malloc+0x24ce>
    53ce:	bd040713          	addi	a4,s0,-1072
    53d2:	00003317          	auipc	t1,0x3
    53d6:	1b630313          	addi	t1,t1,438 # 8588 <malloc+0x28be>
    53da:	0007b883          	ld	a7,0(a5)
    53de:	0087b803          	ld	a6,8(a5)
    53e2:	6b88                	ld	a0,16(a5)
    53e4:	6f8c                	ld	a1,24(a5)
    53e6:	7390                	ld	a2,32(a5)
    53e8:	7794                	ld	a3,40(a5)
    53ea:	01173023          	sd	a7,0(a4)
    53ee:	01073423          	sd	a6,8(a4)
    53f2:	eb08                	sd	a0,16(a4)
    53f4:	ef0c                	sd	a1,24(a4)
    53f6:	f310                	sd	a2,32(a4)
    53f8:	f714                	sd	a3,40(a4)
    53fa:	03078793          	addi	a5,a5,48
    53fe:	03070713          	addi	a4,a4,48
    5402:	fc679ce3          	bne	a5,t1,53da <main+0x4c>
          exit(1);
      }
    }
  }

  printf("usertests starting\n");
    5406:	00003517          	auipc	a0,0x3
    540a:	d3250513          	addi	a0,a0,-718 # 8138 <malloc+0x246e>
    540e:	00000097          	auipc	ra,0x0
    5412:	7fe080e7          	jalr	2046(ra) # 5c0c <printf>
  int free0 = countfree();
    5416:	00000097          	auipc	ra,0x0
    541a:	da8080e7          	jalr	-600(ra) # 51be <countfree>
    541e:	8a2a                	mv	s4,a0
  int free1 = 0;
  int fail = 0;
  for (struct test *t = tests; t->s != 0; t++) {
    5420:	bd843503          	ld	a0,-1064(s0)
    5424:	bd040493          	addi	s1,s0,-1072
  int fail = 0;
    5428:	4981                	li	s3,0
    if((justone == 0) || strcmp(t->s, justone) == 0) {
      if(!run(t->f, t->s))
        fail = 1;
    542a:	4a85                	li	s5,1
  for (struct test *t = tests; t->s != 0; t++) {
    542c:	e55d                	bnez	a0,54da <main+0x14c>
  }

  if(fail){
    printf("SOME TESTS FAILED\n");
    exit(1);
  } else if((free1 = countfree()) < free0){
    542e:	00000097          	auipc	ra,0x0
    5432:	d90080e7          	jalr	-624(ra) # 51be <countfree>
    5436:	85aa                	mv	a1,a0
    5438:	0f455163          	bge	a0,s4,551a <main+0x18c>
    printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    543c:	8652                	mv	a2,s4
    543e:	00003517          	auipc	a0,0x3
    5442:	cb250513          	addi	a0,a0,-846 # 80f0 <malloc+0x2426>
    5446:	00000097          	auipc	ra,0x0
    544a:	7c6080e7          	jalr	1990(ra) # 5c0c <printf>
    exit(1);
    544e:	4505                	li	a0,1
    5450:	00000097          	auipc	ra,0x0
    5454:	418080e7          	jalr	1048(ra) # 5868 <exit>
    5458:	84ae                	mv	s1,a1
  if(argc == 2 && strcmp(argv[1], "-c") == 0){
    545a:	00003597          	auipc	a1,0x3
    545e:	c2e58593          	addi	a1,a1,-978 # 8088 <malloc+0x23be>
    5462:	6488                	ld	a0,8(s1)
    5464:	00000097          	auipc	ra,0x0
    5468:	194080e7          	jalr	404(ra) # 55f8 <strcmp>
    546c:	10050563          	beqz	a0,5576 <main+0x1e8>
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    5470:	00003597          	auipc	a1,0x3
    5474:	d0058593          	addi	a1,a1,-768 # 8170 <malloc+0x24a6>
    5478:	6488                	ld	a0,8(s1)
    547a:	00000097          	auipc	ra,0x0
    547e:	17e080e7          	jalr	382(ra) # 55f8 <strcmp>
    5482:	c97d                	beqz	a0,5578 <main+0x1ea>
  } else if(argc == 2 && argv[1][0] != '-'){
    5484:	0084b903          	ld	s2,8(s1)
    5488:	00094703          	lbu	a4,0(s2)
    548c:	02d00793          	li	a5,45
    5490:	f2f71be3          	bne	a4,a5,53c6 <main+0x38>
    printf("Usage: usertests [-c] [testname]\n");
    5494:	00003517          	auipc	a0,0x3
    5498:	bfc50513          	addi	a0,a0,-1028 # 8090 <malloc+0x23c6>
    549c:	00000097          	auipc	ra,0x0
    54a0:	770080e7          	jalr	1904(ra) # 5c0c <printf>
    exit(1);
    54a4:	4505                	li	a0,1
    54a6:	00000097          	auipc	ra,0x0
    54aa:	3c2080e7          	jalr	962(ra) # 5868 <exit>
          exit(1);
    54ae:	4505                	li	a0,1
    54b0:	00000097          	auipc	ra,0x0
    54b4:	3b8080e7          	jalr	952(ra) # 5868 <exit>
        printf("FAILED -- lost %d free pages\n", free0 - free1);
    54b8:	40a905bb          	subw	a1,s2,a0
    54bc:	855a                	mv	a0,s6
    54be:	00000097          	auipc	ra,0x0
    54c2:	74e080e7          	jalr	1870(ra) # 5c0c <printf>
        if(continuous != 2)
    54c6:	09498463          	beq	s3,s4,554e <main+0x1c0>
          exit(1);
    54ca:	4505                	li	a0,1
    54cc:	00000097          	auipc	ra,0x0
    54d0:	39c080e7          	jalr	924(ra) # 5868 <exit>
  for (struct test *t = tests; t->s != 0; t++) {
    54d4:	04c1                	addi	s1,s1,16
    54d6:	6488                	ld	a0,8(s1)
    54d8:	c115                	beqz	a0,54fc <main+0x16e>
    if((justone == 0) || strcmp(t->s, justone) == 0) {
    54da:	00090863          	beqz	s2,54ea <main+0x15c>
    54de:	85ca                	mv	a1,s2
    54e0:	00000097          	auipc	ra,0x0
    54e4:	118080e7          	jalr	280(ra) # 55f8 <strcmp>
    54e8:	f575                	bnez	a0,54d4 <main+0x146>
      if(!run(t->f, t->s))
    54ea:	648c                	ld	a1,8(s1)
    54ec:	6088                	ld	a0,0(s1)
    54ee:	00000097          	auipc	ra,0x0
    54f2:	e02080e7          	jalr	-510(ra) # 52f0 <run>
    54f6:	fd79                	bnez	a0,54d4 <main+0x146>
        fail = 1;
    54f8:	89d6                	mv	s3,s5
    54fa:	bfe9                	j	54d4 <main+0x146>
  if(fail){
    54fc:	f20989e3          	beqz	s3,542e <main+0xa0>
    printf("SOME TESTS FAILED\n");
    5500:	00003517          	auipc	a0,0x3
    5504:	bd850513          	addi	a0,a0,-1064 # 80d8 <malloc+0x240e>
    5508:	00000097          	auipc	ra,0x0
    550c:	704080e7          	jalr	1796(ra) # 5c0c <printf>
    exit(1);
    5510:	4505                	li	a0,1
    5512:	00000097          	auipc	ra,0x0
    5516:	356080e7          	jalr	854(ra) # 5868 <exit>
  } else {
    printf("ALL TESTS PASSED\n");
    551a:	00003517          	auipc	a0,0x3
    551e:	c0650513          	addi	a0,a0,-1018 # 8120 <malloc+0x2456>
    5522:	00000097          	auipc	ra,0x0
    5526:	6ea080e7          	jalr	1770(ra) # 5c0c <printf>
    exit(0);
    552a:	4501                	li	a0,0
    552c:	00000097          	auipc	ra,0x0
    5530:	33c080e7          	jalr	828(ra) # 5868 <exit>
        printf("SOME TESTS FAILED\n");
    5534:	8556                	mv	a0,s5
    5536:	00000097          	auipc	ra,0x0
    553a:	6d6080e7          	jalr	1750(ra) # 5c0c <printf>
        if(continuous != 2)
    553e:	f74998e3          	bne	s3,s4,54ae <main+0x120>
      int free1 = countfree();
    5542:	00000097          	auipc	ra,0x0
    5546:	c7c080e7          	jalr	-900(ra) # 51be <countfree>
      if(free1 < free0){
    554a:	f72547e3          	blt	a0,s2,54b8 <main+0x12a>
      int free0 = countfree();
    554e:	00000097          	auipc	ra,0x0
    5552:	c70080e7          	jalr	-912(ra) # 51be <countfree>
    5556:	892a                	mv	s2,a0
      for (struct test *t = tests; t->s != 0; t++) {
    5558:	bd843583          	ld	a1,-1064(s0)
    555c:	d1fd                	beqz	a1,5542 <main+0x1b4>
    555e:	bd040493          	addi	s1,s0,-1072
        if(!run(t->f, t->s)){
    5562:	6088                	ld	a0,0(s1)
    5564:	00000097          	auipc	ra,0x0
    5568:	d8c080e7          	jalr	-628(ra) # 52f0 <run>
    556c:	d561                	beqz	a0,5534 <main+0x1a6>
      for (struct test *t = tests; t->s != 0; t++) {
    556e:	04c1                	addi	s1,s1,16
    5570:	648c                	ld	a1,8(s1)
    5572:	f9e5                	bnez	a1,5562 <main+0x1d4>
    5574:	b7f9                	j	5542 <main+0x1b4>
    continuous = 1;
    5576:	4985                	li	s3,1
  } tests[] = {
    5578:	00003797          	auipc	a5,0x3
    557c:	c2078793          	addi	a5,a5,-992 # 8198 <malloc+0x24ce>
    5580:	bd040713          	addi	a4,s0,-1072
    5584:	00003317          	auipc	t1,0x3
    5588:	00430313          	addi	t1,t1,4 # 8588 <malloc+0x28be>
    558c:	0007b883          	ld	a7,0(a5)
    5590:	0087b803          	ld	a6,8(a5)
    5594:	6b88                	ld	a0,16(a5)
    5596:	6f8c                	ld	a1,24(a5)
    5598:	7390                	ld	a2,32(a5)
    559a:	7794                	ld	a3,40(a5)
    559c:	01173023          	sd	a7,0(a4)
    55a0:	01073423          	sd	a6,8(a4)
    55a4:	eb08                	sd	a0,16(a4)
    55a6:	ef0c                	sd	a1,24(a4)
    55a8:	f310                	sd	a2,32(a4)
    55aa:	f714                	sd	a3,40(a4)
    55ac:	03078793          	addi	a5,a5,48
    55b0:	03070713          	addi	a4,a4,48
    55b4:	fc679ce3          	bne	a5,t1,558c <main+0x1fe>
    printf("continuous usertests starting\n");
    55b8:	00003517          	auipc	a0,0x3
    55bc:	b9850513          	addi	a0,a0,-1128 # 8150 <malloc+0x2486>
    55c0:	00000097          	auipc	ra,0x0
    55c4:	64c080e7          	jalr	1612(ra) # 5c0c <printf>
        printf("SOME TESTS FAILED\n");
    55c8:	00003a97          	auipc	s5,0x3
    55cc:	b10a8a93          	addi	s5,s5,-1264 # 80d8 <malloc+0x240e>
        if(continuous != 2)
    55d0:	4a09                	li	s4,2
        printf("FAILED -- lost %d free pages\n", free0 - free1);
    55d2:	00003b17          	auipc	s6,0x3
    55d6:	ae6b0b13          	addi	s6,s6,-1306 # 80b8 <malloc+0x23ee>
    55da:	bf95                	j	554e <main+0x1c0>

00000000000055dc <strcpy>:



char*
strcpy(char *s, const char *t)
{
    55dc:	1141                	addi	sp,sp,-16
    55de:	e422                	sd	s0,8(sp)
    55e0:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    55e2:	87aa                	mv	a5,a0
    55e4:	0585                	addi	a1,a1,1
    55e6:	0785                	addi	a5,a5,1
    55e8:	fff5c703          	lbu	a4,-1(a1)
    55ec:	fee78fa3          	sb	a4,-1(a5)
    55f0:	fb75                	bnez	a4,55e4 <strcpy+0x8>
    ;
  return os;
}
    55f2:	6422                	ld	s0,8(sp)
    55f4:	0141                	addi	sp,sp,16
    55f6:	8082                	ret

00000000000055f8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    55f8:	1141                	addi	sp,sp,-16
    55fa:	e422                	sd	s0,8(sp)
    55fc:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    55fe:	00054783          	lbu	a5,0(a0)
    5602:	cb91                	beqz	a5,5616 <strcmp+0x1e>
    5604:	0005c703          	lbu	a4,0(a1)
    5608:	00f71763          	bne	a4,a5,5616 <strcmp+0x1e>
    p++, q++;
    560c:	0505                	addi	a0,a0,1
    560e:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    5610:	00054783          	lbu	a5,0(a0)
    5614:	fbe5                	bnez	a5,5604 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    5616:	0005c503          	lbu	a0,0(a1)
}
    561a:	40a7853b          	subw	a0,a5,a0
    561e:	6422                	ld	s0,8(sp)
    5620:	0141                	addi	sp,sp,16
    5622:	8082                	ret

0000000000005624 <strlen>:

uint
strlen(const char *s)
{
    5624:	1141                	addi	sp,sp,-16
    5626:	e422                	sd	s0,8(sp)
    5628:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    562a:	00054783          	lbu	a5,0(a0)
    562e:	cf91                	beqz	a5,564a <strlen+0x26>
    5630:	0505                	addi	a0,a0,1
    5632:	87aa                	mv	a5,a0
    5634:	4685                	li	a3,1
    5636:	9e89                	subw	a3,a3,a0
    5638:	00f6853b          	addw	a0,a3,a5
    563c:	0785                	addi	a5,a5,1
    563e:	fff7c703          	lbu	a4,-1(a5)
    5642:	fb7d                	bnez	a4,5638 <strlen+0x14>
    ;
  return n;
}
    5644:	6422                	ld	s0,8(sp)
    5646:	0141                	addi	sp,sp,16
    5648:	8082                	ret
  for(n = 0; s[n]; n++)
    564a:	4501                	li	a0,0
    564c:	bfe5                	j	5644 <strlen+0x20>

000000000000564e <memset>:

void*
memset(void *dst, int c, uint n)
{
    564e:	1141                	addi	sp,sp,-16
    5650:	e422                	sd	s0,8(sp)
    5652:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    5654:	ce09                	beqz	a2,566e <memset+0x20>
    5656:	87aa                	mv	a5,a0
    5658:	fff6071b          	addiw	a4,a2,-1
    565c:	1702                	slli	a4,a4,0x20
    565e:	9301                	srli	a4,a4,0x20
    5660:	0705                	addi	a4,a4,1
    5662:	972a                	add	a4,a4,a0
    cdst[i] = c;
    5664:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    5668:	0785                	addi	a5,a5,1
    566a:	fee79de3          	bne	a5,a4,5664 <memset+0x16>
  }
  return dst;
}
    566e:	6422                	ld	s0,8(sp)
    5670:	0141                	addi	sp,sp,16
    5672:	8082                	ret

0000000000005674 <strchr>:

char*
strchr(const char *s, char c)
{
    5674:	1141                	addi	sp,sp,-16
    5676:	e422                	sd	s0,8(sp)
    5678:	0800                	addi	s0,sp,16
  for(; *s; s++)
    567a:	00054783          	lbu	a5,0(a0)
    567e:	cb99                	beqz	a5,5694 <strchr+0x20>
    if(*s == c)
    5680:	00f58763          	beq	a1,a5,568e <strchr+0x1a>
  for(; *s; s++)
    5684:	0505                	addi	a0,a0,1
    5686:	00054783          	lbu	a5,0(a0)
    568a:	fbfd                	bnez	a5,5680 <strchr+0xc>
      return (char*)s;
  return 0;
    568c:	4501                	li	a0,0
}
    568e:	6422                	ld	s0,8(sp)
    5690:	0141                	addi	sp,sp,16
    5692:	8082                	ret
  return 0;
    5694:	4501                	li	a0,0
    5696:	bfe5                	j	568e <strchr+0x1a>

0000000000005698 <gets>:

char*
gets(char *buf, int max)
{
    5698:	711d                	addi	sp,sp,-96
    569a:	ec86                	sd	ra,88(sp)
    569c:	e8a2                	sd	s0,80(sp)
    569e:	e4a6                	sd	s1,72(sp)
    56a0:	e0ca                	sd	s2,64(sp)
    56a2:	fc4e                	sd	s3,56(sp)
    56a4:	f852                	sd	s4,48(sp)
    56a6:	f456                	sd	s5,40(sp)
    56a8:	f05a                	sd	s6,32(sp)
    56aa:	ec5e                	sd	s7,24(sp)
    56ac:	1080                	addi	s0,sp,96
    56ae:	8baa                	mv	s7,a0
    56b0:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    56b2:	892a                	mv	s2,a0
    56b4:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    56b6:	4aa9                	li	s5,10
    56b8:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    56ba:	89a6                	mv	s3,s1
    56bc:	2485                	addiw	s1,s1,1
    56be:	0344d863          	bge	s1,s4,56ee <gets+0x56>
    cc = read(0, &c, 1);
    56c2:	4605                	li	a2,1
    56c4:	faf40593          	addi	a1,s0,-81
    56c8:	4501                	li	a0,0
    56ca:	00000097          	auipc	ra,0x0
    56ce:	1b6080e7          	jalr	438(ra) # 5880 <read>
    if(cc < 1)
    56d2:	00a05e63          	blez	a0,56ee <gets+0x56>
    buf[i++] = c;
    56d6:	faf44783          	lbu	a5,-81(s0)
    56da:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    56de:	01578763          	beq	a5,s5,56ec <gets+0x54>
    56e2:	0905                	addi	s2,s2,1
    56e4:	fd679be3          	bne	a5,s6,56ba <gets+0x22>
  for(i=0; i+1 < max; ){
    56e8:	89a6                	mv	s3,s1
    56ea:	a011                	j	56ee <gets+0x56>
    56ec:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    56ee:	99de                	add	s3,s3,s7
    56f0:	00098023          	sb	zero,0(s3)
  return buf;
}
    56f4:	855e                	mv	a0,s7
    56f6:	60e6                	ld	ra,88(sp)
    56f8:	6446                	ld	s0,80(sp)
    56fa:	64a6                	ld	s1,72(sp)
    56fc:	6906                	ld	s2,64(sp)
    56fe:	79e2                	ld	s3,56(sp)
    5700:	7a42                	ld	s4,48(sp)
    5702:	7aa2                	ld	s5,40(sp)
    5704:	7b02                	ld	s6,32(sp)
    5706:	6be2                	ld	s7,24(sp)
    5708:	6125                	addi	sp,sp,96
    570a:	8082                	ret

000000000000570c <stat>:

int
stat(const char *n, struct stat *st)
{
    570c:	1101                	addi	sp,sp,-32
    570e:	ec06                	sd	ra,24(sp)
    5710:	e822                	sd	s0,16(sp)
    5712:	e426                	sd	s1,8(sp)
    5714:	e04a                	sd	s2,0(sp)
    5716:	1000                	addi	s0,sp,32
    5718:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    571a:	4581                	li	a1,0
    571c:	00000097          	auipc	ra,0x0
    5720:	18c080e7          	jalr	396(ra) # 58a8 <open>
  if(fd < 0)
    5724:	02054563          	bltz	a0,574e <stat+0x42>
    5728:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    572a:	85ca                	mv	a1,s2
    572c:	00000097          	auipc	ra,0x0
    5730:	194080e7          	jalr	404(ra) # 58c0 <fstat>
    5734:	892a                	mv	s2,a0
  close(fd);
    5736:	8526                	mv	a0,s1
    5738:	00000097          	auipc	ra,0x0
    573c:	158080e7          	jalr	344(ra) # 5890 <close>
  return r;
}
    5740:	854a                	mv	a0,s2
    5742:	60e2                	ld	ra,24(sp)
    5744:	6442                	ld	s0,16(sp)
    5746:	64a2                	ld	s1,8(sp)
    5748:	6902                	ld	s2,0(sp)
    574a:	6105                	addi	sp,sp,32
    574c:	8082                	ret
    return -1;
    574e:	597d                	li	s2,-1
    5750:	bfc5                	j	5740 <stat+0x34>

0000000000005752 <atoi>:

int
atoi(const char *s)
{
    5752:	1141                	addi	sp,sp,-16
    5754:	e422                	sd	s0,8(sp)
    5756:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    5758:	00054603          	lbu	a2,0(a0)
    575c:	fd06079b          	addiw	a5,a2,-48
    5760:	0ff7f793          	andi	a5,a5,255
    5764:	4725                	li	a4,9
    5766:	02f76963          	bltu	a4,a5,5798 <atoi+0x46>
    576a:	86aa                	mv	a3,a0
  n = 0;
    576c:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
    576e:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
    5770:	0685                	addi	a3,a3,1
    5772:	0025179b          	slliw	a5,a0,0x2
    5776:	9fa9                	addw	a5,a5,a0
    5778:	0017979b          	slliw	a5,a5,0x1
    577c:	9fb1                	addw	a5,a5,a2
    577e:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    5782:	0006c603          	lbu	a2,0(a3) # 1000 <bigdir+0x9e>
    5786:	fd06071b          	addiw	a4,a2,-48
    578a:	0ff77713          	andi	a4,a4,255
    578e:	fee5f1e3          	bgeu	a1,a4,5770 <atoi+0x1e>
  return n;
}
    5792:	6422                	ld	s0,8(sp)
    5794:	0141                	addi	sp,sp,16
    5796:	8082                	ret
  n = 0;
    5798:	4501                	li	a0,0
    579a:	bfe5                	j	5792 <atoi+0x40>

000000000000579c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    579c:	1141                	addi	sp,sp,-16
    579e:	e422                	sd	s0,8(sp)
    57a0:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    57a2:	02b57663          	bgeu	a0,a1,57ce <memmove+0x32>
    while(n-- > 0)
    57a6:	02c05163          	blez	a2,57c8 <memmove+0x2c>
    57aa:	fff6079b          	addiw	a5,a2,-1
    57ae:	1782                	slli	a5,a5,0x20
    57b0:	9381                	srli	a5,a5,0x20
    57b2:	0785                	addi	a5,a5,1
    57b4:	97aa                	add	a5,a5,a0
  dst = vdst;
    57b6:	872a                	mv	a4,a0
      *dst++ = *src++;
    57b8:	0585                	addi	a1,a1,1
    57ba:	0705                	addi	a4,a4,1
    57bc:	fff5c683          	lbu	a3,-1(a1)
    57c0:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    57c4:	fee79ae3          	bne	a5,a4,57b8 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    57c8:	6422                	ld	s0,8(sp)
    57ca:	0141                	addi	sp,sp,16
    57cc:	8082                	ret
    dst += n;
    57ce:	00c50733          	add	a4,a0,a2
    src += n;
    57d2:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    57d4:	fec05ae3          	blez	a2,57c8 <memmove+0x2c>
    57d8:	fff6079b          	addiw	a5,a2,-1
    57dc:	1782                	slli	a5,a5,0x20
    57de:	9381                	srli	a5,a5,0x20
    57e0:	fff7c793          	not	a5,a5
    57e4:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    57e6:	15fd                	addi	a1,a1,-1
    57e8:	177d                	addi	a4,a4,-1
    57ea:	0005c683          	lbu	a3,0(a1)
    57ee:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    57f2:	fee79ae3          	bne	a5,a4,57e6 <memmove+0x4a>
    57f6:	bfc9                	j	57c8 <memmove+0x2c>

00000000000057f8 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    57f8:	1141                	addi	sp,sp,-16
    57fa:	e422                	sd	s0,8(sp)
    57fc:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    57fe:	ca05                	beqz	a2,582e <memcmp+0x36>
    5800:	fff6069b          	addiw	a3,a2,-1
    5804:	1682                	slli	a3,a3,0x20
    5806:	9281                	srli	a3,a3,0x20
    5808:	0685                	addi	a3,a3,1
    580a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    580c:	00054783          	lbu	a5,0(a0)
    5810:	0005c703          	lbu	a4,0(a1)
    5814:	00e79863          	bne	a5,a4,5824 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    5818:	0505                	addi	a0,a0,1
    p2++;
    581a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    581c:	fed518e3          	bne	a0,a3,580c <memcmp+0x14>
  }
  return 0;
    5820:	4501                	li	a0,0
    5822:	a019                	j	5828 <memcmp+0x30>
      return *p1 - *p2;
    5824:	40e7853b          	subw	a0,a5,a4
}
    5828:	6422                	ld	s0,8(sp)
    582a:	0141                	addi	sp,sp,16
    582c:	8082                	ret
  return 0;
    582e:	4501                	li	a0,0
    5830:	bfe5                	j	5828 <memcmp+0x30>

0000000000005832 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    5832:	1141                	addi	sp,sp,-16
    5834:	e406                	sd	ra,8(sp)
    5836:	e022                	sd	s0,0(sp)
    5838:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    583a:	00000097          	auipc	ra,0x0
    583e:	f62080e7          	jalr	-158(ra) # 579c <memmove>
}
    5842:	60a2                	ld	ra,8(sp)
    5844:	6402                	ld	s0,0(sp)
    5846:	0141                	addi	sp,sp,16
    5848:	8082                	ret

000000000000584a <ugetpid>:

#ifdef LAB_PGTBL
int
ugetpid(void)
{
    584a:	1141                	addi	sp,sp,-16
    584c:	e422                	sd	s0,8(sp)
    584e:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
    5850:	040007b7          	lui	a5,0x4000
}
    5854:	17f5                	addi	a5,a5,-3
    5856:	07b2                	slli	a5,a5,0xc
    5858:	4388                	lw	a0,0(a5)
    585a:	6422                	ld	s0,8(sp)
    585c:	0141                	addi	sp,sp,16
    585e:	8082                	ret

0000000000005860 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    5860:	4885                	li	a7,1
 ecall
    5862:	00000073          	ecall
 ret
    5866:	8082                	ret

0000000000005868 <exit>:
.global exit
exit:
 li a7, SYS_exit
    5868:	4889                	li	a7,2
 ecall
    586a:	00000073          	ecall
 ret
    586e:	8082                	ret

0000000000005870 <wait>:
.global wait
wait:
 li a7, SYS_wait
    5870:	488d                	li	a7,3
 ecall
    5872:	00000073          	ecall
 ret
    5876:	8082                	ret

0000000000005878 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    5878:	4891                	li	a7,4
 ecall
    587a:	00000073          	ecall
 ret
    587e:	8082                	ret

0000000000005880 <read>:
.global read
read:
 li a7, SYS_read
    5880:	4895                	li	a7,5
 ecall
    5882:	00000073          	ecall
 ret
    5886:	8082                	ret

0000000000005888 <write>:
.global write
write:
 li a7, SYS_write
    5888:	48c1                	li	a7,16
 ecall
    588a:	00000073          	ecall
 ret
    588e:	8082                	ret

0000000000005890 <close>:
.global close
close:
 li a7, SYS_close
    5890:	48d5                	li	a7,21
 ecall
    5892:	00000073          	ecall
 ret
    5896:	8082                	ret

0000000000005898 <kill>:
.global kill
kill:
 li a7, SYS_kill
    5898:	4899                	li	a7,6
 ecall
    589a:	00000073          	ecall
 ret
    589e:	8082                	ret

00000000000058a0 <exec>:
.global exec
exec:
 li a7, SYS_exec
    58a0:	489d                	li	a7,7
 ecall
    58a2:	00000073          	ecall
 ret
    58a6:	8082                	ret

00000000000058a8 <open>:
.global open
open:
 li a7, SYS_open
    58a8:	48bd                	li	a7,15
 ecall
    58aa:	00000073          	ecall
 ret
    58ae:	8082                	ret

00000000000058b0 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    58b0:	48c5                	li	a7,17
 ecall
    58b2:	00000073          	ecall
 ret
    58b6:	8082                	ret

00000000000058b8 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    58b8:	48c9                	li	a7,18
 ecall
    58ba:	00000073          	ecall
 ret
    58be:	8082                	ret

00000000000058c0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    58c0:	48a1                	li	a7,8
 ecall
    58c2:	00000073          	ecall
 ret
    58c6:	8082                	ret

00000000000058c8 <link>:
.global link
link:
 li a7, SYS_link
    58c8:	48cd                	li	a7,19
 ecall
    58ca:	00000073          	ecall
 ret
    58ce:	8082                	ret

00000000000058d0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    58d0:	48d1                	li	a7,20
 ecall
    58d2:	00000073          	ecall
 ret
    58d6:	8082                	ret

00000000000058d8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    58d8:	48a5                	li	a7,9
 ecall
    58da:	00000073          	ecall
 ret
    58de:	8082                	ret

00000000000058e0 <dup>:
.global dup
dup:
 li a7, SYS_dup
    58e0:	48a9                	li	a7,10
 ecall
    58e2:	00000073          	ecall
 ret
    58e6:	8082                	ret

00000000000058e8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    58e8:	48ad                	li	a7,11
 ecall
    58ea:	00000073          	ecall
 ret
    58ee:	8082                	ret

00000000000058f0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    58f0:	48b1                	li	a7,12
 ecall
    58f2:	00000073          	ecall
 ret
    58f6:	8082                	ret

00000000000058f8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    58f8:	48b5                	li	a7,13
 ecall
    58fa:	00000073          	ecall
 ret
    58fe:	8082                	ret

0000000000005900 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    5900:	48b9                	li	a7,14
 ecall
    5902:	00000073          	ecall
 ret
    5906:	8082                	ret

0000000000005908 <connect>:
.global connect
connect:
 li a7, SYS_connect
    5908:	48f5                	li	a7,29
 ecall
    590a:	00000073          	ecall
 ret
    590e:	8082                	ret

0000000000005910 <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
    5910:	48f9                	li	a7,30
 ecall
    5912:	00000073          	ecall
 ret
    5916:	8082                	ret

0000000000005918 <vmprint>:
.global vmprint
vmprint:
 li a7, SYS_vmprint
    5918:	48fd                	li	a7,31
 ecall
    591a:	00000073          	ecall
 ret
    591e:	8082                	ret

0000000000005920 <madvise>:
.global madvise
madvise:
 li a7, SYS_madvise
    5920:	02000893          	li	a7,32
 ecall
    5924:	00000073          	ecall
 ret
    5928:	8082                	ret

000000000000592a <pgprint>:
.global pgprint
pgprint:
 li a7, SYS_pgprint
    592a:	02100893          	li	a7,33
 ecall
    592e:	00000073          	ecall
 ret
    5932:	8082                	ret

0000000000005934 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    5934:	1101                	addi	sp,sp,-32
    5936:	ec06                	sd	ra,24(sp)
    5938:	e822                	sd	s0,16(sp)
    593a:	1000                	addi	s0,sp,32
    593c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    5940:	4605                	li	a2,1
    5942:	fef40593          	addi	a1,s0,-17
    5946:	00000097          	auipc	ra,0x0
    594a:	f42080e7          	jalr	-190(ra) # 5888 <write>
}
    594e:	60e2                	ld	ra,24(sp)
    5950:	6442                	ld	s0,16(sp)
    5952:	6105                	addi	sp,sp,32
    5954:	8082                	ret

0000000000005956 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    5956:	7139                	addi	sp,sp,-64
    5958:	fc06                	sd	ra,56(sp)
    595a:	f822                	sd	s0,48(sp)
    595c:	f426                	sd	s1,40(sp)
    595e:	f04a                	sd	s2,32(sp)
    5960:	ec4e                	sd	s3,24(sp)
    5962:	0080                	addi	s0,sp,64
    5964:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    5966:	c299                	beqz	a3,596c <printint+0x16>
    5968:	0805c863          	bltz	a1,59f8 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    596c:	2581                	sext.w	a1,a1
  neg = 0;
    596e:	4881                	li	a7,0
    5970:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    5974:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    5976:	2601                	sext.w	a2,a2
    5978:	00003517          	auipc	a0,0x3
    597c:	c1850513          	addi	a0,a0,-1000 # 8590 <digits>
    5980:	883a                	mv	a6,a4
    5982:	2705                	addiw	a4,a4,1
    5984:	02c5f7bb          	remuw	a5,a1,a2
    5988:	1782                	slli	a5,a5,0x20
    598a:	9381                	srli	a5,a5,0x20
    598c:	97aa                	add	a5,a5,a0
    598e:	0007c783          	lbu	a5,0(a5) # 4000000 <__BSS_END__+0x3ff1220>
    5992:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    5996:	0005879b          	sext.w	a5,a1
    599a:	02c5d5bb          	divuw	a1,a1,a2
    599e:	0685                	addi	a3,a3,1
    59a0:	fec7f0e3          	bgeu	a5,a2,5980 <printint+0x2a>
  if(neg)
    59a4:	00088b63          	beqz	a7,59ba <printint+0x64>
    buf[i++] = '-';
    59a8:	fd040793          	addi	a5,s0,-48
    59ac:	973e                	add	a4,a4,a5
    59ae:	02d00793          	li	a5,45
    59b2:	fef70823          	sb	a5,-16(a4)
    59b6:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    59ba:	02e05863          	blez	a4,59ea <printint+0x94>
    59be:	fc040793          	addi	a5,s0,-64
    59c2:	00e78933          	add	s2,a5,a4
    59c6:	fff78993          	addi	s3,a5,-1
    59ca:	99ba                	add	s3,s3,a4
    59cc:	377d                	addiw	a4,a4,-1
    59ce:	1702                	slli	a4,a4,0x20
    59d0:	9301                	srli	a4,a4,0x20
    59d2:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    59d6:	fff94583          	lbu	a1,-1(s2)
    59da:	8526                	mv	a0,s1
    59dc:	00000097          	auipc	ra,0x0
    59e0:	f58080e7          	jalr	-168(ra) # 5934 <putc>
  while(--i >= 0)
    59e4:	197d                	addi	s2,s2,-1
    59e6:	ff3918e3          	bne	s2,s3,59d6 <printint+0x80>
}
    59ea:	70e2                	ld	ra,56(sp)
    59ec:	7442                	ld	s0,48(sp)
    59ee:	74a2                	ld	s1,40(sp)
    59f0:	7902                	ld	s2,32(sp)
    59f2:	69e2                	ld	s3,24(sp)
    59f4:	6121                	addi	sp,sp,64
    59f6:	8082                	ret
    x = -xx;
    59f8:	40b005bb          	negw	a1,a1
    neg = 1;
    59fc:	4885                	li	a7,1
    x = -xx;
    59fe:	bf8d                	j	5970 <printint+0x1a>

0000000000005a00 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    5a00:	7119                	addi	sp,sp,-128
    5a02:	fc86                	sd	ra,120(sp)
    5a04:	f8a2                	sd	s0,112(sp)
    5a06:	f4a6                	sd	s1,104(sp)
    5a08:	f0ca                	sd	s2,96(sp)
    5a0a:	ecce                	sd	s3,88(sp)
    5a0c:	e8d2                	sd	s4,80(sp)
    5a0e:	e4d6                	sd	s5,72(sp)
    5a10:	e0da                	sd	s6,64(sp)
    5a12:	fc5e                	sd	s7,56(sp)
    5a14:	f862                	sd	s8,48(sp)
    5a16:	f466                	sd	s9,40(sp)
    5a18:	f06a                	sd	s10,32(sp)
    5a1a:	ec6e                	sd	s11,24(sp)
    5a1c:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    5a1e:	0005c903          	lbu	s2,0(a1)
    5a22:	18090f63          	beqz	s2,5bc0 <vprintf+0x1c0>
    5a26:	8aaa                	mv	s5,a0
    5a28:	8b32                	mv	s6,a2
    5a2a:	00158493          	addi	s1,a1,1
  state = 0;
    5a2e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    5a30:	02500a13          	li	s4,37
      if(c == 'd'){
    5a34:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    5a38:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    5a3c:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    5a40:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    5a44:	00003b97          	auipc	s7,0x3
    5a48:	b4cb8b93          	addi	s7,s7,-1204 # 8590 <digits>
    5a4c:	a839                	j	5a6a <vprintf+0x6a>
        putc(fd, c);
    5a4e:	85ca                	mv	a1,s2
    5a50:	8556                	mv	a0,s5
    5a52:	00000097          	auipc	ra,0x0
    5a56:	ee2080e7          	jalr	-286(ra) # 5934 <putc>
    5a5a:	a019                	j	5a60 <vprintf+0x60>
    } else if(state == '%'){
    5a5c:	01498f63          	beq	s3,s4,5a7a <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    5a60:	0485                	addi	s1,s1,1
    5a62:	fff4c903          	lbu	s2,-1(s1)
    5a66:	14090d63          	beqz	s2,5bc0 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    5a6a:	0009079b          	sext.w	a5,s2
    if(state == 0){
    5a6e:	fe0997e3          	bnez	s3,5a5c <vprintf+0x5c>
      if(c == '%'){
    5a72:	fd479ee3          	bne	a5,s4,5a4e <vprintf+0x4e>
        state = '%';
    5a76:	89be                	mv	s3,a5
    5a78:	b7e5                	j	5a60 <vprintf+0x60>
      if(c == 'd'){
    5a7a:	05878063          	beq	a5,s8,5aba <vprintf+0xba>
      } else if(c == 'l') {
    5a7e:	05978c63          	beq	a5,s9,5ad6 <vprintf+0xd6>
      } else if(c == 'x') {
    5a82:	07a78863          	beq	a5,s10,5af2 <vprintf+0xf2>
      } else if(c == 'p') {
    5a86:	09b78463          	beq	a5,s11,5b0e <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    5a8a:	07300713          	li	a4,115
    5a8e:	0ce78663          	beq	a5,a4,5b5a <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    5a92:	06300713          	li	a4,99
    5a96:	0ee78e63          	beq	a5,a4,5b92 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    5a9a:	11478863          	beq	a5,s4,5baa <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    5a9e:	85d2                	mv	a1,s4
    5aa0:	8556                	mv	a0,s5
    5aa2:	00000097          	auipc	ra,0x0
    5aa6:	e92080e7          	jalr	-366(ra) # 5934 <putc>
        putc(fd, c);
    5aaa:	85ca                	mv	a1,s2
    5aac:	8556                	mv	a0,s5
    5aae:	00000097          	auipc	ra,0x0
    5ab2:	e86080e7          	jalr	-378(ra) # 5934 <putc>
      }
      state = 0;
    5ab6:	4981                	li	s3,0
    5ab8:	b765                	j	5a60 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    5aba:	008b0913          	addi	s2,s6,8
    5abe:	4685                	li	a3,1
    5ac0:	4629                	li	a2,10
    5ac2:	000b2583          	lw	a1,0(s6)
    5ac6:	8556                	mv	a0,s5
    5ac8:	00000097          	auipc	ra,0x0
    5acc:	e8e080e7          	jalr	-370(ra) # 5956 <printint>
    5ad0:	8b4a                	mv	s6,s2
      state = 0;
    5ad2:	4981                	li	s3,0
    5ad4:	b771                	j	5a60 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    5ad6:	008b0913          	addi	s2,s6,8
    5ada:	4681                	li	a3,0
    5adc:	4629                	li	a2,10
    5ade:	000b2583          	lw	a1,0(s6)
    5ae2:	8556                	mv	a0,s5
    5ae4:	00000097          	auipc	ra,0x0
    5ae8:	e72080e7          	jalr	-398(ra) # 5956 <printint>
    5aec:	8b4a                	mv	s6,s2
      state = 0;
    5aee:	4981                	li	s3,0
    5af0:	bf85                	j	5a60 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    5af2:	008b0913          	addi	s2,s6,8
    5af6:	4681                	li	a3,0
    5af8:	4641                	li	a2,16
    5afa:	000b2583          	lw	a1,0(s6)
    5afe:	8556                	mv	a0,s5
    5b00:	00000097          	auipc	ra,0x0
    5b04:	e56080e7          	jalr	-426(ra) # 5956 <printint>
    5b08:	8b4a                	mv	s6,s2
      state = 0;
    5b0a:	4981                	li	s3,0
    5b0c:	bf91                	j	5a60 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    5b0e:	008b0793          	addi	a5,s6,8
    5b12:	f8f43423          	sd	a5,-120(s0)
    5b16:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    5b1a:	03000593          	li	a1,48
    5b1e:	8556                	mv	a0,s5
    5b20:	00000097          	auipc	ra,0x0
    5b24:	e14080e7          	jalr	-492(ra) # 5934 <putc>
  putc(fd, 'x');
    5b28:	85ea                	mv	a1,s10
    5b2a:	8556                	mv	a0,s5
    5b2c:	00000097          	auipc	ra,0x0
    5b30:	e08080e7          	jalr	-504(ra) # 5934 <putc>
    5b34:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    5b36:	03c9d793          	srli	a5,s3,0x3c
    5b3a:	97de                	add	a5,a5,s7
    5b3c:	0007c583          	lbu	a1,0(a5)
    5b40:	8556                	mv	a0,s5
    5b42:	00000097          	auipc	ra,0x0
    5b46:	df2080e7          	jalr	-526(ra) # 5934 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    5b4a:	0992                	slli	s3,s3,0x4
    5b4c:	397d                	addiw	s2,s2,-1
    5b4e:	fe0914e3          	bnez	s2,5b36 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    5b52:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    5b56:	4981                	li	s3,0
    5b58:	b721                	j	5a60 <vprintf+0x60>
        s = va_arg(ap, char*);
    5b5a:	008b0993          	addi	s3,s6,8
    5b5e:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    5b62:	02090163          	beqz	s2,5b84 <vprintf+0x184>
        while(*s != 0){
    5b66:	00094583          	lbu	a1,0(s2)
    5b6a:	c9a1                	beqz	a1,5bba <vprintf+0x1ba>
          putc(fd, *s);
    5b6c:	8556                	mv	a0,s5
    5b6e:	00000097          	auipc	ra,0x0
    5b72:	dc6080e7          	jalr	-570(ra) # 5934 <putc>
          s++;
    5b76:	0905                	addi	s2,s2,1
        while(*s != 0){
    5b78:	00094583          	lbu	a1,0(s2)
    5b7c:	f9e5                	bnez	a1,5b6c <vprintf+0x16c>
        s = va_arg(ap, char*);
    5b7e:	8b4e                	mv	s6,s3
      state = 0;
    5b80:	4981                	li	s3,0
    5b82:	bdf9                	j	5a60 <vprintf+0x60>
          s = "(null)";
    5b84:	00003917          	auipc	s2,0x3
    5b88:	a0490913          	addi	s2,s2,-1532 # 8588 <malloc+0x28be>
        while(*s != 0){
    5b8c:	02800593          	li	a1,40
    5b90:	bff1                	j	5b6c <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    5b92:	008b0913          	addi	s2,s6,8
    5b96:	000b4583          	lbu	a1,0(s6)
    5b9a:	8556                	mv	a0,s5
    5b9c:	00000097          	auipc	ra,0x0
    5ba0:	d98080e7          	jalr	-616(ra) # 5934 <putc>
    5ba4:	8b4a                	mv	s6,s2
      state = 0;
    5ba6:	4981                	li	s3,0
    5ba8:	bd65                	j	5a60 <vprintf+0x60>
        putc(fd, c);
    5baa:	85d2                	mv	a1,s4
    5bac:	8556                	mv	a0,s5
    5bae:	00000097          	auipc	ra,0x0
    5bb2:	d86080e7          	jalr	-634(ra) # 5934 <putc>
      state = 0;
    5bb6:	4981                	li	s3,0
    5bb8:	b565                	j	5a60 <vprintf+0x60>
        s = va_arg(ap, char*);
    5bba:	8b4e                	mv	s6,s3
      state = 0;
    5bbc:	4981                	li	s3,0
    5bbe:	b54d                	j	5a60 <vprintf+0x60>
    }
  }
}
    5bc0:	70e6                	ld	ra,120(sp)
    5bc2:	7446                	ld	s0,112(sp)
    5bc4:	74a6                	ld	s1,104(sp)
    5bc6:	7906                	ld	s2,96(sp)
    5bc8:	69e6                	ld	s3,88(sp)
    5bca:	6a46                	ld	s4,80(sp)
    5bcc:	6aa6                	ld	s5,72(sp)
    5bce:	6b06                	ld	s6,64(sp)
    5bd0:	7be2                	ld	s7,56(sp)
    5bd2:	7c42                	ld	s8,48(sp)
    5bd4:	7ca2                	ld	s9,40(sp)
    5bd6:	7d02                	ld	s10,32(sp)
    5bd8:	6de2                	ld	s11,24(sp)
    5bda:	6109                	addi	sp,sp,128
    5bdc:	8082                	ret

0000000000005bde <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    5bde:	715d                	addi	sp,sp,-80
    5be0:	ec06                	sd	ra,24(sp)
    5be2:	e822                	sd	s0,16(sp)
    5be4:	1000                	addi	s0,sp,32
    5be6:	e010                	sd	a2,0(s0)
    5be8:	e414                	sd	a3,8(s0)
    5bea:	e818                	sd	a4,16(s0)
    5bec:	ec1c                	sd	a5,24(s0)
    5bee:	03043023          	sd	a6,32(s0)
    5bf2:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    5bf6:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    5bfa:	8622                	mv	a2,s0
    5bfc:	00000097          	auipc	ra,0x0
    5c00:	e04080e7          	jalr	-508(ra) # 5a00 <vprintf>
}
    5c04:	60e2                	ld	ra,24(sp)
    5c06:	6442                	ld	s0,16(sp)
    5c08:	6161                	addi	sp,sp,80
    5c0a:	8082                	ret

0000000000005c0c <printf>:

void
printf(const char *fmt, ...)
{
    5c0c:	711d                	addi	sp,sp,-96
    5c0e:	ec06                	sd	ra,24(sp)
    5c10:	e822                	sd	s0,16(sp)
    5c12:	1000                	addi	s0,sp,32
    5c14:	e40c                	sd	a1,8(s0)
    5c16:	e810                	sd	a2,16(s0)
    5c18:	ec14                	sd	a3,24(s0)
    5c1a:	f018                	sd	a4,32(s0)
    5c1c:	f41c                	sd	a5,40(s0)
    5c1e:	03043823          	sd	a6,48(s0)
    5c22:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    5c26:	00840613          	addi	a2,s0,8
    5c2a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    5c2e:	85aa                	mv	a1,a0
    5c30:	4505                	li	a0,1
    5c32:	00000097          	auipc	ra,0x0
    5c36:	dce080e7          	jalr	-562(ra) # 5a00 <vprintf>
}
    5c3a:	60e2                	ld	ra,24(sp)
    5c3c:	6442                	ld	s0,16(sp)
    5c3e:	6125                	addi	sp,sp,96
    5c40:	8082                	ret

0000000000005c42 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    5c42:	1141                	addi	sp,sp,-16
    5c44:	e422                	sd	s0,8(sp)
    5c46:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    5c48:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    5c4c:	00003797          	auipc	a5,0x3
    5c50:	9647b783          	ld	a5,-1692(a5) # 85b0 <freep>
    5c54:	a805                	j	5c84 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    5c56:	4618                	lw	a4,8(a2)
    5c58:	9db9                	addw	a1,a1,a4
    5c5a:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    5c5e:	6398                	ld	a4,0(a5)
    5c60:	6318                	ld	a4,0(a4)
    5c62:	fee53823          	sd	a4,-16(a0)
    5c66:	a091                	j	5caa <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    5c68:	ff852703          	lw	a4,-8(a0)
    5c6c:	9e39                	addw	a2,a2,a4
    5c6e:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    5c70:	ff053703          	ld	a4,-16(a0)
    5c74:	e398                	sd	a4,0(a5)
    5c76:	a099                	j	5cbc <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    5c78:	6398                	ld	a4,0(a5)
    5c7a:	00e7e463          	bltu	a5,a4,5c82 <free+0x40>
    5c7e:	00e6ea63          	bltu	a3,a4,5c92 <free+0x50>
{
    5c82:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    5c84:	fed7fae3          	bgeu	a5,a3,5c78 <free+0x36>
    5c88:	6398                	ld	a4,0(a5)
    5c8a:	00e6e463          	bltu	a3,a4,5c92 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    5c8e:	fee7eae3          	bltu	a5,a4,5c82 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    5c92:	ff852583          	lw	a1,-8(a0)
    5c96:	6390                	ld	a2,0(a5)
    5c98:	02059713          	slli	a4,a1,0x20
    5c9c:	9301                	srli	a4,a4,0x20
    5c9e:	0712                	slli	a4,a4,0x4
    5ca0:	9736                	add	a4,a4,a3
    5ca2:	fae60ae3          	beq	a2,a4,5c56 <free+0x14>
    bp->s.ptr = p->s.ptr;
    5ca6:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    5caa:	4790                	lw	a2,8(a5)
    5cac:	02061713          	slli	a4,a2,0x20
    5cb0:	9301                	srli	a4,a4,0x20
    5cb2:	0712                	slli	a4,a4,0x4
    5cb4:	973e                	add	a4,a4,a5
    5cb6:	fae689e3          	beq	a3,a4,5c68 <free+0x26>
  } else
    p->s.ptr = bp;
    5cba:	e394                	sd	a3,0(a5)
  freep = p;
    5cbc:	00003717          	auipc	a4,0x3
    5cc0:	8ef73a23          	sd	a5,-1804(a4) # 85b0 <freep>
}
    5cc4:	6422                	ld	s0,8(sp)
    5cc6:	0141                	addi	sp,sp,16
    5cc8:	8082                	ret

0000000000005cca <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    5cca:	7139                	addi	sp,sp,-64
    5ccc:	fc06                	sd	ra,56(sp)
    5cce:	f822                	sd	s0,48(sp)
    5cd0:	f426                	sd	s1,40(sp)
    5cd2:	f04a                	sd	s2,32(sp)
    5cd4:	ec4e                	sd	s3,24(sp)
    5cd6:	e852                	sd	s4,16(sp)
    5cd8:	e456                	sd	s5,8(sp)
    5cda:	e05a                	sd	s6,0(sp)
    5cdc:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    5cde:	02051493          	slli	s1,a0,0x20
    5ce2:	9081                	srli	s1,s1,0x20
    5ce4:	04bd                	addi	s1,s1,15
    5ce6:	8091                	srli	s1,s1,0x4
    5ce8:	0014899b          	addiw	s3,s1,1
    5cec:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    5cee:	00003797          	auipc	a5,0x3
    5cf2:	8c27b783          	ld	a5,-1854(a5) # 85b0 <freep>
    5cf6:	c795                	beqz	a5,5d22 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    5cf8:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
    5cfa:	4518                	lw	a4,8(a0)
    5cfc:	02977f63          	bgeu	a4,s1,5d3a <malloc+0x70>
    5d00:	8a4e                	mv	s4,s3
    5d02:	0009879b          	sext.w	a5,s3
    5d06:	6705                	lui	a4,0x1
    5d08:	00e7f363          	bgeu	a5,a4,5d0e <malloc+0x44>
    5d0c:	6a05                	lui	s4,0x1
    5d0e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    5d12:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p);
    }
    if(p == freep)
    5d16:	00003917          	auipc	s2,0x3
    5d1a:	89a90913          	addi	s2,s2,-1894 # 85b0 <freep>
  if(p == (char*)-1)
    5d1e:	5afd                	li	s5,-1
    5d20:	a0bd                	j	5d8e <malloc+0xc4>
    base.s.ptr = freep = prevp = &base;
    5d22:	00009517          	auipc	a0,0x9
    5d26:	0ae50513          	addi	a0,a0,174 # edd0 <base>
    5d2a:	00003797          	auipc	a5,0x3
    5d2e:	88a7b323          	sd	a0,-1914(a5) # 85b0 <freep>
    5d32:	e108                	sd	a0,0(a0)
    base.s.size = 0;
    5d34:	00052423          	sw	zero,8(a0)
    if(p->s.size >= nunits){
    5d38:	b7e1                	j	5d00 <malloc+0x36>
      if(p->s.size == nunits)
    5d3a:	02e48963          	beq	s1,a4,5d6c <malloc+0xa2>
        p->s.size -= nunits;
    5d3e:	4137073b          	subw	a4,a4,s3
    5d42:	c518                	sw	a4,8(a0)
        p += p->s.size;
    5d44:	1702                	slli	a4,a4,0x20
    5d46:	9301                	srli	a4,a4,0x20
    5d48:	0712                	slli	a4,a4,0x4
    5d4a:	953a                	add	a0,a0,a4
        p->s.size = nunits;
    5d4c:	01352423          	sw	s3,8(a0)
      freep = prevp;
    5d50:	00003717          	auipc	a4,0x3
    5d54:	86f73023          	sd	a5,-1952(a4) # 85b0 <freep>
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    5d58:	70e2                	ld	ra,56(sp)
    5d5a:	7442                	ld	s0,48(sp)
    5d5c:	74a2                	ld	s1,40(sp)
    5d5e:	7902                	ld	s2,32(sp)
    5d60:	69e2                	ld	s3,24(sp)
    5d62:	6a42                	ld	s4,16(sp)
    5d64:	6aa2                	ld	s5,8(sp)
    5d66:	6b02                	ld	s6,0(sp)
    5d68:	6121                	addi	sp,sp,64
    5d6a:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    5d6c:	6118                	ld	a4,0(a0)
    5d6e:	e398                	sd	a4,0(a5)
    5d70:	b7c5                	j	5d50 <malloc+0x86>
  hp->s.size = nu;
    5d72:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    5d76:	0541                	addi	a0,a0,16
    5d78:	00000097          	auipc	ra,0x0
    5d7c:	eca080e7          	jalr	-310(ra) # 5c42 <free>
  return freep;
    5d80:	00093783          	ld	a5,0(s2)
      if((p = morecore(nunits)) == 0)
    5d84:	c39d                	beqz	a5,5daa <malloc+0xe0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    5d86:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
    5d88:	4518                	lw	a4,8(a0)
    5d8a:	fa9778e3          	bgeu	a4,s1,5d3a <malloc+0x70>
    if(p == freep)
    5d8e:	00093703          	ld	a4,0(s2)
    5d92:	87aa                	mv	a5,a0
    5d94:	fea719e3          	bne	a4,a0,5d86 <malloc+0xbc>
  p = sbrk(nu * sizeof(Header));
    5d98:	8552                	mv	a0,s4
    5d9a:	00000097          	auipc	ra,0x0
    5d9e:	b56080e7          	jalr	-1194(ra) # 58f0 <sbrk>
  if(p == (char*)-1)
    5da2:	fd5518e3          	bne	a0,s5,5d72 <malloc+0xa8>
        return 0;
    5da6:	4501                	li	a0,0
    5da8:	bf45                	j	5d58 <malloc+0x8e>
    5daa:	853e                	mv	a0,a5
    5dac:	b775                	j	5d58 <malloc+0x8e>
