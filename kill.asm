
_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	57                   	push   %edi
   7:	56                   	push   %esi
   8:	53                   	push   %ebx
   9:	83 ec 14             	sub    $0x14,%esp
   c:	8b 75 08             	mov    0x8(%ebp),%esi
   f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  if(argc < 1){
  12:	85 f6                	test   %esi,%esi
  14:	7e 2a                	jle    40 <main+0x40>
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
  16:	83 fe 01             	cmp    $0x1,%esi
{
  int i;

  if(argc < 1){
    printf(2, "usage: kill pid...\n");
    exit();
  19:	bb 01 00 00 00       	mov    $0x1,%ebx
  }
  for(i=1; i<argc; i++)
  1e:	74 1a                	je     3a <main+0x3a>
    kill(atoi(argv[i]));
  20:	8b 04 9f             	mov    (%edi,%ebx,4),%eax

  if(argc < 1){
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
  23:	83 c3 01             	add    $0x1,%ebx
    kill(atoi(argv[i]));
  26:	89 04 24             	mov    %eax,(%esp)
  29:	e8 32 01 00 00       	call   160 <atoi>
  2e:	89 04 24             	mov    %eax,(%esp)
  31:	e8 82 02 00 00       	call   2b8 <kill>

  if(argc < 1){
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
  36:	39 de                	cmp    %ebx,%esi
  38:	7f e6                	jg     20 <main+0x20>
    kill(atoi(argv[i]));
  exit();
  3a:	e8 49 02 00 00       	call   288 <exit>
  3f:	90                   	nop
main(int argc, char **argv)
{
  int i;

  if(argc < 1){
    printf(2, "usage: kill pid...\n");
  40:	c7 44 24 04 5e 07 00 	movl   $0x75e,0x4(%esp)
  47:	00 
  48:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  4f:	e8 8c 03 00 00       	call   3e0 <printf>
    exit();
  54:	e8 2f 02 00 00       	call   288 <exit>
  59:	90                   	nop
  5a:	90                   	nop
  5b:	90                   	nop
  5c:	90                   	nop
  5d:	90                   	nop
  5e:	90                   	nop
  5f:	90                   	nop

00000060 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  60:	55                   	push   %ebp
  61:	31 d2                	xor    %edx,%edx
  63:	89 e5                	mov    %esp,%ebp
  65:	8b 45 08             	mov    0x8(%ebp),%eax
  68:	53                   	push   %ebx
  69:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  70:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
  74:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  77:	83 c2 01             	add    $0x1,%edx
  7a:	84 c9                	test   %cl,%cl
  7c:	75 f2                	jne    70 <strcpy+0x10>
    ;
  return os;
}
  7e:	5b                   	pop    %ebx
  7f:	5d                   	pop    %ebp
  80:	c3                   	ret    
  81:	eb 0d                	jmp    90 <strcmp>
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

00000090 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	53                   	push   %ebx
  94:	8b 4d 08             	mov    0x8(%ebp),%ecx
  97:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  9a:	0f b6 01             	movzbl (%ecx),%eax
  9d:	84 c0                	test   %al,%al
  9f:	75 14                	jne    b5 <strcmp+0x25>
  a1:	eb 25                	jmp    c8 <strcmp+0x38>
  a3:	90                   	nop
  a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
  a8:	83 c1 01             	add    $0x1,%ecx
  ab:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  ae:	0f b6 01             	movzbl (%ecx),%eax
  b1:	84 c0                	test   %al,%al
  b3:	74 13                	je     c8 <strcmp+0x38>
  b5:	0f b6 1a             	movzbl (%edx),%ebx
  b8:	38 d8                	cmp    %bl,%al
  ba:	74 ec                	je     a8 <strcmp+0x18>
  bc:	0f b6 db             	movzbl %bl,%ebx
  bf:	0f b6 c0             	movzbl %al,%eax
  c2:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
  c4:	5b                   	pop    %ebx
  c5:	5d                   	pop    %ebp
  c6:	c3                   	ret    
  c7:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  c8:	0f b6 1a             	movzbl (%edx),%ebx
  cb:	31 c0                	xor    %eax,%eax
  cd:	0f b6 db             	movzbl %bl,%ebx
  d0:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
  d2:	5b                   	pop    %ebx
  d3:	5d                   	pop    %ebp
  d4:	c3                   	ret    
  d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000e0 <strlen>:

uint
strlen(char *s)
{
  e0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
  e1:	31 d2                	xor    %edx,%edx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
  e3:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
  e5:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
  e7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  ea:	80 39 00             	cmpb   $0x0,(%ecx)
  ed:	74 0c                	je     fb <strlen+0x1b>
  ef:	90                   	nop
  f0:	83 c2 01             	add    $0x1,%edx
  f3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  f7:	89 d0                	mov    %edx,%eax
  f9:	75 f5                	jne    f0 <strlen+0x10>
    ;
  return n;
}
  fb:	5d                   	pop    %ebp
  fc:	c3                   	ret    
  fd:	8d 76 00             	lea    0x0(%esi),%esi

00000100 <memset>:

void*
memset(void *dst, int c, uint n)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 55 08             	mov    0x8(%ebp),%edx
 106:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 107:	8b 4d 10             	mov    0x10(%ebp),%ecx
 10a:	8b 45 0c             	mov    0xc(%ebp),%eax
 10d:	89 d7                	mov    %edx,%edi
 10f:	fc                   	cld    
 110:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 112:	89 d0                	mov    %edx,%eax
 114:	5f                   	pop    %edi
 115:	5d                   	pop    %ebp
 116:	c3                   	ret    
 117:	89 f6                	mov    %esi,%esi
 119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000120 <strchr>:

char*
strchr(const char *s, char c)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	8b 45 08             	mov    0x8(%ebp),%eax
 126:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 12a:	0f b6 10             	movzbl (%eax),%edx
 12d:	84 d2                	test   %dl,%dl
 12f:	75 11                	jne    142 <strchr+0x22>
 131:	eb 15                	jmp    148 <strchr+0x28>
 133:	90                   	nop
 134:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 138:	83 c0 01             	add    $0x1,%eax
 13b:	0f b6 10             	movzbl (%eax),%edx
 13e:	84 d2                	test   %dl,%dl
 140:	74 06                	je     148 <strchr+0x28>
    if(*s == c)
 142:	38 ca                	cmp    %cl,%dl
 144:	75 f2                	jne    138 <strchr+0x18>
      return (char*) s;
  return 0;
}
 146:	5d                   	pop    %ebp
 147:	c3                   	ret    
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 148:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 14a:	5d                   	pop    %ebp
 14b:	90                   	nop
 14c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 150:	c3                   	ret    
 151:	eb 0d                	jmp    160 <atoi>
 153:	90                   	nop
 154:	90                   	nop
 155:	90                   	nop
 156:	90                   	nop
 157:	90                   	nop
 158:	90                   	nop
 159:	90                   	nop
 15a:	90                   	nop
 15b:	90                   	nop
 15c:	90                   	nop
 15d:	90                   	nop
 15e:	90                   	nop
 15f:	90                   	nop

00000160 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 160:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 161:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
 163:	89 e5                	mov    %esp,%ebp
 165:	8b 4d 08             	mov    0x8(%ebp),%ecx
 168:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 169:	0f b6 11             	movzbl (%ecx),%edx
 16c:	8d 5a d0             	lea    -0x30(%edx),%ebx
 16f:	80 fb 09             	cmp    $0x9,%bl
 172:	77 1c                	ja     190 <atoi+0x30>
 174:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 178:	0f be d2             	movsbl %dl,%edx
 17b:	83 c1 01             	add    $0x1,%ecx
 17e:	8d 04 80             	lea    (%eax,%eax,4),%eax
 181:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 185:	0f b6 11             	movzbl (%ecx),%edx
 188:	8d 5a d0             	lea    -0x30(%edx),%ebx
 18b:	80 fb 09             	cmp    $0x9,%bl
 18e:	76 e8                	jbe    178 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 190:	5b                   	pop    %ebx
 191:	5d                   	pop    %ebp
 192:	c3                   	ret    
 193:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001a0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	56                   	push   %esi
 1a4:	8b 45 08             	mov    0x8(%ebp),%eax
 1a7:	53                   	push   %ebx
 1a8:	8b 5d 10             	mov    0x10(%ebp),%ebx
 1ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1ae:	85 db                	test   %ebx,%ebx
 1b0:	7e 14                	jle    1c6 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
 1b2:	31 d2                	xor    %edx,%edx
 1b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
 1b8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 1bc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 1bf:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1c2:	39 da                	cmp    %ebx,%edx
 1c4:	75 f2                	jne    1b8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 1c6:	5b                   	pop    %ebx
 1c7:	5e                   	pop    %esi
 1c8:	5d                   	pop    %ebp
 1c9:	c3                   	ret    
 1ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001d0 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1d6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 1d9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 1dc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 1df:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1e4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1eb:	00 
 1ec:	89 04 24             	mov    %eax,(%esp)
 1ef:	e8 d4 00 00 00       	call   2c8 <open>
  if(fd < 0)
 1f4:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f6:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 1f8:	78 19                	js     213 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 1fa:	8b 45 0c             	mov    0xc(%ebp),%eax
 1fd:	89 1c 24             	mov    %ebx,(%esp)
 200:	89 44 24 04          	mov    %eax,0x4(%esp)
 204:	e8 d7 00 00 00       	call   2e0 <fstat>
  close(fd);
 209:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 20c:	89 c6                	mov    %eax,%esi
  close(fd);
 20e:	e8 9d 00 00 00       	call   2b0 <close>
  return r;
}
 213:	89 f0                	mov    %esi,%eax
 215:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 218:	8b 75 fc             	mov    -0x4(%ebp),%esi
 21b:	89 ec                	mov    %ebp,%esp
 21d:	5d                   	pop    %ebp
 21e:	c3                   	ret    
 21f:	90                   	nop

00000220 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	57                   	push   %edi
 224:	56                   	push   %esi
 225:	31 f6                	xor    %esi,%esi
 227:	53                   	push   %ebx
 228:	83 ec 2c             	sub    $0x2c,%esp
 22b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 22e:	eb 06                	jmp    236 <gets+0x16>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 230:	3c 0a                	cmp    $0xa,%al
 232:	74 39                	je     26d <gets+0x4d>
 234:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 236:	8d 5e 01             	lea    0x1(%esi),%ebx
 239:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 23c:	7d 31                	jge    26f <gets+0x4f>
    cc = read(0, &c, 1);
 23e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 241:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 248:	00 
 249:	89 44 24 04          	mov    %eax,0x4(%esp)
 24d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 254:	e8 47 00 00 00       	call   2a0 <read>
    if(cc < 1)
 259:	85 c0                	test   %eax,%eax
 25b:	7e 12                	jle    26f <gets+0x4f>
      break;
    buf[i++] = c;
 25d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 261:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 265:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 269:	3c 0d                	cmp    $0xd,%al
 26b:	75 c3                	jne    230 <gets+0x10>
 26d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 26f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 273:	89 f8                	mov    %edi,%eax
 275:	83 c4 2c             	add    $0x2c,%esp
 278:	5b                   	pop    %ebx
 279:	5e                   	pop    %esi
 27a:	5f                   	pop    %edi
 27b:	5d                   	pop    %ebp
 27c:	c3                   	ret    
 27d:	90                   	nop
 27e:	90                   	nop
 27f:	90                   	nop

00000280 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 280:	b8 01 00 00 00       	mov    $0x1,%eax
 285:	cd 40                	int    $0x40
 287:	c3                   	ret    

00000288 <exit>:
SYSCALL(exit)
 288:	b8 02 00 00 00       	mov    $0x2,%eax
 28d:	cd 40                	int    $0x40
 28f:	c3                   	ret    

00000290 <wait>:
SYSCALL(wait)
 290:	b8 03 00 00 00       	mov    $0x3,%eax
 295:	cd 40                	int    $0x40
 297:	c3                   	ret    

00000298 <pipe>:
SYSCALL(pipe)
 298:	b8 04 00 00 00       	mov    $0x4,%eax
 29d:	cd 40                	int    $0x40
 29f:	c3                   	ret    

000002a0 <read>:
SYSCALL(read)
 2a0:	b8 06 00 00 00       	mov    $0x6,%eax
 2a5:	cd 40                	int    $0x40
 2a7:	c3                   	ret    

000002a8 <write>:
SYSCALL(write)
 2a8:	b8 05 00 00 00       	mov    $0x5,%eax
 2ad:	cd 40                	int    $0x40
 2af:	c3                   	ret    

000002b0 <close>:
SYSCALL(close)
 2b0:	b8 07 00 00 00       	mov    $0x7,%eax
 2b5:	cd 40                	int    $0x40
 2b7:	c3                   	ret    

000002b8 <kill>:
SYSCALL(kill)
 2b8:	b8 08 00 00 00       	mov    $0x8,%eax
 2bd:	cd 40                	int    $0x40
 2bf:	c3                   	ret    

000002c0 <exec>:
SYSCALL(exec)
 2c0:	b8 09 00 00 00       	mov    $0x9,%eax
 2c5:	cd 40                	int    $0x40
 2c7:	c3                   	ret    

000002c8 <open>:
SYSCALL(open)
 2c8:	b8 0a 00 00 00       	mov    $0xa,%eax
 2cd:	cd 40                	int    $0x40
 2cf:	c3                   	ret    

000002d0 <mknod>:
SYSCALL(mknod)
 2d0:	b8 0b 00 00 00       	mov    $0xb,%eax
 2d5:	cd 40                	int    $0x40
 2d7:	c3                   	ret    

000002d8 <unlink>:
SYSCALL(unlink)
 2d8:	b8 0c 00 00 00       	mov    $0xc,%eax
 2dd:	cd 40                	int    $0x40
 2df:	c3                   	ret    

000002e0 <fstat>:
SYSCALL(fstat)
 2e0:	b8 0d 00 00 00       	mov    $0xd,%eax
 2e5:	cd 40                	int    $0x40
 2e7:	c3                   	ret    

000002e8 <link>:
SYSCALL(link)
 2e8:	b8 0e 00 00 00       	mov    $0xe,%eax
 2ed:	cd 40                	int    $0x40
 2ef:	c3                   	ret    

000002f0 <mkdir>:
SYSCALL(mkdir)
 2f0:	b8 0f 00 00 00       	mov    $0xf,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <chdir>:
SYSCALL(chdir)
 2f8:	b8 10 00 00 00       	mov    $0x10,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <dup>:
SYSCALL(dup)
 300:	b8 11 00 00 00       	mov    $0x11,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <getpid>:
SYSCALL(getpid)
 308:	b8 12 00 00 00       	mov    $0x12,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <sbrk>:
SYSCALL(sbrk)
 310:	b8 13 00 00 00       	mov    $0x13,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <sleep>:
SYSCALL(sleep)
 318:	b8 14 00 00 00       	mov    $0x14,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <uptime>:
SYSCALL(uptime)
 320:	b8 15 00 00 00       	mov    $0x15,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <startrecording>:
SYSCALL(startrecording)
 328:	b8 16 00 00 00       	mov    $0x16,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <stoprecording>:
SYSCALL(stoprecording)
 330:	b8 17 00 00 00       	mov    $0x17,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <fetchrecords>:
 338:	b8 18 00 00 00       	mov    $0x18,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	57                   	push   %edi
 344:	89 cf                	mov    %ecx,%edi
 346:	56                   	push   %esi
 347:	89 c6                	mov    %eax,%esi
 349:	53                   	push   %ebx
 34a:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 34d:	8b 4d 08             	mov    0x8(%ebp),%ecx
 350:	85 c9                	test   %ecx,%ecx
 352:	74 04                	je     358 <printint+0x18>
 354:	85 d2                	test   %edx,%edx
 356:	78 70                	js     3c8 <printint+0x88>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 358:	89 d0                	mov    %edx,%eax
 35a:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 361:	31 c9                	xor    %ecx,%ecx
 363:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 366:	66 90                	xchg   %ax,%ax
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 368:	31 d2                	xor    %edx,%edx
 36a:	f7 f7                	div    %edi
 36c:	0f b6 92 79 07 00 00 	movzbl 0x779(%edx),%edx
 373:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
 376:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
 379:	85 c0                	test   %eax,%eax
 37b:	75 eb                	jne    368 <printint+0x28>
  if(neg)
 37d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 380:	85 c0                	test   %eax,%eax
 382:	74 08                	je     38c <printint+0x4c>
    buf[i++] = '-';
 384:	c6 44 0d d7 2d       	movb   $0x2d,-0x29(%ebp,%ecx,1)
 389:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
 38c:	8d 79 ff             	lea    -0x1(%ecx),%edi
 38f:	01 fb                	add    %edi,%ebx
 391:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 398:	0f b6 03             	movzbl (%ebx),%eax
 39b:	83 ef 01             	sub    $0x1,%edi
 39e:	83 eb 01             	sub    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3a1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3a8:	00 
 3a9:	89 34 24             	mov    %esi,(%esp)
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3ac:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3af:	8d 45 e7             	lea    -0x19(%ebp),%eax
 3b2:	89 44 24 04          	mov    %eax,0x4(%esp)
 3b6:	e8 ed fe ff ff       	call   2a8 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3bb:	83 ff ff             	cmp    $0xffffffff,%edi
 3be:	75 d8                	jne    398 <printint+0x58>
    putc(fd, buf[i]);
}
 3c0:	83 c4 4c             	add    $0x4c,%esp
 3c3:	5b                   	pop    %ebx
 3c4:	5e                   	pop    %esi
 3c5:	5f                   	pop    %edi
 3c6:	5d                   	pop    %ebp
 3c7:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3c8:	89 d0                	mov    %edx,%eax
 3ca:	f7 d8                	neg    %eax
 3cc:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 3d3:	eb 8c                	jmp    361 <printint+0x21>
 3d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003e0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	57                   	push   %edi
 3e4:	56                   	push   %esi
 3e5:	53                   	push   %ebx
 3e6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3e9:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ec:	0f b6 10             	movzbl (%eax),%edx
 3ef:	84 d2                	test   %dl,%dl
 3f1:	0f 84 c9 00 00 00    	je     4c0 <printf+0xe0>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 3f7:	8d 4d 10             	lea    0x10(%ebp),%ecx
 3fa:	31 ff                	xor    %edi,%edi
 3fc:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 3ff:	31 db                	xor    %ebx,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 401:	8d 75 e7             	lea    -0x19(%ebp),%esi
 404:	eb 1e                	jmp    424 <printf+0x44>
 406:	66 90                	xchg   %ax,%ax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 408:	83 fa 25             	cmp    $0x25,%edx
 40b:	0f 85 b7 00 00 00    	jne    4c8 <printf+0xe8>
 411:	66 bf 25 00          	mov    $0x25,%di
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 415:	83 c3 01             	add    $0x1,%ebx
 418:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
 41c:	84 d2                	test   %dl,%dl
 41e:	0f 84 9c 00 00 00    	je     4c0 <printf+0xe0>
    c = fmt[i] & 0xff;
    if(state == 0){
 424:	85 ff                	test   %edi,%edi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 426:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
 429:	74 dd                	je     408 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 42b:	83 ff 25             	cmp    $0x25,%edi
 42e:	75 e5                	jne    415 <printf+0x35>
      if(c == 'd'){
 430:	83 fa 64             	cmp    $0x64,%edx
 433:	0f 84 57 01 00 00    	je     590 <printf+0x1b0>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 439:	83 fa 70             	cmp    $0x70,%edx
 43c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 440:	0f 84 aa 00 00 00    	je     4f0 <printf+0x110>
 446:	83 fa 78             	cmp    $0x78,%edx
 449:	0f 84 a1 00 00 00    	je     4f0 <printf+0x110>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 44f:	83 fa 73             	cmp    $0x73,%edx
 452:	0f 84 c0 00 00 00    	je     518 <printf+0x138>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 458:	83 fa 63             	cmp    $0x63,%edx
 45b:	90                   	nop
 45c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 460:	0f 84 52 01 00 00    	je     5b8 <printf+0x1d8>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 466:	83 fa 25             	cmp    $0x25,%edx
 469:	0f 84 f9 00 00 00    	je     568 <printf+0x188>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 46f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 472:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 475:	31 ff                	xor    %edi,%edi
 477:	89 55 cc             	mov    %edx,-0x34(%ebp)
 47a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 47e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 485:	00 
 486:	89 0c 24             	mov    %ecx,(%esp)
 489:	89 74 24 04          	mov    %esi,0x4(%esp)
 48d:	e8 16 fe ff ff       	call   2a8 <write>
 492:	8b 55 cc             	mov    -0x34(%ebp),%edx
 495:	8b 45 08             	mov    0x8(%ebp),%eax
 498:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 49f:	00 
 4a0:	89 74 24 04          	mov    %esi,0x4(%esp)
 4a4:	88 55 e7             	mov    %dl,-0x19(%ebp)
 4a7:	89 04 24             	mov    %eax,(%esp)
 4aa:	e8 f9 fd ff ff       	call   2a8 <write>
 4af:	8b 45 0c             	mov    0xc(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4b2:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
 4b6:	84 d2                	test   %dl,%dl
 4b8:	0f 85 66 ff ff ff    	jne    424 <printf+0x44>
 4be:	66 90                	xchg   %ax,%ax
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 4c0:	83 c4 3c             	add    $0x3c,%esp
 4c3:	5b                   	pop    %ebx
 4c4:	5e                   	pop    %esi
 4c5:	5f                   	pop    %edi
 4c6:	5d                   	pop    %ebp
 4c7:	c3                   	ret    
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4c8:	8b 45 08             	mov    0x8(%ebp),%eax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 4cb:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4ce:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4d5:	00 
 4d6:	89 74 24 04          	mov    %esi,0x4(%esp)
 4da:	89 04 24             	mov    %eax,(%esp)
 4dd:	e8 c6 fd ff ff       	call   2a8 <write>
 4e2:	8b 45 0c             	mov    0xc(%ebp),%eax
 4e5:	e9 2b ff ff ff       	jmp    415 <printf+0x35>
 4ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 4f0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 4f3:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 4f8:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 4fa:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 501:	8b 10                	mov    (%eax),%edx
 503:	8b 45 08             	mov    0x8(%ebp),%eax
 506:	e8 35 fe ff ff       	call   340 <printint>
 50b:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
 50e:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 512:	e9 fe fe ff ff       	jmp    415 <printf+0x35>
 517:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
 518:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 51b:	8b 3a                	mov    (%edx),%edi
        ap++;
 51d:	83 c2 04             	add    $0x4,%edx
 520:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
 523:	85 ff                	test   %edi,%edi
 525:	0f 84 ba 00 00 00    	je     5e5 <printf+0x205>
          s = "(null)";
        while(*s != 0){
 52b:	0f b6 17             	movzbl (%edi),%edx
 52e:	84 d2                	test   %dl,%dl
 530:	74 2d                	je     55f <printf+0x17f>
 532:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 535:	8b 5d 08             	mov    0x8(%ebp),%ebx
          putc(fd, *s);
          s++;
 538:	83 c7 01             	add    $0x1,%edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 53b:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 53e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 545:	00 
 546:	89 74 24 04          	mov    %esi,0x4(%esp)
 54a:	89 1c 24             	mov    %ebx,(%esp)
 54d:	e8 56 fd ff ff       	call   2a8 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 552:	0f b6 17             	movzbl (%edi),%edx
 555:	84 d2                	test   %dl,%dl
 557:	75 df                	jne    538 <printf+0x158>
 559:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 55c:	8b 45 0c             	mov    0xc(%ebp),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 55f:	31 ff                	xor    %edi,%edi
 561:	e9 af fe ff ff       	jmp    415 <printf+0x35>
 566:	66 90                	xchg   %ax,%ax
 568:	8b 55 08             	mov    0x8(%ebp),%edx
 56b:	31 ff                	xor    %edi,%edi
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 56d:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 571:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 578:	00 
 579:	89 74 24 04          	mov    %esi,0x4(%esp)
 57d:	89 14 24             	mov    %edx,(%esp)
 580:	e8 23 fd ff ff       	call   2a8 <write>
 585:	8b 45 0c             	mov    0xc(%ebp),%eax
 588:	e9 88 fe ff ff       	jmp    415 <printf+0x35>
 58d:	8d 76 00             	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 590:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 593:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 598:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 59b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 5a2:	8b 10                	mov    (%eax),%edx
 5a4:	8b 45 08             	mov    0x8(%ebp),%eax
 5a7:	e8 94 fd ff ff       	call   340 <printint>
 5ac:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
 5af:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 5b3:	e9 5d fe ff ff       	jmp    415 <printf+0x35>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5b8:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
        putc(fd, *ap);
        ap++;
 5bb:	31 ff                	xor    %edi,%edi
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5bd:	8b 01                	mov    (%ecx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5bf:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5c6:	00 
 5c7:	89 74 24 04          	mov    %esi,0x4(%esp)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5cb:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5ce:	8b 45 08             	mov    0x8(%ebp),%eax
 5d1:	89 04 24             	mov    %eax,(%esp)
 5d4:	e8 cf fc ff ff       	call   2a8 <write>
 5d9:	8b 45 0c             	mov    0xc(%ebp),%eax
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 5dc:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 5e0:	e9 30 fe ff ff       	jmp    415 <printf+0x35>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
 5e5:	bf 72 07 00 00       	mov    $0x772,%edi
 5ea:	e9 3c ff ff ff       	jmp    52b <printf+0x14b>
 5ef:	90                   	nop

000005f0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5f0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5f1:	a1 94 07 00 00       	mov    0x794,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 5f6:	89 e5                	mov    %esp,%ebp
 5f8:	57                   	push   %edi
 5f9:	56                   	push   %esi
 5fa:	53                   	push   %ebx
 5fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 5fe:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 601:	39 c8                	cmp    %ecx,%eax
 603:	73 1d                	jae    622 <free+0x32>
 605:	8d 76 00             	lea    0x0(%esi),%esi
 608:	8b 10                	mov    (%eax),%edx
 60a:	39 d1                	cmp    %edx,%ecx
 60c:	72 1a                	jb     628 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 60e:	39 d0                	cmp    %edx,%eax
 610:	72 08                	jb     61a <free+0x2a>
 612:	39 c8                	cmp    %ecx,%eax
 614:	72 12                	jb     628 <free+0x38>
 616:	39 d1                	cmp    %edx,%ecx
 618:	72 0e                	jb     628 <free+0x38>
 61a:	89 d0                	mov    %edx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 61c:	39 c8                	cmp    %ecx,%eax
 61e:	66 90                	xchg   %ax,%ax
 620:	72 e6                	jb     608 <free+0x18>
 622:	8b 10                	mov    (%eax),%edx
 624:	eb e8                	jmp    60e <free+0x1e>
 626:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 628:	8b 71 04             	mov    0x4(%ecx),%esi
 62b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 62e:	39 d7                	cmp    %edx,%edi
 630:	74 19                	je     64b <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 632:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 635:	8b 50 04             	mov    0x4(%eax),%edx
 638:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 63b:	39 ce                	cmp    %ecx,%esi
 63d:	74 23                	je     662 <free+0x72>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 63f:	89 08                	mov    %ecx,(%eax)
  freep = p;
 641:	a3 94 07 00 00       	mov    %eax,0x794
}
 646:	5b                   	pop    %ebx
 647:	5e                   	pop    %esi
 648:	5f                   	pop    %edi
 649:	5d                   	pop    %ebp
 64a:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 64b:	03 72 04             	add    0x4(%edx),%esi
 64e:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
 651:	8b 10                	mov    (%eax),%edx
 653:	8b 12                	mov    (%edx),%edx
 655:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 658:	8b 50 04             	mov    0x4(%eax),%edx
 65b:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 65e:	39 ce                	cmp    %ecx,%esi
 660:	75 dd                	jne    63f <free+0x4f>
    p->s.size += bp->s.size;
 662:	03 51 04             	add    0x4(%ecx),%edx
 665:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 668:	8b 53 f8             	mov    -0x8(%ebx),%edx
 66b:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 66d:	a3 94 07 00 00       	mov    %eax,0x794
}
 672:	5b                   	pop    %ebx
 673:	5e                   	pop    %esi
 674:	5f                   	pop    %edi
 675:	5d                   	pop    %ebp
 676:	c3                   	ret    
 677:	89 f6                	mov    %esi,%esi
 679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000680 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 680:	55                   	push   %ebp
 681:	89 e5                	mov    %esp,%ebp
 683:	57                   	push   %edi
 684:	56                   	push   %esi
 685:	53                   	push   %ebx
 686:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 689:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
 68c:	8b 0d 94 07 00 00    	mov    0x794,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 692:	83 c3 07             	add    $0x7,%ebx
 695:	c1 eb 03             	shr    $0x3,%ebx
 698:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 69b:	85 c9                	test   %ecx,%ecx
 69d:	0f 84 93 00 00 00    	je     736 <malloc+0xb6>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6a3:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 6a5:	8b 50 04             	mov    0x4(%eax),%edx
 6a8:	39 d3                	cmp    %edx,%ebx
 6aa:	76 1f                	jbe    6cb <malloc+0x4b>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 6ac:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 6b3:	90                   	nop
 6b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
    if(p == freep)
 6b8:	3b 05 94 07 00 00    	cmp    0x794,%eax
 6be:	74 30                	je     6f0 <malloc+0x70>
 6c0:	89 c1                	mov    %eax,%ecx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6c2:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 6c4:	8b 50 04             	mov    0x4(%eax),%edx
 6c7:	39 d3                	cmp    %edx,%ebx
 6c9:	77 ed                	ja     6b8 <malloc+0x38>
      if(p->s.size == nunits)
 6cb:	39 d3                	cmp    %edx,%ebx
 6cd:	74 61                	je     730 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 6cf:	29 da                	sub    %ebx,%edx
 6d1:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 6d4:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 6d7:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 6da:	89 0d 94 07 00 00    	mov    %ecx,0x794
      return (void*) (p + 1);
 6e0:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 6e3:	83 c4 1c             	add    $0x1c,%esp
 6e6:	5b                   	pop    %ebx
 6e7:	5e                   	pop    %esi
 6e8:	5f                   	pop    %edi
 6e9:	5d                   	pop    %ebp
 6ea:	c3                   	ret    
 6eb:	90                   	nop
 6ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 6f0:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 6f6:	b8 00 80 00 00       	mov    $0x8000,%eax
 6fb:	bf 00 10 00 00       	mov    $0x1000,%edi
 700:	76 04                	jbe    706 <malloc+0x86>
 702:	89 f0                	mov    %esi,%eax
 704:	89 df                	mov    %ebx,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 706:	89 04 24             	mov    %eax,(%esp)
 709:	e8 02 fc ff ff       	call   310 <sbrk>
  if(p == (char*) -1)
 70e:	83 f8 ff             	cmp    $0xffffffff,%eax
 711:	74 18                	je     72b <malloc+0xab>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 713:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 716:	83 c0 08             	add    $0x8,%eax
 719:	89 04 24             	mov    %eax,(%esp)
 71c:	e8 cf fe ff ff       	call   5f0 <free>
  return freep;
 721:	8b 0d 94 07 00 00    	mov    0x794,%ecx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 727:	85 c9                	test   %ecx,%ecx
 729:	75 97                	jne    6c2 <malloc+0x42>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 72b:	31 c0                	xor    %eax,%eax
 72d:	eb b4                	jmp    6e3 <malloc+0x63>
 72f:	90                   	nop
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 730:	8b 10                	mov    (%eax),%edx
 732:	89 11                	mov    %edx,(%ecx)
 734:	eb a4                	jmp    6da <malloc+0x5a>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 736:	c7 05 94 07 00 00 8c 	movl   $0x78c,0x794
 73d:	07 00 00 
    base.s.size = 0;
 740:	b9 8c 07 00 00       	mov    $0x78c,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 745:	c7 05 8c 07 00 00 8c 	movl   $0x78c,0x78c
 74c:	07 00 00 
    base.s.size = 0;
 74f:	c7 05 90 07 00 00 00 	movl   $0x0,0x790
 756:	00 00 00 
 759:	e9 45 ff ff ff       	jmp    6a3 <malloc+0x23>
