
user/_ln:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	1101                	add	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	add	s0,sp,32
  if(argc != 3){
   8:	478d                	li	a5,3
   a:	00f50d63          	beq	a0,a5,24 <main+0x24>
   e:	e426                	sd	s1,8(sp)
    fprintf(2, "Usage: ln old new\n");
  10:	00001597          	auipc	a1,0x1
  14:	b5058593          	add	a1,a1,-1200 # b60 <malloc+0xfe>
  18:	4509                	li	a0,2
  1a:	163000ef          	jal	97c <fprintf>
    exit(1);
  1e:	4505                	li	a0,1
  20:	514000ef          	jal	534 <exit>
  24:	e426                	sd	s1,8(sp)
  26:	84ae                	mv	s1,a1
  }
  if(link(argv[1], argv[2]) < 0)
  28:	698c                	ld	a1,16(a1)
  2a:	6488                	ld	a0,8(s1)
  2c:	568000ef          	jal	594 <link>
  30:	00054563          	bltz	a0,3a <main+0x3a>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit(0);
  34:	4501                	li	a0,0
  36:	4fe000ef          	jal	534 <exit>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  3a:	6894                	ld	a3,16(s1)
  3c:	6490                	ld	a2,8(s1)
  3e:	00001597          	auipc	a1,0x1
  42:	b3a58593          	add	a1,a1,-1222 # b78 <malloc+0x116>
  46:	4509                	li	a0,2
  48:	135000ef          	jal	97c <fprintf>
  4c:	b7e5                	j	34 <main+0x34>

000000000000004e <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  4e:	1141                	add	sp,sp,-16
  50:	e406                	sd	ra,8(sp)
  52:	e022                	sd	s0,0(sp)
  54:	0800                	add	s0,sp,16
  extern int main();
  main();
  56:	fabff0ef          	jal	0 <main>
  exit(0);
  5a:	4501                	li	a0,0
  5c:	4d8000ef          	jal	534 <exit>

0000000000000060 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  60:	1141                	add	sp,sp,-16
  62:	e422                	sd	s0,8(sp)
  64:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  66:	87aa                	mv	a5,a0
  68:	0585                	add	a1,a1,1
  6a:	0785                	add	a5,a5,1
  6c:	fff5c703          	lbu	a4,-1(a1)
  70:	fee78fa3          	sb	a4,-1(a5)
  74:	fb75                	bnez	a4,68 <strcpy+0x8>
    ;
  return os;
}
  76:	6422                	ld	s0,8(sp)
  78:	0141                	add	sp,sp,16
  7a:	8082                	ret

000000000000007c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  7c:	1141                	add	sp,sp,-16
  7e:	e422                	sd	s0,8(sp)
  80:	0800                	add	s0,sp,16
  while(*p && *p == *q)
  82:	00054783          	lbu	a5,0(a0)
  86:	cb91                	beqz	a5,9a <strcmp+0x1e>
  88:	0005c703          	lbu	a4,0(a1)
  8c:	00f71763          	bne	a4,a5,9a <strcmp+0x1e>
    p++, q++;
  90:	0505                	add	a0,a0,1
  92:	0585                	add	a1,a1,1
  while(*p && *p == *q)
  94:	00054783          	lbu	a5,0(a0)
  98:	fbe5                	bnez	a5,88 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  9a:	0005c503          	lbu	a0,0(a1)
}
  9e:	40a7853b          	subw	a0,a5,a0
  a2:	6422                	ld	s0,8(sp)
  a4:	0141                	add	sp,sp,16
  a6:	8082                	ret

00000000000000a8 <strlen>:

uint
strlen(const char *s)
{
  a8:	1141                	add	sp,sp,-16
  aa:	e422                	sd	s0,8(sp)
  ac:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  ae:	00054783          	lbu	a5,0(a0)
  b2:	cf91                	beqz	a5,ce <strlen+0x26>
  b4:	0505                	add	a0,a0,1
  b6:	87aa                	mv	a5,a0
  b8:	86be                	mv	a3,a5
  ba:	0785                	add	a5,a5,1
  bc:	fff7c703          	lbu	a4,-1(a5)
  c0:	ff65                	bnez	a4,b8 <strlen+0x10>
  c2:	40a6853b          	subw	a0,a3,a0
  c6:	2505                	addw	a0,a0,1
    ;
  return n;
}
  c8:	6422                	ld	s0,8(sp)
  ca:	0141                	add	sp,sp,16
  cc:	8082                	ret
  for(n = 0; s[n]; n++)
  ce:	4501                	li	a0,0
  d0:	bfe5                	j	c8 <strlen+0x20>

00000000000000d2 <memset>:

void*
memset(void *dst, int c, uint n)
{
  d2:	1141                	add	sp,sp,-16
  d4:	e422                	sd	s0,8(sp)
  d6:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  d8:	ca19                	beqz	a2,ee <memset+0x1c>
  da:	87aa                	mv	a5,a0
  dc:	1602                	sll	a2,a2,0x20
  de:	9201                	srl	a2,a2,0x20
  e0:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  e4:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  e8:	0785                	add	a5,a5,1
  ea:	fee79de3          	bne	a5,a4,e4 <memset+0x12>
  }
  return dst;
}
  ee:	6422                	ld	s0,8(sp)
  f0:	0141                	add	sp,sp,16
  f2:	8082                	ret

00000000000000f4 <strchr>:

char*
strchr(const char *s, char c)
{
  f4:	1141                	add	sp,sp,-16
  f6:	e422                	sd	s0,8(sp)
  f8:	0800                	add	s0,sp,16
  for(; *s; s++)
  fa:	00054783          	lbu	a5,0(a0)
  fe:	cb99                	beqz	a5,114 <strchr+0x20>
    if(*s == c)
 100:	00f58763          	beq	a1,a5,10e <strchr+0x1a>
  for(; *s; s++)
 104:	0505                	add	a0,a0,1
 106:	00054783          	lbu	a5,0(a0)
 10a:	fbfd                	bnez	a5,100 <strchr+0xc>
      return (char*)s;
  return 0;
 10c:	4501                	li	a0,0
}
 10e:	6422                	ld	s0,8(sp)
 110:	0141                	add	sp,sp,16
 112:	8082                	ret
  return 0;
 114:	4501                	li	a0,0
 116:	bfe5                	j	10e <strchr+0x1a>

0000000000000118 <gets>:

char*
gets(char *buf, int max)
{
 118:	711d                	add	sp,sp,-96
 11a:	ec86                	sd	ra,88(sp)
 11c:	e8a2                	sd	s0,80(sp)
 11e:	e4a6                	sd	s1,72(sp)
 120:	e0ca                	sd	s2,64(sp)
 122:	fc4e                	sd	s3,56(sp)
 124:	f852                	sd	s4,48(sp)
 126:	f456                	sd	s5,40(sp)
 128:	f05a                	sd	s6,32(sp)
 12a:	ec5e                	sd	s7,24(sp)
 12c:	1080                	add	s0,sp,96
 12e:	8baa                	mv	s7,a0
 130:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 132:	892a                	mv	s2,a0
 134:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 136:	4aa9                	li	s5,10
 138:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 13a:	89a6                	mv	s3,s1
 13c:	2485                	addw	s1,s1,1
 13e:	0344d663          	bge	s1,s4,16a <gets+0x52>
    cc = read(0, &c, 1);
 142:	4605                	li	a2,1
 144:	faf40593          	add	a1,s0,-81
 148:	4501                	li	a0,0
 14a:	402000ef          	jal	54c <read>
    if(cc < 1)
 14e:	00a05e63          	blez	a0,16a <gets+0x52>
    buf[i++] = c;
 152:	faf44783          	lbu	a5,-81(s0)
 156:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 15a:	01578763          	beq	a5,s5,168 <gets+0x50>
 15e:	0905                	add	s2,s2,1
 160:	fd679de3          	bne	a5,s6,13a <gets+0x22>
    buf[i++] = c;
 164:	89a6                	mv	s3,s1
 166:	a011                	j	16a <gets+0x52>
 168:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 16a:	99de                	add	s3,s3,s7
 16c:	00098023          	sb	zero,0(s3)
  return buf;
}
 170:	855e                	mv	a0,s7
 172:	60e6                	ld	ra,88(sp)
 174:	6446                	ld	s0,80(sp)
 176:	64a6                	ld	s1,72(sp)
 178:	6906                	ld	s2,64(sp)
 17a:	79e2                	ld	s3,56(sp)
 17c:	7a42                	ld	s4,48(sp)
 17e:	7aa2                	ld	s5,40(sp)
 180:	7b02                	ld	s6,32(sp)
 182:	6be2                	ld	s7,24(sp)
 184:	6125                	add	sp,sp,96
 186:	8082                	ret

0000000000000188 <stat>:

int
stat(const char *n, struct stat *st)
{
 188:	1101                	add	sp,sp,-32
 18a:	ec06                	sd	ra,24(sp)
 18c:	e822                	sd	s0,16(sp)
 18e:	e04a                	sd	s2,0(sp)
 190:	1000                	add	s0,sp,32
 192:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 194:	4581                	li	a1,0
 196:	3de000ef          	jal	574 <open>
  if(fd < 0)
 19a:	02054263          	bltz	a0,1be <stat+0x36>
 19e:	e426                	sd	s1,8(sp)
 1a0:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1a2:	85ca                	mv	a1,s2
 1a4:	3e8000ef          	jal	58c <fstat>
 1a8:	892a                	mv	s2,a0
  close(fd);
 1aa:	8526                	mv	a0,s1
 1ac:	3b0000ef          	jal	55c <close>
  return r;
 1b0:	64a2                	ld	s1,8(sp)
}
 1b2:	854a                	mv	a0,s2
 1b4:	60e2                	ld	ra,24(sp)
 1b6:	6442                	ld	s0,16(sp)
 1b8:	6902                	ld	s2,0(sp)
 1ba:	6105                	add	sp,sp,32
 1bc:	8082                	ret
    return -1;
 1be:	597d                	li	s2,-1
 1c0:	bfcd                	j	1b2 <stat+0x2a>

00000000000001c2 <atoi>:

int
atoi(const char *s)
{
 1c2:	1141                	add	sp,sp,-16
 1c4:	e422                	sd	s0,8(sp)
 1c6:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1c8:	00054683          	lbu	a3,0(a0)
 1cc:	fd06879b          	addw	a5,a3,-48
 1d0:	0ff7f793          	zext.b	a5,a5
 1d4:	4625                	li	a2,9
 1d6:	02f66863          	bltu	a2,a5,206 <atoi+0x44>
 1da:	872a                	mv	a4,a0
  n = 0;
 1dc:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 1de:	0705                	add	a4,a4,1
 1e0:	0025179b          	sllw	a5,a0,0x2
 1e4:	9fa9                	addw	a5,a5,a0
 1e6:	0017979b          	sllw	a5,a5,0x1
 1ea:	9fb5                	addw	a5,a5,a3
 1ec:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1f0:	00074683          	lbu	a3,0(a4)
 1f4:	fd06879b          	addw	a5,a3,-48
 1f8:	0ff7f793          	zext.b	a5,a5
 1fc:	fef671e3          	bgeu	a2,a5,1de <atoi+0x1c>
  return n;
}
 200:	6422                	ld	s0,8(sp)
 202:	0141                	add	sp,sp,16
 204:	8082                	ret
  n = 0;
 206:	4501                	li	a0,0
 208:	bfe5                	j	200 <atoi+0x3e>

000000000000020a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 20a:	1141                	add	sp,sp,-16
 20c:	e422                	sd	s0,8(sp)
 20e:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 210:	02b57463          	bgeu	a0,a1,238 <memmove+0x2e>
    while(n-- > 0)
 214:	00c05f63          	blez	a2,232 <memmove+0x28>
 218:	1602                	sll	a2,a2,0x20
 21a:	9201                	srl	a2,a2,0x20
 21c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 220:	872a                	mv	a4,a0
      *dst++ = *src++;
 222:	0585                	add	a1,a1,1
 224:	0705                	add	a4,a4,1
 226:	fff5c683          	lbu	a3,-1(a1)
 22a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 22e:	fef71ae3          	bne	a4,a5,222 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 232:	6422                	ld	s0,8(sp)
 234:	0141                	add	sp,sp,16
 236:	8082                	ret
    dst += n;
 238:	00c50733          	add	a4,a0,a2
    src += n;
 23c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 23e:	fec05ae3          	blez	a2,232 <memmove+0x28>
 242:	fff6079b          	addw	a5,a2,-1
 246:	1782                	sll	a5,a5,0x20
 248:	9381                	srl	a5,a5,0x20
 24a:	fff7c793          	not	a5,a5
 24e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 250:	15fd                	add	a1,a1,-1
 252:	177d                	add	a4,a4,-1
 254:	0005c683          	lbu	a3,0(a1)
 258:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 25c:	fee79ae3          	bne	a5,a4,250 <memmove+0x46>
 260:	bfc9                	j	232 <memmove+0x28>

0000000000000262 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 262:	1141                	add	sp,sp,-16
 264:	e422                	sd	s0,8(sp)
 266:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 268:	ca05                	beqz	a2,298 <memcmp+0x36>
 26a:	fff6069b          	addw	a3,a2,-1
 26e:	1682                	sll	a3,a3,0x20
 270:	9281                	srl	a3,a3,0x20
 272:	0685                	add	a3,a3,1
 274:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 276:	00054783          	lbu	a5,0(a0)
 27a:	0005c703          	lbu	a4,0(a1)
 27e:	00e79863          	bne	a5,a4,28e <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 282:	0505                	add	a0,a0,1
    p2++;
 284:	0585                	add	a1,a1,1
  while (n-- > 0) {
 286:	fed518e3          	bne	a0,a3,276 <memcmp+0x14>
  }
  return 0;
 28a:	4501                	li	a0,0
 28c:	a019                	j	292 <memcmp+0x30>
      return *p1 - *p2;
 28e:	40e7853b          	subw	a0,a5,a4
}
 292:	6422                	ld	s0,8(sp)
 294:	0141                	add	sp,sp,16
 296:	8082                	ret
  return 0;
 298:	4501                	li	a0,0
 29a:	bfe5                	j	292 <memcmp+0x30>

000000000000029c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 29c:	1141                	add	sp,sp,-16
 29e:	e406                	sd	ra,8(sp)
 2a0:	e022                	sd	s0,0(sp)
 2a2:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 2a4:	f67ff0ef          	jal	20a <memmove>
}
 2a8:	60a2                	ld	ra,8(sp)
 2aa:	6402                	ld	s0,0(sp)
 2ac:	0141                	add	sp,sp,16
 2ae:	8082                	ret

00000000000002b0 <htons>:
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
}

uint16_t
htons(uint16_t h)
{
 2b0:	1141                	add	sp,sp,-16
 2b2:	e422                	sd	s0,8(sp)
 2b4:	0800                	add	s0,sp,16
    if (!endian) {
 2b6:	00001797          	auipc	a5,0x1
 2ba:	d4a7a783          	lw	a5,-694(a5) # 1000 <endian>
 2be:	e385                	bnez	a5,2de <htons+0x2e>
        endian = byteorder();
 2c0:	4d200793          	li	a5,1234
 2c4:	00001717          	auipc	a4,0x1
 2c8:	d2f72e23          	sw	a5,-708(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 2cc:	0085179b          	sllw	a5,a0,0x8
 2d0:	0085551b          	srlw	a0,a0,0x8
 2d4:	8fc9                	or	a5,a5,a0
 2d6:	03079513          	sll	a0,a5,0x30
 2da:	9141                	srl	a0,a0,0x30
 2dc:	a029                	j	2e6 <htons+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(h) : h;
 2de:	4d200713          	li	a4,1234
 2e2:	fee785e3          	beq	a5,a4,2cc <htons+0x1c>
}
 2e6:	6422                	ld	s0,8(sp)
 2e8:	0141                	add	sp,sp,16
 2ea:	8082                	ret

00000000000002ec <ntohs>:

uint16_t
ntohs(uint16_t n)
{
 2ec:	1141                	add	sp,sp,-16
 2ee:	e422                	sd	s0,8(sp)
 2f0:	0800                	add	s0,sp,16
    if (!endian) {
 2f2:	00001797          	auipc	a5,0x1
 2f6:	d0e7a783          	lw	a5,-754(a5) # 1000 <endian>
 2fa:	e385                	bnez	a5,31a <ntohs+0x2e>
        endian = byteorder();
 2fc:	4d200793          	li	a5,1234
 300:	00001717          	auipc	a4,0x1
 304:	d0f72023          	sw	a5,-768(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 308:	0085179b          	sllw	a5,a0,0x8
 30c:	0085551b          	srlw	a0,a0,0x8
 310:	8fc9                	or	a5,a5,a0
 312:	03079513          	sll	a0,a5,0x30
 316:	9141                	srl	a0,a0,0x30
 318:	a029                	j	322 <ntohs+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(n) : n;
 31a:	4d200713          	li	a4,1234
 31e:	fee785e3          	beq	a5,a4,308 <ntohs+0x1c>
}
 322:	6422                	ld	s0,8(sp)
 324:	0141                	add	sp,sp,16
 326:	8082                	ret

0000000000000328 <htonl>:

uint32_t
htonl(uint32_t h)
{
 328:	1141                	add	sp,sp,-16
 32a:	e422                	sd	s0,8(sp)
 32c:	0800                	add	s0,sp,16
    if (!endian) {
 32e:	00001797          	auipc	a5,0x1
 332:	cd27a783          	lw	a5,-814(a5) # 1000 <endian>
 336:	ef85                	bnez	a5,36e <htonl+0x46>
        endian = byteorder();
 338:	4d200793          	li	a5,1234
 33c:	00001717          	auipc	a4,0x1
 340:	ccf72223          	sw	a5,-828(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 344:	0185179b          	sllw	a5,a0,0x18
 348:	0185571b          	srlw	a4,a0,0x18
 34c:	8fd9                	or	a5,a5,a4
 34e:	0085171b          	sllw	a4,a0,0x8
 352:	00ff06b7          	lui	a3,0xff0
 356:	8f75                	and	a4,a4,a3
 358:	8fd9                	or	a5,a5,a4
 35a:	0085551b          	srlw	a0,a0,0x8
 35e:	6741                	lui	a4,0x10
 360:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeef0>
 364:	8d79                	and	a0,a0,a4
 366:	8fc9                	or	a5,a5,a0
 368:	0007851b          	sext.w	a0,a5
 36c:	a029                	j	376 <htonl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(h) : h;
 36e:	4d200713          	li	a4,1234
 372:	fce789e3          	beq	a5,a4,344 <htonl+0x1c>
}
 376:	6422                	ld	s0,8(sp)
 378:	0141                	add	sp,sp,16
 37a:	8082                	ret

000000000000037c <ntohl>:

uint32_t
ntohl(uint32_t n)
{
 37c:	1141                	add	sp,sp,-16
 37e:	e422                	sd	s0,8(sp)
 380:	0800                	add	s0,sp,16
    if (!endian) {
 382:	00001797          	auipc	a5,0x1
 386:	c7e7a783          	lw	a5,-898(a5) # 1000 <endian>
 38a:	ef85                	bnez	a5,3c2 <ntohl+0x46>
        endian = byteorder();
 38c:	4d200793          	li	a5,1234
 390:	00001717          	auipc	a4,0x1
 394:	c6f72823          	sw	a5,-912(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 398:	0185179b          	sllw	a5,a0,0x18
 39c:	0185571b          	srlw	a4,a0,0x18
 3a0:	8fd9                	or	a5,a5,a4
 3a2:	0085171b          	sllw	a4,a0,0x8
 3a6:	00ff06b7          	lui	a3,0xff0
 3aa:	8f75                	and	a4,a4,a3
 3ac:	8fd9                	or	a5,a5,a4
 3ae:	0085551b          	srlw	a0,a0,0x8
 3b2:	6741                	lui	a4,0x10
 3b4:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeef0>
 3b8:	8d79                	and	a0,a0,a4
 3ba:	8fc9                	or	a5,a5,a0
 3bc:	0007851b          	sext.w	a0,a5
 3c0:	a029                	j	3ca <ntohl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(n) : n;
 3c2:	4d200713          	li	a4,1234
 3c6:	fce789e3          	beq	a5,a4,398 <ntohl+0x1c>
}
 3ca:	6422                	ld	s0,8(sp)
 3cc:	0141                	add	sp,sp,16
 3ce:	8082                	ret

00000000000003d0 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
 3d0:	1141                	add	sp,sp,-16
 3d2:	e422                	sd	s0,8(sp)
 3d4:	0800                	add	s0,sp,16
 3d6:	872a                	mv	a4,a0
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
 3d8:	02000693          	li	a3,32
 3dc:	4525                	li	a0,9
 3de:	a011                	j	3e2 <strtol+0x12>
        s++;
 3e0:	0705                	add	a4,a4,1
    while (*s == ' ' || *s == '\t')
 3e2:	00074783          	lbu	a5,0(a4)
 3e6:	fed78de3          	beq	a5,a3,3e0 <strtol+0x10>
 3ea:	fea78be3          	beq	a5,a0,3e0 <strtol+0x10>

    // plus/minus sign
    if (*s == '+')
 3ee:	02b00693          	li	a3,43
 3f2:	02d78663          	beq	a5,a3,41e <strtol+0x4e>
        s++;
    else if (*s == '-')
 3f6:	02d00693          	li	a3,45
    int neg = 0;
 3fa:	4301                	li	t1,0
    else if (*s == '-')
 3fc:	02d78463          	beq	a5,a3,424 <strtol+0x54>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 400:	fef67793          	and	a5,a2,-17
 404:	eb89                	bnez	a5,416 <strtol+0x46>
 406:	00074683          	lbu	a3,0(a4)
 40a:	03000793          	li	a5,48
 40e:	00f68e63          	beq	a3,a5,42a <strtol+0x5a>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
 412:	e211                	bnez	a2,416 <strtol+0x46>
        s++, base = 8;
    else if (base == 0)
        base = 10;
 414:	4629                	li	a2,10
 416:	4501                	li	a0,0

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
 418:	4825                	li	a6,9
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
 41a:	48e5                	li	a7,25
 41c:	a825                	j	454 <strtol+0x84>
        s++;
 41e:	0705                	add	a4,a4,1
    int neg = 0;
 420:	4301                	li	t1,0
 422:	bff9                	j	400 <strtol+0x30>
        s++, neg = 1;
 424:	0705                	add	a4,a4,1
 426:	4305                	li	t1,1
 428:	bfe1                	j	400 <strtol+0x30>
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 42a:	00174683          	lbu	a3,1(a4)
 42e:	07800793          	li	a5,120
 432:	00f68663          	beq	a3,a5,43e <strtol+0x6e>
    else if (base == 0 && s[0] == '0')
 436:	f265                	bnez	a2,416 <strtol+0x46>
        s++, base = 8;
 438:	0705                	add	a4,a4,1
 43a:	4621                	li	a2,8
 43c:	bfe9                	j	416 <strtol+0x46>
        s += 2, base = 16;
 43e:	0709                	add	a4,a4,2
 440:	4641                	li	a2,16
 442:	bfd1                	j	416 <strtol+0x46>
            dig = *s - '0';
 444:	fd07879b          	addw	a5,a5,-48
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
 448:	04c7d063          	bge	a5,a2,488 <strtol+0xb8>
            break;
        s++, val = (val * base) + dig;
 44c:	0705                	add	a4,a4,1
 44e:	02a60533          	mul	a0,a2,a0
 452:	953e                	add	a0,a0,a5
        if (*s >= '0' && *s <= '9')
 454:	00074783          	lbu	a5,0(a4)
 458:	fd07869b          	addw	a3,a5,-48
 45c:	0ff6f693          	zext.b	a3,a3
 460:	fed872e3          	bgeu	a6,a3,444 <strtol+0x74>
        else if (*s >= 'a' && *s <= 'z')
 464:	f9f7869b          	addw	a3,a5,-97
 468:	0ff6f693          	zext.b	a3,a3
 46c:	00d8e563          	bltu	a7,a3,476 <strtol+0xa6>
            dig = *s - 'a' + 10;
 470:	fa97879b          	addw	a5,a5,-87
 474:	bfd1                	j	448 <strtol+0x78>
        else if (*s >= 'A' && *s <= 'Z')
 476:	fbf7869b          	addw	a3,a5,-65
 47a:	0ff6f693          	zext.b	a3,a3
 47e:	00d8e563          	bltu	a7,a3,488 <strtol+0xb8>
            dig = *s - 'A' + 10;
 482:	fc97879b          	addw	a5,a5,-55
 486:	b7c9                	j	448 <strtol+0x78>
        // we don't properly detect overflow!
    }

    if (endptr)
 488:	c191                	beqz	a1,48c <strtol+0xbc>
        *endptr = (char *) s;
 48a:	e198                	sd	a4,0(a1)
    return (neg ? -val : val);
 48c:	00030463          	beqz	t1,494 <strtol+0xc4>
 490:	40a00533          	neg	a0,a0
}
 494:	6422                	ld	s0,8(sp)
 496:	0141                	add	sp,sp,16
 498:	8082                	ret

000000000000049a <inet_pton>:
inet_pton (int family, const char *p, void *n) {
    char *sp, *ep;
    int idx;
    long ret;

    if (family != AF_INET) {
 49a:	4785                	li	a5,1
 49c:	08f51063          	bne	a0,a5,51c <inet_pton+0x82>
inet_pton (int family, const char *p, void *n) {
 4a0:	715d                	add	sp,sp,-80
 4a2:	e486                	sd	ra,72(sp)
 4a4:	e0a2                	sd	s0,64(sp)
 4a6:	fc26                	sd	s1,56(sp)
 4a8:	f84a                	sd	s2,48(sp)
 4aa:	f44e                	sd	s3,40(sp)
 4ac:	f052                	sd	s4,32(sp)
 4ae:	ec56                	sd	s5,24(sp)
 4b0:	e85a                	sd	s6,16(sp)
 4b2:	0880                	add	s0,sp,80
 4b4:	84ae                	mv	s1,a1
 4b6:	89b2                	mv	s3,a2
 4b8:	4901                	li	s2,0
        return -1;
    }
    sp = (char *)p;
    for (idx = 0; idx < 4; idx++) {
        ret = strtol(sp, &ep, 10);
        if (ret < 0 || ret > 255) {
 4ba:	0ff00a13          	li	s4,255
            return -1;
        }
        if (ep == sp) {
            return -1;
        }
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 4be:	4a8d                	li	s5,3
 4c0:	02e00b13          	li	s6,46
 4c4:	a805                	j	4f4 <inet_pton+0x5a>
 4c6:	0007c783          	lbu	a5,0(a5)
 4ca:	efb9                	bnez	a5,528 <inet_pton+0x8e>
            return -1;
        }
        ((uint8_t *)n)[idx] = ret;
 4cc:	00a981a3          	sb	a0,3(s3)
        sp = ep + 1;
    }
    return 0;
 4d0:	4501                	li	a0,0
}
 4d2:	60a6                	ld	ra,72(sp)
 4d4:	6406                	ld	s0,64(sp)
 4d6:	74e2                	ld	s1,56(sp)
 4d8:	7942                	ld	s2,48(sp)
 4da:	79a2                	ld	s3,40(sp)
 4dc:	7a02                	ld	s4,32(sp)
 4de:	6ae2                	ld	s5,24(sp)
 4e0:	6b42                	ld	s6,16(sp)
 4e2:	6161                	add	sp,sp,80
 4e4:	8082                	ret
        ((uint8_t *)n)[idx] = ret;
 4e6:	01298733          	add	a4,s3,s2
 4ea:	00a70023          	sb	a0,0(a4)
        sp = ep + 1;
 4ee:	00178493          	add	s1,a5,1
    for (idx = 0; idx < 4; idx++) {
 4f2:	0905                	add	s2,s2,1
        ret = strtol(sp, &ep, 10);
 4f4:	4629                	li	a2,10
 4f6:	fb840593          	add	a1,s0,-72
 4fa:	8526                	mv	a0,s1
 4fc:	ed5ff0ef          	jal	3d0 <strtol>
        if (ret < 0 || ret > 255) {
 500:	02aa6063          	bltu	s4,a0,520 <inet_pton+0x86>
        if (ep == sp) {
 504:	fb843783          	ld	a5,-72(s0)
 508:	00978e63          	beq	a5,s1,524 <inet_pton+0x8a>
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 50c:	fb590de3          	beq	s2,s5,4c6 <inet_pton+0x2c>
 510:	0007c703          	lbu	a4,0(a5)
 514:	fd6709e3          	beq	a4,s6,4e6 <inet_pton+0x4c>
            return -1;
 518:	557d                	li	a0,-1
 51a:	bf65                	j	4d2 <inet_pton+0x38>
        return -1;
 51c:	557d                	li	a0,-1
}
 51e:	8082                	ret
            return -1;
 520:	557d                	li	a0,-1
 522:	bf45                	j	4d2 <inet_pton+0x38>
            return -1;
 524:	557d                	li	a0,-1
 526:	b775                	j	4d2 <inet_pton+0x38>
            return -1;
 528:	557d                	li	a0,-1
 52a:	b765                	j	4d2 <inet_pton+0x38>

000000000000052c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 52c:	4885                	li	a7,1
 ecall
 52e:	00000073          	ecall
 ret
 532:	8082                	ret

0000000000000534 <exit>:
.global exit
exit:
 li a7, SYS_exit
 534:	4889                	li	a7,2
 ecall
 536:	00000073          	ecall
 ret
 53a:	8082                	ret

000000000000053c <wait>:
.global wait
wait:
 li a7, SYS_wait
 53c:	488d                	li	a7,3
 ecall
 53e:	00000073          	ecall
 ret
 542:	8082                	ret

0000000000000544 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 544:	4891                	li	a7,4
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <read>:
.global read
read:
 li a7, SYS_read
 54c:	4895                	li	a7,5
 ecall
 54e:	00000073          	ecall
 ret
 552:	8082                	ret

0000000000000554 <write>:
.global write
write:
 li a7, SYS_write
 554:	48c1                	li	a7,16
 ecall
 556:	00000073          	ecall
 ret
 55a:	8082                	ret

000000000000055c <close>:
.global close
close:
 li a7, SYS_close
 55c:	48d5                	li	a7,21
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <kill>:
.global kill
kill:
 li a7, SYS_kill
 564:	4899                	li	a7,6
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <exec>:
.global exec
exec:
 li a7, SYS_exec
 56c:	489d                	li	a7,7
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <open>:
.global open
open:
 li a7, SYS_open
 574:	48bd                	li	a7,15
 ecall
 576:	00000073          	ecall
 ret
 57a:	8082                	ret

000000000000057c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 57c:	48c5                	li	a7,17
 ecall
 57e:	00000073          	ecall
 ret
 582:	8082                	ret

0000000000000584 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 584:	48c9                	li	a7,18
 ecall
 586:	00000073          	ecall
 ret
 58a:	8082                	ret

000000000000058c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 58c:	48a1                	li	a7,8
 ecall
 58e:	00000073          	ecall
 ret
 592:	8082                	ret

0000000000000594 <link>:
.global link
link:
 li a7, SYS_link
 594:	48cd                	li	a7,19
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 59c:	48d1                	li	a7,20
 ecall
 59e:	00000073          	ecall
 ret
 5a2:	8082                	ret

00000000000005a4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5a4:	48a5                	li	a7,9
 ecall
 5a6:	00000073          	ecall
 ret
 5aa:	8082                	ret

00000000000005ac <dup>:
.global dup
dup:
 li a7, SYS_dup
 5ac:	48a9                	li	a7,10
 ecall
 5ae:	00000073          	ecall
 ret
 5b2:	8082                	ret

00000000000005b4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5b4:	48ad                	li	a7,11
 ecall
 5b6:	00000073          	ecall
 ret
 5ba:	8082                	ret

00000000000005bc <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5bc:	48b1                	li	a7,12
 ecall
 5be:	00000073          	ecall
 ret
 5c2:	8082                	ret

00000000000005c4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5c4:	48b5                	li	a7,13
 ecall
 5c6:	00000073          	ecall
 ret
 5ca:	8082                	ret

00000000000005cc <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5cc:	48b9                	li	a7,14
 ecall
 5ce:	00000073          	ecall
 ret
 5d2:	8082                	ret

00000000000005d4 <socket>:
.global socket
socket:
 li a7, SYS_socket
 5d4:	48d9                	li	a7,22
 ecall
 5d6:	00000073          	ecall
 ret
 5da:	8082                	ret

00000000000005dc <bind>:
.global bind
bind:
 li a7, SYS_bind
 5dc:	48dd                	li	a7,23
 ecall
 5de:	00000073          	ecall
 ret
 5e2:	8082                	ret

00000000000005e4 <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 5e4:	48e1                	li	a7,24
 ecall
 5e6:	00000073          	ecall
 ret
 5ea:	8082                	ret

00000000000005ec <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 5ec:	48e5                	li	a7,25
 ecall
 5ee:	00000073          	ecall
 ret
 5f2:	8082                	ret

00000000000005f4 <connect>:
.global connect
connect:
 li a7, SYS_connect
 5f4:	48e9                	li	a7,26
 ecall
 5f6:	00000073          	ecall
 ret
 5fa:	8082                	ret

00000000000005fc <listen>:
.global listen
listen:
 li a7, SYS_listen
 5fc:	48ed                	li	a7,27
 ecall
 5fe:	00000073          	ecall
 ret
 602:	8082                	ret

0000000000000604 <accept>:
.global accept
accept:
 li a7, SYS_accept
 604:	48f1                	li	a7,28
 ecall
 606:	00000073          	ecall
 ret
 60a:	8082                	ret

000000000000060c <recv>:
.global recv
recv:
 li a7, SYS_recv
 60c:	48f5                	li	a7,29
 ecall
 60e:	00000073          	ecall
 ret
 612:	8082                	ret

0000000000000614 <send>:
.global send
send:
 li a7, SYS_send
 614:	48f9                	li	a7,30
 ecall
 616:	00000073          	ecall
 ret
 61a:	8082                	ret

000000000000061c <ioctl>:
.global ioctl
ioctl:
 li a7, SYS_ioctl
 61c:	48fd                	li	a7,31
 ecall
 61e:	00000073          	ecall
 ret
 622:	8082                	ret

0000000000000624 <consolemode>:
.global consolemode
consolemode:
 li a7, SYS_consolemode
 624:	02000893          	li	a7,32
 ecall
 628:	00000073          	ecall
 ret
 62c:	8082                	ret

000000000000062e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 62e:	1101                	add	sp,sp,-32
 630:	ec06                	sd	ra,24(sp)
 632:	e822                	sd	s0,16(sp)
 634:	1000                	add	s0,sp,32
 636:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 63a:	4605                	li	a2,1
 63c:	fef40593          	add	a1,s0,-17
 640:	f15ff0ef          	jal	554 <write>
}
 644:	60e2                	ld	ra,24(sp)
 646:	6442                	ld	s0,16(sp)
 648:	6105                	add	sp,sp,32
 64a:	8082                	ret

000000000000064c <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 64c:	715d                	add	sp,sp,-80
 64e:	e486                	sd	ra,72(sp)
 650:	e0a2                	sd	s0,64(sp)
 652:	fc26                	sd	s1,56(sp)
 654:	0880                	add	s0,sp,80
 656:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 658:	c299                	beqz	a3,65e <printint+0x12>
 65a:	0805c963          	bltz	a1,6ec <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 65e:	2581                	sext.w	a1,a1
  neg = 0;
 660:	4881                	li	a7,0
 662:	fb840693          	add	a3,s0,-72
  }

  i = 0;
 666:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 668:	2601                	sext.w	a2,a2
 66a:	00000517          	auipc	a0,0x0
 66e:	52e50513          	add	a0,a0,1326 # b98 <digits>
 672:	883a                	mv	a6,a4
 674:	2705                	addw	a4,a4,1
 676:	02c5f7bb          	remuw	a5,a1,a2
 67a:	1782                	sll	a5,a5,0x20
 67c:	9381                	srl	a5,a5,0x20
 67e:	97aa                	add	a5,a5,a0
 680:	0007c783          	lbu	a5,0(a5)
 684:	00f68023          	sb	a5,0(a3) # ff0000 <base+0xfeeff0>
  }while((x /= base) != 0);
 688:	0005879b          	sext.w	a5,a1
 68c:	02c5d5bb          	divuw	a1,a1,a2
 690:	0685                	add	a3,a3,1
 692:	fec7f0e3          	bgeu	a5,a2,672 <printint+0x26>
  if(neg)
 696:	00088c63          	beqz	a7,6ae <printint+0x62>
    buf[i++] = '-';
 69a:	fd070793          	add	a5,a4,-48
 69e:	00878733          	add	a4,a5,s0
 6a2:	02d00793          	li	a5,45
 6a6:	fef70423          	sb	a5,-24(a4)
 6aa:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 6ae:	02e05a63          	blez	a4,6e2 <printint+0x96>
 6b2:	f84a                	sd	s2,48(sp)
 6b4:	f44e                	sd	s3,40(sp)
 6b6:	fb840793          	add	a5,s0,-72
 6ba:	00e78933          	add	s2,a5,a4
 6be:	fff78993          	add	s3,a5,-1
 6c2:	99ba                	add	s3,s3,a4
 6c4:	377d                	addw	a4,a4,-1
 6c6:	1702                	sll	a4,a4,0x20
 6c8:	9301                	srl	a4,a4,0x20
 6ca:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 6ce:	fff94583          	lbu	a1,-1(s2)
 6d2:	8526                	mv	a0,s1
 6d4:	f5bff0ef          	jal	62e <putc>
  while(--i >= 0)
 6d8:	197d                	add	s2,s2,-1
 6da:	ff391ae3          	bne	s2,s3,6ce <printint+0x82>
 6de:	7942                	ld	s2,48(sp)
 6e0:	79a2                	ld	s3,40(sp)
}
 6e2:	60a6                	ld	ra,72(sp)
 6e4:	6406                	ld	s0,64(sp)
 6e6:	74e2                	ld	s1,56(sp)
 6e8:	6161                	add	sp,sp,80
 6ea:	8082                	ret
    x = -xx;
 6ec:	40b005bb          	negw	a1,a1
    neg = 1;
 6f0:	4885                	li	a7,1
    x = -xx;
 6f2:	bf85                	j	662 <printint+0x16>

00000000000006f4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6f4:	711d                	add	sp,sp,-96
 6f6:	ec86                	sd	ra,88(sp)
 6f8:	e8a2                	sd	s0,80(sp)
 6fa:	e0ca                	sd	s2,64(sp)
 6fc:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6fe:	0005c903          	lbu	s2,0(a1)
 702:	26090863          	beqz	s2,972 <vprintf+0x27e>
 706:	e4a6                	sd	s1,72(sp)
 708:	fc4e                	sd	s3,56(sp)
 70a:	f852                	sd	s4,48(sp)
 70c:	f456                	sd	s5,40(sp)
 70e:	f05a                	sd	s6,32(sp)
 710:	ec5e                	sd	s7,24(sp)
 712:	e862                	sd	s8,16(sp)
 714:	e466                	sd	s9,8(sp)
 716:	8b2a                	mv	s6,a0
 718:	8a2e                	mv	s4,a1
 71a:	8bb2                	mv	s7,a2
  state = 0;
 71c:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 71e:	4481                	li	s1,0
 720:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 722:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 726:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 72a:	06c00c93          	li	s9,108
 72e:	a005                	j	74e <vprintf+0x5a>
        putc(fd, c0);
 730:	85ca                	mv	a1,s2
 732:	855a                	mv	a0,s6
 734:	efbff0ef          	jal	62e <putc>
 738:	a019                	j	73e <vprintf+0x4a>
    } else if(state == '%'){
 73a:	03598263          	beq	s3,s5,75e <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 73e:	2485                	addw	s1,s1,1
 740:	8726                	mv	a4,s1
 742:	009a07b3          	add	a5,s4,s1
 746:	0007c903          	lbu	s2,0(a5)
 74a:	20090c63          	beqz	s2,962 <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 74e:	0009079b          	sext.w	a5,s2
    if(state == 0){
 752:	fe0994e3          	bnez	s3,73a <vprintf+0x46>
      if(c0 == '%'){
 756:	fd579de3          	bne	a5,s5,730 <vprintf+0x3c>
        state = '%';
 75a:	89be                	mv	s3,a5
 75c:	b7cd                	j	73e <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 75e:	00ea06b3          	add	a3,s4,a4
 762:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 766:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 768:	c681                	beqz	a3,770 <vprintf+0x7c>
 76a:	9752                	add	a4,a4,s4
 76c:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 770:	03878f63          	beq	a5,s8,7ae <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 774:	05978963          	beq	a5,s9,7c6 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 778:	07500713          	li	a4,117
 77c:	0ee78363          	beq	a5,a4,862 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 780:	07800713          	li	a4,120
 784:	12e78563          	beq	a5,a4,8ae <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 788:	07000713          	li	a4,112
 78c:	14e78a63          	beq	a5,a4,8e0 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 790:	07300713          	li	a4,115
 794:	18e78a63          	beq	a5,a4,928 <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 798:	02500713          	li	a4,37
 79c:	04e79563          	bne	a5,a4,7e6 <vprintf+0xf2>
        putc(fd, '%');
 7a0:	02500593          	li	a1,37
 7a4:	855a                	mv	a0,s6
 7a6:	e89ff0ef          	jal	62e <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 7aa:	4981                	li	s3,0
 7ac:	bf49                	j	73e <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 7ae:	008b8913          	add	s2,s7,8
 7b2:	4685                	li	a3,1
 7b4:	4629                	li	a2,10
 7b6:	000ba583          	lw	a1,0(s7)
 7ba:	855a                	mv	a0,s6
 7bc:	e91ff0ef          	jal	64c <printint>
 7c0:	8bca                	mv	s7,s2
      state = 0;
 7c2:	4981                	li	s3,0
 7c4:	bfad                	j	73e <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 7c6:	06400793          	li	a5,100
 7ca:	02f68963          	beq	a3,a5,7fc <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 7ce:	06c00793          	li	a5,108
 7d2:	04f68263          	beq	a3,a5,816 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 7d6:	07500793          	li	a5,117
 7da:	0af68063          	beq	a3,a5,87a <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 7de:	07800793          	li	a5,120
 7e2:	0ef68263          	beq	a3,a5,8c6 <vprintf+0x1d2>
        putc(fd, '%');
 7e6:	02500593          	li	a1,37
 7ea:	855a                	mv	a0,s6
 7ec:	e43ff0ef          	jal	62e <putc>
        putc(fd, c0);
 7f0:	85ca                	mv	a1,s2
 7f2:	855a                	mv	a0,s6
 7f4:	e3bff0ef          	jal	62e <putc>
      state = 0;
 7f8:	4981                	li	s3,0
 7fa:	b791                	j	73e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 7fc:	008b8913          	add	s2,s7,8
 800:	4685                	li	a3,1
 802:	4629                	li	a2,10
 804:	000bb583          	ld	a1,0(s7)
 808:	855a                	mv	a0,s6
 80a:	e43ff0ef          	jal	64c <printint>
        i += 1;
 80e:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 810:	8bca                	mv	s7,s2
      state = 0;
 812:	4981                	li	s3,0
        i += 1;
 814:	b72d                	j	73e <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 816:	06400793          	li	a5,100
 81a:	02f60763          	beq	a2,a5,848 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 81e:	07500793          	li	a5,117
 822:	06f60963          	beq	a2,a5,894 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 826:	07800793          	li	a5,120
 82a:	faf61ee3          	bne	a2,a5,7e6 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 82e:	008b8913          	add	s2,s7,8
 832:	4681                	li	a3,0
 834:	4641                	li	a2,16
 836:	000bb583          	ld	a1,0(s7)
 83a:	855a                	mv	a0,s6
 83c:	e11ff0ef          	jal	64c <printint>
        i += 2;
 840:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 842:	8bca                	mv	s7,s2
      state = 0;
 844:	4981                	li	s3,0
        i += 2;
 846:	bde5                	j	73e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 848:	008b8913          	add	s2,s7,8
 84c:	4685                	li	a3,1
 84e:	4629                	li	a2,10
 850:	000bb583          	ld	a1,0(s7)
 854:	855a                	mv	a0,s6
 856:	df7ff0ef          	jal	64c <printint>
        i += 2;
 85a:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 85c:	8bca                	mv	s7,s2
      state = 0;
 85e:	4981                	li	s3,0
        i += 2;
 860:	bdf9                	j	73e <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 862:	008b8913          	add	s2,s7,8
 866:	4681                	li	a3,0
 868:	4629                	li	a2,10
 86a:	000ba583          	lw	a1,0(s7)
 86e:	855a                	mv	a0,s6
 870:	dddff0ef          	jal	64c <printint>
 874:	8bca                	mv	s7,s2
      state = 0;
 876:	4981                	li	s3,0
 878:	b5d9                	j	73e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 87a:	008b8913          	add	s2,s7,8
 87e:	4681                	li	a3,0
 880:	4629                	li	a2,10
 882:	000bb583          	ld	a1,0(s7)
 886:	855a                	mv	a0,s6
 888:	dc5ff0ef          	jal	64c <printint>
        i += 1;
 88c:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 88e:	8bca                	mv	s7,s2
      state = 0;
 890:	4981                	li	s3,0
        i += 1;
 892:	b575                	j	73e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 894:	008b8913          	add	s2,s7,8
 898:	4681                	li	a3,0
 89a:	4629                	li	a2,10
 89c:	000bb583          	ld	a1,0(s7)
 8a0:	855a                	mv	a0,s6
 8a2:	dabff0ef          	jal	64c <printint>
        i += 2;
 8a6:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 8a8:	8bca                	mv	s7,s2
      state = 0;
 8aa:	4981                	li	s3,0
        i += 2;
 8ac:	bd49                	j	73e <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 8ae:	008b8913          	add	s2,s7,8
 8b2:	4681                	li	a3,0
 8b4:	4641                	li	a2,16
 8b6:	000ba583          	lw	a1,0(s7)
 8ba:	855a                	mv	a0,s6
 8bc:	d91ff0ef          	jal	64c <printint>
 8c0:	8bca                	mv	s7,s2
      state = 0;
 8c2:	4981                	li	s3,0
 8c4:	bdad                	j	73e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 8c6:	008b8913          	add	s2,s7,8
 8ca:	4681                	li	a3,0
 8cc:	4641                	li	a2,16
 8ce:	000bb583          	ld	a1,0(s7)
 8d2:	855a                	mv	a0,s6
 8d4:	d79ff0ef          	jal	64c <printint>
        i += 1;
 8d8:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 8da:	8bca                	mv	s7,s2
      state = 0;
 8dc:	4981                	li	s3,0
        i += 1;
 8de:	b585                	j	73e <vprintf+0x4a>
 8e0:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 8e2:	008b8d13          	add	s10,s7,8
 8e6:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 8ea:	03000593          	li	a1,48
 8ee:	855a                	mv	a0,s6
 8f0:	d3fff0ef          	jal	62e <putc>
  putc(fd, 'x');
 8f4:	07800593          	li	a1,120
 8f8:	855a                	mv	a0,s6
 8fa:	d35ff0ef          	jal	62e <putc>
 8fe:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 900:	00000b97          	auipc	s7,0x0
 904:	298b8b93          	add	s7,s7,664 # b98 <digits>
 908:	03c9d793          	srl	a5,s3,0x3c
 90c:	97de                	add	a5,a5,s7
 90e:	0007c583          	lbu	a1,0(a5)
 912:	855a                	mv	a0,s6
 914:	d1bff0ef          	jal	62e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 918:	0992                	sll	s3,s3,0x4
 91a:	397d                	addw	s2,s2,-1
 91c:	fe0916e3          	bnez	s2,908 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 920:	8bea                	mv	s7,s10
      state = 0;
 922:	4981                	li	s3,0
 924:	6d02                	ld	s10,0(sp)
 926:	bd21                	j	73e <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 928:	008b8993          	add	s3,s7,8
 92c:	000bb903          	ld	s2,0(s7)
 930:	00090f63          	beqz	s2,94e <vprintf+0x25a>
        for(; *s; s++)
 934:	00094583          	lbu	a1,0(s2)
 938:	c195                	beqz	a1,95c <vprintf+0x268>
          putc(fd, *s);
 93a:	855a                	mv	a0,s6
 93c:	cf3ff0ef          	jal	62e <putc>
        for(; *s; s++)
 940:	0905                	add	s2,s2,1
 942:	00094583          	lbu	a1,0(s2)
 946:	f9f5                	bnez	a1,93a <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 948:	8bce                	mv	s7,s3
      state = 0;
 94a:	4981                	li	s3,0
 94c:	bbcd                	j	73e <vprintf+0x4a>
          s = "(null)";
 94e:	00000917          	auipc	s2,0x0
 952:	24290913          	add	s2,s2,578 # b90 <malloc+0x12e>
        for(; *s; s++)
 956:	02800593          	li	a1,40
 95a:	b7c5                	j	93a <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 95c:	8bce                	mv	s7,s3
      state = 0;
 95e:	4981                	li	s3,0
 960:	bbf9                	j	73e <vprintf+0x4a>
 962:	64a6                	ld	s1,72(sp)
 964:	79e2                	ld	s3,56(sp)
 966:	7a42                	ld	s4,48(sp)
 968:	7aa2                	ld	s5,40(sp)
 96a:	7b02                	ld	s6,32(sp)
 96c:	6be2                	ld	s7,24(sp)
 96e:	6c42                	ld	s8,16(sp)
 970:	6ca2                	ld	s9,8(sp)
    }
  }
}
 972:	60e6                	ld	ra,88(sp)
 974:	6446                	ld	s0,80(sp)
 976:	6906                	ld	s2,64(sp)
 978:	6125                	add	sp,sp,96
 97a:	8082                	ret

000000000000097c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 97c:	715d                	add	sp,sp,-80
 97e:	ec06                	sd	ra,24(sp)
 980:	e822                	sd	s0,16(sp)
 982:	1000                	add	s0,sp,32
 984:	e010                	sd	a2,0(s0)
 986:	e414                	sd	a3,8(s0)
 988:	e818                	sd	a4,16(s0)
 98a:	ec1c                	sd	a5,24(s0)
 98c:	03043023          	sd	a6,32(s0)
 990:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 994:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 998:	8622                	mv	a2,s0
 99a:	d5bff0ef          	jal	6f4 <vprintf>
}
 99e:	60e2                	ld	ra,24(sp)
 9a0:	6442                	ld	s0,16(sp)
 9a2:	6161                	add	sp,sp,80
 9a4:	8082                	ret

00000000000009a6 <printf>:

void
printf(const char *fmt, ...)
{
 9a6:	711d                	add	sp,sp,-96
 9a8:	ec06                	sd	ra,24(sp)
 9aa:	e822                	sd	s0,16(sp)
 9ac:	1000                	add	s0,sp,32
 9ae:	e40c                	sd	a1,8(s0)
 9b0:	e810                	sd	a2,16(s0)
 9b2:	ec14                	sd	a3,24(s0)
 9b4:	f018                	sd	a4,32(s0)
 9b6:	f41c                	sd	a5,40(s0)
 9b8:	03043823          	sd	a6,48(s0)
 9bc:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 9c0:	00840613          	add	a2,s0,8
 9c4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 9c8:	85aa                	mv	a1,a0
 9ca:	4505                	li	a0,1
 9cc:	d29ff0ef          	jal	6f4 <vprintf>
}
 9d0:	60e2                	ld	ra,24(sp)
 9d2:	6442                	ld	s0,16(sp)
 9d4:	6125                	add	sp,sp,96
 9d6:	8082                	ret

00000000000009d8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9d8:	1141                	add	sp,sp,-16
 9da:	e422                	sd	s0,8(sp)
 9dc:	0800                	add	s0,sp,16
  Header *bp, *p;

  if(ap == 0)
 9de:	cd3d                	beqz	a0,a5c <free+0x84>
    return;
  if((uint64)ap < 4096)
 9e0:	6785                	lui	a5,0x1
 9e2:	06f56d63          	bltu	a0,a5,a5c <free+0x84>
    return;
  bp = (Header*)ap - 1;
 9e6:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9ea:	00000797          	auipc	a5,0x0
 9ee:	61e7b783          	ld	a5,1566(a5) # 1008 <freep>
 9f2:	a02d                	j	a1c <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 9f4:	4618                	lw	a4,8(a2)
 9f6:	9f2d                	addw	a4,a4,a1
 9f8:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 9fc:	6398                	ld	a4,0(a5)
 9fe:	6310                	ld	a2,0(a4)
 a00:	a83d                	j	a3e <free+0x66>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a02:	ff852703          	lw	a4,-8(a0)
 a06:	9f31                	addw	a4,a4,a2
 a08:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a0a:	ff053683          	ld	a3,-16(a0)
 a0e:	a091                	j	a52 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a10:	6398                	ld	a4,0(a5)
 a12:	00e7e463          	bltu	a5,a4,a1a <free+0x42>
 a16:	00e6ea63          	bltu	a3,a4,a2a <free+0x52>
{
 a1a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a1c:	fed7fae3          	bgeu	a5,a3,a10 <free+0x38>
 a20:	6398                	ld	a4,0(a5)
 a22:	00e6e463          	bltu	a3,a4,a2a <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a26:	fee7eae3          	bltu	a5,a4,a1a <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 a2a:	ff852583          	lw	a1,-8(a0)
 a2e:	6390                	ld	a2,0(a5)
 a30:	02059813          	sll	a6,a1,0x20
 a34:	01c85713          	srl	a4,a6,0x1c
 a38:	9736                	add	a4,a4,a3
 a3a:	fae60de3          	beq	a2,a4,9f4 <free+0x1c>
    bp->s.ptr = p->s.ptr->s.ptr;
 a3e:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a42:	4790                	lw	a2,8(a5)
 a44:	02061593          	sll	a1,a2,0x20
 a48:	01c5d713          	srl	a4,a1,0x1c
 a4c:	973e                	add	a4,a4,a5
 a4e:	fae68ae3          	beq	a3,a4,a02 <free+0x2a>
    p->s.ptr = bp->s.ptr;
 a52:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 a54:	00000717          	auipc	a4,0x0
 a58:	5af73a23          	sd	a5,1460(a4) # 1008 <freep>
}
 a5c:	6422                	ld	s0,8(sp)
 a5e:	0141                	add	sp,sp,16
 a60:	8082                	ret

0000000000000a62 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a62:	7139                	add	sp,sp,-64
 a64:	fc06                	sd	ra,56(sp)
 a66:	f822                	sd	s0,48(sp)
 a68:	f426                	sd	s1,40(sp)
 a6a:	ec4e                	sd	s3,24(sp)
 a6c:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a6e:	02051493          	sll	s1,a0,0x20
 a72:	9081                	srl	s1,s1,0x20
 a74:	04bd                	add	s1,s1,15
 a76:	8091                	srl	s1,s1,0x4
 a78:	0014899b          	addw	s3,s1,1
 a7c:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 a7e:	00000517          	auipc	a0,0x0
 a82:	58a53503          	ld	a0,1418(a0) # 1008 <freep>
 a86:	c915                	beqz	a0,aba <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a88:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a8a:	4798                	lw	a4,8(a5)
 a8c:	08977a63          	bgeu	a4,s1,b20 <malloc+0xbe>
 a90:	f04a                	sd	s2,32(sp)
 a92:	e852                	sd	s4,16(sp)
 a94:	e456                	sd	s5,8(sp)
 a96:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 a98:	8a4e                	mv	s4,s3
 a9a:	0009871b          	sext.w	a4,s3
 a9e:	6685                	lui	a3,0x1
 aa0:	00d77363          	bgeu	a4,a3,aa6 <malloc+0x44>
 aa4:	6a05                	lui	s4,0x1
 aa6:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 aaa:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 aae:	00000917          	auipc	s2,0x0
 ab2:	55a90913          	add	s2,s2,1370 # 1008 <freep>
  if(p == (char*)-1)
 ab6:	5afd                	li	s5,-1
 ab8:	a081                	j	af8 <malloc+0x96>
 aba:	f04a                	sd	s2,32(sp)
 abc:	e852                	sd	s4,16(sp)
 abe:	e456                	sd	s5,8(sp)
 ac0:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 ac2:	00000797          	auipc	a5,0x0
 ac6:	54e78793          	add	a5,a5,1358 # 1010 <base>
 aca:	00000717          	auipc	a4,0x0
 ace:	52f73f23          	sd	a5,1342(a4) # 1008 <freep>
 ad2:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 ad4:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 ad8:	b7c1                	j	a98 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 ada:	6398                	ld	a4,0(a5)
 adc:	e118                	sd	a4,0(a0)
 ade:	a8a9                	j	b38 <malloc+0xd6>
  hp->s.size = nu;
 ae0:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 ae4:	0541                	add	a0,a0,16
 ae6:	ef3ff0ef          	jal	9d8 <free>
  return freep;
 aea:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 aee:	c12d                	beqz	a0,b50 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 af0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 af2:	4798                	lw	a4,8(a5)
 af4:	02977263          	bgeu	a4,s1,b18 <malloc+0xb6>
    if(p == freep)
 af8:	00093703          	ld	a4,0(s2)
 afc:	853e                	mv	a0,a5
 afe:	fef719e3          	bne	a4,a5,af0 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 b02:	8552                	mv	a0,s4
 b04:	ab9ff0ef          	jal	5bc <sbrk>
  if(p == (char*)-1)
 b08:	fd551ce3          	bne	a0,s5,ae0 <malloc+0x7e>
        return 0;
 b0c:	4501                	li	a0,0
 b0e:	7902                	ld	s2,32(sp)
 b10:	6a42                	ld	s4,16(sp)
 b12:	6aa2                	ld	s5,8(sp)
 b14:	6b02                	ld	s6,0(sp)
 b16:	a03d                	j	b44 <malloc+0xe2>
 b18:	7902                	ld	s2,32(sp)
 b1a:	6a42                	ld	s4,16(sp)
 b1c:	6aa2                	ld	s5,8(sp)
 b1e:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 b20:	fae48de3          	beq	s1,a4,ada <malloc+0x78>
        p->s.size -= nunits;
 b24:	4137073b          	subw	a4,a4,s3
 b28:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b2a:	02071693          	sll	a3,a4,0x20
 b2e:	01c6d713          	srl	a4,a3,0x1c
 b32:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b34:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b38:	00000717          	auipc	a4,0x0
 b3c:	4ca73823          	sd	a0,1232(a4) # 1008 <freep>
      return (void*)(p + 1);
 b40:	01078513          	add	a0,a5,16
  }
}
 b44:	70e2                	ld	ra,56(sp)
 b46:	7442                	ld	s0,48(sp)
 b48:	74a2                	ld	s1,40(sp)
 b4a:	69e2                	ld	s3,24(sp)
 b4c:	6121                	add	sp,sp,64
 b4e:	8082                	ret
 b50:	7902                	ld	s2,32(sp)
 b52:	6a42                	ld	s4,16(sp)
 b54:	6aa2                	ld	s5,8(sp)
 b56:	6b02                	ld	s6,0(sp)
 b58:	b7f5                	j	b44 <malloc+0xe2>
