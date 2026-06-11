
user/_telnetd:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
    "Type 'exit' to logout\r\n\r\n";

static char SHELL_PROMPT[] = "$ ";

int main(int argc, char *argv[])
{
   0:	7125                	add	sp,sp,-416
   2:	ef06                	sd	ra,408(sp)
   4:	eb22                	sd	s0,400(sp)
   6:	e726                	sd	s1,392(sp)
   8:	1300                	add	s0,sp,416
    char buf[128];
    char cmd_buf[128];
    int cmd_len = 0;
    int port = 23;

    if (argc > 1) {
   a:	4705                	li	a4,1
    int port = 23;
   c:	44dd                	li	s1,23
    if (argc > 1) {
   e:	08a74763          	blt	a4,a0,9c <main+0x9c>
        port = atoi(argv[1]);
    }

    printf("Starting Telnet Server on port %d\n", port);
  12:	85a6                	mv	a1,s1
  14:	00001517          	auipc	a0,0x1
  18:	d3c50513          	add	a0,a0,-708 # d50 <malloc+0x106>
  1c:	373000ef          	jal	b8e <printf>
    
    soc = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
  20:	4601                	li	a2,0
  22:	4589                	li	a1,2
  24:	4505                	li	a0,1
  26:	796000ef          	jal	7bc <socket>
  2a:	e6a43423          	sd	a0,-408(s0)
    if (soc == -1) {
  2e:	57fd                	li	a5,-1
  30:	06f50b63          	beq	a0,a5,a6 <main+0xa6>
  34:	e34a                	sd	s2,384(sp)
  36:	fece                	sd	s3,376(sp)
  38:	fad2                	sd	s4,368(sp)
  3a:	f6d6                	sd	s5,360(sp)
  3c:	f2da                	sd	s6,352(sp)
  3e:	eede                	sd	s7,344(sp)
  40:	eae2                	sd	s8,336(sp)
  42:	e6e6                	sd	s9,328(sp)
  44:	e2ea                	sd	s10,320(sp)
  46:	fe6e                	sd	s11,312(sp)
        printf("socket: failure\n");
        exit(1);
    }
    printf("socket: success, soc=%d\n", soc);
  48:	e6843903          	ld	s2,-408(s0)
  4c:	85ca                	mv	a1,s2
  4e:	00001517          	auipc	a0,0x1
  52:	d4250513          	add	a0,a0,-702 # d90 <malloc+0x146>
  56:	339000ef          	jal	b8e <printf>
    
    self.sin_family = AF_INET;
  5a:	4785                	li	a5,1
  5c:	f8f41023          	sh	a5,-128(s0)
    self.sin_addr.s_addr = INADDR_ANY;
  60:	f8042223          	sw	zero,-124(s0)
    self.sin_port = htons(port);
  64:	03049513          	sll	a0,s1,0x30
  68:	9141                	srl	a0,a0,0x30
  6a:	42e000ef          	jal	498 <htons>
  6e:	f8a41123          	sh	a0,-126(s0)
    
    if (bind(soc, (struct sockaddr *)&self, sizeof(self)) == -1) {
  72:	4621                	li	a2,8
  74:	f8040593          	add	a1,s0,-128
  78:	854a                	mv	a0,s2
  7a:	74a000ef          	jal	7c4 <bind>
  7e:	57fd                	li	a5,-1
  80:	04f51663          	bne	a0,a5,cc <main+0xcc>
        printf("bind: failure\n");
  84:	00001517          	auipc	a0,0x1
  88:	d2c50513          	add	a0,a0,-724 # db0 <malloc+0x166>
  8c:	303000ef          	jal	b8e <printf>
        close(soc);
  90:	854a                	mv	a0,s2
  92:	6b2000ef          	jal	744 <close>
        exit(1);
  96:	4505                	li	a0,1
  98:	684000ef          	jal	71c <exit>
        port = atoi(argv[1]);
  9c:	6588                	ld	a0,8(a1)
  9e:	30c000ef          	jal	3aa <atoi>
  a2:	84aa                	mv	s1,a0
  a4:	b7bd                	j	12 <main+0x12>
  a6:	e34a                	sd	s2,384(sp)
  a8:	fece                	sd	s3,376(sp)
  aa:	fad2                	sd	s4,368(sp)
  ac:	f6d6                	sd	s5,360(sp)
  ae:	f2da                	sd	s6,352(sp)
  b0:	eede                	sd	s7,344(sp)
  b2:	eae2                	sd	s8,336(sp)
  b4:	e6e6                	sd	s9,328(sp)
  b6:	e2ea                	sd	s10,320(sp)
  b8:	fe6e                	sd	s11,312(sp)
        printf("socket: failure\n");
  ba:	00001517          	auipc	a0,0x1
  be:	cbe50513          	add	a0,a0,-834 # d78 <malloc+0x12e>
  c2:	2cd000ef          	jal	b8e <printf>
        exit(1);
  c6:	4505                	li	a0,1
  c8:	654000ef          	jal	71c <exit>
    }
    
    listen(soc, 5);
  cc:	4595                	li	a1,5
  ce:	e6843503          	ld	a0,-408(s0)
  d2:	712000ef          	jal	7e4 <listen>
    printf("waiting for connection...\n");
  d6:	00001517          	auipc	a0,0x1
  da:	cea50513          	add	a0,a0,-790 # dc0 <malloc+0x176>
  de:	2b1000ef          	jal	b8e <printf>
                            cmd_buf[2] == 'i' && cmd_buf[3] == 't') {
                            send(acc, "logout\r\n", 8);
                            break;
                        }
                        
                        send(acc, "Sorry, command execution is under development\r\n", 49);
  e2:	00001c97          	auipc	s9,0x1
  e6:	d3ec8c93          	add	s9,s9,-706 # e20 <malloc+0x1d6>
                        send(acc, "Use 'sh' to start xv6 shell\r\n", 31);
  ea:	00001c17          	auipc	s8,0x1
  ee:	d66c0c13          	add	s8,s8,-666 # e50 <malloc+0x206>
  f2:	aa21                	j	20a <main+0x20a>
        printf("connection from client\n");
  f4:	00001517          	auipc	a0,0x1
  f8:	d0450513          	add	a0,a0,-764 # df8 <malloc+0x1ae>
  fc:	293000ef          	jal	b8e <printf>
        send(acc, WELCOME_MSG, strlen(WELCOME_MSG));
 100:	00001497          	auipc	s1,0x1
 104:	f1048493          	add	s1,s1,-240 # 1010 <WELCOME_MSG>
 108:	8526                	mv	a0,s1
 10a:	186000ef          	jal	290 <strlen>
 10e:	0005061b          	sext.w	a2,a0
 112:	85a6                	mv	a1,s1
 114:	854e                	mv	a0,s3
 116:	6e6000ef          	jal	7fc <send>
        send(acc, SHELL_PROMPT, 2);
 11a:	4609                	li	a2,2
 11c:	00001597          	auipc	a1,0x1
 120:	ee458593          	add	a1,a1,-284 # 1000 <SHELL_PROMPT>
 124:	854e                	mv	a0,s3
 126:	6d6000ef          	jal	7fc <send>
        cmd_len = 0;
 12a:	4901                	li	s2,0
                    }
                    
                    send(acc, SHELL_PROMPT, 2);
 12c:	00001b17          	auipc	s6,0x1
 130:	ed4b0b13          	add	s6,s6,-300 # 1000 <SHELL_PROMPT>
                        if (cmd_buf[0] == 'e' && cmd_buf[1] == 'x' && 
 134:	06500b93          	li	s7,101
            int ret = recv(acc, buf, sizeof(buf) - 1);
 138:	07f00613          	li	a2,127
 13c:	ef840593          	add	a1,s0,-264
 140:	854e                	mv	a0,s3
 142:	6b2000ef          	jal	7f4 <recv>
            if (ret <= 0) break;
 146:	0aa05963          	blez	a0,1f8 <main+0x1f8>
            buf[ret] = '\0';
 14a:	f9050793          	add	a5,a0,-112
 14e:	97a2                	add	a5,a5,s0
 150:	f6078423          	sb	zero,-152(a5)
            for (i = 0; i < ret; i++) {
 154:	ef840493          	add	s1,s0,-264
 158:	00950a33          	add	s4,a0,s1
                if (buf[i] == '\r' || buf[i] == '\n') {
 15c:	4ab5                	li	s5,13
                        if (cmd_buf[0] == 'e' && cmd_buf[1] == 'x' && 
 15e:	07800d13          	li	s10,120
 162:	06900d93          	li	s11,105
 166:	a0a1                	j	1ae <main+0x1ae>
                    cmd_buf[cmd_len] = '\0';
 168:	f9090793          	add	a5,s2,-112
 16c:	97a2                	add	a5,a5,s0
 16e:	ee078423          	sb	zero,-280(a5)
                    if (cmd_len > 0) {
 172:	03205563          	blez	s2,19c <main+0x19c>
                        if (cmd_buf[0] == 'e' && cmd_buf[1] == 'x' && 
 176:	e7844783          	lbu	a5,-392(s0)
 17a:	01779663          	bne	a5,s7,186 <main+0x186>
 17e:	e7944783          	lbu	a5,-391(s0)
 182:	05a78863          	beq	a5,s10,1d2 <main+0x1d2>
                        send(acc, "Sorry, command execution is under development\r\n", 49);
 186:	03100613          	li	a2,49
 18a:	85e6                	mv	a1,s9
 18c:	854e                	mv	a0,s3
 18e:	66e000ef          	jal	7fc <send>
                        send(acc, "Use 'sh' to start xv6 shell\r\n", 31);
 192:	467d                	li	a2,31
 194:	85e2                	mv	a1,s8
 196:	854e                	mv	a0,s3
 198:	664000ef          	jal	7fc <send>
                    send(acc, SHELL_PROMPT, 2);
 19c:	4609                	li	a2,2
 19e:	85da                	mv	a1,s6
 1a0:	854e                	mv	a0,s3
 1a2:	65a000ef          	jal	7fc <send>
                    cmd_len = 0;
 1a6:	4901                	li	s2,0
            for (i = 0; i < ret; i++) {
 1a8:	0485                	add	s1,s1,1
 1aa:	f94487e3          	beq	s1,s4,138 <main+0x138>
                if (buf[i] == '\r' || buf[i] == '\n') {
 1ae:	0004c783          	lbu	a5,0(s1)
 1b2:	fb578be3          	beq	a5,s5,168 <main+0x168>
 1b6:	4729                	li	a4,10
 1b8:	fae788e3          	beq	a5,a4,168 <main+0x168>
                } else if (cmd_len < (int)(sizeof(cmd_buf) - 1)) {
 1bc:	07e00713          	li	a4,126
 1c0:	ff2744e3          	blt	a4,s2,1a8 <main+0x1a8>
                    cmd_buf[cmd_len++] = buf[i];
 1c4:	f9090713          	add	a4,s2,-112
 1c8:	9722                	add	a4,a4,s0
 1ca:	eef70423          	sb	a5,-280(a4)
 1ce:	2905                	addw	s2,s2,1
 1d0:	bfe1                	j	1a8 <main+0x1a8>
                        if (cmd_buf[0] == 'e' && cmd_buf[1] == 'x' && 
 1d2:	e7a44783          	lbu	a5,-390(s0)
 1d6:	fbb798e3          	bne	a5,s11,186 <main+0x186>
                            cmd_buf[2] == 'i' && cmd_buf[3] == 't') {
 1da:	e7b44703          	lbu	a4,-389(s0)
 1de:	07400793          	li	a5,116
 1e2:	faf712e3          	bne	a4,a5,186 <main+0x186>
                            send(acc, "logout\r\n", 8);
 1e6:	4621                	li	a2,8
 1e8:	00001597          	auipc	a1,0x1
 1ec:	c2858593          	add	a1,a1,-984 # e10 <malloc+0x1c6>
 1f0:	854e                	mv	a0,s3
 1f2:	60a000ef          	jal	7fc <send>
                            break;
 1f6:	b789                	j	138 <main+0x138>
                }
            }
        }
        
        close(acc);
 1f8:	854e                	mv	a0,s3
 1fa:	54a000ef          	jal	744 <close>
        printf("client disconnected\n");
 1fe:	00001517          	auipc	a0,0x1
 202:	c7250513          	add	a0,a0,-910 # e70 <malloc+0x226>
 206:	189000ef          	jal	b8e <printf>
        peerlen = sizeof(peer);
 20a:	47a1                	li	a5,8
 20c:	f8f42623          	sw	a5,-116(s0)
        acc = accept(soc, (struct sockaddr *)&peer, &peerlen);
 210:	f8c40613          	add	a2,s0,-116
 214:	f7840593          	add	a1,s0,-136
 218:	e6843503          	ld	a0,-408(s0)
 21c:	5d0000ef          	jal	7ec <accept>
 220:	89aa                	mv	s3,a0
        if (acc == -1) {
 222:	57fd                	li	a5,-1
 224:	ecf518e3          	bne	a0,a5,f4 <main+0xf4>
            printf("accept: failure\n");
 228:	00001517          	auipc	a0,0x1
 22c:	bb850513          	add	a0,a0,-1096 # de0 <malloc+0x196>
 230:	15f000ef          	jal	b8e <printf>
            continue;
 234:	bfd9                	j	20a <main+0x20a>

0000000000000236 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 236:	1141                	add	sp,sp,-16
 238:	e406                	sd	ra,8(sp)
 23a:	e022                	sd	s0,0(sp)
 23c:	0800                	add	s0,sp,16
  extern int main();
  main();
 23e:	dc3ff0ef          	jal	0 <main>
  exit(0);
 242:	4501                	li	a0,0
 244:	4d8000ef          	jal	71c <exit>

0000000000000248 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 248:	1141                	add	sp,sp,-16
 24a:	e422                	sd	s0,8(sp)
 24c:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 24e:	87aa                	mv	a5,a0
 250:	0585                	add	a1,a1,1
 252:	0785                	add	a5,a5,1
 254:	fff5c703          	lbu	a4,-1(a1)
 258:	fee78fa3          	sb	a4,-1(a5)
 25c:	fb75                	bnez	a4,250 <strcpy+0x8>
    ;
  return os;
}
 25e:	6422                	ld	s0,8(sp)
 260:	0141                	add	sp,sp,16
 262:	8082                	ret

0000000000000264 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 264:	1141                	add	sp,sp,-16
 266:	e422                	sd	s0,8(sp)
 268:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 26a:	00054783          	lbu	a5,0(a0)
 26e:	cb91                	beqz	a5,282 <strcmp+0x1e>
 270:	0005c703          	lbu	a4,0(a1)
 274:	00f71763          	bne	a4,a5,282 <strcmp+0x1e>
    p++, q++;
 278:	0505                	add	a0,a0,1
 27a:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 27c:	00054783          	lbu	a5,0(a0)
 280:	fbe5                	bnez	a5,270 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 282:	0005c503          	lbu	a0,0(a1)
}
 286:	40a7853b          	subw	a0,a5,a0
 28a:	6422                	ld	s0,8(sp)
 28c:	0141                	add	sp,sp,16
 28e:	8082                	ret

0000000000000290 <strlen>:

uint
strlen(const char *s)
{
 290:	1141                	add	sp,sp,-16
 292:	e422                	sd	s0,8(sp)
 294:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 296:	00054783          	lbu	a5,0(a0)
 29a:	cf91                	beqz	a5,2b6 <strlen+0x26>
 29c:	0505                	add	a0,a0,1
 29e:	87aa                	mv	a5,a0
 2a0:	86be                	mv	a3,a5
 2a2:	0785                	add	a5,a5,1
 2a4:	fff7c703          	lbu	a4,-1(a5)
 2a8:	ff65                	bnez	a4,2a0 <strlen+0x10>
 2aa:	40a6853b          	subw	a0,a3,a0
 2ae:	2505                	addw	a0,a0,1
    ;
  return n;
}
 2b0:	6422                	ld	s0,8(sp)
 2b2:	0141                	add	sp,sp,16
 2b4:	8082                	ret
  for(n = 0; s[n]; n++)
 2b6:	4501                	li	a0,0
 2b8:	bfe5                	j	2b0 <strlen+0x20>

00000000000002ba <memset>:

void*
memset(void *dst, int c, uint n)
{
 2ba:	1141                	add	sp,sp,-16
 2bc:	e422                	sd	s0,8(sp)
 2be:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2c0:	ca19                	beqz	a2,2d6 <memset+0x1c>
 2c2:	87aa                	mv	a5,a0
 2c4:	1602                	sll	a2,a2,0x20
 2c6:	9201                	srl	a2,a2,0x20
 2c8:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 2cc:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2d0:	0785                	add	a5,a5,1
 2d2:	fee79de3          	bne	a5,a4,2cc <memset+0x12>
  }
  return dst;
}
 2d6:	6422                	ld	s0,8(sp)
 2d8:	0141                	add	sp,sp,16
 2da:	8082                	ret

00000000000002dc <strchr>:

char*
strchr(const char *s, char c)
{
 2dc:	1141                	add	sp,sp,-16
 2de:	e422                	sd	s0,8(sp)
 2e0:	0800                	add	s0,sp,16
  for(; *s; s++)
 2e2:	00054783          	lbu	a5,0(a0)
 2e6:	cb99                	beqz	a5,2fc <strchr+0x20>
    if(*s == c)
 2e8:	00f58763          	beq	a1,a5,2f6 <strchr+0x1a>
  for(; *s; s++)
 2ec:	0505                	add	a0,a0,1
 2ee:	00054783          	lbu	a5,0(a0)
 2f2:	fbfd                	bnez	a5,2e8 <strchr+0xc>
      return (char*)s;
  return 0;
 2f4:	4501                	li	a0,0
}
 2f6:	6422                	ld	s0,8(sp)
 2f8:	0141                	add	sp,sp,16
 2fa:	8082                	ret
  return 0;
 2fc:	4501                	li	a0,0
 2fe:	bfe5                	j	2f6 <strchr+0x1a>

0000000000000300 <gets>:

char*
gets(char *buf, int max)
{
 300:	711d                	add	sp,sp,-96
 302:	ec86                	sd	ra,88(sp)
 304:	e8a2                	sd	s0,80(sp)
 306:	e4a6                	sd	s1,72(sp)
 308:	e0ca                	sd	s2,64(sp)
 30a:	fc4e                	sd	s3,56(sp)
 30c:	f852                	sd	s4,48(sp)
 30e:	f456                	sd	s5,40(sp)
 310:	f05a                	sd	s6,32(sp)
 312:	ec5e                	sd	s7,24(sp)
 314:	1080                	add	s0,sp,96
 316:	8baa                	mv	s7,a0
 318:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 31a:	892a                	mv	s2,a0
 31c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 31e:	4aa9                	li	s5,10
 320:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 322:	89a6                	mv	s3,s1
 324:	2485                	addw	s1,s1,1
 326:	0344d663          	bge	s1,s4,352 <gets+0x52>
    cc = read(0, &c, 1);
 32a:	4605                	li	a2,1
 32c:	faf40593          	add	a1,s0,-81
 330:	4501                	li	a0,0
 332:	402000ef          	jal	734 <read>
    if(cc < 1)
 336:	00a05e63          	blez	a0,352 <gets+0x52>
    buf[i++] = c;
 33a:	faf44783          	lbu	a5,-81(s0)
 33e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 342:	01578763          	beq	a5,s5,350 <gets+0x50>
 346:	0905                	add	s2,s2,1
 348:	fd679de3          	bne	a5,s6,322 <gets+0x22>
    buf[i++] = c;
 34c:	89a6                	mv	s3,s1
 34e:	a011                	j	352 <gets+0x52>
 350:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 352:	99de                	add	s3,s3,s7
 354:	00098023          	sb	zero,0(s3)
  return buf;
}
 358:	855e                	mv	a0,s7
 35a:	60e6                	ld	ra,88(sp)
 35c:	6446                	ld	s0,80(sp)
 35e:	64a6                	ld	s1,72(sp)
 360:	6906                	ld	s2,64(sp)
 362:	79e2                	ld	s3,56(sp)
 364:	7a42                	ld	s4,48(sp)
 366:	7aa2                	ld	s5,40(sp)
 368:	7b02                	ld	s6,32(sp)
 36a:	6be2                	ld	s7,24(sp)
 36c:	6125                	add	sp,sp,96
 36e:	8082                	ret

0000000000000370 <stat>:

int
stat(const char *n, struct stat *st)
{
 370:	1101                	add	sp,sp,-32
 372:	ec06                	sd	ra,24(sp)
 374:	e822                	sd	s0,16(sp)
 376:	e04a                	sd	s2,0(sp)
 378:	1000                	add	s0,sp,32
 37a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 37c:	4581                	li	a1,0
 37e:	3de000ef          	jal	75c <open>
  if(fd < 0)
 382:	02054263          	bltz	a0,3a6 <stat+0x36>
 386:	e426                	sd	s1,8(sp)
 388:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 38a:	85ca                	mv	a1,s2
 38c:	3e8000ef          	jal	774 <fstat>
 390:	892a                	mv	s2,a0
  close(fd);
 392:	8526                	mv	a0,s1
 394:	3b0000ef          	jal	744 <close>
  return r;
 398:	64a2                	ld	s1,8(sp)
}
 39a:	854a                	mv	a0,s2
 39c:	60e2                	ld	ra,24(sp)
 39e:	6442                	ld	s0,16(sp)
 3a0:	6902                	ld	s2,0(sp)
 3a2:	6105                	add	sp,sp,32
 3a4:	8082                	ret
    return -1;
 3a6:	597d                	li	s2,-1
 3a8:	bfcd                	j	39a <stat+0x2a>

00000000000003aa <atoi>:

int
atoi(const char *s)
{
 3aa:	1141                	add	sp,sp,-16
 3ac:	e422                	sd	s0,8(sp)
 3ae:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3b0:	00054683          	lbu	a3,0(a0)
 3b4:	fd06879b          	addw	a5,a3,-48
 3b8:	0ff7f793          	zext.b	a5,a5
 3bc:	4625                	li	a2,9
 3be:	02f66863          	bltu	a2,a5,3ee <atoi+0x44>
 3c2:	872a                	mv	a4,a0
  n = 0;
 3c4:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 3c6:	0705                	add	a4,a4,1
 3c8:	0025179b          	sllw	a5,a0,0x2
 3cc:	9fa9                	addw	a5,a5,a0
 3ce:	0017979b          	sllw	a5,a5,0x1
 3d2:	9fb5                	addw	a5,a5,a3
 3d4:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 3d8:	00074683          	lbu	a3,0(a4)
 3dc:	fd06879b          	addw	a5,a3,-48
 3e0:	0ff7f793          	zext.b	a5,a5
 3e4:	fef671e3          	bgeu	a2,a5,3c6 <atoi+0x1c>
  return n;
}
 3e8:	6422                	ld	s0,8(sp)
 3ea:	0141                	add	sp,sp,16
 3ec:	8082                	ret
  n = 0;
 3ee:	4501                	li	a0,0
 3f0:	bfe5                	j	3e8 <atoi+0x3e>

00000000000003f2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3f2:	1141                	add	sp,sp,-16
 3f4:	e422                	sd	s0,8(sp)
 3f6:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 3f8:	02b57463          	bgeu	a0,a1,420 <memmove+0x2e>
    while(n-- > 0)
 3fc:	00c05f63          	blez	a2,41a <memmove+0x28>
 400:	1602                	sll	a2,a2,0x20
 402:	9201                	srl	a2,a2,0x20
 404:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 408:	872a                	mv	a4,a0
      *dst++ = *src++;
 40a:	0585                	add	a1,a1,1
 40c:	0705                	add	a4,a4,1
 40e:	fff5c683          	lbu	a3,-1(a1)
 412:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 416:	fef71ae3          	bne	a4,a5,40a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 41a:	6422                	ld	s0,8(sp)
 41c:	0141                	add	sp,sp,16
 41e:	8082                	ret
    dst += n;
 420:	00c50733          	add	a4,a0,a2
    src += n;
 424:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 426:	fec05ae3          	blez	a2,41a <memmove+0x28>
 42a:	fff6079b          	addw	a5,a2,-1
 42e:	1782                	sll	a5,a5,0x20
 430:	9381                	srl	a5,a5,0x20
 432:	fff7c793          	not	a5,a5
 436:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 438:	15fd                	add	a1,a1,-1
 43a:	177d                	add	a4,a4,-1
 43c:	0005c683          	lbu	a3,0(a1)
 440:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 444:	fee79ae3          	bne	a5,a4,438 <memmove+0x46>
 448:	bfc9                	j	41a <memmove+0x28>

000000000000044a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 44a:	1141                	add	sp,sp,-16
 44c:	e422                	sd	s0,8(sp)
 44e:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 450:	ca05                	beqz	a2,480 <memcmp+0x36>
 452:	fff6069b          	addw	a3,a2,-1
 456:	1682                	sll	a3,a3,0x20
 458:	9281                	srl	a3,a3,0x20
 45a:	0685                	add	a3,a3,1
 45c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 45e:	00054783          	lbu	a5,0(a0)
 462:	0005c703          	lbu	a4,0(a1)
 466:	00e79863          	bne	a5,a4,476 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 46a:	0505                	add	a0,a0,1
    p2++;
 46c:	0585                	add	a1,a1,1
  while (n-- > 0) {
 46e:	fed518e3          	bne	a0,a3,45e <memcmp+0x14>
  }
  return 0;
 472:	4501                	li	a0,0
 474:	a019                	j	47a <memcmp+0x30>
      return *p1 - *p2;
 476:	40e7853b          	subw	a0,a5,a4
}
 47a:	6422                	ld	s0,8(sp)
 47c:	0141                	add	sp,sp,16
 47e:	8082                	ret
  return 0;
 480:	4501                	li	a0,0
 482:	bfe5                	j	47a <memcmp+0x30>

0000000000000484 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 484:	1141                	add	sp,sp,-16
 486:	e406                	sd	ra,8(sp)
 488:	e022                	sd	s0,0(sp)
 48a:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 48c:	f67ff0ef          	jal	3f2 <memmove>
}
 490:	60a2                	ld	ra,8(sp)
 492:	6402                	ld	s0,0(sp)
 494:	0141                	add	sp,sp,16
 496:	8082                	ret

0000000000000498 <htons>:
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
}

uint16_t
htons(uint16_t h)
{
 498:	1141                	add	sp,sp,-16
 49a:	e422                	sd	s0,8(sp)
 49c:	0800                	add	s0,sp,16
    if (!endian) {
 49e:	00001797          	auipc	a5,0x1
 4a2:	be27a783          	lw	a5,-1054(a5) # 1080 <endian>
 4a6:	e385                	bnez	a5,4c6 <htons+0x2e>
        endian = byteorder();
 4a8:	4d200793          	li	a5,1234
 4ac:	00001717          	auipc	a4,0x1
 4b0:	bcf72a23          	sw	a5,-1068(a4) # 1080 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 4b4:	0085179b          	sllw	a5,a0,0x8
 4b8:	0085551b          	srlw	a0,a0,0x8
 4bc:	8fc9                	or	a5,a5,a0
 4be:	03079513          	sll	a0,a5,0x30
 4c2:	9141                	srl	a0,a0,0x30
 4c4:	a029                	j	4ce <htons+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(h) : h;
 4c6:	4d200713          	li	a4,1234
 4ca:	fee785e3          	beq	a5,a4,4b4 <htons+0x1c>
}
 4ce:	6422                	ld	s0,8(sp)
 4d0:	0141                	add	sp,sp,16
 4d2:	8082                	ret

00000000000004d4 <ntohs>:

uint16_t
ntohs(uint16_t n)
{
 4d4:	1141                	add	sp,sp,-16
 4d6:	e422                	sd	s0,8(sp)
 4d8:	0800                	add	s0,sp,16
    if (!endian) {
 4da:	00001797          	auipc	a5,0x1
 4de:	ba67a783          	lw	a5,-1114(a5) # 1080 <endian>
 4e2:	e385                	bnez	a5,502 <ntohs+0x2e>
        endian = byteorder();
 4e4:	4d200793          	li	a5,1234
 4e8:	00001717          	auipc	a4,0x1
 4ec:	b8f72c23          	sw	a5,-1128(a4) # 1080 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 4f0:	0085179b          	sllw	a5,a0,0x8
 4f4:	0085551b          	srlw	a0,a0,0x8
 4f8:	8fc9                	or	a5,a5,a0
 4fa:	03079513          	sll	a0,a5,0x30
 4fe:	9141                	srl	a0,a0,0x30
 500:	a029                	j	50a <ntohs+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(n) : n;
 502:	4d200713          	li	a4,1234
 506:	fee785e3          	beq	a5,a4,4f0 <ntohs+0x1c>
}
 50a:	6422                	ld	s0,8(sp)
 50c:	0141                	add	sp,sp,16
 50e:	8082                	ret

0000000000000510 <htonl>:

uint32_t
htonl(uint32_t h)
{
 510:	1141                	add	sp,sp,-16
 512:	e422                	sd	s0,8(sp)
 514:	0800                	add	s0,sp,16
    if (!endian) {
 516:	00001797          	auipc	a5,0x1
 51a:	b6a7a783          	lw	a5,-1174(a5) # 1080 <endian>
 51e:	ef85                	bnez	a5,556 <htonl+0x46>
        endian = byteorder();
 520:	4d200793          	li	a5,1234
 524:	00001717          	auipc	a4,0x1
 528:	b4f72e23          	sw	a5,-1188(a4) # 1080 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 52c:	0185179b          	sllw	a5,a0,0x18
 530:	0185571b          	srlw	a4,a0,0x18
 534:	8fd9                	or	a5,a5,a4
 536:	0085171b          	sllw	a4,a0,0x8
 53a:	00ff06b7          	lui	a3,0xff0
 53e:	8f75                	and	a4,a4,a3
 540:	8fd9                	or	a5,a5,a4
 542:	0085551b          	srlw	a0,a0,0x8
 546:	6741                	lui	a4,0x10
 548:	f0070713          	add	a4,a4,-256 # ff00 <base+0xee70>
 54c:	8d79                	and	a0,a0,a4
 54e:	8fc9                	or	a5,a5,a0
 550:	0007851b          	sext.w	a0,a5
 554:	a029                	j	55e <htonl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(h) : h;
 556:	4d200713          	li	a4,1234
 55a:	fce789e3          	beq	a5,a4,52c <htonl+0x1c>
}
 55e:	6422                	ld	s0,8(sp)
 560:	0141                	add	sp,sp,16
 562:	8082                	ret

0000000000000564 <ntohl>:

uint32_t
ntohl(uint32_t n)
{
 564:	1141                	add	sp,sp,-16
 566:	e422                	sd	s0,8(sp)
 568:	0800                	add	s0,sp,16
    if (!endian) {
 56a:	00001797          	auipc	a5,0x1
 56e:	b167a783          	lw	a5,-1258(a5) # 1080 <endian>
 572:	ef85                	bnez	a5,5aa <ntohl+0x46>
        endian = byteorder();
 574:	4d200793          	li	a5,1234
 578:	00001717          	auipc	a4,0x1
 57c:	b0f72423          	sw	a5,-1272(a4) # 1080 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 580:	0185179b          	sllw	a5,a0,0x18
 584:	0185571b          	srlw	a4,a0,0x18
 588:	8fd9                	or	a5,a5,a4
 58a:	0085171b          	sllw	a4,a0,0x8
 58e:	00ff06b7          	lui	a3,0xff0
 592:	8f75                	and	a4,a4,a3
 594:	8fd9                	or	a5,a5,a4
 596:	0085551b          	srlw	a0,a0,0x8
 59a:	6741                	lui	a4,0x10
 59c:	f0070713          	add	a4,a4,-256 # ff00 <base+0xee70>
 5a0:	8d79                	and	a0,a0,a4
 5a2:	8fc9                	or	a5,a5,a0
 5a4:	0007851b          	sext.w	a0,a5
 5a8:	a029                	j	5b2 <ntohl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(n) : n;
 5aa:	4d200713          	li	a4,1234
 5ae:	fce789e3          	beq	a5,a4,580 <ntohl+0x1c>
}
 5b2:	6422                	ld	s0,8(sp)
 5b4:	0141                	add	sp,sp,16
 5b6:	8082                	ret

00000000000005b8 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
 5b8:	1141                	add	sp,sp,-16
 5ba:	e422                	sd	s0,8(sp)
 5bc:	0800                	add	s0,sp,16
 5be:	872a                	mv	a4,a0
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
 5c0:	02000693          	li	a3,32
 5c4:	4525                	li	a0,9
 5c6:	a011                	j	5ca <strtol+0x12>
        s++;
 5c8:	0705                	add	a4,a4,1
    while (*s == ' ' || *s == '\t')
 5ca:	00074783          	lbu	a5,0(a4)
 5ce:	fed78de3          	beq	a5,a3,5c8 <strtol+0x10>
 5d2:	fea78be3          	beq	a5,a0,5c8 <strtol+0x10>

    // plus/minus sign
    if (*s == '+')
 5d6:	02b00693          	li	a3,43
 5da:	02d78663          	beq	a5,a3,606 <strtol+0x4e>
        s++;
    else if (*s == '-')
 5de:	02d00693          	li	a3,45
    int neg = 0;
 5e2:	4301                	li	t1,0
    else if (*s == '-')
 5e4:	02d78463          	beq	a5,a3,60c <strtol+0x54>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 5e8:	fef67793          	and	a5,a2,-17
 5ec:	eb89                	bnez	a5,5fe <strtol+0x46>
 5ee:	00074683          	lbu	a3,0(a4)
 5f2:	03000793          	li	a5,48
 5f6:	00f68e63          	beq	a3,a5,612 <strtol+0x5a>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
 5fa:	e211                	bnez	a2,5fe <strtol+0x46>
        s++, base = 8;
    else if (base == 0)
        base = 10;
 5fc:	4629                	li	a2,10
 5fe:	4501                	li	a0,0

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
 600:	4825                	li	a6,9
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
 602:	48e5                	li	a7,25
 604:	a825                	j	63c <strtol+0x84>
        s++;
 606:	0705                	add	a4,a4,1
    int neg = 0;
 608:	4301                	li	t1,0
 60a:	bff9                	j	5e8 <strtol+0x30>
        s++, neg = 1;
 60c:	0705                	add	a4,a4,1
 60e:	4305                	li	t1,1
 610:	bfe1                	j	5e8 <strtol+0x30>
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 612:	00174683          	lbu	a3,1(a4)
 616:	07800793          	li	a5,120
 61a:	00f68663          	beq	a3,a5,626 <strtol+0x6e>
    else if (base == 0 && s[0] == '0')
 61e:	f265                	bnez	a2,5fe <strtol+0x46>
        s++, base = 8;
 620:	0705                	add	a4,a4,1
 622:	4621                	li	a2,8
 624:	bfe9                	j	5fe <strtol+0x46>
        s += 2, base = 16;
 626:	0709                	add	a4,a4,2
 628:	4641                	li	a2,16
 62a:	bfd1                	j	5fe <strtol+0x46>
            dig = *s - '0';
 62c:	fd07879b          	addw	a5,a5,-48
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
 630:	04c7d063          	bge	a5,a2,670 <strtol+0xb8>
            break;
        s++, val = (val * base) + dig;
 634:	0705                	add	a4,a4,1
 636:	02a60533          	mul	a0,a2,a0
 63a:	953e                	add	a0,a0,a5
        if (*s >= '0' && *s <= '9')
 63c:	00074783          	lbu	a5,0(a4)
 640:	fd07869b          	addw	a3,a5,-48
 644:	0ff6f693          	zext.b	a3,a3
 648:	fed872e3          	bgeu	a6,a3,62c <strtol+0x74>
        else if (*s >= 'a' && *s <= 'z')
 64c:	f9f7869b          	addw	a3,a5,-97
 650:	0ff6f693          	zext.b	a3,a3
 654:	00d8e563          	bltu	a7,a3,65e <strtol+0xa6>
            dig = *s - 'a' + 10;
 658:	fa97879b          	addw	a5,a5,-87
 65c:	bfd1                	j	630 <strtol+0x78>
        else if (*s >= 'A' && *s <= 'Z')
 65e:	fbf7869b          	addw	a3,a5,-65
 662:	0ff6f693          	zext.b	a3,a3
 666:	00d8e563          	bltu	a7,a3,670 <strtol+0xb8>
            dig = *s - 'A' + 10;
 66a:	fc97879b          	addw	a5,a5,-55
 66e:	b7c9                	j	630 <strtol+0x78>
        // we don't properly detect overflow!
    }

    if (endptr)
 670:	c191                	beqz	a1,674 <strtol+0xbc>
        *endptr = (char *) s;
 672:	e198                	sd	a4,0(a1)
    return (neg ? -val : val);
 674:	00030463          	beqz	t1,67c <strtol+0xc4>
 678:	40a00533          	neg	a0,a0
}
 67c:	6422                	ld	s0,8(sp)
 67e:	0141                	add	sp,sp,16
 680:	8082                	ret

0000000000000682 <inet_pton>:
inet_pton (int family, const char *p, void *n) {
    char *sp, *ep;
    int idx;
    long ret;

    if (family != AF_INET) {
 682:	4785                	li	a5,1
 684:	08f51063          	bne	a0,a5,704 <inet_pton+0x82>
inet_pton (int family, const char *p, void *n) {
 688:	715d                	add	sp,sp,-80
 68a:	e486                	sd	ra,72(sp)
 68c:	e0a2                	sd	s0,64(sp)
 68e:	fc26                	sd	s1,56(sp)
 690:	f84a                	sd	s2,48(sp)
 692:	f44e                	sd	s3,40(sp)
 694:	f052                	sd	s4,32(sp)
 696:	ec56                	sd	s5,24(sp)
 698:	e85a                	sd	s6,16(sp)
 69a:	0880                	add	s0,sp,80
 69c:	84ae                	mv	s1,a1
 69e:	89b2                	mv	s3,a2
 6a0:	4901                	li	s2,0
        return -1;
    }
    sp = (char *)p;
    for (idx = 0; idx < 4; idx++) {
        ret = strtol(sp, &ep, 10);
        if (ret < 0 || ret > 255) {
 6a2:	0ff00a13          	li	s4,255
            return -1;
        }
        if (ep == sp) {
            return -1;
        }
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 6a6:	4a8d                	li	s5,3
 6a8:	02e00b13          	li	s6,46
 6ac:	a805                	j	6dc <inet_pton+0x5a>
 6ae:	0007c783          	lbu	a5,0(a5)
 6b2:	efb9                	bnez	a5,710 <inet_pton+0x8e>
            return -1;
        }
        ((uint8_t *)n)[idx] = ret;
 6b4:	00a981a3          	sb	a0,3(s3)
        sp = ep + 1;
    }
    return 0;
 6b8:	4501                	li	a0,0
}
 6ba:	60a6                	ld	ra,72(sp)
 6bc:	6406                	ld	s0,64(sp)
 6be:	74e2                	ld	s1,56(sp)
 6c0:	7942                	ld	s2,48(sp)
 6c2:	79a2                	ld	s3,40(sp)
 6c4:	7a02                	ld	s4,32(sp)
 6c6:	6ae2                	ld	s5,24(sp)
 6c8:	6b42                	ld	s6,16(sp)
 6ca:	6161                	add	sp,sp,80
 6cc:	8082                	ret
        ((uint8_t *)n)[idx] = ret;
 6ce:	01298733          	add	a4,s3,s2
 6d2:	00a70023          	sb	a0,0(a4)
        sp = ep + 1;
 6d6:	00178493          	add	s1,a5,1
    for (idx = 0; idx < 4; idx++) {
 6da:	0905                	add	s2,s2,1
        ret = strtol(sp, &ep, 10);
 6dc:	4629                	li	a2,10
 6de:	fb840593          	add	a1,s0,-72
 6e2:	8526                	mv	a0,s1
 6e4:	ed5ff0ef          	jal	5b8 <strtol>
        if (ret < 0 || ret > 255) {
 6e8:	02aa6063          	bltu	s4,a0,708 <inet_pton+0x86>
        if (ep == sp) {
 6ec:	fb843783          	ld	a5,-72(s0)
 6f0:	00978e63          	beq	a5,s1,70c <inet_pton+0x8a>
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 6f4:	fb590de3          	beq	s2,s5,6ae <inet_pton+0x2c>
 6f8:	0007c703          	lbu	a4,0(a5)
 6fc:	fd6709e3          	beq	a4,s6,6ce <inet_pton+0x4c>
            return -1;
 700:	557d                	li	a0,-1
 702:	bf65                	j	6ba <inet_pton+0x38>
        return -1;
 704:	557d                	li	a0,-1
}
 706:	8082                	ret
            return -1;
 708:	557d                	li	a0,-1
 70a:	bf45                	j	6ba <inet_pton+0x38>
            return -1;
 70c:	557d                	li	a0,-1
 70e:	b775                	j	6ba <inet_pton+0x38>
            return -1;
 710:	557d                	li	a0,-1
 712:	b765                	j	6ba <inet_pton+0x38>

0000000000000714 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 714:	4885                	li	a7,1
 ecall
 716:	00000073          	ecall
 ret
 71a:	8082                	ret

000000000000071c <exit>:
.global exit
exit:
 li a7, SYS_exit
 71c:	4889                	li	a7,2
 ecall
 71e:	00000073          	ecall
 ret
 722:	8082                	ret

0000000000000724 <wait>:
.global wait
wait:
 li a7, SYS_wait
 724:	488d                	li	a7,3
 ecall
 726:	00000073          	ecall
 ret
 72a:	8082                	ret

000000000000072c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 72c:	4891                	li	a7,4
 ecall
 72e:	00000073          	ecall
 ret
 732:	8082                	ret

0000000000000734 <read>:
.global read
read:
 li a7, SYS_read
 734:	4895                	li	a7,5
 ecall
 736:	00000073          	ecall
 ret
 73a:	8082                	ret

000000000000073c <write>:
.global write
write:
 li a7, SYS_write
 73c:	48c1                	li	a7,16
 ecall
 73e:	00000073          	ecall
 ret
 742:	8082                	ret

0000000000000744 <close>:
.global close
close:
 li a7, SYS_close
 744:	48d5                	li	a7,21
 ecall
 746:	00000073          	ecall
 ret
 74a:	8082                	ret

000000000000074c <kill>:
.global kill
kill:
 li a7, SYS_kill
 74c:	4899                	li	a7,6
 ecall
 74e:	00000073          	ecall
 ret
 752:	8082                	ret

0000000000000754 <exec>:
.global exec
exec:
 li a7, SYS_exec
 754:	489d                	li	a7,7
 ecall
 756:	00000073          	ecall
 ret
 75a:	8082                	ret

000000000000075c <open>:
.global open
open:
 li a7, SYS_open
 75c:	48bd                	li	a7,15
 ecall
 75e:	00000073          	ecall
 ret
 762:	8082                	ret

0000000000000764 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 764:	48c5                	li	a7,17
 ecall
 766:	00000073          	ecall
 ret
 76a:	8082                	ret

000000000000076c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 76c:	48c9                	li	a7,18
 ecall
 76e:	00000073          	ecall
 ret
 772:	8082                	ret

0000000000000774 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 774:	48a1                	li	a7,8
 ecall
 776:	00000073          	ecall
 ret
 77a:	8082                	ret

000000000000077c <link>:
.global link
link:
 li a7, SYS_link
 77c:	48cd                	li	a7,19
 ecall
 77e:	00000073          	ecall
 ret
 782:	8082                	ret

0000000000000784 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 784:	48d1                	li	a7,20
 ecall
 786:	00000073          	ecall
 ret
 78a:	8082                	ret

000000000000078c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 78c:	48a5                	li	a7,9
 ecall
 78e:	00000073          	ecall
 ret
 792:	8082                	ret

0000000000000794 <dup>:
.global dup
dup:
 li a7, SYS_dup
 794:	48a9                	li	a7,10
 ecall
 796:	00000073          	ecall
 ret
 79a:	8082                	ret

000000000000079c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 79c:	48ad                	li	a7,11
 ecall
 79e:	00000073          	ecall
 ret
 7a2:	8082                	ret

00000000000007a4 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 7a4:	48b1                	li	a7,12
 ecall
 7a6:	00000073          	ecall
 ret
 7aa:	8082                	ret

00000000000007ac <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 7ac:	48b5                	li	a7,13
 ecall
 7ae:	00000073          	ecall
 ret
 7b2:	8082                	ret

00000000000007b4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 7b4:	48b9                	li	a7,14
 ecall
 7b6:	00000073          	ecall
 ret
 7ba:	8082                	ret

00000000000007bc <socket>:
.global socket
socket:
 li a7, SYS_socket
 7bc:	48d9                	li	a7,22
 ecall
 7be:	00000073          	ecall
 ret
 7c2:	8082                	ret

00000000000007c4 <bind>:
.global bind
bind:
 li a7, SYS_bind
 7c4:	48dd                	li	a7,23
 ecall
 7c6:	00000073          	ecall
 ret
 7ca:	8082                	ret

00000000000007cc <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 7cc:	48e1                	li	a7,24
 ecall
 7ce:	00000073          	ecall
 ret
 7d2:	8082                	ret

00000000000007d4 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 7d4:	48e5                	li	a7,25
 ecall
 7d6:	00000073          	ecall
 ret
 7da:	8082                	ret

00000000000007dc <connect>:
.global connect
connect:
 li a7, SYS_connect
 7dc:	48e9                	li	a7,26
 ecall
 7de:	00000073          	ecall
 ret
 7e2:	8082                	ret

00000000000007e4 <listen>:
.global listen
listen:
 li a7, SYS_listen
 7e4:	48ed                	li	a7,27
 ecall
 7e6:	00000073          	ecall
 ret
 7ea:	8082                	ret

00000000000007ec <accept>:
.global accept
accept:
 li a7, SYS_accept
 7ec:	48f1                	li	a7,28
 ecall
 7ee:	00000073          	ecall
 ret
 7f2:	8082                	ret

00000000000007f4 <recv>:
.global recv
recv:
 li a7, SYS_recv
 7f4:	48f5                	li	a7,29
 ecall
 7f6:	00000073          	ecall
 ret
 7fa:	8082                	ret

00000000000007fc <send>:
.global send
send:
 li a7, SYS_send
 7fc:	48f9                	li	a7,30
 ecall
 7fe:	00000073          	ecall
 ret
 802:	8082                	ret

0000000000000804 <ioctl>:
.global ioctl
ioctl:
 li a7, SYS_ioctl
 804:	48fd                	li	a7,31
 ecall
 806:	00000073          	ecall
 ret
 80a:	8082                	ret

000000000000080c <consolemode>:
.global consolemode
consolemode:
 li a7, SYS_consolemode
 80c:	02000893          	li	a7,32
 ecall
 810:	00000073          	ecall
 ret
 814:	8082                	ret

0000000000000816 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 816:	1101                	add	sp,sp,-32
 818:	ec06                	sd	ra,24(sp)
 81a:	e822                	sd	s0,16(sp)
 81c:	1000                	add	s0,sp,32
 81e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 822:	4605                	li	a2,1
 824:	fef40593          	add	a1,s0,-17
 828:	f15ff0ef          	jal	73c <write>
}
 82c:	60e2                	ld	ra,24(sp)
 82e:	6442                	ld	s0,16(sp)
 830:	6105                	add	sp,sp,32
 832:	8082                	ret

0000000000000834 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 834:	715d                	add	sp,sp,-80
 836:	e486                	sd	ra,72(sp)
 838:	e0a2                	sd	s0,64(sp)
 83a:	fc26                	sd	s1,56(sp)
 83c:	0880                	add	s0,sp,80
 83e:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 840:	c299                	beqz	a3,846 <printint+0x12>
 842:	0805c963          	bltz	a1,8d4 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 846:	2581                	sext.w	a1,a1
  neg = 0;
 848:	4881                	li	a7,0
 84a:	fb840693          	add	a3,s0,-72
  }

  i = 0;
 84e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 850:	2601                	sext.w	a2,a2
 852:	00000517          	auipc	a0,0x0
 856:	63e50513          	add	a0,a0,1598 # e90 <digits>
 85a:	883a                	mv	a6,a4
 85c:	2705                	addw	a4,a4,1
 85e:	02c5f7bb          	remuw	a5,a1,a2
 862:	1782                	sll	a5,a5,0x20
 864:	9381                	srl	a5,a5,0x20
 866:	97aa                	add	a5,a5,a0
 868:	0007c783          	lbu	a5,0(a5)
 86c:	00f68023          	sb	a5,0(a3) # ff0000 <base+0xfeef70>
  }while((x /= base) != 0);
 870:	0005879b          	sext.w	a5,a1
 874:	02c5d5bb          	divuw	a1,a1,a2
 878:	0685                	add	a3,a3,1
 87a:	fec7f0e3          	bgeu	a5,a2,85a <printint+0x26>
  if(neg)
 87e:	00088c63          	beqz	a7,896 <printint+0x62>
    buf[i++] = '-';
 882:	fd070793          	add	a5,a4,-48
 886:	00878733          	add	a4,a5,s0
 88a:	02d00793          	li	a5,45
 88e:	fef70423          	sb	a5,-24(a4)
 892:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 896:	02e05a63          	blez	a4,8ca <printint+0x96>
 89a:	f84a                	sd	s2,48(sp)
 89c:	f44e                	sd	s3,40(sp)
 89e:	fb840793          	add	a5,s0,-72
 8a2:	00e78933          	add	s2,a5,a4
 8a6:	fff78993          	add	s3,a5,-1
 8aa:	99ba                	add	s3,s3,a4
 8ac:	377d                	addw	a4,a4,-1
 8ae:	1702                	sll	a4,a4,0x20
 8b0:	9301                	srl	a4,a4,0x20
 8b2:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 8b6:	fff94583          	lbu	a1,-1(s2)
 8ba:	8526                	mv	a0,s1
 8bc:	f5bff0ef          	jal	816 <putc>
  while(--i >= 0)
 8c0:	197d                	add	s2,s2,-1
 8c2:	ff391ae3          	bne	s2,s3,8b6 <printint+0x82>
 8c6:	7942                	ld	s2,48(sp)
 8c8:	79a2                	ld	s3,40(sp)
}
 8ca:	60a6                	ld	ra,72(sp)
 8cc:	6406                	ld	s0,64(sp)
 8ce:	74e2                	ld	s1,56(sp)
 8d0:	6161                	add	sp,sp,80
 8d2:	8082                	ret
    x = -xx;
 8d4:	40b005bb          	negw	a1,a1
    neg = 1;
 8d8:	4885                	li	a7,1
    x = -xx;
 8da:	bf85                	j	84a <printint+0x16>

00000000000008dc <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 8dc:	711d                	add	sp,sp,-96
 8de:	ec86                	sd	ra,88(sp)
 8e0:	e8a2                	sd	s0,80(sp)
 8e2:	e0ca                	sd	s2,64(sp)
 8e4:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 8e6:	0005c903          	lbu	s2,0(a1)
 8ea:	26090863          	beqz	s2,b5a <vprintf+0x27e>
 8ee:	e4a6                	sd	s1,72(sp)
 8f0:	fc4e                	sd	s3,56(sp)
 8f2:	f852                	sd	s4,48(sp)
 8f4:	f456                	sd	s5,40(sp)
 8f6:	f05a                	sd	s6,32(sp)
 8f8:	ec5e                	sd	s7,24(sp)
 8fa:	e862                	sd	s8,16(sp)
 8fc:	e466                	sd	s9,8(sp)
 8fe:	8b2a                	mv	s6,a0
 900:	8a2e                	mv	s4,a1
 902:	8bb2                	mv	s7,a2
  state = 0;
 904:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 906:	4481                	li	s1,0
 908:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 90a:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 90e:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 912:	06c00c93          	li	s9,108
 916:	a005                	j	936 <vprintf+0x5a>
        putc(fd, c0);
 918:	85ca                	mv	a1,s2
 91a:	855a                	mv	a0,s6
 91c:	efbff0ef          	jal	816 <putc>
 920:	a019                	j	926 <vprintf+0x4a>
    } else if(state == '%'){
 922:	03598263          	beq	s3,s5,946 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 926:	2485                	addw	s1,s1,1
 928:	8726                	mv	a4,s1
 92a:	009a07b3          	add	a5,s4,s1
 92e:	0007c903          	lbu	s2,0(a5)
 932:	20090c63          	beqz	s2,b4a <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 936:	0009079b          	sext.w	a5,s2
    if(state == 0){
 93a:	fe0994e3          	bnez	s3,922 <vprintf+0x46>
      if(c0 == '%'){
 93e:	fd579de3          	bne	a5,s5,918 <vprintf+0x3c>
        state = '%';
 942:	89be                	mv	s3,a5
 944:	b7cd                	j	926 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 946:	00ea06b3          	add	a3,s4,a4
 94a:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 94e:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 950:	c681                	beqz	a3,958 <vprintf+0x7c>
 952:	9752                	add	a4,a4,s4
 954:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 958:	03878f63          	beq	a5,s8,996 <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 95c:	05978963          	beq	a5,s9,9ae <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 960:	07500713          	li	a4,117
 964:	0ee78363          	beq	a5,a4,a4a <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 968:	07800713          	li	a4,120
 96c:	12e78563          	beq	a5,a4,a96 <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 970:	07000713          	li	a4,112
 974:	14e78a63          	beq	a5,a4,ac8 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 978:	07300713          	li	a4,115
 97c:	18e78a63          	beq	a5,a4,b10 <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 980:	02500713          	li	a4,37
 984:	04e79563          	bne	a5,a4,9ce <vprintf+0xf2>
        putc(fd, '%');
 988:	02500593          	li	a1,37
 98c:	855a                	mv	a0,s6
 98e:	e89ff0ef          	jal	816 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 992:	4981                	li	s3,0
 994:	bf49                	j	926 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 996:	008b8913          	add	s2,s7,8
 99a:	4685                	li	a3,1
 99c:	4629                	li	a2,10
 99e:	000ba583          	lw	a1,0(s7)
 9a2:	855a                	mv	a0,s6
 9a4:	e91ff0ef          	jal	834 <printint>
 9a8:	8bca                	mv	s7,s2
      state = 0;
 9aa:	4981                	li	s3,0
 9ac:	bfad                	j	926 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 9ae:	06400793          	li	a5,100
 9b2:	02f68963          	beq	a3,a5,9e4 <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 9b6:	06c00793          	li	a5,108
 9ba:	04f68263          	beq	a3,a5,9fe <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 9be:	07500793          	li	a5,117
 9c2:	0af68063          	beq	a3,a5,a62 <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 9c6:	07800793          	li	a5,120
 9ca:	0ef68263          	beq	a3,a5,aae <vprintf+0x1d2>
        putc(fd, '%');
 9ce:	02500593          	li	a1,37
 9d2:	855a                	mv	a0,s6
 9d4:	e43ff0ef          	jal	816 <putc>
        putc(fd, c0);
 9d8:	85ca                	mv	a1,s2
 9da:	855a                	mv	a0,s6
 9dc:	e3bff0ef          	jal	816 <putc>
      state = 0;
 9e0:	4981                	li	s3,0
 9e2:	b791                	j	926 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 9e4:	008b8913          	add	s2,s7,8
 9e8:	4685                	li	a3,1
 9ea:	4629                	li	a2,10
 9ec:	000bb583          	ld	a1,0(s7)
 9f0:	855a                	mv	a0,s6
 9f2:	e43ff0ef          	jal	834 <printint>
        i += 1;
 9f6:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 9f8:	8bca                	mv	s7,s2
      state = 0;
 9fa:	4981                	li	s3,0
        i += 1;
 9fc:	b72d                	j	926 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 9fe:	06400793          	li	a5,100
 a02:	02f60763          	beq	a2,a5,a30 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 a06:	07500793          	li	a5,117
 a0a:	06f60963          	beq	a2,a5,a7c <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 a0e:	07800793          	li	a5,120
 a12:	faf61ee3          	bne	a2,a5,9ce <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 a16:	008b8913          	add	s2,s7,8
 a1a:	4681                	li	a3,0
 a1c:	4641                	li	a2,16
 a1e:	000bb583          	ld	a1,0(s7)
 a22:	855a                	mv	a0,s6
 a24:	e11ff0ef          	jal	834 <printint>
        i += 2;
 a28:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 a2a:	8bca                	mv	s7,s2
      state = 0;
 a2c:	4981                	li	s3,0
        i += 2;
 a2e:	bde5                	j	926 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 a30:	008b8913          	add	s2,s7,8
 a34:	4685                	li	a3,1
 a36:	4629                	li	a2,10
 a38:	000bb583          	ld	a1,0(s7)
 a3c:	855a                	mv	a0,s6
 a3e:	df7ff0ef          	jal	834 <printint>
        i += 2;
 a42:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 a44:	8bca                	mv	s7,s2
      state = 0;
 a46:	4981                	li	s3,0
        i += 2;
 a48:	bdf9                	j	926 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 a4a:	008b8913          	add	s2,s7,8
 a4e:	4681                	li	a3,0
 a50:	4629                	li	a2,10
 a52:	000ba583          	lw	a1,0(s7)
 a56:	855a                	mv	a0,s6
 a58:	dddff0ef          	jal	834 <printint>
 a5c:	8bca                	mv	s7,s2
      state = 0;
 a5e:	4981                	li	s3,0
 a60:	b5d9                	j	926 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 a62:	008b8913          	add	s2,s7,8
 a66:	4681                	li	a3,0
 a68:	4629                	li	a2,10
 a6a:	000bb583          	ld	a1,0(s7)
 a6e:	855a                	mv	a0,s6
 a70:	dc5ff0ef          	jal	834 <printint>
        i += 1;
 a74:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 a76:	8bca                	mv	s7,s2
      state = 0;
 a78:	4981                	li	s3,0
        i += 1;
 a7a:	b575                	j	926 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 a7c:	008b8913          	add	s2,s7,8
 a80:	4681                	li	a3,0
 a82:	4629                	li	a2,10
 a84:	000bb583          	ld	a1,0(s7)
 a88:	855a                	mv	a0,s6
 a8a:	dabff0ef          	jal	834 <printint>
        i += 2;
 a8e:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 a90:	8bca                	mv	s7,s2
      state = 0;
 a92:	4981                	li	s3,0
        i += 2;
 a94:	bd49                	j	926 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 a96:	008b8913          	add	s2,s7,8
 a9a:	4681                	li	a3,0
 a9c:	4641                	li	a2,16
 a9e:	000ba583          	lw	a1,0(s7)
 aa2:	855a                	mv	a0,s6
 aa4:	d91ff0ef          	jal	834 <printint>
 aa8:	8bca                	mv	s7,s2
      state = 0;
 aaa:	4981                	li	s3,0
 aac:	bdad                	j	926 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 aae:	008b8913          	add	s2,s7,8
 ab2:	4681                	li	a3,0
 ab4:	4641                	li	a2,16
 ab6:	000bb583          	ld	a1,0(s7)
 aba:	855a                	mv	a0,s6
 abc:	d79ff0ef          	jal	834 <printint>
        i += 1;
 ac0:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 ac2:	8bca                	mv	s7,s2
      state = 0;
 ac4:	4981                	li	s3,0
        i += 1;
 ac6:	b585                	j	926 <vprintf+0x4a>
 ac8:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 aca:	008b8d13          	add	s10,s7,8
 ace:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 ad2:	03000593          	li	a1,48
 ad6:	855a                	mv	a0,s6
 ad8:	d3fff0ef          	jal	816 <putc>
  putc(fd, 'x');
 adc:	07800593          	li	a1,120
 ae0:	855a                	mv	a0,s6
 ae2:	d35ff0ef          	jal	816 <putc>
 ae6:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 ae8:	00000b97          	auipc	s7,0x0
 aec:	3a8b8b93          	add	s7,s7,936 # e90 <digits>
 af0:	03c9d793          	srl	a5,s3,0x3c
 af4:	97de                	add	a5,a5,s7
 af6:	0007c583          	lbu	a1,0(a5)
 afa:	855a                	mv	a0,s6
 afc:	d1bff0ef          	jal	816 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 b00:	0992                	sll	s3,s3,0x4
 b02:	397d                	addw	s2,s2,-1
 b04:	fe0916e3          	bnez	s2,af0 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 b08:	8bea                	mv	s7,s10
      state = 0;
 b0a:	4981                	li	s3,0
 b0c:	6d02                	ld	s10,0(sp)
 b0e:	bd21                	j	926 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 b10:	008b8993          	add	s3,s7,8
 b14:	000bb903          	ld	s2,0(s7)
 b18:	00090f63          	beqz	s2,b36 <vprintf+0x25a>
        for(; *s; s++)
 b1c:	00094583          	lbu	a1,0(s2)
 b20:	c195                	beqz	a1,b44 <vprintf+0x268>
          putc(fd, *s);
 b22:	855a                	mv	a0,s6
 b24:	cf3ff0ef          	jal	816 <putc>
        for(; *s; s++)
 b28:	0905                	add	s2,s2,1
 b2a:	00094583          	lbu	a1,0(s2)
 b2e:	f9f5                	bnez	a1,b22 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 b30:	8bce                	mv	s7,s3
      state = 0;
 b32:	4981                	li	s3,0
 b34:	bbcd                	j	926 <vprintf+0x4a>
          s = "(null)";
 b36:	00000917          	auipc	s2,0x0
 b3a:	35290913          	add	s2,s2,850 # e88 <malloc+0x23e>
        for(; *s; s++)
 b3e:	02800593          	li	a1,40
 b42:	b7c5                	j	b22 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 b44:	8bce                	mv	s7,s3
      state = 0;
 b46:	4981                	li	s3,0
 b48:	bbf9                	j	926 <vprintf+0x4a>
 b4a:	64a6                	ld	s1,72(sp)
 b4c:	79e2                	ld	s3,56(sp)
 b4e:	7a42                	ld	s4,48(sp)
 b50:	7aa2                	ld	s5,40(sp)
 b52:	7b02                	ld	s6,32(sp)
 b54:	6be2                	ld	s7,24(sp)
 b56:	6c42                	ld	s8,16(sp)
 b58:	6ca2                	ld	s9,8(sp)
    }
  }
}
 b5a:	60e6                	ld	ra,88(sp)
 b5c:	6446                	ld	s0,80(sp)
 b5e:	6906                	ld	s2,64(sp)
 b60:	6125                	add	sp,sp,96
 b62:	8082                	ret

0000000000000b64 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 b64:	715d                	add	sp,sp,-80
 b66:	ec06                	sd	ra,24(sp)
 b68:	e822                	sd	s0,16(sp)
 b6a:	1000                	add	s0,sp,32
 b6c:	e010                	sd	a2,0(s0)
 b6e:	e414                	sd	a3,8(s0)
 b70:	e818                	sd	a4,16(s0)
 b72:	ec1c                	sd	a5,24(s0)
 b74:	03043023          	sd	a6,32(s0)
 b78:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 b7c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 b80:	8622                	mv	a2,s0
 b82:	d5bff0ef          	jal	8dc <vprintf>
}
 b86:	60e2                	ld	ra,24(sp)
 b88:	6442                	ld	s0,16(sp)
 b8a:	6161                	add	sp,sp,80
 b8c:	8082                	ret

0000000000000b8e <printf>:

void
printf(const char *fmt, ...)
{
 b8e:	711d                	add	sp,sp,-96
 b90:	ec06                	sd	ra,24(sp)
 b92:	e822                	sd	s0,16(sp)
 b94:	1000                	add	s0,sp,32
 b96:	e40c                	sd	a1,8(s0)
 b98:	e810                	sd	a2,16(s0)
 b9a:	ec14                	sd	a3,24(s0)
 b9c:	f018                	sd	a4,32(s0)
 b9e:	f41c                	sd	a5,40(s0)
 ba0:	03043823          	sd	a6,48(s0)
 ba4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 ba8:	00840613          	add	a2,s0,8
 bac:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 bb0:	85aa                	mv	a1,a0
 bb2:	4505                	li	a0,1
 bb4:	d29ff0ef          	jal	8dc <vprintf>
}
 bb8:	60e2                	ld	ra,24(sp)
 bba:	6442                	ld	s0,16(sp)
 bbc:	6125                	add	sp,sp,96
 bbe:	8082                	ret

0000000000000bc0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 bc0:	1141                	add	sp,sp,-16
 bc2:	e422                	sd	s0,8(sp)
 bc4:	0800                	add	s0,sp,16
  Header *bp, *p;

  if(ap == 0)
 bc6:	cd3d                	beqz	a0,c44 <free+0x84>
    return;
  if((uint64)ap < 4096)
 bc8:	6785                	lui	a5,0x1
 bca:	06f56d63          	bltu	a0,a5,c44 <free+0x84>
    return;
  bp = (Header*)ap - 1;
 bce:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bd2:	00000797          	auipc	a5,0x0
 bd6:	4b67b783          	ld	a5,1206(a5) # 1088 <freep>
 bda:	a02d                	j	c04 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 bdc:	4618                	lw	a4,8(a2)
 bde:	9f2d                	addw	a4,a4,a1
 be0:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 be4:	6398                	ld	a4,0(a5)
 be6:	6310                	ld	a2,0(a4)
 be8:	a83d                	j	c26 <free+0x66>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 bea:	ff852703          	lw	a4,-8(a0)
 bee:	9f31                	addw	a4,a4,a2
 bf0:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 bf2:	ff053683          	ld	a3,-16(a0)
 bf6:	a091                	j	c3a <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bf8:	6398                	ld	a4,0(a5)
 bfa:	00e7e463          	bltu	a5,a4,c02 <free+0x42>
 bfe:	00e6ea63          	bltu	a3,a4,c12 <free+0x52>
{
 c02:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c04:	fed7fae3          	bgeu	a5,a3,bf8 <free+0x38>
 c08:	6398                	ld	a4,0(a5)
 c0a:	00e6e463          	bltu	a3,a4,c12 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c0e:	fee7eae3          	bltu	a5,a4,c02 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 c12:	ff852583          	lw	a1,-8(a0)
 c16:	6390                	ld	a2,0(a5)
 c18:	02059813          	sll	a6,a1,0x20
 c1c:	01c85713          	srl	a4,a6,0x1c
 c20:	9736                	add	a4,a4,a3
 c22:	fae60de3          	beq	a2,a4,bdc <free+0x1c>
    bp->s.ptr = p->s.ptr->s.ptr;
 c26:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 c2a:	4790                	lw	a2,8(a5)
 c2c:	02061593          	sll	a1,a2,0x20
 c30:	01c5d713          	srl	a4,a1,0x1c
 c34:	973e                	add	a4,a4,a5
 c36:	fae68ae3          	beq	a3,a4,bea <free+0x2a>
    p->s.ptr = bp->s.ptr;
 c3a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 c3c:	00000717          	auipc	a4,0x0
 c40:	44f73623          	sd	a5,1100(a4) # 1088 <freep>
}
 c44:	6422                	ld	s0,8(sp)
 c46:	0141                	add	sp,sp,16
 c48:	8082                	ret

0000000000000c4a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 c4a:	7139                	add	sp,sp,-64
 c4c:	fc06                	sd	ra,56(sp)
 c4e:	f822                	sd	s0,48(sp)
 c50:	f426                	sd	s1,40(sp)
 c52:	ec4e                	sd	s3,24(sp)
 c54:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c56:	02051493          	sll	s1,a0,0x20
 c5a:	9081                	srl	s1,s1,0x20
 c5c:	04bd                	add	s1,s1,15
 c5e:	8091                	srl	s1,s1,0x4
 c60:	0014899b          	addw	s3,s1,1
 c64:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 c66:	00000517          	auipc	a0,0x0
 c6a:	42253503          	ld	a0,1058(a0) # 1088 <freep>
 c6e:	c915                	beqz	a0,ca2 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c70:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c72:	4798                	lw	a4,8(a5)
 c74:	08977a63          	bgeu	a4,s1,d08 <malloc+0xbe>
 c78:	f04a                	sd	s2,32(sp)
 c7a:	e852                	sd	s4,16(sp)
 c7c:	e456                	sd	s5,8(sp)
 c7e:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 c80:	8a4e                	mv	s4,s3
 c82:	0009871b          	sext.w	a4,s3
 c86:	6685                	lui	a3,0x1
 c88:	00d77363          	bgeu	a4,a3,c8e <malloc+0x44>
 c8c:	6a05                	lui	s4,0x1
 c8e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 c92:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 c96:	00000917          	auipc	s2,0x0
 c9a:	3f290913          	add	s2,s2,1010 # 1088 <freep>
  if(p == (char*)-1)
 c9e:	5afd                	li	s5,-1
 ca0:	a081                	j	ce0 <malloc+0x96>
 ca2:	f04a                	sd	s2,32(sp)
 ca4:	e852                	sd	s4,16(sp)
 ca6:	e456                	sd	s5,8(sp)
 ca8:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 caa:	00000797          	auipc	a5,0x0
 cae:	3e678793          	add	a5,a5,998 # 1090 <base>
 cb2:	00000717          	auipc	a4,0x0
 cb6:	3cf73b23          	sd	a5,982(a4) # 1088 <freep>
 cba:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 cbc:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 cc0:	b7c1                	j	c80 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 cc2:	6398                	ld	a4,0(a5)
 cc4:	e118                	sd	a4,0(a0)
 cc6:	a8a9                	j	d20 <malloc+0xd6>
  hp->s.size = nu;
 cc8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 ccc:	0541                	add	a0,a0,16
 cce:	ef3ff0ef          	jal	bc0 <free>
  return freep;
 cd2:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 cd6:	c12d                	beqz	a0,d38 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 cd8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 cda:	4798                	lw	a4,8(a5)
 cdc:	02977263          	bgeu	a4,s1,d00 <malloc+0xb6>
    if(p == freep)
 ce0:	00093703          	ld	a4,0(s2)
 ce4:	853e                	mv	a0,a5
 ce6:	fef719e3          	bne	a4,a5,cd8 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 cea:	8552                	mv	a0,s4
 cec:	ab9ff0ef          	jal	7a4 <sbrk>
  if(p == (char*)-1)
 cf0:	fd551ce3          	bne	a0,s5,cc8 <malloc+0x7e>
        return 0;
 cf4:	4501                	li	a0,0
 cf6:	7902                	ld	s2,32(sp)
 cf8:	6a42                	ld	s4,16(sp)
 cfa:	6aa2                	ld	s5,8(sp)
 cfc:	6b02                	ld	s6,0(sp)
 cfe:	a03d                	j	d2c <malloc+0xe2>
 d00:	7902                	ld	s2,32(sp)
 d02:	6a42                	ld	s4,16(sp)
 d04:	6aa2                	ld	s5,8(sp)
 d06:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 d08:	fae48de3          	beq	s1,a4,cc2 <malloc+0x78>
        p->s.size -= nunits;
 d0c:	4137073b          	subw	a4,a4,s3
 d10:	c798                	sw	a4,8(a5)
        p += p->s.size;
 d12:	02071693          	sll	a3,a4,0x20
 d16:	01c6d713          	srl	a4,a3,0x1c
 d1a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 d1c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 d20:	00000717          	auipc	a4,0x0
 d24:	36a73423          	sd	a0,872(a4) # 1088 <freep>
      return (void*)(p + 1);
 d28:	01078513          	add	a0,a5,16
  }
}
 d2c:	70e2                	ld	ra,56(sp)
 d2e:	7442                	ld	s0,48(sp)
 d30:	74a2                	ld	s1,40(sp)
 d32:	69e2                	ld	s3,24(sp)
 d34:	6121                	add	sp,sp,64
 d36:	8082                	ret
 d38:	7902                	ld	s2,32(sp)
 d3a:	6a42                	ld	s4,16(sp)
 d3c:	6aa2                	ld	s5,8(sp)
 d3e:	6b02                	ld	s6,0(sp)
 d40:	b7f5                	j	d2c <malloc+0xe2>
