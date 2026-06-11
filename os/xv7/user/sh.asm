
user/_sh:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <add_history>:
void
add_history(char *cmd)
{
  int fd;
  struct stat st;
  if(cmd[0] == 0) return;
       0:	00054783          	lbu	a5,0(a0)
       4:	12078f63          	beqz	a5,142 <add_history+0x142>
{
       8:	715d                	add	sp,sp,-80
       a:	e486                	sd	ra,72(sp)
       c:	e0a2                	sd	s0,64(sp)
       e:	fc26                	sd	s1,56(sp)
      10:	f84a                	sd	s2,48(sp)
      12:	0880                	add	s0,sp,80
      14:	892a                	mv	s2,a0
  if(hist_count > 0 && strcmp(history[(hist_count-1) % HIST_SIZE], cmd) == 0) return;
      16:	00002497          	auipc	s1,0x2
      1a:	ffe4a483          	lw	s1,-2(s1) # 2014 <hist_count>
      1e:	02905563          	blez	s1,48 <add_history+0x48>
      22:	fff4879b          	addw	a5,s1,-1
      26:	41f7d71b          	sraw	a4,a5,0x1f
      2a:	01c7571b          	srlw	a4,a4,0x1c
      2e:	9fb9                	addw	a5,a5,a4
      30:	8bbd                	and	a5,a5,15
      32:	9f99                	subw	a5,a5,a4
      34:	079e                	sll	a5,a5,0x7
      36:	85aa                	mv	a1,a0
      38:	00002517          	auipc	a0,0x2
      3c:	0f850513          	add	a0,a0,248 # 2130 <history>
      40:	953e                	add	a0,a0,a5
      42:	6bf000ef          	jal	f00 <strcmp>
      46:	c929                	beqz	a0,98 <add_history+0x98>
  memmove(history[hist_count % HIST_SIZE], cmd, HIST_LEN);
      48:	41f4d79b          	sraw	a5,s1,0x1f
      4c:	01c7d79b          	srlw	a5,a5,0x1c
      50:	9cbd                	addw	s1,s1,a5
      52:	88bd                	and	s1,s1,15
      54:	9c9d                	subw	s1,s1,a5
      56:	049e                	sll	s1,s1,0x7
      58:	08000613          	li	a2,128
      5c:	85ca                	mv	a1,s2
      5e:	00002517          	auipc	a0,0x2
      62:	0d250513          	add	a0,a0,210 # 2130 <history>
      66:	9526                	add	a0,a0,s1
      68:	026010ef          	jal	108e <memmove>
  hist_count++;
      6c:	00002717          	auipc	a4,0x2
      70:	fa870713          	add	a4,a4,-88 # 2014 <hist_count>
      74:	431c                	lw	a5,0(a4)
      76:	2785                	addw	a5,a5,1
      78:	c31c                	sw	a5,0(a4)
  hist_index = hist_count;
      7a:	00002717          	auipc	a4,0x2
      7e:	f8f72b23          	sw	a5,-106(a4) # 2010 <hist_index>
  hist_pos = 0;

  fd = open(".sh_history", O_RDWR|O_CREATE);
      82:	20200593          	li	a1,514
      86:	00002517          	auipc	a0,0x2
      8a:	95a50513          	add	a0,a0,-1702 # 19e0 <malloc+0xfa>
      8e:	36a010ef          	jal	13f8 <open>
      92:	84aa                	mv	s1,a0
  if(fd >= 0){
      94:	00055863          	bgez	a0,a4 <add_history+0xa4>
    } else {
      write(fd, cmd, strlen(cmd));
      close(fd);
    }
  }
}
      98:	60a6                	ld	ra,72(sp)
      9a:	6406                	ld	s0,64(sp)
      9c:	74e2                	ld	s1,56(sp)
      9e:	7942                	ld	s2,48(sp)
      a0:	6161                	add	sp,sp,80
      a2:	8082                	ret
    if(fstat(fd, &st) == 0){
      a4:	fb840593          	add	a1,s0,-72
      a8:	368010ef          	jal	1410 <fstat>
      ac:	ed35                	bnez	a0,128 <add_history+0x128>
      ae:	f44e                	sd	s3,40(sp)
      b0:	f052                	sd	s4,32(sp)
      char *p = malloc(st.size + strlen(cmd) + 1);
      b2:	fc842983          	lw	s3,-56(s0)
      b6:	854a                	mv	a0,s2
      b8:	675000ef          	jal	f2c <strlen>
      bc:	2985                	addw	s3,s3,1
      be:	00a9853b          	addw	a0,s3,a0
      c2:	025010ef          	jal	18e6 <malloc>
      c6:	89aa                	mv	s3,a0
      int n = read(fd, p, st.size);
      c8:	fc842603          	lw	a2,-56(s0)
      cc:	85aa                	mv	a1,a0
      ce:	8526                	mv	a0,s1
      d0:	300010ef          	jal	13d0 <read>
      d4:	8a2a                	mv	s4,a0
      p[n] = 0;
      d6:	00a987b3          	add	a5,s3,a0
      da:	00078023          	sb	zero,0(a5)
      close(fd);
      de:	8526                	mv	a0,s1
      e0:	300010ef          	jal	13e0 <close>
      fd = open(".sh_history", O_WRONLY|O_CREATE|O_TRUNC);
      e4:	60100593          	li	a1,1537
      e8:	00002517          	auipc	a0,0x2
      ec:	8f850513          	add	a0,a0,-1800 # 19e0 <malloc+0xfa>
      f0:	308010ef          	jal	13f8 <open>
      f4:	84aa                	mv	s1,a0
      if(fd >= 0){
      f6:	00055863          	bgez	a0,106 <add_history+0x106>
      free(p);
      fa:	854e                	mv	a0,s3
      fc:	760010ef          	jal	185c <free>
     100:	79a2                	ld	s3,40(sp)
     102:	7a02                	ld	s4,32(sp)
     104:	bf51                	j	98 <add_history+0x98>
        write(fd, p, n);
     106:	8652                	mv	a2,s4
     108:	85ce                	mv	a1,s3
     10a:	2ce010ef          	jal	13d8 <write>
        write(fd, cmd, strlen(cmd));
     10e:	854a                	mv	a0,s2
     110:	61d000ef          	jal	f2c <strlen>
     114:	0005061b          	sext.w	a2,a0
     118:	85ca                	mv	a1,s2
     11a:	8526                	mv	a0,s1
     11c:	2bc010ef          	jal	13d8 <write>
        close(fd);
     120:	8526                	mv	a0,s1
     122:	2be010ef          	jal	13e0 <close>
     126:	bfd1                	j	fa <add_history+0xfa>
      write(fd, cmd, strlen(cmd));
     128:	854a                	mv	a0,s2
     12a:	603000ef          	jal	f2c <strlen>
     12e:	0005061b          	sext.w	a2,a0
     132:	85ca                	mv	a1,s2
     134:	8526                	mv	a0,s1
     136:	2a2010ef          	jal	13d8 <write>
      close(fd);
     13a:	8526                	mv	a0,s1
     13c:	2a4010ef          	jal	13e0 <close>
     140:	bfa1                	j	98 <add_history+0x98>
     142:	8082                	ret

0000000000000144 <getcmd_with_history>:

int
getcmd_with_history(char *buf, int nbuf)
{
     144:	7175                	add	sp,sp,-144
     146:	e506                	sd	ra,136(sp)
     148:	e122                	sd	s0,128(sp)
     14a:	fca6                	sd	s1,120(sp)
     14c:	f8ca                	sd	s2,112(sp)
     14e:	f4ce                	sd	s3,104(sp)
     150:	f0d2                	sd	s4,96(sp)
     152:	ecd6                	sd	s5,88(sp)
     154:	e8da                	sd	s6,80(sp)
     156:	e4de                	sd	s7,72(sp)
     158:	e0e2                	sd	s8,64(sp)
     15a:	fc66                	sd	s9,56(sp)
     15c:	f86a                	sd	s10,48(sp)
     15e:	f46e                	sd	s11,40(sp)
     160:	0900                	add	s0,sp,144
     162:	8baa                	mv	s7,a0
     164:	84ae                	mv	s1,a1
     166:	f6b43823          	sd	a1,-144(s0)
  char escape_buf[8];
  int escape_len = 0;
  int prev_mode;
  int ret;

  prev_mode = consolemode(1, 0);
     16a:	4581                	li	a1,0
     16c:	4505                	li	a0,1
     16e:	33a010ef          	jal	14a8 <consolemode>
     172:	f6a43c23          	sd	a0,-136(s0)

  write(2, "$ ", 2);
     176:	4609                	li	a2,2
     178:	00002597          	auipc	a1,0x2
     17c:	88058593          	add	a1,a1,-1920 # 19f8 <malloc+0x112>
     180:	4509                	li	a0,2
     182:	256010ef          	jal	13d8 <write>
  memset(buf, 0, nbuf);
     186:	00048d9b          	sext.w	s11,s1
     18a:	866e                	mv	a2,s11
     18c:	4581                	li	a1,0
     18e:	855e                	mv	a0,s7
     190:	5c7000ef          	jal	f56 <memset>
  i = strlen(buf);
     194:	855e                	mv	a0,s7
     196:	597000ef          	jal	f2c <strlen>
     19a:	0005091b          	sext.w	s2,a0
  int escape_len = 0;
     19e:	4a81                	li	s5,0
  int escape_state = 0;
     1a0:	4481                	li	s1,0

get_next_char:
  cc = read(0, &c, 1);
  if(cc < 1) goto done;

  if(c == '\x1b'){
     1a2:	4b6d                	li	s6,27
      escape_len = 0;
      goto get_next_char;
    }
  }

  if(c == '\n' || c == '\r'){
     1a4:	4ca9                	li	s9,10
     1a6:	4d35                	li	s10,13
        write(2, "\b \b", 3);
     1a8:	00002c17          	auipc	s8,0x2
     1ac:	858c0c13          	add	s8,s8,-1960 # 1a00 <malloc+0x11a>
     1b0:	a019                	j	1b6 <getcmd_with_history+0x72>
    escape_len = 0;
     1b2:	4a81                	li	s5,0
    escape_state = 1;
     1b4:	4485                	li	s1,1
  cc = read(0, &c, 1);
     1b6:	4605                	li	a2,1
     1b8:	f8f40593          	add	a1,s0,-113
     1bc:	4501                	li	a0,0
     1be:	212010ef          	jal	13d0 <read>
  if(cc < 1) goto done;
     1c2:	1aa05263          	blez	a0,366 <getcmd_with_history+0x222>
  if(c == '\x1b'){
     1c6:	f8f44783          	lbu	a5,-113(s0)
     1ca:	ff6784e3          	beq	a5,s6,1b2 <getcmd_with_history+0x6e>
  if(escape_state == 1){
     1ce:	4705                	li	a4,1
     1d0:	04e48563          	beq	s1,a4,21a <getcmd_with_history+0xd6>
  if(c == '\n' || c == '\r'){
     1d4:	17978a63          	beq	a5,s9,348 <getcmd_with_history+0x204>
     1d8:	17a78863          	beq	a5,s10,348 <getcmd_with_history+0x204>
    write(2, "\r\n", 2);
    ret = 0;
    goto done;
  }

  if(c == '\b' || c == 0x7f){
     1dc:	4721                	li	a4,8
     1de:	1ce78063          	beq	a5,a4,39e <getcmd_with_history+0x25a>
     1e2:	07f00713          	li	a4,127
     1e6:	1ae78c63          	beq	a5,a4,39e <getcmd_with_history+0x25a>
      write(2, "\b \b", 3);
    }
    goto get_next_char;
  }

  if(c == 0x15){
     1ea:	4755                	li	a4,21
     1ec:	1ce78563          	beq	a5,a4,3b6 <getcmd_with_history+0x272>
      write(2, "\b \b", 3);
    }
    goto get_next_char;
  }

  if(c < ' ' && c != '\t'){
     1f0:	477d                	li	a4,31
     1f2:	00f76563          	bltu	a4,a5,1fc <getcmd_with_history+0xb8>
     1f6:	4725                	li	a4,9
     1f8:	fae79fe3          	bne	a5,a4,1b6 <getcmd_with_history+0x72>
    goto get_next_char;
  }

  buf[i++] = c;
     1fc:	0019099b          	addw	s3,s2,1
     200:	995e                	add	s2,s2,s7
     202:	00f90023          	sb	a5,0(s2)
  write(2, &c, 1);
     206:	4605                	li	a2,1
     208:	f8f40593          	add	a1,s0,-113
     20c:	4509                	li	a0,2
     20e:	1ca010ef          	jal	13d8 <write>
  buf[i++] = c;
     212:	894e                	mv	s2,s3
  goto get_next_char;
     214:	b74d                	j	1b6 <getcmd_with_history+0x72>
    escape_buf[escape_len++] = c;
     216:	8ab6                	mv	s5,a3
     218:	bf79                	j	1b6 <getcmd_with_history+0x72>
     21a:	001a869b          	addw	a3,s5,1
     21e:	f90a8713          	add	a4,s5,-112
     222:	9722                	add	a4,a4,s0
     224:	fef70823          	sb	a5,-16(a4)
    if(c == '['){
     228:	05b00713          	li	a4,91
     22c:	fee785e3          	beq	a5,a4,216 <getcmd_with_history+0xd2>
    if(c == 'A' || c == 'B'){
     230:	fbf7871b          	addw	a4,a5,-65
     234:	0ff77713          	zext.b	a4,a4
     238:	4605                	li	a2,1
     23a:	04e67563          	bgeu	a2,a4,284 <getcmd_with_history+0x140>
      for(int j = 0; j < escape_len; j++){
     23e:	04d05063          	blez	a3,27e <getcmd_with_history+0x13a>
     242:	f8040493          	add	s1,s0,-128
     246:	012b89b3          	add	s3,s7,s2
     24a:	020a9a13          	sll	s4,s5,0x20
     24e:	020a5a13          	srl	s4,s4,0x20
     252:	f8140793          	add	a5,s0,-127
     256:	9a3e                	add	s4,s4,a5
        buf[i++] = escape_buf[j];
     258:	0004c783          	lbu	a5,0(s1)
     25c:	00f98023          	sb	a5,0(s3)
        write(2, &escape_buf[j], 1);
     260:	4605                	li	a2,1
     262:	85a6                	mv	a1,s1
     264:	4509                	li	a0,2
     266:	172010ef          	jal	13d8 <write>
      for(int j = 0; j < escape_len; j++){
     26a:	0485                	add	s1,s1,1
     26c:	0985                	add	s3,s3,1
     26e:	ff4495e3          	bne	s1,s4,258 <getcmd_with_history+0x114>
     272:	2905                	addw	s2,s2,1
     274:	0159093b          	addw	s2,s2,s5
      escape_len = 0;
     278:	4a81                	li	s5,0
      escape_state = 0;
     27a:	4481                	li	s1,0
     27c:	bf2d                	j	1b6 <getcmd_with_history+0x72>
      escape_len = 0;
     27e:	4a81                	li	s5,0
      escape_state = 0;
     280:	4481                	li	s1,0
     282:	bf15                	j	1b6 <getcmd_with_history+0x72>
      if(c == 'A'){
     284:	04100713          	li	a4,65
     288:	0ae78463          	beq	a5,a4,330 <getcmd_with_history+0x1ec>
        if(hist_index < hist_count) hist_index++;
     28c:	00002797          	auipc	a5,0x2
     290:	d847a783          	lw	a5,-636(a5) # 2010 <hist_index>
     294:	00002717          	auipc	a4,0x2
     298:	d8072703          	lw	a4,-640(a4) # 2014 <hist_count>
     29c:	00e7d763          	bge	a5,a4,2aa <getcmd_with_history+0x166>
     2a0:	2785                	addw	a5,a5,1
     2a2:	00002717          	auipc	a4,0x2
     2a6:	d6f72723          	sw	a5,-658(a4) # 2010 <hist_index>
      while(i > 0){
     2aa:	01205a63          	blez	s2,2be <getcmd_with_history+0x17a>
        write(2, "\b \b", 3);
     2ae:	460d                	li	a2,3
     2b0:	85e2                	mv	a1,s8
     2b2:	4509                	li	a0,2
     2b4:	124010ef          	jal	13d8 <write>
        i--;
     2b8:	397d                	addw	s2,s2,-1
      while(i > 0){
     2ba:	fe091ae3          	bnez	s2,2ae <getcmd_with_history+0x16a>
      memset(buf, 0, nbuf);
     2be:	866e                	mv	a2,s11
     2c0:	4581                	li	a1,0
     2c2:	855e                	mv	a0,s7
     2c4:	493000ef          	jal	f56 <memset>
      if(hist_index < hist_count){
     2c8:	00002797          	auipc	a5,0x2
     2cc:	d4878793          	add	a5,a5,-696 # 2010 <hist_index>
     2d0:	439c                	lw	a5,0(a5)
     2d2:	00002717          	auipc	a4,0x2
     2d6:	d4270713          	add	a4,a4,-702 # 2014 <hist_count>
     2da:	4318                	lw	a4,0(a4)
      escape_len = 0;
     2dc:	4a81                	li	s5,0
      escape_state = 0;
     2de:	4481                	li	s1,0
      if(hist_index < hist_count){
     2e0:	ece7dbe3          	bge	a5,a4,1b6 <getcmd_with_history+0x72>
        char *h = history[hist_index % HIST_SIZE];
     2e4:	41f7d71b          	sraw	a4,a5,0x1f
     2e8:	01c7571b          	srlw	a4,a4,0x1c
     2ec:	9fb9                	addw	a5,a5,a4
     2ee:	8bbd                	and	a5,a5,15
     2f0:	9f99                	subw	a5,a5,a4
     2f2:	079e                	sll	a5,a5,0x7
     2f4:	00002717          	auipc	a4,0x2
     2f8:	e3c70713          	add	a4,a4,-452 # 2130 <history>
     2fc:	00e784b3          	add	s1,a5,a4
        int hlen = strlen(h);
     300:	8526                	mv	a0,s1
     302:	42b000ef          	jal	f2c <strlen>
     306:	0005091b          	sext.w	s2,a0
        if(hlen > nbuf - 1) hlen = nbuf - 1;
     30a:	f7043783          	ld	a5,-144(s0)
     30e:	00f94463          	blt	s2,a5,316 <getcmd_with_history+0x1d2>
     312:	fff7891b          	addw	s2,a5,-1
        memmove(buf, h, hlen);
     316:	864a                	mv	a2,s2
     318:	85a6                	mv	a1,s1
     31a:	855e                	mv	a0,s7
     31c:	573000ef          	jal	108e <memmove>
        write(2, buf, i);
     320:	864a                	mv	a2,s2
     322:	85de                	mv	a1,s7
     324:	4509                	li	a0,2
     326:	0b2010ef          	jal	13d8 <write>
      escape_len = 0;
     32a:	4a81                	li	s5,0
      escape_state = 0;
     32c:	4481                	li	s1,0
     32e:	b561                	j	1b6 <getcmd_with_history+0x72>
        if(hist_index > 0) hist_index--;
     330:	00002797          	auipc	a5,0x2
     334:	ce07a783          	lw	a5,-800(a5) # 2010 <hist_index>
     338:	f6f059e3          	blez	a5,2aa <getcmd_with_history+0x166>
     33c:	37fd                	addw	a5,a5,-1
     33e:	00002717          	auipc	a4,0x2
     342:	ccf72923          	sw	a5,-814(a4) # 2010 <hist_index>
     346:	b795                	j	2aa <getcmd_with_history+0x166>
    buf[i++] = '\n';
     348:	0019049b          	addw	s1,s2,1
     34c:	995e                	add	s2,s2,s7
     34e:	47a9                	li	a5,10
     350:	00f90023          	sb	a5,0(s2)
    write(2, "\r\n", 2);
     354:	4609                	li	a2,2
     356:	00001597          	auipc	a1,0x1
     35a:	6b258593          	add	a1,a1,1714 # 1a08 <malloc+0x122>
     35e:	4509                	li	a0,2
     360:	078010ef          	jal	13d8 <write>
    buf[i++] = '\n';
     364:	8926                	mv	s2,s1

done:
  buf[i] = '\0';
     366:	9bca                	add	s7,s7,s2
     368:	000b8023          	sb	zero,0(s7)
  consolemode((prev_mode & 1) ? 1 : 0, (prev_mode & 2) ? 1 : 0);
     36c:	f7843783          	ld	a5,-136(s0)
     370:	4017d59b          	sraw	a1,a5,0x1
     374:	8985                	and	a1,a1,1
     376:	0017f513          	and	a0,a5,1
     37a:	12e010ef          	jal	14a8 <consolemode>
  return ret;
}
     37e:	4501                	li	a0,0
     380:	60aa                	ld	ra,136(sp)
     382:	640a                	ld	s0,128(sp)
     384:	74e6                	ld	s1,120(sp)
     386:	7946                	ld	s2,112(sp)
     388:	79a6                	ld	s3,104(sp)
     38a:	7a06                	ld	s4,96(sp)
     38c:	6ae6                	ld	s5,88(sp)
     38e:	6b46                	ld	s6,80(sp)
     390:	6ba6                	ld	s7,72(sp)
     392:	6c06                	ld	s8,64(sp)
     394:	7ce2                	ld	s9,56(sp)
     396:	7d42                	ld	s10,48(sp)
     398:	7da2                	ld	s11,40(sp)
     39a:	6149                	add	sp,sp,144
     39c:	8082                	ret
    if(i > 0){
     39e:	e1205ce3          	blez	s2,1b6 <getcmd_with_history+0x72>
      i--;
     3a2:	397d                	addw	s2,s2,-1
      write(2, "\b \b", 3);
     3a4:	460d                	li	a2,3
     3a6:	00001597          	auipc	a1,0x1
     3aa:	65a58593          	add	a1,a1,1626 # 1a00 <malloc+0x11a>
     3ae:	4509                	li	a0,2
     3b0:	028010ef          	jal	13d8 <write>
     3b4:	b509                	j	1b6 <getcmd_with_history+0x72>
    while(i > 0){
     3b6:	e12050e3          	blez	s2,1b6 <getcmd_with_history+0x72>
      write(2, "\b \b", 3);
     3ba:	00001497          	auipc	s1,0x1
     3be:	64648493          	add	s1,s1,1606 # 1a00 <malloc+0x11a>
      i--;
     3c2:	397d                	addw	s2,s2,-1
      write(2, "\b \b", 3);
     3c4:	460d                	li	a2,3
     3c6:	85a6                	mv	a1,s1
     3c8:	4509                	li	a0,2
     3ca:	00e010ef          	jal	13d8 <write>
    while(i > 0){
     3ce:	fe091ae3          	bnez	s2,3c2 <getcmd_with_history+0x27e>
     3d2:	84ca                	mv	s1,s2
     3d4:	b3cd                	j	1b6 <getcmd_with_history+0x72>

00000000000003d6 <getcmd>:

int
getcmd(char *buf, int nbuf)
{
     3d6:	1101                	add	sp,sp,-32
     3d8:	ec06                	sd	ra,24(sp)
     3da:	e822                	sd	s0,16(sp)
     3dc:	e426                	sd	s1,8(sp)
     3de:	e04a                	sd	s2,0(sp)
     3e0:	1000                	add	s0,sp,32
     3e2:	84aa                	mv	s1,a0
     3e4:	892e                	mv	s2,a1
  write(2, "$ ", 2);
     3e6:	4609                	li	a2,2
     3e8:	00001597          	auipc	a1,0x1
     3ec:	61058593          	add	a1,a1,1552 # 19f8 <malloc+0x112>
     3f0:	4509                	li	a0,2
     3f2:	7e7000ef          	jal	13d8 <write>
  memset(buf, 0, nbuf);
     3f6:	864a                	mv	a2,s2
     3f8:	4581                	li	a1,0
     3fa:	8526                	mv	a0,s1
     3fc:	35b000ef          	jal	f56 <memset>
  gets(buf, nbuf);
     400:	85ca                	mv	a1,s2
     402:	8526                	mv	a0,s1
     404:	399000ef          	jal	f9c <gets>
  if(buf[0] == 0)
     408:	0004c503          	lbu	a0,0(s1)
     40c:	00153513          	seqz	a0,a0
    return -1;
  return 0;
}
     410:	40a00533          	neg	a0,a0
     414:	60e2                	ld	ra,24(sp)
     416:	6442                	ld	s0,16(sp)
     418:	64a2                	ld	s1,8(sp)
     41a:	6902                	ld	s2,0(sp)
     41c:	6105                	add	sp,sp,32
     41e:	8082                	ret

0000000000000420 <print_history>:

void
print_history(void)
{
     420:	7139                	add	sp,sp,-64
     422:	fc06                	sd	ra,56(sp)
     424:	f822                	sd	s0,48(sp)
     426:	f426                	sd	s1,40(sp)
     428:	f04a                	sd	s2,32(sp)
     42a:	ec4e                	sd	s3,24(sp)
     42c:	e852                	sd	s4,16(sp)
     42e:	e456                	sd	s5,8(sp)
     430:	0080                	add	s0,sp,64
  int start = (hist_count >= HIST_SIZE) ? (hist_count - HIST_SIZE + 1) : 1;
     432:	00002797          	auipc	a5,0x2
     436:	be27a783          	lw	a5,-1054(a5) # 2014 <hist_count>
     43a:	893e                	mv	s2,a5
     43c:	2781                	sext.w	a5,a5
     43e:	4741                	li	a4,16
     440:	00e7d363          	bge	a5,a4,446 <print_history+0x26>
     444:	4941                	li	s2,16
  for(int i = 0; i < HIST_SIZE && (start + i) <= hist_count; i++){
     446:	ff19049b          	addw	s1,s2,-15
     44a:	2901                	sext.w	s2,s2
     44c:	00002a17          	auipc	s4,0x2
     450:	bc8a0a13          	add	s4,s4,-1080 # 2014 <hist_count>
    int idx = (start + i - 1) % HIST_SIZE;
    if(history[idx][0] != 0){
     454:	00002997          	auipc	s3,0x2
     458:	cdc98993          	add	s3,s3,-804 # 2130 <history>
      printf("%4d  %s", start + i, history[idx]);
     45c:	00001a97          	auipc	s5,0x1
     460:	5b4a8a93          	add	s5,s5,1460 # 1a10 <malloc+0x12a>
     464:	a031                	j	470 <print_history+0x50>
  for(int i = 0; i < HIST_SIZE && (start + i) <= hist_count; i++){
     466:	0014879b          	addw	a5,s1,1
     46a:	03248f63          	beq	s1,s2,4a8 <print_history+0x88>
     46e:	84be                	mv	s1,a5
     470:	0004859b          	sext.w	a1,s1
     474:	000a2783          	lw	a5,0(s4)
     478:	02b7c863          	blt	a5,a1,4a8 <print_history+0x88>
    int idx = (start + i - 1) % HIST_SIZE;
     47c:	fff4879b          	addw	a5,s1,-1
     480:	41f7d71b          	sraw	a4,a5,0x1f
     484:	01c7571b          	srlw	a4,a4,0x1c
     488:	00e7863b          	addw	a2,a5,a4
     48c:	8a3d                	and	a2,a2,15
     48e:	9e19                	subw	a2,a2,a4
    if(history[idx][0] != 0){
     490:	00761793          	sll	a5,a2,0x7
     494:	97ce                	add	a5,a5,s3
     496:	0007c783          	lbu	a5,0(a5)
     49a:	d7f1                	beqz	a5,466 <print_history+0x46>
      printf("%4d  %s", start + i, history[idx]);
     49c:	061e                	sll	a2,a2,0x7
     49e:	964e                	add	a2,a2,s3
     4a0:	8556                	mv	a0,s5
     4a2:	388010ef          	jal	182a <printf>
     4a6:	b7c1                	j	466 <print_history+0x46>
    }
  }
}
     4a8:	70e2                	ld	ra,56(sp)
     4aa:	7442                	ld	s0,48(sp)
     4ac:	74a2                	ld	s1,40(sp)
     4ae:	7902                	ld	s2,32(sp)
     4b0:	69e2                	ld	s3,24(sp)
     4b2:	6a42                	ld	s4,16(sp)
     4b4:	6aa2                	ld	s5,8(sp)
     4b6:	6121                	add	sp,sp,64
     4b8:	8082                	ret

00000000000004ba <cmd_is_history>:

int
cmd_is_history(char *buf)
{
     4ba:	1141                	add	sp,sp,-16
     4bc:	e422                	sd	s0,8(sp)
     4be:	0800                	add	s0,sp,16
  return (buf[0] == 'h' && buf[1] == 'i' && buf[2] == 's' && 
          buf[3] == 't' && buf[4] == 'o' && buf[5] == 'r' && 
          buf[6] == 'y' && (buf[7] == '\n' || buf[7] == '\0' || buf[7] == ' '));
     4c0:	00054683          	lbu	a3,0(a0)
     4c4:	06800713          	li	a4,104
     4c8:	00e68663          	beq	a3,a4,4d4 <cmd_is_history+0x1a>
     4cc:	4501                	li	a0,0
}
     4ce:	6422                	ld	s0,8(sp)
     4d0:	0141                	add	sp,sp,16
     4d2:	8082                	ret
     4d4:	87aa                	mv	a5,a0
  return (buf[0] == 'h' && buf[1] == 'i' && buf[2] == 's' && 
     4d6:	00154683          	lbu	a3,1(a0)
     4da:	06900713          	li	a4,105
          buf[6] == 'y' && (buf[7] == '\n' || buf[7] == '\0' || buf[7] == ' '));
     4de:	4501                	li	a0,0
  return (buf[0] == 'h' && buf[1] == 'i' && buf[2] == 's' && 
     4e0:	fee697e3          	bne	a3,a4,4ce <cmd_is_history+0x14>
     4e4:	0027c683          	lbu	a3,2(a5)
     4e8:	07300713          	li	a4,115
     4ec:	fee691e3          	bne	a3,a4,4ce <cmd_is_history+0x14>
     4f0:	0037c683          	lbu	a3,3(a5)
     4f4:	07400713          	li	a4,116
     4f8:	fce69be3          	bne	a3,a4,4ce <cmd_is_history+0x14>
          buf[3] == 't' && buf[4] == 'o' && buf[5] == 'r' && 
     4fc:	0047c683          	lbu	a3,4(a5)
     500:	06f00713          	li	a4,111
     504:	fce695e3          	bne	a3,a4,4ce <cmd_is_history+0x14>
     508:	0057c683          	lbu	a3,5(a5)
     50c:	07200713          	li	a4,114
     510:	fae69fe3          	bne	a3,a4,4ce <cmd_is_history+0x14>
     514:	0067c683          	lbu	a3,6(a5)
     518:	07900713          	li	a4,121
     51c:	fae699e3          	bne	a3,a4,4ce <cmd_is_history+0x14>
          buf[6] == 'y' && (buf[7] == '\n' || buf[7] == '\0' || buf[7] == ' '));
     520:	0077c703          	lbu	a4,7(a5)
     524:	02000793          	li	a5,32
     528:	00e7eb63          	bltu	a5,a4,53e <cmd_is_history+0x84>
     52c:	4785                	li	a5,1
     52e:	1782                	sll	a5,a5,0x20
     530:	40178793          	add	a5,a5,1025
     534:	00e7d7b3          	srl	a5,a5,a4
     538:	0017f513          	and	a0,a5,1
     53c:	bf49                	j	4ce <cmd_is_history+0x14>
     53e:	4501                	li	a0,0
     540:	b779                	j	4ce <cmd_is_history+0x14>

0000000000000542 <panic>:
  exit(0);
}

void
panic(char *s)
{
     542:	1141                	add	sp,sp,-16
     544:	e406                	sd	ra,8(sp)
     546:	e022                	sd	s0,0(sp)
     548:	0800                	add	s0,sp,16
     54a:	862a                	mv	a2,a0
  fprintf(2, "%s\n", s);
     54c:	00001597          	auipc	a1,0x1
     550:	4cc58593          	add	a1,a1,1228 # 1a18 <malloc+0x132>
     554:	4509                	li	a0,2
     556:	2aa010ef          	jal	1800 <fprintf>
  exit(1);
     55a:	4505                	li	a0,1
     55c:	65d000ef          	jal	13b8 <exit>

0000000000000560 <fork1>:
}

int
fork1(void)
{
     560:	1141                	add	sp,sp,-16
     562:	e406                	sd	ra,8(sp)
     564:	e022                	sd	s0,0(sp)
     566:	0800                	add	s0,sp,16
  int pid;

  pid = fork();
     568:	649000ef          	jal	13b0 <fork>
  if(pid == -1)
     56c:	57fd                	li	a5,-1
     56e:	00f50663          	beq	a0,a5,57a <fork1+0x1a>
    panic("fork");
  return pid;
}
     572:	60a2                	ld	ra,8(sp)
     574:	6402                	ld	s0,0(sp)
     576:	0141                	add	sp,sp,16
     578:	8082                	ret
    panic("fork");
     57a:	00001517          	auipc	a0,0x1
     57e:	4a650513          	add	a0,a0,1190 # 1a20 <malloc+0x13a>
     582:	fc1ff0ef          	jal	542 <panic>

0000000000000586 <runcmd>:
{
     586:	7179                	add	sp,sp,-48
     588:	f406                	sd	ra,40(sp)
     58a:	f022                	sd	s0,32(sp)
     58c:	1800                	add	s0,sp,48
  if(cmd == 0)
     58e:	c115                	beqz	a0,5b2 <runcmd+0x2c>
     590:	ec26                	sd	s1,24(sp)
     592:	84aa                	mv	s1,a0
  switch(cmd->type){
     594:	4118                	lw	a4,0(a0)
     596:	4795                	li	a5,5
     598:	02e7e163          	bltu	a5,a4,5ba <runcmd+0x34>
     59c:	00056783          	lwu	a5,0(a0)
     5a0:	078a                	sll	a5,a5,0x2
     5a2:	00001717          	auipc	a4,0x1
     5a6:	58670713          	add	a4,a4,1414 # 1b28 <malloc+0x242>
     5aa:	97ba                	add	a5,a5,a4
     5ac:	439c                	lw	a5,0(a5)
     5ae:	97ba                	add	a5,a5,a4
     5b0:	8782                	jr	a5
     5b2:	ec26                	sd	s1,24(sp)
    exit(1);
     5b4:	4505                	li	a0,1
     5b6:	603000ef          	jal	13b8 <exit>
    panic("runcmd");
     5ba:	00001517          	auipc	a0,0x1
     5be:	46e50513          	add	a0,a0,1134 # 1a28 <malloc+0x142>
     5c2:	f81ff0ef          	jal	542 <panic>
    if(ecmd->argv[0] == 0)
     5c6:	6508                	ld	a0,8(a0)
     5c8:	c105                	beqz	a0,5e8 <runcmd+0x62>
    exec(ecmd->argv[0], ecmd->argv);
     5ca:	00848593          	add	a1,s1,8
     5ce:	623000ef          	jal	13f0 <exec>
    fprintf(2, "exec %s failed\n", ecmd->argv[0]);
     5d2:	6490                	ld	a2,8(s1)
     5d4:	00001597          	auipc	a1,0x1
     5d8:	45c58593          	add	a1,a1,1116 # 1a30 <malloc+0x14a>
     5dc:	4509                	li	a0,2
     5de:	222010ef          	jal	1800 <fprintf>
  exit(0);
     5e2:	4501                	li	a0,0
     5e4:	5d5000ef          	jal	13b8 <exit>
      exit(1);
     5e8:	4505                	li	a0,1
     5ea:	5cf000ef          	jal	13b8 <exit>
    close(rcmd->fd);
     5ee:	5148                	lw	a0,36(a0)
     5f0:	5f1000ef          	jal	13e0 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     5f4:	508c                	lw	a1,32(s1)
     5f6:	6888                	ld	a0,16(s1)
     5f8:	601000ef          	jal	13f8 <open>
     5fc:	00054563          	bltz	a0,606 <runcmd+0x80>
    runcmd(rcmd->cmd);
     600:	6488                	ld	a0,8(s1)
     602:	f85ff0ef          	jal	586 <runcmd>
      fprintf(2, "open %s failed\n", rcmd->file);
     606:	6890                	ld	a2,16(s1)
     608:	00001597          	auipc	a1,0x1
     60c:	43858593          	add	a1,a1,1080 # 1a40 <malloc+0x15a>
     610:	4509                	li	a0,2
     612:	1ee010ef          	jal	1800 <fprintf>
      exit(1);
     616:	4505                	li	a0,1
     618:	5a1000ef          	jal	13b8 <exit>
    if(fork1() == 0)
     61c:	f45ff0ef          	jal	560 <fork1>
     620:	e501                	bnez	a0,628 <runcmd+0xa2>
      runcmd(lcmd->left);
     622:	6488                	ld	a0,8(s1)
     624:	f63ff0ef          	jal	586 <runcmd>
    wait(0);
     628:	4501                	li	a0,0
     62a:	597000ef          	jal	13c0 <wait>
    runcmd(lcmd->right);
     62e:	6888                	ld	a0,16(s1)
     630:	f57ff0ef          	jal	586 <runcmd>
    if(pipe(p) < 0)
     634:	fd840513          	add	a0,s0,-40
     638:	591000ef          	jal	13c8 <pipe>
     63c:	02054763          	bltz	a0,66a <runcmd+0xe4>
    if(fork1() == 0){
     640:	f21ff0ef          	jal	560 <fork1>
     644:	e90d                	bnez	a0,676 <runcmd+0xf0>
      close(1);
     646:	4505                	li	a0,1
     648:	599000ef          	jal	13e0 <close>
      dup(p[1]);
     64c:	fdc42503          	lw	a0,-36(s0)
     650:	5e1000ef          	jal	1430 <dup>
      close(p[0]);
     654:	fd842503          	lw	a0,-40(s0)
     658:	589000ef          	jal	13e0 <close>
      close(p[1]);
     65c:	fdc42503          	lw	a0,-36(s0)
     660:	581000ef          	jal	13e0 <close>
      runcmd(pcmd->left);
     664:	6488                	ld	a0,8(s1)
     666:	f21ff0ef          	jal	586 <runcmd>
      panic("pipe");
     66a:	00001517          	auipc	a0,0x1
     66e:	3e650513          	add	a0,a0,998 # 1a50 <malloc+0x16a>
     672:	ed1ff0ef          	jal	542 <panic>
    if(fork1() == 0){
     676:	eebff0ef          	jal	560 <fork1>
     67a:	e115                	bnez	a0,69e <runcmd+0x118>
      close(0);
     67c:	565000ef          	jal	13e0 <close>
      dup(p[0]);
     680:	fd842503          	lw	a0,-40(s0)
     684:	5ad000ef          	jal	1430 <dup>
      close(p[0]);
     688:	fd842503          	lw	a0,-40(s0)
     68c:	555000ef          	jal	13e0 <close>
      close(p[1]);
     690:	fdc42503          	lw	a0,-36(s0)
     694:	54d000ef          	jal	13e0 <close>
      runcmd(pcmd->right);
     698:	6888                	ld	a0,16(s1)
     69a:	eedff0ef          	jal	586 <runcmd>
    close(p[0]);
     69e:	fd842503          	lw	a0,-40(s0)
     6a2:	53f000ef          	jal	13e0 <close>
    close(p[1]);
     6a6:	fdc42503          	lw	a0,-36(s0)
     6aa:	537000ef          	jal	13e0 <close>
    wait(0);
     6ae:	4501                	li	a0,0
     6b0:	511000ef          	jal	13c0 <wait>
    wait(0);
     6b4:	4501                	li	a0,0
     6b6:	50b000ef          	jal	13c0 <wait>
    break;
     6ba:	b725                	j	5e2 <runcmd+0x5c>
    if(fork1() == 0)
     6bc:	ea5ff0ef          	jal	560 <fork1>
     6c0:	f20511e3          	bnez	a0,5e2 <runcmd+0x5c>
      runcmd(bcmd->cmd);
     6c4:	6488                	ld	a0,8(s1)
     6c6:	ec1ff0ef          	jal	586 <runcmd>

00000000000006ca <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     6ca:	7139                	add	sp,sp,-64
     6cc:	fc06                	sd	ra,56(sp)
     6ce:	f822                	sd	s0,48(sp)
     6d0:	f426                	sd	s1,40(sp)
     6d2:	f04a                	sd	s2,32(sp)
     6d4:	ec4e                	sd	s3,24(sp)
     6d6:	e852                	sd	s4,16(sp)
     6d8:	e456                	sd	s5,8(sp)
     6da:	e05a                	sd	s6,0(sp)
     6dc:	0080                	add	s0,sp,64
     6de:	8a2a                	mv	s4,a0
     6e0:	892e                	mv	s2,a1
     6e2:	8ab2                	mv	s5,a2
     6e4:	8b36                	mv	s6,a3
  char *s;
  int ret;

  s = *ps;
     6e6:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     6e8:	00002997          	auipc	s3,0x2
     6ec:	92098993          	add	s3,s3,-1760 # 2008 <whitespace>
     6f0:	00b4fc63          	bgeu	s1,a1,708 <gettoken+0x3e>
     6f4:	0004c583          	lbu	a1,0(s1)
     6f8:	854e                	mv	a0,s3
     6fa:	07f000ef          	jal	f78 <strchr>
     6fe:	c509                	beqz	a0,708 <gettoken+0x3e>
    s++;
     700:	0485                	add	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     702:	fe9919e3          	bne	s2,s1,6f4 <gettoken+0x2a>
     706:	84ca                	mv	s1,s2
  if(q)
     708:	000a8463          	beqz	s5,710 <gettoken+0x46>
    *q = s;
     70c:	009ab023          	sd	s1,0(s5)
  ret = *s;
     710:	0004c783          	lbu	a5,0(s1)
     714:	00078a9b          	sext.w	s5,a5
  switch(*s){
     718:	03c00713          	li	a4,60
     71c:	06f76463          	bltu	a4,a5,784 <gettoken+0xba>
     720:	03a00713          	li	a4,58
     724:	00f76e63          	bltu	a4,a5,740 <gettoken+0x76>
     728:	cf89                	beqz	a5,742 <gettoken+0x78>
     72a:	02600713          	li	a4,38
     72e:	00e78963          	beq	a5,a4,740 <gettoken+0x76>
     732:	fd87879b          	addw	a5,a5,-40
     736:	0ff7f793          	zext.b	a5,a5
     73a:	4705                	li	a4,1
     73c:	06f76b63          	bltu	a4,a5,7b2 <gettoken+0xe8>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     740:	0485                	add	s1,s1,1
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     742:	000b0463          	beqz	s6,74a <gettoken+0x80>
    *eq = s;
     746:	009b3023          	sd	s1,0(s6)

  while(s < es && strchr(whitespace, *s))
     74a:	00002997          	auipc	s3,0x2
     74e:	8be98993          	add	s3,s3,-1858 # 2008 <whitespace>
     752:	0124fc63          	bgeu	s1,s2,76a <gettoken+0xa0>
     756:	0004c583          	lbu	a1,0(s1)
     75a:	854e                	mv	a0,s3
     75c:	01d000ef          	jal	f78 <strchr>
     760:	c509                	beqz	a0,76a <gettoken+0xa0>
    s++;
     762:	0485                	add	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     764:	fe9919e3          	bne	s2,s1,756 <gettoken+0x8c>
     768:	84ca                	mv	s1,s2
  *ps = s;
     76a:	009a3023          	sd	s1,0(s4)
  return ret;
}
     76e:	8556                	mv	a0,s5
     770:	70e2                	ld	ra,56(sp)
     772:	7442                	ld	s0,48(sp)
     774:	74a2                	ld	s1,40(sp)
     776:	7902                	ld	s2,32(sp)
     778:	69e2                	ld	s3,24(sp)
     77a:	6a42                	ld	s4,16(sp)
     77c:	6aa2                	ld	s5,8(sp)
     77e:	6b02                	ld	s6,0(sp)
     780:	6121                	add	sp,sp,64
     782:	8082                	ret
  switch(*s){
     784:	03e00713          	li	a4,62
     788:	02e79163          	bne	a5,a4,7aa <gettoken+0xe0>
    s++;
     78c:	00148693          	add	a3,s1,1
    if(*s == '>'){
     790:	0014c703          	lbu	a4,1(s1)
     794:	03e00793          	li	a5,62
      s++;
     798:	0489                	add	s1,s1,2
      ret = '+';
     79a:	02b00a93          	li	s5,43
    if(*s == '>'){
     79e:	faf702e3          	beq	a4,a5,742 <gettoken+0x78>
    s++;
     7a2:	84b6                	mv	s1,a3
  ret = *s;
     7a4:	03e00a93          	li	s5,62
     7a8:	bf69                	j	742 <gettoken+0x78>
  switch(*s){
     7aa:	07c00713          	li	a4,124
     7ae:	f8e789e3          	beq	a5,a4,740 <gettoken+0x76>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     7b2:	00002997          	auipc	s3,0x2
     7b6:	85698993          	add	s3,s3,-1962 # 2008 <whitespace>
     7ba:	00002a97          	auipc	s5,0x2
     7be:	846a8a93          	add	s5,s5,-1978 # 2000 <symbols>
     7c2:	0324fd63          	bgeu	s1,s2,7fc <gettoken+0x132>
     7c6:	0004c583          	lbu	a1,0(s1)
     7ca:	854e                	mv	a0,s3
     7cc:	7ac000ef          	jal	f78 <strchr>
     7d0:	e11d                	bnez	a0,7f6 <gettoken+0x12c>
     7d2:	0004c583          	lbu	a1,0(s1)
     7d6:	8556                	mv	a0,s5
     7d8:	7a0000ef          	jal	f78 <strchr>
     7dc:	e911                	bnez	a0,7f0 <gettoken+0x126>
      s++;
     7de:	0485                	add	s1,s1,1
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     7e0:	fe9913e3          	bne	s2,s1,7c6 <gettoken+0xfc>
  if(eq)
     7e4:	84ca                	mv	s1,s2
    ret = 'a';
     7e6:	06100a93          	li	s5,97
  if(eq)
     7ea:	f40b1ee3          	bnez	s6,746 <gettoken+0x7c>
     7ee:	bfb5                	j	76a <gettoken+0xa0>
    ret = 'a';
     7f0:	06100a93          	li	s5,97
     7f4:	b7b9                	j	742 <gettoken+0x78>
     7f6:	06100a93          	li	s5,97
     7fa:	b7a1                	j	742 <gettoken+0x78>
     7fc:	06100a93          	li	s5,97
  if(eq)
     800:	f40b13e3          	bnez	s6,746 <gettoken+0x7c>
     804:	b79d                	j	76a <gettoken+0xa0>

0000000000000806 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     806:	7139                	add	sp,sp,-64
     808:	fc06                	sd	ra,56(sp)
     80a:	f822                	sd	s0,48(sp)
     80c:	f426                	sd	s1,40(sp)
     80e:	f04a                	sd	s2,32(sp)
     810:	ec4e                	sd	s3,24(sp)
     812:	e852                	sd	s4,16(sp)
     814:	e456                	sd	s5,8(sp)
     816:	0080                	add	s0,sp,64
     818:	8a2a                	mv	s4,a0
     81a:	892e                	mv	s2,a1
     81c:	8ab2                	mv	s5,a2
  char *s;

  s = *ps;
     81e:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     820:	00001997          	auipc	s3,0x1
     824:	7e898993          	add	s3,s3,2024 # 2008 <whitespace>
     828:	00b4fc63          	bgeu	s1,a1,840 <peek+0x3a>
     82c:	0004c583          	lbu	a1,0(s1)
     830:	854e                	mv	a0,s3
     832:	746000ef          	jal	f78 <strchr>
     836:	c509                	beqz	a0,840 <peek+0x3a>
    s++;
     838:	0485                	add	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     83a:	fe9919e3          	bne	s2,s1,82c <peek+0x26>
     83e:	84ca                	mv	s1,s2
  *ps = s;
     840:	009a3023          	sd	s1,0(s4)
  return *s && strchr(toks, *s);
     844:	0004c583          	lbu	a1,0(s1)
     848:	4501                	li	a0,0
     84a:	e991                	bnez	a1,85e <peek+0x58>
}
     84c:	70e2                	ld	ra,56(sp)
     84e:	7442                	ld	s0,48(sp)
     850:	74a2                	ld	s1,40(sp)
     852:	7902                	ld	s2,32(sp)
     854:	69e2                	ld	s3,24(sp)
     856:	6a42                	ld	s4,16(sp)
     858:	6aa2                	ld	s5,8(sp)
     85a:	6121                	add	sp,sp,64
     85c:	8082                	ret
  return *s && strchr(toks, *s);
     85e:	8556                	mv	a0,s5
     860:	718000ef          	jal	f78 <strchr>
     864:	00a03533          	snez	a0,a0
     868:	b7d5                	j	84c <peek+0x46>

000000000000086a <nulterminate>:
  return ret;
}

struct cmd*
nulterminate(struct cmd *cmd)
{
     86a:	1101                	add	sp,sp,-32
     86c:	ec06                	sd	ra,24(sp)
     86e:	e822                	sd	s0,16(sp)
     870:	e426                	sd	s1,8(sp)
     872:	1000                	add	s0,sp,32
     874:	84aa                	mv	s1,a0
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     876:	c131                	beqz	a0,8ba <nulterminate+0x50>
    return 0;

  switch(cmd->type){
     878:	4118                	lw	a4,0(a0)
     87a:	4795                	li	a5,5
     87c:	02e7ef63          	bltu	a5,a4,8ba <nulterminate+0x50>
     880:	00056783          	lwu	a5,0(a0)
     884:	078a                	sll	a5,a5,0x2
     886:	00001717          	auipc	a4,0x1
     88a:	2ba70713          	add	a4,a4,698 # 1b40 <malloc+0x25a>
     88e:	97ba                	add	a5,a5,a4
     890:	439c                	lw	a5,0(a5)
     892:	97ba                	add	a5,a5,a4
     894:	8782                	jr	a5
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     896:	651c                	ld	a5,8(a0)
     898:	c38d                	beqz	a5,8ba <nulterminate+0x50>
     89a:	01050793          	add	a5,a0,16
      *ecmd->eargv[i] = 0;
     89e:	67b8                	ld	a4,72(a5)
     8a0:	00070023          	sb	zero,0(a4)
    for(i=0; ecmd->argv[i]; i++)
     8a4:	07a1                	add	a5,a5,8
     8a6:	ff87b703          	ld	a4,-8(a5)
     8aa:	fb75                	bnez	a4,89e <nulterminate+0x34>
     8ac:	a039                	j	8ba <nulterminate+0x50>
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
     8ae:	6508                	ld	a0,8(a0)
     8b0:	fbbff0ef          	jal	86a <nulterminate>
    *rcmd->efile = 0;
     8b4:	6c9c                	ld	a5,24(s1)
     8b6:	00078023          	sb	zero,0(a5)
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     8ba:	8526                	mv	a0,s1
     8bc:	60e2                	ld	ra,24(sp)
     8be:	6442                	ld	s0,16(sp)
     8c0:	64a2                	ld	s1,8(sp)
     8c2:	6105                	add	sp,sp,32
     8c4:	8082                	ret
    nulterminate(pcmd->left);
     8c6:	6508                	ld	a0,8(a0)
     8c8:	fa3ff0ef          	jal	86a <nulterminate>
    nulterminate(pcmd->right);
     8cc:	6888                	ld	a0,16(s1)
     8ce:	f9dff0ef          	jal	86a <nulterminate>
    break;
     8d2:	b7e5                	j	8ba <nulterminate+0x50>
    nulterminate(lcmd->left);
     8d4:	6508                	ld	a0,8(a0)
     8d6:	f95ff0ef          	jal	86a <nulterminate>
    nulterminate(lcmd->right);
     8da:	6888                	ld	a0,16(s1)
     8dc:	f8fff0ef          	jal	86a <nulterminate>
    break;
     8e0:	bfe9                	j	8ba <nulterminate+0x50>
    nulterminate(bcmd->cmd);
     8e2:	6508                	ld	a0,8(a0)
     8e4:	f87ff0ef          	jal	86a <nulterminate>
    break;
     8e8:	bfc9                	j	8ba <nulterminate+0x50>

00000000000008ea <execcmd>:

struct cmd*
execcmd(void)
{
     8ea:	1101                	add	sp,sp,-32
     8ec:	ec06                	sd	ra,24(sp)
     8ee:	e822                	sd	s0,16(sp)
     8f0:	e426                	sd	s1,8(sp)
     8f2:	1000                	add	s0,sp,32
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     8f4:	0a800513          	li	a0,168
     8f8:	7ef000ef          	jal	18e6 <malloc>
     8fc:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     8fe:	0a800613          	li	a2,168
     902:	4581                	li	a1,0
     904:	652000ef          	jal	f56 <memset>
  cmd->type = EXEC;
     908:	4785                	li	a5,1
     90a:	c09c                	sw	a5,0(s1)
  return (struct cmd*)cmd;
}
     90c:	8526                	mv	a0,s1
     90e:	60e2                	ld	ra,24(sp)
     910:	6442                	ld	s0,16(sp)
     912:	64a2                	ld	s1,8(sp)
     914:	6105                	add	sp,sp,32
     916:	8082                	ret

0000000000000918 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     918:	7139                	add	sp,sp,-64
     91a:	fc06                	sd	ra,56(sp)
     91c:	f822                	sd	s0,48(sp)
     91e:	f426                	sd	s1,40(sp)
     920:	f04a                	sd	s2,32(sp)
     922:	ec4e                	sd	s3,24(sp)
     924:	e852                	sd	s4,16(sp)
     926:	e456                	sd	s5,8(sp)
     928:	e05a                	sd	s6,0(sp)
     92a:	0080                	add	s0,sp,64
     92c:	8b2a                	mv	s6,a0
     92e:	8aae                	mv	s5,a1
     930:	8a32                	mv	s4,a2
     932:	89b6                	mv	s3,a3
     934:	893a                	mv	s2,a4
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     936:	02800513          	li	a0,40
     93a:	7ad000ef          	jal	18e6 <malloc>
     93e:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     940:	02800613          	li	a2,40
     944:	4581                	li	a1,0
     946:	610000ef          	jal	f56 <memset>
  cmd->type = REDIR;
     94a:	4789                	li	a5,2
     94c:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     94e:	0164b423          	sd	s6,8(s1)
  cmd->file = file;
     952:	0154b823          	sd	s5,16(s1)
  cmd->efile = efile;
     956:	0144bc23          	sd	s4,24(s1)
  cmd->mode = mode;
     95a:	0334a023          	sw	s3,32(s1)
  cmd->fd = fd;
     95e:	0324a223          	sw	s2,36(s1)
  return (struct cmd*)cmd;
}
     962:	8526                	mv	a0,s1
     964:	70e2                	ld	ra,56(sp)
     966:	7442                	ld	s0,48(sp)
     968:	74a2                	ld	s1,40(sp)
     96a:	7902                	ld	s2,32(sp)
     96c:	69e2                	ld	s3,24(sp)
     96e:	6a42                	ld	s4,16(sp)
     970:	6aa2                	ld	s5,8(sp)
     972:	6b02                	ld	s6,0(sp)
     974:	6121                	add	sp,sp,64
     976:	8082                	ret

0000000000000978 <parseredirs>:
{
     978:	711d                	add	sp,sp,-96
     97a:	ec86                	sd	ra,88(sp)
     97c:	e8a2                	sd	s0,80(sp)
     97e:	e4a6                	sd	s1,72(sp)
     980:	e0ca                	sd	s2,64(sp)
     982:	fc4e                	sd	s3,56(sp)
     984:	f852                	sd	s4,48(sp)
     986:	f456                	sd	s5,40(sp)
     988:	f05a                	sd	s6,32(sp)
     98a:	ec5e                	sd	s7,24(sp)
     98c:	1080                	add	s0,sp,96
     98e:	8a2a                	mv	s4,a0
     990:	89ae                	mv	s3,a1
     992:	8932                	mv	s2,a2
  while(peek(ps, es, "<>")){
     994:	00001a97          	auipc	s5,0x1
     998:	0e4a8a93          	add	s5,s5,228 # 1a78 <malloc+0x192>
    if(gettoken(ps, es, &q, &eq) != 'a')
     99c:	06100b13          	li	s6,97
    switch(tok){
     9a0:	03c00b93          	li	s7,60
  while(peek(ps, es, "<>")){
     9a4:	a00d                	j	9c6 <parseredirs+0x4e>
      panic("missing file for redirection");
     9a6:	00001517          	auipc	a0,0x1
     9aa:	0b250513          	add	a0,a0,178 # 1a58 <malloc+0x172>
     9ae:	b95ff0ef          	jal	542 <panic>
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     9b2:	4701                	li	a4,0
     9b4:	4681                	li	a3,0
     9b6:	fa043603          	ld	a2,-96(s0)
     9ba:	fa843583          	ld	a1,-88(s0)
     9be:	8552                	mv	a0,s4
     9c0:	f59ff0ef          	jal	918 <redircmd>
     9c4:	8a2a                	mv	s4,a0
  while(peek(ps, es, "<>")){
     9c6:	8656                	mv	a2,s5
     9c8:	85ca                	mv	a1,s2
     9ca:	854e                	mv	a0,s3
     9cc:	e3bff0ef          	jal	806 <peek>
     9d0:	c525                	beqz	a0,a38 <parseredirs+0xc0>
    tok = gettoken(ps, es, 0, 0);
     9d2:	4681                	li	a3,0
     9d4:	4601                	li	a2,0
     9d6:	85ca                	mv	a1,s2
     9d8:	854e                	mv	a0,s3
     9da:	cf1ff0ef          	jal	6ca <gettoken>
     9de:	84aa                	mv	s1,a0
    if(gettoken(ps, es, &q, &eq) != 'a')
     9e0:	fa040693          	add	a3,s0,-96
     9e4:	fa840613          	add	a2,s0,-88
     9e8:	85ca                	mv	a1,s2
     9ea:	854e                	mv	a0,s3
     9ec:	cdfff0ef          	jal	6ca <gettoken>
     9f0:	fb651be3          	bne	a0,s6,9a6 <parseredirs+0x2e>
    switch(tok){
     9f4:	fb748fe3          	beq	s1,s7,9b2 <parseredirs+0x3a>
     9f8:	03e00793          	li	a5,62
     9fc:	02f48263          	beq	s1,a5,a20 <parseredirs+0xa8>
     a00:	02b00793          	li	a5,43
     a04:	fcf491e3          	bne	s1,a5,9c6 <parseredirs+0x4e>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     a08:	4705                	li	a4,1
     a0a:	20100693          	li	a3,513
     a0e:	fa043603          	ld	a2,-96(s0)
     a12:	fa843583          	ld	a1,-88(s0)
     a16:	8552                	mv	a0,s4
     a18:	f01ff0ef          	jal	918 <redircmd>
     a1c:	8a2a                	mv	s4,a0
      break;
     a1e:	b765                	j	9c6 <parseredirs+0x4e>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
     a20:	4705                	li	a4,1
     a22:	60100693          	li	a3,1537
     a26:	fa043603          	ld	a2,-96(s0)
     a2a:	fa843583          	ld	a1,-88(s0)
     a2e:	8552                	mv	a0,s4
     a30:	ee9ff0ef          	jal	918 <redircmd>
     a34:	8a2a                	mv	s4,a0
      break;
     a36:	bf41                	j	9c6 <parseredirs+0x4e>
}
     a38:	8552                	mv	a0,s4
     a3a:	60e6                	ld	ra,88(sp)
     a3c:	6446                	ld	s0,80(sp)
     a3e:	64a6                	ld	s1,72(sp)
     a40:	6906                	ld	s2,64(sp)
     a42:	79e2                	ld	s3,56(sp)
     a44:	7a42                	ld	s4,48(sp)
     a46:	7aa2                	ld	s5,40(sp)
     a48:	7b02                	ld	s6,32(sp)
     a4a:	6be2                	ld	s7,24(sp)
     a4c:	6125                	add	sp,sp,96
     a4e:	8082                	ret

0000000000000a50 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     a50:	7179                	add	sp,sp,-48
     a52:	f406                	sd	ra,40(sp)
     a54:	f022                	sd	s0,32(sp)
     a56:	ec26                	sd	s1,24(sp)
     a58:	e84a                	sd	s2,16(sp)
     a5a:	e44e                	sd	s3,8(sp)
     a5c:	1800                	add	s0,sp,48
     a5e:	89aa                	mv	s3,a0
     a60:	892e                	mv	s2,a1
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     a62:	4561                	li	a0,24
     a64:	683000ef          	jal	18e6 <malloc>
     a68:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     a6a:	4661                	li	a2,24
     a6c:	4581                	li	a1,0
     a6e:	4e8000ef          	jal	f56 <memset>
  cmd->type = PIPE;
     a72:	478d                	li	a5,3
     a74:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     a76:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     a7a:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     a7e:	8526                	mv	a0,s1
     a80:	70a2                	ld	ra,40(sp)
     a82:	7402                	ld	s0,32(sp)
     a84:	64e2                	ld	s1,24(sp)
     a86:	6942                	ld	s2,16(sp)
     a88:	69a2                	ld	s3,8(sp)
     a8a:	6145                	add	sp,sp,48
     a8c:	8082                	ret

0000000000000a8e <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     a8e:	7179                	add	sp,sp,-48
     a90:	f406                	sd	ra,40(sp)
     a92:	f022                	sd	s0,32(sp)
     a94:	ec26                	sd	s1,24(sp)
     a96:	e84a                	sd	s2,16(sp)
     a98:	e44e                	sd	s3,8(sp)
     a9a:	1800                	add	s0,sp,48
     a9c:	89aa                	mv	s3,a0
     a9e:	892e                	mv	s2,a1
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     aa0:	4561                	li	a0,24
     aa2:	645000ef          	jal	18e6 <malloc>
     aa6:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     aa8:	4661                	li	a2,24
     aaa:	4581                	li	a1,0
     aac:	4aa000ef          	jal	f56 <memset>
  cmd->type = LIST;
     ab0:	4791                	li	a5,4
     ab2:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     ab4:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     ab8:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     abc:	8526                	mv	a0,s1
     abe:	70a2                	ld	ra,40(sp)
     ac0:	7402                	ld	s0,32(sp)
     ac2:	64e2                	ld	s1,24(sp)
     ac4:	6942                	ld	s2,16(sp)
     ac6:	69a2                	ld	s3,8(sp)
     ac8:	6145                	add	sp,sp,48
     aca:	8082                	ret

0000000000000acc <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     acc:	1101                	add	sp,sp,-32
     ace:	ec06                	sd	ra,24(sp)
     ad0:	e822                	sd	s0,16(sp)
     ad2:	e426                	sd	s1,8(sp)
     ad4:	e04a                	sd	s2,0(sp)
     ad6:	1000                	add	s0,sp,32
     ad8:	892a                	mv	s2,a0
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     ada:	4541                	li	a0,16
     adc:	60b000ef          	jal	18e6 <malloc>
     ae0:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     ae2:	4641                	li	a2,16
     ae4:	4581                	li	a1,0
     ae6:	470000ef          	jal	f56 <memset>
  cmd->type = BACK;
     aea:	4795                	li	a5,5
     aec:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     aee:	0124b423          	sd	s2,8(s1)
  return (struct cmd*)cmd;
}
     af2:	8526                	mv	a0,s1
     af4:	60e2                	ld	ra,24(sp)
     af6:	6442                	ld	s0,16(sp)
     af8:	64a2                	ld	s1,8(sp)
     afa:	6902                	ld	s2,0(sp)
     afc:	6105                	add	sp,sp,32
     afe:	8082                	ret

0000000000000b00 <parseline>:
{
     b00:	7179                	add	sp,sp,-48
     b02:	f406                	sd	ra,40(sp)
     b04:	f022                	sd	s0,32(sp)
     b06:	ec26                	sd	s1,24(sp)
     b08:	e84a                	sd	s2,16(sp)
     b0a:	e44e                	sd	s3,8(sp)
     b0c:	e052                	sd	s4,0(sp)
     b0e:	1800                	add	s0,sp,48
     b10:	892a                	mv	s2,a0
     b12:	89ae                	mv	s3,a1
  cmd = parsepipe(ps, es);
     b14:	364000ef          	jal	e78 <parsepipe>
     b18:	84aa                	mv	s1,a0
  while(peek(ps, es, "&")){
     b1a:	00001a17          	auipc	s4,0x1
     b1e:	f66a0a13          	add	s4,s4,-154 # 1a80 <malloc+0x19a>
     b22:	a819                	j	b38 <parseline+0x38>
    gettoken(ps, es, 0, 0);
     b24:	4681                	li	a3,0
     b26:	4601                	li	a2,0
     b28:	85ce                	mv	a1,s3
     b2a:	854a                	mv	a0,s2
     b2c:	b9fff0ef          	jal	6ca <gettoken>
    cmd = backcmd(cmd);
     b30:	8526                	mv	a0,s1
     b32:	f9bff0ef          	jal	acc <backcmd>
     b36:	84aa                	mv	s1,a0
  while(peek(ps, es, "&")){
     b38:	8652                	mv	a2,s4
     b3a:	85ce                	mv	a1,s3
     b3c:	854a                	mv	a0,s2
     b3e:	cc9ff0ef          	jal	806 <peek>
     b42:	f16d                	bnez	a0,b24 <parseline+0x24>
  if(peek(ps, es, ";")){
     b44:	00001617          	auipc	a2,0x1
     b48:	f4460613          	add	a2,a2,-188 # 1a88 <malloc+0x1a2>
     b4c:	85ce                	mv	a1,s3
     b4e:	854a                	mv	a0,s2
     b50:	cb7ff0ef          	jal	806 <peek>
     b54:	e911                	bnez	a0,b68 <parseline+0x68>
}
     b56:	8526                	mv	a0,s1
     b58:	70a2                	ld	ra,40(sp)
     b5a:	7402                	ld	s0,32(sp)
     b5c:	64e2                	ld	s1,24(sp)
     b5e:	6942                	ld	s2,16(sp)
     b60:	69a2                	ld	s3,8(sp)
     b62:	6a02                	ld	s4,0(sp)
     b64:	6145                	add	sp,sp,48
     b66:	8082                	ret
    gettoken(ps, es, 0, 0);
     b68:	4681                	li	a3,0
     b6a:	4601                	li	a2,0
     b6c:	85ce                	mv	a1,s3
     b6e:	854a                	mv	a0,s2
     b70:	b5bff0ef          	jal	6ca <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     b74:	85ce                	mv	a1,s3
     b76:	854a                	mv	a0,s2
     b78:	f89ff0ef          	jal	b00 <parseline>
     b7c:	85aa                	mv	a1,a0
     b7e:	8526                	mv	a0,s1
     b80:	f0fff0ef          	jal	a8e <listcmd>
     b84:	84aa                	mv	s1,a0
  return cmd;
     b86:	bfc1                	j	b56 <parseline+0x56>

0000000000000b88 <parsecmd>:
{
     b88:	7179                	add	sp,sp,-48
     b8a:	f406                	sd	ra,40(sp)
     b8c:	f022                	sd	s0,32(sp)
     b8e:	ec26                	sd	s1,24(sp)
     b90:	e84a                	sd	s2,16(sp)
     b92:	1800                	add	s0,sp,48
     b94:	fca43c23          	sd	a0,-40(s0)
  es = s + strlen(s);
     b98:	84aa                	mv	s1,a0
     b9a:	392000ef          	jal	f2c <strlen>
     b9e:	1502                	sll	a0,a0,0x20
     ba0:	9101                	srl	a0,a0,0x20
     ba2:	94aa                	add	s1,s1,a0
  cmd = parseline(&s, es);
     ba4:	85a6                	mv	a1,s1
     ba6:	fd840513          	add	a0,s0,-40
     baa:	f57ff0ef          	jal	b00 <parseline>
     bae:	892a                	mv	s2,a0
  peek(&s, es, "");
     bb0:	00001617          	auipc	a2,0x1
     bb4:	e4060613          	add	a2,a2,-448 # 19f0 <malloc+0x10a>
     bb8:	85a6                	mv	a1,s1
     bba:	fd840513          	add	a0,s0,-40
     bbe:	c49ff0ef          	jal	806 <peek>
  if(s != es){
     bc2:	fd843603          	ld	a2,-40(s0)
     bc6:	00961c63          	bne	a2,s1,bde <parsecmd+0x56>
  nulterminate(cmd);
     bca:	854a                	mv	a0,s2
     bcc:	c9fff0ef          	jal	86a <nulterminate>
}
     bd0:	854a                	mv	a0,s2
     bd2:	70a2                	ld	ra,40(sp)
     bd4:	7402                	ld	s0,32(sp)
     bd6:	64e2                	ld	s1,24(sp)
     bd8:	6942                	ld	s2,16(sp)
     bda:	6145                	add	sp,sp,48
     bdc:	8082                	ret
    fprintf(2, "leftovers: %s\n", s);
     bde:	00001597          	auipc	a1,0x1
     be2:	eb258593          	add	a1,a1,-334 # 1a90 <malloc+0x1aa>
     be6:	4509                	li	a0,2
     be8:	419000ef          	jal	1800 <fprintf>
    panic("syntax");
     bec:	00001517          	auipc	a0,0x1
     bf0:	eb450513          	add	a0,a0,-332 # 1aa0 <malloc+0x1ba>
     bf4:	94fff0ef          	jal	542 <panic>

0000000000000bf8 <main>:
{
     bf8:	715d                	add	sp,sp,-80
     bfa:	e486                	sd	ra,72(sp)
     bfc:	e0a2                	sd	s0,64(sp)
     bfe:	fc26                	sd	s1,56(sp)
     c00:	f84a                	sd	s2,48(sp)
     c02:	f44e                	sd	s3,40(sp)
     c04:	f052                	sd	s4,32(sp)
     c06:	ec56                	sd	s5,24(sp)
     c08:	0880                	add	s0,sp,80
  while((fd = open("console", O_RDWR)) >= 0){
     c0a:	00001497          	auipc	s1,0x1
     c0e:	e9e48493          	add	s1,s1,-354 # 1aa8 <malloc+0x1c2>
     c12:	4589                	li	a1,2
     c14:	8526                	mv	a0,s1
     c16:	7e2000ef          	jal	13f8 <open>
     c1a:	00054763          	bltz	a0,c28 <main+0x30>
    if(fd >= 3){
     c1e:	4789                	li	a5,2
     c20:	fea7d9e3          	bge	a5,a0,c12 <main+0x1a>
      close(fd);
     c24:	7bc000ef          	jal	13e0 <close>
  while(getcmd_with_history(buf, sizeof(buf)) >= 0){
     c28:	00001497          	auipc	s1,0x1
     c2c:	40848493          	add	s1,s1,1032 # 2030 <buf.0>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     c30:	06300913          	li	s2,99
     c34:	06400993          	li	s3,100
      char *histargv[] = { "history", 0 };
     c38:	00001a17          	auipc	s4,0x1
     c3c:	e78a0a13          	add	s4,s4,-392 # 1ab0 <malloc+0x1ca>
     c40:	a081                	j	c80 <main+0x88>
     c42:	fb443823          	sd	s4,-80(s0)
     c46:	fa043c23          	sd	zero,-72(s0)
      if(fork1() == 0){
     c4a:	917ff0ef          	jal	560 <fork1>
     c4e:	ed01                	bnez	a0,c66 <main+0x6e>
        exec("history", histargv);
     c50:	fb040593          	add	a1,s0,-80
     c54:	00001517          	auipc	a0,0x1
     c58:	e5c50513          	add	a0,a0,-420 # 1ab0 <malloc+0x1ca>
     c5c:	794000ef          	jal	13f0 <exec>
        exit(1);
     c60:	4505                	li	a0,1
     c62:	756000ef          	jal	13b8 <exit>
      wait(0);
     c66:	4501                	li	a0,0
     c68:	758000ef          	jal	13c0 <wait>
      continue;
     c6c:	a811                	j	c80 <main+0x88>
    add_history(buf);
     c6e:	8526                	mv	a0,s1
     c70:	b90ff0ef          	jal	0 <add_history>
    if(fork1() == 0)
     c74:	8edff0ef          	jal	560 <fork1>
     c78:	c149                	beqz	a0,cfa <main+0x102>
    wait(0);
     c7a:	4501                	li	a0,0
     c7c:	744000ef          	jal	13c0 <wait>
  while(getcmd_with_history(buf, sizeof(buf)) >= 0){
     c80:	10000593          	li	a1,256
     c84:	8526                	mv	a0,s1
     c86:	cbeff0ef          	jal	144 <getcmd_with_history>
     c8a:	08054063          	bltz	a0,d0a <main+0x112>
    if(cmd_is_history(buf)){
     c8e:	8526                	mv	a0,s1
     c90:	82bff0ef          	jal	4ba <cmd_is_history>
     c94:	f55d                	bnez	a0,c42 <main+0x4a>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     c96:	0004c783          	lbu	a5,0(s1)
     c9a:	fd279ae3          	bne	a5,s2,c6e <main+0x76>
     c9e:	0014c783          	lbu	a5,1(s1)
     ca2:	fd3796e3          	bne	a5,s3,c6e <main+0x76>
     ca6:	00001717          	auipc	a4,0x1
     caa:	38c74703          	lbu	a4,908(a4) # 2032 <buf.0+0x2>
     cae:	02000793          	li	a5,32
     cb2:	faf71ee3          	bne	a4,a5,c6e <main+0x76>
      buf[strlen(buf)-1] = 0;
     cb6:	00001a97          	auipc	s5,0x1
     cba:	37aa8a93          	add	s5,s5,890 # 2030 <buf.0>
     cbe:	8556                	mv	a0,s5
     cc0:	26c000ef          	jal	f2c <strlen>
     cc4:	fff5079b          	addw	a5,a0,-1
     cc8:	1782                	sll	a5,a5,0x20
     cca:	9381                	srl	a5,a5,0x20
     ccc:	9abe                	add	s5,s5,a5
     cce:	000a8023          	sb	zero,0(s5)
      if(chdir(buf+3) < 0)
     cd2:	00001517          	auipc	a0,0x1
     cd6:	36150513          	add	a0,a0,865 # 2033 <buf.0+0x3>
     cda:	74e000ef          	jal	1428 <chdir>
     cde:	fa0551e3          	bgez	a0,c80 <main+0x88>
        fprintf(2, "cannot cd %s\n", buf+3);
     ce2:	00001617          	auipc	a2,0x1
     ce6:	35160613          	add	a2,a2,849 # 2033 <buf.0+0x3>
     cea:	00001597          	auipc	a1,0x1
     cee:	dce58593          	add	a1,a1,-562 # 1ab8 <malloc+0x1d2>
     cf2:	4509                	li	a0,2
     cf4:	30d000ef          	jal	1800 <fprintf>
     cf8:	b761                	j	c80 <main+0x88>
      runcmd(parsecmd(buf));
     cfa:	00001517          	auipc	a0,0x1
     cfe:	33650513          	add	a0,a0,822 # 2030 <buf.0>
     d02:	e87ff0ef          	jal	b88 <parsecmd>
     d06:	881ff0ef          	jal	586 <runcmd>
  exit(0);
     d0a:	4501                	li	a0,0
     d0c:	6ac000ef          	jal	13b8 <exit>

0000000000000d10 <parseblock>:
{
     d10:	7179                	add	sp,sp,-48
     d12:	f406                	sd	ra,40(sp)
     d14:	f022                	sd	s0,32(sp)
     d16:	ec26                	sd	s1,24(sp)
     d18:	e84a                	sd	s2,16(sp)
     d1a:	e44e                	sd	s3,8(sp)
     d1c:	1800                	add	s0,sp,48
     d1e:	84aa                	mv	s1,a0
     d20:	892e                	mv	s2,a1
  if(!peek(ps, es, "("))
     d22:	00001617          	auipc	a2,0x1
     d26:	da660613          	add	a2,a2,-602 # 1ac8 <malloc+0x1e2>
     d2a:	addff0ef          	jal	806 <peek>
     d2e:	c539                	beqz	a0,d7c <parseblock+0x6c>
  gettoken(ps, es, 0, 0);
     d30:	4681                	li	a3,0
     d32:	4601                	li	a2,0
     d34:	85ca                	mv	a1,s2
     d36:	8526                	mv	a0,s1
     d38:	993ff0ef          	jal	6ca <gettoken>
  cmd = parseline(ps, es);
     d3c:	85ca                	mv	a1,s2
     d3e:	8526                	mv	a0,s1
     d40:	dc1ff0ef          	jal	b00 <parseline>
     d44:	89aa                	mv	s3,a0
  if(!peek(ps, es, ")"))
     d46:	00001617          	auipc	a2,0x1
     d4a:	d9a60613          	add	a2,a2,-614 # 1ae0 <malloc+0x1fa>
     d4e:	85ca                	mv	a1,s2
     d50:	8526                	mv	a0,s1
     d52:	ab5ff0ef          	jal	806 <peek>
     d56:	c90d                	beqz	a0,d88 <parseblock+0x78>
  gettoken(ps, es, 0, 0);
     d58:	4681                	li	a3,0
     d5a:	4601                	li	a2,0
     d5c:	85ca                	mv	a1,s2
     d5e:	8526                	mv	a0,s1
     d60:	96bff0ef          	jal	6ca <gettoken>
  cmd = parseredirs(cmd, ps, es);
     d64:	864a                	mv	a2,s2
     d66:	85a6                	mv	a1,s1
     d68:	854e                	mv	a0,s3
     d6a:	c0fff0ef          	jal	978 <parseredirs>
}
     d6e:	70a2                	ld	ra,40(sp)
     d70:	7402                	ld	s0,32(sp)
     d72:	64e2                	ld	s1,24(sp)
     d74:	6942                	ld	s2,16(sp)
     d76:	69a2                	ld	s3,8(sp)
     d78:	6145                	add	sp,sp,48
     d7a:	8082                	ret
    panic("parseblock");
     d7c:	00001517          	auipc	a0,0x1
     d80:	d5450513          	add	a0,a0,-684 # 1ad0 <malloc+0x1ea>
     d84:	fbeff0ef          	jal	542 <panic>
    panic("syntax - missing )");
     d88:	00001517          	auipc	a0,0x1
     d8c:	d6050513          	add	a0,a0,-672 # 1ae8 <malloc+0x202>
     d90:	fb2ff0ef          	jal	542 <panic>

0000000000000d94 <parseexec>:
{
     d94:	7159                	add	sp,sp,-112
     d96:	f486                	sd	ra,104(sp)
     d98:	f0a2                	sd	s0,96(sp)
     d9a:	eca6                	sd	s1,88(sp)
     d9c:	e0d2                	sd	s4,64(sp)
     d9e:	fc56                	sd	s5,56(sp)
     da0:	1880                	add	s0,sp,112
     da2:	8a2a                	mv	s4,a0
     da4:	8aae                	mv	s5,a1
  if(peek(ps, es, "("))
     da6:	00001617          	auipc	a2,0x1
     daa:	d2260613          	add	a2,a2,-734 # 1ac8 <malloc+0x1e2>
     dae:	a59ff0ef          	jal	806 <peek>
     db2:	e915                	bnez	a0,de6 <parseexec+0x52>
     db4:	e8ca                	sd	s2,80(sp)
     db6:	e4ce                	sd	s3,72(sp)
     db8:	f85a                	sd	s6,48(sp)
     dba:	f45e                	sd	s7,40(sp)
     dbc:	f062                	sd	s8,32(sp)
     dbe:	ec66                	sd	s9,24(sp)
     dc0:	89aa                	mv	s3,a0
  ret = execcmd();
     dc2:	b29ff0ef          	jal	8ea <execcmd>
     dc6:	8c2a                	mv	s8,a0
  ret = parseredirs(ret, ps, es);
     dc8:	8656                	mv	a2,s5
     dca:	85d2                	mv	a1,s4
     dcc:	badff0ef          	jal	978 <parseredirs>
     dd0:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
     dd2:	008c0913          	add	s2,s8,8
     dd6:	00001b17          	auipc	s6,0x1
     dda:	d3ab0b13          	add	s6,s6,-710 # 1b10 <malloc+0x22a>
    if(tok != 'a')
     dde:	06100c93          	li	s9,97
    if(argc >= MAXARGS)
     de2:	4ba9                	li	s7,10
  while(!peek(ps, es, "|)&;")){
     de4:	a815                	j	e18 <parseexec+0x84>
    return parseblock(ps, es);
     de6:	85d6                	mv	a1,s5
     de8:	8552                	mv	a0,s4
     dea:	f27ff0ef          	jal	d10 <parseblock>
     dee:	84aa                	mv	s1,a0
}
     df0:	8526                	mv	a0,s1
     df2:	70a6                	ld	ra,104(sp)
     df4:	7406                	ld	s0,96(sp)
     df6:	64e6                	ld	s1,88(sp)
     df8:	6a06                	ld	s4,64(sp)
     dfa:	7ae2                	ld	s5,56(sp)
     dfc:	6165                	add	sp,sp,112
     dfe:	8082                	ret
      panic("syntax");
     e00:	00001517          	auipc	a0,0x1
     e04:	ca050513          	add	a0,a0,-864 # 1aa0 <malloc+0x1ba>
     e08:	f3aff0ef          	jal	542 <panic>
    ret = parseredirs(ret, ps, es);
     e0c:	8656                	mv	a2,s5
     e0e:	85d2                	mv	a1,s4
     e10:	8526                	mv	a0,s1
     e12:	b67ff0ef          	jal	978 <parseredirs>
     e16:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
     e18:	865a                	mv	a2,s6
     e1a:	85d6                	mv	a1,s5
     e1c:	8552                	mv	a0,s4
     e1e:	9e9ff0ef          	jal	806 <peek>
     e22:	ed15                	bnez	a0,e5e <parseexec+0xca>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     e24:	f9040693          	add	a3,s0,-112
     e28:	f9840613          	add	a2,s0,-104
     e2c:	85d6                	mv	a1,s5
     e2e:	8552                	mv	a0,s4
     e30:	89bff0ef          	jal	6ca <gettoken>
     e34:	c50d                	beqz	a0,e5e <parseexec+0xca>
    if(tok != 'a')
     e36:	fd9515e3          	bne	a0,s9,e00 <parseexec+0x6c>
    cmd->argv[argc] = q;
     e3a:	f9843783          	ld	a5,-104(s0)
     e3e:	00f93023          	sd	a5,0(s2)
    cmd->eargv[argc] = eq;
     e42:	f9043783          	ld	a5,-112(s0)
     e46:	04f93823          	sd	a5,80(s2)
    argc++;
     e4a:	2985                	addw	s3,s3,1
    if(argc >= MAXARGS)
     e4c:	0921                	add	s2,s2,8
     e4e:	fb799fe3          	bne	s3,s7,e0c <parseexec+0x78>
      panic("too many args");
     e52:	00001517          	auipc	a0,0x1
     e56:	cae50513          	add	a0,a0,-850 # 1b00 <malloc+0x21a>
     e5a:	ee8ff0ef          	jal	542 <panic>
  cmd->argv[argc] = 0;
     e5e:	098e                	sll	s3,s3,0x3
     e60:	9c4e                	add	s8,s8,s3
     e62:	000c3423          	sd	zero,8(s8)
  cmd->eargv[argc] = 0;
     e66:	040c3c23          	sd	zero,88(s8)
     e6a:	6946                	ld	s2,80(sp)
     e6c:	69a6                	ld	s3,72(sp)
     e6e:	7b42                	ld	s6,48(sp)
     e70:	7ba2                	ld	s7,40(sp)
     e72:	7c02                	ld	s8,32(sp)
     e74:	6ce2                	ld	s9,24(sp)
  return ret;
     e76:	bfad                	j	df0 <parseexec+0x5c>

0000000000000e78 <parsepipe>:
{
     e78:	7179                	add	sp,sp,-48
     e7a:	f406                	sd	ra,40(sp)
     e7c:	f022                	sd	s0,32(sp)
     e7e:	ec26                	sd	s1,24(sp)
     e80:	e84a                	sd	s2,16(sp)
     e82:	e44e                	sd	s3,8(sp)
     e84:	1800                	add	s0,sp,48
     e86:	892a                	mv	s2,a0
     e88:	89ae                	mv	s3,a1
  cmd = parseexec(ps, es);
     e8a:	f0bff0ef          	jal	d94 <parseexec>
     e8e:	84aa                	mv	s1,a0
  if(peek(ps, es, "|")){
     e90:	00001617          	auipc	a2,0x1
     e94:	c8860613          	add	a2,a2,-888 # 1b18 <malloc+0x232>
     e98:	85ce                	mv	a1,s3
     e9a:	854a                	mv	a0,s2
     e9c:	96bff0ef          	jal	806 <peek>
     ea0:	e909                	bnez	a0,eb2 <parsepipe+0x3a>
}
     ea2:	8526                	mv	a0,s1
     ea4:	70a2                	ld	ra,40(sp)
     ea6:	7402                	ld	s0,32(sp)
     ea8:	64e2                	ld	s1,24(sp)
     eaa:	6942                	ld	s2,16(sp)
     eac:	69a2                	ld	s3,8(sp)
     eae:	6145                	add	sp,sp,48
     eb0:	8082                	ret
    gettoken(ps, es, 0, 0);
     eb2:	4681                	li	a3,0
     eb4:	4601                	li	a2,0
     eb6:	85ce                	mv	a1,s3
     eb8:	854a                	mv	a0,s2
     eba:	811ff0ef          	jal	6ca <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     ebe:	85ce                	mv	a1,s3
     ec0:	854a                	mv	a0,s2
     ec2:	fb7ff0ef          	jal	e78 <parsepipe>
     ec6:	85aa                	mv	a1,a0
     ec8:	8526                	mv	a0,s1
     eca:	b87ff0ef          	jal	a50 <pipecmd>
     ece:	84aa                	mv	s1,a0
  return cmd;
     ed0:	bfc9                	j	ea2 <parsepipe+0x2a>

0000000000000ed2 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
     ed2:	1141                	add	sp,sp,-16
     ed4:	e406                	sd	ra,8(sp)
     ed6:	e022                	sd	s0,0(sp)
     ed8:	0800                	add	s0,sp,16
  extern int main();
  main();
     eda:	d1fff0ef          	jal	bf8 <main>
  exit(0);
     ede:	4501                	li	a0,0
     ee0:	4d8000ef          	jal	13b8 <exit>

0000000000000ee4 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     ee4:	1141                	add	sp,sp,-16
     ee6:	e422                	sd	s0,8(sp)
     ee8:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     eea:	87aa                	mv	a5,a0
     eec:	0585                	add	a1,a1,1
     eee:	0785                	add	a5,a5,1
     ef0:	fff5c703          	lbu	a4,-1(a1)
     ef4:	fee78fa3          	sb	a4,-1(a5)
     ef8:	fb75                	bnez	a4,eec <strcpy+0x8>
    ;
  return os;
}
     efa:	6422                	ld	s0,8(sp)
     efc:	0141                	add	sp,sp,16
     efe:	8082                	ret

0000000000000f00 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     f00:	1141                	add	sp,sp,-16
     f02:	e422                	sd	s0,8(sp)
     f04:	0800                	add	s0,sp,16
  while(*p && *p == *q)
     f06:	00054783          	lbu	a5,0(a0)
     f0a:	cb91                	beqz	a5,f1e <strcmp+0x1e>
     f0c:	0005c703          	lbu	a4,0(a1)
     f10:	00f71763          	bne	a4,a5,f1e <strcmp+0x1e>
    p++, q++;
     f14:	0505                	add	a0,a0,1
     f16:	0585                	add	a1,a1,1
  while(*p && *p == *q)
     f18:	00054783          	lbu	a5,0(a0)
     f1c:	fbe5                	bnez	a5,f0c <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     f1e:	0005c503          	lbu	a0,0(a1)
}
     f22:	40a7853b          	subw	a0,a5,a0
     f26:	6422                	ld	s0,8(sp)
     f28:	0141                	add	sp,sp,16
     f2a:	8082                	ret

0000000000000f2c <strlen>:

uint
strlen(const char *s)
{
     f2c:	1141                	add	sp,sp,-16
     f2e:	e422                	sd	s0,8(sp)
     f30:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     f32:	00054783          	lbu	a5,0(a0)
     f36:	cf91                	beqz	a5,f52 <strlen+0x26>
     f38:	0505                	add	a0,a0,1
     f3a:	87aa                	mv	a5,a0
     f3c:	86be                	mv	a3,a5
     f3e:	0785                	add	a5,a5,1
     f40:	fff7c703          	lbu	a4,-1(a5)
     f44:	ff65                	bnez	a4,f3c <strlen+0x10>
     f46:	40a6853b          	subw	a0,a3,a0
     f4a:	2505                	addw	a0,a0,1
    ;
  return n;
}
     f4c:	6422                	ld	s0,8(sp)
     f4e:	0141                	add	sp,sp,16
     f50:	8082                	ret
  for(n = 0; s[n]; n++)
     f52:	4501                	li	a0,0
     f54:	bfe5                	j	f4c <strlen+0x20>

0000000000000f56 <memset>:

void*
memset(void *dst, int c, uint n)
{
     f56:	1141                	add	sp,sp,-16
     f58:	e422                	sd	s0,8(sp)
     f5a:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     f5c:	ca19                	beqz	a2,f72 <memset+0x1c>
     f5e:	87aa                	mv	a5,a0
     f60:	1602                	sll	a2,a2,0x20
     f62:	9201                	srl	a2,a2,0x20
     f64:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     f68:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     f6c:	0785                	add	a5,a5,1
     f6e:	fee79de3          	bne	a5,a4,f68 <memset+0x12>
  }
  return dst;
}
     f72:	6422                	ld	s0,8(sp)
     f74:	0141                	add	sp,sp,16
     f76:	8082                	ret

0000000000000f78 <strchr>:

char*
strchr(const char *s, char c)
{
     f78:	1141                	add	sp,sp,-16
     f7a:	e422                	sd	s0,8(sp)
     f7c:	0800                	add	s0,sp,16
  for(; *s; s++)
     f7e:	00054783          	lbu	a5,0(a0)
     f82:	cb99                	beqz	a5,f98 <strchr+0x20>
    if(*s == c)
     f84:	00f58763          	beq	a1,a5,f92 <strchr+0x1a>
  for(; *s; s++)
     f88:	0505                	add	a0,a0,1
     f8a:	00054783          	lbu	a5,0(a0)
     f8e:	fbfd                	bnez	a5,f84 <strchr+0xc>
      return (char*)s;
  return 0;
     f90:	4501                	li	a0,0
}
     f92:	6422                	ld	s0,8(sp)
     f94:	0141                	add	sp,sp,16
     f96:	8082                	ret
  return 0;
     f98:	4501                	li	a0,0
     f9a:	bfe5                	j	f92 <strchr+0x1a>

0000000000000f9c <gets>:

char*
gets(char *buf, int max)
{
     f9c:	711d                	add	sp,sp,-96
     f9e:	ec86                	sd	ra,88(sp)
     fa0:	e8a2                	sd	s0,80(sp)
     fa2:	e4a6                	sd	s1,72(sp)
     fa4:	e0ca                	sd	s2,64(sp)
     fa6:	fc4e                	sd	s3,56(sp)
     fa8:	f852                	sd	s4,48(sp)
     faa:	f456                	sd	s5,40(sp)
     fac:	f05a                	sd	s6,32(sp)
     fae:	ec5e                	sd	s7,24(sp)
     fb0:	1080                	add	s0,sp,96
     fb2:	8baa                	mv	s7,a0
     fb4:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     fb6:	892a                	mv	s2,a0
     fb8:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     fba:	4aa9                	li	s5,10
     fbc:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     fbe:	89a6                	mv	s3,s1
     fc0:	2485                	addw	s1,s1,1
     fc2:	0344d663          	bge	s1,s4,fee <gets+0x52>
    cc = read(0, &c, 1);
     fc6:	4605                	li	a2,1
     fc8:	faf40593          	add	a1,s0,-81
     fcc:	4501                	li	a0,0
     fce:	402000ef          	jal	13d0 <read>
    if(cc < 1)
     fd2:	00a05e63          	blez	a0,fee <gets+0x52>
    buf[i++] = c;
     fd6:	faf44783          	lbu	a5,-81(s0)
     fda:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     fde:	01578763          	beq	a5,s5,fec <gets+0x50>
     fe2:	0905                	add	s2,s2,1
     fe4:	fd679de3          	bne	a5,s6,fbe <gets+0x22>
    buf[i++] = c;
     fe8:	89a6                	mv	s3,s1
     fea:	a011                	j	fee <gets+0x52>
     fec:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     fee:	99de                	add	s3,s3,s7
     ff0:	00098023          	sb	zero,0(s3)
  return buf;
}
     ff4:	855e                	mv	a0,s7
     ff6:	60e6                	ld	ra,88(sp)
     ff8:	6446                	ld	s0,80(sp)
     ffa:	64a6                	ld	s1,72(sp)
     ffc:	6906                	ld	s2,64(sp)
     ffe:	79e2                	ld	s3,56(sp)
    1000:	7a42                	ld	s4,48(sp)
    1002:	7aa2                	ld	s5,40(sp)
    1004:	7b02                	ld	s6,32(sp)
    1006:	6be2                	ld	s7,24(sp)
    1008:	6125                	add	sp,sp,96
    100a:	8082                	ret

000000000000100c <stat>:

int
stat(const char *n, struct stat *st)
{
    100c:	1101                	add	sp,sp,-32
    100e:	ec06                	sd	ra,24(sp)
    1010:	e822                	sd	s0,16(sp)
    1012:	e04a                	sd	s2,0(sp)
    1014:	1000                	add	s0,sp,32
    1016:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1018:	4581                	li	a1,0
    101a:	3de000ef          	jal	13f8 <open>
  if(fd < 0)
    101e:	02054263          	bltz	a0,1042 <stat+0x36>
    1022:	e426                	sd	s1,8(sp)
    1024:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    1026:	85ca                	mv	a1,s2
    1028:	3e8000ef          	jal	1410 <fstat>
    102c:	892a                	mv	s2,a0
  close(fd);
    102e:	8526                	mv	a0,s1
    1030:	3b0000ef          	jal	13e0 <close>
  return r;
    1034:	64a2                	ld	s1,8(sp)
}
    1036:	854a                	mv	a0,s2
    1038:	60e2                	ld	ra,24(sp)
    103a:	6442                	ld	s0,16(sp)
    103c:	6902                	ld	s2,0(sp)
    103e:	6105                	add	sp,sp,32
    1040:	8082                	ret
    return -1;
    1042:	597d                	li	s2,-1
    1044:	bfcd                	j	1036 <stat+0x2a>

0000000000001046 <atoi>:

int
atoi(const char *s)
{
    1046:	1141                	add	sp,sp,-16
    1048:	e422                	sd	s0,8(sp)
    104a:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    104c:	00054683          	lbu	a3,0(a0)
    1050:	fd06879b          	addw	a5,a3,-48
    1054:	0ff7f793          	zext.b	a5,a5
    1058:	4625                	li	a2,9
    105a:	02f66863          	bltu	a2,a5,108a <atoi+0x44>
    105e:	872a                	mv	a4,a0
  n = 0;
    1060:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
    1062:	0705                	add	a4,a4,1
    1064:	0025179b          	sllw	a5,a0,0x2
    1068:	9fa9                	addw	a5,a5,a0
    106a:	0017979b          	sllw	a5,a5,0x1
    106e:	9fb5                	addw	a5,a5,a3
    1070:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    1074:	00074683          	lbu	a3,0(a4)
    1078:	fd06879b          	addw	a5,a3,-48
    107c:	0ff7f793          	zext.b	a5,a5
    1080:	fef671e3          	bgeu	a2,a5,1062 <atoi+0x1c>
  return n;
}
    1084:	6422                	ld	s0,8(sp)
    1086:	0141                	add	sp,sp,16
    1088:	8082                	ret
  n = 0;
    108a:	4501                	li	a0,0
    108c:	bfe5                	j	1084 <atoi+0x3e>

000000000000108e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    108e:	1141                	add	sp,sp,-16
    1090:	e422                	sd	s0,8(sp)
    1092:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    1094:	02b57463          	bgeu	a0,a1,10bc <memmove+0x2e>
    while(n-- > 0)
    1098:	00c05f63          	blez	a2,10b6 <memmove+0x28>
    109c:	1602                	sll	a2,a2,0x20
    109e:	9201                	srl	a2,a2,0x20
    10a0:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    10a4:	872a                	mv	a4,a0
      *dst++ = *src++;
    10a6:	0585                	add	a1,a1,1
    10a8:	0705                	add	a4,a4,1
    10aa:	fff5c683          	lbu	a3,-1(a1)
    10ae:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    10b2:	fef71ae3          	bne	a4,a5,10a6 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    10b6:	6422                	ld	s0,8(sp)
    10b8:	0141                	add	sp,sp,16
    10ba:	8082                	ret
    dst += n;
    10bc:	00c50733          	add	a4,a0,a2
    src += n;
    10c0:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    10c2:	fec05ae3          	blez	a2,10b6 <memmove+0x28>
    10c6:	fff6079b          	addw	a5,a2,-1
    10ca:	1782                	sll	a5,a5,0x20
    10cc:	9381                	srl	a5,a5,0x20
    10ce:	fff7c793          	not	a5,a5
    10d2:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    10d4:	15fd                	add	a1,a1,-1
    10d6:	177d                	add	a4,a4,-1
    10d8:	0005c683          	lbu	a3,0(a1)
    10dc:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    10e0:	fee79ae3          	bne	a5,a4,10d4 <memmove+0x46>
    10e4:	bfc9                	j	10b6 <memmove+0x28>

00000000000010e6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    10e6:	1141                	add	sp,sp,-16
    10e8:	e422                	sd	s0,8(sp)
    10ea:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    10ec:	ca05                	beqz	a2,111c <memcmp+0x36>
    10ee:	fff6069b          	addw	a3,a2,-1
    10f2:	1682                	sll	a3,a3,0x20
    10f4:	9281                	srl	a3,a3,0x20
    10f6:	0685                	add	a3,a3,1
    10f8:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    10fa:	00054783          	lbu	a5,0(a0)
    10fe:	0005c703          	lbu	a4,0(a1)
    1102:	00e79863          	bne	a5,a4,1112 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    1106:	0505                	add	a0,a0,1
    p2++;
    1108:	0585                	add	a1,a1,1
  while (n-- > 0) {
    110a:	fed518e3          	bne	a0,a3,10fa <memcmp+0x14>
  }
  return 0;
    110e:	4501                	li	a0,0
    1110:	a019                	j	1116 <memcmp+0x30>
      return *p1 - *p2;
    1112:	40e7853b          	subw	a0,a5,a4
}
    1116:	6422                	ld	s0,8(sp)
    1118:	0141                	add	sp,sp,16
    111a:	8082                	ret
  return 0;
    111c:	4501                	li	a0,0
    111e:	bfe5                	j	1116 <memcmp+0x30>

0000000000001120 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    1120:	1141                	add	sp,sp,-16
    1122:	e406                	sd	ra,8(sp)
    1124:	e022                	sd	s0,0(sp)
    1126:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
    1128:	f67ff0ef          	jal	108e <memmove>
}
    112c:	60a2                	ld	ra,8(sp)
    112e:	6402                	ld	s0,0(sp)
    1130:	0141                	add	sp,sp,16
    1132:	8082                	ret

0000000000001134 <htons>:
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
}

uint16_t
htons(uint16_t h)
{
    1134:	1141                	add	sp,sp,-16
    1136:	e422                	sd	s0,8(sp)
    1138:	0800                	add	s0,sp,16
    if (!endian) {
    113a:	00001797          	auipc	a5,0x1
    113e:	ede7a783          	lw	a5,-290(a5) # 2018 <endian>
    1142:	e385                	bnez	a5,1162 <htons+0x2e>
        endian = byteorder();
    1144:	4d200793          	li	a5,1234
    1148:	00001717          	auipc	a4,0x1
    114c:	ecf72823          	sw	a5,-304(a4) # 2018 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
    1150:	0085179b          	sllw	a5,a0,0x8
    1154:	0085551b          	srlw	a0,a0,0x8
    1158:	8fc9                	or	a5,a5,a0
    115a:	03079513          	sll	a0,a5,0x30
    115e:	9141                	srl	a0,a0,0x30
    1160:	a029                	j	116a <htons+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(h) : h;
    1162:	4d200713          	li	a4,1234
    1166:	fee785e3          	beq	a5,a4,1150 <htons+0x1c>
}
    116a:	6422                	ld	s0,8(sp)
    116c:	0141                	add	sp,sp,16
    116e:	8082                	ret

0000000000001170 <ntohs>:

uint16_t
ntohs(uint16_t n)
{
    1170:	1141                	add	sp,sp,-16
    1172:	e422                	sd	s0,8(sp)
    1174:	0800                	add	s0,sp,16
    if (!endian) {
    1176:	00001797          	auipc	a5,0x1
    117a:	ea27a783          	lw	a5,-350(a5) # 2018 <endian>
    117e:	e385                	bnez	a5,119e <ntohs+0x2e>
        endian = byteorder();
    1180:	4d200793          	li	a5,1234
    1184:	00001717          	auipc	a4,0x1
    1188:	e8f72a23          	sw	a5,-364(a4) # 2018 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
    118c:	0085179b          	sllw	a5,a0,0x8
    1190:	0085551b          	srlw	a0,a0,0x8
    1194:	8fc9                	or	a5,a5,a0
    1196:	03079513          	sll	a0,a5,0x30
    119a:	9141                	srl	a0,a0,0x30
    119c:	a029                	j	11a6 <ntohs+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(n) : n;
    119e:	4d200713          	li	a4,1234
    11a2:	fee785e3          	beq	a5,a4,118c <ntohs+0x1c>
}
    11a6:	6422                	ld	s0,8(sp)
    11a8:	0141                	add	sp,sp,16
    11aa:	8082                	ret

00000000000011ac <htonl>:

uint32_t
htonl(uint32_t h)
{
    11ac:	1141                	add	sp,sp,-16
    11ae:	e422                	sd	s0,8(sp)
    11b0:	0800                	add	s0,sp,16
    if (!endian) {
    11b2:	00001797          	auipc	a5,0x1
    11b6:	e667a783          	lw	a5,-410(a5) # 2018 <endian>
    11ba:	ef85                	bnez	a5,11f2 <htonl+0x46>
        endian = byteorder();
    11bc:	4d200793          	li	a5,1234
    11c0:	00001717          	auipc	a4,0x1
    11c4:	e4f72c23          	sw	a5,-424(a4) # 2018 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
    11c8:	0185179b          	sllw	a5,a0,0x18
    11cc:	0185571b          	srlw	a4,a0,0x18
    11d0:	8fd9                	or	a5,a5,a4
    11d2:	0085171b          	sllw	a4,a0,0x8
    11d6:	00ff06b7          	lui	a3,0xff0
    11da:	8f75                	and	a4,a4,a3
    11dc:	8fd9                	or	a5,a5,a4
    11de:	0085551b          	srlw	a0,a0,0x8
    11e2:	6741                	lui	a4,0x10
    11e4:	f0070713          	add	a4,a4,-256 # ff00 <base+0xd5d0>
    11e8:	8d79                	and	a0,a0,a4
    11ea:	8fc9                	or	a5,a5,a0
    11ec:	0007851b          	sext.w	a0,a5
    11f0:	a029                	j	11fa <htonl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(h) : h;
    11f2:	4d200713          	li	a4,1234
    11f6:	fce789e3          	beq	a5,a4,11c8 <htonl+0x1c>
}
    11fa:	6422                	ld	s0,8(sp)
    11fc:	0141                	add	sp,sp,16
    11fe:	8082                	ret

0000000000001200 <ntohl>:

uint32_t
ntohl(uint32_t n)
{
    1200:	1141                	add	sp,sp,-16
    1202:	e422                	sd	s0,8(sp)
    1204:	0800                	add	s0,sp,16
    if (!endian) {
    1206:	00001797          	auipc	a5,0x1
    120a:	e127a783          	lw	a5,-494(a5) # 2018 <endian>
    120e:	ef85                	bnez	a5,1246 <ntohl+0x46>
        endian = byteorder();
    1210:	4d200793          	li	a5,1234
    1214:	00001717          	auipc	a4,0x1
    1218:	e0f72223          	sw	a5,-508(a4) # 2018 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
    121c:	0185179b          	sllw	a5,a0,0x18
    1220:	0185571b          	srlw	a4,a0,0x18
    1224:	8fd9                	or	a5,a5,a4
    1226:	0085171b          	sllw	a4,a0,0x8
    122a:	00ff06b7          	lui	a3,0xff0
    122e:	8f75                	and	a4,a4,a3
    1230:	8fd9                	or	a5,a5,a4
    1232:	0085551b          	srlw	a0,a0,0x8
    1236:	6741                	lui	a4,0x10
    1238:	f0070713          	add	a4,a4,-256 # ff00 <base+0xd5d0>
    123c:	8d79                	and	a0,a0,a4
    123e:	8fc9                	or	a5,a5,a0
    1240:	0007851b          	sext.w	a0,a5
    1244:	a029                	j	124e <ntohl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(n) : n;
    1246:	4d200713          	li	a4,1234
    124a:	fce789e3          	beq	a5,a4,121c <ntohl+0x1c>
}
    124e:	6422                	ld	s0,8(sp)
    1250:	0141                	add	sp,sp,16
    1252:	8082                	ret

0000000000001254 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
    1254:	1141                	add	sp,sp,-16
    1256:	e422                	sd	s0,8(sp)
    1258:	0800                	add	s0,sp,16
    125a:	872a                	mv	a4,a0
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
    125c:	02000693          	li	a3,32
    1260:	4525                	li	a0,9
    1262:	a011                	j	1266 <strtol+0x12>
        s++;
    1264:	0705                	add	a4,a4,1
    while (*s == ' ' || *s == '\t')
    1266:	00074783          	lbu	a5,0(a4)
    126a:	fed78de3          	beq	a5,a3,1264 <strtol+0x10>
    126e:	fea78be3          	beq	a5,a0,1264 <strtol+0x10>

    // plus/minus sign
    if (*s == '+')
    1272:	02b00693          	li	a3,43
    1276:	02d78663          	beq	a5,a3,12a2 <strtol+0x4e>
        s++;
    else if (*s == '-')
    127a:	02d00693          	li	a3,45
    int neg = 0;
    127e:	4301                	li	t1,0
    else if (*s == '-')
    1280:	02d78463          	beq	a5,a3,12a8 <strtol+0x54>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
    1284:	fef67793          	and	a5,a2,-17
    1288:	eb89                	bnez	a5,129a <strtol+0x46>
    128a:	00074683          	lbu	a3,0(a4)
    128e:	03000793          	li	a5,48
    1292:	00f68e63          	beq	a3,a5,12ae <strtol+0x5a>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
    1296:	e211                	bnez	a2,129a <strtol+0x46>
        s++, base = 8;
    else if (base == 0)
        base = 10;
    1298:	4629                	li	a2,10
    129a:	4501                	li	a0,0

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
    129c:	4825                	li	a6,9
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
    129e:	48e5                	li	a7,25
    12a0:	a825                	j	12d8 <strtol+0x84>
        s++;
    12a2:	0705                	add	a4,a4,1
    int neg = 0;
    12a4:	4301                	li	t1,0
    12a6:	bff9                	j	1284 <strtol+0x30>
        s++, neg = 1;
    12a8:	0705                	add	a4,a4,1
    12aa:	4305                	li	t1,1
    12ac:	bfe1                	j	1284 <strtol+0x30>
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
    12ae:	00174683          	lbu	a3,1(a4)
    12b2:	07800793          	li	a5,120
    12b6:	00f68663          	beq	a3,a5,12c2 <strtol+0x6e>
    else if (base == 0 && s[0] == '0')
    12ba:	f265                	bnez	a2,129a <strtol+0x46>
        s++, base = 8;
    12bc:	0705                	add	a4,a4,1
    12be:	4621                	li	a2,8
    12c0:	bfe9                	j	129a <strtol+0x46>
        s += 2, base = 16;
    12c2:	0709                	add	a4,a4,2
    12c4:	4641                	li	a2,16
    12c6:	bfd1                	j	129a <strtol+0x46>
            dig = *s - '0';
    12c8:	fd07879b          	addw	a5,a5,-48
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
    12cc:	04c7d063          	bge	a5,a2,130c <strtol+0xb8>
            break;
        s++, val = (val * base) + dig;
    12d0:	0705                	add	a4,a4,1
    12d2:	02a60533          	mul	a0,a2,a0
    12d6:	953e                	add	a0,a0,a5
        if (*s >= '0' && *s <= '9')
    12d8:	00074783          	lbu	a5,0(a4)
    12dc:	fd07869b          	addw	a3,a5,-48
    12e0:	0ff6f693          	zext.b	a3,a3
    12e4:	fed872e3          	bgeu	a6,a3,12c8 <strtol+0x74>
        else if (*s >= 'a' && *s <= 'z')
    12e8:	f9f7869b          	addw	a3,a5,-97
    12ec:	0ff6f693          	zext.b	a3,a3
    12f0:	00d8e563          	bltu	a7,a3,12fa <strtol+0xa6>
            dig = *s - 'a' + 10;
    12f4:	fa97879b          	addw	a5,a5,-87
    12f8:	bfd1                	j	12cc <strtol+0x78>
        else if (*s >= 'A' && *s <= 'Z')
    12fa:	fbf7869b          	addw	a3,a5,-65
    12fe:	0ff6f693          	zext.b	a3,a3
    1302:	00d8e563          	bltu	a7,a3,130c <strtol+0xb8>
            dig = *s - 'A' + 10;
    1306:	fc97879b          	addw	a5,a5,-55
    130a:	b7c9                	j	12cc <strtol+0x78>
        // we don't properly detect overflow!
    }

    if (endptr)
    130c:	c191                	beqz	a1,1310 <strtol+0xbc>
        *endptr = (char *) s;
    130e:	e198                	sd	a4,0(a1)
    return (neg ? -val : val);
    1310:	00030463          	beqz	t1,1318 <strtol+0xc4>
    1314:	40a00533          	neg	a0,a0
}
    1318:	6422                	ld	s0,8(sp)
    131a:	0141                	add	sp,sp,16
    131c:	8082                	ret

000000000000131e <inet_pton>:
inet_pton (int family, const char *p, void *n) {
    char *sp, *ep;
    int idx;
    long ret;

    if (family != AF_INET) {
    131e:	4785                	li	a5,1
    1320:	08f51063          	bne	a0,a5,13a0 <inet_pton+0x82>
inet_pton (int family, const char *p, void *n) {
    1324:	715d                	add	sp,sp,-80
    1326:	e486                	sd	ra,72(sp)
    1328:	e0a2                	sd	s0,64(sp)
    132a:	fc26                	sd	s1,56(sp)
    132c:	f84a                	sd	s2,48(sp)
    132e:	f44e                	sd	s3,40(sp)
    1330:	f052                	sd	s4,32(sp)
    1332:	ec56                	sd	s5,24(sp)
    1334:	e85a                	sd	s6,16(sp)
    1336:	0880                	add	s0,sp,80
    1338:	84ae                	mv	s1,a1
    133a:	89b2                	mv	s3,a2
    133c:	4901                	li	s2,0
        return -1;
    }
    sp = (char *)p;
    for (idx = 0; idx < 4; idx++) {
        ret = strtol(sp, &ep, 10);
        if (ret < 0 || ret > 255) {
    133e:	0ff00a13          	li	s4,255
            return -1;
        }
        if (ep == sp) {
            return -1;
        }
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
    1342:	4a8d                	li	s5,3
    1344:	02e00b13          	li	s6,46
    1348:	a805                	j	1378 <inet_pton+0x5a>
    134a:	0007c783          	lbu	a5,0(a5)
    134e:	efb9                	bnez	a5,13ac <inet_pton+0x8e>
            return -1;
        }
        ((uint8_t *)n)[idx] = ret;
    1350:	00a981a3          	sb	a0,3(s3)
        sp = ep + 1;
    }
    return 0;
    1354:	4501                	li	a0,0
}
    1356:	60a6                	ld	ra,72(sp)
    1358:	6406                	ld	s0,64(sp)
    135a:	74e2                	ld	s1,56(sp)
    135c:	7942                	ld	s2,48(sp)
    135e:	79a2                	ld	s3,40(sp)
    1360:	7a02                	ld	s4,32(sp)
    1362:	6ae2                	ld	s5,24(sp)
    1364:	6b42                	ld	s6,16(sp)
    1366:	6161                	add	sp,sp,80
    1368:	8082                	ret
        ((uint8_t *)n)[idx] = ret;
    136a:	01298733          	add	a4,s3,s2
    136e:	00a70023          	sb	a0,0(a4)
        sp = ep + 1;
    1372:	00178493          	add	s1,a5,1
    for (idx = 0; idx < 4; idx++) {
    1376:	0905                	add	s2,s2,1
        ret = strtol(sp, &ep, 10);
    1378:	4629                	li	a2,10
    137a:	fb840593          	add	a1,s0,-72
    137e:	8526                	mv	a0,s1
    1380:	ed5ff0ef          	jal	1254 <strtol>
        if (ret < 0 || ret > 255) {
    1384:	02aa6063          	bltu	s4,a0,13a4 <inet_pton+0x86>
        if (ep == sp) {
    1388:	fb843783          	ld	a5,-72(s0)
    138c:	00978e63          	beq	a5,s1,13a8 <inet_pton+0x8a>
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
    1390:	fb590de3          	beq	s2,s5,134a <inet_pton+0x2c>
    1394:	0007c703          	lbu	a4,0(a5)
    1398:	fd6709e3          	beq	a4,s6,136a <inet_pton+0x4c>
            return -1;
    139c:	557d                	li	a0,-1
    139e:	bf65                	j	1356 <inet_pton+0x38>
        return -1;
    13a0:	557d                	li	a0,-1
}
    13a2:	8082                	ret
            return -1;
    13a4:	557d                	li	a0,-1
    13a6:	bf45                	j	1356 <inet_pton+0x38>
            return -1;
    13a8:	557d                	li	a0,-1
    13aa:	b775                	j	1356 <inet_pton+0x38>
            return -1;
    13ac:	557d                	li	a0,-1
    13ae:	b765                	j	1356 <inet_pton+0x38>

00000000000013b0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    13b0:	4885                	li	a7,1
 ecall
    13b2:	00000073          	ecall
 ret
    13b6:	8082                	ret

00000000000013b8 <exit>:
.global exit
exit:
 li a7, SYS_exit
    13b8:	4889                	li	a7,2
 ecall
    13ba:	00000073          	ecall
 ret
    13be:	8082                	ret

00000000000013c0 <wait>:
.global wait
wait:
 li a7, SYS_wait
    13c0:	488d                	li	a7,3
 ecall
    13c2:	00000073          	ecall
 ret
    13c6:	8082                	ret

00000000000013c8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    13c8:	4891                	li	a7,4
 ecall
    13ca:	00000073          	ecall
 ret
    13ce:	8082                	ret

00000000000013d0 <read>:
.global read
read:
 li a7, SYS_read
    13d0:	4895                	li	a7,5
 ecall
    13d2:	00000073          	ecall
 ret
    13d6:	8082                	ret

00000000000013d8 <write>:
.global write
write:
 li a7, SYS_write
    13d8:	48c1                	li	a7,16
 ecall
    13da:	00000073          	ecall
 ret
    13de:	8082                	ret

00000000000013e0 <close>:
.global close
close:
 li a7, SYS_close
    13e0:	48d5                	li	a7,21
 ecall
    13e2:	00000073          	ecall
 ret
    13e6:	8082                	ret

00000000000013e8 <kill>:
.global kill
kill:
 li a7, SYS_kill
    13e8:	4899                	li	a7,6
 ecall
    13ea:	00000073          	ecall
 ret
    13ee:	8082                	ret

00000000000013f0 <exec>:
.global exec
exec:
 li a7, SYS_exec
    13f0:	489d                	li	a7,7
 ecall
    13f2:	00000073          	ecall
 ret
    13f6:	8082                	ret

00000000000013f8 <open>:
.global open
open:
 li a7, SYS_open
    13f8:	48bd                	li	a7,15
 ecall
    13fa:	00000073          	ecall
 ret
    13fe:	8082                	ret

0000000000001400 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    1400:	48c5                	li	a7,17
 ecall
    1402:	00000073          	ecall
 ret
    1406:	8082                	ret

0000000000001408 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    1408:	48c9                	li	a7,18
 ecall
    140a:	00000073          	ecall
 ret
    140e:	8082                	ret

0000000000001410 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    1410:	48a1                	li	a7,8
 ecall
    1412:	00000073          	ecall
 ret
    1416:	8082                	ret

0000000000001418 <link>:
.global link
link:
 li a7, SYS_link
    1418:	48cd                	li	a7,19
 ecall
    141a:	00000073          	ecall
 ret
    141e:	8082                	ret

0000000000001420 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    1420:	48d1                	li	a7,20
 ecall
    1422:	00000073          	ecall
 ret
    1426:	8082                	ret

0000000000001428 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    1428:	48a5                	li	a7,9
 ecall
    142a:	00000073          	ecall
 ret
    142e:	8082                	ret

0000000000001430 <dup>:
.global dup
dup:
 li a7, SYS_dup
    1430:	48a9                	li	a7,10
 ecall
    1432:	00000073          	ecall
 ret
    1436:	8082                	ret

0000000000001438 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    1438:	48ad                	li	a7,11
 ecall
    143a:	00000073          	ecall
 ret
    143e:	8082                	ret

0000000000001440 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    1440:	48b1                	li	a7,12
 ecall
    1442:	00000073          	ecall
 ret
    1446:	8082                	ret

0000000000001448 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    1448:	48b5                	li	a7,13
 ecall
    144a:	00000073          	ecall
 ret
    144e:	8082                	ret

0000000000001450 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    1450:	48b9                	li	a7,14
 ecall
    1452:	00000073          	ecall
 ret
    1456:	8082                	ret

0000000000001458 <socket>:
.global socket
socket:
 li a7, SYS_socket
    1458:	48d9                	li	a7,22
 ecall
    145a:	00000073          	ecall
 ret
    145e:	8082                	ret

0000000000001460 <bind>:
.global bind
bind:
 li a7, SYS_bind
    1460:	48dd                	li	a7,23
 ecall
    1462:	00000073          	ecall
 ret
    1466:	8082                	ret

0000000000001468 <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
    1468:	48e1                	li	a7,24
 ecall
    146a:	00000073          	ecall
 ret
    146e:	8082                	ret

0000000000001470 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
    1470:	48e5                	li	a7,25
 ecall
    1472:	00000073          	ecall
 ret
    1476:	8082                	ret

0000000000001478 <connect>:
.global connect
connect:
 li a7, SYS_connect
    1478:	48e9                	li	a7,26
 ecall
    147a:	00000073          	ecall
 ret
    147e:	8082                	ret

0000000000001480 <listen>:
.global listen
listen:
 li a7, SYS_listen
    1480:	48ed                	li	a7,27
 ecall
    1482:	00000073          	ecall
 ret
    1486:	8082                	ret

0000000000001488 <accept>:
.global accept
accept:
 li a7, SYS_accept
    1488:	48f1                	li	a7,28
 ecall
    148a:	00000073          	ecall
 ret
    148e:	8082                	ret

0000000000001490 <recv>:
.global recv
recv:
 li a7, SYS_recv
    1490:	48f5                	li	a7,29
 ecall
    1492:	00000073          	ecall
 ret
    1496:	8082                	ret

0000000000001498 <send>:
.global send
send:
 li a7, SYS_send
    1498:	48f9                	li	a7,30
 ecall
    149a:	00000073          	ecall
 ret
    149e:	8082                	ret

00000000000014a0 <ioctl>:
.global ioctl
ioctl:
 li a7, SYS_ioctl
    14a0:	48fd                	li	a7,31
 ecall
    14a2:	00000073          	ecall
 ret
    14a6:	8082                	ret

00000000000014a8 <consolemode>:
.global consolemode
consolemode:
 li a7, SYS_consolemode
    14a8:	02000893          	li	a7,32
 ecall
    14ac:	00000073          	ecall
 ret
    14b0:	8082                	ret

00000000000014b2 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    14b2:	1101                	add	sp,sp,-32
    14b4:	ec06                	sd	ra,24(sp)
    14b6:	e822                	sd	s0,16(sp)
    14b8:	1000                	add	s0,sp,32
    14ba:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    14be:	4605                	li	a2,1
    14c0:	fef40593          	add	a1,s0,-17
    14c4:	f15ff0ef          	jal	13d8 <write>
}
    14c8:	60e2                	ld	ra,24(sp)
    14ca:	6442                	ld	s0,16(sp)
    14cc:	6105                	add	sp,sp,32
    14ce:	8082                	ret

00000000000014d0 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
    14d0:	715d                	add	sp,sp,-80
    14d2:	e486                	sd	ra,72(sp)
    14d4:	e0a2                	sd	s0,64(sp)
    14d6:	fc26                	sd	s1,56(sp)
    14d8:	0880                	add	s0,sp,80
    14da:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    14dc:	c299                	beqz	a3,14e2 <printint+0x12>
    14de:	0805c963          	bltz	a1,1570 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    14e2:	2581                	sext.w	a1,a1
  neg = 0;
    14e4:	4881                	li	a7,0
    14e6:	fb840693          	add	a3,s0,-72
  }

  i = 0;
    14ea:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    14ec:	2601                	sext.w	a2,a2
    14ee:	00000517          	auipc	a0,0x0
    14f2:	66a50513          	add	a0,a0,1642 # 1b58 <digits>
    14f6:	883a                	mv	a6,a4
    14f8:	2705                	addw	a4,a4,1
    14fa:	02c5f7bb          	remuw	a5,a1,a2
    14fe:	1782                	sll	a5,a5,0x20
    1500:	9381                	srl	a5,a5,0x20
    1502:	97aa                	add	a5,a5,a0
    1504:	0007c783          	lbu	a5,0(a5)
    1508:	00f68023          	sb	a5,0(a3) # ff0000 <base+0xfed6d0>
  }while((x /= base) != 0);
    150c:	0005879b          	sext.w	a5,a1
    1510:	02c5d5bb          	divuw	a1,a1,a2
    1514:	0685                	add	a3,a3,1
    1516:	fec7f0e3          	bgeu	a5,a2,14f6 <printint+0x26>
  if(neg)
    151a:	00088c63          	beqz	a7,1532 <printint+0x62>
    buf[i++] = '-';
    151e:	fd070793          	add	a5,a4,-48
    1522:	00878733          	add	a4,a5,s0
    1526:	02d00793          	li	a5,45
    152a:	fef70423          	sb	a5,-24(a4)
    152e:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
    1532:	02e05a63          	blez	a4,1566 <printint+0x96>
    1536:	f84a                	sd	s2,48(sp)
    1538:	f44e                	sd	s3,40(sp)
    153a:	fb840793          	add	a5,s0,-72
    153e:	00e78933          	add	s2,a5,a4
    1542:	fff78993          	add	s3,a5,-1
    1546:	99ba                	add	s3,s3,a4
    1548:	377d                	addw	a4,a4,-1
    154a:	1702                	sll	a4,a4,0x20
    154c:	9301                	srl	a4,a4,0x20
    154e:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    1552:	fff94583          	lbu	a1,-1(s2)
    1556:	8526                	mv	a0,s1
    1558:	f5bff0ef          	jal	14b2 <putc>
  while(--i >= 0)
    155c:	197d                	add	s2,s2,-1
    155e:	ff391ae3          	bne	s2,s3,1552 <printint+0x82>
    1562:	7942                	ld	s2,48(sp)
    1564:	79a2                	ld	s3,40(sp)
}
    1566:	60a6                	ld	ra,72(sp)
    1568:	6406                	ld	s0,64(sp)
    156a:	74e2                	ld	s1,56(sp)
    156c:	6161                	add	sp,sp,80
    156e:	8082                	ret
    x = -xx;
    1570:	40b005bb          	negw	a1,a1
    neg = 1;
    1574:	4885                	li	a7,1
    x = -xx;
    1576:	bf85                	j	14e6 <printint+0x16>

0000000000001578 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    1578:	711d                	add	sp,sp,-96
    157a:	ec86                	sd	ra,88(sp)
    157c:	e8a2                	sd	s0,80(sp)
    157e:	e0ca                	sd	s2,64(sp)
    1580:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    1582:	0005c903          	lbu	s2,0(a1)
    1586:	26090863          	beqz	s2,17f6 <vprintf+0x27e>
    158a:	e4a6                	sd	s1,72(sp)
    158c:	fc4e                	sd	s3,56(sp)
    158e:	f852                	sd	s4,48(sp)
    1590:	f456                	sd	s5,40(sp)
    1592:	f05a                	sd	s6,32(sp)
    1594:	ec5e                	sd	s7,24(sp)
    1596:	e862                	sd	s8,16(sp)
    1598:	e466                	sd	s9,8(sp)
    159a:	8b2a                	mv	s6,a0
    159c:	8a2e                	mv	s4,a1
    159e:	8bb2                	mv	s7,a2
  state = 0;
    15a0:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
    15a2:	4481                	li	s1,0
    15a4:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
    15a6:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
    15aa:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
    15ae:	06c00c93          	li	s9,108
    15b2:	a005                	j	15d2 <vprintf+0x5a>
        putc(fd, c0);
    15b4:	85ca                	mv	a1,s2
    15b6:	855a                	mv	a0,s6
    15b8:	efbff0ef          	jal	14b2 <putc>
    15bc:	a019                	j	15c2 <vprintf+0x4a>
    } else if(state == '%'){
    15be:	03598263          	beq	s3,s5,15e2 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
    15c2:	2485                	addw	s1,s1,1
    15c4:	8726                	mv	a4,s1
    15c6:	009a07b3          	add	a5,s4,s1
    15ca:	0007c903          	lbu	s2,0(a5)
    15ce:	20090c63          	beqz	s2,17e6 <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
    15d2:	0009079b          	sext.w	a5,s2
    if(state == 0){
    15d6:	fe0994e3          	bnez	s3,15be <vprintf+0x46>
      if(c0 == '%'){
    15da:	fd579de3          	bne	a5,s5,15b4 <vprintf+0x3c>
        state = '%';
    15de:	89be                	mv	s3,a5
    15e0:	b7cd                	j	15c2 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
    15e2:	00ea06b3          	add	a3,s4,a4
    15e6:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
    15ea:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
    15ec:	c681                	beqz	a3,15f4 <vprintf+0x7c>
    15ee:	9752                	add	a4,a4,s4
    15f0:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
    15f4:	03878f63          	beq	a5,s8,1632 <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
    15f8:	05978963          	beq	a5,s9,164a <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
    15fc:	07500713          	li	a4,117
    1600:	0ee78363          	beq	a5,a4,16e6 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
    1604:	07800713          	li	a4,120
    1608:	12e78563          	beq	a5,a4,1732 <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
    160c:	07000713          	li	a4,112
    1610:	14e78a63          	beq	a5,a4,1764 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
    1614:	07300713          	li	a4,115
    1618:	18e78a63          	beq	a5,a4,17ac <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
    161c:	02500713          	li	a4,37
    1620:	04e79563          	bne	a5,a4,166a <vprintf+0xf2>
        putc(fd, '%');
    1624:	02500593          	li	a1,37
    1628:	855a                	mv	a0,s6
    162a:	e89ff0ef          	jal	14b2 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
    162e:	4981                	li	s3,0
    1630:	bf49                	j	15c2 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
    1632:	008b8913          	add	s2,s7,8
    1636:	4685                	li	a3,1
    1638:	4629                	li	a2,10
    163a:	000ba583          	lw	a1,0(s7)
    163e:	855a                	mv	a0,s6
    1640:	e91ff0ef          	jal	14d0 <printint>
    1644:	8bca                	mv	s7,s2
      state = 0;
    1646:	4981                	li	s3,0
    1648:	bfad                	j	15c2 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
    164a:	06400793          	li	a5,100
    164e:	02f68963          	beq	a3,a5,1680 <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    1652:	06c00793          	li	a5,108
    1656:	04f68263          	beq	a3,a5,169a <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
    165a:	07500793          	li	a5,117
    165e:	0af68063          	beq	a3,a5,16fe <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
    1662:	07800793          	li	a5,120
    1666:	0ef68263          	beq	a3,a5,174a <vprintf+0x1d2>
        putc(fd, '%');
    166a:	02500593          	li	a1,37
    166e:	855a                	mv	a0,s6
    1670:	e43ff0ef          	jal	14b2 <putc>
        putc(fd, c0);
    1674:	85ca                	mv	a1,s2
    1676:	855a                	mv	a0,s6
    1678:	e3bff0ef          	jal	14b2 <putc>
      state = 0;
    167c:	4981                	li	s3,0
    167e:	b791                	j	15c2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
    1680:	008b8913          	add	s2,s7,8
    1684:	4685                	li	a3,1
    1686:	4629                	li	a2,10
    1688:	000bb583          	ld	a1,0(s7)
    168c:	855a                	mv	a0,s6
    168e:	e43ff0ef          	jal	14d0 <printint>
        i += 1;
    1692:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
    1694:	8bca                	mv	s7,s2
      state = 0;
    1696:	4981                	li	s3,0
        i += 1;
    1698:	b72d                	j	15c2 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    169a:	06400793          	li	a5,100
    169e:	02f60763          	beq	a2,a5,16cc <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
    16a2:	07500793          	li	a5,117
    16a6:	06f60963          	beq	a2,a5,1718 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
    16aa:	07800793          	li	a5,120
    16ae:	faf61ee3          	bne	a2,a5,166a <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
    16b2:	008b8913          	add	s2,s7,8
    16b6:	4681                	li	a3,0
    16b8:	4641                	li	a2,16
    16ba:	000bb583          	ld	a1,0(s7)
    16be:	855a                	mv	a0,s6
    16c0:	e11ff0ef          	jal	14d0 <printint>
        i += 2;
    16c4:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
    16c6:	8bca                	mv	s7,s2
      state = 0;
    16c8:	4981                	li	s3,0
        i += 2;
    16ca:	bde5                	j	15c2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
    16cc:	008b8913          	add	s2,s7,8
    16d0:	4685                	li	a3,1
    16d2:	4629                	li	a2,10
    16d4:	000bb583          	ld	a1,0(s7)
    16d8:	855a                	mv	a0,s6
    16da:	df7ff0ef          	jal	14d0 <printint>
        i += 2;
    16de:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
    16e0:	8bca                	mv	s7,s2
      state = 0;
    16e2:	4981                	li	s3,0
        i += 2;
    16e4:	bdf9                	j	15c2 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
    16e6:	008b8913          	add	s2,s7,8
    16ea:	4681                	li	a3,0
    16ec:	4629                	li	a2,10
    16ee:	000ba583          	lw	a1,0(s7)
    16f2:	855a                	mv	a0,s6
    16f4:	dddff0ef          	jal	14d0 <printint>
    16f8:	8bca                	mv	s7,s2
      state = 0;
    16fa:	4981                	li	s3,0
    16fc:	b5d9                	j	15c2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
    16fe:	008b8913          	add	s2,s7,8
    1702:	4681                	li	a3,0
    1704:	4629                	li	a2,10
    1706:	000bb583          	ld	a1,0(s7)
    170a:	855a                	mv	a0,s6
    170c:	dc5ff0ef          	jal	14d0 <printint>
        i += 1;
    1710:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
    1712:	8bca                	mv	s7,s2
      state = 0;
    1714:	4981                	li	s3,0
        i += 1;
    1716:	b575                	j	15c2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
    1718:	008b8913          	add	s2,s7,8
    171c:	4681                	li	a3,0
    171e:	4629                	li	a2,10
    1720:	000bb583          	ld	a1,0(s7)
    1724:	855a                	mv	a0,s6
    1726:	dabff0ef          	jal	14d0 <printint>
        i += 2;
    172a:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
    172c:	8bca                	mv	s7,s2
      state = 0;
    172e:	4981                	li	s3,0
        i += 2;
    1730:	bd49                	j	15c2 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
    1732:	008b8913          	add	s2,s7,8
    1736:	4681                	li	a3,0
    1738:	4641                	li	a2,16
    173a:	000ba583          	lw	a1,0(s7)
    173e:	855a                	mv	a0,s6
    1740:	d91ff0ef          	jal	14d0 <printint>
    1744:	8bca                	mv	s7,s2
      state = 0;
    1746:	4981                	li	s3,0
    1748:	bdad                	j	15c2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
    174a:	008b8913          	add	s2,s7,8
    174e:	4681                	li	a3,0
    1750:	4641                	li	a2,16
    1752:	000bb583          	ld	a1,0(s7)
    1756:	855a                	mv	a0,s6
    1758:	d79ff0ef          	jal	14d0 <printint>
        i += 1;
    175c:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
    175e:	8bca                	mv	s7,s2
      state = 0;
    1760:	4981                	li	s3,0
        i += 1;
    1762:	b585                	j	15c2 <vprintf+0x4a>
    1764:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
    1766:	008b8d13          	add	s10,s7,8
    176a:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    176e:	03000593          	li	a1,48
    1772:	855a                	mv	a0,s6
    1774:	d3fff0ef          	jal	14b2 <putc>
  putc(fd, 'x');
    1778:	07800593          	li	a1,120
    177c:	855a                	mv	a0,s6
    177e:	d35ff0ef          	jal	14b2 <putc>
    1782:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    1784:	00000b97          	auipc	s7,0x0
    1788:	3d4b8b93          	add	s7,s7,980 # 1b58 <digits>
    178c:	03c9d793          	srl	a5,s3,0x3c
    1790:	97de                	add	a5,a5,s7
    1792:	0007c583          	lbu	a1,0(a5)
    1796:	855a                	mv	a0,s6
    1798:	d1bff0ef          	jal	14b2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    179c:	0992                	sll	s3,s3,0x4
    179e:	397d                	addw	s2,s2,-1
    17a0:	fe0916e3          	bnez	s2,178c <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
    17a4:	8bea                	mv	s7,s10
      state = 0;
    17a6:	4981                	li	s3,0
    17a8:	6d02                	ld	s10,0(sp)
    17aa:	bd21                	j	15c2 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
    17ac:	008b8993          	add	s3,s7,8
    17b0:	000bb903          	ld	s2,0(s7)
    17b4:	00090f63          	beqz	s2,17d2 <vprintf+0x25a>
        for(; *s; s++)
    17b8:	00094583          	lbu	a1,0(s2)
    17bc:	c195                	beqz	a1,17e0 <vprintf+0x268>
          putc(fd, *s);
    17be:	855a                	mv	a0,s6
    17c0:	cf3ff0ef          	jal	14b2 <putc>
        for(; *s; s++)
    17c4:	0905                	add	s2,s2,1
    17c6:	00094583          	lbu	a1,0(s2)
    17ca:	f9f5                	bnez	a1,17be <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
    17cc:	8bce                	mv	s7,s3
      state = 0;
    17ce:	4981                	li	s3,0
    17d0:	bbcd                	j	15c2 <vprintf+0x4a>
          s = "(null)";
    17d2:	00000917          	auipc	s2,0x0
    17d6:	34e90913          	add	s2,s2,846 # 1b20 <malloc+0x23a>
        for(; *s; s++)
    17da:	02800593          	li	a1,40
    17de:	b7c5                	j	17be <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
    17e0:	8bce                	mv	s7,s3
      state = 0;
    17e2:	4981                	li	s3,0
    17e4:	bbf9                	j	15c2 <vprintf+0x4a>
    17e6:	64a6                	ld	s1,72(sp)
    17e8:	79e2                	ld	s3,56(sp)
    17ea:	7a42                	ld	s4,48(sp)
    17ec:	7aa2                	ld	s5,40(sp)
    17ee:	7b02                	ld	s6,32(sp)
    17f0:	6be2                	ld	s7,24(sp)
    17f2:	6c42                	ld	s8,16(sp)
    17f4:	6ca2                	ld	s9,8(sp)
    }
  }
}
    17f6:	60e6                	ld	ra,88(sp)
    17f8:	6446                	ld	s0,80(sp)
    17fa:	6906                	ld	s2,64(sp)
    17fc:	6125                	add	sp,sp,96
    17fe:	8082                	ret

0000000000001800 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    1800:	715d                	add	sp,sp,-80
    1802:	ec06                	sd	ra,24(sp)
    1804:	e822                	sd	s0,16(sp)
    1806:	1000                	add	s0,sp,32
    1808:	e010                	sd	a2,0(s0)
    180a:	e414                	sd	a3,8(s0)
    180c:	e818                	sd	a4,16(s0)
    180e:	ec1c                	sd	a5,24(s0)
    1810:	03043023          	sd	a6,32(s0)
    1814:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    1818:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    181c:	8622                	mv	a2,s0
    181e:	d5bff0ef          	jal	1578 <vprintf>
}
    1822:	60e2                	ld	ra,24(sp)
    1824:	6442                	ld	s0,16(sp)
    1826:	6161                	add	sp,sp,80
    1828:	8082                	ret

000000000000182a <printf>:

void
printf(const char *fmt, ...)
{
    182a:	711d                	add	sp,sp,-96
    182c:	ec06                	sd	ra,24(sp)
    182e:	e822                	sd	s0,16(sp)
    1830:	1000                	add	s0,sp,32
    1832:	e40c                	sd	a1,8(s0)
    1834:	e810                	sd	a2,16(s0)
    1836:	ec14                	sd	a3,24(s0)
    1838:	f018                	sd	a4,32(s0)
    183a:	f41c                	sd	a5,40(s0)
    183c:	03043823          	sd	a6,48(s0)
    1840:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    1844:	00840613          	add	a2,s0,8
    1848:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    184c:	85aa                	mv	a1,a0
    184e:	4505                	li	a0,1
    1850:	d29ff0ef          	jal	1578 <vprintf>
}
    1854:	60e2                	ld	ra,24(sp)
    1856:	6442                	ld	s0,16(sp)
    1858:	6125                	add	sp,sp,96
    185a:	8082                	ret

000000000000185c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    185c:	1141                	add	sp,sp,-16
    185e:	e422                	sd	s0,8(sp)
    1860:	0800                	add	s0,sp,16
  Header *bp, *p;

  if(ap == 0)
    1862:	cd3d                	beqz	a0,18e0 <free+0x84>
    return;
  if((uint64)ap < 4096)
    1864:	6785                	lui	a5,0x1
    1866:	06f56d63          	bltu	a0,a5,18e0 <free+0x84>
    return;
  bp = (Header*)ap - 1;
    186a:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    186e:	00000797          	auipc	a5,0x0
    1872:	7b27b783          	ld	a5,1970(a5) # 2020 <freep>
    1876:	a02d                	j	18a0 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    1878:	4618                	lw	a4,8(a2)
    187a:	9f2d                	addw	a4,a4,a1
    187c:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    1880:	6398                	ld	a4,0(a5)
    1882:	6310                	ld	a2,0(a4)
    1884:	a83d                	j	18c2 <free+0x66>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    1886:	ff852703          	lw	a4,-8(a0)
    188a:	9f31                	addw	a4,a4,a2
    188c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    188e:	ff053683          	ld	a3,-16(a0)
    1892:	a091                	j	18d6 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1894:	6398                	ld	a4,0(a5)
    1896:	00e7e463          	bltu	a5,a4,189e <free+0x42>
    189a:	00e6ea63          	bltu	a3,a4,18ae <free+0x52>
{
    189e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    18a0:	fed7fae3          	bgeu	a5,a3,1894 <free+0x38>
    18a4:	6398                	ld	a4,0(a5)
    18a6:	00e6e463          	bltu	a3,a4,18ae <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    18aa:	fee7eae3          	bltu	a5,a4,189e <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
    18ae:	ff852583          	lw	a1,-8(a0)
    18b2:	6390                	ld	a2,0(a5)
    18b4:	02059813          	sll	a6,a1,0x20
    18b8:	01c85713          	srl	a4,a6,0x1c
    18bc:	9736                	add	a4,a4,a3
    18be:	fae60de3          	beq	a2,a4,1878 <free+0x1c>
    bp->s.ptr = p->s.ptr->s.ptr;
    18c2:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    18c6:	4790                	lw	a2,8(a5)
    18c8:	02061593          	sll	a1,a2,0x20
    18cc:	01c5d713          	srl	a4,a1,0x1c
    18d0:	973e                	add	a4,a4,a5
    18d2:	fae68ae3          	beq	a3,a4,1886 <free+0x2a>
    p->s.ptr = bp->s.ptr;
    18d6:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    18d8:	00000717          	auipc	a4,0x0
    18dc:	74f73423          	sd	a5,1864(a4) # 2020 <freep>
}
    18e0:	6422                	ld	s0,8(sp)
    18e2:	0141                	add	sp,sp,16
    18e4:	8082                	ret

00000000000018e6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    18e6:	7139                	add	sp,sp,-64
    18e8:	fc06                	sd	ra,56(sp)
    18ea:	f822                	sd	s0,48(sp)
    18ec:	f426                	sd	s1,40(sp)
    18ee:	ec4e                	sd	s3,24(sp)
    18f0:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    18f2:	02051493          	sll	s1,a0,0x20
    18f6:	9081                	srl	s1,s1,0x20
    18f8:	04bd                	add	s1,s1,15
    18fa:	8091                	srl	s1,s1,0x4
    18fc:	0014899b          	addw	s3,s1,1
    1900:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
    1902:	00000517          	auipc	a0,0x0
    1906:	71e53503          	ld	a0,1822(a0) # 2020 <freep>
    190a:	c915                	beqz	a0,193e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    190c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    190e:	4798                	lw	a4,8(a5)
    1910:	08977a63          	bgeu	a4,s1,19a4 <malloc+0xbe>
    1914:	f04a                	sd	s2,32(sp)
    1916:	e852                	sd	s4,16(sp)
    1918:	e456                	sd	s5,8(sp)
    191a:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    191c:	8a4e                	mv	s4,s3
    191e:	0009871b          	sext.w	a4,s3
    1922:	6685                	lui	a3,0x1
    1924:	00d77363          	bgeu	a4,a3,192a <malloc+0x44>
    1928:	6a05                	lui	s4,0x1
    192a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    192e:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1932:	00000917          	auipc	s2,0x0
    1936:	6ee90913          	add	s2,s2,1774 # 2020 <freep>
  if(p == (char*)-1)
    193a:	5afd                	li	s5,-1
    193c:	a081                	j	197c <malloc+0x96>
    193e:	f04a                	sd	s2,32(sp)
    1940:	e852                	sd	s4,16(sp)
    1942:	e456                	sd	s5,8(sp)
    1944:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    1946:	00001797          	auipc	a5,0x1
    194a:	fea78793          	add	a5,a5,-22 # 2930 <base>
    194e:	00000717          	auipc	a4,0x0
    1952:	6cf73923          	sd	a5,1746(a4) # 2020 <freep>
    1956:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    1958:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    195c:	b7c1                	j	191c <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
    195e:	6398                	ld	a4,0(a5)
    1960:	e118                	sd	a4,0(a0)
    1962:	a8a9                	j	19bc <malloc+0xd6>
  hp->s.size = nu;
    1964:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    1968:	0541                	add	a0,a0,16
    196a:	ef3ff0ef          	jal	185c <free>
  return freep;
    196e:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    1972:	c12d                	beqz	a0,19d4 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1974:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    1976:	4798                	lw	a4,8(a5)
    1978:	02977263          	bgeu	a4,s1,199c <malloc+0xb6>
    if(p == freep)
    197c:	00093703          	ld	a4,0(s2)
    1980:	853e                	mv	a0,a5
    1982:	fef719e3          	bne	a4,a5,1974 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
    1986:	8552                	mv	a0,s4
    1988:	ab9ff0ef          	jal	1440 <sbrk>
  if(p == (char*)-1)
    198c:	fd551ce3          	bne	a0,s5,1964 <malloc+0x7e>
        return 0;
    1990:	4501                	li	a0,0
    1992:	7902                	ld	s2,32(sp)
    1994:	6a42                	ld	s4,16(sp)
    1996:	6aa2                	ld	s5,8(sp)
    1998:	6b02                	ld	s6,0(sp)
    199a:	a03d                	j	19c8 <malloc+0xe2>
    199c:	7902                	ld	s2,32(sp)
    199e:	6a42                	ld	s4,16(sp)
    19a0:	6aa2                	ld	s5,8(sp)
    19a2:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    19a4:	fae48de3          	beq	s1,a4,195e <malloc+0x78>
        p->s.size -= nunits;
    19a8:	4137073b          	subw	a4,a4,s3
    19ac:	c798                	sw	a4,8(a5)
        p += p->s.size;
    19ae:	02071693          	sll	a3,a4,0x20
    19b2:	01c6d713          	srl	a4,a3,0x1c
    19b6:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    19b8:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    19bc:	00000717          	auipc	a4,0x0
    19c0:	66a73223          	sd	a0,1636(a4) # 2020 <freep>
      return (void*)(p + 1);
    19c4:	01078513          	add	a0,a5,16
  }
}
    19c8:	70e2                	ld	ra,56(sp)
    19ca:	7442                	ld	s0,48(sp)
    19cc:	74a2                	ld	s1,40(sp)
    19ce:	69e2                	ld	s3,24(sp)
    19d0:	6121                	add	sp,sp,64
    19d2:	8082                	ret
    19d4:	7902                	ld	s2,32(sp)
    19d6:	6a42                	ld	s4,16(sp)
    19d8:	6aa2                	ld	s5,8(sp)
    19da:	6b02                	ld	s6,0(sp)
    19dc:	b7f5                	j	19c8 <malloc+0xe2>
