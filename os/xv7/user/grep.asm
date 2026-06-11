
user/_grep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
   0:	7179                	add	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	e052                	sd	s4,0(sp)
   e:	1800                	add	s0,sp,48
  10:	892a                	mv	s2,a0
  12:	89ae                	mv	s3,a1
  14:	84b2                	mv	s1,a2
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  16:	02e00a13          	li	s4,46
    if(matchhere(re, text))
  1a:	85a6                	mv	a1,s1
  1c:	854e                	mv	a0,s3
  1e:	02c000ef          	jal	4a <matchhere>
  22:	e919                	bnez	a0,38 <matchstar+0x38>
  }while(*text!='\0' && (*text++==c || c=='.'));
  24:	0004c783          	lbu	a5,0(s1)
  28:	cb89                	beqz	a5,3a <matchstar+0x3a>
  2a:	0485                	add	s1,s1,1
  2c:	2781                	sext.w	a5,a5
  2e:	ff2786e3          	beq	a5,s2,1a <matchstar+0x1a>
  32:	ff4904e3          	beq	s2,s4,1a <matchstar+0x1a>
  36:	a011                	j	3a <matchstar+0x3a>
      return 1;
  38:	4505                	li	a0,1
  return 0;
}
  3a:	70a2                	ld	ra,40(sp)
  3c:	7402                	ld	s0,32(sp)
  3e:	64e2                	ld	s1,24(sp)
  40:	6942                	ld	s2,16(sp)
  42:	69a2                	ld	s3,8(sp)
  44:	6a02                	ld	s4,0(sp)
  46:	6145                	add	sp,sp,48
  48:	8082                	ret

000000000000004a <matchhere>:
  if(re[0] == '\0')
  4a:	00054703          	lbu	a4,0(a0)
  4e:	c73d                	beqz	a4,bc <matchhere+0x72>
{
  50:	1141                	add	sp,sp,-16
  52:	e406                	sd	ra,8(sp)
  54:	e022                	sd	s0,0(sp)
  56:	0800                	add	s0,sp,16
  58:	87aa                	mv	a5,a0
  if(re[1] == '*')
  5a:	00154683          	lbu	a3,1(a0)
  5e:	02a00613          	li	a2,42
  62:	02c68563          	beq	a3,a2,8c <matchhere+0x42>
  if(re[0] == '$' && re[1] == '\0')
  66:	02400613          	li	a2,36
  6a:	02c70863          	beq	a4,a2,9a <matchhere+0x50>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  6e:	0005c683          	lbu	a3,0(a1)
  return 0;
  72:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  74:	ca81                	beqz	a3,84 <matchhere+0x3a>
  76:	02e00613          	li	a2,46
  7a:	02c70b63          	beq	a4,a2,b0 <matchhere+0x66>
  return 0;
  7e:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  80:	02d70863          	beq	a4,a3,b0 <matchhere+0x66>
}
  84:	60a2                	ld	ra,8(sp)
  86:	6402                	ld	s0,0(sp)
  88:	0141                	add	sp,sp,16
  8a:	8082                	ret
    return matchstar(re[0], re+2, text);
  8c:	862e                	mv	a2,a1
  8e:	00250593          	add	a1,a0,2
  92:	853a                	mv	a0,a4
  94:	f6dff0ef          	jal	0 <matchstar>
  98:	b7f5                	j	84 <matchhere+0x3a>
  if(re[0] == '$' && re[1] == '\0')
  9a:	c691                	beqz	a3,a6 <matchhere+0x5c>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  9c:	0005c683          	lbu	a3,0(a1)
  a0:	fef9                	bnez	a3,7e <matchhere+0x34>
  return 0;
  a2:	4501                	li	a0,0
  a4:	b7c5                	j	84 <matchhere+0x3a>
    return *text == '\0';
  a6:	0005c503          	lbu	a0,0(a1)
  aa:	00153513          	seqz	a0,a0
  ae:	bfd9                	j	84 <matchhere+0x3a>
    return matchhere(re+1, text+1);
  b0:	0585                	add	a1,a1,1
  b2:	00178513          	add	a0,a5,1
  b6:	f95ff0ef          	jal	4a <matchhere>
  ba:	b7e9                	j	84 <matchhere+0x3a>
    return 1;
  bc:	4505                	li	a0,1
}
  be:	8082                	ret

00000000000000c0 <match>:
{
  c0:	1101                	add	sp,sp,-32
  c2:	ec06                	sd	ra,24(sp)
  c4:	e822                	sd	s0,16(sp)
  c6:	e426                	sd	s1,8(sp)
  c8:	e04a                	sd	s2,0(sp)
  ca:	1000                	add	s0,sp,32
  cc:	892a                	mv	s2,a0
  ce:	84ae                	mv	s1,a1
  if(re[0] == '^')
  d0:	00054703          	lbu	a4,0(a0)
  d4:	05e00793          	li	a5,94
  d8:	00f70c63          	beq	a4,a5,f0 <match+0x30>
    if(matchhere(re, text))
  dc:	85a6                	mv	a1,s1
  de:	854a                	mv	a0,s2
  e0:	f6bff0ef          	jal	4a <matchhere>
  e4:	e911                	bnez	a0,f8 <match+0x38>
  }while(*text++ != '\0');
  e6:	0485                	add	s1,s1,1
  e8:	fff4c783          	lbu	a5,-1(s1)
  ec:	fbe5                	bnez	a5,dc <match+0x1c>
  ee:	a031                	j	fa <match+0x3a>
    return matchhere(re+1, text);
  f0:	0505                	add	a0,a0,1
  f2:	f59ff0ef          	jal	4a <matchhere>
  f6:	a011                	j	fa <match+0x3a>
      return 1;
  f8:	4505                	li	a0,1
}
  fa:	60e2                	ld	ra,24(sp)
  fc:	6442                	ld	s0,16(sp)
  fe:	64a2                	ld	s1,8(sp)
 100:	6902                	ld	s2,0(sp)
 102:	6105                	add	sp,sp,32
 104:	8082                	ret

0000000000000106 <grep>:
{
 106:	715d                	add	sp,sp,-80
 108:	e486                	sd	ra,72(sp)
 10a:	e0a2                	sd	s0,64(sp)
 10c:	fc26                	sd	s1,56(sp)
 10e:	f84a                	sd	s2,48(sp)
 110:	f44e                	sd	s3,40(sp)
 112:	f052                	sd	s4,32(sp)
 114:	ec56                	sd	s5,24(sp)
 116:	e85a                	sd	s6,16(sp)
 118:	e45e                	sd	s7,8(sp)
 11a:	e062                	sd	s8,0(sp)
 11c:	0880                	add	s0,sp,80
 11e:	89aa                	mv	s3,a0
 120:	8b2e                	mv	s6,a1
  m = 0;
 122:	4a01                	li	s4,0
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 124:	3ff00b93          	li	s7,1023
 128:	00001a97          	auipc	s5,0x1
 12c:	ee8a8a93          	add	s5,s5,-280 # 1010 <buf>
 130:	a835                	j	16c <grep+0x66>
      p = q+1;
 132:	00148913          	add	s2,s1,1
    while((q = strchr(p, '\n')) != 0){
 136:	45a9                	li	a1,10
 138:	854a                	mv	a0,s2
 13a:	1c6000ef          	jal	300 <strchr>
 13e:	84aa                	mv	s1,a0
 140:	c505                	beqz	a0,168 <grep+0x62>
      *q = 0;
 142:	00048023          	sb	zero,0(s1)
      if(match(pattern, p)){
 146:	85ca                	mv	a1,s2
 148:	854e                	mv	a0,s3
 14a:	f77ff0ef          	jal	c0 <match>
 14e:	d175                	beqz	a0,132 <grep+0x2c>
        *q = '\n';
 150:	47a9                	li	a5,10
 152:	00f48023          	sb	a5,0(s1)
        write(1, p, q+1 - p);
 156:	00148613          	add	a2,s1,1
 15a:	4126063b          	subw	a2,a2,s2
 15e:	85ca                	mv	a1,s2
 160:	4505                	li	a0,1
 162:	5fe000ef          	jal	760 <write>
 166:	b7f1                	j	132 <grep+0x2c>
    if(m > 0){
 168:	03404563          	bgtz	s4,192 <grep+0x8c>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 16c:	414b863b          	subw	a2,s7,s4
 170:	014a85b3          	add	a1,s5,s4
 174:	855a                	mv	a0,s6
 176:	5e2000ef          	jal	758 <read>
 17a:	02a05963          	blez	a0,1ac <grep+0xa6>
    m += n;
 17e:	00aa0c3b          	addw	s8,s4,a0
 182:	000c0a1b          	sext.w	s4,s8
    buf[m] = '\0';
 186:	014a87b3          	add	a5,s5,s4
 18a:	00078023          	sb	zero,0(a5)
    p = buf;
 18e:	8956                	mv	s2,s5
    while((q = strchr(p, '\n')) != 0){
 190:	b75d                	j	136 <grep+0x30>
      m -= p - buf;
 192:	00001517          	auipc	a0,0x1
 196:	e7e50513          	add	a0,a0,-386 # 1010 <buf>
 19a:	40a90a33          	sub	s4,s2,a0
 19e:	414c0a3b          	subw	s4,s8,s4
      memmove(buf, p, m);
 1a2:	8652                	mv	a2,s4
 1a4:	85ca                	mv	a1,s2
 1a6:	270000ef          	jal	416 <memmove>
 1aa:	b7c9                	j	16c <grep+0x66>
}
 1ac:	60a6                	ld	ra,72(sp)
 1ae:	6406                	ld	s0,64(sp)
 1b0:	74e2                	ld	s1,56(sp)
 1b2:	7942                	ld	s2,48(sp)
 1b4:	79a2                	ld	s3,40(sp)
 1b6:	7a02                	ld	s4,32(sp)
 1b8:	6ae2                	ld	s5,24(sp)
 1ba:	6b42                	ld	s6,16(sp)
 1bc:	6ba2                	ld	s7,8(sp)
 1be:	6c02                	ld	s8,0(sp)
 1c0:	6161                	add	sp,sp,80
 1c2:	8082                	ret

00000000000001c4 <main>:
{
 1c4:	7179                	add	sp,sp,-48
 1c6:	f406                	sd	ra,40(sp)
 1c8:	f022                	sd	s0,32(sp)
 1ca:	ec26                	sd	s1,24(sp)
 1cc:	e84a                	sd	s2,16(sp)
 1ce:	e44e                	sd	s3,8(sp)
 1d0:	e052                	sd	s4,0(sp)
 1d2:	1800                	add	s0,sp,48
  if(argc <= 1){
 1d4:	4785                	li	a5,1
 1d6:	04a7d663          	bge	a5,a0,222 <main+0x5e>
  pattern = argv[1];
 1da:	0085ba03          	ld	s4,8(a1)
  if(argc <= 2){
 1de:	4789                	li	a5,2
 1e0:	04a7db63          	bge	a5,a0,236 <main+0x72>
 1e4:	01058913          	add	s2,a1,16
 1e8:	ffd5099b          	addw	s3,a0,-3
 1ec:	02099793          	sll	a5,s3,0x20
 1f0:	01d7d993          	srl	s3,a5,0x1d
 1f4:	05e1                	add	a1,a1,24
 1f6:	99ae                	add	s3,s3,a1
    if((fd = open(argv[i], O_RDONLY)) < 0){
 1f8:	4581                	li	a1,0
 1fa:	00093503          	ld	a0,0(s2)
 1fe:	582000ef          	jal	780 <open>
 202:	84aa                	mv	s1,a0
 204:	04054063          	bltz	a0,244 <main+0x80>
    grep(pattern, fd);
 208:	85aa                	mv	a1,a0
 20a:	8552                	mv	a0,s4
 20c:	efbff0ef          	jal	106 <grep>
    close(fd);
 210:	8526                	mv	a0,s1
 212:	556000ef          	jal	768 <close>
  for(i = 2; i < argc; i++){
 216:	0921                	add	s2,s2,8
 218:	ff3910e3          	bne	s2,s3,1f8 <main+0x34>
  exit(0);
 21c:	4501                	li	a0,0
 21e:	522000ef          	jal	740 <exit>
    fprintf(2, "usage: grep pattern [file ...]\n");
 222:	00001597          	auipc	a1,0x1
 226:	b4e58593          	add	a1,a1,-1202 # d70 <malloc+0x102>
 22a:	4509                	li	a0,2
 22c:	15d000ef          	jal	b88 <fprintf>
    exit(1);
 230:	4505                	li	a0,1
 232:	50e000ef          	jal	740 <exit>
    grep(pattern, 0);
 236:	4581                	li	a1,0
 238:	8552                	mv	a0,s4
 23a:	ecdff0ef          	jal	106 <grep>
    exit(0);
 23e:	4501                	li	a0,0
 240:	500000ef          	jal	740 <exit>
      printf("grep: cannot open %s\n", argv[i]);
 244:	00093583          	ld	a1,0(s2)
 248:	00001517          	auipc	a0,0x1
 24c:	b4850513          	add	a0,a0,-1208 # d90 <malloc+0x122>
 250:	163000ef          	jal	bb2 <printf>
      exit(1);
 254:	4505                	li	a0,1
 256:	4ea000ef          	jal	740 <exit>

000000000000025a <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 25a:	1141                	add	sp,sp,-16
 25c:	e406                	sd	ra,8(sp)
 25e:	e022                	sd	s0,0(sp)
 260:	0800                	add	s0,sp,16
  extern int main();
  main();
 262:	f63ff0ef          	jal	1c4 <main>
  exit(0);
 266:	4501                	li	a0,0
 268:	4d8000ef          	jal	740 <exit>

000000000000026c <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 26c:	1141                	add	sp,sp,-16
 26e:	e422                	sd	s0,8(sp)
 270:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 272:	87aa                	mv	a5,a0
 274:	0585                	add	a1,a1,1
 276:	0785                	add	a5,a5,1
 278:	fff5c703          	lbu	a4,-1(a1)
 27c:	fee78fa3          	sb	a4,-1(a5)
 280:	fb75                	bnez	a4,274 <strcpy+0x8>
    ;
  return os;
}
 282:	6422                	ld	s0,8(sp)
 284:	0141                	add	sp,sp,16
 286:	8082                	ret

0000000000000288 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 288:	1141                	add	sp,sp,-16
 28a:	e422                	sd	s0,8(sp)
 28c:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 28e:	00054783          	lbu	a5,0(a0)
 292:	cb91                	beqz	a5,2a6 <strcmp+0x1e>
 294:	0005c703          	lbu	a4,0(a1)
 298:	00f71763          	bne	a4,a5,2a6 <strcmp+0x1e>
    p++, q++;
 29c:	0505                	add	a0,a0,1
 29e:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 2a0:	00054783          	lbu	a5,0(a0)
 2a4:	fbe5                	bnez	a5,294 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 2a6:	0005c503          	lbu	a0,0(a1)
}
 2aa:	40a7853b          	subw	a0,a5,a0
 2ae:	6422                	ld	s0,8(sp)
 2b0:	0141                	add	sp,sp,16
 2b2:	8082                	ret

00000000000002b4 <strlen>:

uint
strlen(const char *s)
{
 2b4:	1141                	add	sp,sp,-16
 2b6:	e422                	sd	s0,8(sp)
 2b8:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2ba:	00054783          	lbu	a5,0(a0)
 2be:	cf91                	beqz	a5,2da <strlen+0x26>
 2c0:	0505                	add	a0,a0,1
 2c2:	87aa                	mv	a5,a0
 2c4:	86be                	mv	a3,a5
 2c6:	0785                	add	a5,a5,1
 2c8:	fff7c703          	lbu	a4,-1(a5)
 2cc:	ff65                	bnez	a4,2c4 <strlen+0x10>
 2ce:	40a6853b          	subw	a0,a3,a0
 2d2:	2505                	addw	a0,a0,1
    ;
  return n;
}
 2d4:	6422                	ld	s0,8(sp)
 2d6:	0141                	add	sp,sp,16
 2d8:	8082                	ret
  for(n = 0; s[n]; n++)
 2da:	4501                	li	a0,0
 2dc:	bfe5                	j	2d4 <strlen+0x20>

00000000000002de <memset>:

void*
memset(void *dst, int c, uint n)
{
 2de:	1141                	add	sp,sp,-16
 2e0:	e422                	sd	s0,8(sp)
 2e2:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2e4:	ca19                	beqz	a2,2fa <memset+0x1c>
 2e6:	87aa                	mv	a5,a0
 2e8:	1602                	sll	a2,a2,0x20
 2ea:	9201                	srl	a2,a2,0x20
 2ec:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 2f0:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2f4:	0785                	add	a5,a5,1
 2f6:	fee79de3          	bne	a5,a4,2f0 <memset+0x12>
  }
  return dst;
}
 2fa:	6422                	ld	s0,8(sp)
 2fc:	0141                	add	sp,sp,16
 2fe:	8082                	ret

0000000000000300 <strchr>:

char*
strchr(const char *s, char c)
{
 300:	1141                	add	sp,sp,-16
 302:	e422                	sd	s0,8(sp)
 304:	0800                	add	s0,sp,16
  for(; *s; s++)
 306:	00054783          	lbu	a5,0(a0)
 30a:	cb99                	beqz	a5,320 <strchr+0x20>
    if(*s == c)
 30c:	00f58763          	beq	a1,a5,31a <strchr+0x1a>
  for(; *s; s++)
 310:	0505                	add	a0,a0,1
 312:	00054783          	lbu	a5,0(a0)
 316:	fbfd                	bnez	a5,30c <strchr+0xc>
      return (char*)s;
  return 0;
 318:	4501                	li	a0,0
}
 31a:	6422                	ld	s0,8(sp)
 31c:	0141                	add	sp,sp,16
 31e:	8082                	ret
  return 0;
 320:	4501                	li	a0,0
 322:	bfe5                	j	31a <strchr+0x1a>

0000000000000324 <gets>:

char*
gets(char *buf, int max)
{
 324:	711d                	add	sp,sp,-96
 326:	ec86                	sd	ra,88(sp)
 328:	e8a2                	sd	s0,80(sp)
 32a:	e4a6                	sd	s1,72(sp)
 32c:	e0ca                	sd	s2,64(sp)
 32e:	fc4e                	sd	s3,56(sp)
 330:	f852                	sd	s4,48(sp)
 332:	f456                	sd	s5,40(sp)
 334:	f05a                	sd	s6,32(sp)
 336:	ec5e                	sd	s7,24(sp)
 338:	1080                	add	s0,sp,96
 33a:	8baa                	mv	s7,a0
 33c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 33e:	892a                	mv	s2,a0
 340:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 342:	4aa9                	li	s5,10
 344:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 346:	89a6                	mv	s3,s1
 348:	2485                	addw	s1,s1,1
 34a:	0344d663          	bge	s1,s4,376 <gets+0x52>
    cc = read(0, &c, 1);
 34e:	4605                	li	a2,1
 350:	faf40593          	add	a1,s0,-81
 354:	4501                	li	a0,0
 356:	402000ef          	jal	758 <read>
    if(cc < 1)
 35a:	00a05e63          	blez	a0,376 <gets+0x52>
    buf[i++] = c;
 35e:	faf44783          	lbu	a5,-81(s0)
 362:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 366:	01578763          	beq	a5,s5,374 <gets+0x50>
 36a:	0905                	add	s2,s2,1
 36c:	fd679de3          	bne	a5,s6,346 <gets+0x22>
    buf[i++] = c;
 370:	89a6                	mv	s3,s1
 372:	a011                	j	376 <gets+0x52>
 374:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 376:	99de                	add	s3,s3,s7
 378:	00098023          	sb	zero,0(s3)
  return buf;
}
 37c:	855e                	mv	a0,s7
 37e:	60e6                	ld	ra,88(sp)
 380:	6446                	ld	s0,80(sp)
 382:	64a6                	ld	s1,72(sp)
 384:	6906                	ld	s2,64(sp)
 386:	79e2                	ld	s3,56(sp)
 388:	7a42                	ld	s4,48(sp)
 38a:	7aa2                	ld	s5,40(sp)
 38c:	7b02                	ld	s6,32(sp)
 38e:	6be2                	ld	s7,24(sp)
 390:	6125                	add	sp,sp,96
 392:	8082                	ret

0000000000000394 <stat>:

int
stat(const char *n, struct stat *st)
{
 394:	1101                	add	sp,sp,-32
 396:	ec06                	sd	ra,24(sp)
 398:	e822                	sd	s0,16(sp)
 39a:	e04a                	sd	s2,0(sp)
 39c:	1000                	add	s0,sp,32
 39e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3a0:	4581                	li	a1,0
 3a2:	3de000ef          	jal	780 <open>
  if(fd < 0)
 3a6:	02054263          	bltz	a0,3ca <stat+0x36>
 3aa:	e426                	sd	s1,8(sp)
 3ac:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3ae:	85ca                	mv	a1,s2
 3b0:	3e8000ef          	jal	798 <fstat>
 3b4:	892a                	mv	s2,a0
  close(fd);
 3b6:	8526                	mv	a0,s1
 3b8:	3b0000ef          	jal	768 <close>
  return r;
 3bc:	64a2                	ld	s1,8(sp)
}
 3be:	854a                	mv	a0,s2
 3c0:	60e2                	ld	ra,24(sp)
 3c2:	6442                	ld	s0,16(sp)
 3c4:	6902                	ld	s2,0(sp)
 3c6:	6105                	add	sp,sp,32
 3c8:	8082                	ret
    return -1;
 3ca:	597d                	li	s2,-1
 3cc:	bfcd                	j	3be <stat+0x2a>

00000000000003ce <atoi>:

int
atoi(const char *s)
{
 3ce:	1141                	add	sp,sp,-16
 3d0:	e422                	sd	s0,8(sp)
 3d2:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3d4:	00054683          	lbu	a3,0(a0)
 3d8:	fd06879b          	addw	a5,a3,-48
 3dc:	0ff7f793          	zext.b	a5,a5
 3e0:	4625                	li	a2,9
 3e2:	02f66863          	bltu	a2,a5,412 <atoi+0x44>
 3e6:	872a                	mv	a4,a0
  n = 0;
 3e8:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 3ea:	0705                	add	a4,a4,1
 3ec:	0025179b          	sllw	a5,a0,0x2
 3f0:	9fa9                	addw	a5,a5,a0
 3f2:	0017979b          	sllw	a5,a5,0x1
 3f6:	9fb5                	addw	a5,a5,a3
 3f8:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 3fc:	00074683          	lbu	a3,0(a4)
 400:	fd06879b          	addw	a5,a3,-48
 404:	0ff7f793          	zext.b	a5,a5
 408:	fef671e3          	bgeu	a2,a5,3ea <atoi+0x1c>
  return n;
}
 40c:	6422                	ld	s0,8(sp)
 40e:	0141                	add	sp,sp,16
 410:	8082                	ret
  n = 0;
 412:	4501                	li	a0,0
 414:	bfe5                	j	40c <atoi+0x3e>

0000000000000416 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 416:	1141                	add	sp,sp,-16
 418:	e422                	sd	s0,8(sp)
 41a:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 41c:	02b57463          	bgeu	a0,a1,444 <memmove+0x2e>
    while(n-- > 0)
 420:	00c05f63          	blez	a2,43e <memmove+0x28>
 424:	1602                	sll	a2,a2,0x20
 426:	9201                	srl	a2,a2,0x20
 428:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 42c:	872a                	mv	a4,a0
      *dst++ = *src++;
 42e:	0585                	add	a1,a1,1
 430:	0705                	add	a4,a4,1
 432:	fff5c683          	lbu	a3,-1(a1)
 436:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 43a:	fef71ae3          	bne	a4,a5,42e <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 43e:	6422                	ld	s0,8(sp)
 440:	0141                	add	sp,sp,16
 442:	8082                	ret
    dst += n;
 444:	00c50733          	add	a4,a0,a2
    src += n;
 448:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 44a:	fec05ae3          	blez	a2,43e <memmove+0x28>
 44e:	fff6079b          	addw	a5,a2,-1
 452:	1782                	sll	a5,a5,0x20
 454:	9381                	srl	a5,a5,0x20
 456:	fff7c793          	not	a5,a5
 45a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 45c:	15fd                	add	a1,a1,-1
 45e:	177d                	add	a4,a4,-1
 460:	0005c683          	lbu	a3,0(a1)
 464:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 468:	fee79ae3          	bne	a5,a4,45c <memmove+0x46>
 46c:	bfc9                	j	43e <memmove+0x28>

000000000000046e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 46e:	1141                	add	sp,sp,-16
 470:	e422                	sd	s0,8(sp)
 472:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 474:	ca05                	beqz	a2,4a4 <memcmp+0x36>
 476:	fff6069b          	addw	a3,a2,-1
 47a:	1682                	sll	a3,a3,0x20
 47c:	9281                	srl	a3,a3,0x20
 47e:	0685                	add	a3,a3,1
 480:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 482:	00054783          	lbu	a5,0(a0)
 486:	0005c703          	lbu	a4,0(a1)
 48a:	00e79863          	bne	a5,a4,49a <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 48e:	0505                	add	a0,a0,1
    p2++;
 490:	0585                	add	a1,a1,1
  while (n-- > 0) {
 492:	fed518e3          	bne	a0,a3,482 <memcmp+0x14>
  }
  return 0;
 496:	4501                	li	a0,0
 498:	a019                	j	49e <memcmp+0x30>
      return *p1 - *p2;
 49a:	40e7853b          	subw	a0,a5,a4
}
 49e:	6422                	ld	s0,8(sp)
 4a0:	0141                	add	sp,sp,16
 4a2:	8082                	ret
  return 0;
 4a4:	4501                	li	a0,0
 4a6:	bfe5                	j	49e <memcmp+0x30>

00000000000004a8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4a8:	1141                	add	sp,sp,-16
 4aa:	e406                	sd	ra,8(sp)
 4ac:	e022                	sd	s0,0(sp)
 4ae:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 4b0:	f67ff0ef          	jal	416 <memmove>
}
 4b4:	60a2                	ld	ra,8(sp)
 4b6:	6402                	ld	s0,0(sp)
 4b8:	0141                	add	sp,sp,16
 4ba:	8082                	ret

00000000000004bc <htons>:
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
}

uint16_t
htons(uint16_t h)
{
 4bc:	1141                	add	sp,sp,-16
 4be:	e422                	sd	s0,8(sp)
 4c0:	0800                	add	s0,sp,16
    if (!endian) {
 4c2:	00001797          	auipc	a5,0x1
 4c6:	b3e7a783          	lw	a5,-1218(a5) # 1000 <endian>
 4ca:	e385                	bnez	a5,4ea <htons+0x2e>
        endian = byteorder();
 4cc:	4d200793          	li	a5,1234
 4d0:	00001717          	auipc	a4,0x1
 4d4:	b2f72823          	sw	a5,-1232(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 4d8:	0085179b          	sllw	a5,a0,0x8
 4dc:	0085551b          	srlw	a0,a0,0x8
 4e0:	8fc9                	or	a5,a5,a0
 4e2:	03079513          	sll	a0,a5,0x30
 4e6:	9141                	srl	a0,a0,0x30
 4e8:	a029                	j	4f2 <htons+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(h) : h;
 4ea:	4d200713          	li	a4,1234
 4ee:	fee785e3          	beq	a5,a4,4d8 <htons+0x1c>
}
 4f2:	6422                	ld	s0,8(sp)
 4f4:	0141                	add	sp,sp,16
 4f6:	8082                	ret

00000000000004f8 <ntohs>:

uint16_t
ntohs(uint16_t n)
{
 4f8:	1141                	add	sp,sp,-16
 4fa:	e422                	sd	s0,8(sp)
 4fc:	0800                	add	s0,sp,16
    if (!endian) {
 4fe:	00001797          	auipc	a5,0x1
 502:	b027a783          	lw	a5,-1278(a5) # 1000 <endian>
 506:	e385                	bnez	a5,526 <ntohs+0x2e>
        endian = byteorder();
 508:	4d200793          	li	a5,1234
 50c:	00001717          	auipc	a4,0x1
 510:	aef72a23          	sw	a5,-1292(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 514:	0085179b          	sllw	a5,a0,0x8
 518:	0085551b          	srlw	a0,a0,0x8
 51c:	8fc9                	or	a5,a5,a0
 51e:	03079513          	sll	a0,a5,0x30
 522:	9141                	srl	a0,a0,0x30
 524:	a029                	j	52e <ntohs+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(n) : n;
 526:	4d200713          	li	a4,1234
 52a:	fee785e3          	beq	a5,a4,514 <ntohs+0x1c>
}
 52e:	6422                	ld	s0,8(sp)
 530:	0141                	add	sp,sp,16
 532:	8082                	ret

0000000000000534 <htonl>:

uint32_t
htonl(uint32_t h)
{
 534:	1141                	add	sp,sp,-16
 536:	e422                	sd	s0,8(sp)
 538:	0800                	add	s0,sp,16
    if (!endian) {
 53a:	00001797          	auipc	a5,0x1
 53e:	ac67a783          	lw	a5,-1338(a5) # 1000 <endian>
 542:	ef85                	bnez	a5,57a <htonl+0x46>
        endian = byteorder();
 544:	4d200793          	li	a5,1234
 548:	00001717          	auipc	a4,0x1
 54c:	aaf72c23          	sw	a5,-1352(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 550:	0185179b          	sllw	a5,a0,0x18
 554:	0185571b          	srlw	a4,a0,0x18
 558:	8fd9                	or	a5,a5,a4
 55a:	0085171b          	sllw	a4,a0,0x8
 55e:	00ff06b7          	lui	a3,0xff0
 562:	8f75                	and	a4,a4,a3
 564:	8fd9                	or	a5,a5,a4
 566:	0085551b          	srlw	a0,a0,0x8
 56a:	6741                	lui	a4,0x10
 56c:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeaf0>
 570:	8d79                	and	a0,a0,a4
 572:	8fc9                	or	a5,a5,a0
 574:	0007851b          	sext.w	a0,a5
 578:	a029                	j	582 <htonl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(h) : h;
 57a:	4d200713          	li	a4,1234
 57e:	fce789e3          	beq	a5,a4,550 <htonl+0x1c>
}
 582:	6422                	ld	s0,8(sp)
 584:	0141                	add	sp,sp,16
 586:	8082                	ret

0000000000000588 <ntohl>:

uint32_t
ntohl(uint32_t n)
{
 588:	1141                	add	sp,sp,-16
 58a:	e422                	sd	s0,8(sp)
 58c:	0800                	add	s0,sp,16
    if (!endian) {
 58e:	00001797          	auipc	a5,0x1
 592:	a727a783          	lw	a5,-1422(a5) # 1000 <endian>
 596:	ef85                	bnez	a5,5ce <ntohl+0x46>
        endian = byteorder();
 598:	4d200793          	li	a5,1234
 59c:	00001717          	auipc	a4,0x1
 5a0:	a6f72223          	sw	a5,-1436(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 5a4:	0185179b          	sllw	a5,a0,0x18
 5a8:	0185571b          	srlw	a4,a0,0x18
 5ac:	8fd9                	or	a5,a5,a4
 5ae:	0085171b          	sllw	a4,a0,0x8
 5b2:	00ff06b7          	lui	a3,0xff0
 5b6:	8f75                	and	a4,a4,a3
 5b8:	8fd9                	or	a5,a5,a4
 5ba:	0085551b          	srlw	a0,a0,0x8
 5be:	6741                	lui	a4,0x10
 5c0:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeaf0>
 5c4:	8d79                	and	a0,a0,a4
 5c6:	8fc9                	or	a5,a5,a0
 5c8:	0007851b          	sext.w	a0,a5
 5cc:	a029                	j	5d6 <ntohl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(n) : n;
 5ce:	4d200713          	li	a4,1234
 5d2:	fce789e3          	beq	a5,a4,5a4 <ntohl+0x1c>
}
 5d6:	6422                	ld	s0,8(sp)
 5d8:	0141                	add	sp,sp,16
 5da:	8082                	ret

00000000000005dc <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
 5dc:	1141                	add	sp,sp,-16
 5de:	e422                	sd	s0,8(sp)
 5e0:	0800                	add	s0,sp,16
 5e2:	872a                	mv	a4,a0
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
 5e4:	02000693          	li	a3,32
 5e8:	4525                	li	a0,9
 5ea:	a011                	j	5ee <strtol+0x12>
        s++;
 5ec:	0705                	add	a4,a4,1
    while (*s == ' ' || *s == '\t')
 5ee:	00074783          	lbu	a5,0(a4)
 5f2:	fed78de3          	beq	a5,a3,5ec <strtol+0x10>
 5f6:	fea78be3          	beq	a5,a0,5ec <strtol+0x10>

    // plus/minus sign
    if (*s == '+')
 5fa:	02b00693          	li	a3,43
 5fe:	02d78663          	beq	a5,a3,62a <strtol+0x4e>
        s++;
    else if (*s == '-')
 602:	02d00693          	li	a3,45
    int neg = 0;
 606:	4301                	li	t1,0
    else if (*s == '-')
 608:	02d78463          	beq	a5,a3,630 <strtol+0x54>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 60c:	fef67793          	and	a5,a2,-17
 610:	eb89                	bnez	a5,622 <strtol+0x46>
 612:	00074683          	lbu	a3,0(a4)
 616:	03000793          	li	a5,48
 61a:	00f68e63          	beq	a3,a5,636 <strtol+0x5a>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
 61e:	e211                	bnez	a2,622 <strtol+0x46>
        s++, base = 8;
    else if (base == 0)
        base = 10;
 620:	4629                	li	a2,10
 622:	4501                	li	a0,0

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
 624:	4825                	li	a6,9
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
 626:	48e5                	li	a7,25
 628:	a825                	j	660 <strtol+0x84>
        s++;
 62a:	0705                	add	a4,a4,1
    int neg = 0;
 62c:	4301                	li	t1,0
 62e:	bff9                	j	60c <strtol+0x30>
        s++, neg = 1;
 630:	0705                	add	a4,a4,1
 632:	4305                	li	t1,1
 634:	bfe1                	j	60c <strtol+0x30>
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 636:	00174683          	lbu	a3,1(a4)
 63a:	07800793          	li	a5,120
 63e:	00f68663          	beq	a3,a5,64a <strtol+0x6e>
    else if (base == 0 && s[0] == '0')
 642:	f265                	bnez	a2,622 <strtol+0x46>
        s++, base = 8;
 644:	0705                	add	a4,a4,1
 646:	4621                	li	a2,8
 648:	bfe9                	j	622 <strtol+0x46>
        s += 2, base = 16;
 64a:	0709                	add	a4,a4,2
 64c:	4641                	li	a2,16
 64e:	bfd1                	j	622 <strtol+0x46>
            dig = *s - '0';
 650:	fd07879b          	addw	a5,a5,-48
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
 654:	04c7d063          	bge	a5,a2,694 <strtol+0xb8>
            break;
        s++, val = (val * base) + dig;
 658:	0705                	add	a4,a4,1
 65a:	02a60533          	mul	a0,a2,a0
 65e:	953e                	add	a0,a0,a5
        if (*s >= '0' && *s <= '9')
 660:	00074783          	lbu	a5,0(a4)
 664:	fd07869b          	addw	a3,a5,-48
 668:	0ff6f693          	zext.b	a3,a3
 66c:	fed872e3          	bgeu	a6,a3,650 <strtol+0x74>
        else if (*s >= 'a' && *s <= 'z')
 670:	f9f7869b          	addw	a3,a5,-97
 674:	0ff6f693          	zext.b	a3,a3
 678:	00d8e563          	bltu	a7,a3,682 <strtol+0xa6>
            dig = *s - 'a' + 10;
 67c:	fa97879b          	addw	a5,a5,-87
 680:	bfd1                	j	654 <strtol+0x78>
        else if (*s >= 'A' && *s <= 'Z')
 682:	fbf7869b          	addw	a3,a5,-65
 686:	0ff6f693          	zext.b	a3,a3
 68a:	00d8e563          	bltu	a7,a3,694 <strtol+0xb8>
            dig = *s - 'A' + 10;
 68e:	fc97879b          	addw	a5,a5,-55
 692:	b7c9                	j	654 <strtol+0x78>
        // we don't properly detect overflow!
    }

    if (endptr)
 694:	c191                	beqz	a1,698 <strtol+0xbc>
        *endptr = (char *) s;
 696:	e198                	sd	a4,0(a1)
    return (neg ? -val : val);
 698:	00030463          	beqz	t1,6a0 <strtol+0xc4>
 69c:	40a00533          	neg	a0,a0
}
 6a0:	6422                	ld	s0,8(sp)
 6a2:	0141                	add	sp,sp,16
 6a4:	8082                	ret

00000000000006a6 <inet_pton>:
inet_pton (int family, const char *p, void *n) {
    char *sp, *ep;
    int idx;
    long ret;

    if (family != AF_INET) {
 6a6:	4785                	li	a5,1
 6a8:	08f51063          	bne	a0,a5,728 <inet_pton+0x82>
inet_pton (int family, const char *p, void *n) {
 6ac:	715d                	add	sp,sp,-80
 6ae:	e486                	sd	ra,72(sp)
 6b0:	e0a2                	sd	s0,64(sp)
 6b2:	fc26                	sd	s1,56(sp)
 6b4:	f84a                	sd	s2,48(sp)
 6b6:	f44e                	sd	s3,40(sp)
 6b8:	f052                	sd	s4,32(sp)
 6ba:	ec56                	sd	s5,24(sp)
 6bc:	e85a                	sd	s6,16(sp)
 6be:	0880                	add	s0,sp,80
 6c0:	84ae                	mv	s1,a1
 6c2:	89b2                	mv	s3,a2
 6c4:	4901                	li	s2,0
        return -1;
    }
    sp = (char *)p;
    for (idx = 0; idx < 4; idx++) {
        ret = strtol(sp, &ep, 10);
        if (ret < 0 || ret > 255) {
 6c6:	0ff00a13          	li	s4,255
            return -1;
        }
        if (ep == sp) {
            return -1;
        }
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 6ca:	4a8d                	li	s5,3
 6cc:	02e00b13          	li	s6,46
 6d0:	a805                	j	700 <inet_pton+0x5a>
 6d2:	0007c783          	lbu	a5,0(a5)
 6d6:	efb9                	bnez	a5,734 <inet_pton+0x8e>
            return -1;
        }
        ((uint8_t *)n)[idx] = ret;
 6d8:	00a981a3          	sb	a0,3(s3)
        sp = ep + 1;
    }
    return 0;
 6dc:	4501                	li	a0,0
}
 6de:	60a6                	ld	ra,72(sp)
 6e0:	6406                	ld	s0,64(sp)
 6e2:	74e2                	ld	s1,56(sp)
 6e4:	7942                	ld	s2,48(sp)
 6e6:	79a2                	ld	s3,40(sp)
 6e8:	7a02                	ld	s4,32(sp)
 6ea:	6ae2                	ld	s5,24(sp)
 6ec:	6b42                	ld	s6,16(sp)
 6ee:	6161                	add	sp,sp,80
 6f0:	8082                	ret
        ((uint8_t *)n)[idx] = ret;
 6f2:	01298733          	add	a4,s3,s2
 6f6:	00a70023          	sb	a0,0(a4)
        sp = ep + 1;
 6fa:	00178493          	add	s1,a5,1
    for (idx = 0; idx < 4; idx++) {
 6fe:	0905                	add	s2,s2,1
        ret = strtol(sp, &ep, 10);
 700:	4629                	li	a2,10
 702:	fb840593          	add	a1,s0,-72
 706:	8526                	mv	a0,s1
 708:	ed5ff0ef          	jal	5dc <strtol>
        if (ret < 0 || ret > 255) {
 70c:	02aa6063          	bltu	s4,a0,72c <inet_pton+0x86>
        if (ep == sp) {
 710:	fb843783          	ld	a5,-72(s0)
 714:	00978e63          	beq	a5,s1,730 <inet_pton+0x8a>
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 718:	fb590de3          	beq	s2,s5,6d2 <inet_pton+0x2c>
 71c:	0007c703          	lbu	a4,0(a5)
 720:	fd6709e3          	beq	a4,s6,6f2 <inet_pton+0x4c>
            return -1;
 724:	557d                	li	a0,-1
 726:	bf65                	j	6de <inet_pton+0x38>
        return -1;
 728:	557d                	li	a0,-1
}
 72a:	8082                	ret
            return -1;
 72c:	557d                	li	a0,-1
 72e:	bf45                	j	6de <inet_pton+0x38>
            return -1;
 730:	557d                	li	a0,-1
 732:	b775                	j	6de <inet_pton+0x38>
            return -1;
 734:	557d                	li	a0,-1
 736:	b765                	j	6de <inet_pton+0x38>

0000000000000738 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 738:	4885                	li	a7,1
 ecall
 73a:	00000073          	ecall
 ret
 73e:	8082                	ret

0000000000000740 <exit>:
.global exit
exit:
 li a7, SYS_exit
 740:	4889                	li	a7,2
 ecall
 742:	00000073          	ecall
 ret
 746:	8082                	ret

0000000000000748 <wait>:
.global wait
wait:
 li a7, SYS_wait
 748:	488d                	li	a7,3
 ecall
 74a:	00000073          	ecall
 ret
 74e:	8082                	ret

0000000000000750 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 750:	4891                	li	a7,4
 ecall
 752:	00000073          	ecall
 ret
 756:	8082                	ret

0000000000000758 <read>:
.global read
read:
 li a7, SYS_read
 758:	4895                	li	a7,5
 ecall
 75a:	00000073          	ecall
 ret
 75e:	8082                	ret

0000000000000760 <write>:
.global write
write:
 li a7, SYS_write
 760:	48c1                	li	a7,16
 ecall
 762:	00000073          	ecall
 ret
 766:	8082                	ret

0000000000000768 <close>:
.global close
close:
 li a7, SYS_close
 768:	48d5                	li	a7,21
 ecall
 76a:	00000073          	ecall
 ret
 76e:	8082                	ret

0000000000000770 <kill>:
.global kill
kill:
 li a7, SYS_kill
 770:	4899                	li	a7,6
 ecall
 772:	00000073          	ecall
 ret
 776:	8082                	ret

0000000000000778 <exec>:
.global exec
exec:
 li a7, SYS_exec
 778:	489d                	li	a7,7
 ecall
 77a:	00000073          	ecall
 ret
 77e:	8082                	ret

0000000000000780 <open>:
.global open
open:
 li a7, SYS_open
 780:	48bd                	li	a7,15
 ecall
 782:	00000073          	ecall
 ret
 786:	8082                	ret

0000000000000788 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 788:	48c5                	li	a7,17
 ecall
 78a:	00000073          	ecall
 ret
 78e:	8082                	ret

0000000000000790 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 790:	48c9                	li	a7,18
 ecall
 792:	00000073          	ecall
 ret
 796:	8082                	ret

0000000000000798 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 798:	48a1                	li	a7,8
 ecall
 79a:	00000073          	ecall
 ret
 79e:	8082                	ret

00000000000007a0 <link>:
.global link
link:
 li a7, SYS_link
 7a0:	48cd                	li	a7,19
 ecall
 7a2:	00000073          	ecall
 ret
 7a6:	8082                	ret

00000000000007a8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 7a8:	48d1                	li	a7,20
 ecall
 7aa:	00000073          	ecall
 ret
 7ae:	8082                	ret

00000000000007b0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 7b0:	48a5                	li	a7,9
 ecall
 7b2:	00000073          	ecall
 ret
 7b6:	8082                	ret

00000000000007b8 <dup>:
.global dup
dup:
 li a7, SYS_dup
 7b8:	48a9                	li	a7,10
 ecall
 7ba:	00000073          	ecall
 ret
 7be:	8082                	ret

00000000000007c0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 7c0:	48ad                	li	a7,11
 ecall
 7c2:	00000073          	ecall
 ret
 7c6:	8082                	ret

00000000000007c8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 7c8:	48b1                	li	a7,12
 ecall
 7ca:	00000073          	ecall
 ret
 7ce:	8082                	ret

00000000000007d0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 7d0:	48b5                	li	a7,13
 ecall
 7d2:	00000073          	ecall
 ret
 7d6:	8082                	ret

00000000000007d8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 7d8:	48b9                	li	a7,14
 ecall
 7da:	00000073          	ecall
 ret
 7de:	8082                	ret

00000000000007e0 <socket>:
.global socket
socket:
 li a7, SYS_socket
 7e0:	48d9                	li	a7,22
 ecall
 7e2:	00000073          	ecall
 ret
 7e6:	8082                	ret

00000000000007e8 <bind>:
.global bind
bind:
 li a7, SYS_bind
 7e8:	48dd                	li	a7,23
 ecall
 7ea:	00000073          	ecall
 ret
 7ee:	8082                	ret

00000000000007f0 <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 7f0:	48e1                	li	a7,24
 ecall
 7f2:	00000073          	ecall
 ret
 7f6:	8082                	ret

00000000000007f8 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 7f8:	48e5                	li	a7,25
 ecall
 7fa:	00000073          	ecall
 ret
 7fe:	8082                	ret

0000000000000800 <connect>:
.global connect
connect:
 li a7, SYS_connect
 800:	48e9                	li	a7,26
 ecall
 802:	00000073          	ecall
 ret
 806:	8082                	ret

0000000000000808 <listen>:
.global listen
listen:
 li a7, SYS_listen
 808:	48ed                	li	a7,27
 ecall
 80a:	00000073          	ecall
 ret
 80e:	8082                	ret

0000000000000810 <accept>:
.global accept
accept:
 li a7, SYS_accept
 810:	48f1                	li	a7,28
 ecall
 812:	00000073          	ecall
 ret
 816:	8082                	ret

0000000000000818 <recv>:
.global recv
recv:
 li a7, SYS_recv
 818:	48f5                	li	a7,29
 ecall
 81a:	00000073          	ecall
 ret
 81e:	8082                	ret

0000000000000820 <send>:
.global send
send:
 li a7, SYS_send
 820:	48f9                	li	a7,30
 ecall
 822:	00000073          	ecall
 ret
 826:	8082                	ret

0000000000000828 <ioctl>:
.global ioctl
ioctl:
 li a7, SYS_ioctl
 828:	48fd                	li	a7,31
 ecall
 82a:	00000073          	ecall
 ret
 82e:	8082                	ret

0000000000000830 <consolemode>:
.global consolemode
consolemode:
 li a7, SYS_consolemode
 830:	02000893          	li	a7,32
 ecall
 834:	00000073          	ecall
 ret
 838:	8082                	ret

000000000000083a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 83a:	1101                	add	sp,sp,-32
 83c:	ec06                	sd	ra,24(sp)
 83e:	e822                	sd	s0,16(sp)
 840:	1000                	add	s0,sp,32
 842:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 846:	4605                	li	a2,1
 848:	fef40593          	add	a1,s0,-17
 84c:	f15ff0ef          	jal	760 <write>
}
 850:	60e2                	ld	ra,24(sp)
 852:	6442                	ld	s0,16(sp)
 854:	6105                	add	sp,sp,32
 856:	8082                	ret

0000000000000858 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 858:	715d                	add	sp,sp,-80
 85a:	e486                	sd	ra,72(sp)
 85c:	e0a2                	sd	s0,64(sp)
 85e:	fc26                	sd	s1,56(sp)
 860:	0880                	add	s0,sp,80
 862:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 864:	c299                	beqz	a3,86a <printint+0x12>
 866:	0805c963          	bltz	a1,8f8 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 86a:	2581                	sext.w	a1,a1
  neg = 0;
 86c:	4881                	li	a7,0
 86e:	fb840693          	add	a3,s0,-72
  }

  i = 0;
 872:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 874:	2601                	sext.w	a2,a2
 876:	00000517          	auipc	a0,0x0
 87a:	53a50513          	add	a0,a0,1338 # db0 <digits>
 87e:	883a                	mv	a6,a4
 880:	2705                	addw	a4,a4,1
 882:	02c5f7bb          	remuw	a5,a1,a2
 886:	1782                	sll	a5,a5,0x20
 888:	9381                	srl	a5,a5,0x20
 88a:	97aa                	add	a5,a5,a0
 88c:	0007c783          	lbu	a5,0(a5)
 890:	00f68023          	sb	a5,0(a3) # ff0000 <base+0xfeebf0>
  }while((x /= base) != 0);
 894:	0005879b          	sext.w	a5,a1
 898:	02c5d5bb          	divuw	a1,a1,a2
 89c:	0685                	add	a3,a3,1
 89e:	fec7f0e3          	bgeu	a5,a2,87e <printint+0x26>
  if(neg)
 8a2:	00088c63          	beqz	a7,8ba <printint+0x62>
    buf[i++] = '-';
 8a6:	fd070793          	add	a5,a4,-48
 8aa:	00878733          	add	a4,a5,s0
 8ae:	02d00793          	li	a5,45
 8b2:	fef70423          	sb	a5,-24(a4)
 8b6:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 8ba:	02e05a63          	blez	a4,8ee <printint+0x96>
 8be:	f84a                	sd	s2,48(sp)
 8c0:	f44e                	sd	s3,40(sp)
 8c2:	fb840793          	add	a5,s0,-72
 8c6:	00e78933          	add	s2,a5,a4
 8ca:	fff78993          	add	s3,a5,-1
 8ce:	99ba                	add	s3,s3,a4
 8d0:	377d                	addw	a4,a4,-1
 8d2:	1702                	sll	a4,a4,0x20
 8d4:	9301                	srl	a4,a4,0x20
 8d6:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 8da:	fff94583          	lbu	a1,-1(s2)
 8de:	8526                	mv	a0,s1
 8e0:	f5bff0ef          	jal	83a <putc>
  while(--i >= 0)
 8e4:	197d                	add	s2,s2,-1
 8e6:	ff391ae3          	bne	s2,s3,8da <printint+0x82>
 8ea:	7942                	ld	s2,48(sp)
 8ec:	79a2                	ld	s3,40(sp)
}
 8ee:	60a6                	ld	ra,72(sp)
 8f0:	6406                	ld	s0,64(sp)
 8f2:	74e2                	ld	s1,56(sp)
 8f4:	6161                	add	sp,sp,80
 8f6:	8082                	ret
    x = -xx;
 8f8:	40b005bb          	negw	a1,a1
    neg = 1;
 8fc:	4885                	li	a7,1
    x = -xx;
 8fe:	bf85                	j	86e <printint+0x16>

0000000000000900 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 900:	711d                	add	sp,sp,-96
 902:	ec86                	sd	ra,88(sp)
 904:	e8a2                	sd	s0,80(sp)
 906:	e0ca                	sd	s2,64(sp)
 908:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 90a:	0005c903          	lbu	s2,0(a1)
 90e:	26090863          	beqz	s2,b7e <vprintf+0x27e>
 912:	e4a6                	sd	s1,72(sp)
 914:	fc4e                	sd	s3,56(sp)
 916:	f852                	sd	s4,48(sp)
 918:	f456                	sd	s5,40(sp)
 91a:	f05a                	sd	s6,32(sp)
 91c:	ec5e                	sd	s7,24(sp)
 91e:	e862                	sd	s8,16(sp)
 920:	e466                	sd	s9,8(sp)
 922:	8b2a                	mv	s6,a0
 924:	8a2e                	mv	s4,a1
 926:	8bb2                	mv	s7,a2
  state = 0;
 928:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 92a:	4481                	li	s1,0
 92c:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 92e:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 932:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 936:	06c00c93          	li	s9,108
 93a:	a005                	j	95a <vprintf+0x5a>
        putc(fd, c0);
 93c:	85ca                	mv	a1,s2
 93e:	855a                	mv	a0,s6
 940:	efbff0ef          	jal	83a <putc>
 944:	a019                	j	94a <vprintf+0x4a>
    } else if(state == '%'){
 946:	03598263          	beq	s3,s5,96a <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 94a:	2485                	addw	s1,s1,1
 94c:	8726                	mv	a4,s1
 94e:	009a07b3          	add	a5,s4,s1
 952:	0007c903          	lbu	s2,0(a5)
 956:	20090c63          	beqz	s2,b6e <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 95a:	0009079b          	sext.w	a5,s2
    if(state == 0){
 95e:	fe0994e3          	bnez	s3,946 <vprintf+0x46>
      if(c0 == '%'){
 962:	fd579de3          	bne	a5,s5,93c <vprintf+0x3c>
        state = '%';
 966:	89be                	mv	s3,a5
 968:	b7cd                	j	94a <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 96a:	00ea06b3          	add	a3,s4,a4
 96e:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 972:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 974:	c681                	beqz	a3,97c <vprintf+0x7c>
 976:	9752                	add	a4,a4,s4
 978:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 97c:	03878f63          	beq	a5,s8,9ba <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 980:	05978963          	beq	a5,s9,9d2 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 984:	07500713          	li	a4,117
 988:	0ee78363          	beq	a5,a4,a6e <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 98c:	07800713          	li	a4,120
 990:	12e78563          	beq	a5,a4,aba <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 994:	07000713          	li	a4,112
 998:	14e78a63          	beq	a5,a4,aec <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 99c:	07300713          	li	a4,115
 9a0:	18e78a63          	beq	a5,a4,b34 <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 9a4:	02500713          	li	a4,37
 9a8:	04e79563          	bne	a5,a4,9f2 <vprintf+0xf2>
        putc(fd, '%');
 9ac:	02500593          	li	a1,37
 9b0:	855a                	mv	a0,s6
 9b2:	e89ff0ef          	jal	83a <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 9b6:	4981                	li	s3,0
 9b8:	bf49                	j	94a <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 9ba:	008b8913          	add	s2,s7,8
 9be:	4685                	li	a3,1
 9c0:	4629                	li	a2,10
 9c2:	000ba583          	lw	a1,0(s7)
 9c6:	855a                	mv	a0,s6
 9c8:	e91ff0ef          	jal	858 <printint>
 9cc:	8bca                	mv	s7,s2
      state = 0;
 9ce:	4981                	li	s3,0
 9d0:	bfad                	j	94a <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 9d2:	06400793          	li	a5,100
 9d6:	02f68963          	beq	a3,a5,a08 <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 9da:	06c00793          	li	a5,108
 9de:	04f68263          	beq	a3,a5,a22 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 9e2:	07500793          	li	a5,117
 9e6:	0af68063          	beq	a3,a5,a86 <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 9ea:	07800793          	li	a5,120
 9ee:	0ef68263          	beq	a3,a5,ad2 <vprintf+0x1d2>
        putc(fd, '%');
 9f2:	02500593          	li	a1,37
 9f6:	855a                	mv	a0,s6
 9f8:	e43ff0ef          	jal	83a <putc>
        putc(fd, c0);
 9fc:	85ca                	mv	a1,s2
 9fe:	855a                	mv	a0,s6
 a00:	e3bff0ef          	jal	83a <putc>
      state = 0;
 a04:	4981                	li	s3,0
 a06:	b791                	j	94a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 a08:	008b8913          	add	s2,s7,8
 a0c:	4685                	li	a3,1
 a0e:	4629                	li	a2,10
 a10:	000bb583          	ld	a1,0(s7)
 a14:	855a                	mv	a0,s6
 a16:	e43ff0ef          	jal	858 <printint>
        i += 1;
 a1a:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 a1c:	8bca                	mv	s7,s2
      state = 0;
 a1e:	4981                	li	s3,0
        i += 1;
 a20:	b72d                	j	94a <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 a22:	06400793          	li	a5,100
 a26:	02f60763          	beq	a2,a5,a54 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 a2a:	07500793          	li	a5,117
 a2e:	06f60963          	beq	a2,a5,aa0 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 a32:	07800793          	li	a5,120
 a36:	faf61ee3          	bne	a2,a5,9f2 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 a3a:	008b8913          	add	s2,s7,8
 a3e:	4681                	li	a3,0
 a40:	4641                	li	a2,16
 a42:	000bb583          	ld	a1,0(s7)
 a46:	855a                	mv	a0,s6
 a48:	e11ff0ef          	jal	858 <printint>
        i += 2;
 a4c:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 a4e:	8bca                	mv	s7,s2
      state = 0;
 a50:	4981                	li	s3,0
        i += 2;
 a52:	bde5                	j	94a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 a54:	008b8913          	add	s2,s7,8
 a58:	4685                	li	a3,1
 a5a:	4629                	li	a2,10
 a5c:	000bb583          	ld	a1,0(s7)
 a60:	855a                	mv	a0,s6
 a62:	df7ff0ef          	jal	858 <printint>
        i += 2;
 a66:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 a68:	8bca                	mv	s7,s2
      state = 0;
 a6a:	4981                	li	s3,0
        i += 2;
 a6c:	bdf9                	j	94a <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 a6e:	008b8913          	add	s2,s7,8
 a72:	4681                	li	a3,0
 a74:	4629                	li	a2,10
 a76:	000ba583          	lw	a1,0(s7)
 a7a:	855a                	mv	a0,s6
 a7c:	dddff0ef          	jal	858 <printint>
 a80:	8bca                	mv	s7,s2
      state = 0;
 a82:	4981                	li	s3,0
 a84:	b5d9                	j	94a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 a86:	008b8913          	add	s2,s7,8
 a8a:	4681                	li	a3,0
 a8c:	4629                	li	a2,10
 a8e:	000bb583          	ld	a1,0(s7)
 a92:	855a                	mv	a0,s6
 a94:	dc5ff0ef          	jal	858 <printint>
        i += 1;
 a98:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 a9a:	8bca                	mv	s7,s2
      state = 0;
 a9c:	4981                	li	s3,0
        i += 1;
 a9e:	b575                	j	94a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 aa0:	008b8913          	add	s2,s7,8
 aa4:	4681                	li	a3,0
 aa6:	4629                	li	a2,10
 aa8:	000bb583          	ld	a1,0(s7)
 aac:	855a                	mv	a0,s6
 aae:	dabff0ef          	jal	858 <printint>
        i += 2;
 ab2:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 ab4:	8bca                	mv	s7,s2
      state = 0;
 ab6:	4981                	li	s3,0
        i += 2;
 ab8:	bd49                	j	94a <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 aba:	008b8913          	add	s2,s7,8
 abe:	4681                	li	a3,0
 ac0:	4641                	li	a2,16
 ac2:	000ba583          	lw	a1,0(s7)
 ac6:	855a                	mv	a0,s6
 ac8:	d91ff0ef          	jal	858 <printint>
 acc:	8bca                	mv	s7,s2
      state = 0;
 ace:	4981                	li	s3,0
 ad0:	bdad                	j	94a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 ad2:	008b8913          	add	s2,s7,8
 ad6:	4681                	li	a3,0
 ad8:	4641                	li	a2,16
 ada:	000bb583          	ld	a1,0(s7)
 ade:	855a                	mv	a0,s6
 ae0:	d79ff0ef          	jal	858 <printint>
        i += 1;
 ae4:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 ae6:	8bca                	mv	s7,s2
      state = 0;
 ae8:	4981                	li	s3,0
        i += 1;
 aea:	b585                	j	94a <vprintf+0x4a>
 aec:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 aee:	008b8d13          	add	s10,s7,8
 af2:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 af6:	03000593          	li	a1,48
 afa:	855a                	mv	a0,s6
 afc:	d3fff0ef          	jal	83a <putc>
  putc(fd, 'x');
 b00:	07800593          	li	a1,120
 b04:	855a                	mv	a0,s6
 b06:	d35ff0ef          	jal	83a <putc>
 b0a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 b0c:	00000b97          	auipc	s7,0x0
 b10:	2a4b8b93          	add	s7,s7,676 # db0 <digits>
 b14:	03c9d793          	srl	a5,s3,0x3c
 b18:	97de                	add	a5,a5,s7
 b1a:	0007c583          	lbu	a1,0(a5)
 b1e:	855a                	mv	a0,s6
 b20:	d1bff0ef          	jal	83a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 b24:	0992                	sll	s3,s3,0x4
 b26:	397d                	addw	s2,s2,-1
 b28:	fe0916e3          	bnez	s2,b14 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 b2c:	8bea                	mv	s7,s10
      state = 0;
 b2e:	4981                	li	s3,0
 b30:	6d02                	ld	s10,0(sp)
 b32:	bd21                	j	94a <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 b34:	008b8993          	add	s3,s7,8
 b38:	000bb903          	ld	s2,0(s7)
 b3c:	00090f63          	beqz	s2,b5a <vprintf+0x25a>
        for(; *s; s++)
 b40:	00094583          	lbu	a1,0(s2)
 b44:	c195                	beqz	a1,b68 <vprintf+0x268>
          putc(fd, *s);
 b46:	855a                	mv	a0,s6
 b48:	cf3ff0ef          	jal	83a <putc>
        for(; *s; s++)
 b4c:	0905                	add	s2,s2,1
 b4e:	00094583          	lbu	a1,0(s2)
 b52:	f9f5                	bnez	a1,b46 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 b54:	8bce                	mv	s7,s3
      state = 0;
 b56:	4981                	li	s3,0
 b58:	bbcd                	j	94a <vprintf+0x4a>
          s = "(null)";
 b5a:	00000917          	auipc	s2,0x0
 b5e:	24e90913          	add	s2,s2,590 # da8 <malloc+0x13a>
        for(; *s; s++)
 b62:	02800593          	li	a1,40
 b66:	b7c5                	j	b46 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 b68:	8bce                	mv	s7,s3
      state = 0;
 b6a:	4981                	li	s3,0
 b6c:	bbf9                	j	94a <vprintf+0x4a>
 b6e:	64a6                	ld	s1,72(sp)
 b70:	79e2                	ld	s3,56(sp)
 b72:	7a42                	ld	s4,48(sp)
 b74:	7aa2                	ld	s5,40(sp)
 b76:	7b02                	ld	s6,32(sp)
 b78:	6be2                	ld	s7,24(sp)
 b7a:	6c42                	ld	s8,16(sp)
 b7c:	6ca2                	ld	s9,8(sp)
    }
  }
}
 b7e:	60e6                	ld	ra,88(sp)
 b80:	6446                	ld	s0,80(sp)
 b82:	6906                	ld	s2,64(sp)
 b84:	6125                	add	sp,sp,96
 b86:	8082                	ret

0000000000000b88 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 b88:	715d                	add	sp,sp,-80
 b8a:	ec06                	sd	ra,24(sp)
 b8c:	e822                	sd	s0,16(sp)
 b8e:	1000                	add	s0,sp,32
 b90:	e010                	sd	a2,0(s0)
 b92:	e414                	sd	a3,8(s0)
 b94:	e818                	sd	a4,16(s0)
 b96:	ec1c                	sd	a5,24(s0)
 b98:	03043023          	sd	a6,32(s0)
 b9c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 ba0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 ba4:	8622                	mv	a2,s0
 ba6:	d5bff0ef          	jal	900 <vprintf>
}
 baa:	60e2                	ld	ra,24(sp)
 bac:	6442                	ld	s0,16(sp)
 bae:	6161                	add	sp,sp,80
 bb0:	8082                	ret

0000000000000bb2 <printf>:

void
printf(const char *fmt, ...)
{
 bb2:	711d                	add	sp,sp,-96
 bb4:	ec06                	sd	ra,24(sp)
 bb6:	e822                	sd	s0,16(sp)
 bb8:	1000                	add	s0,sp,32
 bba:	e40c                	sd	a1,8(s0)
 bbc:	e810                	sd	a2,16(s0)
 bbe:	ec14                	sd	a3,24(s0)
 bc0:	f018                	sd	a4,32(s0)
 bc2:	f41c                	sd	a5,40(s0)
 bc4:	03043823          	sd	a6,48(s0)
 bc8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 bcc:	00840613          	add	a2,s0,8
 bd0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 bd4:	85aa                	mv	a1,a0
 bd6:	4505                	li	a0,1
 bd8:	d29ff0ef          	jal	900 <vprintf>
}
 bdc:	60e2                	ld	ra,24(sp)
 bde:	6442                	ld	s0,16(sp)
 be0:	6125                	add	sp,sp,96
 be2:	8082                	ret

0000000000000be4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 be4:	1141                	add	sp,sp,-16
 be6:	e422                	sd	s0,8(sp)
 be8:	0800                	add	s0,sp,16
  Header *bp, *p;

  if(ap == 0)
 bea:	cd3d                	beqz	a0,c68 <free+0x84>
    return;
  if((uint64)ap < 4096)
 bec:	6785                	lui	a5,0x1
 bee:	06f56d63          	bltu	a0,a5,c68 <free+0x84>
    return;
  bp = (Header*)ap - 1;
 bf2:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bf6:	00000797          	auipc	a5,0x0
 bfa:	4127b783          	ld	a5,1042(a5) # 1008 <freep>
 bfe:	a02d                	j	c28 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 c00:	4618                	lw	a4,8(a2)
 c02:	9f2d                	addw	a4,a4,a1
 c04:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 c08:	6398                	ld	a4,0(a5)
 c0a:	6310                	ld	a2,0(a4)
 c0c:	a83d                	j	c4a <free+0x66>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 c0e:	ff852703          	lw	a4,-8(a0)
 c12:	9f31                	addw	a4,a4,a2
 c14:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 c16:	ff053683          	ld	a3,-16(a0)
 c1a:	a091                	j	c5e <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c1c:	6398                	ld	a4,0(a5)
 c1e:	00e7e463          	bltu	a5,a4,c26 <free+0x42>
 c22:	00e6ea63          	bltu	a3,a4,c36 <free+0x52>
{
 c26:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c28:	fed7fae3          	bgeu	a5,a3,c1c <free+0x38>
 c2c:	6398                	ld	a4,0(a5)
 c2e:	00e6e463          	bltu	a3,a4,c36 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c32:	fee7eae3          	bltu	a5,a4,c26 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 c36:	ff852583          	lw	a1,-8(a0)
 c3a:	6390                	ld	a2,0(a5)
 c3c:	02059813          	sll	a6,a1,0x20
 c40:	01c85713          	srl	a4,a6,0x1c
 c44:	9736                	add	a4,a4,a3
 c46:	fae60de3          	beq	a2,a4,c00 <free+0x1c>
    bp->s.ptr = p->s.ptr->s.ptr;
 c4a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 c4e:	4790                	lw	a2,8(a5)
 c50:	02061593          	sll	a1,a2,0x20
 c54:	01c5d713          	srl	a4,a1,0x1c
 c58:	973e                	add	a4,a4,a5
 c5a:	fae68ae3          	beq	a3,a4,c0e <free+0x2a>
    p->s.ptr = bp->s.ptr;
 c5e:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 c60:	00000717          	auipc	a4,0x0
 c64:	3af73423          	sd	a5,936(a4) # 1008 <freep>
}
 c68:	6422                	ld	s0,8(sp)
 c6a:	0141                	add	sp,sp,16
 c6c:	8082                	ret

0000000000000c6e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 c6e:	7139                	add	sp,sp,-64
 c70:	fc06                	sd	ra,56(sp)
 c72:	f822                	sd	s0,48(sp)
 c74:	f426                	sd	s1,40(sp)
 c76:	ec4e                	sd	s3,24(sp)
 c78:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c7a:	02051493          	sll	s1,a0,0x20
 c7e:	9081                	srl	s1,s1,0x20
 c80:	04bd                	add	s1,s1,15
 c82:	8091                	srl	s1,s1,0x4
 c84:	0014899b          	addw	s3,s1,1
 c88:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 c8a:	00000517          	auipc	a0,0x0
 c8e:	37e53503          	ld	a0,894(a0) # 1008 <freep>
 c92:	c915                	beqz	a0,cc6 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c94:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c96:	4798                	lw	a4,8(a5)
 c98:	08977a63          	bgeu	a4,s1,d2c <malloc+0xbe>
 c9c:	f04a                	sd	s2,32(sp)
 c9e:	e852                	sd	s4,16(sp)
 ca0:	e456                	sd	s5,8(sp)
 ca2:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 ca4:	8a4e                	mv	s4,s3
 ca6:	0009871b          	sext.w	a4,s3
 caa:	6685                	lui	a3,0x1
 cac:	00d77363          	bgeu	a4,a3,cb2 <malloc+0x44>
 cb0:	6a05                	lui	s4,0x1
 cb2:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 cb6:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 cba:	00000917          	auipc	s2,0x0
 cbe:	34e90913          	add	s2,s2,846 # 1008 <freep>
  if(p == (char*)-1)
 cc2:	5afd                	li	s5,-1
 cc4:	a081                	j	d04 <malloc+0x96>
 cc6:	f04a                	sd	s2,32(sp)
 cc8:	e852                	sd	s4,16(sp)
 cca:	e456                	sd	s5,8(sp)
 ccc:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 cce:	00000797          	auipc	a5,0x0
 cd2:	74278793          	add	a5,a5,1858 # 1410 <base>
 cd6:	00000717          	auipc	a4,0x0
 cda:	32f73923          	sd	a5,818(a4) # 1008 <freep>
 cde:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 ce0:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 ce4:	b7c1                	j	ca4 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 ce6:	6398                	ld	a4,0(a5)
 ce8:	e118                	sd	a4,0(a0)
 cea:	a8a9                	j	d44 <malloc+0xd6>
  hp->s.size = nu;
 cec:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 cf0:	0541                	add	a0,a0,16
 cf2:	ef3ff0ef          	jal	be4 <free>
  return freep;
 cf6:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 cfa:	c12d                	beqz	a0,d5c <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 cfc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 cfe:	4798                	lw	a4,8(a5)
 d00:	02977263          	bgeu	a4,s1,d24 <malloc+0xb6>
    if(p == freep)
 d04:	00093703          	ld	a4,0(s2)
 d08:	853e                	mv	a0,a5
 d0a:	fef719e3          	bne	a4,a5,cfc <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 d0e:	8552                	mv	a0,s4
 d10:	ab9ff0ef          	jal	7c8 <sbrk>
  if(p == (char*)-1)
 d14:	fd551ce3          	bne	a0,s5,cec <malloc+0x7e>
        return 0;
 d18:	4501                	li	a0,0
 d1a:	7902                	ld	s2,32(sp)
 d1c:	6a42                	ld	s4,16(sp)
 d1e:	6aa2                	ld	s5,8(sp)
 d20:	6b02                	ld	s6,0(sp)
 d22:	a03d                	j	d50 <malloc+0xe2>
 d24:	7902                	ld	s2,32(sp)
 d26:	6a42                	ld	s4,16(sp)
 d28:	6aa2                	ld	s5,8(sp)
 d2a:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 d2c:	fae48de3          	beq	s1,a4,ce6 <malloc+0x78>
        p->s.size -= nunits;
 d30:	4137073b          	subw	a4,a4,s3
 d34:	c798                	sw	a4,8(a5)
        p += p->s.size;
 d36:	02071693          	sll	a3,a4,0x20
 d3a:	01c6d713          	srl	a4,a3,0x1c
 d3e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 d40:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 d44:	00000717          	auipc	a4,0x0
 d48:	2ca73223          	sd	a0,708(a4) # 1008 <freep>
      return (void*)(p + 1);
 d4c:	01078513          	add	a0,a5,16
  }
}
 d50:	70e2                	ld	ra,56(sp)
 d52:	7442                	ld	s0,48(sp)
 d54:	74a2                	ld	s1,40(sp)
 d56:	69e2                	ld	s3,24(sp)
 d58:	6121                	add	sp,sp,64
 d5a:	8082                	ret
 d5c:	7902                	ld	s2,32(sp)
 d5e:	6a42                	ld	s4,16(sp)
 d60:	6aa2                	ld	s5,8(sp)
 d62:	6b02                	ld	s6,0(sp)
 d64:	b7f5                	j	d50 <malloc+0xe2>
