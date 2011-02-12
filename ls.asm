
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	56                   	push   %esi
   4:	53                   	push   %ebx
   5:	83 ec 10             	sub    $0x10,%esp
   8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  static char buf[DIRSIZ+1];
  char *p;
  
  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
   b:	89 1c 24             	mov    %ebx,(%esp)
   e:	e8 cd 03 00 00       	call   3e0 <strlen>
  13:	01 d8                	add    %ebx,%eax
  15:	73 10                	jae    27 <fmtname+0x27>
  17:	eb 13                	jmp    2c <fmtname+0x2c>
  19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  20:	83 e8 01             	sub    $0x1,%eax
  23:	39 c3                	cmp    %eax,%ebx
  25:	77 05                	ja     2c <fmtname+0x2c>
  27:	80 38 2f             	cmpb   $0x2f,(%eax)
  2a:	75 f4                	jne    20 <fmtname+0x20>
    ;
  p++;
  2c:	8d 58 01             	lea    0x1(%eax),%ebx
  
  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  2f:	89 1c 24             	mov    %ebx,(%esp)
  32:	e8 a9 03 00 00       	call   3e0 <strlen>
  37:	83 f8 0d             	cmp    $0xd,%eax
  3a:	77 53                	ja     8f <fmtname+0x8f>
    return p;
  memmove(buf, p, strlen(p));
  3c:	89 1c 24             	mov    %ebx,(%esp)
  3f:	e8 9c 03 00 00       	call   3e0 <strlen>
  44:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  48:	c7 04 24 c0 0a 00 00 	movl   $0xac0,(%esp)
  4f:	89 44 24 08          	mov    %eax,0x8(%esp)
  53:	e8 48 04 00 00       	call   4a0 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  58:	89 1c 24             	mov    %ebx,(%esp)
  5b:	e8 80 03 00 00       	call   3e0 <strlen>
  60:	89 1c 24             	mov    %ebx,(%esp)
  63:	bb c0 0a 00 00       	mov    $0xac0,%ebx
  68:	89 c6                	mov    %eax,%esi
  6a:	e8 71 03 00 00       	call   3e0 <strlen>
  6f:	ba 0e 00 00 00       	mov    $0xe,%edx
  74:	29 f2                	sub    %esi,%edx
  76:	89 54 24 08          	mov    %edx,0x8(%esp)
  7a:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
  81:	00 
  82:	05 c0 0a 00 00       	add    $0xac0,%eax
  87:	89 04 24             	mov    %eax,(%esp)
  8a:	e8 71 03 00 00       	call   400 <memset>
  return buf;
}
  8f:	83 c4 10             	add    $0x10,%esp
  92:	89 d8                	mov    %ebx,%eax
  94:	5b                   	pop    %ebx
  95:	5e                   	pop    %esi
  96:	5d                   	pop    %ebp
  97:	c3                   	ret    
  98:	90                   	nop
  99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000000a0 <ls>:

void
ls(char *path)
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	57                   	push   %edi
  a4:	56                   	push   %esi
  a5:	53                   	push   %ebx
  a6:	81 ec 6c 02 00 00    	sub    $0x26c,%esp
  ac:	8b 7d 08             	mov    0x8(%ebp),%edi
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  
  if((fd = open(path, 0)) < 0){
  af:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  b6:	00 
  b7:	89 3c 24             	mov    %edi,(%esp)
  ba:	e8 09 05 00 00       	call   5c8 <open>
  bf:	85 c0                	test   %eax,%eax
  c1:	89 c3                	mov    %eax,%ebx
  c3:	0f 88 c7 01 00 00    	js     290 <ls+0x1f0>
    printf(2, "ls: cannot open %s\n", path);
    return;
  }
  
  if(fstat(fd, &st) < 0){
  c9:	8d 75 c4             	lea    -0x3c(%ebp),%esi
  cc:	89 74 24 04          	mov    %esi,0x4(%esp)
  d0:	89 04 24             	mov    %eax,(%esp)
  d3:	e8 08 05 00 00       	call   5e0 <fstat>
  d8:	85 c0                	test   %eax,%eax
  da:	0f 88 00 02 00 00    	js     2e0 <ls+0x240>
    printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }
  
  switch(st.type){
  e0:	0f b7 45 c4          	movzwl -0x3c(%ebp),%eax
  e4:	66 83 f8 01          	cmp    $0x1,%ax
  e8:	74 66                	je     150 <ls+0xb0>
  ea:	66 83 f8 02          	cmp    $0x2,%ax
  ee:	66 90                	xchg   %ax,%ax
  f0:	74 16                	je     108 <ls+0x68>
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
  f2:	89 1c 24             	mov    %ebx,(%esp)
  f5:	e8 b6 04 00 00       	call   5b0 <close>
}
  fa:	81 c4 6c 02 00 00    	add    $0x26c,%esp
 100:	5b                   	pop    %ebx
 101:	5e                   	pop    %esi
 102:	5f                   	pop    %edi
 103:	5d                   	pop    %ebp
 104:	c3                   	ret    
 105:	8d 76 00             	lea    0x0(%esi),%esi
    return;
  }
  
  switch(st.type){
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 108:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 10b:	8b 75 cc             	mov    -0x34(%ebp),%esi
 10e:	89 3c 24             	mov    %edi,(%esp)
 111:	89 95 ac fd ff ff    	mov    %edx,-0x254(%ebp)
 117:	e8 e4 fe ff ff       	call   0 <fmtname>
 11c:	8b 95 ac fd ff ff    	mov    -0x254(%ebp),%edx
 122:	89 74 24 10          	mov    %esi,0x10(%esp)
 126:	c7 44 24 0c 02 00 00 	movl   $0x2,0xc(%esp)
 12d:	00 
 12e:	c7 44 24 04 86 0a 00 	movl   $0xa86,0x4(%esp)
 135:	00 
 136:	89 54 24 14          	mov    %edx,0x14(%esp)
 13a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 141:	89 44 24 08          	mov    %eax,0x8(%esp)
 145:	e8 96 05 00 00       	call   6e0 <printf>
    break;
 14a:	eb a6                	jmp    f2 <ls+0x52>
 14c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  
  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 150:	89 3c 24             	mov    %edi,(%esp)
 153:	e8 88 02 00 00       	call   3e0 <strlen>
 158:	83 c0 10             	add    $0x10,%eax
 15b:	3d 00 02 00 00       	cmp    $0x200,%eax
 160:	0f 87 0a 01 00 00    	ja     270 <ls+0x1d0>
      printf(1, "ls: path too long\n");
      break;
    }
    strcpy(buf, path);
 166:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
 16c:	89 7c 24 04          	mov    %edi,0x4(%esp)
 170:	8d 7d d8             	lea    -0x28(%ebp),%edi
 173:	89 04 24             	mov    %eax,(%esp)
 176:	e8 e5 01 00 00       	call   360 <strcpy>
    p = buf+strlen(buf);
 17b:	8d 95 c4 fd ff ff    	lea    -0x23c(%ebp),%edx
 181:	89 14 24             	mov    %edx,(%esp)
 184:	e8 57 02 00 00       	call   3e0 <strlen>
 189:	8d 95 c4 fd ff ff    	lea    -0x23c(%ebp),%edx
 18f:	8d 04 02             	lea    (%edx,%eax,1),%eax
    *p++ = '/';
 192:	c6 00 2f             	movb   $0x2f,(%eax)
 195:	83 c0 01             	add    $0x1,%eax
 198:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
 19e:	66 90                	xchg   %ax,%ax
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1a0:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 1a7:	00 
 1a8:	89 7c 24 04          	mov    %edi,0x4(%esp)
 1ac:	89 1c 24             	mov    %ebx,(%esp)
 1af:	e8 ec 03 00 00       	call   5a0 <read>
 1b4:	83 f8 10             	cmp    $0x10,%eax
 1b7:	0f 85 35 ff ff ff    	jne    f2 <ls+0x52>
      if(de.inum == 0)
 1bd:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
 1c2:	74 dc                	je     1a0 <ls+0x100>
        continue;
      memmove(p, de.name, DIRSIZ);
 1c4:	8d 45 da             	lea    -0x26(%ebp),%eax
 1c7:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
 1ce:	00 
 1cf:	89 44 24 04          	mov    %eax,0x4(%esp)
 1d3:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 1d9:	89 14 24             	mov    %edx,(%esp)
 1dc:	e8 bf 02 00 00       	call   4a0 <memmove>
      p[DIRSIZ] = 0;
 1e1:	8b 85 b4 fd ff ff    	mov    -0x24c(%ebp),%eax
      if(stat(buf, &st) < 0){
 1e7:	8d 95 c4 fd ff ff    	lea    -0x23c(%ebp),%edx
    *p++ = '/';
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
      if(de.inum == 0)
        continue;
      memmove(p, de.name, DIRSIZ);
      p[DIRSIZ] = 0;
 1ed:	c6 40 0e 00          	movb   $0x0,0xe(%eax)
      if(stat(buf, &st) < 0){
 1f1:	89 74 24 04          	mov    %esi,0x4(%esp)
 1f5:	89 14 24             	mov    %edx,(%esp)
 1f8:	e8 d3 02 00 00       	call   4d0 <stat>
 1fd:	85 c0                	test   %eax,%eax
 1ff:	0f 88 b3 00 00 00    	js     2b8 <ls+0x218>
        printf(1, "ls: cannot stat %s\n", buf);
        continue;
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 205:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
 209:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 20c:	8b 4d cc             	mov    -0x34(%ebp),%ecx
 20f:	89 85 b0 fd ff ff    	mov    %eax,-0x250(%ebp)
 215:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
 21b:	89 04 24             	mov    %eax,(%esp)
 21e:	89 95 ac fd ff ff    	mov    %edx,-0x254(%ebp)
 224:	89 8d a8 fd ff ff    	mov    %ecx,-0x258(%ebp)
 22a:	e8 d1 fd ff ff       	call   0 <fmtname>
 22f:	8b 95 ac fd ff ff    	mov    -0x254(%ebp),%edx
 235:	89 54 24 14          	mov    %edx,0x14(%esp)
 239:	8b 8d a8 fd ff ff    	mov    -0x258(%ebp),%ecx
 23f:	89 4c 24 10          	mov    %ecx,0x10(%esp)
 243:	8b 95 b0 fd ff ff    	mov    -0x250(%ebp),%edx
 249:	89 44 24 08          	mov    %eax,0x8(%esp)
 24d:	c7 44 24 04 86 0a 00 	movl   $0xa86,0x4(%esp)
 254:	00 
 255:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 25c:	89 54 24 0c          	mov    %edx,0xc(%esp)
 260:	e8 7b 04 00 00       	call   6e0 <printf>
 265:	e9 36 ff ff ff       	jmp    1a0 <ls+0x100>
 26a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
    break;
  
  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
      printf(1, "ls: path too long\n");
 270:	c7 44 24 04 93 0a 00 	movl   $0xa93,0x4(%esp)
 277:	00 
 278:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 27f:	e8 5c 04 00 00       	call   6e0 <printf>
      break;
 284:	e9 69 fe ff ff       	jmp    f2 <ls+0x52>
 289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct dirent de;
  struct stat st;
  
  if((fd = open(path, 0)) < 0){
    printf(2, "ls: cannot open %s\n", path);
 290:	89 7c 24 08          	mov    %edi,0x8(%esp)
 294:	c7 44 24 04 5e 0a 00 	movl   $0xa5e,0x4(%esp)
 29b:	00 
 29c:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 2a3:	e8 38 04 00 00       	call   6e0 <printf>
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
}
 2a8:	81 c4 6c 02 00 00    	add    $0x26c,%esp
 2ae:	5b                   	pop    %ebx
 2af:	5e                   	pop    %esi
 2b0:	5f                   	pop    %edi
 2b1:	5d                   	pop    %ebp
 2b2:	c3                   	ret    
 2b3:	90                   	nop
 2b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(de.inum == 0)
        continue;
      memmove(p, de.name, DIRSIZ);
      p[DIRSIZ] = 0;
      if(stat(buf, &st) < 0){
        printf(1, "ls: cannot stat %s\n", buf);
 2b8:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
 2be:	89 44 24 08          	mov    %eax,0x8(%esp)
 2c2:	c7 44 24 04 72 0a 00 	movl   $0xa72,0x4(%esp)
 2c9:	00 
 2ca:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2d1:	e8 0a 04 00 00       	call   6e0 <printf>
        continue;
 2d6:	e9 c5 fe ff ff       	jmp    1a0 <ls+0x100>
 2db:	90                   	nop
 2dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "ls: cannot open %s\n", path);
    return;
  }
  
  if(fstat(fd, &st) < 0){
    printf(2, "ls: cannot stat %s\n", path);
 2e0:	89 7c 24 08          	mov    %edi,0x8(%esp)
 2e4:	c7 44 24 04 72 0a 00 	movl   $0xa72,0x4(%esp)
 2eb:	00 
 2ec:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 2f3:	e8 e8 03 00 00       	call   6e0 <printf>
    close(fd);
 2f8:	89 1c 24             	mov    %ebx,(%esp)
 2fb:	e8 b0 02 00 00       	call   5b0 <close>
    return;
 300:	e9 f5 fd ff ff       	jmp    fa <ls+0x5a>
 305:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000310 <main>:
  close(fd);
}

int
main(int argc, char *argv[])
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	83 e4 f0             	and    $0xfffffff0,%esp
 316:	57                   	push   %edi
 317:	56                   	push   %esi
 318:	53                   	push   %ebx
  int i;

  if(argc < 2){
    ls(".");
    exit();
 319:	bb 01 00 00 00       	mov    $0x1,%ebx
  close(fd);
}

int
main(int argc, char *argv[])
{
 31e:	83 ec 14             	sub    $0x14,%esp
 321:	8b 75 08             	mov    0x8(%ebp),%esi
 324:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  if(argc < 2){
 327:	83 fe 01             	cmp    $0x1,%esi
 32a:	7e 1c                	jle    348 <main+0x38>
 32c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
 330:	8b 04 9f             	mov    (%edi,%ebx,4),%eax

  if(argc < 2){
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
 333:	83 c3 01             	add    $0x1,%ebx
    ls(argv[i]);
 336:	89 04 24             	mov    %eax,(%esp)
 339:	e8 62 fd ff ff       	call   a0 <ls>

  if(argc < 2){
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
 33e:	39 de                	cmp    %ebx,%esi
 340:	7f ee                	jg     330 <main+0x20>
    ls(argv[i]);
  exit();
 342:	e8 41 02 00 00       	call   588 <exit>
 347:	90                   	nop
main(int argc, char *argv[])
{
  int i;

  if(argc < 2){
    ls(".");
 348:	c7 04 24 a6 0a 00 00 	movl   $0xaa6,(%esp)
 34f:	e8 4c fd ff ff       	call   a0 <ls>
    exit();
 354:	e8 2f 02 00 00       	call   588 <exit>
 359:	90                   	nop
 35a:	90                   	nop
 35b:	90                   	nop
 35c:	90                   	nop
 35d:	90                   	nop
 35e:	90                   	nop
 35f:	90                   	nop

00000360 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 360:	55                   	push   %ebp
 361:	31 d2                	xor    %edx,%edx
 363:	89 e5                	mov    %esp,%ebp
 365:	8b 45 08             	mov    0x8(%ebp),%eax
 368:	53                   	push   %ebx
 369:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 36c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 370:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
 374:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 377:	83 c2 01             	add    $0x1,%edx
 37a:	84 c9                	test   %cl,%cl
 37c:	75 f2                	jne    370 <strcpy+0x10>
    ;
  return os;
}
 37e:	5b                   	pop    %ebx
 37f:	5d                   	pop    %ebp
 380:	c3                   	ret    
 381:	eb 0d                	jmp    390 <strcmp>
 383:	90                   	nop
 384:	90                   	nop
 385:	90                   	nop
 386:	90                   	nop
 387:	90                   	nop
 388:	90                   	nop
 389:	90                   	nop
 38a:	90                   	nop
 38b:	90                   	nop
 38c:	90                   	nop
 38d:	90                   	nop
 38e:	90                   	nop
 38f:	90                   	nop

00000390 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	53                   	push   %ebx
 394:	8b 4d 08             	mov    0x8(%ebp),%ecx
 397:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 39a:	0f b6 01             	movzbl (%ecx),%eax
 39d:	84 c0                	test   %al,%al
 39f:	75 14                	jne    3b5 <strcmp+0x25>
 3a1:	eb 25                	jmp    3c8 <strcmp+0x38>
 3a3:	90                   	nop
 3a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
 3a8:	83 c1 01             	add    $0x1,%ecx
 3ab:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3ae:	0f b6 01             	movzbl (%ecx),%eax
 3b1:	84 c0                	test   %al,%al
 3b3:	74 13                	je     3c8 <strcmp+0x38>
 3b5:	0f b6 1a             	movzbl (%edx),%ebx
 3b8:	38 d8                	cmp    %bl,%al
 3ba:	74 ec                	je     3a8 <strcmp+0x18>
 3bc:	0f b6 db             	movzbl %bl,%ebx
 3bf:	0f b6 c0             	movzbl %al,%eax
 3c2:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 3c4:	5b                   	pop    %ebx
 3c5:	5d                   	pop    %ebp
 3c6:	c3                   	ret    
 3c7:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3c8:	0f b6 1a             	movzbl (%edx),%ebx
 3cb:	31 c0                	xor    %eax,%eax
 3cd:	0f b6 db             	movzbl %bl,%ebx
 3d0:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 3d2:	5b                   	pop    %ebx
 3d3:	5d                   	pop    %ebp
 3d4:	c3                   	ret    
 3d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003e0 <strlen>:

uint
strlen(char *s)
{
 3e0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 3e1:	31 d2                	xor    %edx,%edx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 3e3:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
 3e5:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 3e7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 3ea:	80 39 00             	cmpb   $0x0,(%ecx)
 3ed:	74 0c                	je     3fb <strlen+0x1b>
 3ef:	90                   	nop
 3f0:	83 c2 01             	add    $0x1,%edx
 3f3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 3f7:	89 d0                	mov    %edx,%eax
 3f9:	75 f5                	jne    3f0 <strlen+0x10>
    ;
  return n;
}
 3fb:	5d                   	pop    %ebp
 3fc:	c3                   	ret    
 3fd:	8d 76 00             	lea    0x0(%esi),%esi

00000400 <memset>:

void*
memset(void *dst, int c, uint n)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	8b 55 08             	mov    0x8(%ebp),%edx
 406:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 407:	8b 4d 10             	mov    0x10(%ebp),%ecx
 40a:	8b 45 0c             	mov    0xc(%ebp),%eax
 40d:	89 d7                	mov    %edx,%edi
 40f:	fc                   	cld    
 410:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 412:	89 d0                	mov    %edx,%eax
 414:	5f                   	pop    %edi
 415:	5d                   	pop    %ebp
 416:	c3                   	ret    
 417:	89 f6                	mov    %esi,%esi
 419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000420 <strchr>:

char*
strchr(const char *s, char c)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	8b 45 08             	mov    0x8(%ebp),%eax
 426:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 42a:	0f b6 10             	movzbl (%eax),%edx
 42d:	84 d2                	test   %dl,%dl
 42f:	75 11                	jne    442 <strchr+0x22>
 431:	eb 15                	jmp    448 <strchr+0x28>
 433:	90                   	nop
 434:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 438:	83 c0 01             	add    $0x1,%eax
 43b:	0f b6 10             	movzbl (%eax),%edx
 43e:	84 d2                	test   %dl,%dl
 440:	74 06                	je     448 <strchr+0x28>
    if(*s == c)
 442:	38 ca                	cmp    %cl,%dl
 444:	75 f2                	jne    438 <strchr+0x18>
      return (char*) s;
  return 0;
}
 446:	5d                   	pop    %ebp
 447:	c3                   	ret    
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 448:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 44a:	5d                   	pop    %ebp
 44b:	90                   	nop
 44c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 450:	c3                   	ret    
 451:	eb 0d                	jmp    460 <atoi>
 453:	90                   	nop
 454:	90                   	nop
 455:	90                   	nop
 456:	90                   	nop
 457:	90                   	nop
 458:	90                   	nop
 459:	90                   	nop
 45a:	90                   	nop
 45b:	90                   	nop
 45c:	90                   	nop
 45d:	90                   	nop
 45e:	90                   	nop
 45f:	90                   	nop

00000460 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 460:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 461:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
 463:	89 e5                	mov    %esp,%ebp
 465:	8b 4d 08             	mov    0x8(%ebp),%ecx
 468:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 469:	0f b6 11             	movzbl (%ecx),%edx
 46c:	8d 5a d0             	lea    -0x30(%edx),%ebx
 46f:	80 fb 09             	cmp    $0x9,%bl
 472:	77 1c                	ja     490 <atoi+0x30>
 474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 478:	0f be d2             	movsbl %dl,%edx
 47b:	83 c1 01             	add    $0x1,%ecx
 47e:	8d 04 80             	lea    (%eax,%eax,4),%eax
 481:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 485:	0f b6 11             	movzbl (%ecx),%edx
 488:	8d 5a d0             	lea    -0x30(%edx),%ebx
 48b:	80 fb 09             	cmp    $0x9,%bl
 48e:	76 e8                	jbe    478 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 490:	5b                   	pop    %ebx
 491:	5d                   	pop    %ebp
 492:	c3                   	ret    
 493:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004a0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	56                   	push   %esi
 4a4:	8b 45 08             	mov    0x8(%ebp),%eax
 4a7:	53                   	push   %ebx
 4a8:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4ae:	85 db                	test   %ebx,%ebx
 4b0:	7e 14                	jle    4c6 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
 4b2:	31 d2                	xor    %edx,%edx
 4b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
 4b8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 4bc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 4bf:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4c2:	39 da                	cmp    %ebx,%edx
 4c4:	75 f2                	jne    4b8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 4c6:	5b                   	pop    %ebx
 4c7:	5e                   	pop    %esi
 4c8:	5d                   	pop    %ebp
 4c9:	c3                   	ret    
 4ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000004d0 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 4d0:	55                   	push   %ebp
 4d1:	89 e5                	mov    %esp,%ebp
 4d3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4d6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 4d9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 4dc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 4df:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4e4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 4eb:	00 
 4ec:	89 04 24             	mov    %eax,(%esp)
 4ef:	e8 d4 00 00 00       	call   5c8 <open>
  if(fd < 0)
 4f4:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4f6:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 4f8:	78 19                	js     513 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 4fa:	8b 45 0c             	mov    0xc(%ebp),%eax
 4fd:	89 1c 24             	mov    %ebx,(%esp)
 500:	89 44 24 04          	mov    %eax,0x4(%esp)
 504:	e8 d7 00 00 00       	call   5e0 <fstat>
  close(fd);
 509:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 50c:	89 c6                	mov    %eax,%esi
  close(fd);
 50e:	e8 9d 00 00 00       	call   5b0 <close>
  return r;
}
 513:	89 f0                	mov    %esi,%eax
 515:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 518:	8b 75 fc             	mov    -0x4(%ebp),%esi
 51b:	89 ec                	mov    %ebp,%esp
 51d:	5d                   	pop    %ebp
 51e:	c3                   	ret    
 51f:	90                   	nop

00000520 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 520:	55                   	push   %ebp
 521:	89 e5                	mov    %esp,%ebp
 523:	57                   	push   %edi
 524:	56                   	push   %esi
 525:	31 f6                	xor    %esi,%esi
 527:	53                   	push   %ebx
 528:	83 ec 2c             	sub    $0x2c,%esp
 52b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 52e:	eb 06                	jmp    536 <gets+0x16>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 530:	3c 0a                	cmp    $0xa,%al
 532:	74 39                	je     56d <gets+0x4d>
 534:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 536:	8d 5e 01             	lea    0x1(%esi),%ebx
 539:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 53c:	7d 31                	jge    56f <gets+0x4f>
    cc = read(0, &c, 1);
 53e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 541:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 548:	00 
 549:	89 44 24 04          	mov    %eax,0x4(%esp)
 54d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 554:	e8 47 00 00 00       	call   5a0 <read>
    if(cc < 1)
 559:	85 c0                	test   %eax,%eax
 55b:	7e 12                	jle    56f <gets+0x4f>
      break;
    buf[i++] = c;
 55d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 561:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 565:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 569:	3c 0d                	cmp    $0xd,%al
 56b:	75 c3                	jne    530 <gets+0x10>
 56d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 56f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 573:	89 f8                	mov    %edi,%eax
 575:	83 c4 2c             	add    $0x2c,%esp
 578:	5b                   	pop    %ebx
 579:	5e                   	pop    %esi
 57a:	5f                   	pop    %edi
 57b:	5d                   	pop    %ebp
 57c:	c3                   	ret    
 57d:	90                   	nop
 57e:	90                   	nop
 57f:	90                   	nop

00000580 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 580:	b8 01 00 00 00       	mov    $0x1,%eax
 585:	cd 40                	int    $0x40
 587:	c3                   	ret    

00000588 <exit>:
SYSCALL(exit)
 588:	b8 02 00 00 00       	mov    $0x2,%eax
 58d:	cd 40                	int    $0x40
 58f:	c3                   	ret    

00000590 <wait>:
SYSCALL(wait)
 590:	b8 03 00 00 00       	mov    $0x3,%eax
 595:	cd 40                	int    $0x40
 597:	c3                   	ret    

00000598 <pipe>:
SYSCALL(pipe)
 598:	b8 04 00 00 00       	mov    $0x4,%eax
 59d:	cd 40                	int    $0x40
 59f:	c3                   	ret    

000005a0 <read>:
SYSCALL(read)
 5a0:	b8 06 00 00 00       	mov    $0x6,%eax
 5a5:	cd 40                	int    $0x40
 5a7:	c3                   	ret    

000005a8 <write>:
SYSCALL(write)
 5a8:	b8 05 00 00 00       	mov    $0x5,%eax
 5ad:	cd 40                	int    $0x40
 5af:	c3                   	ret    

000005b0 <close>:
SYSCALL(close)
 5b0:	b8 07 00 00 00       	mov    $0x7,%eax
 5b5:	cd 40                	int    $0x40
 5b7:	c3                   	ret    

000005b8 <kill>:
SYSCALL(kill)
 5b8:	b8 08 00 00 00       	mov    $0x8,%eax
 5bd:	cd 40                	int    $0x40
 5bf:	c3                   	ret    

000005c0 <exec>:
SYSCALL(exec)
 5c0:	b8 09 00 00 00       	mov    $0x9,%eax
 5c5:	cd 40                	int    $0x40
 5c7:	c3                   	ret    

000005c8 <open>:
SYSCALL(open)
 5c8:	b8 0a 00 00 00       	mov    $0xa,%eax
 5cd:	cd 40                	int    $0x40
 5cf:	c3                   	ret    

000005d0 <mknod>:
SYSCALL(mknod)
 5d0:	b8 0b 00 00 00       	mov    $0xb,%eax
 5d5:	cd 40                	int    $0x40
 5d7:	c3                   	ret    

000005d8 <unlink>:
SYSCALL(unlink)
 5d8:	b8 0c 00 00 00       	mov    $0xc,%eax
 5dd:	cd 40                	int    $0x40
 5df:	c3                   	ret    

000005e0 <fstat>:
SYSCALL(fstat)
 5e0:	b8 0d 00 00 00       	mov    $0xd,%eax
 5e5:	cd 40                	int    $0x40
 5e7:	c3                   	ret    

000005e8 <link>:
SYSCALL(link)
 5e8:	b8 0e 00 00 00       	mov    $0xe,%eax
 5ed:	cd 40                	int    $0x40
 5ef:	c3                   	ret    

000005f0 <mkdir>:
SYSCALL(mkdir)
 5f0:	b8 0f 00 00 00       	mov    $0xf,%eax
 5f5:	cd 40                	int    $0x40
 5f7:	c3                   	ret    

000005f8 <chdir>:
SYSCALL(chdir)
 5f8:	b8 10 00 00 00       	mov    $0x10,%eax
 5fd:	cd 40                	int    $0x40
 5ff:	c3                   	ret    

00000600 <dup>:
SYSCALL(dup)
 600:	b8 11 00 00 00       	mov    $0x11,%eax
 605:	cd 40                	int    $0x40
 607:	c3                   	ret    

00000608 <getpid>:
SYSCALL(getpid)
 608:	b8 12 00 00 00       	mov    $0x12,%eax
 60d:	cd 40                	int    $0x40
 60f:	c3                   	ret    

00000610 <sbrk>:
SYSCALL(sbrk)
 610:	b8 13 00 00 00       	mov    $0x13,%eax
 615:	cd 40                	int    $0x40
 617:	c3                   	ret    

00000618 <sleep>:
SYSCALL(sleep)
 618:	b8 14 00 00 00       	mov    $0x14,%eax
 61d:	cd 40                	int    $0x40
 61f:	c3                   	ret    

00000620 <uptime>:
SYSCALL(uptime)
 620:	b8 15 00 00 00       	mov    $0x15,%eax
 625:	cd 40                	int    $0x40
 627:	c3                   	ret    

00000628 <startrecording>:
SYSCALL(startrecording)
 628:	b8 16 00 00 00       	mov    $0x16,%eax
 62d:	cd 40                	int    $0x40
 62f:	c3                   	ret    

00000630 <stoprecording>:
SYSCALL(stoprecording)
 630:	b8 17 00 00 00       	mov    $0x17,%eax
 635:	cd 40                	int    $0x40
 637:	c3                   	ret    

00000638 <fetchrecords>:
 638:	b8 18 00 00 00       	mov    $0x18,%eax
 63d:	cd 40                	int    $0x40
 63f:	c3                   	ret    

00000640 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 640:	55                   	push   %ebp
 641:	89 e5                	mov    %esp,%ebp
 643:	57                   	push   %edi
 644:	89 cf                	mov    %ecx,%edi
 646:	56                   	push   %esi
 647:	89 c6                	mov    %eax,%esi
 649:	53                   	push   %ebx
 64a:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 64d:	8b 4d 08             	mov    0x8(%ebp),%ecx
 650:	85 c9                	test   %ecx,%ecx
 652:	74 04                	je     658 <printint+0x18>
 654:	85 d2                	test   %edx,%edx
 656:	78 70                	js     6c8 <printint+0x88>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 658:	89 d0                	mov    %edx,%eax
 65a:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 661:	31 c9                	xor    %ecx,%ecx
 663:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 666:	66 90                	xchg   %ax,%ax
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 668:	31 d2                	xor    %edx,%edx
 66a:	f7 f7                	div    %edi
 66c:	0f b6 92 af 0a 00 00 	movzbl 0xaaf(%edx),%edx
 673:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
 676:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
 679:	85 c0                	test   %eax,%eax
 67b:	75 eb                	jne    668 <printint+0x28>
  if(neg)
 67d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 680:	85 c0                	test   %eax,%eax
 682:	74 08                	je     68c <printint+0x4c>
    buf[i++] = '-';
 684:	c6 44 0d d7 2d       	movb   $0x2d,-0x29(%ebp,%ecx,1)
 689:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
 68c:	8d 79 ff             	lea    -0x1(%ecx),%edi
 68f:	01 fb                	add    %edi,%ebx
 691:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 698:	0f b6 03             	movzbl (%ebx),%eax
 69b:	83 ef 01             	sub    $0x1,%edi
 69e:	83 eb 01             	sub    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6a1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6a8:	00 
 6a9:	89 34 24             	mov    %esi,(%esp)
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 6ac:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6af:	8d 45 e7             	lea    -0x19(%ebp),%eax
 6b2:	89 44 24 04          	mov    %eax,0x4(%esp)
 6b6:	e8 ed fe ff ff       	call   5a8 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 6bb:	83 ff ff             	cmp    $0xffffffff,%edi
 6be:	75 d8                	jne    698 <printint+0x58>
    putc(fd, buf[i]);
}
 6c0:	83 c4 4c             	add    $0x4c,%esp
 6c3:	5b                   	pop    %ebx
 6c4:	5e                   	pop    %esi
 6c5:	5f                   	pop    %edi
 6c6:	5d                   	pop    %ebp
 6c7:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 6c8:	89 d0                	mov    %edx,%eax
 6ca:	f7 d8                	neg    %eax
 6cc:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 6d3:	eb 8c                	jmp    661 <printint+0x21>
 6d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006e0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	57                   	push   %edi
 6e4:	56                   	push   %esi
 6e5:	53                   	push   %ebx
 6e6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6e9:	8b 45 0c             	mov    0xc(%ebp),%eax
 6ec:	0f b6 10             	movzbl (%eax),%edx
 6ef:	84 d2                	test   %dl,%dl
 6f1:	0f 84 c9 00 00 00    	je     7c0 <printf+0xe0>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 6f7:	8d 4d 10             	lea    0x10(%ebp),%ecx
 6fa:	31 ff                	xor    %edi,%edi
 6fc:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 6ff:	31 db                	xor    %ebx,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 701:	8d 75 e7             	lea    -0x19(%ebp),%esi
 704:	eb 1e                	jmp    724 <printf+0x44>
 706:	66 90                	xchg   %ax,%ax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 708:	83 fa 25             	cmp    $0x25,%edx
 70b:	0f 85 b7 00 00 00    	jne    7c8 <printf+0xe8>
 711:	66 bf 25 00          	mov    $0x25,%di
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 715:	83 c3 01             	add    $0x1,%ebx
 718:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
 71c:	84 d2                	test   %dl,%dl
 71e:	0f 84 9c 00 00 00    	je     7c0 <printf+0xe0>
    c = fmt[i] & 0xff;
    if(state == 0){
 724:	85 ff                	test   %edi,%edi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 726:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
 729:	74 dd                	je     708 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 72b:	83 ff 25             	cmp    $0x25,%edi
 72e:	75 e5                	jne    715 <printf+0x35>
      if(c == 'd'){
 730:	83 fa 64             	cmp    $0x64,%edx
 733:	0f 84 57 01 00 00    	je     890 <printf+0x1b0>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 739:	83 fa 70             	cmp    $0x70,%edx
 73c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 740:	0f 84 aa 00 00 00    	je     7f0 <printf+0x110>
 746:	83 fa 78             	cmp    $0x78,%edx
 749:	0f 84 a1 00 00 00    	je     7f0 <printf+0x110>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 74f:	83 fa 73             	cmp    $0x73,%edx
 752:	0f 84 c0 00 00 00    	je     818 <printf+0x138>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 758:	83 fa 63             	cmp    $0x63,%edx
 75b:	90                   	nop
 75c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 760:	0f 84 52 01 00 00    	je     8b8 <printf+0x1d8>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 766:	83 fa 25             	cmp    $0x25,%edx
 769:	0f 84 f9 00 00 00    	je     868 <printf+0x188>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 76f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 772:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 775:	31 ff                	xor    %edi,%edi
 777:	89 55 cc             	mov    %edx,-0x34(%ebp)
 77a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 77e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 785:	00 
 786:	89 0c 24             	mov    %ecx,(%esp)
 789:	89 74 24 04          	mov    %esi,0x4(%esp)
 78d:	e8 16 fe ff ff       	call   5a8 <write>
 792:	8b 55 cc             	mov    -0x34(%ebp),%edx
 795:	8b 45 08             	mov    0x8(%ebp),%eax
 798:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 79f:	00 
 7a0:	89 74 24 04          	mov    %esi,0x4(%esp)
 7a4:	88 55 e7             	mov    %dl,-0x19(%ebp)
 7a7:	89 04 24             	mov    %eax,(%esp)
 7aa:	e8 f9 fd ff ff       	call   5a8 <write>
 7af:	8b 45 0c             	mov    0xc(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7b2:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
 7b6:	84 d2                	test   %dl,%dl
 7b8:	0f 85 66 ff ff ff    	jne    724 <printf+0x44>
 7be:	66 90                	xchg   %ax,%ax
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 7c0:	83 c4 3c             	add    $0x3c,%esp
 7c3:	5b                   	pop    %ebx
 7c4:	5e                   	pop    %esi
 7c5:	5f                   	pop    %edi
 7c6:	5d                   	pop    %ebp
 7c7:	c3                   	ret    
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7c8:	8b 45 08             	mov    0x8(%ebp),%eax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 7cb:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7ce:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 7d5:	00 
 7d6:	89 74 24 04          	mov    %esi,0x4(%esp)
 7da:	89 04 24             	mov    %eax,(%esp)
 7dd:	e8 c6 fd ff ff       	call   5a8 <write>
 7e2:	8b 45 0c             	mov    0xc(%ebp),%eax
 7e5:	e9 2b ff ff ff       	jmp    715 <printf+0x35>
 7ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 7f0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 7f3:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 7f8:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 7fa:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 801:	8b 10                	mov    (%eax),%edx
 803:	8b 45 08             	mov    0x8(%ebp),%eax
 806:	e8 35 fe ff ff       	call   640 <printint>
 80b:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
 80e:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 812:	e9 fe fe ff ff       	jmp    715 <printf+0x35>
 817:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
 818:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 81b:	8b 3a                	mov    (%edx),%edi
        ap++;
 81d:	83 c2 04             	add    $0x4,%edx
 820:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
 823:	85 ff                	test   %edi,%edi
 825:	0f 84 ba 00 00 00    	je     8e5 <printf+0x205>
          s = "(null)";
        while(*s != 0){
 82b:	0f b6 17             	movzbl (%edi),%edx
 82e:	84 d2                	test   %dl,%dl
 830:	74 2d                	je     85f <printf+0x17f>
 832:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 835:	8b 5d 08             	mov    0x8(%ebp),%ebx
          putc(fd, *s);
          s++;
 838:	83 c7 01             	add    $0x1,%edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 83b:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 83e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 845:	00 
 846:	89 74 24 04          	mov    %esi,0x4(%esp)
 84a:	89 1c 24             	mov    %ebx,(%esp)
 84d:	e8 56 fd ff ff       	call   5a8 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 852:	0f b6 17             	movzbl (%edi),%edx
 855:	84 d2                	test   %dl,%dl
 857:	75 df                	jne    838 <printf+0x158>
 859:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 85c:	8b 45 0c             	mov    0xc(%ebp),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 85f:	31 ff                	xor    %edi,%edi
 861:	e9 af fe ff ff       	jmp    715 <printf+0x35>
 866:	66 90                	xchg   %ax,%ax
 868:	8b 55 08             	mov    0x8(%ebp),%edx
 86b:	31 ff                	xor    %edi,%edi
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 86d:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 871:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 878:	00 
 879:	89 74 24 04          	mov    %esi,0x4(%esp)
 87d:	89 14 24             	mov    %edx,(%esp)
 880:	e8 23 fd ff ff       	call   5a8 <write>
 885:	8b 45 0c             	mov    0xc(%ebp),%eax
 888:	e9 88 fe ff ff       	jmp    715 <printf+0x35>
 88d:	8d 76 00             	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 890:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 893:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 898:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 89b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 8a2:	8b 10                	mov    (%eax),%edx
 8a4:	8b 45 08             	mov    0x8(%ebp),%eax
 8a7:	e8 94 fd ff ff       	call   640 <printint>
 8ac:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
 8af:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 8b3:	e9 5d fe ff ff       	jmp    715 <printf+0x35>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 8b8:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
        putc(fd, *ap);
        ap++;
 8bb:	31 ff                	xor    %edi,%edi
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 8bd:	8b 01                	mov    (%ecx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 8bf:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 8c6:	00 
 8c7:	89 74 24 04          	mov    %esi,0x4(%esp)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 8cb:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 8ce:	8b 45 08             	mov    0x8(%ebp),%eax
 8d1:	89 04 24             	mov    %eax,(%esp)
 8d4:	e8 cf fc ff ff       	call   5a8 <write>
 8d9:	8b 45 0c             	mov    0xc(%ebp),%eax
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 8dc:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 8e0:	e9 30 fe ff ff       	jmp    715 <printf+0x35>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
 8e5:	bf a8 0a 00 00       	mov    $0xaa8,%edi
 8ea:	e9 3c ff ff ff       	jmp    82b <printf+0x14b>
 8ef:	90                   	nop

000008f0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8f0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8f1:	a1 d8 0a 00 00       	mov    0xad8,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 8f6:	89 e5                	mov    %esp,%ebp
 8f8:	57                   	push   %edi
 8f9:	56                   	push   %esi
 8fa:	53                   	push   %ebx
 8fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 8fe:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 901:	39 c8                	cmp    %ecx,%eax
 903:	73 1d                	jae    922 <free+0x32>
 905:	8d 76 00             	lea    0x0(%esi),%esi
 908:	8b 10                	mov    (%eax),%edx
 90a:	39 d1                	cmp    %edx,%ecx
 90c:	72 1a                	jb     928 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 90e:	39 d0                	cmp    %edx,%eax
 910:	72 08                	jb     91a <free+0x2a>
 912:	39 c8                	cmp    %ecx,%eax
 914:	72 12                	jb     928 <free+0x38>
 916:	39 d1                	cmp    %edx,%ecx
 918:	72 0e                	jb     928 <free+0x38>
 91a:	89 d0                	mov    %edx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 91c:	39 c8                	cmp    %ecx,%eax
 91e:	66 90                	xchg   %ax,%ax
 920:	72 e6                	jb     908 <free+0x18>
 922:	8b 10                	mov    (%eax),%edx
 924:	eb e8                	jmp    90e <free+0x1e>
 926:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 928:	8b 71 04             	mov    0x4(%ecx),%esi
 92b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 92e:	39 d7                	cmp    %edx,%edi
 930:	74 19                	je     94b <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 932:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 935:	8b 50 04             	mov    0x4(%eax),%edx
 938:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 93b:	39 ce                	cmp    %ecx,%esi
 93d:	74 23                	je     962 <free+0x72>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 93f:	89 08                	mov    %ecx,(%eax)
  freep = p;
 941:	a3 d8 0a 00 00       	mov    %eax,0xad8
}
 946:	5b                   	pop    %ebx
 947:	5e                   	pop    %esi
 948:	5f                   	pop    %edi
 949:	5d                   	pop    %ebp
 94a:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 94b:	03 72 04             	add    0x4(%edx),%esi
 94e:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
 951:	8b 10                	mov    (%eax),%edx
 953:	8b 12                	mov    (%edx),%edx
 955:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 958:	8b 50 04             	mov    0x4(%eax),%edx
 95b:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 95e:	39 ce                	cmp    %ecx,%esi
 960:	75 dd                	jne    93f <free+0x4f>
    p->s.size += bp->s.size;
 962:	03 51 04             	add    0x4(%ecx),%edx
 965:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 968:	8b 53 f8             	mov    -0x8(%ebx),%edx
 96b:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 96d:	a3 d8 0a 00 00       	mov    %eax,0xad8
}
 972:	5b                   	pop    %ebx
 973:	5e                   	pop    %esi
 974:	5f                   	pop    %edi
 975:	5d                   	pop    %ebp
 976:	c3                   	ret    
 977:	89 f6                	mov    %esi,%esi
 979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000980 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 980:	55                   	push   %ebp
 981:	89 e5                	mov    %esp,%ebp
 983:	57                   	push   %edi
 984:	56                   	push   %esi
 985:	53                   	push   %ebx
 986:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 989:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
 98c:	8b 0d d8 0a 00 00    	mov    0xad8,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 992:	83 c3 07             	add    $0x7,%ebx
 995:	c1 eb 03             	shr    $0x3,%ebx
 998:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 99b:	85 c9                	test   %ecx,%ecx
 99d:	0f 84 93 00 00 00    	je     a36 <malloc+0xb6>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9a3:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 9a5:	8b 50 04             	mov    0x4(%eax),%edx
 9a8:	39 d3                	cmp    %edx,%ebx
 9aa:	76 1f                	jbe    9cb <malloc+0x4b>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 9ac:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 9b3:	90                   	nop
 9b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
    if(p == freep)
 9b8:	3b 05 d8 0a 00 00    	cmp    0xad8,%eax
 9be:	74 30                	je     9f0 <malloc+0x70>
 9c0:	89 c1                	mov    %eax,%ecx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9c2:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 9c4:	8b 50 04             	mov    0x4(%eax),%edx
 9c7:	39 d3                	cmp    %edx,%ebx
 9c9:	77 ed                	ja     9b8 <malloc+0x38>
      if(p->s.size == nunits)
 9cb:	39 d3                	cmp    %edx,%ebx
 9cd:	74 61                	je     a30 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 9cf:	29 da                	sub    %ebx,%edx
 9d1:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 9d4:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 9d7:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 9da:	89 0d d8 0a 00 00    	mov    %ecx,0xad8
      return (void*) (p + 1);
 9e0:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 9e3:	83 c4 1c             	add    $0x1c,%esp
 9e6:	5b                   	pop    %ebx
 9e7:	5e                   	pop    %esi
 9e8:	5f                   	pop    %edi
 9e9:	5d                   	pop    %ebp
 9ea:	c3                   	ret    
 9eb:	90                   	nop
 9ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 9f0:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 9f6:	b8 00 80 00 00       	mov    $0x8000,%eax
 9fb:	bf 00 10 00 00       	mov    $0x1000,%edi
 a00:	76 04                	jbe    a06 <malloc+0x86>
 a02:	89 f0                	mov    %esi,%eax
 a04:	89 df                	mov    %ebx,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 a06:	89 04 24             	mov    %eax,(%esp)
 a09:	e8 02 fc ff ff       	call   610 <sbrk>
  if(p == (char*) -1)
 a0e:	83 f8 ff             	cmp    $0xffffffff,%eax
 a11:	74 18                	je     a2b <malloc+0xab>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 a13:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 a16:	83 c0 08             	add    $0x8,%eax
 a19:	89 04 24             	mov    %eax,(%esp)
 a1c:	e8 cf fe ff ff       	call   8f0 <free>
  return freep;
 a21:	8b 0d d8 0a 00 00    	mov    0xad8,%ecx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 a27:	85 c9                	test   %ecx,%ecx
 a29:	75 97                	jne    9c2 <malloc+0x42>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 a2b:	31 c0                	xor    %eax,%eax
 a2d:	eb b4                	jmp    9e3 <malloc+0x63>
 a2f:	90                   	nop
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 a30:	8b 10                	mov    (%eax),%edx
 a32:	89 11                	mov    %edx,(%ecx)
 a34:	eb a4                	jmp    9da <malloc+0x5a>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 a36:	c7 05 d8 0a 00 00 d0 	movl   $0xad0,0xad8
 a3d:	0a 00 00 
    base.s.size = 0;
 a40:	b9 d0 0a 00 00       	mov    $0xad0,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 a45:	c7 05 d0 0a 00 00 d0 	movl   $0xad0,0xad0
 a4c:	0a 00 00 
    base.s.size = 0;
 a4f:	c7 05 d4 0a 00 00 00 	movl   $0x0,0xad4
 a56:	00 00 00 
 a59:	e9 45 ff ff ff       	jmp    9a3 <malloc+0x23>
