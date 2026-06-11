
user/_cat:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	7179                	add	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	add	s0,sp,48
   e:	89aa                	mv	s3,a0
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
  10:	00001917          	auipc	s2,0x1
  14:	00090913          	mv	s2,s2
  18:	20000613          	li	a2,512
  1c:	85ca                	mv	a1,s2
  1e:	854e                	mv	a0,s3
  20:	5c8000ef          	jal	5e8 <read>
  24:	84aa                	mv	s1,a0
  26:	02a05363          	blez	a0,4c <cat+0x4c>
    if (write(1, buf, n) != n) {
  2a:	8626                	mv	a2,s1
  2c:	85ca                	mv	a1,s2
  2e:	4505                	li	a0,1
  30:	5c0000ef          	jal	5f0 <write>
  34:	fe9502e3          	beq	a0,s1,18 <cat+0x18>
      fprintf(2, "cat: write error\n");
  38:	00001597          	auipc	a1,0x1
  3c:	bc858593          	add	a1,a1,-1080 # c00 <malloc+0x102>
  40:	4509                	li	a0,2
  42:	1d7000ef          	jal	a18 <fprintf>
      exit(1);
  46:	4505                	li	a0,1
  48:	588000ef          	jal	5d0 <exit>
    }
  }
  if(n < 0){
  4c:	00054963          	bltz	a0,5e <cat+0x5e>
    fprintf(2, "cat: read error\n");
    exit(1);
  }
}
  50:	70a2                	ld	ra,40(sp)
  52:	7402                	ld	s0,32(sp)
  54:	64e2                	ld	s1,24(sp)
  56:	6942                	ld	s2,16(sp)
  58:	69a2                	ld	s3,8(sp)
  5a:	6145                	add	sp,sp,48
  5c:	8082                	ret
    fprintf(2, "cat: read error\n");
  5e:	00001597          	auipc	a1,0x1
  62:	bba58593          	add	a1,a1,-1094 # c18 <malloc+0x11a>
  66:	4509                	li	a0,2
  68:	1b1000ef          	jal	a18 <fprintf>
    exit(1);
  6c:	4505                	li	a0,1
  6e:	562000ef          	jal	5d0 <exit>

0000000000000072 <main>:

int
main(int argc, char *argv[])
{
  72:	7179                	add	sp,sp,-48
  74:	f406                	sd	ra,40(sp)
  76:	f022                	sd	s0,32(sp)
  78:	1800                	add	s0,sp,48
  int fd, i;

  if(argc <= 1){
  7a:	4785                	li	a5,1
  7c:	04a7d263          	bge	a5,a0,c0 <main+0x4e>
  80:	ec26                	sd	s1,24(sp)
  82:	e84a                	sd	s2,16(sp)
  84:	e44e                	sd	s3,8(sp)
  86:	00858913          	add	s2,a1,8
  8a:	ffe5099b          	addw	s3,a0,-2
  8e:	02099793          	sll	a5,s3,0x20
  92:	01d7d993          	srl	s3,a5,0x1d
  96:	05c1                	add	a1,a1,16
  98:	99ae                	add	s3,s3,a1
    cat(0);
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], O_RDONLY)) < 0){
  9a:	4581                	li	a1,0
  9c:	00093503          	ld	a0,0(s2) # 1010 <buf>
  a0:	570000ef          	jal	610 <open>
  a4:	84aa                	mv	s1,a0
  a6:	02054663          	bltz	a0,d2 <main+0x60>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
      exit(1);
    }
    cat(fd);
  aa:	f57ff0ef          	jal	0 <cat>
    close(fd);
  ae:	8526                	mv	a0,s1
  b0:	548000ef          	jal	5f8 <close>
  for(i = 1; i < argc; i++){
  b4:	0921                	add	s2,s2,8
  b6:	ff3912e3          	bne	s2,s3,9a <main+0x28>
  }
  exit(0);
  ba:	4501                	li	a0,0
  bc:	514000ef          	jal	5d0 <exit>
  c0:	ec26                	sd	s1,24(sp)
  c2:	e84a                	sd	s2,16(sp)
  c4:	e44e                	sd	s3,8(sp)
    cat(0);
  c6:	4501                	li	a0,0
  c8:	f39ff0ef          	jal	0 <cat>
    exit(0);
  cc:	4501                	li	a0,0
  ce:	502000ef          	jal	5d0 <exit>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
  d2:	00093603          	ld	a2,0(s2)
  d6:	00001597          	auipc	a1,0x1
  da:	b5a58593          	add	a1,a1,-1190 # c30 <malloc+0x132>
  de:	4509                	li	a0,2
  e0:	139000ef          	jal	a18 <fprintf>
      exit(1);
  e4:	4505                	li	a0,1
  e6:	4ea000ef          	jal	5d0 <exit>

00000000000000ea <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  ea:	1141                	add	sp,sp,-16
  ec:	e406                	sd	ra,8(sp)
  ee:	e022                	sd	s0,0(sp)
  f0:	0800                	add	s0,sp,16
  extern int main();
  main();
  f2:	f81ff0ef          	jal	72 <main>
  exit(0);
  f6:	4501                	li	a0,0
  f8:	4d8000ef          	jal	5d0 <exit>

00000000000000fc <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  fc:	1141                	add	sp,sp,-16
  fe:	e422                	sd	s0,8(sp)
 100:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 102:	87aa                	mv	a5,a0
 104:	0585                	add	a1,a1,1
 106:	0785                	add	a5,a5,1
 108:	fff5c703          	lbu	a4,-1(a1)
 10c:	fee78fa3          	sb	a4,-1(a5)
 110:	fb75                	bnez	a4,104 <strcpy+0x8>
    ;
  return os;
}
 112:	6422                	ld	s0,8(sp)
 114:	0141                	add	sp,sp,16
 116:	8082                	ret

0000000000000118 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 118:	1141                	add	sp,sp,-16
 11a:	e422                	sd	s0,8(sp)
 11c:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 11e:	00054783          	lbu	a5,0(a0)
 122:	cb91                	beqz	a5,136 <strcmp+0x1e>
 124:	0005c703          	lbu	a4,0(a1)
 128:	00f71763          	bne	a4,a5,136 <strcmp+0x1e>
    p++, q++;
 12c:	0505                	add	a0,a0,1
 12e:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 130:	00054783          	lbu	a5,0(a0)
 134:	fbe5                	bnez	a5,124 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 136:	0005c503          	lbu	a0,0(a1)
}
 13a:	40a7853b          	subw	a0,a5,a0
 13e:	6422                	ld	s0,8(sp)
 140:	0141                	add	sp,sp,16
 142:	8082                	ret

0000000000000144 <strlen>:

uint
strlen(const char *s)
{
 144:	1141                	add	sp,sp,-16
 146:	e422                	sd	s0,8(sp)
 148:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 14a:	00054783          	lbu	a5,0(a0)
 14e:	cf91                	beqz	a5,16a <strlen+0x26>
 150:	0505                	add	a0,a0,1
 152:	87aa                	mv	a5,a0
 154:	86be                	mv	a3,a5
 156:	0785                	add	a5,a5,1
 158:	fff7c703          	lbu	a4,-1(a5)
 15c:	ff65                	bnez	a4,154 <strlen+0x10>
 15e:	40a6853b          	subw	a0,a3,a0
 162:	2505                	addw	a0,a0,1
    ;
  return n;
}
 164:	6422                	ld	s0,8(sp)
 166:	0141                	add	sp,sp,16
 168:	8082                	ret
  for(n = 0; s[n]; n++)
 16a:	4501                	li	a0,0
 16c:	bfe5                	j	164 <strlen+0x20>

000000000000016e <memset>:

void*
memset(void *dst, int c, uint n)
{
 16e:	1141                	add	sp,sp,-16
 170:	e422                	sd	s0,8(sp)
 172:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 174:	ca19                	beqz	a2,18a <memset+0x1c>
 176:	87aa                	mv	a5,a0
 178:	1602                	sll	a2,a2,0x20
 17a:	9201                	srl	a2,a2,0x20
 17c:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 180:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 184:	0785                	add	a5,a5,1
 186:	fee79de3          	bne	a5,a4,180 <memset+0x12>
  }
  return dst;
}
 18a:	6422                	ld	s0,8(sp)
 18c:	0141                	add	sp,sp,16
 18e:	8082                	ret

0000000000000190 <strchr>:

char*
strchr(const char *s, char c)
{
 190:	1141                	add	sp,sp,-16
 192:	e422                	sd	s0,8(sp)
 194:	0800                	add	s0,sp,16
  for(; *s; s++)
 196:	00054783          	lbu	a5,0(a0)
 19a:	cb99                	beqz	a5,1b0 <strchr+0x20>
    if(*s == c)
 19c:	00f58763          	beq	a1,a5,1aa <strchr+0x1a>
  for(; *s; s++)
 1a0:	0505                	add	a0,a0,1
 1a2:	00054783          	lbu	a5,0(a0)
 1a6:	fbfd                	bnez	a5,19c <strchr+0xc>
      return (char*)s;
  return 0;
 1a8:	4501                	li	a0,0
}
 1aa:	6422                	ld	s0,8(sp)
 1ac:	0141                	add	sp,sp,16
 1ae:	8082                	ret
  return 0;
 1b0:	4501                	li	a0,0
 1b2:	bfe5                	j	1aa <strchr+0x1a>

00000000000001b4 <gets>:

char*
gets(char *buf, int max)
{
 1b4:	711d                	add	sp,sp,-96
 1b6:	ec86                	sd	ra,88(sp)
 1b8:	e8a2                	sd	s0,80(sp)
 1ba:	e4a6                	sd	s1,72(sp)
 1bc:	e0ca                	sd	s2,64(sp)
 1be:	fc4e                	sd	s3,56(sp)
 1c0:	f852                	sd	s4,48(sp)
 1c2:	f456                	sd	s5,40(sp)
 1c4:	f05a                	sd	s6,32(sp)
 1c6:	ec5e                	sd	s7,24(sp)
 1c8:	1080                	add	s0,sp,96
 1ca:	8baa                	mv	s7,a0
 1cc:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1ce:	892a                	mv	s2,a0
 1d0:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1d2:	4aa9                	li	s5,10
 1d4:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1d6:	89a6                	mv	s3,s1
 1d8:	2485                	addw	s1,s1,1
 1da:	0344d663          	bge	s1,s4,206 <gets+0x52>
    cc = read(0, &c, 1);
 1de:	4605                	li	a2,1
 1e0:	faf40593          	add	a1,s0,-81
 1e4:	4501                	li	a0,0
 1e6:	402000ef          	jal	5e8 <read>
    if(cc < 1)
 1ea:	00a05e63          	blez	a0,206 <gets+0x52>
    buf[i++] = c;
 1ee:	faf44783          	lbu	a5,-81(s0)
 1f2:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1f6:	01578763          	beq	a5,s5,204 <gets+0x50>
 1fa:	0905                	add	s2,s2,1
 1fc:	fd679de3          	bne	a5,s6,1d6 <gets+0x22>
    buf[i++] = c;
 200:	89a6                	mv	s3,s1
 202:	a011                	j	206 <gets+0x52>
 204:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 206:	99de                	add	s3,s3,s7
 208:	00098023          	sb	zero,0(s3)
  return buf;
}
 20c:	855e                	mv	a0,s7
 20e:	60e6                	ld	ra,88(sp)
 210:	6446                	ld	s0,80(sp)
 212:	64a6                	ld	s1,72(sp)
 214:	6906                	ld	s2,64(sp)
 216:	79e2                	ld	s3,56(sp)
 218:	7a42                	ld	s4,48(sp)
 21a:	7aa2                	ld	s5,40(sp)
 21c:	7b02                	ld	s6,32(sp)
 21e:	6be2                	ld	s7,24(sp)
 220:	6125                	add	sp,sp,96
 222:	8082                	ret

0000000000000224 <stat>:

int
stat(const char *n, struct stat *st)
{
 224:	1101                	add	sp,sp,-32
 226:	ec06                	sd	ra,24(sp)
 228:	e822                	sd	s0,16(sp)
 22a:	e04a                	sd	s2,0(sp)
 22c:	1000                	add	s0,sp,32
 22e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 230:	4581                	li	a1,0
 232:	3de000ef          	jal	610 <open>
  if(fd < 0)
 236:	02054263          	bltz	a0,25a <stat+0x36>
 23a:	e426                	sd	s1,8(sp)
 23c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 23e:	85ca                	mv	a1,s2
 240:	3e8000ef          	jal	628 <fstat>
 244:	892a                	mv	s2,a0
  close(fd);
 246:	8526                	mv	a0,s1
 248:	3b0000ef          	jal	5f8 <close>
  return r;
 24c:	64a2                	ld	s1,8(sp)
}
 24e:	854a                	mv	a0,s2
 250:	60e2                	ld	ra,24(sp)
 252:	6442                	ld	s0,16(sp)
 254:	6902                	ld	s2,0(sp)
 256:	6105                	add	sp,sp,32
 258:	8082                	ret
    return -1;
 25a:	597d                	li	s2,-1
 25c:	bfcd                	j	24e <stat+0x2a>

000000000000025e <atoi>:

int
atoi(const char *s)
{
 25e:	1141                	add	sp,sp,-16
 260:	e422                	sd	s0,8(sp)
 262:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 264:	00054683          	lbu	a3,0(a0)
 268:	fd06879b          	addw	a5,a3,-48
 26c:	0ff7f793          	zext.b	a5,a5
 270:	4625                	li	a2,9
 272:	02f66863          	bltu	a2,a5,2a2 <atoi+0x44>
 276:	872a                	mv	a4,a0
  n = 0;
 278:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 27a:	0705                	add	a4,a4,1
 27c:	0025179b          	sllw	a5,a0,0x2
 280:	9fa9                	addw	a5,a5,a0
 282:	0017979b          	sllw	a5,a5,0x1
 286:	9fb5                	addw	a5,a5,a3
 288:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 28c:	00074683          	lbu	a3,0(a4)
 290:	fd06879b          	addw	a5,a3,-48
 294:	0ff7f793          	zext.b	a5,a5
 298:	fef671e3          	bgeu	a2,a5,27a <atoi+0x1c>
  return n;
}
 29c:	6422                	ld	s0,8(sp)
 29e:	0141                	add	sp,sp,16
 2a0:	8082                	ret
  n = 0;
 2a2:	4501                	li	a0,0
 2a4:	bfe5                	j	29c <atoi+0x3e>

00000000000002a6 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2a6:	1141                	add	sp,sp,-16
 2a8:	e422                	sd	s0,8(sp)
 2aa:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2ac:	02b57463          	bgeu	a0,a1,2d4 <memmove+0x2e>
    while(n-- > 0)
 2b0:	00c05f63          	blez	a2,2ce <memmove+0x28>
 2b4:	1602                	sll	a2,a2,0x20
 2b6:	9201                	srl	a2,a2,0x20
 2b8:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2bc:	872a                	mv	a4,a0
      *dst++ = *src++;
 2be:	0585                	add	a1,a1,1
 2c0:	0705                	add	a4,a4,1
 2c2:	fff5c683          	lbu	a3,-1(a1)
 2c6:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2ca:	fef71ae3          	bne	a4,a5,2be <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2ce:	6422                	ld	s0,8(sp)
 2d0:	0141                	add	sp,sp,16
 2d2:	8082                	ret
    dst += n;
 2d4:	00c50733          	add	a4,a0,a2
    src += n;
 2d8:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2da:	fec05ae3          	blez	a2,2ce <memmove+0x28>
 2de:	fff6079b          	addw	a5,a2,-1
 2e2:	1782                	sll	a5,a5,0x20
 2e4:	9381                	srl	a5,a5,0x20
 2e6:	fff7c793          	not	a5,a5
 2ea:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2ec:	15fd                	add	a1,a1,-1
 2ee:	177d                	add	a4,a4,-1
 2f0:	0005c683          	lbu	a3,0(a1)
 2f4:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2f8:	fee79ae3          	bne	a5,a4,2ec <memmove+0x46>
 2fc:	bfc9                	j	2ce <memmove+0x28>

00000000000002fe <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2fe:	1141                	add	sp,sp,-16
 300:	e422                	sd	s0,8(sp)
 302:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 304:	ca05                	beqz	a2,334 <memcmp+0x36>
 306:	fff6069b          	addw	a3,a2,-1
 30a:	1682                	sll	a3,a3,0x20
 30c:	9281                	srl	a3,a3,0x20
 30e:	0685                	add	a3,a3,1
 310:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 312:	00054783          	lbu	a5,0(a0)
 316:	0005c703          	lbu	a4,0(a1)
 31a:	00e79863          	bne	a5,a4,32a <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 31e:	0505                	add	a0,a0,1
    p2++;
 320:	0585                	add	a1,a1,1
  while (n-- > 0) {
 322:	fed518e3          	bne	a0,a3,312 <memcmp+0x14>
  }
  return 0;
 326:	4501                	li	a0,0
 328:	a019                	j	32e <memcmp+0x30>
      return *p1 - *p2;
 32a:	40e7853b          	subw	a0,a5,a4
}
 32e:	6422                	ld	s0,8(sp)
 330:	0141                	add	sp,sp,16
 332:	8082                	ret
  return 0;
 334:	4501                	li	a0,0
 336:	bfe5                	j	32e <memcmp+0x30>

0000000000000338 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 338:	1141                	add	sp,sp,-16
 33a:	e406                	sd	ra,8(sp)
 33c:	e022                	sd	s0,0(sp)
 33e:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 340:	f67ff0ef          	jal	2a6 <memmove>
}
 344:	60a2                	ld	ra,8(sp)
 346:	6402                	ld	s0,0(sp)
 348:	0141                	add	sp,sp,16
 34a:	8082                	ret

000000000000034c <htons>:
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
}

uint16_t
htons(uint16_t h)
{
 34c:	1141                	add	sp,sp,-16
 34e:	e422                	sd	s0,8(sp)
 350:	0800                	add	s0,sp,16
    if (!endian) {
 352:	00001797          	auipc	a5,0x1
 356:	cae7a783          	lw	a5,-850(a5) # 1000 <endian>
 35a:	e385                	bnez	a5,37a <htons+0x2e>
        endian = byteorder();
 35c:	4d200793          	li	a5,1234
 360:	00001717          	auipc	a4,0x1
 364:	caf72023          	sw	a5,-864(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 368:	0085179b          	sllw	a5,a0,0x8
 36c:	0085551b          	srlw	a0,a0,0x8
 370:	8fc9                	or	a5,a5,a0
 372:	03079513          	sll	a0,a5,0x30
 376:	9141                	srl	a0,a0,0x30
 378:	a029                	j	382 <htons+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(h) : h;
 37a:	4d200713          	li	a4,1234
 37e:	fee785e3          	beq	a5,a4,368 <htons+0x1c>
}
 382:	6422                	ld	s0,8(sp)
 384:	0141                	add	sp,sp,16
 386:	8082                	ret

0000000000000388 <ntohs>:

uint16_t
ntohs(uint16_t n)
{
 388:	1141                	add	sp,sp,-16
 38a:	e422                	sd	s0,8(sp)
 38c:	0800                	add	s0,sp,16
    if (!endian) {
 38e:	00001797          	auipc	a5,0x1
 392:	c727a783          	lw	a5,-910(a5) # 1000 <endian>
 396:	e385                	bnez	a5,3b6 <ntohs+0x2e>
        endian = byteorder();
 398:	4d200793          	li	a5,1234
 39c:	00001717          	auipc	a4,0x1
 3a0:	c6f72223          	sw	a5,-924(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 3a4:	0085179b          	sllw	a5,a0,0x8
 3a8:	0085551b          	srlw	a0,a0,0x8
 3ac:	8fc9                	or	a5,a5,a0
 3ae:	03079513          	sll	a0,a5,0x30
 3b2:	9141                	srl	a0,a0,0x30
 3b4:	a029                	j	3be <ntohs+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(n) : n;
 3b6:	4d200713          	li	a4,1234
 3ba:	fee785e3          	beq	a5,a4,3a4 <ntohs+0x1c>
}
 3be:	6422                	ld	s0,8(sp)
 3c0:	0141                	add	sp,sp,16
 3c2:	8082                	ret

00000000000003c4 <htonl>:

uint32_t
htonl(uint32_t h)
{
 3c4:	1141                	add	sp,sp,-16
 3c6:	e422                	sd	s0,8(sp)
 3c8:	0800                	add	s0,sp,16
    if (!endian) {
 3ca:	00001797          	auipc	a5,0x1
 3ce:	c367a783          	lw	a5,-970(a5) # 1000 <endian>
 3d2:	ef85                	bnez	a5,40a <htonl+0x46>
        endian = byteorder();
 3d4:	4d200793          	li	a5,1234
 3d8:	00001717          	auipc	a4,0x1
 3dc:	c2f72423          	sw	a5,-984(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 3e0:	0185179b          	sllw	a5,a0,0x18
 3e4:	0185571b          	srlw	a4,a0,0x18
 3e8:	8fd9                	or	a5,a5,a4
 3ea:	0085171b          	sllw	a4,a0,0x8
 3ee:	00ff06b7          	lui	a3,0xff0
 3f2:	8f75                	and	a4,a4,a3
 3f4:	8fd9                	or	a5,a5,a4
 3f6:	0085551b          	srlw	a0,a0,0x8
 3fa:	6741                	lui	a4,0x10
 3fc:	f0070713          	add	a4,a4,-256 # ff00 <base+0xecf0>
 400:	8d79                	and	a0,a0,a4
 402:	8fc9                	or	a5,a5,a0
 404:	0007851b          	sext.w	a0,a5
 408:	a029                	j	412 <htonl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(h) : h;
 40a:	4d200713          	li	a4,1234
 40e:	fce789e3          	beq	a5,a4,3e0 <htonl+0x1c>
}
 412:	6422                	ld	s0,8(sp)
 414:	0141                	add	sp,sp,16
 416:	8082                	ret

0000000000000418 <ntohl>:

uint32_t
ntohl(uint32_t n)
{
 418:	1141                	add	sp,sp,-16
 41a:	e422                	sd	s0,8(sp)
 41c:	0800                	add	s0,sp,16
    if (!endian) {
 41e:	00001797          	auipc	a5,0x1
 422:	be27a783          	lw	a5,-1054(a5) # 1000 <endian>
 426:	ef85                	bnez	a5,45e <ntohl+0x46>
        endian = byteorder();
 428:	4d200793          	li	a5,1234
 42c:	00001717          	auipc	a4,0x1
 430:	bcf72a23          	sw	a5,-1068(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 434:	0185179b          	sllw	a5,a0,0x18
 438:	0185571b          	srlw	a4,a0,0x18
 43c:	8fd9                	or	a5,a5,a4
 43e:	0085171b          	sllw	a4,a0,0x8
 442:	00ff06b7          	lui	a3,0xff0
 446:	8f75                	and	a4,a4,a3
 448:	8fd9                	or	a5,a5,a4
 44a:	0085551b          	srlw	a0,a0,0x8
 44e:	6741                	lui	a4,0x10
 450:	f0070713          	add	a4,a4,-256 # ff00 <base+0xecf0>
 454:	8d79                	and	a0,a0,a4
 456:	8fc9                	or	a5,a5,a0
 458:	0007851b          	sext.w	a0,a5
 45c:	a029                	j	466 <ntohl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(n) : n;
 45e:	4d200713          	li	a4,1234
 462:	fce789e3          	beq	a5,a4,434 <ntohl+0x1c>
}
 466:	6422                	ld	s0,8(sp)
 468:	0141                	add	sp,sp,16
 46a:	8082                	ret

000000000000046c <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
 46c:	1141                	add	sp,sp,-16
 46e:	e422                	sd	s0,8(sp)
 470:	0800                	add	s0,sp,16
 472:	872a                	mv	a4,a0
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
 474:	02000693          	li	a3,32
 478:	4525                	li	a0,9
 47a:	a011                	j	47e <strtol+0x12>
        s++;
 47c:	0705                	add	a4,a4,1
    while (*s == ' ' || *s == '\t')
 47e:	00074783          	lbu	a5,0(a4)
 482:	fed78de3          	beq	a5,a3,47c <strtol+0x10>
 486:	fea78be3          	beq	a5,a0,47c <strtol+0x10>

    // plus/minus sign
    if (*s == '+')
 48a:	02b00693          	li	a3,43
 48e:	02d78663          	beq	a5,a3,4ba <strtol+0x4e>
        s++;
    else if (*s == '-')
 492:	02d00693          	li	a3,45
    int neg = 0;
 496:	4301                	li	t1,0
    else if (*s == '-')
 498:	02d78463          	beq	a5,a3,4c0 <strtol+0x54>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 49c:	fef67793          	and	a5,a2,-17
 4a0:	eb89                	bnez	a5,4b2 <strtol+0x46>
 4a2:	00074683          	lbu	a3,0(a4)
 4a6:	03000793          	li	a5,48
 4aa:	00f68e63          	beq	a3,a5,4c6 <strtol+0x5a>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
 4ae:	e211                	bnez	a2,4b2 <strtol+0x46>
        s++, base = 8;
    else if (base == 0)
        base = 10;
 4b0:	4629                	li	a2,10
 4b2:	4501                	li	a0,0

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
 4b4:	4825                	li	a6,9
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
 4b6:	48e5                	li	a7,25
 4b8:	a825                	j	4f0 <strtol+0x84>
        s++;
 4ba:	0705                	add	a4,a4,1
    int neg = 0;
 4bc:	4301                	li	t1,0
 4be:	bff9                	j	49c <strtol+0x30>
        s++, neg = 1;
 4c0:	0705                	add	a4,a4,1
 4c2:	4305                	li	t1,1
 4c4:	bfe1                	j	49c <strtol+0x30>
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 4c6:	00174683          	lbu	a3,1(a4)
 4ca:	07800793          	li	a5,120
 4ce:	00f68663          	beq	a3,a5,4da <strtol+0x6e>
    else if (base == 0 && s[0] == '0')
 4d2:	f265                	bnez	a2,4b2 <strtol+0x46>
        s++, base = 8;
 4d4:	0705                	add	a4,a4,1
 4d6:	4621                	li	a2,8
 4d8:	bfe9                	j	4b2 <strtol+0x46>
        s += 2, base = 16;
 4da:	0709                	add	a4,a4,2
 4dc:	4641                	li	a2,16
 4de:	bfd1                	j	4b2 <strtol+0x46>
            dig = *s - '0';
 4e0:	fd07879b          	addw	a5,a5,-48
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
 4e4:	04c7d063          	bge	a5,a2,524 <strtol+0xb8>
            break;
        s++, val = (val * base) + dig;
 4e8:	0705                	add	a4,a4,1
 4ea:	02a60533          	mul	a0,a2,a0
 4ee:	953e                	add	a0,a0,a5
        if (*s >= '0' && *s <= '9')
 4f0:	00074783          	lbu	a5,0(a4)
 4f4:	fd07869b          	addw	a3,a5,-48
 4f8:	0ff6f693          	zext.b	a3,a3
 4fc:	fed872e3          	bgeu	a6,a3,4e0 <strtol+0x74>
        else if (*s >= 'a' && *s <= 'z')
 500:	f9f7869b          	addw	a3,a5,-97
 504:	0ff6f693          	zext.b	a3,a3
 508:	00d8e563          	bltu	a7,a3,512 <strtol+0xa6>
            dig = *s - 'a' + 10;
 50c:	fa97879b          	addw	a5,a5,-87
 510:	bfd1                	j	4e4 <strtol+0x78>
        else if (*s >= 'A' && *s <= 'Z')
 512:	fbf7869b          	addw	a3,a5,-65
 516:	0ff6f693          	zext.b	a3,a3
 51a:	00d8e563          	bltu	a7,a3,524 <strtol+0xb8>
            dig = *s - 'A' + 10;
 51e:	fc97879b          	addw	a5,a5,-55
 522:	b7c9                	j	4e4 <strtol+0x78>
        // we don't properly detect overflow!
    }

    if (endptr)
 524:	c191                	beqz	a1,528 <strtol+0xbc>
        *endptr = (char *) s;
 526:	e198                	sd	a4,0(a1)
    return (neg ? -val : val);
 528:	00030463          	beqz	t1,530 <strtol+0xc4>
 52c:	40a00533          	neg	a0,a0
}
 530:	6422                	ld	s0,8(sp)
 532:	0141                	add	sp,sp,16
 534:	8082                	ret

0000000000000536 <inet_pton>:
inet_pton (int family, const char *p, void *n) {
    char *sp, *ep;
    int idx;
    long ret;

    if (family != AF_INET) {
 536:	4785                	li	a5,1
 538:	08f51063          	bne	a0,a5,5b8 <inet_pton+0x82>
inet_pton (int family, const char *p, void *n) {
 53c:	715d                	add	sp,sp,-80
 53e:	e486                	sd	ra,72(sp)
 540:	e0a2                	sd	s0,64(sp)
 542:	fc26                	sd	s1,56(sp)
 544:	f84a                	sd	s2,48(sp)
 546:	f44e                	sd	s3,40(sp)
 548:	f052                	sd	s4,32(sp)
 54a:	ec56                	sd	s5,24(sp)
 54c:	e85a                	sd	s6,16(sp)
 54e:	0880                	add	s0,sp,80
 550:	84ae                	mv	s1,a1
 552:	89b2                	mv	s3,a2
 554:	4901                	li	s2,0
        return -1;
    }
    sp = (char *)p;
    for (idx = 0; idx < 4; idx++) {
        ret = strtol(sp, &ep, 10);
        if (ret < 0 || ret > 255) {
 556:	0ff00a13          	li	s4,255
            return -1;
        }
        if (ep == sp) {
            return -1;
        }
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 55a:	4a8d                	li	s5,3
 55c:	02e00b13          	li	s6,46
 560:	a805                	j	590 <inet_pton+0x5a>
 562:	0007c783          	lbu	a5,0(a5)
 566:	efb9                	bnez	a5,5c4 <inet_pton+0x8e>
            return -1;
        }
        ((uint8_t *)n)[idx] = ret;
 568:	00a981a3          	sb	a0,3(s3)
        sp = ep + 1;
    }
    return 0;
 56c:	4501                	li	a0,0
}
 56e:	60a6                	ld	ra,72(sp)
 570:	6406                	ld	s0,64(sp)
 572:	74e2                	ld	s1,56(sp)
 574:	7942                	ld	s2,48(sp)
 576:	79a2                	ld	s3,40(sp)
 578:	7a02                	ld	s4,32(sp)
 57a:	6ae2                	ld	s5,24(sp)
 57c:	6b42                	ld	s6,16(sp)
 57e:	6161                	add	sp,sp,80
 580:	8082                	ret
        ((uint8_t *)n)[idx] = ret;
 582:	01298733          	add	a4,s3,s2
 586:	00a70023          	sb	a0,0(a4)
        sp = ep + 1;
 58a:	00178493          	add	s1,a5,1
    for (idx = 0; idx < 4; idx++) {
 58e:	0905                	add	s2,s2,1
        ret = strtol(sp, &ep, 10);
 590:	4629                	li	a2,10
 592:	fb840593          	add	a1,s0,-72
 596:	8526                	mv	a0,s1
 598:	ed5ff0ef          	jal	46c <strtol>
        if (ret < 0 || ret > 255) {
 59c:	02aa6063          	bltu	s4,a0,5bc <inet_pton+0x86>
        if (ep == sp) {
 5a0:	fb843783          	ld	a5,-72(s0)
 5a4:	00978e63          	beq	a5,s1,5c0 <inet_pton+0x8a>
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 5a8:	fb590de3          	beq	s2,s5,562 <inet_pton+0x2c>
 5ac:	0007c703          	lbu	a4,0(a5)
 5b0:	fd6709e3          	beq	a4,s6,582 <inet_pton+0x4c>
            return -1;
 5b4:	557d                	li	a0,-1
 5b6:	bf65                	j	56e <inet_pton+0x38>
        return -1;
 5b8:	557d                	li	a0,-1
}
 5ba:	8082                	ret
            return -1;
 5bc:	557d                	li	a0,-1
 5be:	bf45                	j	56e <inet_pton+0x38>
            return -1;
 5c0:	557d                	li	a0,-1
 5c2:	b775                	j	56e <inet_pton+0x38>
            return -1;
 5c4:	557d                	li	a0,-1
 5c6:	b765                	j	56e <inet_pton+0x38>

00000000000005c8 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5c8:	4885                	li	a7,1
 ecall
 5ca:	00000073          	ecall
 ret
 5ce:	8082                	ret

00000000000005d0 <exit>:
.global exit
exit:
 li a7, SYS_exit
 5d0:	4889                	li	a7,2
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <wait>:
.global wait
wait:
 li a7, SYS_wait
 5d8:	488d                	li	a7,3
 ecall
 5da:	00000073          	ecall
 ret
 5de:	8082                	ret

00000000000005e0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5e0:	4891                	li	a7,4
 ecall
 5e2:	00000073          	ecall
 ret
 5e6:	8082                	ret

00000000000005e8 <read>:
.global read
read:
 li a7, SYS_read
 5e8:	4895                	li	a7,5
 ecall
 5ea:	00000073          	ecall
 ret
 5ee:	8082                	ret

00000000000005f0 <write>:
.global write
write:
 li a7, SYS_write
 5f0:	48c1                	li	a7,16
 ecall
 5f2:	00000073          	ecall
 ret
 5f6:	8082                	ret

00000000000005f8 <close>:
.global close
close:
 li a7, SYS_close
 5f8:	48d5                	li	a7,21
 ecall
 5fa:	00000073          	ecall
 ret
 5fe:	8082                	ret

0000000000000600 <kill>:
.global kill
kill:
 li a7, SYS_kill
 600:	4899                	li	a7,6
 ecall
 602:	00000073          	ecall
 ret
 606:	8082                	ret

0000000000000608 <exec>:
.global exec
exec:
 li a7, SYS_exec
 608:	489d                	li	a7,7
 ecall
 60a:	00000073          	ecall
 ret
 60e:	8082                	ret

0000000000000610 <open>:
.global open
open:
 li a7, SYS_open
 610:	48bd                	li	a7,15
 ecall
 612:	00000073          	ecall
 ret
 616:	8082                	ret

0000000000000618 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 618:	48c5                	li	a7,17
 ecall
 61a:	00000073          	ecall
 ret
 61e:	8082                	ret

0000000000000620 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 620:	48c9                	li	a7,18
 ecall
 622:	00000073          	ecall
 ret
 626:	8082                	ret

0000000000000628 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 628:	48a1                	li	a7,8
 ecall
 62a:	00000073          	ecall
 ret
 62e:	8082                	ret

0000000000000630 <link>:
.global link
link:
 li a7, SYS_link
 630:	48cd                	li	a7,19
 ecall
 632:	00000073          	ecall
 ret
 636:	8082                	ret

0000000000000638 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 638:	48d1                	li	a7,20
 ecall
 63a:	00000073          	ecall
 ret
 63e:	8082                	ret

0000000000000640 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 640:	48a5                	li	a7,9
 ecall
 642:	00000073          	ecall
 ret
 646:	8082                	ret

0000000000000648 <dup>:
.global dup
dup:
 li a7, SYS_dup
 648:	48a9                	li	a7,10
 ecall
 64a:	00000073          	ecall
 ret
 64e:	8082                	ret

0000000000000650 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 650:	48ad                	li	a7,11
 ecall
 652:	00000073          	ecall
 ret
 656:	8082                	ret

0000000000000658 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 658:	48b1                	li	a7,12
 ecall
 65a:	00000073          	ecall
 ret
 65e:	8082                	ret

0000000000000660 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 660:	48b5                	li	a7,13
 ecall
 662:	00000073          	ecall
 ret
 666:	8082                	ret

0000000000000668 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 668:	48b9                	li	a7,14
 ecall
 66a:	00000073          	ecall
 ret
 66e:	8082                	ret

0000000000000670 <socket>:
.global socket
socket:
 li a7, SYS_socket
 670:	48d9                	li	a7,22
 ecall
 672:	00000073          	ecall
 ret
 676:	8082                	ret

0000000000000678 <bind>:
.global bind
bind:
 li a7, SYS_bind
 678:	48dd                	li	a7,23
 ecall
 67a:	00000073          	ecall
 ret
 67e:	8082                	ret

0000000000000680 <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 680:	48e1                	li	a7,24
 ecall
 682:	00000073          	ecall
 ret
 686:	8082                	ret

0000000000000688 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 688:	48e5                	li	a7,25
 ecall
 68a:	00000073          	ecall
 ret
 68e:	8082                	ret

0000000000000690 <connect>:
.global connect
connect:
 li a7, SYS_connect
 690:	48e9                	li	a7,26
 ecall
 692:	00000073          	ecall
 ret
 696:	8082                	ret

0000000000000698 <listen>:
.global listen
listen:
 li a7, SYS_listen
 698:	48ed                	li	a7,27
 ecall
 69a:	00000073          	ecall
 ret
 69e:	8082                	ret

00000000000006a0 <accept>:
.global accept
accept:
 li a7, SYS_accept
 6a0:	48f1                	li	a7,28
 ecall
 6a2:	00000073          	ecall
 ret
 6a6:	8082                	ret

00000000000006a8 <recv>:
.global recv
recv:
 li a7, SYS_recv
 6a8:	48f5                	li	a7,29
 ecall
 6aa:	00000073          	ecall
 ret
 6ae:	8082                	ret

00000000000006b0 <send>:
.global send
send:
 li a7, SYS_send
 6b0:	48f9                	li	a7,30
 ecall
 6b2:	00000073          	ecall
 ret
 6b6:	8082                	ret

00000000000006b8 <ioctl>:
.global ioctl
ioctl:
 li a7, SYS_ioctl
 6b8:	48fd                	li	a7,31
 ecall
 6ba:	00000073          	ecall
 ret
 6be:	8082                	ret

00000000000006c0 <consolemode>:
.global consolemode
consolemode:
 li a7, SYS_consolemode
 6c0:	02000893          	li	a7,32
 ecall
 6c4:	00000073          	ecall
 ret
 6c8:	8082                	ret

00000000000006ca <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 6ca:	1101                	add	sp,sp,-32
 6cc:	ec06                	sd	ra,24(sp)
 6ce:	e822                	sd	s0,16(sp)
 6d0:	1000                	add	s0,sp,32
 6d2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 6d6:	4605                	li	a2,1
 6d8:	fef40593          	add	a1,s0,-17
 6dc:	f15ff0ef          	jal	5f0 <write>
}
 6e0:	60e2                	ld	ra,24(sp)
 6e2:	6442                	ld	s0,16(sp)
 6e4:	6105                	add	sp,sp,32
 6e6:	8082                	ret

00000000000006e8 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 6e8:	715d                	add	sp,sp,-80
 6ea:	e486                	sd	ra,72(sp)
 6ec:	e0a2                	sd	s0,64(sp)
 6ee:	fc26                	sd	s1,56(sp)
 6f0:	0880                	add	s0,sp,80
 6f2:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 6f4:	c299                	beqz	a3,6fa <printint+0x12>
 6f6:	0805c963          	bltz	a1,788 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 6fa:	2581                	sext.w	a1,a1
  neg = 0;
 6fc:	4881                	li	a7,0
 6fe:	fb840693          	add	a3,s0,-72
  }

  i = 0;
 702:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 704:	2601                	sext.w	a2,a2
 706:	00000517          	auipc	a0,0x0
 70a:	54a50513          	add	a0,a0,1354 # c50 <digits>
 70e:	883a                	mv	a6,a4
 710:	2705                	addw	a4,a4,1
 712:	02c5f7bb          	remuw	a5,a1,a2
 716:	1782                	sll	a5,a5,0x20
 718:	9381                	srl	a5,a5,0x20
 71a:	97aa                	add	a5,a5,a0
 71c:	0007c783          	lbu	a5,0(a5)
 720:	00f68023          	sb	a5,0(a3) # ff0000 <base+0xfeedf0>
  }while((x /= base) != 0);
 724:	0005879b          	sext.w	a5,a1
 728:	02c5d5bb          	divuw	a1,a1,a2
 72c:	0685                	add	a3,a3,1
 72e:	fec7f0e3          	bgeu	a5,a2,70e <printint+0x26>
  if(neg)
 732:	00088c63          	beqz	a7,74a <printint+0x62>
    buf[i++] = '-';
 736:	fd070793          	add	a5,a4,-48
 73a:	00878733          	add	a4,a5,s0
 73e:	02d00793          	li	a5,45
 742:	fef70423          	sb	a5,-24(a4)
 746:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 74a:	02e05a63          	blez	a4,77e <printint+0x96>
 74e:	f84a                	sd	s2,48(sp)
 750:	f44e                	sd	s3,40(sp)
 752:	fb840793          	add	a5,s0,-72
 756:	00e78933          	add	s2,a5,a4
 75a:	fff78993          	add	s3,a5,-1
 75e:	99ba                	add	s3,s3,a4
 760:	377d                	addw	a4,a4,-1
 762:	1702                	sll	a4,a4,0x20
 764:	9301                	srl	a4,a4,0x20
 766:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 76a:	fff94583          	lbu	a1,-1(s2)
 76e:	8526                	mv	a0,s1
 770:	f5bff0ef          	jal	6ca <putc>
  while(--i >= 0)
 774:	197d                	add	s2,s2,-1
 776:	ff391ae3          	bne	s2,s3,76a <printint+0x82>
 77a:	7942                	ld	s2,48(sp)
 77c:	79a2                	ld	s3,40(sp)
}
 77e:	60a6                	ld	ra,72(sp)
 780:	6406                	ld	s0,64(sp)
 782:	74e2                	ld	s1,56(sp)
 784:	6161                	add	sp,sp,80
 786:	8082                	ret
    x = -xx;
 788:	40b005bb          	negw	a1,a1
    neg = 1;
 78c:	4885                	li	a7,1
    x = -xx;
 78e:	bf85                	j	6fe <printint+0x16>

0000000000000790 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 790:	711d                	add	sp,sp,-96
 792:	ec86                	sd	ra,88(sp)
 794:	e8a2                	sd	s0,80(sp)
 796:	e0ca                	sd	s2,64(sp)
 798:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 79a:	0005c903          	lbu	s2,0(a1)
 79e:	26090863          	beqz	s2,a0e <vprintf+0x27e>
 7a2:	e4a6                	sd	s1,72(sp)
 7a4:	fc4e                	sd	s3,56(sp)
 7a6:	f852                	sd	s4,48(sp)
 7a8:	f456                	sd	s5,40(sp)
 7aa:	f05a                	sd	s6,32(sp)
 7ac:	ec5e                	sd	s7,24(sp)
 7ae:	e862                	sd	s8,16(sp)
 7b0:	e466                	sd	s9,8(sp)
 7b2:	8b2a                	mv	s6,a0
 7b4:	8a2e                	mv	s4,a1
 7b6:	8bb2                	mv	s7,a2
  state = 0;
 7b8:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 7ba:	4481                	li	s1,0
 7bc:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 7be:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 7c2:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 7c6:	06c00c93          	li	s9,108
 7ca:	a005                	j	7ea <vprintf+0x5a>
        putc(fd, c0);
 7cc:	85ca                	mv	a1,s2
 7ce:	855a                	mv	a0,s6
 7d0:	efbff0ef          	jal	6ca <putc>
 7d4:	a019                	j	7da <vprintf+0x4a>
    } else if(state == '%'){
 7d6:	03598263          	beq	s3,s5,7fa <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 7da:	2485                	addw	s1,s1,1
 7dc:	8726                	mv	a4,s1
 7de:	009a07b3          	add	a5,s4,s1
 7e2:	0007c903          	lbu	s2,0(a5)
 7e6:	20090c63          	beqz	s2,9fe <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 7ea:	0009079b          	sext.w	a5,s2
    if(state == 0){
 7ee:	fe0994e3          	bnez	s3,7d6 <vprintf+0x46>
      if(c0 == '%'){
 7f2:	fd579de3          	bne	a5,s5,7cc <vprintf+0x3c>
        state = '%';
 7f6:	89be                	mv	s3,a5
 7f8:	b7cd                	j	7da <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 7fa:	00ea06b3          	add	a3,s4,a4
 7fe:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 802:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 804:	c681                	beqz	a3,80c <vprintf+0x7c>
 806:	9752                	add	a4,a4,s4
 808:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 80c:	03878f63          	beq	a5,s8,84a <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 810:	05978963          	beq	a5,s9,862 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 814:	07500713          	li	a4,117
 818:	0ee78363          	beq	a5,a4,8fe <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 81c:	07800713          	li	a4,120
 820:	12e78563          	beq	a5,a4,94a <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 824:	07000713          	li	a4,112
 828:	14e78a63          	beq	a5,a4,97c <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 82c:	07300713          	li	a4,115
 830:	18e78a63          	beq	a5,a4,9c4 <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 834:	02500713          	li	a4,37
 838:	04e79563          	bne	a5,a4,882 <vprintf+0xf2>
        putc(fd, '%');
 83c:	02500593          	li	a1,37
 840:	855a                	mv	a0,s6
 842:	e89ff0ef          	jal	6ca <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 846:	4981                	li	s3,0
 848:	bf49                	j	7da <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 84a:	008b8913          	add	s2,s7,8
 84e:	4685                	li	a3,1
 850:	4629                	li	a2,10
 852:	000ba583          	lw	a1,0(s7)
 856:	855a                	mv	a0,s6
 858:	e91ff0ef          	jal	6e8 <printint>
 85c:	8bca                	mv	s7,s2
      state = 0;
 85e:	4981                	li	s3,0
 860:	bfad                	j	7da <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 862:	06400793          	li	a5,100
 866:	02f68963          	beq	a3,a5,898 <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 86a:	06c00793          	li	a5,108
 86e:	04f68263          	beq	a3,a5,8b2 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 872:	07500793          	li	a5,117
 876:	0af68063          	beq	a3,a5,916 <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 87a:	07800793          	li	a5,120
 87e:	0ef68263          	beq	a3,a5,962 <vprintf+0x1d2>
        putc(fd, '%');
 882:	02500593          	li	a1,37
 886:	855a                	mv	a0,s6
 888:	e43ff0ef          	jal	6ca <putc>
        putc(fd, c0);
 88c:	85ca                	mv	a1,s2
 88e:	855a                	mv	a0,s6
 890:	e3bff0ef          	jal	6ca <putc>
      state = 0;
 894:	4981                	li	s3,0
 896:	b791                	j	7da <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 898:	008b8913          	add	s2,s7,8
 89c:	4685                	li	a3,1
 89e:	4629                	li	a2,10
 8a0:	000bb583          	ld	a1,0(s7)
 8a4:	855a                	mv	a0,s6
 8a6:	e43ff0ef          	jal	6e8 <printint>
        i += 1;
 8aa:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 8ac:	8bca                	mv	s7,s2
      state = 0;
 8ae:	4981                	li	s3,0
        i += 1;
 8b0:	b72d                	j	7da <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 8b2:	06400793          	li	a5,100
 8b6:	02f60763          	beq	a2,a5,8e4 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 8ba:	07500793          	li	a5,117
 8be:	06f60963          	beq	a2,a5,930 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 8c2:	07800793          	li	a5,120
 8c6:	faf61ee3          	bne	a2,a5,882 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 8ca:	008b8913          	add	s2,s7,8
 8ce:	4681                	li	a3,0
 8d0:	4641                	li	a2,16
 8d2:	000bb583          	ld	a1,0(s7)
 8d6:	855a                	mv	a0,s6
 8d8:	e11ff0ef          	jal	6e8 <printint>
        i += 2;
 8dc:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 8de:	8bca                	mv	s7,s2
      state = 0;
 8e0:	4981                	li	s3,0
        i += 2;
 8e2:	bde5                	j	7da <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 8e4:	008b8913          	add	s2,s7,8
 8e8:	4685                	li	a3,1
 8ea:	4629                	li	a2,10
 8ec:	000bb583          	ld	a1,0(s7)
 8f0:	855a                	mv	a0,s6
 8f2:	df7ff0ef          	jal	6e8 <printint>
        i += 2;
 8f6:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 8f8:	8bca                	mv	s7,s2
      state = 0;
 8fa:	4981                	li	s3,0
        i += 2;
 8fc:	bdf9                	j	7da <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 8fe:	008b8913          	add	s2,s7,8
 902:	4681                	li	a3,0
 904:	4629                	li	a2,10
 906:	000ba583          	lw	a1,0(s7)
 90a:	855a                	mv	a0,s6
 90c:	dddff0ef          	jal	6e8 <printint>
 910:	8bca                	mv	s7,s2
      state = 0;
 912:	4981                	li	s3,0
 914:	b5d9                	j	7da <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 916:	008b8913          	add	s2,s7,8
 91a:	4681                	li	a3,0
 91c:	4629                	li	a2,10
 91e:	000bb583          	ld	a1,0(s7)
 922:	855a                	mv	a0,s6
 924:	dc5ff0ef          	jal	6e8 <printint>
        i += 1;
 928:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 92a:	8bca                	mv	s7,s2
      state = 0;
 92c:	4981                	li	s3,0
        i += 1;
 92e:	b575                	j	7da <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 930:	008b8913          	add	s2,s7,8
 934:	4681                	li	a3,0
 936:	4629                	li	a2,10
 938:	000bb583          	ld	a1,0(s7)
 93c:	855a                	mv	a0,s6
 93e:	dabff0ef          	jal	6e8 <printint>
        i += 2;
 942:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 944:	8bca                	mv	s7,s2
      state = 0;
 946:	4981                	li	s3,0
        i += 2;
 948:	bd49                	j	7da <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 94a:	008b8913          	add	s2,s7,8
 94e:	4681                	li	a3,0
 950:	4641                	li	a2,16
 952:	000ba583          	lw	a1,0(s7)
 956:	855a                	mv	a0,s6
 958:	d91ff0ef          	jal	6e8 <printint>
 95c:	8bca                	mv	s7,s2
      state = 0;
 95e:	4981                	li	s3,0
 960:	bdad                	j	7da <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 962:	008b8913          	add	s2,s7,8
 966:	4681                	li	a3,0
 968:	4641                	li	a2,16
 96a:	000bb583          	ld	a1,0(s7)
 96e:	855a                	mv	a0,s6
 970:	d79ff0ef          	jal	6e8 <printint>
        i += 1;
 974:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 976:	8bca                	mv	s7,s2
      state = 0;
 978:	4981                	li	s3,0
        i += 1;
 97a:	b585                	j	7da <vprintf+0x4a>
 97c:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 97e:	008b8d13          	add	s10,s7,8
 982:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 986:	03000593          	li	a1,48
 98a:	855a                	mv	a0,s6
 98c:	d3fff0ef          	jal	6ca <putc>
  putc(fd, 'x');
 990:	07800593          	li	a1,120
 994:	855a                	mv	a0,s6
 996:	d35ff0ef          	jal	6ca <putc>
 99a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 99c:	00000b97          	auipc	s7,0x0
 9a0:	2b4b8b93          	add	s7,s7,692 # c50 <digits>
 9a4:	03c9d793          	srl	a5,s3,0x3c
 9a8:	97de                	add	a5,a5,s7
 9aa:	0007c583          	lbu	a1,0(a5)
 9ae:	855a                	mv	a0,s6
 9b0:	d1bff0ef          	jal	6ca <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 9b4:	0992                	sll	s3,s3,0x4
 9b6:	397d                	addw	s2,s2,-1
 9b8:	fe0916e3          	bnez	s2,9a4 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 9bc:	8bea                	mv	s7,s10
      state = 0;
 9be:	4981                	li	s3,0
 9c0:	6d02                	ld	s10,0(sp)
 9c2:	bd21                	j	7da <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 9c4:	008b8993          	add	s3,s7,8
 9c8:	000bb903          	ld	s2,0(s7)
 9cc:	00090f63          	beqz	s2,9ea <vprintf+0x25a>
        for(; *s; s++)
 9d0:	00094583          	lbu	a1,0(s2)
 9d4:	c195                	beqz	a1,9f8 <vprintf+0x268>
          putc(fd, *s);
 9d6:	855a                	mv	a0,s6
 9d8:	cf3ff0ef          	jal	6ca <putc>
        for(; *s; s++)
 9dc:	0905                	add	s2,s2,1
 9de:	00094583          	lbu	a1,0(s2)
 9e2:	f9f5                	bnez	a1,9d6 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 9e4:	8bce                	mv	s7,s3
      state = 0;
 9e6:	4981                	li	s3,0
 9e8:	bbcd                	j	7da <vprintf+0x4a>
          s = "(null)";
 9ea:	00000917          	auipc	s2,0x0
 9ee:	25e90913          	add	s2,s2,606 # c48 <malloc+0x14a>
        for(; *s; s++)
 9f2:	02800593          	li	a1,40
 9f6:	b7c5                	j	9d6 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 9f8:	8bce                	mv	s7,s3
      state = 0;
 9fa:	4981                	li	s3,0
 9fc:	bbf9                	j	7da <vprintf+0x4a>
 9fe:	64a6                	ld	s1,72(sp)
 a00:	79e2                	ld	s3,56(sp)
 a02:	7a42                	ld	s4,48(sp)
 a04:	7aa2                	ld	s5,40(sp)
 a06:	7b02                	ld	s6,32(sp)
 a08:	6be2                	ld	s7,24(sp)
 a0a:	6c42                	ld	s8,16(sp)
 a0c:	6ca2                	ld	s9,8(sp)
    }
  }
}
 a0e:	60e6                	ld	ra,88(sp)
 a10:	6446                	ld	s0,80(sp)
 a12:	6906                	ld	s2,64(sp)
 a14:	6125                	add	sp,sp,96
 a16:	8082                	ret

0000000000000a18 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a18:	715d                	add	sp,sp,-80
 a1a:	ec06                	sd	ra,24(sp)
 a1c:	e822                	sd	s0,16(sp)
 a1e:	1000                	add	s0,sp,32
 a20:	e010                	sd	a2,0(s0)
 a22:	e414                	sd	a3,8(s0)
 a24:	e818                	sd	a4,16(s0)
 a26:	ec1c                	sd	a5,24(s0)
 a28:	03043023          	sd	a6,32(s0)
 a2c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a30:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a34:	8622                	mv	a2,s0
 a36:	d5bff0ef          	jal	790 <vprintf>
}
 a3a:	60e2                	ld	ra,24(sp)
 a3c:	6442                	ld	s0,16(sp)
 a3e:	6161                	add	sp,sp,80
 a40:	8082                	ret

0000000000000a42 <printf>:

void
printf(const char *fmt, ...)
{
 a42:	711d                	add	sp,sp,-96
 a44:	ec06                	sd	ra,24(sp)
 a46:	e822                	sd	s0,16(sp)
 a48:	1000                	add	s0,sp,32
 a4a:	e40c                	sd	a1,8(s0)
 a4c:	e810                	sd	a2,16(s0)
 a4e:	ec14                	sd	a3,24(s0)
 a50:	f018                	sd	a4,32(s0)
 a52:	f41c                	sd	a5,40(s0)
 a54:	03043823          	sd	a6,48(s0)
 a58:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a5c:	00840613          	add	a2,s0,8
 a60:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a64:	85aa                	mv	a1,a0
 a66:	4505                	li	a0,1
 a68:	d29ff0ef          	jal	790 <vprintf>
}
 a6c:	60e2                	ld	ra,24(sp)
 a6e:	6442                	ld	s0,16(sp)
 a70:	6125                	add	sp,sp,96
 a72:	8082                	ret

0000000000000a74 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a74:	1141                	add	sp,sp,-16
 a76:	e422                	sd	s0,8(sp)
 a78:	0800                	add	s0,sp,16
  Header *bp, *p;

  if(ap == 0)
 a7a:	cd3d                	beqz	a0,af8 <free+0x84>
    return;
  if((uint64)ap < 4096)
 a7c:	6785                	lui	a5,0x1
 a7e:	06f56d63          	bltu	a0,a5,af8 <free+0x84>
    return;
  bp = (Header*)ap - 1;
 a82:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a86:	00000797          	auipc	a5,0x0
 a8a:	5827b783          	ld	a5,1410(a5) # 1008 <freep>
 a8e:	a02d                	j	ab8 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a90:	4618                	lw	a4,8(a2)
 a92:	9f2d                	addw	a4,a4,a1
 a94:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a98:	6398                	ld	a4,0(a5)
 a9a:	6310                	ld	a2,0(a4)
 a9c:	a83d                	j	ada <free+0x66>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a9e:	ff852703          	lw	a4,-8(a0)
 aa2:	9f31                	addw	a4,a4,a2
 aa4:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 aa6:	ff053683          	ld	a3,-16(a0)
 aaa:	a091                	j	aee <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 aac:	6398                	ld	a4,0(a5)
 aae:	00e7e463          	bltu	a5,a4,ab6 <free+0x42>
 ab2:	00e6ea63          	bltu	a3,a4,ac6 <free+0x52>
{
 ab6:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ab8:	fed7fae3          	bgeu	a5,a3,aac <free+0x38>
 abc:	6398                	ld	a4,0(a5)
 abe:	00e6e463          	bltu	a3,a4,ac6 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ac2:	fee7eae3          	bltu	a5,a4,ab6 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 ac6:	ff852583          	lw	a1,-8(a0)
 aca:	6390                	ld	a2,0(a5)
 acc:	02059813          	sll	a6,a1,0x20
 ad0:	01c85713          	srl	a4,a6,0x1c
 ad4:	9736                	add	a4,a4,a3
 ad6:	fae60de3          	beq	a2,a4,a90 <free+0x1c>
    bp->s.ptr = p->s.ptr->s.ptr;
 ada:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 ade:	4790                	lw	a2,8(a5)
 ae0:	02061593          	sll	a1,a2,0x20
 ae4:	01c5d713          	srl	a4,a1,0x1c
 ae8:	973e                	add	a4,a4,a5
 aea:	fae68ae3          	beq	a3,a4,a9e <free+0x2a>
    p->s.ptr = bp->s.ptr;
 aee:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 af0:	00000717          	auipc	a4,0x0
 af4:	50f73c23          	sd	a5,1304(a4) # 1008 <freep>
}
 af8:	6422                	ld	s0,8(sp)
 afa:	0141                	add	sp,sp,16
 afc:	8082                	ret

0000000000000afe <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 afe:	7139                	add	sp,sp,-64
 b00:	fc06                	sd	ra,56(sp)
 b02:	f822                	sd	s0,48(sp)
 b04:	f426                	sd	s1,40(sp)
 b06:	ec4e                	sd	s3,24(sp)
 b08:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b0a:	02051493          	sll	s1,a0,0x20
 b0e:	9081                	srl	s1,s1,0x20
 b10:	04bd                	add	s1,s1,15
 b12:	8091                	srl	s1,s1,0x4
 b14:	0014899b          	addw	s3,s1,1
 b18:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 b1a:	00000517          	auipc	a0,0x0
 b1e:	4ee53503          	ld	a0,1262(a0) # 1008 <freep>
 b22:	c915                	beqz	a0,b56 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b24:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b26:	4798                	lw	a4,8(a5)
 b28:	08977a63          	bgeu	a4,s1,bbc <malloc+0xbe>
 b2c:	f04a                	sd	s2,32(sp)
 b2e:	e852                	sd	s4,16(sp)
 b30:	e456                	sd	s5,8(sp)
 b32:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 b34:	8a4e                	mv	s4,s3
 b36:	0009871b          	sext.w	a4,s3
 b3a:	6685                	lui	a3,0x1
 b3c:	00d77363          	bgeu	a4,a3,b42 <malloc+0x44>
 b40:	6a05                	lui	s4,0x1
 b42:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 b46:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b4a:	00000917          	auipc	s2,0x0
 b4e:	4be90913          	add	s2,s2,1214 # 1008 <freep>
  if(p == (char*)-1)
 b52:	5afd                	li	s5,-1
 b54:	a081                	j	b94 <malloc+0x96>
 b56:	f04a                	sd	s2,32(sp)
 b58:	e852                	sd	s4,16(sp)
 b5a:	e456                	sd	s5,8(sp)
 b5c:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 b5e:	00000797          	auipc	a5,0x0
 b62:	6b278793          	add	a5,a5,1714 # 1210 <base>
 b66:	00000717          	auipc	a4,0x0
 b6a:	4af73123          	sd	a5,1186(a4) # 1008 <freep>
 b6e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 b70:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 b74:	b7c1                	j	b34 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 b76:	6398                	ld	a4,0(a5)
 b78:	e118                	sd	a4,0(a0)
 b7a:	a8a9                	j	bd4 <malloc+0xd6>
  hp->s.size = nu;
 b7c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 b80:	0541                	add	a0,a0,16
 b82:	ef3ff0ef          	jal	a74 <free>
  return freep;
 b86:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 b8a:	c12d                	beqz	a0,bec <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b8c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b8e:	4798                	lw	a4,8(a5)
 b90:	02977263          	bgeu	a4,s1,bb4 <malloc+0xb6>
    if(p == freep)
 b94:	00093703          	ld	a4,0(s2)
 b98:	853e                	mv	a0,a5
 b9a:	fef719e3          	bne	a4,a5,b8c <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 b9e:	8552                	mv	a0,s4
 ba0:	ab9ff0ef          	jal	658 <sbrk>
  if(p == (char*)-1)
 ba4:	fd551ce3          	bne	a0,s5,b7c <malloc+0x7e>
        return 0;
 ba8:	4501                	li	a0,0
 baa:	7902                	ld	s2,32(sp)
 bac:	6a42                	ld	s4,16(sp)
 bae:	6aa2                	ld	s5,8(sp)
 bb0:	6b02                	ld	s6,0(sp)
 bb2:	a03d                	j	be0 <malloc+0xe2>
 bb4:	7902                	ld	s2,32(sp)
 bb6:	6a42                	ld	s4,16(sp)
 bb8:	6aa2                	ld	s5,8(sp)
 bba:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 bbc:	fae48de3          	beq	s1,a4,b76 <malloc+0x78>
        p->s.size -= nunits;
 bc0:	4137073b          	subw	a4,a4,s3
 bc4:	c798                	sw	a4,8(a5)
        p += p->s.size;
 bc6:	02071693          	sll	a3,a4,0x20
 bca:	01c6d713          	srl	a4,a3,0x1c
 bce:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 bd0:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 bd4:	00000717          	auipc	a4,0x0
 bd8:	42a73a23          	sd	a0,1076(a4) # 1008 <freep>
      return (void*)(p + 1);
 bdc:	01078513          	add	a0,a5,16
  }
}
 be0:	70e2                	ld	ra,56(sp)
 be2:	7442                	ld	s0,48(sp)
 be4:	74a2                	ld	s1,40(sp)
 be6:	69e2                	ld	s3,24(sp)
 be8:	6121                	add	sp,sp,64
 bea:	8082                	ret
 bec:	7902                	ld	s2,32(sp)
 bee:	6a42                	ld	s4,16(sp)
 bf0:	6aa2                	ld	s5,8(sp)
 bf2:	6b02                	ld	s6,0(sp)
 bf4:	b7f5                	j	be0 <malloc+0xe2>
