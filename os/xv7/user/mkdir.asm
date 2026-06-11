
user/_mkdir:     file format elf64-littleriscv


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
  int i;

  if(argc < 2){
   8:	4785                	li	a5,1
   a:	02a7d763          	bge	a5,a0,38 <main+0x38>
   e:	e426                	sd	s1,8(sp)
  10:	e04a                	sd	s2,0(sp)
  12:	00858493          	add	s1,a1,8
  16:	ffe5091b          	addw	s2,a0,-2
  1a:	02091793          	sll	a5,s2,0x20
  1e:	01d7d913          	srl	s2,a5,0x1d
  22:	05c1                	add	a1,a1,16
  24:	992e                	add	s2,s2,a1
    fprintf(2, "Usage: mkdir files...\n");
    exit(1);
  }

  for(i = 1; i < argc; i++){
    if(mkdir(argv[i]) < 0){
  26:	6088                	ld	a0,0(s1)
  28:	58c000ef          	jal	5b4 <mkdir>
  2c:	02054263          	bltz	a0,50 <main+0x50>
  for(i = 1; i < argc; i++){
  30:	04a1                	add	s1,s1,8
  32:	ff249ae3          	bne	s1,s2,26 <main+0x26>
  36:	a02d                	j	60 <main+0x60>
  38:	e426                	sd	s1,8(sp)
  3a:	e04a                	sd	s2,0(sp)
    fprintf(2, "Usage: mkdir files...\n");
  3c:	00001597          	auipc	a1,0x1
  40:	b4458593          	add	a1,a1,-1212 # b80 <malloc+0x106>
  44:	4509                	li	a0,2
  46:	14f000ef          	jal	994 <fprintf>
    exit(1);
  4a:	4505                	li	a0,1
  4c:	500000ef          	jal	54c <exit>
      fprintf(2, "mkdir: %s failed to create\n", argv[i]);
  50:	6090                	ld	a2,0(s1)
  52:	00001597          	auipc	a1,0x1
  56:	b4658593          	add	a1,a1,-1210 # b98 <malloc+0x11e>
  5a:	4509                	li	a0,2
  5c:	139000ef          	jal	994 <fprintf>
      break;
    }
  }

  exit(0);
  60:	4501                	li	a0,0
  62:	4ea000ef          	jal	54c <exit>

0000000000000066 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  66:	1141                	add	sp,sp,-16
  68:	e406                	sd	ra,8(sp)
  6a:	e022                	sd	s0,0(sp)
  6c:	0800                	add	s0,sp,16
  extern int main();
  main();
  6e:	f93ff0ef          	jal	0 <main>
  exit(0);
  72:	4501                	li	a0,0
  74:	4d8000ef          	jal	54c <exit>

0000000000000078 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  78:	1141                	add	sp,sp,-16
  7a:	e422                	sd	s0,8(sp)
  7c:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  7e:	87aa                	mv	a5,a0
  80:	0585                	add	a1,a1,1
  82:	0785                	add	a5,a5,1
  84:	fff5c703          	lbu	a4,-1(a1)
  88:	fee78fa3          	sb	a4,-1(a5)
  8c:	fb75                	bnez	a4,80 <strcpy+0x8>
    ;
  return os;
}
  8e:	6422                	ld	s0,8(sp)
  90:	0141                	add	sp,sp,16
  92:	8082                	ret

0000000000000094 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  94:	1141                	add	sp,sp,-16
  96:	e422                	sd	s0,8(sp)
  98:	0800                	add	s0,sp,16
  while(*p && *p == *q)
  9a:	00054783          	lbu	a5,0(a0)
  9e:	cb91                	beqz	a5,b2 <strcmp+0x1e>
  a0:	0005c703          	lbu	a4,0(a1)
  a4:	00f71763          	bne	a4,a5,b2 <strcmp+0x1e>
    p++, q++;
  a8:	0505                	add	a0,a0,1
  aa:	0585                	add	a1,a1,1
  while(*p && *p == *q)
  ac:	00054783          	lbu	a5,0(a0)
  b0:	fbe5                	bnez	a5,a0 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  b2:	0005c503          	lbu	a0,0(a1)
}
  b6:	40a7853b          	subw	a0,a5,a0
  ba:	6422                	ld	s0,8(sp)
  bc:	0141                	add	sp,sp,16
  be:	8082                	ret

00000000000000c0 <strlen>:

uint
strlen(const char *s)
{
  c0:	1141                	add	sp,sp,-16
  c2:	e422                	sd	s0,8(sp)
  c4:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  c6:	00054783          	lbu	a5,0(a0)
  ca:	cf91                	beqz	a5,e6 <strlen+0x26>
  cc:	0505                	add	a0,a0,1
  ce:	87aa                	mv	a5,a0
  d0:	86be                	mv	a3,a5
  d2:	0785                	add	a5,a5,1
  d4:	fff7c703          	lbu	a4,-1(a5)
  d8:	ff65                	bnez	a4,d0 <strlen+0x10>
  da:	40a6853b          	subw	a0,a3,a0
  de:	2505                	addw	a0,a0,1
    ;
  return n;
}
  e0:	6422                	ld	s0,8(sp)
  e2:	0141                	add	sp,sp,16
  e4:	8082                	ret
  for(n = 0; s[n]; n++)
  e6:	4501                	li	a0,0
  e8:	bfe5                	j	e0 <strlen+0x20>

00000000000000ea <memset>:

void*
memset(void *dst, int c, uint n)
{
  ea:	1141                	add	sp,sp,-16
  ec:	e422                	sd	s0,8(sp)
  ee:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  f0:	ca19                	beqz	a2,106 <memset+0x1c>
  f2:	87aa                	mv	a5,a0
  f4:	1602                	sll	a2,a2,0x20
  f6:	9201                	srl	a2,a2,0x20
  f8:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  fc:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 100:	0785                	add	a5,a5,1
 102:	fee79de3          	bne	a5,a4,fc <memset+0x12>
  }
  return dst;
}
 106:	6422                	ld	s0,8(sp)
 108:	0141                	add	sp,sp,16
 10a:	8082                	ret

000000000000010c <strchr>:

char*
strchr(const char *s, char c)
{
 10c:	1141                	add	sp,sp,-16
 10e:	e422                	sd	s0,8(sp)
 110:	0800                	add	s0,sp,16
  for(; *s; s++)
 112:	00054783          	lbu	a5,0(a0)
 116:	cb99                	beqz	a5,12c <strchr+0x20>
    if(*s == c)
 118:	00f58763          	beq	a1,a5,126 <strchr+0x1a>
  for(; *s; s++)
 11c:	0505                	add	a0,a0,1
 11e:	00054783          	lbu	a5,0(a0)
 122:	fbfd                	bnez	a5,118 <strchr+0xc>
      return (char*)s;
  return 0;
 124:	4501                	li	a0,0
}
 126:	6422                	ld	s0,8(sp)
 128:	0141                	add	sp,sp,16
 12a:	8082                	ret
  return 0;
 12c:	4501                	li	a0,0
 12e:	bfe5                	j	126 <strchr+0x1a>

0000000000000130 <gets>:

char*
gets(char *buf, int max)
{
 130:	711d                	add	sp,sp,-96
 132:	ec86                	sd	ra,88(sp)
 134:	e8a2                	sd	s0,80(sp)
 136:	e4a6                	sd	s1,72(sp)
 138:	e0ca                	sd	s2,64(sp)
 13a:	fc4e                	sd	s3,56(sp)
 13c:	f852                	sd	s4,48(sp)
 13e:	f456                	sd	s5,40(sp)
 140:	f05a                	sd	s6,32(sp)
 142:	ec5e                	sd	s7,24(sp)
 144:	1080                	add	s0,sp,96
 146:	8baa                	mv	s7,a0
 148:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 14a:	892a                	mv	s2,a0
 14c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 14e:	4aa9                	li	s5,10
 150:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 152:	89a6                	mv	s3,s1
 154:	2485                	addw	s1,s1,1
 156:	0344d663          	bge	s1,s4,182 <gets+0x52>
    cc = read(0, &c, 1);
 15a:	4605                	li	a2,1
 15c:	faf40593          	add	a1,s0,-81
 160:	4501                	li	a0,0
 162:	402000ef          	jal	564 <read>
    if(cc < 1)
 166:	00a05e63          	blez	a0,182 <gets+0x52>
    buf[i++] = c;
 16a:	faf44783          	lbu	a5,-81(s0)
 16e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 172:	01578763          	beq	a5,s5,180 <gets+0x50>
 176:	0905                	add	s2,s2,1
 178:	fd679de3          	bne	a5,s6,152 <gets+0x22>
    buf[i++] = c;
 17c:	89a6                	mv	s3,s1
 17e:	a011                	j	182 <gets+0x52>
 180:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 182:	99de                	add	s3,s3,s7
 184:	00098023          	sb	zero,0(s3)
  return buf;
}
 188:	855e                	mv	a0,s7
 18a:	60e6                	ld	ra,88(sp)
 18c:	6446                	ld	s0,80(sp)
 18e:	64a6                	ld	s1,72(sp)
 190:	6906                	ld	s2,64(sp)
 192:	79e2                	ld	s3,56(sp)
 194:	7a42                	ld	s4,48(sp)
 196:	7aa2                	ld	s5,40(sp)
 198:	7b02                	ld	s6,32(sp)
 19a:	6be2                	ld	s7,24(sp)
 19c:	6125                	add	sp,sp,96
 19e:	8082                	ret

00000000000001a0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1a0:	1101                	add	sp,sp,-32
 1a2:	ec06                	sd	ra,24(sp)
 1a4:	e822                	sd	s0,16(sp)
 1a6:	e04a                	sd	s2,0(sp)
 1a8:	1000                	add	s0,sp,32
 1aa:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1ac:	4581                	li	a1,0
 1ae:	3de000ef          	jal	58c <open>
  if(fd < 0)
 1b2:	02054263          	bltz	a0,1d6 <stat+0x36>
 1b6:	e426                	sd	s1,8(sp)
 1b8:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1ba:	85ca                	mv	a1,s2
 1bc:	3e8000ef          	jal	5a4 <fstat>
 1c0:	892a                	mv	s2,a0
  close(fd);
 1c2:	8526                	mv	a0,s1
 1c4:	3b0000ef          	jal	574 <close>
  return r;
 1c8:	64a2                	ld	s1,8(sp)
}
 1ca:	854a                	mv	a0,s2
 1cc:	60e2                	ld	ra,24(sp)
 1ce:	6442                	ld	s0,16(sp)
 1d0:	6902                	ld	s2,0(sp)
 1d2:	6105                	add	sp,sp,32
 1d4:	8082                	ret
    return -1;
 1d6:	597d                	li	s2,-1
 1d8:	bfcd                	j	1ca <stat+0x2a>

00000000000001da <atoi>:

int
atoi(const char *s)
{
 1da:	1141                	add	sp,sp,-16
 1dc:	e422                	sd	s0,8(sp)
 1de:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1e0:	00054683          	lbu	a3,0(a0)
 1e4:	fd06879b          	addw	a5,a3,-48
 1e8:	0ff7f793          	zext.b	a5,a5
 1ec:	4625                	li	a2,9
 1ee:	02f66863          	bltu	a2,a5,21e <atoi+0x44>
 1f2:	872a                	mv	a4,a0
  n = 0;
 1f4:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 1f6:	0705                	add	a4,a4,1
 1f8:	0025179b          	sllw	a5,a0,0x2
 1fc:	9fa9                	addw	a5,a5,a0
 1fe:	0017979b          	sllw	a5,a5,0x1
 202:	9fb5                	addw	a5,a5,a3
 204:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 208:	00074683          	lbu	a3,0(a4)
 20c:	fd06879b          	addw	a5,a3,-48
 210:	0ff7f793          	zext.b	a5,a5
 214:	fef671e3          	bgeu	a2,a5,1f6 <atoi+0x1c>
  return n;
}
 218:	6422                	ld	s0,8(sp)
 21a:	0141                	add	sp,sp,16
 21c:	8082                	ret
  n = 0;
 21e:	4501                	li	a0,0
 220:	bfe5                	j	218 <atoi+0x3e>

0000000000000222 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 222:	1141                	add	sp,sp,-16
 224:	e422                	sd	s0,8(sp)
 226:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 228:	02b57463          	bgeu	a0,a1,250 <memmove+0x2e>
    while(n-- > 0)
 22c:	00c05f63          	blez	a2,24a <memmove+0x28>
 230:	1602                	sll	a2,a2,0x20
 232:	9201                	srl	a2,a2,0x20
 234:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 238:	872a                	mv	a4,a0
      *dst++ = *src++;
 23a:	0585                	add	a1,a1,1
 23c:	0705                	add	a4,a4,1
 23e:	fff5c683          	lbu	a3,-1(a1)
 242:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 246:	fef71ae3          	bne	a4,a5,23a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 24a:	6422                	ld	s0,8(sp)
 24c:	0141                	add	sp,sp,16
 24e:	8082                	ret
    dst += n;
 250:	00c50733          	add	a4,a0,a2
    src += n;
 254:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 256:	fec05ae3          	blez	a2,24a <memmove+0x28>
 25a:	fff6079b          	addw	a5,a2,-1
 25e:	1782                	sll	a5,a5,0x20
 260:	9381                	srl	a5,a5,0x20
 262:	fff7c793          	not	a5,a5
 266:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 268:	15fd                	add	a1,a1,-1
 26a:	177d                	add	a4,a4,-1
 26c:	0005c683          	lbu	a3,0(a1)
 270:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 274:	fee79ae3          	bne	a5,a4,268 <memmove+0x46>
 278:	bfc9                	j	24a <memmove+0x28>

000000000000027a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 27a:	1141                	add	sp,sp,-16
 27c:	e422                	sd	s0,8(sp)
 27e:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 280:	ca05                	beqz	a2,2b0 <memcmp+0x36>
 282:	fff6069b          	addw	a3,a2,-1
 286:	1682                	sll	a3,a3,0x20
 288:	9281                	srl	a3,a3,0x20
 28a:	0685                	add	a3,a3,1
 28c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 28e:	00054783          	lbu	a5,0(a0)
 292:	0005c703          	lbu	a4,0(a1)
 296:	00e79863          	bne	a5,a4,2a6 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 29a:	0505                	add	a0,a0,1
    p2++;
 29c:	0585                	add	a1,a1,1
  while (n-- > 0) {
 29e:	fed518e3          	bne	a0,a3,28e <memcmp+0x14>
  }
  return 0;
 2a2:	4501                	li	a0,0
 2a4:	a019                	j	2aa <memcmp+0x30>
      return *p1 - *p2;
 2a6:	40e7853b          	subw	a0,a5,a4
}
 2aa:	6422                	ld	s0,8(sp)
 2ac:	0141                	add	sp,sp,16
 2ae:	8082                	ret
  return 0;
 2b0:	4501                	li	a0,0
 2b2:	bfe5                	j	2aa <memcmp+0x30>

00000000000002b4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2b4:	1141                	add	sp,sp,-16
 2b6:	e406                	sd	ra,8(sp)
 2b8:	e022                	sd	s0,0(sp)
 2ba:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 2bc:	f67ff0ef          	jal	222 <memmove>
}
 2c0:	60a2                	ld	ra,8(sp)
 2c2:	6402                	ld	s0,0(sp)
 2c4:	0141                	add	sp,sp,16
 2c6:	8082                	ret

00000000000002c8 <htons>:
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
}

uint16_t
htons(uint16_t h)
{
 2c8:	1141                	add	sp,sp,-16
 2ca:	e422                	sd	s0,8(sp)
 2cc:	0800                	add	s0,sp,16
    if (!endian) {
 2ce:	00001797          	auipc	a5,0x1
 2d2:	d327a783          	lw	a5,-718(a5) # 1000 <endian>
 2d6:	e385                	bnez	a5,2f6 <htons+0x2e>
        endian = byteorder();
 2d8:	4d200793          	li	a5,1234
 2dc:	00001717          	auipc	a4,0x1
 2e0:	d2f72223          	sw	a5,-732(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 2e4:	0085179b          	sllw	a5,a0,0x8
 2e8:	0085551b          	srlw	a0,a0,0x8
 2ec:	8fc9                	or	a5,a5,a0
 2ee:	03079513          	sll	a0,a5,0x30
 2f2:	9141                	srl	a0,a0,0x30
 2f4:	a029                	j	2fe <htons+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(h) : h;
 2f6:	4d200713          	li	a4,1234
 2fa:	fee785e3          	beq	a5,a4,2e4 <htons+0x1c>
}
 2fe:	6422                	ld	s0,8(sp)
 300:	0141                	add	sp,sp,16
 302:	8082                	ret

0000000000000304 <ntohs>:

uint16_t
ntohs(uint16_t n)
{
 304:	1141                	add	sp,sp,-16
 306:	e422                	sd	s0,8(sp)
 308:	0800                	add	s0,sp,16
    if (!endian) {
 30a:	00001797          	auipc	a5,0x1
 30e:	cf67a783          	lw	a5,-778(a5) # 1000 <endian>
 312:	e385                	bnez	a5,332 <ntohs+0x2e>
        endian = byteorder();
 314:	4d200793          	li	a5,1234
 318:	00001717          	auipc	a4,0x1
 31c:	cef72423          	sw	a5,-792(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 320:	0085179b          	sllw	a5,a0,0x8
 324:	0085551b          	srlw	a0,a0,0x8
 328:	8fc9                	or	a5,a5,a0
 32a:	03079513          	sll	a0,a5,0x30
 32e:	9141                	srl	a0,a0,0x30
 330:	a029                	j	33a <ntohs+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(n) : n;
 332:	4d200713          	li	a4,1234
 336:	fee785e3          	beq	a5,a4,320 <ntohs+0x1c>
}
 33a:	6422                	ld	s0,8(sp)
 33c:	0141                	add	sp,sp,16
 33e:	8082                	ret

0000000000000340 <htonl>:

uint32_t
htonl(uint32_t h)
{
 340:	1141                	add	sp,sp,-16
 342:	e422                	sd	s0,8(sp)
 344:	0800                	add	s0,sp,16
    if (!endian) {
 346:	00001797          	auipc	a5,0x1
 34a:	cba7a783          	lw	a5,-838(a5) # 1000 <endian>
 34e:	ef85                	bnez	a5,386 <htonl+0x46>
        endian = byteorder();
 350:	4d200793          	li	a5,1234
 354:	00001717          	auipc	a4,0x1
 358:	caf72623          	sw	a5,-852(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 35c:	0185179b          	sllw	a5,a0,0x18
 360:	0185571b          	srlw	a4,a0,0x18
 364:	8fd9                	or	a5,a5,a4
 366:	0085171b          	sllw	a4,a0,0x8
 36a:	00ff06b7          	lui	a3,0xff0
 36e:	8f75                	and	a4,a4,a3
 370:	8fd9                	or	a5,a5,a4
 372:	0085551b          	srlw	a0,a0,0x8
 376:	6741                	lui	a4,0x10
 378:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeef0>
 37c:	8d79                	and	a0,a0,a4
 37e:	8fc9                	or	a5,a5,a0
 380:	0007851b          	sext.w	a0,a5
 384:	a029                	j	38e <htonl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(h) : h;
 386:	4d200713          	li	a4,1234
 38a:	fce789e3          	beq	a5,a4,35c <htonl+0x1c>
}
 38e:	6422                	ld	s0,8(sp)
 390:	0141                	add	sp,sp,16
 392:	8082                	ret

0000000000000394 <ntohl>:

uint32_t
ntohl(uint32_t n)
{
 394:	1141                	add	sp,sp,-16
 396:	e422                	sd	s0,8(sp)
 398:	0800                	add	s0,sp,16
    if (!endian) {
 39a:	00001797          	auipc	a5,0x1
 39e:	c667a783          	lw	a5,-922(a5) # 1000 <endian>
 3a2:	ef85                	bnez	a5,3da <ntohl+0x46>
        endian = byteorder();
 3a4:	4d200793          	li	a5,1234
 3a8:	00001717          	auipc	a4,0x1
 3ac:	c4f72c23          	sw	a5,-936(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 3b0:	0185179b          	sllw	a5,a0,0x18
 3b4:	0185571b          	srlw	a4,a0,0x18
 3b8:	8fd9                	or	a5,a5,a4
 3ba:	0085171b          	sllw	a4,a0,0x8
 3be:	00ff06b7          	lui	a3,0xff0
 3c2:	8f75                	and	a4,a4,a3
 3c4:	8fd9                	or	a5,a5,a4
 3c6:	0085551b          	srlw	a0,a0,0x8
 3ca:	6741                	lui	a4,0x10
 3cc:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeef0>
 3d0:	8d79                	and	a0,a0,a4
 3d2:	8fc9                	or	a5,a5,a0
 3d4:	0007851b          	sext.w	a0,a5
 3d8:	a029                	j	3e2 <ntohl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(n) : n;
 3da:	4d200713          	li	a4,1234
 3de:	fce789e3          	beq	a5,a4,3b0 <ntohl+0x1c>
}
 3e2:	6422                	ld	s0,8(sp)
 3e4:	0141                	add	sp,sp,16
 3e6:	8082                	ret

00000000000003e8 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
 3e8:	1141                	add	sp,sp,-16
 3ea:	e422                	sd	s0,8(sp)
 3ec:	0800                	add	s0,sp,16
 3ee:	872a                	mv	a4,a0
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
 3f0:	02000693          	li	a3,32
 3f4:	4525                	li	a0,9
 3f6:	a011                	j	3fa <strtol+0x12>
        s++;
 3f8:	0705                	add	a4,a4,1
    while (*s == ' ' || *s == '\t')
 3fa:	00074783          	lbu	a5,0(a4)
 3fe:	fed78de3          	beq	a5,a3,3f8 <strtol+0x10>
 402:	fea78be3          	beq	a5,a0,3f8 <strtol+0x10>

    // plus/minus sign
    if (*s == '+')
 406:	02b00693          	li	a3,43
 40a:	02d78663          	beq	a5,a3,436 <strtol+0x4e>
        s++;
    else if (*s == '-')
 40e:	02d00693          	li	a3,45
    int neg = 0;
 412:	4301                	li	t1,0
    else if (*s == '-')
 414:	02d78463          	beq	a5,a3,43c <strtol+0x54>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 418:	fef67793          	and	a5,a2,-17
 41c:	eb89                	bnez	a5,42e <strtol+0x46>
 41e:	00074683          	lbu	a3,0(a4)
 422:	03000793          	li	a5,48
 426:	00f68e63          	beq	a3,a5,442 <strtol+0x5a>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
 42a:	e211                	bnez	a2,42e <strtol+0x46>
        s++, base = 8;
    else if (base == 0)
        base = 10;
 42c:	4629                	li	a2,10
 42e:	4501                	li	a0,0

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
 430:	4825                	li	a6,9
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
 432:	48e5                	li	a7,25
 434:	a825                	j	46c <strtol+0x84>
        s++;
 436:	0705                	add	a4,a4,1
    int neg = 0;
 438:	4301                	li	t1,0
 43a:	bff9                	j	418 <strtol+0x30>
        s++, neg = 1;
 43c:	0705                	add	a4,a4,1
 43e:	4305                	li	t1,1
 440:	bfe1                	j	418 <strtol+0x30>
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 442:	00174683          	lbu	a3,1(a4)
 446:	07800793          	li	a5,120
 44a:	00f68663          	beq	a3,a5,456 <strtol+0x6e>
    else if (base == 0 && s[0] == '0')
 44e:	f265                	bnez	a2,42e <strtol+0x46>
        s++, base = 8;
 450:	0705                	add	a4,a4,1
 452:	4621                	li	a2,8
 454:	bfe9                	j	42e <strtol+0x46>
        s += 2, base = 16;
 456:	0709                	add	a4,a4,2
 458:	4641                	li	a2,16
 45a:	bfd1                	j	42e <strtol+0x46>
            dig = *s - '0';
 45c:	fd07879b          	addw	a5,a5,-48
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
 460:	04c7d063          	bge	a5,a2,4a0 <strtol+0xb8>
            break;
        s++, val = (val * base) + dig;
 464:	0705                	add	a4,a4,1
 466:	02a60533          	mul	a0,a2,a0
 46a:	953e                	add	a0,a0,a5
        if (*s >= '0' && *s <= '9')
 46c:	00074783          	lbu	a5,0(a4)
 470:	fd07869b          	addw	a3,a5,-48
 474:	0ff6f693          	zext.b	a3,a3
 478:	fed872e3          	bgeu	a6,a3,45c <strtol+0x74>
        else if (*s >= 'a' && *s <= 'z')
 47c:	f9f7869b          	addw	a3,a5,-97
 480:	0ff6f693          	zext.b	a3,a3
 484:	00d8e563          	bltu	a7,a3,48e <strtol+0xa6>
            dig = *s - 'a' + 10;
 488:	fa97879b          	addw	a5,a5,-87
 48c:	bfd1                	j	460 <strtol+0x78>
        else if (*s >= 'A' && *s <= 'Z')
 48e:	fbf7869b          	addw	a3,a5,-65
 492:	0ff6f693          	zext.b	a3,a3
 496:	00d8e563          	bltu	a7,a3,4a0 <strtol+0xb8>
            dig = *s - 'A' + 10;
 49a:	fc97879b          	addw	a5,a5,-55
 49e:	b7c9                	j	460 <strtol+0x78>
        // we don't properly detect overflow!
    }

    if (endptr)
 4a0:	c191                	beqz	a1,4a4 <strtol+0xbc>
        *endptr = (char *) s;
 4a2:	e198                	sd	a4,0(a1)
    return (neg ? -val : val);
 4a4:	00030463          	beqz	t1,4ac <strtol+0xc4>
 4a8:	40a00533          	neg	a0,a0
}
 4ac:	6422                	ld	s0,8(sp)
 4ae:	0141                	add	sp,sp,16
 4b0:	8082                	ret

00000000000004b2 <inet_pton>:
inet_pton (int family, const char *p, void *n) {
    char *sp, *ep;
    int idx;
    long ret;

    if (family != AF_INET) {
 4b2:	4785                	li	a5,1
 4b4:	08f51063          	bne	a0,a5,534 <inet_pton+0x82>
inet_pton (int family, const char *p, void *n) {
 4b8:	715d                	add	sp,sp,-80
 4ba:	e486                	sd	ra,72(sp)
 4bc:	e0a2                	sd	s0,64(sp)
 4be:	fc26                	sd	s1,56(sp)
 4c0:	f84a                	sd	s2,48(sp)
 4c2:	f44e                	sd	s3,40(sp)
 4c4:	f052                	sd	s4,32(sp)
 4c6:	ec56                	sd	s5,24(sp)
 4c8:	e85a                	sd	s6,16(sp)
 4ca:	0880                	add	s0,sp,80
 4cc:	84ae                	mv	s1,a1
 4ce:	89b2                	mv	s3,a2
 4d0:	4901                	li	s2,0
        return -1;
    }
    sp = (char *)p;
    for (idx = 0; idx < 4; idx++) {
        ret = strtol(sp, &ep, 10);
        if (ret < 0 || ret > 255) {
 4d2:	0ff00a13          	li	s4,255
            return -1;
        }
        if (ep == sp) {
            return -1;
        }
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 4d6:	4a8d                	li	s5,3
 4d8:	02e00b13          	li	s6,46
 4dc:	a805                	j	50c <inet_pton+0x5a>
 4de:	0007c783          	lbu	a5,0(a5)
 4e2:	efb9                	bnez	a5,540 <inet_pton+0x8e>
            return -1;
        }
        ((uint8_t *)n)[idx] = ret;
 4e4:	00a981a3          	sb	a0,3(s3)
        sp = ep + 1;
    }
    return 0;
 4e8:	4501                	li	a0,0
}
 4ea:	60a6                	ld	ra,72(sp)
 4ec:	6406                	ld	s0,64(sp)
 4ee:	74e2                	ld	s1,56(sp)
 4f0:	7942                	ld	s2,48(sp)
 4f2:	79a2                	ld	s3,40(sp)
 4f4:	7a02                	ld	s4,32(sp)
 4f6:	6ae2                	ld	s5,24(sp)
 4f8:	6b42                	ld	s6,16(sp)
 4fa:	6161                	add	sp,sp,80
 4fc:	8082                	ret
        ((uint8_t *)n)[idx] = ret;
 4fe:	01298733          	add	a4,s3,s2
 502:	00a70023          	sb	a0,0(a4)
        sp = ep + 1;
 506:	00178493          	add	s1,a5,1
    for (idx = 0; idx < 4; idx++) {
 50a:	0905                	add	s2,s2,1
        ret = strtol(sp, &ep, 10);
 50c:	4629                	li	a2,10
 50e:	fb840593          	add	a1,s0,-72
 512:	8526                	mv	a0,s1
 514:	ed5ff0ef          	jal	3e8 <strtol>
        if (ret < 0 || ret > 255) {
 518:	02aa6063          	bltu	s4,a0,538 <inet_pton+0x86>
        if (ep == sp) {
 51c:	fb843783          	ld	a5,-72(s0)
 520:	00978e63          	beq	a5,s1,53c <inet_pton+0x8a>
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 524:	fb590de3          	beq	s2,s5,4de <inet_pton+0x2c>
 528:	0007c703          	lbu	a4,0(a5)
 52c:	fd6709e3          	beq	a4,s6,4fe <inet_pton+0x4c>
            return -1;
 530:	557d                	li	a0,-1
 532:	bf65                	j	4ea <inet_pton+0x38>
        return -1;
 534:	557d                	li	a0,-1
}
 536:	8082                	ret
            return -1;
 538:	557d                	li	a0,-1
 53a:	bf45                	j	4ea <inet_pton+0x38>
            return -1;
 53c:	557d                	li	a0,-1
 53e:	b775                	j	4ea <inet_pton+0x38>
            return -1;
 540:	557d                	li	a0,-1
 542:	b765                	j	4ea <inet_pton+0x38>

0000000000000544 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 544:	4885                	li	a7,1
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <exit>:
.global exit
exit:
 li a7, SYS_exit
 54c:	4889                	li	a7,2
 ecall
 54e:	00000073          	ecall
 ret
 552:	8082                	ret

0000000000000554 <wait>:
.global wait
wait:
 li a7, SYS_wait
 554:	488d                	li	a7,3
 ecall
 556:	00000073          	ecall
 ret
 55a:	8082                	ret

000000000000055c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 55c:	4891                	li	a7,4
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <read>:
.global read
read:
 li a7, SYS_read
 564:	4895                	li	a7,5
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <write>:
.global write
write:
 li a7, SYS_write
 56c:	48c1                	li	a7,16
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <close>:
.global close
close:
 li a7, SYS_close
 574:	48d5                	li	a7,21
 ecall
 576:	00000073          	ecall
 ret
 57a:	8082                	ret

000000000000057c <kill>:
.global kill
kill:
 li a7, SYS_kill
 57c:	4899                	li	a7,6
 ecall
 57e:	00000073          	ecall
 ret
 582:	8082                	ret

0000000000000584 <exec>:
.global exec
exec:
 li a7, SYS_exec
 584:	489d                	li	a7,7
 ecall
 586:	00000073          	ecall
 ret
 58a:	8082                	ret

000000000000058c <open>:
.global open
open:
 li a7, SYS_open
 58c:	48bd                	li	a7,15
 ecall
 58e:	00000073          	ecall
 ret
 592:	8082                	ret

0000000000000594 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 594:	48c5                	li	a7,17
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 59c:	48c9                	li	a7,18
 ecall
 59e:	00000073          	ecall
 ret
 5a2:	8082                	ret

00000000000005a4 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5a4:	48a1                	li	a7,8
 ecall
 5a6:	00000073          	ecall
 ret
 5aa:	8082                	ret

00000000000005ac <link>:
.global link
link:
 li a7, SYS_link
 5ac:	48cd                	li	a7,19
 ecall
 5ae:	00000073          	ecall
 ret
 5b2:	8082                	ret

00000000000005b4 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5b4:	48d1                	li	a7,20
 ecall
 5b6:	00000073          	ecall
 ret
 5ba:	8082                	ret

00000000000005bc <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5bc:	48a5                	li	a7,9
 ecall
 5be:	00000073          	ecall
 ret
 5c2:	8082                	ret

00000000000005c4 <dup>:
.global dup
dup:
 li a7, SYS_dup
 5c4:	48a9                	li	a7,10
 ecall
 5c6:	00000073          	ecall
 ret
 5ca:	8082                	ret

00000000000005cc <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5cc:	48ad                	li	a7,11
 ecall
 5ce:	00000073          	ecall
 ret
 5d2:	8082                	ret

00000000000005d4 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5d4:	48b1                	li	a7,12
 ecall
 5d6:	00000073          	ecall
 ret
 5da:	8082                	ret

00000000000005dc <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5dc:	48b5                	li	a7,13
 ecall
 5de:	00000073          	ecall
 ret
 5e2:	8082                	ret

00000000000005e4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5e4:	48b9                	li	a7,14
 ecall
 5e6:	00000073          	ecall
 ret
 5ea:	8082                	ret

00000000000005ec <socket>:
.global socket
socket:
 li a7, SYS_socket
 5ec:	48d9                	li	a7,22
 ecall
 5ee:	00000073          	ecall
 ret
 5f2:	8082                	ret

00000000000005f4 <bind>:
.global bind
bind:
 li a7, SYS_bind
 5f4:	48dd                	li	a7,23
 ecall
 5f6:	00000073          	ecall
 ret
 5fa:	8082                	ret

00000000000005fc <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 5fc:	48e1                	li	a7,24
 ecall
 5fe:	00000073          	ecall
 ret
 602:	8082                	ret

0000000000000604 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 604:	48e5                	li	a7,25
 ecall
 606:	00000073          	ecall
 ret
 60a:	8082                	ret

000000000000060c <connect>:
.global connect
connect:
 li a7, SYS_connect
 60c:	48e9                	li	a7,26
 ecall
 60e:	00000073          	ecall
 ret
 612:	8082                	ret

0000000000000614 <listen>:
.global listen
listen:
 li a7, SYS_listen
 614:	48ed                	li	a7,27
 ecall
 616:	00000073          	ecall
 ret
 61a:	8082                	ret

000000000000061c <accept>:
.global accept
accept:
 li a7, SYS_accept
 61c:	48f1                	li	a7,28
 ecall
 61e:	00000073          	ecall
 ret
 622:	8082                	ret

0000000000000624 <recv>:
.global recv
recv:
 li a7, SYS_recv
 624:	48f5                	li	a7,29
 ecall
 626:	00000073          	ecall
 ret
 62a:	8082                	ret

000000000000062c <send>:
.global send
send:
 li a7, SYS_send
 62c:	48f9                	li	a7,30
 ecall
 62e:	00000073          	ecall
 ret
 632:	8082                	ret

0000000000000634 <ioctl>:
.global ioctl
ioctl:
 li a7, SYS_ioctl
 634:	48fd                	li	a7,31
 ecall
 636:	00000073          	ecall
 ret
 63a:	8082                	ret

000000000000063c <consolemode>:
.global consolemode
consolemode:
 li a7, SYS_consolemode
 63c:	02000893          	li	a7,32
 ecall
 640:	00000073          	ecall
 ret
 644:	8082                	ret

0000000000000646 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 646:	1101                	add	sp,sp,-32
 648:	ec06                	sd	ra,24(sp)
 64a:	e822                	sd	s0,16(sp)
 64c:	1000                	add	s0,sp,32
 64e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 652:	4605                	li	a2,1
 654:	fef40593          	add	a1,s0,-17
 658:	f15ff0ef          	jal	56c <write>
}
 65c:	60e2                	ld	ra,24(sp)
 65e:	6442                	ld	s0,16(sp)
 660:	6105                	add	sp,sp,32
 662:	8082                	ret

0000000000000664 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 664:	715d                	add	sp,sp,-80
 666:	e486                	sd	ra,72(sp)
 668:	e0a2                	sd	s0,64(sp)
 66a:	fc26                	sd	s1,56(sp)
 66c:	0880                	add	s0,sp,80
 66e:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 670:	c299                	beqz	a3,676 <printint+0x12>
 672:	0805c963          	bltz	a1,704 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 676:	2581                	sext.w	a1,a1
  neg = 0;
 678:	4881                	li	a7,0
 67a:	fb840693          	add	a3,s0,-72
  }

  i = 0;
 67e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 680:	2601                	sext.w	a2,a2
 682:	00000517          	auipc	a0,0x0
 686:	53e50513          	add	a0,a0,1342 # bc0 <digits>
 68a:	883a                	mv	a6,a4
 68c:	2705                	addw	a4,a4,1
 68e:	02c5f7bb          	remuw	a5,a1,a2
 692:	1782                	sll	a5,a5,0x20
 694:	9381                	srl	a5,a5,0x20
 696:	97aa                	add	a5,a5,a0
 698:	0007c783          	lbu	a5,0(a5)
 69c:	00f68023          	sb	a5,0(a3) # ff0000 <base+0xfeeff0>
  }while((x /= base) != 0);
 6a0:	0005879b          	sext.w	a5,a1
 6a4:	02c5d5bb          	divuw	a1,a1,a2
 6a8:	0685                	add	a3,a3,1
 6aa:	fec7f0e3          	bgeu	a5,a2,68a <printint+0x26>
  if(neg)
 6ae:	00088c63          	beqz	a7,6c6 <printint+0x62>
    buf[i++] = '-';
 6b2:	fd070793          	add	a5,a4,-48
 6b6:	00878733          	add	a4,a5,s0
 6ba:	02d00793          	li	a5,45
 6be:	fef70423          	sb	a5,-24(a4)
 6c2:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 6c6:	02e05a63          	blez	a4,6fa <printint+0x96>
 6ca:	f84a                	sd	s2,48(sp)
 6cc:	f44e                	sd	s3,40(sp)
 6ce:	fb840793          	add	a5,s0,-72
 6d2:	00e78933          	add	s2,a5,a4
 6d6:	fff78993          	add	s3,a5,-1
 6da:	99ba                	add	s3,s3,a4
 6dc:	377d                	addw	a4,a4,-1
 6de:	1702                	sll	a4,a4,0x20
 6e0:	9301                	srl	a4,a4,0x20
 6e2:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 6e6:	fff94583          	lbu	a1,-1(s2)
 6ea:	8526                	mv	a0,s1
 6ec:	f5bff0ef          	jal	646 <putc>
  while(--i >= 0)
 6f0:	197d                	add	s2,s2,-1
 6f2:	ff391ae3          	bne	s2,s3,6e6 <printint+0x82>
 6f6:	7942                	ld	s2,48(sp)
 6f8:	79a2                	ld	s3,40(sp)
}
 6fa:	60a6                	ld	ra,72(sp)
 6fc:	6406                	ld	s0,64(sp)
 6fe:	74e2                	ld	s1,56(sp)
 700:	6161                	add	sp,sp,80
 702:	8082                	ret
    x = -xx;
 704:	40b005bb          	negw	a1,a1
    neg = 1;
 708:	4885                	li	a7,1
    x = -xx;
 70a:	bf85                	j	67a <printint+0x16>

000000000000070c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 70c:	711d                	add	sp,sp,-96
 70e:	ec86                	sd	ra,88(sp)
 710:	e8a2                	sd	s0,80(sp)
 712:	e0ca                	sd	s2,64(sp)
 714:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 716:	0005c903          	lbu	s2,0(a1)
 71a:	26090863          	beqz	s2,98a <vprintf+0x27e>
 71e:	e4a6                	sd	s1,72(sp)
 720:	fc4e                	sd	s3,56(sp)
 722:	f852                	sd	s4,48(sp)
 724:	f456                	sd	s5,40(sp)
 726:	f05a                	sd	s6,32(sp)
 728:	ec5e                	sd	s7,24(sp)
 72a:	e862                	sd	s8,16(sp)
 72c:	e466                	sd	s9,8(sp)
 72e:	8b2a                	mv	s6,a0
 730:	8a2e                	mv	s4,a1
 732:	8bb2                	mv	s7,a2
  state = 0;
 734:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 736:	4481                	li	s1,0
 738:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 73a:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 73e:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 742:	06c00c93          	li	s9,108
 746:	a005                	j	766 <vprintf+0x5a>
        putc(fd, c0);
 748:	85ca                	mv	a1,s2
 74a:	855a                	mv	a0,s6
 74c:	efbff0ef          	jal	646 <putc>
 750:	a019                	j	756 <vprintf+0x4a>
    } else if(state == '%'){
 752:	03598263          	beq	s3,s5,776 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 756:	2485                	addw	s1,s1,1
 758:	8726                	mv	a4,s1
 75a:	009a07b3          	add	a5,s4,s1
 75e:	0007c903          	lbu	s2,0(a5)
 762:	20090c63          	beqz	s2,97a <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 766:	0009079b          	sext.w	a5,s2
    if(state == 0){
 76a:	fe0994e3          	bnez	s3,752 <vprintf+0x46>
      if(c0 == '%'){
 76e:	fd579de3          	bne	a5,s5,748 <vprintf+0x3c>
        state = '%';
 772:	89be                	mv	s3,a5
 774:	b7cd                	j	756 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 776:	00ea06b3          	add	a3,s4,a4
 77a:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 77e:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 780:	c681                	beqz	a3,788 <vprintf+0x7c>
 782:	9752                	add	a4,a4,s4
 784:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 788:	03878f63          	beq	a5,s8,7c6 <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 78c:	05978963          	beq	a5,s9,7de <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 790:	07500713          	li	a4,117
 794:	0ee78363          	beq	a5,a4,87a <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 798:	07800713          	li	a4,120
 79c:	12e78563          	beq	a5,a4,8c6 <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 7a0:	07000713          	li	a4,112
 7a4:	14e78a63          	beq	a5,a4,8f8 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 7a8:	07300713          	li	a4,115
 7ac:	18e78a63          	beq	a5,a4,940 <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 7b0:	02500713          	li	a4,37
 7b4:	04e79563          	bne	a5,a4,7fe <vprintf+0xf2>
        putc(fd, '%');
 7b8:	02500593          	li	a1,37
 7bc:	855a                	mv	a0,s6
 7be:	e89ff0ef          	jal	646 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 7c2:	4981                	li	s3,0
 7c4:	bf49                	j	756 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 7c6:	008b8913          	add	s2,s7,8
 7ca:	4685                	li	a3,1
 7cc:	4629                	li	a2,10
 7ce:	000ba583          	lw	a1,0(s7)
 7d2:	855a                	mv	a0,s6
 7d4:	e91ff0ef          	jal	664 <printint>
 7d8:	8bca                	mv	s7,s2
      state = 0;
 7da:	4981                	li	s3,0
 7dc:	bfad                	j	756 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 7de:	06400793          	li	a5,100
 7e2:	02f68963          	beq	a3,a5,814 <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 7e6:	06c00793          	li	a5,108
 7ea:	04f68263          	beq	a3,a5,82e <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 7ee:	07500793          	li	a5,117
 7f2:	0af68063          	beq	a3,a5,892 <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 7f6:	07800793          	li	a5,120
 7fa:	0ef68263          	beq	a3,a5,8de <vprintf+0x1d2>
        putc(fd, '%');
 7fe:	02500593          	li	a1,37
 802:	855a                	mv	a0,s6
 804:	e43ff0ef          	jal	646 <putc>
        putc(fd, c0);
 808:	85ca                	mv	a1,s2
 80a:	855a                	mv	a0,s6
 80c:	e3bff0ef          	jal	646 <putc>
      state = 0;
 810:	4981                	li	s3,0
 812:	b791                	j	756 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 814:	008b8913          	add	s2,s7,8
 818:	4685                	li	a3,1
 81a:	4629                	li	a2,10
 81c:	000bb583          	ld	a1,0(s7)
 820:	855a                	mv	a0,s6
 822:	e43ff0ef          	jal	664 <printint>
        i += 1;
 826:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 828:	8bca                	mv	s7,s2
      state = 0;
 82a:	4981                	li	s3,0
        i += 1;
 82c:	b72d                	j	756 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 82e:	06400793          	li	a5,100
 832:	02f60763          	beq	a2,a5,860 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 836:	07500793          	li	a5,117
 83a:	06f60963          	beq	a2,a5,8ac <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 83e:	07800793          	li	a5,120
 842:	faf61ee3          	bne	a2,a5,7fe <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 846:	008b8913          	add	s2,s7,8
 84a:	4681                	li	a3,0
 84c:	4641                	li	a2,16
 84e:	000bb583          	ld	a1,0(s7)
 852:	855a                	mv	a0,s6
 854:	e11ff0ef          	jal	664 <printint>
        i += 2;
 858:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 85a:	8bca                	mv	s7,s2
      state = 0;
 85c:	4981                	li	s3,0
        i += 2;
 85e:	bde5                	j	756 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 860:	008b8913          	add	s2,s7,8
 864:	4685                	li	a3,1
 866:	4629                	li	a2,10
 868:	000bb583          	ld	a1,0(s7)
 86c:	855a                	mv	a0,s6
 86e:	df7ff0ef          	jal	664 <printint>
        i += 2;
 872:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 874:	8bca                	mv	s7,s2
      state = 0;
 876:	4981                	li	s3,0
        i += 2;
 878:	bdf9                	j	756 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 87a:	008b8913          	add	s2,s7,8
 87e:	4681                	li	a3,0
 880:	4629                	li	a2,10
 882:	000ba583          	lw	a1,0(s7)
 886:	855a                	mv	a0,s6
 888:	dddff0ef          	jal	664 <printint>
 88c:	8bca                	mv	s7,s2
      state = 0;
 88e:	4981                	li	s3,0
 890:	b5d9                	j	756 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 892:	008b8913          	add	s2,s7,8
 896:	4681                	li	a3,0
 898:	4629                	li	a2,10
 89a:	000bb583          	ld	a1,0(s7)
 89e:	855a                	mv	a0,s6
 8a0:	dc5ff0ef          	jal	664 <printint>
        i += 1;
 8a4:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 8a6:	8bca                	mv	s7,s2
      state = 0;
 8a8:	4981                	li	s3,0
        i += 1;
 8aa:	b575                	j	756 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8ac:	008b8913          	add	s2,s7,8
 8b0:	4681                	li	a3,0
 8b2:	4629                	li	a2,10
 8b4:	000bb583          	ld	a1,0(s7)
 8b8:	855a                	mv	a0,s6
 8ba:	dabff0ef          	jal	664 <printint>
        i += 2;
 8be:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 8c0:	8bca                	mv	s7,s2
      state = 0;
 8c2:	4981                	li	s3,0
        i += 2;
 8c4:	bd49                	j	756 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 8c6:	008b8913          	add	s2,s7,8
 8ca:	4681                	li	a3,0
 8cc:	4641                	li	a2,16
 8ce:	000ba583          	lw	a1,0(s7)
 8d2:	855a                	mv	a0,s6
 8d4:	d91ff0ef          	jal	664 <printint>
 8d8:	8bca                	mv	s7,s2
      state = 0;
 8da:	4981                	li	s3,0
 8dc:	bdad                	j	756 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 8de:	008b8913          	add	s2,s7,8
 8e2:	4681                	li	a3,0
 8e4:	4641                	li	a2,16
 8e6:	000bb583          	ld	a1,0(s7)
 8ea:	855a                	mv	a0,s6
 8ec:	d79ff0ef          	jal	664 <printint>
        i += 1;
 8f0:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 8f2:	8bca                	mv	s7,s2
      state = 0;
 8f4:	4981                	li	s3,0
        i += 1;
 8f6:	b585                	j	756 <vprintf+0x4a>
 8f8:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 8fa:	008b8d13          	add	s10,s7,8
 8fe:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 902:	03000593          	li	a1,48
 906:	855a                	mv	a0,s6
 908:	d3fff0ef          	jal	646 <putc>
  putc(fd, 'x');
 90c:	07800593          	li	a1,120
 910:	855a                	mv	a0,s6
 912:	d35ff0ef          	jal	646 <putc>
 916:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 918:	00000b97          	auipc	s7,0x0
 91c:	2a8b8b93          	add	s7,s7,680 # bc0 <digits>
 920:	03c9d793          	srl	a5,s3,0x3c
 924:	97de                	add	a5,a5,s7
 926:	0007c583          	lbu	a1,0(a5)
 92a:	855a                	mv	a0,s6
 92c:	d1bff0ef          	jal	646 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 930:	0992                	sll	s3,s3,0x4
 932:	397d                	addw	s2,s2,-1
 934:	fe0916e3          	bnez	s2,920 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 938:	8bea                	mv	s7,s10
      state = 0;
 93a:	4981                	li	s3,0
 93c:	6d02                	ld	s10,0(sp)
 93e:	bd21                	j	756 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 940:	008b8993          	add	s3,s7,8
 944:	000bb903          	ld	s2,0(s7)
 948:	00090f63          	beqz	s2,966 <vprintf+0x25a>
        for(; *s; s++)
 94c:	00094583          	lbu	a1,0(s2)
 950:	c195                	beqz	a1,974 <vprintf+0x268>
          putc(fd, *s);
 952:	855a                	mv	a0,s6
 954:	cf3ff0ef          	jal	646 <putc>
        for(; *s; s++)
 958:	0905                	add	s2,s2,1
 95a:	00094583          	lbu	a1,0(s2)
 95e:	f9f5                	bnez	a1,952 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 960:	8bce                	mv	s7,s3
      state = 0;
 962:	4981                	li	s3,0
 964:	bbcd                	j	756 <vprintf+0x4a>
          s = "(null)";
 966:	00000917          	auipc	s2,0x0
 96a:	25290913          	add	s2,s2,594 # bb8 <malloc+0x13e>
        for(; *s; s++)
 96e:	02800593          	li	a1,40
 972:	b7c5                	j	952 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 974:	8bce                	mv	s7,s3
      state = 0;
 976:	4981                	li	s3,0
 978:	bbf9                	j	756 <vprintf+0x4a>
 97a:	64a6                	ld	s1,72(sp)
 97c:	79e2                	ld	s3,56(sp)
 97e:	7a42                	ld	s4,48(sp)
 980:	7aa2                	ld	s5,40(sp)
 982:	7b02                	ld	s6,32(sp)
 984:	6be2                	ld	s7,24(sp)
 986:	6c42                	ld	s8,16(sp)
 988:	6ca2                	ld	s9,8(sp)
    }
  }
}
 98a:	60e6                	ld	ra,88(sp)
 98c:	6446                	ld	s0,80(sp)
 98e:	6906                	ld	s2,64(sp)
 990:	6125                	add	sp,sp,96
 992:	8082                	ret

0000000000000994 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 994:	715d                	add	sp,sp,-80
 996:	ec06                	sd	ra,24(sp)
 998:	e822                	sd	s0,16(sp)
 99a:	1000                	add	s0,sp,32
 99c:	e010                	sd	a2,0(s0)
 99e:	e414                	sd	a3,8(s0)
 9a0:	e818                	sd	a4,16(s0)
 9a2:	ec1c                	sd	a5,24(s0)
 9a4:	03043023          	sd	a6,32(s0)
 9a8:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 9ac:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 9b0:	8622                	mv	a2,s0
 9b2:	d5bff0ef          	jal	70c <vprintf>
}
 9b6:	60e2                	ld	ra,24(sp)
 9b8:	6442                	ld	s0,16(sp)
 9ba:	6161                	add	sp,sp,80
 9bc:	8082                	ret

00000000000009be <printf>:

void
printf(const char *fmt, ...)
{
 9be:	711d                	add	sp,sp,-96
 9c0:	ec06                	sd	ra,24(sp)
 9c2:	e822                	sd	s0,16(sp)
 9c4:	1000                	add	s0,sp,32
 9c6:	e40c                	sd	a1,8(s0)
 9c8:	e810                	sd	a2,16(s0)
 9ca:	ec14                	sd	a3,24(s0)
 9cc:	f018                	sd	a4,32(s0)
 9ce:	f41c                	sd	a5,40(s0)
 9d0:	03043823          	sd	a6,48(s0)
 9d4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 9d8:	00840613          	add	a2,s0,8
 9dc:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 9e0:	85aa                	mv	a1,a0
 9e2:	4505                	li	a0,1
 9e4:	d29ff0ef          	jal	70c <vprintf>
}
 9e8:	60e2                	ld	ra,24(sp)
 9ea:	6442                	ld	s0,16(sp)
 9ec:	6125                	add	sp,sp,96
 9ee:	8082                	ret

00000000000009f0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9f0:	1141                	add	sp,sp,-16
 9f2:	e422                	sd	s0,8(sp)
 9f4:	0800                	add	s0,sp,16
  Header *bp, *p;

  if(ap == 0)
 9f6:	cd3d                	beqz	a0,a74 <free+0x84>
    return;
  if((uint64)ap < 4096)
 9f8:	6785                	lui	a5,0x1
 9fa:	06f56d63          	bltu	a0,a5,a74 <free+0x84>
    return;
  bp = (Header*)ap - 1;
 9fe:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a02:	00000797          	auipc	a5,0x0
 a06:	6067b783          	ld	a5,1542(a5) # 1008 <freep>
 a0a:	a02d                	j	a34 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a0c:	4618                	lw	a4,8(a2)
 a0e:	9f2d                	addw	a4,a4,a1
 a10:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a14:	6398                	ld	a4,0(a5)
 a16:	6310                	ld	a2,0(a4)
 a18:	a83d                	j	a56 <free+0x66>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a1a:	ff852703          	lw	a4,-8(a0)
 a1e:	9f31                	addw	a4,a4,a2
 a20:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a22:	ff053683          	ld	a3,-16(a0)
 a26:	a091                	j	a6a <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a28:	6398                	ld	a4,0(a5)
 a2a:	00e7e463          	bltu	a5,a4,a32 <free+0x42>
 a2e:	00e6ea63          	bltu	a3,a4,a42 <free+0x52>
{
 a32:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a34:	fed7fae3          	bgeu	a5,a3,a28 <free+0x38>
 a38:	6398                	ld	a4,0(a5)
 a3a:	00e6e463          	bltu	a3,a4,a42 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a3e:	fee7eae3          	bltu	a5,a4,a32 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 a42:	ff852583          	lw	a1,-8(a0)
 a46:	6390                	ld	a2,0(a5)
 a48:	02059813          	sll	a6,a1,0x20
 a4c:	01c85713          	srl	a4,a6,0x1c
 a50:	9736                	add	a4,a4,a3
 a52:	fae60de3          	beq	a2,a4,a0c <free+0x1c>
    bp->s.ptr = p->s.ptr->s.ptr;
 a56:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a5a:	4790                	lw	a2,8(a5)
 a5c:	02061593          	sll	a1,a2,0x20
 a60:	01c5d713          	srl	a4,a1,0x1c
 a64:	973e                	add	a4,a4,a5
 a66:	fae68ae3          	beq	a3,a4,a1a <free+0x2a>
    p->s.ptr = bp->s.ptr;
 a6a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 a6c:	00000717          	auipc	a4,0x0
 a70:	58f73e23          	sd	a5,1436(a4) # 1008 <freep>
}
 a74:	6422                	ld	s0,8(sp)
 a76:	0141                	add	sp,sp,16
 a78:	8082                	ret

0000000000000a7a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a7a:	7139                	add	sp,sp,-64
 a7c:	fc06                	sd	ra,56(sp)
 a7e:	f822                	sd	s0,48(sp)
 a80:	f426                	sd	s1,40(sp)
 a82:	ec4e                	sd	s3,24(sp)
 a84:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a86:	02051493          	sll	s1,a0,0x20
 a8a:	9081                	srl	s1,s1,0x20
 a8c:	04bd                	add	s1,s1,15
 a8e:	8091                	srl	s1,s1,0x4
 a90:	0014899b          	addw	s3,s1,1
 a94:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 a96:	00000517          	auipc	a0,0x0
 a9a:	57253503          	ld	a0,1394(a0) # 1008 <freep>
 a9e:	c915                	beqz	a0,ad2 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 aa0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 aa2:	4798                	lw	a4,8(a5)
 aa4:	08977a63          	bgeu	a4,s1,b38 <malloc+0xbe>
 aa8:	f04a                	sd	s2,32(sp)
 aaa:	e852                	sd	s4,16(sp)
 aac:	e456                	sd	s5,8(sp)
 aae:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 ab0:	8a4e                	mv	s4,s3
 ab2:	0009871b          	sext.w	a4,s3
 ab6:	6685                	lui	a3,0x1
 ab8:	00d77363          	bgeu	a4,a3,abe <malloc+0x44>
 abc:	6a05                	lui	s4,0x1
 abe:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 ac2:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ac6:	00000917          	auipc	s2,0x0
 aca:	54290913          	add	s2,s2,1346 # 1008 <freep>
  if(p == (char*)-1)
 ace:	5afd                	li	s5,-1
 ad0:	a081                	j	b10 <malloc+0x96>
 ad2:	f04a                	sd	s2,32(sp)
 ad4:	e852                	sd	s4,16(sp)
 ad6:	e456                	sd	s5,8(sp)
 ad8:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 ada:	00000797          	auipc	a5,0x0
 ade:	53678793          	add	a5,a5,1334 # 1010 <base>
 ae2:	00000717          	auipc	a4,0x0
 ae6:	52f73323          	sd	a5,1318(a4) # 1008 <freep>
 aea:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 aec:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 af0:	b7c1                	j	ab0 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 af2:	6398                	ld	a4,0(a5)
 af4:	e118                	sd	a4,0(a0)
 af6:	a8a9                	j	b50 <malloc+0xd6>
  hp->s.size = nu;
 af8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 afc:	0541                	add	a0,a0,16
 afe:	ef3ff0ef          	jal	9f0 <free>
  return freep;
 b02:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 b06:	c12d                	beqz	a0,b68 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b08:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b0a:	4798                	lw	a4,8(a5)
 b0c:	02977263          	bgeu	a4,s1,b30 <malloc+0xb6>
    if(p == freep)
 b10:	00093703          	ld	a4,0(s2)
 b14:	853e                	mv	a0,a5
 b16:	fef719e3          	bne	a4,a5,b08 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 b1a:	8552                	mv	a0,s4
 b1c:	ab9ff0ef          	jal	5d4 <sbrk>
  if(p == (char*)-1)
 b20:	fd551ce3          	bne	a0,s5,af8 <malloc+0x7e>
        return 0;
 b24:	4501                	li	a0,0
 b26:	7902                	ld	s2,32(sp)
 b28:	6a42                	ld	s4,16(sp)
 b2a:	6aa2                	ld	s5,8(sp)
 b2c:	6b02                	ld	s6,0(sp)
 b2e:	a03d                	j	b5c <malloc+0xe2>
 b30:	7902                	ld	s2,32(sp)
 b32:	6a42                	ld	s4,16(sp)
 b34:	6aa2                	ld	s5,8(sp)
 b36:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 b38:	fae48de3          	beq	s1,a4,af2 <malloc+0x78>
        p->s.size -= nunits;
 b3c:	4137073b          	subw	a4,a4,s3
 b40:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b42:	02071693          	sll	a3,a4,0x20
 b46:	01c6d713          	srl	a4,a3,0x1c
 b4a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b4c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b50:	00000717          	auipc	a4,0x0
 b54:	4aa73c23          	sd	a0,1208(a4) # 1008 <freep>
      return (void*)(p + 1);
 b58:	01078513          	add	a0,a5,16
  }
}
 b5c:	70e2                	ld	ra,56(sp)
 b5e:	7442                	ld	s0,48(sp)
 b60:	74a2                	ld	s1,40(sp)
 b62:	69e2                	ld	s3,24(sp)
 b64:	6121                	add	sp,sp,64
 b66:	8082                	ret
 b68:	7902                	ld	s2,32(sp)
 b6a:	6a42                	ld	s4,16(sp)
 b6c:	6aa2                	ld	s5,8(sp)
 b6e:	6b02                	ld	s6,0(sp)
 b70:	b7f5                	j	b5c <malloc+0xe2>
