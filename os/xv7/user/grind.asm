
user/_grind:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <do_rand>:
#include "kernel/riscv.h"

// from FreeBSD.
int
do_rand(unsigned long *ctx)
{
       0:	1141                	add	sp,sp,-16
       2:	e422                	sd	s0,8(sp)
       4:	0800                	add	s0,sp,16
 * October 1988, p. 1195.
 */
    long hi, lo, x;

    /* Transform to [1, 0x7ffffffe] range. */
    x = (*ctx % 0x7ffffffe) + 1;
       6:	611c                	ld	a5,0(a0)
       8:	80000737          	lui	a4,0x80000
       c:	ffe74713          	xor	a4,a4,-2
      10:	02e7f7b3          	remu	a5,a5,a4
      14:	0785                	add	a5,a5,1
    hi = x / 127773;
    lo = x % 127773;
      16:	66fd                	lui	a3,0x1f
      18:	31d68693          	add	a3,a3,797 # 1f31d <base+0x1cf15>
      1c:	02d7e733          	rem	a4,a5,a3
    x = 16807 * lo - 2836 * hi;
      20:	6611                	lui	a2,0x4
      22:	1a760613          	add	a2,a2,423 # 41a7 <base+0x1d9f>
      26:	02c70733          	mul	a4,a4,a2
    hi = x / 127773;
      2a:	02d7c7b3          	div	a5,a5,a3
    x = 16807 * lo - 2836 * hi;
      2e:	76fd                	lui	a3,0xfffff
      30:	4ec68693          	add	a3,a3,1260 # fffffffffffff4ec <base+0xffffffffffffd0e4>
      34:	02d787b3          	mul	a5,a5,a3
      38:	97ba                	add	a5,a5,a4
    if (x < 0)
      3a:	0007c963          	bltz	a5,4c <do_rand+0x4c>
        x += 0x7fffffff;
    /* Transform to [0, 0x7ffffffd] range. */
    x--;
      3e:	17fd                	add	a5,a5,-1
    *ctx = x;
      40:	e11c                	sd	a5,0(a0)
    return (x);
}
      42:	0007851b          	sext.w	a0,a5
      46:	6422                	ld	s0,8(sp)
      48:	0141                	add	sp,sp,16
      4a:	8082                	ret
        x += 0x7fffffff;
      4c:	80000737          	lui	a4,0x80000
      50:	fff74713          	not	a4,a4
      54:	97ba                	add	a5,a5,a4
      56:	b7e5                	j	3e <do_rand+0x3e>

0000000000000058 <rand>:

unsigned long rand_next = 1;

int
rand(void)
{
      58:	1141                	add	sp,sp,-16
      5a:	e406                	sd	ra,8(sp)
      5c:	e022                	sd	s0,0(sp)
      5e:	0800                	add	s0,sp,16
    return (do_rand(&rand_next));
      60:	00002517          	auipc	a0,0x2
      64:	fa050513          	add	a0,a0,-96 # 2000 <rand_next>
      68:	f99ff0ef          	jal	0 <do_rand>
}
      6c:	60a2                	ld	ra,8(sp)
      6e:	6402                	ld	s0,0(sp)
      70:	0141                	add	sp,sp,16
      72:	8082                	ret

0000000000000074 <go>:

void
go(int which_child)
{
      74:	7119                	add	sp,sp,-128
      76:	fc86                	sd	ra,120(sp)
      78:	f8a2                	sd	s0,112(sp)
      7a:	f4a6                	sd	s1,104(sp)
      7c:	e4d6                	sd	s5,72(sp)
      7e:	0100                	add	s0,sp,128
      80:	84aa                	mv	s1,a0
  int fd = -1;
  static char buf[999];
  char *break0 = sbrk(0);
      82:	4501                	li	a0,0
      84:	5cf000ef          	jal	e52 <sbrk>
      88:	8aaa                	mv	s5,a0
  uint64 iters = 0;

  mkdir("grindir");
      8a:	00001517          	auipc	a0,0x1
      8e:	36650513          	add	a0,a0,870 # 13f0 <malloc+0xf8>
      92:	5a1000ef          	jal	e32 <mkdir>
  if(chdir("grindir") != 0){
      96:	00001517          	auipc	a0,0x1
      9a:	35a50513          	add	a0,a0,858 # 13f0 <malloc+0xf8>
      9e:	59d000ef          	jal	e3a <chdir>
      a2:	cd19                	beqz	a0,c0 <go+0x4c>
      a4:	f0ca                	sd	s2,96(sp)
      a6:	ecce                	sd	s3,88(sp)
      a8:	e8d2                	sd	s4,80(sp)
      aa:	e0da                	sd	s6,64(sp)
      ac:	fc5e                	sd	s7,56(sp)
    printf("grind: chdir grindir failed\n");
      ae:	00001517          	auipc	a0,0x1
      b2:	34a50513          	add	a0,a0,842 # 13f8 <malloc+0x100>
      b6:	186010ef          	jal	123c <printf>
    exit(1);
      ba:	4505                	li	a0,1
      bc:	50f000ef          	jal	dca <exit>
      c0:	f0ca                	sd	s2,96(sp)
      c2:	ecce                	sd	s3,88(sp)
      c4:	e8d2                	sd	s4,80(sp)
      c6:	e0da                	sd	s6,64(sp)
      c8:	fc5e                	sd	s7,56(sp)
  }
  chdir("/");
      ca:	00001517          	auipc	a0,0x1
      ce:	35650513          	add	a0,a0,854 # 1420 <malloc+0x128>
      d2:	569000ef          	jal	e3a <chdir>
      d6:	00001997          	auipc	s3,0x1
      da:	35a98993          	add	s3,s3,858 # 1430 <malloc+0x138>
      de:	c489                	beqz	s1,e8 <go+0x74>
      e0:	00001997          	auipc	s3,0x1
      e4:	34898993          	add	s3,s3,840 # 1428 <malloc+0x130>
  uint64 iters = 0;
      e8:	4481                	li	s1,0
  int fd = -1;
      ea:	5a7d                	li	s4,-1
      ec:	00001917          	auipc	s2,0x1
      f0:	61490913          	add	s2,s2,1556 # 1700 <malloc+0x408>
      f4:	a819                	j	10a <go+0x96>
    iters++;
    if((iters % 500) == 0)
      write(1, which_child?"B":"A", 1);
    int what = rand() % 23;
    if(what == 1){
      close(open("grindir/../a", O_CREATE|O_RDWR));
      f6:	20200593          	li	a1,514
      fa:	00001517          	auipc	a0,0x1
      fe:	33e50513          	add	a0,a0,830 # 1438 <malloc+0x140>
     102:	509000ef          	jal	e0a <open>
     106:	4ed000ef          	jal	df2 <close>
    iters++;
     10a:	0485                	add	s1,s1,1
    if((iters % 500) == 0)
     10c:	1f400793          	li	a5,500
     110:	02f4f7b3          	remu	a5,s1,a5
     114:	e791                	bnez	a5,120 <go+0xac>
      write(1, which_child?"B":"A", 1);
     116:	4605                	li	a2,1
     118:	85ce                	mv	a1,s3
     11a:	4505                	li	a0,1
     11c:	4cf000ef          	jal	dea <write>
    int what = rand() % 23;
     120:	f39ff0ef          	jal	58 <rand>
     124:	47dd                	li	a5,23
     126:	02f5653b          	remw	a0,a0,a5
     12a:	0005071b          	sext.w	a4,a0
     12e:	47d9                	li	a5,22
     130:	fce7ede3          	bltu	a5,a4,10a <go+0x96>
     134:	02051793          	sll	a5,a0,0x20
     138:	01e7d513          	srl	a0,a5,0x1e
     13c:	954a                	add	a0,a0,s2
     13e:	411c                	lw	a5,0(a0)
     140:	97ca                	add	a5,a5,s2
     142:	8782                	jr	a5
    } else if(what == 2){
      close(open("grindir/../grindir/../b", O_CREATE|O_RDWR));
     144:	20200593          	li	a1,514
     148:	00001517          	auipc	a0,0x1
     14c:	30050513          	add	a0,a0,768 # 1448 <malloc+0x150>
     150:	4bb000ef          	jal	e0a <open>
     154:	49f000ef          	jal	df2 <close>
     158:	bf4d                	j	10a <go+0x96>
    } else if(what == 3){
      unlink("grindir/../a");
     15a:	00001517          	auipc	a0,0x1
     15e:	2de50513          	add	a0,a0,734 # 1438 <malloc+0x140>
     162:	4b9000ef          	jal	e1a <unlink>
     166:	b755                	j	10a <go+0x96>
    } else if(what == 4){
      if(chdir("grindir") != 0){
     168:	00001517          	auipc	a0,0x1
     16c:	28850513          	add	a0,a0,648 # 13f0 <malloc+0xf8>
     170:	4cb000ef          	jal	e3a <chdir>
     174:	ed11                	bnez	a0,190 <go+0x11c>
        printf("grind: chdir grindir failed\n");
        exit(1);
      }
      unlink("../b");
     176:	00001517          	auipc	a0,0x1
     17a:	2ea50513          	add	a0,a0,746 # 1460 <malloc+0x168>
     17e:	49d000ef          	jal	e1a <unlink>
      chdir("/");
     182:	00001517          	auipc	a0,0x1
     186:	29e50513          	add	a0,a0,670 # 1420 <malloc+0x128>
     18a:	4b1000ef          	jal	e3a <chdir>
     18e:	bfb5                	j	10a <go+0x96>
        printf("grind: chdir grindir failed\n");
     190:	00001517          	auipc	a0,0x1
     194:	26850513          	add	a0,a0,616 # 13f8 <malloc+0x100>
     198:	0a4010ef          	jal	123c <printf>
        exit(1);
     19c:	4505                	li	a0,1
     19e:	42d000ef          	jal	dca <exit>
    } else if(what == 5){
      close(fd);
     1a2:	8552                	mv	a0,s4
     1a4:	44f000ef          	jal	df2 <close>
      fd = open("/grindir/../a", O_CREATE|O_RDWR);
     1a8:	20200593          	li	a1,514
     1ac:	00001517          	auipc	a0,0x1
     1b0:	2bc50513          	add	a0,a0,700 # 1468 <malloc+0x170>
     1b4:	457000ef          	jal	e0a <open>
     1b8:	8a2a                	mv	s4,a0
     1ba:	bf81                	j	10a <go+0x96>
    } else if(what == 6){
      close(fd);
     1bc:	8552                	mv	a0,s4
     1be:	435000ef          	jal	df2 <close>
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
     1c2:	20200593          	li	a1,514
     1c6:	00001517          	auipc	a0,0x1
     1ca:	2b250513          	add	a0,a0,690 # 1478 <malloc+0x180>
     1ce:	43d000ef          	jal	e0a <open>
     1d2:	8a2a                	mv	s4,a0
     1d4:	bf1d                	j	10a <go+0x96>
    } else if(what == 7){
      write(fd, buf, sizeof(buf));
     1d6:	3e700613          	li	a2,999
     1da:	00002597          	auipc	a1,0x2
     1de:	e4658593          	add	a1,a1,-442 # 2020 <buf.0>
     1e2:	8552                	mv	a0,s4
     1e4:	407000ef          	jal	dea <write>
     1e8:	b70d                	j	10a <go+0x96>
    } else if(what == 8){
      read(fd, buf, sizeof(buf));
     1ea:	3e700613          	li	a2,999
     1ee:	00002597          	auipc	a1,0x2
     1f2:	e3258593          	add	a1,a1,-462 # 2020 <buf.0>
     1f6:	8552                	mv	a0,s4
     1f8:	3eb000ef          	jal	de2 <read>
     1fc:	b739                	j	10a <go+0x96>
    } else if(what == 9){
      mkdir("grindir/../a");
     1fe:	00001517          	auipc	a0,0x1
     202:	23a50513          	add	a0,a0,570 # 1438 <malloc+0x140>
     206:	42d000ef          	jal	e32 <mkdir>
      close(open("a/../a/./a", O_CREATE|O_RDWR));
     20a:	20200593          	li	a1,514
     20e:	00001517          	auipc	a0,0x1
     212:	28250513          	add	a0,a0,642 # 1490 <malloc+0x198>
     216:	3f5000ef          	jal	e0a <open>
     21a:	3d9000ef          	jal	df2 <close>
      unlink("a/a");
     21e:	00001517          	auipc	a0,0x1
     222:	28250513          	add	a0,a0,642 # 14a0 <malloc+0x1a8>
     226:	3f5000ef          	jal	e1a <unlink>
     22a:	b5c5                	j	10a <go+0x96>
    } else if(what == 10){
      mkdir("/../b");
     22c:	00001517          	auipc	a0,0x1
     230:	27c50513          	add	a0,a0,636 # 14a8 <malloc+0x1b0>
     234:	3ff000ef          	jal	e32 <mkdir>
      close(open("grindir/../b/b", O_CREATE|O_RDWR));
     238:	20200593          	li	a1,514
     23c:	00001517          	auipc	a0,0x1
     240:	27450513          	add	a0,a0,628 # 14b0 <malloc+0x1b8>
     244:	3c7000ef          	jal	e0a <open>
     248:	3ab000ef          	jal	df2 <close>
      unlink("b/b");
     24c:	00001517          	auipc	a0,0x1
     250:	27450513          	add	a0,a0,628 # 14c0 <malloc+0x1c8>
     254:	3c7000ef          	jal	e1a <unlink>
     258:	bd4d                	j	10a <go+0x96>
    } else if(what == 11){
      unlink("b");
     25a:	00001517          	auipc	a0,0x1
     25e:	26e50513          	add	a0,a0,622 # 14c8 <malloc+0x1d0>
     262:	3b9000ef          	jal	e1a <unlink>
      link("../grindir/./../a", "../b");
     266:	00001597          	auipc	a1,0x1
     26a:	1fa58593          	add	a1,a1,506 # 1460 <malloc+0x168>
     26e:	00001517          	auipc	a0,0x1
     272:	26250513          	add	a0,a0,610 # 14d0 <malloc+0x1d8>
     276:	3b5000ef          	jal	e2a <link>
     27a:	bd41                	j	10a <go+0x96>
    } else if(what == 12){
      unlink("../grindir/../a");
     27c:	00001517          	auipc	a0,0x1
     280:	26c50513          	add	a0,a0,620 # 14e8 <malloc+0x1f0>
     284:	397000ef          	jal	e1a <unlink>
      link(".././b", "/grindir/../a");
     288:	00001597          	auipc	a1,0x1
     28c:	1e058593          	add	a1,a1,480 # 1468 <malloc+0x170>
     290:	00001517          	auipc	a0,0x1
     294:	26850513          	add	a0,a0,616 # 14f8 <malloc+0x200>
     298:	393000ef          	jal	e2a <link>
     29c:	b5bd                	j	10a <go+0x96>
    } else if(what == 13){
      int pid = fork();
     29e:	325000ef          	jal	dc2 <fork>
      if(pid == 0){
     2a2:	c519                	beqz	a0,2b0 <go+0x23c>
        exit(0);
      } else if(pid < 0){
     2a4:	00054863          	bltz	a0,2b4 <go+0x240>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     2a8:	4501                	li	a0,0
     2aa:	329000ef          	jal	dd2 <wait>
     2ae:	bdb1                	j	10a <go+0x96>
        exit(0);
     2b0:	31b000ef          	jal	dca <exit>
        printf("grind: fork failed\n");
     2b4:	00001517          	auipc	a0,0x1
     2b8:	24c50513          	add	a0,a0,588 # 1500 <malloc+0x208>
     2bc:	781000ef          	jal	123c <printf>
        exit(1);
     2c0:	4505                	li	a0,1
     2c2:	309000ef          	jal	dca <exit>
    } else if(what == 14){
      int pid = fork();
     2c6:	2fd000ef          	jal	dc2 <fork>
      if(pid == 0){
     2ca:	c519                	beqz	a0,2d8 <go+0x264>
        fork();
        fork();
        exit(0);
      } else if(pid < 0){
     2cc:	00054d63          	bltz	a0,2e6 <go+0x272>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     2d0:	4501                	li	a0,0
     2d2:	301000ef          	jal	dd2 <wait>
     2d6:	bd15                	j	10a <go+0x96>
        fork();
     2d8:	2eb000ef          	jal	dc2 <fork>
        fork();
     2dc:	2e7000ef          	jal	dc2 <fork>
        exit(0);
     2e0:	4501                	li	a0,0
     2e2:	2e9000ef          	jal	dca <exit>
        printf("grind: fork failed\n");
     2e6:	00001517          	auipc	a0,0x1
     2ea:	21a50513          	add	a0,a0,538 # 1500 <malloc+0x208>
     2ee:	74f000ef          	jal	123c <printf>
        exit(1);
     2f2:	4505                	li	a0,1
     2f4:	2d7000ef          	jal	dca <exit>
    } else if(what == 15){
      sbrk(6011);
     2f8:	6505                	lui	a0,0x1
     2fa:	77b50513          	add	a0,a0,1915 # 177b <digits+0x1b>
     2fe:	355000ef          	jal	e52 <sbrk>
     302:	b521                	j	10a <go+0x96>
    } else if(what == 16){
      if(sbrk(0) > break0)
     304:	4501                	li	a0,0
     306:	34d000ef          	jal	e52 <sbrk>
     30a:	e0aaf0e3          	bgeu	s5,a0,10a <go+0x96>
        sbrk(-(sbrk(0) - break0));
     30e:	4501                	li	a0,0
     310:	343000ef          	jal	e52 <sbrk>
     314:	40aa853b          	subw	a0,s5,a0
     318:	33b000ef          	jal	e52 <sbrk>
     31c:	b3fd                	j	10a <go+0x96>
    } else if(what == 17){
      int pid = fork();
     31e:	2a5000ef          	jal	dc2 <fork>
     322:	8b2a                	mv	s6,a0
      if(pid == 0){
     324:	c10d                	beqz	a0,346 <go+0x2d2>
        close(open("a", O_CREATE|O_RDWR));
        exit(0);
      } else if(pid < 0){
     326:	02054d63          	bltz	a0,360 <go+0x2ec>
        printf("grind: fork failed\n");
        exit(1);
      }
      if(chdir("../grindir/..") != 0){
     32a:	00001517          	auipc	a0,0x1
     32e:	1f650513          	add	a0,a0,502 # 1520 <malloc+0x228>
     332:	309000ef          	jal	e3a <chdir>
     336:	ed15                	bnez	a0,372 <go+0x2fe>
        printf("grind: chdir failed\n");
        exit(1);
      }
      kill(pid);
     338:	855a                	mv	a0,s6
     33a:	2c1000ef          	jal	dfa <kill>
      wait(0);
     33e:	4501                	li	a0,0
     340:	293000ef          	jal	dd2 <wait>
     344:	b3d9                	j	10a <go+0x96>
        close(open("a", O_CREATE|O_RDWR));
     346:	20200593          	li	a1,514
     34a:	00001517          	auipc	a0,0x1
     34e:	1ce50513          	add	a0,a0,462 # 1518 <malloc+0x220>
     352:	2b9000ef          	jal	e0a <open>
     356:	29d000ef          	jal	df2 <close>
        exit(0);
     35a:	4501                	li	a0,0
     35c:	26f000ef          	jal	dca <exit>
        printf("grind: fork failed\n");
     360:	00001517          	auipc	a0,0x1
     364:	1a050513          	add	a0,a0,416 # 1500 <malloc+0x208>
     368:	6d5000ef          	jal	123c <printf>
        exit(1);
     36c:	4505                	li	a0,1
     36e:	25d000ef          	jal	dca <exit>
        printf("grind: chdir failed\n");
     372:	00001517          	auipc	a0,0x1
     376:	1be50513          	add	a0,a0,446 # 1530 <malloc+0x238>
     37a:	6c3000ef          	jal	123c <printf>
        exit(1);
     37e:	4505                	li	a0,1
     380:	24b000ef          	jal	dca <exit>
    } else if(what == 18){
      int pid = fork();
     384:	23f000ef          	jal	dc2 <fork>
      if(pid == 0){
     388:	c519                	beqz	a0,396 <go+0x322>
        kill(getpid());
        exit(0);
      } else if(pid < 0){
     38a:	00054d63          	bltz	a0,3a4 <go+0x330>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     38e:	4501                	li	a0,0
     390:	243000ef          	jal	dd2 <wait>
     394:	bb9d                	j	10a <go+0x96>
        kill(getpid());
     396:	2b5000ef          	jal	e4a <getpid>
     39a:	261000ef          	jal	dfa <kill>
        exit(0);
     39e:	4501                	li	a0,0
     3a0:	22b000ef          	jal	dca <exit>
        printf("grind: fork failed\n");
     3a4:	00001517          	auipc	a0,0x1
     3a8:	15c50513          	add	a0,a0,348 # 1500 <malloc+0x208>
     3ac:	691000ef          	jal	123c <printf>
        exit(1);
     3b0:	4505                	li	a0,1
     3b2:	219000ef          	jal	dca <exit>
    } else if(what == 19){
      int fds[2];
      if(pipe(fds) < 0){
     3b6:	f9840513          	add	a0,s0,-104
     3ba:	221000ef          	jal	dda <pipe>
     3be:	02054363          	bltz	a0,3e4 <go+0x370>
        printf("grind: pipe failed\n");
        exit(1);
      }
      int pid = fork();
     3c2:	201000ef          	jal	dc2 <fork>
      if(pid == 0){
     3c6:	c905                	beqz	a0,3f6 <go+0x382>
          printf("grind: pipe write failed\n");
        char c;
        if(read(fds[0], &c, 1) != 1)
          printf("grind: pipe read failed\n");
        exit(0);
      } else if(pid < 0){
     3c8:	08054263          	bltz	a0,44c <go+0x3d8>
        printf("grind: fork failed\n");
        exit(1);
      }
      close(fds[0]);
     3cc:	f9842503          	lw	a0,-104(s0)
     3d0:	223000ef          	jal	df2 <close>
      close(fds[1]);
     3d4:	f9c42503          	lw	a0,-100(s0)
     3d8:	21b000ef          	jal	df2 <close>
      wait(0);
     3dc:	4501                	li	a0,0
     3de:	1f5000ef          	jal	dd2 <wait>
     3e2:	b325                	j	10a <go+0x96>
        printf("grind: pipe failed\n");
     3e4:	00001517          	auipc	a0,0x1
     3e8:	16450513          	add	a0,a0,356 # 1548 <malloc+0x250>
     3ec:	651000ef          	jal	123c <printf>
        exit(1);
     3f0:	4505                	li	a0,1
     3f2:	1d9000ef          	jal	dca <exit>
        fork();
     3f6:	1cd000ef          	jal	dc2 <fork>
        fork();
     3fa:	1c9000ef          	jal	dc2 <fork>
        if(write(fds[1], "x", 1) != 1)
     3fe:	4605                	li	a2,1
     400:	00001597          	auipc	a1,0x1
     404:	16058593          	add	a1,a1,352 # 1560 <malloc+0x268>
     408:	f9c42503          	lw	a0,-100(s0)
     40c:	1df000ef          	jal	dea <write>
     410:	4785                	li	a5,1
     412:	00f51f63          	bne	a0,a5,430 <go+0x3bc>
        if(read(fds[0], &c, 1) != 1)
     416:	4605                	li	a2,1
     418:	f9040593          	add	a1,s0,-112
     41c:	f9842503          	lw	a0,-104(s0)
     420:	1c3000ef          	jal	de2 <read>
     424:	4785                	li	a5,1
     426:	00f51c63          	bne	a0,a5,43e <go+0x3ca>
        exit(0);
     42a:	4501                	li	a0,0
     42c:	19f000ef          	jal	dca <exit>
          printf("grind: pipe write failed\n");
     430:	00001517          	auipc	a0,0x1
     434:	13850513          	add	a0,a0,312 # 1568 <malloc+0x270>
     438:	605000ef          	jal	123c <printf>
     43c:	bfe9                	j	416 <go+0x3a2>
          printf("grind: pipe read failed\n");
     43e:	00001517          	auipc	a0,0x1
     442:	14a50513          	add	a0,a0,330 # 1588 <malloc+0x290>
     446:	5f7000ef          	jal	123c <printf>
     44a:	b7c5                	j	42a <go+0x3b6>
        printf("grind: fork failed\n");
     44c:	00001517          	auipc	a0,0x1
     450:	0b450513          	add	a0,a0,180 # 1500 <malloc+0x208>
     454:	5e9000ef          	jal	123c <printf>
        exit(1);
     458:	4505                	li	a0,1
     45a:	171000ef          	jal	dca <exit>
    } else if(what == 20){
      int pid = fork();
     45e:	165000ef          	jal	dc2 <fork>
      if(pid == 0){
     462:	c519                	beqz	a0,470 <go+0x3fc>
        chdir("a");
        unlink("../a");
        fd = open("x", O_CREATE|O_RDWR);
        unlink("x");
        exit(0);
      } else if(pid < 0){
     464:	04054f63          	bltz	a0,4c2 <go+0x44e>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     468:	4501                	li	a0,0
     46a:	169000ef          	jal	dd2 <wait>
     46e:	b971                	j	10a <go+0x96>
        unlink("a");
     470:	00001517          	auipc	a0,0x1
     474:	0a850513          	add	a0,a0,168 # 1518 <malloc+0x220>
     478:	1a3000ef          	jal	e1a <unlink>
        mkdir("a");
     47c:	00001517          	auipc	a0,0x1
     480:	09c50513          	add	a0,a0,156 # 1518 <malloc+0x220>
     484:	1af000ef          	jal	e32 <mkdir>
        chdir("a");
     488:	00001517          	auipc	a0,0x1
     48c:	09050513          	add	a0,a0,144 # 1518 <malloc+0x220>
     490:	1ab000ef          	jal	e3a <chdir>
        unlink("../a");
     494:	00001517          	auipc	a0,0x1
     498:	11450513          	add	a0,a0,276 # 15a8 <malloc+0x2b0>
     49c:	17f000ef          	jal	e1a <unlink>
        fd = open("x", O_CREATE|O_RDWR);
     4a0:	20200593          	li	a1,514
     4a4:	00001517          	auipc	a0,0x1
     4a8:	0bc50513          	add	a0,a0,188 # 1560 <malloc+0x268>
     4ac:	15f000ef          	jal	e0a <open>
        unlink("x");
     4b0:	00001517          	auipc	a0,0x1
     4b4:	0b050513          	add	a0,a0,176 # 1560 <malloc+0x268>
     4b8:	163000ef          	jal	e1a <unlink>
        exit(0);
     4bc:	4501                	li	a0,0
     4be:	10d000ef          	jal	dca <exit>
        printf("grind: fork failed\n");
     4c2:	00001517          	auipc	a0,0x1
     4c6:	03e50513          	add	a0,a0,62 # 1500 <malloc+0x208>
     4ca:	573000ef          	jal	123c <printf>
        exit(1);
     4ce:	4505                	li	a0,1
     4d0:	0fb000ef          	jal	dca <exit>
    } else if(what == 21){
      unlink("c");
     4d4:	00001517          	auipc	a0,0x1
     4d8:	0dc50513          	add	a0,a0,220 # 15b0 <malloc+0x2b8>
     4dc:	13f000ef          	jal	e1a <unlink>
      // should always succeed. check that there are free i-nodes,
      // file descriptors, blocks.
      int fd1 = open("c", O_CREATE|O_RDWR);
     4e0:	20200593          	li	a1,514
     4e4:	00001517          	auipc	a0,0x1
     4e8:	0cc50513          	add	a0,a0,204 # 15b0 <malloc+0x2b8>
     4ec:	11f000ef          	jal	e0a <open>
     4f0:	8b2a                	mv	s6,a0
      if(fd1 < 0){
     4f2:	04054763          	bltz	a0,540 <go+0x4cc>
        printf("grind: create c failed\n");
        exit(1);
      }
      if(write(fd1, "x", 1) != 1){
     4f6:	4605                	li	a2,1
     4f8:	00001597          	auipc	a1,0x1
     4fc:	06858593          	add	a1,a1,104 # 1560 <malloc+0x268>
     500:	0eb000ef          	jal	dea <write>
     504:	4785                	li	a5,1
     506:	04f51663          	bne	a0,a5,552 <go+0x4de>
        printf("grind: write c failed\n");
        exit(1);
      }
      struct stat st;
      if(fstat(fd1, &st) != 0){
     50a:	f9840593          	add	a1,s0,-104
     50e:	855a                	mv	a0,s6
     510:	113000ef          	jal	e22 <fstat>
     514:	e921                	bnez	a0,564 <go+0x4f0>
        printf("grind: fstat failed\n");
        exit(1);
      }
      if(st.size != 1){
     516:	fa843583          	ld	a1,-88(s0)
     51a:	4785                	li	a5,1
     51c:	04f59d63          	bne	a1,a5,576 <go+0x502>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
        exit(1);
      }
      if(st.ino > 200){
     520:	f9c42583          	lw	a1,-100(s0)
     524:	0c800793          	li	a5,200
     528:	06b7e163          	bltu	a5,a1,58a <go+0x516>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
        exit(1);
      }
      close(fd1);
     52c:	855a                	mv	a0,s6
     52e:	0c5000ef          	jal	df2 <close>
      unlink("c");
     532:	00001517          	auipc	a0,0x1
     536:	07e50513          	add	a0,a0,126 # 15b0 <malloc+0x2b8>
     53a:	0e1000ef          	jal	e1a <unlink>
     53e:	b6f1                	j	10a <go+0x96>
        printf("grind: create c failed\n");
     540:	00001517          	auipc	a0,0x1
     544:	07850513          	add	a0,a0,120 # 15b8 <malloc+0x2c0>
     548:	4f5000ef          	jal	123c <printf>
        exit(1);
     54c:	4505                	li	a0,1
     54e:	07d000ef          	jal	dca <exit>
        printf("grind: write c failed\n");
     552:	00001517          	auipc	a0,0x1
     556:	07e50513          	add	a0,a0,126 # 15d0 <malloc+0x2d8>
     55a:	4e3000ef          	jal	123c <printf>
        exit(1);
     55e:	4505                	li	a0,1
     560:	06b000ef          	jal	dca <exit>
        printf("grind: fstat failed\n");
     564:	00001517          	auipc	a0,0x1
     568:	08450513          	add	a0,a0,132 # 15e8 <malloc+0x2f0>
     56c:	4d1000ef          	jal	123c <printf>
        exit(1);
     570:	4505                	li	a0,1
     572:	059000ef          	jal	dca <exit>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
     576:	2581                	sext.w	a1,a1
     578:	00001517          	auipc	a0,0x1
     57c:	08850513          	add	a0,a0,136 # 1600 <malloc+0x308>
     580:	4bd000ef          	jal	123c <printf>
        exit(1);
     584:	4505                	li	a0,1
     586:	045000ef          	jal	dca <exit>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
     58a:	00001517          	auipc	a0,0x1
     58e:	09e50513          	add	a0,a0,158 # 1628 <malloc+0x330>
     592:	4ab000ef          	jal	123c <printf>
        exit(1);
     596:	4505                	li	a0,1
     598:	033000ef          	jal	dca <exit>
    } else if(what == 22){
      // echo hi | cat
      int aa[2], bb[2];
      if(pipe(aa) < 0){
     59c:	f8840513          	add	a0,s0,-120
     5a0:	03b000ef          	jal	dda <pipe>
     5a4:	0a054563          	bltz	a0,64e <go+0x5da>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      if(pipe(bb) < 0){
     5a8:	f9040513          	add	a0,s0,-112
     5ac:	02f000ef          	jal	dda <pipe>
     5b0:	0a054963          	bltz	a0,662 <go+0x5ee>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      int pid1 = fork();
     5b4:	00f000ef          	jal	dc2 <fork>
      if(pid1 == 0){
     5b8:	cd5d                	beqz	a0,676 <go+0x602>
        close(aa[1]);
        char *args[3] = { "echo", "hi", 0 };
        exec("grindir/../echo", args);
        fprintf(2, "grind: echo: not found\n");
        exit(2);
      } else if(pid1 < 0){
     5ba:	14054263          	bltz	a0,6fe <go+0x68a>
        fprintf(2, "grind: fork failed\n");
        exit(3);
      }
      int pid2 = fork();
     5be:	005000ef          	jal	dc2 <fork>
      if(pid2 == 0){
     5c2:	14050863          	beqz	a0,712 <go+0x69e>
        close(bb[1]);
        char *args[2] = { "cat", 0 };
        exec("/cat", args);
        fprintf(2, "grind: cat: not found\n");
        exit(6);
      } else if(pid2 < 0){
     5c6:	1e054663          	bltz	a0,7b2 <go+0x73e>
        fprintf(2, "grind: fork failed\n");
        exit(7);
      }
      close(aa[0]);
     5ca:	f8842503          	lw	a0,-120(s0)
     5ce:	025000ef          	jal	df2 <close>
      close(aa[1]);
     5d2:	f8c42503          	lw	a0,-116(s0)
     5d6:	01d000ef          	jal	df2 <close>
      close(bb[1]);
     5da:	f9442503          	lw	a0,-108(s0)
     5de:	015000ef          	jal	df2 <close>
      char buf[4] = { 0, 0, 0, 0 };
     5e2:	f8042023          	sw	zero,-128(s0)
      read(bb[0], buf+0, 1);
     5e6:	4605                	li	a2,1
     5e8:	f8040593          	add	a1,s0,-128
     5ec:	f9042503          	lw	a0,-112(s0)
     5f0:	7f2000ef          	jal	de2 <read>
      read(bb[0], buf+1, 1);
     5f4:	4605                	li	a2,1
     5f6:	f8140593          	add	a1,s0,-127
     5fa:	f9042503          	lw	a0,-112(s0)
     5fe:	7e4000ef          	jal	de2 <read>
      read(bb[0], buf+2, 1);
     602:	4605                	li	a2,1
     604:	f8240593          	add	a1,s0,-126
     608:	f9042503          	lw	a0,-112(s0)
     60c:	7d6000ef          	jal	de2 <read>
      close(bb[0]);
     610:	f9042503          	lw	a0,-112(s0)
     614:	7de000ef          	jal	df2 <close>
      int st1, st2;
      wait(&st1);
     618:	f8440513          	add	a0,s0,-124
     61c:	7b6000ef          	jal	dd2 <wait>
      wait(&st2);
     620:	f9840513          	add	a0,s0,-104
     624:	7ae000ef          	jal	dd2 <wait>
      if(st1 != 0 || st2 != 0 || strcmp(buf, "hi\n") != 0){
     628:	f8442783          	lw	a5,-124(s0)
     62c:	f9842b83          	lw	s7,-104(s0)
     630:	0177eb33          	or	s6,a5,s7
     634:	180b1963          	bnez	s6,7c6 <go+0x752>
     638:	00001597          	auipc	a1,0x1
     63c:	09058593          	add	a1,a1,144 # 16c8 <malloc+0x3d0>
     640:	f8040513          	add	a0,s0,-128
     644:	2ce000ef          	jal	912 <strcmp>
     648:	ac0501e3          	beqz	a0,10a <go+0x96>
     64c:	aab5                	j	7c8 <go+0x754>
        fprintf(2, "grind: pipe failed\n");
     64e:	00001597          	auipc	a1,0x1
     652:	efa58593          	add	a1,a1,-262 # 1548 <malloc+0x250>
     656:	4509                	li	a0,2
     658:	3bb000ef          	jal	1212 <fprintf>
        exit(1);
     65c:	4505                	li	a0,1
     65e:	76c000ef          	jal	dca <exit>
        fprintf(2, "grind: pipe failed\n");
     662:	00001597          	auipc	a1,0x1
     666:	ee658593          	add	a1,a1,-282 # 1548 <malloc+0x250>
     66a:	4509                	li	a0,2
     66c:	3a7000ef          	jal	1212 <fprintf>
        exit(1);
     670:	4505                	li	a0,1
     672:	758000ef          	jal	dca <exit>
        close(bb[0]);
     676:	f9042503          	lw	a0,-112(s0)
     67a:	778000ef          	jal	df2 <close>
        close(bb[1]);
     67e:	f9442503          	lw	a0,-108(s0)
     682:	770000ef          	jal	df2 <close>
        close(aa[0]);
     686:	f8842503          	lw	a0,-120(s0)
     68a:	768000ef          	jal	df2 <close>
        close(1);
     68e:	4505                	li	a0,1
     690:	762000ef          	jal	df2 <close>
        if(dup(aa[1]) != 1){
     694:	f8c42503          	lw	a0,-116(s0)
     698:	7aa000ef          	jal	e42 <dup>
     69c:	4785                	li	a5,1
     69e:	00f50c63          	beq	a0,a5,6b6 <go+0x642>
          fprintf(2, "grind: dup failed\n");
     6a2:	00001597          	auipc	a1,0x1
     6a6:	fae58593          	add	a1,a1,-82 # 1650 <malloc+0x358>
     6aa:	4509                	li	a0,2
     6ac:	367000ef          	jal	1212 <fprintf>
          exit(1);
     6b0:	4505                	li	a0,1
     6b2:	718000ef          	jal	dca <exit>
        close(aa[1]);
     6b6:	f8c42503          	lw	a0,-116(s0)
     6ba:	738000ef          	jal	df2 <close>
        char *args[3] = { "echo", "hi", 0 };
     6be:	00001797          	auipc	a5,0x1
     6c2:	faa78793          	add	a5,a5,-86 # 1668 <malloc+0x370>
     6c6:	f8f43c23          	sd	a5,-104(s0)
     6ca:	00001797          	auipc	a5,0x1
     6ce:	fa678793          	add	a5,a5,-90 # 1670 <malloc+0x378>
     6d2:	faf43023          	sd	a5,-96(s0)
     6d6:	fa043423          	sd	zero,-88(s0)
        exec("grindir/../echo", args);
     6da:	f9840593          	add	a1,s0,-104
     6de:	00001517          	auipc	a0,0x1
     6e2:	f9a50513          	add	a0,a0,-102 # 1678 <malloc+0x380>
     6e6:	71c000ef          	jal	e02 <exec>
        fprintf(2, "grind: echo: not found\n");
     6ea:	00001597          	auipc	a1,0x1
     6ee:	f9e58593          	add	a1,a1,-98 # 1688 <malloc+0x390>
     6f2:	4509                	li	a0,2
     6f4:	31f000ef          	jal	1212 <fprintf>
        exit(2);
     6f8:	4509                	li	a0,2
     6fa:	6d0000ef          	jal	dca <exit>
        fprintf(2, "grind: fork failed\n");
     6fe:	00001597          	auipc	a1,0x1
     702:	e0258593          	add	a1,a1,-510 # 1500 <malloc+0x208>
     706:	4509                	li	a0,2
     708:	30b000ef          	jal	1212 <fprintf>
        exit(3);
     70c:	450d                	li	a0,3
     70e:	6bc000ef          	jal	dca <exit>
        close(aa[1]);
     712:	f8c42503          	lw	a0,-116(s0)
     716:	6dc000ef          	jal	df2 <close>
        close(bb[0]);
     71a:	f9042503          	lw	a0,-112(s0)
     71e:	6d4000ef          	jal	df2 <close>
        close(0);
     722:	4501                	li	a0,0
     724:	6ce000ef          	jal	df2 <close>
        if(dup(aa[0]) != 0){
     728:	f8842503          	lw	a0,-120(s0)
     72c:	716000ef          	jal	e42 <dup>
     730:	c919                	beqz	a0,746 <go+0x6d2>
          fprintf(2, "grind: dup failed\n");
     732:	00001597          	auipc	a1,0x1
     736:	f1e58593          	add	a1,a1,-226 # 1650 <malloc+0x358>
     73a:	4509                	li	a0,2
     73c:	2d7000ef          	jal	1212 <fprintf>
          exit(4);
     740:	4511                	li	a0,4
     742:	688000ef          	jal	dca <exit>
        close(aa[0]);
     746:	f8842503          	lw	a0,-120(s0)
     74a:	6a8000ef          	jal	df2 <close>
        close(1);
     74e:	4505                	li	a0,1
     750:	6a2000ef          	jal	df2 <close>
        if(dup(bb[1]) != 1){
     754:	f9442503          	lw	a0,-108(s0)
     758:	6ea000ef          	jal	e42 <dup>
     75c:	4785                	li	a5,1
     75e:	00f50c63          	beq	a0,a5,776 <go+0x702>
          fprintf(2, "grind: dup failed\n");
     762:	00001597          	auipc	a1,0x1
     766:	eee58593          	add	a1,a1,-274 # 1650 <malloc+0x358>
     76a:	4509                	li	a0,2
     76c:	2a7000ef          	jal	1212 <fprintf>
          exit(5);
     770:	4515                	li	a0,5
     772:	658000ef          	jal	dca <exit>
        close(bb[1]);
     776:	f9442503          	lw	a0,-108(s0)
     77a:	678000ef          	jal	df2 <close>
        char *args[2] = { "cat", 0 };
     77e:	00001797          	auipc	a5,0x1
     782:	f2278793          	add	a5,a5,-222 # 16a0 <malloc+0x3a8>
     786:	f8f43c23          	sd	a5,-104(s0)
     78a:	fa043023          	sd	zero,-96(s0)
        exec("/cat", args);
     78e:	f9840593          	add	a1,s0,-104
     792:	00001517          	auipc	a0,0x1
     796:	f1650513          	add	a0,a0,-234 # 16a8 <malloc+0x3b0>
     79a:	668000ef          	jal	e02 <exec>
        fprintf(2, "grind: cat: not found\n");
     79e:	00001597          	auipc	a1,0x1
     7a2:	f1258593          	add	a1,a1,-238 # 16b0 <malloc+0x3b8>
     7a6:	4509                	li	a0,2
     7a8:	26b000ef          	jal	1212 <fprintf>
        exit(6);
     7ac:	4519                	li	a0,6
     7ae:	61c000ef          	jal	dca <exit>
        fprintf(2, "grind: fork failed\n");
     7b2:	00001597          	auipc	a1,0x1
     7b6:	d4e58593          	add	a1,a1,-690 # 1500 <malloc+0x208>
     7ba:	4509                	li	a0,2
     7bc:	257000ef          	jal	1212 <fprintf>
        exit(7);
     7c0:	451d                	li	a0,7
     7c2:	608000ef          	jal	dca <exit>
     7c6:	8b3e                	mv	s6,a5
        printf("grind: exec pipeline failed %d %d \"%s\"\n", st1, st2, buf);
     7c8:	f8040693          	add	a3,s0,-128
     7cc:	865e                	mv	a2,s7
     7ce:	85da                	mv	a1,s6
     7d0:	00001517          	auipc	a0,0x1
     7d4:	f0050513          	add	a0,a0,-256 # 16d0 <malloc+0x3d8>
     7d8:	265000ef          	jal	123c <printf>
        exit(1);
     7dc:	4505                	li	a0,1
     7de:	5ec000ef          	jal	dca <exit>

00000000000007e2 <iter>:
  }
}

void
iter()
{
     7e2:	7179                	add	sp,sp,-48
     7e4:	f406                	sd	ra,40(sp)
     7e6:	f022                	sd	s0,32(sp)
     7e8:	1800                	add	s0,sp,48
  unlink("a");
     7ea:	00001517          	auipc	a0,0x1
     7ee:	d2e50513          	add	a0,a0,-722 # 1518 <malloc+0x220>
     7f2:	628000ef          	jal	e1a <unlink>
  unlink("b");
     7f6:	00001517          	auipc	a0,0x1
     7fa:	cd250513          	add	a0,a0,-814 # 14c8 <malloc+0x1d0>
     7fe:	61c000ef          	jal	e1a <unlink>
  
  int pid1 = fork();
     802:	5c0000ef          	jal	dc2 <fork>
  if(pid1 < 0){
     806:	02054163          	bltz	a0,828 <iter+0x46>
     80a:	ec26                	sd	s1,24(sp)
     80c:	84aa                	mv	s1,a0
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid1 == 0){
     80e:	e905                	bnez	a0,83e <iter+0x5c>
     810:	e84a                	sd	s2,16(sp)
    rand_next ^= 31;
     812:	00001717          	auipc	a4,0x1
     816:	7ee70713          	add	a4,a4,2030 # 2000 <rand_next>
     81a:	631c                	ld	a5,0(a4)
     81c:	01f7c793          	xor	a5,a5,31
     820:	e31c                	sd	a5,0(a4)
    go(0);
     822:	4501                	li	a0,0
     824:	851ff0ef          	jal	74 <go>
     828:	ec26                	sd	s1,24(sp)
     82a:	e84a                	sd	s2,16(sp)
    printf("grind: fork failed\n");
     82c:	00001517          	auipc	a0,0x1
     830:	cd450513          	add	a0,a0,-812 # 1500 <malloc+0x208>
     834:	209000ef          	jal	123c <printf>
    exit(1);
     838:	4505                	li	a0,1
     83a:	590000ef          	jal	dca <exit>
     83e:	e84a                	sd	s2,16(sp)
    exit(0);
  }

  int pid2 = fork();
     840:	582000ef          	jal	dc2 <fork>
     844:	892a                	mv	s2,a0
  if(pid2 < 0){
     846:	02054063          	bltz	a0,866 <iter+0x84>
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid2 == 0){
     84a:	e51d                	bnez	a0,878 <iter+0x96>
    rand_next ^= 7177;
     84c:	00001697          	auipc	a3,0x1
     850:	7b468693          	add	a3,a3,1972 # 2000 <rand_next>
     854:	629c                	ld	a5,0(a3)
     856:	6709                	lui	a4,0x2
     858:	c0970713          	add	a4,a4,-1015 # 1c09 <digits+0x4a9>
     85c:	8fb9                	xor	a5,a5,a4
     85e:	e29c                	sd	a5,0(a3)
    go(1);
     860:	4505                	li	a0,1
     862:	813ff0ef          	jal	74 <go>
    printf("grind: fork failed\n");
     866:	00001517          	auipc	a0,0x1
     86a:	c9a50513          	add	a0,a0,-870 # 1500 <malloc+0x208>
     86e:	1cf000ef          	jal	123c <printf>
    exit(1);
     872:	4505                	li	a0,1
     874:	556000ef          	jal	dca <exit>
    exit(0);
  }

  int st1 = -1;
     878:	57fd                	li	a5,-1
     87a:	fcf42e23          	sw	a5,-36(s0)
  wait(&st1);
     87e:	fdc40513          	add	a0,s0,-36
     882:	550000ef          	jal	dd2 <wait>
  if(st1 != 0){
     886:	fdc42783          	lw	a5,-36(s0)
     88a:	eb99                	bnez	a5,8a0 <iter+0xbe>
    kill(pid1);
    kill(pid2);
  }
  int st2 = -1;
     88c:	57fd                	li	a5,-1
     88e:	fcf42c23          	sw	a5,-40(s0)
  wait(&st2);
     892:	fd840513          	add	a0,s0,-40
     896:	53c000ef          	jal	dd2 <wait>

  exit(0);
     89a:	4501                	li	a0,0
     89c:	52e000ef          	jal	dca <exit>
    kill(pid1);
     8a0:	8526                	mv	a0,s1
     8a2:	558000ef          	jal	dfa <kill>
    kill(pid2);
     8a6:	854a                	mv	a0,s2
     8a8:	552000ef          	jal	dfa <kill>
     8ac:	b7c5                	j	88c <iter+0xaa>

00000000000008ae <main>:
}

int
main()
{
     8ae:	1101                	add	sp,sp,-32
     8b0:	ec06                	sd	ra,24(sp)
     8b2:	e822                	sd	s0,16(sp)
     8b4:	e426                	sd	s1,8(sp)
     8b6:	1000                	add	s0,sp,32
    }
    if(pid > 0){
      wait(0);
    }
    sleep(20);
    rand_next += 1;
     8b8:	00001497          	auipc	s1,0x1
     8bc:	74848493          	add	s1,s1,1864 # 2000 <rand_next>
     8c0:	a809                	j	8d2 <main+0x24>
      iter();
     8c2:	f21ff0ef          	jal	7e2 <iter>
    sleep(20);
     8c6:	4551                	li	a0,20
     8c8:	592000ef          	jal	e5a <sleep>
    rand_next += 1;
     8cc:	609c                	ld	a5,0(s1)
     8ce:	0785                	add	a5,a5,1
     8d0:	e09c                	sd	a5,0(s1)
    int pid = fork();
     8d2:	4f0000ef          	jal	dc2 <fork>
    if(pid == 0){
     8d6:	d575                	beqz	a0,8c2 <main+0x14>
    if(pid > 0){
     8d8:	fea057e3          	blez	a0,8c6 <main+0x18>
      wait(0);
     8dc:	4501                	li	a0,0
     8de:	4f4000ef          	jal	dd2 <wait>
     8e2:	b7d5                	j	8c6 <main+0x18>

00000000000008e4 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
     8e4:	1141                	add	sp,sp,-16
     8e6:	e406                	sd	ra,8(sp)
     8e8:	e022                	sd	s0,0(sp)
     8ea:	0800                	add	s0,sp,16
  extern int main();
  main();
     8ec:	fc3ff0ef          	jal	8ae <main>
  exit(0);
     8f0:	4501                	li	a0,0
     8f2:	4d8000ef          	jal	dca <exit>

00000000000008f6 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     8f6:	1141                	add	sp,sp,-16
     8f8:	e422                	sd	s0,8(sp)
     8fa:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     8fc:	87aa                	mv	a5,a0
     8fe:	0585                	add	a1,a1,1
     900:	0785                	add	a5,a5,1
     902:	fff5c703          	lbu	a4,-1(a1)
     906:	fee78fa3          	sb	a4,-1(a5)
     90a:	fb75                	bnez	a4,8fe <strcpy+0x8>
    ;
  return os;
}
     90c:	6422                	ld	s0,8(sp)
     90e:	0141                	add	sp,sp,16
     910:	8082                	ret

0000000000000912 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     912:	1141                	add	sp,sp,-16
     914:	e422                	sd	s0,8(sp)
     916:	0800                	add	s0,sp,16
  while(*p && *p == *q)
     918:	00054783          	lbu	a5,0(a0)
     91c:	cb91                	beqz	a5,930 <strcmp+0x1e>
     91e:	0005c703          	lbu	a4,0(a1)
     922:	00f71763          	bne	a4,a5,930 <strcmp+0x1e>
    p++, q++;
     926:	0505                	add	a0,a0,1
     928:	0585                	add	a1,a1,1
  while(*p && *p == *q)
     92a:	00054783          	lbu	a5,0(a0)
     92e:	fbe5                	bnez	a5,91e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     930:	0005c503          	lbu	a0,0(a1)
}
     934:	40a7853b          	subw	a0,a5,a0
     938:	6422                	ld	s0,8(sp)
     93a:	0141                	add	sp,sp,16
     93c:	8082                	ret

000000000000093e <strlen>:

uint
strlen(const char *s)
{
     93e:	1141                	add	sp,sp,-16
     940:	e422                	sd	s0,8(sp)
     942:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     944:	00054783          	lbu	a5,0(a0)
     948:	cf91                	beqz	a5,964 <strlen+0x26>
     94a:	0505                	add	a0,a0,1
     94c:	87aa                	mv	a5,a0
     94e:	86be                	mv	a3,a5
     950:	0785                	add	a5,a5,1
     952:	fff7c703          	lbu	a4,-1(a5)
     956:	ff65                	bnez	a4,94e <strlen+0x10>
     958:	40a6853b          	subw	a0,a3,a0
     95c:	2505                	addw	a0,a0,1
    ;
  return n;
}
     95e:	6422                	ld	s0,8(sp)
     960:	0141                	add	sp,sp,16
     962:	8082                	ret
  for(n = 0; s[n]; n++)
     964:	4501                	li	a0,0
     966:	bfe5                	j	95e <strlen+0x20>

0000000000000968 <memset>:

void*
memset(void *dst, int c, uint n)
{
     968:	1141                	add	sp,sp,-16
     96a:	e422                	sd	s0,8(sp)
     96c:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     96e:	ca19                	beqz	a2,984 <memset+0x1c>
     970:	87aa                	mv	a5,a0
     972:	1602                	sll	a2,a2,0x20
     974:	9201                	srl	a2,a2,0x20
     976:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     97a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     97e:	0785                	add	a5,a5,1
     980:	fee79de3          	bne	a5,a4,97a <memset+0x12>
  }
  return dst;
}
     984:	6422                	ld	s0,8(sp)
     986:	0141                	add	sp,sp,16
     988:	8082                	ret

000000000000098a <strchr>:

char*
strchr(const char *s, char c)
{
     98a:	1141                	add	sp,sp,-16
     98c:	e422                	sd	s0,8(sp)
     98e:	0800                	add	s0,sp,16
  for(; *s; s++)
     990:	00054783          	lbu	a5,0(a0)
     994:	cb99                	beqz	a5,9aa <strchr+0x20>
    if(*s == c)
     996:	00f58763          	beq	a1,a5,9a4 <strchr+0x1a>
  for(; *s; s++)
     99a:	0505                	add	a0,a0,1
     99c:	00054783          	lbu	a5,0(a0)
     9a0:	fbfd                	bnez	a5,996 <strchr+0xc>
      return (char*)s;
  return 0;
     9a2:	4501                	li	a0,0
}
     9a4:	6422                	ld	s0,8(sp)
     9a6:	0141                	add	sp,sp,16
     9a8:	8082                	ret
  return 0;
     9aa:	4501                	li	a0,0
     9ac:	bfe5                	j	9a4 <strchr+0x1a>

00000000000009ae <gets>:

char*
gets(char *buf, int max)
{
     9ae:	711d                	add	sp,sp,-96
     9b0:	ec86                	sd	ra,88(sp)
     9b2:	e8a2                	sd	s0,80(sp)
     9b4:	e4a6                	sd	s1,72(sp)
     9b6:	e0ca                	sd	s2,64(sp)
     9b8:	fc4e                	sd	s3,56(sp)
     9ba:	f852                	sd	s4,48(sp)
     9bc:	f456                	sd	s5,40(sp)
     9be:	f05a                	sd	s6,32(sp)
     9c0:	ec5e                	sd	s7,24(sp)
     9c2:	1080                	add	s0,sp,96
     9c4:	8baa                	mv	s7,a0
     9c6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     9c8:	892a                	mv	s2,a0
     9ca:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     9cc:	4aa9                	li	s5,10
     9ce:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     9d0:	89a6                	mv	s3,s1
     9d2:	2485                	addw	s1,s1,1
     9d4:	0344d663          	bge	s1,s4,a00 <gets+0x52>
    cc = read(0, &c, 1);
     9d8:	4605                	li	a2,1
     9da:	faf40593          	add	a1,s0,-81
     9de:	4501                	li	a0,0
     9e0:	402000ef          	jal	de2 <read>
    if(cc < 1)
     9e4:	00a05e63          	blez	a0,a00 <gets+0x52>
    buf[i++] = c;
     9e8:	faf44783          	lbu	a5,-81(s0)
     9ec:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     9f0:	01578763          	beq	a5,s5,9fe <gets+0x50>
     9f4:	0905                	add	s2,s2,1
     9f6:	fd679de3          	bne	a5,s6,9d0 <gets+0x22>
    buf[i++] = c;
     9fa:	89a6                	mv	s3,s1
     9fc:	a011                	j	a00 <gets+0x52>
     9fe:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     a00:	99de                	add	s3,s3,s7
     a02:	00098023          	sb	zero,0(s3)
  return buf;
}
     a06:	855e                	mv	a0,s7
     a08:	60e6                	ld	ra,88(sp)
     a0a:	6446                	ld	s0,80(sp)
     a0c:	64a6                	ld	s1,72(sp)
     a0e:	6906                	ld	s2,64(sp)
     a10:	79e2                	ld	s3,56(sp)
     a12:	7a42                	ld	s4,48(sp)
     a14:	7aa2                	ld	s5,40(sp)
     a16:	7b02                	ld	s6,32(sp)
     a18:	6be2                	ld	s7,24(sp)
     a1a:	6125                	add	sp,sp,96
     a1c:	8082                	ret

0000000000000a1e <stat>:

int
stat(const char *n, struct stat *st)
{
     a1e:	1101                	add	sp,sp,-32
     a20:	ec06                	sd	ra,24(sp)
     a22:	e822                	sd	s0,16(sp)
     a24:	e04a                	sd	s2,0(sp)
     a26:	1000                	add	s0,sp,32
     a28:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     a2a:	4581                	li	a1,0
     a2c:	3de000ef          	jal	e0a <open>
  if(fd < 0)
     a30:	02054263          	bltz	a0,a54 <stat+0x36>
     a34:	e426                	sd	s1,8(sp)
     a36:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     a38:	85ca                	mv	a1,s2
     a3a:	3e8000ef          	jal	e22 <fstat>
     a3e:	892a                	mv	s2,a0
  close(fd);
     a40:	8526                	mv	a0,s1
     a42:	3b0000ef          	jal	df2 <close>
  return r;
     a46:	64a2                	ld	s1,8(sp)
}
     a48:	854a                	mv	a0,s2
     a4a:	60e2                	ld	ra,24(sp)
     a4c:	6442                	ld	s0,16(sp)
     a4e:	6902                	ld	s2,0(sp)
     a50:	6105                	add	sp,sp,32
     a52:	8082                	ret
    return -1;
     a54:	597d                	li	s2,-1
     a56:	bfcd                	j	a48 <stat+0x2a>

0000000000000a58 <atoi>:

int
atoi(const char *s)
{
     a58:	1141                	add	sp,sp,-16
     a5a:	e422                	sd	s0,8(sp)
     a5c:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     a5e:	00054683          	lbu	a3,0(a0)
     a62:	fd06879b          	addw	a5,a3,-48
     a66:	0ff7f793          	zext.b	a5,a5
     a6a:	4625                	li	a2,9
     a6c:	02f66863          	bltu	a2,a5,a9c <atoi+0x44>
     a70:	872a                	mv	a4,a0
  n = 0;
     a72:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
     a74:	0705                	add	a4,a4,1
     a76:	0025179b          	sllw	a5,a0,0x2
     a7a:	9fa9                	addw	a5,a5,a0
     a7c:	0017979b          	sllw	a5,a5,0x1
     a80:	9fb5                	addw	a5,a5,a3
     a82:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     a86:	00074683          	lbu	a3,0(a4)
     a8a:	fd06879b          	addw	a5,a3,-48
     a8e:	0ff7f793          	zext.b	a5,a5
     a92:	fef671e3          	bgeu	a2,a5,a74 <atoi+0x1c>
  return n;
}
     a96:	6422                	ld	s0,8(sp)
     a98:	0141                	add	sp,sp,16
     a9a:	8082                	ret
  n = 0;
     a9c:	4501                	li	a0,0
     a9e:	bfe5                	j	a96 <atoi+0x3e>

0000000000000aa0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     aa0:	1141                	add	sp,sp,-16
     aa2:	e422                	sd	s0,8(sp)
     aa4:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     aa6:	02b57463          	bgeu	a0,a1,ace <memmove+0x2e>
    while(n-- > 0)
     aaa:	00c05f63          	blez	a2,ac8 <memmove+0x28>
     aae:	1602                	sll	a2,a2,0x20
     ab0:	9201                	srl	a2,a2,0x20
     ab2:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     ab6:	872a                	mv	a4,a0
      *dst++ = *src++;
     ab8:	0585                	add	a1,a1,1
     aba:	0705                	add	a4,a4,1
     abc:	fff5c683          	lbu	a3,-1(a1)
     ac0:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     ac4:	fef71ae3          	bne	a4,a5,ab8 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     ac8:	6422                	ld	s0,8(sp)
     aca:	0141                	add	sp,sp,16
     acc:	8082                	ret
    dst += n;
     ace:	00c50733          	add	a4,a0,a2
    src += n;
     ad2:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     ad4:	fec05ae3          	blez	a2,ac8 <memmove+0x28>
     ad8:	fff6079b          	addw	a5,a2,-1
     adc:	1782                	sll	a5,a5,0x20
     ade:	9381                	srl	a5,a5,0x20
     ae0:	fff7c793          	not	a5,a5
     ae4:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     ae6:	15fd                	add	a1,a1,-1
     ae8:	177d                	add	a4,a4,-1
     aea:	0005c683          	lbu	a3,0(a1)
     aee:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     af2:	fee79ae3          	bne	a5,a4,ae6 <memmove+0x46>
     af6:	bfc9                	j	ac8 <memmove+0x28>

0000000000000af8 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     af8:	1141                	add	sp,sp,-16
     afa:	e422                	sd	s0,8(sp)
     afc:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     afe:	ca05                	beqz	a2,b2e <memcmp+0x36>
     b00:	fff6069b          	addw	a3,a2,-1
     b04:	1682                	sll	a3,a3,0x20
     b06:	9281                	srl	a3,a3,0x20
     b08:	0685                	add	a3,a3,1
     b0a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     b0c:	00054783          	lbu	a5,0(a0)
     b10:	0005c703          	lbu	a4,0(a1)
     b14:	00e79863          	bne	a5,a4,b24 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
     b18:	0505                	add	a0,a0,1
    p2++;
     b1a:	0585                	add	a1,a1,1
  while (n-- > 0) {
     b1c:	fed518e3          	bne	a0,a3,b0c <memcmp+0x14>
  }
  return 0;
     b20:	4501                	li	a0,0
     b22:	a019                	j	b28 <memcmp+0x30>
      return *p1 - *p2;
     b24:	40e7853b          	subw	a0,a5,a4
}
     b28:	6422                	ld	s0,8(sp)
     b2a:	0141                	add	sp,sp,16
     b2c:	8082                	ret
  return 0;
     b2e:	4501                	li	a0,0
     b30:	bfe5                	j	b28 <memcmp+0x30>

0000000000000b32 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     b32:	1141                	add	sp,sp,-16
     b34:	e406                	sd	ra,8(sp)
     b36:	e022                	sd	s0,0(sp)
     b38:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
     b3a:	f67ff0ef          	jal	aa0 <memmove>
}
     b3e:	60a2                	ld	ra,8(sp)
     b40:	6402                	ld	s0,0(sp)
     b42:	0141                	add	sp,sp,16
     b44:	8082                	ret

0000000000000b46 <htons>:
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
}

uint16_t
htons(uint16_t h)
{
     b46:	1141                	add	sp,sp,-16
     b48:	e422                	sd	s0,8(sp)
     b4a:	0800                	add	s0,sp,16
    if (!endian) {
     b4c:	00001797          	auipc	a5,0x1
     b50:	4c47a783          	lw	a5,1220(a5) # 2010 <endian>
     b54:	e385                	bnez	a5,b74 <htons+0x2e>
        endian = byteorder();
     b56:	4d200793          	li	a5,1234
     b5a:	00001717          	auipc	a4,0x1
     b5e:	4af72b23          	sw	a5,1206(a4) # 2010 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
     b62:	0085179b          	sllw	a5,a0,0x8
     b66:	0085551b          	srlw	a0,a0,0x8
     b6a:	8fc9                	or	a5,a5,a0
     b6c:	03079513          	sll	a0,a5,0x30
     b70:	9141                	srl	a0,a0,0x30
     b72:	a029                	j	b7c <htons+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(h) : h;
     b74:	4d200713          	li	a4,1234
     b78:	fee785e3          	beq	a5,a4,b62 <htons+0x1c>
}
     b7c:	6422                	ld	s0,8(sp)
     b7e:	0141                	add	sp,sp,16
     b80:	8082                	ret

0000000000000b82 <ntohs>:

uint16_t
ntohs(uint16_t n)
{
     b82:	1141                	add	sp,sp,-16
     b84:	e422                	sd	s0,8(sp)
     b86:	0800                	add	s0,sp,16
    if (!endian) {
     b88:	00001797          	auipc	a5,0x1
     b8c:	4887a783          	lw	a5,1160(a5) # 2010 <endian>
     b90:	e385                	bnez	a5,bb0 <ntohs+0x2e>
        endian = byteorder();
     b92:	4d200793          	li	a5,1234
     b96:	00001717          	auipc	a4,0x1
     b9a:	46f72d23          	sw	a5,1146(a4) # 2010 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
     b9e:	0085179b          	sllw	a5,a0,0x8
     ba2:	0085551b          	srlw	a0,a0,0x8
     ba6:	8fc9                	or	a5,a5,a0
     ba8:	03079513          	sll	a0,a5,0x30
     bac:	9141                	srl	a0,a0,0x30
     bae:	a029                	j	bb8 <ntohs+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(n) : n;
     bb0:	4d200713          	li	a4,1234
     bb4:	fee785e3          	beq	a5,a4,b9e <ntohs+0x1c>
}
     bb8:	6422                	ld	s0,8(sp)
     bba:	0141                	add	sp,sp,16
     bbc:	8082                	ret

0000000000000bbe <htonl>:

uint32_t
htonl(uint32_t h)
{
     bbe:	1141                	add	sp,sp,-16
     bc0:	e422                	sd	s0,8(sp)
     bc2:	0800                	add	s0,sp,16
    if (!endian) {
     bc4:	00001797          	auipc	a5,0x1
     bc8:	44c7a783          	lw	a5,1100(a5) # 2010 <endian>
     bcc:	ef85                	bnez	a5,c04 <htonl+0x46>
        endian = byteorder();
     bce:	4d200793          	li	a5,1234
     bd2:	00001717          	auipc	a4,0x1
     bd6:	42f72f23          	sw	a5,1086(a4) # 2010 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
     bda:	0185179b          	sllw	a5,a0,0x18
     bde:	0185571b          	srlw	a4,a0,0x18
     be2:	8fd9                	or	a5,a5,a4
     be4:	0085171b          	sllw	a4,a0,0x8
     be8:	00ff06b7          	lui	a3,0xff0
     bec:	8f75                	and	a4,a4,a3
     bee:	8fd9                	or	a5,a5,a4
     bf0:	0085551b          	srlw	a0,a0,0x8
     bf4:	6741                	lui	a4,0x10
     bf6:	f0070713          	add	a4,a4,-256 # ff00 <base+0xdaf8>
     bfa:	8d79                	and	a0,a0,a4
     bfc:	8fc9                	or	a5,a5,a0
     bfe:	0007851b          	sext.w	a0,a5
     c02:	a029                	j	c0c <htonl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(h) : h;
     c04:	4d200713          	li	a4,1234
     c08:	fce789e3          	beq	a5,a4,bda <htonl+0x1c>
}
     c0c:	6422                	ld	s0,8(sp)
     c0e:	0141                	add	sp,sp,16
     c10:	8082                	ret

0000000000000c12 <ntohl>:

uint32_t
ntohl(uint32_t n)
{
     c12:	1141                	add	sp,sp,-16
     c14:	e422                	sd	s0,8(sp)
     c16:	0800                	add	s0,sp,16
    if (!endian) {
     c18:	00001797          	auipc	a5,0x1
     c1c:	3f87a783          	lw	a5,1016(a5) # 2010 <endian>
     c20:	ef85                	bnez	a5,c58 <ntohl+0x46>
        endian = byteorder();
     c22:	4d200793          	li	a5,1234
     c26:	00001717          	auipc	a4,0x1
     c2a:	3ef72523          	sw	a5,1002(a4) # 2010 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
     c2e:	0185179b          	sllw	a5,a0,0x18
     c32:	0185571b          	srlw	a4,a0,0x18
     c36:	8fd9                	or	a5,a5,a4
     c38:	0085171b          	sllw	a4,a0,0x8
     c3c:	00ff06b7          	lui	a3,0xff0
     c40:	8f75                	and	a4,a4,a3
     c42:	8fd9                	or	a5,a5,a4
     c44:	0085551b          	srlw	a0,a0,0x8
     c48:	6741                	lui	a4,0x10
     c4a:	f0070713          	add	a4,a4,-256 # ff00 <base+0xdaf8>
     c4e:	8d79                	and	a0,a0,a4
     c50:	8fc9                	or	a5,a5,a0
     c52:	0007851b          	sext.w	a0,a5
     c56:	a029                	j	c60 <ntohl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(n) : n;
     c58:	4d200713          	li	a4,1234
     c5c:	fce789e3          	beq	a5,a4,c2e <ntohl+0x1c>
}
     c60:	6422                	ld	s0,8(sp)
     c62:	0141                	add	sp,sp,16
     c64:	8082                	ret

0000000000000c66 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
     c66:	1141                	add	sp,sp,-16
     c68:	e422                	sd	s0,8(sp)
     c6a:	0800                	add	s0,sp,16
     c6c:	872a                	mv	a4,a0
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
     c6e:	02000693          	li	a3,32
     c72:	4525                	li	a0,9
     c74:	a011                	j	c78 <strtol+0x12>
        s++;
     c76:	0705                	add	a4,a4,1
    while (*s == ' ' || *s == '\t')
     c78:	00074783          	lbu	a5,0(a4)
     c7c:	fed78de3          	beq	a5,a3,c76 <strtol+0x10>
     c80:	fea78be3          	beq	a5,a0,c76 <strtol+0x10>

    // plus/minus sign
    if (*s == '+')
     c84:	02b00693          	li	a3,43
     c88:	02d78663          	beq	a5,a3,cb4 <strtol+0x4e>
        s++;
    else if (*s == '-')
     c8c:	02d00693          	li	a3,45
    int neg = 0;
     c90:	4301                	li	t1,0
    else if (*s == '-')
     c92:	02d78463          	beq	a5,a3,cba <strtol+0x54>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
     c96:	fef67793          	and	a5,a2,-17
     c9a:	eb89                	bnez	a5,cac <strtol+0x46>
     c9c:	00074683          	lbu	a3,0(a4)
     ca0:	03000793          	li	a5,48
     ca4:	00f68e63          	beq	a3,a5,cc0 <strtol+0x5a>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
     ca8:	e211                	bnez	a2,cac <strtol+0x46>
        s++, base = 8;
    else if (base == 0)
        base = 10;
     caa:	4629                	li	a2,10
     cac:	4501                	li	a0,0

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
     cae:	4825                	li	a6,9
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
     cb0:	48e5                	li	a7,25
     cb2:	a825                	j	cea <strtol+0x84>
        s++;
     cb4:	0705                	add	a4,a4,1
    int neg = 0;
     cb6:	4301                	li	t1,0
     cb8:	bff9                	j	c96 <strtol+0x30>
        s++, neg = 1;
     cba:	0705                	add	a4,a4,1
     cbc:	4305                	li	t1,1
     cbe:	bfe1                	j	c96 <strtol+0x30>
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
     cc0:	00174683          	lbu	a3,1(a4)
     cc4:	07800793          	li	a5,120
     cc8:	00f68663          	beq	a3,a5,cd4 <strtol+0x6e>
    else if (base == 0 && s[0] == '0')
     ccc:	f265                	bnez	a2,cac <strtol+0x46>
        s++, base = 8;
     cce:	0705                	add	a4,a4,1
     cd0:	4621                	li	a2,8
     cd2:	bfe9                	j	cac <strtol+0x46>
        s += 2, base = 16;
     cd4:	0709                	add	a4,a4,2
     cd6:	4641                	li	a2,16
     cd8:	bfd1                	j	cac <strtol+0x46>
            dig = *s - '0';
     cda:	fd07879b          	addw	a5,a5,-48
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
     cde:	04c7d063          	bge	a5,a2,d1e <strtol+0xb8>
            break;
        s++, val = (val * base) + dig;
     ce2:	0705                	add	a4,a4,1
     ce4:	02a60533          	mul	a0,a2,a0
     ce8:	953e                	add	a0,a0,a5
        if (*s >= '0' && *s <= '9')
     cea:	00074783          	lbu	a5,0(a4)
     cee:	fd07869b          	addw	a3,a5,-48
     cf2:	0ff6f693          	zext.b	a3,a3
     cf6:	fed872e3          	bgeu	a6,a3,cda <strtol+0x74>
        else if (*s >= 'a' && *s <= 'z')
     cfa:	f9f7869b          	addw	a3,a5,-97
     cfe:	0ff6f693          	zext.b	a3,a3
     d02:	00d8e563          	bltu	a7,a3,d0c <strtol+0xa6>
            dig = *s - 'a' + 10;
     d06:	fa97879b          	addw	a5,a5,-87
     d0a:	bfd1                	j	cde <strtol+0x78>
        else if (*s >= 'A' && *s <= 'Z')
     d0c:	fbf7869b          	addw	a3,a5,-65
     d10:	0ff6f693          	zext.b	a3,a3
     d14:	00d8e563          	bltu	a7,a3,d1e <strtol+0xb8>
            dig = *s - 'A' + 10;
     d18:	fc97879b          	addw	a5,a5,-55
     d1c:	b7c9                	j	cde <strtol+0x78>
        // we don't properly detect overflow!
    }

    if (endptr)
     d1e:	c191                	beqz	a1,d22 <strtol+0xbc>
        *endptr = (char *) s;
     d20:	e198                	sd	a4,0(a1)
    return (neg ? -val : val);
     d22:	00030463          	beqz	t1,d2a <strtol+0xc4>
     d26:	40a00533          	neg	a0,a0
}
     d2a:	6422                	ld	s0,8(sp)
     d2c:	0141                	add	sp,sp,16
     d2e:	8082                	ret

0000000000000d30 <inet_pton>:
inet_pton (int family, const char *p, void *n) {
    char *sp, *ep;
    int idx;
    long ret;

    if (family != AF_INET) {
     d30:	4785                	li	a5,1
     d32:	08f51063          	bne	a0,a5,db2 <inet_pton+0x82>
inet_pton (int family, const char *p, void *n) {
     d36:	715d                	add	sp,sp,-80
     d38:	e486                	sd	ra,72(sp)
     d3a:	e0a2                	sd	s0,64(sp)
     d3c:	fc26                	sd	s1,56(sp)
     d3e:	f84a                	sd	s2,48(sp)
     d40:	f44e                	sd	s3,40(sp)
     d42:	f052                	sd	s4,32(sp)
     d44:	ec56                	sd	s5,24(sp)
     d46:	e85a                	sd	s6,16(sp)
     d48:	0880                	add	s0,sp,80
     d4a:	84ae                	mv	s1,a1
     d4c:	89b2                	mv	s3,a2
     d4e:	4901                	li	s2,0
        return -1;
    }
    sp = (char *)p;
    for (idx = 0; idx < 4; idx++) {
        ret = strtol(sp, &ep, 10);
        if (ret < 0 || ret > 255) {
     d50:	0ff00a13          	li	s4,255
            return -1;
        }
        if (ep == sp) {
            return -1;
        }
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
     d54:	4a8d                	li	s5,3
     d56:	02e00b13          	li	s6,46
     d5a:	a805                	j	d8a <inet_pton+0x5a>
     d5c:	0007c783          	lbu	a5,0(a5)
     d60:	efb9                	bnez	a5,dbe <inet_pton+0x8e>
            return -1;
        }
        ((uint8_t *)n)[idx] = ret;
     d62:	00a981a3          	sb	a0,3(s3)
        sp = ep + 1;
    }
    return 0;
     d66:	4501                	li	a0,0
}
     d68:	60a6                	ld	ra,72(sp)
     d6a:	6406                	ld	s0,64(sp)
     d6c:	74e2                	ld	s1,56(sp)
     d6e:	7942                	ld	s2,48(sp)
     d70:	79a2                	ld	s3,40(sp)
     d72:	7a02                	ld	s4,32(sp)
     d74:	6ae2                	ld	s5,24(sp)
     d76:	6b42                	ld	s6,16(sp)
     d78:	6161                	add	sp,sp,80
     d7a:	8082                	ret
        ((uint8_t *)n)[idx] = ret;
     d7c:	01298733          	add	a4,s3,s2
     d80:	00a70023          	sb	a0,0(a4)
        sp = ep + 1;
     d84:	00178493          	add	s1,a5,1
    for (idx = 0; idx < 4; idx++) {
     d88:	0905                	add	s2,s2,1
        ret = strtol(sp, &ep, 10);
     d8a:	4629                	li	a2,10
     d8c:	fb840593          	add	a1,s0,-72
     d90:	8526                	mv	a0,s1
     d92:	ed5ff0ef          	jal	c66 <strtol>
        if (ret < 0 || ret > 255) {
     d96:	02aa6063          	bltu	s4,a0,db6 <inet_pton+0x86>
        if (ep == sp) {
     d9a:	fb843783          	ld	a5,-72(s0)
     d9e:	00978e63          	beq	a5,s1,dba <inet_pton+0x8a>
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
     da2:	fb590de3          	beq	s2,s5,d5c <inet_pton+0x2c>
     da6:	0007c703          	lbu	a4,0(a5)
     daa:	fd6709e3          	beq	a4,s6,d7c <inet_pton+0x4c>
            return -1;
     dae:	557d                	li	a0,-1
     db0:	bf65                	j	d68 <inet_pton+0x38>
        return -1;
     db2:	557d                	li	a0,-1
}
     db4:	8082                	ret
            return -1;
     db6:	557d                	li	a0,-1
     db8:	bf45                	j	d68 <inet_pton+0x38>
            return -1;
     dba:	557d                	li	a0,-1
     dbc:	b775                	j	d68 <inet_pton+0x38>
            return -1;
     dbe:	557d                	li	a0,-1
     dc0:	b765                	j	d68 <inet_pton+0x38>

0000000000000dc2 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     dc2:	4885                	li	a7,1
 ecall
     dc4:	00000073          	ecall
 ret
     dc8:	8082                	ret

0000000000000dca <exit>:
.global exit
exit:
 li a7, SYS_exit
     dca:	4889                	li	a7,2
 ecall
     dcc:	00000073          	ecall
 ret
     dd0:	8082                	ret

0000000000000dd2 <wait>:
.global wait
wait:
 li a7, SYS_wait
     dd2:	488d                	li	a7,3
 ecall
     dd4:	00000073          	ecall
 ret
     dd8:	8082                	ret

0000000000000dda <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     dda:	4891                	li	a7,4
 ecall
     ddc:	00000073          	ecall
 ret
     de0:	8082                	ret

0000000000000de2 <read>:
.global read
read:
 li a7, SYS_read
     de2:	4895                	li	a7,5
 ecall
     de4:	00000073          	ecall
 ret
     de8:	8082                	ret

0000000000000dea <write>:
.global write
write:
 li a7, SYS_write
     dea:	48c1                	li	a7,16
 ecall
     dec:	00000073          	ecall
 ret
     df0:	8082                	ret

0000000000000df2 <close>:
.global close
close:
 li a7, SYS_close
     df2:	48d5                	li	a7,21
 ecall
     df4:	00000073          	ecall
 ret
     df8:	8082                	ret

0000000000000dfa <kill>:
.global kill
kill:
 li a7, SYS_kill
     dfa:	4899                	li	a7,6
 ecall
     dfc:	00000073          	ecall
 ret
     e00:	8082                	ret

0000000000000e02 <exec>:
.global exec
exec:
 li a7, SYS_exec
     e02:	489d                	li	a7,7
 ecall
     e04:	00000073          	ecall
 ret
     e08:	8082                	ret

0000000000000e0a <open>:
.global open
open:
 li a7, SYS_open
     e0a:	48bd                	li	a7,15
 ecall
     e0c:	00000073          	ecall
 ret
     e10:	8082                	ret

0000000000000e12 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     e12:	48c5                	li	a7,17
 ecall
     e14:	00000073          	ecall
 ret
     e18:	8082                	ret

0000000000000e1a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     e1a:	48c9                	li	a7,18
 ecall
     e1c:	00000073          	ecall
 ret
     e20:	8082                	ret

0000000000000e22 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     e22:	48a1                	li	a7,8
 ecall
     e24:	00000073          	ecall
 ret
     e28:	8082                	ret

0000000000000e2a <link>:
.global link
link:
 li a7, SYS_link
     e2a:	48cd                	li	a7,19
 ecall
     e2c:	00000073          	ecall
 ret
     e30:	8082                	ret

0000000000000e32 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     e32:	48d1                	li	a7,20
 ecall
     e34:	00000073          	ecall
 ret
     e38:	8082                	ret

0000000000000e3a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     e3a:	48a5                	li	a7,9
 ecall
     e3c:	00000073          	ecall
 ret
     e40:	8082                	ret

0000000000000e42 <dup>:
.global dup
dup:
 li a7, SYS_dup
     e42:	48a9                	li	a7,10
 ecall
     e44:	00000073          	ecall
 ret
     e48:	8082                	ret

0000000000000e4a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     e4a:	48ad                	li	a7,11
 ecall
     e4c:	00000073          	ecall
 ret
     e50:	8082                	ret

0000000000000e52 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     e52:	48b1                	li	a7,12
 ecall
     e54:	00000073          	ecall
 ret
     e58:	8082                	ret

0000000000000e5a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     e5a:	48b5                	li	a7,13
 ecall
     e5c:	00000073          	ecall
 ret
     e60:	8082                	ret

0000000000000e62 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     e62:	48b9                	li	a7,14
 ecall
     e64:	00000073          	ecall
 ret
     e68:	8082                	ret

0000000000000e6a <socket>:
.global socket
socket:
 li a7, SYS_socket
     e6a:	48d9                	li	a7,22
 ecall
     e6c:	00000073          	ecall
 ret
     e70:	8082                	ret

0000000000000e72 <bind>:
.global bind
bind:
 li a7, SYS_bind
     e72:	48dd                	li	a7,23
 ecall
     e74:	00000073          	ecall
 ret
     e78:	8082                	ret

0000000000000e7a <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
     e7a:	48e1                	li	a7,24
 ecall
     e7c:	00000073          	ecall
 ret
     e80:	8082                	ret

0000000000000e82 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
     e82:	48e5                	li	a7,25
 ecall
     e84:	00000073          	ecall
 ret
     e88:	8082                	ret

0000000000000e8a <connect>:
.global connect
connect:
 li a7, SYS_connect
     e8a:	48e9                	li	a7,26
 ecall
     e8c:	00000073          	ecall
 ret
     e90:	8082                	ret

0000000000000e92 <listen>:
.global listen
listen:
 li a7, SYS_listen
     e92:	48ed                	li	a7,27
 ecall
     e94:	00000073          	ecall
 ret
     e98:	8082                	ret

0000000000000e9a <accept>:
.global accept
accept:
 li a7, SYS_accept
     e9a:	48f1                	li	a7,28
 ecall
     e9c:	00000073          	ecall
 ret
     ea0:	8082                	ret

0000000000000ea2 <recv>:
.global recv
recv:
 li a7, SYS_recv
     ea2:	48f5                	li	a7,29
 ecall
     ea4:	00000073          	ecall
 ret
     ea8:	8082                	ret

0000000000000eaa <send>:
.global send
send:
 li a7, SYS_send
     eaa:	48f9                	li	a7,30
 ecall
     eac:	00000073          	ecall
 ret
     eb0:	8082                	ret

0000000000000eb2 <ioctl>:
.global ioctl
ioctl:
 li a7, SYS_ioctl
     eb2:	48fd                	li	a7,31
 ecall
     eb4:	00000073          	ecall
 ret
     eb8:	8082                	ret

0000000000000eba <consolemode>:
.global consolemode
consolemode:
 li a7, SYS_consolemode
     eba:	02000893          	li	a7,32
 ecall
     ebe:	00000073          	ecall
 ret
     ec2:	8082                	ret

0000000000000ec4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     ec4:	1101                	add	sp,sp,-32
     ec6:	ec06                	sd	ra,24(sp)
     ec8:	e822                	sd	s0,16(sp)
     eca:	1000                	add	s0,sp,32
     ecc:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     ed0:	4605                	li	a2,1
     ed2:	fef40593          	add	a1,s0,-17
     ed6:	f15ff0ef          	jal	dea <write>
}
     eda:	60e2                	ld	ra,24(sp)
     edc:	6442                	ld	s0,16(sp)
     ede:	6105                	add	sp,sp,32
     ee0:	8082                	ret

0000000000000ee2 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
     ee2:	715d                	add	sp,sp,-80
     ee4:	e486                	sd	ra,72(sp)
     ee6:	e0a2                	sd	s0,64(sp)
     ee8:	fc26                	sd	s1,56(sp)
     eea:	0880                	add	s0,sp,80
     eec:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     eee:	c299                	beqz	a3,ef4 <printint+0x12>
     ef0:	0805c963          	bltz	a1,f82 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     ef4:	2581                	sext.w	a1,a1
  neg = 0;
     ef6:	4881                	li	a7,0
     ef8:	fb840693          	add	a3,s0,-72
  }

  i = 0;
     efc:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
     efe:	2601                	sext.w	a2,a2
     f00:	00001517          	auipc	a0,0x1
     f04:	86050513          	add	a0,a0,-1952 # 1760 <digits>
     f08:	883a                	mv	a6,a4
     f0a:	2705                	addw	a4,a4,1
     f0c:	02c5f7bb          	remuw	a5,a1,a2
     f10:	1782                	sll	a5,a5,0x20
     f12:	9381                	srl	a5,a5,0x20
     f14:	97aa                	add	a5,a5,a0
     f16:	0007c783          	lbu	a5,0(a5)
     f1a:	00f68023          	sb	a5,0(a3) # ff0000 <base+0xfedbf8>
  }while((x /= base) != 0);
     f1e:	0005879b          	sext.w	a5,a1
     f22:	02c5d5bb          	divuw	a1,a1,a2
     f26:	0685                	add	a3,a3,1
     f28:	fec7f0e3          	bgeu	a5,a2,f08 <printint+0x26>
  if(neg)
     f2c:	00088c63          	beqz	a7,f44 <printint+0x62>
    buf[i++] = '-';
     f30:	fd070793          	add	a5,a4,-48
     f34:	00878733          	add	a4,a5,s0
     f38:	02d00793          	li	a5,45
     f3c:	fef70423          	sb	a5,-24(a4)
     f40:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
     f44:	02e05a63          	blez	a4,f78 <printint+0x96>
     f48:	f84a                	sd	s2,48(sp)
     f4a:	f44e                	sd	s3,40(sp)
     f4c:	fb840793          	add	a5,s0,-72
     f50:	00e78933          	add	s2,a5,a4
     f54:	fff78993          	add	s3,a5,-1
     f58:	99ba                	add	s3,s3,a4
     f5a:	377d                	addw	a4,a4,-1
     f5c:	1702                	sll	a4,a4,0x20
     f5e:	9301                	srl	a4,a4,0x20
     f60:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
     f64:	fff94583          	lbu	a1,-1(s2)
     f68:	8526                	mv	a0,s1
     f6a:	f5bff0ef          	jal	ec4 <putc>
  while(--i >= 0)
     f6e:	197d                	add	s2,s2,-1
     f70:	ff391ae3          	bne	s2,s3,f64 <printint+0x82>
     f74:	7942                	ld	s2,48(sp)
     f76:	79a2                	ld	s3,40(sp)
}
     f78:	60a6                	ld	ra,72(sp)
     f7a:	6406                	ld	s0,64(sp)
     f7c:	74e2                	ld	s1,56(sp)
     f7e:	6161                	add	sp,sp,80
     f80:	8082                	ret
    x = -xx;
     f82:	40b005bb          	negw	a1,a1
    neg = 1;
     f86:	4885                	li	a7,1
    x = -xx;
     f88:	bf85                	j	ef8 <printint+0x16>

0000000000000f8a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     f8a:	711d                	add	sp,sp,-96
     f8c:	ec86                	sd	ra,88(sp)
     f8e:	e8a2                	sd	s0,80(sp)
     f90:	e0ca                	sd	s2,64(sp)
     f92:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     f94:	0005c903          	lbu	s2,0(a1)
     f98:	26090863          	beqz	s2,1208 <vprintf+0x27e>
     f9c:	e4a6                	sd	s1,72(sp)
     f9e:	fc4e                	sd	s3,56(sp)
     fa0:	f852                	sd	s4,48(sp)
     fa2:	f456                	sd	s5,40(sp)
     fa4:	f05a                	sd	s6,32(sp)
     fa6:	ec5e                	sd	s7,24(sp)
     fa8:	e862                	sd	s8,16(sp)
     faa:	e466                	sd	s9,8(sp)
     fac:	8b2a                	mv	s6,a0
     fae:	8a2e                	mv	s4,a1
     fb0:	8bb2                	mv	s7,a2
  state = 0;
     fb2:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
     fb4:	4481                	li	s1,0
     fb6:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
     fb8:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
     fbc:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
     fc0:	06c00c93          	li	s9,108
     fc4:	a005                	j	fe4 <vprintf+0x5a>
        putc(fd, c0);
     fc6:	85ca                	mv	a1,s2
     fc8:	855a                	mv	a0,s6
     fca:	efbff0ef          	jal	ec4 <putc>
     fce:	a019                	j	fd4 <vprintf+0x4a>
    } else if(state == '%'){
     fd0:	03598263          	beq	s3,s5,ff4 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
     fd4:	2485                	addw	s1,s1,1
     fd6:	8726                	mv	a4,s1
     fd8:	009a07b3          	add	a5,s4,s1
     fdc:	0007c903          	lbu	s2,0(a5)
     fe0:	20090c63          	beqz	s2,11f8 <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
     fe4:	0009079b          	sext.w	a5,s2
    if(state == 0){
     fe8:	fe0994e3          	bnez	s3,fd0 <vprintf+0x46>
      if(c0 == '%'){
     fec:	fd579de3          	bne	a5,s5,fc6 <vprintf+0x3c>
        state = '%';
     ff0:	89be                	mv	s3,a5
     ff2:	b7cd                	j	fd4 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
     ff4:	00ea06b3          	add	a3,s4,a4
     ff8:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
     ffc:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
     ffe:	c681                	beqz	a3,1006 <vprintf+0x7c>
    1000:	9752                	add	a4,a4,s4
    1002:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
    1006:	03878f63          	beq	a5,s8,1044 <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
    100a:	05978963          	beq	a5,s9,105c <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
    100e:	07500713          	li	a4,117
    1012:	0ee78363          	beq	a5,a4,10f8 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
    1016:	07800713          	li	a4,120
    101a:	12e78563          	beq	a5,a4,1144 <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
    101e:	07000713          	li	a4,112
    1022:	14e78a63          	beq	a5,a4,1176 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
    1026:	07300713          	li	a4,115
    102a:	18e78a63          	beq	a5,a4,11be <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
    102e:	02500713          	li	a4,37
    1032:	04e79563          	bne	a5,a4,107c <vprintf+0xf2>
        putc(fd, '%');
    1036:	02500593          	li	a1,37
    103a:	855a                	mv	a0,s6
    103c:	e89ff0ef          	jal	ec4 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
    1040:	4981                	li	s3,0
    1042:	bf49                	j	fd4 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
    1044:	008b8913          	add	s2,s7,8
    1048:	4685                	li	a3,1
    104a:	4629                	li	a2,10
    104c:	000ba583          	lw	a1,0(s7)
    1050:	855a                	mv	a0,s6
    1052:	e91ff0ef          	jal	ee2 <printint>
    1056:	8bca                	mv	s7,s2
      state = 0;
    1058:	4981                	li	s3,0
    105a:	bfad                	j	fd4 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
    105c:	06400793          	li	a5,100
    1060:	02f68963          	beq	a3,a5,1092 <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    1064:	06c00793          	li	a5,108
    1068:	04f68263          	beq	a3,a5,10ac <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
    106c:	07500793          	li	a5,117
    1070:	0af68063          	beq	a3,a5,1110 <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
    1074:	07800793          	li	a5,120
    1078:	0ef68263          	beq	a3,a5,115c <vprintf+0x1d2>
        putc(fd, '%');
    107c:	02500593          	li	a1,37
    1080:	855a                	mv	a0,s6
    1082:	e43ff0ef          	jal	ec4 <putc>
        putc(fd, c0);
    1086:	85ca                	mv	a1,s2
    1088:	855a                	mv	a0,s6
    108a:	e3bff0ef          	jal	ec4 <putc>
      state = 0;
    108e:	4981                	li	s3,0
    1090:	b791                	j	fd4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
    1092:	008b8913          	add	s2,s7,8
    1096:	4685                	li	a3,1
    1098:	4629                	li	a2,10
    109a:	000bb583          	ld	a1,0(s7)
    109e:	855a                	mv	a0,s6
    10a0:	e43ff0ef          	jal	ee2 <printint>
        i += 1;
    10a4:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
    10a6:	8bca                	mv	s7,s2
      state = 0;
    10a8:	4981                	li	s3,0
        i += 1;
    10aa:	b72d                	j	fd4 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    10ac:	06400793          	li	a5,100
    10b0:	02f60763          	beq	a2,a5,10de <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
    10b4:	07500793          	li	a5,117
    10b8:	06f60963          	beq	a2,a5,112a <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
    10bc:	07800793          	li	a5,120
    10c0:	faf61ee3          	bne	a2,a5,107c <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
    10c4:	008b8913          	add	s2,s7,8
    10c8:	4681                	li	a3,0
    10ca:	4641                	li	a2,16
    10cc:	000bb583          	ld	a1,0(s7)
    10d0:	855a                	mv	a0,s6
    10d2:	e11ff0ef          	jal	ee2 <printint>
        i += 2;
    10d6:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
    10d8:	8bca                	mv	s7,s2
      state = 0;
    10da:	4981                	li	s3,0
        i += 2;
    10dc:	bde5                	j	fd4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
    10de:	008b8913          	add	s2,s7,8
    10e2:	4685                	li	a3,1
    10e4:	4629                	li	a2,10
    10e6:	000bb583          	ld	a1,0(s7)
    10ea:	855a                	mv	a0,s6
    10ec:	df7ff0ef          	jal	ee2 <printint>
        i += 2;
    10f0:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
    10f2:	8bca                	mv	s7,s2
      state = 0;
    10f4:	4981                	li	s3,0
        i += 2;
    10f6:	bdf9                	j	fd4 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
    10f8:	008b8913          	add	s2,s7,8
    10fc:	4681                	li	a3,0
    10fe:	4629                	li	a2,10
    1100:	000ba583          	lw	a1,0(s7)
    1104:	855a                	mv	a0,s6
    1106:	dddff0ef          	jal	ee2 <printint>
    110a:	8bca                	mv	s7,s2
      state = 0;
    110c:	4981                	li	s3,0
    110e:	b5d9                	j	fd4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
    1110:	008b8913          	add	s2,s7,8
    1114:	4681                	li	a3,0
    1116:	4629                	li	a2,10
    1118:	000bb583          	ld	a1,0(s7)
    111c:	855a                	mv	a0,s6
    111e:	dc5ff0ef          	jal	ee2 <printint>
        i += 1;
    1122:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
    1124:	8bca                	mv	s7,s2
      state = 0;
    1126:	4981                	li	s3,0
        i += 1;
    1128:	b575                	j	fd4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
    112a:	008b8913          	add	s2,s7,8
    112e:	4681                	li	a3,0
    1130:	4629                	li	a2,10
    1132:	000bb583          	ld	a1,0(s7)
    1136:	855a                	mv	a0,s6
    1138:	dabff0ef          	jal	ee2 <printint>
        i += 2;
    113c:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
    113e:	8bca                	mv	s7,s2
      state = 0;
    1140:	4981                	li	s3,0
        i += 2;
    1142:	bd49                	j	fd4 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
    1144:	008b8913          	add	s2,s7,8
    1148:	4681                	li	a3,0
    114a:	4641                	li	a2,16
    114c:	000ba583          	lw	a1,0(s7)
    1150:	855a                	mv	a0,s6
    1152:	d91ff0ef          	jal	ee2 <printint>
    1156:	8bca                	mv	s7,s2
      state = 0;
    1158:	4981                	li	s3,0
    115a:	bdad                	j	fd4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
    115c:	008b8913          	add	s2,s7,8
    1160:	4681                	li	a3,0
    1162:	4641                	li	a2,16
    1164:	000bb583          	ld	a1,0(s7)
    1168:	855a                	mv	a0,s6
    116a:	d79ff0ef          	jal	ee2 <printint>
        i += 1;
    116e:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
    1170:	8bca                	mv	s7,s2
      state = 0;
    1172:	4981                	li	s3,0
        i += 1;
    1174:	b585                	j	fd4 <vprintf+0x4a>
    1176:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
    1178:	008b8d13          	add	s10,s7,8
    117c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    1180:	03000593          	li	a1,48
    1184:	855a                	mv	a0,s6
    1186:	d3fff0ef          	jal	ec4 <putc>
  putc(fd, 'x');
    118a:	07800593          	li	a1,120
    118e:	855a                	mv	a0,s6
    1190:	d35ff0ef          	jal	ec4 <putc>
    1194:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    1196:	00000b97          	auipc	s7,0x0
    119a:	5cab8b93          	add	s7,s7,1482 # 1760 <digits>
    119e:	03c9d793          	srl	a5,s3,0x3c
    11a2:	97de                	add	a5,a5,s7
    11a4:	0007c583          	lbu	a1,0(a5)
    11a8:	855a                	mv	a0,s6
    11aa:	d1bff0ef          	jal	ec4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    11ae:	0992                	sll	s3,s3,0x4
    11b0:	397d                	addw	s2,s2,-1
    11b2:	fe0916e3          	bnez	s2,119e <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
    11b6:	8bea                	mv	s7,s10
      state = 0;
    11b8:	4981                	li	s3,0
    11ba:	6d02                	ld	s10,0(sp)
    11bc:	bd21                	j	fd4 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
    11be:	008b8993          	add	s3,s7,8
    11c2:	000bb903          	ld	s2,0(s7)
    11c6:	00090f63          	beqz	s2,11e4 <vprintf+0x25a>
        for(; *s; s++)
    11ca:	00094583          	lbu	a1,0(s2)
    11ce:	c195                	beqz	a1,11f2 <vprintf+0x268>
          putc(fd, *s);
    11d0:	855a                	mv	a0,s6
    11d2:	cf3ff0ef          	jal	ec4 <putc>
        for(; *s; s++)
    11d6:	0905                	add	s2,s2,1
    11d8:	00094583          	lbu	a1,0(s2)
    11dc:	f9f5                	bnez	a1,11d0 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
    11de:	8bce                	mv	s7,s3
      state = 0;
    11e0:	4981                	li	s3,0
    11e2:	bbcd                	j	fd4 <vprintf+0x4a>
          s = "(null)";
    11e4:	00000917          	auipc	s2,0x0
    11e8:	51490913          	add	s2,s2,1300 # 16f8 <malloc+0x400>
        for(; *s; s++)
    11ec:	02800593          	li	a1,40
    11f0:	b7c5                	j	11d0 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
    11f2:	8bce                	mv	s7,s3
      state = 0;
    11f4:	4981                	li	s3,0
    11f6:	bbf9                	j	fd4 <vprintf+0x4a>
    11f8:	64a6                	ld	s1,72(sp)
    11fa:	79e2                	ld	s3,56(sp)
    11fc:	7a42                	ld	s4,48(sp)
    11fe:	7aa2                	ld	s5,40(sp)
    1200:	7b02                	ld	s6,32(sp)
    1202:	6be2                	ld	s7,24(sp)
    1204:	6c42                	ld	s8,16(sp)
    1206:	6ca2                	ld	s9,8(sp)
    }
  }
}
    1208:	60e6                	ld	ra,88(sp)
    120a:	6446                	ld	s0,80(sp)
    120c:	6906                	ld	s2,64(sp)
    120e:	6125                	add	sp,sp,96
    1210:	8082                	ret

0000000000001212 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    1212:	715d                	add	sp,sp,-80
    1214:	ec06                	sd	ra,24(sp)
    1216:	e822                	sd	s0,16(sp)
    1218:	1000                	add	s0,sp,32
    121a:	e010                	sd	a2,0(s0)
    121c:	e414                	sd	a3,8(s0)
    121e:	e818                	sd	a4,16(s0)
    1220:	ec1c                	sd	a5,24(s0)
    1222:	03043023          	sd	a6,32(s0)
    1226:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    122a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    122e:	8622                	mv	a2,s0
    1230:	d5bff0ef          	jal	f8a <vprintf>
}
    1234:	60e2                	ld	ra,24(sp)
    1236:	6442                	ld	s0,16(sp)
    1238:	6161                	add	sp,sp,80
    123a:	8082                	ret

000000000000123c <printf>:

void
printf(const char *fmt, ...)
{
    123c:	711d                	add	sp,sp,-96
    123e:	ec06                	sd	ra,24(sp)
    1240:	e822                	sd	s0,16(sp)
    1242:	1000                	add	s0,sp,32
    1244:	e40c                	sd	a1,8(s0)
    1246:	e810                	sd	a2,16(s0)
    1248:	ec14                	sd	a3,24(s0)
    124a:	f018                	sd	a4,32(s0)
    124c:	f41c                	sd	a5,40(s0)
    124e:	03043823          	sd	a6,48(s0)
    1252:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    1256:	00840613          	add	a2,s0,8
    125a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    125e:	85aa                	mv	a1,a0
    1260:	4505                	li	a0,1
    1262:	d29ff0ef          	jal	f8a <vprintf>
}
    1266:	60e2                	ld	ra,24(sp)
    1268:	6442                	ld	s0,16(sp)
    126a:	6125                	add	sp,sp,96
    126c:	8082                	ret

000000000000126e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    126e:	1141                	add	sp,sp,-16
    1270:	e422                	sd	s0,8(sp)
    1272:	0800                	add	s0,sp,16
  Header *bp, *p;

  if(ap == 0)
    1274:	cd3d                	beqz	a0,12f2 <free+0x84>
    return;
  if((uint64)ap < 4096)
    1276:	6785                	lui	a5,0x1
    1278:	06f56d63          	bltu	a0,a5,12f2 <free+0x84>
    return;
  bp = (Header*)ap - 1;
    127c:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1280:	00001797          	auipc	a5,0x1
    1284:	d987b783          	ld	a5,-616(a5) # 2018 <freep>
    1288:	a02d                	j	12b2 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    128a:	4618                	lw	a4,8(a2)
    128c:	9f2d                	addw	a4,a4,a1
    128e:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    1292:	6398                	ld	a4,0(a5)
    1294:	6310                	ld	a2,0(a4)
    1296:	a83d                	j	12d4 <free+0x66>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    1298:	ff852703          	lw	a4,-8(a0)
    129c:	9f31                	addw	a4,a4,a2
    129e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    12a0:	ff053683          	ld	a3,-16(a0)
    12a4:	a091                	j	12e8 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    12a6:	6398                	ld	a4,0(a5)
    12a8:	00e7e463          	bltu	a5,a4,12b0 <free+0x42>
    12ac:	00e6ea63          	bltu	a3,a4,12c0 <free+0x52>
{
    12b0:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    12b2:	fed7fae3          	bgeu	a5,a3,12a6 <free+0x38>
    12b6:	6398                	ld	a4,0(a5)
    12b8:	00e6e463          	bltu	a3,a4,12c0 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    12bc:	fee7eae3          	bltu	a5,a4,12b0 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
    12c0:	ff852583          	lw	a1,-8(a0)
    12c4:	6390                	ld	a2,0(a5)
    12c6:	02059813          	sll	a6,a1,0x20
    12ca:	01c85713          	srl	a4,a6,0x1c
    12ce:	9736                	add	a4,a4,a3
    12d0:	fae60de3          	beq	a2,a4,128a <free+0x1c>
    bp->s.ptr = p->s.ptr->s.ptr;
    12d4:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    12d8:	4790                	lw	a2,8(a5)
    12da:	02061593          	sll	a1,a2,0x20
    12de:	01c5d713          	srl	a4,a1,0x1c
    12e2:	973e                	add	a4,a4,a5
    12e4:	fae68ae3          	beq	a3,a4,1298 <free+0x2a>
    p->s.ptr = bp->s.ptr;
    12e8:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    12ea:	00001717          	auipc	a4,0x1
    12ee:	d2f73723          	sd	a5,-722(a4) # 2018 <freep>
}
    12f2:	6422                	ld	s0,8(sp)
    12f4:	0141                	add	sp,sp,16
    12f6:	8082                	ret

00000000000012f8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    12f8:	7139                	add	sp,sp,-64
    12fa:	fc06                	sd	ra,56(sp)
    12fc:	f822                	sd	s0,48(sp)
    12fe:	f426                	sd	s1,40(sp)
    1300:	ec4e                	sd	s3,24(sp)
    1302:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1304:	02051493          	sll	s1,a0,0x20
    1308:	9081                	srl	s1,s1,0x20
    130a:	04bd                	add	s1,s1,15
    130c:	8091                	srl	s1,s1,0x4
    130e:	0014899b          	addw	s3,s1,1
    1312:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
    1314:	00001517          	auipc	a0,0x1
    1318:	d0453503          	ld	a0,-764(a0) # 2018 <freep>
    131c:	c915                	beqz	a0,1350 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    131e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    1320:	4798                	lw	a4,8(a5)
    1322:	08977a63          	bgeu	a4,s1,13b6 <malloc+0xbe>
    1326:	f04a                	sd	s2,32(sp)
    1328:	e852                	sd	s4,16(sp)
    132a:	e456                	sd	s5,8(sp)
    132c:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    132e:	8a4e                	mv	s4,s3
    1330:	0009871b          	sext.w	a4,s3
    1334:	6685                	lui	a3,0x1
    1336:	00d77363          	bgeu	a4,a3,133c <malloc+0x44>
    133a:	6a05                	lui	s4,0x1
    133c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    1340:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1344:	00001917          	auipc	s2,0x1
    1348:	cd490913          	add	s2,s2,-812 # 2018 <freep>
  if(p == (char*)-1)
    134c:	5afd                	li	s5,-1
    134e:	a081                	j	138e <malloc+0x96>
    1350:	f04a                	sd	s2,32(sp)
    1352:	e852                	sd	s4,16(sp)
    1354:	e456                	sd	s5,8(sp)
    1356:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    1358:	00001797          	auipc	a5,0x1
    135c:	0b078793          	add	a5,a5,176 # 2408 <base>
    1360:	00001717          	auipc	a4,0x1
    1364:	caf73c23          	sd	a5,-840(a4) # 2018 <freep>
    1368:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    136a:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    136e:	b7c1                	j	132e <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
    1370:	6398                	ld	a4,0(a5)
    1372:	e118                	sd	a4,0(a0)
    1374:	a8a9                	j	13ce <malloc+0xd6>
  hp->s.size = nu;
    1376:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    137a:	0541                	add	a0,a0,16
    137c:	ef3ff0ef          	jal	126e <free>
  return freep;
    1380:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    1384:	c12d                	beqz	a0,13e6 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1386:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    1388:	4798                	lw	a4,8(a5)
    138a:	02977263          	bgeu	a4,s1,13ae <malloc+0xb6>
    if(p == freep)
    138e:	00093703          	ld	a4,0(s2)
    1392:	853e                	mv	a0,a5
    1394:	fef719e3          	bne	a4,a5,1386 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
    1398:	8552                	mv	a0,s4
    139a:	ab9ff0ef          	jal	e52 <sbrk>
  if(p == (char*)-1)
    139e:	fd551ce3          	bne	a0,s5,1376 <malloc+0x7e>
        return 0;
    13a2:	4501                	li	a0,0
    13a4:	7902                	ld	s2,32(sp)
    13a6:	6a42                	ld	s4,16(sp)
    13a8:	6aa2                	ld	s5,8(sp)
    13aa:	6b02                	ld	s6,0(sp)
    13ac:	a03d                	j	13da <malloc+0xe2>
    13ae:	7902                	ld	s2,32(sp)
    13b0:	6a42                	ld	s4,16(sp)
    13b2:	6aa2                	ld	s5,8(sp)
    13b4:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    13b6:	fae48de3          	beq	s1,a4,1370 <malloc+0x78>
        p->s.size -= nunits;
    13ba:	4137073b          	subw	a4,a4,s3
    13be:	c798                	sw	a4,8(a5)
        p += p->s.size;
    13c0:	02071693          	sll	a3,a4,0x20
    13c4:	01c6d713          	srl	a4,a3,0x1c
    13c8:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    13ca:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    13ce:	00001717          	auipc	a4,0x1
    13d2:	c4a73523          	sd	a0,-950(a4) # 2018 <freep>
      return (void*)(p + 1);
    13d6:	01078513          	add	a0,a5,16
  }
}
    13da:	70e2                	ld	ra,56(sp)
    13dc:	7442                	ld	s0,48(sp)
    13de:	74a2                	ld	s1,40(sp)
    13e0:	69e2                	ld	s3,24(sp)
    13e2:	6121                	add	sp,sp,64
    13e4:	8082                	ret
    13e6:	7902                	ld	s2,32(sp)
    13e8:	6a42                	ld	s4,16(sp)
    13ea:	6aa2                	ld	s5,8(sp)
    13ec:	6b02                	ld	s6,0(sp)
    13ee:	b7f5                	j	13da <malloc+0xe2>
