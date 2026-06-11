
user/_tcpecho:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "user/user.h"
#include "kernel/net/socket.h"

int
main (int argc, char *argv[])
{
   0:	7119                	add	sp,sp,-128
   2:	fc86                	sd	ra,120(sp)
   4:	f8a2                	sd	s0,112(sp)
   6:	f4a6                	sd	s1,104(sp)
   8:	f0ca                	sd	s2,96(sp)
   a:	ecce                	sd	s3,88(sp)
   c:	e8d2                	sd	s4,80(sp)
   e:	e4d6                	sd	s5,72(sp)
  10:	e0da                	sd	s6,64(sp)
  12:	0100                	add	s0,sp,128
  14:	81010113          	add	sp,sp,-2032
    int soc, acc, peerlen, ret;
    struct sockaddr_in self, peer;
    unsigned char *addr;
    char buf[2048];

    printf("Starting TCP Echo Server\n");
  18:	00001517          	auipc	a0,0x1
  1c:	ca850513          	add	a0,a0,-856 # cc0 <malloc+0x102>
  20:	2e3000ef          	jal	b02 <printf>
    soc = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
  24:	4601                	li	a2,0
  26:	4589                	li	a1,2
  28:	4505                	li	a0,1
  2a:	706000ef          	jal	730 <socket>
    if (soc == 1) {
  2e:	4785                	li	a5,1
  30:	12f50063          	beq	a0,a5,150 <main+0x150>
  34:	892a                	mv	s2,a0
        printf("socket: failure\n");
        exit(1);
    }
    printf("socket: success, soc=%d\n", soc);
  36:	85aa                	mv	a1,a0
  38:	00001517          	auipc	a0,0x1
  3c:	cc050513          	add	a0,a0,-832 # cf8 <malloc+0x13a>
  40:	2c3000ef          	jal	b02 <printf>
    self.sin_family = AF_INET;
  44:	4785                	li	a5,1
  46:	faf41823          	sh	a5,-80(s0)
    self.sin_addr.s_addr = INADDR_ANY;
  4a:	fa042a23          	sw	zero,-76(s0)
    self.sin_port = htons(7);
  4e:	451d                	li	a0,7
  50:	3bc000ef          	jal	40c <htons>
  54:	faa41923          	sh	a0,-78(s0)
    if (bind(soc, (struct sockaddr *)&self, sizeof(self)) == -1) {
  58:	4621                	li	a2,8
  5a:	fb040593          	add	a1,s0,-80
  5e:	854a                	mv	a0,s2
  60:	6d8000ef          	jal	738 <bind>
  64:	57fd                	li	a5,-1
  66:	0ef50e63          	beq	a0,a5,162 <main+0x162>
        printf("bind: failure\n");
        close(soc);
        exit(1);
    }
    addr = (unsigned char *)&self.sin_addr;
    printf("bind: success, self=%d.%d.%d.%d:%d\n", addr[0], addr[1], addr[2], addr[3], ntohs(self.sin_port));
  6a:	fb444483          	lbu	s1,-76(s0)
  6e:	fb544983          	lbu	s3,-75(s0)
  72:	fb644a03          	lbu	s4,-74(s0)
  76:	fb744a83          	lbu	s5,-73(s0)
  7a:	fb245503          	lhu	a0,-78(s0)
  7e:	3ca000ef          	jal	448 <ntohs>
  82:	0005079b          	sext.w	a5,a0
  86:	8756                	mv	a4,s5
  88:	86d2                	mv	a3,s4
  8a:	864e                	mv	a2,s3
  8c:	85a6                	mv	a1,s1
  8e:	00001517          	auipc	a0,0x1
  92:	c9a50513          	add	a0,a0,-870 # d28 <malloc+0x16a>
  96:	26d000ef          	jal	b02 <printf>
    listen(soc, 100);
  9a:	06400593          	li	a1,100
  9e:	854a                	mv	a0,s2
  a0:	6b8000ef          	jal	758 <listen>
    printf("waiting for connection...\n");
  a4:	00001517          	auipc	a0,0x1
  a8:	cac50513          	add	a0,a0,-852 # d50 <malloc+0x192>
  ac:	257000ef          	jal	b02 <printf>
    peerlen = sizeof(peer);
  b0:	47a1                	li	a5,8
  b2:	faf42e23          	sw	a5,-68(s0)
    acc = accept(soc, (struct sockaddr *)&peer, &peerlen);
  b6:	fbc40613          	add	a2,s0,-68
  ba:	fa840593          	add	a1,s0,-88
  be:	854a                	mv	a0,s2
  c0:	6a0000ef          	jal	760 <accept>
  c4:	89aa                	mv	s3,a0
    if (acc == -1) {
  c6:	57fd                	li	a5,-1
  c8:	0af50963          	beq	a0,a5,17a <main+0x17a>
        printf("accept: failure\n");
        close(soc);
        exit(1);
    }
    addr = (unsigned char *)&peer.sin_addr;
    printf("accept: success, peer=%d.%d.%d.%d:%d\n", addr[0], addr[1], addr[2], addr[3], ntohs(peer.sin_port));
  cc:	fac44483          	lbu	s1,-84(s0)
  d0:	fad44a03          	lbu	s4,-83(s0)
  d4:	fae44a83          	lbu	s5,-82(s0)
  d8:	faf44b03          	lbu	s6,-81(s0)
  dc:	faa45503          	lhu	a0,-86(s0)
  e0:	368000ef          	jal	448 <ntohs>
  e4:	0005079b          	sext.w	a5,a0
  e8:	875a                	mv	a4,s6
  ea:	86d6                	mv	a3,s5
  ec:	8652                	mv	a2,s4
  ee:	85a6                	mv	a1,s1
  f0:	00001517          	auipc	a0,0x1
  f4:	c9850513          	add	a0,a0,-872 # d88 <malloc+0x1ca>
  f8:	20b000ef          	jal	b02 <printf>
    while (1) {
        ret = recv(acc, buf, sizeof(buf));
  fc:	77fd                	lui	a5,0xfffff
  fe:	7a878793          	add	a5,a5,1960 # fffffffffffff7a8 <base+0xffffffffffffe798>
 102:	97a2                	add	a5,a5,s0
 104:	777d                	lui	a4,0xfffff
 106:	79870713          	add	a4,a4,1944 # fffffffffffff798 <base+0xffffffffffffe788>
 10a:	9722                	add	a4,a4,s0
 10c:	e31c                	sd	a5,0(a4)
 10e:	6a05                	lui	s4,0x1
 110:	800a0a13          	add	s4,s4,-2048 # 800 <printint+0x58>
        if (ret <= 0) {
            printf("EOF\n");
            break;
        }
        printf("recv: %d bytes data received\n", ret);
 114:	00001a97          	auipc	s5,0x1
 118:	ca4a8a93          	add	s5,s5,-860 # db8 <malloc+0x1fa>
        ret = recv(acc, buf, sizeof(buf));
 11c:	8652                	mv	a2,s4
 11e:	77fd                	lui	a5,0xfffff
 120:	79878793          	add	a5,a5,1944 # fffffffffffff798 <base+0xffffffffffffe788>
 124:	97a2                	add	a5,a5,s0
 126:	638c                	ld	a1,0(a5)
 128:	854e                	mv	a0,s3
 12a:	63e000ef          	jal	768 <recv>
 12e:	84aa                	mv	s1,a0
        if (ret <= 0) {
 130:	06a05163          	blez	a0,192 <main+0x192>
        printf("recv: %d bytes data received\n", ret);
 134:	85aa                	mv	a1,a0
 136:	8556                	mv	a0,s5
 138:	1cb000ef          	jal	b02 <printf>
        send(acc, buf, ret);
 13c:	8626                	mv	a2,s1
 13e:	77fd                	lui	a5,0xfffff
 140:	79878793          	add	a5,a5,1944 # fffffffffffff798 <base+0xffffffffffffe788>
 144:	97a2                	add	a5,a5,s0
 146:	638c                	ld	a1,0(a5)
 148:	854e                	mv	a0,s3
 14a:	626000ef          	jal	770 <send>
        ret = recv(acc, buf, sizeof(buf));
 14e:	b7f9                	j	11c <main+0x11c>
        printf("socket: failure\n");
 150:	00001517          	auipc	a0,0x1
 154:	b9050513          	add	a0,a0,-1136 # ce0 <malloc+0x122>
 158:	1ab000ef          	jal	b02 <printf>
        exit(1);
 15c:	4505                	li	a0,1
 15e:	532000ef          	jal	690 <exit>
        printf("bind: failure\n");
 162:	00001517          	auipc	a0,0x1
 166:	bb650513          	add	a0,a0,-1098 # d18 <malloc+0x15a>
 16a:	199000ef          	jal	b02 <printf>
        close(soc);
 16e:	854a                	mv	a0,s2
 170:	548000ef          	jal	6b8 <close>
        exit(1);
 174:	4505                	li	a0,1
 176:	51a000ef          	jal	690 <exit>
        printf("accept: failure\n");
 17a:	00001517          	auipc	a0,0x1
 17e:	bf650513          	add	a0,a0,-1034 # d70 <malloc+0x1b2>
 182:	181000ef          	jal	b02 <printf>
        close(soc);
 186:	854a                	mv	a0,s2
 188:	530000ef          	jal	6b8 <close>
        exit(1);
 18c:	4505                	li	a0,1
 18e:	502000ef          	jal	690 <exit>
            printf("EOF\n");
 192:	00001517          	auipc	a0,0x1
 196:	c1e50513          	add	a0,a0,-994 # db0 <malloc+0x1f2>
 19a:	169000ef          	jal	b02 <printf>
    }
    close(soc);  
 19e:	854a                	mv	a0,s2
 1a0:	518000ef          	jal	6b8 <close>
    exit(0);
 1a4:	4501                	li	a0,0
 1a6:	4ea000ef          	jal	690 <exit>

00000000000001aa <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 1aa:	1141                	add	sp,sp,-16
 1ac:	e406                	sd	ra,8(sp)
 1ae:	e022                	sd	s0,0(sp)
 1b0:	0800                	add	s0,sp,16
  extern int main();
  main();
 1b2:	e4fff0ef          	jal	0 <main>
  exit(0);
 1b6:	4501                	li	a0,0
 1b8:	4d8000ef          	jal	690 <exit>

00000000000001bc <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 1bc:	1141                	add	sp,sp,-16
 1be:	e422                	sd	s0,8(sp)
 1c0:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1c2:	87aa                	mv	a5,a0
 1c4:	0585                	add	a1,a1,1
 1c6:	0785                	add	a5,a5,1
 1c8:	fff5c703          	lbu	a4,-1(a1)
 1cc:	fee78fa3          	sb	a4,-1(a5)
 1d0:	fb75                	bnez	a4,1c4 <strcpy+0x8>
    ;
  return os;
}
 1d2:	6422                	ld	s0,8(sp)
 1d4:	0141                	add	sp,sp,16
 1d6:	8082                	ret

00000000000001d8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1d8:	1141                	add	sp,sp,-16
 1da:	e422                	sd	s0,8(sp)
 1dc:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 1de:	00054783          	lbu	a5,0(a0)
 1e2:	cb91                	beqz	a5,1f6 <strcmp+0x1e>
 1e4:	0005c703          	lbu	a4,0(a1)
 1e8:	00f71763          	bne	a4,a5,1f6 <strcmp+0x1e>
    p++, q++;
 1ec:	0505                	add	a0,a0,1
 1ee:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 1f0:	00054783          	lbu	a5,0(a0)
 1f4:	fbe5                	bnez	a5,1e4 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1f6:	0005c503          	lbu	a0,0(a1)
}
 1fa:	40a7853b          	subw	a0,a5,a0
 1fe:	6422                	ld	s0,8(sp)
 200:	0141                	add	sp,sp,16
 202:	8082                	ret

0000000000000204 <strlen>:

uint
strlen(const char *s)
{
 204:	1141                	add	sp,sp,-16
 206:	e422                	sd	s0,8(sp)
 208:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 20a:	00054783          	lbu	a5,0(a0)
 20e:	cf91                	beqz	a5,22a <strlen+0x26>
 210:	0505                	add	a0,a0,1
 212:	87aa                	mv	a5,a0
 214:	86be                	mv	a3,a5
 216:	0785                	add	a5,a5,1
 218:	fff7c703          	lbu	a4,-1(a5)
 21c:	ff65                	bnez	a4,214 <strlen+0x10>
 21e:	40a6853b          	subw	a0,a3,a0
 222:	2505                	addw	a0,a0,1
    ;
  return n;
}
 224:	6422                	ld	s0,8(sp)
 226:	0141                	add	sp,sp,16
 228:	8082                	ret
  for(n = 0; s[n]; n++)
 22a:	4501                	li	a0,0
 22c:	bfe5                	j	224 <strlen+0x20>

000000000000022e <memset>:

void*
memset(void *dst, int c, uint n)
{
 22e:	1141                	add	sp,sp,-16
 230:	e422                	sd	s0,8(sp)
 232:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 234:	ca19                	beqz	a2,24a <memset+0x1c>
 236:	87aa                	mv	a5,a0
 238:	1602                	sll	a2,a2,0x20
 23a:	9201                	srl	a2,a2,0x20
 23c:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 240:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 244:	0785                	add	a5,a5,1
 246:	fee79de3          	bne	a5,a4,240 <memset+0x12>
  }
  return dst;
}
 24a:	6422                	ld	s0,8(sp)
 24c:	0141                	add	sp,sp,16
 24e:	8082                	ret

0000000000000250 <strchr>:

char*
strchr(const char *s, char c)
{
 250:	1141                	add	sp,sp,-16
 252:	e422                	sd	s0,8(sp)
 254:	0800                	add	s0,sp,16
  for(; *s; s++)
 256:	00054783          	lbu	a5,0(a0)
 25a:	cb99                	beqz	a5,270 <strchr+0x20>
    if(*s == c)
 25c:	00f58763          	beq	a1,a5,26a <strchr+0x1a>
  for(; *s; s++)
 260:	0505                	add	a0,a0,1
 262:	00054783          	lbu	a5,0(a0)
 266:	fbfd                	bnez	a5,25c <strchr+0xc>
      return (char*)s;
  return 0;
 268:	4501                	li	a0,0
}
 26a:	6422                	ld	s0,8(sp)
 26c:	0141                	add	sp,sp,16
 26e:	8082                	ret
  return 0;
 270:	4501                	li	a0,0
 272:	bfe5                	j	26a <strchr+0x1a>

0000000000000274 <gets>:

char*
gets(char *buf, int max)
{
 274:	711d                	add	sp,sp,-96
 276:	ec86                	sd	ra,88(sp)
 278:	e8a2                	sd	s0,80(sp)
 27a:	e4a6                	sd	s1,72(sp)
 27c:	e0ca                	sd	s2,64(sp)
 27e:	fc4e                	sd	s3,56(sp)
 280:	f852                	sd	s4,48(sp)
 282:	f456                	sd	s5,40(sp)
 284:	f05a                	sd	s6,32(sp)
 286:	ec5e                	sd	s7,24(sp)
 288:	1080                	add	s0,sp,96
 28a:	8baa                	mv	s7,a0
 28c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 28e:	892a                	mv	s2,a0
 290:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 292:	4aa9                	li	s5,10
 294:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 296:	89a6                	mv	s3,s1
 298:	2485                	addw	s1,s1,1
 29a:	0344d663          	bge	s1,s4,2c6 <gets+0x52>
    cc = read(0, &c, 1);
 29e:	4605                	li	a2,1
 2a0:	faf40593          	add	a1,s0,-81
 2a4:	4501                	li	a0,0
 2a6:	402000ef          	jal	6a8 <read>
    if(cc < 1)
 2aa:	00a05e63          	blez	a0,2c6 <gets+0x52>
    buf[i++] = c;
 2ae:	faf44783          	lbu	a5,-81(s0)
 2b2:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2b6:	01578763          	beq	a5,s5,2c4 <gets+0x50>
 2ba:	0905                	add	s2,s2,1
 2bc:	fd679de3          	bne	a5,s6,296 <gets+0x22>
    buf[i++] = c;
 2c0:	89a6                	mv	s3,s1
 2c2:	a011                	j	2c6 <gets+0x52>
 2c4:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2c6:	99de                	add	s3,s3,s7
 2c8:	00098023          	sb	zero,0(s3)
  return buf;
}
 2cc:	855e                	mv	a0,s7
 2ce:	60e6                	ld	ra,88(sp)
 2d0:	6446                	ld	s0,80(sp)
 2d2:	64a6                	ld	s1,72(sp)
 2d4:	6906                	ld	s2,64(sp)
 2d6:	79e2                	ld	s3,56(sp)
 2d8:	7a42                	ld	s4,48(sp)
 2da:	7aa2                	ld	s5,40(sp)
 2dc:	7b02                	ld	s6,32(sp)
 2de:	6be2                	ld	s7,24(sp)
 2e0:	6125                	add	sp,sp,96
 2e2:	8082                	ret

00000000000002e4 <stat>:

int
stat(const char *n, struct stat *st)
{
 2e4:	1101                	add	sp,sp,-32
 2e6:	ec06                	sd	ra,24(sp)
 2e8:	e822                	sd	s0,16(sp)
 2ea:	e04a                	sd	s2,0(sp)
 2ec:	1000                	add	s0,sp,32
 2ee:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2f0:	4581                	li	a1,0
 2f2:	3de000ef          	jal	6d0 <open>
  if(fd < 0)
 2f6:	02054263          	bltz	a0,31a <stat+0x36>
 2fa:	e426                	sd	s1,8(sp)
 2fc:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2fe:	85ca                	mv	a1,s2
 300:	3e8000ef          	jal	6e8 <fstat>
 304:	892a                	mv	s2,a0
  close(fd);
 306:	8526                	mv	a0,s1
 308:	3b0000ef          	jal	6b8 <close>
  return r;
 30c:	64a2                	ld	s1,8(sp)
}
 30e:	854a                	mv	a0,s2
 310:	60e2                	ld	ra,24(sp)
 312:	6442                	ld	s0,16(sp)
 314:	6902                	ld	s2,0(sp)
 316:	6105                	add	sp,sp,32
 318:	8082                	ret
    return -1;
 31a:	597d                	li	s2,-1
 31c:	bfcd                	j	30e <stat+0x2a>

000000000000031e <atoi>:

int
atoi(const char *s)
{
 31e:	1141                	add	sp,sp,-16
 320:	e422                	sd	s0,8(sp)
 322:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 324:	00054683          	lbu	a3,0(a0)
 328:	fd06879b          	addw	a5,a3,-48
 32c:	0ff7f793          	zext.b	a5,a5
 330:	4625                	li	a2,9
 332:	02f66863          	bltu	a2,a5,362 <atoi+0x44>
 336:	872a                	mv	a4,a0
  n = 0;
 338:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 33a:	0705                	add	a4,a4,1
 33c:	0025179b          	sllw	a5,a0,0x2
 340:	9fa9                	addw	a5,a5,a0
 342:	0017979b          	sllw	a5,a5,0x1
 346:	9fb5                	addw	a5,a5,a3
 348:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 34c:	00074683          	lbu	a3,0(a4)
 350:	fd06879b          	addw	a5,a3,-48
 354:	0ff7f793          	zext.b	a5,a5
 358:	fef671e3          	bgeu	a2,a5,33a <atoi+0x1c>
  return n;
}
 35c:	6422                	ld	s0,8(sp)
 35e:	0141                	add	sp,sp,16
 360:	8082                	ret
  n = 0;
 362:	4501                	li	a0,0
 364:	bfe5                	j	35c <atoi+0x3e>

0000000000000366 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 366:	1141                	add	sp,sp,-16
 368:	e422                	sd	s0,8(sp)
 36a:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 36c:	02b57463          	bgeu	a0,a1,394 <memmove+0x2e>
    while(n-- > 0)
 370:	00c05f63          	blez	a2,38e <memmove+0x28>
 374:	1602                	sll	a2,a2,0x20
 376:	9201                	srl	a2,a2,0x20
 378:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 37c:	872a                	mv	a4,a0
      *dst++ = *src++;
 37e:	0585                	add	a1,a1,1
 380:	0705                	add	a4,a4,1
 382:	fff5c683          	lbu	a3,-1(a1)
 386:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 38a:	fef71ae3          	bne	a4,a5,37e <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 38e:	6422                	ld	s0,8(sp)
 390:	0141                	add	sp,sp,16
 392:	8082                	ret
    dst += n;
 394:	00c50733          	add	a4,a0,a2
    src += n;
 398:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 39a:	fec05ae3          	blez	a2,38e <memmove+0x28>
 39e:	fff6079b          	addw	a5,a2,-1
 3a2:	1782                	sll	a5,a5,0x20
 3a4:	9381                	srl	a5,a5,0x20
 3a6:	fff7c793          	not	a5,a5
 3aa:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3ac:	15fd                	add	a1,a1,-1
 3ae:	177d                	add	a4,a4,-1
 3b0:	0005c683          	lbu	a3,0(a1)
 3b4:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3b8:	fee79ae3          	bne	a5,a4,3ac <memmove+0x46>
 3bc:	bfc9                	j	38e <memmove+0x28>

00000000000003be <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3be:	1141                	add	sp,sp,-16
 3c0:	e422                	sd	s0,8(sp)
 3c2:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3c4:	ca05                	beqz	a2,3f4 <memcmp+0x36>
 3c6:	fff6069b          	addw	a3,a2,-1
 3ca:	1682                	sll	a3,a3,0x20
 3cc:	9281                	srl	a3,a3,0x20
 3ce:	0685                	add	a3,a3,1
 3d0:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3d2:	00054783          	lbu	a5,0(a0)
 3d6:	0005c703          	lbu	a4,0(a1)
 3da:	00e79863          	bne	a5,a4,3ea <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 3de:	0505                	add	a0,a0,1
    p2++;
 3e0:	0585                	add	a1,a1,1
  while (n-- > 0) {
 3e2:	fed518e3          	bne	a0,a3,3d2 <memcmp+0x14>
  }
  return 0;
 3e6:	4501                	li	a0,0
 3e8:	a019                	j	3ee <memcmp+0x30>
      return *p1 - *p2;
 3ea:	40e7853b          	subw	a0,a5,a4
}
 3ee:	6422                	ld	s0,8(sp)
 3f0:	0141                	add	sp,sp,16
 3f2:	8082                	ret
  return 0;
 3f4:	4501                	li	a0,0
 3f6:	bfe5                	j	3ee <memcmp+0x30>

00000000000003f8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3f8:	1141                	add	sp,sp,-16
 3fa:	e406                	sd	ra,8(sp)
 3fc:	e022                	sd	s0,0(sp)
 3fe:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 400:	f67ff0ef          	jal	366 <memmove>
}
 404:	60a2                	ld	ra,8(sp)
 406:	6402                	ld	s0,0(sp)
 408:	0141                	add	sp,sp,16
 40a:	8082                	ret

000000000000040c <htons>:
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
}

uint16_t
htons(uint16_t h)
{
 40c:	1141                	add	sp,sp,-16
 40e:	e422                	sd	s0,8(sp)
 410:	0800                	add	s0,sp,16
    if (!endian) {
 412:	00001797          	auipc	a5,0x1
 416:	bee7a783          	lw	a5,-1042(a5) # 1000 <endian>
 41a:	e385                	bnez	a5,43a <htons+0x2e>
        endian = byteorder();
 41c:	4d200793          	li	a5,1234
 420:	00001717          	auipc	a4,0x1
 424:	bef72023          	sw	a5,-1056(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 428:	0085179b          	sllw	a5,a0,0x8
 42c:	0085551b          	srlw	a0,a0,0x8
 430:	8fc9                	or	a5,a5,a0
 432:	03079513          	sll	a0,a5,0x30
 436:	9141                	srl	a0,a0,0x30
 438:	a029                	j	442 <htons+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(h) : h;
 43a:	4d200713          	li	a4,1234
 43e:	fee785e3          	beq	a5,a4,428 <htons+0x1c>
}
 442:	6422                	ld	s0,8(sp)
 444:	0141                	add	sp,sp,16
 446:	8082                	ret

0000000000000448 <ntohs>:

uint16_t
ntohs(uint16_t n)
{
 448:	1141                	add	sp,sp,-16
 44a:	e422                	sd	s0,8(sp)
 44c:	0800                	add	s0,sp,16
    if (!endian) {
 44e:	00001797          	auipc	a5,0x1
 452:	bb27a783          	lw	a5,-1102(a5) # 1000 <endian>
 456:	e385                	bnez	a5,476 <ntohs+0x2e>
        endian = byteorder();
 458:	4d200793          	li	a5,1234
 45c:	00001717          	auipc	a4,0x1
 460:	baf72223          	sw	a5,-1116(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 464:	0085179b          	sllw	a5,a0,0x8
 468:	0085551b          	srlw	a0,a0,0x8
 46c:	8fc9                	or	a5,a5,a0
 46e:	03079513          	sll	a0,a5,0x30
 472:	9141                	srl	a0,a0,0x30
 474:	a029                	j	47e <ntohs+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(n) : n;
 476:	4d200713          	li	a4,1234
 47a:	fee785e3          	beq	a5,a4,464 <ntohs+0x1c>
}
 47e:	6422                	ld	s0,8(sp)
 480:	0141                	add	sp,sp,16
 482:	8082                	ret

0000000000000484 <htonl>:

uint32_t
htonl(uint32_t h)
{
 484:	1141                	add	sp,sp,-16
 486:	e422                	sd	s0,8(sp)
 488:	0800                	add	s0,sp,16
    if (!endian) {
 48a:	00001797          	auipc	a5,0x1
 48e:	b767a783          	lw	a5,-1162(a5) # 1000 <endian>
 492:	ef85                	bnez	a5,4ca <htonl+0x46>
        endian = byteorder();
 494:	4d200793          	li	a5,1234
 498:	00001717          	auipc	a4,0x1
 49c:	b6f72423          	sw	a5,-1176(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 4a0:	0185179b          	sllw	a5,a0,0x18
 4a4:	0185571b          	srlw	a4,a0,0x18
 4a8:	8fd9                	or	a5,a5,a4
 4aa:	0085171b          	sllw	a4,a0,0x8
 4ae:	00ff06b7          	lui	a3,0xff0
 4b2:	8f75                	and	a4,a4,a3
 4b4:	8fd9                	or	a5,a5,a4
 4b6:	0085551b          	srlw	a0,a0,0x8
 4ba:	6741                	lui	a4,0x10
 4bc:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeef0>
 4c0:	8d79                	and	a0,a0,a4
 4c2:	8fc9                	or	a5,a5,a0
 4c4:	0007851b          	sext.w	a0,a5
 4c8:	a029                	j	4d2 <htonl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(h) : h;
 4ca:	4d200713          	li	a4,1234
 4ce:	fce789e3          	beq	a5,a4,4a0 <htonl+0x1c>
}
 4d2:	6422                	ld	s0,8(sp)
 4d4:	0141                	add	sp,sp,16
 4d6:	8082                	ret

00000000000004d8 <ntohl>:

uint32_t
ntohl(uint32_t n)
{
 4d8:	1141                	add	sp,sp,-16
 4da:	e422                	sd	s0,8(sp)
 4dc:	0800                	add	s0,sp,16
    if (!endian) {
 4de:	00001797          	auipc	a5,0x1
 4e2:	b227a783          	lw	a5,-1246(a5) # 1000 <endian>
 4e6:	ef85                	bnez	a5,51e <ntohl+0x46>
        endian = byteorder();
 4e8:	4d200793          	li	a5,1234
 4ec:	00001717          	auipc	a4,0x1
 4f0:	b0f72a23          	sw	a5,-1260(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 4f4:	0185179b          	sllw	a5,a0,0x18
 4f8:	0185571b          	srlw	a4,a0,0x18
 4fc:	8fd9                	or	a5,a5,a4
 4fe:	0085171b          	sllw	a4,a0,0x8
 502:	00ff06b7          	lui	a3,0xff0
 506:	8f75                	and	a4,a4,a3
 508:	8fd9                	or	a5,a5,a4
 50a:	0085551b          	srlw	a0,a0,0x8
 50e:	6741                	lui	a4,0x10
 510:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeef0>
 514:	8d79                	and	a0,a0,a4
 516:	8fc9                	or	a5,a5,a0
 518:	0007851b          	sext.w	a0,a5
 51c:	a029                	j	526 <ntohl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(n) : n;
 51e:	4d200713          	li	a4,1234
 522:	fce789e3          	beq	a5,a4,4f4 <ntohl+0x1c>
}
 526:	6422                	ld	s0,8(sp)
 528:	0141                	add	sp,sp,16
 52a:	8082                	ret

000000000000052c <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
 52c:	1141                	add	sp,sp,-16
 52e:	e422                	sd	s0,8(sp)
 530:	0800                	add	s0,sp,16
 532:	872a                	mv	a4,a0
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
 534:	02000693          	li	a3,32
 538:	4525                	li	a0,9
 53a:	a011                	j	53e <strtol+0x12>
        s++;
 53c:	0705                	add	a4,a4,1
    while (*s == ' ' || *s == '\t')
 53e:	00074783          	lbu	a5,0(a4)
 542:	fed78de3          	beq	a5,a3,53c <strtol+0x10>
 546:	fea78be3          	beq	a5,a0,53c <strtol+0x10>

    // plus/minus sign
    if (*s == '+')
 54a:	02b00693          	li	a3,43
 54e:	02d78663          	beq	a5,a3,57a <strtol+0x4e>
        s++;
    else if (*s == '-')
 552:	02d00693          	li	a3,45
    int neg = 0;
 556:	4301                	li	t1,0
    else if (*s == '-')
 558:	02d78463          	beq	a5,a3,580 <strtol+0x54>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 55c:	fef67793          	and	a5,a2,-17
 560:	eb89                	bnez	a5,572 <strtol+0x46>
 562:	00074683          	lbu	a3,0(a4)
 566:	03000793          	li	a5,48
 56a:	00f68e63          	beq	a3,a5,586 <strtol+0x5a>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
 56e:	e211                	bnez	a2,572 <strtol+0x46>
        s++, base = 8;
    else if (base == 0)
        base = 10;
 570:	4629                	li	a2,10
 572:	4501                	li	a0,0

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
 574:	4825                	li	a6,9
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
 576:	48e5                	li	a7,25
 578:	a825                	j	5b0 <strtol+0x84>
        s++;
 57a:	0705                	add	a4,a4,1
    int neg = 0;
 57c:	4301                	li	t1,0
 57e:	bff9                	j	55c <strtol+0x30>
        s++, neg = 1;
 580:	0705                	add	a4,a4,1
 582:	4305                	li	t1,1
 584:	bfe1                	j	55c <strtol+0x30>
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 586:	00174683          	lbu	a3,1(a4)
 58a:	07800793          	li	a5,120
 58e:	00f68663          	beq	a3,a5,59a <strtol+0x6e>
    else if (base == 0 && s[0] == '0')
 592:	f265                	bnez	a2,572 <strtol+0x46>
        s++, base = 8;
 594:	0705                	add	a4,a4,1
 596:	4621                	li	a2,8
 598:	bfe9                	j	572 <strtol+0x46>
        s += 2, base = 16;
 59a:	0709                	add	a4,a4,2
 59c:	4641                	li	a2,16
 59e:	bfd1                	j	572 <strtol+0x46>
            dig = *s - '0';
 5a0:	fd07879b          	addw	a5,a5,-48
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
 5a4:	04c7d063          	bge	a5,a2,5e4 <strtol+0xb8>
            break;
        s++, val = (val * base) + dig;
 5a8:	0705                	add	a4,a4,1
 5aa:	02a60533          	mul	a0,a2,a0
 5ae:	953e                	add	a0,a0,a5
        if (*s >= '0' && *s <= '9')
 5b0:	00074783          	lbu	a5,0(a4)
 5b4:	fd07869b          	addw	a3,a5,-48
 5b8:	0ff6f693          	zext.b	a3,a3
 5bc:	fed872e3          	bgeu	a6,a3,5a0 <strtol+0x74>
        else if (*s >= 'a' && *s <= 'z')
 5c0:	f9f7869b          	addw	a3,a5,-97
 5c4:	0ff6f693          	zext.b	a3,a3
 5c8:	00d8e563          	bltu	a7,a3,5d2 <strtol+0xa6>
            dig = *s - 'a' + 10;
 5cc:	fa97879b          	addw	a5,a5,-87
 5d0:	bfd1                	j	5a4 <strtol+0x78>
        else if (*s >= 'A' && *s <= 'Z')
 5d2:	fbf7869b          	addw	a3,a5,-65
 5d6:	0ff6f693          	zext.b	a3,a3
 5da:	00d8e563          	bltu	a7,a3,5e4 <strtol+0xb8>
            dig = *s - 'A' + 10;
 5de:	fc97879b          	addw	a5,a5,-55
 5e2:	b7c9                	j	5a4 <strtol+0x78>
        // we don't properly detect overflow!
    }

    if (endptr)
 5e4:	c191                	beqz	a1,5e8 <strtol+0xbc>
        *endptr = (char *) s;
 5e6:	e198                	sd	a4,0(a1)
    return (neg ? -val : val);
 5e8:	00030463          	beqz	t1,5f0 <strtol+0xc4>
 5ec:	40a00533          	neg	a0,a0
}
 5f0:	6422                	ld	s0,8(sp)
 5f2:	0141                	add	sp,sp,16
 5f4:	8082                	ret

00000000000005f6 <inet_pton>:
inet_pton (int family, const char *p, void *n) {
    char *sp, *ep;
    int idx;
    long ret;

    if (family != AF_INET) {
 5f6:	4785                	li	a5,1
 5f8:	08f51063          	bne	a0,a5,678 <inet_pton+0x82>
inet_pton (int family, const char *p, void *n) {
 5fc:	715d                	add	sp,sp,-80
 5fe:	e486                	sd	ra,72(sp)
 600:	e0a2                	sd	s0,64(sp)
 602:	fc26                	sd	s1,56(sp)
 604:	f84a                	sd	s2,48(sp)
 606:	f44e                	sd	s3,40(sp)
 608:	f052                	sd	s4,32(sp)
 60a:	ec56                	sd	s5,24(sp)
 60c:	e85a                	sd	s6,16(sp)
 60e:	0880                	add	s0,sp,80
 610:	84ae                	mv	s1,a1
 612:	89b2                	mv	s3,a2
 614:	4901                	li	s2,0
        return -1;
    }
    sp = (char *)p;
    for (idx = 0; idx < 4; idx++) {
        ret = strtol(sp, &ep, 10);
        if (ret < 0 || ret > 255) {
 616:	0ff00a13          	li	s4,255
            return -1;
        }
        if (ep == sp) {
            return -1;
        }
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 61a:	4a8d                	li	s5,3
 61c:	02e00b13          	li	s6,46
 620:	a805                	j	650 <inet_pton+0x5a>
 622:	0007c783          	lbu	a5,0(a5)
 626:	efb9                	bnez	a5,684 <inet_pton+0x8e>
            return -1;
        }
        ((uint8_t *)n)[idx] = ret;
 628:	00a981a3          	sb	a0,3(s3)
        sp = ep + 1;
    }
    return 0;
 62c:	4501                	li	a0,0
}
 62e:	60a6                	ld	ra,72(sp)
 630:	6406                	ld	s0,64(sp)
 632:	74e2                	ld	s1,56(sp)
 634:	7942                	ld	s2,48(sp)
 636:	79a2                	ld	s3,40(sp)
 638:	7a02                	ld	s4,32(sp)
 63a:	6ae2                	ld	s5,24(sp)
 63c:	6b42                	ld	s6,16(sp)
 63e:	6161                	add	sp,sp,80
 640:	8082                	ret
        ((uint8_t *)n)[idx] = ret;
 642:	01298733          	add	a4,s3,s2
 646:	00a70023          	sb	a0,0(a4)
        sp = ep + 1;
 64a:	00178493          	add	s1,a5,1
    for (idx = 0; idx < 4; idx++) {
 64e:	0905                	add	s2,s2,1
        ret = strtol(sp, &ep, 10);
 650:	4629                	li	a2,10
 652:	fb840593          	add	a1,s0,-72
 656:	8526                	mv	a0,s1
 658:	ed5ff0ef          	jal	52c <strtol>
        if (ret < 0 || ret > 255) {
 65c:	02aa6063          	bltu	s4,a0,67c <inet_pton+0x86>
        if (ep == sp) {
 660:	fb843783          	ld	a5,-72(s0)
 664:	00978e63          	beq	a5,s1,680 <inet_pton+0x8a>
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 668:	fb590de3          	beq	s2,s5,622 <inet_pton+0x2c>
 66c:	0007c703          	lbu	a4,0(a5)
 670:	fd6709e3          	beq	a4,s6,642 <inet_pton+0x4c>
            return -1;
 674:	557d                	li	a0,-1
 676:	bf65                	j	62e <inet_pton+0x38>
        return -1;
 678:	557d                	li	a0,-1
}
 67a:	8082                	ret
            return -1;
 67c:	557d                	li	a0,-1
 67e:	bf45                	j	62e <inet_pton+0x38>
            return -1;
 680:	557d                	li	a0,-1
 682:	b775                	j	62e <inet_pton+0x38>
            return -1;
 684:	557d                	li	a0,-1
 686:	b765                	j	62e <inet_pton+0x38>

0000000000000688 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 688:	4885                	li	a7,1
 ecall
 68a:	00000073          	ecall
 ret
 68e:	8082                	ret

0000000000000690 <exit>:
.global exit
exit:
 li a7, SYS_exit
 690:	4889                	li	a7,2
 ecall
 692:	00000073          	ecall
 ret
 696:	8082                	ret

0000000000000698 <wait>:
.global wait
wait:
 li a7, SYS_wait
 698:	488d                	li	a7,3
 ecall
 69a:	00000073          	ecall
 ret
 69e:	8082                	ret

00000000000006a0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 6a0:	4891                	li	a7,4
 ecall
 6a2:	00000073          	ecall
 ret
 6a6:	8082                	ret

00000000000006a8 <read>:
.global read
read:
 li a7, SYS_read
 6a8:	4895                	li	a7,5
 ecall
 6aa:	00000073          	ecall
 ret
 6ae:	8082                	ret

00000000000006b0 <write>:
.global write
write:
 li a7, SYS_write
 6b0:	48c1                	li	a7,16
 ecall
 6b2:	00000073          	ecall
 ret
 6b6:	8082                	ret

00000000000006b8 <close>:
.global close
close:
 li a7, SYS_close
 6b8:	48d5                	li	a7,21
 ecall
 6ba:	00000073          	ecall
 ret
 6be:	8082                	ret

00000000000006c0 <kill>:
.global kill
kill:
 li a7, SYS_kill
 6c0:	4899                	li	a7,6
 ecall
 6c2:	00000073          	ecall
 ret
 6c6:	8082                	ret

00000000000006c8 <exec>:
.global exec
exec:
 li a7, SYS_exec
 6c8:	489d                	li	a7,7
 ecall
 6ca:	00000073          	ecall
 ret
 6ce:	8082                	ret

00000000000006d0 <open>:
.global open
open:
 li a7, SYS_open
 6d0:	48bd                	li	a7,15
 ecall
 6d2:	00000073          	ecall
 ret
 6d6:	8082                	ret

00000000000006d8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 6d8:	48c5                	li	a7,17
 ecall
 6da:	00000073          	ecall
 ret
 6de:	8082                	ret

00000000000006e0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 6e0:	48c9                	li	a7,18
 ecall
 6e2:	00000073          	ecall
 ret
 6e6:	8082                	ret

00000000000006e8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 6e8:	48a1                	li	a7,8
 ecall
 6ea:	00000073          	ecall
 ret
 6ee:	8082                	ret

00000000000006f0 <link>:
.global link
link:
 li a7, SYS_link
 6f0:	48cd                	li	a7,19
 ecall
 6f2:	00000073          	ecall
 ret
 6f6:	8082                	ret

00000000000006f8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 6f8:	48d1                	li	a7,20
 ecall
 6fa:	00000073          	ecall
 ret
 6fe:	8082                	ret

0000000000000700 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 700:	48a5                	li	a7,9
 ecall
 702:	00000073          	ecall
 ret
 706:	8082                	ret

0000000000000708 <dup>:
.global dup
dup:
 li a7, SYS_dup
 708:	48a9                	li	a7,10
 ecall
 70a:	00000073          	ecall
 ret
 70e:	8082                	ret

0000000000000710 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 710:	48ad                	li	a7,11
 ecall
 712:	00000073          	ecall
 ret
 716:	8082                	ret

0000000000000718 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 718:	48b1                	li	a7,12
 ecall
 71a:	00000073          	ecall
 ret
 71e:	8082                	ret

0000000000000720 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 720:	48b5                	li	a7,13
 ecall
 722:	00000073          	ecall
 ret
 726:	8082                	ret

0000000000000728 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 728:	48b9                	li	a7,14
 ecall
 72a:	00000073          	ecall
 ret
 72e:	8082                	ret

0000000000000730 <socket>:
.global socket
socket:
 li a7, SYS_socket
 730:	48d9                	li	a7,22
 ecall
 732:	00000073          	ecall
 ret
 736:	8082                	ret

0000000000000738 <bind>:
.global bind
bind:
 li a7, SYS_bind
 738:	48dd                	li	a7,23
 ecall
 73a:	00000073          	ecall
 ret
 73e:	8082                	ret

0000000000000740 <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 740:	48e1                	li	a7,24
 ecall
 742:	00000073          	ecall
 ret
 746:	8082                	ret

0000000000000748 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 748:	48e5                	li	a7,25
 ecall
 74a:	00000073          	ecall
 ret
 74e:	8082                	ret

0000000000000750 <connect>:
.global connect
connect:
 li a7, SYS_connect
 750:	48e9                	li	a7,26
 ecall
 752:	00000073          	ecall
 ret
 756:	8082                	ret

0000000000000758 <listen>:
.global listen
listen:
 li a7, SYS_listen
 758:	48ed                	li	a7,27
 ecall
 75a:	00000073          	ecall
 ret
 75e:	8082                	ret

0000000000000760 <accept>:
.global accept
accept:
 li a7, SYS_accept
 760:	48f1                	li	a7,28
 ecall
 762:	00000073          	ecall
 ret
 766:	8082                	ret

0000000000000768 <recv>:
.global recv
recv:
 li a7, SYS_recv
 768:	48f5                	li	a7,29
 ecall
 76a:	00000073          	ecall
 ret
 76e:	8082                	ret

0000000000000770 <send>:
.global send
send:
 li a7, SYS_send
 770:	48f9                	li	a7,30
 ecall
 772:	00000073          	ecall
 ret
 776:	8082                	ret

0000000000000778 <ioctl>:
.global ioctl
ioctl:
 li a7, SYS_ioctl
 778:	48fd                	li	a7,31
 ecall
 77a:	00000073          	ecall
 ret
 77e:	8082                	ret

0000000000000780 <consolemode>:
.global consolemode
consolemode:
 li a7, SYS_consolemode
 780:	02000893          	li	a7,32
 ecall
 784:	00000073          	ecall
 ret
 788:	8082                	ret

000000000000078a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 78a:	1101                	add	sp,sp,-32
 78c:	ec06                	sd	ra,24(sp)
 78e:	e822                	sd	s0,16(sp)
 790:	1000                	add	s0,sp,32
 792:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 796:	4605                	li	a2,1
 798:	fef40593          	add	a1,s0,-17
 79c:	f15ff0ef          	jal	6b0 <write>
}
 7a0:	60e2                	ld	ra,24(sp)
 7a2:	6442                	ld	s0,16(sp)
 7a4:	6105                	add	sp,sp,32
 7a6:	8082                	ret

00000000000007a8 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 7a8:	715d                	add	sp,sp,-80
 7aa:	e486                	sd	ra,72(sp)
 7ac:	e0a2                	sd	s0,64(sp)
 7ae:	fc26                	sd	s1,56(sp)
 7b0:	0880                	add	s0,sp,80
 7b2:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 7b4:	c299                	beqz	a3,7ba <printint+0x12>
 7b6:	0805c963          	bltz	a1,848 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 7ba:	2581                	sext.w	a1,a1
  neg = 0;
 7bc:	4881                	li	a7,0
 7be:	fb840693          	add	a3,s0,-72
  }

  i = 0;
 7c2:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 7c4:	2601                	sext.w	a2,a2
 7c6:	00000517          	auipc	a0,0x0
 7ca:	61a50513          	add	a0,a0,1562 # de0 <digits>
 7ce:	883a                	mv	a6,a4
 7d0:	2705                	addw	a4,a4,1
 7d2:	02c5f7bb          	remuw	a5,a1,a2
 7d6:	1782                	sll	a5,a5,0x20
 7d8:	9381                	srl	a5,a5,0x20
 7da:	97aa                	add	a5,a5,a0
 7dc:	0007c783          	lbu	a5,0(a5)
 7e0:	00f68023          	sb	a5,0(a3) # ff0000 <base+0xfeeff0>
  }while((x /= base) != 0);
 7e4:	0005879b          	sext.w	a5,a1
 7e8:	02c5d5bb          	divuw	a1,a1,a2
 7ec:	0685                	add	a3,a3,1
 7ee:	fec7f0e3          	bgeu	a5,a2,7ce <printint+0x26>
  if(neg)
 7f2:	00088c63          	beqz	a7,80a <printint+0x62>
    buf[i++] = '-';
 7f6:	fd070793          	add	a5,a4,-48
 7fa:	00878733          	add	a4,a5,s0
 7fe:	02d00793          	li	a5,45
 802:	fef70423          	sb	a5,-24(a4)
 806:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 80a:	02e05a63          	blez	a4,83e <printint+0x96>
 80e:	f84a                	sd	s2,48(sp)
 810:	f44e                	sd	s3,40(sp)
 812:	fb840793          	add	a5,s0,-72
 816:	00e78933          	add	s2,a5,a4
 81a:	fff78993          	add	s3,a5,-1
 81e:	99ba                	add	s3,s3,a4
 820:	377d                	addw	a4,a4,-1
 822:	1702                	sll	a4,a4,0x20
 824:	9301                	srl	a4,a4,0x20
 826:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 82a:	fff94583          	lbu	a1,-1(s2)
 82e:	8526                	mv	a0,s1
 830:	f5bff0ef          	jal	78a <putc>
  while(--i >= 0)
 834:	197d                	add	s2,s2,-1
 836:	ff391ae3          	bne	s2,s3,82a <printint+0x82>
 83a:	7942                	ld	s2,48(sp)
 83c:	79a2                	ld	s3,40(sp)
}
 83e:	60a6                	ld	ra,72(sp)
 840:	6406                	ld	s0,64(sp)
 842:	74e2                	ld	s1,56(sp)
 844:	6161                	add	sp,sp,80
 846:	8082                	ret
    x = -xx;
 848:	40b005bb          	negw	a1,a1
    neg = 1;
 84c:	4885                	li	a7,1
    x = -xx;
 84e:	bf85                	j	7be <printint+0x16>

0000000000000850 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 850:	711d                	add	sp,sp,-96
 852:	ec86                	sd	ra,88(sp)
 854:	e8a2                	sd	s0,80(sp)
 856:	e0ca                	sd	s2,64(sp)
 858:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 85a:	0005c903          	lbu	s2,0(a1)
 85e:	26090863          	beqz	s2,ace <vprintf+0x27e>
 862:	e4a6                	sd	s1,72(sp)
 864:	fc4e                	sd	s3,56(sp)
 866:	f852                	sd	s4,48(sp)
 868:	f456                	sd	s5,40(sp)
 86a:	f05a                	sd	s6,32(sp)
 86c:	ec5e                	sd	s7,24(sp)
 86e:	e862                	sd	s8,16(sp)
 870:	e466                	sd	s9,8(sp)
 872:	8b2a                	mv	s6,a0
 874:	8a2e                	mv	s4,a1
 876:	8bb2                	mv	s7,a2
  state = 0;
 878:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 87a:	4481                	li	s1,0
 87c:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 87e:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 882:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 886:	06c00c93          	li	s9,108
 88a:	a005                	j	8aa <vprintf+0x5a>
        putc(fd, c0);
 88c:	85ca                	mv	a1,s2
 88e:	855a                	mv	a0,s6
 890:	efbff0ef          	jal	78a <putc>
 894:	a019                	j	89a <vprintf+0x4a>
    } else if(state == '%'){
 896:	03598263          	beq	s3,s5,8ba <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 89a:	2485                	addw	s1,s1,1
 89c:	8726                	mv	a4,s1
 89e:	009a07b3          	add	a5,s4,s1
 8a2:	0007c903          	lbu	s2,0(a5)
 8a6:	20090c63          	beqz	s2,abe <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 8aa:	0009079b          	sext.w	a5,s2
    if(state == 0){
 8ae:	fe0994e3          	bnez	s3,896 <vprintf+0x46>
      if(c0 == '%'){
 8b2:	fd579de3          	bne	a5,s5,88c <vprintf+0x3c>
        state = '%';
 8b6:	89be                	mv	s3,a5
 8b8:	b7cd                	j	89a <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 8ba:	00ea06b3          	add	a3,s4,a4
 8be:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 8c2:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 8c4:	c681                	beqz	a3,8cc <vprintf+0x7c>
 8c6:	9752                	add	a4,a4,s4
 8c8:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 8cc:	03878f63          	beq	a5,s8,90a <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 8d0:	05978963          	beq	a5,s9,922 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 8d4:	07500713          	li	a4,117
 8d8:	0ee78363          	beq	a5,a4,9be <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 8dc:	07800713          	li	a4,120
 8e0:	12e78563          	beq	a5,a4,a0a <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 8e4:	07000713          	li	a4,112
 8e8:	14e78a63          	beq	a5,a4,a3c <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 8ec:	07300713          	li	a4,115
 8f0:	18e78a63          	beq	a5,a4,a84 <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 8f4:	02500713          	li	a4,37
 8f8:	04e79563          	bne	a5,a4,942 <vprintf+0xf2>
        putc(fd, '%');
 8fc:	02500593          	li	a1,37
 900:	855a                	mv	a0,s6
 902:	e89ff0ef          	jal	78a <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 906:	4981                	li	s3,0
 908:	bf49                	j	89a <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 90a:	008b8913          	add	s2,s7,8
 90e:	4685                	li	a3,1
 910:	4629                	li	a2,10
 912:	000ba583          	lw	a1,0(s7)
 916:	855a                	mv	a0,s6
 918:	e91ff0ef          	jal	7a8 <printint>
 91c:	8bca                	mv	s7,s2
      state = 0;
 91e:	4981                	li	s3,0
 920:	bfad                	j	89a <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 922:	06400793          	li	a5,100
 926:	02f68963          	beq	a3,a5,958 <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 92a:	06c00793          	li	a5,108
 92e:	04f68263          	beq	a3,a5,972 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 932:	07500793          	li	a5,117
 936:	0af68063          	beq	a3,a5,9d6 <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 93a:	07800793          	li	a5,120
 93e:	0ef68263          	beq	a3,a5,a22 <vprintf+0x1d2>
        putc(fd, '%');
 942:	02500593          	li	a1,37
 946:	855a                	mv	a0,s6
 948:	e43ff0ef          	jal	78a <putc>
        putc(fd, c0);
 94c:	85ca                	mv	a1,s2
 94e:	855a                	mv	a0,s6
 950:	e3bff0ef          	jal	78a <putc>
      state = 0;
 954:	4981                	li	s3,0
 956:	b791                	j	89a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 958:	008b8913          	add	s2,s7,8
 95c:	4685                	li	a3,1
 95e:	4629                	li	a2,10
 960:	000bb583          	ld	a1,0(s7)
 964:	855a                	mv	a0,s6
 966:	e43ff0ef          	jal	7a8 <printint>
        i += 1;
 96a:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 96c:	8bca                	mv	s7,s2
      state = 0;
 96e:	4981                	li	s3,0
        i += 1;
 970:	b72d                	j	89a <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 972:	06400793          	li	a5,100
 976:	02f60763          	beq	a2,a5,9a4 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 97a:	07500793          	li	a5,117
 97e:	06f60963          	beq	a2,a5,9f0 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 982:	07800793          	li	a5,120
 986:	faf61ee3          	bne	a2,a5,942 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 98a:	008b8913          	add	s2,s7,8
 98e:	4681                	li	a3,0
 990:	4641                	li	a2,16
 992:	000bb583          	ld	a1,0(s7)
 996:	855a                	mv	a0,s6
 998:	e11ff0ef          	jal	7a8 <printint>
        i += 2;
 99c:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 99e:	8bca                	mv	s7,s2
      state = 0;
 9a0:	4981                	li	s3,0
        i += 2;
 9a2:	bde5                	j	89a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 9a4:	008b8913          	add	s2,s7,8
 9a8:	4685                	li	a3,1
 9aa:	4629                	li	a2,10
 9ac:	000bb583          	ld	a1,0(s7)
 9b0:	855a                	mv	a0,s6
 9b2:	df7ff0ef          	jal	7a8 <printint>
        i += 2;
 9b6:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 9b8:	8bca                	mv	s7,s2
      state = 0;
 9ba:	4981                	li	s3,0
        i += 2;
 9bc:	bdf9                	j	89a <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 9be:	008b8913          	add	s2,s7,8
 9c2:	4681                	li	a3,0
 9c4:	4629                	li	a2,10
 9c6:	000ba583          	lw	a1,0(s7)
 9ca:	855a                	mv	a0,s6
 9cc:	dddff0ef          	jal	7a8 <printint>
 9d0:	8bca                	mv	s7,s2
      state = 0;
 9d2:	4981                	li	s3,0
 9d4:	b5d9                	j	89a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9d6:	008b8913          	add	s2,s7,8
 9da:	4681                	li	a3,0
 9dc:	4629                	li	a2,10
 9de:	000bb583          	ld	a1,0(s7)
 9e2:	855a                	mv	a0,s6
 9e4:	dc5ff0ef          	jal	7a8 <printint>
        i += 1;
 9e8:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 9ea:	8bca                	mv	s7,s2
      state = 0;
 9ec:	4981                	li	s3,0
        i += 1;
 9ee:	b575                	j	89a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9f0:	008b8913          	add	s2,s7,8
 9f4:	4681                	li	a3,0
 9f6:	4629                	li	a2,10
 9f8:	000bb583          	ld	a1,0(s7)
 9fc:	855a                	mv	a0,s6
 9fe:	dabff0ef          	jal	7a8 <printint>
        i += 2;
 a02:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 a04:	8bca                	mv	s7,s2
      state = 0;
 a06:	4981                	li	s3,0
        i += 2;
 a08:	bd49                	j	89a <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 a0a:	008b8913          	add	s2,s7,8
 a0e:	4681                	li	a3,0
 a10:	4641                	li	a2,16
 a12:	000ba583          	lw	a1,0(s7)
 a16:	855a                	mv	a0,s6
 a18:	d91ff0ef          	jal	7a8 <printint>
 a1c:	8bca                	mv	s7,s2
      state = 0;
 a1e:	4981                	li	s3,0
 a20:	bdad                	j	89a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 a22:	008b8913          	add	s2,s7,8
 a26:	4681                	li	a3,0
 a28:	4641                	li	a2,16
 a2a:	000bb583          	ld	a1,0(s7)
 a2e:	855a                	mv	a0,s6
 a30:	d79ff0ef          	jal	7a8 <printint>
        i += 1;
 a34:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 a36:	8bca                	mv	s7,s2
      state = 0;
 a38:	4981                	li	s3,0
        i += 1;
 a3a:	b585                	j	89a <vprintf+0x4a>
 a3c:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 a3e:	008b8d13          	add	s10,s7,8
 a42:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 a46:	03000593          	li	a1,48
 a4a:	855a                	mv	a0,s6
 a4c:	d3fff0ef          	jal	78a <putc>
  putc(fd, 'x');
 a50:	07800593          	li	a1,120
 a54:	855a                	mv	a0,s6
 a56:	d35ff0ef          	jal	78a <putc>
 a5a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a5c:	00000b97          	auipc	s7,0x0
 a60:	384b8b93          	add	s7,s7,900 # de0 <digits>
 a64:	03c9d793          	srl	a5,s3,0x3c
 a68:	97de                	add	a5,a5,s7
 a6a:	0007c583          	lbu	a1,0(a5)
 a6e:	855a                	mv	a0,s6
 a70:	d1bff0ef          	jal	78a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a74:	0992                	sll	s3,s3,0x4
 a76:	397d                	addw	s2,s2,-1
 a78:	fe0916e3          	bnez	s2,a64 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 a7c:	8bea                	mv	s7,s10
      state = 0;
 a7e:	4981                	li	s3,0
 a80:	6d02                	ld	s10,0(sp)
 a82:	bd21                	j	89a <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 a84:	008b8993          	add	s3,s7,8
 a88:	000bb903          	ld	s2,0(s7)
 a8c:	00090f63          	beqz	s2,aaa <vprintf+0x25a>
        for(; *s; s++)
 a90:	00094583          	lbu	a1,0(s2)
 a94:	c195                	beqz	a1,ab8 <vprintf+0x268>
          putc(fd, *s);
 a96:	855a                	mv	a0,s6
 a98:	cf3ff0ef          	jal	78a <putc>
        for(; *s; s++)
 a9c:	0905                	add	s2,s2,1
 a9e:	00094583          	lbu	a1,0(s2)
 aa2:	f9f5                	bnez	a1,a96 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 aa4:	8bce                	mv	s7,s3
      state = 0;
 aa6:	4981                	li	s3,0
 aa8:	bbcd                	j	89a <vprintf+0x4a>
          s = "(null)";
 aaa:	00000917          	auipc	s2,0x0
 aae:	32e90913          	add	s2,s2,814 # dd8 <malloc+0x21a>
        for(; *s; s++)
 ab2:	02800593          	li	a1,40
 ab6:	b7c5                	j	a96 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 ab8:	8bce                	mv	s7,s3
      state = 0;
 aba:	4981                	li	s3,0
 abc:	bbf9                	j	89a <vprintf+0x4a>
 abe:	64a6                	ld	s1,72(sp)
 ac0:	79e2                	ld	s3,56(sp)
 ac2:	7a42                	ld	s4,48(sp)
 ac4:	7aa2                	ld	s5,40(sp)
 ac6:	7b02                	ld	s6,32(sp)
 ac8:	6be2                	ld	s7,24(sp)
 aca:	6c42                	ld	s8,16(sp)
 acc:	6ca2                	ld	s9,8(sp)
    }
  }
}
 ace:	60e6                	ld	ra,88(sp)
 ad0:	6446                	ld	s0,80(sp)
 ad2:	6906                	ld	s2,64(sp)
 ad4:	6125                	add	sp,sp,96
 ad6:	8082                	ret

0000000000000ad8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 ad8:	715d                	add	sp,sp,-80
 ada:	ec06                	sd	ra,24(sp)
 adc:	e822                	sd	s0,16(sp)
 ade:	1000                	add	s0,sp,32
 ae0:	e010                	sd	a2,0(s0)
 ae2:	e414                	sd	a3,8(s0)
 ae4:	e818                	sd	a4,16(s0)
 ae6:	ec1c                	sd	a5,24(s0)
 ae8:	03043023          	sd	a6,32(s0)
 aec:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 af0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 af4:	8622                	mv	a2,s0
 af6:	d5bff0ef          	jal	850 <vprintf>
}
 afa:	60e2                	ld	ra,24(sp)
 afc:	6442                	ld	s0,16(sp)
 afe:	6161                	add	sp,sp,80
 b00:	8082                	ret

0000000000000b02 <printf>:

void
printf(const char *fmt, ...)
{
 b02:	711d                	add	sp,sp,-96
 b04:	ec06                	sd	ra,24(sp)
 b06:	e822                	sd	s0,16(sp)
 b08:	1000                	add	s0,sp,32
 b0a:	e40c                	sd	a1,8(s0)
 b0c:	e810                	sd	a2,16(s0)
 b0e:	ec14                	sd	a3,24(s0)
 b10:	f018                	sd	a4,32(s0)
 b12:	f41c                	sd	a5,40(s0)
 b14:	03043823          	sd	a6,48(s0)
 b18:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b1c:	00840613          	add	a2,s0,8
 b20:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 b24:	85aa                	mv	a1,a0
 b26:	4505                	li	a0,1
 b28:	d29ff0ef          	jal	850 <vprintf>
}
 b2c:	60e2                	ld	ra,24(sp)
 b2e:	6442                	ld	s0,16(sp)
 b30:	6125                	add	sp,sp,96
 b32:	8082                	ret

0000000000000b34 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b34:	1141                	add	sp,sp,-16
 b36:	e422                	sd	s0,8(sp)
 b38:	0800                	add	s0,sp,16
  Header *bp, *p;

  if(ap == 0)
 b3a:	cd3d                	beqz	a0,bb8 <free+0x84>
    return;
  if((uint64)ap < 4096)
 b3c:	6785                	lui	a5,0x1
 b3e:	06f56d63          	bltu	a0,a5,bb8 <free+0x84>
    return;
  bp = (Header*)ap - 1;
 b42:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b46:	00000797          	auipc	a5,0x0
 b4a:	4c27b783          	ld	a5,1218(a5) # 1008 <freep>
 b4e:	a02d                	j	b78 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 b50:	4618                	lw	a4,8(a2)
 b52:	9f2d                	addw	a4,a4,a1
 b54:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 b58:	6398                	ld	a4,0(a5)
 b5a:	6310                	ld	a2,0(a4)
 b5c:	a83d                	j	b9a <free+0x66>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 b5e:	ff852703          	lw	a4,-8(a0)
 b62:	9f31                	addw	a4,a4,a2
 b64:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 b66:	ff053683          	ld	a3,-16(a0)
 b6a:	a091                	j	bae <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b6c:	6398                	ld	a4,0(a5)
 b6e:	00e7e463          	bltu	a5,a4,b76 <free+0x42>
 b72:	00e6ea63          	bltu	a3,a4,b86 <free+0x52>
{
 b76:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b78:	fed7fae3          	bgeu	a5,a3,b6c <free+0x38>
 b7c:	6398                	ld	a4,0(a5)
 b7e:	00e6e463          	bltu	a3,a4,b86 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b82:	fee7eae3          	bltu	a5,a4,b76 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 b86:	ff852583          	lw	a1,-8(a0)
 b8a:	6390                	ld	a2,0(a5)
 b8c:	02059813          	sll	a6,a1,0x20
 b90:	01c85713          	srl	a4,a6,0x1c
 b94:	9736                	add	a4,a4,a3
 b96:	fae60de3          	beq	a2,a4,b50 <free+0x1c>
    bp->s.ptr = p->s.ptr->s.ptr;
 b9a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 b9e:	4790                	lw	a2,8(a5)
 ba0:	02061593          	sll	a1,a2,0x20
 ba4:	01c5d713          	srl	a4,a1,0x1c
 ba8:	973e                	add	a4,a4,a5
 baa:	fae68ae3          	beq	a3,a4,b5e <free+0x2a>
    p->s.ptr = bp->s.ptr;
 bae:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 bb0:	00000717          	auipc	a4,0x0
 bb4:	44f73c23          	sd	a5,1112(a4) # 1008 <freep>
}
 bb8:	6422                	ld	s0,8(sp)
 bba:	0141                	add	sp,sp,16
 bbc:	8082                	ret

0000000000000bbe <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 bbe:	7139                	add	sp,sp,-64
 bc0:	fc06                	sd	ra,56(sp)
 bc2:	f822                	sd	s0,48(sp)
 bc4:	f426                	sd	s1,40(sp)
 bc6:	ec4e                	sd	s3,24(sp)
 bc8:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 bca:	02051493          	sll	s1,a0,0x20
 bce:	9081                	srl	s1,s1,0x20
 bd0:	04bd                	add	s1,s1,15
 bd2:	8091                	srl	s1,s1,0x4
 bd4:	0014899b          	addw	s3,s1,1
 bd8:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 bda:	00000517          	auipc	a0,0x0
 bde:	42e53503          	ld	a0,1070(a0) # 1008 <freep>
 be2:	c915                	beqz	a0,c16 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 be4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 be6:	4798                	lw	a4,8(a5)
 be8:	08977a63          	bgeu	a4,s1,c7c <malloc+0xbe>
 bec:	f04a                	sd	s2,32(sp)
 bee:	e852                	sd	s4,16(sp)
 bf0:	e456                	sd	s5,8(sp)
 bf2:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 bf4:	8a4e                	mv	s4,s3
 bf6:	0009871b          	sext.w	a4,s3
 bfa:	6685                	lui	a3,0x1
 bfc:	00d77363          	bgeu	a4,a3,c02 <malloc+0x44>
 c00:	6a05                	lui	s4,0x1
 c02:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 c06:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 c0a:	00000917          	auipc	s2,0x0
 c0e:	3fe90913          	add	s2,s2,1022 # 1008 <freep>
  if(p == (char*)-1)
 c12:	5afd                	li	s5,-1
 c14:	a081                	j	c54 <malloc+0x96>
 c16:	f04a                	sd	s2,32(sp)
 c18:	e852                	sd	s4,16(sp)
 c1a:	e456                	sd	s5,8(sp)
 c1c:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 c1e:	00000797          	auipc	a5,0x0
 c22:	3f278793          	add	a5,a5,1010 # 1010 <base>
 c26:	00000717          	auipc	a4,0x0
 c2a:	3ef73123          	sd	a5,994(a4) # 1008 <freep>
 c2e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 c30:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 c34:	b7c1                	j	bf4 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 c36:	6398                	ld	a4,0(a5)
 c38:	e118                	sd	a4,0(a0)
 c3a:	a8a9                	j	c94 <malloc+0xd6>
  hp->s.size = nu;
 c3c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 c40:	0541                	add	a0,a0,16
 c42:	ef3ff0ef          	jal	b34 <free>
  return freep;
 c46:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 c4a:	c12d                	beqz	a0,cac <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c4c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c4e:	4798                	lw	a4,8(a5)
 c50:	02977263          	bgeu	a4,s1,c74 <malloc+0xb6>
    if(p == freep)
 c54:	00093703          	ld	a4,0(s2)
 c58:	853e                	mv	a0,a5
 c5a:	fef719e3          	bne	a4,a5,c4c <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 c5e:	8552                	mv	a0,s4
 c60:	ab9ff0ef          	jal	718 <sbrk>
  if(p == (char*)-1)
 c64:	fd551ce3          	bne	a0,s5,c3c <malloc+0x7e>
        return 0;
 c68:	4501                	li	a0,0
 c6a:	7902                	ld	s2,32(sp)
 c6c:	6a42                	ld	s4,16(sp)
 c6e:	6aa2                	ld	s5,8(sp)
 c70:	6b02                	ld	s6,0(sp)
 c72:	a03d                	j	ca0 <malloc+0xe2>
 c74:	7902                	ld	s2,32(sp)
 c76:	6a42                	ld	s4,16(sp)
 c78:	6aa2                	ld	s5,8(sp)
 c7a:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 c7c:	fae48de3          	beq	s1,a4,c36 <malloc+0x78>
        p->s.size -= nunits;
 c80:	4137073b          	subw	a4,a4,s3
 c84:	c798                	sw	a4,8(a5)
        p += p->s.size;
 c86:	02071693          	sll	a3,a4,0x20
 c8a:	01c6d713          	srl	a4,a3,0x1c
 c8e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 c90:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 c94:	00000717          	auipc	a4,0x0
 c98:	36a73a23          	sd	a0,884(a4) # 1008 <freep>
      return (void*)(p + 1);
 c9c:	01078513          	add	a0,a5,16
  }
}
 ca0:	70e2                	ld	ra,56(sp)
 ca2:	7442                	ld	s0,48(sp)
 ca4:	74a2                	ld	s1,40(sp)
 ca6:	69e2                	ld	s3,24(sp)
 ca8:	6121                	add	sp,sp,64
 caa:	8082                	ret
 cac:	7902                	ld	s2,32(sp)
 cae:	6a42                	ld	s4,16(sp)
 cb0:	6aa2                	ld	s5,8(sp)
 cb2:	6b02                	ld	s6,0(sp)
 cb4:	b7f5                	j	ca0 <malloc+0xe2>
