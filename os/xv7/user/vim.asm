
user/_vim:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <editor_set_status>:
  return np;
}

static void
editor_set_status(const char *msg)
{
       0:	1141                	add	sp,sp,-16
       2:	e422                	sd	s0,8(sp)
       4:	0800                	add	s0,sp,16
  while(src[i] && i < max - 1){
       6:	00054703          	lbu	a4,0(a0)
       a:	c329                	beqz	a4,4c <editor_set_status+0x4c>
       c:	4785                	li	a5,1
    dst[i] = src[i];
       e:	00003617          	auipc	a2,0x3
      12:	02260613          	add	a2,a2,34 # 3030 <E>
  while(src[i] && i < max - 1){
      16:	05000593          	li	a1,80
      1a:	a011                	j	1e <editor_set_status+0x1e>
      1c:	87b6                	mv	a5,a3
    dst[i] = src[i];
      1e:	00f606b3          	add	a3,a2,a5
      22:	02e68fa3          	sb	a4,63(a3)
  while(src[i] && i < max - 1){
      26:	00f50733          	add	a4,a0,a5
      2a:	00074703          	lbu	a4,0(a4)
      2e:	c709                	beqz	a4,38 <editor_set_status+0x38>
      30:	00178693          	add	a3,a5,1
      34:	feb694e3          	bne	a3,a1,1c <editor_set_status+0x1c>
  dst[i] = '\0';
      38:	00003717          	auipc	a4,0x3
      3c:	ff870713          	add	a4,a4,-8 # 3030 <E>
      40:	97ba                	add	a5,a5,a4
      42:	04078023          	sb	zero,64(a5)
  str_copy(E.statusmsg, sizeof(E.statusmsg), msg);
}
      46:	6422                	ld	s0,8(sp)
      48:	0141                	add	sp,sp,16
      4a:	8082                	ret
  while(src[i] && i < max - 1){
      4c:	4781                	li	a5,0
      4e:	b7ed                	j	38 <editor_set_status+0x38>

0000000000000050 <append_num>:
  ab_append(ab, "\x1b[K", 3);
}

static void
append_num(char *buf, int *pos, int max, int num)
{
      50:	1101                	add	sp,sp,-32
      52:	ec22                	sd	s0,24(sp)
      54:	1000                	add	s0,sp,32
  char tmp[16];
  int len = 0;
  int i;
  if(num == 0){
      56:	ca99                	beqz	a3,6c <append_num+0x1c>
    tmp[len++] = '0';
  } else {
    while(num > 0 && len < (int)sizeof(tmp)){
      58:	fe040e13          	add	t3,s0,-32
      5c:	ff040313          	add	t1,s0,-16
      60:	87f2                	mv	a5,t3
      tmp[len++] = '0' + (num % 10);
      62:	4829                	li	a6,10
    while(num > 0 && len < (int)sizeof(tmp)){
      64:	48a5                	li	a7,9
      66:	04d04b63          	bgtz	a3,bc <append_num+0x6c>
      6a:	a089                	j	ac <append_num+0x5c>
    tmp[len++] = '0';
      6c:	03000793          	li	a5,48
      70:	fef40023          	sb	a5,-32(s0)
      74:	4785                	li	a5,1
      76:	fe040713          	add	a4,s0,-32
      7a:	973e                	add	a4,a4,a5
      7c:	fdf40693          	add	a3,s0,-33
      80:	00f68833          	add	a6,a3,a5
      84:	37fd                	addw	a5,a5,-1
      86:	1782                	sll	a5,a5,0x20
      88:	9381                	srl	a5,a5,0x20
      8a:	40f80833          	sub	a6,a6,a5
      num /= 10;
    }
  }
  for(i = len - 1; i >= 0; i--){
    if(*pos >= max - 1)
      8e:	367d                	addw	a2,a2,-1
      90:	419c                	lw	a5,0(a1)
      92:	00c7dd63          	bge	a5,a2,ac <append_num+0x5c>
      break;
    buf[*pos] = tmp[i];
      96:	97aa                	add	a5,a5,a0
      98:	fff74683          	lbu	a3,-1(a4)
      9c:	00d78023          	sb	a3,0(a5)
    (*pos)++;
      a0:	419c                	lw	a5,0(a1)
      a2:	2785                	addw	a5,a5,1
      a4:	c19c                	sw	a5,0(a1)
  for(i = len - 1; i >= 0; i--){
      a6:	177d                	add	a4,a4,-1
      a8:	ff0714e3          	bne	a4,a6,90 <append_num+0x40>
  }
  buf[*pos] = '\0';
      ac:	419c                	lw	a5,0(a1)
      ae:	953e                	add	a0,a0,a5
      b0:	00050023          	sb	zero,0(a0)
}
      b4:	6462                	ld	s0,24(sp)
      b6:	6105                	add	sp,sp,32
      b8:	8082                	ret
      ba:	87ba                	mv	a5,a4
      tmp[len++] = '0' + (num % 10);
      bc:	0306e73b          	remw	a4,a3,a6
      c0:	0307071b          	addw	a4,a4,48
      c4:	00e78023          	sb	a4,0(a5)
      num /= 10;
      c8:	8736                	mv	a4,a3
      ca:	0306c6bb          	divw	a3,a3,a6
    while(num > 0 && len < (int)sizeof(tmp)){
      ce:	00e8d663          	bge	a7,a4,da <append_num+0x8a>
      d2:	00178713          	add	a4,a5,1
      d6:	fe6712e3          	bne	a4,t1,ba <append_num+0x6a>
      tmp[len++] = '0' + (num % 10);
      da:	41c787bb          	subw	a5,a5,t3
      de:	2785                	addw	a5,a5,1
  for(i = len - 1; i >= 0; i--){
      e0:	f8f04be3          	bgtz	a5,76 <append_num+0x26>
      e4:	b7e1                	j	ac <append_num+0x5c>

00000000000000e6 <editor_move_cursor>:
  E.last_coloff = E.coloff;
}

static void
editor_move_cursor(int key)
{
      e6:	1141                	add	sp,sp,-16
      e8:	e422                	sd	s0,8(sp)
      ea:	0800                	add	s0,sp,16
  struct erow *row = (E.cy >= E.numrows) ? 0 : &E.row[E.cy];
      ec:	00003797          	auipc	a5,0x3
      f0:	f4478793          	add	a5,a5,-188 # 3030 <E>
      f4:	43d8                	lw	a4,4(a5)
      f6:	5394                	lw	a3,32(a5)
      f8:	14d75663          	bge	a4,a3,244 <editor_move_cursor+0x15e>
      fc:	00171793          	sll	a5,a4,0x1
     100:	97ba                	add	a5,a5,a4
     102:	078e                	sll	a5,a5,0x3
     104:	00003617          	auipc	a2,0x3
     108:	f5463603          	ld	a2,-172(a2) # 3058 <E+0x28>
     10c:	963e                	add	a2,a2,a5
  switch(key){
     10e:	06b00793          	li	a5,107
     112:	10f50b63          	beq	a0,a5,228 <editor_move_cursor+0x142>
     116:	08a7c363          	blt	a5,a0,19c <editor_move_cursor+0xb6>
     11a:	03000793          	li	a5,48
     11e:	10f50c63          	beq	a0,a5,236 <editor_move_cursor+0x150>
     122:	02a7d263          	bge	a5,a0,146 <editor_move_cursor+0x60>
     126:	06800793          	li	a5,104
     12a:	0af50063          	beq	a0,a5,1ca <editor_move_cursor+0xe4>
     12e:	06a00793          	li	a5,106
     132:	02f51c63          	bne	a0,a5,16a <editor_move_cursor+0x84>
    if(E.cy != 0)
      E.cy--;
    break;
  case KEY_ARROW_DOWN:
  case 'j':
    if(E.cy + 1 < E.numrows)
     136:	2705                	addw	a4,a4,1
     138:	12d74e63          	blt	a4,a3,274 <editor_move_cursor+0x18e>
    if(row)
      E.cx = row->size;
    break;
  }

  row = (E.cy >= E.numrows) ? 0 : &E.row[E.cy];
     13c:	00003717          	auipc	a4,0x3
     140:	ef872703          	lw	a4,-264(a4) # 3034 <E+0x4>
     144:	a01d                	j	16a <editor_move_cursor+0x84>
  switch(key){
     146:	02400793          	li	a5,36
     14a:	02f51063          	bne	a0,a5,16a <editor_move_cursor+0x84>
    if(row)
     14e:	16060e63          	beqz	a2,2ca <editor_move_cursor+0x1e4>
      E.cx = row->size;
     152:	421c                	lw	a5,0(a2)
     154:	00003717          	auipc	a4,0x3
     158:	ecf72e23          	sw	a5,-292(a4) # 3030 <E>
  row = (E.cy >= E.numrows) ? 0 : &E.row[E.cy];
     15c:	00003717          	auipc	a4,0x3
     160:	ed872703          	lw	a4,-296(a4) # 3034 <E+0x4>
  int rowlen = row ? row->size : 0;
     164:	4781                	li	a5,0
  row = (E.cy >= E.numrows) ? 0 : &E.row[E.cy];
     166:	00d75e63          	bge	a4,a3,182 <editor_move_cursor+0x9c>
     16a:	00171793          	sll	a5,a4,0x1
     16e:	97ba                	add	a5,a5,a4
     170:	078e                	sll	a5,a5,0x3
     172:	00003717          	auipc	a4,0x3
     176:	ee673703          	ld	a4,-282(a4) # 3058 <E+0x28>
     17a:	973e                	add	a4,a4,a5
  int rowlen = row ? row->size : 0;
     17c:	4781                	li	a5,0
     17e:	c311                	beqz	a4,182 <editor_move_cursor+0x9c>
     180:	431c                	lw	a5,0(a4)
  if(E.cx > rowlen)
     182:	00003717          	auipc	a4,0x3
     186:	eae72703          	lw	a4,-338(a4) # 3030 <E>
     18a:	00e7d663          	bge	a5,a4,196 <editor_move_cursor+0xb0>
    E.cx = rowlen;
     18e:	00003717          	auipc	a4,0x3
     192:	eaf72123          	sw	a5,-350(a4) # 3030 <E>
}
     196:	6422                	ld	s0,8(sp)
     198:	0141                	add	sp,sp,16
     19a:	8082                	ret
  switch(key){
     19c:	3e900793          	li	a5,1001
     1a0:	12f50f63          	beq	a0,a5,2de <editor_move_cursor+0x1f8>
     1a4:	00a7db63          	bge	a5,a0,1ba <editor_move_cursor+0xd4>
     1a8:	3ea00793          	li	a5,1002
     1ac:	06f50e63          	beq	a0,a5,228 <editor_move_cursor+0x142>
     1b0:	3eb00793          	li	a5,1003
     1b4:	f8f501e3          	beq	a0,a5,136 <editor_move_cursor+0x50>
     1b8:	bf4d                	j	16a <editor_move_cursor+0x84>
     1ba:	06c00793          	li	a5,108
     1be:	12f50063          	beq	a0,a5,2de <editor_move_cursor+0x1f8>
     1c2:	3e800793          	li	a5,1000
     1c6:	faf512e3          	bne	a0,a5,16a <editor_move_cursor+0x84>
    if(E.cx != 0){
     1ca:	00003797          	auipc	a5,0x3
     1ce:	e667a783          	lw	a5,-410(a5) # 3030 <E>
     1d2:	c799                	beqz	a5,1e0 <editor_move_cursor+0xfa>
      E.cx--;
     1d4:	37fd                	addw	a5,a5,-1
     1d6:	00003717          	auipc	a4,0x3
     1da:	e4f72d23          	sw	a5,-422(a4) # 3030 <E>
     1de:	bfbd                	j	15c <editor_move_cursor+0x76>
    } else if(E.cy > 0){
     1e0:	04e05f63          	blez	a4,23e <editor_move_cursor+0x158>
      E.cy--;
     1e4:	377d                	addw	a4,a4,-1
     1e6:	0007059b          	sext.w	a1,a4
     1ea:	00003517          	auipc	a0,0x3
     1ee:	e4650513          	add	a0,a0,-442 # 3030 <E>
     1f2:	c158                	sw	a4,4(a0)
      E.cx = E.row[E.cy].size;
     1f4:	00159613          	sll	a2,a1,0x1
     1f8:	962e                	add	a2,a2,a1
     1fa:	060e                	sll	a2,a2,0x3
     1fc:	7518                	ld	a4,40(a0)
     1fe:	9732                	add	a4,a4,a2
     200:	4310                	lw	a2,0(a4)
     202:	c110                	sw	a2,0(a0)
  row = (E.cy >= E.numrows) ? 0 : &E.row[E.cy];
     204:	f6d5dfe3          	bge	a1,a3,182 <editor_move_cursor+0x9c>
     208:	bfa5                	j	180 <editor_move_cursor+0x9a>
    } else if(row && E.cx == row->size){
     20a:	f4c799e3          	bne	a5,a2,15c <editor_move_cursor+0x76>
      if(E.cy + 1 < E.numrows){
     20e:	2705                	addw	a4,a4,1
     210:	0007079b          	sext.w	a5,a4
     214:	f4d7d4e3          	bge	a5,a3,15c <editor_move_cursor+0x76>
        E.cy++;
     218:	00003797          	auipc	a5,0x3
     21c:	e1878793          	add	a5,a5,-488 # 3030 <E>
     220:	c3d8                	sw	a4,4(a5)
        E.cx = 0;
     222:	0007a023          	sw	zero,0(a5)
     226:	a899                	j	27c <editor_move_cursor+0x196>
    if(E.cy != 0)
     228:	db15                	beqz	a4,15c <editor_move_cursor+0x76>
      E.cy--;
     22a:	377d                	addw	a4,a4,-1
     22c:	00003797          	auipc	a5,0x3
     230:	e0e7a423          	sw	a4,-504(a5) # 3034 <E+0x4>
     234:	b725                	j	15c <editor_move_cursor+0x76>
    E.cx = 0;
     236:	00003797          	auipc	a5,0x3
     23a:	de07ad23          	sw	zero,-518(a5) # 3030 <E>
  row = (E.cy >= E.numrows) ? 0 : &E.row[E.cy];
     23e:	f4d75ce3          	bge	a4,a3,196 <editor_move_cursor+0xb0>
     242:	b725                	j	16a <editor_move_cursor+0x84>
  switch(key){
     244:	06b00793          	li	a5,107
     248:	fef500e3          	beq	a0,a5,228 <editor_move_cursor+0x142>
     24c:	04a7c563          	blt	a5,a0,296 <editor_move_cursor+0x1b0>
     250:	03000793          	li	a5,48
     254:	fef501e3          	beq	a0,a5,236 <editor_move_cursor+0x150>
     258:	02a7d763          	bge	a5,a0,286 <editor_move_cursor+0x1a0>
     25c:	06800793          	li	a5,104
     260:	f6f505e3          	beq	a0,a5,1ca <editor_move_cursor+0xe4>
     264:	06a00793          	li	a5,106
     268:	02f51563          	bne	a0,a5,292 <editor_move_cursor+0x1ac>
    if(E.cy + 1 < E.numrows)
     26c:	2705                	addw	a4,a4,1
  int rowlen = row ? row->size : 0;
     26e:	4781                	li	a5,0
    if(E.cy + 1 < E.numrows)
     270:	f0d759e3          	bge	a4,a3,182 <editor_move_cursor+0x9c>
      E.cy++;
     274:	00003797          	auipc	a5,0x3
     278:	dce7a023          	sw	a4,-576(a5) # 3034 <E+0x4>
  row = (E.cy >= E.numrows) ? 0 : &E.row[E.cy];
     27c:	00003717          	auipc	a4,0x3
     280:	db872703          	lw	a4,-584(a4) # 3034 <E+0x4>
     284:	b5dd                	j	16a <editor_move_cursor+0x84>
  switch(key){
     286:	02400793          	li	a5,36
     28a:	ecf509e3          	beq	a0,a5,15c <editor_move_cursor+0x76>
     28e:	4781                	li	a5,0
     290:	bdcd                	j	182 <editor_move_cursor+0x9c>
     292:	4781                	li	a5,0
     294:	b5fd                	j	182 <editor_move_cursor+0x9c>
     296:	3e900793          	li	a5,1001
     29a:	ecf501e3          	beq	a0,a5,15c <editor_move_cursor+0x76>
     29e:	00a7dc63          	bge	a5,a0,2b6 <editor_move_cursor+0x1d0>
     2a2:	3ea00793          	li	a5,1002
     2a6:	f8f501e3          	beq	a0,a5,228 <editor_move_cursor+0x142>
     2aa:	3eb00793          	li	a5,1003
     2ae:	faf50fe3          	beq	a0,a5,26c <editor_move_cursor+0x186>
     2b2:	4781                	li	a5,0
     2b4:	b5f9                	j	182 <editor_move_cursor+0x9c>
     2b6:	06c00793          	li	a5,108
     2ba:	eaf501e3          	beq	a0,a5,15c <editor_move_cursor+0x76>
     2be:	3e800793          	li	a5,1000
     2c2:	f0f504e3          	beq	a0,a5,1ca <editor_move_cursor+0xe4>
     2c6:	4781                	li	a5,0
     2c8:	bd6d                	j	182 <editor_move_cursor+0x9c>
  row = (E.cy >= E.numrows) ? 0 : &E.row[E.cy];
     2ca:	00003717          	auipc	a4,0x3
     2ce:	d6a72703          	lw	a4,-662(a4) # 3034 <E+0x4>
     2d2:	bd61                	j	16a <editor_move_cursor+0x84>
     2d4:	00003717          	auipc	a4,0x3
     2d8:	d6072703          	lw	a4,-672(a4) # 3034 <E+0x4>
     2dc:	b579                	j	16a <editor_move_cursor+0x84>
    if(row && E.cx < row->size){
     2de:	da7d                	beqz	a2,2d4 <editor_move_cursor+0x1ee>
     2e0:	00003797          	auipc	a5,0x3
     2e4:	d507a783          	lw	a5,-688(a5) # 3030 <E>
     2e8:	4210                	lw	a2,0(a2)
     2ea:	f2c7d0e3          	bge	a5,a2,20a <editor_move_cursor+0x124>
      E.cx++;
     2ee:	2785                	addw	a5,a5,1
     2f0:	00003717          	auipc	a4,0x3
     2f4:	d4f72023          	sw	a5,-704(a4) # 3030 <E>
     2f8:	b595                	j	15c <editor_move_cursor+0x76>

00000000000002fa <editor_try_quit>:
}

static int
editor_try_quit(int force)
{
  if(E.dirty && !force){
     2fa:	00003797          	auipc	a5,0x3
     2fe:	d667a783          	lw	a5,-666(a5) # 3060 <E+0x30>
     302:	c7a9                	beqz	a5,34c <editor_try_quit+0x52>
{
     304:	1101                	add	sp,sp,-32
     306:	ec06                	sd	ra,24(sp)
     308:	e822                	sd	s0,16(sp)
     30a:	e426                	sd	s1,8(sp)
     30c:	1000                	add	s0,sp,32
     30e:	84aa                	mv	s1,a0
      editor_set_status("Unsaved changes. Press Ctrl+Q again or use :q!");
      E.quit_times--;
      return 0;
    }
  }
  return 1;
     310:	4505                	li	a0,1
  if(E.dirty && !force){
     312:	e499                	bnez	s1,320 <editor_try_quit+0x26>
    if(E.quit_times > 0){
     314:	00003797          	auipc	a5,0x3
     318:	e007a783          	lw	a5,-512(a5) # 3114 <E+0xe4>
     31c:	00f04763          	bgtz	a5,32a <editor_try_quit+0x30>
}
     320:	60e2                	ld	ra,24(sp)
     322:	6442                	ld	s0,16(sp)
     324:	64a2                	ld	s1,8(sp)
     326:	6105                	add	sp,sp,32
     328:	8082                	ret
      editor_set_status("Unsaved changes. Press Ctrl+Q again or use :q!");
     32a:	00002517          	auipc	a0,0x2
     32e:	e1650513          	add	a0,a0,-490 # 2140 <malloc+0x106>
     332:	ccfff0ef          	jal	0 <editor_set_status>
      E.quit_times--;
     336:	00003717          	auipc	a4,0x3
     33a:	cfa70713          	add	a4,a4,-774 # 3030 <E>
     33e:	0e472783          	lw	a5,228(a4)
     342:	37fd                	addw	a5,a5,-1
     344:	0ef72223          	sw	a5,228(a4)
      return 0;
     348:	8526                	mv	a0,s1
     34a:	bfd9                	j	320 <editor_try_quit+0x26>
  return 1;
     34c:	4505                	li	a0,1
}
     34e:	8082                	ret

0000000000000350 <editor_row_del_char>:
  if(at < 0 || at >= row->size)
     350:	0405c563          	bltz	a1,39a <editor_row_del_char+0x4a>
{
     354:	1101                	add	sp,sp,-32
     356:	ec06                	sd	ra,24(sp)
     358:	e822                	sd	s0,16(sp)
     35a:	e426                	sd	s1,8(sp)
     35c:	1000                	add	s0,sp,32
     35e:	84aa                	mv	s1,a0
     360:	87ae                	mv	a5,a1
  if(at < 0 || at >= row->size)
     362:	4110                	lw	a2,0(a0)
     364:	00c5c763          	blt	a1,a2,372 <editor_row_del_char+0x22>
}
     368:	60e2                	ld	ra,24(sp)
     36a:	6442                	ld	s0,16(sp)
     36c:	64a2                	ld	s1,8(sp)
     36e:	6105                	add	sp,sp,32
     370:	8082                	ret
  memmove(&row->chars[at], &row->chars[at + 1], row->size - at - 1);
     372:	6508                	ld	a0,8(a0)
     374:	9e0d                	subw	a2,a2,a1
     376:	0585                	add	a1,a1,1
     378:	367d                	addw	a2,a2,-1
     37a:	95aa                	add	a1,a1,a0
     37c:	953e                	add	a0,a0,a5
     37e:	464010ef          	jal	17e2 <memmove>
  row->size--;
     382:	409c                	lw	a5,0(s1)
     384:	37fd                	addw	a5,a5,-1
     386:	0007871b          	sext.w	a4,a5
     38a:	c09c                	sw	a5,0(s1)
  row->chars[row->size] = '\0';
     38c:	649c                	ld	a5,8(s1)
     38e:	97ba                	add	a5,a5,a4
     390:	00078023          	sb	zero,0(a5)
  row->dirty = 1;
     394:	4785                	li	a5,1
     396:	c89c                	sw	a5,16(s1)
     398:	bfc1                	j	368 <editor_row_del_char+0x18>
     39a:	8082                	ret

000000000000039c <editor_del_row>:
  if(at < 0 || at >= E.numrows)
     39c:	0a054963          	bltz	a0,44e <editor_del_row+0xb2>
{
     3a0:	1101                	add	sp,sp,-32
     3a2:	ec06                	sd	ra,24(sp)
     3a4:	e822                	sd	s0,16(sp)
     3a6:	e426                	sd	s1,8(sp)
     3a8:	1000                	add	s0,sp,32
     3aa:	84aa                	mv	s1,a0
  if(at < 0 || at >= E.numrows)
     3ac:	00003797          	auipc	a5,0x3
     3b0:	ca47a783          	lw	a5,-860(a5) # 3050 <E+0x20>
     3b4:	00f54763          	blt	a0,a5,3c2 <editor_del_row+0x26>
}
     3b8:	60e2                	ld	ra,24(sp)
     3ba:	6442                	ld	s0,16(sp)
     3bc:	64a2                	ld	s1,8(sp)
     3be:	6105                	add	sp,sp,32
     3c0:	8082                	ret
     3c2:	e04a                	sd	s2,0(sp)
  editor_free_row(&E.row[at]);
     3c4:	00151713          	sll	a4,a0,0x1
     3c8:	972a                	add	a4,a4,a0
     3ca:	00371913          	sll	s2,a4,0x3
  if(row->chars)
     3ce:	00003797          	auipc	a5,0x3
     3d2:	c8a7b783          	ld	a5,-886(a5) # 3058 <E+0x28>
     3d6:	97ca                	add	a5,a5,s2
     3d8:	6788                	ld	a0,8(a5)
     3da:	c119                	beqz	a0,3e0 <editor_del_row+0x44>
    free(row->chars);
     3dc:	3d5010ef          	jal	1fb0 <free>
  for(i = at; i < E.numrows - 1; i++)
     3e0:	00003797          	auipc	a5,0x3
     3e4:	c707a783          	lw	a5,-912(a5) # 3050 <E+0x20>
     3e8:	37fd                	addw	a5,a5,-1
     3ea:	02f4d963          	bge	s1,a5,41c <editor_del_row+0x80>
     3ee:	01890713          	add	a4,s2,24
    E.row[i] = E.row[i + 1];
     3f2:	00003697          	auipc	a3,0x3
     3f6:	c3e68693          	add	a3,a3,-962 # 3030 <E>
     3fa:	769c                	ld	a5,40(a3)
     3fc:	97ba                	add	a5,a5,a4
     3fe:	6390                	ld	a2,0(a5)
     400:	fec7b423          	sd	a2,-24(a5)
     404:	6790                	ld	a2,8(a5)
     406:	fec7b823          	sd	a2,-16(a5)
     40a:	6b90                	ld	a2,16(a5)
     40c:	fec7bc23          	sd	a2,-8(a5)
  for(i = at; i < E.numrows - 1; i++)
     410:	2485                	addw	s1,s1,1
     412:	529c                	lw	a5,32(a3)
     414:	37fd                	addw	a5,a5,-1
     416:	0761                	add	a4,a4,24
     418:	fef4c1e3          	blt	s1,a5,3fa <editor_del_row+0x5e>
  E.numrows--;
     41c:	00003717          	auipc	a4,0x3
     420:	c2f72a23          	sw	a5,-972(a4) # 3050 <E+0x20>
  if(E.numrows == 0){
     424:	cb99                	beqz	a5,43a <editor_del_row+0x9e>
  E.dirty = 1;
     426:	00003797          	auipc	a5,0x3
     42a:	c0a78793          	add	a5,a5,-1014 # 3030 <E>
     42e:	4705                	li	a4,1
     430:	db98                	sw	a4,48(a5)
  E.screen_dirty = 1;
     432:	0ee7a623          	sw	a4,236(a5)
     436:	6902                	ld	s2,0(sp)
     438:	b741                	j	3b8 <editor_del_row+0x1c>
    free(E.row);
     43a:	00003497          	auipc	s1,0x3
     43e:	bf648493          	add	s1,s1,-1034 # 3030 <E>
     442:	7488                	ld	a0,40(s1)
     444:	36d010ef          	jal	1fb0 <free>
    E.row = 0;
     448:	0204b423          	sd	zero,40(s1)
     44c:	bfe9                	j	426 <editor_del_row+0x8a>
     44e:	8082                	ret

0000000000000450 <str_dup>:
{
     450:	7179                	add	sp,sp,-48
     452:	f406                	sd	ra,40(sp)
     454:	f022                	sd	s0,32(sp)
     456:	ec26                	sd	s1,24(sp)
     458:	e84a                	sd	s2,16(sp)
     45a:	e44e                	sd	s3,8(sp)
     45c:	1800                	add	s0,sp,48
     45e:	89aa                	mv	s3,a0
  int len = strlen(s);
     460:	220010ef          	jal	1680 <strlen>
     464:	0005091b          	sext.w	s2,a0
  char *p = malloc(len + 1);
     468:	2505                	addw	a0,a0,1
     46a:	3d1010ef          	jal	203a <malloc>
     46e:	84aa                	mv	s1,a0
  if(p == 0)
     470:	c901                	beqz	a0,480 <str_dup+0x30>
  memmove(p, s, len);
     472:	864a                	mv	a2,s2
     474:	85ce                	mv	a1,s3
     476:	36c010ef          	jal	17e2 <memmove>
  p[len] = '\0';
     47a:	9926                	add	s2,s2,s1
     47c:	00090023          	sb	zero,0(s2)
}
     480:	8526                	mv	a0,s1
     482:	70a2                	ld	ra,40(sp)
     484:	7402                	ld	s0,32(sp)
     486:	64e2                	ld	s1,24(sp)
     488:	6942                	ld	s2,16(sp)
     48a:	69a2                	ld	s3,8(sp)
     48c:	6145                	add	sp,sp,48
     48e:	8082                	ret

0000000000000490 <mem_realloc>:
{
     490:	7179                	add	sp,sp,-48
     492:	f406                	sd	ra,40(sp)
     494:	f022                	sd	s0,32(sp)
     496:	ec26                	sd	s1,24(sp)
     498:	e84a                	sd	s2,16(sp)
     49a:	e44e                	sd	s3,8(sp)
     49c:	e052                	sd	s4,0(sp)
     49e:	1800                	add	s0,sp,48
     4a0:	89aa                	mv	s3,a0
     4a2:	8a2e                	mv	s4,a1
     4a4:	8932                	mv	s2,a2
  void *np = malloc(newlen);
     4a6:	8532                	mv	a0,a2
     4a8:	393010ef          	jal	203a <malloc>
     4ac:	84aa                	mv	s1,a0
  if(np == 0)
     4ae:	cd09                	beqz	a0,4c8 <mem_realloc+0x38>
  if(p){
     4b0:	00098c63          	beqz	s3,4c8 <mem_realloc+0x38>
    int copylen = oldlen < newlen ? oldlen : newlen;
     4b4:	864a                	mv	a2,s2
     4b6:	012a5363          	bge	s4,s2,4bc <mem_realloc+0x2c>
     4ba:	8652                	mv	a2,s4
     4bc:	2601                	sext.w	a2,a2
    if(copylen > 0)
     4be:	00c04e63          	bgtz	a2,4da <mem_realloc+0x4a>
    free(p);
     4c2:	854e                	mv	a0,s3
     4c4:	2ed010ef          	jal	1fb0 <free>
}
     4c8:	8526                	mv	a0,s1
     4ca:	70a2                	ld	ra,40(sp)
     4cc:	7402                	ld	s0,32(sp)
     4ce:	64e2                	ld	s1,24(sp)
     4d0:	6942                	ld	s2,16(sp)
     4d2:	69a2                	ld	s3,8(sp)
     4d4:	6a02                	ld	s4,0(sp)
     4d6:	6145                	add	sp,sp,48
     4d8:	8082                	ret
      memmove(np, p, copylen);
     4da:	85ce                	mv	a1,s3
     4dc:	8526                	mv	a0,s1
     4de:	304010ef          	jal	17e2 <memmove>
     4e2:	b7c5                	j	4c2 <mem_realloc+0x32>

00000000000004e4 <editor_insert_row>:
  if(at < 0 || at > E.numrows)
     4e4:	12054c63          	bltz	a0,61c <editor_insert_row+0x138>
{
     4e8:	7139                	add	sp,sp,-64
     4ea:	fc06                	sd	ra,56(sp)
     4ec:	f822                	sd	s0,48(sp)
     4ee:	f426                	sd	s1,40(sp)
     4f0:	f04a                	sd	s2,32(sp)
     4f2:	ec4e                	sd	s3,24(sp)
     4f4:	0080                	add	s0,sp,64
     4f6:	84aa                	mv	s1,a0
     4f8:	89ae                	mv	s3,a1
     4fa:	8932                	mv	s2,a2
  if(at < 0 || at > E.numrows)
     4fc:	00003797          	auipc	a5,0x3
     500:	b547a783          	lw	a5,-1196(a5) # 3050 <E+0x20>
     504:	00a7d963          	bge	a5,a0,516 <editor_insert_row+0x32>
}
     508:	70e2                	ld	ra,56(sp)
     50a:	7442                	ld	s0,48(sp)
     50c:	74a2                	ld	s1,40(sp)
     50e:	7902                	ld	s2,32(sp)
     510:	69e2                	ld	s3,24(sp)
     512:	6121                	add	sp,sp,64
     514:	8082                	ret
     516:	e852                	sd	s4,16(sp)
                      sizeof(struct erow) * (E.numrows + 1));
     518:	0017871b          	addw	a4,a5,1
  E.row = mem_realloc(E.row, sizeof(struct erow) * E.numrows,
     51c:	0017161b          	sllw	a2,a4,0x1
     520:	9e39                	addw	a2,a2,a4
     522:	0017959b          	sllw	a1,a5,0x1
     526:	9dbd                	addw	a1,a1,a5
     528:	00003a17          	auipc	s4,0x3
     52c:	b08a0a13          	add	s4,s4,-1272 # 3030 <E>
     530:	0036161b          	sllw	a2,a2,0x3
     534:	0035959b          	sllw	a1,a1,0x3
     538:	028a3503          	ld	a0,40(s4)
     53c:	f55ff0ef          	jal	490 <mem_realloc>
     540:	02aa3423          	sd	a0,40(s4)
  if(E.row == 0)
     544:	c971                	beqz	a0,618 <editor_insert_row+0x134>
     546:	e456                	sd	s5,8(sp)
  for(i = E.numrows; i > at; i--)
     548:	00003797          	auipc	a5,0x3
     54c:	b087a783          	lw	a5,-1272(a5) # 3050 <E+0x20>
     550:	02f4df63          	bge	s1,a5,58e <editor_insert_row+0xaa>
     554:	00179713          	sll	a4,a5,0x1
     558:	973e                	add	a4,a4,a5
     55a:	070e                	sll	a4,a4,0x3
     55c:	1721                	add	a4,a4,-24
     55e:	fff7869b          	addw	a3,a5,-1
     562:	9e85                	subw	a3,a3,s1
     564:	1682                	sll	a3,a3,0x20
     566:	9281                	srl	a3,a3,0x20
     568:	8f95                	sub	a5,a5,a3
     56a:	00179613          	sll	a2,a5,0x1
     56e:	963e                	add	a2,a2,a5
     570:	060e                	sll	a2,a2,0x3
     572:	fd060613          	add	a2,a2,-48
    E.row[i] = E.row[i - 1];
     576:	85d2                	mv	a1,s4
     578:	759c                	ld	a5,40(a1)
     57a:	97ba                	add	a5,a5,a4
     57c:	6394                	ld	a3,0(a5)
     57e:	ef94                	sd	a3,24(a5)
     580:	6794                	ld	a3,8(a5)
     582:	f394                	sd	a3,32(a5)
     584:	6b94                	ld	a3,16(a5)
     586:	f794                	sd	a3,40(a5)
  for(i = E.numrows; i > at; i--)
     588:	1721                	add	a4,a4,-24
     58a:	fec717e3          	bne	a4,a2,578 <editor_insert_row+0x94>
  E.row[at].size = len;
     58e:	00149793          	sll	a5,s1,0x1
     592:	94be                	add	s1,s1,a5
     594:	048e                	sll	s1,s1,0x3
     596:	00003a17          	auipc	s4,0x3
     59a:	a9aa0a13          	add	s4,s4,-1382 # 3030 <E>
     59e:	028a3783          	ld	a5,40(s4)
     5a2:	97a6                	add	a5,a5,s1
     5a4:	0127a023          	sw	s2,0(a5)
  E.row[at].chars = malloc(len + 1);
     5a8:	028a3a83          	ld	s5,40(s4)
     5ac:	9aa6                	add	s5,s5,s1
     5ae:	0019051b          	addw	a0,s2,1
     5b2:	289010ef          	jal	203a <malloc>
     5b6:	00aab423          	sd	a0,8(s5)
  if(E.row[at].chars == 0){
     5ba:	028a3783          	ld	a5,40(s4)
     5be:	97a6                	add	a5,a5,s1
     5c0:	6788                	ld	a0,8(a5)
     5c2:	c129                	beqz	a0,604 <editor_insert_row+0x120>
    memmove(E.row[at].chars, s, len);
     5c4:	864a                	mv	a2,s2
     5c6:	85ce                	mv	a1,s3
     5c8:	21a010ef          	jal	17e2 <memmove>
    E.row[at].chars[len] = '\0';
     5cc:	00003717          	auipc	a4,0x3
     5d0:	a6470713          	add	a4,a4,-1436 # 3030 <E>
     5d4:	771c                	ld	a5,40(a4)
     5d6:	97a6                	add	a5,a5,s1
     5d8:	679c                	ld	a5,8(a5)
     5da:	97ca                	add	a5,a5,s2
     5dc:	00078023          	sb	zero,0(a5)
    E.row[at].dirty = 1;
     5e0:	771c                	ld	a5,40(a4)
     5e2:	97a6                	add	a5,a5,s1
     5e4:	4705                	li	a4,1
     5e6:	cb98                	sw	a4,16(a5)
  E.numrows++;
     5e8:	00003797          	auipc	a5,0x3
     5ec:	a4878793          	add	a5,a5,-1464 # 3030 <E>
     5f0:	5398                	lw	a4,32(a5)
     5f2:	2705                	addw	a4,a4,1
     5f4:	d398                	sw	a4,32(a5)
  E.dirty = 1;
     5f6:	4705                	li	a4,1
     5f8:	db98                	sw	a4,48(a5)
  E.screen_dirty = 1;
     5fa:	0ee7a623          	sw	a4,236(a5)
     5fe:	6a42                	ld	s4,16(sp)
     600:	6aa2                	ld	s5,8(sp)
     602:	b719                	j	508 <editor_insert_row+0x24>
    E.row[at].size = 0;
     604:	0007a023          	sw	zero,0(a5)
    E.row[at].dirty = 1;
     608:	00003797          	auipc	a5,0x3
     60c:	a507b783          	ld	a5,-1456(a5) # 3058 <E+0x28>
     610:	97a6                	add	a5,a5,s1
     612:	4705                	li	a4,1
     614:	cb98                	sw	a4,16(a5)
     616:	bfc9                	j	5e8 <editor_insert_row+0x104>
     618:	6a42                	ld	s4,16(sp)
     61a:	b5fd                	j	508 <editor_insert_row+0x24>
     61c:	8082                	ret

000000000000061e <ab_append>:
  if(len <= 0)
     61e:	06c05063          	blez	a2,67e <ab_append+0x60>
{
     622:	7179                	add	sp,sp,-48
     624:	f406                	sd	ra,40(sp)
     626:	f022                	sd	s0,32(sp)
     628:	ec26                	sd	s1,24(sp)
     62a:	e84a                	sd	s2,16(sp)
     62c:	e44e                	sd	s3,8(sp)
     62e:	e052                	sd	s4,0(sp)
     630:	1800                	add	s0,sp,48
     632:	84aa                	mv	s1,a0
     634:	89ae                	mv	s3,a1
     636:	8932                	mv	s2,a2
  char *newbuf = malloc(ab->len + len);
     638:	4508                	lw	a0,8(a0)
     63a:	9d31                	addw	a0,a0,a2
     63c:	1ff010ef          	jal	203a <malloc>
     640:	8a2a                	mv	s4,a0
  if(newbuf == 0)
     642:	c115                	beqz	a0,666 <ab_append+0x48>
  if(ab->len)
     644:	4490                	lw	a2,8(s1)
     646:	ea05                	bnez	a2,676 <ab_append+0x58>
  memmove(newbuf + ab->len, s, len);
     648:	4488                	lw	a0,8(s1)
     64a:	864a                	mv	a2,s2
     64c:	85ce                	mv	a1,s3
     64e:	9552                	add	a0,a0,s4
     650:	192010ef          	jal	17e2 <memmove>
  free(ab->b);
     654:	6088                	ld	a0,0(s1)
     656:	15b010ef          	jal	1fb0 <free>
  ab->b = newbuf;
     65a:	0144b023          	sd	s4,0(s1)
  ab->len += len;
     65e:	449c                	lw	a5,8(s1)
     660:	012787bb          	addw	a5,a5,s2
     664:	c49c                	sw	a5,8(s1)
}
     666:	70a2                	ld	ra,40(sp)
     668:	7402                	ld	s0,32(sp)
     66a:	64e2                	ld	s1,24(sp)
     66c:	6942                	ld	s2,16(sp)
     66e:	69a2                	ld	s3,8(sp)
     670:	6a02                	ld	s4,0(sp)
     672:	6145                	add	sp,sp,48
     674:	8082                	ret
    memmove(newbuf, ab->b, ab->len);
     676:	608c                	ld	a1,0(s1)
     678:	16a010ef          	jal	17e2 <memmove>
     67c:	b7f1                	j	648 <ab_append+0x2a>
     67e:	8082                	ret

0000000000000680 <editor_save>:
{
     680:	715d                	add	sp,sp,-80
     682:	e486                	sd	ra,72(sp)
     684:	e0a2                	sd	s0,64(sp)
     686:	0880                	add	s0,sp,80
  if(E.filename == 0){
     688:	00003797          	auipc	a5,0x3
     68c:	9e07b783          	ld	a5,-1568(a5) # 3068 <E+0x38>
     690:	0e078a63          	beqz	a5,784 <editor_save+0x104>
     694:	fc26                	sd	s1,56(sp)
     696:	f84a                	sd	s2,48(sp)
     698:	f44e                	sd	s3,40(sp)
     69a:	ec56                	sd	s5,24(sp)
  for(j = 0; j < E.numrows; j++)
     69c:	00003697          	auipc	a3,0x3
     6a0:	9b46a683          	lw	a3,-1612(a3) # 3050 <E+0x20>
     6a4:	0ed05763          	blez	a3,792 <editor_save+0x112>
     6a8:	00003797          	auipc	a5,0x3
     6ac:	9b07b783          	ld	a5,-1616(a5) # 3058 <E+0x28>
     6b0:	00169713          	sll	a4,a3,0x1
     6b4:	9736                	add	a4,a4,a3
     6b6:	070e                	sll	a4,a4,0x3
     6b8:	973e                	add	a4,a4,a5
  int totlen = 0;
     6ba:	4901                	li	s2,0
    totlen += E.row[j].size + 1;
     6bc:	4388                	lw	a0,0(a5)
     6be:	2505                	addw	a0,a0,1
     6c0:	0125053b          	addw	a0,a0,s2
     6c4:	0005091b          	sext.w	s2,a0
  for(j = 0; j < E.numrows; j++)
     6c8:	07e1                	add	a5,a5,24
     6ca:	fee799e3          	bne	a5,a4,6bc <editor_save+0x3c>
  if(totlen == 0){
     6ce:	0c090263          	beqz	s2,792 <editor_save+0x112>
  buf = malloc(totlen);
     6d2:	2501                	sext.w	a0,a0
     6d4:	167010ef          	jal	203a <malloc>
     6d8:	8aaa                	mv	s5,a0
  if(buf == 0)
     6da:	c171                	beqz	a0,79e <editor_save+0x11e>
  for(j = 0; j < E.numrows; j++){
     6dc:	00003797          	auipc	a5,0x3
     6e0:	9747a783          	lw	a5,-1676(a5) # 3050 <E+0x20>
     6e4:	04f05763          	blez	a5,732 <editor_save+0xb2>
     6e8:	f052                	sd	s4,32(sp)
     6ea:	e85a                	sd	s6,16(sp)
     6ec:	e45e                	sd	s7,8(sp)
  p = buf;
     6ee:	8baa                	mv	s7,a0
  for(j = 0; j < E.numrows; j++){
     6f0:	4481                	li	s1,0
     6f2:	4a01                	li	s4,0
    memmove(p, E.row[j].chars, E.row[j].size);
     6f4:	00003997          	auipc	s3,0x3
     6f8:	93c98993          	add	s3,s3,-1732 # 3030 <E>
    *p = '\n';
     6fc:	4b29                	li	s6,10
    memmove(p, E.row[j].chars, E.row[j].size);
     6fe:	0289b783          	ld	a5,40(s3)
     702:	97a6                	add	a5,a5,s1
     704:	4390                	lw	a2,0(a5)
     706:	678c                	ld	a1,8(a5)
     708:	855e                	mv	a0,s7
     70a:	0d8010ef          	jal	17e2 <memmove>
    p += E.row[j].size;
     70e:	0289b783          	ld	a5,40(s3)
     712:	97a6                	add	a5,a5,s1
     714:	439c                	lw	a5,0(a5)
     716:	97de                	add	a5,a5,s7
    *p = '\n';
     718:	01678023          	sb	s6,0(a5)
    p++;
     71c:	00178b93          	add	s7,a5,1
  for(j = 0; j < E.numrows; j++){
     720:	2a05                	addw	s4,s4,1
     722:	04e1                	add	s1,s1,24
     724:	0209a783          	lw	a5,32(s3)
     728:	fcfa4be3          	blt	s4,a5,6fe <editor_save+0x7e>
     72c:	7a02                	ld	s4,32(sp)
     72e:	6b42                	ld	s6,16(sp)
     730:	6ba2                	ld	s7,8(sp)
  fd = open(E.filename, O_WRONLY | O_CREATE | O_TRUNC);
     732:	60100593          	li	a1,1537
     736:	00003517          	auipc	a0,0x3
     73a:	93253503          	ld	a0,-1742(a0) # 3068 <E+0x38>
     73e:	40e010ef          	jal	1b4c <open>
     742:	84aa                	mv	s1,a0
  if(fd >= 0){
     744:	00054f63          	bltz	a0,762 <editor_save+0xe2>
    int wrote = write(fd, buf, len);
     748:	864a                	mv	a2,s2
     74a:	85d6                	mv	a1,s5
     74c:	3e0010ef          	jal	1b2c <write>
     750:	89aa                	mv	s3,a0
    close(fd);
     752:	8526                	mv	a0,s1
     754:	3e0010ef          	jal	1b34 <close>
    free(buf);
     758:	8556                	mv	a0,s5
     75a:	057010ef          	jal	1fb0 <free>
    if(wrote == len){
     75e:	05298b63          	beq	s3,s2,7b4 <editor_save+0x134>
  free(buf);
     762:	8556                	mv	a0,s5
     764:	04d010ef          	jal	1fb0 <free>
  editor_set_status("Save failed");
     768:	00002517          	auipc	a0,0x2
     76c:	a6050513          	add	a0,a0,-1440 # 21c8 <malloc+0x18e>
     770:	891ff0ef          	jal	0 <editor_set_status>
     774:	74e2                	ld	s1,56(sp)
     776:	7942                	ld	s2,48(sp)
     778:	79a2                	ld	s3,40(sp)
     77a:	6ae2                	ld	s5,24(sp)
}
     77c:	60a6                	ld	ra,72(sp)
     77e:	6406                	ld	s0,64(sp)
     780:	6161                	add	sp,sp,80
     782:	8082                	ret
    editor_set_status("No file name. Use :w <name>");
     784:	00002517          	auipc	a0,0x2
     788:	9f450513          	add	a0,a0,-1548 # 2178 <malloc+0x13e>
     78c:	875ff0ef          	jal	0 <editor_set_status>
    return;
     790:	b7f5                	j	77c <editor_save+0xfc>
    buf = malloc(1);
     792:	4505                	li	a0,1
     794:	0a7010ef          	jal	203a <malloc>
     798:	8aaa                	mv	s5,a0
  if(buf == 0){
     79a:	4901                	li	s2,0
     79c:	f959                	bnez	a0,732 <editor_save+0xb2>
    editor_set_status("Save failed: out of memory");
     79e:	00002517          	auipc	a0,0x2
     7a2:	9fa50513          	add	a0,a0,-1542 # 2198 <malloc+0x15e>
     7a6:	85bff0ef          	jal	0 <editor_set_status>
    return;
     7aa:	74e2                	ld	s1,56(sp)
     7ac:	7942                	ld	s2,48(sp)
     7ae:	79a2                	ld	s3,40(sp)
     7b0:	6ae2                	ld	s5,24(sp)
     7b2:	b7e9                	j	77c <editor_save+0xfc>
      E.dirty = 0;
     7b4:	00003797          	auipc	a5,0x3
     7b8:	8a07a623          	sw	zero,-1876(a5) # 3060 <E+0x30>
      editor_set_status("File saved");
     7bc:	00002517          	auipc	a0,0x2
     7c0:	9fc50513          	add	a0,a0,-1540 # 21b8 <malloc+0x17e>
     7c4:	83dff0ef          	jal	0 <editor_set_status>
      return;
     7c8:	74e2                	ld	s1,56(sp)
     7ca:	7942                	ld	s2,48(sp)
     7cc:	79a2                	ld	s3,40(sp)
     7ce:	6ae2                	ld	s5,24(sp)
     7d0:	b775                	j	77c <editor_save+0xfc>

00000000000007d2 <editor_quit>:
  write(1, "\x1b[H", 3);
}

static void
editor_quit(void)
{
     7d2:	1141                	add	sp,sp,-16
     7d4:	e406                	sd	ra,8(sp)
     7d6:	e022                	sd	s0,0(sp)
     7d8:	0800                	add	s0,sp,16
  if(E.saved_mode >= 0)
     7da:	00003517          	auipc	a0,0x3
     7de:	93e52503          	lw	a0,-1730(a0) # 3118 <E+0xe8>
     7e2:	02055d63          	bgez	a0,81c <editor_quit+0x4a>
  write(1, "\x1b[?7h", 5);
     7e6:	4615                	li	a2,5
     7e8:	00002597          	auipc	a1,0x2
     7ec:	9f058593          	add	a1,a1,-1552 # 21d8 <malloc+0x19e>
     7f0:	4505                	li	a0,1
     7f2:	33a010ef          	jal	1b2c <write>
  write(1, "\x1b[2J", 4);
     7f6:	4611                	li	a2,4
     7f8:	00002597          	auipc	a1,0x2
     7fc:	9e858593          	add	a1,a1,-1560 # 21e0 <malloc+0x1a6>
     800:	4505                	li	a0,1
     802:	32a010ef          	jal	1b2c <write>
  write(1, "\x1b[H", 3);
     806:	460d                	li	a2,3
     808:	00002597          	auipc	a1,0x2
     80c:	9e058593          	add	a1,a1,-1568 # 21e8 <malloc+0x1ae>
     810:	4505                	li	a0,1
     812:	31a010ef          	jal	1b2c <write>
  editor_cleanup();
  exit(0);
     816:	4501                	li	a0,0
     818:	2f4010ef          	jal	1b0c <exit>
    consolemode((E.saved_mode & 1) ? 1 : 0, (E.saved_mode & 2) ? 1 : 0);
     81c:	4015559b          	sraw	a1,a0,0x1
     820:	8985                	and	a1,a1,1
     822:	8905                	and	a0,a0,1
     824:	3d8010ef          	jal	1bfc <consolemode>
     828:	bf7d                	j	7e6 <editor_quit+0x14>

000000000000082a <editor_read_key>:
{
     82a:	1101                	add	sp,sp,-32
     82c:	ec06                	sd	ra,24(sp)
     82e:	e822                	sd	s0,16(sp)
     830:	e426                	sd	s1,8(sp)
     832:	e04a                	sd	s2,0(sp)
     834:	1000                	add	s0,sp,32
    if(esc_state != 0 && bufpos >= buflen){
     836:	00002497          	auipc	s1,0x2
     83a:	7e648493          	add	s1,s1,2022 # 301c <esc_state.5>
    if(esc_state == 1){
     83e:	4905                	li	s2,1
    if(esc_state != 0 && bufpos >= buflen){
     840:	409c                	lw	a5,0(s1)
     842:	c7ad                	beqz	a5,8ac <editor_read_key+0x82>
     844:	00002717          	auipc	a4,0x2
     848:	7d472703          	lw	a4,2004(a4) # 3018 <bufpos.4>
     84c:	00002797          	auipc	a5,0x2
     850:	7c87a783          	lw	a5,1992(a5) # 3014 <buflen.3>
     854:	02f75863          	bge	a4,a5,884 <editor_read_key+0x5a>
    if(pushback >= 0){
     858:	00002797          	auipc	a5,0x2
     85c:	7a87a783          	lw	a5,1960(a5) # 3000 <pushback.1>
     860:	0407dc63          	bgez	a5,8b8 <editor_read_key+0x8e>
      c = buf[bufpos++];
     864:	00002797          	auipc	a5,0x2
     868:	7b478793          	add	a5,a5,1972 # 3018 <bufpos.4>
     86c:	4398                	lw	a4,0(a5)
     86e:	0017069b          	addw	a3,a4,1
     872:	c394                	sw	a3,0(a5)
     874:	00002797          	auipc	a5,0x2
     878:	7bc78793          	add	a5,a5,1980 # 3030 <E>
     87c:	97ba                	add	a5,a5,a4
     87e:	0f07c783          	lbu	a5,240(a5)
     882:	a091                	j	8c6 <editor_read_key+0x9c>
      if(uptime() - esc_tick > 5){
     884:	320010ef          	jal	1ba4 <uptime>
     888:	00002797          	auipc	a5,0x2
     88c:	7887a783          	lw	a5,1928(a5) # 3010 <esc_tick.2>
     890:	9d1d                	subw	a0,a0,a5
     892:	4795                	li	a5,5
     894:	00a7f863          	bgeu	a5,a0,8a4 <editor_read_key+0x7a>
        esc_state = 0;
     898:	00002797          	auipc	a5,0x2
     89c:	7807a223          	sw	zero,1924(a5) # 301c <esc_state.5>
        return '\x1b';
     8a0:	456d                	li	a0,27
     8a2:	a82d                	j	8dc <editor_read_key+0xb2>
      sleep(1);
     8a4:	4505                	li	a0,1
     8a6:	2f6010ef          	jal	1b9c <sleep>
      continue;
     8aa:	bf59                	j	840 <editor_read_key+0x16>
    if(pushback >= 0){
     8ac:	00002797          	auipc	a5,0x2
     8b0:	7547a783          	lw	a5,1876(a5) # 3000 <pushback.1>
     8b4:	0207ca63          	bltz	a5,8e8 <editor_read_key+0xbe>
      c = pushback;
     8b8:	0ff7f793          	zext.b	a5,a5
      pushback = -1;
     8bc:	577d                	li	a4,-1
     8be:	00002697          	auipc	a3,0x2
     8c2:	74e6a123          	sw	a4,1858(a3) # 3000 <pushback.1>
    if(esc_state == 1){
     8c6:	4098                	lw	a4,0(s1)
     8c8:	05270e63          	beq	a4,s2,924 <editor_read_key+0xfa>
    } else if(esc_state == 2){
     8cc:	4689                	li	a3,2
     8ce:	06d70f63          	beq	a4,a3,94c <editor_read_key+0x122>
    if(c == '\x1b'){
     8d2:	476d                	li	a4,27
     8d4:	0ae78c63          	beq	a5,a4,98c <editor_read_key+0x162>
    return c;
     8d8:	0007851b          	sext.w	a0,a5
}
     8dc:	60e2                	ld	ra,24(sp)
     8de:	6442                	ld	s0,16(sp)
     8e0:	64a2                	ld	s1,8(sp)
     8e2:	6902                	ld	s2,0(sp)
     8e4:	6105                	add	sp,sp,32
     8e6:	8082                	ret
      if(bufpos >= buflen){
     8e8:	00002717          	auipc	a4,0x2
     8ec:	73072703          	lw	a4,1840(a4) # 3018 <bufpos.4>
     8f0:	00002797          	auipc	a5,0x2
     8f4:	7247a783          	lw	a5,1828(a5) # 3014 <buflen.3>
     8f8:	f6f746e3          	blt	a4,a5,864 <editor_read_key+0x3a>
        n = read(0, buf, sizeof(buf));
     8fc:	04000613          	li	a2,64
     900:	00003597          	auipc	a1,0x3
     904:	82058593          	add	a1,a1,-2016 # 3120 <buf.0>
     908:	4501                	li	a0,0
     90a:	21a010ef          	jal	1b24 <read>
        if(n <= 0)
     90e:	f2a059e3          	blez	a0,840 <editor_read_key+0x16>
        buflen = n;
     912:	00002797          	auipc	a5,0x2
     916:	70a7a123          	sw	a0,1794(a5) # 3014 <buflen.3>
        bufpos = 0;
     91a:	00002797          	auipc	a5,0x2
     91e:	6e07af23          	sw	zero,1790(a5) # 3018 <bufpos.4>
     922:	b789                	j	864 <editor_read_key+0x3a>
      if(c == '['){
     924:	05b00713          	li	a4,91
     928:	00e78c63          	beq	a5,a4,940 <editor_read_key+0x116>
        esc_state = 0;
     92c:	00002717          	auipc	a4,0x2
     930:	6e072823          	sw	zero,1776(a4) # 301c <esc_state.5>
        pushback = c;
     934:	00002717          	auipc	a4,0x2
     938:	6cf72623          	sw	a5,1740(a4) # 3000 <pushback.1>
        return '\x1b';
     93c:	456d                	li	a0,27
     93e:	bf79                	j	8dc <editor_read_key+0xb2>
        esc_state = 2;
     940:	4789                	li	a5,2
     942:	00002717          	auipc	a4,0x2
     946:	6cf72d23          	sw	a5,1754(a4) # 301c <esc_state.5>
        continue;
     94a:	bddd                	j	840 <editor_read_key+0x16>
      esc_state = 0;
     94c:	00002717          	auipc	a4,0x2
     950:	6c072823          	sw	zero,1744(a4) # 301c <esc_state.5>
      switch(c){
     954:	04300713          	li	a4,67
     958:	04e78663          	beq	a5,a4,9a4 <editor_read_key+0x17a>
     95c:	02f76063          	bltu	a4,a5,97c <editor_read_key+0x152>
     960:	04100713          	li	a4,65
      case 'A': return KEY_ARROW_UP;
     964:	3ea00513          	li	a0,1002
      switch(c){
     968:	f6e78ae3          	beq	a5,a4,8dc <editor_read_key+0xb2>
     96c:	04200713          	li	a4,66
     970:	3eb00513          	li	a0,1003
     974:	f6e784e3          	beq	a5,a4,8dc <editor_read_key+0xb2>
        return '\x1b';
     978:	456d                	li	a0,27
     97a:	b78d                	j	8dc <editor_read_key+0xb2>
      switch(c){
     97c:	04400713          	li	a4,68
      case 'D': return KEY_ARROW_LEFT;
     980:	3e800513          	li	a0,1000
      switch(c){
     984:	f4e78ce3          	beq	a5,a4,8dc <editor_read_key+0xb2>
        return '\x1b';
     988:	456d                	li	a0,27
     98a:	bf89                	j	8dc <editor_read_key+0xb2>
      esc_state = 1;
     98c:	4785                	li	a5,1
     98e:	00002717          	auipc	a4,0x2
     992:	68f72723          	sw	a5,1678(a4) # 301c <esc_state.5>
      esc_tick = uptime();
     996:	20e010ef          	jal	1ba4 <uptime>
     99a:	00002797          	auipc	a5,0x2
     99e:	66a7ab23          	sw	a0,1654(a5) # 3010 <esc_tick.2>
      continue;
     9a2:	bd79                	j	840 <editor_read_key+0x16>
      case 'C': return KEY_ARROW_RIGHT;
     9a4:	3e900513          	li	a0,1001
     9a8:	bf15                	j	8dc <editor_read_key+0xb2>

00000000000009aa <main>:
}

int
main(int argc, char *argv[])
{
     9aa:	7109                	add	sp,sp,-384
     9ac:	fe86                	sd	ra,376(sp)
     9ae:	faa2                	sd	s0,368(sp)
     9b0:	f6a6                	sd	s1,360(sp)
     9b2:	f2ca                	sd	s2,352(sp)
     9b4:	eece                	sd	s3,344(sp)
     9b6:	ead2                	sd	s4,336(sp)
     9b8:	e6d6                	sd	s5,328(sp)
     9ba:	e2da                	sd	s6,320(sp)
     9bc:	fe5e                	sd	s7,312(sp)
     9be:	fa62                	sd	s8,304(sp)
     9c0:	0300                	add	s0,sp,384
     9c2:	8a2a                	mv	s4,a0
     9c4:	892e                	mv	s2,a1
  E.cx = 0;
     9c6:	00002497          	auipc	s1,0x2
     9ca:	66a48493          	add	s1,s1,1642 # 3030 <E>
     9ce:	0004a023          	sw	zero,0(s1)
  E.cy = 0;
     9d2:	0004a223          	sw	zero,4(s1)
  E.rowoff = 0;
     9d6:	0004a423          	sw	zero,8(s1)
  E.coloff = 0;
     9da:	0004a623          	sw	zero,12(s1)
  E.last_rowoff = -1;
     9de:	57fd                	li	a5,-1
     9e0:	c89c                	sw	a5,16(s1)
  E.last_coloff = -1;
     9e2:	c8dc                	sw	a5,20(s1)
  E.screenrows = 23; // 24 rows - 1 status line
     9e4:	475d                	li	a4,23
     9e6:	cc98                	sw	a4,24(s1)
  E.screencols = 80;
     9e8:	05000713          	li	a4,80
     9ec:	ccd8                	sw	a4,28(s1)
  E.numrows = 0;
     9ee:	0204a023          	sw	zero,32(s1)
  E.row = 0;
     9f2:	0204b423          	sd	zero,40(s1)
  E.dirty = 0;
     9f6:	0204a823          	sw	zero,48(s1)
  E.mode = MODE_NORMAL;
     9fa:	0204aa23          	sw	zero,52(s1)
  E.filename = 0;
     9fe:	0204bc23          	sd	zero,56(s1)
  E.statusmsg[0] = '\0';
     a02:	04048023          	sb	zero,64(s1)
  E.cmdline[0] = '\0';
     a06:	08048823          	sb	zero,144(s1)
  E.cmdlen = 0;
     a0a:	0e04a023          	sw	zero,224(s1)
  E.quit_times = 1;
     a0e:	4985                	li	s3,1
     a10:	0f34a223          	sw	s3,228(s1)
  E.saved_mode = -1;
     a14:	0ef4a423          	sw	a5,232(s1)
  E.screen_dirty = 1;
     a18:	0f34a623          	sw	s3,236(s1)
  editor_init();

  E.saved_mode = consolemode(1, 0);
     a1c:	4581                	li	a1,0
     a1e:	4505                	li	a0,1
     a20:	1dc010ef          	jal	1bfc <consolemode>
     a24:	0ea4a423          	sw	a0,232(s1)
  write(1, "\x1b[2J", 4);
     a28:	4611                	li	a2,4
     a2a:	00001597          	auipc	a1,0x1
     a2e:	7b658593          	add	a1,a1,1974 # 21e0 <malloc+0x1a6>
     a32:	4505                	li	a0,1
     a34:	0f8010ef          	jal	1b2c <write>
  write(1, "\x1b[H", 3);
     a38:	460d                	li	a2,3
     a3a:	00001597          	auipc	a1,0x1
     a3e:	7ae58593          	add	a1,a1,1966 # 21e8 <malloc+0x1ae>
     a42:	4505                	li	a0,1
     a44:	0e8010ef          	jal	1b2c <write>
  write(1, "\x1b[1;1H", 6);
     a48:	4619                	li	a2,6
     a4a:	00001597          	auipc	a1,0x1
     a4e:	7a658593          	add	a1,a1,1958 # 21f0 <malloc+0x1b6>
     a52:	4505                	li	a0,1
     a54:	0d8010ef          	jal	1b2c <write>
  // Disable line wrap to prevent long lines from corrupting the screen.
  write(1, "\x1b[?7l", 5);
     a58:	4615                	li	a2,5
     a5a:	00001597          	auipc	a1,0x1
     a5e:	79e58593          	add	a1,a1,1950 # 21f8 <malloc+0x1be>
     a62:	4505                	li	a0,1
     a64:	0c8010ef          	jal	1b2c <write>

  if(argc >= 2){
     a68:	0149c863          	blt	s3,s4,a78 <main+0xce>
  if(E.cy < E.rowoff)
     a6c:	00002497          	auipc	s1,0x2
     a70:	5c448493          	add	s1,s1,1476 # 3030 <E>
  if(len < (int)sizeof(buf) - 1)
     a74:	4af9                	li	s5,30
     a76:	adb5                	j	10f2 <main+0x748>
    editor_open(argv[1]);
     a78:	00893483          	ld	s1,8(s2)
  E.filename = str_dup(filename);
     a7c:	8526                	mv	a0,s1
     a7e:	9d3ff0ef          	jal	450 <str_dup>
     a82:	00002797          	auipc	a5,0x2
     a86:	5ea7b323          	sd	a0,1510(a5) # 3068 <E+0x38>
  fd = open(filename, O_RDONLY);
     a8a:	4581                	li	a1,0
     a8c:	8526                	mv	a0,s1
     a8e:	0be010ef          	jal	1b4c <open>
     a92:	8aaa                	mv	s5,a0
  if(fd < 0)
     a94:	fc054ce3          	bltz	a0,a6c <main+0xc2>
  int filelen = 0;
     a98:	4a01                	li	s4,0
  char *filebuf = 0;
     a9a:	4481                	li	s1,0
  while((n = read(fd, tmp, sizeof(tmp))) > 0){
     a9c:	10000613          	li	a2,256
     aa0:	eb040593          	add	a1,s0,-336
     aa4:	8556                	mv	a0,s5
     aa6:	07e010ef          	jal	1b24 <read>
     aaa:	892a                	mv	s2,a0
     aac:	02a05763          	blez	a0,ada <main+0x130>
    filebuf = mem_realloc(filebuf, filelen, filelen + n);
     ab0:	012a09bb          	addw	s3,s4,s2
     ab4:	864e                	mv	a2,s3
     ab6:	85d2                	mv	a1,s4
     ab8:	8526                	mv	a0,s1
     aba:	9d7ff0ef          	jal	490 <mem_realloc>
     abe:	84aa                	mv	s1,a0
    if(filebuf == 0){
     ac0:	c909                	beqz	a0,ad2 <main+0x128>
    memmove(filebuf + filelen, tmp, n);
     ac2:	864a                	mv	a2,s2
     ac4:	eb040593          	add	a1,s0,-336
     ac8:	9552                	add	a0,a0,s4
     aca:	519000ef          	jal	17e2 <memmove>
    filelen += n;
     ace:	8a4e                	mv	s4,s3
     ad0:	b7f1                	j	a9c <main+0xf2>
      close(fd);
     ad2:	8556                	mv	a0,s5
     ad4:	060010ef          	jal	1b34 <close>
      return;
     ad8:	bf51                	j	a6c <main+0xc2>
  if(filelen > 0){
     ada:	05405063          	blez	s4,b1a <main+0x170>
     ade:	8bd2                	mv	s7,s4
     ae0:	4901                	li	s2,0
    int start = 0;
     ae2:	4581                	li	a1,0
      if(filebuf[i] == '\n'){
     ae4:	4b29                	li	s6,10
        editor_insert_row(E.numrows, &filebuf[start], i - start);
     ae6:	00002997          	auipc	s3,0x2
     aea:	54a98993          	add	s3,s3,1354 # 3030 <E>
     aee:	a021                	j	af6 <main+0x14c>
    for(i = 0; i < filelen; i++){
     af0:	0905                	add	s2,s2,1
     af2:	03790263          	beq	s2,s7,b16 <main+0x16c>
      if(filebuf[i] == '\n'){
     af6:	012487b3          	add	a5,s1,s2
     afa:	0007c783          	lbu	a5,0(a5)
     afe:	ff6799e3          	bne	a5,s6,af0 <main+0x146>
        editor_insert_row(E.numrows, &filebuf[start], i - start);
     b02:	40b9063b          	subw	a2,s2,a1
     b06:	95a6                	add	a1,a1,s1
     b08:	0209a503          	lw	a0,32(s3)
     b0c:	9d9ff0ef          	jal	4e4 <editor_insert_row>
        start = i + 1;
     b10:	0019059b          	addw	a1,s2,1
     b14:	bff1                	j	af0 <main+0x146>
    if(start < filelen)
     b16:	0145ce63          	blt	a1,s4,b32 <main+0x188>
  if(filebuf)
     b1a:	c481                	beqz	s1,b22 <main+0x178>
    free(filebuf);
     b1c:	8526                	mv	a0,s1
     b1e:	492010ef          	jal	1fb0 <free>
  close(fd);
     b22:	8556                	mv	a0,s5
     b24:	010010ef          	jal	1b34 <close>
  E.dirty = 0;
     b28:	00002797          	auipc	a5,0x2
     b2c:	5207ac23          	sw	zero,1336(a5) # 3060 <E+0x30>
     b30:	bf35                	j	a6c <main+0xc2>
      editor_insert_row(E.numrows, &filebuf[start], filelen - start);
     b32:	40ba063b          	subw	a2,s4,a1
     b36:	95a6                	add	a1,a1,s1
     b38:	00002517          	auipc	a0,0x2
     b3c:	51852503          	lw	a0,1304(a0) # 3050 <E+0x20>
     b40:	9a5ff0ef          	jal	4e4 <editor_insert_row>
     b44:	bfd9                	j	b1a <main+0x170>
  buf[len++] = '\x1b';
     b46:	4c6d                	li	s8,27
  buf[len++] = '[';
     b48:	4b89                	li	s7,2
     b4a:	05b00b13          	li	s6,91
    for(y = 0; y < E.screenrows; y++){
     b4e:	1cd04c63          	bgtz	a3,d26 <main+0x37c>
     b52:	a871                	j	bee <main+0x244>
      ab_append(ab, "~", 1);
     b54:	4605                	li	a2,1
     b56:	85da                	mv	a1,s6
     b58:	e8040513          	add	a0,s0,-384
     b5c:	ac3ff0ef          	jal	61e <ab_append>
     b60:	a021                	j	b68 <main+0x1be>
      if(len > E.screencols) len = E.screencols;
     b62:	2601                	sext.w	a2,a2
      if(len > 0)
     b64:	04c04e63          	bgtz	a2,bc0 <main+0x216>
    ab_append(ab, "\x1b[K", 3);
     b68:	460d                	li	a2,3
     b6a:	85d2                	mv	a1,s4
     b6c:	e8040513          	add	a0,s0,-384
     b70:	aafff0ef          	jal	61e <ab_append>
    ab_append(ab, "\r\n", 2);
     b74:	4609                	li	a2,2
     b76:	85ce                	mv	a1,s3
     b78:	e8040513          	add	a0,s0,-384
     b7c:	aa3ff0ef          	jal	61e <ab_append>
  for(y = 0; y < E.screenrows; y++){
     b80:	2905                	addw	s2,s2,1
     b82:	4c9c                	lw	a5,24(s1)
     b84:	04f95563          	bge	s2,a5,bce <main+0x224>
    int filerow = y + E.rowoff;
     b88:	449c                	lw	a5,8(s1)
     b8a:	012787bb          	addw	a5,a5,s2
    if(filerow >= E.numrows){
     b8e:	5098                	lw	a4,32(s1)
     b90:	fce7d2e3          	bge	a5,a4,b54 <main+0x1aa>
      int len = E.row[filerow].size - E.coloff;
     b94:	00179713          	sll	a4,a5,0x1
     b98:	97ba                	add	a5,a5,a4
     b9a:	078e                	sll	a5,a5,0x3
     b9c:	7494                	ld	a3,40(s1)
     b9e:	96be                	add	a3,a3,a5
     ba0:	44cc                	lw	a1,12(s1)
     ba2:	429c                	lw	a5,0(a3)
     ba4:	9f8d                	subw	a5,a5,a1
      if(len < 0) len = 0;
     ba6:	0007871b          	sext.w	a4,a5
     baa:	fff74713          	not	a4,a4
     bae:	977d                	sra	a4,a4,0x3f
     bb0:	8ff9                	and	a5,a5,a4
      if(len > E.screencols) len = E.screencols;
     bb2:	4cd8                	lw	a4,28(s1)
     bb4:	863e                	mv	a2,a5
     bb6:	2781                	sext.w	a5,a5
     bb8:	faf755e3          	bge	a4,a5,b62 <main+0x1b8>
     bbc:	863a                	mv	a2,a4
     bbe:	b755                	j	b62 <main+0x1b8>
        ab_append(ab, &E.row[filerow].chars[E.coloff], len);
     bc0:	669c                	ld	a5,8(a3)
     bc2:	95be                	add	a1,a1,a5
     bc4:	e8040513          	add	a0,s0,-384
     bc8:	a57ff0ef          	jal	61e <ab_append>
     bcc:	bf71                	j	b68 <main+0x1be>
      for(i = 0; i < E.numrows; i++)
     bce:	509c                	lw	a5,32(s1)
     bd0:	00f05d63          	blez	a5,bea <main+0x240>
     bd4:	4681                	li	a3,0
     bd6:	4701                	li	a4,0
        E.row[i].dirty = 0;
     bd8:	749c                	ld	a5,40(s1)
     bda:	97b6                	add	a5,a5,a3
     bdc:	0007a823          	sw	zero,16(a5)
      for(i = 0; i < E.numrows; i++)
     be0:	2705                	addw	a4,a4,1
     be2:	06e1                	add	a3,a3,24
     be4:	509c                	lw	a5,32(s1)
     be6:	fef749e3          	blt	a4,a5,bd8 <main+0x22e>
    E.screen_dirty = 0;
     bea:	0e04a623          	sw	zero,236(s1)
    int srow = E.screenrows + 1;
     bee:	4c94                	lw	a3,24(s1)
    buf[slen++] = '\x1b';
     bf0:	47ed                	li	a5,27
     bf2:	e8f40823          	sb	a5,-368(s0)
    buf[slen++] = '[';
     bf6:	4789                	li	a5,2
     bf8:	eaf42823          	sw	a5,-336(s0)
     bfc:	05b00793          	li	a5,91
     c00:	e8f408a3          	sb	a5,-367(s0)
    append_num(buf, &slen, sizeof(buf), srow);
     c04:	2685                	addw	a3,a3,1
     c06:	02000613          	li	a2,32
     c0a:	eb040593          	add	a1,s0,-336
     c0e:	e9040513          	add	a0,s0,-368
     c12:	c3eff0ef          	jal	50 <append_num>
    if(slen < (int)sizeof(buf) - 1)
     c16:	eb042783          	lw	a5,-336(s0)
     c1a:	00facd63          	blt	s5,a5,c34 <main+0x28a>
      buf[slen++] = ';';
     c1e:	0017871b          	addw	a4,a5,1
     c22:	eae42823          	sw	a4,-336(s0)
     c26:	fb078793          	add	a5,a5,-80
     c2a:	97a2                	add	a5,a5,s0
     c2c:	03b00713          	li	a4,59
     c30:	eee78023          	sb	a4,-288(a5)
    append_num(buf, &slen, sizeof(buf), 1);
     c34:	4685                	li	a3,1
     c36:	02000613          	li	a2,32
     c3a:	eb040593          	add	a1,s0,-336
     c3e:	e9040513          	add	a0,s0,-368
     c42:	c0eff0ef          	jal	50 <append_num>
    if(slen < (int)sizeof(buf) - 1)
     c46:	eb042783          	lw	a5,-336(s0)
     c4a:	00facd63          	blt	s5,a5,c64 <main+0x2ba>
      buf[slen++] = 'H';
     c4e:	0017871b          	addw	a4,a5,1
     c52:	eae42823          	sw	a4,-336(s0)
     c56:	fb078793          	add	a5,a5,-80
     c5a:	97a2                	add	a5,a5,s0
     c5c:	04800713          	li	a4,72
     c60:	eee78023          	sb	a4,-288(a5)
    buf[slen] = '\0';
     c64:	eb042603          	lw	a2,-336(s0)
     c68:	fb060793          	add	a5,a2,-80
     c6c:	97a2                	add	a5,a5,s0
     c6e:	ee078023          	sb	zero,-288(a5)
    ab_append(&ab, buf, slen);
     c72:	e9040593          	add	a1,s0,-368
     c76:	e8040513          	add	a0,s0,-384
     c7a:	9a5ff0ef          	jal	61e <ab_append>
  int limit = E.screencols;
     c7e:	4ccc                	lw	a1,28(s1)
  if(limit > (int)sizeof(line)) limit = sizeof(line);
     c80:	862e                	mv	a2,a1
     c82:	05000793          	li	a5,80
     c86:	00b7d463          	bge	a5,a1,c8e <main+0x2e4>
     c8a:	05000613          	li	a2,80
     c8e:	2601                	sext.w	a2,a2
  for(i = 0; i < limit; i++)
     c90:	14b05fe3          	blez	a1,15ee <main+0xc44>
     c94:	eb040713          	add	a4,s0,-336
     c98:	4781                	li	a5,0
    line[i] = ' ';
     c9a:	02000693          	li	a3,32
     c9e:	00d70023          	sb	a3,0(a4)
  for(i = 0; i < limit; i++)
     ca2:	2785                	addw	a5,a5,1
     ca4:	0705                	add	a4,a4,1
     ca6:	fec7cce3          	blt	a5,a2,c9e <main+0x2f4>
  if(E.mode == MODE_COMMAND){
     caa:	58dc                	lw	a5,52(s1)
     cac:	4709                	li	a4,2
     cae:	14e78b63          	beq	a5,a4,e04 <main+0x45a>
  } else if(E.mode == MODE_INSERT){
     cb2:	4705                	li	a4,1
     cb4:	32e78063          	beq	a5,a4,fd4 <main+0x62a>
  } else if(E.statusmsg[0]){
     cb8:	0404c703          	lbu	a4,64(s1)
     cbc:	18070263          	beqz	a4,e40 <main+0x496>
    for(i = 0; E.statusmsg[i] && i < limit; i++)
     cc0:	18b05063          	blez	a1,e40 <main+0x496>
     cc4:	eb040693          	add	a3,s0,-336
     cc8:	4781                	li	a5,0
      line[i] = E.statusmsg[i];
     cca:	00e68023          	sb	a4,0(a3)
    for(i = 0; E.statusmsg[i] && i < limit; i++)
     cce:	00f48733          	add	a4,s1,a5
     cd2:	04174703          	lbu	a4,65(a4)
     cd6:	16070563          	beqz	a4,e40 <main+0x496>
     cda:	0785                	add	a5,a5,1
     cdc:	0685                	add	a3,a3,1
     cde:	0007859b          	sext.w	a1,a5
     ce2:	fec5c4e3          	blt	a1,a2,cca <main+0x320>
     ce6:	aaa9                	j	e40 <main+0x496>
    ab_append(ab, "~", 1);
     ce8:	4605                	li	a2,1
     cea:	00001597          	auipc	a1,0x1
     cee:	51658593          	add	a1,a1,1302 # 2200 <malloc+0x1c6>
     cf2:	e8040513          	add	a0,s0,-384
     cf6:	929ff0ef          	jal	61e <ab_append>
     cfa:	a029                	j	d04 <main+0x35a>
    if(clen > E.screencols) clen = E.screencols;
     cfc:	0007061b          	sext.w	a2,a4
    if(clen > 0)
     d00:	0ec04b63          	bgtz	a2,df6 <main+0x44c>
  ab_append(ab, "\x1b[K", 3);
     d04:	460d                	li	a2,3
     d06:	00001597          	auipc	a1,0x1
     d0a:	50258593          	add	a1,a1,1282 # 2208 <malloc+0x1ce>
     d0e:	e8040513          	add	a0,s0,-384
     d12:	90dff0ef          	jal	61e <ab_append>
        E.row[filerow].dirty = 0;
     d16:	749c                	ld	a5,40(s1)
     d18:	97d2                	add	a5,a5,s4
     d1a:	0007a823          	sw	zero,16(a5)
    for(y = 0; y < E.screenrows; y++){
     d1e:	2905                	addw	s2,s2,1
     d20:	4c9c                	lw	a5,24(s1)
     d22:	ecf956e3          	bge	s2,a5,bee <main+0x244>
      int filerow = y + E.rowoff;
     d26:	0084a983          	lw	s3,8(s1)
     d2a:	012989bb          	addw	s3,s3,s2
      if(filerow < E.numrows && E.row[filerow].dirty){
     d2e:	509c                	lw	a5,32(s1)
     d30:	fef9d7e3          	bge	s3,a5,d1e <main+0x374>
     d34:	00199a13          	sll	s4,s3,0x1
     d38:	9a4e                	add	s4,s4,s3
     d3a:	0a0e                	sll	s4,s4,0x3
     d3c:	749c                	ld	a5,40(s1)
     d3e:	97d2                	add	a5,a5,s4
     d40:	4b9c                	lw	a5,16(a5)
     d42:	dff1                	beqz	a5,d1e <main+0x374>
  buf[len++] = '\x1b';
     d44:	eb840823          	sb	s8,-336(s0)
  buf[len++] = '[';
     d48:	e9742823          	sw	s7,-368(s0)
     d4c:	eb6408a3          	sb	s6,-335(s0)
  append_num(buf, &len, sizeof(buf), screen_row);
     d50:	0019069b          	addw	a3,s2,1
     d54:	02000613          	li	a2,32
     d58:	e9040593          	add	a1,s0,-368
     d5c:	eb040513          	add	a0,s0,-336
     d60:	af0ff0ef          	jal	50 <append_num>
  if(len < (int)sizeof(buf) - 1)
     d64:	e9042783          	lw	a5,-368(s0)
     d68:	00facd63          	blt	s5,a5,d82 <main+0x3d8>
    buf[len++] = ';';
     d6c:	0017871b          	addw	a4,a5,1
     d70:	e8e42823          	sw	a4,-368(s0)
     d74:	fb078793          	add	a5,a5,-80
     d78:	97a2                	add	a5,a5,s0
     d7a:	03b00713          	li	a4,59
     d7e:	f0e78023          	sb	a4,-256(a5)
  append_num(buf, &len, sizeof(buf), 1);
     d82:	4685                	li	a3,1
     d84:	02000613          	li	a2,32
     d88:	e9040593          	add	a1,s0,-368
     d8c:	eb040513          	add	a0,s0,-336
     d90:	ac0ff0ef          	jal	50 <append_num>
  if(len < (int)sizeof(buf) - 1)
     d94:	e9042783          	lw	a5,-368(s0)
     d98:	00facd63          	blt	s5,a5,db2 <main+0x408>
    buf[len++] = 'H';
     d9c:	0017871b          	addw	a4,a5,1
     da0:	e8e42823          	sw	a4,-368(s0)
     da4:	fb078793          	add	a5,a5,-80
     da8:	97a2                	add	a5,a5,s0
     daa:	04800713          	li	a4,72
     dae:	f0e78023          	sb	a4,-256(a5)
  buf[len] = '\0';
     db2:	e9042603          	lw	a2,-368(s0)
     db6:	fb060793          	add	a5,a2,-80
     dba:	97a2                	add	a5,a5,s0
     dbc:	f0078023          	sb	zero,-256(a5)
  ab_append(ab, buf, len);
     dc0:	eb040593          	add	a1,s0,-336
     dc4:	e8040513          	add	a0,s0,-384
     dc8:	857ff0ef          	jal	61e <ab_append>
  if(filerow >= E.numrows){
     dcc:	509c                	lw	a5,32(s1)
     dce:	f0f9dde3          	bge	s3,a5,ce8 <main+0x33e>
    int clen = E.row[filerow].size - E.coloff;
     dd2:	7494                	ld	a3,40(s1)
     dd4:	96d2                	add	a3,a3,s4
     dd6:	44cc                	lw	a1,12(s1)
     dd8:	429c                	lw	a5,0(a3)
     dda:	9f8d                	subw	a5,a5,a1
    if(clen < 0) clen = 0;
     ddc:	0007871b          	sext.w	a4,a5
     de0:	fff74713          	not	a4,a4
     de4:	977d                	sra	a4,a4,0x3f
     de6:	8ff9                	and	a5,a5,a4
    if(clen > E.screencols) clen = E.screencols;
     de8:	4cd0                	lw	a2,28(s1)
     dea:	873e                	mv	a4,a5
     dec:	2781                	sext.w	a5,a5
     dee:	f0f657e3          	bge	a2,a5,cfc <main+0x352>
     df2:	8732                	mv	a4,a2
     df4:	b721                	j	cfc <main+0x352>
      ab_append(ab, &E.row[filerow].chars[E.coloff], clen);
     df6:	669c                	ld	a5,8(a3)
     df8:	95be                	add	a1,a1,a5
     dfa:	e8040513          	add	a0,s0,-384
     dfe:	821ff0ef          	jal	61e <ab_append>
     e02:	b709                	j	d04 <main+0x35a>
    if(pos < limit) line[pos++] = ':';
     e04:	03a00793          	li	a5,58
     e08:	eaf40823          	sb	a5,-336(s0)
    for(i = 0; i < E.cmdlen && pos < limit; i++)
     e0c:	0e04a503          	lw	a0,224(s1)
     e10:	02a05863          	blez	a0,e40 <main+0x496>
     e14:	4785                	li	a5,1
     e16:	02b7d563          	bge	a5,a1,e40 <main+0x496>
     e1a:	00002697          	auipc	a3,0x2
     e1e:	2a668693          	add	a3,a3,678 # 30c0 <E+0x90>
     e22:	eb140713          	add	a4,s0,-335
     e26:	2505                	addw	a0,a0,1
     e28:	4785                	li	a5,1
      line[pos++] = E.cmdline[i];
     e2a:	2785                	addw	a5,a5,1
     e2c:	0006c583          	lbu	a1,0(a3)
     e30:	00b70023          	sb	a1,0(a4)
    for(i = 0; i < E.cmdlen && pos < limit; i++)
     e34:	00a78663          	beq	a5,a0,e40 <main+0x496>
     e38:	0685                	add	a3,a3,1
     e3a:	0705                	add	a4,a4,1
     e3c:	fef617e3          	bne	a2,a5,e2a <main+0x480>
  ab_append(ab, line, limit);
     e40:	eb040593          	add	a1,s0,-336
     e44:	e8040513          	add	a0,s0,-384
     e48:	fd6ff0ef          	jal	61e <ab_append>
  ab_append(ab, "\x1b[K", 3);
     e4c:	460d                	li	a2,3
     e4e:	00001597          	auipc	a1,0x1
     e52:	3ba58593          	add	a1,a1,954 # 2208 <malloc+0x1ce>
     e56:	e8040513          	add	a0,s0,-384
     e5a:	fc4ff0ef          	jal	61e <ab_append>
  if(E.cy < E.numrows)
     e5e:	40dc                	lw	a5,4(s1)
     e60:	5094                	lw	a3,32(s1)
    rx = 0;
     e62:	4701                	li	a4,0
  if(E.cy < E.numrows)
     e64:	02d7d063          	bge	a5,a3,e84 <main+0x4da>
  if(cx > row->size)
     e68:	7494                	ld	a3,40(s1)
     e6a:	00179713          	sll	a4,a5,0x1
     e6e:	973e                	add	a4,a4,a5
     e70:	070e                	sll	a4,a4,0x3
     e72:	9736                	add	a4,a4,a3
     e74:	4090                	lw	a2,0(s1)
     e76:	4314                	lw	a3,0(a4)
     e78:	8736                	mv	a4,a3
     e7a:	2681                	sext.w	a3,a3
     e7c:	00d65363          	bge	a2,a3,e82 <main+0x4d8>
     e80:	8732                	mv	a4,a2
     e82:	2701                	sext.w	a4,a4
  if(E.mode == MODE_COMMAND){
     e84:	58d0                	lw	a2,52(s1)
     e86:	4689                	li	a3,2
     e88:	16d60e63          	beq	a2,a3,1004 <main+0x65a>
    row = (E.cy - E.rowoff) + 1;
     e8c:	4494                	lw	a3,8(s1)
     e8e:	9f95                	subw	a5,a5,a3
     e90:	2785                	addw	a5,a5,1
    col = (rx - E.coloff) + 1;
     e92:	44d4                	lw	a3,12(s1)
     e94:	9f15                	subw	a4,a4,a3
     e96:	2705                	addw	a4,a4,1
  if(col < 1) col = 1;
     e98:	863a                	mv	a2,a4
     e9a:	16e05b63          	blez	a4,1010 <main+0x666>
  if(col > E.screencols) col = E.screencols;
     e9e:	4cd8                	lw	a4,28(s1)
     ea0:	86b2                	mv	a3,a2
     ea2:	2601                	sext.w	a2,a2
     ea4:	00c75363          	bge	a4,a2,eaa <main+0x500>
     ea8:	86ba                	mv	a3,a4
     eaa:	0006891b          	sext.w	s2,a3
  buf[len++] = '\x1b';
     eae:	476d                	li	a4,27
     eb0:	e8e40823          	sb	a4,-368(s0)
  buf[len++] = '[';
     eb4:	4709                	li	a4,2
     eb6:	eae42823          	sw	a4,-336(s0)
     eba:	05b00713          	li	a4,91
     ebe:	e8e408a3          	sb	a4,-367(s0)
  if(row < 1) row = 1;
     ec2:	86be                	mv	a3,a5
     ec4:	14f05863          	blez	a5,1014 <main+0x66a>
  append_num(buf, &len, sizeof(buf), row);
     ec8:	2681                	sext.w	a3,a3
     eca:	02000613          	li	a2,32
     ece:	eb040593          	add	a1,s0,-336
     ed2:	e9040513          	add	a0,s0,-368
     ed6:	97aff0ef          	jal	50 <append_num>
  if(len < (int)sizeof(buf) - 1)
     eda:	eb042783          	lw	a5,-336(s0)
     ede:	00facd63          	blt	s5,a5,ef8 <main+0x54e>
    buf[len++] = ';';
     ee2:	0017871b          	addw	a4,a5,1
     ee6:	eae42823          	sw	a4,-336(s0)
     eea:	fb078793          	add	a5,a5,-80
     eee:	97a2                	add	a5,a5,s0
     ef0:	03b00713          	li	a4,59
     ef4:	eee78023          	sb	a4,-288(a5)
  append_num(buf, &len, sizeof(buf), col);
     ef8:	86ca                	mv	a3,s2
     efa:	02000613          	li	a2,32
     efe:	eb040593          	add	a1,s0,-336
     f02:	e9040513          	add	a0,s0,-368
     f06:	94aff0ef          	jal	50 <append_num>
  if(len < (int)sizeof(buf) - 1)
     f0a:	eb042783          	lw	a5,-336(s0)
     f0e:	00facd63          	blt	s5,a5,f28 <main+0x57e>
    buf[len++] = 'H';
     f12:	0017871b          	addw	a4,a5,1
     f16:	eae42823          	sw	a4,-336(s0)
     f1a:	fb078793          	add	a5,a5,-80
     f1e:	97a2                	add	a5,a5,s0
     f20:	04800713          	li	a4,72
     f24:	eee78023          	sb	a4,-288(a5)
  buf[len] = '\0';
     f28:	eb042603          	lw	a2,-336(s0)
     f2c:	fb060793          	add	a5,a2,-80
     f30:	97a2                	add	a5,a5,s0
     f32:	ee078023          	sb	zero,-288(a5)
  ab_append(&ab, buf, len);
     f36:	e9040593          	add	a1,s0,-368
     f3a:	e8040513          	add	a0,s0,-384
     f3e:	ee0ff0ef          	jal	61e <ab_append>
  ab_append(&ab, "\x1b[?25h", 6); // show cursor
     f42:	4619                	li	a2,6
     f44:	00001597          	auipc	a1,0x1
     f48:	2e458593          	add	a1,a1,740 # 2228 <malloc+0x1ee>
     f4c:	e8040513          	add	a0,s0,-384
     f50:	eceff0ef          	jal	61e <ab_append>
  write(1, ab.b, ab.len);
     f54:	e8043903          	ld	s2,-384(s0)
     f58:	e8842603          	lw	a2,-376(s0)
     f5c:	85ca                	mv	a1,s2
     f5e:	4505                	li	a0,1
     f60:	3cd000ef          	jal	1b2c <write>
  if(ab->b)
     f64:	00090563          	beqz	s2,f6e <main+0x5c4>
    free(ab->b);
     f68:	854a                	mv	a0,s2
     f6a:	046010ef          	jal	1fb0 <free>
  E.last_rowoff = E.rowoff;
     f6e:	449c                	lw	a5,8(s1)
     f70:	c89c                	sw	a5,16(s1)
  E.last_coloff = E.coloff;
     f72:	44dc                	lw	a5,12(s1)
     f74:	c8dc                	sw	a5,20(s1)
  int c = editor_read_key();
     f76:	8b5ff0ef          	jal	82a <editor_read_key>
  if(c != CTRL_KEY('q'))
     f7a:	47c5                	li	a5,17
     f7c:	64f50e63          	beq	a0,a5,15d8 <main+0xc2e>
    E.quit_times = 1;
     f80:	4705                	li	a4,1
     f82:	0ee4a223          	sw	a4,228(s1)
  if(E.mode == MODE_INSERT){
     f86:	58dc                	lw	a5,52(s1)
     f88:	08e78863          	beq	a5,a4,1018 <main+0x66e>
  if(E.mode == MODE_COMMAND){
     f8c:	4709                	li	a4,2
     f8e:	34e78563          	beq	a5,a4,12d8 <main+0x92e>
  switch(c){
     f92:	03a00793          	li	a5,58
     f96:	5cf50263          	beq	a0,a5,155a <main+0xbb0>
     f9a:	4aa7de63          	bge	a5,a0,1456 <main+0xaac>
     f9e:	07800793          	li	a5,120
     fa2:	4ea7c463          	blt	a5,a0,148a <main+0xae0>
     fa6:	06300793          	li	a5,99
     faa:	14a7d463          	bge	a5,a0,10f2 <main+0x748>
     fae:	f9c5079b          	addw	a5,a0,-100
     fb2:	0007869b          	sext.w	a3,a5
     fb6:	4751                	li	a4,20
     fb8:	12d76d63          	bltu	a4,a3,10f2 <main+0x748>
     fbc:	02079713          	sll	a4,a5,0x20
     fc0:	01e75793          	srl	a5,a4,0x1e
     fc4:	00001717          	auipc	a4,0x1
     fc8:	2ac70713          	add	a4,a4,684 # 2270 <malloc+0x236>
     fcc:	97ba                	add	a5,a5,a4
     fce:	439c                	lw	a5,0(a5)
     fd0:	97ba                	add	a5,a5,a4
     fd2:	8782                	jr	a5
     fd4:	eb040693          	add	a3,s0,-336
  } else if(E.mode == MODE_INSERT){
     fd8:	4781                	li	a5,0
    for(i = 0; ins[i] && i < limit; i++)
     fda:	02d00713          	li	a4,45
     fde:	00001517          	auipc	a0,0x1
     fe2:	23a50513          	add	a0,a0,570 # 2218 <malloc+0x1de>
      line[i] = ins[i];
     fe6:	00e68023          	sb	a4,0(a3)
    for(i = 0; ins[i] && i < limit; i++)
     fea:	00a78733          	add	a4,a5,a0
     fee:	00174703          	lbu	a4,1(a4)
     ff2:	e40707e3          	beqz	a4,e40 <main+0x496>
     ff6:	0785                	add	a5,a5,1
     ff8:	0685                	add	a3,a3,1
     ffa:	0007859b          	sext.w	a1,a5
     ffe:	fec5c4e3          	blt	a1,a2,fe6 <main+0x63c>
    1002:	bd3d                	j	e40 <main+0x496>
    row = E.screenrows + 1;
    1004:	4c9c                	lw	a5,24(s1)
    1006:	2785                	addw	a5,a5,1
    col = 2 + E.cmdlen;
    1008:	0e04a703          	lw	a4,224(s1)
    100c:	2709                	addw	a4,a4,2
    100e:	b569                	j	e98 <main+0x4ee>
  if(col < 1) col = 1;
    1010:	4605                	li	a2,1
    1012:	b571                	j	e9e <main+0x4f4>
  if(row < 1) row = 1;
    1014:	4685                	li	a3,1
    1016:	bd4d                	j	ec8 <main+0x51e>
    switch(c){
    1018:	47ed                	li	a5,27
    101a:	02a7c863          	blt	a5,a0,104a <main+0x6a0>
    101e:	479d                	li	a5,7
    1020:	02a7d963          	bge	a5,a0,1052 <main+0x6a8>
    1024:	ff85079b          	addw	a5,a0,-8
    1028:	0007869b          	sext.w	a3,a5
    102c:	474d                	li	a4,19
    102e:	02d76263          	bltu	a4,a3,1052 <main+0x6a8>
    1032:	02079713          	sll	a4,a5,0x20
    1036:	01e75793          	srl	a5,a4,0x1e
    103a:	00001717          	auipc	a4,0x1
    103e:	28a70713          	add	a4,a4,650 # 22c4 <malloc+0x28a>
    1042:	97ba                	add	a5,a5,a4
    1044:	439c                	lw	a5,0(a5)
    1046:	97ba                	add	a5,a5,a4
    1048:	8782                	jr	a5
    104a:	07f00793          	li	a5,127
    104e:	1af50363          	beq	a0,a5,11f4 <main+0x84a>
        unsigned char uc = (unsigned char)c;
    1052:	0ff57913          	zext.b	s2,a0
        if(uc >= 32 && uc != 127){
    1056:	47fd                	li	a5,31
    1058:	0927fd63          	bgeu	a5,s2,10f2 <main+0x748>
    105c:	07f00793          	li	a5,127
    1060:	08f90963          	beq	s2,a5,10f2 <main+0x748>
  if(E.cy == E.numrows)
    1064:	5088                	lw	a0,32(s1)
    1066:	40dc                	lw	a5,4(s1)
    1068:	24a78663          	beq	a5,a0,12b4 <main+0x90a>
  editor_row_insert_char(&E.row[E.cy], E.cx, c);
    106c:	40d8                	lw	a4,4(s1)
    106e:	00171793          	sll	a5,a4,0x1
    1072:	97ba                	add	a5,a5,a4
    1074:	078e                	sll	a5,a5,0x3
    1076:	0284b983          	ld	s3,40(s1)
    107a:	99be                	add	s3,s3,a5
    107c:	0004aa03          	lw	s4,0(s1)
  if(at < 0 || at > row->size)
    1080:	000a4663          	bltz	s4,108c <main+0x6e2>
    1084:	0009a783          	lw	a5,0(s3)
    1088:	0147d463          	bge	a5,s4,1090 <main+0x6e6>
    at = row->size;
    108c:	0009aa03          	lw	s4,0(s3)
  row->chars = mem_realloc(row->chars, row->size + 1, row->size + 2);
    1090:	0009a583          	lw	a1,0(s3)
    1094:	0025861b          	addw	a2,a1,2
    1098:	2585                	addw	a1,a1,1
    109a:	0089b503          	ld	a0,8(s3)
    109e:	bf2ff0ef          	jal	490 <mem_realloc>
    10a2:	00a9b423          	sd	a0,8(s3)
  if(row->chars == 0)
    10a6:	c90d                	beqz	a0,10d8 <main+0x72e>
  if(at < row->size)
    10a8:	0009a603          	lw	a2,0(s3)
    10ac:	20ca4c63          	blt	s4,a2,12c4 <main+0x91a>
  row->chars[at] = c;
    10b0:	0089b783          	ld	a5,8(s3)
    10b4:	97d2                	add	a5,a5,s4
    10b6:	01278023          	sb	s2,0(a5)
  row->size++;
    10ba:	0009a783          	lw	a5,0(s3)
    10be:	2785                	addw	a5,a5,1
    10c0:	0007871b          	sext.w	a4,a5
    10c4:	00f9a023          	sw	a5,0(s3)
  row->chars[row->size] = '\0';
    10c8:	0089b783          	ld	a5,8(s3)
    10cc:	97ba                	add	a5,a5,a4
    10ce:	00078023          	sb	zero,0(a5)
  row->dirty = 1;
    10d2:	4785                	li	a5,1
    10d4:	00f9a823          	sw	a5,16(s3)
  E.cx++;
    10d8:	409c                	lw	a5,0(s1)
    10da:	2785                	addw	a5,a5,1
    10dc:	c09c                	sw	a5,0(s1)
  E.dirty = 1;
    10de:	4785                	li	a5,1
    10e0:	d89c                	sw	a5,48(s1)
  E.screen_dirty = 1;
    10e2:	0ef4a623          	sw	a5,236(s1)
}
    10e6:	a031                	j	10f2 <main+0x748>
      E.mode = MODE_NORMAL;
    10e8:	0204aa23          	sw	zero,52(s1)
      E.screen_dirty = 1;
    10ec:	4785                	li	a5,1
    10ee:	0ef4a623          	sw	a5,236(s1)
  struct abuf ab = {0, 0};
    10f2:	e8043023          	sd	zero,-384(s0)
    10f6:	e8042423          	sw	zero,-376(s0)
  if(E.cy < E.rowoff)
    10fa:	40dc                	lw	a5,4(s1)
    10fc:	4498                	lw	a4,8(s1)
    10fe:	00e7d363          	bge	a5,a4,1104 <main+0x75a>
    E.rowoff = E.cy;
    1102:	c49c                	sw	a5,8(s1)
  if(E.cy >= E.rowoff + E.screenrows)
    1104:	4c94                	lw	a3,24(s1)
    1106:	4498                	lw	a4,8(s1)
    1108:	9f35                	addw	a4,a4,a3
    110a:	00e7c563          	blt	a5,a4,1114 <main+0x76a>
    E.rowoff = E.cy - E.screenrows + 1;
    110e:	9f95                	subw	a5,a5,a3
    1110:	2785                	addw	a5,a5,1
    1112:	c49c                	sw	a5,8(s1)
  if(E.cx < E.coloff)
    1114:	409c                	lw	a5,0(s1)
    1116:	44d8                	lw	a4,12(s1)
    1118:	00e7d363          	bge	a5,a4,111e <main+0x774>
    E.coloff = E.cx;
    111c:	c4dc                	sw	a5,12(s1)
  if(E.cx >= E.coloff + E.screencols)
    111e:	4cd0                	lw	a2,28(s1)
    1120:	44d8                	lw	a4,12(s1)
    1122:	9f31                	addw	a4,a4,a2
    1124:	00e7c563          	blt	a5,a4,112e <main+0x784>
    E.coloff = E.cx - E.screencols + 1;
    1128:	9f91                	subw	a5,a5,a2
    112a:	2785                	addw	a5,a5,1
    112c:	c4dc                	sw	a5,12(s1)
  clear_screen = (!force_full && E.screen_dirty);
    112e:	58d8                	lw	a4,52(s1)
    1130:	4785                	li	a5,1
    1132:	00f70a63          	beq	a4,a5,1146 <main+0x79c>
    1136:	0ec4a903          	lw	s2,236(s1)
  if(force_full || E.screen_dirty || E.rowoff != E.last_rowoff || E.coloff != E.last_coloff){
    113a:	4c091363          	bnez	s2,1600 <main+0xc56>
    113e:	6498                	ld	a4,8(s1)
    1140:	689c                	ld	a5,16(s1)
    1142:	a0f702e3          	beq	a4,a5,b46 <main+0x19c>
    ab_append(&ab, "\x1b[?25l", 6); // hide cursor for full redraw
    1146:	4619                	li	a2,6
    1148:	00001597          	auipc	a1,0x1
    114c:	11858593          	add	a1,a1,280 # 2260 <malloc+0x226>
    1150:	e8040513          	add	a0,s0,-384
    1154:	ccaff0ef          	jal	61e <ab_append>
    ab_append(&ab, "\x1b[H", 3);
    1158:	460d                	li	a2,3
    115a:	00001597          	auipc	a1,0x1
    115e:	08e58593          	add	a1,a1,142 # 21e8 <malloc+0x1ae>
    1162:	e8040513          	add	a0,s0,-384
    1166:	cb8ff0ef          	jal	61e <ab_append>
  for(y = 0; y < E.screenrows; y++){
    116a:	4c9c                	lw	a5,24(s1)
    116c:	a6f051e3          	blez	a5,bce <main+0x224>
    1170:	4901                	li	s2,0
      ab_append(ab, "~", 1);
    1172:	00001b17          	auipc	s6,0x1
    1176:	08eb0b13          	add	s6,s6,142 # 2200 <malloc+0x1c6>
    ab_append(ab, "\x1b[K", 3);
    117a:	00001a17          	auipc	s4,0x1
    117e:	08ea0a13          	add	s4,s4,142 # 2208 <malloc+0x1ce>
    ab_append(ab, "\r\n", 2);
    1182:	00001997          	auipc	s3,0x1
    1186:	08e98993          	add	s3,s3,142 # 2210 <malloc+0x1d6>
    118a:	bafd                	j	b88 <main+0x1de>
  if(E.cx == 0){
    118c:	409c                	lw	a5,0(s1)
    118e:	e395                	bnez	a5,11b2 <main+0x808>
    editor_insert_row(E.cy, "", 0);
    1190:	4601                	li	a2,0
    1192:	00001597          	auipc	a1,0x1
    1196:	fde58593          	add	a1,a1,-34 # 2170 <malloc+0x136>
    119a:	40c8                	lw	a0,4(s1)
    119c:	b48ff0ef          	jal	4e4 <editor_insert_row>
  E.cy++;
    11a0:	40dc                	lw	a5,4(s1)
    11a2:	2785                	addw	a5,a5,1
    11a4:	c0dc                	sw	a5,4(s1)
  E.cx = 0;
    11a6:	0004a023          	sw	zero,0(s1)
  E.screen_dirty = 1;
    11aa:	4785                	li	a5,1
    11ac:	0ef4a623          	sw	a5,236(s1)
}
    11b0:	b789                	j	10f2 <main+0x748>
    struct erow *row = &E.row[E.cy];
    11b2:	40c8                	lw	a0,4(s1)
    11b4:	00151713          	sll	a4,a0,0x1
    11b8:	972a                	add	a4,a4,a0
    11ba:	070e                	sll	a4,a4,0x3
    11bc:	7494                	ld	a3,40(s1)
    11be:	9736                	add	a4,a4,a3
    editor_insert_row(E.cy + 1, &row->chars[E.cx], row->size - E.cx);
    11c0:	4310                	lw	a2,0(a4)
    11c2:	670c                	ld	a1,8(a4)
    11c4:	9e1d                	subw	a2,a2,a5
    11c6:	95be                	add	a1,a1,a5
    11c8:	2505                	addw	a0,a0,1
    11ca:	b1aff0ef          	jal	4e4 <editor_insert_row>
    row = &E.row[E.cy];
    11ce:	40dc                	lw	a5,4(s1)
    11d0:	00179713          	sll	a4,a5,0x1
    11d4:	973e                	add	a4,a4,a5
    11d6:	070e                	sll	a4,a4,0x3
    11d8:	749c                	ld	a5,40(s1)
    11da:	97ba                	add	a5,a5,a4
    row->size = E.cx;
    11dc:	4094                	lw	a3,0(s1)
    11de:	c394                	sw	a3,0(a5)
    row->chars[row->size] = '\0';
    11e0:	6798                	ld	a4,8(a5)
    11e2:	9736                	add	a4,a4,a3
    11e4:	00070023          	sb	zero,0(a4)
    row->dirty = 1;
    11e8:	4705                	li	a4,1
    11ea:	cb98                	sw	a4,16(a5)
    11ec:	bf55                	j	11a0 <main+0x7f6>
      editor_save();
    11ee:	c92ff0ef          	jal	680 <editor_save>
      return;
    11f2:	b701                	j	10f2 <main+0x748>
  if(E.cy >= E.numrows)
    11f4:	40dc                	lw	a5,4(s1)
    11f6:	5098                	lw	a4,32(s1)
    11f8:	eee7dde3          	bge	a5,a4,10f2 <main+0x748>
  if(E.cx == 0 && E.cy == 0)
    11fc:	6098                	ld	a4,0(s1)
    11fe:	ee070ae3          	beqz	a4,10f2 <main+0x748>
  struct erow *row = &E.row[E.cy];
    1202:	0284b903          	ld	s2,40(s1)
    1206:	00179713          	sll	a4,a5,0x1
    120a:	97ba                	add	a5,a5,a4
    120c:	078e                	sll	a5,a5,0x3
    120e:	00f909b3          	add	s3,s2,a5
  if(E.cx > 0){
    1212:	408c                	lw	a1,0(s1)
    1214:	00b05e63          	blez	a1,1230 <main+0x886>
    editor_row_del_char(row, E.cx - 1);
    1218:	35fd                	addw	a1,a1,-1
    121a:	854e                	mv	a0,s3
    121c:	934ff0ef          	jal	350 <editor_row_del_char>
    E.cx--;
    1220:	409c                	lw	a5,0(s1)
    1222:	37fd                	addw	a5,a5,-1
    1224:	c09c                	sw	a5,0(s1)
    E.dirty = 1;
    1226:	4785                	li	a5,1
    1228:	d89c                	sw	a5,48(s1)
    E.screen_dirty = 1;
    122a:	0ef4a623          	sw	a5,236(s1)
    122e:	b5d1                	j	10f2 <main+0x748>
    int prevlen = E.row[E.cy - 1].size;
    1230:	17a1                	add	a5,a5,-24
    1232:	993e                	add	s2,s2,a5
    1234:	00092a03          	lw	s4,0(s2)
    prev->chars = mem_realloc(prev->chars, prev->size + 1, prev->size + row->size + 1);
    1238:	0009a603          	lw	a2,0(s3)
    123c:	0146063b          	addw	a2,a2,s4
    1240:	2605                	addw	a2,a2,1
    1242:	001a059b          	addw	a1,s4,1
    1246:	00893503          	ld	a0,8(s2)
    124a:	a46ff0ef          	jal	490 <mem_realloc>
    124e:	87aa                	mv	a5,a0
    1250:	00a93423          	sd	a0,8(s2)
    if(prev->chars == 0)
    1254:	e8050fe3          	beqz	a0,10f2 <main+0x748>
    memmove(&prev->chars[prev->size], row->chars, row->size);
    1258:	00092503          	lw	a0,0(s2)
    125c:	0009a603          	lw	a2,0(s3)
    1260:	0089b583          	ld	a1,8(s3)
    1264:	953e                	add	a0,a0,a5
    1266:	57c000ef          	jal	17e2 <memmove>
    prev->size += row->size;
    126a:	00092703          	lw	a4,0(s2)
    126e:	0009a783          	lw	a5,0(s3)
    1272:	9fb9                	addw	a5,a5,a4
    1274:	0007871b          	sext.w	a4,a5
    1278:	00f92023          	sw	a5,0(s2)
    prev->chars[prev->size] = '\0';
    127c:	00893783          	ld	a5,8(s2)
    1280:	97ba                	add	a5,a5,a4
    1282:	00078023          	sb	zero,0(a5)
    prev->dirty = 1;
    1286:	4985                	li	s3,1
    1288:	01392823          	sw	s3,16(s2)
    editor_del_row(E.cy);
    128c:	00002917          	auipc	s2,0x2
    1290:	da490913          	add	s2,s2,-604 # 3030 <E>
    1294:	00492503          	lw	a0,4(s2)
    1298:	904ff0ef          	jal	39c <editor_del_row>
    E.cy--;
    129c:	00492783          	lw	a5,4(s2)
    12a0:	37fd                	addw	a5,a5,-1
    12a2:	00f92223          	sw	a5,4(s2)
    E.cx = prevlen;
    12a6:	01492023          	sw	s4,0(s2)
    E.dirty = 1;
    12aa:	03392823          	sw	s3,48(s2)
    E.screen_dirty = 1;
    12ae:	0f392623          	sw	s3,236(s2)
    12b2:	b581                	j	10f2 <main+0x748>
    editor_insert_row(E.numrows, "", 0);
    12b4:	4601                	li	a2,0
    12b6:	00001597          	auipc	a1,0x1
    12ba:	eba58593          	add	a1,a1,-326 # 2170 <malloc+0x136>
    12be:	a26ff0ef          	jal	4e4 <editor_insert_row>
    12c2:	b36d                	j	106c <main+0x6c2>
    memmove(&row->chars[at + 1], &row->chars[at], row->size - at);
    12c4:	001a0713          	add	a4,s4,1
    12c8:	4146063b          	subw	a2,a2,s4
    12cc:	014505b3          	add	a1,a0,s4
    12d0:	953a                	add	a0,a0,a4
    12d2:	510000ef          	jal	17e2 <memmove>
    12d6:	bbe9                	j	10b0 <main+0x706>
    switch(c){
    12d8:	47ed                	li	a5,27
    12da:	06f50b63          	beq	a0,a5,1350 <main+0x9a6>
    12de:	02a7c963          	blt	a5,a0,1310 <main+0x966>
    12e2:	47a9                	li	a5,10
    12e4:	08f50063          	beq	a0,a5,1364 <main+0x9ba>
    12e8:	47b5                	li	a5,13
    12ea:	06f50d63          	beq	a0,a5,1364 <main+0x9ba>
    12ee:	47a1                	li	a5,8
    12f0:	e0f511e3          	bne	a0,a5,10f2 <main+0x748>
      if(E.cmdlen > 0)
    12f4:	0e04a783          	lw	a5,224(s1)
    12f8:	def05de3          	blez	a5,10f2 <main+0x748>
        E.cmdline[--E.cmdlen] = '\0';
    12fc:	37fd                	addw	a5,a5,-1
    12fe:	0007871b          	sext.w	a4,a5
    1302:	0ef4a023          	sw	a5,224(s1)
    1306:	00e487b3          	add	a5,s1,a4
    130a:	08078823          	sb	zero,144(a5)
    130e:	b3d5                	j	10f2 <main+0x748>
    switch(c){
    1310:	07f00793          	li	a5,127
    1314:	fef500e3          	beq	a0,a5,12f4 <main+0x94a>
      if(c >= 32 && c <= 126 && E.cmdlen < (int)sizeof(E.cmdline) - 1){
    1318:	fe05079b          	addw	a5,a0,-32
    131c:	05e00713          	li	a4,94
    1320:	dcf769e3          	bltu	a4,a5,10f2 <main+0x748>
    1324:	0e04a783          	lw	a5,224(s1)
    1328:	04e00713          	li	a4,78
    132c:	dcf743e3          	blt	a4,a5,10f2 <main+0x748>
        E.cmdline[E.cmdlen++] = c;
    1330:	0017869b          	addw	a3,a5,1
    1334:	0006871b          	sext.w	a4,a3
    1338:	0ed4a023          	sw	a3,224(s1)
    133c:	97a6                	add	a5,a5,s1
    133e:	08a78823          	sb	a0,144(a5)
        E.cmdline[E.cmdlen] = '\0';
    1342:	9726                	add	a4,a4,s1
    1344:	08070823          	sb	zero,144(a4)
        E.screen_dirty = 1;
    1348:	4785                	li	a5,1
    134a:	0ef4a623          	sw	a5,236(s1)
    134e:	b355                	j	10f2 <main+0x748>
      E.mode = MODE_NORMAL;
    1350:	0204aa23          	sw	zero,52(s1)
      E.cmdlen = 0;
    1354:	0e04a023          	sw	zero,224(s1)
      E.cmdline[0] = '\0';
    1358:	08048823          	sb	zero,144(s1)
      E.screen_dirty = 1;
    135c:	4785                	li	a5,1
    135e:	0ef4a623          	sw	a5,236(s1)
      return;
    1362:	bb41                	j	10f2 <main+0x748>
  if(E.cmdlen == 0){
    1364:	0e04a783          	lw	a5,224(s1)
    1368:	c3c5                	beqz	a5,1408 <main+0xa5e>
  E.cmdline[E.cmdlen] = '\0';
    136a:	97a6                	add	a5,a5,s1
    136c:	08078823          	sb	zero,144(a5)
  if(strcmp(E.cmdline, "q") == 0){
    1370:	00001597          	auipc	a1,0x1
    1374:	ec058593          	add	a1,a1,-320 # 2230 <malloc+0x1f6>
    1378:	00002517          	auipc	a0,0x2
    137c:	d4850513          	add	a0,a0,-696 # 30c0 <E+0x90>
    1380:	2d4000ef          	jal	1654 <strcmp>
    1384:	c549                	beqz	a0,140e <main+0xa64>
  } else if(strcmp(E.cmdline, "q!") == 0){
    1386:	00001597          	auipc	a1,0x1
    138a:	eb258593          	add	a1,a1,-334 # 2238 <malloc+0x1fe>
    138e:	00002517          	auipc	a0,0x2
    1392:	d3250513          	add	a0,a0,-718 # 30c0 <E+0x90>
    1396:	2be000ef          	jal	1654 <strcmp>
    139a:	c949                	beqz	a0,142c <main+0xa82>
  } else if(strcmp(E.cmdline, "w") == 0){
    139c:	00001597          	auipc	a1,0x1
    13a0:	ea458593          	add	a1,a1,-348 # 2240 <malloc+0x206>
    13a4:	00002517          	auipc	a0,0x2
    13a8:	d1c50513          	add	a0,a0,-740 # 30c0 <E+0x90>
    13ac:	2a8000ef          	jal	1654 <strcmp>
    13b0:	c141                	beqz	a0,1430 <main+0xa86>
  } else if(strcmp(E.cmdline, "wq") == 0){
    13b2:	00001597          	auipc	a1,0x1
    13b6:	e9658593          	add	a1,a1,-362 # 2248 <malloc+0x20e>
    13ba:	00002517          	auipc	a0,0x2
    13be:	d0650513          	add	a0,a0,-762 # 30c0 <E+0x90>
    13c2:	292000ef          	jal	1654 <strcmp>
    13c6:	c925                	beqz	a0,1436 <main+0xa8c>
  } else if(E.cmdline[0] == 'w' && E.cmdline[1] == ' '){
    13c8:	0904d703          	lhu	a4,144(s1)
    13cc:	6789                	lui	a5,0x2
    13ce:	07778793          	add	a5,a5,119 # 2077 <malloc+0x3d>
    13d2:	06f71b63          	bne	a4,a5,1448 <main+0xa9e>
    if(name[0]){
    13d6:	00002797          	auipc	a5,0x2
    13da:	cec7c783          	lbu	a5,-788(a5) # 30c2 <E+0x92>
    13de:	cb9d                	beqz	a5,1414 <main+0xa6a>
      if(E.filename)
    13e0:	00002517          	auipc	a0,0x2
    13e4:	c8853503          	ld	a0,-888(a0) # 3068 <E+0x38>
    13e8:	c119                	beqz	a0,13ee <main+0xa44>
        free(E.filename);
    13ea:	3c7000ef          	jal	1fb0 <free>
      E.filename = str_dup(name);
    13ee:	00002517          	auipc	a0,0x2
    13f2:	cd450513          	add	a0,a0,-812 # 30c2 <E+0x92>
    13f6:	85aff0ef          	jal	450 <str_dup>
    13fa:	00002797          	auipc	a5,0x2
    13fe:	c6a7b723          	sd	a0,-914(a5) # 3068 <E+0x38>
      editor_save();
    1402:	a7eff0ef          	jal	680 <editor_save>
    1406:	a039                	j	1414 <main+0xa6a>
    E.mode = MODE_NORMAL;
    1408:	0204aa23          	sw	zero,52(s1)
    return;
    140c:	b1dd                	j	10f2 <main+0x748>
    if(editor_try_quit(0))
    140e:	eedfe0ef          	jal	2fa <editor_try_quit>
    1412:	e919                	bnez	a0,1428 <main+0xa7e>
  E.mode = MODE_NORMAL;
    1414:	0204aa23          	sw	zero,52(s1)
  E.cmdlen = 0;
    1418:	0e04a023          	sw	zero,224(s1)
  E.cmdline[0] = '\0';
    141c:	08048823          	sb	zero,144(s1)
  E.screen_dirty = 1;
    1420:	4785                	li	a5,1
    1422:	0ef4a623          	sw	a5,236(s1)
    1426:	b1f1                	j	10f2 <main+0x748>
      editor_quit();
    1428:	baaff0ef          	jal	7d2 <editor_quit>
    editor_quit();
    142c:	ba6ff0ef          	jal	7d2 <editor_quit>
    editor_save();
    1430:	a50ff0ef          	jal	680 <editor_save>
    1434:	b7c5                	j	1414 <main+0xa6a>
    editor_save();
    1436:	a4aff0ef          	jal	680 <editor_save>
    if(!E.dirty)
    143a:	00002797          	auipc	a5,0x2
    143e:	c267a783          	lw	a5,-986(a5) # 3060 <E+0x30>
    1442:	fbe9                	bnez	a5,1414 <main+0xa6a>
      editor_quit();
    1444:	b8eff0ef          	jal	7d2 <editor_quit>
    editor_set_status("Unknown command");
    1448:	00001517          	auipc	a0,0x1
    144c:	e0850513          	add	a0,a0,-504 # 2250 <malloc+0x216>
    1450:	bb1fe0ef          	jal	0 <editor_set_status>
    1454:	b7c1                	j	1414 <main+0xa6a>
  switch(c){
    1456:	47cd                	li	a5,19
    1458:	10f50d63          	beq	a0,a5,1572 <main+0xbc8>
    145c:	00a7dd63          	bge	a5,a0,1476 <main+0xacc>
    1460:	02400793          	li	a5,36
    1464:	00f50663          	beq	a0,a5,1470 <main+0xac6>
    1468:	03000793          	li	a5,48
    146c:	c8f513e3          	bne	a0,a5,10f2 <main+0x748>
    editor_move_cursor(c);
    1470:	c77fe0ef          	jal	e6 <editor_move_cursor>
    return;
    1474:	b9bd                	j	10f2 <main+0x748>
  switch(c){
    1476:	47c5                	li	a5,17
    1478:	c6f51de3          	bne	a0,a5,10f2 <main+0x748>
    if(editor_try_quit(0))
    147c:	4501                	li	a0,0
    147e:	e7dfe0ef          	jal	2fa <editor_try_quit>
    1482:	c60508e3          	beqz	a0,10f2 <main+0x748>
      editor_quit();
    1486:	b4cff0ef          	jal	7d2 <editor_quit>
  switch(c){
    148a:	c185079b          	addw	a5,a0,-1000
    148e:	470d                	li	a4,3
    1490:	c6f761e3          	bltu	a4,a5,10f2 <main+0x748>
    editor_move_cursor(c);
    1494:	c53fe0ef          	jal	e6 <editor_move_cursor>
    return;
    1498:	b9a9                	j	10f2 <main+0x748>
    E.mode = MODE_INSERT;
    149a:	4785                	li	a5,1
    149c:	d8dc                	sw	a5,52(s1)
    E.screen_dirty = 1;
    149e:	0ef4a623          	sw	a5,236(s1)
    return;
    14a2:	b981                	j	10f2 <main+0x748>
  if(E.cy >= E.numrows)
    14a4:	40d8                	lw	a4,4(s1)
    14a6:	5090                	lw	a2,32(s1)
    14a8:	c4c755e3          	bge	a4,a2,10f2 <main+0x748>
  struct erow *row = &E.row[E.cy];
    14ac:	7494                	ld	a3,40(s1)
    14ae:	00171793          	sll	a5,a4,0x1
    14b2:	97ba                	add	a5,a5,a4
    14b4:	078e                	sll	a5,a5,0x3
    14b6:	00f68933          	add	s2,a3,a5
  if(E.cx < row->size){
    14ba:	408c                	lw	a1,0(s1)
    14bc:	00092503          	lw	a0,0(s2)
    14c0:	08a5c163          	blt	a1,a0,1542 <main+0xb98>
  if(E.cx == row->size && E.cy + 1 < E.numrows){
    14c4:	c2a597e3          	bne	a1,a0,10f2 <main+0x748>
    14c8:	2705                	addw	a4,a4,1
    14ca:	c2c754e3          	bge	a4,a2,10f2 <main+0x748>
    struct erow *next = &E.row[E.cy + 1];
    14ce:	07e1                	add	a5,a5,24
    14d0:	00f689b3          	add	s3,a3,a5
    row->chars = mem_realloc(row->chars, row->size + 1, row->size + next->size + 1);
    14d4:	0009a603          	lw	a2,0(s3)
    14d8:	9e29                	addw	a2,a2,a0
    14da:	2605                	addw	a2,a2,1
    14dc:	0015059b          	addw	a1,a0,1
    14e0:	00893503          	ld	a0,8(s2)
    14e4:	fadfe0ef          	jal	490 <mem_realloc>
    14e8:	87aa                	mv	a5,a0
    14ea:	00a93423          	sd	a0,8(s2)
    if(row->chars == 0)
    14ee:	c00502e3          	beqz	a0,10f2 <main+0x748>
    memmove(&row->chars[row->size], next->chars, next->size);
    14f2:	00092503          	lw	a0,0(s2)
    14f6:	0009a603          	lw	a2,0(s3)
    14fa:	0089b583          	ld	a1,8(s3)
    14fe:	953e                	add	a0,a0,a5
    1500:	2e2000ef          	jal	17e2 <memmove>
    row->size += next->size;
    1504:	00092703          	lw	a4,0(s2)
    1508:	0009a783          	lw	a5,0(s3)
    150c:	9fb9                	addw	a5,a5,a4
    150e:	0007871b          	sext.w	a4,a5
    1512:	00f92023          	sw	a5,0(s2)
    row->chars[row->size] = '\0';
    1516:	00893783          	ld	a5,8(s2)
    151a:	97ba                	add	a5,a5,a4
    151c:	00078023          	sb	zero,0(a5)
    row->dirty = 1;
    1520:	4985                	li	s3,1
    1522:	01392823          	sw	s3,16(s2)
    editor_del_row(E.cy + 1);
    1526:	00002917          	auipc	s2,0x2
    152a:	b0a90913          	add	s2,s2,-1270 # 3030 <E>
    152e:	00492503          	lw	a0,4(s2)
    1532:	2505                	addw	a0,a0,1
    1534:	e69fe0ef          	jal	39c <editor_del_row>
    E.dirty = 1;
    1538:	03392823          	sw	s3,48(s2)
    E.screen_dirty = 1;
    153c:	0f392623          	sw	s3,236(s2)
    1540:	be4d                	j	10f2 <main+0x748>
    editor_row_del_char(row, E.cx);
    1542:	854a                	mv	a0,s2
    1544:	e0dfe0ef          	jal	350 <editor_row_del_char>
    E.dirty = 1;
    1548:	00002797          	auipc	a5,0x2
    154c:	ae878793          	add	a5,a5,-1304 # 3030 <E>
    1550:	4705                	li	a4,1
    1552:	db98                	sw	a4,48(a5)
    E.screen_dirty = 1;
    1554:	0ee7a623          	sw	a4,236(a5)
    return;
    1558:	be69                	j	10f2 <main+0x748>
  E.mode = MODE_COMMAND;
    155a:	4789                	li	a5,2
    155c:	d8dc                	sw	a5,52(s1)
  E.cmdlen = 0;
    155e:	0e04a023          	sw	zero,224(s1)
  E.cmdline[0] = '\0';
    1562:	08048823          	sb	zero,144(s1)
  E.statusmsg[0] = '\0';
    1566:	04048023          	sb	zero,64(s1)
  E.screen_dirty = 1;
    156a:	4785                	li	a5,1
    156c:	0ef4a623          	sw	a5,236(s1)
}
    1570:	b649                	j	10f2 <main+0x748>
    editor_save();
    1572:	90eff0ef          	jal	680 <editor_save>
    return;
    1576:	beb5                	j	10f2 <main+0x748>
    int next = editor_read_key();
    1578:	ab2ff0ef          	jal	82a <editor_read_key>
    if(next == 'd'){
    157c:	06400793          	li	a5,100
    1580:	b6f519e3          	bne	a0,a5,10f2 <main+0x748>
      if(E.numrows > 0){
    1584:	509c                	lw	a5,32(s1)
    1586:	b6f056e3          	blez	a5,10f2 <main+0x748>
        editor_del_row(E.cy);
    158a:	00002917          	auipc	s2,0x2
    158e:	aa690913          	add	s2,s2,-1370 # 3030 <E>
    1592:	00492503          	lw	a0,4(s2)
    1596:	e07fe0ef          	jal	39c <editor_del_row>
        if(E.cy >= E.numrows)
    159a:	02092783          	lw	a5,32(s2)
    159e:	00492703          	lw	a4,4(s2)
    15a2:	00f74763          	blt	a4,a5,15b0 <main+0xc06>
          E.cy = E.numrows - 1;
    15a6:	37fd                	addw	a5,a5,-1
    15a8:	00002717          	auipc	a4,0x2
    15ac:	a8f72623          	sw	a5,-1396(a4) # 3034 <E+0x4>
        if(E.cy < 0)
    15b0:	00002797          	auipc	a5,0x2
    15b4:	a847a783          	lw	a5,-1404(a5) # 3034 <E+0x4>
    15b8:	0007cb63          	bltz	a5,15ce <main+0xc24>
        E.cx = 0;
    15bc:	00002797          	auipc	a5,0x2
    15c0:	a7478793          	add	a5,a5,-1420 # 3030 <E>
    15c4:	0007a023          	sw	zero,0(a5)
        E.dirty = 1;
    15c8:	4705                	li	a4,1
    15ca:	db98                	sw	a4,48(a5)
    15cc:	b61d                	j	10f2 <main+0x748>
          E.cy = 0;
    15ce:	00002797          	auipc	a5,0x2
    15d2:	a607a323          	sw	zero,-1434(a5) # 3034 <E+0x4>
    15d6:	b7dd                	j	15bc <main+0xc12>
  if(E.mode == MODE_INSERT){
    15d8:	58dc                	lw	a5,52(s1)
    15da:	4705                	li	a4,1
    15dc:	9ae798e3          	bne	a5,a4,f8c <main+0x5e2>
      if(editor_try_quit(0))
    15e0:	4501                	li	a0,0
    15e2:	d19fe0ef          	jal	2fa <editor_try_quit>
    15e6:	b00506e3          	beqz	a0,10f2 <main+0x748>
        editor_quit();
    15ea:	9e8ff0ef          	jal	7d2 <editor_quit>
  if(E.mode == MODE_COMMAND){
    15ee:	58dc                	lw	a5,52(s1)
    15f0:	4709                	li	a4,2
    15f2:	84e787e3          	beq	a5,a4,e40 <main+0x496>
  } else if(E.mode == MODE_INSERT){
    15f6:	4705                	li	a4,1
    15f8:	ece79063          	bne	a5,a4,cb8 <main+0x30e>
    15fc:	845ff06f          	j	e40 <main+0x496>
    ab_append(&ab, "\x1b[?25l", 6); // hide cursor for full redraw
    1600:	4619                	li	a2,6
    1602:	00001597          	auipc	a1,0x1
    1606:	c5e58593          	add	a1,a1,-930 # 2260 <malloc+0x226>
    160a:	e8040513          	add	a0,s0,-384
    160e:	810ff0ef          	jal	61e <ab_append>
      ab_append(&ab, "\x1b[2J", 4);   // clear screen
    1612:	4611                	li	a2,4
    1614:	00001597          	auipc	a1,0x1
    1618:	bcc58593          	add	a1,a1,-1076 # 21e0 <malloc+0x1a6>
    161c:	e8040513          	add	a0,s0,-384
    1620:	ffffe0ef          	jal	61e <ab_append>
    1624:	be15                	j	1158 <main+0x7ae>

0000000000001626 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
    1626:	1141                	add	sp,sp,-16
    1628:	e406                	sd	ra,8(sp)
    162a:	e022                	sd	s0,0(sp)
    162c:	0800                	add	s0,sp,16
  extern int main();
  main();
    162e:	b7cff0ef          	jal	9aa <main>
  exit(0);
    1632:	4501                	li	a0,0
    1634:	4d8000ef          	jal	1b0c <exit>

0000000000001638 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    1638:	1141                	add	sp,sp,-16
    163a:	e422                	sd	s0,8(sp)
    163c:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    163e:	87aa                	mv	a5,a0
    1640:	0585                	add	a1,a1,1
    1642:	0785                	add	a5,a5,1
    1644:	fff5c703          	lbu	a4,-1(a1)
    1648:	fee78fa3          	sb	a4,-1(a5)
    164c:	fb75                	bnez	a4,1640 <strcpy+0x8>
    ;
  return os;
}
    164e:	6422                	ld	s0,8(sp)
    1650:	0141                	add	sp,sp,16
    1652:	8082                	ret

0000000000001654 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1654:	1141                	add	sp,sp,-16
    1656:	e422                	sd	s0,8(sp)
    1658:	0800                	add	s0,sp,16
  while(*p && *p == *q)
    165a:	00054783          	lbu	a5,0(a0)
    165e:	cb91                	beqz	a5,1672 <strcmp+0x1e>
    1660:	0005c703          	lbu	a4,0(a1)
    1664:	00f71763          	bne	a4,a5,1672 <strcmp+0x1e>
    p++, q++;
    1668:	0505                	add	a0,a0,1
    166a:	0585                	add	a1,a1,1
  while(*p && *p == *q)
    166c:	00054783          	lbu	a5,0(a0)
    1670:	fbe5                	bnez	a5,1660 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    1672:	0005c503          	lbu	a0,0(a1)
}
    1676:	40a7853b          	subw	a0,a5,a0
    167a:	6422                	ld	s0,8(sp)
    167c:	0141                	add	sp,sp,16
    167e:	8082                	ret

0000000000001680 <strlen>:

uint
strlen(const char *s)
{
    1680:	1141                	add	sp,sp,-16
    1682:	e422                	sd	s0,8(sp)
    1684:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    1686:	00054783          	lbu	a5,0(a0)
    168a:	cf91                	beqz	a5,16a6 <strlen+0x26>
    168c:	0505                	add	a0,a0,1
    168e:	87aa                	mv	a5,a0
    1690:	86be                	mv	a3,a5
    1692:	0785                	add	a5,a5,1
    1694:	fff7c703          	lbu	a4,-1(a5)
    1698:	ff65                	bnez	a4,1690 <strlen+0x10>
    169a:	40a6853b          	subw	a0,a3,a0
    169e:	2505                	addw	a0,a0,1
    ;
  return n;
}
    16a0:	6422                	ld	s0,8(sp)
    16a2:	0141                	add	sp,sp,16
    16a4:	8082                	ret
  for(n = 0; s[n]; n++)
    16a6:	4501                	li	a0,0
    16a8:	bfe5                	j	16a0 <strlen+0x20>

00000000000016aa <memset>:

void*
memset(void *dst, int c, uint n)
{
    16aa:	1141                	add	sp,sp,-16
    16ac:	e422                	sd	s0,8(sp)
    16ae:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    16b0:	ca19                	beqz	a2,16c6 <memset+0x1c>
    16b2:	87aa                	mv	a5,a0
    16b4:	1602                	sll	a2,a2,0x20
    16b6:	9201                	srl	a2,a2,0x20
    16b8:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    16bc:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    16c0:	0785                	add	a5,a5,1
    16c2:	fee79de3          	bne	a5,a4,16bc <memset+0x12>
  }
  return dst;
}
    16c6:	6422                	ld	s0,8(sp)
    16c8:	0141                	add	sp,sp,16
    16ca:	8082                	ret

00000000000016cc <strchr>:

char*
strchr(const char *s, char c)
{
    16cc:	1141                	add	sp,sp,-16
    16ce:	e422                	sd	s0,8(sp)
    16d0:	0800                	add	s0,sp,16
  for(; *s; s++)
    16d2:	00054783          	lbu	a5,0(a0)
    16d6:	cb99                	beqz	a5,16ec <strchr+0x20>
    if(*s == c)
    16d8:	00f58763          	beq	a1,a5,16e6 <strchr+0x1a>
  for(; *s; s++)
    16dc:	0505                	add	a0,a0,1
    16de:	00054783          	lbu	a5,0(a0)
    16e2:	fbfd                	bnez	a5,16d8 <strchr+0xc>
      return (char*)s;
  return 0;
    16e4:	4501                	li	a0,0
}
    16e6:	6422                	ld	s0,8(sp)
    16e8:	0141                	add	sp,sp,16
    16ea:	8082                	ret
  return 0;
    16ec:	4501                	li	a0,0
    16ee:	bfe5                	j	16e6 <strchr+0x1a>

00000000000016f0 <gets>:

char*
gets(char *buf, int max)
{
    16f0:	711d                	add	sp,sp,-96
    16f2:	ec86                	sd	ra,88(sp)
    16f4:	e8a2                	sd	s0,80(sp)
    16f6:	e4a6                	sd	s1,72(sp)
    16f8:	e0ca                	sd	s2,64(sp)
    16fa:	fc4e                	sd	s3,56(sp)
    16fc:	f852                	sd	s4,48(sp)
    16fe:	f456                	sd	s5,40(sp)
    1700:	f05a                	sd	s6,32(sp)
    1702:	ec5e                	sd	s7,24(sp)
    1704:	1080                	add	s0,sp,96
    1706:	8baa                	mv	s7,a0
    1708:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    170a:	892a                	mv	s2,a0
    170c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    170e:	4aa9                	li	s5,10
    1710:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    1712:	89a6                	mv	s3,s1
    1714:	2485                	addw	s1,s1,1
    1716:	0344d663          	bge	s1,s4,1742 <gets+0x52>
    cc = read(0, &c, 1);
    171a:	4605                	li	a2,1
    171c:	faf40593          	add	a1,s0,-81
    1720:	4501                	li	a0,0
    1722:	402000ef          	jal	1b24 <read>
    if(cc < 1)
    1726:	00a05e63          	blez	a0,1742 <gets+0x52>
    buf[i++] = c;
    172a:	faf44783          	lbu	a5,-81(s0)
    172e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    1732:	01578763          	beq	a5,s5,1740 <gets+0x50>
    1736:	0905                	add	s2,s2,1
    1738:	fd679de3          	bne	a5,s6,1712 <gets+0x22>
    buf[i++] = c;
    173c:	89a6                	mv	s3,s1
    173e:	a011                	j	1742 <gets+0x52>
    1740:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    1742:	99de                	add	s3,s3,s7
    1744:	00098023          	sb	zero,0(s3)
  return buf;
}
    1748:	855e                	mv	a0,s7
    174a:	60e6                	ld	ra,88(sp)
    174c:	6446                	ld	s0,80(sp)
    174e:	64a6                	ld	s1,72(sp)
    1750:	6906                	ld	s2,64(sp)
    1752:	79e2                	ld	s3,56(sp)
    1754:	7a42                	ld	s4,48(sp)
    1756:	7aa2                	ld	s5,40(sp)
    1758:	7b02                	ld	s6,32(sp)
    175a:	6be2                	ld	s7,24(sp)
    175c:	6125                	add	sp,sp,96
    175e:	8082                	ret

0000000000001760 <stat>:

int
stat(const char *n, struct stat *st)
{
    1760:	1101                	add	sp,sp,-32
    1762:	ec06                	sd	ra,24(sp)
    1764:	e822                	sd	s0,16(sp)
    1766:	e04a                	sd	s2,0(sp)
    1768:	1000                	add	s0,sp,32
    176a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    176c:	4581                	li	a1,0
    176e:	3de000ef          	jal	1b4c <open>
  if(fd < 0)
    1772:	02054263          	bltz	a0,1796 <stat+0x36>
    1776:	e426                	sd	s1,8(sp)
    1778:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    177a:	85ca                	mv	a1,s2
    177c:	3e8000ef          	jal	1b64 <fstat>
    1780:	892a                	mv	s2,a0
  close(fd);
    1782:	8526                	mv	a0,s1
    1784:	3b0000ef          	jal	1b34 <close>
  return r;
    1788:	64a2                	ld	s1,8(sp)
}
    178a:	854a                	mv	a0,s2
    178c:	60e2                	ld	ra,24(sp)
    178e:	6442                	ld	s0,16(sp)
    1790:	6902                	ld	s2,0(sp)
    1792:	6105                	add	sp,sp,32
    1794:	8082                	ret
    return -1;
    1796:	597d                	li	s2,-1
    1798:	bfcd                	j	178a <stat+0x2a>

000000000000179a <atoi>:

int
atoi(const char *s)
{
    179a:	1141                	add	sp,sp,-16
    179c:	e422                	sd	s0,8(sp)
    179e:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    17a0:	00054683          	lbu	a3,0(a0)
    17a4:	fd06879b          	addw	a5,a3,-48
    17a8:	0ff7f793          	zext.b	a5,a5
    17ac:	4625                	li	a2,9
    17ae:	02f66863          	bltu	a2,a5,17de <atoi+0x44>
    17b2:	872a                	mv	a4,a0
  n = 0;
    17b4:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
    17b6:	0705                	add	a4,a4,1
    17b8:	0025179b          	sllw	a5,a0,0x2
    17bc:	9fa9                	addw	a5,a5,a0
    17be:	0017979b          	sllw	a5,a5,0x1
    17c2:	9fb5                	addw	a5,a5,a3
    17c4:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    17c8:	00074683          	lbu	a3,0(a4)
    17cc:	fd06879b          	addw	a5,a3,-48
    17d0:	0ff7f793          	zext.b	a5,a5
    17d4:	fef671e3          	bgeu	a2,a5,17b6 <atoi+0x1c>
  return n;
}
    17d8:	6422                	ld	s0,8(sp)
    17da:	0141                	add	sp,sp,16
    17dc:	8082                	ret
  n = 0;
    17de:	4501                	li	a0,0
    17e0:	bfe5                	j	17d8 <atoi+0x3e>

00000000000017e2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    17e2:	1141                	add	sp,sp,-16
    17e4:	e422                	sd	s0,8(sp)
    17e6:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    17e8:	02b57463          	bgeu	a0,a1,1810 <memmove+0x2e>
    while(n-- > 0)
    17ec:	00c05f63          	blez	a2,180a <memmove+0x28>
    17f0:	1602                	sll	a2,a2,0x20
    17f2:	9201                	srl	a2,a2,0x20
    17f4:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    17f8:	872a                	mv	a4,a0
      *dst++ = *src++;
    17fa:	0585                	add	a1,a1,1
    17fc:	0705                	add	a4,a4,1
    17fe:	fff5c683          	lbu	a3,-1(a1)
    1802:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    1806:	fef71ae3          	bne	a4,a5,17fa <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    180a:	6422                	ld	s0,8(sp)
    180c:	0141                	add	sp,sp,16
    180e:	8082                	ret
    dst += n;
    1810:	00c50733          	add	a4,a0,a2
    src += n;
    1814:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    1816:	fec05ae3          	blez	a2,180a <memmove+0x28>
    181a:	fff6079b          	addw	a5,a2,-1
    181e:	1782                	sll	a5,a5,0x20
    1820:	9381                	srl	a5,a5,0x20
    1822:	fff7c793          	not	a5,a5
    1826:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    1828:	15fd                	add	a1,a1,-1
    182a:	177d                	add	a4,a4,-1
    182c:	0005c683          	lbu	a3,0(a1)
    1830:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    1834:	fee79ae3          	bne	a5,a4,1828 <memmove+0x46>
    1838:	bfc9                	j	180a <memmove+0x28>

000000000000183a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    183a:	1141                	add	sp,sp,-16
    183c:	e422                	sd	s0,8(sp)
    183e:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    1840:	ca05                	beqz	a2,1870 <memcmp+0x36>
    1842:	fff6069b          	addw	a3,a2,-1
    1846:	1682                	sll	a3,a3,0x20
    1848:	9281                	srl	a3,a3,0x20
    184a:	0685                	add	a3,a3,1
    184c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    184e:	00054783          	lbu	a5,0(a0)
    1852:	0005c703          	lbu	a4,0(a1)
    1856:	00e79863          	bne	a5,a4,1866 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    185a:	0505                	add	a0,a0,1
    p2++;
    185c:	0585                	add	a1,a1,1
  while (n-- > 0) {
    185e:	fed518e3          	bne	a0,a3,184e <memcmp+0x14>
  }
  return 0;
    1862:	4501                	li	a0,0
    1864:	a019                	j	186a <memcmp+0x30>
      return *p1 - *p2;
    1866:	40e7853b          	subw	a0,a5,a4
}
    186a:	6422                	ld	s0,8(sp)
    186c:	0141                	add	sp,sp,16
    186e:	8082                	ret
  return 0;
    1870:	4501                	li	a0,0
    1872:	bfe5                	j	186a <memcmp+0x30>

0000000000001874 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    1874:	1141                	add	sp,sp,-16
    1876:	e406                	sd	ra,8(sp)
    1878:	e022                	sd	s0,0(sp)
    187a:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
    187c:	f67ff0ef          	jal	17e2 <memmove>
}
    1880:	60a2                	ld	ra,8(sp)
    1882:	6402                	ld	s0,0(sp)
    1884:	0141                	add	sp,sp,16
    1886:	8082                	ret

0000000000001888 <htons>:
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
}

uint16_t
htons(uint16_t h)
{
    1888:	1141                	add	sp,sp,-16
    188a:	e422                	sd	s0,8(sp)
    188c:	0800                	add	s0,sp,16
    if (!endian) {
    188e:	00001797          	auipc	a5,0x1
    1892:	7927a783          	lw	a5,1938(a5) # 3020 <endian>
    1896:	e385                	bnez	a5,18b6 <htons+0x2e>
        endian = byteorder();
    1898:	4d200793          	li	a5,1234
    189c:	00001717          	auipc	a4,0x1
    18a0:	78f72223          	sw	a5,1924(a4) # 3020 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
    18a4:	0085179b          	sllw	a5,a0,0x8
    18a8:	0085551b          	srlw	a0,a0,0x8
    18ac:	8fc9                	or	a5,a5,a0
    18ae:	03079513          	sll	a0,a5,0x30
    18b2:	9141                	srl	a0,a0,0x30
    18b4:	a029                	j	18be <htons+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(h) : h;
    18b6:	4d200713          	li	a4,1234
    18ba:	fee785e3          	beq	a5,a4,18a4 <htons+0x1c>
}
    18be:	6422                	ld	s0,8(sp)
    18c0:	0141                	add	sp,sp,16
    18c2:	8082                	ret

00000000000018c4 <ntohs>:

uint16_t
ntohs(uint16_t n)
{
    18c4:	1141                	add	sp,sp,-16
    18c6:	e422                	sd	s0,8(sp)
    18c8:	0800                	add	s0,sp,16
    if (!endian) {
    18ca:	00001797          	auipc	a5,0x1
    18ce:	7567a783          	lw	a5,1878(a5) # 3020 <endian>
    18d2:	e385                	bnez	a5,18f2 <ntohs+0x2e>
        endian = byteorder();
    18d4:	4d200793          	li	a5,1234
    18d8:	00001717          	auipc	a4,0x1
    18dc:	74f72423          	sw	a5,1864(a4) # 3020 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
    18e0:	0085179b          	sllw	a5,a0,0x8
    18e4:	0085551b          	srlw	a0,a0,0x8
    18e8:	8fc9                	or	a5,a5,a0
    18ea:	03079513          	sll	a0,a5,0x30
    18ee:	9141                	srl	a0,a0,0x30
    18f0:	a029                	j	18fa <ntohs+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(n) : n;
    18f2:	4d200713          	li	a4,1234
    18f6:	fee785e3          	beq	a5,a4,18e0 <ntohs+0x1c>
}
    18fa:	6422                	ld	s0,8(sp)
    18fc:	0141                	add	sp,sp,16
    18fe:	8082                	ret

0000000000001900 <htonl>:

uint32_t
htonl(uint32_t h)
{
    1900:	1141                	add	sp,sp,-16
    1902:	e422                	sd	s0,8(sp)
    1904:	0800                	add	s0,sp,16
    if (!endian) {
    1906:	00001797          	auipc	a5,0x1
    190a:	71a7a783          	lw	a5,1818(a5) # 3020 <endian>
    190e:	ef85                	bnez	a5,1946 <htonl+0x46>
        endian = byteorder();
    1910:	4d200793          	li	a5,1234
    1914:	00001717          	auipc	a4,0x1
    1918:	70f72623          	sw	a5,1804(a4) # 3020 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
    191c:	0185179b          	sllw	a5,a0,0x18
    1920:	0185571b          	srlw	a4,a0,0x18
    1924:	8fd9                	or	a5,a5,a4
    1926:	0085171b          	sllw	a4,a0,0x8
    192a:	00ff06b7          	lui	a3,0xff0
    192e:	8f75                	and	a4,a4,a3
    1930:	8fd9                	or	a5,a5,a4
    1932:	0085551b          	srlw	a0,a0,0x8
    1936:	6741                	lui	a4,0x10
    1938:	f0070713          	add	a4,a4,-256 # ff00 <base+0xcda0>
    193c:	8d79                	and	a0,a0,a4
    193e:	8fc9                	or	a5,a5,a0
    1940:	0007851b          	sext.w	a0,a5
    1944:	a029                	j	194e <htonl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(h) : h;
    1946:	4d200713          	li	a4,1234
    194a:	fce789e3          	beq	a5,a4,191c <htonl+0x1c>
}
    194e:	6422                	ld	s0,8(sp)
    1950:	0141                	add	sp,sp,16
    1952:	8082                	ret

0000000000001954 <ntohl>:

uint32_t
ntohl(uint32_t n)
{
    1954:	1141                	add	sp,sp,-16
    1956:	e422                	sd	s0,8(sp)
    1958:	0800                	add	s0,sp,16
    if (!endian) {
    195a:	00001797          	auipc	a5,0x1
    195e:	6c67a783          	lw	a5,1734(a5) # 3020 <endian>
    1962:	ef85                	bnez	a5,199a <ntohl+0x46>
        endian = byteorder();
    1964:	4d200793          	li	a5,1234
    1968:	00001717          	auipc	a4,0x1
    196c:	6af72c23          	sw	a5,1720(a4) # 3020 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
    1970:	0185179b          	sllw	a5,a0,0x18
    1974:	0185571b          	srlw	a4,a0,0x18
    1978:	8fd9                	or	a5,a5,a4
    197a:	0085171b          	sllw	a4,a0,0x8
    197e:	00ff06b7          	lui	a3,0xff0
    1982:	8f75                	and	a4,a4,a3
    1984:	8fd9                	or	a5,a5,a4
    1986:	0085551b          	srlw	a0,a0,0x8
    198a:	6741                	lui	a4,0x10
    198c:	f0070713          	add	a4,a4,-256 # ff00 <base+0xcda0>
    1990:	8d79                	and	a0,a0,a4
    1992:	8fc9                	or	a5,a5,a0
    1994:	0007851b          	sext.w	a0,a5
    1998:	a029                	j	19a2 <ntohl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(n) : n;
    199a:	4d200713          	li	a4,1234
    199e:	fce789e3          	beq	a5,a4,1970 <ntohl+0x1c>
}
    19a2:	6422                	ld	s0,8(sp)
    19a4:	0141                	add	sp,sp,16
    19a6:	8082                	ret

00000000000019a8 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
    19a8:	1141                	add	sp,sp,-16
    19aa:	e422                	sd	s0,8(sp)
    19ac:	0800                	add	s0,sp,16
    19ae:	872a                	mv	a4,a0
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
    19b0:	02000693          	li	a3,32
    19b4:	4525                	li	a0,9
    19b6:	a011                	j	19ba <strtol+0x12>
        s++;
    19b8:	0705                	add	a4,a4,1
    while (*s == ' ' || *s == '\t')
    19ba:	00074783          	lbu	a5,0(a4)
    19be:	fed78de3          	beq	a5,a3,19b8 <strtol+0x10>
    19c2:	fea78be3          	beq	a5,a0,19b8 <strtol+0x10>

    // plus/minus sign
    if (*s == '+')
    19c6:	02b00693          	li	a3,43
    19ca:	02d78663          	beq	a5,a3,19f6 <strtol+0x4e>
        s++;
    else if (*s == '-')
    19ce:	02d00693          	li	a3,45
    int neg = 0;
    19d2:	4301                	li	t1,0
    else if (*s == '-')
    19d4:	02d78463          	beq	a5,a3,19fc <strtol+0x54>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
    19d8:	fef67793          	and	a5,a2,-17
    19dc:	eb89                	bnez	a5,19ee <strtol+0x46>
    19de:	00074683          	lbu	a3,0(a4)
    19e2:	03000793          	li	a5,48
    19e6:	00f68e63          	beq	a3,a5,1a02 <strtol+0x5a>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
    19ea:	e211                	bnez	a2,19ee <strtol+0x46>
        s++, base = 8;
    else if (base == 0)
        base = 10;
    19ec:	4629                	li	a2,10
    19ee:	4501                	li	a0,0

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
    19f0:	4825                	li	a6,9
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
    19f2:	48e5                	li	a7,25
    19f4:	a825                	j	1a2c <strtol+0x84>
        s++;
    19f6:	0705                	add	a4,a4,1
    int neg = 0;
    19f8:	4301                	li	t1,0
    19fa:	bff9                	j	19d8 <strtol+0x30>
        s++, neg = 1;
    19fc:	0705                	add	a4,a4,1
    19fe:	4305                	li	t1,1
    1a00:	bfe1                	j	19d8 <strtol+0x30>
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
    1a02:	00174683          	lbu	a3,1(a4)
    1a06:	07800793          	li	a5,120
    1a0a:	00f68663          	beq	a3,a5,1a16 <strtol+0x6e>
    else if (base == 0 && s[0] == '0')
    1a0e:	f265                	bnez	a2,19ee <strtol+0x46>
        s++, base = 8;
    1a10:	0705                	add	a4,a4,1
    1a12:	4621                	li	a2,8
    1a14:	bfe9                	j	19ee <strtol+0x46>
        s += 2, base = 16;
    1a16:	0709                	add	a4,a4,2
    1a18:	4641                	li	a2,16
    1a1a:	bfd1                	j	19ee <strtol+0x46>
            dig = *s - '0';
    1a1c:	fd07879b          	addw	a5,a5,-48
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
    1a20:	04c7d063          	bge	a5,a2,1a60 <strtol+0xb8>
            break;
        s++, val = (val * base) + dig;
    1a24:	0705                	add	a4,a4,1
    1a26:	02a60533          	mul	a0,a2,a0
    1a2a:	953e                	add	a0,a0,a5
        if (*s >= '0' && *s <= '9')
    1a2c:	00074783          	lbu	a5,0(a4)
    1a30:	fd07869b          	addw	a3,a5,-48
    1a34:	0ff6f693          	zext.b	a3,a3
    1a38:	fed872e3          	bgeu	a6,a3,1a1c <strtol+0x74>
        else if (*s >= 'a' && *s <= 'z')
    1a3c:	f9f7869b          	addw	a3,a5,-97
    1a40:	0ff6f693          	zext.b	a3,a3
    1a44:	00d8e563          	bltu	a7,a3,1a4e <strtol+0xa6>
            dig = *s - 'a' + 10;
    1a48:	fa97879b          	addw	a5,a5,-87
    1a4c:	bfd1                	j	1a20 <strtol+0x78>
        else if (*s >= 'A' && *s <= 'Z')
    1a4e:	fbf7869b          	addw	a3,a5,-65
    1a52:	0ff6f693          	zext.b	a3,a3
    1a56:	00d8e563          	bltu	a7,a3,1a60 <strtol+0xb8>
            dig = *s - 'A' + 10;
    1a5a:	fc97879b          	addw	a5,a5,-55
    1a5e:	b7c9                	j	1a20 <strtol+0x78>
        // we don't properly detect overflow!
    }

    if (endptr)
    1a60:	c191                	beqz	a1,1a64 <strtol+0xbc>
        *endptr = (char *) s;
    1a62:	e198                	sd	a4,0(a1)
    return (neg ? -val : val);
    1a64:	00030463          	beqz	t1,1a6c <strtol+0xc4>
    1a68:	40a00533          	neg	a0,a0
}
    1a6c:	6422                	ld	s0,8(sp)
    1a6e:	0141                	add	sp,sp,16
    1a70:	8082                	ret

0000000000001a72 <inet_pton>:
inet_pton (int family, const char *p, void *n) {
    char *sp, *ep;
    int idx;
    long ret;

    if (family != AF_INET) {
    1a72:	4785                	li	a5,1
    1a74:	08f51063          	bne	a0,a5,1af4 <inet_pton+0x82>
inet_pton (int family, const char *p, void *n) {
    1a78:	715d                	add	sp,sp,-80
    1a7a:	e486                	sd	ra,72(sp)
    1a7c:	e0a2                	sd	s0,64(sp)
    1a7e:	fc26                	sd	s1,56(sp)
    1a80:	f84a                	sd	s2,48(sp)
    1a82:	f44e                	sd	s3,40(sp)
    1a84:	f052                	sd	s4,32(sp)
    1a86:	ec56                	sd	s5,24(sp)
    1a88:	e85a                	sd	s6,16(sp)
    1a8a:	0880                	add	s0,sp,80
    1a8c:	84ae                	mv	s1,a1
    1a8e:	89b2                	mv	s3,a2
    1a90:	4901                	li	s2,0
        return -1;
    }
    sp = (char *)p;
    for (idx = 0; idx < 4; idx++) {
        ret = strtol(sp, &ep, 10);
        if (ret < 0 || ret > 255) {
    1a92:	0ff00a13          	li	s4,255
            return -1;
        }
        if (ep == sp) {
            return -1;
        }
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
    1a96:	4a8d                	li	s5,3
    1a98:	02e00b13          	li	s6,46
    1a9c:	a805                	j	1acc <inet_pton+0x5a>
    1a9e:	0007c783          	lbu	a5,0(a5)
    1aa2:	efb9                	bnez	a5,1b00 <inet_pton+0x8e>
            return -1;
        }
        ((uint8_t *)n)[idx] = ret;
    1aa4:	00a981a3          	sb	a0,3(s3)
        sp = ep + 1;
    }
    return 0;
    1aa8:	4501                	li	a0,0
}
    1aaa:	60a6                	ld	ra,72(sp)
    1aac:	6406                	ld	s0,64(sp)
    1aae:	74e2                	ld	s1,56(sp)
    1ab0:	7942                	ld	s2,48(sp)
    1ab2:	79a2                	ld	s3,40(sp)
    1ab4:	7a02                	ld	s4,32(sp)
    1ab6:	6ae2                	ld	s5,24(sp)
    1ab8:	6b42                	ld	s6,16(sp)
    1aba:	6161                	add	sp,sp,80
    1abc:	8082                	ret
        ((uint8_t *)n)[idx] = ret;
    1abe:	01298733          	add	a4,s3,s2
    1ac2:	00a70023          	sb	a0,0(a4)
        sp = ep + 1;
    1ac6:	00178493          	add	s1,a5,1
    for (idx = 0; idx < 4; idx++) {
    1aca:	0905                	add	s2,s2,1
        ret = strtol(sp, &ep, 10);
    1acc:	4629                	li	a2,10
    1ace:	fb840593          	add	a1,s0,-72
    1ad2:	8526                	mv	a0,s1
    1ad4:	ed5ff0ef          	jal	19a8 <strtol>
        if (ret < 0 || ret > 255) {
    1ad8:	02aa6063          	bltu	s4,a0,1af8 <inet_pton+0x86>
        if (ep == sp) {
    1adc:	fb843783          	ld	a5,-72(s0)
    1ae0:	00978e63          	beq	a5,s1,1afc <inet_pton+0x8a>
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
    1ae4:	fb590de3          	beq	s2,s5,1a9e <inet_pton+0x2c>
    1ae8:	0007c703          	lbu	a4,0(a5)
    1aec:	fd6709e3          	beq	a4,s6,1abe <inet_pton+0x4c>
            return -1;
    1af0:	557d                	li	a0,-1
    1af2:	bf65                	j	1aaa <inet_pton+0x38>
        return -1;
    1af4:	557d                	li	a0,-1
}
    1af6:	8082                	ret
            return -1;
    1af8:	557d                	li	a0,-1
    1afa:	bf45                	j	1aaa <inet_pton+0x38>
            return -1;
    1afc:	557d                	li	a0,-1
    1afe:	b775                	j	1aaa <inet_pton+0x38>
            return -1;
    1b00:	557d                	li	a0,-1
    1b02:	b765                	j	1aaa <inet_pton+0x38>

0000000000001b04 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    1b04:	4885                	li	a7,1
 ecall
    1b06:	00000073          	ecall
 ret
    1b0a:	8082                	ret

0000000000001b0c <exit>:
.global exit
exit:
 li a7, SYS_exit
    1b0c:	4889                	li	a7,2
 ecall
    1b0e:	00000073          	ecall
 ret
    1b12:	8082                	ret

0000000000001b14 <wait>:
.global wait
wait:
 li a7, SYS_wait
    1b14:	488d                	li	a7,3
 ecall
    1b16:	00000073          	ecall
 ret
    1b1a:	8082                	ret

0000000000001b1c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    1b1c:	4891                	li	a7,4
 ecall
    1b1e:	00000073          	ecall
 ret
    1b22:	8082                	ret

0000000000001b24 <read>:
.global read
read:
 li a7, SYS_read
    1b24:	4895                	li	a7,5
 ecall
    1b26:	00000073          	ecall
 ret
    1b2a:	8082                	ret

0000000000001b2c <write>:
.global write
write:
 li a7, SYS_write
    1b2c:	48c1                	li	a7,16
 ecall
    1b2e:	00000073          	ecall
 ret
    1b32:	8082                	ret

0000000000001b34 <close>:
.global close
close:
 li a7, SYS_close
    1b34:	48d5                	li	a7,21
 ecall
    1b36:	00000073          	ecall
 ret
    1b3a:	8082                	ret

0000000000001b3c <kill>:
.global kill
kill:
 li a7, SYS_kill
    1b3c:	4899                	li	a7,6
 ecall
    1b3e:	00000073          	ecall
 ret
    1b42:	8082                	ret

0000000000001b44 <exec>:
.global exec
exec:
 li a7, SYS_exec
    1b44:	489d                	li	a7,7
 ecall
    1b46:	00000073          	ecall
 ret
    1b4a:	8082                	ret

0000000000001b4c <open>:
.global open
open:
 li a7, SYS_open
    1b4c:	48bd                	li	a7,15
 ecall
    1b4e:	00000073          	ecall
 ret
    1b52:	8082                	ret

0000000000001b54 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    1b54:	48c5                	li	a7,17
 ecall
    1b56:	00000073          	ecall
 ret
    1b5a:	8082                	ret

0000000000001b5c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    1b5c:	48c9                	li	a7,18
 ecall
    1b5e:	00000073          	ecall
 ret
    1b62:	8082                	ret

0000000000001b64 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    1b64:	48a1                	li	a7,8
 ecall
    1b66:	00000073          	ecall
 ret
    1b6a:	8082                	ret

0000000000001b6c <link>:
.global link
link:
 li a7, SYS_link
    1b6c:	48cd                	li	a7,19
 ecall
    1b6e:	00000073          	ecall
 ret
    1b72:	8082                	ret

0000000000001b74 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    1b74:	48d1                	li	a7,20
 ecall
    1b76:	00000073          	ecall
 ret
    1b7a:	8082                	ret

0000000000001b7c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    1b7c:	48a5                	li	a7,9
 ecall
    1b7e:	00000073          	ecall
 ret
    1b82:	8082                	ret

0000000000001b84 <dup>:
.global dup
dup:
 li a7, SYS_dup
    1b84:	48a9                	li	a7,10
 ecall
    1b86:	00000073          	ecall
 ret
    1b8a:	8082                	ret

0000000000001b8c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    1b8c:	48ad                	li	a7,11
 ecall
    1b8e:	00000073          	ecall
 ret
    1b92:	8082                	ret

0000000000001b94 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    1b94:	48b1                	li	a7,12
 ecall
    1b96:	00000073          	ecall
 ret
    1b9a:	8082                	ret

0000000000001b9c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    1b9c:	48b5                	li	a7,13
 ecall
    1b9e:	00000073          	ecall
 ret
    1ba2:	8082                	ret

0000000000001ba4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    1ba4:	48b9                	li	a7,14
 ecall
    1ba6:	00000073          	ecall
 ret
    1baa:	8082                	ret

0000000000001bac <socket>:
.global socket
socket:
 li a7, SYS_socket
    1bac:	48d9                	li	a7,22
 ecall
    1bae:	00000073          	ecall
 ret
    1bb2:	8082                	ret

0000000000001bb4 <bind>:
.global bind
bind:
 li a7, SYS_bind
    1bb4:	48dd                	li	a7,23
 ecall
    1bb6:	00000073          	ecall
 ret
    1bba:	8082                	ret

0000000000001bbc <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
    1bbc:	48e1                	li	a7,24
 ecall
    1bbe:	00000073          	ecall
 ret
    1bc2:	8082                	ret

0000000000001bc4 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
    1bc4:	48e5                	li	a7,25
 ecall
    1bc6:	00000073          	ecall
 ret
    1bca:	8082                	ret

0000000000001bcc <connect>:
.global connect
connect:
 li a7, SYS_connect
    1bcc:	48e9                	li	a7,26
 ecall
    1bce:	00000073          	ecall
 ret
    1bd2:	8082                	ret

0000000000001bd4 <listen>:
.global listen
listen:
 li a7, SYS_listen
    1bd4:	48ed                	li	a7,27
 ecall
    1bd6:	00000073          	ecall
 ret
    1bda:	8082                	ret

0000000000001bdc <accept>:
.global accept
accept:
 li a7, SYS_accept
    1bdc:	48f1                	li	a7,28
 ecall
    1bde:	00000073          	ecall
 ret
    1be2:	8082                	ret

0000000000001be4 <recv>:
.global recv
recv:
 li a7, SYS_recv
    1be4:	48f5                	li	a7,29
 ecall
    1be6:	00000073          	ecall
 ret
    1bea:	8082                	ret

0000000000001bec <send>:
.global send
send:
 li a7, SYS_send
    1bec:	48f9                	li	a7,30
 ecall
    1bee:	00000073          	ecall
 ret
    1bf2:	8082                	ret

0000000000001bf4 <ioctl>:
.global ioctl
ioctl:
 li a7, SYS_ioctl
    1bf4:	48fd                	li	a7,31
 ecall
    1bf6:	00000073          	ecall
 ret
    1bfa:	8082                	ret

0000000000001bfc <consolemode>:
.global consolemode
consolemode:
 li a7, SYS_consolemode
    1bfc:	02000893          	li	a7,32
 ecall
    1c00:	00000073          	ecall
 ret
    1c04:	8082                	ret

0000000000001c06 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    1c06:	1101                	add	sp,sp,-32
    1c08:	ec06                	sd	ra,24(sp)
    1c0a:	e822                	sd	s0,16(sp)
    1c0c:	1000                	add	s0,sp,32
    1c0e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    1c12:	4605                	li	a2,1
    1c14:	fef40593          	add	a1,s0,-17
    1c18:	f15ff0ef          	jal	1b2c <write>
}
    1c1c:	60e2                	ld	ra,24(sp)
    1c1e:	6442                	ld	s0,16(sp)
    1c20:	6105                	add	sp,sp,32
    1c22:	8082                	ret

0000000000001c24 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
    1c24:	715d                	add	sp,sp,-80
    1c26:	e486                	sd	ra,72(sp)
    1c28:	e0a2                	sd	s0,64(sp)
    1c2a:	fc26                	sd	s1,56(sp)
    1c2c:	0880                	add	s0,sp,80
    1c2e:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1c30:	c299                	beqz	a3,1c36 <printint+0x12>
    1c32:	0805c963          	bltz	a1,1cc4 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1c36:	2581                	sext.w	a1,a1
  neg = 0;
    1c38:	4881                	li	a7,0
    1c3a:	fb840693          	add	a3,s0,-72
  }

  i = 0;
    1c3e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    1c40:	2601                	sext.w	a2,a2
    1c42:	00000517          	auipc	a0,0x0
    1c46:	6d650513          	add	a0,a0,1750 # 2318 <digits>
    1c4a:	883a                	mv	a6,a4
    1c4c:	2705                	addw	a4,a4,1
    1c4e:	02c5f7bb          	remuw	a5,a1,a2
    1c52:	1782                	sll	a5,a5,0x20
    1c54:	9381                	srl	a5,a5,0x20
    1c56:	97aa                	add	a5,a5,a0
    1c58:	0007c783          	lbu	a5,0(a5)
    1c5c:	00f68023          	sb	a5,0(a3) # ff0000 <base+0xfecea0>
  }while((x /= base) != 0);
    1c60:	0005879b          	sext.w	a5,a1
    1c64:	02c5d5bb          	divuw	a1,a1,a2
    1c68:	0685                	add	a3,a3,1
    1c6a:	fec7f0e3          	bgeu	a5,a2,1c4a <printint+0x26>
  if(neg)
    1c6e:	00088c63          	beqz	a7,1c86 <printint+0x62>
    buf[i++] = '-';
    1c72:	fd070793          	add	a5,a4,-48
    1c76:	00878733          	add	a4,a5,s0
    1c7a:	02d00793          	li	a5,45
    1c7e:	fef70423          	sb	a5,-24(a4)
    1c82:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
    1c86:	02e05a63          	blez	a4,1cba <printint+0x96>
    1c8a:	f84a                	sd	s2,48(sp)
    1c8c:	f44e                	sd	s3,40(sp)
    1c8e:	fb840793          	add	a5,s0,-72
    1c92:	00e78933          	add	s2,a5,a4
    1c96:	fff78993          	add	s3,a5,-1
    1c9a:	99ba                	add	s3,s3,a4
    1c9c:	377d                	addw	a4,a4,-1
    1c9e:	1702                	sll	a4,a4,0x20
    1ca0:	9301                	srl	a4,a4,0x20
    1ca2:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    1ca6:	fff94583          	lbu	a1,-1(s2)
    1caa:	8526                	mv	a0,s1
    1cac:	f5bff0ef          	jal	1c06 <putc>
  while(--i >= 0)
    1cb0:	197d                	add	s2,s2,-1
    1cb2:	ff391ae3          	bne	s2,s3,1ca6 <printint+0x82>
    1cb6:	7942                	ld	s2,48(sp)
    1cb8:	79a2                	ld	s3,40(sp)
}
    1cba:	60a6                	ld	ra,72(sp)
    1cbc:	6406                	ld	s0,64(sp)
    1cbe:	74e2                	ld	s1,56(sp)
    1cc0:	6161                	add	sp,sp,80
    1cc2:	8082                	ret
    x = -xx;
    1cc4:	40b005bb          	negw	a1,a1
    neg = 1;
    1cc8:	4885                	li	a7,1
    x = -xx;
    1cca:	bf85                	j	1c3a <printint+0x16>

0000000000001ccc <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    1ccc:	711d                	add	sp,sp,-96
    1cce:	ec86                	sd	ra,88(sp)
    1cd0:	e8a2                	sd	s0,80(sp)
    1cd2:	e0ca                	sd	s2,64(sp)
    1cd4:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    1cd6:	0005c903          	lbu	s2,0(a1)
    1cda:	26090863          	beqz	s2,1f4a <vprintf+0x27e>
    1cde:	e4a6                	sd	s1,72(sp)
    1ce0:	fc4e                	sd	s3,56(sp)
    1ce2:	f852                	sd	s4,48(sp)
    1ce4:	f456                	sd	s5,40(sp)
    1ce6:	f05a                	sd	s6,32(sp)
    1ce8:	ec5e                	sd	s7,24(sp)
    1cea:	e862                	sd	s8,16(sp)
    1cec:	e466                	sd	s9,8(sp)
    1cee:	8b2a                	mv	s6,a0
    1cf0:	8a2e                	mv	s4,a1
    1cf2:	8bb2                	mv	s7,a2
  state = 0;
    1cf4:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
    1cf6:	4481                	li	s1,0
    1cf8:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
    1cfa:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
    1cfe:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
    1d02:	06c00c93          	li	s9,108
    1d06:	a005                	j	1d26 <vprintf+0x5a>
        putc(fd, c0);
    1d08:	85ca                	mv	a1,s2
    1d0a:	855a                	mv	a0,s6
    1d0c:	efbff0ef          	jal	1c06 <putc>
    1d10:	a019                	j	1d16 <vprintf+0x4a>
    } else if(state == '%'){
    1d12:	03598263          	beq	s3,s5,1d36 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
    1d16:	2485                	addw	s1,s1,1
    1d18:	8726                	mv	a4,s1
    1d1a:	009a07b3          	add	a5,s4,s1
    1d1e:	0007c903          	lbu	s2,0(a5)
    1d22:	20090c63          	beqz	s2,1f3a <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
    1d26:	0009079b          	sext.w	a5,s2
    if(state == 0){
    1d2a:	fe0994e3          	bnez	s3,1d12 <vprintf+0x46>
      if(c0 == '%'){
    1d2e:	fd579de3          	bne	a5,s5,1d08 <vprintf+0x3c>
        state = '%';
    1d32:	89be                	mv	s3,a5
    1d34:	b7cd                	j	1d16 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
    1d36:	00ea06b3          	add	a3,s4,a4
    1d3a:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
    1d3e:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
    1d40:	c681                	beqz	a3,1d48 <vprintf+0x7c>
    1d42:	9752                	add	a4,a4,s4
    1d44:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
    1d48:	03878f63          	beq	a5,s8,1d86 <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
    1d4c:	05978963          	beq	a5,s9,1d9e <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
    1d50:	07500713          	li	a4,117
    1d54:	0ee78363          	beq	a5,a4,1e3a <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
    1d58:	07800713          	li	a4,120
    1d5c:	12e78563          	beq	a5,a4,1e86 <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
    1d60:	07000713          	li	a4,112
    1d64:	14e78a63          	beq	a5,a4,1eb8 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
    1d68:	07300713          	li	a4,115
    1d6c:	18e78a63          	beq	a5,a4,1f00 <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
    1d70:	02500713          	li	a4,37
    1d74:	04e79563          	bne	a5,a4,1dbe <vprintf+0xf2>
        putc(fd, '%');
    1d78:	02500593          	li	a1,37
    1d7c:	855a                	mv	a0,s6
    1d7e:	e89ff0ef          	jal	1c06 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
    1d82:	4981                	li	s3,0
    1d84:	bf49                	j	1d16 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
    1d86:	008b8913          	add	s2,s7,8
    1d8a:	4685                	li	a3,1
    1d8c:	4629                	li	a2,10
    1d8e:	000ba583          	lw	a1,0(s7)
    1d92:	855a                	mv	a0,s6
    1d94:	e91ff0ef          	jal	1c24 <printint>
    1d98:	8bca                	mv	s7,s2
      state = 0;
    1d9a:	4981                	li	s3,0
    1d9c:	bfad                	j	1d16 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
    1d9e:	06400793          	li	a5,100
    1da2:	02f68963          	beq	a3,a5,1dd4 <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    1da6:	06c00793          	li	a5,108
    1daa:	04f68263          	beq	a3,a5,1dee <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
    1dae:	07500793          	li	a5,117
    1db2:	0af68063          	beq	a3,a5,1e52 <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
    1db6:	07800793          	li	a5,120
    1dba:	0ef68263          	beq	a3,a5,1e9e <vprintf+0x1d2>
        putc(fd, '%');
    1dbe:	02500593          	li	a1,37
    1dc2:	855a                	mv	a0,s6
    1dc4:	e43ff0ef          	jal	1c06 <putc>
        putc(fd, c0);
    1dc8:	85ca                	mv	a1,s2
    1dca:	855a                	mv	a0,s6
    1dcc:	e3bff0ef          	jal	1c06 <putc>
      state = 0;
    1dd0:	4981                	li	s3,0
    1dd2:	b791                	j	1d16 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
    1dd4:	008b8913          	add	s2,s7,8
    1dd8:	4685                	li	a3,1
    1dda:	4629                	li	a2,10
    1ddc:	000bb583          	ld	a1,0(s7)
    1de0:	855a                	mv	a0,s6
    1de2:	e43ff0ef          	jal	1c24 <printint>
        i += 1;
    1de6:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
    1de8:	8bca                	mv	s7,s2
      state = 0;
    1dea:	4981                	li	s3,0
        i += 1;
    1dec:	b72d                	j	1d16 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    1dee:	06400793          	li	a5,100
    1df2:	02f60763          	beq	a2,a5,1e20 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
    1df6:	07500793          	li	a5,117
    1dfa:	06f60963          	beq	a2,a5,1e6c <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
    1dfe:	07800793          	li	a5,120
    1e02:	faf61ee3          	bne	a2,a5,1dbe <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
    1e06:	008b8913          	add	s2,s7,8
    1e0a:	4681                	li	a3,0
    1e0c:	4641                	li	a2,16
    1e0e:	000bb583          	ld	a1,0(s7)
    1e12:	855a                	mv	a0,s6
    1e14:	e11ff0ef          	jal	1c24 <printint>
        i += 2;
    1e18:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
    1e1a:	8bca                	mv	s7,s2
      state = 0;
    1e1c:	4981                	li	s3,0
        i += 2;
    1e1e:	bde5                	j	1d16 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
    1e20:	008b8913          	add	s2,s7,8
    1e24:	4685                	li	a3,1
    1e26:	4629                	li	a2,10
    1e28:	000bb583          	ld	a1,0(s7)
    1e2c:	855a                	mv	a0,s6
    1e2e:	df7ff0ef          	jal	1c24 <printint>
        i += 2;
    1e32:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
    1e34:	8bca                	mv	s7,s2
      state = 0;
    1e36:	4981                	li	s3,0
        i += 2;
    1e38:	bdf9                	j	1d16 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
    1e3a:	008b8913          	add	s2,s7,8
    1e3e:	4681                	li	a3,0
    1e40:	4629                	li	a2,10
    1e42:	000ba583          	lw	a1,0(s7)
    1e46:	855a                	mv	a0,s6
    1e48:	dddff0ef          	jal	1c24 <printint>
    1e4c:	8bca                	mv	s7,s2
      state = 0;
    1e4e:	4981                	li	s3,0
    1e50:	b5d9                	j	1d16 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
    1e52:	008b8913          	add	s2,s7,8
    1e56:	4681                	li	a3,0
    1e58:	4629                	li	a2,10
    1e5a:	000bb583          	ld	a1,0(s7)
    1e5e:	855a                	mv	a0,s6
    1e60:	dc5ff0ef          	jal	1c24 <printint>
        i += 1;
    1e64:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
    1e66:	8bca                	mv	s7,s2
      state = 0;
    1e68:	4981                	li	s3,0
        i += 1;
    1e6a:	b575                	j	1d16 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
    1e6c:	008b8913          	add	s2,s7,8
    1e70:	4681                	li	a3,0
    1e72:	4629                	li	a2,10
    1e74:	000bb583          	ld	a1,0(s7)
    1e78:	855a                	mv	a0,s6
    1e7a:	dabff0ef          	jal	1c24 <printint>
        i += 2;
    1e7e:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
    1e80:	8bca                	mv	s7,s2
      state = 0;
    1e82:	4981                	li	s3,0
        i += 2;
    1e84:	bd49                	j	1d16 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
    1e86:	008b8913          	add	s2,s7,8
    1e8a:	4681                	li	a3,0
    1e8c:	4641                	li	a2,16
    1e8e:	000ba583          	lw	a1,0(s7)
    1e92:	855a                	mv	a0,s6
    1e94:	d91ff0ef          	jal	1c24 <printint>
    1e98:	8bca                	mv	s7,s2
      state = 0;
    1e9a:	4981                	li	s3,0
    1e9c:	bdad                	j	1d16 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
    1e9e:	008b8913          	add	s2,s7,8
    1ea2:	4681                	li	a3,0
    1ea4:	4641                	li	a2,16
    1ea6:	000bb583          	ld	a1,0(s7)
    1eaa:	855a                	mv	a0,s6
    1eac:	d79ff0ef          	jal	1c24 <printint>
        i += 1;
    1eb0:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
    1eb2:	8bca                	mv	s7,s2
      state = 0;
    1eb4:	4981                	li	s3,0
        i += 1;
    1eb6:	b585                	j	1d16 <vprintf+0x4a>
    1eb8:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
    1eba:	008b8d13          	add	s10,s7,8
    1ebe:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    1ec2:	03000593          	li	a1,48
    1ec6:	855a                	mv	a0,s6
    1ec8:	d3fff0ef          	jal	1c06 <putc>
  putc(fd, 'x');
    1ecc:	07800593          	li	a1,120
    1ed0:	855a                	mv	a0,s6
    1ed2:	d35ff0ef          	jal	1c06 <putc>
    1ed6:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    1ed8:	00000b97          	auipc	s7,0x0
    1edc:	440b8b93          	add	s7,s7,1088 # 2318 <digits>
    1ee0:	03c9d793          	srl	a5,s3,0x3c
    1ee4:	97de                	add	a5,a5,s7
    1ee6:	0007c583          	lbu	a1,0(a5)
    1eea:	855a                	mv	a0,s6
    1eec:	d1bff0ef          	jal	1c06 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1ef0:	0992                	sll	s3,s3,0x4
    1ef2:	397d                	addw	s2,s2,-1
    1ef4:	fe0916e3          	bnez	s2,1ee0 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
    1ef8:	8bea                	mv	s7,s10
      state = 0;
    1efa:	4981                	li	s3,0
    1efc:	6d02                	ld	s10,0(sp)
    1efe:	bd21                	j	1d16 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
    1f00:	008b8993          	add	s3,s7,8
    1f04:	000bb903          	ld	s2,0(s7)
    1f08:	00090f63          	beqz	s2,1f26 <vprintf+0x25a>
        for(; *s; s++)
    1f0c:	00094583          	lbu	a1,0(s2)
    1f10:	c195                	beqz	a1,1f34 <vprintf+0x268>
          putc(fd, *s);
    1f12:	855a                	mv	a0,s6
    1f14:	cf3ff0ef          	jal	1c06 <putc>
        for(; *s; s++)
    1f18:	0905                	add	s2,s2,1
    1f1a:	00094583          	lbu	a1,0(s2)
    1f1e:	f9f5                	bnez	a1,1f12 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
    1f20:	8bce                	mv	s7,s3
      state = 0;
    1f22:	4981                	li	s3,0
    1f24:	bbcd                	j	1d16 <vprintf+0x4a>
          s = "(null)";
    1f26:	00000917          	auipc	s2,0x0
    1f2a:	34290913          	add	s2,s2,834 # 2268 <malloc+0x22e>
        for(; *s; s++)
    1f2e:	02800593          	li	a1,40
    1f32:	b7c5                	j	1f12 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
    1f34:	8bce                	mv	s7,s3
      state = 0;
    1f36:	4981                	li	s3,0
    1f38:	bbf9                	j	1d16 <vprintf+0x4a>
    1f3a:	64a6                	ld	s1,72(sp)
    1f3c:	79e2                	ld	s3,56(sp)
    1f3e:	7a42                	ld	s4,48(sp)
    1f40:	7aa2                	ld	s5,40(sp)
    1f42:	7b02                	ld	s6,32(sp)
    1f44:	6be2                	ld	s7,24(sp)
    1f46:	6c42                	ld	s8,16(sp)
    1f48:	6ca2                	ld	s9,8(sp)
    }
  }
}
    1f4a:	60e6                	ld	ra,88(sp)
    1f4c:	6446                	ld	s0,80(sp)
    1f4e:	6906                	ld	s2,64(sp)
    1f50:	6125                	add	sp,sp,96
    1f52:	8082                	ret

0000000000001f54 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    1f54:	715d                	add	sp,sp,-80
    1f56:	ec06                	sd	ra,24(sp)
    1f58:	e822                	sd	s0,16(sp)
    1f5a:	1000                	add	s0,sp,32
    1f5c:	e010                	sd	a2,0(s0)
    1f5e:	e414                	sd	a3,8(s0)
    1f60:	e818                	sd	a4,16(s0)
    1f62:	ec1c                	sd	a5,24(s0)
    1f64:	03043023          	sd	a6,32(s0)
    1f68:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    1f6c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    1f70:	8622                	mv	a2,s0
    1f72:	d5bff0ef          	jal	1ccc <vprintf>
}
    1f76:	60e2                	ld	ra,24(sp)
    1f78:	6442                	ld	s0,16(sp)
    1f7a:	6161                	add	sp,sp,80
    1f7c:	8082                	ret

0000000000001f7e <printf>:

void
printf(const char *fmt, ...)
{
    1f7e:	711d                	add	sp,sp,-96
    1f80:	ec06                	sd	ra,24(sp)
    1f82:	e822                	sd	s0,16(sp)
    1f84:	1000                	add	s0,sp,32
    1f86:	e40c                	sd	a1,8(s0)
    1f88:	e810                	sd	a2,16(s0)
    1f8a:	ec14                	sd	a3,24(s0)
    1f8c:	f018                	sd	a4,32(s0)
    1f8e:	f41c                	sd	a5,40(s0)
    1f90:	03043823          	sd	a6,48(s0)
    1f94:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    1f98:	00840613          	add	a2,s0,8
    1f9c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    1fa0:	85aa                	mv	a1,a0
    1fa2:	4505                	li	a0,1
    1fa4:	d29ff0ef          	jal	1ccc <vprintf>
}
    1fa8:	60e2                	ld	ra,24(sp)
    1faa:	6442                	ld	s0,16(sp)
    1fac:	6125                	add	sp,sp,96
    1fae:	8082                	ret

0000000000001fb0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1fb0:	1141                	add	sp,sp,-16
    1fb2:	e422                	sd	s0,8(sp)
    1fb4:	0800                	add	s0,sp,16
  Header *bp, *p;

  if(ap == 0)
    1fb6:	cd3d                	beqz	a0,2034 <free+0x84>
    return;
  if((uint64)ap < 4096)
    1fb8:	6785                	lui	a5,0x1
    1fba:	06f56d63          	bltu	a0,a5,2034 <free+0x84>
    return;
  bp = (Header*)ap - 1;
    1fbe:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1fc2:	00001797          	auipc	a5,0x1
    1fc6:	0667b783          	ld	a5,102(a5) # 3028 <freep>
    1fca:	a02d                	j	1ff4 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    1fcc:	4618                	lw	a4,8(a2)
    1fce:	9f2d                	addw	a4,a4,a1
    1fd0:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    1fd4:	6398                	ld	a4,0(a5)
    1fd6:	6310                	ld	a2,0(a4)
    1fd8:	a83d                	j	2016 <free+0x66>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    1fda:	ff852703          	lw	a4,-8(a0)
    1fde:	9f31                	addw	a4,a4,a2
    1fe0:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    1fe2:	ff053683          	ld	a3,-16(a0)
    1fe6:	a091                	j	202a <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1fe8:	6398                	ld	a4,0(a5)
    1fea:	00e7e463          	bltu	a5,a4,1ff2 <free+0x42>
    1fee:	00e6ea63          	bltu	a3,a4,2002 <free+0x52>
{
    1ff2:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1ff4:	fed7fae3          	bgeu	a5,a3,1fe8 <free+0x38>
    1ff8:	6398                	ld	a4,0(a5)
    1ffa:	00e6e463          	bltu	a3,a4,2002 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1ffe:	fee7eae3          	bltu	a5,a4,1ff2 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
    2002:	ff852583          	lw	a1,-8(a0)
    2006:	6390                	ld	a2,0(a5)
    2008:	02059813          	sll	a6,a1,0x20
    200c:	01c85713          	srl	a4,a6,0x1c
    2010:	9736                	add	a4,a4,a3
    2012:	fae60de3          	beq	a2,a4,1fcc <free+0x1c>
    bp->s.ptr = p->s.ptr->s.ptr;
    2016:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    201a:	4790                	lw	a2,8(a5)
    201c:	02061593          	sll	a1,a2,0x20
    2020:	01c5d713          	srl	a4,a1,0x1c
    2024:	973e                	add	a4,a4,a5
    2026:	fae68ae3          	beq	a3,a4,1fda <free+0x2a>
    p->s.ptr = bp->s.ptr;
    202a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    202c:	00001717          	auipc	a4,0x1
    2030:	fef73e23          	sd	a5,-4(a4) # 3028 <freep>
}
    2034:	6422                	ld	s0,8(sp)
    2036:	0141                	add	sp,sp,16
    2038:	8082                	ret

000000000000203a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    203a:	7139                	add	sp,sp,-64
    203c:	fc06                	sd	ra,56(sp)
    203e:	f822                	sd	s0,48(sp)
    2040:	f426                	sd	s1,40(sp)
    2042:	ec4e                	sd	s3,24(sp)
    2044:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    2046:	02051493          	sll	s1,a0,0x20
    204a:	9081                	srl	s1,s1,0x20
    204c:	04bd                	add	s1,s1,15
    204e:	8091                	srl	s1,s1,0x4
    2050:	0014899b          	addw	s3,s1,1
    2054:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
    2056:	00001517          	auipc	a0,0x1
    205a:	fd253503          	ld	a0,-46(a0) # 3028 <freep>
    205e:	c915                	beqz	a0,2092 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    2060:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    2062:	4798                	lw	a4,8(a5)
    2064:	08977a63          	bgeu	a4,s1,20f8 <malloc+0xbe>
    2068:	f04a                	sd	s2,32(sp)
    206a:	e852                	sd	s4,16(sp)
    206c:	e456                	sd	s5,8(sp)
    206e:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    2070:	8a4e                	mv	s4,s3
    2072:	0009871b          	sext.w	a4,s3
    2076:	6685                	lui	a3,0x1
    2078:	00d77363          	bgeu	a4,a3,207e <malloc+0x44>
    207c:	6a05                	lui	s4,0x1
    207e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    2082:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    2086:	00001917          	auipc	s2,0x1
    208a:	fa290913          	add	s2,s2,-94 # 3028 <freep>
  if(p == (char*)-1)
    208e:	5afd                	li	s5,-1
    2090:	a081                	j	20d0 <malloc+0x96>
    2092:	f04a                	sd	s2,32(sp)
    2094:	e852                	sd	s4,16(sp)
    2096:	e456                	sd	s5,8(sp)
    2098:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    209a:	00001797          	auipc	a5,0x1
    209e:	0c678793          	add	a5,a5,198 # 3160 <base>
    20a2:	00001717          	auipc	a4,0x1
    20a6:	f8f73323          	sd	a5,-122(a4) # 3028 <freep>
    20aa:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    20ac:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    20b0:	b7c1                	j	2070 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
    20b2:	6398                	ld	a4,0(a5)
    20b4:	e118                	sd	a4,0(a0)
    20b6:	a8a9                	j	2110 <malloc+0xd6>
  hp->s.size = nu;
    20b8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    20bc:	0541                	add	a0,a0,16
    20be:	ef3ff0ef          	jal	1fb0 <free>
  return freep;
    20c2:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    20c6:	c12d                	beqz	a0,2128 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    20c8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    20ca:	4798                	lw	a4,8(a5)
    20cc:	02977263          	bgeu	a4,s1,20f0 <malloc+0xb6>
    if(p == freep)
    20d0:	00093703          	ld	a4,0(s2)
    20d4:	853e                	mv	a0,a5
    20d6:	fef719e3          	bne	a4,a5,20c8 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
    20da:	8552                	mv	a0,s4
    20dc:	ab9ff0ef          	jal	1b94 <sbrk>
  if(p == (char*)-1)
    20e0:	fd551ce3          	bne	a0,s5,20b8 <malloc+0x7e>
        return 0;
    20e4:	4501                	li	a0,0
    20e6:	7902                	ld	s2,32(sp)
    20e8:	6a42                	ld	s4,16(sp)
    20ea:	6aa2                	ld	s5,8(sp)
    20ec:	6b02                	ld	s6,0(sp)
    20ee:	a03d                	j	211c <malloc+0xe2>
    20f0:	7902                	ld	s2,32(sp)
    20f2:	6a42                	ld	s4,16(sp)
    20f4:	6aa2                	ld	s5,8(sp)
    20f6:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    20f8:	fae48de3          	beq	s1,a4,20b2 <malloc+0x78>
        p->s.size -= nunits;
    20fc:	4137073b          	subw	a4,a4,s3
    2100:	c798                	sw	a4,8(a5)
        p += p->s.size;
    2102:	02071693          	sll	a3,a4,0x20
    2106:	01c6d713          	srl	a4,a3,0x1c
    210a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    210c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    2110:	00001717          	auipc	a4,0x1
    2114:	f0a73c23          	sd	a0,-232(a4) # 3028 <freep>
      return (void*)(p + 1);
    2118:	01078513          	add	a0,a5,16
  }
}
    211c:	70e2                	ld	ra,56(sp)
    211e:	7442                	ld	s0,48(sp)
    2120:	74a2                	ld	s1,40(sp)
    2122:	69e2                	ld	s3,24(sp)
    2124:	6121                	add	sp,sp,64
    2126:	8082                	ret
    2128:	7902                	ld	s2,32(sp)
    212a:	6a42                	ld	s4,16(sp)
    212c:	6aa2                	ld	s5,8(sp)
    212e:	6b02                	ld	s6,0(sp)
    2130:	b7f5                	j	211c <malloc+0xe2>
