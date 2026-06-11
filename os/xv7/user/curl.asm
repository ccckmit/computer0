
user/_curl:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "user/user.h"
#include "kernel/net/socket.h"

int main(int argc, char *argv[])
{
   0:	714d                	add	sp,sp,-336
   2:	e686                	sd	ra,328(sp)
   4:	e2a2                	sd	s0,320(sp)
   6:	fe26                	sd	s1,312(sp)
   8:	fa4a                	sd	s2,304(sp)
   a:	f64e                	sd	s3,296(sp)
   c:	0a80                	add	s0,sp,336
   e:	72fd                	lui	t0,0xfffff
  10:	9116                	add	sp,sp,t0
    char buf[4096];
    char request[256];
    int i, port = 8080;
    char *host = "192.0.2.2";

    if (argc > 1) {
  12:	4785                	li	a5,1
  14:	00a7de63          	bge	a5,a0,30 <main+0x30>
        host = argv[1];
  18:	6584                	ld	s1,8(a1)
    }
    if (argc > 2) {
  1a:	4789                	li	a5,2
    int i, port = 8080;
  1c:	6989                	lui	s3,0x2
  1e:	f9098993          	add	s3,s3,-112 # 1f90 <base+0xf80>
    if (argc > 2) {
  22:	00a7de63          	bge	a5,a0,3e <main+0x3e>
        port = atoi(argv[2]);
  26:	6988                	ld	a0,16(a1)
  28:	3da000ef          	jal	402 <atoi>
  2c:	89aa                	mv	s3,a0
  2e:	a801                	j	3e <main+0x3e>
    char *host = "192.0.2.2";
  30:	00001497          	auipc	s1,0x1
  34:	d7048493          	add	s1,s1,-656 # da0 <malloc+0xfe>
    int i, port = 8080;
  38:	6989                	lui	s3,0x2
  3a:	f9098993          	add	s3,s3,-112 # 1f90 <base+0xf80>
    }

    printf("curl: connecting to %s:%d\n", host, port);
  3e:	864e                	mv	a2,s3
  40:	85a6                	mv	a1,s1
  42:	00001517          	auipc	a0,0x1
  46:	d6e50513          	add	a0,a0,-658 # db0 <malloc+0x10e>
  4a:	39d000ef          	jal	be6 <printf>

    soc = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
  4e:	4601                	li	a2,0
  50:	4589                	li	a1,2
  52:	4505                	li	a0,1
  54:	7c0000ef          	jal	814 <socket>
  58:	892a                	mv	s2,a0
    if (soc == -1) {
  5a:	57fd                	li	a5,-1
  5c:	1cf50a63          	beq	a0,a5,230 <main+0x230>
        printf("curl: socket failed\n");
        exit(1);
    }
    printf("curl: socket created\n");
  60:	00001517          	auipc	a0,0x1
  64:	d8850513          	add	a0,a0,-632 # de8 <malloc+0x146>
  68:	37f000ef          	jal	be6 <printf>

    server.sin_family = AF_INET;
  6c:	4785                	li	a5,1
  6e:	fcf41423          	sh	a5,-56(s0)
    server.sin_port = htons(port);
  72:	03099513          	sll	a0,s3,0x30
  76:	9141                	srl	a0,a0,0x30
  78:	478000ef          	jal	4f0 <htons>
  7c:	fca41523          	sh	a0,-54(s0)
    inet_pton(AF_INET, host, &server.sin_addr);
  80:	fcc40613          	add	a2,s0,-52
  84:	85a6                	mv	a1,s1
  86:	4505                	li	a0,1
  88:	652000ef          	jal	6da <inet_pton>

    printf("curl: calling connect...\n");
  8c:	00001517          	auipc	a0,0x1
  90:	d7450513          	add	a0,a0,-652 # e00 <malloc+0x15e>
  94:	353000ef          	jal	be6 <printf>
    if (connect(soc, (struct sockaddr *)&server, sizeof(server)) == -1) {
  98:	4621                	li	a2,8
  9a:	fc840593          	add	a1,s0,-56
  9e:	854a                	mv	a0,s2
  a0:	794000ef          	jal	834 <connect>
  a4:	57fd                	li	a5,-1
  a6:	18f50e63          	beq	a0,a5,242 <main+0x242>
        printf("curl: connect failed\n");
        close(soc);
        exit(1);
    }
    printf("curl: connected!\n");
  aa:	00001517          	auipc	a0,0x1
  ae:	d8e50513          	add	a0,a0,-626 # e38 <malloc+0x196>
  b2:	335000ef          	jal	be6 <printf>

    i = 0;
    request[i++] = 'G';
  b6:	77fd                	lui	a5,0xfffff
  b8:	fd078793          	add	a5,a5,-48 # ffffffffffffefd0 <base+0xffffffffffffdfc0>
  bc:	97a2                	add	a5,a5,s0
  be:	04700713          	li	a4,71
  c2:	eee78c23          	sb	a4,-264(a5)
    request[i++] = 'E';
  c6:	04500713          	li	a4,69
  ca:	eee78ca3          	sb	a4,-263(a5)
    request[i++] = 'T';
  ce:	05400693          	li	a3,84
  d2:	eed78d23          	sb	a3,-262(a5)
    request[i++] = ' ';
  d6:	02000713          	li	a4,32
  da:	eee78da3          	sb	a4,-261(a5)
    request[i++] = '/';
  de:	02f00593          	li	a1,47
  e2:	eeb78e23          	sb	a1,-260(a5)
    request[i++] = ' ';
  e6:	eee78ea3          	sb	a4,-259(a5)
    request[i++] = 'H';
  ea:	04800613          	li	a2,72
  ee:	eec78f23          	sb	a2,-258(a5)
    request[i++] = 'T';
  f2:	eed78fa3          	sb	a3,-257(a5)
    request[i++] = 'T';
  f6:	f0d78023          	sb	a3,-256(a5)
    request[i++] = 'P';
  fa:	05000693          	li	a3,80
  fe:	f0d780a3          	sb	a3,-255(a5)
    request[i++] = '/';
 102:	f0b78123          	sb	a1,-254(a5)
    request[i++] = '1';
 106:	03100693          	li	a3,49
 10a:	f0d781a3          	sb	a3,-253(a5)
    request[i++] = '.';
 10e:	02e00593          	li	a1,46
 112:	f0b78223          	sb	a1,-252(a5)
    request[i++] = '1';
 116:	f0d782a3          	sb	a3,-251(a5)
    request[i++] = '\r';
 11a:	46b5                	li	a3,13
 11c:	f0d78323          	sb	a3,-250(a5)
    request[i++] = '\n';
 120:	46a9                	li	a3,10
 122:	f0d783a3          	sb	a3,-249(a5)
    request[i++] = 'H';
 126:	f0c78423          	sb	a2,-248(a5)
    request[i++] = 'o';
 12a:	06f00693          	li	a3,111
 12e:	f0d784a3          	sb	a3,-247(a5)
    request[i++] = 's';
 132:	07300693          	li	a3,115
 136:	f0d78523          	sb	a3,-246(a5)
    request[i++] = 't';
 13a:	07400693          	li	a3,116
 13e:	f0d785a3          	sb	a3,-245(a5)
    request[i++] = ':';
 142:	03a00693          	li	a3,58
 146:	f0d78623          	sb	a3,-244(a5)
    request[i++] = ' ';
 14a:	f0e786a3          	sb	a4,-243(a5)
    {
        char *h = host;
        while (*h && i < 250) {
 14e:	0004c703          	lbu	a4,0(s1)
 152:	10070463          	beqz	a4,25a <main+0x25a>
 156:	47dd                	li	a5,23
            request[i++] = *h++;
 158:	76fd                	lui	a3,0xfffff
 15a:	ec868693          	add	a3,a3,-312 # ffffffffffffeec8 <base+0xffffffffffffdeb8>
 15e:	96a2                	add	a3,a3,s0
 160:	767d                	lui	a2,0xfffff
 162:	eb860613          	add	a2,a2,-328 # ffffffffffffeeb8 <base+0xffffffffffffdea8>
 166:	9622                	add	a2,a2,s0
 168:	e214                	sd	a3,0(a2)
        while (*h && i < 250) {
 16a:	0fb00593          	li	a1,251
            request[i++] = *h++;
 16e:	0007861b          	sext.w	a2,a5
 172:	76fd                	lui	a3,0xfffff
 174:	eb868693          	add	a3,a3,-328 # ffffffffffffeeb8 <base+0xffffffffffffdea8>
 178:	96a2                	add	a3,a3,s0
 17a:	6294                	ld	a3,0(a3)
 17c:	96be                	add	a3,a3,a5
 17e:	fee68fa3          	sb	a4,-1(a3)
        while (*h && i < 250) {
 182:	00f48733          	add	a4,s1,a5
 186:	fea74703          	lbu	a4,-22(a4)
 18a:	c701                	beqz	a4,192 <main+0x192>
 18c:	0785                	add	a5,a5,1
 18e:	feb790e3          	bne	a5,a1,16e <main+0x16e>
        }
    }
    request[i++] = '\r';
 192:	77fd                	lui	a5,0xfffff
 194:	fd078793          	add	a5,a5,-48 # ffffffffffffefd0 <base+0xffffffffffffdfc0>
 198:	97a2                	add	a5,a5,s0
 19a:	79fd                	lui	s3,0xfffff
 19c:	eb898713          	add	a4,s3,-328 # ffffffffffffeeb8 <base+0xffffffffffffdea8>
 1a0:	9722                	add	a4,a4,s0
 1a2:	e31c                	sd	a5,0(a4)
 1a4:	631c                	ld	a5,0(a4)
 1a6:	97b2                	add	a5,a5,a2
 1a8:	46b5                	li	a3,13
 1aa:	eed78c23          	sb	a3,-264(a5)
    request[i++] = '\n';
 1ae:	0016079b          	addw	a5,a2,1
 1b2:	eb898713          	add	a4,s3,-328
 1b6:	9722                	add	a4,a4,s0
 1b8:	6318                	ld	a4,0(a4)
 1ba:	97ba                	add	a5,a5,a4
 1bc:	4729                	li	a4,10
 1be:	eee78c23          	sb	a4,-264(a5)
    request[i++] = '\r';
 1c2:	0026079b          	addw	a5,a2,2
 1c6:	eb898593          	add	a1,s3,-328
 1ca:	95a2                	add	a1,a1,s0
 1cc:	618c                	ld	a1,0(a1)
 1ce:	97ae                	add	a5,a5,a1
 1d0:	eed78c23          	sb	a3,-264(a5)
    request[i++] = '\n';
 1d4:	0036079b          	addw	a5,a2,3
 1d8:	97ae                	add	a5,a5,a1
 1da:	eee78c23          	sb	a4,-264(a5)
    
    send(soc, request, i);
 1de:	75fd                	lui	a1,0xfffff
 1e0:	2611                	addw	a2,a2,4
 1e2:	ec858793          	add	a5,a1,-312 # ffffffffffffeec8 <base+0xffffffffffffdeb8>
 1e6:	008785b3          	add	a1,a5,s0
 1ea:	854a                	mv	a0,s2
 1ec:	668000ef          	jal	854 <send>
    printf("curl: request sent\n");
 1f0:	00001517          	auipc	a0,0x1
 1f4:	c6050513          	add	a0,a0,-928 # e50 <malloc+0x1ae>
 1f8:	1ef000ef          	jal	be6 <printf>

    int n = recv(soc, buf, sizeof(buf) - 1);
 1fc:	75fd                	lui	a1,0xfffff
 1fe:	6605                	lui	a2,0x1
 200:	167d                	add	a2,a2,-1 # fff <digits+0x167>
 202:	fc858793          	add	a5,a1,-56 # ffffffffffffefc8 <base+0xffffffffffffdfb8>
 206:	008785b3          	add	a1,a5,s0
 20a:	854a                	mv	a0,s2
 20c:	640000ef          	jal	84c <recv>
 210:	84aa                	mv	s1,a0
    printf("curl: received %d bytes\n", n);
 212:	85aa                	mv	a1,a0
 214:	00001517          	auipc	a0,0x1
 218:	c5450513          	add	a0,a0,-940 # e68 <malloc+0x1c6>
 21c:	1cb000ef          	jal	be6 <printf>
    if (n > 0) {
 220:	02904f63          	bgtz	s1,25e <main+0x25e>
        buf[n] = '\0';
        printf("%s\n", buf);
    }

    close(soc);
 224:	854a                	mv	a0,s2
 226:	576000ef          	jal	79c <close>
    exit(0);
 22a:	4501                	li	a0,0
 22c:	548000ef          	jal	774 <exit>
        printf("curl: socket failed\n");
 230:	00001517          	auipc	a0,0x1
 234:	ba050513          	add	a0,a0,-1120 # dd0 <malloc+0x12e>
 238:	1af000ef          	jal	be6 <printf>
        exit(1);
 23c:	4505                	li	a0,1
 23e:	536000ef          	jal	774 <exit>
        printf("curl: connect failed\n");
 242:	00001517          	auipc	a0,0x1
 246:	bde50513          	add	a0,a0,-1058 # e20 <malloc+0x17e>
 24a:	19d000ef          	jal	be6 <printf>
        close(soc);
 24e:	854a                	mv	a0,s2
 250:	54c000ef          	jal	79c <close>
        exit(1);
 254:	4505                	li	a0,1
 256:	51e000ef          	jal	774 <exit>
    request[i++] = ' ';
 25a:	4659                	li	a2,22
 25c:	bf1d                	j	192 <main+0x192>
        buf[n] = '\0';
 25e:	77fd                	lui	a5,0xfffff
 260:	fd078793          	add	a5,a5,-48 # ffffffffffffefd0 <base+0xffffffffffffdfc0>
 264:	97a2                	add	a5,a5,s0
 266:	eb898713          	add	a4,s3,-328
 26a:	9722                	add	a4,a4,s0
 26c:	e31c                	sd	a5,0(a4)
 26e:	631c                	ld	a5,0(a4)
 270:	97a6                	add	a5,a5,s1
 272:	fe078c23          	sb	zero,-8(a5)
        printf("%s\n", buf);
 276:	75fd                	lui	a1,0xfffff
 278:	fc858793          	add	a5,a1,-56 # ffffffffffffefc8 <base+0xffffffffffffdfb8>
 27c:	008785b3          	add	a1,a5,s0
 280:	00001517          	auipc	a0,0x1
 284:	c0850513          	add	a0,a0,-1016 # e88 <malloc+0x1e6>
 288:	15f000ef          	jal	be6 <printf>
 28c:	bf61                	j	224 <main+0x224>

000000000000028e <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 28e:	1141                	add	sp,sp,-16
 290:	e406                	sd	ra,8(sp)
 292:	e022                	sd	s0,0(sp)
 294:	0800                	add	s0,sp,16
  extern int main();
  main();
 296:	d6bff0ef          	jal	0 <main>
  exit(0);
 29a:	4501                	li	a0,0
 29c:	4d8000ef          	jal	774 <exit>

00000000000002a0 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 2a0:	1141                	add	sp,sp,-16
 2a2:	e422                	sd	s0,8(sp)
 2a4:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2a6:	87aa                	mv	a5,a0
 2a8:	0585                	add	a1,a1,1
 2aa:	0785                	add	a5,a5,1
 2ac:	fff5c703          	lbu	a4,-1(a1)
 2b0:	fee78fa3          	sb	a4,-1(a5)
 2b4:	fb75                	bnez	a4,2a8 <strcpy+0x8>
    ;
  return os;
}
 2b6:	6422                	ld	s0,8(sp)
 2b8:	0141                	add	sp,sp,16
 2ba:	8082                	ret

00000000000002bc <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2bc:	1141                	add	sp,sp,-16
 2be:	e422                	sd	s0,8(sp)
 2c0:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 2c2:	00054783          	lbu	a5,0(a0)
 2c6:	cb91                	beqz	a5,2da <strcmp+0x1e>
 2c8:	0005c703          	lbu	a4,0(a1)
 2cc:	00f71763          	bne	a4,a5,2da <strcmp+0x1e>
    p++, q++;
 2d0:	0505                	add	a0,a0,1
 2d2:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 2d4:	00054783          	lbu	a5,0(a0)
 2d8:	fbe5                	bnez	a5,2c8 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 2da:	0005c503          	lbu	a0,0(a1)
}
 2de:	40a7853b          	subw	a0,a5,a0
 2e2:	6422                	ld	s0,8(sp)
 2e4:	0141                	add	sp,sp,16
 2e6:	8082                	ret

00000000000002e8 <strlen>:

uint
strlen(const char *s)
{
 2e8:	1141                	add	sp,sp,-16
 2ea:	e422                	sd	s0,8(sp)
 2ec:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2ee:	00054783          	lbu	a5,0(a0)
 2f2:	cf91                	beqz	a5,30e <strlen+0x26>
 2f4:	0505                	add	a0,a0,1
 2f6:	87aa                	mv	a5,a0
 2f8:	86be                	mv	a3,a5
 2fa:	0785                	add	a5,a5,1
 2fc:	fff7c703          	lbu	a4,-1(a5)
 300:	ff65                	bnez	a4,2f8 <strlen+0x10>
 302:	40a6853b          	subw	a0,a3,a0
 306:	2505                	addw	a0,a0,1
    ;
  return n;
}
 308:	6422                	ld	s0,8(sp)
 30a:	0141                	add	sp,sp,16
 30c:	8082                	ret
  for(n = 0; s[n]; n++)
 30e:	4501                	li	a0,0
 310:	bfe5                	j	308 <strlen+0x20>

0000000000000312 <memset>:

void*
memset(void *dst, int c, uint n)
{
 312:	1141                	add	sp,sp,-16
 314:	e422                	sd	s0,8(sp)
 316:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 318:	ca19                	beqz	a2,32e <memset+0x1c>
 31a:	87aa                	mv	a5,a0
 31c:	1602                	sll	a2,a2,0x20
 31e:	9201                	srl	a2,a2,0x20
 320:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 324:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 328:	0785                	add	a5,a5,1
 32a:	fee79de3          	bne	a5,a4,324 <memset+0x12>
  }
  return dst;
}
 32e:	6422                	ld	s0,8(sp)
 330:	0141                	add	sp,sp,16
 332:	8082                	ret

0000000000000334 <strchr>:

char*
strchr(const char *s, char c)
{
 334:	1141                	add	sp,sp,-16
 336:	e422                	sd	s0,8(sp)
 338:	0800                	add	s0,sp,16
  for(; *s; s++)
 33a:	00054783          	lbu	a5,0(a0)
 33e:	cb99                	beqz	a5,354 <strchr+0x20>
    if(*s == c)
 340:	00f58763          	beq	a1,a5,34e <strchr+0x1a>
  for(; *s; s++)
 344:	0505                	add	a0,a0,1
 346:	00054783          	lbu	a5,0(a0)
 34a:	fbfd                	bnez	a5,340 <strchr+0xc>
      return (char*)s;
  return 0;
 34c:	4501                	li	a0,0
}
 34e:	6422                	ld	s0,8(sp)
 350:	0141                	add	sp,sp,16
 352:	8082                	ret
  return 0;
 354:	4501                	li	a0,0
 356:	bfe5                	j	34e <strchr+0x1a>

0000000000000358 <gets>:

char*
gets(char *buf, int max)
{
 358:	711d                	add	sp,sp,-96
 35a:	ec86                	sd	ra,88(sp)
 35c:	e8a2                	sd	s0,80(sp)
 35e:	e4a6                	sd	s1,72(sp)
 360:	e0ca                	sd	s2,64(sp)
 362:	fc4e                	sd	s3,56(sp)
 364:	f852                	sd	s4,48(sp)
 366:	f456                	sd	s5,40(sp)
 368:	f05a                	sd	s6,32(sp)
 36a:	ec5e                	sd	s7,24(sp)
 36c:	1080                	add	s0,sp,96
 36e:	8baa                	mv	s7,a0
 370:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 372:	892a                	mv	s2,a0
 374:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 376:	4aa9                	li	s5,10
 378:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 37a:	89a6                	mv	s3,s1
 37c:	2485                	addw	s1,s1,1
 37e:	0344d663          	bge	s1,s4,3aa <gets+0x52>
    cc = read(0, &c, 1);
 382:	4605                	li	a2,1
 384:	faf40593          	add	a1,s0,-81
 388:	4501                	li	a0,0
 38a:	402000ef          	jal	78c <read>
    if(cc < 1)
 38e:	00a05e63          	blez	a0,3aa <gets+0x52>
    buf[i++] = c;
 392:	faf44783          	lbu	a5,-81(s0)
 396:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 39a:	01578763          	beq	a5,s5,3a8 <gets+0x50>
 39e:	0905                	add	s2,s2,1
 3a0:	fd679de3          	bne	a5,s6,37a <gets+0x22>
    buf[i++] = c;
 3a4:	89a6                	mv	s3,s1
 3a6:	a011                	j	3aa <gets+0x52>
 3a8:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 3aa:	99de                	add	s3,s3,s7
 3ac:	00098023          	sb	zero,0(s3)
  return buf;
}
 3b0:	855e                	mv	a0,s7
 3b2:	60e6                	ld	ra,88(sp)
 3b4:	6446                	ld	s0,80(sp)
 3b6:	64a6                	ld	s1,72(sp)
 3b8:	6906                	ld	s2,64(sp)
 3ba:	79e2                	ld	s3,56(sp)
 3bc:	7a42                	ld	s4,48(sp)
 3be:	7aa2                	ld	s5,40(sp)
 3c0:	7b02                	ld	s6,32(sp)
 3c2:	6be2                	ld	s7,24(sp)
 3c4:	6125                	add	sp,sp,96
 3c6:	8082                	ret

00000000000003c8 <stat>:

int
stat(const char *n, struct stat *st)
{
 3c8:	1101                	add	sp,sp,-32
 3ca:	ec06                	sd	ra,24(sp)
 3cc:	e822                	sd	s0,16(sp)
 3ce:	e04a                	sd	s2,0(sp)
 3d0:	1000                	add	s0,sp,32
 3d2:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3d4:	4581                	li	a1,0
 3d6:	3de000ef          	jal	7b4 <open>
  if(fd < 0)
 3da:	02054263          	bltz	a0,3fe <stat+0x36>
 3de:	e426                	sd	s1,8(sp)
 3e0:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3e2:	85ca                	mv	a1,s2
 3e4:	3e8000ef          	jal	7cc <fstat>
 3e8:	892a                	mv	s2,a0
  close(fd);
 3ea:	8526                	mv	a0,s1
 3ec:	3b0000ef          	jal	79c <close>
  return r;
 3f0:	64a2                	ld	s1,8(sp)
}
 3f2:	854a                	mv	a0,s2
 3f4:	60e2                	ld	ra,24(sp)
 3f6:	6442                	ld	s0,16(sp)
 3f8:	6902                	ld	s2,0(sp)
 3fa:	6105                	add	sp,sp,32
 3fc:	8082                	ret
    return -1;
 3fe:	597d                	li	s2,-1
 400:	bfcd                	j	3f2 <stat+0x2a>

0000000000000402 <atoi>:

int
atoi(const char *s)
{
 402:	1141                	add	sp,sp,-16
 404:	e422                	sd	s0,8(sp)
 406:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 408:	00054683          	lbu	a3,0(a0)
 40c:	fd06879b          	addw	a5,a3,-48
 410:	0ff7f793          	zext.b	a5,a5
 414:	4625                	li	a2,9
 416:	02f66863          	bltu	a2,a5,446 <atoi+0x44>
 41a:	872a                	mv	a4,a0
  n = 0;
 41c:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 41e:	0705                	add	a4,a4,1
 420:	0025179b          	sllw	a5,a0,0x2
 424:	9fa9                	addw	a5,a5,a0
 426:	0017979b          	sllw	a5,a5,0x1
 42a:	9fb5                	addw	a5,a5,a3
 42c:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 430:	00074683          	lbu	a3,0(a4)
 434:	fd06879b          	addw	a5,a3,-48
 438:	0ff7f793          	zext.b	a5,a5
 43c:	fef671e3          	bgeu	a2,a5,41e <atoi+0x1c>
  return n;
}
 440:	6422                	ld	s0,8(sp)
 442:	0141                	add	sp,sp,16
 444:	8082                	ret
  n = 0;
 446:	4501                	li	a0,0
 448:	bfe5                	j	440 <atoi+0x3e>

000000000000044a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 44a:	1141                	add	sp,sp,-16
 44c:	e422                	sd	s0,8(sp)
 44e:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 450:	02b57463          	bgeu	a0,a1,478 <memmove+0x2e>
    while(n-- > 0)
 454:	00c05f63          	blez	a2,472 <memmove+0x28>
 458:	1602                	sll	a2,a2,0x20
 45a:	9201                	srl	a2,a2,0x20
 45c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 460:	872a                	mv	a4,a0
      *dst++ = *src++;
 462:	0585                	add	a1,a1,1
 464:	0705                	add	a4,a4,1
 466:	fff5c683          	lbu	a3,-1(a1)
 46a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 46e:	fef71ae3          	bne	a4,a5,462 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 472:	6422                	ld	s0,8(sp)
 474:	0141                	add	sp,sp,16
 476:	8082                	ret
    dst += n;
 478:	00c50733          	add	a4,a0,a2
    src += n;
 47c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 47e:	fec05ae3          	blez	a2,472 <memmove+0x28>
 482:	fff6079b          	addw	a5,a2,-1
 486:	1782                	sll	a5,a5,0x20
 488:	9381                	srl	a5,a5,0x20
 48a:	fff7c793          	not	a5,a5
 48e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 490:	15fd                	add	a1,a1,-1
 492:	177d                	add	a4,a4,-1
 494:	0005c683          	lbu	a3,0(a1)
 498:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 49c:	fee79ae3          	bne	a5,a4,490 <memmove+0x46>
 4a0:	bfc9                	j	472 <memmove+0x28>

00000000000004a2 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4a2:	1141                	add	sp,sp,-16
 4a4:	e422                	sd	s0,8(sp)
 4a6:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4a8:	ca05                	beqz	a2,4d8 <memcmp+0x36>
 4aa:	fff6069b          	addw	a3,a2,-1
 4ae:	1682                	sll	a3,a3,0x20
 4b0:	9281                	srl	a3,a3,0x20
 4b2:	0685                	add	a3,a3,1
 4b4:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 4b6:	00054783          	lbu	a5,0(a0)
 4ba:	0005c703          	lbu	a4,0(a1)
 4be:	00e79863          	bne	a5,a4,4ce <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 4c2:	0505                	add	a0,a0,1
    p2++;
 4c4:	0585                	add	a1,a1,1
  while (n-- > 0) {
 4c6:	fed518e3          	bne	a0,a3,4b6 <memcmp+0x14>
  }
  return 0;
 4ca:	4501                	li	a0,0
 4cc:	a019                	j	4d2 <memcmp+0x30>
      return *p1 - *p2;
 4ce:	40e7853b          	subw	a0,a5,a4
}
 4d2:	6422                	ld	s0,8(sp)
 4d4:	0141                	add	sp,sp,16
 4d6:	8082                	ret
  return 0;
 4d8:	4501                	li	a0,0
 4da:	bfe5                	j	4d2 <memcmp+0x30>

00000000000004dc <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4dc:	1141                	add	sp,sp,-16
 4de:	e406                	sd	ra,8(sp)
 4e0:	e022                	sd	s0,0(sp)
 4e2:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 4e4:	f67ff0ef          	jal	44a <memmove>
}
 4e8:	60a2                	ld	ra,8(sp)
 4ea:	6402                	ld	s0,0(sp)
 4ec:	0141                	add	sp,sp,16
 4ee:	8082                	ret

00000000000004f0 <htons>:
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
}

uint16_t
htons(uint16_t h)
{
 4f0:	1141                	add	sp,sp,-16
 4f2:	e422                	sd	s0,8(sp)
 4f4:	0800                	add	s0,sp,16
    if (!endian) {
 4f6:	00001797          	auipc	a5,0x1
 4fa:	b0a7a783          	lw	a5,-1270(a5) # 1000 <endian>
 4fe:	e385                	bnez	a5,51e <htons+0x2e>
        endian = byteorder();
 500:	4d200793          	li	a5,1234
 504:	00001717          	auipc	a4,0x1
 508:	aef72e23          	sw	a5,-1284(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 50c:	0085179b          	sllw	a5,a0,0x8
 510:	0085551b          	srlw	a0,a0,0x8
 514:	8fc9                	or	a5,a5,a0
 516:	03079513          	sll	a0,a5,0x30
 51a:	9141                	srl	a0,a0,0x30
 51c:	a029                	j	526 <htons+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(h) : h;
 51e:	4d200713          	li	a4,1234
 522:	fee785e3          	beq	a5,a4,50c <htons+0x1c>
}
 526:	6422                	ld	s0,8(sp)
 528:	0141                	add	sp,sp,16
 52a:	8082                	ret

000000000000052c <ntohs>:

uint16_t
ntohs(uint16_t n)
{
 52c:	1141                	add	sp,sp,-16
 52e:	e422                	sd	s0,8(sp)
 530:	0800                	add	s0,sp,16
    if (!endian) {
 532:	00001797          	auipc	a5,0x1
 536:	ace7a783          	lw	a5,-1330(a5) # 1000 <endian>
 53a:	e385                	bnez	a5,55a <ntohs+0x2e>
        endian = byteorder();
 53c:	4d200793          	li	a5,1234
 540:	00001717          	auipc	a4,0x1
 544:	acf72023          	sw	a5,-1344(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 548:	0085179b          	sllw	a5,a0,0x8
 54c:	0085551b          	srlw	a0,a0,0x8
 550:	8fc9                	or	a5,a5,a0
 552:	03079513          	sll	a0,a5,0x30
 556:	9141                	srl	a0,a0,0x30
 558:	a029                	j	562 <ntohs+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(n) : n;
 55a:	4d200713          	li	a4,1234
 55e:	fee785e3          	beq	a5,a4,548 <ntohs+0x1c>
}
 562:	6422                	ld	s0,8(sp)
 564:	0141                	add	sp,sp,16
 566:	8082                	ret

0000000000000568 <htonl>:

uint32_t
htonl(uint32_t h)
{
 568:	1141                	add	sp,sp,-16
 56a:	e422                	sd	s0,8(sp)
 56c:	0800                	add	s0,sp,16
    if (!endian) {
 56e:	00001797          	auipc	a5,0x1
 572:	a927a783          	lw	a5,-1390(a5) # 1000 <endian>
 576:	ef85                	bnez	a5,5ae <htonl+0x46>
        endian = byteorder();
 578:	4d200793          	li	a5,1234
 57c:	00001717          	auipc	a4,0x1
 580:	a8f72223          	sw	a5,-1404(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 584:	0185179b          	sllw	a5,a0,0x18
 588:	0185571b          	srlw	a4,a0,0x18
 58c:	8fd9                	or	a5,a5,a4
 58e:	0085171b          	sllw	a4,a0,0x8
 592:	00ff06b7          	lui	a3,0xff0
 596:	8f75                	and	a4,a4,a3
 598:	8fd9                	or	a5,a5,a4
 59a:	0085551b          	srlw	a0,a0,0x8
 59e:	6741                	lui	a4,0x10
 5a0:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeef0>
 5a4:	8d79                	and	a0,a0,a4
 5a6:	8fc9                	or	a5,a5,a0
 5a8:	0007851b          	sext.w	a0,a5
 5ac:	a029                	j	5b6 <htonl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(h) : h;
 5ae:	4d200713          	li	a4,1234
 5b2:	fce789e3          	beq	a5,a4,584 <htonl+0x1c>
}
 5b6:	6422                	ld	s0,8(sp)
 5b8:	0141                	add	sp,sp,16
 5ba:	8082                	ret

00000000000005bc <ntohl>:

uint32_t
ntohl(uint32_t n)
{
 5bc:	1141                	add	sp,sp,-16
 5be:	e422                	sd	s0,8(sp)
 5c0:	0800                	add	s0,sp,16
    if (!endian) {
 5c2:	00001797          	auipc	a5,0x1
 5c6:	a3e7a783          	lw	a5,-1474(a5) # 1000 <endian>
 5ca:	ef85                	bnez	a5,602 <ntohl+0x46>
        endian = byteorder();
 5cc:	4d200793          	li	a5,1234
 5d0:	00001717          	auipc	a4,0x1
 5d4:	a2f72823          	sw	a5,-1488(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 5d8:	0185179b          	sllw	a5,a0,0x18
 5dc:	0185571b          	srlw	a4,a0,0x18
 5e0:	8fd9                	or	a5,a5,a4
 5e2:	0085171b          	sllw	a4,a0,0x8
 5e6:	00ff06b7          	lui	a3,0xff0
 5ea:	8f75                	and	a4,a4,a3
 5ec:	8fd9                	or	a5,a5,a4
 5ee:	0085551b          	srlw	a0,a0,0x8
 5f2:	6741                	lui	a4,0x10
 5f4:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeef0>
 5f8:	8d79                	and	a0,a0,a4
 5fa:	8fc9                	or	a5,a5,a0
 5fc:	0007851b          	sext.w	a0,a5
 600:	a029                	j	60a <ntohl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(n) : n;
 602:	4d200713          	li	a4,1234
 606:	fce789e3          	beq	a5,a4,5d8 <ntohl+0x1c>
}
 60a:	6422                	ld	s0,8(sp)
 60c:	0141                	add	sp,sp,16
 60e:	8082                	ret

0000000000000610 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
 610:	1141                	add	sp,sp,-16
 612:	e422                	sd	s0,8(sp)
 614:	0800                	add	s0,sp,16
 616:	872a                	mv	a4,a0
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
 618:	02000693          	li	a3,32
 61c:	4525                	li	a0,9
 61e:	a011                	j	622 <strtol+0x12>
        s++;
 620:	0705                	add	a4,a4,1
    while (*s == ' ' || *s == '\t')
 622:	00074783          	lbu	a5,0(a4)
 626:	fed78de3          	beq	a5,a3,620 <strtol+0x10>
 62a:	fea78be3          	beq	a5,a0,620 <strtol+0x10>

    // plus/minus sign
    if (*s == '+')
 62e:	02b00693          	li	a3,43
 632:	02d78663          	beq	a5,a3,65e <strtol+0x4e>
        s++;
    else if (*s == '-')
 636:	02d00693          	li	a3,45
    int neg = 0;
 63a:	4301                	li	t1,0
    else if (*s == '-')
 63c:	02d78463          	beq	a5,a3,664 <strtol+0x54>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 640:	fef67793          	and	a5,a2,-17
 644:	eb89                	bnez	a5,656 <strtol+0x46>
 646:	00074683          	lbu	a3,0(a4)
 64a:	03000793          	li	a5,48
 64e:	00f68e63          	beq	a3,a5,66a <strtol+0x5a>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
 652:	e211                	bnez	a2,656 <strtol+0x46>
        s++, base = 8;
    else if (base == 0)
        base = 10;
 654:	4629                	li	a2,10
 656:	4501                	li	a0,0

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
 658:	4825                	li	a6,9
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
 65a:	48e5                	li	a7,25
 65c:	a825                	j	694 <strtol+0x84>
        s++;
 65e:	0705                	add	a4,a4,1
    int neg = 0;
 660:	4301                	li	t1,0
 662:	bff9                	j	640 <strtol+0x30>
        s++, neg = 1;
 664:	0705                	add	a4,a4,1
 666:	4305                	li	t1,1
 668:	bfe1                	j	640 <strtol+0x30>
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 66a:	00174683          	lbu	a3,1(a4)
 66e:	07800793          	li	a5,120
 672:	00f68663          	beq	a3,a5,67e <strtol+0x6e>
    else if (base == 0 && s[0] == '0')
 676:	f265                	bnez	a2,656 <strtol+0x46>
        s++, base = 8;
 678:	0705                	add	a4,a4,1
 67a:	4621                	li	a2,8
 67c:	bfe9                	j	656 <strtol+0x46>
        s += 2, base = 16;
 67e:	0709                	add	a4,a4,2
 680:	4641                	li	a2,16
 682:	bfd1                	j	656 <strtol+0x46>
            dig = *s - '0';
 684:	fd07879b          	addw	a5,a5,-48
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
 688:	04c7d063          	bge	a5,a2,6c8 <strtol+0xb8>
            break;
        s++, val = (val * base) + dig;
 68c:	0705                	add	a4,a4,1
 68e:	02a60533          	mul	a0,a2,a0
 692:	953e                	add	a0,a0,a5
        if (*s >= '0' && *s <= '9')
 694:	00074783          	lbu	a5,0(a4)
 698:	fd07869b          	addw	a3,a5,-48
 69c:	0ff6f693          	zext.b	a3,a3
 6a0:	fed872e3          	bgeu	a6,a3,684 <strtol+0x74>
        else if (*s >= 'a' && *s <= 'z')
 6a4:	f9f7869b          	addw	a3,a5,-97
 6a8:	0ff6f693          	zext.b	a3,a3
 6ac:	00d8e563          	bltu	a7,a3,6b6 <strtol+0xa6>
            dig = *s - 'a' + 10;
 6b0:	fa97879b          	addw	a5,a5,-87
 6b4:	bfd1                	j	688 <strtol+0x78>
        else if (*s >= 'A' && *s <= 'Z')
 6b6:	fbf7869b          	addw	a3,a5,-65
 6ba:	0ff6f693          	zext.b	a3,a3
 6be:	00d8e563          	bltu	a7,a3,6c8 <strtol+0xb8>
            dig = *s - 'A' + 10;
 6c2:	fc97879b          	addw	a5,a5,-55
 6c6:	b7c9                	j	688 <strtol+0x78>
        // we don't properly detect overflow!
    }

    if (endptr)
 6c8:	c191                	beqz	a1,6cc <strtol+0xbc>
        *endptr = (char *) s;
 6ca:	e198                	sd	a4,0(a1)
    return (neg ? -val : val);
 6cc:	00030463          	beqz	t1,6d4 <strtol+0xc4>
 6d0:	40a00533          	neg	a0,a0
}
 6d4:	6422                	ld	s0,8(sp)
 6d6:	0141                	add	sp,sp,16
 6d8:	8082                	ret

00000000000006da <inet_pton>:
inet_pton (int family, const char *p, void *n) {
    char *sp, *ep;
    int idx;
    long ret;

    if (family != AF_INET) {
 6da:	4785                	li	a5,1
 6dc:	08f51063          	bne	a0,a5,75c <inet_pton+0x82>
inet_pton (int family, const char *p, void *n) {
 6e0:	715d                	add	sp,sp,-80
 6e2:	e486                	sd	ra,72(sp)
 6e4:	e0a2                	sd	s0,64(sp)
 6e6:	fc26                	sd	s1,56(sp)
 6e8:	f84a                	sd	s2,48(sp)
 6ea:	f44e                	sd	s3,40(sp)
 6ec:	f052                	sd	s4,32(sp)
 6ee:	ec56                	sd	s5,24(sp)
 6f0:	e85a                	sd	s6,16(sp)
 6f2:	0880                	add	s0,sp,80
 6f4:	84ae                	mv	s1,a1
 6f6:	89b2                	mv	s3,a2
 6f8:	4901                	li	s2,0
        return -1;
    }
    sp = (char *)p;
    for (idx = 0; idx < 4; idx++) {
        ret = strtol(sp, &ep, 10);
        if (ret < 0 || ret > 255) {
 6fa:	0ff00a13          	li	s4,255
            return -1;
        }
        if (ep == sp) {
            return -1;
        }
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 6fe:	4a8d                	li	s5,3
 700:	02e00b13          	li	s6,46
 704:	a805                	j	734 <inet_pton+0x5a>
 706:	0007c783          	lbu	a5,0(a5)
 70a:	efb9                	bnez	a5,768 <inet_pton+0x8e>
            return -1;
        }
        ((uint8_t *)n)[idx] = ret;
 70c:	00a981a3          	sb	a0,3(s3)
        sp = ep + 1;
    }
    return 0;
 710:	4501                	li	a0,0
}
 712:	60a6                	ld	ra,72(sp)
 714:	6406                	ld	s0,64(sp)
 716:	74e2                	ld	s1,56(sp)
 718:	7942                	ld	s2,48(sp)
 71a:	79a2                	ld	s3,40(sp)
 71c:	7a02                	ld	s4,32(sp)
 71e:	6ae2                	ld	s5,24(sp)
 720:	6b42                	ld	s6,16(sp)
 722:	6161                	add	sp,sp,80
 724:	8082                	ret
        ((uint8_t *)n)[idx] = ret;
 726:	01298733          	add	a4,s3,s2
 72a:	00a70023          	sb	a0,0(a4)
        sp = ep + 1;
 72e:	00178493          	add	s1,a5,1
    for (idx = 0; idx < 4; idx++) {
 732:	0905                	add	s2,s2,1
        ret = strtol(sp, &ep, 10);
 734:	4629                	li	a2,10
 736:	fb840593          	add	a1,s0,-72
 73a:	8526                	mv	a0,s1
 73c:	ed5ff0ef          	jal	610 <strtol>
        if (ret < 0 || ret > 255) {
 740:	02aa6063          	bltu	s4,a0,760 <inet_pton+0x86>
        if (ep == sp) {
 744:	fb843783          	ld	a5,-72(s0)
 748:	00978e63          	beq	a5,s1,764 <inet_pton+0x8a>
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 74c:	fb590de3          	beq	s2,s5,706 <inet_pton+0x2c>
 750:	0007c703          	lbu	a4,0(a5)
 754:	fd6709e3          	beq	a4,s6,726 <inet_pton+0x4c>
            return -1;
 758:	557d                	li	a0,-1
 75a:	bf65                	j	712 <inet_pton+0x38>
        return -1;
 75c:	557d                	li	a0,-1
}
 75e:	8082                	ret
            return -1;
 760:	557d                	li	a0,-1
 762:	bf45                	j	712 <inet_pton+0x38>
            return -1;
 764:	557d                	li	a0,-1
 766:	b775                	j	712 <inet_pton+0x38>
            return -1;
 768:	557d                	li	a0,-1
 76a:	b765                	j	712 <inet_pton+0x38>

000000000000076c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 76c:	4885                	li	a7,1
 ecall
 76e:	00000073          	ecall
 ret
 772:	8082                	ret

0000000000000774 <exit>:
.global exit
exit:
 li a7, SYS_exit
 774:	4889                	li	a7,2
 ecall
 776:	00000073          	ecall
 ret
 77a:	8082                	ret

000000000000077c <wait>:
.global wait
wait:
 li a7, SYS_wait
 77c:	488d                	li	a7,3
 ecall
 77e:	00000073          	ecall
 ret
 782:	8082                	ret

0000000000000784 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 784:	4891                	li	a7,4
 ecall
 786:	00000073          	ecall
 ret
 78a:	8082                	ret

000000000000078c <read>:
.global read
read:
 li a7, SYS_read
 78c:	4895                	li	a7,5
 ecall
 78e:	00000073          	ecall
 ret
 792:	8082                	ret

0000000000000794 <write>:
.global write
write:
 li a7, SYS_write
 794:	48c1                	li	a7,16
 ecall
 796:	00000073          	ecall
 ret
 79a:	8082                	ret

000000000000079c <close>:
.global close
close:
 li a7, SYS_close
 79c:	48d5                	li	a7,21
 ecall
 79e:	00000073          	ecall
 ret
 7a2:	8082                	ret

00000000000007a4 <kill>:
.global kill
kill:
 li a7, SYS_kill
 7a4:	4899                	li	a7,6
 ecall
 7a6:	00000073          	ecall
 ret
 7aa:	8082                	ret

00000000000007ac <exec>:
.global exec
exec:
 li a7, SYS_exec
 7ac:	489d                	li	a7,7
 ecall
 7ae:	00000073          	ecall
 ret
 7b2:	8082                	ret

00000000000007b4 <open>:
.global open
open:
 li a7, SYS_open
 7b4:	48bd                	li	a7,15
 ecall
 7b6:	00000073          	ecall
 ret
 7ba:	8082                	ret

00000000000007bc <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 7bc:	48c5                	li	a7,17
 ecall
 7be:	00000073          	ecall
 ret
 7c2:	8082                	ret

00000000000007c4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 7c4:	48c9                	li	a7,18
 ecall
 7c6:	00000073          	ecall
 ret
 7ca:	8082                	ret

00000000000007cc <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 7cc:	48a1                	li	a7,8
 ecall
 7ce:	00000073          	ecall
 ret
 7d2:	8082                	ret

00000000000007d4 <link>:
.global link
link:
 li a7, SYS_link
 7d4:	48cd                	li	a7,19
 ecall
 7d6:	00000073          	ecall
 ret
 7da:	8082                	ret

00000000000007dc <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 7dc:	48d1                	li	a7,20
 ecall
 7de:	00000073          	ecall
 ret
 7e2:	8082                	ret

00000000000007e4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 7e4:	48a5                	li	a7,9
 ecall
 7e6:	00000073          	ecall
 ret
 7ea:	8082                	ret

00000000000007ec <dup>:
.global dup
dup:
 li a7, SYS_dup
 7ec:	48a9                	li	a7,10
 ecall
 7ee:	00000073          	ecall
 ret
 7f2:	8082                	ret

00000000000007f4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 7f4:	48ad                	li	a7,11
 ecall
 7f6:	00000073          	ecall
 ret
 7fa:	8082                	ret

00000000000007fc <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 7fc:	48b1                	li	a7,12
 ecall
 7fe:	00000073          	ecall
 ret
 802:	8082                	ret

0000000000000804 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 804:	48b5                	li	a7,13
 ecall
 806:	00000073          	ecall
 ret
 80a:	8082                	ret

000000000000080c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 80c:	48b9                	li	a7,14
 ecall
 80e:	00000073          	ecall
 ret
 812:	8082                	ret

0000000000000814 <socket>:
.global socket
socket:
 li a7, SYS_socket
 814:	48d9                	li	a7,22
 ecall
 816:	00000073          	ecall
 ret
 81a:	8082                	ret

000000000000081c <bind>:
.global bind
bind:
 li a7, SYS_bind
 81c:	48dd                	li	a7,23
 ecall
 81e:	00000073          	ecall
 ret
 822:	8082                	ret

0000000000000824 <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 824:	48e1                	li	a7,24
 ecall
 826:	00000073          	ecall
 ret
 82a:	8082                	ret

000000000000082c <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 82c:	48e5                	li	a7,25
 ecall
 82e:	00000073          	ecall
 ret
 832:	8082                	ret

0000000000000834 <connect>:
.global connect
connect:
 li a7, SYS_connect
 834:	48e9                	li	a7,26
 ecall
 836:	00000073          	ecall
 ret
 83a:	8082                	ret

000000000000083c <listen>:
.global listen
listen:
 li a7, SYS_listen
 83c:	48ed                	li	a7,27
 ecall
 83e:	00000073          	ecall
 ret
 842:	8082                	ret

0000000000000844 <accept>:
.global accept
accept:
 li a7, SYS_accept
 844:	48f1                	li	a7,28
 ecall
 846:	00000073          	ecall
 ret
 84a:	8082                	ret

000000000000084c <recv>:
.global recv
recv:
 li a7, SYS_recv
 84c:	48f5                	li	a7,29
 ecall
 84e:	00000073          	ecall
 ret
 852:	8082                	ret

0000000000000854 <send>:
.global send
send:
 li a7, SYS_send
 854:	48f9                	li	a7,30
 ecall
 856:	00000073          	ecall
 ret
 85a:	8082                	ret

000000000000085c <ioctl>:
.global ioctl
ioctl:
 li a7, SYS_ioctl
 85c:	48fd                	li	a7,31
 ecall
 85e:	00000073          	ecall
 ret
 862:	8082                	ret

0000000000000864 <consolemode>:
.global consolemode
consolemode:
 li a7, SYS_consolemode
 864:	02000893          	li	a7,32
 ecall
 868:	00000073          	ecall
 ret
 86c:	8082                	ret

000000000000086e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 86e:	1101                	add	sp,sp,-32
 870:	ec06                	sd	ra,24(sp)
 872:	e822                	sd	s0,16(sp)
 874:	1000                	add	s0,sp,32
 876:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 87a:	4605                	li	a2,1
 87c:	fef40593          	add	a1,s0,-17
 880:	f15ff0ef          	jal	794 <write>
}
 884:	60e2                	ld	ra,24(sp)
 886:	6442                	ld	s0,16(sp)
 888:	6105                	add	sp,sp,32
 88a:	8082                	ret

000000000000088c <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 88c:	715d                	add	sp,sp,-80
 88e:	e486                	sd	ra,72(sp)
 890:	e0a2                	sd	s0,64(sp)
 892:	fc26                	sd	s1,56(sp)
 894:	0880                	add	s0,sp,80
 896:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 898:	c299                	beqz	a3,89e <printint+0x12>
 89a:	0805c963          	bltz	a1,92c <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 89e:	2581                	sext.w	a1,a1
  neg = 0;
 8a0:	4881                	li	a7,0
 8a2:	fb840693          	add	a3,s0,-72
  }

  i = 0;
 8a6:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 8a8:	2601                	sext.w	a2,a2
 8aa:	00000517          	auipc	a0,0x0
 8ae:	5ee50513          	add	a0,a0,1518 # e98 <digits>
 8b2:	883a                	mv	a6,a4
 8b4:	2705                	addw	a4,a4,1
 8b6:	02c5f7bb          	remuw	a5,a1,a2
 8ba:	1782                	sll	a5,a5,0x20
 8bc:	9381                	srl	a5,a5,0x20
 8be:	97aa                	add	a5,a5,a0
 8c0:	0007c783          	lbu	a5,0(a5)
 8c4:	00f68023          	sb	a5,0(a3) # ff0000 <base+0xfeeff0>
  }while((x /= base) != 0);
 8c8:	0005879b          	sext.w	a5,a1
 8cc:	02c5d5bb          	divuw	a1,a1,a2
 8d0:	0685                	add	a3,a3,1
 8d2:	fec7f0e3          	bgeu	a5,a2,8b2 <printint+0x26>
  if(neg)
 8d6:	00088c63          	beqz	a7,8ee <printint+0x62>
    buf[i++] = '-';
 8da:	fd070793          	add	a5,a4,-48
 8de:	00878733          	add	a4,a5,s0
 8e2:	02d00793          	li	a5,45
 8e6:	fef70423          	sb	a5,-24(a4)
 8ea:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 8ee:	02e05a63          	blez	a4,922 <printint+0x96>
 8f2:	f84a                	sd	s2,48(sp)
 8f4:	f44e                	sd	s3,40(sp)
 8f6:	fb840793          	add	a5,s0,-72
 8fa:	00e78933          	add	s2,a5,a4
 8fe:	fff78993          	add	s3,a5,-1
 902:	99ba                	add	s3,s3,a4
 904:	377d                	addw	a4,a4,-1
 906:	1702                	sll	a4,a4,0x20
 908:	9301                	srl	a4,a4,0x20
 90a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 90e:	fff94583          	lbu	a1,-1(s2)
 912:	8526                	mv	a0,s1
 914:	f5bff0ef          	jal	86e <putc>
  while(--i >= 0)
 918:	197d                	add	s2,s2,-1
 91a:	ff391ae3          	bne	s2,s3,90e <printint+0x82>
 91e:	7942                	ld	s2,48(sp)
 920:	79a2                	ld	s3,40(sp)
}
 922:	60a6                	ld	ra,72(sp)
 924:	6406                	ld	s0,64(sp)
 926:	74e2                	ld	s1,56(sp)
 928:	6161                	add	sp,sp,80
 92a:	8082                	ret
    x = -xx;
 92c:	40b005bb          	negw	a1,a1
    neg = 1;
 930:	4885                	li	a7,1
    x = -xx;
 932:	bf85                	j	8a2 <printint+0x16>

0000000000000934 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 934:	711d                	add	sp,sp,-96
 936:	ec86                	sd	ra,88(sp)
 938:	e8a2                	sd	s0,80(sp)
 93a:	e0ca                	sd	s2,64(sp)
 93c:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 93e:	0005c903          	lbu	s2,0(a1)
 942:	26090863          	beqz	s2,bb2 <vprintf+0x27e>
 946:	e4a6                	sd	s1,72(sp)
 948:	fc4e                	sd	s3,56(sp)
 94a:	f852                	sd	s4,48(sp)
 94c:	f456                	sd	s5,40(sp)
 94e:	f05a                	sd	s6,32(sp)
 950:	ec5e                	sd	s7,24(sp)
 952:	e862                	sd	s8,16(sp)
 954:	e466                	sd	s9,8(sp)
 956:	8b2a                	mv	s6,a0
 958:	8a2e                	mv	s4,a1
 95a:	8bb2                	mv	s7,a2
  state = 0;
 95c:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 95e:	4481                	li	s1,0
 960:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 962:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 966:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 96a:	06c00c93          	li	s9,108
 96e:	a005                	j	98e <vprintf+0x5a>
        putc(fd, c0);
 970:	85ca                	mv	a1,s2
 972:	855a                	mv	a0,s6
 974:	efbff0ef          	jal	86e <putc>
 978:	a019                	j	97e <vprintf+0x4a>
    } else if(state == '%'){
 97a:	03598263          	beq	s3,s5,99e <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 97e:	2485                	addw	s1,s1,1
 980:	8726                	mv	a4,s1
 982:	009a07b3          	add	a5,s4,s1
 986:	0007c903          	lbu	s2,0(a5)
 98a:	20090c63          	beqz	s2,ba2 <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 98e:	0009079b          	sext.w	a5,s2
    if(state == 0){
 992:	fe0994e3          	bnez	s3,97a <vprintf+0x46>
      if(c0 == '%'){
 996:	fd579de3          	bne	a5,s5,970 <vprintf+0x3c>
        state = '%';
 99a:	89be                	mv	s3,a5
 99c:	b7cd                	j	97e <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 99e:	00ea06b3          	add	a3,s4,a4
 9a2:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 9a6:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 9a8:	c681                	beqz	a3,9b0 <vprintf+0x7c>
 9aa:	9752                	add	a4,a4,s4
 9ac:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 9b0:	03878f63          	beq	a5,s8,9ee <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 9b4:	05978963          	beq	a5,s9,a06 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 9b8:	07500713          	li	a4,117
 9bc:	0ee78363          	beq	a5,a4,aa2 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 9c0:	07800713          	li	a4,120
 9c4:	12e78563          	beq	a5,a4,aee <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 9c8:	07000713          	li	a4,112
 9cc:	14e78a63          	beq	a5,a4,b20 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 9d0:	07300713          	li	a4,115
 9d4:	18e78a63          	beq	a5,a4,b68 <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 9d8:	02500713          	li	a4,37
 9dc:	04e79563          	bne	a5,a4,a26 <vprintf+0xf2>
        putc(fd, '%');
 9e0:	02500593          	li	a1,37
 9e4:	855a                	mv	a0,s6
 9e6:	e89ff0ef          	jal	86e <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 9ea:	4981                	li	s3,0
 9ec:	bf49                	j	97e <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 9ee:	008b8913          	add	s2,s7,8
 9f2:	4685                	li	a3,1
 9f4:	4629                	li	a2,10
 9f6:	000ba583          	lw	a1,0(s7)
 9fa:	855a                	mv	a0,s6
 9fc:	e91ff0ef          	jal	88c <printint>
 a00:	8bca                	mv	s7,s2
      state = 0;
 a02:	4981                	li	s3,0
 a04:	bfad                	j	97e <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 a06:	06400793          	li	a5,100
 a0a:	02f68963          	beq	a3,a5,a3c <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 a0e:	06c00793          	li	a5,108
 a12:	04f68263          	beq	a3,a5,a56 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 a16:	07500793          	li	a5,117
 a1a:	0af68063          	beq	a3,a5,aba <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 a1e:	07800793          	li	a5,120
 a22:	0ef68263          	beq	a3,a5,b06 <vprintf+0x1d2>
        putc(fd, '%');
 a26:	02500593          	li	a1,37
 a2a:	855a                	mv	a0,s6
 a2c:	e43ff0ef          	jal	86e <putc>
        putc(fd, c0);
 a30:	85ca                	mv	a1,s2
 a32:	855a                	mv	a0,s6
 a34:	e3bff0ef          	jal	86e <putc>
      state = 0;
 a38:	4981                	li	s3,0
 a3a:	b791                	j	97e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 a3c:	008b8913          	add	s2,s7,8
 a40:	4685                	li	a3,1
 a42:	4629                	li	a2,10
 a44:	000bb583          	ld	a1,0(s7)
 a48:	855a                	mv	a0,s6
 a4a:	e43ff0ef          	jal	88c <printint>
        i += 1;
 a4e:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 a50:	8bca                	mv	s7,s2
      state = 0;
 a52:	4981                	li	s3,0
        i += 1;
 a54:	b72d                	j	97e <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 a56:	06400793          	li	a5,100
 a5a:	02f60763          	beq	a2,a5,a88 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 a5e:	07500793          	li	a5,117
 a62:	06f60963          	beq	a2,a5,ad4 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 a66:	07800793          	li	a5,120
 a6a:	faf61ee3          	bne	a2,a5,a26 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 a6e:	008b8913          	add	s2,s7,8
 a72:	4681                	li	a3,0
 a74:	4641                	li	a2,16
 a76:	000bb583          	ld	a1,0(s7)
 a7a:	855a                	mv	a0,s6
 a7c:	e11ff0ef          	jal	88c <printint>
        i += 2;
 a80:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 a82:	8bca                	mv	s7,s2
      state = 0;
 a84:	4981                	li	s3,0
        i += 2;
 a86:	bde5                	j	97e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 a88:	008b8913          	add	s2,s7,8
 a8c:	4685                	li	a3,1
 a8e:	4629                	li	a2,10
 a90:	000bb583          	ld	a1,0(s7)
 a94:	855a                	mv	a0,s6
 a96:	df7ff0ef          	jal	88c <printint>
        i += 2;
 a9a:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 a9c:	8bca                	mv	s7,s2
      state = 0;
 a9e:	4981                	li	s3,0
        i += 2;
 aa0:	bdf9                	j	97e <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 aa2:	008b8913          	add	s2,s7,8
 aa6:	4681                	li	a3,0
 aa8:	4629                	li	a2,10
 aaa:	000ba583          	lw	a1,0(s7)
 aae:	855a                	mv	a0,s6
 ab0:	dddff0ef          	jal	88c <printint>
 ab4:	8bca                	mv	s7,s2
      state = 0;
 ab6:	4981                	li	s3,0
 ab8:	b5d9                	j	97e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 aba:	008b8913          	add	s2,s7,8
 abe:	4681                	li	a3,0
 ac0:	4629                	li	a2,10
 ac2:	000bb583          	ld	a1,0(s7)
 ac6:	855a                	mv	a0,s6
 ac8:	dc5ff0ef          	jal	88c <printint>
        i += 1;
 acc:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 ace:	8bca                	mv	s7,s2
      state = 0;
 ad0:	4981                	li	s3,0
        i += 1;
 ad2:	b575                	j	97e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 ad4:	008b8913          	add	s2,s7,8
 ad8:	4681                	li	a3,0
 ada:	4629                	li	a2,10
 adc:	000bb583          	ld	a1,0(s7)
 ae0:	855a                	mv	a0,s6
 ae2:	dabff0ef          	jal	88c <printint>
        i += 2;
 ae6:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 ae8:	8bca                	mv	s7,s2
      state = 0;
 aea:	4981                	li	s3,0
        i += 2;
 aec:	bd49                	j	97e <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 aee:	008b8913          	add	s2,s7,8
 af2:	4681                	li	a3,0
 af4:	4641                	li	a2,16
 af6:	000ba583          	lw	a1,0(s7)
 afa:	855a                	mv	a0,s6
 afc:	d91ff0ef          	jal	88c <printint>
 b00:	8bca                	mv	s7,s2
      state = 0;
 b02:	4981                	li	s3,0
 b04:	bdad                	j	97e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 b06:	008b8913          	add	s2,s7,8
 b0a:	4681                	li	a3,0
 b0c:	4641                	li	a2,16
 b0e:	000bb583          	ld	a1,0(s7)
 b12:	855a                	mv	a0,s6
 b14:	d79ff0ef          	jal	88c <printint>
        i += 1;
 b18:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 b1a:	8bca                	mv	s7,s2
      state = 0;
 b1c:	4981                	li	s3,0
        i += 1;
 b1e:	b585                	j	97e <vprintf+0x4a>
 b20:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 b22:	008b8d13          	add	s10,s7,8
 b26:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 b2a:	03000593          	li	a1,48
 b2e:	855a                	mv	a0,s6
 b30:	d3fff0ef          	jal	86e <putc>
  putc(fd, 'x');
 b34:	07800593          	li	a1,120
 b38:	855a                	mv	a0,s6
 b3a:	d35ff0ef          	jal	86e <putc>
 b3e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 b40:	00000b97          	auipc	s7,0x0
 b44:	358b8b93          	add	s7,s7,856 # e98 <digits>
 b48:	03c9d793          	srl	a5,s3,0x3c
 b4c:	97de                	add	a5,a5,s7
 b4e:	0007c583          	lbu	a1,0(a5)
 b52:	855a                	mv	a0,s6
 b54:	d1bff0ef          	jal	86e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 b58:	0992                	sll	s3,s3,0x4
 b5a:	397d                	addw	s2,s2,-1
 b5c:	fe0916e3          	bnez	s2,b48 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 b60:	8bea                	mv	s7,s10
      state = 0;
 b62:	4981                	li	s3,0
 b64:	6d02                	ld	s10,0(sp)
 b66:	bd21                	j	97e <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 b68:	008b8993          	add	s3,s7,8
 b6c:	000bb903          	ld	s2,0(s7)
 b70:	00090f63          	beqz	s2,b8e <vprintf+0x25a>
        for(; *s; s++)
 b74:	00094583          	lbu	a1,0(s2)
 b78:	c195                	beqz	a1,b9c <vprintf+0x268>
          putc(fd, *s);
 b7a:	855a                	mv	a0,s6
 b7c:	cf3ff0ef          	jal	86e <putc>
        for(; *s; s++)
 b80:	0905                	add	s2,s2,1
 b82:	00094583          	lbu	a1,0(s2)
 b86:	f9f5                	bnez	a1,b7a <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 b88:	8bce                	mv	s7,s3
      state = 0;
 b8a:	4981                	li	s3,0
 b8c:	bbcd                	j	97e <vprintf+0x4a>
          s = "(null)";
 b8e:	00000917          	auipc	s2,0x0
 b92:	30290913          	add	s2,s2,770 # e90 <malloc+0x1ee>
        for(; *s; s++)
 b96:	02800593          	li	a1,40
 b9a:	b7c5                	j	b7a <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 b9c:	8bce                	mv	s7,s3
      state = 0;
 b9e:	4981                	li	s3,0
 ba0:	bbf9                	j	97e <vprintf+0x4a>
 ba2:	64a6                	ld	s1,72(sp)
 ba4:	79e2                	ld	s3,56(sp)
 ba6:	7a42                	ld	s4,48(sp)
 ba8:	7aa2                	ld	s5,40(sp)
 baa:	7b02                	ld	s6,32(sp)
 bac:	6be2                	ld	s7,24(sp)
 bae:	6c42                	ld	s8,16(sp)
 bb0:	6ca2                	ld	s9,8(sp)
    }
  }
}
 bb2:	60e6                	ld	ra,88(sp)
 bb4:	6446                	ld	s0,80(sp)
 bb6:	6906                	ld	s2,64(sp)
 bb8:	6125                	add	sp,sp,96
 bba:	8082                	ret

0000000000000bbc <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 bbc:	715d                	add	sp,sp,-80
 bbe:	ec06                	sd	ra,24(sp)
 bc0:	e822                	sd	s0,16(sp)
 bc2:	1000                	add	s0,sp,32
 bc4:	e010                	sd	a2,0(s0)
 bc6:	e414                	sd	a3,8(s0)
 bc8:	e818                	sd	a4,16(s0)
 bca:	ec1c                	sd	a5,24(s0)
 bcc:	03043023          	sd	a6,32(s0)
 bd0:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 bd4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 bd8:	8622                	mv	a2,s0
 bda:	d5bff0ef          	jal	934 <vprintf>
}
 bde:	60e2                	ld	ra,24(sp)
 be0:	6442                	ld	s0,16(sp)
 be2:	6161                	add	sp,sp,80
 be4:	8082                	ret

0000000000000be6 <printf>:

void
printf(const char *fmt, ...)
{
 be6:	711d                	add	sp,sp,-96
 be8:	ec06                	sd	ra,24(sp)
 bea:	e822                	sd	s0,16(sp)
 bec:	1000                	add	s0,sp,32
 bee:	e40c                	sd	a1,8(s0)
 bf0:	e810                	sd	a2,16(s0)
 bf2:	ec14                	sd	a3,24(s0)
 bf4:	f018                	sd	a4,32(s0)
 bf6:	f41c                	sd	a5,40(s0)
 bf8:	03043823          	sd	a6,48(s0)
 bfc:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 c00:	00840613          	add	a2,s0,8
 c04:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 c08:	85aa                	mv	a1,a0
 c0a:	4505                	li	a0,1
 c0c:	d29ff0ef          	jal	934 <vprintf>
}
 c10:	60e2                	ld	ra,24(sp)
 c12:	6442                	ld	s0,16(sp)
 c14:	6125                	add	sp,sp,96
 c16:	8082                	ret

0000000000000c18 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 c18:	1141                	add	sp,sp,-16
 c1a:	e422                	sd	s0,8(sp)
 c1c:	0800                	add	s0,sp,16
  Header *bp, *p;

  if(ap == 0)
 c1e:	cd3d                	beqz	a0,c9c <free+0x84>
    return;
  if((uint64)ap < 4096)
 c20:	6785                	lui	a5,0x1
 c22:	06f56d63          	bltu	a0,a5,c9c <free+0x84>
    return;
  bp = (Header*)ap - 1;
 c26:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c2a:	00000797          	auipc	a5,0x0
 c2e:	3de7b783          	ld	a5,990(a5) # 1008 <freep>
 c32:	a02d                	j	c5c <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 c34:	4618                	lw	a4,8(a2)
 c36:	9f2d                	addw	a4,a4,a1
 c38:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 c3c:	6398                	ld	a4,0(a5)
 c3e:	6310                	ld	a2,0(a4)
 c40:	a83d                	j	c7e <free+0x66>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 c42:	ff852703          	lw	a4,-8(a0)
 c46:	9f31                	addw	a4,a4,a2
 c48:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 c4a:	ff053683          	ld	a3,-16(a0)
 c4e:	a091                	j	c92 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c50:	6398                	ld	a4,0(a5)
 c52:	00e7e463          	bltu	a5,a4,c5a <free+0x42>
 c56:	00e6ea63          	bltu	a3,a4,c6a <free+0x52>
{
 c5a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c5c:	fed7fae3          	bgeu	a5,a3,c50 <free+0x38>
 c60:	6398                	ld	a4,0(a5)
 c62:	00e6e463          	bltu	a3,a4,c6a <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c66:	fee7eae3          	bltu	a5,a4,c5a <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 c6a:	ff852583          	lw	a1,-8(a0)
 c6e:	6390                	ld	a2,0(a5)
 c70:	02059813          	sll	a6,a1,0x20
 c74:	01c85713          	srl	a4,a6,0x1c
 c78:	9736                	add	a4,a4,a3
 c7a:	fae60de3          	beq	a2,a4,c34 <free+0x1c>
    bp->s.ptr = p->s.ptr->s.ptr;
 c7e:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 c82:	4790                	lw	a2,8(a5)
 c84:	02061593          	sll	a1,a2,0x20
 c88:	01c5d713          	srl	a4,a1,0x1c
 c8c:	973e                	add	a4,a4,a5
 c8e:	fae68ae3          	beq	a3,a4,c42 <free+0x2a>
    p->s.ptr = bp->s.ptr;
 c92:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 c94:	00000717          	auipc	a4,0x0
 c98:	36f73a23          	sd	a5,884(a4) # 1008 <freep>
}
 c9c:	6422                	ld	s0,8(sp)
 c9e:	0141                	add	sp,sp,16
 ca0:	8082                	ret

0000000000000ca2 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 ca2:	7139                	add	sp,sp,-64
 ca4:	fc06                	sd	ra,56(sp)
 ca6:	f822                	sd	s0,48(sp)
 ca8:	f426                	sd	s1,40(sp)
 caa:	ec4e                	sd	s3,24(sp)
 cac:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 cae:	02051493          	sll	s1,a0,0x20
 cb2:	9081                	srl	s1,s1,0x20
 cb4:	04bd                	add	s1,s1,15
 cb6:	8091                	srl	s1,s1,0x4
 cb8:	0014899b          	addw	s3,s1,1
 cbc:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 cbe:	00000517          	auipc	a0,0x0
 cc2:	34a53503          	ld	a0,842(a0) # 1008 <freep>
 cc6:	c915                	beqz	a0,cfa <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 cc8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 cca:	4798                	lw	a4,8(a5)
 ccc:	08977a63          	bgeu	a4,s1,d60 <malloc+0xbe>
 cd0:	f04a                	sd	s2,32(sp)
 cd2:	e852                	sd	s4,16(sp)
 cd4:	e456                	sd	s5,8(sp)
 cd6:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 cd8:	8a4e                	mv	s4,s3
 cda:	0009871b          	sext.w	a4,s3
 cde:	6685                	lui	a3,0x1
 ce0:	00d77363          	bgeu	a4,a3,ce6 <malloc+0x44>
 ce4:	6a05                	lui	s4,0x1
 ce6:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 cea:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 cee:	00000917          	auipc	s2,0x0
 cf2:	31a90913          	add	s2,s2,794 # 1008 <freep>
  if(p == (char*)-1)
 cf6:	5afd                	li	s5,-1
 cf8:	a081                	j	d38 <malloc+0x96>
 cfa:	f04a                	sd	s2,32(sp)
 cfc:	e852                	sd	s4,16(sp)
 cfe:	e456                	sd	s5,8(sp)
 d00:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 d02:	00000797          	auipc	a5,0x0
 d06:	30e78793          	add	a5,a5,782 # 1010 <base>
 d0a:	00000717          	auipc	a4,0x0
 d0e:	2ef73f23          	sd	a5,766(a4) # 1008 <freep>
 d12:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 d14:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 d18:	b7c1                	j	cd8 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 d1a:	6398                	ld	a4,0(a5)
 d1c:	e118                	sd	a4,0(a0)
 d1e:	a8a9                	j	d78 <malloc+0xd6>
  hp->s.size = nu;
 d20:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 d24:	0541                	add	a0,a0,16
 d26:	ef3ff0ef          	jal	c18 <free>
  return freep;
 d2a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 d2e:	c12d                	beqz	a0,d90 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d30:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 d32:	4798                	lw	a4,8(a5)
 d34:	02977263          	bgeu	a4,s1,d58 <malloc+0xb6>
    if(p == freep)
 d38:	00093703          	ld	a4,0(s2)
 d3c:	853e                	mv	a0,a5
 d3e:	fef719e3          	bne	a4,a5,d30 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 d42:	8552                	mv	a0,s4
 d44:	ab9ff0ef          	jal	7fc <sbrk>
  if(p == (char*)-1)
 d48:	fd551ce3          	bne	a0,s5,d20 <malloc+0x7e>
        return 0;
 d4c:	4501                	li	a0,0
 d4e:	7902                	ld	s2,32(sp)
 d50:	6a42                	ld	s4,16(sp)
 d52:	6aa2                	ld	s5,8(sp)
 d54:	6b02                	ld	s6,0(sp)
 d56:	a03d                	j	d84 <malloc+0xe2>
 d58:	7902                	ld	s2,32(sp)
 d5a:	6a42                	ld	s4,16(sp)
 d5c:	6aa2                	ld	s5,8(sp)
 d5e:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 d60:	fae48de3          	beq	s1,a4,d1a <malloc+0x78>
        p->s.size -= nunits;
 d64:	4137073b          	subw	a4,a4,s3
 d68:	c798                	sw	a4,8(a5)
        p += p->s.size;
 d6a:	02071693          	sll	a3,a4,0x20
 d6e:	01c6d713          	srl	a4,a3,0x1c
 d72:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 d74:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 d78:	00000717          	auipc	a4,0x0
 d7c:	28a73823          	sd	a0,656(a4) # 1008 <freep>
      return (void*)(p + 1);
 d80:	01078513          	add	a0,a5,16
  }
}
 d84:	70e2                	ld	ra,56(sp)
 d86:	7442                	ld	s0,48(sp)
 d88:	74a2                	ld	s1,40(sp)
 d8a:	69e2                	ld	s3,24(sp)
 d8c:	6121                	add	sp,sp,64
 d8e:	8082                	ret
 d90:	7902                	ld	s2,32(sp)
 d92:	6a42                	ld	s4,16(sp)
 d94:	6aa2                	ld	s5,8(sp)
 d96:	6b02                	ld	s6,0(sp)
 d98:	b7f5                	j	d84 <malloc+0xe2>
