
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

00000010 <opentest>:
}


void
opentest(void)
{
      10:	55                   	push   %ebp
      11:	89 e5                	mov    %esp,%ebp
      13:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(stdout, "open test\n");
      16:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
      1b:	c7 44 24 04 40 38 00 	movl   $0x3840,0x4(%esp)
      22:	00 
      23:	89 04 24             	mov    %eax,(%esp)
      26:	e8 95 34 00 00       	call   34c0 <printf>
  fd = open("echo", 0);
      2b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
      32:	00 
      33:	c7 04 24 4b 38 00 00 	movl   $0x384b,(%esp)
      3a:	e8 69 33 00 00       	call   33a8 <open>
  if(fd < 0){
      3f:	85 c0                	test   %eax,%eax
      41:	78 37                	js     7a <opentest+0x6a>
    printf(stdout, "open echo failed!\n");
    exit();
  }
  close(fd);
      43:	89 04 24             	mov    %eax,(%esp)
      46:	e8 45 33 00 00       	call   3390 <close>
  fd = open("doesnotexist", 0);
      4b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
      52:	00 
      53:	c7 04 24 63 38 00 00 	movl   $0x3863,(%esp)
      5a:	e8 49 33 00 00       	call   33a8 <open>
  if(fd >= 0){
      5f:	85 c0                	test   %eax,%eax
      61:	79 31                	jns    94 <opentest+0x84>
    printf(stdout, "open doesnotexist succeeded!\n");
    exit();
  }
  printf(stdout, "open test ok\n");
      63:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
      68:	c7 44 24 04 8e 38 00 	movl   $0x388e,0x4(%esp)
      6f:	00 
      70:	89 04 24             	mov    %eax,(%esp)
      73:	e8 48 34 00 00       	call   34c0 <printf>
}
      78:	c9                   	leave  
      79:	c3                   	ret    
  int fd;

  printf(stdout, "open test\n");
  fd = open("echo", 0);
  if(fd < 0){
    printf(stdout, "open echo failed!\n");
      7a:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
      7f:	c7 44 24 04 50 38 00 	movl   $0x3850,0x4(%esp)
      86:	00 
      87:	89 04 24             	mov    %eax,(%esp)
      8a:	e8 31 34 00 00       	call   34c0 <printf>
    exit();
      8f:	e8 d4 32 00 00       	call   3368 <exit>
  }
  close(fd);
  fd = open("doesnotexist", 0);
  if(fd >= 0){
    printf(stdout, "open doesnotexist succeeded!\n");
      94:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
      99:	c7 44 24 04 70 38 00 	movl   $0x3870,0x4(%esp)
      a0:	00 
      a1:	89 04 24             	mov    %eax,(%esp)
      a4:	e8 17 34 00 00       	call   34c0 <printf>
    exit();
      a9:	e8 ba 32 00 00       	call   3368 <exit>
      ae:	66 90                	xchg   %ax,%ax

000000b0 <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
      b0:	55                   	push   %ebp
      b1:	89 e5                	mov    %esp,%ebp
      b3:	53                   	push   %ebx
  int n, pid;

  printf(1, "fork test\n");
      b4:	31 db                	xor    %ebx,%ebx
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
      b6:	83 ec 14             	sub    $0x14,%esp
  int n, pid;

  printf(1, "fork test\n");
      b9:	c7 44 24 04 9c 38 00 	movl   $0x389c,0x4(%esp)
      c0:	00 
      c1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      c8:	e8 f3 33 00 00       	call   34c0 <printf>
      cd:	eb 13                	jmp    e2 <forktest+0x32>
      cf:	90                   	nop

  for(n=0; n<1000; n++){
    pid = fork();
    if(pid < 0)
      break;
    if(pid == 0)
      d0:	74 72                	je     144 <forktest+0x94>
{
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<1000; n++){
      d2:	83 c3 01             	add    $0x1,%ebx
      d5:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
      db:	90                   	nop
      dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      e0:	74 4e                	je     130 <forktest+0x80>
      e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pid = fork();
      e8:	e8 73 32 00 00       	call   3360 <fork>
    if(pid < 0)
      ed:	83 f8 00             	cmp    $0x0,%eax
      f0:	7d de                	jge    d0 <forktest+0x20>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit();
  }
  
  for(; n > 0; n--){
      f2:	85 db                	test   %ebx,%ebx
      f4:	74 11                	je     107 <forktest+0x57>
      f6:	66 90                	xchg   %ax,%ax
    if(wait() < 0){
      f8:	e8 73 32 00 00       	call   3370 <wait>
      fd:	85 c0                	test   %eax,%eax
      ff:	90                   	nop
     100:	78 47                	js     149 <forktest+0x99>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit();
  }
  
  for(; n > 0; n--){
     102:	83 eb 01             	sub    $0x1,%ebx
     105:	75 f1                	jne    f8 <forktest+0x48>
     107:	90                   	nop
      printf(1, "wait stopped early\n");
      exit();
    }
  }
  
  if(wait() != -1){
     108:	e8 63 32 00 00       	call   3370 <wait>
     10d:	83 f8 ff             	cmp    $0xffffffff,%eax
     110:	75 50                	jne    162 <forktest+0xb2>
    printf(1, "wait got too many\n");
    exit();
  }
  
  printf(1, "fork test OK\n");
     112:	c7 44 24 04 ce 38 00 	movl   $0x38ce,0x4(%esp)
     119:	00 
     11a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     121:	e8 9a 33 00 00       	call   34c0 <printf>
}
     126:	83 c4 14             	add    $0x14,%esp
     129:	5b                   	pop    %ebx
     12a:	5d                   	pop    %ebp
     12b:	c3                   	ret    
     12c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(pid == 0)
      exit();
  }
  
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
     130:	c7 44 24 04 d8 46 00 	movl   $0x46d8,0x4(%esp)
     137:	00 
     138:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     13f:	e8 7c 33 00 00       	call   34c0 <printf>
    exit();
     144:	e8 1f 32 00 00       	call   3368 <exit>
  }
  
  for(; n > 0; n--){
    if(wait() < 0){
      printf(1, "wait stopped early\n");
     149:	c7 44 24 04 a7 38 00 	movl   $0x38a7,0x4(%esp)
     150:	00 
     151:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     158:	e8 63 33 00 00       	call   34c0 <printf>
      exit();
     15d:	e8 06 32 00 00       	call   3368 <exit>
    }
  }
  
  if(wait() != -1){
    printf(1, "wait got too many\n");
     162:	c7 44 24 04 bb 38 00 	movl   $0x38bb,0x4(%esp)
     169:	00 
     16a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     171:	e8 4a 33 00 00       	call   34c0 <printf>
    exit();
     176:	e8 ed 31 00 00       	call   3368 <exit>
     17b:	90                   	nop
     17c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000180 <exitwait>:
}

// try to find any races between exit and wait
void
exitwait(void)
{
     180:	55                   	push   %ebp
     181:	89 e5                	mov    %esp,%ebp
     183:	56                   	push   %esi
     184:	31 f6                	xor    %esi,%esi
     186:	53                   	push   %ebx
     187:	83 ec 10             	sub    $0x10,%esp
     18a:	eb 17                	jmp    1a3 <exitwait+0x23>
     18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
      return;
    }
    if(pid){
     190:	74 79                	je     20b <exitwait+0x8b>
      if(wait() != pid){
     192:	e8 d9 31 00 00       	call   3370 <wait>
     197:	39 c3                	cmp    %eax,%ebx
     199:	75 35                	jne    1d0 <exitwait+0x50>
void
exitwait(void)
{
  int i, pid;

  for(i = 0; i < 100; i++){
     19b:	83 c6 01             	add    $0x1,%esi
     19e:	83 fe 64             	cmp    $0x64,%esi
     1a1:	74 4d                	je     1f0 <exitwait+0x70>
    pid = fork();
     1a3:	e8 b8 31 00 00       	call   3360 <fork>
    if(pid < 0){
     1a8:	83 f8 00             	cmp    $0x0,%eax
exitwait(void)
{
  int i, pid;

  for(i = 0; i < 100; i++){
    pid = fork();
     1ab:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
     1ad:	7d e1                	jge    190 <exitwait+0x10>
      printf(1, "fork failed\n");
     1af:	c7 44 24 04 69 39 00 	movl   $0x3969,0x4(%esp)
     1b6:	00 
     1b7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     1be:	e8 fd 32 00 00       	call   34c0 <printf>
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
}
     1c3:	83 c4 10             	add    $0x10,%esp
     1c6:	5b                   	pop    %ebx
     1c7:	5e                   	pop    %esi
     1c8:	5d                   	pop    %ebp
     1c9:	c3                   	ret    
     1ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      printf(1, "fork failed\n");
      return;
    }
    if(pid){
      if(wait() != pid){
        printf(1, "wait wrong pid\n");
     1d0:	c7 44 24 04 dc 38 00 	movl   $0x38dc,0x4(%esp)
     1d7:	00 
     1d8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     1df:	e8 dc 32 00 00       	call   34c0 <printf>
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
}
     1e4:	83 c4 10             	add    $0x10,%esp
     1e7:	5b                   	pop    %ebx
     1e8:	5e                   	pop    %esi
     1e9:	5d                   	pop    %ebp
     1ea:	c3                   	ret    
     1eb:	90                   	nop
     1ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      }
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
     1f0:	c7 44 24 04 ec 38 00 	movl   $0x38ec,0x4(%esp)
     1f7:	00 
     1f8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     1ff:	e8 bc 32 00 00       	call   34c0 <printf>
}
     204:	83 c4 10             	add    $0x10,%esp
     207:	5b                   	pop    %ebx
     208:	5e                   	pop    %esi
     209:	5d                   	pop    %ebp
     20a:	c3                   	ret    
      if(wait() != pid){
        printf(1, "wait wrong pid\n");
        return;
      }
    } else {
      exit();
     20b:	e8 58 31 00 00       	call   3368 <exit>

00000210 <validatetest>:
      "ebx");
}

void
validatetest(void)
{
     210:	55                   	push   %ebp
     211:	89 e5                	mov    %esp,%ebp
     213:	56                   	push   %esi
     214:	53                   	push   %ebx
  int hi = 1100*1024;

  printf(stdout, "validate test\n");
     215:	31 db                	xor    %ebx,%ebx
      "ebx");
}

void
validatetest(void)
{
     217:	83 ec 10             	sub    $0x10,%esp
  int hi = 1100*1024;

  printf(stdout, "validate test\n");
     21a:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
     21f:	c7 44 24 04 f9 38 00 	movl   $0x38f9,0x4(%esp)
     226:	00 
     227:	89 04 24             	mov    %eax,(%esp)
     22a:	e8 91 32 00 00       	call   34c0 <printf>
     22f:	90                   	nop

  uint p;
  for (p = 0; p <= (uint)hi; p += 4096) {
    int pid;
    if ((pid = fork()) == 0) {
     230:	e8 2b 31 00 00       	call   3360 <fork>
     235:	85 c0                	test   %eax,%eax
     237:	89 c6                	mov    %eax,%esi
     239:	74 79                	je     2b4 <validatetest+0xa4>
      // try to crash the kernel by passing in a badly placed integer
      validateint((int*)p);
      exit();
    }
    sleep(0);
     23b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     242:	e8 b1 31 00 00       	call   33f8 <sleep>
    sleep(0);
     247:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     24e:	e8 a5 31 00 00       	call   33f8 <sleep>
    kill(pid);
     253:	89 34 24             	mov    %esi,(%esp)
     256:	e8 3d 31 00 00       	call   3398 <kill>
    wait();
     25b:	e8 10 31 00 00       	call   3370 <wait>

    // try to crash the kernel by passing in a bad string pointer
    if (link("nosuchfile", (char*)p) != -1) {
     260:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     264:	c7 04 24 08 39 00 00 	movl   $0x3908,(%esp)
     26b:	e8 58 31 00 00       	call   33c8 <link>
     270:	83 f8 ff             	cmp    $0xffffffff,%eax
     273:	75 2a                	jne    29f <validatetest+0x8f>
  int hi = 1100*1024;

  printf(stdout, "validate test\n");

  uint p;
  for (p = 0; p <= (uint)hi; p += 4096) {
     275:	81 c3 00 10 00 00    	add    $0x1000,%ebx
     27b:	81 fb 00 40 11 00    	cmp    $0x114000,%ebx
     281:	75 ad                	jne    230 <validatetest+0x20>
      printf(stdout, "link should not succeed\n");
      exit();
    }
  }

  printf(stdout, "validate ok\n");
     283:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
     288:	c7 44 24 04 2c 39 00 	movl   $0x392c,0x4(%esp)
     28f:	00 
     290:	89 04 24             	mov    %eax,(%esp)
     293:	e8 28 32 00 00       	call   34c0 <printf>
}
     298:	83 c4 10             	add    $0x10,%esp
     29b:	5b                   	pop    %ebx
     29c:	5e                   	pop    %esi
     29d:	5d                   	pop    %ebp
     29e:	c3                   	ret    
    kill(pid);
    wait();

    // try to crash the kernel by passing in a bad string pointer
    if (link("nosuchfile", (char*)p) != -1) {
      printf(stdout, "link should not succeed\n");
     29f:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
     2a4:	c7 44 24 04 13 39 00 	movl   $0x3913,0x4(%esp)
     2ab:	00 
     2ac:	89 04 24             	mov    %eax,(%esp)
     2af:	e8 0c 32 00 00       	call   34c0 <printf>
      exit();
     2b4:	e8 af 30 00 00       	call   3368 <exit>
     2b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002c0 <sbrktest>:
  printf(1, "fork test OK\n");
}

void
sbrktest(void)
{
     2c0:	55                   	push   %ebp
     2c1:	89 e5                	mov    %esp,%ebp
     2c3:	57                   	push   %edi
     2c4:	56                   	push   %esi
  char *oldbrk = sbrk(0);

  printf(stdout, "sbrk test\n");

  // can one sbrk() less than a page?
  char *a = sbrk(0);
     2c5:	31 f6                	xor    %esi,%esi
  printf(1, "fork test OK\n");
}

void
sbrktest(void)
{
     2c7:	53                   	push   %ebx
     2c8:	81 ec cc 00 00 00    	sub    $0xcc,%esp
  int pid;
  char *oldbrk = sbrk(0);
     2ce:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     2d5:	e8 16 31 00 00       	call   33f0 <sbrk>

  printf(stdout, "sbrk test\n");
     2da:	c7 44 24 04 39 39 00 	movl   $0x3939,0x4(%esp)
     2e1:	00 

void
sbrktest(void)
{
  int pid;
  char *oldbrk = sbrk(0);
     2e2:	89 85 54 ff ff ff    	mov    %eax,-0xac(%ebp)

  printf(stdout, "sbrk test\n");
     2e8:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
     2ed:	89 04 24             	mov    %eax,(%esp)
     2f0:	e8 cb 31 00 00       	call   34c0 <printf>

  // can one sbrk() less than a page?
  char *a = sbrk(0);
     2f5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     2fc:	e8 ef 30 00 00       	call   33f0 <sbrk>
     301:	89 c3                	mov    %eax,%ebx
     303:	90                   	nop
     304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int i;
  for(i = 0; i < 5000; i++){
    char *b = sbrk(1);
     308:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     30f:	e8 dc 30 00 00       	call   33f0 <sbrk>
    if(b != a){
     314:	39 c3                	cmp    %eax,%ebx
     316:	0f 85 8a 02 00 00    	jne    5a6 <sbrktest+0x2e6>
  printf(stdout, "sbrk test\n");

  // can one sbrk() less than a page?
  char *a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
     31c:	83 c6 01             	add    $0x1,%esi
    char *b = sbrk(1);
    if(b != a){
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
      exit();
    }
    *b = 1;
     31f:	c6 03 01             	movb   $0x1,(%ebx)
    a = b + 1;
     322:	83 c3 01             	add    $0x1,%ebx
  printf(stdout, "sbrk test\n");

  // can one sbrk() less than a page?
  char *a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
     325:	81 fe 88 13 00 00    	cmp    $0x1388,%esi
     32b:	75 db                	jne    308 <sbrktest+0x48>
      exit();
    }
    *b = 1;
    a = b + 1;
  }
  pid = fork();
     32d:	e8 2e 30 00 00       	call   3360 <fork>
  if(pid < 0){
     332:	85 c0                	test   %eax,%eax
      exit();
    }
    *b = 1;
    a = b + 1;
  }
  pid = fork();
     334:	89 c6                	mov    %eax,%esi
  if(pid < 0){
     336:	0f 88 18 04 00 00    	js     754 <sbrktest+0x494>
    printf(stdout, "sbrk test fork failed\n");
    exit();
  }
  char *c = sbrk(1);
     33c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  c = sbrk(1);
  if(c != a + 1){
     343:	83 c3 01             	add    $0x1,%ebx
  pid = fork();
  if(pid < 0){
    printf(stdout, "sbrk test fork failed\n");
    exit();
  }
  char *c = sbrk(1);
     346:	e8 a5 30 00 00       	call   33f0 <sbrk>
  c = sbrk(1);
     34b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     352:	e8 99 30 00 00       	call   33f0 <sbrk>
  if(c != a + 1){
     357:	39 d8                	cmp    %ebx,%eax
     359:	0f 85 db 03 00 00    	jne    73a <sbrktest+0x47a>
    printf(stdout, "sbrk test failed post-fork\n");
    exit();
  }
  if(pid == 0)
     35f:	85 f6                	test   %esi,%esi
     361:	0f 84 ce 03 00 00    	je     735 <sbrktest+0x475>
     367:	90                   	nop
    exit();
  wait();
     368:	e8 03 30 00 00       	call   3370 <wait>

  // can one allocate the full 640K?
  a = sbrk(0);
     36d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     374:	e8 77 30 00 00       	call   33f0 <sbrk>
     379:	89 c3                	mov    %eax,%ebx
  uint amt = (640 * 1024) - (uint) a;
  char *p = sbrk(amt);
     37b:	b8 00 00 0a 00       	mov    $0xa0000,%eax
     380:	29 d8                	sub    %ebx,%eax
     382:	89 04 24             	mov    %eax,(%esp)
     385:	e8 66 30 00 00       	call   33f0 <sbrk>
  if(p != a){
     38a:	39 c3                	cmp    %eax,%ebx
     38c:	0f 85 86 03 00 00    	jne    718 <sbrktest+0x458>
    printf(stdout, "sbrk test failed 640K test, p %x a %x\n", p, a);
    exit();
  }
  char *lastaddr = (char *)(640 * 1024 - 1);
  *lastaddr = 99;
     392:	c6 05 ff ff 09 00 63 	movb   $0x63,0x9ffff

  // is one forbidden from allocating more than 640K?
  c = sbrk(4096);
     399:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
     3a0:	e8 4b 30 00 00       	call   33f0 <sbrk>
  if(c != (char *) 0xffffffff){
     3a5:	83 f8 ff             	cmp    $0xffffffff,%eax
     3a8:	0f 85 4c 03 00 00    	jne    6fa <sbrktest+0x43a>
    printf(stdout, "sbrk allocated more than 640K, c %x\n", c);
    exit();
  }

  // can one de-allocate?
  a = sbrk(0);
     3ae:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     3b5:	e8 36 30 00 00       	call   33f0 <sbrk>
  c = sbrk(-4096);
     3ba:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
    printf(stdout, "sbrk allocated more than 640K, c %x\n", c);
    exit();
  }

  // can one de-allocate?
  a = sbrk(0);
     3c1:	89 c3                	mov    %eax,%ebx
  c = sbrk(-4096);
     3c3:	e8 28 30 00 00       	call   33f0 <sbrk>
  if(c == (char *) 0xffffffff){
     3c8:	83 f8 ff             	cmp    $0xffffffff,%eax
     3cb:	0f 84 0f 03 00 00    	je     6e0 <sbrktest+0x420>
    printf(stdout, "sbrk could not deallocate\n");
    exit();
  }
  c = sbrk(0);
     3d1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     3d8:	e8 13 30 00 00       	call   33f0 <sbrk>
  if(c != a - 4096){
     3dd:	8d 93 00 f0 ff ff    	lea    -0x1000(%ebx),%edx
     3e3:	39 d0                	cmp    %edx,%eax
     3e5:	0f 85 d3 02 00 00    	jne    6be <sbrktest+0x3fe>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    exit();
  }

  // can one re-allocate that page?
  a = sbrk(0);
     3eb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     3f2:	e8 f9 2f 00 00       	call   33f0 <sbrk>
  c = sbrk(4096);
     3f7:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    exit();
  }

  // can one re-allocate that page?
  a = sbrk(0);
     3fe:	89 c3                	mov    %eax,%ebx
  c = sbrk(4096);
     400:	e8 eb 2f 00 00       	call   33f0 <sbrk>
  if(c != a || sbrk(0) != a + 4096){
     405:	39 c3                	cmp    %eax,%ebx
    exit();
  }

  // can one re-allocate that page?
  a = sbrk(0);
  c = sbrk(4096);
     407:	89 c6                	mov    %eax,%esi
  if(c != a || sbrk(0) != a + 4096){
     409:	0f 85 8d 02 00 00    	jne    69c <sbrktest+0x3dc>
     40f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     416:	e8 d5 2f 00 00       	call   33f0 <sbrk>
     41b:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
     421:	39 d0                	cmp    %edx,%eax
     423:	0f 85 73 02 00 00    	jne    69c <sbrktest+0x3dc>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    exit();
  }
  if(*lastaddr == 99){
     429:	80 3d ff ff 09 00 63 	cmpb   $0x63,0x9ffff
     430:	0f 84 4c 02 00 00    	je     682 <sbrktest+0x3c2>
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    exit();
  }

  c = sbrk(4096);
     436:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  if(c != (char *) 0xffffffff){
    printf(stdout, "sbrk was able to re-allocate beyond 640K, c %x\n", c);
    exit();
     43d:	bb 00 00 0a 00       	mov    $0xa0000,%ebx
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    exit();
  }

  c = sbrk(4096);
     442:	e8 a9 2f 00 00       	call   33f0 <sbrk>
  if(c != (char *) 0xffffffff){
     447:	83 f8 ff             	cmp    $0xffffffff,%eax
     44a:	0f 85 14 02 00 00    	jne    664 <sbrktest+0x3a4>
    exit();
  }

  // can we read the kernel's memory?
  for(a = (char*)(640*1024); a < (char *)2000000; a += 50000){
    int ppid = getpid();
     450:	e8 93 2f 00 00       	call   33e8 <getpid>
     455:	89 c6                	mov    %eax,%esi
    int pid = fork();
     457:	e8 04 2f 00 00       	call   3360 <fork>
    if(pid < 0){
     45c:	83 f8 00             	cmp    $0x0,%eax
     45f:	0f 8c e5 01 00 00    	jl     64a <sbrktest+0x38a>
      printf(stdout, "fork failed\n");
      exit();
    }
    if(pid == 0){
     465:	0f 84 b2 01 00 00    	je     61d <sbrktest+0x35d>
    printf(stdout, "sbrk was able to re-allocate beyond 640K, c %x\n", c);
    exit();
  }

  // can we read the kernel's memory?
  for(a = (char*)(640*1024); a < (char *)2000000; a += 50000){
     46b:	81 c3 50 c3 00 00    	add    $0xc350,%ebx
     471:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(pid == 0){
      printf(stdout, "oops could read %x = %x\n", a, *a);
      kill(ppid);
      exit();
    }
    wait();
     478:	e8 f3 2e 00 00       	call   3370 <wait>
    printf(stdout, "sbrk was able to re-allocate beyond 640K, c %x\n", c);
    exit();
  }

  // can we read the kernel's memory?
  for(a = (char*)(640*1024); a < (char *)2000000; a += 50000){
     47d:	81 fb 70 99 1e 00    	cmp    $0x1e9970,%ebx
     483:	75 cb                	jne    450 <sbrktest+0x190>
    wait();
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  sbrk(-(sbrk(0) - oldbrk));
     485:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     48c:	e8 5f 2f 00 00       	call   33f0 <sbrk>
     491:	8b 95 54 ff ff ff    	mov    -0xac(%ebp),%edx
     497:	29 c2                	sub    %eax,%edx
     499:	89 14 24             	mov    %edx,(%esp)
     49c:	e8 4f 2f 00 00       	call   33f0 <sbrk>
  int pids[32];
  int fds[2];
  if(pipe(fds) != 0){
     4a1:	8d 45 dc             	lea    -0x24(%ebp),%eax
     4a4:	89 04 24             	mov    %eax,(%esp)
     4a7:	e8 cc 2e 00 00       	call   3378 <pipe>
     4ac:	85 c0                	test   %eax,%eax
     4ae:	0f 85 50 01 00 00    	jne    604 <sbrktest+0x344>
    printf(1, "pipe() failed\n");
    exit();
     4b4:	31 db                	xor    %ebx,%ebx
     4b6:	8d bd 5c ff ff ff    	lea    -0xa4(%ebp),%edi
     4bc:	eb 2a                	jmp    4e8 <sbrktest+0x228>
      write(fds[1], "x", 1);
      // sit around until killed
      for(;;) sleep(1000);
    }
    char scratch;
    if(pids[i] != -1)
     4be:	83 f8 ff             	cmp    $0xffffffff,%eax
     4c1:	74 1a                	je     4dd <sbrktest+0x21d>
      read(fds[0], &scratch, 1);
     4c3:	8d 45 e7             	lea    -0x19(%ebp),%eax
     4c6:	89 44 24 04          	mov    %eax,0x4(%esp)
     4ca:	8b 45 dc             	mov    -0x24(%ebp),%eax
     4cd:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     4d4:	00 
     4d5:	89 04 24             	mov    %eax,(%esp)
     4d8:	e8 a3 2e 00 00       	call   3380 <read>
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit();
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if((pids[i] = fork()) == 0) {
     4dd:	89 34 9f             	mov    %esi,(%edi,%ebx,4)
  int fds[2];
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit();
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
     4e0:	83 c3 01             	add    $0x1,%ebx
     4e3:	83 fb 20             	cmp    $0x20,%ebx
     4e6:	74 56                	je     53e <sbrktest+0x27e>
    if((pids[i] = fork()) == 0) {
     4e8:	e8 73 2e 00 00       	call   3360 <fork>
     4ed:	85 c0                	test   %eax,%eax
     4ef:	89 c6                	mov    %eax,%esi
     4f1:	75 cb                	jne    4be <sbrktest+0x1fe>
      // allocate the full 640K
      sbrk((640 * 1024) - (uint)sbrk(0));
     4f3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     4fa:	e8 f1 2e 00 00       	call   33f0 <sbrk>
     4ff:	ba 00 00 0a 00       	mov    $0xa0000,%edx
     504:	29 c2                	sub    %eax,%edx
     506:	89 14 24             	mov    %edx,(%esp)
     509:	e8 e2 2e 00 00       	call   33f0 <sbrk>
      write(fds[1], "x", 1);
     50e:	8b 45 e0             	mov    -0x20(%ebp),%eax
     511:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     518:	00 
     519:	c7 44 24 04 02 3f 00 	movl   $0x3f02,0x4(%esp)
     520:	00 
     521:	89 04 24             	mov    %eax,(%esp)
     524:	e8 5f 2e 00 00       	call   3388 <write>
     529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      // sit around until killed
      for(;;) sleep(1000);
     530:	c7 04 24 e8 03 00 00 	movl   $0x3e8,(%esp)
     537:	e8 bc 2e 00 00       	call   33f8 <sleep>
     53c:	eb f2                	jmp    530 <sbrktest+0x270>
    if(pids[i] != -1)
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
     53e:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
     545:	30 db                	xor    %bl,%bl
     547:	e8 a4 2e 00 00       	call   33f0 <sbrk>
     54c:	89 c6                	mov    %eax,%esi
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if(pids[i] == -1)
     54e:	8b 04 9f             	mov    (%edi,%ebx,4),%eax
     551:	83 f8 ff             	cmp    $0xffffffff,%eax
     554:	74 0d                	je     563 <sbrktest+0x2a3>
      continue;
    kill(pids[i]);
     556:	89 04 24             	mov    %eax,(%esp)
     559:	e8 3a 2e 00 00       	call   3398 <kill>
    wait();
     55e:	e8 0d 2e 00 00       	call   3370 <wait>
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
     563:	83 c3 01             	add    $0x1,%ebx
     566:	83 fb 20             	cmp    $0x20,%ebx
     569:	75 e3                	jne    54e <sbrktest+0x28e>
    if(pids[i] == -1)
      continue;
    kill(pids[i]);
    wait();
  }
  if(c == (char*)0xffffffff) {
     56b:	83 fe ff             	cmp    $0xffffffff,%esi
     56e:	66 90                	xchg   %ax,%ax
     570:	74 78                	je     5ea <sbrktest+0x32a>
    printf(stdout, "failed sbrk leaked memory\n");
    exit();
  }

  if(sbrk(0) > oldbrk)
     572:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     579:	e8 72 2e 00 00       	call   33f0 <sbrk>
     57e:	39 85 54 ff ff ff    	cmp    %eax,-0xac(%ebp)
     584:	72 46                	jb     5cc <sbrktest+0x30c>
    sbrk(-(sbrk(0) - oldbrk));

  printf(stdout, "sbrk test OK\n");
     586:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
     58b:	c7 44 24 04 f0 39 00 	movl   $0x39f0,0x4(%esp)
     592:	00 
     593:	89 04 24             	mov    %eax,(%esp)
     596:	e8 25 2f 00 00       	call   34c0 <printf>
}
     59b:	81 c4 cc 00 00 00    	add    $0xcc,%esp
     5a1:	5b                   	pop    %ebx
     5a2:	5e                   	pop    %esi
     5a3:	5f                   	pop    %edi
     5a4:	5d                   	pop    %ebp
     5a5:	c3                   	ret    
  char *a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
    char *b = sbrk(1);
    if(b != a){
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
     5a6:	89 44 24 10          	mov    %eax,0x10(%esp)
     5aa:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
     5af:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
     5b3:	89 74 24 08          	mov    %esi,0x8(%esp)
     5b7:	c7 44 24 04 44 39 00 	movl   $0x3944,0x4(%esp)
     5be:	00 
     5bf:	89 04 24             	mov    %eax,(%esp)
     5c2:	e8 f9 2e 00 00       	call   34c0 <printf>
      exit();
     5c7:	e8 9c 2d 00 00       	call   3368 <exit>
    printf(stdout, "failed sbrk leaked memory\n");
    exit();
  }

  if(sbrk(0) > oldbrk)
    sbrk(-(sbrk(0) - oldbrk));
     5cc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     5d3:	e8 18 2e 00 00       	call   33f0 <sbrk>
     5d8:	8b 95 54 ff ff ff    	mov    -0xac(%ebp),%edx
     5de:	29 c2                	sub    %eax,%edx
     5e0:	89 14 24             	mov    %edx,(%esp)
     5e3:	e8 08 2e 00 00       	call   33f0 <sbrk>
     5e8:	eb 9c                	jmp    586 <sbrktest+0x2c6>
      continue;
    kill(pids[i]);
    wait();
  }
  if(c == (char*)0xffffffff) {
    printf(stdout, "failed sbrk leaked memory\n");
     5ea:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
     5ef:	c7 44 24 04 d5 39 00 	movl   $0x39d5,0x4(%esp)
     5f6:	00 
     5f7:	89 04 24             	mov    %eax,(%esp)
     5fa:	e8 c1 2e 00 00       	call   34c0 <printf>
    exit();
     5ff:	e8 64 2d 00 00       	call   3368 <exit>
  // failed allocation?
  sbrk(-(sbrk(0) - oldbrk));
  int pids[32];
  int fds[2];
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
     604:	c7 44 24 04 c6 39 00 	movl   $0x39c6,0x4(%esp)
     60b:	00 
     60c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     613:	e8 a8 2e 00 00       	call   34c0 <printf>
    exit();
     618:	e8 4b 2d 00 00       	call   3368 <exit>
    if(pid < 0){
      printf(stdout, "fork failed\n");
      exit();
    }
    if(pid == 0){
      printf(stdout, "oops could read %x = %x\n", a, *a);
     61d:	0f be 03             	movsbl (%ebx),%eax
     620:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     624:	c7 44 24 04 ad 39 00 	movl   $0x39ad,0x4(%esp)
     62b:	00 
     62c:	89 44 24 0c          	mov    %eax,0xc(%esp)
     630:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
     635:	89 04 24             	mov    %eax,(%esp)
     638:	e8 83 2e 00 00       	call   34c0 <printf>
      kill(ppid);
     63d:	89 34 24             	mov    %esi,(%esp)
     640:	e8 53 2d 00 00       	call   3398 <kill>
      exit();
     645:	e8 1e 2d 00 00       	call   3368 <exit>
  // can we read the kernel's memory?
  for(a = (char*)(640*1024); a < (char *)2000000; a += 50000){
    int ppid = getpid();
    int pid = fork();
    if(pid < 0){
      printf(stdout, "fork failed\n");
     64a:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
     64f:	c7 44 24 04 69 39 00 	movl   $0x3969,0x4(%esp)
     656:	00 
     657:	89 04 24             	mov    %eax,(%esp)
     65a:	e8 61 2e 00 00       	call   34c0 <printf>
      exit();
     65f:	e8 04 2d 00 00       	call   3368 <exit>
    exit();
  }

  c = sbrk(4096);
  if(c != (char *) 0xffffffff){
    printf(stdout, "sbrk was able to re-allocate beyond 640K, c %x\n", c);
     664:	89 44 24 08          	mov    %eax,0x8(%esp)
     668:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
     66d:	c7 44 24 04 dc 47 00 	movl   $0x47dc,0x4(%esp)
     674:	00 
     675:	89 04 24             	mov    %eax,(%esp)
     678:	e8 43 2e 00 00       	call   34c0 <printf>
    exit();
     67d:	e8 e6 2c 00 00       	call   3368 <exit>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    exit();
  }
  if(*lastaddr == 99){
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
     682:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
     687:	c7 44 24 04 ac 47 00 	movl   $0x47ac,0x4(%esp)
     68e:	00 
     68f:	89 04 24             	mov    %eax,(%esp)
     692:	e8 29 2e 00 00       	call   34c0 <printf>
    exit();
     697:	e8 cc 2c 00 00       	call   3368 <exit>

  // can one re-allocate that page?
  a = sbrk(0);
  c = sbrk(4096);
  if(c != a || sbrk(0) != a + 4096){
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
     69c:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
     6a1:	89 74 24 0c          	mov    %esi,0xc(%esp)
     6a5:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     6a9:	c7 44 24 04 84 47 00 	movl   $0x4784,0x4(%esp)
     6b0:	00 
     6b1:	89 04 24             	mov    %eax,(%esp)
     6b4:	e8 07 2e 00 00       	call   34c0 <printf>
    exit();
     6b9:	e8 aa 2c 00 00       	call   3368 <exit>
    printf(stdout, "sbrk could not deallocate\n");
    exit();
  }
  c = sbrk(0);
  if(c != a - 4096){
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
     6be:	89 44 24 0c          	mov    %eax,0xc(%esp)
     6c2:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
     6c7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     6cb:	c7 44 24 04 4c 47 00 	movl   $0x474c,0x4(%esp)
     6d2:	00 
     6d3:	89 04 24             	mov    %eax,(%esp)
     6d6:	e8 e5 2d 00 00       	call   34c0 <printf>
    exit();
     6db:	e8 88 2c 00 00       	call   3368 <exit>

  // can one de-allocate?
  a = sbrk(0);
  c = sbrk(-4096);
  if(c == (char *) 0xffffffff){
    printf(stdout, "sbrk could not deallocate\n");
     6e0:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
     6e5:	c7 44 24 04 92 39 00 	movl   $0x3992,0x4(%esp)
     6ec:	00 
     6ed:	89 04 24             	mov    %eax,(%esp)
     6f0:	e8 cb 2d 00 00       	call   34c0 <printf>
    exit();
     6f5:	e8 6e 2c 00 00       	call   3368 <exit>
  *lastaddr = 99;

  // is one forbidden from allocating more than 640K?
  c = sbrk(4096);
  if(c != (char *) 0xffffffff){
    printf(stdout, "sbrk allocated more than 640K, c %x\n", c);
     6fa:	89 44 24 08          	mov    %eax,0x8(%esp)
     6fe:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
     703:	c7 44 24 04 24 47 00 	movl   $0x4724,0x4(%esp)
     70a:	00 
     70b:	89 04 24             	mov    %eax,(%esp)
     70e:	e8 ad 2d 00 00       	call   34c0 <printf>
    exit();
     713:	e8 50 2c 00 00       	call   3368 <exit>
  // can one allocate the full 640K?
  a = sbrk(0);
  uint amt = (640 * 1024) - (uint) a;
  char *p = sbrk(amt);
  if(p != a){
    printf(stdout, "sbrk test failed 640K test, p %x a %x\n", p, a);
     718:	89 44 24 08          	mov    %eax,0x8(%esp)
     71c:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
     721:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
     725:	c7 44 24 04 fc 46 00 	movl   $0x46fc,0x4(%esp)
     72c:	00 
     72d:	89 04 24             	mov    %eax,(%esp)
     730:	e8 8b 2d 00 00       	call   34c0 <printf>
    exit();
     735:	e8 2e 2c 00 00       	call   3368 <exit>
    exit();
  }
  char *c = sbrk(1);
  c = sbrk(1);
  if(c != a + 1){
    printf(stdout, "sbrk test failed post-fork\n");
     73a:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
     73f:	c7 44 24 04 76 39 00 	movl   $0x3976,0x4(%esp)
     746:	00 
     747:	89 04 24             	mov    %eax,(%esp)
     74a:	e8 71 2d 00 00       	call   34c0 <printf>
    exit();
     74f:	e8 14 2c 00 00       	call   3368 <exit>
    *b = 1;
    a = b + 1;
  }
  pid = fork();
  if(pid < 0){
    printf(stdout, "sbrk test fork failed\n");
     754:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
     759:	c7 44 24 04 5f 39 00 	movl   $0x395f,0x4(%esp)
     760:	00 
     761:	89 04 24             	mov    %eax,(%esp)
     764:	e8 57 2d 00 00       	call   34c0 <printf>
    exit();
     769:	e8 fa 2b 00 00       	call   3368 <exit>
     76e:	66 90                	xchg   %ax,%ax

00000770 <preempt>:
}

// meant to be run w/ at most two CPUs
void
preempt(void)
{
     770:	55                   	push   %ebp
     771:	89 e5                	mov    %esp,%ebp
     773:	57                   	push   %edi
     774:	56                   	push   %esi
     775:	53                   	push   %ebx
     776:	83 ec 2c             	sub    $0x2c,%esp
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
     779:	c7 44 24 04 fe 39 00 	movl   $0x39fe,0x4(%esp)
     780:	00 
     781:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     788:	e8 33 2d 00 00       	call   34c0 <printf>
  pid1 = fork();
     78d:	e8 ce 2b 00 00       	call   3360 <fork>
  if(pid1 == 0)
     792:	85 c0                	test   %eax,%eax
{
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
  pid1 = fork();
     794:	89 c7                	mov    %eax,%edi
  if(pid1 == 0)
     796:	75 02                	jne    79a <preempt+0x2a>
     798:	eb fe                	jmp    798 <preempt+0x28>
     79a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for(;;)
      ;

  pid2 = fork();
     7a0:	e8 bb 2b 00 00       	call   3360 <fork>
  if(pid2 == 0)
     7a5:	85 c0                	test   %eax,%eax
  pid1 = fork();
  if(pid1 == 0)
    for(;;)
      ;

  pid2 = fork();
     7a7:	89 c6                	mov    %eax,%esi
  if(pid2 == 0)
     7a9:	75 02                	jne    7ad <preempt+0x3d>
     7ab:	eb fe                	jmp    7ab <preempt+0x3b>
    for(;;)
      ;

  pipe(pfds);
     7ad:	8d 45 e0             	lea    -0x20(%ebp),%eax
     7b0:	89 04 24             	mov    %eax,(%esp)
     7b3:	e8 c0 2b 00 00       	call   3378 <pipe>
  pid3 = fork();
     7b8:	e8 a3 2b 00 00       	call   3360 <fork>
  if(pid3 == 0){
     7bd:	85 c0                	test   %eax,%eax
  if(pid2 == 0)
    for(;;)
      ;

  pipe(pfds);
  pid3 = fork();
     7bf:	89 c3                	mov    %eax,%ebx
  if(pid3 == 0){
     7c1:	75 4c                	jne    80f <preempt+0x9f>
    close(pfds[0]);
     7c3:	8b 45 e0             	mov    -0x20(%ebp),%eax
     7c6:	89 04 24             	mov    %eax,(%esp)
     7c9:	e8 c2 2b 00 00       	call   3390 <close>
    if(write(pfds[1], "x", 1) != 1)
     7ce:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     7d1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     7d8:	00 
     7d9:	c7 44 24 04 02 3f 00 	movl   $0x3f02,0x4(%esp)
     7e0:	00 
     7e1:	89 04 24             	mov    %eax,(%esp)
     7e4:	e8 9f 2b 00 00       	call   3388 <write>
     7e9:	83 f8 01             	cmp    $0x1,%eax
     7ec:	74 14                	je     802 <preempt+0x92>
      printf(1, "preempt write error");
     7ee:	c7 44 24 04 08 3a 00 	movl   $0x3a08,0x4(%esp)
     7f5:	00 
     7f6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     7fd:	e8 be 2c 00 00       	call   34c0 <printf>
    close(pfds[1]);
     802:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     805:	89 04 24             	mov    %eax,(%esp)
     808:	e8 83 2b 00 00       	call   3390 <close>
     80d:	eb fe                	jmp    80d <preempt+0x9d>
    for(;;)
      ;
  }

  close(pfds[1]);
     80f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     812:	89 04 24             	mov    %eax,(%esp)
     815:	e8 76 2b 00 00       	call   3390 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     81a:	8b 45 e0             	mov    -0x20(%ebp),%eax
     81d:	c7 44 24 08 00 08 00 	movl   $0x800,0x8(%esp)
     824:	00 
     825:	c7 44 24 04 a0 4d 00 	movl   $0x4da0,0x4(%esp)
     82c:	00 
     82d:	89 04 24             	mov    %eax,(%esp)
     830:	e8 4b 2b 00 00       	call   3380 <read>
     835:	83 f8 01             	cmp    $0x1,%eax
     838:	74 1c                	je     856 <preempt+0xe6>
    printf(1, "preempt read error");
     83a:	c7 44 24 04 1c 3a 00 	movl   $0x3a1c,0x4(%esp)
     841:	00 
     842:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     849:	e8 72 2c 00 00       	call   34c0 <printf>
  printf(1, "wait... ");
  wait();
  wait();
  wait();
  printf(1, "preempt ok\n");
}
     84e:	83 c4 2c             	add    $0x2c,%esp
     851:	5b                   	pop    %ebx
     852:	5e                   	pop    %esi
     853:	5f                   	pop    %edi
     854:	5d                   	pop    %ebp
     855:	c3                   	ret    
  close(pfds[1]);
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    printf(1, "preempt read error");
    return;
  }
  close(pfds[0]);
     856:	8b 45 e0             	mov    -0x20(%ebp),%eax
     859:	89 04 24             	mov    %eax,(%esp)
     85c:	e8 2f 2b 00 00       	call   3390 <close>
  printf(1, "kill... ");
     861:	c7 44 24 04 2f 3a 00 	movl   $0x3a2f,0x4(%esp)
     868:	00 
     869:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     870:	e8 4b 2c 00 00       	call   34c0 <printf>
  kill(pid1);
     875:	89 3c 24             	mov    %edi,(%esp)
     878:	e8 1b 2b 00 00       	call   3398 <kill>
  kill(pid2);
     87d:	89 34 24             	mov    %esi,(%esp)
     880:	e8 13 2b 00 00       	call   3398 <kill>
  kill(pid3);
     885:	89 1c 24             	mov    %ebx,(%esp)
     888:	e8 0b 2b 00 00       	call   3398 <kill>
  printf(1, "wait... ");
     88d:	c7 44 24 04 38 3a 00 	movl   $0x3a38,0x4(%esp)
     894:	00 
     895:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     89c:	e8 1f 2c 00 00       	call   34c0 <printf>
  wait();
     8a1:	e8 ca 2a 00 00       	call   3370 <wait>
  wait();
     8a6:	e8 c5 2a 00 00       	call   3370 <wait>
     8ab:	90                   	nop
     8ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  wait();
     8b0:	e8 bb 2a 00 00       	call   3370 <wait>
  printf(1, "preempt ok\n");
     8b5:	c7 44 24 04 41 3a 00 	movl   $0x3a41,0x4(%esp)
     8bc:	00 
     8bd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     8c4:	e8 f7 2b 00 00       	call   34c0 <printf>
     8c9:	eb 83                	jmp    84e <preempt+0xde>
     8cb:	90                   	nop
     8cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000008d0 <pipe1>:

// simple fork and pipe read/write

void
pipe1(void)
{
     8d0:	55                   	push   %ebp
     8d1:	89 e5                	mov    %esp,%ebp
     8d3:	57                   	push   %edi
     8d4:	56                   	push   %esi
     8d5:	53                   	push   %ebx
     8d6:	83 ec 2c             	sub    $0x2c,%esp
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
     8d9:	8d 45 e0             	lea    -0x20(%ebp),%eax
     8dc:	89 04 24             	mov    %eax,(%esp)
     8df:	e8 94 2a 00 00       	call   3378 <pipe>
     8e4:	85 c0                	test   %eax,%eax
     8e6:	0f 85 53 01 00 00    	jne    a3f <pipe1+0x16f>
    printf(1, "pipe() failed\n");
    exit();
  }
  pid = fork();
     8ec:	e8 6f 2a 00 00       	call   3360 <fork>
  seq = 0;
  if(pid == 0){
     8f1:	83 f8 00             	cmp    $0x0,%eax
     8f4:	0f 84 87 00 00 00    	je     981 <pipe1+0xb1>
     8fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printf(1, "pipe1 oops 1\n");
        exit();
      }
    }
    exit();
  } else if(pid > 0){
     900:	0f 8e 52 01 00 00    	jle    a58 <pipe1+0x188>
    close(fds[1]);
     906:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     909:	31 ff                	xor    %edi,%edi
     90b:	be 01 00 00 00       	mov    $0x1,%esi
     910:	31 db                	xor    %ebx,%ebx
     912:	89 04 24             	mov    %eax,(%esp)
     915:	e8 76 2a 00 00       	call   3390 <close>
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
     91a:	8b 45 e0             	mov    -0x20(%ebp),%eax
     91d:	89 74 24 08          	mov    %esi,0x8(%esp)
     921:	c7 44 24 04 a0 4d 00 	movl   $0x4da0,0x4(%esp)
     928:	00 
     929:	89 04 24             	mov    %eax,(%esp)
     92c:	e8 4f 2a 00 00       	call   3380 <read>
     931:	85 c0                	test   %eax,%eax
     933:	0f 8e a4 00 00 00    	jle    9dd <pipe1+0x10d>
     939:	31 d2                	xor    %edx,%edx
     93b:	90                   	nop
     93c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(i = 0; i < n; i++){
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     940:	38 9a a0 4d 00 00    	cmp    %bl,0x4da0(%edx)
     946:	75 1d                	jne    965 <pipe1+0x95>
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
     948:	83 c2 01             	add    $0x1,%edx
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     94b:	83 c3 01             	add    $0x1,%ebx
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
     94e:	39 d0                	cmp    %edx,%eax
     950:	7f ee                	jg     940 <pipe1+0x70>
          printf(1, "pipe1 oops 2\n");
          return;
        }
      }
      total += n;
      cc = cc * 2;
     952:	01 f6                	add    %esi,%esi
      if(cc > sizeof(buf))
     954:	81 fe 00 08 00 00    	cmp    $0x800,%esi
     95a:	76 05                	jbe    961 <pipe1+0x91>
     95c:	be 00 08 00 00       	mov    $0x800,%esi
        if((buf[i] & 0xff) != (seq++ & 0xff)){
          printf(1, "pipe1 oops 2\n");
          return;
        }
      }
      total += n;
     961:	01 c7                	add    %eax,%edi
     963:	eb b5                	jmp    91a <pipe1+0x4a>
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
        if((buf[i] & 0xff) != (seq++ & 0xff)){
          printf(1, "pipe1 oops 2\n");
     965:	c7 44 24 04 5b 3a 00 	movl   $0x3a5b,0x4(%esp)
     96c:	00 
     96d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     974:	e8 47 2b 00 00       	call   34c0 <printf>
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
}
     979:	83 c4 2c             	add    $0x2c,%esp
     97c:	5b                   	pop    %ebx
     97d:	5e                   	pop    %esi
     97e:	5f                   	pop    %edi
     97f:	5d                   	pop    %ebp
     980:	c3                   	ret    
    exit();
  }
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
     981:	8b 45 e0             	mov    -0x20(%ebp),%eax
     984:	31 db                	xor    %ebx,%ebx
     986:	89 04 24             	mov    %eax,(%esp)
     989:	e8 02 2a 00 00       	call   3390 <close>
    for(n = 0; n < 5; n++){
     98e:	31 c0                	xor    %eax,%eax
      for(i = 0; i < 1033; i++)
        buf[i] = seq++;
     990:	8d 14 18             	lea    (%eax,%ebx,1),%edx
     993:	88 90 a0 4d 00 00    	mov    %dl,0x4da0(%eax)
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
     999:	83 c0 01             	add    $0x1,%eax
     99c:	3d 09 04 00 00       	cmp    $0x409,%eax
     9a1:	75 ed                	jne    990 <pipe1+0xc0>
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
     9a3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
     9a6:	81 c3 09 04 00 00    	add    $0x409,%ebx
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
     9ac:	c7 44 24 08 09 04 00 	movl   $0x409,0x8(%esp)
     9b3:	00 
     9b4:	c7 44 24 04 a0 4d 00 	movl   $0x4da0,0x4(%esp)
     9bb:	00 
     9bc:	89 04 24             	mov    %eax,(%esp)
     9bf:	e8 c4 29 00 00       	call   3388 <write>
     9c4:	3d 09 04 00 00       	cmp    $0x409,%eax
     9c9:	75 5b                	jne    a26 <pipe1+0x156>
  }
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
     9cb:	81 fb 2d 14 00 00    	cmp    $0x142d,%ebx
     9d1:	75 bb                	jne    98e <pipe1+0xbe>
     9d3:	90                   	nop
     9d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      printf(1, "pipe1 oops 3 total %d\n", total);
    close(fds[0]);
    wait();
  } else {
    printf(1, "fork() failed\n");
    exit();
     9d8:	e8 8b 29 00 00       	call   3368 <exit>
      total += n;
      cc = cc * 2;
      if(cc > sizeof(buf))
        cc = sizeof(buf);
    }
    if(total != 5 * 1033)
     9dd:	81 ff 2d 14 00 00    	cmp    $0x142d,%edi
     9e3:	74 18                	je     9fd <pipe1+0x12d>
      printf(1, "pipe1 oops 3 total %d\n", total);
     9e5:	89 7c 24 08          	mov    %edi,0x8(%esp)
     9e9:	c7 44 24 04 69 3a 00 	movl   $0x3a69,0x4(%esp)
     9f0:	00 
     9f1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     9f8:	e8 c3 2a 00 00       	call   34c0 <printf>
    close(fds[0]);
     9fd:	8b 45 e0             	mov    -0x20(%ebp),%eax
     a00:	89 04 24             	mov    %eax,(%esp)
     a03:	e8 88 29 00 00       	call   3390 <close>
    wait();
     a08:	e8 63 29 00 00       	call   3370 <wait>
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
     a0d:	c7 44 24 04 80 3a 00 	movl   $0x3a80,0x4(%esp)
     a14:	00 
     a15:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     a1c:	e8 9f 2a 00 00       	call   34c0 <printf>
     a21:	e9 53 ff ff ff       	jmp    979 <pipe1+0xa9>
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
        printf(1, "pipe1 oops 1\n");
     a26:	c7 44 24 04 4d 3a 00 	movl   $0x3a4d,0x4(%esp)
     a2d:	00 
     a2e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     a35:	e8 86 2a 00 00       	call   34c0 <printf>
        exit();
     a3a:	e8 29 29 00 00       	call   3368 <exit>
{
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
     a3f:	c7 44 24 04 c6 39 00 	movl   $0x39c6,0x4(%esp)
     a46:	00 
     a47:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     a4e:	e8 6d 2a 00 00       	call   34c0 <printf>
    exit();
     a53:	e8 10 29 00 00       	call   3368 <exit>
    if(total != 5 * 1033)
      printf(1, "pipe1 oops 3 total %d\n", total);
    close(fds[0]);
    wait();
  } else {
    printf(1, "fork() failed\n");
     a58:	c7 44 24 04 8a 3a 00 	movl   $0x3a8a,0x4(%esp)
     a5f:	00 
     a60:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     a67:	e8 54 2a 00 00       	call   34c0 <printf>
     a6c:	e9 62 ff ff ff       	jmp    9d3 <pipe1+0x103>
     a71:	eb 0d                	jmp    a80 <fourteen>
     a73:	90                   	nop
     a74:	90                   	nop
     a75:	90                   	nop
     a76:	90                   	nop
     a77:	90                   	nop
     a78:	90                   	nop
     a79:	90                   	nop
     a7a:	90                   	nop
     a7b:	90                   	nop
     a7c:	90                   	nop
     a7d:	90                   	nop
     a7e:	90                   	nop
     a7f:	90                   	nop

00000a80 <fourteen>:
  printf(1, "bigfile test ok\n");
}

void
fourteen(void)
{
     a80:	55                   	push   %ebp
     a81:	89 e5                	mov    %esp,%ebp
     a83:	83 ec 18             	sub    $0x18,%esp
  int fd;

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");
     a86:	c7 44 24 04 99 3a 00 	movl   $0x3a99,0x4(%esp)
     a8d:	00 
     a8e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     a95:	e8 26 2a 00 00       	call   34c0 <printf>

  if(mkdir("12345678901234") != 0){
     a9a:	c7 04 24 d4 3a 00 00 	movl   $0x3ad4,(%esp)
     aa1:	e8 2a 29 00 00       	call   33d0 <mkdir>
     aa6:	85 c0                	test   %eax,%eax
     aa8:	0f 85 92 00 00 00    	jne    b40 <fourteen+0xc0>
    printf(1, "mkdir 12345678901234 failed\n");
    exit();
  }
  if(mkdir("12345678901234/123456789012345") != 0){
     aae:	c7 04 24 0c 48 00 00 	movl   $0x480c,(%esp)
     ab5:	e8 16 29 00 00       	call   33d0 <mkdir>
     aba:	85 c0                	test   %eax,%eax
     abc:	0f 85 fb 00 00 00    	jne    bbd <fourteen+0x13d>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    exit();
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
     ac2:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
     ac9:	00 
     aca:	c7 04 24 5c 48 00 00 	movl   $0x485c,(%esp)
     ad1:	e8 d2 28 00 00       	call   33a8 <open>
  if(fd < 0){
     ad6:	85 c0                	test   %eax,%eax
     ad8:	0f 88 c6 00 00 00    	js     ba4 <fourteen+0x124>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    exit();
  }
  close(fd);
     ade:	89 04 24             	mov    %eax,(%esp)
     ae1:	e8 aa 28 00 00       	call   3390 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
     ae6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     aed:	00 
     aee:	c7 04 24 cc 48 00 00 	movl   $0x48cc,(%esp)
     af5:	e8 ae 28 00 00       	call   33a8 <open>
  if(fd < 0){
     afa:	85 c0                	test   %eax,%eax
     afc:	0f 88 89 00 00 00    	js     b8b <fourteen+0x10b>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    exit();
  }
  close(fd);
     b02:	89 04 24             	mov    %eax,(%esp)
     b05:	e8 86 28 00 00       	call   3390 <close>

  if(mkdir("12345678901234/12345678901234") == 0){
     b0a:	c7 04 24 c5 3a 00 00 	movl   $0x3ac5,(%esp)
     b11:	e8 ba 28 00 00       	call   33d0 <mkdir>
     b16:	85 c0                	test   %eax,%eax
     b18:	74 58                	je     b72 <fourteen+0xf2>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    exit();
  }
  if(mkdir("123456789012345/12345678901234") == 0){
     b1a:	c7 04 24 68 49 00 00 	movl   $0x4968,(%esp)
     b21:	e8 aa 28 00 00       	call   33d0 <mkdir>
     b26:	85 c0                	test   %eax,%eax
     b28:	74 2f                	je     b59 <fourteen+0xd9>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    exit();
  }

  printf(1, "fourteen ok\n");
     b2a:	c7 44 24 04 e3 3a 00 	movl   $0x3ae3,0x4(%esp)
     b31:	00 
     b32:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b39:	e8 82 29 00 00       	call   34c0 <printf>
}
     b3e:	c9                   	leave  
     b3f:	c3                   	ret    

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");

  if(mkdir("12345678901234") != 0){
    printf(1, "mkdir 12345678901234 failed\n");
     b40:	c7 44 24 04 a8 3a 00 	movl   $0x3aa8,0x4(%esp)
     b47:	00 
     b48:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b4f:	e8 6c 29 00 00       	call   34c0 <printf>
    exit();
     b54:	e8 0f 28 00 00       	call   3368 <exit>
  if(mkdir("12345678901234/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    exit();
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
     b59:	c7 44 24 04 88 49 00 	movl   $0x4988,0x4(%esp)
     b60:	00 
     b61:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b68:	e8 53 29 00 00       	call   34c0 <printf>
    exit();
     b6d:	e8 f6 27 00 00       	call   3368 <exit>
    exit();
  }
  close(fd);

  if(mkdir("12345678901234/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
     b72:	c7 44 24 04 38 49 00 	movl   $0x4938,0x4(%esp)
     b79:	00 
     b7a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b81:	e8 3a 29 00 00       	call   34c0 <printf>
    exit();
     b86:	e8 dd 27 00 00       	call   3368 <exit>
    exit();
  }
  close(fd);
  fd = open("12345678901234/12345678901234/12345678901234", 0);
  if(fd < 0){
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
     b8b:	c7 44 24 04 fc 48 00 	movl   $0x48fc,0x4(%esp)
     b92:	00 
     b93:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b9a:	e8 21 29 00 00       	call   34c0 <printf>
    exit();
     b9f:	e8 c4 27 00 00       	call   3368 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    exit();
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
  if(fd < 0){
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
     ba4:	c7 44 24 04 8c 48 00 	movl   $0x488c,0x4(%esp)
     bab:	00 
     bac:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     bb3:	e8 08 29 00 00       	call   34c0 <printf>
    exit();
     bb8:	e8 ab 27 00 00       	call   3368 <exit>
  if(mkdir("12345678901234") != 0){
    printf(1, "mkdir 12345678901234 failed\n");
    exit();
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
     bbd:	c7 44 24 04 2c 48 00 	movl   $0x482c,0x4(%esp)
     bc4:	00 
     bc5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     bcc:	e8 ef 28 00 00       	call   34c0 <printf>
    exit();
     bd1:	e8 92 27 00 00       	call   3368 <exit>
     bd6:	8d 76 00             	lea    0x0(%esi),%esi
     bd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000be0 <iref>:
}

// test that iput() is called at the end of _namei()
void
iref(void)
{
     be0:	55                   	push   %ebp
     be1:	89 e5                	mov    %esp,%ebp
     be3:	53                   	push   %ebx
  int i, fd;

  printf(1, "empty file name\n");
     be4:	31 db                	xor    %ebx,%ebx
}

// test that iput() is called at the end of _namei()
void
iref(void)
{
     be6:	83 ec 14             	sub    $0x14,%esp
  int i, fd;

  printf(1, "empty file name\n");
     be9:	c7 44 24 04 f0 3a 00 	movl   $0x3af0,0x4(%esp)
     bf0:	00 
     bf1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     bf8:	e8 c3 28 00 00       	call   34c0 <printf>
     bfd:	8d 76 00             	lea    0x0(%esi),%esi

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    if(mkdir("irefd") != 0){
     c00:	c7 04 24 01 3b 00 00 	movl   $0x3b01,(%esp)
     c07:	e8 c4 27 00 00       	call   33d0 <mkdir>
     c0c:	85 c0                	test   %eax,%eax
     c0e:	0f 85 b2 00 00 00    	jne    cc6 <iref+0xe6>
      printf(1, "mkdir irefd failed\n");
      exit();
    }
    if(chdir("irefd") != 0){
     c14:	c7 04 24 01 3b 00 00 	movl   $0x3b01,(%esp)
     c1b:	e8 b8 27 00 00       	call   33d8 <chdir>
     c20:	85 c0                	test   %eax,%eax
     c22:	0f 85 b7 00 00 00    	jne    cdf <iref+0xff>
      printf(1, "chdir irefd failed\n");
      exit();
    }

    mkdir("");
     c28:	c7 04 24 bc 45 00 00 	movl   $0x45bc,(%esp)
     c2f:	e8 9c 27 00 00       	call   33d0 <mkdir>
    link("README", "");
     c34:	c7 44 24 04 bc 45 00 	movl   $0x45bc,0x4(%esp)
     c3b:	00 
     c3c:	c7 04 24 2f 3b 00 00 	movl   $0x3b2f,(%esp)
     c43:	e8 80 27 00 00       	call   33c8 <link>
    fd = open("", O_CREATE);
     c48:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
     c4f:	00 
     c50:	c7 04 24 bc 45 00 00 	movl   $0x45bc,(%esp)
     c57:	e8 4c 27 00 00       	call   33a8 <open>
    if(fd >= 0)
     c5c:	85 c0                	test   %eax,%eax
     c5e:	78 08                	js     c68 <iref+0x88>
      close(fd);
     c60:	89 04 24             	mov    %eax,(%esp)
     c63:	e8 28 27 00 00       	call   3390 <close>
    fd = open("xx", O_CREATE);
     c68:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
     c6f:	00 
     c70:	c7 04 24 01 3f 00 00 	movl   $0x3f01,(%esp)
     c77:	e8 2c 27 00 00       	call   33a8 <open>
    if(fd >= 0)
     c7c:	85 c0                	test   %eax,%eax
     c7e:	78 08                	js     c88 <iref+0xa8>
      close(fd);
     c80:	89 04 24             	mov    %eax,(%esp)
     c83:	e8 08 27 00 00       	call   3390 <close>
  int i, fd;

  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
     c88:	83 c3 01             	add    $0x1,%ebx
    if(fd >= 0)
      close(fd);
    fd = open("xx", O_CREATE);
    if(fd >= 0)
      close(fd);
    unlink("xx");
     c8b:	c7 04 24 01 3f 00 00 	movl   $0x3f01,(%esp)
     c92:	e8 21 27 00 00       	call   33b8 <unlink>
  int i, fd;

  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
     c97:	83 fb 33             	cmp    $0x33,%ebx
     c9a:	0f 85 60 ff ff ff    	jne    c00 <iref+0x20>
    if(fd >= 0)
      close(fd);
    unlink("xx");
  }

  chdir("/");
     ca0:	c7 04 24 36 3b 00 00 	movl   $0x3b36,(%esp)
     ca7:	e8 2c 27 00 00       	call   33d8 <chdir>
  printf(1, "empty file name OK\n");
     cac:	c7 44 24 04 38 3b 00 	movl   $0x3b38,0x4(%esp)
     cb3:	00 
     cb4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     cbb:	e8 00 28 00 00       	call   34c0 <printf>
}
     cc0:	83 c4 14             	add    $0x14,%esp
     cc3:	5b                   	pop    %ebx
     cc4:	5d                   	pop    %ebp
     cc5:	c3                   	ret    
  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    if(mkdir("irefd") != 0){
      printf(1, "mkdir irefd failed\n");
     cc6:	c7 44 24 04 07 3b 00 	movl   $0x3b07,0x4(%esp)
     ccd:	00 
     cce:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     cd5:	e8 e6 27 00 00       	call   34c0 <printf>
      exit();
     cda:	e8 89 26 00 00       	call   3368 <exit>
    }
    if(chdir("irefd") != 0){
      printf(1, "chdir irefd failed\n");
     cdf:	c7 44 24 04 1b 3b 00 	movl   $0x3b1b,0x4(%esp)
     ce6:	00 
     ce7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     cee:	e8 cd 27 00 00       	call   34c0 <printf>
      exit();
     cf3:	e8 70 26 00 00       	call   3368 <exit>
     cf8:	90                   	nop
     cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000d00 <dirfile>:
  printf(1, "rmdot ok\n");
}

void
dirfile(void)
{
     d00:	55                   	push   %ebp
     d01:	89 e5                	mov    %esp,%ebp
     d03:	53                   	push   %ebx
     d04:	83 ec 14             	sub    $0x14,%esp
  int fd;

  printf(1, "dir vs file\n");
     d07:	c7 44 24 04 4c 3b 00 	movl   $0x3b4c,0x4(%esp)
     d0e:	00 
     d0f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d16:	e8 a5 27 00 00       	call   34c0 <printf>

  fd = open("dirfile", O_CREATE);
     d1b:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
     d22:	00 
     d23:	c7 04 24 59 3b 00 00 	movl   $0x3b59,(%esp)
     d2a:	e8 79 26 00 00       	call   33a8 <open>
  if(fd < 0){
     d2f:	85 c0                	test   %eax,%eax
     d31:	0f 88 4e 01 00 00    	js     e85 <dirfile+0x185>
    printf(1, "create dirfile failed\n");
    exit();
  }
  close(fd);
     d37:	89 04 24             	mov    %eax,(%esp)
     d3a:	e8 51 26 00 00       	call   3390 <close>
  if(chdir("dirfile") == 0){
     d3f:	c7 04 24 59 3b 00 00 	movl   $0x3b59,(%esp)
     d46:	e8 8d 26 00 00       	call   33d8 <chdir>
     d4b:	85 c0                	test   %eax,%eax
     d4d:	0f 84 19 01 00 00    	je     e6c <dirfile+0x16c>
    printf(1, "chdir dirfile succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", 0);
     d53:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     d5a:	00 
     d5b:	c7 04 24 92 3b 00 00 	movl   $0x3b92,(%esp)
     d62:	e8 41 26 00 00       	call   33a8 <open>
  if(fd >= 0){
     d67:	85 c0                	test   %eax,%eax
     d69:	0f 89 e4 00 00 00    	jns    e53 <dirfile+0x153>
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", O_CREATE);
     d6f:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
     d76:	00 
     d77:	c7 04 24 92 3b 00 00 	movl   $0x3b92,(%esp)
     d7e:	e8 25 26 00 00       	call   33a8 <open>
  if(fd >= 0){
     d83:	85 c0                	test   %eax,%eax
     d85:	0f 89 c8 00 00 00    	jns    e53 <dirfile+0x153>
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  if(mkdir("dirfile/xx") == 0){
     d8b:	c7 04 24 92 3b 00 00 	movl   $0x3b92,(%esp)
     d92:	e8 39 26 00 00       	call   33d0 <mkdir>
     d97:	85 c0                	test   %eax,%eax
     d99:	0f 84 7c 01 00 00    	je     f1b <dirfile+0x21b>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile/xx") == 0){
     d9f:	c7 04 24 92 3b 00 00 	movl   $0x3b92,(%esp)
     da6:	e8 0d 26 00 00       	call   33b8 <unlink>
     dab:	85 c0                	test   %eax,%eax
     dad:	0f 84 4f 01 00 00    	je     f02 <dirfile+0x202>
    printf(1, "unlink dirfile/xx succeeded!\n");
    exit();
  }
  if(link("README", "dirfile/xx") == 0){
     db3:	c7 44 24 04 92 3b 00 	movl   $0x3b92,0x4(%esp)
     dba:	00 
     dbb:	c7 04 24 2f 3b 00 00 	movl   $0x3b2f,(%esp)
     dc2:	e8 01 26 00 00       	call   33c8 <link>
     dc7:	85 c0                	test   %eax,%eax
     dc9:	0f 84 1a 01 00 00    	je     ee9 <dirfile+0x1e9>
    printf(1, "link to dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile") != 0){
     dcf:	c7 04 24 59 3b 00 00 	movl   $0x3b59,(%esp)
     dd6:	e8 dd 25 00 00       	call   33b8 <unlink>
     ddb:	85 c0                	test   %eax,%eax
     ddd:	0f 85 ed 00 00 00    	jne    ed0 <dirfile+0x1d0>
    printf(1, "unlink dirfile failed!\n");
    exit();
  }

  fd = open(".", O_RDWR);
     de3:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
     dea:	00 
     deb:	c7 04 24 1f 3e 00 00 	movl   $0x3e1f,(%esp)
     df2:	e8 b1 25 00 00       	call   33a8 <open>
  if(fd >= 0){
     df7:	85 c0                	test   %eax,%eax
     df9:	0f 89 b8 00 00 00    	jns    eb7 <dirfile+0x1b7>
    printf(1, "open . for writing succeeded!\n");
    exit();
  }
  fd = open(".", 0);
     dff:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     e06:	00 
     e07:	c7 04 24 1f 3e 00 00 	movl   $0x3e1f,(%esp)
     e0e:	e8 95 25 00 00       	call   33a8 <open>
  if(write(fd, "x", 1) > 0){
     e13:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     e1a:	00 
     e1b:	c7 44 24 04 02 3f 00 	movl   $0x3f02,0x4(%esp)
     e22:	00 
  fd = open(".", O_RDWR);
  if(fd >= 0){
    printf(1, "open . for writing succeeded!\n");
    exit();
  }
  fd = open(".", 0);
     e23:	89 c3                	mov    %eax,%ebx
  if(write(fd, "x", 1) > 0){
     e25:	89 04 24             	mov    %eax,(%esp)
     e28:	e8 5b 25 00 00       	call   3388 <write>
     e2d:	85 c0                	test   %eax,%eax
     e2f:	7f 6d                	jg     e9e <dirfile+0x19e>
    printf(1, "write . succeeded!\n");
    exit();
  }
  close(fd);
     e31:	89 1c 24             	mov    %ebx,(%esp)
     e34:	e8 57 25 00 00       	call   3390 <close>

  printf(1, "dir vs file OK\n");
     e39:	c7 44 24 04 22 3c 00 	movl   $0x3c22,0x4(%esp)
     e40:	00 
     e41:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e48:	e8 73 26 00 00       	call   34c0 <printf>
}
     e4d:	83 c4 14             	add    $0x14,%esp
     e50:	5b                   	pop    %ebx
     e51:	5d                   	pop    %ebp
     e52:	c3                   	ret    
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", O_CREATE);
  if(fd >= 0){
    printf(1, "create dirfile/xx succeeded!\n");
     e53:	c7 44 24 04 9d 3b 00 	movl   $0x3b9d,0x4(%esp)
     e5a:	00 
     e5b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e62:	e8 59 26 00 00       	call   34c0 <printf>
    exit();
     e67:	e8 fc 24 00 00       	call   3368 <exit>
    printf(1, "create dirfile failed\n");
    exit();
  }
  close(fd);
  if(chdir("dirfile") == 0){
    printf(1, "chdir dirfile succeeded!\n");
     e6c:	c7 44 24 04 78 3b 00 	movl   $0x3b78,0x4(%esp)
     e73:	00 
     e74:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e7b:	e8 40 26 00 00       	call   34c0 <printf>
    exit();
     e80:	e8 e3 24 00 00       	call   3368 <exit>

  printf(1, "dir vs file\n");

  fd = open("dirfile", O_CREATE);
  if(fd < 0){
    printf(1, "create dirfile failed\n");
     e85:	c7 44 24 04 61 3b 00 	movl   $0x3b61,0x4(%esp)
     e8c:	00 
     e8d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e94:	e8 27 26 00 00       	call   34c0 <printf>
    exit();
     e99:	e8 ca 24 00 00       	call   3368 <exit>
    printf(1, "open . for writing succeeded!\n");
    exit();
  }
  fd = open(".", 0);
  if(write(fd, "x", 1) > 0){
    printf(1, "write . succeeded!\n");
     e9e:	c7 44 24 04 0e 3c 00 	movl   $0x3c0e,0x4(%esp)
     ea5:	00 
     ea6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     ead:	e8 0e 26 00 00       	call   34c0 <printf>
    exit();
     eb2:	e8 b1 24 00 00       	call   3368 <exit>
    exit();
  }

  fd = open(".", O_RDWR);
  if(fd >= 0){
    printf(1, "open . for writing succeeded!\n");
     eb7:	c7 44 24 04 dc 49 00 	movl   $0x49dc,0x4(%esp)
     ebe:	00 
     ebf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     ec6:	e8 f5 25 00 00       	call   34c0 <printf>
    exit();
     ecb:	e8 98 24 00 00       	call   3368 <exit>
  if(link("README", "dirfile/xx") == 0){
    printf(1, "link to dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile") != 0){
    printf(1, "unlink dirfile failed!\n");
     ed0:	c7 44 24 04 f6 3b 00 	movl   $0x3bf6,0x4(%esp)
     ed7:	00 
     ed8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     edf:	e8 dc 25 00 00       	call   34c0 <printf>
    exit();
     ee4:	e8 7f 24 00 00       	call   3368 <exit>
  if(unlink("dirfile/xx") == 0){
    printf(1, "unlink dirfile/xx succeeded!\n");
    exit();
  }
  if(link("README", "dirfile/xx") == 0){
    printf(1, "link to dirfile/xx succeeded!\n");
     ee9:	c7 44 24 04 bc 49 00 	movl   $0x49bc,0x4(%esp)
     ef0:	00 
     ef1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     ef8:	e8 c3 25 00 00       	call   34c0 <printf>
    exit();
     efd:	e8 66 24 00 00       	call   3368 <exit>
  if(mkdir("dirfile/xx") == 0){
    printf(1, "mkdir dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile/xx") == 0){
    printf(1, "unlink dirfile/xx succeeded!\n");
     f02:	c7 44 24 04 d8 3b 00 	movl   $0x3bd8,0x4(%esp)
     f09:	00 
     f0a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f11:	e8 aa 25 00 00       	call   34c0 <printf>
    exit();
     f16:	e8 4d 24 00 00       	call   3368 <exit>
  if(fd >= 0){
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  if(mkdir("dirfile/xx") == 0){
    printf(1, "mkdir dirfile/xx succeeded!\n");
     f1b:	c7 44 24 04 bb 3b 00 	movl   $0x3bbb,0x4(%esp)
     f22:	00 
     f23:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f2a:	e8 91 25 00 00       	call   34c0 <printf>
    exit();
     f2f:	e8 34 24 00 00       	call   3368 <exit>
     f34:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     f3a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000f40 <rmdot>:
  printf(1, "fourteen ok\n");
}

void
rmdot(void)
{
     f40:	55                   	push   %ebp
     f41:	89 e5                	mov    %esp,%ebp
     f43:	83 ec 18             	sub    $0x18,%esp
  printf(1, "rmdot test\n");
     f46:	c7 44 24 04 32 3c 00 	movl   $0x3c32,0x4(%esp)
     f4d:	00 
     f4e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f55:	e8 66 25 00 00       	call   34c0 <printf>
  if(mkdir("dots") != 0){
     f5a:	c7 04 24 3e 3c 00 00 	movl   $0x3c3e,(%esp)
     f61:	e8 6a 24 00 00       	call   33d0 <mkdir>
     f66:	85 c0                	test   %eax,%eax
     f68:	0f 85 9a 00 00 00    	jne    1008 <rmdot+0xc8>
    printf(1, "mkdir dots failed\n");
    exit();
  }
  if(chdir("dots") != 0){
     f6e:	c7 04 24 3e 3c 00 00 	movl   $0x3c3e,(%esp)
     f75:	e8 5e 24 00 00       	call   33d8 <chdir>
     f7a:	85 c0                	test   %eax,%eax
     f7c:	0f 85 35 01 00 00    	jne    10b7 <rmdot+0x177>
    printf(1, "chdir dots failed\n");
    exit();
  }
  if(unlink(".") == 0){
     f82:	c7 04 24 1f 3e 00 00 	movl   $0x3e1f,(%esp)
     f89:	e8 2a 24 00 00       	call   33b8 <unlink>
     f8e:	85 c0                	test   %eax,%eax
     f90:	0f 84 08 01 00 00    	je     109e <rmdot+0x15e>
    printf(1, "rm . worked!\n");
    exit();
  }
  if(unlink("..") == 0){
     f96:	c7 04 24 1e 3e 00 00 	movl   $0x3e1e,(%esp)
     f9d:	e8 16 24 00 00       	call   33b8 <unlink>
     fa2:	85 c0                	test   %eax,%eax
     fa4:	0f 84 db 00 00 00    	je     1085 <rmdot+0x145>
    printf(1, "rm .. worked!\n");
    exit();
  }
  if(chdir("/") != 0){
     faa:	c7 04 24 36 3b 00 00 	movl   $0x3b36,(%esp)
     fb1:	e8 22 24 00 00       	call   33d8 <chdir>
     fb6:	85 c0                	test   %eax,%eax
     fb8:	0f 85 ae 00 00 00    	jne    106c <rmdot+0x12c>
    printf(1, "chdir / failed\n");
    exit();
  }
  if(unlink("dots/.") == 0){
     fbe:	c7 04 24 96 3c 00 00 	movl   $0x3c96,(%esp)
     fc5:	e8 ee 23 00 00       	call   33b8 <unlink>
     fca:	85 c0                	test   %eax,%eax
     fcc:	0f 84 81 00 00 00    	je     1053 <rmdot+0x113>
    printf(1, "unlink dots/. worked!\n");
    exit();
  }
  if(unlink("dots/..") == 0){
     fd2:	c7 04 24 b4 3c 00 00 	movl   $0x3cb4,(%esp)
     fd9:	e8 da 23 00 00       	call   33b8 <unlink>
     fde:	85 c0                	test   %eax,%eax
     fe0:	74 58                	je     103a <rmdot+0xfa>
    printf(1, "unlink dots/.. worked!\n");
    exit();
  }
  if(unlink("dots") != 0){
     fe2:	c7 04 24 3e 3c 00 00 	movl   $0x3c3e,(%esp)
     fe9:	e8 ca 23 00 00       	call   33b8 <unlink>
     fee:	85 c0                	test   %eax,%eax
     ff0:	75 2f                	jne    1021 <rmdot+0xe1>
    printf(1, "unlink dots failed!\n");
    exit();
  }
  printf(1, "rmdot ok\n");
     ff2:	c7 44 24 04 e9 3c 00 	movl   $0x3ce9,0x4(%esp)
     ff9:	00 
     ffa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1001:	e8 ba 24 00 00       	call   34c0 <printf>
}
    1006:	c9                   	leave  
    1007:	c3                   	ret    
void
rmdot(void)
{
  printf(1, "rmdot test\n");
  if(mkdir("dots") != 0){
    printf(1, "mkdir dots failed\n");
    1008:	c7 44 24 04 43 3c 00 	movl   $0x3c43,0x4(%esp)
    100f:	00 
    1010:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1017:	e8 a4 24 00 00       	call   34c0 <printf>
    exit();
    101c:	e8 47 23 00 00       	call   3368 <exit>
  if(unlink("dots/..") == 0){
    printf(1, "unlink dots/.. worked!\n");
    exit();
  }
  if(unlink("dots") != 0){
    printf(1, "unlink dots failed!\n");
    1021:	c7 44 24 04 d4 3c 00 	movl   $0x3cd4,0x4(%esp)
    1028:	00 
    1029:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1030:	e8 8b 24 00 00       	call   34c0 <printf>
    exit();
    1035:	e8 2e 23 00 00       	call   3368 <exit>
  if(unlink("dots/.") == 0){
    printf(1, "unlink dots/. worked!\n");
    exit();
  }
  if(unlink("dots/..") == 0){
    printf(1, "unlink dots/.. worked!\n");
    103a:	c7 44 24 04 bc 3c 00 	movl   $0x3cbc,0x4(%esp)
    1041:	00 
    1042:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1049:	e8 72 24 00 00       	call   34c0 <printf>
    exit();
    104e:	e8 15 23 00 00       	call   3368 <exit>
  if(chdir("/") != 0){
    printf(1, "chdir / failed\n");
    exit();
  }
  if(unlink("dots/.") == 0){
    printf(1, "unlink dots/. worked!\n");
    1053:	c7 44 24 04 9d 3c 00 	movl   $0x3c9d,0x4(%esp)
    105a:	00 
    105b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1062:	e8 59 24 00 00       	call   34c0 <printf>
    exit();
    1067:	e8 fc 22 00 00       	call   3368 <exit>
  if(unlink("..") == 0){
    printf(1, "rm .. worked!\n");
    exit();
  }
  if(chdir("/") != 0){
    printf(1, "chdir / failed\n");
    106c:	c7 44 24 04 86 3c 00 	movl   $0x3c86,0x4(%esp)
    1073:	00 
    1074:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    107b:	e8 40 24 00 00       	call   34c0 <printf>
    exit();
    1080:	e8 e3 22 00 00       	call   3368 <exit>
  if(unlink(".") == 0){
    printf(1, "rm . worked!\n");
    exit();
  }
  if(unlink("..") == 0){
    printf(1, "rm .. worked!\n");
    1085:	c7 44 24 04 77 3c 00 	movl   $0x3c77,0x4(%esp)
    108c:	00 
    108d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1094:	e8 27 24 00 00       	call   34c0 <printf>
    exit();
    1099:	e8 ca 22 00 00       	call   3368 <exit>
  if(chdir("dots") != 0){
    printf(1, "chdir dots failed\n");
    exit();
  }
  if(unlink(".") == 0){
    printf(1, "rm . worked!\n");
    109e:	c7 44 24 04 69 3c 00 	movl   $0x3c69,0x4(%esp)
    10a5:	00 
    10a6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10ad:	e8 0e 24 00 00       	call   34c0 <printf>
    exit();
    10b2:	e8 b1 22 00 00       	call   3368 <exit>
  if(mkdir("dots") != 0){
    printf(1, "mkdir dots failed\n");
    exit();
  }
  if(chdir("dots") != 0){
    printf(1, "chdir dots failed\n");
    10b7:	c7 44 24 04 56 3c 00 	movl   $0x3c56,0x4(%esp)
    10be:	00 
    10bf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10c6:	e8 f5 23 00 00       	call   34c0 <printf>
    exit();
    10cb:	e8 98 22 00 00       	call   3368 <exit>

000010d0 <subdir>:
  printf(1, "bigdir ok\n");
}

void
subdir(void)
{
    10d0:	55                   	push   %ebp
    10d1:	89 e5                	mov    %esp,%ebp
    10d3:	53                   	push   %ebx
    10d4:	83 ec 14             	sub    $0x14,%esp
  int fd, cc;

  printf(1, "subdir test\n");
    10d7:	c7 44 24 04 f3 3c 00 	movl   $0x3cf3,0x4(%esp)
    10de:	00 
    10df:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10e6:	e8 d5 23 00 00       	call   34c0 <printf>

  unlink("ff");
    10eb:	c7 04 24 7c 3d 00 00 	movl   $0x3d7c,(%esp)
    10f2:	e8 c1 22 00 00       	call   33b8 <unlink>
  if(mkdir("dd") != 0){
    10f7:	c7 04 24 19 3e 00 00 	movl   $0x3e19,(%esp)
    10fe:	e8 cd 22 00 00       	call   33d0 <mkdir>
    1103:	85 c0                	test   %eax,%eax
    1105:	0f 85 07 06 00 00    	jne    1712 <subdir+0x642>
    printf(1, "subdir mkdir dd failed\n");
    exit();
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    110b:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1112:	00 
    1113:	c7 04 24 52 3d 00 00 	movl   $0x3d52,(%esp)
    111a:	e8 89 22 00 00       	call   33a8 <open>
  if(fd < 0){
    111f:	85 c0                	test   %eax,%eax
  if(mkdir("dd") != 0){
    printf(1, "subdir mkdir dd failed\n");
    exit();
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    1121:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1123:	0f 88 d0 05 00 00    	js     16f9 <subdir+0x629>
    printf(1, "create dd/ff failed\n");
    exit();
  }
  write(fd, "ff", 2);
    1129:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
    1130:	00 
    1131:	c7 44 24 04 7c 3d 00 	movl   $0x3d7c,0x4(%esp)
    1138:	00 
    1139:	89 04 24             	mov    %eax,(%esp)
    113c:	e8 47 22 00 00       	call   3388 <write>
  close(fd);
    1141:	89 1c 24             	mov    %ebx,(%esp)
    1144:	e8 47 22 00 00       	call   3390 <close>
  
  if(unlink("dd") >= 0){
    1149:	c7 04 24 19 3e 00 00 	movl   $0x3e19,(%esp)
    1150:	e8 63 22 00 00       	call   33b8 <unlink>
    1155:	85 c0                	test   %eax,%eax
    1157:	0f 89 83 05 00 00    	jns    16e0 <subdir+0x610>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    exit();
  }

  if(mkdir("/dd/dd") != 0){
    115d:	c7 04 24 2d 3d 00 00 	movl   $0x3d2d,(%esp)
    1164:	e8 67 22 00 00       	call   33d0 <mkdir>
    1169:	85 c0                	test   %eax,%eax
    116b:	0f 85 56 05 00 00    	jne    16c7 <subdir+0x5f7>
    printf(1, "subdir mkdir dd/dd failed\n");
    exit();
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1171:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1178:	00 
    1179:	c7 04 24 4f 3d 00 00 	movl   $0x3d4f,(%esp)
    1180:	e8 23 22 00 00       	call   33a8 <open>
  if(fd < 0){
    1185:	85 c0                	test   %eax,%eax
  if(mkdir("/dd/dd") != 0){
    printf(1, "subdir mkdir dd/dd failed\n");
    exit();
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1187:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1189:	0f 88 25 04 00 00    	js     15b4 <subdir+0x4e4>
    printf(1, "create dd/dd/ff failed\n");
    exit();
  }
  write(fd, "FF", 2);
    118f:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
    1196:	00 
    1197:	c7 44 24 04 70 3d 00 	movl   $0x3d70,0x4(%esp)
    119e:	00 
    119f:	89 04 24             	mov    %eax,(%esp)
    11a2:	e8 e1 21 00 00       	call   3388 <write>
  close(fd);
    11a7:	89 1c 24             	mov    %ebx,(%esp)
    11aa:	e8 e1 21 00 00       	call   3390 <close>

  fd = open("dd/dd/../ff", 0);
    11af:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    11b6:	00 
    11b7:	c7 04 24 73 3d 00 00 	movl   $0x3d73,(%esp)
    11be:	e8 e5 21 00 00       	call   33a8 <open>
  if(fd < 0){
    11c3:	85 c0                	test   %eax,%eax
    exit();
  }
  write(fd, "FF", 2);
  close(fd);

  fd = open("dd/dd/../ff", 0);
    11c5:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    11c7:	0f 88 ce 03 00 00    	js     159b <subdir+0x4cb>
    printf(1, "open dd/dd/../ff failed\n");
    exit();
  }
  cc = read(fd, buf, sizeof(buf));
    11cd:	c7 44 24 08 00 08 00 	movl   $0x800,0x8(%esp)
    11d4:	00 
    11d5:	c7 44 24 04 a0 4d 00 	movl   $0x4da0,0x4(%esp)
    11dc:	00 
    11dd:	89 04 24             	mov    %eax,(%esp)
    11e0:	e8 9b 21 00 00       	call   3380 <read>
  if(cc != 2 || buf[0] != 'f'){
    11e5:	83 f8 02             	cmp    $0x2,%eax
    11e8:	0f 85 fe 02 00 00    	jne    14ec <subdir+0x41c>
    11ee:	80 3d a0 4d 00 00 66 	cmpb   $0x66,0x4da0
    11f5:	0f 85 f1 02 00 00    	jne    14ec <subdir+0x41c>
    printf(1, "dd/dd/../ff wrong content\n");
    exit();
  }
  close(fd);
    11fb:	89 1c 24             	mov    %ebx,(%esp)
    11fe:	e8 8d 21 00 00       	call   3390 <close>

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    1203:	c7 44 24 04 b3 3d 00 	movl   $0x3db3,0x4(%esp)
    120a:	00 
    120b:	c7 04 24 4f 3d 00 00 	movl   $0x3d4f,(%esp)
    1212:	e8 b1 21 00 00       	call   33c8 <link>
    1217:	85 c0                	test   %eax,%eax
    1219:	0f 85 c7 03 00 00    	jne    15e6 <subdir+0x516>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    exit();
  }

  if(unlink("dd/dd/ff") != 0){
    121f:	c7 04 24 4f 3d 00 00 	movl   $0x3d4f,(%esp)
    1226:	e8 8d 21 00 00       	call   33b8 <unlink>
    122b:	85 c0                	test   %eax,%eax
    122d:	0f 85 eb 02 00 00    	jne    151e <subdir+0x44e>
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1233:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    123a:	00 
    123b:	c7 04 24 4f 3d 00 00 	movl   $0x3d4f,(%esp)
    1242:	e8 61 21 00 00       	call   33a8 <open>
    1247:	85 c0                	test   %eax,%eax
    1249:	0f 89 5f 04 00 00    	jns    16ae <subdir+0x5de>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    exit();
  }

  if(chdir("dd") != 0){
    124f:	c7 04 24 19 3e 00 00 	movl   $0x3e19,(%esp)
    1256:	e8 7d 21 00 00       	call   33d8 <chdir>
    125b:	85 c0                	test   %eax,%eax
    125d:	0f 85 32 04 00 00    	jne    1695 <subdir+0x5c5>
    printf(1, "chdir dd failed\n");
    exit();
  }
  if(chdir("dd/../../dd") != 0){
    1263:	c7 04 24 e7 3d 00 00 	movl   $0x3de7,(%esp)
    126a:	e8 69 21 00 00       	call   33d8 <chdir>
    126f:	85 c0                	test   %eax,%eax
    1271:	0f 85 8e 02 00 00    	jne    1505 <subdir+0x435>
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("dd/../../../dd") != 0){
    1277:	c7 04 24 0d 3e 00 00 	movl   $0x3e0d,(%esp)
    127e:	e8 55 21 00 00       	call   33d8 <chdir>
    1283:	85 c0                	test   %eax,%eax
    1285:	0f 85 7a 02 00 00    	jne    1505 <subdir+0x435>
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("./..") != 0){
    128b:	c7 04 24 1c 3e 00 00 	movl   $0x3e1c,(%esp)
    1292:	e8 41 21 00 00       	call   33d8 <chdir>
    1297:	85 c0                	test   %eax,%eax
    1299:	0f 85 2e 03 00 00    	jne    15cd <subdir+0x4fd>
    printf(1, "chdir ./.. failed\n");
    exit();
  }

  fd = open("dd/dd/ffff", 0);
    129f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    12a6:	00 
    12a7:	c7 04 24 b3 3d 00 00 	movl   $0x3db3,(%esp)
    12ae:	e8 f5 20 00 00       	call   33a8 <open>
  if(fd < 0){
    12b3:	85 c0                	test   %eax,%eax
  if(chdir("./..") != 0){
    printf(1, "chdir ./.. failed\n");
    exit();
  }

  fd = open("dd/dd/ffff", 0);
    12b5:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    12b7:	0f 88 81 05 00 00    	js     183e <subdir+0x76e>
    printf(1, "open dd/dd/ffff failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    12bd:	c7 44 24 08 00 08 00 	movl   $0x800,0x8(%esp)
    12c4:	00 
    12c5:	c7 44 24 04 a0 4d 00 	movl   $0x4da0,0x4(%esp)
    12cc:	00 
    12cd:	89 04 24             	mov    %eax,(%esp)
    12d0:	e8 ab 20 00 00       	call   3380 <read>
    12d5:	83 f8 02             	cmp    $0x2,%eax
    12d8:	0f 85 47 05 00 00    	jne    1825 <subdir+0x755>
    printf(1, "read dd/dd/ffff wrong len\n");
    exit();
  }
  close(fd);
    12de:	89 1c 24             	mov    %ebx,(%esp)
    12e1:	e8 aa 20 00 00       	call   3390 <close>

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    12e6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    12ed:	00 
    12ee:	c7 04 24 4f 3d 00 00 	movl   $0x3d4f,(%esp)
    12f5:	e8 ae 20 00 00       	call   33a8 <open>
    12fa:	85 c0                	test   %eax,%eax
    12fc:	0f 89 4e 02 00 00    	jns    1550 <subdir+0x480>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    exit();
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    1302:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1309:	00 
    130a:	c7 04 24 67 3e 00 00 	movl   $0x3e67,(%esp)
    1311:	e8 92 20 00 00       	call   33a8 <open>
    1316:	85 c0                	test   %eax,%eax
    1318:	0f 89 19 02 00 00    	jns    1537 <subdir+0x467>
    printf(1, "create dd/ff/ff succeeded!\n");
    exit();
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    131e:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1325:	00 
    1326:	c7 04 24 8c 3e 00 00 	movl   $0x3e8c,(%esp)
    132d:	e8 76 20 00 00       	call   33a8 <open>
    1332:	85 c0                	test   %eax,%eax
    1334:	0f 89 42 03 00 00    	jns    167c <subdir+0x5ac>
    printf(1, "create dd/xx/ff succeeded!\n");
    exit();
  }
  if(open("dd", O_CREATE) >= 0){
    133a:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    1341:	00 
    1342:	c7 04 24 19 3e 00 00 	movl   $0x3e19,(%esp)
    1349:	e8 5a 20 00 00       	call   33a8 <open>
    134e:	85 c0                	test   %eax,%eax
    1350:	0f 89 0d 03 00 00    	jns    1663 <subdir+0x593>
    printf(1, "create dd succeeded!\n");
    exit();
  }
  if(open("dd", O_RDWR) >= 0){
    1356:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    135d:	00 
    135e:	c7 04 24 19 3e 00 00 	movl   $0x3e19,(%esp)
    1365:	e8 3e 20 00 00       	call   33a8 <open>
    136a:	85 c0                	test   %eax,%eax
    136c:	0f 89 d8 02 00 00    	jns    164a <subdir+0x57a>
    printf(1, "open dd rdwr succeeded!\n");
    exit();
  }
  if(open("dd", O_WRONLY) >= 0){
    1372:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1379:	00 
    137a:	c7 04 24 19 3e 00 00 	movl   $0x3e19,(%esp)
    1381:	e8 22 20 00 00       	call   33a8 <open>
    1386:	85 c0                	test   %eax,%eax
    1388:	0f 89 a3 02 00 00    	jns    1631 <subdir+0x561>
    printf(1, "open dd wronly succeeded!\n");
    exit();
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    138e:	c7 44 24 04 fb 3e 00 	movl   $0x3efb,0x4(%esp)
    1395:	00 
    1396:	c7 04 24 67 3e 00 00 	movl   $0x3e67,(%esp)
    139d:	e8 26 20 00 00       	call   33c8 <link>
    13a2:	85 c0                	test   %eax,%eax
    13a4:	0f 84 6e 02 00 00    	je     1618 <subdir+0x548>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    13aa:	c7 44 24 04 fb 3e 00 	movl   $0x3efb,0x4(%esp)
    13b1:	00 
    13b2:	c7 04 24 8c 3e 00 00 	movl   $0x3e8c,(%esp)
    13b9:	e8 0a 20 00 00       	call   33c8 <link>
    13be:	85 c0                	test   %eax,%eax
    13c0:	0f 84 39 02 00 00    	je     15ff <subdir+0x52f>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    13c6:	c7 44 24 04 b3 3d 00 	movl   $0x3db3,0x4(%esp)
    13cd:	00 
    13ce:	c7 04 24 52 3d 00 00 	movl   $0x3d52,(%esp)
    13d5:	e8 ee 1f 00 00       	call   33c8 <link>
    13da:	85 c0                	test   %eax,%eax
    13dc:	0f 84 a0 01 00 00    	je     1582 <subdir+0x4b2>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    exit();
  }
  if(mkdir("dd/ff/ff") == 0){
    13e2:	c7 04 24 67 3e 00 00 	movl   $0x3e67,(%esp)
    13e9:	e8 e2 1f 00 00       	call   33d0 <mkdir>
    13ee:	85 c0                	test   %eax,%eax
    13f0:	0f 84 73 01 00 00    	je     1569 <subdir+0x499>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/xx/ff") == 0){
    13f6:	c7 04 24 8c 3e 00 00 	movl   $0x3e8c,(%esp)
    13fd:	e8 ce 1f 00 00       	call   33d0 <mkdir>
    1402:	85 c0                	test   %eax,%eax
    1404:	0f 84 02 04 00 00    	je     180c <subdir+0x73c>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/dd/ffff") == 0){
    140a:	c7 04 24 b3 3d 00 00 	movl   $0x3db3,(%esp)
    1411:	e8 ba 1f 00 00       	call   33d0 <mkdir>
    1416:	85 c0                	test   %eax,%eax
    1418:	0f 84 d5 03 00 00    	je     17f3 <subdir+0x723>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    exit();
  }
  if(unlink("dd/xx/ff") == 0){
    141e:	c7 04 24 8c 3e 00 00 	movl   $0x3e8c,(%esp)
    1425:	e8 8e 1f 00 00       	call   33b8 <unlink>
    142a:	85 c0                	test   %eax,%eax
    142c:	0f 84 a8 03 00 00    	je     17da <subdir+0x70a>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    exit();
  }
  if(unlink("dd/ff/ff") == 0){
    1432:	c7 04 24 67 3e 00 00 	movl   $0x3e67,(%esp)
    1439:	e8 7a 1f 00 00       	call   33b8 <unlink>
    143e:	85 c0                	test   %eax,%eax
    1440:	0f 84 7b 03 00 00    	je     17c1 <subdir+0x6f1>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/ff") == 0){
    1446:	c7 04 24 52 3d 00 00 	movl   $0x3d52,(%esp)
    144d:	e8 86 1f 00 00       	call   33d8 <chdir>
    1452:	85 c0                	test   %eax,%eax
    1454:	0f 84 4e 03 00 00    	je     17a8 <subdir+0x6d8>
    printf(1, "chdir dd/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/xx") == 0){
    145a:	c7 04 24 fe 3e 00 00 	movl   $0x3efe,(%esp)
    1461:	e8 72 1f 00 00       	call   33d8 <chdir>
    1466:	85 c0                	test   %eax,%eax
    1468:	0f 84 21 03 00 00    	je     178f <subdir+0x6bf>
    printf(1, "chdir dd/xx succeeded!\n");
    exit();
  }

  if(unlink("dd/dd/ffff") != 0){
    146e:	c7 04 24 b3 3d 00 00 	movl   $0x3db3,(%esp)
    1475:	e8 3e 1f 00 00       	call   33b8 <unlink>
    147a:	85 c0                	test   %eax,%eax
    147c:	0f 85 9c 00 00 00    	jne    151e <subdir+0x44e>
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(unlink("dd/ff") != 0){
    1482:	c7 04 24 52 3d 00 00 	movl   $0x3d52,(%esp)
    1489:	e8 2a 1f 00 00       	call   33b8 <unlink>
    148e:	85 c0                	test   %eax,%eax
    1490:	0f 85 e0 02 00 00    	jne    1776 <subdir+0x6a6>
    printf(1, "unlink dd/ff failed\n");
    exit();
  }
  if(unlink("dd") == 0){
    1496:	c7 04 24 19 3e 00 00 	movl   $0x3e19,(%esp)
    149d:	e8 16 1f 00 00       	call   33b8 <unlink>
    14a2:	85 c0                	test   %eax,%eax
    14a4:	0f 84 b3 02 00 00    	je     175d <subdir+0x68d>
    printf(1, "unlink non-empty dd succeeded!\n");
    exit();
  }
  if(unlink("dd/dd") < 0){
    14aa:	c7 04 24 2e 3d 00 00 	movl   $0x3d2e,(%esp)
    14b1:	e8 02 1f 00 00       	call   33b8 <unlink>
    14b6:	85 c0                	test   %eax,%eax
    14b8:	0f 88 86 02 00 00    	js     1744 <subdir+0x674>
    printf(1, "unlink dd/dd failed\n");
    exit();
  }
  if(unlink("dd") < 0){
    14be:	c7 04 24 19 3e 00 00 	movl   $0x3e19,(%esp)
    14c5:	e8 ee 1e 00 00       	call   33b8 <unlink>
    14ca:	85 c0                	test   %eax,%eax
    14cc:	0f 88 59 02 00 00    	js     172b <subdir+0x65b>
    printf(1, "unlink dd failed\n");
    exit();
  }

  printf(1, "subdir ok\n");
    14d2:	c7 44 24 04 fb 3f 00 	movl   $0x3ffb,0x4(%esp)
    14d9:	00 
    14da:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    14e1:	e8 da 1f 00 00       	call   34c0 <printf>
}
    14e6:	83 c4 14             	add    $0x14,%esp
    14e9:	5b                   	pop    %ebx
    14ea:	5d                   	pop    %ebp
    14eb:	c3                   	ret    
    printf(1, "open dd/dd/../ff failed\n");
    exit();
  }
  cc = read(fd, buf, sizeof(buf));
  if(cc != 2 || buf[0] != 'f'){
    printf(1, "dd/dd/../ff wrong content\n");
    14ec:	c7 44 24 04 98 3d 00 	movl   $0x3d98,0x4(%esp)
    14f3:	00 
    14f4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    14fb:	e8 c0 1f 00 00       	call   34c0 <printf>
    exit();
    1500:	e8 63 1e 00 00       	call   3368 <exit>
  if(chdir("dd/../../dd") != 0){
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("dd/../../../dd") != 0){
    printf(1, "chdir dd/../../dd failed\n");
    1505:	c7 44 24 04 f3 3d 00 	movl   $0x3df3,0x4(%esp)
    150c:	00 
    150d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1514:	e8 a7 1f 00 00       	call   34c0 <printf>
    exit();
    1519:	e8 4a 1e 00 00       	call   3368 <exit>
    printf(1, "chdir dd/xx succeeded!\n");
    exit();
  }

  if(unlink("dd/dd/ffff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    151e:	c7 44 24 04 be 3d 00 	movl   $0x3dbe,0x4(%esp)
    1525:	00 
    1526:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    152d:	e8 8e 1f 00 00       	call   34c0 <printf>
    exit();
    1532:	e8 31 1e 00 00       	call   3368 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    exit();
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/ff/ff succeeded!\n");
    1537:	c7 44 24 04 70 3e 00 	movl   $0x3e70,0x4(%esp)
    153e:	00 
    153f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1546:	e8 75 1f 00 00       	call   34c0 <printf>
    exit();
    154b:	e8 18 1e 00 00       	call   3368 <exit>
    exit();
  }
  close(fd);

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    1550:	c7 44 24 04 6c 4a 00 	movl   $0x4a6c,0x4(%esp)
    1557:	00 
    1558:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    155f:	e8 5c 1f 00 00       	call   34c0 <printf>
    exit();
    1564:	e8 ff 1d 00 00       	call   3368 <exit>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    exit();
  }
  if(mkdir("dd/ff/ff") == 0){
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    1569:	c7 44 24 04 04 3f 00 	movl   $0x3f04,0x4(%esp)
    1570:	00 
    1571:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1578:	e8 43 1f 00 00       	call   34c0 <printf>
    exit();
    157d:	e8 e6 1d 00 00       	call   3368 <exit>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    1582:	c7 44 24 04 dc 4a 00 	movl   $0x4adc,0x4(%esp)
    1589:	00 
    158a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1591:	e8 2a 1f 00 00       	call   34c0 <printf>
    exit();
    1596:	e8 cd 1d 00 00       	call   3368 <exit>
  write(fd, "FF", 2);
  close(fd);

  fd = open("dd/dd/../ff", 0);
  if(fd < 0){
    printf(1, "open dd/dd/../ff failed\n");
    159b:	c7 44 24 04 7f 3d 00 	movl   $0x3d7f,0x4(%esp)
    15a2:	00 
    15a3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15aa:	e8 11 1f 00 00       	call   34c0 <printf>
    exit();
    15af:	e8 b4 1d 00 00       	call   3368 <exit>
    exit();
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create dd/dd/ff failed\n");
    15b4:	c7 44 24 04 58 3d 00 	movl   $0x3d58,0x4(%esp)
    15bb:	00 
    15bc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15c3:	e8 f8 1e 00 00       	call   34c0 <printf>
    exit();
    15c8:	e8 9b 1d 00 00       	call   3368 <exit>
  if(chdir("dd/../../../dd") != 0){
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("./..") != 0){
    printf(1, "chdir ./.. failed\n");
    15cd:	c7 44 24 04 21 3e 00 	movl   $0x3e21,0x4(%esp)
    15d4:	00 
    15d5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15dc:	e8 df 1e 00 00       	call   34c0 <printf>
    exit();
    15e1:	e8 82 1d 00 00       	call   3368 <exit>
    exit();
  }
  close(fd);

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    15e6:	c7 44 24 04 24 4a 00 	movl   $0x4a24,0x4(%esp)
    15ed:	00 
    15ee:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15f5:	e8 c6 1e 00 00       	call   34c0 <printf>
    exit();
    15fa:	e8 69 1d 00 00       	call   3368 <exit>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    15ff:	c7 44 24 04 b8 4a 00 	movl   $0x4ab8,0x4(%esp)
    1606:	00 
    1607:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    160e:	e8 ad 1e 00 00       	call   34c0 <printf>
    exit();
    1613:	e8 50 1d 00 00       	call   3368 <exit>
  if(open("dd", O_WRONLY) >= 0){
    printf(1, "open dd wronly succeeded!\n");
    exit();
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    1618:	c7 44 24 04 94 4a 00 	movl   $0x4a94,0x4(%esp)
    161f:	00 
    1620:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1627:	e8 94 1e 00 00       	call   34c0 <printf>
    exit();
    162c:	e8 37 1d 00 00       	call   3368 <exit>
  if(open("dd", O_RDWR) >= 0){
    printf(1, "open dd rdwr succeeded!\n");
    exit();
  }
  if(open("dd", O_WRONLY) >= 0){
    printf(1, "open dd wronly succeeded!\n");
    1631:	c7 44 24 04 e0 3e 00 	movl   $0x3ee0,0x4(%esp)
    1638:	00 
    1639:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1640:	e8 7b 1e 00 00       	call   34c0 <printf>
    exit();
    1645:	e8 1e 1d 00 00       	call   3368 <exit>
  if(open("dd", O_CREATE) >= 0){
    printf(1, "create dd succeeded!\n");
    exit();
  }
  if(open("dd", O_RDWR) >= 0){
    printf(1, "open dd rdwr succeeded!\n");
    164a:	c7 44 24 04 c7 3e 00 	movl   $0x3ec7,0x4(%esp)
    1651:	00 
    1652:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1659:	e8 62 1e 00 00       	call   34c0 <printf>
    exit();
    165e:	e8 05 1d 00 00       	call   3368 <exit>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/xx/ff succeeded!\n");
    exit();
  }
  if(open("dd", O_CREATE) >= 0){
    printf(1, "create dd succeeded!\n");
    1663:	c7 44 24 04 b1 3e 00 	movl   $0x3eb1,0x4(%esp)
    166a:	00 
    166b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1672:	e8 49 1e 00 00       	call   34c0 <printf>
    exit();
    1677:	e8 ec 1c 00 00       	call   3368 <exit>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/ff/ff succeeded!\n");
    exit();
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/xx/ff succeeded!\n");
    167c:	c7 44 24 04 95 3e 00 	movl   $0x3e95,0x4(%esp)
    1683:	00 
    1684:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    168b:	e8 30 1e 00 00       	call   34c0 <printf>
    exit();
    1690:	e8 d3 1c 00 00       	call   3368 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    exit();
  }

  if(chdir("dd") != 0){
    printf(1, "chdir dd failed\n");
    1695:	c7 44 24 04 d6 3d 00 	movl   $0x3dd6,0x4(%esp)
    169c:	00 
    169d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    16a4:	e8 17 1e 00 00       	call   34c0 <printf>
    exit();
    16a9:	e8 ba 1c 00 00       	call   3368 <exit>
  if(unlink("dd/dd/ff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    16ae:	c7 44 24 04 48 4a 00 	movl   $0x4a48,0x4(%esp)
    16b5:	00 
    16b6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    16bd:	e8 fe 1d 00 00       	call   34c0 <printf>
    exit();
    16c2:	e8 a1 1c 00 00       	call   3368 <exit>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    exit();
  }

  if(mkdir("/dd/dd") != 0){
    printf(1, "subdir mkdir dd/dd failed\n");
    16c7:	c7 44 24 04 34 3d 00 	movl   $0x3d34,0x4(%esp)
    16ce:	00 
    16cf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    16d6:	e8 e5 1d 00 00       	call   34c0 <printf>
    exit();
    16db:	e8 88 1c 00 00       	call   3368 <exit>
  }
  write(fd, "ff", 2);
  close(fd);
  
  if(unlink("dd") >= 0){
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    16e0:	c7 44 24 04 fc 49 00 	movl   $0x49fc,0x4(%esp)
    16e7:	00 
    16e8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    16ef:	e8 cc 1d 00 00       	call   34c0 <printf>
    exit();
    16f4:	e8 6f 1c 00 00       	call   3368 <exit>
    exit();
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create dd/ff failed\n");
    16f9:	c7 44 24 04 18 3d 00 	movl   $0x3d18,0x4(%esp)
    1700:	00 
    1701:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1708:	e8 b3 1d 00 00       	call   34c0 <printf>
    exit();
    170d:	e8 56 1c 00 00       	call   3368 <exit>

  printf(1, "subdir test\n");

  unlink("ff");
  if(mkdir("dd") != 0){
    printf(1, "subdir mkdir dd failed\n");
    1712:	c7 44 24 04 00 3d 00 	movl   $0x3d00,0x4(%esp)
    1719:	00 
    171a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1721:	e8 9a 1d 00 00       	call   34c0 <printf>
    exit();
    1726:	e8 3d 1c 00 00       	call   3368 <exit>
  if(unlink("dd/dd") < 0){
    printf(1, "unlink dd/dd failed\n");
    exit();
  }
  if(unlink("dd") < 0){
    printf(1, "unlink dd failed\n");
    172b:	c7 44 24 04 e9 3f 00 	movl   $0x3fe9,0x4(%esp)
    1732:	00 
    1733:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    173a:	e8 81 1d 00 00       	call   34c0 <printf>
    exit();
    173f:	e8 24 1c 00 00       	call   3368 <exit>
  if(unlink("dd") == 0){
    printf(1, "unlink non-empty dd succeeded!\n");
    exit();
  }
  if(unlink("dd/dd") < 0){
    printf(1, "unlink dd/dd failed\n");
    1744:	c7 44 24 04 d4 3f 00 	movl   $0x3fd4,0x4(%esp)
    174b:	00 
    174c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1753:	e8 68 1d 00 00       	call   34c0 <printf>
    exit();
    1758:	e8 0b 1c 00 00       	call   3368 <exit>
  if(unlink("dd/ff") != 0){
    printf(1, "unlink dd/ff failed\n");
    exit();
  }
  if(unlink("dd") == 0){
    printf(1, "unlink non-empty dd succeeded!\n");
    175d:	c7 44 24 04 00 4b 00 	movl   $0x4b00,0x4(%esp)
    1764:	00 
    1765:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    176c:	e8 4f 1d 00 00       	call   34c0 <printf>
    exit();
    1771:	e8 f2 1b 00 00       	call   3368 <exit>
  if(unlink("dd/dd/ffff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(unlink("dd/ff") != 0){
    printf(1, "unlink dd/ff failed\n");
    1776:	c7 44 24 04 bf 3f 00 	movl   $0x3fbf,0x4(%esp)
    177d:	00 
    177e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1785:	e8 36 1d 00 00       	call   34c0 <printf>
    exit();
    178a:	e8 d9 1b 00 00       	call   3368 <exit>
  if(chdir("dd/ff") == 0){
    printf(1, "chdir dd/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/xx") == 0){
    printf(1, "chdir dd/xx succeeded!\n");
    178f:	c7 44 24 04 a7 3f 00 	movl   $0x3fa7,0x4(%esp)
    1796:	00 
    1797:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    179e:	e8 1d 1d 00 00       	call   34c0 <printf>
    exit();
    17a3:	e8 c0 1b 00 00       	call   3368 <exit>
  if(unlink("dd/ff/ff") == 0){
    printf(1, "unlink dd/ff/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/ff") == 0){
    printf(1, "chdir dd/ff succeeded!\n");
    17a8:	c7 44 24 04 8f 3f 00 	movl   $0x3f8f,0x4(%esp)
    17af:	00 
    17b0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    17b7:	e8 04 1d 00 00       	call   34c0 <printf>
    exit();
    17bc:	e8 a7 1b 00 00       	call   3368 <exit>
  if(unlink("dd/xx/ff") == 0){
    printf(1, "unlink dd/xx/ff succeeded!\n");
    exit();
  }
  if(unlink("dd/ff/ff") == 0){
    printf(1, "unlink dd/ff/ff succeeded!\n");
    17c1:	c7 44 24 04 73 3f 00 	movl   $0x3f73,0x4(%esp)
    17c8:	00 
    17c9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    17d0:	e8 eb 1c 00 00       	call   34c0 <printf>
    exit();
    17d5:	e8 8e 1b 00 00       	call   3368 <exit>
  if(mkdir("dd/dd/ffff") == 0){
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    exit();
  }
  if(unlink("dd/xx/ff") == 0){
    printf(1, "unlink dd/xx/ff succeeded!\n");
    17da:	c7 44 24 04 57 3f 00 	movl   $0x3f57,0x4(%esp)
    17e1:	00 
    17e2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    17e9:	e8 d2 1c 00 00       	call   34c0 <printf>
    exit();
    17ee:	e8 75 1b 00 00       	call   3368 <exit>
  if(mkdir("dd/xx/ff") == 0){
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/dd/ffff") == 0){
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    17f3:	c7 44 24 04 3a 3f 00 	movl   $0x3f3a,0x4(%esp)
    17fa:	00 
    17fb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1802:	e8 b9 1c 00 00       	call   34c0 <printf>
    exit();
    1807:	e8 5c 1b 00 00       	call   3368 <exit>
  if(mkdir("dd/ff/ff") == 0){
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/xx/ff") == 0){
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    180c:	c7 44 24 04 1f 3f 00 	movl   $0x3f1f,0x4(%esp)
    1813:	00 
    1814:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    181b:	e8 a0 1c 00 00       	call   34c0 <printf>
    exit();
    1820:	e8 43 1b 00 00       	call   3368 <exit>
  if(fd < 0){
    printf(1, "open dd/dd/ffff failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    printf(1, "read dd/dd/ffff wrong len\n");
    1825:	c7 44 24 04 4c 3e 00 	movl   $0x3e4c,0x4(%esp)
    182c:	00 
    182d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1834:	e8 87 1c 00 00       	call   34c0 <printf>
    exit();
    1839:	e8 2a 1b 00 00       	call   3368 <exit>
    exit();
  }

  fd = open("dd/dd/ffff", 0);
  if(fd < 0){
    printf(1, "open dd/dd/ffff failed\n");
    183e:	c7 44 24 04 34 3e 00 	movl   $0x3e34,0x4(%esp)
    1845:	00 
    1846:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    184d:	e8 6e 1c 00 00       	call   34c0 <printf>
    exit();
    1852:	e8 11 1b 00 00       	call   3368 <exit>
    1857:	89 f6                	mov    %esi,%esi
    1859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001860 <bigdir>:
}

// directory that uses indirect blocks
void
bigdir(void)
{
    1860:	55                   	push   %ebp
    1861:	89 e5                	mov    %esp,%ebp
    1863:	56                   	push   %esi
    1864:	53                   	push   %ebx
    1865:	83 ec 20             	sub    $0x20,%esp
  int i, fd;
  char name[10];

  printf(1, "bigdir test\n");
    1868:	c7 44 24 04 06 40 00 	movl   $0x4006,0x4(%esp)
    186f:	00 
    1870:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1877:	e8 44 1c 00 00       	call   34c0 <printf>
  unlink("bd");
    187c:	c7 04 24 13 40 00 00 	movl   $0x4013,(%esp)
    1883:	e8 30 1b 00 00       	call   33b8 <unlink>

  fd = open("bd", O_CREATE);
    1888:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    188f:	00 
    1890:	c7 04 24 13 40 00 00 	movl   $0x4013,(%esp)
    1897:	e8 0c 1b 00 00       	call   33a8 <open>
  if(fd < 0){
    189c:	85 c0                	test   %eax,%eax
    189e:	0f 88 e6 00 00 00    	js     198a <bigdir+0x12a>
    printf(1, "bigdir create failed\n");
    exit();
  }
  close(fd);
    18a4:	89 04 24             	mov    %eax,(%esp)
    18a7:	31 db                	xor    %ebx,%ebx
    18a9:	e8 e2 1a 00 00       	call   3390 <close>
    18ae:	8d 75 ee             	lea    -0x12(%ebp),%esi
    18b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    18b8:	89 d8                	mov    %ebx,%eax
    18ba:	c1 f8 06             	sar    $0x6,%eax
    18bd:	83 c0 30             	add    $0x30,%eax
    18c0:	88 45 ef             	mov    %al,-0x11(%ebp)
    name[2] = '0' + (i % 64);
    18c3:	89 d8                	mov    %ebx,%eax
    18c5:	83 e0 3f             	and    $0x3f,%eax
    18c8:	83 c0 30             	add    $0x30,%eax
    exit();
  }
  close(fd);

  for(i = 0; i < 500; i++){
    name[0] = 'x';
    18cb:	c6 45 ee 78          	movb   $0x78,-0x12(%ebp)
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    18cf:	88 45 f0             	mov    %al,-0x10(%ebp)
    name[3] = '\0';
    18d2:	c6 45 f1 00          	movb   $0x0,-0xf(%ebp)
    if(link("bd", name) != 0){
    18d6:	89 74 24 04          	mov    %esi,0x4(%esp)
    18da:	c7 04 24 13 40 00 00 	movl   $0x4013,(%esp)
    18e1:	e8 e2 1a 00 00       	call   33c8 <link>
    18e6:	85 c0                	test   %eax,%eax
    18e8:	75 6e                	jne    1958 <bigdir+0xf8>
    printf(1, "bigdir create failed\n");
    exit();
  }
  close(fd);

  for(i = 0; i < 500; i++){
    18ea:	83 c3 01             	add    $0x1,%ebx
    18ed:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    18f3:	75 c3                	jne    18b8 <bigdir+0x58>
      printf(1, "bigdir link failed\n");
      exit();
    }
  }

  unlink("bd");
    18f5:	c7 04 24 13 40 00 00 	movl   $0x4013,(%esp)
    18fc:	66 31 db             	xor    %bx,%bx
    18ff:	e8 b4 1a 00 00       	call   33b8 <unlink>
    1904:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    1908:	89 d8                	mov    %ebx,%eax
    190a:	c1 f8 06             	sar    $0x6,%eax
    190d:	83 c0 30             	add    $0x30,%eax
    1910:	88 45 ef             	mov    %al,-0x11(%ebp)
    name[2] = '0' + (i % 64);
    1913:	89 d8                	mov    %ebx,%eax
    1915:	83 e0 3f             	and    $0x3f,%eax
    1918:	83 c0 30             	add    $0x30,%eax
    }
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    name[0] = 'x';
    191b:	c6 45 ee 78          	movb   $0x78,-0x12(%ebp)
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    191f:	88 45 f0             	mov    %al,-0x10(%ebp)
    name[3] = '\0';
    1922:	c6 45 f1 00          	movb   $0x0,-0xf(%ebp)
    if(unlink(name) != 0){
    1926:	89 34 24             	mov    %esi,(%esp)
    1929:	e8 8a 1a 00 00       	call   33b8 <unlink>
    192e:	85 c0                	test   %eax,%eax
    1930:	75 3f                	jne    1971 <bigdir+0x111>
      exit();
    }
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    1932:	83 c3 01             	add    $0x1,%ebx
    1935:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    193b:	75 cb                	jne    1908 <bigdir+0xa8>
      printf(1, "bigdir unlink failed");
      exit();
    }
  }

  printf(1, "bigdir ok\n");
    193d:	c7 44 24 04 55 40 00 	movl   $0x4055,0x4(%esp)
    1944:	00 
    1945:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    194c:	e8 6f 1b 00 00       	call   34c0 <printf>
}
    1951:	83 c4 20             	add    $0x20,%esp
    1954:	5b                   	pop    %ebx
    1955:	5e                   	pop    %esi
    1956:	5d                   	pop    %ebp
    1957:	c3                   	ret    
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(link("bd", name) != 0){
      printf(1, "bigdir link failed\n");
    1958:	c7 44 24 04 2c 40 00 	movl   $0x402c,0x4(%esp)
    195f:	00 
    1960:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1967:	e8 54 1b 00 00       	call   34c0 <printf>
      exit();
    196c:	e8 f7 19 00 00       	call   3368 <exit>
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(unlink(name) != 0){
      printf(1, "bigdir unlink failed");
    1971:	c7 44 24 04 40 40 00 	movl   $0x4040,0x4(%esp)
    1978:	00 
    1979:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1980:	e8 3b 1b 00 00       	call   34c0 <printf>
      exit();
    1985:	e8 de 19 00 00       	call   3368 <exit>
  printf(1, "bigdir test\n");
  unlink("bd");

  fd = open("bd", O_CREATE);
  if(fd < 0){
    printf(1, "bigdir create failed\n");
    198a:	c7 44 24 04 16 40 00 	movl   $0x4016,0x4(%esp)
    1991:	00 
    1992:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1999:	e8 22 1b 00 00       	call   34c0 <printf>
    exit();
    199e:	e8 c5 19 00 00       	call   3368 <exit>
    19a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    19a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000019b0 <linktest>:
  printf(1, "unlinkread ok\n");
}

void
linktest(void)
{
    19b0:	55                   	push   %ebp
    19b1:	89 e5                	mov    %esp,%ebp
    19b3:	53                   	push   %ebx
    19b4:	83 ec 14             	sub    $0x14,%esp
  int fd;

  printf(1, "linktest\n");
    19b7:	c7 44 24 04 60 40 00 	movl   $0x4060,0x4(%esp)
    19be:	00 
    19bf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    19c6:	e8 f5 1a 00 00       	call   34c0 <printf>

  unlink("lf1");
    19cb:	c7 04 24 6a 40 00 00 	movl   $0x406a,(%esp)
    19d2:	e8 e1 19 00 00       	call   33b8 <unlink>
  unlink("lf2");
    19d7:	c7 04 24 6e 40 00 00 	movl   $0x406e,(%esp)
    19de:	e8 d5 19 00 00       	call   33b8 <unlink>

  fd = open("lf1", O_CREATE|O_RDWR);
    19e3:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    19ea:	00 
    19eb:	c7 04 24 6a 40 00 00 	movl   $0x406a,(%esp)
    19f2:	e8 b1 19 00 00       	call   33a8 <open>
  if(fd < 0){
    19f7:	85 c0                	test   %eax,%eax
  printf(1, "linktest\n");

  unlink("lf1");
  unlink("lf2");

  fd = open("lf1", O_CREATE|O_RDWR);
    19f9:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    19fb:	0f 88 26 01 00 00    	js     1b27 <linktest+0x177>
    printf(1, "create lf1 failed\n");
    exit();
  }
  if(write(fd, "hello", 5) != 5){
    1a01:	c7 44 24 08 05 00 00 	movl   $0x5,0x8(%esp)
    1a08:	00 
    1a09:	c7 44 24 04 85 40 00 	movl   $0x4085,0x4(%esp)
    1a10:	00 
    1a11:	89 04 24             	mov    %eax,(%esp)
    1a14:	e8 6f 19 00 00       	call   3388 <write>
    1a19:	83 f8 05             	cmp    $0x5,%eax
    1a1c:	0f 85 cd 01 00 00    	jne    1bef <linktest+0x23f>
    printf(1, "write lf1 failed\n");
    exit();
  }
  close(fd);
    1a22:	89 1c 24             	mov    %ebx,(%esp)
    1a25:	e8 66 19 00 00       	call   3390 <close>

  if(link("lf1", "lf2") < 0){
    1a2a:	c7 44 24 04 6e 40 00 	movl   $0x406e,0x4(%esp)
    1a31:	00 
    1a32:	c7 04 24 6a 40 00 00 	movl   $0x406a,(%esp)
    1a39:	e8 8a 19 00 00       	call   33c8 <link>
    1a3e:	85 c0                	test   %eax,%eax
    1a40:	0f 88 90 01 00 00    	js     1bd6 <linktest+0x226>
    printf(1, "link lf1 lf2 failed\n");
    exit();
  }
  unlink("lf1");
    1a46:	c7 04 24 6a 40 00 00 	movl   $0x406a,(%esp)
    1a4d:	e8 66 19 00 00       	call   33b8 <unlink>

  if(open("lf1", 0) >= 0){
    1a52:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1a59:	00 
    1a5a:	c7 04 24 6a 40 00 00 	movl   $0x406a,(%esp)
    1a61:	e8 42 19 00 00       	call   33a8 <open>
    1a66:	85 c0                	test   %eax,%eax
    1a68:	0f 89 4f 01 00 00    	jns    1bbd <linktest+0x20d>
    printf(1, "unlinked lf1 but it is still there!\n");
    exit();
  }

  fd = open("lf2", 0);
    1a6e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1a75:	00 
    1a76:	c7 04 24 6e 40 00 00 	movl   $0x406e,(%esp)
    1a7d:	e8 26 19 00 00       	call   33a8 <open>
  if(fd < 0){
    1a82:	85 c0                	test   %eax,%eax
  if(open("lf1", 0) >= 0){
    printf(1, "unlinked lf1 but it is still there!\n");
    exit();
  }

  fd = open("lf2", 0);
    1a84:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1a86:	0f 88 18 01 00 00    	js     1ba4 <linktest+0x1f4>
    printf(1, "open lf2 failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    1a8c:	c7 44 24 08 00 08 00 	movl   $0x800,0x8(%esp)
    1a93:	00 
    1a94:	c7 44 24 04 a0 4d 00 	movl   $0x4da0,0x4(%esp)
    1a9b:	00 
    1a9c:	89 04 24             	mov    %eax,(%esp)
    1a9f:	e8 dc 18 00 00       	call   3380 <read>
    1aa4:	83 f8 05             	cmp    $0x5,%eax
    1aa7:	0f 85 de 00 00 00    	jne    1b8b <linktest+0x1db>
    printf(1, "read lf2 failed\n");
    exit();
  }
  close(fd);
    1aad:	89 1c 24             	mov    %ebx,(%esp)
    1ab0:	e8 db 18 00 00       	call   3390 <close>

  if(link("lf2", "lf2") >= 0){
    1ab5:	c7 44 24 04 6e 40 00 	movl   $0x406e,0x4(%esp)
    1abc:	00 
    1abd:	c7 04 24 6e 40 00 00 	movl   $0x406e,(%esp)
    1ac4:	e8 ff 18 00 00       	call   33c8 <link>
    1ac9:	85 c0                	test   %eax,%eax
    1acb:	0f 89 a1 00 00 00    	jns    1b72 <linktest+0x1c2>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    exit();
  }

  unlink("lf2");
    1ad1:	c7 04 24 6e 40 00 00 	movl   $0x406e,(%esp)
    1ad8:	e8 db 18 00 00       	call   33b8 <unlink>
  if(link("lf2", "lf1") >= 0){
    1add:	c7 44 24 04 6a 40 00 	movl   $0x406a,0x4(%esp)
    1ae4:	00 
    1ae5:	c7 04 24 6e 40 00 00 	movl   $0x406e,(%esp)
    1aec:	e8 d7 18 00 00       	call   33c8 <link>
    1af1:	85 c0                	test   %eax,%eax
    1af3:	79 64                	jns    1b59 <linktest+0x1a9>
    printf(1, "link non-existant succeeded! oops\n");
    exit();
  }

  if(link(".", "lf1") >= 0){
    1af5:	c7 44 24 04 6a 40 00 	movl   $0x406a,0x4(%esp)
    1afc:	00 
    1afd:	c7 04 24 1f 3e 00 00 	movl   $0x3e1f,(%esp)
    1b04:	e8 bf 18 00 00       	call   33c8 <link>
    1b09:	85 c0                	test   %eax,%eax
    1b0b:	79 33                	jns    1b40 <linktest+0x190>
    printf(1, "link . lf1 succeeded! oops\n");
    exit();
  }

  printf(1, "linktest ok\n");
    1b0d:	c7 44 24 04 0e 41 00 	movl   $0x410e,0x4(%esp)
    1b14:	00 
    1b15:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b1c:	e8 9f 19 00 00       	call   34c0 <printf>
}
    1b21:	83 c4 14             	add    $0x14,%esp
    1b24:	5b                   	pop    %ebx
    1b25:	5d                   	pop    %ebp
    1b26:	c3                   	ret    
  unlink("lf1");
  unlink("lf2");

  fd = open("lf1", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "create lf1 failed\n");
    1b27:	c7 44 24 04 72 40 00 	movl   $0x4072,0x4(%esp)
    1b2e:	00 
    1b2f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b36:	e8 85 19 00 00       	call   34c0 <printf>
    exit();
    1b3b:	e8 28 18 00 00       	call   3368 <exit>
    printf(1, "link non-existant succeeded! oops\n");
    exit();
  }

  if(link(".", "lf1") >= 0){
    printf(1, "link . lf1 succeeded! oops\n");
    1b40:	c7 44 24 04 f2 40 00 	movl   $0x40f2,0x4(%esp)
    1b47:	00 
    1b48:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b4f:	e8 6c 19 00 00       	call   34c0 <printf>
    exit();
    1b54:	e8 0f 18 00 00       	call   3368 <exit>
    exit();
  }

  unlink("lf2");
  if(link("lf2", "lf1") >= 0){
    printf(1, "link non-existant succeeded! oops\n");
    1b59:	c7 44 24 04 48 4b 00 	movl   $0x4b48,0x4(%esp)
    1b60:	00 
    1b61:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b68:	e8 53 19 00 00       	call   34c0 <printf>
    exit();
    1b6d:	e8 f6 17 00 00       	call   3368 <exit>
    exit();
  }
  close(fd);

  if(link("lf2", "lf2") >= 0){
    printf(1, "link lf2 lf2 succeeded! oops\n");
    1b72:	c7 44 24 04 d4 40 00 	movl   $0x40d4,0x4(%esp)
    1b79:	00 
    1b7a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b81:	e8 3a 19 00 00       	call   34c0 <printf>
    exit();
    1b86:	e8 dd 17 00 00       	call   3368 <exit>
  if(fd < 0){
    printf(1, "open lf2 failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "read lf2 failed\n");
    1b8b:	c7 44 24 04 c3 40 00 	movl   $0x40c3,0x4(%esp)
    1b92:	00 
    1b93:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b9a:	e8 21 19 00 00       	call   34c0 <printf>
    exit();
    1b9f:	e8 c4 17 00 00       	call   3368 <exit>
    exit();
  }

  fd = open("lf2", 0);
  if(fd < 0){
    printf(1, "open lf2 failed\n");
    1ba4:	c7 44 24 04 b2 40 00 	movl   $0x40b2,0x4(%esp)
    1bab:	00 
    1bac:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1bb3:	e8 08 19 00 00       	call   34c0 <printf>
    exit();
    1bb8:	e8 ab 17 00 00       	call   3368 <exit>
    exit();
  }
  unlink("lf1");

  if(open("lf1", 0) >= 0){
    printf(1, "unlinked lf1 but it is still there!\n");
    1bbd:	c7 44 24 04 20 4b 00 	movl   $0x4b20,0x4(%esp)
    1bc4:	00 
    1bc5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1bcc:	e8 ef 18 00 00       	call   34c0 <printf>
    exit();
    1bd1:	e8 92 17 00 00       	call   3368 <exit>
    exit();
  }
  close(fd);

  if(link("lf1", "lf2") < 0){
    printf(1, "link lf1 lf2 failed\n");
    1bd6:	c7 44 24 04 9d 40 00 	movl   $0x409d,0x4(%esp)
    1bdd:	00 
    1bde:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1be5:	e8 d6 18 00 00       	call   34c0 <printf>
    exit();
    1bea:	e8 79 17 00 00       	call   3368 <exit>
  if(fd < 0){
    printf(1, "create lf1 failed\n");
    exit();
  }
  if(write(fd, "hello", 5) != 5){
    printf(1, "write lf1 failed\n");
    1bef:	c7 44 24 04 8b 40 00 	movl   $0x408b,0x4(%esp)
    1bf6:	00 
    1bf7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1bfe:	e8 bd 18 00 00       	call   34c0 <printf>
    exit();
    1c03:	e8 60 17 00 00       	call   3368 <exit>
    1c08:	90                   	nop
    1c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001c10 <unlinkread>:
}

// can I unlink a file and still read it?
void
unlinkread(void)
{
    1c10:	55                   	push   %ebp
    1c11:	89 e5                	mov    %esp,%ebp
    1c13:	56                   	push   %esi
    1c14:	53                   	push   %ebx
    1c15:	83 ec 10             	sub    $0x10,%esp
  int fd, fd1;

  printf(1, "unlinkread test\n");
    1c18:	c7 44 24 04 1b 41 00 	movl   $0x411b,0x4(%esp)
    1c1f:	00 
    1c20:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c27:	e8 94 18 00 00       	call   34c0 <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1c2c:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1c33:	00 
    1c34:	c7 04 24 2c 41 00 00 	movl   $0x412c,(%esp)
    1c3b:	e8 68 17 00 00       	call   33a8 <open>
  if(fd < 0){
    1c40:	85 c0                	test   %eax,%eax
unlinkread(void)
{
  int fd, fd1;

  printf(1, "unlinkread test\n");
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1c42:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1c44:	0f 88 fe 00 00 00    	js     1d48 <unlinkread+0x138>
    printf(1, "create unlinkread failed\n");
    exit();
  }
  write(fd, "hello", 5);
    1c4a:	c7 44 24 08 05 00 00 	movl   $0x5,0x8(%esp)
    1c51:	00 
    1c52:	c7 44 24 04 85 40 00 	movl   $0x4085,0x4(%esp)
    1c59:	00 
    1c5a:	89 04 24             	mov    %eax,(%esp)
    1c5d:	e8 26 17 00 00       	call   3388 <write>
  close(fd);
    1c62:	89 1c 24             	mov    %ebx,(%esp)
    1c65:	e8 26 17 00 00       	call   3390 <close>

  fd = open("unlinkread", O_RDWR);
    1c6a:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    1c71:	00 
    1c72:	c7 04 24 2c 41 00 00 	movl   $0x412c,(%esp)
    1c79:	e8 2a 17 00 00       	call   33a8 <open>
  if(fd < 0){
    1c7e:	85 c0                	test   %eax,%eax
    exit();
  }
  write(fd, "hello", 5);
  close(fd);

  fd = open("unlinkread", O_RDWR);
    1c80:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1c82:	0f 88 3d 01 00 00    	js     1dc5 <unlinkread+0x1b5>
    printf(1, "open unlinkread failed\n");
    exit();
  }
  if(unlink("unlinkread") != 0){
    1c88:	c7 04 24 2c 41 00 00 	movl   $0x412c,(%esp)
    1c8f:	e8 24 17 00 00       	call   33b8 <unlink>
    1c94:	85 c0                	test   %eax,%eax
    1c96:	0f 85 10 01 00 00    	jne    1dac <unlinkread+0x19c>
    printf(1, "unlink unlinkread failed\n");
    exit();
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    1c9c:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1ca3:	00 
    1ca4:	c7 04 24 2c 41 00 00 	movl   $0x412c,(%esp)
    1cab:	e8 f8 16 00 00       	call   33a8 <open>
  write(fd1, "yyy", 3);
    1cb0:	c7 44 24 08 03 00 00 	movl   $0x3,0x8(%esp)
    1cb7:	00 
    1cb8:	c7 44 24 04 83 41 00 	movl   $0x4183,0x4(%esp)
    1cbf:	00 
  if(unlink("unlinkread") != 0){
    printf(1, "unlink unlinkread failed\n");
    exit();
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    1cc0:	89 c6                	mov    %eax,%esi
  write(fd1, "yyy", 3);
    1cc2:	89 04 24             	mov    %eax,(%esp)
    1cc5:	e8 be 16 00 00       	call   3388 <write>
  close(fd1);
    1cca:	89 34 24             	mov    %esi,(%esp)
    1ccd:	e8 be 16 00 00       	call   3390 <close>

  if(read(fd, buf, sizeof(buf)) != 5){
    1cd2:	c7 44 24 08 00 08 00 	movl   $0x800,0x8(%esp)
    1cd9:	00 
    1cda:	c7 44 24 04 a0 4d 00 	movl   $0x4da0,0x4(%esp)
    1ce1:	00 
    1ce2:	89 1c 24             	mov    %ebx,(%esp)
    1ce5:	e8 96 16 00 00       	call   3380 <read>
    1cea:	83 f8 05             	cmp    $0x5,%eax
    1ced:	0f 85 a0 00 00 00    	jne    1d93 <unlinkread+0x183>
    printf(1, "unlinkread read failed");
    exit();
  }
  if(buf[0] != 'h'){
    1cf3:	80 3d a0 4d 00 00 68 	cmpb   $0x68,0x4da0
    1cfa:	75 7e                	jne    1d7a <unlinkread+0x16a>
    printf(1, "unlinkread wrong data\n");
    exit();
  }
  if(write(fd, buf, 10) != 10){
    1cfc:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1d03:	00 
    1d04:	c7 44 24 04 a0 4d 00 	movl   $0x4da0,0x4(%esp)
    1d0b:	00 
    1d0c:	89 1c 24             	mov    %ebx,(%esp)
    1d0f:	e8 74 16 00 00       	call   3388 <write>
    1d14:	83 f8 0a             	cmp    $0xa,%eax
    1d17:	75 48                	jne    1d61 <unlinkread+0x151>
    printf(1, "unlinkread write failed\n");
    exit();
  }
  close(fd);
    1d19:	89 1c 24             	mov    %ebx,(%esp)
    1d1c:	e8 6f 16 00 00       	call   3390 <close>
  unlink("unlinkread");
    1d21:	c7 04 24 2c 41 00 00 	movl   $0x412c,(%esp)
    1d28:	e8 8b 16 00 00       	call   33b8 <unlink>
  printf(1, "unlinkread ok\n");
    1d2d:	c7 44 24 04 ce 41 00 	movl   $0x41ce,0x4(%esp)
    1d34:	00 
    1d35:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d3c:	e8 7f 17 00 00       	call   34c0 <printf>
}
    1d41:	83 c4 10             	add    $0x10,%esp
    1d44:	5b                   	pop    %ebx
    1d45:	5e                   	pop    %esi
    1d46:	5d                   	pop    %ebp
    1d47:	c3                   	ret    
  int fd, fd1;

  printf(1, "unlinkread test\n");
  fd = open("unlinkread", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create unlinkread failed\n");
    1d48:	c7 44 24 04 37 41 00 	movl   $0x4137,0x4(%esp)
    1d4f:	00 
    1d50:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d57:	e8 64 17 00 00       	call   34c0 <printf>
    exit();
    1d5c:	e8 07 16 00 00       	call   3368 <exit>
  if(buf[0] != 'h'){
    printf(1, "unlinkread wrong data\n");
    exit();
  }
  if(write(fd, buf, 10) != 10){
    printf(1, "unlinkread write failed\n");
    1d61:	c7 44 24 04 b5 41 00 	movl   $0x41b5,0x4(%esp)
    1d68:	00 
    1d69:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d70:	e8 4b 17 00 00       	call   34c0 <printf>
    exit();
    1d75:	e8 ee 15 00 00       	call   3368 <exit>
  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "unlinkread read failed");
    exit();
  }
  if(buf[0] != 'h'){
    printf(1, "unlinkread wrong data\n");
    1d7a:	c7 44 24 04 9e 41 00 	movl   $0x419e,0x4(%esp)
    1d81:	00 
    1d82:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d89:	e8 32 17 00 00       	call   34c0 <printf>
    exit();
    1d8e:	e8 d5 15 00 00       	call   3368 <exit>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
  write(fd1, "yyy", 3);
  close(fd1);

  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "unlinkread read failed");
    1d93:	c7 44 24 04 87 41 00 	movl   $0x4187,0x4(%esp)
    1d9a:	00 
    1d9b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1da2:	e8 19 17 00 00       	call   34c0 <printf>
    exit();
    1da7:	e8 bc 15 00 00       	call   3368 <exit>
  if(fd < 0){
    printf(1, "open unlinkread failed\n");
    exit();
  }
  if(unlink("unlinkread") != 0){
    printf(1, "unlink unlinkread failed\n");
    1dac:	c7 44 24 04 69 41 00 	movl   $0x4169,0x4(%esp)
    1db3:	00 
    1db4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1dbb:	e8 00 17 00 00       	call   34c0 <printf>
    exit();
    1dc0:	e8 a3 15 00 00       	call   3368 <exit>
  write(fd, "hello", 5);
  close(fd);

  fd = open("unlinkread", O_RDWR);
  if(fd < 0){
    printf(1, "open unlinkread failed\n");
    1dc5:	c7 44 24 04 51 41 00 	movl   $0x4151,0x4(%esp)
    1dcc:	00 
    1dcd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1dd4:	e8 e7 16 00 00       	call   34c0 <printf>
    exit();
    1dd9:	e8 8a 15 00 00       	call   3368 <exit>
    1dde:	66 90                	xchg   %ax,%ax

00001de0 <createdelete>:
}

// two processes create and delete different files in same directory
void
createdelete(void)
{
    1de0:	55                   	push   %ebp
    1de1:	89 e5                	mov    %esp,%ebp
    1de3:	57                   	push   %edi
    1de4:	56                   	push   %esi
    1de5:	53                   	push   %ebx
    1de6:	83 ec 4c             	sub    $0x4c,%esp
  enum { N = 20 };
  int pid, i, fd;
  char name[32];

  printf(1, "createdelete test\n");
    1de9:	c7 44 24 04 dd 41 00 	movl   $0x41dd,0x4(%esp)
    1df0:	00 
    1df1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1df8:	e8 c3 16 00 00       	call   34c0 <printf>
  pid = fork();
    1dfd:	e8 5e 15 00 00       	call   3360 <fork>
  if(pid < 0){
    1e02:	85 c0                	test   %eax,%eax
  enum { N = 20 };
  int pid, i, fd;
  char name[32];

  printf(1, "createdelete test\n");
  pid = fork();
    1e04:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  if(pid < 0){
    1e07:	0f 88 14 02 00 00    	js     2021 <createdelete+0x241>
    printf(1, "fork failed\n");
    exit();
  }

  name[0] = pid ? 'p' : 'c';
    1e0d:	83 7d c4 01          	cmpl   $0x1,-0x3c(%ebp)
  name[2] = '\0';
    1e11:	bf 01 00 00 00       	mov    $0x1,%edi
    1e16:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    1e1a:	8d 75 c8             	lea    -0x38(%ebp),%esi
  if(pid < 0){
    printf(1, "fork failed\n");
    exit();
  }

  name[0] = pid ? 'p' : 'c';
    1e1d:	19 c0                	sbb    %eax,%eax
  name[2] = '\0';
    1e1f:	31 db                	xor    %ebx,%ebx
  if(pid < 0){
    printf(1, "fork failed\n");
    exit();
  }

  name[0] = pid ? 'p' : 'c';
    1e21:	83 e0 f3             	and    $0xfffffff3,%eax
    1e24:	83 c0 70             	add    $0x70,%eax
    1e27:	88 45 c8             	mov    %al,-0x38(%ebp)
    1e2a:	eb 0f                	jmp    1e3b <createdelete+0x5b>
    1e2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  name[2] = '\0';
  for(i = 0; i < N; i++){
    1e30:	83 ff 13             	cmp    $0x13,%edi
    1e33:	7f 6b                	jg     1ea0 <createdelete+0xc0>
    printf(1, "fork failed\n");
    exit();
  }

  name[0] = pid ? 'p' : 'c';
  name[2] = '\0';
    1e35:	83 c3 01             	add    $0x1,%ebx
    1e38:	83 c7 01             	add    $0x1,%edi
  for(i = 0; i < N; i++){
    name[1] = '0' + i;
    1e3b:	8d 43 30             	lea    0x30(%ebx),%eax
    1e3e:	88 45 c9             	mov    %al,-0x37(%ebp)
    fd = open(name, O_CREATE | O_RDWR);
    1e41:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1e48:	00 
    1e49:	89 34 24             	mov    %esi,(%esp)
    1e4c:	e8 57 15 00 00       	call   33a8 <open>
    if(fd < 0){
    1e51:	85 c0                	test   %eax,%eax
    1e53:	0f 88 3e 01 00 00    	js     1f97 <createdelete+0x1b7>
      printf(1, "create failed\n");
      exit();
    }
    close(fd);
    1e59:	89 04 24             	mov    %eax,(%esp)
    1e5c:	e8 2f 15 00 00       	call   3390 <close>
    if(i > 0 && (i % 2 ) == 0){
    1e61:	85 db                	test   %ebx,%ebx
    1e63:	74 d0                	je     1e35 <createdelete+0x55>
    1e65:	f6 c3 01             	test   $0x1,%bl
    1e68:	75 c6                	jne    1e30 <createdelete+0x50>
      name[1] = '0' + (i / 2);
    1e6a:	89 d8                	mov    %ebx,%eax
    1e6c:	d1 f8                	sar    %eax
    1e6e:	83 c0 30             	add    $0x30,%eax
    1e71:	88 45 c9             	mov    %al,-0x37(%ebp)
      if(unlink(name) < 0){
    1e74:	89 34 24             	mov    %esi,(%esp)
    1e77:	e8 3c 15 00 00       	call   33b8 <unlink>
    1e7c:	85 c0                	test   %eax,%eax
    1e7e:	79 b0                	jns    1e30 <createdelete+0x50>
        printf(1, "unlink failed\n");
    1e80:	c7 44 24 04 f0 41 00 	movl   $0x41f0,0x4(%esp)
    1e87:	00 
    1e88:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e8f:	e8 2c 16 00 00       	call   34c0 <printf>
        exit();
    1e94:	e8 cf 14 00 00       	call   3368 <exit>
    1e99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      }
    }
  }

  if(pid==0)
    1ea0:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    1ea3:	85 c0                	test   %eax,%eax
    1ea5:	0f 84 71 01 00 00    	je     201c <createdelete+0x23c>
    exit();
  else
    wait();
    1eab:	e8 c0 14 00 00       	call   3370 <wait>
    1eb0:	31 db                	xor    %ebx,%ebx
    1eb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  for(i = 0; i < N; i++){
    name[0] = 'p';
    1eb8:	8d 7b 30             	lea    0x30(%ebx),%edi
    name[1] = '0' + i;
    1ebb:	89 f8                	mov    %edi,%eax
    exit();
  else
    wait();

  for(i = 0; i < N; i++){
    name[0] = 'p';
    1ebd:	c6 45 c8 70          	movb   $0x70,-0x38(%ebp)
    name[1] = '0' + i;
    1ec1:	88 45 c9             	mov    %al,-0x37(%ebp)
    fd = open(name, 0);
    1ec4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1ecb:	00 
    1ecc:	89 34 24             	mov    %esi,(%esp)
    1ecf:	e8 d4 14 00 00       	call   33a8 <open>
    if((i == 0 || i >= N/2) && fd < 0){
    1ed4:	83 fb 09             	cmp    $0x9,%ebx
    1ed7:	0f 9f c1             	setg   %cl
    1eda:	85 db                	test   %ebx,%ebx
    1edc:	0f 94 c2             	sete   %dl
    1edf:	08 d1                	or     %dl,%cl
    1ee1:	88 4d c3             	mov    %cl,-0x3d(%ebp)
    1ee4:	74 08                	je     1eee <createdelete+0x10e>
    1ee6:	85 c0                	test   %eax,%eax
    1ee8:	0f 88 16 01 00 00    	js     2004 <createdelete+0x224>
      printf(1, "oops createdelete %s didn't exist\n", name);
      exit();
    } else if((i >= 1 && i < N/2) && fd >= 0){
    1eee:	8d 53 ff             	lea    -0x1(%ebx),%edx
    1ef1:	83 fa 08             	cmp    $0x8,%edx
    1ef4:	89 c2                	mov    %eax,%edx
    1ef6:	f7 d2                	not    %edx
    1ef8:	0f 96 45 c4          	setbe  -0x3c(%ebp)
    1efc:	c1 ea 1f             	shr    $0x1f,%edx
    1eff:	80 7d c4 00          	cmpb   $0x0,-0x3c(%ebp)
    1f03:	0f 85 b9 00 00 00    	jne    1fc2 <createdelete+0x1e2>
      printf(1, "oops createdelete %s did exist\n", name);
      exit();
    }
    if(fd >= 0)
    1f09:	84 d2                	test   %dl,%dl
    1f0b:	74 08                	je     1f15 <createdelete+0x135>
      close(fd);
    1f0d:	89 04 24             	mov    %eax,(%esp)
    1f10:	e8 7b 14 00 00       	call   3390 <close>

    name[0] = 'c';
    name[1] = '0' + i;
    1f15:	89 f8                	mov    %edi,%eax
      exit();
    }
    if(fd >= 0)
      close(fd);

    name[0] = 'c';
    1f17:	c6 45 c8 63          	movb   $0x63,-0x38(%ebp)
    name[1] = '0' + i;
    1f1b:	88 45 c9             	mov    %al,-0x37(%ebp)
    fd = open(name, 0);
    1f1e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1f25:	00 
    1f26:	89 34 24             	mov    %esi,(%esp)
    1f29:	e8 7a 14 00 00       	call   33a8 <open>
    if((i == 0 || i >= N/2) && fd < 0){
    1f2e:	80 7d c3 00          	cmpb   $0x0,-0x3d(%ebp)
    1f32:	74 08                	je     1f3c <createdelete+0x15c>
    1f34:	85 c0                	test   %eax,%eax
    1f36:	0f 88 ab 00 00 00    	js     1fe7 <createdelete+0x207>
      printf(1, "oops createdelete %s didn't exist\n", name);
      exit();
    } else if((i >= 1 && i < N/2) && fd >= 0){
    1f3c:	85 c0                	test   %eax,%eax
    1f3e:	66 90                	xchg   %ax,%ax
    1f40:	79 6e                	jns    1fb0 <createdelete+0x1d0>
  if(pid==0)
    exit();
  else
    wait();

  for(i = 0; i < N; i++){
    1f42:	83 c3 01             	add    $0x1,%ebx
    1f45:	83 fb 14             	cmp    $0x14,%ebx
    1f48:	0f 85 6a ff ff ff    	jne    1eb8 <createdelete+0xd8>
    1f4e:	bb 30 00 00 00       	mov    $0x30,%ebx
    1f53:	90                   	nop
    1f54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      close(fd);
  }

  for(i = 0; i < N; i++){
    name[0] = 'p';
    name[1] = '0' + i;
    1f58:	88 5d c9             	mov    %bl,-0x37(%ebp)
    unlink(name);
    name[0] = 'c';
    unlink(name);
    1f5b:	83 c3 01             	add    $0x1,%ebx
    if(fd >= 0)
      close(fd);
  }

  for(i = 0; i < N; i++){
    name[0] = 'p';
    1f5e:	c6 45 c8 70          	movb   $0x70,-0x38(%ebp)
    name[1] = '0' + i;
    unlink(name);
    1f62:	89 34 24             	mov    %esi,(%esp)
    1f65:	e8 4e 14 00 00       	call   33b8 <unlink>
    name[0] = 'c';
    1f6a:	c6 45 c8 63          	movb   $0x63,-0x38(%ebp)
    unlink(name);
    1f6e:	89 34 24             	mov    %esi,(%esp)
    1f71:	e8 42 14 00 00       	call   33b8 <unlink>
    }
    if(fd >= 0)
      close(fd);
  }

  for(i = 0; i < N; i++){
    1f76:	80 fb 44             	cmp    $0x44,%bl
    1f79:	75 dd                	jne    1f58 <createdelete+0x178>
    unlink(name);
    name[0] = 'c';
    unlink(name);
  }

  printf(1, "createdelete ok\n");
    1f7b:	c7 44 24 04 ff 41 00 	movl   $0x41ff,0x4(%esp)
    1f82:	00 
    1f83:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1f8a:	e8 31 15 00 00       	call   34c0 <printf>
}
    1f8f:	83 c4 4c             	add    $0x4c,%esp
    1f92:	5b                   	pop    %ebx
    1f93:	5e                   	pop    %esi
    1f94:	5f                   	pop    %edi
    1f95:	5d                   	pop    %ebp
    1f96:	c3                   	ret    
  name[2] = '\0';
  for(i = 0; i < N; i++){
    name[1] = '0' + i;
    fd = open(name, O_CREATE | O_RDWR);
    if(fd < 0){
      printf(1, "create failed\n");
    1f97:	c7 44 24 04 1d 40 00 	movl   $0x401d,0x4(%esp)
    1f9e:	00 
    1f9f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1fa6:	e8 15 15 00 00       	call   34c0 <printf>
      exit();
    1fab:	e8 b8 13 00 00       	call   3368 <exit>
    name[1] = '0' + i;
    fd = open(name, 0);
    if((i == 0 || i >= N/2) && fd < 0){
      printf(1, "oops createdelete %s didn't exist\n", name);
      exit();
    } else if((i >= 1 && i < N/2) && fd >= 0){
    1fb0:	80 7d c4 00          	cmpb   $0x0,-0x3c(%ebp)
    1fb4:	75 14                	jne    1fca <createdelete+0x1ea>
      printf(1, "oops createdelete %s did exist\n", name);
      exit();
    }
    if(fd >= 0)
      close(fd);
    1fb6:	89 04 24             	mov    %eax,(%esp)
    1fb9:	e8 d2 13 00 00       	call   3390 <close>
    1fbe:	66 90                	xchg   %ax,%ax
    1fc0:	eb 80                	jmp    1f42 <createdelete+0x162>
    name[1] = '0' + i;
    fd = open(name, 0);
    if((i == 0 || i >= N/2) && fd < 0){
      printf(1, "oops createdelete %s didn't exist\n", name);
      exit();
    } else if((i >= 1 && i < N/2) && fd >= 0){
    1fc2:	84 d2                	test   %dl,%dl
    1fc4:	0f 84 4b ff ff ff    	je     1f15 <createdelete+0x135>
    fd = open(name, 0);
    if((i == 0 || i >= N/2) && fd < 0){
      printf(1, "oops createdelete %s didn't exist\n", name);
      exit();
    } else if((i >= 1 && i < N/2) && fd >= 0){
      printf(1, "oops createdelete %s did exist\n", name);
    1fca:	89 74 24 08          	mov    %esi,0x8(%esp)
    1fce:	c7 44 24 04 90 4b 00 	movl   $0x4b90,0x4(%esp)
    1fd5:	00 
    1fd6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1fdd:	e8 de 14 00 00       	call   34c0 <printf>
      exit();
    1fe2:	e8 81 13 00 00       	call   3368 <exit>

    name[0] = 'c';
    name[1] = '0' + i;
    fd = open(name, 0);
    if((i == 0 || i >= N/2) && fd < 0){
      printf(1, "oops createdelete %s didn't exist\n", name);
    1fe7:	89 74 24 08          	mov    %esi,0x8(%esp)
    1feb:	c7 44 24 04 6c 4b 00 	movl   $0x4b6c,0x4(%esp)
    1ff2:	00 
    1ff3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ffa:	e8 c1 14 00 00       	call   34c0 <printf>
      exit();
    1fff:	e8 64 13 00 00       	call   3368 <exit>
  for(i = 0; i < N; i++){
    name[0] = 'p';
    name[1] = '0' + i;
    fd = open(name, 0);
    if((i == 0 || i >= N/2) && fd < 0){
      printf(1, "oops createdelete %s didn't exist\n", name);
    2004:	89 74 24 08          	mov    %esi,0x8(%esp)
    2008:	c7 44 24 04 6c 4b 00 	movl   $0x4b6c,0x4(%esp)
    200f:	00 
    2010:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2017:	e8 a4 14 00 00       	call   34c0 <printf>
      exit();
    201c:	e8 47 13 00 00       	call   3368 <exit>
  char name[32];

  printf(1, "createdelete test\n");
  pid = fork();
  if(pid < 0){
    printf(1, "fork failed\n");
    2021:	c7 44 24 04 69 39 00 	movl   $0x3969,0x4(%esp)
    2028:	00 
    2029:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2030:	e8 8b 14 00 00       	call   34c0 <printf>
    exit();
    2035:	e8 2e 13 00 00       	call   3368 <exit>
    203a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00002040 <dirtest>:
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
}

void dirtest(void)
{
    2040:	55                   	push   %ebp
    2041:	89 e5                	mov    %esp,%ebp
    2043:	83 ec 18             	sub    $0x18,%esp
  printf(stdout, "mkdir test\n");
    2046:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    204b:	c7 44 24 04 10 42 00 	movl   $0x4210,0x4(%esp)
    2052:	00 
    2053:	89 04 24             	mov    %eax,(%esp)
    2056:	e8 65 14 00 00       	call   34c0 <printf>

  if(mkdir("dir0") < 0) {
    205b:	c7 04 24 1c 42 00 00 	movl   $0x421c,(%esp)
    2062:	e8 69 13 00 00       	call   33d0 <mkdir>
    2067:	85 c0                	test   %eax,%eax
    2069:	78 4b                	js     20b6 <dirtest+0x76>
    printf(stdout, "mkdir failed\n");
    exit();
  }

  if(chdir("dir0") < 0) {
    206b:	c7 04 24 1c 42 00 00 	movl   $0x421c,(%esp)
    2072:	e8 61 13 00 00       	call   33d8 <chdir>
    2077:	85 c0                	test   %eax,%eax
    2079:	0f 88 85 00 00 00    	js     2104 <dirtest+0xc4>
    printf(stdout, "chdir dir0 failed\n");
    exit();
  }

  if(chdir("..") < 0) {
    207f:	c7 04 24 1e 3e 00 00 	movl   $0x3e1e,(%esp)
    2086:	e8 4d 13 00 00       	call   33d8 <chdir>
    208b:	85 c0                	test   %eax,%eax
    208d:	78 5b                	js     20ea <dirtest+0xaa>
    printf(stdout, "chdir .. failed\n");
    exit();
  }

  if(unlink("dir0") < 0) {
    208f:	c7 04 24 1c 42 00 00 	movl   $0x421c,(%esp)
    2096:	e8 1d 13 00 00       	call   33b8 <unlink>
    209b:	85 c0                	test   %eax,%eax
    209d:	78 31                	js     20d0 <dirtest+0x90>
    printf(stdout, "unlink dir0 failed\n");
    exit();
  }
  printf(stdout, "mkdir test\n");
    209f:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    20a4:	c7 44 24 04 10 42 00 	movl   $0x4210,0x4(%esp)
    20ab:	00 
    20ac:	89 04 24             	mov    %eax,(%esp)
    20af:	e8 0c 14 00 00       	call   34c0 <printf>
}
    20b4:	c9                   	leave  
    20b5:	c3                   	ret    
void dirtest(void)
{
  printf(stdout, "mkdir test\n");

  if(mkdir("dir0") < 0) {
    printf(stdout, "mkdir failed\n");
    20b6:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    20bb:	c7 44 24 04 21 42 00 	movl   $0x4221,0x4(%esp)
    20c2:	00 
    20c3:	89 04 24             	mov    %eax,(%esp)
    20c6:	e8 f5 13 00 00       	call   34c0 <printf>
    exit();
    20cb:	e8 98 12 00 00       	call   3368 <exit>
    printf(stdout, "chdir .. failed\n");
    exit();
  }

  if(unlink("dir0") < 0) {
    printf(stdout, "unlink dir0 failed\n");
    20d0:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    20d5:	c7 44 24 04 53 42 00 	movl   $0x4253,0x4(%esp)
    20dc:	00 
    20dd:	89 04 24             	mov    %eax,(%esp)
    20e0:	e8 db 13 00 00       	call   34c0 <printf>
    exit();
    20e5:	e8 7e 12 00 00       	call   3368 <exit>
    printf(stdout, "chdir dir0 failed\n");
    exit();
  }

  if(chdir("..") < 0) {
    printf(stdout, "chdir .. failed\n");
    20ea:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    20ef:	c7 44 24 04 42 42 00 	movl   $0x4242,0x4(%esp)
    20f6:	00 
    20f7:	89 04 24             	mov    %eax,(%esp)
    20fa:	e8 c1 13 00 00       	call   34c0 <printf>
    exit();
    20ff:	e8 64 12 00 00       	call   3368 <exit>
    printf(stdout, "mkdir failed\n");
    exit();
  }

  if(chdir("dir0") < 0) {
    printf(stdout, "chdir dir0 failed\n");
    2104:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    2109:	c7 44 24 04 2f 42 00 	movl   $0x422f,0x4(%esp)
    2110:	00 
    2111:	89 04 24             	mov    %eax,(%esp)
    2114:	e8 a7 13 00 00       	call   34c0 <printf>
    exit();
    2119:	e8 4a 12 00 00       	call   3368 <exit>
    211e:	66 90                	xchg   %ax,%ax

00002120 <createtest>:
  printf(stdout, "big files ok\n");
}

void
createtest(void)
{
    2120:	55                   	push   %ebp
    2121:	89 e5                	mov    %esp,%ebp
    2123:	53                   	push   %ebx
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
    2124:	bb 30 00 00 00       	mov    $0x30,%ebx
  printf(stdout, "big files ok\n");
}

void
createtest(void)
{
    2129:	83 ec 14             	sub    $0x14,%esp
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");
    212c:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    2131:	c7 44 24 04 b0 4b 00 	movl   $0x4bb0,0x4(%esp)
    2138:	00 
    2139:	89 04 24             	mov    %eax,(%esp)
    213c:	e8 7f 13 00 00       	call   34c0 <printf>

  name[0] = 'a';
    2141:	c6 05 a0 55 00 00 61 	movb   $0x61,0x55a0
  name[2] = '\0';
    2148:	c6 05 a2 55 00 00 00 	movb   $0x0,0x55a2
    214f:	90                   	nop
  for(i = 0; i < 52; i++) {
    name[1] = '0' + i;
    2150:	88 1d a1 55 00 00    	mov    %bl,0x55a1
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
    2156:	83 c3 01             	add    $0x1,%ebx

  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++) {
    name[1] = '0' + i;
    fd = open(name, O_CREATE|O_RDWR);
    2159:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    2160:	00 
    2161:	c7 04 24 a0 55 00 00 	movl   $0x55a0,(%esp)
    2168:	e8 3b 12 00 00       	call   33a8 <open>
    close(fd);
    216d:	89 04 24             	mov    %eax,(%esp)
    2170:	e8 1b 12 00 00       	call   3390 <close>

  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++) {
    2175:	80 fb 64             	cmp    $0x64,%bl
    2178:	75 d6                	jne    2150 <createtest+0x30>
    name[1] = '0' + i;
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
    217a:	c6 05 a0 55 00 00 61 	movb   $0x61,0x55a0
  name[2] = '\0';
    2181:	bb 30 00 00 00       	mov    $0x30,%ebx
    2186:	c6 05 a2 55 00 00 00 	movb   $0x0,0x55a2
    218d:	8d 76 00             	lea    0x0(%esi),%esi
  for(i = 0; i < 52; i++) {
    name[1] = '0' + i;
    2190:	88 1d a1 55 00 00    	mov    %bl,0x55a1
    unlink(name);
    2196:	83 c3 01             	add    $0x1,%ebx
    2199:	c7 04 24 a0 55 00 00 	movl   $0x55a0,(%esp)
    21a0:	e8 13 12 00 00       	call   33b8 <unlink>
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++) {
    21a5:	80 fb 64             	cmp    $0x64,%bl
    21a8:	75 e6                	jne    2190 <createtest+0x70>
    name[1] = '0' + i;
    unlink(name);
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
    21aa:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    21af:	c7 44 24 04 d8 4b 00 	movl   $0x4bd8,0x4(%esp)
    21b6:	00 
    21b7:	89 04 24             	mov    %eax,(%esp)
    21ba:	e8 01 13 00 00       	call   34c0 <printf>
}
    21bf:	83 c4 14             	add    $0x14,%esp
    21c2:	5b                   	pop    %ebx
    21c3:	5d                   	pop    %ebp
    21c4:	c3                   	ret    
    21c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    21c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000021d0 <writetest1>:
  printf(stdout, "small file test ok\n");
}

void
writetest1(void)
{
    21d0:	55                   	push   %ebp
    21d1:	89 e5                	mov    %esp,%ebp
    21d3:	56                   	push   %esi
    21d4:	53                   	push   %ebx
    21d5:	83 ec 10             	sub    $0x10,%esp
  int i, fd, n;

  printf(stdout, "big files test\n");
    21d8:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    21dd:	c7 44 24 04 67 42 00 	movl   $0x4267,0x4(%esp)
    21e4:	00 
    21e5:	89 04 24             	mov    %eax,(%esp)
    21e8:	e8 d3 12 00 00       	call   34c0 <printf>

  fd = open("big", O_CREATE|O_RDWR);
    21ed:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    21f4:	00 
    21f5:	c7 04 24 e1 42 00 00 	movl   $0x42e1,(%esp)
    21fc:	e8 a7 11 00 00       	call   33a8 <open>
  if(fd < 0){
    2201:	85 c0                	test   %eax,%eax
{
  int i, fd, n;

  printf(stdout, "big files test\n");

  fd = open("big", O_CREATE|O_RDWR);
    2203:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    2205:	0f 88 7a 01 00 00    	js     2385 <writetest1+0x1b5>
    printf(stdout, "error: creat big failed!\n");
    exit();
    220b:	31 db                	xor    %ebx,%ebx
    220d:	8d 76 00             	lea    0x0(%esi),%esi
  }

  for(i = 0; i < MAXFILE; i++) {
    ((int*) buf)[0] = i;
    2210:	89 1d a0 4d 00 00    	mov    %ebx,0x4da0
    if(write(fd, buf, 512) != 512) {
    2216:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    221d:	00 
    221e:	c7 44 24 04 a0 4d 00 	movl   $0x4da0,0x4(%esp)
    2225:	00 
    2226:	89 34 24             	mov    %esi,(%esp)
    2229:	e8 5a 11 00 00       	call   3388 <write>
    222e:	3d 00 02 00 00       	cmp    $0x200,%eax
    2233:	0f 85 b2 00 00 00    	jne    22eb <writetest1+0x11b>
  if(fd < 0){
    printf(stdout, "error: creat big failed!\n");
    exit();
  }

  for(i = 0; i < MAXFILE; i++) {
    2239:	83 c3 01             	add    $0x1,%ebx
    223c:	81 fb 8c 00 00 00    	cmp    $0x8c,%ebx
    2242:	75 cc                	jne    2210 <writetest1+0x40>
      printf(stdout, "error: write big file failed\n", i);
      exit();
    }
  }

  close(fd);
    2244:	89 34 24             	mov    %esi,(%esp)
    2247:	e8 44 11 00 00       	call   3390 <close>

  fd = open("big", O_RDONLY);
    224c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2253:	00 
    2254:	c7 04 24 e1 42 00 00 	movl   $0x42e1,(%esp)
    225b:	e8 48 11 00 00       	call   33a8 <open>
  if(fd < 0){
    2260:	85 c0                	test   %eax,%eax
    }
  }

  close(fd);

  fd = open("big", O_RDONLY);
    2262:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    2264:	0f 88 01 01 00 00    	js     236b <writetest1+0x19b>
    printf(stdout, "error: open big failed!\n");
    exit();
    226a:	31 db                	xor    %ebx,%ebx
    226c:	eb 1d                	jmp    228b <writetest1+0xbb>
    226e:	66 90                	xchg   %ax,%ax
      if(n == MAXFILE - 1) {
        printf(stdout, "read only %d blocks from big", n);
        exit();
      }
      break;
    } else if(i != 512) {
    2270:	3d 00 02 00 00       	cmp    $0x200,%eax
    2275:	0f 85 b0 00 00 00    	jne    232b <writetest1+0x15b>
      printf(stdout, "read failed %d\n", i);
      exit();
    }
    if(((int*)buf)[0] != n) {
    227b:	a1 a0 4d 00 00       	mov    0x4da0,%eax
    2280:	39 d8                	cmp    %ebx,%eax
    2282:	0f 85 81 00 00 00    	jne    2309 <writetest1+0x139>
      printf(stdout, "read content of block %d is %d\n",
             n, ((int*)buf)[0]);
      exit();
    }
    n++;
    2288:	83 c3 01             	add    $0x1,%ebx
    exit();
  }

  n = 0;
  for(;;) {
    i = read(fd, buf, 512);
    228b:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    2292:	00 
    2293:	c7 44 24 04 a0 4d 00 	movl   $0x4da0,0x4(%esp)
    229a:	00 
    229b:	89 34 24             	mov    %esi,(%esp)
    229e:	e8 dd 10 00 00       	call   3380 <read>
    if(i == 0) {
    22a3:	85 c0                	test   %eax,%eax
    22a5:	75 c9                	jne    2270 <writetest1+0xa0>
      if(n == MAXFILE - 1) {
    22a7:	81 fb 8b 00 00 00    	cmp    $0x8b,%ebx
    22ad:	0f 84 96 00 00 00    	je     2349 <writetest1+0x179>
             n, ((int*)buf)[0]);
      exit();
    }
    n++;
  }
  close(fd);
    22b3:	89 34 24             	mov    %esi,(%esp)
    22b6:	e8 d5 10 00 00       	call   3390 <close>
  if(unlink("big") < 0) {
    22bb:	c7 04 24 e1 42 00 00 	movl   $0x42e1,(%esp)
    22c2:	e8 f1 10 00 00       	call   33b8 <unlink>
    22c7:	85 c0                	test   %eax,%eax
    22c9:	0f 88 d0 00 00 00    	js     239f <writetest1+0x1cf>
    printf(stdout, "unlink big failed\n");
    exit();
  }
  printf(stdout, "big files ok\n");
    22cf:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    22d4:	c7 44 24 04 08 43 00 	movl   $0x4308,0x4(%esp)
    22db:	00 
    22dc:	89 04 24             	mov    %eax,(%esp)
    22df:	e8 dc 11 00 00       	call   34c0 <printf>
}
    22e4:	83 c4 10             	add    $0x10,%esp
    22e7:	5b                   	pop    %ebx
    22e8:	5e                   	pop    %esi
    22e9:	5d                   	pop    %ebp
    22ea:	c3                   	ret    
  }

  for(i = 0; i < MAXFILE; i++) {
    ((int*) buf)[0] = i;
    if(write(fd, buf, 512) != 512) {
      printf(stdout, "error: write big file failed\n", i);
    22eb:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    22f0:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    22f4:	c7 44 24 04 91 42 00 	movl   $0x4291,0x4(%esp)
    22fb:	00 
    22fc:	89 04 24             	mov    %eax,(%esp)
    22ff:	e8 bc 11 00 00       	call   34c0 <printf>
      exit();
    2304:	e8 5f 10 00 00       	call   3368 <exit>
    } else if(i != 512) {
      printf(stdout, "read failed %d\n", i);
      exit();
    }
    if(((int*)buf)[0] != n) {
      printf(stdout, "read content of block %d is %d\n",
    2309:	89 44 24 0c          	mov    %eax,0xc(%esp)
    230d:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    2312:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    2316:	c7 44 24 04 00 4c 00 	movl   $0x4c00,0x4(%esp)
    231d:	00 
    231e:	89 04 24             	mov    %eax,(%esp)
    2321:	e8 9a 11 00 00       	call   34c0 <printf>
             n, ((int*)buf)[0]);
      exit();
    2326:	e8 3d 10 00 00       	call   3368 <exit>
        printf(stdout, "read only %d blocks from big", n);
        exit();
      }
      break;
    } else if(i != 512) {
      printf(stdout, "read failed %d\n", i);
    232b:	89 44 24 08          	mov    %eax,0x8(%esp)
    232f:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    2334:	c7 44 24 04 e5 42 00 	movl   $0x42e5,0x4(%esp)
    233b:	00 
    233c:	89 04 24             	mov    %eax,(%esp)
    233f:	e8 7c 11 00 00       	call   34c0 <printf>
      exit();
    2344:	e8 1f 10 00 00       	call   3368 <exit>
  n = 0;
  for(;;) {
    i = read(fd, buf, 512);
    if(i == 0) {
      if(n == MAXFILE - 1) {
        printf(stdout, "read only %d blocks from big", n);
    2349:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    234e:	c7 44 24 08 8b 00 00 	movl   $0x8b,0x8(%esp)
    2355:	00 
    2356:	c7 44 24 04 c8 42 00 	movl   $0x42c8,0x4(%esp)
    235d:	00 
    235e:	89 04 24             	mov    %eax,(%esp)
    2361:	e8 5a 11 00 00       	call   34c0 <printf>
        exit();
    2366:	e8 fd 0f 00 00       	call   3368 <exit>

  close(fd);

  fd = open("big", O_RDONLY);
  if(fd < 0){
    printf(stdout, "error: open big failed!\n");
    236b:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    2370:	c7 44 24 04 af 42 00 	movl   $0x42af,0x4(%esp)
    2377:	00 
    2378:	89 04 24             	mov    %eax,(%esp)
    237b:	e8 40 11 00 00       	call   34c0 <printf>
    exit();
    2380:	e8 e3 0f 00 00       	call   3368 <exit>

  printf(stdout, "big files test\n");

  fd = open("big", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(stdout, "error: creat big failed!\n");
    2385:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    238a:	c7 44 24 04 77 42 00 	movl   $0x4277,0x4(%esp)
    2391:	00 
    2392:	89 04 24             	mov    %eax,(%esp)
    2395:	e8 26 11 00 00       	call   34c0 <printf>
    exit();
    239a:	e8 c9 0f 00 00       	call   3368 <exit>
    }
    n++;
  }
  close(fd);
  if(unlink("big") < 0) {
    printf(stdout, "unlink big failed\n");
    239f:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    23a4:	c7 44 24 04 f5 42 00 	movl   $0x42f5,0x4(%esp)
    23ab:	00 
    23ac:	89 04 24             	mov    %eax,(%esp)
    23af:	e8 0c 11 00 00       	call   34c0 <printf>
    exit();
    23b4:	e8 af 0f 00 00       	call   3368 <exit>
    23b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000023c0 <writetest>:
  printf(stdout, "open test ok\n");
}

void
writetest(void)
{
    23c0:	55                   	push   %ebp
    23c1:	89 e5                	mov    %esp,%ebp
    23c3:	56                   	push   %esi
    23c4:	53                   	push   %ebx
    23c5:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int i;

  printf(stdout, "small file test\n");
    23c8:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    23cd:	c7 44 24 04 16 43 00 	movl   $0x4316,0x4(%esp)
    23d4:	00 
    23d5:	89 04 24             	mov    %eax,(%esp)
    23d8:	e8 e3 10 00 00       	call   34c0 <printf>
  fd = open("small", O_CREATE|O_RDWR);
    23dd:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    23e4:	00 
    23e5:	c7 04 24 27 43 00 00 	movl   $0x4327,(%esp)
    23ec:	e8 b7 0f 00 00       	call   33a8 <open>
  if(fd >= 0){
    23f1:	85 c0                	test   %eax,%eax
{
  int fd;
  int i;

  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_RDWR);
    23f3:	89 c6                	mov    %eax,%esi
  if(fd >= 0){
    23f5:	0f 88 b1 01 00 00    	js     25ac <writetest+0x1ec>
    printf(stdout, "creat small succeeded; ok\n");
    23fb:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    2400:	31 db                	xor    %ebx,%ebx
    2402:	c7 44 24 04 2d 43 00 	movl   $0x432d,0x4(%esp)
    2409:	00 
    240a:	89 04 24             	mov    %eax,(%esp)
    240d:	e8 ae 10 00 00       	call   34c0 <printf>
    2412:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++) {
    if(write(fd, "aaaaaaaaaa", 10) != 10) {
    2418:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    241f:	00 
    2420:	c7 44 24 04 64 43 00 	movl   $0x4364,0x4(%esp)
    2427:	00 
    2428:	89 34 24             	mov    %esi,(%esp)
    242b:	e8 58 0f 00 00       	call   3388 <write>
    2430:	83 f8 0a             	cmp    $0xa,%eax
    2433:	0f 85 e9 00 00 00    	jne    2522 <writetest+0x162>
      printf(stdout, "error: write aa %d new file failed\n", i);
      exit();
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10) {
    2439:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    2440:	00 
    2441:	c7 44 24 04 6f 43 00 	movl   $0x436f,0x4(%esp)
    2448:	00 
    2449:	89 34 24             	mov    %esi,(%esp)
    244c:	e8 37 0f 00 00       	call   3388 <write>
    2451:	83 f8 0a             	cmp    $0xa,%eax
    2454:	0f 85 e6 00 00 00    	jne    2540 <writetest+0x180>
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++) {
    245a:	83 c3 01             	add    $0x1,%ebx
    245d:	83 fb 64             	cmp    $0x64,%ebx
    2460:	75 b6                	jne    2418 <writetest+0x58>
    if(write(fd, "bbbbbbbbbb", 10) != 10) {
      printf(stdout, "error: write bb %d new file failed\n", i);
      exit();
    }
  }
  printf(stdout, "writes ok\n");
    2462:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    2467:	c7 44 24 04 7a 43 00 	movl   $0x437a,0x4(%esp)
    246e:	00 
    246f:	89 04 24             	mov    %eax,(%esp)
    2472:	e8 49 10 00 00       	call   34c0 <printf>
  close(fd);
    2477:	89 34 24             	mov    %esi,(%esp)
    247a:	e8 11 0f 00 00       	call   3390 <close>
  fd = open("small", O_RDONLY);
    247f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2486:	00 
    2487:	c7 04 24 27 43 00 00 	movl   $0x4327,(%esp)
    248e:	e8 15 0f 00 00       	call   33a8 <open>
  if(fd >= 0){
    2493:	85 c0                	test   %eax,%eax
      exit();
    }
  }
  printf(stdout, "writes ok\n");
  close(fd);
  fd = open("small", O_RDONLY);
    2495:	89 c3                	mov    %eax,%ebx
  if(fd >= 0){
    2497:	0f 88 c1 00 00 00    	js     255e <writetest+0x19e>
    printf(stdout, "open small succeeded ok\n");
    249d:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    24a2:	c7 44 24 04 85 43 00 	movl   $0x4385,0x4(%esp)
    24a9:	00 
    24aa:	89 04 24             	mov    %eax,(%esp)
    24ad:	e8 0e 10 00 00       	call   34c0 <printf>
  } else {
    printf(stdout, "error: open small failed!\n");
    exit();
  }
  i = read(fd, buf, 2000);
    24b2:	c7 44 24 08 d0 07 00 	movl   $0x7d0,0x8(%esp)
    24b9:	00 
    24ba:	c7 44 24 04 a0 4d 00 	movl   $0x4da0,0x4(%esp)
    24c1:	00 
    24c2:	89 1c 24             	mov    %ebx,(%esp)
    24c5:	e8 b6 0e 00 00       	call   3380 <read>
  if(i == 2000) {
    24ca:	3d d0 07 00 00       	cmp    $0x7d0,%eax
    24cf:	0f 85 a3 00 00 00    	jne    2578 <writetest+0x1b8>
    printf(stdout, "read succeeded ok\n");
    24d5:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    24da:	c7 44 24 04 b9 43 00 	movl   $0x43b9,0x4(%esp)
    24e1:	00 
    24e2:	89 04 24             	mov    %eax,(%esp)
    24e5:	e8 d6 0f 00 00       	call   34c0 <printf>
  } else {
    printf(stdout, "read failed\n");
    exit();
  }
  close(fd);
    24ea:	89 1c 24             	mov    %ebx,(%esp)
    24ed:	e8 9e 0e 00 00       	call   3390 <close>

  if(unlink("small") < 0) {
    24f2:	c7 04 24 27 43 00 00 	movl   $0x4327,(%esp)
    24f9:	e8 ba 0e 00 00       	call   33b8 <unlink>
    24fe:	85 c0                	test   %eax,%eax
    2500:	0f 88 8c 00 00 00    	js     2592 <writetest+0x1d2>
    printf(stdout, "unlink small failed\n");
    exit();
  }
  printf(stdout, "small file test ok\n");
    2506:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    250b:	c7 44 24 04 e1 43 00 	movl   $0x43e1,0x4(%esp)
    2512:	00 
    2513:	89 04 24             	mov    %eax,(%esp)
    2516:	e8 a5 0f 00 00       	call   34c0 <printf>
}
    251b:	83 c4 10             	add    $0x10,%esp
    251e:	5b                   	pop    %ebx
    251f:	5e                   	pop    %esi
    2520:	5d                   	pop    %ebp
    2521:	c3                   	ret    
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++) {
    if(write(fd, "aaaaaaaaaa", 10) != 10) {
      printf(stdout, "error: write aa %d new file failed\n", i);
    2522:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    2527:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    252b:	c7 44 24 04 20 4c 00 	movl   $0x4c20,0x4(%esp)
    2532:	00 
    2533:	89 04 24             	mov    %eax,(%esp)
    2536:	e8 85 0f 00 00       	call   34c0 <printf>
      exit();
    253b:	e8 28 0e 00 00       	call   3368 <exit>
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10) {
      printf(stdout, "error: write bb %d new file failed\n", i);
    2540:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    2545:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    2549:	c7 44 24 04 44 4c 00 	movl   $0x4c44,0x4(%esp)
    2550:	00 
    2551:	89 04 24             	mov    %eax,(%esp)
    2554:	e8 67 0f 00 00       	call   34c0 <printf>
      exit();
    2559:	e8 0a 0e 00 00       	call   3368 <exit>
  close(fd);
  fd = open("small", O_RDONLY);
  if(fd >= 0){
    printf(stdout, "open small succeeded ok\n");
  } else {
    printf(stdout, "error: open small failed!\n");
    255e:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    2563:	c7 44 24 04 9e 43 00 	movl   $0x439e,0x4(%esp)
    256a:	00 
    256b:	89 04 24             	mov    %eax,(%esp)
    256e:	e8 4d 0f 00 00       	call   34c0 <printf>
    exit();
    2573:	e8 f0 0d 00 00       	call   3368 <exit>
  }
  i = read(fd, buf, 2000);
  if(i == 2000) {
    printf(stdout, "read succeeded ok\n");
  } else {
    printf(stdout, "read failed\n");
    2578:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    257d:	c7 44 24 04 44 41 00 	movl   $0x4144,0x4(%esp)
    2584:	00 
    2585:	89 04 24             	mov    %eax,(%esp)
    2588:	e8 33 0f 00 00       	call   34c0 <printf>
    exit();
    258d:	e8 d6 0d 00 00       	call   3368 <exit>
  }
  close(fd);

  if(unlink("small") < 0) {
    printf(stdout, "unlink small failed\n");
    2592:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    2597:	c7 44 24 04 cc 43 00 	movl   $0x43cc,0x4(%esp)
    259e:	00 
    259f:	89 04 24             	mov    %eax,(%esp)
    25a2:	e8 19 0f 00 00       	call   34c0 <printf>
    exit();
    25a7:	e8 bc 0d 00 00       	call   3368 <exit>
  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_RDWR);
  if(fd >= 0){
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
    25ac:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    25b1:	c7 44 24 04 48 43 00 	movl   $0x4348,0x4(%esp)
    25b8:	00 
    25b9:	89 04 24             	mov    %eax,(%esp)
    25bc:	e8 ff 0e 00 00       	call   34c0 <printf>
    exit();
    25c1:	e8 a2 0d 00 00       	call   3368 <exit>
    25c6:	8d 76 00             	lea    0x0(%esi),%esi
    25c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000025d0 <bigfile>:
  printf(1, "subdir ok\n");
}

void
bigfile(void)
{
    25d0:	55                   	push   %ebp
    25d1:	89 e5                	mov    %esp,%ebp
    25d3:	57                   	push   %edi
    25d4:	56                   	push   %esi
    25d5:	53                   	push   %ebx
    25d6:	83 ec 1c             	sub    $0x1c,%esp
  int fd, i, total, cc;

  printf(1, "bigfile test\n");
    25d9:	c7 44 24 04 f5 43 00 	movl   $0x43f5,0x4(%esp)
    25e0:	00 
    25e1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    25e8:	e8 d3 0e 00 00       	call   34c0 <printf>

  unlink("bigfile");
    25ed:	c7 04 24 11 44 00 00 	movl   $0x4411,(%esp)
    25f4:	e8 bf 0d 00 00       	call   33b8 <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
    25f9:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    2600:	00 
    2601:	c7 04 24 11 44 00 00 	movl   $0x4411,(%esp)
    2608:	e8 9b 0d 00 00       	call   33a8 <open>
  if(fd < 0){
    260d:	85 c0                	test   %eax,%eax
  int fd, i, total, cc;

  printf(1, "bigfile test\n");

  unlink("bigfile");
  fd = open("bigfile", O_CREATE | O_RDWR);
    260f:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    2611:	0f 88 7f 01 00 00    	js     2796 <bigfile+0x1c6>
    printf(1, "cannot create bigfile");
    exit();
    2617:	31 db                	xor    %ebx,%ebx
    2619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  for(i = 0; i < 20; i++){
    memset(buf, i, 600);
    2620:	c7 44 24 08 58 02 00 	movl   $0x258,0x8(%esp)
    2627:	00 
    2628:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    262c:	c7 04 24 a0 4d 00 00 	movl   $0x4da0,(%esp)
    2633:	e8 a8 0b 00 00       	call   31e0 <memset>
    if(write(fd, buf, 600) != 600){
    2638:	c7 44 24 08 58 02 00 	movl   $0x258,0x8(%esp)
    263f:	00 
    2640:	c7 44 24 04 a0 4d 00 	movl   $0x4da0,0x4(%esp)
    2647:	00 
    2648:	89 34 24             	mov    %esi,(%esp)
    264b:	e8 38 0d 00 00       	call   3388 <write>
    2650:	3d 58 02 00 00       	cmp    $0x258,%eax
    2655:	0f 85 09 01 00 00    	jne    2764 <bigfile+0x194>
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "cannot create bigfile");
    exit();
  }
  for(i = 0; i < 20; i++){
    265b:	83 c3 01             	add    $0x1,%ebx
    265e:	83 fb 14             	cmp    $0x14,%ebx
    2661:	75 bd                	jne    2620 <bigfile+0x50>
    if(write(fd, buf, 600) != 600){
      printf(1, "write bigfile failed\n");
      exit();
    }
  }
  close(fd);
    2663:	89 34 24             	mov    %esi,(%esp)
    2666:	e8 25 0d 00 00       	call   3390 <close>

  fd = open("bigfile", 0);
    266b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2672:	00 
    2673:	c7 04 24 11 44 00 00 	movl   $0x4411,(%esp)
    267a:	e8 29 0d 00 00       	call   33a8 <open>
  if(fd < 0){
    267f:	85 c0                	test   %eax,%eax
      exit();
    }
  }
  close(fd);

  fd = open("bigfile", 0);
    2681:	89 c7                	mov    %eax,%edi
  if(fd < 0){
    2683:	0f 88 f4 00 00 00    	js     277d <bigfile+0x1ad>
    printf(1, "cannot open bigfile\n");
    exit();
    2689:	31 f6                	xor    %esi,%esi
    268b:	31 db                	xor    %ebx,%ebx
    268d:	eb 2f                	jmp    26be <bigfile+0xee>
    268f:	90                   	nop
      printf(1, "read bigfile failed\n");
      exit();
    }
    if(cc == 0)
      break;
    if(cc != 300){
    2690:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    2695:	0f 85 97 00 00 00    	jne    2732 <bigfile+0x162>
      printf(1, "short read bigfile\n");
      exit();
    }
    if(buf[0] != i/2 || buf[299] != i/2){
    269b:	0f be 05 a0 4d 00 00 	movsbl 0x4da0,%eax
    26a2:	89 da                	mov    %ebx,%edx
    26a4:	d1 fa                	sar    %edx
    26a6:	39 d0                	cmp    %edx,%eax
    26a8:	75 6f                	jne    2719 <bigfile+0x149>
    26aa:	0f be 15 cb 4e 00 00 	movsbl 0x4ecb,%edx
    26b1:	39 d0                	cmp    %edx,%eax
    26b3:	75 64                	jne    2719 <bigfile+0x149>
      printf(1, "read bigfile wrong data\n");
      exit();
    }
    total += cc;
    26b5:	81 c6 2c 01 00 00    	add    $0x12c,%esi
  if(fd < 0){
    printf(1, "cannot open bigfile\n");
    exit();
  }
  total = 0;
  for(i = 0; ; i++){
    26bb:	83 c3 01             	add    $0x1,%ebx
    cc = read(fd, buf, 300);
    26be:	c7 44 24 08 2c 01 00 	movl   $0x12c,0x8(%esp)
    26c5:	00 
    26c6:	c7 44 24 04 a0 4d 00 	movl   $0x4da0,0x4(%esp)
    26cd:	00 
    26ce:	89 3c 24             	mov    %edi,(%esp)
    26d1:	e8 aa 0c 00 00       	call   3380 <read>
    if(cc < 0){
    26d6:	83 f8 00             	cmp    $0x0,%eax
    26d9:	7c 70                	jl     274b <bigfile+0x17b>
      printf(1, "read bigfile failed\n");
      exit();
    }
    if(cc == 0)
    26db:	75 b3                	jne    2690 <bigfile+0xc0>
      printf(1, "read bigfile wrong data\n");
      exit();
    }
    total += cc;
  }
  close(fd);
    26dd:	89 3c 24             	mov    %edi,(%esp)
    26e0:	e8 ab 0c 00 00       	call   3390 <close>
  if(total != 20*600){
    26e5:	81 fe e0 2e 00 00    	cmp    $0x2ee0,%esi
    26eb:	0f 85 be 00 00 00    	jne    27af <bigfile+0x1df>
    printf(1, "read bigfile wrong total\n");
    exit();
  }
  unlink("bigfile");
    26f1:	c7 04 24 11 44 00 00 	movl   $0x4411,(%esp)
    26f8:	e8 bb 0c 00 00       	call   33b8 <unlink>

  printf(1, "bigfile test ok\n");
    26fd:	c7 44 24 04 a0 44 00 	movl   $0x44a0,0x4(%esp)
    2704:	00 
    2705:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    270c:	e8 af 0d 00 00       	call   34c0 <printf>
}
    2711:	83 c4 1c             	add    $0x1c,%esp
    2714:	5b                   	pop    %ebx
    2715:	5e                   	pop    %esi
    2716:	5f                   	pop    %edi
    2717:	5d                   	pop    %ebp
    2718:	c3                   	ret    
    if(cc != 300){
      printf(1, "short read bigfile\n");
      exit();
    }
    if(buf[0] != i/2 || buf[299] != i/2){
      printf(1, "read bigfile wrong data\n");
    2719:	c7 44 24 04 6d 44 00 	movl   $0x446d,0x4(%esp)
    2720:	00 
    2721:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2728:	e8 93 0d 00 00       	call   34c0 <printf>
      exit();
    272d:	e8 36 0c 00 00       	call   3368 <exit>
      exit();
    }
    if(cc == 0)
      break;
    if(cc != 300){
      printf(1, "short read bigfile\n");
    2732:	c7 44 24 04 59 44 00 	movl   $0x4459,0x4(%esp)
    2739:	00 
    273a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2741:	e8 7a 0d 00 00       	call   34c0 <printf>
      exit();
    2746:	e8 1d 0c 00 00       	call   3368 <exit>
  }
  total = 0;
  for(i = 0; ; i++){
    cc = read(fd, buf, 300);
    if(cc < 0){
      printf(1, "read bigfile failed\n");
    274b:	c7 44 24 04 44 44 00 	movl   $0x4444,0x4(%esp)
    2752:	00 
    2753:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    275a:	e8 61 0d 00 00       	call   34c0 <printf>
      exit();
    275f:	e8 04 0c 00 00       	call   3368 <exit>
    exit();
  }
  for(i = 0; i < 20; i++){
    memset(buf, i, 600);
    if(write(fd, buf, 600) != 600){
      printf(1, "write bigfile failed\n");
    2764:	c7 44 24 04 19 44 00 	movl   $0x4419,0x4(%esp)
    276b:	00 
    276c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2773:	e8 48 0d 00 00       	call   34c0 <printf>
      exit();
    2778:	e8 eb 0b 00 00       	call   3368 <exit>
  }
  close(fd);

  fd = open("bigfile", 0);
  if(fd < 0){
    printf(1, "cannot open bigfile\n");
    277d:	c7 44 24 04 2f 44 00 	movl   $0x442f,0x4(%esp)
    2784:	00 
    2785:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    278c:	e8 2f 0d 00 00       	call   34c0 <printf>
    exit();
    2791:	e8 d2 0b 00 00       	call   3368 <exit>
  printf(1, "bigfile test\n");

  unlink("bigfile");
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "cannot create bigfile");
    2796:	c7 44 24 04 03 44 00 	movl   $0x4403,0x4(%esp)
    279d:	00 
    279e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    27a5:	e8 16 0d 00 00       	call   34c0 <printf>
    exit();
    27aa:	e8 b9 0b 00 00       	call   3368 <exit>
    }
    total += cc;
  }
  close(fd);
  if(total != 20*600){
    printf(1, "read bigfile wrong total\n");
    27af:	c7 44 24 04 86 44 00 	movl   $0x4486,0x4(%esp)
    27b6:	00 
    27b7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    27be:	e8 fd 0c 00 00       	call   34c0 <printf>
    exit();
    27c3:	e8 a0 0b 00 00       	call   3368 <exit>
    27c8:	90                   	nop
    27c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000027d0 <concreate>:
}

// test concurrent create and unlink of the same file
void
concreate(void)
{
    27d0:	55                   	push   %ebp
    27d1:	89 e5                	mov    %esp,%ebp
    27d3:	57                   	push   %edi
    27d4:	56                   	push   %esi
    27d5:	53                   	push   %ebx
    char name[14];
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
    27d6:	31 db                	xor    %ebx,%ebx
}

// test concurrent create and unlink of the same file
void
concreate(void)
{
    27d8:	83 ec 6c             	sub    $0x6c,%esp
  struct {
    ushort inum;
    char name[14];
  } de;

  printf(1, "concreate test\n");
    27db:	c7 44 24 04 b1 44 00 	movl   $0x44b1,0x4(%esp)
    27e2:	00 
    27e3:	8d 7d e5             	lea    -0x1b(%ebp),%edi
    27e6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    27ed:	e8 ce 0c 00 00       	call   34c0 <printf>
  file[0] = 'C';
    27f2:	c6 45 e5 43          	movb   $0x43,-0x1b(%ebp)
  file[2] = '\0';
    27f6:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
    27fa:	eb 4f                	jmp    284b <concreate+0x7b>
    27fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
    2800:	b8 56 55 55 55       	mov    $0x55555556,%eax
    2805:	f7 eb                	imul   %ebx
    2807:	89 d8                	mov    %ebx,%eax
    2809:	c1 f8 1f             	sar    $0x1f,%eax
    280c:	29 c2                	sub    %eax,%edx
    280e:	8d 04 52             	lea    (%edx,%edx,2),%eax
    2811:	89 da                	mov    %ebx,%edx
    2813:	29 c2                	sub    %eax,%edx
    2815:	83 fa 01             	cmp    $0x1,%edx
    2818:	74 7e                	je     2898 <concreate+0xc8>
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
      link("C0", file);
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    281a:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    2821:	00 
    2822:	89 3c 24             	mov    %edi,(%esp)
    2825:	e8 7e 0b 00 00       	call   33a8 <open>
      if(fd < 0){
    282a:	85 c0                	test   %eax,%eax
    282c:	0f 88 e3 01 00 00    	js     2a15 <concreate+0x245>
        printf(1, "concreate create %s failed\n", file);
        exit();
      }
      close(fd);
    2832:	89 04 24             	mov    %eax,(%esp)
    2835:	e8 56 0b 00 00       	call   3390 <close>
    }
    if(pid == 0)
    283a:	85 f6                	test   %esi,%esi
    283c:	74 52                	je     2890 <concreate+0xc0>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    283e:	83 c3 01             	add    $0x1,%ebx
      close(fd);
    }
    if(pid == 0)
      exit();
    else
      wait();
    2841:	e8 2a 0b 00 00       	call   3370 <wait>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    2846:	83 fb 28             	cmp    $0x28,%ebx
    2849:	74 6d                	je     28b8 <concreate+0xe8>
    file[1] = '0' + i;
    284b:	8d 43 30             	lea    0x30(%ebx),%eax
    284e:	88 45 e6             	mov    %al,-0x1a(%ebp)
    unlink(file);
    2851:	89 3c 24             	mov    %edi,(%esp)
    2854:	e8 5f 0b 00 00       	call   33b8 <unlink>
    pid = fork();
    2859:	e8 02 0b 00 00       	call   3360 <fork>
    if(pid && (i % 3) == 1){
    285e:	85 c0                	test   %eax,%eax
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    2860:	89 c6                	mov    %eax,%esi
    if(pid && (i % 3) == 1){
    2862:	75 9c                	jne    2800 <concreate+0x30>
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
    2864:	b8 67 66 66 66       	mov    $0x66666667,%eax
    2869:	f7 eb                	imul   %ebx
    286b:	89 d8                	mov    %ebx,%eax
    286d:	c1 f8 1f             	sar    $0x1f,%eax
    2870:	d1 fa                	sar    %edx
    2872:	29 c2                	sub    %eax,%edx
    2874:	8d 04 92             	lea    (%edx,%edx,4),%eax
    2877:	89 da                	mov    %ebx,%edx
    2879:	29 c2                	sub    %eax,%edx
    287b:	83 fa 01             	cmp    $0x1,%edx
    287e:	75 9a                	jne    281a <concreate+0x4a>
      link("C0", file);
    2880:	89 7c 24 04          	mov    %edi,0x4(%esp)
    2884:	c7 04 24 c1 44 00 00 	movl   $0x44c1,(%esp)
    288b:	e8 38 0b 00 00       	call   33c8 <link>
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
      i = de.name[1] - '0';
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
        exit();
    2890:	e8 d3 0a 00 00       	call   3368 <exit>
    2895:	8d 76 00             	lea    0x0(%esi),%esi
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    2898:	83 c3 01             	add    $0x1,%ebx
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
      link("C0", file);
    289b:	89 7c 24 04          	mov    %edi,0x4(%esp)
    289f:	c7 04 24 c1 44 00 00 	movl   $0x44c1,(%esp)
    28a6:	e8 1d 0b 00 00       	call   33c8 <link>
      close(fd);
    }
    if(pid == 0)
      exit();
    else
      wait();
    28ab:	e8 c0 0a 00 00       	call   3370 <wait>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    28b0:	83 fb 28             	cmp    $0x28,%ebx
    28b3:	75 96                	jne    284b <concreate+0x7b>
    28b5:	8d 76 00             	lea    0x0(%esi),%esi
      exit();
    else
      wait();
  }

  memset(fa, 0, sizeof(fa));
    28b8:	8d 45 ac             	lea    -0x54(%ebp),%eax
    28bb:	c7 44 24 08 28 00 00 	movl   $0x28,0x8(%esp)
    28c2:	00 
    28c3:	8d 75 d4             	lea    -0x2c(%ebp),%esi
    28c6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    28cd:	00 
    28ce:	89 04 24             	mov    %eax,(%esp)
    28d1:	e8 0a 09 00 00       	call   31e0 <memset>
  fd = open(".", 0);
    28d6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    28dd:	00 
    28de:	c7 04 24 1f 3e 00 00 	movl   $0x3e1f,(%esp)
    28e5:	e8 be 0a 00 00       	call   33a8 <open>
    28ea:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
    28f1:	89 c3                	mov    %eax,%ebx
    28f3:	90                   	nop
    28f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  n = 0;
  while(read(fd, &de, sizeof(de)) > 0){
    28f8:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    28ff:	00 
    2900:	89 74 24 04          	mov    %esi,0x4(%esp)
    2904:	89 1c 24             	mov    %ebx,(%esp)
    2907:	e8 74 0a 00 00       	call   3380 <read>
    290c:	85 c0                	test   %eax,%eax
    290e:	7e 40                	jle    2950 <concreate+0x180>
    if(de.inum == 0)
    2910:	66 83 7d d4 00       	cmpw   $0x0,-0x2c(%ebp)
    2915:	74 e1                	je     28f8 <concreate+0x128>
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    2917:	80 7d d6 43          	cmpb   $0x43,-0x2a(%ebp)
    291b:	90                   	nop
    291c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2920:	75 d6                	jne    28f8 <concreate+0x128>
    2922:	80 7d d8 00          	cmpb   $0x0,-0x28(%ebp)
    2926:	75 d0                	jne    28f8 <concreate+0x128>
      i = de.name[1] - '0';
    2928:	0f be 45 d7          	movsbl -0x29(%ebp),%eax
    292c:	83 e8 30             	sub    $0x30,%eax
      if(i < 0 || i >= sizeof(fa)){
    292f:	83 f8 27             	cmp    $0x27,%eax
    2932:	0f 87 fa 00 00 00    	ja     2a32 <concreate+0x262>
        printf(1, "concreate weird file %s\n", de.name);
        exit();
      }
      if(fa[i]){
    2938:	80 7c 05 ac 00       	cmpb   $0x0,-0x54(%ebp,%eax,1)
    293d:	0f 85 28 01 00 00    	jne    2a6b <concreate+0x29b>
        printf(1, "concreate duplicate file %s\n", de.name);
        exit();
      }
      fa[i] = 1;
    2943:	c6 44 05 ac 01       	movb   $0x1,-0x54(%ebp,%eax,1)
      n++;
    2948:	83 45 a4 01          	addl   $0x1,-0x5c(%ebp)
    294c:	eb aa                	jmp    28f8 <concreate+0x128>
    294e:	66 90                	xchg   %ax,%ax
    }
  }
  close(fd);
    2950:	89 1c 24             	mov    %ebx,(%esp)
    2953:	e8 38 0a 00 00       	call   3390 <close>

  if(n != 40){
    2958:	83 7d a4 28          	cmpl   $0x28,-0x5c(%ebp)
    295c:	0f 85 f0 00 00 00    	jne    2a52 <concreate+0x282>
    printf(1, "concreate not enough files in directory listing\n");
    exit();
    2962:	31 db                	xor    %ebx,%ebx
    2964:	eb 3d                	jmp    29a3 <concreate+0x1d3>
    2966:	66 90                	xchg   %ax,%ax
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
      exit();
    }
    if(((i % 3) == 0 && pid == 0) ||
    2968:	83 f8 01             	cmp    $0x1,%eax
    296b:	90                   	nop
    296c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2970:	75 5d                	jne    29cf <concreate+0x1ff>
    2972:	85 f6                	test   %esi,%esi
    2974:	74 59                	je     29cf <concreate+0x1ff>
       ((i % 3) == 1 && pid != 0)){
      fd = open(file, 0);
    2976:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    297d:	00 
    297e:	89 3c 24             	mov    %edi,(%esp)
    2981:	e8 22 0a 00 00       	call   33a8 <open>
      close(fd);
    2986:	89 04 24             	mov    %eax,(%esp)
    2989:	e8 02 0a 00 00       	call   3390 <close>
    } else {
      unlink(file);
    }
    if(pid == 0)
    298e:	85 f6                	test   %esi,%esi
    2990:	0f 84 fa fe ff ff    	je     2890 <concreate+0xc0>
  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    exit();
  }

  for(i = 0; i < 40; i++){
    2996:	83 c3 01             	add    $0x1,%ebx
      unlink(file);
    }
    if(pid == 0)
      exit();
    else
      wait();
    2999:	e8 d2 09 00 00       	call   3370 <wait>
  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    exit();
  }

  for(i = 0; i < 40; i++){
    299e:	83 fb 28             	cmp    $0x28,%ebx
    29a1:	74 3d                	je     29e0 <concreate+0x210>
    file[1] = '0' + i;
    29a3:	8d 43 30             	lea    0x30(%ebx),%eax
    29a6:	88 45 e6             	mov    %al,-0x1a(%ebp)
    pid = fork();
    29a9:	e8 b2 09 00 00       	call   3360 <fork>
    if(pid < 0){
    29ae:	85 c0                	test   %eax,%eax
    exit();
  }

  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    pid = fork();
    29b0:	89 c6                	mov    %eax,%esi
    if(pid < 0){
    29b2:	78 48                	js     29fc <concreate+0x22c>
      printf(1, "fork failed\n");
      exit();
    }
    if(((i % 3) == 0 && pid == 0) ||
    29b4:	b8 56 55 55 55       	mov    $0x55555556,%eax
    29b9:	f7 eb                	imul   %ebx
    29bb:	89 d8                	mov    %ebx,%eax
    29bd:	c1 f8 1f             	sar    $0x1f,%eax
    29c0:	29 c2                	sub    %eax,%edx
    29c2:	89 d8                	mov    %ebx,%eax
    29c4:	8d 14 52             	lea    (%edx,%edx,2),%edx
    29c7:	29 d0                	sub    %edx,%eax
    29c9:	75 9d                	jne    2968 <concreate+0x198>
    29cb:	85 f6                	test   %esi,%esi
    29cd:	74 a7                	je     2976 <concreate+0x1a6>
       ((i % 3) == 1 && pid != 0)){
      fd = open(file, 0);
      close(fd);
    } else {
      unlink(file);
    29cf:	89 3c 24             	mov    %edi,(%esp)
    29d2:	e8 e1 09 00 00       	call   33b8 <unlink>
    29d7:	eb b5                	jmp    298e <concreate+0x1be>
    29d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      exit();
    else
      wait();
  }

  printf(1, "concreate ok\n");
    29e0:	c7 44 24 04 16 45 00 	movl   $0x4516,0x4(%esp)
    29e7:	00 
    29e8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    29ef:	e8 cc 0a 00 00       	call   34c0 <printf>
}
    29f4:	83 c4 6c             	add    $0x6c,%esp
    29f7:	5b                   	pop    %ebx
    29f8:	5e                   	pop    %esi
    29f9:	5f                   	pop    %edi
    29fa:	5d                   	pop    %ebp
    29fb:	c3                   	ret    

  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
    29fc:	c7 44 24 04 69 39 00 	movl   $0x3969,0x4(%esp)
    2a03:	00 
    2a04:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a0b:	e8 b0 0a 00 00       	call   34c0 <printf>
      exit();
    2a10:	e8 53 09 00 00       	call   3368 <exit>
    } else if(pid == 0 && (i % 5) == 1){
      link("C0", file);
    } else {
      fd = open(file, O_CREATE | O_RDWR);
      if(fd < 0){
        printf(1, "concreate create %s failed\n", file);
    2a15:	89 7c 24 08          	mov    %edi,0x8(%esp)
    2a19:	c7 44 24 04 c4 44 00 	movl   $0x44c4,0x4(%esp)
    2a20:	00 
    2a21:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a28:	e8 93 0a 00 00       	call   34c0 <printf>
        exit();
    2a2d:	e8 36 09 00 00       	call   3368 <exit>
    if(de.inum == 0)
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
      i = de.name[1] - '0';
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
    2a32:	8d 45 d6             	lea    -0x2a(%ebp),%eax
    2a35:	89 44 24 08          	mov    %eax,0x8(%esp)
    2a39:	c7 44 24 04 e0 44 00 	movl   $0x44e0,0x4(%esp)
    2a40:	00 
    2a41:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a48:	e8 73 0a 00 00       	call   34c0 <printf>
    2a4d:	e9 3e fe ff ff       	jmp    2890 <concreate+0xc0>
    }
  }
  close(fd);

  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    2a52:	c7 44 24 04 68 4c 00 	movl   $0x4c68,0x4(%esp)
    2a59:	00 
    2a5a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a61:	e8 5a 0a 00 00       	call   34c0 <printf>
    exit();
    2a66:	e8 fd 08 00 00       	call   3368 <exit>
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
        exit();
      }
      if(fa[i]){
        printf(1, "concreate duplicate file %s\n", de.name);
    2a6b:	8d 45 d6             	lea    -0x2a(%ebp),%eax
    2a6e:	89 44 24 08          	mov    %eax,0x8(%esp)
    2a72:	c7 44 24 04 f9 44 00 	movl   $0x44f9,0x4(%esp)
    2a79:	00 
    2a7a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a81:	e8 3a 0a 00 00       	call   34c0 <printf>
        exit();
    2a86:	e8 dd 08 00 00       	call   3368 <exit>
    2a8b:	90                   	nop
    2a8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00002a90 <twofiles>:

// two processes write two different files at the same
// time, to test block allocation.
void
twofiles(void)
{
    2a90:	55                   	push   %ebp
    2a91:	89 e5                	mov    %esp,%ebp
    2a93:	57                   	push   %edi
    2a94:	56                   	push   %esi
    2a95:	53                   	push   %ebx
    2a96:	83 ec 2c             	sub    $0x2c,%esp
  int fd, pid, i, j, n, total;
  char *fname;

  printf(1, "twofiles test\n");
    2a99:	c7 44 24 04 24 45 00 	movl   $0x4524,0x4(%esp)
    2aa0:	00 
    2aa1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2aa8:	e8 13 0a 00 00       	call   34c0 <printf>

  unlink("f1");
    2aad:	c7 04 24 6b 40 00 00 	movl   $0x406b,(%esp)
    2ab4:	e8 ff 08 00 00       	call   33b8 <unlink>
  unlink("f2");
    2ab9:	c7 04 24 6f 40 00 00 	movl   $0x406f,(%esp)
    2ac0:	e8 f3 08 00 00       	call   33b8 <unlink>

  pid = fork();
    2ac5:	e8 96 08 00 00       	call   3360 <fork>
  if(pid < 0){
    2aca:	83 f8 00             	cmp    $0x0,%eax
  printf(1, "twofiles test\n");

  unlink("f1");
  unlink("f2");

  pid = fork();
    2acd:	89 c7                	mov    %eax,%edi
  if(pid < 0){
    2acf:	0f 8c 64 01 00 00    	jl     2c39 <twofiles+0x1a9>
    printf(1, "fork failed\n");
    return;
  }

  fname = pid ? "f1" : "f2";
    2ad5:	b8 6b 40 00 00       	mov    $0x406b,%eax
    2ada:	75 05                	jne    2ae1 <twofiles+0x51>
    2adc:	b8 6f 40 00 00       	mov    $0x406f,%eax
  fd = open(fname, O_CREATE | O_RDWR);
    2ae1:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    2ae8:	00 
    2ae9:	89 04 24             	mov    %eax,(%esp)
    2aec:	e8 b7 08 00 00       	call   33a8 <open>
  if(fd < 0){
    2af1:	85 c0                	test   %eax,%eax
    printf(1, "fork failed\n");
    return;
  }

  fname = pid ? "f1" : "f2";
  fd = open(fname, O_CREATE | O_RDWR);
    2af3:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    2af5:	0f 88 8e 01 00 00    	js     2c89 <twofiles+0x1f9>
    printf(1, "create failed\n");
    exit();
  }

  memset(buf, pid?'p':'c', 512);
    2afb:	83 ff 01             	cmp    $0x1,%edi
    2afe:	19 c0                	sbb    %eax,%eax
    2b00:	31 db                	xor    %ebx,%ebx
    2b02:	83 e0 f3             	and    $0xfffffff3,%eax
    2b05:	83 c0 70             	add    $0x70,%eax
    2b08:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    2b0f:	00 
    2b10:	89 44 24 04          	mov    %eax,0x4(%esp)
    2b14:	c7 04 24 a0 4d 00 00 	movl   $0x4da0,(%esp)
    2b1b:	e8 c0 06 00 00       	call   31e0 <memset>
  for(i = 0; i < 12; i++){
    if((n = write(fd, buf, 500)) != 500){
    2b20:	c7 44 24 08 f4 01 00 	movl   $0x1f4,0x8(%esp)
    2b27:	00 
    2b28:	c7 44 24 04 a0 4d 00 	movl   $0x4da0,0x4(%esp)
    2b2f:	00 
    2b30:	89 34 24             	mov    %esi,(%esp)
    2b33:	e8 50 08 00 00       	call   3388 <write>
    2b38:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    2b3d:	0f 85 29 01 00 00    	jne    2c6c <twofiles+0x1dc>
    printf(1, "create failed\n");
    exit();
  }

  memset(buf, pid?'p':'c', 512);
  for(i = 0; i < 12; i++){
    2b43:	83 c3 01             	add    $0x1,%ebx
    2b46:	83 fb 0c             	cmp    $0xc,%ebx
    2b49:	75 d5                	jne    2b20 <twofiles+0x90>
    if((n = write(fd, buf, 500)) != 500){
      printf(1, "write failed %d\n", n);
      exit();
    }
  }
  close(fd);
    2b4b:	89 34 24             	mov    %esi,(%esp)
    2b4e:	e8 3d 08 00 00       	call   3390 <close>
  if(pid)
    2b53:	85 ff                	test   %edi,%edi
    2b55:	0f 84 d9 00 00 00    	je     2c34 <twofiles+0x1a4>
    wait();
    2b5b:	e8 10 08 00 00       	call   3370 <wait>
    2b60:	30 db                	xor    %bl,%bl
    2b62:	b8 6f 40 00 00       	mov    $0x406f,%eax
  else
    exit();

  for(i = 0; i < 2; i++){
    fd = open(i?"f1":"f2", 0);
    2b67:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2b6e:	00 
    2b6f:	31 f6                	xor    %esi,%esi
    2b71:	89 04 24             	mov    %eax,(%esp)
    2b74:	e8 2f 08 00 00       	call   33a8 <open>
    2b79:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    2b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
    2b80:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2b83:	c7 44 24 08 00 08 00 	movl   $0x800,0x8(%esp)
    2b8a:	00 
    2b8b:	c7 44 24 04 a0 4d 00 	movl   $0x4da0,0x4(%esp)
    2b92:	00 
    2b93:	89 04 24             	mov    %eax,(%esp)
    2b96:	e8 e5 07 00 00       	call   3380 <read>
    2b9b:	85 c0                	test   %eax,%eax
    2b9d:	7e 2a                	jle    2bc9 <twofiles+0x139>
    2b9f:	31 c9                	xor    %ecx,%ecx
    2ba1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      for(j = 0; j < n; j++){
        if(buf[j] != (i?'p':'c')){
    2ba8:	83 fb 01             	cmp    $0x1,%ebx
    2bab:	0f be b9 a0 4d 00 00 	movsbl 0x4da0(%ecx),%edi
    2bb2:	19 d2                	sbb    %edx,%edx
    2bb4:	83 e2 f3             	and    $0xfffffff3,%edx
    2bb7:	83 c2 70             	add    $0x70,%edx
    2bba:	39 d7                	cmp    %edx,%edi
    2bbc:	75 62                	jne    2c20 <twofiles+0x190>

  for(i = 0; i < 2; i++){
    fd = open(i?"f1":"f2", 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
    2bbe:	83 c1 01             	add    $0x1,%ecx
    2bc1:	39 c8                	cmp    %ecx,%eax
    2bc3:	7f e3                	jg     2ba8 <twofiles+0x118>
        if(buf[j] != (i?'p':'c')){
          printf(1, "wrong char\n");
          exit();
        }
      }
      total += n;
    2bc5:	01 c6                	add    %eax,%esi
    2bc7:	eb b7                	jmp    2b80 <twofiles+0xf0>
    }
    close(fd);
    2bc9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2bcc:	89 04 24             	mov    %eax,(%esp)
    2bcf:	e8 bc 07 00 00       	call   3390 <close>
    if(total != 12*500){
    2bd4:	81 fe 70 17 00 00    	cmp    $0x1770,%esi
    2bda:	75 73                	jne    2c4f <twofiles+0x1bf>
  if(pid)
    wait();
  else
    exit();

  for(i = 0; i < 2; i++){
    2bdc:	83 fb 01             	cmp    $0x1,%ebx
      total += n;
    }
    close(fd);
    if(total != 12*500){
      printf(1, "wrong length %d\n", total);
      exit();
    2bdf:	b8 6b 40 00 00       	mov    $0x406b,%eax
  if(pid)
    wait();
  else
    exit();

  for(i = 0; i < 2; i++){
    2be4:	75 30                	jne    2c16 <twofiles+0x186>
      printf(1, "wrong length %d\n", total);
      exit();
    }
  }

  unlink("f1");
    2be6:	89 04 24             	mov    %eax,(%esp)
    2be9:	e8 ca 07 00 00       	call   33b8 <unlink>
  unlink("f2");
    2bee:	c7 04 24 6f 40 00 00 	movl   $0x406f,(%esp)
    2bf5:	e8 be 07 00 00       	call   33b8 <unlink>

  printf(1, "twofiles ok\n");
    2bfa:	c7 44 24 04 61 45 00 	movl   $0x4561,0x4(%esp)
    2c01:	00 
    2c02:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c09:	e8 b2 08 00 00       	call   34c0 <printf>
}
    2c0e:	83 c4 2c             	add    $0x2c,%esp
    2c11:	5b                   	pop    %ebx
    2c12:	5e                   	pop    %esi
    2c13:	5f                   	pop    %edi
    2c14:	5d                   	pop    %ebp
    2c15:	c3                   	ret    
  }
  close(fd);
  if(pid)
    wait();
  else
    exit();
    2c16:	bb 01 00 00 00       	mov    $0x1,%ebx
    2c1b:	e9 47 ff ff ff       	jmp    2b67 <twofiles+0xd7>
    fd = open(i?"f1":"f2", 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
        if(buf[j] != (i?'p':'c')){
          printf(1, "wrong char\n");
    2c20:	c7 44 24 04 44 45 00 	movl   $0x4544,0x4(%esp)
    2c27:	00 
    2c28:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c2f:	e8 8c 08 00 00       	call   34c0 <printf>
          exit();
    2c34:	e8 2f 07 00 00       	call   3368 <exit>
  unlink("f1");
  unlink("f2");

  pid = fork();
  if(pid < 0){
    printf(1, "fork failed\n");
    2c39:	c7 44 24 04 69 39 00 	movl   $0x3969,0x4(%esp)
    2c40:	00 
    2c41:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c48:	e8 73 08 00 00       	call   34c0 <printf>
    return;
    2c4d:	eb bf                	jmp    2c0e <twofiles+0x17e>
      }
      total += n;
    }
    close(fd);
    if(total != 12*500){
      printf(1, "wrong length %d\n", total);
    2c4f:	89 74 24 08          	mov    %esi,0x8(%esp)
    2c53:	c7 44 24 04 50 45 00 	movl   $0x4550,0x4(%esp)
    2c5a:	00 
    2c5b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c62:	e8 59 08 00 00       	call   34c0 <printf>
      exit();
    2c67:	e8 fc 06 00 00       	call   3368 <exit>
  }

  memset(buf, pid?'p':'c', 512);
  for(i = 0; i < 12; i++){
    if((n = write(fd, buf, 500)) != 500){
      printf(1, "write failed %d\n", n);
    2c6c:	89 44 24 08          	mov    %eax,0x8(%esp)
    2c70:	c7 44 24 04 33 45 00 	movl   $0x4533,0x4(%esp)
    2c77:	00 
    2c78:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c7f:	e8 3c 08 00 00       	call   34c0 <printf>
      exit();
    2c84:	e8 df 06 00 00       	call   3368 <exit>
  }

  fname = pid ? "f1" : "f2";
  fd = open(fname, O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create failed\n");
    2c89:	c7 44 24 04 1d 40 00 	movl   $0x401d,0x4(%esp)
    2c90:	00 
    2c91:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c98:	e8 23 08 00 00       	call   34c0 <printf>
    exit();
    2c9d:	e8 c6 06 00 00       	call   3368 <exit>
    2ca2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2ca9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002cb0 <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
{
    2cb0:	55                   	push   %ebp
    2cb1:	89 e5                	mov    %esp,%ebp
    2cb3:	57                   	push   %edi
    2cb4:	56                   	push   %esi
    2cb5:	53                   	push   %ebx
    2cb6:	83 ec 3c             	sub    $0x3c,%esp
  int fd, pid, i, n, nc, np;
  char buf[10];

  unlink("sharedfd");
    2cb9:	c7 04 24 6e 45 00 00 	movl   $0x456e,(%esp)
    2cc0:	e8 f3 06 00 00       	call   33b8 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    2cc5:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    2ccc:	00 
    2ccd:	c7 04 24 6e 45 00 00 	movl   $0x456e,(%esp)
    2cd4:	e8 cf 06 00 00       	call   33a8 <open>
  if(fd < 0){
    2cd9:	85 c0                	test   %eax,%eax
{
  int fd, pid, i, n, nc, np;
  char buf[10];

  unlink("sharedfd");
  fd = open("sharedfd", O_CREATE|O_RDWR);
    2cdb:	89 c7                	mov    %eax,%edi
  if(fd < 0){
    2cdd:	0f 88 55 01 00 00    	js     2e38 <sharedfd+0x188>
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
    2ce3:	e8 78 06 00 00       	call   3360 <fork>
  memset(buf, pid==0?'c':'p', sizeof(buf));
    2ce8:	8d 75 de             	lea    -0x22(%ebp),%esi
    2ceb:	83 f8 01             	cmp    $0x1,%eax
  fd = open("sharedfd", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
    2cee:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
    2cf1:	19 c0                	sbb    %eax,%eax
    2cf3:	31 db                	xor    %ebx,%ebx
    2cf5:	83 e0 f3             	and    $0xfffffff3,%eax
    2cf8:	83 c0 70             	add    $0x70,%eax
    2cfb:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    2d02:	00 
    2d03:	89 44 24 04          	mov    %eax,0x4(%esp)
    2d07:	89 34 24             	mov    %esi,(%esp)
    2d0a:	e8 d1 04 00 00       	call   31e0 <memset>
    2d0f:	eb 12                	jmp    2d23 <sharedfd+0x73>
    2d11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 1000; i++){
    2d18:	83 c3 01             	add    $0x1,%ebx
    2d1b:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    2d21:	74 2d                	je     2d50 <sharedfd+0xa0>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    2d23:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    2d2a:	00 
    2d2b:	89 74 24 04          	mov    %esi,0x4(%esp)
    2d2f:	89 3c 24             	mov    %edi,(%esp)
    2d32:	e8 51 06 00 00       	call   3388 <write>
    2d37:	83 f8 0a             	cmp    $0xa,%eax
    2d3a:	74 dc                	je     2d18 <sharedfd+0x68>
      printf(1, "fstests: write sharedfd failed\n");
    2d3c:	c7 44 24 04 c8 4c 00 	movl   $0x4cc8,0x4(%esp)
    2d43:	00 
    2d44:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2d4b:	e8 70 07 00 00       	call   34c0 <printf>
      break;
    }
  }
  if(pid == 0)
    2d50:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    2d53:	85 d2                	test   %edx,%edx
    2d55:	0f 84 0f 01 00 00    	je     2e6a <sharedfd+0x1ba>
    exit();
  else
    wait();
    2d5b:	e8 10 06 00 00       	call   3370 <wait>
  close(fd);
  fd = open("sharedfd", 0);
  if(fd < 0){
    2d60:	31 db                	xor    %ebx,%ebx
  }
  if(pid == 0)
    exit();
  else
    wait();
  close(fd);
    2d62:	89 3c 24             	mov    %edi,(%esp)
  fd = open("sharedfd", 0);
  if(fd < 0){
    2d65:	31 ff                	xor    %edi,%edi
  }
  if(pid == 0)
    exit();
  else
    wait();
  close(fd);
    2d67:	e8 24 06 00 00       	call   3390 <close>
  fd = open("sharedfd", 0);
    2d6c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2d73:	00 
    2d74:	c7 04 24 6e 45 00 00 	movl   $0x456e,(%esp)
    2d7b:	e8 28 06 00 00       	call   33a8 <open>
  if(fd < 0){
    2d80:	85 c0                	test   %eax,%eax
  if(pid == 0)
    exit();
  else
    wait();
  close(fd);
  fd = open("sharedfd", 0);
    2d82:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  if(fd < 0){
    2d85:	0f 88 c9 00 00 00    	js     2e54 <sharedfd+0x1a4>
    2d8b:	90                   	nop
    2d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    2d90:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    2d97:	00 
    2d98:	89 74 24 04          	mov    %esi,0x4(%esp)
    2d9c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    2d9f:	89 04 24             	mov    %eax,(%esp)
    2da2:	e8 d9 05 00 00       	call   3380 <read>
    2da7:	85 c0                	test   %eax,%eax
    2da9:	7e 26                	jle    2dd1 <sharedfd+0x121>
    wait();
  close(fd);
  fd = open("sharedfd", 0);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
    2dab:	31 c0                	xor    %eax,%eax
    2dad:	eb 14                	jmp    2dc3 <sharedfd+0x113>
    2daf:	90                   	nop
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i = 0; i < sizeof(buf); i++){
      if(buf[i] == 'c')
        nc++;
      if(buf[i] == 'p')
        np++;
    2db0:	80 fa 70             	cmp    $0x70,%dl
    2db3:	0f 94 c2             	sete   %dl
    2db6:	0f b6 d2             	movzbl %dl,%edx
    2db9:	01 d3                	add    %edx,%ebx
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i = 0; i < sizeof(buf); i++){
    2dbb:	83 c0 01             	add    $0x1,%eax
    2dbe:	83 f8 0a             	cmp    $0xa,%eax
    2dc1:	74 cd                	je     2d90 <sharedfd+0xe0>
      if(buf[i] == 'c')
    2dc3:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
    2dc7:	80 fa 63             	cmp    $0x63,%dl
    2dca:	75 e4                	jne    2db0 <sharedfd+0x100>
        nc++;
    2dcc:	83 c7 01             	add    $0x1,%edi
    2dcf:	eb ea                	jmp    2dbb <sharedfd+0x10b>
      if(buf[i] == 'p')
        np++;
    }
  }
  close(fd);
    2dd1:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    2dd4:	89 04 24             	mov    %eax,(%esp)
    2dd7:	e8 b4 05 00 00       	call   3390 <close>
  unlink("sharedfd");
    2ddc:	c7 04 24 6e 45 00 00 	movl   $0x456e,(%esp)
    2de3:	e8 d0 05 00 00       	call   33b8 <unlink>
  if(nc == 10000 && np == 10000)
    2de8:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
    2dee:	74 24                	je     2e14 <sharedfd+0x164>
    printf(1, "sharedfd ok\n");
  else
    printf(1, "sharedfd oops %d %d\n", nc, np);
    2df0:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
    2df4:	89 7c 24 08          	mov    %edi,0x8(%esp)
    2df8:	c7 44 24 04 84 45 00 	movl   $0x4584,0x4(%esp)
    2dff:	00 
    2e00:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e07:	e8 b4 06 00 00       	call   34c0 <printf>
}
    2e0c:	83 c4 3c             	add    $0x3c,%esp
    2e0f:	5b                   	pop    %ebx
    2e10:	5e                   	pop    %esi
    2e11:	5f                   	pop    %edi
    2e12:	5d                   	pop    %ebp
    2e13:	c3                   	ret    
        np++;
    }
  }
  close(fd);
  unlink("sharedfd");
  if(nc == 10000 && np == 10000)
    2e14:	81 ff 10 27 00 00    	cmp    $0x2710,%edi
    2e1a:	75 d4                	jne    2df0 <sharedfd+0x140>
    printf(1, "sharedfd ok\n");
    2e1c:	c7 44 24 04 77 45 00 	movl   $0x4577,0x4(%esp)
    2e23:	00 
    2e24:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e2b:	e8 90 06 00 00       	call   34c0 <printf>
  else
    printf(1, "sharedfd oops %d %d\n", nc, np);
}
    2e30:	83 c4 3c             	add    $0x3c,%esp
    2e33:	5b                   	pop    %ebx
    2e34:	5e                   	pop    %esi
    2e35:	5f                   	pop    %edi
    2e36:	5d                   	pop    %ebp
    2e37:	c3                   	ret    
  char buf[10];

  unlink("sharedfd");
  fd = open("sharedfd", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for writing");
    2e38:	c7 44 24 04 9c 4c 00 	movl   $0x4c9c,0x4(%esp)
    2e3f:	00 
    2e40:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e47:	e8 74 06 00 00       	call   34c0 <printf>
  unlink("sharedfd");
  if(nc == 10000 && np == 10000)
    printf(1, "sharedfd ok\n");
  else
    printf(1, "sharedfd oops %d %d\n", nc, np);
}
    2e4c:	83 c4 3c             	add    $0x3c,%esp
    2e4f:	5b                   	pop    %ebx
    2e50:	5e                   	pop    %esi
    2e51:	5f                   	pop    %edi
    2e52:	5d                   	pop    %ebp
    2e53:	c3                   	ret    
  else
    wait();
  close(fd);
  fd = open("sharedfd", 0);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for reading\n");
    2e54:	c7 44 24 04 e8 4c 00 	movl   $0x4ce8,0x4(%esp)
    2e5b:	00 
    2e5c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e63:	e8 58 06 00 00       	call   34c0 <printf>
    return;
    2e68:	eb a2                	jmp    2e0c <sharedfd+0x15c>
      printf(1, "fstests: write sharedfd failed\n");
      break;
    }
  }
  if(pid == 0)
    exit();
    2e6a:	e8 f9 04 00 00       	call   3368 <exit>
    2e6f:	90                   	nop

00002e70 <mem>:
  printf(1, "exitwait ok\n");
}

void
mem(void)
{
    2e70:	55                   	push   %ebp
    2e71:	89 e5                	mov    %esp,%ebp
    2e73:	57                   	push   %edi
    2e74:	56                   	push   %esi
    2e75:	53                   	push   %ebx
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
  ppid = getpid();
  if((pid = fork()) == 0){
    2e76:	31 db                	xor    %ebx,%ebx
  printf(1, "exitwait ok\n");
}

void
mem(void)
{
    2e78:	83 ec 1c             	sub    $0x1c,%esp
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
    2e7b:	c7 44 24 04 99 45 00 	movl   $0x4599,0x4(%esp)
    2e82:	00 
    2e83:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e8a:	e8 31 06 00 00       	call   34c0 <printf>
  ppid = getpid();
    2e8f:	e8 54 05 00 00       	call   33e8 <getpid>
    2e94:	89 c6                	mov    %eax,%esi
  if((pid = fork()) == 0){
    2e96:	e8 c5 04 00 00       	call   3360 <fork>
    2e9b:	85 c0                	test   %eax,%eax
    2e9d:	74 0d                	je     2eac <mem+0x3c>
    2e9f:	90                   	nop
    2ea0:	eb 5f                	jmp    2f01 <mem+0x91>
    2ea2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    m1 = 0;
    while((m2 = malloc(10001)) != 0) {
      *(char**) m2 = m1;
    2ea8:	89 18                	mov    %ebx,(%eax)
    2eaa:	89 c3                	mov    %eax,%ebx

  printf(1, "mem test\n");
  ppid = getpid();
  if((pid = fork()) == 0){
    m1 = 0;
    while((m2 = malloc(10001)) != 0) {
    2eac:	c7 04 24 11 27 00 00 	movl   $0x2711,(%esp)
    2eb3:	e8 a8 08 00 00       	call   3760 <malloc>
    2eb8:	85 c0                	test   %eax,%eax
    2eba:	75 ec                	jne    2ea8 <mem+0x38>
      *(char**) m2 = m1;
      m1 = m2;
    }
    while(m1) {
    2ebc:	85 db                	test   %ebx,%ebx
    2ebe:	74 10                	je     2ed0 <mem+0x60>
      m2 = *(char**)m1;
    2ec0:	8b 3b                	mov    (%ebx),%edi
      free(m1);
    2ec2:	89 1c 24             	mov    %ebx,(%esp)
    2ec5:	e8 06 08 00 00       	call   36d0 <free>
    2eca:	89 fb                	mov    %edi,%ebx
    m1 = 0;
    while((m2 = malloc(10001)) != 0) {
      *(char**) m2 = m1;
      m1 = m2;
    }
    while(m1) {
    2ecc:	85 db                	test   %ebx,%ebx
    2ece:	75 f0                	jne    2ec0 <mem+0x50>
      m2 = *(char**)m1;
      free(m1);
      m1 = m2;
    }
    m1 = malloc(1024*20);
    2ed0:	c7 04 24 00 50 00 00 	movl   $0x5000,(%esp)
    2ed7:	e8 84 08 00 00       	call   3760 <malloc>
    if(m1 == 0) {
    2edc:	85 c0                	test   %eax,%eax
    2ede:	74 30                	je     2f10 <mem+0xa0>
      printf(1, "couldn't allocate mem?!!\n");
      kill(ppid);
      exit();
    }
    free(m1);
    2ee0:	89 04 24             	mov    %eax,(%esp)
    2ee3:	e8 e8 07 00 00       	call   36d0 <free>
    printf(1, "mem ok\n");
    2ee8:	c7 44 24 04 bd 45 00 	movl   $0x45bd,0x4(%esp)
    2eef:	00 
    2ef0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ef7:	e8 c4 05 00 00       	call   34c0 <printf>
    exit();
    2efc:	e8 67 04 00 00       	call   3368 <exit>
  } else {
    wait();
  }
}
    2f01:	83 c4 1c             	add    $0x1c,%esp
    2f04:	5b                   	pop    %ebx
    2f05:	5e                   	pop    %esi
    2f06:	5f                   	pop    %edi
    2f07:	5d                   	pop    %ebp
    }
    free(m1);
    printf(1, "mem ok\n");
    exit();
  } else {
    wait();
    2f08:	e9 63 04 00 00       	jmp    3370 <wait>
    2f0d:	8d 76 00             	lea    0x0(%esi),%esi
      free(m1);
      m1 = m2;
    }
    m1 = malloc(1024*20);
    if(m1 == 0) {
      printf(1, "couldn't allocate mem?!!\n");
    2f10:	c7 44 24 04 a3 45 00 	movl   $0x45a3,0x4(%esp)
    2f17:	00 
    2f18:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2f1f:	e8 9c 05 00 00       	call   34c0 <printf>
      kill(ppid);
    2f24:	89 34 24             	mov    %esi,(%esp)
    2f27:	e8 6c 04 00 00       	call   3398 <kill>
      exit();
    2f2c:	e8 37 04 00 00       	call   3368 <exit>
    2f31:	eb 0d                	jmp    2f40 <exectest>
    2f33:	90                   	nop
    2f34:	90                   	nop
    2f35:	90                   	nop
    2f36:	90                   	nop
    2f37:	90                   	nop
    2f38:	90                   	nop
    2f39:	90                   	nop
    2f3a:	90                   	nop
    2f3b:	90                   	nop
    2f3c:	90                   	nop
    2f3d:	90                   	nop
    2f3e:	90                   	nop
    2f3f:	90                   	nop

00002f40 <exectest>:
  printf(stdout, "mkdir test\n");
}

void
exectest(void)
{
    2f40:	55                   	push   %ebp
    2f41:	89 e5                	mov    %esp,%ebp
    2f43:	83 ec 18             	sub    $0x18,%esp
  printf(stdout, "exec test\n");
    2f46:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    2f4b:	c7 44 24 04 c5 45 00 	movl   $0x45c5,0x4(%esp)
    2f52:	00 
    2f53:	89 04 24             	mov    %eax,(%esp)
    2f56:	e8 65 05 00 00       	call   34c0 <printf>
  if(exec("echo", echoargv) < 0) {
    2f5b:	c7 44 24 04 58 4d 00 	movl   $0x4d58,0x4(%esp)
    2f62:	00 
    2f63:	c7 04 24 4b 38 00 00 	movl   $0x384b,(%esp)
    2f6a:	e8 31 04 00 00       	call   33a0 <exec>
    2f6f:	85 c0                	test   %eax,%eax
    2f71:	78 02                	js     2f75 <exectest+0x35>
    printf(stdout, "exec echo failed\n");
    exit();
  }
}
    2f73:	c9                   	leave  
    2f74:	c3                   	ret    
void
exectest(void)
{
  printf(stdout, "exec test\n");
  if(exec("echo", echoargv) < 0) {
    printf(stdout, "exec echo failed\n");
    2f75:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    2f7a:	c7 44 24 04 d0 45 00 	movl   $0x45d0,0x4(%esp)
    2f81:	00 
    2f82:	89 04 24             	mov    %eax,(%esp)
    2f85:	e8 36 05 00 00       	call   34c0 <printf>
    exit();
    2f8a:	e8 d9 03 00 00       	call   3368 <exit>
    2f8f:	90                   	nop

00002f90 <stopRecordingTest>:
	}
	printf(stdout, "fetchrecords ok\n");
}

void
stopRecordingTest(void){
    2f90:	55                   	push   %ebp
    2f91:	89 e5                	mov    %esp,%ebp
    2f93:	83 ec 18             	sub    $0x18,%esp
	int result;
 	printf(stdout, "stoprecording test\n");
    2f96:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    2f9b:	c7 44 24 04 e2 45 00 	movl   $0x45e2,0x4(%esp)
    2fa2:	00 
    2fa3:	89 04 24             	mov    %eax,(%esp)
    2fa6:	e8 15 05 00 00       	call   34c0 <printf>
 	result = stoprecording();
    2fab:	e8 60 04 00 00       	call   3410 <stoprecording>
 	if(result != 0){
    2fb0:	85 c0                	test   %eax,%eax
    2fb2:	75 17                	jne    2fcb <stopRecordingTest+0x3b>
		printf(stdout, "stoprecording test failed\n");
		exit();
	}
	printf(stdout, "stoprecording ok\n");
    2fb4:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    2fb9:	c7 44 24 04 11 46 00 	movl   $0x4611,0x4(%esp)
    2fc0:	00 
    2fc1:	89 04 24             	mov    %eax,(%esp)
    2fc4:	e8 f7 04 00 00       	call   34c0 <printf>
}
    2fc9:	c9                   	leave  
    2fca:	c3                   	ret    
stopRecordingTest(void){
	int result;
 	printf(stdout, "stoprecording test\n");
 	result = stoprecording();
 	if(result != 0){
		printf(stdout, "stoprecording test failed\n");
    2fcb:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    2fd0:	c7 44 24 04 f6 45 00 	movl   $0x45f6,0x4(%esp)
    2fd7:	00 
    2fd8:	89 04 24             	mov    %eax,(%esp)
    2fdb:	e8 e0 04 00 00       	call   34c0 <printf>
		exit();
    2fe0:	e8 83 03 00 00       	call   3368 <exit>
    2fe5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002ff0 <fetchRecordsTest>:
	}
	printf(stdout, "startrecording ok\n");
}

void
fetchRecordsTest(void){
    2ff0:	55                   	push   %ebp
    2ff1:	89 e5                	mov    %esp,%ebp
    2ff3:	83 ec 18             	sub    $0x18,%esp
	int result;
 	printf(stdout, "fetchrecords test\n");
    2ff6:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    2ffb:	c7 44 24 04 23 46 00 	movl   $0x4623,0x4(%esp)
    3002:	00 
    3003:	89 04 24             	mov    %eax,(%esp)
    3006:	e8 b5 04 00 00       	call   34c0 <printf>
 	result = fetchrecords();
    300b:	e8 08 04 00 00       	call   3418 <fetchrecords>
 	if(result != 0){
    3010:	85 c0                	test   %eax,%eax
    3012:	75 17                	jne    302b <fetchRecordsTest+0x3b>
		printf(stdout, "fetchrecords test failed\n");
		exit();
	}
	printf(stdout, "fetchrecords ok\n");
    3014:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    3019:	c7 44 24 04 50 46 00 	movl   $0x4650,0x4(%esp)
    3020:	00 
    3021:	89 04 24             	mov    %eax,(%esp)
    3024:	e8 97 04 00 00       	call   34c0 <printf>
}
    3029:	c9                   	leave  
    302a:	c3                   	ret    
fetchRecordsTest(void){
	int result;
 	printf(stdout, "fetchrecords test\n");
 	result = fetchrecords();
 	if(result != 0){
		printf(stdout, "fetchrecords test failed\n");
    302b:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    3030:	c7 44 24 04 36 46 00 	movl   $0x4636,0x4(%esp)
    3037:	00 
    3038:	89 04 24             	mov    %eax,(%esp)
    303b:	e8 80 04 00 00       	call   34c0 <printf>
		exit();
    3040:	e8 23 03 00 00       	call   3368 <exit>
    3045:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003050 <startRecordingTest>:

// simple file system tests


void
startRecordingTest(void){
    3050:	55                   	push   %ebp
    3051:	89 e5                	mov    %esp,%ebp
    3053:	83 ec 18             	sub    $0x18,%esp
	int result;
 	printf(stdout, "startrecording test\n");
    3056:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    305b:	c7 44 24 04 61 46 00 	movl   $0x4661,0x4(%esp)
    3062:	00 
    3063:	89 04 24             	mov    %eax,(%esp)
    3066:	e8 55 04 00 00       	call   34c0 <printf>
 	result = startrecording();
    306b:	e8 98 03 00 00       	call   3408 <startrecording>
 	if(result != 0){
    3070:	85 c0                	test   %eax,%eax
    3072:	75 17                	jne    308b <startRecordingTest+0x3b>
		printf(stdout, "startrecording test failed\n");
		exit();
	}
	printf(stdout, "startrecording ok\n");
    3074:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    3079:	c7 44 24 04 92 46 00 	movl   $0x4692,0x4(%esp)
    3080:	00 
    3081:	89 04 24             	mov    %eax,(%esp)
    3084:	e8 37 04 00 00       	call   34c0 <printf>
}
    3089:	c9                   	leave  
    308a:	c3                   	ret    
startRecordingTest(void){
	int result;
 	printf(stdout, "startrecording test\n");
 	result = startrecording();
 	if(result != 0){
		printf(stdout, "startrecording test failed\n");
    308b:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
    3090:	c7 44 24 04 76 46 00 	movl   $0x4676,0x4(%esp)
    3097:	00 
    3098:	89 04 24             	mov    %eax,(%esp)
    309b:	e8 20 04 00 00       	call   34c0 <printf>
		exit();
    30a0:	e8 c3 02 00 00       	call   3368 <exit>
    30a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    30a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000030b0 <main>:
  printf(stdout, "validate ok\n");
}

int
main(int argc, char *argv[])
{
    30b0:	55                   	push   %ebp
    30b1:	89 e5                	mov    %esp,%ebp
    30b3:	83 e4 f0             	and    $0xfffffff0,%esp
    30b6:	83 ec 10             	sub    $0x10,%esp
  printf(1, "usertests starting\n");
    30b9:	c7 44 24 04 a5 46 00 	movl   $0x46a5,0x4(%esp)
    30c0:	00 
    30c1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    30c8:	e8 f3 03 00 00       	call   34c0 <printf>

  if(open("usertests.ran", 0) >= 0){
    30cd:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    30d4:	00 
    30d5:	c7 04 24 b9 46 00 00 	movl   $0x46b9,(%esp)
    30dc:	e8 c7 02 00 00       	call   33a8 <open>
    30e1:	85 c0                	test   %eax,%eax
    30e3:	78 1b                	js     3100 <main+0x50>
    printf(1, "already ran user tests -- rebuild fs.img\n");
    30e5:	c7 44 24 04 14 4d 00 	movl   $0x4d14,0x4(%esp)
    30ec:	00 
    30ed:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    30f4:	e8 c7 03 00 00       	call   34c0 <printf>
    exit();
    30f9:	e8 6a 02 00 00       	call   3368 <exit>
    30fe:	66 90                	xchg   %ax,%ax
  }
  close(open("usertests.ran", O_CREATE));
    3100:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    3107:	00 
    3108:	c7 04 24 b9 46 00 00 	movl   $0x46b9,(%esp)
    310f:	e8 94 02 00 00       	call   33a8 <open>
    3114:	89 04 24             	mov    %eax,(%esp)
    3117:	e8 74 02 00 00       	call   3390 <close>

startRecordingTest();
    311c:	e8 2f ff ff ff       	call   3050 <startRecordingTest>
stopRecordingTest();
    3121:	e8 6a fe ff ff       	call   2f90 <stopRecordingTest>
fetchRecordsTest();
    3126:	e8 c5 fe ff ff       	call   2ff0 <fetchRecordsTest>
    312b:	90                   	nop
    312c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bigdir(); // slow

  exectest();
*/

  exit();
    3130:	e8 33 02 00 00       	call   3368 <exit>
    3135:	90                   	nop
    3136:	90                   	nop
    3137:	90                   	nop
    3138:	90                   	nop
    3139:	90                   	nop
    313a:	90                   	nop
    313b:	90                   	nop
    313c:	90                   	nop
    313d:	90                   	nop
    313e:	90                   	nop
    313f:	90                   	nop

00003140 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    3140:	55                   	push   %ebp
    3141:	31 d2                	xor    %edx,%edx
    3143:	89 e5                	mov    %esp,%ebp
    3145:	8b 45 08             	mov    0x8(%ebp),%eax
    3148:	53                   	push   %ebx
    3149:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    314c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3150:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
    3154:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    3157:	83 c2 01             	add    $0x1,%edx
    315a:	84 c9                	test   %cl,%cl
    315c:	75 f2                	jne    3150 <strcpy+0x10>
    ;
  return os;
}
    315e:	5b                   	pop    %ebx
    315f:	5d                   	pop    %ebp
    3160:	c3                   	ret    
    3161:	eb 0d                	jmp    3170 <strcmp>
    3163:	90                   	nop
    3164:	90                   	nop
    3165:	90                   	nop
    3166:	90                   	nop
    3167:	90                   	nop
    3168:	90                   	nop
    3169:	90                   	nop
    316a:	90                   	nop
    316b:	90                   	nop
    316c:	90                   	nop
    316d:	90                   	nop
    316e:	90                   	nop
    316f:	90                   	nop

00003170 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3170:	55                   	push   %ebp
    3171:	89 e5                	mov    %esp,%ebp
    3173:	53                   	push   %ebx
    3174:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3177:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    317a:	0f b6 01             	movzbl (%ecx),%eax
    317d:	84 c0                	test   %al,%al
    317f:	75 14                	jne    3195 <strcmp+0x25>
    3181:	eb 25                	jmp    31a8 <strcmp+0x38>
    3183:	90                   	nop
    3184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
    3188:	83 c1 01             	add    $0x1,%ecx
    318b:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    318e:	0f b6 01             	movzbl (%ecx),%eax
    3191:	84 c0                	test   %al,%al
    3193:	74 13                	je     31a8 <strcmp+0x38>
    3195:	0f b6 1a             	movzbl (%edx),%ebx
    3198:	38 d8                	cmp    %bl,%al
    319a:	74 ec                	je     3188 <strcmp+0x18>
    319c:	0f b6 db             	movzbl %bl,%ebx
    319f:	0f b6 c0             	movzbl %al,%eax
    31a2:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    31a4:	5b                   	pop    %ebx
    31a5:	5d                   	pop    %ebp
    31a6:	c3                   	ret    
    31a7:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    31a8:	0f b6 1a             	movzbl (%edx),%ebx
    31ab:	31 c0                	xor    %eax,%eax
    31ad:	0f b6 db             	movzbl %bl,%ebx
    31b0:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    31b2:	5b                   	pop    %ebx
    31b3:	5d                   	pop    %ebp
    31b4:	c3                   	ret    
    31b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    31b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000031c0 <strlen>:

uint
strlen(char *s)
{
    31c0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
    31c1:	31 d2                	xor    %edx,%edx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    31c3:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
    31c5:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    31c7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    31ca:	80 39 00             	cmpb   $0x0,(%ecx)
    31cd:	74 0c                	je     31db <strlen+0x1b>
    31cf:	90                   	nop
    31d0:	83 c2 01             	add    $0x1,%edx
    31d3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    31d7:	89 d0                	mov    %edx,%eax
    31d9:	75 f5                	jne    31d0 <strlen+0x10>
    ;
  return n;
}
    31db:	5d                   	pop    %ebp
    31dc:	c3                   	ret    
    31dd:	8d 76 00             	lea    0x0(%esi),%esi

000031e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    31e0:	55                   	push   %ebp
    31e1:	89 e5                	mov    %esp,%ebp
    31e3:	8b 55 08             	mov    0x8(%ebp),%edx
    31e6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    31e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    31ea:	8b 45 0c             	mov    0xc(%ebp),%eax
    31ed:	89 d7                	mov    %edx,%edi
    31ef:	fc                   	cld    
    31f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    31f2:	89 d0                	mov    %edx,%eax
    31f4:	5f                   	pop    %edi
    31f5:	5d                   	pop    %ebp
    31f6:	c3                   	ret    
    31f7:	89 f6                	mov    %esi,%esi
    31f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003200 <strchr>:

char*
strchr(const char *s, char c)
{
    3200:	55                   	push   %ebp
    3201:	89 e5                	mov    %esp,%ebp
    3203:	8b 45 08             	mov    0x8(%ebp),%eax
    3206:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    320a:	0f b6 10             	movzbl (%eax),%edx
    320d:	84 d2                	test   %dl,%dl
    320f:	75 11                	jne    3222 <strchr+0x22>
    3211:	eb 15                	jmp    3228 <strchr+0x28>
    3213:	90                   	nop
    3214:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3218:	83 c0 01             	add    $0x1,%eax
    321b:	0f b6 10             	movzbl (%eax),%edx
    321e:	84 d2                	test   %dl,%dl
    3220:	74 06                	je     3228 <strchr+0x28>
    if(*s == c)
    3222:	38 ca                	cmp    %cl,%dl
    3224:	75 f2                	jne    3218 <strchr+0x18>
      return (char*) s;
  return 0;
}
    3226:	5d                   	pop    %ebp
    3227:	c3                   	ret    
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    3228:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
    322a:	5d                   	pop    %ebp
    322b:	90                   	nop
    322c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3230:	c3                   	ret    
    3231:	eb 0d                	jmp    3240 <atoi>
    3233:	90                   	nop
    3234:	90                   	nop
    3235:	90                   	nop
    3236:	90                   	nop
    3237:	90                   	nop
    3238:	90                   	nop
    3239:	90                   	nop
    323a:	90                   	nop
    323b:	90                   	nop
    323c:	90                   	nop
    323d:	90                   	nop
    323e:	90                   	nop
    323f:	90                   	nop

00003240 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    3240:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3241:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
    3243:	89 e5                	mov    %esp,%ebp
    3245:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3248:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3249:	0f b6 11             	movzbl (%ecx),%edx
    324c:	8d 5a d0             	lea    -0x30(%edx),%ebx
    324f:	80 fb 09             	cmp    $0x9,%bl
    3252:	77 1c                	ja     3270 <atoi+0x30>
    3254:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
    3258:	0f be d2             	movsbl %dl,%edx
    325b:	83 c1 01             	add    $0x1,%ecx
    325e:	8d 04 80             	lea    (%eax,%eax,4),%eax
    3261:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3265:	0f b6 11             	movzbl (%ecx),%edx
    3268:	8d 5a d0             	lea    -0x30(%edx),%ebx
    326b:	80 fb 09             	cmp    $0x9,%bl
    326e:	76 e8                	jbe    3258 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
    3270:	5b                   	pop    %ebx
    3271:	5d                   	pop    %ebp
    3272:	c3                   	ret    
    3273:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003280 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    3280:	55                   	push   %ebp
    3281:	89 e5                	mov    %esp,%ebp
    3283:	56                   	push   %esi
    3284:	8b 45 08             	mov    0x8(%ebp),%eax
    3287:	53                   	push   %ebx
    3288:	8b 5d 10             	mov    0x10(%ebp),%ebx
    328b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    328e:	85 db                	test   %ebx,%ebx
    3290:	7e 14                	jle    32a6 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
    3292:	31 d2                	xor    %edx,%edx
    3294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
    3298:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    329c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    329f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    32a2:	39 da                	cmp    %ebx,%edx
    32a4:	75 f2                	jne    3298 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    32a6:	5b                   	pop    %ebx
    32a7:	5e                   	pop    %esi
    32a8:	5d                   	pop    %ebp
    32a9:	c3                   	ret    
    32aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000032b0 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
    32b0:	55                   	push   %ebp
    32b1:	89 e5                	mov    %esp,%ebp
    32b3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    32b6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
    32b9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
    32bc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    32bf:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    32c4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    32cb:	00 
    32cc:	89 04 24             	mov    %eax,(%esp)
    32cf:	e8 d4 00 00 00       	call   33a8 <open>
  if(fd < 0)
    32d4:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    32d6:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
    32d8:	78 19                	js     32f3 <stat+0x43>
    return -1;
  r = fstat(fd, st);
    32da:	8b 45 0c             	mov    0xc(%ebp),%eax
    32dd:	89 1c 24             	mov    %ebx,(%esp)
    32e0:	89 44 24 04          	mov    %eax,0x4(%esp)
    32e4:	e8 d7 00 00 00       	call   33c0 <fstat>
  close(fd);
    32e9:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
    32ec:	89 c6                	mov    %eax,%esi
  close(fd);
    32ee:	e8 9d 00 00 00       	call   3390 <close>
  return r;
}
    32f3:	89 f0                	mov    %esi,%eax
    32f5:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    32f8:	8b 75 fc             	mov    -0x4(%ebp),%esi
    32fb:	89 ec                	mov    %ebp,%esp
    32fd:	5d                   	pop    %ebp
    32fe:	c3                   	ret    
    32ff:	90                   	nop

00003300 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
    3300:	55                   	push   %ebp
    3301:	89 e5                	mov    %esp,%ebp
    3303:	57                   	push   %edi
    3304:	56                   	push   %esi
    3305:	31 f6                	xor    %esi,%esi
    3307:	53                   	push   %ebx
    3308:	83 ec 2c             	sub    $0x2c,%esp
    330b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    330e:	eb 06                	jmp    3316 <gets+0x16>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    3310:	3c 0a                	cmp    $0xa,%al
    3312:	74 39                	je     334d <gets+0x4d>
    3314:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3316:	8d 5e 01             	lea    0x1(%esi),%ebx
    3319:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    331c:	7d 31                	jge    334f <gets+0x4f>
    cc = read(0, &c, 1);
    331e:	8d 45 e7             	lea    -0x19(%ebp),%eax
    3321:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3328:	00 
    3329:	89 44 24 04          	mov    %eax,0x4(%esp)
    332d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3334:	e8 47 00 00 00       	call   3380 <read>
    if(cc < 1)
    3339:	85 c0                	test   %eax,%eax
    333b:	7e 12                	jle    334f <gets+0x4f>
      break;
    buf[i++] = c;
    333d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    3341:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
    3345:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    3349:	3c 0d                	cmp    $0xd,%al
    334b:	75 c3                	jne    3310 <gets+0x10>
    334d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    334f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    3353:	89 f8                	mov    %edi,%eax
    3355:	83 c4 2c             	add    $0x2c,%esp
    3358:	5b                   	pop    %ebx
    3359:	5e                   	pop    %esi
    335a:	5f                   	pop    %edi
    335b:	5d                   	pop    %ebp
    335c:	c3                   	ret    
    335d:	90                   	nop
    335e:	90                   	nop
    335f:	90                   	nop

00003360 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    3360:	b8 01 00 00 00       	mov    $0x1,%eax
    3365:	cd 40                	int    $0x40
    3367:	c3                   	ret    

00003368 <exit>:
SYSCALL(exit)
    3368:	b8 02 00 00 00       	mov    $0x2,%eax
    336d:	cd 40                	int    $0x40
    336f:	c3                   	ret    

00003370 <wait>:
SYSCALL(wait)
    3370:	b8 03 00 00 00       	mov    $0x3,%eax
    3375:	cd 40                	int    $0x40
    3377:	c3                   	ret    

00003378 <pipe>:
SYSCALL(pipe)
    3378:	b8 04 00 00 00       	mov    $0x4,%eax
    337d:	cd 40                	int    $0x40
    337f:	c3                   	ret    

00003380 <read>:
SYSCALL(read)
    3380:	b8 06 00 00 00       	mov    $0x6,%eax
    3385:	cd 40                	int    $0x40
    3387:	c3                   	ret    

00003388 <write>:
SYSCALL(write)
    3388:	b8 05 00 00 00       	mov    $0x5,%eax
    338d:	cd 40                	int    $0x40
    338f:	c3                   	ret    

00003390 <close>:
SYSCALL(close)
    3390:	b8 07 00 00 00       	mov    $0x7,%eax
    3395:	cd 40                	int    $0x40
    3397:	c3                   	ret    

00003398 <kill>:
SYSCALL(kill)
    3398:	b8 08 00 00 00       	mov    $0x8,%eax
    339d:	cd 40                	int    $0x40
    339f:	c3                   	ret    

000033a0 <exec>:
SYSCALL(exec)
    33a0:	b8 09 00 00 00       	mov    $0x9,%eax
    33a5:	cd 40                	int    $0x40
    33a7:	c3                   	ret    

000033a8 <open>:
SYSCALL(open)
    33a8:	b8 0a 00 00 00       	mov    $0xa,%eax
    33ad:	cd 40                	int    $0x40
    33af:	c3                   	ret    

000033b0 <mknod>:
SYSCALL(mknod)
    33b0:	b8 0b 00 00 00       	mov    $0xb,%eax
    33b5:	cd 40                	int    $0x40
    33b7:	c3                   	ret    

000033b8 <unlink>:
SYSCALL(unlink)
    33b8:	b8 0c 00 00 00       	mov    $0xc,%eax
    33bd:	cd 40                	int    $0x40
    33bf:	c3                   	ret    

000033c0 <fstat>:
SYSCALL(fstat)
    33c0:	b8 0d 00 00 00       	mov    $0xd,%eax
    33c5:	cd 40                	int    $0x40
    33c7:	c3                   	ret    

000033c8 <link>:
SYSCALL(link)
    33c8:	b8 0e 00 00 00       	mov    $0xe,%eax
    33cd:	cd 40                	int    $0x40
    33cf:	c3                   	ret    

000033d0 <mkdir>:
SYSCALL(mkdir)
    33d0:	b8 0f 00 00 00       	mov    $0xf,%eax
    33d5:	cd 40                	int    $0x40
    33d7:	c3                   	ret    

000033d8 <chdir>:
SYSCALL(chdir)
    33d8:	b8 10 00 00 00       	mov    $0x10,%eax
    33dd:	cd 40                	int    $0x40
    33df:	c3                   	ret    

000033e0 <dup>:
SYSCALL(dup)
    33e0:	b8 11 00 00 00       	mov    $0x11,%eax
    33e5:	cd 40                	int    $0x40
    33e7:	c3                   	ret    

000033e8 <getpid>:
SYSCALL(getpid)
    33e8:	b8 12 00 00 00       	mov    $0x12,%eax
    33ed:	cd 40                	int    $0x40
    33ef:	c3                   	ret    

000033f0 <sbrk>:
SYSCALL(sbrk)
    33f0:	b8 13 00 00 00       	mov    $0x13,%eax
    33f5:	cd 40                	int    $0x40
    33f7:	c3                   	ret    

000033f8 <sleep>:
SYSCALL(sleep)
    33f8:	b8 14 00 00 00       	mov    $0x14,%eax
    33fd:	cd 40                	int    $0x40
    33ff:	c3                   	ret    

00003400 <uptime>:
SYSCALL(uptime)
    3400:	b8 15 00 00 00       	mov    $0x15,%eax
    3405:	cd 40                	int    $0x40
    3407:	c3                   	ret    

00003408 <startrecording>:
SYSCALL(startrecording)
    3408:	b8 16 00 00 00       	mov    $0x16,%eax
    340d:	cd 40                	int    $0x40
    340f:	c3                   	ret    

00003410 <stoprecording>:
SYSCALL(stoprecording)
    3410:	b8 17 00 00 00       	mov    $0x17,%eax
    3415:	cd 40                	int    $0x40
    3417:	c3                   	ret    

00003418 <fetchrecords>:
    3418:	b8 18 00 00 00       	mov    $0x18,%eax
    341d:	cd 40                	int    $0x40
    341f:	c3                   	ret    

00003420 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    3420:	55                   	push   %ebp
    3421:	89 e5                	mov    %esp,%ebp
    3423:	57                   	push   %edi
    3424:	89 cf                	mov    %ecx,%edi
    3426:	56                   	push   %esi
    3427:	89 c6                	mov    %eax,%esi
    3429:	53                   	push   %ebx
    342a:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    342d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3430:	85 c9                	test   %ecx,%ecx
    3432:	74 04                	je     3438 <printint+0x18>
    3434:	85 d2                	test   %edx,%edx
    3436:	78 70                	js     34a8 <printint+0x88>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    3438:	89 d0                	mov    %edx,%eax
    343a:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    3441:	31 c9                	xor    %ecx,%ecx
    3443:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    3446:	66 90                	xchg   %ax,%ax
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    3448:	31 d2                	xor    %edx,%edx
    344a:	f7 f7                	div    %edi
    344c:	0f b6 92 47 4d 00 00 	movzbl 0x4d47(%edx),%edx
    3453:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
    3456:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
    3459:	85 c0                	test   %eax,%eax
    345b:	75 eb                	jne    3448 <printint+0x28>
  if(neg)
    345d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    3460:	85 c0                	test   %eax,%eax
    3462:	74 08                	je     346c <printint+0x4c>
    buf[i++] = '-';
    3464:	c6 44 0d d7 2d       	movb   $0x2d,-0x29(%ebp,%ecx,1)
    3469:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
    346c:	8d 79 ff             	lea    -0x1(%ecx),%edi
    346f:	01 fb                	add    %edi,%ebx
    3471:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3478:	0f b6 03             	movzbl (%ebx),%eax
    347b:	83 ef 01             	sub    $0x1,%edi
    347e:	83 eb 01             	sub    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3481:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3488:	00 
    3489:	89 34 24             	mov    %esi,(%esp)
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    348c:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    348f:	8d 45 e7             	lea    -0x19(%ebp),%eax
    3492:	89 44 24 04          	mov    %eax,0x4(%esp)
    3496:	e8 ed fe ff ff       	call   3388 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    349b:	83 ff ff             	cmp    $0xffffffff,%edi
    349e:	75 d8                	jne    3478 <printint+0x58>
    putc(fd, buf[i]);
}
    34a0:	83 c4 4c             	add    $0x4c,%esp
    34a3:	5b                   	pop    %ebx
    34a4:	5e                   	pop    %esi
    34a5:	5f                   	pop    %edi
    34a6:	5d                   	pop    %ebp
    34a7:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    34a8:	89 d0                	mov    %edx,%eax
    34aa:	f7 d8                	neg    %eax
    34ac:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    34b3:	eb 8c                	jmp    3441 <printint+0x21>
    34b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    34b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000034c0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    34c0:	55                   	push   %ebp
    34c1:	89 e5                	mov    %esp,%ebp
    34c3:	57                   	push   %edi
    34c4:	56                   	push   %esi
    34c5:	53                   	push   %ebx
    34c6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    34c9:	8b 45 0c             	mov    0xc(%ebp),%eax
    34cc:	0f b6 10             	movzbl (%eax),%edx
    34cf:	84 d2                	test   %dl,%dl
    34d1:	0f 84 c9 00 00 00    	je     35a0 <printf+0xe0>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    34d7:	8d 4d 10             	lea    0x10(%ebp),%ecx
    34da:	31 ff                	xor    %edi,%edi
    34dc:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    34df:	31 db                	xor    %ebx,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    34e1:	8d 75 e7             	lea    -0x19(%ebp),%esi
    34e4:	eb 1e                	jmp    3504 <printf+0x44>
    34e6:	66 90                	xchg   %ax,%ax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    34e8:	83 fa 25             	cmp    $0x25,%edx
    34eb:	0f 85 b7 00 00 00    	jne    35a8 <printf+0xe8>
    34f1:	66 bf 25 00          	mov    $0x25,%di
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    34f5:	83 c3 01             	add    $0x1,%ebx
    34f8:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
    34fc:	84 d2                	test   %dl,%dl
    34fe:	0f 84 9c 00 00 00    	je     35a0 <printf+0xe0>
    c = fmt[i] & 0xff;
    if(state == 0){
    3504:	85 ff                	test   %edi,%edi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    3506:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
    3509:	74 dd                	je     34e8 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    350b:	83 ff 25             	cmp    $0x25,%edi
    350e:	75 e5                	jne    34f5 <printf+0x35>
      if(c == 'd'){
    3510:	83 fa 64             	cmp    $0x64,%edx
    3513:	0f 84 57 01 00 00    	je     3670 <printf+0x1b0>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    3519:	83 fa 70             	cmp    $0x70,%edx
    351c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3520:	0f 84 aa 00 00 00    	je     35d0 <printf+0x110>
    3526:	83 fa 78             	cmp    $0x78,%edx
    3529:	0f 84 a1 00 00 00    	je     35d0 <printf+0x110>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    352f:	83 fa 73             	cmp    $0x73,%edx
    3532:	0f 84 c0 00 00 00    	je     35f8 <printf+0x138>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    3538:	83 fa 63             	cmp    $0x63,%edx
    353b:	90                   	nop
    353c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3540:	0f 84 52 01 00 00    	je     3698 <printf+0x1d8>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    3546:	83 fa 25             	cmp    $0x25,%edx
    3549:	0f 84 f9 00 00 00    	je     3648 <printf+0x188>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    354f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3552:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3555:	31 ff                	xor    %edi,%edi
    3557:	89 55 cc             	mov    %edx,-0x34(%ebp)
    355a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    355e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3565:	00 
    3566:	89 0c 24             	mov    %ecx,(%esp)
    3569:	89 74 24 04          	mov    %esi,0x4(%esp)
    356d:	e8 16 fe ff ff       	call   3388 <write>
    3572:	8b 55 cc             	mov    -0x34(%ebp),%edx
    3575:	8b 45 08             	mov    0x8(%ebp),%eax
    3578:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    357f:	00 
    3580:	89 74 24 04          	mov    %esi,0x4(%esp)
    3584:	88 55 e7             	mov    %dl,-0x19(%ebp)
    3587:	89 04 24             	mov    %eax,(%esp)
    358a:	e8 f9 fd ff ff       	call   3388 <write>
    358f:	8b 45 0c             	mov    0xc(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3592:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
    3596:	84 d2                	test   %dl,%dl
    3598:	0f 85 66 ff ff ff    	jne    3504 <printf+0x44>
    359e:	66 90                	xchg   %ax,%ax
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    35a0:	83 c4 3c             	add    $0x3c,%esp
    35a3:	5b                   	pop    %ebx
    35a4:	5e                   	pop    %esi
    35a5:	5f                   	pop    %edi
    35a6:	5d                   	pop    %ebp
    35a7:	c3                   	ret    
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    35a8:	8b 45 08             	mov    0x8(%ebp),%eax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    35ab:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    35ae:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    35b5:	00 
    35b6:	89 74 24 04          	mov    %esi,0x4(%esp)
    35ba:	89 04 24             	mov    %eax,(%esp)
    35bd:	e8 c6 fd ff ff       	call   3388 <write>
    35c2:	8b 45 0c             	mov    0xc(%ebp),%eax
    35c5:	e9 2b ff ff ff       	jmp    34f5 <printf+0x35>
    35ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    35d0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    35d3:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
    35d8:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    35da:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    35e1:	8b 10                	mov    (%eax),%edx
    35e3:	8b 45 08             	mov    0x8(%ebp),%eax
    35e6:	e8 35 fe ff ff       	call   3420 <printint>
    35eb:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    35ee:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    35f2:	e9 fe fe ff ff       	jmp    34f5 <printf+0x35>
    35f7:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
    35f8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    35fb:	8b 3a                	mov    (%edx),%edi
        ap++;
    35fd:	83 c2 04             	add    $0x4,%edx
    3600:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
    3603:	85 ff                	test   %edi,%edi
    3605:	0f 84 ba 00 00 00    	je     36c5 <printf+0x205>
          s = "(null)";
        while(*s != 0){
    360b:	0f b6 17             	movzbl (%edi),%edx
    360e:	84 d2                	test   %dl,%dl
    3610:	74 2d                	je     363f <printf+0x17f>
    3612:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    3615:	8b 5d 08             	mov    0x8(%ebp),%ebx
          putc(fd, *s);
          s++;
    3618:	83 c7 01             	add    $0x1,%edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    361b:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    361e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3625:	00 
    3626:	89 74 24 04          	mov    %esi,0x4(%esp)
    362a:	89 1c 24             	mov    %ebx,(%esp)
    362d:	e8 56 fd ff ff       	call   3388 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    3632:	0f b6 17             	movzbl (%edi),%edx
    3635:	84 d2                	test   %dl,%dl
    3637:	75 df                	jne    3618 <printf+0x158>
    3639:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    363c:	8b 45 0c             	mov    0xc(%ebp),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    363f:	31 ff                	xor    %edi,%edi
    3641:	e9 af fe ff ff       	jmp    34f5 <printf+0x35>
    3646:	66 90                	xchg   %ax,%ax
    3648:	8b 55 08             	mov    0x8(%ebp),%edx
    364b:	31 ff                	xor    %edi,%edi
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    364d:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3651:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3658:	00 
    3659:	89 74 24 04          	mov    %esi,0x4(%esp)
    365d:	89 14 24             	mov    %edx,(%esp)
    3660:	e8 23 fd ff ff       	call   3388 <write>
    3665:	8b 45 0c             	mov    0xc(%ebp),%eax
    3668:	e9 88 fe ff ff       	jmp    34f5 <printf+0x35>
    366d:	8d 76 00             	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    3670:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    3673:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
    3678:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    367b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3682:	8b 10                	mov    (%eax),%edx
    3684:	8b 45 08             	mov    0x8(%ebp),%eax
    3687:	e8 94 fd ff ff       	call   3420 <printint>
    368c:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    368f:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    3693:	e9 5d fe ff ff       	jmp    34f5 <printf+0x35>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    3698:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
        putc(fd, *ap);
        ap++;
    369b:	31 ff                	xor    %edi,%edi
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    369d:	8b 01                	mov    (%ecx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    369f:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    36a6:	00 
    36a7:	89 74 24 04          	mov    %esi,0x4(%esp)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    36ab:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    36ae:	8b 45 08             	mov    0x8(%ebp),%eax
    36b1:	89 04 24             	mov    %eax,(%esp)
    36b4:	e8 cf fc ff ff       	call   3388 <write>
    36b9:	8b 45 0c             	mov    0xc(%ebp),%eax
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
    36bc:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    36c0:	e9 30 fe ff ff       	jmp    34f5 <printf+0x35>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
    36c5:	bf 40 4d 00 00       	mov    $0x4d40,%edi
    36ca:	e9 3c ff ff ff       	jmp    360b <printf+0x14b>
    36cf:	90                   	nop

000036d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    36d0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    36d1:	a1 88 4d 00 00       	mov    0x4d88,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    36d6:	89 e5                	mov    %esp,%ebp
    36d8:	57                   	push   %edi
    36d9:	56                   	push   %esi
    36da:	53                   	push   %ebx
    36db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
    36de:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    36e1:	39 c8                	cmp    %ecx,%eax
    36e3:	73 1d                	jae    3702 <free+0x32>
    36e5:	8d 76 00             	lea    0x0(%esi),%esi
    36e8:	8b 10                	mov    (%eax),%edx
    36ea:	39 d1                	cmp    %edx,%ecx
    36ec:	72 1a                	jb     3708 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    36ee:	39 d0                	cmp    %edx,%eax
    36f0:	72 08                	jb     36fa <free+0x2a>
    36f2:	39 c8                	cmp    %ecx,%eax
    36f4:	72 12                	jb     3708 <free+0x38>
    36f6:	39 d1                	cmp    %edx,%ecx
    36f8:	72 0e                	jb     3708 <free+0x38>
    36fa:	89 d0                	mov    %edx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    36fc:	39 c8                	cmp    %ecx,%eax
    36fe:	66 90                	xchg   %ax,%ax
    3700:	72 e6                	jb     36e8 <free+0x18>
    3702:	8b 10                	mov    (%eax),%edx
    3704:	eb e8                	jmp    36ee <free+0x1e>
    3706:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    3708:	8b 71 04             	mov    0x4(%ecx),%esi
    370b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    370e:	39 d7                	cmp    %edx,%edi
    3710:	74 19                	je     372b <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    3712:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    3715:	8b 50 04             	mov    0x4(%eax),%edx
    3718:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    371b:	39 ce                	cmp    %ecx,%esi
    371d:	74 23                	je     3742 <free+0x72>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    371f:	89 08                	mov    %ecx,(%eax)
  freep = p;
    3721:	a3 88 4d 00 00       	mov    %eax,0x4d88
}
    3726:	5b                   	pop    %ebx
    3727:	5e                   	pop    %esi
    3728:	5f                   	pop    %edi
    3729:	5d                   	pop    %ebp
    372a:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    372b:	03 72 04             	add    0x4(%edx),%esi
    372e:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
    3731:	8b 10                	mov    (%eax),%edx
    3733:	8b 12                	mov    (%edx),%edx
    3735:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    3738:	8b 50 04             	mov    0x4(%eax),%edx
    373b:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    373e:	39 ce                	cmp    %ecx,%esi
    3740:	75 dd                	jne    371f <free+0x4f>
    p->s.size += bp->s.size;
    3742:	03 51 04             	add    0x4(%ecx),%edx
    3745:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    3748:	8b 53 f8             	mov    -0x8(%ebx),%edx
    374b:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
    374d:	a3 88 4d 00 00       	mov    %eax,0x4d88
}
    3752:	5b                   	pop    %ebx
    3753:	5e                   	pop    %esi
    3754:	5f                   	pop    %edi
    3755:	5d                   	pop    %ebp
    3756:	c3                   	ret    
    3757:	89 f6                	mov    %esi,%esi
    3759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003760 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3760:	55                   	push   %ebp
    3761:	89 e5                	mov    %esp,%ebp
    3763:	57                   	push   %edi
    3764:	56                   	push   %esi
    3765:	53                   	push   %ebx
    3766:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3769:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
    376c:	8b 0d 88 4d 00 00    	mov    0x4d88,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3772:	83 c3 07             	add    $0x7,%ebx
    3775:	c1 eb 03             	shr    $0x3,%ebx
    3778:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    377b:	85 c9                	test   %ecx,%ecx
    377d:	0f 84 93 00 00 00    	je     3816 <malloc+0xb6>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3783:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    3785:	8b 50 04             	mov    0x4(%eax),%edx
    3788:	39 d3                	cmp    %edx,%ebx
    378a:	76 1f                	jbe    37ab <malloc+0x4b>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
    378c:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    3793:	90                   	nop
    3794:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
    if(p == freep)
    3798:	3b 05 88 4d 00 00    	cmp    0x4d88,%eax
    379e:	74 30                	je     37d0 <malloc+0x70>
    37a0:	89 c1                	mov    %eax,%ecx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    37a2:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    37a4:	8b 50 04             	mov    0x4(%eax),%edx
    37a7:	39 d3                	cmp    %edx,%ebx
    37a9:	77 ed                	ja     3798 <malloc+0x38>
      if(p->s.size == nunits)
    37ab:	39 d3                	cmp    %edx,%ebx
    37ad:	74 61                	je     3810 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    37af:	29 da                	sub    %ebx,%edx
    37b1:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    37b4:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    37b7:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    37ba:	89 0d 88 4d 00 00    	mov    %ecx,0x4d88
      return (void*) (p + 1);
    37c0:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    37c3:	83 c4 1c             	add    $0x1c,%esp
    37c6:	5b                   	pop    %ebx
    37c7:	5e                   	pop    %esi
    37c8:	5f                   	pop    %edi
    37c9:	5d                   	pop    %ebp
    37ca:	c3                   	ret    
    37cb:	90                   	nop
    37cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    37d0:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
    37d6:	b8 00 80 00 00       	mov    $0x8000,%eax
    37db:	bf 00 10 00 00       	mov    $0x1000,%edi
    37e0:	76 04                	jbe    37e6 <malloc+0x86>
    37e2:	89 f0                	mov    %esi,%eax
    37e4:	89 df                	mov    %ebx,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    37e6:	89 04 24             	mov    %eax,(%esp)
    37e9:	e8 02 fc ff ff       	call   33f0 <sbrk>
  if(p == (char*) -1)
    37ee:	83 f8 ff             	cmp    $0xffffffff,%eax
    37f1:	74 18                	je     380b <malloc+0xab>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    37f3:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
    37f6:	83 c0 08             	add    $0x8,%eax
    37f9:	89 04 24             	mov    %eax,(%esp)
    37fc:	e8 cf fe ff ff       	call   36d0 <free>
  return freep;
    3801:	8b 0d 88 4d 00 00    	mov    0x4d88,%ecx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    3807:	85 c9                	test   %ecx,%ecx
    3809:	75 97                	jne    37a2 <malloc+0x42>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    380b:	31 c0                	xor    %eax,%eax
    380d:	eb b4                	jmp    37c3 <malloc+0x63>
    380f:	90                   	nop
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    3810:	8b 10                	mov    (%eax),%edx
    3812:	89 11                	mov    %edx,(%ecx)
    3814:	eb a4                	jmp    37ba <malloc+0x5a>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    3816:	c7 05 88 4d 00 00 80 	movl   $0x4d80,0x4d88
    381d:	4d 00 00 
    base.s.size = 0;
    3820:	b9 80 4d 00 00       	mov    $0x4d80,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    3825:	c7 05 80 4d 00 00 80 	movl   $0x4d80,0x4d80
    382c:	4d 00 00 
    base.s.size = 0;
    382f:	c7 05 84 4d 00 00 00 	movl   $0x0,0x4d84
    3836:	00 00 00 
    3839:	e9 45 ff ff ff       	jmp    3783 <malloc+0x23>
