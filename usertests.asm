
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <validateint>:
  printf(stdout, "sbrk test OK\n");
}

void
validateint(int *p)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
      "int %2\n\t"
      "mov %%ebx, %%esp" :
      "=a" (res) :
      "a" (SYS_sleep), "n" (T_SYSCALL), "c" (p) :
      "ebx");
}
       3:	5d                   	pop    %ebp
       4:	c3                   	ret    
       5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
       9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000010 <main>:
  printf(stdout, "validate ok\n");
}

int
main(int argc, char *argv[])
{
      10:	55                   	push   %ebp
      11:	89 e5                	mov    %esp,%ebp
      13:	83 e4 f0             	and    $0xfffffff0,%esp
      16:	83 ec 10             	sub    $0x10,%esp
  printf(1, "usertests starting\n");
      19:	c7 44 24 04 10 37 00 	movl   $0x3710,0x4(%esp)
      20:	00 
      21:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      28:	e8 63 33 00 00       	call   3390 <printf>

  if(open("usertests.ran", 0) >= 0){
      2d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
      34:	00 
      35:	c7 04 24 24 37 00 00 	movl   $0x3724,(%esp)
      3c:	e8 37 32 00 00       	call   3278 <open>
      41:	85 c0                	test   %eax,%eax
      43:	78 1b                	js     60 <main+0x50>
    printf(1, "already ran user tests -- rebuild fs.img\n");
      45:	c7 44 24 04 e8 44 00 	movl   $0x44e8,0x4(%esp)
      4c:	00 
      4d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      54:	e8 37 33 00 00       	call   3390 <printf>
    exit();
      59:	e8 da 31 00 00       	call   3238 <exit>
      5e:	66 90                	xchg   %ax,%ax
  }
  close(open("usertests.ran", O_CREATE));
      60:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
      67:	00 
      68:	c7 04 24 24 37 00 00 	movl   $0x3724,(%esp)
      6f:	e8 04 32 00 00       	call   3278 <open>
      74:	89 04 24             	mov    %eax,(%esp)
      77:	e8 e4 31 00 00       	call   3260 <close>
  bigdir(); // slow

  exectest();
*/

  exit();
      7c:	e8 b7 31 00 00       	call   3238 <exit>
      81:	eb 0d                	jmp    90 <opentest>
      83:	90                   	nop
      84:	90                   	nop
      85:	90                   	nop
      86:	90                   	nop
      87:	90                   	nop
      88:	90                   	nop
      89:	90                   	nop
      8a:	90                   	nop
      8b:	90                   	nop
      8c:	90                   	nop
      8d:	90                   	nop
      8e:	90                   	nop
      8f:	90                   	nop

00000090 <opentest>:
*/


void
opentest(void)
{
      90:	55                   	push   %ebp
      91:	89 e5                	mov    %esp,%ebp
      93:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(stdout, "open test\n");
      96:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
      9b:	c7 44 24 04 32 37 00 	movl   $0x3732,0x4(%esp)
      a2:	00 
      a3:	89 04 24             	mov    %eax,(%esp)
      a6:	e8 e5 32 00 00       	call   3390 <printf>
  fd = open("echo", 0);
      ab:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
      b2:	00 
      b3:	c7 04 24 3d 37 00 00 	movl   $0x373d,(%esp)
      ba:	e8 b9 31 00 00       	call   3278 <open>
  if(fd < 0){
      bf:	85 c0                	test   %eax,%eax
      c1:	78 37                	js     fa <opentest+0x6a>
    printf(stdout, "open echo failed!\n");
    exit();
  }
  close(fd);
      c3:	89 04 24             	mov    %eax,(%esp)
      c6:	e8 95 31 00 00       	call   3260 <close>
  fd = open("doesnotexist", 0);
      cb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
      d2:	00 
      d3:	c7 04 24 55 37 00 00 	movl   $0x3755,(%esp)
      da:	e8 99 31 00 00       	call   3278 <open>
  if(fd >= 0){
      df:	85 c0                	test   %eax,%eax
      e1:	79 31                	jns    114 <opentest+0x84>
    printf(stdout, "open doesnotexist succeeded!\n");
    exit();
  }
  printf(stdout, "open test ok\n");
      e3:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
      e8:	c7 44 24 04 80 37 00 	movl   $0x3780,0x4(%esp)
      ef:	00 
      f0:	89 04 24             	mov    %eax,(%esp)
      f3:	e8 98 32 00 00       	call   3390 <printf>
}
      f8:	c9                   	leave  
      f9:	c3                   	ret    
  int fd;

  printf(stdout, "open test\n");
  fd = open("echo", 0);
  if(fd < 0){
    printf(stdout, "open echo failed!\n");
      fa:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
      ff:	c7 44 24 04 42 37 00 	movl   $0x3742,0x4(%esp)
     106:	00 
     107:	89 04 24             	mov    %eax,(%esp)
     10a:	e8 81 32 00 00       	call   3390 <printf>
    exit();
     10f:	e8 24 31 00 00       	call   3238 <exit>
  }
  close(fd);
  fd = open("doesnotexist", 0);
  if(fd >= 0){
    printf(stdout, "open doesnotexist succeeded!\n");
     114:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
     119:	c7 44 24 04 62 37 00 	movl   $0x3762,0x4(%esp)
     120:	00 
     121:	89 04 24             	mov    %eax,(%esp)
     124:	e8 67 32 00 00       	call   3390 <printf>
    exit();
     129:	e8 0a 31 00 00       	call   3238 <exit>
     12e:	66 90                	xchg   %ax,%ax

00000130 <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
     130:	55                   	push   %ebp
     131:	89 e5                	mov    %esp,%ebp
     133:	53                   	push   %ebx
  int n, pid;

  printf(1, "fork test\n");
     134:	31 db                	xor    %ebx,%ebx
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
     136:	83 ec 14             	sub    $0x14,%esp
  int n, pid;

  printf(1, "fork test\n");
     139:	c7 44 24 04 8e 37 00 	movl   $0x378e,0x4(%esp)
     140:	00 
     141:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     148:	e8 43 32 00 00       	call   3390 <printf>
     14d:	eb 13                	jmp    162 <forktest+0x32>
     14f:	90                   	nop

  for(n=0; n<1000; n++){
    pid = fork();
    if(pid < 0)
      break;
    if(pid == 0)
     150:	74 72                	je     1c4 <forktest+0x94>
{
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<1000; n++){
     152:	83 c3 01             	add    $0x1,%ebx
     155:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
     15b:	90                   	nop
     15c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     160:	74 4e                	je     1b0 <forktest+0x80>
     162:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pid = fork();
     168:	e8 c3 30 00 00       	call   3230 <fork>
    if(pid < 0)
     16d:	83 f8 00             	cmp    $0x0,%eax
     170:	7d de                	jge    150 <forktest+0x20>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit();
  }
  
  for(; n > 0; n--){
     172:	85 db                	test   %ebx,%ebx
     174:	74 11                	je     187 <forktest+0x57>
     176:	66 90                	xchg   %ax,%ax
    if(wait() < 0){
     178:	e8 c3 30 00 00       	call   3240 <wait>
     17d:	85 c0                	test   %eax,%eax
     17f:	90                   	nop
     180:	78 47                	js     1c9 <forktest+0x99>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit();
  }
  
  for(; n > 0; n--){
     182:	83 eb 01             	sub    $0x1,%ebx
     185:	75 f1                	jne    178 <forktest+0x48>
     187:	90                   	nop
      printf(1, "wait stopped early\n");
      exit();
    }
  }
  
  if(wait() != -1){
     188:	e8 b3 30 00 00       	call   3240 <wait>
     18d:	83 f8 ff             	cmp    $0xffffffff,%eax
     190:	75 50                	jne    1e2 <forktest+0xb2>
    printf(1, "wait got too many\n");
    exit();
  }
  
  printf(1, "fork test OK\n");
     192:	c7 44 24 04 c0 37 00 	movl   $0x37c0,0x4(%esp)
     199:	00 
     19a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     1a1:	e8 ea 31 00 00       	call   3390 <printf>
}
     1a6:	83 c4 14             	add    $0x14,%esp
     1a9:	5b                   	pop    %ebx
     1aa:	5d                   	pop    %ebp
     1ab:	c3                   	ret    
     1ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(pid == 0)
      exit();
  }
  
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
     1b0:	c7 44 24 04 14 45 00 	movl   $0x4514,0x4(%esp)
     1b7:	00 
     1b8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     1bf:	e8 cc 31 00 00       	call   3390 <printf>
    exit();
     1c4:	e8 6f 30 00 00       	call   3238 <exit>
  }
  
  for(; n > 0; n--){
    if(wait() < 0){
      printf(1, "wait stopped early\n");
     1c9:	c7 44 24 04 99 37 00 	movl   $0x3799,0x4(%esp)
     1d0:	00 
     1d1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     1d8:	e8 b3 31 00 00       	call   3390 <printf>
      exit();
     1dd:	e8 56 30 00 00       	call   3238 <exit>
    }
  }
  
  if(wait() != -1){
    printf(1, "wait got too many\n");
     1e2:	c7 44 24 04 ad 37 00 	movl   $0x37ad,0x4(%esp)
     1e9:	00 
     1ea:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     1f1:	e8 9a 31 00 00       	call   3390 <printf>
    exit();
     1f6:	e8 3d 30 00 00       	call   3238 <exit>
     1fb:	90                   	nop
     1fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000200 <exitwait>:
}

// try to find any races between exit and wait
void
exitwait(void)
{
     200:	55                   	push   %ebp
     201:	89 e5                	mov    %esp,%ebp
     203:	56                   	push   %esi
     204:	31 f6                	xor    %esi,%esi
     206:	53                   	push   %ebx
     207:	83 ec 10             	sub    $0x10,%esp
     20a:	eb 17                	jmp    223 <exitwait+0x23>
     20c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
      return;
    }
    if(pid){
     210:	74 79                	je     28b <exitwait+0x8b>
      if(wait() != pid){
     212:	e8 29 30 00 00       	call   3240 <wait>
     217:	39 c3                	cmp    %eax,%ebx
     219:	75 35                	jne    250 <exitwait+0x50>
void
exitwait(void)
{
  int i, pid;

  for(i = 0; i < 100; i++){
     21b:	83 c6 01             	add    $0x1,%esi
     21e:	83 fe 64             	cmp    $0x64,%esi
     221:	74 4d                	je     270 <exitwait+0x70>
    pid = fork();
     223:	e8 08 30 00 00       	call   3230 <fork>
    if(pid < 0){
     228:	83 f8 00             	cmp    $0x0,%eax
exitwait(void)
{
  int i, pid;

  for(i = 0; i < 100; i++){
    pid = fork();
     22b:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
     22d:	7d e1                	jge    210 <exitwait+0x10>
      printf(1, "fork failed\n");
     22f:	c7 44 24 04 5b 38 00 	movl   $0x385b,0x4(%esp)
     236:	00 
     237:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     23e:	e8 4d 31 00 00       	call   3390 <printf>
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
}
     243:	83 c4 10             	add    $0x10,%esp
     246:	5b                   	pop    %ebx
     247:	5e                   	pop    %esi
     248:	5d                   	pop    %ebp
     249:	c3                   	ret    
     24a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      printf(1, "fork failed\n");
      return;
    }
    if(pid){
      if(wait() != pid){
        printf(1, "wait wrong pid\n");
     250:	c7 44 24 04 ce 37 00 	movl   $0x37ce,0x4(%esp)
     257:	00 
     258:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     25f:	e8 2c 31 00 00       	call   3390 <printf>
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
}
     264:	83 c4 10             	add    $0x10,%esp
     267:	5b                   	pop    %ebx
     268:	5e                   	pop    %esi
     269:	5d                   	pop    %ebp
     26a:	c3                   	ret    
     26b:	90                   	nop
     26c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      }
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
     270:	c7 44 24 04 de 37 00 	movl   $0x37de,0x4(%esp)
     277:	00 
     278:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     27f:	e8 0c 31 00 00       	call   3390 <printf>
}
     284:	83 c4 10             	add    $0x10,%esp
     287:	5b                   	pop    %ebx
     288:	5e                   	pop    %esi
     289:	5d                   	pop    %ebp
     28a:	c3                   	ret    
      if(wait() != pid){
        printf(1, "wait wrong pid\n");
        return;
      }
    } else {
      exit();
     28b:	e8 a8 2f 00 00       	call   3238 <exit>

00000290 <validatetest>:
      "ebx");
}

void
validatetest(void)
{
     290:	55                   	push   %ebp
     291:	89 e5                	mov    %esp,%ebp
     293:	56                   	push   %esi
     294:	53                   	push   %ebx
  int hi = 1100*1024;

  printf(stdout, "validate test\n");
     295:	31 db                	xor    %ebx,%ebx
      "ebx");
}

void
validatetest(void)
{
     297:	83 ec 10             	sub    $0x10,%esp
  int hi = 1100*1024;

  printf(stdout, "validate test\n");
     29a:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
     29f:	c7 44 24 04 eb 37 00 	movl   $0x37eb,0x4(%esp)
     2a6:	00 
     2a7:	89 04 24             	mov    %eax,(%esp)
     2aa:	e8 e1 30 00 00       	call   3390 <printf>
     2af:	90                   	nop

  uint p;
  for (p = 0; p <= (uint)hi; p += 4096) {
    int pid;
    if ((pid = fork()) == 0) {
     2b0:	e8 7b 2f 00 00       	call   3230 <fork>
     2b5:	85 c0                	test   %eax,%eax
     2b7:	89 c6                	mov    %eax,%esi
     2b9:	74 79                	je     334 <validatetest+0xa4>
      // try to crash the kernel by passing in a badly placed integer
      validateint((int*)p);
      exit();
    }
    sleep(0);
     2bb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     2c2:	e8 01 30 00 00       	call   32c8 <sleep>
    sleep(0);
     2c7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     2ce:	e8 f5 2f 00 00       	call   32c8 <sleep>
    kill(pid);
     2d3:	89 34 24             	mov    %esi,(%esp)
     2d6:	e8 8d 2f 00 00       	call   3268 <kill>
    wait();
     2db:	e8 60 2f 00 00       	call   3240 <wait>

    // try to crash the kernel by passing in a bad string pointer
    if (link("nosuchfile", (char*)p) != -1) {
     2e0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     2e4:	c7 04 24 fa 37 00 00 	movl   $0x37fa,(%esp)
     2eb:	e8 a8 2f 00 00       	call   3298 <link>
     2f0:	83 f8 ff             	cmp    $0xffffffff,%eax
     2f3:	75 2a                	jne    31f <validatetest+0x8f>
  int hi = 1100*1024;

  printf(stdout, "validate test\n");

  uint p;
  for (p = 0; p <= (uint)hi; p += 4096) {
     2f5:	81 c3 00 10 00 00    	add    $0x1000,%ebx
     2fb:	81 fb 00 40 11 00    	cmp    $0x114000,%ebx
     301:	75 ad                	jne    2b0 <validatetest+0x20>
      printf(stdout, "link should not succeed\n");
      exit();
    }
  }

  printf(stdout, "validate ok\n");
     303:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
     308:	c7 44 24 04 1e 38 00 	movl   $0x381e,0x4(%esp)
     30f:	00 
     310:	89 04 24             	mov    %eax,(%esp)
     313:	e8 78 30 00 00       	call   3390 <printf>
}
     318:	83 c4 10             	add    $0x10,%esp
     31b:	5b                   	pop    %ebx
     31c:	5e                   	pop    %esi
     31d:	5d                   	pop    %ebp
     31e:	c3                   	ret    
    kill(pid);
    wait();

    // try to crash the kernel by passing in a bad string pointer
    if (link("nosuchfile", (char*)p) != -1) {
      printf(stdout, "link should not succeed\n");
     31f:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
     324:	c7 44 24 04 05 38 00 	movl   $0x3805,0x4(%esp)
     32b:	00 
     32c:	89 04 24             	mov    %eax,(%esp)
     32f:	e8 5c 30 00 00       	call   3390 <printf>
      exit();
     334:	e8 ff 2e 00 00       	call   3238 <exit>
     339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000340 <sbrktest>:
  printf(1, "fork test OK\n");
}

void
sbrktest(void)
{
     340:	55                   	push   %ebp
     341:	89 e5                	mov    %esp,%ebp
     343:	57                   	push   %edi
     344:	56                   	push   %esi
  char *oldbrk = sbrk(0);

  printf(stdout, "sbrk test\n");

  // can one sbrk() less than a page?
  char *a = sbrk(0);
     345:	31 f6                	xor    %esi,%esi
  printf(1, "fork test OK\n");
}

void
sbrktest(void)
{
     347:	53                   	push   %ebx
     348:	81 ec cc 00 00 00    	sub    $0xcc,%esp
  int pid;
  char *oldbrk = sbrk(0);
     34e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     355:	e8 66 2f 00 00       	call   32c0 <sbrk>

  printf(stdout, "sbrk test\n");
     35a:	c7 44 24 04 2b 38 00 	movl   $0x382b,0x4(%esp)
     361:	00 

void
sbrktest(void)
{
  int pid;
  char *oldbrk = sbrk(0);
     362:	89 85 54 ff ff ff    	mov    %eax,-0xac(%ebp)

  printf(stdout, "sbrk test\n");
     368:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
     36d:	89 04 24             	mov    %eax,(%esp)
     370:	e8 1b 30 00 00       	call   3390 <printf>

  // can one sbrk() less than a page?
  char *a = sbrk(0);
     375:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     37c:	e8 3f 2f 00 00       	call   32c0 <sbrk>
     381:	89 c3                	mov    %eax,%ebx
     383:	90                   	nop
     384:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int i;
  for(i = 0; i < 5000; i++){
    char *b = sbrk(1);
     388:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     38f:	e8 2c 2f 00 00       	call   32c0 <sbrk>
    if(b != a){
     394:	39 c3                	cmp    %eax,%ebx
     396:	0f 85 8a 02 00 00    	jne    626 <sbrktest+0x2e6>
  printf(stdout, "sbrk test\n");

  // can one sbrk() less than a page?
  char *a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
     39c:	83 c6 01             	add    $0x1,%esi
    char *b = sbrk(1);
    if(b != a){
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
      exit();
    }
    *b = 1;
     39f:	c6 03 01             	movb   $0x1,(%ebx)
    a = b + 1;
     3a2:	83 c3 01             	add    $0x1,%ebx
  printf(stdout, "sbrk test\n");

  // can one sbrk() less than a page?
  char *a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
     3a5:	81 fe 88 13 00 00    	cmp    $0x1388,%esi
     3ab:	75 db                	jne    388 <sbrktest+0x48>
      exit();
    }
    *b = 1;
    a = b + 1;
  }
  pid = fork();
     3ad:	e8 7e 2e 00 00       	call   3230 <fork>
  if(pid < 0){
     3b2:	85 c0                	test   %eax,%eax
      exit();
    }
    *b = 1;
    a = b + 1;
  }
  pid = fork();
     3b4:	89 c6                	mov    %eax,%esi
  if(pid < 0){
     3b6:	0f 88 18 04 00 00    	js     7d4 <sbrktest+0x494>
    printf(stdout, "sbrk test fork failed\n");
    exit();
  }
  char *c = sbrk(1);
     3bc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  c = sbrk(1);
  if(c != a + 1){
     3c3:	83 c3 01             	add    $0x1,%ebx
  pid = fork();
  if(pid < 0){
    printf(stdout, "sbrk test fork failed\n");
    exit();
  }
  char *c = sbrk(1);
     3c6:	e8 f5 2e 00 00       	call   32c0 <sbrk>
  c = sbrk(1);
     3cb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     3d2:	e8 e9 2e 00 00       	call   32c0 <sbrk>
  if(c != a + 1){
     3d7:	39 d8                	cmp    %ebx,%eax
     3d9:	0f 85 db 03 00 00    	jne    7ba <sbrktest+0x47a>
    printf(stdout, "sbrk test failed post-fork\n");
    exit();
  }
  if(pid == 0)
     3df:	85 f6                	test   %esi,%esi
     3e1:	0f 84 ce 03 00 00    	je     7b5 <sbrktest+0x475>
     3e7:	90                   	nop
    exit();
  wait();
     3e8:	e8 53 2e 00 00       	call   3240 <wait>

  // can one allocate the full 640K?
  a = sbrk(0);
     3ed:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     3f4:	e8 c7 2e 00 00       	call   32c0 <sbrk>
     3f9:	89 c3                	mov    %eax,%ebx
  uint amt = (640 * 1024) - (uint) a;
  char *p = sbrk(amt);
     3fb:	b8 00 00 0a 00       	mov    $0xa0000,%eax
     400:	29 d8                	sub    %ebx,%eax
     402:	89 04 24             	mov    %eax,(%esp)
     405:	e8 b6 2e 00 00       	call   32c0 <sbrk>
  if(p != a){
     40a:	39 c3                	cmp    %eax,%ebx
     40c:	0f 85 86 03 00 00    	jne    798 <sbrktest+0x458>
    printf(stdout, "sbrk test failed 640K test, p %x a %x\n", p, a);
    exit();
  }
  char *lastaddr = (char *)(640 * 1024 - 1);
  *lastaddr = 99;
     412:	c6 05 ff ff 09 00 63 	movb   $0x63,0x9ffff

  // is one forbidden from allocating more than 640K?
  c = sbrk(4096);
     419:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
     420:	e8 9b 2e 00 00       	call   32c0 <sbrk>
  if(c != (char *) 0xffffffff){
     425:	83 f8 ff             	cmp    $0xffffffff,%eax
     428:	0f 85 4c 03 00 00    	jne    77a <sbrktest+0x43a>
    printf(stdout, "sbrk allocated more than 640K, c %x\n", c);
    exit();
  }

  // can one de-allocate?
  a = sbrk(0);
     42e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     435:	e8 86 2e 00 00       	call   32c0 <sbrk>
  c = sbrk(-4096);
     43a:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
    printf(stdout, "sbrk allocated more than 640K, c %x\n", c);
    exit();
  }

  // can one de-allocate?
  a = sbrk(0);
     441:	89 c3                	mov    %eax,%ebx
  c = sbrk(-4096);
     443:	e8 78 2e 00 00       	call   32c0 <sbrk>
  if(c == (char *) 0xffffffff){
     448:	83 f8 ff             	cmp    $0xffffffff,%eax
     44b:	0f 84 0f 03 00 00    	je     760 <sbrktest+0x420>
    printf(stdout, "sbrk could not deallocate\n");
    exit();
  }
  c = sbrk(0);
     451:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     458:	e8 63 2e 00 00       	call   32c0 <sbrk>
  if(c != a - 4096){
     45d:	8d 93 00 f0 ff ff    	lea    -0x1000(%ebx),%edx
     463:	39 d0                	cmp    %edx,%eax
     465:	0f 85 d3 02 00 00    	jne    73e <sbrktest+0x3fe>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    exit();
  }

  // can one re-allocate that page?
  a = sbrk(0);
     46b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     472:	e8 49 2e 00 00       	call   32c0 <sbrk>
  c = sbrk(4096);
     477:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    exit();
  }

  // can one re-allocate that page?
  a = sbrk(0);
     47e:	89 c3                	mov    %eax,%ebx
  c = sbrk(4096);
     480:	e8 3b 2e 00 00       	call   32c0 <sbrk>
  if(c != a || sbrk(0) != a + 4096){
     485:	39 c3                	cmp    %eax,%ebx
    exit();
  }

  // can one re-allocate that page?
  a = sbrk(0);
  c = sbrk(4096);
     487:	89 c6                	mov    %eax,%esi
  if(c != a || sbrk(0) != a + 4096){
     489:	0f 85 8d 02 00 00    	jne    71c <sbrktest+0x3dc>
     48f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     496:	e8 25 2e 00 00       	call   32c0 <sbrk>
     49b:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
     4a1:	39 d0                	cmp    %edx,%eax
     4a3:	0f 85 73 02 00 00    	jne    71c <sbrktest+0x3dc>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    exit();
  }
  if(*lastaddr == 99){
     4a9:	80 3d ff ff 09 00 63 	cmpb   $0x63,0x9ffff
     4b0:	0f 84 4c 02 00 00    	je     702 <sbrktest+0x3c2>
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    exit();
  }

  c = sbrk(4096);
     4b6:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  if(c != (char *) 0xffffffff){
    printf(stdout, "sbrk was able to re-allocate beyond 640K, c %x\n", c);
    exit();
     4bd:	bb 00 00 0a 00       	mov    $0xa0000,%ebx
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    exit();
  }

  c = sbrk(4096);
     4c2:	e8 f9 2d 00 00       	call   32c0 <sbrk>
  if(c != (char *) 0xffffffff){
     4c7:	83 f8 ff             	cmp    $0xffffffff,%eax
     4ca:	0f 85 14 02 00 00    	jne    6e4 <sbrktest+0x3a4>
    exit();
  }

  // can we read the kernel's memory?
  for(a = (char*)(640*1024); a < (char *)2000000; a += 50000){
    int ppid = getpid();
     4d0:	e8 e3 2d 00 00       	call   32b8 <getpid>
     4d5:	89 c6                	mov    %eax,%esi
    int pid = fork();
     4d7:	e8 54 2d 00 00       	call   3230 <fork>
    if(pid < 0){
     4dc:	83 f8 00             	cmp    $0x0,%eax
     4df:	0f 8c e5 01 00 00    	jl     6ca <sbrktest+0x38a>
      printf(stdout, "fork failed\n");
      exit();
    }
    if(pid == 0){
     4e5:	0f 84 b2 01 00 00    	je     69d <sbrktest+0x35d>
    printf(stdout, "sbrk was able to re-allocate beyond 640K, c %x\n", c);
    exit();
  }

  // can we read the kernel's memory?
  for(a = (char*)(640*1024); a < (char *)2000000; a += 50000){
     4eb:	81 c3 50 c3 00 00    	add    $0xc350,%ebx
     4f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(pid == 0){
      printf(stdout, "oops could read %x = %x\n", a, *a);
      kill(ppid);
      exit();
    }
    wait();
     4f8:	e8 43 2d 00 00       	call   3240 <wait>
    printf(stdout, "sbrk was able to re-allocate beyond 640K, c %x\n", c);
    exit();
  }

  // can we read the kernel's memory?
  for(a = (char*)(640*1024); a < (char *)2000000; a += 50000){
     4fd:	81 fb 70 99 1e 00    	cmp    $0x1e9970,%ebx
     503:	75 cb                	jne    4d0 <sbrktest+0x190>
    wait();
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  sbrk(-(sbrk(0) - oldbrk));
     505:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     50c:	e8 af 2d 00 00       	call   32c0 <sbrk>
     511:	8b 95 54 ff ff ff    	mov    -0xac(%ebp),%edx
     517:	29 c2                	sub    %eax,%edx
     519:	89 14 24             	mov    %edx,(%esp)
     51c:	e8 9f 2d 00 00       	call   32c0 <sbrk>
  int pids[32];
  int fds[2];
  if(pipe(fds) != 0){
     521:	8d 45 dc             	lea    -0x24(%ebp),%eax
     524:	89 04 24             	mov    %eax,(%esp)
     527:	e8 1c 2d 00 00       	call   3248 <pipe>
     52c:	85 c0                	test   %eax,%eax
     52e:	0f 85 50 01 00 00    	jne    684 <sbrktest+0x344>
    printf(1, "pipe() failed\n");
    exit();
     534:	31 db                	xor    %ebx,%ebx
     536:	8d bd 5c ff ff ff    	lea    -0xa4(%ebp),%edi
     53c:	eb 2a                	jmp    568 <sbrktest+0x228>
      write(fds[1], "x", 1);
      // sit around until killed
      for(;;) sleep(1000);
    }
    char scratch;
    if(pids[i] != -1)
     53e:	83 f8 ff             	cmp    $0xffffffff,%eax
     541:	74 1a                	je     55d <sbrktest+0x21d>
      read(fds[0], &scratch, 1);
     543:	8d 45 e7             	lea    -0x19(%ebp),%eax
     546:	89 44 24 04          	mov    %eax,0x4(%esp)
     54a:	8b 45 dc             	mov    -0x24(%ebp),%eax
     54d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     554:	00 
     555:	89 04 24             	mov    %eax,(%esp)
     558:	e8 f3 2c 00 00       	call   3250 <read>
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit();
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if((pids[i] = fork()) == 0) {
     55d:	89 34 9f             	mov    %esi,(%edi,%ebx,4)
  int fds[2];
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit();
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
     560:	83 c3 01             	add    $0x1,%ebx
     563:	83 fb 20             	cmp    $0x20,%ebx
     566:	74 56                	je     5be <sbrktest+0x27e>
    if((pids[i] = fork()) == 0) {
     568:	e8 c3 2c 00 00       	call   3230 <fork>
     56d:	85 c0                	test   %eax,%eax
     56f:	89 c6                	mov    %eax,%esi
     571:	75 cb                	jne    53e <sbrktest+0x1fe>
      // allocate the full 640K
      sbrk((640 * 1024) - (uint)sbrk(0));
     573:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     57a:	e8 41 2d 00 00       	call   32c0 <sbrk>
     57f:	ba 00 00 0a 00       	mov    $0xa0000,%edx
     584:	29 c2                	sub    %eax,%edx
     586:	89 14 24             	mov    %edx,(%esp)
     589:	e8 32 2d 00 00       	call   32c0 <sbrk>
      write(fds[1], "x", 1);
     58e:	8b 45 e0             	mov    -0x20(%ebp),%eax
     591:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     598:	00 
     599:	c7 44 24 04 f4 3d 00 	movl   $0x3df4,0x4(%esp)
     5a0:	00 
     5a1:	89 04 24             	mov    %eax,(%esp)
     5a4:	e8 af 2c 00 00       	call   3258 <write>
     5a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      // sit around until killed
      for(;;) sleep(1000);
     5b0:	c7 04 24 e8 03 00 00 	movl   $0x3e8,(%esp)
     5b7:	e8 0c 2d 00 00       	call   32c8 <sleep>
     5bc:	eb f2                	jmp    5b0 <sbrktest+0x270>
    if(pids[i] != -1)
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
     5be:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
     5c5:	30 db                	xor    %bl,%bl
     5c7:	e8 f4 2c 00 00       	call   32c0 <sbrk>
     5cc:	89 c6                	mov    %eax,%esi
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if(pids[i] == -1)
     5ce:	8b 04 9f             	mov    (%edi,%ebx,4),%eax
     5d1:	83 f8 ff             	cmp    $0xffffffff,%eax
     5d4:	74 0d                	je     5e3 <sbrktest+0x2a3>
      continue;
    kill(pids[i]);
     5d6:	89 04 24             	mov    %eax,(%esp)
     5d9:	e8 8a 2c 00 00       	call   3268 <kill>
    wait();
     5de:	e8 5d 2c 00 00       	call   3240 <wait>
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
     5e3:	83 c3 01             	add    $0x1,%ebx
     5e6:	83 fb 20             	cmp    $0x20,%ebx
     5e9:	75 e3                	jne    5ce <sbrktest+0x28e>
    if(pids[i] == -1)
      continue;
    kill(pids[i]);
    wait();
  }
  if(c == (char*)0xffffffff) {
     5eb:	83 fe ff             	cmp    $0xffffffff,%esi
     5ee:	66 90                	xchg   %ax,%ax
     5f0:	74 78                	je     66a <sbrktest+0x32a>
    printf(stdout, "failed sbrk leaked memory\n");
    exit();
  }

  if(sbrk(0) > oldbrk)
     5f2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     5f9:	e8 c2 2c 00 00       	call   32c0 <sbrk>
     5fe:	39 85 54 ff ff ff    	cmp    %eax,-0xac(%ebp)
     604:	72 46                	jb     64c <sbrktest+0x30c>
    sbrk(-(sbrk(0) - oldbrk));

  printf(stdout, "sbrk test OK\n");
     606:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
     60b:	c7 44 24 04 e2 38 00 	movl   $0x38e2,0x4(%esp)
     612:	00 
     613:	89 04 24             	mov    %eax,(%esp)
     616:	e8 75 2d 00 00       	call   3390 <printf>
}
     61b:	81 c4 cc 00 00 00    	add    $0xcc,%esp
     621:	5b                   	pop    %ebx
     622:	5e                   	pop    %esi
     623:	5f                   	pop    %edi
     624:	5d                   	pop    %ebp
     625:	c3                   	ret    
  char *a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
    char *b = sbrk(1);
    if(b != a){
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
     626:	89 44 24 10          	mov    %eax,0x10(%esp)
     62a:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
     62f:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
     633:	89 74 24 08          	mov    %esi,0x8(%esp)
     637:	c7 44 24 04 36 38 00 	movl   $0x3836,0x4(%esp)
     63e:	00 
     63f:	89 04 24             	mov    %eax,(%esp)
     642:	e8 49 2d 00 00       	call   3390 <printf>
      exit();
     647:	e8 ec 2b 00 00       	call   3238 <exit>
    printf(stdout, "failed sbrk leaked memory\n");
    exit();
  }

  if(sbrk(0) > oldbrk)
    sbrk(-(sbrk(0) - oldbrk));
     64c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     653:	e8 68 2c 00 00       	call   32c0 <sbrk>
     658:	8b 95 54 ff ff ff    	mov    -0xac(%ebp),%edx
     65e:	29 c2                	sub    %eax,%edx
     660:	89 14 24             	mov    %edx,(%esp)
     663:	e8 58 2c 00 00       	call   32c0 <sbrk>
     668:	eb 9c                	jmp    606 <sbrktest+0x2c6>
      continue;
    kill(pids[i]);
    wait();
  }
  if(c == (char*)0xffffffff) {
    printf(stdout, "failed sbrk leaked memory\n");
     66a:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
     66f:	c7 44 24 04 c7 38 00 	movl   $0x38c7,0x4(%esp)
     676:	00 
     677:	89 04 24             	mov    %eax,(%esp)
     67a:	e8 11 2d 00 00       	call   3390 <printf>
    exit();
     67f:	e8 b4 2b 00 00       	call   3238 <exit>
  // failed allocation?
  sbrk(-(sbrk(0) - oldbrk));
  int pids[32];
  int fds[2];
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
     684:	c7 44 24 04 b8 38 00 	movl   $0x38b8,0x4(%esp)
     68b:	00 
     68c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     693:	e8 f8 2c 00 00       	call   3390 <printf>
    exit();
     698:	e8 9b 2b 00 00       	call   3238 <exit>
    if(pid < 0){
      printf(stdout, "fork failed\n");
      exit();
    }
    if(pid == 0){
      printf(stdout, "oops could read %x = %x\n", a, *a);
     69d:	0f be 03             	movsbl (%ebx),%eax
     6a0:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     6a4:	c7 44 24 04 9f 38 00 	movl   $0x389f,0x4(%esp)
     6ab:	00 
     6ac:	89 44 24 0c          	mov    %eax,0xc(%esp)
     6b0:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
     6b5:	89 04 24             	mov    %eax,(%esp)
     6b8:	e8 d3 2c 00 00       	call   3390 <printf>
      kill(ppid);
     6bd:	89 34 24             	mov    %esi,(%esp)
     6c0:	e8 a3 2b 00 00       	call   3268 <kill>
      exit();
     6c5:	e8 6e 2b 00 00       	call   3238 <exit>
  // can we read the kernel's memory?
  for(a = (char*)(640*1024); a < (char *)2000000; a += 50000){
    int ppid = getpid();
    int pid = fork();
    if(pid < 0){
      printf(stdout, "fork failed\n");
     6ca:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
     6cf:	c7 44 24 04 5b 38 00 	movl   $0x385b,0x4(%esp)
     6d6:	00 
     6d7:	89 04 24             	mov    %eax,(%esp)
     6da:	e8 b1 2c 00 00       	call   3390 <printf>
      exit();
     6df:	e8 54 2b 00 00       	call   3238 <exit>
    exit();
  }

  c = sbrk(4096);
  if(c != (char *) 0xffffffff){
    printf(stdout, "sbrk was able to re-allocate beyond 640K, c %x\n", c);
     6e4:	89 44 24 08          	mov    %eax,0x8(%esp)
     6e8:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
     6ed:	c7 44 24 04 18 46 00 	movl   $0x4618,0x4(%esp)
     6f4:	00 
     6f5:	89 04 24             	mov    %eax,(%esp)
     6f8:	e8 93 2c 00 00       	call   3390 <printf>
    exit();
     6fd:	e8 36 2b 00 00       	call   3238 <exit>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    exit();
  }
  if(*lastaddr == 99){
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
     702:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
     707:	c7 44 24 04 e8 45 00 	movl   $0x45e8,0x4(%esp)
     70e:	00 
     70f:	89 04 24             	mov    %eax,(%esp)
     712:	e8 79 2c 00 00       	call   3390 <printf>
    exit();
     717:	e8 1c 2b 00 00       	call   3238 <exit>

  // can one re-allocate that page?
  a = sbrk(0);
  c = sbrk(4096);
  if(c != a || sbrk(0) != a + 4096){
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
     71c:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
     721:	89 74 24 0c          	mov    %esi,0xc(%esp)
     725:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     729:	c7 44 24 04 c0 45 00 	movl   $0x45c0,0x4(%esp)
     730:	00 
     731:	89 04 24             	mov    %eax,(%esp)
     734:	e8 57 2c 00 00       	call   3390 <printf>
    exit();
     739:	e8 fa 2a 00 00       	call   3238 <exit>
    printf(stdout, "sbrk could not deallocate\n");
    exit();
  }
  c = sbrk(0);
  if(c != a - 4096){
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
     73e:	89 44 24 0c          	mov    %eax,0xc(%esp)
     742:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
     747:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     74b:	c7 44 24 04 88 45 00 	movl   $0x4588,0x4(%esp)
     752:	00 
     753:	89 04 24             	mov    %eax,(%esp)
     756:	e8 35 2c 00 00       	call   3390 <printf>
    exit();
     75b:	e8 d8 2a 00 00       	call   3238 <exit>

  // can one de-allocate?
  a = sbrk(0);
  c = sbrk(-4096);
  if(c == (char *) 0xffffffff){
    printf(stdout, "sbrk could not deallocate\n");
     760:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
     765:	c7 44 24 04 84 38 00 	movl   $0x3884,0x4(%esp)
     76c:	00 
     76d:	89 04 24             	mov    %eax,(%esp)
     770:	e8 1b 2c 00 00       	call   3390 <printf>
    exit();
     775:	e8 be 2a 00 00       	call   3238 <exit>
  *lastaddr = 99;

  // is one forbidden from allocating more than 640K?
  c = sbrk(4096);
  if(c != (char *) 0xffffffff){
    printf(stdout, "sbrk allocated more than 640K, c %x\n", c);
     77a:	89 44 24 08          	mov    %eax,0x8(%esp)
     77e:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
     783:	c7 44 24 04 60 45 00 	movl   $0x4560,0x4(%esp)
     78a:	00 
     78b:	89 04 24             	mov    %eax,(%esp)
     78e:	e8 fd 2b 00 00       	call   3390 <printf>
    exit();
     793:	e8 a0 2a 00 00       	call   3238 <exit>
  // can one allocate the full 640K?
  a = sbrk(0);
  uint amt = (640 * 1024) - (uint) a;
  char *p = sbrk(amt);
  if(p != a){
    printf(stdout, "sbrk test failed 640K test, p %x a %x\n", p, a);
     798:	89 44 24 08          	mov    %eax,0x8(%esp)
     79c:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
     7a1:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
     7a5:	c7 44 24 04 38 45 00 	movl   $0x4538,0x4(%esp)
     7ac:	00 
     7ad:	89 04 24             	mov    %eax,(%esp)
     7b0:	e8 db 2b 00 00       	call   3390 <printf>
    exit();
     7b5:	e8 7e 2a 00 00       	call   3238 <exit>
    exit();
  }
  char *c = sbrk(1);
  c = sbrk(1);
  if(c != a + 1){
    printf(stdout, "sbrk test failed post-fork\n");
     7ba:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
     7bf:	c7 44 24 04 68 38 00 	movl   $0x3868,0x4(%esp)
     7c6:	00 
     7c7:	89 04 24             	mov    %eax,(%esp)
     7ca:	e8 c1 2b 00 00       	call   3390 <printf>
    exit();
     7cf:	e8 64 2a 00 00       	call   3238 <exit>
    *b = 1;
    a = b + 1;
  }
  pid = fork();
  if(pid < 0){
    printf(stdout, "sbrk test fork failed\n");
     7d4:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
     7d9:	c7 44 24 04 51 38 00 	movl   $0x3851,0x4(%esp)
     7e0:	00 
     7e1:	89 04 24             	mov    %eax,(%esp)
     7e4:	e8 a7 2b 00 00       	call   3390 <printf>
    exit();
     7e9:	e8 4a 2a 00 00       	call   3238 <exit>
     7ee:	66 90                	xchg   %ax,%ax

000007f0 <preempt>:
}

// meant to be run w/ at most two CPUs
void
preempt(void)
{
     7f0:	55                   	push   %ebp
     7f1:	89 e5                	mov    %esp,%ebp
     7f3:	57                   	push   %edi
     7f4:	56                   	push   %esi
     7f5:	53                   	push   %ebx
     7f6:	83 ec 2c             	sub    $0x2c,%esp
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
     7f9:	c7 44 24 04 f0 38 00 	movl   $0x38f0,0x4(%esp)
     800:	00 
     801:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     808:	e8 83 2b 00 00       	call   3390 <printf>
  pid1 = fork();
     80d:	e8 1e 2a 00 00       	call   3230 <fork>
  if(pid1 == 0)
     812:	85 c0                	test   %eax,%eax
{
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
  pid1 = fork();
     814:	89 c7                	mov    %eax,%edi
  if(pid1 == 0)
     816:	75 02                	jne    81a <preempt+0x2a>
     818:	eb fe                	jmp    818 <preempt+0x28>
     81a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for(;;)
      ;

  pid2 = fork();
     820:	e8 0b 2a 00 00       	call   3230 <fork>
  if(pid2 == 0)
     825:	85 c0                	test   %eax,%eax
  pid1 = fork();
  if(pid1 == 0)
    for(;;)
      ;

  pid2 = fork();
     827:	89 c6                	mov    %eax,%esi
  if(pid2 == 0)
     829:	75 02                	jne    82d <preempt+0x3d>
     82b:	eb fe                	jmp    82b <preempt+0x3b>
    for(;;)
      ;

  pipe(pfds);
     82d:	8d 45 e0             	lea    -0x20(%ebp),%eax
     830:	89 04 24             	mov    %eax,(%esp)
     833:	e8 10 2a 00 00       	call   3248 <pipe>
  pid3 = fork();
     838:	e8 f3 29 00 00       	call   3230 <fork>
  if(pid3 == 0){
     83d:	85 c0                	test   %eax,%eax
  if(pid2 == 0)
    for(;;)
      ;

  pipe(pfds);
  pid3 = fork();
     83f:	89 c3                	mov    %eax,%ebx
  if(pid3 == 0){
     841:	75 4c                	jne    88f <preempt+0x9f>
    close(pfds[0]);
     843:	8b 45 e0             	mov    -0x20(%ebp),%eax
     846:	89 04 24             	mov    %eax,(%esp)
     849:	e8 12 2a 00 00       	call   3260 <close>
    if(write(pfds[1], "x", 1) != 1)
     84e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     851:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     858:	00 
     859:	c7 44 24 04 f4 3d 00 	movl   $0x3df4,0x4(%esp)
     860:	00 
     861:	89 04 24             	mov    %eax,(%esp)
     864:	e8 ef 29 00 00       	call   3258 <write>
     869:	83 f8 01             	cmp    $0x1,%eax
     86c:	74 14                	je     882 <preempt+0x92>
      printf(1, "preempt write error");
     86e:	c7 44 24 04 fa 38 00 	movl   $0x38fa,0x4(%esp)
     875:	00 
     876:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     87d:	e8 0e 2b 00 00       	call   3390 <printf>
    close(pfds[1]);
     882:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     885:	89 04 24             	mov    %eax,(%esp)
     888:	e8 d3 29 00 00       	call   3260 <close>
     88d:	eb fe                	jmp    88d <preempt+0x9d>
    for(;;)
      ;
  }

  close(pfds[1]);
     88f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     892:	89 04 24             	mov    %eax,(%esp)
     895:	e8 c6 29 00 00       	call   3260 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     89a:	8b 45 e0             	mov    -0x20(%ebp),%eax
     89d:	c7 44 24 08 00 08 00 	movl   $0x800,0x8(%esp)
     8a4:	00 
     8a5:	c7 44 24 04 a0 4b 00 	movl   $0x4ba0,0x4(%esp)
     8ac:	00 
     8ad:	89 04 24             	mov    %eax,(%esp)
     8b0:	e8 9b 29 00 00       	call   3250 <read>
     8b5:	83 f8 01             	cmp    $0x1,%eax
     8b8:	74 1c                	je     8d6 <preempt+0xe6>
    printf(1, "preempt read error");
     8ba:	c7 44 24 04 0e 39 00 	movl   $0x390e,0x4(%esp)
     8c1:	00 
     8c2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     8c9:	e8 c2 2a 00 00       	call   3390 <printf>
  printf(1, "wait... ");
  wait();
  wait();
  wait();
  printf(1, "preempt ok\n");
}
     8ce:	83 c4 2c             	add    $0x2c,%esp
     8d1:	5b                   	pop    %ebx
     8d2:	5e                   	pop    %esi
     8d3:	5f                   	pop    %edi
     8d4:	5d                   	pop    %ebp
     8d5:	c3                   	ret    
  close(pfds[1]);
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    printf(1, "preempt read error");
    return;
  }
  close(pfds[0]);
     8d6:	8b 45 e0             	mov    -0x20(%ebp),%eax
     8d9:	89 04 24             	mov    %eax,(%esp)
     8dc:	e8 7f 29 00 00       	call   3260 <close>
  printf(1, "kill... ");
     8e1:	c7 44 24 04 21 39 00 	movl   $0x3921,0x4(%esp)
     8e8:	00 
     8e9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     8f0:	e8 9b 2a 00 00       	call   3390 <printf>
  kill(pid1);
     8f5:	89 3c 24             	mov    %edi,(%esp)
     8f8:	e8 6b 29 00 00       	call   3268 <kill>
  kill(pid2);
     8fd:	89 34 24             	mov    %esi,(%esp)
     900:	e8 63 29 00 00       	call   3268 <kill>
  kill(pid3);
     905:	89 1c 24             	mov    %ebx,(%esp)
     908:	e8 5b 29 00 00       	call   3268 <kill>
  printf(1, "wait... ");
     90d:	c7 44 24 04 2a 39 00 	movl   $0x392a,0x4(%esp)
     914:	00 
     915:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     91c:	e8 6f 2a 00 00       	call   3390 <printf>
  wait();
     921:	e8 1a 29 00 00       	call   3240 <wait>
  wait();
     926:	e8 15 29 00 00       	call   3240 <wait>
     92b:	90                   	nop
     92c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  wait();
     930:	e8 0b 29 00 00       	call   3240 <wait>
  printf(1, "preempt ok\n");
     935:	c7 44 24 04 33 39 00 	movl   $0x3933,0x4(%esp)
     93c:	00 
     93d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     944:	e8 47 2a 00 00       	call   3390 <printf>
     949:	eb 83                	jmp    8ce <preempt+0xde>
     94b:	90                   	nop
     94c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000950 <pipe1>:

// simple fork and pipe read/write

void
pipe1(void)
{
     950:	55                   	push   %ebp
     951:	89 e5                	mov    %esp,%ebp
     953:	57                   	push   %edi
     954:	56                   	push   %esi
     955:	53                   	push   %ebx
     956:	83 ec 2c             	sub    $0x2c,%esp
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
     959:	8d 45 e0             	lea    -0x20(%ebp),%eax
     95c:	89 04 24             	mov    %eax,(%esp)
     95f:	e8 e4 28 00 00       	call   3248 <pipe>
     964:	85 c0                	test   %eax,%eax
     966:	0f 85 53 01 00 00    	jne    abf <pipe1+0x16f>
    printf(1, "pipe() failed\n");
    exit();
  }
  pid = fork();
     96c:	e8 bf 28 00 00       	call   3230 <fork>
  seq = 0;
  if(pid == 0){
     971:	83 f8 00             	cmp    $0x0,%eax
     974:	0f 84 87 00 00 00    	je     a01 <pipe1+0xb1>
     97a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printf(1, "pipe1 oops 1\n");
        exit();
      }
    }
    exit();
  } else if(pid > 0){
     980:	0f 8e 52 01 00 00    	jle    ad8 <pipe1+0x188>
    close(fds[1]);
     986:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     989:	31 ff                	xor    %edi,%edi
     98b:	be 01 00 00 00       	mov    $0x1,%esi
     990:	31 db                	xor    %ebx,%ebx
     992:	89 04 24             	mov    %eax,(%esp)
     995:	e8 c6 28 00 00       	call   3260 <close>
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
     99a:	8b 45 e0             	mov    -0x20(%ebp),%eax
     99d:	89 74 24 08          	mov    %esi,0x8(%esp)
     9a1:	c7 44 24 04 a0 4b 00 	movl   $0x4ba0,0x4(%esp)
     9a8:	00 
     9a9:	89 04 24             	mov    %eax,(%esp)
     9ac:	e8 9f 28 00 00       	call   3250 <read>
     9b1:	85 c0                	test   %eax,%eax
     9b3:	0f 8e a4 00 00 00    	jle    a5d <pipe1+0x10d>
     9b9:	31 d2                	xor    %edx,%edx
     9bb:	90                   	nop
     9bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(i = 0; i < n; i++){
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     9c0:	38 9a a0 4b 00 00    	cmp    %bl,0x4ba0(%edx)
     9c6:	75 1d                	jne    9e5 <pipe1+0x95>
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
     9c8:	83 c2 01             	add    $0x1,%edx
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     9cb:	83 c3 01             	add    $0x1,%ebx
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
     9ce:	39 d0                	cmp    %edx,%eax
     9d0:	7f ee                	jg     9c0 <pipe1+0x70>
          printf(1, "pipe1 oops 2\n");
          return;
        }
      }
      total += n;
      cc = cc * 2;
     9d2:	01 f6                	add    %esi,%esi
      if(cc > sizeof(buf))
     9d4:	81 fe 00 08 00 00    	cmp    $0x800,%esi
     9da:	76 05                	jbe    9e1 <pipe1+0x91>
     9dc:	be 00 08 00 00       	mov    $0x800,%esi
        if((buf[i] & 0xff) != (seq++ & 0xff)){
          printf(1, "pipe1 oops 2\n");
          return;
        }
      }
      total += n;
     9e1:	01 c7                	add    %eax,%edi
     9e3:	eb b5                	jmp    99a <pipe1+0x4a>
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
        if((buf[i] & 0xff) != (seq++ & 0xff)){
          printf(1, "pipe1 oops 2\n");
     9e5:	c7 44 24 04 4d 39 00 	movl   $0x394d,0x4(%esp)
     9ec:	00 
     9ed:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     9f4:	e8 97 29 00 00       	call   3390 <printf>
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
}
     9f9:	83 c4 2c             	add    $0x2c,%esp
     9fc:	5b                   	pop    %ebx
     9fd:	5e                   	pop    %esi
     9fe:	5f                   	pop    %edi
     9ff:	5d                   	pop    %ebp
     a00:	c3                   	ret    
    exit();
  }
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
     a01:	8b 45 e0             	mov    -0x20(%ebp),%eax
     a04:	31 db                	xor    %ebx,%ebx
     a06:	89 04 24             	mov    %eax,(%esp)
     a09:	e8 52 28 00 00       	call   3260 <close>
    for(n = 0; n < 5; n++){
     a0e:	31 c0                	xor    %eax,%eax
      for(i = 0; i < 1033; i++)
        buf[i] = seq++;
     a10:	8d 14 18             	lea    (%eax,%ebx,1),%edx
     a13:	88 90 a0 4b 00 00    	mov    %dl,0x4ba0(%eax)
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
     a19:	83 c0 01             	add    $0x1,%eax
     a1c:	3d 09 04 00 00       	cmp    $0x409,%eax
     a21:	75 ed                	jne    a10 <pipe1+0xc0>
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
     a23:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
     a26:	81 c3 09 04 00 00    	add    $0x409,%ebx
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
     a2c:	c7 44 24 08 09 04 00 	movl   $0x409,0x8(%esp)
     a33:	00 
     a34:	c7 44 24 04 a0 4b 00 	movl   $0x4ba0,0x4(%esp)
     a3b:	00 
     a3c:	89 04 24             	mov    %eax,(%esp)
     a3f:	e8 14 28 00 00       	call   3258 <write>
     a44:	3d 09 04 00 00       	cmp    $0x409,%eax
     a49:	75 5b                	jne    aa6 <pipe1+0x156>
  }
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
     a4b:	81 fb 2d 14 00 00    	cmp    $0x142d,%ebx
     a51:	75 bb                	jne    a0e <pipe1+0xbe>
     a53:	90                   	nop
     a54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      printf(1, "pipe1 oops 3 total %d\n", total);
    close(fds[0]);
    wait();
  } else {
    printf(1, "fork() failed\n");
    exit();
     a58:	e8 db 27 00 00       	call   3238 <exit>
      total += n;
      cc = cc * 2;
      if(cc > sizeof(buf))
        cc = sizeof(buf);
    }
    if(total != 5 * 1033)
     a5d:	81 ff 2d 14 00 00    	cmp    $0x142d,%edi
     a63:	74 18                	je     a7d <pipe1+0x12d>
      printf(1, "pipe1 oops 3 total %d\n", total);
     a65:	89 7c 24 08          	mov    %edi,0x8(%esp)
     a69:	c7 44 24 04 5b 39 00 	movl   $0x395b,0x4(%esp)
     a70:	00 
     a71:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     a78:	e8 13 29 00 00       	call   3390 <printf>
    close(fds[0]);
     a7d:	8b 45 e0             	mov    -0x20(%ebp),%eax
     a80:	89 04 24             	mov    %eax,(%esp)
     a83:	e8 d8 27 00 00       	call   3260 <close>
    wait();
     a88:	e8 b3 27 00 00       	call   3240 <wait>
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
     a8d:	c7 44 24 04 72 39 00 	movl   $0x3972,0x4(%esp)
     a94:	00 
     a95:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     a9c:	e8 ef 28 00 00       	call   3390 <printf>
     aa1:	e9 53 ff ff ff       	jmp    9f9 <pipe1+0xa9>
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
        printf(1, "pipe1 oops 1\n");
     aa6:	c7 44 24 04 3f 39 00 	movl   $0x393f,0x4(%esp)
     aad:	00 
     aae:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     ab5:	e8 d6 28 00 00       	call   3390 <printf>
        exit();
     aba:	e8 79 27 00 00       	call   3238 <exit>
{
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
     abf:	c7 44 24 04 b8 38 00 	movl   $0x38b8,0x4(%esp)
     ac6:	00 
     ac7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     ace:	e8 bd 28 00 00       	call   3390 <printf>
    exit();
     ad3:	e8 60 27 00 00       	call   3238 <exit>
    if(total != 5 * 1033)
      printf(1, "pipe1 oops 3 total %d\n", total);
    close(fds[0]);
    wait();
  } else {
    printf(1, "fork() failed\n");
     ad8:	c7 44 24 04 7c 39 00 	movl   $0x397c,0x4(%esp)
     adf:	00 
     ae0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     ae7:	e8 a4 28 00 00       	call   3390 <printf>
     aec:	e9 62 ff ff ff       	jmp    a53 <pipe1+0x103>
     af1:	eb 0d                	jmp    b00 <fourteen>
     af3:	90                   	nop
     af4:	90                   	nop
     af5:	90                   	nop
     af6:	90                   	nop
     af7:	90                   	nop
     af8:	90                   	nop
     af9:	90                   	nop
     afa:	90                   	nop
     afb:	90                   	nop
     afc:	90                   	nop
     afd:	90                   	nop
     afe:	90                   	nop
     aff:	90                   	nop

00000b00 <fourteen>:
  printf(1, "bigfile test ok\n");
}

void
fourteen(void)
{
     b00:	55                   	push   %ebp
     b01:	89 e5                	mov    %esp,%ebp
     b03:	83 ec 18             	sub    $0x18,%esp
  int fd;

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");
     b06:	c7 44 24 04 8b 39 00 	movl   $0x398b,0x4(%esp)
     b0d:	00 
     b0e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b15:	e8 76 28 00 00       	call   3390 <printf>

  if(mkdir("12345678901234") != 0){
     b1a:	c7 04 24 c6 39 00 00 	movl   $0x39c6,(%esp)
     b21:	e8 7a 27 00 00       	call   32a0 <mkdir>
     b26:	85 c0                	test   %eax,%eax
     b28:	0f 85 92 00 00 00    	jne    bc0 <fourteen+0xc0>
    printf(1, "mkdir 12345678901234 failed\n");
    exit();
  }
  if(mkdir("12345678901234/123456789012345") != 0){
     b2e:	c7 04 24 48 46 00 00 	movl   $0x4648,(%esp)
     b35:	e8 66 27 00 00       	call   32a0 <mkdir>
     b3a:	85 c0                	test   %eax,%eax
     b3c:	0f 85 fb 00 00 00    	jne    c3d <fourteen+0x13d>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    exit();
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
     b42:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
     b49:	00 
     b4a:	c7 04 24 98 46 00 00 	movl   $0x4698,(%esp)
     b51:	e8 22 27 00 00       	call   3278 <open>
  if(fd < 0){
     b56:	85 c0                	test   %eax,%eax
     b58:	0f 88 c6 00 00 00    	js     c24 <fourteen+0x124>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    exit();
  }
  close(fd);
     b5e:	89 04 24             	mov    %eax,(%esp)
     b61:	e8 fa 26 00 00       	call   3260 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
     b66:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     b6d:	00 
     b6e:	c7 04 24 08 47 00 00 	movl   $0x4708,(%esp)
     b75:	e8 fe 26 00 00       	call   3278 <open>
  if(fd < 0){
     b7a:	85 c0                	test   %eax,%eax
     b7c:	0f 88 89 00 00 00    	js     c0b <fourteen+0x10b>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    exit();
  }
  close(fd);
     b82:	89 04 24             	mov    %eax,(%esp)
     b85:	e8 d6 26 00 00       	call   3260 <close>

  if(mkdir("12345678901234/12345678901234") == 0){
     b8a:	c7 04 24 b7 39 00 00 	movl   $0x39b7,(%esp)
     b91:	e8 0a 27 00 00       	call   32a0 <mkdir>
     b96:	85 c0                	test   %eax,%eax
     b98:	74 58                	je     bf2 <fourteen+0xf2>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    exit();
  }
  if(mkdir("123456789012345/12345678901234") == 0){
     b9a:	c7 04 24 a4 47 00 00 	movl   $0x47a4,(%esp)
     ba1:	e8 fa 26 00 00       	call   32a0 <mkdir>
     ba6:	85 c0                	test   %eax,%eax
     ba8:	74 2f                	je     bd9 <fourteen+0xd9>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    exit();
  }

  printf(1, "fourteen ok\n");
     baa:	c7 44 24 04 d5 39 00 	movl   $0x39d5,0x4(%esp)
     bb1:	00 
     bb2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     bb9:	e8 d2 27 00 00       	call   3390 <printf>
}
     bbe:	c9                   	leave  
     bbf:	c3                   	ret    

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");

  if(mkdir("12345678901234") != 0){
    printf(1, "mkdir 12345678901234 failed\n");
     bc0:	c7 44 24 04 9a 39 00 	movl   $0x399a,0x4(%esp)
     bc7:	00 
     bc8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     bcf:	e8 bc 27 00 00       	call   3390 <printf>
    exit();
     bd4:	e8 5f 26 00 00       	call   3238 <exit>
  if(mkdir("12345678901234/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    exit();
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
     bd9:	c7 44 24 04 c4 47 00 	movl   $0x47c4,0x4(%esp)
     be0:	00 
     be1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     be8:	e8 a3 27 00 00       	call   3390 <printf>
    exit();
     bed:	e8 46 26 00 00       	call   3238 <exit>
    exit();
  }
  close(fd);

  if(mkdir("12345678901234/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
     bf2:	c7 44 24 04 74 47 00 	movl   $0x4774,0x4(%esp)
     bf9:	00 
     bfa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     c01:	e8 8a 27 00 00       	call   3390 <printf>
    exit();
     c06:	e8 2d 26 00 00       	call   3238 <exit>
    exit();
  }
  close(fd);
  fd = open("12345678901234/12345678901234/12345678901234", 0);
  if(fd < 0){
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
     c0b:	c7 44 24 04 38 47 00 	movl   $0x4738,0x4(%esp)
     c12:	00 
     c13:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     c1a:	e8 71 27 00 00       	call   3390 <printf>
    exit();
     c1f:	e8 14 26 00 00       	call   3238 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    exit();
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
  if(fd < 0){
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
     c24:	c7 44 24 04 c8 46 00 	movl   $0x46c8,0x4(%esp)
     c2b:	00 
     c2c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     c33:	e8 58 27 00 00       	call   3390 <printf>
    exit();
     c38:	e8 fb 25 00 00       	call   3238 <exit>
  if(mkdir("12345678901234") != 0){
    printf(1, "mkdir 12345678901234 failed\n");
    exit();
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
     c3d:	c7 44 24 04 68 46 00 	movl   $0x4668,0x4(%esp)
     c44:	00 
     c45:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     c4c:	e8 3f 27 00 00       	call   3390 <printf>
    exit();
     c51:	e8 e2 25 00 00       	call   3238 <exit>
     c56:	8d 76 00             	lea    0x0(%esi),%esi
     c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c60 <iref>:
}

// test that iput() is called at the end of _namei()
void
iref(void)
{
     c60:	55                   	push   %ebp
     c61:	89 e5                	mov    %esp,%ebp
     c63:	53                   	push   %ebx
  int i, fd;

  printf(1, "empty file name\n");
     c64:	31 db                	xor    %ebx,%ebx
}

// test that iput() is called at the end of _namei()
void
iref(void)
{
     c66:	83 ec 14             	sub    $0x14,%esp
  int i, fd;

  printf(1, "empty file name\n");
     c69:	c7 44 24 04 e2 39 00 	movl   $0x39e2,0x4(%esp)
     c70:	00 
     c71:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     c78:	e8 13 27 00 00       	call   3390 <printf>
     c7d:	8d 76 00             	lea    0x0(%esi),%esi

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    if(mkdir("irefd") != 0){
     c80:	c7 04 24 f3 39 00 00 	movl   $0x39f3,(%esp)
     c87:	e8 14 26 00 00       	call   32a0 <mkdir>
     c8c:	85 c0                	test   %eax,%eax
     c8e:	0f 85 b2 00 00 00    	jne    d46 <iref+0xe6>
      printf(1, "mkdir irefd failed\n");
      exit();
    }
    if(chdir("irefd") != 0){
     c94:	c7 04 24 f3 39 00 00 	movl   $0x39f3,(%esp)
     c9b:	e8 08 26 00 00       	call   32a8 <chdir>
     ca0:	85 c0                	test   %eax,%eax
     ca2:	0f 85 b7 00 00 00    	jne    d5f <iref+0xff>
      printf(1, "chdir irefd failed\n");
      exit();
    }

    mkdir("");
     ca8:	c7 04 24 ae 44 00 00 	movl   $0x44ae,(%esp)
     caf:	e8 ec 25 00 00       	call   32a0 <mkdir>
    link("README", "");
     cb4:	c7 44 24 04 ae 44 00 	movl   $0x44ae,0x4(%esp)
     cbb:	00 
     cbc:	c7 04 24 21 3a 00 00 	movl   $0x3a21,(%esp)
     cc3:	e8 d0 25 00 00       	call   3298 <link>
    fd = open("", O_CREATE);
     cc8:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
     ccf:	00 
     cd0:	c7 04 24 ae 44 00 00 	movl   $0x44ae,(%esp)
     cd7:	e8 9c 25 00 00       	call   3278 <open>
    if(fd >= 0)
     cdc:	85 c0                	test   %eax,%eax
     cde:	78 08                	js     ce8 <iref+0x88>
      close(fd);
     ce0:	89 04 24             	mov    %eax,(%esp)
     ce3:	e8 78 25 00 00       	call   3260 <close>
    fd = open("xx", O_CREATE);
     ce8:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
     cef:	00 
     cf0:	c7 04 24 f3 3d 00 00 	movl   $0x3df3,(%esp)
     cf7:	e8 7c 25 00 00       	call   3278 <open>
    if(fd >= 0)
     cfc:	85 c0                	test   %eax,%eax
     cfe:	78 08                	js     d08 <iref+0xa8>
      close(fd);
     d00:	89 04 24             	mov    %eax,(%esp)
     d03:	e8 58 25 00 00       	call   3260 <close>
  int i, fd;

  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
     d08:	83 c3 01             	add    $0x1,%ebx
    if(fd >= 0)
      close(fd);
    fd = open("xx", O_CREATE);
    if(fd >= 0)
      close(fd);
    unlink("xx");
     d0b:	c7 04 24 f3 3d 00 00 	movl   $0x3df3,(%esp)
     d12:	e8 71 25 00 00       	call   3288 <unlink>
  int i, fd;

  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
     d17:	83 fb 33             	cmp    $0x33,%ebx
     d1a:	0f 85 60 ff ff ff    	jne    c80 <iref+0x20>
    if(fd >= 0)
      close(fd);
    unlink("xx");
  }

  chdir("/");
     d20:	c7 04 24 28 3a 00 00 	movl   $0x3a28,(%esp)
     d27:	e8 7c 25 00 00       	call   32a8 <chdir>
  printf(1, "empty file name OK\n");
     d2c:	c7 44 24 04 2a 3a 00 	movl   $0x3a2a,0x4(%esp)
     d33:	00 
     d34:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d3b:	e8 50 26 00 00       	call   3390 <printf>
}
     d40:	83 c4 14             	add    $0x14,%esp
     d43:	5b                   	pop    %ebx
     d44:	5d                   	pop    %ebp
     d45:	c3                   	ret    
  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    if(mkdir("irefd") != 0){
      printf(1, "mkdir irefd failed\n");
     d46:	c7 44 24 04 f9 39 00 	movl   $0x39f9,0x4(%esp)
     d4d:	00 
     d4e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d55:	e8 36 26 00 00       	call   3390 <printf>
      exit();
     d5a:	e8 d9 24 00 00       	call   3238 <exit>
    }
    if(chdir("irefd") != 0){
      printf(1, "chdir irefd failed\n");
     d5f:	c7 44 24 04 0d 3a 00 	movl   $0x3a0d,0x4(%esp)
     d66:	00 
     d67:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d6e:	e8 1d 26 00 00       	call   3390 <printf>
      exit();
     d73:	e8 c0 24 00 00       	call   3238 <exit>
     d78:	90                   	nop
     d79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000d80 <dirfile>:
  printf(1, "rmdot ok\n");
}

void
dirfile(void)
{
     d80:	55                   	push   %ebp
     d81:	89 e5                	mov    %esp,%ebp
     d83:	53                   	push   %ebx
     d84:	83 ec 14             	sub    $0x14,%esp
  int fd;

  printf(1, "dir vs file\n");
     d87:	c7 44 24 04 3e 3a 00 	movl   $0x3a3e,0x4(%esp)
     d8e:	00 
     d8f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d96:	e8 f5 25 00 00       	call   3390 <printf>

  fd = open("dirfile", O_CREATE);
     d9b:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
     da2:	00 
     da3:	c7 04 24 4b 3a 00 00 	movl   $0x3a4b,(%esp)
     daa:	e8 c9 24 00 00       	call   3278 <open>
  if(fd < 0){
     daf:	85 c0                	test   %eax,%eax
     db1:	0f 88 4e 01 00 00    	js     f05 <dirfile+0x185>
    printf(1, "create dirfile failed\n");
    exit();
  }
  close(fd);
     db7:	89 04 24             	mov    %eax,(%esp)
     dba:	e8 a1 24 00 00       	call   3260 <close>
  if(chdir("dirfile") == 0){
     dbf:	c7 04 24 4b 3a 00 00 	movl   $0x3a4b,(%esp)
     dc6:	e8 dd 24 00 00       	call   32a8 <chdir>
     dcb:	85 c0                	test   %eax,%eax
     dcd:	0f 84 19 01 00 00    	je     eec <dirfile+0x16c>
    printf(1, "chdir dirfile succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", 0);
     dd3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     dda:	00 
     ddb:	c7 04 24 84 3a 00 00 	movl   $0x3a84,(%esp)
     de2:	e8 91 24 00 00       	call   3278 <open>
  if(fd >= 0){
     de7:	85 c0                	test   %eax,%eax
     de9:	0f 89 e4 00 00 00    	jns    ed3 <dirfile+0x153>
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", O_CREATE);
     def:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
     df6:	00 
     df7:	c7 04 24 84 3a 00 00 	movl   $0x3a84,(%esp)
     dfe:	e8 75 24 00 00       	call   3278 <open>
  if(fd >= 0){
     e03:	85 c0                	test   %eax,%eax
     e05:	0f 89 c8 00 00 00    	jns    ed3 <dirfile+0x153>
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  if(mkdir("dirfile/xx") == 0){
     e0b:	c7 04 24 84 3a 00 00 	movl   $0x3a84,(%esp)
     e12:	e8 89 24 00 00       	call   32a0 <mkdir>
     e17:	85 c0                	test   %eax,%eax
     e19:	0f 84 7c 01 00 00    	je     f9b <dirfile+0x21b>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile/xx") == 0){
     e1f:	c7 04 24 84 3a 00 00 	movl   $0x3a84,(%esp)
     e26:	e8 5d 24 00 00       	call   3288 <unlink>
     e2b:	85 c0                	test   %eax,%eax
     e2d:	0f 84 4f 01 00 00    	je     f82 <dirfile+0x202>
    printf(1, "unlink dirfile/xx succeeded!\n");
    exit();
  }
  if(link("README", "dirfile/xx") == 0){
     e33:	c7 44 24 04 84 3a 00 	movl   $0x3a84,0x4(%esp)
     e3a:	00 
     e3b:	c7 04 24 21 3a 00 00 	movl   $0x3a21,(%esp)
     e42:	e8 51 24 00 00       	call   3298 <link>
     e47:	85 c0                	test   %eax,%eax
     e49:	0f 84 1a 01 00 00    	je     f69 <dirfile+0x1e9>
    printf(1, "link to dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile") != 0){
     e4f:	c7 04 24 4b 3a 00 00 	movl   $0x3a4b,(%esp)
     e56:	e8 2d 24 00 00       	call   3288 <unlink>
     e5b:	85 c0                	test   %eax,%eax
     e5d:	0f 85 ed 00 00 00    	jne    f50 <dirfile+0x1d0>
    printf(1, "unlink dirfile failed!\n");
    exit();
  }

  fd = open(".", O_RDWR);
     e63:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
     e6a:	00 
     e6b:	c7 04 24 11 3d 00 00 	movl   $0x3d11,(%esp)
     e72:	e8 01 24 00 00       	call   3278 <open>
  if(fd >= 0){
     e77:	85 c0                	test   %eax,%eax
     e79:	0f 89 b8 00 00 00    	jns    f37 <dirfile+0x1b7>
    printf(1, "open . for writing succeeded!\n");
    exit();
  }
  fd = open(".", 0);
     e7f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     e86:	00 
     e87:	c7 04 24 11 3d 00 00 	movl   $0x3d11,(%esp)
     e8e:	e8 e5 23 00 00       	call   3278 <open>
  if(write(fd, "x", 1) > 0){
     e93:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     e9a:	00 
     e9b:	c7 44 24 04 f4 3d 00 	movl   $0x3df4,0x4(%esp)
     ea2:	00 
  fd = open(".", O_RDWR);
  if(fd >= 0){
    printf(1, "open . for writing succeeded!\n");
    exit();
  }
  fd = open(".", 0);
     ea3:	89 c3                	mov    %eax,%ebx
  if(write(fd, "x", 1) > 0){
     ea5:	89 04 24             	mov    %eax,(%esp)
     ea8:	e8 ab 23 00 00       	call   3258 <write>
     ead:	85 c0                	test   %eax,%eax
     eaf:	7f 6d                	jg     f1e <dirfile+0x19e>
    printf(1, "write . succeeded!\n");
    exit();
  }
  close(fd);
     eb1:	89 1c 24             	mov    %ebx,(%esp)
     eb4:	e8 a7 23 00 00       	call   3260 <close>

  printf(1, "dir vs file OK\n");
     eb9:	c7 44 24 04 14 3b 00 	movl   $0x3b14,0x4(%esp)
     ec0:	00 
     ec1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     ec8:	e8 c3 24 00 00       	call   3390 <printf>
}
     ecd:	83 c4 14             	add    $0x14,%esp
     ed0:	5b                   	pop    %ebx
     ed1:	5d                   	pop    %ebp
     ed2:	c3                   	ret    
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", O_CREATE);
  if(fd >= 0){
    printf(1, "create dirfile/xx succeeded!\n");
     ed3:	c7 44 24 04 8f 3a 00 	movl   $0x3a8f,0x4(%esp)
     eda:	00 
     edb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     ee2:	e8 a9 24 00 00       	call   3390 <printf>
    exit();
     ee7:	e8 4c 23 00 00       	call   3238 <exit>
    printf(1, "create dirfile failed\n");
    exit();
  }
  close(fd);
  if(chdir("dirfile") == 0){
    printf(1, "chdir dirfile succeeded!\n");
     eec:	c7 44 24 04 6a 3a 00 	movl   $0x3a6a,0x4(%esp)
     ef3:	00 
     ef4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     efb:	e8 90 24 00 00       	call   3390 <printf>
    exit();
     f00:	e8 33 23 00 00       	call   3238 <exit>

  printf(1, "dir vs file\n");

  fd = open("dirfile", O_CREATE);
  if(fd < 0){
    printf(1, "create dirfile failed\n");
     f05:	c7 44 24 04 53 3a 00 	movl   $0x3a53,0x4(%esp)
     f0c:	00 
     f0d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f14:	e8 77 24 00 00       	call   3390 <printf>
    exit();
     f19:	e8 1a 23 00 00       	call   3238 <exit>
    printf(1, "open . for writing succeeded!\n");
    exit();
  }
  fd = open(".", 0);
  if(write(fd, "x", 1) > 0){
    printf(1, "write . succeeded!\n");
     f1e:	c7 44 24 04 00 3b 00 	movl   $0x3b00,0x4(%esp)
     f25:	00 
     f26:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f2d:	e8 5e 24 00 00       	call   3390 <printf>
    exit();
     f32:	e8 01 23 00 00       	call   3238 <exit>
    exit();
  }

  fd = open(".", O_RDWR);
  if(fd >= 0){
    printf(1, "open . for writing succeeded!\n");
     f37:	c7 44 24 04 18 48 00 	movl   $0x4818,0x4(%esp)
     f3e:	00 
     f3f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f46:	e8 45 24 00 00       	call   3390 <printf>
    exit();
     f4b:	e8 e8 22 00 00       	call   3238 <exit>
  if(link("README", "dirfile/xx") == 0){
    printf(1, "link to dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile") != 0){
    printf(1, "unlink dirfile failed!\n");
     f50:	c7 44 24 04 e8 3a 00 	movl   $0x3ae8,0x4(%esp)
     f57:	00 
     f58:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f5f:	e8 2c 24 00 00       	call   3390 <printf>
    exit();
     f64:	e8 cf 22 00 00       	call   3238 <exit>
  if(unlink("dirfile/xx") == 0){
    printf(1, "unlink dirfile/xx succeeded!\n");
    exit();
  }
  if(link("README", "dirfile/xx") == 0){
    printf(1, "link to dirfile/xx succeeded!\n");
     f69:	c7 44 24 04 f8 47 00 	movl   $0x47f8,0x4(%esp)
     f70:	00 
     f71:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f78:	e8 13 24 00 00       	call   3390 <printf>
    exit();
     f7d:	e8 b6 22 00 00       	call   3238 <exit>
  if(mkdir("dirfile/xx") == 0){
    printf(1, "mkdir dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile/xx") == 0){
    printf(1, "unlink dirfile/xx succeeded!\n");
     f82:	c7 44 24 04 ca 3a 00 	movl   $0x3aca,0x4(%esp)
     f89:	00 
     f8a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f91:	e8 fa 23 00 00       	call   3390 <printf>
    exit();
     f96:	e8 9d 22 00 00       	call   3238 <exit>
  if(fd >= 0){
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  if(mkdir("dirfile/xx") == 0){
    printf(1, "mkdir dirfile/xx succeeded!\n");
     f9b:	c7 44 24 04 ad 3a 00 	movl   $0x3aad,0x4(%esp)
     fa2:	00 
     fa3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     faa:	e8 e1 23 00 00       	call   3390 <printf>
    exit();
     faf:	e8 84 22 00 00       	call   3238 <exit>
     fb4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     fba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000fc0 <rmdot>:
  printf(1, "fourteen ok\n");
}

void
rmdot(void)
{
     fc0:	55                   	push   %ebp
     fc1:	89 e5                	mov    %esp,%ebp
     fc3:	83 ec 18             	sub    $0x18,%esp
  printf(1, "rmdot test\n");
     fc6:	c7 44 24 04 24 3b 00 	movl   $0x3b24,0x4(%esp)
     fcd:	00 
     fce:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     fd5:	e8 b6 23 00 00       	call   3390 <printf>
  if(mkdir("dots") != 0){
     fda:	c7 04 24 30 3b 00 00 	movl   $0x3b30,(%esp)
     fe1:	e8 ba 22 00 00       	call   32a0 <mkdir>
     fe6:	85 c0                	test   %eax,%eax
     fe8:	0f 85 9a 00 00 00    	jne    1088 <rmdot+0xc8>
    printf(1, "mkdir dots failed\n");
    exit();
  }
  if(chdir("dots") != 0){
     fee:	c7 04 24 30 3b 00 00 	movl   $0x3b30,(%esp)
     ff5:	e8 ae 22 00 00       	call   32a8 <chdir>
     ffa:	85 c0                	test   %eax,%eax
     ffc:	0f 85 35 01 00 00    	jne    1137 <rmdot+0x177>
    printf(1, "chdir dots failed\n");
    exit();
  }
  if(unlink(".") == 0){
    1002:	c7 04 24 11 3d 00 00 	movl   $0x3d11,(%esp)
    1009:	e8 7a 22 00 00       	call   3288 <unlink>
    100e:	85 c0                	test   %eax,%eax
    1010:	0f 84 08 01 00 00    	je     111e <rmdot+0x15e>
    printf(1, "rm . worked!\n");
    exit();
  }
  if(unlink("..") == 0){
    1016:	c7 04 24 10 3d 00 00 	movl   $0x3d10,(%esp)
    101d:	e8 66 22 00 00       	call   3288 <unlink>
    1022:	85 c0                	test   %eax,%eax
    1024:	0f 84 db 00 00 00    	je     1105 <rmdot+0x145>
    printf(1, "rm .. worked!\n");
    exit();
  }
  if(chdir("/") != 0){
    102a:	c7 04 24 28 3a 00 00 	movl   $0x3a28,(%esp)
    1031:	e8 72 22 00 00       	call   32a8 <chdir>
    1036:	85 c0                	test   %eax,%eax
    1038:	0f 85 ae 00 00 00    	jne    10ec <rmdot+0x12c>
    printf(1, "chdir / failed\n");
    exit();
  }
  if(unlink("dots/.") == 0){
    103e:	c7 04 24 88 3b 00 00 	movl   $0x3b88,(%esp)
    1045:	e8 3e 22 00 00       	call   3288 <unlink>
    104a:	85 c0                	test   %eax,%eax
    104c:	0f 84 81 00 00 00    	je     10d3 <rmdot+0x113>
    printf(1, "unlink dots/. worked!\n");
    exit();
  }
  if(unlink("dots/..") == 0){
    1052:	c7 04 24 a6 3b 00 00 	movl   $0x3ba6,(%esp)
    1059:	e8 2a 22 00 00       	call   3288 <unlink>
    105e:	85 c0                	test   %eax,%eax
    1060:	74 58                	je     10ba <rmdot+0xfa>
    printf(1, "unlink dots/.. worked!\n");
    exit();
  }
  if(unlink("dots") != 0){
    1062:	c7 04 24 30 3b 00 00 	movl   $0x3b30,(%esp)
    1069:	e8 1a 22 00 00       	call   3288 <unlink>
    106e:	85 c0                	test   %eax,%eax
    1070:	75 2f                	jne    10a1 <rmdot+0xe1>
    printf(1, "unlink dots failed!\n");
    exit();
  }
  printf(1, "rmdot ok\n");
    1072:	c7 44 24 04 db 3b 00 	movl   $0x3bdb,0x4(%esp)
    1079:	00 
    107a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1081:	e8 0a 23 00 00       	call   3390 <printf>
}
    1086:	c9                   	leave  
    1087:	c3                   	ret    
void
rmdot(void)
{
  printf(1, "rmdot test\n");
  if(mkdir("dots") != 0){
    printf(1, "mkdir dots failed\n");
    1088:	c7 44 24 04 35 3b 00 	movl   $0x3b35,0x4(%esp)
    108f:	00 
    1090:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1097:	e8 f4 22 00 00       	call   3390 <printf>
    exit();
    109c:	e8 97 21 00 00       	call   3238 <exit>
  if(unlink("dots/..") == 0){
    printf(1, "unlink dots/.. worked!\n");
    exit();
  }
  if(unlink("dots") != 0){
    printf(1, "unlink dots failed!\n");
    10a1:	c7 44 24 04 c6 3b 00 	movl   $0x3bc6,0x4(%esp)
    10a8:	00 
    10a9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10b0:	e8 db 22 00 00       	call   3390 <printf>
    exit();
    10b5:	e8 7e 21 00 00       	call   3238 <exit>
  if(unlink("dots/.") == 0){
    printf(1, "unlink dots/. worked!\n");
    exit();
  }
  if(unlink("dots/..") == 0){
    printf(1, "unlink dots/.. worked!\n");
    10ba:	c7 44 24 04 ae 3b 00 	movl   $0x3bae,0x4(%esp)
    10c1:	00 
    10c2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10c9:	e8 c2 22 00 00       	call   3390 <printf>
    exit();
    10ce:	e8 65 21 00 00       	call   3238 <exit>
  if(chdir("/") != 0){
    printf(1, "chdir / failed\n");
    exit();
  }
  if(unlink("dots/.") == 0){
    printf(1, "unlink dots/. worked!\n");
    10d3:	c7 44 24 04 8f 3b 00 	movl   $0x3b8f,0x4(%esp)
    10da:	00 
    10db:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10e2:	e8 a9 22 00 00       	call   3390 <printf>
    exit();
    10e7:	e8 4c 21 00 00       	call   3238 <exit>
  if(unlink("..") == 0){
    printf(1, "rm .. worked!\n");
    exit();
  }
  if(chdir("/") != 0){
    printf(1, "chdir / failed\n");
    10ec:	c7 44 24 04 78 3b 00 	movl   $0x3b78,0x4(%esp)
    10f3:	00 
    10f4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10fb:	e8 90 22 00 00       	call   3390 <printf>
    exit();
    1100:	e8 33 21 00 00       	call   3238 <exit>
  if(unlink(".") == 0){
    printf(1, "rm . worked!\n");
    exit();
  }
  if(unlink("..") == 0){
    printf(1, "rm .. worked!\n");
    1105:	c7 44 24 04 69 3b 00 	movl   $0x3b69,0x4(%esp)
    110c:	00 
    110d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1114:	e8 77 22 00 00       	call   3390 <printf>
    exit();
    1119:	e8 1a 21 00 00       	call   3238 <exit>
  if(chdir("dots") != 0){
    printf(1, "chdir dots failed\n");
    exit();
  }
  if(unlink(".") == 0){
    printf(1, "rm . worked!\n");
    111e:	c7 44 24 04 5b 3b 00 	movl   $0x3b5b,0x4(%esp)
    1125:	00 
    1126:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    112d:	e8 5e 22 00 00       	call   3390 <printf>
    exit();
    1132:	e8 01 21 00 00       	call   3238 <exit>
  if(mkdir("dots") != 0){
    printf(1, "mkdir dots failed\n");
    exit();
  }
  if(chdir("dots") != 0){
    printf(1, "chdir dots failed\n");
    1137:	c7 44 24 04 48 3b 00 	movl   $0x3b48,0x4(%esp)
    113e:	00 
    113f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1146:	e8 45 22 00 00       	call   3390 <printf>
    exit();
    114b:	e8 e8 20 00 00       	call   3238 <exit>

00001150 <subdir>:
  printf(1, "bigdir ok\n");
}

void
subdir(void)
{
    1150:	55                   	push   %ebp
    1151:	89 e5                	mov    %esp,%ebp
    1153:	53                   	push   %ebx
    1154:	83 ec 14             	sub    $0x14,%esp
  int fd, cc;

  printf(1, "subdir test\n");
    1157:	c7 44 24 04 e5 3b 00 	movl   $0x3be5,0x4(%esp)
    115e:	00 
    115f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1166:	e8 25 22 00 00       	call   3390 <printf>

  unlink("ff");
    116b:	c7 04 24 6e 3c 00 00 	movl   $0x3c6e,(%esp)
    1172:	e8 11 21 00 00       	call   3288 <unlink>
  if(mkdir("dd") != 0){
    1177:	c7 04 24 0b 3d 00 00 	movl   $0x3d0b,(%esp)
    117e:	e8 1d 21 00 00       	call   32a0 <mkdir>
    1183:	85 c0                	test   %eax,%eax
    1185:	0f 85 07 06 00 00    	jne    1792 <subdir+0x642>
    printf(1, "subdir mkdir dd failed\n");
    exit();
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    118b:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1192:	00 
    1193:	c7 04 24 44 3c 00 00 	movl   $0x3c44,(%esp)
    119a:	e8 d9 20 00 00       	call   3278 <open>
  if(fd < 0){
    119f:	85 c0                	test   %eax,%eax
  if(mkdir("dd") != 0){
    printf(1, "subdir mkdir dd failed\n");
    exit();
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    11a1:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    11a3:	0f 88 d0 05 00 00    	js     1779 <subdir+0x629>
    printf(1, "create dd/ff failed\n");
    exit();
  }
  write(fd, "ff", 2);
    11a9:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
    11b0:	00 
    11b1:	c7 44 24 04 6e 3c 00 	movl   $0x3c6e,0x4(%esp)
    11b8:	00 
    11b9:	89 04 24             	mov    %eax,(%esp)
    11bc:	e8 97 20 00 00       	call   3258 <write>
  close(fd);
    11c1:	89 1c 24             	mov    %ebx,(%esp)
    11c4:	e8 97 20 00 00       	call   3260 <close>
  
  if(unlink("dd") >= 0){
    11c9:	c7 04 24 0b 3d 00 00 	movl   $0x3d0b,(%esp)
    11d0:	e8 b3 20 00 00       	call   3288 <unlink>
    11d5:	85 c0                	test   %eax,%eax
    11d7:	0f 89 83 05 00 00    	jns    1760 <subdir+0x610>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    exit();
  }

  if(mkdir("/dd/dd") != 0){
    11dd:	c7 04 24 1f 3c 00 00 	movl   $0x3c1f,(%esp)
    11e4:	e8 b7 20 00 00       	call   32a0 <mkdir>
    11e9:	85 c0                	test   %eax,%eax
    11eb:	0f 85 56 05 00 00    	jne    1747 <subdir+0x5f7>
    printf(1, "subdir mkdir dd/dd failed\n");
    exit();
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    11f1:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    11f8:	00 
    11f9:	c7 04 24 41 3c 00 00 	movl   $0x3c41,(%esp)
    1200:	e8 73 20 00 00       	call   3278 <open>
  if(fd < 0){
    1205:	85 c0                	test   %eax,%eax
  if(mkdir("/dd/dd") != 0){
    printf(1, "subdir mkdir dd/dd failed\n");
    exit();
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1207:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1209:	0f 88 25 04 00 00    	js     1634 <subdir+0x4e4>
    printf(1, "create dd/dd/ff failed\n");
    exit();
  }
  write(fd, "FF", 2);
    120f:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
    1216:	00 
    1217:	c7 44 24 04 62 3c 00 	movl   $0x3c62,0x4(%esp)
    121e:	00 
    121f:	89 04 24             	mov    %eax,(%esp)
    1222:	e8 31 20 00 00       	call   3258 <write>
  close(fd);
    1227:	89 1c 24             	mov    %ebx,(%esp)
    122a:	e8 31 20 00 00       	call   3260 <close>

  fd = open("dd/dd/../ff", 0);
    122f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1236:	00 
    1237:	c7 04 24 65 3c 00 00 	movl   $0x3c65,(%esp)
    123e:	e8 35 20 00 00       	call   3278 <open>
  if(fd < 0){
    1243:	85 c0                	test   %eax,%eax
    exit();
  }
  write(fd, "FF", 2);
  close(fd);

  fd = open("dd/dd/../ff", 0);
    1245:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1247:	0f 88 ce 03 00 00    	js     161b <subdir+0x4cb>
    printf(1, "open dd/dd/../ff failed\n");
    exit();
  }
  cc = read(fd, buf, sizeof(buf));
    124d:	c7 44 24 08 00 08 00 	movl   $0x800,0x8(%esp)
    1254:	00 
    1255:	c7 44 24 04 a0 4b 00 	movl   $0x4ba0,0x4(%esp)
    125c:	00 
    125d:	89 04 24             	mov    %eax,(%esp)
    1260:	e8 eb 1f 00 00       	call   3250 <read>
  if(cc != 2 || buf[0] != 'f'){
    1265:	83 f8 02             	cmp    $0x2,%eax
    1268:	0f 85 fe 02 00 00    	jne    156c <subdir+0x41c>
    126e:	80 3d a0 4b 00 00 66 	cmpb   $0x66,0x4ba0
    1275:	0f 85 f1 02 00 00    	jne    156c <subdir+0x41c>
    printf(1, "dd/dd/../ff wrong content\n");
    exit();
  }
  close(fd);
    127b:	89 1c 24             	mov    %ebx,(%esp)
    127e:	e8 dd 1f 00 00       	call   3260 <close>

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    1283:	c7 44 24 04 a5 3c 00 	movl   $0x3ca5,0x4(%esp)
    128a:	00 
    128b:	c7 04 24 41 3c 00 00 	movl   $0x3c41,(%esp)
    1292:	e8 01 20 00 00       	call   3298 <link>
    1297:	85 c0                	test   %eax,%eax
    1299:	0f 85 c7 03 00 00    	jne    1666 <subdir+0x516>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    exit();
  }

  if(unlink("dd/dd/ff") != 0){
    129f:	c7 04 24 41 3c 00 00 	movl   $0x3c41,(%esp)
    12a6:	e8 dd 1f 00 00       	call   3288 <unlink>
    12ab:	85 c0                	test   %eax,%eax
    12ad:	0f 85 eb 02 00 00    	jne    159e <subdir+0x44e>
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    12b3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    12ba:	00 
    12bb:	c7 04 24 41 3c 00 00 	movl   $0x3c41,(%esp)
    12c2:	e8 b1 1f 00 00       	call   3278 <open>
    12c7:	85 c0                	test   %eax,%eax
    12c9:	0f 89 5f 04 00 00    	jns    172e <subdir+0x5de>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    exit();
  }

  if(chdir("dd") != 0){
    12cf:	c7 04 24 0b 3d 00 00 	movl   $0x3d0b,(%esp)
    12d6:	e8 cd 1f 00 00       	call   32a8 <chdir>
    12db:	85 c0                	test   %eax,%eax
    12dd:	0f 85 32 04 00 00    	jne    1715 <subdir+0x5c5>
    printf(1, "chdir dd failed\n");
    exit();
  }
  if(chdir("dd/../../dd") != 0){
    12e3:	c7 04 24 d9 3c 00 00 	movl   $0x3cd9,(%esp)
    12ea:	e8 b9 1f 00 00       	call   32a8 <chdir>
    12ef:	85 c0                	test   %eax,%eax
    12f1:	0f 85 8e 02 00 00    	jne    1585 <subdir+0x435>
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("dd/../../../dd") != 0){
    12f7:	c7 04 24 ff 3c 00 00 	movl   $0x3cff,(%esp)
    12fe:	e8 a5 1f 00 00       	call   32a8 <chdir>
    1303:	85 c0                	test   %eax,%eax
    1305:	0f 85 7a 02 00 00    	jne    1585 <subdir+0x435>
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("./..") != 0){
    130b:	c7 04 24 0e 3d 00 00 	movl   $0x3d0e,(%esp)
    1312:	e8 91 1f 00 00       	call   32a8 <chdir>
    1317:	85 c0                	test   %eax,%eax
    1319:	0f 85 2e 03 00 00    	jne    164d <subdir+0x4fd>
    printf(1, "chdir ./.. failed\n");
    exit();
  }

  fd = open("dd/dd/ffff", 0);
    131f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1326:	00 
    1327:	c7 04 24 a5 3c 00 00 	movl   $0x3ca5,(%esp)
    132e:	e8 45 1f 00 00       	call   3278 <open>
  if(fd < 0){
    1333:	85 c0                	test   %eax,%eax
  if(chdir("./..") != 0){
    printf(1, "chdir ./.. failed\n");
    exit();
  }

  fd = open("dd/dd/ffff", 0);
    1335:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1337:	0f 88 81 05 00 00    	js     18be <subdir+0x76e>
    printf(1, "open dd/dd/ffff failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    133d:	c7 44 24 08 00 08 00 	movl   $0x800,0x8(%esp)
    1344:	00 
    1345:	c7 44 24 04 a0 4b 00 	movl   $0x4ba0,0x4(%esp)
    134c:	00 
    134d:	89 04 24             	mov    %eax,(%esp)
    1350:	e8 fb 1e 00 00       	call   3250 <read>
    1355:	83 f8 02             	cmp    $0x2,%eax
    1358:	0f 85 47 05 00 00    	jne    18a5 <subdir+0x755>
    printf(1, "read dd/dd/ffff wrong len\n");
    exit();
  }
  close(fd);
    135e:	89 1c 24             	mov    %ebx,(%esp)
    1361:	e8 fa 1e 00 00       	call   3260 <close>

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1366:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    136d:	00 
    136e:	c7 04 24 41 3c 00 00 	movl   $0x3c41,(%esp)
    1375:	e8 fe 1e 00 00       	call   3278 <open>
    137a:	85 c0                	test   %eax,%eax
    137c:	0f 89 4e 02 00 00    	jns    15d0 <subdir+0x480>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    exit();
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    1382:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1389:	00 
    138a:	c7 04 24 59 3d 00 00 	movl   $0x3d59,(%esp)
    1391:	e8 e2 1e 00 00       	call   3278 <open>
    1396:	85 c0                	test   %eax,%eax
    1398:	0f 89 19 02 00 00    	jns    15b7 <subdir+0x467>
    printf(1, "create dd/ff/ff succeeded!\n");
    exit();
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    139e:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    13a5:	00 
    13a6:	c7 04 24 7e 3d 00 00 	movl   $0x3d7e,(%esp)
    13ad:	e8 c6 1e 00 00       	call   3278 <open>
    13b2:	85 c0                	test   %eax,%eax
    13b4:	0f 89 42 03 00 00    	jns    16fc <subdir+0x5ac>
    printf(1, "create dd/xx/ff succeeded!\n");
    exit();
  }
  if(open("dd", O_CREATE) >= 0){
    13ba:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    13c1:	00 
    13c2:	c7 04 24 0b 3d 00 00 	movl   $0x3d0b,(%esp)
    13c9:	e8 aa 1e 00 00       	call   3278 <open>
    13ce:	85 c0                	test   %eax,%eax
    13d0:	0f 89 0d 03 00 00    	jns    16e3 <subdir+0x593>
    printf(1, "create dd succeeded!\n");
    exit();
  }
  if(open("dd", O_RDWR) >= 0){
    13d6:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    13dd:	00 
    13de:	c7 04 24 0b 3d 00 00 	movl   $0x3d0b,(%esp)
    13e5:	e8 8e 1e 00 00       	call   3278 <open>
    13ea:	85 c0                	test   %eax,%eax
    13ec:	0f 89 d8 02 00 00    	jns    16ca <subdir+0x57a>
    printf(1, "open dd rdwr succeeded!\n");
    exit();
  }
  if(open("dd", O_WRONLY) >= 0){
    13f2:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    13f9:	00 
    13fa:	c7 04 24 0b 3d 00 00 	movl   $0x3d0b,(%esp)
    1401:	e8 72 1e 00 00       	call   3278 <open>
    1406:	85 c0                	test   %eax,%eax
    1408:	0f 89 a3 02 00 00    	jns    16b1 <subdir+0x561>
    printf(1, "open dd wronly succeeded!\n");
    exit();
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    140e:	c7 44 24 04 ed 3d 00 	movl   $0x3ded,0x4(%esp)
    1415:	00 
    1416:	c7 04 24 59 3d 00 00 	movl   $0x3d59,(%esp)
    141d:	e8 76 1e 00 00       	call   3298 <link>
    1422:	85 c0                	test   %eax,%eax
    1424:	0f 84 6e 02 00 00    	je     1698 <subdir+0x548>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    142a:	c7 44 24 04 ed 3d 00 	movl   $0x3ded,0x4(%esp)
    1431:	00 
    1432:	c7 04 24 7e 3d 00 00 	movl   $0x3d7e,(%esp)
    1439:	e8 5a 1e 00 00       	call   3298 <link>
    143e:	85 c0                	test   %eax,%eax
    1440:	0f 84 39 02 00 00    	je     167f <subdir+0x52f>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    1446:	c7 44 24 04 a5 3c 00 	movl   $0x3ca5,0x4(%esp)
    144d:	00 
    144e:	c7 04 24 44 3c 00 00 	movl   $0x3c44,(%esp)
    1455:	e8 3e 1e 00 00       	call   3298 <link>
    145a:	85 c0                	test   %eax,%eax
    145c:	0f 84 a0 01 00 00    	je     1602 <subdir+0x4b2>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    exit();
  }
  if(mkdir("dd/ff/ff") == 0){
    1462:	c7 04 24 59 3d 00 00 	movl   $0x3d59,(%esp)
    1469:	e8 32 1e 00 00       	call   32a0 <mkdir>
    146e:	85 c0                	test   %eax,%eax
    1470:	0f 84 73 01 00 00    	je     15e9 <subdir+0x499>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/xx/ff") == 0){
    1476:	c7 04 24 7e 3d 00 00 	movl   $0x3d7e,(%esp)
    147d:	e8 1e 1e 00 00       	call   32a0 <mkdir>
    1482:	85 c0                	test   %eax,%eax
    1484:	0f 84 02 04 00 00    	je     188c <subdir+0x73c>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/dd/ffff") == 0){
    148a:	c7 04 24 a5 3c 00 00 	movl   $0x3ca5,(%esp)
    1491:	e8 0a 1e 00 00       	call   32a0 <mkdir>
    1496:	85 c0                	test   %eax,%eax
    1498:	0f 84 d5 03 00 00    	je     1873 <subdir+0x723>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    exit();
  }
  if(unlink("dd/xx/ff") == 0){
    149e:	c7 04 24 7e 3d 00 00 	movl   $0x3d7e,(%esp)
    14a5:	e8 de 1d 00 00       	call   3288 <unlink>
    14aa:	85 c0                	test   %eax,%eax
    14ac:	0f 84 a8 03 00 00    	je     185a <subdir+0x70a>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    exit();
  }
  if(unlink("dd/ff/ff") == 0){
    14b2:	c7 04 24 59 3d 00 00 	movl   $0x3d59,(%esp)
    14b9:	e8 ca 1d 00 00       	call   3288 <unlink>
    14be:	85 c0                	test   %eax,%eax
    14c0:	0f 84 7b 03 00 00    	je     1841 <subdir+0x6f1>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/ff") == 0){
    14c6:	c7 04 24 44 3c 00 00 	movl   $0x3c44,(%esp)
    14cd:	e8 d6 1d 00 00       	call   32a8 <chdir>
    14d2:	85 c0                	test   %eax,%eax
    14d4:	0f 84 4e 03 00 00    	je     1828 <subdir+0x6d8>
    printf(1, "chdir dd/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/xx") == 0){
    14da:	c7 04 24 f0 3d 00 00 	movl   $0x3df0,(%esp)
    14e1:	e8 c2 1d 00 00       	call   32a8 <chdir>
    14e6:	85 c0                	test   %eax,%eax
    14e8:	0f 84 21 03 00 00    	je     180f <subdir+0x6bf>
    printf(1, "chdir dd/xx succeeded!\n");
    exit();
  }

  if(unlink("dd/dd/ffff") != 0){
    14ee:	c7 04 24 a5 3c 00 00 	movl   $0x3ca5,(%esp)
    14f5:	e8 8e 1d 00 00       	call   3288 <unlink>
    14fa:	85 c0                	test   %eax,%eax
    14fc:	0f 85 9c 00 00 00    	jne    159e <subdir+0x44e>
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(unlink("dd/ff") != 0){
    1502:	c7 04 24 44 3c 00 00 	movl   $0x3c44,(%esp)
    1509:	e8 7a 1d 00 00       	call   3288 <unlink>
    150e:	85 c0                	test   %eax,%eax
    1510:	0f 85 e0 02 00 00    	jne    17f6 <subdir+0x6a6>
    printf(1, "unlink dd/ff failed\n");
    exit();
  }
  if(unlink("dd") == 0){
    1516:	c7 04 24 0b 3d 00 00 	movl   $0x3d0b,(%esp)
    151d:	e8 66 1d 00 00       	call   3288 <unlink>
    1522:	85 c0                	test   %eax,%eax
    1524:	0f 84 b3 02 00 00    	je     17dd <subdir+0x68d>
    printf(1, "unlink non-empty dd succeeded!\n");
    exit();
  }
  if(unlink("dd/dd") < 0){
    152a:	c7 04 24 20 3c 00 00 	movl   $0x3c20,(%esp)
    1531:	e8 52 1d 00 00       	call   3288 <unlink>
    1536:	85 c0                	test   %eax,%eax
    1538:	0f 88 86 02 00 00    	js     17c4 <subdir+0x674>
    printf(1, "unlink dd/dd failed\n");
    exit();
  }
  if(unlink("dd") < 0){
    153e:	c7 04 24 0b 3d 00 00 	movl   $0x3d0b,(%esp)
    1545:	e8 3e 1d 00 00       	call   3288 <unlink>
    154a:	85 c0                	test   %eax,%eax
    154c:	0f 88 59 02 00 00    	js     17ab <subdir+0x65b>
    printf(1, "unlink dd failed\n");
    exit();
  }

  printf(1, "subdir ok\n");
    1552:	c7 44 24 04 ed 3e 00 	movl   $0x3eed,0x4(%esp)
    1559:	00 
    155a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1561:	e8 2a 1e 00 00       	call   3390 <printf>
}
    1566:	83 c4 14             	add    $0x14,%esp
    1569:	5b                   	pop    %ebx
    156a:	5d                   	pop    %ebp
    156b:	c3                   	ret    
    printf(1, "open dd/dd/../ff failed\n");
    exit();
  }
  cc = read(fd, buf, sizeof(buf));
  if(cc != 2 || buf[0] != 'f'){
    printf(1, "dd/dd/../ff wrong content\n");
    156c:	c7 44 24 04 8a 3c 00 	movl   $0x3c8a,0x4(%esp)
    1573:	00 
    1574:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    157b:	e8 10 1e 00 00       	call   3390 <printf>
    exit();
    1580:	e8 b3 1c 00 00       	call   3238 <exit>
  if(chdir("dd/../../dd") != 0){
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("dd/../../../dd") != 0){
    printf(1, "chdir dd/../../dd failed\n");
    1585:	c7 44 24 04 e5 3c 00 	movl   $0x3ce5,0x4(%esp)
    158c:	00 
    158d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1594:	e8 f7 1d 00 00       	call   3390 <printf>
    exit();
    1599:	e8 9a 1c 00 00       	call   3238 <exit>
    printf(1, "chdir dd/xx succeeded!\n");
    exit();
  }

  if(unlink("dd/dd/ffff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    159e:	c7 44 24 04 b0 3c 00 	movl   $0x3cb0,0x4(%esp)
    15a5:	00 
    15a6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15ad:	e8 de 1d 00 00       	call   3390 <printf>
    exit();
    15b2:	e8 81 1c 00 00       	call   3238 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    exit();
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/ff/ff succeeded!\n");
    15b7:	c7 44 24 04 62 3d 00 	movl   $0x3d62,0x4(%esp)
    15be:	00 
    15bf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15c6:	e8 c5 1d 00 00       	call   3390 <printf>
    exit();
    15cb:	e8 68 1c 00 00       	call   3238 <exit>
    exit();
  }
  close(fd);

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    15d0:	c7 44 24 04 a8 48 00 	movl   $0x48a8,0x4(%esp)
    15d7:	00 
    15d8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15df:	e8 ac 1d 00 00       	call   3390 <printf>
    exit();
    15e4:	e8 4f 1c 00 00       	call   3238 <exit>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    exit();
  }
  if(mkdir("dd/ff/ff") == 0){
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    15e9:	c7 44 24 04 f6 3d 00 	movl   $0x3df6,0x4(%esp)
    15f0:	00 
    15f1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15f8:	e8 93 1d 00 00       	call   3390 <printf>
    exit();
    15fd:	e8 36 1c 00 00       	call   3238 <exit>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    1602:	c7 44 24 04 18 49 00 	movl   $0x4918,0x4(%esp)
    1609:	00 
    160a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1611:	e8 7a 1d 00 00       	call   3390 <printf>
    exit();
    1616:	e8 1d 1c 00 00       	call   3238 <exit>
  write(fd, "FF", 2);
  close(fd);

  fd = open("dd/dd/../ff", 0);
  if(fd < 0){
    printf(1, "open dd/dd/../ff failed\n");
    161b:	c7 44 24 04 71 3c 00 	movl   $0x3c71,0x4(%esp)
    1622:	00 
    1623:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    162a:	e8 61 1d 00 00       	call   3390 <printf>
    exit();
    162f:	e8 04 1c 00 00       	call   3238 <exit>
    exit();
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create dd/dd/ff failed\n");
    1634:	c7 44 24 04 4a 3c 00 	movl   $0x3c4a,0x4(%esp)
    163b:	00 
    163c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1643:	e8 48 1d 00 00       	call   3390 <printf>
    exit();
    1648:	e8 eb 1b 00 00       	call   3238 <exit>
  if(chdir("dd/../../../dd") != 0){
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("./..") != 0){
    printf(1, "chdir ./.. failed\n");
    164d:	c7 44 24 04 13 3d 00 	movl   $0x3d13,0x4(%esp)
    1654:	00 
    1655:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    165c:	e8 2f 1d 00 00       	call   3390 <printf>
    exit();
    1661:	e8 d2 1b 00 00       	call   3238 <exit>
    exit();
  }
  close(fd);

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    1666:	c7 44 24 04 60 48 00 	movl   $0x4860,0x4(%esp)
    166d:	00 
    166e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1675:	e8 16 1d 00 00       	call   3390 <printf>
    exit();
    167a:	e8 b9 1b 00 00       	call   3238 <exit>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    167f:	c7 44 24 04 f4 48 00 	movl   $0x48f4,0x4(%esp)
    1686:	00 
    1687:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    168e:	e8 fd 1c 00 00       	call   3390 <printf>
    exit();
    1693:	e8 a0 1b 00 00       	call   3238 <exit>
  if(open("dd", O_WRONLY) >= 0){
    printf(1, "open dd wronly succeeded!\n");
    exit();
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    1698:	c7 44 24 04 d0 48 00 	movl   $0x48d0,0x4(%esp)
    169f:	00 
    16a0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    16a7:	e8 e4 1c 00 00       	call   3390 <printf>
    exit();
    16ac:	e8 87 1b 00 00       	call   3238 <exit>
  if(open("dd", O_RDWR) >= 0){
    printf(1, "open dd rdwr succeeded!\n");
    exit();
  }
  if(open("dd", O_WRONLY) >= 0){
    printf(1, "open dd wronly succeeded!\n");
    16b1:	c7 44 24 04 d2 3d 00 	movl   $0x3dd2,0x4(%esp)
    16b8:	00 
    16b9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    16c0:	e8 cb 1c 00 00       	call   3390 <printf>
    exit();
    16c5:	e8 6e 1b 00 00       	call   3238 <exit>
  if(open("dd", O_CREATE) >= 0){
    printf(1, "create dd succeeded!\n");
    exit();
  }
  if(open("dd", O_RDWR) >= 0){
    printf(1, "open dd rdwr succeeded!\n");
    16ca:	c7 44 24 04 b9 3d 00 	movl   $0x3db9,0x4(%esp)
    16d1:	00 
    16d2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    16d9:	e8 b2 1c 00 00       	call   3390 <printf>
    exit();
    16de:	e8 55 1b 00 00       	call   3238 <exit>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/xx/ff succeeded!\n");
    exit();
  }
  if(open("dd", O_CREATE) >= 0){
    printf(1, "create dd succeeded!\n");
    16e3:	c7 44 24 04 a3 3d 00 	movl   $0x3da3,0x4(%esp)
    16ea:	00 
    16eb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    16f2:	e8 99 1c 00 00       	call   3390 <printf>
    exit();
    16f7:	e8 3c 1b 00 00       	call   3238 <exit>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/ff/ff succeeded!\n");
    exit();
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/xx/ff succeeded!\n");
    16fc:	c7 44 24 04 87 3d 00 	movl   $0x3d87,0x4(%esp)
    1703:	00 
    1704:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    170b:	e8 80 1c 00 00       	call   3390 <printf>
    exit();
    1710:	e8 23 1b 00 00       	call   3238 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    exit();
  }

  if(chdir("dd") != 0){
    printf(1, "chdir dd failed\n");
    1715:	c7 44 24 04 c8 3c 00 	movl   $0x3cc8,0x4(%esp)
    171c:	00 
    171d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1724:	e8 67 1c 00 00       	call   3390 <printf>
    exit();
    1729:	e8 0a 1b 00 00       	call   3238 <exit>
  if(unlink("dd/dd/ff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    172e:	c7 44 24 04 84 48 00 	movl   $0x4884,0x4(%esp)
    1735:	00 
    1736:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    173d:	e8 4e 1c 00 00       	call   3390 <printf>
    exit();
    1742:	e8 f1 1a 00 00       	call   3238 <exit>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    exit();
  }

  if(mkdir("/dd/dd") != 0){
    printf(1, "subdir mkdir dd/dd failed\n");
    1747:	c7 44 24 04 26 3c 00 	movl   $0x3c26,0x4(%esp)
    174e:	00 
    174f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1756:	e8 35 1c 00 00       	call   3390 <printf>
    exit();
    175b:	e8 d8 1a 00 00       	call   3238 <exit>
  }
  write(fd, "ff", 2);
  close(fd);
  
  if(unlink("dd") >= 0){
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    1760:	c7 44 24 04 38 48 00 	movl   $0x4838,0x4(%esp)
    1767:	00 
    1768:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    176f:	e8 1c 1c 00 00       	call   3390 <printf>
    exit();
    1774:	e8 bf 1a 00 00       	call   3238 <exit>
    exit();
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create dd/ff failed\n");
    1779:	c7 44 24 04 0a 3c 00 	movl   $0x3c0a,0x4(%esp)
    1780:	00 
    1781:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1788:	e8 03 1c 00 00       	call   3390 <printf>
    exit();
    178d:	e8 a6 1a 00 00       	call   3238 <exit>

  printf(1, "subdir test\n");

  unlink("ff");
  if(mkdir("dd") != 0){
    printf(1, "subdir mkdir dd failed\n");
    1792:	c7 44 24 04 f2 3b 00 	movl   $0x3bf2,0x4(%esp)
    1799:	00 
    179a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    17a1:	e8 ea 1b 00 00       	call   3390 <printf>
    exit();
    17a6:	e8 8d 1a 00 00       	call   3238 <exit>
  if(unlink("dd/dd") < 0){
    printf(1, "unlink dd/dd failed\n");
    exit();
  }
  if(unlink("dd") < 0){
    printf(1, "unlink dd failed\n");
    17ab:	c7 44 24 04 db 3e 00 	movl   $0x3edb,0x4(%esp)
    17b2:	00 
    17b3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    17ba:	e8 d1 1b 00 00       	call   3390 <printf>
    exit();
    17bf:	e8 74 1a 00 00       	call   3238 <exit>
  if(unlink("dd") == 0){
    printf(1, "unlink non-empty dd succeeded!\n");
    exit();
  }
  if(unlink("dd/dd") < 0){
    printf(1, "unlink dd/dd failed\n");
    17c4:	c7 44 24 04 c6 3e 00 	movl   $0x3ec6,0x4(%esp)
    17cb:	00 
    17cc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    17d3:	e8 b8 1b 00 00       	call   3390 <printf>
    exit();
    17d8:	e8 5b 1a 00 00       	call   3238 <exit>
  if(unlink("dd/ff") != 0){
    printf(1, "unlink dd/ff failed\n");
    exit();
  }
  if(unlink("dd") == 0){
    printf(1, "unlink non-empty dd succeeded!\n");
    17dd:	c7 44 24 04 3c 49 00 	movl   $0x493c,0x4(%esp)
    17e4:	00 
    17e5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    17ec:	e8 9f 1b 00 00       	call   3390 <printf>
    exit();
    17f1:	e8 42 1a 00 00       	call   3238 <exit>
  if(unlink("dd/dd/ffff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(unlink("dd/ff") != 0){
    printf(1, "unlink dd/ff failed\n");
    17f6:	c7 44 24 04 b1 3e 00 	movl   $0x3eb1,0x4(%esp)
    17fd:	00 
    17fe:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1805:	e8 86 1b 00 00       	call   3390 <printf>
    exit();
    180a:	e8 29 1a 00 00       	call   3238 <exit>
  if(chdir("dd/ff") == 0){
    printf(1, "chdir dd/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/xx") == 0){
    printf(1, "chdir dd/xx succeeded!\n");
    180f:	c7 44 24 04 99 3e 00 	movl   $0x3e99,0x4(%esp)
    1816:	00 
    1817:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    181e:	e8 6d 1b 00 00       	call   3390 <printf>
    exit();
    1823:	e8 10 1a 00 00       	call   3238 <exit>
  if(unlink("dd/ff/ff") == 0){
    printf(1, "unlink dd/ff/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/ff") == 0){
    printf(1, "chdir dd/ff succeeded!\n");
    1828:	c7 44 24 04 81 3e 00 	movl   $0x3e81,0x4(%esp)
    182f:	00 
    1830:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1837:	e8 54 1b 00 00       	call   3390 <printf>
    exit();
    183c:	e8 f7 19 00 00       	call   3238 <exit>
  if(unlink("dd/xx/ff") == 0){
    printf(1, "unlink dd/xx/ff succeeded!\n");
    exit();
  }
  if(unlink("dd/ff/ff") == 0){
    printf(1, "unlink dd/ff/ff succeeded!\n");
    1841:	c7 44 24 04 65 3e 00 	movl   $0x3e65,0x4(%esp)
    1848:	00 
    1849:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1850:	e8 3b 1b 00 00       	call   3390 <printf>
    exit();
    1855:	e8 de 19 00 00       	call   3238 <exit>
  if(mkdir("dd/dd/ffff") == 0){
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    exit();
  }
  if(unlink("dd/xx/ff") == 0){
    printf(1, "unlink dd/xx/ff succeeded!\n");
    185a:	c7 44 24 04 49 3e 00 	movl   $0x3e49,0x4(%esp)
    1861:	00 
    1862:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1869:	e8 22 1b 00 00       	call   3390 <printf>
    exit();
    186e:	e8 c5 19 00 00       	call   3238 <exit>
  if(mkdir("dd/xx/ff") == 0){
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/dd/ffff") == 0){
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    1873:	c7 44 24 04 2c 3e 00 	movl   $0x3e2c,0x4(%esp)
    187a:	00 
    187b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1882:	e8 09 1b 00 00       	call   3390 <printf>
    exit();
    1887:	e8 ac 19 00 00       	call   3238 <exit>
  if(mkdir("dd/ff/ff") == 0){
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/xx/ff") == 0){
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    188c:	c7 44 24 04 11 3e 00 	movl   $0x3e11,0x4(%esp)
    1893:	00 
    1894:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    189b:	e8 f0 1a 00 00       	call   3390 <printf>
    exit();
    18a0:	e8 93 19 00 00       	call   3238 <exit>
  if(fd < 0){
    printf(1, "open dd/dd/ffff failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    printf(1, "read dd/dd/ffff wrong len\n");
    18a5:	c7 44 24 04 3e 3d 00 	movl   $0x3d3e,0x4(%esp)
    18ac:	00 
    18ad:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18b4:	e8 d7 1a 00 00       	call   3390 <printf>
    exit();
    18b9:	e8 7a 19 00 00       	call   3238 <exit>
    exit();
  }

  fd = open("dd/dd/ffff", 0);
  if(fd < 0){
    printf(1, "open dd/dd/ffff failed\n");
    18be:	c7 44 24 04 26 3d 00 	movl   $0x3d26,0x4(%esp)
    18c5:	00 
    18c6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18cd:	e8 be 1a 00 00       	call   3390 <printf>
    exit();
    18d2:	e8 61 19 00 00       	call   3238 <exit>
    18d7:	89 f6                	mov    %esi,%esi
    18d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000018e0 <bigdir>:
}

// directory that uses indirect blocks
void
bigdir(void)
{
    18e0:	55                   	push   %ebp
    18e1:	89 e5                	mov    %esp,%ebp
    18e3:	56                   	push   %esi
    18e4:	53                   	push   %ebx
    18e5:	83 ec 20             	sub    $0x20,%esp
  int i, fd;
  char name[10];

  printf(1, "bigdir test\n");
    18e8:	c7 44 24 04 f8 3e 00 	movl   $0x3ef8,0x4(%esp)
    18ef:	00 
    18f0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18f7:	e8 94 1a 00 00       	call   3390 <printf>
  unlink("bd");
    18fc:	c7 04 24 05 3f 00 00 	movl   $0x3f05,(%esp)
    1903:	e8 80 19 00 00       	call   3288 <unlink>

  fd = open("bd", O_CREATE);
    1908:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    190f:	00 
    1910:	c7 04 24 05 3f 00 00 	movl   $0x3f05,(%esp)
    1917:	e8 5c 19 00 00       	call   3278 <open>
  if(fd < 0){
    191c:	85 c0                	test   %eax,%eax
    191e:	0f 88 e6 00 00 00    	js     1a0a <bigdir+0x12a>
    printf(1, "bigdir create failed\n");
    exit();
  }
  close(fd);
    1924:	89 04 24             	mov    %eax,(%esp)
    1927:	31 db                	xor    %ebx,%ebx
    1929:	e8 32 19 00 00       	call   3260 <close>
    192e:	8d 75 ee             	lea    -0x12(%ebp),%esi
    1931:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    1938:	89 d8                	mov    %ebx,%eax
    193a:	c1 f8 06             	sar    $0x6,%eax
    193d:	83 c0 30             	add    $0x30,%eax
    1940:	88 45 ef             	mov    %al,-0x11(%ebp)
    name[2] = '0' + (i % 64);
    1943:	89 d8                	mov    %ebx,%eax
    1945:	83 e0 3f             	and    $0x3f,%eax
    1948:	83 c0 30             	add    $0x30,%eax
    exit();
  }
  close(fd);

  for(i = 0; i < 500; i++){
    name[0] = 'x';
    194b:	c6 45 ee 78          	movb   $0x78,-0x12(%ebp)
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    194f:	88 45 f0             	mov    %al,-0x10(%ebp)
    name[3] = '\0';
    1952:	c6 45 f1 00          	movb   $0x0,-0xf(%ebp)
    if(link("bd", name) != 0){
    1956:	89 74 24 04          	mov    %esi,0x4(%esp)
    195a:	c7 04 24 05 3f 00 00 	movl   $0x3f05,(%esp)
    1961:	e8 32 19 00 00       	call   3298 <link>
    1966:	85 c0                	test   %eax,%eax
    1968:	75 6e                	jne    19d8 <bigdir+0xf8>
    printf(1, "bigdir create failed\n");
    exit();
  }
  close(fd);

  for(i = 0; i < 500; i++){
    196a:	83 c3 01             	add    $0x1,%ebx
    196d:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    1973:	75 c3                	jne    1938 <bigdir+0x58>
      printf(1, "bigdir link failed\n");
      exit();
    }
  }

  unlink("bd");
    1975:	c7 04 24 05 3f 00 00 	movl   $0x3f05,(%esp)
    197c:	66 31 db             	xor    %bx,%bx
    197f:	e8 04 19 00 00       	call   3288 <unlink>
    1984:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    1988:	89 d8                	mov    %ebx,%eax
    198a:	c1 f8 06             	sar    $0x6,%eax
    198d:	83 c0 30             	add    $0x30,%eax
    1990:	88 45 ef             	mov    %al,-0x11(%ebp)
    name[2] = '0' + (i % 64);
    1993:	89 d8                	mov    %ebx,%eax
    1995:	83 e0 3f             	and    $0x3f,%eax
    1998:	83 c0 30             	add    $0x30,%eax
    }
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    name[0] = 'x';
    199b:	c6 45 ee 78          	movb   $0x78,-0x12(%ebp)
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    199f:	88 45 f0             	mov    %al,-0x10(%ebp)
    name[3] = '\0';
    19a2:	c6 45 f1 00          	movb   $0x0,-0xf(%ebp)
    if(unlink(name) != 0){
    19a6:	89 34 24             	mov    %esi,(%esp)
    19a9:	e8 da 18 00 00       	call   3288 <unlink>
    19ae:	85 c0                	test   %eax,%eax
    19b0:	75 3f                	jne    19f1 <bigdir+0x111>
      exit();
    }
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    19b2:	83 c3 01             	add    $0x1,%ebx
    19b5:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    19bb:	75 cb                	jne    1988 <bigdir+0xa8>
      printf(1, "bigdir unlink failed");
      exit();
    }
  }

  printf(1, "bigdir ok\n");
    19bd:	c7 44 24 04 47 3f 00 	movl   $0x3f47,0x4(%esp)
    19c4:	00 
    19c5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    19cc:	e8 bf 19 00 00       	call   3390 <printf>
}
    19d1:	83 c4 20             	add    $0x20,%esp
    19d4:	5b                   	pop    %ebx
    19d5:	5e                   	pop    %esi
    19d6:	5d                   	pop    %ebp
    19d7:	c3                   	ret    
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(link("bd", name) != 0){
      printf(1, "bigdir link failed\n");
    19d8:	c7 44 24 04 1e 3f 00 	movl   $0x3f1e,0x4(%esp)
    19df:	00 
    19e0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    19e7:	e8 a4 19 00 00       	call   3390 <printf>
      exit();
    19ec:	e8 47 18 00 00       	call   3238 <exit>
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(unlink(name) != 0){
      printf(1, "bigdir unlink failed");
    19f1:	c7 44 24 04 32 3f 00 	movl   $0x3f32,0x4(%esp)
    19f8:	00 
    19f9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a00:	e8 8b 19 00 00       	call   3390 <printf>
      exit();
    1a05:	e8 2e 18 00 00       	call   3238 <exit>
  printf(1, "bigdir test\n");
  unlink("bd");

  fd = open("bd", O_CREATE);
  if(fd < 0){
    printf(1, "bigdir create failed\n");
    1a0a:	c7 44 24 04 08 3f 00 	movl   $0x3f08,0x4(%esp)
    1a11:	00 
    1a12:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a19:	e8 72 19 00 00       	call   3390 <printf>
    exit();
    1a1e:	e8 15 18 00 00       	call   3238 <exit>
    1a23:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001a30 <linktest>:
  printf(1, "unlinkread ok\n");
}

void
linktest(void)
{
    1a30:	55                   	push   %ebp
    1a31:	89 e5                	mov    %esp,%ebp
    1a33:	53                   	push   %ebx
    1a34:	83 ec 14             	sub    $0x14,%esp
  int fd;

  printf(1, "linktest\n");
    1a37:	c7 44 24 04 52 3f 00 	movl   $0x3f52,0x4(%esp)
    1a3e:	00 
    1a3f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a46:	e8 45 19 00 00       	call   3390 <printf>

  unlink("lf1");
    1a4b:	c7 04 24 5c 3f 00 00 	movl   $0x3f5c,(%esp)
    1a52:	e8 31 18 00 00       	call   3288 <unlink>
  unlink("lf2");
    1a57:	c7 04 24 60 3f 00 00 	movl   $0x3f60,(%esp)
    1a5e:	e8 25 18 00 00       	call   3288 <unlink>

  fd = open("lf1", O_CREATE|O_RDWR);
    1a63:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1a6a:	00 
    1a6b:	c7 04 24 5c 3f 00 00 	movl   $0x3f5c,(%esp)
    1a72:	e8 01 18 00 00       	call   3278 <open>
  if(fd < 0){
    1a77:	85 c0                	test   %eax,%eax
  printf(1, "linktest\n");

  unlink("lf1");
  unlink("lf2");

  fd = open("lf1", O_CREATE|O_RDWR);
    1a79:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1a7b:	0f 88 26 01 00 00    	js     1ba7 <linktest+0x177>
    printf(1, "create lf1 failed\n");
    exit();
  }
  if(write(fd, "hello", 5) != 5){
    1a81:	c7 44 24 08 05 00 00 	movl   $0x5,0x8(%esp)
    1a88:	00 
    1a89:	c7 44 24 04 77 3f 00 	movl   $0x3f77,0x4(%esp)
    1a90:	00 
    1a91:	89 04 24             	mov    %eax,(%esp)
    1a94:	e8 bf 17 00 00       	call   3258 <write>
    1a99:	83 f8 05             	cmp    $0x5,%eax
    1a9c:	0f 85 cd 01 00 00    	jne    1c6f <linktest+0x23f>
    printf(1, "write lf1 failed\n");
    exit();
  }
  close(fd);
    1aa2:	89 1c 24             	mov    %ebx,(%esp)
    1aa5:	e8 b6 17 00 00       	call   3260 <close>

  if(link("lf1", "lf2") < 0){
    1aaa:	c7 44 24 04 60 3f 00 	movl   $0x3f60,0x4(%esp)
    1ab1:	00 
    1ab2:	c7 04 24 5c 3f 00 00 	movl   $0x3f5c,(%esp)
    1ab9:	e8 da 17 00 00       	call   3298 <link>
    1abe:	85 c0                	test   %eax,%eax
    1ac0:	0f 88 90 01 00 00    	js     1c56 <linktest+0x226>
    printf(1, "link lf1 lf2 failed\n");
    exit();
  }
  unlink("lf1");
    1ac6:	c7 04 24 5c 3f 00 00 	movl   $0x3f5c,(%esp)
    1acd:	e8 b6 17 00 00       	call   3288 <unlink>

  if(open("lf1", 0) >= 0){
    1ad2:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1ad9:	00 
    1ada:	c7 04 24 5c 3f 00 00 	movl   $0x3f5c,(%esp)
    1ae1:	e8 92 17 00 00       	call   3278 <open>
    1ae6:	85 c0                	test   %eax,%eax
    1ae8:	0f 89 4f 01 00 00    	jns    1c3d <linktest+0x20d>
    printf(1, "unlinked lf1 but it is still there!\n");
    exit();
  }

  fd = open("lf2", 0);
    1aee:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1af5:	00 
    1af6:	c7 04 24 60 3f 00 00 	movl   $0x3f60,(%esp)
    1afd:	e8 76 17 00 00       	call   3278 <open>
  if(fd < 0){
    1b02:	85 c0                	test   %eax,%eax
  if(open("lf1", 0) >= 0){
    printf(1, "unlinked lf1 but it is still there!\n");
    exit();
  }

  fd = open("lf2", 0);
    1b04:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1b06:	0f 88 18 01 00 00    	js     1c24 <linktest+0x1f4>
    printf(1, "open lf2 failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    1b0c:	c7 44 24 08 00 08 00 	movl   $0x800,0x8(%esp)
    1b13:	00 
    1b14:	c7 44 24 04 a0 4b 00 	movl   $0x4ba0,0x4(%esp)
    1b1b:	00 
    1b1c:	89 04 24             	mov    %eax,(%esp)
    1b1f:	e8 2c 17 00 00       	call   3250 <read>
    1b24:	83 f8 05             	cmp    $0x5,%eax
    1b27:	0f 85 de 00 00 00    	jne    1c0b <linktest+0x1db>
    printf(1, "read lf2 failed\n");
    exit();
  }
  close(fd);
    1b2d:	89 1c 24             	mov    %ebx,(%esp)
    1b30:	e8 2b 17 00 00       	call   3260 <close>

  if(link("lf2", "lf2") >= 0){
    1b35:	c7 44 24 04 60 3f 00 	movl   $0x3f60,0x4(%esp)
    1b3c:	00 
    1b3d:	c7 04 24 60 3f 00 00 	movl   $0x3f60,(%esp)
    1b44:	e8 4f 17 00 00       	call   3298 <link>
    1b49:	85 c0                	test   %eax,%eax
    1b4b:	0f 89 a1 00 00 00    	jns    1bf2 <linktest+0x1c2>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    exit();
  }

  unlink("lf2");
    1b51:	c7 04 24 60 3f 00 00 	movl   $0x3f60,(%esp)
    1b58:	e8 2b 17 00 00       	call   3288 <unlink>
  if(link("lf2", "lf1") >= 0){
    1b5d:	c7 44 24 04 5c 3f 00 	movl   $0x3f5c,0x4(%esp)
    1b64:	00 
    1b65:	c7 04 24 60 3f 00 00 	movl   $0x3f60,(%esp)
    1b6c:	e8 27 17 00 00       	call   3298 <link>
    1b71:	85 c0                	test   %eax,%eax
    1b73:	79 64                	jns    1bd9 <linktest+0x1a9>
    printf(1, "link non-existant succeeded! oops\n");
    exit();
  }

  if(link(".", "lf1") >= 0){
    1b75:	c7 44 24 04 5c 3f 00 	movl   $0x3f5c,0x4(%esp)
    1b7c:	00 
    1b7d:	c7 04 24 11 3d 00 00 	movl   $0x3d11,(%esp)
    1b84:	e8 0f 17 00 00       	call   3298 <link>
    1b89:	85 c0                	test   %eax,%eax
    1b8b:	79 33                	jns    1bc0 <linktest+0x190>
    printf(1, "link . lf1 succeeded! oops\n");
    exit();
  }

  printf(1, "linktest ok\n");
    1b8d:	c7 44 24 04 00 40 00 	movl   $0x4000,0x4(%esp)
    1b94:	00 
    1b95:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b9c:	e8 ef 17 00 00       	call   3390 <printf>
}
    1ba1:	83 c4 14             	add    $0x14,%esp
    1ba4:	5b                   	pop    %ebx
    1ba5:	5d                   	pop    %ebp
    1ba6:	c3                   	ret    
  unlink("lf1");
  unlink("lf2");

  fd = open("lf1", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "create lf1 failed\n");
    1ba7:	c7 44 24 04 64 3f 00 	movl   $0x3f64,0x4(%esp)
    1bae:	00 
    1baf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1bb6:	e8 d5 17 00 00       	call   3390 <printf>
    exit();
    1bbb:	e8 78 16 00 00       	call   3238 <exit>
    printf(1, "link non-existant succeeded! oops\n");
    exit();
  }

  if(link(".", "lf1") >= 0){
    printf(1, "link . lf1 succeeded! oops\n");
    1bc0:	c7 44 24 04 e4 3f 00 	movl   $0x3fe4,0x4(%esp)
    1bc7:	00 
    1bc8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1bcf:	e8 bc 17 00 00       	call   3390 <printf>
    exit();
    1bd4:	e8 5f 16 00 00       	call   3238 <exit>
    exit();
  }

  unlink("lf2");
  if(link("lf2", "lf1") >= 0){
    printf(1, "link non-existant succeeded! oops\n");
    1bd9:	c7 44 24 04 84 49 00 	movl   $0x4984,0x4(%esp)
    1be0:	00 
    1be1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1be8:	e8 a3 17 00 00       	call   3390 <printf>
    exit();
    1bed:	e8 46 16 00 00       	call   3238 <exit>
    exit();
  }
  close(fd);

  if(link("lf2", "lf2") >= 0){
    printf(1, "link lf2 lf2 succeeded! oops\n");
    1bf2:	c7 44 24 04 c6 3f 00 	movl   $0x3fc6,0x4(%esp)
    1bf9:	00 
    1bfa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c01:	e8 8a 17 00 00       	call   3390 <printf>
    exit();
    1c06:	e8 2d 16 00 00       	call   3238 <exit>
  if(fd < 0){
    printf(1, "open lf2 failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "read lf2 failed\n");
    1c0b:	c7 44 24 04 b5 3f 00 	movl   $0x3fb5,0x4(%esp)
    1c12:	00 
    1c13:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c1a:	e8 71 17 00 00       	call   3390 <printf>
    exit();
    1c1f:	e8 14 16 00 00       	call   3238 <exit>
    exit();
  }

  fd = open("lf2", 0);
  if(fd < 0){
    printf(1, "open lf2 failed\n");
    1c24:	c7 44 24 04 a4 3f 00 	movl   $0x3fa4,0x4(%esp)
    1c2b:	00 
    1c2c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c33:	e8 58 17 00 00       	call   3390 <printf>
    exit();
    1c38:	e8 fb 15 00 00       	call   3238 <exit>
    exit();
  }
  unlink("lf1");

  if(open("lf1", 0) >= 0){
    printf(1, "unlinked lf1 but it is still there!\n");
    1c3d:	c7 44 24 04 5c 49 00 	movl   $0x495c,0x4(%esp)
    1c44:	00 
    1c45:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c4c:	e8 3f 17 00 00       	call   3390 <printf>
    exit();
    1c51:	e8 e2 15 00 00       	call   3238 <exit>
    exit();
  }
  close(fd);

  if(link("lf1", "lf2") < 0){
    printf(1, "link lf1 lf2 failed\n");
    1c56:	c7 44 24 04 8f 3f 00 	movl   $0x3f8f,0x4(%esp)
    1c5d:	00 
    1c5e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c65:	e8 26 17 00 00       	call   3390 <printf>
    exit();
    1c6a:	e8 c9 15 00 00       	call   3238 <exit>
  if(fd < 0){
    printf(1, "create lf1 failed\n");
    exit();
  }
  if(write(fd, "hello", 5) != 5){
    printf(1, "write lf1 failed\n");
    1c6f:	c7 44 24 04 7d 3f 00 	movl   $0x3f7d,0x4(%esp)
    1c76:	00 
    1c77:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c7e:	e8 0d 17 00 00       	call   3390 <printf>
    exit();
    1c83:	e8 b0 15 00 00       	call   3238 <exit>
    1c88:	90                   	nop
    1c89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001c90 <unlinkread>:
}

// can I unlink a file and still read it?
void
unlinkread(void)
{
    1c90:	55                   	push   %ebp
    1c91:	89 e5                	mov    %esp,%ebp
    1c93:	56                   	push   %esi
    1c94:	53                   	push   %ebx
    1c95:	83 ec 10             	sub    $0x10,%esp
  int fd, fd1;

  printf(1, "unlinkread test\n");
    1c98:	c7 44 24 04 0d 40 00 	movl   $0x400d,0x4(%esp)
    1c9f:	00 
    1ca0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ca7:	e8 e4 16 00 00       	call   3390 <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1cac:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1cb3:	00 
    1cb4:	c7 04 24 1e 40 00 00 	movl   $0x401e,(%esp)
    1cbb:	e8 b8 15 00 00       	call   3278 <open>
  if(fd < 0){
    1cc0:	85 c0                	test   %eax,%eax
unlinkread(void)
{
  int fd, fd1;

  printf(1, "unlinkread test\n");
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1cc2:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1cc4:	0f 88 fe 00 00 00    	js     1dc8 <unlinkread+0x138>
    printf(1, "create unlinkread failed\n");
    exit();
  }
  write(fd, "hello", 5);
    1cca:	c7 44 24 08 05 00 00 	movl   $0x5,0x8(%esp)
    1cd1:	00 
    1cd2:	c7 44 24 04 77 3f 00 	movl   $0x3f77,0x4(%esp)
    1cd9:	00 
    1cda:	89 04 24             	mov    %eax,(%esp)
    1cdd:	e8 76 15 00 00       	call   3258 <write>
  close(fd);
    1ce2:	89 1c 24             	mov    %ebx,(%esp)
    1ce5:	e8 76 15 00 00       	call   3260 <close>

  fd = open("unlinkread", O_RDWR);
    1cea:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    1cf1:	00 
    1cf2:	c7 04 24 1e 40 00 00 	movl   $0x401e,(%esp)
    1cf9:	e8 7a 15 00 00       	call   3278 <open>
  if(fd < 0){
    1cfe:	85 c0                	test   %eax,%eax
    exit();
  }
  write(fd, "hello", 5);
  close(fd);

  fd = open("unlinkread", O_RDWR);
    1d00:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1d02:	0f 88 3d 01 00 00    	js     1e45 <unlinkread+0x1b5>
    printf(1, "open unlinkread failed\n");
    exit();
  }
  if(unlink("unlinkread") != 0){
    1d08:	c7 04 24 1e 40 00 00 	movl   $0x401e,(%esp)
    1d0f:	e8 74 15 00 00       	call   3288 <unlink>
    1d14:	85 c0                	test   %eax,%eax
    1d16:	0f 85 10 01 00 00    	jne    1e2c <unlinkread+0x19c>
    printf(1, "unlink unlinkread failed\n");
    exit();
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    1d1c:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1d23:	00 
    1d24:	c7 04 24 1e 40 00 00 	movl   $0x401e,(%esp)
    1d2b:	e8 48 15 00 00       	call   3278 <open>
  write(fd1, "yyy", 3);
    1d30:	c7 44 24 08 03 00 00 	movl   $0x3,0x8(%esp)
    1d37:	00 
    1d38:	c7 44 24 04 75 40 00 	movl   $0x4075,0x4(%esp)
    1d3f:	00 
  if(unlink("unlinkread") != 0){
    printf(1, "unlink unlinkread failed\n");
    exit();
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    1d40:	89 c6                	mov    %eax,%esi
  write(fd1, "yyy", 3);
    1d42:	89 04 24             	mov    %eax,(%esp)
    1d45:	e8 0e 15 00 00       	call   3258 <write>
  close(fd1);
    1d4a:	89 34 24             	mov    %esi,(%esp)
    1d4d:	e8 0e 15 00 00       	call   3260 <close>

  if(read(fd, buf, sizeof(buf)) != 5){
    1d52:	c7 44 24 08 00 08 00 	movl   $0x800,0x8(%esp)
    1d59:	00 
    1d5a:	c7 44 24 04 a0 4b 00 	movl   $0x4ba0,0x4(%esp)
    1d61:	00 
    1d62:	89 1c 24             	mov    %ebx,(%esp)
    1d65:	e8 e6 14 00 00       	call   3250 <read>
    1d6a:	83 f8 05             	cmp    $0x5,%eax
    1d6d:	0f 85 a0 00 00 00    	jne    1e13 <unlinkread+0x183>
    printf(1, "unlinkread read failed");
    exit();
  }
  if(buf[0] != 'h'){
    1d73:	80 3d a0 4b 00 00 68 	cmpb   $0x68,0x4ba0
    1d7a:	75 7e                	jne    1dfa <unlinkread+0x16a>
    printf(1, "unlinkread wrong data\n");
    exit();
  }
  if(write(fd, buf, 10) != 10){
    1d7c:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1d83:	00 
    1d84:	c7 44 24 04 a0 4b 00 	movl   $0x4ba0,0x4(%esp)
    1d8b:	00 
    1d8c:	89 1c 24             	mov    %ebx,(%esp)
    1d8f:	e8 c4 14 00 00       	call   3258 <write>
    1d94:	83 f8 0a             	cmp    $0xa,%eax
    1d97:	75 48                	jne    1de1 <unlinkread+0x151>
    printf(1, "unlinkread write failed\n");
    exit();
  }
  close(fd);
    1d99:	89 1c 24             	mov    %ebx,(%esp)
    1d9c:	e8 bf 14 00 00       	call   3260 <close>
  unlink("unlinkread");
    1da1:	c7 04 24 1e 40 00 00 	movl   $0x401e,(%esp)
    1da8:	e8 db 14 00 00       	call   3288 <unlink>
  printf(1, "unlinkread ok\n");
    1dad:	c7 44 24 04 c0 40 00 	movl   $0x40c0,0x4(%esp)
    1db4:	00 
    1db5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1dbc:	e8 cf 15 00 00       	call   3390 <printf>
}
    1dc1:	83 c4 10             	add    $0x10,%esp
    1dc4:	5b                   	pop    %ebx
    1dc5:	5e                   	pop    %esi
    1dc6:	5d                   	pop    %ebp
    1dc7:	c3                   	ret    
  int fd, fd1;

  printf(1, "unlinkread test\n");
  fd = open("unlinkread", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create unlinkread failed\n");
    1dc8:	c7 44 24 04 29 40 00 	movl   $0x4029,0x4(%esp)
    1dcf:	00 
    1dd0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1dd7:	e8 b4 15 00 00       	call   3390 <printf>
    exit();
    1ddc:	e8 57 14 00 00       	call   3238 <exit>
  if(buf[0] != 'h'){
    printf(1, "unlinkread wrong data\n");
    exit();
  }
  if(write(fd, buf, 10) != 10){
    printf(1, "unlinkread write failed\n");
    1de1:	c7 44 24 04 a7 40 00 	movl   $0x40a7,0x4(%esp)
    1de8:	00 
    1de9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1df0:	e8 9b 15 00 00       	call   3390 <printf>
    exit();
    1df5:	e8 3e 14 00 00       	call   3238 <exit>
  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "unlinkread read failed");
    exit();
  }
  if(buf[0] != 'h'){
    printf(1, "unlinkread wrong data\n");
    1dfa:	c7 44 24 04 90 40 00 	movl   $0x4090,0x4(%esp)
    1e01:	00 
    1e02:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e09:	e8 82 15 00 00       	call   3390 <printf>
    exit();
    1e0e:	e8 25 14 00 00       	call   3238 <exit>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
  write(fd1, "yyy", 3);
  close(fd1);

  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "unlinkread read failed");
    1e13:	c7 44 24 04 79 40 00 	movl   $0x4079,0x4(%esp)
    1e1a:	00 
    1e1b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e22:	e8 69 15 00 00       	call   3390 <printf>
    exit();
    1e27:	e8 0c 14 00 00       	call   3238 <exit>
  if(fd < 0){
    printf(1, "open unlinkread failed\n");
    exit();
  }
  if(unlink("unlinkread") != 0){
    printf(1, "unlink unlinkread failed\n");
    1e2c:	c7 44 24 04 5b 40 00 	movl   $0x405b,0x4(%esp)
    1e33:	00 
    1e34:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e3b:	e8 50 15 00 00       	call   3390 <printf>
    exit();
    1e40:	e8 f3 13 00 00       	call   3238 <exit>
  write(fd, "hello", 5);
  close(fd);

  fd = open("unlinkread", O_RDWR);
  if(fd < 0){
    printf(1, "open unlinkread failed\n");
    1e45:	c7 44 24 04 43 40 00 	movl   $0x4043,0x4(%esp)
    1e4c:	00 
    1e4d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e54:	e8 37 15 00 00       	call   3390 <printf>
    exit();
    1e59:	e8 da 13 00 00       	call   3238 <exit>
    1e5e:	66 90                	xchg   %ax,%ax

00001e60 <createdelete>:
}

// two processes create and delete different files in same directory
void
createdelete(void)
{
    1e60:	55                   	push   %ebp
    1e61:	89 e5                	mov    %esp,%ebp
    1e63:	57                   	push   %edi
    1e64:	56                   	push   %esi
    1e65:	53                   	push   %ebx
    1e66:	83 ec 4c             	sub    $0x4c,%esp
  enum { N = 20 };
  int pid, i, fd;
  char name[32];

  printf(1, "createdelete test\n");
    1e69:	c7 44 24 04 cf 40 00 	movl   $0x40cf,0x4(%esp)
    1e70:	00 
    1e71:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e78:	e8 13 15 00 00       	call   3390 <printf>
  pid = fork();
    1e7d:	e8 ae 13 00 00       	call   3230 <fork>
  if(pid < 0){
    1e82:	85 c0                	test   %eax,%eax
  enum { N = 20 };
  int pid, i, fd;
  char name[32];

  printf(1, "createdelete test\n");
  pid = fork();
    1e84:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  if(pid < 0){
    1e87:	0f 88 14 02 00 00    	js     20a1 <createdelete+0x241>
    printf(1, "fork failed\n");
    exit();
  }

  name[0] = pid ? 'p' : 'c';
    1e8d:	83 7d c4 01          	cmpl   $0x1,-0x3c(%ebp)
  name[2] = '\0';
    1e91:	bf 01 00 00 00       	mov    $0x1,%edi
    1e96:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    1e9a:	8d 75 c8             	lea    -0x38(%ebp),%esi
  if(pid < 0){
    printf(1, "fork failed\n");
    exit();
  }

  name[0] = pid ? 'p' : 'c';
    1e9d:	19 c0                	sbb    %eax,%eax
  name[2] = '\0';
    1e9f:	31 db                	xor    %ebx,%ebx
  if(pid < 0){
    printf(1, "fork failed\n");
    exit();
  }

  name[0] = pid ? 'p' : 'c';
    1ea1:	83 e0 f3             	and    $0xfffffff3,%eax
    1ea4:	83 c0 70             	add    $0x70,%eax
    1ea7:	88 45 c8             	mov    %al,-0x38(%ebp)
    1eaa:	eb 0f                	jmp    1ebb <createdelete+0x5b>
    1eac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  name[2] = '\0';
  for(i = 0; i < N; i++){
    1eb0:	83 ff 13             	cmp    $0x13,%edi
    1eb3:	7f 6b                	jg     1f20 <createdelete+0xc0>
    printf(1, "fork failed\n");
    exit();
  }

  name[0] = pid ? 'p' : 'c';
  name[2] = '\0';
    1eb5:	83 c3 01             	add    $0x1,%ebx
    1eb8:	83 c7 01             	add    $0x1,%edi
  for(i = 0; i < N; i++){
    name[1] = '0' + i;
    1ebb:	8d 43 30             	lea    0x30(%ebx),%eax
    1ebe:	88 45 c9             	mov    %al,-0x37(%ebp)
    fd = open(name, O_CREATE | O_RDWR);
    1ec1:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1ec8:	00 
    1ec9:	89 34 24             	mov    %esi,(%esp)
    1ecc:	e8 a7 13 00 00       	call   3278 <open>
    if(fd < 0){
    1ed1:	85 c0                	test   %eax,%eax
    1ed3:	0f 88 3e 01 00 00    	js     2017 <createdelete+0x1b7>
      printf(1, "create failed\n");
      exit();
    }
    close(fd);
    1ed9:	89 04 24             	mov    %eax,(%esp)
    1edc:	e8 7f 13 00 00       	call   3260 <close>
    if(i > 0 && (i % 2 ) == 0){
    1ee1:	85 db                	test   %ebx,%ebx
    1ee3:	74 d0                	je     1eb5 <createdelete+0x55>
    1ee5:	f6 c3 01             	test   $0x1,%bl
    1ee8:	75 c6                	jne    1eb0 <createdelete+0x50>
      name[1] = '0' + (i / 2);
    1eea:	89 d8                	mov    %ebx,%eax
    1eec:	d1 f8                	sar    %eax
    1eee:	83 c0 30             	add    $0x30,%eax
    1ef1:	88 45 c9             	mov    %al,-0x37(%ebp)
      if(unlink(name) < 0){
    1ef4:	89 34 24             	mov    %esi,(%esp)
    1ef7:	e8 8c 13 00 00       	call   3288 <unlink>
    1efc:	85 c0                	test   %eax,%eax
    1efe:	79 b0                	jns    1eb0 <createdelete+0x50>
        printf(1, "unlink failed\n");
    1f00:	c7 44 24 04 e2 40 00 	movl   $0x40e2,0x4(%esp)
    1f07:	00 
    1f08:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1f0f:	e8 7c 14 00 00       	call   3390 <printf>
        exit();
    1f14:	e8 1f 13 00 00       	call   3238 <exit>
    1f19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      }
    }
  }

  if(pid==0)
    1f20:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    1f23:	85 c0                	test   %eax,%eax
    1f25:	0f 84 71 01 00 00    	je     209c <createdelete+0x23c>
    exit();
  else
    wait();
    1f2b:	e8 10 13 00 00       	call   3240 <wait>
    1f30:	31 db                	xor    %ebx,%ebx
    1f32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  for(i = 0; i < N; i++){
    name[0] = 'p';
    1f38:	8d 7b 30             	lea    0x30(%ebx),%edi
    name[1] = '0' + i;
    1f3b:	89 f8                	mov    %edi,%eax
    exit();
  else
    wait();

  for(i = 0; i < N; i++){
    name[0] = 'p';
    1f3d:	c6 45 c8 70          	movb   $0x70,-0x38(%ebp)
    name[1] = '0' + i;
    1f41:	88 45 c9             	mov    %al,-0x37(%ebp)
    fd = open(name, 0);
    1f44:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1f4b:	00 
    1f4c:	89 34 24             	mov    %esi,(%esp)
    1f4f:	e8 24 13 00 00       	call   3278 <open>
    if((i == 0 || i >= N/2) && fd < 0){
    1f54:	83 fb 09             	cmp    $0x9,%ebx
    1f57:	0f 9f c1             	setg   %cl
    1f5a:	85 db                	test   %ebx,%ebx
    1f5c:	0f 94 c2             	sete   %dl
    1f5f:	08 d1                	or     %dl,%cl
    1f61:	88 4d c3             	mov    %cl,-0x3d(%ebp)
    1f64:	74 08                	je     1f6e <createdelete+0x10e>
    1f66:	85 c0                	test   %eax,%eax
    1f68:	0f 88 16 01 00 00    	js     2084 <createdelete+0x224>
      printf(1, "oops createdelete %s didn't exist\n", name);
      exit();
    } else if((i >= 1 && i < N/2) && fd >= 0){
    1f6e:	8d 53 ff             	lea    -0x1(%ebx),%edx
    1f71:	83 fa 08             	cmp    $0x8,%edx
    1f74:	89 c2                	mov    %eax,%edx
    1f76:	f7 d2                	not    %edx
    1f78:	0f 96 45 c4          	setbe  -0x3c(%ebp)
    1f7c:	c1 ea 1f             	shr    $0x1f,%edx
    1f7f:	80 7d c4 00          	cmpb   $0x0,-0x3c(%ebp)
    1f83:	0f 85 b9 00 00 00    	jne    2042 <createdelete+0x1e2>
      printf(1, "oops createdelete %s did exist\n", name);
      exit();
    }
    if(fd >= 0)
    1f89:	84 d2                	test   %dl,%dl
    1f8b:	74 08                	je     1f95 <createdelete+0x135>
      close(fd);
    1f8d:	89 04 24             	mov    %eax,(%esp)
    1f90:	e8 cb 12 00 00       	call   3260 <close>

    name[0] = 'c';
    name[1] = '0' + i;
    1f95:	89 f8                	mov    %edi,%eax
      exit();
    }
    if(fd >= 0)
      close(fd);

    name[0] = 'c';
    1f97:	c6 45 c8 63          	movb   $0x63,-0x38(%ebp)
    name[1] = '0' + i;
    1f9b:	88 45 c9             	mov    %al,-0x37(%ebp)
    fd = open(name, 0);
    1f9e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1fa5:	00 
    1fa6:	89 34 24             	mov    %esi,(%esp)
    1fa9:	e8 ca 12 00 00       	call   3278 <open>
    if((i == 0 || i >= N/2) && fd < 0){
    1fae:	80 7d c3 00          	cmpb   $0x0,-0x3d(%ebp)
    1fb2:	74 08                	je     1fbc <createdelete+0x15c>
    1fb4:	85 c0                	test   %eax,%eax
    1fb6:	0f 88 ab 00 00 00    	js     2067 <createdelete+0x207>
      printf(1, "oops createdelete %s didn't exist\n", name);
      exit();
    } else if((i >= 1 && i < N/2) && fd >= 0){
    1fbc:	85 c0                	test   %eax,%eax
    1fbe:	66 90                	xchg   %ax,%ax
    1fc0:	79 6e                	jns    2030 <createdelete+0x1d0>
  if(pid==0)
    exit();
  else
    wait();

  for(i = 0; i < N; i++){
    1fc2:	83 c3 01             	add    $0x1,%ebx
    1fc5:	83 fb 14             	cmp    $0x14,%ebx
    1fc8:	0f 85 6a ff ff ff    	jne    1f38 <createdelete+0xd8>
    1fce:	bb 30 00 00 00       	mov    $0x30,%ebx
    1fd3:	90                   	nop
    1fd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      close(fd);
  }

  for(i = 0; i < N; i++){
    name[0] = 'p';
    name[1] = '0' + i;
    1fd8:	88 5d c9             	mov    %bl,-0x37(%ebp)
    unlink(name);
    name[0] = 'c';
    unlink(name);
    1fdb:	83 c3 01             	add    $0x1,%ebx
    if(fd >= 0)
      close(fd);
  }

  for(i = 0; i < N; i++){
    name[0] = 'p';
    1fde:	c6 45 c8 70          	movb   $0x70,-0x38(%ebp)
    name[1] = '0' + i;
    unlink(name);
    1fe2:	89 34 24             	mov    %esi,(%esp)
    1fe5:	e8 9e 12 00 00       	call   3288 <unlink>
    name[0] = 'c';
    1fea:	c6 45 c8 63          	movb   $0x63,-0x38(%ebp)
    unlink(name);
    1fee:	89 34 24             	mov    %esi,(%esp)
    1ff1:	e8 92 12 00 00       	call   3288 <unlink>
    }
    if(fd >= 0)
      close(fd);
  }

  for(i = 0; i < N; i++){
    1ff6:	80 fb 44             	cmp    $0x44,%bl
    1ff9:	75 dd                	jne    1fd8 <createdelete+0x178>
    unlink(name);
    name[0] = 'c';
    unlink(name);
  }

  printf(1, "createdelete ok\n");
    1ffb:	c7 44 24 04 f1 40 00 	movl   $0x40f1,0x4(%esp)
    2002:	00 
    2003:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    200a:	e8 81 13 00 00       	call   3390 <printf>
}
    200f:	83 c4 4c             	add    $0x4c,%esp
    2012:	5b                   	pop    %ebx
    2013:	5e                   	pop    %esi
    2014:	5f                   	pop    %edi
    2015:	5d                   	pop    %ebp
    2016:	c3                   	ret    
  name[2] = '\0';
  for(i = 0; i < N; i++){
    name[1] = '0' + i;
    fd = open(name, O_CREATE | O_RDWR);
    if(fd < 0){
      printf(1, "create failed\n");
    2017:	c7 44 24 04 0f 3f 00 	movl   $0x3f0f,0x4(%esp)
    201e:	00 
    201f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2026:	e8 65 13 00 00       	call   3390 <printf>
      exit();
    202b:	e8 08 12 00 00       	call   3238 <exit>
    name[1] = '0' + i;
    fd = open(name, 0);
    if((i == 0 || i >= N/2) && fd < 0){
      printf(1, "oops createdelete %s didn't exist\n", name);
      exit();
    } else if((i >= 1 && i < N/2) && fd >= 0){
    2030:	80 7d c4 00          	cmpb   $0x0,-0x3c(%ebp)
    2034:	75 14                	jne    204a <createdelete+0x1ea>
      printf(1, "oops createdelete %s did exist\n", name);
      exit();
    }
    if(fd >= 0)
      close(fd);
    2036:	89 04 24             	mov    %eax,(%esp)
    2039:	e8 22 12 00 00       	call   3260 <close>
    203e:	66 90                	xchg   %ax,%ax
    2040:	eb 80                	jmp    1fc2 <createdelete+0x162>
    name[1] = '0' + i;
    fd = open(name, 0);
    if((i == 0 || i >= N/2) && fd < 0){
      printf(1, "oops createdelete %s didn't exist\n", name);
      exit();
    } else if((i >= 1 && i < N/2) && fd >= 0){
    2042:	84 d2                	test   %dl,%dl
    2044:	0f 84 4b ff ff ff    	je     1f95 <createdelete+0x135>
    fd = open(name, 0);
    if((i == 0 || i >= N/2) && fd < 0){
      printf(1, "oops createdelete %s didn't exist\n", name);
      exit();
    } else if((i >= 1 && i < N/2) && fd >= 0){
      printf(1, "oops createdelete %s did exist\n", name);
    204a:	89 74 24 08          	mov    %esi,0x8(%esp)
    204e:	c7 44 24 04 cc 49 00 	movl   $0x49cc,0x4(%esp)
    2055:	00 
    2056:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    205d:	e8 2e 13 00 00       	call   3390 <printf>
      exit();
    2062:	e8 d1 11 00 00       	call   3238 <exit>

    name[0] = 'c';
    name[1] = '0' + i;
    fd = open(name, 0);
    if((i == 0 || i >= N/2) && fd < 0){
      printf(1, "oops createdelete %s didn't exist\n", name);
    2067:	89 74 24 08          	mov    %esi,0x8(%esp)
    206b:	c7 44 24 04 a8 49 00 	movl   $0x49a8,0x4(%esp)
    2072:	00 
    2073:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    207a:	e8 11 13 00 00       	call   3390 <printf>
      exit();
    207f:	e8 b4 11 00 00       	call   3238 <exit>
  for(i = 0; i < N; i++){
    name[0] = 'p';
    name[1] = '0' + i;
    fd = open(name, 0);
    if((i == 0 || i >= N/2) && fd < 0){
      printf(1, "oops createdelete %s didn't exist\n", name);
    2084:	89 74 24 08          	mov    %esi,0x8(%esp)
    2088:	c7 44 24 04 a8 49 00 	movl   $0x49a8,0x4(%esp)
    208f:	00 
    2090:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2097:	e8 f4 12 00 00       	call   3390 <printf>
      exit();
    209c:	e8 97 11 00 00       	call   3238 <exit>
  char name[32];

  printf(1, "createdelete test\n");
  pid = fork();
  if(pid < 0){
    printf(1, "fork failed\n");
    20a1:	c7 44 24 04 5b 38 00 	movl   $0x385b,0x4(%esp)
    20a8:	00 
    20a9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    20b0:	e8 db 12 00 00       	call   3390 <printf>
    exit();
    20b5:	e8 7e 11 00 00       	call   3238 <exit>
    20ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000020c0 <dirtest>:
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
}

void dirtest(void)
{
    20c0:	55                   	push   %ebp
    20c1:	89 e5                	mov    %esp,%ebp
    20c3:	83 ec 18             	sub    $0x18,%esp
  printf(stdout, "mkdir test\n");
    20c6:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
    20cb:	c7 44 24 04 02 41 00 	movl   $0x4102,0x4(%esp)
    20d2:	00 
    20d3:	89 04 24             	mov    %eax,(%esp)
    20d6:	e8 b5 12 00 00       	call   3390 <printf>

  if(mkdir("dir0") < 0) {
    20db:	c7 04 24 0e 41 00 00 	movl   $0x410e,(%esp)
    20e2:	e8 b9 11 00 00       	call   32a0 <mkdir>
    20e7:	85 c0                	test   %eax,%eax
    20e9:	78 4b                	js     2136 <dirtest+0x76>
    printf(stdout, "mkdir failed\n");
    exit();
  }

  if(chdir("dir0") < 0) {
    20eb:	c7 04 24 0e 41 00 00 	movl   $0x410e,(%esp)
    20f2:	e8 b1 11 00 00       	call   32a8 <chdir>
    20f7:	85 c0                	test   %eax,%eax
    20f9:	0f 88 85 00 00 00    	js     2184 <dirtest+0xc4>
    printf(stdout, "chdir dir0 failed\n");
    exit();
  }

  if(chdir("..") < 0) {
    20ff:	c7 04 24 10 3d 00 00 	movl   $0x3d10,(%esp)
    2106:	e8 9d 11 00 00       	call   32a8 <chdir>
    210b:	85 c0                	test   %eax,%eax
    210d:	78 5b                	js     216a <dirtest+0xaa>
    printf(stdout, "chdir .. failed\n");
    exit();
  }

  if(unlink("dir0") < 0) {
    210f:	c7 04 24 0e 41 00 00 	movl   $0x410e,(%esp)
    2116:	e8 6d 11 00 00       	call   3288 <unlink>
    211b:	85 c0                	test   %eax,%eax
    211d:	78 31                	js     2150 <dirtest+0x90>
    printf(stdout, "unlink dir0 failed\n");
    exit();
  }
  printf(stdout, "mkdir test\n");
    211f:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
    2124:	c7 44 24 04 02 41 00 	movl   $0x4102,0x4(%esp)
    212b:	00 
    212c:	89 04 24             	mov    %eax,(%esp)
    212f:	e8 5c 12 00 00       	call   3390 <printf>
}
    2134:	c9                   	leave  
    2135:	c3                   	ret    
void dirtest(void)
{
  printf(stdout, "mkdir test\n");

  if(mkdir("dir0") < 0) {
    printf(stdout, "mkdir failed\n");
    2136:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
    213b:	c7 44 24 04 13 41 00 	movl   $0x4113,0x4(%esp)
    2142:	00 
    2143:	89 04 24             	mov    %eax,(%esp)
    2146:	e8 45 12 00 00       	call   3390 <printf>
    exit();
    214b:	e8 e8 10 00 00       	call   3238 <exit>
    printf(stdout, "chdir .. failed\n");
    exit();
  }

  if(unlink("dir0") < 0) {
    printf(stdout, "unlink dir0 failed\n");
    2150:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
    2155:	c7 44 24 04 45 41 00 	movl   $0x4145,0x4(%esp)
    215c:	00 
    215d:	89 04 24             	mov    %eax,(%esp)
    2160:	e8 2b 12 00 00       	call   3390 <printf>
    exit();
    2165:	e8 ce 10 00 00       	call   3238 <exit>
    printf(stdout, "chdir dir0 failed\n");
    exit();
  }

  if(chdir("..") < 0) {
    printf(stdout, "chdir .. failed\n");
    216a:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
    216f:	c7 44 24 04 34 41 00 	movl   $0x4134,0x4(%esp)
    2176:	00 
    2177:	89 04 24             	mov    %eax,(%esp)
    217a:	e8 11 12 00 00       	call   3390 <printf>
    exit();
    217f:	e8 b4 10 00 00       	call   3238 <exit>
    printf(stdout, "mkdir failed\n");
    exit();
  }

  if(chdir("dir0") < 0) {
    printf(stdout, "chdir dir0 failed\n");
    2184:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
    2189:	c7 44 24 04 21 41 00 	movl   $0x4121,0x4(%esp)
    2190:	00 
    2191:	89 04 24             	mov    %eax,(%esp)
    2194:	e8 f7 11 00 00       	call   3390 <printf>
    exit();
    2199:	e8 9a 10 00 00       	call   3238 <exit>
    219e:	66 90                	xchg   %ax,%ax

000021a0 <createtest>:
  printf(stdout, "big files ok\n");
}

void
createtest(void)
{
    21a0:	55                   	push   %ebp
    21a1:	89 e5                	mov    %esp,%ebp
    21a3:	53                   	push   %ebx
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
    21a4:	bb 30 00 00 00       	mov    $0x30,%ebx
  printf(stdout, "big files ok\n");
}

void
createtest(void)
{
    21a9:	83 ec 14             	sub    $0x14,%esp
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");
    21ac:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
    21b1:	c7 44 24 04 ec 49 00 	movl   $0x49ec,0x4(%esp)
    21b8:	00 
    21b9:	89 04 24             	mov    %eax,(%esp)
    21bc:	e8 cf 11 00 00       	call   3390 <printf>

  name[0] = 'a';
    21c1:	c6 05 a0 53 00 00 61 	movb   $0x61,0x53a0
  name[2] = '\0';
    21c8:	c6 05 a2 53 00 00 00 	movb   $0x0,0x53a2
    21cf:	90                   	nop
  for(i = 0; i < 52; i++) {
    name[1] = '0' + i;
    21d0:	88 1d a1 53 00 00    	mov    %bl,0x53a1
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
    21d6:	83 c3 01             	add    $0x1,%ebx

  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++) {
    name[1] = '0' + i;
    fd = open(name, O_CREATE|O_RDWR);
    21d9:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    21e0:	00 
    21e1:	c7 04 24 a0 53 00 00 	movl   $0x53a0,(%esp)
    21e8:	e8 8b 10 00 00       	call   3278 <open>
    close(fd);
    21ed:	89 04 24             	mov    %eax,(%esp)
    21f0:	e8 6b 10 00 00       	call   3260 <close>

  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++) {
    21f5:	80 fb 64             	cmp    $0x64,%bl
    21f8:	75 d6                	jne    21d0 <createtest+0x30>
    name[1] = '0' + i;
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
    21fa:	c6 05 a0 53 00 00 61 	movb   $0x61,0x53a0
  name[2] = '\0';
    2201:	bb 30 00 00 00       	mov    $0x30,%ebx
    2206:	c6 05 a2 53 00 00 00 	movb   $0x0,0x53a2
    220d:	8d 76 00             	lea    0x0(%esi),%esi
  for(i = 0; i < 52; i++) {
    name[1] = '0' + i;
    2210:	88 1d a1 53 00 00    	mov    %bl,0x53a1
    unlink(name);
    2216:	83 c3 01             	add    $0x1,%ebx
    2219:	c7 04 24 a0 53 00 00 	movl   $0x53a0,(%esp)
    2220:	e8 63 10 00 00       	call   3288 <unlink>
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++) {
    2225:	80 fb 64             	cmp    $0x64,%bl
    2228:	75 e6                	jne    2210 <createtest+0x70>
    name[1] = '0' + i;
    unlink(name);
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
    222a:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
    222f:	c7 44 24 04 14 4a 00 	movl   $0x4a14,0x4(%esp)
    2236:	00 
    2237:	89 04 24             	mov    %eax,(%esp)
    223a:	e8 51 11 00 00       	call   3390 <printf>
}
    223f:	83 c4 14             	add    $0x14,%esp
    2242:	5b                   	pop    %ebx
    2243:	5d                   	pop    %ebp
    2244:	c3                   	ret    
    2245:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002250 <writetest1>:
  printf(stdout, "small file test ok\n");
}

void
writetest1(void)
{
    2250:	55                   	push   %ebp
    2251:	89 e5                	mov    %esp,%ebp
    2253:	56                   	push   %esi
    2254:	53                   	push   %ebx
    2255:	83 ec 10             	sub    $0x10,%esp
  int i, fd, n;

  printf(stdout, "big files test\n");
    2258:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
    225d:	c7 44 24 04 59 41 00 	movl   $0x4159,0x4(%esp)
    2264:	00 
    2265:	89 04 24             	mov    %eax,(%esp)
    2268:	e8 23 11 00 00       	call   3390 <printf>

  fd = open("big", O_CREATE|O_RDWR);
    226d:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    2274:	00 
    2275:	c7 04 24 d3 41 00 00 	movl   $0x41d3,(%esp)
    227c:	e8 f7 0f 00 00       	call   3278 <open>
  if(fd < 0){
    2281:	85 c0                	test   %eax,%eax
{
  int i, fd, n;

  printf(stdout, "big files test\n");

  fd = open("big", O_CREATE|O_RDWR);
    2283:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    2285:	0f 88 7a 01 00 00    	js     2405 <writetest1+0x1b5>
    printf(stdout, "error: creat big failed!\n");
    exit();
    228b:	31 db                	xor    %ebx,%ebx
    228d:	8d 76 00             	lea    0x0(%esi),%esi
  }

  for(i = 0; i < MAXFILE; i++) {
    ((int*) buf)[0] = i;
    2290:	89 1d a0 4b 00 00    	mov    %ebx,0x4ba0
    if(write(fd, buf, 512) != 512) {
    2296:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    229d:	00 
    229e:	c7 44 24 04 a0 4b 00 	movl   $0x4ba0,0x4(%esp)
    22a5:	00 
    22a6:	89 34 24             	mov    %esi,(%esp)
    22a9:	e8 aa 0f 00 00       	call   3258 <write>
    22ae:	3d 00 02 00 00       	cmp    $0x200,%eax
    22b3:	0f 85 b2 00 00 00    	jne    236b <writetest1+0x11b>
  if(fd < 0){
    printf(stdout, "error: creat big failed!\n");
    exit();
  }

  for(i = 0; i < MAXFILE; i++) {
    22b9:	83 c3 01             	add    $0x1,%ebx
    22bc:	81 fb 8c 00 00 00    	cmp    $0x8c,%ebx
    22c2:	75 cc                	jne    2290 <writetest1+0x40>
      printf(stdout, "error: write big file failed\n", i);
      exit();
    }
  }

  close(fd);
    22c4:	89 34 24             	mov    %esi,(%esp)
    22c7:	e8 94 0f 00 00       	call   3260 <close>

  fd = open("big", O_RDONLY);
    22cc:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    22d3:	00 
    22d4:	c7 04 24 d3 41 00 00 	movl   $0x41d3,(%esp)
    22db:	e8 98 0f 00 00       	call   3278 <open>
  if(fd < 0){
    22e0:	85 c0                	test   %eax,%eax
    }
  }

  close(fd);

  fd = open("big", O_RDONLY);
    22e2:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    22e4:	0f 88 01 01 00 00    	js     23eb <writetest1+0x19b>
    printf(stdout, "error: open big failed!\n");
    exit();
    22ea:	31 db                	xor    %ebx,%ebx
    22ec:	eb 1d                	jmp    230b <writetest1+0xbb>
    22ee:	66 90                	xchg   %ax,%ax
      if(n == MAXFILE - 1) {
        printf(stdout, "read only %d blocks from big", n);
        exit();
      }
      break;
    } else if(i != 512) {
    22f0:	3d 00 02 00 00       	cmp    $0x200,%eax
    22f5:	0f 85 b0 00 00 00    	jne    23ab <writetest1+0x15b>
      printf(stdout, "read failed %d\n", i);
      exit();
    }
    if(((int*)buf)[0] != n) {
    22fb:	a1 a0 4b 00 00       	mov    0x4ba0,%eax
    2300:	39 d8                	cmp    %ebx,%eax
    2302:	0f 85 81 00 00 00    	jne    2389 <writetest1+0x139>
      printf(stdout, "read content of block %d is %d\n",
             n, ((int*)buf)[0]);
      exit();
    }
    n++;
    2308:	83 c3 01             	add    $0x1,%ebx
    exit();
  }

  n = 0;
  for(;;) {
    i = read(fd, buf, 512);
    230b:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    2312:	00 
    2313:	c7 44 24 04 a0 4b 00 	movl   $0x4ba0,0x4(%esp)
    231a:	00 
    231b:	89 34 24             	mov    %esi,(%esp)
    231e:	e8 2d 0f 00 00       	call   3250 <read>
    if(i == 0) {
    2323:	85 c0                	test   %eax,%eax
    2325:	75 c9                	jne    22f0 <writetest1+0xa0>
      if(n == MAXFILE - 1) {
    2327:	81 fb 8b 00 00 00    	cmp    $0x8b,%ebx
    232d:	0f 84 96 00 00 00    	je     23c9 <writetest1+0x179>
             n, ((int*)buf)[0]);
      exit();
    }
    n++;
  }
  close(fd);
    2333:	89 34 24             	mov    %esi,(%esp)
    2336:	e8 25 0f 00 00       	call   3260 <close>
  if(unlink("big") < 0) {
    233b:	c7 04 24 d3 41 00 00 	movl   $0x41d3,(%esp)
    2342:	e8 41 0f 00 00       	call   3288 <unlink>
    2347:	85 c0                	test   %eax,%eax
    2349:	0f 88 d0 00 00 00    	js     241f <writetest1+0x1cf>
    printf(stdout, "unlink big failed\n");
    exit();
  }
  printf(stdout, "big files ok\n");
    234f:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
    2354:	c7 44 24 04 fa 41 00 	movl   $0x41fa,0x4(%esp)
    235b:	00 
    235c:	89 04 24             	mov    %eax,(%esp)
    235f:	e8 2c 10 00 00       	call   3390 <printf>
}
    2364:	83 c4 10             	add    $0x10,%esp
    2367:	5b                   	pop    %ebx
    2368:	5e                   	pop    %esi
    2369:	5d                   	pop    %ebp
    236a:	c3                   	ret    
  }

  for(i = 0; i < MAXFILE; i++) {
    ((int*) buf)[0] = i;
    if(write(fd, buf, 512) != 512) {
      printf(stdout, "error: write big file failed\n", i);
    236b:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
    2370:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    2374:	c7 44 24 04 83 41 00 	movl   $0x4183,0x4(%esp)
    237b:	00 
    237c:	89 04 24             	mov    %eax,(%esp)
    237f:	e8 0c 10 00 00       	call   3390 <printf>
      exit();
    2384:	e8 af 0e 00 00       	call   3238 <exit>
    } else if(i != 512) {
      printf(stdout, "read failed %d\n", i);
      exit();
    }
    if(((int*)buf)[0] != n) {
      printf(stdout, "read content of block %d is %d\n",
    2389:	89 44 24 0c          	mov    %eax,0xc(%esp)
    238d:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
    2392:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    2396:	c7 44 24 04 3c 4a 00 	movl   $0x4a3c,0x4(%esp)
    239d:	00 
    239e:	89 04 24             	mov    %eax,(%esp)
    23a1:	e8 ea 0f 00 00       	call   3390 <printf>
             n, ((int*)buf)[0]);
      exit();
    23a6:	e8 8d 0e 00 00       	call   3238 <exit>
        printf(stdout, "read only %d blocks from big", n);
        exit();
      }
      break;
    } else if(i != 512) {
      printf(stdout, "read failed %d\n", i);
    23ab:	89 44 24 08          	mov    %eax,0x8(%esp)
    23af:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
    23b4:	c7 44 24 04 d7 41 00 	movl   $0x41d7,0x4(%esp)
    23bb:	00 
    23bc:	89 04 24             	mov    %eax,(%esp)
    23bf:	e8 cc 0f 00 00       	call   3390 <printf>
      exit();
    23c4:	e8 6f 0e 00 00       	call   3238 <exit>
  n = 0;
  for(;;) {
    i = read(fd, buf, 512);
    if(i == 0) {
      if(n == MAXFILE - 1) {
        printf(stdout, "read only %d blocks from big", n);
    23c9:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
    23ce:	c7 44 24 08 8b 00 00 	movl   $0x8b,0x8(%esp)
    23d5:	00 
    23d6:	c7 44 24 04 ba 41 00 	movl   $0x41ba,0x4(%esp)
    23dd:	00 
    23de:	89 04 24             	mov    %eax,(%esp)
    23e1:	e8 aa 0f 00 00       	call   3390 <printf>
        exit();
    23e6:	e8 4d 0e 00 00       	call   3238 <exit>

  close(fd);

  fd = open("big", O_RDONLY);
  if(fd < 0){
    printf(stdout, "error: open big failed!\n");
    23eb:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
    23f0:	c7 44 24 04 a1 41 00 	movl   $0x41a1,0x4(%esp)
    23f7:	00 
    23f8:	89 04 24             	mov    %eax,(%esp)
    23fb:	e8 90 0f 00 00       	call   3390 <printf>
    exit();
    2400:	e8 33 0e 00 00       	call   3238 <exit>

  printf(stdout, "big files test\n");

  fd = open("big", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(stdout, "error: creat big failed!\n");
    2405:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
    240a:	c7 44 24 04 69 41 00 	movl   $0x4169,0x4(%esp)
    2411:	00 
    2412:	89 04 24             	mov    %eax,(%esp)
    2415:	e8 76 0f 00 00       	call   3390 <printf>
    exit();
    241a:	e8 19 0e 00 00       	call   3238 <exit>
    }
    n++;
  }
  close(fd);
  if(unlink("big") < 0) {
    printf(stdout, "unlink big failed\n");
    241f:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
    2424:	c7 44 24 04 e7 41 00 	movl   $0x41e7,0x4(%esp)
    242b:	00 
    242c:	89 04 24             	mov    %eax,(%esp)
    242f:	e8 5c 0f 00 00       	call   3390 <printf>
    exit();
    2434:	e8 ff 0d 00 00       	call   3238 <exit>
    2439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00002440 <writetest>:
  printf(stdout, "open test ok\n");
}

void
writetest(void)
{
    2440:	55                   	push   %ebp
    2441:	89 e5                	mov    %esp,%ebp
    2443:	56                   	push   %esi
    2444:	53                   	push   %ebx
    2445:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int i;

  printf(stdout, "small file test\n");
    2448:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
    244d:	c7 44 24 04 08 42 00 	movl   $0x4208,0x4(%esp)
    2454:	00 
    2455:	89 04 24             	mov    %eax,(%esp)
    2458:	e8 33 0f 00 00       	call   3390 <printf>
  fd = open("small", O_CREATE|O_RDWR);
    245d:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    2464:	00 
    2465:	c7 04 24 19 42 00 00 	movl   $0x4219,(%esp)
    246c:	e8 07 0e 00 00       	call   3278 <open>
  if(fd >= 0){
    2471:	85 c0                	test   %eax,%eax
{
  int fd;
  int i;

  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_RDWR);
    2473:	89 c6                	mov    %eax,%esi
  if(fd >= 0){
    2475:	0f 88 b1 01 00 00    	js     262c <writetest+0x1ec>
    printf(stdout, "creat small succeeded; ok\n");
    247b:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
    2480:	31 db                	xor    %ebx,%ebx
    2482:	c7 44 24 04 1f 42 00 	movl   $0x421f,0x4(%esp)
    2489:	00 
    248a:	89 04 24             	mov    %eax,(%esp)
    248d:	e8 fe 0e 00 00       	call   3390 <printf>
    2492:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++) {
    if(write(fd, "aaaaaaaaaa", 10) != 10) {
    2498:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    249f:	00 
    24a0:	c7 44 24 04 56 42 00 	movl   $0x4256,0x4(%esp)
    24a7:	00 
    24a8:	89 34 24             	mov    %esi,(%esp)
    24ab:	e8 a8 0d 00 00       	call   3258 <write>
    24b0:	83 f8 0a             	cmp    $0xa,%eax
    24b3:	0f 85 e9 00 00 00    	jne    25a2 <writetest+0x162>
      printf(stdout, "error: write aa %d new file failed\n", i);
      exit();
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10) {
    24b9:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    24c0:	00 
    24c1:	c7 44 24 04 61 42 00 	movl   $0x4261,0x4(%esp)
    24c8:	00 
    24c9:	89 34 24             	mov    %esi,(%esp)
    24cc:	e8 87 0d 00 00       	call   3258 <write>
    24d1:	83 f8 0a             	cmp    $0xa,%eax
    24d4:	0f 85 e6 00 00 00    	jne    25c0 <writetest+0x180>
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++) {
    24da:	83 c3 01             	add    $0x1,%ebx
    24dd:	83 fb 64             	cmp    $0x64,%ebx
    24e0:	75 b6                	jne    2498 <writetest+0x58>
    if(write(fd, "bbbbbbbbbb", 10) != 10) {
      printf(stdout, "error: write bb %d new file failed\n", i);
      exit();
    }
  }
  printf(stdout, "writes ok\n");
    24e2:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
    24e7:	c7 44 24 04 6c 42 00 	movl   $0x426c,0x4(%esp)
    24ee:	00 
    24ef:	89 04 24             	mov    %eax,(%esp)
    24f2:	e8 99 0e 00 00       	call   3390 <printf>
  close(fd);
    24f7:	89 34 24             	mov    %esi,(%esp)
    24fa:	e8 61 0d 00 00       	call   3260 <close>
  fd = open("small", O_RDONLY);
    24ff:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2506:	00 
    2507:	c7 04 24 19 42 00 00 	movl   $0x4219,(%esp)
    250e:	e8 65 0d 00 00       	call   3278 <open>
  if(fd >= 0){
    2513:	85 c0                	test   %eax,%eax
      exit();
    }
  }
  printf(stdout, "writes ok\n");
  close(fd);
  fd = open("small", O_RDONLY);
    2515:	89 c3                	mov    %eax,%ebx
  if(fd >= 0){
    2517:	0f 88 c1 00 00 00    	js     25de <writetest+0x19e>
    printf(stdout, "open small succeeded ok\n");
    251d:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
    2522:	c7 44 24 04 77 42 00 	movl   $0x4277,0x4(%esp)
    2529:	00 
    252a:	89 04 24             	mov    %eax,(%esp)
    252d:	e8 5e 0e 00 00       	call   3390 <printf>
  } else {
    printf(stdout, "error: open small failed!\n");
    exit();
  }
  i = read(fd, buf, 2000);
    2532:	c7 44 24 08 d0 07 00 	movl   $0x7d0,0x8(%esp)
    2539:	00 
    253a:	c7 44 24 04 a0 4b 00 	movl   $0x4ba0,0x4(%esp)
    2541:	00 
    2542:	89 1c 24             	mov    %ebx,(%esp)
    2545:	e8 06 0d 00 00       	call   3250 <read>
  if(i == 2000) {
    254a:	3d d0 07 00 00       	cmp    $0x7d0,%eax
    254f:	0f 85 a3 00 00 00    	jne    25f8 <writetest+0x1b8>
    printf(stdout, "read succeeded ok\n");
    2555:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
    255a:	c7 44 24 04 ab 42 00 	movl   $0x42ab,0x4(%esp)
    2561:	00 
    2562:	89 04 24             	mov    %eax,(%esp)
    2565:	e8 26 0e 00 00       	call   3390 <printf>
  } else {
    printf(stdout, "read failed\n");
    exit();
  }
  close(fd);
    256a:	89 1c 24             	mov    %ebx,(%esp)
    256d:	e8 ee 0c 00 00       	call   3260 <close>

  if(unlink("small") < 0) {
    2572:	c7 04 24 19 42 00 00 	movl   $0x4219,(%esp)
    2579:	e8 0a 0d 00 00       	call   3288 <unlink>
    257e:	85 c0                	test   %eax,%eax
    2580:	0f 88 8c 00 00 00    	js     2612 <writetest+0x1d2>
    printf(stdout, "unlink small failed\n");
    exit();
  }
  printf(stdout, "small file test ok\n");
    2586:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
    258b:	c7 44 24 04 d3 42 00 	movl   $0x42d3,0x4(%esp)
    2592:	00 
    2593:	89 04 24             	mov    %eax,(%esp)
    2596:	e8 f5 0d 00 00       	call   3390 <printf>
}
    259b:	83 c4 10             	add    $0x10,%esp
    259e:	5b                   	pop    %ebx
    259f:	5e                   	pop    %esi
    25a0:	5d                   	pop    %ebp
    25a1:	c3                   	ret    
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++) {
    if(write(fd, "aaaaaaaaaa", 10) != 10) {
      printf(stdout, "error: write aa %d new file failed\n", i);
    25a2:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
    25a7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    25ab:	c7 44 24 04 5c 4a 00 	movl   $0x4a5c,0x4(%esp)
    25b2:	00 
    25b3:	89 04 24             	mov    %eax,(%esp)
    25b6:	e8 d5 0d 00 00       	call   3390 <printf>
      exit();
    25bb:	e8 78 0c 00 00       	call   3238 <exit>
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10) {
      printf(stdout, "error: write bb %d new file failed\n", i);
    25c0:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
    25c5:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    25c9:	c7 44 24 04 80 4a 00 	movl   $0x4a80,0x4(%esp)
    25d0:	00 
    25d1:	89 04 24             	mov    %eax,(%esp)
    25d4:	e8 b7 0d 00 00       	call   3390 <printf>
      exit();
    25d9:	e8 5a 0c 00 00       	call   3238 <exit>
  close(fd);
  fd = open("small", O_RDONLY);
  if(fd >= 0){
    printf(stdout, "open small succeeded ok\n");
  } else {
    printf(stdout, "error: open small failed!\n");
    25de:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
    25e3:	c7 44 24 04 90 42 00 	movl   $0x4290,0x4(%esp)
    25ea:	00 
    25eb:	89 04 24             	mov    %eax,(%esp)
    25ee:	e8 9d 0d 00 00       	call   3390 <printf>
    exit();
    25f3:	e8 40 0c 00 00       	call   3238 <exit>
  }
  i = read(fd, buf, 2000);
  if(i == 2000) {
    printf(stdout, "read succeeded ok\n");
  } else {
    printf(stdout, "read failed\n");
    25f8:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
    25fd:	c7 44 24 04 36 40 00 	movl   $0x4036,0x4(%esp)
    2604:	00 
    2605:	89 04 24             	mov    %eax,(%esp)
    2608:	e8 83 0d 00 00       	call   3390 <printf>
    exit();
    260d:	e8 26 0c 00 00       	call   3238 <exit>
  }
  close(fd);

  if(unlink("small") < 0) {
    printf(stdout, "unlink small failed\n");
    2612:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
    2617:	c7 44 24 04 be 42 00 	movl   $0x42be,0x4(%esp)
    261e:	00 
    261f:	89 04 24             	mov    %eax,(%esp)
    2622:	e8 69 0d 00 00       	call   3390 <printf>
    exit();
    2627:	e8 0c 0c 00 00       	call   3238 <exit>
  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_RDWR);
  if(fd >= 0){
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
    262c:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
    2631:	c7 44 24 04 3a 42 00 	movl   $0x423a,0x4(%esp)
    2638:	00 
    2639:	89 04 24             	mov    %eax,(%esp)
    263c:	e8 4f 0d 00 00       	call   3390 <printf>
    exit();
    2641:	e8 f2 0b 00 00       	call   3238 <exit>
    2646:	8d 76 00             	lea    0x0(%esi),%esi
    2649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002650 <bigfile>:
  printf(1, "subdir ok\n");
}

void
bigfile(void)
{
    2650:	55                   	push   %ebp
    2651:	89 e5                	mov    %esp,%ebp
    2653:	57                   	push   %edi
    2654:	56                   	push   %esi
    2655:	53                   	push   %ebx
    2656:	83 ec 1c             	sub    $0x1c,%esp
  int fd, i, total, cc;

  printf(1, "bigfile test\n");
    2659:	c7 44 24 04 e7 42 00 	movl   $0x42e7,0x4(%esp)
    2660:	00 
    2661:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2668:	e8 23 0d 00 00       	call   3390 <printf>

  unlink("bigfile");
    266d:	c7 04 24 03 43 00 00 	movl   $0x4303,(%esp)
    2674:	e8 0f 0c 00 00       	call   3288 <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
    2679:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    2680:	00 
    2681:	c7 04 24 03 43 00 00 	movl   $0x4303,(%esp)
    2688:	e8 eb 0b 00 00       	call   3278 <open>
  if(fd < 0){
    268d:	85 c0                	test   %eax,%eax
  int fd, i, total, cc;

  printf(1, "bigfile test\n");

  unlink("bigfile");
  fd = open("bigfile", O_CREATE | O_RDWR);
    268f:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    2691:	0f 88 7f 01 00 00    	js     2816 <bigfile+0x1c6>
    printf(1, "cannot create bigfile");
    exit();
    2697:	31 db                	xor    %ebx,%ebx
    2699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  for(i = 0; i < 20; i++){
    memset(buf, i, 600);
    26a0:	c7 44 24 08 58 02 00 	movl   $0x258,0x8(%esp)
    26a7:	00 
    26a8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    26ac:	c7 04 24 a0 4b 00 00 	movl   $0x4ba0,(%esp)
    26b3:	e8 f8 09 00 00       	call   30b0 <memset>
    if(write(fd, buf, 600) != 600){
    26b8:	c7 44 24 08 58 02 00 	movl   $0x258,0x8(%esp)
    26bf:	00 
    26c0:	c7 44 24 04 a0 4b 00 	movl   $0x4ba0,0x4(%esp)
    26c7:	00 
    26c8:	89 34 24             	mov    %esi,(%esp)
    26cb:	e8 88 0b 00 00       	call   3258 <write>
    26d0:	3d 58 02 00 00       	cmp    $0x258,%eax
    26d5:	0f 85 09 01 00 00    	jne    27e4 <bigfile+0x194>
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "cannot create bigfile");
    exit();
  }
  for(i = 0; i < 20; i++){
    26db:	83 c3 01             	add    $0x1,%ebx
    26de:	83 fb 14             	cmp    $0x14,%ebx
    26e1:	75 bd                	jne    26a0 <bigfile+0x50>
    if(write(fd, buf, 600) != 600){
      printf(1, "write bigfile failed\n");
      exit();
    }
  }
  close(fd);
    26e3:	89 34 24             	mov    %esi,(%esp)
    26e6:	e8 75 0b 00 00       	call   3260 <close>

  fd = open("bigfile", 0);
    26eb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    26f2:	00 
    26f3:	c7 04 24 03 43 00 00 	movl   $0x4303,(%esp)
    26fa:	e8 79 0b 00 00       	call   3278 <open>
  if(fd < 0){
    26ff:	85 c0                	test   %eax,%eax
      exit();
    }
  }
  close(fd);

  fd = open("bigfile", 0);
    2701:	89 c7                	mov    %eax,%edi
  if(fd < 0){
    2703:	0f 88 f4 00 00 00    	js     27fd <bigfile+0x1ad>
    printf(1, "cannot open bigfile\n");
    exit();
    2709:	31 f6                	xor    %esi,%esi
    270b:	31 db                	xor    %ebx,%ebx
    270d:	eb 2f                	jmp    273e <bigfile+0xee>
    270f:	90                   	nop
      printf(1, "read bigfile failed\n");
      exit();
    }
    if(cc == 0)
      break;
    if(cc != 300){
    2710:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    2715:	0f 85 97 00 00 00    	jne    27b2 <bigfile+0x162>
      printf(1, "short read bigfile\n");
      exit();
    }
    if(buf[0] != i/2 || buf[299] != i/2){
    271b:	0f be 05 a0 4b 00 00 	movsbl 0x4ba0,%eax
    2722:	89 da                	mov    %ebx,%edx
    2724:	d1 fa                	sar    %edx
    2726:	39 d0                	cmp    %edx,%eax
    2728:	75 6f                	jne    2799 <bigfile+0x149>
    272a:	0f be 15 cb 4c 00 00 	movsbl 0x4ccb,%edx
    2731:	39 d0                	cmp    %edx,%eax
    2733:	75 64                	jne    2799 <bigfile+0x149>
      printf(1, "read bigfile wrong data\n");
      exit();
    }
    total += cc;
    2735:	81 c6 2c 01 00 00    	add    $0x12c,%esi
  if(fd < 0){
    printf(1, "cannot open bigfile\n");
    exit();
  }
  total = 0;
  for(i = 0; ; i++){
    273b:	83 c3 01             	add    $0x1,%ebx
    cc = read(fd, buf, 300);
    273e:	c7 44 24 08 2c 01 00 	movl   $0x12c,0x8(%esp)
    2745:	00 
    2746:	c7 44 24 04 a0 4b 00 	movl   $0x4ba0,0x4(%esp)
    274d:	00 
    274e:	89 3c 24             	mov    %edi,(%esp)
    2751:	e8 fa 0a 00 00       	call   3250 <read>
    if(cc < 0){
    2756:	83 f8 00             	cmp    $0x0,%eax
    2759:	7c 70                	jl     27cb <bigfile+0x17b>
      printf(1, "read bigfile failed\n");
      exit();
    }
    if(cc == 0)
    275b:	75 b3                	jne    2710 <bigfile+0xc0>
      printf(1, "read bigfile wrong data\n");
      exit();
    }
    total += cc;
  }
  close(fd);
    275d:	89 3c 24             	mov    %edi,(%esp)
    2760:	e8 fb 0a 00 00       	call   3260 <close>
  if(total != 20*600){
    2765:	81 fe e0 2e 00 00    	cmp    $0x2ee0,%esi
    276b:	0f 85 be 00 00 00    	jne    282f <bigfile+0x1df>
    printf(1, "read bigfile wrong total\n");
    exit();
  }
  unlink("bigfile");
    2771:	c7 04 24 03 43 00 00 	movl   $0x4303,(%esp)
    2778:	e8 0b 0b 00 00       	call   3288 <unlink>

  printf(1, "bigfile test ok\n");
    277d:	c7 44 24 04 92 43 00 	movl   $0x4392,0x4(%esp)
    2784:	00 
    2785:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    278c:	e8 ff 0b 00 00       	call   3390 <printf>
}
    2791:	83 c4 1c             	add    $0x1c,%esp
    2794:	5b                   	pop    %ebx
    2795:	5e                   	pop    %esi
    2796:	5f                   	pop    %edi
    2797:	5d                   	pop    %ebp
    2798:	c3                   	ret    
    if(cc != 300){
      printf(1, "short read bigfile\n");
      exit();
    }
    if(buf[0] != i/2 || buf[299] != i/2){
      printf(1, "read bigfile wrong data\n");
    2799:	c7 44 24 04 5f 43 00 	movl   $0x435f,0x4(%esp)
    27a0:	00 
    27a1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    27a8:	e8 e3 0b 00 00       	call   3390 <printf>
      exit();
    27ad:	e8 86 0a 00 00       	call   3238 <exit>
      exit();
    }
    if(cc == 0)
      break;
    if(cc != 300){
      printf(1, "short read bigfile\n");
    27b2:	c7 44 24 04 4b 43 00 	movl   $0x434b,0x4(%esp)
    27b9:	00 
    27ba:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    27c1:	e8 ca 0b 00 00       	call   3390 <printf>
      exit();
    27c6:	e8 6d 0a 00 00       	call   3238 <exit>
  }
  total = 0;
  for(i = 0; ; i++){
    cc = read(fd, buf, 300);
    if(cc < 0){
      printf(1, "read bigfile failed\n");
    27cb:	c7 44 24 04 36 43 00 	movl   $0x4336,0x4(%esp)
    27d2:	00 
    27d3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    27da:	e8 b1 0b 00 00       	call   3390 <printf>
      exit();
    27df:	e8 54 0a 00 00       	call   3238 <exit>
    exit();
  }
  for(i = 0; i < 20; i++){
    memset(buf, i, 600);
    if(write(fd, buf, 600) != 600){
      printf(1, "write bigfile failed\n");
    27e4:	c7 44 24 04 0b 43 00 	movl   $0x430b,0x4(%esp)
    27eb:	00 
    27ec:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    27f3:	e8 98 0b 00 00       	call   3390 <printf>
      exit();
    27f8:	e8 3b 0a 00 00       	call   3238 <exit>
  }
  close(fd);

  fd = open("bigfile", 0);
  if(fd < 0){
    printf(1, "cannot open bigfile\n");
    27fd:	c7 44 24 04 21 43 00 	movl   $0x4321,0x4(%esp)
    2804:	00 
    2805:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    280c:	e8 7f 0b 00 00       	call   3390 <printf>
    exit();
    2811:	e8 22 0a 00 00       	call   3238 <exit>
  printf(1, "bigfile test\n");

  unlink("bigfile");
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "cannot create bigfile");
    2816:	c7 44 24 04 f5 42 00 	movl   $0x42f5,0x4(%esp)
    281d:	00 
    281e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2825:	e8 66 0b 00 00       	call   3390 <printf>
    exit();
    282a:	e8 09 0a 00 00       	call   3238 <exit>
    }
    total += cc;
  }
  close(fd);
  if(total != 20*600){
    printf(1, "read bigfile wrong total\n");
    282f:	c7 44 24 04 78 43 00 	movl   $0x4378,0x4(%esp)
    2836:	00 
    2837:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    283e:	e8 4d 0b 00 00       	call   3390 <printf>
    exit();
    2843:	e8 f0 09 00 00       	call   3238 <exit>
    2848:	90                   	nop
    2849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00002850 <concreate>:
}

// test concurrent create and unlink of the same file
void
concreate(void)
{
    2850:	55                   	push   %ebp
    2851:	89 e5                	mov    %esp,%ebp
    2853:	57                   	push   %edi
    2854:	56                   	push   %esi
    2855:	53                   	push   %ebx
    char name[14];
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
    2856:	31 db                	xor    %ebx,%ebx
}

// test concurrent create and unlink of the same file
void
concreate(void)
{
    2858:	83 ec 6c             	sub    $0x6c,%esp
  struct {
    ushort inum;
    char name[14];
  } de;

  printf(1, "concreate test\n");
    285b:	c7 44 24 04 a3 43 00 	movl   $0x43a3,0x4(%esp)
    2862:	00 
    2863:	8d 7d e5             	lea    -0x1b(%ebp),%edi
    2866:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    286d:	e8 1e 0b 00 00       	call   3390 <printf>
  file[0] = 'C';
    2872:	c6 45 e5 43          	movb   $0x43,-0x1b(%ebp)
  file[2] = '\0';
    2876:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
    287a:	eb 4f                	jmp    28cb <concreate+0x7b>
    287c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
    2880:	b8 56 55 55 55       	mov    $0x55555556,%eax
    2885:	f7 eb                	imul   %ebx
    2887:	89 d8                	mov    %ebx,%eax
    2889:	c1 f8 1f             	sar    $0x1f,%eax
    288c:	29 c2                	sub    %eax,%edx
    288e:	8d 04 52             	lea    (%edx,%edx,2),%eax
    2891:	89 da                	mov    %ebx,%edx
    2893:	29 c2                	sub    %eax,%edx
    2895:	83 fa 01             	cmp    $0x1,%edx
    2898:	74 7e                	je     2918 <concreate+0xc8>
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
      link("C0", file);
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    289a:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    28a1:	00 
    28a2:	89 3c 24             	mov    %edi,(%esp)
    28a5:	e8 ce 09 00 00       	call   3278 <open>
      if(fd < 0){
    28aa:	85 c0                	test   %eax,%eax
    28ac:	0f 88 e3 01 00 00    	js     2a95 <concreate+0x245>
        printf(1, "concreate create %s failed\n", file);
        exit();
      }
      close(fd);
    28b2:	89 04 24             	mov    %eax,(%esp)
    28b5:	e8 a6 09 00 00       	call   3260 <close>
    }
    if(pid == 0)
    28ba:	85 f6                	test   %esi,%esi
    28bc:	74 52                	je     2910 <concreate+0xc0>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    28be:	83 c3 01             	add    $0x1,%ebx
      close(fd);
    }
    if(pid == 0)
      exit();
    else
      wait();
    28c1:	e8 7a 09 00 00       	call   3240 <wait>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    28c6:	83 fb 28             	cmp    $0x28,%ebx
    28c9:	74 6d                	je     2938 <concreate+0xe8>
    file[1] = '0' + i;
    28cb:	8d 43 30             	lea    0x30(%ebx),%eax
    28ce:	88 45 e6             	mov    %al,-0x1a(%ebp)
    unlink(file);
    28d1:	89 3c 24             	mov    %edi,(%esp)
    28d4:	e8 af 09 00 00       	call   3288 <unlink>
    pid = fork();
    28d9:	e8 52 09 00 00       	call   3230 <fork>
    if(pid && (i % 3) == 1){
    28de:	85 c0                	test   %eax,%eax
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    28e0:	89 c6                	mov    %eax,%esi
    if(pid && (i % 3) == 1){
    28e2:	75 9c                	jne    2880 <concreate+0x30>
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
    28e4:	b8 67 66 66 66       	mov    $0x66666667,%eax
    28e9:	f7 eb                	imul   %ebx
    28eb:	89 d8                	mov    %ebx,%eax
    28ed:	c1 f8 1f             	sar    $0x1f,%eax
    28f0:	d1 fa                	sar    %edx
    28f2:	29 c2                	sub    %eax,%edx
    28f4:	8d 04 92             	lea    (%edx,%edx,4),%eax
    28f7:	89 da                	mov    %ebx,%edx
    28f9:	29 c2                	sub    %eax,%edx
    28fb:	83 fa 01             	cmp    $0x1,%edx
    28fe:	75 9a                	jne    289a <concreate+0x4a>
      link("C0", file);
    2900:	89 7c 24 04          	mov    %edi,0x4(%esp)
    2904:	c7 04 24 b3 43 00 00 	movl   $0x43b3,(%esp)
    290b:	e8 88 09 00 00       	call   3298 <link>
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
      i = de.name[1] - '0';
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
        exit();
    2910:	e8 23 09 00 00       	call   3238 <exit>
    2915:	8d 76 00             	lea    0x0(%esi),%esi
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    2918:	83 c3 01             	add    $0x1,%ebx
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
      link("C0", file);
    291b:	89 7c 24 04          	mov    %edi,0x4(%esp)
    291f:	c7 04 24 b3 43 00 00 	movl   $0x43b3,(%esp)
    2926:	e8 6d 09 00 00       	call   3298 <link>
      close(fd);
    }
    if(pid == 0)
      exit();
    else
      wait();
    292b:	e8 10 09 00 00       	call   3240 <wait>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    2930:	83 fb 28             	cmp    $0x28,%ebx
    2933:	75 96                	jne    28cb <concreate+0x7b>
    2935:	8d 76 00             	lea    0x0(%esi),%esi
      exit();
    else
      wait();
  }

  memset(fa, 0, sizeof(fa));
    2938:	8d 45 ac             	lea    -0x54(%ebp),%eax
    293b:	c7 44 24 08 28 00 00 	movl   $0x28,0x8(%esp)
    2942:	00 
    2943:	8d 75 d4             	lea    -0x2c(%ebp),%esi
    2946:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    294d:	00 
    294e:	89 04 24             	mov    %eax,(%esp)
    2951:	e8 5a 07 00 00       	call   30b0 <memset>
  fd = open(".", 0);
    2956:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    295d:	00 
    295e:	c7 04 24 11 3d 00 00 	movl   $0x3d11,(%esp)
    2965:	e8 0e 09 00 00       	call   3278 <open>
    296a:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
    2971:	89 c3                	mov    %eax,%ebx
    2973:	90                   	nop
    2974:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  n = 0;
  while(read(fd, &de, sizeof(de)) > 0){
    2978:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    297f:	00 
    2980:	89 74 24 04          	mov    %esi,0x4(%esp)
    2984:	89 1c 24             	mov    %ebx,(%esp)
    2987:	e8 c4 08 00 00       	call   3250 <read>
    298c:	85 c0                	test   %eax,%eax
    298e:	7e 40                	jle    29d0 <concreate+0x180>
    if(de.inum == 0)
    2990:	66 83 7d d4 00       	cmpw   $0x0,-0x2c(%ebp)
    2995:	74 e1                	je     2978 <concreate+0x128>
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    2997:	80 7d d6 43          	cmpb   $0x43,-0x2a(%ebp)
    299b:	90                   	nop
    299c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    29a0:	75 d6                	jne    2978 <concreate+0x128>
    29a2:	80 7d d8 00          	cmpb   $0x0,-0x28(%ebp)
    29a6:	75 d0                	jne    2978 <concreate+0x128>
      i = de.name[1] - '0';
    29a8:	0f be 45 d7          	movsbl -0x29(%ebp),%eax
    29ac:	83 e8 30             	sub    $0x30,%eax
      if(i < 0 || i >= sizeof(fa)){
    29af:	83 f8 27             	cmp    $0x27,%eax
    29b2:	0f 87 fa 00 00 00    	ja     2ab2 <concreate+0x262>
        printf(1, "concreate weird file %s\n", de.name);
        exit();
      }
      if(fa[i]){
    29b8:	80 7c 05 ac 00       	cmpb   $0x0,-0x54(%ebp,%eax,1)
    29bd:	0f 85 28 01 00 00    	jne    2aeb <concreate+0x29b>
        printf(1, "concreate duplicate file %s\n", de.name);
        exit();
      }
      fa[i] = 1;
    29c3:	c6 44 05 ac 01       	movb   $0x1,-0x54(%ebp,%eax,1)
      n++;
    29c8:	83 45 a4 01          	addl   $0x1,-0x5c(%ebp)
    29cc:	eb aa                	jmp    2978 <concreate+0x128>
    29ce:	66 90                	xchg   %ax,%ax
    }
  }
  close(fd);
    29d0:	89 1c 24             	mov    %ebx,(%esp)
    29d3:	e8 88 08 00 00       	call   3260 <close>

  if(n != 40){
    29d8:	83 7d a4 28          	cmpl   $0x28,-0x5c(%ebp)
    29dc:	0f 85 f0 00 00 00    	jne    2ad2 <concreate+0x282>
    printf(1, "concreate not enough files in directory listing\n");
    exit();
    29e2:	31 db                	xor    %ebx,%ebx
    29e4:	eb 3d                	jmp    2a23 <concreate+0x1d3>
    29e6:	66 90                	xchg   %ax,%ax
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
      exit();
    }
    if(((i % 3) == 0 && pid == 0) ||
    29e8:	83 f8 01             	cmp    $0x1,%eax
    29eb:	90                   	nop
    29ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    29f0:	75 5d                	jne    2a4f <concreate+0x1ff>
    29f2:	85 f6                	test   %esi,%esi
    29f4:	74 59                	je     2a4f <concreate+0x1ff>
       ((i % 3) == 1 && pid != 0)){
      fd = open(file, 0);
    29f6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    29fd:	00 
    29fe:	89 3c 24             	mov    %edi,(%esp)
    2a01:	e8 72 08 00 00       	call   3278 <open>
      close(fd);
    2a06:	89 04 24             	mov    %eax,(%esp)
    2a09:	e8 52 08 00 00       	call   3260 <close>
    } else {
      unlink(file);
    }
    if(pid == 0)
    2a0e:	85 f6                	test   %esi,%esi
    2a10:	0f 84 fa fe ff ff    	je     2910 <concreate+0xc0>
  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    exit();
  }

  for(i = 0; i < 40; i++){
    2a16:	83 c3 01             	add    $0x1,%ebx
      unlink(file);
    }
    if(pid == 0)
      exit();
    else
      wait();
    2a19:	e8 22 08 00 00       	call   3240 <wait>
  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    exit();
  }

  for(i = 0; i < 40; i++){
    2a1e:	83 fb 28             	cmp    $0x28,%ebx
    2a21:	74 3d                	je     2a60 <concreate+0x210>
    file[1] = '0' + i;
    2a23:	8d 43 30             	lea    0x30(%ebx),%eax
    2a26:	88 45 e6             	mov    %al,-0x1a(%ebp)
    pid = fork();
    2a29:	e8 02 08 00 00       	call   3230 <fork>
    if(pid < 0){
    2a2e:	85 c0                	test   %eax,%eax
    exit();
  }

  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    pid = fork();
    2a30:	89 c6                	mov    %eax,%esi
    if(pid < 0){
    2a32:	78 48                	js     2a7c <concreate+0x22c>
      printf(1, "fork failed\n");
      exit();
    }
    if(((i % 3) == 0 && pid == 0) ||
    2a34:	b8 56 55 55 55       	mov    $0x55555556,%eax
    2a39:	f7 eb                	imul   %ebx
    2a3b:	89 d8                	mov    %ebx,%eax
    2a3d:	c1 f8 1f             	sar    $0x1f,%eax
    2a40:	29 c2                	sub    %eax,%edx
    2a42:	89 d8                	mov    %ebx,%eax
    2a44:	8d 14 52             	lea    (%edx,%edx,2),%edx
    2a47:	29 d0                	sub    %edx,%eax
    2a49:	75 9d                	jne    29e8 <concreate+0x198>
    2a4b:	85 f6                	test   %esi,%esi
    2a4d:	74 a7                	je     29f6 <concreate+0x1a6>
       ((i % 3) == 1 && pid != 0)){
      fd = open(file, 0);
      close(fd);
    } else {
      unlink(file);
    2a4f:	89 3c 24             	mov    %edi,(%esp)
    2a52:	e8 31 08 00 00       	call   3288 <unlink>
    2a57:	eb b5                	jmp    2a0e <concreate+0x1be>
    2a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      exit();
    else
      wait();
  }

  printf(1, "concreate ok\n");
    2a60:	c7 44 24 04 08 44 00 	movl   $0x4408,0x4(%esp)
    2a67:	00 
    2a68:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a6f:	e8 1c 09 00 00       	call   3390 <printf>
}
    2a74:	83 c4 6c             	add    $0x6c,%esp
    2a77:	5b                   	pop    %ebx
    2a78:	5e                   	pop    %esi
    2a79:	5f                   	pop    %edi
    2a7a:	5d                   	pop    %ebp
    2a7b:	c3                   	ret    

  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
    2a7c:	c7 44 24 04 5b 38 00 	movl   $0x385b,0x4(%esp)
    2a83:	00 
    2a84:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a8b:	e8 00 09 00 00       	call   3390 <printf>
      exit();
    2a90:	e8 a3 07 00 00       	call   3238 <exit>
    } else if(pid == 0 && (i % 5) == 1){
      link("C0", file);
    } else {
      fd = open(file, O_CREATE | O_RDWR);
      if(fd < 0){
        printf(1, "concreate create %s failed\n", file);
    2a95:	89 7c 24 08          	mov    %edi,0x8(%esp)
    2a99:	c7 44 24 04 b6 43 00 	movl   $0x43b6,0x4(%esp)
    2aa0:	00 
    2aa1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2aa8:	e8 e3 08 00 00       	call   3390 <printf>
        exit();
    2aad:	e8 86 07 00 00       	call   3238 <exit>
    if(de.inum == 0)
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
      i = de.name[1] - '0';
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
    2ab2:	8d 45 d6             	lea    -0x2a(%ebp),%eax
    2ab5:	89 44 24 08          	mov    %eax,0x8(%esp)
    2ab9:	c7 44 24 04 d2 43 00 	movl   $0x43d2,0x4(%esp)
    2ac0:	00 
    2ac1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ac8:	e8 c3 08 00 00       	call   3390 <printf>
    2acd:	e9 3e fe ff ff       	jmp    2910 <concreate+0xc0>
    }
  }
  close(fd);

  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    2ad2:	c7 44 24 04 a4 4a 00 	movl   $0x4aa4,0x4(%esp)
    2ad9:	00 
    2ada:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ae1:	e8 aa 08 00 00       	call   3390 <printf>
    exit();
    2ae6:	e8 4d 07 00 00       	call   3238 <exit>
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
        exit();
      }
      if(fa[i]){
        printf(1, "concreate duplicate file %s\n", de.name);
    2aeb:	8d 45 d6             	lea    -0x2a(%ebp),%eax
    2aee:	89 44 24 08          	mov    %eax,0x8(%esp)
    2af2:	c7 44 24 04 eb 43 00 	movl   $0x43eb,0x4(%esp)
    2af9:	00 
    2afa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2b01:	e8 8a 08 00 00       	call   3390 <printf>
        exit();
    2b06:	e8 2d 07 00 00       	call   3238 <exit>
    2b0b:	90                   	nop
    2b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00002b10 <twofiles>:

// two processes write two different files at the same
// time, to test block allocation.
void
twofiles(void)
{
    2b10:	55                   	push   %ebp
    2b11:	89 e5                	mov    %esp,%ebp
    2b13:	57                   	push   %edi
    2b14:	56                   	push   %esi
    2b15:	53                   	push   %ebx
    2b16:	83 ec 2c             	sub    $0x2c,%esp
  int fd, pid, i, j, n, total;
  char *fname;

  printf(1, "twofiles test\n");
    2b19:	c7 44 24 04 16 44 00 	movl   $0x4416,0x4(%esp)
    2b20:	00 
    2b21:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2b28:	e8 63 08 00 00       	call   3390 <printf>

  unlink("f1");
    2b2d:	c7 04 24 5d 3f 00 00 	movl   $0x3f5d,(%esp)
    2b34:	e8 4f 07 00 00       	call   3288 <unlink>
  unlink("f2");
    2b39:	c7 04 24 61 3f 00 00 	movl   $0x3f61,(%esp)
    2b40:	e8 43 07 00 00       	call   3288 <unlink>

  pid = fork();
    2b45:	e8 e6 06 00 00       	call   3230 <fork>
  if(pid < 0){
    2b4a:	83 f8 00             	cmp    $0x0,%eax
  printf(1, "twofiles test\n");

  unlink("f1");
  unlink("f2");

  pid = fork();
    2b4d:	89 c7                	mov    %eax,%edi
  if(pid < 0){
    2b4f:	0f 8c 64 01 00 00    	jl     2cb9 <twofiles+0x1a9>
    printf(1, "fork failed\n");
    return;
  }

  fname = pid ? "f1" : "f2";
    2b55:	b8 5d 3f 00 00       	mov    $0x3f5d,%eax
    2b5a:	75 05                	jne    2b61 <twofiles+0x51>
    2b5c:	b8 61 3f 00 00       	mov    $0x3f61,%eax
  fd = open(fname, O_CREATE | O_RDWR);
    2b61:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    2b68:	00 
    2b69:	89 04 24             	mov    %eax,(%esp)
    2b6c:	e8 07 07 00 00       	call   3278 <open>
  if(fd < 0){
    2b71:	85 c0                	test   %eax,%eax
    printf(1, "fork failed\n");
    return;
  }

  fname = pid ? "f1" : "f2";
  fd = open(fname, O_CREATE | O_RDWR);
    2b73:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    2b75:	0f 88 8e 01 00 00    	js     2d09 <twofiles+0x1f9>
    printf(1, "create failed\n");
    exit();
  }

  memset(buf, pid?'p':'c', 512);
    2b7b:	83 ff 01             	cmp    $0x1,%edi
    2b7e:	19 c0                	sbb    %eax,%eax
    2b80:	31 db                	xor    %ebx,%ebx
    2b82:	83 e0 f3             	and    $0xfffffff3,%eax
    2b85:	83 c0 70             	add    $0x70,%eax
    2b88:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    2b8f:	00 
    2b90:	89 44 24 04          	mov    %eax,0x4(%esp)
    2b94:	c7 04 24 a0 4b 00 00 	movl   $0x4ba0,(%esp)
    2b9b:	e8 10 05 00 00       	call   30b0 <memset>
  for(i = 0; i < 12; i++){
    if((n = write(fd, buf, 500)) != 500){
    2ba0:	c7 44 24 08 f4 01 00 	movl   $0x1f4,0x8(%esp)
    2ba7:	00 
    2ba8:	c7 44 24 04 a0 4b 00 	movl   $0x4ba0,0x4(%esp)
    2baf:	00 
    2bb0:	89 34 24             	mov    %esi,(%esp)
    2bb3:	e8 a0 06 00 00       	call   3258 <write>
    2bb8:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    2bbd:	0f 85 29 01 00 00    	jne    2cec <twofiles+0x1dc>
    printf(1, "create failed\n");
    exit();
  }

  memset(buf, pid?'p':'c', 512);
  for(i = 0; i < 12; i++){
    2bc3:	83 c3 01             	add    $0x1,%ebx
    2bc6:	83 fb 0c             	cmp    $0xc,%ebx
    2bc9:	75 d5                	jne    2ba0 <twofiles+0x90>
    if((n = write(fd, buf, 500)) != 500){
      printf(1, "write failed %d\n", n);
      exit();
    }
  }
  close(fd);
    2bcb:	89 34 24             	mov    %esi,(%esp)
    2bce:	e8 8d 06 00 00       	call   3260 <close>
  if(pid)
    2bd3:	85 ff                	test   %edi,%edi
    2bd5:	0f 84 d9 00 00 00    	je     2cb4 <twofiles+0x1a4>
    wait();
    2bdb:	e8 60 06 00 00       	call   3240 <wait>
    2be0:	30 db                	xor    %bl,%bl
    2be2:	b8 61 3f 00 00       	mov    $0x3f61,%eax
  else
    exit();

  for(i = 0; i < 2; i++){
    fd = open(i?"f1":"f2", 0);
    2be7:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2bee:	00 
    2bef:	31 f6                	xor    %esi,%esi
    2bf1:	89 04 24             	mov    %eax,(%esp)
    2bf4:	e8 7f 06 00 00       	call   3278 <open>
    2bf9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    2bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
    2c00:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2c03:	c7 44 24 08 00 08 00 	movl   $0x800,0x8(%esp)
    2c0a:	00 
    2c0b:	c7 44 24 04 a0 4b 00 	movl   $0x4ba0,0x4(%esp)
    2c12:	00 
    2c13:	89 04 24             	mov    %eax,(%esp)
    2c16:	e8 35 06 00 00       	call   3250 <read>
    2c1b:	85 c0                	test   %eax,%eax
    2c1d:	7e 2a                	jle    2c49 <twofiles+0x139>
    2c1f:	31 c9                	xor    %ecx,%ecx
    2c21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      for(j = 0; j < n; j++){
        if(buf[j] != (i?'p':'c')){
    2c28:	83 fb 01             	cmp    $0x1,%ebx
    2c2b:	0f be b9 a0 4b 00 00 	movsbl 0x4ba0(%ecx),%edi
    2c32:	19 d2                	sbb    %edx,%edx
    2c34:	83 e2 f3             	and    $0xfffffff3,%edx
    2c37:	83 c2 70             	add    $0x70,%edx
    2c3a:	39 d7                	cmp    %edx,%edi
    2c3c:	75 62                	jne    2ca0 <twofiles+0x190>

  for(i = 0; i < 2; i++){
    fd = open(i?"f1":"f2", 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
    2c3e:	83 c1 01             	add    $0x1,%ecx
    2c41:	39 c8                	cmp    %ecx,%eax
    2c43:	7f e3                	jg     2c28 <twofiles+0x118>
        if(buf[j] != (i?'p':'c')){
          printf(1, "wrong char\n");
          exit();
        }
      }
      total += n;
    2c45:	01 c6                	add    %eax,%esi
    2c47:	eb b7                	jmp    2c00 <twofiles+0xf0>
    }
    close(fd);
    2c49:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2c4c:	89 04 24             	mov    %eax,(%esp)
    2c4f:	e8 0c 06 00 00       	call   3260 <close>
    if(total != 12*500){
    2c54:	81 fe 70 17 00 00    	cmp    $0x1770,%esi
    2c5a:	75 73                	jne    2ccf <twofiles+0x1bf>
  if(pid)
    wait();
  else
    exit();

  for(i = 0; i < 2; i++){
    2c5c:	83 fb 01             	cmp    $0x1,%ebx
      total += n;
    }
    close(fd);
    if(total != 12*500){
      printf(1, "wrong length %d\n", total);
      exit();
    2c5f:	b8 5d 3f 00 00       	mov    $0x3f5d,%eax
  if(pid)
    wait();
  else
    exit();

  for(i = 0; i < 2; i++){
    2c64:	75 30                	jne    2c96 <twofiles+0x186>
      printf(1, "wrong length %d\n", total);
      exit();
    }
  }

  unlink("f1");
    2c66:	89 04 24             	mov    %eax,(%esp)
    2c69:	e8 1a 06 00 00       	call   3288 <unlink>
  unlink("f2");
    2c6e:	c7 04 24 61 3f 00 00 	movl   $0x3f61,(%esp)
    2c75:	e8 0e 06 00 00       	call   3288 <unlink>

  printf(1, "twofiles ok\n");
    2c7a:	c7 44 24 04 53 44 00 	movl   $0x4453,0x4(%esp)
    2c81:	00 
    2c82:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c89:	e8 02 07 00 00       	call   3390 <printf>
}
    2c8e:	83 c4 2c             	add    $0x2c,%esp
    2c91:	5b                   	pop    %ebx
    2c92:	5e                   	pop    %esi
    2c93:	5f                   	pop    %edi
    2c94:	5d                   	pop    %ebp
    2c95:	c3                   	ret    
  }
  close(fd);
  if(pid)
    wait();
  else
    exit();
    2c96:	bb 01 00 00 00       	mov    $0x1,%ebx
    2c9b:	e9 47 ff ff ff       	jmp    2be7 <twofiles+0xd7>
    fd = open(i?"f1":"f2", 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
        if(buf[j] != (i?'p':'c')){
          printf(1, "wrong char\n");
    2ca0:	c7 44 24 04 36 44 00 	movl   $0x4436,0x4(%esp)
    2ca7:	00 
    2ca8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2caf:	e8 dc 06 00 00       	call   3390 <printf>
          exit();
    2cb4:	e8 7f 05 00 00       	call   3238 <exit>
  unlink("f1");
  unlink("f2");

  pid = fork();
  if(pid < 0){
    printf(1, "fork failed\n");
    2cb9:	c7 44 24 04 5b 38 00 	movl   $0x385b,0x4(%esp)
    2cc0:	00 
    2cc1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2cc8:	e8 c3 06 00 00       	call   3390 <printf>
    return;
    2ccd:	eb bf                	jmp    2c8e <twofiles+0x17e>
      }
      total += n;
    }
    close(fd);
    if(total != 12*500){
      printf(1, "wrong length %d\n", total);
    2ccf:	89 74 24 08          	mov    %esi,0x8(%esp)
    2cd3:	c7 44 24 04 42 44 00 	movl   $0x4442,0x4(%esp)
    2cda:	00 
    2cdb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ce2:	e8 a9 06 00 00       	call   3390 <printf>
      exit();
    2ce7:	e8 4c 05 00 00       	call   3238 <exit>
  }

  memset(buf, pid?'p':'c', 512);
  for(i = 0; i < 12; i++){
    if((n = write(fd, buf, 500)) != 500){
      printf(1, "write failed %d\n", n);
    2cec:	89 44 24 08          	mov    %eax,0x8(%esp)
    2cf0:	c7 44 24 04 25 44 00 	movl   $0x4425,0x4(%esp)
    2cf7:	00 
    2cf8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2cff:	e8 8c 06 00 00       	call   3390 <printf>
      exit();
    2d04:	e8 2f 05 00 00       	call   3238 <exit>
  }

  fname = pid ? "f1" : "f2";
  fd = open(fname, O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create failed\n");
    2d09:	c7 44 24 04 0f 3f 00 	movl   $0x3f0f,0x4(%esp)
    2d10:	00 
    2d11:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2d18:	e8 73 06 00 00       	call   3390 <printf>
    exit();
    2d1d:	e8 16 05 00 00       	call   3238 <exit>
    2d22:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002d30 <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
{
    2d30:	55                   	push   %ebp
    2d31:	89 e5                	mov    %esp,%ebp
    2d33:	57                   	push   %edi
    2d34:	56                   	push   %esi
    2d35:	53                   	push   %ebx
    2d36:	83 ec 3c             	sub    $0x3c,%esp
  int fd, pid, i, n, nc, np;
  char buf[10];

  unlink("sharedfd");
    2d39:	c7 04 24 60 44 00 00 	movl   $0x4460,(%esp)
    2d40:	e8 43 05 00 00       	call   3288 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    2d45:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    2d4c:	00 
    2d4d:	c7 04 24 60 44 00 00 	movl   $0x4460,(%esp)
    2d54:	e8 1f 05 00 00       	call   3278 <open>
  if(fd < 0){
    2d59:	85 c0                	test   %eax,%eax
{
  int fd, pid, i, n, nc, np;
  char buf[10];

  unlink("sharedfd");
  fd = open("sharedfd", O_CREATE|O_RDWR);
    2d5b:	89 c7                	mov    %eax,%edi
  if(fd < 0){
    2d5d:	0f 88 55 01 00 00    	js     2eb8 <sharedfd+0x188>
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
    2d63:	e8 c8 04 00 00       	call   3230 <fork>
  memset(buf, pid==0?'c':'p', sizeof(buf));
    2d68:	8d 75 de             	lea    -0x22(%ebp),%esi
    2d6b:	83 f8 01             	cmp    $0x1,%eax
  fd = open("sharedfd", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
    2d6e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
    2d71:	19 c0                	sbb    %eax,%eax
    2d73:	31 db                	xor    %ebx,%ebx
    2d75:	83 e0 f3             	and    $0xfffffff3,%eax
    2d78:	83 c0 70             	add    $0x70,%eax
    2d7b:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    2d82:	00 
    2d83:	89 44 24 04          	mov    %eax,0x4(%esp)
    2d87:	89 34 24             	mov    %esi,(%esp)
    2d8a:	e8 21 03 00 00       	call   30b0 <memset>
    2d8f:	eb 12                	jmp    2da3 <sharedfd+0x73>
    2d91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 1000; i++){
    2d98:	83 c3 01             	add    $0x1,%ebx
    2d9b:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    2da1:	74 2d                	je     2dd0 <sharedfd+0xa0>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    2da3:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    2daa:	00 
    2dab:	89 74 24 04          	mov    %esi,0x4(%esp)
    2daf:	89 3c 24             	mov    %edi,(%esp)
    2db2:	e8 a1 04 00 00       	call   3258 <write>
    2db7:	83 f8 0a             	cmp    $0xa,%eax
    2dba:	74 dc                	je     2d98 <sharedfd+0x68>
      printf(1, "fstests: write sharedfd failed\n");
    2dbc:	c7 44 24 04 04 4b 00 	movl   $0x4b04,0x4(%esp)
    2dc3:	00 
    2dc4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2dcb:	e8 c0 05 00 00       	call   3390 <printf>
      break;
    }
  }
  if(pid == 0)
    2dd0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    2dd3:	85 d2                	test   %edx,%edx
    2dd5:	0f 84 0f 01 00 00    	je     2eea <sharedfd+0x1ba>
    exit();
  else
    wait();
    2ddb:	e8 60 04 00 00       	call   3240 <wait>
  close(fd);
  fd = open("sharedfd", 0);
  if(fd < 0){
    2de0:	31 db                	xor    %ebx,%ebx
  }
  if(pid == 0)
    exit();
  else
    wait();
  close(fd);
    2de2:	89 3c 24             	mov    %edi,(%esp)
  fd = open("sharedfd", 0);
  if(fd < 0){
    2de5:	31 ff                	xor    %edi,%edi
  }
  if(pid == 0)
    exit();
  else
    wait();
  close(fd);
    2de7:	e8 74 04 00 00       	call   3260 <close>
  fd = open("sharedfd", 0);
    2dec:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2df3:	00 
    2df4:	c7 04 24 60 44 00 00 	movl   $0x4460,(%esp)
    2dfb:	e8 78 04 00 00       	call   3278 <open>
  if(fd < 0){
    2e00:	85 c0                	test   %eax,%eax
  if(pid == 0)
    exit();
  else
    wait();
  close(fd);
  fd = open("sharedfd", 0);
    2e02:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  if(fd < 0){
    2e05:	0f 88 c9 00 00 00    	js     2ed4 <sharedfd+0x1a4>
    2e0b:	90                   	nop
    2e0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    2e10:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    2e17:	00 
    2e18:	89 74 24 04          	mov    %esi,0x4(%esp)
    2e1c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    2e1f:	89 04 24             	mov    %eax,(%esp)
    2e22:	e8 29 04 00 00       	call   3250 <read>
    2e27:	85 c0                	test   %eax,%eax
    2e29:	7e 26                	jle    2e51 <sharedfd+0x121>
    wait();
  close(fd);
  fd = open("sharedfd", 0);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
    2e2b:	31 c0                	xor    %eax,%eax
    2e2d:	eb 14                	jmp    2e43 <sharedfd+0x113>
    2e2f:	90                   	nop
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i = 0; i < sizeof(buf); i++){
      if(buf[i] == 'c')
        nc++;
      if(buf[i] == 'p')
        np++;
    2e30:	80 fa 70             	cmp    $0x70,%dl
    2e33:	0f 94 c2             	sete   %dl
    2e36:	0f b6 d2             	movzbl %dl,%edx
    2e39:	01 d3                	add    %edx,%ebx
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i = 0; i < sizeof(buf); i++){
    2e3b:	83 c0 01             	add    $0x1,%eax
    2e3e:	83 f8 0a             	cmp    $0xa,%eax
    2e41:	74 cd                	je     2e10 <sharedfd+0xe0>
      if(buf[i] == 'c')
    2e43:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
    2e47:	80 fa 63             	cmp    $0x63,%dl
    2e4a:	75 e4                	jne    2e30 <sharedfd+0x100>
        nc++;
    2e4c:	83 c7 01             	add    $0x1,%edi
    2e4f:	eb ea                	jmp    2e3b <sharedfd+0x10b>
      if(buf[i] == 'p')
        np++;
    }
  }
  close(fd);
    2e51:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    2e54:	89 04 24             	mov    %eax,(%esp)
    2e57:	e8 04 04 00 00       	call   3260 <close>
  unlink("sharedfd");
    2e5c:	c7 04 24 60 44 00 00 	movl   $0x4460,(%esp)
    2e63:	e8 20 04 00 00       	call   3288 <unlink>
  if(nc == 10000 && np == 10000)
    2e68:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
    2e6e:	74 24                	je     2e94 <sharedfd+0x164>
    printf(1, "sharedfd ok\n");
  else
    printf(1, "sharedfd oops %d %d\n", nc, np);
    2e70:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
    2e74:	89 7c 24 08          	mov    %edi,0x8(%esp)
    2e78:	c7 44 24 04 76 44 00 	movl   $0x4476,0x4(%esp)
    2e7f:	00 
    2e80:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e87:	e8 04 05 00 00       	call   3390 <printf>
}
    2e8c:	83 c4 3c             	add    $0x3c,%esp
    2e8f:	5b                   	pop    %ebx
    2e90:	5e                   	pop    %esi
    2e91:	5f                   	pop    %edi
    2e92:	5d                   	pop    %ebp
    2e93:	c3                   	ret    
        np++;
    }
  }
  close(fd);
  unlink("sharedfd");
  if(nc == 10000 && np == 10000)
    2e94:	81 ff 10 27 00 00    	cmp    $0x2710,%edi
    2e9a:	75 d4                	jne    2e70 <sharedfd+0x140>
    printf(1, "sharedfd ok\n");
    2e9c:	c7 44 24 04 69 44 00 	movl   $0x4469,0x4(%esp)
    2ea3:	00 
    2ea4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2eab:	e8 e0 04 00 00       	call   3390 <printf>
  else
    printf(1, "sharedfd oops %d %d\n", nc, np);
}
    2eb0:	83 c4 3c             	add    $0x3c,%esp
    2eb3:	5b                   	pop    %ebx
    2eb4:	5e                   	pop    %esi
    2eb5:	5f                   	pop    %edi
    2eb6:	5d                   	pop    %ebp
    2eb7:	c3                   	ret    
  char buf[10];

  unlink("sharedfd");
  fd = open("sharedfd", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for writing");
    2eb8:	c7 44 24 04 d8 4a 00 	movl   $0x4ad8,0x4(%esp)
    2ebf:	00 
    2ec0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ec7:	e8 c4 04 00 00       	call   3390 <printf>
  unlink("sharedfd");
  if(nc == 10000 && np == 10000)
    printf(1, "sharedfd ok\n");
  else
    printf(1, "sharedfd oops %d %d\n", nc, np);
}
    2ecc:	83 c4 3c             	add    $0x3c,%esp
    2ecf:	5b                   	pop    %ebx
    2ed0:	5e                   	pop    %esi
    2ed1:	5f                   	pop    %edi
    2ed2:	5d                   	pop    %ebp
    2ed3:	c3                   	ret    
  else
    wait();
  close(fd);
  fd = open("sharedfd", 0);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for reading\n");
    2ed4:	c7 44 24 04 24 4b 00 	movl   $0x4b24,0x4(%esp)
    2edb:	00 
    2edc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ee3:	e8 a8 04 00 00       	call   3390 <printf>
    return;
    2ee8:	eb a2                	jmp    2e8c <sharedfd+0x15c>
      printf(1, "fstests: write sharedfd failed\n");
      break;
    }
  }
  if(pid == 0)
    exit();
    2eea:	e8 49 03 00 00       	call   3238 <exit>
    2eef:	90                   	nop

00002ef0 <mem>:
  printf(1, "exitwait ok\n");
}

void
mem(void)
{
    2ef0:	55                   	push   %ebp
    2ef1:	89 e5                	mov    %esp,%ebp
    2ef3:	57                   	push   %edi
    2ef4:	56                   	push   %esi
    2ef5:	53                   	push   %ebx
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
  ppid = getpid();
  if((pid = fork()) == 0){
    2ef6:	31 db                	xor    %ebx,%ebx
  printf(1, "exitwait ok\n");
}

void
mem(void)
{
    2ef8:	83 ec 1c             	sub    $0x1c,%esp
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
    2efb:	c7 44 24 04 8b 44 00 	movl   $0x448b,0x4(%esp)
    2f02:	00 
    2f03:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2f0a:	e8 81 04 00 00       	call   3390 <printf>
  ppid = getpid();
    2f0f:	e8 a4 03 00 00       	call   32b8 <getpid>
    2f14:	89 c6                	mov    %eax,%esi
  if((pid = fork()) == 0){
    2f16:	e8 15 03 00 00       	call   3230 <fork>
    2f1b:	85 c0                	test   %eax,%eax
    2f1d:	74 0d                	je     2f2c <mem+0x3c>
    2f1f:	90                   	nop
    2f20:	eb 5f                	jmp    2f81 <mem+0x91>
    2f22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    m1 = 0;
    while((m2 = malloc(10001)) != 0) {
      *(char**) m2 = m1;
    2f28:	89 18                	mov    %ebx,(%eax)
    2f2a:	89 c3                	mov    %eax,%ebx

  printf(1, "mem test\n");
  ppid = getpid();
  if((pid = fork()) == 0){
    m1 = 0;
    while((m2 = malloc(10001)) != 0) {
    2f2c:	c7 04 24 11 27 00 00 	movl   $0x2711,(%esp)
    2f33:	e8 f8 06 00 00       	call   3630 <malloc>
    2f38:	85 c0                	test   %eax,%eax
    2f3a:	75 ec                	jne    2f28 <mem+0x38>
      *(char**) m2 = m1;
      m1 = m2;
    }
    while(m1) {
    2f3c:	85 db                	test   %ebx,%ebx
    2f3e:	74 10                	je     2f50 <mem+0x60>
      m2 = *(char**)m1;
    2f40:	8b 3b                	mov    (%ebx),%edi
      free(m1);
    2f42:	89 1c 24             	mov    %ebx,(%esp)
    2f45:	e8 56 06 00 00       	call   35a0 <free>
    2f4a:	89 fb                	mov    %edi,%ebx
    m1 = 0;
    while((m2 = malloc(10001)) != 0) {
      *(char**) m2 = m1;
      m1 = m2;
    }
    while(m1) {
    2f4c:	85 db                	test   %ebx,%ebx
    2f4e:	75 f0                	jne    2f40 <mem+0x50>
      m2 = *(char**)m1;
      free(m1);
      m1 = m2;
    }
    m1 = malloc(1024*20);
    2f50:	c7 04 24 00 50 00 00 	movl   $0x5000,(%esp)
    2f57:	e8 d4 06 00 00       	call   3630 <malloc>
    if(m1 == 0) {
    2f5c:	85 c0                	test   %eax,%eax
    2f5e:	74 30                	je     2f90 <mem+0xa0>
      printf(1, "couldn't allocate mem?!!\n");
      kill(ppid);
      exit();
    }
    free(m1);
    2f60:	89 04 24             	mov    %eax,(%esp)
    2f63:	e8 38 06 00 00       	call   35a0 <free>
    printf(1, "mem ok\n");
    2f68:	c7 44 24 04 af 44 00 	movl   $0x44af,0x4(%esp)
    2f6f:	00 
    2f70:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2f77:	e8 14 04 00 00       	call   3390 <printf>
    exit();
    2f7c:	e8 b7 02 00 00       	call   3238 <exit>
  } else {
    wait();
  }
}
    2f81:	83 c4 1c             	add    $0x1c,%esp
    2f84:	5b                   	pop    %ebx
    2f85:	5e                   	pop    %esi
    2f86:	5f                   	pop    %edi
    2f87:	5d                   	pop    %ebp
    }
    free(m1);
    printf(1, "mem ok\n");
    exit();
  } else {
    wait();
    2f88:	e9 b3 02 00 00       	jmp    3240 <wait>
    2f8d:	8d 76 00             	lea    0x0(%esi),%esi
      free(m1);
      m1 = m2;
    }
    m1 = malloc(1024*20);
    if(m1 == 0) {
      printf(1, "couldn't allocate mem?!!\n");
    2f90:	c7 44 24 04 95 44 00 	movl   $0x4495,0x4(%esp)
    2f97:	00 
    2f98:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2f9f:	e8 ec 03 00 00       	call   3390 <printf>
      kill(ppid);
    2fa4:	89 34 24             	mov    %esi,(%esp)
    2fa7:	e8 bc 02 00 00       	call   3268 <kill>
      exit();
    2fac:	e8 87 02 00 00       	call   3238 <exit>
    2fb1:	eb 0d                	jmp    2fc0 <exectest>
    2fb3:	90                   	nop
    2fb4:	90                   	nop
    2fb5:	90                   	nop
    2fb6:	90                   	nop
    2fb7:	90                   	nop
    2fb8:	90                   	nop
    2fb9:	90                   	nop
    2fba:	90                   	nop
    2fbb:	90                   	nop
    2fbc:	90                   	nop
    2fbd:	90                   	nop
    2fbe:	90                   	nop
    2fbf:	90                   	nop

00002fc0 <exectest>:
  printf(stdout, "mkdir test\n");
}

void
exectest(void)
{
    2fc0:	55                   	push   %ebp
    2fc1:	89 e5                	mov    %esp,%ebp
    2fc3:	83 ec 18             	sub    $0x18,%esp
  printf(stdout, "exec test\n");
    2fc6:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
    2fcb:	c7 44 24 04 b7 44 00 	movl   $0x44b7,0x4(%esp)
    2fd2:	00 
    2fd3:	89 04 24             	mov    %eax,(%esp)
    2fd6:	e8 b5 03 00 00       	call   3390 <printf>
  if(exec("echo", echoargv) < 0) {
    2fdb:	c7 44 24 04 68 4b 00 	movl   $0x4b68,0x4(%esp)
    2fe2:	00 
    2fe3:	c7 04 24 3d 37 00 00 	movl   $0x373d,(%esp)
    2fea:	e8 81 02 00 00       	call   3270 <exec>
    2fef:	85 c0                	test   %eax,%eax
    2ff1:	78 02                	js     2ff5 <exectest+0x35>
    printf(stdout, "exec echo failed\n");
    exit();
  }
}
    2ff3:	c9                   	leave  
    2ff4:	c3                   	ret    
void
exectest(void)
{
  printf(stdout, "exec test\n");
  if(exec("echo", echoargv) < 0) {
    printf(stdout, "exec echo failed\n");
    2ff5:	a1 7c 4b 00 00       	mov    0x4b7c,%eax
    2ffa:	c7 44 24 04 c2 44 00 	movl   $0x44c2,0x4(%esp)
    3001:	00 
    3002:	89 04 24             	mov    %eax,(%esp)
    3005:	e8 86 03 00 00       	call   3390 <printf>
    exit();
    300a:	e8 29 02 00 00       	call   3238 <exit>
    300f:	90                   	nop

00003010 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    3010:	55                   	push   %ebp
    3011:	31 d2                	xor    %edx,%edx
    3013:	89 e5                	mov    %esp,%ebp
    3015:	8b 45 08             	mov    0x8(%ebp),%eax
    3018:	53                   	push   %ebx
    3019:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    301c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3020:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
    3024:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    3027:	83 c2 01             	add    $0x1,%edx
    302a:	84 c9                	test   %cl,%cl
    302c:	75 f2                	jne    3020 <strcpy+0x10>
    ;
  return os;
}
    302e:	5b                   	pop    %ebx
    302f:	5d                   	pop    %ebp
    3030:	c3                   	ret    
    3031:	eb 0d                	jmp    3040 <strcmp>
    3033:	90                   	nop
    3034:	90                   	nop
    3035:	90                   	nop
    3036:	90                   	nop
    3037:	90                   	nop
    3038:	90                   	nop
    3039:	90                   	nop
    303a:	90                   	nop
    303b:	90                   	nop
    303c:	90                   	nop
    303d:	90                   	nop
    303e:	90                   	nop
    303f:	90                   	nop

00003040 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3040:	55                   	push   %ebp
    3041:	89 e5                	mov    %esp,%ebp
    3043:	53                   	push   %ebx
    3044:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3047:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    304a:	0f b6 01             	movzbl (%ecx),%eax
    304d:	84 c0                	test   %al,%al
    304f:	75 14                	jne    3065 <strcmp+0x25>
    3051:	eb 25                	jmp    3078 <strcmp+0x38>
    3053:	90                   	nop
    3054:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
    3058:	83 c1 01             	add    $0x1,%ecx
    305b:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    305e:	0f b6 01             	movzbl (%ecx),%eax
    3061:	84 c0                	test   %al,%al
    3063:	74 13                	je     3078 <strcmp+0x38>
    3065:	0f b6 1a             	movzbl (%edx),%ebx
    3068:	38 d8                	cmp    %bl,%al
    306a:	74 ec                	je     3058 <strcmp+0x18>
    306c:	0f b6 db             	movzbl %bl,%ebx
    306f:	0f b6 c0             	movzbl %al,%eax
    3072:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    3074:	5b                   	pop    %ebx
    3075:	5d                   	pop    %ebp
    3076:	c3                   	ret    
    3077:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    3078:	0f b6 1a             	movzbl (%edx),%ebx
    307b:	31 c0                	xor    %eax,%eax
    307d:	0f b6 db             	movzbl %bl,%ebx
    3080:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    3082:	5b                   	pop    %ebx
    3083:	5d                   	pop    %ebp
    3084:	c3                   	ret    
    3085:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3089:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003090 <strlen>:

uint
strlen(char *s)
{
    3090:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
    3091:	31 d2                	xor    %edx,%edx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    3093:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
    3095:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    3097:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    309a:	80 39 00             	cmpb   $0x0,(%ecx)
    309d:	74 0c                	je     30ab <strlen+0x1b>
    309f:	90                   	nop
    30a0:	83 c2 01             	add    $0x1,%edx
    30a3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    30a7:	89 d0                	mov    %edx,%eax
    30a9:	75 f5                	jne    30a0 <strlen+0x10>
    ;
  return n;
}
    30ab:	5d                   	pop    %ebp
    30ac:	c3                   	ret    
    30ad:	8d 76 00             	lea    0x0(%esi),%esi

000030b0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    30b0:	55                   	push   %ebp
    30b1:	89 e5                	mov    %esp,%ebp
    30b3:	8b 55 08             	mov    0x8(%ebp),%edx
    30b6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    30b7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    30ba:	8b 45 0c             	mov    0xc(%ebp),%eax
    30bd:	89 d7                	mov    %edx,%edi
    30bf:	fc                   	cld    
    30c0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    30c2:	89 d0                	mov    %edx,%eax
    30c4:	5f                   	pop    %edi
    30c5:	5d                   	pop    %ebp
    30c6:	c3                   	ret    
    30c7:	89 f6                	mov    %esi,%esi
    30c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000030d0 <strchr>:

char*
strchr(const char *s, char c)
{
    30d0:	55                   	push   %ebp
    30d1:	89 e5                	mov    %esp,%ebp
    30d3:	8b 45 08             	mov    0x8(%ebp),%eax
    30d6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    30da:	0f b6 10             	movzbl (%eax),%edx
    30dd:	84 d2                	test   %dl,%dl
    30df:	75 11                	jne    30f2 <strchr+0x22>
    30e1:	eb 15                	jmp    30f8 <strchr+0x28>
    30e3:	90                   	nop
    30e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    30e8:	83 c0 01             	add    $0x1,%eax
    30eb:	0f b6 10             	movzbl (%eax),%edx
    30ee:	84 d2                	test   %dl,%dl
    30f0:	74 06                	je     30f8 <strchr+0x28>
    if(*s == c)
    30f2:	38 ca                	cmp    %cl,%dl
    30f4:	75 f2                	jne    30e8 <strchr+0x18>
      return (char*) s;
  return 0;
}
    30f6:	5d                   	pop    %ebp
    30f7:	c3                   	ret    
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    30f8:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
    30fa:	5d                   	pop    %ebp
    30fb:	90                   	nop
    30fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3100:	c3                   	ret    
    3101:	eb 0d                	jmp    3110 <atoi>
    3103:	90                   	nop
    3104:	90                   	nop
    3105:	90                   	nop
    3106:	90                   	nop
    3107:	90                   	nop
    3108:	90                   	nop
    3109:	90                   	nop
    310a:	90                   	nop
    310b:	90                   	nop
    310c:	90                   	nop
    310d:	90                   	nop
    310e:	90                   	nop
    310f:	90                   	nop

00003110 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    3110:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3111:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
    3113:	89 e5                	mov    %esp,%ebp
    3115:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3118:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3119:	0f b6 11             	movzbl (%ecx),%edx
    311c:	8d 5a d0             	lea    -0x30(%edx),%ebx
    311f:	80 fb 09             	cmp    $0x9,%bl
    3122:	77 1c                	ja     3140 <atoi+0x30>
    3124:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
    3128:	0f be d2             	movsbl %dl,%edx
    312b:	83 c1 01             	add    $0x1,%ecx
    312e:	8d 04 80             	lea    (%eax,%eax,4),%eax
    3131:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3135:	0f b6 11             	movzbl (%ecx),%edx
    3138:	8d 5a d0             	lea    -0x30(%edx),%ebx
    313b:	80 fb 09             	cmp    $0x9,%bl
    313e:	76 e8                	jbe    3128 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
    3140:	5b                   	pop    %ebx
    3141:	5d                   	pop    %ebp
    3142:	c3                   	ret    
    3143:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003150 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    3150:	55                   	push   %ebp
    3151:	89 e5                	mov    %esp,%ebp
    3153:	56                   	push   %esi
    3154:	8b 45 08             	mov    0x8(%ebp),%eax
    3157:	53                   	push   %ebx
    3158:	8b 5d 10             	mov    0x10(%ebp),%ebx
    315b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    315e:	85 db                	test   %ebx,%ebx
    3160:	7e 14                	jle    3176 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
    3162:	31 d2                	xor    %edx,%edx
    3164:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
    3168:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    316c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    316f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    3172:	39 da                	cmp    %ebx,%edx
    3174:	75 f2                	jne    3168 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    3176:	5b                   	pop    %ebx
    3177:	5e                   	pop    %esi
    3178:	5d                   	pop    %ebp
    3179:	c3                   	ret    
    317a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00003180 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
    3180:	55                   	push   %ebp
    3181:	89 e5                	mov    %esp,%ebp
    3183:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3186:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
    3189:	89 5d f8             	mov    %ebx,-0x8(%ebp)
    318c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    318f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3194:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    319b:	00 
    319c:	89 04 24             	mov    %eax,(%esp)
    319f:	e8 d4 00 00 00       	call   3278 <open>
  if(fd < 0)
    31a4:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    31a6:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
    31a8:	78 19                	js     31c3 <stat+0x43>
    return -1;
  r = fstat(fd, st);
    31aa:	8b 45 0c             	mov    0xc(%ebp),%eax
    31ad:	89 1c 24             	mov    %ebx,(%esp)
    31b0:	89 44 24 04          	mov    %eax,0x4(%esp)
    31b4:	e8 d7 00 00 00       	call   3290 <fstat>
  close(fd);
    31b9:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
    31bc:	89 c6                	mov    %eax,%esi
  close(fd);
    31be:	e8 9d 00 00 00       	call   3260 <close>
  return r;
}
    31c3:	89 f0                	mov    %esi,%eax
    31c5:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    31c8:	8b 75 fc             	mov    -0x4(%ebp),%esi
    31cb:	89 ec                	mov    %ebp,%esp
    31cd:	5d                   	pop    %ebp
    31ce:	c3                   	ret    
    31cf:	90                   	nop

000031d0 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
    31d0:	55                   	push   %ebp
    31d1:	89 e5                	mov    %esp,%ebp
    31d3:	57                   	push   %edi
    31d4:	56                   	push   %esi
    31d5:	31 f6                	xor    %esi,%esi
    31d7:	53                   	push   %ebx
    31d8:	83 ec 2c             	sub    $0x2c,%esp
    31db:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    31de:	eb 06                	jmp    31e6 <gets+0x16>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    31e0:	3c 0a                	cmp    $0xa,%al
    31e2:	74 39                	je     321d <gets+0x4d>
    31e4:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    31e6:	8d 5e 01             	lea    0x1(%esi),%ebx
    31e9:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    31ec:	7d 31                	jge    321f <gets+0x4f>
    cc = read(0, &c, 1);
    31ee:	8d 45 e7             	lea    -0x19(%ebp),%eax
    31f1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    31f8:	00 
    31f9:	89 44 24 04          	mov    %eax,0x4(%esp)
    31fd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3204:	e8 47 00 00 00       	call   3250 <read>
    if(cc < 1)
    3209:	85 c0                	test   %eax,%eax
    320b:	7e 12                	jle    321f <gets+0x4f>
      break;
    buf[i++] = c;
    320d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    3211:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
    3215:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    3219:	3c 0d                	cmp    $0xd,%al
    321b:	75 c3                	jne    31e0 <gets+0x10>
    321d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    321f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    3223:	89 f8                	mov    %edi,%eax
    3225:	83 c4 2c             	add    $0x2c,%esp
    3228:	5b                   	pop    %ebx
    3229:	5e                   	pop    %esi
    322a:	5f                   	pop    %edi
    322b:	5d                   	pop    %ebp
    322c:	c3                   	ret    
    322d:	90                   	nop
    322e:	90                   	nop
    322f:	90                   	nop

00003230 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    3230:	b8 01 00 00 00       	mov    $0x1,%eax
    3235:	cd 40                	int    $0x40
    3237:	c3                   	ret    

00003238 <exit>:
SYSCALL(exit)
    3238:	b8 02 00 00 00       	mov    $0x2,%eax
    323d:	cd 40                	int    $0x40
    323f:	c3                   	ret    

00003240 <wait>:
SYSCALL(wait)
    3240:	b8 03 00 00 00       	mov    $0x3,%eax
    3245:	cd 40                	int    $0x40
    3247:	c3                   	ret    

00003248 <pipe>:
SYSCALL(pipe)
    3248:	b8 04 00 00 00       	mov    $0x4,%eax
    324d:	cd 40                	int    $0x40
    324f:	c3                   	ret    

00003250 <read>:
SYSCALL(read)
    3250:	b8 06 00 00 00       	mov    $0x6,%eax
    3255:	cd 40                	int    $0x40
    3257:	c3                   	ret    

00003258 <write>:
SYSCALL(write)
    3258:	b8 05 00 00 00       	mov    $0x5,%eax
    325d:	cd 40                	int    $0x40
    325f:	c3                   	ret    

00003260 <close>:
SYSCALL(close)
    3260:	b8 07 00 00 00       	mov    $0x7,%eax
    3265:	cd 40                	int    $0x40
    3267:	c3                   	ret    

00003268 <kill>:
SYSCALL(kill)
    3268:	b8 08 00 00 00       	mov    $0x8,%eax
    326d:	cd 40                	int    $0x40
    326f:	c3                   	ret    

00003270 <exec>:
SYSCALL(exec)
    3270:	b8 09 00 00 00       	mov    $0x9,%eax
    3275:	cd 40                	int    $0x40
    3277:	c3                   	ret    

00003278 <open>:
SYSCALL(open)
    3278:	b8 0a 00 00 00       	mov    $0xa,%eax
    327d:	cd 40                	int    $0x40
    327f:	c3                   	ret    

00003280 <mknod>:
SYSCALL(mknod)
    3280:	b8 0b 00 00 00       	mov    $0xb,%eax
    3285:	cd 40                	int    $0x40
    3287:	c3                   	ret    

00003288 <unlink>:
SYSCALL(unlink)
    3288:	b8 0c 00 00 00       	mov    $0xc,%eax
    328d:	cd 40                	int    $0x40
    328f:	c3                   	ret    

00003290 <fstat>:
SYSCALL(fstat)
    3290:	b8 0d 00 00 00       	mov    $0xd,%eax
    3295:	cd 40                	int    $0x40
    3297:	c3                   	ret    

00003298 <link>:
SYSCALL(link)
    3298:	b8 0e 00 00 00       	mov    $0xe,%eax
    329d:	cd 40                	int    $0x40
    329f:	c3                   	ret    

000032a0 <mkdir>:
SYSCALL(mkdir)
    32a0:	b8 0f 00 00 00       	mov    $0xf,%eax
    32a5:	cd 40                	int    $0x40
    32a7:	c3                   	ret    

000032a8 <chdir>:
SYSCALL(chdir)
    32a8:	b8 10 00 00 00       	mov    $0x10,%eax
    32ad:	cd 40                	int    $0x40
    32af:	c3                   	ret    

000032b0 <dup>:
SYSCALL(dup)
    32b0:	b8 11 00 00 00       	mov    $0x11,%eax
    32b5:	cd 40                	int    $0x40
    32b7:	c3                   	ret    

000032b8 <getpid>:
SYSCALL(getpid)
    32b8:	b8 12 00 00 00       	mov    $0x12,%eax
    32bd:	cd 40                	int    $0x40
    32bf:	c3                   	ret    

000032c0 <sbrk>:
SYSCALL(sbrk)
    32c0:	b8 13 00 00 00       	mov    $0x13,%eax
    32c5:	cd 40                	int    $0x40
    32c7:	c3                   	ret    

000032c8 <sleep>:
SYSCALL(sleep)
    32c8:	b8 14 00 00 00       	mov    $0x14,%eax
    32cd:	cd 40                	int    $0x40
    32cf:	c3                   	ret    

000032d0 <uptime>:
SYSCALL(uptime)
    32d0:	b8 15 00 00 00       	mov    $0x15,%eax
    32d5:	cd 40                	int    $0x40
    32d7:	c3                   	ret    

000032d8 <startrecording>:
SYSCALL(startrecording)
    32d8:	b8 16 00 00 00       	mov    $0x16,%eax
    32dd:	cd 40                	int    $0x40
    32df:	c3                   	ret    

000032e0 <stoprecording>:
SYSCALL(stoprecording)
    32e0:	b8 17 00 00 00       	mov    $0x17,%eax
    32e5:	cd 40                	int    $0x40
    32e7:	c3                   	ret    

000032e8 <fetchrecords>:
    32e8:	b8 18 00 00 00       	mov    $0x18,%eax
    32ed:	cd 40                	int    $0x40
    32ef:	c3                   	ret    

000032f0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    32f0:	55                   	push   %ebp
    32f1:	89 e5                	mov    %esp,%ebp
    32f3:	57                   	push   %edi
    32f4:	89 cf                	mov    %ecx,%edi
    32f6:	56                   	push   %esi
    32f7:	89 c6                	mov    %eax,%esi
    32f9:	53                   	push   %ebx
    32fa:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    32fd:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3300:	85 c9                	test   %ecx,%ecx
    3302:	74 04                	je     3308 <printint+0x18>
    3304:	85 d2                	test   %edx,%edx
    3306:	78 70                	js     3378 <printint+0x88>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    3308:	89 d0                	mov    %edx,%eax
    330a:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    3311:	31 c9                	xor    %ecx,%ecx
    3313:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    3316:	66 90                	xchg   %ax,%ax
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    3318:	31 d2                	xor    %edx,%edx
    331a:	f7 f7                	div    %edi
    331c:	0f b6 92 57 4b 00 00 	movzbl 0x4b57(%edx),%edx
    3323:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
    3326:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
    3329:	85 c0                	test   %eax,%eax
    332b:	75 eb                	jne    3318 <printint+0x28>
  if(neg)
    332d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    3330:	85 c0                	test   %eax,%eax
    3332:	74 08                	je     333c <printint+0x4c>
    buf[i++] = '-';
    3334:	c6 44 0d d7 2d       	movb   $0x2d,-0x29(%ebp,%ecx,1)
    3339:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
    333c:	8d 79 ff             	lea    -0x1(%ecx),%edi
    333f:	01 fb                	add    %edi,%ebx
    3341:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3348:	0f b6 03             	movzbl (%ebx),%eax
    334b:	83 ef 01             	sub    $0x1,%edi
    334e:	83 eb 01             	sub    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3351:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3358:	00 
    3359:	89 34 24             	mov    %esi,(%esp)
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    335c:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    335f:	8d 45 e7             	lea    -0x19(%ebp),%eax
    3362:	89 44 24 04          	mov    %eax,0x4(%esp)
    3366:	e8 ed fe ff ff       	call   3258 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    336b:	83 ff ff             	cmp    $0xffffffff,%edi
    336e:	75 d8                	jne    3348 <printint+0x58>
    putc(fd, buf[i]);
}
    3370:	83 c4 4c             	add    $0x4c,%esp
    3373:	5b                   	pop    %ebx
    3374:	5e                   	pop    %esi
    3375:	5f                   	pop    %edi
    3376:	5d                   	pop    %ebp
    3377:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    3378:	89 d0                	mov    %edx,%eax
    337a:	f7 d8                	neg    %eax
    337c:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    3383:	eb 8c                	jmp    3311 <printint+0x21>
    3385:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003390 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    3390:	55                   	push   %ebp
    3391:	89 e5                	mov    %esp,%ebp
    3393:	57                   	push   %edi
    3394:	56                   	push   %esi
    3395:	53                   	push   %ebx
    3396:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3399:	8b 45 0c             	mov    0xc(%ebp),%eax
    339c:	0f b6 10             	movzbl (%eax),%edx
    339f:	84 d2                	test   %dl,%dl
    33a1:	0f 84 c9 00 00 00    	je     3470 <printf+0xe0>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    33a7:	8d 4d 10             	lea    0x10(%ebp),%ecx
    33aa:	31 ff                	xor    %edi,%edi
    33ac:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    33af:	31 db                	xor    %ebx,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    33b1:	8d 75 e7             	lea    -0x19(%ebp),%esi
    33b4:	eb 1e                	jmp    33d4 <printf+0x44>
    33b6:	66 90                	xchg   %ax,%ax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    33b8:	83 fa 25             	cmp    $0x25,%edx
    33bb:	0f 85 b7 00 00 00    	jne    3478 <printf+0xe8>
    33c1:	66 bf 25 00          	mov    $0x25,%di
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    33c5:	83 c3 01             	add    $0x1,%ebx
    33c8:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
    33cc:	84 d2                	test   %dl,%dl
    33ce:	0f 84 9c 00 00 00    	je     3470 <printf+0xe0>
    c = fmt[i] & 0xff;
    if(state == 0){
    33d4:	85 ff                	test   %edi,%edi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    33d6:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
    33d9:	74 dd                	je     33b8 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    33db:	83 ff 25             	cmp    $0x25,%edi
    33de:	75 e5                	jne    33c5 <printf+0x35>
      if(c == 'd'){
    33e0:	83 fa 64             	cmp    $0x64,%edx
    33e3:	0f 84 57 01 00 00    	je     3540 <printf+0x1b0>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    33e9:	83 fa 70             	cmp    $0x70,%edx
    33ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    33f0:	0f 84 aa 00 00 00    	je     34a0 <printf+0x110>
    33f6:	83 fa 78             	cmp    $0x78,%edx
    33f9:	0f 84 a1 00 00 00    	je     34a0 <printf+0x110>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    33ff:	83 fa 73             	cmp    $0x73,%edx
    3402:	0f 84 c0 00 00 00    	je     34c8 <printf+0x138>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    3408:	83 fa 63             	cmp    $0x63,%edx
    340b:	90                   	nop
    340c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3410:	0f 84 52 01 00 00    	je     3568 <printf+0x1d8>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    3416:	83 fa 25             	cmp    $0x25,%edx
    3419:	0f 84 f9 00 00 00    	je     3518 <printf+0x188>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    341f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3422:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3425:	31 ff                	xor    %edi,%edi
    3427:	89 55 cc             	mov    %edx,-0x34(%ebp)
    342a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    342e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3435:	00 
    3436:	89 0c 24             	mov    %ecx,(%esp)
    3439:	89 74 24 04          	mov    %esi,0x4(%esp)
    343d:	e8 16 fe ff ff       	call   3258 <write>
    3442:	8b 55 cc             	mov    -0x34(%ebp),%edx
    3445:	8b 45 08             	mov    0x8(%ebp),%eax
    3448:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    344f:	00 
    3450:	89 74 24 04          	mov    %esi,0x4(%esp)
    3454:	88 55 e7             	mov    %dl,-0x19(%ebp)
    3457:	89 04 24             	mov    %eax,(%esp)
    345a:	e8 f9 fd ff ff       	call   3258 <write>
    345f:	8b 45 0c             	mov    0xc(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3462:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
    3466:	84 d2                	test   %dl,%dl
    3468:	0f 85 66 ff ff ff    	jne    33d4 <printf+0x44>
    346e:	66 90                	xchg   %ax,%ax
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    3470:	83 c4 3c             	add    $0x3c,%esp
    3473:	5b                   	pop    %ebx
    3474:	5e                   	pop    %esi
    3475:	5f                   	pop    %edi
    3476:	5d                   	pop    %ebp
    3477:	c3                   	ret    
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3478:	8b 45 08             	mov    0x8(%ebp),%eax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    347b:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    347e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3485:	00 
    3486:	89 74 24 04          	mov    %esi,0x4(%esp)
    348a:	89 04 24             	mov    %eax,(%esp)
    348d:	e8 c6 fd ff ff       	call   3258 <write>
    3492:	8b 45 0c             	mov    0xc(%ebp),%eax
    3495:	e9 2b ff ff ff       	jmp    33c5 <printf+0x35>
    349a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    34a0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    34a3:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
    34a8:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    34aa:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    34b1:	8b 10                	mov    (%eax),%edx
    34b3:	8b 45 08             	mov    0x8(%ebp),%eax
    34b6:	e8 35 fe ff ff       	call   32f0 <printint>
    34bb:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    34be:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    34c2:	e9 fe fe ff ff       	jmp    33c5 <printf+0x35>
    34c7:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
    34c8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    34cb:	8b 3a                	mov    (%edx),%edi
        ap++;
    34cd:	83 c2 04             	add    $0x4,%edx
    34d0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
    34d3:	85 ff                	test   %edi,%edi
    34d5:	0f 84 ba 00 00 00    	je     3595 <printf+0x205>
          s = "(null)";
        while(*s != 0){
    34db:	0f b6 17             	movzbl (%edi),%edx
    34de:	84 d2                	test   %dl,%dl
    34e0:	74 2d                	je     350f <printf+0x17f>
    34e2:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    34e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
          putc(fd, *s);
          s++;
    34e8:	83 c7 01             	add    $0x1,%edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    34eb:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    34ee:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    34f5:	00 
    34f6:	89 74 24 04          	mov    %esi,0x4(%esp)
    34fa:	89 1c 24             	mov    %ebx,(%esp)
    34fd:	e8 56 fd ff ff       	call   3258 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    3502:	0f b6 17             	movzbl (%edi),%edx
    3505:	84 d2                	test   %dl,%dl
    3507:	75 df                	jne    34e8 <printf+0x158>
    3509:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    350c:	8b 45 0c             	mov    0xc(%ebp),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    350f:	31 ff                	xor    %edi,%edi
    3511:	e9 af fe ff ff       	jmp    33c5 <printf+0x35>
    3516:	66 90                	xchg   %ax,%ax
    3518:	8b 55 08             	mov    0x8(%ebp),%edx
    351b:	31 ff                	xor    %edi,%edi
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    351d:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3521:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3528:	00 
    3529:	89 74 24 04          	mov    %esi,0x4(%esp)
    352d:	89 14 24             	mov    %edx,(%esp)
    3530:	e8 23 fd ff ff       	call   3258 <write>
    3535:	8b 45 0c             	mov    0xc(%ebp),%eax
    3538:	e9 88 fe ff ff       	jmp    33c5 <printf+0x35>
    353d:	8d 76 00             	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    3540:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    3543:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
    3548:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    354b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3552:	8b 10                	mov    (%eax),%edx
    3554:	8b 45 08             	mov    0x8(%ebp),%eax
    3557:	e8 94 fd ff ff       	call   32f0 <printint>
    355c:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    355f:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    3563:	e9 5d fe ff ff       	jmp    33c5 <printf+0x35>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    3568:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
        putc(fd, *ap);
        ap++;
    356b:	31 ff                	xor    %edi,%edi
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    356d:	8b 01                	mov    (%ecx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    356f:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3576:	00 
    3577:	89 74 24 04          	mov    %esi,0x4(%esp)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    357b:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    357e:	8b 45 08             	mov    0x8(%ebp),%eax
    3581:	89 04 24             	mov    %eax,(%esp)
    3584:	e8 cf fc ff ff       	call   3258 <write>
    3589:	8b 45 0c             	mov    0xc(%ebp),%eax
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
    358c:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    3590:	e9 30 fe ff ff       	jmp    33c5 <printf+0x35>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
    3595:	bf 50 4b 00 00       	mov    $0x4b50,%edi
    359a:	e9 3c ff ff ff       	jmp    34db <printf+0x14b>
    359f:	90                   	nop

000035a0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    35a0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    35a1:	a1 88 4b 00 00       	mov    0x4b88,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    35a6:	89 e5                	mov    %esp,%ebp
    35a8:	57                   	push   %edi
    35a9:	56                   	push   %esi
    35aa:	53                   	push   %ebx
    35ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
    35ae:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    35b1:	39 c8                	cmp    %ecx,%eax
    35b3:	73 1d                	jae    35d2 <free+0x32>
    35b5:	8d 76 00             	lea    0x0(%esi),%esi
    35b8:	8b 10                	mov    (%eax),%edx
    35ba:	39 d1                	cmp    %edx,%ecx
    35bc:	72 1a                	jb     35d8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    35be:	39 d0                	cmp    %edx,%eax
    35c0:	72 08                	jb     35ca <free+0x2a>
    35c2:	39 c8                	cmp    %ecx,%eax
    35c4:	72 12                	jb     35d8 <free+0x38>
    35c6:	39 d1                	cmp    %edx,%ecx
    35c8:	72 0e                	jb     35d8 <free+0x38>
    35ca:	89 d0                	mov    %edx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    35cc:	39 c8                	cmp    %ecx,%eax
    35ce:	66 90                	xchg   %ax,%ax
    35d0:	72 e6                	jb     35b8 <free+0x18>
    35d2:	8b 10                	mov    (%eax),%edx
    35d4:	eb e8                	jmp    35be <free+0x1e>
    35d6:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    35d8:	8b 71 04             	mov    0x4(%ecx),%esi
    35db:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    35de:	39 d7                	cmp    %edx,%edi
    35e0:	74 19                	je     35fb <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    35e2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    35e5:	8b 50 04             	mov    0x4(%eax),%edx
    35e8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    35eb:	39 ce                	cmp    %ecx,%esi
    35ed:	74 23                	je     3612 <free+0x72>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    35ef:	89 08                	mov    %ecx,(%eax)
  freep = p;
    35f1:	a3 88 4b 00 00       	mov    %eax,0x4b88
}
    35f6:	5b                   	pop    %ebx
    35f7:	5e                   	pop    %esi
    35f8:	5f                   	pop    %edi
    35f9:	5d                   	pop    %ebp
    35fa:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    35fb:	03 72 04             	add    0x4(%edx),%esi
    35fe:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
    3601:	8b 10                	mov    (%eax),%edx
    3603:	8b 12                	mov    (%edx),%edx
    3605:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    3608:	8b 50 04             	mov    0x4(%eax),%edx
    360b:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    360e:	39 ce                	cmp    %ecx,%esi
    3610:	75 dd                	jne    35ef <free+0x4f>
    p->s.size += bp->s.size;
    3612:	03 51 04             	add    0x4(%ecx),%edx
    3615:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    3618:	8b 53 f8             	mov    -0x8(%ebx),%edx
    361b:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
    361d:	a3 88 4b 00 00       	mov    %eax,0x4b88
}
    3622:	5b                   	pop    %ebx
    3623:	5e                   	pop    %esi
    3624:	5f                   	pop    %edi
    3625:	5d                   	pop    %ebp
    3626:	c3                   	ret    
    3627:	89 f6                	mov    %esi,%esi
    3629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003630 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3630:	55                   	push   %ebp
    3631:	89 e5                	mov    %esp,%ebp
    3633:	57                   	push   %edi
    3634:	56                   	push   %esi
    3635:	53                   	push   %ebx
    3636:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3639:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
    363c:	8b 0d 88 4b 00 00    	mov    0x4b88,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3642:	83 c3 07             	add    $0x7,%ebx
    3645:	c1 eb 03             	shr    $0x3,%ebx
    3648:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    364b:	85 c9                	test   %ecx,%ecx
    364d:	0f 84 93 00 00 00    	je     36e6 <malloc+0xb6>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3653:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    3655:	8b 50 04             	mov    0x4(%eax),%edx
    3658:	39 d3                	cmp    %edx,%ebx
    365a:	76 1f                	jbe    367b <malloc+0x4b>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
    365c:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    3663:	90                   	nop
    3664:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
    if(p == freep)
    3668:	3b 05 88 4b 00 00    	cmp    0x4b88,%eax
    366e:	74 30                	je     36a0 <malloc+0x70>
    3670:	89 c1                	mov    %eax,%ecx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3672:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    3674:	8b 50 04             	mov    0x4(%eax),%edx
    3677:	39 d3                	cmp    %edx,%ebx
    3679:	77 ed                	ja     3668 <malloc+0x38>
      if(p->s.size == nunits)
    367b:	39 d3                	cmp    %edx,%ebx
    367d:	74 61                	je     36e0 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    367f:	29 da                	sub    %ebx,%edx
    3681:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    3684:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    3687:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    368a:	89 0d 88 4b 00 00    	mov    %ecx,0x4b88
      return (void*) (p + 1);
    3690:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    3693:	83 c4 1c             	add    $0x1c,%esp
    3696:	5b                   	pop    %ebx
    3697:	5e                   	pop    %esi
    3698:	5f                   	pop    %edi
    3699:	5d                   	pop    %ebp
    369a:	c3                   	ret    
    369b:	90                   	nop
    369c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    36a0:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
    36a6:	b8 00 80 00 00       	mov    $0x8000,%eax
    36ab:	bf 00 10 00 00       	mov    $0x1000,%edi
    36b0:	76 04                	jbe    36b6 <malloc+0x86>
    36b2:	89 f0                	mov    %esi,%eax
    36b4:	89 df                	mov    %ebx,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    36b6:	89 04 24             	mov    %eax,(%esp)
    36b9:	e8 02 fc ff ff       	call   32c0 <sbrk>
  if(p == (char*) -1)
    36be:	83 f8 ff             	cmp    $0xffffffff,%eax
    36c1:	74 18                	je     36db <malloc+0xab>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    36c3:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
    36c6:	83 c0 08             	add    $0x8,%eax
    36c9:	89 04 24             	mov    %eax,(%esp)
    36cc:	e8 cf fe ff ff       	call   35a0 <free>
  return freep;
    36d1:	8b 0d 88 4b 00 00    	mov    0x4b88,%ecx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    36d7:	85 c9                	test   %ecx,%ecx
    36d9:	75 97                	jne    3672 <malloc+0x42>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    36db:	31 c0                	xor    %eax,%eax
    36dd:	eb b4                	jmp    3693 <malloc+0x63>
    36df:	90                   	nop
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    36e0:	8b 10                	mov    (%eax),%edx
    36e2:	89 11                	mov    %edx,(%ecx)
    36e4:	eb a4                	jmp    368a <malloc+0x5a>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    36e6:	c7 05 88 4b 00 00 80 	movl   $0x4b80,0x4b88
    36ed:	4b 00 00 
    base.s.size = 0;
    36f0:	b9 80 4b 00 00       	mov    $0x4b80,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    36f5:	c7 05 80 4b 00 00 80 	movl   $0x4b80,0x4b80
    36fc:	4b 00 00 
    base.s.size = 0;
    36ff:	c7 05 84 4b 00 00 00 	movl   $0x0,0x4b84
    3706:	00 00 00 
    3709:	e9 45 ff ff ff       	jmp    3653 <malloc+0x23>
