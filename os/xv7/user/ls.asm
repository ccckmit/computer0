
user/_ls:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

char*
fmtname(char *path)
{
   0:	7179                	add	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	1800                	add	s0,sp,48
   a:	84aa                	mv	s1,a0
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
   c:	2b6000ef          	jal	2c2 <strlen>
  10:	02051793          	sll	a5,a0,0x20
  14:	9381                	srl	a5,a5,0x20
  16:	97a6                	add	a5,a5,s1
  18:	02f00693          	li	a3,47
  1c:	0097e963          	bltu	a5,s1,2e <fmtname+0x2e>
  20:	0007c703          	lbu	a4,0(a5)
  24:	00d70563          	beq	a4,a3,2e <fmtname+0x2e>
  28:	17fd                	add	a5,a5,-1
  2a:	fe97fbe3          	bgeu	a5,s1,20 <fmtname+0x20>
    ;
  p++;
  2e:	00178493          	add	s1,a5,1

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  32:	8526                	mv	a0,s1
  34:	28e000ef          	jal	2c2 <strlen>
  38:	2501                	sext.w	a0,a0
  3a:	47b5                	li	a5,13
  3c:	00a7f863          	bgeu	a5,a0,4c <fmtname+0x4c>
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}
  40:	8526                	mv	a0,s1
  42:	70a2                	ld	ra,40(sp)
  44:	7402                	ld	s0,32(sp)
  46:	64e2                	ld	s1,24(sp)
  48:	6145                	add	sp,sp,48
  4a:	8082                	ret
  4c:	e84a                	sd	s2,16(sp)
  4e:	e44e                	sd	s3,8(sp)
  memmove(buf, p, strlen(p));
  50:	8526                	mv	a0,s1
  52:	270000ef          	jal	2c2 <strlen>
  56:	00001997          	auipc	s3,0x1
  5a:	fba98993          	add	s3,s3,-70 # 1010 <buf.0>
  5e:	0005061b          	sext.w	a2,a0
  62:	85a6                	mv	a1,s1
  64:	854e                	mv	a0,s3
  66:	3be000ef          	jal	424 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  6a:	8526                	mv	a0,s1
  6c:	256000ef          	jal	2c2 <strlen>
  70:	0005091b          	sext.w	s2,a0
  74:	8526                	mv	a0,s1
  76:	24c000ef          	jal	2c2 <strlen>
  7a:	1902                	sll	s2,s2,0x20
  7c:	02095913          	srl	s2,s2,0x20
  80:	4639                	li	a2,14
  82:	9e09                	subw	a2,a2,a0
  84:	02000593          	li	a1,32
  88:	01298533          	add	a0,s3,s2
  8c:	260000ef          	jal	2ec <memset>
  return buf;
  90:	84ce                	mv	s1,s3
  92:	6942                	ld	s2,16(sp)
  94:	69a2                	ld	s3,8(sp)
  96:	b76d                	j	40 <fmtname+0x40>

0000000000000098 <ls>:

void
ls(char *path)
{
  98:	d9010113          	add	sp,sp,-624
  9c:	26113423          	sd	ra,616(sp)
  a0:	26813023          	sd	s0,608(sp)
  a4:	25213823          	sd	s2,592(sp)
  a8:	1c80                	add	s0,sp,624
  aa:	892a                	mv	s2,a0
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, O_RDONLY)) < 0){
  ac:	4581                	li	a1,0
  ae:	6e0000ef          	jal	78e <open>
  b2:	06054363          	bltz	a0,118 <ls+0x80>
  b6:	24913c23          	sd	s1,600(sp)
  ba:	84aa                	mv	s1,a0
    fprintf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  bc:	d9840593          	add	a1,s0,-616
  c0:	6e6000ef          	jal	7a6 <fstat>
  c4:	06054363          	bltz	a0,12a <ls+0x92>
    fprintf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
  c8:	da041783          	lh	a5,-608(s0)
  cc:	4705                	li	a4,1
  ce:	06e78c63          	beq	a5,a4,146 <ls+0xae>
  d2:	37f9                	addw	a5,a5,-2
  d4:	17c2                	sll	a5,a5,0x30
  d6:	93c1                	srl	a5,a5,0x30
  d8:	02f76263          	bltu	a4,a5,fc <ls+0x64>
  case T_DEVICE:
  case T_FILE:
    printf("%s %d %d %d\n", fmtname(path), st.type, st.ino, (int) st.size);
  dc:	854a                	mv	a0,s2
  de:	f23ff0ef          	jal	0 <fmtname>
  e2:	85aa                	mv	a1,a0
  e4:	da842703          	lw	a4,-600(s0)
  e8:	d9c42683          	lw	a3,-612(s0)
  ec:	da041603          	lh	a2,-608(s0)
  f0:	00001517          	auipc	a0,0x1
  f4:	cc050513          	add	a0,a0,-832 # db0 <malloc+0x134>
  f8:	2c9000ef          	jal	bc0 <printf>
      }
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, (int) st.size);
    }
    break;
  }
  close(fd);
  fc:	8526                	mv	a0,s1
  fe:	678000ef          	jal	776 <close>
 102:	25813483          	ld	s1,600(sp)
}
 106:	26813083          	ld	ra,616(sp)
 10a:	26013403          	ld	s0,608(sp)
 10e:	25013903          	ld	s2,592(sp)
 112:	27010113          	add	sp,sp,624
 116:	8082                	ret
    fprintf(2, "ls: cannot open %s\n", path);
 118:	864a                	mv	a2,s2
 11a:	00001597          	auipc	a1,0x1
 11e:	c6658593          	add	a1,a1,-922 # d80 <malloc+0x104>
 122:	4509                	li	a0,2
 124:	273000ef          	jal	b96 <fprintf>
    return;
 128:	bff9                	j	106 <ls+0x6e>
    fprintf(2, "ls: cannot stat %s\n", path);
 12a:	864a                	mv	a2,s2
 12c:	00001597          	auipc	a1,0x1
 130:	c6c58593          	add	a1,a1,-916 # d98 <malloc+0x11c>
 134:	4509                	li	a0,2
 136:	261000ef          	jal	b96 <fprintf>
    close(fd);
 13a:	8526                	mv	a0,s1
 13c:	63a000ef          	jal	776 <close>
    return;
 140:	25813483          	ld	s1,600(sp)
 144:	b7c9                	j	106 <ls+0x6e>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 146:	854a                	mv	a0,s2
 148:	17a000ef          	jal	2c2 <strlen>
 14c:	2541                	addw	a0,a0,16
 14e:	20000793          	li	a5,512
 152:	00a7f963          	bgeu	a5,a0,164 <ls+0xcc>
      printf("ls: path too long\n");
 156:	00001517          	auipc	a0,0x1
 15a:	c6a50513          	add	a0,a0,-918 # dc0 <malloc+0x144>
 15e:	263000ef          	jal	bc0 <printf>
      break;
 162:	bf69                	j	fc <ls+0x64>
 164:	25313423          	sd	s3,584(sp)
 168:	25413023          	sd	s4,576(sp)
 16c:	23513c23          	sd	s5,568(sp)
    strcpy(buf, path);
 170:	85ca                	mv	a1,s2
 172:	dc040513          	add	a0,s0,-576
 176:	104000ef          	jal	27a <strcpy>
    p = buf+strlen(buf);
 17a:	dc040513          	add	a0,s0,-576
 17e:	144000ef          	jal	2c2 <strlen>
 182:	1502                	sll	a0,a0,0x20
 184:	9101                	srl	a0,a0,0x20
 186:	dc040793          	add	a5,s0,-576
 18a:	00a78933          	add	s2,a5,a0
    *p++ = '/';
 18e:	00190993          	add	s3,s2,1
 192:	02f00793          	li	a5,47
 196:	00f90023          	sb	a5,0(s2)
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, (int) st.size);
 19a:	00001a17          	auipc	s4,0x1
 19e:	c16a0a13          	add	s4,s4,-1002 # db0 <malloc+0x134>
        printf("ls: cannot stat %s\n", buf);
 1a2:	00001a97          	auipc	s5,0x1
 1a6:	bf6a8a93          	add	s5,s5,-1034 # d98 <malloc+0x11c>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1aa:	a031                	j	1b6 <ls+0x11e>
        printf("ls: cannot stat %s\n", buf);
 1ac:	dc040593          	add	a1,s0,-576
 1b0:	8556                	mv	a0,s5
 1b2:	20f000ef          	jal	bc0 <printf>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1b6:	4641                	li	a2,16
 1b8:	db040593          	add	a1,s0,-592
 1bc:	8526                	mv	a0,s1
 1be:	5a8000ef          	jal	766 <read>
 1c2:	47c1                	li	a5,16
 1c4:	04f51463          	bne	a0,a5,20c <ls+0x174>
      if(de.inum == 0)
 1c8:	db045783          	lhu	a5,-592(s0)
 1cc:	d7ed                	beqz	a5,1b6 <ls+0x11e>
      memmove(p, de.name, DIRSIZ);
 1ce:	4639                	li	a2,14
 1d0:	db240593          	add	a1,s0,-590
 1d4:	854e                	mv	a0,s3
 1d6:	24e000ef          	jal	424 <memmove>
      p[DIRSIZ] = 0;
 1da:	000907a3          	sb	zero,15(s2)
      if(stat(buf, &st) < 0){
 1de:	d9840593          	add	a1,s0,-616
 1e2:	dc040513          	add	a0,s0,-576
 1e6:	1bc000ef          	jal	3a2 <stat>
 1ea:	fc0541e3          	bltz	a0,1ac <ls+0x114>
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, (int) st.size);
 1ee:	dc040513          	add	a0,s0,-576
 1f2:	e0fff0ef          	jal	0 <fmtname>
 1f6:	85aa                	mv	a1,a0
 1f8:	da842703          	lw	a4,-600(s0)
 1fc:	d9c42683          	lw	a3,-612(s0)
 200:	da041603          	lh	a2,-608(s0)
 204:	8552                	mv	a0,s4
 206:	1bb000ef          	jal	bc0 <printf>
 20a:	b775                	j	1b6 <ls+0x11e>
 20c:	24813983          	ld	s3,584(sp)
 210:	24013a03          	ld	s4,576(sp)
 214:	23813a83          	ld	s5,568(sp)
 218:	b5d5                	j	fc <ls+0x64>

000000000000021a <main>:

int
main(int argc, char *argv[])
{
 21a:	1101                	add	sp,sp,-32
 21c:	ec06                	sd	ra,24(sp)
 21e:	e822                	sd	s0,16(sp)
 220:	1000                	add	s0,sp,32
  int i;

  if(argc < 2){
 222:	4785                	li	a5,1
 224:	02a7d763          	bge	a5,a0,252 <main+0x38>
 228:	e426                	sd	s1,8(sp)
 22a:	e04a                	sd	s2,0(sp)
 22c:	00858493          	add	s1,a1,8
 230:	ffe5091b          	addw	s2,a0,-2
 234:	02091793          	sll	a5,s2,0x20
 238:	01d7d913          	srl	s2,a5,0x1d
 23c:	05c1                	add	a1,a1,16
 23e:	992e                	add	s2,s2,a1
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
 240:	6088                	ld	a0,0(s1)
 242:	e57ff0ef          	jal	98 <ls>
  for(i=1; i<argc; i++)
 246:	04a1                	add	s1,s1,8
 248:	ff249ce3          	bne	s1,s2,240 <main+0x26>
  exit(0);
 24c:	4501                	li	a0,0
 24e:	500000ef          	jal	74e <exit>
 252:	e426                	sd	s1,8(sp)
 254:	e04a                	sd	s2,0(sp)
    ls(".");
 256:	00001517          	auipc	a0,0x1
 25a:	b8250513          	add	a0,a0,-1150 # dd8 <malloc+0x15c>
 25e:	e3bff0ef          	jal	98 <ls>
    exit(0);
 262:	4501                	li	a0,0
 264:	4ea000ef          	jal	74e <exit>

0000000000000268 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 268:	1141                	add	sp,sp,-16
 26a:	e406                	sd	ra,8(sp)
 26c:	e022                	sd	s0,0(sp)
 26e:	0800                	add	s0,sp,16
  extern int main();
  main();
 270:	fabff0ef          	jal	21a <main>
  exit(0);
 274:	4501                	li	a0,0
 276:	4d8000ef          	jal	74e <exit>

000000000000027a <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 27a:	1141                	add	sp,sp,-16
 27c:	e422                	sd	s0,8(sp)
 27e:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 280:	87aa                	mv	a5,a0
 282:	0585                	add	a1,a1,1
 284:	0785                	add	a5,a5,1
 286:	fff5c703          	lbu	a4,-1(a1)
 28a:	fee78fa3          	sb	a4,-1(a5)
 28e:	fb75                	bnez	a4,282 <strcpy+0x8>
    ;
  return os;
}
 290:	6422                	ld	s0,8(sp)
 292:	0141                	add	sp,sp,16
 294:	8082                	ret

0000000000000296 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 296:	1141                	add	sp,sp,-16
 298:	e422                	sd	s0,8(sp)
 29a:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 29c:	00054783          	lbu	a5,0(a0)
 2a0:	cb91                	beqz	a5,2b4 <strcmp+0x1e>
 2a2:	0005c703          	lbu	a4,0(a1)
 2a6:	00f71763          	bne	a4,a5,2b4 <strcmp+0x1e>
    p++, q++;
 2aa:	0505                	add	a0,a0,1
 2ac:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 2ae:	00054783          	lbu	a5,0(a0)
 2b2:	fbe5                	bnez	a5,2a2 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 2b4:	0005c503          	lbu	a0,0(a1)
}
 2b8:	40a7853b          	subw	a0,a5,a0
 2bc:	6422                	ld	s0,8(sp)
 2be:	0141                	add	sp,sp,16
 2c0:	8082                	ret

00000000000002c2 <strlen>:

uint
strlen(const char *s)
{
 2c2:	1141                	add	sp,sp,-16
 2c4:	e422                	sd	s0,8(sp)
 2c6:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2c8:	00054783          	lbu	a5,0(a0)
 2cc:	cf91                	beqz	a5,2e8 <strlen+0x26>
 2ce:	0505                	add	a0,a0,1
 2d0:	87aa                	mv	a5,a0
 2d2:	86be                	mv	a3,a5
 2d4:	0785                	add	a5,a5,1
 2d6:	fff7c703          	lbu	a4,-1(a5)
 2da:	ff65                	bnez	a4,2d2 <strlen+0x10>
 2dc:	40a6853b          	subw	a0,a3,a0
 2e0:	2505                	addw	a0,a0,1
    ;
  return n;
}
 2e2:	6422                	ld	s0,8(sp)
 2e4:	0141                	add	sp,sp,16
 2e6:	8082                	ret
  for(n = 0; s[n]; n++)
 2e8:	4501                	li	a0,0
 2ea:	bfe5                	j	2e2 <strlen+0x20>

00000000000002ec <memset>:

void*
memset(void *dst, int c, uint n)
{
 2ec:	1141                	add	sp,sp,-16
 2ee:	e422                	sd	s0,8(sp)
 2f0:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2f2:	ca19                	beqz	a2,308 <memset+0x1c>
 2f4:	87aa                	mv	a5,a0
 2f6:	1602                	sll	a2,a2,0x20
 2f8:	9201                	srl	a2,a2,0x20
 2fa:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 2fe:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 302:	0785                	add	a5,a5,1
 304:	fee79de3          	bne	a5,a4,2fe <memset+0x12>
  }
  return dst;
}
 308:	6422                	ld	s0,8(sp)
 30a:	0141                	add	sp,sp,16
 30c:	8082                	ret

000000000000030e <strchr>:

char*
strchr(const char *s, char c)
{
 30e:	1141                	add	sp,sp,-16
 310:	e422                	sd	s0,8(sp)
 312:	0800                	add	s0,sp,16
  for(; *s; s++)
 314:	00054783          	lbu	a5,0(a0)
 318:	cb99                	beqz	a5,32e <strchr+0x20>
    if(*s == c)
 31a:	00f58763          	beq	a1,a5,328 <strchr+0x1a>
  for(; *s; s++)
 31e:	0505                	add	a0,a0,1
 320:	00054783          	lbu	a5,0(a0)
 324:	fbfd                	bnez	a5,31a <strchr+0xc>
      return (char*)s;
  return 0;
 326:	4501                	li	a0,0
}
 328:	6422                	ld	s0,8(sp)
 32a:	0141                	add	sp,sp,16
 32c:	8082                	ret
  return 0;
 32e:	4501                	li	a0,0
 330:	bfe5                	j	328 <strchr+0x1a>

0000000000000332 <gets>:

char*
gets(char *buf, int max)
{
 332:	711d                	add	sp,sp,-96
 334:	ec86                	sd	ra,88(sp)
 336:	e8a2                	sd	s0,80(sp)
 338:	e4a6                	sd	s1,72(sp)
 33a:	e0ca                	sd	s2,64(sp)
 33c:	fc4e                	sd	s3,56(sp)
 33e:	f852                	sd	s4,48(sp)
 340:	f456                	sd	s5,40(sp)
 342:	f05a                	sd	s6,32(sp)
 344:	ec5e                	sd	s7,24(sp)
 346:	1080                	add	s0,sp,96
 348:	8baa                	mv	s7,a0
 34a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 34c:	892a                	mv	s2,a0
 34e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 350:	4aa9                	li	s5,10
 352:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 354:	89a6                	mv	s3,s1
 356:	2485                	addw	s1,s1,1
 358:	0344d663          	bge	s1,s4,384 <gets+0x52>
    cc = read(0, &c, 1);
 35c:	4605                	li	a2,1
 35e:	faf40593          	add	a1,s0,-81
 362:	4501                	li	a0,0
 364:	402000ef          	jal	766 <read>
    if(cc < 1)
 368:	00a05e63          	blez	a0,384 <gets+0x52>
    buf[i++] = c;
 36c:	faf44783          	lbu	a5,-81(s0)
 370:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 374:	01578763          	beq	a5,s5,382 <gets+0x50>
 378:	0905                	add	s2,s2,1
 37a:	fd679de3          	bne	a5,s6,354 <gets+0x22>
    buf[i++] = c;
 37e:	89a6                	mv	s3,s1
 380:	a011                	j	384 <gets+0x52>
 382:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 384:	99de                	add	s3,s3,s7
 386:	00098023          	sb	zero,0(s3)
  return buf;
}
 38a:	855e                	mv	a0,s7
 38c:	60e6                	ld	ra,88(sp)
 38e:	6446                	ld	s0,80(sp)
 390:	64a6                	ld	s1,72(sp)
 392:	6906                	ld	s2,64(sp)
 394:	79e2                	ld	s3,56(sp)
 396:	7a42                	ld	s4,48(sp)
 398:	7aa2                	ld	s5,40(sp)
 39a:	7b02                	ld	s6,32(sp)
 39c:	6be2                	ld	s7,24(sp)
 39e:	6125                	add	sp,sp,96
 3a0:	8082                	ret

00000000000003a2 <stat>:

int
stat(const char *n, struct stat *st)
{
 3a2:	1101                	add	sp,sp,-32
 3a4:	ec06                	sd	ra,24(sp)
 3a6:	e822                	sd	s0,16(sp)
 3a8:	e04a                	sd	s2,0(sp)
 3aa:	1000                	add	s0,sp,32
 3ac:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3ae:	4581                	li	a1,0
 3b0:	3de000ef          	jal	78e <open>
  if(fd < 0)
 3b4:	02054263          	bltz	a0,3d8 <stat+0x36>
 3b8:	e426                	sd	s1,8(sp)
 3ba:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3bc:	85ca                	mv	a1,s2
 3be:	3e8000ef          	jal	7a6 <fstat>
 3c2:	892a                	mv	s2,a0
  close(fd);
 3c4:	8526                	mv	a0,s1
 3c6:	3b0000ef          	jal	776 <close>
  return r;
 3ca:	64a2                	ld	s1,8(sp)
}
 3cc:	854a                	mv	a0,s2
 3ce:	60e2                	ld	ra,24(sp)
 3d0:	6442                	ld	s0,16(sp)
 3d2:	6902                	ld	s2,0(sp)
 3d4:	6105                	add	sp,sp,32
 3d6:	8082                	ret
    return -1;
 3d8:	597d                	li	s2,-1
 3da:	bfcd                	j	3cc <stat+0x2a>

00000000000003dc <atoi>:

int
atoi(const char *s)
{
 3dc:	1141                	add	sp,sp,-16
 3de:	e422                	sd	s0,8(sp)
 3e0:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3e2:	00054683          	lbu	a3,0(a0)
 3e6:	fd06879b          	addw	a5,a3,-48
 3ea:	0ff7f793          	zext.b	a5,a5
 3ee:	4625                	li	a2,9
 3f0:	02f66863          	bltu	a2,a5,420 <atoi+0x44>
 3f4:	872a                	mv	a4,a0
  n = 0;
 3f6:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 3f8:	0705                	add	a4,a4,1
 3fa:	0025179b          	sllw	a5,a0,0x2
 3fe:	9fa9                	addw	a5,a5,a0
 400:	0017979b          	sllw	a5,a5,0x1
 404:	9fb5                	addw	a5,a5,a3
 406:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 40a:	00074683          	lbu	a3,0(a4)
 40e:	fd06879b          	addw	a5,a3,-48
 412:	0ff7f793          	zext.b	a5,a5
 416:	fef671e3          	bgeu	a2,a5,3f8 <atoi+0x1c>
  return n;
}
 41a:	6422                	ld	s0,8(sp)
 41c:	0141                	add	sp,sp,16
 41e:	8082                	ret
  n = 0;
 420:	4501                	li	a0,0
 422:	bfe5                	j	41a <atoi+0x3e>

0000000000000424 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 424:	1141                	add	sp,sp,-16
 426:	e422                	sd	s0,8(sp)
 428:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 42a:	02b57463          	bgeu	a0,a1,452 <memmove+0x2e>
    while(n-- > 0)
 42e:	00c05f63          	blez	a2,44c <memmove+0x28>
 432:	1602                	sll	a2,a2,0x20
 434:	9201                	srl	a2,a2,0x20
 436:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 43a:	872a                	mv	a4,a0
      *dst++ = *src++;
 43c:	0585                	add	a1,a1,1
 43e:	0705                	add	a4,a4,1
 440:	fff5c683          	lbu	a3,-1(a1)
 444:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 448:	fef71ae3          	bne	a4,a5,43c <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 44c:	6422                	ld	s0,8(sp)
 44e:	0141                	add	sp,sp,16
 450:	8082                	ret
    dst += n;
 452:	00c50733          	add	a4,a0,a2
    src += n;
 456:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 458:	fec05ae3          	blez	a2,44c <memmove+0x28>
 45c:	fff6079b          	addw	a5,a2,-1
 460:	1782                	sll	a5,a5,0x20
 462:	9381                	srl	a5,a5,0x20
 464:	fff7c793          	not	a5,a5
 468:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 46a:	15fd                	add	a1,a1,-1
 46c:	177d                	add	a4,a4,-1
 46e:	0005c683          	lbu	a3,0(a1)
 472:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 476:	fee79ae3          	bne	a5,a4,46a <memmove+0x46>
 47a:	bfc9                	j	44c <memmove+0x28>

000000000000047c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 47c:	1141                	add	sp,sp,-16
 47e:	e422                	sd	s0,8(sp)
 480:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 482:	ca05                	beqz	a2,4b2 <memcmp+0x36>
 484:	fff6069b          	addw	a3,a2,-1
 488:	1682                	sll	a3,a3,0x20
 48a:	9281                	srl	a3,a3,0x20
 48c:	0685                	add	a3,a3,1
 48e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 490:	00054783          	lbu	a5,0(a0)
 494:	0005c703          	lbu	a4,0(a1)
 498:	00e79863          	bne	a5,a4,4a8 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 49c:	0505                	add	a0,a0,1
    p2++;
 49e:	0585                	add	a1,a1,1
  while (n-- > 0) {
 4a0:	fed518e3          	bne	a0,a3,490 <memcmp+0x14>
  }
  return 0;
 4a4:	4501                	li	a0,0
 4a6:	a019                	j	4ac <memcmp+0x30>
      return *p1 - *p2;
 4a8:	40e7853b          	subw	a0,a5,a4
}
 4ac:	6422                	ld	s0,8(sp)
 4ae:	0141                	add	sp,sp,16
 4b0:	8082                	ret
  return 0;
 4b2:	4501                	li	a0,0
 4b4:	bfe5                	j	4ac <memcmp+0x30>

00000000000004b6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4b6:	1141                	add	sp,sp,-16
 4b8:	e406                	sd	ra,8(sp)
 4ba:	e022                	sd	s0,0(sp)
 4bc:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 4be:	f67ff0ef          	jal	424 <memmove>
}
 4c2:	60a2                	ld	ra,8(sp)
 4c4:	6402                	ld	s0,0(sp)
 4c6:	0141                	add	sp,sp,16
 4c8:	8082                	ret

00000000000004ca <htons>:
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
}

uint16_t
htons(uint16_t h)
{
 4ca:	1141                	add	sp,sp,-16
 4cc:	e422                	sd	s0,8(sp)
 4ce:	0800                	add	s0,sp,16
    if (!endian) {
 4d0:	00001797          	auipc	a5,0x1
 4d4:	b307a783          	lw	a5,-1232(a5) # 1000 <endian>
 4d8:	e385                	bnez	a5,4f8 <htons+0x2e>
        endian = byteorder();
 4da:	4d200793          	li	a5,1234
 4de:	00001717          	auipc	a4,0x1
 4e2:	b2f72123          	sw	a5,-1246(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 4e6:	0085179b          	sllw	a5,a0,0x8
 4ea:	0085551b          	srlw	a0,a0,0x8
 4ee:	8fc9                	or	a5,a5,a0
 4f0:	03079513          	sll	a0,a5,0x30
 4f4:	9141                	srl	a0,a0,0x30
 4f6:	a029                	j	500 <htons+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(h) : h;
 4f8:	4d200713          	li	a4,1234
 4fc:	fee785e3          	beq	a5,a4,4e6 <htons+0x1c>
}
 500:	6422                	ld	s0,8(sp)
 502:	0141                	add	sp,sp,16
 504:	8082                	ret

0000000000000506 <ntohs>:

uint16_t
ntohs(uint16_t n)
{
 506:	1141                	add	sp,sp,-16
 508:	e422                	sd	s0,8(sp)
 50a:	0800                	add	s0,sp,16
    if (!endian) {
 50c:	00001797          	auipc	a5,0x1
 510:	af47a783          	lw	a5,-1292(a5) # 1000 <endian>
 514:	e385                	bnez	a5,534 <ntohs+0x2e>
        endian = byteorder();
 516:	4d200793          	li	a5,1234
 51a:	00001717          	auipc	a4,0x1
 51e:	aef72323          	sw	a5,-1306(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 522:	0085179b          	sllw	a5,a0,0x8
 526:	0085551b          	srlw	a0,a0,0x8
 52a:	8fc9                	or	a5,a5,a0
 52c:	03079513          	sll	a0,a5,0x30
 530:	9141                	srl	a0,a0,0x30
 532:	a029                	j	53c <ntohs+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(n) : n;
 534:	4d200713          	li	a4,1234
 538:	fee785e3          	beq	a5,a4,522 <ntohs+0x1c>
}
 53c:	6422                	ld	s0,8(sp)
 53e:	0141                	add	sp,sp,16
 540:	8082                	ret

0000000000000542 <htonl>:

uint32_t
htonl(uint32_t h)
{
 542:	1141                	add	sp,sp,-16
 544:	e422                	sd	s0,8(sp)
 546:	0800                	add	s0,sp,16
    if (!endian) {
 548:	00001797          	auipc	a5,0x1
 54c:	ab87a783          	lw	a5,-1352(a5) # 1000 <endian>
 550:	ef85                	bnez	a5,588 <htonl+0x46>
        endian = byteorder();
 552:	4d200793          	li	a5,1234
 556:	00001717          	auipc	a4,0x1
 55a:	aaf72523          	sw	a5,-1366(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 55e:	0185179b          	sllw	a5,a0,0x18
 562:	0185571b          	srlw	a4,a0,0x18
 566:	8fd9                	or	a5,a5,a4
 568:	0085171b          	sllw	a4,a0,0x8
 56c:	00ff06b7          	lui	a3,0xff0
 570:	8f75                	and	a4,a4,a3
 572:	8fd9                	or	a5,a5,a4
 574:	0085551b          	srlw	a0,a0,0x8
 578:	6741                	lui	a4,0x10
 57a:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeee0>
 57e:	8d79                	and	a0,a0,a4
 580:	8fc9                	or	a5,a5,a0
 582:	0007851b          	sext.w	a0,a5
 586:	a029                	j	590 <htonl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(h) : h;
 588:	4d200713          	li	a4,1234
 58c:	fce789e3          	beq	a5,a4,55e <htonl+0x1c>
}
 590:	6422                	ld	s0,8(sp)
 592:	0141                	add	sp,sp,16
 594:	8082                	ret

0000000000000596 <ntohl>:

uint32_t
ntohl(uint32_t n)
{
 596:	1141                	add	sp,sp,-16
 598:	e422                	sd	s0,8(sp)
 59a:	0800                	add	s0,sp,16
    if (!endian) {
 59c:	00001797          	auipc	a5,0x1
 5a0:	a647a783          	lw	a5,-1436(a5) # 1000 <endian>
 5a4:	ef85                	bnez	a5,5dc <ntohl+0x46>
        endian = byteorder();
 5a6:	4d200793          	li	a5,1234
 5aa:	00001717          	auipc	a4,0x1
 5ae:	a4f72b23          	sw	a5,-1450(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 5b2:	0185179b          	sllw	a5,a0,0x18
 5b6:	0185571b          	srlw	a4,a0,0x18
 5ba:	8fd9                	or	a5,a5,a4
 5bc:	0085171b          	sllw	a4,a0,0x8
 5c0:	00ff06b7          	lui	a3,0xff0
 5c4:	8f75                	and	a4,a4,a3
 5c6:	8fd9                	or	a5,a5,a4
 5c8:	0085551b          	srlw	a0,a0,0x8
 5cc:	6741                	lui	a4,0x10
 5ce:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeee0>
 5d2:	8d79                	and	a0,a0,a4
 5d4:	8fc9                	or	a5,a5,a0
 5d6:	0007851b          	sext.w	a0,a5
 5da:	a029                	j	5e4 <ntohl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(n) : n;
 5dc:	4d200713          	li	a4,1234
 5e0:	fce789e3          	beq	a5,a4,5b2 <ntohl+0x1c>
}
 5e4:	6422                	ld	s0,8(sp)
 5e6:	0141                	add	sp,sp,16
 5e8:	8082                	ret

00000000000005ea <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
 5ea:	1141                	add	sp,sp,-16
 5ec:	e422                	sd	s0,8(sp)
 5ee:	0800                	add	s0,sp,16
 5f0:	872a                	mv	a4,a0
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
 5f2:	02000693          	li	a3,32
 5f6:	4525                	li	a0,9
 5f8:	a011                	j	5fc <strtol+0x12>
        s++;
 5fa:	0705                	add	a4,a4,1
    while (*s == ' ' || *s == '\t')
 5fc:	00074783          	lbu	a5,0(a4)
 600:	fed78de3          	beq	a5,a3,5fa <strtol+0x10>
 604:	fea78be3          	beq	a5,a0,5fa <strtol+0x10>

    // plus/minus sign
    if (*s == '+')
 608:	02b00693          	li	a3,43
 60c:	02d78663          	beq	a5,a3,638 <strtol+0x4e>
        s++;
    else if (*s == '-')
 610:	02d00693          	li	a3,45
    int neg = 0;
 614:	4301                	li	t1,0
    else if (*s == '-')
 616:	02d78463          	beq	a5,a3,63e <strtol+0x54>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 61a:	fef67793          	and	a5,a2,-17
 61e:	eb89                	bnez	a5,630 <strtol+0x46>
 620:	00074683          	lbu	a3,0(a4)
 624:	03000793          	li	a5,48
 628:	00f68e63          	beq	a3,a5,644 <strtol+0x5a>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
 62c:	e211                	bnez	a2,630 <strtol+0x46>
        s++, base = 8;
    else if (base == 0)
        base = 10;
 62e:	4629                	li	a2,10
 630:	4501                	li	a0,0

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
 632:	4825                	li	a6,9
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
 634:	48e5                	li	a7,25
 636:	a825                	j	66e <strtol+0x84>
        s++;
 638:	0705                	add	a4,a4,1
    int neg = 0;
 63a:	4301                	li	t1,0
 63c:	bff9                	j	61a <strtol+0x30>
        s++, neg = 1;
 63e:	0705                	add	a4,a4,1
 640:	4305                	li	t1,1
 642:	bfe1                	j	61a <strtol+0x30>
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 644:	00174683          	lbu	a3,1(a4)
 648:	07800793          	li	a5,120
 64c:	00f68663          	beq	a3,a5,658 <strtol+0x6e>
    else if (base == 0 && s[0] == '0')
 650:	f265                	bnez	a2,630 <strtol+0x46>
        s++, base = 8;
 652:	0705                	add	a4,a4,1
 654:	4621                	li	a2,8
 656:	bfe9                	j	630 <strtol+0x46>
        s += 2, base = 16;
 658:	0709                	add	a4,a4,2
 65a:	4641                	li	a2,16
 65c:	bfd1                	j	630 <strtol+0x46>
            dig = *s - '0';
 65e:	fd07879b          	addw	a5,a5,-48
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
 662:	04c7d063          	bge	a5,a2,6a2 <strtol+0xb8>
            break;
        s++, val = (val * base) + dig;
 666:	0705                	add	a4,a4,1
 668:	02a60533          	mul	a0,a2,a0
 66c:	953e                	add	a0,a0,a5
        if (*s >= '0' && *s <= '9')
 66e:	00074783          	lbu	a5,0(a4)
 672:	fd07869b          	addw	a3,a5,-48
 676:	0ff6f693          	zext.b	a3,a3
 67a:	fed872e3          	bgeu	a6,a3,65e <strtol+0x74>
        else if (*s >= 'a' && *s <= 'z')
 67e:	f9f7869b          	addw	a3,a5,-97
 682:	0ff6f693          	zext.b	a3,a3
 686:	00d8e563          	bltu	a7,a3,690 <strtol+0xa6>
            dig = *s - 'a' + 10;
 68a:	fa97879b          	addw	a5,a5,-87
 68e:	bfd1                	j	662 <strtol+0x78>
        else if (*s >= 'A' && *s <= 'Z')
 690:	fbf7869b          	addw	a3,a5,-65
 694:	0ff6f693          	zext.b	a3,a3
 698:	00d8e563          	bltu	a7,a3,6a2 <strtol+0xb8>
            dig = *s - 'A' + 10;
 69c:	fc97879b          	addw	a5,a5,-55
 6a0:	b7c9                	j	662 <strtol+0x78>
        // we don't properly detect overflow!
    }

    if (endptr)
 6a2:	c191                	beqz	a1,6a6 <strtol+0xbc>
        *endptr = (char *) s;
 6a4:	e198                	sd	a4,0(a1)
    return (neg ? -val : val);
 6a6:	00030463          	beqz	t1,6ae <strtol+0xc4>
 6aa:	40a00533          	neg	a0,a0
}
 6ae:	6422                	ld	s0,8(sp)
 6b0:	0141                	add	sp,sp,16
 6b2:	8082                	ret

00000000000006b4 <inet_pton>:
inet_pton (int family, const char *p, void *n) {
    char *sp, *ep;
    int idx;
    long ret;

    if (family != AF_INET) {
 6b4:	4785                	li	a5,1
 6b6:	08f51063          	bne	a0,a5,736 <inet_pton+0x82>
inet_pton (int family, const char *p, void *n) {
 6ba:	715d                	add	sp,sp,-80
 6bc:	e486                	sd	ra,72(sp)
 6be:	e0a2                	sd	s0,64(sp)
 6c0:	fc26                	sd	s1,56(sp)
 6c2:	f84a                	sd	s2,48(sp)
 6c4:	f44e                	sd	s3,40(sp)
 6c6:	f052                	sd	s4,32(sp)
 6c8:	ec56                	sd	s5,24(sp)
 6ca:	e85a                	sd	s6,16(sp)
 6cc:	0880                	add	s0,sp,80
 6ce:	84ae                	mv	s1,a1
 6d0:	89b2                	mv	s3,a2
 6d2:	4901                	li	s2,0
        return -1;
    }
    sp = (char *)p;
    for (idx = 0; idx < 4; idx++) {
        ret = strtol(sp, &ep, 10);
        if (ret < 0 || ret > 255) {
 6d4:	0ff00a13          	li	s4,255
            return -1;
        }
        if (ep == sp) {
            return -1;
        }
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 6d8:	4a8d                	li	s5,3
 6da:	02e00b13          	li	s6,46
 6de:	a805                	j	70e <inet_pton+0x5a>
 6e0:	0007c783          	lbu	a5,0(a5)
 6e4:	efb9                	bnez	a5,742 <inet_pton+0x8e>
            return -1;
        }
        ((uint8_t *)n)[idx] = ret;
 6e6:	00a981a3          	sb	a0,3(s3)
        sp = ep + 1;
    }
    return 0;
 6ea:	4501                	li	a0,0
}
 6ec:	60a6                	ld	ra,72(sp)
 6ee:	6406                	ld	s0,64(sp)
 6f0:	74e2                	ld	s1,56(sp)
 6f2:	7942                	ld	s2,48(sp)
 6f4:	79a2                	ld	s3,40(sp)
 6f6:	7a02                	ld	s4,32(sp)
 6f8:	6ae2                	ld	s5,24(sp)
 6fa:	6b42                	ld	s6,16(sp)
 6fc:	6161                	add	sp,sp,80
 6fe:	8082                	ret
        ((uint8_t *)n)[idx] = ret;
 700:	01298733          	add	a4,s3,s2
 704:	00a70023          	sb	a0,0(a4)
        sp = ep + 1;
 708:	00178493          	add	s1,a5,1
    for (idx = 0; idx < 4; idx++) {
 70c:	0905                	add	s2,s2,1
        ret = strtol(sp, &ep, 10);
 70e:	4629                	li	a2,10
 710:	fb840593          	add	a1,s0,-72
 714:	8526                	mv	a0,s1
 716:	ed5ff0ef          	jal	5ea <strtol>
        if (ret < 0 || ret > 255) {
 71a:	02aa6063          	bltu	s4,a0,73a <inet_pton+0x86>
        if (ep == sp) {
 71e:	fb843783          	ld	a5,-72(s0)
 722:	00978e63          	beq	a5,s1,73e <inet_pton+0x8a>
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 726:	fb590de3          	beq	s2,s5,6e0 <inet_pton+0x2c>
 72a:	0007c703          	lbu	a4,0(a5)
 72e:	fd6709e3          	beq	a4,s6,700 <inet_pton+0x4c>
            return -1;
 732:	557d                	li	a0,-1
 734:	bf65                	j	6ec <inet_pton+0x38>
        return -1;
 736:	557d                	li	a0,-1
}
 738:	8082                	ret
            return -1;
 73a:	557d                	li	a0,-1
 73c:	bf45                	j	6ec <inet_pton+0x38>
            return -1;
 73e:	557d                	li	a0,-1
 740:	b775                	j	6ec <inet_pton+0x38>
            return -1;
 742:	557d                	li	a0,-1
 744:	b765                	j	6ec <inet_pton+0x38>

0000000000000746 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 746:	4885                	li	a7,1
 ecall
 748:	00000073          	ecall
 ret
 74c:	8082                	ret

000000000000074e <exit>:
.global exit
exit:
 li a7, SYS_exit
 74e:	4889                	li	a7,2
 ecall
 750:	00000073          	ecall
 ret
 754:	8082                	ret

0000000000000756 <wait>:
.global wait
wait:
 li a7, SYS_wait
 756:	488d                	li	a7,3
 ecall
 758:	00000073          	ecall
 ret
 75c:	8082                	ret

000000000000075e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 75e:	4891                	li	a7,4
 ecall
 760:	00000073          	ecall
 ret
 764:	8082                	ret

0000000000000766 <read>:
.global read
read:
 li a7, SYS_read
 766:	4895                	li	a7,5
 ecall
 768:	00000073          	ecall
 ret
 76c:	8082                	ret

000000000000076e <write>:
.global write
write:
 li a7, SYS_write
 76e:	48c1                	li	a7,16
 ecall
 770:	00000073          	ecall
 ret
 774:	8082                	ret

0000000000000776 <close>:
.global close
close:
 li a7, SYS_close
 776:	48d5                	li	a7,21
 ecall
 778:	00000073          	ecall
 ret
 77c:	8082                	ret

000000000000077e <kill>:
.global kill
kill:
 li a7, SYS_kill
 77e:	4899                	li	a7,6
 ecall
 780:	00000073          	ecall
 ret
 784:	8082                	ret

0000000000000786 <exec>:
.global exec
exec:
 li a7, SYS_exec
 786:	489d                	li	a7,7
 ecall
 788:	00000073          	ecall
 ret
 78c:	8082                	ret

000000000000078e <open>:
.global open
open:
 li a7, SYS_open
 78e:	48bd                	li	a7,15
 ecall
 790:	00000073          	ecall
 ret
 794:	8082                	ret

0000000000000796 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 796:	48c5                	li	a7,17
 ecall
 798:	00000073          	ecall
 ret
 79c:	8082                	ret

000000000000079e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 79e:	48c9                	li	a7,18
 ecall
 7a0:	00000073          	ecall
 ret
 7a4:	8082                	ret

00000000000007a6 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 7a6:	48a1                	li	a7,8
 ecall
 7a8:	00000073          	ecall
 ret
 7ac:	8082                	ret

00000000000007ae <link>:
.global link
link:
 li a7, SYS_link
 7ae:	48cd                	li	a7,19
 ecall
 7b0:	00000073          	ecall
 ret
 7b4:	8082                	ret

00000000000007b6 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 7b6:	48d1                	li	a7,20
 ecall
 7b8:	00000073          	ecall
 ret
 7bc:	8082                	ret

00000000000007be <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 7be:	48a5                	li	a7,9
 ecall
 7c0:	00000073          	ecall
 ret
 7c4:	8082                	ret

00000000000007c6 <dup>:
.global dup
dup:
 li a7, SYS_dup
 7c6:	48a9                	li	a7,10
 ecall
 7c8:	00000073          	ecall
 ret
 7cc:	8082                	ret

00000000000007ce <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 7ce:	48ad                	li	a7,11
 ecall
 7d0:	00000073          	ecall
 ret
 7d4:	8082                	ret

00000000000007d6 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 7d6:	48b1                	li	a7,12
 ecall
 7d8:	00000073          	ecall
 ret
 7dc:	8082                	ret

00000000000007de <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 7de:	48b5                	li	a7,13
 ecall
 7e0:	00000073          	ecall
 ret
 7e4:	8082                	ret

00000000000007e6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 7e6:	48b9                	li	a7,14
 ecall
 7e8:	00000073          	ecall
 ret
 7ec:	8082                	ret

00000000000007ee <socket>:
.global socket
socket:
 li a7, SYS_socket
 7ee:	48d9                	li	a7,22
 ecall
 7f0:	00000073          	ecall
 ret
 7f4:	8082                	ret

00000000000007f6 <bind>:
.global bind
bind:
 li a7, SYS_bind
 7f6:	48dd                	li	a7,23
 ecall
 7f8:	00000073          	ecall
 ret
 7fc:	8082                	ret

00000000000007fe <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 7fe:	48e1                	li	a7,24
 ecall
 800:	00000073          	ecall
 ret
 804:	8082                	ret

0000000000000806 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 806:	48e5                	li	a7,25
 ecall
 808:	00000073          	ecall
 ret
 80c:	8082                	ret

000000000000080e <connect>:
.global connect
connect:
 li a7, SYS_connect
 80e:	48e9                	li	a7,26
 ecall
 810:	00000073          	ecall
 ret
 814:	8082                	ret

0000000000000816 <listen>:
.global listen
listen:
 li a7, SYS_listen
 816:	48ed                	li	a7,27
 ecall
 818:	00000073          	ecall
 ret
 81c:	8082                	ret

000000000000081e <accept>:
.global accept
accept:
 li a7, SYS_accept
 81e:	48f1                	li	a7,28
 ecall
 820:	00000073          	ecall
 ret
 824:	8082                	ret

0000000000000826 <recv>:
.global recv
recv:
 li a7, SYS_recv
 826:	48f5                	li	a7,29
 ecall
 828:	00000073          	ecall
 ret
 82c:	8082                	ret

000000000000082e <send>:
.global send
send:
 li a7, SYS_send
 82e:	48f9                	li	a7,30
 ecall
 830:	00000073          	ecall
 ret
 834:	8082                	ret

0000000000000836 <ioctl>:
.global ioctl
ioctl:
 li a7, SYS_ioctl
 836:	48fd                	li	a7,31
 ecall
 838:	00000073          	ecall
 ret
 83c:	8082                	ret

000000000000083e <consolemode>:
.global consolemode
consolemode:
 li a7, SYS_consolemode
 83e:	02000893          	li	a7,32
 ecall
 842:	00000073          	ecall
 ret
 846:	8082                	ret

0000000000000848 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 848:	1101                	add	sp,sp,-32
 84a:	ec06                	sd	ra,24(sp)
 84c:	e822                	sd	s0,16(sp)
 84e:	1000                	add	s0,sp,32
 850:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 854:	4605                	li	a2,1
 856:	fef40593          	add	a1,s0,-17
 85a:	f15ff0ef          	jal	76e <write>
}
 85e:	60e2                	ld	ra,24(sp)
 860:	6442                	ld	s0,16(sp)
 862:	6105                	add	sp,sp,32
 864:	8082                	ret

0000000000000866 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 866:	715d                	add	sp,sp,-80
 868:	e486                	sd	ra,72(sp)
 86a:	e0a2                	sd	s0,64(sp)
 86c:	fc26                	sd	s1,56(sp)
 86e:	0880                	add	s0,sp,80
 870:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 872:	c299                	beqz	a3,878 <printint+0x12>
 874:	0805c963          	bltz	a1,906 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 878:	2581                	sext.w	a1,a1
  neg = 0;
 87a:	4881                	li	a7,0
 87c:	fb840693          	add	a3,s0,-72
  }

  i = 0;
 880:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 882:	2601                	sext.w	a2,a2
 884:	00000517          	auipc	a0,0x0
 888:	56450513          	add	a0,a0,1380 # de8 <digits>
 88c:	883a                	mv	a6,a4
 88e:	2705                	addw	a4,a4,1
 890:	02c5f7bb          	remuw	a5,a1,a2
 894:	1782                	sll	a5,a5,0x20
 896:	9381                	srl	a5,a5,0x20
 898:	97aa                	add	a5,a5,a0
 89a:	0007c783          	lbu	a5,0(a5)
 89e:	00f68023          	sb	a5,0(a3) # ff0000 <base+0xfeefe0>
  }while((x /= base) != 0);
 8a2:	0005879b          	sext.w	a5,a1
 8a6:	02c5d5bb          	divuw	a1,a1,a2
 8aa:	0685                	add	a3,a3,1
 8ac:	fec7f0e3          	bgeu	a5,a2,88c <printint+0x26>
  if(neg)
 8b0:	00088c63          	beqz	a7,8c8 <printint+0x62>
    buf[i++] = '-';
 8b4:	fd070793          	add	a5,a4,-48
 8b8:	00878733          	add	a4,a5,s0
 8bc:	02d00793          	li	a5,45
 8c0:	fef70423          	sb	a5,-24(a4)
 8c4:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 8c8:	02e05a63          	blez	a4,8fc <printint+0x96>
 8cc:	f84a                	sd	s2,48(sp)
 8ce:	f44e                	sd	s3,40(sp)
 8d0:	fb840793          	add	a5,s0,-72
 8d4:	00e78933          	add	s2,a5,a4
 8d8:	fff78993          	add	s3,a5,-1
 8dc:	99ba                	add	s3,s3,a4
 8de:	377d                	addw	a4,a4,-1
 8e0:	1702                	sll	a4,a4,0x20
 8e2:	9301                	srl	a4,a4,0x20
 8e4:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 8e8:	fff94583          	lbu	a1,-1(s2)
 8ec:	8526                	mv	a0,s1
 8ee:	f5bff0ef          	jal	848 <putc>
  while(--i >= 0)
 8f2:	197d                	add	s2,s2,-1
 8f4:	ff391ae3          	bne	s2,s3,8e8 <printint+0x82>
 8f8:	7942                	ld	s2,48(sp)
 8fa:	79a2                	ld	s3,40(sp)
}
 8fc:	60a6                	ld	ra,72(sp)
 8fe:	6406                	ld	s0,64(sp)
 900:	74e2                	ld	s1,56(sp)
 902:	6161                	add	sp,sp,80
 904:	8082                	ret
    x = -xx;
 906:	40b005bb          	negw	a1,a1
    neg = 1;
 90a:	4885                	li	a7,1
    x = -xx;
 90c:	bf85                	j	87c <printint+0x16>

000000000000090e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 90e:	711d                	add	sp,sp,-96
 910:	ec86                	sd	ra,88(sp)
 912:	e8a2                	sd	s0,80(sp)
 914:	e0ca                	sd	s2,64(sp)
 916:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 918:	0005c903          	lbu	s2,0(a1)
 91c:	26090863          	beqz	s2,b8c <vprintf+0x27e>
 920:	e4a6                	sd	s1,72(sp)
 922:	fc4e                	sd	s3,56(sp)
 924:	f852                	sd	s4,48(sp)
 926:	f456                	sd	s5,40(sp)
 928:	f05a                	sd	s6,32(sp)
 92a:	ec5e                	sd	s7,24(sp)
 92c:	e862                	sd	s8,16(sp)
 92e:	e466                	sd	s9,8(sp)
 930:	8b2a                	mv	s6,a0
 932:	8a2e                	mv	s4,a1
 934:	8bb2                	mv	s7,a2
  state = 0;
 936:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 938:	4481                	li	s1,0
 93a:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 93c:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 940:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 944:	06c00c93          	li	s9,108
 948:	a005                	j	968 <vprintf+0x5a>
        putc(fd, c0);
 94a:	85ca                	mv	a1,s2
 94c:	855a                	mv	a0,s6
 94e:	efbff0ef          	jal	848 <putc>
 952:	a019                	j	958 <vprintf+0x4a>
    } else if(state == '%'){
 954:	03598263          	beq	s3,s5,978 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 958:	2485                	addw	s1,s1,1
 95a:	8726                	mv	a4,s1
 95c:	009a07b3          	add	a5,s4,s1
 960:	0007c903          	lbu	s2,0(a5)
 964:	20090c63          	beqz	s2,b7c <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 968:	0009079b          	sext.w	a5,s2
    if(state == 0){
 96c:	fe0994e3          	bnez	s3,954 <vprintf+0x46>
      if(c0 == '%'){
 970:	fd579de3          	bne	a5,s5,94a <vprintf+0x3c>
        state = '%';
 974:	89be                	mv	s3,a5
 976:	b7cd                	j	958 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 978:	00ea06b3          	add	a3,s4,a4
 97c:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 980:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 982:	c681                	beqz	a3,98a <vprintf+0x7c>
 984:	9752                	add	a4,a4,s4
 986:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 98a:	03878f63          	beq	a5,s8,9c8 <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 98e:	05978963          	beq	a5,s9,9e0 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 992:	07500713          	li	a4,117
 996:	0ee78363          	beq	a5,a4,a7c <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 99a:	07800713          	li	a4,120
 99e:	12e78563          	beq	a5,a4,ac8 <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 9a2:	07000713          	li	a4,112
 9a6:	14e78a63          	beq	a5,a4,afa <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 9aa:	07300713          	li	a4,115
 9ae:	18e78a63          	beq	a5,a4,b42 <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 9b2:	02500713          	li	a4,37
 9b6:	04e79563          	bne	a5,a4,a00 <vprintf+0xf2>
        putc(fd, '%');
 9ba:	02500593          	li	a1,37
 9be:	855a                	mv	a0,s6
 9c0:	e89ff0ef          	jal	848 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 9c4:	4981                	li	s3,0
 9c6:	bf49                	j	958 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 9c8:	008b8913          	add	s2,s7,8
 9cc:	4685                	li	a3,1
 9ce:	4629                	li	a2,10
 9d0:	000ba583          	lw	a1,0(s7)
 9d4:	855a                	mv	a0,s6
 9d6:	e91ff0ef          	jal	866 <printint>
 9da:	8bca                	mv	s7,s2
      state = 0;
 9dc:	4981                	li	s3,0
 9de:	bfad                	j	958 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 9e0:	06400793          	li	a5,100
 9e4:	02f68963          	beq	a3,a5,a16 <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 9e8:	06c00793          	li	a5,108
 9ec:	04f68263          	beq	a3,a5,a30 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 9f0:	07500793          	li	a5,117
 9f4:	0af68063          	beq	a3,a5,a94 <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 9f8:	07800793          	li	a5,120
 9fc:	0ef68263          	beq	a3,a5,ae0 <vprintf+0x1d2>
        putc(fd, '%');
 a00:	02500593          	li	a1,37
 a04:	855a                	mv	a0,s6
 a06:	e43ff0ef          	jal	848 <putc>
        putc(fd, c0);
 a0a:	85ca                	mv	a1,s2
 a0c:	855a                	mv	a0,s6
 a0e:	e3bff0ef          	jal	848 <putc>
      state = 0;
 a12:	4981                	li	s3,0
 a14:	b791                	j	958 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 a16:	008b8913          	add	s2,s7,8
 a1a:	4685                	li	a3,1
 a1c:	4629                	li	a2,10
 a1e:	000bb583          	ld	a1,0(s7)
 a22:	855a                	mv	a0,s6
 a24:	e43ff0ef          	jal	866 <printint>
        i += 1;
 a28:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 a2a:	8bca                	mv	s7,s2
      state = 0;
 a2c:	4981                	li	s3,0
        i += 1;
 a2e:	b72d                	j	958 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 a30:	06400793          	li	a5,100
 a34:	02f60763          	beq	a2,a5,a62 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 a38:	07500793          	li	a5,117
 a3c:	06f60963          	beq	a2,a5,aae <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 a40:	07800793          	li	a5,120
 a44:	faf61ee3          	bne	a2,a5,a00 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 a48:	008b8913          	add	s2,s7,8
 a4c:	4681                	li	a3,0
 a4e:	4641                	li	a2,16
 a50:	000bb583          	ld	a1,0(s7)
 a54:	855a                	mv	a0,s6
 a56:	e11ff0ef          	jal	866 <printint>
        i += 2;
 a5a:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 a5c:	8bca                	mv	s7,s2
      state = 0;
 a5e:	4981                	li	s3,0
        i += 2;
 a60:	bde5                	j	958 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 a62:	008b8913          	add	s2,s7,8
 a66:	4685                	li	a3,1
 a68:	4629                	li	a2,10
 a6a:	000bb583          	ld	a1,0(s7)
 a6e:	855a                	mv	a0,s6
 a70:	df7ff0ef          	jal	866 <printint>
        i += 2;
 a74:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 a76:	8bca                	mv	s7,s2
      state = 0;
 a78:	4981                	li	s3,0
        i += 2;
 a7a:	bdf9                	j	958 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 a7c:	008b8913          	add	s2,s7,8
 a80:	4681                	li	a3,0
 a82:	4629                	li	a2,10
 a84:	000ba583          	lw	a1,0(s7)
 a88:	855a                	mv	a0,s6
 a8a:	dddff0ef          	jal	866 <printint>
 a8e:	8bca                	mv	s7,s2
      state = 0;
 a90:	4981                	li	s3,0
 a92:	b5d9                	j	958 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 a94:	008b8913          	add	s2,s7,8
 a98:	4681                	li	a3,0
 a9a:	4629                	li	a2,10
 a9c:	000bb583          	ld	a1,0(s7)
 aa0:	855a                	mv	a0,s6
 aa2:	dc5ff0ef          	jal	866 <printint>
        i += 1;
 aa6:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 aa8:	8bca                	mv	s7,s2
      state = 0;
 aaa:	4981                	li	s3,0
        i += 1;
 aac:	b575                	j	958 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 aae:	008b8913          	add	s2,s7,8
 ab2:	4681                	li	a3,0
 ab4:	4629                	li	a2,10
 ab6:	000bb583          	ld	a1,0(s7)
 aba:	855a                	mv	a0,s6
 abc:	dabff0ef          	jal	866 <printint>
        i += 2;
 ac0:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 ac2:	8bca                	mv	s7,s2
      state = 0;
 ac4:	4981                	li	s3,0
        i += 2;
 ac6:	bd49                	j	958 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 ac8:	008b8913          	add	s2,s7,8
 acc:	4681                	li	a3,0
 ace:	4641                	li	a2,16
 ad0:	000ba583          	lw	a1,0(s7)
 ad4:	855a                	mv	a0,s6
 ad6:	d91ff0ef          	jal	866 <printint>
 ada:	8bca                	mv	s7,s2
      state = 0;
 adc:	4981                	li	s3,0
 ade:	bdad                	j	958 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 ae0:	008b8913          	add	s2,s7,8
 ae4:	4681                	li	a3,0
 ae6:	4641                	li	a2,16
 ae8:	000bb583          	ld	a1,0(s7)
 aec:	855a                	mv	a0,s6
 aee:	d79ff0ef          	jal	866 <printint>
        i += 1;
 af2:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 af4:	8bca                	mv	s7,s2
      state = 0;
 af6:	4981                	li	s3,0
        i += 1;
 af8:	b585                	j	958 <vprintf+0x4a>
 afa:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 afc:	008b8d13          	add	s10,s7,8
 b00:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 b04:	03000593          	li	a1,48
 b08:	855a                	mv	a0,s6
 b0a:	d3fff0ef          	jal	848 <putc>
  putc(fd, 'x');
 b0e:	07800593          	li	a1,120
 b12:	855a                	mv	a0,s6
 b14:	d35ff0ef          	jal	848 <putc>
 b18:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 b1a:	00000b97          	auipc	s7,0x0
 b1e:	2ceb8b93          	add	s7,s7,718 # de8 <digits>
 b22:	03c9d793          	srl	a5,s3,0x3c
 b26:	97de                	add	a5,a5,s7
 b28:	0007c583          	lbu	a1,0(a5)
 b2c:	855a                	mv	a0,s6
 b2e:	d1bff0ef          	jal	848 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 b32:	0992                	sll	s3,s3,0x4
 b34:	397d                	addw	s2,s2,-1
 b36:	fe0916e3          	bnez	s2,b22 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 b3a:	8bea                	mv	s7,s10
      state = 0;
 b3c:	4981                	li	s3,0
 b3e:	6d02                	ld	s10,0(sp)
 b40:	bd21                	j	958 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 b42:	008b8993          	add	s3,s7,8
 b46:	000bb903          	ld	s2,0(s7)
 b4a:	00090f63          	beqz	s2,b68 <vprintf+0x25a>
        for(; *s; s++)
 b4e:	00094583          	lbu	a1,0(s2)
 b52:	c195                	beqz	a1,b76 <vprintf+0x268>
          putc(fd, *s);
 b54:	855a                	mv	a0,s6
 b56:	cf3ff0ef          	jal	848 <putc>
        for(; *s; s++)
 b5a:	0905                	add	s2,s2,1
 b5c:	00094583          	lbu	a1,0(s2)
 b60:	f9f5                	bnez	a1,b54 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 b62:	8bce                	mv	s7,s3
      state = 0;
 b64:	4981                	li	s3,0
 b66:	bbcd                	j	958 <vprintf+0x4a>
          s = "(null)";
 b68:	00000917          	auipc	s2,0x0
 b6c:	27890913          	add	s2,s2,632 # de0 <malloc+0x164>
        for(; *s; s++)
 b70:	02800593          	li	a1,40
 b74:	b7c5                	j	b54 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 b76:	8bce                	mv	s7,s3
      state = 0;
 b78:	4981                	li	s3,0
 b7a:	bbf9                	j	958 <vprintf+0x4a>
 b7c:	64a6                	ld	s1,72(sp)
 b7e:	79e2                	ld	s3,56(sp)
 b80:	7a42                	ld	s4,48(sp)
 b82:	7aa2                	ld	s5,40(sp)
 b84:	7b02                	ld	s6,32(sp)
 b86:	6be2                	ld	s7,24(sp)
 b88:	6c42                	ld	s8,16(sp)
 b8a:	6ca2                	ld	s9,8(sp)
    }
  }
}
 b8c:	60e6                	ld	ra,88(sp)
 b8e:	6446                	ld	s0,80(sp)
 b90:	6906                	ld	s2,64(sp)
 b92:	6125                	add	sp,sp,96
 b94:	8082                	ret

0000000000000b96 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 b96:	715d                	add	sp,sp,-80
 b98:	ec06                	sd	ra,24(sp)
 b9a:	e822                	sd	s0,16(sp)
 b9c:	1000                	add	s0,sp,32
 b9e:	e010                	sd	a2,0(s0)
 ba0:	e414                	sd	a3,8(s0)
 ba2:	e818                	sd	a4,16(s0)
 ba4:	ec1c                	sd	a5,24(s0)
 ba6:	03043023          	sd	a6,32(s0)
 baa:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 bae:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 bb2:	8622                	mv	a2,s0
 bb4:	d5bff0ef          	jal	90e <vprintf>
}
 bb8:	60e2                	ld	ra,24(sp)
 bba:	6442                	ld	s0,16(sp)
 bbc:	6161                	add	sp,sp,80
 bbe:	8082                	ret

0000000000000bc0 <printf>:

void
printf(const char *fmt, ...)
{
 bc0:	711d                	add	sp,sp,-96
 bc2:	ec06                	sd	ra,24(sp)
 bc4:	e822                	sd	s0,16(sp)
 bc6:	1000                	add	s0,sp,32
 bc8:	e40c                	sd	a1,8(s0)
 bca:	e810                	sd	a2,16(s0)
 bcc:	ec14                	sd	a3,24(s0)
 bce:	f018                	sd	a4,32(s0)
 bd0:	f41c                	sd	a5,40(s0)
 bd2:	03043823          	sd	a6,48(s0)
 bd6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 bda:	00840613          	add	a2,s0,8
 bde:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 be2:	85aa                	mv	a1,a0
 be4:	4505                	li	a0,1
 be6:	d29ff0ef          	jal	90e <vprintf>
}
 bea:	60e2                	ld	ra,24(sp)
 bec:	6442                	ld	s0,16(sp)
 bee:	6125                	add	sp,sp,96
 bf0:	8082                	ret

0000000000000bf2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 bf2:	1141                	add	sp,sp,-16
 bf4:	e422                	sd	s0,8(sp)
 bf6:	0800                	add	s0,sp,16
  Header *bp, *p;

  if(ap == 0)
 bf8:	cd3d                	beqz	a0,c76 <free+0x84>
    return;
  if((uint64)ap < 4096)
 bfa:	6785                	lui	a5,0x1
 bfc:	06f56d63          	bltu	a0,a5,c76 <free+0x84>
    return;
  bp = (Header*)ap - 1;
 c00:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c04:	00000797          	auipc	a5,0x0
 c08:	4047b783          	ld	a5,1028(a5) # 1008 <freep>
 c0c:	a02d                	j	c36 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 c0e:	4618                	lw	a4,8(a2)
 c10:	9f2d                	addw	a4,a4,a1
 c12:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 c16:	6398                	ld	a4,0(a5)
 c18:	6310                	ld	a2,0(a4)
 c1a:	a83d                	j	c58 <free+0x66>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 c1c:	ff852703          	lw	a4,-8(a0)
 c20:	9f31                	addw	a4,a4,a2
 c22:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 c24:	ff053683          	ld	a3,-16(a0)
 c28:	a091                	j	c6c <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c2a:	6398                	ld	a4,0(a5)
 c2c:	00e7e463          	bltu	a5,a4,c34 <free+0x42>
 c30:	00e6ea63          	bltu	a3,a4,c44 <free+0x52>
{
 c34:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c36:	fed7fae3          	bgeu	a5,a3,c2a <free+0x38>
 c3a:	6398                	ld	a4,0(a5)
 c3c:	00e6e463          	bltu	a3,a4,c44 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c40:	fee7eae3          	bltu	a5,a4,c34 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 c44:	ff852583          	lw	a1,-8(a0)
 c48:	6390                	ld	a2,0(a5)
 c4a:	02059813          	sll	a6,a1,0x20
 c4e:	01c85713          	srl	a4,a6,0x1c
 c52:	9736                	add	a4,a4,a3
 c54:	fae60de3          	beq	a2,a4,c0e <free+0x1c>
    bp->s.ptr = p->s.ptr->s.ptr;
 c58:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 c5c:	4790                	lw	a2,8(a5)
 c5e:	02061593          	sll	a1,a2,0x20
 c62:	01c5d713          	srl	a4,a1,0x1c
 c66:	973e                	add	a4,a4,a5
 c68:	fae68ae3          	beq	a3,a4,c1c <free+0x2a>
    p->s.ptr = bp->s.ptr;
 c6c:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 c6e:	00000717          	auipc	a4,0x0
 c72:	38f73d23          	sd	a5,922(a4) # 1008 <freep>
}
 c76:	6422                	ld	s0,8(sp)
 c78:	0141                	add	sp,sp,16
 c7a:	8082                	ret

0000000000000c7c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 c7c:	7139                	add	sp,sp,-64
 c7e:	fc06                	sd	ra,56(sp)
 c80:	f822                	sd	s0,48(sp)
 c82:	f426                	sd	s1,40(sp)
 c84:	ec4e                	sd	s3,24(sp)
 c86:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c88:	02051493          	sll	s1,a0,0x20
 c8c:	9081                	srl	s1,s1,0x20
 c8e:	04bd                	add	s1,s1,15
 c90:	8091                	srl	s1,s1,0x4
 c92:	0014899b          	addw	s3,s1,1
 c96:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 c98:	00000517          	auipc	a0,0x0
 c9c:	37053503          	ld	a0,880(a0) # 1008 <freep>
 ca0:	c915                	beqz	a0,cd4 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ca2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ca4:	4798                	lw	a4,8(a5)
 ca6:	08977a63          	bgeu	a4,s1,d3a <malloc+0xbe>
 caa:	f04a                	sd	s2,32(sp)
 cac:	e852                	sd	s4,16(sp)
 cae:	e456                	sd	s5,8(sp)
 cb0:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 cb2:	8a4e                	mv	s4,s3
 cb4:	0009871b          	sext.w	a4,s3
 cb8:	6685                	lui	a3,0x1
 cba:	00d77363          	bgeu	a4,a3,cc0 <malloc+0x44>
 cbe:	6a05                	lui	s4,0x1
 cc0:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 cc4:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 cc8:	00000917          	auipc	s2,0x0
 ccc:	34090913          	add	s2,s2,832 # 1008 <freep>
  if(p == (char*)-1)
 cd0:	5afd                	li	s5,-1
 cd2:	a081                	j	d12 <malloc+0x96>
 cd4:	f04a                	sd	s2,32(sp)
 cd6:	e852                	sd	s4,16(sp)
 cd8:	e456                	sd	s5,8(sp)
 cda:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 cdc:	00000797          	auipc	a5,0x0
 ce0:	34478793          	add	a5,a5,836 # 1020 <base>
 ce4:	00000717          	auipc	a4,0x0
 ce8:	32f73223          	sd	a5,804(a4) # 1008 <freep>
 cec:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 cee:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 cf2:	b7c1                	j	cb2 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 cf4:	6398                	ld	a4,0(a5)
 cf6:	e118                	sd	a4,0(a0)
 cf8:	a8a9                	j	d52 <malloc+0xd6>
  hp->s.size = nu;
 cfa:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 cfe:	0541                	add	a0,a0,16
 d00:	ef3ff0ef          	jal	bf2 <free>
  return freep;
 d04:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 d08:	c12d                	beqz	a0,d6a <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d0a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 d0c:	4798                	lw	a4,8(a5)
 d0e:	02977263          	bgeu	a4,s1,d32 <malloc+0xb6>
    if(p == freep)
 d12:	00093703          	ld	a4,0(s2)
 d16:	853e                	mv	a0,a5
 d18:	fef719e3          	bne	a4,a5,d0a <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 d1c:	8552                	mv	a0,s4
 d1e:	ab9ff0ef          	jal	7d6 <sbrk>
  if(p == (char*)-1)
 d22:	fd551ce3          	bne	a0,s5,cfa <malloc+0x7e>
        return 0;
 d26:	4501                	li	a0,0
 d28:	7902                	ld	s2,32(sp)
 d2a:	6a42                	ld	s4,16(sp)
 d2c:	6aa2                	ld	s5,8(sp)
 d2e:	6b02                	ld	s6,0(sp)
 d30:	a03d                	j	d5e <malloc+0xe2>
 d32:	7902                	ld	s2,32(sp)
 d34:	6a42                	ld	s4,16(sp)
 d36:	6aa2                	ld	s5,8(sp)
 d38:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 d3a:	fae48de3          	beq	s1,a4,cf4 <malloc+0x78>
        p->s.size -= nunits;
 d3e:	4137073b          	subw	a4,a4,s3
 d42:	c798                	sw	a4,8(a5)
        p += p->s.size;
 d44:	02071693          	sll	a3,a4,0x20
 d48:	01c6d713          	srl	a4,a3,0x1c
 d4c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 d4e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 d52:	00000717          	auipc	a4,0x0
 d56:	2aa73b23          	sd	a0,694(a4) # 1008 <freep>
      return (void*)(p + 1);
 d5a:	01078513          	add	a0,a5,16
  }
}
 d5e:	70e2                	ld	ra,56(sp)
 d60:	7442                	ld	s0,48(sp)
 d62:	74a2                	ld	s1,40(sp)
 d64:	69e2                	ld	s3,24(sp)
 d66:	6121                	add	sp,sp,64
 d68:	8082                	ret
 d6a:	7902                	ld	s2,32(sp)
 d6c:	6a42                	ld	s4,16(sp)
 d6e:	6aa2                	ld	s5,8(sp)
 d70:	6b02                	ld	s6,0(sp)
 d72:	b7f5                	j	d5e <malloc+0xe2>
