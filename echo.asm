
_echo:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
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

  for(i = 1; i < argc; i++)
  12:	83 fe 01             	cmp    $0x1,%esi
  15:	7e 60                	jle    77 <main+0x77>
  17:	bb 01 00 00 00       	mov    $0x1,%ebx
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  1c:	83 c3 01             	add    $0x1,%ebx
  1f:	39 de                	cmp    %ebx,%esi
  21:	7e 30                	jle    53 <main+0x53>
  23:	90                   	nop
  24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  28:	c7 44 24 0c 7e 07 00 	movl   $0x77e,0xc(%esp)
  2f:	00 
  30:	8b 44 9f fc          	mov    -0x4(%edi,%ebx,4),%eax
  34:	83 c3 01             	add    $0x1,%ebx
  37:	c7 44 24 04 80 07 00 	movl   $0x780,0x4(%esp)
  3e:	00 
  3f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  46:	89 44 24 08          	mov    %eax,0x8(%esp)
  4a:	e8 b1 03 00 00       	call   400 <printf>
  4f:	39 de                	cmp    %ebx,%esi
  51:	7f d5                	jg     28 <main+0x28>
  53:	c7 44 24 0c 85 07 00 	movl   $0x785,0xc(%esp)
  5a:	00 
  5b:	8b 44 b7 fc          	mov    -0x4(%edi,%esi,4),%eax
  5f:	c7 44 24 04 80 07 00 	movl   $0x780,0x4(%esp)
  66:	00 
  67:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  6e:	89 44 24 08          	mov    %eax,0x8(%esp)
  72:	e8 89 03 00 00       	call   400 <printf>
  exit();
  77:	e8 2c 02 00 00       	call   2a8 <exit>
  7c:	90                   	nop
  7d:	90                   	nop
  7e:	90                   	nop
  7f:	90                   	nop

00000080 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  80:	55                   	push   %ebp
  81:	31 d2                	xor    %edx,%edx
  83:	89 e5                	mov    %esp,%ebp
  85:	8b 45 08             	mov    0x8(%ebp),%eax
  88:	53                   	push   %ebx
  89:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  90:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
  94:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  97:	83 c2 01             	add    $0x1,%edx
  9a:	84 c9                	test   %cl,%cl
  9c:	75 f2                	jne    90 <strcpy+0x10>
    ;
  return os;
}
  9e:	5b                   	pop    %ebx
  9f:	5d                   	pop    %ebp
  a0:	c3                   	ret    
  a1:	eb 0d                	jmp    b0 <strcmp>
  a3:	90                   	nop
  a4:	90                   	nop
  a5:	90                   	nop
  a6:	90                   	nop
  a7:	90                   	nop
  a8:	90                   	nop
  a9:	90                   	nop
  aa:	90                   	nop
  ab:	90                   	nop
  ac:	90                   	nop
  ad:	90                   	nop
  ae:	90                   	nop
  af:	90                   	nop

000000b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	53                   	push   %ebx
  b4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  b7:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  ba:	0f b6 01             	movzbl (%ecx),%eax
  bd:	84 c0                	test   %al,%al
  bf:	75 14                	jne    d5 <strcmp+0x25>
  c1:	eb 25                	jmp    e8 <strcmp+0x38>
  c3:	90                   	nop
  c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
  c8:	83 c1 01             	add    $0x1,%ecx
  cb:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  ce:	0f b6 01             	movzbl (%ecx),%eax
  d1:	84 c0                	test   %al,%al
  d3:	74 13                	je     e8 <strcmp+0x38>
  d5:	0f b6 1a             	movzbl (%edx),%ebx
  d8:	38 d8                	cmp    %bl,%al
  da:	74 ec                	je     c8 <strcmp+0x18>
  dc:	0f b6 db             	movzbl %bl,%ebx
  df:	0f b6 c0             	movzbl %al,%eax
  e2:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
  e4:	5b                   	pop    %ebx
  e5:	5d                   	pop    %ebp
  e6:	c3                   	ret    
  e7:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  e8:	0f b6 1a             	movzbl (%edx),%ebx
  eb:	31 c0                	xor    %eax,%eax
  ed:	0f b6 db             	movzbl %bl,%ebx
  f0:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
  f2:	5b                   	pop    %ebx
  f3:	5d                   	pop    %ebp
  f4:	c3                   	ret    
  f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000100 <strlen>:

uint
strlen(char *s)
{
 100:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 101:	31 d2                	xor    %edx,%edx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 103:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
 105:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 107:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 10a:	80 39 00             	cmpb   $0x0,(%ecx)
 10d:	74 0c                	je     11b <strlen+0x1b>
 10f:	90                   	nop
 110:	83 c2 01             	add    $0x1,%edx
 113:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 117:	89 d0                	mov    %edx,%eax
 119:	75 f5                	jne    110 <strlen+0x10>
    ;
  return n;
}
 11b:	5d                   	pop    %ebp
 11c:	c3                   	ret    
 11d:	8d 76 00             	lea    0x0(%esi),%esi

00000120 <memset>:

void*
memset(void *dst, int c, uint n)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	8b 55 08             	mov    0x8(%ebp),%edx
 126:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 127:	8b 4d 10             	mov    0x10(%ebp),%ecx
 12a:	8b 45 0c             	mov    0xc(%ebp),%eax
 12d:	89 d7                	mov    %edx,%edi
 12f:	fc                   	cld    
 130:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 132:	89 d0                	mov    %edx,%eax
 134:	5f                   	pop    %edi
 135:	5d                   	pop    %ebp
 136:	c3                   	ret    
 137:	89 f6                	mov    %esi,%esi
 139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000140 <strchr>:

char*
strchr(const char *s, char c)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	8b 45 08             	mov    0x8(%ebp),%eax
 146:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 14a:	0f b6 10             	movzbl (%eax),%edx
 14d:	84 d2                	test   %dl,%dl
 14f:	75 11                	jne    162 <strchr+0x22>
 151:	eb 15                	jmp    168 <strchr+0x28>
 153:	90                   	nop
 154:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 158:	83 c0 01             	add    $0x1,%eax
 15b:	0f b6 10             	movzbl (%eax),%edx
 15e:	84 d2                	test   %dl,%dl
 160:	74 06                	je     168 <strchr+0x28>
    if(*s == c)
 162:	38 ca                	cmp    %cl,%dl
 164:	75 f2                	jne    158 <strchr+0x18>
      return (char*) s;
  return 0;
}
 166:	5d                   	pop    %ebp
 167:	c3                   	ret    
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 168:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 16a:	5d                   	pop    %ebp
 16b:	90                   	nop
 16c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 170:	c3                   	ret    
 171:	eb 0d                	jmp    180 <atoi>
 173:	90                   	nop
 174:	90                   	nop
 175:	90                   	nop
 176:	90                   	nop
 177:	90                   	nop
 178:	90                   	nop
 179:	90                   	nop
 17a:	90                   	nop
 17b:	90                   	nop
 17c:	90                   	nop
 17d:	90                   	nop
 17e:	90                   	nop
 17f:	90                   	nop

00000180 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 180:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 181:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
 183:	89 e5                	mov    %esp,%ebp
 185:	8b 4d 08             	mov    0x8(%ebp),%ecx
 188:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 189:	0f b6 11             	movzbl (%ecx),%edx
 18c:	8d 5a d0             	lea    -0x30(%edx),%ebx
 18f:	80 fb 09             	cmp    $0x9,%bl
 192:	77 1c                	ja     1b0 <atoi+0x30>
 194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 198:	0f be d2             	movsbl %dl,%edx
 19b:	83 c1 01             	add    $0x1,%ecx
 19e:	8d 04 80             	lea    (%eax,%eax,4),%eax
 1a1:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1a5:	0f b6 11             	movzbl (%ecx),%edx
 1a8:	8d 5a d0             	lea    -0x30(%edx),%ebx
 1ab:	80 fb 09             	cmp    $0x9,%bl
 1ae:	76 e8                	jbe    198 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 1b0:	5b                   	pop    %ebx
 1b1:	5d                   	pop    %ebp
 1b2:	c3                   	ret    
 1b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001c0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	56                   	push   %esi
 1c4:	8b 45 08             	mov    0x8(%ebp),%eax
 1c7:	53                   	push   %ebx
 1c8:	8b 5d 10             	mov    0x10(%ebp),%ebx
 1cb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1ce:	85 db                	test   %ebx,%ebx
 1d0:	7e 14                	jle    1e6 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
 1d2:	31 d2                	xor    %edx,%edx
 1d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
 1d8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 1dc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 1df:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1e2:	39 da                	cmp    %ebx,%edx
 1e4:	75 f2                	jne    1d8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 1e6:	5b                   	pop    %ebx
 1e7:	5e                   	pop    %esi
 1e8:	5d                   	pop    %ebp
 1e9:	c3                   	ret    
 1ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001f0 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 1f9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 1fc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 1ff:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 204:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 20b:	00 
 20c:	89 04 24             	mov    %eax,(%esp)
 20f:	e8 d4 00 00 00       	call   2e8 <open>
  if(fd < 0)
 214:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 216:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 218:	78 19                	js     233 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 21a:	8b 45 0c             	mov    0xc(%ebp),%eax
 21d:	89 1c 24             	mov    %ebx,(%esp)
 220:	89 44 24 04          	mov    %eax,0x4(%esp)
 224:	e8 d7 00 00 00       	call   300 <fstat>
  close(fd);
 229:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 22c:	89 c6                	mov    %eax,%esi
  close(fd);
 22e:	e8 9d 00 00 00       	call   2d0 <close>
  return r;
}
 233:	89 f0                	mov    %esi,%eax
 235:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 238:	8b 75 fc             	mov    -0x4(%ebp),%esi
 23b:	89 ec                	mov    %ebp,%esp
 23d:	5d                   	pop    %ebp
 23e:	c3                   	ret    
 23f:	90                   	nop

00000240 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	57                   	push   %edi
 244:	56                   	push   %esi
 245:	31 f6                	xor    %esi,%esi
 247:	53                   	push   %ebx
 248:	83 ec 2c             	sub    $0x2c,%esp
 24b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 24e:	eb 06                	jmp    256 <gets+0x16>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 250:	3c 0a                	cmp    $0xa,%al
 252:	74 39                	je     28d <gets+0x4d>
 254:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 256:	8d 5e 01             	lea    0x1(%esi),%ebx
 259:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 25c:	7d 31                	jge    28f <gets+0x4f>
    cc = read(0, &c, 1);
 25e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 261:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 268:	00 
 269:	89 44 24 04          	mov    %eax,0x4(%esp)
 26d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 274:	e8 47 00 00 00       	call   2c0 <read>
    if(cc < 1)
 279:	85 c0                	test   %eax,%eax
 27b:	7e 12                	jle    28f <gets+0x4f>
      break;
    buf[i++] = c;
 27d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 281:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 285:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 289:	3c 0d                	cmp    $0xd,%al
 28b:	75 c3                	jne    250 <gets+0x10>
 28d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 28f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 293:	89 f8                	mov    %edi,%eax
 295:	83 c4 2c             	add    $0x2c,%esp
 298:	5b                   	pop    %ebx
 299:	5e                   	pop    %esi
 29a:	5f                   	pop    %edi
 29b:	5d                   	pop    %ebp
 29c:	c3                   	ret    
 29d:	90                   	nop
 29e:	90                   	nop
 29f:	90                   	nop

000002a0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2a0:	b8 01 00 00 00       	mov    $0x1,%eax
 2a5:	cd 40                	int    $0x40
 2a7:	c3                   	ret    

000002a8 <exit>:
SYSCALL(exit)
 2a8:	b8 02 00 00 00       	mov    $0x2,%eax
 2ad:	cd 40                	int    $0x40
 2af:	c3                   	ret    

000002b0 <wait>:
SYSCALL(wait)
 2b0:	b8 03 00 00 00       	mov    $0x3,%eax
 2b5:	cd 40                	int    $0x40
 2b7:	c3                   	ret    

000002b8 <pipe>:
SYSCALL(pipe)
 2b8:	b8 04 00 00 00       	mov    $0x4,%eax
 2bd:	cd 40                	int    $0x40
 2bf:	c3                   	ret    

000002c0 <read>:
SYSCALL(read)
 2c0:	b8 06 00 00 00       	mov    $0x6,%eax
 2c5:	cd 40                	int    $0x40
 2c7:	c3                   	ret    

000002c8 <write>:
SYSCALL(write)
 2c8:	b8 05 00 00 00       	mov    $0x5,%eax
 2cd:	cd 40                	int    $0x40
 2cf:	c3                   	ret    

000002d0 <close>:
SYSCALL(close)
 2d0:	b8 07 00 00 00       	mov    $0x7,%eax
 2d5:	cd 40                	int    $0x40
 2d7:	c3                   	ret    

000002d8 <kill>:
SYSCALL(kill)
 2d8:	b8 08 00 00 00       	mov    $0x8,%eax
 2dd:	cd 40                	int    $0x40
 2df:	c3                   	ret    

000002e0 <exec>:
SYSCALL(exec)
 2e0:	b8 09 00 00 00       	mov    $0x9,%eax
 2e5:	cd 40                	int    $0x40
 2e7:	c3                   	ret    

000002e8 <open>:
SYSCALL(open)
 2e8:	b8 0a 00 00 00       	mov    $0xa,%eax
 2ed:	cd 40                	int    $0x40
 2ef:	c3                   	ret    

000002f0 <mknod>:
SYSCALL(mknod)
 2f0:	b8 0b 00 00 00       	mov    $0xb,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <unlink>:
SYSCALL(unlink)
 2f8:	b8 0c 00 00 00       	mov    $0xc,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <fstat>:
SYSCALL(fstat)
 300:	b8 0d 00 00 00       	mov    $0xd,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <link>:
SYSCALL(link)
 308:	b8 0e 00 00 00       	mov    $0xe,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <mkdir>:
SYSCALL(mkdir)
 310:	b8 0f 00 00 00       	mov    $0xf,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <chdir>:
SYSCALL(chdir)
 318:	b8 10 00 00 00       	mov    $0x10,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <dup>:
SYSCALL(dup)
 320:	b8 11 00 00 00       	mov    $0x11,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <getpid>:
SYSCALL(getpid)
 328:	b8 12 00 00 00       	mov    $0x12,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <sbrk>:
SYSCALL(sbrk)
 330:	b8 13 00 00 00       	mov    $0x13,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <sleep>:
SYSCALL(sleep)
 338:	b8 14 00 00 00       	mov    $0x14,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <uptime>:
SYSCALL(uptime)
 340:	b8 15 00 00 00       	mov    $0x15,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <startrecording>:
SYSCALL(startrecording)
 348:	b8 16 00 00 00       	mov    $0x16,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <stoprecording>:
SYSCALL(stoprecording)
 350:	b8 17 00 00 00       	mov    $0x17,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <fetchrecords>:
 358:	b8 18 00 00 00       	mov    $0x18,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	57                   	push   %edi
 364:	89 cf                	mov    %ecx,%edi
 366:	56                   	push   %esi
 367:	89 c6                	mov    %eax,%esi
 369:	53                   	push   %ebx
 36a:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 36d:	8b 4d 08             	mov    0x8(%ebp),%ecx
 370:	85 c9                	test   %ecx,%ecx
 372:	74 04                	je     378 <printint+0x18>
 374:	85 d2                	test   %edx,%edx
 376:	78 70                	js     3e8 <printint+0x88>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 378:	89 d0                	mov    %edx,%eax
 37a:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 381:	31 c9                	xor    %ecx,%ecx
 383:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 386:	66 90                	xchg   %ax,%ax
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 388:	31 d2                	xor    %edx,%edx
 38a:	f7 f7                	div    %edi
 38c:	0f b6 92 8e 07 00 00 	movzbl 0x78e(%edx),%edx
 393:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
 396:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
 399:	85 c0                	test   %eax,%eax
 39b:	75 eb                	jne    388 <printint+0x28>
  if(neg)
 39d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 3a0:	85 c0                	test   %eax,%eax
 3a2:	74 08                	je     3ac <printint+0x4c>
    buf[i++] = '-';
 3a4:	c6 44 0d d7 2d       	movb   $0x2d,-0x29(%ebp,%ecx,1)
 3a9:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
 3ac:	8d 79 ff             	lea    -0x1(%ecx),%edi
 3af:	01 fb                	add    %edi,%ebx
 3b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3b8:	0f b6 03             	movzbl (%ebx),%eax
 3bb:	83 ef 01             	sub    $0x1,%edi
 3be:	83 eb 01             	sub    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3c1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3c8:	00 
 3c9:	89 34 24             	mov    %esi,(%esp)
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3cc:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3cf:	8d 45 e7             	lea    -0x19(%ebp),%eax
 3d2:	89 44 24 04          	mov    %eax,0x4(%esp)
 3d6:	e8 ed fe ff ff       	call   2c8 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3db:	83 ff ff             	cmp    $0xffffffff,%edi
 3de:	75 d8                	jne    3b8 <printint+0x58>
    putc(fd, buf[i]);
}
 3e0:	83 c4 4c             	add    $0x4c,%esp
 3e3:	5b                   	pop    %ebx
 3e4:	5e                   	pop    %esi
 3e5:	5f                   	pop    %edi
 3e6:	5d                   	pop    %ebp
 3e7:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3e8:	89 d0                	mov    %edx,%eax
 3ea:	f7 d8                	neg    %eax
 3ec:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 3f3:	eb 8c                	jmp    381 <printint+0x21>
 3f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000400 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	57                   	push   %edi
 404:	56                   	push   %esi
 405:	53                   	push   %ebx
 406:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 409:	8b 45 0c             	mov    0xc(%ebp),%eax
 40c:	0f b6 10             	movzbl (%eax),%edx
 40f:	84 d2                	test   %dl,%dl
 411:	0f 84 c9 00 00 00    	je     4e0 <printf+0xe0>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 417:	8d 4d 10             	lea    0x10(%ebp),%ecx
 41a:	31 ff                	xor    %edi,%edi
 41c:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 41f:	31 db                	xor    %ebx,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 421:	8d 75 e7             	lea    -0x19(%ebp),%esi
 424:	eb 1e                	jmp    444 <printf+0x44>
 426:	66 90                	xchg   %ax,%ax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 428:	83 fa 25             	cmp    $0x25,%edx
 42b:	0f 85 b7 00 00 00    	jne    4e8 <printf+0xe8>
 431:	66 bf 25 00          	mov    $0x25,%di
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 435:	83 c3 01             	add    $0x1,%ebx
 438:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
 43c:	84 d2                	test   %dl,%dl
 43e:	0f 84 9c 00 00 00    	je     4e0 <printf+0xe0>
    c = fmt[i] & 0xff;
    if(state == 0){
 444:	85 ff                	test   %edi,%edi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 446:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
 449:	74 dd                	je     428 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 44b:	83 ff 25             	cmp    $0x25,%edi
 44e:	75 e5                	jne    435 <printf+0x35>
      if(c == 'd'){
 450:	83 fa 64             	cmp    $0x64,%edx
 453:	0f 84 57 01 00 00    	je     5b0 <printf+0x1b0>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 459:	83 fa 70             	cmp    $0x70,%edx
 45c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 460:	0f 84 aa 00 00 00    	je     510 <printf+0x110>
 466:	83 fa 78             	cmp    $0x78,%edx
 469:	0f 84 a1 00 00 00    	je     510 <printf+0x110>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 46f:	83 fa 73             	cmp    $0x73,%edx
 472:	0f 84 c0 00 00 00    	je     538 <printf+0x138>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 478:	83 fa 63             	cmp    $0x63,%edx
 47b:	90                   	nop
 47c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 480:	0f 84 52 01 00 00    	je     5d8 <printf+0x1d8>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 486:	83 fa 25             	cmp    $0x25,%edx
 489:	0f 84 f9 00 00 00    	je     588 <printf+0x188>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 48f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 492:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 495:	31 ff                	xor    %edi,%edi
 497:	89 55 cc             	mov    %edx,-0x34(%ebp)
 49a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 49e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4a5:	00 
 4a6:	89 0c 24             	mov    %ecx,(%esp)
 4a9:	89 74 24 04          	mov    %esi,0x4(%esp)
 4ad:	e8 16 fe ff ff       	call   2c8 <write>
 4b2:	8b 55 cc             	mov    -0x34(%ebp),%edx
 4b5:	8b 45 08             	mov    0x8(%ebp),%eax
 4b8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4bf:	00 
 4c0:	89 74 24 04          	mov    %esi,0x4(%esp)
 4c4:	88 55 e7             	mov    %dl,-0x19(%ebp)
 4c7:	89 04 24             	mov    %eax,(%esp)
 4ca:	e8 f9 fd ff ff       	call   2c8 <write>
 4cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4d2:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
 4d6:	84 d2                	test   %dl,%dl
 4d8:	0f 85 66 ff ff ff    	jne    444 <printf+0x44>
 4de:	66 90                	xchg   %ax,%ax
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 4e0:	83 c4 3c             	add    $0x3c,%esp
 4e3:	5b                   	pop    %ebx
 4e4:	5e                   	pop    %esi
 4e5:	5f                   	pop    %edi
 4e6:	5d                   	pop    %ebp
 4e7:	c3                   	ret    
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4e8:	8b 45 08             	mov    0x8(%ebp),%eax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 4eb:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4ee:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4f5:	00 
 4f6:	89 74 24 04          	mov    %esi,0x4(%esp)
 4fa:	89 04 24             	mov    %eax,(%esp)
 4fd:	e8 c6 fd ff ff       	call   2c8 <write>
 502:	8b 45 0c             	mov    0xc(%ebp),%eax
 505:	e9 2b ff ff ff       	jmp    435 <printf+0x35>
 50a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 510:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 513:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 518:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 51a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 521:	8b 10                	mov    (%eax),%edx
 523:	8b 45 08             	mov    0x8(%ebp),%eax
 526:	e8 35 fe ff ff       	call   360 <printint>
 52b:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
 52e:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 532:	e9 fe fe ff ff       	jmp    435 <printf+0x35>
 537:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
 538:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 53b:	8b 3a                	mov    (%edx),%edi
        ap++;
 53d:	83 c2 04             	add    $0x4,%edx
 540:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
 543:	85 ff                	test   %edi,%edi
 545:	0f 84 ba 00 00 00    	je     605 <printf+0x205>
          s = "(null)";
        while(*s != 0){
 54b:	0f b6 17             	movzbl (%edi),%edx
 54e:	84 d2                	test   %dl,%dl
 550:	74 2d                	je     57f <printf+0x17f>
 552:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 555:	8b 5d 08             	mov    0x8(%ebp),%ebx
          putc(fd, *s);
          s++;
 558:	83 c7 01             	add    $0x1,%edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 55b:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 55e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 565:	00 
 566:	89 74 24 04          	mov    %esi,0x4(%esp)
 56a:	89 1c 24             	mov    %ebx,(%esp)
 56d:	e8 56 fd ff ff       	call   2c8 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 572:	0f b6 17             	movzbl (%edi),%edx
 575:	84 d2                	test   %dl,%dl
 577:	75 df                	jne    558 <printf+0x158>
 579:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 57c:	8b 45 0c             	mov    0xc(%ebp),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 57f:	31 ff                	xor    %edi,%edi
 581:	e9 af fe ff ff       	jmp    435 <printf+0x35>
 586:	66 90                	xchg   %ax,%ax
 588:	8b 55 08             	mov    0x8(%ebp),%edx
 58b:	31 ff                	xor    %edi,%edi
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 58d:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 591:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 598:	00 
 599:	89 74 24 04          	mov    %esi,0x4(%esp)
 59d:	89 14 24             	mov    %edx,(%esp)
 5a0:	e8 23 fd ff ff       	call   2c8 <write>
 5a5:	8b 45 0c             	mov    0xc(%ebp),%eax
 5a8:	e9 88 fe ff ff       	jmp    435 <printf+0x35>
 5ad:	8d 76 00             	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 5b0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 5b3:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 5b8:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 5bb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 5c2:	8b 10                	mov    (%eax),%edx
 5c4:	8b 45 08             	mov    0x8(%ebp),%eax
 5c7:	e8 94 fd ff ff       	call   360 <printint>
 5cc:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
 5cf:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 5d3:	e9 5d fe ff ff       	jmp    435 <printf+0x35>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5d8:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
        putc(fd, *ap);
        ap++;
 5db:	31 ff                	xor    %edi,%edi
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5dd:	8b 01                	mov    (%ecx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5df:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5e6:	00 
 5e7:	89 74 24 04          	mov    %esi,0x4(%esp)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5eb:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5ee:	8b 45 08             	mov    0x8(%ebp),%eax
 5f1:	89 04 24             	mov    %eax,(%esp)
 5f4:	e8 cf fc ff ff       	call   2c8 <write>
 5f9:	8b 45 0c             	mov    0xc(%ebp),%eax
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 5fc:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 600:	e9 30 fe ff ff       	jmp    435 <printf+0x35>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
 605:	bf 87 07 00 00       	mov    $0x787,%edi
 60a:	e9 3c ff ff ff       	jmp    54b <printf+0x14b>
 60f:	90                   	nop

00000610 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 610:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 611:	a1 a8 07 00 00       	mov    0x7a8,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 616:	89 e5                	mov    %esp,%ebp
 618:	57                   	push   %edi
 619:	56                   	push   %esi
 61a:	53                   	push   %ebx
 61b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 61e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 621:	39 c8                	cmp    %ecx,%eax
 623:	73 1d                	jae    642 <free+0x32>
 625:	8d 76 00             	lea    0x0(%esi),%esi
 628:	8b 10                	mov    (%eax),%edx
 62a:	39 d1                	cmp    %edx,%ecx
 62c:	72 1a                	jb     648 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 62e:	39 d0                	cmp    %edx,%eax
 630:	72 08                	jb     63a <free+0x2a>
 632:	39 c8                	cmp    %ecx,%eax
 634:	72 12                	jb     648 <free+0x38>
 636:	39 d1                	cmp    %edx,%ecx
 638:	72 0e                	jb     648 <free+0x38>
 63a:	89 d0                	mov    %edx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 63c:	39 c8                	cmp    %ecx,%eax
 63e:	66 90                	xchg   %ax,%ax
 640:	72 e6                	jb     628 <free+0x18>
 642:	8b 10                	mov    (%eax),%edx
 644:	eb e8                	jmp    62e <free+0x1e>
 646:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 648:	8b 71 04             	mov    0x4(%ecx),%esi
 64b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 64e:	39 d7                	cmp    %edx,%edi
 650:	74 19                	je     66b <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 652:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 655:	8b 50 04             	mov    0x4(%eax),%edx
 658:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 65b:	39 ce                	cmp    %ecx,%esi
 65d:	74 23                	je     682 <free+0x72>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 65f:	89 08                	mov    %ecx,(%eax)
  freep = p;
 661:	a3 a8 07 00 00       	mov    %eax,0x7a8
}
 666:	5b                   	pop    %ebx
 667:	5e                   	pop    %esi
 668:	5f                   	pop    %edi
 669:	5d                   	pop    %ebp
 66a:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 66b:	03 72 04             	add    0x4(%edx),%esi
 66e:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
 671:	8b 10                	mov    (%eax),%edx
 673:	8b 12                	mov    (%edx),%edx
 675:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 678:	8b 50 04             	mov    0x4(%eax),%edx
 67b:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 67e:	39 ce                	cmp    %ecx,%esi
 680:	75 dd                	jne    65f <free+0x4f>
    p->s.size += bp->s.size;
 682:	03 51 04             	add    0x4(%ecx),%edx
 685:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 688:	8b 53 f8             	mov    -0x8(%ebx),%edx
 68b:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 68d:	a3 a8 07 00 00       	mov    %eax,0x7a8
}
 692:	5b                   	pop    %ebx
 693:	5e                   	pop    %esi
 694:	5f                   	pop    %edi
 695:	5d                   	pop    %ebp
 696:	c3                   	ret    
 697:	89 f6                	mov    %esi,%esi
 699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6a0:	55                   	push   %ebp
 6a1:	89 e5                	mov    %esp,%ebp
 6a3:	57                   	push   %edi
 6a4:	56                   	push   %esi
 6a5:	53                   	push   %ebx
 6a6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
 6ac:	8b 0d a8 07 00 00    	mov    0x7a8,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6b2:	83 c3 07             	add    $0x7,%ebx
 6b5:	c1 eb 03             	shr    $0x3,%ebx
 6b8:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 6bb:	85 c9                	test   %ecx,%ecx
 6bd:	0f 84 93 00 00 00    	je     756 <malloc+0xb6>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6c3:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 6c5:	8b 50 04             	mov    0x4(%eax),%edx
 6c8:	39 d3                	cmp    %edx,%ebx
 6ca:	76 1f                	jbe    6eb <malloc+0x4b>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 6cc:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 6d3:	90                   	nop
 6d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
    if(p == freep)
 6d8:	3b 05 a8 07 00 00    	cmp    0x7a8,%eax
 6de:	74 30                	je     710 <malloc+0x70>
 6e0:	89 c1                	mov    %eax,%ecx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6e2:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 6e4:	8b 50 04             	mov    0x4(%eax),%edx
 6e7:	39 d3                	cmp    %edx,%ebx
 6e9:	77 ed                	ja     6d8 <malloc+0x38>
      if(p->s.size == nunits)
 6eb:	39 d3                	cmp    %edx,%ebx
 6ed:	74 61                	je     750 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 6ef:	29 da                	sub    %ebx,%edx
 6f1:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 6f4:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 6f7:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 6fa:	89 0d a8 07 00 00    	mov    %ecx,0x7a8
      return (void*) (p + 1);
 700:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 703:	83 c4 1c             	add    $0x1c,%esp
 706:	5b                   	pop    %ebx
 707:	5e                   	pop    %esi
 708:	5f                   	pop    %edi
 709:	5d                   	pop    %ebp
 70a:	c3                   	ret    
 70b:	90                   	nop
 70c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 710:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 716:	b8 00 80 00 00       	mov    $0x8000,%eax
 71b:	bf 00 10 00 00       	mov    $0x1000,%edi
 720:	76 04                	jbe    726 <malloc+0x86>
 722:	89 f0                	mov    %esi,%eax
 724:	89 df                	mov    %ebx,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 726:	89 04 24             	mov    %eax,(%esp)
 729:	e8 02 fc ff ff       	call   330 <sbrk>
  if(p == (char*) -1)
 72e:	83 f8 ff             	cmp    $0xffffffff,%eax
 731:	74 18                	je     74b <malloc+0xab>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 733:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 736:	83 c0 08             	add    $0x8,%eax
 739:	89 04 24             	mov    %eax,(%esp)
 73c:	e8 cf fe ff ff       	call   610 <free>
  return freep;
 741:	8b 0d a8 07 00 00    	mov    0x7a8,%ecx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 747:	85 c9                	test   %ecx,%ecx
 749:	75 97                	jne    6e2 <malloc+0x42>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 74b:	31 c0                	xor    %eax,%eax
 74d:	eb b4                	jmp    703 <malloc+0x63>
 74f:	90                   	nop
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 750:	8b 10                	mov    (%eax),%edx
 752:	89 11                	mov    %edx,(%ecx)
 754:	eb a4                	jmp    6fa <malloc+0x5a>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 756:	c7 05 a8 07 00 00 a0 	movl   $0x7a0,0x7a8
 75d:	07 00 00 
    base.s.size = 0;
 760:	b9 a0 07 00 00       	mov    $0x7a0,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 765:	c7 05 a0 07 00 00 a0 	movl   $0x7a0,0x7a0
 76c:	07 00 00 
    base.s.size = 0;
 76f:	c7 05 a4 07 00 00 00 	movl   $0x0,0x7a4
 776:	00 00 00 
 779:	e9 45 ff ff ff       	jmp    6c3 <malloc+0x23>
