
user/_wc:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
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
  12:	fc5e                	sd	s7,56(sp)
  14:	f862                	sd	s8,48(sp)
  16:	f466                	sd	s9,40(sp)
  18:	f06a                	sd	s10,32(sp)
  1a:	ec6e                	sd	s11,24(sp)
  1c:	0100                	add	s0,sp,128
  1e:	f8a43423          	sd	a0,-120(s0)
  22:	f8b43023          	sd	a1,-128(s0)
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  26:	4901                	li	s2,0
  l = w = c = 0;
  28:	4d01                	li	s10,0
  2a:	4c81                	li	s9,0
  2c:	4c01                	li	s8,0
  while((n = read(fd, buf, sizeof(buf))) > 0){
  2e:	00001d97          	auipc	s11,0x1
  32:	fe2d8d93          	add	s11,s11,-30 # 1010 <buf>
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
  36:	4aa9                	li	s5,10
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
  38:	00001a17          	auipc	s4,0x1
  3c:	c38a0a13          	add	s4,s4,-968 # c70 <malloc+0x100>
        inword = 0;
  40:	4b81                	li	s7,0
  while((n = read(fd, buf, sizeof(buf))) > 0){
  42:	a035                	j	6e <wc+0x6e>
      if(strchr(" \r\t\n\v", buf[i]))
  44:	8552                	mv	a0,s4
  46:	1bc000ef          	jal	202 <strchr>
  4a:	c919                	beqz	a0,60 <wc+0x60>
        inword = 0;
  4c:	895e                	mv	s2,s7
    for(i=0; i<n; i++){
  4e:	0485                	add	s1,s1,1
  50:	01348d63          	beq	s1,s3,6a <wc+0x6a>
      if(buf[i] == '\n')
  54:	0004c583          	lbu	a1,0(s1)
  58:	ff5596e3          	bne	a1,s5,44 <wc+0x44>
        l++;
  5c:	2c05                	addw	s8,s8,1
  5e:	b7dd                	j	44 <wc+0x44>
      else if(!inword){
  60:	fe0917e3          	bnez	s2,4e <wc+0x4e>
        w++;
  64:	2c85                	addw	s9,s9,1
        inword = 1;
  66:	4905                	li	s2,1
  68:	b7dd                	j	4e <wc+0x4e>
  6a:	01ab0d3b          	addw	s10,s6,s10
  while((n = read(fd, buf, sizeof(buf))) > 0){
  6e:	20000613          	li	a2,512
  72:	85ee                	mv	a1,s11
  74:	f8843503          	ld	a0,-120(s0)
  78:	5e2000ef          	jal	65a <read>
  7c:	8b2a                	mv	s6,a0
  7e:	00a05963          	blez	a0,90 <wc+0x90>
    for(i=0; i<n; i++){
  82:	00001497          	auipc	s1,0x1
  86:	f8e48493          	add	s1,s1,-114 # 1010 <buf>
  8a:	009509b3          	add	s3,a0,s1
  8e:	b7d9                	j	54 <wc+0x54>
      }
    }
  }
  if(n < 0){
  90:	02054c63          	bltz	a0,c8 <wc+0xc8>
    printf("wc: read error\n");
    exit(1);
  }
  printf("%d %d %d %s\n", l, w, c, name);
  94:	f8043703          	ld	a4,-128(s0)
  98:	86ea                	mv	a3,s10
  9a:	8666                	mv	a2,s9
  9c:	85e2                	mv	a1,s8
  9e:	00001517          	auipc	a0,0x1
  a2:	bf250513          	add	a0,a0,-1038 # c90 <malloc+0x120>
  a6:	20f000ef          	jal	ab4 <printf>
}
  aa:	70e6                	ld	ra,120(sp)
  ac:	7446                	ld	s0,112(sp)
  ae:	74a6                	ld	s1,104(sp)
  b0:	7906                	ld	s2,96(sp)
  b2:	69e6                	ld	s3,88(sp)
  b4:	6a46                	ld	s4,80(sp)
  b6:	6aa6                	ld	s5,72(sp)
  b8:	6b06                	ld	s6,64(sp)
  ba:	7be2                	ld	s7,56(sp)
  bc:	7c42                	ld	s8,48(sp)
  be:	7ca2                	ld	s9,40(sp)
  c0:	7d02                	ld	s10,32(sp)
  c2:	6de2                	ld	s11,24(sp)
  c4:	6109                	add	sp,sp,128
  c6:	8082                	ret
    printf("wc: read error\n");
  c8:	00001517          	auipc	a0,0x1
  cc:	bb850513          	add	a0,a0,-1096 # c80 <malloc+0x110>
  d0:	1e5000ef          	jal	ab4 <printf>
    exit(1);
  d4:	4505                	li	a0,1
  d6:	56c000ef          	jal	642 <exit>

00000000000000da <main>:

int
main(int argc, char *argv[])
{
  da:	7179                	add	sp,sp,-48
  dc:	f406                	sd	ra,40(sp)
  de:	f022                	sd	s0,32(sp)
  e0:	1800                	add	s0,sp,48
  int fd, i;

  if(argc <= 1){
  e2:	4785                	li	a5,1
  e4:	04a7d463          	bge	a5,a0,12c <main+0x52>
  e8:	ec26                	sd	s1,24(sp)
  ea:	e84a                	sd	s2,16(sp)
  ec:	e44e                	sd	s3,8(sp)
  ee:	00858913          	add	s2,a1,8
  f2:	ffe5099b          	addw	s3,a0,-2
  f6:	02099793          	sll	a5,s3,0x20
  fa:	01d7d993          	srl	s3,a5,0x1d
  fe:	05c1                	add	a1,a1,16
 100:	99ae                	add	s3,s3,a1
    wc(0, "");
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], O_RDONLY)) < 0){
 102:	4581                	li	a1,0
 104:	00093503          	ld	a0,0(s2)
 108:	57a000ef          	jal	682 <open>
 10c:	84aa                	mv	s1,a0
 10e:	02054c63          	bltz	a0,146 <main+0x6c>
      printf("wc: cannot open %s\n", argv[i]);
      exit(1);
    }
    wc(fd, argv[i]);
 112:	00093583          	ld	a1,0(s2)
 116:	eebff0ef          	jal	0 <wc>
    close(fd);
 11a:	8526                	mv	a0,s1
 11c:	54e000ef          	jal	66a <close>
  for(i = 1; i < argc; i++){
 120:	0921                	add	s2,s2,8
 122:	ff3910e3          	bne	s2,s3,102 <main+0x28>
  }
  exit(0);
 126:	4501                	li	a0,0
 128:	51a000ef          	jal	642 <exit>
 12c:	ec26                	sd	s1,24(sp)
 12e:	e84a                	sd	s2,16(sp)
 130:	e44e                	sd	s3,8(sp)
    wc(0, "");
 132:	00001597          	auipc	a1,0x1
 136:	b4658593          	add	a1,a1,-1210 # c78 <malloc+0x108>
 13a:	4501                	li	a0,0
 13c:	ec5ff0ef          	jal	0 <wc>
    exit(0);
 140:	4501                	li	a0,0
 142:	500000ef          	jal	642 <exit>
      printf("wc: cannot open %s\n", argv[i]);
 146:	00093583          	ld	a1,0(s2)
 14a:	00001517          	auipc	a0,0x1
 14e:	b5650513          	add	a0,a0,-1194 # ca0 <malloc+0x130>
 152:	163000ef          	jal	ab4 <printf>
      exit(1);
 156:	4505                	li	a0,1
 158:	4ea000ef          	jal	642 <exit>

000000000000015c <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 15c:	1141                	add	sp,sp,-16
 15e:	e406                	sd	ra,8(sp)
 160:	e022                	sd	s0,0(sp)
 162:	0800                	add	s0,sp,16
  extern int main();
  main();
 164:	f77ff0ef          	jal	da <main>
  exit(0);
 168:	4501                	li	a0,0
 16a:	4d8000ef          	jal	642 <exit>

000000000000016e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 16e:	1141                	add	sp,sp,-16
 170:	e422                	sd	s0,8(sp)
 172:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 174:	87aa                	mv	a5,a0
 176:	0585                	add	a1,a1,1
 178:	0785                	add	a5,a5,1
 17a:	fff5c703          	lbu	a4,-1(a1)
 17e:	fee78fa3          	sb	a4,-1(a5)
 182:	fb75                	bnez	a4,176 <strcpy+0x8>
    ;
  return os;
}
 184:	6422                	ld	s0,8(sp)
 186:	0141                	add	sp,sp,16
 188:	8082                	ret

000000000000018a <strcmp>:

int
strcmp(const char *p, const char *q)
{
 18a:	1141                	add	sp,sp,-16
 18c:	e422                	sd	s0,8(sp)
 18e:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 190:	00054783          	lbu	a5,0(a0)
 194:	cb91                	beqz	a5,1a8 <strcmp+0x1e>
 196:	0005c703          	lbu	a4,0(a1)
 19a:	00f71763          	bne	a4,a5,1a8 <strcmp+0x1e>
    p++, q++;
 19e:	0505                	add	a0,a0,1
 1a0:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 1a2:	00054783          	lbu	a5,0(a0)
 1a6:	fbe5                	bnez	a5,196 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1a8:	0005c503          	lbu	a0,0(a1)
}
 1ac:	40a7853b          	subw	a0,a5,a0
 1b0:	6422                	ld	s0,8(sp)
 1b2:	0141                	add	sp,sp,16
 1b4:	8082                	ret

00000000000001b6 <strlen>:

uint
strlen(const char *s)
{
 1b6:	1141                	add	sp,sp,-16
 1b8:	e422                	sd	s0,8(sp)
 1ba:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1bc:	00054783          	lbu	a5,0(a0)
 1c0:	cf91                	beqz	a5,1dc <strlen+0x26>
 1c2:	0505                	add	a0,a0,1
 1c4:	87aa                	mv	a5,a0
 1c6:	86be                	mv	a3,a5
 1c8:	0785                	add	a5,a5,1
 1ca:	fff7c703          	lbu	a4,-1(a5)
 1ce:	ff65                	bnez	a4,1c6 <strlen+0x10>
 1d0:	40a6853b          	subw	a0,a3,a0
 1d4:	2505                	addw	a0,a0,1
    ;
  return n;
}
 1d6:	6422                	ld	s0,8(sp)
 1d8:	0141                	add	sp,sp,16
 1da:	8082                	ret
  for(n = 0; s[n]; n++)
 1dc:	4501                	li	a0,0
 1de:	bfe5                	j	1d6 <strlen+0x20>

00000000000001e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1e0:	1141                	add	sp,sp,-16
 1e2:	e422                	sd	s0,8(sp)
 1e4:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1e6:	ca19                	beqz	a2,1fc <memset+0x1c>
 1e8:	87aa                	mv	a5,a0
 1ea:	1602                	sll	a2,a2,0x20
 1ec:	9201                	srl	a2,a2,0x20
 1ee:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1f2:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1f6:	0785                	add	a5,a5,1
 1f8:	fee79de3          	bne	a5,a4,1f2 <memset+0x12>
  }
  return dst;
}
 1fc:	6422                	ld	s0,8(sp)
 1fe:	0141                	add	sp,sp,16
 200:	8082                	ret

0000000000000202 <strchr>:

char*
strchr(const char *s, char c)
{
 202:	1141                	add	sp,sp,-16
 204:	e422                	sd	s0,8(sp)
 206:	0800                	add	s0,sp,16
  for(; *s; s++)
 208:	00054783          	lbu	a5,0(a0)
 20c:	cb99                	beqz	a5,222 <strchr+0x20>
    if(*s == c)
 20e:	00f58763          	beq	a1,a5,21c <strchr+0x1a>
  for(; *s; s++)
 212:	0505                	add	a0,a0,1
 214:	00054783          	lbu	a5,0(a0)
 218:	fbfd                	bnez	a5,20e <strchr+0xc>
      return (char*)s;
  return 0;
 21a:	4501                	li	a0,0
}
 21c:	6422                	ld	s0,8(sp)
 21e:	0141                	add	sp,sp,16
 220:	8082                	ret
  return 0;
 222:	4501                	li	a0,0
 224:	bfe5                	j	21c <strchr+0x1a>

0000000000000226 <gets>:

char*
gets(char *buf, int max)
{
 226:	711d                	add	sp,sp,-96
 228:	ec86                	sd	ra,88(sp)
 22a:	e8a2                	sd	s0,80(sp)
 22c:	e4a6                	sd	s1,72(sp)
 22e:	e0ca                	sd	s2,64(sp)
 230:	fc4e                	sd	s3,56(sp)
 232:	f852                	sd	s4,48(sp)
 234:	f456                	sd	s5,40(sp)
 236:	f05a                	sd	s6,32(sp)
 238:	ec5e                	sd	s7,24(sp)
 23a:	1080                	add	s0,sp,96
 23c:	8baa                	mv	s7,a0
 23e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 240:	892a                	mv	s2,a0
 242:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 244:	4aa9                	li	s5,10
 246:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 248:	89a6                	mv	s3,s1
 24a:	2485                	addw	s1,s1,1
 24c:	0344d663          	bge	s1,s4,278 <gets+0x52>
    cc = read(0, &c, 1);
 250:	4605                	li	a2,1
 252:	faf40593          	add	a1,s0,-81
 256:	4501                	li	a0,0
 258:	402000ef          	jal	65a <read>
    if(cc < 1)
 25c:	00a05e63          	blez	a0,278 <gets+0x52>
    buf[i++] = c;
 260:	faf44783          	lbu	a5,-81(s0)
 264:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 268:	01578763          	beq	a5,s5,276 <gets+0x50>
 26c:	0905                	add	s2,s2,1
 26e:	fd679de3          	bne	a5,s6,248 <gets+0x22>
    buf[i++] = c;
 272:	89a6                	mv	s3,s1
 274:	a011                	j	278 <gets+0x52>
 276:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 278:	99de                	add	s3,s3,s7
 27a:	00098023          	sb	zero,0(s3)
  return buf;
}
 27e:	855e                	mv	a0,s7
 280:	60e6                	ld	ra,88(sp)
 282:	6446                	ld	s0,80(sp)
 284:	64a6                	ld	s1,72(sp)
 286:	6906                	ld	s2,64(sp)
 288:	79e2                	ld	s3,56(sp)
 28a:	7a42                	ld	s4,48(sp)
 28c:	7aa2                	ld	s5,40(sp)
 28e:	7b02                	ld	s6,32(sp)
 290:	6be2                	ld	s7,24(sp)
 292:	6125                	add	sp,sp,96
 294:	8082                	ret

0000000000000296 <stat>:

int
stat(const char *n, struct stat *st)
{
 296:	1101                	add	sp,sp,-32
 298:	ec06                	sd	ra,24(sp)
 29a:	e822                	sd	s0,16(sp)
 29c:	e04a                	sd	s2,0(sp)
 29e:	1000                	add	s0,sp,32
 2a0:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2a2:	4581                	li	a1,0
 2a4:	3de000ef          	jal	682 <open>
  if(fd < 0)
 2a8:	02054263          	bltz	a0,2cc <stat+0x36>
 2ac:	e426                	sd	s1,8(sp)
 2ae:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2b0:	85ca                	mv	a1,s2
 2b2:	3e8000ef          	jal	69a <fstat>
 2b6:	892a                	mv	s2,a0
  close(fd);
 2b8:	8526                	mv	a0,s1
 2ba:	3b0000ef          	jal	66a <close>
  return r;
 2be:	64a2                	ld	s1,8(sp)
}
 2c0:	854a                	mv	a0,s2
 2c2:	60e2                	ld	ra,24(sp)
 2c4:	6442                	ld	s0,16(sp)
 2c6:	6902                	ld	s2,0(sp)
 2c8:	6105                	add	sp,sp,32
 2ca:	8082                	ret
    return -1;
 2cc:	597d                	li	s2,-1
 2ce:	bfcd                	j	2c0 <stat+0x2a>

00000000000002d0 <atoi>:

int
atoi(const char *s)
{
 2d0:	1141                	add	sp,sp,-16
 2d2:	e422                	sd	s0,8(sp)
 2d4:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2d6:	00054683          	lbu	a3,0(a0)
 2da:	fd06879b          	addw	a5,a3,-48
 2de:	0ff7f793          	zext.b	a5,a5
 2e2:	4625                	li	a2,9
 2e4:	02f66863          	bltu	a2,a5,314 <atoi+0x44>
 2e8:	872a                	mv	a4,a0
  n = 0;
 2ea:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2ec:	0705                	add	a4,a4,1
 2ee:	0025179b          	sllw	a5,a0,0x2
 2f2:	9fa9                	addw	a5,a5,a0
 2f4:	0017979b          	sllw	a5,a5,0x1
 2f8:	9fb5                	addw	a5,a5,a3
 2fa:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2fe:	00074683          	lbu	a3,0(a4)
 302:	fd06879b          	addw	a5,a3,-48
 306:	0ff7f793          	zext.b	a5,a5
 30a:	fef671e3          	bgeu	a2,a5,2ec <atoi+0x1c>
  return n;
}
 30e:	6422                	ld	s0,8(sp)
 310:	0141                	add	sp,sp,16
 312:	8082                	ret
  n = 0;
 314:	4501                	li	a0,0
 316:	bfe5                	j	30e <atoi+0x3e>

0000000000000318 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 318:	1141                	add	sp,sp,-16
 31a:	e422                	sd	s0,8(sp)
 31c:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 31e:	02b57463          	bgeu	a0,a1,346 <memmove+0x2e>
    while(n-- > 0)
 322:	00c05f63          	blez	a2,340 <memmove+0x28>
 326:	1602                	sll	a2,a2,0x20
 328:	9201                	srl	a2,a2,0x20
 32a:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 32e:	872a                	mv	a4,a0
      *dst++ = *src++;
 330:	0585                	add	a1,a1,1
 332:	0705                	add	a4,a4,1
 334:	fff5c683          	lbu	a3,-1(a1)
 338:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 33c:	fef71ae3          	bne	a4,a5,330 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 340:	6422                	ld	s0,8(sp)
 342:	0141                	add	sp,sp,16
 344:	8082                	ret
    dst += n;
 346:	00c50733          	add	a4,a0,a2
    src += n;
 34a:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 34c:	fec05ae3          	blez	a2,340 <memmove+0x28>
 350:	fff6079b          	addw	a5,a2,-1
 354:	1782                	sll	a5,a5,0x20
 356:	9381                	srl	a5,a5,0x20
 358:	fff7c793          	not	a5,a5
 35c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 35e:	15fd                	add	a1,a1,-1
 360:	177d                	add	a4,a4,-1
 362:	0005c683          	lbu	a3,0(a1)
 366:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 36a:	fee79ae3          	bne	a5,a4,35e <memmove+0x46>
 36e:	bfc9                	j	340 <memmove+0x28>

0000000000000370 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 370:	1141                	add	sp,sp,-16
 372:	e422                	sd	s0,8(sp)
 374:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 376:	ca05                	beqz	a2,3a6 <memcmp+0x36>
 378:	fff6069b          	addw	a3,a2,-1
 37c:	1682                	sll	a3,a3,0x20
 37e:	9281                	srl	a3,a3,0x20
 380:	0685                	add	a3,a3,1
 382:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 384:	00054783          	lbu	a5,0(a0)
 388:	0005c703          	lbu	a4,0(a1)
 38c:	00e79863          	bne	a5,a4,39c <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 390:	0505                	add	a0,a0,1
    p2++;
 392:	0585                	add	a1,a1,1
  while (n-- > 0) {
 394:	fed518e3          	bne	a0,a3,384 <memcmp+0x14>
  }
  return 0;
 398:	4501                	li	a0,0
 39a:	a019                	j	3a0 <memcmp+0x30>
      return *p1 - *p2;
 39c:	40e7853b          	subw	a0,a5,a4
}
 3a0:	6422                	ld	s0,8(sp)
 3a2:	0141                	add	sp,sp,16
 3a4:	8082                	ret
  return 0;
 3a6:	4501                	li	a0,0
 3a8:	bfe5                	j	3a0 <memcmp+0x30>

00000000000003aa <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3aa:	1141                	add	sp,sp,-16
 3ac:	e406                	sd	ra,8(sp)
 3ae:	e022                	sd	s0,0(sp)
 3b0:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 3b2:	f67ff0ef          	jal	318 <memmove>
}
 3b6:	60a2                	ld	ra,8(sp)
 3b8:	6402                	ld	s0,0(sp)
 3ba:	0141                	add	sp,sp,16
 3bc:	8082                	ret

00000000000003be <htons>:
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
}

uint16_t
htons(uint16_t h)
{
 3be:	1141                	add	sp,sp,-16
 3c0:	e422                	sd	s0,8(sp)
 3c2:	0800                	add	s0,sp,16
    if (!endian) {
 3c4:	00001797          	auipc	a5,0x1
 3c8:	c3c7a783          	lw	a5,-964(a5) # 1000 <endian>
 3cc:	e385                	bnez	a5,3ec <htons+0x2e>
        endian = byteorder();
 3ce:	4d200793          	li	a5,1234
 3d2:	00001717          	auipc	a4,0x1
 3d6:	c2f72723          	sw	a5,-978(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 3da:	0085179b          	sllw	a5,a0,0x8
 3de:	0085551b          	srlw	a0,a0,0x8
 3e2:	8fc9                	or	a5,a5,a0
 3e4:	03079513          	sll	a0,a5,0x30
 3e8:	9141                	srl	a0,a0,0x30
 3ea:	a029                	j	3f4 <htons+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(h) : h;
 3ec:	4d200713          	li	a4,1234
 3f0:	fee785e3          	beq	a5,a4,3da <htons+0x1c>
}
 3f4:	6422                	ld	s0,8(sp)
 3f6:	0141                	add	sp,sp,16
 3f8:	8082                	ret

00000000000003fa <ntohs>:

uint16_t
ntohs(uint16_t n)
{
 3fa:	1141                	add	sp,sp,-16
 3fc:	e422                	sd	s0,8(sp)
 3fe:	0800                	add	s0,sp,16
    if (!endian) {
 400:	00001797          	auipc	a5,0x1
 404:	c007a783          	lw	a5,-1024(a5) # 1000 <endian>
 408:	e385                	bnez	a5,428 <ntohs+0x2e>
        endian = byteorder();
 40a:	4d200793          	li	a5,1234
 40e:	00001717          	auipc	a4,0x1
 412:	bef72923          	sw	a5,-1038(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 416:	0085179b          	sllw	a5,a0,0x8
 41a:	0085551b          	srlw	a0,a0,0x8
 41e:	8fc9                	or	a5,a5,a0
 420:	03079513          	sll	a0,a5,0x30
 424:	9141                	srl	a0,a0,0x30
 426:	a029                	j	430 <ntohs+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(n) : n;
 428:	4d200713          	li	a4,1234
 42c:	fee785e3          	beq	a5,a4,416 <ntohs+0x1c>
}
 430:	6422                	ld	s0,8(sp)
 432:	0141                	add	sp,sp,16
 434:	8082                	ret

0000000000000436 <htonl>:

uint32_t
htonl(uint32_t h)
{
 436:	1141                	add	sp,sp,-16
 438:	e422                	sd	s0,8(sp)
 43a:	0800                	add	s0,sp,16
    if (!endian) {
 43c:	00001797          	auipc	a5,0x1
 440:	bc47a783          	lw	a5,-1084(a5) # 1000 <endian>
 444:	ef85                	bnez	a5,47c <htonl+0x46>
        endian = byteorder();
 446:	4d200793          	li	a5,1234
 44a:	00001717          	auipc	a4,0x1
 44e:	baf72b23          	sw	a5,-1098(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 452:	0185179b          	sllw	a5,a0,0x18
 456:	0185571b          	srlw	a4,a0,0x18
 45a:	8fd9                	or	a5,a5,a4
 45c:	0085171b          	sllw	a4,a0,0x8
 460:	00ff06b7          	lui	a3,0xff0
 464:	8f75                	and	a4,a4,a3
 466:	8fd9                	or	a5,a5,a4
 468:	0085551b          	srlw	a0,a0,0x8
 46c:	6741                	lui	a4,0x10
 46e:	f0070713          	add	a4,a4,-256 # ff00 <base+0xecf0>
 472:	8d79                	and	a0,a0,a4
 474:	8fc9                	or	a5,a5,a0
 476:	0007851b          	sext.w	a0,a5
 47a:	a029                	j	484 <htonl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(h) : h;
 47c:	4d200713          	li	a4,1234
 480:	fce789e3          	beq	a5,a4,452 <htonl+0x1c>
}
 484:	6422                	ld	s0,8(sp)
 486:	0141                	add	sp,sp,16
 488:	8082                	ret

000000000000048a <ntohl>:

uint32_t
ntohl(uint32_t n)
{
 48a:	1141                	add	sp,sp,-16
 48c:	e422                	sd	s0,8(sp)
 48e:	0800                	add	s0,sp,16
    if (!endian) {
 490:	00001797          	auipc	a5,0x1
 494:	b707a783          	lw	a5,-1168(a5) # 1000 <endian>
 498:	ef85                	bnez	a5,4d0 <ntohl+0x46>
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
 4c2:	f0070713          	add	a4,a4,-256 # ff00 <base+0xecf0>
 4c6:	8d79                	and	a0,a0,a4
 4c8:	8fc9                	or	a5,a5,a0
 4ca:	0007851b          	sext.w	a0,a5
 4ce:	a029                	j	4d8 <ntohl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(n) : n;
 4d0:	4d200713          	li	a4,1234
 4d4:	fce789e3          	beq	a5,a4,4a6 <ntohl+0x1c>
}
 4d8:	6422                	ld	s0,8(sp)
 4da:	0141                	add	sp,sp,16
 4dc:	8082                	ret

00000000000004de <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
 4de:	1141                	add	sp,sp,-16
 4e0:	e422                	sd	s0,8(sp)
 4e2:	0800                	add	s0,sp,16
 4e4:	872a                	mv	a4,a0
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
 4e6:	02000693          	li	a3,32
 4ea:	4525                	li	a0,9
 4ec:	a011                	j	4f0 <strtol+0x12>
        s++;
 4ee:	0705                	add	a4,a4,1
    while (*s == ' ' || *s == '\t')
 4f0:	00074783          	lbu	a5,0(a4)
 4f4:	fed78de3          	beq	a5,a3,4ee <strtol+0x10>
 4f8:	fea78be3          	beq	a5,a0,4ee <strtol+0x10>

    // plus/minus sign
    if (*s == '+')
 4fc:	02b00693          	li	a3,43
 500:	02d78663          	beq	a5,a3,52c <strtol+0x4e>
        s++;
    else if (*s == '-')
 504:	02d00693          	li	a3,45
    int neg = 0;
 508:	4301                	li	t1,0
    else if (*s == '-')
 50a:	02d78463          	beq	a5,a3,532 <strtol+0x54>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 50e:	fef67793          	and	a5,a2,-17
 512:	eb89                	bnez	a5,524 <strtol+0x46>
 514:	00074683          	lbu	a3,0(a4)
 518:	03000793          	li	a5,48
 51c:	00f68e63          	beq	a3,a5,538 <strtol+0x5a>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
 520:	e211                	bnez	a2,524 <strtol+0x46>
        s++, base = 8;
    else if (base == 0)
        base = 10;
 522:	4629                	li	a2,10
 524:	4501                	li	a0,0

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
 526:	4825                	li	a6,9
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
 528:	48e5                	li	a7,25
 52a:	a825                	j	562 <strtol+0x84>
        s++;
 52c:	0705                	add	a4,a4,1
    int neg = 0;
 52e:	4301                	li	t1,0
 530:	bff9                	j	50e <strtol+0x30>
        s++, neg = 1;
 532:	0705                	add	a4,a4,1
 534:	4305                	li	t1,1
 536:	bfe1                	j	50e <strtol+0x30>
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 538:	00174683          	lbu	a3,1(a4)
 53c:	07800793          	li	a5,120
 540:	00f68663          	beq	a3,a5,54c <strtol+0x6e>
    else if (base == 0 && s[0] == '0')
 544:	f265                	bnez	a2,524 <strtol+0x46>
        s++, base = 8;
 546:	0705                	add	a4,a4,1
 548:	4621                	li	a2,8
 54a:	bfe9                	j	524 <strtol+0x46>
        s += 2, base = 16;
 54c:	0709                	add	a4,a4,2
 54e:	4641                	li	a2,16
 550:	bfd1                	j	524 <strtol+0x46>
            dig = *s - '0';
 552:	fd07879b          	addw	a5,a5,-48
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
 556:	04c7d063          	bge	a5,a2,596 <strtol+0xb8>
            break;
        s++, val = (val * base) + dig;
 55a:	0705                	add	a4,a4,1
 55c:	02a60533          	mul	a0,a2,a0
 560:	953e                	add	a0,a0,a5
        if (*s >= '0' && *s <= '9')
 562:	00074783          	lbu	a5,0(a4)
 566:	fd07869b          	addw	a3,a5,-48
 56a:	0ff6f693          	zext.b	a3,a3
 56e:	fed872e3          	bgeu	a6,a3,552 <strtol+0x74>
        else if (*s >= 'a' && *s <= 'z')
 572:	f9f7869b          	addw	a3,a5,-97
 576:	0ff6f693          	zext.b	a3,a3
 57a:	00d8e563          	bltu	a7,a3,584 <strtol+0xa6>
            dig = *s - 'a' + 10;
 57e:	fa97879b          	addw	a5,a5,-87
 582:	bfd1                	j	556 <strtol+0x78>
        else if (*s >= 'A' && *s <= 'Z')
 584:	fbf7869b          	addw	a3,a5,-65
 588:	0ff6f693          	zext.b	a3,a3
 58c:	00d8e563          	bltu	a7,a3,596 <strtol+0xb8>
            dig = *s - 'A' + 10;
 590:	fc97879b          	addw	a5,a5,-55
 594:	b7c9                	j	556 <strtol+0x78>
        // we don't properly detect overflow!
    }

    if (endptr)
 596:	c191                	beqz	a1,59a <strtol+0xbc>
        *endptr = (char *) s;
 598:	e198                	sd	a4,0(a1)
    return (neg ? -val : val);
 59a:	00030463          	beqz	t1,5a2 <strtol+0xc4>
 59e:	40a00533          	neg	a0,a0
}
 5a2:	6422                	ld	s0,8(sp)
 5a4:	0141                	add	sp,sp,16
 5a6:	8082                	ret

00000000000005a8 <inet_pton>:
inet_pton (int family, const char *p, void *n) {
    char *sp, *ep;
    int idx;
    long ret;

    if (family != AF_INET) {
 5a8:	4785                	li	a5,1
 5aa:	08f51063          	bne	a0,a5,62a <inet_pton+0x82>
inet_pton (int family, const char *p, void *n) {
 5ae:	715d                	add	sp,sp,-80
 5b0:	e486                	sd	ra,72(sp)
 5b2:	e0a2                	sd	s0,64(sp)
 5b4:	fc26                	sd	s1,56(sp)
 5b6:	f84a                	sd	s2,48(sp)
 5b8:	f44e                	sd	s3,40(sp)
 5ba:	f052                	sd	s4,32(sp)
 5bc:	ec56                	sd	s5,24(sp)
 5be:	e85a                	sd	s6,16(sp)
 5c0:	0880                	add	s0,sp,80
 5c2:	84ae                	mv	s1,a1
 5c4:	89b2                	mv	s3,a2
 5c6:	4901                	li	s2,0
        return -1;
    }
    sp = (char *)p;
    for (idx = 0; idx < 4; idx++) {
        ret = strtol(sp, &ep, 10);
        if (ret < 0 || ret > 255) {
 5c8:	0ff00a13          	li	s4,255
            return -1;
        }
        if (ep == sp) {
            return -1;
        }
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 5cc:	4a8d                	li	s5,3
 5ce:	02e00b13          	li	s6,46
 5d2:	a805                	j	602 <inet_pton+0x5a>
 5d4:	0007c783          	lbu	a5,0(a5)
 5d8:	efb9                	bnez	a5,636 <inet_pton+0x8e>
            return -1;
        }
        ((uint8_t *)n)[idx] = ret;
 5da:	00a981a3          	sb	a0,3(s3)
        sp = ep + 1;
    }
    return 0;
 5de:	4501                	li	a0,0
}
 5e0:	60a6                	ld	ra,72(sp)
 5e2:	6406                	ld	s0,64(sp)
 5e4:	74e2                	ld	s1,56(sp)
 5e6:	7942                	ld	s2,48(sp)
 5e8:	79a2                	ld	s3,40(sp)
 5ea:	7a02                	ld	s4,32(sp)
 5ec:	6ae2                	ld	s5,24(sp)
 5ee:	6b42                	ld	s6,16(sp)
 5f0:	6161                	add	sp,sp,80
 5f2:	8082                	ret
        ((uint8_t *)n)[idx] = ret;
 5f4:	01298733          	add	a4,s3,s2
 5f8:	00a70023          	sb	a0,0(a4)
        sp = ep + 1;
 5fc:	00178493          	add	s1,a5,1
    for (idx = 0; idx < 4; idx++) {
 600:	0905                	add	s2,s2,1
        ret = strtol(sp, &ep, 10);
 602:	4629                	li	a2,10
 604:	fb840593          	add	a1,s0,-72
 608:	8526                	mv	a0,s1
 60a:	ed5ff0ef          	jal	4de <strtol>
        if (ret < 0 || ret > 255) {
 60e:	02aa6063          	bltu	s4,a0,62e <inet_pton+0x86>
        if (ep == sp) {
 612:	fb843783          	ld	a5,-72(s0)
 616:	00978e63          	beq	a5,s1,632 <inet_pton+0x8a>
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 61a:	fb590de3          	beq	s2,s5,5d4 <inet_pton+0x2c>
 61e:	0007c703          	lbu	a4,0(a5)
 622:	fd6709e3          	beq	a4,s6,5f4 <inet_pton+0x4c>
            return -1;
 626:	557d                	li	a0,-1
 628:	bf65                	j	5e0 <inet_pton+0x38>
        return -1;
 62a:	557d                	li	a0,-1
}
 62c:	8082                	ret
            return -1;
 62e:	557d                	li	a0,-1
 630:	bf45                	j	5e0 <inet_pton+0x38>
            return -1;
 632:	557d                	li	a0,-1
 634:	b775                	j	5e0 <inet_pton+0x38>
            return -1;
 636:	557d                	li	a0,-1
 638:	b765                	j	5e0 <inet_pton+0x38>

000000000000063a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 63a:	4885                	li	a7,1
 ecall
 63c:	00000073          	ecall
 ret
 640:	8082                	ret

0000000000000642 <exit>:
.global exit
exit:
 li a7, SYS_exit
 642:	4889                	li	a7,2
 ecall
 644:	00000073          	ecall
 ret
 648:	8082                	ret

000000000000064a <wait>:
.global wait
wait:
 li a7, SYS_wait
 64a:	488d                	li	a7,3
 ecall
 64c:	00000073          	ecall
 ret
 650:	8082                	ret

0000000000000652 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 652:	4891                	li	a7,4
 ecall
 654:	00000073          	ecall
 ret
 658:	8082                	ret

000000000000065a <read>:
.global read
read:
 li a7, SYS_read
 65a:	4895                	li	a7,5
 ecall
 65c:	00000073          	ecall
 ret
 660:	8082                	ret

0000000000000662 <write>:
.global write
write:
 li a7, SYS_write
 662:	48c1                	li	a7,16
 ecall
 664:	00000073          	ecall
 ret
 668:	8082                	ret

000000000000066a <close>:
.global close
close:
 li a7, SYS_close
 66a:	48d5                	li	a7,21
 ecall
 66c:	00000073          	ecall
 ret
 670:	8082                	ret

0000000000000672 <kill>:
.global kill
kill:
 li a7, SYS_kill
 672:	4899                	li	a7,6
 ecall
 674:	00000073          	ecall
 ret
 678:	8082                	ret

000000000000067a <exec>:
.global exec
exec:
 li a7, SYS_exec
 67a:	489d                	li	a7,7
 ecall
 67c:	00000073          	ecall
 ret
 680:	8082                	ret

0000000000000682 <open>:
.global open
open:
 li a7, SYS_open
 682:	48bd                	li	a7,15
 ecall
 684:	00000073          	ecall
 ret
 688:	8082                	ret

000000000000068a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 68a:	48c5                	li	a7,17
 ecall
 68c:	00000073          	ecall
 ret
 690:	8082                	ret

0000000000000692 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 692:	48c9                	li	a7,18
 ecall
 694:	00000073          	ecall
 ret
 698:	8082                	ret

000000000000069a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 69a:	48a1                	li	a7,8
 ecall
 69c:	00000073          	ecall
 ret
 6a0:	8082                	ret

00000000000006a2 <link>:
.global link
link:
 li a7, SYS_link
 6a2:	48cd                	li	a7,19
 ecall
 6a4:	00000073          	ecall
 ret
 6a8:	8082                	ret

00000000000006aa <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 6aa:	48d1                	li	a7,20
 ecall
 6ac:	00000073          	ecall
 ret
 6b0:	8082                	ret

00000000000006b2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 6b2:	48a5                	li	a7,9
 ecall
 6b4:	00000073          	ecall
 ret
 6b8:	8082                	ret

00000000000006ba <dup>:
.global dup
dup:
 li a7, SYS_dup
 6ba:	48a9                	li	a7,10
 ecall
 6bc:	00000073          	ecall
 ret
 6c0:	8082                	ret

00000000000006c2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 6c2:	48ad                	li	a7,11
 ecall
 6c4:	00000073          	ecall
 ret
 6c8:	8082                	ret

00000000000006ca <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 6ca:	48b1                	li	a7,12
 ecall
 6cc:	00000073          	ecall
 ret
 6d0:	8082                	ret

00000000000006d2 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 6d2:	48b5                	li	a7,13
 ecall
 6d4:	00000073          	ecall
 ret
 6d8:	8082                	ret

00000000000006da <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 6da:	48b9                	li	a7,14
 ecall
 6dc:	00000073          	ecall
 ret
 6e0:	8082                	ret

00000000000006e2 <socket>:
.global socket
socket:
 li a7, SYS_socket
 6e2:	48d9                	li	a7,22
 ecall
 6e4:	00000073          	ecall
 ret
 6e8:	8082                	ret

00000000000006ea <bind>:
.global bind
bind:
 li a7, SYS_bind
 6ea:	48dd                	li	a7,23
 ecall
 6ec:	00000073          	ecall
 ret
 6f0:	8082                	ret

00000000000006f2 <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 6f2:	48e1                	li	a7,24
 ecall
 6f4:	00000073          	ecall
 ret
 6f8:	8082                	ret

00000000000006fa <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 6fa:	48e5                	li	a7,25
 ecall
 6fc:	00000073          	ecall
 ret
 700:	8082                	ret

0000000000000702 <connect>:
.global connect
connect:
 li a7, SYS_connect
 702:	48e9                	li	a7,26
 ecall
 704:	00000073          	ecall
 ret
 708:	8082                	ret

000000000000070a <listen>:
.global listen
listen:
 li a7, SYS_listen
 70a:	48ed                	li	a7,27
 ecall
 70c:	00000073          	ecall
 ret
 710:	8082                	ret

0000000000000712 <accept>:
.global accept
accept:
 li a7, SYS_accept
 712:	48f1                	li	a7,28
 ecall
 714:	00000073          	ecall
 ret
 718:	8082                	ret

000000000000071a <recv>:
.global recv
recv:
 li a7, SYS_recv
 71a:	48f5                	li	a7,29
 ecall
 71c:	00000073          	ecall
 ret
 720:	8082                	ret

0000000000000722 <send>:
.global send
send:
 li a7, SYS_send
 722:	48f9                	li	a7,30
 ecall
 724:	00000073          	ecall
 ret
 728:	8082                	ret

000000000000072a <ioctl>:
.global ioctl
ioctl:
 li a7, SYS_ioctl
 72a:	48fd                	li	a7,31
 ecall
 72c:	00000073          	ecall
 ret
 730:	8082                	ret

0000000000000732 <consolemode>:
.global consolemode
consolemode:
 li a7, SYS_consolemode
 732:	02000893          	li	a7,32
 ecall
 736:	00000073          	ecall
 ret
 73a:	8082                	ret

000000000000073c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 73c:	1101                	add	sp,sp,-32
 73e:	ec06                	sd	ra,24(sp)
 740:	e822                	sd	s0,16(sp)
 742:	1000                	add	s0,sp,32
 744:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 748:	4605                	li	a2,1
 74a:	fef40593          	add	a1,s0,-17
 74e:	f15ff0ef          	jal	662 <write>
}
 752:	60e2                	ld	ra,24(sp)
 754:	6442                	ld	s0,16(sp)
 756:	6105                	add	sp,sp,32
 758:	8082                	ret

000000000000075a <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 75a:	715d                	add	sp,sp,-80
 75c:	e486                	sd	ra,72(sp)
 75e:	e0a2                	sd	s0,64(sp)
 760:	fc26                	sd	s1,56(sp)
 762:	0880                	add	s0,sp,80
 764:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 766:	c299                	beqz	a3,76c <printint+0x12>
 768:	0805c963          	bltz	a1,7fa <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 76c:	2581                	sext.w	a1,a1
  neg = 0;
 76e:	4881                	li	a7,0
 770:	fb840693          	add	a3,s0,-72
  }

  i = 0;
 774:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 776:	2601                	sext.w	a2,a2
 778:	00000517          	auipc	a0,0x0
 77c:	54850513          	add	a0,a0,1352 # cc0 <digits>
 780:	883a                	mv	a6,a4
 782:	2705                	addw	a4,a4,1
 784:	02c5f7bb          	remuw	a5,a1,a2
 788:	1782                	sll	a5,a5,0x20
 78a:	9381                	srl	a5,a5,0x20
 78c:	97aa                	add	a5,a5,a0
 78e:	0007c783          	lbu	a5,0(a5)
 792:	00f68023          	sb	a5,0(a3) # ff0000 <base+0xfeedf0>
  }while((x /= base) != 0);
 796:	0005879b          	sext.w	a5,a1
 79a:	02c5d5bb          	divuw	a1,a1,a2
 79e:	0685                	add	a3,a3,1
 7a0:	fec7f0e3          	bgeu	a5,a2,780 <printint+0x26>
  if(neg)
 7a4:	00088c63          	beqz	a7,7bc <printint+0x62>
    buf[i++] = '-';
 7a8:	fd070793          	add	a5,a4,-48
 7ac:	00878733          	add	a4,a5,s0
 7b0:	02d00793          	li	a5,45
 7b4:	fef70423          	sb	a5,-24(a4)
 7b8:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 7bc:	02e05a63          	blez	a4,7f0 <printint+0x96>
 7c0:	f84a                	sd	s2,48(sp)
 7c2:	f44e                	sd	s3,40(sp)
 7c4:	fb840793          	add	a5,s0,-72
 7c8:	00e78933          	add	s2,a5,a4
 7cc:	fff78993          	add	s3,a5,-1
 7d0:	99ba                	add	s3,s3,a4
 7d2:	377d                	addw	a4,a4,-1
 7d4:	1702                	sll	a4,a4,0x20
 7d6:	9301                	srl	a4,a4,0x20
 7d8:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 7dc:	fff94583          	lbu	a1,-1(s2)
 7e0:	8526                	mv	a0,s1
 7e2:	f5bff0ef          	jal	73c <putc>
  while(--i >= 0)
 7e6:	197d                	add	s2,s2,-1
 7e8:	ff391ae3          	bne	s2,s3,7dc <printint+0x82>
 7ec:	7942                	ld	s2,48(sp)
 7ee:	79a2                	ld	s3,40(sp)
}
 7f0:	60a6                	ld	ra,72(sp)
 7f2:	6406                	ld	s0,64(sp)
 7f4:	74e2                	ld	s1,56(sp)
 7f6:	6161                	add	sp,sp,80
 7f8:	8082                	ret
    x = -xx;
 7fa:	40b005bb          	negw	a1,a1
    neg = 1;
 7fe:	4885                	li	a7,1
    x = -xx;
 800:	bf85                	j	770 <printint+0x16>

0000000000000802 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 802:	711d                	add	sp,sp,-96
 804:	ec86                	sd	ra,88(sp)
 806:	e8a2                	sd	s0,80(sp)
 808:	e0ca                	sd	s2,64(sp)
 80a:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 80c:	0005c903          	lbu	s2,0(a1)
 810:	26090863          	beqz	s2,a80 <vprintf+0x27e>
 814:	e4a6                	sd	s1,72(sp)
 816:	fc4e                	sd	s3,56(sp)
 818:	f852                	sd	s4,48(sp)
 81a:	f456                	sd	s5,40(sp)
 81c:	f05a                	sd	s6,32(sp)
 81e:	ec5e                	sd	s7,24(sp)
 820:	e862                	sd	s8,16(sp)
 822:	e466                	sd	s9,8(sp)
 824:	8b2a                	mv	s6,a0
 826:	8a2e                	mv	s4,a1
 828:	8bb2                	mv	s7,a2
  state = 0;
 82a:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 82c:	4481                	li	s1,0
 82e:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 830:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 834:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 838:	06c00c93          	li	s9,108
 83c:	a005                	j	85c <vprintf+0x5a>
        putc(fd, c0);
 83e:	85ca                	mv	a1,s2
 840:	855a                	mv	a0,s6
 842:	efbff0ef          	jal	73c <putc>
 846:	a019                	j	84c <vprintf+0x4a>
    } else if(state == '%'){
 848:	03598263          	beq	s3,s5,86c <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 84c:	2485                	addw	s1,s1,1
 84e:	8726                	mv	a4,s1
 850:	009a07b3          	add	a5,s4,s1
 854:	0007c903          	lbu	s2,0(a5)
 858:	20090c63          	beqz	s2,a70 <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 85c:	0009079b          	sext.w	a5,s2
    if(state == 0){
 860:	fe0994e3          	bnez	s3,848 <vprintf+0x46>
      if(c0 == '%'){
 864:	fd579de3          	bne	a5,s5,83e <vprintf+0x3c>
        state = '%';
 868:	89be                	mv	s3,a5
 86a:	b7cd                	j	84c <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 86c:	00ea06b3          	add	a3,s4,a4
 870:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 874:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 876:	c681                	beqz	a3,87e <vprintf+0x7c>
 878:	9752                	add	a4,a4,s4
 87a:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 87e:	03878f63          	beq	a5,s8,8bc <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 882:	05978963          	beq	a5,s9,8d4 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 886:	07500713          	li	a4,117
 88a:	0ee78363          	beq	a5,a4,970 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 88e:	07800713          	li	a4,120
 892:	12e78563          	beq	a5,a4,9bc <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 896:	07000713          	li	a4,112
 89a:	14e78a63          	beq	a5,a4,9ee <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 89e:	07300713          	li	a4,115
 8a2:	18e78a63          	beq	a5,a4,a36 <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 8a6:	02500713          	li	a4,37
 8aa:	04e79563          	bne	a5,a4,8f4 <vprintf+0xf2>
        putc(fd, '%');
 8ae:	02500593          	li	a1,37
 8b2:	855a                	mv	a0,s6
 8b4:	e89ff0ef          	jal	73c <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 8b8:	4981                	li	s3,0
 8ba:	bf49                	j	84c <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 8bc:	008b8913          	add	s2,s7,8
 8c0:	4685                	li	a3,1
 8c2:	4629                	li	a2,10
 8c4:	000ba583          	lw	a1,0(s7)
 8c8:	855a                	mv	a0,s6
 8ca:	e91ff0ef          	jal	75a <printint>
 8ce:	8bca                	mv	s7,s2
      state = 0;
 8d0:	4981                	li	s3,0
 8d2:	bfad                	j	84c <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 8d4:	06400793          	li	a5,100
 8d8:	02f68963          	beq	a3,a5,90a <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 8dc:	06c00793          	li	a5,108
 8e0:	04f68263          	beq	a3,a5,924 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 8e4:	07500793          	li	a5,117
 8e8:	0af68063          	beq	a3,a5,988 <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 8ec:	07800793          	li	a5,120
 8f0:	0ef68263          	beq	a3,a5,9d4 <vprintf+0x1d2>
        putc(fd, '%');
 8f4:	02500593          	li	a1,37
 8f8:	855a                	mv	a0,s6
 8fa:	e43ff0ef          	jal	73c <putc>
        putc(fd, c0);
 8fe:	85ca                	mv	a1,s2
 900:	855a                	mv	a0,s6
 902:	e3bff0ef          	jal	73c <putc>
      state = 0;
 906:	4981                	li	s3,0
 908:	b791                	j	84c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 90a:	008b8913          	add	s2,s7,8
 90e:	4685                	li	a3,1
 910:	4629                	li	a2,10
 912:	000bb583          	ld	a1,0(s7)
 916:	855a                	mv	a0,s6
 918:	e43ff0ef          	jal	75a <printint>
        i += 1;
 91c:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 91e:	8bca                	mv	s7,s2
      state = 0;
 920:	4981                	li	s3,0
        i += 1;
 922:	b72d                	j	84c <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 924:	06400793          	li	a5,100
 928:	02f60763          	beq	a2,a5,956 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 92c:	07500793          	li	a5,117
 930:	06f60963          	beq	a2,a5,9a2 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 934:	07800793          	li	a5,120
 938:	faf61ee3          	bne	a2,a5,8f4 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 93c:	008b8913          	add	s2,s7,8
 940:	4681                	li	a3,0
 942:	4641                	li	a2,16
 944:	000bb583          	ld	a1,0(s7)
 948:	855a                	mv	a0,s6
 94a:	e11ff0ef          	jal	75a <printint>
        i += 2;
 94e:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 950:	8bca                	mv	s7,s2
      state = 0;
 952:	4981                	li	s3,0
        i += 2;
 954:	bde5                	j	84c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 956:	008b8913          	add	s2,s7,8
 95a:	4685                	li	a3,1
 95c:	4629                	li	a2,10
 95e:	000bb583          	ld	a1,0(s7)
 962:	855a                	mv	a0,s6
 964:	df7ff0ef          	jal	75a <printint>
        i += 2;
 968:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 96a:	8bca                	mv	s7,s2
      state = 0;
 96c:	4981                	li	s3,0
        i += 2;
 96e:	bdf9                	j	84c <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 970:	008b8913          	add	s2,s7,8
 974:	4681                	li	a3,0
 976:	4629                	li	a2,10
 978:	000ba583          	lw	a1,0(s7)
 97c:	855a                	mv	a0,s6
 97e:	dddff0ef          	jal	75a <printint>
 982:	8bca                	mv	s7,s2
      state = 0;
 984:	4981                	li	s3,0
 986:	b5d9                	j	84c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 988:	008b8913          	add	s2,s7,8
 98c:	4681                	li	a3,0
 98e:	4629                	li	a2,10
 990:	000bb583          	ld	a1,0(s7)
 994:	855a                	mv	a0,s6
 996:	dc5ff0ef          	jal	75a <printint>
        i += 1;
 99a:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 99c:	8bca                	mv	s7,s2
      state = 0;
 99e:	4981                	li	s3,0
        i += 1;
 9a0:	b575                	j	84c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9a2:	008b8913          	add	s2,s7,8
 9a6:	4681                	li	a3,0
 9a8:	4629                	li	a2,10
 9aa:	000bb583          	ld	a1,0(s7)
 9ae:	855a                	mv	a0,s6
 9b0:	dabff0ef          	jal	75a <printint>
        i += 2;
 9b4:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 9b6:	8bca                	mv	s7,s2
      state = 0;
 9b8:	4981                	li	s3,0
        i += 2;
 9ba:	bd49                	j	84c <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 9bc:	008b8913          	add	s2,s7,8
 9c0:	4681                	li	a3,0
 9c2:	4641                	li	a2,16
 9c4:	000ba583          	lw	a1,0(s7)
 9c8:	855a                	mv	a0,s6
 9ca:	d91ff0ef          	jal	75a <printint>
 9ce:	8bca                	mv	s7,s2
      state = 0;
 9d0:	4981                	li	s3,0
 9d2:	bdad                	j	84c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 9d4:	008b8913          	add	s2,s7,8
 9d8:	4681                	li	a3,0
 9da:	4641                	li	a2,16
 9dc:	000bb583          	ld	a1,0(s7)
 9e0:	855a                	mv	a0,s6
 9e2:	d79ff0ef          	jal	75a <printint>
        i += 1;
 9e6:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 9e8:	8bca                	mv	s7,s2
      state = 0;
 9ea:	4981                	li	s3,0
        i += 1;
 9ec:	b585                	j	84c <vprintf+0x4a>
 9ee:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 9f0:	008b8d13          	add	s10,s7,8
 9f4:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 9f8:	03000593          	li	a1,48
 9fc:	855a                	mv	a0,s6
 9fe:	d3fff0ef          	jal	73c <putc>
  putc(fd, 'x');
 a02:	07800593          	li	a1,120
 a06:	855a                	mv	a0,s6
 a08:	d35ff0ef          	jal	73c <putc>
 a0c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a0e:	00000b97          	auipc	s7,0x0
 a12:	2b2b8b93          	add	s7,s7,690 # cc0 <digits>
 a16:	03c9d793          	srl	a5,s3,0x3c
 a1a:	97de                	add	a5,a5,s7
 a1c:	0007c583          	lbu	a1,0(a5)
 a20:	855a                	mv	a0,s6
 a22:	d1bff0ef          	jal	73c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a26:	0992                	sll	s3,s3,0x4
 a28:	397d                	addw	s2,s2,-1
 a2a:	fe0916e3          	bnez	s2,a16 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 a2e:	8bea                	mv	s7,s10
      state = 0;
 a30:	4981                	li	s3,0
 a32:	6d02                	ld	s10,0(sp)
 a34:	bd21                	j	84c <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 a36:	008b8993          	add	s3,s7,8
 a3a:	000bb903          	ld	s2,0(s7)
 a3e:	00090f63          	beqz	s2,a5c <vprintf+0x25a>
        for(; *s; s++)
 a42:	00094583          	lbu	a1,0(s2)
 a46:	c195                	beqz	a1,a6a <vprintf+0x268>
          putc(fd, *s);
 a48:	855a                	mv	a0,s6
 a4a:	cf3ff0ef          	jal	73c <putc>
        for(; *s; s++)
 a4e:	0905                	add	s2,s2,1
 a50:	00094583          	lbu	a1,0(s2)
 a54:	f9f5                	bnez	a1,a48 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 a56:	8bce                	mv	s7,s3
      state = 0;
 a58:	4981                	li	s3,0
 a5a:	bbcd                	j	84c <vprintf+0x4a>
          s = "(null)";
 a5c:	00000917          	auipc	s2,0x0
 a60:	25c90913          	add	s2,s2,604 # cb8 <malloc+0x148>
        for(; *s; s++)
 a64:	02800593          	li	a1,40
 a68:	b7c5                	j	a48 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 a6a:	8bce                	mv	s7,s3
      state = 0;
 a6c:	4981                	li	s3,0
 a6e:	bbf9                	j	84c <vprintf+0x4a>
 a70:	64a6                	ld	s1,72(sp)
 a72:	79e2                	ld	s3,56(sp)
 a74:	7a42                	ld	s4,48(sp)
 a76:	7aa2                	ld	s5,40(sp)
 a78:	7b02                	ld	s6,32(sp)
 a7a:	6be2                	ld	s7,24(sp)
 a7c:	6c42                	ld	s8,16(sp)
 a7e:	6ca2                	ld	s9,8(sp)
    }
  }
}
 a80:	60e6                	ld	ra,88(sp)
 a82:	6446                	ld	s0,80(sp)
 a84:	6906                	ld	s2,64(sp)
 a86:	6125                	add	sp,sp,96
 a88:	8082                	ret

0000000000000a8a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a8a:	715d                	add	sp,sp,-80
 a8c:	ec06                	sd	ra,24(sp)
 a8e:	e822                	sd	s0,16(sp)
 a90:	1000                	add	s0,sp,32
 a92:	e010                	sd	a2,0(s0)
 a94:	e414                	sd	a3,8(s0)
 a96:	e818                	sd	a4,16(s0)
 a98:	ec1c                	sd	a5,24(s0)
 a9a:	03043023          	sd	a6,32(s0)
 a9e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 aa2:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 aa6:	8622                	mv	a2,s0
 aa8:	d5bff0ef          	jal	802 <vprintf>
}
 aac:	60e2                	ld	ra,24(sp)
 aae:	6442                	ld	s0,16(sp)
 ab0:	6161                	add	sp,sp,80
 ab2:	8082                	ret

0000000000000ab4 <printf>:

void
printf(const char *fmt, ...)
{
 ab4:	711d                	add	sp,sp,-96
 ab6:	ec06                	sd	ra,24(sp)
 ab8:	e822                	sd	s0,16(sp)
 aba:	1000                	add	s0,sp,32
 abc:	e40c                	sd	a1,8(s0)
 abe:	e810                	sd	a2,16(s0)
 ac0:	ec14                	sd	a3,24(s0)
 ac2:	f018                	sd	a4,32(s0)
 ac4:	f41c                	sd	a5,40(s0)
 ac6:	03043823          	sd	a6,48(s0)
 aca:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 ace:	00840613          	add	a2,s0,8
 ad2:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 ad6:	85aa                	mv	a1,a0
 ad8:	4505                	li	a0,1
 ada:	d29ff0ef          	jal	802 <vprintf>
}
 ade:	60e2                	ld	ra,24(sp)
 ae0:	6442                	ld	s0,16(sp)
 ae2:	6125                	add	sp,sp,96
 ae4:	8082                	ret

0000000000000ae6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 ae6:	1141                	add	sp,sp,-16
 ae8:	e422                	sd	s0,8(sp)
 aea:	0800                	add	s0,sp,16
  Header *bp, *p;

  if(ap == 0)
 aec:	cd3d                	beqz	a0,b6a <free+0x84>
    return;
  if((uint64)ap < 4096)
 aee:	6785                	lui	a5,0x1
 af0:	06f56d63          	bltu	a0,a5,b6a <free+0x84>
    return;
  bp = (Header*)ap - 1;
 af4:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 af8:	00000797          	auipc	a5,0x0
 afc:	5107b783          	ld	a5,1296(a5) # 1008 <freep>
 b00:	a02d                	j	b2a <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 b02:	4618                	lw	a4,8(a2)
 b04:	9f2d                	addw	a4,a4,a1
 b06:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 b0a:	6398                	ld	a4,0(a5)
 b0c:	6310                	ld	a2,0(a4)
 b0e:	a83d                	j	b4c <free+0x66>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 b10:	ff852703          	lw	a4,-8(a0)
 b14:	9f31                	addw	a4,a4,a2
 b16:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 b18:	ff053683          	ld	a3,-16(a0)
 b1c:	a091                	j	b60 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b1e:	6398                	ld	a4,0(a5)
 b20:	00e7e463          	bltu	a5,a4,b28 <free+0x42>
 b24:	00e6ea63          	bltu	a3,a4,b38 <free+0x52>
{
 b28:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b2a:	fed7fae3          	bgeu	a5,a3,b1e <free+0x38>
 b2e:	6398                	ld	a4,0(a5)
 b30:	00e6e463          	bltu	a3,a4,b38 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b34:	fee7eae3          	bltu	a5,a4,b28 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 b38:	ff852583          	lw	a1,-8(a0)
 b3c:	6390                	ld	a2,0(a5)
 b3e:	02059813          	sll	a6,a1,0x20
 b42:	01c85713          	srl	a4,a6,0x1c
 b46:	9736                	add	a4,a4,a3
 b48:	fae60de3          	beq	a2,a4,b02 <free+0x1c>
    bp->s.ptr = p->s.ptr->s.ptr;
 b4c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 b50:	4790                	lw	a2,8(a5)
 b52:	02061593          	sll	a1,a2,0x20
 b56:	01c5d713          	srl	a4,a1,0x1c
 b5a:	973e                	add	a4,a4,a5
 b5c:	fae68ae3          	beq	a3,a4,b10 <free+0x2a>
    p->s.ptr = bp->s.ptr;
 b60:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 b62:	00000717          	auipc	a4,0x0
 b66:	4af73323          	sd	a5,1190(a4) # 1008 <freep>
}
 b6a:	6422                	ld	s0,8(sp)
 b6c:	0141                	add	sp,sp,16
 b6e:	8082                	ret

0000000000000b70 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b70:	7139                	add	sp,sp,-64
 b72:	fc06                	sd	ra,56(sp)
 b74:	f822                	sd	s0,48(sp)
 b76:	f426                	sd	s1,40(sp)
 b78:	ec4e                	sd	s3,24(sp)
 b7a:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b7c:	02051493          	sll	s1,a0,0x20
 b80:	9081                	srl	s1,s1,0x20
 b82:	04bd                	add	s1,s1,15
 b84:	8091                	srl	s1,s1,0x4
 b86:	0014899b          	addw	s3,s1,1
 b8a:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 b8c:	00000517          	auipc	a0,0x0
 b90:	47c53503          	ld	a0,1148(a0) # 1008 <freep>
 b94:	c915                	beqz	a0,bc8 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b96:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b98:	4798                	lw	a4,8(a5)
 b9a:	08977a63          	bgeu	a4,s1,c2e <malloc+0xbe>
 b9e:	f04a                	sd	s2,32(sp)
 ba0:	e852                	sd	s4,16(sp)
 ba2:	e456                	sd	s5,8(sp)
 ba4:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 ba6:	8a4e                	mv	s4,s3
 ba8:	0009871b          	sext.w	a4,s3
 bac:	6685                	lui	a3,0x1
 bae:	00d77363          	bgeu	a4,a3,bb4 <malloc+0x44>
 bb2:	6a05                	lui	s4,0x1
 bb4:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 bb8:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 bbc:	00000917          	auipc	s2,0x0
 bc0:	44c90913          	add	s2,s2,1100 # 1008 <freep>
  if(p == (char*)-1)
 bc4:	5afd                	li	s5,-1
 bc6:	a081                	j	c06 <malloc+0x96>
 bc8:	f04a                	sd	s2,32(sp)
 bca:	e852                	sd	s4,16(sp)
 bcc:	e456                	sd	s5,8(sp)
 bce:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 bd0:	00000797          	auipc	a5,0x0
 bd4:	64078793          	add	a5,a5,1600 # 1210 <base>
 bd8:	00000717          	auipc	a4,0x0
 bdc:	42f73823          	sd	a5,1072(a4) # 1008 <freep>
 be0:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 be2:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 be6:	b7c1                	j	ba6 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 be8:	6398                	ld	a4,0(a5)
 bea:	e118                	sd	a4,0(a0)
 bec:	a8a9                	j	c46 <malloc+0xd6>
  hp->s.size = nu;
 bee:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 bf2:	0541                	add	a0,a0,16
 bf4:	ef3ff0ef          	jal	ae6 <free>
  return freep;
 bf8:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 bfc:	c12d                	beqz	a0,c5e <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bfe:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c00:	4798                	lw	a4,8(a5)
 c02:	02977263          	bgeu	a4,s1,c26 <malloc+0xb6>
    if(p == freep)
 c06:	00093703          	ld	a4,0(s2)
 c0a:	853e                	mv	a0,a5
 c0c:	fef719e3          	bne	a4,a5,bfe <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 c10:	8552                	mv	a0,s4
 c12:	ab9ff0ef          	jal	6ca <sbrk>
  if(p == (char*)-1)
 c16:	fd551ce3          	bne	a0,s5,bee <malloc+0x7e>
        return 0;
 c1a:	4501                	li	a0,0
 c1c:	7902                	ld	s2,32(sp)
 c1e:	6a42                	ld	s4,16(sp)
 c20:	6aa2                	ld	s5,8(sp)
 c22:	6b02                	ld	s6,0(sp)
 c24:	a03d                	j	c52 <malloc+0xe2>
 c26:	7902                	ld	s2,32(sp)
 c28:	6a42                	ld	s4,16(sp)
 c2a:	6aa2                	ld	s5,8(sp)
 c2c:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 c2e:	fae48de3          	beq	s1,a4,be8 <malloc+0x78>
        p->s.size -= nunits;
 c32:	4137073b          	subw	a4,a4,s3
 c36:	c798                	sw	a4,8(a5)
        p += p->s.size;
 c38:	02071693          	sll	a3,a4,0x20
 c3c:	01c6d713          	srl	a4,a3,0x1c
 c40:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 c42:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 c46:	00000717          	auipc	a4,0x0
 c4a:	3ca73123          	sd	a0,962(a4) # 1008 <freep>
      return (void*)(p + 1);
 c4e:	01078513          	add	a0,a5,16
  }
}
 c52:	70e2                	ld	ra,56(sp)
 c54:	7442                	ld	s0,48(sp)
 c56:	74a2                	ld	s1,40(sp)
 c58:	69e2                	ld	s3,24(sp)
 c5a:	6121                	add	sp,sp,64
 c5c:	8082                	ret
 c5e:	7902                	ld	s2,32(sp)
 c60:	6a42                	ld	s4,16(sp)
 c62:	6aa2                	ld	s5,8(sp)
 c64:	6b02                	ld	s6,0(sp)
 c66:	b7f5                	j	c52 <malloc+0xe2>
