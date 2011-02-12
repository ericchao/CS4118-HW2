
kernel:     file format elf32-i386


Disassembly of section .text:

00100000 <brelse>:
}

// Release the buffer b.
void
brelse(struct buf *b)
{
  100000:	55                   	push   %ebp
  100001:	89 e5                	mov    %esp,%ebp
  100003:	53                   	push   %ebx
  100004:	83 ec 14             	sub    $0x14,%esp
  100007:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((b->flags & B_BUSY) == 0)
  10000a:	f6 03 01             	testb  $0x1,(%ebx)
  10000d:	74 57                	je     100066 <brelse+0x66>
    panic("brelse");

  acquire(&bcache.lock);
  10000f:	c7 04 24 60 78 10 00 	movl   $0x107860,(%esp)
  100016:	e8 05 3b 00 00       	call   103b20 <acquire>

  b->next->prev = b->prev;
  10001b:	8b 43 10             	mov    0x10(%ebx),%eax
  10001e:	8b 53 0c             	mov    0xc(%ebx),%edx
  100021:	89 50 0c             	mov    %edx,0xc(%eax)
  b->prev->next = b->next;
  100024:	8b 43 0c             	mov    0xc(%ebx),%eax
  100027:	8b 53 10             	mov    0x10(%ebx),%edx
  10002a:	89 50 10             	mov    %edx,0x10(%eax)
  b->next = bcache.head.next;
  10002d:	a1 94 8d 10 00       	mov    0x108d94,%eax
  b->prev = &bcache.head;
  100032:	c7 43 0c 84 8d 10 00 	movl   $0x108d84,0xc(%ebx)

  acquire(&bcache.lock);

  b->next->prev = b->prev;
  b->prev->next = b->next;
  b->next = bcache.head.next;
  100039:	89 43 10             	mov    %eax,0x10(%ebx)
  b->prev = &bcache.head;
  bcache.head.next->prev = b;
  10003c:	a1 94 8d 10 00       	mov    0x108d94,%eax
  100041:	89 58 0c             	mov    %ebx,0xc(%eax)
  bcache.head.next = b;
  100044:	89 1d 94 8d 10 00    	mov    %ebx,0x108d94

  b->flags &= ~B_BUSY;
  10004a:	83 23 fe             	andl   $0xfffffffe,(%ebx)
  wakeup(b);
  10004d:	89 1c 24             	mov    %ebx,(%esp)
  100050:	e8 fb 2f 00 00       	call   103050 <wakeup>

  release(&bcache.lock);
  100055:	c7 45 08 60 78 10 00 	movl   $0x107860,0x8(%ebp)
}
  10005c:	83 c4 14             	add    $0x14,%esp
  10005f:	5b                   	pop    %ebx
  100060:	5d                   	pop    %ebp
  bcache.head.next = b;

  b->flags &= ~B_BUSY;
  wakeup(b);

  release(&bcache.lock);
  100061:	e9 6a 3a 00 00       	jmp    103ad0 <release>
// Release the buffer b.
void
brelse(struct buf *b)
{
  if((b->flags & B_BUSY) == 0)
    panic("brelse");
  100066:	c7 04 24 a0 64 10 00 	movl   $0x1064a0,(%esp)
  10006d:	e8 3e 08 00 00       	call   1008b0 <panic>
  100072:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100079:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100080 <bwrite>:
}

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  100080:	55                   	push   %ebp
  100081:	89 e5                	mov    %esp,%ebp
  100083:	83 ec 18             	sub    $0x18,%esp
  100086:	8b 45 08             	mov    0x8(%ebp),%eax
  if((b->flags & B_BUSY) == 0)
  100089:	8b 10                	mov    (%eax),%edx
  10008b:	f6 c2 01             	test   $0x1,%dl
  10008e:	74 0e                	je     10009e <bwrite+0x1e>
    panic("bwrite");
  b->flags |= B_DIRTY;
  100090:	83 ca 04             	or     $0x4,%edx
  100093:	89 10                	mov    %edx,(%eax)
  iderw(b);
  100095:	89 45 08             	mov    %eax,0x8(%ebp)
}
  100098:	c9                   	leave  
bwrite(struct buf *b)
{
  if((b->flags & B_BUSY) == 0)
    panic("bwrite");
  b->flags |= B_DIRTY;
  iderw(b);
  100099:	e9 82 1e 00 00       	jmp    101f20 <iderw>
// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if((b->flags & B_BUSY) == 0)
    panic("bwrite");
  10009e:	c7 04 24 a7 64 10 00 	movl   $0x1064a7,(%esp)
  1000a5:	e8 06 08 00 00       	call   1008b0 <panic>
  1000aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001000b0 <bread>:
}

// Return a B_BUSY buf with the contents of the indicated disk sector.
struct buf*
bread(uint dev, uint sector)
{
  1000b0:	55                   	push   %ebp
  1000b1:	89 e5                	mov    %esp,%ebp
  1000b3:	57                   	push   %edi
  1000b4:	56                   	push   %esi
  1000b5:	53                   	push   %ebx
  1000b6:	83 ec 1c             	sub    $0x1c,%esp
  1000b9:	8b 75 08             	mov    0x8(%ebp),%esi
  1000bc:	8b 7d 0c             	mov    0xc(%ebp),%edi
static struct buf*
bget(uint dev, uint sector)
{
  struct buf *b;

  acquire(&bcache.lock);
  1000bf:	c7 04 24 60 78 10 00 	movl   $0x107860,(%esp)
  1000c6:	e8 55 3a 00 00       	call   103b20 <acquire>

 loop:
  // Try for cached block.
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
  1000cb:	8b 1d 94 8d 10 00    	mov    0x108d94,%ebx
  1000d1:	81 fb 84 8d 10 00    	cmp    $0x108d84,%ebx
  1000d7:	75 12                	jne    1000eb <bread+0x3b>
  1000d9:	eb 35                	jmp    100110 <bread+0x60>
  1000db:	90                   	nop
  1000dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1000e0:	8b 5b 10             	mov    0x10(%ebx),%ebx
  1000e3:	81 fb 84 8d 10 00    	cmp    $0x108d84,%ebx
  1000e9:	74 25                	je     100110 <bread+0x60>
    if(b->dev == dev && b->sector == sector){
  1000eb:	3b 73 04             	cmp    0x4(%ebx),%esi
  1000ee:	66 90                	xchg   %ax,%ax
  1000f0:	75 ee                	jne    1000e0 <bread+0x30>
  1000f2:	3b 7b 08             	cmp    0x8(%ebx),%edi
  1000f5:	75 e9                	jne    1000e0 <bread+0x30>
      if(!(b->flags & B_BUSY)){
  1000f7:	8b 03                	mov    (%ebx),%eax
  1000f9:	a8 01                	test   $0x1,%al
  1000fb:	74 64                	je     100161 <bread+0xb1>
        b->flags |= B_BUSY;
        release(&bcache.lock);
        return b;
      }
      sleep(b, &bcache.lock);
  1000fd:	c7 44 24 04 60 78 10 	movl   $0x107860,0x4(%esp)
  100104:	00 
  100105:	89 1c 24             	mov    %ebx,(%esp)
  100108:	e8 63 30 00 00       	call   103170 <sleep>
  10010d:	eb bc                	jmp    1000cb <bread+0x1b>
  10010f:	90                   	nop
      goto loop;
    }
  }

  // Allocate fresh block.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
  100110:	8b 1d 90 8d 10 00    	mov    0x108d90,%ebx
  100116:	81 fb 84 8d 10 00    	cmp    $0x108d84,%ebx
  10011c:	75 0d                	jne    10012b <bread+0x7b>
  10011e:	eb 54                	jmp    100174 <bread+0xc4>
  100120:	8b 5b 0c             	mov    0xc(%ebx),%ebx
  100123:	81 fb 84 8d 10 00    	cmp    $0x108d84,%ebx
  100129:	74 49                	je     100174 <bread+0xc4>
    if((b->flags & B_BUSY) == 0){
  10012b:	f6 03 01             	testb  $0x1,(%ebx)
  10012e:	66 90                	xchg   %ax,%ax
  100130:	75 ee                	jne    100120 <bread+0x70>
      b->dev = dev;
  100132:	89 73 04             	mov    %esi,0x4(%ebx)
      b->sector = sector;
  100135:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = B_BUSY;
  100138:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
      release(&bcache.lock);
  10013e:	c7 04 24 60 78 10 00 	movl   $0x107860,(%esp)
  100145:	e8 86 39 00 00       	call   103ad0 <release>
bread(uint dev, uint sector)
{
  struct buf *b;

  b = bget(dev, sector);
  if(!(b->flags & B_VALID))
  10014a:	f6 03 02             	testb  $0x2,(%ebx)
  10014d:	75 08                	jne    100157 <bread+0xa7>
    iderw(b);
  10014f:	89 1c 24             	mov    %ebx,(%esp)
  100152:	e8 c9 1d 00 00       	call   101f20 <iderw>
  return b;
}
  100157:	83 c4 1c             	add    $0x1c,%esp
  10015a:	89 d8                	mov    %ebx,%eax
  10015c:	5b                   	pop    %ebx
  10015d:	5e                   	pop    %esi
  10015e:	5f                   	pop    %edi
  10015f:	5d                   	pop    %ebp
  100160:	c3                   	ret    
 loop:
  // Try for cached block.
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    if(b->dev == dev && b->sector == sector){
      if(!(b->flags & B_BUSY)){
        b->flags |= B_BUSY;
  100161:	83 c8 01             	or     $0x1,%eax
  100164:	89 03                	mov    %eax,(%ebx)
        release(&bcache.lock);
  100166:	c7 04 24 60 78 10 00 	movl   $0x107860,(%esp)
  10016d:	e8 5e 39 00 00       	call   103ad0 <release>
  100172:	eb d6                	jmp    10014a <bread+0x9a>
      b->flags = B_BUSY;
      release(&bcache.lock);
      return b;
    }
  }
  panic("bget: no buffers");
  100174:	c7 04 24 ae 64 10 00 	movl   $0x1064ae,(%esp)
  10017b:	e8 30 07 00 00       	call   1008b0 <panic>

00100180 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
  100180:	55                   	push   %ebp
  100181:	89 e5                	mov    %esp,%ebp
  100183:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
  100186:	c7 44 24 04 bf 64 10 	movl   $0x1064bf,0x4(%esp)
  10018d:	00 
  10018e:	c7 04 24 60 78 10 00 	movl   $0x107860,(%esp)
  100195:	e8 f6 37 00 00       	call   103990 <initlock>
  // head.next is most recently used.
  struct buf head;
} bcache;

void
binit(void)
  10019a:	ba 84 8d 10 00       	mov    $0x108d84,%edx
  10019f:	b8 94 78 10 00       	mov    $0x107894,%eax
  struct buf *b;

  initlock(&bcache.lock, "bcache");

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  1001a4:	c7 05 90 8d 10 00 84 	movl   $0x108d84,0x108d90
  1001ab:	8d 10 00 
  bcache.head.next = &bcache.head;
  1001ae:	c7 05 94 8d 10 00 84 	movl   $0x108d84,0x108d94
  1001b5:	8d 10 00 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
  1001b8:	89 50 10             	mov    %edx,0x10(%eax)
    b->prev = &bcache.head;
  1001bb:	c7 40 0c 84 8d 10 00 	movl   $0x108d84,0xc(%eax)
    b->dev = -1;
  1001c2:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    bcache.head.next->prev = b;
  1001c9:	8b 15 94 8d 10 00    	mov    0x108d94,%edx
  1001cf:	89 42 0c             	mov    %eax,0xc(%edx)
  initlock(&bcache.lock, "bcache");

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
  1001d2:	89 c2                	mov    %eax,%edx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    b->dev = -1;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  1001d4:	a3 94 8d 10 00       	mov    %eax,0x108d94
  initlock(&bcache.lock, "bcache");

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
  1001d9:	05 18 02 00 00       	add    $0x218,%eax
  1001de:	3d 84 8d 10 00       	cmp    $0x108d84,%eax
  1001e3:	75 d3                	jne    1001b8 <binit+0x38>
    b->prev = &bcache.head;
    b->dev = -1;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
  1001e5:	c9                   	leave  
  1001e6:	c3                   	ret    
  1001e7:	90                   	nop
  1001e8:	90                   	nop
  1001e9:	90                   	nop
  1001ea:	90                   	nop
  1001eb:	90                   	nop
  1001ec:	90                   	nop
  1001ed:	90                   	nop
  1001ee:	90                   	nop
  1001ef:	90                   	nop

001001f0 <consoleinit>:
  return n;
}

void
consoleinit(void)
{
  1001f0:	55                   	push   %ebp
  1001f1:	89 e5                	mov    %esp,%ebp
  1001f3:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
  1001f6:	c7 44 24 04 c6 64 10 	movl   $0x1064c6,0x4(%esp)
  1001fd:	00 
  1001fe:	c7 04 24 c0 77 10 00 	movl   $0x1077c0,(%esp)
  100205:	e8 86 37 00 00       	call   103990 <initlock>
  initlock(&input.lock, "input");
  10020a:	c7 44 24 04 ce 64 10 	movl   $0x1064ce,0x4(%esp)
  100211:	00 
  100212:	c7 04 24 a0 8f 10 00 	movl   $0x108fa0,(%esp)
  100219:	e8 72 37 00 00       	call   103990 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  picenable(IRQ_KBD);
  10021e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
consoleinit(void)
{
  initlock(&cons.lock, "console");
  initlock(&input.lock, "input");

  devsw[CONSOLE].write = consolewrite;
  100225:	c7 05 0c 9a 10 00 d0 	movl   $0x1003d0,0x109a0c
  10022c:	03 10 00 
  devsw[CONSOLE].read = consoleread;
  10022f:	c7 05 08 9a 10 00 20 	movl   $0x100620,0x109a08
  100236:	06 10 00 
  cons.locking = 1;
  100239:	c7 05 f4 77 10 00 01 	movl   $0x1,0x1077f4
  100240:	00 00 00 

  picenable(IRQ_KBD);
  100243:	e8 38 29 00 00       	call   102b80 <picenable>
  ioapicenable(IRQ_KBD, 0);
  100248:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10024f:	00 
  100250:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  100257:	e8 e4 1e 00 00       	call   102140 <ioapicenable>
}
  10025c:	c9                   	leave  
  10025d:	c3                   	ret    
  10025e:	66 90                	xchg   %ax,%ax

00100260 <consputc>:
  crt[pos] = ' ' | 0x0700;
}

void
consputc(int c)
{
  100260:	55                   	push   %ebp
  100261:	89 e5                	mov    %esp,%ebp
  100263:	57                   	push   %edi
  100264:	56                   	push   %esi
  100265:	89 c6                	mov    %eax,%esi
  100267:	53                   	push   %ebx
  100268:	83 ec 1c             	sub    $0x1c,%esp
  if(panicked){
  10026b:	83 3d a0 77 10 00 00 	cmpl   $0x0,0x1077a0
  100272:	74 03                	je     100277 <consputc+0x17>
}

static inline void
cli(void)
{
  asm volatile("cli");
  100274:	fa                   	cli    
  100275:	eb fe                	jmp    100275 <consputc+0x15>
    cli();
    for(;;)
      ;
  }

  if(c == BACKSPACE){
  100277:	3d 00 01 00 00       	cmp    $0x100,%eax
  10027c:	0f 84 a0 00 00 00    	je     100322 <consputc+0xc2>
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  100282:	89 04 24             	mov    %eax,(%esp)
  100285:	e8 56 4e 00 00       	call   1050e0 <uartputc>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  10028a:	b9 d4 03 00 00       	mov    $0x3d4,%ecx
  10028f:	b8 0e 00 00 00       	mov    $0xe,%eax
  100294:	89 ca                	mov    %ecx,%edx
  100296:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  100297:	bf d5 03 00 00       	mov    $0x3d5,%edi
  10029c:	89 fa                	mov    %edi,%edx
  10029e:	ec                   	in     (%dx),%al
{
  int pos;
  
  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
  10029f:	0f b6 d8             	movzbl %al,%ebx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  1002a2:	89 ca                	mov    %ecx,%edx
  1002a4:	c1 e3 08             	shl    $0x8,%ebx
  1002a7:	b8 0f 00 00 00       	mov    $0xf,%eax
  1002ac:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  1002ad:	89 fa                	mov    %edi,%edx
  1002af:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
  1002b0:	0f b6 c0             	movzbl %al,%eax
  1002b3:	09 c3                	or     %eax,%ebx

  if(c == '\n')
  1002b5:	83 fe 0a             	cmp    $0xa,%esi
  1002b8:	0f 84 ee 00 00 00    	je     1003ac <consputc+0x14c>
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
  1002be:	81 fe 00 01 00 00    	cmp    $0x100,%esi
  1002c4:	0f 84 cb 00 00 00    	je     100395 <consputc+0x135>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
  1002ca:	66 81 e6 ff 00       	and    $0xff,%si
  1002cf:	66 81 ce 00 07       	or     $0x700,%si
  1002d4:	66 89 b4 1b 00 80 0b 	mov    %si,0xb8000(%ebx,%ebx,1)
  1002db:	00 
  1002dc:	83 c3 01             	add    $0x1,%ebx
  
  if((pos/80) >= 24){  // Scroll up.
  1002df:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
  1002e5:	8d 8c 1b 00 80 0b 00 	lea    0xb8000(%ebx,%ebx,1),%ecx
  1002ec:	7f 5d                	jg     10034b <consputc+0xeb>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  1002ee:	be d4 03 00 00       	mov    $0x3d4,%esi
  1002f3:	b8 0e 00 00 00       	mov    $0xe,%eax
  1002f8:	89 f2                	mov    %esi,%edx
  1002fa:	ee                   	out    %al,(%dx)
  1002fb:	bf d5 03 00 00       	mov    $0x3d5,%edi
  100300:	89 d8                	mov    %ebx,%eax
  100302:	c1 f8 08             	sar    $0x8,%eax
  100305:	89 fa                	mov    %edi,%edx
  100307:	ee                   	out    %al,(%dx)
  100308:	b8 0f 00 00 00       	mov    $0xf,%eax
  10030d:	89 f2                	mov    %esi,%edx
  10030f:	ee                   	out    %al,(%dx)
  100310:	89 d8                	mov    %ebx,%eax
  100312:	89 fa                	mov    %edi,%edx
  100314:	ee                   	out    %al,(%dx)
  
  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
  100315:	66 c7 01 20 07       	movw   $0x720,(%ecx)
  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
}
  10031a:	83 c4 1c             	add    $0x1c,%esp
  10031d:	5b                   	pop    %ebx
  10031e:	5e                   	pop    %esi
  10031f:	5f                   	pop    %edi
  100320:	5d                   	pop    %ebp
  100321:	c3                   	ret    
    for(;;)
      ;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  100322:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  100329:	e8 b2 4d 00 00       	call   1050e0 <uartputc>
  10032e:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  100335:	e8 a6 4d 00 00       	call   1050e0 <uartputc>
  10033a:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  100341:	e8 9a 4d 00 00       	call   1050e0 <uartputc>
  100346:	e9 3f ff ff ff       	jmp    10028a <consputc+0x2a>
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
  
  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
    pos -= 80;
  10034b:	83 eb 50             	sub    $0x50,%ebx
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
  
  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
  10034e:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
  100355:	00 
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
  100356:	8d b4 1b 00 80 0b 00 	lea    0xb8000(%ebx,%ebx,1),%esi
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
  
  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
  10035d:	c7 44 24 04 a0 80 0b 	movl   $0xb80a0,0x4(%esp)
  100364:	00 
  100365:	c7 04 24 00 80 0b 00 	movl   $0xb8000,(%esp)
  10036c:	e8 cf 38 00 00       	call   103c40 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
  100371:	b8 80 07 00 00       	mov    $0x780,%eax
  100376:	29 d8                	sub    %ebx,%eax
  100378:	01 c0                	add    %eax,%eax
  10037a:	89 44 24 08          	mov    %eax,0x8(%esp)
  10037e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  100385:	00 
  100386:	89 34 24             	mov    %esi,(%esp)
  100389:	e8 32 38 00 00       	call   103bc0 <memset>
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
}

void
consputc(int c)
  10038e:	89 f1                	mov    %esi,%ecx
  100390:	e9 59 ff ff ff       	jmp    1002ee <consputc+0x8e>
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
  100395:	85 db                	test   %ebx,%ebx
  100397:	8d 8c 1b 00 80 0b 00 	lea    0xb8000(%ebx,%ebx,1),%ecx
  10039e:	0f 8e 4a ff ff ff    	jle    1002ee <consputc+0x8e>
  1003a4:	83 eb 01             	sub    $0x1,%ebx
  1003a7:	e9 33 ff ff ff       	jmp    1002df <consputc+0x7f>
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  1003ac:	89 da                	mov    %ebx,%edx
  1003ae:	89 d8                	mov    %ebx,%eax
  1003b0:	b9 50 00 00 00       	mov    $0x50,%ecx
  1003b5:	83 c3 50             	add    $0x50,%ebx
  1003b8:	c1 fa 1f             	sar    $0x1f,%edx
  1003bb:	f7 f9                	idiv   %ecx
  1003bd:	29 d3                	sub    %edx,%ebx
  1003bf:	e9 1b ff ff ff       	jmp    1002df <consputc+0x7f>
  1003c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1003ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

001003d0 <consolewrite>:
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
  1003d0:	55                   	push   %ebp
  1003d1:	89 e5                	mov    %esp,%ebp
  1003d3:	57                   	push   %edi
  1003d4:	56                   	push   %esi
  1003d5:	53                   	push   %ebx
  1003d6:	83 ec 1c             	sub    $0x1c,%esp
  int i;

  iunlock(ip);
  1003d9:	8b 45 08             	mov    0x8(%ebp),%eax
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
  1003dc:	8b 75 10             	mov    0x10(%ebp),%esi
  1003df:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  iunlock(ip);
  1003e2:	89 04 24             	mov    %eax,(%esp)
  1003e5:	e8 66 13 00 00       	call   101750 <iunlock>
  acquire(&cons.lock);
  1003ea:	c7 04 24 c0 77 10 00 	movl   $0x1077c0,(%esp)
  1003f1:	e8 2a 37 00 00       	call   103b20 <acquire>
  for(i = 0; i < n; i++)
  1003f6:	85 f6                	test   %esi,%esi
  1003f8:	7e 16                	jle    100410 <consolewrite+0x40>
  1003fa:	31 db                	xor    %ebx,%ebx
  1003fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    consputc(buf[i] & 0xff);
  100400:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
  100404:	83 c3 01             	add    $0x1,%ebx
    consputc(buf[i] & 0xff);
  100407:	e8 54 fe ff ff       	call   100260 <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
  10040c:	39 de                	cmp    %ebx,%esi
  10040e:	7f f0                	jg     100400 <consolewrite+0x30>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
  100410:	c7 04 24 c0 77 10 00 	movl   $0x1077c0,(%esp)
  100417:	e8 b4 36 00 00       	call   103ad0 <release>
  ilock(ip);
  10041c:	8b 45 08             	mov    0x8(%ebp),%eax
  10041f:	89 04 24             	mov    %eax,(%esp)
  100422:	e8 69 17 00 00       	call   101b90 <ilock>

  return n;
}
  100427:	83 c4 1c             	add    $0x1c,%esp
  10042a:	89 f0                	mov    %esi,%eax
  10042c:	5b                   	pop    %ebx
  10042d:	5e                   	pop    %esi
  10042e:	5f                   	pop    %edi
  10042f:	5d                   	pop    %ebp
  100430:	c3                   	ret    
  100431:	eb 0d                	jmp    100440 <printint>
  100433:	90                   	nop
  100434:	90                   	nop
  100435:	90                   	nop
  100436:	90                   	nop
  100437:	90                   	nop
  100438:	90                   	nop
  100439:	90                   	nop
  10043a:	90                   	nop
  10043b:	90                   	nop
  10043c:	90                   	nop
  10043d:	90                   	nop
  10043e:	90                   	nop
  10043f:	90                   	nop

00100440 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sgn)
{
  100440:	55                   	push   %ebp
  100441:	89 e5                	mov    %esp,%ebp
  100443:	57                   	push   %edi
  100444:	56                   	push   %esi
  100445:	89 d6                	mov    %edx,%esi
  100447:	53                   	push   %ebx
  100448:	83 ec 1c             	sub    $0x1c,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i = 0, neg = 0;
  uint x;

  if(sgn && xx < 0){
  10044b:	85 c9                	test   %ecx,%ecx
  10044d:	74 04                	je     100453 <printint+0x13>
  10044f:	85 c0                	test   %eax,%eax
  100451:	78 55                	js     1004a8 <printint+0x68>
    neg = 1;
    x = -xx;
  } else
    x = xx;
  100453:	31 ff                	xor    %edi,%edi
  100455:	31 c9                	xor    %ecx,%ecx
  100457:	8d 5d d8             	lea    -0x28(%ebp),%ebx
  10045a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  do{
    buf[i++] = digits[x % base];
  100460:	31 d2                	xor    %edx,%edx
  100462:	f7 f6                	div    %esi
  100464:	0f b6 92 ee 64 10 00 	movzbl 0x1064ee(%edx),%edx
  10046b:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  10046e:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
  100471:	85 c0                	test   %eax,%eax
  100473:	75 eb                	jne    100460 <printint+0x20>
  if(neg)
  100475:	85 ff                	test   %edi,%edi
  100477:	74 08                	je     100481 <printint+0x41>
    buf[i++] = '-';
  100479:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
  10047e:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
  100481:	8d 71 ff             	lea    -0x1(%ecx),%esi
  100484:	01 f3                	add    %esi,%ebx
  100486:	66 90                	xchg   %ax,%ax
    consputc(buf[i]);
  100488:	0f be 03             	movsbl (%ebx),%eax
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
  10048b:	83 ee 01             	sub    $0x1,%esi
  10048e:	83 eb 01             	sub    $0x1,%ebx
    consputc(buf[i]);
  100491:	e8 ca fd ff ff       	call   100260 <consputc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
  100496:	83 fe ff             	cmp    $0xffffffff,%esi
  100499:	75 ed                	jne    100488 <printint+0x48>
    consputc(buf[i]);
}
  10049b:	83 c4 1c             	add    $0x1c,%esp
  10049e:	5b                   	pop    %ebx
  10049f:	5e                   	pop    %esi
  1004a0:	5f                   	pop    %edi
  1004a1:	5d                   	pop    %ebp
  1004a2:	c3                   	ret    
  1004a3:	90                   	nop
  1004a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int i = 0, neg = 0;
  uint x;

  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  1004a8:	f7 d8                	neg    %eax
  1004aa:	bf 01 00 00 00       	mov    $0x1,%edi
  1004af:	eb a4                	jmp    100455 <printint+0x15>
  1004b1:	eb 0d                	jmp    1004c0 <cprintf>
  1004b3:	90                   	nop
  1004b4:	90                   	nop
  1004b5:	90                   	nop
  1004b6:	90                   	nop
  1004b7:	90                   	nop
  1004b8:	90                   	nop
  1004b9:	90                   	nop
  1004ba:	90                   	nop
  1004bb:	90                   	nop
  1004bc:	90                   	nop
  1004bd:	90                   	nop
  1004be:	90                   	nop
  1004bf:	90                   	nop

001004c0 <cprintf>:
}

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
  1004c0:	55                   	push   %ebp
  1004c1:	89 e5                	mov    %esp,%ebp
  1004c3:	57                   	push   %edi
  1004c4:	56                   	push   %esi
  1004c5:	53                   	push   %ebx
  1004c6:	83 ec 2c             	sub    $0x2c,%esp
  int i, c, state, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
  1004c9:	8b 3d f4 77 10 00    	mov    0x1077f4,%edi
  if(locking)
  1004cf:	85 ff                	test   %edi,%edi
  1004d1:	0f 85 29 01 00 00    	jne    100600 <cprintf+0x140>
    acquire(&cons.lock);

  argp = (uint*)(void*)(&fmt + 1);
  state = 0;
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
  1004d7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  1004da:	0f b6 01             	movzbl (%ecx),%eax
  1004dd:	85 c0                	test   %eax,%eax
  1004df:	0f 84 93 00 00 00    	je     100578 <cprintf+0xb8>

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);

  argp = (uint*)(void*)(&fmt + 1);
  1004e5:	8d 75 0c             	lea    0xc(%ebp),%esi
  1004e8:	31 db                	xor    %ebx,%ebx
  1004ea:	eb 3f                	jmp    10052b <cprintf+0x6b>
  1004ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
  1004f0:	83 fa 25             	cmp    $0x25,%edx
  1004f3:	0f 84 b7 00 00 00    	je     1005b0 <cprintf+0xf0>
  1004f9:	83 fa 64             	cmp    $0x64,%edx
  1004fc:	0f 84 8e 00 00 00    	je     100590 <cprintf+0xd0>
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
  100502:	b8 25 00 00 00       	mov    $0x25,%eax
  100507:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  10050a:	e8 51 fd ff ff       	call   100260 <consputc>
      consputc(c);
  10050f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  100512:	89 d0                	mov    %edx,%eax
  100514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100518:	e8 43 fd ff ff       	call   100260 <consputc>
  10051d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if(locking)
    acquire(&cons.lock);

  argp = (uint*)(void*)(&fmt + 1);
  state = 0;
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
  100520:	83 c3 01             	add    $0x1,%ebx
  100523:	0f b6 04 19          	movzbl (%ecx,%ebx,1),%eax
  100527:	85 c0                	test   %eax,%eax
  100529:	74 4d                	je     100578 <cprintf+0xb8>
    if(c != '%'){
  10052b:	83 f8 25             	cmp    $0x25,%eax
  10052e:	75 e8                	jne    100518 <cprintf+0x58>
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
  100530:	83 c3 01             	add    $0x1,%ebx
  100533:	0f b6 14 19          	movzbl (%ecx,%ebx,1),%edx
    if(c == 0)
  100537:	85 d2                	test   %edx,%edx
  100539:	74 3d                	je     100578 <cprintf+0xb8>
      break;
    switch(c){
  10053b:	83 fa 70             	cmp    $0x70,%edx
  10053e:	74 12                	je     100552 <cprintf+0x92>
  100540:	7e ae                	jle    1004f0 <cprintf+0x30>
  100542:	83 fa 73             	cmp    $0x73,%edx
  100545:	8d 76 00             	lea    0x0(%esi),%esi
  100548:	74 7e                	je     1005c8 <cprintf+0x108>
  10054a:	83 fa 78             	cmp    $0x78,%edx
  10054d:	8d 76 00             	lea    0x0(%esi),%esi
  100550:	75 b0                	jne    100502 <cprintf+0x42>
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
  100552:	8b 06                	mov    (%esi),%eax
  100554:	31 c9                	xor    %ecx,%ecx
  100556:	ba 10 00 00 00       	mov    $0x10,%edx
  if(locking)
    acquire(&cons.lock);

  argp = (uint*)(void*)(&fmt + 1);
  state = 0;
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
  10055b:	83 c3 01             	add    $0x1,%ebx
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
  10055e:	83 c6 04             	add    $0x4,%esi
  100561:	e8 da fe ff ff       	call   100440 <printint>
  100566:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if(locking)
    acquire(&cons.lock);

  argp = (uint*)(void*)(&fmt + 1);
  state = 0;
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
  100569:	0f b6 04 19          	movzbl (%ecx,%ebx,1),%eax
  10056d:	85 c0                	test   %eax,%eax
  10056f:	75 ba                	jne    10052b <cprintf+0x6b>
  100571:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      consputc(c);
      break;
    }
  }

  if(locking)
  100578:	85 ff                	test   %edi,%edi
  10057a:	74 0c                	je     100588 <cprintf+0xc8>
    release(&cons.lock);
  10057c:	c7 04 24 c0 77 10 00 	movl   $0x1077c0,(%esp)
  100583:	e8 48 35 00 00       	call   103ad0 <release>
}
  100588:	83 c4 2c             	add    $0x2c,%esp
  10058b:	5b                   	pop    %ebx
  10058c:	5e                   	pop    %esi
  10058d:	5f                   	pop    %edi
  10058e:	5d                   	pop    %ebp
  10058f:	c3                   	ret    
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
    case 'd':
      printint(*argp++, 10, 1);
  100590:	8b 06                	mov    (%esi),%eax
  100592:	b9 01 00 00 00       	mov    $0x1,%ecx
  100597:	ba 0a 00 00 00       	mov    $0xa,%edx
  10059c:	83 c6 04             	add    $0x4,%esi
  10059f:	e8 9c fe ff ff       	call   100440 <printint>
  1005a4:	8b 4d 08             	mov    0x8(%ebp),%ecx
      break;
  1005a7:	e9 74 ff ff ff       	jmp    100520 <cprintf+0x60>
  1005ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
  1005b0:	b8 25 00 00 00       	mov    $0x25,%eax
  1005b5:	e8 a6 fc ff ff       	call   100260 <consputc>
  1005ba:	8b 4d 08             	mov    0x8(%ebp),%ecx
      break;
  1005bd:	e9 5e ff ff ff       	jmp    100520 <cprintf+0x60>
  1005c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
  1005c8:	8b 16                	mov    (%esi),%edx
  1005ca:	83 c6 04             	add    $0x4,%esi
  1005cd:	85 d2                	test   %edx,%edx
  1005cf:	74 47                	je     100618 <cprintf+0x158>
        s = "(null)";
      for(; *s; s++)
  1005d1:	0f b6 02             	movzbl (%edx),%eax
  1005d4:	84 c0                	test   %al,%al
  1005d6:	0f 84 44 ff ff ff    	je     100520 <cprintf+0x60>
  1005dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        consputc(*s);
  1005e0:	0f be c0             	movsbl %al,%eax
  1005e3:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  1005e6:	e8 75 fc ff ff       	call   100260 <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
  1005eb:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  1005ee:	83 c2 01             	add    $0x1,%edx
  1005f1:	0f b6 02             	movzbl (%edx),%eax
  1005f4:	84 c0                	test   %al,%al
  1005f6:	75 e8                	jne    1005e0 <cprintf+0x120>
  1005f8:	e9 20 ff ff ff       	jmp    10051d <cprintf+0x5d>
  1005fd:	8d 76 00             	lea    0x0(%esi),%esi
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);
  100600:	c7 04 24 c0 77 10 00 	movl   $0x1077c0,(%esp)
  100607:	e8 14 35 00 00       	call   103b20 <acquire>
  10060c:	e9 c6 fe ff ff       	jmp    1004d7 <cprintf+0x17>
  100611:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
  100618:	ba d4 64 10 00       	mov    $0x1064d4,%edx
  10061d:	eb b2                	jmp    1005d1 <cprintf+0x111>
  10061f:	90                   	nop

00100620 <consoleread>:
  release(&input.lock);
}

int
consoleread(struct inode *ip, char *dst, int n)
{
  100620:	55                   	push   %ebp
  100621:	89 e5                	mov    %esp,%ebp
  100623:	57                   	push   %edi
  100624:	56                   	push   %esi
  100625:	53                   	push   %ebx
  100626:	83 ec 3c             	sub    $0x3c,%esp
  100629:	8b 5d 10             	mov    0x10(%ebp),%ebx
  10062c:	8b 7d 08             	mov    0x8(%ebp),%edi
  10062f:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
  100632:	89 3c 24             	mov    %edi,(%esp)
  100635:	e8 16 11 00 00       	call   101750 <iunlock>
  target = n;
  10063a:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  acquire(&input.lock);
  10063d:	c7 04 24 a0 8f 10 00 	movl   $0x108fa0,(%esp)
  100644:	e8 d7 34 00 00       	call   103b20 <acquire>
  while(n > 0){
  100649:	85 db                	test   %ebx,%ebx
  10064b:	7f 2c                	jg     100679 <consoleread+0x59>
  10064d:	e9 c0 00 00 00       	jmp    100712 <consoleread+0xf2>
  100652:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(input.r == input.w){
      if(proc->killed){
  100658:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  10065e:	8b 40 24             	mov    0x24(%eax),%eax
  100661:	85 c0                	test   %eax,%eax
  100663:	75 5b                	jne    1006c0 <consoleread+0xa0>
        release(&input.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &input.lock);
  100665:	c7 44 24 04 a0 8f 10 	movl   $0x108fa0,0x4(%esp)
  10066c:	00 
  10066d:	c7 04 24 54 90 10 00 	movl   $0x109054,(%esp)
  100674:	e8 f7 2a 00 00       	call   103170 <sleep>

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
  100679:	a1 54 90 10 00       	mov    0x109054,%eax
  10067e:	3b 05 58 90 10 00    	cmp    0x109058,%eax
  100684:	74 d2                	je     100658 <consoleread+0x38>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &input.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
  100686:	89 c2                	mov    %eax,%edx
  100688:	83 e2 7f             	and    $0x7f,%edx
  10068b:	0f b6 8a d4 8f 10 00 	movzbl 0x108fd4(%edx),%ecx
  100692:	0f be d1             	movsbl %cl,%edx
  100695:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  100698:	8d 50 01             	lea    0x1(%eax),%edx
    if(c == C('D')){  // EOF
  10069b:	83 7d d4 04          	cmpl   $0x4,-0x2c(%ebp)
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &input.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
  10069f:	89 15 54 90 10 00    	mov    %edx,0x109054
    if(c == C('D')){  // EOF
  1006a5:	74 3a                	je     1006e1 <consoleread+0xc1>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
  1006a7:	88 0e                	mov    %cl,(%esi)
    --n;
  1006a9:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
  1006ac:	83 7d d4 0a          	cmpl   $0xa,-0x2c(%ebp)
  1006b0:	74 39                	je     1006eb <consoleread+0xcb>
  int c;

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
  1006b2:	85 db                	test   %ebx,%ebx
  1006b4:	7e 35                	jle    1006eb <consoleread+0xcb>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
  1006b6:	83 c6 01             	add    $0x1,%esi
  1006b9:	eb be                	jmp    100679 <consoleread+0x59>
  1006bb:	90                   	nop
  1006bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
      if(proc->killed){
        release(&input.lock);
  1006c0:	c7 04 24 a0 8f 10 00 	movl   $0x108fa0,(%esp)
  1006c7:	e8 04 34 00 00       	call   103ad0 <release>
        ilock(ip);
  1006cc:	89 3c 24             	mov    %edi,(%esp)
  1006cf:	e8 bc 14 00 00       	call   101b90 <ilock>
  }
  release(&input.lock);
  ilock(ip);

  return target - n;
}
  1006d4:	83 c4 3c             	add    $0x3c,%esp
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
      if(proc->killed){
        release(&input.lock);
        ilock(ip);
  1006d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&input.lock);
  ilock(ip);

  return target - n;
}
  1006dc:	5b                   	pop    %ebx
  1006dd:	5e                   	pop    %esi
  1006de:	5f                   	pop    %edi
  1006df:	5d                   	pop    %ebp
  1006e0:	c3                   	ret    
      }
      sleep(&input.r, &input.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
  1006e1:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
  1006e4:	76 05                	jbe    1006eb <consoleread+0xcb>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
  1006e6:	a3 54 90 10 00       	mov    %eax,0x109054
  1006eb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1006ee:	29 d8                	sub    %ebx,%eax
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&input.lock);
  1006f0:	c7 04 24 a0 8f 10 00 	movl   $0x108fa0,(%esp)
  1006f7:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1006fa:	e8 d1 33 00 00       	call   103ad0 <release>
  ilock(ip);
  1006ff:	89 3c 24             	mov    %edi,(%esp)
  100702:	e8 89 14 00 00       	call   101b90 <ilock>
  100707:	8b 45 e0             	mov    -0x20(%ebp),%eax

  return target - n;
}
  10070a:	83 c4 3c             	add    $0x3c,%esp
  10070d:	5b                   	pop    %ebx
  10070e:	5e                   	pop    %esi
  10070f:	5f                   	pop    %edi
  100710:	5d                   	pop    %ebp
  100711:	c3                   	ret    
  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
      if(proc->killed){
  100712:	31 c0                	xor    %eax,%eax
  100714:	eb da                	jmp    1006f0 <consoleread+0xd0>
  100716:	8d 76 00             	lea    0x0(%esi),%esi
  100719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100720 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
  100720:	55                   	push   %ebp
  100721:	89 e5                	mov    %esp,%ebp
  100723:	57                   	push   %edi
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
  100724:	bf d0 8f 10 00       	mov    $0x108fd0,%edi

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
  100729:	56                   	push   %esi
  10072a:	53                   	push   %ebx
  10072b:	83 ec 1c             	sub    $0x1c,%esp
  10072e:	8b 75 08             	mov    0x8(%ebp),%esi
  int c;

  acquire(&input.lock);
  100731:	c7 04 24 a0 8f 10 00 	movl   $0x108fa0,(%esp)
  100738:	e8 e3 33 00 00       	call   103b20 <acquire>
  10073d:	8d 76 00             	lea    0x0(%esi),%esi
  while((c = getc()) >= 0){
  100740:	ff d6                	call   *%esi
  100742:	85 c0                	test   %eax,%eax
  100744:	89 c3                	mov    %eax,%ebx
  100746:	0f 88 9c 00 00 00    	js     1007e8 <consoleintr+0xc8>
    switch(c){
  10074c:	83 fb 10             	cmp    $0x10,%ebx
  10074f:	90                   	nop
  100750:	0f 84 1a 01 00 00    	je     100870 <consoleintr+0x150>
  100756:	0f 8f a4 00 00 00    	jg     100800 <consoleintr+0xe0>
  10075c:	83 fb 08             	cmp    $0x8,%ebx
  10075f:	90                   	nop
  100760:	0f 84 a8 00 00 00    	je     10080e <consoleintr+0xee>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
  100766:	85 db                	test   %ebx,%ebx
  100768:	74 d6                	je     100740 <consoleintr+0x20>
  10076a:	a1 5c 90 10 00       	mov    0x10905c,%eax
  10076f:	89 c2                	mov    %eax,%edx
  100771:	2b 15 54 90 10 00    	sub    0x109054,%edx
  100777:	83 fa 7f             	cmp    $0x7f,%edx
  10077a:	77 c4                	ja     100740 <consoleintr+0x20>
        c = (c == '\r') ? '\n' : c;
  10077c:	83 fb 0d             	cmp    $0xd,%ebx
  10077f:	0f 84 f8 00 00 00    	je     10087d <consoleintr+0x15d>
        input.buf[input.e++ % INPUT_BUF] = c;
  100785:	89 c2                	mov    %eax,%edx
  100787:	83 c0 01             	add    $0x1,%eax
  10078a:	83 e2 7f             	and    $0x7f,%edx
  10078d:	88 5c 17 04          	mov    %bl,0x4(%edi,%edx,1)
  100791:	a3 5c 90 10 00       	mov    %eax,0x10905c
        consputc(c);
  100796:	89 d8                	mov    %ebx,%eax
  100798:	e8 c3 fa ff ff       	call   100260 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
  10079d:	83 fb 04             	cmp    $0x4,%ebx
  1007a0:	0f 84 f3 00 00 00    	je     100899 <consoleintr+0x179>
  1007a6:	83 fb 0a             	cmp    $0xa,%ebx
  1007a9:	0f 84 ea 00 00 00    	je     100899 <consoleintr+0x179>
  1007af:	8b 15 54 90 10 00    	mov    0x109054,%edx
  1007b5:	a1 5c 90 10 00       	mov    0x10905c,%eax
  1007ba:	83 ea 80             	sub    $0xffffff80,%edx
  1007bd:	39 d0                	cmp    %edx,%eax
  1007bf:	0f 85 7b ff ff ff    	jne    100740 <consoleintr+0x20>
          input.w = input.e;
  1007c5:	a3 58 90 10 00       	mov    %eax,0x109058
          wakeup(&input.r);
  1007ca:	c7 04 24 54 90 10 00 	movl   $0x109054,(%esp)
  1007d1:	e8 7a 28 00 00       	call   103050 <wakeup>
consoleintr(int (*getc)(void))
{
  int c;

  acquire(&input.lock);
  while((c = getc()) >= 0){
  1007d6:	ff d6                	call   *%esi
  1007d8:	85 c0                	test   %eax,%eax
  1007da:	89 c3                	mov    %eax,%ebx
  1007dc:	0f 89 6a ff ff ff    	jns    10074c <consoleintr+0x2c>
  1007e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        }
      }
      break;
    }
  }
  release(&input.lock);
  1007e8:	c7 45 08 a0 8f 10 00 	movl   $0x108fa0,0x8(%ebp)
}
  1007ef:	83 c4 1c             	add    $0x1c,%esp
  1007f2:	5b                   	pop    %ebx
  1007f3:	5e                   	pop    %esi
  1007f4:	5f                   	pop    %edi
  1007f5:	5d                   	pop    %ebp
        }
      }
      break;
    }
  }
  release(&input.lock);
  1007f6:	e9 d5 32 00 00       	jmp    103ad0 <release>
  1007fb:	90                   	nop
  1007fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int c;

  acquire(&input.lock);
  while((c = getc()) >= 0){
    switch(c){
  100800:	83 fb 15             	cmp    $0x15,%ebx
  100803:	74 57                	je     10085c <consoleintr+0x13c>
  100805:	83 fb 7f             	cmp    $0x7f,%ebx
  100808:	0f 85 58 ff ff ff    	jne    100766 <consoleintr+0x46>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
  10080e:	a1 5c 90 10 00       	mov    0x10905c,%eax
  100813:	3b 05 58 90 10 00    	cmp    0x109058,%eax
  100819:	0f 84 21 ff ff ff    	je     100740 <consoleintr+0x20>
        input.e--;
  10081f:	83 e8 01             	sub    $0x1,%eax
  100822:	a3 5c 90 10 00       	mov    %eax,0x10905c
        consputc(BACKSPACE);
  100827:	b8 00 01 00 00       	mov    $0x100,%eax
  10082c:	e8 2f fa ff ff       	call   100260 <consputc>
  100831:	e9 0a ff ff ff       	jmp    100740 <consoleintr+0x20>
  100836:	66 90                	xchg   %ax,%ax
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
  100838:	83 e8 01             	sub    $0x1,%eax
  10083b:	89 c2                	mov    %eax,%edx
  10083d:	83 e2 7f             	and    $0x7f,%edx
  100840:	80 ba d4 8f 10 00 0a 	cmpb   $0xa,0x108fd4(%edx)
  100847:	0f 84 f3 fe ff ff    	je     100740 <consoleintr+0x20>
        input.e--;
  10084d:	a3 5c 90 10 00       	mov    %eax,0x10905c
        consputc(BACKSPACE);
  100852:	b8 00 01 00 00       	mov    $0x100,%eax
  100857:	e8 04 fa ff ff       	call   100260 <consputc>
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
  10085c:	a1 5c 90 10 00       	mov    0x10905c,%eax
  100861:	3b 05 58 90 10 00    	cmp    0x109058,%eax
  100867:	75 cf                	jne    100838 <consoleintr+0x118>
  100869:	e9 d2 fe ff ff       	jmp    100740 <consoleintr+0x20>
  10086e:	66 90                	xchg   %ax,%ax

  acquire(&input.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      procdump();
  100870:	e8 2b 30 00 00       	call   1038a0 <procdump>
  100875:	8d 76 00             	lea    0x0(%esi),%esi
      break;
  100878:	e9 c3 fe ff ff       	jmp    100740 <consoleintr+0x20>
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
  10087d:	89 c2                	mov    %eax,%edx
  10087f:	83 c0 01             	add    $0x1,%eax
  100882:	83 e2 7f             	and    $0x7f,%edx
  100885:	c6 44 17 04 0a       	movb   $0xa,0x4(%edi,%edx,1)
  10088a:	a3 5c 90 10 00       	mov    %eax,0x10905c
        consputc(c);
  10088f:	b8 0a 00 00 00       	mov    $0xa,%eax
  100894:	e8 c7 f9 ff ff       	call   100260 <consputc>
  100899:	a1 5c 90 10 00       	mov    0x10905c,%eax
  10089e:	e9 22 ff ff ff       	jmp    1007c5 <consoleintr+0xa5>
  1008a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1008a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001008b0 <panic>:
    release(&cons.lock);
}

void
panic(char *s)
{
  1008b0:	55                   	push   %ebp
  1008b1:	89 e5                	mov    %esp,%ebp
  1008b3:	56                   	push   %esi
  1008b4:	53                   	push   %ebx
  1008b5:	83 ec 40             	sub    $0x40,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
  1008b8:	fa                   	cli    
  int i;
  uint pcs[10];
  
  cli();
  cons.locking = 0;
  cprintf("cpu%d: panic: ", cpu->id);
  1008b9:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  1008bf:	8d 75 d0             	lea    -0x30(%ebp),%esi
  1008c2:	31 db                	xor    %ebx,%ebx
{
  int i;
  uint pcs[10];
  
  cli();
  cons.locking = 0;
  1008c4:	c7 05 f4 77 10 00 00 	movl   $0x0,0x1077f4
  1008cb:	00 00 00 
  cprintf("cpu%d: panic: ", cpu->id);
  1008ce:	0f b6 00             	movzbl (%eax),%eax
  1008d1:	c7 04 24 db 64 10 00 	movl   $0x1064db,(%esp)
  1008d8:	89 44 24 04          	mov    %eax,0x4(%esp)
  1008dc:	e8 df fb ff ff       	call   1004c0 <cprintf>
  cprintf(s);
  1008e1:	8b 45 08             	mov    0x8(%ebp),%eax
  1008e4:	89 04 24             	mov    %eax,(%esp)
  1008e7:	e8 d4 fb ff ff       	call   1004c0 <cprintf>
  cprintf("\n");
  1008ec:	c7 04 24 16 69 10 00 	movl   $0x106916,(%esp)
  1008f3:	e8 c8 fb ff ff       	call   1004c0 <cprintf>
  getcallerpcs(&s, pcs);
  1008f8:	8d 45 08             	lea    0x8(%ebp),%eax
  1008fb:	89 74 24 04          	mov    %esi,0x4(%esp)
  1008ff:	89 04 24             	mov    %eax,(%esp)
  100902:	e8 a9 30 00 00       	call   1039b0 <getcallerpcs>
  100907:	90                   	nop
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
  100908:	8b 04 9e             	mov    (%esi,%ebx,4),%eax
  cons.locking = 0;
  cprintf("cpu%d: panic: ", cpu->id);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
  10090b:	83 c3 01             	add    $0x1,%ebx
    cprintf(" %p", pcs[i]);
  10090e:	c7 04 24 ea 64 10 00 	movl   $0x1064ea,(%esp)
  100915:	89 44 24 04          	mov    %eax,0x4(%esp)
  100919:	e8 a2 fb ff ff       	call   1004c0 <cprintf>
  cons.locking = 0;
  cprintf("cpu%d: panic: ", cpu->id);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
  10091e:	83 fb 0a             	cmp    $0xa,%ebx
  100921:	75 e5                	jne    100908 <panic+0x58>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
  100923:	c7 05 a0 77 10 00 01 	movl   $0x1,0x1077a0
  10092a:	00 00 00 
  10092d:	eb fe                	jmp    10092d <panic+0x7d>
  10092f:	90                   	nop

00100930 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
  100930:	55                   	push   %ebp
  100931:	89 e5                	mov    %esp,%ebp
  100933:	57                   	push   %edi
  100934:	56                   	push   %esi
  100935:	53                   	push   %ebx
  100936:	81 ec ac 00 00 00    	sub    $0xac,%esp
  pde_t *pgdir, *oldpgdir;

  pgdir = 0;
  sz = 0;

  if((ip = namei(path)) == 0)
  10093c:	8b 45 08             	mov    0x8(%ebp),%eax
  10093f:	89 04 24             	mov    %eax,(%esp)
  100942:	e8 e9 14 00 00       	call   101e30 <namei>
  100947:	89 c7                	mov    %eax,%edi
  100949:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10094e:	85 ff                	test   %edi,%edi
  100950:	0f 84 1a 01 00 00    	je     100a70 <exec+0x140>
    return -1;
  ilock(ip);
  100956:	89 3c 24             	mov    %edi,(%esp)
  100959:	e8 32 12 00 00       	call   101b90 <ilock>

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
  10095e:	8d 45 94             	lea    -0x6c(%ebp),%eax
  100961:	c7 44 24 0c 34 00 00 	movl   $0x34,0xc(%esp)
  100968:	00 
  100969:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  100970:	00 
  100971:	89 44 24 04          	mov    %eax,0x4(%esp)
  100975:	89 3c 24             	mov    %edi,(%esp)
  100978:	e8 d3 09 00 00       	call   101350 <readi>
  10097d:	83 f8 33             	cmp    $0x33,%eax
  100980:	0f 86 dd 00 00 00    	jbe    100a63 <exec+0x133>
    goto bad;
  if(elf.magic != ELF_MAGIC)
  100986:	81 7d 94 7f 45 4c 46 	cmpl   $0x464c457f,-0x6c(%ebp)
  10098d:	0f 85 d0 00 00 00    	jne    100a63 <exec+0x133>
  100993:	90                   	nop
  100994:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    goto bad;

  if(!(pgdir = setupkvm()))
  100998:	e8 c3 54 00 00       	call   105e60 <setupkvm>
  10099d:	85 c0                	test   %eax,%eax
  10099f:	89 45 80             	mov    %eax,-0x80(%ebp)
  1009a2:	0f 84 bb 00 00 00    	je     100a63 <exec+0x133>
    goto bad;

  // Load program into memory.
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  1009a8:	66 83 7d c0 00       	cmpw   $0x0,-0x40(%ebp)
  1009ad:	8b 75 b0             	mov    -0x50(%ebp),%esi
  1009b0:	0f 84 0d 03 00 00    	je     100cc3 <exec+0x393>
  1009b6:	c7 45 84 00 00 00 00 	movl   $0x0,-0x7c(%ebp)
  1009bd:	31 db                	xor    %ebx,%ebx
  1009bf:	eb 19                	jmp    1009da <exec+0xaa>
  1009c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1009c8:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
  1009cc:	83 c3 01             	add    $0x1,%ebx
  1009cf:	39 d8                	cmp    %ebx,%eax
  1009d1:	0f 8e a9 00 00 00    	jle    100a80 <exec+0x150>
  1009d7:	83 c6 20             	add    $0x20,%esi
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
  1009da:	8d 55 c8             	lea    -0x38(%ebp),%edx
  1009dd:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
  1009e4:	00 
  1009e5:	89 74 24 08          	mov    %esi,0x8(%esp)
  1009e9:	89 54 24 04          	mov    %edx,0x4(%esp)
  1009ed:	89 3c 24             	mov    %edi,(%esp)
  1009f0:	e8 5b 09 00 00       	call   101350 <readi>
  1009f5:	83 f8 20             	cmp    $0x20,%eax
  1009f8:	75 5e                	jne    100a58 <exec+0x128>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
  1009fa:	83 7d c8 01          	cmpl   $0x1,-0x38(%ebp)
  1009fe:	75 c8                	jne    1009c8 <exec+0x98>
      continue;
    if(ph.memsz < ph.filesz)
  100a00:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100a03:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  100a06:	72 50                	jb     100a58 <exec+0x128>
      goto bad;
    if(!(sz = allocuvm(pgdir, sz, ph.va + ph.memsz)))
  100a08:	03 45 d0             	add    -0x30(%ebp),%eax
  100a0b:	89 44 24 08          	mov    %eax,0x8(%esp)
  100a0f:	8b 4d 84             	mov    -0x7c(%ebp),%ecx
  100a12:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  100a16:	8b 45 80             	mov    -0x80(%ebp),%eax
  100a19:	89 04 24             	mov    %eax,(%esp)
  100a1c:	e8 ff 56 00 00       	call   106120 <allocuvm>
  100a21:	85 c0                	test   %eax,%eax
  100a23:	89 45 84             	mov    %eax,-0x7c(%ebp)
  100a26:	74 30                	je     100a58 <exec+0x128>
      goto bad;
    if(!loaduvm(pgdir, (char *)ph.va, ip, ph.offset, ph.filesz))
  100a28:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100a2b:	89 44 24 10          	mov    %eax,0x10(%esp)
  100a2f:	8b 45 cc             	mov    -0x34(%ebp),%eax
  100a32:	89 7c 24 08          	mov    %edi,0x8(%esp)
  100a36:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100a3a:	8b 45 d0             	mov    -0x30(%ebp),%eax
  100a3d:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a41:	8b 55 80             	mov    -0x80(%ebp),%edx
  100a44:	89 14 24             	mov    %edx,(%esp)
  100a47:	e8 a4 57 00 00       	call   1061f0 <loaduvm>
  100a4c:	85 c0                	test   %eax,%eax
  100a4e:	0f 85 74 ff ff ff    	jne    1009c8 <exec+0x98>
  100a54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  freevm(oldpgdir);

  return 0;

 bad:
  if(pgdir) freevm(pgdir);
  100a58:	8b 45 80             	mov    -0x80(%ebp),%eax
  100a5b:	89 04 24             	mov    %eax,(%esp)
  100a5e:	e8 7d 55 00 00       	call   105fe0 <freevm>
  iunlockput(ip);
  100a63:	89 3c 24             	mov    %edi,(%esp)
  100a66:	e8 35 10 00 00       	call   101aa0 <iunlockput>
  100a6b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return -1;
}
  100a70:	81 c4 ac 00 00 00    	add    $0xac,%esp
  100a76:	5b                   	pop    %ebx
  100a77:	5e                   	pop    %esi
  100a78:	5f                   	pop    %edi
  100a79:	5d                   	pop    %ebp
  100a7a:	c3                   	ret    
  100a7b:	90                   	nop
  100a7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  if(!(pgdir = setupkvm()))
    goto bad;

  // Load program into memory.
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  100a80:	8b 4d 84             	mov    -0x7c(%ebp),%ecx
  100a83:	81 c1 ff 0f 00 00    	add    $0xfff,%ecx
  100a89:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  100a8f:	89 cb                	mov    %ecx,%ebx
  100a91:	89 4d 84             	mov    %ecx,-0x7c(%ebp)
  100a94:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(!(sz = allocuvm(pgdir, sz, ph.va + ph.memsz)))
      goto bad;
    if(!loaduvm(pgdir, (char *)ph.va, ip, ph.offset, ph.filesz))
      goto bad;
  }
  iunlockput(ip);
  100a9a:	89 3c 24             	mov    %edi,(%esp)
  100a9d:	e8 fe 0f 00 00       	call   101aa0 <iunlockput>

  // Allocate and initialize stack at sz
  sz = spbottom = PGROUNDUP(sz);
  if(!(sz = allocuvm(pgdir, sz, sz + PGSIZE)))
  100aa2:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  100aa6:	8b 45 84             	mov    -0x7c(%ebp),%eax
  100aa9:	89 44 24 04          	mov    %eax,0x4(%esp)
  100aad:	8b 55 80             	mov    -0x80(%ebp),%edx
  100ab0:	89 14 24             	mov    %edx,(%esp)
  100ab3:	e8 68 56 00 00       	call   106120 <allocuvm>
  100ab8:	85 c0                	test   %eax,%eax
  100aba:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
  100ac0:	74 96                	je     100a58 <exec+0x128>
    goto bad;
  mem = uva2ka(pgdir, (char *)spbottom);
  100ac2:	8b 4d 84             	mov    -0x7c(%ebp),%ecx
  100ac5:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  100ac9:	8b 45 80             	mov    -0x80(%ebp),%eax
  100acc:	89 04 24             	mov    %eax,(%esp)
  100acf:	e8 cc 52 00 00       	call   105da0 <uva2ka>

  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100ad4:	8b 4d 0c             	mov    0xc(%ebp),%ecx

  // Allocate and initialize stack at sz
  sz = spbottom = PGROUNDUP(sz);
  if(!(sz = allocuvm(pgdir, sz, sz + PGSIZE)))
    goto bad;
  mem = uva2ka(pgdir, (char *)spbottom);
  100ad7:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)

  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100add:	8b 11                	mov    (%ecx),%edx
  100adf:	85 d2                	test   %edx,%edx
  100ae1:	0f 84 ac 01 00 00    	je     100c93 <exec+0x363>
  100ae7:	31 f6                	xor    %esi,%esi
  100ae9:	31 db                	xor    %ebx,%ebx
  100aeb:	89 cf                	mov    %ecx,%edi
  100aed:	8d 76 00             	lea    0x0(%esi),%esi
    arglen += strlen(argv[argc]) + 1;
  100af0:	89 14 24             	mov    %edx,(%esp)
  if(!(sz = allocuvm(pgdir, sz, sz + PGSIZE)))
    goto bad;
  mem = uva2ka(pgdir, (char *)spbottom);

  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100af3:	83 c3 01             	add    $0x1,%ebx
    arglen += strlen(argv[argc]) + 1;
  100af6:	e8 a5 32 00 00       	call   103da0 <strlen>
  if(!(sz = allocuvm(pgdir, sz, sz + PGSIZE)))
    goto bad;
  mem = uva2ka(pgdir, (char *)spbottom);

  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100afb:	8b 14 9f             	mov    (%edi,%ebx,4),%edx
    arglen += strlen(argv[argc]) + 1;
  100afe:	01 f0                	add    %esi,%eax
  if(!(sz = allocuvm(pgdir, sz, sz + PGSIZE)))
    goto bad;
  mem = uva2ka(pgdir, (char *)spbottom);

  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100b00:	85 d2                	test   %edx,%edx
    arglen += strlen(argv[argc]) + 1;
  100b02:	8d 70 01             	lea    0x1(%eax),%esi
  if(!(sz = allocuvm(pgdir, sz, sz + PGSIZE)))
    goto bad;
  mem = uva2ka(pgdir, (char *)spbottom);

  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100b05:	75 e9                	jne    100af0 <exec+0x1c0>
    arglen += strlen(argv[argc]) + 1;
  arglen = (arglen+3) & ~3;

  sp = sz;
  argp = sz - arglen - 4*(argc+1);
  100b07:	8b 8d 74 ff ff ff    	mov    -0x8c(%ebp),%ecx
  if(!(sz = allocuvm(pgdir, sz, sz + PGSIZE)))
    goto bad;
  mem = uva2ka(pgdir, (char *)spbottom);

  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100b0d:	89 da                	mov    %ebx,%edx
  100b0f:	83 c0 04             	add    $0x4,%eax
  100b12:	f7 d2                	not    %edx
    arglen += strlen(argv[argc]) + 1;
  arglen = (arglen+3) & ~3;

  sp = sz;
  argp = sz - arglen - 4*(argc+1);
  100b14:	83 e0 fc             	and    $0xfffffffc,%eax
  100b17:	89 9d 70 ff ff ff    	mov    %ebx,-0x90(%ebp)
  if(!(sz = allocuvm(pgdir, sz, sz + PGSIZE)))
    goto bad;
  mem = uva2ka(pgdir, (char *)spbottom);

  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100b1d:	89 df                	mov    %ebx,%edi
  100b1f:	83 ef 01             	sub    $0x1,%edi
    arglen += strlen(argv[argc]) + 1;
  arglen = (arglen+3) & ~3;

  sp = sz;
  argp = sz - arglen - 4*(argc+1);
  100b22:	8d 14 91             	lea    (%ecx,%edx,4),%edx
  100b25:	29 c2                	sub    %eax,%edx
  100b27:	89 95 78 ff ff ff    	mov    %edx,-0x88(%ebp)

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp-spbottom + 4*argc) = 0;  // argv[argc]
  100b2d:	89 d1                	mov    %edx,%ecx
  100b2f:	8b 95 7c ff ff ff    	mov    -0x84(%ebp),%edx
  100b35:	2b 4d 84             	sub    -0x7c(%ebp),%ecx
  100b38:	8d 04 99             	lea    (%ecx,%ebx,4),%eax
  100b3b:	c7 04 10 00 00 00 00 	movl   $0x0,(%eax,%edx,1)
  100b42:	8b 75 0c             	mov    0xc(%ebp),%esi
  100b45:	8d 14 bd 00 00 00 00 	lea    0x0(,%edi,4),%edx
  100b4c:	8b 9d 74 ff ff ff    	mov    -0x8c(%ebp),%ebx
  100b52:	01 d6                	add    %edx,%esi
  100b54:	8d 14 11             	lea    (%ecx,%edx,1),%edx
  100b57:	03 95 7c ff ff ff    	add    -0x84(%ebp),%edx
  100b5d:	8d 76 00             	lea    0x0(%esi),%esi
  for(i=argc-1; i>=0; i--){
    len = strlen(argv[i]) + 1;
  100b60:	8b 06                	mov    (%esi),%eax
  sp = sz;
  argp = sz - arglen - 4*(argc+1);

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp-spbottom + 4*argc) = 0;  // argv[argc]
  for(i=argc-1; i>=0; i--){
  100b62:	83 ef 01             	sub    $0x1,%edi
    len = strlen(argv[i]) + 1;
  100b65:	89 04 24             	mov    %eax,(%esp)
  100b68:	89 95 6c ff ff ff    	mov    %edx,-0x94(%ebp)
  100b6e:	e8 2d 32 00 00       	call   103da0 <strlen>
    sp -= len;
  100b73:	83 c0 01             	add    $0x1,%eax
  100b76:	29 c3                	sub    %eax,%ebx
    memmove(mem+sp-spbottom, argv[i], len);
  100b78:	89 44 24 08          	mov    %eax,0x8(%esp)
  100b7c:	8b 06                	mov    (%esi),%eax
  sp = sz;
  argp = sz - arglen - 4*(argc+1);

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp-spbottom + 4*argc) = 0;  // argv[argc]
  for(i=argc-1; i>=0; i--){
  100b7e:	83 ee 04             	sub    $0x4,%esi
    len = strlen(argv[i]) + 1;
    sp -= len;
    memmove(mem+sp-spbottom, argv[i], len);
  100b81:	89 44 24 04          	mov    %eax,0x4(%esp)
  100b85:	89 d8                	mov    %ebx,%eax
  100b87:	2b 45 84             	sub    -0x7c(%ebp),%eax
  100b8a:	03 85 7c ff ff ff    	add    -0x84(%ebp),%eax
  100b90:	89 04 24             	mov    %eax,(%esp)
  100b93:	e8 a8 30 00 00       	call   103c40 <memmove>
    *(uint*)(mem+argp-spbottom + 4*i) = sp;  // argv[i]
  100b98:	8b 95 6c ff ff ff    	mov    -0x94(%ebp),%edx
  100b9e:	89 1a                	mov    %ebx,(%edx)
  sp = sz;
  argp = sz - arglen - 4*(argc+1);

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp-spbottom + 4*argc) = 0;  // argv[argc]
  for(i=argc-1; i>=0; i--){
  100ba0:	83 ea 04             	sub    $0x4,%edx
  100ba3:	83 ff ff             	cmp    $0xffffffff,%edi
  100ba6:	75 b8                	jne    100b60 <exec+0x230>
    *(uint*)(mem+argp-spbottom + 4*i) = sp;  // argv[i]
  }

  // Stack frame for main(argc, argv), below arguments.
  sp = argp;
  sp -= 4;
  100ba8:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  *(uint*)(mem+sp-spbottom) = argp;
  100bae:	8b 95 78 ff ff ff    	mov    -0x88(%ebp),%edx
  100bb4:	8b 8d 7c ff ff ff    	mov    -0x84(%ebp),%ecx
    *(uint*)(mem+argp-spbottom + 4*i) = sp;  // argv[i]
  }

  // Stack frame for main(argc, argv), below arguments.
  sp = argp;
  sp -= 4;
  100bba:	83 e8 04             	sub    $0x4,%eax
  *(uint*)(mem+sp-spbottom) = argp;
  100bbd:	2b 45 84             	sub    -0x7c(%ebp),%eax
  100bc0:	89 14 01             	mov    %edx,(%ecx,%eax,1)
  sp -= 4;
  100bc3:	89 d0                	mov    %edx,%eax
  *(uint*)(mem+sp-spbottom) = argc;
  100bc5:	8b 95 70 ff ff ff    	mov    -0x90(%ebp),%edx

  // Stack frame for main(argc, argv), below arguments.
  sp = argp;
  sp -= 4;
  *(uint*)(mem+sp-spbottom) = argp;
  sp -= 4;
  100bcb:	83 e8 08             	sub    $0x8,%eax
  *(uint*)(mem+sp-spbottom) = argc;
  100bce:	2b 45 84             	sub    -0x7c(%ebp),%eax
  100bd1:	89 14 01             	mov    %edx,(%ecx,%eax,1)
  sp -= 4;
  100bd4:	8b 9d 78 ff ff ff    	mov    -0x88(%ebp),%ebx
  100bda:	83 eb 0c             	sub    $0xc,%ebx
  *(uint*)(mem+sp-spbottom) = 0xffffffff;   // fake return pc
  100bdd:	89 d8                	mov    %ebx,%eax
  100bdf:	2b 45 84             	sub    -0x7c(%ebp),%eax
  100be2:	c7 04 01 ff ff ff ff 	movl   $0xffffffff,(%ecx,%eax,1)

  // Save program name for debugging.
  for(last=s=path; *s; s++)
  100be9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  100bec:	0f b6 11             	movzbl (%ecx),%edx
  100bef:	84 d2                	test   %dl,%dl
  100bf1:	74 28                	je     100c1b <exec+0x2eb>
  100bf3:	89 c8                	mov    %ecx,%eax
  100bf5:	83 c0 01             	add    $0x1,%eax
  100bf8:	eb 10                	jmp    100c0a <exec+0x2da>
  100bfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100c00:	0f b6 10             	movzbl (%eax),%edx
  100c03:	83 c0 01             	add    $0x1,%eax
  100c06:	84 d2                	test   %dl,%dl
  100c08:	74 11                	je     100c1b <exec+0x2eb>
    if(*s == '/')
  100c0a:	80 fa 2f             	cmp    $0x2f,%dl
  100c0d:	75 f1                	jne    100c00 <exec+0x2d0>
  *(uint*)(mem+sp-spbottom) = argc;
  sp -= 4;
  *(uint*)(mem+sp-spbottom) = 0xffffffff;   // fake return pc

  // Save program name for debugging.
  for(last=s=path; *s; s++)
  100c0f:	0f b6 10             	movzbl (%eax),%edx
    if(*s == '/')
  100c12:	89 c1                	mov    %eax,%ecx
  *(uint*)(mem+sp-spbottom) = argc;
  sp -= 4;
  *(uint*)(mem+sp-spbottom) = 0xffffffff;   // fake return pc

  // Save program name for debugging.
  for(last=s=path; *s; s++)
  100c14:	83 c0 01             	add    $0x1,%eax
  100c17:	84 d2                	test   %dl,%dl
  100c19:	75 ef                	jne    100c0a <exec+0x2da>
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));
  100c1b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  100c21:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  100c25:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
  100c2c:	00 
  100c2d:	83 c0 70             	add    $0x70,%eax
  100c30:	89 04 24             	mov    %eax,(%esp)
  100c33:	e8 28 31 00 00       	call   103d60 <safestrcpy>

  // Commit to the user image.
  oldpgdir = proc->pgdir;
  proc->pgdir = pgdir;
  100c38:	8b 55 80             	mov    -0x80(%ebp),%edx
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));

  // Commit to the user image.
  oldpgdir = proc->pgdir;
  100c3b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  100c41:	8b 70 04             	mov    0x4(%eax),%esi
  proc->pgdir = pgdir;
  100c44:	89 50 04             	mov    %edx,0x4(%eax)
  proc->sz = sz;
  100c47:	8b 8d 74 ff ff ff    	mov    -0x8c(%ebp),%ecx
  100c4d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  100c53:	89 08                	mov    %ecx,(%eax)
  proc->tf->eip = elf.entry;  // main
  100c55:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  100c5b:	8b 55 ac             	mov    -0x54(%ebp),%edx
  100c5e:	8b 40 18             	mov    0x18(%eax),%eax
  100c61:	89 50 38             	mov    %edx,0x38(%eax)
  proc->tf->esp = sp;
  100c64:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  100c6a:	8b 40 18             	mov    0x18(%eax),%eax
  100c6d:	89 58 44             	mov    %ebx,0x44(%eax)

  switchuvm(proc); 
  100c70:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  100c76:	89 04 24             	mov    %eax,(%esp)
  100c79:	e8 32 56 00 00       	call   1062b0 <switchuvm>

  freevm(oldpgdir);
  100c7e:	89 34 24             	mov    %esi,(%esp)
  100c81:	e8 5a 53 00 00       	call   105fe0 <freevm>

 bad:
  if(pgdir) freevm(pgdir);
  iunlockput(ip);
  return -1;
}
  100c86:	81 c4 ac 00 00 00    	add    $0xac,%esp
  proc->tf->eip = elf.entry;  // main
  proc->tf->esp = sp;

  switchuvm(proc); 

  freevm(oldpgdir);
  100c8c:	31 c0                	xor    %eax,%eax

 bad:
  if(pgdir) freevm(pgdir);
  iunlockput(ip);
  return -1;
}
  100c8e:	5b                   	pop    %ebx
  100c8f:	5e                   	pop    %esi
  100c90:	5f                   	pop    %edi
  100c91:	5d                   	pop    %ebp
  100c92:	c3                   	ret    
  for(argc=0; argv[argc]; argc++)
    arglen += strlen(argv[argc]) + 1;
  arglen = (arglen+3) & ~3;

  sp = sz;
  argp = sz - arglen - 4*(argc+1);
  100c93:	8b 95 74 ff ff ff    	mov    -0x8c(%ebp),%edx

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp-spbottom + 4*argc) = 0;  // argv[argc]
  100c99:	8b 8d 7c ff ff ff    	mov    -0x84(%ebp),%ecx
  for(argc=0; argv[argc]; argc++)
    arglen += strlen(argv[argc]) + 1;
  arglen = (arglen+3) & ~3;

  sp = sz;
  argp = sz - arglen - 4*(argc+1);
  100c9f:	83 ea 04             	sub    $0x4,%edx

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp-spbottom + 4*argc) = 0;  // argv[argc]
  100ca2:	89 d0                	mov    %edx,%eax
  100ca4:	2b 45 84             	sub    -0x7c(%ebp),%eax
  for(argc=0; argv[argc]; argc++)
    arglen += strlen(argv[argc]) + 1;
  arglen = (arglen+3) & ~3;

  sp = sz;
  argp = sz - arglen - 4*(argc+1);
  100ca7:	89 95 78 ff ff ff    	mov    %edx,-0x88(%ebp)

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp-spbottom + 4*argc) = 0;  // argv[argc]
  100cad:	c7 04 01 00 00 00 00 	movl   $0x0,(%ecx,%eax,1)
  100cb4:	c7 85 70 ff ff ff 00 	movl   $0x0,-0x90(%ebp)
  100cbb:	00 00 00 
  100cbe:	e9 e5 fe ff ff       	jmp    100ba8 <exec+0x278>

  if(!(pgdir = setupkvm()))
    goto bad;

  // Load program into memory.
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  100cc3:	bb 00 10 00 00       	mov    $0x1000,%ebx
  100cc8:	c7 45 84 00 00 00 00 	movl   $0x0,-0x7c(%ebp)
  100ccf:	e9 c6 fd ff ff       	jmp    100a9a <exec+0x16a>
  100cd4:	90                   	nop
  100cd5:	90                   	nop
  100cd6:	90                   	nop
  100cd7:	90                   	nop
  100cd8:	90                   	nop
  100cd9:	90                   	nop
  100cda:	90                   	nop
  100cdb:	90                   	nop
  100cdc:	90                   	nop
  100cdd:	90                   	nop
  100cde:	90                   	nop
  100cdf:	90                   	nop

00100ce0 <filewrite>:
}

// Write to file f.  Addr is kernel address.
int
filewrite(struct file *f, char *addr, int n)
{
  100ce0:	55                   	push   %ebp
  100ce1:	89 e5                	mov    %esp,%ebp
  100ce3:	83 ec 38             	sub    $0x38,%esp
  100ce6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  100ce9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  100cec:	89 75 f8             	mov    %esi,-0x8(%ebp)
  100cef:	8b 75 0c             	mov    0xc(%ebp),%esi
  100cf2:	89 7d fc             	mov    %edi,-0x4(%ebp)
  100cf5:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->writable == 0)
  100cf8:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
  100cfc:	74 5a                	je     100d58 <filewrite+0x78>
    return -1;
  if(f->type == FD_PIPE)
  100cfe:	8b 03                	mov    (%ebx),%eax
  100d00:	83 f8 01             	cmp    $0x1,%eax
  100d03:	74 5b                	je     100d60 <filewrite+0x80>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
  100d05:	83 f8 02             	cmp    $0x2,%eax
  100d08:	75 6d                	jne    100d77 <filewrite+0x97>
    ilock(f->ip);
  100d0a:	8b 43 10             	mov    0x10(%ebx),%eax
  100d0d:	89 04 24             	mov    %eax,(%esp)
  100d10:	e8 7b 0e 00 00       	call   101b90 <ilock>
    if((r = writei(f->ip, addr, f->off, n)) > 0)
  100d15:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  100d19:	8b 43 14             	mov    0x14(%ebx),%eax
  100d1c:	89 74 24 04          	mov    %esi,0x4(%esp)
  100d20:	89 44 24 08          	mov    %eax,0x8(%esp)
  100d24:	8b 43 10             	mov    0x10(%ebx),%eax
  100d27:	89 04 24             	mov    %eax,(%esp)
  100d2a:	e8 b1 07 00 00       	call   1014e0 <writei>
  100d2f:	85 c0                	test   %eax,%eax
  100d31:	7e 03                	jle    100d36 <filewrite+0x56>
      f->off += r;
  100d33:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
  100d36:	8b 53 10             	mov    0x10(%ebx),%edx
  100d39:	89 14 24             	mov    %edx,(%esp)
  100d3c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  100d3f:	e8 0c 0a 00 00       	call   101750 <iunlock>
    return r;
  100d44:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  }
  panic("filewrite");
}
  100d47:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  100d4a:	8b 75 f8             	mov    -0x8(%ebp),%esi
  100d4d:	8b 7d fc             	mov    -0x4(%ebp),%edi
  100d50:	89 ec                	mov    %ebp,%esp
  100d52:	5d                   	pop    %ebp
  100d53:	c3                   	ret    
  100d54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((r = writei(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("filewrite");
  100d58:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100d5d:	eb e8                	jmp    100d47 <filewrite+0x67>
  100d5f:	90                   	nop
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
  100d60:	8b 43 0c             	mov    0xc(%ebx),%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("filewrite");
}
  100d63:	8b 75 f8             	mov    -0x8(%ebp),%esi
  100d66:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  100d69:	8b 7d fc             	mov    -0x4(%ebp),%edi
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
  100d6c:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("filewrite");
}
  100d6f:	89 ec                	mov    %ebp,%esp
  100d71:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
  100d72:	e9 d9 1f 00 00       	jmp    102d50 <pipewrite>
    if((r = writei(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("filewrite");
  100d77:	c7 04 24 ff 64 10 00 	movl   $0x1064ff,(%esp)
  100d7e:	e8 2d fb ff ff       	call   1008b0 <panic>
  100d83:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100d89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100d90 <fileread>:
}

// Read from file f.  Addr is kernel address.
int
fileread(struct file *f, char *addr, int n)
{
  100d90:	55                   	push   %ebp
  100d91:	89 e5                	mov    %esp,%ebp
  100d93:	83 ec 38             	sub    $0x38,%esp
  100d96:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  100d99:	8b 5d 08             	mov    0x8(%ebp),%ebx
  100d9c:	89 75 f8             	mov    %esi,-0x8(%ebp)
  100d9f:	8b 75 0c             	mov    0xc(%ebp),%esi
  100da2:	89 7d fc             	mov    %edi,-0x4(%ebp)
  100da5:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
  100da8:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
  100dac:	74 5a                	je     100e08 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
  100dae:	8b 03                	mov    (%ebx),%eax
  100db0:	83 f8 01             	cmp    $0x1,%eax
  100db3:	74 5b                	je     100e10 <fileread+0x80>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
  100db5:	83 f8 02             	cmp    $0x2,%eax
  100db8:	75 6d                	jne    100e27 <fileread+0x97>
    ilock(f->ip);
  100dba:	8b 43 10             	mov    0x10(%ebx),%eax
  100dbd:	89 04 24             	mov    %eax,(%esp)
  100dc0:	e8 cb 0d 00 00       	call   101b90 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
  100dc5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  100dc9:	8b 43 14             	mov    0x14(%ebx),%eax
  100dcc:	89 74 24 04          	mov    %esi,0x4(%esp)
  100dd0:	89 44 24 08          	mov    %eax,0x8(%esp)
  100dd4:	8b 43 10             	mov    0x10(%ebx),%eax
  100dd7:	89 04 24             	mov    %eax,(%esp)
  100dda:	e8 71 05 00 00       	call   101350 <readi>
  100ddf:	85 c0                	test   %eax,%eax
  100de1:	7e 03                	jle    100de6 <fileread+0x56>
      f->off += r;
  100de3:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
  100de6:	8b 53 10             	mov    0x10(%ebx),%edx
  100de9:	89 14 24             	mov    %edx,(%esp)
  100dec:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  100def:	e8 5c 09 00 00       	call   101750 <iunlock>
    return r;
  100df4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  }
  panic("fileread");
}
  100df7:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  100dfa:	8b 75 f8             	mov    -0x8(%ebp),%esi
  100dfd:	8b 7d fc             	mov    -0x4(%ebp),%edi
  100e00:	89 ec                	mov    %ebp,%esp
  100e02:	5d                   	pop    %ebp
  100e03:	c3                   	ret    
  100e04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
  100e08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100e0d:	eb e8                	jmp    100df7 <fileread+0x67>
  100e0f:	90                   	nop
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  100e10:	8b 43 0c             	mov    0xc(%ebx),%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
  100e13:	8b 75 f8             	mov    -0x8(%ebp),%esi
  100e16:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  100e19:	8b 7d fc             	mov    -0x4(%ebp),%edi
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  100e1c:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
  100e1f:	89 ec                	mov    %ebp,%esp
  100e21:	5d                   	pop    %ebp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  100e22:	e9 29 1e 00 00       	jmp    102c50 <piperead>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
  100e27:	c7 04 24 09 65 10 00 	movl   $0x106509,(%esp)
  100e2e:	e8 7d fa ff ff       	call   1008b0 <panic>
  100e33:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100e40 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
  100e40:	55                   	push   %ebp
  if(f->type == FD_INODE){
  100e41:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
  100e46:	89 e5                	mov    %esp,%ebp
  100e48:	53                   	push   %ebx
  100e49:	83 ec 14             	sub    $0x14,%esp
  100e4c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
  100e4f:	83 3b 02             	cmpl   $0x2,(%ebx)
  100e52:	74 0c                	je     100e60 <filestat+0x20>
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
}
  100e54:	83 c4 14             	add    $0x14,%esp
  100e57:	5b                   	pop    %ebx
  100e58:	5d                   	pop    %ebp
  100e59:	c3                   	ret    
  100e5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
  if(f->type == FD_INODE){
    ilock(f->ip);
  100e60:	8b 43 10             	mov    0x10(%ebx),%eax
  100e63:	89 04 24             	mov    %eax,(%esp)
  100e66:	e8 25 0d 00 00       	call   101b90 <ilock>
    stati(f->ip, st);
  100e6b:	8b 45 0c             	mov    0xc(%ebp),%eax
  100e6e:	89 44 24 04          	mov    %eax,0x4(%esp)
  100e72:	8b 43 10             	mov    0x10(%ebx),%eax
  100e75:	89 04 24             	mov    %eax,(%esp)
  100e78:	e8 e3 01 00 00       	call   101060 <stati>
    iunlock(f->ip);
  100e7d:	8b 43 10             	mov    0x10(%ebx),%eax
  100e80:	89 04 24             	mov    %eax,(%esp)
  100e83:	e8 c8 08 00 00       	call   101750 <iunlock>
    return 0;
  }
  return -1;
}
  100e88:	83 c4 14             	add    $0x14,%esp
filestat(struct file *f, struct stat *st)
{
  if(f->type == FD_INODE){
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
  100e8b:	31 c0                	xor    %eax,%eax
    return 0;
  }
  return -1;
}
  100e8d:	5b                   	pop    %ebx
  100e8e:	5d                   	pop    %ebp
  100e8f:	c3                   	ret    

00100e90 <filedup>:
}

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
  100e90:	55                   	push   %ebp
  100e91:	89 e5                	mov    %esp,%ebp
  100e93:	53                   	push   %ebx
  100e94:	83 ec 14             	sub    $0x14,%esp
  100e97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
  100e9a:	c7 04 24 60 90 10 00 	movl   $0x109060,(%esp)
  100ea1:	e8 7a 2c 00 00       	call   103b20 <acquire>
  if(f->ref < 1)
  100ea6:	8b 43 04             	mov    0x4(%ebx),%eax
  100ea9:	85 c0                	test   %eax,%eax
  100eab:	7e 1a                	jle    100ec7 <filedup+0x37>
    panic("filedup");
  f->ref++;
  100ead:	83 c0 01             	add    $0x1,%eax
  100eb0:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
  100eb3:	c7 04 24 60 90 10 00 	movl   $0x109060,(%esp)
  100eba:	e8 11 2c 00 00       	call   103ad0 <release>
  return f;
}
  100ebf:	89 d8                	mov    %ebx,%eax
  100ec1:	83 c4 14             	add    $0x14,%esp
  100ec4:	5b                   	pop    %ebx
  100ec5:	5d                   	pop    %ebp
  100ec6:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
  100ec7:	c7 04 24 12 65 10 00 	movl   $0x106512,(%esp)
  100ece:	e8 dd f9 ff ff       	call   1008b0 <panic>
  100ed3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100ee0 <filealloc>:
}

// Allocate a file structure.
struct file*
filealloc(void)
{
  100ee0:	55                   	push   %ebp
  100ee1:	89 e5                	mov    %esp,%ebp
  100ee3:	53                   	push   %ebx
  initlock(&ftable.lock, "ftable");
}

// Allocate a file structure.
struct file*
filealloc(void)
  100ee4:	bb ac 90 10 00       	mov    $0x1090ac,%ebx
{
  100ee9:	83 ec 14             	sub    $0x14,%esp
  struct file *f;

  acquire(&ftable.lock);
  100eec:	c7 04 24 60 90 10 00 	movl   $0x109060,(%esp)
  100ef3:	e8 28 2c 00 00       	call   103b20 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
  100ef8:	8b 15 98 90 10 00    	mov    0x109098,%edx
  100efe:	85 d2                	test   %edx,%edx
  100f00:	75 11                	jne    100f13 <filealloc+0x33>
  100f02:	eb 4a                	jmp    100f4e <filealloc+0x6e>
  100f04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
filealloc(void)
{
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
  100f08:	83 c3 18             	add    $0x18,%ebx
  100f0b:	81 fb f4 99 10 00    	cmp    $0x1099f4,%ebx
  100f11:	74 25                	je     100f38 <filealloc+0x58>
    if(f->ref == 0){
  100f13:	8b 43 04             	mov    0x4(%ebx),%eax
  100f16:	85 c0                	test   %eax,%eax
  100f18:	75 ee                	jne    100f08 <filealloc+0x28>
      f->ref = 1;
  100f1a:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
  100f21:	c7 04 24 60 90 10 00 	movl   $0x109060,(%esp)
  100f28:	e8 a3 2b 00 00       	call   103ad0 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
  100f2d:	89 d8                	mov    %ebx,%eax
  100f2f:	83 c4 14             	add    $0x14,%esp
  100f32:	5b                   	pop    %ebx
  100f33:	5d                   	pop    %ebp
  100f34:	c3                   	ret    
  100f35:	8d 76 00             	lea    0x0(%esi),%esi
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
  100f38:	31 db                	xor    %ebx,%ebx
  100f3a:	c7 04 24 60 90 10 00 	movl   $0x109060,(%esp)
  100f41:	e8 8a 2b 00 00       	call   103ad0 <release>
  return 0;
}
  100f46:	89 d8                	mov    %ebx,%eax
  100f48:	83 c4 14             	add    $0x14,%esp
  100f4b:	5b                   	pop    %ebx
  100f4c:	5d                   	pop    %ebp
  100f4d:	c3                   	ret    
{
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
  100f4e:	bb 94 90 10 00       	mov    $0x109094,%ebx
  100f53:	eb c5                	jmp    100f1a <filealloc+0x3a>
  100f55:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100f60 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
  100f60:	55                   	push   %ebp
  100f61:	89 e5                	mov    %esp,%ebp
  100f63:	83 ec 38             	sub    $0x38,%esp
  100f66:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  100f69:	8b 5d 08             	mov    0x8(%ebp),%ebx
  100f6c:	89 75 f8             	mov    %esi,-0x8(%ebp)
  100f6f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  struct file ff;

  acquire(&ftable.lock);
  100f72:	c7 04 24 60 90 10 00 	movl   $0x109060,(%esp)
  100f79:	e8 a2 2b 00 00       	call   103b20 <acquire>
  if(f->ref < 1)
  100f7e:	8b 43 04             	mov    0x4(%ebx),%eax
  100f81:	85 c0                	test   %eax,%eax
  100f83:	0f 8e 9c 00 00 00    	jle    101025 <fileclose+0xc5>
    panic("fileclose");
  if(--f->ref > 0){
  100f89:	83 e8 01             	sub    $0x1,%eax
  100f8c:	85 c0                	test   %eax,%eax
  100f8e:	89 43 04             	mov    %eax,0x4(%ebx)
  100f91:	74 1d                	je     100fb0 <fileclose+0x50>
    release(&ftable.lock);
  100f93:	c7 45 08 60 90 10 00 	movl   $0x109060,0x8(%ebp)
  
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE)
    iput(ff.ip);
}
  100f9a:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  100f9d:	8b 75 f8             	mov    -0x8(%ebp),%esi
  100fa0:	8b 7d fc             	mov    -0x4(%ebp),%edi
  100fa3:	89 ec                	mov    %ebp,%esp
  100fa5:	5d                   	pop    %ebp

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
  100fa6:	e9 25 2b 00 00       	jmp    103ad0 <release>
  100fab:	90                   	nop
  100fac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return;
  }
  ff = *f;
  100fb0:	8b 43 0c             	mov    0xc(%ebx),%eax
  100fb3:	8b 7b 10             	mov    0x10(%ebx),%edi
  100fb6:	89 45 e0             	mov    %eax,-0x20(%ebp)
  100fb9:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  100fbd:	88 45 e7             	mov    %al,-0x19(%ebp)
  100fc0:	8b 33                	mov    (%ebx),%esi
  f->ref = 0;
  100fc2:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
  f->type = FD_NONE;
  100fc9:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  release(&ftable.lock);
  100fcf:	c7 04 24 60 90 10 00 	movl   $0x109060,(%esp)
  100fd6:	e8 f5 2a 00 00       	call   103ad0 <release>
  
  if(ff.type == FD_PIPE)
  100fdb:	83 fe 01             	cmp    $0x1,%esi
  100fde:	74 30                	je     101010 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE)
  100fe0:	83 fe 02             	cmp    $0x2,%esi
  100fe3:	74 13                	je     100ff8 <fileclose+0x98>
    iput(ff.ip);
}
  100fe5:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  100fe8:	8b 75 f8             	mov    -0x8(%ebp),%esi
  100feb:	8b 7d fc             	mov    -0x4(%ebp),%edi
  100fee:	89 ec                	mov    %ebp,%esp
  100ff0:	5d                   	pop    %ebp
  100ff1:	c3                   	ret    
  100ff2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ftable.lock);
  
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE)
    iput(ff.ip);
  100ff8:	89 7d 08             	mov    %edi,0x8(%ebp)
}
  100ffb:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  100ffe:	8b 75 f8             	mov    -0x8(%ebp),%esi
  101001:	8b 7d fc             	mov    -0x4(%ebp),%edi
  101004:	89 ec                	mov    %ebp,%esp
  101006:	5d                   	pop    %ebp
  release(&ftable.lock);
  
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE)
    iput(ff.ip);
  101007:	e9 54 08 00 00       	jmp    101860 <iput>
  10100c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
  
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  101010:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  101014:	89 44 24 04          	mov    %eax,0x4(%esp)
  101018:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10101b:	89 04 24             	mov    %eax,(%esp)
  10101e:	e8 1d 1e 00 00       	call   102e40 <pipeclose>
  101023:	eb c0                	jmp    100fe5 <fileclose+0x85>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  101025:	c7 04 24 1a 65 10 00 	movl   $0x10651a,(%esp)
  10102c:	e8 7f f8 ff ff       	call   1008b0 <panic>
  101031:	eb 0d                	jmp    101040 <fileinit>
  101033:	90                   	nop
  101034:	90                   	nop
  101035:	90                   	nop
  101036:	90                   	nop
  101037:	90                   	nop
  101038:	90                   	nop
  101039:	90                   	nop
  10103a:	90                   	nop
  10103b:	90                   	nop
  10103c:	90                   	nop
  10103d:	90                   	nop
  10103e:	90                   	nop
  10103f:	90                   	nop

00101040 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
  101040:	55                   	push   %ebp
  101041:	89 e5                	mov    %esp,%ebp
  101043:	83 ec 18             	sub    $0x18,%esp
  initlock(&ftable.lock, "ftable");
  101046:	c7 44 24 04 24 65 10 	movl   $0x106524,0x4(%esp)
  10104d:	00 
  10104e:	c7 04 24 60 90 10 00 	movl   $0x109060,(%esp)
  101055:	e8 36 29 00 00       	call   103990 <initlock>
}
  10105a:	c9                   	leave  
  10105b:	c3                   	ret    
  10105c:	90                   	nop
  10105d:	90                   	nop
  10105e:	90                   	nop
  10105f:	90                   	nop

00101060 <stati>:
}

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
  101060:	55                   	push   %ebp
  101061:	89 e5                	mov    %esp,%ebp
  101063:	8b 55 08             	mov    0x8(%ebp),%edx
  101066:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
  101069:	8b 0a                	mov    (%edx),%ecx
  10106b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
  10106e:	8b 4a 04             	mov    0x4(%edx),%ecx
  101071:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
  101074:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
  101078:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
  10107b:	0f b7 4a 16          	movzwl 0x16(%edx),%ecx
  10107f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
  101083:	8b 52 18             	mov    0x18(%edx),%edx
  101086:	89 50 10             	mov    %edx,0x10(%eax)
}
  101089:	5d                   	pop    %ebp
  10108a:	c3                   	ret    
  10108b:	90                   	nop
  10108c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00101090 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  101090:	55                   	push   %ebp
  101091:	89 e5                	mov    %esp,%ebp
  101093:	53                   	push   %ebx
  101094:	83 ec 14             	sub    $0x14,%esp
  101097:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
  10109a:	c7 04 24 60 9a 10 00 	movl   $0x109a60,(%esp)
  1010a1:	e8 7a 2a 00 00       	call   103b20 <acquire>
  ip->ref++;
  1010a6:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
  1010aa:	c7 04 24 60 9a 10 00 	movl   $0x109a60,(%esp)
  1010b1:	e8 1a 2a 00 00       	call   103ad0 <release>
  return ip;
}
  1010b6:	89 d8                	mov    %ebx,%eax
  1010b8:	83 c4 14             	add    $0x14,%esp
  1010bb:	5b                   	pop    %ebx
  1010bc:	5d                   	pop    %ebp
  1010bd:	c3                   	ret    
  1010be:	66 90                	xchg   %ax,%ax

001010c0 <iget>:

// Find the inode with number inum on device dev
// and return the in-memory copy.
static struct inode*
iget(uint dev, uint inum)
{
  1010c0:	55                   	push   %ebp
  1010c1:	89 e5                	mov    %esp,%ebp
  1010c3:	57                   	push   %edi
  1010c4:	89 d7                	mov    %edx,%edi
  1010c6:	56                   	push   %esi
}

// Find the inode with number inum on device dev
// and return the in-memory copy.
static struct inode*
iget(uint dev, uint inum)
  1010c7:	31 f6                	xor    %esi,%esi
{
  1010c9:	53                   	push   %ebx
  1010ca:	89 c3                	mov    %eax,%ebx
  1010cc:	83 ec 2c             	sub    $0x2c,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
  1010cf:	c7 04 24 60 9a 10 00 	movl   $0x109a60,(%esp)
  1010d6:	e8 45 2a 00 00       	call   103b20 <acquire>
}

// Find the inode with number inum on device dev
// and return the in-memory copy.
static struct inode*
iget(uint dev, uint inum)
  1010db:	b8 94 9a 10 00       	mov    $0x109a94,%eax
  1010e0:	eb 14                	jmp    1010f6 <iget+0x36>
  1010e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
  1010e8:	85 f6                	test   %esi,%esi
  1010ea:	74 3c                	je     101128 <iget+0x68>

  acquire(&icache.lock);

  // Try for cached inode.
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
  1010ec:	83 c0 50             	add    $0x50,%eax
  1010ef:	3d 34 aa 10 00       	cmp    $0x10aa34,%eax
  1010f4:	74 42                	je     101138 <iget+0x78>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
  1010f6:	8b 48 08             	mov    0x8(%eax),%ecx
  1010f9:	85 c9                	test   %ecx,%ecx
  1010fb:	7e eb                	jle    1010e8 <iget+0x28>
  1010fd:	39 18                	cmp    %ebx,(%eax)
  1010ff:	75 e7                	jne    1010e8 <iget+0x28>
  101101:	39 78 04             	cmp    %edi,0x4(%eax)
  101104:	75 e2                	jne    1010e8 <iget+0x28>
      ip->ref++;
  101106:	83 c1 01             	add    $0x1,%ecx
  101109:	89 48 08             	mov    %ecx,0x8(%eax)
      release(&icache.lock);
  10110c:	c7 04 24 60 9a 10 00 	movl   $0x109a60,(%esp)
  101113:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  101116:	e8 b5 29 00 00       	call   103ad0 <release>
      return ip;
  10111b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);

  return ip;
}
  10111e:	83 c4 2c             	add    $0x2c,%esp
  101121:	5b                   	pop    %ebx
  101122:	5e                   	pop    %esi
  101123:	5f                   	pop    %edi
  101124:	5d                   	pop    %ebp
  101125:	c3                   	ret    
  101126:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
  101128:	85 c9                	test   %ecx,%ecx
  10112a:	75 c0                	jne    1010ec <iget+0x2c>
  10112c:	89 c6                	mov    %eax,%esi

  acquire(&icache.lock);

  // Try for cached inode.
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
  10112e:	83 c0 50             	add    $0x50,%eax
  101131:	3d 34 aa 10 00       	cmp    $0x10aa34,%eax
  101136:	75 be                	jne    1010f6 <iget+0x36>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Allocate fresh inode.
  if(empty == 0)
  101138:	85 f6                	test   %esi,%esi
  10113a:	74 29                	je     101165 <iget+0xa5>
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
  10113c:	89 1e                	mov    %ebx,(%esi)
  ip->inum = inum;
  10113e:	89 7e 04             	mov    %edi,0x4(%esi)
  ip->ref = 1;
  101141:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->flags = 0;
  101148:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
  release(&icache.lock);
  10114f:	c7 04 24 60 9a 10 00 	movl   $0x109a60,(%esp)
  101156:	e8 75 29 00 00       	call   103ad0 <release>

  return ip;
}
  10115b:	83 c4 2c             	add    $0x2c,%esp
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);
  10115e:	89 f0                	mov    %esi,%eax

  return ip;
}
  101160:	5b                   	pop    %ebx
  101161:	5e                   	pop    %esi
  101162:	5f                   	pop    %edi
  101163:	5d                   	pop    %ebp
  101164:	c3                   	ret    
      empty = ip;
  }

  // Allocate fresh inode.
  if(empty == 0)
    panic("iget: no inodes");
  101165:	c7 04 24 2b 65 10 00 	movl   $0x10652b,(%esp)
  10116c:	e8 3f f7 ff ff       	call   1008b0 <panic>
  101171:	eb 0d                	jmp    101180 <readsb>
  101173:	90                   	nop
  101174:	90                   	nop
  101175:	90                   	nop
  101176:	90                   	nop
  101177:	90                   	nop
  101178:	90                   	nop
  101179:	90                   	nop
  10117a:	90                   	nop
  10117b:	90                   	nop
  10117c:	90                   	nop
  10117d:	90                   	nop
  10117e:	90                   	nop
  10117f:	90                   	nop

00101180 <readsb>:
static void itrunc(struct inode*);

// Read the super block.
static void
readsb(int dev, struct superblock *sb)
{
  101180:	55                   	push   %ebp
  101181:	89 e5                	mov    %esp,%ebp
  101183:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  
  bp = bread(dev, 1);
  101186:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  10118d:	00 
static void itrunc(struct inode*);

// Read the super block.
static void
readsb(int dev, struct superblock *sb)
{
  10118e:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  101191:	89 75 fc             	mov    %esi,-0x4(%ebp)
  101194:	89 d6                	mov    %edx,%esi
  struct buf *bp;
  
  bp = bread(dev, 1);
  101196:	89 04 24             	mov    %eax,(%esp)
  101199:	e8 12 ef ff ff       	call   1000b0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
  10119e:	89 34 24             	mov    %esi,(%esp)
  1011a1:	c7 44 24 08 0c 00 00 	movl   $0xc,0x8(%esp)
  1011a8:	00 
static void
readsb(int dev, struct superblock *sb)
{
  struct buf *bp;
  
  bp = bread(dev, 1);
  1011a9:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
  1011ab:	8d 40 18             	lea    0x18(%eax),%eax
  1011ae:	89 44 24 04          	mov    %eax,0x4(%esp)
  1011b2:	e8 89 2a 00 00       	call   103c40 <memmove>
  brelse(bp);
  1011b7:	89 1c 24             	mov    %ebx,(%esp)
  1011ba:	e8 41 ee ff ff       	call   100000 <brelse>
}
  1011bf:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  1011c2:	8b 75 fc             	mov    -0x4(%ebp),%esi
  1011c5:	89 ec                	mov    %ebp,%esp
  1011c7:	5d                   	pop    %ebp
  1011c8:	c3                   	ret    
  1011c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001011d0 <balloc>:
// Blocks. 

// Allocate a disk block.
static uint
balloc(uint dev)
{
  1011d0:	55                   	push   %ebp
  1011d1:	89 e5                	mov    %esp,%ebp
  1011d3:	57                   	push   %edi
  1011d4:	56                   	push   %esi
  1011d5:	53                   	push   %ebx
  1011d6:	83 ec 3c             	sub    $0x3c,%esp
  int b, bi, m;
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  1011d9:	8d 55 dc             	lea    -0x24(%ebp),%edx
// Blocks. 

// Allocate a disk block.
static uint
balloc(uint dev)
{
  1011dc:	89 45 d0             	mov    %eax,-0x30(%ebp)
  int b, bi, m;
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  1011df:	e8 9c ff ff ff       	call   101180 <readsb>
  for(b = 0; b < sb.size; b += BPB){
  1011e4:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1011e7:	85 c0                	test   %eax,%eax
  1011e9:	0f 84 9c 00 00 00    	je     10128b <balloc+0xbb>
  1011ef:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    bp = bread(dev, BBLOCK(b, sb.ninodes));
  1011f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1011f9:	31 db                	xor    %ebx,%ebx
  1011fb:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1011fe:	c1 e8 03             	shr    $0x3,%eax
  101201:	c1 fa 0c             	sar    $0xc,%edx
  101204:	8d 44 10 03          	lea    0x3(%eax,%edx,1),%eax
  101208:	89 44 24 04          	mov    %eax,0x4(%esp)
  10120c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  10120f:	89 04 24             	mov    %eax,(%esp)
  101212:	e8 99 ee ff ff       	call   1000b0 <bread>
  101217:	89 c6                	mov    %eax,%esi
  101219:	eb 10                	jmp    10122b <balloc+0x5b>
  10121b:	90                   	nop
  10121c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(bi = 0; bi < BPB; bi++){
  101220:	83 c3 01             	add    $0x1,%ebx
  101223:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
  101229:	74 45                	je     101270 <balloc+0xa0>
      m = 1 << (bi % 8);
  10122b:	89 d9                	mov    %ebx,%ecx
  10122d:	ba 01 00 00 00       	mov    $0x1,%edx
  101232:	83 e1 07             	and    $0x7,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
  101235:	89 d8                	mov    %ebx,%eax
  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb.ninodes));
    for(bi = 0; bi < BPB; bi++){
      m = 1 << (bi % 8);
  101237:	d3 e2                	shl    %cl,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
  101239:	c1 f8 03             	sar    $0x3,%eax
  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb.ninodes));
    for(bi = 0; bi < BPB; bi++){
      m = 1 << (bi % 8);
  10123c:	89 d1                	mov    %edx,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
  10123e:	0f b6 54 06 18       	movzbl 0x18(%esi,%eax,1),%edx
  101243:	0f b6 fa             	movzbl %dl,%edi
  101246:	85 cf                	test   %ecx,%edi
  101248:	75 d6                	jne    101220 <balloc+0x50>
        bp->data[bi/8] |= m;  // Mark block in use on disk.
  10124a:	09 d1                	or     %edx,%ecx
  10124c:	88 4c 06 18          	mov    %cl,0x18(%esi,%eax,1)
        bwrite(bp);
  101250:	89 34 24             	mov    %esi,(%esp)
  101253:	e8 28 ee ff ff       	call   100080 <bwrite>
        brelse(bp);
  101258:	89 34 24             	mov    %esi,(%esp)
  10125b:	e8 a0 ed ff ff       	call   100000 <brelse>
  101260:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
  101263:	83 c4 3c             	add    $0x3c,%esp
    for(bi = 0; bi < BPB; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use on disk.
        bwrite(bp);
        brelse(bp);
  101266:	8d 04 13             	lea    (%ebx,%edx,1),%eax
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
  101269:	5b                   	pop    %ebx
  10126a:	5e                   	pop    %esi
  10126b:	5f                   	pop    %edi
  10126c:	5d                   	pop    %ebp
  10126d:	c3                   	ret    
  10126e:	66 90                	xchg   %ax,%ax
        bwrite(bp);
        brelse(bp);
        return b + bi;
      }
    }
    brelse(bp);
  101270:	89 34 24             	mov    %esi,(%esp)
  101273:	e8 88 ed ff ff       	call   100000 <brelse>
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
  101278:	81 45 d4 00 10 00 00 	addl   $0x1000,-0x2c(%ebp)
  10127f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  101282:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  101285:	0f 87 6b ff ff ff    	ja     1011f6 <balloc+0x26>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
  10128b:	c7 04 24 3b 65 10 00 	movl   $0x10653b,(%esp)
  101292:	e8 19 f6 ff ff       	call   1008b0 <panic>
  101297:	89 f6                	mov    %esi,%esi
  101299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001012a0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
  1012a0:	55                   	push   %ebp
  1012a1:	89 e5                	mov    %esp,%ebp
  1012a3:	83 ec 38             	sub    $0x38,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
  1012a6:	83 fa 0b             	cmp    $0xb,%edx

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
  1012a9:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  1012ac:	89 c3                	mov    %eax,%ebx
  1012ae:	89 75 f8             	mov    %esi,-0x8(%ebp)
  1012b1:	89 7d fc             	mov    %edi,-0x4(%ebp)
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
  1012b4:	77 1a                	ja     1012d0 <bmap+0x30>
    if((addr = ip->addrs[bn]) == 0)
  1012b6:	8d 7a 04             	lea    0x4(%edx),%edi
  1012b9:	8b 44 b8 0c          	mov    0xc(%eax,%edi,4),%eax
  1012bd:	85 c0                	test   %eax,%eax
  1012bf:	74 5f                	je     101320 <bmap+0x80>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
  1012c1:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1012c4:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1012c7:	8b 7d fc             	mov    -0x4(%ebp),%edi
  1012ca:	89 ec                	mov    %ebp,%esp
  1012cc:	5d                   	pop    %ebp
  1012cd:	c3                   	ret    
  1012ce:	66 90                	xchg   %ax,%ax
  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
  1012d0:	8d 7a f4             	lea    -0xc(%edx),%edi

  if(bn < NINDIRECT){
  1012d3:	83 ff 7f             	cmp    $0x7f,%edi
  1012d6:	77 64                	ja     10133c <bmap+0x9c>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
  1012d8:	8b 40 4c             	mov    0x4c(%eax),%eax
  1012db:	85 c0                	test   %eax,%eax
  1012dd:	74 51                	je     101330 <bmap+0x90>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
  1012df:	89 44 24 04          	mov    %eax,0x4(%esp)
  1012e3:	8b 03                	mov    (%ebx),%eax
  1012e5:	89 04 24             	mov    %eax,(%esp)
  1012e8:	e8 c3 ed ff ff       	call   1000b0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
  1012ed:	8d 7c b8 18          	lea    0x18(%eax,%edi,4),%edi

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
  1012f1:	89 c6                	mov    %eax,%esi
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
  1012f3:	8b 07                	mov    (%edi),%eax
  1012f5:	85 c0                	test   %eax,%eax
  1012f7:	75 17                	jne    101310 <bmap+0x70>
      a[bn] = addr = balloc(ip->dev);
  1012f9:	8b 03                	mov    (%ebx),%eax
  1012fb:	e8 d0 fe ff ff       	call   1011d0 <balloc>
  101300:	89 07                	mov    %eax,(%edi)
      bwrite(bp);
  101302:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  101305:	89 34 24             	mov    %esi,(%esp)
  101308:	e8 73 ed ff ff       	call   100080 <bwrite>
  10130d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    }
    brelse(bp);
  101310:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  101313:	89 34 24             	mov    %esi,(%esp)
  101316:	e8 e5 ec ff ff       	call   100000 <brelse>
    return addr;
  10131b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10131e:	eb a1                	jmp    1012c1 <bmap+0x21>
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
  101320:	8b 03                	mov    (%ebx),%eax
  101322:	e8 a9 fe ff ff       	call   1011d0 <balloc>
  101327:	89 44 bb 0c          	mov    %eax,0xc(%ebx,%edi,4)
  10132b:	eb 94                	jmp    1012c1 <bmap+0x21>
  10132d:	8d 76 00             	lea    0x0(%esi),%esi
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
  101330:	8b 03                	mov    (%ebx),%eax
  101332:	e8 99 fe ff ff       	call   1011d0 <balloc>
  101337:	89 43 4c             	mov    %eax,0x4c(%ebx)
  10133a:	eb a3                	jmp    1012df <bmap+0x3f>
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
  10133c:	c7 04 24 51 65 10 00 	movl   $0x106551,(%esp)
  101343:	e8 68 f5 ff ff       	call   1008b0 <panic>
  101348:	90                   	nop
  101349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00101350 <readi>:
}

// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
  101350:	55                   	push   %ebp
  101351:	89 e5                	mov    %esp,%ebp
  101353:	83 ec 38             	sub    $0x38,%esp
  101356:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  101359:	8b 5d 08             	mov    0x8(%ebp),%ebx
  10135c:	89 75 f8             	mov    %esi,-0x8(%ebp)
  10135f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  101362:	89 7d fc             	mov    %edi,-0x4(%ebp)
  101365:	8b 75 10             	mov    0x10(%ebp),%esi
  101368:	8b 7d 0c             	mov    0xc(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
  10136b:	66 83 7b 10 03       	cmpw   $0x3,0x10(%ebx)
  101370:	74 1e                	je     101390 <readi+0x40>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
  101372:	8b 43 18             	mov    0x18(%ebx),%eax
  101375:	39 f0                	cmp    %esi,%eax
  101377:	73 3f                	jae    1013b8 <readi+0x68>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
  101379:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  10137e:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  101381:	8b 75 f8             	mov    -0x8(%ebp),%esi
  101384:	8b 7d fc             	mov    -0x4(%ebp),%edi
  101387:	89 ec                	mov    %ebp,%esp
  101389:	5d                   	pop    %ebp
  10138a:	c3                   	ret    
  10138b:	90                   	nop
  10138c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
  101390:	0f b7 43 12          	movzwl 0x12(%ebx),%eax
  101394:	66 83 f8 09          	cmp    $0x9,%ax
  101398:	77 df                	ja     101379 <readi+0x29>
  10139a:	98                   	cwtl   
  10139b:	8b 04 c5 00 9a 10 00 	mov    0x109a00(,%eax,8),%eax
  1013a2:	85 c0                	test   %eax,%eax
  1013a4:	74 d3                	je     101379 <readi+0x29>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  1013a6:	89 4d 10             	mov    %ecx,0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
  1013a9:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1013ac:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1013af:	8b 7d fc             	mov    -0x4(%ebp),%edi
  1013b2:	89 ec                	mov    %ebp,%esp
  1013b4:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  1013b5:	ff e0                	jmp    *%eax
  1013b7:	90                   	nop
  }

  if(off > ip->size || off + n < off)
  1013b8:	89 ca                	mov    %ecx,%edx
  1013ba:	01 f2                	add    %esi,%edx
  1013bc:	72 bb                	jb     101379 <readi+0x29>
    return -1;
  if(off + n > ip->size)
  1013be:	39 d0                	cmp    %edx,%eax
  1013c0:	73 04                	jae    1013c6 <readi+0x76>
    n = ip->size - off;
  1013c2:	89 c1                	mov    %eax,%ecx
  1013c4:	29 f1                	sub    %esi,%ecx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  1013c6:	85 c9                	test   %ecx,%ecx
  1013c8:	74 7c                	je     101446 <readi+0xf6>
  1013ca:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
  1013d1:	89 7d e0             	mov    %edi,-0x20(%ebp)
  1013d4:	89 4d dc             	mov    %ecx,-0x24(%ebp)
  1013d7:	90                   	nop
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
  1013d8:	89 f2                	mov    %esi,%edx
  1013da:	89 d8                	mov    %ebx,%eax
  1013dc:	c1 ea 09             	shr    $0x9,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
  1013df:	bf 00 02 00 00       	mov    $0x200,%edi
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
  1013e4:	e8 b7 fe ff ff       	call   1012a0 <bmap>
  1013e9:	89 44 24 04          	mov    %eax,0x4(%esp)
  1013ed:	8b 03                	mov    (%ebx),%eax
  1013ef:	89 04 24             	mov    %eax,(%esp)
  1013f2:	e8 b9 ec ff ff       	call   1000b0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
  1013f7:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  1013fa:	2b 4d e4             	sub    -0x1c(%ebp),%ecx
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
  1013fd:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
  1013ff:	89 f0                	mov    %esi,%eax
  101401:	25 ff 01 00 00       	and    $0x1ff,%eax
  101406:	29 c7                	sub    %eax,%edi
  101408:	39 cf                	cmp    %ecx,%edi
  10140a:	76 02                	jbe    10140e <readi+0xbe>
  10140c:	89 cf                	mov    %ecx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
  10140e:	8d 44 02 18          	lea    0x18(%edx,%eax,1),%eax
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  101412:	01 fe                	add    %edi,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
  101414:	89 7c 24 08          	mov    %edi,0x8(%esp)
  101418:	89 44 24 04          	mov    %eax,0x4(%esp)
  10141c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10141f:	89 04 24             	mov    %eax,(%esp)
  101422:	89 55 d8             	mov    %edx,-0x28(%ebp)
  101425:	e8 16 28 00 00       	call   103c40 <memmove>
    brelse(bp);
  10142a:	8b 55 d8             	mov    -0x28(%ebp),%edx
  10142d:	89 14 24             	mov    %edx,(%esp)
  101430:	e8 cb eb ff ff       	call   100000 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  101435:	01 7d e4             	add    %edi,-0x1c(%ebp)
  101438:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10143b:	01 7d e0             	add    %edi,-0x20(%ebp)
  10143e:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  101441:	77 95                	ja     1013d8 <readi+0x88>
  101443:	8b 4d dc             	mov    -0x24(%ebp),%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
  101446:	89 c8                	mov    %ecx,%eax
  101448:	e9 31 ff ff ff       	jmp    10137e <readi+0x2e>
  10144d:	8d 76 00             	lea    0x0(%esi),%esi

00101450 <iupdate>:
}

// Copy inode, which has changed, from memory to disk.
void
iupdate(struct inode *ip)
{
  101450:	55                   	push   %ebp
  101451:	89 e5                	mov    %esp,%ebp
  101453:	56                   	push   %esi
  101454:	53                   	push   %ebx
  101455:	83 ec 10             	sub    $0x10,%esp
  101458:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum));
  10145b:	8b 43 04             	mov    0x4(%ebx),%eax
  10145e:	c1 e8 03             	shr    $0x3,%eax
  101461:	83 c0 02             	add    $0x2,%eax
  101464:	89 44 24 04          	mov    %eax,0x4(%esp)
  101468:	8b 03                	mov    (%ebx),%eax
  10146a:	89 04 24             	mov    %eax,(%esp)
  10146d:	e8 3e ec ff ff       	call   1000b0 <bread>
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  101472:	0f b7 53 10          	movzwl 0x10(%ebx),%edx
iupdate(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum));
  101476:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  101478:	8b 43 04             	mov    0x4(%ebx),%eax
  10147b:	83 e0 07             	and    $0x7,%eax
  10147e:	c1 e0 06             	shl    $0x6,%eax
  101481:	8d 44 06 18          	lea    0x18(%esi,%eax,1),%eax
  dip->type = ip->type;
  101485:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
  101488:	0f b7 53 12          	movzwl 0x12(%ebx),%edx
  10148c:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
  101490:	0f b7 53 14          	movzwl 0x14(%ebx),%edx
  101494:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
  101498:	0f b7 53 16          	movzwl 0x16(%ebx),%edx
  10149c:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
  1014a0:	8b 53 18             	mov    0x18(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  1014a3:	83 c3 1c             	add    $0x1c,%ebx
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  1014a6:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  1014a9:	83 c0 0c             	add    $0xc,%eax
  1014ac:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  1014b0:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
  1014b7:	00 
  1014b8:	89 04 24             	mov    %eax,(%esp)
  1014bb:	e8 80 27 00 00       	call   103c40 <memmove>
  bwrite(bp);
  1014c0:	89 34 24             	mov    %esi,(%esp)
  1014c3:	e8 b8 eb ff ff       	call   100080 <bwrite>
  brelse(bp);
  1014c8:	89 75 08             	mov    %esi,0x8(%ebp)
}
  1014cb:	83 c4 10             	add    $0x10,%esp
  1014ce:	5b                   	pop    %ebx
  1014cf:	5e                   	pop    %esi
  1014d0:	5d                   	pop    %ebp
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  bwrite(bp);
  brelse(bp);
  1014d1:	e9 2a eb ff ff       	jmp    100000 <brelse>
  1014d6:	8d 76 00             	lea    0x0(%esi),%esi
  1014d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001014e0 <writei>:
}

// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
  1014e0:	55                   	push   %ebp
  1014e1:	89 e5                	mov    %esp,%ebp
  1014e3:	83 ec 38             	sub    $0x38,%esp
  1014e6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  1014e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  1014ec:	89 75 f8             	mov    %esi,-0x8(%ebp)
  1014ef:	8b 4d 14             	mov    0x14(%ebp),%ecx
  1014f2:	89 7d fc             	mov    %edi,-0x4(%ebp)
  1014f5:	8b 75 10             	mov    0x10(%ebp),%esi
  1014f8:	8b 7d 0c             	mov    0xc(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
  1014fb:	66 83 7b 10 03       	cmpw   $0x3,0x10(%ebx)
  101500:	74 1e                	je     101520 <writei+0x40>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
  101502:	39 73 18             	cmp    %esi,0x18(%ebx)
  101505:	73 41                	jae    101548 <writei+0x68>

  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
  101507:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  10150c:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  10150f:	8b 75 f8             	mov    -0x8(%ebp),%esi
  101512:	8b 7d fc             	mov    -0x4(%ebp),%edi
  101515:	89 ec                	mov    %ebp,%esp
  101517:	5d                   	pop    %ebp
  101518:	c3                   	ret    
  101519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
  101520:	0f b7 43 12          	movzwl 0x12(%ebx),%eax
  101524:	66 83 f8 09          	cmp    $0x9,%ax
  101528:	77 dd                	ja     101507 <writei+0x27>
  10152a:	98                   	cwtl   
  10152b:	8b 04 c5 04 9a 10 00 	mov    0x109a04(,%eax,8),%eax
  101532:	85 c0                	test   %eax,%eax
  101534:	74 d1                	je     101507 <writei+0x27>
      return -1;
    return devsw[ip->major].write(ip, src, n);
  101536:	89 4d 10             	mov    %ecx,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
  101539:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  10153c:	8b 75 f8             	mov    -0x8(%ebp),%esi
  10153f:	8b 7d fc             	mov    -0x4(%ebp),%edi
  101542:	89 ec                	mov    %ebp,%esp
  101544:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  101545:	ff e0                	jmp    *%eax
  101547:	90                   	nop
  }

  if(off > ip->size || off + n < off)
  101548:	89 c8                	mov    %ecx,%eax
  10154a:	01 f0                	add    %esi,%eax
  10154c:	72 b9                	jb     101507 <writei+0x27>
    return -1;
  if(off + n > MAXFILE*BSIZE)
  10154e:	3d 00 18 01 00       	cmp    $0x11800,%eax
  101553:	76 07                	jbe    10155c <writei+0x7c>
    n = MAXFILE*BSIZE - off;
  101555:	b9 00 18 01 00       	mov    $0x11800,%ecx
  10155a:	29 f1                	sub    %esi,%ecx

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
  10155c:	85 c9                	test   %ecx,%ecx
  10155e:	0f 84 92 00 00 00    	je     1015f6 <writei+0x116>
  101564:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
  10156b:	89 7d e0             	mov    %edi,-0x20(%ebp)
  10156e:	89 4d dc             	mov    %ecx,-0x24(%ebp)
  101571:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
  101578:	89 f2                	mov    %esi,%edx
  10157a:	89 d8                	mov    %ebx,%eax
  10157c:	c1 ea 09             	shr    $0x9,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
  10157f:	bf 00 02 00 00       	mov    $0x200,%edi
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
  101584:	e8 17 fd ff ff       	call   1012a0 <bmap>
  101589:	89 44 24 04          	mov    %eax,0x4(%esp)
  10158d:	8b 03                	mov    (%ebx),%eax
  10158f:	89 04 24             	mov    %eax,(%esp)
  101592:	e8 19 eb ff ff       	call   1000b0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
  101597:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  10159a:	2b 4d e4             	sub    -0x1c(%ebp),%ecx
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
  10159d:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
  10159f:	89 f0                	mov    %esi,%eax
  1015a1:	25 ff 01 00 00       	and    $0x1ff,%eax
  1015a6:	29 c7                	sub    %eax,%edi
  1015a8:	39 cf                	cmp    %ecx,%edi
  1015aa:	76 02                	jbe    1015ae <writei+0xce>
  1015ac:	89 cf                	mov    %ecx,%edi
    memmove(bp->data + off%BSIZE, src, m);
  1015ae:	89 7c 24 08          	mov    %edi,0x8(%esp)
  1015b2:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  1015b5:	8d 44 02 18          	lea    0x18(%edx,%eax,1),%eax
  1015b9:	89 04 24             	mov    %eax,(%esp)
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
  1015bc:	01 fe                	add    %edi,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
  1015be:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  1015c2:	89 55 d8             	mov    %edx,-0x28(%ebp)
  1015c5:	e8 76 26 00 00       	call   103c40 <memmove>
    bwrite(bp);
  1015ca:	8b 55 d8             	mov    -0x28(%ebp),%edx
  1015cd:	89 14 24             	mov    %edx,(%esp)
  1015d0:	e8 ab ea ff ff       	call   100080 <bwrite>
    brelse(bp);
  1015d5:	8b 55 d8             	mov    -0x28(%ebp),%edx
  1015d8:	89 14 24             	mov    %edx,(%esp)
  1015db:	e8 20 ea ff ff       	call   100000 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
  1015e0:	01 7d e4             	add    %edi,-0x1c(%ebp)
  1015e3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1015e6:	01 7d e0             	add    %edi,-0x20(%ebp)
  1015e9:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  1015ec:	77 8a                	ja     101578 <writei+0x98>
    memmove(bp->data + off%BSIZE, src, m);
    bwrite(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
  1015ee:	3b 73 18             	cmp    0x18(%ebx),%esi
  1015f1:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  1015f4:	77 07                	ja     1015fd <writei+0x11d>
    ip->size = off;
    iupdate(ip);
  }
  return n;
  1015f6:	89 c8                	mov    %ecx,%eax
  1015f8:	e9 0f ff ff ff       	jmp    10150c <writei+0x2c>
    bwrite(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
  1015fd:	89 73 18             	mov    %esi,0x18(%ebx)
    iupdate(ip);
  101600:	89 1c 24             	mov    %ebx,(%esp)
  101603:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  101606:	e8 45 fe ff ff       	call   101450 <iupdate>
  10160b:	8b 4d d8             	mov    -0x28(%ebp),%ecx
  }
  return n;
  10160e:	89 c8                	mov    %ecx,%eax
  101610:	e9 f7 fe ff ff       	jmp    10150c <writei+0x2c>
  101615:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  101619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101620 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
  101620:	55                   	push   %ebp
  101621:	89 e5                	mov    %esp,%ebp
  101623:	83 ec 18             	sub    $0x18,%esp
  return strncmp(s, t, DIRSIZ);
  101626:	8b 45 0c             	mov    0xc(%ebp),%eax
  101629:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
  101630:	00 
  101631:	89 44 24 04          	mov    %eax,0x4(%esp)
  101635:	8b 45 08             	mov    0x8(%ebp),%eax
  101638:	89 04 24             	mov    %eax,(%esp)
  10163b:	e8 70 26 00 00       	call   103cb0 <strncmp>
}
  101640:	c9                   	leave  
  101641:	c3                   	ret    
  101642:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  101649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101650 <dirlookup>:
// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
// Caller must have already locked dp.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
  101650:	55                   	push   %ebp
  101651:	89 e5                	mov    %esp,%ebp
  101653:	57                   	push   %edi
  101654:	56                   	push   %esi
  101655:	53                   	push   %ebx
  101656:	83 ec 3c             	sub    $0x3c,%esp
  101659:	8b 45 08             	mov    0x8(%ebp),%eax
  10165c:	8b 55 10             	mov    0x10(%ebp),%edx
  10165f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  101662:	89 45 dc             	mov    %eax,-0x24(%ebp)
  101665:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  uint off, inum;
  struct buf *bp;
  struct dirent *de;

  if(dp->type != T_DIR)
  101668:	66 83 78 10 01       	cmpw   $0x1,0x10(%eax)
  10166d:	0f 85 d0 00 00 00    	jne    101743 <dirlookup+0xf3>
    panic("dirlookup not DIR");
  101673:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)

  for(off = 0; off < dp->size; off += BSIZE){
  10167a:	8b 48 18             	mov    0x18(%eax),%ecx
  10167d:	85 c9                	test   %ecx,%ecx
  10167f:	0f 84 b4 00 00 00    	je     101739 <dirlookup+0xe9>
    bp = bread(dp->dev, bmap(dp, off / BSIZE));
  101685:	8b 55 e0             	mov    -0x20(%ebp),%edx
  101688:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10168b:	c1 ea 09             	shr    $0x9,%edx
  10168e:	e8 0d fc ff ff       	call   1012a0 <bmap>
  101693:	89 44 24 04          	mov    %eax,0x4(%esp)
  101697:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  10169a:	8b 01                	mov    (%ecx),%eax
  10169c:	89 04 24             	mov    %eax,(%esp)
  10169f:	e8 0c ea ff ff       	call   1000b0 <bread>
  1016a4:	89 45 e4             	mov    %eax,-0x1c(%ebp)

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
// Caller must have already locked dp.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
  1016a7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += BSIZE){
    bp = bread(dp->dev, bmap(dp, off / BSIZE));
    for(de = (struct dirent*)bp->data;
  1016aa:	83 c0 18             	add    $0x18,%eax
  1016ad:	89 45 d8             	mov    %eax,-0x28(%ebp)
  1016b0:	89 c6                	mov    %eax,%esi

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
// Caller must have already locked dp.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
  1016b2:	81 c7 18 02 00 00    	add    $0x218,%edi
  1016b8:	eb 0d                	jmp    1016c7 <dirlookup+0x77>
  1016ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  for(off = 0; off < dp->size; off += BSIZE){
    bp = bread(dp->dev, bmap(dp, off / BSIZE));
    for(de = (struct dirent*)bp->data;
        de < (struct dirent*)(bp->data + BSIZE);
        de++){
  1016c0:	83 c6 10             	add    $0x10,%esi
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += BSIZE){
    bp = bread(dp->dev, bmap(dp, off / BSIZE));
    for(de = (struct dirent*)bp->data;
  1016c3:	39 fe                	cmp    %edi,%esi
  1016c5:	74 51                	je     101718 <dirlookup+0xc8>
        de < (struct dirent*)(bp->data + BSIZE);
        de++){
      if(de->inum == 0)
  1016c7:	66 83 3e 00          	cmpw   $0x0,(%esi)
  1016cb:	74 f3                	je     1016c0 <dirlookup+0x70>
        continue;
      if(namecmp(name, de->name) == 0){
  1016cd:	8d 46 02             	lea    0x2(%esi),%eax
  1016d0:	89 44 24 04          	mov    %eax,0x4(%esp)
  1016d4:	89 1c 24             	mov    %ebx,(%esp)
  1016d7:	e8 44 ff ff ff       	call   101620 <namecmp>
  1016dc:	85 c0                	test   %eax,%eax
  1016de:	75 e0                	jne    1016c0 <dirlookup+0x70>
        // entry matches path element
        if(poff)
  1016e0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1016e3:	85 d2                	test   %edx,%edx
  1016e5:	74 0e                	je     1016f5 <dirlookup+0xa5>
          *poff = off + (uchar*)de - bp->data;
  1016e7:	8b 55 e0             	mov    -0x20(%ebp),%edx
  1016ea:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  1016ed:	8d 04 16             	lea    (%esi,%edx,1),%eax
  1016f0:	2b 45 d8             	sub    -0x28(%ebp),%eax
  1016f3:	89 01                	mov    %eax,(%ecx)
        inum = de->inum;
        brelse(bp);
  1016f5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
        continue;
      if(namecmp(name, de->name) == 0){
        // entry matches path element
        if(poff)
          *poff = off + (uchar*)de - bp->data;
        inum = de->inum;
  1016f8:	0f b7 1e             	movzwl (%esi),%ebx
        brelse(bp);
  1016fb:	89 04 24             	mov    %eax,(%esp)
  1016fe:	e8 fd e8 ff ff       	call   100000 <brelse>
        return iget(dp->dev, inum);
  101703:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  101706:	89 da                	mov    %ebx,%edx
  101708:	8b 01                	mov    (%ecx),%eax
      }
    }
    brelse(bp);
  }
  return 0;
}
  10170a:	83 c4 3c             	add    $0x3c,%esp
  10170d:	5b                   	pop    %ebx
  10170e:	5e                   	pop    %esi
  10170f:	5f                   	pop    %edi
  101710:	5d                   	pop    %ebp
        // entry matches path element
        if(poff)
          *poff = off + (uchar*)de - bp->data;
        inum = de->inum;
        brelse(bp);
        return iget(dp->dev, inum);
  101711:	e9 aa f9 ff ff       	jmp    1010c0 <iget>
  101716:	66 90                	xchg   %ax,%ax
      }
    }
    brelse(bp);
  101718:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10171b:	89 04 24             	mov    %eax,(%esp)
  10171e:	e8 dd e8 ff ff       	call   100000 <brelse>
  struct dirent *de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += BSIZE){
  101723:	8b 55 dc             	mov    -0x24(%ebp),%edx
  101726:	81 45 e0 00 02 00 00 	addl   $0x200,-0x20(%ebp)
  10172d:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  101730:	39 4a 18             	cmp    %ecx,0x18(%edx)
  101733:	0f 87 4c ff ff ff    	ja     101685 <dirlookup+0x35>
      }
    }
    brelse(bp);
  }
  return 0;
}
  101739:	83 c4 3c             	add    $0x3c,%esp
  10173c:	31 c0                	xor    %eax,%eax
  10173e:	5b                   	pop    %ebx
  10173f:	5e                   	pop    %esi
  101740:	5f                   	pop    %edi
  101741:	5d                   	pop    %ebp
  101742:	c3                   	ret    
  uint off, inum;
  struct buf *bp;
  struct dirent *de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
  101743:	c7 04 24 64 65 10 00 	movl   $0x106564,(%esp)
  10174a:	e8 61 f1 ff ff       	call   1008b0 <panic>
  10174f:	90                   	nop

00101750 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  101750:	55                   	push   %ebp
  101751:	89 e5                	mov    %esp,%ebp
  101753:	53                   	push   %ebx
  101754:	83 ec 14             	sub    $0x14,%esp
  101757:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
  10175a:	85 db                	test   %ebx,%ebx
  10175c:	74 36                	je     101794 <iunlock+0x44>
  10175e:	f6 43 0c 01          	testb  $0x1,0xc(%ebx)
  101762:	74 30                	je     101794 <iunlock+0x44>
  101764:	8b 43 08             	mov    0x8(%ebx),%eax
  101767:	85 c0                	test   %eax,%eax
  101769:	7e 29                	jle    101794 <iunlock+0x44>
    panic("iunlock");

  acquire(&icache.lock);
  10176b:	c7 04 24 60 9a 10 00 	movl   $0x109a60,(%esp)
  101772:	e8 a9 23 00 00       	call   103b20 <acquire>
  ip->flags &= ~I_BUSY;
  101777:	83 63 0c fe          	andl   $0xfffffffe,0xc(%ebx)
  wakeup(ip);
  10177b:	89 1c 24             	mov    %ebx,(%esp)
  10177e:	e8 cd 18 00 00       	call   103050 <wakeup>
  release(&icache.lock);
  101783:	c7 45 08 60 9a 10 00 	movl   $0x109a60,0x8(%ebp)
}
  10178a:	83 c4 14             	add    $0x14,%esp
  10178d:	5b                   	pop    %ebx
  10178e:	5d                   	pop    %ebp
    panic("iunlock");

  acquire(&icache.lock);
  ip->flags &= ~I_BUSY;
  wakeup(ip);
  release(&icache.lock);
  10178f:	e9 3c 23 00 00       	jmp    103ad0 <release>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
    panic("iunlock");
  101794:	c7 04 24 76 65 10 00 	movl   $0x106576,(%esp)
  10179b:	e8 10 f1 ff ff       	call   1008b0 <panic>

001017a0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
  1017a0:	55                   	push   %ebp
  1017a1:	89 e5                	mov    %esp,%ebp
  1017a3:	57                   	push   %edi
  1017a4:	56                   	push   %esi
  1017a5:	89 c6                	mov    %eax,%esi
  1017a7:	53                   	push   %ebx
  1017a8:	89 d3                	mov    %edx,%ebx
  1017aa:	83 ec 2c             	sub    $0x2c,%esp
static void
bzero(int dev, int bno)
{
  struct buf *bp;
  
  bp = bread(dev, bno);
  1017ad:	89 54 24 04          	mov    %edx,0x4(%esp)
  1017b1:	89 04 24             	mov    %eax,(%esp)
  1017b4:	e8 f7 e8 ff ff       	call   1000b0 <bread>
  memset(bp->data, 0, BSIZE);
  1017b9:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  1017c0:	00 
  1017c1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1017c8:	00 
static void
bzero(int dev, int bno)
{
  struct buf *bp;
  
  bp = bread(dev, bno);
  1017c9:	89 c7                	mov    %eax,%edi
  memset(bp->data, 0, BSIZE);
  1017cb:	8d 40 18             	lea    0x18(%eax),%eax
  1017ce:	89 04 24             	mov    %eax,(%esp)
  1017d1:	e8 ea 23 00 00       	call   103bc0 <memset>
  bwrite(bp);
  1017d6:	89 3c 24             	mov    %edi,(%esp)
  1017d9:	e8 a2 e8 ff ff       	call   100080 <bwrite>
  brelse(bp);
  1017de:	89 3c 24             	mov    %edi,(%esp)
  1017e1:	e8 1a e8 ff ff       	call   100000 <brelse>
  struct superblock sb;
  int bi, m;

  bzero(dev, b);

  readsb(dev, &sb);
  1017e6:	89 f0                	mov    %esi,%eax
  1017e8:	8d 55 dc             	lea    -0x24(%ebp),%edx
  1017eb:	e8 90 f9 ff ff       	call   101180 <readsb>
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  1017f0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1017f3:	89 da                	mov    %ebx,%edx
  1017f5:	c1 ea 0c             	shr    $0xc,%edx
  1017f8:	89 34 24             	mov    %esi,(%esp)
  bi = b % BPB;
  m = 1 << (bi % 8);
  1017fb:	be 01 00 00 00       	mov    $0x1,%esi
  int bi, m;

  bzero(dev, b);

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  101800:	c1 e8 03             	shr    $0x3,%eax
  101803:	8d 44 10 03          	lea    0x3(%eax,%edx,1),%eax
  101807:	89 44 24 04          	mov    %eax,0x4(%esp)
  10180b:	e8 a0 e8 ff ff       	call   1000b0 <bread>
  bi = b % BPB;
  101810:	89 da                	mov    %ebx,%edx
  m = 1 << (bi % 8);
  101812:	89 d9                	mov    %ebx,%ecx

  bzero(dev, b);

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  bi = b % BPB;
  101814:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
  m = 1 << (bi % 8);
  10181a:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
  10181d:	c1 fa 03             	sar    $0x3,%edx
  bzero(dev, b);

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  bi = b % BPB;
  m = 1 << (bi % 8);
  101820:	d3 e6                	shl    %cl,%esi
  if((bp->data[bi/8] & m) == 0)
  101822:	0f b6 4c 10 18       	movzbl 0x18(%eax,%edx,1),%ecx
  int bi, m;

  bzero(dev, b);

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  101827:	89 c7                	mov    %eax,%edi
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
  101829:	0f b6 c1             	movzbl %cl,%eax
  10182c:	85 f0                	test   %esi,%eax
  10182e:	74 22                	je     101852 <bfree+0xb2>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;  // Mark block free on disk.
  101830:	89 f0                	mov    %esi,%eax
  101832:	f7 d0                	not    %eax
  101834:	21 c8                	and    %ecx,%eax
  101836:	88 44 17 18          	mov    %al,0x18(%edi,%edx,1)
  bwrite(bp);
  10183a:	89 3c 24             	mov    %edi,(%esp)
  10183d:	e8 3e e8 ff ff       	call   100080 <bwrite>
  brelse(bp);
  101842:	89 3c 24             	mov    %edi,(%esp)
  101845:	e8 b6 e7 ff ff       	call   100000 <brelse>
}
  10184a:	83 c4 2c             	add    $0x2c,%esp
  10184d:	5b                   	pop    %ebx
  10184e:	5e                   	pop    %esi
  10184f:	5f                   	pop    %edi
  101850:	5d                   	pop    %ebp
  101851:	c3                   	ret    
  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
  101852:	c7 04 24 7e 65 10 00 	movl   $0x10657e,(%esp)
  101859:	e8 52 f0 ff ff       	call   1008b0 <panic>
  10185e:	66 90                	xchg   %ax,%ax

00101860 <iput>:
}

// Caller holds reference to unlocked ip.  Drop reference.
void
iput(struct inode *ip)
{
  101860:	55                   	push   %ebp
  101861:	89 e5                	mov    %esp,%ebp
  101863:	57                   	push   %edi
  101864:	56                   	push   %esi
  101865:	53                   	push   %ebx
  101866:	83 ec 2c             	sub    $0x2c,%esp
  101869:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&icache.lock);
  10186c:	c7 04 24 60 9a 10 00 	movl   $0x109a60,(%esp)
  101873:	e8 a8 22 00 00       	call   103b20 <acquire>
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
  101878:	8b 46 08             	mov    0x8(%esi),%eax
  10187b:	83 f8 01             	cmp    $0x1,%eax
  10187e:	0f 85 a1 00 00 00    	jne    101925 <iput+0xc5>
  101884:	8b 56 0c             	mov    0xc(%esi),%edx
  101887:	f6 c2 02             	test   $0x2,%dl
  10188a:	0f 84 95 00 00 00    	je     101925 <iput+0xc5>
  101890:	66 83 7e 16 00       	cmpw   $0x0,0x16(%esi)
  101895:	0f 85 8a 00 00 00    	jne    101925 <iput+0xc5>
    // inode is no longer used: truncate and free inode.
    if(ip->flags & I_BUSY)
  10189b:	f6 c2 01             	test   $0x1,%dl
  10189e:	66 90                	xchg   %ax,%ax
  1018a0:	0f 85 f8 00 00 00    	jne    10199e <iput+0x13e>
      panic("iput busy");
    ip->flags |= I_BUSY;
  1018a6:	83 ca 01             	or     $0x1,%edx
    release(&icache.lock);
  1018a9:	89 f3                	mov    %esi,%ebx
  acquire(&icache.lock);
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
    // inode is no longer used: truncate and free inode.
    if(ip->flags & I_BUSY)
      panic("iput busy");
    ip->flags |= I_BUSY;
  1018ab:	89 56 0c             	mov    %edx,0xc(%esi)
  release(&icache.lock);
}

// Caller holds reference to unlocked ip.  Drop reference.
void
iput(struct inode *ip)
  1018ae:	8d 7e 30             	lea    0x30(%esi),%edi
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
    // inode is no longer used: truncate and free inode.
    if(ip->flags & I_BUSY)
      panic("iput busy");
    ip->flags |= I_BUSY;
    release(&icache.lock);
  1018b1:	c7 04 24 60 9a 10 00 	movl   $0x109a60,(%esp)
  1018b8:	e8 13 22 00 00       	call   103ad0 <release>
  1018bd:	eb 08                	jmp    1018c7 <iput+0x67>
  1018bf:	90                   	nop
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    if(ip->addrs[i]){
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
  1018c0:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
  1018c3:	39 fb                	cmp    %edi,%ebx
  1018c5:	74 1c                	je     1018e3 <iput+0x83>
    if(ip->addrs[i]){
  1018c7:	8b 53 1c             	mov    0x1c(%ebx),%edx
  1018ca:	85 d2                	test   %edx,%edx
  1018cc:	74 f2                	je     1018c0 <iput+0x60>
      bfree(ip->dev, ip->addrs[i]);
  1018ce:	8b 06                	mov    (%esi),%eax
  1018d0:	e8 cb fe ff ff       	call   1017a0 <bfree>
      ip->addrs[i] = 0;
  1018d5:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
  1018dc:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
  1018df:	39 fb                	cmp    %edi,%ebx
  1018e1:	75 e4                	jne    1018c7 <iput+0x67>
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[NDIRECT]){
  1018e3:	8b 46 4c             	mov    0x4c(%esi),%eax
  1018e6:	85 c0                	test   %eax,%eax
  1018e8:	75 56                	jne    101940 <iput+0xe0>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  1018ea:	c7 46 18 00 00 00 00 	movl   $0x0,0x18(%esi)
  iupdate(ip);
  1018f1:	89 34 24             	mov    %esi,(%esp)
  1018f4:	e8 57 fb ff ff       	call   101450 <iupdate>
    if(ip->flags & I_BUSY)
      panic("iput busy");
    ip->flags |= I_BUSY;
    release(&icache.lock);
    itrunc(ip);
    ip->type = 0;
  1018f9:	66 c7 46 10 00 00    	movw   $0x0,0x10(%esi)
    iupdate(ip);
  1018ff:	89 34 24             	mov    %esi,(%esp)
  101902:	e8 49 fb ff ff       	call   101450 <iupdate>
    acquire(&icache.lock);
  101907:	c7 04 24 60 9a 10 00 	movl   $0x109a60,(%esp)
  10190e:	e8 0d 22 00 00       	call   103b20 <acquire>
    ip->flags = 0;
  101913:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
    wakeup(ip);
  10191a:	89 34 24             	mov    %esi,(%esp)
  10191d:	e8 2e 17 00 00       	call   103050 <wakeup>
  101922:	8b 46 08             	mov    0x8(%esi),%eax
  }
  ip->ref--;
  101925:	83 e8 01             	sub    $0x1,%eax
  101928:	89 46 08             	mov    %eax,0x8(%esi)
  release(&icache.lock);
  10192b:	c7 45 08 60 9a 10 00 	movl   $0x109a60,0x8(%ebp)
}
  101932:	83 c4 2c             	add    $0x2c,%esp
  101935:	5b                   	pop    %ebx
  101936:	5e                   	pop    %esi
  101937:	5f                   	pop    %edi
  101938:	5d                   	pop    %ebp
    acquire(&icache.lock);
    ip->flags = 0;
    wakeup(ip);
  }
  ip->ref--;
  release(&icache.lock);
  101939:	e9 92 21 00 00       	jmp    103ad0 <release>
  10193e:	66 90                	xchg   %ax,%ax
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
  101940:	89 44 24 04          	mov    %eax,0x4(%esp)
  101944:	8b 06                	mov    (%esi),%eax
    a = (uint*)bp->data;
  101946:	31 db                	xor    %ebx,%ebx
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
  101948:	89 04 24             	mov    %eax,(%esp)
  10194b:	e8 60 e7 ff ff       	call   1000b0 <bread>
    a = (uint*)bp->data;
  101950:	89 c7                	mov    %eax,%edi
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
  101952:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
  101955:	83 c7 18             	add    $0x18,%edi
  101958:	31 c0                	xor    %eax,%eax
  10195a:	eb 11                	jmp    10196d <iput+0x10d>
  10195c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(j = 0; j < NINDIRECT; j++){
  101960:	83 c3 01             	add    $0x1,%ebx
  101963:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
  101969:	89 d8                	mov    %ebx,%eax
  10196b:	74 10                	je     10197d <iput+0x11d>
      if(a[j])
  10196d:	8b 14 87             	mov    (%edi,%eax,4),%edx
  101970:	85 d2                	test   %edx,%edx
  101972:	74 ec                	je     101960 <iput+0x100>
        bfree(ip->dev, a[j]);
  101974:	8b 06                	mov    (%esi),%eax
  101976:	e8 25 fe ff ff       	call   1017a0 <bfree>
  10197b:	eb e3                	jmp    101960 <iput+0x100>
    }
    brelse(bp);
  10197d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  101980:	89 04 24             	mov    %eax,(%esp)
  101983:	e8 78 e6 ff ff       	call   100000 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
  101988:	8b 56 4c             	mov    0x4c(%esi),%edx
  10198b:	8b 06                	mov    (%esi),%eax
  10198d:	e8 0e fe ff ff       	call   1017a0 <bfree>
    ip->addrs[NDIRECT] = 0;
  101992:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  101999:	e9 4c ff ff ff       	jmp    1018ea <iput+0x8a>
{
  acquire(&icache.lock);
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
    // inode is no longer used: truncate and free inode.
    if(ip->flags & I_BUSY)
      panic("iput busy");
  10199e:	c7 04 24 91 65 10 00 	movl   $0x106591,(%esp)
  1019a5:	e8 06 ef ff ff       	call   1008b0 <panic>
  1019aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001019b0 <dirlink>:
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
  1019b0:	55                   	push   %ebp
  1019b1:	89 e5                	mov    %esp,%ebp
  1019b3:	57                   	push   %edi
  1019b4:	56                   	push   %esi
  1019b5:	53                   	push   %ebx
  1019b6:	83 ec 2c             	sub    $0x2c,%esp
  1019b9:	8b 75 08             	mov    0x8(%ebp),%esi
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
  1019bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  1019bf:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  1019c6:	00 
  1019c7:	89 34 24             	mov    %esi,(%esp)
  1019ca:	89 44 24 04          	mov    %eax,0x4(%esp)
  1019ce:	e8 7d fc ff ff       	call   101650 <dirlookup>
  1019d3:	85 c0                	test   %eax,%eax
  1019d5:	0f 85 89 00 00 00    	jne    101a64 <dirlink+0xb4>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
  1019db:	8b 56 18             	mov    0x18(%esi),%edx
  1019de:	85 d2                	test   %edx,%edx
  1019e0:	0f 84 8d 00 00 00    	je     101a73 <dirlink+0xc3>
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
    return -1;
  1019e6:	8d 7d d8             	lea    -0x28(%ebp),%edi
  1019e9:	31 db                	xor    %ebx,%ebx
  1019eb:	eb 0b                	jmp    1019f8 <dirlink+0x48>
  1019ed:	8d 76 00             	lea    0x0(%esi),%esi
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
  1019f0:	83 c3 10             	add    $0x10,%ebx
  1019f3:	39 5e 18             	cmp    %ebx,0x18(%esi)
  1019f6:	76 24                	jbe    101a1c <dirlink+0x6c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  1019f8:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  1019ff:	00 
  101a00:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  101a04:	89 7c 24 04          	mov    %edi,0x4(%esp)
  101a08:	89 34 24             	mov    %esi,(%esp)
  101a0b:	e8 40 f9 ff ff       	call   101350 <readi>
  101a10:	83 f8 10             	cmp    $0x10,%eax
  101a13:	75 65                	jne    101a7a <dirlink+0xca>
      panic("dirlink read");
    if(de.inum == 0)
  101a15:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
  101a1a:	75 d4                	jne    1019f0 <dirlink+0x40>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  101a1c:	8b 45 0c             	mov    0xc(%ebp),%eax
  101a1f:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
  101a26:	00 
  101a27:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a2b:	8d 45 da             	lea    -0x26(%ebp),%eax
  101a2e:	89 04 24             	mov    %eax,(%esp)
  101a31:	e8 da 22 00 00       	call   103d10 <strncpy>
  de.inum = inum;
  101a36:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  101a39:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  101a40:	00 
  101a41:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  101a45:	89 7c 24 04          	mov    %edi,0x4(%esp)
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  101a49:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  101a4d:	89 34 24             	mov    %esi,(%esp)
  101a50:	e8 8b fa ff ff       	call   1014e0 <writei>
  101a55:	83 f8 10             	cmp    $0x10,%eax
  101a58:	75 2c                	jne    101a86 <dirlink+0xd6>
    panic("dirlink");
  101a5a:	31 c0                	xor    %eax,%eax
  
  return 0;
}
  101a5c:	83 c4 2c             	add    $0x2c,%esp
  101a5f:	5b                   	pop    %ebx
  101a60:	5e                   	pop    %esi
  101a61:	5f                   	pop    %edi
  101a62:	5d                   	pop    %ebp
  101a63:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
  101a64:	89 04 24             	mov    %eax,(%esp)
  101a67:	e8 f4 fd ff ff       	call   101860 <iput>
  101a6c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    return -1;
  101a71:	eb e9                	jmp    101a5c <dirlink+0xac>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
  101a73:	8d 7d d8             	lea    -0x28(%ebp),%edi
  101a76:	31 db                	xor    %ebx,%ebx
  101a78:	eb a2                	jmp    101a1c <dirlink+0x6c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
  101a7a:	c7 04 24 9b 65 10 00 	movl   $0x10659b,(%esp)
  101a81:	e8 2a ee ff ff       	call   1008b0 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
  101a86:	c7 04 24 6a 6b 10 00 	movl   $0x106b6a,(%esp)
  101a8d:	e8 1e ee ff ff       	call   1008b0 <panic>
  101a92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  101a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101aa0 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  101aa0:	55                   	push   %ebp
  101aa1:	89 e5                	mov    %esp,%ebp
  101aa3:	53                   	push   %ebx
  101aa4:	83 ec 14             	sub    $0x14,%esp
  101aa7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
  101aaa:	89 1c 24             	mov    %ebx,(%esp)
  101aad:	e8 9e fc ff ff       	call   101750 <iunlock>
  iput(ip);
  101ab2:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
  101ab5:	83 c4 14             	add    $0x14,%esp
  101ab8:	5b                   	pop    %ebx
  101ab9:	5d                   	pop    %ebp
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
  101aba:	e9 a1 fd ff ff       	jmp    101860 <iput>
  101abf:	90                   	nop

00101ac0 <ialloc>:
static struct inode* iget(uint dev, uint inum);

// Allocate a new inode with the given type on device dev.
struct inode*
ialloc(uint dev, short type)
{
  101ac0:	55                   	push   %ebp
  101ac1:	89 e5                	mov    %esp,%ebp
  101ac3:	57                   	push   %edi
  101ac4:	56                   	push   %esi
  101ac5:	53                   	push   %ebx
  101ac6:	83 ec 3c             	sub    $0x3c,%esp
  101ac9:	0f b7 45 0c          	movzwl 0xc(%ebp),%eax
  int inum;
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
  101acd:	8d 55 dc             	lea    -0x24(%ebp),%edx
static struct inode* iget(uint dev, uint inum);

// Allocate a new inode with the given type on device dev.
struct inode*
ialloc(uint dev, short type)
{
  101ad0:	66 89 45 d6          	mov    %ax,-0x2a(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
  101ad4:	8b 45 08             	mov    0x8(%ebp),%eax
  101ad7:	e8 a4 f6 ff ff       	call   101180 <readsb>
  for(inum = 1; inum < sb.ninodes; inum++){  // loop over inode blocks
  101adc:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
  101ae0:	0f 86 96 00 00 00    	jbe    101b7c <ialloc+0xbc>
  101ae6:	be 01 00 00 00       	mov    $0x1,%esi
  101aeb:	bb 01 00 00 00       	mov    $0x1,%ebx
  101af0:	eb 18                	jmp    101b0a <ialloc+0x4a>
  101af2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  101af8:	83 c3 01             	add    $0x1,%ebx
      dip->type = type;
      bwrite(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  101afb:	89 3c 24             	mov    %edi,(%esp)
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
  for(inum = 1; inum < sb.ninodes; inum++){  // loop over inode blocks
  101afe:	89 de                	mov    %ebx,%esi
      dip->type = type;
      bwrite(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  101b00:	e8 fb e4 ff ff       	call   100000 <brelse>
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
  for(inum = 1; inum < sb.ninodes; inum++){  // loop over inode blocks
  101b05:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
  101b08:	76 72                	jbe    101b7c <ialloc+0xbc>
    bp = bread(dev, IBLOCK(inum));
  101b0a:	89 f0                	mov    %esi,%eax
  101b0c:	c1 e8 03             	shr    $0x3,%eax
  101b0f:	83 c0 02             	add    $0x2,%eax
  101b12:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b16:	8b 45 08             	mov    0x8(%ebp),%eax
  101b19:	89 04 24             	mov    %eax,(%esp)
  101b1c:	e8 8f e5 ff ff       	call   1000b0 <bread>
  101b21:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
  101b23:	89 f0                	mov    %esi,%eax
  101b25:	83 e0 07             	and    $0x7,%eax
  101b28:	c1 e0 06             	shl    $0x6,%eax
  101b2b:	8d 54 07 18          	lea    0x18(%edi,%eax,1),%edx
    if(dip->type == 0){  // a free inode
  101b2f:	66 83 3a 00          	cmpw   $0x0,(%edx)
  101b33:	75 c3                	jne    101af8 <ialloc+0x38>
      memset(dip, 0, sizeof(*dip));
  101b35:	89 14 24             	mov    %edx,(%esp)
  101b38:	89 55 d0             	mov    %edx,-0x30(%ebp)
  101b3b:	c7 44 24 08 40 00 00 	movl   $0x40,0x8(%esp)
  101b42:	00 
  101b43:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  101b4a:	00 
  101b4b:	e8 70 20 00 00       	call   103bc0 <memset>
      dip->type = type;
  101b50:	8b 55 d0             	mov    -0x30(%ebp),%edx
  101b53:	0f b7 45 d6          	movzwl -0x2a(%ebp),%eax
  101b57:	66 89 02             	mov    %ax,(%edx)
      bwrite(bp);   // mark it allocated on the disk
  101b5a:	89 3c 24             	mov    %edi,(%esp)
  101b5d:	e8 1e e5 ff ff       	call   100080 <bwrite>
      brelse(bp);
  101b62:	89 3c 24             	mov    %edi,(%esp)
  101b65:	e8 96 e4 ff ff       	call   100000 <brelse>
      return iget(dev, inum);
  101b6a:	8b 45 08             	mov    0x8(%ebp),%eax
  101b6d:	89 f2                	mov    %esi,%edx
  101b6f:	e8 4c f5 ff ff       	call   1010c0 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
  101b74:	83 c4 3c             	add    $0x3c,%esp
  101b77:	5b                   	pop    %ebx
  101b78:	5e                   	pop    %esi
  101b79:	5f                   	pop    %edi
  101b7a:	5d                   	pop    %ebp
  101b7b:	c3                   	ret    
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
  101b7c:	c7 04 24 a8 65 10 00 	movl   $0x1065a8,(%esp)
  101b83:	e8 28 ed ff ff       	call   1008b0 <panic>
  101b88:	90                   	nop
  101b89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00101b90 <ilock>:
}

// Lock the given inode.
void
ilock(struct inode *ip)
{
  101b90:	55                   	push   %ebp
  101b91:	89 e5                	mov    %esp,%ebp
  101b93:	56                   	push   %esi
  101b94:	53                   	push   %ebx
  101b95:	83 ec 10             	sub    $0x10,%esp
  101b98:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
  101b9b:	85 db                	test   %ebx,%ebx
  101b9d:	0f 84 e5 00 00 00    	je     101c88 <ilock+0xf8>
  101ba3:	8b 4b 08             	mov    0x8(%ebx),%ecx
  101ba6:	85 c9                	test   %ecx,%ecx
  101ba8:	0f 8e da 00 00 00    	jle    101c88 <ilock+0xf8>
    panic("ilock");

  acquire(&icache.lock);
  101bae:	c7 04 24 60 9a 10 00 	movl   $0x109a60,(%esp)
  101bb5:	e8 66 1f 00 00       	call   103b20 <acquire>
  while(ip->flags & I_BUSY)
  101bba:	8b 43 0c             	mov    0xc(%ebx),%eax
  101bbd:	a8 01                	test   $0x1,%al
  101bbf:	74 1e                	je     101bdf <ilock+0x4f>
  101bc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(ip, &icache.lock);
  101bc8:	c7 44 24 04 60 9a 10 	movl   $0x109a60,0x4(%esp)
  101bcf:	00 
  101bd0:	89 1c 24             	mov    %ebx,(%esp)
  101bd3:	e8 98 15 00 00       	call   103170 <sleep>

  if(ip == 0 || ip->ref < 1)
    panic("ilock");

  acquire(&icache.lock);
  while(ip->flags & I_BUSY)
  101bd8:	8b 43 0c             	mov    0xc(%ebx),%eax
  101bdb:	a8 01                	test   $0x1,%al
  101bdd:	75 e9                	jne    101bc8 <ilock+0x38>
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
  101bdf:	83 c8 01             	or     $0x1,%eax
  101be2:	89 43 0c             	mov    %eax,0xc(%ebx)
  release(&icache.lock);
  101be5:	c7 04 24 60 9a 10 00 	movl   $0x109a60,(%esp)
  101bec:	e8 df 1e 00 00       	call   103ad0 <release>

  if(!(ip->flags & I_VALID)){
  101bf1:	f6 43 0c 02          	testb  $0x2,0xc(%ebx)
  101bf5:	74 09                	je     101c00 <ilock+0x70>
    brelse(bp);
    ip->flags |= I_VALID;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
  101bf7:	83 c4 10             	add    $0x10,%esp
  101bfa:	5b                   	pop    %ebx
  101bfb:	5e                   	pop    %esi
  101bfc:	5d                   	pop    %ebp
  101bfd:	c3                   	ret    
  101bfe:	66 90                	xchg   %ax,%ax
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
  release(&icache.lock);

  if(!(ip->flags & I_VALID)){
    bp = bread(ip->dev, IBLOCK(ip->inum));
  101c00:	8b 43 04             	mov    0x4(%ebx),%eax
  101c03:	c1 e8 03             	shr    $0x3,%eax
  101c06:	83 c0 02             	add    $0x2,%eax
  101c09:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c0d:	8b 03                	mov    (%ebx),%eax
  101c0f:	89 04 24             	mov    %eax,(%esp)
  101c12:	e8 99 e4 ff ff       	call   1000b0 <bread>
  101c17:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
  101c19:	8b 43 04             	mov    0x4(%ebx),%eax
  101c1c:	83 e0 07             	and    $0x7,%eax
  101c1f:	c1 e0 06             	shl    $0x6,%eax
  101c22:	8d 44 06 18          	lea    0x18(%esi,%eax,1),%eax
    ip->type = dip->type;
  101c26:	0f b7 10             	movzwl (%eax),%edx
  101c29:	66 89 53 10          	mov    %dx,0x10(%ebx)
    ip->major = dip->major;
  101c2d:	0f b7 50 02          	movzwl 0x2(%eax),%edx
  101c31:	66 89 53 12          	mov    %dx,0x12(%ebx)
    ip->minor = dip->minor;
  101c35:	0f b7 50 04          	movzwl 0x4(%eax),%edx
  101c39:	66 89 53 14          	mov    %dx,0x14(%ebx)
    ip->nlink = dip->nlink;
  101c3d:	0f b7 50 06          	movzwl 0x6(%eax),%edx
  101c41:	66 89 53 16          	mov    %dx,0x16(%ebx)
    ip->size = dip->size;
  101c45:	8b 50 08             	mov    0x8(%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
  101c48:	83 c0 0c             	add    $0xc,%eax
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
  101c4b:	89 53 18             	mov    %edx,0x18(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
  101c4e:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c52:	8d 43 1c             	lea    0x1c(%ebx),%eax
  101c55:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
  101c5c:	00 
  101c5d:	89 04 24             	mov    %eax,(%esp)
  101c60:	e8 db 1f 00 00       	call   103c40 <memmove>
    brelse(bp);
  101c65:	89 34 24             	mov    %esi,(%esp)
  101c68:	e8 93 e3 ff ff       	call   100000 <brelse>
    ip->flags |= I_VALID;
  101c6d:	83 4b 0c 02          	orl    $0x2,0xc(%ebx)
    if(ip->type == 0)
  101c71:	66 83 7b 10 00       	cmpw   $0x0,0x10(%ebx)
  101c76:	0f 85 7b ff ff ff    	jne    101bf7 <ilock+0x67>
      panic("ilock: no type");
  101c7c:	c7 04 24 c0 65 10 00 	movl   $0x1065c0,(%esp)
  101c83:	e8 28 ec ff ff       	call   1008b0 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
  101c88:	c7 04 24 ba 65 10 00 	movl   $0x1065ba,(%esp)
  101c8f:	e8 1c ec ff ff       	call   1008b0 <panic>
  101c94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  101c9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00101ca0 <namex>:
// Look up and return the inode for a path name.
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
static struct inode*
namex(char *path, int nameiparent, char *name)
{
  101ca0:	55                   	push   %ebp
  101ca1:	89 e5                	mov    %esp,%ebp
  101ca3:	57                   	push   %edi
  101ca4:	56                   	push   %esi
  101ca5:	53                   	push   %ebx
  101ca6:	89 c3                	mov    %eax,%ebx
  101ca8:	83 ec 2c             	sub    $0x2c,%esp
  101cab:	89 55 e0             	mov    %edx,-0x20(%ebp)
  101cae:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
  101cb1:	80 38 2f             	cmpb   $0x2f,(%eax)
  101cb4:	0f 84 14 01 00 00    	je     101dce <namex+0x12e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);
  101cba:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  101cc0:	8b 40 68             	mov    0x68(%eax),%eax
  101cc3:	89 04 24             	mov    %eax,(%esp)
  101cc6:	e8 c5 f3 ff ff       	call   101090 <idup>
  101ccb:	89 c7                	mov    %eax,%edi
  101ccd:	eb 04                	jmp    101cd3 <namex+0x33>
  101ccf:	90                   	nop
{
  char *s;
  int len;

  while(*path == '/')
    path++;
  101cd0:	83 c3 01             	add    $0x1,%ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
  101cd3:	0f b6 03             	movzbl (%ebx),%eax
  101cd6:	3c 2f                	cmp    $0x2f,%al
  101cd8:	74 f6                	je     101cd0 <namex+0x30>
    path++;
  if(*path == 0)
  101cda:	84 c0                	test   %al,%al
  101cdc:	75 1a                	jne    101cf8 <namex+0x58>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
  101cde:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  101ce1:	85 db                	test   %ebx,%ebx
  101ce3:	0f 85 0d 01 00 00    	jne    101df6 <namex+0x156>
    iput(ip);
    return 0;
  }
  return ip;
}
  101ce9:	83 c4 2c             	add    $0x2c,%esp
  101cec:	89 f8                	mov    %edi,%eax
  101cee:	5b                   	pop    %ebx
  101cef:	5e                   	pop    %esi
  101cf0:	5f                   	pop    %edi
  101cf1:	5d                   	pop    %ebp
  101cf2:	c3                   	ret    
  101cf3:	90                   	nop
  101cf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
  101cf8:	3c 2f                	cmp    $0x2f,%al
  101cfa:	0f 84 94 00 00 00    	je     101d94 <namex+0xf4>
  101d00:	89 de                	mov    %ebx,%esi
  101d02:	eb 08                	jmp    101d0c <namex+0x6c>
  101d04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  101d08:	3c 2f                	cmp    $0x2f,%al
  101d0a:	74 0a                	je     101d16 <namex+0x76>
    path++;
  101d0c:	83 c6 01             	add    $0x1,%esi
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
  101d0f:	0f b6 06             	movzbl (%esi),%eax
  101d12:	84 c0                	test   %al,%al
  101d14:	75 f2                	jne    101d08 <namex+0x68>
  101d16:	89 f2                	mov    %esi,%edx
  101d18:	29 da                	sub    %ebx,%edx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
  101d1a:	83 fa 0d             	cmp    $0xd,%edx
  101d1d:	7e 79                	jle    101d98 <namex+0xf8>
    memmove(name, s, DIRSIZ);
  101d1f:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
  101d26:	00 
  101d27:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  101d2b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  101d2e:	89 04 24             	mov    %eax,(%esp)
  101d31:	e8 0a 1f 00 00       	call   103c40 <memmove>
  101d36:	eb 03                	jmp    101d3b <namex+0x9b>
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
    path++;
  101d38:	83 c6 01             	add    $0x1,%esi
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
  101d3b:	80 3e 2f             	cmpb   $0x2f,(%esi)
  101d3e:	74 f8                	je     101d38 <namex+0x98>
  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
  101d40:	85 f6                	test   %esi,%esi
  101d42:	74 9a                	je     101cde <namex+0x3e>
    ilock(ip);
  101d44:	89 3c 24             	mov    %edi,(%esp)
  101d47:	e8 44 fe ff ff       	call   101b90 <ilock>
    if(ip->type != T_DIR){
  101d4c:	66 83 7f 10 01       	cmpw   $0x1,0x10(%edi)
  101d51:	75 67                	jne    101dba <namex+0x11a>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
  101d53:	8b 45 e0             	mov    -0x20(%ebp),%eax
  101d56:	85 c0                	test   %eax,%eax
  101d58:	74 0c                	je     101d66 <namex+0xc6>
  101d5a:	80 3e 00             	cmpb   $0x0,(%esi)
  101d5d:	8d 76 00             	lea    0x0(%esi),%esi
  101d60:	0f 84 7e 00 00 00    	je     101de4 <namex+0x144>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
  101d66:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  101d6d:	00 
  101d6e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  101d71:	89 3c 24             	mov    %edi,(%esp)
  101d74:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d78:	e8 d3 f8 ff ff       	call   101650 <dirlookup>
  101d7d:	85 c0                	test   %eax,%eax
  101d7f:	89 c3                	mov    %eax,%ebx
  101d81:	74 37                	je     101dba <namex+0x11a>
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
  101d83:	89 3c 24             	mov    %edi,(%esp)
  101d86:	89 df                	mov    %ebx,%edi
  101d88:	89 f3                	mov    %esi,%ebx
  101d8a:	e8 11 fd ff ff       	call   101aa0 <iunlockput>
  101d8f:	e9 3f ff ff ff       	jmp    101cd3 <namex+0x33>
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
  101d94:	89 de                	mov    %ebx,%esi
  101d96:	31 d2                	xor    %edx,%edx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
  101d98:	89 54 24 08          	mov    %edx,0x8(%esp)
  101d9c:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  101da0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  101da3:	89 04 24             	mov    %eax,(%esp)
  101da6:	89 55 dc             	mov    %edx,-0x24(%ebp)
  101da9:	e8 92 1e 00 00       	call   103c40 <memmove>
    name[len] = 0;
  101dae:	8b 55 dc             	mov    -0x24(%ebp),%edx
  101db1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  101db4:	c6 04 10 00          	movb   $0x0,(%eax,%edx,1)
  101db8:	eb 81                	jmp    101d3b <namex+0x9b>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
  101dba:	89 3c 24             	mov    %edi,(%esp)
  101dbd:	31 ff                	xor    %edi,%edi
  101dbf:	e8 dc fc ff ff       	call   101aa0 <iunlockput>
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
  101dc4:	83 c4 2c             	add    $0x2c,%esp
  101dc7:	89 f8                	mov    %edi,%eax
  101dc9:	5b                   	pop    %ebx
  101dca:	5e                   	pop    %esi
  101dcb:	5f                   	pop    %edi
  101dcc:	5d                   	pop    %ebp
  101dcd:	c3                   	ret    
namex(char *path, int nameiparent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  101dce:	ba 01 00 00 00       	mov    $0x1,%edx
  101dd3:	b8 01 00 00 00       	mov    $0x1,%eax
  101dd8:	e8 e3 f2 ff ff       	call   1010c0 <iget>
  101ddd:	89 c7                	mov    %eax,%edi
  101ddf:	e9 ef fe ff ff       	jmp    101cd3 <namex+0x33>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
  101de4:	89 3c 24             	mov    %edi,(%esp)
  101de7:	e8 64 f9 ff ff       	call   101750 <iunlock>
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
  101dec:	83 c4 2c             	add    $0x2c,%esp
  101def:	89 f8                	mov    %edi,%eax
  101df1:	5b                   	pop    %ebx
  101df2:	5e                   	pop    %esi
  101df3:	5f                   	pop    %edi
  101df4:	5d                   	pop    %ebp
  101df5:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
  101df6:	89 3c 24             	mov    %edi,(%esp)
  101df9:	31 ff                	xor    %edi,%edi
  101dfb:	e8 60 fa ff ff       	call   101860 <iput>
    return 0;
  101e00:	e9 e4 fe ff ff       	jmp    101ce9 <namex+0x49>
  101e05:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  101e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101e10 <nameiparent>:
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
  101e10:	55                   	push   %ebp
  return namex(path, 1, name);
  101e11:	ba 01 00 00 00       	mov    $0x1,%edx
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
  101e16:	89 e5                	mov    %esp,%ebp
  101e18:	83 ec 08             	sub    $0x8,%esp
  return namex(path, 1, name);
  101e1b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  101e1e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  101e21:	c9                   	leave  
}

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
  101e22:	e9 79 fe ff ff       	jmp    101ca0 <namex>
  101e27:	89 f6                	mov    %esi,%esi
  101e29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101e30 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
  101e30:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
  101e31:	31 d2                	xor    %edx,%edx
  return ip;
}

struct inode*
namei(char *path)
{
  101e33:	89 e5                	mov    %esp,%ebp
  101e35:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
  101e38:	8b 45 08             	mov    0x8(%ebp),%eax
  101e3b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
  101e3e:	e8 5d fe ff ff       	call   101ca0 <namex>
}
  101e43:	c9                   	leave  
  101e44:	c3                   	ret    
  101e45:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  101e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101e50 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(void)
{
  101e50:	55                   	push   %ebp
  101e51:	89 e5                	mov    %esp,%ebp
  101e53:	83 ec 18             	sub    $0x18,%esp
  initlock(&icache.lock, "icache");
  101e56:	c7 44 24 04 cf 65 10 	movl   $0x1065cf,0x4(%esp)
  101e5d:	00 
  101e5e:	c7 04 24 60 9a 10 00 	movl   $0x109a60,(%esp)
  101e65:	e8 26 1b 00 00       	call   103990 <initlock>
}
  101e6a:	c9                   	leave  
  101e6b:	c3                   	ret    
  101e6c:	90                   	nop
  101e6d:	90                   	nop
  101e6e:	90                   	nop
  101e6f:	90                   	nop

00101e70 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  101e70:	55                   	push   %ebp
  101e71:	89 e5                	mov    %esp,%ebp
  101e73:	56                   	push   %esi
  101e74:	89 c6                	mov    %eax,%esi
  101e76:	83 ec 14             	sub    $0x14,%esp
  if(b == 0)
  101e79:	85 c0                	test   %eax,%eax
  101e7b:	0f 84 8d 00 00 00    	je     101f0e <idestart+0x9e>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  101e81:	ba f7 01 00 00       	mov    $0x1f7,%edx
  101e86:	66 90                	xchg   %ax,%ax
  101e88:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY) 
  101e89:	25 c0 00 00 00       	and    $0xc0,%eax
  101e8e:	83 f8 40             	cmp    $0x40,%eax
  101e91:	75 f5                	jne    101e88 <idestart+0x18>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  101e93:	ba f6 03 00 00       	mov    $0x3f6,%edx
  101e98:	31 c0                	xor    %eax,%eax
  101e9a:	ee                   	out    %al,(%dx)
  101e9b:	ba f2 01 00 00       	mov    $0x1f2,%edx
  101ea0:	b8 01 00 00 00       	mov    $0x1,%eax
  101ea5:	ee                   	out    %al,(%dx)
    panic("idestart");

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, 1);  // number of sectors
  outb(0x1f3, b->sector & 0xff);
  101ea6:	8b 4e 08             	mov    0x8(%esi),%ecx
  101ea9:	b2 f3                	mov    $0xf3,%dl
  101eab:	89 c8                	mov    %ecx,%eax
  101ead:	ee                   	out    %al,(%dx)
  101eae:	89 c8                	mov    %ecx,%eax
  101eb0:	b2 f4                	mov    $0xf4,%dl
  101eb2:	c1 e8 08             	shr    $0x8,%eax
  101eb5:	ee                   	out    %al,(%dx)
  101eb6:	89 c8                	mov    %ecx,%eax
  101eb8:	b2 f5                	mov    $0xf5,%dl
  101eba:	c1 e8 10             	shr    $0x10,%eax
  101ebd:	ee                   	out    %al,(%dx)
  101ebe:	8b 46 04             	mov    0x4(%esi),%eax
  101ec1:	c1 e9 18             	shr    $0x18,%ecx
  101ec4:	b2 f6                	mov    $0xf6,%dl
  101ec6:	83 e1 0f             	and    $0xf,%ecx
  101ec9:	83 e0 01             	and    $0x1,%eax
  101ecc:	c1 e0 04             	shl    $0x4,%eax
  101ecf:	09 c8                	or     %ecx,%eax
  101ed1:	83 c8 e0             	or     $0xffffffe0,%eax
  101ed4:	ee                   	out    %al,(%dx)
  outb(0x1f4, (b->sector >> 8) & 0xff);
  outb(0x1f5, (b->sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((b->sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
  101ed5:	f6 06 04             	testb  $0x4,(%esi)
  101ed8:	75 16                	jne    101ef0 <idestart+0x80>
  101eda:	ba f7 01 00 00       	mov    $0x1f7,%edx
  101edf:	b8 20 00 00 00       	mov    $0x20,%eax
  101ee4:	ee                   	out    %al,(%dx)
    outb(0x1f7, IDE_CMD_WRITE);
    outsl(0x1f0, b->data, 512/4);
  } else {
    outb(0x1f7, IDE_CMD_READ);
  }
}
  101ee5:	83 c4 14             	add    $0x14,%esp
  101ee8:	5e                   	pop    %esi
  101ee9:	5d                   	pop    %ebp
  101eea:	c3                   	ret    
  101eeb:	90                   	nop
  101eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  101ef0:	b2 f7                	mov    $0xf7,%dl
  101ef2:	b8 30 00 00 00       	mov    $0x30,%eax
  101ef7:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
  101ef8:	b9 80 00 00 00       	mov    $0x80,%ecx
  101efd:	83 c6 18             	add    $0x18,%esi
  101f00:	ba f0 01 00 00       	mov    $0x1f0,%edx
  101f05:	fc                   	cld    
  101f06:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  101f08:	83 c4 14             	add    $0x14,%esp
  101f0b:	5e                   	pop    %esi
  101f0c:	5d                   	pop    %ebp
  101f0d:	c3                   	ret    
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
  101f0e:	c7 04 24 d6 65 10 00 	movl   $0x1065d6,(%esp)
  101f15:	e8 96 e9 ff ff       	call   1008b0 <panic>
  101f1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00101f20 <iderw>:
// Sync buf with disk. 
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
  101f20:	55                   	push   %ebp
  101f21:	89 e5                	mov    %esp,%ebp
  101f23:	53                   	push   %ebx
  101f24:	83 ec 14             	sub    $0x14,%esp
  101f27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!(b->flags & B_BUSY))
  101f2a:	8b 03                	mov    (%ebx),%eax
  101f2c:	a8 01                	test   $0x1,%al
  101f2e:	0f 84 90 00 00 00    	je     101fc4 <iderw+0xa4>
    panic("iderw: buf not busy");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
  101f34:	83 e0 06             	and    $0x6,%eax
  101f37:	83 f8 02             	cmp    $0x2,%eax
  101f3a:	0f 84 9c 00 00 00    	je     101fdc <iderw+0xbc>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
  101f40:	8b 53 04             	mov    0x4(%ebx),%edx
  101f43:	85 d2                	test   %edx,%edx
  101f45:	74 0d                	je     101f54 <iderw+0x34>
  101f47:	a1 38 78 10 00       	mov    0x107838,%eax
  101f4c:	85 c0                	test   %eax,%eax
  101f4e:	0f 84 7c 00 00 00    	je     101fd0 <iderw+0xb0>
    panic("idrw: ide disk 1 not present");

  acquire(&idelock);
  101f54:	c7 04 24 00 78 10 00 	movl   $0x107800,(%esp)
  101f5b:	e8 c0 1b 00 00       	call   103b20 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)
  101f60:	ba 34 78 10 00       	mov    $0x107834,%edx
    panic("idrw: ide disk 1 not present");

  acquire(&idelock);

  // Append b to idequeue.
  b->qnext = 0;
  101f65:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
  101f6c:	a1 34 78 10 00       	mov    0x107834,%eax
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)
  101f71:	85 c0                	test   %eax,%eax
  101f73:	74 0d                	je     101f82 <iderw+0x62>
  101f75:	8d 76 00             	lea    0x0(%esi),%esi
  101f78:	8d 50 14             	lea    0x14(%eax),%edx
  101f7b:	8b 40 14             	mov    0x14(%eax),%eax
  101f7e:	85 c0                	test   %eax,%eax
  101f80:	75 f6                	jne    101f78 <iderw+0x58>
    ;
  *pp = b;
  101f82:	89 1a                	mov    %ebx,(%edx)
  
  // Start disk if necessary.
  if(idequeue == b)
  101f84:	39 1d 34 78 10 00    	cmp    %ebx,0x107834
  101f8a:	75 14                	jne    101fa0 <iderw+0x80>
  101f8c:	eb 2d                	jmp    101fbb <iderw+0x9b>
  101f8e:	66 90                	xchg   %ax,%ax
    idestart(b);
  
  // Wait for request to finish.
  // Assuming will not sleep too long: ignore proc->killed.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID) {
    sleep(b, &idelock);
  101f90:	c7 44 24 04 00 78 10 	movl   $0x107800,0x4(%esp)
  101f97:	00 
  101f98:	89 1c 24             	mov    %ebx,(%esp)
  101f9b:	e8 d0 11 00 00       	call   103170 <sleep>
  if(idequeue == b)
    idestart(b);
  
  // Wait for request to finish.
  // Assuming will not sleep too long: ignore proc->killed.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID) {
  101fa0:	8b 03                	mov    (%ebx),%eax
  101fa2:	83 e0 06             	and    $0x6,%eax
  101fa5:	83 f8 02             	cmp    $0x2,%eax
  101fa8:	75 e6                	jne    101f90 <iderw+0x70>
    sleep(b, &idelock);
  }

  release(&idelock);
  101faa:	c7 45 08 00 78 10 00 	movl   $0x107800,0x8(%ebp)
}
  101fb1:	83 c4 14             	add    $0x14,%esp
  101fb4:	5b                   	pop    %ebx
  101fb5:	5d                   	pop    %ebp
  // Assuming will not sleep too long: ignore proc->killed.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID) {
    sleep(b, &idelock);
  }

  release(&idelock);
  101fb6:	e9 15 1b 00 00       	jmp    103ad0 <release>
    ;
  *pp = b;
  
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
  101fbb:	89 d8                	mov    %ebx,%eax
  101fbd:	e8 ae fe ff ff       	call   101e70 <idestart>
  101fc2:	eb dc                	jmp    101fa0 <iderw+0x80>
iderw(struct buf *b)
{
  struct buf **pp;

  if(!(b->flags & B_BUSY))
    panic("iderw: buf not busy");
  101fc4:	c7 04 24 df 65 10 00 	movl   $0x1065df,(%esp)
  101fcb:	e8 e0 e8 ff ff       	call   1008b0 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("idrw: ide disk 1 not present");
  101fd0:	c7 04 24 08 66 10 00 	movl   $0x106608,(%esp)
  101fd7:	e8 d4 e8 ff ff       	call   1008b0 <panic>
  struct buf **pp;

  if(!(b->flags & B_BUSY))
    panic("iderw: buf not busy");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  101fdc:	c7 04 24 f3 65 10 00 	movl   $0x1065f3,(%esp)
  101fe3:	e8 c8 e8 ff ff       	call   1008b0 <panic>
  101fe8:	90                   	nop
  101fe9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00101ff0 <ideintr>:
}

// Interrupt handler.
void
ideintr(void)
{
  101ff0:	55                   	push   %ebp
  101ff1:	89 e5                	mov    %esp,%ebp
  101ff3:	57                   	push   %edi
  101ff4:	53                   	push   %ebx
  101ff5:	83 ec 10             	sub    $0x10,%esp
  struct buf *b;

  // Take first buffer off queue.
  acquire(&idelock);
  101ff8:	c7 04 24 00 78 10 00 	movl   $0x107800,(%esp)
  101fff:	e8 1c 1b 00 00       	call   103b20 <acquire>
  if((b = idequeue) == 0){
  102004:	8b 1d 34 78 10 00    	mov    0x107834,%ebx
  10200a:	85 db                	test   %ebx,%ebx
  10200c:	74 7a                	je     102088 <ideintr+0x98>
    release(&idelock);
    cprintf("Spurious IDE interrupt.\n");
    return;
  }
  idequeue = b->qnext;
  10200e:	8b 43 14             	mov    0x14(%ebx),%eax
  102011:	a3 34 78 10 00       	mov    %eax,0x107834

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
  102016:	8b 0b                	mov    (%ebx),%ecx
  102018:	f6 c1 04             	test   $0x4,%cl
  10201b:	74 33                	je     102050 <ideintr+0x60>
    insl(0x1f0, b->data, 512/4);
  
  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
  10201d:	83 c9 02             	or     $0x2,%ecx
  102020:	83 e1 fb             	and    $0xfffffffb,%ecx
  102023:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
  102025:	89 1c 24             	mov    %ebx,(%esp)
  102028:	e8 23 10 00 00       	call   103050 <wakeup>
  
  // Start disk on next buf in queue.
  if(idequeue != 0)
  10202d:	a1 34 78 10 00       	mov    0x107834,%eax
  102032:	85 c0                	test   %eax,%eax
  102034:	74 05                	je     10203b <ideintr+0x4b>
    idestart(idequeue);
  102036:	e8 35 fe ff ff       	call   101e70 <idestart>

  release(&idelock);
  10203b:	c7 04 24 00 78 10 00 	movl   $0x107800,(%esp)
  102042:	e8 89 1a 00 00       	call   103ad0 <release>
}
  102047:	83 c4 10             	add    $0x10,%esp
  10204a:	5b                   	pop    %ebx
  10204b:	5f                   	pop    %edi
  10204c:	5d                   	pop    %ebp
  10204d:	c3                   	ret    
  10204e:	66 90                	xchg   %ax,%ax
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  102050:	ba f7 01 00 00       	mov    $0x1f7,%edx
  102055:	8d 76 00             	lea    0x0(%esi),%esi
  102058:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY) 
  102059:	0f b6 c0             	movzbl %al,%eax
  10205c:	89 c7                	mov    %eax,%edi
  10205e:	81 e7 c0 00 00 00    	and    $0xc0,%edi
  102064:	83 ff 40             	cmp    $0x40,%edi
  102067:	75 ef                	jne    102058 <ideintr+0x68>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
  102069:	a8 21                	test   $0x21,%al
  10206b:	75 b0                	jne    10201d <ideintr+0x2d>
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
  10206d:	8d 7b 18             	lea    0x18(%ebx),%edi
  102070:	b9 80 00 00 00       	mov    $0x80,%ecx
  102075:	ba f0 01 00 00       	mov    $0x1f0,%edx
  10207a:	fc                   	cld    
  10207b:	f3 6d                	rep insl (%dx),%es:(%edi)
  10207d:	8b 0b                	mov    (%ebx),%ecx
  10207f:	eb 9c                	jmp    10201d <ideintr+0x2d>
  102081:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct buf *b;

  // Take first buffer off queue.
  acquire(&idelock);
  if((b = idequeue) == 0){
    release(&idelock);
  102088:	c7 04 24 00 78 10 00 	movl   $0x107800,(%esp)
  10208f:	e8 3c 1a 00 00       	call   103ad0 <release>
    cprintf("Spurious IDE interrupt.\n");
  102094:	c7 04 24 25 66 10 00 	movl   $0x106625,(%esp)
  10209b:	e8 20 e4 ff ff       	call   1004c0 <cprintf>
    return;
  1020a0:	eb a5                	jmp    102047 <ideintr+0x57>
  1020a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1020a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001020b0 <ideinit>:
  return 0;
}

void
ideinit(void)
{
  1020b0:	55                   	push   %ebp
  1020b1:	89 e5                	mov    %esp,%ebp
  1020b3:	83 ec 18             	sub    $0x18,%esp
  int i;

  initlock(&idelock, "ide");
  1020b6:	c7 44 24 04 3e 66 10 	movl   $0x10663e,0x4(%esp)
  1020bd:	00 
  1020be:	c7 04 24 00 78 10 00 	movl   $0x107800,(%esp)
  1020c5:	e8 c6 18 00 00       	call   103990 <initlock>
  picenable(IRQ_IDE);
  1020ca:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
  1020d1:	e8 aa 0a 00 00       	call   102b80 <picenable>
  ioapicenable(IRQ_IDE, ncpu - 1);
  1020d6:	a1 80 b0 10 00       	mov    0x10b080,%eax
  1020db:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
  1020e2:	83 e8 01             	sub    $0x1,%eax
  1020e5:	89 44 24 04          	mov    %eax,0x4(%esp)
  1020e9:	e8 52 00 00 00       	call   102140 <ioapicenable>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  1020ee:	ba f7 01 00 00       	mov    $0x1f7,%edx
  1020f3:	90                   	nop
  1020f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1020f8:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY) 
  1020f9:	25 c0 00 00 00       	and    $0xc0,%eax
  1020fe:	83 f8 40             	cmp    $0x40,%eax
  102101:	75 f5                	jne    1020f8 <ideinit+0x48>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102103:	ba f6 01 00 00       	mov    $0x1f6,%edx
  102108:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  10210d:	ee                   	out    %al,(%dx)
  10210e:	31 c9                	xor    %ecx,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  102110:	b2 f7                	mov    $0xf7,%dl
  102112:	eb 0f                	jmp    102123 <ideinit+0x73>
  102114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
  102118:	83 c1 01             	add    $0x1,%ecx
  10211b:	81 f9 e8 03 00 00    	cmp    $0x3e8,%ecx
  102121:	74 0f                	je     102132 <ideinit+0x82>
  102123:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
  102124:	84 c0                	test   %al,%al
  102126:	74 f0                	je     102118 <ideinit+0x68>
      havedisk1 = 1;
  102128:	c7 05 38 78 10 00 01 	movl   $0x1,0x107838
  10212f:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102132:	ba f6 01 00 00       	mov    $0x1f6,%edx
  102137:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
  10213c:	ee                   	out    %al,(%dx)
    }
  }
  
  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
  10213d:	c9                   	leave  
  10213e:	c3                   	ret    
  10213f:	90                   	nop

00102140 <ioapicenable>:
}

void
ioapicenable(int irq, int cpunum)
{
  if(!ismp)
  102140:	8b 15 84 aa 10 00    	mov    0x10aa84,%edx
  }
}

void
ioapicenable(int irq, int cpunum)
{
  102146:	55                   	push   %ebp
  102147:	89 e5                	mov    %esp,%ebp
  102149:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!ismp)
  10214c:	85 d2                	test   %edx,%edx
  10214e:	74 31                	je     102181 <ioapicenable+0x41>
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  102150:	8b 15 34 aa 10 00    	mov    0x10aa34,%edx
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  102156:	8d 48 20             	lea    0x20(%eax),%ecx
  102159:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  10215d:	89 02                	mov    %eax,(%edx)
  ioapic->data = data;
  10215f:	8b 15 34 aa 10 00    	mov    0x10aa34,%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  102165:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
  102168:	89 4a 10             	mov    %ecx,0x10(%edx)
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  10216b:	8b 0d 34 aa 10 00    	mov    0x10aa34,%ecx

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
  102171:	8b 55 0c             	mov    0xc(%ebp),%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  102174:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
  102176:	a1 34 aa 10 00       	mov    0x10aa34,%eax

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
  10217b:	c1 e2 18             	shl    $0x18,%edx

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
  10217e:	89 50 10             	mov    %edx,0x10(%eax)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
  102181:	5d                   	pop    %ebp
  102182:	c3                   	ret    
  102183:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  102189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00102190 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
  102190:	55                   	push   %ebp
  102191:	89 e5                	mov    %esp,%ebp
  102193:	56                   	push   %esi
  102194:	53                   	push   %ebx
  102195:	83 ec 10             	sub    $0x10,%esp
  int i, id, maxintr;

  if(!ismp)
  102198:	8b 0d 84 aa 10 00    	mov    0x10aa84,%ecx
  10219e:	85 c9                	test   %ecx,%ecx
  1021a0:	0f 84 9e 00 00 00    	je     102244 <ioapicinit+0xb4>
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
  1021a6:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
  1021ad:	00 00 00 
  return ioapic->data;
  1021b0:	8b 35 10 00 c0 fe    	mov    0xfec00010,%esi
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
  1021b6:	bb 00 00 c0 fe       	mov    $0xfec00000,%ebx
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
  1021bb:	c7 05 00 00 c0 fe 00 	movl   $0x0,0xfec00000
  1021c2:	00 00 00 
  return ioapic->data;
  1021c5:	a1 10 00 c0 fe       	mov    0xfec00010,%eax
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
  1021ca:	0f b6 15 80 aa 10 00 	movzbl 0x10aa80,%edx
  int i, id, maxintr;

  if(!ismp)
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  1021d1:	c7 05 34 aa 10 00 00 	movl   $0xfec00000,0x10aa34
  1021d8:	00 c0 fe 
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  1021db:	c1 ee 10             	shr    $0x10,%esi
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
  1021de:	c1 e8 18             	shr    $0x18,%eax

  if(!ismp)
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  1021e1:	81 e6 ff 00 00 00    	and    $0xff,%esi
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
  1021e7:	39 c2                	cmp    %eax,%edx
  1021e9:	74 12                	je     1021fd <ioapicinit+0x6d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
  1021eb:	c7 04 24 44 66 10 00 	movl   $0x106644,(%esp)
  1021f2:	e8 c9 e2 ff ff       	call   1004c0 <cprintf>
  1021f7:	8b 1d 34 aa 10 00    	mov    0x10aa34,%ebx
  1021fd:	ba 10 00 00 00       	mov    $0x10,%edx
  102202:	31 c0                	xor    %eax,%eax
  102204:	eb 08                	jmp    10220e <ioapicinit+0x7e>
  102206:	66 90                	xchg   %ax,%ax

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
  102208:	8b 1d 34 aa 10 00    	mov    0x10aa34,%ebx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  10220e:	89 13                	mov    %edx,(%ebx)
  ioapic->data = data;
  102210:	8b 1d 34 aa 10 00    	mov    0x10aa34,%ebx
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
  102216:	8d 48 20             	lea    0x20(%eax),%ecx
  102219:	81 c9 00 00 01 00    	or     $0x10000,%ecx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
  10221f:	83 c0 01             	add    $0x1,%eax

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
  102222:	89 4b 10             	mov    %ecx,0x10(%ebx)
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  102225:	8b 0d 34 aa 10 00    	mov    0x10aa34,%ecx
  10222b:	8d 5a 01             	lea    0x1(%edx),%ebx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
  10222e:	83 c2 02             	add    $0x2,%edx
  102231:	39 c6                	cmp    %eax,%esi
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  102233:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
  102235:	8b 0d 34 aa 10 00    	mov    0x10aa34,%ecx
  10223b:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
  102242:	7d c4                	jge    102208 <ioapicinit+0x78>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
  102244:	83 c4 10             	add    $0x10,%esp
  102247:	5b                   	pop    %ebx
  102248:	5e                   	pop    %esi
  102249:	5d                   	pop    %ebp
  10224a:	c3                   	ret    
  10224b:	90                   	nop
  10224c:	90                   	nop
  10224d:	90                   	nop
  10224e:	90                   	nop
  10224f:	90                   	nop

00102250 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc()
{
  102250:	55                   	push   %ebp
  102251:	89 e5                	mov    %esp,%ebp
  102253:	53                   	push   %ebx
  102254:	83 ec 14             	sub    $0x14,%esp
  struct run *r;

  acquire(&kmem.lock);
  102257:	c7 04 24 40 aa 10 00 	movl   $0x10aa40,(%esp)
  10225e:	e8 bd 18 00 00       	call   103b20 <acquire>
  r = kmem.freelist;
  102263:	8b 1d 74 aa 10 00    	mov    0x10aa74,%ebx
  if(r)
  102269:	85 db                	test   %ebx,%ebx
  10226b:	74 07                	je     102274 <kalloc+0x24>
    kmem.freelist = r->next;
  10226d:	8b 03                	mov    (%ebx),%eax
  10226f:	a3 74 aa 10 00       	mov    %eax,0x10aa74
  release(&kmem.lock);
  102274:	c7 04 24 40 aa 10 00 	movl   $0x10aa40,(%esp)
  10227b:	e8 50 18 00 00       	call   103ad0 <release>
  return (char*) r;
}
  102280:	89 d8                	mov    %ebx,%eax
  102282:	83 c4 14             	add    $0x14,%esp
  102285:	5b                   	pop    %ebx
  102286:	5d                   	pop    %ebp
  102287:	c3                   	ret    
  102288:	90                   	nop
  102289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102290 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
  102290:	55                   	push   %ebp
  102291:	89 e5                	mov    %esp,%ebp
  102293:	53                   	push   %ebx
  102294:	83 ec 14             	sub    $0x14,%esp
  102297:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if(((uint) v) % PGSIZE || (uint)v < 1024*1024 || (uint)v >= PHYSTOP) 
  10229a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
  1022a0:	75 52                	jne    1022f4 <kfree+0x64>
  1022a2:	81 fb ff ff 0f 00    	cmp    $0xfffff,%ebx
  1022a8:	76 4a                	jbe    1022f4 <kfree+0x64>
  1022aa:	81 fb ff ff ff 00    	cmp    $0xffffff,%ebx
  1022b0:	77 42                	ja     1022f4 <kfree+0x64>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
  1022b2:	89 1c 24             	mov    %ebx,(%esp)
  1022b5:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
  1022bc:	00 
  1022bd:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  1022c4:	00 
  1022c5:	e8 f6 18 00 00       	call   103bc0 <memset>

  acquire(&kmem.lock);
  1022ca:	c7 04 24 40 aa 10 00 	movl   $0x10aa40,(%esp)
  1022d1:	e8 4a 18 00 00       	call   103b20 <acquire>
  r = (struct run *) v;
  r->next = kmem.freelist;
  1022d6:	a1 74 aa 10 00       	mov    0x10aa74,%eax
  1022db:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  1022dd:	89 1d 74 aa 10 00    	mov    %ebx,0x10aa74
  release(&kmem.lock);
  1022e3:	c7 45 08 40 aa 10 00 	movl   $0x10aa40,0x8(%ebp)
}
  1022ea:	83 c4 14             	add    $0x14,%esp
  1022ed:	5b                   	pop    %ebx
  1022ee:	5d                   	pop    %ebp

  acquire(&kmem.lock);
  r = (struct run *) v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  release(&kmem.lock);
  1022ef:	e9 dc 17 00 00       	jmp    103ad0 <release>
kfree(char *v)
{
  struct run *r;

  if(((uint) v) % PGSIZE || (uint)v < 1024*1024 || (uint)v >= PHYSTOP) 
    panic("kfree");
  1022f4:	c7 04 24 76 66 10 00 	movl   $0x106676,(%esp)
  1022fb:	e8 b0 e5 ff ff       	call   1008b0 <panic>

00102300 <kinit>:
} kmem;

// Initialize free list of physical pages.
void
kinit(void)
{
  102300:	55                   	push   %ebp
  102301:	89 e5                	mov    %esp,%ebp
  102303:	53                   	push   %ebx
  extern char end[];

  initlock(&kmem.lock, "kmem");
  char *p = (char*)PGROUNDUP((uint)end);
  102304:	bb 23 e9 10 00       	mov    $0x10e923,%ebx
} kmem;

// Initialize free list of physical pages.
void
kinit(void)
{
  102309:	83 ec 14             	sub    $0x14,%esp
  extern char end[];

  initlock(&kmem.lock, "kmem");
  char *p = (char*)PGROUNDUP((uint)end);
  10230c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
void
kinit(void)
{
  extern char end[];

  initlock(&kmem.lock, "kmem");
  102312:	c7 44 24 04 7c 66 10 	movl   $0x10667c,0x4(%esp)
  102319:	00 
  10231a:	c7 04 24 40 aa 10 00 	movl   $0x10aa40,(%esp)
  102321:	e8 6a 16 00 00       	call   103990 <initlock>
  char *p = (char*)PGROUNDUP((uint)end);
  for( ; p + PGSIZE - 1 < (char*) PHYSTOP; p += PGSIZE)
  102326:	8d 83 ff 0f 00 00    	lea    0xfff(%ebx),%eax
  10232c:	3d ff ff ff 00       	cmp    $0xffffff,%eax
  102331:	77 20                	ja     102353 <kinit+0x53>
  102333:	90                   	nop
  102334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
  102338:	89 1c 24             	mov    %ebx,(%esp)
{
  extern char end[];

  initlock(&kmem.lock, "kmem");
  char *p = (char*)PGROUNDUP((uint)end);
  for( ; p + PGSIZE - 1 < (char*) PHYSTOP; p += PGSIZE)
  10233b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
  102341:	e8 4a ff ff ff       	call   102290 <kfree>
{
  extern char end[];

  initlock(&kmem.lock, "kmem");
  char *p = (char*)PGROUNDUP((uint)end);
  for( ; p + PGSIZE - 1 < (char*) PHYSTOP; p += PGSIZE)
  102346:	8d 83 ff 0f 00 00    	lea    0xfff(%ebx),%eax
  10234c:	3d ff ff ff 00       	cmp    $0xffffff,%eax
  102351:	76 e5                	jbe    102338 <kinit+0x38>
    kfree(p);
}
  102353:	83 c4 14             	add    $0x14,%esp
  102356:	5b                   	pop    %ebx
  102357:	5d                   	pop    %ebp
  102358:	c3                   	ret    
  102359:	90                   	nop
  10235a:	90                   	nop
  10235b:	90                   	nop
  10235c:	90                   	nop
  10235d:	90                   	nop
  10235e:	90                   	nop
  10235f:	90                   	nop

00102360 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
  102360:	55                   	push   %ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  102361:	ba 64 00 00 00       	mov    $0x64,%edx
  102366:	89 e5                	mov    %esp,%ebp
  102368:	ec                   	in     (%dx),%al
  102369:	89 c2                	mov    %eax,%edx
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
  10236b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  102370:	83 e2 01             	and    $0x1,%edx
  102373:	74 3e                	je     1023b3 <kbdgetc+0x53>
  102375:	ba 60 00 00 00       	mov    $0x60,%edx
  10237a:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
  10237b:	0f b6 c0             	movzbl %al,%eax

  if(data == 0xE0){
  10237e:	3d e0 00 00 00       	cmp    $0xe0,%eax
  102383:	0f 84 7f 00 00 00    	je     102408 <kbdgetc+0xa8>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
  102389:	84 c0                	test   %al,%al
  10238b:	79 2b                	jns    1023b8 <kbdgetc+0x58>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
  10238d:	8b 15 3c 78 10 00    	mov    0x10783c,%edx
  102393:	f6 c2 40             	test   $0x40,%dl
  102396:	75 03                	jne    10239b <kbdgetc+0x3b>
  102398:	83 e0 7f             	and    $0x7f,%eax
    shift &= ~(shiftcode[data] | E0ESC);
  10239b:	0f b6 80 a0 66 10 00 	movzbl 0x1066a0(%eax),%eax
  1023a2:	83 c8 40             	or     $0x40,%eax
  1023a5:	0f b6 c0             	movzbl %al,%eax
  1023a8:	f7 d0                	not    %eax
  1023aa:	21 d0                	and    %edx,%eax
  1023ac:	a3 3c 78 10 00       	mov    %eax,0x10783c
  1023b1:	31 c0                	xor    %eax,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
  1023b3:	5d                   	pop    %ebp
  1023b4:	c3                   	ret    
  1023b5:	8d 76 00             	lea    0x0(%esi),%esi
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
  1023b8:	8b 0d 3c 78 10 00    	mov    0x10783c,%ecx
  1023be:	f6 c1 40             	test   $0x40,%cl
  1023c1:	74 05                	je     1023c8 <kbdgetc+0x68>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
  1023c3:	0c 80                	or     $0x80,%al
    shift &= ~E0ESC;
  1023c5:	83 e1 bf             	and    $0xffffffbf,%ecx
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  1023c8:	0f b6 90 a0 66 10 00 	movzbl 0x1066a0(%eax),%edx
  1023cf:	09 ca                	or     %ecx,%edx
  1023d1:	0f b6 88 a0 67 10 00 	movzbl 0x1067a0(%eax),%ecx
  1023d8:	31 ca                	xor    %ecx,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
  1023da:	89 d1                	mov    %edx,%ecx
  1023dc:	83 e1 03             	and    $0x3,%ecx
  1023df:	8b 0c 8d a0 68 10 00 	mov    0x1068a0(,%ecx,4),%ecx
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  1023e6:	89 15 3c 78 10 00    	mov    %edx,0x10783c
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
  1023ec:	83 e2 08             	and    $0x8,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  1023ef:	0f b6 04 01          	movzbl (%ecx,%eax,1),%eax
  if(shift & CAPSLOCK){
  1023f3:	74 be                	je     1023b3 <kbdgetc+0x53>
    if('a' <= c && c <= 'z')
  1023f5:	8d 50 9f             	lea    -0x61(%eax),%edx
  1023f8:	83 fa 19             	cmp    $0x19,%edx
  1023fb:	77 1b                	ja     102418 <kbdgetc+0xb8>
      c += 'A' - 'a';
  1023fd:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
  102400:	5d                   	pop    %ebp
  102401:	c3                   	ret    
  102402:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
  102408:	30 c0                	xor    %al,%al
  10240a:	83 0d 3c 78 10 00 40 	orl    $0x40,0x10783c
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
  102411:	5d                   	pop    %ebp
  102412:	c3                   	ret    
  102413:	90                   	nop
  102414:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
  102418:	8d 50 bf             	lea    -0x41(%eax),%edx
  10241b:	83 fa 19             	cmp    $0x19,%edx
  10241e:	77 93                	ja     1023b3 <kbdgetc+0x53>
      c += 'a' - 'A';
  102420:	83 c0 20             	add    $0x20,%eax
  }
  return c;
}
  102423:	5d                   	pop    %ebp
  102424:	c3                   	ret    
  102425:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  102429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00102430 <kbdintr>:

void
kbdintr(void)
{
  102430:	55                   	push   %ebp
  102431:	89 e5                	mov    %esp,%ebp
  102433:	83 ec 18             	sub    $0x18,%esp
  consoleintr(kbdgetc);
  102436:	c7 04 24 60 23 10 00 	movl   $0x102360,(%esp)
  10243d:	e8 de e2 ff ff       	call   100720 <consoleintr>
}
  102442:	c9                   	leave  
  102443:	c3                   	ret    
  102444:	90                   	nop
  102445:	90                   	nop
  102446:	90                   	nop
  102447:	90                   	nop
  102448:	90                   	nop
  102449:	90                   	nop
  10244a:	90                   	nop
  10244b:	90                   	nop
  10244c:	90                   	nop
  10244d:	90                   	nop
  10244e:	90                   	nop
  10244f:	90                   	nop

00102450 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
  102450:	a1 78 aa 10 00       	mov    0x10aa78,%eax
}

// Acknowledge interrupt.
void
lapiceoi(void)
{
  102455:	55                   	push   %ebp
  102456:	89 e5                	mov    %esp,%ebp
  if(lapic)
  102458:	85 c0                	test   %eax,%eax
  10245a:	74 12                	je     10246e <lapiceoi+0x1e>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  10245c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
  102463:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  102466:	a1 78 aa 10 00       	mov    0x10aa78,%eax
  10246b:	8b 40 20             	mov    0x20(%eax),%eax
void
lapiceoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
}
  10246e:	5d                   	pop    %ebp
  10246f:	c3                   	ret    

00102470 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
  102470:	55                   	push   %ebp
  102471:	89 e5                	mov    %esp,%ebp
}
  102473:	5d                   	pop    %ebp
  102474:	c3                   	ret    
  102475:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  102479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00102480 <lapicstartap>:

// Start additional processor running bootstrap code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
  102480:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102481:	ba 70 00 00 00       	mov    $0x70,%edx
  102486:	89 e5                	mov    %esp,%ebp
  102488:	b8 0f 00 00 00       	mov    $0xf,%eax
  10248d:	53                   	push   %ebx
  10248e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  102491:	0f b6 5d 08          	movzbl 0x8(%ebp),%ebx
  102495:	ee                   	out    %al,(%dx)
  102496:	b8 0a 00 00 00       	mov    $0xa,%eax
  10249b:	b2 71                	mov    $0x71,%dl
  10249d:	ee                   	out    %al,(%dx)
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
  outb(IO_RTC+1, 0x0A);
  wrv = (ushort*)(0x40<<4 | 0x67);  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
  10249e:	89 c8                	mov    %ecx,%eax
  1024a0:	c1 e8 04             	shr    $0x4,%eax
  1024a3:	66 a3 69 04 00 00    	mov    %ax,0x469
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1024a9:	a1 78 aa 10 00       	mov    0x10aa78,%eax
  1024ae:	c1 e3 18             	shl    $0x18,%ebx
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
  outb(IO_RTC+1, 0x0A);
  wrv = (ushort*)(0x40<<4 | 0x67);  // Warm reset vector
  wrv[0] = 0;
  1024b1:	66 c7 05 67 04 00 00 	movw   $0x0,0x467
  1024b8:	00 00 

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  lapic[ID];  // wait for write to finish, by reading
  1024ba:	c1 e9 0c             	shr    $0xc,%ecx
  1024bd:	80 cd 06             	or     $0x6,%ch
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1024c0:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
  1024c6:	a1 78 aa 10 00       	mov    0x10aa78,%eax
  1024cb:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1024ce:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
  1024d5:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
  1024d8:	a1 78 aa 10 00       	mov    0x10aa78,%eax
  1024dd:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1024e0:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
  1024e7:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
  1024ea:	a1 78 aa 10 00       	mov    0x10aa78,%eax
  1024ef:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1024f2:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
  1024f8:	a1 78 aa 10 00       	mov    0x10aa78,%eax
  1024fd:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102500:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
  102506:	a1 78 aa 10 00       	mov    0x10aa78,%eax
  10250b:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  10250e:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
  102514:	a1 78 aa 10 00       	mov    0x10aa78,%eax
  102519:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  10251c:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
  102522:	a1 78 aa 10 00       	mov    0x10aa78,%eax
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
  102527:	5b                   	pop    %ebx
  102528:	5d                   	pop    %ebp

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  lapic[ID];  // wait for write to finish, by reading
  102529:	8b 40 20             	mov    0x20(%eax),%eax
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
  10252c:	c3                   	ret    
  10252d:	8d 76 00             	lea    0x0(%esi),%esi

00102530 <cpunum>:
  lapicw(TPR, 0);
}

int
cpunum(void)
{
  102530:	55                   	push   %ebp
  102531:	89 e5                	mov    %esp,%ebp
  102533:	83 ec 18             	sub    $0x18,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  102536:	9c                   	pushf  
  102537:	58                   	pop    %eax
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
  102538:	f6 c4 02             	test   $0x2,%ah
  10253b:	74 12                	je     10254f <cpunum+0x1f>
    static int n;
    if(n++ == 0)
  10253d:	a1 40 78 10 00       	mov    0x107840,%eax
  102542:	8d 50 01             	lea    0x1(%eax),%edx
  102545:	85 c0                	test   %eax,%eax
  102547:	89 15 40 78 10 00    	mov    %edx,0x107840
  10254d:	74 19                	je     102568 <cpunum+0x38>
      cprintf("cpu called from %x with interrupts enabled\n",
        __builtin_return_address(0));
  }

  if(lapic)
  10254f:	8b 15 78 aa 10 00    	mov    0x10aa78,%edx
  102555:	31 c0                	xor    %eax,%eax
  102557:	85 d2                	test   %edx,%edx
  102559:	74 06                	je     102561 <cpunum+0x31>
    return lapic[ID]>>24;
  10255b:	8b 42 20             	mov    0x20(%edx),%eax
  10255e:	c1 e8 18             	shr    $0x18,%eax
  return 0;
}
  102561:	c9                   	leave  
  102562:	c3                   	ret    
  102563:	90                   	nop
  102564:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
    static int n;
    if(n++ == 0)
      cprintf("cpu called from %x with interrupts enabled\n",
  102568:	8b 45 04             	mov    0x4(%ebp),%eax
  10256b:	c7 04 24 b0 68 10 00 	movl   $0x1068b0,(%esp)
  102572:	89 44 24 04          	mov    %eax,0x4(%esp)
  102576:	e8 45 df ff ff       	call   1004c0 <cprintf>
  10257b:	eb d2                	jmp    10254f <cpunum+0x1f>
  10257d:	8d 76 00             	lea    0x0(%esi),%esi

00102580 <lapicinit>:
  lapic[ID];  // wait for write to finish, by reading
}

void
lapicinit(int c)
{
  102580:	55                   	push   %ebp
  102581:	89 e5                	mov    %esp,%ebp
  102583:	83 ec 18             	sub    $0x18,%esp
  cprintf("lapicinit: %d 0x%x\n", c, lapic);
  102586:	a1 78 aa 10 00       	mov    0x10aa78,%eax
  10258b:	c7 04 24 dc 68 10 00 	movl   $0x1068dc,(%esp)
  102592:	89 44 24 08          	mov    %eax,0x8(%esp)
  102596:	8b 45 08             	mov    0x8(%ebp),%eax
  102599:	89 44 24 04          	mov    %eax,0x4(%esp)
  10259d:	e8 1e df ff ff       	call   1004c0 <cprintf>
  if(!lapic) 
  1025a2:	a1 78 aa 10 00       	mov    0x10aa78,%eax
  1025a7:	85 c0                	test   %eax,%eax
  1025a9:	0f 84 0a 01 00 00    	je     1026b9 <lapicinit+0x139>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1025af:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
  1025b6:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
  1025b9:	a1 78 aa 10 00       	mov    0x10aa78,%eax
  1025be:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1025c1:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
  1025c8:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  1025cb:	a1 78 aa 10 00       	mov    0x10aa78,%eax
  1025d0:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1025d3:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
  1025da:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
  1025dd:	a1 78 aa 10 00       	mov    0x10aa78,%eax
  1025e2:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1025e5:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
  1025ec:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
  1025ef:	a1 78 aa 10 00       	mov    0x10aa78,%eax
  1025f4:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1025f7:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
  1025fe:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
  102601:	a1 78 aa 10 00       	mov    0x10aa78,%eax
  102606:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102609:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
  102610:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
  102613:	a1 78 aa 10 00       	mov    0x10aa78,%eax
  102618:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
  10261b:	8b 50 30             	mov    0x30(%eax),%edx
  10261e:	c1 ea 10             	shr    $0x10,%edx
  102621:	80 fa 03             	cmp    $0x3,%dl
  102624:	0f 87 96 00 00 00    	ja     1026c0 <lapicinit+0x140>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  10262a:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
  102631:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  102634:	a1 78 aa 10 00       	mov    0x10aa78,%eax
  102639:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  10263c:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
  102643:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  102646:	a1 78 aa 10 00       	mov    0x10aa78,%eax
  10264b:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  10264e:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
  102655:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  102658:	a1 78 aa 10 00       	mov    0x10aa78,%eax
  10265d:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102660:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
  102667:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  10266a:	a1 78 aa 10 00       	mov    0x10aa78,%eax
  10266f:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102672:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
  102679:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  10267c:	a1 78 aa 10 00       	mov    0x10aa78,%eax
  102681:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102684:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
  10268b:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
  10268e:	8b 0d 78 aa 10 00    	mov    0x10aa78,%ecx
  102694:	8b 41 20             	mov    0x20(%ecx),%eax
  102697:	8d 91 00 03 00 00    	lea    0x300(%ecx),%edx
  10269d:	8d 76 00             	lea    0x0(%esi),%esi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
  1026a0:	8b 02                	mov    (%edx),%eax
  1026a2:	f6 c4 10             	test   $0x10,%ah
  1026a5:	75 f9                	jne    1026a0 <lapicinit+0x120>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1026a7:	c7 81 80 00 00 00 00 	movl   $0x0,0x80(%ecx)
  1026ae:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  1026b1:	a1 78 aa 10 00       	mov    0x10aa78,%eax
  1026b6:	8b 40 20             	mov    0x20(%eax),%eax
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
  1026b9:	c9                   	leave  
  1026ba:	c3                   	ret    
  1026bb:	90                   	nop
  1026bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1026c0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
  1026c7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
  1026ca:	a1 78 aa 10 00       	mov    0x10aa78,%eax
  1026cf:	8b 50 20             	mov    0x20(%eax),%edx
  1026d2:	e9 53 ff ff ff       	jmp    10262a <lapicinit+0xaa>
  1026d7:	90                   	nop
  1026d8:	90                   	nop
  1026d9:	90                   	nop
  1026da:	90                   	nop
  1026db:	90                   	nop
  1026dc:	90                   	nop
  1026dd:	90                   	nop
  1026de:	90                   	nop
  1026df:	90                   	nop

001026e0 <mpmain>:
// Common CPU setup code.
// Bootstrap CPU comes here from mainc().
// Other CPUs jump here from bootother.S.
static void
mpmain(void)
{
  1026e0:	55                   	push   %ebp
  1026e1:	89 e5                	mov    %esp,%ebp
  1026e3:	53                   	push   %ebx
  1026e4:	83 ec 14             	sub    $0x14,%esp
  if(cpunum() != mpbcpu()) {
  1026e7:	e8 44 fe ff ff       	call   102530 <cpunum>
  1026ec:	89 c3                	mov    %eax,%ebx
  1026ee:	e8 ed 01 00 00       	call   1028e0 <mpbcpu>
  1026f3:	39 c3                	cmp    %eax,%ebx
  1026f5:	74 16                	je     10270d <mpmain+0x2d>
    ksegment();
  1026f7:	e8 64 3c 00 00       	call   106360 <ksegment>
  1026fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    lapicinit(cpunum());
  102700:	e8 2b fe ff ff       	call   102530 <cpunum>
  102705:	89 04 24             	mov    %eax,(%esp)
  102708:	e8 73 fe ff ff       	call   102580 <lapicinit>
  }
  vmenable();        // turn on paging
  10270d:	e8 4e 35 00 00       	call   105c60 <vmenable>
  cprintf("cpu%d: starting\n", cpu->id);
  102712:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  102718:	0f b6 00             	movzbl (%eax),%eax
  10271b:	c7 04 24 f0 68 10 00 	movl   $0x1068f0,(%esp)
  102722:	89 44 24 04          	mov    %eax,0x4(%esp)
  102726:	e8 95 dd ff ff       	call   1004c0 <cprintf>
  idtinit();       // load idt register
  10272b:	e8 30 26 00 00       	call   104d60 <idtinit>
  xchg(&cpu->booted, 1);
  102730:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
  102737:	b8 01 00 00 00       	mov    $0x1,%eax
  10273c:	f0 87 82 a8 00 00 00 	lock xchg %eax,0xa8(%edx)
  scheduler();     // start running processes
  102743:	e8 38 0b 00 00       	call   103280 <scheduler>
  102748:	90                   	nop
  102749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102750 <mainc>:
  panic("jkstack");
}

void
mainc(void)
{
  102750:	55                   	push   %ebp
  102751:	89 e5                	mov    %esp,%ebp
  102753:	53                   	push   %ebx
  102754:	83 ec 14             	sub    $0x14,%esp
  cprintf("\ncpu%d: starting xv6\n\n", cpu->id);
  102757:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  10275d:	0f b6 00             	movzbl (%eax),%eax
  102760:	c7 04 24 01 69 10 00 	movl   $0x106901,(%esp)
  102767:	89 44 24 04          	mov    %eax,0x4(%esp)
  10276b:	e8 50 dd ff ff       	call   1004c0 <cprintf>
  kvmalloc();      // initialize the kernel page table
  102770:	e8 ab 37 00 00       	call   105f20 <kvmalloc>
  pinit();         // process table
  102775:	e8 f6 11 00 00       	call   103970 <pinit>
  tvinit();        // trap vectors
  10277a:	e8 81 28 00 00       	call   105000 <tvinit>
  10277f:	90                   	nop
  binit();         // buffer cache
  102780:	e8 fb d9 ff ff       	call   100180 <binit>
  fileinit();      // file table
  102785:	e8 b6 e8 ff ff       	call   101040 <fileinit>
  iinit();         // inode cache
  10278a:	e8 c1 f6 ff ff       	call   101e50 <iinit>
  10278f:	90                   	nop
  ideinit();       // disk
  102790:	e8 1b f9 ff ff       	call   1020b0 <ideinit>
  if(!ismp)
  102795:	a1 84 aa 10 00       	mov    0x10aa84,%eax
  10279a:	85 c0                	test   %eax,%eax
  10279c:	0f 84 ab 00 00 00    	je     10284d <mainc+0xfd>
    timerinit();   // uniprocessor timer
  userinit();      // first user process
  1027a2:	e8 09 10 00 00       	call   1037b0 <userinit>
  char *stack;

  // Write bootstrap code to unused memory at 0x7000.  The linker has
  // placed the start of bootother.S there.
  code = (uchar *) 0x7000;
  memmove(code, _binary_bootother_start, (uint)_binary_bootother_size);
  1027a7:	c7 44 24 08 6a 00 00 	movl   $0x6a,0x8(%esp)
  1027ae:	00 
  1027af:	c7 44 24 04 34 77 10 	movl   $0x107734,0x4(%esp)
  1027b6:	00 
  1027b7:	c7 04 24 00 70 00 00 	movl   $0x7000,(%esp)
  1027be:	e8 7d 14 00 00       	call   103c40 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
  1027c3:	69 05 80 b0 10 00 bc 	imul   $0xbc,0x10b080,%eax
  1027ca:	00 00 00 
  1027cd:	05 a0 aa 10 00       	add    $0x10aaa0,%eax
  1027d2:	3d a0 aa 10 00       	cmp    $0x10aaa0,%eax
  1027d7:	76 6a                	jbe    102843 <mainc+0xf3>
  1027d9:	bb a0 aa 10 00       	mov    $0x10aaa0,%ebx
  1027de:	66 90                	xchg   %ax,%ax
    if(c == cpus+cpunum())  // We've started already.
  1027e0:	e8 4b fd ff ff       	call   102530 <cpunum>
  1027e5:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
  1027eb:	05 a0 aa 10 00       	add    $0x10aaa0,%eax
  1027f0:	39 c3                	cmp    %eax,%ebx
  1027f2:	74 36                	je     10282a <mainc+0xda>
      continue;

    // Fill in %esp, %eip and start code on cpu.
    stack = kalloc();
  1027f4:	e8 57 fa ff ff       	call   102250 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void**)(code-8) = mpmain;
  1027f9:	c7 05 f8 6f 00 00 e0 	movl   $0x1026e0,0x6ff8
  102800:	26 10 00 
    if(c == cpus+cpunum())  // We've started already.
      continue;

    // Fill in %esp, %eip and start code on cpu.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
  102803:	05 00 10 00 00       	add    $0x1000,%eax
  102808:	a3 fc 6f 00 00       	mov    %eax,0x6ffc
    *(void**)(code-8) = mpmain;
    lapicstartap(c->id, (uint)code);
  10280d:	c7 44 24 04 00 70 00 	movl   $0x7000,0x4(%esp)
  102814:	00 
  102815:	0f b6 03             	movzbl (%ebx),%eax
  102818:	89 04 24             	mov    %eax,(%esp)
  10281b:	e8 60 fc ff ff       	call   102480 <lapicstartap>

    // Wait for cpu to finish mpmain()
    while(c->booted == 0)
  102820:	8b 83 a8 00 00 00    	mov    0xa8(%ebx),%eax
  102826:	85 c0                	test   %eax,%eax
  102828:	74 f6                	je     102820 <mainc+0xd0>
  // Write bootstrap code to unused memory at 0x7000.  The linker has
  // placed the start of bootother.S there.
  code = (uchar *) 0x7000;
  memmove(code, _binary_bootother_start, (uint)_binary_bootother_size);

  for(c = cpus; c < cpus+ncpu; c++){
  10282a:	69 05 80 b0 10 00 bc 	imul   $0xbc,0x10b080,%eax
  102831:	00 00 00 
  102834:	81 c3 bc 00 00 00    	add    $0xbc,%ebx
  10283a:	05 a0 aa 10 00       	add    $0x10aaa0,%eax
  10283f:	39 c3                	cmp    %eax,%ebx
  102841:	72 9d                	jb     1027e0 <mainc+0x90>
  userinit();      // first user process
  bootothers();    // start other processors

  // Finish setting up this processor in mpmain.
  mpmain();
}
  102843:	83 c4 14             	add    $0x14,%esp
  102846:	5b                   	pop    %ebx
  102847:	5d                   	pop    %ebp
    timerinit();   // uniprocessor timer
  userinit();      // first user process
  bootothers();    // start other processors

  // Finish setting up this processor in mpmain.
  mpmain();
  102848:	e9 93 fe ff ff       	jmp    1026e0 <mpmain>
  binit();         // buffer cache
  fileinit();      // file table
  iinit();         // inode cache
  ideinit();       // disk
  if(!ismp)
    timerinit();   // uniprocessor timer
  10284d:	e8 ae 24 00 00       	call   104d00 <timerinit>
  102852:	e9 4b ff ff ff       	jmp    1027a2 <mainc+0x52>
  102857:	89 f6                	mov    %esi,%esi
  102859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00102860 <jkstack>:
  jkstack();       // call mainc() on a properly-allocated stack 
}

void
jkstack(void)
{
  102860:	55                   	push   %ebp
  102861:	89 e5                	mov    %esp,%ebp
  102863:	83 ec 18             	sub    $0x18,%esp
  char *kstack = kalloc();
  102866:	e8 e5 f9 ff ff       	call   102250 <kalloc>
  if(!kstack)
  10286b:	85 c0                	test   %eax,%eax
  10286d:	74 19                	je     102888 <jkstack+0x28>
    panic("jkstack\n");
  char *top = kstack + PGSIZE;
  asm volatile("movl %0,%%esp" : : "r" (top));
  10286f:	05 00 10 00 00       	add    $0x1000,%eax
  102874:	89 c4                	mov    %eax,%esp
  asm volatile("call mainc");
  102876:	e8 d5 fe ff ff       	call   102750 <mainc>
  panic("jkstack");
  10287b:	c7 04 24 21 69 10 00 	movl   $0x106921,(%esp)
  102882:	e8 29 e0 ff ff       	call   1008b0 <panic>
  102887:	90                   	nop
void
jkstack(void)
{
  char *kstack = kalloc();
  if(!kstack)
    panic("jkstack\n");
  102888:	c7 04 24 18 69 10 00 	movl   $0x106918,(%esp)
  10288f:	e8 1c e0 ff ff       	call   1008b0 <panic>
  102894:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10289a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

001028a0 <main>:
void mainc(void);

// Bootstrap processor starts running C code here.
int
main(void)
{
  1028a0:	55                   	push   %ebp
  1028a1:	89 e5                	mov    %esp,%ebp
  1028a3:	83 e4 f0             	and    $0xfffffff0,%esp
  1028a6:	83 ec 10             	sub    $0x10,%esp
  mpinit();        // collect info about this machine
  1028a9:	e8 d2 00 00 00       	call   102980 <mpinit>
  lapicinit(mpbcpu());
  1028ae:	e8 2d 00 00 00       	call   1028e0 <mpbcpu>
  1028b3:	89 04 24             	mov    %eax,(%esp)
  1028b6:	e8 c5 fc ff ff       	call   102580 <lapicinit>
  ksegment();      // set up segments
  1028bb:	e8 a0 3a 00 00       	call   106360 <ksegment>
  picinit();       // interrupt controller
  1028c0:	e8 eb 02 00 00       	call   102bb0 <picinit>
  ioapicinit();    // another interrupt controller
  1028c5:	e8 c6 f8 ff ff       	call   102190 <ioapicinit>
  consoleinit();   // I/O devices & their interrupts
  1028ca:	e8 21 d9 ff ff       	call   1001f0 <consoleinit>
  1028cf:	90                   	nop
  uartinit();      // serial port
  1028d0:	e8 5b 28 00 00       	call   105130 <uartinit>
  kinit();         // initialize memory allocator
  1028d5:	e8 26 fa ff ff       	call   102300 <kinit>
  jkstack();       // call mainc() on a properly-allocated stack 
  1028da:	e8 81 ff ff ff       	call   102860 <jkstack>
  1028df:	90                   	nop

001028e0 <mpbcpu>:
int ncpu;
uchar ioapicid;

int
mpbcpu(void)
{
  1028e0:	a1 44 78 10 00       	mov    0x107844,%eax
  1028e5:	55                   	push   %ebp
  1028e6:	89 e5                	mov    %esp,%ebp
  return bcpu-cpus;
}
  1028e8:	5d                   	pop    %ebp
int ncpu;
uchar ioapicid;

int
mpbcpu(void)
{
  1028e9:	2d a0 aa 10 00       	sub    $0x10aaa0,%eax
  1028ee:	c1 f8 02             	sar    $0x2,%eax
  1028f1:	69 c0 cf 46 7d 67    	imul   $0x677d46cf,%eax,%eax
  return bcpu-cpus;
}
  1028f7:	c3                   	ret    
  1028f8:	90                   	nop
  1028f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102900 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uchar *addr, int len)
{
  102900:	55                   	push   %ebp
  102901:	89 e5                	mov    %esp,%ebp
  102903:	56                   	push   %esi
  102904:	89 d6                	mov    %edx,%esi
  102906:	53                   	push   %ebx
  102907:	89 c3                	mov    %eax,%ebx
  102909:	83 ec 10             	sub    $0x10,%esp
  uchar *e, *p;

  cprintf("mpsearch1 0x%x %d\n", addr, len);
  e = addr+len;
  10290c:	8d 34 33             	lea    (%ebx,%esi,1),%esi
static struct mp*
mpsearch1(uchar *addr, int len)
{
  uchar *e, *p;

  cprintf("mpsearch1 0x%x %d\n", addr, len);
  10290f:	89 54 24 08          	mov    %edx,0x8(%esp)
  102913:	89 44 24 04          	mov    %eax,0x4(%esp)
  102917:	c7 04 24 29 69 10 00 	movl   $0x106929,(%esp)
  10291e:	e8 9d db ff ff       	call   1004c0 <cprintf>
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
  102923:	39 f3                	cmp    %esi,%ebx
  102925:	73 3a                	jae    102961 <mpsearch1+0x61>
  102927:	90                   	nop
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  102928:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
  10292f:	00 
  102930:	c7 44 24 04 3c 69 10 	movl   $0x10693c,0x4(%esp)
  102937:	00 
  102938:	89 1c 24             	mov    %ebx,(%esp)
  10293b:	e8 a0 12 00 00       	call   103be0 <memcmp>
  102940:	85 c0                	test   %eax,%eax
  102942:	75 16                	jne    10295a <mpsearch1+0x5a>
  102944:	31 d2                	xor    %edx,%edx
  102946:	66 90                	xchg   %ax,%ax
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
  102948:	0f b6 0c 03          	movzbl (%ebx,%eax,1),%ecx
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
  10294c:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
  10294f:	01 ca                	add    %ecx,%edx
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
  102951:	83 f8 10             	cmp    $0x10,%eax
  102954:	75 f2                	jne    102948 <mpsearch1+0x48>
  uchar *e, *p;

  cprintf("mpsearch1 0x%x %d\n", addr, len);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  102956:	84 d2                	test   %dl,%dl
  102958:	74 10                	je     10296a <mpsearch1+0x6a>
{
  uchar *e, *p;

  cprintf("mpsearch1 0x%x %d\n", addr, len);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
  10295a:	83 c3 10             	add    $0x10,%ebx
  10295d:	39 de                	cmp    %ebx,%esi
  10295f:	77 c7                	ja     102928 <mpsearch1+0x28>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
  102961:	83 c4 10             	add    $0x10,%esp
{
  uchar *e, *p;

  cprintf("mpsearch1 0x%x %d\n", addr, len);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
  102964:	31 c0                	xor    %eax,%eax
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
  102966:	5b                   	pop    %ebx
  102967:	5e                   	pop    %esi
  102968:	5d                   	pop    %ebp
  102969:	c3                   	ret    
  10296a:	83 c4 10             	add    $0x10,%esp

  cprintf("mpsearch1 0x%x %d\n", addr, len);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  10296d:	89 d8                	mov    %ebx,%eax
  return 0;
}
  10296f:	5b                   	pop    %ebx
  102970:	5e                   	pop    %esi
  102971:	5d                   	pop    %ebp
  102972:	c3                   	ret    
  102973:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  102979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00102980 <mpinit>:
  return conf;
}

void
mpinit(void)
{
  102980:	55                   	push   %ebp
  102981:	89 e5                	mov    %esp,%ebp
  102983:	57                   	push   %edi
  102984:	56                   	push   %esi
  102985:	53                   	push   %ebx
  102986:	83 ec 2c             	sub    $0x2c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar*)0x400;
  if((p = ((bda[0x0F]<<8)|bda[0x0E]) << 4)){
  102989:	0f b6 05 0f 04 00 00 	movzbl 0x40f,%eax
  102990:	0f b6 15 0e 04 00 00 	movzbl 0x40e,%edx
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
  102997:	c7 05 44 78 10 00 a0 	movl   $0x10aaa0,0x107844
  10299e:	aa 10 00 
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar*)0x400;
  if((p = ((bda[0x0F]<<8)|bda[0x0E]) << 4)){
  1029a1:	c1 e0 08             	shl    $0x8,%eax
  1029a4:	09 d0                	or     %edx,%eax
  1029a6:	c1 e0 04             	shl    $0x4,%eax
  1029a9:	85 c0                	test   %eax,%eax
  1029ab:	75 1b                	jne    1029c8 <mpinit+0x48>
    if((mp = mpsearch1((uchar*)p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1((uchar*)p-1024, 1024)))
  1029ad:	0f b6 05 14 04 00 00 	movzbl 0x414,%eax
  1029b4:	0f b6 15 13 04 00 00 	movzbl 0x413,%edx
  1029bb:	c1 e0 08             	shl    $0x8,%eax
  1029be:	09 d0                	or     %edx,%eax
  1029c0:	c1 e0 0a             	shl    $0xa,%eax
  1029c3:	2d 00 04 00 00       	sub    $0x400,%eax
  1029c8:	ba 00 04 00 00       	mov    $0x400,%edx
  1029cd:	e8 2e ff ff ff       	call   102900 <mpsearch1>
  1029d2:	85 c0                	test   %eax,%eax
  1029d4:	89 c3                	mov    %eax,%ebx
  1029d6:	0f 84 54 01 00 00    	je     102b30 <mpinit+0x1b0>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
  1029dc:	8b 73 04             	mov    0x4(%ebx),%esi
  1029df:	85 f6                	test   %esi,%esi
  1029e1:	74 1c                	je     1029ff <mpinit+0x7f>
    return 0;
  conf = (struct mpconf*)mp->physaddr;
  if(memcmp(conf, "PCMP", 4) != 0)
  1029e3:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
  1029ea:	00 
  1029eb:	c7 44 24 04 41 69 10 	movl   $0x106941,0x4(%esp)
  1029f2:	00 
  1029f3:	89 34 24             	mov    %esi,(%esp)
  1029f6:	e8 e5 11 00 00       	call   103be0 <memcmp>
  1029fb:	85 c0                	test   %eax,%eax
  1029fd:	74 09                	je     102a08 <mpinit+0x88>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
  1029ff:	83 c4 2c             	add    $0x2c,%esp
  102a02:	5b                   	pop    %ebx
  102a03:	5e                   	pop    %esi
  102a04:	5f                   	pop    %edi
  102a05:	5d                   	pop    %ebp
  102a06:	c3                   	ret    
  102a07:	90                   	nop
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
    return 0;
  conf = (struct mpconf*)mp->physaddr;
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
  102a08:	0f b6 46 06          	movzbl 0x6(%esi),%eax
  102a0c:	3c 04                	cmp    $0x4,%al
  102a0e:	74 04                	je     102a14 <mpinit+0x94>
  102a10:	3c 01                	cmp    $0x1,%al
  102a12:	75 eb                	jne    1029ff <mpinit+0x7f>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
  102a14:	0f b7 7e 04          	movzwl 0x4(%esi),%edi
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
  102a18:	85 ff                	test   %edi,%edi
  102a1a:	74 15                	je     102a31 <mpinit+0xb1>
  102a1c:	31 d2                	xor    %edx,%edx
  102a1e:	31 c0                	xor    %eax,%eax
    sum += addr[i];
  102a20:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
  102a24:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
  102a27:	01 ca                	add    %ecx,%edx
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
  102a29:	39 c7                	cmp    %eax,%edi
  102a2b:	7f f3                	jg     102a20 <mpinit+0xa0>
  conf = (struct mpconf*)mp->physaddr;
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
  102a2d:	84 d2                	test   %dl,%dl
  102a2f:	75 ce                	jne    1029ff <mpinit+0x7f>
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  102a31:	c7 05 84 aa 10 00 01 	movl   $0x1,0x10aa84
  102a38:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
  102a3b:	8b 46 24             	mov    0x24(%esi),%eax
  102a3e:	a3 78 aa 10 00       	mov    %eax,0x10aa78
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  102a43:	0f b7 56 04          	movzwl 0x4(%esi),%edx
  102a47:	8d 46 2c             	lea    0x2c(%esi),%eax
  102a4a:	8d 14 16             	lea    (%esi,%edx,1),%edx
  102a4d:	39 d0                	cmp    %edx,%eax
  102a4f:	73 61                	jae    102ab2 <mpinit+0x132>
  102a51:	8b 0d 44 78 10 00    	mov    0x107844,%ecx
  102a57:	89 de                	mov    %ebx,%esi
  102a59:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    switch(*p){
  102a5c:	0f b6 08             	movzbl (%eax),%ecx
  102a5f:	80 f9 04             	cmp    $0x4,%cl
  102a62:	76 2c                	jbe    102a90 <mpinit+0x110>
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
  102a64:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
  102a67:	0f b6 c9             	movzbl %cl,%ecx
  102a6a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  102a6e:	c7 04 24 68 69 10 00 	movl   $0x106968,(%esp)
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
  102a75:	a3 44 78 10 00       	mov    %eax,0x107844
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
  102a7a:	e8 41 da ff ff       	call   1004c0 <cprintf>
      panic("mpinit");
  102a7f:	c7 04 24 61 69 10 00 	movl   $0x106961,(%esp)
  102a86:	e8 25 de ff ff       	call   1008b0 <panic>
  102a8b:	90                   	nop
  102a8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
  102a90:	0f b6 c9             	movzbl %cl,%ecx
  102a93:	ff 24 8d 88 69 10 00 	jmp    *0x106988(,%ecx,4)
  102a9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
  102aa0:	83 c0 08             	add    $0x8,%eax
  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  102aa3:	39 c2                	cmp    %eax,%edx
  102aa5:	77 b5                	ja     102a5c <mpinit+0xdc>
  102aa7:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  102aaa:	89 f3                	mov    %esi,%ebx
  102aac:	89 0d 44 78 10 00    	mov    %ecx,0x107844
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
      panic("mpinit");
    }
  }
  if(mp->imcrp){
  102ab2:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
  102ab6:	0f 84 43 ff ff ff    	je     1029ff <mpinit+0x7f>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102abc:	ba 22 00 00 00       	mov    $0x22,%edx
  102ac1:	b8 70 00 00 00       	mov    $0x70,%eax
  102ac6:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  102ac7:	b2 23                	mov    $0x23,%dl
  102ac9:	ec                   	in     (%dx),%al
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102aca:	83 c8 01             	or     $0x1,%eax
  102acd:	ee                   	out    %al,(%dx)
  102ace:	e9 2c ff ff ff       	jmp    1029ff <mpinit+0x7f>
  102ad3:	90                   	nop
  102ad4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu != proc->apicid) {
  102ad8:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
  102adc:	8b 3d 80 b0 10 00    	mov    0x10b080,%edi
  102ae2:	0f b6 cb             	movzbl %bl,%ecx
  102ae5:	39 f9                	cmp    %edi,%ecx
  102ae7:	75 68                	jne    102b51 <mpinit+0x1d1>
        cprintf("mpinit: ncpu=%d apicpid=%d", ncpu, proc->apicid);
        panic("mpinit");
      }
      if(proc->flags & MPBOOT)
  102ae9:	f6 40 03 02          	testb  $0x2,0x3(%eax)
  102aed:	74 0f                	je     102afe <mpinit+0x17e>
        bcpu = &cpus[ncpu];
  102aef:	69 f9 bc 00 00 00    	imul   $0xbc,%ecx,%edi
  102af5:	81 c7 a0 aa 10 00    	add    $0x10aaa0,%edi
  102afb:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      cpus[ncpu].id = ncpu;
  102afe:	69 f9 bc 00 00 00    	imul   $0xbc,%ecx,%edi
      ncpu++;
  102b04:	83 c1 01             	add    $0x1,%ecx
  102b07:	89 0d 80 b0 10 00    	mov    %ecx,0x10b080
      p += sizeof(struct mpproc);
  102b0d:	83 c0 14             	add    $0x14,%eax
        cprintf("mpinit: ncpu=%d apicpid=%d", ncpu, proc->apicid);
        panic("mpinit");
      }
      if(proc->flags & MPBOOT)
        bcpu = &cpus[ncpu];
      cpus[ncpu].id = ncpu;
  102b10:	88 9f a0 aa 10 00    	mov    %bl,0x10aaa0(%edi)
      ncpu++;
      p += sizeof(struct mpproc);
      continue;
  102b16:	eb 8b                	jmp    102aa3 <mpinit+0x123>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
  102b18:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
  102b1c:	83 c0 08             	add    $0x8,%eax
      ncpu++;
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
  102b1f:	88 0d 80 aa 10 00    	mov    %cl,0x10aa80
      p += sizeof(struct mpioapic);
      continue;
  102b25:	e9 79 ff ff ff       	jmp    102aa3 <mpinit+0x123>
  102b2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1((uchar*)p-1024, 1024)))
      return mp;
  }
  return mpsearch1((uchar*)0xF0000, 0x10000);
  102b30:	ba 00 00 01 00       	mov    $0x10000,%edx
  102b35:	b8 00 00 0f 00       	mov    $0xf0000,%eax
  102b3a:	e8 c1 fd ff ff       	call   102900 <mpsearch1>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
  102b3f:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1((uchar*)p-1024, 1024)))
      return mp;
  }
  return mpsearch1((uchar*)0xF0000, 0x10000);
  102b41:	89 c3                	mov    %eax,%ebx
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
  102b43:	0f 85 93 fe ff ff    	jne    1029dc <mpinit+0x5c>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
  102b49:	83 c4 2c             	add    $0x2c,%esp
  102b4c:	5b                   	pop    %ebx
  102b4d:	5e                   	pop    %esi
  102b4e:	5f                   	pop    %edi
  102b4f:	5d                   	pop    %ebp
  102b50:	c3                   	ret    
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu != proc->apicid) {
  102b51:	8b 45 e4             	mov    -0x1c(%ebp),%eax
        cprintf("mpinit: ncpu=%d apicpid=%d", ncpu, proc->apicid);
  102b54:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  102b58:	89 7c 24 04          	mov    %edi,0x4(%esp)
  102b5c:	c7 04 24 46 69 10 00 	movl   $0x106946,(%esp)
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu != proc->apicid) {
  102b63:	a3 44 78 10 00       	mov    %eax,0x107844
        cprintf("mpinit: ncpu=%d apicpid=%d", ncpu, proc->apicid);
  102b68:	e8 53 d9 ff ff       	call   1004c0 <cprintf>
        panic("mpinit");
  102b6d:	c7 04 24 61 69 10 00 	movl   $0x106961,(%esp)
  102b74:	e8 37 dd ff ff       	call   1008b0 <panic>
  102b79:	90                   	nop
  102b7a:	90                   	nop
  102b7b:	90                   	nop
  102b7c:	90                   	nop
  102b7d:	90                   	nop
  102b7e:	90                   	nop
  102b7f:	90                   	nop

00102b80 <picenable>:
  outb(IO_PIC2+1, mask >> 8);
}

void
picenable(int irq)
{
  102b80:	55                   	push   %ebp
  picsetmask(irqmask & ~(1<<irq));
  102b81:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
  outb(IO_PIC2+1, mask >> 8);
}

void
picenable(int irq)
{
  102b86:	89 e5                	mov    %esp,%ebp
  102b88:	ba 21 00 00 00       	mov    $0x21,%edx
  picsetmask(irqmask & ~(1<<irq));
  102b8d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  102b90:	d3 c0                	rol    %cl,%eax
  102b92:	66 23 05 00 73 10 00 	and    0x107300,%ax
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
  irqmask = mask;
  102b99:	66 a3 00 73 10 00    	mov    %ax,0x107300
  102b9f:	ee                   	out    %al,(%dx)
  102ba0:	66 c1 e8 08          	shr    $0x8,%ax
  102ba4:	b2 a1                	mov    $0xa1,%dl
  102ba6:	ee                   	out    %al,(%dx)

void
picenable(int irq)
{
  picsetmask(irqmask & ~(1<<irq));
}
  102ba7:	5d                   	pop    %ebp
  102ba8:	c3                   	ret    
  102ba9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102bb0 <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
  102bb0:	55                   	push   %ebp
  102bb1:	b9 21 00 00 00       	mov    $0x21,%ecx
  102bb6:	89 e5                	mov    %esp,%ebp
  102bb8:	83 ec 0c             	sub    $0xc,%esp
  102bbb:	89 1c 24             	mov    %ebx,(%esp)
  102bbe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  102bc3:	89 ca                	mov    %ecx,%edx
  102bc5:	89 74 24 04          	mov    %esi,0x4(%esp)
  102bc9:	89 7c 24 08          	mov    %edi,0x8(%esp)
  102bcd:	ee                   	out    %al,(%dx)
  102bce:	bb a1 00 00 00       	mov    $0xa1,%ebx
  102bd3:	89 da                	mov    %ebx,%edx
  102bd5:	ee                   	out    %al,(%dx)
  102bd6:	be 11 00 00 00       	mov    $0x11,%esi
  102bdb:	b2 20                	mov    $0x20,%dl
  102bdd:	89 f0                	mov    %esi,%eax
  102bdf:	ee                   	out    %al,(%dx)
  102be0:	b8 20 00 00 00       	mov    $0x20,%eax
  102be5:	89 ca                	mov    %ecx,%edx
  102be7:	ee                   	out    %al,(%dx)
  102be8:	b8 04 00 00 00       	mov    $0x4,%eax
  102bed:	ee                   	out    %al,(%dx)
  102bee:	bf 03 00 00 00       	mov    $0x3,%edi
  102bf3:	89 f8                	mov    %edi,%eax
  102bf5:	ee                   	out    %al,(%dx)
  102bf6:	b1 a0                	mov    $0xa0,%cl
  102bf8:	89 f0                	mov    %esi,%eax
  102bfa:	89 ca                	mov    %ecx,%edx
  102bfc:	ee                   	out    %al,(%dx)
  102bfd:	b8 28 00 00 00       	mov    $0x28,%eax
  102c02:	89 da                	mov    %ebx,%edx
  102c04:	ee                   	out    %al,(%dx)
  102c05:	b8 02 00 00 00       	mov    $0x2,%eax
  102c0a:	ee                   	out    %al,(%dx)
  102c0b:	89 f8                	mov    %edi,%eax
  102c0d:	ee                   	out    %al,(%dx)
  102c0e:	be 68 00 00 00       	mov    $0x68,%esi
  102c13:	b2 20                	mov    $0x20,%dl
  102c15:	89 f0                	mov    %esi,%eax
  102c17:	ee                   	out    %al,(%dx)
  102c18:	bb 0a 00 00 00       	mov    $0xa,%ebx
  102c1d:	89 d8                	mov    %ebx,%eax
  102c1f:	ee                   	out    %al,(%dx)
  102c20:	89 f0                	mov    %esi,%eax
  102c22:	89 ca                	mov    %ecx,%edx
  102c24:	ee                   	out    %al,(%dx)
  102c25:	89 d8                	mov    %ebx,%eax
  102c27:	ee                   	out    %al,(%dx)
  outb(IO_PIC1, 0x0a);             // read IRR by default

  outb(IO_PIC2, 0x68);             // OCW3
  outb(IO_PIC2, 0x0a);             // OCW3

  if(irqmask != 0xFFFF)
  102c28:	0f b7 05 00 73 10 00 	movzwl 0x107300,%eax
  102c2f:	66 83 f8 ff          	cmp    $0xffffffff,%ax
  102c33:	74 0a                	je     102c3f <picinit+0x8f>
  102c35:	b2 21                	mov    $0x21,%dl
  102c37:	ee                   	out    %al,(%dx)
  102c38:	66 c1 e8 08          	shr    $0x8,%ax
  102c3c:	b2 a1                	mov    $0xa1,%dl
  102c3e:	ee                   	out    %al,(%dx)
    picsetmask(irqmask);
}
  102c3f:	8b 1c 24             	mov    (%esp),%ebx
  102c42:	8b 74 24 04          	mov    0x4(%esp),%esi
  102c46:	8b 7c 24 08          	mov    0x8(%esp),%edi
  102c4a:	89 ec                	mov    %ebp,%esp
  102c4c:	5d                   	pop    %ebp
  102c4d:	c3                   	ret    
  102c4e:	90                   	nop
  102c4f:	90                   	nop

00102c50 <piperead>:
  return n;
}

int
piperead(struct pipe *p, char *addr, int n)
{
  102c50:	55                   	push   %ebp
  102c51:	89 e5                	mov    %esp,%ebp
  102c53:	57                   	push   %edi
  102c54:	56                   	push   %esi
  102c55:	53                   	push   %ebx
  102c56:	83 ec 1c             	sub    $0x1c,%esp
  102c59:	8b 5d 08             	mov    0x8(%ebp),%ebx
  102c5c:	8b 7d 10             	mov    0x10(%ebp),%edi
  int i;

  acquire(&p->lock);
  102c5f:	89 1c 24             	mov    %ebx,(%esp)
  102c62:	e8 b9 0e 00 00       	call   103b20 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
  102c67:	8b 93 34 02 00 00    	mov    0x234(%ebx),%edx
  102c6d:	3b 93 38 02 00 00    	cmp    0x238(%ebx),%edx
  102c73:	75 58                	jne    102ccd <piperead+0x7d>
  102c75:	8b b3 40 02 00 00    	mov    0x240(%ebx),%esi
  102c7b:	85 f6                	test   %esi,%esi
  102c7d:	74 4e                	je     102ccd <piperead+0x7d>
    if(proc->killed){
  102c7f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  102c85:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
    if(proc->killed){
  102c8b:	8b 48 24             	mov    0x24(%eax),%ecx
  102c8e:	85 c9                	test   %ecx,%ecx
  102c90:	74 21                	je     102cb3 <piperead+0x63>
  102c92:	e9 99 00 00 00       	jmp    102d30 <piperead+0xe0>
  102c97:	90                   	nop
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
  102c98:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
  102c9e:	85 c0                	test   %eax,%eax
  102ca0:	74 2b                	je     102ccd <piperead+0x7d>
    if(proc->killed){
  102ca2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  102ca8:	8b 50 24             	mov    0x24(%eax),%edx
  102cab:	85 d2                	test   %edx,%edx
  102cad:	0f 85 7d 00 00 00    	jne    102d30 <piperead+0xe0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  102cb3:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  102cb7:	89 34 24             	mov    %esi,(%esp)
  102cba:	e8 b1 04 00 00       	call   103170 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
  102cbf:	8b 93 34 02 00 00    	mov    0x234(%ebx),%edx
  102cc5:	3b 93 38 02 00 00    	cmp    0x238(%ebx),%edx
  102ccb:	74 cb                	je     102c98 <piperead+0x48>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
  102ccd:	85 ff                	test   %edi,%edi
  102ccf:	7e 76                	jle    102d47 <piperead+0xf7>
    if(p->nread == p->nwrite)
  102cd1:	31 f6                	xor    %esi,%esi
  102cd3:	3b 93 38 02 00 00    	cmp    0x238(%ebx),%edx
  102cd9:	75 0d                	jne    102ce8 <piperead+0x98>
  102cdb:	eb 6a                	jmp    102d47 <piperead+0xf7>
  102cdd:	8d 76 00             	lea    0x0(%esi),%esi
  102ce0:	39 93 38 02 00 00    	cmp    %edx,0x238(%ebx)
  102ce6:	74 22                	je     102d0a <piperead+0xba>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  102ce8:	89 d0                	mov    %edx,%eax
  102cea:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  102ced:	83 c2 01             	add    $0x1,%edx
  102cf0:	25 ff 01 00 00       	and    $0x1ff,%eax
  102cf5:	0f b6 44 03 34       	movzbl 0x34(%ebx,%eax,1),%eax
  102cfa:	88 04 31             	mov    %al,(%ecx,%esi,1)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
  102cfd:	83 c6 01             	add    $0x1,%esi
  102d00:	39 f7                	cmp    %esi,%edi
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  102d02:	89 93 34 02 00 00    	mov    %edx,0x234(%ebx)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
  102d08:	7f d6                	jg     102ce0 <piperead+0x90>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  102d0a:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
  102d10:	89 04 24             	mov    %eax,(%esp)
  102d13:	e8 38 03 00 00       	call   103050 <wakeup>
  release(&p->lock);
  102d18:	89 1c 24             	mov    %ebx,(%esp)
  102d1b:	e8 b0 0d 00 00       	call   103ad0 <release>
  return i;
}
  102d20:	83 c4 1c             	add    $0x1c,%esp
  102d23:	89 f0                	mov    %esi,%eax
  102d25:	5b                   	pop    %ebx
  102d26:	5e                   	pop    %esi
  102d27:	5f                   	pop    %edi
  102d28:	5d                   	pop    %ebp
  102d29:	c3                   	ret    
  102d2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
    if(proc->killed){
      release(&p->lock);
  102d30:	be ff ff ff ff       	mov    $0xffffffff,%esi
  102d35:	89 1c 24             	mov    %ebx,(%esp)
  102d38:	e8 93 0d 00 00       	call   103ad0 <release>
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
  102d3d:	83 c4 1c             	add    $0x1c,%esp
  102d40:	89 f0                	mov    %esi,%eax
  102d42:	5b                   	pop    %ebx
  102d43:	5e                   	pop    %esi
  102d44:	5f                   	pop    %edi
  102d45:	5d                   	pop    %ebp
  102d46:	c3                   	ret    
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
  102d47:	31 f6                	xor    %esi,%esi
  102d49:	eb bf                	jmp    102d0a <piperead+0xba>
  102d4b:	90                   	nop
  102d4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00102d50 <pipewrite>:
    release(&p->lock);
}

int
pipewrite(struct pipe *p, char *addr, int n)
{
  102d50:	55                   	push   %ebp
  102d51:	89 e5                	mov    %esp,%ebp
  102d53:	57                   	push   %edi
  102d54:	56                   	push   %esi
  102d55:	53                   	push   %ebx
  102d56:	83 ec 3c             	sub    $0x3c,%esp
  102d59:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
  102d5c:	89 1c 24             	mov    %ebx,(%esp)
  102d5f:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
  102d65:	e8 b6 0d 00 00       	call   103b20 <acquire>
  for(i = 0; i < n; i++){
  102d6a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  102d6d:	85 c9                	test   %ecx,%ecx
  102d6f:	0f 8e 8d 00 00 00    	jle    102e02 <pipewrite+0xb2>
  102d75:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
      if(p->readopen == 0 || proc->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
  102d7b:	8d bb 38 02 00 00    	lea    0x238(%ebx),%edi
  102d81:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  102d88:	eb 37                	jmp    102dc1 <pipewrite+0x71>
  102d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE) {  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
  102d90:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
  102d96:	85 c0                	test   %eax,%eax
  102d98:	74 7e                	je     102e18 <pipewrite+0xc8>
  102d9a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  102da0:	8b 50 24             	mov    0x24(%eax),%edx
  102da3:	85 d2                	test   %edx,%edx
  102da5:	75 71                	jne    102e18 <pipewrite+0xc8>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
  102da7:	89 34 24             	mov    %esi,(%esp)
  102daa:	e8 a1 02 00 00       	call   103050 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
  102daf:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  102db3:	89 3c 24             	mov    %edi,(%esp)
  102db6:	e8 b5 03 00 00       	call   103170 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE) {  //DOC: pipewrite-full
  102dbb:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
  102dc1:	8b 93 34 02 00 00    	mov    0x234(%ebx),%edx
  102dc7:	81 c2 00 02 00 00    	add    $0x200,%edx
  102dcd:	39 d0                	cmp    %edx,%eax
  102dcf:	74 bf                	je     102d90 <pipewrite+0x40>
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  102dd1:	89 c2                	mov    %eax,%edx
  102dd3:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  102dd6:	83 c0 01             	add    $0x1,%eax
  102dd9:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  102ddf:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  102de2:	8b 55 0c             	mov    0xc(%ebp),%edx
  102de5:	0f b6 0c 0a          	movzbl (%edx,%ecx,1),%ecx
  102de9:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  102dec:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  102df0:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
  102df6:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
  102dfa:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  102dfd:	39 4d 10             	cmp    %ecx,0x10(%ebp)
  102e00:	7f bf                	jg     102dc1 <pipewrite+0x71>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  102e02:	89 34 24             	mov    %esi,(%esp)
  102e05:	e8 46 02 00 00       	call   103050 <wakeup>
  release(&p->lock);
  102e0a:	89 1c 24             	mov    %ebx,(%esp)
  102e0d:	e8 be 0c 00 00       	call   103ad0 <release>
  return n;
  102e12:	eb 13                	jmp    102e27 <pipewrite+0xd7>
  102e14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE) {  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
        release(&p->lock);
  102e18:	89 1c 24             	mov    %ebx,(%esp)
  102e1b:	e8 b0 0c 00 00       	call   103ad0 <release>
  102e20:	c7 45 10 ff ff ff ff 	movl   $0xffffffff,0x10(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
  102e27:	8b 45 10             	mov    0x10(%ebp),%eax
  102e2a:	83 c4 3c             	add    $0x3c,%esp
  102e2d:	5b                   	pop    %ebx
  102e2e:	5e                   	pop    %esi
  102e2f:	5f                   	pop    %edi
  102e30:	5d                   	pop    %ebp
  102e31:	c3                   	ret    
  102e32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00102e40 <pipeclose>:
  return -1;
}

void
pipeclose(struct pipe *p, int writable)
{
  102e40:	55                   	push   %ebp
  102e41:	89 e5                	mov    %esp,%ebp
  102e43:	83 ec 18             	sub    $0x18,%esp
  102e46:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  102e49:	8b 5d 08             	mov    0x8(%ebp),%ebx
  102e4c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  102e4f:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
  102e52:	89 1c 24             	mov    %ebx,(%esp)
  102e55:	e8 c6 0c 00 00       	call   103b20 <acquire>
  if(writable){
  102e5a:	85 f6                	test   %esi,%esi
  102e5c:	74 42                	je     102ea0 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
  102e5e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
void
pipeclose(struct pipe *p, int writable)
{
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
  102e64:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
  102e6b:	00 00 00 
    wakeup(&p->nread);
  102e6e:	89 04 24             	mov    %eax,(%esp)
  102e71:	e8 da 01 00 00       	call   103050 <wakeup>
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0) {
  102e76:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
  102e7c:	85 c0                	test   %eax,%eax
  102e7e:	75 0a                	jne    102e8a <pipeclose+0x4a>
  102e80:	8b b3 40 02 00 00    	mov    0x240(%ebx),%esi
  102e86:	85 f6                	test   %esi,%esi
  102e88:	74 36                	je     102ec0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
  102e8a:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
  102e8d:	8b 75 fc             	mov    -0x4(%ebp),%esi
  102e90:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  102e93:	89 ec                	mov    %ebp,%esp
  102e95:	5d                   	pop    %ebp
  }
  if(p->readopen == 0 && p->writeopen == 0) {
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
  102e96:	e9 35 0c 00 00       	jmp    103ad0 <release>
  102e9b:	90                   	nop
  102e9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  102ea0:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
  102ea6:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
  102ead:	00 00 00 
    wakeup(&p->nwrite);
  102eb0:	89 04 24             	mov    %eax,(%esp)
  102eb3:	e8 98 01 00 00       	call   103050 <wakeup>
  102eb8:	eb bc                	jmp    102e76 <pipeclose+0x36>
  102eba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
  if(p->readopen == 0 && p->writeopen == 0) {
    release(&p->lock);
  102ec0:	89 1c 24             	mov    %ebx,(%esp)
  102ec3:	e8 08 0c 00 00       	call   103ad0 <release>
    kfree((char*)p);
  } else
    release(&p->lock);
}
  102ec8:	8b 75 fc             	mov    -0x4(%ebp),%esi
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0) {
    release(&p->lock);
    kfree((char*)p);
  102ecb:	89 5d 08             	mov    %ebx,0x8(%ebp)
  } else
    release(&p->lock);
}
  102ece:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  102ed1:	89 ec                	mov    %ebp,%esp
  102ed3:	5d                   	pop    %ebp
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0) {
    release(&p->lock);
    kfree((char*)p);
  102ed4:	e9 b7 f3 ff ff       	jmp    102290 <kfree>
  102ed9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102ee0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
  102ee0:	55                   	push   %ebp
  102ee1:	89 e5                	mov    %esp,%ebp
  102ee3:	57                   	push   %edi
  102ee4:	56                   	push   %esi
  102ee5:	53                   	push   %ebx
  102ee6:	83 ec 1c             	sub    $0x1c,%esp
  102ee9:	8b 75 08             	mov    0x8(%ebp),%esi
  102eec:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
  102eef:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  102ef5:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
  102efb:	e8 e0 df ff ff       	call   100ee0 <filealloc>
  102f00:	85 c0                	test   %eax,%eax
  102f02:	89 06                	mov    %eax,(%esi)
  102f04:	0f 84 9c 00 00 00    	je     102fa6 <pipealloc+0xc6>
  102f0a:	e8 d1 df ff ff       	call   100ee0 <filealloc>
  102f0f:	85 c0                	test   %eax,%eax
  102f11:	89 03                	mov    %eax,(%ebx)
  102f13:	0f 84 7f 00 00 00    	je     102f98 <pipealloc+0xb8>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
  102f19:	e8 32 f3 ff ff       	call   102250 <kalloc>
  102f1e:	85 c0                	test   %eax,%eax
  102f20:	89 c7                	mov    %eax,%edi
  102f22:	74 74                	je     102f98 <pipealloc+0xb8>
    goto bad;
  p->readopen = 1;
  102f24:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
  102f2b:	00 00 00 
  p->writeopen = 1;
  102f2e:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
  102f35:	00 00 00 
  p->nwrite = 0;
  102f38:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
  102f3f:	00 00 00 
  p->nread = 0;
  102f42:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
  102f49:	00 00 00 
  initlock(&p->lock, "pipe");
  102f4c:	89 04 24             	mov    %eax,(%esp)
  102f4f:	c7 44 24 04 9c 69 10 	movl   $0x10699c,0x4(%esp)
  102f56:	00 
  102f57:	e8 34 0a 00 00       	call   103990 <initlock>
  (*f0)->type = FD_PIPE;
  102f5c:	8b 06                	mov    (%esi),%eax
  102f5e:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
  102f64:	8b 06                	mov    (%esi),%eax
  102f66:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
  102f6a:	8b 06                	mov    (%esi),%eax
  102f6c:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
  102f70:	8b 06                	mov    (%esi),%eax
  102f72:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
  102f75:	8b 03                	mov    (%ebx),%eax
  102f77:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
  102f7d:	8b 03                	mov    (%ebx),%eax
  102f7f:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
  102f83:	8b 03                	mov    (%ebx),%eax
  102f85:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
  102f89:	8b 03                	mov    (%ebx),%eax
  102f8b:	89 78 0c             	mov    %edi,0xc(%eax)
  102f8e:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
  102f90:	83 c4 1c             	add    $0x1c,%esp
  102f93:	5b                   	pop    %ebx
  102f94:	5e                   	pop    %esi
  102f95:	5f                   	pop    %edi
  102f96:	5d                   	pop    %ebp
  102f97:	c3                   	ret    
  return 0;

 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
  102f98:	8b 06                	mov    (%esi),%eax
  102f9a:	85 c0                	test   %eax,%eax
  102f9c:	74 08                	je     102fa6 <pipealloc+0xc6>
    fileclose(*f0);
  102f9e:	89 04 24             	mov    %eax,(%esp)
  102fa1:	e8 ba df ff ff       	call   100f60 <fileclose>
  if(*f1)
  102fa6:	8b 13                	mov    (%ebx),%edx
  102fa8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  102fad:	85 d2                	test   %edx,%edx
  102faf:	74 df                	je     102f90 <pipealloc+0xb0>
    fileclose(*f1);
  102fb1:	89 14 24             	mov    %edx,(%esp)
  102fb4:	e8 a7 df ff ff       	call   100f60 <fileclose>
  102fb9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  102fbe:	eb d0                	jmp    102f90 <pipealloc+0xb0>

00102fc0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
  102fc0:	55                   	push   %ebp
  102fc1:	89 e5                	mov    %esp,%ebp
  102fc3:	53                   	push   %ebx
  102fc4:	83 ec 14             	sub    $0x14,%esp
  102fc7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
  102fca:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  102fd1:	e8 4a 0b 00 00       	call   103b20 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
  102fd6:	8b 15 e4 b0 10 00    	mov    0x10b0e4,%edx

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
  102fdc:	b8 54 b1 10 00       	mov    $0x10b154,%eax
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
  102fe1:	39 da                	cmp    %ebx,%edx
  102fe3:	75 0d                	jne    102ff2 <kill+0x32>
  102fe5:	eb 60                	jmp    103047 <kill+0x87>
  102fe7:	90                   	nop
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  102fe8:	83 e8 80             	sub    $0xffffff80,%eax
  102feb:	3d d4 d0 10 00       	cmp    $0x10d0d4,%eax
  102ff0:	74 3e                	je     103030 <kill+0x70>
    if(p->pid == pid){
  102ff2:	8b 50 10             	mov    0x10(%eax),%edx
  102ff5:	39 da                	cmp    %ebx,%edx
  102ff7:	75 ef                	jne    102fe8 <kill+0x28>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
  102ff9:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
  102ffd:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
  103004:	74 1a                	je     103020 <kill+0x60>
        p->state = RUNNABLE;
      release(&ptable.lock);
  103006:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  10300d:	e8 be 0a 00 00       	call   103ad0 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
  103012:	83 c4 14             	add    $0x14,%esp
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
      release(&ptable.lock);
  103015:	31 c0                	xor    %eax,%eax
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
  103017:	5b                   	pop    %ebx
  103018:	5d                   	pop    %ebp
  103019:	c3                   	ret    
  10301a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
  103020:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  103027:	eb dd                	jmp    103006 <kill+0x46>
  103029:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  103030:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  103037:	e8 94 0a 00 00       	call   103ad0 <release>
  return -1;
}
  10303c:	83 c4 14             	add    $0x14,%esp
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  10303f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return -1;
}
  103044:	5b                   	pop    %ebx
  103045:	5d                   	pop    %ebp
  103046:	c3                   	ret    
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
  103047:	b8 d4 b0 10 00       	mov    $0x10b0d4,%eax
  10304c:	eb ab                	jmp    102ff9 <kill+0x39>
  10304e:	66 90                	xchg   %ax,%ax

00103050 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
  103050:	55                   	push   %ebp
  103051:	89 e5                	mov    %esp,%ebp
  103053:	53                   	push   %ebx
  103054:	83 ec 14             	sub    $0x14,%esp
  103057:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
  10305a:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  103061:	e8 ba 0a 00 00       	call   103b20 <acquire>
      p->state = RUNNABLE;
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
  103066:	b8 d4 b0 10 00       	mov    $0x10b0d4,%eax
  10306b:	eb 0d                	jmp    10307a <wakeup+0x2a>
  10306d:	8d 76 00             	lea    0x0(%esi),%esi
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  103070:	83 e8 80             	sub    $0xffffff80,%eax
  103073:	3d d4 d0 10 00       	cmp    $0x10d0d4,%eax
  103078:	74 1e                	je     103098 <wakeup+0x48>
    if(p->state == SLEEPING && p->chan == chan)
  10307a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  10307e:	75 f0                	jne    103070 <wakeup+0x20>
  103080:	3b 58 20             	cmp    0x20(%eax),%ebx
  103083:	75 eb                	jne    103070 <wakeup+0x20>
      p->state = RUNNABLE;
  103085:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  10308c:	83 e8 80             	sub    $0xffffff80,%eax
  10308f:	3d d4 d0 10 00       	cmp    $0x10d0d4,%eax
  103094:	75 e4                	jne    10307a <wakeup+0x2a>
  103096:	66 90                	xchg   %ax,%ax
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
  103098:	c7 45 08 a0 b0 10 00 	movl   $0x10b0a0,0x8(%ebp)
}
  10309f:	83 c4 14             	add    $0x14,%esp
  1030a2:	5b                   	pop    %ebx
  1030a3:	5d                   	pop    %ebp
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
  1030a4:	e9 27 0a 00 00       	jmp    103ad0 <release>
  1030a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001030b0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
  1030b0:	55                   	push   %ebp
  1030b1:	89 e5                	mov    %esp,%ebp
  1030b3:	83 ec 18             	sub    $0x18,%esp
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
  1030b6:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  1030bd:	e8 0e 0a 00 00       	call   103ad0 <release>
  
  // Return to "caller", actually trapret (see allocproc).
}
  1030c2:	c9                   	leave  
  1030c3:	c3                   	ret    
  1030c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1030ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

001030d0 <sched>:

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state.
void
sched(void)
{
  1030d0:	55                   	push   %ebp
  1030d1:	89 e5                	mov    %esp,%ebp
  1030d3:	53                   	push   %ebx
  1030d4:	83 ec 14             	sub    $0x14,%esp
  int intena;

  if(!holding(&ptable.lock))
  1030d7:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  1030de:	e8 2d 09 00 00       	call   103a10 <holding>
  1030e3:	85 c0                	test   %eax,%eax
  1030e5:	74 4d                	je     103134 <sched+0x64>
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
  1030e7:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  1030ed:	83 b8 ac 00 00 00 01 	cmpl   $0x1,0xac(%eax)
  1030f4:	75 62                	jne    103158 <sched+0x88>
    panic("sched locks");
  if(proc->state == RUNNING)
  1030f6:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  1030fd:	83 7a 0c 04          	cmpl   $0x4,0xc(%edx)
  103101:	74 49                	je     10314c <sched+0x7c>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  103103:	9c                   	pushf  
  103104:	59                   	pop    %ecx
    panic("sched running");
  if(readeflags()&FL_IF)
  103105:	80 e5 02             	and    $0x2,%ch
  103108:	75 36                	jne    103140 <sched+0x70>
    panic("sched interruptible");
  intena = cpu->intena;
  10310a:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
  swtch(&proc->context, cpu->scheduler);
  103110:	83 c2 1c             	add    $0x1c,%edx
  103113:	8b 40 04             	mov    0x4(%eax),%eax
  103116:	89 14 24             	mov    %edx,(%esp)
  103119:	89 44 24 04          	mov    %eax,0x4(%esp)
  10311d:	e8 9a 0c 00 00       	call   103dbc <swtch>
  cpu->intena = intena;
  103122:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  103128:	89 98 b0 00 00 00    	mov    %ebx,0xb0(%eax)
}
  10312e:	83 c4 14             	add    $0x14,%esp
  103131:	5b                   	pop    %ebx
  103132:	5d                   	pop    %ebp
  103133:	c3                   	ret    
sched(void)
{
  int intena;

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  103134:	c7 04 24 a1 69 10 00 	movl   $0x1069a1,(%esp)
  10313b:	e8 70 d7 ff ff       	call   1008b0 <panic>
  if(cpu->ncli != 1)
    panic("sched locks");
  if(proc->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  103140:	c7 04 24 cd 69 10 00 	movl   $0x1069cd,(%esp)
  103147:	e8 64 d7 ff ff       	call   1008b0 <panic>
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
    panic("sched locks");
  if(proc->state == RUNNING)
    panic("sched running");
  10314c:	c7 04 24 bf 69 10 00 	movl   $0x1069bf,(%esp)
  103153:	e8 58 d7 ff ff       	call   1008b0 <panic>
  int intena;

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
    panic("sched locks");
  103158:	c7 04 24 b3 69 10 00 	movl   $0x1069b3,(%esp)
  10315f:	e8 4c d7 ff ff       	call   1008b0 <panic>
  103164:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10316a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00103170 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  103170:	55                   	push   %ebp
  103171:	89 e5                	mov    %esp,%ebp
  103173:	56                   	push   %esi
  103174:	53                   	push   %ebx
  103175:	83 ec 10             	sub    $0x10,%esp
  if(proc == 0)
  103178:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  10317e:	8b 75 08             	mov    0x8(%ebp),%esi
  103181:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(proc == 0)
  103184:	85 c0                	test   %eax,%eax
  103186:	0f 84 a1 00 00 00    	je     10322d <sleep+0xbd>
    panic("sleep");

  if(lk == 0)
  10318c:	85 db                	test   %ebx,%ebx
  10318e:	0f 84 8d 00 00 00    	je     103221 <sleep+0xb1>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
  103194:	81 fb a0 b0 10 00    	cmp    $0x10b0a0,%ebx
  10319a:	74 5c                	je     1031f8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
  10319c:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  1031a3:	e8 78 09 00 00       	call   103b20 <acquire>
    release(lk);
  1031a8:	89 1c 24             	mov    %ebx,(%esp)
  1031ab:	e8 20 09 00 00       	call   103ad0 <release>
  }

  // Go to sleep.
  proc->chan = chan;
  1031b0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1031b6:	89 70 20             	mov    %esi,0x20(%eax)
  proc->state = SLEEPING;
  1031b9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1031bf:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
  1031c6:	e8 05 ff ff ff       	call   1030d0 <sched>

  // Tidy up.
  proc->chan = 0;
  1031cb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1031d1:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
  1031d8:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  1031df:	e8 ec 08 00 00       	call   103ad0 <release>
    acquire(lk);
  1031e4:	89 5d 08             	mov    %ebx,0x8(%ebp)
  }
}
  1031e7:	83 c4 10             	add    $0x10,%esp
  1031ea:	5b                   	pop    %ebx
  1031eb:	5e                   	pop    %esi
  1031ec:	5d                   	pop    %ebp
  proc->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  1031ed:	e9 2e 09 00 00       	jmp    103b20 <acquire>
  1031f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }

  // Go to sleep.
  proc->chan = chan;
  1031f8:	89 70 20             	mov    %esi,0x20(%eax)
  proc->state = SLEEPING;
  1031fb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103201:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
  103208:	e8 c3 fe ff ff       	call   1030d0 <sched>

  // Tidy up.
  proc->chan = 0;
  10320d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103213:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
  10321a:	83 c4 10             	add    $0x10,%esp
  10321d:	5b                   	pop    %ebx
  10321e:	5e                   	pop    %esi
  10321f:	5d                   	pop    %ebp
  103220:	c3                   	ret    
{
  if(proc == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
  103221:	c7 04 24 e7 69 10 00 	movl   $0x1069e7,(%esp)
  103228:	e8 83 d6 ff ff       	call   1008b0 <panic>
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  if(proc == 0)
    panic("sleep");
  10322d:	c7 04 24 e1 69 10 00 	movl   $0x1069e1,(%esp)
  103234:	e8 77 d6 ff ff       	call   1008b0 <panic>
  103239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00103240 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
  103240:	55                   	push   %ebp
  103241:	89 e5                	mov    %esp,%ebp
  103243:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
  103246:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  10324d:	e8 ce 08 00 00       	call   103b20 <acquire>
  proc->state = RUNNABLE;
  103252:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103258:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
  10325f:	e8 6c fe ff ff       	call   1030d0 <sched>
  release(&ptable.lock);
  103264:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  10326b:	e8 60 08 00 00       	call   103ad0 <release>
}
  103270:	c9                   	leave  
  103271:	c3                   	ret    
  103272:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103280 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
  103280:	55                   	push   %ebp
  103281:	89 e5                	mov    %esp,%ebp
  103283:	53                   	push   %ebx
  103284:	83 ec 14             	sub    $0x14,%esp
  103287:	90                   	nop
}

static inline void
sti(void)
{
  asm volatile("sti");
  103288:	fb                   	sti    
//  - choose a process to run
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
  103289:	bb d4 b0 10 00       	mov    $0x10b0d4,%ebx
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
  10328e:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  103295:	e8 86 08 00 00       	call   103b20 <acquire>
  10329a:	eb 0f                	jmp    1032ab <scheduler+0x2b>
  10329c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  1032a0:	83 eb 80             	sub    $0xffffff80,%ebx
  1032a3:	81 fb d4 d0 10 00    	cmp    $0x10d0d4,%ebx
  1032a9:	74 5d                	je     103308 <scheduler+0x88>
      if(p->state != RUNNABLE)
  1032ab:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
  1032af:	90                   	nop
  1032b0:	75 ee                	jne    1032a0 <scheduler+0x20>
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
  1032b2:	65 89 1d 04 00 00 00 	mov    %ebx,%gs:0x4
      switchuvm(p);
  1032b9:	89 1c 24             	mov    %ebx,(%esp)
  1032bc:	e8 ef 2f 00 00       	call   1062b0 <switchuvm>
      p->state = RUNNING;
      swtch(&cpu->scheduler, proc->context);
  1032c1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
      switchuvm(p);
      p->state = RUNNING;
  1032c7:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  1032ce:	83 eb 80             	sub    $0xffffff80,%ebx
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
      switchuvm(p);
      p->state = RUNNING;
      swtch(&cpu->scheduler, proc->context);
  1032d1:	8b 40 1c             	mov    0x1c(%eax),%eax
  1032d4:	89 44 24 04          	mov    %eax,0x4(%esp)
  1032d8:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  1032de:	83 c0 04             	add    $0x4,%eax
  1032e1:	89 04 24             	mov    %eax,(%esp)
  1032e4:	e8 d3 0a 00 00       	call   103dbc <swtch>
      switchkvm();
  1032e9:	e8 92 29 00 00       	call   105c80 <switchkvm>
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  1032ee:	81 fb d4 d0 10 00    	cmp    $0x10d0d4,%ebx
      swtch(&cpu->scheduler, proc->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
  1032f4:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
  1032fb:	00 00 00 00 
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  1032ff:	75 aa                	jne    1032ab <scheduler+0x2b>
  103301:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
    }
    release(&ptable.lock);
  103308:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  10330f:	e8 bc 07 00 00       	call   103ad0 <release>

  }
  103314:	e9 6f ff ff ff       	jmp    103288 <scheduler+0x8>
  103319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00103320 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  103320:	55                   	push   %ebp
  103321:	89 e5                	mov    %esp,%ebp
  103323:	53                   	push   %ebx
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
  103324:	bb d4 b0 10 00       	mov    $0x10b0d4,%ebx

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  103329:	83 ec 24             	sub    $0x24,%esp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
  10332c:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  103333:	e8 e8 07 00 00       	call   103b20 <acquire>
  103338:	31 c0                	xor    %eax,%eax
  10333a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  103340:	81 fb d4 d0 10 00    	cmp    $0x10d0d4,%ebx
  103346:	72 30                	jb     103378 <wait+0x58>
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
  103348:	85 c0                	test   %eax,%eax
  10334a:	74 5c                	je     1033a8 <wait+0x88>
  10334c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103352:	8b 50 24             	mov    0x24(%eax),%edx
  103355:	85 d2                	test   %edx,%edx
  103357:	75 4f                	jne    1033a8 <wait+0x88>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  103359:	bb d4 b0 10 00       	mov    $0x10b0d4,%ebx
  10335e:	89 04 24             	mov    %eax,(%esp)
  103361:	c7 44 24 04 a0 b0 10 	movl   $0x10b0a0,0x4(%esp)
  103368:	00 
  103369:	e8 02 fe ff ff       	call   103170 <sleep>
  10336e:	31 c0                	xor    %eax,%eax

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  103370:	81 fb d4 d0 10 00    	cmp    $0x10d0d4,%ebx
  103376:	73 d0                	jae    103348 <wait+0x28>
      if(p->parent != proc)
  103378:	8b 53 14             	mov    0x14(%ebx),%edx
  10337b:	65 3b 15 04 00 00 00 	cmp    %gs:0x4,%edx
  103382:	74 0c                	je     103390 <wait+0x70>

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  103384:	83 eb 80             	sub    $0xffffff80,%ebx
  103387:	eb b7                	jmp    103340 <wait+0x20>
  103389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->parent != proc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
  103390:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
  103394:	74 29                	je     1033bf <wait+0x9f>
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        release(&ptable.lock);
        return pid;
  103396:	b8 01 00 00 00       	mov    $0x1,%eax
  10339b:	90                   	nop
  10339c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1033a0:	eb e2                	jmp    103384 <wait+0x64>
  1033a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
      release(&ptable.lock);
  1033a8:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  1033af:	e8 1c 07 00 00       	call   103ad0 <release>
  1033b4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}
  1033b9:	83 c4 24             	add    $0x24,%esp
  1033bc:	5b                   	pop    %ebx
  1033bd:	5d                   	pop    %ebp
  1033be:	c3                   	ret    
      if(p->parent != proc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
  1033bf:	8b 43 10             	mov    0x10(%ebx),%eax
        kfree(p->kstack);
  1033c2:	8b 53 08             	mov    0x8(%ebx),%edx
  1033c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1033c8:	89 14 24             	mov    %edx,(%esp)
  1033cb:	e8 c0 ee ff ff       	call   102290 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
  1033d0:	8b 53 04             	mov    0x4(%ebx),%edx
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
  1033d3:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
  1033da:	89 14 24             	mov    %edx,(%esp)
  1033dd:	e8 fe 2b 00 00       	call   105fe0 <freevm>
        p->state = UNUSED;
  1033e2:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        p->pid = 0;
  1033e9:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
  1033f0:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
  1033f7:	c6 43 70 00          	movb   $0x0,0x70(%ebx)
        p->killed = 0;
  1033fb:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        release(&ptable.lock);
  103402:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  103409:	e8 c2 06 00 00       	call   103ad0 <release>
        return pid;
  10340e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103411:	eb a6                	jmp    1033b9 <wait+0x99>
  103413:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  103419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103420 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
  103420:	55                   	push   %ebp
  103421:	89 e5                	mov    %esp,%ebp
  103423:	56                   	push   %esi
  103424:	53                   	push   %ebx
  struct proc *p;
  int fd;

  if(proc == initproc)
    panic("init exiting");
  103425:	31 db                	xor    %ebx,%ebx
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
  103427:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  int fd;

  if(proc == initproc)
  10342a:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  103431:	3b 15 48 78 10 00    	cmp    0x107848,%edx
  103437:	0f 84 fd 00 00 00    	je     10353a <exit+0x11a>
  10343d:	8d 76 00             	lea    0x0(%esi),%esi
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd]){
  103440:	8d 73 08             	lea    0x8(%ebx),%esi
  103443:	8b 44 b2 08          	mov    0x8(%edx,%esi,4),%eax
  103447:	85 c0                	test   %eax,%eax
  103449:	74 1d                	je     103468 <exit+0x48>
      fileclose(proc->ofile[fd]);
  10344b:	89 04 24             	mov    %eax,(%esp)
  10344e:	e8 0d db ff ff       	call   100f60 <fileclose>
      proc->ofile[fd] = 0;
  103453:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103459:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
  103460:	00 
  103461:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
  103468:	83 c3 01             	add    $0x1,%ebx
  10346b:	83 fb 10             	cmp    $0x10,%ebx
  10346e:	75 d0                	jne    103440 <exit+0x20>
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  iput(proc->cwd);
  103470:	8b 42 68             	mov    0x68(%edx),%eax
  103473:	89 04 24             	mov    %eax,(%esp)
  103476:	e8 e5 e3 ff ff       	call   101860 <iput>
  proc->cwd = 0;
  10347b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103481:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

  acquire(&ptable.lock);
  103488:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  10348f:	e8 8c 06 00 00       	call   103b20 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
  103494:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx

// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
  10349b:	b8 d4 b0 10 00       	mov    $0x10b0d4,%eax
  proc->cwd = 0;

  acquire(&ptable.lock);

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
  1034a0:	8b 51 14             	mov    0x14(%ecx),%edx
  1034a3:	eb 0d                	jmp    1034b2 <exit+0x92>
  1034a5:	8d 76 00             	lea    0x0(%esi),%esi
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  1034a8:	83 e8 80             	sub    $0xffffff80,%eax
  1034ab:	3d d4 d0 10 00       	cmp    $0x10d0d4,%eax
  1034b0:	74 1c                	je     1034ce <exit+0xae>
    if(p->state == SLEEPING && p->chan == chan)
  1034b2:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  1034b6:	75 f0                	jne    1034a8 <exit+0x88>
  1034b8:	3b 50 20             	cmp    0x20(%eax),%edx
  1034bb:	75 eb                	jne    1034a8 <exit+0x88>
      p->state = RUNNABLE;
  1034bd:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  1034c4:	83 e8 80             	sub    $0xffffff80,%eax
  1034c7:	3d d4 d0 10 00       	cmp    $0x10d0d4,%eax
  1034cc:	75 e4                	jne    1034b2 <exit+0x92>
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
  1034ce:	8b 1d 48 78 10 00    	mov    0x107848,%ebx
  1034d4:	ba d4 b0 10 00       	mov    $0x10b0d4,%edx
  1034d9:	eb 10                	jmp    1034eb <exit+0xcb>
  1034db:	90                   	nop
  1034dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  1034e0:	83 ea 80             	sub    $0xffffff80,%edx
  1034e3:	81 fa d4 d0 10 00    	cmp    $0x10d0d4,%edx
  1034e9:	74 37                	je     103522 <exit+0x102>
    if(p->parent == proc){
  1034eb:	3b 4a 14             	cmp    0x14(%edx),%ecx
  1034ee:	75 f0                	jne    1034e0 <exit+0xc0>
      p->parent = initproc;
      if(p->state == ZOMBIE)
  1034f0:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
  1034f4:	89 5a 14             	mov    %ebx,0x14(%edx)
      if(p->state == ZOMBIE)
  1034f7:	75 e7                	jne    1034e0 <exit+0xc0>
  1034f9:	b8 d4 b0 10 00       	mov    $0x10b0d4,%eax
  1034fe:	eb 0a                	jmp    10350a <exit+0xea>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  103500:	83 e8 80             	sub    $0xffffff80,%eax
  103503:	3d d4 d0 10 00       	cmp    $0x10d0d4,%eax
  103508:	74 d6                	je     1034e0 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
  10350a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  10350e:	75 f0                	jne    103500 <exit+0xe0>
  103510:	3b 58 20             	cmp    0x20(%eax),%ebx
  103513:	75 eb                	jne    103500 <exit+0xe0>
      p->state = RUNNABLE;
  103515:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  10351c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  103520:	eb de                	jmp    103500 <exit+0xe0>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
  103522:	c7 41 0c 05 00 00 00 	movl   $0x5,0xc(%ecx)
  sched();
  103529:	e8 a2 fb ff ff       	call   1030d0 <sched>
  panic("zombie exit");
  10352e:	c7 04 24 05 6a 10 00 	movl   $0x106a05,(%esp)
  103535:	e8 76 d3 ff ff       	call   1008b0 <panic>
{
  struct proc *p;
  int fd;

  if(proc == initproc)
    panic("init exiting");
  10353a:	c7 04 24 f8 69 10 00 	movl   $0x1069f8,(%esp)
  103541:	e8 6a d3 ff ff       	call   1008b0 <panic>
  103546:	8d 76 00             	lea    0x0(%esi),%esi
  103549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103550 <allocproc>:
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and return it.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
  103550:	55                   	push   %ebp
  103551:	89 e5                	mov    %esp,%ebp
  103553:	53                   	push   %ebx
  103554:	83 ec 14             	sub    $0x14,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
  103557:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  10355e:	e8 bd 05 00 00       	call   103b20 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
  103563:	8b 1d e0 b0 10 00    	mov    0x10b0e0,%ebx
  103569:	85 db                	test   %ebx,%ebx
  10356b:	0f 84 a5 00 00 00    	je     103616 <allocproc+0xc6>

// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and return it.
// Otherwise return 0.
static struct proc*
allocproc(void)
  103571:	bb 54 b1 10 00       	mov    $0x10b154,%ebx
  103576:	eb 0b                	jmp    103583 <allocproc+0x33>
{
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  103578:	83 eb 80             	sub    $0xffffff80,%ebx
  10357b:	81 fb d4 d0 10 00    	cmp    $0x10d0d4,%ebx
  103581:	74 7d                	je     103600 <allocproc+0xb0>
    if(p->state == UNUSED)
  103583:	8b 4b 0c             	mov    0xc(%ebx),%ecx
  103586:	85 c9                	test   %ecx,%ecx
  103588:	75 ee                	jne    103578 <allocproc+0x28>
      goto found;
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  10358a:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
  103591:	a1 04 73 10 00       	mov    0x107304,%eax
  103596:	89 43 10             	mov    %eax,0x10(%ebx)
  103599:	83 c0 01             	add    $0x1,%eax
  10359c:	a3 04 73 10 00       	mov    %eax,0x107304
  release(&ptable.lock);
  1035a1:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  1035a8:	e8 23 05 00 00       	call   103ad0 <release>

  // Allocate kernel stack if possible.
  if((p->kstack = kalloc()) == 0){
  1035ad:	e8 9e ec ff ff       	call   102250 <kalloc>
  1035b2:	85 c0                	test   %eax,%eax
  1035b4:	89 43 08             	mov    %eax,0x8(%ebx)
  1035b7:	74 67                	je     103620 <allocproc+0xd0>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;
  
  // Leave room for trap frame.
  sp -= sizeof *p->tf;
  1035b9:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  p->tf = (struct trapframe*)sp;
  1035bf:	89 53 18             	mov    %edx,0x18(%ebx)
  
  // Set up new context to start executing at forkret,
  // which returns to trapret (see below).
  sp -= 4;
  *(uint*)sp = (uint)trapret;
  1035c2:	c7 80 b0 0f 00 00 50 	movl   $0x104d50,0xfb0(%eax)
  1035c9:	4d 10 00 

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  1035cc:	05 9c 0f 00 00       	add    $0xf9c,%eax
  1035d1:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
  1035d4:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
  1035db:	00 
  1035dc:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1035e3:	00 
  1035e4:	89 04 24             	mov    %eax,(%esp)
  1035e7:	e8 d4 05 00 00       	call   103bc0 <memset>
  p->context->eip = (uint)forkret;
  1035ec:	8b 43 1c             	mov    0x1c(%ebx),%eax
  1035ef:	c7 40 10 b0 30 10 00 	movl   $0x1030b0,0x10(%eax)
  return p;
}
  1035f6:	89 d8                	mov    %ebx,%eax
  1035f8:	83 c4 14             	add    $0x14,%esp
  1035fb:	5b                   	pop    %ebx
  1035fc:	5d                   	pop    %ebp
  1035fd:	c3                   	ret    
  1035fe:	66 90                	xchg   %ax,%ax

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;
  release(&ptable.lock);
  103600:	31 db                	xor    %ebx,%ebx
  103602:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  103609:	e8 c2 04 00 00       	call   103ad0 <release>
  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;
  return p;
}
  10360e:	89 d8                	mov    %ebx,%eax
  103610:	83 c4 14             	add    $0x14,%esp
  103613:	5b                   	pop    %ebx
  103614:	5d                   	pop    %ebp
  103615:	c3                   	ret    
  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;
  release(&ptable.lock);
  return 0;
  103616:	bb d4 b0 10 00       	mov    $0x10b0d4,%ebx
  10361b:	e9 6a ff ff ff       	jmp    10358a <allocproc+0x3a>
  p->pid = nextpid++;
  release(&ptable.lock);

  // Allocate kernel stack if possible.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
  103620:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  103627:	31 db                	xor    %ebx,%ebx
    return 0;
  103629:	eb cb                	jmp    1035f6 <allocproc+0xa6>
  10362b:	90                   	nop
  10362c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00103630 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
  103630:	55                   	push   %ebp
  103631:	89 e5                	mov    %esp,%ebp
  103633:	57                   	push   %edi
  103634:	56                   	push   %esi
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
  103635:	be ff ff ff ff       	mov    $0xffffffff,%esi
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
  10363a:	53                   	push   %ebx
  10363b:	83 ec 1c             	sub    $0x1c,%esp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
  10363e:	e8 0d ff ff ff       	call   103550 <allocproc>
  103643:	85 c0                	test   %eax,%eax
  103645:	89 c3                	mov    %eax,%ebx
  103647:	0f 84 be 00 00 00    	je     10370b <fork+0xdb>
    return -1;

  // Copy process state from p.
  if(!(np->pgdir = copyuvm(proc->pgdir, proc->sz))){
  10364d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103653:	8b 10                	mov    (%eax),%edx
  103655:	89 54 24 04          	mov    %edx,0x4(%esp)
  103659:	8b 40 04             	mov    0x4(%eax),%eax
  10365c:	89 04 24             	mov    %eax,(%esp)
  10365f:	e8 fc 29 00 00       	call   106060 <copyuvm>
  103664:	85 c0                	test   %eax,%eax
  103666:	89 43 04             	mov    %eax,0x4(%ebx)
  103669:	0f 84 a6 00 00 00    	je     103715 <fork+0xe5>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = proc->sz;
  10366f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  np->parent = proc;
  *np->tf = *proc->tf;
  103675:	b9 13 00 00 00       	mov    $0x13,%ecx
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = proc->sz;
  10367a:	8b 00                	mov    (%eax),%eax
  10367c:	89 03                	mov    %eax,(%ebx)
  np->parent = proc;
  10367e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103684:	89 43 14             	mov    %eax,0x14(%ebx)
  *np->tf = *proc->tf;
  103687:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  10368e:	8b 43 18             	mov    0x18(%ebx),%eax
  103691:	8b 72 18             	mov    0x18(%edx),%esi
  103694:	89 c7                	mov    %eax,%edi
  103696:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
  103698:	31 f6                	xor    %esi,%esi
  10369a:	8b 43 18             	mov    0x18(%ebx),%eax
  10369d:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  1036a4:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  1036ab:	90                   	nop
  1036ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(i = 0; i < NOFILE; i++)
    if(proc->ofile[i])
  1036b0:	8b 44 b2 28          	mov    0x28(%edx,%esi,4),%eax
  1036b4:	85 c0                	test   %eax,%eax
  1036b6:	74 13                	je     1036cb <fork+0x9b>
      np->ofile[i] = filedup(proc->ofile[i]);
  1036b8:	89 04 24             	mov    %eax,(%esp)
  1036bb:	e8 d0 d7 ff ff       	call   100e90 <filedup>
  1036c0:	89 44 b3 28          	mov    %eax,0x28(%ebx,%esi,4)
  1036c4:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
  1036cb:	83 c6 01             	add    $0x1,%esi
  1036ce:	83 fe 10             	cmp    $0x10,%esi
  1036d1:	75 dd                	jne    1036b0 <fork+0x80>
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
  1036d3:	8b 42 68             	mov    0x68(%edx),%eax
  1036d6:	89 04 24             	mov    %eax,(%esp)
  1036d9:	e8 b2 d9 ff ff       	call   101090 <idup>
 
  pid = np->pid;
  1036de:	8b 73 10             	mov    0x10(%ebx),%esi
  np->state = RUNNABLE;
  1036e1:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
  1036e8:	89 43 68             	mov    %eax,0x68(%ebx)
 
  pid = np->pid;
  np->state = RUNNABLE;
  safestrcpy(np->name, proc->name, sizeof(proc->name));
  1036eb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1036f1:	83 c3 70             	add    $0x70,%ebx
  1036f4:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
  1036fb:	00 
  1036fc:	89 1c 24             	mov    %ebx,(%esp)
  1036ff:	83 c0 70             	add    $0x70,%eax
  103702:	89 44 24 04          	mov    %eax,0x4(%esp)
  103706:	e8 55 06 00 00       	call   103d60 <safestrcpy>
  return pid;
}
  10370b:	83 c4 1c             	add    $0x1c,%esp
  10370e:	89 f0                	mov    %esi,%eax
  103710:	5b                   	pop    %ebx
  103711:	5e                   	pop    %esi
  103712:	5f                   	pop    %edi
  103713:	5d                   	pop    %ebp
  103714:	c3                   	ret    
  if((np = allocproc()) == 0)
    return -1;

  // Copy process state from p.
  if(!(np->pgdir = copyuvm(proc->pgdir, proc->sz))){
    kfree(np->kstack);
  103715:	8b 43 08             	mov    0x8(%ebx),%eax
  103718:	89 04 24             	mov    %eax,(%esp)
  10371b:	e8 70 eb ff ff       	call   102290 <kfree>
    np->kstack = 0;
  103720:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
  103727:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
  10372e:	eb db                	jmp    10370b <fork+0xdb>

00103730 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  103730:	55                   	push   %ebp
  103731:	89 e5                	mov    %esp,%ebp
  103733:	83 ec 18             	sub    $0x18,%esp
  uint sz = proc->sz;
  103736:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  10373d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  uint sz = proc->sz;
  103740:	8b 02                	mov    (%edx),%eax
  if(n > 0){
  103742:	83 f9 00             	cmp    $0x0,%ecx
  103745:	7f 19                	jg     103760 <growproc+0x30>
    if(!(sz = allocuvm(proc->pgdir, sz, sz + n)))
      return -1;
  } else if(n < 0){
  103747:	75 39                	jne    103782 <growproc+0x52>
    if(!(sz = deallocuvm(proc->pgdir, sz, sz + n)))
      return -1;
  }
  proc->sz = sz;
  103749:	89 02                	mov    %eax,(%edx)
  switchuvm(proc);
  10374b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103751:	89 04 24             	mov    %eax,(%esp)
  103754:	e8 57 2b 00 00       	call   1062b0 <switchuvm>
  103759:	31 c0                	xor    %eax,%eax
  return 0;
}
  10375b:	c9                   	leave  
  10375c:	c3                   	ret    
  10375d:	8d 76 00             	lea    0x0(%esi),%esi
int
growproc(int n)
{
  uint sz = proc->sz;
  if(n > 0){
    if(!(sz = allocuvm(proc->pgdir, sz, sz + n)))
  103760:	01 c1                	add    %eax,%ecx
  103762:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  103766:	89 44 24 04          	mov    %eax,0x4(%esp)
  10376a:	8b 42 04             	mov    0x4(%edx),%eax
  10376d:	89 04 24             	mov    %eax,(%esp)
  103770:	e8 ab 29 00 00       	call   106120 <allocuvm>
  103775:	85 c0                	test   %eax,%eax
  103777:	74 27                	je     1037a0 <growproc+0x70>
      return -1;
  } else if(n < 0){
    if(!(sz = deallocuvm(proc->pgdir, sz, sz + n)))
  103779:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  103780:	eb c7                	jmp    103749 <growproc+0x19>
  103782:	01 c1                	add    %eax,%ecx
  103784:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  103788:	89 44 24 04          	mov    %eax,0x4(%esp)
  10378c:	8b 42 04             	mov    0x4(%edx),%eax
  10378f:	89 04 24             	mov    %eax,(%esp)
  103792:	e8 a9 27 00 00       	call   105f40 <deallocuvm>
  103797:	85 c0                	test   %eax,%eax
  103799:	75 de                	jne    103779 <growproc+0x49>
  10379b:	90                   	nop
  10379c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
  }
  proc->sz = sz;
  switchuvm(proc);
  return 0;
  1037a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  1037a5:	c9                   	leave  
  1037a6:	c3                   	ret    
  1037a7:	89 f6                	mov    %esi,%esi
  1037a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001037b0 <userinit>:
}

// Set up first user process.
void
userinit(void)
{
  1037b0:	55                   	push   %ebp
  1037b1:	89 e5                	mov    %esp,%ebp
  1037b3:	53                   	push   %ebx
  1037b4:	83 ec 14             	sub    $0x14,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];
  
  p = allocproc();
  1037b7:	e8 94 fd ff ff       	call   103550 <allocproc>
  1037bc:	89 c3                	mov    %eax,%ebx
  initproc = p;
  1037be:	a3 48 78 10 00       	mov    %eax,0x107848
  if(!(p->pgdir = setupkvm()))
  1037c3:	e8 98 26 00 00       	call   105e60 <setupkvm>
  1037c8:	85 c0                	test   %eax,%eax
  1037ca:	89 43 04             	mov    %eax,0x4(%ebx)
  1037cd:	0f 84 b6 00 00 00    	je     103889 <userinit+0xd9>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  1037d3:	89 04 24             	mov    %eax,(%esp)
  1037d6:	c7 44 24 08 2c 00 00 	movl   $0x2c,0x8(%esp)
  1037dd:	00 
  1037de:	c7 44 24 04 08 77 10 	movl   $0x107708,0x4(%esp)
  1037e5:	00 
  1037e6:	e8 e5 25 00 00       	call   105dd0 <inituvm>
  p->sz = PGSIZE;
  1037eb:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
  1037f1:	c7 44 24 08 4c 00 00 	movl   $0x4c,0x8(%esp)
  1037f8:	00 
  1037f9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  103800:	00 
  103801:	8b 43 18             	mov    0x18(%ebx),%eax
  103804:	89 04 24             	mov    %eax,(%esp)
  103807:	e8 b4 03 00 00       	call   103bc0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  10380c:	8b 43 18             	mov    0x18(%ebx),%eax
  10380f:	66 c7 40 3c 23 00    	movw   $0x23,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  103815:	8b 43 18             	mov    0x18(%ebx),%eax
  103818:	66 c7 40 2c 2b 00    	movw   $0x2b,0x2c(%eax)
  p->tf->es = p->tf->ds;
  10381e:	8b 43 18             	mov    0x18(%ebx),%eax
  103821:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
  103825:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
  103829:	8b 43 18             	mov    0x18(%ebx),%eax
  10382c:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
  103830:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
  103834:	8b 43 18             	mov    0x18(%ebx),%eax
  103837:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
  10383e:	8b 43 18             	mov    0x18(%ebx),%eax
  103841:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
  103848:	8b 43 18             	mov    0x18(%ebx),%eax
  10384b:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
  103852:	8d 43 70             	lea    0x70(%ebx),%eax
  103855:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
  10385c:	00 
  10385d:	c7 44 24 04 2a 6a 10 	movl   $0x106a2a,0x4(%esp)
  103864:	00 
  103865:	89 04 24             	mov    %eax,(%esp)
  103868:	e8 f3 04 00 00       	call   103d60 <safestrcpy>
  p->cwd = namei("/");
  10386d:	c7 04 24 33 6a 10 00 	movl   $0x106a33,(%esp)
  103874:	e8 b7 e5 ff ff       	call   101e30 <namei>

  p->state = RUNNABLE;
  103879:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");
  103880:	89 43 68             	mov    %eax,0x68(%ebx)

  p->state = RUNNABLE;
}
  103883:	83 c4 14             	add    $0x14,%esp
  103886:	5b                   	pop    %ebx
  103887:	5d                   	pop    %ebp
  103888:	c3                   	ret    
  extern char _binary_initcode_start[], _binary_initcode_size[];
  
  p = allocproc();
  initproc = p;
  if(!(p->pgdir = setupkvm()))
    panic("userinit: out of memory?");
  103889:	c7 04 24 11 6a 10 00 	movl   $0x106a11,(%esp)
  103890:	e8 1b d0 ff ff       	call   1008b0 <panic>
  103895:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  103899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001038a0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
  1038a0:	55                   	push   %ebp
  1038a1:	89 e5                	mov    %esp,%ebp
  1038a3:	57                   	push   %edi
  1038a4:	56                   	push   %esi
  1038a5:	53                   	push   %ebx

// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
  1038a6:	bb d4 b0 10 00       	mov    $0x10b0d4,%ebx
{
  1038ab:	83 ec 4c             	sub    $0x4c,%esp
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
  1038ae:	8d 7d c0             	lea    -0x40(%ebp),%edi
  1038b1:	eb 4b                	jmp    1038fe <procdump+0x5e>
  1038b3:	90                   	nop
  1038b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
  1038b8:	8b 04 85 74 6a 10 00 	mov    0x106a74(,%eax,4),%eax
  1038bf:	85 c0                	test   %eax,%eax
  1038c1:	74 47                	je     10390a <procdump+0x6a>
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
  1038c3:	8b 53 10             	mov    0x10(%ebx),%edx
  1038c6:	8d 4b 70             	lea    0x70(%ebx),%ecx
  1038c9:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  1038cd:	89 44 24 08          	mov    %eax,0x8(%esp)
  1038d1:	c7 04 24 39 6a 10 00 	movl   $0x106a39,(%esp)
  1038d8:	89 54 24 04          	mov    %edx,0x4(%esp)
  1038dc:	e8 df cb ff ff       	call   1004c0 <cprintf>
    if(p->state == SLEEPING){
  1038e1:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
  1038e5:	74 31                	je     103918 <procdump+0x78>
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  1038e7:	c7 04 24 16 69 10 00 	movl   $0x106916,(%esp)
  1038ee:	e8 cd cb ff ff       	call   1004c0 <cprintf>
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  1038f3:	83 eb 80             	sub    $0xffffff80,%ebx
  1038f6:	81 fb d4 d0 10 00    	cmp    $0x10d0d4,%ebx
  1038fc:	74 5a                	je     103958 <procdump+0xb8>
    if(p->state == UNUSED)
  1038fe:	8b 43 0c             	mov    0xc(%ebx),%eax
  103901:	85 c0                	test   %eax,%eax
  103903:	74 ee                	je     1038f3 <procdump+0x53>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
  103905:	83 f8 05             	cmp    $0x5,%eax
  103908:	76 ae                	jbe    1038b8 <procdump+0x18>
  10390a:	b8 35 6a 10 00       	mov    $0x106a35,%eax
  10390f:	eb b2                	jmp    1038c3 <procdump+0x23>
  103911:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
  103918:	8b 43 1c             	mov    0x1c(%ebx),%eax
  10391b:	31 f6                	xor    %esi,%esi
  10391d:	89 7c 24 04          	mov    %edi,0x4(%esp)
  103921:	8b 40 0c             	mov    0xc(%eax),%eax
  103924:	83 c0 08             	add    $0x8,%eax
  103927:	89 04 24             	mov    %eax,(%esp)
  10392a:	e8 81 00 00 00       	call   1039b0 <getcallerpcs>
  10392f:	90                   	nop
      for(i=0; i<10 && pc[i] != 0; i++)
  103930:	8b 04 b7             	mov    (%edi,%esi,4),%eax
  103933:	85 c0                	test   %eax,%eax
  103935:	74 b0                	je     1038e7 <procdump+0x47>
  103937:	83 c6 01             	add    $0x1,%esi
        cprintf(" %p", pc[i]);
  10393a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10393e:	c7 04 24 ea 64 10 00 	movl   $0x1064ea,(%esp)
  103945:	e8 76 cb ff ff       	call   1004c0 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
  10394a:	83 fe 0a             	cmp    $0xa,%esi
  10394d:	75 e1                	jne    103930 <procdump+0x90>
  10394f:	eb 96                	jmp    1038e7 <procdump+0x47>
  103951:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
  103958:	83 c4 4c             	add    $0x4c,%esp
  10395b:	5b                   	pop    %ebx
  10395c:	5e                   	pop    %esi
  10395d:	5f                   	pop    %edi
  10395e:	5d                   	pop    %ebp
  10395f:	90                   	nop
  103960:	c3                   	ret    
  103961:	eb 0d                	jmp    103970 <pinit>
  103963:	90                   	nop
  103964:	90                   	nop
  103965:	90                   	nop
  103966:	90                   	nop
  103967:	90                   	nop
  103968:	90                   	nop
  103969:	90                   	nop
  10396a:	90                   	nop
  10396b:	90                   	nop
  10396c:	90                   	nop
  10396d:	90                   	nop
  10396e:	90                   	nop
  10396f:	90                   	nop

00103970 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
  103970:	55                   	push   %ebp
  103971:	89 e5                	mov    %esp,%ebp
  103973:	83 ec 18             	sub    $0x18,%esp
  initlock(&ptable.lock, "ptable");
  103976:	c7 44 24 04 42 6a 10 	movl   $0x106a42,0x4(%esp)
  10397d:	00 
  10397e:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  103985:	e8 06 00 00 00       	call   103990 <initlock>
}
  10398a:	c9                   	leave  
  10398b:	c3                   	ret    
  10398c:	90                   	nop
  10398d:	90                   	nop
  10398e:	90                   	nop
  10398f:	90                   	nop

00103990 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  103990:	55                   	push   %ebp
  103991:	89 e5                	mov    %esp,%ebp
  103993:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
  103996:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
  103999:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
  10399f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
  1039a2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
  1039a9:	5d                   	pop    %ebp
  1039aa:	c3                   	ret    
  1039ab:	90                   	nop
  1039ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001039b0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
  1039b0:	55                   	push   %ebp
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  1039b1:	31 c0                	xor    %eax,%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
  1039b3:	89 e5                	mov    %esp,%ebp
  1039b5:	53                   	push   %ebx
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  1039b6:	8b 55 08             	mov    0x8(%ebp),%edx
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
  1039b9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  1039bc:	83 ea 08             	sub    $0x8,%edx
  1039bf:	90                   	nop
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint *) 0x100000 || ebp == (uint*)0xffffffff)
  1039c0:	8d 8a 00 00 f0 ff    	lea    -0x100000(%edx),%ecx
  1039c6:	81 f9 fe ff ef ff    	cmp    $0xffeffffe,%ecx
  1039cc:	77 1a                	ja     1039e8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
  1039ce:	8b 4a 04             	mov    0x4(%edx),%ecx
  1039d1:	89 0c 83             	mov    %ecx,(%ebx,%eax,4)
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
  1039d4:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint *) 0x100000 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  1039d7:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
  1039d9:	83 f8 0a             	cmp    $0xa,%eax
  1039dc:	75 e2                	jne    1039c0 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
  1039de:	5b                   	pop    %ebx
  1039df:	5d                   	pop    %ebp
  1039e0:	c3                   	ret    
  1039e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint *) 0x100000 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
  1039e8:	83 f8 09             	cmp    $0x9,%eax
  1039eb:	7f f1                	jg     1039de <getcallerpcs+0x2e>
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint *) 0x100000 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  1039ed:	8d 14 83             	lea    (%ebx,%eax,4),%edx
  }
  for(; i < 10; i++)
  1039f0:	83 c0 01             	add    $0x1,%eax
    pcs[i] = 0;
  1039f3:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
    if(ebp == 0 || ebp < (uint *) 0x100000 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
  1039f9:	83 c2 04             	add    $0x4,%edx
  1039fc:	83 f8 0a             	cmp    $0xa,%eax
  1039ff:	75 ef                	jne    1039f0 <getcallerpcs+0x40>
    pcs[i] = 0;
}
  103a01:	5b                   	pop    %ebx
  103a02:	5d                   	pop    %ebp
  103a03:	c3                   	ret    
  103a04:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  103a0a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00103a10 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  103a10:	55                   	push   %ebp
  return lock->locked && lock->cpu == cpu;
  103a11:	31 c0                	xor    %eax,%eax
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  103a13:	89 e5                	mov    %esp,%ebp
  103a15:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == cpu;
  103a18:	8b 0a                	mov    (%edx),%ecx
  103a1a:	85 c9                	test   %ecx,%ecx
  103a1c:	74 10                	je     103a2e <holding+0x1e>
  103a1e:	8b 42 08             	mov    0x8(%edx),%eax
  103a21:	65 3b 05 00 00 00 00 	cmp    %gs:0x0,%eax
  103a28:	0f 94 c0             	sete   %al
  103a2b:	0f b6 c0             	movzbl %al,%eax
}
  103a2e:	5d                   	pop    %ebp
  103a2f:	c3                   	ret    

00103a30 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
  103a30:	55                   	push   %ebp
  103a31:	89 e5                	mov    %esp,%ebp
  103a33:	53                   	push   %ebx

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  103a34:	9c                   	pushf  
  103a35:	5b                   	pop    %ebx
}

static inline void
cli(void)
{
  asm volatile("cli");
  103a36:	fa                   	cli    
  int eflags;
  
  eflags = readeflags();
  cli();
  if(cpu->ncli++ == 0)
  103a37:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
  103a3e:	8b 82 ac 00 00 00    	mov    0xac(%edx),%eax
  103a44:	8d 48 01             	lea    0x1(%eax),%ecx
  103a47:	85 c0                	test   %eax,%eax
  103a49:	89 8a ac 00 00 00    	mov    %ecx,0xac(%edx)
  103a4f:	75 12                	jne    103a63 <pushcli+0x33>
    cpu->intena = eflags & FL_IF;
  103a51:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  103a57:	81 e3 00 02 00 00    	and    $0x200,%ebx
  103a5d:	89 98 b0 00 00 00    	mov    %ebx,0xb0(%eax)
}
  103a63:	5b                   	pop    %ebx
  103a64:	5d                   	pop    %ebp
  103a65:	c3                   	ret    
  103a66:	8d 76 00             	lea    0x0(%esi),%esi
  103a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103a70 <popcli>:

void
popcli(void)
{
  103a70:	55                   	push   %ebp
  103a71:	89 e5                	mov    %esp,%ebp
  103a73:	83 ec 18             	sub    $0x18,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  103a76:	9c                   	pushf  
  103a77:	58                   	pop    %eax
  if(readeflags()&FL_IF)
  103a78:	f6 c4 02             	test   $0x2,%ah
  103a7b:	75 43                	jne    103ac0 <popcli+0x50>
    panic("popcli - interruptible");
  if(--cpu->ncli < 0)
  103a7d:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
  103a84:	8b 82 ac 00 00 00    	mov    0xac(%edx),%eax
  103a8a:	83 e8 01             	sub    $0x1,%eax
  103a8d:	85 c0                	test   %eax,%eax
  103a8f:	89 82 ac 00 00 00    	mov    %eax,0xac(%edx)
  103a95:	78 1d                	js     103ab4 <popcli+0x44>
    panic("popcli");
  if(cpu->ncli == 0 && cpu->intena)
  103a97:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  103a9d:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
  103aa3:	85 d2                	test   %edx,%edx
  103aa5:	75 0b                	jne    103ab2 <popcli+0x42>
  103aa7:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
  103aad:	85 c0                	test   %eax,%eax
  103aaf:	74 01                	je     103ab2 <popcli+0x42>
}

static inline void
sti(void)
{
  asm volatile("sti");
  103ab1:	fb                   	sti    
    sti();
}
  103ab2:	c9                   	leave  
  103ab3:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--cpu->ncli < 0)
    panic("popcli");
  103ab4:	c7 04 24 a3 6a 10 00 	movl   $0x106aa3,(%esp)
  103abb:	e8 f0 cd ff ff       	call   1008b0 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  103ac0:	c7 04 24 8c 6a 10 00 	movl   $0x106a8c,(%esp)
  103ac7:	e8 e4 cd ff ff       	call   1008b0 <panic>
  103acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00103ad0 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
  103ad0:	55                   	push   %ebp
  103ad1:	89 e5                	mov    %esp,%ebp
  103ad3:	83 ec 18             	sub    $0x18,%esp
  103ad6:	8b 55 08             	mov    0x8(%ebp),%edx

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu;
  103ad9:	8b 0a                	mov    (%edx),%ecx
  103adb:	85 c9                	test   %ecx,%ecx
  103add:	74 0c                	je     103aeb <release+0x1b>
  103adf:	8b 42 08             	mov    0x8(%edx),%eax
  103ae2:	65 3b 05 00 00 00 00 	cmp    %gs:0x0,%eax
  103ae9:	74 0d                	je     103af8 <release+0x28>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
  103aeb:	c7 04 24 aa 6a 10 00 	movl   $0x106aaa,(%esp)
  103af2:	e8 b9 cd ff ff       	call   1008b0 <panic>
  103af7:	90                   	nop

  lk->pcs[0] = 0;
  103af8:	c7 42 0c 00 00 00 00 	movl   $0x0,0xc(%edx)
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
  103aff:	31 c0                	xor    %eax,%eax
  lk->cpu = 0;
  103b01:	c7 42 08 00 00 00 00 	movl   $0x0,0x8(%edx)
  103b08:	f0 87 02             	lock xchg %eax,(%edx)
  // The xchg being asm volatile ensures gcc emits it after
  // the above assignments (and after the critical section).
  xchg(&lk->locked, 0);

  popcli();
}
  103b0b:	c9                   	leave  
  // after a store. So lock->locked = 0 would work here.
  // The xchg being asm volatile ensures gcc emits it after
  // the above assignments (and after the critical section).
  xchg(&lk->locked, 0);

  popcli();
  103b0c:	e9 5f ff ff ff       	jmp    103a70 <popcli>
  103b11:	eb 0d                	jmp    103b20 <acquire>
  103b13:	90                   	nop
  103b14:	90                   	nop
  103b15:	90                   	nop
  103b16:	90                   	nop
  103b17:	90                   	nop
  103b18:	90                   	nop
  103b19:	90                   	nop
  103b1a:	90                   	nop
  103b1b:	90                   	nop
  103b1c:	90                   	nop
  103b1d:	90                   	nop
  103b1e:	90                   	nop
  103b1f:	90                   	nop

00103b20 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
  103b20:	55                   	push   %ebp
  103b21:	89 e5                	mov    %esp,%ebp
  103b23:	53                   	push   %ebx
  103b24:	83 ec 14             	sub    $0x14,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  103b27:	9c                   	pushf  
  103b28:	5b                   	pop    %ebx
}

static inline void
cli(void)
{
  asm volatile("cli");
  103b29:	fa                   	cli    
{
  int eflags;
  
  eflags = readeflags();
  cli();
  if(cpu->ncli++ == 0)
  103b2a:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
  103b31:	8b 82 ac 00 00 00    	mov    0xac(%edx),%eax
  103b37:	8d 48 01             	lea    0x1(%eax),%ecx
  103b3a:	85 c0                	test   %eax,%eax
  103b3c:	89 8a ac 00 00 00    	mov    %ecx,0xac(%edx)
  103b42:	75 12                	jne    103b56 <acquire+0x36>
    cpu->intena = eflags & FL_IF;
  103b44:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  103b4a:	81 e3 00 02 00 00    	and    $0x200,%ebx
  103b50:	89 98 b0 00 00 00    	mov    %ebx,0xb0(%eax)
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
  pushcli();
  if(holding(lk))
  103b56:	8b 55 08             	mov    0x8(%ebp),%edx

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu;
  103b59:	8b 1a                	mov    (%edx),%ebx
  103b5b:	85 db                	test   %ebx,%ebx
  103b5d:	74 0c                	je     103b6b <acquire+0x4b>
  103b5f:	8b 42 08             	mov    0x8(%edx),%eax
  103b62:	65 3b 05 00 00 00 00 	cmp    %gs:0x0,%eax
  103b69:	74 45                	je     103bb0 <acquire+0x90>
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
  103b6b:	b9 01 00 00 00       	mov    $0x1,%ecx
  103b70:	eb 09                	jmp    103b7b <acquire+0x5b>
  103b72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("acquire");

  // The xchg is atomic.
  // It also serializes, so that reads after acquire are not
  // reordered before it. 
  while(xchg(&lk->locked, 1) != 0)
  103b78:	8b 55 08             	mov    0x8(%ebp),%edx
  103b7b:	89 c8                	mov    %ecx,%eax
  103b7d:	f0 87 02             	lock xchg %eax,(%edx)
  103b80:	85 c0                	test   %eax,%eax
  103b82:	75 f4                	jne    103b78 <acquire+0x58>
    ;

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
  103b84:	8b 45 08             	mov    0x8(%ebp),%eax
  103b87:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
  103b8e:	89 50 08             	mov    %edx,0x8(%eax)
  getcallerpcs(&lk, lk->pcs);
  103b91:	8b 45 08             	mov    0x8(%ebp),%eax
  103b94:	83 c0 0c             	add    $0xc,%eax
  103b97:	89 44 24 04          	mov    %eax,0x4(%esp)
  103b9b:	8d 45 08             	lea    0x8(%ebp),%eax
  103b9e:	89 04 24             	mov    %eax,(%esp)
  103ba1:	e8 0a fe ff ff       	call   1039b0 <getcallerpcs>
}
  103ba6:	83 c4 14             	add    $0x14,%esp
  103ba9:	5b                   	pop    %ebx
  103baa:	5d                   	pop    %ebp
  103bab:	c3                   	ret    
  103bac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
void
acquire(struct spinlock *lk)
{
  pushcli();
  if(holding(lk))
    panic("acquire");
  103bb0:	c7 04 24 b2 6a 10 00 	movl   $0x106ab2,(%esp)
  103bb7:	e8 f4 cc ff ff       	call   1008b0 <panic>
  103bbc:	90                   	nop
  103bbd:	90                   	nop
  103bbe:	90                   	nop
  103bbf:	90                   	nop

00103bc0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
  103bc0:	55                   	push   %ebp
  103bc1:	89 e5                	mov    %esp,%ebp
  103bc3:	8b 55 08             	mov    0x8(%ebp),%edx
  103bc6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  103bc7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  103bca:	8b 45 0c             	mov    0xc(%ebp),%eax
  103bcd:	89 d7                	mov    %edx,%edi
  103bcf:	fc                   	cld    
  103bd0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  103bd2:	89 d0                	mov    %edx,%eax
  103bd4:	5f                   	pop    %edi
  103bd5:	5d                   	pop    %ebp
  103bd6:	c3                   	ret    
  103bd7:	89 f6                	mov    %esi,%esi
  103bd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103be0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
  103be0:	55                   	push   %ebp
  103be1:	89 e5                	mov    %esp,%ebp
  103be3:	57                   	push   %edi
  103be4:	56                   	push   %esi
  103be5:	53                   	push   %ebx
  103be6:	8b 55 10             	mov    0x10(%ebp),%edx
  103be9:	8b 75 08             	mov    0x8(%ebp),%esi
  103bec:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
  103bef:	85 d2                	test   %edx,%edx
  103bf1:	74 2d                	je     103c20 <memcmp+0x40>
    if(*s1 != *s2)
  103bf3:	0f b6 1e             	movzbl (%esi),%ebx
  103bf6:	0f b6 0f             	movzbl (%edi),%ecx
  103bf9:	38 cb                	cmp    %cl,%bl
  103bfb:	75 2b                	jne    103c28 <memcmp+0x48>
      return *s1 - *s2;
  103bfd:	83 ea 01             	sub    $0x1,%edx
  103c00:	31 c0                	xor    %eax,%eax
  103c02:	eb 18                	jmp    103c1c <memcmp+0x3c>
  103c04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
  103c08:	0f b6 5c 06 01       	movzbl 0x1(%esi,%eax,1),%ebx
  103c0d:	83 ea 01             	sub    $0x1,%edx
  103c10:	0f b6 4c 07 01       	movzbl 0x1(%edi,%eax,1),%ecx
  103c15:	83 c0 01             	add    $0x1,%eax
  103c18:	38 cb                	cmp    %cl,%bl
  103c1a:	75 0c                	jne    103c28 <memcmp+0x48>
{
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
  103c1c:	85 d2                	test   %edx,%edx
  103c1e:	75 e8                	jne    103c08 <memcmp+0x28>
  103c20:	31 c0                	xor    %eax,%eax
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
  103c22:	5b                   	pop    %ebx
  103c23:	5e                   	pop    %esi
  103c24:	5f                   	pop    %edi
  103c25:	5d                   	pop    %ebp
  103c26:	c3                   	ret    
  103c27:	90                   	nop
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
  103c28:	0f b6 c3             	movzbl %bl,%eax
  103c2b:	0f b6 c9             	movzbl %cl,%ecx
  103c2e:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
  103c30:	5b                   	pop    %ebx
  103c31:	5e                   	pop    %esi
  103c32:	5f                   	pop    %edi
  103c33:	5d                   	pop    %ebp
  103c34:	c3                   	ret    
  103c35:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  103c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103c40 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
  103c40:	55                   	push   %ebp
  103c41:	89 e5                	mov    %esp,%ebp
  103c43:	57                   	push   %edi
  103c44:	56                   	push   %esi
  103c45:	53                   	push   %ebx
  103c46:	8b 45 08             	mov    0x8(%ebp),%eax
  103c49:	8b 75 0c             	mov    0xc(%ebp),%esi
  103c4c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
  103c4f:	39 c6                	cmp    %eax,%esi
  103c51:	73 2d                	jae    103c80 <memmove+0x40>
  103c53:	8d 3c 1e             	lea    (%esi,%ebx,1),%edi
  103c56:	39 f8                	cmp    %edi,%eax
  103c58:	73 26                	jae    103c80 <memmove+0x40>
    s += n;
    d += n;
    while(n-- > 0)
  103c5a:	85 db                	test   %ebx,%ebx
  103c5c:	74 1d                	je     103c7b <memmove+0x3b>

  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
  103c5e:	8d 34 18             	lea    (%eax,%ebx,1),%esi
  103c61:	31 d2                	xor    %edx,%edx
  103c63:	90                   	nop
  103c64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
      *--d = *--s;
  103c68:	0f b6 4c 17 ff       	movzbl -0x1(%edi,%edx,1),%ecx
  103c6d:	88 4c 16 ff          	mov    %cl,-0x1(%esi,%edx,1)
  103c71:	83 ea 01             	sub    $0x1,%edx
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
  103c74:	8d 0c 1a             	lea    (%edx,%ebx,1),%ecx
  103c77:	85 c9                	test   %ecx,%ecx
  103c79:	75 ed                	jne    103c68 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
  103c7b:	5b                   	pop    %ebx
  103c7c:	5e                   	pop    %esi
  103c7d:	5f                   	pop    %edi
  103c7e:	5d                   	pop    %ebp
  103c7f:	c3                   	ret    
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
  103c80:	31 d2                	xor    %edx,%edx
      *--d = *--s;
  } else
    while(n-- > 0)
  103c82:	85 db                	test   %ebx,%ebx
  103c84:	74 f5                	je     103c7b <memmove+0x3b>
  103c86:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
  103c88:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
  103c8c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  103c8f:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
  103c92:	39 d3                	cmp    %edx,%ebx
  103c94:	75 f2                	jne    103c88 <memmove+0x48>
      *d++ = *s++;

  return dst;
}
  103c96:	5b                   	pop    %ebx
  103c97:	5e                   	pop    %esi
  103c98:	5f                   	pop    %edi
  103c99:	5d                   	pop    %ebp
  103c9a:	c3                   	ret    
  103c9b:	90                   	nop
  103c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00103ca0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  103ca0:	55                   	push   %ebp
  103ca1:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
  103ca3:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
  103ca4:	e9 97 ff ff ff       	jmp    103c40 <memmove>
  103ca9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00103cb0 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
  103cb0:	55                   	push   %ebp
  103cb1:	89 e5                	mov    %esp,%ebp
  103cb3:	57                   	push   %edi
  103cb4:	56                   	push   %esi
  103cb5:	53                   	push   %ebx
  103cb6:	8b 7d 10             	mov    0x10(%ebp),%edi
  103cb9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  103cbc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(n > 0 && *p && *p == *q)
  103cbf:	85 ff                	test   %edi,%edi
  103cc1:	74 3d                	je     103d00 <strncmp+0x50>
  103cc3:	0f b6 01             	movzbl (%ecx),%eax
  103cc6:	84 c0                	test   %al,%al
  103cc8:	75 18                	jne    103ce2 <strncmp+0x32>
  103cca:	eb 3c                	jmp    103d08 <strncmp+0x58>
  103ccc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  103cd0:	83 ef 01             	sub    $0x1,%edi
  103cd3:	74 2b                	je     103d00 <strncmp+0x50>
    n--, p++, q++;
  103cd5:	83 c1 01             	add    $0x1,%ecx
  103cd8:	83 c3 01             	add    $0x1,%ebx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
  103cdb:	0f b6 01             	movzbl (%ecx),%eax
  103cde:	84 c0                	test   %al,%al
  103ce0:	74 26                	je     103d08 <strncmp+0x58>
  103ce2:	0f b6 33             	movzbl (%ebx),%esi
  103ce5:	89 f2                	mov    %esi,%edx
  103ce7:	38 d0                	cmp    %dl,%al
  103ce9:	74 e5                	je     103cd0 <strncmp+0x20>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
  103ceb:	81 e6 ff 00 00 00    	and    $0xff,%esi
  103cf1:	0f b6 c0             	movzbl %al,%eax
  103cf4:	29 f0                	sub    %esi,%eax
}
  103cf6:	5b                   	pop    %ebx
  103cf7:	5e                   	pop    %esi
  103cf8:	5f                   	pop    %edi
  103cf9:	5d                   	pop    %ebp
  103cfa:	c3                   	ret    
  103cfb:	90                   	nop
  103cfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
  103d00:	31 c0                	xor    %eax,%eax
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
  103d02:	5b                   	pop    %ebx
  103d03:	5e                   	pop    %esi
  103d04:	5f                   	pop    %edi
  103d05:	5d                   	pop    %ebp
  103d06:	c3                   	ret    
  103d07:	90                   	nop
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
  103d08:	0f b6 33             	movzbl (%ebx),%esi
  103d0b:	eb de                	jmp    103ceb <strncmp+0x3b>
  103d0d:	8d 76 00             	lea    0x0(%esi),%esi

00103d10 <strncpy>:
  return (uchar)*p - (uchar)*q;
}

char*
strncpy(char *s, const char *t, int n)
{
  103d10:	55                   	push   %ebp
  103d11:	89 e5                	mov    %esp,%ebp
  103d13:	8b 45 08             	mov    0x8(%ebp),%eax
  103d16:	56                   	push   %esi
  103d17:	8b 4d 10             	mov    0x10(%ebp),%ecx
  103d1a:	53                   	push   %ebx
  103d1b:	8b 75 0c             	mov    0xc(%ebp),%esi
  103d1e:	89 c3                	mov    %eax,%ebx
  103d20:	eb 09                	jmp    103d2b <strncpy+0x1b>
  103d22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
  103d28:	83 c6 01             	add    $0x1,%esi
  103d2b:	83 e9 01             	sub    $0x1,%ecx
    return 0;
  return (uchar)*p - (uchar)*q;
}

char*
strncpy(char *s, const char *t, int n)
  103d2e:	8d 51 01             	lea    0x1(%ecx),%edx
{
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
  103d31:	85 d2                	test   %edx,%edx
  103d33:	7e 0c                	jle    103d41 <strncpy+0x31>
  103d35:	0f b6 16             	movzbl (%esi),%edx
  103d38:	88 13                	mov    %dl,(%ebx)
  103d3a:	83 c3 01             	add    $0x1,%ebx
  103d3d:	84 d2                	test   %dl,%dl
  103d3f:	75 e7                	jne    103d28 <strncpy+0x18>
    return 0;
  return (uchar)*p - (uchar)*q;
}

char*
strncpy(char *s, const char *t, int n)
  103d41:	31 d2                	xor    %edx,%edx
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
  103d43:	85 c9                	test   %ecx,%ecx
  103d45:	7e 0c                	jle    103d53 <strncpy+0x43>
  103d47:	90                   	nop
    *s++ = 0;
  103d48:	c6 04 13 00          	movb   $0x0,(%ebx,%edx,1)
  103d4c:	83 c2 01             	add    $0x1,%edx
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
  103d4f:	39 ca                	cmp    %ecx,%edx
  103d51:	75 f5                	jne    103d48 <strncpy+0x38>
    *s++ = 0;
  return os;
}
  103d53:	5b                   	pop    %ebx
  103d54:	5e                   	pop    %esi
  103d55:	5d                   	pop    %ebp
  103d56:	c3                   	ret    
  103d57:	89 f6                	mov    %esi,%esi
  103d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103d60 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
  103d60:	55                   	push   %ebp
  103d61:	89 e5                	mov    %esp,%ebp
  103d63:	8b 55 10             	mov    0x10(%ebp),%edx
  103d66:	56                   	push   %esi
  103d67:	8b 45 08             	mov    0x8(%ebp),%eax
  103d6a:	53                   	push   %ebx
  103d6b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *os;
  
  os = s;
  if(n <= 0)
  103d6e:	85 d2                	test   %edx,%edx
  103d70:	7e 1f                	jle    103d91 <safestrcpy+0x31>
  103d72:	89 c1                	mov    %eax,%ecx
  103d74:	eb 05                	jmp    103d7b <safestrcpy+0x1b>
  103d76:	66 90                	xchg   %ax,%ax
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
  103d78:	83 c6 01             	add    $0x1,%esi
  103d7b:	83 ea 01             	sub    $0x1,%edx
  103d7e:	85 d2                	test   %edx,%edx
  103d80:	7e 0c                	jle    103d8e <safestrcpy+0x2e>
  103d82:	0f b6 1e             	movzbl (%esi),%ebx
  103d85:	88 19                	mov    %bl,(%ecx)
  103d87:	83 c1 01             	add    $0x1,%ecx
  103d8a:	84 db                	test   %bl,%bl
  103d8c:	75 ea                	jne    103d78 <safestrcpy+0x18>
    ;
  *s = 0;
  103d8e:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
  103d91:	5b                   	pop    %ebx
  103d92:	5e                   	pop    %esi
  103d93:	5d                   	pop    %ebp
  103d94:	c3                   	ret    
  103d95:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  103d99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103da0 <strlen>:

int
strlen(const char *s)
{
  103da0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
  103da1:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
  103da3:	89 e5                	mov    %esp,%ebp
  103da5:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  103da8:	80 3a 00             	cmpb   $0x0,(%edx)
  103dab:	74 0c                	je     103db9 <strlen+0x19>
  103dad:	8d 76 00             	lea    0x0(%esi),%esi
  103db0:	83 c0 01             	add    $0x1,%eax
  103db3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  103db7:	75 f7                	jne    103db0 <strlen+0x10>
    ;
  return n;
}
  103db9:	5d                   	pop    %ebp
  103dba:	c3                   	ret    
  103dbb:	90                   	nop

00103dbc <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
  103dbc:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
  103dc0:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
  103dc4:	55                   	push   %ebp
  pushl %ebx
  103dc5:	53                   	push   %ebx
  pushl %esi
  103dc6:	56                   	push   %esi
  pushl %edi
  103dc7:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
  103dc8:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
  103dca:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
  103dcc:	5f                   	pop    %edi
  popl %esi
  103dcd:	5e                   	pop    %esi
  popl %ebx
  103dce:	5b                   	pop    %ebx
  popl %ebp
  103dcf:	5d                   	pop    %ebp
  ret
  103dd0:	c3                   	ret    
  103dd1:	90                   	nop
  103dd2:	90                   	nop
  103dd3:	90                   	nop
  103dd4:	90                   	nop
  103dd5:	90                   	nop
  103dd6:	90                   	nop
  103dd7:	90                   	nop
  103dd8:	90                   	nop
  103dd9:	90                   	nop
  103dda:	90                   	nop
  103ddb:	90                   	nop
  103ddc:	90                   	nop
  103ddd:	90                   	nop
  103dde:	90                   	nop
  103ddf:	90                   	nop

00103de0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  103de0:	55                   	push   %ebp
  103de1:	89 e5                	mov    %esp,%ebp
  if(addr >= p->sz || addr+4 > p->sz)
  103de3:	8b 55 08             	mov    0x8(%ebp),%edx
// to a saved program counter, and then the first argument.

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  103de6:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(addr >= p->sz || addr+4 > p->sz)
  103de9:	8b 12                	mov    (%edx),%edx
  103deb:	39 c2                	cmp    %eax,%edx
  103ded:	77 09                	ja     103df8 <fetchint+0x18>
    return -1;
  *ip = *(int*)(addr);
  return 0;
  103def:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  103df4:	5d                   	pop    %ebp
  103df5:	c3                   	ret    
  103df6:	66 90                	xchg   %ax,%ax

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  if(addr >= p->sz || addr+4 > p->sz)
  103df8:	8d 48 04             	lea    0x4(%eax),%ecx
  103dfb:	39 ca                	cmp    %ecx,%edx
  103dfd:	72 f0                	jb     103def <fetchint+0xf>
    return -1;
  *ip = *(int*)(addr);
  103dff:	8b 10                	mov    (%eax),%edx
  103e01:	8b 45 10             	mov    0x10(%ebp),%eax
  103e04:	89 10                	mov    %edx,(%eax)
  103e06:	31 c0                	xor    %eax,%eax
  return 0;
}
  103e08:	5d                   	pop    %ebp
  103e09:	c3                   	ret    
  103e0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00103e10 <fetchstr>:
// Fetch the nul-terminated string at addr from process p.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(struct proc *p, uint addr, char **pp)
{
  103e10:	55                   	push   %ebp
  103e11:	89 e5                	mov    %esp,%ebp
  103e13:	8b 45 08             	mov    0x8(%ebp),%eax
  103e16:	8b 55 0c             	mov    0xc(%ebp),%edx
  103e19:	53                   	push   %ebx
  char *s, *ep;

  if(addr >= p->sz)
  103e1a:	39 10                	cmp    %edx,(%eax)
  103e1c:	77 0a                	ja     103e28 <fetchstr+0x18>
    return -1;
  *pp = (char *) addr;
  ep = (char *) p->sz;
  for(s = *pp; s < ep; s++)
  103e1e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    if(*s == 0)
      return s - *pp;
  return -1;
}
  103e23:	5b                   	pop    %ebx
  103e24:	5d                   	pop    %ebp
  103e25:	c3                   	ret    
  103e26:	66 90                	xchg   %ax,%ax
{
  char *s, *ep;

  if(addr >= p->sz)
    return -1;
  *pp = (char *) addr;
  103e28:	8b 4d 10             	mov    0x10(%ebp),%ecx
  103e2b:	89 11                	mov    %edx,(%ecx)
  ep = (char *) p->sz;
  103e2d:	8b 18                	mov    (%eax),%ebx
  for(s = *pp; s < ep; s++)
  103e2f:	39 da                	cmp    %ebx,%edx
  103e31:	73 eb                	jae    103e1e <fetchstr+0xe>
    if(*s == 0)
  103e33:	31 c0                	xor    %eax,%eax
  103e35:	89 d1                	mov    %edx,%ecx
  103e37:	80 3a 00             	cmpb   $0x0,(%edx)
  103e3a:	74 e7                	je     103e23 <fetchstr+0x13>
  103e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  if(addr >= p->sz)
    return -1;
  *pp = (char *) addr;
  ep = (char *) p->sz;
  for(s = *pp; s < ep; s++)
  103e40:	83 c1 01             	add    $0x1,%ecx
  103e43:	39 cb                	cmp    %ecx,%ebx
  103e45:	76 d7                	jbe    103e1e <fetchstr+0xe>
    if(*s == 0)
  103e47:	80 39 00             	cmpb   $0x0,(%ecx)
  103e4a:	75 f4                	jne    103e40 <fetchstr+0x30>
  103e4c:	89 c8                	mov    %ecx,%eax
  103e4e:	29 d0                	sub    %edx,%eax
  103e50:	eb d1                	jmp    103e23 <fetchstr+0x13>
  103e52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103e60 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  int x = fetchint(proc, proc->tf->esp + 4 + 4*n, ip);
  103e60:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
}

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  103e66:	55                   	push   %ebp
  103e67:	89 e5                	mov    %esp,%ebp
  int x = fetchint(proc, proc->tf->esp + 4 + 4*n, ip);
  103e69:	8b 4d 08             	mov    0x8(%ebp),%ecx
  103e6c:	8b 50 18             	mov    0x18(%eax),%edx

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  if(addr >= p->sz || addr+4 > p->sz)
  103e6f:	8b 00                	mov    (%eax),%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  int x = fetchint(proc, proc->tf->esp + 4 + 4*n, ip);
  103e71:	8b 52 44             	mov    0x44(%edx),%edx
  103e74:	8d 54 8a 04          	lea    0x4(%edx,%ecx,4),%edx

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  if(addr >= p->sz || addr+4 > p->sz)
  103e78:	39 c2                	cmp    %eax,%edx
  103e7a:	72 0c                	jb     103e88 <argint+0x28>
    return -1;
  *ip = *(int*)(addr);
  103e7c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
int
argint(int n, int *ip)
{
  int x = fetchint(proc, proc->tf->esp + 4 + 4*n, ip);
  return x;
}
  103e81:	5d                   	pop    %ebp
  103e82:	c3                   	ret    
  103e83:	90                   	nop
  103e84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  if(addr >= p->sz || addr+4 > p->sz)
  103e88:	8d 4a 04             	lea    0x4(%edx),%ecx
  103e8b:	39 c8                	cmp    %ecx,%eax
  103e8d:	72 ed                	jb     103e7c <argint+0x1c>
    return -1;
  *ip = *(int*)(addr);
  103e8f:	8b 45 0c             	mov    0xc(%ebp),%eax
  103e92:	8b 12                	mov    (%edx),%edx
  103e94:	89 10                	mov    %edx,(%eax)
  103e96:	31 c0                	xor    %eax,%eax
int
argint(int n, int *ip)
{
  int x = fetchint(proc, proc->tf->esp + 4 + 4*n, ip);
  return x;
}
  103e98:	5d                   	pop    %ebp
  103e99:	c3                   	ret    
  103e9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00103ea0 <argptr>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  int x = fetchint(proc, proc->tf->esp + 4 + 4*n, ip);
  103ea0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
  103ea6:	55                   	push   %ebp
  103ea7:	89 e5                	mov    %esp,%ebp

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  int x = fetchint(proc, proc->tf->esp + 4 + 4*n, ip);
  103ea9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  103eac:	8b 50 18             	mov    0x18(%eax),%edx

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  if(addr >= p->sz || addr+4 > p->sz)
  103eaf:	8b 00                	mov    (%eax),%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  int x = fetchint(proc, proc->tf->esp + 4 + 4*n, ip);
  103eb1:	8b 52 44             	mov    0x44(%edx),%edx
  103eb4:	8d 54 8a 04          	lea    0x4(%edx,%ecx,4),%edx

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  if(addr >= p->sz || addr+4 > p->sz)
  103eb8:	39 c2                	cmp    %eax,%edx
  103eba:	73 07                	jae    103ec3 <argptr+0x23>
  103ebc:	8d 4a 04             	lea    0x4(%edx),%ecx
  103ebf:	39 c8                	cmp    %ecx,%eax
  103ec1:	73 0d                	jae    103ed0 <argptr+0x30>
  if(argint(n, &i) < 0)
    return -1;
  if((uint)i >= proc->sz || (uint)i+size >= proc->sz)
    return -1;
  *pp = (char *) i;
  return 0;
  103ec3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  103ec8:	5d                   	pop    %ebp
  103ec9:	c3                   	ret    
  103eca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
int
fetchint(struct proc *p, uint addr, int *ip)
{
  if(addr >= p->sz || addr+4 > p->sz)
    return -1;
  *ip = *(int*)(addr);
  103ed0:	8b 12                	mov    (%edx),%edx
{
  int i;
  
  if(argint(n, &i) < 0)
    return -1;
  if((uint)i >= proc->sz || (uint)i+size >= proc->sz)
  103ed2:	39 c2                	cmp    %eax,%edx
  103ed4:	73 ed                	jae    103ec3 <argptr+0x23>
  103ed6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  103ed9:	01 d1                	add    %edx,%ecx
  103edb:	39 c1                	cmp    %eax,%ecx
  103edd:	73 e4                	jae    103ec3 <argptr+0x23>
    return -1;
  *pp = (char *) i;
  103edf:	8b 45 0c             	mov    0xc(%ebp),%eax
  103ee2:	89 10                	mov    %edx,(%eax)
  103ee4:	31 c0                	xor    %eax,%eax
  return 0;
}
  103ee6:	5d                   	pop    %ebp
  103ee7:	c3                   	ret    
  103ee8:	90                   	nop
  103ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00103ef0 <argstr>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  int x = fetchint(proc, proc->tf->esp + 4 + 4*n, ip);
  103ef0:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
  103ef7:	55                   	push   %ebp
  103ef8:	89 e5                	mov    %esp,%ebp
  103efa:	53                   	push   %ebx

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  int x = fetchint(proc, proc->tf->esp + 4 + 4*n, ip);
  103efb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  103efe:	8b 42 18             	mov    0x18(%edx),%eax
  103f01:	8b 40 44             	mov    0x44(%eax),%eax
  103f04:	8d 44 88 04          	lea    0x4(%eax,%ecx,4),%eax

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  if(addr >= p->sz || addr+4 > p->sz)
  103f08:	8b 0a                	mov    (%edx),%ecx
  103f0a:	39 c8                	cmp    %ecx,%eax
  103f0c:	73 07                	jae    103f15 <argstr+0x25>
  103f0e:	8d 58 04             	lea    0x4(%eax),%ebx
  103f11:	39 d9                	cmp    %ebx,%ecx
  103f13:	73 0b                	jae    103f20 <argstr+0x30>

  if(addr >= p->sz)
    return -1;
  *pp = (char *) addr;
  ep = (char *) p->sz;
  for(s = *pp; s < ep; s++)
  103f15:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(proc, addr, pp);
}
  103f1a:	5b                   	pop    %ebx
  103f1b:	5d                   	pop    %ebp
  103f1c:	c3                   	ret    
  103f1d:	8d 76 00             	lea    0x0(%esi),%esi
int
fetchint(struct proc *p, uint addr, int *ip)
{
  if(addr >= p->sz || addr+4 > p->sz)
    return -1;
  *ip = *(int*)(addr);
  103f20:	8b 18                	mov    (%eax),%ebx
int
fetchstr(struct proc *p, uint addr, char **pp)
{
  char *s, *ep;

  if(addr >= p->sz)
  103f22:	39 cb                	cmp    %ecx,%ebx
  103f24:	73 ef                	jae    103f15 <argstr+0x25>
    return -1;
  *pp = (char *) addr;
  103f26:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  103f29:	89 d8                	mov    %ebx,%eax
  103f2b:	89 19                	mov    %ebx,(%ecx)
  ep = (char *) p->sz;
  103f2d:	8b 12                	mov    (%edx),%edx
  for(s = *pp; s < ep; s++)
  103f2f:	39 d3                	cmp    %edx,%ebx
  103f31:	73 e2                	jae    103f15 <argstr+0x25>
    if(*s == 0)
  103f33:	80 3b 00             	cmpb   $0x0,(%ebx)
  103f36:	75 12                	jne    103f4a <argstr+0x5a>
  103f38:	eb 1e                	jmp    103f58 <argstr+0x68>
  103f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  103f40:	80 38 00             	cmpb   $0x0,(%eax)
  103f43:	90                   	nop
  103f44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  103f48:	74 0e                	je     103f58 <argstr+0x68>

  if(addr >= p->sz)
    return -1;
  *pp = (char *) addr;
  ep = (char *) p->sz;
  for(s = *pp; s < ep; s++)
  103f4a:	83 c0 01             	add    $0x1,%eax
  103f4d:	39 c2                	cmp    %eax,%edx
  103f4f:	90                   	nop
  103f50:	77 ee                	ja     103f40 <argstr+0x50>
  103f52:	eb c1                	jmp    103f15 <argstr+0x25>
  103f54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(*s == 0)
      return s - *pp;
  103f58:	29 d8                	sub    %ebx,%eax
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(proc, addr, pp);
}
  103f5a:	5b                   	pop    %ebx
  103f5b:	5d                   	pop    %ebp
  103f5c:	c3                   	ret    
  103f5d:	8d 76 00             	lea    0x0(%esi),%esi

00103f60 <syscall>:
[SYS_fetchrecords] sys_fetchrecords,
};

void
syscall(void)
{
  103f60:	55                   	push   %ebp
  103f61:	89 e5                	mov    %esp,%ebp
  103f63:	53                   	push   %ebx
  103f64:	83 ec 14             	sub    $0x14,%esp
  int num;
  num = proc->tf->eax;
  103f67:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  103f6e:	8b 5a 18             	mov    0x18(%edx),%ebx
  103f71:	8b 43 1c             	mov    0x1c(%ebx),%eax
  if(num >= 0 && num < NELEM(syscalls) && syscalls[num])
  103f74:	83 f8 18             	cmp    $0x18,%eax
  103f77:	77 17                	ja     103f90 <syscall+0x30>
  103f79:	8b 0c 85 e0 6a 10 00 	mov    0x106ae0(,%eax,4),%ecx
  103f80:	85 c9                	test   %ecx,%ecx
  103f82:	74 0c                	je     103f90 <syscall+0x30>
    proc->tf->eax = syscalls[num]();
  103f84:	ff d1                	call   *%ecx
  103f86:	89 43 1c             	mov    %eax,0x1c(%ebx)
  else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
  }
}
  103f89:	83 c4 14             	add    $0x14,%esp
  103f8c:	5b                   	pop    %ebx
  103f8d:	5d                   	pop    %ebp
  103f8e:	c3                   	ret    
  103f8f:	90                   	nop
  int num;
  num = proc->tf->eax;
  if(num >= 0 && num < NELEM(syscalls) && syscalls[num])
    proc->tf->eax = syscalls[num]();
  else {
    cprintf("%d %s: unknown sys call %d\n",
  103f90:	8b 4a 10             	mov    0x10(%edx),%ecx
  103f93:	83 c2 70             	add    $0x70,%edx
  103f96:	89 44 24 0c          	mov    %eax,0xc(%esp)
  103f9a:	89 54 24 08          	mov    %edx,0x8(%esp)
  103f9e:	c7 04 24 ba 6a 10 00 	movl   $0x106aba,(%esp)
  103fa5:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  103fa9:	e8 12 c5 ff ff       	call   1004c0 <cprintf>
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
  103fae:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103fb4:	8b 40 18             	mov    0x18(%eax),%eax
  103fb7:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
  103fbe:	83 c4 14             	add    $0x14,%esp
  103fc1:	5b                   	pop    %ebx
  103fc2:	5d                   	pop    %ebp
  103fc3:	c3                   	ret    
  103fc4:	90                   	nop
  103fc5:	90                   	nop
  103fc6:	90                   	nop
  103fc7:	90                   	nop
  103fc8:	90                   	nop
  103fc9:	90                   	nop
  103fca:	90                   	nop
  103fcb:	90                   	nop
  103fcc:	90                   	nop
  103fcd:	90                   	nop
  103fce:	90                   	nop
  103fcf:	90                   	nop

00103fd0 <sys_pipe>:
  return exec(path, argv);
}

int
sys_pipe(void)
{
  103fd0:	55                   	push   %ebp
  103fd1:	89 e5                	mov    %esp,%ebp
  103fd3:	83 ec 28             	sub    $0x28,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
  103fd6:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return exec(path, argv);
}

int
sys_pipe(void)
{
  103fd9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  103fdc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
  103fdf:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
  103fe6:	00 
  103fe7:	89 44 24 04          	mov    %eax,0x4(%esp)
  103feb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  103ff2:	e8 a9 fe ff ff       	call   103ea0 <argptr>
  103ff7:	85 c0                	test   %eax,%eax
  103ff9:	79 15                	jns    104010 <sys_pipe+0x40>
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      proc->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  103ffb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
  104000:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  104003:	8b 75 fc             	mov    -0x4(%ebp),%esi
  104006:	89 ec                	mov    %ebp,%esp
  104008:	5d                   	pop    %ebp
  104009:	c3                   	ret    
  10400a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
  104010:	8d 45 ec             	lea    -0x14(%ebp),%eax
  104013:	89 44 24 04          	mov    %eax,0x4(%esp)
  104017:	8d 45 f0             	lea    -0x10(%ebp),%eax
  10401a:	89 04 24             	mov    %eax,(%esp)
  10401d:	e8 be ee ff ff       	call   102ee0 <pipealloc>
  104022:	85 c0                	test   %eax,%eax
  104024:	78 d5                	js     103ffb <sys_pipe+0x2b>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
  104026:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  104029:	31 c0                	xor    %eax,%eax
  10402b:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  104032:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
  104038:	8b 5c 82 28          	mov    0x28(%edx,%eax,4),%ebx
  10403c:	85 db                	test   %ebx,%ebx
  10403e:	74 28                	je     104068 <sys_pipe+0x98>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
  104040:	83 c0 01             	add    $0x1,%eax
  104043:	83 f8 10             	cmp    $0x10,%eax
  104046:	75 f0                	jne    104038 <sys_pipe+0x68>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      proc->ofile[fd0] = 0;
    fileclose(rf);
  104048:	89 0c 24             	mov    %ecx,(%esp)
  10404b:	e8 10 cf ff ff       	call   100f60 <fileclose>
    fileclose(wf);
  104050:	8b 45 ec             	mov    -0x14(%ebp),%eax
  104053:	89 04 24             	mov    %eax,(%esp)
  104056:	e8 05 cf ff ff       	call   100f60 <fileclose>
  10405b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    return -1;
  104060:	eb 9e                	jmp    104000 <sys_pipe+0x30>
  104062:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
  104068:	8d 58 08             	lea    0x8(%eax),%ebx
  10406b:	89 4c 9a 08          	mov    %ecx,0x8(%edx,%ebx,4)
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
  10406f:	8b 75 ec             	mov    -0x14(%ebp),%esi
  104072:	31 d2                	xor    %edx,%edx
  104074:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
  10407b:	90                   	nop
  10407c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
  104080:	83 7c 91 28 00       	cmpl   $0x0,0x28(%ecx,%edx,4)
  104085:	74 19                	je     1040a0 <sys_pipe+0xd0>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
  104087:	83 c2 01             	add    $0x1,%edx
  10408a:	83 fa 10             	cmp    $0x10,%edx
  10408d:	75 f1                	jne    104080 <sys_pipe+0xb0>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      proc->ofile[fd0] = 0;
  10408f:	c7 44 99 08 00 00 00 	movl   $0x0,0x8(%ecx,%ebx,4)
  104096:	00 
  104097:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  10409a:	eb ac                	jmp    104048 <sys_pipe+0x78>
  10409c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
  1040a0:	89 74 91 28          	mov    %esi,0x28(%ecx,%edx,4)
      proc->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  1040a4:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  1040a7:	89 01                	mov    %eax,(%ecx)
  fd[1] = fd1;
  1040a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1040ac:	89 50 04             	mov    %edx,0x4(%eax)
  1040af:	31 c0                	xor    %eax,%eax
  return 0;
  1040b1:	e9 4a ff ff ff       	jmp    104000 <sys_pipe+0x30>
  1040b6:	8d 76 00             	lea    0x0(%esi),%esi
  1040b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001040c0 <sys_exec>:
  return 0;
}

int
sys_exec(void)
{
  1040c0:	55                   	push   %ebp
  1040c1:	89 e5                	mov    %esp,%ebp
  1040c3:	81 ec 88 00 00 00    	sub    $0x88,%esp
  char *path, *argv[20];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0) {
  1040c9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  return 0;
}

int
sys_exec(void)
{
  1040cc:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  1040cf:	89 75 f8             	mov    %esi,-0x8(%ebp)
  1040d2:	89 7d fc             	mov    %edi,-0x4(%ebp)
  char *path, *argv[20];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0) {
  1040d5:	89 44 24 04          	mov    %eax,0x4(%esp)
  1040d9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1040e0:	e8 0b fe ff ff       	call   103ef0 <argstr>
  1040e5:	85 c0                	test   %eax,%eax
  1040e7:	79 17                	jns    104100 <sys_exec+0x40>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
    if(i >= NELEM(argv))
  1040e9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(proc, uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
  1040ee:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1040f1:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1040f4:	8b 7d fc             	mov    -0x4(%ebp),%edi
  1040f7:	89 ec                	mov    %ebp,%esp
  1040f9:	5d                   	pop    %ebp
  1040fa:	c3                   	ret    
  1040fb:	90                   	nop
  1040fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  char *path, *argv[20];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0) {
  104100:	8d 45 e0             	lea    -0x20(%ebp),%eax
  104103:	89 44 24 04          	mov    %eax,0x4(%esp)
  104107:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  10410e:	e8 4d fd ff ff       	call   103e60 <argint>
  104113:	85 c0                	test   %eax,%eax
  104115:	78 d2                	js     1040e9 <sys_exec+0x29>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  104117:	8d 7d 8c             	lea    -0x74(%ebp),%edi
  10411a:	31 f6                	xor    %esi,%esi
  10411c:	c7 44 24 08 50 00 00 	movl   $0x50,0x8(%esp)
  104123:	00 
  104124:	31 db                	xor    %ebx,%ebx
  104126:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10412d:	00 
  10412e:	89 3c 24             	mov    %edi,(%esp)
  104131:	e8 8a fa ff ff       	call   103bc0 <memset>
  104136:	eb 27                	jmp    10415f <sys_exec+0x9f>
      return -1;
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(proc, uarg, &argv[i]) < 0)
  104138:	89 44 24 04          	mov    %eax,0x4(%esp)
  10413c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104142:	8d 14 b7             	lea    (%edi,%esi,4),%edx
  104145:	89 54 24 08          	mov    %edx,0x8(%esp)
  104149:	89 04 24             	mov    %eax,(%esp)
  10414c:	e8 bf fc ff ff       	call   103e10 <fetchstr>
  104151:	85 c0                	test   %eax,%eax
  104153:	78 94                	js     1040e9 <sys_exec+0x29>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0) {
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
  104155:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
  104158:	83 fb 14             	cmp    $0x14,%ebx

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0) {
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
  10415b:	89 de                	mov    %ebx,%esi
    if(i >= NELEM(argv))
  10415d:	74 8a                	je     1040e9 <sys_exec+0x29>
      return -1;
    if(fetchint(proc, uargv+4*i, (int*)&uarg) < 0)
  10415f:	8d 45 dc             	lea    -0x24(%ebp),%eax
  104162:	89 44 24 08          	mov    %eax,0x8(%esp)
  104166:	8d 04 9d 00 00 00 00 	lea    0x0(,%ebx,4),%eax
  10416d:	03 45 e0             	add    -0x20(%ebp),%eax
  104170:	89 44 24 04          	mov    %eax,0x4(%esp)
  104174:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  10417a:	89 04 24             	mov    %eax,(%esp)
  10417d:	e8 5e fc ff ff       	call   103de0 <fetchint>
  104182:	85 c0                	test   %eax,%eax
  104184:	0f 88 5f ff ff ff    	js     1040e9 <sys_exec+0x29>
      return -1;
    if(uarg == 0){
  10418a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10418d:	85 c0                	test   %eax,%eax
  10418f:	75 a7                	jne    104138 <sys_exec+0x78>
      break;
    }
    if(fetchstr(proc, uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
  104191:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(proc, uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
  104194:	c7 44 9d 8c 00 00 00 	movl   $0x0,-0x74(%ebp,%ebx,4)
  10419b:	00 
      break;
    }
    if(fetchstr(proc, uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
  10419c:	89 7c 24 04          	mov    %edi,0x4(%esp)
  1041a0:	89 04 24             	mov    %eax,(%esp)
  1041a3:	e8 88 c7 ff ff       	call   100930 <exec>
  1041a8:	e9 41 ff ff ff       	jmp    1040ee <sys_exec+0x2e>
  1041ad:	8d 76 00             	lea    0x0(%esi),%esi

001041b0 <sys_chdir>:
  return 0;
}

int
sys_chdir(void)
{
  1041b0:	55                   	push   %ebp
  1041b1:	89 e5                	mov    %esp,%ebp
  1041b3:	53                   	push   %ebx
  1041b4:	83 ec 24             	sub    $0x24,%esp
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
  1041b7:	8d 45 f4             	lea    -0xc(%ebp),%eax
  1041ba:	89 44 24 04          	mov    %eax,0x4(%esp)
  1041be:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1041c5:	e8 26 fd ff ff       	call   103ef0 <argstr>
  1041ca:	85 c0                	test   %eax,%eax
  1041cc:	79 12                	jns    1041e0 <sys_chdir+0x30>
    return -1;
  }
  iunlock(ip);
  iput(proc->cwd);
  proc->cwd = ip;
  return 0;
  1041ce:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  1041d3:	83 c4 24             	add    $0x24,%esp
  1041d6:	5b                   	pop    %ebx
  1041d7:	5d                   	pop    %ebp
  1041d8:	c3                   	ret    
  1041d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
sys_chdir(void)
{
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
  1041e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1041e3:	89 04 24             	mov    %eax,(%esp)
  1041e6:	e8 45 dc ff ff       	call   101e30 <namei>
  1041eb:	85 c0                	test   %eax,%eax
  1041ed:	89 c3                	mov    %eax,%ebx
  1041ef:	74 dd                	je     1041ce <sys_chdir+0x1e>
    return -1;
  ilock(ip);
  1041f1:	89 04 24             	mov    %eax,(%esp)
  1041f4:	e8 97 d9 ff ff       	call   101b90 <ilock>
  if(ip->type != T_DIR){
  1041f9:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
  1041fe:	75 26                	jne    104226 <sys_chdir+0x76>
    iunlockput(ip);
    return -1;
  }
  iunlock(ip);
  104200:	89 1c 24             	mov    %ebx,(%esp)
  104203:	e8 48 d5 ff ff       	call   101750 <iunlock>
  iput(proc->cwd);
  104208:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  10420e:	8b 40 68             	mov    0x68(%eax),%eax
  104211:	89 04 24             	mov    %eax,(%esp)
  104214:	e8 47 d6 ff ff       	call   101860 <iput>
  proc->cwd = ip;
  104219:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  10421f:	89 58 68             	mov    %ebx,0x68(%eax)
  104222:	31 c0                	xor    %eax,%eax
  return 0;
  104224:	eb ad                	jmp    1041d3 <sys_chdir+0x23>

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
    return -1;
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
  104226:	89 1c 24             	mov    %ebx,(%esp)
  104229:	e8 72 d8 ff ff       	call   101aa0 <iunlockput>
  10422e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    return -1;
  104233:	eb 9e                	jmp    1041d3 <sys_chdir+0x23>
  104235:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104240 <create>:
  return 0;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
  104240:	55                   	push   %ebp
  104241:	89 e5                	mov    %esp,%ebp
  104243:	83 ec 58             	sub    $0x58,%esp
  104246:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  104249:	8b 4d 08             	mov    0x8(%ebp),%ecx
  10424c:	89 75 f8             	mov    %esi,-0x8(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
  10424f:	8d 75 d6             	lea    -0x2a(%ebp),%esi
  return 0;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
  104252:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
  104255:	31 db                	xor    %ebx,%ebx
  return 0;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
  104257:	89 7d fc             	mov    %edi,-0x4(%ebp)
  10425a:	89 d7                	mov    %edx,%edi
  10425c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
  10425f:	89 74 24 04          	mov    %esi,0x4(%esp)
  104263:	89 04 24             	mov    %eax,(%esp)
  104266:	e8 a5 db ff ff       	call   101e10 <nameiparent>
  10426b:	85 c0                	test   %eax,%eax
  10426d:	74 47                	je     1042b6 <create+0x76>
    return 0;
  ilock(dp);
  10426f:	89 04 24             	mov    %eax,(%esp)
  104272:	89 45 bc             	mov    %eax,-0x44(%ebp)
  104275:	e8 16 d9 ff ff       	call   101b90 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
  10427a:	8b 55 bc             	mov    -0x44(%ebp),%edx
  10427d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  104280:	89 44 24 08          	mov    %eax,0x8(%esp)
  104284:	89 74 24 04          	mov    %esi,0x4(%esp)
  104288:	89 14 24             	mov    %edx,(%esp)
  10428b:	e8 c0 d3 ff ff       	call   101650 <dirlookup>
  104290:	8b 55 bc             	mov    -0x44(%ebp),%edx
  104293:	85 c0                	test   %eax,%eax
  104295:	89 c3                	mov    %eax,%ebx
  104297:	74 3f                	je     1042d8 <create+0x98>
    iunlockput(dp);
  104299:	89 14 24             	mov    %edx,(%esp)
  10429c:	e8 ff d7 ff ff       	call   101aa0 <iunlockput>
    ilock(ip);
  1042a1:	89 1c 24             	mov    %ebx,(%esp)
  1042a4:	e8 e7 d8 ff ff       	call   101b90 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
  1042a9:	66 83 ff 02          	cmp    $0x2,%di
  1042ad:	75 19                	jne    1042c8 <create+0x88>
  1042af:	66 83 7b 10 02       	cmpw   $0x2,0x10(%ebx)
  1042b4:	75 12                	jne    1042c8 <create+0x88>
  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);
  return ip;
}
  1042b6:	89 d8                	mov    %ebx,%eax
  1042b8:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1042bb:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1042be:	8b 7d fc             	mov    -0x4(%ebp),%edi
  1042c1:	89 ec                	mov    %ebp,%esp
  1042c3:	5d                   	pop    %ebp
  1042c4:	c3                   	ret    
  1042c5:	8d 76 00             	lea    0x0(%esi),%esi
  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
  1042c8:	89 1c 24             	mov    %ebx,(%esp)
  1042cb:	31 db                	xor    %ebx,%ebx
  1042cd:	e8 ce d7 ff ff       	call   101aa0 <iunlockput>
    return 0;
  1042d2:	eb e2                	jmp    1042b6 <create+0x76>
  1042d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  if((ip = ialloc(dp->dev, type)) == 0)
  1042d8:	0f bf c7             	movswl %di,%eax
  1042db:	89 44 24 04          	mov    %eax,0x4(%esp)
  1042df:	8b 02                	mov    (%edx),%eax
  1042e1:	89 55 bc             	mov    %edx,-0x44(%ebp)
  1042e4:	89 04 24             	mov    %eax,(%esp)
  1042e7:	e8 d4 d7 ff ff       	call   101ac0 <ialloc>
  1042ec:	8b 55 bc             	mov    -0x44(%ebp),%edx
  1042ef:	85 c0                	test   %eax,%eax
  1042f1:	89 c3                	mov    %eax,%ebx
  1042f3:	0f 84 b7 00 00 00    	je     1043b0 <create+0x170>
    panic("create: ialloc");

  ilock(ip);
  1042f9:	89 55 bc             	mov    %edx,-0x44(%ebp)
  1042fc:	89 04 24             	mov    %eax,(%esp)
  1042ff:	e8 8c d8 ff ff       	call   101b90 <ilock>
  ip->major = major;
  104304:	0f b7 45 c4          	movzwl -0x3c(%ebp),%eax
  104308:	66 89 43 12          	mov    %ax,0x12(%ebx)
  ip->minor = minor;
  10430c:	0f b7 4d c0          	movzwl -0x40(%ebp),%ecx
  ip->nlink = 1;
  104310:	66 c7 43 16 01 00    	movw   $0x1,0x16(%ebx)
  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");

  ilock(ip);
  ip->major = major;
  ip->minor = minor;
  104316:	66 89 4b 14          	mov    %cx,0x14(%ebx)
  ip->nlink = 1;
  iupdate(ip);
  10431a:	89 1c 24             	mov    %ebx,(%esp)
  10431d:	e8 2e d1 ff ff       	call   101450 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
  104322:	66 83 ff 01          	cmp    $0x1,%di
  104326:	8b 55 bc             	mov    -0x44(%ebp),%edx
  104329:	74 2d                	je     104358 <create+0x118>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
  10432b:	8b 43 04             	mov    0x4(%ebx),%eax
  10432e:	89 14 24             	mov    %edx,(%esp)
  104331:	89 55 bc             	mov    %edx,-0x44(%ebp)
  104334:	89 74 24 04          	mov    %esi,0x4(%esp)
  104338:	89 44 24 08          	mov    %eax,0x8(%esp)
  10433c:	e8 6f d6 ff ff       	call   1019b0 <dirlink>
  104341:	8b 55 bc             	mov    -0x44(%ebp),%edx
  104344:	85 c0                	test   %eax,%eax
  104346:	78 74                	js     1043bc <create+0x17c>
    panic("create: dirlink");

  iunlockput(dp);
  104348:	89 14 24             	mov    %edx,(%esp)
  10434b:	e8 50 d7 ff ff       	call   101aa0 <iunlockput>
  return ip;
  104350:	e9 61 ff ff ff       	jmp    1042b6 <create+0x76>
  104355:	8d 76 00             	lea    0x0(%esi),%esi
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
  104358:	66 83 42 16 01       	addw   $0x1,0x16(%edx)
    iupdate(dp);
  10435d:	89 14 24             	mov    %edx,(%esp)
  104360:	89 55 bc             	mov    %edx,-0x44(%ebp)
  104363:	e8 e8 d0 ff ff       	call   101450 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
  104368:	8b 43 04             	mov    0x4(%ebx),%eax
  10436b:	c7 44 24 04 54 6b 10 	movl   $0x106b54,0x4(%esp)
  104372:	00 
  104373:	89 1c 24             	mov    %ebx,(%esp)
  104376:	89 44 24 08          	mov    %eax,0x8(%esp)
  10437a:	e8 31 d6 ff ff       	call   1019b0 <dirlink>
  10437f:	8b 55 bc             	mov    -0x44(%ebp),%edx
  104382:	85 c0                	test   %eax,%eax
  104384:	78 1e                	js     1043a4 <create+0x164>
  104386:	8b 42 04             	mov    0x4(%edx),%eax
  104389:	c7 44 24 04 53 6b 10 	movl   $0x106b53,0x4(%esp)
  104390:	00 
  104391:	89 1c 24             	mov    %ebx,(%esp)
  104394:	89 44 24 08          	mov    %eax,0x8(%esp)
  104398:	e8 13 d6 ff ff       	call   1019b0 <dirlink>
  10439d:	8b 55 bc             	mov    -0x44(%ebp),%edx
  1043a0:	85 c0                	test   %eax,%eax
  1043a2:	79 87                	jns    10432b <create+0xeb>
      panic("create dots");
  1043a4:	c7 04 24 56 6b 10 00 	movl   $0x106b56,(%esp)
  1043ab:	e8 00 c5 ff ff       	call   1008b0 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
  1043b0:	c7 04 24 44 6b 10 00 	movl   $0x106b44,(%esp)
  1043b7:	e8 f4 c4 ff ff       	call   1008b0 <panic>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
  1043bc:	c7 04 24 62 6b 10 00 	movl   $0x106b62,(%esp)
  1043c3:	e8 e8 c4 ff ff       	call   1008b0 <panic>
  1043c8:	90                   	nop
  1043c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001043d0 <sys_mknod>:
  return 0;
}

int
sys_mknod(void)
{
  1043d0:	55                   	push   %ebp
  1043d1:	89 e5                	mov    %esp,%ebp
  1043d3:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  if((len=argstr(0, &path)) < 0 ||
  1043d6:	8d 45 f4             	lea    -0xc(%ebp),%eax
  1043d9:	89 44 24 04          	mov    %eax,0x4(%esp)
  1043dd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1043e4:	e8 07 fb ff ff       	call   103ef0 <argstr>
  1043e9:	85 c0                	test   %eax,%eax
  1043eb:	79 0b                	jns    1043f8 <sys_mknod+0x28>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0)
    return -1;
  iunlockput(ip);
  return 0;
  1043ed:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  1043f2:	c9                   	leave  
  1043f3:	c3                   	ret    
  1043f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *path;
  int len;
  int major, minor;
  
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
  1043f8:	8d 45 f0             	lea    -0x10(%ebp),%eax
  1043fb:	89 44 24 04          	mov    %eax,0x4(%esp)
  1043ff:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  104406:	e8 55 fa ff ff       	call   103e60 <argint>
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  if((len=argstr(0, &path)) < 0 ||
  10440b:	85 c0                	test   %eax,%eax
  10440d:	78 de                	js     1043ed <sys_mknod+0x1d>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
  10440f:	8d 45 ec             	lea    -0x14(%ebp),%eax
  104412:	89 44 24 04          	mov    %eax,0x4(%esp)
  104416:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  10441d:	e8 3e fa ff ff       	call   103e60 <argint>
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  if((len=argstr(0, &path)) < 0 ||
  104422:	85 c0                	test   %eax,%eax
  104424:	78 c7                	js     1043ed <sys_mknod+0x1d>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0)
  104426:	0f bf 45 ec          	movswl -0x14(%ebp),%eax
  10442a:	ba 03 00 00 00       	mov    $0x3,%edx
  10442f:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
  104433:	89 04 24             	mov    %eax,(%esp)
  104436:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104439:	e8 02 fe ff ff       	call   104240 <create>
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  if((len=argstr(0, &path)) < 0 ||
  10443e:	85 c0                	test   %eax,%eax
  104440:	74 ab                	je     1043ed <sys_mknod+0x1d>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0)
    return -1;
  iunlockput(ip);
  104442:	89 04 24             	mov    %eax,(%esp)
  104445:	e8 56 d6 ff ff       	call   101aa0 <iunlockput>
  10444a:	31 c0                	xor    %eax,%eax
  return 0;
}
  10444c:	c9                   	leave  
  10444d:	c3                   	ret    
  10444e:	66 90                	xchg   %ax,%ax

00104450 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
  104450:	55                   	push   %ebp
  104451:	89 e5                	mov    %esp,%ebp
  104453:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0)
  104456:	8d 45 f4             	lea    -0xc(%ebp),%eax
  104459:	89 44 24 04          	mov    %eax,0x4(%esp)
  10445d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104464:	e8 87 fa ff ff       	call   103ef0 <argstr>
  104469:	85 c0                	test   %eax,%eax
  10446b:	79 0b                	jns    104478 <sys_mkdir+0x28>
    return -1;
  iunlockput(ip);
  return 0;
  10446d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104472:	c9                   	leave  
  104473:	c3                   	ret    
  104474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
sys_mkdir(void)
{
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0)
  104478:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10447f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104482:	31 c9                	xor    %ecx,%ecx
  104484:	ba 01 00 00 00       	mov    $0x1,%edx
  104489:	e8 b2 fd ff ff       	call   104240 <create>
  10448e:	85 c0                	test   %eax,%eax
  104490:	74 db                	je     10446d <sys_mkdir+0x1d>
    return -1;
  iunlockput(ip);
  104492:	89 04 24             	mov    %eax,(%esp)
  104495:	e8 06 d6 ff ff       	call   101aa0 <iunlockput>
  10449a:	31 c0                	xor    %eax,%eax
  return 0;
}
  10449c:	c9                   	leave  
  10449d:	c3                   	ret    
  10449e:	66 90                	xchg   %ax,%ax

001044a0 <sys_link>:
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
  1044a0:	55                   	push   %ebp
  1044a1:	89 e5                	mov    %esp,%ebp
  1044a3:	83 ec 48             	sub    $0x48,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
  1044a6:	8d 45 e0             	lea    -0x20(%ebp),%eax
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
  1044a9:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  1044ac:	89 75 f8             	mov    %esi,-0x8(%ebp)
  1044af:	89 7d fc             	mov    %edi,-0x4(%ebp)
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
  1044b2:	89 44 24 04          	mov    %eax,0x4(%esp)
  1044b6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1044bd:	e8 2e fa ff ff       	call   103ef0 <argstr>
  1044c2:	85 c0                	test   %eax,%eax
  1044c4:	79 12                	jns    1044d8 <sys_link+0x38>
bad:
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  return -1;
  1044c6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  1044cb:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1044ce:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1044d1:	8b 7d fc             	mov    -0x4(%ebp),%edi
  1044d4:	89 ec                	mov    %ebp,%esp
  1044d6:	5d                   	pop    %ebp
  1044d7:	c3                   	ret    
sys_link(void)
{
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
  1044d8:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  1044db:	89 44 24 04          	mov    %eax,0x4(%esp)
  1044df:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1044e6:	e8 05 fa ff ff       	call   103ef0 <argstr>
  1044eb:	85 c0                	test   %eax,%eax
  1044ed:	78 d7                	js     1044c6 <sys_link+0x26>
    return -1;
  if((ip = namei(old)) == 0)
  1044ef:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1044f2:	89 04 24             	mov    %eax,(%esp)
  1044f5:	e8 36 d9 ff ff       	call   101e30 <namei>
  1044fa:	85 c0                	test   %eax,%eax
  1044fc:	89 c3                	mov    %eax,%ebx
  1044fe:	74 c6                	je     1044c6 <sys_link+0x26>
    return -1;
  ilock(ip);
  104500:	89 04 24             	mov    %eax,(%esp)
  104503:	e8 88 d6 ff ff       	call   101b90 <ilock>
  if(ip->type == T_DIR){
  104508:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
  10450d:	0f 84 86 00 00 00    	je     104599 <sys_link+0xf9>
    iunlockput(ip);
    return -1;
  }
  ip->nlink++;
  104513:	66 83 43 16 01       	addw   $0x1,0x16(%ebx)
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
  104518:	8d 7d d2             	lea    -0x2e(%ebp),%edi
  if(ip->type == T_DIR){
    iunlockput(ip);
    return -1;
  }
  ip->nlink++;
  iupdate(ip);
  10451b:	89 1c 24             	mov    %ebx,(%esp)
  10451e:	e8 2d cf ff ff       	call   101450 <iupdate>
  iunlock(ip);
  104523:	89 1c 24             	mov    %ebx,(%esp)
  104526:	e8 25 d2 ff ff       	call   101750 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
  10452b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10452e:	89 7c 24 04          	mov    %edi,0x4(%esp)
  104532:	89 04 24             	mov    %eax,(%esp)
  104535:	e8 d6 d8 ff ff       	call   101e10 <nameiparent>
  10453a:	85 c0                	test   %eax,%eax
  10453c:	89 c6                	mov    %eax,%esi
  10453e:	74 44                	je     104584 <sys_link+0xe4>
    goto bad;
  ilock(dp);
  104540:	89 04 24             	mov    %eax,(%esp)
  104543:	e8 48 d6 ff ff       	call   101b90 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
  104548:	8b 06                	mov    (%esi),%eax
  10454a:	3b 03                	cmp    (%ebx),%eax
  10454c:	75 2e                	jne    10457c <sys_link+0xdc>
  10454e:	8b 43 04             	mov    0x4(%ebx),%eax
  104551:	89 7c 24 04          	mov    %edi,0x4(%esp)
  104555:	89 34 24             	mov    %esi,(%esp)
  104558:	89 44 24 08          	mov    %eax,0x8(%esp)
  10455c:	e8 4f d4 ff ff       	call   1019b0 <dirlink>
  104561:	85 c0                	test   %eax,%eax
  104563:	78 17                	js     10457c <sys_link+0xdc>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
  104565:	89 34 24             	mov    %esi,(%esp)
  104568:	e8 33 d5 ff ff       	call   101aa0 <iunlockput>
  iput(ip);
  10456d:	89 1c 24             	mov    %ebx,(%esp)
  104570:	e8 eb d2 ff ff       	call   101860 <iput>
  104575:	31 c0                	xor    %eax,%eax
  return 0;
  104577:	e9 4f ff ff ff       	jmp    1044cb <sys_link+0x2b>

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
  10457c:	89 34 24             	mov    %esi,(%esp)
  10457f:	e8 1c d5 ff ff       	call   101aa0 <iunlockput>
  iunlockput(dp);
  iput(ip);
  return 0;

bad:
  ilock(ip);
  104584:	89 1c 24             	mov    %ebx,(%esp)
  104587:	e8 04 d6 ff ff       	call   101b90 <ilock>
  ip->nlink--;
  10458c:	66 83 6b 16 01       	subw   $0x1,0x16(%ebx)
  iupdate(ip);
  104591:	89 1c 24             	mov    %ebx,(%esp)
  104594:	e8 b7 ce ff ff       	call   101450 <iupdate>
  iunlockput(ip);
  104599:	89 1c 24             	mov    %ebx,(%esp)
  10459c:	e8 ff d4 ff ff       	call   101aa0 <iunlockput>
  1045a1:	83 c8 ff             	or     $0xffffffff,%eax
  return -1;
  1045a4:	e9 22 ff ff ff       	jmp    1044cb <sys_link+0x2b>
  1045a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001045b0 <sys_open>:
  return ip;
}

int
sys_open(void)
{
  1045b0:	55                   	push   %ebp
  1045b1:	89 e5                	mov    %esp,%ebp
  1045b3:	83 ec 38             	sub    $0x38,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
  1045b6:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return ip;
}

int
sys_open(void)
{
  1045b9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  1045bc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
  1045bf:	89 44 24 04          	mov    %eax,0x4(%esp)
  1045c3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1045ca:	e8 21 f9 ff ff       	call   103ef0 <argstr>
  1045cf:	85 c0                	test   %eax,%eax
  1045d1:	79 15                	jns    1045e8 <sys_open+0x38>

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    return -1;
  1045d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
  1045d8:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  1045db:	8b 75 fc             	mov    -0x4(%ebp),%esi
  1045de:	89 ec                	mov    %ebp,%esp
  1045e0:	5d                   	pop    %ebp
  1045e1:	c3                   	ret    
  1045e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
  1045e8:	8d 45 f0             	lea    -0x10(%ebp),%eax
  1045eb:	89 44 24 04          	mov    %eax,0x4(%esp)
  1045ef:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1045f6:	e8 65 f8 ff ff       	call   103e60 <argint>
  1045fb:	85 c0                	test   %eax,%eax
  1045fd:	78 d4                	js     1045d3 <sys_open+0x23>
    return -1;
  if(omode & O_CREATE){
  1045ff:	f6 45 f1 02          	testb  $0x2,-0xf(%ebp)
  104603:	74 63                	je     104668 <sys_open+0xb8>
    if((ip = create(path, T_FILE, 0, 0)) == 0)
  104605:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104608:	31 c9                	xor    %ecx,%ecx
  10460a:	ba 02 00 00 00       	mov    $0x2,%edx
  10460f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104616:	e8 25 fc ff ff       	call   104240 <create>
  10461b:	85 c0                	test   %eax,%eax
  10461d:	89 c3                	mov    %eax,%ebx
  10461f:	74 b2                	je     1045d3 <sys_open+0x23>
      iunlockput(ip);
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
  104621:	e8 ba c8 ff ff       	call   100ee0 <filealloc>
  104626:	85 c0                	test   %eax,%eax
  104628:	89 c6                	mov    %eax,%esi
  10462a:	74 24                	je     104650 <sys_open+0xa0>
  10462c:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  104633:	31 c0                	xor    %eax,%eax
  104635:	8d 76 00             	lea    0x0(%esi),%esi
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
  104638:	8b 4c 82 28          	mov    0x28(%edx,%eax,4),%ecx
  10463c:	85 c9                	test   %ecx,%ecx
  10463e:	74 58                	je     104698 <sys_open+0xe8>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
  104640:	83 c0 01             	add    $0x1,%eax
  104643:	83 f8 10             	cmp    $0x10,%eax
  104646:	75 f0                	jne    104638 <sys_open+0x88>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
  104648:	89 34 24             	mov    %esi,(%esp)
  10464b:	e8 10 c9 ff ff       	call   100f60 <fileclose>
    iunlockput(ip);
  104650:	89 1c 24             	mov    %ebx,(%esp)
  104653:	e8 48 d4 ff ff       	call   101aa0 <iunlockput>
  104658:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    return -1;
  10465d:	e9 76 ff ff ff       	jmp    1045d8 <sys_open+0x28>
  104662:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
  if(omode & O_CREATE){
    if((ip = create(path, T_FILE, 0, 0)) == 0)
      return -1;
  } else {
    if((ip = namei(path)) == 0)
  104668:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10466b:	89 04 24             	mov    %eax,(%esp)
  10466e:	e8 bd d7 ff ff       	call   101e30 <namei>
  104673:	85 c0                	test   %eax,%eax
  104675:	89 c3                	mov    %eax,%ebx
  104677:	0f 84 56 ff ff ff    	je     1045d3 <sys_open+0x23>
      return -1;
    ilock(ip);
  10467d:	89 04 24             	mov    %eax,(%esp)
  104680:	e8 0b d5 ff ff       	call   101b90 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
  104685:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
  10468a:	75 95                	jne    104621 <sys_open+0x71>
  10468c:	8b 75 f0             	mov    -0x10(%ebp),%esi
  10468f:	85 f6                	test   %esi,%esi
  104691:	74 8e                	je     104621 <sys_open+0x71>
  104693:	eb bb                	jmp    104650 <sys_open+0xa0>
  104695:	8d 76 00             	lea    0x0(%esi),%esi
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
  104698:	89 74 82 28          	mov    %esi,0x28(%edx,%eax,4)
    if(f)
      fileclose(f);
    iunlockput(ip);
    return -1;
  }
  iunlock(ip);
  10469c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  10469f:	89 1c 24             	mov    %ebx,(%esp)
  1046a2:	e8 a9 d0 ff ff       	call   101750 <iunlock>

  f->type = FD_INODE;
  1046a7:	c7 06 02 00 00 00    	movl   $0x2,(%esi)
  f->ip = ip;
  1046ad:	89 5e 10             	mov    %ebx,0x10(%esi)
  f->off = 0;
  1046b0:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%esi)
  f->readable = !(omode & O_WRONLY);
  1046b7:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1046ba:	83 f2 01             	xor    $0x1,%edx
  1046bd:	83 e2 01             	and    $0x1,%edx
  1046c0:	88 56 08             	mov    %dl,0x8(%esi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  1046c3:	f6 45 f0 03          	testb  $0x3,-0x10(%ebp)
  1046c7:	0f 95 46 09          	setne  0x9(%esi)
  return fd;
  1046cb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1046ce:	e9 05 ff ff ff       	jmp    1045d8 <sys_open+0x28>
  1046d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1046d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001046e0 <sys_unlink>:
  return 1;
}

int
sys_unlink(void)
{
  1046e0:	55                   	push   %ebp
  1046e1:	89 e5                	mov    %esp,%ebp
  1046e3:	83 ec 78             	sub    $0x78,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
  1046e6:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  return 1;
}

int
sys_unlink(void)
{
  1046e9:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  1046ec:	89 75 f8             	mov    %esi,-0x8(%ebp)
  1046ef:	89 7d fc             	mov    %edi,-0x4(%ebp)
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
  1046f2:	89 44 24 04          	mov    %eax,0x4(%esp)
  1046f6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1046fd:	e8 ee f7 ff ff       	call   103ef0 <argstr>
  104702:	85 c0                	test   %eax,%eax
  104704:	79 12                	jns    104718 <sys_unlink+0x38>
  iunlockput(dp);

  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  return 0;
  104706:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  10470b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  10470e:	8b 75 f8             	mov    -0x8(%ebp),%esi
  104711:	8b 7d fc             	mov    -0x4(%ebp),%edi
  104714:	89 ec                	mov    %ebp,%esp
  104716:	5d                   	pop    %ebp
  104717:	c3                   	ret    
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;
  if((dp = nameiparent(path, name)) == 0)
  104718:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10471b:	8d 5d d2             	lea    -0x2e(%ebp),%ebx
  10471e:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  104722:	89 04 24             	mov    %eax,(%esp)
  104725:	e8 e6 d6 ff ff       	call   101e10 <nameiparent>
  10472a:	85 c0                	test   %eax,%eax
  10472c:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  10472f:	74 d5                	je     104706 <sys_unlink+0x26>
    return -1;
  ilock(dp);
  104731:	89 04 24             	mov    %eax,(%esp)
  104734:	e8 57 d4 ff ff       	call   101b90 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0){
  104739:	c7 44 24 04 54 6b 10 	movl   $0x106b54,0x4(%esp)
  104740:	00 
  104741:	89 1c 24             	mov    %ebx,(%esp)
  104744:	e8 d7 ce ff ff       	call   101620 <namecmp>
  104749:	85 c0                	test   %eax,%eax
  10474b:	0f 84 a4 00 00 00    	je     1047f5 <sys_unlink+0x115>
  104751:	c7 44 24 04 53 6b 10 	movl   $0x106b53,0x4(%esp)
  104758:	00 
  104759:	89 1c 24             	mov    %ebx,(%esp)
  10475c:	e8 bf ce ff ff       	call   101620 <namecmp>
  104761:	85 c0                	test   %eax,%eax
  104763:	0f 84 8c 00 00 00    	je     1047f5 <sys_unlink+0x115>
    iunlockput(dp);
    return -1;
  }

  if((ip = dirlookup(dp, name, &off)) == 0){
  104769:	8d 45 e0             	lea    -0x20(%ebp),%eax
  10476c:	89 44 24 08          	mov    %eax,0x8(%esp)
  104770:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  104773:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  104777:	89 04 24             	mov    %eax,(%esp)
  10477a:	e8 d1 ce ff ff       	call   101650 <dirlookup>
  10477f:	85 c0                	test   %eax,%eax
  104781:	89 c6                	mov    %eax,%esi
  104783:	74 70                	je     1047f5 <sys_unlink+0x115>
    iunlockput(dp);
    return -1;
  }
  ilock(ip);
  104785:	89 04 24             	mov    %eax,(%esp)
  104788:	e8 03 d4 ff ff       	call   101b90 <ilock>

  if(ip->nlink < 1)
  10478d:	66 83 7e 16 00       	cmpw   $0x0,0x16(%esi)
  104792:	0f 8e 0e 01 00 00    	jle    1048a6 <sys_unlink+0x1c6>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
  104798:	66 83 7e 10 01       	cmpw   $0x1,0x10(%esi)
  10479d:	75 71                	jne    104810 <sys_unlink+0x130>
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
  10479f:	83 7e 18 20          	cmpl   $0x20,0x18(%esi)
  1047a3:	76 6b                	jbe    104810 <sys_unlink+0x130>
  1047a5:	8d 7d b2             	lea    -0x4e(%ebp),%edi
  1047a8:	bb 20 00 00 00       	mov    $0x20,%ebx
  1047ad:	8d 76 00             	lea    0x0(%esi),%esi
  1047b0:	eb 0e                	jmp    1047c0 <sys_unlink+0xe0>
  1047b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1047b8:	83 c3 10             	add    $0x10,%ebx
  1047bb:	3b 5e 18             	cmp    0x18(%esi),%ebx
  1047be:	73 50                	jae    104810 <sys_unlink+0x130>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  1047c0:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  1047c7:	00 
  1047c8:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  1047cc:	89 7c 24 04          	mov    %edi,0x4(%esp)
  1047d0:	89 34 24             	mov    %esi,(%esp)
  1047d3:	e8 78 cb ff ff       	call   101350 <readi>
  1047d8:	83 f8 10             	cmp    $0x10,%eax
  1047db:	0f 85 ad 00 00 00    	jne    10488e <sys_unlink+0x1ae>
      panic("isdirempty: readi");
    if(de.inum != 0)
  1047e1:	66 83 7d b2 00       	cmpw   $0x0,-0x4e(%ebp)
  1047e6:	74 d0                	je     1047b8 <sys_unlink+0xd8>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
  1047e8:	89 34 24             	mov    %esi,(%esp)
  1047eb:	90                   	nop
  1047ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1047f0:	e8 ab d2 ff ff       	call   101aa0 <iunlockput>
    iunlockput(dp);
  1047f5:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  1047f8:	89 04 24             	mov    %eax,(%esp)
  1047fb:	e8 a0 d2 ff ff       	call   101aa0 <iunlockput>
  104800:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    return -1;
  104805:	e9 01 ff ff ff       	jmp    10470b <sys_unlink+0x2b>
  10480a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }

  memset(&de, 0, sizeof(de));
  104810:	8d 5d c2             	lea    -0x3e(%ebp),%ebx
  104813:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
  10481a:	00 
  10481b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  104822:	00 
  104823:	89 1c 24             	mov    %ebx,(%esp)
  104826:	e8 95 f3 ff ff       	call   103bc0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  10482b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10482e:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  104835:	00 
  104836:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  10483a:	89 44 24 08          	mov    %eax,0x8(%esp)
  10483e:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  104841:	89 04 24             	mov    %eax,(%esp)
  104844:	e8 97 cc ff ff       	call   1014e0 <writei>
  104849:	83 f8 10             	cmp    $0x10,%eax
  10484c:	75 4c                	jne    10489a <sys_unlink+0x1ba>
    panic("unlink: writei");
  if(ip->type == T_DIR){
  10484e:	66 83 7e 10 01       	cmpw   $0x1,0x10(%esi)
  104853:	74 27                	je     10487c <sys_unlink+0x19c>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
  104855:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  104858:	89 04 24             	mov    %eax,(%esp)
  10485b:	e8 40 d2 ff ff       	call   101aa0 <iunlockput>

  ip->nlink--;
  104860:	66 83 6e 16 01       	subw   $0x1,0x16(%esi)
  iupdate(ip);
  104865:	89 34 24             	mov    %esi,(%esp)
  104868:	e8 e3 cb ff ff       	call   101450 <iupdate>
  iunlockput(ip);
  10486d:	89 34 24             	mov    %esi,(%esp)
  104870:	e8 2b d2 ff ff       	call   101aa0 <iunlockput>
  104875:	31 c0                	xor    %eax,%eax
  return 0;
  104877:	e9 8f fe ff ff       	jmp    10470b <sys_unlink+0x2b>

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
  10487c:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  10487f:	66 83 68 16 01       	subw   $0x1,0x16(%eax)
    iupdate(dp);
  104884:	89 04 24             	mov    %eax,(%esp)
  104887:	e8 c4 cb ff ff       	call   101450 <iupdate>
  10488c:	eb c7                	jmp    104855 <sys_unlink+0x175>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
  10488e:	c7 04 24 84 6b 10 00 	movl   $0x106b84,(%esp)
  104895:	e8 16 c0 ff ff       	call   1008b0 <panic>
    return -1;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  10489a:	c7 04 24 96 6b 10 00 	movl   $0x106b96,(%esp)
  1048a1:	e8 0a c0 ff ff       	call   1008b0 <panic>
    return -1;
  }
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  1048a6:	c7 04 24 72 6b 10 00 	movl   $0x106b72,(%esp)
  1048ad:	e8 fe bf ff ff       	call   1008b0 <panic>
  1048b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1048b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001048c0 <T.67>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
  1048c0:	55                   	push   %ebp
  1048c1:	89 e5                	mov    %esp,%ebp
  1048c3:	83 ec 28             	sub    $0x28,%esp
  1048c6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  1048c9:	89 c3                	mov    %eax,%ebx
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
  1048cb:	8d 45 f4             	lea    -0xc(%ebp),%eax
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
  1048ce:	89 75 fc             	mov    %esi,-0x4(%ebp)
  1048d1:	89 d6                	mov    %edx,%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
  1048d3:	89 44 24 04          	mov    %eax,0x4(%esp)
  1048d7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1048de:	e8 7d f5 ff ff       	call   103e60 <argint>
  1048e3:	85 c0                	test   %eax,%eax
  1048e5:	79 11                	jns    1048f8 <T.67+0x38>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  1048e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return 0;
}
  1048ec:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  1048ef:	8b 75 fc             	mov    -0x4(%ebp),%esi
  1048f2:	89 ec                	mov    %ebp,%esp
  1048f4:	5d                   	pop    %ebp
  1048f5:	c3                   	ret    
  1048f6:	66 90                	xchg   %ax,%ax
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
  1048f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1048fb:	83 f8 0f             	cmp    $0xf,%eax
  1048fe:	77 e7                	ja     1048e7 <T.67+0x27>
  104900:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  104907:	8b 54 82 28          	mov    0x28(%edx,%eax,4),%edx
  10490b:	85 d2                	test   %edx,%edx
  10490d:	74 d8                	je     1048e7 <T.67+0x27>
    return -1;
  if(pfd)
  10490f:	85 db                	test   %ebx,%ebx
  104911:	74 02                	je     104915 <T.67+0x55>
    *pfd = fd;
  104913:	89 03                	mov    %eax,(%ebx)
  if(pf)
  104915:	31 c0                	xor    %eax,%eax
  104917:	85 f6                	test   %esi,%esi
  104919:	74 d1                	je     1048ec <T.67+0x2c>
    *pf = f;
  10491b:	89 16                	mov    %edx,(%esi)
  10491d:	eb cd                	jmp    1048ec <T.67+0x2c>
  10491f:	90                   	nop

00104920 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
  104920:	55                   	push   %ebp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
  104921:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_dup(void)
{
  104923:	89 e5                	mov    %esp,%ebp
  104925:	53                   	push   %ebx
  104926:	83 ec 24             	sub    $0x24,%esp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
  104929:	8d 55 f4             	lea    -0xc(%ebp),%edx
  10492c:	e8 8f ff ff ff       	call   1048c0 <T.67>
  104931:	85 c0                	test   %eax,%eax
  104933:	79 13                	jns    104948 <sys_dup+0x28>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
  104935:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
  10493a:	89 d8                	mov    %ebx,%eax
  10493c:	83 c4 24             	add    $0x24,%esp
  10493f:	5b                   	pop    %ebx
  104940:	5d                   	pop    %ebp
  104941:	c3                   	ret    
  104942:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
  104948:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10494b:	31 db                	xor    %ebx,%ebx
  10494d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104953:	eb 0b                	jmp    104960 <sys_dup+0x40>
  104955:	8d 76 00             	lea    0x0(%esi),%esi
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
  104958:	83 c3 01             	add    $0x1,%ebx
  10495b:	83 fb 10             	cmp    $0x10,%ebx
  10495e:	74 d5                	je     104935 <sys_dup+0x15>
    if(proc->ofile[fd] == 0){
  104960:	8b 4c 98 28          	mov    0x28(%eax,%ebx,4),%ecx
  104964:	85 c9                	test   %ecx,%ecx
  104966:	75 f0                	jne    104958 <sys_dup+0x38>
      proc->ofile[fd] = f;
  104968:	89 54 98 28          	mov    %edx,0x28(%eax,%ebx,4)
  
  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  10496c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10496f:	89 04 24             	mov    %eax,(%esp)
  104972:	e8 19 c5 ff ff       	call   100e90 <filedup>
  return fd;
  104977:	eb c1                	jmp    10493a <sys_dup+0x1a>
  104979:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104980 <sys_read>:
}

int
sys_read(void)
{
  104980:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  104981:	31 c0                	xor    %eax,%eax
  return fd;
}

int
sys_read(void)
{
  104983:	89 e5                	mov    %esp,%ebp
  104985:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  104988:	8d 55 f4             	lea    -0xc(%ebp),%edx
  10498b:	e8 30 ff ff ff       	call   1048c0 <T.67>
  104990:	85 c0                	test   %eax,%eax
  104992:	79 0c                	jns    1049a0 <sys_read+0x20>
    return -1;
  return fileread(f, p, n);
  104994:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104999:	c9                   	leave  
  10499a:	c3                   	ret    
  10499b:	90                   	nop
  10499c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  1049a0:	8d 45 f0             	lea    -0x10(%ebp),%eax
  1049a3:	89 44 24 04          	mov    %eax,0x4(%esp)
  1049a7:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  1049ae:	e8 ad f4 ff ff       	call   103e60 <argint>
  1049b3:	85 c0                	test   %eax,%eax
  1049b5:	78 dd                	js     104994 <sys_read+0x14>
  1049b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1049ba:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1049c1:	89 44 24 08          	mov    %eax,0x8(%esp)
  1049c5:	8d 45 ec             	lea    -0x14(%ebp),%eax
  1049c8:	89 44 24 04          	mov    %eax,0x4(%esp)
  1049cc:	e8 cf f4 ff ff       	call   103ea0 <argptr>
  1049d1:	85 c0                	test   %eax,%eax
  1049d3:	78 bf                	js     104994 <sys_read+0x14>
    return -1;
  return fileread(f, p, n);
  1049d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1049d8:	89 44 24 08          	mov    %eax,0x8(%esp)
  1049dc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1049df:	89 44 24 04          	mov    %eax,0x4(%esp)
  1049e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1049e6:	89 04 24             	mov    %eax,(%esp)
  1049e9:	e8 a2 c3 ff ff       	call   100d90 <fileread>
}
  1049ee:	c9                   	leave  
  1049ef:	c3                   	ret    

001049f0 <sys_write>:

int
sys_write(void)
{
  1049f0:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  1049f1:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
  1049f3:	89 e5                	mov    %esp,%ebp
  1049f5:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  1049f8:	8d 55 f4             	lea    -0xc(%ebp),%edx
  1049fb:	e8 c0 fe ff ff       	call   1048c0 <T.67>
  104a00:	85 c0                	test   %eax,%eax
  104a02:	79 0c                	jns    104a10 <sys_write+0x20>
    return -1;
  return filewrite(f, p, n);
  104a04:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104a09:	c9                   	leave  
  104a0a:	c3                   	ret    
  104a0b:	90                   	nop
  104a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  104a10:	8d 45 f0             	lea    -0x10(%ebp),%eax
  104a13:	89 44 24 04          	mov    %eax,0x4(%esp)
  104a17:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  104a1e:	e8 3d f4 ff ff       	call   103e60 <argint>
  104a23:	85 c0                	test   %eax,%eax
  104a25:	78 dd                	js     104a04 <sys_write+0x14>
  104a27:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104a2a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  104a31:	89 44 24 08          	mov    %eax,0x8(%esp)
  104a35:	8d 45 ec             	lea    -0x14(%ebp),%eax
  104a38:	89 44 24 04          	mov    %eax,0x4(%esp)
  104a3c:	e8 5f f4 ff ff       	call   103ea0 <argptr>
  104a41:	85 c0                	test   %eax,%eax
  104a43:	78 bf                	js     104a04 <sys_write+0x14>
    return -1;
  return filewrite(f, p, n);
  104a45:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104a48:	89 44 24 08          	mov    %eax,0x8(%esp)
  104a4c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  104a4f:	89 44 24 04          	mov    %eax,0x4(%esp)
  104a53:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104a56:	89 04 24             	mov    %eax,(%esp)
  104a59:	e8 82 c2 ff ff       	call   100ce0 <filewrite>
}
  104a5e:	c9                   	leave  
  104a5f:	c3                   	ret    

00104a60 <sys_fstat>:
  return 0;
}

int
sys_fstat(void)
{
  104a60:	55                   	push   %ebp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
  104a61:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
  104a63:	89 e5                	mov    %esp,%ebp
  104a65:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
  104a68:	8d 55 f4             	lea    -0xc(%ebp),%edx
  104a6b:	e8 50 fe ff ff       	call   1048c0 <T.67>
  104a70:	85 c0                	test   %eax,%eax
  104a72:	79 0c                	jns    104a80 <sys_fstat+0x20>
    return -1;
  return filestat(f, st);
  104a74:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104a79:	c9                   	leave  
  104a7a:	c3                   	ret    
  104a7b:	90                   	nop
  104a7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
sys_fstat(void)
{
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
  104a80:	8d 45 f0             	lea    -0x10(%ebp),%eax
  104a83:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
  104a8a:	00 
  104a8b:	89 44 24 04          	mov    %eax,0x4(%esp)
  104a8f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  104a96:	e8 05 f4 ff ff       	call   103ea0 <argptr>
  104a9b:	85 c0                	test   %eax,%eax
  104a9d:	78 d5                	js     104a74 <sys_fstat+0x14>
    return -1;
  return filestat(f, st);
  104a9f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104aa2:	89 44 24 04          	mov    %eax,0x4(%esp)
  104aa6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104aa9:	89 04 24             	mov    %eax,(%esp)
  104aac:	e8 8f c3 ff ff       	call   100e40 <filestat>
}
  104ab1:	c9                   	leave  
  104ab2:	c3                   	ret    
  104ab3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104ac0 <sys_close>:
  return filewrite(f, p, n);
}

int
sys_close(void)
{
  104ac0:	55                   	push   %ebp
  104ac1:	89 e5                	mov    %esp,%ebp
  104ac3:	83 ec 28             	sub    $0x28,%esp
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
  104ac6:	8d 55 f0             	lea    -0x10(%ebp),%edx
  104ac9:	8d 45 f4             	lea    -0xc(%ebp),%eax
  104acc:	e8 ef fd ff ff       	call   1048c0 <T.67>
  104ad1:	89 c2                	mov    %eax,%edx
  104ad3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  104ad8:	85 d2                	test   %edx,%edx
  104ada:	78 1e                	js     104afa <sys_close+0x3a>
    return -1;
  proc->ofile[fd] = 0;
  104adc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104ae2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  104ae5:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
  104aec:	00 
  fileclose(f);
  104aed:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104af0:	89 04 24             	mov    %eax,(%esp)
  104af3:	e8 68 c4 ff ff       	call   100f60 <fileclose>
  104af8:	31 c0                	xor    %eax,%eax
  return 0;
}
  104afa:	c9                   	leave  
  104afb:	c3                   	ret    
  104afc:	90                   	nop
  104afd:	90                   	nop
  104afe:	90                   	nop
  104aff:	90                   	nop

00104b00 <sys_startrecording>:
#include "mmu.h"
#include "proc.h"

int
sys_startrecording(){
  proc->logging = 1;
  104b00:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
#include "param.h"
#include "mmu.h"
#include "proc.h"

int
sys_startrecording(){
  104b06:	55                   	push   %ebp
  104b07:	89 e5                	mov    %esp,%ebp
  proc->logging = 1;
  104b09:	c7 40 6c 01 00 00 00 	movl   $0x1,0x6c(%eax)
  104b10:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  if(proc->logging == 0){
	return 1;
  }
  return 0;
}
  104b16:	5d                   	pop    %ebp
#include "mmu.h"
#include "proc.h"

int
sys_startrecording(){
  proc->logging = 1;
  104b17:	8b 40 6c             	mov    0x6c(%eax),%eax
  104b1a:	85 c0                	test   %eax,%eax
  104b1c:	0f 94 c0             	sete   %al
  104b1f:	0f b6 c0             	movzbl %al,%eax
  if(proc->logging == 0){
	return 1;
  }
  return 0;
}
  104b22:	c3                   	ret    
  104b23:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104b30 <sys_stoprecording>:

int
sys_stoprecording(){
  return proc->logging = 0;
  104b30:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  }
  return 0;
}

int
sys_stoprecording(){
  104b36:	55                   	push   %ebp
  104b37:	89 e5                	mov    %esp,%ebp
  return proc->logging = 0;
  104b39:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
}
  104b40:	31 c0                	xor    %eax,%eax
  104b42:	5d                   	pop    %ebp
  104b43:	c3                   	ret    
  104b44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104b4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00104b50 <sys_fetchrecords>:

int
sys_fetchrecords(){
  104b50:	55                   	push   %ebp
  return 0;
}
  104b51:	31 c0                	xor    %eax,%eax
sys_stoprecording(){
  return proc->logging = 0;
}

int
sys_fetchrecords(){
  104b53:	89 e5                	mov    %esp,%ebp
  return 0;
}
  104b55:	5d                   	pop    %ebp
  104b56:	c3                   	ret    
  104b57:	89 f6                	mov    %esi,%esi
  104b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104b60 <sys_getpid>:
}

int
sys_getpid(void)
{
  return proc->pid;
  104b60:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  return kill(pid);
}

int
sys_getpid(void)
{
  104b66:	55                   	push   %ebp
  104b67:	89 e5                	mov    %esp,%ebp
  return proc->pid;
}
  104b69:	5d                   	pop    %ebp
}

int
sys_getpid(void)
{
  return proc->pid;
  104b6a:	8b 40 10             	mov    0x10(%eax),%eax
}
  104b6d:	c3                   	ret    
  104b6e:	66 90                	xchg   %ax,%ax

00104b70 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since boot.
int
sys_uptime(void)
{
  104b70:	55                   	push   %ebp
  104b71:	89 e5                	mov    %esp,%ebp
  104b73:	53                   	push   %ebx
  104b74:	83 ec 14             	sub    $0x14,%esp
  uint xticks;
  
  acquire(&tickslock);
  104b77:	c7 04 24 e0 d0 10 00 	movl   $0x10d0e0,(%esp)
  104b7e:	e8 9d ef ff ff       	call   103b20 <acquire>
  xticks = ticks;
  104b83:	8b 1d 20 d9 10 00    	mov    0x10d920,%ebx
  release(&tickslock);
  104b89:	c7 04 24 e0 d0 10 00 	movl   $0x10d0e0,(%esp)
  104b90:	e8 3b ef ff ff       	call   103ad0 <release>
  return xticks;
}
  104b95:	83 c4 14             	add    $0x14,%esp
  104b98:	89 d8                	mov    %ebx,%eax
  104b9a:	5b                   	pop    %ebx
  104b9b:	5d                   	pop    %ebp
  104b9c:	c3                   	ret    
  104b9d:	8d 76 00             	lea    0x0(%esi),%esi

00104ba0 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
  104ba0:	55                   	push   %ebp
  104ba1:	89 e5                	mov    %esp,%ebp
  104ba3:	53                   	push   %ebx
  104ba4:	83 ec 24             	sub    $0x24,%esp
  int n;
  uint ticks0;
  
  if(argint(0, &n) < 0)
  104ba7:	8d 45 f4             	lea    -0xc(%ebp),%eax
  104baa:	89 44 24 04          	mov    %eax,0x4(%esp)
  104bae:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104bb5:	e8 a6 f2 ff ff       	call   103e60 <argint>
  104bba:	89 c2                	mov    %eax,%edx
  104bbc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  104bc1:	85 d2                	test   %edx,%edx
  104bc3:	78 59                	js     104c1e <sys_sleep+0x7e>
    return -1;
  acquire(&tickslock);
  104bc5:	c7 04 24 e0 d0 10 00 	movl   $0x10d0e0,(%esp)
  104bcc:	e8 4f ef ff ff       	call   103b20 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
  104bd1:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  uint ticks0;
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  104bd4:	8b 1d 20 d9 10 00    	mov    0x10d920,%ebx
  while(ticks - ticks0 < n){
  104bda:	85 c9                	test   %ecx,%ecx
  104bdc:	75 22                	jne    104c00 <sys_sleep+0x60>
  104bde:	eb 48                	jmp    104c28 <sys_sleep+0x88>
    if(proc->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  104be0:	c7 44 24 04 e0 d0 10 	movl   $0x10d0e0,0x4(%esp)
  104be7:	00 
  104be8:	c7 04 24 20 d9 10 00 	movl   $0x10d920,(%esp)
  104bef:	e8 7c e5 ff ff       	call   103170 <sleep>
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
  104bf4:	a1 20 d9 10 00       	mov    0x10d920,%eax
  104bf9:	29 d8                	sub    %ebx,%eax
  104bfb:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  104bfe:	73 28                	jae    104c28 <sys_sleep+0x88>
    if(proc->killed){
  104c00:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104c06:	8b 50 24             	mov    0x24(%eax),%edx
  104c09:	85 d2                	test   %edx,%edx
  104c0b:	74 d3                	je     104be0 <sys_sleep+0x40>
      release(&tickslock);
  104c0d:	c7 04 24 e0 d0 10 00 	movl   $0x10d0e0,(%esp)
  104c14:	e8 b7 ee ff ff       	call   103ad0 <release>
  104c19:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
  104c1e:	83 c4 24             	add    $0x24,%esp
  104c21:	5b                   	pop    %ebx
  104c22:	5d                   	pop    %ebp
  104c23:	c3                   	ret    
  104c24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  104c28:	c7 04 24 e0 d0 10 00 	movl   $0x10d0e0,(%esp)
  104c2f:	e8 9c ee ff ff       	call   103ad0 <release>
  return 0;
}
  104c34:	83 c4 24             	add    $0x24,%esp
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  104c37:	31 c0                	xor    %eax,%eax
  return 0;
}
  104c39:	5b                   	pop    %ebx
  104c3a:	5d                   	pop    %ebp
  104c3b:	c3                   	ret    
  104c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00104c40 <sys_sbrk>:
  return proc->pid;
}

int
sys_sbrk(void)
{
  104c40:	55                   	push   %ebp
  104c41:	89 e5                	mov    %esp,%ebp
  104c43:	53                   	push   %ebx
  104c44:	83 ec 24             	sub    $0x24,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
  104c47:	8d 45 f4             	lea    -0xc(%ebp),%eax
  104c4a:	89 44 24 04          	mov    %eax,0x4(%esp)
  104c4e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104c55:	e8 06 f2 ff ff       	call   103e60 <argint>
  104c5a:	85 c0                	test   %eax,%eax
  104c5c:	79 12                	jns    104c70 <sys_sbrk+0x30>
    return -1;
  addr = proc->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
  104c5e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104c63:	83 c4 24             	add    $0x24,%esp
  104c66:	5b                   	pop    %ebx
  104c67:	5d                   	pop    %ebp
  104c68:	c3                   	ret    
  104c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = proc->sz;
  104c70:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104c76:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
  104c78:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104c7b:	89 04 24             	mov    %eax,(%esp)
  104c7e:	e8 ad ea ff ff       	call   103730 <growproc>
  104c83:	89 c2                	mov    %eax,%edx
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = proc->sz;
  104c85:	89 d8                	mov    %ebx,%eax
  if(growproc(n) < 0)
  104c87:	85 d2                	test   %edx,%edx
  104c89:	79 d8                	jns    104c63 <sys_sbrk+0x23>
  104c8b:	eb d1                	jmp    104c5e <sys_sbrk+0x1e>
  104c8d:	8d 76 00             	lea    0x0(%esi),%esi

00104c90 <sys_kill>:
  return wait();
}

int
sys_kill(void)
{
  104c90:	55                   	push   %ebp
  104c91:	89 e5                	mov    %esp,%ebp
  104c93:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
  104c96:	8d 45 f4             	lea    -0xc(%ebp),%eax
  104c99:	89 44 24 04          	mov    %eax,0x4(%esp)
  104c9d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104ca4:	e8 b7 f1 ff ff       	call   103e60 <argint>
  104ca9:	89 c2                	mov    %eax,%edx
  104cab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  104cb0:	85 d2                	test   %edx,%edx
  104cb2:	78 0b                	js     104cbf <sys_kill+0x2f>
    return -1;
  return kill(pid);
  104cb4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104cb7:	89 04 24             	mov    %eax,(%esp)
  104cba:	e8 01 e3 ff ff       	call   102fc0 <kill>
}
  104cbf:	c9                   	leave  
  104cc0:	c3                   	ret    
  104cc1:	eb 0d                	jmp    104cd0 <sys_wait>
  104cc3:	90                   	nop
  104cc4:	90                   	nop
  104cc5:	90                   	nop
  104cc6:	90                   	nop
  104cc7:	90                   	nop
  104cc8:	90                   	nop
  104cc9:	90                   	nop
  104cca:	90                   	nop
  104ccb:	90                   	nop
  104ccc:	90                   	nop
  104ccd:	90                   	nop
  104cce:	90                   	nop
  104ccf:	90                   	nop

00104cd0 <sys_wait>:
  return 0;  // not reached
}

int
sys_wait(void)
{
  104cd0:	55                   	push   %ebp
  104cd1:	89 e5                	mov    %esp,%ebp
  104cd3:	83 ec 08             	sub    $0x8,%esp
  return wait();
}
  104cd6:	c9                   	leave  
}

int
sys_wait(void)
{
  return wait();
  104cd7:	e9 44 e6 ff ff       	jmp    103320 <wait>
  104cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00104ce0 <sys_exit>:
  return fork();
}

int
sys_exit(void)
{
  104ce0:	55                   	push   %ebp
  104ce1:	89 e5                	mov    %esp,%ebp
  104ce3:	83 ec 08             	sub    $0x8,%esp
  exit();
  104ce6:	e8 35 e7 ff ff       	call   103420 <exit>
  return 0;  // not reached
}
  104ceb:	31 c0                	xor    %eax,%eax
  104ced:	c9                   	leave  
  104cee:	c3                   	ret    
  104cef:	90                   	nop

00104cf0 <sys_fork>:
  return 0;
}

int
sys_fork(void)
{
  104cf0:	55                   	push   %ebp
  104cf1:	89 e5                	mov    %esp,%ebp
  104cf3:	83 ec 08             	sub    $0x8,%esp
  return fork();
}
  104cf6:	c9                   	leave  
}

int
sys_fork(void)
{
  return fork();
  104cf7:	e9 34 e9 ff ff       	jmp    103630 <fork>
  104cfc:	90                   	nop
  104cfd:	90                   	nop
  104cfe:	90                   	nop
  104cff:	90                   	nop

00104d00 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
  104d00:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  104d01:	ba 43 00 00 00       	mov    $0x43,%edx
  104d06:	89 e5                	mov    %esp,%ebp
  104d08:	83 ec 18             	sub    $0x18,%esp
  104d0b:	b8 34 00 00 00       	mov    $0x34,%eax
  104d10:	ee                   	out    %al,(%dx)
  104d11:	b8 9c ff ff ff       	mov    $0xffffff9c,%eax
  104d16:	b2 40                	mov    $0x40,%dl
  104d18:	ee                   	out    %al,(%dx)
  104d19:	b8 2e 00 00 00       	mov    $0x2e,%eax
  104d1e:	ee                   	out    %al,(%dx)
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
  picenable(IRQ_TIMER);
  104d1f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104d26:	e8 55 de ff ff       	call   102b80 <picenable>
}
  104d2b:	c9                   	leave  
  104d2c:	c3                   	ret    
  104d2d:	90                   	nop
  104d2e:	90                   	nop
  104d2f:	90                   	nop

00104d30 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
  104d30:	1e                   	push   %ds
  pushl %es
  104d31:	06                   	push   %es
  pushl %fs
  104d32:	0f a0                	push   %fs
  pushl %gs
  104d34:	0f a8                	push   %gs
  pushal
  104d36:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
  104d37:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
  104d3b:	8e d8                	mov    %eax,%ds
  movw %ax, %es
  104d3d:	8e c0                	mov    %eax,%es
  movw $(SEG_KCPU<<3), %ax
  104d3f:	66 b8 18 00          	mov    $0x18,%ax
  movw %ax, %fs
  104d43:	8e e0                	mov    %eax,%fs
  movw %ax, %gs
  104d45:	8e e8                	mov    %eax,%gs

  # Call trap(tf), where tf=%esp
  pushl %esp
  104d47:	54                   	push   %esp
  call trap
  104d48:	e8 43 00 00 00       	call   104d90 <trap>
  addl $4, %esp
  104d4d:	83 c4 04             	add    $0x4,%esp

00104d50 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
  104d50:	61                   	popa   
  popl %gs
  104d51:	0f a9                	pop    %gs
  popl %fs
  104d53:	0f a1                	pop    %fs
  popl %es
  104d55:	07                   	pop    %es
  popl %ds
  104d56:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
  104d57:	83 c4 08             	add    $0x8,%esp
  iret
  104d5a:	cf                   	iret   
  104d5b:	90                   	nop
  104d5c:	90                   	nop
  104d5d:	90                   	nop
  104d5e:	90                   	nop
  104d5f:	90                   	nop

00104d60 <idtinit>:
  initlock(&tickslock, "time");
}

void
idtinit(void)
{
  104d60:	55                   	push   %ebp
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  pd[1] = (uint)p;
  104d61:	b8 20 d1 10 00       	mov    $0x10d120,%eax
  104d66:	89 e5                	mov    %esp,%ebp
  104d68:	83 ec 10             	sub    $0x10,%esp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  104d6b:	66 c7 45 fa ff 07    	movw   $0x7ff,-0x6(%ebp)
  pd[1] = (uint)p;
  104d71:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
  104d75:	c1 e8 10             	shr    $0x10,%eax
  104d78:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
  104d7c:	8d 45 fa             	lea    -0x6(%ebp),%eax
  104d7f:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
  104d82:	c9                   	leave  
  104d83:	c3                   	ret    
  104d84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104d8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00104d90 <trap>:

void
trap(struct trapframe *tf)
{
  104d90:	55                   	push   %ebp
  104d91:	89 e5                	mov    %esp,%ebp
  104d93:	56                   	push   %esi
  104d94:	53                   	push   %ebx
  104d95:	83 ec 20             	sub    $0x20,%esp
  104d98:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
  104d9b:	8b 43 30             	mov    0x30(%ebx),%eax
  104d9e:	83 f8 40             	cmp    $0x40,%eax
  104da1:	0f 84 d1 00 00 00    	je     104e78 <trap+0xe8>
    if(proc->killed)
      exit();
    return;
  }

  switch(tf->trapno){
  104da7:	8d 50 e0             	lea    -0x20(%eax),%edx
  104daa:	83 fa 1f             	cmp    $0x1f,%edx
  104dad:	0f 86 bd 00 00 00    	jbe    104e70 <trap+0xe0>
            cpu->id, tf->cs, tf->eip);
    lapiceoi();
    break;
   
  default:
    if(proc == 0 || (tf->cs&3) == 0){
  104db3:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  104dba:	85 d2                	test   %edx,%edx
  104dbc:	0f 84 fe 01 00 00    	je     104fc0 <trap+0x230>
  104dc2:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
  104dc6:	0f 84 f4 01 00 00    	je     104fc0 <trap+0x230>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
  104dcc:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
  104dcf:	8b 4a 10             	mov    0x10(%edx),%ecx
  104dd2:	83 c2 70             	add    $0x70,%edx
  104dd5:	89 74 24 1c          	mov    %esi,0x1c(%esp)
  104dd9:	8b 73 38             	mov    0x38(%ebx),%esi
  104ddc:	89 74 24 18          	mov    %esi,0x18(%esp)
  104de0:	65 8b 35 00 00 00 00 	mov    %gs:0x0,%esi
  104de7:	0f b6 36             	movzbl (%esi),%esi
  104dea:	89 74 24 14          	mov    %esi,0x14(%esp)
  104dee:	8b 73 34             	mov    0x34(%ebx),%esi
  104df1:	89 44 24 0c          	mov    %eax,0xc(%esp)
  104df5:	89 54 24 08          	mov    %edx,0x8(%esp)
  104df9:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  104dfd:	89 74 24 10          	mov    %esi,0x10(%esp)
  104e01:	c7 04 24 00 6c 10 00 	movl   $0x106c00,(%esp)
  104e08:	e8 b3 b6 ff ff       	call   1004c0 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
            rcr2());
    proc->killed = 1;
  104e0d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104e13:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  104e1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
  104e20:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104e26:	85 c0                	test   %eax,%eax
  104e28:	74 70                	je     104e9a <trap+0x10a>
  104e2a:	8b 50 24             	mov    0x24(%eax),%edx
  104e2d:	85 d2                	test   %edx,%edx
  104e2f:	74 10                	je     104e41 <trap+0xb1>
  104e31:	0f b7 53 3c          	movzwl 0x3c(%ebx),%edx
  104e35:	83 e2 03             	and    $0x3,%edx
  104e38:	83 fa 03             	cmp    $0x3,%edx
  104e3b:	0f 84 67 01 00 00    	je     104fa8 <trap+0x218>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
  104e41:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
  104e45:	0f 84 35 01 00 00    	je     104f80 <trap+0x1f0>
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
  104e4b:	8b 40 24             	mov    0x24(%eax),%eax
  104e4e:	85 c0                	test   %eax,%eax
  104e50:	74 48                	je     104e9a <trap+0x10a>
  104e52:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
  104e56:	83 e0 03             	and    $0x3,%eax
  104e59:	83 f8 03             	cmp    $0x3,%eax
  104e5c:	75 3c                	jne    104e9a <trap+0x10a>
    exit();
}
  104e5e:	83 c4 20             	add    $0x20,%esp
  104e61:	5b                   	pop    %ebx
  104e62:	5e                   	pop    %esi
  104e63:	5d                   	pop    %ebp
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();
  104e64:	e9 b7 e5 ff ff       	jmp    103420 <exit>
  104e69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(proc->killed)
      exit();
    return;
  }

  switch(tf->trapno){
  104e70:	ff 24 95 50 6c 10 00 	jmp    *0x106c50(,%edx,4)
  104e77:	90                   	nop

void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(proc->killed)
  104e78:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104e7e:	8b 70 24             	mov    0x24(%eax),%esi
  104e81:	85 f6                	test   %esi,%esi
  104e83:	75 23                	jne    104ea8 <trap+0x118>
      exit();
    proc->tf = tf;
  104e85:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
  104e88:	e8 d3 f0 ff ff       	call   103f60 <syscall>
    if(proc->killed)
  104e8d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104e93:	8b 48 24             	mov    0x24(%eax),%ecx
  104e96:	85 c9                	test   %ecx,%ecx
  104e98:	75 c4                	jne    104e5e <trap+0xce>
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();
}
  104e9a:	83 c4 20             	add    $0x20,%esp
  104e9d:	5b                   	pop    %ebx
  104e9e:	5e                   	pop    %esi
  104e9f:	5d                   	pop    %ebp
  104ea0:	c3                   	ret    
  104ea1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(proc->killed)
      exit();
  104ea8:	e8 73 e5 ff ff       	call   103420 <exit>
  104ead:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104eb3:	eb d0                	jmp    104e85 <trap+0xf5>
  104eb5:	8d 76 00             	lea    0x0(%esi),%esi
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
  104eb8:	8b 43 38             	mov    0x38(%ebx),%eax
  104ebb:	89 44 24 0c          	mov    %eax,0xc(%esp)
  104ebf:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
  104ec3:	89 44 24 08          	mov    %eax,0x8(%esp)
  104ec7:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  104ecd:	0f b6 00             	movzbl (%eax),%eax
  104ed0:	c7 04 24 a8 6b 10 00 	movl   $0x106ba8,(%esp)
  104ed7:	89 44 24 04          	mov    %eax,0x4(%esp)
  104edb:	e8 e0 b5 ff ff       	call   1004c0 <cprintf>
            cpu->id, tf->cs, tf->eip);
    lapiceoi();
  104ee0:	e8 6b d5 ff ff       	call   102450 <lapiceoi>
    break;
  104ee5:	e9 36 ff ff ff       	jmp    104e20 <trap+0x90>
  104eea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_COM1:
    uartintr();
  104ef0:	e8 cb 01 00 00       	call   1050c0 <uartintr>
  104ef5:	8d 76 00             	lea    0x0(%esi),%esi
    lapiceoi();
  104ef8:	e8 53 d5 ff ff       	call   102450 <lapiceoi>
  104efd:	8d 76 00             	lea    0x0(%esi),%esi
    break;
  104f00:	e9 1b ff ff ff       	jmp    104e20 <trap+0x90>
  104f05:	8d 76 00             	lea    0x0(%esi),%esi
  104f08:	90                   	nop
  104f09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
  104f10:	e8 db d0 ff ff       	call   101ff0 <ideintr>
  104f15:	8d 76 00             	lea    0x0(%esi),%esi
    lapiceoi();
  104f18:	e8 33 d5 ff ff       	call   102450 <lapiceoi>
  104f1d:	8d 76 00             	lea    0x0(%esi),%esi
    break;
  104f20:	e9 fb fe ff ff       	jmp    104e20 <trap+0x90>
  104f25:	8d 76 00             	lea    0x0(%esi),%esi
  104f28:	90                   	nop
  104f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
  104f30:	e8 fb d4 ff ff       	call   102430 <kbdintr>
  104f35:	8d 76 00             	lea    0x0(%esi),%esi
    lapiceoi();
  104f38:	e8 13 d5 ff ff       	call   102450 <lapiceoi>
  104f3d:	8d 76 00             	lea    0x0(%esi),%esi
    break;
  104f40:	e9 db fe ff ff       	jmp    104e20 <trap+0x90>
  104f45:	8d 76 00             	lea    0x0(%esi),%esi
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpu->id == 0){
  104f48:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  104f4e:	80 38 00             	cmpb   $0x0,(%eax)
  104f51:	75 c2                	jne    104f15 <trap+0x185>
      acquire(&tickslock);
  104f53:	c7 04 24 e0 d0 10 00 	movl   $0x10d0e0,(%esp)
  104f5a:	e8 c1 eb ff ff       	call   103b20 <acquire>
      ticks++;
  104f5f:	83 05 20 d9 10 00 01 	addl   $0x1,0x10d920
      wakeup(&ticks);
  104f66:	c7 04 24 20 d9 10 00 	movl   $0x10d920,(%esp)
  104f6d:	e8 de e0 ff ff       	call   103050 <wakeup>
      release(&tickslock);
  104f72:	c7 04 24 e0 d0 10 00 	movl   $0x10d0e0,(%esp)
  104f79:	e8 52 eb ff ff       	call   103ad0 <release>
  104f7e:	eb 95                	jmp    104f15 <trap+0x185>
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
  104f80:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
  104f84:	0f 85 c1 fe ff ff    	jne    104e4b <trap+0xbb>
  104f8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    yield();
  104f90:	e8 ab e2 ff ff       	call   103240 <yield>

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
  104f95:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104f9b:	85 c0                	test   %eax,%eax
  104f9d:	0f 85 a8 fe ff ff    	jne    104e4b <trap+0xbb>
  104fa3:	e9 f2 fe ff ff       	jmp    104e9a <trap+0x10a>

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();
  104fa8:	e8 73 e4 ff ff       	call   103420 <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
  104fad:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104fb3:	85 c0                	test   %eax,%eax
  104fb5:	0f 85 86 fe ff ff    	jne    104e41 <trap+0xb1>
  104fbb:	e9 da fe ff ff       	jmp    104e9a <trap+0x10a>
  104fc0:	0f 20 d2             	mov    %cr2,%edx
    break;
   
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
  104fc3:	89 54 24 10          	mov    %edx,0x10(%esp)
  104fc7:	8b 53 38             	mov    0x38(%ebx),%edx
  104fca:	89 54 24 0c          	mov    %edx,0xc(%esp)
  104fce:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
  104fd5:	0f b6 12             	movzbl (%edx),%edx
  104fd8:	89 44 24 04          	mov    %eax,0x4(%esp)
  104fdc:	c7 04 24 cc 6b 10 00 	movl   $0x106bcc,(%esp)
  104fe3:	89 54 24 08          	mov    %edx,0x8(%esp)
  104fe7:	e8 d4 b4 ff ff       	call   1004c0 <cprintf>
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
  104fec:	c7 04 24 43 6c 10 00 	movl   $0x106c43,(%esp)
  104ff3:	e8 b8 b8 ff ff       	call   1008b0 <panic>
  104ff8:	90                   	nop
  104ff9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00105000 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
  105000:	55                   	push   %ebp
  105001:	31 c0                	xor    %eax,%eax
  105003:	89 e5                	mov    %esp,%ebp
  105005:	ba 20 d1 10 00       	mov    $0x10d120,%edx
  10500a:	83 ec 18             	sub    $0x18,%esp
  10500d:	8d 76 00             	lea    0x0(%esi),%esi
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  105010:	8b 0c 85 08 73 10 00 	mov    0x107308(,%eax,4),%ecx
  105017:	66 89 0c c5 20 d1 10 	mov    %cx,0x10d120(,%eax,8)
  10501e:	00 
  10501f:	c1 e9 10             	shr    $0x10,%ecx
  105022:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  105029:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  10502e:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  105033:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
  105038:	83 c0 01             	add    $0x1,%eax
  10503b:	3d 00 01 00 00       	cmp    $0x100,%eax
  105040:	75 ce                	jne    105010 <tvinit+0x10>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
  105042:	a1 08 74 10 00       	mov    0x107408,%eax
  
  initlock(&tickslock, "time");
  105047:	c7 44 24 04 48 6c 10 	movl   $0x106c48,0x4(%esp)
  10504e:	00 
  10504f:	c7 04 24 e0 d0 10 00 	movl   $0x10d0e0,(%esp)
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
  105056:	66 c7 05 22 d3 10 00 	movw   $0x8,0x10d322
  10505d:	08 00 
  10505f:	66 a3 20 d3 10 00    	mov    %ax,0x10d320
  105065:	c1 e8 10             	shr    $0x10,%eax
  105068:	c6 05 24 d3 10 00 00 	movb   $0x0,0x10d324
  10506f:	c6 05 25 d3 10 00 ef 	movb   $0xef,0x10d325
  105076:	66 a3 26 d3 10 00    	mov    %ax,0x10d326
  
  initlock(&tickslock, "time");
  10507c:	e8 0f e9 ff ff       	call   103990 <initlock>
}
  105081:	c9                   	leave  
  105082:	c3                   	ret    
  105083:	90                   	nop
  105084:	90                   	nop
  105085:	90                   	nop
  105086:	90                   	nop
  105087:	90                   	nop
  105088:	90                   	nop
  105089:	90                   	nop
  10508a:	90                   	nop
  10508b:	90                   	nop
  10508c:	90                   	nop
  10508d:	90                   	nop
  10508e:	90                   	nop
  10508f:	90                   	nop

00105090 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
  105090:	a1 4c 78 10 00       	mov    0x10784c,%eax
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
  105095:	55                   	push   %ebp
  105096:	89 e5                	mov    %esp,%ebp
  if(!uart)
  105098:	85 c0                	test   %eax,%eax
  10509a:	75 0c                	jne    1050a8 <uartgetc+0x18>
    return -1;
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
  10509c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  1050a1:	5d                   	pop    %ebp
  1050a2:	c3                   	ret    
  1050a3:	90                   	nop
  1050a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  1050a8:	ba fd 03 00 00       	mov    $0x3fd,%edx
  1050ad:	ec                   	in     (%dx),%al
static int
uartgetc(void)
{
  if(!uart)
    return -1;
  if(!(inb(COM1+5) & 0x01))
  1050ae:	a8 01                	test   $0x1,%al
  1050b0:	74 ea                	je     10509c <uartgetc+0xc>
  1050b2:	b2 f8                	mov    $0xf8,%dl
  1050b4:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
  1050b5:	0f b6 c0             	movzbl %al,%eax
}
  1050b8:	5d                   	pop    %ebp
  1050b9:	c3                   	ret    
  1050ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001050c0 <uartintr>:

void
uartintr(void)
{
  1050c0:	55                   	push   %ebp
  1050c1:	89 e5                	mov    %esp,%ebp
  1050c3:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
  1050c6:	c7 04 24 90 50 10 00 	movl   $0x105090,(%esp)
  1050cd:	e8 4e b6 ff ff       	call   100720 <consoleintr>
}
  1050d2:	c9                   	leave  
  1050d3:	c3                   	ret    
  1050d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1050da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

001050e0 <uartputc>:
    uartputc(*p);
}

void
uartputc(int c)
{
  1050e0:	55                   	push   %ebp
  1050e1:	89 e5                	mov    %esp,%ebp
  1050e3:	56                   	push   %esi
  1050e4:	be fd 03 00 00       	mov    $0x3fd,%esi
  1050e9:	53                   	push   %ebx
  int i;

  if(!uart)
  1050ea:	31 db                	xor    %ebx,%ebx
    uartputc(*p);
}

void
uartputc(int c)
{
  1050ec:	83 ec 10             	sub    $0x10,%esp
  int i;

  if(!uart)
  1050ef:	8b 15 4c 78 10 00    	mov    0x10784c,%edx
  1050f5:	85 d2                	test   %edx,%edx
  1050f7:	75 1e                	jne    105117 <uartputc+0x37>
  1050f9:	eb 2c                	jmp    105127 <uartputc+0x47>
  1050fb:	90                   	nop
  1050fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
  105100:	83 c3 01             	add    $0x1,%ebx
    microdelay(10);
  105103:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
  10510a:	e8 61 d3 ff ff       	call   102470 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
  10510f:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
  105115:	74 07                	je     10511e <uartputc+0x3e>
  105117:	89 f2                	mov    %esi,%edx
  105119:	ec                   	in     (%dx),%al
  10511a:	a8 20                	test   $0x20,%al
  10511c:	74 e2                	je     105100 <uartputc+0x20>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  10511e:	ba f8 03 00 00       	mov    $0x3f8,%edx
  105123:	8b 45 08             	mov    0x8(%ebp),%eax
  105126:	ee                   	out    %al,(%dx)
    microdelay(10);
  outb(COM1+0, c);
}
  105127:	83 c4 10             	add    $0x10,%esp
  10512a:	5b                   	pop    %ebx
  10512b:	5e                   	pop    %esi
  10512c:	5d                   	pop    %ebp
  10512d:	c3                   	ret    
  10512e:	66 90                	xchg   %ax,%ax

00105130 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
  105130:	55                   	push   %ebp
  105131:	31 c9                	xor    %ecx,%ecx
  105133:	89 e5                	mov    %esp,%ebp
  105135:	89 c8                	mov    %ecx,%eax
  105137:	57                   	push   %edi
  105138:	bf fa 03 00 00       	mov    $0x3fa,%edi
  10513d:	56                   	push   %esi
  10513e:	89 fa                	mov    %edi,%edx
  105140:	53                   	push   %ebx
  105141:	83 ec 1c             	sub    $0x1c,%esp
  105144:	ee                   	out    %al,(%dx)
  105145:	bb fb 03 00 00       	mov    $0x3fb,%ebx
  10514a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
  10514f:	89 da                	mov    %ebx,%edx
  105151:	ee                   	out    %al,(%dx)
  105152:	b8 0c 00 00 00       	mov    $0xc,%eax
  105157:	b2 f8                	mov    $0xf8,%dl
  105159:	ee                   	out    %al,(%dx)
  10515a:	be f9 03 00 00       	mov    $0x3f9,%esi
  10515f:	89 c8                	mov    %ecx,%eax
  105161:	89 f2                	mov    %esi,%edx
  105163:	ee                   	out    %al,(%dx)
  105164:	b8 03 00 00 00       	mov    $0x3,%eax
  105169:	89 da                	mov    %ebx,%edx
  10516b:	ee                   	out    %al,(%dx)
  10516c:	b2 fc                	mov    $0xfc,%dl
  10516e:	89 c8                	mov    %ecx,%eax
  105170:	ee                   	out    %al,(%dx)
  105171:	b8 01 00 00 00       	mov    $0x1,%eax
  105176:	89 f2                	mov    %esi,%edx
  105178:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  105179:	b2 fd                	mov    $0xfd,%dl
  10517b:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
  10517c:	3c ff                	cmp    $0xff,%al
  10517e:	74 55                	je     1051d5 <uartinit+0xa5>
    return;
  uart = 1;
  105180:	c7 05 4c 78 10 00 01 	movl   $0x1,0x10784c
  105187:	00 00 00 
  10518a:	89 fa                	mov    %edi,%edx
  10518c:	ec                   	in     (%dx),%al
  10518d:	b2 f8                	mov    $0xf8,%dl
  10518f:	ec                   	in     (%dx),%al
  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);
  105190:	bb d0 6c 10 00       	mov    $0x106cd0,%ebx

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  picenable(IRQ_COM1);
  105195:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  10519c:	e8 df d9 ff ff       	call   102b80 <picenable>
  ioapicenable(IRQ_COM1, 0);
  1051a1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1051a8:	00 
  1051a9:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  1051b0:	e8 8b cf ff ff       	call   102140 <ioapicenable>
  1051b5:	b8 78 00 00 00       	mov    $0x78,%eax
  1051ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
  1051c0:	0f be c0             	movsbl %al,%eax
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
  1051c3:	83 c3 01             	add    $0x1,%ebx
    uartputc(*p);
  1051c6:	89 04 24             	mov    %eax,(%esp)
  1051c9:	e8 12 ff ff ff       	call   1050e0 <uartputc>
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
  1051ce:	0f b6 03             	movzbl (%ebx),%eax
  1051d1:	84 c0                	test   %al,%al
  1051d3:	75 eb                	jne    1051c0 <uartinit+0x90>
    uartputc(*p);
}
  1051d5:	83 c4 1c             	add    $0x1c,%esp
  1051d8:	5b                   	pop    %ebx
  1051d9:	5e                   	pop    %esi
  1051da:	5f                   	pop    %edi
  1051db:	5d                   	pop    %ebp
  1051dc:	c3                   	ret    
  1051dd:	90                   	nop
  1051de:	90                   	nop
  1051df:	90                   	nop

001051e0 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
  1051e0:	6a 00                	push   $0x0
  pushl $0
  1051e2:	6a 00                	push   $0x0
  jmp alltraps
  1051e4:	e9 47 fb ff ff       	jmp    104d30 <alltraps>

001051e9 <vector1>:
.globl vector1
vector1:
  pushl $0
  1051e9:	6a 00                	push   $0x0
  pushl $1
  1051eb:	6a 01                	push   $0x1
  jmp alltraps
  1051ed:	e9 3e fb ff ff       	jmp    104d30 <alltraps>

001051f2 <vector2>:
.globl vector2
vector2:
  pushl $0
  1051f2:	6a 00                	push   $0x0
  pushl $2
  1051f4:	6a 02                	push   $0x2
  jmp alltraps
  1051f6:	e9 35 fb ff ff       	jmp    104d30 <alltraps>

001051fb <vector3>:
.globl vector3
vector3:
  pushl $0
  1051fb:	6a 00                	push   $0x0
  pushl $3
  1051fd:	6a 03                	push   $0x3
  jmp alltraps
  1051ff:	e9 2c fb ff ff       	jmp    104d30 <alltraps>

00105204 <vector4>:
.globl vector4
vector4:
  pushl $0
  105204:	6a 00                	push   $0x0
  pushl $4
  105206:	6a 04                	push   $0x4
  jmp alltraps
  105208:	e9 23 fb ff ff       	jmp    104d30 <alltraps>

0010520d <vector5>:
.globl vector5
vector5:
  pushl $0
  10520d:	6a 00                	push   $0x0
  pushl $5
  10520f:	6a 05                	push   $0x5
  jmp alltraps
  105211:	e9 1a fb ff ff       	jmp    104d30 <alltraps>

00105216 <vector6>:
.globl vector6
vector6:
  pushl $0
  105216:	6a 00                	push   $0x0
  pushl $6
  105218:	6a 06                	push   $0x6
  jmp alltraps
  10521a:	e9 11 fb ff ff       	jmp    104d30 <alltraps>

0010521f <vector7>:
.globl vector7
vector7:
  pushl $0
  10521f:	6a 00                	push   $0x0
  pushl $7
  105221:	6a 07                	push   $0x7
  jmp alltraps
  105223:	e9 08 fb ff ff       	jmp    104d30 <alltraps>

00105228 <vector8>:
.globl vector8
vector8:
  pushl $8
  105228:	6a 08                	push   $0x8
  jmp alltraps
  10522a:	e9 01 fb ff ff       	jmp    104d30 <alltraps>

0010522f <vector9>:
.globl vector9
vector9:
  pushl $0
  10522f:	6a 00                	push   $0x0
  pushl $9
  105231:	6a 09                	push   $0x9
  jmp alltraps
  105233:	e9 f8 fa ff ff       	jmp    104d30 <alltraps>

00105238 <vector10>:
.globl vector10
vector10:
  pushl $10
  105238:	6a 0a                	push   $0xa
  jmp alltraps
  10523a:	e9 f1 fa ff ff       	jmp    104d30 <alltraps>

0010523f <vector11>:
.globl vector11
vector11:
  pushl $11
  10523f:	6a 0b                	push   $0xb
  jmp alltraps
  105241:	e9 ea fa ff ff       	jmp    104d30 <alltraps>

00105246 <vector12>:
.globl vector12
vector12:
  pushl $12
  105246:	6a 0c                	push   $0xc
  jmp alltraps
  105248:	e9 e3 fa ff ff       	jmp    104d30 <alltraps>

0010524d <vector13>:
.globl vector13
vector13:
  pushl $13
  10524d:	6a 0d                	push   $0xd
  jmp alltraps
  10524f:	e9 dc fa ff ff       	jmp    104d30 <alltraps>

00105254 <vector14>:
.globl vector14
vector14:
  pushl $14
  105254:	6a 0e                	push   $0xe
  jmp alltraps
  105256:	e9 d5 fa ff ff       	jmp    104d30 <alltraps>

0010525b <vector15>:
.globl vector15
vector15:
  pushl $0
  10525b:	6a 00                	push   $0x0
  pushl $15
  10525d:	6a 0f                	push   $0xf
  jmp alltraps
  10525f:	e9 cc fa ff ff       	jmp    104d30 <alltraps>

00105264 <vector16>:
.globl vector16
vector16:
  pushl $0
  105264:	6a 00                	push   $0x0
  pushl $16
  105266:	6a 10                	push   $0x10
  jmp alltraps
  105268:	e9 c3 fa ff ff       	jmp    104d30 <alltraps>

0010526d <vector17>:
.globl vector17
vector17:
  pushl $17
  10526d:	6a 11                	push   $0x11
  jmp alltraps
  10526f:	e9 bc fa ff ff       	jmp    104d30 <alltraps>

00105274 <vector18>:
.globl vector18
vector18:
  pushl $0
  105274:	6a 00                	push   $0x0
  pushl $18
  105276:	6a 12                	push   $0x12
  jmp alltraps
  105278:	e9 b3 fa ff ff       	jmp    104d30 <alltraps>

0010527d <vector19>:
.globl vector19
vector19:
  pushl $0
  10527d:	6a 00                	push   $0x0
  pushl $19
  10527f:	6a 13                	push   $0x13
  jmp alltraps
  105281:	e9 aa fa ff ff       	jmp    104d30 <alltraps>

00105286 <vector20>:
.globl vector20
vector20:
  pushl $0
  105286:	6a 00                	push   $0x0
  pushl $20
  105288:	6a 14                	push   $0x14
  jmp alltraps
  10528a:	e9 a1 fa ff ff       	jmp    104d30 <alltraps>

0010528f <vector21>:
.globl vector21
vector21:
  pushl $0
  10528f:	6a 00                	push   $0x0
  pushl $21
  105291:	6a 15                	push   $0x15
  jmp alltraps
  105293:	e9 98 fa ff ff       	jmp    104d30 <alltraps>

00105298 <vector22>:
.globl vector22
vector22:
  pushl $0
  105298:	6a 00                	push   $0x0
  pushl $22
  10529a:	6a 16                	push   $0x16
  jmp alltraps
  10529c:	e9 8f fa ff ff       	jmp    104d30 <alltraps>

001052a1 <vector23>:
.globl vector23
vector23:
  pushl $0
  1052a1:	6a 00                	push   $0x0
  pushl $23
  1052a3:	6a 17                	push   $0x17
  jmp alltraps
  1052a5:	e9 86 fa ff ff       	jmp    104d30 <alltraps>

001052aa <vector24>:
.globl vector24
vector24:
  pushl $0
  1052aa:	6a 00                	push   $0x0
  pushl $24
  1052ac:	6a 18                	push   $0x18
  jmp alltraps
  1052ae:	e9 7d fa ff ff       	jmp    104d30 <alltraps>

001052b3 <vector25>:
.globl vector25
vector25:
  pushl $0
  1052b3:	6a 00                	push   $0x0
  pushl $25
  1052b5:	6a 19                	push   $0x19
  jmp alltraps
  1052b7:	e9 74 fa ff ff       	jmp    104d30 <alltraps>

001052bc <vector26>:
.globl vector26
vector26:
  pushl $0
  1052bc:	6a 00                	push   $0x0
  pushl $26
  1052be:	6a 1a                	push   $0x1a
  jmp alltraps
  1052c0:	e9 6b fa ff ff       	jmp    104d30 <alltraps>

001052c5 <vector27>:
.globl vector27
vector27:
  pushl $0
  1052c5:	6a 00                	push   $0x0
  pushl $27
  1052c7:	6a 1b                	push   $0x1b
  jmp alltraps
  1052c9:	e9 62 fa ff ff       	jmp    104d30 <alltraps>

001052ce <vector28>:
.globl vector28
vector28:
  pushl $0
  1052ce:	6a 00                	push   $0x0
  pushl $28
  1052d0:	6a 1c                	push   $0x1c
  jmp alltraps
  1052d2:	e9 59 fa ff ff       	jmp    104d30 <alltraps>

001052d7 <vector29>:
.globl vector29
vector29:
  pushl $0
  1052d7:	6a 00                	push   $0x0
  pushl $29
  1052d9:	6a 1d                	push   $0x1d
  jmp alltraps
  1052db:	e9 50 fa ff ff       	jmp    104d30 <alltraps>

001052e0 <vector30>:
.globl vector30
vector30:
  pushl $0
  1052e0:	6a 00                	push   $0x0
  pushl $30
  1052e2:	6a 1e                	push   $0x1e
  jmp alltraps
  1052e4:	e9 47 fa ff ff       	jmp    104d30 <alltraps>

001052e9 <vector31>:
.globl vector31
vector31:
  pushl $0
  1052e9:	6a 00                	push   $0x0
  pushl $31
  1052eb:	6a 1f                	push   $0x1f
  jmp alltraps
  1052ed:	e9 3e fa ff ff       	jmp    104d30 <alltraps>

001052f2 <vector32>:
.globl vector32
vector32:
  pushl $0
  1052f2:	6a 00                	push   $0x0
  pushl $32
  1052f4:	6a 20                	push   $0x20
  jmp alltraps
  1052f6:	e9 35 fa ff ff       	jmp    104d30 <alltraps>

001052fb <vector33>:
.globl vector33
vector33:
  pushl $0
  1052fb:	6a 00                	push   $0x0
  pushl $33
  1052fd:	6a 21                	push   $0x21
  jmp alltraps
  1052ff:	e9 2c fa ff ff       	jmp    104d30 <alltraps>

00105304 <vector34>:
.globl vector34
vector34:
  pushl $0
  105304:	6a 00                	push   $0x0
  pushl $34
  105306:	6a 22                	push   $0x22
  jmp alltraps
  105308:	e9 23 fa ff ff       	jmp    104d30 <alltraps>

0010530d <vector35>:
.globl vector35
vector35:
  pushl $0
  10530d:	6a 00                	push   $0x0
  pushl $35
  10530f:	6a 23                	push   $0x23
  jmp alltraps
  105311:	e9 1a fa ff ff       	jmp    104d30 <alltraps>

00105316 <vector36>:
.globl vector36
vector36:
  pushl $0
  105316:	6a 00                	push   $0x0
  pushl $36
  105318:	6a 24                	push   $0x24
  jmp alltraps
  10531a:	e9 11 fa ff ff       	jmp    104d30 <alltraps>

0010531f <vector37>:
.globl vector37
vector37:
  pushl $0
  10531f:	6a 00                	push   $0x0
  pushl $37
  105321:	6a 25                	push   $0x25
  jmp alltraps
  105323:	e9 08 fa ff ff       	jmp    104d30 <alltraps>

00105328 <vector38>:
.globl vector38
vector38:
  pushl $0
  105328:	6a 00                	push   $0x0
  pushl $38
  10532a:	6a 26                	push   $0x26
  jmp alltraps
  10532c:	e9 ff f9 ff ff       	jmp    104d30 <alltraps>

00105331 <vector39>:
.globl vector39
vector39:
  pushl $0
  105331:	6a 00                	push   $0x0
  pushl $39
  105333:	6a 27                	push   $0x27
  jmp alltraps
  105335:	e9 f6 f9 ff ff       	jmp    104d30 <alltraps>

0010533a <vector40>:
.globl vector40
vector40:
  pushl $0
  10533a:	6a 00                	push   $0x0
  pushl $40
  10533c:	6a 28                	push   $0x28
  jmp alltraps
  10533e:	e9 ed f9 ff ff       	jmp    104d30 <alltraps>

00105343 <vector41>:
.globl vector41
vector41:
  pushl $0
  105343:	6a 00                	push   $0x0
  pushl $41
  105345:	6a 29                	push   $0x29
  jmp alltraps
  105347:	e9 e4 f9 ff ff       	jmp    104d30 <alltraps>

0010534c <vector42>:
.globl vector42
vector42:
  pushl $0
  10534c:	6a 00                	push   $0x0
  pushl $42
  10534e:	6a 2a                	push   $0x2a
  jmp alltraps
  105350:	e9 db f9 ff ff       	jmp    104d30 <alltraps>

00105355 <vector43>:
.globl vector43
vector43:
  pushl $0
  105355:	6a 00                	push   $0x0
  pushl $43
  105357:	6a 2b                	push   $0x2b
  jmp alltraps
  105359:	e9 d2 f9 ff ff       	jmp    104d30 <alltraps>

0010535e <vector44>:
.globl vector44
vector44:
  pushl $0
  10535e:	6a 00                	push   $0x0
  pushl $44
  105360:	6a 2c                	push   $0x2c
  jmp alltraps
  105362:	e9 c9 f9 ff ff       	jmp    104d30 <alltraps>

00105367 <vector45>:
.globl vector45
vector45:
  pushl $0
  105367:	6a 00                	push   $0x0
  pushl $45
  105369:	6a 2d                	push   $0x2d
  jmp alltraps
  10536b:	e9 c0 f9 ff ff       	jmp    104d30 <alltraps>

00105370 <vector46>:
.globl vector46
vector46:
  pushl $0
  105370:	6a 00                	push   $0x0
  pushl $46
  105372:	6a 2e                	push   $0x2e
  jmp alltraps
  105374:	e9 b7 f9 ff ff       	jmp    104d30 <alltraps>

00105379 <vector47>:
.globl vector47
vector47:
  pushl $0
  105379:	6a 00                	push   $0x0
  pushl $47
  10537b:	6a 2f                	push   $0x2f
  jmp alltraps
  10537d:	e9 ae f9 ff ff       	jmp    104d30 <alltraps>

00105382 <vector48>:
.globl vector48
vector48:
  pushl $0
  105382:	6a 00                	push   $0x0
  pushl $48
  105384:	6a 30                	push   $0x30
  jmp alltraps
  105386:	e9 a5 f9 ff ff       	jmp    104d30 <alltraps>

0010538b <vector49>:
.globl vector49
vector49:
  pushl $0
  10538b:	6a 00                	push   $0x0
  pushl $49
  10538d:	6a 31                	push   $0x31
  jmp alltraps
  10538f:	e9 9c f9 ff ff       	jmp    104d30 <alltraps>

00105394 <vector50>:
.globl vector50
vector50:
  pushl $0
  105394:	6a 00                	push   $0x0
  pushl $50
  105396:	6a 32                	push   $0x32
  jmp alltraps
  105398:	e9 93 f9 ff ff       	jmp    104d30 <alltraps>

0010539d <vector51>:
.globl vector51
vector51:
  pushl $0
  10539d:	6a 00                	push   $0x0
  pushl $51
  10539f:	6a 33                	push   $0x33
  jmp alltraps
  1053a1:	e9 8a f9 ff ff       	jmp    104d30 <alltraps>

001053a6 <vector52>:
.globl vector52
vector52:
  pushl $0
  1053a6:	6a 00                	push   $0x0
  pushl $52
  1053a8:	6a 34                	push   $0x34
  jmp alltraps
  1053aa:	e9 81 f9 ff ff       	jmp    104d30 <alltraps>

001053af <vector53>:
.globl vector53
vector53:
  pushl $0
  1053af:	6a 00                	push   $0x0
  pushl $53
  1053b1:	6a 35                	push   $0x35
  jmp alltraps
  1053b3:	e9 78 f9 ff ff       	jmp    104d30 <alltraps>

001053b8 <vector54>:
.globl vector54
vector54:
  pushl $0
  1053b8:	6a 00                	push   $0x0
  pushl $54
  1053ba:	6a 36                	push   $0x36
  jmp alltraps
  1053bc:	e9 6f f9 ff ff       	jmp    104d30 <alltraps>

001053c1 <vector55>:
.globl vector55
vector55:
  pushl $0
  1053c1:	6a 00                	push   $0x0
  pushl $55
  1053c3:	6a 37                	push   $0x37
  jmp alltraps
  1053c5:	e9 66 f9 ff ff       	jmp    104d30 <alltraps>

001053ca <vector56>:
.globl vector56
vector56:
  pushl $0
  1053ca:	6a 00                	push   $0x0
  pushl $56
  1053cc:	6a 38                	push   $0x38
  jmp alltraps
  1053ce:	e9 5d f9 ff ff       	jmp    104d30 <alltraps>

001053d3 <vector57>:
.globl vector57
vector57:
  pushl $0
  1053d3:	6a 00                	push   $0x0
  pushl $57
  1053d5:	6a 39                	push   $0x39
  jmp alltraps
  1053d7:	e9 54 f9 ff ff       	jmp    104d30 <alltraps>

001053dc <vector58>:
.globl vector58
vector58:
  pushl $0
  1053dc:	6a 00                	push   $0x0
  pushl $58
  1053de:	6a 3a                	push   $0x3a
  jmp alltraps
  1053e0:	e9 4b f9 ff ff       	jmp    104d30 <alltraps>

001053e5 <vector59>:
.globl vector59
vector59:
  pushl $0
  1053e5:	6a 00                	push   $0x0
  pushl $59
  1053e7:	6a 3b                	push   $0x3b
  jmp alltraps
  1053e9:	e9 42 f9 ff ff       	jmp    104d30 <alltraps>

001053ee <vector60>:
.globl vector60
vector60:
  pushl $0
  1053ee:	6a 00                	push   $0x0
  pushl $60
  1053f0:	6a 3c                	push   $0x3c
  jmp alltraps
  1053f2:	e9 39 f9 ff ff       	jmp    104d30 <alltraps>

001053f7 <vector61>:
.globl vector61
vector61:
  pushl $0
  1053f7:	6a 00                	push   $0x0
  pushl $61
  1053f9:	6a 3d                	push   $0x3d
  jmp alltraps
  1053fb:	e9 30 f9 ff ff       	jmp    104d30 <alltraps>

00105400 <vector62>:
.globl vector62
vector62:
  pushl $0
  105400:	6a 00                	push   $0x0
  pushl $62
  105402:	6a 3e                	push   $0x3e
  jmp alltraps
  105404:	e9 27 f9 ff ff       	jmp    104d30 <alltraps>

00105409 <vector63>:
.globl vector63
vector63:
  pushl $0
  105409:	6a 00                	push   $0x0
  pushl $63
  10540b:	6a 3f                	push   $0x3f
  jmp alltraps
  10540d:	e9 1e f9 ff ff       	jmp    104d30 <alltraps>

00105412 <vector64>:
.globl vector64
vector64:
  pushl $0
  105412:	6a 00                	push   $0x0
  pushl $64
  105414:	6a 40                	push   $0x40
  jmp alltraps
  105416:	e9 15 f9 ff ff       	jmp    104d30 <alltraps>

0010541b <vector65>:
.globl vector65
vector65:
  pushl $0
  10541b:	6a 00                	push   $0x0
  pushl $65
  10541d:	6a 41                	push   $0x41
  jmp alltraps
  10541f:	e9 0c f9 ff ff       	jmp    104d30 <alltraps>

00105424 <vector66>:
.globl vector66
vector66:
  pushl $0
  105424:	6a 00                	push   $0x0
  pushl $66
  105426:	6a 42                	push   $0x42
  jmp alltraps
  105428:	e9 03 f9 ff ff       	jmp    104d30 <alltraps>

0010542d <vector67>:
.globl vector67
vector67:
  pushl $0
  10542d:	6a 00                	push   $0x0
  pushl $67
  10542f:	6a 43                	push   $0x43
  jmp alltraps
  105431:	e9 fa f8 ff ff       	jmp    104d30 <alltraps>

00105436 <vector68>:
.globl vector68
vector68:
  pushl $0
  105436:	6a 00                	push   $0x0
  pushl $68
  105438:	6a 44                	push   $0x44
  jmp alltraps
  10543a:	e9 f1 f8 ff ff       	jmp    104d30 <alltraps>

0010543f <vector69>:
.globl vector69
vector69:
  pushl $0
  10543f:	6a 00                	push   $0x0
  pushl $69
  105441:	6a 45                	push   $0x45
  jmp alltraps
  105443:	e9 e8 f8 ff ff       	jmp    104d30 <alltraps>

00105448 <vector70>:
.globl vector70
vector70:
  pushl $0
  105448:	6a 00                	push   $0x0
  pushl $70
  10544a:	6a 46                	push   $0x46
  jmp alltraps
  10544c:	e9 df f8 ff ff       	jmp    104d30 <alltraps>

00105451 <vector71>:
.globl vector71
vector71:
  pushl $0
  105451:	6a 00                	push   $0x0
  pushl $71
  105453:	6a 47                	push   $0x47
  jmp alltraps
  105455:	e9 d6 f8 ff ff       	jmp    104d30 <alltraps>

0010545a <vector72>:
.globl vector72
vector72:
  pushl $0
  10545a:	6a 00                	push   $0x0
  pushl $72
  10545c:	6a 48                	push   $0x48
  jmp alltraps
  10545e:	e9 cd f8 ff ff       	jmp    104d30 <alltraps>

00105463 <vector73>:
.globl vector73
vector73:
  pushl $0
  105463:	6a 00                	push   $0x0
  pushl $73
  105465:	6a 49                	push   $0x49
  jmp alltraps
  105467:	e9 c4 f8 ff ff       	jmp    104d30 <alltraps>

0010546c <vector74>:
.globl vector74
vector74:
  pushl $0
  10546c:	6a 00                	push   $0x0
  pushl $74
  10546e:	6a 4a                	push   $0x4a
  jmp alltraps
  105470:	e9 bb f8 ff ff       	jmp    104d30 <alltraps>

00105475 <vector75>:
.globl vector75
vector75:
  pushl $0
  105475:	6a 00                	push   $0x0
  pushl $75
  105477:	6a 4b                	push   $0x4b
  jmp alltraps
  105479:	e9 b2 f8 ff ff       	jmp    104d30 <alltraps>

0010547e <vector76>:
.globl vector76
vector76:
  pushl $0
  10547e:	6a 00                	push   $0x0
  pushl $76
  105480:	6a 4c                	push   $0x4c
  jmp alltraps
  105482:	e9 a9 f8 ff ff       	jmp    104d30 <alltraps>

00105487 <vector77>:
.globl vector77
vector77:
  pushl $0
  105487:	6a 00                	push   $0x0
  pushl $77
  105489:	6a 4d                	push   $0x4d
  jmp alltraps
  10548b:	e9 a0 f8 ff ff       	jmp    104d30 <alltraps>

00105490 <vector78>:
.globl vector78
vector78:
  pushl $0
  105490:	6a 00                	push   $0x0
  pushl $78
  105492:	6a 4e                	push   $0x4e
  jmp alltraps
  105494:	e9 97 f8 ff ff       	jmp    104d30 <alltraps>

00105499 <vector79>:
.globl vector79
vector79:
  pushl $0
  105499:	6a 00                	push   $0x0
  pushl $79
  10549b:	6a 4f                	push   $0x4f
  jmp alltraps
  10549d:	e9 8e f8 ff ff       	jmp    104d30 <alltraps>

001054a2 <vector80>:
.globl vector80
vector80:
  pushl $0
  1054a2:	6a 00                	push   $0x0
  pushl $80
  1054a4:	6a 50                	push   $0x50
  jmp alltraps
  1054a6:	e9 85 f8 ff ff       	jmp    104d30 <alltraps>

001054ab <vector81>:
.globl vector81
vector81:
  pushl $0
  1054ab:	6a 00                	push   $0x0
  pushl $81
  1054ad:	6a 51                	push   $0x51
  jmp alltraps
  1054af:	e9 7c f8 ff ff       	jmp    104d30 <alltraps>

001054b4 <vector82>:
.globl vector82
vector82:
  pushl $0
  1054b4:	6a 00                	push   $0x0
  pushl $82
  1054b6:	6a 52                	push   $0x52
  jmp alltraps
  1054b8:	e9 73 f8 ff ff       	jmp    104d30 <alltraps>

001054bd <vector83>:
.globl vector83
vector83:
  pushl $0
  1054bd:	6a 00                	push   $0x0
  pushl $83
  1054bf:	6a 53                	push   $0x53
  jmp alltraps
  1054c1:	e9 6a f8 ff ff       	jmp    104d30 <alltraps>

001054c6 <vector84>:
.globl vector84
vector84:
  pushl $0
  1054c6:	6a 00                	push   $0x0
  pushl $84
  1054c8:	6a 54                	push   $0x54
  jmp alltraps
  1054ca:	e9 61 f8 ff ff       	jmp    104d30 <alltraps>

001054cf <vector85>:
.globl vector85
vector85:
  pushl $0
  1054cf:	6a 00                	push   $0x0
  pushl $85
  1054d1:	6a 55                	push   $0x55
  jmp alltraps
  1054d3:	e9 58 f8 ff ff       	jmp    104d30 <alltraps>

001054d8 <vector86>:
.globl vector86
vector86:
  pushl $0
  1054d8:	6a 00                	push   $0x0
  pushl $86
  1054da:	6a 56                	push   $0x56
  jmp alltraps
  1054dc:	e9 4f f8 ff ff       	jmp    104d30 <alltraps>

001054e1 <vector87>:
.globl vector87
vector87:
  pushl $0
  1054e1:	6a 00                	push   $0x0
  pushl $87
  1054e3:	6a 57                	push   $0x57
  jmp alltraps
  1054e5:	e9 46 f8 ff ff       	jmp    104d30 <alltraps>

001054ea <vector88>:
.globl vector88
vector88:
  pushl $0
  1054ea:	6a 00                	push   $0x0
  pushl $88
  1054ec:	6a 58                	push   $0x58
  jmp alltraps
  1054ee:	e9 3d f8 ff ff       	jmp    104d30 <alltraps>

001054f3 <vector89>:
.globl vector89
vector89:
  pushl $0
  1054f3:	6a 00                	push   $0x0
  pushl $89
  1054f5:	6a 59                	push   $0x59
  jmp alltraps
  1054f7:	e9 34 f8 ff ff       	jmp    104d30 <alltraps>

001054fc <vector90>:
.globl vector90
vector90:
  pushl $0
  1054fc:	6a 00                	push   $0x0
  pushl $90
  1054fe:	6a 5a                	push   $0x5a
  jmp alltraps
  105500:	e9 2b f8 ff ff       	jmp    104d30 <alltraps>

00105505 <vector91>:
.globl vector91
vector91:
  pushl $0
  105505:	6a 00                	push   $0x0
  pushl $91
  105507:	6a 5b                	push   $0x5b
  jmp alltraps
  105509:	e9 22 f8 ff ff       	jmp    104d30 <alltraps>

0010550e <vector92>:
.globl vector92
vector92:
  pushl $0
  10550e:	6a 00                	push   $0x0
  pushl $92
  105510:	6a 5c                	push   $0x5c
  jmp alltraps
  105512:	e9 19 f8 ff ff       	jmp    104d30 <alltraps>

00105517 <vector93>:
.globl vector93
vector93:
  pushl $0
  105517:	6a 00                	push   $0x0
  pushl $93
  105519:	6a 5d                	push   $0x5d
  jmp alltraps
  10551b:	e9 10 f8 ff ff       	jmp    104d30 <alltraps>

00105520 <vector94>:
.globl vector94
vector94:
  pushl $0
  105520:	6a 00                	push   $0x0
  pushl $94
  105522:	6a 5e                	push   $0x5e
  jmp alltraps
  105524:	e9 07 f8 ff ff       	jmp    104d30 <alltraps>

00105529 <vector95>:
.globl vector95
vector95:
  pushl $0
  105529:	6a 00                	push   $0x0
  pushl $95
  10552b:	6a 5f                	push   $0x5f
  jmp alltraps
  10552d:	e9 fe f7 ff ff       	jmp    104d30 <alltraps>

00105532 <vector96>:
.globl vector96
vector96:
  pushl $0
  105532:	6a 00                	push   $0x0
  pushl $96
  105534:	6a 60                	push   $0x60
  jmp alltraps
  105536:	e9 f5 f7 ff ff       	jmp    104d30 <alltraps>

0010553b <vector97>:
.globl vector97
vector97:
  pushl $0
  10553b:	6a 00                	push   $0x0
  pushl $97
  10553d:	6a 61                	push   $0x61
  jmp alltraps
  10553f:	e9 ec f7 ff ff       	jmp    104d30 <alltraps>

00105544 <vector98>:
.globl vector98
vector98:
  pushl $0
  105544:	6a 00                	push   $0x0
  pushl $98
  105546:	6a 62                	push   $0x62
  jmp alltraps
  105548:	e9 e3 f7 ff ff       	jmp    104d30 <alltraps>

0010554d <vector99>:
.globl vector99
vector99:
  pushl $0
  10554d:	6a 00                	push   $0x0
  pushl $99
  10554f:	6a 63                	push   $0x63
  jmp alltraps
  105551:	e9 da f7 ff ff       	jmp    104d30 <alltraps>

00105556 <vector100>:
.globl vector100
vector100:
  pushl $0
  105556:	6a 00                	push   $0x0
  pushl $100
  105558:	6a 64                	push   $0x64
  jmp alltraps
  10555a:	e9 d1 f7 ff ff       	jmp    104d30 <alltraps>

0010555f <vector101>:
.globl vector101
vector101:
  pushl $0
  10555f:	6a 00                	push   $0x0
  pushl $101
  105561:	6a 65                	push   $0x65
  jmp alltraps
  105563:	e9 c8 f7 ff ff       	jmp    104d30 <alltraps>

00105568 <vector102>:
.globl vector102
vector102:
  pushl $0
  105568:	6a 00                	push   $0x0
  pushl $102
  10556a:	6a 66                	push   $0x66
  jmp alltraps
  10556c:	e9 bf f7 ff ff       	jmp    104d30 <alltraps>

00105571 <vector103>:
.globl vector103
vector103:
  pushl $0
  105571:	6a 00                	push   $0x0
  pushl $103
  105573:	6a 67                	push   $0x67
  jmp alltraps
  105575:	e9 b6 f7 ff ff       	jmp    104d30 <alltraps>

0010557a <vector104>:
.globl vector104
vector104:
  pushl $0
  10557a:	6a 00                	push   $0x0
  pushl $104
  10557c:	6a 68                	push   $0x68
  jmp alltraps
  10557e:	e9 ad f7 ff ff       	jmp    104d30 <alltraps>

00105583 <vector105>:
.globl vector105
vector105:
  pushl $0
  105583:	6a 00                	push   $0x0
  pushl $105
  105585:	6a 69                	push   $0x69
  jmp alltraps
  105587:	e9 a4 f7 ff ff       	jmp    104d30 <alltraps>

0010558c <vector106>:
.globl vector106
vector106:
  pushl $0
  10558c:	6a 00                	push   $0x0
  pushl $106
  10558e:	6a 6a                	push   $0x6a
  jmp alltraps
  105590:	e9 9b f7 ff ff       	jmp    104d30 <alltraps>

00105595 <vector107>:
.globl vector107
vector107:
  pushl $0
  105595:	6a 00                	push   $0x0
  pushl $107
  105597:	6a 6b                	push   $0x6b
  jmp alltraps
  105599:	e9 92 f7 ff ff       	jmp    104d30 <alltraps>

0010559e <vector108>:
.globl vector108
vector108:
  pushl $0
  10559e:	6a 00                	push   $0x0
  pushl $108
  1055a0:	6a 6c                	push   $0x6c
  jmp alltraps
  1055a2:	e9 89 f7 ff ff       	jmp    104d30 <alltraps>

001055a7 <vector109>:
.globl vector109
vector109:
  pushl $0
  1055a7:	6a 00                	push   $0x0
  pushl $109
  1055a9:	6a 6d                	push   $0x6d
  jmp alltraps
  1055ab:	e9 80 f7 ff ff       	jmp    104d30 <alltraps>

001055b0 <vector110>:
.globl vector110
vector110:
  pushl $0
  1055b0:	6a 00                	push   $0x0
  pushl $110
  1055b2:	6a 6e                	push   $0x6e
  jmp alltraps
  1055b4:	e9 77 f7 ff ff       	jmp    104d30 <alltraps>

001055b9 <vector111>:
.globl vector111
vector111:
  pushl $0
  1055b9:	6a 00                	push   $0x0
  pushl $111
  1055bb:	6a 6f                	push   $0x6f
  jmp alltraps
  1055bd:	e9 6e f7 ff ff       	jmp    104d30 <alltraps>

001055c2 <vector112>:
.globl vector112
vector112:
  pushl $0
  1055c2:	6a 00                	push   $0x0
  pushl $112
  1055c4:	6a 70                	push   $0x70
  jmp alltraps
  1055c6:	e9 65 f7 ff ff       	jmp    104d30 <alltraps>

001055cb <vector113>:
.globl vector113
vector113:
  pushl $0
  1055cb:	6a 00                	push   $0x0
  pushl $113
  1055cd:	6a 71                	push   $0x71
  jmp alltraps
  1055cf:	e9 5c f7 ff ff       	jmp    104d30 <alltraps>

001055d4 <vector114>:
.globl vector114
vector114:
  pushl $0
  1055d4:	6a 00                	push   $0x0
  pushl $114
  1055d6:	6a 72                	push   $0x72
  jmp alltraps
  1055d8:	e9 53 f7 ff ff       	jmp    104d30 <alltraps>

001055dd <vector115>:
.globl vector115
vector115:
  pushl $0
  1055dd:	6a 00                	push   $0x0
  pushl $115
  1055df:	6a 73                	push   $0x73
  jmp alltraps
  1055e1:	e9 4a f7 ff ff       	jmp    104d30 <alltraps>

001055e6 <vector116>:
.globl vector116
vector116:
  pushl $0
  1055e6:	6a 00                	push   $0x0
  pushl $116
  1055e8:	6a 74                	push   $0x74
  jmp alltraps
  1055ea:	e9 41 f7 ff ff       	jmp    104d30 <alltraps>

001055ef <vector117>:
.globl vector117
vector117:
  pushl $0
  1055ef:	6a 00                	push   $0x0
  pushl $117
  1055f1:	6a 75                	push   $0x75
  jmp alltraps
  1055f3:	e9 38 f7 ff ff       	jmp    104d30 <alltraps>

001055f8 <vector118>:
.globl vector118
vector118:
  pushl $0
  1055f8:	6a 00                	push   $0x0
  pushl $118
  1055fa:	6a 76                	push   $0x76
  jmp alltraps
  1055fc:	e9 2f f7 ff ff       	jmp    104d30 <alltraps>

00105601 <vector119>:
.globl vector119
vector119:
  pushl $0
  105601:	6a 00                	push   $0x0
  pushl $119
  105603:	6a 77                	push   $0x77
  jmp alltraps
  105605:	e9 26 f7 ff ff       	jmp    104d30 <alltraps>

0010560a <vector120>:
.globl vector120
vector120:
  pushl $0
  10560a:	6a 00                	push   $0x0
  pushl $120
  10560c:	6a 78                	push   $0x78
  jmp alltraps
  10560e:	e9 1d f7 ff ff       	jmp    104d30 <alltraps>

00105613 <vector121>:
.globl vector121
vector121:
  pushl $0
  105613:	6a 00                	push   $0x0
  pushl $121
  105615:	6a 79                	push   $0x79
  jmp alltraps
  105617:	e9 14 f7 ff ff       	jmp    104d30 <alltraps>

0010561c <vector122>:
.globl vector122
vector122:
  pushl $0
  10561c:	6a 00                	push   $0x0
  pushl $122
  10561e:	6a 7a                	push   $0x7a
  jmp alltraps
  105620:	e9 0b f7 ff ff       	jmp    104d30 <alltraps>

00105625 <vector123>:
.globl vector123
vector123:
  pushl $0
  105625:	6a 00                	push   $0x0
  pushl $123
  105627:	6a 7b                	push   $0x7b
  jmp alltraps
  105629:	e9 02 f7 ff ff       	jmp    104d30 <alltraps>

0010562e <vector124>:
.globl vector124
vector124:
  pushl $0
  10562e:	6a 00                	push   $0x0
  pushl $124
  105630:	6a 7c                	push   $0x7c
  jmp alltraps
  105632:	e9 f9 f6 ff ff       	jmp    104d30 <alltraps>

00105637 <vector125>:
.globl vector125
vector125:
  pushl $0
  105637:	6a 00                	push   $0x0
  pushl $125
  105639:	6a 7d                	push   $0x7d
  jmp alltraps
  10563b:	e9 f0 f6 ff ff       	jmp    104d30 <alltraps>

00105640 <vector126>:
.globl vector126
vector126:
  pushl $0
  105640:	6a 00                	push   $0x0
  pushl $126
  105642:	6a 7e                	push   $0x7e
  jmp alltraps
  105644:	e9 e7 f6 ff ff       	jmp    104d30 <alltraps>

00105649 <vector127>:
.globl vector127
vector127:
  pushl $0
  105649:	6a 00                	push   $0x0
  pushl $127
  10564b:	6a 7f                	push   $0x7f
  jmp alltraps
  10564d:	e9 de f6 ff ff       	jmp    104d30 <alltraps>

00105652 <vector128>:
.globl vector128
vector128:
  pushl $0
  105652:	6a 00                	push   $0x0
  pushl $128
  105654:	68 80 00 00 00       	push   $0x80
  jmp alltraps
  105659:	e9 d2 f6 ff ff       	jmp    104d30 <alltraps>

0010565e <vector129>:
.globl vector129
vector129:
  pushl $0
  10565e:	6a 00                	push   $0x0
  pushl $129
  105660:	68 81 00 00 00       	push   $0x81
  jmp alltraps
  105665:	e9 c6 f6 ff ff       	jmp    104d30 <alltraps>

0010566a <vector130>:
.globl vector130
vector130:
  pushl $0
  10566a:	6a 00                	push   $0x0
  pushl $130
  10566c:	68 82 00 00 00       	push   $0x82
  jmp alltraps
  105671:	e9 ba f6 ff ff       	jmp    104d30 <alltraps>

00105676 <vector131>:
.globl vector131
vector131:
  pushl $0
  105676:	6a 00                	push   $0x0
  pushl $131
  105678:	68 83 00 00 00       	push   $0x83
  jmp alltraps
  10567d:	e9 ae f6 ff ff       	jmp    104d30 <alltraps>

00105682 <vector132>:
.globl vector132
vector132:
  pushl $0
  105682:	6a 00                	push   $0x0
  pushl $132
  105684:	68 84 00 00 00       	push   $0x84
  jmp alltraps
  105689:	e9 a2 f6 ff ff       	jmp    104d30 <alltraps>

0010568e <vector133>:
.globl vector133
vector133:
  pushl $0
  10568e:	6a 00                	push   $0x0
  pushl $133
  105690:	68 85 00 00 00       	push   $0x85
  jmp alltraps
  105695:	e9 96 f6 ff ff       	jmp    104d30 <alltraps>

0010569a <vector134>:
.globl vector134
vector134:
  pushl $0
  10569a:	6a 00                	push   $0x0
  pushl $134
  10569c:	68 86 00 00 00       	push   $0x86
  jmp alltraps
  1056a1:	e9 8a f6 ff ff       	jmp    104d30 <alltraps>

001056a6 <vector135>:
.globl vector135
vector135:
  pushl $0
  1056a6:	6a 00                	push   $0x0
  pushl $135
  1056a8:	68 87 00 00 00       	push   $0x87
  jmp alltraps
  1056ad:	e9 7e f6 ff ff       	jmp    104d30 <alltraps>

001056b2 <vector136>:
.globl vector136
vector136:
  pushl $0
  1056b2:	6a 00                	push   $0x0
  pushl $136
  1056b4:	68 88 00 00 00       	push   $0x88
  jmp alltraps
  1056b9:	e9 72 f6 ff ff       	jmp    104d30 <alltraps>

001056be <vector137>:
.globl vector137
vector137:
  pushl $0
  1056be:	6a 00                	push   $0x0
  pushl $137
  1056c0:	68 89 00 00 00       	push   $0x89
  jmp alltraps
  1056c5:	e9 66 f6 ff ff       	jmp    104d30 <alltraps>

001056ca <vector138>:
.globl vector138
vector138:
  pushl $0
  1056ca:	6a 00                	push   $0x0
  pushl $138
  1056cc:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
  1056d1:	e9 5a f6 ff ff       	jmp    104d30 <alltraps>

001056d6 <vector139>:
.globl vector139
vector139:
  pushl $0
  1056d6:	6a 00                	push   $0x0
  pushl $139
  1056d8:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
  1056dd:	e9 4e f6 ff ff       	jmp    104d30 <alltraps>

001056e2 <vector140>:
.globl vector140
vector140:
  pushl $0
  1056e2:	6a 00                	push   $0x0
  pushl $140
  1056e4:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
  1056e9:	e9 42 f6 ff ff       	jmp    104d30 <alltraps>

001056ee <vector141>:
.globl vector141
vector141:
  pushl $0
  1056ee:	6a 00                	push   $0x0
  pushl $141
  1056f0:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
  1056f5:	e9 36 f6 ff ff       	jmp    104d30 <alltraps>

001056fa <vector142>:
.globl vector142
vector142:
  pushl $0
  1056fa:	6a 00                	push   $0x0
  pushl $142
  1056fc:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
  105701:	e9 2a f6 ff ff       	jmp    104d30 <alltraps>

00105706 <vector143>:
.globl vector143
vector143:
  pushl $0
  105706:	6a 00                	push   $0x0
  pushl $143
  105708:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
  10570d:	e9 1e f6 ff ff       	jmp    104d30 <alltraps>

00105712 <vector144>:
.globl vector144
vector144:
  pushl $0
  105712:	6a 00                	push   $0x0
  pushl $144
  105714:	68 90 00 00 00       	push   $0x90
  jmp alltraps
  105719:	e9 12 f6 ff ff       	jmp    104d30 <alltraps>

0010571e <vector145>:
.globl vector145
vector145:
  pushl $0
  10571e:	6a 00                	push   $0x0
  pushl $145
  105720:	68 91 00 00 00       	push   $0x91
  jmp alltraps
  105725:	e9 06 f6 ff ff       	jmp    104d30 <alltraps>

0010572a <vector146>:
.globl vector146
vector146:
  pushl $0
  10572a:	6a 00                	push   $0x0
  pushl $146
  10572c:	68 92 00 00 00       	push   $0x92
  jmp alltraps
  105731:	e9 fa f5 ff ff       	jmp    104d30 <alltraps>

00105736 <vector147>:
.globl vector147
vector147:
  pushl $0
  105736:	6a 00                	push   $0x0
  pushl $147
  105738:	68 93 00 00 00       	push   $0x93
  jmp alltraps
  10573d:	e9 ee f5 ff ff       	jmp    104d30 <alltraps>

00105742 <vector148>:
.globl vector148
vector148:
  pushl $0
  105742:	6a 00                	push   $0x0
  pushl $148
  105744:	68 94 00 00 00       	push   $0x94
  jmp alltraps
  105749:	e9 e2 f5 ff ff       	jmp    104d30 <alltraps>

0010574e <vector149>:
.globl vector149
vector149:
  pushl $0
  10574e:	6a 00                	push   $0x0
  pushl $149
  105750:	68 95 00 00 00       	push   $0x95
  jmp alltraps
  105755:	e9 d6 f5 ff ff       	jmp    104d30 <alltraps>

0010575a <vector150>:
.globl vector150
vector150:
  pushl $0
  10575a:	6a 00                	push   $0x0
  pushl $150
  10575c:	68 96 00 00 00       	push   $0x96
  jmp alltraps
  105761:	e9 ca f5 ff ff       	jmp    104d30 <alltraps>

00105766 <vector151>:
.globl vector151
vector151:
  pushl $0
  105766:	6a 00                	push   $0x0
  pushl $151
  105768:	68 97 00 00 00       	push   $0x97
  jmp alltraps
  10576d:	e9 be f5 ff ff       	jmp    104d30 <alltraps>

00105772 <vector152>:
.globl vector152
vector152:
  pushl $0
  105772:	6a 00                	push   $0x0
  pushl $152
  105774:	68 98 00 00 00       	push   $0x98
  jmp alltraps
  105779:	e9 b2 f5 ff ff       	jmp    104d30 <alltraps>

0010577e <vector153>:
.globl vector153
vector153:
  pushl $0
  10577e:	6a 00                	push   $0x0
  pushl $153
  105780:	68 99 00 00 00       	push   $0x99
  jmp alltraps
  105785:	e9 a6 f5 ff ff       	jmp    104d30 <alltraps>

0010578a <vector154>:
.globl vector154
vector154:
  pushl $0
  10578a:	6a 00                	push   $0x0
  pushl $154
  10578c:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
  105791:	e9 9a f5 ff ff       	jmp    104d30 <alltraps>

00105796 <vector155>:
.globl vector155
vector155:
  pushl $0
  105796:	6a 00                	push   $0x0
  pushl $155
  105798:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
  10579d:	e9 8e f5 ff ff       	jmp    104d30 <alltraps>

001057a2 <vector156>:
.globl vector156
vector156:
  pushl $0
  1057a2:	6a 00                	push   $0x0
  pushl $156
  1057a4:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
  1057a9:	e9 82 f5 ff ff       	jmp    104d30 <alltraps>

001057ae <vector157>:
.globl vector157
vector157:
  pushl $0
  1057ae:	6a 00                	push   $0x0
  pushl $157
  1057b0:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
  1057b5:	e9 76 f5 ff ff       	jmp    104d30 <alltraps>

001057ba <vector158>:
.globl vector158
vector158:
  pushl $0
  1057ba:	6a 00                	push   $0x0
  pushl $158
  1057bc:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
  1057c1:	e9 6a f5 ff ff       	jmp    104d30 <alltraps>

001057c6 <vector159>:
.globl vector159
vector159:
  pushl $0
  1057c6:	6a 00                	push   $0x0
  pushl $159
  1057c8:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
  1057cd:	e9 5e f5 ff ff       	jmp    104d30 <alltraps>

001057d2 <vector160>:
.globl vector160
vector160:
  pushl $0
  1057d2:	6a 00                	push   $0x0
  pushl $160
  1057d4:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
  1057d9:	e9 52 f5 ff ff       	jmp    104d30 <alltraps>

001057de <vector161>:
.globl vector161
vector161:
  pushl $0
  1057de:	6a 00                	push   $0x0
  pushl $161
  1057e0:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
  1057e5:	e9 46 f5 ff ff       	jmp    104d30 <alltraps>

001057ea <vector162>:
.globl vector162
vector162:
  pushl $0
  1057ea:	6a 00                	push   $0x0
  pushl $162
  1057ec:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
  1057f1:	e9 3a f5 ff ff       	jmp    104d30 <alltraps>

001057f6 <vector163>:
.globl vector163
vector163:
  pushl $0
  1057f6:	6a 00                	push   $0x0
  pushl $163
  1057f8:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
  1057fd:	e9 2e f5 ff ff       	jmp    104d30 <alltraps>

00105802 <vector164>:
.globl vector164
vector164:
  pushl $0
  105802:	6a 00                	push   $0x0
  pushl $164
  105804:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
  105809:	e9 22 f5 ff ff       	jmp    104d30 <alltraps>

0010580e <vector165>:
.globl vector165
vector165:
  pushl $0
  10580e:	6a 00                	push   $0x0
  pushl $165
  105810:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
  105815:	e9 16 f5 ff ff       	jmp    104d30 <alltraps>

0010581a <vector166>:
.globl vector166
vector166:
  pushl $0
  10581a:	6a 00                	push   $0x0
  pushl $166
  10581c:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
  105821:	e9 0a f5 ff ff       	jmp    104d30 <alltraps>

00105826 <vector167>:
.globl vector167
vector167:
  pushl $0
  105826:	6a 00                	push   $0x0
  pushl $167
  105828:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
  10582d:	e9 fe f4 ff ff       	jmp    104d30 <alltraps>

00105832 <vector168>:
.globl vector168
vector168:
  pushl $0
  105832:	6a 00                	push   $0x0
  pushl $168
  105834:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
  105839:	e9 f2 f4 ff ff       	jmp    104d30 <alltraps>

0010583e <vector169>:
.globl vector169
vector169:
  pushl $0
  10583e:	6a 00                	push   $0x0
  pushl $169
  105840:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
  105845:	e9 e6 f4 ff ff       	jmp    104d30 <alltraps>

0010584a <vector170>:
.globl vector170
vector170:
  pushl $0
  10584a:	6a 00                	push   $0x0
  pushl $170
  10584c:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
  105851:	e9 da f4 ff ff       	jmp    104d30 <alltraps>

00105856 <vector171>:
.globl vector171
vector171:
  pushl $0
  105856:	6a 00                	push   $0x0
  pushl $171
  105858:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
  10585d:	e9 ce f4 ff ff       	jmp    104d30 <alltraps>

00105862 <vector172>:
.globl vector172
vector172:
  pushl $0
  105862:	6a 00                	push   $0x0
  pushl $172
  105864:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
  105869:	e9 c2 f4 ff ff       	jmp    104d30 <alltraps>

0010586e <vector173>:
.globl vector173
vector173:
  pushl $0
  10586e:	6a 00                	push   $0x0
  pushl $173
  105870:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
  105875:	e9 b6 f4 ff ff       	jmp    104d30 <alltraps>

0010587a <vector174>:
.globl vector174
vector174:
  pushl $0
  10587a:	6a 00                	push   $0x0
  pushl $174
  10587c:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
  105881:	e9 aa f4 ff ff       	jmp    104d30 <alltraps>

00105886 <vector175>:
.globl vector175
vector175:
  pushl $0
  105886:	6a 00                	push   $0x0
  pushl $175
  105888:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
  10588d:	e9 9e f4 ff ff       	jmp    104d30 <alltraps>

00105892 <vector176>:
.globl vector176
vector176:
  pushl $0
  105892:	6a 00                	push   $0x0
  pushl $176
  105894:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
  105899:	e9 92 f4 ff ff       	jmp    104d30 <alltraps>

0010589e <vector177>:
.globl vector177
vector177:
  pushl $0
  10589e:	6a 00                	push   $0x0
  pushl $177
  1058a0:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
  1058a5:	e9 86 f4 ff ff       	jmp    104d30 <alltraps>

001058aa <vector178>:
.globl vector178
vector178:
  pushl $0
  1058aa:	6a 00                	push   $0x0
  pushl $178
  1058ac:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
  1058b1:	e9 7a f4 ff ff       	jmp    104d30 <alltraps>

001058b6 <vector179>:
.globl vector179
vector179:
  pushl $0
  1058b6:	6a 00                	push   $0x0
  pushl $179
  1058b8:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
  1058bd:	e9 6e f4 ff ff       	jmp    104d30 <alltraps>

001058c2 <vector180>:
.globl vector180
vector180:
  pushl $0
  1058c2:	6a 00                	push   $0x0
  pushl $180
  1058c4:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
  1058c9:	e9 62 f4 ff ff       	jmp    104d30 <alltraps>

001058ce <vector181>:
.globl vector181
vector181:
  pushl $0
  1058ce:	6a 00                	push   $0x0
  pushl $181
  1058d0:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
  1058d5:	e9 56 f4 ff ff       	jmp    104d30 <alltraps>

001058da <vector182>:
.globl vector182
vector182:
  pushl $0
  1058da:	6a 00                	push   $0x0
  pushl $182
  1058dc:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
  1058e1:	e9 4a f4 ff ff       	jmp    104d30 <alltraps>

001058e6 <vector183>:
.globl vector183
vector183:
  pushl $0
  1058e6:	6a 00                	push   $0x0
  pushl $183
  1058e8:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
  1058ed:	e9 3e f4 ff ff       	jmp    104d30 <alltraps>

001058f2 <vector184>:
.globl vector184
vector184:
  pushl $0
  1058f2:	6a 00                	push   $0x0
  pushl $184
  1058f4:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
  1058f9:	e9 32 f4 ff ff       	jmp    104d30 <alltraps>

001058fe <vector185>:
.globl vector185
vector185:
  pushl $0
  1058fe:	6a 00                	push   $0x0
  pushl $185
  105900:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
  105905:	e9 26 f4 ff ff       	jmp    104d30 <alltraps>

0010590a <vector186>:
.globl vector186
vector186:
  pushl $0
  10590a:	6a 00                	push   $0x0
  pushl $186
  10590c:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
  105911:	e9 1a f4 ff ff       	jmp    104d30 <alltraps>

00105916 <vector187>:
.globl vector187
vector187:
  pushl $0
  105916:	6a 00                	push   $0x0
  pushl $187
  105918:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
  10591d:	e9 0e f4 ff ff       	jmp    104d30 <alltraps>

00105922 <vector188>:
.globl vector188
vector188:
  pushl $0
  105922:	6a 00                	push   $0x0
  pushl $188
  105924:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
  105929:	e9 02 f4 ff ff       	jmp    104d30 <alltraps>

0010592e <vector189>:
.globl vector189
vector189:
  pushl $0
  10592e:	6a 00                	push   $0x0
  pushl $189
  105930:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
  105935:	e9 f6 f3 ff ff       	jmp    104d30 <alltraps>

0010593a <vector190>:
.globl vector190
vector190:
  pushl $0
  10593a:	6a 00                	push   $0x0
  pushl $190
  10593c:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
  105941:	e9 ea f3 ff ff       	jmp    104d30 <alltraps>

00105946 <vector191>:
.globl vector191
vector191:
  pushl $0
  105946:	6a 00                	push   $0x0
  pushl $191
  105948:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
  10594d:	e9 de f3 ff ff       	jmp    104d30 <alltraps>

00105952 <vector192>:
.globl vector192
vector192:
  pushl $0
  105952:	6a 00                	push   $0x0
  pushl $192
  105954:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
  105959:	e9 d2 f3 ff ff       	jmp    104d30 <alltraps>

0010595e <vector193>:
.globl vector193
vector193:
  pushl $0
  10595e:	6a 00                	push   $0x0
  pushl $193
  105960:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
  105965:	e9 c6 f3 ff ff       	jmp    104d30 <alltraps>

0010596a <vector194>:
.globl vector194
vector194:
  pushl $0
  10596a:	6a 00                	push   $0x0
  pushl $194
  10596c:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
  105971:	e9 ba f3 ff ff       	jmp    104d30 <alltraps>

00105976 <vector195>:
.globl vector195
vector195:
  pushl $0
  105976:	6a 00                	push   $0x0
  pushl $195
  105978:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
  10597d:	e9 ae f3 ff ff       	jmp    104d30 <alltraps>

00105982 <vector196>:
.globl vector196
vector196:
  pushl $0
  105982:	6a 00                	push   $0x0
  pushl $196
  105984:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
  105989:	e9 a2 f3 ff ff       	jmp    104d30 <alltraps>

0010598e <vector197>:
.globl vector197
vector197:
  pushl $0
  10598e:	6a 00                	push   $0x0
  pushl $197
  105990:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
  105995:	e9 96 f3 ff ff       	jmp    104d30 <alltraps>

0010599a <vector198>:
.globl vector198
vector198:
  pushl $0
  10599a:	6a 00                	push   $0x0
  pushl $198
  10599c:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
  1059a1:	e9 8a f3 ff ff       	jmp    104d30 <alltraps>

001059a6 <vector199>:
.globl vector199
vector199:
  pushl $0
  1059a6:	6a 00                	push   $0x0
  pushl $199
  1059a8:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
  1059ad:	e9 7e f3 ff ff       	jmp    104d30 <alltraps>

001059b2 <vector200>:
.globl vector200
vector200:
  pushl $0
  1059b2:	6a 00                	push   $0x0
  pushl $200
  1059b4:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
  1059b9:	e9 72 f3 ff ff       	jmp    104d30 <alltraps>

001059be <vector201>:
.globl vector201
vector201:
  pushl $0
  1059be:	6a 00                	push   $0x0
  pushl $201
  1059c0:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
  1059c5:	e9 66 f3 ff ff       	jmp    104d30 <alltraps>

001059ca <vector202>:
.globl vector202
vector202:
  pushl $0
  1059ca:	6a 00                	push   $0x0
  pushl $202
  1059cc:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
  1059d1:	e9 5a f3 ff ff       	jmp    104d30 <alltraps>

001059d6 <vector203>:
.globl vector203
vector203:
  pushl $0
  1059d6:	6a 00                	push   $0x0
  pushl $203
  1059d8:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
  1059dd:	e9 4e f3 ff ff       	jmp    104d30 <alltraps>

001059e2 <vector204>:
.globl vector204
vector204:
  pushl $0
  1059e2:	6a 00                	push   $0x0
  pushl $204
  1059e4:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
  1059e9:	e9 42 f3 ff ff       	jmp    104d30 <alltraps>

001059ee <vector205>:
.globl vector205
vector205:
  pushl $0
  1059ee:	6a 00                	push   $0x0
  pushl $205
  1059f0:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
  1059f5:	e9 36 f3 ff ff       	jmp    104d30 <alltraps>

001059fa <vector206>:
.globl vector206
vector206:
  pushl $0
  1059fa:	6a 00                	push   $0x0
  pushl $206
  1059fc:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
  105a01:	e9 2a f3 ff ff       	jmp    104d30 <alltraps>

00105a06 <vector207>:
.globl vector207
vector207:
  pushl $0
  105a06:	6a 00                	push   $0x0
  pushl $207
  105a08:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
  105a0d:	e9 1e f3 ff ff       	jmp    104d30 <alltraps>

00105a12 <vector208>:
.globl vector208
vector208:
  pushl $0
  105a12:	6a 00                	push   $0x0
  pushl $208
  105a14:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
  105a19:	e9 12 f3 ff ff       	jmp    104d30 <alltraps>

00105a1e <vector209>:
.globl vector209
vector209:
  pushl $0
  105a1e:	6a 00                	push   $0x0
  pushl $209
  105a20:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
  105a25:	e9 06 f3 ff ff       	jmp    104d30 <alltraps>

00105a2a <vector210>:
.globl vector210
vector210:
  pushl $0
  105a2a:	6a 00                	push   $0x0
  pushl $210
  105a2c:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
  105a31:	e9 fa f2 ff ff       	jmp    104d30 <alltraps>

00105a36 <vector211>:
.globl vector211
vector211:
  pushl $0
  105a36:	6a 00                	push   $0x0
  pushl $211
  105a38:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
  105a3d:	e9 ee f2 ff ff       	jmp    104d30 <alltraps>

00105a42 <vector212>:
.globl vector212
vector212:
  pushl $0
  105a42:	6a 00                	push   $0x0
  pushl $212
  105a44:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
  105a49:	e9 e2 f2 ff ff       	jmp    104d30 <alltraps>

00105a4e <vector213>:
.globl vector213
vector213:
  pushl $0
  105a4e:	6a 00                	push   $0x0
  pushl $213
  105a50:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
  105a55:	e9 d6 f2 ff ff       	jmp    104d30 <alltraps>

00105a5a <vector214>:
.globl vector214
vector214:
  pushl $0
  105a5a:	6a 00                	push   $0x0
  pushl $214
  105a5c:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
  105a61:	e9 ca f2 ff ff       	jmp    104d30 <alltraps>

00105a66 <vector215>:
.globl vector215
vector215:
  pushl $0
  105a66:	6a 00                	push   $0x0
  pushl $215
  105a68:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
  105a6d:	e9 be f2 ff ff       	jmp    104d30 <alltraps>

00105a72 <vector216>:
.globl vector216
vector216:
  pushl $0
  105a72:	6a 00                	push   $0x0
  pushl $216
  105a74:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
  105a79:	e9 b2 f2 ff ff       	jmp    104d30 <alltraps>

00105a7e <vector217>:
.globl vector217
vector217:
  pushl $0
  105a7e:	6a 00                	push   $0x0
  pushl $217
  105a80:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
  105a85:	e9 a6 f2 ff ff       	jmp    104d30 <alltraps>

00105a8a <vector218>:
.globl vector218
vector218:
  pushl $0
  105a8a:	6a 00                	push   $0x0
  pushl $218
  105a8c:	68 da 00 00 00       	push   $0xda
  jmp alltraps
  105a91:	e9 9a f2 ff ff       	jmp    104d30 <alltraps>

00105a96 <vector219>:
.globl vector219
vector219:
  pushl $0
  105a96:	6a 00                	push   $0x0
  pushl $219
  105a98:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
  105a9d:	e9 8e f2 ff ff       	jmp    104d30 <alltraps>

00105aa2 <vector220>:
.globl vector220
vector220:
  pushl $0
  105aa2:	6a 00                	push   $0x0
  pushl $220
  105aa4:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
  105aa9:	e9 82 f2 ff ff       	jmp    104d30 <alltraps>

00105aae <vector221>:
.globl vector221
vector221:
  pushl $0
  105aae:	6a 00                	push   $0x0
  pushl $221
  105ab0:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
  105ab5:	e9 76 f2 ff ff       	jmp    104d30 <alltraps>

00105aba <vector222>:
.globl vector222
vector222:
  pushl $0
  105aba:	6a 00                	push   $0x0
  pushl $222
  105abc:	68 de 00 00 00       	push   $0xde
  jmp alltraps
  105ac1:	e9 6a f2 ff ff       	jmp    104d30 <alltraps>

00105ac6 <vector223>:
.globl vector223
vector223:
  pushl $0
  105ac6:	6a 00                	push   $0x0
  pushl $223
  105ac8:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
  105acd:	e9 5e f2 ff ff       	jmp    104d30 <alltraps>

00105ad2 <vector224>:
.globl vector224
vector224:
  pushl $0
  105ad2:	6a 00                	push   $0x0
  pushl $224
  105ad4:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
  105ad9:	e9 52 f2 ff ff       	jmp    104d30 <alltraps>

00105ade <vector225>:
.globl vector225
vector225:
  pushl $0
  105ade:	6a 00                	push   $0x0
  pushl $225
  105ae0:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
  105ae5:	e9 46 f2 ff ff       	jmp    104d30 <alltraps>

00105aea <vector226>:
.globl vector226
vector226:
  pushl $0
  105aea:	6a 00                	push   $0x0
  pushl $226
  105aec:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
  105af1:	e9 3a f2 ff ff       	jmp    104d30 <alltraps>

00105af6 <vector227>:
.globl vector227
vector227:
  pushl $0
  105af6:	6a 00                	push   $0x0
  pushl $227
  105af8:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
  105afd:	e9 2e f2 ff ff       	jmp    104d30 <alltraps>

00105b02 <vector228>:
.globl vector228
vector228:
  pushl $0
  105b02:	6a 00                	push   $0x0
  pushl $228
  105b04:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
  105b09:	e9 22 f2 ff ff       	jmp    104d30 <alltraps>

00105b0e <vector229>:
.globl vector229
vector229:
  pushl $0
  105b0e:	6a 00                	push   $0x0
  pushl $229
  105b10:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
  105b15:	e9 16 f2 ff ff       	jmp    104d30 <alltraps>

00105b1a <vector230>:
.globl vector230
vector230:
  pushl $0
  105b1a:	6a 00                	push   $0x0
  pushl $230
  105b1c:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
  105b21:	e9 0a f2 ff ff       	jmp    104d30 <alltraps>

00105b26 <vector231>:
.globl vector231
vector231:
  pushl $0
  105b26:	6a 00                	push   $0x0
  pushl $231
  105b28:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
  105b2d:	e9 fe f1 ff ff       	jmp    104d30 <alltraps>

00105b32 <vector232>:
.globl vector232
vector232:
  pushl $0
  105b32:	6a 00                	push   $0x0
  pushl $232
  105b34:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
  105b39:	e9 f2 f1 ff ff       	jmp    104d30 <alltraps>

00105b3e <vector233>:
.globl vector233
vector233:
  pushl $0
  105b3e:	6a 00                	push   $0x0
  pushl $233
  105b40:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
  105b45:	e9 e6 f1 ff ff       	jmp    104d30 <alltraps>

00105b4a <vector234>:
.globl vector234
vector234:
  pushl $0
  105b4a:	6a 00                	push   $0x0
  pushl $234
  105b4c:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
  105b51:	e9 da f1 ff ff       	jmp    104d30 <alltraps>

00105b56 <vector235>:
.globl vector235
vector235:
  pushl $0
  105b56:	6a 00                	push   $0x0
  pushl $235
  105b58:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
  105b5d:	e9 ce f1 ff ff       	jmp    104d30 <alltraps>

00105b62 <vector236>:
.globl vector236
vector236:
  pushl $0
  105b62:	6a 00                	push   $0x0
  pushl $236
  105b64:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
  105b69:	e9 c2 f1 ff ff       	jmp    104d30 <alltraps>

00105b6e <vector237>:
.globl vector237
vector237:
  pushl $0
  105b6e:	6a 00                	push   $0x0
  pushl $237
  105b70:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
  105b75:	e9 b6 f1 ff ff       	jmp    104d30 <alltraps>

00105b7a <vector238>:
.globl vector238
vector238:
  pushl $0
  105b7a:	6a 00                	push   $0x0
  pushl $238
  105b7c:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
  105b81:	e9 aa f1 ff ff       	jmp    104d30 <alltraps>

00105b86 <vector239>:
.globl vector239
vector239:
  pushl $0
  105b86:	6a 00                	push   $0x0
  pushl $239
  105b88:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
  105b8d:	e9 9e f1 ff ff       	jmp    104d30 <alltraps>

00105b92 <vector240>:
.globl vector240
vector240:
  pushl $0
  105b92:	6a 00                	push   $0x0
  pushl $240
  105b94:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
  105b99:	e9 92 f1 ff ff       	jmp    104d30 <alltraps>

00105b9e <vector241>:
.globl vector241
vector241:
  pushl $0
  105b9e:	6a 00                	push   $0x0
  pushl $241
  105ba0:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
  105ba5:	e9 86 f1 ff ff       	jmp    104d30 <alltraps>

00105baa <vector242>:
.globl vector242
vector242:
  pushl $0
  105baa:	6a 00                	push   $0x0
  pushl $242
  105bac:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
  105bb1:	e9 7a f1 ff ff       	jmp    104d30 <alltraps>

00105bb6 <vector243>:
.globl vector243
vector243:
  pushl $0
  105bb6:	6a 00                	push   $0x0
  pushl $243
  105bb8:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
  105bbd:	e9 6e f1 ff ff       	jmp    104d30 <alltraps>

00105bc2 <vector244>:
.globl vector244
vector244:
  pushl $0
  105bc2:	6a 00                	push   $0x0
  pushl $244
  105bc4:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
  105bc9:	e9 62 f1 ff ff       	jmp    104d30 <alltraps>

00105bce <vector245>:
.globl vector245
vector245:
  pushl $0
  105bce:	6a 00                	push   $0x0
  pushl $245
  105bd0:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
  105bd5:	e9 56 f1 ff ff       	jmp    104d30 <alltraps>

00105bda <vector246>:
.globl vector246
vector246:
  pushl $0
  105bda:	6a 00                	push   $0x0
  pushl $246
  105bdc:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
  105be1:	e9 4a f1 ff ff       	jmp    104d30 <alltraps>

00105be6 <vector247>:
.globl vector247
vector247:
  pushl $0
  105be6:	6a 00                	push   $0x0
  pushl $247
  105be8:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
  105bed:	e9 3e f1 ff ff       	jmp    104d30 <alltraps>

00105bf2 <vector248>:
.globl vector248
vector248:
  pushl $0
  105bf2:	6a 00                	push   $0x0
  pushl $248
  105bf4:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
  105bf9:	e9 32 f1 ff ff       	jmp    104d30 <alltraps>

00105bfe <vector249>:
.globl vector249
vector249:
  pushl $0
  105bfe:	6a 00                	push   $0x0
  pushl $249
  105c00:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
  105c05:	e9 26 f1 ff ff       	jmp    104d30 <alltraps>

00105c0a <vector250>:
.globl vector250
vector250:
  pushl $0
  105c0a:	6a 00                	push   $0x0
  pushl $250
  105c0c:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
  105c11:	e9 1a f1 ff ff       	jmp    104d30 <alltraps>

00105c16 <vector251>:
.globl vector251
vector251:
  pushl $0
  105c16:	6a 00                	push   $0x0
  pushl $251
  105c18:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
  105c1d:	e9 0e f1 ff ff       	jmp    104d30 <alltraps>

00105c22 <vector252>:
.globl vector252
vector252:
  pushl $0
  105c22:	6a 00                	push   $0x0
  pushl $252
  105c24:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
  105c29:	e9 02 f1 ff ff       	jmp    104d30 <alltraps>

00105c2e <vector253>:
.globl vector253
vector253:
  pushl $0
  105c2e:	6a 00                	push   $0x0
  pushl $253
  105c30:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
  105c35:	e9 f6 f0 ff ff       	jmp    104d30 <alltraps>

00105c3a <vector254>:
.globl vector254
vector254:
  pushl $0
  105c3a:	6a 00                	push   $0x0
  pushl $254
  105c3c:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
  105c41:	e9 ea f0 ff ff       	jmp    104d30 <alltraps>

00105c46 <vector255>:
.globl vector255
vector255:
  pushl $0
  105c46:	6a 00                	push   $0x0
  pushl $255
  105c48:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
  105c4d:	e9 de f0 ff ff       	jmp    104d30 <alltraps>
  105c52:	90                   	nop
  105c53:	90                   	nop
  105c54:	90                   	nop
  105c55:	90                   	nop
  105c56:	90                   	nop
  105c57:	90                   	nop
  105c58:	90                   	nop
  105c59:	90                   	nop
  105c5a:	90                   	nop
  105c5b:	90                   	nop
  105c5c:	90                   	nop
  105c5d:	90                   	nop
  105c5e:	90                   	nop
  105c5f:	90                   	nop

00105c60 <vmenable>:
}

// Turn on paging.
void
vmenable(void)
{
  105c60:	55                   	push   %ebp
}

static inline void
lcr3(uint val) 
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
  105c61:	a1 50 78 10 00       	mov    0x107850,%eax
  105c66:	89 e5                	mov    %esp,%ebp
  105c68:	0f 22 d8             	mov    %eax,%cr3

static inline uint
rcr0(void)
{
  uint val;
  asm volatile("movl %%cr0,%0" : "=r" (val));
  105c6b:	0f 20 c0             	mov    %cr0,%eax
}

static inline void
lcr0(uint val)
{
  asm volatile("movl %0,%%cr0" : : "r" (val));
  105c6e:	0d 00 00 00 80       	or     $0x80000000,%eax
  105c73:	0f 22 c0             	mov    %eax,%cr0

  switchkvm(); // load kpgdir into cr3
  cr0 = rcr0();
  cr0 |= CR0_PG;
  lcr0(cr0);
}
  105c76:	5d                   	pop    %ebp
  105c77:	c3                   	ret    
  105c78:	90                   	nop
  105c79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00105c80 <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm()
{
  105c80:	55                   	push   %ebp
}

static inline void
lcr3(uint val) 
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
  105c81:	a1 50 78 10 00       	mov    0x107850,%eax
  105c86:	89 e5                	mov    %esp,%ebp
  105c88:	0f 22 d8             	mov    %eax,%cr3
  lcr3(PADDR(kpgdir));   // switch to the kernel page table
}
  105c8b:	5d                   	pop    %ebp
  105c8c:	c3                   	ret    
  105c8d:	8d 76 00             	lea    0x0(%esi),%esi

00105c90 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to linear address va.  If create!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int create)
{
  105c90:	55                   	push   %ebp
  105c91:	89 e5                	mov    %esp,%ebp
  105c93:	83 ec 28             	sub    $0x28,%esp
  105c96:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  uint r;
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  105c99:	89 d3                	mov    %edx,%ebx
  105c9b:	c1 eb 16             	shr    $0x16,%ebx
  105c9e:	8d 1c 98             	lea    (%eax,%ebx,4),%ebx
// Return the address of the PTE in page table pgdir
// that corresponds to linear address va.  If create!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int create)
{
  105ca1:	89 75 fc             	mov    %esi,-0x4(%ebp)
  uint r;
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
  105ca4:	8b 33                	mov    (%ebx),%esi
  105ca6:	f7 c6 01 00 00 00    	test   $0x1,%esi
  105cac:	74 22                	je     105cd0 <walkpgdir+0x40>
    pgtab = (pte_t*) PTE_ADDR(*pde);
  105cae:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = PADDR(r) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
  105cb4:	c1 ea 0a             	shr    $0xa,%edx
  105cb7:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
  105cbd:	8d 04 16             	lea    (%esi,%edx,1),%eax
}
  105cc0:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  105cc3:	8b 75 fc             	mov    -0x4(%ebp),%esi
  105cc6:	89 ec                	mov    %ebp,%esp
  105cc8:	5d                   	pop    %ebp
  105cc9:	c3                   	ret    
  105cca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*) PTE_ADDR(*pde);
  } else if(!create || !(r = (uint) kalloc()))
  105cd0:	85 c9                	test   %ecx,%ecx
  105cd2:	75 04                	jne    105cd8 <walkpgdir+0x48>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = PADDR(r) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
  105cd4:	31 c0                	xor    %eax,%eax
  105cd6:	eb e8                	jmp    105cc0 <walkpgdir+0x30>
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*) PTE_ADDR(*pde);
  } else if(!create || !(r = (uint) kalloc()))
  105cd8:	89 55 f4             	mov    %edx,-0xc(%ebp)
  105cdb:	90                   	nop
  105cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  105ce0:	e8 6b c5 ff ff       	call   102250 <kalloc>
  105ce5:	85 c0                	test   %eax,%eax
  105ce7:	74 eb                	je     105cd4 <walkpgdir+0x44>
    return 0;
  else {
    pgtab = (pte_t*) r;
  105ce9:	89 c6                	mov    %eax,%esi
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
  105ceb:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
  105cf2:	00 
  105cf3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  105cfa:	00 
  105cfb:	89 04 24             	mov    %eax,(%esp)
  105cfe:	e8 bd de ff ff       	call   103bc0 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = PADDR(r) | PTE_P | PTE_W | PTE_U;
  105d03:	89 f0                	mov    %esi,%eax
  105d05:	83 c8 07             	or     $0x7,%eax
  105d08:	89 03                	mov    %eax,(%ebx)
  105d0a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  105d0d:	eb a5                	jmp    105cb4 <walkpgdir+0x24>
  105d0f:	90                   	nop

00105d10 <mappages>:
// Create PTEs for linear addresses starting at la that refer to
// physical addresses starting at pa. la and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *la, uint size, uint pa, int perm)
{
  105d10:	55                   	push   %ebp
  105d11:	89 e5                	mov    %esp,%ebp
  105d13:	57                   	push   %edi
  105d14:	56                   	push   %esi
  105d15:	53                   	push   %ebx
  char *a = PGROUNDDOWN(la);
  105d16:	89 d3                	mov    %edx,%ebx
  char *last = PGROUNDDOWN(la + size - 1);
  105d18:	8d 7c 0a ff          	lea    -0x1(%edx,%ecx,1),%edi
// Create PTEs for linear addresses starting at la that refer to
// physical addresses starting at pa. la and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *la, uint size, uint pa, int perm)
{
  105d1c:	83 ec 2c             	sub    $0x2c,%esp
  105d1f:	8b 75 08             	mov    0x8(%ebp),%esi
  105d22:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *a = PGROUNDDOWN(la);
  105d25:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  char *last = PGROUNDDOWN(la + size - 1);
  105d2b:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    pte_t *pte = walkpgdir(pgdir, a, 1);
    if(pte == 0)
      return 0;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
  105d31:	83 4d 0c 01          	orl    $0x1,0xc(%ebp)
  105d35:	eb 1d                	jmp    105d54 <mappages+0x44>
  105d37:	90                   	nop

  while(1){
    pte_t *pte = walkpgdir(pgdir, a, 1);
    if(pte == 0)
      return 0;
    if(*pte & PTE_P)
  105d38:	f6 00 01             	testb  $0x1,(%eax)
  105d3b:	75 48                	jne    105d85 <mappages+0x75>
      panic("remap");
    *pte = pa | perm | PTE_P;
  105d3d:	8b 55 0c             	mov    0xc(%ebp),%edx
  105d40:	09 f2                	or     %esi,%edx
    if(a == last)
  105d42:	39 fb                	cmp    %edi,%ebx
    pte_t *pte = walkpgdir(pgdir, a, 1);
    if(pte == 0)
      return 0;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
  105d44:	89 10                	mov    %edx,(%eax)
    if(a == last)
  105d46:	74 30                	je     105d78 <mappages+0x68>
      break;
    a += PGSIZE;
  105d48:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    pa += PGSIZE;
  105d4e:	81 c6 00 10 00 00    	add    $0x1000,%esi
{
  char *a = PGROUNDDOWN(la);
  char *last = PGROUNDDOWN(la + size - 1);

  while(1){
    pte_t *pte = walkpgdir(pgdir, a, 1);
  105d54:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  105d57:	b9 01 00 00 00       	mov    $0x1,%ecx
  105d5c:	89 da                	mov    %ebx,%edx
  105d5e:	e8 2d ff ff ff       	call   105c90 <walkpgdir>
    if(pte == 0)
  105d63:	85 c0                	test   %eax,%eax
  105d65:	75 d1                	jne    105d38 <mappages+0x28>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 1;
}
  105d67:	83 c4 2c             	add    $0x2c,%esp
    *pte = pa | perm | PTE_P;
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  105d6a:	31 c0                	xor    %eax,%eax
  return 1;
}
  105d6c:	5b                   	pop    %ebx
  105d6d:	5e                   	pop    %esi
  105d6e:	5f                   	pop    %edi
  105d6f:	5d                   	pop    %ebp
  105d70:	c3                   	ret    
  105d71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105d78:	83 c4 2c             	add    $0x2c,%esp
    if(pte == 0)
      return 0;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
    if(a == last)
  105d7b:	b8 01 00 00 00       	mov    $0x1,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 1;
}
  105d80:	5b                   	pop    %ebx
  105d81:	5e                   	pop    %esi
  105d82:	5f                   	pop    %edi
  105d83:	5d                   	pop    %ebp
  105d84:	c3                   	ret    
  while(1){
    pte_t *pte = walkpgdir(pgdir, a, 1);
    if(pte == 0)
      return 0;
    if(*pte & PTE_P)
      panic("remap");
  105d85:	c7 04 24 d8 6c 10 00 	movl   $0x106cd8,(%esp)
  105d8c:	e8 1f ab ff ff       	call   1008b0 <panic>
  105d91:	eb 0d                	jmp    105da0 <uva2ka>
  105d93:	90                   	nop
  105d94:	90                   	nop
  105d95:	90                   	nop
  105d96:	90                   	nop
  105d97:	90                   	nop
  105d98:	90                   	nop
  105d99:	90                   	nop
  105d9a:	90                   	nop
  105d9b:	90                   	nop
  105d9c:	90                   	nop
  105d9d:	90                   	nop
  105d9e:	90                   	nop
  105d9f:	90                   	nop

00105da0 <uva2ka>:
// maps to.  The result is also a kernel logical address,
// since the kernel maps the physical memory allocated to user
// processes directly.
char*
uva2ka(pde_t *pgdir, char *uva)
{    
  105da0:	55                   	push   %ebp
  pte_t *pte = walkpgdir(pgdir, uva, 0);
  105da1:	31 c9                	xor    %ecx,%ecx
// maps to.  The result is also a kernel logical address,
// since the kernel maps the physical memory allocated to user
// processes directly.
char*
uva2ka(pde_t *pgdir, char *uva)
{    
  105da3:	89 e5                	mov    %esp,%ebp
  105da5:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte = walkpgdir(pgdir, uva, 0);
  105da8:	8b 55 0c             	mov    0xc(%ebp),%edx
  105dab:	8b 45 08             	mov    0x8(%ebp),%eax
  105dae:	e8 dd fe ff ff       	call   105c90 <walkpgdir>
  105db3:	89 c2                	mov    %eax,%edx
  if(pte == 0) return 0;
  105db5:	31 c0                	xor    %eax,%eax
  105db7:	85 d2                	test   %edx,%edx
  105db9:	74 07                	je     105dc2 <uva2ka+0x22>
  uint pa = PTE_ADDR(*pte);
  return (char *)pa;
  105dbb:	8b 02                	mov    (%edx),%eax
  105dbd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
}
  105dc2:	c9                   	leave  
  105dc3:	c3                   	ret    
  105dc4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105dca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00105dd0 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
  105dd0:	55                   	push   %ebp
  105dd1:	89 e5                	mov    %esp,%ebp
  105dd3:	83 ec 38             	sub    $0x38,%esp
  105dd6:	8b 45 08             	mov    0x8(%ebp),%eax
  105dd9:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  105ddc:	89 75 f8             	mov    %esi,-0x8(%ebp)
  105ddf:	8b 75 10             	mov    0x10(%ebp),%esi
  105de2:	89 7d fc             	mov    %edi,-0x4(%ebp)
  105de5:	8b 7d 0c             	mov    0xc(%ebp),%edi
  105de8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *mem = kalloc();
  105deb:	e8 60 c4 ff ff       	call   102250 <kalloc>
  if (sz >= PGSIZE)
  105df0:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem = kalloc();
  105df6:	89 c3                	mov    %eax,%ebx
  if (sz >= PGSIZE)
  105df8:	77 4c                	ja     105e46 <inituvm+0x76>
    panic("inituvm: more than a page");
  memset(mem, 0, PGSIZE);
  105dfa:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
  105e01:	00 
  105e02:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  105e09:	00 
  105e0a:	89 04 24             	mov    %eax,(%esp)
  105e0d:	e8 ae dd ff ff       	call   103bc0 <memset>
  mappages(pgdir, 0, PGSIZE, PADDR(mem), PTE_W|PTE_U);
  105e12:	b9 00 10 00 00       	mov    $0x1000,%ecx
  105e17:	31 d2                	xor    %edx,%edx
  105e19:	89 1c 24             	mov    %ebx,(%esp)
  105e1c:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
  105e23:	00 
  105e24:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  105e27:	e8 e4 fe ff ff       	call   105d10 <mappages>
  memmove(mem, init, sz);
  105e2c:	89 75 10             	mov    %esi,0x10(%ebp)
}
  105e2f:	8b 75 f8             	mov    -0x8(%ebp),%esi
  char *mem = kalloc();
  if (sz >= PGSIZE)
    panic("inituvm: more than a page");
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, PADDR(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
  105e32:	89 7d 0c             	mov    %edi,0xc(%ebp)
}
  105e35:	8b 7d fc             	mov    -0x4(%ebp),%edi
  char *mem = kalloc();
  if (sz >= PGSIZE)
    panic("inituvm: more than a page");
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, PADDR(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
  105e38:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
  105e3b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  105e3e:	89 ec                	mov    %ebp,%esp
  105e40:	5d                   	pop    %ebp
  char *mem = kalloc();
  if (sz >= PGSIZE)
    panic("inituvm: more than a page");
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, PADDR(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
  105e41:	e9 fa dd ff ff       	jmp    103c40 <memmove>
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem = kalloc();
  if (sz >= PGSIZE)
    panic("inituvm: more than a page");
  105e46:	c7 04 24 de 6c 10 00 	movl   $0x106cde,(%esp)
  105e4d:	e8 5e aa ff ff       	call   1008b0 <panic>
  105e52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105e60 <setupkvm>:
}

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
  105e60:	55                   	push   %ebp
  105e61:	89 e5                	mov    %esp,%ebp
  105e63:	53                   	push   %ebx
  105e64:	83 ec 14             	sub    $0x14,%esp
  pde_t *pgdir;

  // Allocate page directory
  if(!(pgdir = (pde_t *) kalloc()))
  105e67:	e8 e4 c3 ff ff       	call   102250 <kalloc>
  105e6c:	85 c0                	test   %eax,%eax
  105e6e:	89 c3                	mov    %eax,%ebx
  105e70:	75 0e                	jne    105e80 <setupkvm+0x20>
     !mappages(pgdir, (void *)0x100000, PHYSTOP-0x100000, 0x100000, PTE_W) ||
     // Map devices such as ioapic, lapic, ...
     !mappages(pgdir, (void *)0xFE000000, 0x2000000, 0xFE000000, PTE_W))
    return 0;
  return pgdir;
}
  105e72:	89 d8                	mov    %ebx,%eax
  105e74:	83 c4 14             	add    $0x14,%esp
  105e77:	5b                   	pop    %ebx
  105e78:	5d                   	pop    %ebp
  105e79:	c3                   	ret    
  105e7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  pde_t *pgdir;

  // Allocate page directory
  if(!(pgdir = (pde_t *) kalloc()))
    return 0;
  memset(pgdir, 0, PGSIZE);
  105e80:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
  105e87:	00 
  105e88:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  105e8f:	00 
  105e90:	89 04 24             	mov    %eax,(%esp)
  105e93:	e8 28 dd ff ff       	call   103bc0 <memset>
  if(// Map IO space from 640K to 1Mbyte
     !mappages(pgdir, (void *)USERTOP, 0x60000, USERTOP, PTE_W) ||
  105e98:	b9 00 00 06 00       	mov    $0x60000,%ecx
  105e9d:	ba 00 00 0a 00       	mov    $0xa0000,%edx
  105ea2:	89 d8                	mov    %ebx,%eax
  105ea4:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  105eab:	00 
  105eac:	c7 04 24 00 00 0a 00 	movl   $0xa0000,(%esp)
  105eb3:	e8 58 fe ff ff       	call   105d10 <mappages>

  // Allocate page directory
  if(!(pgdir = (pde_t *) kalloc()))
    return 0;
  memset(pgdir, 0, PGSIZE);
  if(// Map IO space from 640K to 1Mbyte
  105eb8:	85 c0                	test   %eax,%eax
  105eba:	75 0a                	jne    105ec6 <setupkvm+0x66>
  105ebc:	31 db                	xor    %ebx,%ebx
     !mappages(pgdir, (void *)0x100000, PHYSTOP-0x100000, 0x100000, PTE_W) ||
     // Map devices such as ioapic, lapic, ...
     !mappages(pgdir, (void *)0xFE000000, 0x2000000, 0xFE000000, PTE_W))
    return 0;
  return pgdir;
}
  105ebe:	83 c4 14             	add    $0x14,%esp
  105ec1:	89 d8                	mov    %ebx,%eax
  105ec3:	5b                   	pop    %ebx
  105ec4:	5d                   	pop    %ebp
  105ec5:	c3                   	ret    
    return 0;
  memset(pgdir, 0, PGSIZE);
  if(// Map IO space from 640K to 1Mbyte
     !mappages(pgdir, (void *)USERTOP, 0x60000, USERTOP, PTE_W) ||
     // Map kernel and free memory pool
     !mappages(pgdir, (void *)0x100000, PHYSTOP-0x100000, 0x100000, PTE_W) ||
  105ec6:	b9 00 00 f0 00       	mov    $0xf00000,%ecx
  105ecb:	ba 00 00 10 00       	mov    $0x100000,%edx
  105ed0:	89 d8                	mov    %ebx,%eax
  105ed2:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  105ed9:	00 
  105eda:	c7 04 24 00 00 10 00 	movl   $0x100000,(%esp)
  105ee1:	e8 2a fe ff ff       	call   105d10 <mappages>

  // Allocate page directory
  if(!(pgdir = (pde_t *) kalloc()))
    return 0;
  memset(pgdir, 0, PGSIZE);
  if(// Map IO space from 640K to 1Mbyte
  105ee6:	85 c0                	test   %eax,%eax
  105ee8:	74 d2                	je     105ebc <setupkvm+0x5c>
     !mappages(pgdir, (void *)USERTOP, 0x60000, USERTOP, PTE_W) ||
     // Map kernel and free memory pool
     !mappages(pgdir, (void *)0x100000, PHYSTOP-0x100000, 0x100000, PTE_W) ||
     // Map devices such as ioapic, lapic, ...
     !mappages(pgdir, (void *)0xFE000000, 0x2000000, 0xFE000000, PTE_W))
  105eea:	b9 00 00 00 02       	mov    $0x2000000,%ecx
  105eef:	ba 00 00 00 fe       	mov    $0xfe000000,%edx
  105ef4:	89 d8                	mov    %ebx,%eax
  105ef6:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  105efd:	00 
  105efe:	c7 04 24 00 00 00 fe 	movl   $0xfe000000,(%esp)
  105f05:	e8 06 fe ff ff       	call   105d10 <mappages>

  // Allocate page directory
  if(!(pgdir = (pde_t *) kalloc()))
    return 0;
  memset(pgdir, 0, PGSIZE);
  if(// Map IO space from 640K to 1Mbyte
  105f0a:	85 c0                	test   %eax,%eax
  105f0c:	0f 85 60 ff ff ff    	jne    105e72 <setupkvm+0x12>
  105f12:	eb a8                	jmp    105ebc <setupkvm+0x5c>
  105f14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105f1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00105f20 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
  105f20:	55                   	push   %ebp
  105f21:	89 e5                	mov    %esp,%ebp
  105f23:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
  105f26:	e8 35 ff ff ff       	call   105e60 <setupkvm>
  105f2b:	a3 50 78 10 00       	mov    %eax,0x107850
}
  105f30:	c9                   	leave  
  105f31:	c3                   	ret    
  105f32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105f40 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  105f40:	55                   	push   %ebp
  105f41:	89 e5                	mov    %esp,%ebp
  105f43:	57                   	push   %edi
  105f44:	56                   	push   %esi
  105f45:	53                   	push   %ebx
  105f46:	83 ec 2c             	sub    $0x2c,%esp
  char *a = (char *)PGROUNDUP(newsz);
  105f49:	8b 5d 10             	mov    0x10(%ebp),%ebx
  char *last = PGROUNDDOWN(oldsz - 1);
  105f4c:	8b 75 0c             	mov    0xc(%ebp),%esi
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  105f4f:	8b 7d 08             	mov    0x8(%ebp),%edi
  char *a = (char *)PGROUNDUP(newsz);
  105f52:	81 c3 ff 0f 00 00    	add    $0xfff,%ebx
  char *last = PGROUNDDOWN(oldsz - 1);
  105f58:	83 ee 01             	sub    $0x1,%esi
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  char *a = (char *)PGROUNDUP(newsz);
  105f5b:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  char *last = PGROUNDDOWN(oldsz - 1);
  105f61:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a <= last; a += PGSIZE){
  105f67:	39 f3                	cmp    %esi,%ebx
  105f69:	77 41                	ja     105fac <deallocuvm+0x6c>
  105f6b:	90                   	nop
  105f6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pte_t *pte = walkpgdir(pgdir, a, 0);
  105f70:	31 c9                	xor    %ecx,%ecx
  105f72:	89 da                	mov    %ebx,%edx
  105f74:	89 f8                	mov    %edi,%eax
  105f76:	e8 15 fd ff ff       	call   105c90 <walkpgdir>
    if(pte && (*pte & PTE_P) != 0){
  105f7b:	85 c0                	test   %eax,%eax
  105f7d:	74 23                	je     105fa2 <deallocuvm+0x62>
  105f7f:	8b 10                	mov    (%eax),%edx
  105f81:	f6 c2 01             	test   $0x1,%dl
  105f84:	74 1c                	je     105fa2 <deallocuvm+0x62>
      uint pa = PTE_ADDR(*pte);
      if(pa == 0)
  105f86:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  105f8c:	74 3d                	je     105fcb <deallocuvm+0x8b>
        panic("kfree");
      kfree((void *) pa);
  105f8e:	89 14 24             	mov    %edx,(%esp)
  105f91:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  105f94:	e8 f7 c2 ff ff       	call   102290 <kfree>
      *pte = 0;
  105f99:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  105f9c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  char *a = (char *)PGROUNDUP(newsz);
  char *last = PGROUNDDOWN(oldsz - 1);
  for(; a <= last; a += PGSIZE){
  105fa2:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  105fa8:	39 de                	cmp    %ebx,%esi
  105faa:	73 c4                	jae    105f70 <deallocuvm+0x30>
  105fac:	8b 45 10             	mov    0x10(%ebp),%eax
  105faf:	3b 45 0c             	cmp    0xc(%ebp),%eax
  105fb2:	77 0c                	ja     105fc0 <deallocuvm+0x80>
      kfree((void *) pa);
      *pte = 0;
    }
  }
  return newsz < oldsz ? newsz : oldsz;
}
  105fb4:	83 c4 2c             	add    $0x2c,%esp
  105fb7:	5b                   	pop    %ebx
  105fb8:	5e                   	pop    %esi
  105fb9:	5f                   	pop    %edi
  105fba:	5d                   	pop    %ebp
  105fbb:	c3                   	ret    
  105fbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  char *a = (char *)PGROUNDUP(newsz);
  char *last = PGROUNDDOWN(oldsz - 1);
  for(; a <= last; a += PGSIZE){
  105fc0:	8b 45 0c             	mov    0xc(%ebp),%eax
      kfree((void *) pa);
      *pte = 0;
    }
  }
  return newsz < oldsz ? newsz : oldsz;
}
  105fc3:	83 c4 2c             	add    $0x2c,%esp
  105fc6:	5b                   	pop    %ebx
  105fc7:	5e                   	pop    %esi
  105fc8:	5f                   	pop    %edi
  105fc9:	5d                   	pop    %ebp
  105fca:	c3                   	ret    
  for(; a <= last; a += PGSIZE){
    pte_t *pte = walkpgdir(pgdir, a, 0);
    if(pte && (*pte & PTE_P) != 0){
      uint pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
  105fcb:	c7 04 24 76 66 10 00 	movl   $0x106676,(%esp)
  105fd2:	e8 d9 a8 ff ff       	call   1008b0 <panic>
  105fd7:	89 f6                	mov    %esi,%esi
  105fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105fe0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
  105fe0:	55                   	push   %ebp
  105fe1:	89 e5                	mov    %esp,%ebp
  105fe3:	56                   	push   %esi
  105fe4:	53                   	push   %ebx
  105fe5:	83 ec 10             	sub    $0x10,%esp
  105fe8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint i;

  if(!pgdir)
  105feb:	85 db                	test   %ebx,%ebx
  105fed:	74 59                	je     106048 <freevm+0x68>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, USERTOP, 0);
  105fef:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  105ff6:	00 
  105ff7:	31 f6                	xor    %esi,%esi
  105ff9:	c7 44 24 04 00 00 0a 	movl   $0xa0000,0x4(%esp)
  106000:	00 
  106001:	89 1c 24             	mov    %ebx,(%esp)
  106004:	e8 37 ff ff ff       	call   105f40 <deallocuvm>
  106009:	eb 10                	jmp    10601b <freevm+0x3b>
  10600b:	90                   	nop
  10600c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < NPDENTRIES; i++){
  106010:	83 c6 01             	add    $0x1,%esi
  106013:	81 fe 00 04 00 00    	cmp    $0x400,%esi
  106019:	74 1f                	je     10603a <freevm+0x5a>
    if(pgdir[i] & PTE_P)
  10601b:	8b 04 b3             	mov    (%ebx,%esi,4),%eax
  10601e:	a8 01                	test   $0x1,%al
  106020:	74 ee                	je     106010 <freevm+0x30>
      kfree((void *) PTE_ADDR(pgdir[i]));
  106022:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  uint i;

  if(!pgdir)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, USERTOP, 0);
  for(i = 0; i < NPDENTRIES; i++){
  106027:	83 c6 01             	add    $0x1,%esi
    if(pgdir[i] & PTE_P)
      kfree((void *) PTE_ADDR(pgdir[i]));
  10602a:	89 04 24             	mov    %eax,(%esp)
  10602d:	e8 5e c2 ff ff       	call   102290 <kfree>
  uint i;

  if(!pgdir)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, USERTOP, 0);
  for(i = 0; i < NPDENTRIES; i++){
  106032:	81 fe 00 04 00 00    	cmp    $0x400,%esi
  106038:	75 e1                	jne    10601b <freevm+0x3b>
    if(pgdir[i] & PTE_P)
      kfree((void *) PTE_ADDR(pgdir[i]));
  }
  kfree((void *) pgdir);
  10603a:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
  10603d:	83 c4 10             	add    $0x10,%esp
  106040:	5b                   	pop    %ebx
  106041:	5e                   	pop    %esi
  106042:	5d                   	pop    %ebp
  deallocuvm(pgdir, USERTOP, 0);
  for(i = 0; i < NPDENTRIES; i++){
    if(pgdir[i] & PTE_P)
      kfree((void *) PTE_ADDR(pgdir[i]));
  }
  kfree((void *) pgdir);
  106043:	e9 48 c2 ff ff       	jmp    102290 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(!pgdir)
    panic("freevm: no pgdir");
  106048:	c7 04 24 f8 6c 10 00 	movl   $0x106cf8,(%esp)
  10604f:	e8 5c a8 ff ff       	call   1008b0 <panic>
  106054:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10605a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00106060 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
  106060:	55                   	push   %ebp
  106061:	89 e5                	mov    %esp,%ebp
  106063:	57                   	push   %edi
  106064:	56                   	push   %esi
  106065:	53                   	push   %ebx
  106066:	83 ec 2c             	sub    $0x2c,%esp
  pde_t *d = setupkvm();
  106069:	e8 f2 fd ff ff       	call   105e60 <setupkvm>
  pte_t *pte;
  uint pa, i;
  char *mem;

  if(!d) return 0;
  10606e:	85 c0                	test   %eax,%eax
// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
  pde_t *d = setupkvm();
  106070:	89 c6                	mov    %eax,%esi
  pte_t *pte;
  uint pa, i;
  char *mem;

  if(!d) return 0;
  106072:	0f 84 84 00 00 00    	je     1060fc <copyuvm+0x9c>
  for(i = 0; i < sz; i += PGSIZE){
  106078:	8b 45 0c             	mov    0xc(%ebp),%eax
  10607b:	85 c0                	test   %eax,%eax
  10607d:	74 7d                	je     1060fc <copyuvm+0x9c>
  10607f:	31 db                	xor    %ebx,%ebx
  106081:	eb 47                	jmp    1060ca <copyuvm+0x6a>
  106083:	90                   	nop
  106084:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present\n");
    pa = PTE_ADDR(*pte);
    if(!(mem = kalloc()))
      goto bad;
    memmove(mem, (char *)pa, PGSIZE);
  106088:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  10608e:	89 54 24 04          	mov    %edx,0x4(%esp)
  106092:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
  106099:	00 
  10609a:	89 04 24             	mov    %eax,(%esp)
  10609d:	e8 9e db ff ff       	call   103c40 <memmove>
    if(!mappages(d, (void *)i, PGSIZE, PADDR(mem), PTE_W|PTE_U))
  1060a2:	b9 00 10 00 00       	mov    $0x1000,%ecx
  1060a7:	89 da                	mov    %ebx,%edx
  1060a9:	89 f0                	mov    %esi,%eax
  1060ab:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
  1060b2:	00 
  1060b3:	89 3c 24             	mov    %edi,(%esp)
  1060b6:	e8 55 fc ff ff       	call   105d10 <mappages>
  1060bb:	85 c0                	test   %eax,%eax
  1060bd:	74 33                	je     1060f2 <copyuvm+0x92>
  pte_t *pte;
  uint pa, i;
  char *mem;

  if(!d) return 0;
  for(i = 0; i < sz; i += PGSIZE){
  1060bf:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  1060c5:	39 5d 0c             	cmp    %ebx,0xc(%ebp)
  1060c8:	76 32                	jbe    1060fc <copyuvm+0x9c>
    if(!(pte = walkpgdir(pgdir, (void *)i, 0)))
  1060ca:	8b 45 08             	mov    0x8(%ebp),%eax
  1060cd:	31 c9                	xor    %ecx,%ecx
  1060cf:	89 da                	mov    %ebx,%edx
  1060d1:	e8 ba fb ff ff       	call   105c90 <walkpgdir>
  1060d6:	85 c0                	test   %eax,%eax
  1060d8:	74 2c                	je     106106 <copyuvm+0xa6>
      panic("copyuvm: pte should exist\n");
    if(!(*pte & PTE_P))
  1060da:	8b 10                	mov    (%eax),%edx
  1060dc:	f6 c2 01             	test   $0x1,%dl
  1060df:	74 31                	je     106112 <copyuvm+0xb2>
      panic("copyuvm: page not present\n");
    pa = PTE_ADDR(*pte);
    if(!(mem = kalloc()))
  1060e1:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  1060e4:	e8 67 c1 ff ff       	call   102250 <kalloc>
  1060e9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  1060ec:	85 c0                	test   %eax,%eax
  1060ee:	89 c7                	mov    %eax,%edi
  1060f0:	75 96                	jne    106088 <copyuvm+0x28>
      goto bad;
  }
  return d;

bad:
  freevm(d);
  1060f2:	89 34 24             	mov    %esi,(%esp)
  1060f5:	31 f6                	xor    %esi,%esi
  1060f7:	e8 e4 fe ff ff       	call   105fe0 <freevm>
  return 0;
}
  1060fc:	83 c4 2c             	add    $0x2c,%esp
  1060ff:	89 f0                	mov    %esi,%eax
  106101:	5b                   	pop    %ebx
  106102:	5e                   	pop    %esi
  106103:	5f                   	pop    %edi
  106104:	5d                   	pop    %ebp
  106105:	c3                   	ret    
  char *mem;

  if(!d) return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if(!(pte = walkpgdir(pgdir, (void *)i, 0)))
      panic("copyuvm: pte should exist\n");
  106106:	c7 04 24 09 6d 10 00 	movl   $0x106d09,(%esp)
  10610d:	e8 9e a7 ff ff       	call   1008b0 <panic>
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present\n");
  106112:	c7 04 24 24 6d 10 00 	movl   $0x106d24,(%esp)
  106119:	e8 92 a7 ff ff       	call   1008b0 <panic>
  10611e:	66 90                	xchg   %ax,%ax

00106120 <allocuvm>:
// newsz. Allocates physical memory and page table entries. oldsz and
// newsz need not be page-aligned, nor does newsz have to be larger
// than oldsz.  Returns the new process size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  106120:	55                   	push   %ebp
  if(newsz > USERTOP)
  106121:	31 c0                	xor    %eax,%eax
// newsz. Allocates physical memory and page table entries. oldsz and
// newsz need not be page-aligned, nor does newsz have to be larger
// than oldsz.  Returns the new process size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  106123:	89 e5                	mov    %esp,%ebp
  106125:	57                   	push   %edi
  106126:	56                   	push   %esi
  106127:	53                   	push   %ebx
  106128:	83 ec 2c             	sub    $0x2c,%esp
  10612b:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(newsz > USERTOP)
  10612e:	81 7d 10 00 00 0a 00 	cmpl   $0xa0000,0x10(%ebp)
  106135:	0f 87 93 00 00 00    	ja     1061ce <allocuvm+0xae>
    return 0;
  char *a = (char *)PGROUNDUP(oldsz);
  10613b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *last = PGROUNDDOWN(newsz - 1);
  10613e:	8b 75 10             	mov    0x10(%ebp),%esi
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  if(newsz > USERTOP)
    return 0;
  char *a = (char *)PGROUNDUP(oldsz);
  106141:	81 c3 ff 0f 00 00    	add    $0xfff,%ebx
  char *last = PGROUNDDOWN(newsz - 1);
  106147:	83 ee 01             	sub    $0x1,%esi
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  if(newsz > USERTOP)
    return 0;
  char *a = (char *)PGROUNDUP(oldsz);
  10614a:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  char *last = PGROUNDDOWN(newsz - 1);
  106150:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for (; a <= last; a += PGSIZE){
  106156:	39 f3                	cmp    %esi,%ebx
  106158:	76 47                	jbe    1061a1 <allocuvm+0x81>
  10615a:	eb 7c                	jmp    1061d8 <allocuvm+0xb8>
  10615c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
  106160:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
  106167:	00 
  106168:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10616f:	00 
  106170:	89 04 24             	mov    %eax,(%esp)
  106173:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  106176:	e8 45 da ff ff       	call   103bc0 <memset>
    mappages(pgdir, a, PGSIZE, PADDR(mem), PTE_W|PTE_U);
  10617b:	b9 00 10 00 00       	mov    $0x1000,%ecx
  106180:	89 f8                	mov    %edi,%eax
  106182:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
  106189:	00 
  10618a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  10618d:	89 14 24             	mov    %edx,(%esp)
  106190:	89 da                	mov    %ebx,%edx
{
  if(newsz > USERTOP)
    return 0;
  char *a = (char *)PGROUNDUP(oldsz);
  char *last = PGROUNDDOWN(newsz - 1);
  for (; a <= last; a += PGSIZE){
  106192:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    mappages(pgdir, a, PGSIZE, PADDR(mem), PTE_W|PTE_U);
  106198:	e8 73 fb ff ff       	call   105d10 <mappages>
{
  if(newsz > USERTOP)
    return 0;
  char *a = (char *)PGROUNDUP(oldsz);
  char *last = PGROUNDDOWN(newsz - 1);
  for (; a <= last; a += PGSIZE){
  10619d:	39 de                	cmp    %ebx,%esi
  10619f:	72 37                	jb     1061d8 <allocuvm+0xb8>
    char *mem = kalloc();
  1061a1:	e8 aa c0 ff ff       	call   102250 <kalloc>
    if(mem == 0){
  1061a6:	85 c0                	test   %eax,%eax
  1061a8:	75 b6                	jne    106160 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
  1061aa:	c7 04 24 3f 6d 10 00 	movl   $0x106d3f,(%esp)
  1061b1:	e8 0a a3 ff ff       	call   1004c0 <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
  1061b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1061b9:	89 44 24 08          	mov    %eax,0x8(%esp)
  1061bd:	8b 45 10             	mov    0x10(%ebp),%eax
  1061c0:	89 3c 24             	mov    %edi,(%esp)
  1061c3:	89 44 24 04          	mov    %eax,0x4(%esp)
  1061c7:	e8 74 fd ff ff       	call   105f40 <deallocuvm>
  1061cc:	31 c0                	xor    %eax,%eax
    }
    memset(mem, 0, PGSIZE);
    mappages(pgdir, a, PGSIZE, PADDR(mem), PTE_W|PTE_U);
  }
  return newsz > oldsz ? newsz : oldsz;
}
  1061ce:	83 c4 2c             	add    $0x2c,%esp
  1061d1:	5b                   	pop    %ebx
  1061d2:	5e                   	pop    %esi
  1061d3:	5f                   	pop    %edi
  1061d4:	5d                   	pop    %ebp
  1061d5:	c3                   	ret    
  1061d6:	66 90                	xchg   %ax,%ax
      return 0;
    }
    memset(mem, 0, PGSIZE);
    mappages(pgdir, a, PGSIZE, PADDR(mem), PTE_W|PTE_U);
  }
  return newsz > oldsz ? newsz : oldsz;
  1061d8:	8b 45 10             	mov    0x10(%ebp),%eax
  1061db:	3b 45 0c             	cmp    0xc(%ebp),%eax
  1061de:	73 ee                	jae    1061ce <allocuvm+0xae>
  1061e0:	8b 45 0c             	mov    0xc(%ebp),%eax
}
  1061e3:	83 c4 2c             	add    $0x2c,%esp
  1061e6:	5b                   	pop    %ebx
  1061e7:	5e                   	pop    %esi
  1061e8:	5f                   	pop    %edi
  1061e9:	5d                   	pop    %ebp
  1061ea:	c3                   	ret    
  1061eb:	90                   	nop
  1061ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001061f0 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
  1061f0:	55                   	push   %ebp
  1061f1:	89 e5                	mov    %esp,%ebp
  1061f3:	57                   	push   %edi
  1061f4:	56                   	push   %esi
  1061f5:	53                   	push   %ebx
  1061f6:	83 ec 3c             	sub    $0x3c,%esp
  1061f9:	8b 7d 0c             	mov    0xc(%ebp),%edi
  uint i, pa, n;
  pte_t *pte;

  if((uint)addr % PGSIZE != 0)
  1061fc:	f7 c7 ff 0f 00 00    	test   $0xfff,%edi
  106202:	0f 85 99 00 00 00    	jne    1062a1 <loaduvm+0xb1>
    panic("loaduvm: addr must be page aligned\n");
  106208:	8b 75 18             	mov    0x18(%ebp),%esi
  10620b:	31 db                	xor    %ebx,%ebx
  for(i = 0; i < sz; i += PGSIZE){
  10620d:	85 f6                	test   %esi,%esi
  10620f:	74 77                	je     106288 <loaduvm+0x98>
  106211:	89 7d d4             	mov    %edi,-0x2c(%ebp)
  106214:	eb 13                	jmp    106229 <loaduvm+0x39>
  106216:	66 90                	xchg   %ax,%ax
  106218:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  10621e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
  106224:	39 5d 18             	cmp    %ebx,0x18(%ebp)
  106227:	76 5f                	jbe    106288 <loaduvm+0x98>
    if(!(pte = walkpgdir(pgdir, addr+i, 0)))
  106229:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10622c:	31 c9                	xor    %ecx,%ecx
  10622e:	8b 45 08             	mov    0x8(%ebp),%eax
  106231:	01 da                	add    %ebx,%edx
  106233:	e8 58 fa ff ff       	call   105c90 <walkpgdir>
  106238:	85 c0                	test   %eax,%eax
  10623a:	74 59                	je     106295 <loaduvm+0xa5>
      panic("loaduvm: address should exist\n");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE) n = sz - i;
  10623c:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
  if((uint)addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned\n");
  for(i = 0; i < sz; i += PGSIZE){
    if(!(pte = walkpgdir(pgdir, addr+i, 0)))
      panic("loaduvm: address should exist\n");
    pa = PTE_ADDR(*pte);
  106242:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE) n = sz - i;
  106244:	ba 00 10 00 00       	mov    $0x1000,%edx
  106249:	77 02                	ja     10624d <loaduvm+0x5d>
  10624b:	89 f2                	mov    %esi,%edx
    else n = PGSIZE;
    if(readi(ip, (char *)pa, offset+i, n) != n)
  10624d:	89 54 24 0c          	mov    %edx,0xc(%esp)
  106251:	8b 7d 14             	mov    0x14(%ebp),%edi
  106254:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  106259:	89 44 24 04          	mov    %eax,0x4(%esp)
  10625d:	8d 0c 3b             	lea    (%ebx,%edi,1),%ecx
  106260:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  106264:	8b 45 10             	mov    0x10(%ebp),%eax
  106267:	89 04 24             	mov    %eax,(%esp)
  10626a:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  10626d:	e8 de b0 ff ff       	call   101350 <readi>
  106272:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  106275:	39 d0                	cmp    %edx,%eax
  106277:	74 9f                	je     106218 <loaduvm+0x28>
      return 0;
  }
  return 1;
}
  106279:	83 c4 3c             	add    $0x3c,%esp
    if(!(pte = walkpgdir(pgdir, addr+i, 0)))
      panic("loaduvm: address should exist\n");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE) n = sz - i;
    else n = PGSIZE;
    if(readi(ip, (char *)pa, offset+i, n) != n)
  10627c:	31 c0                	xor    %eax,%eax
      return 0;
  }
  return 1;
}
  10627e:	5b                   	pop    %ebx
  10627f:	5e                   	pop    %esi
  106280:	5f                   	pop    %edi
  106281:	5d                   	pop    %ebp
  106282:	c3                   	ret    
  106283:	90                   	nop
  106284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  106288:	83 c4 3c             	add    $0x3c,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint)addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned\n");
  for(i = 0; i < sz; i += PGSIZE){
  10628b:	b8 01 00 00 00       	mov    $0x1,%eax
    else n = PGSIZE;
    if(readi(ip, (char *)pa, offset+i, n) != n)
      return 0;
  }
  return 1;
}
  106290:	5b                   	pop    %ebx
  106291:	5e                   	pop    %esi
  106292:	5f                   	pop    %edi
  106293:	5d                   	pop    %ebp
  106294:	c3                   	ret    

  if((uint)addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned\n");
  for(i = 0; i < sz; i += PGSIZE){
    if(!(pte = walkpgdir(pgdir, addr+i, 0)))
      panic("loaduvm: address should exist\n");
  106295:	c7 04 24 90 6d 10 00 	movl   $0x106d90,(%esp)
  10629c:	e8 0f a6 ff ff       	call   1008b0 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint)addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned\n");
  1062a1:	c7 04 24 6c 6d 10 00 	movl   $0x106d6c,(%esp)
  1062a8:	e8 03 a6 ff ff       	call   1008b0 <panic>
  1062ad:	8d 76 00             	lea    0x0(%esi),%esi

001062b0 <switchuvm>:
}

// Switch h/w page table and TSS registers to point to process p.
void
switchuvm(struct proc *p)
{
  1062b0:	55                   	push   %ebp
  1062b1:	89 e5                	mov    %esp,%ebp
  1062b3:	53                   	push   %ebx
  1062b4:	83 ec 14             	sub    $0x14,%esp
  1062b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
  1062ba:	e8 71 d7 ff ff       	call   103a30 <pushcli>

  // Setup TSS
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
  1062bf:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  1062c5:	8d 50 08             	lea    0x8(%eax),%edx
  1062c8:	89 d1                	mov    %edx,%ecx
  1062ca:	66 89 90 a2 00 00 00 	mov    %dx,0xa2(%eax)
  1062d1:	c1 e9 10             	shr    $0x10,%ecx
  1062d4:	c1 ea 18             	shr    $0x18,%edx
  1062d7:	88 88 a4 00 00 00    	mov    %cl,0xa4(%eax)
  1062dd:	c6 80 a5 00 00 00 99 	movb   $0x99,0xa5(%eax)
  1062e4:	88 90 a7 00 00 00    	mov    %dl,0xa7(%eax)
  1062ea:	66 c7 80 a0 00 00 00 	movw   $0x67,0xa0(%eax)
  1062f1:	67 00 
  1062f3:	c6 80 a6 00 00 00 40 	movb   $0x40,0xa6(%eax)
  cpu->gdt[SEG_TSS].s = 0;
  1062fa:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  106300:	80 a0 a5 00 00 00 ef 	andb   $0xef,0xa5(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
  106307:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  10630d:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
  106313:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  106319:	8b 50 08             	mov    0x8(%eax),%edx
  10631c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  106322:	81 c2 00 10 00 00    	add    $0x1000,%edx
  106328:	89 50 0c             	mov    %edx,0xc(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
  10632b:	b8 30 00 00 00       	mov    $0x30,%eax
  106330:	0f 00 d8             	ltr    %ax
  ltr(SEG_TSS << 3);

  if(p->pgdir == 0)
  106333:	8b 43 04             	mov    0x4(%ebx),%eax
  106336:	85 c0                	test   %eax,%eax
  106338:	74 0d                	je     106347 <switchuvm+0x97>
}

static inline void
lcr3(uint val) 
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
  10633a:	0f 22 d8             	mov    %eax,%cr3
    panic("switchuvm: no pgdir\n");

  lcr3(PADDR(p->pgdir));  // switch to new address space
  popcli();
}
  10633d:	83 c4 14             	add    $0x14,%esp
  106340:	5b                   	pop    %ebx
  106341:	5d                   	pop    %ebp

  if(p->pgdir == 0)
    panic("switchuvm: no pgdir\n");

  lcr3(PADDR(p->pgdir));  // switch to new address space
  popcli();
  106342:	e9 29 d7 ff ff       	jmp    103a70 <popcli>
  cpu->ts.ss0 = SEG_KDATA << 3;
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
  ltr(SEG_TSS << 3);

  if(p->pgdir == 0)
    panic("switchuvm: no pgdir\n");
  106347:	c7 04 24 57 6d 10 00 	movl   $0x106d57,(%esp)
  10634e:	e8 5d a5 ff ff       	call   1008b0 <panic>
  106353:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  106359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00106360 <ksegment>:

// Set up CPU's kernel segment descriptors.
// Run once at boot time on each CPU.
void
ksegment(void)
{
  106360:	55                   	push   %ebp
  106361:	89 e5                	mov    %esp,%ebp
  106363:	83 ec 18             	sub    $0x18,%esp

  // Map virtual addresses to linear addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  106366:	e8 c5 c1 ff ff       	call   102530 <cpunum>
  10636b:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
  106371:	05 a0 aa 10 00       	add    $0x10aaa0,%eax
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);

  // Map cpu, and curproc
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
  106376:	8d 90 b4 00 00 00    	lea    0xb4(%eax),%edx
  10637c:	66 89 90 8a 00 00 00 	mov    %dx,0x8a(%eax)
  106383:	89 d1                	mov    %edx,%ecx
  106385:	c1 ea 18             	shr    $0x18,%edx
  106388:	88 90 8f 00 00 00    	mov    %dl,0x8f(%eax)
  10638e:	c1 e9 10             	shr    $0x10,%ecx

  lgdt(c->gdt, sizeof(c->gdt));
  106391:	8d 50 70             	lea    0x70(%eax),%edx
  // Map virtual addresses to linear addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  106394:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
  10639a:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
  1063a0:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
  1063a4:	c6 40 7d 9a          	movb   $0x9a,0x7d(%eax)
  1063a8:	c6 40 7e cf          	movb   $0xcf,0x7e(%eax)
  1063ac:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  1063b0:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
  1063b7:	ff ff 
  1063b9:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
  1063c0:	00 00 
  1063c2:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
  1063c9:	c6 80 85 00 00 00 92 	movb   $0x92,0x85(%eax)
  1063d0:	c6 80 86 00 00 00 cf 	movb   $0xcf,0x86(%eax)
  1063d7:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
  1063de:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
  1063e5:	ff ff 
  1063e7:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
  1063ee:	00 00 
  1063f0:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
  1063f7:	c6 80 95 00 00 00 fa 	movb   $0xfa,0x95(%eax)
  1063fe:	c6 80 96 00 00 00 cf 	movb   $0xcf,0x96(%eax)
  106405:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
  10640c:	66 c7 80 98 00 00 00 	movw   $0xffff,0x98(%eax)
  106413:	ff ff 
  106415:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
  10641c:	00 00 
  10641e:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
  106425:	c6 80 9d 00 00 00 f2 	movb   $0xf2,0x9d(%eax)
  10642c:	c6 80 9e 00 00 00 cf 	movb   $0xcf,0x9e(%eax)
  106433:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)

  // Map cpu, and curproc
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
  10643a:	66 c7 80 88 00 00 00 	movw   $0x0,0x88(%eax)
  106441:	00 00 
  106443:	88 88 8c 00 00 00    	mov    %cl,0x8c(%eax)
  106449:	c6 80 8d 00 00 00 92 	movb   $0x92,0x8d(%eax)
  106450:	c6 80 8e 00 00 00 c0 	movb   $0xc0,0x8e(%eax)
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  106457:	66 c7 45 f2 37 00    	movw   $0x37,-0xe(%ebp)
  pd[1] = (uint)p;
  10645d:	66 89 55 f4          	mov    %dx,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
  106461:	c1 ea 10             	shr    $0x10,%edx
  106464:	66 89 55 f6          	mov    %dx,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
  106468:	8d 55 f2             	lea    -0xe(%ebp),%edx
  10646b:	0f 01 12             	lgdtl  (%edx)
}

static inline void
loadgs(ushort v)
{
  asm volatile("movw %0, %%gs" : : "r" (v));
  10646e:	ba 18 00 00 00       	mov    $0x18,%edx
  106473:	8e ea                	mov    %edx,%gs

  lgdt(c->gdt, sizeof(c->gdt));
  loadgs(SEG_KCPU << 3);
  
  // Initialize cpu-local storage.
  cpu = c;
  106475:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
  proc = 0;
  10647b:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
  106482:	00 00 00 00 
}
  106486:	c9                   	leave  
  106487:	c3                   	ret    
