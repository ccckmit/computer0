
user/_echo:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	7139                	add	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	f04a                	sd	s2,32(sp)
   a:	ec4e                	sd	s3,24(sp)
   c:	e852                	sd	s4,16(sp)
   e:	e456                	sd	s5,8(sp)
  10:	0080                	add	s0,sp,64
  int i;

  for(i = 1; i < argc; i++){
  12:	4785                	li	a5,1
  14:	06a7d063          	bge	a5,a0,74 <main+0x74>
  18:	00858493          	add	s1,a1,8
  1c:	3579                	addw	a0,a0,-2
  1e:	02051793          	sll	a5,a0,0x20
  22:	01d7d513          	srl	a0,a5,0x1d
  26:	00a48a33          	add	s4,s1,a0
  2a:	05c1                	add	a1,a1,16
  2c:	00a589b3          	add	s3,a1,a0
    write(1, argv[i], strlen(argv[i]));
    if(i + 1 < argc){
      write(1, " ", 1);
  30:	00001a97          	auipc	s5,0x1
  34:	b60a8a93          	add	s5,s5,-1184 # b90 <malloc+0x102>
  38:	a809                	j	4a <main+0x4a>
  3a:	4605                	li	a2,1
  3c:	85d6                	mv	a1,s5
  3e:	4505                	li	a0,1
  40:	540000ef          	jal	580 <write>
  for(i = 1; i < argc; i++){
  44:	04a1                	add	s1,s1,8
  46:	03348763          	beq	s1,s3,74 <main+0x74>
    write(1, argv[i], strlen(argv[i]));
  4a:	0004b903          	ld	s2,0(s1)
  4e:	854a                	mv	a0,s2
  50:	084000ef          	jal	d4 <strlen>
  54:	0005061b          	sext.w	a2,a0
  58:	85ca                	mv	a1,s2
  5a:	4505                	li	a0,1
  5c:	524000ef          	jal	580 <write>
    if(i + 1 < argc){
  60:	fd449de3          	bne	s1,s4,3a <main+0x3a>
    } else {
      write(1, "\n", 1);
  64:	4605                	li	a2,1
  66:	00001597          	auipc	a1,0x1
  6a:	b3258593          	add	a1,a1,-1230 # b98 <malloc+0x10a>
  6e:	4505                	li	a0,1
  70:	510000ef          	jal	580 <write>
    }
  }
  exit(0);
  74:	4501                	li	a0,0
  76:	4ea000ef          	jal	560 <exit>

000000000000007a <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  7a:	1141                	add	sp,sp,-16
  7c:	e406                	sd	ra,8(sp)
  7e:	e022                	sd	s0,0(sp)
  80:	0800                	add	s0,sp,16
  extern int main();
  main();
  82:	f7fff0ef          	jal	0 <main>
  exit(0);
  86:	4501                	li	a0,0
  88:	4d8000ef          	jal	560 <exit>

000000000000008c <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  8c:	1141                	add	sp,sp,-16
  8e:	e422                	sd	s0,8(sp)
  90:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  92:	87aa                	mv	a5,a0
  94:	0585                	add	a1,a1,1
  96:	0785                	add	a5,a5,1
  98:	fff5c703          	lbu	a4,-1(a1)
  9c:	fee78fa3          	sb	a4,-1(a5)
  a0:	fb75                	bnez	a4,94 <strcpy+0x8>
    ;
  return os;
}
  a2:	6422                	ld	s0,8(sp)
  a4:	0141                	add	sp,sp,16
  a6:	8082                	ret

00000000000000a8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  a8:	1141                	add	sp,sp,-16
  aa:	e422                	sd	s0,8(sp)
  ac:	0800                	add	s0,sp,16
  while(*p && *p == *q)
  ae:	00054783          	lbu	a5,0(a0)
  b2:	cb91                	beqz	a5,c6 <strcmp+0x1e>
  b4:	0005c703          	lbu	a4,0(a1)
  b8:	00f71763          	bne	a4,a5,c6 <strcmp+0x1e>
    p++, q++;
  bc:	0505                	add	a0,a0,1
  be:	0585                	add	a1,a1,1
  while(*p && *p == *q)
  c0:	00054783          	lbu	a5,0(a0)
  c4:	fbe5                	bnez	a5,b4 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  c6:	0005c503          	lbu	a0,0(a1)
}
  ca:	40a7853b          	subw	a0,a5,a0
  ce:	6422                	ld	s0,8(sp)
  d0:	0141                	add	sp,sp,16
  d2:	8082                	ret

00000000000000d4 <strlen>:

uint
strlen(const char *s)
{
  d4:	1141                	add	sp,sp,-16
  d6:	e422                	sd	s0,8(sp)
  d8:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  da:	00054783          	lbu	a5,0(a0)
  de:	cf91                	beqz	a5,fa <strlen+0x26>
  e0:	0505                	add	a0,a0,1
  e2:	87aa                	mv	a5,a0
  e4:	86be                	mv	a3,a5
  e6:	0785                	add	a5,a5,1
  e8:	fff7c703          	lbu	a4,-1(a5)
  ec:	ff65                	bnez	a4,e4 <strlen+0x10>
  ee:	40a6853b          	subw	a0,a3,a0
  f2:	2505                	addw	a0,a0,1
    ;
  return n;
}
  f4:	6422                	ld	s0,8(sp)
  f6:	0141                	add	sp,sp,16
  f8:	8082                	ret
  for(n = 0; s[n]; n++)
  fa:	4501                	li	a0,0
  fc:	bfe5                	j	f4 <strlen+0x20>

00000000000000fe <memset>:

void*
memset(void *dst, int c, uint n)
{
  fe:	1141                	add	sp,sp,-16
 100:	e422                	sd	s0,8(sp)
 102:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 104:	ca19                	beqz	a2,11a <memset+0x1c>
 106:	87aa                	mv	a5,a0
 108:	1602                	sll	a2,a2,0x20
 10a:	9201                	srl	a2,a2,0x20
 10c:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 110:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 114:	0785                	add	a5,a5,1
 116:	fee79de3          	bne	a5,a4,110 <memset+0x12>
  }
  return dst;
}
 11a:	6422                	ld	s0,8(sp)
 11c:	0141                	add	sp,sp,16
 11e:	8082                	ret

0000000000000120 <strchr>:

char*
strchr(const char *s, char c)
{
 120:	1141                	add	sp,sp,-16
 122:	e422                	sd	s0,8(sp)
 124:	0800                	add	s0,sp,16
  for(; *s; s++)
 126:	00054783          	lbu	a5,0(a0)
 12a:	cb99                	beqz	a5,140 <strchr+0x20>
    if(*s == c)
 12c:	00f58763          	beq	a1,a5,13a <strchr+0x1a>
  for(; *s; s++)
 130:	0505                	add	a0,a0,1
 132:	00054783          	lbu	a5,0(a0)
 136:	fbfd                	bnez	a5,12c <strchr+0xc>
      return (char*)s;
  return 0;
 138:	4501                	li	a0,0
}
 13a:	6422                	ld	s0,8(sp)
 13c:	0141                	add	sp,sp,16
 13e:	8082                	ret
  return 0;
 140:	4501                	li	a0,0
 142:	bfe5                	j	13a <strchr+0x1a>

0000000000000144 <gets>:

char*
gets(char *buf, int max)
{
 144:	711d                	add	sp,sp,-96
 146:	ec86                	sd	ra,88(sp)
 148:	e8a2                	sd	s0,80(sp)
 14a:	e4a6                	sd	s1,72(sp)
 14c:	e0ca                	sd	s2,64(sp)
 14e:	fc4e                	sd	s3,56(sp)
 150:	f852                	sd	s4,48(sp)
 152:	f456                	sd	s5,40(sp)
 154:	f05a                	sd	s6,32(sp)
 156:	ec5e                	sd	s7,24(sp)
 158:	1080                	add	s0,sp,96
 15a:	8baa                	mv	s7,a0
 15c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 15e:	892a                	mv	s2,a0
 160:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 162:	4aa9                	li	s5,10
 164:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 166:	89a6                	mv	s3,s1
 168:	2485                	addw	s1,s1,1
 16a:	0344d663          	bge	s1,s4,196 <gets+0x52>
    cc = read(0, &c, 1);
 16e:	4605                	li	a2,1
 170:	faf40593          	add	a1,s0,-81
 174:	4501                	li	a0,0
 176:	402000ef          	jal	578 <read>
    if(cc < 1)
 17a:	00a05e63          	blez	a0,196 <gets+0x52>
    buf[i++] = c;
 17e:	faf44783          	lbu	a5,-81(s0)
 182:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 186:	01578763          	beq	a5,s5,194 <gets+0x50>
 18a:	0905                	add	s2,s2,1
 18c:	fd679de3          	bne	a5,s6,166 <gets+0x22>
    buf[i++] = c;
 190:	89a6                	mv	s3,s1
 192:	a011                	j	196 <gets+0x52>
 194:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 196:	99de                	add	s3,s3,s7
 198:	00098023          	sb	zero,0(s3)
  return buf;
}
 19c:	855e                	mv	a0,s7
 19e:	60e6                	ld	ra,88(sp)
 1a0:	6446                	ld	s0,80(sp)
 1a2:	64a6                	ld	s1,72(sp)
 1a4:	6906                	ld	s2,64(sp)
 1a6:	79e2                	ld	s3,56(sp)
 1a8:	7a42                	ld	s4,48(sp)
 1aa:	7aa2                	ld	s5,40(sp)
 1ac:	7b02                	ld	s6,32(sp)
 1ae:	6be2                	ld	s7,24(sp)
 1b0:	6125                	add	sp,sp,96
 1b2:	8082                	ret

00000000000001b4 <stat>:

int
stat(const char *n, struct stat *st)
{
 1b4:	1101                	add	sp,sp,-32
 1b6:	ec06                	sd	ra,24(sp)
 1b8:	e822                	sd	s0,16(sp)
 1ba:	e04a                	sd	s2,0(sp)
 1bc:	1000                	add	s0,sp,32
 1be:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1c0:	4581                	li	a1,0
 1c2:	3de000ef          	jal	5a0 <open>
  if(fd < 0)
 1c6:	02054263          	bltz	a0,1ea <stat+0x36>
 1ca:	e426                	sd	s1,8(sp)
 1cc:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1ce:	85ca                	mv	a1,s2
 1d0:	3e8000ef          	jal	5b8 <fstat>
 1d4:	892a                	mv	s2,a0
  close(fd);
 1d6:	8526                	mv	a0,s1
 1d8:	3b0000ef          	jal	588 <close>
  return r;
 1dc:	64a2                	ld	s1,8(sp)
}
 1de:	854a                	mv	a0,s2
 1e0:	60e2                	ld	ra,24(sp)
 1e2:	6442                	ld	s0,16(sp)
 1e4:	6902                	ld	s2,0(sp)
 1e6:	6105                	add	sp,sp,32
 1e8:	8082                	ret
    return -1;
 1ea:	597d                	li	s2,-1
 1ec:	bfcd                	j	1de <stat+0x2a>

00000000000001ee <atoi>:

int
atoi(const char *s)
{
 1ee:	1141                	add	sp,sp,-16
 1f0:	e422                	sd	s0,8(sp)
 1f2:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1f4:	00054683          	lbu	a3,0(a0)
 1f8:	fd06879b          	addw	a5,a3,-48
 1fc:	0ff7f793          	zext.b	a5,a5
 200:	4625                	li	a2,9
 202:	02f66863          	bltu	a2,a5,232 <atoi+0x44>
 206:	872a                	mv	a4,a0
  n = 0;
 208:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 20a:	0705                	add	a4,a4,1
 20c:	0025179b          	sllw	a5,a0,0x2
 210:	9fa9                	addw	a5,a5,a0
 212:	0017979b          	sllw	a5,a5,0x1
 216:	9fb5                	addw	a5,a5,a3
 218:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 21c:	00074683          	lbu	a3,0(a4)
 220:	fd06879b          	addw	a5,a3,-48
 224:	0ff7f793          	zext.b	a5,a5
 228:	fef671e3          	bgeu	a2,a5,20a <atoi+0x1c>
  return n;
}
 22c:	6422                	ld	s0,8(sp)
 22e:	0141                	add	sp,sp,16
 230:	8082                	ret
  n = 0;
 232:	4501                	li	a0,0
 234:	bfe5                	j	22c <atoi+0x3e>

0000000000000236 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 236:	1141                	add	sp,sp,-16
 238:	e422                	sd	s0,8(sp)
 23a:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 23c:	02b57463          	bgeu	a0,a1,264 <memmove+0x2e>
    while(n-- > 0)
 240:	00c05f63          	blez	a2,25e <memmove+0x28>
 244:	1602                	sll	a2,a2,0x20
 246:	9201                	srl	a2,a2,0x20
 248:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 24c:	872a                	mv	a4,a0
      *dst++ = *src++;
 24e:	0585                	add	a1,a1,1
 250:	0705                	add	a4,a4,1
 252:	fff5c683          	lbu	a3,-1(a1)
 256:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 25a:	fef71ae3          	bne	a4,a5,24e <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 25e:	6422                	ld	s0,8(sp)
 260:	0141                	add	sp,sp,16
 262:	8082                	ret
    dst += n;
 264:	00c50733          	add	a4,a0,a2
    src += n;
 268:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 26a:	fec05ae3          	blez	a2,25e <memmove+0x28>
 26e:	fff6079b          	addw	a5,a2,-1
 272:	1782                	sll	a5,a5,0x20
 274:	9381                	srl	a5,a5,0x20
 276:	fff7c793          	not	a5,a5
 27a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 27c:	15fd                	add	a1,a1,-1
 27e:	177d                	add	a4,a4,-1
 280:	0005c683          	lbu	a3,0(a1)
 284:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 288:	fee79ae3          	bne	a5,a4,27c <memmove+0x46>
 28c:	bfc9                	j	25e <memmove+0x28>

000000000000028e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 28e:	1141                	add	sp,sp,-16
 290:	e422                	sd	s0,8(sp)
 292:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 294:	ca05                	beqz	a2,2c4 <memcmp+0x36>
 296:	fff6069b          	addw	a3,a2,-1
 29a:	1682                	sll	a3,a3,0x20
 29c:	9281                	srl	a3,a3,0x20
 29e:	0685                	add	a3,a3,1
 2a0:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2a2:	00054783          	lbu	a5,0(a0)
 2a6:	0005c703          	lbu	a4,0(a1)
 2aa:	00e79863          	bne	a5,a4,2ba <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2ae:	0505                	add	a0,a0,1
    p2++;
 2b0:	0585                	add	a1,a1,1
  while (n-- > 0) {
 2b2:	fed518e3          	bne	a0,a3,2a2 <memcmp+0x14>
  }
  return 0;
 2b6:	4501                	li	a0,0
 2b8:	a019                	j	2be <memcmp+0x30>
      return *p1 - *p2;
 2ba:	40e7853b          	subw	a0,a5,a4
}
 2be:	6422                	ld	s0,8(sp)
 2c0:	0141                	add	sp,sp,16
 2c2:	8082                	ret
  return 0;
 2c4:	4501                	li	a0,0
 2c6:	bfe5                	j	2be <memcmp+0x30>

00000000000002c8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2c8:	1141                	add	sp,sp,-16
 2ca:	e406                	sd	ra,8(sp)
 2cc:	e022                	sd	s0,0(sp)
 2ce:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 2d0:	f67ff0ef          	jal	236 <memmove>
}
 2d4:	60a2                	ld	ra,8(sp)
 2d6:	6402                	ld	s0,0(sp)
 2d8:	0141                	add	sp,sp,16
 2da:	8082                	ret

00000000000002dc <htons>:
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
}

uint16_t
htons(uint16_t h)
{
 2dc:	1141                	add	sp,sp,-16
 2de:	e422                	sd	s0,8(sp)
 2e0:	0800                	add	s0,sp,16
    if (!endian) {
 2e2:	00001797          	auipc	a5,0x1
 2e6:	d1e7a783          	lw	a5,-738(a5) # 1000 <endian>
 2ea:	e385                	bnez	a5,30a <htons+0x2e>
        endian = byteorder();
 2ec:	4d200793          	li	a5,1234
 2f0:	00001717          	auipc	a4,0x1
 2f4:	d0f72823          	sw	a5,-752(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 2f8:	0085179b          	sllw	a5,a0,0x8
 2fc:	0085551b          	srlw	a0,a0,0x8
 300:	8fc9                	or	a5,a5,a0
 302:	03079513          	sll	a0,a5,0x30
 306:	9141                	srl	a0,a0,0x30
 308:	a029                	j	312 <htons+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(h) : h;
 30a:	4d200713          	li	a4,1234
 30e:	fee785e3          	beq	a5,a4,2f8 <htons+0x1c>
}
 312:	6422                	ld	s0,8(sp)
 314:	0141                	add	sp,sp,16
 316:	8082                	ret

0000000000000318 <ntohs>:

uint16_t
ntohs(uint16_t n)
{
 318:	1141                	add	sp,sp,-16
 31a:	e422                	sd	s0,8(sp)
 31c:	0800                	add	s0,sp,16
    if (!endian) {
 31e:	00001797          	auipc	a5,0x1
 322:	ce27a783          	lw	a5,-798(a5) # 1000 <endian>
 326:	e385                	bnez	a5,346 <ntohs+0x2e>
        endian = byteorder();
 328:	4d200793          	li	a5,1234
 32c:	00001717          	auipc	a4,0x1
 330:	ccf72a23          	sw	a5,-812(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 334:	0085179b          	sllw	a5,a0,0x8
 338:	0085551b          	srlw	a0,a0,0x8
 33c:	8fc9                	or	a5,a5,a0
 33e:	03079513          	sll	a0,a5,0x30
 342:	9141                	srl	a0,a0,0x30
 344:	a029                	j	34e <ntohs+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(n) : n;
 346:	4d200713          	li	a4,1234
 34a:	fee785e3          	beq	a5,a4,334 <ntohs+0x1c>
}
 34e:	6422                	ld	s0,8(sp)
 350:	0141                	add	sp,sp,16
 352:	8082                	ret

0000000000000354 <htonl>:

uint32_t
htonl(uint32_t h)
{
 354:	1141                	add	sp,sp,-16
 356:	e422                	sd	s0,8(sp)
 358:	0800                	add	s0,sp,16
    if (!endian) {
 35a:	00001797          	auipc	a5,0x1
 35e:	ca67a783          	lw	a5,-858(a5) # 1000 <endian>
 362:	ef85                	bnez	a5,39a <htonl+0x46>
        endian = byteorder();
 364:	4d200793          	li	a5,1234
 368:	00001717          	auipc	a4,0x1
 36c:	c8f72c23          	sw	a5,-872(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 370:	0185179b          	sllw	a5,a0,0x18
 374:	0185571b          	srlw	a4,a0,0x18
 378:	8fd9                	or	a5,a5,a4
 37a:	0085171b          	sllw	a4,a0,0x8
 37e:	00ff06b7          	lui	a3,0xff0
 382:	8f75                	and	a4,a4,a3
 384:	8fd9                	or	a5,a5,a4
 386:	0085551b          	srlw	a0,a0,0x8
 38a:	6741                	lui	a4,0x10
 38c:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeef0>
 390:	8d79                	and	a0,a0,a4
 392:	8fc9                	or	a5,a5,a0
 394:	0007851b          	sext.w	a0,a5
 398:	a029                	j	3a2 <htonl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(h) : h;
 39a:	4d200713          	li	a4,1234
 39e:	fce789e3          	beq	a5,a4,370 <htonl+0x1c>
}
 3a2:	6422                	ld	s0,8(sp)
 3a4:	0141                	add	sp,sp,16
 3a6:	8082                	ret

00000000000003a8 <ntohl>:

uint32_t
ntohl(uint32_t n)
{
 3a8:	1141                	add	sp,sp,-16
 3aa:	e422                	sd	s0,8(sp)
 3ac:	0800                	add	s0,sp,16
    if (!endian) {
 3ae:	00001797          	auipc	a5,0x1
 3b2:	c527a783          	lw	a5,-942(a5) # 1000 <endian>
 3b6:	ef85                	bnez	a5,3ee <ntohl+0x46>
        endian = byteorder();
 3b8:	4d200793          	li	a5,1234
 3bc:	00001717          	auipc	a4,0x1
 3c0:	c4f72223          	sw	a5,-956(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 3c4:	0185179b          	sllw	a5,a0,0x18
 3c8:	0185571b          	srlw	a4,a0,0x18
 3cc:	8fd9                	or	a5,a5,a4
 3ce:	0085171b          	sllw	a4,a0,0x8
 3d2:	00ff06b7          	lui	a3,0xff0
 3d6:	8f75                	and	a4,a4,a3
 3d8:	8fd9                	or	a5,a5,a4
 3da:	0085551b          	srlw	a0,a0,0x8
 3de:	6741                	lui	a4,0x10
 3e0:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeef0>
 3e4:	8d79                	and	a0,a0,a4
 3e6:	8fc9                	or	a5,a5,a0
 3e8:	0007851b          	sext.w	a0,a5
 3ec:	a029                	j	3f6 <ntohl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(n) : n;
 3ee:	4d200713          	li	a4,1234
 3f2:	fce789e3          	beq	a5,a4,3c4 <ntohl+0x1c>
}
 3f6:	6422                	ld	s0,8(sp)
 3f8:	0141                	add	sp,sp,16
 3fa:	8082                	ret

00000000000003fc <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
 3fc:	1141                	add	sp,sp,-16
 3fe:	e422                	sd	s0,8(sp)
 400:	0800                	add	s0,sp,16
 402:	872a                	mv	a4,a0
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
 404:	02000693          	li	a3,32
 408:	4525                	li	a0,9
 40a:	a011                	j	40e <strtol+0x12>
        s++;
 40c:	0705                	add	a4,a4,1
    while (*s == ' ' || *s == '\t')
 40e:	00074783          	lbu	a5,0(a4)
 412:	fed78de3          	beq	a5,a3,40c <strtol+0x10>
 416:	fea78be3          	beq	a5,a0,40c <strtol+0x10>

    // plus/minus sign
    if (*s == '+')
 41a:	02b00693          	li	a3,43
 41e:	02d78663          	beq	a5,a3,44a <strtol+0x4e>
        s++;
    else if (*s == '-')
 422:	02d00693          	li	a3,45
    int neg = 0;
 426:	4301                	li	t1,0
    else if (*s == '-')
 428:	02d78463          	beq	a5,a3,450 <strtol+0x54>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 42c:	fef67793          	and	a5,a2,-17
 430:	eb89                	bnez	a5,442 <strtol+0x46>
 432:	00074683          	lbu	a3,0(a4)
 436:	03000793          	li	a5,48
 43a:	00f68e63          	beq	a3,a5,456 <strtol+0x5a>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
 43e:	e211                	bnez	a2,442 <strtol+0x46>
        s++, base = 8;
    else if (base == 0)
        base = 10;
 440:	4629                	li	a2,10
 442:	4501                	li	a0,0

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
 444:	4825                	li	a6,9
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
 446:	48e5                	li	a7,25
 448:	a825                	j	480 <strtol+0x84>
        s++;
 44a:	0705                	add	a4,a4,1
    int neg = 0;
 44c:	4301                	li	t1,0
 44e:	bff9                	j	42c <strtol+0x30>
        s++, neg = 1;
 450:	0705                	add	a4,a4,1
 452:	4305                	li	t1,1
 454:	bfe1                	j	42c <strtol+0x30>
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 456:	00174683          	lbu	a3,1(a4)
 45a:	07800793          	li	a5,120
 45e:	00f68663          	beq	a3,a5,46a <strtol+0x6e>
    else if (base == 0 && s[0] == '0')
 462:	f265                	bnez	a2,442 <strtol+0x46>
        s++, base = 8;
 464:	0705                	add	a4,a4,1
 466:	4621                	li	a2,8
 468:	bfe9                	j	442 <strtol+0x46>
        s += 2, base = 16;
 46a:	0709                	add	a4,a4,2
 46c:	4641                	li	a2,16
 46e:	bfd1                	j	442 <strtol+0x46>
            dig = *s - '0';
 470:	fd07879b          	addw	a5,a5,-48
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
 474:	04c7d063          	bge	a5,a2,4b4 <strtol+0xb8>
            break;
        s++, val = (val * base) + dig;
 478:	0705                	add	a4,a4,1
 47a:	02a60533          	mul	a0,a2,a0
 47e:	953e                	add	a0,a0,a5
        if (*s >= '0' && *s <= '9')
 480:	00074783          	lbu	a5,0(a4)
 484:	fd07869b          	addw	a3,a5,-48
 488:	0ff6f693          	zext.b	a3,a3
 48c:	fed872e3          	bgeu	a6,a3,470 <strtol+0x74>
        else if (*s >= 'a' && *s <= 'z')
 490:	f9f7869b          	addw	a3,a5,-97
 494:	0ff6f693          	zext.b	a3,a3
 498:	00d8e563          	bltu	a7,a3,4a2 <strtol+0xa6>
            dig = *s - 'a' + 10;
 49c:	fa97879b          	addw	a5,a5,-87
 4a0:	bfd1                	j	474 <strtol+0x78>
        else if (*s >= 'A' && *s <= 'Z')
 4a2:	fbf7869b          	addw	a3,a5,-65
 4a6:	0ff6f693          	zext.b	a3,a3
 4aa:	00d8e563          	bltu	a7,a3,4b4 <strtol+0xb8>
            dig = *s - 'A' + 10;
 4ae:	fc97879b          	addw	a5,a5,-55
 4b2:	b7c9                	j	474 <strtol+0x78>
        // we don't properly detect overflow!
    }

    if (endptr)
 4b4:	c191                	beqz	a1,4b8 <strtol+0xbc>
        *endptr = (char *) s;
 4b6:	e198                	sd	a4,0(a1)
    return (neg ? -val : val);
 4b8:	00030463          	beqz	t1,4c0 <strtol+0xc4>
 4bc:	40a00533          	neg	a0,a0
}
 4c0:	6422                	ld	s0,8(sp)
 4c2:	0141                	add	sp,sp,16
 4c4:	8082                	ret

00000000000004c6 <inet_pton>:
inet_pton (int family, const char *p, void *n) {
    char *sp, *ep;
    int idx;
    long ret;

    if (family != AF_INET) {
 4c6:	4785                	li	a5,1
 4c8:	08f51063          	bne	a0,a5,548 <inet_pton+0x82>
inet_pton (int family, const char *p, void *n) {
 4cc:	715d                	add	sp,sp,-80
 4ce:	e486                	sd	ra,72(sp)
 4d0:	e0a2                	sd	s0,64(sp)
 4d2:	fc26                	sd	s1,56(sp)
 4d4:	f84a                	sd	s2,48(sp)
 4d6:	f44e                	sd	s3,40(sp)
 4d8:	f052                	sd	s4,32(sp)
 4da:	ec56                	sd	s5,24(sp)
 4dc:	e85a                	sd	s6,16(sp)
 4de:	0880                	add	s0,sp,80
 4e0:	84ae                	mv	s1,a1
 4e2:	89b2                	mv	s3,a2
 4e4:	4901                	li	s2,0
        return -1;
    }
    sp = (char *)p;
    for (idx = 0; idx < 4; idx++) {
        ret = strtol(sp, &ep, 10);
        if (ret < 0 || ret > 255) {
 4e6:	0ff00a13          	li	s4,255
            return -1;
        }
        if (ep == sp) {
            return -1;
        }
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 4ea:	4a8d                	li	s5,3
 4ec:	02e00b13          	li	s6,46
 4f0:	a805                	j	520 <inet_pton+0x5a>
 4f2:	0007c783          	lbu	a5,0(a5)
 4f6:	efb9                	bnez	a5,554 <inet_pton+0x8e>
            return -1;
        }
        ((uint8_t *)n)[idx] = ret;
 4f8:	00a981a3          	sb	a0,3(s3)
        sp = ep + 1;
    }
    return 0;
 4fc:	4501                	li	a0,0
}
 4fe:	60a6                	ld	ra,72(sp)
 500:	6406                	ld	s0,64(sp)
 502:	74e2                	ld	s1,56(sp)
 504:	7942                	ld	s2,48(sp)
 506:	79a2                	ld	s3,40(sp)
 508:	7a02                	ld	s4,32(sp)
 50a:	6ae2                	ld	s5,24(sp)
 50c:	6b42                	ld	s6,16(sp)
 50e:	6161                	add	sp,sp,80
 510:	8082                	ret
        ((uint8_t *)n)[idx] = ret;
 512:	01298733          	add	a4,s3,s2
 516:	00a70023          	sb	a0,0(a4)
        sp = ep + 1;
 51a:	00178493          	add	s1,a5,1
    for (idx = 0; idx < 4; idx++) {
 51e:	0905                	add	s2,s2,1
        ret = strtol(sp, &ep, 10);
 520:	4629                	li	a2,10
 522:	fb840593          	add	a1,s0,-72
 526:	8526                	mv	a0,s1
 528:	ed5ff0ef          	jal	3fc <strtol>
        if (ret < 0 || ret > 255) {
 52c:	02aa6063          	bltu	s4,a0,54c <inet_pton+0x86>
        if (ep == sp) {
 530:	fb843783          	ld	a5,-72(s0)
 534:	00978e63          	beq	a5,s1,550 <inet_pton+0x8a>
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 538:	fb590de3          	beq	s2,s5,4f2 <inet_pton+0x2c>
 53c:	0007c703          	lbu	a4,0(a5)
 540:	fd6709e3          	beq	a4,s6,512 <inet_pton+0x4c>
            return -1;
 544:	557d                	li	a0,-1
 546:	bf65                	j	4fe <inet_pton+0x38>
        return -1;
 548:	557d                	li	a0,-1
}
 54a:	8082                	ret
            return -1;
 54c:	557d                	li	a0,-1
 54e:	bf45                	j	4fe <inet_pton+0x38>
            return -1;
 550:	557d                	li	a0,-1
 552:	b775                	j	4fe <inet_pton+0x38>
            return -1;
 554:	557d                	li	a0,-1
 556:	b765                	j	4fe <inet_pton+0x38>

0000000000000558 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 558:	4885                	li	a7,1
 ecall
 55a:	00000073          	ecall
 ret
 55e:	8082                	ret

0000000000000560 <exit>:
.global exit
exit:
 li a7, SYS_exit
 560:	4889                	li	a7,2
 ecall
 562:	00000073          	ecall
 ret
 566:	8082                	ret

0000000000000568 <wait>:
.global wait
wait:
 li a7, SYS_wait
 568:	488d                	li	a7,3
 ecall
 56a:	00000073          	ecall
 ret
 56e:	8082                	ret

0000000000000570 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 570:	4891                	li	a7,4
 ecall
 572:	00000073          	ecall
 ret
 576:	8082                	ret

0000000000000578 <read>:
.global read
read:
 li a7, SYS_read
 578:	4895                	li	a7,5
 ecall
 57a:	00000073          	ecall
 ret
 57e:	8082                	ret

0000000000000580 <write>:
.global write
write:
 li a7, SYS_write
 580:	48c1                	li	a7,16
 ecall
 582:	00000073          	ecall
 ret
 586:	8082                	ret

0000000000000588 <close>:
.global close
close:
 li a7, SYS_close
 588:	48d5                	li	a7,21
 ecall
 58a:	00000073          	ecall
 ret
 58e:	8082                	ret

0000000000000590 <kill>:
.global kill
kill:
 li a7, SYS_kill
 590:	4899                	li	a7,6
 ecall
 592:	00000073          	ecall
 ret
 596:	8082                	ret

0000000000000598 <exec>:
.global exec
exec:
 li a7, SYS_exec
 598:	489d                	li	a7,7
 ecall
 59a:	00000073          	ecall
 ret
 59e:	8082                	ret

00000000000005a0 <open>:
.global open
open:
 li a7, SYS_open
 5a0:	48bd                	li	a7,15
 ecall
 5a2:	00000073          	ecall
 ret
 5a6:	8082                	ret

00000000000005a8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5a8:	48c5                	li	a7,17
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5b0:	48c9                	li	a7,18
 ecall
 5b2:	00000073          	ecall
 ret
 5b6:	8082                	ret

00000000000005b8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5b8:	48a1                	li	a7,8
 ecall
 5ba:	00000073          	ecall
 ret
 5be:	8082                	ret

00000000000005c0 <link>:
.global link
link:
 li a7, SYS_link
 5c0:	48cd                	li	a7,19
 ecall
 5c2:	00000073          	ecall
 ret
 5c6:	8082                	ret

00000000000005c8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5c8:	48d1                	li	a7,20
 ecall
 5ca:	00000073          	ecall
 ret
 5ce:	8082                	ret

00000000000005d0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5d0:	48a5                	li	a7,9
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <dup>:
.global dup
dup:
 li a7, SYS_dup
 5d8:	48a9                	li	a7,10
 ecall
 5da:	00000073          	ecall
 ret
 5de:	8082                	ret

00000000000005e0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5e0:	48ad                	li	a7,11
 ecall
 5e2:	00000073          	ecall
 ret
 5e6:	8082                	ret

00000000000005e8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5e8:	48b1                	li	a7,12
 ecall
 5ea:	00000073          	ecall
 ret
 5ee:	8082                	ret

00000000000005f0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5f0:	48b5                	li	a7,13
 ecall
 5f2:	00000073          	ecall
 ret
 5f6:	8082                	ret

00000000000005f8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5f8:	48b9                	li	a7,14
 ecall
 5fa:	00000073          	ecall
 ret
 5fe:	8082                	ret

0000000000000600 <socket>:
.global socket
socket:
 li a7, SYS_socket
 600:	48d9                	li	a7,22
 ecall
 602:	00000073          	ecall
 ret
 606:	8082                	ret

0000000000000608 <bind>:
.global bind
bind:
 li a7, SYS_bind
 608:	48dd                	li	a7,23
 ecall
 60a:	00000073          	ecall
 ret
 60e:	8082                	ret

0000000000000610 <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 610:	48e1                	li	a7,24
 ecall
 612:	00000073          	ecall
 ret
 616:	8082                	ret

0000000000000618 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 618:	48e5                	li	a7,25
 ecall
 61a:	00000073          	ecall
 ret
 61e:	8082                	ret

0000000000000620 <connect>:
.global connect
connect:
 li a7, SYS_connect
 620:	48e9                	li	a7,26
 ecall
 622:	00000073          	ecall
 ret
 626:	8082                	ret

0000000000000628 <listen>:
.global listen
listen:
 li a7, SYS_listen
 628:	48ed                	li	a7,27
 ecall
 62a:	00000073          	ecall
 ret
 62e:	8082                	ret

0000000000000630 <accept>:
.global accept
accept:
 li a7, SYS_accept
 630:	48f1                	li	a7,28
 ecall
 632:	00000073          	ecall
 ret
 636:	8082                	ret

0000000000000638 <recv>:
.global recv
recv:
 li a7, SYS_recv
 638:	48f5                	li	a7,29
 ecall
 63a:	00000073          	ecall
 ret
 63e:	8082                	ret

0000000000000640 <send>:
.global send
send:
 li a7, SYS_send
 640:	48f9                	li	a7,30
 ecall
 642:	00000073          	ecall
 ret
 646:	8082                	ret

0000000000000648 <ioctl>:
.global ioctl
ioctl:
 li a7, SYS_ioctl
 648:	48fd                	li	a7,31
 ecall
 64a:	00000073          	ecall
 ret
 64e:	8082                	ret

0000000000000650 <consolemode>:
.global consolemode
consolemode:
 li a7, SYS_consolemode
 650:	02000893          	li	a7,32
 ecall
 654:	00000073          	ecall
 ret
 658:	8082                	ret

000000000000065a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 65a:	1101                	add	sp,sp,-32
 65c:	ec06                	sd	ra,24(sp)
 65e:	e822                	sd	s0,16(sp)
 660:	1000                	add	s0,sp,32
 662:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 666:	4605                	li	a2,1
 668:	fef40593          	add	a1,s0,-17
 66c:	f15ff0ef          	jal	580 <write>
}
 670:	60e2                	ld	ra,24(sp)
 672:	6442                	ld	s0,16(sp)
 674:	6105                	add	sp,sp,32
 676:	8082                	ret

0000000000000678 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 678:	715d                	add	sp,sp,-80
 67a:	e486                	sd	ra,72(sp)
 67c:	e0a2                	sd	s0,64(sp)
 67e:	fc26                	sd	s1,56(sp)
 680:	0880                	add	s0,sp,80
 682:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 684:	c299                	beqz	a3,68a <printint+0x12>
 686:	0805c963          	bltz	a1,718 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 68a:	2581                	sext.w	a1,a1
  neg = 0;
 68c:	4881                	li	a7,0
 68e:	fb840693          	add	a3,s0,-72
  }

  i = 0;
 692:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 694:	2601                	sext.w	a2,a2
 696:	00000517          	auipc	a0,0x0
 69a:	51250513          	add	a0,a0,1298 # ba8 <digits>
 69e:	883a                	mv	a6,a4
 6a0:	2705                	addw	a4,a4,1
 6a2:	02c5f7bb          	remuw	a5,a1,a2
 6a6:	1782                	sll	a5,a5,0x20
 6a8:	9381                	srl	a5,a5,0x20
 6aa:	97aa                	add	a5,a5,a0
 6ac:	0007c783          	lbu	a5,0(a5)
 6b0:	00f68023          	sb	a5,0(a3) # ff0000 <base+0xfeeff0>
  }while((x /= base) != 0);
 6b4:	0005879b          	sext.w	a5,a1
 6b8:	02c5d5bb          	divuw	a1,a1,a2
 6bc:	0685                	add	a3,a3,1
 6be:	fec7f0e3          	bgeu	a5,a2,69e <printint+0x26>
  if(neg)
 6c2:	00088c63          	beqz	a7,6da <printint+0x62>
    buf[i++] = '-';
 6c6:	fd070793          	add	a5,a4,-48
 6ca:	00878733          	add	a4,a5,s0
 6ce:	02d00793          	li	a5,45
 6d2:	fef70423          	sb	a5,-24(a4)
 6d6:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 6da:	02e05a63          	blez	a4,70e <printint+0x96>
 6de:	f84a                	sd	s2,48(sp)
 6e0:	f44e                	sd	s3,40(sp)
 6e2:	fb840793          	add	a5,s0,-72
 6e6:	00e78933          	add	s2,a5,a4
 6ea:	fff78993          	add	s3,a5,-1
 6ee:	99ba                	add	s3,s3,a4
 6f0:	377d                	addw	a4,a4,-1
 6f2:	1702                	sll	a4,a4,0x20
 6f4:	9301                	srl	a4,a4,0x20
 6f6:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 6fa:	fff94583          	lbu	a1,-1(s2)
 6fe:	8526                	mv	a0,s1
 700:	f5bff0ef          	jal	65a <putc>
  while(--i >= 0)
 704:	197d                	add	s2,s2,-1
 706:	ff391ae3          	bne	s2,s3,6fa <printint+0x82>
 70a:	7942                	ld	s2,48(sp)
 70c:	79a2                	ld	s3,40(sp)
}
 70e:	60a6                	ld	ra,72(sp)
 710:	6406                	ld	s0,64(sp)
 712:	74e2                	ld	s1,56(sp)
 714:	6161                	add	sp,sp,80
 716:	8082                	ret
    x = -xx;
 718:	40b005bb          	negw	a1,a1
    neg = 1;
 71c:	4885                	li	a7,1
    x = -xx;
 71e:	bf85                	j	68e <printint+0x16>

0000000000000720 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 720:	711d                	add	sp,sp,-96
 722:	ec86                	sd	ra,88(sp)
 724:	e8a2                	sd	s0,80(sp)
 726:	e0ca                	sd	s2,64(sp)
 728:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 72a:	0005c903          	lbu	s2,0(a1)
 72e:	26090863          	beqz	s2,99e <vprintf+0x27e>
 732:	e4a6                	sd	s1,72(sp)
 734:	fc4e                	sd	s3,56(sp)
 736:	f852                	sd	s4,48(sp)
 738:	f456                	sd	s5,40(sp)
 73a:	f05a                	sd	s6,32(sp)
 73c:	ec5e                	sd	s7,24(sp)
 73e:	e862                	sd	s8,16(sp)
 740:	e466                	sd	s9,8(sp)
 742:	8b2a                	mv	s6,a0
 744:	8a2e                	mv	s4,a1
 746:	8bb2                	mv	s7,a2
  state = 0;
 748:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 74a:	4481                	li	s1,0
 74c:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 74e:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 752:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 756:	06c00c93          	li	s9,108
 75a:	a005                	j	77a <vprintf+0x5a>
        putc(fd, c0);
 75c:	85ca                	mv	a1,s2
 75e:	855a                	mv	a0,s6
 760:	efbff0ef          	jal	65a <putc>
 764:	a019                	j	76a <vprintf+0x4a>
    } else if(state == '%'){
 766:	03598263          	beq	s3,s5,78a <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 76a:	2485                	addw	s1,s1,1
 76c:	8726                	mv	a4,s1
 76e:	009a07b3          	add	a5,s4,s1
 772:	0007c903          	lbu	s2,0(a5)
 776:	20090c63          	beqz	s2,98e <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 77a:	0009079b          	sext.w	a5,s2
    if(state == 0){
 77e:	fe0994e3          	bnez	s3,766 <vprintf+0x46>
      if(c0 == '%'){
 782:	fd579de3          	bne	a5,s5,75c <vprintf+0x3c>
        state = '%';
 786:	89be                	mv	s3,a5
 788:	b7cd                	j	76a <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 78a:	00ea06b3          	add	a3,s4,a4
 78e:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 792:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 794:	c681                	beqz	a3,79c <vprintf+0x7c>
 796:	9752                	add	a4,a4,s4
 798:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 79c:	03878f63          	beq	a5,s8,7da <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 7a0:	05978963          	beq	a5,s9,7f2 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 7a4:	07500713          	li	a4,117
 7a8:	0ee78363          	beq	a5,a4,88e <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 7ac:	07800713          	li	a4,120
 7b0:	12e78563          	beq	a5,a4,8da <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 7b4:	07000713          	li	a4,112
 7b8:	14e78a63          	beq	a5,a4,90c <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 7bc:	07300713          	li	a4,115
 7c0:	18e78a63          	beq	a5,a4,954 <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 7c4:	02500713          	li	a4,37
 7c8:	04e79563          	bne	a5,a4,812 <vprintf+0xf2>
        putc(fd, '%');
 7cc:	02500593          	li	a1,37
 7d0:	855a                	mv	a0,s6
 7d2:	e89ff0ef          	jal	65a <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 7d6:	4981                	li	s3,0
 7d8:	bf49                	j	76a <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 7da:	008b8913          	add	s2,s7,8
 7de:	4685                	li	a3,1
 7e0:	4629                	li	a2,10
 7e2:	000ba583          	lw	a1,0(s7)
 7e6:	855a                	mv	a0,s6
 7e8:	e91ff0ef          	jal	678 <printint>
 7ec:	8bca                	mv	s7,s2
      state = 0;
 7ee:	4981                	li	s3,0
 7f0:	bfad                	j	76a <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 7f2:	06400793          	li	a5,100
 7f6:	02f68963          	beq	a3,a5,828 <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 7fa:	06c00793          	li	a5,108
 7fe:	04f68263          	beq	a3,a5,842 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 802:	07500793          	li	a5,117
 806:	0af68063          	beq	a3,a5,8a6 <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 80a:	07800793          	li	a5,120
 80e:	0ef68263          	beq	a3,a5,8f2 <vprintf+0x1d2>
        putc(fd, '%');
 812:	02500593          	li	a1,37
 816:	855a                	mv	a0,s6
 818:	e43ff0ef          	jal	65a <putc>
        putc(fd, c0);
 81c:	85ca                	mv	a1,s2
 81e:	855a                	mv	a0,s6
 820:	e3bff0ef          	jal	65a <putc>
      state = 0;
 824:	4981                	li	s3,0
 826:	b791                	j	76a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 828:	008b8913          	add	s2,s7,8
 82c:	4685                	li	a3,1
 82e:	4629                	li	a2,10
 830:	000bb583          	ld	a1,0(s7)
 834:	855a                	mv	a0,s6
 836:	e43ff0ef          	jal	678 <printint>
        i += 1;
 83a:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 83c:	8bca                	mv	s7,s2
      state = 0;
 83e:	4981                	li	s3,0
        i += 1;
 840:	b72d                	j	76a <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 842:	06400793          	li	a5,100
 846:	02f60763          	beq	a2,a5,874 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 84a:	07500793          	li	a5,117
 84e:	06f60963          	beq	a2,a5,8c0 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 852:	07800793          	li	a5,120
 856:	faf61ee3          	bne	a2,a5,812 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 85a:	008b8913          	add	s2,s7,8
 85e:	4681                	li	a3,0
 860:	4641                	li	a2,16
 862:	000bb583          	ld	a1,0(s7)
 866:	855a                	mv	a0,s6
 868:	e11ff0ef          	jal	678 <printint>
        i += 2;
 86c:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 86e:	8bca                	mv	s7,s2
      state = 0;
 870:	4981                	li	s3,0
        i += 2;
 872:	bde5                	j	76a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 874:	008b8913          	add	s2,s7,8
 878:	4685                	li	a3,1
 87a:	4629                	li	a2,10
 87c:	000bb583          	ld	a1,0(s7)
 880:	855a                	mv	a0,s6
 882:	df7ff0ef          	jal	678 <printint>
        i += 2;
 886:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 888:	8bca                	mv	s7,s2
      state = 0;
 88a:	4981                	li	s3,0
        i += 2;
 88c:	bdf9                	j	76a <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 88e:	008b8913          	add	s2,s7,8
 892:	4681                	li	a3,0
 894:	4629                	li	a2,10
 896:	000ba583          	lw	a1,0(s7)
 89a:	855a                	mv	a0,s6
 89c:	dddff0ef          	jal	678 <printint>
 8a0:	8bca                	mv	s7,s2
      state = 0;
 8a2:	4981                	li	s3,0
 8a4:	b5d9                	j	76a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8a6:	008b8913          	add	s2,s7,8
 8aa:	4681                	li	a3,0
 8ac:	4629                	li	a2,10
 8ae:	000bb583          	ld	a1,0(s7)
 8b2:	855a                	mv	a0,s6
 8b4:	dc5ff0ef          	jal	678 <printint>
        i += 1;
 8b8:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 8ba:	8bca                	mv	s7,s2
      state = 0;
 8bc:	4981                	li	s3,0
        i += 1;
 8be:	b575                	j	76a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8c0:	008b8913          	add	s2,s7,8
 8c4:	4681                	li	a3,0
 8c6:	4629                	li	a2,10
 8c8:	000bb583          	ld	a1,0(s7)
 8cc:	855a                	mv	a0,s6
 8ce:	dabff0ef          	jal	678 <printint>
        i += 2;
 8d2:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 8d4:	8bca                	mv	s7,s2
      state = 0;
 8d6:	4981                	li	s3,0
        i += 2;
 8d8:	bd49                	j	76a <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 8da:	008b8913          	add	s2,s7,8
 8de:	4681                	li	a3,0
 8e0:	4641                	li	a2,16
 8e2:	000ba583          	lw	a1,0(s7)
 8e6:	855a                	mv	a0,s6
 8e8:	d91ff0ef          	jal	678 <printint>
 8ec:	8bca                	mv	s7,s2
      state = 0;
 8ee:	4981                	li	s3,0
 8f0:	bdad                	j	76a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 8f2:	008b8913          	add	s2,s7,8
 8f6:	4681                	li	a3,0
 8f8:	4641                	li	a2,16
 8fa:	000bb583          	ld	a1,0(s7)
 8fe:	855a                	mv	a0,s6
 900:	d79ff0ef          	jal	678 <printint>
        i += 1;
 904:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 906:	8bca                	mv	s7,s2
      state = 0;
 908:	4981                	li	s3,0
        i += 1;
 90a:	b585                	j	76a <vprintf+0x4a>
 90c:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 90e:	008b8d13          	add	s10,s7,8
 912:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 916:	03000593          	li	a1,48
 91a:	855a                	mv	a0,s6
 91c:	d3fff0ef          	jal	65a <putc>
  putc(fd, 'x');
 920:	07800593          	li	a1,120
 924:	855a                	mv	a0,s6
 926:	d35ff0ef          	jal	65a <putc>
 92a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 92c:	00000b97          	auipc	s7,0x0
 930:	27cb8b93          	add	s7,s7,636 # ba8 <digits>
 934:	03c9d793          	srl	a5,s3,0x3c
 938:	97de                	add	a5,a5,s7
 93a:	0007c583          	lbu	a1,0(a5)
 93e:	855a                	mv	a0,s6
 940:	d1bff0ef          	jal	65a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 944:	0992                	sll	s3,s3,0x4
 946:	397d                	addw	s2,s2,-1
 948:	fe0916e3          	bnez	s2,934 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 94c:	8bea                	mv	s7,s10
      state = 0;
 94e:	4981                	li	s3,0
 950:	6d02                	ld	s10,0(sp)
 952:	bd21                	j	76a <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 954:	008b8993          	add	s3,s7,8
 958:	000bb903          	ld	s2,0(s7)
 95c:	00090f63          	beqz	s2,97a <vprintf+0x25a>
        for(; *s; s++)
 960:	00094583          	lbu	a1,0(s2)
 964:	c195                	beqz	a1,988 <vprintf+0x268>
          putc(fd, *s);
 966:	855a                	mv	a0,s6
 968:	cf3ff0ef          	jal	65a <putc>
        for(; *s; s++)
 96c:	0905                	add	s2,s2,1
 96e:	00094583          	lbu	a1,0(s2)
 972:	f9f5                	bnez	a1,966 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 974:	8bce                	mv	s7,s3
      state = 0;
 976:	4981                	li	s3,0
 978:	bbcd                	j	76a <vprintf+0x4a>
          s = "(null)";
 97a:	00000917          	auipc	s2,0x0
 97e:	22690913          	add	s2,s2,550 # ba0 <malloc+0x112>
        for(; *s; s++)
 982:	02800593          	li	a1,40
 986:	b7c5                	j	966 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 988:	8bce                	mv	s7,s3
      state = 0;
 98a:	4981                	li	s3,0
 98c:	bbf9                	j	76a <vprintf+0x4a>
 98e:	64a6                	ld	s1,72(sp)
 990:	79e2                	ld	s3,56(sp)
 992:	7a42                	ld	s4,48(sp)
 994:	7aa2                	ld	s5,40(sp)
 996:	7b02                	ld	s6,32(sp)
 998:	6be2                	ld	s7,24(sp)
 99a:	6c42                	ld	s8,16(sp)
 99c:	6ca2                	ld	s9,8(sp)
    }
  }
}
 99e:	60e6                	ld	ra,88(sp)
 9a0:	6446                	ld	s0,80(sp)
 9a2:	6906                	ld	s2,64(sp)
 9a4:	6125                	add	sp,sp,96
 9a6:	8082                	ret

00000000000009a8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9a8:	715d                	add	sp,sp,-80
 9aa:	ec06                	sd	ra,24(sp)
 9ac:	e822                	sd	s0,16(sp)
 9ae:	1000                	add	s0,sp,32
 9b0:	e010                	sd	a2,0(s0)
 9b2:	e414                	sd	a3,8(s0)
 9b4:	e818                	sd	a4,16(s0)
 9b6:	ec1c                	sd	a5,24(s0)
 9b8:	03043023          	sd	a6,32(s0)
 9bc:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 9c0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 9c4:	8622                	mv	a2,s0
 9c6:	d5bff0ef          	jal	720 <vprintf>
}
 9ca:	60e2                	ld	ra,24(sp)
 9cc:	6442                	ld	s0,16(sp)
 9ce:	6161                	add	sp,sp,80
 9d0:	8082                	ret

00000000000009d2 <printf>:

void
printf(const char *fmt, ...)
{
 9d2:	711d                	add	sp,sp,-96
 9d4:	ec06                	sd	ra,24(sp)
 9d6:	e822                	sd	s0,16(sp)
 9d8:	1000                	add	s0,sp,32
 9da:	e40c                	sd	a1,8(s0)
 9dc:	e810                	sd	a2,16(s0)
 9de:	ec14                	sd	a3,24(s0)
 9e0:	f018                	sd	a4,32(s0)
 9e2:	f41c                	sd	a5,40(s0)
 9e4:	03043823          	sd	a6,48(s0)
 9e8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 9ec:	00840613          	add	a2,s0,8
 9f0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 9f4:	85aa                	mv	a1,a0
 9f6:	4505                	li	a0,1
 9f8:	d29ff0ef          	jal	720 <vprintf>
}
 9fc:	60e2                	ld	ra,24(sp)
 9fe:	6442                	ld	s0,16(sp)
 a00:	6125                	add	sp,sp,96
 a02:	8082                	ret

0000000000000a04 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a04:	1141                	add	sp,sp,-16
 a06:	e422                	sd	s0,8(sp)
 a08:	0800                	add	s0,sp,16
  Header *bp, *p;

  if(ap == 0)
 a0a:	cd3d                	beqz	a0,a88 <free+0x84>
    return;
  if((uint64)ap < 4096)
 a0c:	6785                	lui	a5,0x1
 a0e:	06f56d63          	bltu	a0,a5,a88 <free+0x84>
    return;
  bp = (Header*)ap - 1;
 a12:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a16:	00000797          	auipc	a5,0x0
 a1a:	5f27b783          	ld	a5,1522(a5) # 1008 <freep>
 a1e:	a02d                	j	a48 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a20:	4618                	lw	a4,8(a2)
 a22:	9f2d                	addw	a4,a4,a1
 a24:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a28:	6398                	ld	a4,0(a5)
 a2a:	6310                	ld	a2,0(a4)
 a2c:	a83d                	j	a6a <free+0x66>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a2e:	ff852703          	lw	a4,-8(a0)
 a32:	9f31                	addw	a4,a4,a2
 a34:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a36:	ff053683          	ld	a3,-16(a0)
 a3a:	a091                	j	a7e <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a3c:	6398                	ld	a4,0(a5)
 a3e:	00e7e463          	bltu	a5,a4,a46 <free+0x42>
 a42:	00e6ea63          	bltu	a3,a4,a56 <free+0x52>
{
 a46:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a48:	fed7fae3          	bgeu	a5,a3,a3c <free+0x38>
 a4c:	6398                	ld	a4,0(a5)
 a4e:	00e6e463          	bltu	a3,a4,a56 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a52:	fee7eae3          	bltu	a5,a4,a46 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 a56:	ff852583          	lw	a1,-8(a0)
 a5a:	6390                	ld	a2,0(a5)
 a5c:	02059813          	sll	a6,a1,0x20
 a60:	01c85713          	srl	a4,a6,0x1c
 a64:	9736                	add	a4,a4,a3
 a66:	fae60de3          	beq	a2,a4,a20 <free+0x1c>
    bp->s.ptr = p->s.ptr->s.ptr;
 a6a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a6e:	4790                	lw	a2,8(a5)
 a70:	02061593          	sll	a1,a2,0x20
 a74:	01c5d713          	srl	a4,a1,0x1c
 a78:	973e                	add	a4,a4,a5
 a7a:	fae68ae3          	beq	a3,a4,a2e <free+0x2a>
    p->s.ptr = bp->s.ptr;
 a7e:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 a80:	00000717          	auipc	a4,0x0
 a84:	58f73423          	sd	a5,1416(a4) # 1008 <freep>
}
 a88:	6422                	ld	s0,8(sp)
 a8a:	0141                	add	sp,sp,16
 a8c:	8082                	ret

0000000000000a8e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a8e:	7139                	add	sp,sp,-64
 a90:	fc06                	sd	ra,56(sp)
 a92:	f822                	sd	s0,48(sp)
 a94:	f426                	sd	s1,40(sp)
 a96:	ec4e                	sd	s3,24(sp)
 a98:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a9a:	02051493          	sll	s1,a0,0x20
 a9e:	9081                	srl	s1,s1,0x20
 aa0:	04bd                	add	s1,s1,15
 aa2:	8091                	srl	s1,s1,0x4
 aa4:	0014899b          	addw	s3,s1,1
 aa8:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 aaa:	00000517          	auipc	a0,0x0
 aae:	55e53503          	ld	a0,1374(a0) # 1008 <freep>
 ab2:	c915                	beqz	a0,ae6 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ab4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ab6:	4798                	lw	a4,8(a5)
 ab8:	08977a63          	bgeu	a4,s1,b4c <malloc+0xbe>
 abc:	f04a                	sd	s2,32(sp)
 abe:	e852                	sd	s4,16(sp)
 ac0:	e456                	sd	s5,8(sp)
 ac2:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 ac4:	8a4e                	mv	s4,s3
 ac6:	0009871b          	sext.w	a4,s3
 aca:	6685                	lui	a3,0x1
 acc:	00d77363          	bgeu	a4,a3,ad2 <malloc+0x44>
 ad0:	6a05                	lui	s4,0x1
 ad2:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 ad6:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ada:	00000917          	auipc	s2,0x0
 ade:	52e90913          	add	s2,s2,1326 # 1008 <freep>
  if(p == (char*)-1)
 ae2:	5afd                	li	s5,-1
 ae4:	a081                	j	b24 <malloc+0x96>
 ae6:	f04a                	sd	s2,32(sp)
 ae8:	e852                	sd	s4,16(sp)
 aea:	e456                	sd	s5,8(sp)
 aec:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 aee:	00000797          	auipc	a5,0x0
 af2:	52278793          	add	a5,a5,1314 # 1010 <base>
 af6:	00000717          	auipc	a4,0x0
 afa:	50f73923          	sd	a5,1298(a4) # 1008 <freep>
 afe:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 b00:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 b04:	b7c1                	j	ac4 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 b06:	6398                	ld	a4,0(a5)
 b08:	e118                	sd	a4,0(a0)
 b0a:	a8a9                	j	b64 <malloc+0xd6>
  hp->s.size = nu;
 b0c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 b10:	0541                	add	a0,a0,16
 b12:	ef3ff0ef          	jal	a04 <free>
  return freep;
 b16:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 b1a:	c12d                	beqz	a0,b7c <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b1c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b1e:	4798                	lw	a4,8(a5)
 b20:	02977263          	bgeu	a4,s1,b44 <malloc+0xb6>
    if(p == freep)
 b24:	00093703          	ld	a4,0(s2)
 b28:	853e                	mv	a0,a5
 b2a:	fef719e3          	bne	a4,a5,b1c <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 b2e:	8552                	mv	a0,s4
 b30:	ab9ff0ef          	jal	5e8 <sbrk>
  if(p == (char*)-1)
 b34:	fd551ce3          	bne	a0,s5,b0c <malloc+0x7e>
        return 0;
 b38:	4501                	li	a0,0
 b3a:	7902                	ld	s2,32(sp)
 b3c:	6a42                	ld	s4,16(sp)
 b3e:	6aa2                	ld	s5,8(sp)
 b40:	6b02                	ld	s6,0(sp)
 b42:	a03d                	j	b70 <malloc+0xe2>
 b44:	7902                	ld	s2,32(sp)
 b46:	6a42                	ld	s4,16(sp)
 b48:	6aa2                	ld	s5,8(sp)
 b4a:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 b4c:	fae48de3          	beq	s1,a4,b06 <malloc+0x78>
        p->s.size -= nunits;
 b50:	4137073b          	subw	a4,a4,s3
 b54:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b56:	02071693          	sll	a3,a4,0x20
 b5a:	01c6d713          	srl	a4,a3,0x1c
 b5e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b60:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b64:	00000717          	auipc	a4,0x0
 b68:	4aa73223          	sd	a0,1188(a4) # 1008 <freep>
      return (void*)(p + 1);
 b6c:	01078513          	add	a0,a5,16
  }
}
 b70:	70e2                	ld	ra,56(sp)
 b72:	7442                	ld	s0,48(sp)
 b74:	74a2                	ld	s1,40(sp)
 b76:	69e2                	ld	s3,24(sp)
 b78:	6121                	add	sp,sp,64
 b7a:	8082                	ret
 b7c:	7902                	ld	s2,32(sp)
 b7e:	6a42                	ld	s4,16(sp)
 b80:	6aa2                	ld	s5,8(sp)
 b82:	6b02                	ld	s6,0(sp)
 b84:	b7f5                	j	b70 <malloc+0xe2>
