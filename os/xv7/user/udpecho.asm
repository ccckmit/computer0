
user/_udpecho:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "user/user.h"
#include "kernel/net/socket.h"

int
main (int argc, char *argv[])
{
   0:	7135                	add	sp,sp,-160
   2:	ed06                	sd	ra,152(sp)
   4:	e922                	sd	s0,144(sp)
   6:	e526                	sd	s1,136(sp)
   8:	e14a                	sd	s2,128(sp)
   a:	fcce                	sd	s3,120(sp)
   c:	f8d2                	sd	s4,112(sp)
   e:	f4d6                	sd	s5,104(sp)
  10:	f0da                	sd	s6,96(sp)
  12:	ecde                	sd	s7,88(sp)
  14:	e8e2                	sd	s8,80(sp)
  16:	e4e6                	sd	s9,72(sp)
  18:	e0ea                	sd	s10,64(sp)
  1a:	1100                	add	s0,sp,160
  1c:	81010113          	add	sp,sp,-2032
    int soc, peerlen, ret;
    struct sockaddr_in self, peer;
    unsigned char *addr;
    char buf[2048];

    printf("Starting UDP Echo Server\n");
  20:	00001517          	auipc	a0,0x1
  24:	ca050513          	add	a0,a0,-864 # cc0 <malloc+0xfc>
  28:	2e1000ef          	jal	b08 <printf>
    soc = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP);
  2c:	4601                	li	a2,0
  2e:	4585                	li	a1,1
  30:	4505                	li	a0,1
  32:	704000ef          	jal	736 <socket>
    if (soc == -1) {
  36:	57fd                	li	a5,-1
  38:	08f50f63          	beq	a0,a5,d6 <main+0xd6>
  3c:	892a                	mv	s2,a0
        printf("socket: failure\n");
        exit(1);
    }
    printf("socket: success, soc=%d\n", soc);
  3e:	85aa                	mv	a1,a0
  40:	00001517          	auipc	a0,0x1
  44:	cb850513          	add	a0,a0,-840 # cf8 <malloc+0x134>
  48:	2c1000ef          	jal	b08 <printf>
    self.sin_family = AF_INET;
  4c:	4785                	li	a5,1
  4e:	f8f41823          	sh	a5,-112(s0)
    self.sin_addr.s_addr = INADDR_ANY;
  52:	f8042a23          	sw	zero,-108(s0)
    self.sin_port = htons(7);
  56:	451d                	li	a0,7
  58:	3ba000ef          	jal	412 <htons>
  5c:	f8a41923          	sh	a0,-110(s0)
    if (bind(soc, (struct sockaddr *)&self, sizeof(self)) == -1) {
  60:	4621                	li	a2,8
  62:	f9040593          	add	a1,s0,-112
  66:	854a                	mv	a0,s2
  68:	6d6000ef          	jal	73e <bind>
  6c:	57fd                	li	a5,-1
  6e:	06f50d63          	beq	a0,a5,e8 <main+0xe8>
        printf("bind: failure\n");
        close(soc);
        exit(1);
    }
    addr = (unsigned char *)&self.sin_addr.s_addr;
    printf("bind: success, self=%d.%d.%d.%d:%d\n",
  72:	f9444483          	lbu	s1,-108(s0)
  76:	f9544983          	lbu	s3,-107(s0)
  7a:	f9644a03          	lbu	s4,-106(s0)
  7e:	f9744a83          	lbu	s5,-105(s0)
        addr[0], addr[1], addr[2], addr[3], ntohs(self.sin_port));
  82:	f9245503          	lhu	a0,-110(s0)
  86:	3c8000ef          	jal	44e <ntohs>
    printf("bind: success, self=%d.%d.%d.%d:%d\n",
  8a:	0005079b          	sext.w	a5,a0
  8e:	8756                	mv	a4,s5
  90:	86d2                	mv	a3,s4
  92:	864e                	mv	a2,s3
  94:	85a6                	mv	a1,s1
  96:	00001517          	auipc	a0,0x1
  9a:	c9250513          	add	a0,a0,-878 # d28 <malloc+0x164>
  9e:	26b000ef          	jal	b08 <printf>
    printf("waiting for message...\n");
  a2:	00001517          	auipc	a0,0x1
  a6:	cae50513          	add	a0,a0,-850 # d50 <malloc+0x18c>
  aa:	25f000ef          	jal	b08 <printf>
    while (1) {
        peerlen = sizeof(peer);
  ae:	4c21                	li	s8,8
        ret = recvfrom(soc, buf, sizeof(buf), (struct sockaddr *)&peer, &peerlen);
  b0:	77fd                	lui	a5,0xfffff
  b2:	78878793          	add	a5,a5,1928 # fffffffffffff788 <base+0xffffffffffffe778>
  b6:	97a2                	add	a5,a5,s0
  b8:	777d                	lui	a4,0xfffff
  ba:	77870713          	add	a4,a4,1912 # fffffffffffff778 <base+0xffffffffffffe768>
  be:	9722                	add	a4,a4,s0
  c0:	e31c                	sd	a5,0(a4)
  c2:	6b85                	lui	s7,0x1
  c4:	800b8b93          	add	s7,s7,-2048 # 800 <printint+0x52>
        if (ret <= 0) {
            printf("EOF\n");
            break;
        }
        if (ret == 2 && buf[0] == '.' && buf[1] == '\n') {
  c8:	4c89                	li	s9,2
  ca:	7d7d                	lui	s10,0xfffff
  cc:	fa0d0793          	add	a5,s10,-96 # ffffffffffffefa0 <base+0xffffffffffffdf90>
  d0:	00878d33          	add	s10,a5,s0
  d4:	a841                	j	164 <main+0x164>
        printf("socket: failure\n");
  d6:	00001517          	auipc	a0,0x1
  da:	c0a50513          	add	a0,a0,-1014 # ce0 <malloc+0x11c>
  de:	22b000ef          	jal	b08 <printf>
        exit(1);
  e2:	4505                	li	a0,1
  e4:	5b2000ef          	jal	696 <exit>
        printf("bind: failure\n");
  e8:	00001517          	auipc	a0,0x1
  ec:	c3050513          	add	a0,a0,-976 # d18 <malloc+0x154>
  f0:	219000ef          	jal	b08 <printf>
        close(soc);
  f4:	854a                	mv	a0,s2
  f6:	5c8000ef          	jal	6be <close>
        exit(1);
  fa:	4505                	li	a0,1
  fc:	59a000ef          	jal	696 <exit>
            printf("EOF\n");
 100:	00001517          	auipc	a0,0x1
 104:	c6850513          	add	a0,a0,-920 # d68 <malloc+0x1a4>
 108:	201000ef          	jal	b08 <printf>
        addr = (unsigned char *)&peer.sin_addr.s_addr;
        printf("recvfrom: %d bytes data received, peer=%d.%d.%d.%d:%d\n",
            ret, addr[0], addr[1], addr[2], addr[3], ntohs(peer.sin_port));
        sendto(soc, buf, ret, (struct sockaddr *)&peer, peerlen);
    }
    close(soc);  
 10c:	854a                	mv	a0,s2
 10e:	5b0000ef          	jal	6be <close>
    exit(0);
 112:	4501                	li	a0,0
 114:	582000ef          	jal	696 <exit>
        printf("recvfrom: %d bytes data received, peer=%d.%d.%d.%d:%d\n",
 118:	f8c44983          	lbu	s3,-116(s0)
 11c:	f8d44a03          	lbu	s4,-115(s0)
 120:	f8e44a83          	lbu	s5,-114(s0)
 124:	f8f44b03          	lbu	s6,-113(s0)
            ret, addr[0], addr[1], addr[2], addr[3], ntohs(peer.sin_port));
 128:	f8a45503          	lhu	a0,-118(s0)
 12c:	322000ef          	jal	44e <ntohs>
        printf("recvfrom: %d bytes data received, peer=%d.%d.%d.%d:%d\n",
 130:	0005081b          	sext.w	a6,a0
 134:	87da                	mv	a5,s6
 136:	8756                	mv	a4,s5
 138:	86d2                	mv	a3,s4
 13a:	864e                	mv	a2,s3
 13c:	85a6                	mv	a1,s1
 13e:	00001517          	auipc	a0,0x1
 142:	c3a50513          	add	a0,a0,-966 # d78 <malloc+0x1b4>
 146:	1c3000ef          	jal	b08 <printf>
        sendto(soc, buf, ret, (struct sockaddr *)&peer, peerlen);
 14a:	f9c42703          	lw	a4,-100(s0)
 14e:	f8840693          	add	a3,s0,-120
 152:	8626                	mv	a2,s1
 154:	77fd                	lui	a5,0xfffff
 156:	77878793          	add	a5,a5,1912 # fffffffffffff778 <base+0xffffffffffffe768>
 15a:	97a2                	add	a5,a5,s0
 15c:	638c                	ld	a1,0(a5)
 15e:	854a                	mv	a0,s2
 160:	5ee000ef          	jal	74e <sendto>
        peerlen = sizeof(peer);
 164:	f9842e23          	sw	s8,-100(s0)
        ret = recvfrom(soc, buf, sizeof(buf), (struct sockaddr *)&peer, &peerlen);
 168:	f9c40713          	add	a4,s0,-100
 16c:	f8840693          	add	a3,s0,-120
 170:	865e                	mv	a2,s7
 172:	77fd                	lui	a5,0xfffff
 174:	77878793          	add	a5,a5,1912 # fffffffffffff778 <base+0xffffffffffffe768>
 178:	97a2                	add	a5,a5,s0
 17a:	638c                	ld	a1,0(a5)
 17c:	854a                	mv	a0,s2
 17e:	5c8000ef          	jal	746 <recvfrom>
 182:	84aa                	mv	s1,a0
        if (ret <= 0) {
 184:	f6a05ee3          	blez	a0,100 <main+0x100>
        if (ret == 2 && buf[0] == '.' && buf[1] == '\n') {
 188:	f99518e3          	bne	a0,s9,118 <main+0x118>
 18c:	7e8d4703          	lbu	a4,2024(s10)
 190:	02e00793          	li	a5,46
 194:	f8f712e3          	bne	a4,a5,118 <main+0x118>
 198:	7e9d4703          	lbu	a4,2025(s10)
 19c:	47a9                	li	a5,10
 19e:	f6f71de3          	bne	a4,a5,118 <main+0x118>
            printf("quit\n");
 1a2:	00001517          	auipc	a0,0x1
 1a6:	bce50513          	add	a0,a0,-1074 # d70 <malloc+0x1ac>
 1aa:	15f000ef          	jal	b08 <printf>
            break;  
 1ae:	bfb9                	j	10c <main+0x10c>

00000000000001b0 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 1b0:	1141                	add	sp,sp,-16
 1b2:	e406                	sd	ra,8(sp)
 1b4:	e022                	sd	s0,0(sp)
 1b6:	0800                	add	s0,sp,16
  extern int main();
  main();
 1b8:	e49ff0ef          	jal	0 <main>
  exit(0);
 1bc:	4501                	li	a0,0
 1be:	4d8000ef          	jal	696 <exit>

00000000000001c2 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 1c2:	1141                	add	sp,sp,-16
 1c4:	e422                	sd	s0,8(sp)
 1c6:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1c8:	87aa                	mv	a5,a0
 1ca:	0585                	add	a1,a1,1
 1cc:	0785                	add	a5,a5,1
 1ce:	fff5c703          	lbu	a4,-1(a1)
 1d2:	fee78fa3          	sb	a4,-1(a5)
 1d6:	fb75                	bnez	a4,1ca <strcpy+0x8>
    ;
  return os;
}
 1d8:	6422                	ld	s0,8(sp)
 1da:	0141                	add	sp,sp,16
 1dc:	8082                	ret

00000000000001de <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1de:	1141                	add	sp,sp,-16
 1e0:	e422                	sd	s0,8(sp)
 1e2:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 1e4:	00054783          	lbu	a5,0(a0)
 1e8:	cb91                	beqz	a5,1fc <strcmp+0x1e>
 1ea:	0005c703          	lbu	a4,0(a1)
 1ee:	00f71763          	bne	a4,a5,1fc <strcmp+0x1e>
    p++, q++;
 1f2:	0505                	add	a0,a0,1
 1f4:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 1f6:	00054783          	lbu	a5,0(a0)
 1fa:	fbe5                	bnez	a5,1ea <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1fc:	0005c503          	lbu	a0,0(a1)
}
 200:	40a7853b          	subw	a0,a5,a0
 204:	6422                	ld	s0,8(sp)
 206:	0141                	add	sp,sp,16
 208:	8082                	ret

000000000000020a <strlen>:

uint
strlen(const char *s)
{
 20a:	1141                	add	sp,sp,-16
 20c:	e422                	sd	s0,8(sp)
 20e:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 210:	00054783          	lbu	a5,0(a0)
 214:	cf91                	beqz	a5,230 <strlen+0x26>
 216:	0505                	add	a0,a0,1
 218:	87aa                	mv	a5,a0
 21a:	86be                	mv	a3,a5
 21c:	0785                	add	a5,a5,1
 21e:	fff7c703          	lbu	a4,-1(a5)
 222:	ff65                	bnez	a4,21a <strlen+0x10>
 224:	40a6853b          	subw	a0,a3,a0
 228:	2505                	addw	a0,a0,1
    ;
  return n;
}
 22a:	6422                	ld	s0,8(sp)
 22c:	0141                	add	sp,sp,16
 22e:	8082                	ret
  for(n = 0; s[n]; n++)
 230:	4501                	li	a0,0
 232:	bfe5                	j	22a <strlen+0x20>

0000000000000234 <memset>:

void*
memset(void *dst, int c, uint n)
{
 234:	1141                	add	sp,sp,-16
 236:	e422                	sd	s0,8(sp)
 238:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 23a:	ca19                	beqz	a2,250 <memset+0x1c>
 23c:	87aa                	mv	a5,a0
 23e:	1602                	sll	a2,a2,0x20
 240:	9201                	srl	a2,a2,0x20
 242:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 246:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 24a:	0785                	add	a5,a5,1
 24c:	fee79de3          	bne	a5,a4,246 <memset+0x12>
  }
  return dst;
}
 250:	6422                	ld	s0,8(sp)
 252:	0141                	add	sp,sp,16
 254:	8082                	ret

0000000000000256 <strchr>:

char*
strchr(const char *s, char c)
{
 256:	1141                	add	sp,sp,-16
 258:	e422                	sd	s0,8(sp)
 25a:	0800                	add	s0,sp,16
  for(; *s; s++)
 25c:	00054783          	lbu	a5,0(a0)
 260:	cb99                	beqz	a5,276 <strchr+0x20>
    if(*s == c)
 262:	00f58763          	beq	a1,a5,270 <strchr+0x1a>
  for(; *s; s++)
 266:	0505                	add	a0,a0,1
 268:	00054783          	lbu	a5,0(a0)
 26c:	fbfd                	bnez	a5,262 <strchr+0xc>
      return (char*)s;
  return 0;
 26e:	4501                	li	a0,0
}
 270:	6422                	ld	s0,8(sp)
 272:	0141                	add	sp,sp,16
 274:	8082                	ret
  return 0;
 276:	4501                	li	a0,0
 278:	bfe5                	j	270 <strchr+0x1a>

000000000000027a <gets>:

char*
gets(char *buf, int max)
{
 27a:	711d                	add	sp,sp,-96
 27c:	ec86                	sd	ra,88(sp)
 27e:	e8a2                	sd	s0,80(sp)
 280:	e4a6                	sd	s1,72(sp)
 282:	e0ca                	sd	s2,64(sp)
 284:	fc4e                	sd	s3,56(sp)
 286:	f852                	sd	s4,48(sp)
 288:	f456                	sd	s5,40(sp)
 28a:	f05a                	sd	s6,32(sp)
 28c:	ec5e                	sd	s7,24(sp)
 28e:	1080                	add	s0,sp,96
 290:	8baa                	mv	s7,a0
 292:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 294:	892a                	mv	s2,a0
 296:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 298:	4aa9                	li	s5,10
 29a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 29c:	89a6                	mv	s3,s1
 29e:	2485                	addw	s1,s1,1
 2a0:	0344d663          	bge	s1,s4,2cc <gets+0x52>
    cc = read(0, &c, 1);
 2a4:	4605                	li	a2,1
 2a6:	faf40593          	add	a1,s0,-81
 2aa:	4501                	li	a0,0
 2ac:	402000ef          	jal	6ae <read>
    if(cc < 1)
 2b0:	00a05e63          	blez	a0,2cc <gets+0x52>
    buf[i++] = c;
 2b4:	faf44783          	lbu	a5,-81(s0)
 2b8:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2bc:	01578763          	beq	a5,s5,2ca <gets+0x50>
 2c0:	0905                	add	s2,s2,1
 2c2:	fd679de3          	bne	a5,s6,29c <gets+0x22>
    buf[i++] = c;
 2c6:	89a6                	mv	s3,s1
 2c8:	a011                	j	2cc <gets+0x52>
 2ca:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2cc:	99de                	add	s3,s3,s7
 2ce:	00098023          	sb	zero,0(s3)
  return buf;
}
 2d2:	855e                	mv	a0,s7
 2d4:	60e6                	ld	ra,88(sp)
 2d6:	6446                	ld	s0,80(sp)
 2d8:	64a6                	ld	s1,72(sp)
 2da:	6906                	ld	s2,64(sp)
 2dc:	79e2                	ld	s3,56(sp)
 2de:	7a42                	ld	s4,48(sp)
 2e0:	7aa2                	ld	s5,40(sp)
 2e2:	7b02                	ld	s6,32(sp)
 2e4:	6be2                	ld	s7,24(sp)
 2e6:	6125                	add	sp,sp,96
 2e8:	8082                	ret

00000000000002ea <stat>:

int
stat(const char *n, struct stat *st)
{
 2ea:	1101                	add	sp,sp,-32
 2ec:	ec06                	sd	ra,24(sp)
 2ee:	e822                	sd	s0,16(sp)
 2f0:	e04a                	sd	s2,0(sp)
 2f2:	1000                	add	s0,sp,32
 2f4:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2f6:	4581                	li	a1,0
 2f8:	3de000ef          	jal	6d6 <open>
  if(fd < 0)
 2fc:	02054263          	bltz	a0,320 <stat+0x36>
 300:	e426                	sd	s1,8(sp)
 302:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 304:	85ca                	mv	a1,s2
 306:	3e8000ef          	jal	6ee <fstat>
 30a:	892a                	mv	s2,a0
  close(fd);
 30c:	8526                	mv	a0,s1
 30e:	3b0000ef          	jal	6be <close>
  return r;
 312:	64a2                	ld	s1,8(sp)
}
 314:	854a                	mv	a0,s2
 316:	60e2                	ld	ra,24(sp)
 318:	6442                	ld	s0,16(sp)
 31a:	6902                	ld	s2,0(sp)
 31c:	6105                	add	sp,sp,32
 31e:	8082                	ret
    return -1;
 320:	597d                	li	s2,-1
 322:	bfcd                	j	314 <stat+0x2a>

0000000000000324 <atoi>:

int
atoi(const char *s)
{
 324:	1141                	add	sp,sp,-16
 326:	e422                	sd	s0,8(sp)
 328:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 32a:	00054683          	lbu	a3,0(a0)
 32e:	fd06879b          	addw	a5,a3,-48
 332:	0ff7f793          	zext.b	a5,a5
 336:	4625                	li	a2,9
 338:	02f66863          	bltu	a2,a5,368 <atoi+0x44>
 33c:	872a                	mv	a4,a0
  n = 0;
 33e:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 340:	0705                	add	a4,a4,1
 342:	0025179b          	sllw	a5,a0,0x2
 346:	9fa9                	addw	a5,a5,a0
 348:	0017979b          	sllw	a5,a5,0x1
 34c:	9fb5                	addw	a5,a5,a3
 34e:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 352:	00074683          	lbu	a3,0(a4)
 356:	fd06879b          	addw	a5,a3,-48
 35a:	0ff7f793          	zext.b	a5,a5
 35e:	fef671e3          	bgeu	a2,a5,340 <atoi+0x1c>
  return n;
}
 362:	6422                	ld	s0,8(sp)
 364:	0141                	add	sp,sp,16
 366:	8082                	ret
  n = 0;
 368:	4501                	li	a0,0
 36a:	bfe5                	j	362 <atoi+0x3e>

000000000000036c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 36c:	1141                	add	sp,sp,-16
 36e:	e422                	sd	s0,8(sp)
 370:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 372:	02b57463          	bgeu	a0,a1,39a <memmove+0x2e>
    while(n-- > 0)
 376:	00c05f63          	blez	a2,394 <memmove+0x28>
 37a:	1602                	sll	a2,a2,0x20
 37c:	9201                	srl	a2,a2,0x20
 37e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 382:	872a                	mv	a4,a0
      *dst++ = *src++;
 384:	0585                	add	a1,a1,1
 386:	0705                	add	a4,a4,1
 388:	fff5c683          	lbu	a3,-1(a1)
 38c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 390:	fef71ae3          	bne	a4,a5,384 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 394:	6422                	ld	s0,8(sp)
 396:	0141                	add	sp,sp,16
 398:	8082                	ret
    dst += n;
 39a:	00c50733          	add	a4,a0,a2
    src += n;
 39e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3a0:	fec05ae3          	blez	a2,394 <memmove+0x28>
 3a4:	fff6079b          	addw	a5,a2,-1
 3a8:	1782                	sll	a5,a5,0x20
 3aa:	9381                	srl	a5,a5,0x20
 3ac:	fff7c793          	not	a5,a5
 3b0:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3b2:	15fd                	add	a1,a1,-1
 3b4:	177d                	add	a4,a4,-1
 3b6:	0005c683          	lbu	a3,0(a1)
 3ba:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3be:	fee79ae3          	bne	a5,a4,3b2 <memmove+0x46>
 3c2:	bfc9                	j	394 <memmove+0x28>

00000000000003c4 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3c4:	1141                	add	sp,sp,-16
 3c6:	e422                	sd	s0,8(sp)
 3c8:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3ca:	ca05                	beqz	a2,3fa <memcmp+0x36>
 3cc:	fff6069b          	addw	a3,a2,-1
 3d0:	1682                	sll	a3,a3,0x20
 3d2:	9281                	srl	a3,a3,0x20
 3d4:	0685                	add	a3,a3,1
 3d6:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3d8:	00054783          	lbu	a5,0(a0)
 3dc:	0005c703          	lbu	a4,0(a1)
 3e0:	00e79863          	bne	a5,a4,3f0 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 3e4:	0505                	add	a0,a0,1
    p2++;
 3e6:	0585                	add	a1,a1,1
  while (n-- > 0) {
 3e8:	fed518e3          	bne	a0,a3,3d8 <memcmp+0x14>
  }
  return 0;
 3ec:	4501                	li	a0,0
 3ee:	a019                	j	3f4 <memcmp+0x30>
      return *p1 - *p2;
 3f0:	40e7853b          	subw	a0,a5,a4
}
 3f4:	6422                	ld	s0,8(sp)
 3f6:	0141                	add	sp,sp,16
 3f8:	8082                	ret
  return 0;
 3fa:	4501                	li	a0,0
 3fc:	bfe5                	j	3f4 <memcmp+0x30>

00000000000003fe <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3fe:	1141                	add	sp,sp,-16
 400:	e406                	sd	ra,8(sp)
 402:	e022                	sd	s0,0(sp)
 404:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 406:	f67ff0ef          	jal	36c <memmove>
}
 40a:	60a2                	ld	ra,8(sp)
 40c:	6402                	ld	s0,0(sp)
 40e:	0141                	add	sp,sp,16
 410:	8082                	ret

0000000000000412 <htons>:
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
}

uint16_t
htons(uint16_t h)
{
 412:	1141                	add	sp,sp,-16
 414:	e422                	sd	s0,8(sp)
 416:	0800                	add	s0,sp,16
    if (!endian) {
 418:	00001797          	auipc	a5,0x1
 41c:	be87a783          	lw	a5,-1048(a5) # 1000 <endian>
 420:	e385                	bnez	a5,440 <htons+0x2e>
        endian = byteorder();
 422:	4d200793          	li	a5,1234
 426:	00001717          	auipc	a4,0x1
 42a:	bcf72d23          	sw	a5,-1062(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 42e:	0085179b          	sllw	a5,a0,0x8
 432:	0085551b          	srlw	a0,a0,0x8
 436:	8fc9                	or	a5,a5,a0
 438:	03079513          	sll	a0,a5,0x30
 43c:	9141                	srl	a0,a0,0x30
 43e:	a029                	j	448 <htons+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(h) : h;
 440:	4d200713          	li	a4,1234
 444:	fee785e3          	beq	a5,a4,42e <htons+0x1c>
}
 448:	6422                	ld	s0,8(sp)
 44a:	0141                	add	sp,sp,16
 44c:	8082                	ret

000000000000044e <ntohs>:

uint16_t
ntohs(uint16_t n)
{
 44e:	1141                	add	sp,sp,-16
 450:	e422                	sd	s0,8(sp)
 452:	0800                	add	s0,sp,16
    if (!endian) {
 454:	00001797          	auipc	a5,0x1
 458:	bac7a783          	lw	a5,-1108(a5) # 1000 <endian>
 45c:	e385                	bnez	a5,47c <ntohs+0x2e>
        endian = byteorder();
 45e:	4d200793          	li	a5,1234
 462:	00001717          	auipc	a4,0x1
 466:	b8f72f23          	sw	a5,-1122(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 46a:	0085179b          	sllw	a5,a0,0x8
 46e:	0085551b          	srlw	a0,a0,0x8
 472:	8fc9                	or	a5,a5,a0
 474:	03079513          	sll	a0,a5,0x30
 478:	9141                	srl	a0,a0,0x30
 47a:	a029                	j	484 <ntohs+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(n) : n;
 47c:	4d200713          	li	a4,1234
 480:	fee785e3          	beq	a5,a4,46a <ntohs+0x1c>
}
 484:	6422                	ld	s0,8(sp)
 486:	0141                	add	sp,sp,16
 488:	8082                	ret

000000000000048a <htonl>:

uint32_t
htonl(uint32_t h)
{
 48a:	1141                	add	sp,sp,-16
 48c:	e422                	sd	s0,8(sp)
 48e:	0800                	add	s0,sp,16
    if (!endian) {
 490:	00001797          	auipc	a5,0x1
 494:	b707a783          	lw	a5,-1168(a5) # 1000 <endian>
 498:	ef85                	bnez	a5,4d0 <htonl+0x46>
        endian = byteorder();
 49a:	4d200793          	li	a5,1234
 49e:	00001717          	auipc	a4,0x1
 4a2:	b6f72123          	sw	a5,-1182(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 4a6:	0185179b          	sllw	a5,a0,0x18
 4aa:	0185571b          	srlw	a4,a0,0x18
 4ae:	8fd9                	or	a5,a5,a4
 4b0:	0085171b          	sllw	a4,a0,0x8
 4b4:	00ff06b7          	lui	a3,0xff0
 4b8:	8f75                	and	a4,a4,a3
 4ba:	8fd9                	or	a5,a5,a4
 4bc:	0085551b          	srlw	a0,a0,0x8
 4c0:	6741                	lui	a4,0x10
 4c2:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeef0>
 4c6:	8d79                	and	a0,a0,a4
 4c8:	8fc9                	or	a5,a5,a0
 4ca:	0007851b          	sext.w	a0,a5
 4ce:	a029                	j	4d8 <htonl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(h) : h;
 4d0:	4d200713          	li	a4,1234
 4d4:	fce789e3          	beq	a5,a4,4a6 <htonl+0x1c>
}
 4d8:	6422                	ld	s0,8(sp)
 4da:	0141                	add	sp,sp,16
 4dc:	8082                	ret

00000000000004de <ntohl>:

uint32_t
ntohl(uint32_t n)
{
 4de:	1141                	add	sp,sp,-16
 4e0:	e422                	sd	s0,8(sp)
 4e2:	0800                	add	s0,sp,16
    if (!endian) {
 4e4:	00001797          	auipc	a5,0x1
 4e8:	b1c7a783          	lw	a5,-1252(a5) # 1000 <endian>
 4ec:	ef85                	bnez	a5,524 <ntohl+0x46>
        endian = byteorder();
 4ee:	4d200793          	li	a5,1234
 4f2:	00001717          	auipc	a4,0x1
 4f6:	b0f72723          	sw	a5,-1266(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 4fa:	0185179b          	sllw	a5,a0,0x18
 4fe:	0185571b          	srlw	a4,a0,0x18
 502:	8fd9                	or	a5,a5,a4
 504:	0085171b          	sllw	a4,a0,0x8
 508:	00ff06b7          	lui	a3,0xff0
 50c:	8f75                	and	a4,a4,a3
 50e:	8fd9                	or	a5,a5,a4
 510:	0085551b          	srlw	a0,a0,0x8
 514:	6741                	lui	a4,0x10
 516:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeef0>
 51a:	8d79                	and	a0,a0,a4
 51c:	8fc9                	or	a5,a5,a0
 51e:	0007851b          	sext.w	a0,a5
 522:	a029                	j	52c <ntohl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(n) : n;
 524:	4d200713          	li	a4,1234
 528:	fce789e3          	beq	a5,a4,4fa <ntohl+0x1c>
}
 52c:	6422                	ld	s0,8(sp)
 52e:	0141                	add	sp,sp,16
 530:	8082                	ret

0000000000000532 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
 532:	1141                	add	sp,sp,-16
 534:	e422                	sd	s0,8(sp)
 536:	0800                	add	s0,sp,16
 538:	872a                	mv	a4,a0
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
 53a:	02000693          	li	a3,32
 53e:	4525                	li	a0,9
 540:	a011                	j	544 <strtol+0x12>
        s++;
 542:	0705                	add	a4,a4,1
    while (*s == ' ' || *s == '\t')
 544:	00074783          	lbu	a5,0(a4)
 548:	fed78de3          	beq	a5,a3,542 <strtol+0x10>
 54c:	fea78be3          	beq	a5,a0,542 <strtol+0x10>

    // plus/minus sign
    if (*s == '+')
 550:	02b00693          	li	a3,43
 554:	02d78663          	beq	a5,a3,580 <strtol+0x4e>
        s++;
    else if (*s == '-')
 558:	02d00693          	li	a3,45
    int neg = 0;
 55c:	4301                	li	t1,0
    else if (*s == '-')
 55e:	02d78463          	beq	a5,a3,586 <strtol+0x54>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 562:	fef67793          	and	a5,a2,-17
 566:	eb89                	bnez	a5,578 <strtol+0x46>
 568:	00074683          	lbu	a3,0(a4)
 56c:	03000793          	li	a5,48
 570:	00f68e63          	beq	a3,a5,58c <strtol+0x5a>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
 574:	e211                	bnez	a2,578 <strtol+0x46>
        s++, base = 8;
    else if (base == 0)
        base = 10;
 576:	4629                	li	a2,10
 578:	4501                	li	a0,0

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
 57a:	4825                	li	a6,9
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
 57c:	48e5                	li	a7,25
 57e:	a825                	j	5b6 <strtol+0x84>
        s++;
 580:	0705                	add	a4,a4,1
    int neg = 0;
 582:	4301                	li	t1,0
 584:	bff9                	j	562 <strtol+0x30>
        s++, neg = 1;
 586:	0705                	add	a4,a4,1
 588:	4305                	li	t1,1
 58a:	bfe1                	j	562 <strtol+0x30>
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 58c:	00174683          	lbu	a3,1(a4)
 590:	07800793          	li	a5,120
 594:	00f68663          	beq	a3,a5,5a0 <strtol+0x6e>
    else if (base == 0 && s[0] == '0')
 598:	f265                	bnez	a2,578 <strtol+0x46>
        s++, base = 8;
 59a:	0705                	add	a4,a4,1
 59c:	4621                	li	a2,8
 59e:	bfe9                	j	578 <strtol+0x46>
        s += 2, base = 16;
 5a0:	0709                	add	a4,a4,2
 5a2:	4641                	li	a2,16
 5a4:	bfd1                	j	578 <strtol+0x46>
            dig = *s - '0';
 5a6:	fd07879b          	addw	a5,a5,-48
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
 5aa:	04c7d063          	bge	a5,a2,5ea <strtol+0xb8>
            break;
        s++, val = (val * base) + dig;
 5ae:	0705                	add	a4,a4,1
 5b0:	02a60533          	mul	a0,a2,a0
 5b4:	953e                	add	a0,a0,a5
        if (*s >= '0' && *s <= '9')
 5b6:	00074783          	lbu	a5,0(a4)
 5ba:	fd07869b          	addw	a3,a5,-48
 5be:	0ff6f693          	zext.b	a3,a3
 5c2:	fed872e3          	bgeu	a6,a3,5a6 <strtol+0x74>
        else if (*s >= 'a' && *s <= 'z')
 5c6:	f9f7869b          	addw	a3,a5,-97
 5ca:	0ff6f693          	zext.b	a3,a3
 5ce:	00d8e563          	bltu	a7,a3,5d8 <strtol+0xa6>
            dig = *s - 'a' + 10;
 5d2:	fa97879b          	addw	a5,a5,-87
 5d6:	bfd1                	j	5aa <strtol+0x78>
        else if (*s >= 'A' && *s <= 'Z')
 5d8:	fbf7869b          	addw	a3,a5,-65
 5dc:	0ff6f693          	zext.b	a3,a3
 5e0:	00d8e563          	bltu	a7,a3,5ea <strtol+0xb8>
            dig = *s - 'A' + 10;
 5e4:	fc97879b          	addw	a5,a5,-55
 5e8:	b7c9                	j	5aa <strtol+0x78>
        // we don't properly detect overflow!
    }

    if (endptr)
 5ea:	c191                	beqz	a1,5ee <strtol+0xbc>
        *endptr = (char *) s;
 5ec:	e198                	sd	a4,0(a1)
    return (neg ? -val : val);
 5ee:	00030463          	beqz	t1,5f6 <strtol+0xc4>
 5f2:	40a00533          	neg	a0,a0
}
 5f6:	6422                	ld	s0,8(sp)
 5f8:	0141                	add	sp,sp,16
 5fa:	8082                	ret

00000000000005fc <inet_pton>:
inet_pton (int family, const char *p, void *n) {
    char *sp, *ep;
    int idx;
    long ret;

    if (family != AF_INET) {
 5fc:	4785                	li	a5,1
 5fe:	08f51063          	bne	a0,a5,67e <inet_pton+0x82>
inet_pton (int family, const char *p, void *n) {
 602:	715d                	add	sp,sp,-80
 604:	e486                	sd	ra,72(sp)
 606:	e0a2                	sd	s0,64(sp)
 608:	fc26                	sd	s1,56(sp)
 60a:	f84a                	sd	s2,48(sp)
 60c:	f44e                	sd	s3,40(sp)
 60e:	f052                	sd	s4,32(sp)
 610:	ec56                	sd	s5,24(sp)
 612:	e85a                	sd	s6,16(sp)
 614:	0880                	add	s0,sp,80
 616:	84ae                	mv	s1,a1
 618:	89b2                	mv	s3,a2
 61a:	4901                	li	s2,0
        return -1;
    }
    sp = (char *)p;
    for (idx = 0; idx < 4; idx++) {
        ret = strtol(sp, &ep, 10);
        if (ret < 0 || ret > 255) {
 61c:	0ff00a13          	li	s4,255
            return -1;
        }
        if (ep == sp) {
            return -1;
        }
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 620:	4a8d                	li	s5,3
 622:	02e00b13          	li	s6,46
 626:	a805                	j	656 <inet_pton+0x5a>
 628:	0007c783          	lbu	a5,0(a5)
 62c:	efb9                	bnez	a5,68a <inet_pton+0x8e>
            return -1;
        }
        ((uint8_t *)n)[idx] = ret;
 62e:	00a981a3          	sb	a0,3(s3)
        sp = ep + 1;
    }
    return 0;
 632:	4501                	li	a0,0
}
 634:	60a6                	ld	ra,72(sp)
 636:	6406                	ld	s0,64(sp)
 638:	74e2                	ld	s1,56(sp)
 63a:	7942                	ld	s2,48(sp)
 63c:	79a2                	ld	s3,40(sp)
 63e:	7a02                	ld	s4,32(sp)
 640:	6ae2                	ld	s5,24(sp)
 642:	6b42                	ld	s6,16(sp)
 644:	6161                	add	sp,sp,80
 646:	8082                	ret
        ((uint8_t *)n)[idx] = ret;
 648:	01298733          	add	a4,s3,s2
 64c:	00a70023          	sb	a0,0(a4)
        sp = ep + 1;
 650:	00178493          	add	s1,a5,1
    for (idx = 0; idx < 4; idx++) {
 654:	0905                	add	s2,s2,1
        ret = strtol(sp, &ep, 10);
 656:	4629                	li	a2,10
 658:	fb840593          	add	a1,s0,-72
 65c:	8526                	mv	a0,s1
 65e:	ed5ff0ef          	jal	532 <strtol>
        if (ret < 0 || ret > 255) {
 662:	02aa6063          	bltu	s4,a0,682 <inet_pton+0x86>
        if (ep == sp) {
 666:	fb843783          	ld	a5,-72(s0)
 66a:	00978e63          	beq	a5,s1,686 <inet_pton+0x8a>
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 66e:	fb590de3          	beq	s2,s5,628 <inet_pton+0x2c>
 672:	0007c703          	lbu	a4,0(a5)
 676:	fd6709e3          	beq	a4,s6,648 <inet_pton+0x4c>
            return -1;
 67a:	557d                	li	a0,-1
 67c:	bf65                	j	634 <inet_pton+0x38>
        return -1;
 67e:	557d                	li	a0,-1
}
 680:	8082                	ret
            return -1;
 682:	557d                	li	a0,-1
 684:	bf45                	j	634 <inet_pton+0x38>
            return -1;
 686:	557d                	li	a0,-1
 688:	b775                	j	634 <inet_pton+0x38>
            return -1;
 68a:	557d                	li	a0,-1
 68c:	b765                	j	634 <inet_pton+0x38>

000000000000068e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 68e:	4885                	li	a7,1
 ecall
 690:	00000073          	ecall
 ret
 694:	8082                	ret

0000000000000696 <exit>:
.global exit
exit:
 li a7, SYS_exit
 696:	4889                	li	a7,2
 ecall
 698:	00000073          	ecall
 ret
 69c:	8082                	ret

000000000000069e <wait>:
.global wait
wait:
 li a7, SYS_wait
 69e:	488d                	li	a7,3
 ecall
 6a0:	00000073          	ecall
 ret
 6a4:	8082                	ret

00000000000006a6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 6a6:	4891                	li	a7,4
 ecall
 6a8:	00000073          	ecall
 ret
 6ac:	8082                	ret

00000000000006ae <read>:
.global read
read:
 li a7, SYS_read
 6ae:	4895                	li	a7,5
 ecall
 6b0:	00000073          	ecall
 ret
 6b4:	8082                	ret

00000000000006b6 <write>:
.global write
write:
 li a7, SYS_write
 6b6:	48c1                	li	a7,16
 ecall
 6b8:	00000073          	ecall
 ret
 6bc:	8082                	ret

00000000000006be <close>:
.global close
close:
 li a7, SYS_close
 6be:	48d5                	li	a7,21
 ecall
 6c0:	00000073          	ecall
 ret
 6c4:	8082                	ret

00000000000006c6 <kill>:
.global kill
kill:
 li a7, SYS_kill
 6c6:	4899                	li	a7,6
 ecall
 6c8:	00000073          	ecall
 ret
 6cc:	8082                	ret

00000000000006ce <exec>:
.global exec
exec:
 li a7, SYS_exec
 6ce:	489d                	li	a7,7
 ecall
 6d0:	00000073          	ecall
 ret
 6d4:	8082                	ret

00000000000006d6 <open>:
.global open
open:
 li a7, SYS_open
 6d6:	48bd                	li	a7,15
 ecall
 6d8:	00000073          	ecall
 ret
 6dc:	8082                	ret

00000000000006de <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 6de:	48c5                	li	a7,17
 ecall
 6e0:	00000073          	ecall
 ret
 6e4:	8082                	ret

00000000000006e6 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 6e6:	48c9                	li	a7,18
 ecall
 6e8:	00000073          	ecall
 ret
 6ec:	8082                	ret

00000000000006ee <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 6ee:	48a1                	li	a7,8
 ecall
 6f0:	00000073          	ecall
 ret
 6f4:	8082                	ret

00000000000006f6 <link>:
.global link
link:
 li a7, SYS_link
 6f6:	48cd                	li	a7,19
 ecall
 6f8:	00000073          	ecall
 ret
 6fc:	8082                	ret

00000000000006fe <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 6fe:	48d1                	li	a7,20
 ecall
 700:	00000073          	ecall
 ret
 704:	8082                	ret

0000000000000706 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 706:	48a5                	li	a7,9
 ecall
 708:	00000073          	ecall
 ret
 70c:	8082                	ret

000000000000070e <dup>:
.global dup
dup:
 li a7, SYS_dup
 70e:	48a9                	li	a7,10
 ecall
 710:	00000073          	ecall
 ret
 714:	8082                	ret

0000000000000716 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 716:	48ad                	li	a7,11
 ecall
 718:	00000073          	ecall
 ret
 71c:	8082                	ret

000000000000071e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 71e:	48b1                	li	a7,12
 ecall
 720:	00000073          	ecall
 ret
 724:	8082                	ret

0000000000000726 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 726:	48b5                	li	a7,13
 ecall
 728:	00000073          	ecall
 ret
 72c:	8082                	ret

000000000000072e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 72e:	48b9                	li	a7,14
 ecall
 730:	00000073          	ecall
 ret
 734:	8082                	ret

0000000000000736 <socket>:
.global socket
socket:
 li a7, SYS_socket
 736:	48d9                	li	a7,22
 ecall
 738:	00000073          	ecall
 ret
 73c:	8082                	ret

000000000000073e <bind>:
.global bind
bind:
 li a7, SYS_bind
 73e:	48dd                	li	a7,23
 ecall
 740:	00000073          	ecall
 ret
 744:	8082                	ret

0000000000000746 <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 746:	48e1                	li	a7,24
 ecall
 748:	00000073          	ecall
 ret
 74c:	8082                	ret

000000000000074e <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 74e:	48e5                	li	a7,25
 ecall
 750:	00000073          	ecall
 ret
 754:	8082                	ret

0000000000000756 <connect>:
.global connect
connect:
 li a7, SYS_connect
 756:	48e9                	li	a7,26
 ecall
 758:	00000073          	ecall
 ret
 75c:	8082                	ret

000000000000075e <listen>:
.global listen
listen:
 li a7, SYS_listen
 75e:	48ed                	li	a7,27
 ecall
 760:	00000073          	ecall
 ret
 764:	8082                	ret

0000000000000766 <accept>:
.global accept
accept:
 li a7, SYS_accept
 766:	48f1                	li	a7,28
 ecall
 768:	00000073          	ecall
 ret
 76c:	8082                	ret

000000000000076e <recv>:
.global recv
recv:
 li a7, SYS_recv
 76e:	48f5                	li	a7,29
 ecall
 770:	00000073          	ecall
 ret
 774:	8082                	ret

0000000000000776 <send>:
.global send
send:
 li a7, SYS_send
 776:	48f9                	li	a7,30
 ecall
 778:	00000073          	ecall
 ret
 77c:	8082                	ret

000000000000077e <ioctl>:
.global ioctl
ioctl:
 li a7, SYS_ioctl
 77e:	48fd                	li	a7,31
 ecall
 780:	00000073          	ecall
 ret
 784:	8082                	ret

0000000000000786 <consolemode>:
.global consolemode
consolemode:
 li a7, SYS_consolemode
 786:	02000893          	li	a7,32
 ecall
 78a:	00000073          	ecall
 ret
 78e:	8082                	ret

0000000000000790 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 790:	1101                	add	sp,sp,-32
 792:	ec06                	sd	ra,24(sp)
 794:	e822                	sd	s0,16(sp)
 796:	1000                	add	s0,sp,32
 798:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 79c:	4605                	li	a2,1
 79e:	fef40593          	add	a1,s0,-17
 7a2:	f15ff0ef          	jal	6b6 <write>
}
 7a6:	60e2                	ld	ra,24(sp)
 7a8:	6442                	ld	s0,16(sp)
 7aa:	6105                	add	sp,sp,32
 7ac:	8082                	ret

00000000000007ae <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 7ae:	715d                	add	sp,sp,-80
 7b0:	e486                	sd	ra,72(sp)
 7b2:	e0a2                	sd	s0,64(sp)
 7b4:	fc26                	sd	s1,56(sp)
 7b6:	0880                	add	s0,sp,80
 7b8:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 7ba:	c299                	beqz	a3,7c0 <printint+0x12>
 7bc:	0805c963          	bltz	a1,84e <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 7c0:	2581                	sext.w	a1,a1
  neg = 0;
 7c2:	4881                	li	a7,0
 7c4:	fb840693          	add	a3,s0,-72
  }

  i = 0;
 7c8:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 7ca:	2601                	sext.w	a2,a2
 7cc:	00000517          	auipc	a0,0x0
 7d0:	5ec50513          	add	a0,a0,1516 # db8 <digits>
 7d4:	883a                	mv	a6,a4
 7d6:	2705                	addw	a4,a4,1
 7d8:	02c5f7bb          	remuw	a5,a1,a2
 7dc:	1782                	sll	a5,a5,0x20
 7de:	9381                	srl	a5,a5,0x20
 7e0:	97aa                	add	a5,a5,a0
 7e2:	0007c783          	lbu	a5,0(a5)
 7e6:	00f68023          	sb	a5,0(a3) # ff0000 <base+0xfeeff0>
  }while((x /= base) != 0);
 7ea:	0005879b          	sext.w	a5,a1
 7ee:	02c5d5bb          	divuw	a1,a1,a2
 7f2:	0685                	add	a3,a3,1
 7f4:	fec7f0e3          	bgeu	a5,a2,7d4 <printint+0x26>
  if(neg)
 7f8:	00088c63          	beqz	a7,810 <printint+0x62>
    buf[i++] = '-';
 7fc:	fd070793          	add	a5,a4,-48
 800:	00878733          	add	a4,a5,s0
 804:	02d00793          	li	a5,45
 808:	fef70423          	sb	a5,-24(a4)
 80c:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 810:	02e05a63          	blez	a4,844 <printint+0x96>
 814:	f84a                	sd	s2,48(sp)
 816:	f44e                	sd	s3,40(sp)
 818:	fb840793          	add	a5,s0,-72
 81c:	00e78933          	add	s2,a5,a4
 820:	fff78993          	add	s3,a5,-1
 824:	99ba                	add	s3,s3,a4
 826:	377d                	addw	a4,a4,-1
 828:	1702                	sll	a4,a4,0x20
 82a:	9301                	srl	a4,a4,0x20
 82c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 830:	fff94583          	lbu	a1,-1(s2)
 834:	8526                	mv	a0,s1
 836:	f5bff0ef          	jal	790 <putc>
  while(--i >= 0)
 83a:	197d                	add	s2,s2,-1
 83c:	ff391ae3          	bne	s2,s3,830 <printint+0x82>
 840:	7942                	ld	s2,48(sp)
 842:	79a2                	ld	s3,40(sp)
}
 844:	60a6                	ld	ra,72(sp)
 846:	6406                	ld	s0,64(sp)
 848:	74e2                	ld	s1,56(sp)
 84a:	6161                	add	sp,sp,80
 84c:	8082                	ret
    x = -xx;
 84e:	40b005bb          	negw	a1,a1
    neg = 1;
 852:	4885                	li	a7,1
    x = -xx;
 854:	bf85                	j	7c4 <printint+0x16>

0000000000000856 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 856:	711d                	add	sp,sp,-96
 858:	ec86                	sd	ra,88(sp)
 85a:	e8a2                	sd	s0,80(sp)
 85c:	e0ca                	sd	s2,64(sp)
 85e:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 860:	0005c903          	lbu	s2,0(a1)
 864:	26090863          	beqz	s2,ad4 <vprintf+0x27e>
 868:	e4a6                	sd	s1,72(sp)
 86a:	fc4e                	sd	s3,56(sp)
 86c:	f852                	sd	s4,48(sp)
 86e:	f456                	sd	s5,40(sp)
 870:	f05a                	sd	s6,32(sp)
 872:	ec5e                	sd	s7,24(sp)
 874:	e862                	sd	s8,16(sp)
 876:	e466                	sd	s9,8(sp)
 878:	8b2a                	mv	s6,a0
 87a:	8a2e                	mv	s4,a1
 87c:	8bb2                	mv	s7,a2
  state = 0;
 87e:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 880:	4481                	li	s1,0
 882:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 884:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 888:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 88c:	06c00c93          	li	s9,108
 890:	a005                	j	8b0 <vprintf+0x5a>
        putc(fd, c0);
 892:	85ca                	mv	a1,s2
 894:	855a                	mv	a0,s6
 896:	efbff0ef          	jal	790 <putc>
 89a:	a019                	j	8a0 <vprintf+0x4a>
    } else if(state == '%'){
 89c:	03598263          	beq	s3,s5,8c0 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 8a0:	2485                	addw	s1,s1,1
 8a2:	8726                	mv	a4,s1
 8a4:	009a07b3          	add	a5,s4,s1
 8a8:	0007c903          	lbu	s2,0(a5)
 8ac:	20090c63          	beqz	s2,ac4 <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 8b0:	0009079b          	sext.w	a5,s2
    if(state == 0){
 8b4:	fe0994e3          	bnez	s3,89c <vprintf+0x46>
      if(c0 == '%'){
 8b8:	fd579de3          	bne	a5,s5,892 <vprintf+0x3c>
        state = '%';
 8bc:	89be                	mv	s3,a5
 8be:	b7cd                	j	8a0 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 8c0:	00ea06b3          	add	a3,s4,a4
 8c4:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 8c8:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 8ca:	c681                	beqz	a3,8d2 <vprintf+0x7c>
 8cc:	9752                	add	a4,a4,s4
 8ce:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 8d2:	03878f63          	beq	a5,s8,910 <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 8d6:	05978963          	beq	a5,s9,928 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 8da:	07500713          	li	a4,117
 8de:	0ee78363          	beq	a5,a4,9c4 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 8e2:	07800713          	li	a4,120
 8e6:	12e78563          	beq	a5,a4,a10 <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 8ea:	07000713          	li	a4,112
 8ee:	14e78a63          	beq	a5,a4,a42 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 8f2:	07300713          	li	a4,115
 8f6:	18e78a63          	beq	a5,a4,a8a <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 8fa:	02500713          	li	a4,37
 8fe:	04e79563          	bne	a5,a4,948 <vprintf+0xf2>
        putc(fd, '%');
 902:	02500593          	li	a1,37
 906:	855a                	mv	a0,s6
 908:	e89ff0ef          	jal	790 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 90c:	4981                	li	s3,0
 90e:	bf49                	j	8a0 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 910:	008b8913          	add	s2,s7,8
 914:	4685                	li	a3,1
 916:	4629                	li	a2,10
 918:	000ba583          	lw	a1,0(s7)
 91c:	855a                	mv	a0,s6
 91e:	e91ff0ef          	jal	7ae <printint>
 922:	8bca                	mv	s7,s2
      state = 0;
 924:	4981                	li	s3,0
 926:	bfad                	j	8a0 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 928:	06400793          	li	a5,100
 92c:	02f68963          	beq	a3,a5,95e <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 930:	06c00793          	li	a5,108
 934:	04f68263          	beq	a3,a5,978 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 938:	07500793          	li	a5,117
 93c:	0af68063          	beq	a3,a5,9dc <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 940:	07800793          	li	a5,120
 944:	0ef68263          	beq	a3,a5,a28 <vprintf+0x1d2>
        putc(fd, '%');
 948:	02500593          	li	a1,37
 94c:	855a                	mv	a0,s6
 94e:	e43ff0ef          	jal	790 <putc>
        putc(fd, c0);
 952:	85ca                	mv	a1,s2
 954:	855a                	mv	a0,s6
 956:	e3bff0ef          	jal	790 <putc>
      state = 0;
 95a:	4981                	li	s3,0
 95c:	b791                	j	8a0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 95e:	008b8913          	add	s2,s7,8
 962:	4685                	li	a3,1
 964:	4629                	li	a2,10
 966:	000bb583          	ld	a1,0(s7)
 96a:	855a                	mv	a0,s6
 96c:	e43ff0ef          	jal	7ae <printint>
        i += 1;
 970:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 972:	8bca                	mv	s7,s2
      state = 0;
 974:	4981                	li	s3,0
        i += 1;
 976:	b72d                	j	8a0 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 978:	06400793          	li	a5,100
 97c:	02f60763          	beq	a2,a5,9aa <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 980:	07500793          	li	a5,117
 984:	06f60963          	beq	a2,a5,9f6 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 988:	07800793          	li	a5,120
 98c:	faf61ee3          	bne	a2,a5,948 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 990:	008b8913          	add	s2,s7,8
 994:	4681                	li	a3,0
 996:	4641                	li	a2,16
 998:	000bb583          	ld	a1,0(s7)
 99c:	855a                	mv	a0,s6
 99e:	e11ff0ef          	jal	7ae <printint>
        i += 2;
 9a2:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 9a4:	8bca                	mv	s7,s2
      state = 0;
 9a6:	4981                	li	s3,0
        i += 2;
 9a8:	bde5                	j	8a0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 9aa:	008b8913          	add	s2,s7,8
 9ae:	4685                	li	a3,1
 9b0:	4629                	li	a2,10
 9b2:	000bb583          	ld	a1,0(s7)
 9b6:	855a                	mv	a0,s6
 9b8:	df7ff0ef          	jal	7ae <printint>
        i += 2;
 9bc:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 9be:	8bca                	mv	s7,s2
      state = 0;
 9c0:	4981                	li	s3,0
        i += 2;
 9c2:	bdf9                	j	8a0 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 9c4:	008b8913          	add	s2,s7,8
 9c8:	4681                	li	a3,0
 9ca:	4629                	li	a2,10
 9cc:	000ba583          	lw	a1,0(s7)
 9d0:	855a                	mv	a0,s6
 9d2:	dddff0ef          	jal	7ae <printint>
 9d6:	8bca                	mv	s7,s2
      state = 0;
 9d8:	4981                	li	s3,0
 9da:	b5d9                	j	8a0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9dc:	008b8913          	add	s2,s7,8
 9e0:	4681                	li	a3,0
 9e2:	4629                	li	a2,10
 9e4:	000bb583          	ld	a1,0(s7)
 9e8:	855a                	mv	a0,s6
 9ea:	dc5ff0ef          	jal	7ae <printint>
        i += 1;
 9ee:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 9f0:	8bca                	mv	s7,s2
      state = 0;
 9f2:	4981                	li	s3,0
        i += 1;
 9f4:	b575                	j	8a0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9f6:	008b8913          	add	s2,s7,8
 9fa:	4681                	li	a3,0
 9fc:	4629                	li	a2,10
 9fe:	000bb583          	ld	a1,0(s7)
 a02:	855a                	mv	a0,s6
 a04:	dabff0ef          	jal	7ae <printint>
        i += 2;
 a08:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 a0a:	8bca                	mv	s7,s2
      state = 0;
 a0c:	4981                	li	s3,0
        i += 2;
 a0e:	bd49                	j	8a0 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 a10:	008b8913          	add	s2,s7,8
 a14:	4681                	li	a3,0
 a16:	4641                	li	a2,16
 a18:	000ba583          	lw	a1,0(s7)
 a1c:	855a                	mv	a0,s6
 a1e:	d91ff0ef          	jal	7ae <printint>
 a22:	8bca                	mv	s7,s2
      state = 0;
 a24:	4981                	li	s3,0
 a26:	bdad                	j	8a0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 a28:	008b8913          	add	s2,s7,8
 a2c:	4681                	li	a3,0
 a2e:	4641                	li	a2,16
 a30:	000bb583          	ld	a1,0(s7)
 a34:	855a                	mv	a0,s6
 a36:	d79ff0ef          	jal	7ae <printint>
        i += 1;
 a3a:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 a3c:	8bca                	mv	s7,s2
      state = 0;
 a3e:	4981                	li	s3,0
        i += 1;
 a40:	b585                	j	8a0 <vprintf+0x4a>
 a42:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 a44:	008b8d13          	add	s10,s7,8
 a48:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 a4c:	03000593          	li	a1,48
 a50:	855a                	mv	a0,s6
 a52:	d3fff0ef          	jal	790 <putc>
  putc(fd, 'x');
 a56:	07800593          	li	a1,120
 a5a:	855a                	mv	a0,s6
 a5c:	d35ff0ef          	jal	790 <putc>
 a60:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a62:	00000b97          	auipc	s7,0x0
 a66:	356b8b93          	add	s7,s7,854 # db8 <digits>
 a6a:	03c9d793          	srl	a5,s3,0x3c
 a6e:	97de                	add	a5,a5,s7
 a70:	0007c583          	lbu	a1,0(a5)
 a74:	855a                	mv	a0,s6
 a76:	d1bff0ef          	jal	790 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a7a:	0992                	sll	s3,s3,0x4
 a7c:	397d                	addw	s2,s2,-1
 a7e:	fe0916e3          	bnez	s2,a6a <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 a82:	8bea                	mv	s7,s10
      state = 0;
 a84:	4981                	li	s3,0
 a86:	6d02                	ld	s10,0(sp)
 a88:	bd21                	j	8a0 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 a8a:	008b8993          	add	s3,s7,8
 a8e:	000bb903          	ld	s2,0(s7)
 a92:	00090f63          	beqz	s2,ab0 <vprintf+0x25a>
        for(; *s; s++)
 a96:	00094583          	lbu	a1,0(s2)
 a9a:	c195                	beqz	a1,abe <vprintf+0x268>
          putc(fd, *s);
 a9c:	855a                	mv	a0,s6
 a9e:	cf3ff0ef          	jal	790 <putc>
        for(; *s; s++)
 aa2:	0905                	add	s2,s2,1
 aa4:	00094583          	lbu	a1,0(s2)
 aa8:	f9f5                	bnez	a1,a9c <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 aaa:	8bce                	mv	s7,s3
      state = 0;
 aac:	4981                	li	s3,0
 aae:	bbcd                	j	8a0 <vprintf+0x4a>
          s = "(null)";
 ab0:	00000917          	auipc	s2,0x0
 ab4:	30090913          	add	s2,s2,768 # db0 <malloc+0x1ec>
        for(; *s; s++)
 ab8:	02800593          	li	a1,40
 abc:	b7c5                	j	a9c <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 abe:	8bce                	mv	s7,s3
      state = 0;
 ac0:	4981                	li	s3,0
 ac2:	bbf9                	j	8a0 <vprintf+0x4a>
 ac4:	64a6                	ld	s1,72(sp)
 ac6:	79e2                	ld	s3,56(sp)
 ac8:	7a42                	ld	s4,48(sp)
 aca:	7aa2                	ld	s5,40(sp)
 acc:	7b02                	ld	s6,32(sp)
 ace:	6be2                	ld	s7,24(sp)
 ad0:	6c42                	ld	s8,16(sp)
 ad2:	6ca2                	ld	s9,8(sp)
    }
  }
}
 ad4:	60e6                	ld	ra,88(sp)
 ad6:	6446                	ld	s0,80(sp)
 ad8:	6906                	ld	s2,64(sp)
 ada:	6125                	add	sp,sp,96
 adc:	8082                	ret

0000000000000ade <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 ade:	715d                	add	sp,sp,-80
 ae0:	ec06                	sd	ra,24(sp)
 ae2:	e822                	sd	s0,16(sp)
 ae4:	1000                	add	s0,sp,32
 ae6:	e010                	sd	a2,0(s0)
 ae8:	e414                	sd	a3,8(s0)
 aea:	e818                	sd	a4,16(s0)
 aec:	ec1c                	sd	a5,24(s0)
 aee:	03043023          	sd	a6,32(s0)
 af2:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 af6:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 afa:	8622                	mv	a2,s0
 afc:	d5bff0ef          	jal	856 <vprintf>
}
 b00:	60e2                	ld	ra,24(sp)
 b02:	6442                	ld	s0,16(sp)
 b04:	6161                	add	sp,sp,80
 b06:	8082                	ret

0000000000000b08 <printf>:

void
printf(const char *fmt, ...)
{
 b08:	711d                	add	sp,sp,-96
 b0a:	ec06                	sd	ra,24(sp)
 b0c:	e822                	sd	s0,16(sp)
 b0e:	1000                	add	s0,sp,32
 b10:	e40c                	sd	a1,8(s0)
 b12:	e810                	sd	a2,16(s0)
 b14:	ec14                	sd	a3,24(s0)
 b16:	f018                	sd	a4,32(s0)
 b18:	f41c                	sd	a5,40(s0)
 b1a:	03043823          	sd	a6,48(s0)
 b1e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b22:	00840613          	add	a2,s0,8
 b26:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 b2a:	85aa                	mv	a1,a0
 b2c:	4505                	li	a0,1
 b2e:	d29ff0ef          	jal	856 <vprintf>
}
 b32:	60e2                	ld	ra,24(sp)
 b34:	6442                	ld	s0,16(sp)
 b36:	6125                	add	sp,sp,96
 b38:	8082                	ret

0000000000000b3a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b3a:	1141                	add	sp,sp,-16
 b3c:	e422                	sd	s0,8(sp)
 b3e:	0800                	add	s0,sp,16
  Header *bp, *p;

  if(ap == 0)
 b40:	cd3d                	beqz	a0,bbe <free+0x84>
    return;
  if((uint64)ap < 4096)
 b42:	6785                	lui	a5,0x1
 b44:	06f56d63          	bltu	a0,a5,bbe <free+0x84>
    return;
  bp = (Header*)ap - 1;
 b48:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b4c:	00000797          	auipc	a5,0x0
 b50:	4bc7b783          	ld	a5,1212(a5) # 1008 <freep>
 b54:	a02d                	j	b7e <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 b56:	4618                	lw	a4,8(a2)
 b58:	9f2d                	addw	a4,a4,a1
 b5a:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 b5e:	6398                	ld	a4,0(a5)
 b60:	6310                	ld	a2,0(a4)
 b62:	a83d                	j	ba0 <free+0x66>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 b64:	ff852703          	lw	a4,-8(a0)
 b68:	9f31                	addw	a4,a4,a2
 b6a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 b6c:	ff053683          	ld	a3,-16(a0)
 b70:	a091                	j	bb4 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b72:	6398                	ld	a4,0(a5)
 b74:	00e7e463          	bltu	a5,a4,b7c <free+0x42>
 b78:	00e6ea63          	bltu	a3,a4,b8c <free+0x52>
{
 b7c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b7e:	fed7fae3          	bgeu	a5,a3,b72 <free+0x38>
 b82:	6398                	ld	a4,0(a5)
 b84:	00e6e463          	bltu	a3,a4,b8c <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b88:	fee7eae3          	bltu	a5,a4,b7c <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 b8c:	ff852583          	lw	a1,-8(a0)
 b90:	6390                	ld	a2,0(a5)
 b92:	02059813          	sll	a6,a1,0x20
 b96:	01c85713          	srl	a4,a6,0x1c
 b9a:	9736                	add	a4,a4,a3
 b9c:	fae60de3          	beq	a2,a4,b56 <free+0x1c>
    bp->s.ptr = p->s.ptr->s.ptr;
 ba0:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 ba4:	4790                	lw	a2,8(a5)
 ba6:	02061593          	sll	a1,a2,0x20
 baa:	01c5d713          	srl	a4,a1,0x1c
 bae:	973e                	add	a4,a4,a5
 bb0:	fae68ae3          	beq	a3,a4,b64 <free+0x2a>
    p->s.ptr = bp->s.ptr;
 bb4:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 bb6:	00000717          	auipc	a4,0x0
 bba:	44f73923          	sd	a5,1106(a4) # 1008 <freep>
}
 bbe:	6422                	ld	s0,8(sp)
 bc0:	0141                	add	sp,sp,16
 bc2:	8082                	ret

0000000000000bc4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 bc4:	7139                	add	sp,sp,-64
 bc6:	fc06                	sd	ra,56(sp)
 bc8:	f822                	sd	s0,48(sp)
 bca:	f426                	sd	s1,40(sp)
 bcc:	ec4e                	sd	s3,24(sp)
 bce:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 bd0:	02051493          	sll	s1,a0,0x20
 bd4:	9081                	srl	s1,s1,0x20
 bd6:	04bd                	add	s1,s1,15
 bd8:	8091                	srl	s1,s1,0x4
 bda:	0014899b          	addw	s3,s1,1
 bde:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 be0:	00000517          	auipc	a0,0x0
 be4:	42853503          	ld	a0,1064(a0) # 1008 <freep>
 be8:	c915                	beqz	a0,c1c <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bea:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 bec:	4798                	lw	a4,8(a5)
 bee:	08977a63          	bgeu	a4,s1,c82 <malloc+0xbe>
 bf2:	f04a                	sd	s2,32(sp)
 bf4:	e852                	sd	s4,16(sp)
 bf6:	e456                	sd	s5,8(sp)
 bf8:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 bfa:	8a4e                	mv	s4,s3
 bfc:	0009871b          	sext.w	a4,s3
 c00:	6685                	lui	a3,0x1
 c02:	00d77363          	bgeu	a4,a3,c08 <malloc+0x44>
 c06:	6a05                	lui	s4,0x1
 c08:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 c0c:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 c10:	00000917          	auipc	s2,0x0
 c14:	3f890913          	add	s2,s2,1016 # 1008 <freep>
  if(p == (char*)-1)
 c18:	5afd                	li	s5,-1
 c1a:	a081                	j	c5a <malloc+0x96>
 c1c:	f04a                	sd	s2,32(sp)
 c1e:	e852                	sd	s4,16(sp)
 c20:	e456                	sd	s5,8(sp)
 c22:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 c24:	00000797          	auipc	a5,0x0
 c28:	3ec78793          	add	a5,a5,1004 # 1010 <base>
 c2c:	00000717          	auipc	a4,0x0
 c30:	3cf73e23          	sd	a5,988(a4) # 1008 <freep>
 c34:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 c36:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 c3a:	b7c1                	j	bfa <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 c3c:	6398                	ld	a4,0(a5)
 c3e:	e118                	sd	a4,0(a0)
 c40:	a8a9                	j	c9a <malloc+0xd6>
  hp->s.size = nu;
 c42:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 c46:	0541                	add	a0,a0,16
 c48:	ef3ff0ef          	jal	b3a <free>
  return freep;
 c4c:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 c50:	c12d                	beqz	a0,cb2 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c52:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c54:	4798                	lw	a4,8(a5)
 c56:	02977263          	bgeu	a4,s1,c7a <malloc+0xb6>
    if(p == freep)
 c5a:	00093703          	ld	a4,0(s2)
 c5e:	853e                	mv	a0,a5
 c60:	fef719e3          	bne	a4,a5,c52 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 c64:	8552                	mv	a0,s4
 c66:	ab9ff0ef          	jal	71e <sbrk>
  if(p == (char*)-1)
 c6a:	fd551ce3          	bne	a0,s5,c42 <malloc+0x7e>
        return 0;
 c6e:	4501                	li	a0,0
 c70:	7902                	ld	s2,32(sp)
 c72:	6a42                	ld	s4,16(sp)
 c74:	6aa2                	ld	s5,8(sp)
 c76:	6b02                	ld	s6,0(sp)
 c78:	a03d                	j	ca6 <malloc+0xe2>
 c7a:	7902                	ld	s2,32(sp)
 c7c:	6a42                	ld	s4,16(sp)
 c7e:	6aa2                	ld	s5,8(sp)
 c80:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 c82:	fae48de3          	beq	s1,a4,c3c <malloc+0x78>
        p->s.size -= nunits;
 c86:	4137073b          	subw	a4,a4,s3
 c8a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 c8c:	02071693          	sll	a3,a4,0x20
 c90:	01c6d713          	srl	a4,a3,0x1c
 c94:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 c96:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 c9a:	00000717          	auipc	a4,0x0
 c9e:	36a73723          	sd	a0,878(a4) # 1008 <freep>
      return (void*)(p + 1);
 ca2:	01078513          	add	a0,a5,16
  }
}
 ca6:	70e2                	ld	ra,56(sp)
 ca8:	7442                	ld	s0,48(sp)
 caa:	74a2                	ld	s1,40(sp)
 cac:	69e2                	ld	s3,24(sp)
 cae:	6121                	add	sp,sp,64
 cb0:	8082                	ret
 cb2:	7902                	ld	s2,32(sp)
 cb4:	6a42                	ld	s4,16(sp)
 cb6:	6aa2                	ld	s5,8(sp)
 cb8:	6b02                	ld	s6,0(sp)
 cba:	b7f5                	j	ca6 <malloc+0xe2>
