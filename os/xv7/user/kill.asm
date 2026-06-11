
user/_kill:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char **argv)
{
   0:	1101                	add	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	add	s0,sp,32
  int i;

  if(argc < 2){
   8:	4785                	li	a5,1
   a:	02a7d963          	bge	a5,a0,3c <main+0x3c>
   e:	e426                	sd	s1,8(sp)
  10:	e04a                	sd	s2,0(sp)
  12:	00858493          	add	s1,a1,8
  16:	ffe5091b          	addw	s2,a0,-2
  1a:	02091793          	sll	a5,s2,0x20
  1e:	01d7d913          	srl	s2,a5,0x1d
  22:	05c1                	add	a1,a1,16
  24:	992e                	add	s2,s2,a1
    fprintf(2, "usage: kill pid...\n");
    exit(1);
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  26:	6088                	ld	a0,0(s1)
  28:	1a0000ef          	jal	1c8 <atoi>
  2c:	53e000ef          	jal	56a <kill>
  for(i=1; i<argc; i++)
  30:	04a1                	add	s1,s1,8
  32:	ff249ae3          	bne	s1,s2,26 <main+0x26>
  exit(0);
  36:	4501                	li	a0,0
  38:	502000ef          	jal	53a <exit>
  3c:	e426                	sd	s1,8(sp)
  3e:	e04a                	sd	s2,0(sp)
    fprintf(2, "usage: kill pid...\n");
  40:	00001597          	auipc	a1,0x1
  44:	b2058593          	add	a1,a1,-1248 # b60 <malloc+0xf8>
  48:	4509                	li	a0,2
  4a:	139000ef          	jal	982 <fprintf>
    exit(1);
  4e:	4505                	li	a0,1
  50:	4ea000ef          	jal	53a <exit>

0000000000000054 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  54:	1141                	add	sp,sp,-16
  56:	e406                	sd	ra,8(sp)
  58:	e022                	sd	s0,0(sp)
  5a:	0800                	add	s0,sp,16
  extern int main();
  main();
  5c:	fa5ff0ef          	jal	0 <main>
  exit(0);
  60:	4501                	li	a0,0
  62:	4d8000ef          	jal	53a <exit>

0000000000000066 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  66:	1141                	add	sp,sp,-16
  68:	e422                	sd	s0,8(sp)
  6a:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  6c:	87aa                	mv	a5,a0
  6e:	0585                	add	a1,a1,1
  70:	0785                	add	a5,a5,1
  72:	fff5c703          	lbu	a4,-1(a1)
  76:	fee78fa3          	sb	a4,-1(a5)
  7a:	fb75                	bnez	a4,6e <strcpy+0x8>
    ;
  return os;
}
  7c:	6422                	ld	s0,8(sp)
  7e:	0141                	add	sp,sp,16
  80:	8082                	ret

0000000000000082 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  82:	1141                	add	sp,sp,-16
  84:	e422                	sd	s0,8(sp)
  86:	0800                	add	s0,sp,16
  while(*p && *p == *q)
  88:	00054783          	lbu	a5,0(a0)
  8c:	cb91                	beqz	a5,a0 <strcmp+0x1e>
  8e:	0005c703          	lbu	a4,0(a1)
  92:	00f71763          	bne	a4,a5,a0 <strcmp+0x1e>
    p++, q++;
  96:	0505                	add	a0,a0,1
  98:	0585                	add	a1,a1,1
  while(*p && *p == *q)
  9a:	00054783          	lbu	a5,0(a0)
  9e:	fbe5                	bnez	a5,8e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  a0:	0005c503          	lbu	a0,0(a1)
}
  a4:	40a7853b          	subw	a0,a5,a0
  a8:	6422                	ld	s0,8(sp)
  aa:	0141                	add	sp,sp,16
  ac:	8082                	ret

00000000000000ae <strlen>:

uint
strlen(const char *s)
{
  ae:	1141                	add	sp,sp,-16
  b0:	e422                	sd	s0,8(sp)
  b2:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  b4:	00054783          	lbu	a5,0(a0)
  b8:	cf91                	beqz	a5,d4 <strlen+0x26>
  ba:	0505                	add	a0,a0,1
  bc:	87aa                	mv	a5,a0
  be:	86be                	mv	a3,a5
  c0:	0785                	add	a5,a5,1
  c2:	fff7c703          	lbu	a4,-1(a5)
  c6:	ff65                	bnez	a4,be <strlen+0x10>
  c8:	40a6853b          	subw	a0,a3,a0
  cc:	2505                	addw	a0,a0,1
    ;
  return n;
}
  ce:	6422                	ld	s0,8(sp)
  d0:	0141                	add	sp,sp,16
  d2:	8082                	ret
  for(n = 0; s[n]; n++)
  d4:	4501                	li	a0,0
  d6:	bfe5                	j	ce <strlen+0x20>

00000000000000d8 <memset>:

void*
memset(void *dst, int c, uint n)
{
  d8:	1141                	add	sp,sp,-16
  da:	e422                	sd	s0,8(sp)
  dc:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  de:	ca19                	beqz	a2,f4 <memset+0x1c>
  e0:	87aa                	mv	a5,a0
  e2:	1602                	sll	a2,a2,0x20
  e4:	9201                	srl	a2,a2,0x20
  e6:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  ea:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  ee:	0785                	add	a5,a5,1
  f0:	fee79de3          	bne	a5,a4,ea <memset+0x12>
  }
  return dst;
}
  f4:	6422                	ld	s0,8(sp)
  f6:	0141                	add	sp,sp,16
  f8:	8082                	ret

00000000000000fa <strchr>:

char*
strchr(const char *s, char c)
{
  fa:	1141                	add	sp,sp,-16
  fc:	e422                	sd	s0,8(sp)
  fe:	0800                	add	s0,sp,16
  for(; *s; s++)
 100:	00054783          	lbu	a5,0(a0)
 104:	cb99                	beqz	a5,11a <strchr+0x20>
    if(*s == c)
 106:	00f58763          	beq	a1,a5,114 <strchr+0x1a>
  for(; *s; s++)
 10a:	0505                	add	a0,a0,1
 10c:	00054783          	lbu	a5,0(a0)
 110:	fbfd                	bnez	a5,106 <strchr+0xc>
      return (char*)s;
  return 0;
 112:	4501                	li	a0,0
}
 114:	6422                	ld	s0,8(sp)
 116:	0141                	add	sp,sp,16
 118:	8082                	ret
  return 0;
 11a:	4501                	li	a0,0
 11c:	bfe5                	j	114 <strchr+0x1a>

000000000000011e <gets>:

char*
gets(char *buf, int max)
{
 11e:	711d                	add	sp,sp,-96
 120:	ec86                	sd	ra,88(sp)
 122:	e8a2                	sd	s0,80(sp)
 124:	e4a6                	sd	s1,72(sp)
 126:	e0ca                	sd	s2,64(sp)
 128:	fc4e                	sd	s3,56(sp)
 12a:	f852                	sd	s4,48(sp)
 12c:	f456                	sd	s5,40(sp)
 12e:	f05a                	sd	s6,32(sp)
 130:	ec5e                	sd	s7,24(sp)
 132:	1080                	add	s0,sp,96
 134:	8baa                	mv	s7,a0
 136:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 138:	892a                	mv	s2,a0
 13a:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 13c:	4aa9                	li	s5,10
 13e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 140:	89a6                	mv	s3,s1
 142:	2485                	addw	s1,s1,1
 144:	0344d663          	bge	s1,s4,170 <gets+0x52>
    cc = read(0, &c, 1);
 148:	4605                	li	a2,1
 14a:	faf40593          	add	a1,s0,-81
 14e:	4501                	li	a0,0
 150:	402000ef          	jal	552 <read>
    if(cc < 1)
 154:	00a05e63          	blez	a0,170 <gets+0x52>
    buf[i++] = c;
 158:	faf44783          	lbu	a5,-81(s0)
 15c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 160:	01578763          	beq	a5,s5,16e <gets+0x50>
 164:	0905                	add	s2,s2,1
 166:	fd679de3          	bne	a5,s6,140 <gets+0x22>
    buf[i++] = c;
 16a:	89a6                	mv	s3,s1
 16c:	a011                	j	170 <gets+0x52>
 16e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 170:	99de                	add	s3,s3,s7
 172:	00098023          	sb	zero,0(s3)
  return buf;
}
 176:	855e                	mv	a0,s7
 178:	60e6                	ld	ra,88(sp)
 17a:	6446                	ld	s0,80(sp)
 17c:	64a6                	ld	s1,72(sp)
 17e:	6906                	ld	s2,64(sp)
 180:	79e2                	ld	s3,56(sp)
 182:	7a42                	ld	s4,48(sp)
 184:	7aa2                	ld	s5,40(sp)
 186:	7b02                	ld	s6,32(sp)
 188:	6be2                	ld	s7,24(sp)
 18a:	6125                	add	sp,sp,96
 18c:	8082                	ret

000000000000018e <stat>:

int
stat(const char *n, struct stat *st)
{
 18e:	1101                	add	sp,sp,-32
 190:	ec06                	sd	ra,24(sp)
 192:	e822                	sd	s0,16(sp)
 194:	e04a                	sd	s2,0(sp)
 196:	1000                	add	s0,sp,32
 198:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 19a:	4581                	li	a1,0
 19c:	3de000ef          	jal	57a <open>
  if(fd < 0)
 1a0:	02054263          	bltz	a0,1c4 <stat+0x36>
 1a4:	e426                	sd	s1,8(sp)
 1a6:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1a8:	85ca                	mv	a1,s2
 1aa:	3e8000ef          	jal	592 <fstat>
 1ae:	892a                	mv	s2,a0
  close(fd);
 1b0:	8526                	mv	a0,s1
 1b2:	3b0000ef          	jal	562 <close>
  return r;
 1b6:	64a2                	ld	s1,8(sp)
}
 1b8:	854a                	mv	a0,s2
 1ba:	60e2                	ld	ra,24(sp)
 1bc:	6442                	ld	s0,16(sp)
 1be:	6902                	ld	s2,0(sp)
 1c0:	6105                	add	sp,sp,32
 1c2:	8082                	ret
    return -1;
 1c4:	597d                	li	s2,-1
 1c6:	bfcd                	j	1b8 <stat+0x2a>

00000000000001c8 <atoi>:

int
atoi(const char *s)
{
 1c8:	1141                	add	sp,sp,-16
 1ca:	e422                	sd	s0,8(sp)
 1cc:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1ce:	00054683          	lbu	a3,0(a0)
 1d2:	fd06879b          	addw	a5,a3,-48
 1d6:	0ff7f793          	zext.b	a5,a5
 1da:	4625                	li	a2,9
 1dc:	02f66863          	bltu	a2,a5,20c <atoi+0x44>
 1e0:	872a                	mv	a4,a0
  n = 0;
 1e2:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 1e4:	0705                	add	a4,a4,1
 1e6:	0025179b          	sllw	a5,a0,0x2
 1ea:	9fa9                	addw	a5,a5,a0
 1ec:	0017979b          	sllw	a5,a5,0x1
 1f0:	9fb5                	addw	a5,a5,a3
 1f2:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1f6:	00074683          	lbu	a3,0(a4)
 1fa:	fd06879b          	addw	a5,a3,-48
 1fe:	0ff7f793          	zext.b	a5,a5
 202:	fef671e3          	bgeu	a2,a5,1e4 <atoi+0x1c>
  return n;
}
 206:	6422                	ld	s0,8(sp)
 208:	0141                	add	sp,sp,16
 20a:	8082                	ret
  n = 0;
 20c:	4501                	li	a0,0
 20e:	bfe5                	j	206 <atoi+0x3e>

0000000000000210 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 210:	1141                	add	sp,sp,-16
 212:	e422                	sd	s0,8(sp)
 214:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 216:	02b57463          	bgeu	a0,a1,23e <memmove+0x2e>
    while(n-- > 0)
 21a:	00c05f63          	blez	a2,238 <memmove+0x28>
 21e:	1602                	sll	a2,a2,0x20
 220:	9201                	srl	a2,a2,0x20
 222:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 226:	872a                	mv	a4,a0
      *dst++ = *src++;
 228:	0585                	add	a1,a1,1
 22a:	0705                	add	a4,a4,1
 22c:	fff5c683          	lbu	a3,-1(a1)
 230:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 234:	fef71ae3          	bne	a4,a5,228 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 238:	6422                	ld	s0,8(sp)
 23a:	0141                	add	sp,sp,16
 23c:	8082                	ret
    dst += n;
 23e:	00c50733          	add	a4,a0,a2
    src += n;
 242:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 244:	fec05ae3          	blez	a2,238 <memmove+0x28>
 248:	fff6079b          	addw	a5,a2,-1
 24c:	1782                	sll	a5,a5,0x20
 24e:	9381                	srl	a5,a5,0x20
 250:	fff7c793          	not	a5,a5
 254:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 256:	15fd                	add	a1,a1,-1
 258:	177d                	add	a4,a4,-1
 25a:	0005c683          	lbu	a3,0(a1)
 25e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 262:	fee79ae3          	bne	a5,a4,256 <memmove+0x46>
 266:	bfc9                	j	238 <memmove+0x28>

0000000000000268 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 268:	1141                	add	sp,sp,-16
 26a:	e422                	sd	s0,8(sp)
 26c:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 26e:	ca05                	beqz	a2,29e <memcmp+0x36>
 270:	fff6069b          	addw	a3,a2,-1
 274:	1682                	sll	a3,a3,0x20
 276:	9281                	srl	a3,a3,0x20
 278:	0685                	add	a3,a3,1
 27a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 27c:	00054783          	lbu	a5,0(a0)
 280:	0005c703          	lbu	a4,0(a1)
 284:	00e79863          	bne	a5,a4,294 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 288:	0505                	add	a0,a0,1
    p2++;
 28a:	0585                	add	a1,a1,1
  while (n-- > 0) {
 28c:	fed518e3          	bne	a0,a3,27c <memcmp+0x14>
  }
  return 0;
 290:	4501                	li	a0,0
 292:	a019                	j	298 <memcmp+0x30>
      return *p1 - *p2;
 294:	40e7853b          	subw	a0,a5,a4
}
 298:	6422                	ld	s0,8(sp)
 29a:	0141                	add	sp,sp,16
 29c:	8082                	ret
  return 0;
 29e:	4501                	li	a0,0
 2a0:	bfe5                	j	298 <memcmp+0x30>

00000000000002a2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2a2:	1141                	add	sp,sp,-16
 2a4:	e406                	sd	ra,8(sp)
 2a6:	e022                	sd	s0,0(sp)
 2a8:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 2aa:	f67ff0ef          	jal	210 <memmove>
}
 2ae:	60a2                	ld	ra,8(sp)
 2b0:	6402                	ld	s0,0(sp)
 2b2:	0141                	add	sp,sp,16
 2b4:	8082                	ret

00000000000002b6 <htons>:
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
}

uint16_t
htons(uint16_t h)
{
 2b6:	1141                	add	sp,sp,-16
 2b8:	e422                	sd	s0,8(sp)
 2ba:	0800                	add	s0,sp,16
    if (!endian) {
 2bc:	00001797          	auipc	a5,0x1
 2c0:	d447a783          	lw	a5,-700(a5) # 1000 <endian>
 2c4:	e385                	bnez	a5,2e4 <htons+0x2e>
        endian = byteorder();
 2c6:	4d200793          	li	a5,1234
 2ca:	00001717          	auipc	a4,0x1
 2ce:	d2f72b23          	sw	a5,-714(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 2d2:	0085179b          	sllw	a5,a0,0x8
 2d6:	0085551b          	srlw	a0,a0,0x8
 2da:	8fc9                	or	a5,a5,a0
 2dc:	03079513          	sll	a0,a5,0x30
 2e0:	9141                	srl	a0,a0,0x30
 2e2:	a029                	j	2ec <htons+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(h) : h;
 2e4:	4d200713          	li	a4,1234
 2e8:	fee785e3          	beq	a5,a4,2d2 <htons+0x1c>
}
 2ec:	6422                	ld	s0,8(sp)
 2ee:	0141                	add	sp,sp,16
 2f0:	8082                	ret

00000000000002f2 <ntohs>:

uint16_t
ntohs(uint16_t n)
{
 2f2:	1141                	add	sp,sp,-16
 2f4:	e422                	sd	s0,8(sp)
 2f6:	0800                	add	s0,sp,16
    if (!endian) {
 2f8:	00001797          	auipc	a5,0x1
 2fc:	d087a783          	lw	a5,-760(a5) # 1000 <endian>
 300:	e385                	bnez	a5,320 <ntohs+0x2e>
        endian = byteorder();
 302:	4d200793          	li	a5,1234
 306:	00001717          	auipc	a4,0x1
 30a:	cef72d23          	sw	a5,-774(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 30e:	0085179b          	sllw	a5,a0,0x8
 312:	0085551b          	srlw	a0,a0,0x8
 316:	8fc9                	or	a5,a5,a0
 318:	03079513          	sll	a0,a5,0x30
 31c:	9141                	srl	a0,a0,0x30
 31e:	a029                	j	328 <ntohs+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(n) : n;
 320:	4d200713          	li	a4,1234
 324:	fee785e3          	beq	a5,a4,30e <ntohs+0x1c>
}
 328:	6422                	ld	s0,8(sp)
 32a:	0141                	add	sp,sp,16
 32c:	8082                	ret

000000000000032e <htonl>:

uint32_t
htonl(uint32_t h)
{
 32e:	1141                	add	sp,sp,-16
 330:	e422                	sd	s0,8(sp)
 332:	0800                	add	s0,sp,16
    if (!endian) {
 334:	00001797          	auipc	a5,0x1
 338:	ccc7a783          	lw	a5,-820(a5) # 1000 <endian>
 33c:	ef85                	bnez	a5,374 <htonl+0x46>
        endian = byteorder();
 33e:	4d200793          	li	a5,1234
 342:	00001717          	auipc	a4,0x1
 346:	caf72f23          	sw	a5,-834(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 34a:	0185179b          	sllw	a5,a0,0x18
 34e:	0185571b          	srlw	a4,a0,0x18
 352:	8fd9                	or	a5,a5,a4
 354:	0085171b          	sllw	a4,a0,0x8
 358:	00ff06b7          	lui	a3,0xff0
 35c:	8f75                	and	a4,a4,a3
 35e:	8fd9                	or	a5,a5,a4
 360:	0085551b          	srlw	a0,a0,0x8
 364:	6741                	lui	a4,0x10
 366:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeef0>
 36a:	8d79                	and	a0,a0,a4
 36c:	8fc9                	or	a5,a5,a0
 36e:	0007851b          	sext.w	a0,a5
 372:	a029                	j	37c <htonl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(h) : h;
 374:	4d200713          	li	a4,1234
 378:	fce789e3          	beq	a5,a4,34a <htonl+0x1c>
}
 37c:	6422                	ld	s0,8(sp)
 37e:	0141                	add	sp,sp,16
 380:	8082                	ret

0000000000000382 <ntohl>:

uint32_t
ntohl(uint32_t n)
{
 382:	1141                	add	sp,sp,-16
 384:	e422                	sd	s0,8(sp)
 386:	0800                	add	s0,sp,16
    if (!endian) {
 388:	00001797          	auipc	a5,0x1
 38c:	c787a783          	lw	a5,-904(a5) # 1000 <endian>
 390:	ef85                	bnez	a5,3c8 <ntohl+0x46>
        endian = byteorder();
 392:	4d200793          	li	a5,1234
 396:	00001717          	auipc	a4,0x1
 39a:	c6f72523          	sw	a5,-918(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 39e:	0185179b          	sllw	a5,a0,0x18
 3a2:	0185571b          	srlw	a4,a0,0x18
 3a6:	8fd9                	or	a5,a5,a4
 3a8:	0085171b          	sllw	a4,a0,0x8
 3ac:	00ff06b7          	lui	a3,0xff0
 3b0:	8f75                	and	a4,a4,a3
 3b2:	8fd9                	or	a5,a5,a4
 3b4:	0085551b          	srlw	a0,a0,0x8
 3b8:	6741                	lui	a4,0x10
 3ba:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeef0>
 3be:	8d79                	and	a0,a0,a4
 3c0:	8fc9                	or	a5,a5,a0
 3c2:	0007851b          	sext.w	a0,a5
 3c6:	a029                	j	3d0 <ntohl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(n) : n;
 3c8:	4d200713          	li	a4,1234
 3cc:	fce789e3          	beq	a5,a4,39e <ntohl+0x1c>
}
 3d0:	6422                	ld	s0,8(sp)
 3d2:	0141                	add	sp,sp,16
 3d4:	8082                	ret

00000000000003d6 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
 3d6:	1141                	add	sp,sp,-16
 3d8:	e422                	sd	s0,8(sp)
 3da:	0800                	add	s0,sp,16
 3dc:	872a                	mv	a4,a0
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
 3de:	02000693          	li	a3,32
 3e2:	4525                	li	a0,9
 3e4:	a011                	j	3e8 <strtol+0x12>
        s++;
 3e6:	0705                	add	a4,a4,1
    while (*s == ' ' || *s == '\t')
 3e8:	00074783          	lbu	a5,0(a4)
 3ec:	fed78de3          	beq	a5,a3,3e6 <strtol+0x10>
 3f0:	fea78be3          	beq	a5,a0,3e6 <strtol+0x10>

    // plus/minus sign
    if (*s == '+')
 3f4:	02b00693          	li	a3,43
 3f8:	02d78663          	beq	a5,a3,424 <strtol+0x4e>
        s++;
    else if (*s == '-')
 3fc:	02d00693          	li	a3,45
    int neg = 0;
 400:	4301                	li	t1,0
    else if (*s == '-')
 402:	02d78463          	beq	a5,a3,42a <strtol+0x54>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 406:	fef67793          	and	a5,a2,-17
 40a:	eb89                	bnez	a5,41c <strtol+0x46>
 40c:	00074683          	lbu	a3,0(a4)
 410:	03000793          	li	a5,48
 414:	00f68e63          	beq	a3,a5,430 <strtol+0x5a>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
 418:	e211                	bnez	a2,41c <strtol+0x46>
        s++, base = 8;
    else if (base == 0)
        base = 10;
 41a:	4629                	li	a2,10
 41c:	4501                	li	a0,0

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
 41e:	4825                	li	a6,9
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
 420:	48e5                	li	a7,25
 422:	a825                	j	45a <strtol+0x84>
        s++;
 424:	0705                	add	a4,a4,1
    int neg = 0;
 426:	4301                	li	t1,0
 428:	bff9                	j	406 <strtol+0x30>
        s++, neg = 1;
 42a:	0705                	add	a4,a4,1
 42c:	4305                	li	t1,1
 42e:	bfe1                	j	406 <strtol+0x30>
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 430:	00174683          	lbu	a3,1(a4)
 434:	07800793          	li	a5,120
 438:	00f68663          	beq	a3,a5,444 <strtol+0x6e>
    else if (base == 0 && s[0] == '0')
 43c:	f265                	bnez	a2,41c <strtol+0x46>
        s++, base = 8;
 43e:	0705                	add	a4,a4,1
 440:	4621                	li	a2,8
 442:	bfe9                	j	41c <strtol+0x46>
        s += 2, base = 16;
 444:	0709                	add	a4,a4,2
 446:	4641                	li	a2,16
 448:	bfd1                	j	41c <strtol+0x46>
            dig = *s - '0';
 44a:	fd07879b          	addw	a5,a5,-48
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
 44e:	04c7d063          	bge	a5,a2,48e <strtol+0xb8>
            break;
        s++, val = (val * base) + dig;
 452:	0705                	add	a4,a4,1
 454:	02a60533          	mul	a0,a2,a0
 458:	953e                	add	a0,a0,a5
        if (*s >= '0' && *s <= '9')
 45a:	00074783          	lbu	a5,0(a4)
 45e:	fd07869b          	addw	a3,a5,-48
 462:	0ff6f693          	zext.b	a3,a3
 466:	fed872e3          	bgeu	a6,a3,44a <strtol+0x74>
        else if (*s >= 'a' && *s <= 'z')
 46a:	f9f7869b          	addw	a3,a5,-97
 46e:	0ff6f693          	zext.b	a3,a3
 472:	00d8e563          	bltu	a7,a3,47c <strtol+0xa6>
            dig = *s - 'a' + 10;
 476:	fa97879b          	addw	a5,a5,-87
 47a:	bfd1                	j	44e <strtol+0x78>
        else if (*s >= 'A' && *s <= 'Z')
 47c:	fbf7869b          	addw	a3,a5,-65
 480:	0ff6f693          	zext.b	a3,a3
 484:	00d8e563          	bltu	a7,a3,48e <strtol+0xb8>
            dig = *s - 'A' + 10;
 488:	fc97879b          	addw	a5,a5,-55
 48c:	b7c9                	j	44e <strtol+0x78>
        // we don't properly detect overflow!
    }

    if (endptr)
 48e:	c191                	beqz	a1,492 <strtol+0xbc>
        *endptr = (char *) s;
 490:	e198                	sd	a4,0(a1)
    return (neg ? -val : val);
 492:	00030463          	beqz	t1,49a <strtol+0xc4>
 496:	40a00533          	neg	a0,a0
}
 49a:	6422                	ld	s0,8(sp)
 49c:	0141                	add	sp,sp,16
 49e:	8082                	ret

00000000000004a0 <inet_pton>:
inet_pton (int family, const char *p, void *n) {
    char *sp, *ep;
    int idx;
    long ret;

    if (family != AF_INET) {
 4a0:	4785                	li	a5,1
 4a2:	08f51063          	bne	a0,a5,522 <inet_pton+0x82>
inet_pton (int family, const char *p, void *n) {
 4a6:	715d                	add	sp,sp,-80
 4a8:	e486                	sd	ra,72(sp)
 4aa:	e0a2                	sd	s0,64(sp)
 4ac:	fc26                	sd	s1,56(sp)
 4ae:	f84a                	sd	s2,48(sp)
 4b0:	f44e                	sd	s3,40(sp)
 4b2:	f052                	sd	s4,32(sp)
 4b4:	ec56                	sd	s5,24(sp)
 4b6:	e85a                	sd	s6,16(sp)
 4b8:	0880                	add	s0,sp,80
 4ba:	84ae                	mv	s1,a1
 4bc:	89b2                	mv	s3,a2
 4be:	4901                	li	s2,0
        return -1;
    }
    sp = (char *)p;
    for (idx = 0; idx < 4; idx++) {
        ret = strtol(sp, &ep, 10);
        if (ret < 0 || ret > 255) {
 4c0:	0ff00a13          	li	s4,255
            return -1;
        }
        if (ep == sp) {
            return -1;
        }
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 4c4:	4a8d                	li	s5,3
 4c6:	02e00b13          	li	s6,46
 4ca:	a805                	j	4fa <inet_pton+0x5a>
 4cc:	0007c783          	lbu	a5,0(a5)
 4d0:	efb9                	bnez	a5,52e <inet_pton+0x8e>
            return -1;
        }
        ((uint8_t *)n)[idx] = ret;
 4d2:	00a981a3          	sb	a0,3(s3)
        sp = ep + 1;
    }
    return 0;
 4d6:	4501                	li	a0,0
}
 4d8:	60a6                	ld	ra,72(sp)
 4da:	6406                	ld	s0,64(sp)
 4dc:	74e2                	ld	s1,56(sp)
 4de:	7942                	ld	s2,48(sp)
 4e0:	79a2                	ld	s3,40(sp)
 4e2:	7a02                	ld	s4,32(sp)
 4e4:	6ae2                	ld	s5,24(sp)
 4e6:	6b42                	ld	s6,16(sp)
 4e8:	6161                	add	sp,sp,80
 4ea:	8082                	ret
        ((uint8_t *)n)[idx] = ret;
 4ec:	01298733          	add	a4,s3,s2
 4f0:	00a70023          	sb	a0,0(a4)
        sp = ep + 1;
 4f4:	00178493          	add	s1,a5,1
    for (idx = 0; idx < 4; idx++) {
 4f8:	0905                	add	s2,s2,1
        ret = strtol(sp, &ep, 10);
 4fa:	4629                	li	a2,10
 4fc:	fb840593          	add	a1,s0,-72
 500:	8526                	mv	a0,s1
 502:	ed5ff0ef          	jal	3d6 <strtol>
        if (ret < 0 || ret > 255) {
 506:	02aa6063          	bltu	s4,a0,526 <inet_pton+0x86>
        if (ep == sp) {
 50a:	fb843783          	ld	a5,-72(s0)
 50e:	00978e63          	beq	a5,s1,52a <inet_pton+0x8a>
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 512:	fb590de3          	beq	s2,s5,4cc <inet_pton+0x2c>
 516:	0007c703          	lbu	a4,0(a5)
 51a:	fd6709e3          	beq	a4,s6,4ec <inet_pton+0x4c>
            return -1;
 51e:	557d                	li	a0,-1
 520:	bf65                	j	4d8 <inet_pton+0x38>
        return -1;
 522:	557d                	li	a0,-1
}
 524:	8082                	ret
            return -1;
 526:	557d                	li	a0,-1
 528:	bf45                	j	4d8 <inet_pton+0x38>
            return -1;
 52a:	557d                	li	a0,-1
 52c:	b775                	j	4d8 <inet_pton+0x38>
            return -1;
 52e:	557d                	li	a0,-1
 530:	b765                	j	4d8 <inet_pton+0x38>

0000000000000532 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 532:	4885                	li	a7,1
 ecall
 534:	00000073          	ecall
 ret
 538:	8082                	ret

000000000000053a <exit>:
.global exit
exit:
 li a7, SYS_exit
 53a:	4889                	li	a7,2
 ecall
 53c:	00000073          	ecall
 ret
 540:	8082                	ret

0000000000000542 <wait>:
.global wait
wait:
 li a7, SYS_wait
 542:	488d                	li	a7,3
 ecall
 544:	00000073          	ecall
 ret
 548:	8082                	ret

000000000000054a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 54a:	4891                	li	a7,4
 ecall
 54c:	00000073          	ecall
 ret
 550:	8082                	ret

0000000000000552 <read>:
.global read
read:
 li a7, SYS_read
 552:	4895                	li	a7,5
 ecall
 554:	00000073          	ecall
 ret
 558:	8082                	ret

000000000000055a <write>:
.global write
write:
 li a7, SYS_write
 55a:	48c1                	li	a7,16
 ecall
 55c:	00000073          	ecall
 ret
 560:	8082                	ret

0000000000000562 <close>:
.global close
close:
 li a7, SYS_close
 562:	48d5                	li	a7,21
 ecall
 564:	00000073          	ecall
 ret
 568:	8082                	ret

000000000000056a <kill>:
.global kill
kill:
 li a7, SYS_kill
 56a:	4899                	li	a7,6
 ecall
 56c:	00000073          	ecall
 ret
 570:	8082                	ret

0000000000000572 <exec>:
.global exec
exec:
 li a7, SYS_exec
 572:	489d                	li	a7,7
 ecall
 574:	00000073          	ecall
 ret
 578:	8082                	ret

000000000000057a <open>:
.global open
open:
 li a7, SYS_open
 57a:	48bd                	li	a7,15
 ecall
 57c:	00000073          	ecall
 ret
 580:	8082                	ret

0000000000000582 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 582:	48c5                	li	a7,17
 ecall
 584:	00000073          	ecall
 ret
 588:	8082                	ret

000000000000058a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 58a:	48c9                	li	a7,18
 ecall
 58c:	00000073          	ecall
 ret
 590:	8082                	ret

0000000000000592 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 592:	48a1                	li	a7,8
 ecall
 594:	00000073          	ecall
 ret
 598:	8082                	ret

000000000000059a <link>:
.global link
link:
 li a7, SYS_link
 59a:	48cd                	li	a7,19
 ecall
 59c:	00000073          	ecall
 ret
 5a0:	8082                	ret

00000000000005a2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5a2:	48d1                	li	a7,20
 ecall
 5a4:	00000073          	ecall
 ret
 5a8:	8082                	ret

00000000000005aa <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5aa:	48a5                	li	a7,9
 ecall
 5ac:	00000073          	ecall
 ret
 5b0:	8082                	ret

00000000000005b2 <dup>:
.global dup
dup:
 li a7, SYS_dup
 5b2:	48a9                	li	a7,10
 ecall
 5b4:	00000073          	ecall
 ret
 5b8:	8082                	ret

00000000000005ba <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5ba:	48ad                	li	a7,11
 ecall
 5bc:	00000073          	ecall
 ret
 5c0:	8082                	ret

00000000000005c2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5c2:	48b1                	li	a7,12
 ecall
 5c4:	00000073          	ecall
 ret
 5c8:	8082                	ret

00000000000005ca <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5ca:	48b5                	li	a7,13
 ecall
 5cc:	00000073          	ecall
 ret
 5d0:	8082                	ret

00000000000005d2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5d2:	48b9                	li	a7,14
 ecall
 5d4:	00000073          	ecall
 ret
 5d8:	8082                	ret

00000000000005da <socket>:
.global socket
socket:
 li a7, SYS_socket
 5da:	48d9                	li	a7,22
 ecall
 5dc:	00000073          	ecall
 ret
 5e0:	8082                	ret

00000000000005e2 <bind>:
.global bind
bind:
 li a7, SYS_bind
 5e2:	48dd                	li	a7,23
 ecall
 5e4:	00000073          	ecall
 ret
 5e8:	8082                	ret

00000000000005ea <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 5ea:	48e1                	li	a7,24
 ecall
 5ec:	00000073          	ecall
 ret
 5f0:	8082                	ret

00000000000005f2 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 5f2:	48e5                	li	a7,25
 ecall
 5f4:	00000073          	ecall
 ret
 5f8:	8082                	ret

00000000000005fa <connect>:
.global connect
connect:
 li a7, SYS_connect
 5fa:	48e9                	li	a7,26
 ecall
 5fc:	00000073          	ecall
 ret
 600:	8082                	ret

0000000000000602 <listen>:
.global listen
listen:
 li a7, SYS_listen
 602:	48ed                	li	a7,27
 ecall
 604:	00000073          	ecall
 ret
 608:	8082                	ret

000000000000060a <accept>:
.global accept
accept:
 li a7, SYS_accept
 60a:	48f1                	li	a7,28
 ecall
 60c:	00000073          	ecall
 ret
 610:	8082                	ret

0000000000000612 <recv>:
.global recv
recv:
 li a7, SYS_recv
 612:	48f5                	li	a7,29
 ecall
 614:	00000073          	ecall
 ret
 618:	8082                	ret

000000000000061a <send>:
.global send
send:
 li a7, SYS_send
 61a:	48f9                	li	a7,30
 ecall
 61c:	00000073          	ecall
 ret
 620:	8082                	ret

0000000000000622 <ioctl>:
.global ioctl
ioctl:
 li a7, SYS_ioctl
 622:	48fd                	li	a7,31
 ecall
 624:	00000073          	ecall
 ret
 628:	8082                	ret

000000000000062a <consolemode>:
.global consolemode
consolemode:
 li a7, SYS_consolemode
 62a:	02000893          	li	a7,32
 ecall
 62e:	00000073          	ecall
 ret
 632:	8082                	ret

0000000000000634 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 634:	1101                	add	sp,sp,-32
 636:	ec06                	sd	ra,24(sp)
 638:	e822                	sd	s0,16(sp)
 63a:	1000                	add	s0,sp,32
 63c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 640:	4605                	li	a2,1
 642:	fef40593          	add	a1,s0,-17
 646:	f15ff0ef          	jal	55a <write>
}
 64a:	60e2                	ld	ra,24(sp)
 64c:	6442                	ld	s0,16(sp)
 64e:	6105                	add	sp,sp,32
 650:	8082                	ret

0000000000000652 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 652:	715d                	add	sp,sp,-80
 654:	e486                	sd	ra,72(sp)
 656:	e0a2                	sd	s0,64(sp)
 658:	fc26                	sd	s1,56(sp)
 65a:	0880                	add	s0,sp,80
 65c:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 65e:	c299                	beqz	a3,664 <printint+0x12>
 660:	0805c963          	bltz	a1,6f2 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 664:	2581                	sext.w	a1,a1
  neg = 0;
 666:	4881                	li	a7,0
 668:	fb840693          	add	a3,s0,-72
  }

  i = 0;
 66c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 66e:	2601                	sext.w	a2,a2
 670:	00000517          	auipc	a0,0x0
 674:	51050513          	add	a0,a0,1296 # b80 <digits>
 678:	883a                	mv	a6,a4
 67a:	2705                	addw	a4,a4,1
 67c:	02c5f7bb          	remuw	a5,a1,a2
 680:	1782                	sll	a5,a5,0x20
 682:	9381                	srl	a5,a5,0x20
 684:	97aa                	add	a5,a5,a0
 686:	0007c783          	lbu	a5,0(a5)
 68a:	00f68023          	sb	a5,0(a3) # ff0000 <base+0xfeeff0>
  }while((x /= base) != 0);
 68e:	0005879b          	sext.w	a5,a1
 692:	02c5d5bb          	divuw	a1,a1,a2
 696:	0685                	add	a3,a3,1
 698:	fec7f0e3          	bgeu	a5,a2,678 <printint+0x26>
  if(neg)
 69c:	00088c63          	beqz	a7,6b4 <printint+0x62>
    buf[i++] = '-';
 6a0:	fd070793          	add	a5,a4,-48
 6a4:	00878733          	add	a4,a5,s0
 6a8:	02d00793          	li	a5,45
 6ac:	fef70423          	sb	a5,-24(a4)
 6b0:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 6b4:	02e05a63          	blez	a4,6e8 <printint+0x96>
 6b8:	f84a                	sd	s2,48(sp)
 6ba:	f44e                	sd	s3,40(sp)
 6bc:	fb840793          	add	a5,s0,-72
 6c0:	00e78933          	add	s2,a5,a4
 6c4:	fff78993          	add	s3,a5,-1
 6c8:	99ba                	add	s3,s3,a4
 6ca:	377d                	addw	a4,a4,-1
 6cc:	1702                	sll	a4,a4,0x20
 6ce:	9301                	srl	a4,a4,0x20
 6d0:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 6d4:	fff94583          	lbu	a1,-1(s2)
 6d8:	8526                	mv	a0,s1
 6da:	f5bff0ef          	jal	634 <putc>
  while(--i >= 0)
 6de:	197d                	add	s2,s2,-1
 6e0:	ff391ae3          	bne	s2,s3,6d4 <printint+0x82>
 6e4:	7942                	ld	s2,48(sp)
 6e6:	79a2                	ld	s3,40(sp)
}
 6e8:	60a6                	ld	ra,72(sp)
 6ea:	6406                	ld	s0,64(sp)
 6ec:	74e2                	ld	s1,56(sp)
 6ee:	6161                	add	sp,sp,80
 6f0:	8082                	ret
    x = -xx;
 6f2:	40b005bb          	negw	a1,a1
    neg = 1;
 6f6:	4885                	li	a7,1
    x = -xx;
 6f8:	bf85                	j	668 <printint+0x16>

00000000000006fa <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6fa:	711d                	add	sp,sp,-96
 6fc:	ec86                	sd	ra,88(sp)
 6fe:	e8a2                	sd	s0,80(sp)
 700:	e0ca                	sd	s2,64(sp)
 702:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 704:	0005c903          	lbu	s2,0(a1)
 708:	26090863          	beqz	s2,978 <vprintf+0x27e>
 70c:	e4a6                	sd	s1,72(sp)
 70e:	fc4e                	sd	s3,56(sp)
 710:	f852                	sd	s4,48(sp)
 712:	f456                	sd	s5,40(sp)
 714:	f05a                	sd	s6,32(sp)
 716:	ec5e                	sd	s7,24(sp)
 718:	e862                	sd	s8,16(sp)
 71a:	e466                	sd	s9,8(sp)
 71c:	8b2a                	mv	s6,a0
 71e:	8a2e                	mv	s4,a1
 720:	8bb2                	mv	s7,a2
  state = 0;
 722:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 724:	4481                	li	s1,0
 726:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 728:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 72c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 730:	06c00c93          	li	s9,108
 734:	a005                	j	754 <vprintf+0x5a>
        putc(fd, c0);
 736:	85ca                	mv	a1,s2
 738:	855a                	mv	a0,s6
 73a:	efbff0ef          	jal	634 <putc>
 73e:	a019                	j	744 <vprintf+0x4a>
    } else if(state == '%'){
 740:	03598263          	beq	s3,s5,764 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 744:	2485                	addw	s1,s1,1
 746:	8726                	mv	a4,s1
 748:	009a07b3          	add	a5,s4,s1
 74c:	0007c903          	lbu	s2,0(a5)
 750:	20090c63          	beqz	s2,968 <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 754:	0009079b          	sext.w	a5,s2
    if(state == 0){
 758:	fe0994e3          	bnez	s3,740 <vprintf+0x46>
      if(c0 == '%'){
 75c:	fd579de3          	bne	a5,s5,736 <vprintf+0x3c>
        state = '%';
 760:	89be                	mv	s3,a5
 762:	b7cd                	j	744 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 764:	00ea06b3          	add	a3,s4,a4
 768:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 76c:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 76e:	c681                	beqz	a3,776 <vprintf+0x7c>
 770:	9752                	add	a4,a4,s4
 772:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 776:	03878f63          	beq	a5,s8,7b4 <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 77a:	05978963          	beq	a5,s9,7cc <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 77e:	07500713          	li	a4,117
 782:	0ee78363          	beq	a5,a4,868 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 786:	07800713          	li	a4,120
 78a:	12e78563          	beq	a5,a4,8b4 <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 78e:	07000713          	li	a4,112
 792:	14e78a63          	beq	a5,a4,8e6 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 796:	07300713          	li	a4,115
 79a:	18e78a63          	beq	a5,a4,92e <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 79e:	02500713          	li	a4,37
 7a2:	04e79563          	bne	a5,a4,7ec <vprintf+0xf2>
        putc(fd, '%');
 7a6:	02500593          	li	a1,37
 7aa:	855a                	mv	a0,s6
 7ac:	e89ff0ef          	jal	634 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 7b0:	4981                	li	s3,0
 7b2:	bf49                	j	744 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 7b4:	008b8913          	add	s2,s7,8
 7b8:	4685                	li	a3,1
 7ba:	4629                	li	a2,10
 7bc:	000ba583          	lw	a1,0(s7)
 7c0:	855a                	mv	a0,s6
 7c2:	e91ff0ef          	jal	652 <printint>
 7c6:	8bca                	mv	s7,s2
      state = 0;
 7c8:	4981                	li	s3,0
 7ca:	bfad                	j	744 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 7cc:	06400793          	li	a5,100
 7d0:	02f68963          	beq	a3,a5,802 <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 7d4:	06c00793          	li	a5,108
 7d8:	04f68263          	beq	a3,a5,81c <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 7dc:	07500793          	li	a5,117
 7e0:	0af68063          	beq	a3,a5,880 <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 7e4:	07800793          	li	a5,120
 7e8:	0ef68263          	beq	a3,a5,8cc <vprintf+0x1d2>
        putc(fd, '%');
 7ec:	02500593          	li	a1,37
 7f0:	855a                	mv	a0,s6
 7f2:	e43ff0ef          	jal	634 <putc>
        putc(fd, c0);
 7f6:	85ca                	mv	a1,s2
 7f8:	855a                	mv	a0,s6
 7fa:	e3bff0ef          	jal	634 <putc>
      state = 0;
 7fe:	4981                	li	s3,0
 800:	b791                	j	744 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 802:	008b8913          	add	s2,s7,8
 806:	4685                	li	a3,1
 808:	4629                	li	a2,10
 80a:	000bb583          	ld	a1,0(s7)
 80e:	855a                	mv	a0,s6
 810:	e43ff0ef          	jal	652 <printint>
        i += 1;
 814:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 816:	8bca                	mv	s7,s2
      state = 0;
 818:	4981                	li	s3,0
        i += 1;
 81a:	b72d                	j	744 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 81c:	06400793          	li	a5,100
 820:	02f60763          	beq	a2,a5,84e <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 824:	07500793          	li	a5,117
 828:	06f60963          	beq	a2,a5,89a <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 82c:	07800793          	li	a5,120
 830:	faf61ee3          	bne	a2,a5,7ec <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 834:	008b8913          	add	s2,s7,8
 838:	4681                	li	a3,0
 83a:	4641                	li	a2,16
 83c:	000bb583          	ld	a1,0(s7)
 840:	855a                	mv	a0,s6
 842:	e11ff0ef          	jal	652 <printint>
        i += 2;
 846:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 848:	8bca                	mv	s7,s2
      state = 0;
 84a:	4981                	li	s3,0
        i += 2;
 84c:	bde5                	j	744 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 84e:	008b8913          	add	s2,s7,8
 852:	4685                	li	a3,1
 854:	4629                	li	a2,10
 856:	000bb583          	ld	a1,0(s7)
 85a:	855a                	mv	a0,s6
 85c:	df7ff0ef          	jal	652 <printint>
        i += 2;
 860:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 862:	8bca                	mv	s7,s2
      state = 0;
 864:	4981                	li	s3,0
        i += 2;
 866:	bdf9                	j	744 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 868:	008b8913          	add	s2,s7,8
 86c:	4681                	li	a3,0
 86e:	4629                	li	a2,10
 870:	000ba583          	lw	a1,0(s7)
 874:	855a                	mv	a0,s6
 876:	dddff0ef          	jal	652 <printint>
 87a:	8bca                	mv	s7,s2
      state = 0;
 87c:	4981                	li	s3,0
 87e:	b5d9                	j	744 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 880:	008b8913          	add	s2,s7,8
 884:	4681                	li	a3,0
 886:	4629                	li	a2,10
 888:	000bb583          	ld	a1,0(s7)
 88c:	855a                	mv	a0,s6
 88e:	dc5ff0ef          	jal	652 <printint>
        i += 1;
 892:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 894:	8bca                	mv	s7,s2
      state = 0;
 896:	4981                	li	s3,0
        i += 1;
 898:	b575                	j	744 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 89a:	008b8913          	add	s2,s7,8
 89e:	4681                	li	a3,0
 8a0:	4629                	li	a2,10
 8a2:	000bb583          	ld	a1,0(s7)
 8a6:	855a                	mv	a0,s6
 8a8:	dabff0ef          	jal	652 <printint>
        i += 2;
 8ac:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 8ae:	8bca                	mv	s7,s2
      state = 0;
 8b0:	4981                	li	s3,0
        i += 2;
 8b2:	bd49                	j	744 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 8b4:	008b8913          	add	s2,s7,8
 8b8:	4681                	li	a3,0
 8ba:	4641                	li	a2,16
 8bc:	000ba583          	lw	a1,0(s7)
 8c0:	855a                	mv	a0,s6
 8c2:	d91ff0ef          	jal	652 <printint>
 8c6:	8bca                	mv	s7,s2
      state = 0;
 8c8:	4981                	li	s3,0
 8ca:	bdad                	j	744 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 8cc:	008b8913          	add	s2,s7,8
 8d0:	4681                	li	a3,0
 8d2:	4641                	li	a2,16
 8d4:	000bb583          	ld	a1,0(s7)
 8d8:	855a                	mv	a0,s6
 8da:	d79ff0ef          	jal	652 <printint>
        i += 1;
 8de:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 8e0:	8bca                	mv	s7,s2
      state = 0;
 8e2:	4981                	li	s3,0
        i += 1;
 8e4:	b585                	j	744 <vprintf+0x4a>
 8e6:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 8e8:	008b8d13          	add	s10,s7,8
 8ec:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 8f0:	03000593          	li	a1,48
 8f4:	855a                	mv	a0,s6
 8f6:	d3fff0ef          	jal	634 <putc>
  putc(fd, 'x');
 8fa:	07800593          	li	a1,120
 8fe:	855a                	mv	a0,s6
 900:	d35ff0ef          	jal	634 <putc>
 904:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 906:	00000b97          	auipc	s7,0x0
 90a:	27ab8b93          	add	s7,s7,634 # b80 <digits>
 90e:	03c9d793          	srl	a5,s3,0x3c
 912:	97de                	add	a5,a5,s7
 914:	0007c583          	lbu	a1,0(a5)
 918:	855a                	mv	a0,s6
 91a:	d1bff0ef          	jal	634 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 91e:	0992                	sll	s3,s3,0x4
 920:	397d                	addw	s2,s2,-1
 922:	fe0916e3          	bnez	s2,90e <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 926:	8bea                	mv	s7,s10
      state = 0;
 928:	4981                	li	s3,0
 92a:	6d02                	ld	s10,0(sp)
 92c:	bd21                	j	744 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 92e:	008b8993          	add	s3,s7,8
 932:	000bb903          	ld	s2,0(s7)
 936:	00090f63          	beqz	s2,954 <vprintf+0x25a>
        for(; *s; s++)
 93a:	00094583          	lbu	a1,0(s2)
 93e:	c195                	beqz	a1,962 <vprintf+0x268>
          putc(fd, *s);
 940:	855a                	mv	a0,s6
 942:	cf3ff0ef          	jal	634 <putc>
        for(; *s; s++)
 946:	0905                	add	s2,s2,1
 948:	00094583          	lbu	a1,0(s2)
 94c:	f9f5                	bnez	a1,940 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 94e:	8bce                	mv	s7,s3
      state = 0;
 950:	4981                	li	s3,0
 952:	bbcd                	j	744 <vprintf+0x4a>
          s = "(null)";
 954:	00000917          	auipc	s2,0x0
 958:	22490913          	add	s2,s2,548 # b78 <malloc+0x110>
        for(; *s; s++)
 95c:	02800593          	li	a1,40
 960:	b7c5                	j	940 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 962:	8bce                	mv	s7,s3
      state = 0;
 964:	4981                	li	s3,0
 966:	bbf9                	j	744 <vprintf+0x4a>
 968:	64a6                	ld	s1,72(sp)
 96a:	79e2                	ld	s3,56(sp)
 96c:	7a42                	ld	s4,48(sp)
 96e:	7aa2                	ld	s5,40(sp)
 970:	7b02                	ld	s6,32(sp)
 972:	6be2                	ld	s7,24(sp)
 974:	6c42                	ld	s8,16(sp)
 976:	6ca2                	ld	s9,8(sp)
    }
  }
}
 978:	60e6                	ld	ra,88(sp)
 97a:	6446                	ld	s0,80(sp)
 97c:	6906                	ld	s2,64(sp)
 97e:	6125                	add	sp,sp,96
 980:	8082                	ret

0000000000000982 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 982:	715d                	add	sp,sp,-80
 984:	ec06                	sd	ra,24(sp)
 986:	e822                	sd	s0,16(sp)
 988:	1000                	add	s0,sp,32
 98a:	e010                	sd	a2,0(s0)
 98c:	e414                	sd	a3,8(s0)
 98e:	e818                	sd	a4,16(s0)
 990:	ec1c                	sd	a5,24(s0)
 992:	03043023          	sd	a6,32(s0)
 996:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 99a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 99e:	8622                	mv	a2,s0
 9a0:	d5bff0ef          	jal	6fa <vprintf>
}
 9a4:	60e2                	ld	ra,24(sp)
 9a6:	6442                	ld	s0,16(sp)
 9a8:	6161                	add	sp,sp,80
 9aa:	8082                	ret

00000000000009ac <printf>:

void
printf(const char *fmt, ...)
{
 9ac:	711d                	add	sp,sp,-96
 9ae:	ec06                	sd	ra,24(sp)
 9b0:	e822                	sd	s0,16(sp)
 9b2:	1000                	add	s0,sp,32
 9b4:	e40c                	sd	a1,8(s0)
 9b6:	e810                	sd	a2,16(s0)
 9b8:	ec14                	sd	a3,24(s0)
 9ba:	f018                	sd	a4,32(s0)
 9bc:	f41c                	sd	a5,40(s0)
 9be:	03043823          	sd	a6,48(s0)
 9c2:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 9c6:	00840613          	add	a2,s0,8
 9ca:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 9ce:	85aa                	mv	a1,a0
 9d0:	4505                	li	a0,1
 9d2:	d29ff0ef          	jal	6fa <vprintf>
}
 9d6:	60e2                	ld	ra,24(sp)
 9d8:	6442                	ld	s0,16(sp)
 9da:	6125                	add	sp,sp,96
 9dc:	8082                	ret

00000000000009de <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9de:	1141                	add	sp,sp,-16
 9e0:	e422                	sd	s0,8(sp)
 9e2:	0800                	add	s0,sp,16
  Header *bp, *p;

  if(ap == 0)
 9e4:	cd3d                	beqz	a0,a62 <free+0x84>
    return;
  if((uint64)ap < 4096)
 9e6:	6785                	lui	a5,0x1
 9e8:	06f56d63          	bltu	a0,a5,a62 <free+0x84>
    return;
  bp = (Header*)ap - 1;
 9ec:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9f0:	00000797          	auipc	a5,0x0
 9f4:	6187b783          	ld	a5,1560(a5) # 1008 <freep>
 9f8:	a02d                	j	a22 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 9fa:	4618                	lw	a4,8(a2)
 9fc:	9f2d                	addw	a4,a4,a1
 9fe:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a02:	6398                	ld	a4,0(a5)
 a04:	6310                	ld	a2,0(a4)
 a06:	a83d                	j	a44 <free+0x66>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a08:	ff852703          	lw	a4,-8(a0)
 a0c:	9f31                	addw	a4,a4,a2
 a0e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a10:	ff053683          	ld	a3,-16(a0)
 a14:	a091                	j	a58 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a16:	6398                	ld	a4,0(a5)
 a18:	00e7e463          	bltu	a5,a4,a20 <free+0x42>
 a1c:	00e6ea63          	bltu	a3,a4,a30 <free+0x52>
{
 a20:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a22:	fed7fae3          	bgeu	a5,a3,a16 <free+0x38>
 a26:	6398                	ld	a4,0(a5)
 a28:	00e6e463          	bltu	a3,a4,a30 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a2c:	fee7eae3          	bltu	a5,a4,a20 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 a30:	ff852583          	lw	a1,-8(a0)
 a34:	6390                	ld	a2,0(a5)
 a36:	02059813          	sll	a6,a1,0x20
 a3a:	01c85713          	srl	a4,a6,0x1c
 a3e:	9736                	add	a4,a4,a3
 a40:	fae60de3          	beq	a2,a4,9fa <free+0x1c>
    bp->s.ptr = p->s.ptr->s.ptr;
 a44:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a48:	4790                	lw	a2,8(a5)
 a4a:	02061593          	sll	a1,a2,0x20
 a4e:	01c5d713          	srl	a4,a1,0x1c
 a52:	973e                	add	a4,a4,a5
 a54:	fae68ae3          	beq	a3,a4,a08 <free+0x2a>
    p->s.ptr = bp->s.ptr;
 a58:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 a5a:	00000717          	auipc	a4,0x0
 a5e:	5af73723          	sd	a5,1454(a4) # 1008 <freep>
}
 a62:	6422                	ld	s0,8(sp)
 a64:	0141                	add	sp,sp,16
 a66:	8082                	ret

0000000000000a68 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a68:	7139                	add	sp,sp,-64
 a6a:	fc06                	sd	ra,56(sp)
 a6c:	f822                	sd	s0,48(sp)
 a6e:	f426                	sd	s1,40(sp)
 a70:	ec4e                	sd	s3,24(sp)
 a72:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a74:	02051493          	sll	s1,a0,0x20
 a78:	9081                	srl	s1,s1,0x20
 a7a:	04bd                	add	s1,s1,15
 a7c:	8091                	srl	s1,s1,0x4
 a7e:	0014899b          	addw	s3,s1,1
 a82:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 a84:	00000517          	auipc	a0,0x0
 a88:	58453503          	ld	a0,1412(a0) # 1008 <freep>
 a8c:	c915                	beqz	a0,ac0 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a8e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a90:	4798                	lw	a4,8(a5)
 a92:	08977a63          	bgeu	a4,s1,b26 <malloc+0xbe>
 a96:	f04a                	sd	s2,32(sp)
 a98:	e852                	sd	s4,16(sp)
 a9a:	e456                	sd	s5,8(sp)
 a9c:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 a9e:	8a4e                	mv	s4,s3
 aa0:	0009871b          	sext.w	a4,s3
 aa4:	6685                	lui	a3,0x1
 aa6:	00d77363          	bgeu	a4,a3,aac <malloc+0x44>
 aaa:	6a05                	lui	s4,0x1
 aac:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 ab0:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ab4:	00000917          	auipc	s2,0x0
 ab8:	55490913          	add	s2,s2,1364 # 1008 <freep>
  if(p == (char*)-1)
 abc:	5afd                	li	s5,-1
 abe:	a081                	j	afe <malloc+0x96>
 ac0:	f04a                	sd	s2,32(sp)
 ac2:	e852                	sd	s4,16(sp)
 ac4:	e456                	sd	s5,8(sp)
 ac6:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 ac8:	00000797          	auipc	a5,0x0
 acc:	54878793          	add	a5,a5,1352 # 1010 <base>
 ad0:	00000717          	auipc	a4,0x0
 ad4:	52f73c23          	sd	a5,1336(a4) # 1008 <freep>
 ad8:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 ada:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 ade:	b7c1                	j	a9e <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 ae0:	6398                	ld	a4,0(a5)
 ae2:	e118                	sd	a4,0(a0)
 ae4:	a8a9                	j	b3e <malloc+0xd6>
  hp->s.size = nu;
 ae6:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 aea:	0541                	add	a0,a0,16
 aec:	ef3ff0ef          	jal	9de <free>
  return freep;
 af0:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 af4:	c12d                	beqz	a0,b56 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 af6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 af8:	4798                	lw	a4,8(a5)
 afa:	02977263          	bgeu	a4,s1,b1e <malloc+0xb6>
    if(p == freep)
 afe:	00093703          	ld	a4,0(s2)
 b02:	853e                	mv	a0,a5
 b04:	fef719e3          	bne	a4,a5,af6 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 b08:	8552                	mv	a0,s4
 b0a:	ab9ff0ef          	jal	5c2 <sbrk>
  if(p == (char*)-1)
 b0e:	fd551ce3          	bne	a0,s5,ae6 <malloc+0x7e>
        return 0;
 b12:	4501                	li	a0,0
 b14:	7902                	ld	s2,32(sp)
 b16:	6a42                	ld	s4,16(sp)
 b18:	6aa2                	ld	s5,8(sp)
 b1a:	6b02                	ld	s6,0(sp)
 b1c:	a03d                	j	b4a <malloc+0xe2>
 b1e:	7902                	ld	s2,32(sp)
 b20:	6a42                	ld	s4,16(sp)
 b22:	6aa2                	ld	s5,8(sp)
 b24:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 b26:	fae48de3          	beq	s1,a4,ae0 <malloc+0x78>
        p->s.size -= nunits;
 b2a:	4137073b          	subw	a4,a4,s3
 b2e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b30:	02071693          	sll	a3,a4,0x20
 b34:	01c6d713          	srl	a4,a3,0x1c
 b38:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b3a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b3e:	00000717          	auipc	a4,0x0
 b42:	4ca73523          	sd	a0,1226(a4) # 1008 <freep>
      return (void*)(p + 1);
 b46:	01078513          	add	a0,a5,16
  }
}
 b4a:	70e2                	ld	ra,56(sp)
 b4c:	7442                	ld	s0,48(sp)
 b4e:	74a2                	ld	s1,40(sp)
 b50:	69e2                	ld	s3,24(sp)
 b52:	6121                	add	sp,sp,64
 b54:	8082                	ret
 b56:	7902                	ld	s2,32(sp)
 b58:	6a42                	ld	s4,16(sp)
 b5a:	6aa2                	ld	s5,8(sp)
 b5c:	6b02                	ld	s6,0(sp)
 b5e:	b7f5                	j	b4a <malloc+0xe2>
