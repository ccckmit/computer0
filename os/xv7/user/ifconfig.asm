
user/_ifconfig:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <display>:
#include "kernel/net/socket.h"
#include "kernel/net/if.h"

static void
display(const char *name)
{
       0:	7111                	add	sp,sp,-256
       2:	fd86                	sd	ra,248(sp)
       4:	f9a2                	sd	s0,240(sp)
       6:	f5a6                	sd	s1,232(sp)
       8:	e9d2                	sd	s4,208(sp)
       a:	0200                	add	s0,sp,256
       c:	84aa                	mv	s1,a0
    struct ifreq ifr;
    int fd;
    const char **s, *str[] = {
       e:	00001797          	auipc	a5,0x1
      12:	44278793          	add	a5,a5,1090 # 1450 <malloc+0x40a>
      16:	f0840713          	add	a4,s0,-248
      1a:	00001317          	auipc	t1,0x1
      1e:	4b630313          	add	t1,t1,1206 # 14d0 <malloc+0x48a>
      22:	0007b883          	ld	a7,0(a5)
      26:	0087b803          	ld	a6,8(a5)
      2a:	6b90                	ld	a2,16(a5)
      2c:	6f94                	ld	a3,24(a5)
      2e:	01173023          	sd	a7,0(a4)
      32:	01073423          	sd	a6,8(a4)
      36:	eb10                	sd	a2,16(a4)
      38:	ef14                	sd	a3,24(a4)
      3a:	02078793          	add	a5,a5,32
      3e:	02070713          	add	a4,a4,32
      42:	fe6790e3          	bne	a5,t1,22 <display+0x22>
      46:	639c                	ld	a5,0(a5)
      48:	e31c                	sd	a5,0(a4)
        NULL
    };
    unsigned short mask = 1;
    int any = 0;
    uint8_t *p; 
    fd = socket(AF_INET, SOCK_DGRAM, 0);
      4a:	4601                	li	a2,0
      4c:	4585                	li	a1,1
      4e:	4505                	li	a0,1
      50:	369000ef          	jal	bb8 <socket>
      54:	8a2a                	mv	s4,a0
    if (fd == -1)
      56:	57fd                	li	a5,-1
      58:	12f50863          	beq	a0,a5,188 <display+0x188>
        return;
    // name
    strcpy(ifr.ifr_name, name);
      5c:	85a6                	mv	a1,s1
      5e:	f9040513          	add	a0,s0,-112
      62:	5e2000ef          	jal	644 <strcpy>
    if (ioctl(fd, SIOCGIFFLAGS, &ifr) == -1) {
      66:	f9040613          	add	a2,s0,-112
      6a:	c02075b7          	lui	a1,0xc0207
      6e:	90558593          	add	a1,a1,-1787 # ffffffffc0206905 <base+0xffffffffc02048f5>
      72:	8552                	mv	a0,s4
      74:	38d000ef          	jal	c00 <ioctl>
      78:	57fd                	li	a5,-1
      7a:	04f50963          	beq	a0,a5,cc <display+0xcc>
      7e:	edce                	sd	s3,216(sp)
        close(fd);
        printf("ifconfig: interface %s does not exist\n", name);
        return;
    }
    printf("%s: ", ifr.ifr_name);
      80:	f9040593          	add	a1,s0,-112
      84:	00001517          	auipc	a0,0x1
      88:	0ec50513          	add	a0,a0,236 # 1170 <malloc+0x12a>
      8c:	6ff000ef          	jal	f8a <printf>
    // flags
    printf("flags=%x<", ifr.ifr_flags);
      90:	fa041583          	lh	a1,-96(s0)
      94:	00001517          	auipc	a0,0x1
      98:	0e450513          	add	a0,a0,228 # 1178 <malloc+0x132>
      9c:	6ef000ef          	jal	f8a <printf>
    for (s = str; *s; s++) {
      a0:	f0843983          	ld	s3,-248(s0)
      a4:	06098a63          	beqz	s3,118 <display+0x118>
      a8:	f1ca                	sd	s2,224(sp)
      aa:	e5d6                	sd	s5,200(sp)
      ac:	e1da                	sd	s6,192(sp)
      ae:	fd5e                	sd	s7,184(sp)
    int any = 0;
      b0:	4701                	li	a4,0
    unsigned short mask = 1;
      b2:	4485                	li	s1,1
    for (s = str; *s; s++) {
      b4:	f0840913          	add	s2,s0,-248
        if (ifr.ifr_flags & mask) {
            if (any)
                printf("|");
            any = 1;
            printf("%s", *s);
      b8:	00001b17          	auipc	s6,0x1
      bc:	0d8b0b13          	add	s6,s6,216 # 1190 <malloc+0x14a>
            any = 1;
      c0:	4a85                	li	s5,1
                printf("|");
      c2:	00001b97          	auipc	s7,0x1
      c6:	0c6b8b93          	add	s7,s7,198 # 1188 <malloc+0x142>
      ca:	a815                	j	fe <display+0xfe>
        close(fd);
      cc:	8552                	mv	a0,s4
      ce:	273000ef          	jal	b40 <close>
        printf("ifconfig: interface %s does not exist\n", name);
      d2:	85a6                	mv	a1,s1
      d4:	00001517          	auipc	a0,0x1
      d8:	06c50513          	add	a0,a0,108 # 1140 <malloc+0xfa>
      dc:	6af000ef          	jal	f8a <printf>
        return;
      e0:	a065                	j	188 <display+0x188>
            printf("%s", *s);
      e2:	85ce                	mv	a1,s3
      e4:	855a                	mv	a0,s6
      e6:	6a5000ef          	jal	f8a <printf>
            any = 1;
      ea:	8756                	mv	a4,s5
        }
        mask <<= 1;
      ec:	0014949b          	sllw	s1,s1,0x1
      f0:	14c2                	sll	s1,s1,0x30
      f2:	90c1                	srl	s1,s1,0x30
    for (s = str; *s; s++) {
      f4:	0921                	add	s2,s2,8
      f6:	00093983          	ld	s3,0(s2)
      fa:	00098b63          	beqz	s3,110 <display+0x110>
        if (ifr.ifr_flags & mask) {
      fe:	fa041783          	lh	a5,-96(s0)
     102:	8fe5                	and	a5,a5,s1
     104:	d7e5                	beqz	a5,ec <display+0xec>
            if (any)
     106:	df71                	beqz	a4,e2 <display+0xe2>
                printf("|");
     108:	855e                	mv	a0,s7
     10a:	681000ef          	jal	f8a <printf>
     10e:	bfd1                	j	e2 <display+0xe2>
     110:	790e                	ld	s2,224(sp)
     112:	6aae                	ld	s5,200(sp)
     114:	6b0e                	ld	s6,192(sp)
     116:	7bea                	ld	s7,184(sp)
    }
    printf(">");
     118:	00001517          	auipc	a0,0x1
     11c:	08050513          	add	a0,a0,128 # 1198 <malloc+0x152>
     120:	66b000ef          	jal	f8a <printf>
    // mtu
    ifr.ifr_mtu = 1500;
     124:	5dc00793          	li	a5,1500
     128:	faf42023          	sw	a5,-96(s0)
    if (ioctl(fd, SIOCGIFMTU, &ifr) == -1)
     12c:	f9040613          	add	a2,s0,-112
     130:	c02075b7          	lui	a1,0xc0207
     134:	90d58593          	add	a1,a1,-1779 # ffffffffc020690d <base+0xffffffffc02048fd>
     138:	8552                	mv	a0,s4
     13a:	2c7000ef          	jal	c00 <ioctl>
        ;//ifr.ifr_mtu = 0;
    printf(" mtu %d\n", ifr.ifr_mtu);
     13e:	fa042583          	lw	a1,-96(s0)
     142:	00001517          	auipc	a0,0x1
     146:	05e50513          	add	a0,a0,94 # 11a0 <malloc+0x15a>
     14a:	641000ef          	jal	f8a <printf>
    // hwaddr
    if (ioctl(fd, SIOCGIFHWADDR, &ifr) == 0) {
     14e:	f9040613          	add	a2,s0,-112
     152:	c02075b7          	lui	a1,0xc0207
     156:	90358593          	add	a1,a1,-1789 # ffffffffc0206903 <base+0xffffffffc02048f3>
     15a:	8552                	mv	a0,s4
     15c:	2a5000ef          	jal	c00 <ioctl>
     160:	c915                	beqz	a0,194 <display+0x194>
        p = (uint8_t *)ifr.ifr_hwaddr.sa_data;
        printf("  ether %x:%x:%x:%x:%x:%x\n", p[0], p[1], p[2], p[3], p[4], p[5]);
    }
    do {
        // addr
        ifr.ifr_addr.sa_family = AF_INET;
     162:	4785                	li	a5,1
     164:	faf41023          	sh	a5,-96(s0)
        if (ioctl(fd, SIOCGIFADDR, &ifr) == -1)
     168:	f9040613          	add	a2,s0,-112
     16c:	c02075b7          	lui	a1,0xc0207
     170:	90758593          	add	a1,a1,-1785 # ffffffffc0206907 <base+0xffffffffc02048f7>
     174:	8552                	mv	a0,s4
     176:	28b000ef          	jal	c00 <ioctl>
     17a:	57fd                	li	a5,-1
     17c:	02f51f63          	bne	a0,a5,1ba <display+0x1ba>
        if (ioctl(fd, SIOCGIFBRDADDR, &ifr) == -1)
            break;
        p = (uint8_t *)&((struct sockaddr_in *)&ifr.ifr_broadaddr)->sin_addr;
        printf(" broadcast %d.%d.%d.%d\n", p[0], p[1], p[2], p[3]);
    } while(0);
    close(fd);
     180:	8552                	mv	a0,s4
     182:	1bf000ef          	jal	b40 <close>
     186:	69ee                	ld	s3,216(sp)
}
     188:	70ee                	ld	ra,248(sp)
     18a:	744e                	ld	s0,240(sp)
     18c:	74ae                	ld	s1,232(sp)
     18e:	6a4e                	ld	s4,208(sp)
     190:	6111                	add	sp,sp,256
     192:	8082                	ret
        printf("  ether %x:%x:%x:%x:%x:%x\n", p[0], p[1], p[2], p[3], p[4], p[5]);
     194:	fa744803          	lbu	a6,-89(s0)
     198:	fa644783          	lbu	a5,-90(s0)
     19c:	fa544703          	lbu	a4,-91(s0)
     1a0:	fa444683          	lbu	a3,-92(s0)
     1a4:	fa344603          	lbu	a2,-93(s0)
     1a8:	fa244583          	lbu	a1,-94(s0)
     1ac:	00001517          	auipc	a0,0x1
     1b0:	00450513          	add	a0,a0,4 # 11b0 <malloc+0x16a>
     1b4:	5d7000ef          	jal	f8a <printf>
     1b8:	b76d                	j	162 <display+0x162>
        printf("  inet %d.%d.%d.%d", p[0], p[1], p[2], p[3]);
     1ba:	fa744703          	lbu	a4,-89(s0)
     1be:	fa644683          	lbu	a3,-90(s0)
     1c2:	fa544603          	lbu	a2,-91(s0)
     1c6:	fa444583          	lbu	a1,-92(s0)
     1ca:	00001517          	auipc	a0,0x1
     1ce:	00650513          	add	a0,a0,6 # 11d0 <malloc+0x18a>
     1d2:	5b9000ef          	jal	f8a <printf>
        ifr.ifr_netmask.sa_family = AF_INET;
     1d6:	4785                	li	a5,1
     1d8:	faf41023          	sh	a5,-96(s0)
        if (ioctl(fd, SIOCGIFNETMASK, &ifr) == -1)
     1dc:	f9040613          	add	a2,s0,-112
     1e0:	c02075b7          	lui	a1,0xc0207
     1e4:	90958593          	add	a1,a1,-1783 # ffffffffc0206909 <base+0xffffffffc02048f9>
     1e8:	8552                	mv	a0,s4
     1ea:	217000ef          	jal	c00 <ioctl>
     1ee:	57fd                	li	a5,-1
     1f0:	f8f508e3          	beq	a0,a5,180 <display+0x180>
        printf(" netmask %d.%d.%d.%d", p[0], p[1], p[2], p[3]);
     1f4:	fa744703          	lbu	a4,-89(s0)
     1f8:	fa644683          	lbu	a3,-90(s0)
     1fc:	fa544603          	lbu	a2,-91(s0)
     200:	fa444583          	lbu	a1,-92(s0)
     204:	00001517          	auipc	a0,0x1
     208:	fe450513          	add	a0,a0,-28 # 11e8 <malloc+0x1a2>
     20c:	57f000ef          	jal	f8a <printf>
        ifr.ifr_broadaddr.sa_family = AF_INET;
     210:	4785                	li	a5,1
     212:	faf41023          	sh	a5,-96(s0)
        if (ioctl(fd, SIOCGIFBRDADDR, &ifr) == -1)
     216:	f9040613          	add	a2,s0,-112
     21a:	c02075b7          	lui	a1,0xc0207
     21e:	90b58593          	add	a1,a1,-1781 # ffffffffc020690b <base+0xffffffffc02048fb>
     222:	8552                	mv	a0,s4
     224:	1dd000ef          	jal	c00 <ioctl>
     228:	57fd                	li	a5,-1
     22a:	f4f50be3          	beq	a0,a5,180 <display+0x180>
        printf(" broadcast %d.%d.%d.%d\n", p[0], p[1], p[2], p[3]);
     22e:	fa744703          	lbu	a4,-89(s0)
     232:	fa644683          	lbu	a3,-90(s0)
     236:	fa544603          	lbu	a2,-91(s0)
     23a:	fa444583          	lbu	a1,-92(s0)
     23e:	00001517          	auipc	a0,0x1
     242:	fc250513          	add	a0,a0,-62 # 1200 <malloc+0x1ba>
     246:	545000ef          	jal	f8a <printf>
     24a:	bf1d                	j	180 <display+0x180>

000000000000024c <display_all>:

static void
display_all(void)
{
     24c:	715d                	add	sp,sp,-80
     24e:	e486                	sd	ra,72(sp)
     250:	e0a2                	sd	s0,64(sp)
     252:	fc26                	sd	s1,56(sp)
     254:	f84a                	sd	s2,48(sp)
     256:	f44e                	sd	s3,40(sp)
     258:	0880                	add	s0,sp,80
    int fd;
    struct ifreq ifr = {.ifr_ifindex = 0};
     25a:	fa043823          	sd	zero,-80(s0)
     25e:	fa043c23          	sd	zero,-72(s0)
     262:	fc043023          	sd	zero,-64(s0)
     266:	fc043423          	sd	zero,-56(s0)

    fd = socket(AF_INET, SOCK_DGRAM, 0);
     26a:	4601                	li	a2,0
     26c:	4585                	li	a1,1
     26e:	4505                	li	a0,1
     270:	149000ef          	jal	bb8 <socket>
    if (fd == -1) {
     274:	57fd                	li	a5,-1
     276:	00f50963          	beq	a0,a5,288 <display_all+0x3c>
     27a:	84aa                	mv	s1,a0
        exit(-1);
    }
    while (1) {
        if (ioctl(fd, SIOCGIFNAME, &ifr) == -1)
     27c:	c0207937          	lui	s2,0xc0207
     280:	90190913          	add	s2,s2,-1791 # ffffffffc0206901 <base+0xffffffffc02048f1>
     284:	59fd                	li	s3,-1
     286:	a829                	j	2a0 <display_all+0x54>
        exit(-1);
     288:	557d                	li	a0,-1
     28a:	08f000ef          	jal	b18 <exit>
            break;
        display(ifr.ifr_name);
     28e:	fb040513          	add	a0,s0,-80
     292:	d6fff0ef          	jal	0 <display>
        ifr.ifr_ifindex++;
     296:	fc042783          	lw	a5,-64(s0)
     29a:	2785                	addw	a5,a5,1
     29c:	fcf42023          	sw	a5,-64(s0)
        if (ioctl(fd, SIOCGIFNAME, &ifr) == -1)
     2a0:	fb040613          	add	a2,s0,-80
     2a4:	85ca                	mv	a1,s2
     2a6:	8526                	mv	a0,s1
     2a8:	159000ef          	jal	c00 <ioctl>
     2ac:	ff3511e3          	bne	a0,s3,28e <display_all+0x42>
    }
    close(fd);
     2b0:	8526                	mv	a0,s1
     2b2:	08f000ef          	jal	b40 <close>
}
     2b6:	60a6                	ld	ra,72(sp)
     2b8:	6406                	ld	s0,64(sp)
     2ba:	74e2                	ld	s1,56(sp)
     2bc:	7942                	ld	s2,48(sp)
     2be:	79a2                	ld	s3,40(sp)
     2c0:	6161                	add	sp,sp,80
     2c2:	8082                	ret

00000000000002c4 <ifset>:
    close(fd);
}

static void
ifset(const char *name, uint32_t addr, uint32_t netmask)
{
     2c4:	715d                	add	sp,sp,-80
     2c6:	e486                	sd	ra,72(sp)
     2c8:	e0a2                	sd	s0,64(sp)
     2ca:	f84a                	sd	s2,48(sp)
     2cc:	f44e                	sd	s3,40(sp)
     2ce:	f052                	sd	s4,32(sp)
     2d0:	0880                	add	s0,sp,80
     2d2:	8a2a                	mv	s4,a0
     2d4:	892e                	mv	s2,a1
     2d6:	89b2                	mv	s3,a2
    int fd;
    struct ifreq ifr;

    fd = socket(AF_INET, SOCK_DGRAM, 0);
     2d8:	4601                	li	a2,0
     2da:	4585                	li	a1,1
     2dc:	4505                	li	a0,1
     2de:	0db000ef          	jal	bb8 <socket>
    if (fd == -1)
     2e2:	57fd                	li	a5,-1
     2e4:	04f50f63          	beq	a0,a5,342 <ifset+0x7e>
     2e8:	fc26                	sd	s1,56(sp)
     2ea:	84aa                	mv	s1,a0
        return;
    strcpy(ifr.ifr_name, name); 
     2ec:	85d2                	mv	a1,s4
     2ee:	fb040513          	add	a0,s0,-80
     2f2:	352000ef          	jal	644 <strcpy>
    ifr.ifr_addr.sa_family = AF_INET;
     2f6:	4785                	li	a5,1
     2f8:	fcf41023          	sh	a5,-64(s0)
    ((struct sockaddr_in *)&ifr.ifr_addr)->sin_addr.s_addr = addr;
     2fc:	fd242223          	sw	s2,-60(s0)
    if (ioctl(fd, SIOCSIFADDR, &ifr) == -1) {
     300:	fb040613          	add	a2,s0,-80
     304:	802075b7          	lui	a1,0x80207
     308:	90858593          	add	a1,a1,-1784 # ffffffff80206908 <base+0xffffffff802048f8>
     30c:	8526                	mv	a0,s1
     30e:	0f3000ef          	jal	c00 <ioctl>
     312:	57fd                	li	a5,-1
     314:	02f50e63          	beq	a0,a5,350 <ifset+0x8c>
        close(fd);
        printf("ifconfig: ioctl(SIOCSIFADDR) failure, interface=%s\n", name);
        return;
    }
    ifr.ifr_netmask.sa_family = AF_INET;
     318:	4785                	li	a5,1
     31a:	fcf41023          	sh	a5,-64(s0)
    ((struct sockaddr_in *)&ifr.ifr_netmask)->sin_addr.s_addr = netmask;
     31e:	fd342223          	sw	s3,-60(s0)
    if (ioctl(fd, SIOCSIFNETMASK, &ifr) == -1) {
     322:	fb040613          	add	a2,s0,-80
     326:	802075b7          	lui	a1,0x80207
     32a:	90a58593          	add	a1,a1,-1782 # ffffffff8020690a <base+0xffffffff802048fa>
     32e:	8526                	mv	a0,s1
     330:	0d1000ef          	jal	c00 <ioctl>
     334:	57fd                	li	a5,-1
     336:	02f50963          	beq	a0,a5,368 <ifset+0xa4>
        close(fd);
        printf("ifconfig: ioctl(SIOCSIFNETMASK) failure, interface=%s\n", name);
        return;
    }
    close(fd);
     33a:	8526                	mv	a0,s1
     33c:	005000ef          	jal	b40 <close>
     340:	74e2                	ld	s1,56(sp)
}
     342:	60a6                	ld	ra,72(sp)
     344:	6406                	ld	s0,64(sp)
     346:	7942                	ld	s2,48(sp)
     348:	79a2                	ld	s3,40(sp)
     34a:	7a02                	ld	s4,32(sp)
     34c:	6161                	add	sp,sp,80
     34e:	8082                	ret
        close(fd);
     350:	8526                	mv	a0,s1
     352:	7ee000ef          	jal	b40 <close>
        printf("ifconfig: ioctl(SIOCSIFADDR) failure, interface=%s\n", name);
     356:	85d2                	mv	a1,s4
     358:	00001517          	auipc	a0,0x1
     35c:	ec050513          	add	a0,a0,-320 # 1218 <malloc+0x1d2>
     360:	42b000ef          	jal	f8a <printf>
        return;
     364:	74e2                	ld	s1,56(sp)
     366:	bff1                	j	342 <ifset+0x7e>
        close(fd);
     368:	8526                	mv	a0,s1
     36a:	7d6000ef          	jal	b40 <close>
        printf("ifconfig: ioctl(SIOCSIFNETMASK) failure, interface=%s\n", name);
     36e:	85d2                	mv	a1,s4
     370:	00001517          	auipc	a0,0x1
     374:	ee050513          	add	a0,a0,-288 # 1250 <malloc+0x20a>
     378:	413000ef          	jal	f8a <printf>
        return;
     37c:	74e2                	ld	s1,56(sp)
     37e:	b7d1                	j	342 <ifset+0x7e>

0000000000000380 <usage>:

static void
usage(void)
{
     380:	1141                	add	sp,sp,-16
     382:	e406                	sd	ra,8(sp)
     384:	e022                	sd	s0,0(sp)
     386:	0800                	add	s0,sp,16
    printf("usage: ifconfig interface [command|address]\n");
     388:	00001517          	auipc	a0,0x1
     38c:	f0050513          	add	a0,a0,-256 # 1288 <malloc+0x242>
     390:	3fb000ef          	jal	f8a <printf>
    printf("           - command: up | down\n");
     394:	00001517          	auipc	a0,0x1
     398:	f2450513          	add	a0,a0,-220 # 12b8 <malloc+0x272>
     39c:	3ef000ef          	jal	f8a <printf>
    printf("           - address: ADDRESS/PREFIX | ADDRESS netmask NETMASK\n");
     3a0:	00001517          	auipc	a0,0x1
     3a4:	f4050513          	add	a0,a0,-192 # 12e0 <malloc+0x29a>
     3a8:	3e3000ef          	jal	f8a <printf>
    printf("       ifconfig [-a]\n");
     3ac:	00001517          	auipc	a0,0x1
     3b0:	f7450513          	add	a0,a0,-140 # 1320 <malloc+0x2da>
     3b4:	3d7000ef          	jal	f8a <printf>
    exit(-1);
     3b8:	557d                	li	a0,-1
     3ba:	75e000ef          	jal	b18 <exit>

00000000000003be <main>:
}

int
main(int argc, char *argv[])
{
     3be:	715d                	add	sp,sp,-80
     3c0:	e486                	sd	ra,72(sp)
     3c2:	e0a2                	sd	s0,64(sp)
     3c4:	0880                	add	s0,sp,80
    char *s;
    uint32_t addr, netmask;
    int prefix = 0;

    if (argc == 1) {
     3c6:	4785                	li	a5,1
     3c8:	02f50063          	beq	a0,a5,3e8 <main+0x2a>
     3cc:	fc26                	sd	s1,56(sp)
     3ce:	84ae                	mv	s1,a1
        display_all();
        exit(0);
    }
    if (argc == 2) {
     3d0:	4789                	li	a5,2
     3d2:	02f50263          	beq	a0,a5,3f6 <main+0x38>
            display_all();
        else
            display(argv[1]);
        exit(0);
    }
    if (argc == 3) {
     3d6:	478d                	li	a5,3
     3d8:	04f50263          	beq	a0,a5,41c <main+0x5e>
            usage();
        netmask = htonl(0xffffffff << (32 - prefix));
        ifset(argv[1], addr, netmask);
        exit(0);
    }
    if (argc == 5) {
     3dc:	4795                	li	a5,5
     3de:	1ef50c63          	beq	a0,a5,5d6 <main+0x218>
     3e2:	f84a                	sd	s2,48(sp)
        if (inet_pton(AF_INET, argv[4], (struct in_addr *)&netmask) == -1)
            usage();
        ifset(argv[1], addr, netmask);
        exit(0);
    }
    usage();
     3e4:	f9dff0ef          	jal	380 <usage>
     3e8:	fc26                	sd	s1,56(sp)
     3ea:	f84a                	sd	s2,48(sp)
        display_all();
     3ec:	e61ff0ef          	jal	24c <display_all>
        exit(0);
     3f0:	4501                	li	a0,0
     3f2:	726000ef          	jal	b18 <exit>
     3f6:	f84a                	sd	s2,48(sp)
        if (strcmp(argv[1], "-a") == 0)
     3f8:	6584                	ld	s1,8(a1)
     3fa:	00001597          	auipc	a1,0x1
     3fe:	f3e58593          	add	a1,a1,-194 # 1338 <malloc+0x2f2>
     402:	8526                	mv	a0,s1
     404:	25c000ef          	jal	660 <strcmp>
     408:	e511                	bnez	a0,414 <main+0x56>
            display_all();
     40a:	e43ff0ef          	jal	24c <display_all>
        exit(0);
     40e:	4501                	li	a0,0
     410:	708000ef          	jal	b18 <exit>
            display(argv[1]);
     414:	8526                	mv	a0,s1
     416:	bebff0ef          	jal	0 <display>
     41a:	bfd5                	j	40e <main+0x50>
     41c:	f84a                	sd	s2,48(sp)
        if (strcmp(argv[2], "up") == 0) {
     41e:	0105b903          	ld	s2,16(a1)
     422:	00001597          	auipc	a1,0x1
     426:	f1e58593          	add	a1,a1,-226 # 1340 <malloc+0x2fa>
     42a:	854a                	mv	a0,s2
     42c:	234000ef          	jal	660 <strcmp>
     430:	cd2d                	beqz	a0,4aa <main+0xec>
        if (strcmp(argv[2], "down") == 0) {
     432:	00001597          	auipc	a1,0x1
     436:	f4e58593          	add	a1,a1,-178 # 1380 <malloc+0x33a>
     43a:	854a                	mv	a0,s2
     43c:	224000ef          	jal	660 <strcmp>
     440:	12051563          	bnez	a0,56a <main+0x1ac>
            ifdown(argv[1]);
     444:	0084b903          	ld	s2,8(s1)
    fd = socket(AF_INET, SOCK_DGRAM, 0);
     448:	4601                	li	a2,0
     44a:	4585                	li	a1,1
     44c:	4505                	li	a0,1
     44e:	76a000ef          	jal	bb8 <socket>
     452:	84aa                	mv	s1,a0
    if (fd == -1)
     454:	57fd                	li	a5,-1
     456:	04f50763          	beq	a0,a5,4a4 <main+0xe6>
    strcpy(ifr.ifr_name, name);
     45a:	85ca                	mv	a1,s2
     45c:	fb840513          	add	a0,s0,-72
     460:	1e4000ef          	jal	644 <strcpy>
    if (ioctl(fd, SIOCGIFFLAGS, &ifr) == -1) {
     464:	fb840613          	add	a2,s0,-72
     468:	c02075b7          	lui	a1,0xc0207
     46c:	90558593          	add	a1,a1,-1787 # ffffffffc0206905 <base+0xffffffffc02048f5>
     470:	8526                	mv	a0,s1
     472:	78e000ef          	jal	c00 <ioctl>
     476:	57fd                	li	a5,-1
     478:	0cf50363          	beq	a0,a5,53e <main+0x180>
    ifr.ifr_flags &= ~IFF_UP;
     47c:	fc845783          	lhu	a5,-56(s0)
     480:	9bf9                	and	a5,a5,-2
     482:	fcf41423          	sh	a5,-56(s0)
    if (ioctl(fd, SIOCSIFFLAGS, &ifr) == -1) {
     486:	fb840613          	add	a2,s0,-72
     48a:	802075b7          	lui	a1,0x80207
     48e:	90658593          	add	a1,a1,-1786 # ffffffff80206906 <base+0xffffffff802048f6>
     492:	8526                	mv	a0,s1
     494:	76c000ef          	jal	c00 <ioctl>
     498:	57fd                	li	a5,-1
     49a:	0af50d63          	beq	a0,a5,554 <main+0x196>
    close(fd);
     49e:	8526                	mv	a0,s1
     4a0:	6a0000ef          	jal	b40 <close>
            exit(0);
     4a4:	4501                	li	a0,0
     4a6:	672000ef          	jal	b18 <exit>
            ifup(argv[1]);
     4aa:	0084b903          	ld	s2,8(s1)
    fd = socket(AF_INET, SOCK_DGRAM, 0);
     4ae:	4601                	li	a2,0
     4b0:	4585                	li	a1,1
     4b2:	4505                	li	a0,1
     4b4:	704000ef          	jal	bb8 <socket>
     4b8:	84aa                	mv	s1,a0
    if (fd == -1)
     4ba:	57fd                	li	a5,-1
     4bc:	04f50863          	beq	a0,a5,50c <main+0x14e>
    strcpy(ifr.ifr_name, name);
     4c0:	85ca                	mv	a1,s2
     4c2:	fb840513          	add	a0,s0,-72
     4c6:	17e000ef          	jal	644 <strcpy>
    if (ioctl(fd, SIOCGIFFLAGS, &ifr) == -1) {
     4ca:	fb840613          	add	a2,s0,-72
     4ce:	c02075b7          	lui	a1,0xc0207
     4d2:	90558593          	add	a1,a1,-1787 # ffffffffc0206905 <base+0xffffffffc02048f5>
     4d6:	8526                	mv	a0,s1
     4d8:	728000ef          	jal	c00 <ioctl>
     4dc:	57fd                	li	a5,-1
     4de:	02f50a63          	beq	a0,a5,512 <main+0x154>
    ifr.ifr_flags |= IFF_UP;
     4e2:	fc845783          	lhu	a5,-56(s0)
     4e6:	0017e793          	or	a5,a5,1
     4ea:	fcf41423          	sh	a5,-56(s0)
    if (ioctl(fd, SIOCSIFFLAGS, &ifr) == -1) {
     4ee:	fb840613          	add	a2,s0,-72
     4f2:	802075b7          	lui	a1,0x80207
     4f6:	90658593          	add	a1,a1,-1786 # ffffffff80206906 <base+0xffffffff802048f6>
     4fa:	8526                	mv	a0,s1
     4fc:	704000ef          	jal	c00 <ioctl>
     500:	57fd                	li	a5,-1
     502:	02f50363          	beq	a0,a5,528 <main+0x16a>
    close(fd);
     506:	8526                	mv	a0,s1
     508:	638000ef          	jal	b40 <close>
            exit(0);
     50c:	4501                	li	a0,0
     50e:	60a000ef          	jal	b18 <exit>
        close(fd);
     512:	8526                	mv	a0,s1
     514:	62c000ef          	jal	b40 <close>
        printf("ifconfig: interface %s does not exist\n", name);
     518:	85ca                	mv	a1,s2
     51a:	00001517          	auipc	a0,0x1
     51e:	c2650513          	add	a0,a0,-986 # 1140 <malloc+0xfa>
     522:	269000ef          	jal	f8a <printf>
        return;
     526:	b7dd                	j	50c <main+0x14e>
        close(fd);
     528:	8526                	mv	a0,s1
     52a:	616000ef          	jal	b40 <close>
        printf("ifconfig: ioctl(SIOCSIFFLAGS) failure, interface=%s\n", name);
     52e:	85ca                	mv	a1,s2
     530:	00001517          	auipc	a0,0x1
     534:	e1850513          	add	a0,a0,-488 # 1348 <malloc+0x302>
     538:	253000ef          	jal	f8a <printf>
        return;
     53c:	bfc1                	j	50c <main+0x14e>
        close(fd);
     53e:	8526                	mv	a0,s1
     540:	600000ef          	jal	b40 <close>
        printf("ifconfig: interface %s does not exist\n", name);
     544:	85ca                	mv	a1,s2
     546:	00001517          	auipc	a0,0x1
     54a:	bfa50513          	add	a0,a0,-1030 # 1140 <malloc+0xfa>
     54e:	23d000ef          	jal	f8a <printf>
        return;
     552:	bf89                	j	4a4 <main+0xe6>
        close(fd);
     554:	8526                	mv	a0,s1
     556:	5ea000ef          	jal	b40 <close>
        printf("ifconfig: ioctl(SIOCSIFFLAGS) failure, interface=%s\n", name);
     55a:	85ca                	mv	a1,s2
     55c:	00001517          	auipc	a0,0x1
     560:	dec50513          	add	a0,a0,-532 # 1348 <malloc+0x302>
     564:	227000ef          	jal	f8a <printf>
        return;
     568:	bf35                	j	4a4 <main+0xe6>
        s = strchr(argv[2], '/');
     56a:	02f00593          	li	a1,47
     56e:	854a                	mv	a0,s2
     570:	168000ef          	jal	6d8 <strchr>
     574:	892a                	mv	s2,a0
        if (!s)
     576:	c905                	beqz	a0,5a6 <main+0x1e8>
        *s++ = 0;
     578:	00050023          	sb	zero,0(a0)
        if (inet_pton(AF_INET, argv[2], (struct in_addr *)&addr) == -1)
     57c:	fdc40613          	add	a2,s0,-36
     580:	688c                	ld	a1,16(s1)
     582:	4505                	li	a0,1
     584:	4fa000ef          	jal	a7e <inet_pton>
     588:	57fd                	li	a5,-1
     58a:	02f50063          	beq	a0,a5,5aa <main+0x1ec>
        prefix = atoi(s);
     58e:	00190513          	add	a0,s2,1
     592:	214000ef          	jal	7a6 <atoi>
        if (prefix < 0 || prefix > 32)
     596:	0005071b          	sext.w	a4,a0
     59a:	02000793          	li	a5,32
     59e:	00e7f863          	bgeu	a5,a4,5ae <main+0x1f0>
            usage();
     5a2:	ddfff0ef          	jal	380 <usage>
            usage();
     5a6:	ddbff0ef          	jal	380 <usage>
            usage();
     5aa:	dd7ff0ef          	jal	380 <usage>
        netmask = htonl(0xffffffff << (32 - prefix));
     5ae:	02000793          	li	a5,32
     5b2:	9f89                	subw	a5,a5,a0
     5b4:	557d                	li	a0,-1
     5b6:	00f5153b          	sllw	a0,a0,a5
     5ba:	352000ef          	jal	90c <htonl>
     5be:	0005061b          	sext.w	a2,a0
     5c2:	fcc42c23          	sw	a2,-40(s0)
        ifset(argv[1], addr, netmask);
     5c6:	fdc42583          	lw	a1,-36(s0)
     5ca:	6488                	ld	a0,8(s1)
     5cc:	cf9ff0ef          	jal	2c4 <ifset>
        exit(0);
     5d0:	4501                	li	a0,0
     5d2:	546000ef          	jal	b18 <exit>
        if (inet_pton(AF_INET, argv[2], (struct in_addr *)&addr) == -1)
     5d6:	fdc40613          	add	a2,s0,-36
     5da:	698c                	ld	a1,16(a1)
     5dc:	4505                	li	a0,1
     5de:	4a0000ef          	jal	a7e <inet_pton>
     5e2:	57fd                	li	a5,-1
     5e4:	00f50d63          	beq	a0,a5,5fe <main+0x240>
        if (strcmp(argv[3], "netmask") != 0)
     5e8:	00001597          	auipc	a1,0x1
     5ec:	da058593          	add	a1,a1,-608 # 1388 <malloc+0x342>
     5f0:	6c88                	ld	a0,24(s1)
     5f2:	06e000ef          	jal	660 <strcmp>
     5f6:	c519                	beqz	a0,604 <main+0x246>
     5f8:	f84a                	sd	s2,48(sp)
            usage();
     5fa:	d87ff0ef          	jal	380 <usage>
     5fe:	f84a                	sd	s2,48(sp)
            usage();
     600:	d81ff0ef          	jal	380 <usage>
        if (inet_pton(AF_INET, argv[4], (struct in_addr *)&netmask) == -1)
     604:	fd840613          	add	a2,s0,-40
     608:	708c                	ld	a1,32(s1)
     60a:	4505                	li	a0,1
     60c:	472000ef          	jal	a7e <inet_pton>
     610:	57fd                	li	a5,-1
     612:	00f50d63          	beq	a0,a5,62c <main+0x26e>
     616:	f84a                	sd	s2,48(sp)
        ifset(argv[1], addr, netmask);
     618:	fd842603          	lw	a2,-40(s0)
     61c:	fdc42583          	lw	a1,-36(s0)
     620:	6488                	ld	a0,8(s1)
     622:	ca3ff0ef          	jal	2c4 <ifset>
        exit(0);
     626:	4501                	li	a0,0
     628:	4f0000ef          	jal	b18 <exit>
     62c:	f84a                	sd	s2,48(sp)
            usage();
     62e:	d53ff0ef          	jal	380 <usage>

0000000000000632 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
     632:	1141                	add	sp,sp,-16
     634:	e406                	sd	ra,8(sp)
     636:	e022                	sd	s0,0(sp)
     638:	0800                	add	s0,sp,16
  extern int main();
  main();
     63a:	d85ff0ef          	jal	3be <main>
  exit(0);
     63e:	4501                	li	a0,0
     640:	4d8000ef          	jal	b18 <exit>

0000000000000644 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     644:	1141                	add	sp,sp,-16
     646:	e422                	sd	s0,8(sp)
     648:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     64a:	87aa                	mv	a5,a0
     64c:	0585                	add	a1,a1,1
     64e:	0785                	add	a5,a5,1
     650:	fff5c703          	lbu	a4,-1(a1)
     654:	fee78fa3          	sb	a4,-1(a5)
     658:	fb75                	bnez	a4,64c <strcpy+0x8>
    ;
  return os;
}
     65a:	6422                	ld	s0,8(sp)
     65c:	0141                	add	sp,sp,16
     65e:	8082                	ret

0000000000000660 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     660:	1141                	add	sp,sp,-16
     662:	e422                	sd	s0,8(sp)
     664:	0800                	add	s0,sp,16
  while(*p && *p == *q)
     666:	00054783          	lbu	a5,0(a0)
     66a:	cb91                	beqz	a5,67e <strcmp+0x1e>
     66c:	0005c703          	lbu	a4,0(a1)
     670:	00f71763          	bne	a4,a5,67e <strcmp+0x1e>
    p++, q++;
     674:	0505                	add	a0,a0,1
     676:	0585                	add	a1,a1,1
  while(*p && *p == *q)
     678:	00054783          	lbu	a5,0(a0)
     67c:	fbe5                	bnez	a5,66c <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     67e:	0005c503          	lbu	a0,0(a1)
}
     682:	40a7853b          	subw	a0,a5,a0
     686:	6422                	ld	s0,8(sp)
     688:	0141                	add	sp,sp,16
     68a:	8082                	ret

000000000000068c <strlen>:

uint
strlen(const char *s)
{
     68c:	1141                	add	sp,sp,-16
     68e:	e422                	sd	s0,8(sp)
     690:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     692:	00054783          	lbu	a5,0(a0)
     696:	cf91                	beqz	a5,6b2 <strlen+0x26>
     698:	0505                	add	a0,a0,1
     69a:	87aa                	mv	a5,a0
     69c:	86be                	mv	a3,a5
     69e:	0785                	add	a5,a5,1
     6a0:	fff7c703          	lbu	a4,-1(a5)
     6a4:	ff65                	bnez	a4,69c <strlen+0x10>
     6a6:	40a6853b          	subw	a0,a3,a0
     6aa:	2505                	addw	a0,a0,1
    ;
  return n;
}
     6ac:	6422                	ld	s0,8(sp)
     6ae:	0141                	add	sp,sp,16
     6b0:	8082                	ret
  for(n = 0; s[n]; n++)
     6b2:	4501                	li	a0,0
     6b4:	bfe5                	j	6ac <strlen+0x20>

00000000000006b6 <memset>:

void*
memset(void *dst, int c, uint n)
{
     6b6:	1141                	add	sp,sp,-16
     6b8:	e422                	sd	s0,8(sp)
     6ba:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     6bc:	ca19                	beqz	a2,6d2 <memset+0x1c>
     6be:	87aa                	mv	a5,a0
     6c0:	1602                	sll	a2,a2,0x20
     6c2:	9201                	srl	a2,a2,0x20
     6c4:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     6c8:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     6cc:	0785                	add	a5,a5,1
     6ce:	fee79de3          	bne	a5,a4,6c8 <memset+0x12>
  }
  return dst;
}
     6d2:	6422                	ld	s0,8(sp)
     6d4:	0141                	add	sp,sp,16
     6d6:	8082                	ret

00000000000006d8 <strchr>:

char*
strchr(const char *s, char c)
{
     6d8:	1141                	add	sp,sp,-16
     6da:	e422                	sd	s0,8(sp)
     6dc:	0800                	add	s0,sp,16
  for(; *s; s++)
     6de:	00054783          	lbu	a5,0(a0)
     6e2:	cb99                	beqz	a5,6f8 <strchr+0x20>
    if(*s == c)
     6e4:	00f58763          	beq	a1,a5,6f2 <strchr+0x1a>
  for(; *s; s++)
     6e8:	0505                	add	a0,a0,1
     6ea:	00054783          	lbu	a5,0(a0)
     6ee:	fbfd                	bnez	a5,6e4 <strchr+0xc>
      return (char*)s;
  return 0;
     6f0:	4501                	li	a0,0
}
     6f2:	6422                	ld	s0,8(sp)
     6f4:	0141                	add	sp,sp,16
     6f6:	8082                	ret
  return 0;
     6f8:	4501                	li	a0,0
     6fa:	bfe5                	j	6f2 <strchr+0x1a>

00000000000006fc <gets>:

char*
gets(char *buf, int max)
{
     6fc:	711d                	add	sp,sp,-96
     6fe:	ec86                	sd	ra,88(sp)
     700:	e8a2                	sd	s0,80(sp)
     702:	e4a6                	sd	s1,72(sp)
     704:	e0ca                	sd	s2,64(sp)
     706:	fc4e                	sd	s3,56(sp)
     708:	f852                	sd	s4,48(sp)
     70a:	f456                	sd	s5,40(sp)
     70c:	f05a                	sd	s6,32(sp)
     70e:	ec5e                	sd	s7,24(sp)
     710:	1080                	add	s0,sp,96
     712:	8baa                	mv	s7,a0
     714:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     716:	892a                	mv	s2,a0
     718:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     71a:	4aa9                	li	s5,10
     71c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     71e:	89a6                	mv	s3,s1
     720:	2485                	addw	s1,s1,1
     722:	0344d663          	bge	s1,s4,74e <gets+0x52>
    cc = read(0, &c, 1);
     726:	4605                	li	a2,1
     728:	faf40593          	add	a1,s0,-81
     72c:	4501                	li	a0,0
     72e:	402000ef          	jal	b30 <read>
    if(cc < 1)
     732:	00a05e63          	blez	a0,74e <gets+0x52>
    buf[i++] = c;
     736:	faf44783          	lbu	a5,-81(s0)
     73a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     73e:	01578763          	beq	a5,s5,74c <gets+0x50>
     742:	0905                	add	s2,s2,1
     744:	fd679de3          	bne	a5,s6,71e <gets+0x22>
    buf[i++] = c;
     748:	89a6                	mv	s3,s1
     74a:	a011                	j	74e <gets+0x52>
     74c:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     74e:	99de                	add	s3,s3,s7
     750:	00098023          	sb	zero,0(s3)
  return buf;
}
     754:	855e                	mv	a0,s7
     756:	60e6                	ld	ra,88(sp)
     758:	6446                	ld	s0,80(sp)
     75a:	64a6                	ld	s1,72(sp)
     75c:	6906                	ld	s2,64(sp)
     75e:	79e2                	ld	s3,56(sp)
     760:	7a42                	ld	s4,48(sp)
     762:	7aa2                	ld	s5,40(sp)
     764:	7b02                	ld	s6,32(sp)
     766:	6be2                	ld	s7,24(sp)
     768:	6125                	add	sp,sp,96
     76a:	8082                	ret

000000000000076c <stat>:

int
stat(const char *n, struct stat *st)
{
     76c:	1101                	add	sp,sp,-32
     76e:	ec06                	sd	ra,24(sp)
     770:	e822                	sd	s0,16(sp)
     772:	e04a                	sd	s2,0(sp)
     774:	1000                	add	s0,sp,32
     776:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     778:	4581                	li	a1,0
     77a:	3de000ef          	jal	b58 <open>
  if(fd < 0)
     77e:	02054263          	bltz	a0,7a2 <stat+0x36>
     782:	e426                	sd	s1,8(sp)
     784:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     786:	85ca                	mv	a1,s2
     788:	3e8000ef          	jal	b70 <fstat>
     78c:	892a                	mv	s2,a0
  close(fd);
     78e:	8526                	mv	a0,s1
     790:	3b0000ef          	jal	b40 <close>
  return r;
     794:	64a2                	ld	s1,8(sp)
}
     796:	854a                	mv	a0,s2
     798:	60e2                	ld	ra,24(sp)
     79a:	6442                	ld	s0,16(sp)
     79c:	6902                	ld	s2,0(sp)
     79e:	6105                	add	sp,sp,32
     7a0:	8082                	ret
    return -1;
     7a2:	597d                	li	s2,-1
     7a4:	bfcd                	j	796 <stat+0x2a>

00000000000007a6 <atoi>:

int
atoi(const char *s)
{
     7a6:	1141                	add	sp,sp,-16
     7a8:	e422                	sd	s0,8(sp)
     7aa:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     7ac:	00054683          	lbu	a3,0(a0)
     7b0:	fd06879b          	addw	a5,a3,-48
     7b4:	0ff7f793          	zext.b	a5,a5
     7b8:	4625                	li	a2,9
     7ba:	02f66863          	bltu	a2,a5,7ea <atoi+0x44>
     7be:	872a                	mv	a4,a0
  n = 0;
     7c0:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
     7c2:	0705                	add	a4,a4,1
     7c4:	0025179b          	sllw	a5,a0,0x2
     7c8:	9fa9                	addw	a5,a5,a0
     7ca:	0017979b          	sllw	a5,a5,0x1
     7ce:	9fb5                	addw	a5,a5,a3
     7d0:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     7d4:	00074683          	lbu	a3,0(a4)
     7d8:	fd06879b          	addw	a5,a3,-48
     7dc:	0ff7f793          	zext.b	a5,a5
     7e0:	fef671e3          	bgeu	a2,a5,7c2 <atoi+0x1c>
  return n;
}
     7e4:	6422                	ld	s0,8(sp)
     7e6:	0141                	add	sp,sp,16
     7e8:	8082                	ret
  n = 0;
     7ea:	4501                	li	a0,0
     7ec:	bfe5                	j	7e4 <atoi+0x3e>

00000000000007ee <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     7ee:	1141                	add	sp,sp,-16
     7f0:	e422                	sd	s0,8(sp)
     7f2:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     7f4:	02b57463          	bgeu	a0,a1,81c <memmove+0x2e>
    while(n-- > 0)
     7f8:	00c05f63          	blez	a2,816 <memmove+0x28>
     7fc:	1602                	sll	a2,a2,0x20
     7fe:	9201                	srl	a2,a2,0x20
     800:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     804:	872a                	mv	a4,a0
      *dst++ = *src++;
     806:	0585                	add	a1,a1,1
     808:	0705                	add	a4,a4,1
     80a:	fff5c683          	lbu	a3,-1(a1)
     80e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     812:	fef71ae3          	bne	a4,a5,806 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     816:	6422                	ld	s0,8(sp)
     818:	0141                	add	sp,sp,16
     81a:	8082                	ret
    dst += n;
     81c:	00c50733          	add	a4,a0,a2
    src += n;
     820:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     822:	fec05ae3          	blez	a2,816 <memmove+0x28>
     826:	fff6079b          	addw	a5,a2,-1
     82a:	1782                	sll	a5,a5,0x20
     82c:	9381                	srl	a5,a5,0x20
     82e:	fff7c793          	not	a5,a5
     832:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     834:	15fd                	add	a1,a1,-1
     836:	177d                	add	a4,a4,-1
     838:	0005c683          	lbu	a3,0(a1)
     83c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     840:	fee79ae3          	bne	a5,a4,834 <memmove+0x46>
     844:	bfc9                	j	816 <memmove+0x28>

0000000000000846 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     846:	1141                	add	sp,sp,-16
     848:	e422                	sd	s0,8(sp)
     84a:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     84c:	ca05                	beqz	a2,87c <memcmp+0x36>
     84e:	fff6069b          	addw	a3,a2,-1
     852:	1682                	sll	a3,a3,0x20
     854:	9281                	srl	a3,a3,0x20
     856:	0685                	add	a3,a3,1
     858:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     85a:	00054783          	lbu	a5,0(a0)
     85e:	0005c703          	lbu	a4,0(a1)
     862:	00e79863          	bne	a5,a4,872 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
     866:	0505                	add	a0,a0,1
    p2++;
     868:	0585                	add	a1,a1,1
  while (n-- > 0) {
     86a:	fed518e3          	bne	a0,a3,85a <memcmp+0x14>
  }
  return 0;
     86e:	4501                	li	a0,0
     870:	a019                	j	876 <memcmp+0x30>
      return *p1 - *p2;
     872:	40e7853b          	subw	a0,a5,a4
}
     876:	6422                	ld	s0,8(sp)
     878:	0141                	add	sp,sp,16
     87a:	8082                	ret
  return 0;
     87c:	4501                	li	a0,0
     87e:	bfe5                	j	876 <memcmp+0x30>

0000000000000880 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     880:	1141                	add	sp,sp,-16
     882:	e406                	sd	ra,8(sp)
     884:	e022                	sd	s0,0(sp)
     886:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
     888:	f67ff0ef          	jal	7ee <memmove>
}
     88c:	60a2                	ld	ra,8(sp)
     88e:	6402                	ld	s0,0(sp)
     890:	0141                	add	sp,sp,16
     892:	8082                	ret

0000000000000894 <htons>:
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
}

uint16_t
htons(uint16_t h)
{
     894:	1141                	add	sp,sp,-16
     896:	e422                	sd	s0,8(sp)
     898:	0800                	add	s0,sp,16
    if (!endian) {
     89a:	00001797          	auipc	a5,0x1
     89e:	7667a783          	lw	a5,1894(a5) # 2000 <endian>
     8a2:	e385                	bnez	a5,8c2 <htons+0x2e>
        endian = byteorder();
     8a4:	4d200793          	li	a5,1234
     8a8:	00001717          	auipc	a4,0x1
     8ac:	74f72c23          	sw	a5,1880(a4) # 2000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
     8b0:	0085179b          	sllw	a5,a0,0x8
     8b4:	0085551b          	srlw	a0,a0,0x8
     8b8:	8fc9                	or	a5,a5,a0
     8ba:	03079513          	sll	a0,a5,0x30
     8be:	9141                	srl	a0,a0,0x30
     8c0:	a029                	j	8ca <htons+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(h) : h;
     8c2:	4d200713          	li	a4,1234
     8c6:	fee785e3          	beq	a5,a4,8b0 <htons+0x1c>
}
     8ca:	6422                	ld	s0,8(sp)
     8cc:	0141                	add	sp,sp,16
     8ce:	8082                	ret

00000000000008d0 <ntohs>:

uint16_t
ntohs(uint16_t n)
{
     8d0:	1141                	add	sp,sp,-16
     8d2:	e422                	sd	s0,8(sp)
     8d4:	0800                	add	s0,sp,16
    if (!endian) {
     8d6:	00001797          	auipc	a5,0x1
     8da:	72a7a783          	lw	a5,1834(a5) # 2000 <endian>
     8de:	e385                	bnez	a5,8fe <ntohs+0x2e>
        endian = byteorder();
     8e0:	4d200793          	li	a5,1234
     8e4:	00001717          	auipc	a4,0x1
     8e8:	70f72e23          	sw	a5,1820(a4) # 2000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
     8ec:	0085179b          	sllw	a5,a0,0x8
     8f0:	0085551b          	srlw	a0,a0,0x8
     8f4:	8fc9                	or	a5,a5,a0
     8f6:	03079513          	sll	a0,a5,0x30
     8fa:	9141                	srl	a0,a0,0x30
     8fc:	a029                	j	906 <ntohs+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(n) : n;
     8fe:	4d200713          	li	a4,1234
     902:	fee785e3          	beq	a5,a4,8ec <ntohs+0x1c>
}
     906:	6422                	ld	s0,8(sp)
     908:	0141                	add	sp,sp,16
     90a:	8082                	ret

000000000000090c <htonl>:

uint32_t
htonl(uint32_t h)
{
     90c:	1141                	add	sp,sp,-16
     90e:	e422                	sd	s0,8(sp)
     910:	0800                	add	s0,sp,16
    if (!endian) {
     912:	00001797          	auipc	a5,0x1
     916:	6ee7a783          	lw	a5,1774(a5) # 2000 <endian>
     91a:	ef85                	bnez	a5,952 <htonl+0x46>
        endian = byteorder();
     91c:	4d200793          	li	a5,1234
     920:	00001717          	auipc	a4,0x1
     924:	6ef72023          	sw	a5,1760(a4) # 2000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
     928:	0185179b          	sllw	a5,a0,0x18
     92c:	0185571b          	srlw	a4,a0,0x18
     930:	8fd9                	or	a5,a5,a4
     932:	0085171b          	sllw	a4,a0,0x8
     936:	00ff06b7          	lui	a3,0xff0
     93a:	8f75                	and	a4,a4,a3
     93c:	8fd9                	or	a5,a5,a4
     93e:	0085551b          	srlw	a0,a0,0x8
     942:	6741                	lui	a4,0x10
     944:	f0070713          	add	a4,a4,-256 # ff00 <base+0xdef0>
     948:	8d79                	and	a0,a0,a4
     94a:	8fc9                	or	a5,a5,a0
     94c:	0007851b          	sext.w	a0,a5
     950:	a029                	j	95a <htonl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(h) : h;
     952:	4d200713          	li	a4,1234
     956:	fce789e3          	beq	a5,a4,928 <htonl+0x1c>
}
     95a:	6422                	ld	s0,8(sp)
     95c:	0141                	add	sp,sp,16
     95e:	8082                	ret

0000000000000960 <ntohl>:

uint32_t
ntohl(uint32_t n)
{
     960:	1141                	add	sp,sp,-16
     962:	e422                	sd	s0,8(sp)
     964:	0800                	add	s0,sp,16
    if (!endian) {
     966:	00001797          	auipc	a5,0x1
     96a:	69a7a783          	lw	a5,1690(a5) # 2000 <endian>
     96e:	ef85                	bnez	a5,9a6 <ntohl+0x46>
        endian = byteorder();
     970:	4d200793          	li	a5,1234
     974:	00001717          	auipc	a4,0x1
     978:	68f72623          	sw	a5,1676(a4) # 2000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
     97c:	0185179b          	sllw	a5,a0,0x18
     980:	0185571b          	srlw	a4,a0,0x18
     984:	8fd9                	or	a5,a5,a4
     986:	0085171b          	sllw	a4,a0,0x8
     98a:	00ff06b7          	lui	a3,0xff0
     98e:	8f75                	and	a4,a4,a3
     990:	8fd9                	or	a5,a5,a4
     992:	0085551b          	srlw	a0,a0,0x8
     996:	6741                	lui	a4,0x10
     998:	f0070713          	add	a4,a4,-256 # ff00 <base+0xdef0>
     99c:	8d79                	and	a0,a0,a4
     99e:	8fc9                	or	a5,a5,a0
     9a0:	0007851b          	sext.w	a0,a5
     9a4:	a029                	j	9ae <ntohl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(n) : n;
     9a6:	4d200713          	li	a4,1234
     9aa:	fce789e3          	beq	a5,a4,97c <ntohl+0x1c>
}
     9ae:	6422                	ld	s0,8(sp)
     9b0:	0141                	add	sp,sp,16
     9b2:	8082                	ret

00000000000009b4 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
     9b4:	1141                	add	sp,sp,-16
     9b6:	e422                	sd	s0,8(sp)
     9b8:	0800                	add	s0,sp,16
     9ba:	872a                	mv	a4,a0
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
     9bc:	02000693          	li	a3,32
     9c0:	4525                	li	a0,9
     9c2:	a011                	j	9c6 <strtol+0x12>
        s++;
     9c4:	0705                	add	a4,a4,1
    while (*s == ' ' || *s == '\t')
     9c6:	00074783          	lbu	a5,0(a4)
     9ca:	fed78de3          	beq	a5,a3,9c4 <strtol+0x10>
     9ce:	fea78be3          	beq	a5,a0,9c4 <strtol+0x10>

    // plus/minus sign
    if (*s == '+')
     9d2:	02b00693          	li	a3,43
     9d6:	02d78663          	beq	a5,a3,a02 <strtol+0x4e>
        s++;
    else if (*s == '-')
     9da:	02d00693          	li	a3,45
    int neg = 0;
     9de:	4301                	li	t1,0
    else if (*s == '-')
     9e0:	02d78463          	beq	a5,a3,a08 <strtol+0x54>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
     9e4:	fef67793          	and	a5,a2,-17
     9e8:	eb89                	bnez	a5,9fa <strtol+0x46>
     9ea:	00074683          	lbu	a3,0(a4)
     9ee:	03000793          	li	a5,48
     9f2:	00f68e63          	beq	a3,a5,a0e <strtol+0x5a>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
     9f6:	e211                	bnez	a2,9fa <strtol+0x46>
        s++, base = 8;
    else if (base == 0)
        base = 10;
     9f8:	4629                	li	a2,10
     9fa:	4501                	li	a0,0

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
     9fc:	4825                	li	a6,9
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
     9fe:	48e5                	li	a7,25
     a00:	a825                	j	a38 <strtol+0x84>
        s++;
     a02:	0705                	add	a4,a4,1
    int neg = 0;
     a04:	4301                	li	t1,0
     a06:	bff9                	j	9e4 <strtol+0x30>
        s++, neg = 1;
     a08:	0705                	add	a4,a4,1
     a0a:	4305                	li	t1,1
     a0c:	bfe1                	j	9e4 <strtol+0x30>
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
     a0e:	00174683          	lbu	a3,1(a4)
     a12:	07800793          	li	a5,120
     a16:	00f68663          	beq	a3,a5,a22 <strtol+0x6e>
    else if (base == 0 && s[0] == '0')
     a1a:	f265                	bnez	a2,9fa <strtol+0x46>
        s++, base = 8;
     a1c:	0705                	add	a4,a4,1
     a1e:	4621                	li	a2,8
     a20:	bfe9                	j	9fa <strtol+0x46>
        s += 2, base = 16;
     a22:	0709                	add	a4,a4,2
     a24:	4641                	li	a2,16
     a26:	bfd1                	j	9fa <strtol+0x46>
            dig = *s - '0';
     a28:	fd07879b          	addw	a5,a5,-48
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
     a2c:	04c7d063          	bge	a5,a2,a6c <strtol+0xb8>
            break;
        s++, val = (val * base) + dig;
     a30:	0705                	add	a4,a4,1
     a32:	02a60533          	mul	a0,a2,a0
     a36:	953e                	add	a0,a0,a5
        if (*s >= '0' && *s <= '9')
     a38:	00074783          	lbu	a5,0(a4)
     a3c:	fd07869b          	addw	a3,a5,-48
     a40:	0ff6f693          	zext.b	a3,a3
     a44:	fed872e3          	bgeu	a6,a3,a28 <strtol+0x74>
        else if (*s >= 'a' && *s <= 'z')
     a48:	f9f7869b          	addw	a3,a5,-97
     a4c:	0ff6f693          	zext.b	a3,a3
     a50:	00d8e563          	bltu	a7,a3,a5a <strtol+0xa6>
            dig = *s - 'a' + 10;
     a54:	fa97879b          	addw	a5,a5,-87
     a58:	bfd1                	j	a2c <strtol+0x78>
        else if (*s >= 'A' && *s <= 'Z')
     a5a:	fbf7869b          	addw	a3,a5,-65
     a5e:	0ff6f693          	zext.b	a3,a3
     a62:	00d8e563          	bltu	a7,a3,a6c <strtol+0xb8>
            dig = *s - 'A' + 10;
     a66:	fc97879b          	addw	a5,a5,-55
     a6a:	b7c9                	j	a2c <strtol+0x78>
        // we don't properly detect overflow!
    }

    if (endptr)
     a6c:	c191                	beqz	a1,a70 <strtol+0xbc>
        *endptr = (char *) s;
     a6e:	e198                	sd	a4,0(a1)
    return (neg ? -val : val);
     a70:	00030463          	beqz	t1,a78 <strtol+0xc4>
     a74:	40a00533          	neg	a0,a0
}
     a78:	6422                	ld	s0,8(sp)
     a7a:	0141                	add	sp,sp,16
     a7c:	8082                	ret

0000000000000a7e <inet_pton>:
inet_pton (int family, const char *p, void *n) {
    char *sp, *ep;
    int idx;
    long ret;

    if (family != AF_INET) {
     a7e:	4785                	li	a5,1
     a80:	08f51063          	bne	a0,a5,b00 <inet_pton+0x82>
inet_pton (int family, const char *p, void *n) {
     a84:	715d                	add	sp,sp,-80
     a86:	e486                	sd	ra,72(sp)
     a88:	e0a2                	sd	s0,64(sp)
     a8a:	fc26                	sd	s1,56(sp)
     a8c:	f84a                	sd	s2,48(sp)
     a8e:	f44e                	sd	s3,40(sp)
     a90:	f052                	sd	s4,32(sp)
     a92:	ec56                	sd	s5,24(sp)
     a94:	e85a                	sd	s6,16(sp)
     a96:	0880                	add	s0,sp,80
     a98:	84ae                	mv	s1,a1
     a9a:	89b2                	mv	s3,a2
     a9c:	4901                	li	s2,0
        return -1;
    }
    sp = (char *)p;
    for (idx = 0; idx < 4; idx++) {
        ret = strtol(sp, &ep, 10);
        if (ret < 0 || ret > 255) {
     a9e:	0ff00a13          	li	s4,255
            return -1;
        }
        if (ep == sp) {
            return -1;
        }
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
     aa2:	4a8d                	li	s5,3
     aa4:	02e00b13          	li	s6,46
     aa8:	a805                	j	ad8 <inet_pton+0x5a>
     aaa:	0007c783          	lbu	a5,0(a5)
     aae:	efb9                	bnez	a5,b0c <inet_pton+0x8e>
            return -1;
        }
        ((uint8_t *)n)[idx] = ret;
     ab0:	00a981a3          	sb	a0,3(s3)
        sp = ep + 1;
    }
    return 0;
     ab4:	4501                	li	a0,0
}
     ab6:	60a6                	ld	ra,72(sp)
     ab8:	6406                	ld	s0,64(sp)
     aba:	74e2                	ld	s1,56(sp)
     abc:	7942                	ld	s2,48(sp)
     abe:	79a2                	ld	s3,40(sp)
     ac0:	7a02                	ld	s4,32(sp)
     ac2:	6ae2                	ld	s5,24(sp)
     ac4:	6b42                	ld	s6,16(sp)
     ac6:	6161                	add	sp,sp,80
     ac8:	8082                	ret
        ((uint8_t *)n)[idx] = ret;
     aca:	01298733          	add	a4,s3,s2
     ace:	00a70023          	sb	a0,0(a4)
        sp = ep + 1;
     ad2:	00178493          	add	s1,a5,1
    for (idx = 0; idx < 4; idx++) {
     ad6:	0905                	add	s2,s2,1
        ret = strtol(sp, &ep, 10);
     ad8:	4629                	li	a2,10
     ada:	fb840593          	add	a1,s0,-72
     ade:	8526                	mv	a0,s1
     ae0:	ed5ff0ef          	jal	9b4 <strtol>
        if (ret < 0 || ret > 255) {
     ae4:	02aa6063          	bltu	s4,a0,b04 <inet_pton+0x86>
        if (ep == sp) {
     ae8:	fb843783          	ld	a5,-72(s0)
     aec:	00978e63          	beq	a5,s1,b08 <inet_pton+0x8a>
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
     af0:	fb590de3          	beq	s2,s5,aaa <inet_pton+0x2c>
     af4:	0007c703          	lbu	a4,0(a5)
     af8:	fd6709e3          	beq	a4,s6,aca <inet_pton+0x4c>
            return -1;
     afc:	557d                	li	a0,-1
     afe:	bf65                	j	ab6 <inet_pton+0x38>
        return -1;
     b00:	557d                	li	a0,-1
}
     b02:	8082                	ret
            return -1;
     b04:	557d                	li	a0,-1
     b06:	bf45                	j	ab6 <inet_pton+0x38>
            return -1;
     b08:	557d                	li	a0,-1
     b0a:	b775                	j	ab6 <inet_pton+0x38>
            return -1;
     b0c:	557d                	li	a0,-1
     b0e:	b765                	j	ab6 <inet_pton+0x38>

0000000000000b10 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     b10:	4885                	li	a7,1
 ecall
     b12:	00000073          	ecall
 ret
     b16:	8082                	ret

0000000000000b18 <exit>:
.global exit
exit:
 li a7, SYS_exit
     b18:	4889                	li	a7,2
 ecall
     b1a:	00000073          	ecall
 ret
     b1e:	8082                	ret

0000000000000b20 <wait>:
.global wait
wait:
 li a7, SYS_wait
     b20:	488d                	li	a7,3
 ecall
     b22:	00000073          	ecall
 ret
     b26:	8082                	ret

0000000000000b28 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     b28:	4891                	li	a7,4
 ecall
     b2a:	00000073          	ecall
 ret
     b2e:	8082                	ret

0000000000000b30 <read>:
.global read
read:
 li a7, SYS_read
     b30:	4895                	li	a7,5
 ecall
     b32:	00000073          	ecall
 ret
     b36:	8082                	ret

0000000000000b38 <write>:
.global write
write:
 li a7, SYS_write
     b38:	48c1                	li	a7,16
 ecall
     b3a:	00000073          	ecall
 ret
     b3e:	8082                	ret

0000000000000b40 <close>:
.global close
close:
 li a7, SYS_close
     b40:	48d5                	li	a7,21
 ecall
     b42:	00000073          	ecall
 ret
     b46:	8082                	ret

0000000000000b48 <kill>:
.global kill
kill:
 li a7, SYS_kill
     b48:	4899                	li	a7,6
 ecall
     b4a:	00000073          	ecall
 ret
     b4e:	8082                	ret

0000000000000b50 <exec>:
.global exec
exec:
 li a7, SYS_exec
     b50:	489d                	li	a7,7
 ecall
     b52:	00000073          	ecall
 ret
     b56:	8082                	ret

0000000000000b58 <open>:
.global open
open:
 li a7, SYS_open
     b58:	48bd                	li	a7,15
 ecall
     b5a:	00000073          	ecall
 ret
     b5e:	8082                	ret

0000000000000b60 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     b60:	48c5                	li	a7,17
 ecall
     b62:	00000073          	ecall
 ret
     b66:	8082                	ret

0000000000000b68 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     b68:	48c9                	li	a7,18
 ecall
     b6a:	00000073          	ecall
 ret
     b6e:	8082                	ret

0000000000000b70 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     b70:	48a1                	li	a7,8
 ecall
     b72:	00000073          	ecall
 ret
     b76:	8082                	ret

0000000000000b78 <link>:
.global link
link:
 li a7, SYS_link
     b78:	48cd                	li	a7,19
 ecall
     b7a:	00000073          	ecall
 ret
     b7e:	8082                	ret

0000000000000b80 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     b80:	48d1                	li	a7,20
 ecall
     b82:	00000073          	ecall
 ret
     b86:	8082                	ret

0000000000000b88 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     b88:	48a5                	li	a7,9
 ecall
     b8a:	00000073          	ecall
 ret
     b8e:	8082                	ret

0000000000000b90 <dup>:
.global dup
dup:
 li a7, SYS_dup
     b90:	48a9                	li	a7,10
 ecall
     b92:	00000073          	ecall
 ret
     b96:	8082                	ret

0000000000000b98 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     b98:	48ad                	li	a7,11
 ecall
     b9a:	00000073          	ecall
 ret
     b9e:	8082                	ret

0000000000000ba0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     ba0:	48b1                	li	a7,12
 ecall
     ba2:	00000073          	ecall
 ret
     ba6:	8082                	ret

0000000000000ba8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     ba8:	48b5                	li	a7,13
 ecall
     baa:	00000073          	ecall
 ret
     bae:	8082                	ret

0000000000000bb0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     bb0:	48b9                	li	a7,14
 ecall
     bb2:	00000073          	ecall
 ret
     bb6:	8082                	ret

0000000000000bb8 <socket>:
.global socket
socket:
 li a7, SYS_socket
     bb8:	48d9                	li	a7,22
 ecall
     bba:	00000073          	ecall
 ret
     bbe:	8082                	ret

0000000000000bc0 <bind>:
.global bind
bind:
 li a7, SYS_bind
     bc0:	48dd                	li	a7,23
 ecall
     bc2:	00000073          	ecall
 ret
     bc6:	8082                	ret

0000000000000bc8 <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
     bc8:	48e1                	li	a7,24
 ecall
     bca:	00000073          	ecall
 ret
     bce:	8082                	ret

0000000000000bd0 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
     bd0:	48e5                	li	a7,25
 ecall
     bd2:	00000073          	ecall
 ret
     bd6:	8082                	ret

0000000000000bd8 <connect>:
.global connect
connect:
 li a7, SYS_connect
     bd8:	48e9                	li	a7,26
 ecall
     bda:	00000073          	ecall
 ret
     bde:	8082                	ret

0000000000000be0 <listen>:
.global listen
listen:
 li a7, SYS_listen
     be0:	48ed                	li	a7,27
 ecall
     be2:	00000073          	ecall
 ret
     be6:	8082                	ret

0000000000000be8 <accept>:
.global accept
accept:
 li a7, SYS_accept
     be8:	48f1                	li	a7,28
 ecall
     bea:	00000073          	ecall
 ret
     bee:	8082                	ret

0000000000000bf0 <recv>:
.global recv
recv:
 li a7, SYS_recv
     bf0:	48f5                	li	a7,29
 ecall
     bf2:	00000073          	ecall
 ret
     bf6:	8082                	ret

0000000000000bf8 <send>:
.global send
send:
 li a7, SYS_send
     bf8:	48f9                	li	a7,30
 ecall
     bfa:	00000073          	ecall
 ret
     bfe:	8082                	ret

0000000000000c00 <ioctl>:
.global ioctl
ioctl:
 li a7, SYS_ioctl
     c00:	48fd                	li	a7,31
 ecall
     c02:	00000073          	ecall
 ret
     c06:	8082                	ret

0000000000000c08 <consolemode>:
.global consolemode
consolemode:
 li a7, SYS_consolemode
     c08:	02000893          	li	a7,32
 ecall
     c0c:	00000073          	ecall
 ret
     c10:	8082                	ret

0000000000000c12 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     c12:	1101                	add	sp,sp,-32
     c14:	ec06                	sd	ra,24(sp)
     c16:	e822                	sd	s0,16(sp)
     c18:	1000                	add	s0,sp,32
     c1a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     c1e:	4605                	li	a2,1
     c20:	fef40593          	add	a1,s0,-17
     c24:	f15ff0ef          	jal	b38 <write>
}
     c28:	60e2                	ld	ra,24(sp)
     c2a:	6442                	ld	s0,16(sp)
     c2c:	6105                	add	sp,sp,32
     c2e:	8082                	ret

0000000000000c30 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
     c30:	715d                	add	sp,sp,-80
     c32:	e486                	sd	ra,72(sp)
     c34:	e0a2                	sd	s0,64(sp)
     c36:	fc26                	sd	s1,56(sp)
     c38:	0880                	add	s0,sp,80
     c3a:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     c3c:	c299                	beqz	a3,c42 <printint+0x12>
     c3e:	0805c963          	bltz	a1,cd0 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     c42:	2581                	sext.w	a1,a1
  neg = 0;
     c44:	4881                	li	a7,0
     c46:	fb840693          	add	a3,s0,-72
  }

  i = 0;
     c4a:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
     c4c:	2601                	sext.w	a2,a2
     c4e:	00001517          	auipc	a0,0x1
     c52:	88a50513          	add	a0,a0,-1910 # 14d8 <digits>
     c56:	883a                	mv	a6,a4
     c58:	2705                	addw	a4,a4,1
     c5a:	02c5f7bb          	remuw	a5,a1,a2
     c5e:	1782                	sll	a5,a5,0x20
     c60:	9381                	srl	a5,a5,0x20
     c62:	97aa                	add	a5,a5,a0
     c64:	0007c783          	lbu	a5,0(a5)
     c68:	00f68023          	sb	a5,0(a3) # ff0000 <base+0xfedff0>
  }while((x /= base) != 0);
     c6c:	0005879b          	sext.w	a5,a1
     c70:	02c5d5bb          	divuw	a1,a1,a2
     c74:	0685                	add	a3,a3,1
     c76:	fec7f0e3          	bgeu	a5,a2,c56 <printint+0x26>
  if(neg)
     c7a:	00088c63          	beqz	a7,c92 <printint+0x62>
    buf[i++] = '-';
     c7e:	fd070793          	add	a5,a4,-48
     c82:	00878733          	add	a4,a5,s0
     c86:	02d00793          	li	a5,45
     c8a:	fef70423          	sb	a5,-24(a4)
     c8e:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
     c92:	02e05a63          	blez	a4,cc6 <printint+0x96>
     c96:	f84a                	sd	s2,48(sp)
     c98:	f44e                	sd	s3,40(sp)
     c9a:	fb840793          	add	a5,s0,-72
     c9e:	00e78933          	add	s2,a5,a4
     ca2:	fff78993          	add	s3,a5,-1
     ca6:	99ba                	add	s3,s3,a4
     ca8:	377d                	addw	a4,a4,-1
     caa:	1702                	sll	a4,a4,0x20
     cac:	9301                	srl	a4,a4,0x20
     cae:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
     cb2:	fff94583          	lbu	a1,-1(s2)
     cb6:	8526                	mv	a0,s1
     cb8:	f5bff0ef          	jal	c12 <putc>
  while(--i >= 0)
     cbc:	197d                	add	s2,s2,-1
     cbe:	ff391ae3          	bne	s2,s3,cb2 <printint+0x82>
     cc2:	7942                	ld	s2,48(sp)
     cc4:	79a2                	ld	s3,40(sp)
}
     cc6:	60a6                	ld	ra,72(sp)
     cc8:	6406                	ld	s0,64(sp)
     cca:	74e2                	ld	s1,56(sp)
     ccc:	6161                	add	sp,sp,80
     cce:	8082                	ret
    x = -xx;
     cd0:	40b005bb          	negw	a1,a1
    neg = 1;
     cd4:	4885                	li	a7,1
    x = -xx;
     cd6:	bf85                	j	c46 <printint+0x16>

0000000000000cd8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     cd8:	711d                	add	sp,sp,-96
     cda:	ec86                	sd	ra,88(sp)
     cdc:	e8a2                	sd	s0,80(sp)
     cde:	e0ca                	sd	s2,64(sp)
     ce0:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     ce2:	0005c903          	lbu	s2,0(a1)
     ce6:	26090863          	beqz	s2,f56 <vprintf+0x27e>
     cea:	e4a6                	sd	s1,72(sp)
     cec:	fc4e                	sd	s3,56(sp)
     cee:	f852                	sd	s4,48(sp)
     cf0:	f456                	sd	s5,40(sp)
     cf2:	f05a                	sd	s6,32(sp)
     cf4:	ec5e                	sd	s7,24(sp)
     cf6:	e862                	sd	s8,16(sp)
     cf8:	e466                	sd	s9,8(sp)
     cfa:	8b2a                	mv	s6,a0
     cfc:	8a2e                	mv	s4,a1
     cfe:	8bb2                	mv	s7,a2
  state = 0;
     d00:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
     d02:	4481                	li	s1,0
     d04:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
     d06:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
     d0a:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
     d0e:	06c00c93          	li	s9,108
     d12:	a005                	j	d32 <vprintf+0x5a>
        putc(fd, c0);
     d14:	85ca                	mv	a1,s2
     d16:	855a                	mv	a0,s6
     d18:	efbff0ef          	jal	c12 <putc>
     d1c:	a019                	j	d22 <vprintf+0x4a>
    } else if(state == '%'){
     d1e:	03598263          	beq	s3,s5,d42 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
     d22:	2485                	addw	s1,s1,1
     d24:	8726                	mv	a4,s1
     d26:	009a07b3          	add	a5,s4,s1
     d2a:	0007c903          	lbu	s2,0(a5)
     d2e:	20090c63          	beqz	s2,f46 <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
     d32:	0009079b          	sext.w	a5,s2
    if(state == 0){
     d36:	fe0994e3          	bnez	s3,d1e <vprintf+0x46>
      if(c0 == '%'){
     d3a:	fd579de3          	bne	a5,s5,d14 <vprintf+0x3c>
        state = '%';
     d3e:	89be                	mv	s3,a5
     d40:	b7cd                	j	d22 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
     d42:	00ea06b3          	add	a3,s4,a4
     d46:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
     d4a:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
     d4c:	c681                	beqz	a3,d54 <vprintf+0x7c>
     d4e:	9752                	add	a4,a4,s4
     d50:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
     d54:	03878f63          	beq	a5,s8,d92 <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
     d58:	05978963          	beq	a5,s9,daa <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
     d5c:	07500713          	li	a4,117
     d60:	0ee78363          	beq	a5,a4,e46 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
     d64:	07800713          	li	a4,120
     d68:	12e78563          	beq	a5,a4,e92 <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
     d6c:	07000713          	li	a4,112
     d70:	14e78a63          	beq	a5,a4,ec4 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
     d74:	07300713          	li	a4,115
     d78:	18e78a63          	beq	a5,a4,f0c <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
     d7c:	02500713          	li	a4,37
     d80:	04e79563          	bne	a5,a4,dca <vprintf+0xf2>
        putc(fd, '%');
     d84:	02500593          	li	a1,37
     d88:	855a                	mv	a0,s6
     d8a:	e89ff0ef          	jal	c12 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
     d8e:	4981                	li	s3,0
     d90:	bf49                	j	d22 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
     d92:	008b8913          	add	s2,s7,8
     d96:	4685                	li	a3,1
     d98:	4629                	li	a2,10
     d9a:	000ba583          	lw	a1,0(s7)
     d9e:	855a                	mv	a0,s6
     da0:	e91ff0ef          	jal	c30 <printint>
     da4:	8bca                	mv	s7,s2
      state = 0;
     da6:	4981                	li	s3,0
     da8:	bfad                	j	d22 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
     daa:	06400793          	li	a5,100
     dae:	02f68963          	beq	a3,a5,de0 <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     db2:	06c00793          	li	a5,108
     db6:	04f68263          	beq	a3,a5,dfa <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
     dba:	07500793          	li	a5,117
     dbe:	0af68063          	beq	a3,a5,e5e <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
     dc2:	07800793          	li	a5,120
     dc6:	0ef68263          	beq	a3,a5,eaa <vprintf+0x1d2>
        putc(fd, '%');
     dca:	02500593          	li	a1,37
     dce:	855a                	mv	a0,s6
     dd0:	e43ff0ef          	jal	c12 <putc>
        putc(fd, c0);
     dd4:	85ca                	mv	a1,s2
     dd6:	855a                	mv	a0,s6
     dd8:	e3bff0ef          	jal	c12 <putc>
      state = 0;
     ddc:	4981                	li	s3,0
     dde:	b791                	j	d22 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
     de0:	008b8913          	add	s2,s7,8
     de4:	4685                	li	a3,1
     de6:	4629                	li	a2,10
     de8:	000bb583          	ld	a1,0(s7)
     dec:	855a                	mv	a0,s6
     dee:	e43ff0ef          	jal	c30 <printint>
        i += 1;
     df2:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
     df4:	8bca                	mv	s7,s2
      state = 0;
     df6:	4981                	li	s3,0
        i += 1;
     df8:	b72d                	j	d22 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     dfa:	06400793          	li	a5,100
     dfe:	02f60763          	beq	a2,a5,e2c <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
     e02:	07500793          	li	a5,117
     e06:	06f60963          	beq	a2,a5,e78 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
     e0a:	07800793          	li	a5,120
     e0e:	faf61ee3          	bne	a2,a5,dca <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
     e12:	008b8913          	add	s2,s7,8
     e16:	4681                	li	a3,0
     e18:	4641                	li	a2,16
     e1a:	000bb583          	ld	a1,0(s7)
     e1e:	855a                	mv	a0,s6
     e20:	e11ff0ef          	jal	c30 <printint>
        i += 2;
     e24:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
     e26:	8bca                	mv	s7,s2
      state = 0;
     e28:	4981                	li	s3,0
        i += 2;
     e2a:	bde5                	j	d22 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
     e2c:	008b8913          	add	s2,s7,8
     e30:	4685                	li	a3,1
     e32:	4629                	li	a2,10
     e34:	000bb583          	ld	a1,0(s7)
     e38:	855a                	mv	a0,s6
     e3a:	df7ff0ef          	jal	c30 <printint>
        i += 2;
     e3e:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
     e40:	8bca                	mv	s7,s2
      state = 0;
     e42:	4981                	li	s3,0
        i += 2;
     e44:	bdf9                	j	d22 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
     e46:	008b8913          	add	s2,s7,8
     e4a:	4681                	li	a3,0
     e4c:	4629                	li	a2,10
     e4e:	000ba583          	lw	a1,0(s7)
     e52:	855a                	mv	a0,s6
     e54:	dddff0ef          	jal	c30 <printint>
     e58:	8bca                	mv	s7,s2
      state = 0;
     e5a:	4981                	li	s3,0
     e5c:	b5d9                	j	d22 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     e5e:	008b8913          	add	s2,s7,8
     e62:	4681                	li	a3,0
     e64:	4629                	li	a2,10
     e66:	000bb583          	ld	a1,0(s7)
     e6a:	855a                	mv	a0,s6
     e6c:	dc5ff0ef          	jal	c30 <printint>
        i += 1;
     e70:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
     e72:	8bca                	mv	s7,s2
      state = 0;
     e74:	4981                	li	s3,0
        i += 1;
     e76:	b575                	j	d22 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     e78:	008b8913          	add	s2,s7,8
     e7c:	4681                	li	a3,0
     e7e:	4629                	li	a2,10
     e80:	000bb583          	ld	a1,0(s7)
     e84:	855a                	mv	a0,s6
     e86:	dabff0ef          	jal	c30 <printint>
        i += 2;
     e8a:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
     e8c:	8bca                	mv	s7,s2
      state = 0;
     e8e:	4981                	li	s3,0
        i += 2;
     e90:	bd49                	j	d22 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
     e92:	008b8913          	add	s2,s7,8
     e96:	4681                	li	a3,0
     e98:	4641                	li	a2,16
     e9a:	000ba583          	lw	a1,0(s7)
     e9e:	855a                	mv	a0,s6
     ea0:	d91ff0ef          	jal	c30 <printint>
     ea4:	8bca                	mv	s7,s2
      state = 0;
     ea6:	4981                	li	s3,0
     ea8:	bdad                	j	d22 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
     eaa:	008b8913          	add	s2,s7,8
     eae:	4681                	li	a3,0
     eb0:	4641                	li	a2,16
     eb2:	000bb583          	ld	a1,0(s7)
     eb6:	855a                	mv	a0,s6
     eb8:	d79ff0ef          	jal	c30 <printint>
        i += 1;
     ebc:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
     ebe:	8bca                	mv	s7,s2
      state = 0;
     ec0:	4981                	li	s3,0
        i += 1;
     ec2:	b585                	j	d22 <vprintf+0x4a>
     ec4:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
     ec6:	008b8d13          	add	s10,s7,8
     eca:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
     ece:	03000593          	li	a1,48
     ed2:	855a                	mv	a0,s6
     ed4:	d3fff0ef          	jal	c12 <putc>
  putc(fd, 'x');
     ed8:	07800593          	li	a1,120
     edc:	855a                	mv	a0,s6
     ede:	d35ff0ef          	jal	c12 <putc>
     ee2:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     ee4:	00000b97          	auipc	s7,0x0
     ee8:	5f4b8b93          	add	s7,s7,1524 # 14d8 <digits>
     eec:	03c9d793          	srl	a5,s3,0x3c
     ef0:	97de                	add	a5,a5,s7
     ef2:	0007c583          	lbu	a1,0(a5)
     ef6:	855a                	mv	a0,s6
     ef8:	d1bff0ef          	jal	c12 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     efc:	0992                	sll	s3,s3,0x4
     efe:	397d                	addw	s2,s2,-1
     f00:	fe0916e3          	bnez	s2,eec <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
     f04:	8bea                	mv	s7,s10
      state = 0;
     f06:	4981                	li	s3,0
     f08:	6d02                	ld	s10,0(sp)
     f0a:	bd21                	j	d22 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
     f0c:	008b8993          	add	s3,s7,8
     f10:	000bb903          	ld	s2,0(s7)
     f14:	00090f63          	beqz	s2,f32 <vprintf+0x25a>
        for(; *s; s++)
     f18:	00094583          	lbu	a1,0(s2)
     f1c:	c195                	beqz	a1,f40 <vprintf+0x268>
          putc(fd, *s);
     f1e:	855a                	mv	a0,s6
     f20:	cf3ff0ef          	jal	c12 <putc>
        for(; *s; s++)
     f24:	0905                	add	s2,s2,1
     f26:	00094583          	lbu	a1,0(s2)
     f2a:	f9f5                	bnez	a1,f1e <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
     f2c:	8bce                	mv	s7,s3
      state = 0;
     f2e:	4981                	li	s3,0
     f30:	bbcd                	j	d22 <vprintf+0x4a>
          s = "(null)";
     f32:	00000917          	auipc	s2,0x0
     f36:	51690913          	add	s2,s2,1302 # 1448 <malloc+0x402>
        for(; *s; s++)
     f3a:	02800593          	li	a1,40
     f3e:	b7c5                	j	f1e <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
     f40:	8bce                	mv	s7,s3
      state = 0;
     f42:	4981                	li	s3,0
     f44:	bbf9                	j	d22 <vprintf+0x4a>
     f46:	64a6                	ld	s1,72(sp)
     f48:	79e2                	ld	s3,56(sp)
     f4a:	7a42                	ld	s4,48(sp)
     f4c:	7aa2                	ld	s5,40(sp)
     f4e:	7b02                	ld	s6,32(sp)
     f50:	6be2                	ld	s7,24(sp)
     f52:	6c42                	ld	s8,16(sp)
     f54:	6ca2                	ld	s9,8(sp)
    }
  }
}
     f56:	60e6                	ld	ra,88(sp)
     f58:	6446                	ld	s0,80(sp)
     f5a:	6906                	ld	s2,64(sp)
     f5c:	6125                	add	sp,sp,96
     f5e:	8082                	ret

0000000000000f60 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     f60:	715d                	add	sp,sp,-80
     f62:	ec06                	sd	ra,24(sp)
     f64:	e822                	sd	s0,16(sp)
     f66:	1000                	add	s0,sp,32
     f68:	e010                	sd	a2,0(s0)
     f6a:	e414                	sd	a3,8(s0)
     f6c:	e818                	sd	a4,16(s0)
     f6e:	ec1c                	sd	a5,24(s0)
     f70:	03043023          	sd	a6,32(s0)
     f74:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
     f78:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
     f7c:	8622                	mv	a2,s0
     f7e:	d5bff0ef          	jal	cd8 <vprintf>
}
     f82:	60e2                	ld	ra,24(sp)
     f84:	6442                	ld	s0,16(sp)
     f86:	6161                	add	sp,sp,80
     f88:	8082                	ret

0000000000000f8a <printf>:

void
printf(const char *fmt, ...)
{
     f8a:	711d                	add	sp,sp,-96
     f8c:	ec06                	sd	ra,24(sp)
     f8e:	e822                	sd	s0,16(sp)
     f90:	1000                	add	s0,sp,32
     f92:	e40c                	sd	a1,8(s0)
     f94:	e810                	sd	a2,16(s0)
     f96:	ec14                	sd	a3,24(s0)
     f98:	f018                	sd	a4,32(s0)
     f9a:	f41c                	sd	a5,40(s0)
     f9c:	03043823          	sd	a6,48(s0)
     fa0:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     fa4:	00840613          	add	a2,s0,8
     fa8:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
     fac:	85aa                	mv	a1,a0
     fae:	4505                	li	a0,1
     fb0:	d29ff0ef          	jal	cd8 <vprintf>
}
     fb4:	60e2                	ld	ra,24(sp)
     fb6:	6442                	ld	s0,16(sp)
     fb8:	6125                	add	sp,sp,96
     fba:	8082                	ret

0000000000000fbc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     fbc:	1141                	add	sp,sp,-16
     fbe:	e422                	sd	s0,8(sp)
     fc0:	0800                	add	s0,sp,16
  Header *bp, *p;

  if(ap == 0)
     fc2:	cd3d                	beqz	a0,1040 <free+0x84>
    return;
  if((uint64)ap < 4096)
     fc4:	6785                	lui	a5,0x1
     fc6:	06f56d63          	bltu	a0,a5,1040 <free+0x84>
    return;
  bp = (Header*)ap - 1;
     fca:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     fce:	00001797          	auipc	a5,0x1
     fd2:	03a7b783          	ld	a5,58(a5) # 2008 <freep>
     fd6:	a02d                	j	1000 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
     fd8:	4618                	lw	a4,8(a2)
     fda:	9f2d                	addw	a4,a4,a1
     fdc:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
     fe0:	6398                	ld	a4,0(a5)
     fe2:	6310                	ld	a2,0(a4)
     fe4:	a83d                	j	1022 <free+0x66>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
     fe6:	ff852703          	lw	a4,-8(a0)
     fea:	9f31                	addw	a4,a4,a2
     fec:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     fee:	ff053683          	ld	a3,-16(a0)
     ff2:	a091                	j	1036 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     ff4:	6398                	ld	a4,0(a5)
     ff6:	00e7e463          	bltu	a5,a4,ffe <free+0x42>
     ffa:	00e6ea63          	bltu	a3,a4,100e <free+0x52>
{
     ffe:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1000:	fed7fae3          	bgeu	a5,a3,ff4 <free+0x38>
    1004:	6398                	ld	a4,0(a5)
    1006:	00e6e463          	bltu	a3,a4,100e <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    100a:	fee7eae3          	bltu	a5,a4,ffe <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
    100e:	ff852583          	lw	a1,-8(a0)
    1012:	6390                	ld	a2,0(a5)
    1014:	02059813          	sll	a6,a1,0x20
    1018:	01c85713          	srl	a4,a6,0x1c
    101c:	9736                	add	a4,a4,a3
    101e:	fae60de3          	beq	a2,a4,fd8 <free+0x1c>
    bp->s.ptr = p->s.ptr->s.ptr;
    1022:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    1026:	4790                	lw	a2,8(a5)
    1028:	02061593          	sll	a1,a2,0x20
    102c:	01c5d713          	srl	a4,a1,0x1c
    1030:	973e                	add	a4,a4,a5
    1032:	fae68ae3          	beq	a3,a4,fe6 <free+0x2a>
    p->s.ptr = bp->s.ptr;
    1036:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    1038:	00001717          	auipc	a4,0x1
    103c:	fcf73823          	sd	a5,-48(a4) # 2008 <freep>
}
    1040:	6422                	ld	s0,8(sp)
    1042:	0141                	add	sp,sp,16
    1044:	8082                	ret

0000000000001046 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1046:	7139                	add	sp,sp,-64
    1048:	fc06                	sd	ra,56(sp)
    104a:	f822                	sd	s0,48(sp)
    104c:	f426                	sd	s1,40(sp)
    104e:	ec4e                	sd	s3,24(sp)
    1050:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1052:	02051493          	sll	s1,a0,0x20
    1056:	9081                	srl	s1,s1,0x20
    1058:	04bd                	add	s1,s1,15
    105a:	8091                	srl	s1,s1,0x4
    105c:	0014899b          	addw	s3,s1,1
    1060:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
    1062:	00001517          	auipc	a0,0x1
    1066:	fa653503          	ld	a0,-90(a0) # 2008 <freep>
    106a:	c915                	beqz	a0,109e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    106c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    106e:	4798                	lw	a4,8(a5)
    1070:	08977a63          	bgeu	a4,s1,1104 <malloc+0xbe>
    1074:	f04a                	sd	s2,32(sp)
    1076:	e852                	sd	s4,16(sp)
    1078:	e456                	sd	s5,8(sp)
    107a:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    107c:	8a4e                	mv	s4,s3
    107e:	0009871b          	sext.w	a4,s3
    1082:	6685                	lui	a3,0x1
    1084:	00d77363          	bgeu	a4,a3,108a <malloc+0x44>
    1088:	6a05                	lui	s4,0x1
    108a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    108e:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1092:	00001917          	auipc	s2,0x1
    1096:	f7690913          	add	s2,s2,-138 # 2008 <freep>
  if(p == (char*)-1)
    109a:	5afd                	li	s5,-1
    109c:	a081                	j	10dc <malloc+0x96>
    109e:	f04a                	sd	s2,32(sp)
    10a0:	e852                	sd	s4,16(sp)
    10a2:	e456                	sd	s5,8(sp)
    10a4:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    10a6:	00001797          	auipc	a5,0x1
    10aa:	f6a78793          	add	a5,a5,-150 # 2010 <base>
    10ae:	00001717          	auipc	a4,0x1
    10b2:	f4f73d23          	sd	a5,-166(a4) # 2008 <freep>
    10b6:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    10b8:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    10bc:	b7c1                	j	107c <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
    10be:	6398                	ld	a4,0(a5)
    10c0:	e118                	sd	a4,0(a0)
    10c2:	a8a9                	j	111c <malloc+0xd6>
  hp->s.size = nu;
    10c4:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    10c8:	0541                	add	a0,a0,16
    10ca:	ef3ff0ef          	jal	fbc <free>
  return freep;
    10ce:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    10d2:	c12d                	beqz	a0,1134 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    10d4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    10d6:	4798                	lw	a4,8(a5)
    10d8:	02977263          	bgeu	a4,s1,10fc <malloc+0xb6>
    if(p == freep)
    10dc:	00093703          	ld	a4,0(s2)
    10e0:	853e                	mv	a0,a5
    10e2:	fef719e3          	bne	a4,a5,10d4 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
    10e6:	8552                	mv	a0,s4
    10e8:	ab9ff0ef          	jal	ba0 <sbrk>
  if(p == (char*)-1)
    10ec:	fd551ce3          	bne	a0,s5,10c4 <malloc+0x7e>
        return 0;
    10f0:	4501                	li	a0,0
    10f2:	7902                	ld	s2,32(sp)
    10f4:	6a42                	ld	s4,16(sp)
    10f6:	6aa2                	ld	s5,8(sp)
    10f8:	6b02                	ld	s6,0(sp)
    10fa:	a03d                	j	1128 <malloc+0xe2>
    10fc:	7902                	ld	s2,32(sp)
    10fe:	6a42                	ld	s4,16(sp)
    1100:	6aa2                	ld	s5,8(sp)
    1102:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    1104:	fae48de3          	beq	s1,a4,10be <malloc+0x78>
        p->s.size -= nunits;
    1108:	4137073b          	subw	a4,a4,s3
    110c:	c798                	sw	a4,8(a5)
        p += p->s.size;
    110e:	02071693          	sll	a3,a4,0x20
    1112:	01c6d713          	srl	a4,a3,0x1c
    1116:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    1118:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    111c:	00001717          	auipc	a4,0x1
    1120:	eea73623          	sd	a0,-276(a4) # 2008 <freep>
      return (void*)(p + 1);
    1124:	01078513          	add	a0,a5,16
  }
}
    1128:	70e2                	ld	ra,56(sp)
    112a:	7442                	ld	s0,48(sp)
    112c:	74a2                	ld	s1,40(sp)
    112e:	69e2                	ld	s3,24(sp)
    1130:	6121                	add	sp,sp,64
    1132:	8082                	ret
    1134:	7902                	ld	s2,32(sp)
    1136:	6a42                	ld	s4,16(sp)
    1138:	6aa2                	ld	s5,8(sp)
    113a:	6b02                	ld	s6,0(sp)
    113c:	b7f5                	j	1128 <malloc+0xe2>
