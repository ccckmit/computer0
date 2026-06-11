
user/_httpd:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
    "Content-Length: 9\r\n"
    "\r\n"
    "Not Found";

int main(int argc, char *argv[])
{
   0:	7175                	add	sp,sp,-144
   2:	e506                	sd	ra,136(sp)
   4:	e122                	sd	s0,128(sp)
   6:	fca6                	sd	s1,120(sp)
   8:	f8ca                	sd	s2,112(sp)
   a:	f4ce                	sd	s3,104(sp)
   c:	f0d2                	sd	s4,96(sp)
   e:	ecd6                	sd	s5,88(sp)
  10:	e8da                	sd	s6,80(sp)
  12:	e4de                	sd	s7,72(sp)
  14:	e0e2                	sd	s8,64(sp)
  16:	fc66                	sd	s9,56(sp)
  18:	f86a                	sd	s10,48(sp)
  1a:	0900                	add	s0,sp,144
  1c:	81010113          	add	sp,sp,-2032
    struct sockaddr_in self, peer;
    unsigned char *addr;
    char buf[2048];
    int port = 8080;

    if (argc > 1) {
  20:	4785                	li	a5,1
    int port = 8080;
  22:	6489                	lui	s1,0x2
  24:	f9048493          	add	s1,s1,-112 # 1f90 <base+0xed0>
    if (argc > 1) {
  28:	06a7ca63          	blt	a5,a0,9c <main+0x9c>
        port = atoi(argv[1]);
    }

    printf("Starting HTTP Server on port %d\n", port);
  2c:	85a6                	mv	a1,s1
  2e:	00001517          	auipc	a0,0x1
  32:	ce250513          	add	a0,a0,-798 # d10 <malloc+0xfc>
  36:	323000ef          	jal	b58 <printf>
    
    soc = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
  3a:	4601                	li	a2,0
  3c:	4589                	li	a1,2
  3e:	4505                	li	a0,1
  40:	746000ef          	jal	786 <socket>
  44:	892a                	mv	s2,a0
    if (soc == -1) {
  46:	57fd                	li	a5,-1
  48:	04f50f63          	beq	a0,a5,a6 <main+0xa6>
        printf("socket: failure\n");
        exit(1);
    }
    printf("socket: success, soc=%d\n", soc);
  4c:	85aa                	mv	a1,a0
  4e:	00001517          	auipc	a0,0x1
  52:	d0250513          	add	a0,a0,-766 # d50 <malloc+0x13c>
  56:	303000ef          	jal	b58 <printf>
    
    self.sin_family = AF_INET;
  5a:	4785                	li	a5,1
  5c:	f8f41823          	sh	a5,-112(s0)
    self.sin_addr.s_addr = INADDR_ANY;
  60:	f8042a23          	sw	zero,-108(s0)
    self.sin_port = htons(port);
  64:	03049513          	sll	a0,s1,0x30
  68:	9141                	srl	a0,a0,0x30
  6a:	3f8000ef          	jal	462 <htons>
  6e:	f8a41923          	sh	a0,-110(s0)
    
    if (bind(soc, (struct sockaddr *)&self, sizeof(self)) == -1) {
  72:	4621                	li	a2,8
  74:	f9040593          	add	a1,s0,-112
  78:	854a                	mv	a0,s2
  7a:	714000ef          	jal	78e <bind>
  7e:	57fd                	li	a5,-1
  80:	02f51c63          	bne	a0,a5,b8 <main+0xb8>
        printf("bind: failure\n");
  84:	00001517          	auipc	a0,0x1
  88:	cec50513          	add	a0,a0,-788 # d70 <malloc+0x15c>
  8c:	2cd000ef          	jal	b58 <printf>
        close(soc);
  90:	854a                	mv	a0,s2
  92:	67c000ef          	jal	70e <close>
        exit(1);
  96:	4505                	li	a0,1
  98:	64e000ef          	jal	6e6 <exit>
        port = atoi(argv[1]);
  9c:	6588                	ld	a0,8(a1)
  9e:	2d6000ef          	jal	374 <atoi>
  a2:	84aa                	mv	s1,a0
  a4:	b761                	j	2c <main+0x2c>
        printf("socket: failure\n");
  a6:	00001517          	auipc	a0,0x1
  aa:	c9250513          	add	a0,a0,-878 # d38 <malloc+0x124>
  ae:	2ab000ef          	jal	b58 <printf>
        exit(1);
  b2:	4505                	li	a0,1
  b4:	632000ef          	jal	6e6 <exit>
    }
    
    addr = (unsigned char *)&self.sin_addr;
    printf("bind: success, http://%d.%d.%d.%d:%d\n", 
  b8:	f9444483          	lbu	s1,-108(s0)
  bc:	f9544983          	lbu	s3,-107(s0)
  c0:	f9644a03          	lbu	s4,-106(s0)
  c4:	f9744a83          	lbu	s5,-105(s0)
           addr[0], addr[1], addr[2], addr[3], ntohs(self.sin_port));
  c8:	f9245503          	lhu	a0,-110(s0)
  cc:	3d2000ef          	jal	49e <ntohs>
    printf("bind: success, http://%d.%d.%d.%d:%d\n", 
  d0:	0005079b          	sext.w	a5,a0
  d4:	8756                	mv	a4,s5
  d6:	86d2                	mv	a3,s4
  d8:	864e                	mv	a2,s3
  da:	85a6                	mv	a1,s1
  dc:	00001517          	auipc	a0,0x1
  e0:	ca450513          	add	a0,a0,-860 # d80 <malloc+0x16c>
  e4:	275000ef          	jal	b58 <printf>
    
    listen(soc, 5);
  e8:	4595                	li	a1,5
  ea:	854a                	mv	a0,s2
  ec:	6c2000ef          	jal	7ae <listen>
    printf("waiting for connection...\n");
  f0:	00001517          	auipc	a0,0x1
  f4:	cb850513          	add	a0,a0,-840 # da8 <malloc+0x194>
  f8:	261000ef          	jal	b58 <printf>

    while (1) {
        peerlen = sizeof(peer);
  fc:	49a1                	li	s3,8
        
        addr = (unsigned char *)&peer.sin_addr;
        printf("accept: from %d.%d.%d.%d:%d\n", 
               addr[0], addr[1], addr[2], addr[3], ntohs(peer.sin_port));
        
        int ret = recv(acc, buf, sizeof(buf) - 1);
  fe:	7b7d                	lui	s6,0xfffff
 100:	788b0793          	add	a5,s6,1928 # fffffffffffff788 <base+0xffffffffffffe6c8>
 104:	00878b33          	add	s6,a5,s0
        if (ret > 0) {
            buf[ret] = '\0';
 108:	7afd                	lui	s5,0xfffff
 10a:	fa0a8793          	add	a5,s5,-96 # ffffffffffffefa0 <base+0xffffffffffffdee0>
 10e:	00878ab3          	add	s5,a5,s0
            printf("recv: %d bytes\n", ret);
            
            if (buf[0] == 'G' && buf[1] == 'E' && buf[2] == 'T' && buf[3] == ' ') {
                send(acc, HTTP_RESPONSE, strlen(HTTP_RESPONSE));
            } else {
                send(acc, HTTP_RESPONSE_404, strlen(HTTP_RESPONSE_404));
 112:	00001b97          	auipc	s7,0x1
 116:	f3eb8b93          	add	s7,s7,-194 # 1050 <HTTP_RESPONSE_404>
 11a:	a039                	j	128 <main+0x128>
            printf("accept: failure\n");
 11c:	00001517          	auipc	a0,0x1
 120:	cac50513          	add	a0,a0,-852 # dc8 <malloc+0x1b4>
 124:	235000ef          	jal	b58 <printf>
        peerlen = sizeof(peer);
 128:	f9342e23          	sw	s3,-100(s0)
        acc = accept(soc, (struct sockaddr *)&peer, &peerlen);
 12c:	f9c40613          	add	a2,s0,-100
 130:	f8840593          	add	a1,s0,-120
 134:	854a                	mv	a0,s2
 136:	680000ef          	jal	7b6 <accept>
 13a:	84aa                	mv	s1,a0
        if (acc == -1) {
 13c:	57fd                	li	a5,-1
 13e:	fcf50fe3          	beq	a0,a5,11c <main+0x11c>
        printf("accept: from %d.%d.%d.%d:%d\n", 
 142:	f8c44a03          	lbu	s4,-116(s0)
 146:	f8d44c03          	lbu	s8,-115(s0)
 14a:	f8e44c83          	lbu	s9,-114(s0)
 14e:	f8f44d03          	lbu	s10,-113(s0)
               addr[0], addr[1], addr[2], addr[3], ntohs(peer.sin_port));
 152:	f8a45503          	lhu	a0,-118(s0)
 156:	348000ef          	jal	49e <ntohs>
        printf("accept: from %d.%d.%d.%d:%d\n", 
 15a:	0005079b          	sext.w	a5,a0
 15e:	876a                	mv	a4,s10
 160:	86e6                	mv	a3,s9
 162:	8662                	mv	a2,s8
 164:	85d2                	mv	a1,s4
 166:	00001517          	auipc	a0,0x1
 16a:	c7a50513          	add	a0,a0,-902 # de0 <malloc+0x1cc>
 16e:	1eb000ef          	jal	b58 <printf>
        int ret = recv(acc, buf, sizeof(buf) - 1);
 172:	7ff00613          	li	a2,2047
 176:	85da                	mv	a1,s6
 178:	8526                	mv	a0,s1
 17a:	644000ef          	jal	7be <recv>
        if (ret > 0) {
 17e:	00a04663          	bgtz	a0,18a <main+0x18a>
            }
        }
        
        close(acc);
 182:	8526                	mv	a0,s1
 184:	58a000ef          	jal	70e <close>
 188:	b745                	j	128 <main+0x128>
            buf[ret] = '\0';
 18a:	00aa87b3          	add	a5,s5,a0
 18e:	7e078423          	sb	zero,2024(a5)
            printf("recv: %d bytes\n", ret);
 192:	85aa                	mv	a1,a0
 194:	00001517          	auipc	a0,0x1
 198:	c6c50513          	add	a0,a0,-916 # e00 <malloc+0x1ec>
 19c:	1bd000ef          	jal	b58 <printf>
            if (buf[0] == 'G' && buf[1] == 'E' && buf[2] == 'T' && buf[3] == ' ') {
 1a0:	7e8ac703          	lbu	a4,2024(s5)
 1a4:	04700793          	li	a5,71
 1a8:	00f71863          	bne	a4,a5,1b8 <main+0x1b8>
 1ac:	7e9ac703          	lbu	a4,2025(s5)
 1b0:	04500793          	li	a5,69
 1b4:	00f70c63          	beq	a4,a5,1cc <main+0x1cc>
                send(acc, HTTP_RESPONSE_404, strlen(HTTP_RESPONSE_404));
 1b8:	855e                	mv	a0,s7
 1ba:	0a0000ef          	jal	25a <strlen>
 1be:	0005061b          	sext.w	a2,a0
 1c2:	85de                	mv	a1,s7
 1c4:	8526                	mv	a0,s1
 1c6:	600000ef          	jal	7c6 <send>
 1ca:	bf65                	j	182 <main+0x182>
            if (buf[0] == 'G' && buf[1] == 'E' && buf[2] == 'T' && buf[3] == ' ') {
 1cc:	7eaac703          	lbu	a4,2026(s5)
 1d0:	05400793          	li	a5,84
 1d4:	fef712e3          	bne	a4,a5,1b8 <main+0x1b8>
 1d8:	7ebac703          	lbu	a4,2027(s5)
 1dc:	02000793          	li	a5,32
 1e0:	fcf71ce3          	bne	a4,a5,1b8 <main+0x1b8>
                send(acc, HTTP_RESPONSE, strlen(HTTP_RESPONSE));
 1e4:	00001a17          	auipc	s4,0x1
 1e8:	e1ca0a13          	add	s4,s4,-484 # 1000 <HTTP_RESPONSE>
 1ec:	8552                	mv	a0,s4
 1ee:	06c000ef          	jal	25a <strlen>
 1f2:	0005061b          	sext.w	a2,a0
 1f6:	85d2                	mv	a1,s4
 1f8:	8526                	mv	a0,s1
 1fa:	5cc000ef          	jal	7c6 <send>
 1fe:	b751                	j	182 <main+0x182>

0000000000000200 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 200:	1141                	add	sp,sp,-16
 202:	e406                	sd	ra,8(sp)
 204:	e022                	sd	s0,0(sp)
 206:	0800                	add	s0,sp,16
  extern int main();
  main();
 208:	df9ff0ef          	jal	0 <main>
  exit(0);
 20c:	4501                	li	a0,0
 20e:	4d8000ef          	jal	6e6 <exit>

0000000000000212 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 212:	1141                	add	sp,sp,-16
 214:	e422                	sd	s0,8(sp)
 216:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 218:	87aa                	mv	a5,a0
 21a:	0585                	add	a1,a1,1
 21c:	0785                	add	a5,a5,1
 21e:	fff5c703          	lbu	a4,-1(a1)
 222:	fee78fa3          	sb	a4,-1(a5)
 226:	fb75                	bnez	a4,21a <strcpy+0x8>
    ;
  return os;
}
 228:	6422                	ld	s0,8(sp)
 22a:	0141                	add	sp,sp,16
 22c:	8082                	ret

000000000000022e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 22e:	1141                	add	sp,sp,-16
 230:	e422                	sd	s0,8(sp)
 232:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 234:	00054783          	lbu	a5,0(a0)
 238:	cb91                	beqz	a5,24c <strcmp+0x1e>
 23a:	0005c703          	lbu	a4,0(a1)
 23e:	00f71763          	bne	a4,a5,24c <strcmp+0x1e>
    p++, q++;
 242:	0505                	add	a0,a0,1
 244:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 246:	00054783          	lbu	a5,0(a0)
 24a:	fbe5                	bnez	a5,23a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 24c:	0005c503          	lbu	a0,0(a1)
}
 250:	40a7853b          	subw	a0,a5,a0
 254:	6422                	ld	s0,8(sp)
 256:	0141                	add	sp,sp,16
 258:	8082                	ret

000000000000025a <strlen>:

uint
strlen(const char *s)
{
 25a:	1141                	add	sp,sp,-16
 25c:	e422                	sd	s0,8(sp)
 25e:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 260:	00054783          	lbu	a5,0(a0)
 264:	cf91                	beqz	a5,280 <strlen+0x26>
 266:	0505                	add	a0,a0,1
 268:	87aa                	mv	a5,a0
 26a:	86be                	mv	a3,a5
 26c:	0785                	add	a5,a5,1
 26e:	fff7c703          	lbu	a4,-1(a5)
 272:	ff65                	bnez	a4,26a <strlen+0x10>
 274:	40a6853b          	subw	a0,a3,a0
 278:	2505                	addw	a0,a0,1
    ;
  return n;
}
 27a:	6422                	ld	s0,8(sp)
 27c:	0141                	add	sp,sp,16
 27e:	8082                	ret
  for(n = 0; s[n]; n++)
 280:	4501                	li	a0,0
 282:	bfe5                	j	27a <strlen+0x20>

0000000000000284 <memset>:

void*
memset(void *dst, int c, uint n)
{
 284:	1141                	add	sp,sp,-16
 286:	e422                	sd	s0,8(sp)
 288:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 28a:	ca19                	beqz	a2,2a0 <memset+0x1c>
 28c:	87aa                	mv	a5,a0
 28e:	1602                	sll	a2,a2,0x20
 290:	9201                	srl	a2,a2,0x20
 292:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 296:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 29a:	0785                	add	a5,a5,1
 29c:	fee79de3          	bne	a5,a4,296 <memset+0x12>
  }
  return dst;
}
 2a0:	6422                	ld	s0,8(sp)
 2a2:	0141                	add	sp,sp,16
 2a4:	8082                	ret

00000000000002a6 <strchr>:

char*
strchr(const char *s, char c)
{
 2a6:	1141                	add	sp,sp,-16
 2a8:	e422                	sd	s0,8(sp)
 2aa:	0800                	add	s0,sp,16
  for(; *s; s++)
 2ac:	00054783          	lbu	a5,0(a0)
 2b0:	cb99                	beqz	a5,2c6 <strchr+0x20>
    if(*s == c)
 2b2:	00f58763          	beq	a1,a5,2c0 <strchr+0x1a>
  for(; *s; s++)
 2b6:	0505                	add	a0,a0,1
 2b8:	00054783          	lbu	a5,0(a0)
 2bc:	fbfd                	bnez	a5,2b2 <strchr+0xc>
      return (char*)s;
  return 0;
 2be:	4501                	li	a0,0
}
 2c0:	6422                	ld	s0,8(sp)
 2c2:	0141                	add	sp,sp,16
 2c4:	8082                	ret
  return 0;
 2c6:	4501                	li	a0,0
 2c8:	bfe5                	j	2c0 <strchr+0x1a>

00000000000002ca <gets>:

char*
gets(char *buf, int max)
{
 2ca:	711d                	add	sp,sp,-96
 2cc:	ec86                	sd	ra,88(sp)
 2ce:	e8a2                	sd	s0,80(sp)
 2d0:	e4a6                	sd	s1,72(sp)
 2d2:	e0ca                	sd	s2,64(sp)
 2d4:	fc4e                	sd	s3,56(sp)
 2d6:	f852                	sd	s4,48(sp)
 2d8:	f456                	sd	s5,40(sp)
 2da:	f05a                	sd	s6,32(sp)
 2dc:	ec5e                	sd	s7,24(sp)
 2de:	1080                	add	s0,sp,96
 2e0:	8baa                	mv	s7,a0
 2e2:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2e4:	892a                	mv	s2,a0
 2e6:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2e8:	4aa9                	li	s5,10
 2ea:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 2ec:	89a6                	mv	s3,s1
 2ee:	2485                	addw	s1,s1,1
 2f0:	0344d663          	bge	s1,s4,31c <gets+0x52>
    cc = read(0, &c, 1);
 2f4:	4605                	li	a2,1
 2f6:	faf40593          	add	a1,s0,-81
 2fa:	4501                	li	a0,0
 2fc:	402000ef          	jal	6fe <read>
    if(cc < 1)
 300:	00a05e63          	blez	a0,31c <gets+0x52>
    buf[i++] = c;
 304:	faf44783          	lbu	a5,-81(s0)
 308:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 30c:	01578763          	beq	a5,s5,31a <gets+0x50>
 310:	0905                	add	s2,s2,1
 312:	fd679de3          	bne	a5,s6,2ec <gets+0x22>
    buf[i++] = c;
 316:	89a6                	mv	s3,s1
 318:	a011                	j	31c <gets+0x52>
 31a:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 31c:	99de                	add	s3,s3,s7
 31e:	00098023          	sb	zero,0(s3)
  return buf;
}
 322:	855e                	mv	a0,s7
 324:	60e6                	ld	ra,88(sp)
 326:	6446                	ld	s0,80(sp)
 328:	64a6                	ld	s1,72(sp)
 32a:	6906                	ld	s2,64(sp)
 32c:	79e2                	ld	s3,56(sp)
 32e:	7a42                	ld	s4,48(sp)
 330:	7aa2                	ld	s5,40(sp)
 332:	7b02                	ld	s6,32(sp)
 334:	6be2                	ld	s7,24(sp)
 336:	6125                	add	sp,sp,96
 338:	8082                	ret

000000000000033a <stat>:

int
stat(const char *n, struct stat *st)
{
 33a:	1101                	add	sp,sp,-32
 33c:	ec06                	sd	ra,24(sp)
 33e:	e822                	sd	s0,16(sp)
 340:	e04a                	sd	s2,0(sp)
 342:	1000                	add	s0,sp,32
 344:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 346:	4581                	li	a1,0
 348:	3de000ef          	jal	726 <open>
  if(fd < 0)
 34c:	02054263          	bltz	a0,370 <stat+0x36>
 350:	e426                	sd	s1,8(sp)
 352:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 354:	85ca                	mv	a1,s2
 356:	3e8000ef          	jal	73e <fstat>
 35a:	892a                	mv	s2,a0
  close(fd);
 35c:	8526                	mv	a0,s1
 35e:	3b0000ef          	jal	70e <close>
  return r;
 362:	64a2                	ld	s1,8(sp)
}
 364:	854a                	mv	a0,s2
 366:	60e2                	ld	ra,24(sp)
 368:	6442                	ld	s0,16(sp)
 36a:	6902                	ld	s2,0(sp)
 36c:	6105                	add	sp,sp,32
 36e:	8082                	ret
    return -1;
 370:	597d                	li	s2,-1
 372:	bfcd                	j	364 <stat+0x2a>

0000000000000374 <atoi>:

int
atoi(const char *s)
{
 374:	1141                	add	sp,sp,-16
 376:	e422                	sd	s0,8(sp)
 378:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 37a:	00054683          	lbu	a3,0(a0)
 37e:	fd06879b          	addw	a5,a3,-48
 382:	0ff7f793          	zext.b	a5,a5
 386:	4625                	li	a2,9
 388:	02f66863          	bltu	a2,a5,3b8 <atoi+0x44>
 38c:	872a                	mv	a4,a0
  n = 0;
 38e:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 390:	0705                	add	a4,a4,1
 392:	0025179b          	sllw	a5,a0,0x2
 396:	9fa9                	addw	a5,a5,a0
 398:	0017979b          	sllw	a5,a5,0x1
 39c:	9fb5                	addw	a5,a5,a3
 39e:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 3a2:	00074683          	lbu	a3,0(a4)
 3a6:	fd06879b          	addw	a5,a3,-48
 3aa:	0ff7f793          	zext.b	a5,a5
 3ae:	fef671e3          	bgeu	a2,a5,390 <atoi+0x1c>
  return n;
}
 3b2:	6422                	ld	s0,8(sp)
 3b4:	0141                	add	sp,sp,16
 3b6:	8082                	ret
  n = 0;
 3b8:	4501                	li	a0,0
 3ba:	bfe5                	j	3b2 <atoi+0x3e>

00000000000003bc <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3bc:	1141                	add	sp,sp,-16
 3be:	e422                	sd	s0,8(sp)
 3c0:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 3c2:	02b57463          	bgeu	a0,a1,3ea <memmove+0x2e>
    while(n-- > 0)
 3c6:	00c05f63          	blez	a2,3e4 <memmove+0x28>
 3ca:	1602                	sll	a2,a2,0x20
 3cc:	9201                	srl	a2,a2,0x20
 3ce:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 3d2:	872a                	mv	a4,a0
      *dst++ = *src++;
 3d4:	0585                	add	a1,a1,1
 3d6:	0705                	add	a4,a4,1
 3d8:	fff5c683          	lbu	a3,-1(a1)
 3dc:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 3e0:	fef71ae3          	bne	a4,a5,3d4 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3e4:	6422                	ld	s0,8(sp)
 3e6:	0141                	add	sp,sp,16
 3e8:	8082                	ret
    dst += n;
 3ea:	00c50733          	add	a4,a0,a2
    src += n;
 3ee:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3f0:	fec05ae3          	blez	a2,3e4 <memmove+0x28>
 3f4:	fff6079b          	addw	a5,a2,-1
 3f8:	1782                	sll	a5,a5,0x20
 3fa:	9381                	srl	a5,a5,0x20
 3fc:	fff7c793          	not	a5,a5
 400:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 402:	15fd                	add	a1,a1,-1
 404:	177d                	add	a4,a4,-1
 406:	0005c683          	lbu	a3,0(a1)
 40a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 40e:	fee79ae3          	bne	a5,a4,402 <memmove+0x46>
 412:	bfc9                	j	3e4 <memmove+0x28>

0000000000000414 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 414:	1141                	add	sp,sp,-16
 416:	e422                	sd	s0,8(sp)
 418:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 41a:	ca05                	beqz	a2,44a <memcmp+0x36>
 41c:	fff6069b          	addw	a3,a2,-1
 420:	1682                	sll	a3,a3,0x20
 422:	9281                	srl	a3,a3,0x20
 424:	0685                	add	a3,a3,1
 426:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 428:	00054783          	lbu	a5,0(a0)
 42c:	0005c703          	lbu	a4,0(a1)
 430:	00e79863          	bne	a5,a4,440 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 434:	0505                	add	a0,a0,1
    p2++;
 436:	0585                	add	a1,a1,1
  while (n-- > 0) {
 438:	fed518e3          	bne	a0,a3,428 <memcmp+0x14>
  }
  return 0;
 43c:	4501                	li	a0,0
 43e:	a019                	j	444 <memcmp+0x30>
      return *p1 - *p2;
 440:	40e7853b          	subw	a0,a5,a4
}
 444:	6422                	ld	s0,8(sp)
 446:	0141                	add	sp,sp,16
 448:	8082                	ret
  return 0;
 44a:	4501                	li	a0,0
 44c:	bfe5                	j	444 <memcmp+0x30>

000000000000044e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 44e:	1141                	add	sp,sp,-16
 450:	e406                	sd	ra,8(sp)
 452:	e022                	sd	s0,0(sp)
 454:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 456:	f67ff0ef          	jal	3bc <memmove>
}
 45a:	60a2                	ld	ra,8(sp)
 45c:	6402                	ld	s0,0(sp)
 45e:	0141                	add	sp,sp,16
 460:	8082                	ret

0000000000000462 <htons>:
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
}

uint16_t
htons(uint16_t h)
{
 462:	1141                	add	sp,sp,-16
 464:	e422                	sd	s0,8(sp)
 466:	0800                	add	s0,sp,16
    if (!endian) {
 468:	00001797          	auipc	a5,0x1
 46c:	c487a783          	lw	a5,-952(a5) # 10b0 <endian>
 470:	e385                	bnez	a5,490 <htons+0x2e>
        endian = byteorder();
 472:	4d200793          	li	a5,1234
 476:	00001717          	auipc	a4,0x1
 47a:	c2f72d23          	sw	a5,-966(a4) # 10b0 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 47e:	0085179b          	sllw	a5,a0,0x8
 482:	0085551b          	srlw	a0,a0,0x8
 486:	8fc9                	or	a5,a5,a0
 488:	03079513          	sll	a0,a5,0x30
 48c:	9141                	srl	a0,a0,0x30
 48e:	a029                	j	498 <htons+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(h) : h;
 490:	4d200713          	li	a4,1234
 494:	fee785e3          	beq	a5,a4,47e <htons+0x1c>
}
 498:	6422                	ld	s0,8(sp)
 49a:	0141                	add	sp,sp,16
 49c:	8082                	ret

000000000000049e <ntohs>:

uint16_t
ntohs(uint16_t n)
{
 49e:	1141                	add	sp,sp,-16
 4a0:	e422                	sd	s0,8(sp)
 4a2:	0800                	add	s0,sp,16
    if (!endian) {
 4a4:	00001797          	auipc	a5,0x1
 4a8:	c0c7a783          	lw	a5,-1012(a5) # 10b0 <endian>
 4ac:	e385                	bnez	a5,4cc <ntohs+0x2e>
        endian = byteorder();
 4ae:	4d200793          	li	a5,1234
 4b2:	00001717          	auipc	a4,0x1
 4b6:	bef72f23          	sw	a5,-1026(a4) # 10b0 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 4ba:	0085179b          	sllw	a5,a0,0x8
 4be:	0085551b          	srlw	a0,a0,0x8
 4c2:	8fc9                	or	a5,a5,a0
 4c4:	03079513          	sll	a0,a5,0x30
 4c8:	9141                	srl	a0,a0,0x30
 4ca:	a029                	j	4d4 <ntohs+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(n) : n;
 4cc:	4d200713          	li	a4,1234
 4d0:	fee785e3          	beq	a5,a4,4ba <ntohs+0x1c>
}
 4d4:	6422                	ld	s0,8(sp)
 4d6:	0141                	add	sp,sp,16
 4d8:	8082                	ret

00000000000004da <htonl>:

uint32_t
htonl(uint32_t h)
{
 4da:	1141                	add	sp,sp,-16
 4dc:	e422                	sd	s0,8(sp)
 4de:	0800                	add	s0,sp,16
    if (!endian) {
 4e0:	00001797          	auipc	a5,0x1
 4e4:	bd07a783          	lw	a5,-1072(a5) # 10b0 <endian>
 4e8:	ef85                	bnez	a5,520 <htonl+0x46>
        endian = byteorder();
 4ea:	4d200793          	li	a5,1234
 4ee:	00001717          	auipc	a4,0x1
 4f2:	bcf72123          	sw	a5,-1086(a4) # 10b0 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 4f6:	0185179b          	sllw	a5,a0,0x18
 4fa:	0185571b          	srlw	a4,a0,0x18
 4fe:	8fd9                	or	a5,a5,a4
 500:	0085171b          	sllw	a4,a0,0x8
 504:	00ff06b7          	lui	a3,0xff0
 508:	8f75                	and	a4,a4,a3
 50a:	8fd9                	or	a5,a5,a4
 50c:	0085551b          	srlw	a0,a0,0x8
 510:	6741                	lui	a4,0x10
 512:	f0070713          	add	a4,a4,-256 # ff00 <base+0xee40>
 516:	8d79                	and	a0,a0,a4
 518:	8fc9                	or	a5,a5,a0
 51a:	0007851b          	sext.w	a0,a5
 51e:	a029                	j	528 <htonl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(h) : h;
 520:	4d200713          	li	a4,1234
 524:	fce789e3          	beq	a5,a4,4f6 <htonl+0x1c>
}
 528:	6422                	ld	s0,8(sp)
 52a:	0141                	add	sp,sp,16
 52c:	8082                	ret

000000000000052e <ntohl>:

uint32_t
ntohl(uint32_t n)
{
 52e:	1141                	add	sp,sp,-16
 530:	e422                	sd	s0,8(sp)
 532:	0800                	add	s0,sp,16
    if (!endian) {
 534:	00001797          	auipc	a5,0x1
 538:	b7c7a783          	lw	a5,-1156(a5) # 10b0 <endian>
 53c:	ef85                	bnez	a5,574 <ntohl+0x46>
        endian = byteorder();
 53e:	4d200793          	li	a5,1234
 542:	00001717          	auipc	a4,0x1
 546:	b6f72723          	sw	a5,-1170(a4) # 10b0 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 54a:	0185179b          	sllw	a5,a0,0x18
 54e:	0185571b          	srlw	a4,a0,0x18
 552:	8fd9                	or	a5,a5,a4
 554:	0085171b          	sllw	a4,a0,0x8
 558:	00ff06b7          	lui	a3,0xff0
 55c:	8f75                	and	a4,a4,a3
 55e:	8fd9                	or	a5,a5,a4
 560:	0085551b          	srlw	a0,a0,0x8
 564:	6741                	lui	a4,0x10
 566:	f0070713          	add	a4,a4,-256 # ff00 <base+0xee40>
 56a:	8d79                	and	a0,a0,a4
 56c:	8fc9                	or	a5,a5,a0
 56e:	0007851b          	sext.w	a0,a5
 572:	a029                	j	57c <ntohl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(n) : n;
 574:	4d200713          	li	a4,1234
 578:	fce789e3          	beq	a5,a4,54a <ntohl+0x1c>
}
 57c:	6422                	ld	s0,8(sp)
 57e:	0141                	add	sp,sp,16
 580:	8082                	ret

0000000000000582 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
 582:	1141                	add	sp,sp,-16
 584:	e422                	sd	s0,8(sp)
 586:	0800                	add	s0,sp,16
 588:	872a                	mv	a4,a0
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
 58a:	02000693          	li	a3,32
 58e:	4525                	li	a0,9
 590:	a011                	j	594 <strtol+0x12>
        s++;
 592:	0705                	add	a4,a4,1
    while (*s == ' ' || *s == '\t')
 594:	00074783          	lbu	a5,0(a4)
 598:	fed78de3          	beq	a5,a3,592 <strtol+0x10>
 59c:	fea78be3          	beq	a5,a0,592 <strtol+0x10>

    // plus/minus sign
    if (*s == '+')
 5a0:	02b00693          	li	a3,43
 5a4:	02d78663          	beq	a5,a3,5d0 <strtol+0x4e>
        s++;
    else if (*s == '-')
 5a8:	02d00693          	li	a3,45
    int neg = 0;
 5ac:	4301                	li	t1,0
    else if (*s == '-')
 5ae:	02d78463          	beq	a5,a3,5d6 <strtol+0x54>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 5b2:	fef67793          	and	a5,a2,-17
 5b6:	eb89                	bnez	a5,5c8 <strtol+0x46>
 5b8:	00074683          	lbu	a3,0(a4)
 5bc:	03000793          	li	a5,48
 5c0:	00f68e63          	beq	a3,a5,5dc <strtol+0x5a>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
 5c4:	e211                	bnez	a2,5c8 <strtol+0x46>
        s++, base = 8;
    else if (base == 0)
        base = 10;
 5c6:	4629                	li	a2,10
 5c8:	4501                	li	a0,0

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
 5ca:	4825                	li	a6,9
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
 5cc:	48e5                	li	a7,25
 5ce:	a825                	j	606 <strtol+0x84>
        s++;
 5d0:	0705                	add	a4,a4,1
    int neg = 0;
 5d2:	4301                	li	t1,0
 5d4:	bff9                	j	5b2 <strtol+0x30>
        s++, neg = 1;
 5d6:	0705                	add	a4,a4,1
 5d8:	4305                	li	t1,1
 5da:	bfe1                	j	5b2 <strtol+0x30>
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 5dc:	00174683          	lbu	a3,1(a4)
 5e0:	07800793          	li	a5,120
 5e4:	00f68663          	beq	a3,a5,5f0 <strtol+0x6e>
    else if (base == 0 && s[0] == '0')
 5e8:	f265                	bnez	a2,5c8 <strtol+0x46>
        s++, base = 8;
 5ea:	0705                	add	a4,a4,1
 5ec:	4621                	li	a2,8
 5ee:	bfe9                	j	5c8 <strtol+0x46>
        s += 2, base = 16;
 5f0:	0709                	add	a4,a4,2
 5f2:	4641                	li	a2,16
 5f4:	bfd1                	j	5c8 <strtol+0x46>
            dig = *s - '0';
 5f6:	fd07879b          	addw	a5,a5,-48
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
 5fa:	04c7d063          	bge	a5,a2,63a <strtol+0xb8>
            break;
        s++, val = (val * base) + dig;
 5fe:	0705                	add	a4,a4,1
 600:	02a60533          	mul	a0,a2,a0
 604:	953e                	add	a0,a0,a5
        if (*s >= '0' && *s <= '9')
 606:	00074783          	lbu	a5,0(a4)
 60a:	fd07869b          	addw	a3,a5,-48
 60e:	0ff6f693          	zext.b	a3,a3
 612:	fed872e3          	bgeu	a6,a3,5f6 <strtol+0x74>
        else if (*s >= 'a' && *s <= 'z')
 616:	f9f7869b          	addw	a3,a5,-97
 61a:	0ff6f693          	zext.b	a3,a3
 61e:	00d8e563          	bltu	a7,a3,628 <strtol+0xa6>
            dig = *s - 'a' + 10;
 622:	fa97879b          	addw	a5,a5,-87
 626:	bfd1                	j	5fa <strtol+0x78>
        else if (*s >= 'A' && *s <= 'Z')
 628:	fbf7869b          	addw	a3,a5,-65
 62c:	0ff6f693          	zext.b	a3,a3
 630:	00d8e563          	bltu	a7,a3,63a <strtol+0xb8>
            dig = *s - 'A' + 10;
 634:	fc97879b          	addw	a5,a5,-55
 638:	b7c9                	j	5fa <strtol+0x78>
        // we don't properly detect overflow!
    }

    if (endptr)
 63a:	c191                	beqz	a1,63e <strtol+0xbc>
        *endptr = (char *) s;
 63c:	e198                	sd	a4,0(a1)
    return (neg ? -val : val);
 63e:	00030463          	beqz	t1,646 <strtol+0xc4>
 642:	40a00533          	neg	a0,a0
}
 646:	6422                	ld	s0,8(sp)
 648:	0141                	add	sp,sp,16
 64a:	8082                	ret

000000000000064c <inet_pton>:
inet_pton (int family, const char *p, void *n) {
    char *sp, *ep;
    int idx;
    long ret;

    if (family != AF_INET) {
 64c:	4785                	li	a5,1
 64e:	08f51063          	bne	a0,a5,6ce <inet_pton+0x82>
inet_pton (int family, const char *p, void *n) {
 652:	715d                	add	sp,sp,-80
 654:	e486                	sd	ra,72(sp)
 656:	e0a2                	sd	s0,64(sp)
 658:	fc26                	sd	s1,56(sp)
 65a:	f84a                	sd	s2,48(sp)
 65c:	f44e                	sd	s3,40(sp)
 65e:	f052                	sd	s4,32(sp)
 660:	ec56                	sd	s5,24(sp)
 662:	e85a                	sd	s6,16(sp)
 664:	0880                	add	s0,sp,80
 666:	84ae                	mv	s1,a1
 668:	89b2                	mv	s3,a2
 66a:	4901                	li	s2,0
        return -1;
    }
    sp = (char *)p;
    for (idx = 0; idx < 4; idx++) {
        ret = strtol(sp, &ep, 10);
        if (ret < 0 || ret > 255) {
 66c:	0ff00a13          	li	s4,255
            return -1;
        }
        if (ep == sp) {
            return -1;
        }
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 670:	4a8d                	li	s5,3
 672:	02e00b13          	li	s6,46
 676:	a805                	j	6a6 <inet_pton+0x5a>
 678:	0007c783          	lbu	a5,0(a5)
 67c:	efb9                	bnez	a5,6da <inet_pton+0x8e>
            return -1;
        }
        ((uint8_t *)n)[idx] = ret;
 67e:	00a981a3          	sb	a0,3(s3)
        sp = ep + 1;
    }
    return 0;
 682:	4501                	li	a0,0
}
 684:	60a6                	ld	ra,72(sp)
 686:	6406                	ld	s0,64(sp)
 688:	74e2                	ld	s1,56(sp)
 68a:	7942                	ld	s2,48(sp)
 68c:	79a2                	ld	s3,40(sp)
 68e:	7a02                	ld	s4,32(sp)
 690:	6ae2                	ld	s5,24(sp)
 692:	6b42                	ld	s6,16(sp)
 694:	6161                	add	sp,sp,80
 696:	8082                	ret
        ((uint8_t *)n)[idx] = ret;
 698:	01298733          	add	a4,s3,s2
 69c:	00a70023          	sb	a0,0(a4)
        sp = ep + 1;
 6a0:	00178493          	add	s1,a5,1
    for (idx = 0; idx < 4; idx++) {
 6a4:	0905                	add	s2,s2,1
        ret = strtol(sp, &ep, 10);
 6a6:	4629                	li	a2,10
 6a8:	fb840593          	add	a1,s0,-72
 6ac:	8526                	mv	a0,s1
 6ae:	ed5ff0ef          	jal	582 <strtol>
        if (ret < 0 || ret > 255) {
 6b2:	02aa6063          	bltu	s4,a0,6d2 <inet_pton+0x86>
        if (ep == sp) {
 6b6:	fb843783          	ld	a5,-72(s0)
 6ba:	00978e63          	beq	a5,s1,6d6 <inet_pton+0x8a>
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 6be:	fb590de3          	beq	s2,s5,678 <inet_pton+0x2c>
 6c2:	0007c703          	lbu	a4,0(a5)
 6c6:	fd6709e3          	beq	a4,s6,698 <inet_pton+0x4c>
            return -1;
 6ca:	557d                	li	a0,-1
 6cc:	bf65                	j	684 <inet_pton+0x38>
        return -1;
 6ce:	557d                	li	a0,-1
}
 6d0:	8082                	ret
            return -1;
 6d2:	557d                	li	a0,-1
 6d4:	bf45                	j	684 <inet_pton+0x38>
            return -1;
 6d6:	557d                	li	a0,-1
 6d8:	b775                	j	684 <inet_pton+0x38>
            return -1;
 6da:	557d                	li	a0,-1
 6dc:	b765                	j	684 <inet_pton+0x38>

00000000000006de <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 6de:	4885                	li	a7,1
 ecall
 6e0:	00000073          	ecall
 ret
 6e4:	8082                	ret

00000000000006e6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 6e6:	4889                	li	a7,2
 ecall
 6e8:	00000073          	ecall
 ret
 6ec:	8082                	ret

00000000000006ee <wait>:
.global wait
wait:
 li a7, SYS_wait
 6ee:	488d                	li	a7,3
 ecall
 6f0:	00000073          	ecall
 ret
 6f4:	8082                	ret

00000000000006f6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 6f6:	4891                	li	a7,4
 ecall
 6f8:	00000073          	ecall
 ret
 6fc:	8082                	ret

00000000000006fe <read>:
.global read
read:
 li a7, SYS_read
 6fe:	4895                	li	a7,5
 ecall
 700:	00000073          	ecall
 ret
 704:	8082                	ret

0000000000000706 <write>:
.global write
write:
 li a7, SYS_write
 706:	48c1                	li	a7,16
 ecall
 708:	00000073          	ecall
 ret
 70c:	8082                	ret

000000000000070e <close>:
.global close
close:
 li a7, SYS_close
 70e:	48d5                	li	a7,21
 ecall
 710:	00000073          	ecall
 ret
 714:	8082                	ret

0000000000000716 <kill>:
.global kill
kill:
 li a7, SYS_kill
 716:	4899                	li	a7,6
 ecall
 718:	00000073          	ecall
 ret
 71c:	8082                	ret

000000000000071e <exec>:
.global exec
exec:
 li a7, SYS_exec
 71e:	489d                	li	a7,7
 ecall
 720:	00000073          	ecall
 ret
 724:	8082                	ret

0000000000000726 <open>:
.global open
open:
 li a7, SYS_open
 726:	48bd                	li	a7,15
 ecall
 728:	00000073          	ecall
 ret
 72c:	8082                	ret

000000000000072e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 72e:	48c5                	li	a7,17
 ecall
 730:	00000073          	ecall
 ret
 734:	8082                	ret

0000000000000736 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 736:	48c9                	li	a7,18
 ecall
 738:	00000073          	ecall
 ret
 73c:	8082                	ret

000000000000073e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 73e:	48a1                	li	a7,8
 ecall
 740:	00000073          	ecall
 ret
 744:	8082                	ret

0000000000000746 <link>:
.global link
link:
 li a7, SYS_link
 746:	48cd                	li	a7,19
 ecall
 748:	00000073          	ecall
 ret
 74c:	8082                	ret

000000000000074e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 74e:	48d1                	li	a7,20
 ecall
 750:	00000073          	ecall
 ret
 754:	8082                	ret

0000000000000756 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 756:	48a5                	li	a7,9
 ecall
 758:	00000073          	ecall
 ret
 75c:	8082                	ret

000000000000075e <dup>:
.global dup
dup:
 li a7, SYS_dup
 75e:	48a9                	li	a7,10
 ecall
 760:	00000073          	ecall
 ret
 764:	8082                	ret

0000000000000766 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 766:	48ad                	li	a7,11
 ecall
 768:	00000073          	ecall
 ret
 76c:	8082                	ret

000000000000076e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 76e:	48b1                	li	a7,12
 ecall
 770:	00000073          	ecall
 ret
 774:	8082                	ret

0000000000000776 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 776:	48b5                	li	a7,13
 ecall
 778:	00000073          	ecall
 ret
 77c:	8082                	ret

000000000000077e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 77e:	48b9                	li	a7,14
 ecall
 780:	00000073          	ecall
 ret
 784:	8082                	ret

0000000000000786 <socket>:
.global socket
socket:
 li a7, SYS_socket
 786:	48d9                	li	a7,22
 ecall
 788:	00000073          	ecall
 ret
 78c:	8082                	ret

000000000000078e <bind>:
.global bind
bind:
 li a7, SYS_bind
 78e:	48dd                	li	a7,23
 ecall
 790:	00000073          	ecall
 ret
 794:	8082                	ret

0000000000000796 <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 796:	48e1                	li	a7,24
 ecall
 798:	00000073          	ecall
 ret
 79c:	8082                	ret

000000000000079e <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 79e:	48e5                	li	a7,25
 ecall
 7a0:	00000073          	ecall
 ret
 7a4:	8082                	ret

00000000000007a6 <connect>:
.global connect
connect:
 li a7, SYS_connect
 7a6:	48e9                	li	a7,26
 ecall
 7a8:	00000073          	ecall
 ret
 7ac:	8082                	ret

00000000000007ae <listen>:
.global listen
listen:
 li a7, SYS_listen
 7ae:	48ed                	li	a7,27
 ecall
 7b0:	00000073          	ecall
 ret
 7b4:	8082                	ret

00000000000007b6 <accept>:
.global accept
accept:
 li a7, SYS_accept
 7b6:	48f1                	li	a7,28
 ecall
 7b8:	00000073          	ecall
 ret
 7bc:	8082                	ret

00000000000007be <recv>:
.global recv
recv:
 li a7, SYS_recv
 7be:	48f5                	li	a7,29
 ecall
 7c0:	00000073          	ecall
 ret
 7c4:	8082                	ret

00000000000007c6 <send>:
.global send
send:
 li a7, SYS_send
 7c6:	48f9                	li	a7,30
 ecall
 7c8:	00000073          	ecall
 ret
 7cc:	8082                	ret

00000000000007ce <ioctl>:
.global ioctl
ioctl:
 li a7, SYS_ioctl
 7ce:	48fd                	li	a7,31
 ecall
 7d0:	00000073          	ecall
 ret
 7d4:	8082                	ret

00000000000007d6 <consolemode>:
.global consolemode
consolemode:
 li a7, SYS_consolemode
 7d6:	02000893          	li	a7,32
 ecall
 7da:	00000073          	ecall
 ret
 7de:	8082                	ret

00000000000007e0 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 7e0:	1101                	add	sp,sp,-32
 7e2:	ec06                	sd	ra,24(sp)
 7e4:	e822                	sd	s0,16(sp)
 7e6:	1000                	add	s0,sp,32
 7e8:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 7ec:	4605                	li	a2,1
 7ee:	fef40593          	add	a1,s0,-17
 7f2:	f15ff0ef          	jal	706 <write>
}
 7f6:	60e2                	ld	ra,24(sp)
 7f8:	6442                	ld	s0,16(sp)
 7fa:	6105                	add	sp,sp,32
 7fc:	8082                	ret

00000000000007fe <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 7fe:	715d                	add	sp,sp,-80
 800:	e486                	sd	ra,72(sp)
 802:	e0a2                	sd	s0,64(sp)
 804:	fc26                	sd	s1,56(sp)
 806:	0880                	add	s0,sp,80
 808:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 80a:	c299                	beqz	a3,810 <printint+0x12>
 80c:	0805c963          	bltz	a1,89e <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 810:	2581                	sext.w	a1,a1
  neg = 0;
 812:	4881                	li	a7,0
 814:	fb840693          	add	a3,s0,-72
  }

  i = 0;
 818:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 81a:	2601                	sext.w	a2,a2
 81c:	00000517          	auipc	a0,0x0
 820:	5fc50513          	add	a0,a0,1532 # e18 <digits>
 824:	883a                	mv	a6,a4
 826:	2705                	addw	a4,a4,1
 828:	02c5f7bb          	remuw	a5,a1,a2
 82c:	1782                	sll	a5,a5,0x20
 82e:	9381                	srl	a5,a5,0x20
 830:	97aa                	add	a5,a5,a0
 832:	0007c783          	lbu	a5,0(a5)
 836:	00f68023          	sb	a5,0(a3) # ff0000 <base+0xfeef40>
  }while((x /= base) != 0);
 83a:	0005879b          	sext.w	a5,a1
 83e:	02c5d5bb          	divuw	a1,a1,a2
 842:	0685                	add	a3,a3,1
 844:	fec7f0e3          	bgeu	a5,a2,824 <printint+0x26>
  if(neg)
 848:	00088c63          	beqz	a7,860 <printint+0x62>
    buf[i++] = '-';
 84c:	fd070793          	add	a5,a4,-48
 850:	00878733          	add	a4,a5,s0
 854:	02d00793          	li	a5,45
 858:	fef70423          	sb	a5,-24(a4)
 85c:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 860:	02e05a63          	blez	a4,894 <printint+0x96>
 864:	f84a                	sd	s2,48(sp)
 866:	f44e                	sd	s3,40(sp)
 868:	fb840793          	add	a5,s0,-72
 86c:	00e78933          	add	s2,a5,a4
 870:	fff78993          	add	s3,a5,-1
 874:	99ba                	add	s3,s3,a4
 876:	377d                	addw	a4,a4,-1
 878:	1702                	sll	a4,a4,0x20
 87a:	9301                	srl	a4,a4,0x20
 87c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 880:	fff94583          	lbu	a1,-1(s2)
 884:	8526                	mv	a0,s1
 886:	f5bff0ef          	jal	7e0 <putc>
  while(--i >= 0)
 88a:	197d                	add	s2,s2,-1
 88c:	ff391ae3          	bne	s2,s3,880 <printint+0x82>
 890:	7942                	ld	s2,48(sp)
 892:	79a2                	ld	s3,40(sp)
}
 894:	60a6                	ld	ra,72(sp)
 896:	6406                	ld	s0,64(sp)
 898:	74e2                	ld	s1,56(sp)
 89a:	6161                	add	sp,sp,80
 89c:	8082                	ret
    x = -xx;
 89e:	40b005bb          	negw	a1,a1
    neg = 1;
 8a2:	4885                	li	a7,1
    x = -xx;
 8a4:	bf85                	j	814 <printint+0x16>

00000000000008a6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 8a6:	711d                	add	sp,sp,-96
 8a8:	ec86                	sd	ra,88(sp)
 8aa:	e8a2                	sd	s0,80(sp)
 8ac:	e0ca                	sd	s2,64(sp)
 8ae:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 8b0:	0005c903          	lbu	s2,0(a1)
 8b4:	26090863          	beqz	s2,b24 <vprintf+0x27e>
 8b8:	e4a6                	sd	s1,72(sp)
 8ba:	fc4e                	sd	s3,56(sp)
 8bc:	f852                	sd	s4,48(sp)
 8be:	f456                	sd	s5,40(sp)
 8c0:	f05a                	sd	s6,32(sp)
 8c2:	ec5e                	sd	s7,24(sp)
 8c4:	e862                	sd	s8,16(sp)
 8c6:	e466                	sd	s9,8(sp)
 8c8:	8b2a                	mv	s6,a0
 8ca:	8a2e                	mv	s4,a1
 8cc:	8bb2                	mv	s7,a2
  state = 0;
 8ce:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 8d0:	4481                	li	s1,0
 8d2:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 8d4:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 8d8:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 8dc:	06c00c93          	li	s9,108
 8e0:	a005                	j	900 <vprintf+0x5a>
        putc(fd, c0);
 8e2:	85ca                	mv	a1,s2
 8e4:	855a                	mv	a0,s6
 8e6:	efbff0ef          	jal	7e0 <putc>
 8ea:	a019                	j	8f0 <vprintf+0x4a>
    } else if(state == '%'){
 8ec:	03598263          	beq	s3,s5,910 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 8f0:	2485                	addw	s1,s1,1
 8f2:	8726                	mv	a4,s1
 8f4:	009a07b3          	add	a5,s4,s1
 8f8:	0007c903          	lbu	s2,0(a5)
 8fc:	20090c63          	beqz	s2,b14 <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 900:	0009079b          	sext.w	a5,s2
    if(state == 0){
 904:	fe0994e3          	bnez	s3,8ec <vprintf+0x46>
      if(c0 == '%'){
 908:	fd579de3          	bne	a5,s5,8e2 <vprintf+0x3c>
        state = '%';
 90c:	89be                	mv	s3,a5
 90e:	b7cd                	j	8f0 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 910:	00ea06b3          	add	a3,s4,a4
 914:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 918:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 91a:	c681                	beqz	a3,922 <vprintf+0x7c>
 91c:	9752                	add	a4,a4,s4
 91e:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 922:	03878f63          	beq	a5,s8,960 <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 926:	05978963          	beq	a5,s9,978 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 92a:	07500713          	li	a4,117
 92e:	0ee78363          	beq	a5,a4,a14 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 932:	07800713          	li	a4,120
 936:	12e78563          	beq	a5,a4,a60 <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 93a:	07000713          	li	a4,112
 93e:	14e78a63          	beq	a5,a4,a92 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 942:	07300713          	li	a4,115
 946:	18e78a63          	beq	a5,a4,ada <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 94a:	02500713          	li	a4,37
 94e:	04e79563          	bne	a5,a4,998 <vprintf+0xf2>
        putc(fd, '%');
 952:	02500593          	li	a1,37
 956:	855a                	mv	a0,s6
 958:	e89ff0ef          	jal	7e0 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 95c:	4981                	li	s3,0
 95e:	bf49                	j	8f0 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 960:	008b8913          	add	s2,s7,8
 964:	4685                	li	a3,1
 966:	4629                	li	a2,10
 968:	000ba583          	lw	a1,0(s7)
 96c:	855a                	mv	a0,s6
 96e:	e91ff0ef          	jal	7fe <printint>
 972:	8bca                	mv	s7,s2
      state = 0;
 974:	4981                	li	s3,0
 976:	bfad                	j	8f0 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 978:	06400793          	li	a5,100
 97c:	02f68963          	beq	a3,a5,9ae <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 980:	06c00793          	li	a5,108
 984:	04f68263          	beq	a3,a5,9c8 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 988:	07500793          	li	a5,117
 98c:	0af68063          	beq	a3,a5,a2c <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 990:	07800793          	li	a5,120
 994:	0ef68263          	beq	a3,a5,a78 <vprintf+0x1d2>
        putc(fd, '%');
 998:	02500593          	li	a1,37
 99c:	855a                	mv	a0,s6
 99e:	e43ff0ef          	jal	7e0 <putc>
        putc(fd, c0);
 9a2:	85ca                	mv	a1,s2
 9a4:	855a                	mv	a0,s6
 9a6:	e3bff0ef          	jal	7e0 <putc>
      state = 0;
 9aa:	4981                	li	s3,0
 9ac:	b791                	j	8f0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 9ae:	008b8913          	add	s2,s7,8
 9b2:	4685                	li	a3,1
 9b4:	4629                	li	a2,10
 9b6:	000bb583          	ld	a1,0(s7)
 9ba:	855a                	mv	a0,s6
 9bc:	e43ff0ef          	jal	7fe <printint>
        i += 1;
 9c0:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 9c2:	8bca                	mv	s7,s2
      state = 0;
 9c4:	4981                	li	s3,0
        i += 1;
 9c6:	b72d                	j	8f0 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 9c8:	06400793          	li	a5,100
 9cc:	02f60763          	beq	a2,a5,9fa <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 9d0:	07500793          	li	a5,117
 9d4:	06f60963          	beq	a2,a5,a46 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 9d8:	07800793          	li	a5,120
 9dc:	faf61ee3          	bne	a2,a5,998 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 9e0:	008b8913          	add	s2,s7,8
 9e4:	4681                	li	a3,0
 9e6:	4641                	li	a2,16
 9e8:	000bb583          	ld	a1,0(s7)
 9ec:	855a                	mv	a0,s6
 9ee:	e11ff0ef          	jal	7fe <printint>
        i += 2;
 9f2:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 9f4:	8bca                	mv	s7,s2
      state = 0;
 9f6:	4981                	li	s3,0
        i += 2;
 9f8:	bde5                	j	8f0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 9fa:	008b8913          	add	s2,s7,8
 9fe:	4685                	li	a3,1
 a00:	4629                	li	a2,10
 a02:	000bb583          	ld	a1,0(s7)
 a06:	855a                	mv	a0,s6
 a08:	df7ff0ef          	jal	7fe <printint>
        i += 2;
 a0c:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 a0e:	8bca                	mv	s7,s2
      state = 0;
 a10:	4981                	li	s3,0
        i += 2;
 a12:	bdf9                	j	8f0 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 a14:	008b8913          	add	s2,s7,8
 a18:	4681                	li	a3,0
 a1a:	4629                	li	a2,10
 a1c:	000ba583          	lw	a1,0(s7)
 a20:	855a                	mv	a0,s6
 a22:	dddff0ef          	jal	7fe <printint>
 a26:	8bca                	mv	s7,s2
      state = 0;
 a28:	4981                	li	s3,0
 a2a:	b5d9                	j	8f0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 a2c:	008b8913          	add	s2,s7,8
 a30:	4681                	li	a3,0
 a32:	4629                	li	a2,10
 a34:	000bb583          	ld	a1,0(s7)
 a38:	855a                	mv	a0,s6
 a3a:	dc5ff0ef          	jal	7fe <printint>
        i += 1;
 a3e:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 a40:	8bca                	mv	s7,s2
      state = 0;
 a42:	4981                	li	s3,0
        i += 1;
 a44:	b575                	j	8f0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 a46:	008b8913          	add	s2,s7,8
 a4a:	4681                	li	a3,0
 a4c:	4629                	li	a2,10
 a4e:	000bb583          	ld	a1,0(s7)
 a52:	855a                	mv	a0,s6
 a54:	dabff0ef          	jal	7fe <printint>
        i += 2;
 a58:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 a5a:	8bca                	mv	s7,s2
      state = 0;
 a5c:	4981                	li	s3,0
        i += 2;
 a5e:	bd49                	j	8f0 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 a60:	008b8913          	add	s2,s7,8
 a64:	4681                	li	a3,0
 a66:	4641                	li	a2,16
 a68:	000ba583          	lw	a1,0(s7)
 a6c:	855a                	mv	a0,s6
 a6e:	d91ff0ef          	jal	7fe <printint>
 a72:	8bca                	mv	s7,s2
      state = 0;
 a74:	4981                	li	s3,0
 a76:	bdad                	j	8f0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 a78:	008b8913          	add	s2,s7,8
 a7c:	4681                	li	a3,0
 a7e:	4641                	li	a2,16
 a80:	000bb583          	ld	a1,0(s7)
 a84:	855a                	mv	a0,s6
 a86:	d79ff0ef          	jal	7fe <printint>
        i += 1;
 a8a:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 a8c:	8bca                	mv	s7,s2
      state = 0;
 a8e:	4981                	li	s3,0
        i += 1;
 a90:	b585                	j	8f0 <vprintf+0x4a>
 a92:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 a94:	008b8d13          	add	s10,s7,8
 a98:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 a9c:	03000593          	li	a1,48
 aa0:	855a                	mv	a0,s6
 aa2:	d3fff0ef          	jal	7e0 <putc>
  putc(fd, 'x');
 aa6:	07800593          	li	a1,120
 aaa:	855a                	mv	a0,s6
 aac:	d35ff0ef          	jal	7e0 <putc>
 ab0:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 ab2:	00000b97          	auipc	s7,0x0
 ab6:	366b8b93          	add	s7,s7,870 # e18 <digits>
 aba:	03c9d793          	srl	a5,s3,0x3c
 abe:	97de                	add	a5,a5,s7
 ac0:	0007c583          	lbu	a1,0(a5)
 ac4:	855a                	mv	a0,s6
 ac6:	d1bff0ef          	jal	7e0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 aca:	0992                	sll	s3,s3,0x4
 acc:	397d                	addw	s2,s2,-1
 ace:	fe0916e3          	bnez	s2,aba <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 ad2:	8bea                	mv	s7,s10
      state = 0;
 ad4:	4981                	li	s3,0
 ad6:	6d02                	ld	s10,0(sp)
 ad8:	bd21                	j	8f0 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 ada:	008b8993          	add	s3,s7,8
 ade:	000bb903          	ld	s2,0(s7)
 ae2:	00090f63          	beqz	s2,b00 <vprintf+0x25a>
        for(; *s; s++)
 ae6:	00094583          	lbu	a1,0(s2)
 aea:	c195                	beqz	a1,b0e <vprintf+0x268>
          putc(fd, *s);
 aec:	855a                	mv	a0,s6
 aee:	cf3ff0ef          	jal	7e0 <putc>
        for(; *s; s++)
 af2:	0905                	add	s2,s2,1
 af4:	00094583          	lbu	a1,0(s2)
 af8:	f9f5                	bnez	a1,aec <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 afa:	8bce                	mv	s7,s3
      state = 0;
 afc:	4981                	li	s3,0
 afe:	bbcd                	j	8f0 <vprintf+0x4a>
          s = "(null)";
 b00:	00000917          	auipc	s2,0x0
 b04:	31090913          	add	s2,s2,784 # e10 <malloc+0x1fc>
        for(; *s; s++)
 b08:	02800593          	li	a1,40
 b0c:	b7c5                	j	aec <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 b0e:	8bce                	mv	s7,s3
      state = 0;
 b10:	4981                	li	s3,0
 b12:	bbf9                	j	8f0 <vprintf+0x4a>
 b14:	64a6                	ld	s1,72(sp)
 b16:	79e2                	ld	s3,56(sp)
 b18:	7a42                	ld	s4,48(sp)
 b1a:	7aa2                	ld	s5,40(sp)
 b1c:	7b02                	ld	s6,32(sp)
 b1e:	6be2                	ld	s7,24(sp)
 b20:	6c42                	ld	s8,16(sp)
 b22:	6ca2                	ld	s9,8(sp)
    }
  }
}
 b24:	60e6                	ld	ra,88(sp)
 b26:	6446                	ld	s0,80(sp)
 b28:	6906                	ld	s2,64(sp)
 b2a:	6125                	add	sp,sp,96
 b2c:	8082                	ret

0000000000000b2e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 b2e:	715d                	add	sp,sp,-80
 b30:	ec06                	sd	ra,24(sp)
 b32:	e822                	sd	s0,16(sp)
 b34:	1000                	add	s0,sp,32
 b36:	e010                	sd	a2,0(s0)
 b38:	e414                	sd	a3,8(s0)
 b3a:	e818                	sd	a4,16(s0)
 b3c:	ec1c                	sd	a5,24(s0)
 b3e:	03043023          	sd	a6,32(s0)
 b42:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 b46:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 b4a:	8622                	mv	a2,s0
 b4c:	d5bff0ef          	jal	8a6 <vprintf>
}
 b50:	60e2                	ld	ra,24(sp)
 b52:	6442                	ld	s0,16(sp)
 b54:	6161                	add	sp,sp,80
 b56:	8082                	ret

0000000000000b58 <printf>:

void
printf(const char *fmt, ...)
{
 b58:	711d                	add	sp,sp,-96
 b5a:	ec06                	sd	ra,24(sp)
 b5c:	e822                	sd	s0,16(sp)
 b5e:	1000                	add	s0,sp,32
 b60:	e40c                	sd	a1,8(s0)
 b62:	e810                	sd	a2,16(s0)
 b64:	ec14                	sd	a3,24(s0)
 b66:	f018                	sd	a4,32(s0)
 b68:	f41c                	sd	a5,40(s0)
 b6a:	03043823          	sd	a6,48(s0)
 b6e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b72:	00840613          	add	a2,s0,8
 b76:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 b7a:	85aa                	mv	a1,a0
 b7c:	4505                	li	a0,1
 b7e:	d29ff0ef          	jal	8a6 <vprintf>
}
 b82:	60e2                	ld	ra,24(sp)
 b84:	6442                	ld	s0,16(sp)
 b86:	6125                	add	sp,sp,96
 b88:	8082                	ret

0000000000000b8a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b8a:	1141                	add	sp,sp,-16
 b8c:	e422                	sd	s0,8(sp)
 b8e:	0800                	add	s0,sp,16
  Header *bp, *p;

  if(ap == 0)
 b90:	cd3d                	beqz	a0,c0e <free+0x84>
    return;
  if((uint64)ap < 4096)
 b92:	6785                	lui	a5,0x1
 b94:	06f56d63          	bltu	a0,a5,c0e <free+0x84>
    return;
  bp = (Header*)ap - 1;
 b98:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b9c:	00000797          	auipc	a5,0x0
 ba0:	51c7b783          	ld	a5,1308(a5) # 10b8 <freep>
 ba4:	a02d                	j	bce <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 ba6:	4618                	lw	a4,8(a2)
 ba8:	9f2d                	addw	a4,a4,a1
 baa:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 bae:	6398                	ld	a4,0(a5)
 bb0:	6310                	ld	a2,0(a4)
 bb2:	a83d                	j	bf0 <free+0x66>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 bb4:	ff852703          	lw	a4,-8(a0)
 bb8:	9f31                	addw	a4,a4,a2
 bba:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 bbc:	ff053683          	ld	a3,-16(a0)
 bc0:	a091                	j	c04 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bc2:	6398                	ld	a4,0(a5)
 bc4:	00e7e463          	bltu	a5,a4,bcc <free+0x42>
 bc8:	00e6ea63          	bltu	a3,a4,bdc <free+0x52>
{
 bcc:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bce:	fed7fae3          	bgeu	a5,a3,bc2 <free+0x38>
 bd2:	6398                	ld	a4,0(a5)
 bd4:	00e6e463          	bltu	a3,a4,bdc <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bd8:	fee7eae3          	bltu	a5,a4,bcc <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 bdc:	ff852583          	lw	a1,-8(a0)
 be0:	6390                	ld	a2,0(a5)
 be2:	02059813          	sll	a6,a1,0x20
 be6:	01c85713          	srl	a4,a6,0x1c
 bea:	9736                	add	a4,a4,a3
 bec:	fae60de3          	beq	a2,a4,ba6 <free+0x1c>
    bp->s.ptr = p->s.ptr->s.ptr;
 bf0:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 bf4:	4790                	lw	a2,8(a5)
 bf6:	02061593          	sll	a1,a2,0x20
 bfa:	01c5d713          	srl	a4,a1,0x1c
 bfe:	973e                	add	a4,a4,a5
 c00:	fae68ae3          	beq	a3,a4,bb4 <free+0x2a>
    p->s.ptr = bp->s.ptr;
 c04:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 c06:	00000717          	auipc	a4,0x0
 c0a:	4af73923          	sd	a5,1202(a4) # 10b8 <freep>
}
 c0e:	6422                	ld	s0,8(sp)
 c10:	0141                	add	sp,sp,16
 c12:	8082                	ret

0000000000000c14 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 c14:	7139                	add	sp,sp,-64
 c16:	fc06                	sd	ra,56(sp)
 c18:	f822                	sd	s0,48(sp)
 c1a:	f426                	sd	s1,40(sp)
 c1c:	ec4e                	sd	s3,24(sp)
 c1e:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c20:	02051493          	sll	s1,a0,0x20
 c24:	9081                	srl	s1,s1,0x20
 c26:	04bd                	add	s1,s1,15
 c28:	8091                	srl	s1,s1,0x4
 c2a:	0014899b          	addw	s3,s1,1
 c2e:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 c30:	00000517          	auipc	a0,0x0
 c34:	48853503          	ld	a0,1160(a0) # 10b8 <freep>
 c38:	c915                	beqz	a0,c6c <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c3a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c3c:	4798                	lw	a4,8(a5)
 c3e:	08977a63          	bgeu	a4,s1,cd2 <malloc+0xbe>
 c42:	f04a                	sd	s2,32(sp)
 c44:	e852                	sd	s4,16(sp)
 c46:	e456                	sd	s5,8(sp)
 c48:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 c4a:	8a4e                	mv	s4,s3
 c4c:	0009871b          	sext.w	a4,s3
 c50:	6685                	lui	a3,0x1
 c52:	00d77363          	bgeu	a4,a3,c58 <malloc+0x44>
 c56:	6a05                	lui	s4,0x1
 c58:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 c5c:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 c60:	00000917          	auipc	s2,0x0
 c64:	45890913          	add	s2,s2,1112 # 10b8 <freep>
  if(p == (char*)-1)
 c68:	5afd                	li	s5,-1
 c6a:	a081                	j	caa <malloc+0x96>
 c6c:	f04a                	sd	s2,32(sp)
 c6e:	e852                	sd	s4,16(sp)
 c70:	e456                	sd	s5,8(sp)
 c72:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 c74:	00000797          	auipc	a5,0x0
 c78:	44c78793          	add	a5,a5,1100 # 10c0 <base>
 c7c:	00000717          	auipc	a4,0x0
 c80:	42f73e23          	sd	a5,1084(a4) # 10b8 <freep>
 c84:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 c86:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 c8a:	b7c1                	j	c4a <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 c8c:	6398                	ld	a4,0(a5)
 c8e:	e118                	sd	a4,0(a0)
 c90:	a8a9                	j	cea <malloc+0xd6>
  hp->s.size = nu;
 c92:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 c96:	0541                	add	a0,a0,16
 c98:	ef3ff0ef          	jal	b8a <free>
  return freep;
 c9c:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 ca0:	c12d                	beqz	a0,d02 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ca2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ca4:	4798                	lw	a4,8(a5)
 ca6:	02977263          	bgeu	a4,s1,cca <malloc+0xb6>
    if(p == freep)
 caa:	00093703          	ld	a4,0(s2)
 cae:	853e                	mv	a0,a5
 cb0:	fef719e3          	bne	a4,a5,ca2 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 cb4:	8552                	mv	a0,s4
 cb6:	ab9ff0ef          	jal	76e <sbrk>
  if(p == (char*)-1)
 cba:	fd551ce3          	bne	a0,s5,c92 <malloc+0x7e>
        return 0;
 cbe:	4501                	li	a0,0
 cc0:	7902                	ld	s2,32(sp)
 cc2:	6a42                	ld	s4,16(sp)
 cc4:	6aa2                	ld	s5,8(sp)
 cc6:	6b02                	ld	s6,0(sp)
 cc8:	a03d                	j	cf6 <malloc+0xe2>
 cca:	7902                	ld	s2,32(sp)
 ccc:	6a42                	ld	s4,16(sp)
 cce:	6aa2                	ld	s5,8(sp)
 cd0:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 cd2:	fae48de3          	beq	s1,a4,c8c <malloc+0x78>
        p->s.size -= nunits;
 cd6:	4137073b          	subw	a4,a4,s3
 cda:	c798                	sw	a4,8(a5)
        p += p->s.size;
 cdc:	02071693          	sll	a3,a4,0x20
 ce0:	01c6d713          	srl	a4,a3,0x1c
 ce4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 ce6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 cea:	00000717          	auipc	a4,0x0
 cee:	3ca73723          	sd	a0,974(a4) # 10b8 <freep>
      return (void*)(p + 1);
 cf2:	01078513          	add	a0,a5,16
  }
}
 cf6:	70e2                	ld	ra,56(sp)
 cf8:	7442                	ld	s0,48(sp)
 cfa:	74a2                	ld	s1,40(sp)
 cfc:	69e2                	ld	s3,24(sp)
 cfe:	6121                	add	sp,sp,64
 d00:	8082                	ret
 d02:	7902                	ld	s2,32(sp)
 d04:	6a42                	ld	s4,16(sp)
 d06:	6aa2                	ld	s5,8(sp)
 d08:	6b02                	ld	s6,0(sp)
 d0a:	b7f5                	j	cf6 <malloc+0xe2>
