
user/_history:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fcntl.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	7109                	add	sp,sp,-384
   2:	fe86                	sd	ra,376(sp)
   4:	faa2                	sd	s0,368(sp)
   6:	0300                	add	s0,sp,384
  char buf[256];
  int n;
  int line_num = 1;
  int i;
  
  fd = open(".sh_history", O_RDONLY);
   8:	4581                	li	a1,0
   a:	00001517          	auipc	a0,0x1
   e:	c5650513          	add	a0,a0,-938 # c60 <malloc+0x102>
  12:	65e000ef          	jal	670 <open>
  16:	e8a43423          	sd	a0,-376(s0)
  if(fd < 0){
  1a:	06054063          	bltz	a0,7a <main+0x7a>
  1e:	f6a6                	sd	s1,360(sp)
  20:	f2ca                	sd	s2,352(sp)
  22:	eece                	sd	s3,344(sp)
  24:	ead2                	sd	s4,336(sp)
  26:	e6d6                	sd	s5,328(sp)
  28:	e2da                	sd	s6,320(sp)
  2a:	fe5e                	sd	s7,312(sp)
  2c:	fa62                	sd	s8,304(sp)
  2e:	f666                	sd	s9,296(sp)
  30:	f26a                	sd	s10,288(sp)
  32:	ee6e                	sd	s11,280(sp)
  34:	4b05                	li	s6,1
  while((n = read(fd, buf, sizeof(buf) - 1)) > 0){
    buf[n] = 0;
    i = 0;
    while(i < n){
      int start = i;
      while(i < n && buf[i] != '\n' && buf[i] != 0){
  36:	49a9                	li	s3,10
      }
      if(i > start){
        buf[i] = 0;
        if(line_num < 10) write(1, " ", 1);
        if(line_num < 100) write(1, " ", 1);
        write(1, "   ", 3);
  38:	00001d17          	auipc	s10,0x1
  3c:	c60d0d13          	add	s10,s10,-928 # c98 <malloc+0x13a>
        write(1, "  ", 2);
  40:	00001c97          	auipc	s9,0x1
  44:	c60c8c93          	add	s9,s9,-928 # ca0 <malloc+0x142>
        write(1, buf + start, i - start);
        write(1, "\n", 1);
  48:	00001c17          	auipc	s8,0x1
  4c:	c60c0c13          	add	s8,s8,-928 # ca8 <malloc+0x14a>
  while((n = read(fd, buf, sizeof(buf) - 1)) > 0){
  50:	0ff00613          	li	a2,255
  54:	e9040593          	add	a1,s0,-368
  58:	e8843503          	ld	a0,-376(s0)
  5c:	5ec000ef          	jal	648 <read>
  60:	892a                	mv	s2,a0
  62:	0ca05063          	blez	a0,122 <main+0x122>
    buf[n] = 0;
  66:	f9090793          	add	a5,s2,-112
  6a:	97a2                	add	a5,a5,s0
  6c:	f0078023          	sb	zero,-256(a5)
    i = 0;
  70:	4a01                	li	s4,0
        if(line_num < 10) write(1, " ", 1);
  72:	4ba5                	li	s7,9
        if(line_num < 100) write(1, " ", 1);
  74:	06300d93          	li	s11,99
  78:	a8b9                	j	d6 <main+0xd6>
    write(1, "No command history found.\n", 26);
  7a:	4669                	li	a2,26
  7c:	00001597          	auipc	a1,0x1
  80:	bf458593          	add	a1,a1,-1036 # c70 <malloc+0x112>
  84:	4505                	li	a0,1
  86:	5ca000ef          	jal	650 <write>
    return 0;
  8a:	a85d                	j	140 <main+0x140>
      if(i > start){
  8c:	049a5163          	bge	s4,s1,ce <main+0xce>
        buf[i] = 0;
  90:	f9048793          	add	a5,s1,-112
  94:	97a2                	add	a5,a5,s0
  96:	f0078023          	sb	zero,-256(a5)
        if(line_num < 10) write(1, " ", 1);
  9a:	076bd163          	bge	s7,s6,fc <main+0xfc>
        if(line_num < 100) write(1, " ", 1);
  9e:	076dd763          	bge	s11,s6,10c <main+0x10c>
        write(1, "   ", 3);
  a2:	460d                	li	a2,3
  a4:	85ea                	mv	a1,s10
  a6:	4505                	li	a0,1
  a8:	5a8000ef          	jal	650 <write>
        write(1, "  ", 2);
  ac:	4609                	li	a2,2
  ae:	85e6                	mv	a1,s9
  b0:	4505                	li	a0,1
  b2:	59e000ef          	jal	650 <write>
        write(1, buf + start, i - start);
  b6:	4144863b          	subw	a2,s1,s4
  ba:	85d6                	mv	a1,s5
  bc:	4505                	li	a0,1
  be:	592000ef          	jal	650 <write>
        write(1, "\n", 1);
  c2:	4605                	li	a2,1
  c4:	85e2                	mv	a1,s8
  c6:	4505                	li	a0,1
  c8:	588000ef          	jal	650 <write>
        line_num++;
  cc:	2b05                	addw	s6,s6,1
      }
      i++;
  ce:	00148a1b          	addw	s4,s1,1
    while(i < n){
  d2:	f72a5fe3          	bge	s4,s2,50 <main+0x50>
      while(i < n && buf[i] != '\n' && buf[i] != 0){
  d6:	052a5463          	bge	s4,s2,11e <main+0x11e>
  da:	e9040793          	add	a5,s0,-368
  de:	01478ab3          	add	s5,a5,s4
  e2:	8756                	mv	a4,s5
  e4:	84d2                	mv	s1,s4
  e6:	00074783          	lbu	a5,0(a4)
  ea:	fb3781e3          	beq	a5,s3,8c <main+0x8c>
  ee:	dfd9                	beqz	a5,8c <main+0x8c>
        i++;
  f0:	2485                	addw	s1,s1,1
      while(i < n && buf[i] != '\n' && buf[i] != 0){
  f2:	0705                	add	a4,a4,1
  f4:	fe9919e3          	bne	s2,s1,e6 <main+0xe6>
  f8:	84ca                	mv	s1,s2
  fa:	bf49                	j	8c <main+0x8c>
        if(line_num < 10) write(1, " ", 1);
  fc:	4605                	li	a2,1
  fe:	00001597          	auipc	a1,0x1
 102:	b9258593          	add	a1,a1,-1134 # c90 <malloc+0x132>
 106:	4505                	li	a0,1
 108:	548000ef          	jal	650 <write>
        if(line_num < 100) write(1, " ", 1);
 10c:	4605                	li	a2,1
 10e:	00001597          	auipc	a1,0x1
 112:	b8258593          	add	a1,a1,-1150 # c90 <malloc+0x132>
 116:	4505                	li	a0,1
 118:	538000ef          	jal	650 <write>
 11c:	b759                	j	a2 <main+0xa2>
      while(i < n && buf[i] != '\n' && buf[i] != 0){
 11e:	84d2                	mv	s1,s4
 120:	b77d                	j	ce <main+0xce>
    }
  }
  close(fd);
 122:	e8843503          	ld	a0,-376(s0)
 126:	532000ef          	jal	658 <close>
 12a:	74b6                	ld	s1,360(sp)
 12c:	7916                	ld	s2,352(sp)
 12e:	69f6                	ld	s3,344(sp)
 130:	6a56                	ld	s4,336(sp)
 132:	6ab6                	ld	s5,328(sp)
 134:	6b16                	ld	s6,320(sp)
 136:	7bf2                	ld	s7,312(sp)
 138:	7c52                	ld	s8,304(sp)
 13a:	7cb2                	ld	s9,296(sp)
 13c:	7d12                	ld	s10,288(sp)
 13e:	6df2                	ld	s11,280(sp)
  return 0;
}
 140:	4501                	li	a0,0
 142:	70f6                	ld	ra,376(sp)
 144:	7456                	ld	s0,368(sp)
 146:	6119                	add	sp,sp,384
 148:	8082                	ret

000000000000014a <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 14a:	1141                	add	sp,sp,-16
 14c:	e406                	sd	ra,8(sp)
 14e:	e022                	sd	s0,0(sp)
 150:	0800                	add	s0,sp,16
  extern int main();
  main();
 152:	eafff0ef          	jal	0 <main>
  exit(0);
 156:	4501                	li	a0,0
 158:	4d8000ef          	jal	630 <exit>

000000000000015c <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 15c:	1141                	add	sp,sp,-16
 15e:	e422                	sd	s0,8(sp)
 160:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 162:	87aa                	mv	a5,a0
 164:	0585                	add	a1,a1,1
 166:	0785                	add	a5,a5,1
 168:	fff5c703          	lbu	a4,-1(a1)
 16c:	fee78fa3          	sb	a4,-1(a5)
 170:	fb75                	bnez	a4,164 <strcpy+0x8>
    ;
  return os;
}
 172:	6422                	ld	s0,8(sp)
 174:	0141                	add	sp,sp,16
 176:	8082                	ret

0000000000000178 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 178:	1141                	add	sp,sp,-16
 17a:	e422                	sd	s0,8(sp)
 17c:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 17e:	00054783          	lbu	a5,0(a0)
 182:	cb91                	beqz	a5,196 <strcmp+0x1e>
 184:	0005c703          	lbu	a4,0(a1)
 188:	00f71763          	bne	a4,a5,196 <strcmp+0x1e>
    p++, q++;
 18c:	0505                	add	a0,a0,1
 18e:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 190:	00054783          	lbu	a5,0(a0)
 194:	fbe5                	bnez	a5,184 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 196:	0005c503          	lbu	a0,0(a1)
}
 19a:	40a7853b          	subw	a0,a5,a0
 19e:	6422                	ld	s0,8(sp)
 1a0:	0141                	add	sp,sp,16
 1a2:	8082                	ret

00000000000001a4 <strlen>:

uint
strlen(const char *s)
{
 1a4:	1141                	add	sp,sp,-16
 1a6:	e422                	sd	s0,8(sp)
 1a8:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1aa:	00054783          	lbu	a5,0(a0)
 1ae:	cf91                	beqz	a5,1ca <strlen+0x26>
 1b0:	0505                	add	a0,a0,1
 1b2:	87aa                	mv	a5,a0
 1b4:	86be                	mv	a3,a5
 1b6:	0785                	add	a5,a5,1
 1b8:	fff7c703          	lbu	a4,-1(a5)
 1bc:	ff65                	bnez	a4,1b4 <strlen+0x10>
 1be:	40a6853b          	subw	a0,a3,a0
 1c2:	2505                	addw	a0,a0,1
    ;
  return n;
}
 1c4:	6422                	ld	s0,8(sp)
 1c6:	0141                	add	sp,sp,16
 1c8:	8082                	ret
  for(n = 0; s[n]; n++)
 1ca:	4501                	li	a0,0
 1cc:	bfe5                	j	1c4 <strlen+0x20>

00000000000001ce <memset>:

void*
memset(void *dst, int c, uint n)
{
 1ce:	1141                	add	sp,sp,-16
 1d0:	e422                	sd	s0,8(sp)
 1d2:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1d4:	ca19                	beqz	a2,1ea <memset+0x1c>
 1d6:	87aa                	mv	a5,a0
 1d8:	1602                	sll	a2,a2,0x20
 1da:	9201                	srl	a2,a2,0x20
 1dc:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1e0:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1e4:	0785                	add	a5,a5,1
 1e6:	fee79de3          	bne	a5,a4,1e0 <memset+0x12>
  }
  return dst;
}
 1ea:	6422                	ld	s0,8(sp)
 1ec:	0141                	add	sp,sp,16
 1ee:	8082                	ret

00000000000001f0 <strchr>:

char*
strchr(const char *s, char c)
{
 1f0:	1141                	add	sp,sp,-16
 1f2:	e422                	sd	s0,8(sp)
 1f4:	0800                	add	s0,sp,16
  for(; *s; s++)
 1f6:	00054783          	lbu	a5,0(a0)
 1fa:	cb99                	beqz	a5,210 <strchr+0x20>
    if(*s == c)
 1fc:	00f58763          	beq	a1,a5,20a <strchr+0x1a>
  for(; *s; s++)
 200:	0505                	add	a0,a0,1
 202:	00054783          	lbu	a5,0(a0)
 206:	fbfd                	bnez	a5,1fc <strchr+0xc>
      return (char*)s;
  return 0;
 208:	4501                	li	a0,0
}
 20a:	6422                	ld	s0,8(sp)
 20c:	0141                	add	sp,sp,16
 20e:	8082                	ret
  return 0;
 210:	4501                	li	a0,0
 212:	bfe5                	j	20a <strchr+0x1a>

0000000000000214 <gets>:

char*
gets(char *buf, int max)
{
 214:	711d                	add	sp,sp,-96
 216:	ec86                	sd	ra,88(sp)
 218:	e8a2                	sd	s0,80(sp)
 21a:	e4a6                	sd	s1,72(sp)
 21c:	e0ca                	sd	s2,64(sp)
 21e:	fc4e                	sd	s3,56(sp)
 220:	f852                	sd	s4,48(sp)
 222:	f456                	sd	s5,40(sp)
 224:	f05a                	sd	s6,32(sp)
 226:	ec5e                	sd	s7,24(sp)
 228:	1080                	add	s0,sp,96
 22a:	8baa                	mv	s7,a0
 22c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 22e:	892a                	mv	s2,a0
 230:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 232:	4aa9                	li	s5,10
 234:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 236:	89a6                	mv	s3,s1
 238:	2485                	addw	s1,s1,1
 23a:	0344d663          	bge	s1,s4,266 <gets+0x52>
    cc = read(0, &c, 1);
 23e:	4605                	li	a2,1
 240:	faf40593          	add	a1,s0,-81
 244:	4501                	li	a0,0
 246:	402000ef          	jal	648 <read>
    if(cc < 1)
 24a:	00a05e63          	blez	a0,266 <gets+0x52>
    buf[i++] = c;
 24e:	faf44783          	lbu	a5,-81(s0)
 252:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 256:	01578763          	beq	a5,s5,264 <gets+0x50>
 25a:	0905                	add	s2,s2,1
 25c:	fd679de3          	bne	a5,s6,236 <gets+0x22>
    buf[i++] = c;
 260:	89a6                	mv	s3,s1
 262:	a011                	j	266 <gets+0x52>
 264:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 266:	99de                	add	s3,s3,s7
 268:	00098023          	sb	zero,0(s3)
  return buf;
}
 26c:	855e                	mv	a0,s7
 26e:	60e6                	ld	ra,88(sp)
 270:	6446                	ld	s0,80(sp)
 272:	64a6                	ld	s1,72(sp)
 274:	6906                	ld	s2,64(sp)
 276:	79e2                	ld	s3,56(sp)
 278:	7a42                	ld	s4,48(sp)
 27a:	7aa2                	ld	s5,40(sp)
 27c:	7b02                	ld	s6,32(sp)
 27e:	6be2                	ld	s7,24(sp)
 280:	6125                	add	sp,sp,96
 282:	8082                	ret

0000000000000284 <stat>:

int
stat(const char *n, struct stat *st)
{
 284:	1101                	add	sp,sp,-32
 286:	ec06                	sd	ra,24(sp)
 288:	e822                	sd	s0,16(sp)
 28a:	e04a                	sd	s2,0(sp)
 28c:	1000                	add	s0,sp,32
 28e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 290:	4581                	li	a1,0
 292:	3de000ef          	jal	670 <open>
  if(fd < 0)
 296:	02054263          	bltz	a0,2ba <stat+0x36>
 29a:	e426                	sd	s1,8(sp)
 29c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 29e:	85ca                	mv	a1,s2
 2a0:	3e8000ef          	jal	688 <fstat>
 2a4:	892a                	mv	s2,a0
  close(fd);
 2a6:	8526                	mv	a0,s1
 2a8:	3b0000ef          	jal	658 <close>
  return r;
 2ac:	64a2                	ld	s1,8(sp)
}
 2ae:	854a                	mv	a0,s2
 2b0:	60e2                	ld	ra,24(sp)
 2b2:	6442                	ld	s0,16(sp)
 2b4:	6902                	ld	s2,0(sp)
 2b6:	6105                	add	sp,sp,32
 2b8:	8082                	ret
    return -1;
 2ba:	597d                	li	s2,-1
 2bc:	bfcd                	j	2ae <stat+0x2a>

00000000000002be <atoi>:

int
atoi(const char *s)
{
 2be:	1141                	add	sp,sp,-16
 2c0:	e422                	sd	s0,8(sp)
 2c2:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2c4:	00054683          	lbu	a3,0(a0)
 2c8:	fd06879b          	addw	a5,a3,-48
 2cc:	0ff7f793          	zext.b	a5,a5
 2d0:	4625                	li	a2,9
 2d2:	02f66863          	bltu	a2,a5,302 <atoi+0x44>
 2d6:	872a                	mv	a4,a0
  n = 0;
 2d8:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2da:	0705                	add	a4,a4,1
 2dc:	0025179b          	sllw	a5,a0,0x2
 2e0:	9fa9                	addw	a5,a5,a0
 2e2:	0017979b          	sllw	a5,a5,0x1
 2e6:	9fb5                	addw	a5,a5,a3
 2e8:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2ec:	00074683          	lbu	a3,0(a4)
 2f0:	fd06879b          	addw	a5,a3,-48
 2f4:	0ff7f793          	zext.b	a5,a5
 2f8:	fef671e3          	bgeu	a2,a5,2da <atoi+0x1c>
  return n;
}
 2fc:	6422                	ld	s0,8(sp)
 2fe:	0141                	add	sp,sp,16
 300:	8082                	ret
  n = 0;
 302:	4501                	li	a0,0
 304:	bfe5                	j	2fc <atoi+0x3e>

0000000000000306 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 306:	1141                	add	sp,sp,-16
 308:	e422                	sd	s0,8(sp)
 30a:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 30c:	02b57463          	bgeu	a0,a1,334 <memmove+0x2e>
    while(n-- > 0)
 310:	00c05f63          	blez	a2,32e <memmove+0x28>
 314:	1602                	sll	a2,a2,0x20
 316:	9201                	srl	a2,a2,0x20
 318:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 31c:	872a                	mv	a4,a0
      *dst++ = *src++;
 31e:	0585                	add	a1,a1,1
 320:	0705                	add	a4,a4,1
 322:	fff5c683          	lbu	a3,-1(a1)
 326:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 32a:	fef71ae3          	bne	a4,a5,31e <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 32e:	6422                	ld	s0,8(sp)
 330:	0141                	add	sp,sp,16
 332:	8082                	ret
    dst += n;
 334:	00c50733          	add	a4,a0,a2
    src += n;
 338:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 33a:	fec05ae3          	blez	a2,32e <memmove+0x28>
 33e:	fff6079b          	addw	a5,a2,-1
 342:	1782                	sll	a5,a5,0x20
 344:	9381                	srl	a5,a5,0x20
 346:	fff7c793          	not	a5,a5
 34a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 34c:	15fd                	add	a1,a1,-1
 34e:	177d                	add	a4,a4,-1
 350:	0005c683          	lbu	a3,0(a1)
 354:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 358:	fee79ae3          	bne	a5,a4,34c <memmove+0x46>
 35c:	bfc9                	j	32e <memmove+0x28>

000000000000035e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 35e:	1141                	add	sp,sp,-16
 360:	e422                	sd	s0,8(sp)
 362:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 364:	ca05                	beqz	a2,394 <memcmp+0x36>
 366:	fff6069b          	addw	a3,a2,-1
 36a:	1682                	sll	a3,a3,0x20
 36c:	9281                	srl	a3,a3,0x20
 36e:	0685                	add	a3,a3,1
 370:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 372:	00054783          	lbu	a5,0(a0)
 376:	0005c703          	lbu	a4,0(a1)
 37a:	00e79863          	bne	a5,a4,38a <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 37e:	0505                	add	a0,a0,1
    p2++;
 380:	0585                	add	a1,a1,1
  while (n-- > 0) {
 382:	fed518e3          	bne	a0,a3,372 <memcmp+0x14>
  }
  return 0;
 386:	4501                	li	a0,0
 388:	a019                	j	38e <memcmp+0x30>
      return *p1 - *p2;
 38a:	40e7853b          	subw	a0,a5,a4
}
 38e:	6422                	ld	s0,8(sp)
 390:	0141                	add	sp,sp,16
 392:	8082                	ret
  return 0;
 394:	4501                	li	a0,0
 396:	bfe5                	j	38e <memcmp+0x30>

0000000000000398 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 398:	1141                	add	sp,sp,-16
 39a:	e406                	sd	ra,8(sp)
 39c:	e022                	sd	s0,0(sp)
 39e:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 3a0:	f67ff0ef          	jal	306 <memmove>
}
 3a4:	60a2                	ld	ra,8(sp)
 3a6:	6402                	ld	s0,0(sp)
 3a8:	0141                	add	sp,sp,16
 3aa:	8082                	ret

00000000000003ac <htons>:
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
}

uint16_t
htons(uint16_t h)
{
 3ac:	1141                	add	sp,sp,-16
 3ae:	e422                	sd	s0,8(sp)
 3b0:	0800                	add	s0,sp,16
    if (!endian) {
 3b2:	00001797          	auipc	a5,0x1
 3b6:	c4e7a783          	lw	a5,-946(a5) # 1000 <endian>
 3ba:	e385                	bnez	a5,3da <htons+0x2e>
        endian = byteorder();
 3bc:	4d200793          	li	a5,1234
 3c0:	00001717          	auipc	a4,0x1
 3c4:	c4f72023          	sw	a5,-960(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 3c8:	0085179b          	sllw	a5,a0,0x8
 3cc:	0085551b          	srlw	a0,a0,0x8
 3d0:	8fc9                	or	a5,a5,a0
 3d2:	03079513          	sll	a0,a5,0x30
 3d6:	9141                	srl	a0,a0,0x30
 3d8:	a029                	j	3e2 <htons+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(h) : h;
 3da:	4d200713          	li	a4,1234
 3de:	fee785e3          	beq	a5,a4,3c8 <htons+0x1c>
}
 3e2:	6422                	ld	s0,8(sp)
 3e4:	0141                	add	sp,sp,16
 3e6:	8082                	ret

00000000000003e8 <ntohs>:

uint16_t
ntohs(uint16_t n)
{
 3e8:	1141                	add	sp,sp,-16
 3ea:	e422                	sd	s0,8(sp)
 3ec:	0800                	add	s0,sp,16
    if (!endian) {
 3ee:	00001797          	auipc	a5,0x1
 3f2:	c127a783          	lw	a5,-1006(a5) # 1000 <endian>
 3f6:	e385                	bnez	a5,416 <ntohs+0x2e>
        endian = byteorder();
 3f8:	4d200793          	li	a5,1234
 3fc:	00001717          	auipc	a4,0x1
 400:	c0f72223          	sw	a5,-1020(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 404:	0085179b          	sllw	a5,a0,0x8
 408:	0085551b          	srlw	a0,a0,0x8
 40c:	8fc9                	or	a5,a5,a0
 40e:	03079513          	sll	a0,a5,0x30
 412:	9141                	srl	a0,a0,0x30
 414:	a029                	j	41e <ntohs+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(n) : n;
 416:	4d200713          	li	a4,1234
 41a:	fee785e3          	beq	a5,a4,404 <ntohs+0x1c>
}
 41e:	6422                	ld	s0,8(sp)
 420:	0141                	add	sp,sp,16
 422:	8082                	ret

0000000000000424 <htonl>:

uint32_t
htonl(uint32_t h)
{
 424:	1141                	add	sp,sp,-16
 426:	e422                	sd	s0,8(sp)
 428:	0800                	add	s0,sp,16
    if (!endian) {
 42a:	00001797          	auipc	a5,0x1
 42e:	bd67a783          	lw	a5,-1066(a5) # 1000 <endian>
 432:	ef85                	bnez	a5,46a <htonl+0x46>
        endian = byteorder();
 434:	4d200793          	li	a5,1234
 438:	00001717          	auipc	a4,0x1
 43c:	bcf72423          	sw	a5,-1080(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 440:	0185179b          	sllw	a5,a0,0x18
 444:	0185571b          	srlw	a4,a0,0x18
 448:	8fd9                	or	a5,a5,a4
 44a:	0085171b          	sllw	a4,a0,0x8
 44e:	00ff06b7          	lui	a3,0xff0
 452:	8f75                	and	a4,a4,a3
 454:	8fd9                	or	a5,a5,a4
 456:	0085551b          	srlw	a0,a0,0x8
 45a:	6741                	lui	a4,0x10
 45c:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeef0>
 460:	8d79                	and	a0,a0,a4
 462:	8fc9                	or	a5,a5,a0
 464:	0007851b          	sext.w	a0,a5
 468:	a029                	j	472 <htonl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(h) : h;
 46a:	4d200713          	li	a4,1234
 46e:	fce789e3          	beq	a5,a4,440 <htonl+0x1c>
}
 472:	6422                	ld	s0,8(sp)
 474:	0141                	add	sp,sp,16
 476:	8082                	ret

0000000000000478 <ntohl>:

uint32_t
ntohl(uint32_t n)
{
 478:	1141                	add	sp,sp,-16
 47a:	e422                	sd	s0,8(sp)
 47c:	0800                	add	s0,sp,16
    if (!endian) {
 47e:	00001797          	auipc	a5,0x1
 482:	b827a783          	lw	a5,-1150(a5) # 1000 <endian>
 486:	ef85                	bnez	a5,4be <ntohl+0x46>
        endian = byteorder();
 488:	4d200793          	li	a5,1234
 48c:	00001717          	auipc	a4,0x1
 490:	b6f72a23          	sw	a5,-1164(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 494:	0185179b          	sllw	a5,a0,0x18
 498:	0185571b          	srlw	a4,a0,0x18
 49c:	8fd9                	or	a5,a5,a4
 49e:	0085171b          	sllw	a4,a0,0x8
 4a2:	00ff06b7          	lui	a3,0xff0
 4a6:	8f75                	and	a4,a4,a3
 4a8:	8fd9                	or	a5,a5,a4
 4aa:	0085551b          	srlw	a0,a0,0x8
 4ae:	6741                	lui	a4,0x10
 4b0:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeef0>
 4b4:	8d79                	and	a0,a0,a4
 4b6:	8fc9                	or	a5,a5,a0
 4b8:	0007851b          	sext.w	a0,a5
 4bc:	a029                	j	4c6 <ntohl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(n) : n;
 4be:	4d200713          	li	a4,1234
 4c2:	fce789e3          	beq	a5,a4,494 <ntohl+0x1c>
}
 4c6:	6422                	ld	s0,8(sp)
 4c8:	0141                	add	sp,sp,16
 4ca:	8082                	ret

00000000000004cc <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
 4cc:	1141                	add	sp,sp,-16
 4ce:	e422                	sd	s0,8(sp)
 4d0:	0800                	add	s0,sp,16
 4d2:	872a                	mv	a4,a0
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
 4d4:	02000693          	li	a3,32
 4d8:	4525                	li	a0,9
 4da:	a011                	j	4de <strtol+0x12>
        s++;
 4dc:	0705                	add	a4,a4,1
    while (*s == ' ' || *s == '\t')
 4de:	00074783          	lbu	a5,0(a4)
 4e2:	fed78de3          	beq	a5,a3,4dc <strtol+0x10>
 4e6:	fea78be3          	beq	a5,a0,4dc <strtol+0x10>

    // plus/minus sign
    if (*s == '+')
 4ea:	02b00693          	li	a3,43
 4ee:	02d78663          	beq	a5,a3,51a <strtol+0x4e>
        s++;
    else if (*s == '-')
 4f2:	02d00693          	li	a3,45
    int neg = 0;
 4f6:	4301                	li	t1,0
    else if (*s == '-')
 4f8:	02d78463          	beq	a5,a3,520 <strtol+0x54>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 4fc:	fef67793          	and	a5,a2,-17
 500:	eb89                	bnez	a5,512 <strtol+0x46>
 502:	00074683          	lbu	a3,0(a4)
 506:	03000793          	li	a5,48
 50a:	00f68e63          	beq	a3,a5,526 <strtol+0x5a>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
 50e:	e211                	bnez	a2,512 <strtol+0x46>
        s++, base = 8;
    else if (base == 0)
        base = 10;
 510:	4629                	li	a2,10
 512:	4501                	li	a0,0

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
 514:	4825                	li	a6,9
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
 516:	48e5                	li	a7,25
 518:	a825                	j	550 <strtol+0x84>
        s++;
 51a:	0705                	add	a4,a4,1
    int neg = 0;
 51c:	4301                	li	t1,0
 51e:	bff9                	j	4fc <strtol+0x30>
        s++, neg = 1;
 520:	0705                	add	a4,a4,1
 522:	4305                	li	t1,1
 524:	bfe1                	j	4fc <strtol+0x30>
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 526:	00174683          	lbu	a3,1(a4)
 52a:	07800793          	li	a5,120
 52e:	00f68663          	beq	a3,a5,53a <strtol+0x6e>
    else if (base == 0 && s[0] == '0')
 532:	f265                	bnez	a2,512 <strtol+0x46>
        s++, base = 8;
 534:	0705                	add	a4,a4,1
 536:	4621                	li	a2,8
 538:	bfe9                	j	512 <strtol+0x46>
        s += 2, base = 16;
 53a:	0709                	add	a4,a4,2
 53c:	4641                	li	a2,16
 53e:	bfd1                	j	512 <strtol+0x46>
            dig = *s - '0';
 540:	fd07879b          	addw	a5,a5,-48
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
 544:	04c7d063          	bge	a5,a2,584 <strtol+0xb8>
            break;
        s++, val = (val * base) + dig;
 548:	0705                	add	a4,a4,1
 54a:	02a60533          	mul	a0,a2,a0
 54e:	953e                	add	a0,a0,a5
        if (*s >= '0' && *s <= '9')
 550:	00074783          	lbu	a5,0(a4)
 554:	fd07869b          	addw	a3,a5,-48
 558:	0ff6f693          	zext.b	a3,a3
 55c:	fed872e3          	bgeu	a6,a3,540 <strtol+0x74>
        else if (*s >= 'a' && *s <= 'z')
 560:	f9f7869b          	addw	a3,a5,-97
 564:	0ff6f693          	zext.b	a3,a3
 568:	00d8e563          	bltu	a7,a3,572 <strtol+0xa6>
            dig = *s - 'a' + 10;
 56c:	fa97879b          	addw	a5,a5,-87
 570:	bfd1                	j	544 <strtol+0x78>
        else if (*s >= 'A' && *s <= 'Z')
 572:	fbf7869b          	addw	a3,a5,-65
 576:	0ff6f693          	zext.b	a3,a3
 57a:	00d8e563          	bltu	a7,a3,584 <strtol+0xb8>
            dig = *s - 'A' + 10;
 57e:	fc97879b          	addw	a5,a5,-55
 582:	b7c9                	j	544 <strtol+0x78>
        // we don't properly detect overflow!
    }

    if (endptr)
 584:	c191                	beqz	a1,588 <strtol+0xbc>
        *endptr = (char *) s;
 586:	e198                	sd	a4,0(a1)
    return (neg ? -val : val);
 588:	00030463          	beqz	t1,590 <strtol+0xc4>
 58c:	40a00533          	neg	a0,a0
}
 590:	6422                	ld	s0,8(sp)
 592:	0141                	add	sp,sp,16
 594:	8082                	ret

0000000000000596 <inet_pton>:
inet_pton (int family, const char *p, void *n) {
    char *sp, *ep;
    int idx;
    long ret;

    if (family != AF_INET) {
 596:	4785                	li	a5,1
 598:	08f51063          	bne	a0,a5,618 <inet_pton+0x82>
inet_pton (int family, const char *p, void *n) {
 59c:	715d                	add	sp,sp,-80
 59e:	e486                	sd	ra,72(sp)
 5a0:	e0a2                	sd	s0,64(sp)
 5a2:	fc26                	sd	s1,56(sp)
 5a4:	f84a                	sd	s2,48(sp)
 5a6:	f44e                	sd	s3,40(sp)
 5a8:	f052                	sd	s4,32(sp)
 5aa:	ec56                	sd	s5,24(sp)
 5ac:	e85a                	sd	s6,16(sp)
 5ae:	0880                	add	s0,sp,80
 5b0:	84ae                	mv	s1,a1
 5b2:	89b2                	mv	s3,a2
 5b4:	4901                	li	s2,0
        return -1;
    }
    sp = (char *)p;
    for (idx = 0; idx < 4; idx++) {
        ret = strtol(sp, &ep, 10);
        if (ret < 0 || ret > 255) {
 5b6:	0ff00a13          	li	s4,255
            return -1;
        }
        if (ep == sp) {
            return -1;
        }
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 5ba:	4a8d                	li	s5,3
 5bc:	02e00b13          	li	s6,46
 5c0:	a805                	j	5f0 <inet_pton+0x5a>
 5c2:	0007c783          	lbu	a5,0(a5)
 5c6:	efb9                	bnez	a5,624 <inet_pton+0x8e>
            return -1;
        }
        ((uint8_t *)n)[idx] = ret;
 5c8:	00a981a3          	sb	a0,3(s3)
        sp = ep + 1;
    }
    return 0;
 5cc:	4501                	li	a0,0
}
 5ce:	60a6                	ld	ra,72(sp)
 5d0:	6406                	ld	s0,64(sp)
 5d2:	74e2                	ld	s1,56(sp)
 5d4:	7942                	ld	s2,48(sp)
 5d6:	79a2                	ld	s3,40(sp)
 5d8:	7a02                	ld	s4,32(sp)
 5da:	6ae2                	ld	s5,24(sp)
 5dc:	6b42                	ld	s6,16(sp)
 5de:	6161                	add	sp,sp,80
 5e0:	8082                	ret
        ((uint8_t *)n)[idx] = ret;
 5e2:	01298733          	add	a4,s3,s2
 5e6:	00a70023          	sb	a0,0(a4)
        sp = ep + 1;
 5ea:	00178493          	add	s1,a5,1
    for (idx = 0; idx < 4; idx++) {
 5ee:	0905                	add	s2,s2,1
        ret = strtol(sp, &ep, 10);
 5f0:	4629                	li	a2,10
 5f2:	fb840593          	add	a1,s0,-72
 5f6:	8526                	mv	a0,s1
 5f8:	ed5ff0ef          	jal	4cc <strtol>
        if (ret < 0 || ret > 255) {
 5fc:	02aa6063          	bltu	s4,a0,61c <inet_pton+0x86>
        if (ep == sp) {
 600:	fb843783          	ld	a5,-72(s0)
 604:	00978e63          	beq	a5,s1,620 <inet_pton+0x8a>
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 608:	fb590de3          	beq	s2,s5,5c2 <inet_pton+0x2c>
 60c:	0007c703          	lbu	a4,0(a5)
 610:	fd6709e3          	beq	a4,s6,5e2 <inet_pton+0x4c>
            return -1;
 614:	557d                	li	a0,-1
 616:	bf65                	j	5ce <inet_pton+0x38>
        return -1;
 618:	557d                	li	a0,-1
}
 61a:	8082                	ret
            return -1;
 61c:	557d                	li	a0,-1
 61e:	bf45                	j	5ce <inet_pton+0x38>
            return -1;
 620:	557d                	li	a0,-1
 622:	b775                	j	5ce <inet_pton+0x38>
            return -1;
 624:	557d                	li	a0,-1
 626:	b765                	j	5ce <inet_pton+0x38>

0000000000000628 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 628:	4885                	li	a7,1
 ecall
 62a:	00000073          	ecall
 ret
 62e:	8082                	ret

0000000000000630 <exit>:
.global exit
exit:
 li a7, SYS_exit
 630:	4889                	li	a7,2
 ecall
 632:	00000073          	ecall
 ret
 636:	8082                	ret

0000000000000638 <wait>:
.global wait
wait:
 li a7, SYS_wait
 638:	488d                	li	a7,3
 ecall
 63a:	00000073          	ecall
 ret
 63e:	8082                	ret

0000000000000640 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 640:	4891                	li	a7,4
 ecall
 642:	00000073          	ecall
 ret
 646:	8082                	ret

0000000000000648 <read>:
.global read
read:
 li a7, SYS_read
 648:	4895                	li	a7,5
 ecall
 64a:	00000073          	ecall
 ret
 64e:	8082                	ret

0000000000000650 <write>:
.global write
write:
 li a7, SYS_write
 650:	48c1                	li	a7,16
 ecall
 652:	00000073          	ecall
 ret
 656:	8082                	ret

0000000000000658 <close>:
.global close
close:
 li a7, SYS_close
 658:	48d5                	li	a7,21
 ecall
 65a:	00000073          	ecall
 ret
 65e:	8082                	ret

0000000000000660 <kill>:
.global kill
kill:
 li a7, SYS_kill
 660:	4899                	li	a7,6
 ecall
 662:	00000073          	ecall
 ret
 666:	8082                	ret

0000000000000668 <exec>:
.global exec
exec:
 li a7, SYS_exec
 668:	489d                	li	a7,7
 ecall
 66a:	00000073          	ecall
 ret
 66e:	8082                	ret

0000000000000670 <open>:
.global open
open:
 li a7, SYS_open
 670:	48bd                	li	a7,15
 ecall
 672:	00000073          	ecall
 ret
 676:	8082                	ret

0000000000000678 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 678:	48c5                	li	a7,17
 ecall
 67a:	00000073          	ecall
 ret
 67e:	8082                	ret

0000000000000680 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 680:	48c9                	li	a7,18
 ecall
 682:	00000073          	ecall
 ret
 686:	8082                	ret

0000000000000688 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 688:	48a1                	li	a7,8
 ecall
 68a:	00000073          	ecall
 ret
 68e:	8082                	ret

0000000000000690 <link>:
.global link
link:
 li a7, SYS_link
 690:	48cd                	li	a7,19
 ecall
 692:	00000073          	ecall
 ret
 696:	8082                	ret

0000000000000698 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 698:	48d1                	li	a7,20
 ecall
 69a:	00000073          	ecall
 ret
 69e:	8082                	ret

00000000000006a0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 6a0:	48a5                	li	a7,9
 ecall
 6a2:	00000073          	ecall
 ret
 6a6:	8082                	ret

00000000000006a8 <dup>:
.global dup
dup:
 li a7, SYS_dup
 6a8:	48a9                	li	a7,10
 ecall
 6aa:	00000073          	ecall
 ret
 6ae:	8082                	ret

00000000000006b0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 6b0:	48ad                	li	a7,11
 ecall
 6b2:	00000073          	ecall
 ret
 6b6:	8082                	ret

00000000000006b8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 6b8:	48b1                	li	a7,12
 ecall
 6ba:	00000073          	ecall
 ret
 6be:	8082                	ret

00000000000006c0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 6c0:	48b5                	li	a7,13
 ecall
 6c2:	00000073          	ecall
 ret
 6c6:	8082                	ret

00000000000006c8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 6c8:	48b9                	li	a7,14
 ecall
 6ca:	00000073          	ecall
 ret
 6ce:	8082                	ret

00000000000006d0 <socket>:
.global socket
socket:
 li a7, SYS_socket
 6d0:	48d9                	li	a7,22
 ecall
 6d2:	00000073          	ecall
 ret
 6d6:	8082                	ret

00000000000006d8 <bind>:
.global bind
bind:
 li a7, SYS_bind
 6d8:	48dd                	li	a7,23
 ecall
 6da:	00000073          	ecall
 ret
 6de:	8082                	ret

00000000000006e0 <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 6e0:	48e1                	li	a7,24
 ecall
 6e2:	00000073          	ecall
 ret
 6e6:	8082                	ret

00000000000006e8 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 6e8:	48e5                	li	a7,25
 ecall
 6ea:	00000073          	ecall
 ret
 6ee:	8082                	ret

00000000000006f0 <connect>:
.global connect
connect:
 li a7, SYS_connect
 6f0:	48e9                	li	a7,26
 ecall
 6f2:	00000073          	ecall
 ret
 6f6:	8082                	ret

00000000000006f8 <listen>:
.global listen
listen:
 li a7, SYS_listen
 6f8:	48ed                	li	a7,27
 ecall
 6fa:	00000073          	ecall
 ret
 6fe:	8082                	ret

0000000000000700 <accept>:
.global accept
accept:
 li a7, SYS_accept
 700:	48f1                	li	a7,28
 ecall
 702:	00000073          	ecall
 ret
 706:	8082                	ret

0000000000000708 <recv>:
.global recv
recv:
 li a7, SYS_recv
 708:	48f5                	li	a7,29
 ecall
 70a:	00000073          	ecall
 ret
 70e:	8082                	ret

0000000000000710 <send>:
.global send
send:
 li a7, SYS_send
 710:	48f9                	li	a7,30
 ecall
 712:	00000073          	ecall
 ret
 716:	8082                	ret

0000000000000718 <ioctl>:
.global ioctl
ioctl:
 li a7, SYS_ioctl
 718:	48fd                	li	a7,31
 ecall
 71a:	00000073          	ecall
 ret
 71e:	8082                	ret

0000000000000720 <consolemode>:
.global consolemode
consolemode:
 li a7, SYS_consolemode
 720:	02000893          	li	a7,32
 ecall
 724:	00000073          	ecall
 ret
 728:	8082                	ret

000000000000072a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 72a:	1101                	add	sp,sp,-32
 72c:	ec06                	sd	ra,24(sp)
 72e:	e822                	sd	s0,16(sp)
 730:	1000                	add	s0,sp,32
 732:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 736:	4605                	li	a2,1
 738:	fef40593          	add	a1,s0,-17
 73c:	f15ff0ef          	jal	650 <write>
}
 740:	60e2                	ld	ra,24(sp)
 742:	6442                	ld	s0,16(sp)
 744:	6105                	add	sp,sp,32
 746:	8082                	ret

0000000000000748 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 748:	715d                	add	sp,sp,-80
 74a:	e486                	sd	ra,72(sp)
 74c:	e0a2                	sd	s0,64(sp)
 74e:	fc26                	sd	s1,56(sp)
 750:	0880                	add	s0,sp,80
 752:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 754:	c299                	beqz	a3,75a <printint+0x12>
 756:	0805c963          	bltz	a1,7e8 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 75a:	2581                	sext.w	a1,a1
  neg = 0;
 75c:	4881                	li	a7,0
 75e:	fb840693          	add	a3,s0,-72
  }

  i = 0;
 762:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 764:	2601                	sext.w	a2,a2
 766:	00000517          	auipc	a0,0x0
 76a:	55250513          	add	a0,a0,1362 # cb8 <digits>
 76e:	883a                	mv	a6,a4
 770:	2705                	addw	a4,a4,1
 772:	02c5f7bb          	remuw	a5,a1,a2
 776:	1782                	sll	a5,a5,0x20
 778:	9381                	srl	a5,a5,0x20
 77a:	97aa                	add	a5,a5,a0
 77c:	0007c783          	lbu	a5,0(a5)
 780:	00f68023          	sb	a5,0(a3) # ff0000 <base+0xfeeff0>
  }while((x /= base) != 0);
 784:	0005879b          	sext.w	a5,a1
 788:	02c5d5bb          	divuw	a1,a1,a2
 78c:	0685                	add	a3,a3,1
 78e:	fec7f0e3          	bgeu	a5,a2,76e <printint+0x26>
  if(neg)
 792:	00088c63          	beqz	a7,7aa <printint+0x62>
    buf[i++] = '-';
 796:	fd070793          	add	a5,a4,-48
 79a:	00878733          	add	a4,a5,s0
 79e:	02d00793          	li	a5,45
 7a2:	fef70423          	sb	a5,-24(a4)
 7a6:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 7aa:	02e05a63          	blez	a4,7de <printint+0x96>
 7ae:	f84a                	sd	s2,48(sp)
 7b0:	f44e                	sd	s3,40(sp)
 7b2:	fb840793          	add	a5,s0,-72
 7b6:	00e78933          	add	s2,a5,a4
 7ba:	fff78993          	add	s3,a5,-1
 7be:	99ba                	add	s3,s3,a4
 7c0:	377d                	addw	a4,a4,-1
 7c2:	1702                	sll	a4,a4,0x20
 7c4:	9301                	srl	a4,a4,0x20
 7c6:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 7ca:	fff94583          	lbu	a1,-1(s2)
 7ce:	8526                	mv	a0,s1
 7d0:	f5bff0ef          	jal	72a <putc>
  while(--i >= 0)
 7d4:	197d                	add	s2,s2,-1
 7d6:	ff391ae3          	bne	s2,s3,7ca <printint+0x82>
 7da:	7942                	ld	s2,48(sp)
 7dc:	79a2                	ld	s3,40(sp)
}
 7de:	60a6                	ld	ra,72(sp)
 7e0:	6406                	ld	s0,64(sp)
 7e2:	74e2                	ld	s1,56(sp)
 7e4:	6161                	add	sp,sp,80
 7e6:	8082                	ret
    x = -xx;
 7e8:	40b005bb          	negw	a1,a1
    neg = 1;
 7ec:	4885                	li	a7,1
    x = -xx;
 7ee:	bf85                	j	75e <printint+0x16>

00000000000007f0 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7f0:	711d                	add	sp,sp,-96
 7f2:	ec86                	sd	ra,88(sp)
 7f4:	e8a2                	sd	s0,80(sp)
 7f6:	e0ca                	sd	s2,64(sp)
 7f8:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 7fa:	0005c903          	lbu	s2,0(a1)
 7fe:	26090863          	beqz	s2,a6e <vprintf+0x27e>
 802:	e4a6                	sd	s1,72(sp)
 804:	fc4e                	sd	s3,56(sp)
 806:	f852                	sd	s4,48(sp)
 808:	f456                	sd	s5,40(sp)
 80a:	f05a                	sd	s6,32(sp)
 80c:	ec5e                	sd	s7,24(sp)
 80e:	e862                	sd	s8,16(sp)
 810:	e466                	sd	s9,8(sp)
 812:	8b2a                	mv	s6,a0
 814:	8a2e                	mv	s4,a1
 816:	8bb2                	mv	s7,a2
  state = 0;
 818:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 81a:	4481                	li	s1,0
 81c:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 81e:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 822:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 826:	06c00c93          	li	s9,108
 82a:	a005                	j	84a <vprintf+0x5a>
        putc(fd, c0);
 82c:	85ca                	mv	a1,s2
 82e:	855a                	mv	a0,s6
 830:	efbff0ef          	jal	72a <putc>
 834:	a019                	j	83a <vprintf+0x4a>
    } else if(state == '%'){
 836:	03598263          	beq	s3,s5,85a <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 83a:	2485                	addw	s1,s1,1
 83c:	8726                	mv	a4,s1
 83e:	009a07b3          	add	a5,s4,s1
 842:	0007c903          	lbu	s2,0(a5)
 846:	20090c63          	beqz	s2,a5e <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 84a:	0009079b          	sext.w	a5,s2
    if(state == 0){
 84e:	fe0994e3          	bnez	s3,836 <vprintf+0x46>
      if(c0 == '%'){
 852:	fd579de3          	bne	a5,s5,82c <vprintf+0x3c>
        state = '%';
 856:	89be                	mv	s3,a5
 858:	b7cd                	j	83a <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 85a:	00ea06b3          	add	a3,s4,a4
 85e:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 862:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 864:	c681                	beqz	a3,86c <vprintf+0x7c>
 866:	9752                	add	a4,a4,s4
 868:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 86c:	03878f63          	beq	a5,s8,8aa <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 870:	05978963          	beq	a5,s9,8c2 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 874:	07500713          	li	a4,117
 878:	0ee78363          	beq	a5,a4,95e <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 87c:	07800713          	li	a4,120
 880:	12e78563          	beq	a5,a4,9aa <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 884:	07000713          	li	a4,112
 888:	14e78a63          	beq	a5,a4,9dc <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 88c:	07300713          	li	a4,115
 890:	18e78a63          	beq	a5,a4,a24 <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 894:	02500713          	li	a4,37
 898:	04e79563          	bne	a5,a4,8e2 <vprintf+0xf2>
        putc(fd, '%');
 89c:	02500593          	li	a1,37
 8a0:	855a                	mv	a0,s6
 8a2:	e89ff0ef          	jal	72a <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 8a6:	4981                	li	s3,0
 8a8:	bf49                	j	83a <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 8aa:	008b8913          	add	s2,s7,8
 8ae:	4685                	li	a3,1
 8b0:	4629                	li	a2,10
 8b2:	000ba583          	lw	a1,0(s7)
 8b6:	855a                	mv	a0,s6
 8b8:	e91ff0ef          	jal	748 <printint>
 8bc:	8bca                	mv	s7,s2
      state = 0;
 8be:	4981                	li	s3,0
 8c0:	bfad                	j	83a <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 8c2:	06400793          	li	a5,100
 8c6:	02f68963          	beq	a3,a5,8f8 <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 8ca:	06c00793          	li	a5,108
 8ce:	04f68263          	beq	a3,a5,912 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 8d2:	07500793          	li	a5,117
 8d6:	0af68063          	beq	a3,a5,976 <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 8da:	07800793          	li	a5,120
 8de:	0ef68263          	beq	a3,a5,9c2 <vprintf+0x1d2>
        putc(fd, '%');
 8e2:	02500593          	li	a1,37
 8e6:	855a                	mv	a0,s6
 8e8:	e43ff0ef          	jal	72a <putc>
        putc(fd, c0);
 8ec:	85ca                	mv	a1,s2
 8ee:	855a                	mv	a0,s6
 8f0:	e3bff0ef          	jal	72a <putc>
      state = 0;
 8f4:	4981                	li	s3,0
 8f6:	b791                	j	83a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 8f8:	008b8913          	add	s2,s7,8
 8fc:	4685                	li	a3,1
 8fe:	4629                	li	a2,10
 900:	000bb583          	ld	a1,0(s7)
 904:	855a                	mv	a0,s6
 906:	e43ff0ef          	jal	748 <printint>
        i += 1;
 90a:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 90c:	8bca                	mv	s7,s2
      state = 0;
 90e:	4981                	li	s3,0
        i += 1;
 910:	b72d                	j	83a <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 912:	06400793          	li	a5,100
 916:	02f60763          	beq	a2,a5,944 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 91a:	07500793          	li	a5,117
 91e:	06f60963          	beq	a2,a5,990 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 922:	07800793          	li	a5,120
 926:	faf61ee3          	bne	a2,a5,8e2 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 92a:	008b8913          	add	s2,s7,8
 92e:	4681                	li	a3,0
 930:	4641                	li	a2,16
 932:	000bb583          	ld	a1,0(s7)
 936:	855a                	mv	a0,s6
 938:	e11ff0ef          	jal	748 <printint>
        i += 2;
 93c:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 93e:	8bca                	mv	s7,s2
      state = 0;
 940:	4981                	li	s3,0
        i += 2;
 942:	bde5                	j	83a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 944:	008b8913          	add	s2,s7,8
 948:	4685                	li	a3,1
 94a:	4629                	li	a2,10
 94c:	000bb583          	ld	a1,0(s7)
 950:	855a                	mv	a0,s6
 952:	df7ff0ef          	jal	748 <printint>
        i += 2;
 956:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 958:	8bca                	mv	s7,s2
      state = 0;
 95a:	4981                	li	s3,0
        i += 2;
 95c:	bdf9                	j	83a <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 95e:	008b8913          	add	s2,s7,8
 962:	4681                	li	a3,0
 964:	4629                	li	a2,10
 966:	000ba583          	lw	a1,0(s7)
 96a:	855a                	mv	a0,s6
 96c:	dddff0ef          	jal	748 <printint>
 970:	8bca                	mv	s7,s2
      state = 0;
 972:	4981                	li	s3,0
 974:	b5d9                	j	83a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 976:	008b8913          	add	s2,s7,8
 97a:	4681                	li	a3,0
 97c:	4629                	li	a2,10
 97e:	000bb583          	ld	a1,0(s7)
 982:	855a                	mv	a0,s6
 984:	dc5ff0ef          	jal	748 <printint>
        i += 1;
 988:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 98a:	8bca                	mv	s7,s2
      state = 0;
 98c:	4981                	li	s3,0
        i += 1;
 98e:	b575                	j	83a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 990:	008b8913          	add	s2,s7,8
 994:	4681                	li	a3,0
 996:	4629                	li	a2,10
 998:	000bb583          	ld	a1,0(s7)
 99c:	855a                	mv	a0,s6
 99e:	dabff0ef          	jal	748 <printint>
        i += 2;
 9a2:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 9a4:	8bca                	mv	s7,s2
      state = 0;
 9a6:	4981                	li	s3,0
        i += 2;
 9a8:	bd49                	j	83a <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 9aa:	008b8913          	add	s2,s7,8
 9ae:	4681                	li	a3,0
 9b0:	4641                	li	a2,16
 9b2:	000ba583          	lw	a1,0(s7)
 9b6:	855a                	mv	a0,s6
 9b8:	d91ff0ef          	jal	748 <printint>
 9bc:	8bca                	mv	s7,s2
      state = 0;
 9be:	4981                	li	s3,0
 9c0:	bdad                	j	83a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 9c2:	008b8913          	add	s2,s7,8
 9c6:	4681                	li	a3,0
 9c8:	4641                	li	a2,16
 9ca:	000bb583          	ld	a1,0(s7)
 9ce:	855a                	mv	a0,s6
 9d0:	d79ff0ef          	jal	748 <printint>
        i += 1;
 9d4:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 9d6:	8bca                	mv	s7,s2
      state = 0;
 9d8:	4981                	li	s3,0
        i += 1;
 9da:	b585                	j	83a <vprintf+0x4a>
 9dc:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 9de:	008b8d13          	add	s10,s7,8
 9e2:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 9e6:	03000593          	li	a1,48
 9ea:	855a                	mv	a0,s6
 9ec:	d3fff0ef          	jal	72a <putc>
  putc(fd, 'x');
 9f0:	07800593          	li	a1,120
 9f4:	855a                	mv	a0,s6
 9f6:	d35ff0ef          	jal	72a <putc>
 9fa:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 9fc:	00000b97          	auipc	s7,0x0
 a00:	2bcb8b93          	add	s7,s7,700 # cb8 <digits>
 a04:	03c9d793          	srl	a5,s3,0x3c
 a08:	97de                	add	a5,a5,s7
 a0a:	0007c583          	lbu	a1,0(a5)
 a0e:	855a                	mv	a0,s6
 a10:	d1bff0ef          	jal	72a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a14:	0992                	sll	s3,s3,0x4
 a16:	397d                	addw	s2,s2,-1
 a18:	fe0916e3          	bnez	s2,a04 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 a1c:	8bea                	mv	s7,s10
      state = 0;
 a1e:	4981                	li	s3,0
 a20:	6d02                	ld	s10,0(sp)
 a22:	bd21                	j	83a <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 a24:	008b8993          	add	s3,s7,8
 a28:	000bb903          	ld	s2,0(s7)
 a2c:	00090f63          	beqz	s2,a4a <vprintf+0x25a>
        for(; *s; s++)
 a30:	00094583          	lbu	a1,0(s2)
 a34:	c195                	beqz	a1,a58 <vprintf+0x268>
          putc(fd, *s);
 a36:	855a                	mv	a0,s6
 a38:	cf3ff0ef          	jal	72a <putc>
        for(; *s; s++)
 a3c:	0905                	add	s2,s2,1
 a3e:	00094583          	lbu	a1,0(s2)
 a42:	f9f5                	bnez	a1,a36 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 a44:	8bce                	mv	s7,s3
      state = 0;
 a46:	4981                	li	s3,0
 a48:	bbcd                	j	83a <vprintf+0x4a>
          s = "(null)";
 a4a:	00000917          	auipc	s2,0x0
 a4e:	26690913          	add	s2,s2,614 # cb0 <malloc+0x152>
        for(; *s; s++)
 a52:	02800593          	li	a1,40
 a56:	b7c5                	j	a36 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 a58:	8bce                	mv	s7,s3
      state = 0;
 a5a:	4981                	li	s3,0
 a5c:	bbf9                	j	83a <vprintf+0x4a>
 a5e:	64a6                	ld	s1,72(sp)
 a60:	79e2                	ld	s3,56(sp)
 a62:	7a42                	ld	s4,48(sp)
 a64:	7aa2                	ld	s5,40(sp)
 a66:	7b02                	ld	s6,32(sp)
 a68:	6be2                	ld	s7,24(sp)
 a6a:	6c42                	ld	s8,16(sp)
 a6c:	6ca2                	ld	s9,8(sp)
    }
  }
}
 a6e:	60e6                	ld	ra,88(sp)
 a70:	6446                	ld	s0,80(sp)
 a72:	6906                	ld	s2,64(sp)
 a74:	6125                	add	sp,sp,96
 a76:	8082                	ret

0000000000000a78 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a78:	715d                	add	sp,sp,-80
 a7a:	ec06                	sd	ra,24(sp)
 a7c:	e822                	sd	s0,16(sp)
 a7e:	1000                	add	s0,sp,32
 a80:	e010                	sd	a2,0(s0)
 a82:	e414                	sd	a3,8(s0)
 a84:	e818                	sd	a4,16(s0)
 a86:	ec1c                	sd	a5,24(s0)
 a88:	03043023          	sd	a6,32(s0)
 a8c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a90:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a94:	8622                	mv	a2,s0
 a96:	d5bff0ef          	jal	7f0 <vprintf>
}
 a9a:	60e2                	ld	ra,24(sp)
 a9c:	6442                	ld	s0,16(sp)
 a9e:	6161                	add	sp,sp,80
 aa0:	8082                	ret

0000000000000aa2 <printf>:

void
printf(const char *fmt, ...)
{
 aa2:	711d                	add	sp,sp,-96
 aa4:	ec06                	sd	ra,24(sp)
 aa6:	e822                	sd	s0,16(sp)
 aa8:	1000                	add	s0,sp,32
 aaa:	e40c                	sd	a1,8(s0)
 aac:	e810                	sd	a2,16(s0)
 aae:	ec14                	sd	a3,24(s0)
 ab0:	f018                	sd	a4,32(s0)
 ab2:	f41c                	sd	a5,40(s0)
 ab4:	03043823          	sd	a6,48(s0)
 ab8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 abc:	00840613          	add	a2,s0,8
 ac0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 ac4:	85aa                	mv	a1,a0
 ac6:	4505                	li	a0,1
 ac8:	d29ff0ef          	jal	7f0 <vprintf>
}
 acc:	60e2                	ld	ra,24(sp)
 ace:	6442                	ld	s0,16(sp)
 ad0:	6125                	add	sp,sp,96
 ad2:	8082                	ret

0000000000000ad4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 ad4:	1141                	add	sp,sp,-16
 ad6:	e422                	sd	s0,8(sp)
 ad8:	0800                	add	s0,sp,16
  Header *bp, *p;

  if(ap == 0)
 ada:	cd3d                	beqz	a0,b58 <free+0x84>
    return;
  if((uint64)ap < 4096)
 adc:	6785                	lui	a5,0x1
 ade:	06f56d63          	bltu	a0,a5,b58 <free+0x84>
    return;
  bp = (Header*)ap - 1;
 ae2:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ae6:	00000797          	auipc	a5,0x0
 aea:	5227b783          	ld	a5,1314(a5) # 1008 <freep>
 aee:	a02d                	j	b18 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 af0:	4618                	lw	a4,8(a2)
 af2:	9f2d                	addw	a4,a4,a1
 af4:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 af8:	6398                	ld	a4,0(a5)
 afa:	6310                	ld	a2,0(a4)
 afc:	a83d                	j	b3a <free+0x66>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 afe:	ff852703          	lw	a4,-8(a0)
 b02:	9f31                	addw	a4,a4,a2
 b04:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 b06:	ff053683          	ld	a3,-16(a0)
 b0a:	a091                	j	b4e <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b0c:	6398                	ld	a4,0(a5)
 b0e:	00e7e463          	bltu	a5,a4,b16 <free+0x42>
 b12:	00e6ea63          	bltu	a3,a4,b26 <free+0x52>
{
 b16:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b18:	fed7fae3          	bgeu	a5,a3,b0c <free+0x38>
 b1c:	6398                	ld	a4,0(a5)
 b1e:	00e6e463          	bltu	a3,a4,b26 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b22:	fee7eae3          	bltu	a5,a4,b16 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 b26:	ff852583          	lw	a1,-8(a0)
 b2a:	6390                	ld	a2,0(a5)
 b2c:	02059813          	sll	a6,a1,0x20
 b30:	01c85713          	srl	a4,a6,0x1c
 b34:	9736                	add	a4,a4,a3
 b36:	fae60de3          	beq	a2,a4,af0 <free+0x1c>
    bp->s.ptr = p->s.ptr->s.ptr;
 b3a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 b3e:	4790                	lw	a2,8(a5)
 b40:	02061593          	sll	a1,a2,0x20
 b44:	01c5d713          	srl	a4,a1,0x1c
 b48:	973e                	add	a4,a4,a5
 b4a:	fae68ae3          	beq	a3,a4,afe <free+0x2a>
    p->s.ptr = bp->s.ptr;
 b4e:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 b50:	00000717          	auipc	a4,0x0
 b54:	4af73c23          	sd	a5,1208(a4) # 1008 <freep>
}
 b58:	6422                	ld	s0,8(sp)
 b5a:	0141                	add	sp,sp,16
 b5c:	8082                	ret

0000000000000b5e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b5e:	7139                	add	sp,sp,-64
 b60:	fc06                	sd	ra,56(sp)
 b62:	f822                	sd	s0,48(sp)
 b64:	f426                	sd	s1,40(sp)
 b66:	ec4e                	sd	s3,24(sp)
 b68:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b6a:	02051493          	sll	s1,a0,0x20
 b6e:	9081                	srl	s1,s1,0x20
 b70:	04bd                	add	s1,s1,15
 b72:	8091                	srl	s1,s1,0x4
 b74:	0014899b          	addw	s3,s1,1
 b78:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 b7a:	00000517          	auipc	a0,0x0
 b7e:	48e53503          	ld	a0,1166(a0) # 1008 <freep>
 b82:	c915                	beqz	a0,bb6 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b84:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b86:	4798                	lw	a4,8(a5)
 b88:	08977a63          	bgeu	a4,s1,c1c <malloc+0xbe>
 b8c:	f04a                	sd	s2,32(sp)
 b8e:	e852                	sd	s4,16(sp)
 b90:	e456                	sd	s5,8(sp)
 b92:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 b94:	8a4e                	mv	s4,s3
 b96:	0009871b          	sext.w	a4,s3
 b9a:	6685                	lui	a3,0x1
 b9c:	00d77363          	bgeu	a4,a3,ba2 <malloc+0x44>
 ba0:	6a05                	lui	s4,0x1
 ba2:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 ba6:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 baa:	00000917          	auipc	s2,0x0
 bae:	45e90913          	add	s2,s2,1118 # 1008 <freep>
  if(p == (char*)-1)
 bb2:	5afd                	li	s5,-1
 bb4:	a081                	j	bf4 <malloc+0x96>
 bb6:	f04a                	sd	s2,32(sp)
 bb8:	e852                	sd	s4,16(sp)
 bba:	e456                	sd	s5,8(sp)
 bbc:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 bbe:	00000797          	auipc	a5,0x0
 bc2:	45278793          	add	a5,a5,1106 # 1010 <base>
 bc6:	00000717          	auipc	a4,0x0
 bca:	44f73123          	sd	a5,1090(a4) # 1008 <freep>
 bce:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 bd0:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 bd4:	b7c1                	j	b94 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 bd6:	6398                	ld	a4,0(a5)
 bd8:	e118                	sd	a4,0(a0)
 bda:	a8a9                	j	c34 <malloc+0xd6>
  hp->s.size = nu;
 bdc:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 be0:	0541                	add	a0,a0,16
 be2:	ef3ff0ef          	jal	ad4 <free>
  return freep;
 be6:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 bea:	c12d                	beqz	a0,c4c <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bec:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 bee:	4798                	lw	a4,8(a5)
 bf0:	02977263          	bgeu	a4,s1,c14 <malloc+0xb6>
    if(p == freep)
 bf4:	00093703          	ld	a4,0(s2)
 bf8:	853e                	mv	a0,a5
 bfa:	fef719e3          	bne	a4,a5,bec <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 bfe:	8552                	mv	a0,s4
 c00:	ab9ff0ef          	jal	6b8 <sbrk>
  if(p == (char*)-1)
 c04:	fd551ce3          	bne	a0,s5,bdc <malloc+0x7e>
        return 0;
 c08:	4501                	li	a0,0
 c0a:	7902                	ld	s2,32(sp)
 c0c:	6a42                	ld	s4,16(sp)
 c0e:	6aa2                	ld	s5,8(sp)
 c10:	6b02                	ld	s6,0(sp)
 c12:	a03d                	j	c40 <malloc+0xe2>
 c14:	7902                	ld	s2,32(sp)
 c16:	6a42                	ld	s4,16(sp)
 c18:	6aa2                	ld	s5,8(sp)
 c1a:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 c1c:	fae48de3          	beq	s1,a4,bd6 <malloc+0x78>
        p->s.size -= nunits;
 c20:	4137073b          	subw	a4,a4,s3
 c24:	c798                	sw	a4,8(a5)
        p += p->s.size;
 c26:	02071693          	sll	a3,a4,0x20
 c2a:	01c6d713          	srl	a4,a3,0x1c
 c2e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 c30:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 c34:	00000717          	auipc	a4,0x0
 c38:	3ca73a23          	sd	a0,980(a4) # 1008 <freep>
      return (void*)(p + 1);
 c3c:	01078513          	add	a0,a5,16
  }
}
 c40:	70e2                	ld	ra,56(sp)
 c42:	7442                	ld	s0,48(sp)
 c44:	74a2                	ld	s1,40(sp)
 c46:	69e2                	ld	s3,24(sp)
 c48:	6121                	add	sp,sp,64
 c4a:	8082                	ret
 c4c:	7902                	ld	s2,32(sp)
 c4e:	6a42                	ld	s4,16(sp)
 c50:	6aa2                	ld	s5,8(sp)
 c52:	6b02                	ld	s6,0(sp)
 c54:	b7f5                	j	c40 <malloc+0xe2>
