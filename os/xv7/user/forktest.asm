
user/_forktest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <print>:

#define N  1000

void
print(const char *s)
{
   0:	1101                	add	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	add	s0,sp,32
   a:	84aa                	mv	s1,a0
  write(1, s, strlen(s));
   c:	124000ef          	jal	130 <strlen>
  10:	0005061b          	sext.w	a2,a0
  14:	85a6                	mv	a1,s1
  16:	4505                	li	a0,1
  18:	5a4000ef          	jal	5bc <write>
}
  1c:	60e2                	ld	ra,24(sp)
  1e:	6442                	ld	s0,16(sp)
  20:	64a2                	ld	s1,8(sp)
  22:	6105                	add	sp,sp,32
  24:	8082                	ret

0000000000000026 <forktest>:

void
forktest(void)
{
  26:	1101                	add	sp,sp,-32
  28:	ec06                	sd	ra,24(sp)
  2a:	e822                	sd	s0,16(sp)
  2c:	e426                	sd	s1,8(sp)
  2e:	e04a                	sd	s2,0(sp)
  30:	1000                	add	s0,sp,32
  int n, pid;

  print("fork test\n");
  32:	00000517          	auipc	a0,0x0
  36:	66650513          	add	a0,a0,1638 # 698 <consolemode+0xc>
  3a:	fc7ff0ef          	jal	0 <print>

  for(n=0; n<N; n++){
  3e:	4481                	li	s1,0
  40:	3e800913          	li	s2,1000
    pid = fork();
  44:	550000ef          	jal	594 <fork>
    if(pid < 0)
  48:	04054363          	bltz	a0,8e <forktest+0x68>
      break;
    if(pid == 0)
  4c:	cd09                	beqz	a0,66 <forktest+0x40>
  for(n=0; n<N; n++){
  4e:	2485                	addw	s1,s1,1
  50:	ff249ae3          	bne	s1,s2,44 <forktest+0x1e>
      exit(0);
  }

  if(n == N){
    print("fork claimed to work N times!\n");
  54:	00000517          	auipc	a0,0x0
  58:	69450513          	add	a0,a0,1684 # 6e8 <consolemode+0x5c>
  5c:	fa5ff0ef          	jal	0 <print>
    exit(1);
  60:	4505                	li	a0,1
  62:	53a000ef          	jal	59c <exit>
      exit(0);
  66:	536000ef          	jal	59c <exit>
  }

  for(; n > 0; n--){
    if(wait(0) < 0){
      print("wait stopped early\n");
  6a:	00000517          	auipc	a0,0x0
  6e:	63e50513          	add	a0,a0,1598 # 6a8 <consolemode+0x1c>
  72:	f8fff0ef          	jal	0 <print>
      exit(1);
  76:	4505                	li	a0,1
  78:	524000ef          	jal	59c <exit>
    }
  }

  if(wait(0) != -1){
    print("wait got too many\n");
  7c:	00000517          	auipc	a0,0x0
  80:	64450513          	add	a0,a0,1604 # 6c0 <consolemode+0x34>
  84:	f7dff0ef          	jal	0 <print>
    exit(1);
  88:	4505                	li	a0,1
  8a:	512000ef          	jal	59c <exit>
  for(; n > 0; n--){
  8e:	00905963          	blez	s1,a0 <forktest+0x7a>
    if(wait(0) < 0){
  92:	4501                	li	a0,0
  94:	510000ef          	jal	5a4 <wait>
  98:	fc0549e3          	bltz	a0,6a <forktest+0x44>
  for(; n > 0; n--){
  9c:	34fd                	addw	s1,s1,-1
  9e:	f8f5                	bnez	s1,92 <forktest+0x6c>
  if(wait(0) != -1){
  a0:	4501                	li	a0,0
  a2:	502000ef          	jal	5a4 <wait>
  a6:	57fd                	li	a5,-1
  a8:	fcf51ae3          	bne	a0,a5,7c <forktest+0x56>
  }

  print("fork test OK\n");
  ac:	00000517          	auipc	a0,0x0
  b0:	62c50513          	add	a0,a0,1580 # 6d8 <consolemode+0x4c>
  b4:	f4dff0ef          	jal	0 <print>
}
  b8:	60e2                	ld	ra,24(sp)
  ba:	6442                	ld	s0,16(sp)
  bc:	64a2                	ld	s1,8(sp)
  be:	6902                	ld	s2,0(sp)
  c0:	6105                	add	sp,sp,32
  c2:	8082                	ret

00000000000000c4 <main>:

int
main(void)
{
  c4:	1141                	add	sp,sp,-16
  c6:	e406                	sd	ra,8(sp)
  c8:	e022                	sd	s0,0(sp)
  ca:	0800                	add	s0,sp,16
  forktest();
  cc:	f5bff0ef          	jal	26 <forktest>
  exit(0);
  d0:	4501                	li	a0,0
  d2:	4ca000ef          	jal	59c <exit>

00000000000000d6 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  d6:	1141                	add	sp,sp,-16
  d8:	e406                	sd	ra,8(sp)
  da:	e022                	sd	s0,0(sp)
  dc:	0800                	add	s0,sp,16
  extern int main();
  main();
  de:	fe7ff0ef          	jal	c4 <main>
  exit(0);
  e2:	4501                	li	a0,0
  e4:	4b8000ef          	jal	59c <exit>

00000000000000e8 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  e8:	1141                	add	sp,sp,-16
  ea:	e422                	sd	s0,8(sp)
  ec:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  ee:	87aa                	mv	a5,a0
  f0:	0585                	add	a1,a1,1
  f2:	0785                	add	a5,a5,1
  f4:	fff5c703          	lbu	a4,-1(a1)
  f8:	fee78fa3          	sb	a4,-1(a5)
  fc:	fb75                	bnez	a4,f0 <strcpy+0x8>
    ;
  return os;
}
  fe:	6422                	ld	s0,8(sp)
 100:	0141                	add	sp,sp,16
 102:	8082                	ret

0000000000000104 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 104:	1141                	add	sp,sp,-16
 106:	e422                	sd	s0,8(sp)
 108:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 10a:	00054783          	lbu	a5,0(a0)
 10e:	cb91                	beqz	a5,122 <strcmp+0x1e>
 110:	0005c703          	lbu	a4,0(a1)
 114:	00f71763          	bne	a4,a5,122 <strcmp+0x1e>
    p++, q++;
 118:	0505                	add	a0,a0,1
 11a:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 11c:	00054783          	lbu	a5,0(a0)
 120:	fbe5                	bnez	a5,110 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 122:	0005c503          	lbu	a0,0(a1)
}
 126:	40a7853b          	subw	a0,a5,a0
 12a:	6422                	ld	s0,8(sp)
 12c:	0141                	add	sp,sp,16
 12e:	8082                	ret

0000000000000130 <strlen>:

uint
strlen(const char *s)
{
 130:	1141                	add	sp,sp,-16
 132:	e422                	sd	s0,8(sp)
 134:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 136:	00054783          	lbu	a5,0(a0)
 13a:	cf91                	beqz	a5,156 <strlen+0x26>
 13c:	0505                	add	a0,a0,1
 13e:	87aa                	mv	a5,a0
 140:	86be                	mv	a3,a5
 142:	0785                	add	a5,a5,1
 144:	fff7c703          	lbu	a4,-1(a5)
 148:	ff65                	bnez	a4,140 <strlen+0x10>
 14a:	40a6853b          	subw	a0,a3,a0
 14e:	2505                	addw	a0,a0,1
    ;
  return n;
}
 150:	6422                	ld	s0,8(sp)
 152:	0141                	add	sp,sp,16
 154:	8082                	ret
  for(n = 0; s[n]; n++)
 156:	4501                	li	a0,0
 158:	bfe5                	j	150 <strlen+0x20>

000000000000015a <memset>:

void*
memset(void *dst, int c, uint n)
{
 15a:	1141                	add	sp,sp,-16
 15c:	e422                	sd	s0,8(sp)
 15e:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 160:	ca19                	beqz	a2,176 <memset+0x1c>
 162:	87aa                	mv	a5,a0
 164:	1602                	sll	a2,a2,0x20
 166:	9201                	srl	a2,a2,0x20
 168:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 16c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 170:	0785                	add	a5,a5,1
 172:	fee79de3          	bne	a5,a4,16c <memset+0x12>
  }
  return dst;
}
 176:	6422                	ld	s0,8(sp)
 178:	0141                	add	sp,sp,16
 17a:	8082                	ret

000000000000017c <strchr>:

char*
strchr(const char *s, char c)
{
 17c:	1141                	add	sp,sp,-16
 17e:	e422                	sd	s0,8(sp)
 180:	0800                	add	s0,sp,16
  for(; *s; s++)
 182:	00054783          	lbu	a5,0(a0)
 186:	cb99                	beqz	a5,19c <strchr+0x20>
    if(*s == c)
 188:	00f58763          	beq	a1,a5,196 <strchr+0x1a>
  for(; *s; s++)
 18c:	0505                	add	a0,a0,1
 18e:	00054783          	lbu	a5,0(a0)
 192:	fbfd                	bnez	a5,188 <strchr+0xc>
      return (char*)s;
  return 0;
 194:	4501                	li	a0,0
}
 196:	6422                	ld	s0,8(sp)
 198:	0141                	add	sp,sp,16
 19a:	8082                	ret
  return 0;
 19c:	4501                	li	a0,0
 19e:	bfe5                	j	196 <strchr+0x1a>

00000000000001a0 <gets>:

char*
gets(char *buf, int max)
{
 1a0:	711d                	add	sp,sp,-96
 1a2:	ec86                	sd	ra,88(sp)
 1a4:	e8a2                	sd	s0,80(sp)
 1a6:	e4a6                	sd	s1,72(sp)
 1a8:	e0ca                	sd	s2,64(sp)
 1aa:	fc4e                	sd	s3,56(sp)
 1ac:	f852                	sd	s4,48(sp)
 1ae:	f456                	sd	s5,40(sp)
 1b0:	f05a                	sd	s6,32(sp)
 1b2:	ec5e                	sd	s7,24(sp)
 1b4:	1080                	add	s0,sp,96
 1b6:	8baa                	mv	s7,a0
 1b8:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1ba:	892a                	mv	s2,a0
 1bc:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1be:	4aa9                	li	s5,10
 1c0:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1c2:	89a6                	mv	s3,s1
 1c4:	2485                	addw	s1,s1,1
 1c6:	0344d663          	bge	s1,s4,1f2 <gets+0x52>
    cc = read(0, &c, 1);
 1ca:	4605                	li	a2,1
 1cc:	faf40593          	add	a1,s0,-81
 1d0:	4501                	li	a0,0
 1d2:	3e2000ef          	jal	5b4 <read>
    if(cc < 1)
 1d6:	00a05e63          	blez	a0,1f2 <gets+0x52>
    buf[i++] = c;
 1da:	faf44783          	lbu	a5,-81(s0)
 1de:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1e2:	01578763          	beq	a5,s5,1f0 <gets+0x50>
 1e6:	0905                	add	s2,s2,1
 1e8:	fd679de3          	bne	a5,s6,1c2 <gets+0x22>
    buf[i++] = c;
 1ec:	89a6                	mv	s3,s1
 1ee:	a011                	j	1f2 <gets+0x52>
 1f0:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1f2:	99de                	add	s3,s3,s7
 1f4:	00098023          	sb	zero,0(s3)
  return buf;
}
 1f8:	855e                	mv	a0,s7
 1fa:	60e6                	ld	ra,88(sp)
 1fc:	6446                	ld	s0,80(sp)
 1fe:	64a6                	ld	s1,72(sp)
 200:	6906                	ld	s2,64(sp)
 202:	79e2                	ld	s3,56(sp)
 204:	7a42                	ld	s4,48(sp)
 206:	7aa2                	ld	s5,40(sp)
 208:	7b02                	ld	s6,32(sp)
 20a:	6be2                	ld	s7,24(sp)
 20c:	6125                	add	sp,sp,96
 20e:	8082                	ret

0000000000000210 <stat>:

int
stat(const char *n, struct stat *st)
{
 210:	1101                	add	sp,sp,-32
 212:	ec06                	sd	ra,24(sp)
 214:	e822                	sd	s0,16(sp)
 216:	e04a                	sd	s2,0(sp)
 218:	1000                	add	s0,sp,32
 21a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 21c:	4581                	li	a1,0
 21e:	3be000ef          	jal	5dc <open>
  if(fd < 0)
 222:	02054263          	bltz	a0,246 <stat+0x36>
 226:	e426                	sd	s1,8(sp)
 228:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 22a:	85ca                	mv	a1,s2
 22c:	3c8000ef          	jal	5f4 <fstat>
 230:	892a                	mv	s2,a0
  close(fd);
 232:	8526                	mv	a0,s1
 234:	390000ef          	jal	5c4 <close>
  return r;
 238:	64a2                	ld	s1,8(sp)
}
 23a:	854a                	mv	a0,s2
 23c:	60e2                	ld	ra,24(sp)
 23e:	6442                	ld	s0,16(sp)
 240:	6902                	ld	s2,0(sp)
 242:	6105                	add	sp,sp,32
 244:	8082                	ret
    return -1;
 246:	597d                	li	s2,-1
 248:	bfcd                	j	23a <stat+0x2a>

000000000000024a <atoi>:

int
atoi(const char *s)
{
 24a:	1141                	add	sp,sp,-16
 24c:	e422                	sd	s0,8(sp)
 24e:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 250:	00054683          	lbu	a3,0(a0)
 254:	fd06879b          	addw	a5,a3,-48
 258:	0ff7f793          	zext.b	a5,a5
 25c:	4625                	li	a2,9
 25e:	02f66863          	bltu	a2,a5,28e <atoi+0x44>
 262:	872a                	mv	a4,a0
  n = 0;
 264:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 266:	0705                	add	a4,a4,1
 268:	0025179b          	sllw	a5,a0,0x2
 26c:	9fa9                	addw	a5,a5,a0
 26e:	0017979b          	sllw	a5,a5,0x1
 272:	9fb5                	addw	a5,a5,a3
 274:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 278:	00074683          	lbu	a3,0(a4)
 27c:	fd06879b          	addw	a5,a3,-48
 280:	0ff7f793          	zext.b	a5,a5
 284:	fef671e3          	bgeu	a2,a5,266 <atoi+0x1c>
  return n;
}
 288:	6422                	ld	s0,8(sp)
 28a:	0141                	add	sp,sp,16
 28c:	8082                	ret
  n = 0;
 28e:	4501                	li	a0,0
 290:	bfe5                	j	288 <atoi+0x3e>

0000000000000292 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 292:	1141                	add	sp,sp,-16
 294:	e422                	sd	s0,8(sp)
 296:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 298:	02b57463          	bgeu	a0,a1,2c0 <memmove+0x2e>
    while(n-- > 0)
 29c:	00c05f63          	blez	a2,2ba <memmove+0x28>
 2a0:	1602                	sll	a2,a2,0x20
 2a2:	9201                	srl	a2,a2,0x20
 2a4:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2a8:	872a                	mv	a4,a0
      *dst++ = *src++;
 2aa:	0585                	add	a1,a1,1
 2ac:	0705                	add	a4,a4,1
 2ae:	fff5c683          	lbu	a3,-1(a1)
 2b2:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2b6:	fef71ae3          	bne	a4,a5,2aa <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2ba:	6422                	ld	s0,8(sp)
 2bc:	0141                	add	sp,sp,16
 2be:	8082                	ret
    dst += n;
 2c0:	00c50733          	add	a4,a0,a2
    src += n;
 2c4:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2c6:	fec05ae3          	blez	a2,2ba <memmove+0x28>
 2ca:	fff6079b          	addw	a5,a2,-1
 2ce:	1782                	sll	a5,a5,0x20
 2d0:	9381                	srl	a5,a5,0x20
 2d2:	fff7c793          	not	a5,a5
 2d6:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2d8:	15fd                	add	a1,a1,-1
 2da:	177d                	add	a4,a4,-1
 2dc:	0005c683          	lbu	a3,0(a1)
 2e0:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2e4:	fee79ae3          	bne	a5,a4,2d8 <memmove+0x46>
 2e8:	bfc9                	j	2ba <memmove+0x28>

00000000000002ea <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2ea:	1141                	add	sp,sp,-16
 2ec:	e422                	sd	s0,8(sp)
 2ee:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2f0:	ca05                	beqz	a2,320 <memcmp+0x36>
 2f2:	fff6069b          	addw	a3,a2,-1
 2f6:	1682                	sll	a3,a3,0x20
 2f8:	9281                	srl	a3,a3,0x20
 2fa:	0685                	add	a3,a3,1
 2fc:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2fe:	00054783          	lbu	a5,0(a0)
 302:	0005c703          	lbu	a4,0(a1)
 306:	00e79863          	bne	a5,a4,316 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 30a:	0505                	add	a0,a0,1
    p2++;
 30c:	0585                	add	a1,a1,1
  while (n-- > 0) {
 30e:	fed518e3          	bne	a0,a3,2fe <memcmp+0x14>
  }
  return 0;
 312:	4501                	li	a0,0
 314:	a019                	j	31a <memcmp+0x30>
      return *p1 - *p2;
 316:	40e7853b          	subw	a0,a5,a4
}
 31a:	6422                	ld	s0,8(sp)
 31c:	0141                	add	sp,sp,16
 31e:	8082                	ret
  return 0;
 320:	4501                	li	a0,0
 322:	bfe5                	j	31a <memcmp+0x30>

0000000000000324 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 324:	1141                	add	sp,sp,-16
 326:	e406                	sd	ra,8(sp)
 328:	e022                	sd	s0,0(sp)
 32a:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 32c:	f67ff0ef          	jal	292 <memmove>
}
 330:	60a2                	ld	ra,8(sp)
 332:	6402                	ld	s0,0(sp)
 334:	0141                	add	sp,sp,16
 336:	8082                	ret

0000000000000338 <htons>:
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
}

uint16_t
htons(uint16_t h)
{
 338:	1141                	add	sp,sp,-16
 33a:	e422                	sd	s0,8(sp)
 33c:	0800                	add	s0,sp,16
    if (!endian) {
 33e:	70802783          	lw	a5,1800(zero) # 708 <endian>
 342:	ef91                	bnez	a5,35e <htons+0x26>
        endian = byteorder();
 344:	4d200793          	li	a5,1234
 348:	70f02423          	sw	a5,1800(zero) # 708 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 34c:	0085179b          	sllw	a5,a0,0x8
 350:	0085551b          	srlw	a0,a0,0x8
 354:	8fc9                	or	a5,a5,a0
 356:	03079513          	sll	a0,a5,0x30
 35a:	9141                	srl	a0,a0,0x30
 35c:	a029                	j	366 <htons+0x2e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(h) : h;
 35e:	4d200713          	li	a4,1234
 362:	fee785e3          	beq	a5,a4,34c <htons+0x14>
}
 366:	6422                	ld	s0,8(sp)
 368:	0141                	add	sp,sp,16
 36a:	8082                	ret

000000000000036c <ntohs>:

uint16_t
ntohs(uint16_t n)
{
 36c:	1141                	add	sp,sp,-16
 36e:	e422                	sd	s0,8(sp)
 370:	0800                	add	s0,sp,16
    if (!endian) {
 372:	70802783          	lw	a5,1800(zero) # 708 <endian>
 376:	ef91                	bnez	a5,392 <ntohs+0x26>
        endian = byteorder();
 378:	4d200793          	li	a5,1234
 37c:	70f02423          	sw	a5,1800(zero) # 708 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 380:	0085179b          	sllw	a5,a0,0x8
 384:	0085551b          	srlw	a0,a0,0x8
 388:	8fc9                	or	a5,a5,a0
 38a:	03079513          	sll	a0,a5,0x30
 38e:	9141                	srl	a0,a0,0x30
 390:	a029                	j	39a <ntohs+0x2e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(n) : n;
 392:	4d200713          	li	a4,1234
 396:	fee785e3          	beq	a5,a4,380 <ntohs+0x14>
}
 39a:	6422                	ld	s0,8(sp)
 39c:	0141                	add	sp,sp,16
 39e:	8082                	ret

00000000000003a0 <htonl>:

uint32_t
htonl(uint32_t h)
{
 3a0:	1141                	add	sp,sp,-16
 3a2:	e422                	sd	s0,8(sp)
 3a4:	0800                	add	s0,sp,16
    if (!endian) {
 3a6:	70802783          	lw	a5,1800(zero) # 708 <endian>
 3aa:	eb95                	bnez	a5,3de <htonl+0x3e>
        endian = byteorder();
 3ac:	4d200793          	li	a5,1234
 3b0:	70f02423          	sw	a5,1800(zero) # 708 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 3b4:	0185179b          	sllw	a5,a0,0x18
 3b8:	0185571b          	srlw	a4,a0,0x18
 3bc:	8fd9                	or	a5,a5,a4
 3be:	0085171b          	sllw	a4,a0,0x8
 3c2:	00ff06b7          	lui	a3,0xff0
 3c6:	8f75                	and	a4,a4,a3
 3c8:	8fd9                	or	a5,a5,a4
 3ca:	0085551b          	srlw	a0,a0,0x8
 3ce:	6741                	lui	a4,0x10
 3d0:	f0070713          	add	a4,a4,-256 # ff00 <__global_pointer$+0xeff9>
 3d4:	8d79                	and	a0,a0,a4
 3d6:	8fc9                	or	a5,a5,a0
 3d8:	0007851b          	sext.w	a0,a5
 3dc:	a029                	j	3e6 <htonl+0x46>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(h) : h;
 3de:	4d200713          	li	a4,1234
 3e2:	fce789e3          	beq	a5,a4,3b4 <htonl+0x14>
}
 3e6:	6422                	ld	s0,8(sp)
 3e8:	0141                	add	sp,sp,16
 3ea:	8082                	ret

00000000000003ec <ntohl>:

uint32_t
ntohl(uint32_t n)
{
 3ec:	1141                	add	sp,sp,-16
 3ee:	e422                	sd	s0,8(sp)
 3f0:	0800                	add	s0,sp,16
    if (!endian) {
 3f2:	70802783          	lw	a5,1800(zero) # 708 <endian>
 3f6:	eb95                	bnez	a5,42a <ntohl+0x3e>
        endian = byteorder();
 3f8:	4d200793          	li	a5,1234
 3fc:	70f02423          	sw	a5,1800(zero) # 708 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 400:	0185179b          	sllw	a5,a0,0x18
 404:	0185571b          	srlw	a4,a0,0x18
 408:	8fd9                	or	a5,a5,a4
 40a:	0085171b          	sllw	a4,a0,0x8
 40e:	00ff06b7          	lui	a3,0xff0
 412:	8f75                	and	a4,a4,a3
 414:	8fd9                	or	a5,a5,a4
 416:	0085551b          	srlw	a0,a0,0x8
 41a:	6741                	lui	a4,0x10
 41c:	f0070713          	add	a4,a4,-256 # ff00 <__global_pointer$+0xeff9>
 420:	8d79                	and	a0,a0,a4
 422:	8fc9                	or	a5,a5,a0
 424:	0007851b          	sext.w	a0,a5
 428:	a029                	j	432 <ntohl+0x46>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(n) : n;
 42a:	4d200713          	li	a4,1234
 42e:	fce789e3          	beq	a5,a4,400 <ntohl+0x14>
}
 432:	6422                	ld	s0,8(sp)
 434:	0141                	add	sp,sp,16
 436:	8082                	ret

0000000000000438 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
 438:	1141                	add	sp,sp,-16
 43a:	e422                	sd	s0,8(sp)
 43c:	0800                	add	s0,sp,16
 43e:	872a                	mv	a4,a0
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
 440:	02000693          	li	a3,32
 444:	4525                	li	a0,9
 446:	a011                	j	44a <strtol+0x12>
        s++;
 448:	0705                	add	a4,a4,1
    while (*s == ' ' || *s == '\t')
 44a:	00074783          	lbu	a5,0(a4)
 44e:	fed78de3          	beq	a5,a3,448 <strtol+0x10>
 452:	fea78be3          	beq	a5,a0,448 <strtol+0x10>

    // plus/minus sign
    if (*s == '+')
 456:	02b00693          	li	a3,43
 45a:	02d78663          	beq	a5,a3,486 <strtol+0x4e>
        s++;
    else if (*s == '-')
 45e:	02d00693          	li	a3,45
    int neg = 0;
 462:	4301                	li	t1,0
    else if (*s == '-')
 464:	02d78463          	beq	a5,a3,48c <strtol+0x54>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 468:	fef67793          	and	a5,a2,-17
 46c:	eb89                	bnez	a5,47e <strtol+0x46>
 46e:	00074683          	lbu	a3,0(a4)
 472:	03000793          	li	a5,48
 476:	00f68e63          	beq	a3,a5,492 <strtol+0x5a>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
 47a:	e211                	bnez	a2,47e <strtol+0x46>
        s++, base = 8;
    else if (base == 0)
        base = 10;
 47c:	4629                	li	a2,10
 47e:	4501                	li	a0,0

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
 480:	4825                	li	a6,9
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
 482:	48e5                	li	a7,25
 484:	a825                	j	4bc <strtol+0x84>
        s++;
 486:	0705                	add	a4,a4,1
    int neg = 0;
 488:	4301                	li	t1,0
 48a:	bff9                	j	468 <strtol+0x30>
        s++, neg = 1;
 48c:	0705                	add	a4,a4,1
 48e:	4305                	li	t1,1
 490:	bfe1                	j	468 <strtol+0x30>
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 492:	00174683          	lbu	a3,1(a4)
 496:	07800793          	li	a5,120
 49a:	00f68663          	beq	a3,a5,4a6 <strtol+0x6e>
    else if (base == 0 && s[0] == '0')
 49e:	f265                	bnez	a2,47e <strtol+0x46>
        s++, base = 8;
 4a0:	0705                	add	a4,a4,1
 4a2:	4621                	li	a2,8
 4a4:	bfe9                	j	47e <strtol+0x46>
        s += 2, base = 16;
 4a6:	0709                	add	a4,a4,2
 4a8:	4641                	li	a2,16
 4aa:	bfd1                	j	47e <strtol+0x46>
            dig = *s - '0';
 4ac:	fd07879b          	addw	a5,a5,-48
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
 4b0:	04c7d063          	bge	a5,a2,4f0 <strtol+0xb8>
            break;
        s++, val = (val * base) + dig;
 4b4:	0705                	add	a4,a4,1
 4b6:	02a60533          	mul	a0,a2,a0
 4ba:	953e                	add	a0,a0,a5
        if (*s >= '0' && *s <= '9')
 4bc:	00074783          	lbu	a5,0(a4)
 4c0:	fd07869b          	addw	a3,a5,-48
 4c4:	0ff6f693          	zext.b	a3,a3
 4c8:	fed872e3          	bgeu	a6,a3,4ac <strtol+0x74>
        else if (*s >= 'a' && *s <= 'z')
 4cc:	f9f7869b          	addw	a3,a5,-97
 4d0:	0ff6f693          	zext.b	a3,a3
 4d4:	00d8e563          	bltu	a7,a3,4de <strtol+0xa6>
            dig = *s - 'a' + 10;
 4d8:	fa97879b          	addw	a5,a5,-87
 4dc:	bfd1                	j	4b0 <strtol+0x78>
        else if (*s >= 'A' && *s <= 'Z')
 4de:	fbf7869b          	addw	a3,a5,-65
 4e2:	0ff6f693          	zext.b	a3,a3
 4e6:	00d8e563          	bltu	a7,a3,4f0 <strtol+0xb8>
            dig = *s - 'A' + 10;
 4ea:	fc97879b          	addw	a5,a5,-55
 4ee:	b7c9                	j	4b0 <strtol+0x78>
        // we don't properly detect overflow!
    }

    if (endptr)
 4f0:	c191                	beqz	a1,4f4 <strtol+0xbc>
        *endptr = (char *) s;
 4f2:	e198                	sd	a4,0(a1)
    return (neg ? -val : val);
 4f4:	00030463          	beqz	t1,4fc <strtol+0xc4>
 4f8:	40a00533          	neg	a0,a0
}
 4fc:	6422                	ld	s0,8(sp)
 4fe:	0141                	add	sp,sp,16
 500:	8082                	ret

0000000000000502 <inet_pton>:
inet_pton (int family, const char *p, void *n) {
    char *sp, *ep;
    int idx;
    long ret;

    if (family != AF_INET) {
 502:	4785                	li	a5,1
 504:	08f51063          	bne	a0,a5,584 <inet_pton+0x82>
inet_pton (int family, const char *p, void *n) {
 508:	715d                	add	sp,sp,-80
 50a:	e486                	sd	ra,72(sp)
 50c:	e0a2                	sd	s0,64(sp)
 50e:	fc26                	sd	s1,56(sp)
 510:	f84a                	sd	s2,48(sp)
 512:	f44e                	sd	s3,40(sp)
 514:	f052                	sd	s4,32(sp)
 516:	ec56                	sd	s5,24(sp)
 518:	e85a                	sd	s6,16(sp)
 51a:	0880                	add	s0,sp,80
 51c:	84ae                	mv	s1,a1
 51e:	89b2                	mv	s3,a2
 520:	4901                	li	s2,0
        return -1;
    }
    sp = (char *)p;
    for (idx = 0; idx < 4; idx++) {
        ret = strtol(sp, &ep, 10);
        if (ret < 0 || ret > 255) {
 522:	0ff00a13          	li	s4,255
            return -1;
        }
        if (ep == sp) {
            return -1;
        }
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 526:	4a8d                	li	s5,3
 528:	02e00b13          	li	s6,46
 52c:	a805                	j	55c <inet_pton+0x5a>
 52e:	0007c783          	lbu	a5,0(a5)
 532:	efb9                	bnez	a5,590 <inet_pton+0x8e>
            return -1;
        }
        ((uint8_t *)n)[idx] = ret;
 534:	00a981a3          	sb	a0,3(s3)
        sp = ep + 1;
    }
    return 0;
 538:	4501                	li	a0,0
}
 53a:	60a6                	ld	ra,72(sp)
 53c:	6406                	ld	s0,64(sp)
 53e:	74e2                	ld	s1,56(sp)
 540:	7942                	ld	s2,48(sp)
 542:	79a2                	ld	s3,40(sp)
 544:	7a02                	ld	s4,32(sp)
 546:	6ae2                	ld	s5,24(sp)
 548:	6b42                	ld	s6,16(sp)
 54a:	6161                	add	sp,sp,80
 54c:	8082                	ret
        ((uint8_t *)n)[idx] = ret;
 54e:	01298733          	add	a4,s3,s2
 552:	00a70023          	sb	a0,0(a4)
        sp = ep + 1;
 556:	00178493          	add	s1,a5,1
    for (idx = 0; idx < 4; idx++) {
 55a:	0905                	add	s2,s2,1
        ret = strtol(sp, &ep, 10);
 55c:	4629                	li	a2,10
 55e:	fb840593          	add	a1,s0,-72
 562:	8526                	mv	a0,s1
 564:	ed5ff0ef          	jal	438 <strtol>
        if (ret < 0 || ret > 255) {
 568:	02aa6063          	bltu	s4,a0,588 <inet_pton+0x86>
        if (ep == sp) {
 56c:	fb843783          	ld	a5,-72(s0)
 570:	00978e63          	beq	a5,s1,58c <inet_pton+0x8a>
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 574:	fb590de3          	beq	s2,s5,52e <inet_pton+0x2c>
 578:	0007c703          	lbu	a4,0(a5)
 57c:	fd6709e3          	beq	a4,s6,54e <inet_pton+0x4c>
            return -1;
 580:	557d                	li	a0,-1
 582:	bf65                	j	53a <inet_pton+0x38>
        return -1;
 584:	557d                	li	a0,-1
}
 586:	8082                	ret
            return -1;
 588:	557d                	li	a0,-1
 58a:	bf45                	j	53a <inet_pton+0x38>
            return -1;
 58c:	557d                	li	a0,-1
 58e:	b775                	j	53a <inet_pton+0x38>
            return -1;
 590:	557d                	li	a0,-1
 592:	b765                	j	53a <inet_pton+0x38>

0000000000000594 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 594:	4885                	li	a7,1
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <exit>:
.global exit
exit:
 li a7, SYS_exit
 59c:	4889                	li	a7,2
 ecall
 59e:	00000073          	ecall
 ret
 5a2:	8082                	ret

00000000000005a4 <wait>:
.global wait
wait:
 li a7, SYS_wait
 5a4:	488d                	li	a7,3
 ecall
 5a6:	00000073          	ecall
 ret
 5aa:	8082                	ret

00000000000005ac <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5ac:	4891                	li	a7,4
 ecall
 5ae:	00000073          	ecall
 ret
 5b2:	8082                	ret

00000000000005b4 <read>:
.global read
read:
 li a7, SYS_read
 5b4:	4895                	li	a7,5
 ecall
 5b6:	00000073          	ecall
 ret
 5ba:	8082                	ret

00000000000005bc <write>:
.global write
write:
 li a7, SYS_write
 5bc:	48c1                	li	a7,16
 ecall
 5be:	00000073          	ecall
 ret
 5c2:	8082                	ret

00000000000005c4 <close>:
.global close
close:
 li a7, SYS_close
 5c4:	48d5                	li	a7,21
 ecall
 5c6:	00000073          	ecall
 ret
 5ca:	8082                	ret

00000000000005cc <kill>:
.global kill
kill:
 li a7, SYS_kill
 5cc:	4899                	li	a7,6
 ecall
 5ce:	00000073          	ecall
 ret
 5d2:	8082                	ret

00000000000005d4 <exec>:
.global exec
exec:
 li a7, SYS_exec
 5d4:	489d                	li	a7,7
 ecall
 5d6:	00000073          	ecall
 ret
 5da:	8082                	ret

00000000000005dc <open>:
.global open
open:
 li a7, SYS_open
 5dc:	48bd                	li	a7,15
 ecall
 5de:	00000073          	ecall
 ret
 5e2:	8082                	ret

00000000000005e4 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5e4:	48c5                	li	a7,17
 ecall
 5e6:	00000073          	ecall
 ret
 5ea:	8082                	ret

00000000000005ec <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5ec:	48c9                	li	a7,18
 ecall
 5ee:	00000073          	ecall
 ret
 5f2:	8082                	ret

00000000000005f4 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5f4:	48a1                	li	a7,8
 ecall
 5f6:	00000073          	ecall
 ret
 5fa:	8082                	ret

00000000000005fc <link>:
.global link
link:
 li a7, SYS_link
 5fc:	48cd                	li	a7,19
 ecall
 5fe:	00000073          	ecall
 ret
 602:	8082                	ret

0000000000000604 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 604:	48d1                	li	a7,20
 ecall
 606:	00000073          	ecall
 ret
 60a:	8082                	ret

000000000000060c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 60c:	48a5                	li	a7,9
 ecall
 60e:	00000073          	ecall
 ret
 612:	8082                	ret

0000000000000614 <dup>:
.global dup
dup:
 li a7, SYS_dup
 614:	48a9                	li	a7,10
 ecall
 616:	00000073          	ecall
 ret
 61a:	8082                	ret

000000000000061c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 61c:	48ad                	li	a7,11
 ecall
 61e:	00000073          	ecall
 ret
 622:	8082                	ret

0000000000000624 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 624:	48b1                	li	a7,12
 ecall
 626:	00000073          	ecall
 ret
 62a:	8082                	ret

000000000000062c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 62c:	48b5                	li	a7,13
 ecall
 62e:	00000073          	ecall
 ret
 632:	8082                	ret

0000000000000634 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 634:	48b9                	li	a7,14
 ecall
 636:	00000073          	ecall
 ret
 63a:	8082                	ret

000000000000063c <socket>:
.global socket
socket:
 li a7, SYS_socket
 63c:	48d9                	li	a7,22
 ecall
 63e:	00000073          	ecall
 ret
 642:	8082                	ret

0000000000000644 <bind>:
.global bind
bind:
 li a7, SYS_bind
 644:	48dd                	li	a7,23
 ecall
 646:	00000073          	ecall
 ret
 64a:	8082                	ret

000000000000064c <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 64c:	48e1                	li	a7,24
 ecall
 64e:	00000073          	ecall
 ret
 652:	8082                	ret

0000000000000654 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 654:	48e5                	li	a7,25
 ecall
 656:	00000073          	ecall
 ret
 65a:	8082                	ret

000000000000065c <connect>:
.global connect
connect:
 li a7, SYS_connect
 65c:	48e9                	li	a7,26
 ecall
 65e:	00000073          	ecall
 ret
 662:	8082                	ret

0000000000000664 <listen>:
.global listen
listen:
 li a7, SYS_listen
 664:	48ed                	li	a7,27
 ecall
 666:	00000073          	ecall
 ret
 66a:	8082                	ret

000000000000066c <accept>:
.global accept
accept:
 li a7, SYS_accept
 66c:	48f1                	li	a7,28
 ecall
 66e:	00000073          	ecall
 ret
 672:	8082                	ret

0000000000000674 <recv>:
.global recv
recv:
 li a7, SYS_recv
 674:	48f5                	li	a7,29
 ecall
 676:	00000073          	ecall
 ret
 67a:	8082                	ret

000000000000067c <send>:
.global send
send:
 li a7, SYS_send
 67c:	48f9                	li	a7,30
 ecall
 67e:	00000073          	ecall
 ret
 682:	8082                	ret

0000000000000684 <ioctl>:
.global ioctl
ioctl:
 li a7, SYS_ioctl
 684:	48fd                	li	a7,31
 ecall
 686:	00000073          	ecall
 ret
 68a:	8082                	ret

000000000000068c <consolemode>:
.global consolemode
consolemode:
 li a7, SYS_consolemode
 68c:	02000893          	li	a7,32
 ecall
 690:	00000073          	ecall
 ret
 694:	8082                	ret
