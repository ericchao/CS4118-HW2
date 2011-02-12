#include "record.h"
#define NULL (void*)0

typedef struct rnode recordnode;

struct rnode
{
	struct record *rec;
	struct rnode *next;
};

static void add_record(recordnode* rlist, struct record* re)
{
	recordnode *cur = rlist;
	while(cur->next != NULL)
	{
		cur = cur->next;
	}
	
	recordnode *newnode = (recordnode*)kalloc();
	newnode->rec = re;
	newnode->next = NULL;
	cur->next = newnode;
}

static void print_records(recordnode* rlist)
{
	recordnode *cur = rlist;

	while(cur->next != NULL)
	{
		cprintf("%s: %s", cur->rec->type, cur->rec->value);
		cur = cur->next;
	}
	cprintf("%s: %s", cur->rec->type, cur->rec->value);

}
